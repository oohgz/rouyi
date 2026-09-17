package com.ruoyi.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * AI配置类
 *
 * @author ruoyi
 */
@Component
@ConfigurationProperties(prefix = "ruoyi.ai")
public class AiConfig
{
    /**
     * 是否启用AI功能
     */
    private boolean enabled = false;

    /**
     * AI模型提供商
     */
    private String provider = "mock";

    /**
     * API密钥
     */
    private String apiKey = "";

    /**
     * 模型名称
     */
    private String model = "mock-model";

    // Getter和Setter方法
    public boolean isEnabled()
    {
        return enabled;
    }

    public void setEnabled(boolean enabled)
    {
        this.enabled = enabled;
    }

    public String getProvider()
    {
        return provider;
    }

    public void setProvider(String provider)
    {
        this.provider = provider;
    }

    public String getApiKey()
    {
        return apiKey;
    }

    public void setApiKey(String apiKey)
    {
        this.apiKey = apiKey;
    }

    public String getModel()
    {
        return model;
    }

    public void setModel(String model)
    {
        this.model = model;
    }
}