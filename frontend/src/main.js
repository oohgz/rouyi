import { createApp } from 'vue'
import Cookies from 'js-cookie'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import 'element-plus/theme-chalk/dark/css-vars.css'
import locale from 'element-plus/es/locale/lang/zh-cn'

import '@/assets/styles/index.scss'
import App from './App'
import router from './router'
import directive from './directive'
import plugins from './plugins'
import { download } from '@/utils/request'

// svg图标
import 'virtual:svg-icons-register'
import SvgIcon from '@/components/SvgIcon'
import elementIcons from '@/components/SvgIcon/svgicon'

import './permission'
import { useDict } from '@/utils/dict'
import { getConfigKey } from "@/api/system/config"
import { parseTime, resetForm, addDateRange, handleTree, selectDictLabel, selectDictLabels } from '@/utils/ruoyi'

// 全局组件
import Pagination from '@/components/Pagination'
import RightToolbar from '@/components/RightToolbar'
import Editor from "@/components/Editor"
import FileUpload from "@/components/FileUpload"
import ImageUpload from "@/components/ImageUpload"
import ImagePreview from "@/components/ImagePreview"
import DictTag from '@/components/DictTag'

// 🔥 关键修复：用框架默认的 Pinia，移除 Vuex 代码
import { createPinia } from 'pinia'
const pinia = createPinia() // 初始化 Pinia

// 只创建一个 App 实例
const app = createApp(App)

// 🔥 挂载 Pinia（必须在路由、组件之前）
app.use(pinia)
app.use(router)

// 其他配置不变
app.use(plugins)
app.use(elementIcons)
directive(app)

app.use(ElementPlus, {
    locale: locale,
    size: Cookies.get('size') || 'default'
})

// 全局组件挂载
app.component('DictTag', DictTag)
app.component('Pagination', Pagination)
app.component('FileUpload', FileUpload)
app.component('ImageUpload', ImageUpload)
app.component('ImagePreview', ImagePreview)
app.component('RightToolbar', RightToolbar)
app.component('Editor', Editor)
app.component('svg-icon', SvgIcon)

// 全局方法挂载
app.config.globalProperties.useDict = useDict
app.config.globalProperties.download = download
app.config.globalProperties.parseTime = parseTime
app.config.globalProperties.resetForm = resetForm
app.config.globalProperties.handleTree = handleTree
app.config.globalProperties.addDateRange = addDateRange
app.config.globalProperties.getConfigKey = getConfigKey
app.config.globalProperties.selectDictLabel = selectDictLabel
app.config.globalProperties.selectDictLabels = selectDictLabels

app.mount('#app')