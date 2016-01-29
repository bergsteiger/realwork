package com.atlassian.confluence.util;

import com.atlassian.config.ApplicationConfiguration;
import com.atlassian.config.util.BootstrapUtils;
import com.atlassian.confluence.core.*;
import com.atlassian.confluence.core.TimeZone;
import com.atlassian.confluence.languages.DefaultLocaleManager;
import com.atlassian.confluence.languages.LanguageManager;
import com.atlassian.confluence.languages.LocaleManager;
import com.atlassian.confluence.pages.AbstractPage;
import com.atlassian.confluence.security.Permission;
import com.atlassian.confluence.security.PermissionManager;
import com.atlassian.confluence.setup.BootstrapManager;
import com.atlassian.confluence.setup.ConfluenceBootstrapConstants;
import com.atlassian.confluence.setup.DefaultBootstrapManager;
import com.atlassian.confluence.setup.settings.Settings;
import com.atlassian.confluence.setup.settings.SettingsManager;
import com.atlassian.confluence.user.AuthenticatedUserThreadLocal;
import com.atlassian.confluence.user.SessionKeys;
import com.atlassian.confluence.user.UserAccessor;
import com.atlassian.confluence.user.UserPreferencesKeys;
import com.atlassian.confluence.util.i18n.I18NBeanFactory;
import com.atlassian.confluence.util.i18n.I18NBean;
import com.atlassian.confluence.util.io.IOUtils;
import com.atlassian.confluence.util.zip.FileUnzipper;
import com.atlassian.confluence.util.zip.Unzipper;
import com.atlassian.confluence.util.zip.UrlUnzipper;
import com.atlassian.core.bean.MathBean;
import com.atlassian.core.util.FileSize;
import com.atlassian.core.util.PropertyUtils;
import com.atlassian.core.util.XMLUtils;
import com.atlassian.core.util.bean.ImageInfo;
import com.atlassian.license.License;
import com.atlassian.license.LicenseManager;
import com.atlassian.license.LicenseUtils;
import com.atlassian.renderer.util.RendererUtil;
import com.atlassian.renderer.util.UrlUtil;
import com.atlassian.seraph.util.CookieUtils;
import com.atlassian.spring.container.ContainerManager;
import com.atlassian.user.User;
import com.atlassian.user.search.page.PagerUtils;
import com.atlassian.util.profiling.UtilTimerStack;
import com.atlassian.mail.MailFactory;
import com.atlassian.mail.MailException;
import com.atlassian.bonnie.search.summary.Summarizer;
import com.atlassian.bonnie.search.summary.Summary;
import com.opensymphony.util.TextUtils;
import com.opensymphony.webwork.ServletActionContext;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Category;

import javax.mail.internet.MailDateFormat;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.net.*;
import java.text.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public final class GeneralUtil
{
    private static final Category log = Category.getInstance(GeneralUtil.class);

    private static String versionNumber;
    private static Date buildDate;
    private static String buildNumber;
    private static String buildPartner;
    private static String buildExcludedLocale;
    private static Long systemStartupTime;

    private static final String EMAIL_PATTERN_STRING = "([\\w-%\\+\\.]+@[\\w-%\\.]+\\.[\\p{Alpha}]+)";

    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_PATTERN_STRING);

    private static UserAccessor userAccessor;
    private static final int HTTP_DEFAULT_PORT = 80;
    private static final int HTTPS_DEFAULT_PORT = 443;

    static
    {
        loadDefaultProperties();
        hackUrlEncoder();
    }

    /**
     * This is a truly egregious hack that allows us to modify the stock Java URLEncoder so that it won't
     * encode ~ or @ signs. Please don't do anything like this in your own code.
     */
    private static void hackUrlEncoder()
    {
        try
        {
            Field dontNeedEncodingField = URLEncoder.class.getDeclaredField("dontNeedEncoding");
            dontNeedEncodingField.setAccessible(true);
            BitSet dontNeedEncoding = (BitSet) dontNeedEncodingField.get(URLEncoder.class);
            dontNeedEncoding.set('~');
            dontNeedEncoding.set('@');
        }
        catch (Throwable t)
        {
            log.info("URLEncoder hack failed. Really nothing to worry about: " + t.getMessage(), t);
        }
    }

    private static void loadDefaultProperties()
    {
        try
        {
            InputStream in = GeneralUtil.class.getResourceAsStream("/com/atlassian/confluence/default.properties");
            Properties properties = new Properties();

            properties.load(in);
            versionNumber = properties.getProperty("version.number");
            buildDate = convertToDateWithEnglishLocale(properties.getProperty("build.date"));
            buildNumber = properties.getProperty("build.number");
            buildPartner = defaultPropertyCheck(properties.getProperty("build.partner"));
            buildExcludedLocale = defaultPropertyCheck(properties.getProperty("build.excluded.locale"));
        }
        catch (Exception e)
        {
            throw new RuntimeException("Error while trying to load the default properties!", e);
        }
    }

    /**
     * If the default value of the property is the template string, return null as value.<br/>
     * Template strings have the format @some_string@.
     *
     * @param property
     * @return String
     */
    private static String defaultPropertyCheck(String property)
    {
        if (property.startsWith("@") && property.endsWith("@"))
            return null;

        return property;
    }

    private static Date convertToDateWithEnglishLocale(String buildDateString)
    {
        if (buildDateString == null)
            throw new IllegalArgumentException("parameter buildDateString may not be null.");

        DateFormat formatter = new SimpleDateFormat(DefaultFormatSettingsManager.DEFAULT_DATE_PATTERN, Locale.ENGLISH);
        formatter.setLenient(false);

        try
        {
            return formatter.parse(buildDateString);
        }
        catch (ParseException e)
        {
            log.info("Could not parse : " + buildDateString + " : " + e, e);
            // default build date is now.
            return Calendar.getInstance(Locale.ENGLISH).getTime();
        }
    }

    /**
     * @deprecated since 2.3 use {@link com.atlassian.confluence.core.FormatSettingsManager}
     */
    private static FormatSettingsManager getFormatSettingsManager()
    {
        return (FormatSettingsManager) ContainerManager.getComponent("formatSettingsManager");
    }

    public static String getStackTrace(Throwable t)
    {
        if (t == null)
        {
            return "";
        }

        StringWriter sw = new StringWriter();

        t.printStackTrace(new PrintWriter(sw));
        return sw.toString();
    }

    /**
     * TODO: Replace with a NumberFormatter, similar to {@link DateFormatter}
     *
     * @return the number formatted a String, or <tt>null</tt> if an exception occurred.
     */
    public static String format(Number number)
    {
        String pattern = getFormatSettingsManager().getLongNumberFormat();
        if ((number instanceof Double) || (number instanceof BigDecimal) || (number instanceof Float))
            pattern = getFormatSettingsManager().getDecimalNumberFormat();

        try
        {
            DecimalFormat format = new DecimalFormat(pattern);
            return format.format(number);
        }
        catch (Exception e)
        {
            return "";
        }
    }

    /**
     * @deprecated since 2.3. Provided for pre-2.3 themes and layouts only. New themes and layouts
     * should use {@link ConfluenceActionSupport#getDateFormatter()} or
     * {@link com.atlassian.confluence.user.ConfluenceUserPreferences#getDateFormatter(FormatSettingsManager)}.
     */
    private static DateFormatter getDateFormatter()
    {
        User user = AuthenticatedUserThreadLocal.getUser();
        FormatSettingsManager formatSettingsManager = (FormatSettingsManager) ContainerManager.getComponent("formatSettingsManager");
        return userAccessor.getConfluenceUserPreferences(user).getDateFormatter(formatSettingsManager);
    }

    /**
     * @deprecated since 2.3. Provided for pre-2.3 themes and layouts only. New themes and layouts
     * should use $dateFormatter.format(Date) in the Velocity context or
     * {@link com.atlassian.confluence.user.ConfluenceUserPreferences#getDateFormatter(FormatSettingsManager)}.
     * @see DateFormatter#format(Date)
     */
    public static String format(Date date)
    {
        try
        {
            return getDateFormatter().format(date);
        }
        catch (Exception e)
        {
            return "";
        }
    }

    public static String format(String str)
    {
        return ((str != null) ? str : "");
    }

    public static String format(Object obj)
    {
        try
        {
            if (obj instanceof Number)
            {
                return format((Number) obj);
            }
            else if (obj instanceof Date)
            {
                return format((Date) obj);
            }
            else if (obj instanceof String)
            {
                return format((String) obj);
            }
            else
            {
                return obj.toString();
            }
        }
        catch (Exception e)
        {
            return "";
        }
    }

    /**
     * @deprecated since 2.3. Provided for pre-2.3 themes and layouts only. New themes and layouts
     * should use $dateFormatter.formatDateTime(Date) in the Velocity context or
     * {@link com.atlassian.confluence.user.ConfluenceUserPreferences#getDateFormatter(FormatSettingsManager)}.
     * @see DateFormatter#formatDateTime(Date)
     */
    public static String formatDateTime(Date date)
    {
        try
        {
            return getDateFormatter().formatDateTime(date);
        }
        catch (Exception e)
        {
            return "";
        }
    }

    /**
     * @deprecated since 2.3. Provided for pre-2.3 themes and layouts only. New themes and layouts
     * should use $dateFormatter.formatTime(Date) in the Velocity context or
     * {@link com.atlassian.confluence.user.ConfluenceUserPreferences#getDateFormatter(FormatSettingsManager)}.
     * @see com.atlassian.confluence.core.DateFormatter#formatTime(Date)
     */
    public static String formatTime(Date date)
    {
        try
        {
            return getDateFormatter().formatTime(date);
        }
        catch (Exception e)
        {
            return "";
        }
    }

    /**
     * @deprecated since 2.3. Provided for pre-2.3 themes and layouts only. New themes and layouts
     * should use $dateFormatter.formatBlogDate(Date) in the Velocity context or
     * {@link com.atlassian.confluence.user.ConfluenceUserPreferences#getDateFormatter(FormatSettingsManager)}.
     * @see com.atlassian.confluence.core.DateFormatter#formatBlogDate(Date)
     */
    public static String formatBlogDate(Date date)
    {
        return getDateFormatter().formatBlogDate(date);
    }

    public static Date convertMailFormatDate(String date) throws ParseException
    {
        if (!TextUtils.stringSet(date))
            return null;

        return new MailDateFormat().parse(date);
    }

    public static Character convertToCharacter(Object obj)
    {
        if (obj instanceof Character)
        {
            return (Character) obj;
        }

        try
        {
            return new Character(obj.toString().charAt(0));
        }
        catch (Exception e)
        {
            return null;
        }
    }

    public static Integer convertToInteger(Object obj)
    {
        if (obj instanceof Integer)
        {
            return (Integer) obj;
        }

        try
        {
            DecimalFormat parseFormat = new DecimalFormat(DefaultFormatSettingsManager.DEFAULT_LONG_NUMBER_PATTERN);
            return new Integer(parseFormat.parse(obj.toString()).intValue());
        }
        catch (Exception e)
        {
            return null;
        }
    }

    public static Boolean convertToBoolean(Object obj)
    {
        if (obj instanceof Boolean)
        {
            return (Boolean) obj;
        }

        try
        {
            return Boolean.valueOf(obj.toString());
        }
        catch (Exception e)
        {
            return null;
        }
    }

    public static boolean convertToBoolean(Object bool, boolean defaultValue)
    {
        Boolean boolObj = convertToBoolean(bool);
        if (boolObj == null)
        {
            return defaultValue;
        }

        return boolObj.booleanValue();
    }

    public static String convertToString(Object obj)
    {
        try
        {
            String result = obj.toString();

            if (result.equals(""))
            {
                result = null;
            }

            return result;
        }
        catch (Exception e)
        {
            return null;
        }
    }

    /**
     * A utility method to encode the given url for protocols which the
     * CompleteURLEncoder supports. To only encode HTTP form parameter/values
     * or fragments, use urlEncode() instead.
     * @param url - the entire URL to encode
     * @return encoded url
     */
    public static String completeUrlEncode(String url)
    {
        if (url == null)
        {
            return null;
        }
        
        try
        {
            return CompleteURLEncoder.encode(url, getCharacterEncoding());
        }
        catch (MalformedURLException e)
        {
            log.error("Error while trying to encode the URL!", e);
            return url;
        }
        catch (UnsupportedEncodingException e) {
            log.error("Error while trying to encode the URL!", e);
            return url;
        }
    }


    /**
     * A utility method to encode HTTP form parameter/values.
     * To encode entire URLs, use completeUrlEncode() instead.
     * @param url - part of the url to encode
     * @return encoded url
     */
    public static String urlEncode(String url)
    {
        if (url == null)
        {
            return null;
        }

        try
        {
            return URLEncoder.encode(url, getCharacterEncoding());
        }
        catch (UnsupportedEncodingException e)
        {
            log.error("Error while trying to encode the URL!", e);
            return url;
        }
    }

    public static String urlDecode(String url)
    {
        if (url == null)
        {
            return null;
        }

        try
        {
            return URLDecoder.decode(url, getCharacterEncoding());
        }
        catch (Exception e)
        {
            log.error("Error while trying to decode url" + url, e);
            return url;
        }
    }

    public static boolean shouldUrlDecode(String str)
    {
        if (str == null) return false;
        return str.matches(".*%[a-zA-Z0-9]{2}.*") || str.indexOf("+") != -1;
    }

    public static String getPageUrl(VersionHistorySummary summary)
    {
        return "/pages/viewpage.action?pageId=" + summary.getId();
    }

    public static String getPageUrl(AbstractPage page)
    {
        if (page == null || (page.getOriginalVersion() == null && page.getSpace() == null))
            return "";
        return "/pages/viewpage.action?pageId=" + page.getId();
    }

    /**
     * Is "title" something we can safely put in a /foo/bar/title URL? Or should we reference this thing by ID
     * just to be safe?
     */
    public static boolean isSafeTitleForUrl(String title)
    {
        return TextUtils.stringSet(title) && title.length() < 150 && isAllAscii(title) && !hasFormattingCharacters(title) && title.indexOf("\"") == -1;
    }

    private static boolean hasFormattingCharacters(String text)
    {
        if (!TextUtils.stringSet(text))
            return false;

        // CONF-8860
        if (".".equals(text))
            return true;

        String[] illegalChars = {"+", "?", "%", "&"};

        for (int i = 0; i < illegalChars.length; i++)
        {
            String illegalChar = illegalChars[i];
            if (text.indexOf(illegalChar) != -1)
                return true;
        }

        return false;
    }

    /**
     * This method is only ever called when we know that the page title consists of
     * ASCII characters, so we only need to single-encode it, not double-encode.
     */
    private static String toDisplayUrl(AbstractPage page)
    {
        StringBuffer displayUrl = new StringBuffer("/display/");
        displayUrl.append(GeneralUtil.urlEncode(page.getSpace().getKey()));
        displayUrl.append("/");
        if ("blogpost".equals(page.getType()))
        {
            if (page.getCreationDate() != null) //Why shouldn't a blog have any creation date? It happens in my case... Maybe a bug or so!
            {
                displayUrl.append(new SimpleDateFormat("yyyy/MM/dd").format(page.getCreationDate()));
                displayUrl.append("/");
            }
        }

        displayUrl.append(urlEncode(page.getTitle()));
        return displayUrl.toString();
    }

    /**
     * Need a special case of generalutils getpageurl that appends ? or ampersand smartly
     * this is used to prefix url parameters that are appended after this path like:
     * showcomments=true#addcomment
     */
    public static String customGetPageUrl(AbstractPage page)
    {
        String pageUrl = GeneralUtil.getPageUrl(page);
        return appendAmpsandOrQuestionMark(pageUrl);
    }

    public static String appendAmpsandOrQuestionMark(String str)
    {
        if (!TextUtils.stringSet(str))
            return str;

        if (str.indexOf("?") != -1)
            return str + "&";
        else
            return str + "?";
    }

    /**
     * For really long strings that have no spaces or line breaks, browsers such as firefox, Netscape, have difficulty
     * wrapping them inside a table cell, and so these strings end up stretching the cell longer than its suppose to be = ugly
     * <p/>
     * we want to simulate IE's word-wrap/break function here
     *
     * @param str
     * @param max - max length of string allowed per line
     */
    public static String wordWrap(String str, int max)
    {
        if (!TextUtils.stringSet(str))
            return str;

        StringBuffer sb = new StringBuffer(str);

        int nonSpaceChars = 0;
        for (int i = 0; i < sb.length(); i++)
        {
            if (Character.isWhitespace(sb.charAt(i)))
                nonSpaceChars = 0;
            else
                nonSpaceChars++;

            if (nonSpaceChars > max)
            {
                nonSpaceChars = 0;
                sb.insert(i, " ");
                i++;
            }
        }

        return sb.toString().trim();
    }

    public static String highlight(String content, String searchwords)
    {
        if (!TextUtils.stringSet(content) || !TextUtils.stringSet(searchwords))
            return content;

        StringTokenizer st = new StringTokenizer(searchwords, ", ");
        while (st.hasMoreTokens())
        {
            String token = st.nextToken();

            if (!token.equalsIgnoreCase("span") && !token.equalsIgnoreCase("class") && !token.equalsIgnoreCase("search") && !token.equalsIgnoreCase("highlight"))
            {
                content = Pattern.compile("(" + token + ")", Pattern.CASE_INSENSITIVE).matcher(content).replaceAll("<span class=\"search-highlight\">$0</span>");
            }
        }

        return content;
    }

    public static String doubleUrlEncode(String s)
    {
        return urlEncode(urlEncode(s));
    }

    public static boolean isAllAscii(String s)
    {
        char[] sChars = s.toCharArray();

        for (int i = 0; i < sChars.length; i++)
        {
            char sChar = sChars[i];
            if (sChar > 127)
                return false;
        }

        return true;
    }

    public static boolean isAllLettersOrNumbers(String s)
    {
        char[] sChars = s.toCharArray();

        for (int i = 0; i < sChars.length; i++)
        {
            char sChar = sChars[i];
            if (!Character.isLetterOrDigit(sChar))
                return false;
        }

        return true;
    }

    public static String getVersionNumber()
    {
        return versionNumber;
    }

    public static Date getBuildDate()
    {
        return buildDate;
    }

    public static String getBuildDateString()
    {
        DateFormat format = new SimpleDateFormat(DefaultFormatSettingsManager.DEFAULT_DATE_PATTERN);
        format.setTimeZone(TimeZone.getDefault().getWrappedTimeZone());
        return format.format(buildDate);
    }

    public static String getBuildNumber()
    {
        return buildNumber;
    }

    public static String getBuildPartner()
    {
        return buildPartner;
    }

    public static String getBuildExcludedLocale()
    {
        return buildExcludedLocale;
    }

    public static Long getSystemStartupTime()
    {
        return systemStartupTime;
    }

    public static void setSystemStartupTime(Long systemStartupTime)
    {
        GeneralUtil.systemStartupTime = systemStartupTime;
    }

    // buildDate is set by the maven tasks used to build the application
    // hence when the application is compiled and run inside IDEA, buildDate is null
    public static boolean isLicenseExpired()
    {
        if (buildDate == null)// Why should we have NULL build date ?! Well, in test units, it's NULL! So a workaround for the test units not to fail.
        {
            return false;
        }

        License license = LicenseManager.getInstance().getLicense(ConfluenceBootstrapConstants.DEFAULT_LICENSE_REGISTRY_KEY);

        // if this is a evaluation license with an expiration date, then check for expiry
        // else if a commercial license, then there's no concept of license expiry
        Date expiryDate = license.getExpiryDate();
        if (expiryDate != null)
            return (new Date().after(expiryDate));
        else
            return false;
    }

    // Return an i18n'ized error message if invalid license/installation detected
    public static String checkPartnerDetails(License license, String buildPartnerName)
    {
        if (license == null)
        {
            return ConfluenceActionSupport.getTextStatic("error.license.not.valid");
        }

        String partnerErrorCode = LicenseUtils.isPartnerDetailsValid(license, buildPartnerName);

        if (partnerErrorCode.equals(LicenseUtils.PARTNER_NOT_MATCHING_BUILD))
        {
            return ConfluenceActionSupport.getTextStatic("license.error.invalidlicensekey.regional.license", new String[]{license.getPartnerName()});
        }
        else if (partnerErrorCode.equals(LicenseUtils.LICENSE_NO_PARTNER))
        {
            return ConfluenceActionSupport.getTextStatic("license.error.invalidlicensekey.regional.installation", new String[]{buildPartnerName});
        }
        return null;
    }

    /**
     * Check if the current installation has more active users than is allowed by the license
     *
     * @return true if the number exceeds the license, false otherwise.
     */
    public static boolean hasTooManyUsers()
    {
        if (!ContainerManager.isContainerSetup())
            return false;

        // Grab the license
        License license = LicenseManager.getInstance().getLicense(ConfluenceBootstrapConstants.DEFAULT_LICENSE_REGISTRY_KEY);

        // Get all users in the system
        UserAccessor accessor = (UserAccessor) ContainerManager.getComponent("userAccessor");
        List activeUsers = PagerUtils.toList(accessor.getUsersWithConfluenceAccess()); //this will bottleneck but will do for the timebeing n.f.
        int activeUsersCount = activeUsers.size();

        // If it's null, then something's gone wrong, and we should fail the license check
        if (license == null)
            return true;

        return activeUsersCount > license.getUsers();
    }

    public static boolean stringSet(String str)
    {
        return (str != null && str.length() > 0);
    }

    public static String formatLongTime(long time)
    {
        StringBuffer result = new StringBuffer();
        if (time > 3600000)
        {
            time = scaleTime(time, 3600000, result);
            result.append(":");
        }
        time = scaleTime(time, 60000, result);
        result.append(":");
        time = scaleTime(time, 1000, result);
        result.append(".").append(time);

        return result.toString();
    }

    private static long scaleTime(long time, long scale, StringBuffer buf)
    {
        long report = time / scale;
        time -= report * scale;
        String result = Long.toString(report);
        if (report < 10)
        {
            result = "0" + result;
        }
        buf.append(result);
        return time;
    }

    public static String displayShortUrl(String url)
    {
        return displayShortUrl(url, 32);
    }

    public static String displayShortUrl(String url, int length)
    {
        if (!TextUtils.stringSet(url))
            return "";

        if (UrlUtil.startsWithUrl(url))
        {
            if (url.startsWith("http://"))
                url = url.substring(7);

            int indexOfGoogle = url.indexOf(".google.");
            int indexOfQuery = url.indexOf("q=");
            if (indexOfGoogle >= 0 && indexOfQuery >= 0)
                url = extractGoogleUrl(url, indexOfQuery);
        }

        if (url.length() < length)
            return url;
        else
            return url.substring(0, length - 3) + "...";
    }

    public static String formatDateFull(Date date)
    {
        return DateFormat.getDateInstance(DateFormat.FULL).format(date);
    }

    public static boolean isSuperUser(User user)
    {
        return (user != null && getUserAccessor().hasMembership(UserAccessor.GROUP_CONFLUENCE_ADMINS, user.getName()) &&
                !getUserAccessor().getPropertySet(user).getBoolean(UserPreferencesKeys.PROPERTY_USER_DEACTIVATED));
    }

    public static String getCharacterEncoding()
    {
        if (getGlobalSettings() == null)
            return "UTF-8";
        else
            return getGlobalSettings().getDefaultEncoding();
    }

    public static String escapeXml(String stringToEscape)
    {
        return XMLUtils.escape(stringToEscape);
    }

    /**
     * Escapes ', " and \ with a leading \.
     */
    public static String escapeForJavascript(String s)
    {
        if (s == null)
            return s;
        s = s.replaceAll("\\\\", "\\\\\\\\");
        s = s.replaceAll("\\\'", "\\\\\\\'");
        s = s.replaceAll("\\\"", "\\\\\\\"");
        return s;
    }

    public static boolean isSetupComplete()
    {
        return BootstrapUtils.getBootstrapManager().isSetupComplete();
    }

    /**
     * If configured, masks an email address to defeat the most simplistic spam bots. If
     * Confluence is not configured to mask email addresses, just returns the original
     * address.
     * <p/>
     * Passing in null to this method will just get you null back
     *
     * @param emailAddress the email address to mask
     * @return the masked email address, or the original address if masking is not configured
     */
    public static String maskEmail(String emailAddress)
    {
        if (emailAddress == null || Settings.EMAIL_ADDRESS_PUBLIC.equals(getGlobalSettings().getEmailAddressVisibility()))
            return emailAddress;

        if (Settings.EMAIL_ADDRESS_PRIVATE.equals(getGlobalSettings().getEmailAddressVisibility()))
            return "hidden";

        return alwaysMaskEmail(emailAddress);
    }

    /**
     * Masks an email address by replacing '@' with 'at' and '.' with 'dot'.
     *
     * @param emailAddress an email address to mask, eg dwillis@atlassian.com
     * @return a masked version of the email, eg dwillis at atlassian dot com
     */
    public static String alwaysMaskEmail(String emailAddress)
    {
        StringBuffer buf = new StringBuffer(emailAddress.length() + 20);

        for (int i = 0; i < emailAddress.length(); i++)
        {
            char c = emailAddress.charAt(i);
            if (c == '.')
                buf.append(" dot ");
            else if (c == '@')
                buf.append(" at ");
            else
                buf.append(c);
        }

        return buf.toString();
    }

    public static String findAndMaskEmail(String text, User currentUser)
    {
        if (currentUser != null && userAccessor.hasMembership("confluence-administrators", currentUser.getName()))
            return text;

        if (!TextUtils.stringSet(text) || Settings.EMAIL_ADDRESS_PUBLIC.equals(getGlobalSettings().getEmailAddressVisibility()))
            return text;

        Matcher matcher = EMAIL_PATTERN.matcher(text);

        StringBuffer sb = new StringBuffer();
        while (matcher.find())
        {
            matcher.appendReplacement(sb, maskEmail(matcher.group(0)));
        }

        if (sb.length() == 0)
        {
            return text;
        }
        else
        {
            matcher.appendTail(sb);
            return (sb.toString());
        }
    }

    public static String escapeCDATA(String s)
    {
        if (s.indexOf("]]") < 0)
            return s;

        return s.replaceAll("\\]\\]", "]] ");
    }

    public static String unescapeCDATA(String s)
    {
        if (s.indexOf("]] ") < 0)
            return s;

        return s.replaceAll("\\]\\] ", "]]");
    }

    public static File createTempDirectoryInConfluenceTemp(String prefix)
    {
        Date date = new Date();
        String pattern = "_{0,date,MMddyyyy}_{1,time,HHmmss}";
        String uniqueRandomFileName = MessageFormat.format(pattern, new Object[]{date, date});

        return new File(BootstrapUtils.getBootstrapManager().getFilePathProperty(ConfluenceBootstrapConstants.TEMP_DIR_PROP),
                prefix + uniqueRandomFileName);
    }

    public static File createTempFile(String directory)
    {
        Date date = new Date();
        String pattern = "_{0,date,MMddyyyy}_{1,time,HHmmss}";
        String uniqueRandomFileName = MessageFormat.format(pattern, new Object[]{date, date});

        return new File(directory, uniqueRandomFileName);
    }

    // The unescape() method provided by Radeox was falling over, so we use this instead.
    public static String unescapeEntities(String str)
    {
        Pattern hexEntityPattern = Pattern.compile("&([a-fA-F0-9]+);");
        Pattern decimalEntityPattern = Pattern.compile("&#([0-9]+);");

        str = replaceNumericEntities(str, hexEntityPattern, 16);
        return replaceNumericEntities(str, decimalEntityPattern, 10);
    }

    private static String replaceNumericEntities(String str, Pattern pattern, int base)
    {
        Matcher matcher = pattern.matcher(str);
        StringBuffer buf = new StringBuffer(str.length());
        while (matcher.find())
        {
            matcher.appendReplacement(buf, Character.toString((char) Integer.parseInt(matcher.group(1), base)));
        }

        matcher.appendTail(buf);
        return buf.toString();
    }

    public static String base64Decode(String s)
    {
        try
        {
            final String s1 = s.replaceAll("_", "/");
            final String s2 = s1.replaceAll("-", "+");
            final byte[] sBytes = s2.getBytes();
            return new String(Base64.decodeBase64(sBytes), Settings.DEFAULT_DEFAULT_ENCODING);
        }
        catch (UnsupportedEncodingException e)
        {
            log.error("This Java installation doesn't support UTF-8. Call Mulder");
            return s;
        }
    }

    public static String base64Encode(String s)
    {
        final byte[] sBytes;
        try
        {
            sBytes = s.getBytes(Settings.DEFAULT_DEFAULT_ENCODING);
            return new String(Base64.encodeBase64(sBytes)).replaceAll("\\n", "").replaceAll("/", "_").replaceAll("\\+", "-").trim(); // need to remove \n which is inserted by the base 64 encoder on whim :)
        }
        catch (UnsupportedEncodingException e)
        {
            log.error("This Java installation doesn't support UTF-8. Call Mulder");
            return s;
        }
    }

    /**
     * hack to make strings that contain singles compatible with javascript (which also uses single quotes denote strings)
     *
     * @param s
     */
    public static String hackSingleQuotes(String s)
    {
        if (TextUtils.stringSet(s))
            return s.replaceAll("'", "' + '\\\\\'' + '");

        return s;
    }

    /**
     * @param date    the date to check
     * @param maxDays the number of days into the past the date can fall
     * @return Whether whether the date falls within maxDays before the present.
     */
    public static boolean isInLastDays(Date date, int maxDays)
    {
        if (date == null)
            return false;

        long tstamp = date.getTime();
        long t0 = System.currentTimeMillis();
        long dt = t0 - tstamp;

        long secs = dt / 1000;
        long mins = secs / 60;
        long hours = mins / 60;
        long days = hours / 24;
        return (days < maxDays);
    }

    /**
     * @return A relative time period, 'X hours, Y minutes
     *         ago'
     */
    public static String getRelativeTime(Date date)
    {
        if (date == null)
            return "No timestamp.";

        long tstamp = date.getTime();
        long t0 = System.currentTimeMillis();
        long dt = t0 - tstamp;

        long secs = dt / 1000;
        long mins = secs / 60;
        long hours = mins / 60;
        long days = hours / 24;

        //if (days != 0) return days + " day" + (days == 1 ? " " : "s ") + " ago";

        if (days != 0)
        {
            if (days == 1)
                return ConfluenceActionSupport.getTextStatic("one.day.ago");
            else
                return ConfluenceActionSupport.getTextStatic("x.days.ago", new Object []{"" + days});
        }

        hours -= days * 24;

        //if (hours != 0) return hours + " hour" + (hours == 1 ? " " : "s ") + "ago";

        if (hours != 0)
        {
            if (hours == 1)
                return ConfluenceActionSupport.getTextStatic("one.hour.ago");
            else
                return ConfluenceActionSupport.getTextStatic("x.hours.ago", new Object[]{"" + hours});
        }

        mins -= (days * 24 + hours) * 60;

        //if (mins != 0) return mins + " min" + (mins == 1 ? " " : "s ") + "ago";
        if (mins != 0)
        {
            if (mins == 1)
                return ConfluenceActionSupport.getTextStatic("one.min.ago");
            else
                return ConfluenceActionSupport.getTextStatic("x.mins.ago", new Object[]{"" + mins});
        }

        return ConfluenceActionSupport.getTextStatic("less.than.one.min");
    }

    public static String getFormatDateSimple(Date date)
    {
        DateFormat df = new SimpleDateFormat("dd MMM");
        return df.format(date);
    }

    /**
     * Sets a cookie. set to use a default cookie age of one year and the context path as the default path
     *
     * @param key
     * @param value
     */
    public static Cookie setCookie(String key, String value)
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        int cookieAge = 360 * 24 * 60 * 60;

        String path = request.getContextPath();
        if (!TextUtils.stringSet(path))
            path = "/";

        return CookieUtils.setCookie(request, response, key, value, cookieAge, path);
    }

    public static String getCookieValue(String key)
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        return CookieUtils.getCookieValue(request, key);
    }

    /**
     * our own htmlEncode() ripped from the TextUtils class.
     * this version does NOT escape ugly characters (read their comments)
     *
     * @param s
     */
    public static String htmlEncode(String s)
    {
        if (!TextUtils.stringSet(s))
            return "";

        StringBuffer str = new StringBuffer();

        for (int j = 0; j < s.length(); j++)
        {
            char c = s.charAt(j);

            // encode standard ASCII characters into HTML entities where needed
            if (c < '\200')
            {
                switch (c)
                {
                    case '\'':
                            str.append("&#39;"); // was &apos; CONF-6494

                        break;

                    case '"':
                        str.append("&quot;");

                        break;

                    case '&':
                        str.append("&amp;");

                        break;

                    case '<':
                        str.append("&lt;");

                        break;

                    case '>':
                        str.append("&gt;");

                        break;

                    default:
                        str.append(c);
                }
            }
            //add other characters back in - to handle charactersets
            //other than ascii
            else
            {
                str.append(c);
            }
        }

        return str.toString();
    }

    /**
     * @deprecated since 2.0 use {@link PermissionManager} directly, or use the $permissionHelper from velocity
     */
    public static boolean isGlobalAdministrator(Object notUsedAnyMore, User user)
    {
        log.info("Template uses deprecated GeneralUtil.isGlobalAdministrator. Replace with $permissionHelper.isGlobalAdministrator");
        return isSuperUser(user) || ((PermissionManager) ContainerManager.getComponent("permissionManager")).hasPermission(user, Permission.ADMINISTER, PermissionManager.TARGET_APPLICATION);
    }

    /**
     * The function converts plain text into html in two steps.
     * 1. utilize the oscore plain2html function to turn the plain text into html
     * including converting linebreaks and special characters.
     * 2. finds occurences of multiple spaces and replaces them with &nbsp html entities.
     *
     * @param text
     * @return String converted to html
     */
    public static String plain2html(String text)
    {
        text = TextUtils.plainTextToHtml(text);

        Pattern p = Pattern.compile("\\s{2,}");
        Matcher m = p.matcher(text);

        StringBuffer buf = new StringBuffer();
        while (m.find())
        {
            int numberOfSpaces = m.group(0).length();
            String spaces = " ";
            for (int i = 1; i < numberOfSpaces; i++)
                spaces = spaces.concat("&nbsp;");
            m.appendReplacement(buf, spaces);
        }
        m.appendTail(buf);
        return buf.toString();
    }

    /**
     * @deprecated since 2.3 use {@link PropertyUtils#getProperties(String, Class)} instead
     */
    public static Properties getProperties(String resource, Class callingClass)
    {
        return PropertyUtils.getProperties(resource, callingClass);
    }

    /**
     * @deprecated since 2.3 use {@link PropertyUtils#getProperties(String, Class)} instead
     */
    public static Properties getPropertiesFromFile(File file)
    {
        return PropertyUtils.getPropertiesFromFile(file);
    }

    /**
     * @deprecated since 2.3 use {@link PropertyUtils#getProperties(String, Class)} instead
     */
    public static Properties getPropertiesFromStream(InputStream is)
    {
        return PropertyUtils.getPropertiesFromStream(is);
    }

    /**
     * Unzips the zip file to a folder in temp and returns the File pointing to that expanded folder.
     */
    public static void unzipFile(File zipFile, File dirToExtractTo) throws Exception
    {
        if (!zipFile.isFile())
            throw new IOException("Zip file doesn't exist or Confluence doesn't have read access to it. backupedFile=" + zipFile);

        Unzipper fileUnzipper = new FileUnzipper(zipFile, dirToExtractTo);
        fileUnzipper.unzip();
    }

    /**
     * Unzips the zip url to a folder in temp and returns the File pointing to that expanded folder.
     */
    public static void unzipUrl(URL zipUrl, File dirToExtractTo) throws Exception
    {
        Unzipper urlUnzipper = new UrlUnzipper(zipUrl, dirToExtractTo);
        urlUnzipper.unzip();
    }

    private static String extractGoogleUrl(String url, int indexOfQuery)
    {
        try
        {
            int indexOfAmpersand = url.indexOf("&", indexOfQuery);
            String googleQueryPhrase;
            if (indexOfAmpersand > -1)
                googleQueryPhrase = url.substring(indexOfQuery + 2, indexOfAmpersand);
            else
                googleQueryPhrase = url.substring(indexOfQuery + 2);

            url = "Google: " + URLDecoder.decode(googleQueryPhrase);
        }
        catch (Exception e)
        {
            // if anything above fails, fall through to the default (CONF-1803)
        }
        return url;
    }

    /**
     * if this error message is of the type: "java.io.IOException: Content Length Error"
     * convert it to something nicer
     *
     * @param errorMessage
     */
    public static String getUploadFileTooLargeMessage(String errorMessage)
    {
        Pattern p = Pattern.compile("java\\.io\\.IOException: Content Length Error \\((\\p{Digit}+) > (\\p{Digit}+)\\)");
        Matcher m = p.matcher(errorMessage);

        if (m.matches())
        {
            String attachmentSize = FileSize.format(Long.parseLong(m.group(1)));
            String maxAttachmentSize = FileSize.format(Long.parseLong(m.group(2)));
            return "Total upload size is too large (" + attachmentSize + "). Reduce total filesize to below " + maxAttachmentSize;
        }
        else
        {
            return errorMessage;
        }
    }

    public static ResourceBundle getDefaultResourceBundle()
    {
        ConfluenceActionSupport action = new ConfluenceActionSupport();
        if (ContainerManager.isContainerSetup())
            ContainerManager.autowireComponent(action);

        return ResourceBundle.getBundle(ConfluenceActionSupport.class.getName(), action.getLocale(), Thread.currentThread().getContextClassLoader());
    }

    public static I18NBean getI18n()
    {
        ConfluenceActionSupport action = new ConfluenceActionSupport();
        if (ContainerManager.isContainerSetup())
            ContainerManager.autowireComponent(action);

        return action.getI18n();
    }

    /**
     * convenience method to allow us to determine the size of an int array a velocity file
     *
     * @param array
     */
    public int arraySize(int[] array)
    {
        return array.length;
    }

    /**
     * Take a String which may contain <, > or & and return an XML string containing entities
     */
    public static String escapeXMLCharacters(String input)
    {
        return input.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt");
    }

    /**
     * Take a string and escape the quotes in it with \" and HTML escape them afterwards.
     * We need this function to escape strings containing quotes passed into JavaScript functions
     *
     * <code>null</code> input will be returned as an empty String.
     *
     */
    public static String htmlEscapeQuotes(String input)
    {
        if (input != null)
        {
            return htmlEncode(input.replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\""));
        }
        return "";
    }

    /**
     * Return a List with no null entries
     */
    public static List filterNulls(Collection in)
    {
        List l = new ArrayList();
        for (Iterator i = in.iterator(); i.hasNext();)
        {
            Object o = i.next();
            if (o != null)
            {
                l.add(o);
            }
        }
        return l;
    }

    public static String shortenString(String str, int max)
    {
        if (TextUtils.stringSet(str) && str.length() > max)
            return str.substring(0, max) + "...";
        else
            return str;
    }

    /**
     * <p/>
     * the database lower() function in PostgreSQL only works for ASCII strings. All other unicode and multibyte characters like capital umlaut are not properly converted.
     * At the moment, when searching for pages we do the following comparison:
     * </p>
     * <p/>
     * <code>lower(page.title) = :pageTitle</code> (Where :pageTitle is normally .toLowerCase() first before being passed in)
     * <p/>
     * <p>This special lower case function will skip the JAVA .toLowerCase() for postgres whose database lower() is ineffective.</p>
     *
     * @param str
     */
    public static String specialToLowerCase(String str)
    {
        if (!TextUtils.stringSet(str))
            return str;

        // we must check whether the property is set, because some DBs which do support lower correctly don't set this property,
        // and getBooleanProperty returns false if the property is not set.
        boolean propertyIsSet = BootstrapUtils.getBootstrapManager().getApplicationConfig().getProperty("hibernate.database.lower_non_ascii_supported") != null;
        boolean lowerSupported = BootstrapUtils.getBootstrapManager().getApplicationConfig().getBooleanProperty("hibernate.database.lower_non_ascii_supported");

        if (propertyIsSet && !lowerSupported)
        {
            // replicate Postgres's odd lower case behaviour
            char[] chars = str.toCharArray();
            for (int i = 0; i < chars.length; ++i)
            {
                if (chars[i] < 128)
                {
                    chars[i] = Character.toLowerCase(chars[i]);
                }
            }
            return new String(chars);
        }
        else
        {
            return str.toLowerCase();
        }
    }

    public static String replaceConfluenceHomeConstant(String in, String confHome)
    {
        if (in == null)
        {
            return null;
        }

        StringBuffer prop = new StringBuffer(in);

        int length = BootstrapManager.CONFLUENCE_HOME_CONSTANT.length();
        int index = prop.indexOf(BootstrapManager.CONFLUENCE_HOME_CONSTANT);

        while (index != -1)
        {
            prop.replace(index, index + length, confHome);
            index = prop.indexOf(BootstrapManager.CONFLUENCE_HOME_CONSTANT);
        }
        return prop.toString();
    }


    /**
     * Takes a collection of Strings and lowercases the entries.
     *
     * @param collection
     * @return lowercased collection of strings
     */
    public static Collection specialLowerCaseCollection(Collection collection)
    {
        Collection lowerCollection = new ArrayList();
        for (Iterator iterator = collection.iterator(); iterator.hasNext();)
        {
            String string = (String) iterator.next();
            lowerCollection.add(specialToLowerCase(string));
        }
        return lowerCollection;
    }

    public static List safeSubList(List list, int max)
    {
        if (list == null || list.size() < max)
            return list;
        else
            return list.subList(0, max);
    }

    /**
     * @deprecated since 2.0 use {@link RendererUtil#summarise(String)} instead.
     */
    public static String summarise(String content)
    {
        return RendererUtil.summarise(content);
    }

    /**
     * Create a proper summary of this content fragment.
     *
     * @see com.atlassian.confluence.search.summary.Summarizer
     */
    public static Summary makeSummary(String content)
    {
        return makeSummary(content, null);
    }

    /**
     * Create a proper summary of this content fragment given a query
     *
     * @see Summarizer
     */
    public static Summary makeSummary(String content, String query)
    {
        Summary summary = null;
        try
        {
            String strippedContent = RendererUtil.stripBasicMarkup(content);

            // HACK: Non-breaking spaces appear in wiki-markup as-is. Translate them here [CONF-5116]
            strippedContent = strippedContent.replaceAll("&nbsp;", "\u00A0");

            if (strippedContent != null && !"".equals(strippedContent.trim()))
            {
                Summarizer s = (Summarizer) ContainerManager.getComponent("summarizer");

                UtilTimerStack.push("Summarizer.getSummary");
                summary = s.getSummary(strippedContent, query);
                UtilTimerStack.pop("Summarizer.getSummary");
            }
        }
        catch (IOException e)
        {
            log.error(e, e);
        }
        return summary;
    }

    public static UserAccessor getUserAccessor()
    {
        if (userAccessor == null)
            userAccessor = (UserAccessor) ContainerManager.getComponent("userAccessor");

        return userAccessor;
    }

    public static void setUserAccessor(UserAccessor userAcc)
    {
        userAccessor = userAcc;
    }

    public static ImageInfo getImageInfo(File pathToImage)
    {
        if (pathToImage == null)
            return null;

        FileInputStream fis = null;

        try
        {
            fis = new FileInputStream(pathToImage);
            ImageInfo imageInfo = new ImageInfo();
            imageInfo.setInput(fis);
            imageInfo.setDetermineImageNumber(true);
            imageInfo.setCollectComments(true);
            imageInfo.isValidImage();

            return imageInfo;
        }
        catch (FileNotFoundException e)
        {
            log.error("Could not load image " + pathToImage);
            return null;
        }
        finally
        {
            IOUtils.close(fis);
        }

    }

    public static String getNiceDuration(int minutes, int seconds)
    {
        String result = "";

        if (minutes > 0)
        {
            result += minutes + " minute" + (minutes > 1 ? "s" : "") + " ";
        }

        if (seconds > 0)
        {
            result += seconds + " second" + (seconds > 1 ? "s" : "");
        }

        return result;
    }

    public static ConfluenceActionSupport newWiredConfluenceActionSupport()
    {
        ConfluenceActionSupport dummy = new ConfluenceActionSupport();
        if (ContainerManager.isContainerSetup())
            ContainerManager.autowireComponent(dummy);

        // HACK: If we're still in the bootstrap/setup process, languageManager will not get injected, so do it manually
        /**
         * In some cases, the bootstrap manager or context may not have been set. This manifests itself with any tests extending
         * the AbstractXWorkTest, which tries to instantiate the action being tested. In most cases, a NoClassDefFoundError is reported
         * for the AbstractUserProfileAction class. However, this is caused by the following lines being called in the instantiation process,
         * which throws a NullPointerException and causes the instantiation to fail. (We don't see the NPE, however, which made it very difficult to track down.)
         */
        if (BootstrapUtils.getBootstrapManager() != null && BootstrapUtils.getBootstrapContext() != null && !BootstrapUtils.getBootstrapManager().isSetupComplete())
        {
            dummy = new ConfluenceActionSupport() {
                public Locale getLocale()
                {
                    ApplicationConfiguration applicationConfig = (ApplicationConfiguration) BootstrapUtils.getBootstrapContext().getBean("applicationConfig");
                    String localeString = (String) applicationConfig.getProperty(SessionKeys.LOCALE_FOR_SETUP);
                    if (localeString != null)
                        return new DefaultLocaleManager().toLocale(localeString);
                    else
                        return LocaleManager.DEFAULT_LOCALE;
                }
            };
            dummy.setLanguageManager((LanguageManager) BootstrapUtils.getBootstrapContext().getBean("languageManager"));
            dummy.setI18NBeanFactory((I18NBeanFactory) BootstrapUtils.getBootstrapContext().getBean("i18NBeanFactory"));
        }

        return dummy;
    }

    public static void profilePush(String s)
    {
        UtilTimerStack.push(s);
    }

    public static void profilePop(String s)
    {
        UtilTimerStack.pop(s);
    }

    /**
     * Get the default domain name.
     * @param request
     * @return null if request is null, otherwise a base URL derived from the request.
     */
    public static String lookupDomainName(HttpServletRequest request)
    {
        if (request == null)
            return null;
        String port = "";
        if (!isStandardPort(request.getScheme(), request.getServerPort()))
        {
            port = ":" + request.getServerPort();
        }
        return request.getScheme() + "://" + request.getServerName() + port + request.getContextPath();
    }

    private static boolean isStandardPort(String scheme, int port)
    {
        if (scheme.equalsIgnoreCase("http") && port == HTTP_DEFAULT_PORT) return true;
        if (scheme.equalsIgnoreCase("https") && port == HTTPS_DEFAULT_PORT) return true;
        return false;
    }

    public static Settings getGlobalSettings()
    {
        if (ContainerManager.isContainerSetup())
        {
            SettingsManager settingsManager = (SettingsManager) ContainerManager.getComponent("settingsManager");
            return settingsManager.getGlobalSettings();
        }
        else
        {
//            Exception e = new Exception();
//            String context = e.getStackTrace().length > 1 ? e.getStackTrace()[1].toString() : "Unknown caller";
//            log.warn("Attempting to retrieve global settings before ContainerManager has been set up: " + context);
            return null;
        }
    }

    public static String personalSpaceUrl(String contextPath, String username)
    {
        return contextPath + "/display/~" + doubleUrlEncode(username);
    }

    /**
     * @return returns the name of either the installed font or default font
     */
    public static String getDefaultFontFamily()
    {
        FontManager fontManager = (FontManager) ContainerManager.getComponent("fontManager");
        String installedFont = fontManager.getCurrentFont();
        if (TextUtils.stringSet(installedFont))
            return installedFont;
        else
            return DefaultFontManager.DEFAULT_FONT;
    }

    /**
     * converts a fraction into a percentage
     *
     * @param numerator
     * @param denom
     */
    public long getPercentage(long numerator, long denom)
    {
        return (new MathBean()).getPercentage(numerator, denom);
    }

    public long subtract(long a, long b)
    {
        return a - b;
    }

    public long getPercentage(String numeratorAsString, String denomAsString)
    {
        long numerator;
        long denom;
        try
        {
            numerator = Long.parseLong(numeratorAsString);
            denom = Long.parseLong(denomAsString);
        }
        catch (NumberFormatException e)
        {
            return 0;
        }
        return getPercentage(numerator, denom);
    }

    public long subtract(String firstOperandAsString, String secondOperandAsString)
    {
        long firstOperand;
        long secondOperand;
        try
        {
            firstOperand = Long.parseLong(firstOperandAsString);
            secondOperand = Long.parseLong(secondOperandAsString);
        }
        catch (NumberFormatException e)
        {
            return 0;
        }
        return subtract(firstOperand, secondOperand);
    }

    /**
     * Checks if temp directory exists before returning the path. Create it if it doesn't already exist.
     * @return path to temp directory inside Confluence home
     */
    public static String getConfluenceTempDirectoryPath()
    {
        String tempDirPath = ((DefaultBootstrapManager) BootstrapUtils.getBootstrapManager()).getConfluenceHome() + File.separator + ConfluenceHomeGlobalConstants.TEMP_DIR;
        File tempDir = new File(tempDirPath);
        if (!tempDir.exists())
        {
            if (!tempDir.mkdir())
                throw new RuntimeException("Could not create temp directory inside Confluence home.");
        }
        return tempDirPath;
    }

    public static File getConfluenceTempDirectory()
    {
        return new File(getConfluenceTempDirectoryPath());
    }

    /**
     * Method will turn a String of comma seperated entities into a String Array.
     * Spaces before or after the comma will be cropped.  Backslashes are treated as escaped characters.  Eg
     * when "backslash""comma" is encountered, the backslash is discarded and the comma is not treated as a delimiter.
     *
     * @param escapedNames Comma delimited string with original commas and backslashes escaped by backslashes
     * @return String[] of escapedNames
     */
    public static String[] splitCommaDelimitedString(String escapedNames)
    {
        if (!TextUtils.stringSet(escapedNames))
            return new String[0];
        
        List result = new ArrayList();
        StringBuffer currentName = new StringBuffer();
        for (int i = 0; i < escapedNames.length();)
        {
            char c = escapedNames.charAt(i++);
            if (c == '\\')
            {
                currentName.append(escapedNames.charAt(i++));
            }
            else if (c != ',')
            {
                currentName.append(c);
            }
            else
            {
                result.add(currentName.toString().trim());
                currentName = new StringBuffer();
            }
        }
        if (!StringUtils.isEmpty(currentName.toString()))
            result.add(currentName.toString().trim());
        return (String[]) result.toArray(new String[result.size()]);
    }

    /**
     * Escape commas on each entry in the given list of strings.
     *
     * @param toEscape {@link String}s to escape
     * @return escaped {@link String}s
     */
    public static List escapeCommas(List toEscape)
    {
        List result = new ArrayList(toEscape.size());
        for (int i = 0; i < toEscape.size(); i++)
        {
            result.add(escapeCommas((String)toEscape.get(i)));
        }
        return result;
    }

    /**
     * Escapes commas and backslashes with leading backslashes.
     *
     * @param toEscape string to escape.  If null, then null will be returned.
     */
    public static String escapeCommas(String toEscape)
    {
        if (toEscape == null)
            return null;

        if (toEscape.indexOf("\\") < 0 && toEscape.indexOf(",") < 0)
            return toEscape;

        StringBuffer sb = new StringBuffer(toEscape.length() + 5);

        for (int i = 0; i < toEscape.length(); i++)
        {
            if (toEscape.charAt(i) == ',')
                sb.append("\\,");
            else if (toEscape.charAt(i) == '\\')
                sb.append("\\\\");
            else
                sb.append(toEscape.charAt(i));
        }

        return sb.toString();
    }


    /**
     * Truncate a string after n characters
     * @param s The String to truncate
     * @param length The maximum length allowed.
     * @return The truncated String -- or the original String if no truncation was needed.
     */
    public static String constrainLength(String s, int length)
    {
        if (s != null && s.length() > length)
        {
            return s.substring(0, length);
        }
        else
        {
            return s;
        }
    }


    public static boolean isOutgoingMailConfigured()
    {
        try
        {
            return MailFactory.getServerManager().getSmtpMailServers().size() > 0;
        }
        catch (MailException e)
        {
            log.error("Error retrieving SMTP mailservers: " + e.getMessage(), e);
            return false;
        }
    }

    public static boolean isEditorAjaxEnabled()
    {
        return System.getProperty("confluence.editor.ajax.disable") == null;
    }
}
