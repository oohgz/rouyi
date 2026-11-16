# 权限设计说明

本项目在若依 RBAC 基础上，补充了**业务级行权限（Row-Level Security）**，目标：同一接口对不同角色返回不同数据范围，且拦截发生在服务端。

## 一、角色划分

| 角色标识 | 名称 | 数据可见范围 |
| --- | --- | --- |
| `admin` | 管理员 | 全量数据 |
| `manage` | 教务员 | 全量数据（业务操作权限略少于管理员） |
| `teacher` | 教师 | 仅本人授课课程下的学生、选课、成绩 |
| `student` | 学生 | 仅本人的选课记录与成绩 |

角色与系统用户的关联通过若依 `sys_user_role` 维护；业务侧通过 `user_id` 与 `tb_student` / `tb_teacher` 建立映射。

## 二、三层校验

### 第 1 层：角色 / 按钮级（注解）

```java
@PreAuthorize("@ss.hasPermi('manage:score:list')")
@GetMapping("/list")
public TableDataInfo list(Score score) { ... }
```

细粒度到 `manage:*:list / add / edit / remove / export / query`。

### 第 2 层：接口级归属校验

以「按课程查询学生」为例：进入查询前先判断资源归属，防止跨课程取数。

```java
// StudentController#listByCourse
List<String> roles = sysUserService.selectRoleKeysByUserId(loginUser.getUserId());
if (!roles.contains("teacher") && !roles.contains("admin") && !roles.contains("manage")) {
    return AjaxResult.error("无权限访问");
}
if (roles.contains("teacher")) {
    Teacher teacher = teacherMapper.selectTeacherByUserId(loginUser.getUserId());
    Course course = courseMapper.selectCourseById(courseId);
    if (course == null || !course.getTeacherId().equals(teacher.getId())) {
        return AjaxResult.error("无权查询该课程的学生");   // 越权拦截点
    }
}
```

### 第 3 层：数据级过滤（Service）

```java
// StudentSelectionServiceImpl#selectStudentSelectionList
if (roles.contains("student")) {
    Student student = studentMapper.selectStudentByUserId(currentUserId);
    studentSelection.setStudentId(student.getId());          // 只看自己
} else if (roles.contains("teacher")) {
    List<Course> courses = courseMapper.selectCourseList(courseQuery); // 授课课程
    if (courses.isEmpty()) {
        return Collections.emptyList();                      // 无授课 → 空集，绝不返回全量
    }
    studentSelection.setCourseIds(courses.stream().map(Course::getId).collect(Collectors.toList()));
}
```

## 三、两个易错点与处理

### 1. 条件缺失导致全量泄露

若教师没有授课课程，`courseIds` 为空集合，若直接拼 `IN ()` 或跳过条件，查询会退化为「无条件」→ 返回全量数据。

**处理**：显式判断空集并 `return Collections.emptyList()`。

### 2. 权限过滤与分页冲突

若依通过 `PageHelper.startPage()` 在 Controller 层开启分页，而角色校验需要先查一次数据库（查角色、查授课课程），这会「消耗」掉一次分页设置，导致分页失效（返回第一页数据或全量数据）。

**处理**：在权限过滤完成后，按 `pageNum / pageSize` 重新 `startPage()`：

```java
Integer pageNum = ServletUtils.getParameterToInt("pageNum");
Integer pageSize = ServletUtils.getParameterToInt("pageSize");
if (pageNum != null && pageSize != null) {
    PageHelper.startPage(pageNum, pageSize);
}
```

## 四、验证方式

越权场景的验证用例与结论见 [TEST.md](TEST.md)。
