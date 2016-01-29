package com.atlassian.confluence.core.actions;

import com.atlassian.config.util.BootstrapUtils;
import com.atlassian.confluence.core.ConfluenceActionSupport;
import com.atlassian.confluence.plugin.editor.Editor;
import com.atlassian.confluence.plugin.editor.EditorManager;
import com.atlassian.confluence.spaces.Space;
import com.atlassian.confluence.themes.*;
import com.atlassian.confluence.util.GeneralUtil;
import com.atlassian.confluence.util.velocity.VelocityUtils;
import com.atlassian.plugin.ModuleDescriptor;
import com.atlassian.plugin.PluginAccessor;
import com.atlassian.plugin.elements.ResourceLocation;
import com.atlassian.plugin.util.LastModifiedHandler;
import com.atlassian.spring.container.ContainerManager;
import com.opensymphony.util.TextUtils;
import com.opensymphony.webwork.ServletActionContext;
import org.apache.commons.lang.StringUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * Action to display the customised stylesheet for the site.
 *
 * <p>Both spellings. Muahaha.
 */
public class StylesheetAction extends ConfluenceActionSupport implements LastModifiedAware
{
    public static final String RESULT_SETUP = "setup";

    private ColourScheme scheme;
    private ColourSchemeManager colourSchemeManager;

    private String spaceKey;
    private String pluginCompleteKey;
    private String stylesheetName;
    private String stylesheetLocation;
    private boolean forWysiwyg;
    private EditorManager editorManager;
    private ThemeManager themeManager;
    private PluginAccessor pluginAccessor;
    private Theme theme;

    public static String renderDefaultStylesheet()
    {
        ColourSchemeManager colourSchemeManager = (ColourSchemeManager) ContainerManager.getComponent("colourSchemeManager");
        Map contextMap = new HashMap();
        contextMap.put("action", new StylesheetAction(colourSchemeManager.getGlobalColourScheme()));
        contextMap.put("generalUtil", new GeneralUtil());
        return VelocityUtils.getRenderedTemplate("styles/site-css.vm", contextMap);
    }

    public static String renderSpaceStylesheet(Space space)
    {
        if (space == null)
            return renderDefaultStylesheet();

        Map contextMap = new HashMap();
        ColourSchemeManager colourSchemeManager = (ColourSchemeManager) ContainerManager.getComponent("colourSchemeManager");
        contextMap.put("action", new StylesheetAction(colourSchemeManager.getSpaceColourScheme(space)));
        contextMap.put("generalUtil", new GeneralUtil());
        return VelocityUtils.getRenderedTemplate("styles/site-css.vm", contextMap);
    }

    /**
     * Default constructor for WebWork
     */
    public StylesheetAction()
    {
    }

    /**
     * If we want to construct it without executing it in a web
     * context
     */
    public StylesheetAction(ColourScheme colourScheme)
    {
        this.scheme = colourScheme;
    }

    public boolean isPermitted()
    {
        return true;
    }

    public String executeForWysiwyg() throws Exception
    {
        this.forWysiwyg = true;
        return execute();
    }

    public String execute() throws Exception
    {
        ServletActionContext.getResponse().setContentType("text/css");

        // initialise color scheme
        if (BootstrapUtils.getBootstrapManager().isSetupComplete())
        {
            scheme = getActiveColourScheme(spaceKey);
            theme = getActiveTheme(spaceKey);
        }
        else
        {
           scheme = DefaultColourScheme.getInstance(); //quick fix for synching up the setup with the unavailability of Spring
           return RESULT_SETUP;
        }

        if (StringUtils.isNotEmpty(pluginCompleteKey) && isModuleSeparateToTheme(pluginCompleteKey, theme))
        {
            // this isn't an old-style theme stylesheet rendering -- rather it's a plugin requesting a stylesheet resource
            ResourceLocation resource = getStylesheetResource(pluginCompleteKey, stylesheetName);
            if (resource != null)
            {
                stylesheetLocation = prependSlashIfMissing(resource.getLocation());
                return "pluginresource";
            }
            log.warn("Couldn't find matching stylesheet resource for pluginCompleteKey: [" + pluginCompleteKey + "], stylesheetName: [" + stylesheetName + "]");
            // if the resource doesn't exist, just fall through to render the default stylesheet
        }

        return SUCCESS;
    }

    private ColourScheme getActiveColourScheme(String spaceKey)
    {
        if (StringUtils.isNotEmpty(spaceKey))
        {
            return colourSchemeManager.getSpaceColourScheme(spaceKey);
        }
        return colourSchemeManager.getGlobalColourScheme();
    }

    private Theme getActiveTheme(String spaceKey)
    {
        if (StringUtils.isNotEmpty(spaceKey))
        {
            return themeManager.getSpaceTheme(spaceKey);
        }
        return themeManager.getGlobalTheme();
    }

    private boolean isModuleSeparateToTheme(String moduleCompleteKey, Theme theme)
    {
        if (StringUtils.isEmpty(moduleCompleteKey)) return false;
    	if (theme == null) return true;
    	String pluginKey = theme.getPluginKey();
    	if (pluginKey == null || pluginKey.length() == 0) {
        	log.warn("StylesheetAction.isModuleSeparateToTheme: Unknown Plugin Key");
        	return true;
    	}
    	return !moduleCompleteKey.startsWith(pluginKey);
    }

    private ResourceLocation getStylesheetResource(String moduleCompleteKey, String stylesheetName)
    {
        ModuleDescriptor module = pluginAccessor.getEnabledPluginModule(moduleCompleteKey);
        if (module == null) return null;
        return module.getResourceLocation("stylesheet", stylesheetName);
    }

    private String prependSlashIfMissing(String text)
    {
        if (text == null) return null;
        if (text.startsWith("/")) return text;
        return "/" + text;
    }

    public String getStylesheetLocation()
    {
        return stylesheetLocation;
    }

    public void setSpaceKey(String spaceKey)
    {
        this.spaceKey = spaceKey;
    }

    public String getSpaceKey()
    {
        return spaceKey;
    }

    public void setPluginCompleteKey(String pluginCompleteKey)
    {
        this.pluginCompleteKey = pluginCompleteKey;
    }

    public void setStylesheetName(String stylesheetName)
    {
        this.stylesheetName = stylesheetName;
    }

    public String getTopBarColor()
    {
        return scheme.get(ColourScheme.TOP_BAR);
    }

    public String getBreadcrumbsTextColour()
    {
        return scheme.get(ColourScheme.BREADCRUMBS_TEXT);
    }

    public String getSpaceNameColor()
    {
        return scheme.get(ColourScheme.SPACE_NAME);
    }

    public String getHeadingTextColor()
    {
        return scheme.get(ColourScheme.HEADING_TEXT);
    }

    public String getLinkColor()
    {
        return scheme.get(ColourScheme.LINK);
    }

    public String getBorderColor()
    {
        return scheme.get(ColourScheme.BORDER);
    }

    public String getNavBackgroundColor()
    {
        return scheme.get(ColourScheme.NAV_BACKGROUND);
    }

    public String getNavTextColor()
    {
        return scheme.get(ColourScheme.NAV_TEXT);
    }

    public String getNavSelectedBackgroundColor()
    {
        return scheme.get(ColourScheme.NAV_SELECTED_BACKGROUND);
    }

    public String getNavSelectedTextColor()
    {
        return scheme.get(ColourScheme.NAV_SELECTED_TEXT);
    }


    public String getCustomColor1()
    {
        return scheme.get(ColourScheme.CUSTOM_1);
    }

    public String getCustomColor2()
    {
        return scheme.get(ColourScheme.CUSTOM_2);
    }

    public String getCustomColor3()
    {
        return scheme.get(ColourScheme.CUSTOM_3);
    }

    public String getCustomColor4()
    {
        return scheme.get(ColourScheme.CUSTOM_4);
    }

    public String getCustomColor5()
    {
        return scheme.get(ColourScheme.CUSTOM_5);
    }

    public String getTopBarColour()
    {
        return scheme.get(ColourScheme.TOP_BAR);
    }

    public String getSpaceNameColour()
    {
        return scheme.get(ColourScheme.SPACE_NAME);
    }

    public String getHeadingTextColour()
    {
        return scheme.get(ColourScheme.HEADING_TEXT);
    }

    public String getLinkColour()
    {
        return scheme.get(ColourScheme.LINK);
    }

    public String getBorderColour()
    {
        return scheme.get(ColourScheme.BORDER);
    }

    public String getNavBackgroundColour()
    {
        return scheme.get(ColourScheme.NAV_BACKGROUND);
    }

    public String getNavTextColour()
    {
        return scheme.get(ColourScheme.NAV_TEXT);
    }

    public String getNavSelectedBackgroundColour()
    {
        return scheme.get(ColourScheme.NAV_SELECTED_BACKGROUND);
    }

    public String getNavSelectedTextColour()
    {
        return scheme.get(ColourScheme.NAV_SELECTED_TEXT);
    }

    public void setColourSchemeManager(ColourSchemeManager colourSchemeManager)
    {
        this.colourSchemeManager = colourSchemeManager;
    }

    public boolean isForWysiwyg()
    {
        return forWysiwyg;
    }

    public Editor getEditor()
    {
        return editorManager.getCurrentEditor();
    }

    public void setEditorManager(EditorManager editorManager)
    {
        this.editorManager = editorManager;
    }

    private static Map lastModifiedHandlers = new HashMap();

    public LastModifiedHandler getLastModifiedHandler()
    {
        return getLastModifiedHandlerForSpace(getSpaceKey());
    }

    public synchronized static LastModifiedHandler getLastModifiedHandlerForSpace(String spaceKey)
    {
        String key = "com.atlassian.confluence.core.actions.StylesheetAction." + (spaceKey == null ? "global" : spaceKey);
        LastModifiedHandler handler = (LastModifiedHandler)lastModifiedHandlers.get(key);
        if (handler == null)
        {
            handler = new LastModifiedHandler();
            lastModifiedHandlers.put(key,handler);
        }
        return handler;
    }

    public boolean isUserAgentIE()
    {
        if(ServletActionContext.getRequest() == null)
        {
            return false;
        }
        String userAgent = ServletActionContext.getRequest().getHeader("User-Agent");
        return TextUtils.stringSet(userAgent) && userAgent.indexOf("MSIE") != -1;
    }

    public void setThemeManager(ThemeManager themeManager)
    {
        this.themeManager = themeManager;
    }

    public Theme getTheme()
    {
        return theme;
    }

    public void setPluginAccessor(PluginAccessor pluginAccessor)
    {
        this.pluginAccessor = pluginAccessor;
    }
}
