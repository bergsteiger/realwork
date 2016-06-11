{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Provider;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.Telephony,
  Androidapi.JNI.Util,
  Androidapi.JNI.Webkit;

type
// ===== Forward declarations =====

  JAlarmClock = interface;//android.provider.AlarmClock
  JBaseColumns = interface;//android.provider.BaseColumns
  JBrowser = interface;//android.provider.Browser
  JBrowser_BookmarkColumns = interface;//android.provider.Browser$BookmarkColumns
  JBrowser_SearchColumns = interface;//android.provider.Browser$SearchColumns
  JCalendarContract = interface;//android.provider.CalendarContract
  JCalendarContract_Attendees = interface;//android.provider.CalendarContract$Attendees
  JCalendarContract_CalendarAlerts = interface;//android.provider.CalendarContract$CalendarAlerts
  JCalendarContract_CalendarCache = interface;//android.provider.CalendarContract$CalendarCache
  JCalendarContract_CalendarEntity = interface;//android.provider.CalendarContract$CalendarEntity
  JCalendarContract_Calendars = interface;//android.provider.CalendarContract$Calendars
  JCalendarContract_Colors = interface;//android.provider.CalendarContract$Colors
  JCalendarContract_EventDays = interface;//android.provider.CalendarContract$EventDays
  JCalendarContract_Events = interface;//android.provider.CalendarContract$Events
  JCalendarContract_EventsEntity = interface;//android.provider.CalendarContract$EventsEntity
  JCalendarContract_ExtendedProperties = interface;//android.provider.CalendarContract$ExtendedProperties
  JCalendarContract_Instances = interface;//android.provider.CalendarContract$Instances
  JCalendarContract_Reminders = interface;//android.provider.CalendarContract$Reminders
  JCalendarContract_SyncState = interface;//android.provider.CalendarContract$SyncState
  JCallLog = interface;//android.provider.CallLog
  JCallLog_Calls = interface;//android.provider.CallLog$Calls
  JContacts = interface;//android.provider.Contacts
  JContacts_ContactMethods = interface;//android.provider.Contacts$ContactMethods
  JContacts_ContactMethodsColumns = interface;//android.provider.Contacts$ContactMethodsColumns
  JContacts_Extensions = interface;//android.provider.Contacts$Extensions
  JContacts_ExtensionsColumns = interface;//android.provider.Contacts$ExtensionsColumns
  JContacts_GroupMembership = interface;//android.provider.Contacts$GroupMembership
  JContacts_Groups = interface;//android.provider.Contacts$Groups
  JContacts_GroupsColumns = interface;//android.provider.Contacts$GroupsColumns
  JContacts_Intents = interface;//android.provider.Contacts$Intents
  JIntents_Insert = interface;//android.provider.Contacts$Intents$Insert
  JIntents_UI = interface;//android.provider.Contacts$Intents$UI
  JContacts_OrganizationColumns = interface;//android.provider.Contacts$OrganizationColumns
  JContacts_Organizations = interface;//android.provider.Contacts$Organizations
  JContacts_People = interface;//android.provider.Contacts$People
  JPeople_ContactMethods = interface;//android.provider.Contacts$People$ContactMethods
  JPeople_Extensions = interface;//android.provider.Contacts$People$Extensions
  JPeople_Phones = interface;//android.provider.Contacts$People$Phones
  JContacts_PeopleColumns = interface;//android.provider.Contacts$PeopleColumns
  JContacts_Phones = interface;//android.provider.Contacts$Phones
  JContacts_PhonesColumns = interface;//android.provider.Contacts$PhonesColumns
  JContacts_Photos = interface;//android.provider.Contacts$Photos
  JContacts_PhotosColumns = interface;//android.provider.Contacts$PhotosColumns
  JContacts_PresenceColumns = interface;//android.provider.Contacts$PresenceColumns
  JContacts_Settings = interface;//android.provider.Contacts$Settings
  JContacts_SettingsColumns = interface;//android.provider.Contacts$SettingsColumns
  JContactsContract = interface;//android.provider.ContactsContract
  JContactsContract_AggregationExceptions = interface;//android.provider.ContactsContract$AggregationExceptions
  JContactsContract_CommonDataKinds = interface;//android.provider.ContactsContract$CommonDataKinds
  JCommonDataKinds_BaseTypes = interface;//android.provider.ContactsContract$CommonDataKinds$BaseTypes
  JCommonDataKinds_Callable = interface;//android.provider.ContactsContract$CommonDataKinds$Callable
  JCommonDataKinds_Contactables = interface;//android.provider.ContactsContract$CommonDataKinds$Contactables
  JCommonDataKinds_Email = interface;//android.provider.ContactsContract$CommonDataKinds$Email
  JCommonDataKinds_Event = interface;//android.provider.ContactsContract$CommonDataKinds$Event
  JCommonDataKinds_GroupMembership = interface;//android.provider.ContactsContract$CommonDataKinds$GroupMembership
  JCommonDataKinds_Identity = interface;//android.provider.ContactsContract$CommonDataKinds$Identity
  JCommonDataKinds_Im = interface;//android.provider.ContactsContract$CommonDataKinds$Im
  JCommonDataKinds_Nickname = interface;//android.provider.ContactsContract$CommonDataKinds$Nickname
  JCommonDataKinds_Note = interface;//android.provider.ContactsContract$CommonDataKinds$Note
  JCommonDataKinds_Organization = interface;//android.provider.ContactsContract$CommonDataKinds$Organization
  JCommonDataKinds_Phone = interface;//android.provider.ContactsContract$CommonDataKinds$Phone
  JCommonDataKinds_Photo = interface;//android.provider.ContactsContract$CommonDataKinds$Photo
  JCommonDataKinds_Relation = interface;//android.provider.ContactsContract$CommonDataKinds$Relation
  JCommonDataKinds_SipAddress = interface;//android.provider.ContactsContract$CommonDataKinds$SipAddress
  JCommonDataKinds_StructuredName = interface;//android.provider.ContactsContract$CommonDataKinds$StructuredName
  JCommonDataKinds_StructuredPostal = interface;//android.provider.ContactsContract$CommonDataKinds$StructuredPostal
  JCommonDataKinds_Website = interface;//android.provider.ContactsContract$CommonDataKinds$Website
  JContactsContract_Contacts = interface;//android.provider.ContactsContract$Contacts
  JContacts_AggregationSuggestions = interface;//android.provider.ContactsContract$Contacts$AggregationSuggestions
  JAggregationSuggestions_Builder = interface;//android.provider.ContactsContract$Contacts$AggregationSuggestions$Builder
  JContacts_Data = interface;//android.provider.ContactsContract$Contacts$Data
  JContacts_Entity = interface;//android.provider.ContactsContract$Contacts$Entity
  JContacts_Photo = interface;//android.provider.ContactsContract$Contacts$Photo
  JContactsContract_Data = interface;//android.provider.ContactsContract$Data
  JContactsContract_DataUsageFeedback = interface;//android.provider.ContactsContract$DataUsageFeedback
  JContactsContract_DeletedContacts = interface;//android.provider.ContactsContract$DeletedContacts
  JContactsContract_Directory = interface;//android.provider.ContactsContract$Directory
  JContactsContract_DisplayNameSources = interface;//android.provider.ContactsContract$DisplayNameSources
  JContactsContract_DisplayPhoto = interface;//android.provider.ContactsContract$DisplayPhoto
  JContactsContract_FullNameStyle = interface;//android.provider.ContactsContract$FullNameStyle
  JContactsContract_Groups = interface;//android.provider.ContactsContract$Groups
  JContactsContract_Intents = interface;//android.provider.ContactsContract$Intents
  JContactsContract_Intents_Insert = interface;//android.provider.ContactsContract$Intents$Insert
  JContactsContract_PhoneLookup = interface;//android.provider.ContactsContract$PhoneLookup
  JContactsContract_PhoneticNameStyle = interface;//android.provider.ContactsContract$PhoneticNameStyle
  JContactsContract_PinnedPositions = interface;//android.provider.ContactsContract$PinnedPositions
  JContactsContract_StatusUpdates = interface;//android.provider.ContactsContract$StatusUpdates
  JContactsContract_Presence = interface;//android.provider.ContactsContract$Presence
  JContactsContract_Profile = interface;//android.provider.ContactsContract$Profile
  JContactsContract_ProfileSyncState = interface;//android.provider.ContactsContract$ProfileSyncState
  JContactsContract_ProviderStatus = interface;//android.provider.ContactsContract$ProviderStatus
  JContactsContract_QuickContact = interface;//android.provider.ContactsContract$QuickContact
  JContactsContract_RawContacts = interface;//android.provider.ContactsContract$RawContacts
  JRawContacts_Data = interface;//android.provider.ContactsContract$RawContacts$Data
  JRawContacts_DisplayPhoto = interface;//android.provider.ContactsContract$RawContacts$DisplayPhoto
  JRawContacts_Entity = interface;//android.provider.ContactsContract$RawContacts$Entity
  JContactsContract_RawContactsEntity = interface;//android.provider.ContactsContract$RawContactsEntity
  JContactsContract_SearchSnippets = interface;//android.provider.ContactsContract$SearchSnippets
  JContactsContract_Settings = interface;//android.provider.ContactsContract$Settings
  JContactsContract_SyncState = interface;//android.provider.ContactsContract$SyncState
  JDocumentsContract = interface;//android.provider.DocumentsContract
  JDocumentsContract_Document = interface;//android.provider.DocumentsContract$Document
  JDocumentsContract_Root = interface;//android.provider.DocumentsContract$Root
  JDocumentsProvider = interface;//android.provider.DocumentsProvider
  JLiveFolders = interface;//android.provider.LiveFolders
  JMediaStore = interface;//android.provider.MediaStore
  JMediaStore_Audio = interface;//android.provider.MediaStore$Audio
  JAudio_AlbumColumns = interface;//android.provider.MediaStore$Audio$AlbumColumns
  JAudio_Albums = interface;//android.provider.MediaStore$Audio$Albums
  JAudio_ArtistColumns = interface;//android.provider.MediaStore$Audio$ArtistColumns
  JAudio_Artists = interface;//android.provider.MediaStore$Audio$Artists
  JArtists_Albums = interface;//android.provider.MediaStore$Audio$Artists$Albums
  JMediaStore_MediaColumns = interface;//android.provider.MediaStore$MediaColumns
  JAudio_AudioColumns = interface;//android.provider.MediaStore$Audio$AudioColumns
  JAudio_Genres = interface;//android.provider.MediaStore$Audio$Genres
  JGenres_Members = interface;//android.provider.MediaStore$Audio$Genres$Members
  JAudio_GenresColumns = interface;//android.provider.MediaStore$Audio$GenresColumns
  JAudio_Media = interface;//android.provider.MediaStore$Audio$Media
  JAudio_Playlists = interface;//android.provider.MediaStore$Audio$Playlists
  JPlaylists_Members = interface;//android.provider.MediaStore$Audio$Playlists$Members
  JAudio_PlaylistsColumns = interface;//android.provider.MediaStore$Audio$PlaylistsColumns
  JAudio_Radio = interface;//android.provider.MediaStore$Audio$Radio
  JMediaStore_Files = interface;//android.provider.MediaStore$Files
  JFiles_FileColumns = interface;//android.provider.MediaStore$Files$FileColumns
  JMediaStore_Images = interface;//android.provider.MediaStore$Images
  JImages_ImageColumns = interface;//android.provider.MediaStore$Images$ImageColumns
  JImages_Media = interface;//android.provider.MediaStore$Images$Media
  JImages_Thumbnails = interface;//android.provider.MediaStore$Images$Thumbnails
  JMediaStore_Video = interface;//android.provider.MediaStore$Video
  JVideo_Media = interface;//android.provider.MediaStore$Video$Media
  JVideo_Thumbnails = interface;//android.provider.MediaStore$Video$Thumbnails
  JVideo_VideoColumns = interface;//android.provider.MediaStore$Video$VideoColumns
  JOpenableColumns = interface;//android.provider.OpenableColumns
  JSearchRecentSuggestions = interface;//android.provider.SearchRecentSuggestions
  JSettings = interface;//android.provider.Settings
  JSettings_NameValueTable = interface;//android.provider.Settings$NameValueTable
  JSettings_Global = interface;//android.provider.Settings$Global
  JSettings_Secure = interface;//android.provider.Settings$Secure
  JSettings_SettingNotFoundException = interface;//android.provider.Settings$SettingNotFoundException
  JSettings_System = interface;//android.provider.Settings$System
  JSyncStateContract = interface;//android.provider.SyncStateContract
  JSyncStateContract_Columns = interface;//android.provider.SyncStateContract$Columns
  JSyncStateContract_Constants = interface;//android.provider.SyncStateContract$Constants
  JSyncStateContract_Helpers = interface;//android.provider.SyncStateContract$Helpers
  JTelephony = interface;//android.provider.Telephony
  JTelephony_BaseMmsColumns = interface;//android.provider.Telephony$BaseMmsColumns
  JTelephony_CanonicalAddressesColumns = interface;//android.provider.Telephony$CanonicalAddressesColumns
  JTelephony_Carriers = interface;//android.provider.Telephony$Carriers
  JTelephony_Mms = interface;//android.provider.Telephony$Mms
  JMms_Addr = interface;//android.provider.Telephony$Mms$Addr
  JMms_Draft = interface;//android.provider.Telephony$Mms$Draft
  JMms_Inbox = interface;//android.provider.Telephony$Mms$Inbox
  JMms_Intents = interface;//android.provider.Telephony$Mms$Intents
  JMms_Outbox = interface;//android.provider.Telephony$Mms$Outbox
  JMms_Part = interface;//android.provider.Telephony$Mms$Part
  JMms_Rate = interface;//android.provider.Telephony$Mms$Rate
  JMms_Sent = interface;//android.provider.Telephony$Mms$Sent
  JTelephony_MmsSms = interface;//android.provider.Telephony$MmsSms
  JMmsSms_PendingMessages = interface;//android.provider.Telephony$MmsSms$PendingMessages
  JTelephony_Sms = interface;//android.provider.Telephony$Sms
  JSms_Conversations = interface;//android.provider.Telephony$Sms$Conversations
  JSms_Draft = interface;//android.provider.Telephony$Sms$Draft
  JSms_Inbox = interface;//android.provider.Telephony$Sms$Inbox
  JSms_Intents = interface;//android.provider.Telephony$Sms$Intents
  JSms_Outbox = interface;//android.provider.Telephony$Sms$Outbox
  JSms_Sent = interface;//android.provider.Telephony$Sms$Sent
  JTelephony_TextBasedSmsColumns = interface;//android.provider.Telephony$TextBasedSmsColumns
  JTelephony_Threads = interface;//android.provider.Telephony$Threads
  JTelephony_ThreadsColumns = interface;//android.provider.Telephony$ThreadsColumns
  JUserDictionary = interface;//android.provider.UserDictionary
  JUserDictionary_Words = interface;//android.provider.UserDictionary$Words
  JVoicemailContract = interface;//android.provider.VoicemailContract
  JVoicemailContract_Status = interface;//android.provider.VoicemailContract$Status
  JVoicemailContract_Voicemails = interface;//android.provider.VoicemailContract$Voicemails

// ===== Interface declarations =====

  JAlarmClockClass = interface(JObjectClass)
    ['{966CFFB3-96A0-42EE-84D7-89AED6C9DBA7}']
    {class} function _GetACTION_DISMISS_ALARM: JString; cdecl;
    {class} function _GetACTION_SET_ALARM: JString; cdecl;
    {class} function _GetACTION_SET_TIMER: JString; cdecl;
    {class} function _GetACTION_SHOW_ALARMS: JString; cdecl;
    {class} function _GetACTION_SNOOZE_ALARM: JString; cdecl;
    {class} function _GetALARM_SEARCH_MODE_ALL: JString; cdecl;
    {class} function _GetALARM_SEARCH_MODE_LABEL: JString; cdecl;
    {class} function _GetALARM_SEARCH_MODE_NEXT: JString; cdecl;
    {class} function _GetALARM_SEARCH_MODE_TIME: JString; cdecl;
    {class} function _GetEXTRA_ALARM_SEARCH_MODE: JString; cdecl;
    {class} function _GetEXTRA_ALARM_SNOOZE_DURATION: JString; cdecl;
    {class} function _GetEXTRA_DAYS: JString; cdecl;
    {class} function _GetEXTRA_HOUR: JString; cdecl;
    {class} function _GetEXTRA_IS_PM: JString; cdecl;
    {class} function _GetEXTRA_LENGTH: JString; cdecl;
    {class} function _GetEXTRA_MESSAGE: JString; cdecl;
    {class} function _GetEXTRA_MINUTES: JString; cdecl;
    {class} function _GetEXTRA_RINGTONE: JString; cdecl;
    {class} function _GetEXTRA_SKIP_UI: JString; cdecl;
    {class} function _GetEXTRA_VIBRATE: JString; cdecl;
    {class} function _GetVALUE_RINGTONE_SILENT: JString; cdecl;
    {class} function init: JAlarmClock; cdecl;
    {class} property ACTION_DISMISS_ALARM: JString read _GetACTION_DISMISS_ALARM;
    {class} property ACTION_SET_ALARM: JString read _GetACTION_SET_ALARM;
    {class} property ACTION_SET_TIMER: JString read _GetACTION_SET_TIMER;
    {class} property ACTION_SHOW_ALARMS: JString read _GetACTION_SHOW_ALARMS;
    {class} property ACTION_SNOOZE_ALARM: JString read _GetACTION_SNOOZE_ALARM;
    {class} property ALARM_SEARCH_MODE_ALL: JString read _GetALARM_SEARCH_MODE_ALL;
    {class} property ALARM_SEARCH_MODE_LABEL: JString read _GetALARM_SEARCH_MODE_LABEL;
    {class} property ALARM_SEARCH_MODE_NEXT: JString read _GetALARM_SEARCH_MODE_NEXT;
    {class} property ALARM_SEARCH_MODE_TIME: JString read _GetALARM_SEARCH_MODE_TIME;
    {class} property EXTRA_ALARM_SEARCH_MODE: JString read _GetEXTRA_ALARM_SEARCH_MODE;
    {class} property EXTRA_ALARM_SNOOZE_DURATION: JString read _GetEXTRA_ALARM_SNOOZE_DURATION;
    {class} property EXTRA_DAYS: JString read _GetEXTRA_DAYS;
    {class} property EXTRA_HOUR: JString read _GetEXTRA_HOUR;
    {class} property EXTRA_IS_PM: JString read _GetEXTRA_IS_PM;
    {class} property EXTRA_LENGTH: JString read _GetEXTRA_LENGTH;
    {class} property EXTRA_MESSAGE: JString read _GetEXTRA_MESSAGE;
    {class} property EXTRA_MINUTES: JString read _GetEXTRA_MINUTES;
    {class} property EXTRA_RINGTONE: JString read _GetEXTRA_RINGTONE;
    {class} property EXTRA_SKIP_UI: JString read _GetEXTRA_SKIP_UI;
    {class} property EXTRA_VIBRATE: JString read _GetEXTRA_VIBRATE;
    {class} property VALUE_RINGTONE_SILENT: JString read _GetVALUE_RINGTONE_SILENT;
  end;

  [JavaSignature('android/provider/AlarmClock')]
  JAlarmClock = interface(JObject)
    ['{4B84B481-1CF9-484F-9F66-F9378600D231}']
  end;
  TJAlarmClock = class(TJavaGenericImport<JAlarmClockClass, JAlarmClock>) end;

  JBaseColumnsClass = interface(IJavaClass)
    ['{41940D1F-2151-4E46-BC9E-038A03919A4B}']
    {class} function _Get_COUNT: JString; cdecl;
    {class} function _Get_ID: JString; cdecl;
    {class} property _COUNT: JString read _Get_COUNT;
    {class} property _ID: JString read _Get_ID;
  end;

  [JavaSignature('android/provider/BaseColumns')]
  JBaseColumns = interface(IJavaInstance)
    ['{3F8E1C71-B6F5-4A75-A44C-4F8B0968D57B}']
  end;
  TJBaseColumns = class(TJavaGenericImport<JBaseColumnsClass, JBaseColumns>) end;

  JBrowserClass = interface(JObjectClass)
    ['{E886757C-AC6C-4EB5-9A05-E0F0A02027AC}']
    {class} function _GetBOOKMARKS_URI: Jnet_Uri; cdecl;
    {class} function _GetEXTRA_APPLICATION_ID: JString; cdecl;
    {class} function _GetEXTRA_CREATE_NEW_TAB: JString; cdecl;
    {class} function _GetEXTRA_HEADERS: JString; cdecl;
    {class} function _GetHISTORY_PROJECTION: TJavaObjectArray<JString>; cdecl;
    {class} function _GetHISTORY_PROJECTION_BOOKMARK_INDEX: Integer; cdecl;
    {class} function _GetHISTORY_PROJECTION_DATE_INDEX: Integer; cdecl;
    {class} function _GetHISTORY_PROJECTION_FAVICON_INDEX: Integer; cdecl;
    {class} function _GetHISTORY_PROJECTION_ID_INDEX: Integer; cdecl;
    {class} function _GetHISTORY_PROJECTION_TITLE_INDEX: Integer; cdecl;
    {class} function _GetHISTORY_PROJECTION_URL_INDEX: Integer; cdecl;
    {class} function _GetHISTORY_PROJECTION_VISITS_INDEX: Integer; cdecl;
    {class} function _GetINITIAL_ZOOM_LEVEL: JString; cdecl;
    {class} function _GetSEARCHES_PROJECTION: TJavaObjectArray<JString>; cdecl;
    {class} function _GetSEARCHES_PROJECTION_DATE_INDEX: Integer; cdecl;
    {class} function _GetSEARCHES_PROJECTION_SEARCH_INDEX: Integer; cdecl;
    {class} function _GetSEARCHES_URI: Jnet_Uri; cdecl;
    {class} function _GetTRUNCATE_HISTORY_PROJECTION: TJavaObjectArray<JString>; cdecl;
    {class} function _GetTRUNCATE_HISTORY_PROJECTION_ID_INDEX: Integer; cdecl;
    {class} function _GetTRUNCATE_N_OLDEST: Integer; cdecl;
    {class} function init: JBrowser; cdecl;
    {class} procedure addSearchUrl(cr: JContentResolver; search: JString); cdecl;
    {class} function canClearHistory(cr: JContentResolver): Boolean; cdecl;
    {class} procedure clearHistory(cr: JContentResolver); cdecl;
    {class} procedure clearSearches(cr: JContentResolver); cdecl;
    {class} procedure deleteFromHistory(cr: JContentResolver; url: JString); cdecl;
    {class} procedure deleteHistoryTimeFrame(cr: JContentResolver; begin_: Int64; end_: Int64); cdecl;
    {class} function getAllBookmarks(cr: JContentResolver): JCursor; cdecl;
    {class} function getAllVisitedUrls(cr: JContentResolver): JCursor; cdecl;
    {class} procedure requestAllIcons(cr: JContentResolver; where: JString; listener: JWebIconDatabase_IconListener); cdecl;
    {class} procedure saveBookmark(c: JContext; title: JString; url: JString); cdecl;
    {class} procedure sendString(context: JContext; string_: JString); cdecl;
    {class} procedure truncateHistory(cr: JContentResolver); cdecl;
    {class} procedure updateVisitedHistory(cr: JContentResolver; url: JString; real: Boolean); cdecl;
    {class} property BOOKMARKS_URI: Jnet_Uri read _GetBOOKMARKS_URI;
    {class} property EXTRA_APPLICATION_ID: JString read _GetEXTRA_APPLICATION_ID;
    {class} property EXTRA_CREATE_NEW_TAB: JString read _GetEXTRA_CREATE_NEW_TAB;
    {class} property EXTRA_HEADERS: JString read _GetEXTRA_HEADERS;
    {class} property HISTORY_PROJECTION: TJavaObjectArray<JString> read _GetHISTORY_PROJECTION;
    {class} property HISTORY_PROJECTION_BOOKMARK_INDEX: Integer read _GetHISTORY_PROJECTION_BOOKMARK_INDEX;
    {class} property HISTORY_PROJECTION_DATE_INDEX: Integer read _GetHISTORY_PROJECTION_DATE_INDEX;
    {class} property HISTORY_PROJECTION_FAVICON_INDEX: Integer read _GetHISTORY_PROJECTION_FAVICON_INDEX;
    {class} property HISTORY_PROJECTION_ID_INDEX: Integer read _GetHISTORY_PROJECTION_ID_INDEX;
    {class} property HISTORY_PROJECTION_TITLE_INDEX: Integer read _GetHISTORY_PROJECTION_TITLE_INDEX;
    {class} property HISTORY_PROJECTION_URL_INDEX: Integer read _GetHISTORY_PROJECTION_URL_INDEX;
    {class} property HISTORY_PROJECTION_VISITS_INDEX: Integer read _GetHISTORY_PROJECTION_VISITS_INDEX;
    {class} property INITIAL_ZOOM_LEVEL: JString read _GetINITIAL_ZOOM_LEVEL;
    {class} property SEARCHES_PROJECTION: TJavaObjectArray<JString> read _GetSEARCHES_PROJECTION;
    {class} property SEARCHES_PROJECTION_DATE_INDEX: Integer read _GetSEARCHES_PROJECTION_DATE_INDEX;
    {class} property SEARCHES_PROJECTION_SEARCH_INDEX: Integer read _GetSEARCHES_PROJECTION_SEARCH_INDEX;
    {class} property SEARCHES_URI: Jnet_Uri read _GetSEARCHES_URI;
    {class} property TRUNCATE_HISTORY_PROJECTION: TJavaObjectArray<JString> read _GetTRUNCATE_HISTORY_PROJECTION;
    {class} property TRUNCATE_HISTORY_PROJECTION_ID_INDEX: Integer read _GetTRUNCATE_HISTORY_PROJECTION_ID_INDEX;
    {class} property TRUNCATE_N_OLDEST: Integer read _GetTRUNCATE_N_OLDEST;
  end;

  [JavaSignature('android/provider/Browser')]
  JBrowser = interface(JObject)
    ['{28900B47-F2A9-496E-AEA4-BE635BEFEF9B}']
  end;
  TJBrowser = class(TJavaGenericImport<JBrowserClass, JBrowser>) end;

  JBrowser_BookmarkColumnsClass = interface(JObjectClass)
    ['{7AE30AE7-56DD-483A-A4A4-888276CC5CA3}']
    {class} function _GetBOOKMARK: JString; cdecl;
    {class} function _GetCREATED: JString; cdecl;
    {class} function _GetDATE: JString; cdecl;
    {class} function _GetFAVICON: JString; cdecl;
    {class} function _GetTITLE: JString; cdecl;
    {class} function _GetURL: JString; cdecl;
    {class} function _GetVISITS: JString; cdecl;
    {class} function init: JBrowser_BookmarkColumns; cdecl;
    {class} property BOOKMARK: JString read _GetBOOKMARK;
    {class} property CREATED: JString read _GetCREATED;
    {class} property DATE: JString read _GetDATE;
    {class} property FAVICON: JString read _GetFAVICON;
    {class} property TITLE: JString read _GetTITLE;
    {class} property URL: JString read _GetURL;
    {class} property VISITS: JString read _GetVISITS;
  end;

  [JavaSignature('android/provider/Browser$BookmarkColumns')]
  JBrowser_BookmarkColumns = interface(JObject)
    ['{964347F7-64CB-45CE-B69C-F3F376B7EE44}']
  end;
  TJBrowser_BookmarkColumns = class(TJavaGenericImport<JBrowser_BookmarkColumnsClass, JBrowser_BookmarkColumns>) end;

  JBrowser_SearchColumnsClass = interface(JObjectClass)
    ['{E8D6CFF1-C7BC-4DB2-8000-240EF4D598FB}']
    {class} function _GetDATE: JString; cdecl;
    {class} function _GetSEARCH: JString; cdecl;
    {class} function _GetURL: JString; cdecl;
    {class} function init: JBrowser_SearchColumns; cdecl;
    {class} property DATE: JString read _GetDATE;
    {class} property SEARCH: JString read _GetSEARCH;
    {class} property URL: JString read _GetURL;
  end;

  [JavaSignature('android/provider/Browser$SearchColumns')]
  JBrowser_SearchColumns = interface(JObject)
    ['{EE842EBD-4C9B-462B-B1B6-372F6A732032}']
  end;
  TJBrowser_SearchColumns = class(TJavaGenericImport<JBrowser_SearchColumnsClass, JBrowser_SearchColumns>) end;

  JCalendarContractClass = interface(JObjectClass)
    ['{A2128576-E669-4326-B3F3-6656D161C7D0}']
    {class} function _GetACCOUNT_TYPE_LOCAL: JString; cdecl;
    {class} function _GetACTION_EVENT_REMINDER: JString; cdecl;
    {class} function _GetACTION_HANDLE_CUSTOM_EVENT: JString; cdecl;
    {class} function _GetAUTHORITY: JString; cdecl;
    {class} function _GetCALLER_IS_SYNCADAPTER: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetEXTRA_CUSTOM_APP_URI: JString; cdecl;
    {class} function _GetEXTRA_EVENT_ALL_DAY: JString; cdecl;
    {class} function _GetEXTRA_EVENT_BEGIN_TIME: JString; cdecl;
    {class} function _GetEXTRA_EVENT_END_TIME: JString; cdecl;
    {class} property ACCOUNT_TYPE_LOCAL: JString read _GetACCOUNT_TYPE_LOCAL;
    {class} property ACTION_EVENT_REMINDER: JString read _GetACTION_EVENT_REMINDER;
    {class} property ACTION_HANDLE_CUSTOM_EVENT: JString read _GetACTION_HANDLE_CUSTOM_EVENT;
    {class} property AUTHORITY: JString read _GetAUTHORITY;
    {class} property CALLER_IS_SYNCADAPTER: JString read _GetCALLER_IS_SYNCADAPTER;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property EXTRA_CUSTOM_APP_URI: JString read _GetEXTRA_CUSTOM_APP_URI;
    {class} property EXTRA_EVENT_ALL_DAY: JString read _GetEXTRA_EVENT_ALL_DAY;
    {class} property EXTRA_EVENT_BEGIN_TIME: JString read _GetEXTRA_EVENT_BEGIN_TIME;
    {class} property EXTRA_EVENT_END_TIME: JString read _GetEXTRA_EVENT_END_TIME;
  end;

  [JavaSignature('android/provider/CalendarContract')]
  JCalendarContract = interface(JObject)
    ['{82B0ED4F-8A46-4C4F-9CA6-D060EC7D3E3B}']
  end;
  TJCalendarContract = class(TJavaGenericImport<JCalendarContractClass, JCalendarContract>) end;

  JCalendarContract_AttendeesClass = interface(JObjectClass)
    ['{FCB32CF5-B56E-459B-A11C-E24A3A1A884D}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function query(cr: JContentResolver; eventId: Int64; projection: TJavaObjectArray<JString>): JCursor; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/CalendarContract$Attendees')]
  JCalendarContract_Attendees = interface(JObject)
    ['{7775F06D-0FCB-4FB1-8AD1-35C74951AE5E}']
  end;
  TJCalendarContract_Attendees = class(TJavaGenericImport<JCalendarContract_AttendeesClass, JCalendarContract_Attendees>) end;

  JCalendarContract_CalendarAlertsClass = interface(JObjectClass)
    ['{776130ED-7CB2-473E-8A3F-F0F6C58C83FC}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_URI_BY_INSTANCE: Jnet_Uri; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property CONTENT_URI_BY_INSTANCE: Jnet_Uri read _GetCONTENT_URI_BY_INSTANCE;
  end;

  [JavaSignature('android/provider/CalendarContract$CalendarAlerts')]
  JCalendarContract_CalendarAlerts = interface(JObject)
    ['{EAB59478-59F1-4E35-9288-1A0E560548A1}']
  end;
  TJCalendarContract_CalendarAlerts = class(TJavaGenericImport<JCalendarContract_CalendarAlertsClass, JCalendarContract_CalendarAlerts>) end;

  JCalendarContract_CalendarCacheClass = interface(JObjectClass)
    ['{218F5BAB-B94C-4D5E-BE36-88694940EE2A}']
    {class} function _GetKEY_TIMEZONE_INSTANCES: JString; cdecl;
    {class} function _GetKEY_TIMEZONE_INSTANCES_PREVIOUS: JString; cdecl;
    {class} function _GetKEY_TIMEZONE_TYPE: JString; cdecl;
    {class} function _GetTIMEZONE_TYPE_AUTO: JString; cdecl;
    {class} function _GetTIMEZONE_TYPE_HOME: JString; cdecl;
    {class} function _GetURI: Jnet_Uri; cdecl;
    {class} property KEY_TIMEZONE_INSTANCES: JString read _GetKEY_TIMEZONE_INSTANCES;
    {class} property KEY_TIMEZONE_INSTANCES_PREVIOUS: JString read _GetKEY_TIMEZONE_INSTANCES_PREVIOUS;
    {class} property KEY_TIMEZONE_TYPE: JString read _GetKEY_TIMEZONE_TYPE;
    {class} property TIMEZONE_TYPE_AUTO: JString read _GetTIMEZONE_TYPE_AUTO;
    {class} property TIMEZONE_TYPE_HOME: JString read _GetTIMEZONE_TYPE_HOME;
    {class} property URI: Jnet_Uri read _GetURI;
  end;

  [JavaSignature('android/provider/CalendarContract$CalendarCache')]
  JCalendarContract_CalendarCache = interface(JObject)
    ['{17DD3DF3-DD4D-4045-92D3-71A868EE73FF}']
  end;
  TJCalendarContract_CalendarCache = class(TJavaGenericImport<JCalendarContract_CalendarCacheClass, JCalendarContract_CalendarCache>) end;

  JCalendarContract_CalendarEntityClass = interface(JObjectClass)
    ['{434CBEE7-C980-4F19-8785-4807E9729F4F}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function newEntityIterator(cursor: JCursor): JEntityIterator; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/CalendarContract$CalendarEntity')]
  JCalendarContract_CalendarEntity = interface(JObject)
    ['{B684C007-08AE-4C6D-812C-1F072BFB2CB7}']
  end;
  TJCalendarContract_CalendarEntity = class(TJavaGenericImport<JCalendarContract_CalendarEntityClass, JCalendarContract_CalendarEntity>) end;

  JCalendarContract_CalendarsClass = interface(JObjectClass)
    ['{C87B42D5-88AD-4981-95D6-C30643133988}']
    {class} function _GetCALENDAR_LOCATION: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetNAME: JString; cdecl;
    {class} property CALENDAR_LOCATION: JString read _GetCALENDAR_LOCATION;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property NAME: JString read _GetNAME;
  end;

  [JavaSignature('android/provider/CalendarContract$Calendars')]
  JCalendarContract_Calendars = interface(JObject)
    ['{D2EB7AF9-43F8-4D96-9D85-2147E35F75FC}']
  end;
  TJCalendarContract_Calendars = class(TJavaGenericImport<JCalendarContract_CalendarsClass, JCalendarContract_Calendars>) end;

  JCalendarContract_ColorsClass = interface(JObjectClass)
    ['{F160C731-69A5-4284-AF64-C6DF9F89B96B}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/CalendarContract$Colors')]
  JCalendarContract_Colors = interface(JObject)
    ['{0FD3621A-9D1E-403C-B345-3C47F40F891F}']
  end;
  TJCalendarContract_Colors = class(TJavaGenericImport<JCalendarContract_ColorsClass, JCalendarContract_Colors>) end;

  JCalendarContract_EventDaysClass = interface(JObjectClass)
    ['{CC23AE6F-BF06-44AA-A288-A1C7FBA55E52}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function query(cr: JContentResolver; startDay: Integer; numDays: Integer; projection: TJavaObjectArray<JString>): JCursor; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/CalendarContract$EventDays')]
  JCalendarContract_EventDays = interface(JObject)
    ['{FC84FBAD-5A8A-4DB1-AC93-9FF52E71A775}']
  end;
  TJCalendarContract_EventDays = class(TJavaGenericImport<JCalendarContract_EventDaysClass, JCalendarContract_EventDays>) end;

  JCalendarContract_EventsClass = interface(JObjectClass)
    ['{6A3B6590-2744-4952-A83A-7EE65D628A32}']
    {class} function _GetCONTENT_EXCEPTION_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} property CONTENT_EXCEPTION_URI: Jnet_Uri read _GetCONTENT_EXCEPTION_URI;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/CalendarContract$Events')]
  JCalendarContract_Events = interface(JObject)
    ['{7F79FF44-33D2-4066-A899-E599A9D0A4A7}']
  end;
  TJCalendarContract_Events = class(TJavaGenericImport<JCalendarContract_EventsClass, JCalendarContract_Events>) end;

  JCalendarContract_EventsEntityClass = interface(JObjectClass)
    ['{157ECBB3-77A9-4D6B-98FA-67E172F0EFAA}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function newEntityIterator(cursor: JCursor; resolver: JContentResolver): JEntityIterator; cdecl; overload;
    {class} function newEntityIterator(cursor: JCursor; provider: JContentProviderClient): JEntityIterator; cdecl; overload;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/CalendarContract$EventsEntity')]
  JCalendarContract_EventsEntity = interface(JObject)
    ['{89461BC2-A5DD-4854-92BD-25549D22BCC3}']
  end;
  TJCalendarContract_EventsEntity = class(TJavaGenericImport<JCalendarContract_EventsEntityClass, JCalendarContract_EventsEntity>) end;

  JCalendarContract_ExtendedPropertiesClass = interface(JObjectClass)
    ['{D2DF19F5-C43F-4701-AF44-2869FFBDDFEF}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/CalendarContract$ExtendedProperties')]
  JCalendarContract_ExtendedProperties = interface(JObject)
    ['{90564D52-DB23-4CE1-8692-5056843DCD9D}']
  end;
  TJCalendarContract_ExtendedProperties = class(TJavaGenericImport<JCalendarContract_ExtendedPropertiesClass, JCalendarContract_ExtendedProperties>) end;

  JCalendarContract_InstancesClass = interface(JObjectClass)
    ['{8D61CB60-F9C0-440F-9FA5-BB56CB6BD0DB}']
    {class} function _GetBEGIN: JString; cdecl;
    {class} function _GetCONTENT_BY_DAY_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_SEARCH_BY_DAY_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_SEARCH_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetEND: JString; cdecl;
    {class} function _GetEND_DAY: JString; cdecl;
    {class} function _GetEND_MINUTE: JString; cdecl;
    {class} function _GetEVENT_ID: JString; cdecl;
    {class} function _GetSTART_DAY: JString; cdecl;
    {class} function _GetSTART_MINUTE: JString; cdecl;
    {class} function query(cr: JContentResolver; projection: TJavaObjectArray<JString>; begin_: Int64; end_: Int64): JCursor; cdecl; overload;
    {class} function query(cr: JContentResolver; projection: TJavaObjectArray<JString>; begin_: Int64; end_: Int64; searchQuery: JString): JCursor; cdecl; overload;
    {class} property &BEGIN: JString read _GetBEGIN;
    {class} property CONTENT_BY_DAY_URI: Jnet_Uri read _GetCONTENT_BY_DAY_URI;
    {class} property CONTENT_SEARCH_BY_DAY_URI: Jnet_Uri read _GetCONTENT_SEARCH_BY_DAY_URI;
    {class} property CONTENT_SEARCH_URI: Jnet_Uri read _GetCONTENT_SEARCH_URI;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property &END: JString read _GetEND;
    {class} property END_DAY: JString read _GetEND_DAY;
    {class} property END_MINUTE: JString read _GetEND_MINUTE;
    {class} property EVENT_ID: JString read _GetEVENT_ID;
    {class} property START_DAY: JString read _GetSTART_DAY;
    {class} property START_MINUTE: JString read _GetSTART_MINUTE;
  end;

  [JavaSignature('android/provider/CalendarContract$Instances')]
  JCalendarContract_Instances = interface(JObject)
    ['{9FC7533E-0D27-4B35-998B-3D9C2CEE79F7}']
  end;
  TJCalendarContract_Instances = class(TJavaGenericImport<JCalendarContract_InstancesClass, JCalendarContract_Instances>) end;

  JCalendarContract_RemindersClass = interface(JObjectClass)
    ['{BA36FD20-EC66-4D37-ADDA-3C031DF34C5B}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function query(cr: JContentResolver; eventId: Int64; projection: TJavaObjectArray<JString>): JCursor; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/CalendarContract$Reminders')]
  JCalendarContract_Reminders = interface(JObject)
    ['{EA76BFBF-0882-453C-8447-CC92FEEBCCE5}']
  end;
  TJCalendarContract_Reminders = class(TJavaGenericImport<JCalendarContract_RemindersClass, JCalendarContract_Reminders>) end;

  JCalendarContract_SyncStateClass = interface(JObjectClass)
    ['{83EFBFA0-5214-4567-8824-3214ECFAE45F}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/CalendarContract$SyncState')]
  JCalendarContract_SyncState = interface(JObject)
    ['{42477479-2128-49DA-9126-CDF5C5067B35}']
  end;
  TJCalendarContract_SyncState = class(TJavaGenericImport<JCalendarContract_SyncStateClass, JCalendarContract_SyncState>) end;

  JCallLogClass = interface(JObjectClass)
    ['{0C575B19-4E9D-4A3B-A864-F7C4BB9A1744}']
    {class} function _GetAUTHORITY: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function init: JCallLog; cdecl;
    {class} property AUTHORITY: JString read _GetAUTHORITY;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/CallLog')]
  JCallLog = interface(JObject)
    ['{F29F58F2-1E89-4D8F-AD31-96DF80305D8F}']
  end;
  TJCallLog = class(TJavaGenericImport<JCallLogClass, JCallLog>) end;

  JCallLog_CallsClass = interface(JObjectClass)
    ['{C1F91074-4530-4BD5-A988-EED3E9684F7F}']
    {class} function _GetCACHED_FORMATTED_NUMBER: JString; cdecl;
    {class} function _GetCACHED_LOOKUP_URI: JString; cdecl;
    {class} function _GetCACHED_MATCHED_NUMBER: JString; cdecl;
    {class} function _GetCACHED_NAME: JString; cdecl;
    {class} function _GetCACHED_NORMALIZED_NUMBER: JString; cdecl;
    {class} function _GetCACHED_NUMBER_LABEL: JString; cdecl;
    {class} function _GetCACHED_NUMBER_TYPE: JString; cdecl;
    {class} function _GetCACHED_PHOTO_ID: JString; cdecl;
    {class} function _GetCACHED_PHOTO_URI: JString; cdecl;
    {class} function _GetCONTENT_FILTER_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_URI_WITH_VOICEMAIL: Jnet_Uri; cdecl;
    {class} function _GetCOUNTRY_ISO: JString; cdecl;
    {class} function _GetDATA_USAGE: JString; cdecl;
    {class} function _GetDATE: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetDURATION: JString; cdecl;
    {class} function _GetEXTRA_CALL_TYPE_FILTER: JString; cdecl;
    {class} function _GetFEATURES: JString; cdecl;
    {class} function _GetFEATURES_VIDEO: Integer; cdecl;
    {class} function _GetGEOCODED_LOCATION: JString; cdecl;
    {class} function _GetINCOMING_TYPE: Integer; cdecl;
    {class} function _GetIS_READ: JString; cdecl;
    {class} function _GetLIMIT_PARAM_KEY: JString; cdecl;
    {class} function _GetMISSED_TYPE: Integer; cdecl;
    {class} function _GetNEW: JString; cdecl;
    {class} function _GetNUMBER: JString; cdecl;
    {class} function _GetNUMBER_PRESENTATION: JString; cdecl;
    {class} function _GetOFFSET_PARAM_KEY: JString; cdecl;
    {class} function _GetOUTGOING_TYPE: Integer; cdecl;
    {class} function _GetPHONE_ACCOUNT_COMPONENT_NAME: JString; cdecl;
    {class} function _GetPHONE_ACCOUNT_ID: JString; cdecl;
    {class} function _GetPRESENTATION_ALLOWED: Integer; cdecl;
    {class} function _GetPRESENTATION_PAYPHONE: Integer; cdecl;
    {class} function _GetPRESENTATION_RESTRICTED: Integer; cdecl;
    {class} function _GetPRESENTATION_UNKNOWN: Integer; cdecl;
    {class} function _GetTRANSCRIPTION: JString; cdecl;
    {class} function _GetTYPE: JString; cdecl;
    {class} function _GetVOICEMAIL_TYPE: Integer; cdecl;
    {class} function _GetVOICEMAIL_URI: JString; cdecl;
    {class} function init: JCallLog_Calls; cdecl;
    {class} function getLastOutgoingCall(context: JContext): JString; cdecl;
    {class} property CACHED_FORMATTED_NUMBER: JString read _GetCACHED_FORMATTED_NUMBER;
    {class} property CACHED_LOOKUP_URI: JString read _GetCACHED_LOOKUP_URI;
    {class} property CACHED_MATCHED_NUMBER: JString read _GetCACHED_MATCHED_NUMBER;
    {class} property CACHED_NAME: JString read _GetCACHED_NAME;
    {class} property CACHED_NORMALIZED_NUMBER: JString read _GetCACHED_NORMALIZED_NUMBER;
    {class} property CACHED_NUMBER_LABEL: JString read _GetCACHED_NUMBER_LABEL;
    {class} property CACHED_NUMBER_TYPE: JString read _GetCACHED_NUMBER_TYPE;
    {class} property CACHED_PHOTO_ID: JString read _GetCACHED_PHOTO_ID;
    {class} property CACHED_PHOTO_URI: JString read _GetCACHED_PHOTO_URI;
    {class} property CONTENT_FILTER_URI: Jnet_Uri read _GetCONTENT_FILTER_URI;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property CONTENT_URI_WITH_VOICEMAIL: Jnet_Uri read _GetCONTENT_URI_WITH_VOICEMAIL;
    {class} property COUNTRY_ISO: JString read _GetCOUNTRY_ISO;
    {class} property DATA_USAGE: JString read _GetDATA_USAGE;
    {class} property DATE: JString read _GetDATE;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property DURATION: JString read _GetDURATION;
    {class} property EXTRA_CALL_TYPE_FILTER: JString read _GetEXTRA_CALL_TYPE_FILTER;
    {class} property FEATURES: JString read _GetFEATURES;
    {class} property FEATURES_VIDEO: Integer read _GetFEATURES_VIDEO;
    {class} property GEOCODED_LOCATION: JString read _GetGEOCODED_LOCATION;
    {class} property INCOMING_TYPE: Integer read _GetINCOMING_TYPE;
    {class} property IS_READ: JString read _GetIS_READ;
    {class} property LIMIT_PARAM_KEY: JString read _GetLIMIT_PARAM_KEY;
    {class} property MISSED_TYPE: Integer read _GetMISSED_TYPE;
    {class} property NEW: JString read _GetNEW;
    {class} property NUMBER: JString read _GetNUMBER;
    {class} property NUMBER_PRESENTATION: JString read _GetNUMBER_PRESENTATION;
    {class} property OFFSET_PARAM_KEY: JString read _GetOFFSET_PARAM_KEY;
    {class} property OUTGOING_TYPE: Integer read _GetOUTGOING_TYPE;
    {class} property PHONE_ACCOUNT_COMPONENT_NAME: JString read _GetPHONE_ACCOUNT_COMPONENT_NAME;
    {class} property PHONE_ACCOUNT_ID: JString read _GetPHONE_ACCOUNT_ID;
    {class} property PRESENTATION_ALLOWED: Integer read _GetPRESENTATION_ALLOWED;
    {class} property PRESENTATION_PAYPHONE: Integer read _GetPRESENTATION_PAYPHONE;
    {class} property PRESENTATION_RESTRICTED: Integer read _GetPRESENTATION_RESTRICTED;
    {class} property PRESENTATION_UNKNOWN: Integer read _GetPRESENTATION_UNKNOWN;
    {class} property TRANSCRIPTION: JString read _GetTRANSCRIPTION;
    {class} property &TYPE: JString read _GetTYPE;
    {class} property VOICEMAIL_TYPE: Integer read _GetVOICEMAIL_TYPE;
    {class} property VOICEMAIL_URI: JString read _GetVOICEMAIL_URI;
  end;

  [JavaSignature('android/provider/CallLog$Calls')]
  JCallLog_Calls = interface(JObject)
    ['{A7EE4C05-1CD7-4AFB-94F2-EF23965CCBFA}']
  end;
  TJCallLog_Calls = class(TJavaGenericImport<JCallLog_CallsClass, JCallLog_Calls>) end;

  JContactsClass = interface(JObjectClass)
    ['{084AE141-8566-4CCE-B5E2-7ECA373E1A0F}']
    {class} function _GetAUTHORITY: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetKIND_EMAIL: Integer; cdecl;
    {class} function _GetKIND_IM: Integer; cdecl;
    {class} function _GetKIND_ORGANIZATION: Integer; cdecl;
    {class} function _GetKIND_PHONE: Integer; cdecl;
    {class} function _GetKIND_POSTAL: Integer; cdecl;
    {class} property AUTHORITY: JString read _GetAUTHORITY;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property KIND_EMAIL: Integer read _GetKIND_EMAIL;
    {class} property KIND_IM: Integer read _GetKIND_IM;
    {class} property KIND_ORGANIZATION: Integer read _GetKIND_ORGANIZATION;
    {class} property KIND_PHONE: Integer read _GetKIND_PHONE;
    {class} property KIND_POSTAL: Integer read _GetKIND_POSTAL;
  end;

  [JavaSignature('android/provider/Contacts')]
  JContacts = interface(JObject)
    ['{31576FEB-6779-489E-9B8D-BE98F11BB7FC}']
  end;
  TJContacts = class(TJavaGenericImport<JContactsClass, JContacts>) end;

  JContacts_ContactMethodsClass = interface(JObjectClass)
    ['{E7392E3D-EEE3-412C-B71D-E0B6320DDA7B}']
    {class} function _GetCONTENT_EMAIL_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_EMAIL_TYPE: JString; cdecl;
    {class} function _GetCONTENT_EMAIL_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_IM_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_POSTAL_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_POSTAL_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetPERSON_ID: JString; cdecl;
    {class} function _GetPOSTAL_LOCATION_LATITUDE: JString; cdecl;
    {class} function _GetPOSTAL_LOCATION_LONGITUDE: JString; cdecl;
    {class} function _GetPROTOCOL_AIM: Integer; cdecl;
    {class} function _GetPROTOCOL_GOOGLE_TALK: Integer; cdecl;
    {class} function _GetPROTOCOL_ICQ: Integer; cdecl;
    {class} function _GetPROTOCOL_JABBER: Integer; cdecl;
    {class} function _GetPROTOCOL_MSN: Integer; cdecl;
    {class} function _GetPROTOCOL_QQ: Integer; cdecl;
    {class} function _GetPROTOCOL_SKYPE: Integer; cdecl;
    {class} function _GetPROTOCOL_YAHOO: Integer; cdecl;
    {class} function decodeImProtocol(encodedString: JString): JObject; cdecl;//Deprecated
    {class} function encodeCustomImProtocol(protocolString: JString): JString; cdecl;//Deprecated
    {class} function encodePredefinedImProtocol(protocol: Integer): JString; cdecl;//Deprecated
    {class} function getDisplayLabel(context: JContext; kind: Integer; type_: Integer; label_: JCharSequence): JCharSequence; cdecl;//Deprecated
    {class} property CONTENT_EMAIL_ITEM_TYPE: JString read _GetCONTENT_EMAIL_ITEM_TYPE;
    {class} property CONTENT_EMAIL_TYPE: JString read _GetCONTENT_EMAIL_TYPE;
    {class} property CONTENT_EMAIL_URI: Jnet_Uri read _GetCONTENT_EMAIL_URI;
    {class} property CONTENT_IM_ITEM_TYPE: JString read _GetCONTENT_IM_ITEM_TYPE;
    {class} property CONTENT_POSTAL_ITEM_TYPE: JString read _GetCONTENT_POSTAL_ITEM_TYPE;
    {class} property CONTENT_POSTAL_TYPE: JString read _GetCONTENT_POSTAL_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property PERSON_ID: JString read _GetPERSON_ID;
    {class} property POSTAL_LOCATION_LATITUDE: JString read _GetPOSTAL_LOCATION_LATITUDE;
    {class} property POSTAL_LOCATION_LONGITUDE: JString read _GetPOSTAL_LOCATION_LONGITUDE;
    {class} property PROTOCOL_AIM: Integer read _GetPROTOCOL_AIM;
    {class} property PROTOCOL_GOOGLE_TALK: Integer read _GetPROTOCOL_GOOGLE_TALK;
    {class} property PROTOCOL_ICQ: Integer read _GetPROTOCOL_ICQ;
    {class} property PROTOCOL_JABBER: Integer read _GetPROTOCOL_JABBER;
    {class} property PROTOCOL_MSN: Integer read _GetPROTOCOL_MSN;
    {class} property PROTOCOL_QQ: Integer read _GetPROTOCOL_QQ;
    {class} property PROTOCOL_SKYPE: Integer read _GetPROTOCOL_SKYPE;
    {class} property PROTOCOL_YAHOO: Integer read _GetPROTOCOL_YAHOO;
  end;

  [JavaSignature('android/provider/Contacts$ContactMethods')]
  JContacts_ContactMethods = interface(JObject)
    ['{4336FCFA-8273-4814-A060-BCEF8613EC38}']
    procedure addPostalLocation(context: JContext; postalId: Int64; latitude: Double; longitude: Double); cdecl;//Deprecated
  end;
  TJContacts_ContactMethods = class(TJavaGenericImport<JContacts_ContactMethodsClass, JContacts_ContactMethods>) end;

  JContacts_ContactMethodsColumnsClass = interface(IJavaClass)
    ['{A3629EC7-5EA7-4E30-9912-9BE3B3116CAB}']
    {class} function _GetAUX_DATA: JString; cdecl;
    {class} function _GetDATA: JString; cdecl;
    {class} function _GetISPRIMARY: JString; cdecl;
    {class} function _GetKIND: JString; cdecl;
    {class} function _GetLABEL: JString; cdecl;
    {class} function _GetTYPE: JString; cdecl;
    {class} function _GetTYPE_CUSTOM: Integer; cdecl;
    {class} function _GetTYPE_HOME: Integer; cdecl;
    {class} function _GetTYPE_OTHER: Integer; cdecl;
    {class} function _GetTYPE_WORK: Integer; cdecl;
    {class} property AUX_DATA: JString read _GetAUX_DATA;
    {class} property DATA: JString read _GetDATA;
    {class} property ISPRIMARY: JString read _GetISPRIMARY;
    {class} property KIND: JString read _GetKIND;
    {class} property &LABEL: JString read _GetLABEL;
    {class} property &TYPE: JString read _GetTYPE;
    {class} property TYPE_CUSTOM: Integer read _GetTYPE_CUSTOM;
    {class} property TYPE_HOME: Integer read _GetTYPE_HOME;
    {class} property TYPE_OTHER: Integer read _GetTYPE_OTHER;
    {class} property TYPE_WORK: Integer read _GetTYPE_WORK;
  end;

  [JavaSignature('android/provider/Contacts$ContactMethodsColumns')]
  JContacts_ContactMethodsColumns = interface(IJavaInstance)
    ['{4E8D661C-6E9F-4A55-A794-E8BEFF607E5C}']
  end;
  TJContacts_ContactMethodsColumns = class(TJavaGenericImport<JContacts_ContactMethodsColumnsClass, JContacts_ContactMethodsColumns>) end;

  JContacts_ExtensionsClass = interface(JObjectClass)
    ['{F4FD4B8D-3F96-4C0E-8C12-6BB78F3A584A}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetPERSON_ID: JString; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property PERSON_ID: JString read _GetPERSON_ID;
  end;

  [JavaSignature('android/provider/Contacts$Extensions')]
  JContacts_Extensions = interface(JObject)
    ['{458FE1B4-F7BD-4125-B8D1-803192A5DC0D}']
  end;
  TJContacts_Extensions = class(TJavaGenericImport<JContacts_ExtensionsClass, JContacts_Extensions>) end;

  JContacts_ExtensionsColumnsClass = interface(IJavaClass)
    ['{F0C26E1A-5DA1-487E-BCC4-207D5860F239}']
    {class} function _GetNAME: JString; cdecl;
    {class} function _GetVALUE: JString; cdecl;
    {class} property NAME: JString read _GetNAME;
    {class} property VALUE: JString read _GetVALUE;
  end;

  [JavaSignature('android/provider/Contacts$ExtensionsColumns')]
  JContacts_ExtensionsColumns = interface(IJavaInstance)
    ['{02CDF856-3141-48EA-B6B6-44B498BEB144}']
  end;
  TJContacts_ExtensionsColumns = class(TJavaGenericImport<JContacts_ExtensionsColumnsClass, JContacts_ExtensionsColumns>) end;

  JContacts_GroupMembershipClass = interface(JObjectClass)
    ['{C5CE55C3-D97D-49CB-9D8A-6462647A7D11}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetGROUP_ID: JString; cdecl;
    {class} function _GetGROUP_SYNC_ACCOUNT: JString; cdecl;
    {class} function _GetGROUP_SYNC_ACCOUNT_TYPE: JString; cdecl;
    {class} function _GetGROUP_SYNC_ID: JString; cdecl;
    {class} function _GetPERSON_ID: JString; cdecl;
    {class} function _GetRAW_CONTENT_URI: Jnet_Uri; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property GROUP_ID: JString read _GetGROUP_ID;
    {class} property GROUP_SYNC_ACCOUNT: JString read _GetGROUP_SYNC_ACCOUNT;
    {class} property GROUP_SYNC_ACCOUNT_TYPE: JString read _GetGROUP_SYNC_ACCOUNT_TYPE;
    {class} property GROUP_SYNC_ID: JString read _GetGROUP_SYNC_ID;
    {class} property PERSON_ID: JString read _GetPERSON_ID;
    {class} property RAW_CONTENT_URI: Jnet_Uri read _GetRAW_CONTENT_URI;
  end;

  [JavaSignature('android/provider/Contacts$GroupMembership')]
  JContacts_GroupMembership = interface(JObject)
    ['{E374AA3B-4721-48DE-AA8D-29DDA3425586}']
  end;
  TJContacts_GroupMembership = class(TJavaGenericImport<JContacts_GroupMembershipClass, JContacts_GroupMembership>) end;

  JContacts_GroupsClass = interface(JObjectClass)
    ['{B066518A-FA76-46E5-B324-16A10C77B766}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetDELETED_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetGROUP_ANDROID_STARRED: JString; cdecl;
    {class} function _GetGROUP_MY_CONTACTS: JString; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property DELETED_CONTENT_URI: Jnet_Uri read _GetDELETED_CONTENT_URI;
    {class} property GROUP_ANDROID_STARRED: JString read _GetGROUP_ANDROID_STARRED;
    {class} property GROUP_MY_CONTACTS: JString read _GetGROUP_MY_CONTACTS;
  end;

  [JavaSignature('android/provider/Contacts$Groups')]
  JContacts_Groups = interface(JObject)
    ['{68A7D006-DC19-4CF4-BD69-1F4C75163C5A}']
  end;
  TJContacts_Groups = class(TJavaGenericImport<JContacts_GroupsClass, JContacts_Groups>) end;

  JContacts_GroupsColumnsClass = interface(IJavaClass)
    ['{9F717155-86DF-4B07-8494-815CCE57D0DA}']
    {class} function _GetNAME: JString; cdecl;
    {class} function _GetNOTES: JString; cdecl;
    {class} function _GetSHOULD_SYNC: JString; cdecl;
    {class} function _GetSYSTEM_ID: JString; cdecl;
    {class} property NAME: JString read _GetNAME;
    {class} property NOTES: JString read _GetNOTES;
    {class} property SHOULD_SYNC: JString read _GetSHOULD_SYNC;
    {class} property SYSTEM_ID: JString read _GetSYSTEM_ID;
  end;

  [JavaSignature('android/provider/Contacts$GroupsColumns')]
  JContacts_GroupsColumns = interface(IJavaInstance)
    ['{0DE73B43-0D39-4CB9-A65A-100DCDF8DE94}']
  end;
  TJContacts_GroupsColumns = class(TJavaGenericImport<JContacts_GroupsColumnsClass, JContacts_GroupsColumns>) end;

  JContacts_IntentsClass = interface(JObjectClass)
    ['{42C14BF0-54D4-46B7-8255-16CC534167BC}']
    {class} function _GetATTACH_IMAGE: JString; cdecl;
    {class} function _GetEXTRA_CREATE_DESCRIPTION: JString; cdecl;
    {class} function _GetEXTRA_FORCE_CREATE: JString; cdecl;
    {class} function _GetSEARCH_SUGGESTION_CLICKED: JString; cdecl;
    {class} function _GetSEARCH_SUGGESTION_CREATE_CONTACT_CLICKED: JString; cdecl;
    {class} function _GetSEARCH_SUGGESTION_DIAL_NUMBER_CLICKED: JString; cdecl;
    {class} function _GetSHOW_OR_CREATE_CONTACT: JString; cdecl;
    {class} function init: JContacts_Intents; cdecl;//Deprecated
    {class} property ATTACH_IMAGE: JString read _GetATTACH_IMAGE;
    {class} property EXTRA_CREATE_DESCRIPTION: JString read _GetEXTRA_CREATE_DESCRIPTION;
    {class} property EXTRA_FORCE_CREATE: JString read _GetEXTRA_FORCE_CREATE;
    {class} property SEARCH_SUGGESTION_CLICKED: JString read _GetSEARCH_SUGGESTION_CLICKED;
    {class} property SEARCH_SUGGESTION_CREATE_CONTACT_CLICKED: JString read _GetSEARCH_SUGGESTION_CREATE_CONTACT_CLICKED;
    {class} property SEARCH_SUGGESTION_DIAL_NUMBER_CLICKED: JString read _GetSEARCH_SUGGESTION_DIAL_NUMBER_CLICKED;
    {class} property SHOW_OR_CREATE_CONTACT: JString read _GetSHOW_OR_CREATE_CONTACT;
  end;

  [JavaSignature('android/provider/Contacts$Intents')]
  JContacts_Intents = interface(JObject)
    ['{3899A52D-E908-44CB-8722-0331ACB5B43D}']
  end;
  TJContacts_Intents = class(TJavaGenericImport<JContacts_IntentsClass, JContacts_Intents>) end;

  JIntents_InsertClass = interface(JObjectClass)
    ['{47D453BB-E6FF-4579-9263-B3154E0ECC6C}']
    {class} function _GetACTION: JString; cdecl;
    {class} function _GetCOMPANY: JString; cdecl;
    {class} function _GetEMAIL: JString; cdecl;
    {class} function _GetEMAIL_ISPRIMARY: JString; cdecl;
    {class} function _GetEMAIL_TYPE: JString; cdecl;
    {class} function _GetFULL_MODE: JString; cdecl;
    {class} function _GetIM_HANDLE: JString; cdecl;
    {class} function _GetIM_ISPRIMARY: JString; cdecl;
    {class} function _GetIM_PROTOCOL: JString; cdecl;
    {class} function _GetJOB_TITLE: JString; cdecl;
    {class} function _GetNAME: JString; cdecl;
    {class} function _GetNOTES: JString; cdecl;
    {class} function _GetPHONE: JString; cdecl;
    {class} function _GetPHONETIC_NAME: JString; cdecl;
    {class} function _GetPHONE_ISPRIMARY: JString; cdecl;
    {class} function _GetPHONE_TYPE: JString; cdecl;
    {class} function _GetPOSTAL: JString; cdecl;
    {class} function _GetPOSTAL_ISPRIMARY: JString; cdecl;
    {class} function _GetPOSTAL_TYPE: JString; cdecl;
    {class} function _GetSECONDARY_EMAIL: JString; cdecl;
    {class} function _GetSECONDARY_EMAIL_TYPE: JString; cdecl;
    {class} function _GetSECONDARY_PHONE: JString; cdecl;
    {class} function _GetSECONDARY_PHONE_TYPE: JString; cdecl;
    {class} function _GetTERTIARY_EMAIL: JString; cdecl;
    {class} function _GetTERTIARY_EMAIL_TYPE: JString; cdecl;
    {class} function _GetTERTIARY_PHONE: JString; cdecl;
    {class} function _GetTERTIARY_PHONE_TYPE: JString; cdecl;
    {class} function init: JIntents_Insert; cdecl;//Deprecated
    {class} property ACTION: JString read _GetACTION;
    {class} property COMPANY: JString read _GetCOMPANY;
    {class} property EMAIL: JString read _GetEMAIL;
    {class} property EMAIL_ISPRIMARY: JString read _GetEMAIL_ISPRIMARY;
    {class} property EMAIL_TYPE: JString read _GetEMAIL_TYPE;
    {class} property FULL_MODE: JString read _GetFULL_MODE;
    {class} property IM_HANDLE: JString read _GetIM_HANDLE;
    {class} property IM_ISPRIMARY: JString read _GetIM_ISPRIMARY;
    {class} property IM_PROTOCOL: JString read _GetIM_PROTOCOL;
    {class} property JOB_TITLE: JString read _GetJOB_TITLE;
    {class} property NAME: JString read _GetNAME;
    {class} property NOTES: JString read _GetNOTES;
    {class} property PHONE: JString read _GetPHONE;
    {class} property PHONETIC_NAME: JString read _GetPHONETIC_NAME;
    {class} property PHONE_ISPRIMARY: JString read _GetPHONE_ISPRIMARY;
    {class} property PHONE_TYPE: JString read _GetPHONE_TYPE;
    {class} property POSTAL: JString read _GetPOSTAL;
    {class} property POSTAL_ISPRIMARY: JString read _GetPOSTAL_ISPRIMARY;
    {class} property POSTAL_TYPE: JString read _GetPOSTAL_TYPE;
    {class} property SECONDARY_EMAIL: JString read _GetSECONDARY_EMAIL;
    {class} property SECONDARY_EMAIL_TYPE: JString read _GetSECONDARY_EMAIL_TYPE;
    {class} property SECONDARY_PHONE: JString read _GetSECONDARY_PHONE;
    {class} property SECONDARY_PHONE_TYPE: JString read _GetSECONDARY_PHONE_TYPE;
    {class} property TERTIARY_EMAIL: JString read _GetTERTIARY_EMAIL;
    {class} property TERTIARY_EMAIL_TYPE: JString read _GetTERTIARY_EMAIL_TYPE;
    {class} property TERTIARY_PHONE: JString read _GetTERTIARY_PHONE;
    {class} property TERTIARY_PHONE_TYPE: JString read _GetTERTIARY_PHONE_TYPE;
  end;

  [JavaSignature('android/provider/Contacts$Intents$Insert')]
  JIntents_Insert = interface(JObject)
    ['{2C3128E1-F765-46FC-A4E9-5B8A570A006F}']
  end;
  TJIntents_Insert = class(TJavaGenericImport<JIntents_InsertClass, JIntents_Insert>) end;

  JIntents_UIClass = interface(JObjectClass)
    ['{F573A146-D60E-48A3-92CC-28AECCEA7A58}']
    {class} function _GetFILTER_CONTACTS_ACTION: JString; cdecl;
    {class} function _GetFILTER_TEXT_EXTRA_KEY: JString; cdecl;
    {class} function _GetGROUP_NAME_EXTRA_KEY: JString; cdecl;
    {class} function _GetLIST_ALL_CONTACTS_ACTION: JString; cdecl;
    {class} function _GetLIST_CONTACTS_WITH_PHONES_ACTION: JString; cdecl;
    {class} function _GetLIST_DEFAULT: JString; cdecl;
    {class} function _GetLIST_FREQUENT_ACTION: JString; cdecl;
    {class} function _GetLIST_GROUP_ACTION: JString; cdecl;
    {class} function _GetLIST_STARRED_ACTION: JString; cdecl;
    {class} function _GetLIST_STREQUENT_ACTION: JString; cdecl;
    {class} function _GetTITLE_EXTRA_KEY: JString; cdecl;
    {class} function init: JIntents_UI; cdecl;//Deprecated
    {class} property FILTER_CONTACTS_ACTION: JString read _GetFILTER_CONTACTS_ACTION;
    {class} property FILTER_TEXT_EXTRA_KEY: JString read _GetFILTER_TEXT_EXTRA_KEY;
    {class} property GROUP_NAME_EXTRA_KEY: JString read _GetGROUP_NAME_EXTRA_KEY;
    {class} property LIST_ALL_CONTACTS_ACTION: JString read _GetLIST_ALL_CONTACTS_ACTION;
    {class} property LIST_CONTACTS_WITH_PHONES_ACTION: JString read _GetLIST_CONTACTS_WITH_PHONES_ACTION;
    {class} property LIST_DEFAULT: JString read _GetLIST_DEFAULT;
    {class} property LIST_FREQUENT_ACTION: JString read _GetLIST_FREQUENT_ACTION;
    {class} property LIST_GROUP_ACTION: JString read _GetLIST_GROUP_ACTION;
    {class} property LIST_STARRED_ACTION: JString read _GetLIST_STARRED_ACTION;
    {class} property LIST_STREQUENT_ACTION: JString read _GetLIST_STREQUENT_ACTION;
    {class} property TITLE_EXTRA_KEY: JString read _GetTITLE_EXTRA_KEY;
  end;

  [JavaSignature('android/provider/Contacts$Intents$UI')]
  JIntents_UI = interface(JObject)
    ['{E21B86C2-6E55-4DF8-ACB9-78362AFEEC1F}']
  end;
  TJIntents_UI = class(TJavaGenericImport<JIntents_UIClass, JIntents_UI>) end;

  JContacts_OrganizationColumnsClass = interface(IJavaClass)
    ['{BE6F7681-BECC-414F-9D3A-546CC869EBC7}']
    {class} function _GetCOMPANY: JString; cdecl;
    {class} function _GetISPRIMARY: JString; cdecl;
    {class} function _GetLABEL: JString; cdecl;
    {class} function _GetPERSON_ID: JString; cdecl;
    {class} function _GetTITLE: JString; cdecl;
    {class} function _GetTYPE: JString; cdecl;
    {class} function _GetTYPE_CUSTOM: Integer; cdecl;
    {class} function _GetTYPE_OTHER: Integer; cdecl;
    {class} function _GetTYPE_WORK: Integer; cdecl;
    {class} property COMPANY: JString read _GetCOMPANY;
    {class} property ISPRIMARY: JString read _GetISPRIMARY;
    {class} property &LABEL: JString read _GetLABEL;
    {class} property PERSON_ID: JString read _GetPERSON_ID;
    {class} property TITLE: JString read _GetTITLE;
    {class} property &TYPE: JString read _GetTYPE;
    {class} property TYPE_CUSTOM: Integer read _GetTYPE_CUSTOM;
    {class} property TYPE_OTHER: Integer read _GetTYPE_OTHER;
    {class} property TYPE_WORK: Integer read _GetTYPE_WORK;
  end;

  [JavaSignature('android/provider/Contacts$OrganizationColumns')]
  JContacts_OrganizationColumns = interface(IJavaInstance)
    ['{51903653-253E-4641-806A-E34515848A92}']
  end;
  TJContacts_OrganizationColumns = class(TJavaGenericImport<JContacts_OrganizationColumnsClass, JContacts_OrganizationColumns>) end;

  JContacts_OrganizationsClass = interface(JObjectClass)
    ['{8359A187-9035-4B6E-A86B-5322FAD849DF}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function getDisplayLabel(context: JContext; type_: Integer; label_: JCharSequence): JCharSequence; cdecl;//Deprecated
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Contacts$Organizations')]
  JContacts_Organizations = interface(JObject)
    ['{08123B12-1675-456F-91E2-41D83C19724D}']
  end;
  TJContacts_Organizations = class(TJavaGenericImport<JContacts_OrganizationsClass, JContacts_Organizations>) end;

  JContacts_PeopleClass = interface(JObjectClass)
    ['{79BB5A75-B7DB-4CEC-B4DE-0BA93F8782BA}']
    {class} function _GetCONTENT_FILTER_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetDELETED_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetPRIMARY_EMAIL_ID: JString; cdecl;
    {class} function _GetPRIMARY_ORGANIZATION_ID: JString; cdecl;
    {class} function _GetPRIMARY_PHONE_ID: JString; cdecl;
    {class} function addToGroup(resolver: JContentResolver; personId: Int64; groupName: JString): Jnet_Uri; cdecl; overload;//Deprecated
    {class} function addToGroup(resolver: JContentResolver; personId: Int64; groupId: Int64): Jnet_Uri; cdecl; overload;//Deprecated
    {class} function addToMyContactsGroup(resolver: JContentResolver; personId: Int64): Jnet_Uri; cdecl;//Deprecated
    {class} function createPersonInMyContactsGroup(resolver: JContentResolver; values: JContentValues): Jnet_Uri; cdecl;//Deprecated
    {class} function loadContactPhoto(context: JContext; person: Jnet_Uri; placeholderImageResource: Integer; options: JBitmapFactory_Options): JBitmap; cdecl;//Deprecated
    {class} procedure markAsContacted(resolver: JContentResolver; personId: Int64); cdecl;//Deprecated
    {class} function openContactPhotoInputStream(cr: JContentResolver; person: Jnet_Uri): JInputStream; cdecl;//Deprecated
    {class} function queryGroups(resolver: JContentResolver; person: Int64): JCursor; cdecl;//Deprecated
    {class} procedure setPhotoData(cr: JContentResolver; person: Jnet_Uri; data: TJavaArray<Byte>); cdecl;//Deprecated
    {class} property CONTENT_FILTER_URI: Jnet_Uri read _GetCONTENT_FILTER_URI;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property DELETED_CONTENT_URI: Jnet_Uri read _GetDELETED_CONTENT_URI;
    {class} property PRIMARY_EMAIL_ID: JString read _GetPRIMARY_EMAIL_ID;
    {class} property PRIMARY_ORGANIZATION_ID: JString read _GetPRIMARY_ORGANIZATION_ID;
    {class} property PRIMARY_PHONE_ID: JString read _GetPRIMARY_PHONE_ID;
  end;

  [JavaSignature('android/provider/Contacts$People')]
  JContacts_People = interface(JObject)
    ['{29599D8E-C652-4CEE-9B1A-EB1F3D3BD974}']
  end;
  TJContacts_People = class(TJavaGenericImport<JContacts_PeopleClass, JContacts_People>) end;

  JPeople_ContactMethodsClass = interface(JObjectClass)
    ['{FFBB0FBA-6AEC-4E4C-B0DF-A1280FA674C9}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Contacts$People$ContactMethods')]
  JPeople_ContactMethods = interface(JObject)
    ['{33E39BD1-FFF2-417C-ABDE-5E19E6AEFDA4}']
  end;
  TJPeople_ContactMethods = class(TJavaGenericImport<JPeople_ContactMethodsClass, JPeople_ContactMethods>) end;

  JPeople_ExtensionsClass = interface(JObjectClass)
    ['{F1ED3823-09EE-4C45-9887-ADF2A764C108}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetPERSON_ID: JString; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property PERSON_ID: JString read _GetPERSON_ID;
  end;

  [JavaSignature('android/provider/Contacts$People$Extensions')]
  JPeople_Extensions = interface(JObject)
    ['{BCE87217-DDFC-47F1-9673-02D23EA359DC}']
  end;
  TJPeople_Extensions = class(TJavaGenericImport<JPeople_ExtensionsClass, JPeople_Extensions>) end;

  JPeople_PhonesClass = interface(JObjectClass)
    ['{8D325165-B643-414C-A87C-AB58A8CE3E43}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Contacts$People$Phones')]
  JPeople_Phones = interface(JObject)
    ['{8E1EBD27-A95D-4FA9-B210-D575BB44806D}']
  end;
  TJPeople_Phones = class(TJavaGenericImport<JPeople_PhonesClass, JPeople_Phones>) end;

  JContacts_PeopleColumnsClass = interface(IJavaClass)
    ['{4934A41B-BB4E-44BB-B9FE-44455BDA5C93}']
    {class} function _GetCUSTOM_RINGTONE: JString; cdecl;
    {class} function _GetDISPLAY_NAME: JString; cdecl;
    {class} function _GetLAST_TIME_CONTACTED: JString; cdecl;
    {class} function _GetNAME: JString; cdecl;
    {class} function _GetNOTES: JString; cdecl;
    {class} function _GetPHONETIC_NAME: JString; cdecl;
    {class} function _GetPHOTO_VERSION: JString; cdecl;
    {class} function _GetSEND_TO_VOICEMAIL: JString; cdecl;
    {class} function _GetSTARRED: JString; cdecl;
    {class} function _GetTIMES_CONTACTED: JString; cdecl;
    {class} property CUSTOM_RINGTONE: JString read _GetCUSTOM_RINGTONE;
    {class} property DISPLAY_NAME: JString read _GetDISPLAY_NAME;
    {class} property LAST_TIME_CONTACTED: JString read _GetLAST_TIME_CONTACTED;
    {class} property NAME: JString read _GetNAME;
    {class} property NOTES: JString read _GetNOTES;
    {class} property PHONETIC_NAME: JString read _GetPHONETIC_NAME;
    {class} property PHOTO_VERSION: JString read _GetPHOTO_VERSION;
    {class} property SEND_TO_VOICEMAIL: JString read _GetSEND_TO_VOICEMAIL;
    {class} property STARRED: JString read _GetSTARRED;
    {class} property TIMES_CONTACTED: JString read _GetTIMES_CONTACTED;
  end;

  [JavaSignature('android/provider/Contacts$PeopleColumns')]
  JContacts_PeopleColumns = interface(IJavaInstance)
    ['{8C727BCF-E0E2-42F0-8C80-00905562DFCF}']
  end;
  TJContacts_PeopleColumns = class(TJavaGenericImport<JContacts_PeopleColumnsClass, JContacts_PeopleColumns>) end;

  JContacts_PhonesClass = interface(JObjectClass)
    ['{CF5F27C1-2C0C-4EAC-A328-BB28D0EF7D48}']
    {class} function _GetCONTENT_FILTER_URL: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetPERSON_ID: JString; cdecl;
    {class} function getDisplayLabel(context: JContext; type_: Integer; label_: JCharSequence; labelArray: TJavaObjectArray<JCharSequence>): JCharSequence; cdecl; overload;//Deprecated
    {class} function getDisplayLabel(context: JContext; type_: Integer; label_: JCharSequence): JCharSequence; cdecl; overload;//Deprecated
    {class} property CONTENT_FILTER_URL: Jnet_Uri read _GetCONTENT_FILTER_URL;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property PERSON_ID: JString read _GetPERSON_ID;
  end;

  [JavaSignature('android/provider/Contacts$Phones')]
  JContacts_Phones = interface(JObject)
    ['{AE4C71A4-CE42-4B53-B595-62274D7123D2}']
  end;
  TJContacts_Phones = class(TJavaGenericImport<JContacts_PhonesClass, JContacts_Phones>) end;

  JContacts_PhonesColumnsClass = interface(IJavaClass)
    ['{C5F22A6B-2AED-48CE-84BB-3F2C3A43DD2B}']
    {class} function _GetISPRIMARY: JString; cdecl;
    {class} function _GetLABEL: JString; cdecl;
    {class} function _GetNUMBER: JString; cdecl;
    {class} function _GetNUMBER_KEY: JString; cdecl;
    {class} function _GetTYPE: JString; cdecl;
    {class} function _GetTYPE_CUSTOM: Integer; cdecl;
    {class} function _GetTYPE_FAX_HOME: Integer; cdecl;
    {class} function _GetTYPE_FAX_WORK: Integer; cdecl;
    {class} function _GetTYPE_HOME: Integer; cdecl;
    {class} function _GetTYPE_MOBILE: Integer; cdecl;
    {class} function _GetTYPE_OTHER: Integer; cdecl;
    {class} function _GetTYPE_PAGER: Integer; cdecl;
    {class} function _GetTYPE_WORK: Integer; cdecl;
    {class} property ISPRIMARY: JString read _GetISPRIMARY;
    {class} property &LABEL: JString read _GetLABEL;
    {class} property NUMBER: JString read _GetNUMBER;
    {class} property NUMBER_KEY: JString read _GetNUMBER_KEY;
    {class} property &TYPE: JString read _GetTYPE;
    {class} property TYPE_CUSTOM: Integer read _GetTYPE_CUSTOM;
    {class} property TYPE_FAX_HOME: Integer read _GetTYPE_FAX_HOME;
    {class} property TYPE_FAX_WORK: Integer read _GetTYPE_FAX_WORK;
    {class} property TYPE_HOME: Integer read _GetTYPE_HOME;
    {class} property TYPE_MOBILE: Integer read _GetTYPE_MOBILE;
    {class} property TYPE_OTHER: Integer read _GetTYPE_OTHER;
    {class} property TYPE_PAGER: Integer read _GetTYPE_PAGER;
    {class} property TYPE_WORK: Integer read _GetTYPE_WORK;
  end;

  [JavaSignature('android/provider/Contacts$PhonesColumns')]
  JContacts_PhonesColumns = interface(IJavaInstance)
    ['{5967B38B-9C44-40B9-B035-30694E363B53}']
  end;
  TJContacts_PhonesColumns = class(TJavaGenericImport<JContacts_PhonesColumnsClass, JContacts_PhonesColumns>) end;

  JContacts_PhotosClass = interface(JObjectClass)
    ['{27A63125-9A2B-4C7B-94C8-B29146841362}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Contacts$Photos')]
  JContacts_Photos = interface(JObject)
    ['{5498AAAC-BE8D-4BD4-9F39-F351C7F85213}']
  end;
  TJContacts_Photos = class(TJavaGenericImport<JContacts_PhotosClass, JContacts_Photos>) end;

  JContacts_PhotosColumnsClass = interface(IJavaClass)
    ['{D754AED5-EAE1-4475-A430-DA8FF3C82D5F}']
    {class} function _GetDATA: JString; cdecl;
    {class} function _GetDOWNLOAD_REQUIRED: JString; cdecl;
    {class} function _GetEXISTS_ON_SERVER: JString; cdecl;
    {class} function _GetLOCAL_VERSION: JString; cdecl;
    {class} function _GetPERSON_ID: JString; cdecl;
    {class} function _GetSYNC_ERROR: JString; cdecl;
    {class} property DATA: JString read _GetDATA;
    {class} property DOWNLOAD_REQUIRED: JString read _GetDOWNLOAD_REQUIRED;
    {class} property EXISTS_ON_SERVER: JString read _GetEXISTS_ON_SERVER;
    {class} property LOCAL_VERSION: JString read _GetLOCAL_VERSION;
    {class} property PERSON_ID: JString read _GetPERSON_ID;
    {class} property SYNC_ERROR: JString read _GetSYNC_ERROR;
  end;

  [JavaSignature('android/provider/Contacts$PhotosColumns')]
  JContacts_PhotosColumns = interface(IJavaInstance)
    ['{40B8ECB5-8B18-4678-818A-3880485BF463}']
  end;
  TJContacts_PhotosColumns = class(TJavaGenericImport<JContacts_PhotosColumnsClass, JContacts_PhotosColumns>) end;

  JContacts_PresenceColumnsClass = interface(IJavaClass)
    ['{801ACDB6-3761-4304-B5FA-0E22F24A2674}']
    {class} function _GetAVAILABLE: Integer; cdecl;
    {class} function _GetAWAY: Integer; cdecl;
    {class} function _GetDO_NOT_DISTURB: Integer; cdecl;
    {class} function _GetIDLE: Integer; cdecl;
    {class} function _GetIM_ACCOUNT: JString; cdecl;
    {class} function _GetIM_HANDLE: JString; cdecl;
    {class} function _GetIM_PROTOCOL: JString; cdecl;
    {class} function _GetINVISIBLE: Integer; cdecl;
    {class} function _GetOFFLINE: Integer; cdecl;
    {class} function _GetPRESENCE_CUSTOM_STATUS: JString; cdecl;
    {class} function _GetPRESENCE_STATUS: JString; cdecl;
    {class} function _GetPRIORITY: JString; cdecl;
    {class} property AVAILABLE: Integer read _GetAVAILABLE;
    {class} property AWAY: Integer read _GetAWAY;
    {class} property DO_NOT_DISTURB: Integer read _GetDO_NOT_DISTURB;
    {class} property IDLE: Integer read _GetIDLE;
    {class} property IM_ACCOUNT: JString read _GetIM_ACCOUNT;
    {class} property IM_HANDLE: JString read _GetIM_HANDLE;
    {class} property IM_PROTOCOL: JString read _GetIM_PROTOCOL;
    {class} property INVISIBLE: Integer read _GetINVISIBLE;
    {class} property OFFLINE: Integer read _GetOFFLINE;
    {class} property PRESENCE_CUSTOM_STATUS: JString read _GetPRESENCE_CUSTOM_STATUS;
    {class} property PRESENCE_STATUS: JString read _GetPRESENCE_STATUS;
    {class} property PRIORITY: JString read _GetPRIORITY;
  end;

  [JavaSignature('android/provider/Contacts$PresenceColumns')]
  JContacts_PresenceColumns = interface(IJavaInstance)
    ['{90EAC3A6-5FF6-42F5-8248-94E41BE20054}']
  end;
  TJContacts_PresenceColumns = class(TJavaGenericImport<JContacts_PresenceColumnsClass, JContacts_PresenceColumns>) end;

  JContacts_SettingsClass = interface(JObjectClass)
    ['{F5925633-0876-4493-B0D3-24F02B6A2DCC}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetSYNC_EVERYTHING: JString; cdecl;
    {class} function getSetting(cr: JContentResolver; account: JString; key: JString): JString; cdecl;//Deprecated
    {class} procedure setSetting(cr: JContentResolver; account: JString; key: JString; value: JString); cdecl;//Deprecated
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property SYNC_EVERYTHING: JString read _GetSYNC_EVERYTHING;
  end;

  [JavaSignature('android/provider/Contacts$Settings')]
  JContacts_Settings = interface(JObject)
    ['{D0B1ABA3-0E95-4148-912F-10AE6B3B81DA}']
  end;
  TJContacts_Settings = class(TJavaGenericImport<JContacts_SettingsClass, JContacts_Settings>) end;

  JContacts_SettingsColumnsClass = interface(IJavaClass)
    ['{94EAFAE0-EE2B-495C-847A-4CE7F4828115}']
    {class} function _GetKEY: JString; cdecl;
    {class} function _GetVALUE: JString; cdecl;
    {class} function _Get_SYNC_ACCOUNT: JString; cdecl;
    {class} function _Get_SYNC_ACCOUNT_TYPE: JString; cdecl;
    {class} property KEY: JString read _GetKEY;
    {class} property VALUE: JString read _GetVALUE;
    {class} property _SYNC_ACCOUNT: JString read _Get_SYNC_ACCOUNT;
    {class} property _SYNC_ACCOUNT_TYPE: JString read _Get_SYNC_ACCOUNT_TYPE;
  end;

  [JavaSignature('android/provider/Contacts$SettingsColumns')]
  JContacts_SettingsColumns = interface(IJavaInstance)
    ['{E6D7EC94-D966-471A-BADB-FCC9C25645D2}']
  end;
  TJContacts_SettingsColumns = class(TJavaGenericImport<JContacts_SettingsColumnsClass, JContacts_SettingsColumns>) end;

  JContactsContractClass = interface(JObjectClass)
    ['{CFD9D03D-AEFB-488B-B966-5CFEC3CF916B}']
    {class} function _GetAUTHORITY: JString; cdecl;
    {class} function _GetAUTHORITY_URI: Jnet_Uri; cdecl;
    {class} function _GetCALLER_IS_SYNCADAPTER: JString; cdecl;
    {class} function _GetDEFERRED_SNIPPETING: JString; cdecl;
    {class} function _GetDEFERRED_SNIPPETING_QUERY: JString; cdecl;
    {class} function _GetDIRECTORY_PARAM_KEY: JString; cdecl;
    {class} function _GetLIMIT_PARAM_KEY: JString; cdecl;
    {class} function _GetPRIMARY_ACCOUNT_NAME: JString; cdecl;
    {class} function _GetPRIMARY_ACCOUNT_TYPE: JString; cdecl;
    {class} function _GetREMOVE_DUPLICATE_ENTRIES: JString; cdecl;
    {class} function _GetSTREQUENT_PHONE_ONLY: JString; cdecl;
    {class} function init: JContactsContract; cdecl;
    {class} function isProfileId(id: Int64): Boolean; cdecl;
    {class} property AUTHORITY: JString read _GetAUTHORITY;
    {class} property AUTHORITY_URI: Jnet_Uri read _GetAUTHORITY_URI;
    {class} property CALLER_IS_SYNCADAPTER: JString read _GetCALLER_IS_SYNCADAPTER;
    {class} property DEFERRED_SNIPPETING: JString read _GetDEFERRED_SNIPPETING;
    {class} property DEFERRED_SNIPPETING_QUERY: JString read _GetDEFERRED_SNIPPETING_QUERY;
    {class} property DIRECTORY_PARAM_KEY: JString read _GetDIRECTORY_PARAM_KEY;
    {class} property LIMIT_PARAM_KEY: JString read _GetLIMIT_PARAM_KEY;
    {class} property PRIMARY_ACCOUNT_NAME: JString read _GetPRIMARY_ACCOUNT_NAME;
    {class} property PRIMARY_ACCOUNT_TYPE: JString read _GetPRIMARY_ACCOUNT_TYPE;
    {class} property REMOVE_DUPLICATE_ENTRIES: JString read _GetREMOVE_DUPLICATE_ENTRIES;
    {class} property STREQUENT_PHONE_ONLY: JString read _GetSTREQUENT_PHONE_ONLY;
  end;

  [JavaSignature('android/provider/ContactsContract')]
  JContactsContract = interface(JObject)
    ['{906F2B5A-9759-4CC8-B2B5-D9693E60778C}']
  end;
  TJContactsContract = class(TJavaGenericImport<JContactsContractClass, JContactsContract>) end;

  JContactsContract_AggregationExceptionsClass = interface(JObjectClass)
    ['{235B7BA0-F0C0-4283-9BC4-22ED73583C0C}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetRAW_CONTACT_ID1: JString; cdecl;
    {class} function _GetRAW_CONTACT_ID2: JString; cdecl;
    {class} function _GetTYPE: JString; cdecl;
    {class} function _GetTYPE_AUTOMATIC: Integer; cdecl;
    {class} function _GetTYPE_KEEP_SEPARATE: Integer; cdecl;
    {class} function _GetTYPE_KEEP_TOGETHER: Integer; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property RAW_CONTACT_ID1: JString read _GetRAW_CONTACT_ID1;
    {class} property RAW_CONTACT_ID2: JString read _GetRAW_CONTACT_ID2;
    {class} property &TYPE: JString read _GetTYPE;
    {class} property TYPE_AUTOMATIC: Integer read _GetTYPE_AUTOMATIC;
    {class} property TYPE_KEEP_SEPARATE: Integer read _GetTYPE_KEEP_SEPARATE;
    {class} property TYPE_KEEP_TOGETHER: Integer read _GetTYPE_KEEP_TOGETHER;
  end;

  [JavaSignature('android/provider/ContactsContract$AggregationExceptions')]
  JContactsContract_AggregationExceptions = interface(JObject)
    ['{4B9D218A-5020-456E-81AD-44960BF43B6A}']
  end;
  TJContactsContract_AggregationExceptions = class(TJavaGenericImport<JContactsContract_AggregationExceptionsClass, JContactsContract_AggregationExceptions>) end;

  JContactsContract_CommonDataKindsClass = interface(JObjectClass)
    ['{3B30D827-3181-426D-AB34-2E7F3BE8630C}']
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds')]
  JContactsContract_CommonDataKinds = interface(JObject)
    ['{563ED7E9-395F-4B5E-9653-57B10CA41BFB}']
  end;
  TJContactsContract_CommonDataKinds = class(TJavaGenericImport<JContactsContract_CommonDataKindsClass, JContactsContract_CommonDataKinds>) end;

  JCommonDataKinds_BaseTypesClass = interface(IJavaClass)
    ['{819B8EB6-DA73-4589-92AF-38EBBC858372}']
    {class} function _GetTYPE_CUSTOM: Integer; cdecl;
    {class} property TYPE_CUSTOM: Integer read _GetTYPE_CUSTOM;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$BaseTypes')]
  JCommonDataKinds_BaseTypes = interface(IJavaInstance)
    ['{73411F43-0F68-4EB0-B294-A28A3D7228E2}']
  end;
  TJCommonDataKinds_BaseTypes = class(TJavaGenericImport<JCommonDataKinds_BaseTypesClass, JCommonDataKinds_BaseTypes>) end;

  JCommonDataKinds_CallableClass = interface(JObjectClass)
    ['{52C83423-4BA6-4A5D-A7EE-69E2F65D9A38}']
    {class} function _GetCONTENT_FILTER_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function init: JCommonDataKinds_Callable; cdecl;
    {class} property CONTENT_FILTER_URI: Jnet_Uri read _GetCONTENT_FILTER_URI;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Callable')]
  JCommonDataKinds_Callable = interface(JObject)
    ['{83A5C710-3113-4800-A90D-009CF6B450E7}']
  end;
  TJCommonDataKinds_Callable = class(TJavaGenericImport<JCommonDataKinds_CallableClass, JCommonDataKinds_Callable>) end;

  JCommonDataKinds_ContactablesClass = interface(JObjectClass)
    ['{E1C366B7-8611-4667-AB59-A17E53BF262C}']
    {class} function _GetCONTENT_FILTER_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetVISIBLE_CONTACTS_ONLY: JString; cdecl;
    {class} function init: JCommonDataKinds_Contactables; cdecl;
    {class} property CONTENT_FILTER_URI: Jnet_Uri read _GetCONTENT_FILTER_URI;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property VISIBLE_CONTACTS_ONLY: JString read _GetVISIBLE_CONTACTS_ONLY;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Contactables')]
  JCommonDataKinds_Contactables = interface(JObject)
    ['{FD1F2079-E114-4AB4-B5CF-3315637CDD00}']
  end;
  TJCommonDataKinds_Contactables = class(TJavaGenericImport<JCommonDataKinds_ContactablesClass, JCommonDataKinds_Contactables>) end;

  JCommonDataKinds_EmailClass = interface(JObjectClass)
    ['{04DE5162-FD75-4DB3-BC26-F5431C853935}']
    {class} function _GetADDRESS: JString; cdecl;
    {class} function _GetCONTENT_FILTER_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_LOOKUP_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDISPLAY_NAME: JString; cdecl;
    {class} function _GetENTERPRISE_CONTENT_LOOKUP_URI: Jnet_Uri; cdecl;
    {class} function _GetTYPE_HOME: Integer; cdecl;
    {class} function _GetTYPE_MOBILE: Integer; cdecl;
    {class} function _GetTYPE_OTHER: Integer; cdecl;
    {class} function _GetTYPE_WORK: Integer; cdecl;
    {class} function getTypeLabel(res: JResources; type_: Integer; label_: JCharSequence): JCharSequence; cdecl;
    {class} function getTypeLabelResource(type_: Integer): Integer; cdecl;
    {class} property ADDRESS: JString read _GetADDRESS;
    {class} property CONTENT_FILTER_URI: Jnet_Uri read _GetCONTENT_FILTER_URI;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_LOOKUP_URI: Jnet_Uri read _GetCONTENT_LOOKUP_URI;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DISPLAY_NAME: JString read _GetDISPLAY_NAME;
    {class} property ENTERPRISE_CONTENT_LOOKUP_URI: Jnet_Uri read _GetENTERPRISE_CONTENT_LOOKUP_URI;
    {class} property TYPE_HOME: Integer read _GetTYPE_HOME;
    {class} property TYPE_MOBILE: Integer read _GetTYPE_MOBILE;
    {class} property TYPE_OTHER: Integer read _GetTYPE_OTHER;
    {class} property TYPE_WORK: Integer read _GetTYPE_WORK;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Email')]
  JCommonDataKinds_Email = interface(JObject)
    ['{E1AC9554-07BA-4399-8907-B92FA714B486}']
  end;
  TJCommonDataKinds_Email = class(TJavaGenericImport<JCommonDataKinds_EmailClass, JCommonDataKinds_Email>) end;

  JCommonDataKinds_EventClass = interface(JObjectClass)
    ['{2DD258B5-0F79-4BA8-B1D2-080AA0E1DC54}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetSTART_DATE: JString; cdecl;
    {class} function _GetTYPE_ANNIVERSARY: Integer; cdecl;
    {class} function _GetTYPE_BIRTHDAY: Integer; cdecl;
    {class} function _GetTYPE_OTHER: Integer; cdecl;
    {class} function getTypeLabel(res: JResources; type_: Integer; label_: JCharSequence): JCharSequence; cdecl;
    {class} function getTypeResource(type_: JInteger): Integer; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property START_DATE: JString read _GetSTART_DATE;
    {class} property TYPE_ANNIVERSARY: Integer read _GetTYPE_ANNIVERSARY;
    {class} property TYPE_BIRTHDAY: Integer read _GetTYPE_BIRTHDAY;
    {class} property TYPE_OTHER: Integer read _GetTYPE_OTHER;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Event')]
  JCommonDataKinds_Event = interface(JObject)
    ['{3F9DB079-4945-46C0-9D3E-53705F415401}']
  end;
  TJCommonDataKinds_Event = class(TJavaGenericImport<JCommonDataKinds_EventClass, JCommonDataKinds_Event>) end;

  JCommonDataKinds_GroupMembershipClass = interface(JObjectClass)
    ['{D88A5BF9-6278-4B5D-8E77-A63069118869}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetGROUP_ROW_ID: JString; cdecl;
    {class} function _GetGROUP_SOURCE_ID: JString; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property GROUP_ROW_ID: JString read _GetGROUP_ROW_ID;
    {class} property GROUP_SOURCE_ID: JString read _GetGROUP_SOURCE_ID;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$GroupMembership')]
  JCommonDataKinds_GroupMembership = interface(JObject)
    ['{E3EDD408-58E0-4623-AFC3-2B22AFB40EA4}']
  end;
  TJCommonDataKinds_GroupMembership = class(TJavaGenericImport<JCommonDataKinds_GroupMembershipClass, JCommonDataKinds_GroupMembership>) end;

  JCommonDataKinds_IdentityClass = interface(JObjectClass)
    ['{C3B1DA70-10FF-4B3C-9D64-A563B10F011A}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetIDENTITY: JString; cdecl;
    {class} function _GetNAMESPACE: JString; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property IDENTITY: JString read _GetIDENTITY;
    {class} property NAMESPACE: JString read _GetNAMESPACE;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Identity')]
  JCommonDataKinds_Identity = interface(JObject)
    ['{0B4C7B05-838D-4327-A2CF-80C35FD274C3}']
  end;
  TJCommonDataKinds_Identity = class(TJavaGenericImport<JCommonDataKinds_IdentityClass, JCommonDataKinds_Identity>) end;

  JCommonDataKinds_ImClass = interface(JObjectClass)
    ['{3BE10F94-DF30-4E24-9652-7E5AC7500A33}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCUSTOM_PROTOCOL: JString; cdecl;
    {class} function _GetPROTOCOL: JString; cdecl;
    {class} function _GetPROTOCOL_AIM: Integer; cdecl;
    {class} function _GetPROTOCOL_CUSTOM: Integer; cdecl;
    {class} function _GetPROTOCOL_GOOGLE_TALK: Integer; cdecl;
    {class} function _GetPROTOCOL_ICQ: Integer; cdecl;
    {class} function _GetPROTOCOL_JABBER: Integer; cdecl;
    {class} function _GetPROTOCOL_MSN: Integer; cdecl;
    {class} function _GetPROTOCOL_NETMEETING: Integer; cdecl;
    {class} function _GetPROTOCOL_QQ: Integer; cdecl;
    {class} function _GetPROTOCOL_SKYPE: Integer; cdecl;
    {class} function _GetPROTOCOL_YAHOO: Integer; cdecl;
    {class} function _GetTYPE_HOME: Integer; cdecl;
    {class} function _GetTYPE_OTHER: Integer; cdecl;
    {class} function _GetTYPE_WORK: Integer; cdecl;
    {class} function getProtocolLabel(res: JResources; type_: Integer; label_: JCharSequence): JCharSequence; cdecl;
    {class} function getProtocolLabelResource(type_: Integer): Integer; cdecl;
    {class} function getTypeLabel(res: JResources; type_: Integer; label_: JCharSequence): JCharSequence; cdecl;
    {class} function getTypeLabelResource(type_: Integer): Integer; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CUSTOM_PROTOCOL: JString read _GetCUSTOM_PROTOCOL;
    {class} property PROTOCOL: JString read _GetPROTOCOL;
    {class} property PROTOCOL_AIM: Integer read _GetPROTOCOL_AIM;
    {class} property PROTOCOL_CUSTOM: Integer read _GetPROTOCOL_CUSTOM;
    {class} property PROTOCOL_GOOGLE_TALK: Integer read _GetPROTOCOL_GOOGLE_TALK;
    {class} property PROTOCOL_ICQ: Integer read _GetPROTOCOL_ICQ;
    {class} property PROTOCOL_JABBER: Integer read _GetPROTOCOL_JABBER;
    {class} property PROTOCOL_MSN: Integer read _GetPROTOCOL_MSN;
    {class} property PROTOCOL_NETMEETING: Integer read _GetPROTOCOL_NETMEETING;
    {class} property PROTOCOL_QQ: Integer read _GetPROTOCOL_QQ;
    {class} property PROTOCOL_SKYPE: Integer read _GetPROTOCOL_SKYPE;
    {class} property PROTOCOL_YAHOO: Integer read _GetPROTOCOL_YAHOO;
    {class} property TYPE_HOME: Integer read _GetTYPE_HOME;
    {class} property TYPE_OTHER: Integer read _GetTYPE_OTHER;
    {class} property TYPE_WORK: Integer read _GetTYPE_WORK;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Im')]
  JCommonDataKinds_Im = interface(JObject)
    ['{3856508C-FFDF-4100-96F4-BECF719C7479}']
  end;
  TJCommonDataKinds_Im = class(TJavaGenericImport<JCommonDataKinds_ImClass, JCommonDataKinds_Im>) end;

  JCommonDataKinds_NicknameClass = interface(JObjectClass)
    ['{BC47785B-5605-4F0C-AB9B-86B1605ABDDC}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetNAME: JString; cdecl;
    {class} function _GetTYPE_DEFAULT: Integer; cdecl;
    {class} function _GetTYPE_INITIALS: Integer; cdecl;
    {class} function _GetTYPE_MAIDEN_NAME: Integer; cdecl;
    {class} function _GetTYPE_MAINDEN_NAME: Integer; cdecl;
    {class} function _GetTYPE_OTHER_NAME: Integer; cdecl;
    {class} function _GetTYPE_SHORT_NAME: Integer; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property NAME: JString read _GetNAME;
    {class} property TYPE_DEFAULT: Integer read _GetTYPE_DEFAULT;
    {class} property TYPE_INITIALS: Integer read _GetTYPE_INITIALS;
    {class} property TYPE_MAIDEN_NAME: Integer read _GetTYPE_MAIDEN_NAME;
    {class} property TYPE_MAINDEN_NAME: Integer read _GetTYPE_MAINDEN_NAME;
    {class} property TYPE_OTHER_NAME: Integer read _GetTYPE_OTHER_NAME;
    {class} property TYPE_SHORT_NAME: Integer read _GetTYPE_SHORT_NAME;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Nickname')]
  JCommonDataKinds_Nickname = interface(JObject)
    ['{3F2247FD-38FB-4830-9686-090B87EE3D8B}']
  end;
  TJCommonDataKinds_Nickname = class(TJavaGenericImport<JCommonDataKinds_NicknameClass, JCommonDataKinds_Nickname>) end;

  JCommonDataKinds_NoteClass = interface(JObjectClass)
    ['{64340864-E653-4857-879D-91B3BCC9FBE5}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetNOTE: JString; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property NOTE: JString read _GetNOTE;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Note')]
  JCommonDataKinds_Note = interface(JObject)
    ['{E8511BB9-03CF-44DD-A770-7769DFB2FAA1}']
  end;
  TJCommonDataKinds_Note = class(TJavaGenericImport<JCommonDataKinds_NoteClass, JCommonDataKinds_Note>) end;

  JCommonDataKinds_OrganizationClass = interface(JObjectClass)
    ['{FFBF559E-7463-43F7-86DA-A2D66F987D92}']
    {class} function _GetCOMPANY: JString; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetDEPARTMENT: JString; cdecl;
    {class} function _GetJOB_DESCRIPTION: JString; cdecl;
    {class} function _GetOFFICE_LOCATION: JString; cdecl;
    {class} function _GetPHONETIC_NAME: JString; cdecl;
    {class} function _GetSYMBOL: JString; cdecl;
    {class} function _GetTITLE: JString; cdecl;
    {class} function _GetTYPE_OTHER: Integer; cdecl;
    {class} function _GetTYPE_WORK: Integer; cdecl;
    {class} function getTypeLabel(res: JResources; type_: Integer; label_: JCharSequence): JCharSequence; cdecl;
    {class} function getTypeLabelResource(type_: Integer): Integer; cdecl;
    {class} property COMPANY: JString read _GetCOMPANY;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property DEPARTMENT: JString read _GetDEPARTMENT;
    {class} property JOB_DESCRIPTION: JString read _GetJOB_DESCRIPTION;
    {class} property OFFICE_LOCATION: JString read _GetOFFICE_LOCATION;
    {class} property PHONETIC_NAME: JString read _GetPHONETIC_NAME;
    {class} property SYMBOL: JString read _GetSYMBOL;
    {class} property TITLE: JString read _GetTITLE;
    {class} property TYPE_OTHER: Integer read _GetTYPE_OTHER;
    {class} property TYPE_WORK: Integer read _GetTYPE_WORK;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Organization')]
  JCommonDataKinds_Organization = interface(JObject)
    ['{64CCF643-55DA-4D5E-89BC-45B6B9581FEE}']
  end;
  TJCommonDataKinds_Organization = class(TJavaGenericImport<JCommonDataKinds_OrganizationClass, JCommonDataKinds_Organization>) end;

  JCommonDataKinds_PhoneClass = interface(JObjectClass)
    ['{26C70162-6E79-45BB-9BE5-6C1EF293FD07}']
    {class} function _GetCONTENT_FILTER_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetNORMALIZED_NUMBER: JString; cdecl;
    {class} function _GetNUMBER: JString; cdecl;
    {class} function _GetSEARCH_DISPLAY_NAME_KEY: JString; cdecl;
    {class} function _GetSEARCH_PHONE_NUMBER_KEY: JString; cdecl;
    {class} function _GetTYPE_ASSISTANT: Integer; cdecl;
    {class} function _GetTYPE_CALLBACK: Integer; cdecl;
    {class} function _GetTYPE_CAR: Integer; cdecl;
    {class} function _GetTYPE_COMPANY_MAIN: Integer; cdecl;
    {class} function _GetTYPE_FAX_HOME: Integer; cdecl;
    {class} function _GetTYPE_FAX_WORK: Integer; cdecl;
    {class} function _GetTYPE_HOME: Integer; cdecl;
    {class} function _GetTYPE_ISDN: Integer; cdecl;
    {class} function _GetTYPE_MAIN: Integer; cdecl;
    {class} function _GetTYPE_MMS: Integer; cdecl;
    {class} function _GetTYPE_MOBILE: Integer; cdecl;
    {class} function _GetTYPE_OTHER: Integer; cdecl;
    {class} function _GetTYPE_OTHER_FAX: Integer; cdecl;
    {class} function _GetTYPE_PAGER: Integer; cdecl;
    {class} function _GetTYPE_RADIO: Integer; cdecl;
    {class} function _GetTYPE_TELEX: Integer; cdecl;
    {class} function _GetTYPE_TTY_TDD: Integer; cdecl;
    {class} function _GetTYPE_WORK: Integer; cdecl;
    {class} function _GetTYPE_WORK_MOBILE: Integer; cdecl;
    {class} function _GetTYPE_WORK_PAGER: Integer; cdecl;
    {class} function getTypeLabel(res: JResources; type_: Integer; label_: JCharSequence): JCharSequence; cdecl;
    {class} function getTypeLabelResource(type_: Integer): Integer; cdecl;
    {class} property CONTENT_FILTER_URI: Jnet_Uri read _GetCONTENT_FILTER_URI;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property NORMALIZED_NUMBER: JString read _GetNORMALIZED_NUMBER;
    {class} property NUMBER: JString read _GetNUMBER;
    {class} property SEARCH_DISPLAY_NAME_KEY: JString read _GetSEARCH_DISPLAY_NAME_KEY;
    {class} property SEARCH_PHONE_NUMBER_KEY: JString read _GetSEARCH_PHONE_NUMBER_KEY;
    {class} property TYPE_ASSISTANT: Integer read _GetTYPE_ASSISTANT;
    {class} property TYPE_CALLBACK: Integer read _GetTYPE_CALLBACK;
    {class} property TYPE_CAR: Integer read _GetTYPE_CAR;
    {class} property TYPE_COMPANY_MAIN: Integer read _GetTYPE_COMPANY_MAIN;
    {class} property TYPE_FAX_HOME: Integer read _GetTYPE_FAX_HOME;
    {class} property TYPE_FAX_WORK: Integer read _GetTYPE_FAX_WORK;
    {class} property TYPE_HOME: Integer read _GetTYPE_HOME;
    {class} property TYPE_ISDN: Integer read _GetTYPE_ISDN;
    {class} property TYPE_MAIN: Integer read _GetTYPE_MAIN;
    {class} property TYPE_MMS: Integer read _GetTYPE_MMS;
    {class} property TYPE_MOBILE: Integer read _GetTYPE_MOBILE;
    {class} property TYPE_OTHER: Integer read _GetTYPE_OTHER;
    {class} property TYPE_OTHER_FAX: Integer read _GetTYPE_OTHER_FAX;
    {class} property TYPE_PAGER: Integer read _GetTYPE_PAGER;
    {class} property TYPE_RADIO: Integer read _GetTYPE_RADIO;
    {class} property TYPE_TELEX: Integer read _GetTYPE_TELEX;
    {class} property TYPE_TTY_TDD: Integer read _GetTYPE_TTY_TDD;
    {class} property TYPE_WORK: Integer read _GetTYPE_WORK;
    {class} property TYPE_WORK_MOBILE: Integer read _GetTYPE_WORK_MOBILE;
    {class} property TYPE_WORK_PAGER: Integer read _GetTYPE_WORK_PAGER;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Phone')]
  JCommonDataKinds_Phone = interface(JObject)
    ['{B3BC4EC6-2FEB-4F10-9D45-275FDE754A78}']
  end;
  TJCommonDataKinds_Phone = class(TJavaGenericImport<JCommonDataKinds_PhoneClass, JCommonDataKinds_Phone>) end;

  JCommonDataKinds_PhotoClass = interface(JObjectClass)
    ['{DB6F4109-261D-4991-A976-4B785F2D5F53}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetPHOTO: JString; cdecl;
    {class} function _GetPHOTO_FILE_ID: JString; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property PHOTO: JString read _GetPHOTO;
    {class} property PHOTO_FILE_ID: JString read _GetPHOTO_FILE_ID;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Photo')]
  JCommonDataKinds_Photo = interface(JObject)
    ['{967ABFE6-3015-4455-9C76-618C9422689D}']
  end;
  TJCommonDataKinds_Photo = class(TJavaGenericImport<JCommonDataKinds_PhotoClass, JCommonDataKinds_Photo>) end;

  JCommonDataKinds_RelationClass = interface(JObjectClass)
    ['{010209B7-605E-4193-86C8-20E4DACCAA34}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetNAME: JString; cdecl;
    {class} function _GetTYPE_ASSISTANT: Integer; cdecl;
    {class} function _GetTYPE_BROTHER: Integer; cdecl;
    {class} function _GetTYPE_CHILD: Integer; cdecl;
    {class} function _GetTYPE_DOMESTIC_PARTNER: Integer; cdecl;
    {class} function _GetTYPE_FATHER: Integer; cdecl;
    {class} function _GetTYPE_FRIEND: Integer; cdecl;
    {class} function _GetTYPE_MANAGER: Integer; cdecl;
    {class} function _GetTYPE_MOTHER: Integer; cdecl;
    {class} function _GetTYPE_PARENT: Integer; cdecl;
    {class} function _GetTYPE_PARTNER: Integer; cdecl;
    {class} function _GetTYPE_REFERRED_BY: Integer; cdecl;
    {class} function _GetTYPE_RELATIVE: Integer; cdecl;
    {class} function _GetTYPE_SISTER: Integer; cdecl;
    {class} function _GetTYPE_SPOUSE: Integer; cdecl;
    {class} function getTypeLabel(res: JResources; type_: Integer; label_: JCharSequence): JCharSequence; cdecl;
    {class} function getTypeLabelResource(type_: Integer): Integer; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property NAME: JString read _GetNAME;
    {class} property TYPE_ASSISTANT: Integer read _GetTYPE_ASSISTANT;
    {class} property TYPE_BROTHER: Integer read _GetTYPE_BROTHER;
    {class} property TYPE_CHILD: Integer read _GetTYPE_CHILD;
    {class} property TYPE_DOMESTIC_PARTNER: Integer read _GetTYPE_DOMESTIC_PARTNER;
    {class} property TYPE_FATHER: Integer read _GetTYPE_FATHER;
    {class} property TYPE_FRIEND: Integer read _GetTYPE_FRIEND;
    {class} property TYPE_MANAGER: Integer read _GetTYPE_MANAGER;
    {class} property TYPE_MOTHER: Integer read _GetTYPE_MOTHER;
    {class} property TYPE_PARENT: Integer read _GetTYPE_PARENT;
    {class} property TYPE_PARTNER: Integer read _GetTYPE_PARTNER;
    {class} property TYPE_REFERRED_BY: Integer read _GetTYPE_REFERRED_BY;
    {class} property TYPE_RELATIVE: Integer read _GetTYPE_RELATIVE;
    {class} property TYPE_SISTER: Integer read _GetTYPE_SISTER;
    {class} property TYPE_SPOUSE: Integer read _GetTYPE_SPOUSE;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Relation')]
  JCommonDataKinds_Relation = interface(JObject)
    ['{61EC4712-3967-49D6-B267-534F68E726AF}']
  end;
  TJCommonDataKinds_Relation = class(TJavaGenericImport<JCommonDataKinds_RelationClass, JCommonDataKinds_Relation>) end;

  JCommonDataKinds_SipAddressClass = interface(JObjectClass)
    ['{80EDB7D1-1410-41F1-99B1-62711133DD8C}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetSIP_ADDRESS: JString; cdecl;
    {class} function _GetTYPE_HOME: Integer; cdecl;
    {class} function _GetTYPE_OTHER: Integer; cdecl;
    {class} function _GetTYPE_WORK: Integer; cdecl;
    {class} function getTypeLabel(res: JResources; type_: Integer; label_: JCharSequence): JCharSequence; cdecl;
    {class} function getTypeLabelResource(type_: Integer): Integer; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property SIP_ADDRESS: JString read _GetSIP_ADDRESS;
    {class} property TYPE_HOME: Integer read _GetTYPE_HOME;
    {class} property TYPE_OTHER: Integer read _GetTYPE_OTHER;
    {class} property TYPE_WORK: Integer read _GetTYPE_WORK;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$SipAddress')]
  JCommonDataKinds_SipAddress = interface(JObject)
    ['{A14B21AA-B8CC-404C-85FA-2B34F0A8C064}']
  end;
  TJCommonDataKinds_SipAddress = class(TJavaGenericImport<JCommonDataKinds_SipAddressClass, JCommonDataKinds_SipAddress>) end;

  JCommonDataKinds_StructuredNameClass = interface(JObjectClass)
    ['{F784BAC1-A531-4018-8FCA-A37D5DEB6B3D}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetDISPLAY_NAME: JString; cdecl;
    {class} function _GetFAMILY_NAME: JString; cdecl;
    {class} function _GetFULL_NAME_STYLE: JString; cdecl;
    {class} function _GetGIVEN_NAME: JString; cdecl;
    {class} function _GetMIDDLE_NAME: JString; cdecl;
    {class} function _GetPHONETIC_FAMILY_NAME: JString; cdecl;
    {class} function _GetPHONETIC_GIVEN_NAME: JString; cdecl;
    {class} function _GetPHONETIC_MIDDLE_NAME: JString; cdecl;
    {class} function _GetPREFIX: JString; cdecl;
    {class} function _GetSUFFIX: JString; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property DISPLAY_NAME: JString read _GetDISPLAY_NAME;
    {class} property FAMILY_NAME: JString read _GetFAMILY_NAME;
    {class} property FULL_NAME_STYLE: JString read _GetFULL_NAME_STYLE;
    {class} property GIVEN_NAME: JString read _GetGIVEN_NAME;
    {class} property MIDDLE_NAME: JString read _GetMIDDLE_NAME;
    {class} property PHONETIC_FAMILY_NAME: JString read _GetPHONETIC_FAMILY_NAME;
    {class} property PHONETIC_GIVEN_NAME: JString read _GetPHONETIC_GIVEN_NAME;
    {class} property PHONETIC_MIDDLE_NAME: JString read _GetPHONETIC_MIDDLE_NAME;
    {class} property PREFIX: JString read _GetPREFIX;
    {class} property SUFFIX: JString read _GetSUFFIX;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$StructuredName')]
  JCommonDataKinds_StructuredName = interface(JObject)
    ['{94F6949A-A527-4FF2-97D3-0A214660CFDD}']
  end;
  TJCommonDataKinds_StructuredName = class(TJavaGenericImport<JCommonDataKinds_StructuredNameClass, JCommonDataKinds_StructuredName>) end;

  JCommonDataKinds_StructuredPostalClass = interface(JObjectClass)
    ['{B3118CAC-F54A-4BAF-9B70-46C347F1B282}']
    {class} function _GetCITY: JString; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetCOUNTRY: JString; cdecl;
    {class} function _GetFORMATTED_ADDRESS: JString; cdecl;
    {class} function _GetNEIGHBORHOOD: JString; cdecl;
    {class} function _GetPOBOX: JString; cdecl;
    {class} function _GetPOSTCODE: JString; cdecl;
    {class} function _GetREGION: JString; cdecl;
    {class} function _GetSTREET: JString; cdecl;
    {class} function _GetTYPE_HOME: Integer; cdecl;
    {class} function _GetTYPE_OTHER: Integer; cdecl;
    {class} function _GetTYPE_WORK: Integer; cdecl;
    {class} function getTypeLabel(res: JResources; type_: Integer; label_: JCharSequence): JCharSequence; cdecl;
    {class} function getTypeLabelResource(type_: Integer): Integer; cdecl;
    {class} property CITY: JString read _GetCITY;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property COUNTRY: JString read _GetCOUNTRY;
    {class} property FORMATTED_ADDRESS: JString read _GetFORMATTED_ADDRESS;
    {class} property NEIGHBORHOOD: JString read _GetNEIGHBORHOOD;
    {class} property POBOX: JString read _GetPOBOX;
    {class} property POSTCODE: JString read _GetPOSTCODE;
    {class} property REGION: JString read _GetREGION;
    {class} property STREET: JString read _GetSTREET;
    {class} property TYPE_HOME: Integer read _GetTYPE_HOME;
    {class} property TYPE_OTHER: Integer read _GetTYPE_OTHER;
    {class} property TYPE_WORK: Integer read _GetTYPE_WORK;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$StructuredPostal')]
  JCommonDataKinds_StructuredPostal = interface(JObject)
    ['{8A5E45CA-E950-489E-98D9-79C21BB9C9AA}']
  end;
  TJCommonDataKinds_StructuredPostal = class(TJavaGenericImport<JCommonDataKinds_StructuredPostalClass, JCommonDataKinds_StructuredPostal>) end;

  JCommonDataKinds_WebsiteClass = interface(JObjectClass)
    ['{FE9A4E27-0823-4810-A23F-C500700DF6E6}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetTYPE_BLOG: Integer; cdecl;
    {class} function _GetTYPE_FTP: Integer; cdecl;
    {class} function _GetTYPE_HOME: Integer; cdecl;
    {class} function _GetTYPE_HOMEPAGE: Integer; cdecl;
    {class} function _GetTYPE_OTHER: Integer; cdecl;
    {class} function _GetTYPE_PROFILE: Integer; cdecl;
    {class} function _GetTYPE_WORK: Integer; cdecl;
    {class} function _GetURL: JString; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property TYPE_BLOG: Integer read _GetTYPE_BLOG;
    {class} property TYPE_FTP: Integer read _GetTYPE_FTP;
    {class} property TYPE_HOME: Integer read _GetTYPE_HOME;
    {class} property TYPE_HOMEPAGE: Integer read _GetTYPE_HOMEPAGE;
    {class} property TYPE_OTHER: Integer read _GetTYPE_OTHER;
    {class} property TYPE_PROFILE: Integer read _GetTYPE_PROFILE;
    {class} property TYPE_WORK: Integer read _GetTYPE_WORK;
    {class} property URL: JString read _GetURL;
  end;

  [JavaSignature('android/provider/ContactsContract$CommonDataKinds$Website')]
  JCommonDataKinds_Website = interface(JObject)
    ['{CB6FDE41-ED22-4AD6-AAFA-C0A2BAC0EF21}']
  end;
  TJCommonDataKinds_Website = class(TJavaGenericImport<JCommonDataKinds_WebsiteClass, JCommonDataKinds_Website>) end;

  JContactsContract_ContactsClass = interface(JObjectClass)
    ['{3BA68A03-57B0-426D-B452-93635322BBDE}']
    {class} function _GetCONTENT_FILTER_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_FREQUENT_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_GROUP_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_LOOKUP_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_MULTI_VCARD_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_STREQUENT_FILTER_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_STREQUENT_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_VCARD_TYPE: JString; cdecl;
    {class} function _GetCONTENT_VCARD_URI: Jnet_Uri; cdecl;
    {class} function _GetQUERY_PARAMETER_VCARD_NO_PHOTO: JString; cdecl;
    {class} function getLookupUri(resolver: JContentResolver; contactUri: Jnet_Uri): Jnet_Uri; cdecl; overload;
    {class} function getLookupUri(contactId: Int64; lookupKey: JString): Jnet_Uri; cdecl; overload;
    {class} function isEnterpriseContactId(contactId: Int64): Boolean; cdecl;
    {class} function lookupContact(resolver: JContentResolver; lookupUri: Jnet_Uri): Jnet_Uri; cdecl;
    {class} procedure markAsContacted(resolver: JContentResolver; contactId: Int64); cdecl;//Deprecated
    {class} function openContactPhotoInputStream(cr: JContentResolver; contactUri: Jnet_Uri; preferHighres: Boolean): JInputStream; cdecl; overload;
    {class} function openContactPhotoInputStream(cr: JContentResolver; contactUri: Jnet_Uri): JInputStream; cdecl; overload;
    {class} property CONTENT_FILTER_URI: Jnet_Uri read _GetCONTENT_FILTER_URI;
    {class} property CONTENT_FREQUENT_URI: Jnet_Uri read _GetCONTENT_FREQUENT_URI;
    {class} property CONTENT_GROUP_URI: Jnet_Uri read _GetCONTENT_GROUP_URI;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_LOOKUP_URI: Jnet_Uri read _GetCONTENT_LOOKUP_URI;
    {class} property CONTENT_MULTI_VCARD_URI: Jnet_Uri read _GetCONTENT_MULTI_VCARD_URI;
    {class} property CONTENT_STREQUENT_FILTER_URI: Jnet_Uri read _GetCONTENT_STREQUENT_FILTER_URI;
    {class} property CONTENT_STREQUENT_URI: Jnet_Uri read _GetCONTENT_STREQUENT_URI;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property CONTENT_VCARD_TYPE: JString read _GetCONTENT_VCARD_TYPE;
    {class} property CONTENT_VCARD_URI: Jnet_Uri read _GetCONTENT_VCARD_URI;
    {class} property QUERY_PARAMETER_VCARD_NO_PHOTO: JString read _GetQUERY_PARAMETER_VCARD_NO_PHOTO;
  end;

  [JavaSignature('android/provider/ContactsContract$Contacts')]
  JContactsContract_Contacts = interface(JObject)
    ['{F174D654-2BBC-4854-BB3A-23F403CE38D8}']
  end;
  TJContactsContract_Contacts = class(TJavaGenericImport<JContactsContract_ContactsClass, JContactsContract_Contacts>) end;

  JContacts_AggregationSuggestionsClass = interface(JObjectClass)
    ['{9893192B-8FB2-431D-854E-4093F6197FFC}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
  end;

  [JavaSignature('android/provider/ContactsContract$Contacts$AggregationSuggestions')]
  JContacts_AggregationSuggestions = interface(JObject)
    ['{CF42AF54-D723-4D78-9131-5A0A0F5CE081}']
  end;
  TJContacts_AggregationSuggestions = class(TJavaGenericImport<JContacts_AggregationSuggestionsClass, JContacts_AggregationSuggestions>) end;

  JAggregationSuggestions_BuilderClass = interface(JObjectClass)
    ['{F3584D53-C4F2-454B-98C0-8CF7561D4423}']
    {class} function init: JAggregationSuggestions_Builder; cdecl;
  end;

  [JavaSignature('android/provider/ContactsContract$Contacts$AggregationSuggestions$Builder')]
  JAggregationSuggestions_Builder = interface(JObject)
    ['{DFD8C009-6D1C-401B-B8A9-03BAA1413C8A}']
    function addNameParameter(name: JString): JAggregationSuggestions_Builder; cdecl;
    function build: Jnet_Uri; cdecl;
    function setContactId(contactId: Int64): JAggregationSuggestions_Builder; cdecl;
    function setLimit(limit: Integer): JAggregationSuggestions_Builder; cdecl;
  end;
  TJAggregationSuggestions_Builder = class(TJavaGenericImport<JAggregationSuggestions_BuilderClass, JAggregationSuggestions_Builder>) end;

  JContacts_DataClass = interface(JObjectClass)
    ['{8975D2D1-26B6-45B3-BCB6-DDEFA37947A4}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
  end;

  [JavaSignature('android/provider/ContactsContract$Contacts$Data')]
  JContacts_Data = interface(JObject)
    ['{4339CD6A-21C0-4A45-B5C0-A35F80BDDA1C}']
  end;
  TJContacts_Data = class(TJavaGenericImport<JContacts_DataClass, JContacts_Data>) end;

  JContacts_EntityClass = interface(JObjectClass)
    ['{0E60DA08-DCE1-4876-8F1A-30ADCC551FC1}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetDATA_ID: JString; cdecl;
    {class} function _GetRAW_CONTACT_ID: JString; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property DATA_ID: JString read _GetDATA_ID;
    {class} property RAW_CONTACT_ID: JString read _GetRAW_CONTACT_ID;
  end;

  [JavaSignature('android/provider/ContactsContract$Contacts$Entity')]
  JContacts_Entity = interface(JObject)
    ['{E0F3068A-8287-4080-BA0B-A716EEF40A69}']
  end;
  TJContacts_Entity = class(TJavaGenericImport<JContacts_EntityClass, JContacts_Entity>) end;

  JContacts_PhotoClass = interface(JObjectClass)
    ['{090384EF-4948-44BF-872A-1C059D2FF535}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetDISPLAY_PHOTO: JString; cdecl;
    {class} function _GetPHOTO: JString; cdecl;
    {class} function _GetPHOTO_FILE_ID: JString; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property DISPLAY_PHOTO: JString read _GetDISPLAY_PHOTO;
    {class} property PHOTO: JString read _GetPHOTO;
    {class} property PHOTO_FILE_ID: JString read _GetPHOTO_FILE_ID;
  end;

  [JavaSignature('android/provider/ContactsContract$Contacts$Photo')]
  JContacts_Photo = interface(JObject)
    ['{DFDAEDC0-B587-4AFA-81C5-1AE7AEED9E9E}']
  end;
  TJContacts_Photo = class(TJavaGenericImport<JContacts_PhotoClass, JContacts_Photo>) end;

  JContactsContract_DataClass = interface(JObjectClass)
    ['{9144ECE7-6E2F-4A08-A26F-B790DB083635}']
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetVISIBLE_CONTACTS_ONLY: JString; cdecl;
    {class} function getContactLookupUri(resolver: JContentResolver; dataUri: Jnet_Uri): Jnet_Uri; cdecl;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property VISIBLE_CONTACTS_ONLY: JString read _GetVISIBLE_CONTACTS_ONLY;
  end;

  [JavaSignature('android/provider/ContactsContract$Data')]
  JContactsContract_Data = interface(JObject)
    ['{B149289E-DE66-4F78-BE4A-E7236D4FF10B}']
  end;
  TJContactsContract_Data = class(TJavaGenericImport<JContactsContract_DataClass, JContactsContract_Data>) end;

  JContactsContract_DataUsageFeedbackClass = interface(JObjectClass)
    ['{E10A91B1-9740-49BC-A38D-CA014866272E}']
    {class} function _GetDELETE_USAGE_URI: Jnet_Uri; cdecl;
    {class} function _GetFEEDBACK_URI: Jnet_Uri; cdecl;
    {class} function _GetUSAGE_TYPE: JString; cdecl;
    {class} function _GetUSAGE_TYPE_CALL: JString; cdecl;
    {class} function _GetUSAGE_TYPE_LONG_TEXT: JString; cdecl;
    {class} function _GetUSAGE_TYPE_SHORT_TEXT: JString; cdecl;
    {class} function init: JContactsContract_DataUsageFeedback; cdecl;
    {class} property DELETE_USAGE_URI: Jnet_Uri read _GetDELETE_USAGE_URI;
    {class} property FEEDBACK_URI: Jnet_Uri read _GetFEEDBACK_URI;
    {class} property USAGE_TYPE: JString read _GetUSAGE_TYPE;
    {class} property USAGE_TYPE_CALL: JString read _GetUSAGE_TYPE_CALL;
    {class} property USAGE_TYPE_LONG_TEXT: JString read _GetUSAGE_TYPE_LONG_TEXT;
    {class} property USAGE_TYPE_SHORT_TEXT: JString read _GetUSAGE_TYPE_SHORT_TEXT;
  end;

  [JavaSignature('android/provider/ContactsContract$DataUsageFeedback')]
  JContactsContract_DataUsageFeedback = interface(JObject)
    ['{CC44D7E3-874C-4E91-8C19-FAFA86384392}']
  end;
  TJContactsContract_DataUsageFeedback = class(TJavaGenericImport<JContactsContract_DataUsageFeedbackClass, JContactsContract_DataUsageFeedback>) end;

  JContactsContract_DeletedContactsClass = interface(JObjectClass)
    ['{B8226F10-ED20-456F-9740-136C61DFF45F}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDAYS_KEPT_MILLISECONDS: Int64; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DAYS_KEPT_MILLISECONDS: Int64 read _GetDAYS_KEPT_MILLISECONDS;
  end;

  [JavaSignature('android/provider/ContactsContract$DeletedContacts')]
  JContactsContract_DeletedContacts = interface(JObject)
    ['{758F8E4C-4069-4340-A693-2416B8626D42}']
  end;
  TJContactsContract_DeletedContacts = class(TJavaGenericImport<JContactsContract_DeletedContactsClass, JContactsContract_DeletedContacts>) end;

  JContactsContract_DirectoryClass = interface(JObjectClass)
    ['{6E43711D-2668-4932-8010-D5FB9B363AAE}']
    {class} function _GetACCOUNT_NAME: JString; cdecl;
    {class} function _GetACCOUNT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT: Int64; cdecl;
    {class} function _GetDIRECTORY_AUTHORITY: JString; cdecl;
    {class} function _GetDISPLAY_NAME: JString; cdecl;
    {class} function _GetEXPORT_SUPPORT: JString; cdecl;
    {class} function _GetEXPORT_SUPPORT_ANY_ACCOUNT: Integer; cdecl;
    {class} function _GetEXPORT_SUPPORT_NONE: Integer; cdecl;
    {class} function _GetEXPORT_SUPPORT_SAME_ACCOUNT_ONLY: Integer; cdecl;
    {class} function _GetLOCAL_INVISIBLE: Int64; cdecl;
    {class} function _GetPACKAGE_NAME: JString; cdecl;
    {class} function _GetPHOTO_SUPPORT: JString; cdecl;
    {class} function _GetPHOTO_SUPPORT_FULL: Integer; cdecl;
    {class} function _GetPHOTO_SUPPORT_FULL_SIZE_ONLY: Integer; cdecl;
    {class} function _GetPHOTO_SUPPORT_NONE: Integer; cdecl;
    {class} function _GetPHOTO_SUPPORT_THUMBNAIL_ONLY: Integer; cdecl;
    {class} function _GetSHORTCUT_SUPPORT: JString; cdecl;
    {class} function _GetSHORTCUT_SUPPORT_DATA_ITEMS_ONLY: Integer; cdecl;
    {class} function _GetSHORTCUT_SUPPORT_FULL: Integer; cdecl;
    {class} function _GetSHORTCUT_SUPPORT_NONE: Integer; cdecl;
    {class} function _GetTYPE_RESOURCE_ID: JString; cdecl;
    {class} procedure notifyDirectoryChange(resolver: JContentResolver); cdecl;
    {class} property ACCOUNT_NAME: JString read _GetACCOUNT_NAME;
    {class} property ACCOUNT_TYPE: JString read _GetACCOUNT_TYPE;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT: Int64 read _GetDEFAULT;
    {class} property DIRECTORY_AUTHORITY: JString read _GetDIRECTORY_AUTHORITY;
    {class} property DISPLAY_NAME: JString read _GetDISPLAY_NAME;
    {class} property EXPORT_SUPPORT: JString read _GetEXPORT_SUPPORT;
    {class} property EXPORT_SUPPORT_ANY_ACCOUNT: Integer read _GetEXPORT_SUPPORT_ANY_ACCOUNT;
    {class} property EXPORT_SUPPORT_NONE: Integer read _GetEXPORT_SUPPORT_NONE;
    {class} property EXPORT_SUPPORT_SAME_ACCOUNT_ONLY: Integer read _GetEXPORT_SUPPORT_SAME_ACCOUNT_ONLY;
    {class} property LOCAL_INVISIBLE: Int64 read _GetLOCAL_INVISIBLE;
    {class} property PACKAGE_NAME: JString read _GetPACKAGE_NAME;
    {class} property PHOTO_SUPPORT: JString read _GetPHOTO_SUPPORT;
    {class} property PHOTO_SUPPORT_FULL: Integer read _GetPHOTO_SUPPORT_FULL;
    {class} property PHOTO_SUPPORT_FULL_SIZE_ONLY: Integer read _GetPHOTO_SUPPORT_FULL_SIZE_ONLY;
    {class} property PHOTO_SUPPORT_NONE: Integer read _GetPHOTO_SUPPORT_NONE;
    {class} property PHOTO_SUPPORT_THUMBNAIL_ONLY: Integer read _GetPHOTO_SUPPORT_THUMBNAIL_ONLY;
    {class} property SHORTCUT_SUPPORT: JString read _GetSHORTCUT_SUPPORT;
    {class} property SHORTCUT_SUPPORT_DATA_ITEMS_ONLY: Integer read _GetSHORTCUT_SUPPORT_DATA_ITEMS_ONLY;
    {class} property SHORTCUT_SUPPORT_FULL: Integer read _GetSHORTCUT_SUPPORT_FULL;
    {class} property SHORTCUT_SUPPORT_NONE: Integer read _GetSHORTCUT_SUPPORT_NONE;
    {class} property TYPE_RESOURCE_ID: JString read _GetTYPE_RESOURCE_ID;
  end;

  [JavaSignature('android/provider/ContactsContract$Directory')]
  JContactsContract_Directory = interface(JObject)
    ['{B39A38F0-64A3-4CF6-A9D8-3463C165954D}']
  end;
  TJContactsContract_Directory = class(TJavaGenericImport<JContactsContract_DirectoryClass, JContactsContract_Directory>) end;

  JContactsContract_DisplayNameSourcesClass = interface(IJavaClass)
    ['{4DB9FB24-F2D2-4E1B-859D-2928196E6FD1}']
    {class} function _GetEMAIL: Integer; cdecl;
    {class} function _GetNICKNAME: Integer; cdecl;
    {class} function _GetORGANIZATION: Integer; cdecl;
    {class} function _GetPHONE: Integer; cdecl;
    {class} function _GetSTRUCTURED_NAME: Integer; cdecl;
    {class} function _GetSTRUCTURED_PHONETIC_NAME: Integer; cdecl;
    {class} function _GetUNDEFINED: Integer; cdecl;
    {class} property EMAIL: Integer read _GetEMAIL;
    {class} property NICKNAME: Integer read _GetNICKNAME;
    {class} property ORGANIZATION: Integer read _GetORGANIZATION;
    {class} property PHONE: Integer read _GetPHONE;
    {class} property STRUCTURED_NAME: Integer read _GetSTRUCTURED_NAME;
    {class} property STRUCTURED_PHONETIC_NAME: Integer read _GetSTRUCTURED_PHONETIC_NAME;
    {class} property UNDEFINED: Integer read _GetUNDEFINED;
  end;

  [JavaSignature('android/provider/ContactsContract$DisplayNameSources')]
  JContactsContract_DisplayNameSources = interface(IJavaInstance)
    ['{3EB81D20-435B-4001-B1DA-3E218F014458}']
  end;
  TJContactsContract_DisplayNameSources = class(TJavaGenericImport<JContactsContract_DisplayNameSourcesClass, JContactsContract_DisplayNameSources>) end;

  JContactsContract_DisplayPhotoClass = interface(JObjectClass)
    ['{2F313095-DDD3-4C10-861E-B0E5208A6CFA}']
    {class} function _GetCONTENT_MAX_DIMENSIONS_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDISPLAY_MAX_DIM: JString; cdecl;
    {class} function _GetTHUMBNAIL_MAX_DIM: JString; cdecl;
    {class} property CONTENT_MAX_DIMENSIONS_URI: Jnet_Uri read _GetCONTENT_MAX_DIMENSIONS_URI;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DISPLAY_MAX_DIM: JString read _GetDISPLAY_MAX_DIM;
    {class} property THUMBNAIL_MAX_DIM: JString read _GetTHUMBNAIL_MAX_DIM;
  end;

  [JavaSignature('android/provider/ContactsContract$DisplayPhoto')]
  JContactsContract_DisplayPhoto = interface(JObject)
    ['{6961D3C7-ACAE-4FAC-8C4C-4866924849AB}']
  end;
  TJContactsContract_DisplayPhoto = class(TJavaGenericImport<JContactsContract_DisplayPhotoClass, JContactsContract_DisplayPhoto>) end;

  JContactsContract_FullNameStyleClass = interface(IJavaClass)
    ['{C4D11ABF-9A3E-4AD8-A8BD-FC2943ED20B9}']
    {class} function _GetCHINESE: Integer; cdecl;
    {class} function _GetCJK: Integer; cdecl;
    {class} function _GetJAPANESE: Integer; cdecl;
    {class} function _GetKOREAN: Integer; cdecl;
    {class} function _GetUNDEFINED: Integer; cdecl;
    {class} function _GetWESTERN: Integer; cdecl;
    {class} property CHINESE: Integer read _GetCHINESE;
    {class} property CJK: Integer read _GetCJK;
    {class} property JAPANESE: Integer read _GetJAPANESE;
    {class} property KOREAN: Integer read _GetKOREAN;
    {class} property UNDEFINED: Integer read _GetUNDEFINED;
    {class} property WESTERN: Integer read _GetWESTERN;
  end;

  [JavaSignature('android/provider/ContactsContract$FullNameStyle')]
  JContactsContract_FullNameStyle = interface(IJavaInstance)
    ['{3E6883E0-BF39-4589-B1F9-4A2D261FF009}']
  end;
  TJContactsContract_FullNameStyle = class(TJavaGenericImport<JContactsContract_FullNameStyleClass, JContactsContract_FullNameStyle>) end;

  JContactsContract_GroupsClass = interface(JObjectClass)
    ['{8BAC9601-BC22-441B-90A1-57E326B97E09}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_SUMMARY_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function newEntityIterator(cursor: JCursor): JEntityIterator; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_SUMMARY_URI: Jnet_Uri read _GetCONTENT_SUMMARY_URI;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/ContactsContract$Groups')]
  JContactsContract_Groups = interface(JObject)
    ['{73EBA953-50F0-4133-A32B-4CB129246BE9}']
  end;
  TJContactsContract_Groups = class(TJavaGenericImport<JContactsContract_GroupsClass, JContactsContract_Groups>) end;

  JContactsContract_IntentsClass = interface(JObjectClass)
    ['{85920F24-502A-40B0-8362-3BED71F6F159}']
    {class} function _GetATTACH_IMAGE: JString; cdecl;
    {class} function _GetCONTACTS_DATABASE_CREATED: JString; cdecl;
    {class} function _GetEXTRA_CREATE_DESCRIPTION: JString; cdecl;
    {class} function _GetEXTRA_FORCE_CREATE: JString; cdecl;
    {class} function _GetINVITE_CONTACT: JString; cdecl;
    {class} function _GetSEARCH_SUGGESTION_CLICKED: JString; cdecl;
    {class} function _GetSEARCH_SUGGESTION_CREATE_CONTACT_CLICKED: JString; cdecl;
    {class} function _GetSEARCH_SUGGESTION_DIAL_NUMBER_CLICKED: JString; cdecl;
    {class} function _GetSHOW_OR_CREATE_CONTACT: JString; cdecl;
    {class} function init: JContactsContract_Intents; cdecl;
    {class} property ATTACH_IMAGE: JString read _GetATTACH_IMAGE;
    {class} property CONTACTS_DATABASE_CREATED: JString read _GetCONTACTS_DATABASE_CREATED;
    {class} property EXTRA_CREATE_DESCRIPTION: JString read _GetEXTRA_CREATE_DESCRIPTION;
    {class} property EXTRA_FORCE_CREATE: JString read _GetEXTRA_FORCE_CREATE;
    {class} property INVITE_CONTACT: JString read _GetINVITE_CONTACT;
    {class} property SEARCH_SUGGESTION_CLICKED: JString read _GetSEARCH_SUGGESTION_CLICKED;
    {class} property SEARCH_SUGGESTION_CREATE_CONTACT_CLICKED: JString read _GetSEARCH_SUGGESTION_CREATE_CONTACT_CLICKED;
    {class} property SEARCH_SUGGESTION_DIAL_NUMBER_CLICKED: JString read _GetSEARCH_SUGGESTION_DIAL_NUMBER_CLICKED;
    {class} property SHOW_OR_CREATE_CONTACT: JString read _GetSHOW_OR_CREATE_CONTACT;
  end;

  [JavaSignature('android/provider/ContactsContract$Intents')]
  JContactsContract_Intents = interface(JObject)
    ['{C5E2ADB9-00FF-45EC-B335-30D7B8945D2D}']
  end;
  TJContactsContract_Intents = class(TJavaGenericImport<JContactsContract_IntentsClass, JContactsContract_Intents>) end;

  JContactsContract_Intents_InsertClass = interface(JObjectClass)
    ['{63E7DE40-278E-4636-A5C3-6328373C2F61}']
    {class} function _GetACTION: JString; cdecl;
    {class} function _GetCOMPANY: JString; cdecl;
    {class} function _GetDATA: JString; cdecl;
    {class} function _GetEMAIL: JString; cdecl;
    {class} function _GetEMAIL_ISPRIMARY: JString; cdecl;
    {class} function _GetEMAIL_TYPE: JString; cdecl;
    {class} function _GetEXTRA_ACCOUNT: JString; cdecl;
    {class} function _GetEXTRA_DATA_SET: JString; cdecl;
    {class} function _GetFULL_MODE: JString; cdecl;
    {class} function _GetIM_HANDLE: JString; cdecl;
    {class} function _GetIM_ISPRIMARY: JString; cdecl;
    {class} function _GetIM_PROTOCOL: JString; cdecl;
    {class} function _GetJOB_TITLE: JString; cdecl;
    {class} function _GetNAME: JString; cdecl;
    {class} function _GetNOTES: JString; cdecl;
    {class} function _GetPHONE: JString; cdecl;
    {class} function _GetPHONETIC_NAME: JString; cdecl;
    {class} function _GetPHONE_ISPRIMARY: JString; cdecl;
    {class} function _GetPHONE_TYPE: JString; cdecl;
    {class} function _GetPOSTAL: JString; cdecl;
    {class} function _GetPOSTAL_ISPRIMARY: JString; cdecl;
    {class} function _GetPOSTAL_TYPE: JString; cdecl;
    {class} function _GetSECONDARY_EMAIL: JString; cdecl;
    {class} function _GetSECONDARY_EMAIL_TYPE: JString; cdecl;
    {class} function _GetSECONDARY_PHONE: JString; cdecl;
    {class} function _GetSECONDARY_PHONE_TYPE: JString; cdecl;
    {class} function _GetTERTIARY_EMAIL: JString; cdecl;
    {class} function _GetTERTIARY_EMAIL_TYPE: JString; cdecl;
    {class} function _GetTERTIARY_PHONE: JString; cdecl;
    {class} function _GetTERTIARY_PHONE_TYPE: JString; cdecl;
    {class} function init: JContactsContract_Intents_Insert; cdecl;
    {class} property ACTION: JString read _GetACTION;
    {class} property COMPANY: JString read _GetCOMPANY;
    {class} property DATA: JString read _GetDATA;
    {class} property EMAIL: JString read _GetEMAIL;
    {class} property EMAIL_ISPRIMARY: JString read _GetEMAIL_ISPRIMARY;
    {class} property EMAIL_TYPE: JString read _GetEMAIL_TYPE;
    {class} property EXTRA_ACCOUNT: JString read _GetEXTRA_ACCOUNT;
    {class} property EXTRA_DATA_SET: JString read _GetEXTRA_DATA_SET;
    {class} property FULL_MODE: JString read _GetFULL_MODE;
    {class} property IM_HANDLE: JString read _GetIM_HANDLE;
    {class} property IM_ISPRIMARY: JString read _GetIM_ISPRIMARY;
    {class} property IM_PROTOCOL: JString read _GetIM_PROTOCOL;
    {class} property JOB_TITLE: JString read _GetJOB_TITLE;
    {class} property NAME: JString read _GetNAME;
    {class} property NOTES: JString read _GetNOTES;
    {class} property PHONE: JString read _GetPHONE;
    {class} property PHONETIC_NAME: JString read _GetPHONETIC_NAME;
    {class} property PHONE_ISPRIMARY: JString read _GetPHONE_ISPRIMARY;
    {class} property PHONE_TYPE: JString read _GetPHONE_TYPE;
    {class} property POSTAL: JString read _GetPOSTAL;
    {class} property POSTAL_ISPRIMARY: JString read _GetPOSTAL_ISPRIMARY;
    {class} property POSTAL_TYPE: JString read _GetPOSTAL_TYPE;
    {class} property SECONDARY_EMAIL: JString read _GetSECONDARY_EMAIL;
    {class} property SECONDARY_EMAIL_TYPE: JString read _GetSECONDARY_EMAIL_TYPE;
    {class} property SECONDARY_PHONE: JString read _GetSECONDARY_PHONE;
    {class} property SECONDARY_PHONE_TYPE: JString read _GetSECONDARY_PHONE_TYPE;
    {class} property TERTIARY_EMAIL: JString read _GetTERTIARY_EMAIL;
    {class} property TERTIARY_EMAIL_TYPE: JString read _GetTERTIARY_EMAIL_TYPE;
    {class} property TERTIARY_PHONE: JString read _GetTERTIARY_PHONE;
    {class} property TERTIARY_PHONE_TYPE: JString read _GetTERTIARY_PHONE_TYPE;
  end;

  [JavaSignature('android/provider/ContactsContract$Intents$Insert')]
  JContactsContract_Intents_Insert = interface(JObject)
    ['{458E71C3-1413-45B2-865E-F8346EC6C884}']
  end;
  TJContactsContract_Intents_Insert = class(TJavaGenericImport<JContactsContract_Intents_InsertClass, JContactsContract_Intents_Insert>) end;

  JContactsContract_PhoneLookupClass = interface(JObjectClass)
    ['{6580BC4C-30AE-4823-B6C0-220944F74C6D}']
    {class} function _GetCONTENT_FILTER_URI: Jnet_Uri; cdecl;
    {class} function _GetENTERPRISE_CONTENT_FILTER_URI: Jnet_Uri; cdecl;
    {class} function _GetQUERY_PARAMETER_SIP_ADDRESS: JString; cdecl;
    {class} property CONTENT_FILTER_URI: Jnet_Uri read _GetCONTENT_FILTER_URI;
    {class} property ENTERPRISE_CONTENT_FILTER_URI: Jnet_Uri read _GetENTERPRISE_CONTENT_FILTER_URI;
    {class} property QUERY_PARAMETER_SIP_ADDRESS: JString read _GetQUERY_PARAMETER_SIP_ADDRESS;
  end;

  [JavaSignature('android/provider/ContactsContract$PhoneLookup')]
  JContactsContract_PhoneLookup = interface(JObject)
    ['{67220900-E64C-4EBA-A0C9-30759B6DD2C1}']
  end;
  TJContactsContract_PhoneLookup = class(TJavaGenericImport<JContactsContract_PhoneLookupClass, JContactsContract_PhoneLookup>) end;

  JContactsContract_PhoneticNameStyleClass = interface(IJavaClass)
    ['{6A9E8D5F-60FD-4102-A949-55783262E4C9}']
    {class} function _GetJAPANESE: Integer; cdecl;
    {class} function _GetKOREAN: Integer; cdecl;
    {class} function _GetPINYIN: Integer; cdecl;
    {class} function _GetUNDEFINED: Integer; cdecl;
    {class} property JAPANESE: Integer read _GetJAPANESE;
    {class} property KOREAN: Integer read _GetKOREAN;
    {class} property PINYIN: Integer read _GetPINYIN;
    {class} property UNDEFINED: Integer read _GetUNDEFINED;
  end;

  [JavaSignature('android/provider/ContactsContract$PhoneticNameStyle')]
  JContactsContract_PhoneticNameStyle = interface(IJavaInstance)
    ['{57AC607C-87D6-4766-9EFF-C3144DA285C9}']
  end;
  TJContactsContract_PhoneticNameStyle = class(TJavaGenericImport<JContactsContract_PhoneticNameStyleClass, JContactsContract_PhoneticNameStyle>) end;

  JContactsContract_PinnedPositionsClass = interface(JObjectClass)
    ['{9666B1FD-3A9E-479E-9673-349589B8E995}']
    {class} function _GetDEMOTED: Integer; cdecl;
    {class} function _GetUNPINNED: Integer; cdecl;
    {class} function init: JContactsContract_PinnedPositions; cdecl;
    {class} procedure pin(contentResolver: JContentResolver; contactId: Int64; pinnedPosition: Integer); cdecl;
    {class} procedure undemote(contentResolver: JContentResolver; contactId: Int64); cdecl;
    {class} property DEMOTED: Integer read _GetDEMOTED;
    {class} property UNPINNED: Integer read _GetUNPINNED;
  end;

  [JavaSignature('android/provider/ContactsContract$PinnedPositions')]
  JContactsContract_PinnedPositions = interface(JObject)
    ['{494EA356-5D95-42EE-A5F8-A7F5699350B7}']
  end;
  TJContactsContract_PinnedPositions = class(TJavaGenericImport<JContactsContract_PinnedPositionsClass, JContactsContract_PinnedPositions>) end;

  JContactsContract_StatusUpdatesClass = interface(JObjectClass)
    ['{EB026425-5A27-43D5-BB4F-5729721A88DF}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetPROFILE_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function getPresenceIconResourceId(status: Integer): Integer; cdecl;
    {class} function getPresencePrecedence(status: Integer): Integer; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property PROFILE_CONTENT_URI: Jnet_Uri read _GetPROFILE_CONTENT_URI;
  end;

  [JavaSignature('android/provider/ContactsContract$StatusUpdates')]
  JContactsContract_StatusUpdates = interface(JObject)
    ['{EFB001B8-804C-4D5B-8814-BF9153DB7EAF}']
  end;
  TJContactsContract_StatusUpdates = class(TJavaGenericImport<JContactsContract_StatusUpdatesClass, JContactsContract_StatusUpdates>) end;

  JContactsContract_PresenceClass = interface(JContactsContract_StatusUpdatesClass)
    ['{CADB7F8A-65D0-43B4-B90F-B44936C5F743}']
    {class} function init: JContactsContract_Presence; cdecl;
  end;

  [JavaSignature('android/provider/ContactsContract$Presence')]
  JContactsContract_Presence = interface(JContactsContract_StatusUpdates)
    ['{5AD58EB3-195F-4C71-9D7B-18CF95F21DA9}']
  end;
  TJContactsContract_Presence = class(TJavaGenericImport<JContactsContract_PresenceClass, JContactsContract_Presence>) end;

  JContactsContract_ProfileClass = interface(JObjectClass)
    ['{6792B81E-AC9B-463B-BB59-168BA466F12B}']
    {class} function _GetCONTENT_RAW_CONTACTS_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_VCARD_URI: Jnet_Uri; cdecl;
    {class} function _GetMIN_ID: Int64; cdecl;
    {class} property CONTENT_RAW_CONTACTS_URI: Jnet_Uri read _GetCONTENT_RAW_CONTACTS_URI;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property CONTENT_VCARD_URI: Jnet_Uri read _GetCONTENT_VCARD_URI;
    {class} property MIN_ID: Int64 read _GetMIN_ID;
  end;

  [JavaSignature('android/provider/ContactsContract$Profile')]
  JContactsContract_Profile = interface(JObject)
    ['{14F9921F-5E34-49FB-8932-21264E5C0385}']
  end;
  TJContactsContract_Profile = class(TJavaGenericImport<JContactsContract_ProfileClass, JContactsContract_Profile>) end;

  JContactsContract_ProfileSyncStateClass = interface(JObjectClass)
    ['{0DB260ED-4251-4A79-A10E-B5C1BAEC5834}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} //function &get(provider: JContentProviderClient; account: JAccount): TJavaArray<Byte>; cdecl;
    {class} //function getWithUri(provider: JContentProviderClient; account: JAccount): TJavaObjectArray<JPair>; cdecl;
    {class} //function newSetOperation(account: JAccount; data: TJavaArray<Byte>): JContentProviderOperation; cdecl;
    {class} //procedure &set(provider: JContentProviderClient; account: JAccount; data: TJavaArray<Byte>); cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/ContactsContract$ProfileSyncState')]
  JContactsContract_ProfileSyncState = interface(JObject)
    ['{72E51072-AF64-48B6-8674-547E0F3E616B}']
  end;
  TJContactsContract_ProfileSyncState = class(TJavaGenericImport<JContactsContract_ProfileSyncStateClass, JContactsContract_ProfileSyncState>) end;

  JContactsContract_ProviderStatusClass = interface(JObjectClass)
    ['{10EFD27D-EFAF-41A6-AE5C-5C3621A0C509}']
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetSTATUS: JString; cdecl;
    {class} function _GetSTATUS_BUSY: Integer; cdecl;
    {class} function _GetSTATUS_EMPTY: Integer; cdecl;
    {class} function _GetSTATUS_NORMAL: Integer; cdecl;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property STATUS: JString read _GetSTATUS;
    {class} property STATUS_BUSY: Integer read _GetSTATUS_BUSY;
    {class} property STATUS_EMPTY: Integer read _GetSTATUS_EMPTY;
    {class} property STATUS_NORMAL: Integer read _GetSTATUS_NORMAL;
  end;

  [JavaSignature('android/provider/ContactsContract$ProviderStatus')]
  JContactsContract_ProviderStatus = interface(JObject)
    ['{0A79C0A1-AB31-4E8D-B448-F6EFF9BA7203}']
  end;
  TJContactsContract_ProviderStatus = class(TJavaGenericImport<JContactsContract_ProviderStatusClass, JContactsContract_ProviderStatus>) end;

  JContactsContract_QuickContactClass = interface(JObjectClass)
    ['{BFFF22CB-54E7-4771-AF1C-DCD44BF0B754}']
    {class} function _GetACTION_QUICK_CONTACT: JString; cdecl;
    {class} function _GetEXTRA_EXCLUDE_MIMES: JString; cdecl;
    {class} function _GetEXTRA_MODE: JString; cdecl;
    {class} function _GetEXTRA_PRIORITIZED_MIMETYPE: JString; cdecl;
    {class} function _GetMODE_LARGE: Integer; cdecl;
    {class} function _GetMODE_MEDIUM: Integer; cdecl;
    {class} function _GetMODE_SMALL: Integer; cdecl;
    {class} function init: JContactsContract_QuickContact; cdecl;
    {class} procedure showQuickContact(context: JContext; target: JView; lookupUri: Jnet_Uri; mode: Integer; excludeMimes: TJavaObjectArray<JString>); cdecl; overload;
    {class} procedure showQuickContact(context: JContext; target: JRect; lookupUri: Jnet_Uri; mode: Integer; excludeMimes: TJavaObjectArray<JString>); cdecl; overload;
    {class} procedure showQuickContact(context: JContext; target: JView; lookupUri: Jnet_Uri; excludeMimes: TJavaObjectArray<JString>; prioritizedMimeType: JString); cdecl; overload;
    {class} procedure showQuickContact(context: JContext; target: JRect; lookupUri: Jnet_Uri; excludeMimes: TJavaObjectArray<JString>; prioritizedMimeType: JString); cdecl; overload;
    {class} property ACTION_QUICK_CONTACT: JString read _GetACTION_QUICK_CONTACT;
    {class} property EXTRA_EXCLUDE_MIMES: JString read _GetEXTRA_EXCLUDE_MIMES;
    {class} property EXTRA_MODE: JString read _GetEXTRA_MODE;
    {class} property EXTRA_PRIORITIZED_MIMETYPE: JString read _GetEXTRA_PRIORITIZED_MIMETYPE;
    {class} property MODE_LARGE: Integer read _GetMODE_LARGE;
    {class} property MODE_MEDIUM: Integer read _GetMODE_MEDIUM;
    {class} property MODE_SMALL: Integer read _GetMODE_SMALL;
  end;

  [JavaSignature('android/provider/ContactsContract$QuickContact')]
  JContactsContract_QuickContact = interface(JObject)
    ['{58793703-580F-461A-AE92-379CE3C5D499}']
  end;
  TJContactsContract_QuickContact = class(TJavaGenericImport<JContactsContract_QuickContactClass, JContactsContract_QuickContact>) end;

  JContactsContract_RawContactsClass = interface(JObjectClass)
    ['{E0D65538-AB84-4AD8-A420-4BD244B76A83}']
    {class} function _GetAGGREGATION_MODE_DEFAULT: Integer; cdecl;
    {class} function _GetAGGREGATION_MODE_DISABLED: Integer; cdecl;
    {class} function _GetAGGREGATION_MODE_IMMEDIATE: Integer; cdecl;
    {class} function _GetAGGREGATION_MODE_SUSPENDED: Integer; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function getContactLookupUri(resolver: JContentResolver; rawContactUri: Jnet_Uri): Jnet_Uri; cdecl;
    {class} function newEntityIterator(cursor: JCursor): JEntityIterator; cdecl;
    {class} property AGGREGATION_MODE_DEFAULT: Integer read _GetAGGREGATION_MODE_DEFAULT;
    {class} property AGGREGATION_MODE_DISABLED: Integer read _GetAGGREGATION_MODE_DISABLED;
    {class} property AGGREGATION_MODE_IMMEDIATE: Integer read _GetAGGREGATION_MODE_IMMEDIATE;
    {class} property AGGREGATION_MODE_SUSPENDED: Integer read _GetAGGREGATION_MODE_SUSPENDED;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/ContactsContract$RawContacts')]
  JContactsContract_RawContacts = interface(JObject)
    ['{E594CABA-4493-4DDB-89CA-5DC683D8EE69}']
  end;
  TJContactsContract_RawContacts = class(TJavaGenericImport<JContactsContract_RawContactsClass, JContactsContract_RawContacts>) end;

  JRawContacts_DataClass = interface(JObjectClass)
    ['{A561B9F3-0954-447B-9F40-561B3C49B2F3}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
  end;

  [JavaSignature('android/provider/ContactsContract$RawContacts$Data')]
  JRawContacts_Data = interface(JObject)
    ['{E8D7D61B-005D-4E36-83F0-5C2B6CE67895}']
  end;
  TJRawContacts_Data = class(TJavaGenericImport<JRawContacts_DataClass, JRawContacts_Data>) end;

  JRawContacts_DisplayPhotoClass = interface(JObjectClass)
    ['{BF4BD582-6AEF-4BA5-928B-B0A425DF93C0}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
  end;

  [JavaSignature('android/provider/ContactsContract$RawContacts$DisplayPhoto')]
  JRawContacts_DisplayPhoto = interface(JObject)
    ['{2019B5CE-9DFE-486C-83FB-98A4D556D5B0}']
  end;
  TJRawContacts_DisplayPhoto = class(TJavaGenericImport<JRawContacts_DisplayPhotoClass, JRawContacts_DisplayPhoto>) end;

  JRawContacts_EntityClass = interface(JObjectClass)
    ['{F3CDFCCB-4DBF-4F5D-948B-B01D2CDC24A7}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetDATA_ID: JString; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property DATA_ID: JString read _GetDATA_ID;
  end;

  [JavaSignature('android/provider/ContactsContract$RawContacts$Entity')]
  JRawContacts_Entity = interface(JObject)
    ['{37F7049D-1CDA-4275-93E6-CA0FFF28DE8A}']
  end;
  TJRawContacts_Entity = class(TJavaGenericImport<JRawContacts_EntityClass, JRawContacts_Entity>) end;

  JContactsContract_RawContactsEntityClass = interface(JObjectClass)
    ['{83990A10-0BEC-444E-82CB-217C8B0B4EB7}']
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDATA_ID: JString; cdecl;
    {class} function _GetPROFILE_CONTENT_URI: Jnet_Uri; cdecl;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DATA_ID: JString read _GetDATA_ID;
    {class} property PROFILE_CONTENT_URI: Jnet_Uri read _GetPROFILE_CONTENT_URI;
  end;

  [JavaSignature('android/provider/ContactsContract$RawContactsEntity')]
  JContactsContract_RawContactsEntity = interface(JObject)
    ['{05AE5B58-E000-4C2D-9956-5B775749E1FC}']
  end;
  TJContactsContract_RawContactsEntity = class(TJavaGenericImport<JContactsContract_RawContactsEntityClass, JContactsContract_RawContactsEntity>) end;

  JContactsContract_SearchSnippetsClass = interface(JObjectClass)
    ['{B983027B-ED63-4404-B670-CD75E0085DDA}']
    {class} function _GetDEFERRED_SNIPPETING_KEY: JString; cdecl;
    {class} function _GetSNIPPET: JString; cdecl;
    {class} function init: JContactsContract_SearchSnippets; cdecl;
    {class} property DEFERRED_SNIPPETING_KEY: JString read _GetDEFERRED_SNIPPETING_KEY;
    {class} property SNIPPET: JString read _GetSNIPPET;
  end;

  [JavaSignature('android/provider/ContactsContract$SearchSnippets')]
  JContactsContract_SearchSnippets = interface(JObject)
    ['{2A80821B-D9A9-4C51-BC55-4DDBB06BB6AC}']
  end;
  TJContactsContract_SearchSnippets = class(TJavaGenericImport<JContactsContract_SearchSnippetsClass, JContactsContract_SearchSnippets>) end;

  JContactsContract_SettingsClass = interface(JObjectClass)
    ['{13D5FAD0-90BB-4AB2-91E6-BF70605DAF36}']
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/ContactsContract$Settings')]
  JContactsContract_Settings = interface(JObject)
    ['{BBF9385B-DFA5-4639-9EC1-892A91427919}']
  end;
  TJContactsContract_Settings = class(TJavaGenericImport<JContactsContract_SettingsClass, JContactsContract_Settings>) end;

  JContactsContract_SyncStateClass = interface(JObjectClass)
    ['{817DC34B-E666-4002-BCFE-7BC4524722F8}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} //function &get(provider: JContentProviderClient; account: JAccount): TJavaArray<Byte>; cdecl;
    {class} //function getWithUri(provider: JContentProviderClient; account: JAccount): TJavaObjectArray<JPair>; cdecl;
    {class} //function newSetOperation(account: JAccount; data: TJavaArray<Byte>): JContentProviderOperation; cdecl;
    {class} //procedure &set(provider: JContentProviderClient; account: JAccount; data: TJavaArray<Byte>); cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/ContactsContract$SyncState')]
  JContactsContract_SyncState = interface(JObject)
    ['{5691696E-16F0-4DDD-B204-E6443D30A6A0}']
  end;
  TJContactsContract_SyncState = class(TJavaGenericImport<JContactsContract_SyncStateClass, JContactsContract_SyncState>) end;

  JDocumentsContractClass = interface(JObjectClass)
    ['{8674EB28-6F96-435E-814D-2062577EF522}']
    {class} function _GetEXTRA_ERROR: JString; cdecl;
    {class} function _GetEXTRA_EXCLUDE_SELF: JString; cdecl;
    {class} function _GetEXTRA_INFO: JString; cdecl;
    {class} function _GetEXTRA_LOADING: JString; cdecl;
    {class} function _GetEXTRA_PROMPT: JString; cdecl;
    {class} function _GetPROVIDER_INTERFACE: JString; cdecl;
    {class} function buildChildDocumentsUri(authority: JString; parentDocumentId: JString): Jnet_Uri; cdecl;
    {class} function buildChildDocumentsUriUsingTree(treeUri: Jnet_Uri; parentDocumentId: JString): Jnet_Uri; cdecl;
    {class} function buildDocumentUri(authority: JString; documentId: JString): Jnet_Uri; cdecl;
    {class} function buildDocumentUriUsingTree(treeUri: Jnet_Uri; documentId: JString): Jnet_Uri; cdecl;
    {class} function buildRecentDocumentsUri(authority: JString; rootId: JString): Jnet_Uri; cdecl;
    {class} function buildRootUri(authority: JString; rootId: JString): Jnet_Uri; cdecl;
    {class} function buildRootsUri(authority: JString): Jnet_Uri; cdecl;
    {class} function buildSearchDocumentsUri(authority: JString; rootId: JString; query: JString): Jnet_Uri; cdecl;
    {class} function buildTreeDocumentUri(authority: JString; documentId: JString): Jnet_Uri; cdecl;
    {class} function createDocument(resolver: JContentResolver; parentDocumentUri: Jnet_Uri; mimeType: JString; displayName: JString): Jnet_Uri; cdecl;
    {class} function deleteDocument(resolver: JContentResolver; documentUri: Jnet_Uri): Boolean; cdecl;
    {class} function getDocumentId(documentUri: Jnet_Uri): JString; cdecl;
    {class} function getDocumentThumbnail(resolver: JContentResolver; documentUri: Jnet_Uri; size: JPoint; signal: JCancellationSignal): JBitmap; cdecl;
    {class} function getRootId(rootUri: Jnet_Uri): JString; cdecl;
    {class} function getSearchDocumentsQuery(searchDocumentsUri: Jnet_Uri): JString; cdecl;
    {class} function getTreeDocumentId(documentUri: Jnet_Uri): JString; cdecl;
    {class} function isDocumentUri(context: JContext; uri: Jnet_Uri): Boolean; cdecl;
    {class} function renameDocument(resolver: JContentResolver; documentUri: Jnet_Uri; displayName: JString): Jnet_Uri; cdecl;
    {class} property EXTRA_ERROR: JString read _GetEXTRA_ERROR;
    {class} property EXTRA_EXCLUDE_SELF: JString read _GetEXTRA_EXCLUDE_SELF;
    {class} property EXTRA_INFO: JString read _GetEXTRA_INFO;
    {class} property EXTRA_LOADING: JString read _GetEXTRA_LOADING;
    {class} property EXTRA_PROMPT: JString read _GetEXTRA_PROMPT;
    {class} property PROVIDER_INTERFACE: JString read _GetPROVIDER_INTERFACE;
  end;

  [JavaSignature('android/provider/DocumentsContract')]
  JDocumentsContract = interface(JObject)
    ['{AE9261AA-33F9-4AB8-B511-122A34EAEA7D}']
  end;
  TJDocumentsContract = class(TJavaGenericImport<JDocumentsContractClass, JDocumentsContract>) end;

  JDocumentsContract_DocumentClass = interface(JObjectClass)
    ['{5C8B7BBB-D8CD-402F-A1A1-D987D3ED17A7}']
    {class} function _GetCOLUMN_DISPLAY_NAME: JString; cdecl;
    {class} function _GetCOLUMN_DOCUMENT_ID: JString; cdecl;
    {class} function _GetCOLUMN_FLAGS: JString; cdecl;
    {class} function _GetCOLUMN_ICON: JString; cdecl;
    {class} function _GetCOLUMN_LAST_MODIFIED: JString; cdecl;
    {class} function _GetCOLUMN_MIME_TYPE: JString; cdecl;
    {class} function _GetCOLUMN_SIZE: JString; cdecl;
    {class} function _GetCOLUMN_SUMMARY: JString; cdecl;
    {class} function _GetFLAG_DIR_PREFERS_GRID: Integer; cdecl;
    {class} function _GetFLAG_DIR_PREFERS_LAST_MODIFIED: Integer; cdecl;
    {class} function _GetFLAG_DIR_SUPPORTS_CREATE: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_DELETE: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_RENAME: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_THUMBNAIL: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_WRITE: Integer; cdecl;
    {class} function _GetMIME_TYPE_DIR: JString; cdecl;
    {class} property COLUMN_DISPLAY_NAME: JString read _GetCOLUMN_DISPLAY_NAME;
    {class} property COLUMN_DOCUMENT_ID: JString read _GetCOLUMN_DOCUMENT_ID;
    {class} property COLUMN_FLAGS: JString read _GetCOLUMN_FLAGS;
    {class} property COLUMN_ICON: JString read _GetCOLUMN_ICON;
    {class} property COLUMN_LAST_MODIFIED: JString read _GetCOLUMN_LAST_MODIFIED;
    {class} property COLUMN_MIME_TYPE: JString read _GetCOLUMN_MIME_TYPE;
    {class} property COLUMN_SIZE: JString read _GetCOLUMN_SIZE;
    {class} property COLUMN_SUMMARY: JString read _GetCOLUMN_SUMMARY;
    {class} property FLAG_DIR_PREFERS_GRID: Integer read _GetFLAG_DIR_PREFERS_GRID;
    {class} property FLAG_DIR_PREFERS_LAST_MODIFIED: Integer read _GetFLAG_DIR_PREFERS_LAST_MODIFIED;
    {class} property FLAG_DIR_SUPPORTS_CREATE: Integer read _GetFLAG_DIR_SUPPORTS_CREATE;
    {class} property FLAG_SUPPORTS_DELETE: Integer read _GetFLAG_SUPPORTS_DELETE;
    {class} property FLAG_SUPPORTS_RENAME: Integer read _GetFLAG_SUPPORTS_RENAME;
    {class} property FLAG_SUPPORTS_THUMBNAIL: Integer read _GetFLAG_SUPPORTS_THUMBNAIL;
    {class} property FLAG_SUPPORTS_WRITE: Integer read _GetFLAG_SUPPORTS_WRITE;
    {class} property MIME_TYPE_DIR: JString read _GetMIME_TYPE_DIR;
  end;

  [JavaSignature('android/provider/DocumentsContract$Document')]
  JDocumentsContract_Document = interface(JObject)
    ['{1E7B2526-794F-4741-8B63-64036BAF90EE}']
  end;
  TJDocumentsContract_Document = class(TJavaGenericImport<JDocumentsContract_DocumentClass, JDocumentsContract_Document>) end;

  JDocumentsContract_RootClass = interface(JObjectClass)
    ['{498DD351-3B3A-4AED-9976-DD3903D3B101}']
    {class} function _GetCOLUMN_AVAILABLE_BYTES: JString; cdecl;
    {class} function _GetCOLUMN_DOCUMENT_ID: JString; cdecl;
    {class} function _GetCOLUMN_FLAGS: JString; cdecl;
    {class} function _GetCOLUMN_ICON: JString; cdecl;
    {class} function _GetCOLUMN_MIME_TYPES: JString; cdecl;
    {class} function _GetCOLUMN_ROOT_ID: JString; cdecl;
    {class} function _GetCOLUMN_SUMMARY: JString; cdecl;
    {class} function _GetCOLUMN_TITLE: JString; cdecl;
    {class} function _GetFLAG_LOCAL_ONLY: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_CREATE: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_IS_CHILD: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_RECENTS: Integer; cdecl;
    {class} function _GetFLAG_SUPPORTS_SEARCH: Integer; cdecl;
    {class} property COLUMN_AVAILABLE_BYTES: JString read _GetCOLUMN_AVAILABLE_BYTES;
    {class} property COLUMN_DOCUMENT_ID: JString read _GetCOLUMN_DOCUMENT_ID;
    {class} property COLUMN_FLAGS: JString read _GetCOLUMN_FLAGS;
    {class} property COLUMN_ICON: JString read _GetCOLUMN_ICON;
    {class} property COLUMN_MIME_TYPES: JString read _GetCOLUMN_MIME_TYPES;
    {class} property COLUMN_ROOT_ID: JString read _GetCOLUMN_ROOT_ID;
    {class} property COLUMN_SUMMARY: JString read _GetCOLUMN_SUMMARY;
    {class} property COLUMN_TITLE: JString read _GetCOLUMN_TITLE;
    {class} property FLAG_LOCAL_ONLY: Integer read _GetFLAG_LOCAL_ONLY;
    {class} property FLAG_SUPPORTS_CREATE: Integer read _GetFLAG_SUPPORTS_CREATE;
    {class} property FLAG_SUPPORTS_IS_CHILD: Integer read _GetFLAG_SUPPORTS_IS_CHILD;
    {class} property FLAG_SUPPORTS_RECENTS: Integer read _GetFLAG_SUPPORTS_RECENTS;
    {class} property FLAG_SUPPORTS_SEARCH: Integer read _GetFLAG_SUPPORTS_SEARCH;
  end;

  [JavaSignature('android/provider/DocumentsContract$Root')]
  JDocumentsContract_Root = interface(JObject)
    ['{591C6F87-6BBE-46D9-8522-D2DBD5ED0075}']
  end;
  TJDocumentsContract_Root = class(TJavaGenericImport<JDocumentsContract_RootClass, JDocumentsContract_Root>) end;

  JDocumentsProviderClass = interface(JContentProviderClass)
    ['{99656E1E-EBAE-4CD4-9992-05A0EAAA4410}']
    {class} function init: JDocumentsProvider; cdecl;
  end;

  [JavaSignature('android/provider/DocumentsProvider')]
  JDocumentsProvider = interface(JContentProvider)
    ['{DF4B8BA7-1EE5-47C1-BC1F-9F193C79562E}']
    procedure attachInfo(context: JContext; info: JProviderInfo); cdecl;
    function call(method: JString; arg: JString; extras: JBundle): JBundle; cdecl;
    function canonicalize(uri: Jnet_Uri): Jnet_Uri; cdecl;
    function createDocument(parentDocumentId: JString; mimeType: JString; displayName: JString): JString; cdecl;
    function delete(uri: Jnet_Uri; selection: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
    procedure deleteDocument(documentId: JString); cdecl;
    function getDocumentType(documentId: JString): JString; cdecl;
    function getType(uri: Jnet_Uri): JString; cdecl;
    function insert(uri: Jnet_Uri; values: JContentValues): Jnet_Uri; cdecl;
    function isChildDocument(parentDocumentId: JString; documentId: JString): Boolean; cdecl;
    function openAssetFile(uri: Jnet_Uri; mode: JString): JAssetFileDescriptor; cdecl; overload;
    function openAssetFile(uri: Jnet_Uri; mode: JString; signal: JCancellationSignal): JAssetFileDescriptor; cdecl; overload;
    function openDocument(documentId: JString; mode: JString; signal: JCancellationSignal): JParcelFileDescriptor; cdecl;
    function openDocumentThumbnail(documentId: JString; sizeHint: JPoint; signal: JCancellationSignal): JAssetFileDescriptor; cdecl;
    function openFile(uri: Jnet_Uri; mode: JString): JParcelFileDescriptor; cdecl; overload;
    function openFile(uri: Jnet_Uri; mode: JString; signal: JCancellationSignal): JParcelFileDescriptor; cdecl; overload;
    function openTypedAssetFile(uri: Jnet_Uri; mimeTypeFilter: JString; opts: JBundle): JAssetFileDescriptor; cdecl; overload;
    function openTypedAssetFile(uri: Jnet_Uri; mimeTypeFilter: JString; opts: JBundle; signal: JCancellationSignal): JAssetFileDescriptor; cdecl; overload;
    function query(uri: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; sortOrder: JString): JCursor; cdecl;
    function queryChildDocuments(parentDocumentId: JString; projection: TJavaObjectArray<JString>; sortOrder: JString): JCursor; cdecl;
    function queryDocument(documentId: JString; projection: TJavaObjectArray<JString>): JCursor; cdecl;
    function queryRecentDocuments(rootId: JString; projection: TJavaObjectArray<JString>): JCursor; cdecl;
    function queryRoots(projection: TJavaObjectArray<JString>): JCursor; cdecl;
    function querySearchDocuments(rootId: JString; query: JString; projection: TJavaObjectArray<JString>): JCursor; cdecl;
    function renameDocument(documentId: JString; displayName: JString): JString; cdecl;
    procedure revokeDocumentPermission(documentId: JString); cdecl;
    function update(uri: Jnet_Uri; values: JContentValues; selection: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
  end;
  TJDocumentsProvider = class(TJavaGenericImport<JDocumentsProviderClass, JDocumentsProvider>) end;

  JLiveFoldersClass = interface(JObjectClass)
    ['{6572B14B-4141-4AEC-AFE4-07EB06364DBB}']
    {class} function _GetACTION_CREATE_LIVE_FOLDER: JString; cdecl;
    {class} function _GetDESCRIPTION: JString; cdecl;
    {class} function _GetDISPLAY_MODE_GRID: Integer; cdecl;
    {class} function _GetDISPLAY_MODE_LIST: Integer; cdecl;
    {class} function _GetEXTRA_LIVE_FOLDER_BASE_INTENT: JString; cdecl;
    {class} function _GetEXTRA_LIVE_FOLDER_DISPLAY_MODE: JString; cdecl;
    {class} function _GetEXTRA_LIVE_FOLDER_ICON: JString; cdecl;
    {class} function _GetEXTRA_LIVE_FOLDER_NAME: JString; cdecl;
    {class} function _GetICON_BITMAP: JString; cdecl;
    {class} function _GetICON_PACKAGE: JString; cdecl;
    {class} function _GetICON_RESOURCE: JString; cdecl;
    {class} function _GetINTENT: JString; cdecl;
    {class} function _GetNAME: JString; cdecl;
    {class} property ACTION_CREATE_LIVE_FOLDER: JString read _GetACTION_CREATE_LIVE_FOLDER;
    {class} property DESCRIPTION: JString read _GetDESCRIPTION;
    {class} property DISPLAY_MODE_GRID: Integer read _GetDISPLAY_MODE_GRID;
    {class} property DISPLAY_MODE_LIST: Integer read _GetDISPLAY_MODE_LIST;
    {class} property EXTRA_LIVE_FOLDER_BASE_INTENT: JString read _GetEXTRA_LIVE_FOLDER_BASE_INTENT;
    {class} property EXTRA_LIVE_FOLDER_DISPLAY_MODE: JString read _GetEXTRA_LIVE_FOLDER_DISPLAY_MODE;
    {class} property EXTRA_LIVE_FOLDER_ICON: JString read _GetEXTRA_LIVE_FOLDER_ICON;
    {class} property EXTRA_LIVE_FOLDER_NAME: JString read _GetEXTRA_LIVE_FOLDER_NAME;
    {class} property ICON_BITMAP: JString read _GetICON_BITMAP;
    {class} property ICON_PACKAGE: JString read _GetICON_PACKAGE;
    {class} property ICON_RESOURCE: JString read _GetICON_RESOURCE;
    {class} property INTENT: JString read _GetINTENT;
    {class} property NAME: JString read _GetNAME;
  end;

  [JavaSignature('android/provider/LiveFolders')]
  JLiveFolders = interface(JObject)
    ['{DBB7EE2D-C583-4C1E-805C-AE62526AE6D7}']
  end;
  TJLiveFolders = class(TJavaGenericImport<JLiveFoldersClass, JLiveFolders>) end;

  JMediaStoreClass = interface(JObjectClass)
    ['{278F3F27-3ECC-494B-8425-1D29F602F5A5}']
    {class} function _GetACTION_IMAGE_CAPTURE: JString; cdecl;
    {class} function _GetACTION_IMAGE_CAPTURE_SECURE: JString; cdecl;
    {class} function _GetACTION_VIDEO_CAPTURE: JString; cdecl;
    {class} function _GetAUTHORITY: JString; cdecl;
    {class} function _GetEXTRA_DURATION_LIMIT: JString; cdecl;
    {class} function _GetEXTRA_FINISH_ON_COMPLETION: JString; cdecl;
    {class} function _GetEXTRA_FULL_SCREEN: JString; cdecl;
    {class} function _GetEXTRA_MEDIA_ALBUM: JString; cdecl;
    {class} function _GetEXTRA_MEDIA_ARTIST: JString; cdecl;
    {class} function _GetEXTRA_MEDIA_FOCUS: JString; cdecl;
    {class} function _GetEXTRA_MEDIA_GENRE: JString; cdecl;
    {class} function _GetEXTRA_MEDIA_PLAYLIST: JString; cdecl;
    {class} function _GetEXTRA_MEDIA_RADIO_CHANNEL: JString; cdecl;
    {class} function _GetEXTRA_MEDIA_TITLE: JString; cdecl;
    {class} function _GetEXTRA_OUTPUT: JString; cdecl;
    {class} function _GetEXTRA_SCREEN_ORIENTATION: JString; cdecl;
    {class} function _GetEXTRA_SHOW_ACTION_ICONS: JString; cdecl;
    {class} function _GetEXTRA_SIZE_LIMIT: JString; cdecl;
    {class} function _GetEXTRA_VIDEO_QUALITY: JString; cdecl;
    {class} function _GetINTENT_ACTION_MEDIA_PLAY_FROM_SEARCH: JString; cdecl;
    {class} function _GetINTENT_ACTION_MEDIA_SEARCH: JString; cdecl;
    {class} function _GetINTENT_ACTION_MUSIC_PLAYER: JString; cdecl;
    {class} function _GetINTENT_ACTION_STILL_IMAGE_CAMERA: JString; cdecl;
    {class} function _GetINTENT_ACTION_STILL_IMAGE_CAMERA_SECURE: JString; cdecl;
    {class} function _GetINTENT_ACTION_TEXT_OPEN_FROM_SEARCH: JString; cdecl;
    {class} function _GetINTENT_ACTION_VIDEO_CAMERA: JString; cdecl;
    {class} function _GetINTENT_ACTION_VIDEO_PLAY_FROM_SEARCH: JString; cdecl;
    {class} function _GetMEDIA_IGNORE_FILENAME: JString; cdecl;
    {class} function _GetMEDIA_SCANNER_VOLUME: JString; cdecl;
    {class} function _GetMETA_DATA_STILL_IMAGE_CAMERA_PREWARM_SERVICE: JString; cdecl;
    {class} function _GetUNKNOWN_STRING: JString; cdecl;
    {class} function init: JMediaStore; cdecl;
    {class} function getMediaScannerUri: Jnet_Uri; cdecl;
    {class} function getVersion(context: JContext): JString; cdecl;
    {class} property ACTION_IMAGE_CAPTURE: JString read _GetACTION_IMAGE_CAPTURE;
    {class} property ACTION_IMAGE_CAPTURE_SECURE: JString read _GetACTION_IMAGE_CAPTURE_SECURE;
    {class} property ACTION_VIDEO_CAPTURE: JString read _GetACTION_VIDEO_CAPTURE;
    {class} property AUTHORITY: JString read _GetAUTHORITY;
    {class} property EXTRA_DURATION_LIMIT: JString read _GetEXTRA_DURATION_LIMIT;
    {class} property EXTRA_FINISH_ON_COMPLETION: JString read _GetEXTRA_FINISH_ON_COMPLETION;
    {class} property EXTRA_FULL_SCREEN: JString read _GetEXTRA_FULL_SCREEN;
    {class} property EXTRA_MEDIA_ALBUM: JString read _GetEXTRA_MEDIA_ALBUM;
    {class} property EXTRA_MEDIA_ARTIST: JString read _GetEXTRA_MEDIA_ARTIST;
    {class} property EXTRA_MEDIA_FOCUS: JString read _GetEXTRA_MEDIA_FOCUS;
    {class} property EXTRA_MEDIA_GENRE: JString read _GetEXTRA_MEDIA_GENRE;
    {class} property EXTRA_MEDIA_PLAYLIST: JString read _GetEXTRA_MEDIA_PLAYLIST;
    {class} property EXTRA_MEDIA_RADIO_CHANNEL: JString read _GetEXTRA_MEDIA_RADIO_CHANNEL;
    {class} property EXTRA_MEDIA_TITLE: JString read _GetEXTRA_MEDIA_TITLE;
    {class} property EXTRA_OUTPUT: JString read _GetEXTRA_OUTPUT;
    {class} property EXTRA_SCREEN_ORIENTATION: JString read _GetEXTRA_SCREEN_ORIENTATION;
    {class} property EXTRA_SHOW_ACTION_ICONS: JString read _GetEXTRA_SHOW_ACTION_ICONS;
    {class} property EXTRA_SIZE_LIMIT: JString read _GetEXTRA_SIZE_LIMIT;
    {class} property EXTRA_VIDEO_QUALITY: JString read _GetEXTRA_VIDEO_QUALITY;
    {class} property INTENT_ACTION_MEDIA_PLAY_FROM_SEARCH: JString read _GetINTENT_ACTION_MEDIA_PLAY_FROM_SEARCH;
    {class} property INTENT_ACTION_MEDIA_SEARCH: JString read _GetINTENT_ACTION_MEDIA_SEARCH;
    {class} property INTENT_ACTION_MUSIC_PLAYER: JString read _GetINTENT_ACTION_MUSIC_PLAYER;
    {class} property INTENT_ACTION_STILL_IMAGE_CAMERA: JString read _GetINTENT_ACTION_STILL_IMAGE_CAMERA;
    {class} property INTENT_ACTION_STILL_IMAGE_CAMERA_SECURE: JString read _GetINTENT_ACTION_STILL_IMAGE_CAMERA_SECURE;
    {class} property INTENT_ACTION_TEXT_OPEN_FROM_SEARCH: JString read _GetINTENT_ACTION_TEXT_OPEN_FROM_SEARCH;
    {class} property INTENT_ACTION_VIDEO_CAMERA: JString read _GetINTENT_ACTION_VIDEO_CAMERA;
    {class} property INTENT_ACTION_VIDEO_PLAY_FROM_SEARCH: JString read _GetINTENT_ACTION_VIDEO_PLAY_FROM_SEARCH;
    {class} property MEDIA_IGNORE_FILENAME: JString read _GetMEDIA_IGNORE_FILENAME;
    {class} property MEDIA_SCANNER_VOLUME: JString read _GetMEDIA_SCANNER_VOLUME;
    {class} property META_DATA_STILL_IMAGE_CAMERA_PREWARM_SERVICE: JString read _GetMETA_DATA_STILL_IMAGE_CAMERA_PREWARM_SERVICE;
    {class} property UNKNOWN_STRING: JString read _GetUNKNOWN_STRING;
  end;

  [JavaSignature('android/provider/MediaStore')]
  JMediaStore = interface(JObject)
    ['{0E08BF0A-0312-4F84-85B7-261A5AABA092}']
  end;
  TJMediaStore = class(TJavaGenericImport<JMediaStoreClass, JMediaStore>) end;

  JMediaStore_AudioClass = interface(JObjectClass)
    ['{CA79759B-EAAE-44BE-A4B3-4240E9B55D60}']
    {class} function init: JMediaStore_Audio; cdecl;
    {class} function keyFor(name: JString): JString; cdecl;
  end;

  [JavaSignature('android/provider/MediaStore$Audio')]
  JMediaStore_Audio = interface(JObject)
    ['{492E32A0-816F-4BCE-9EFA-BB24D53518F3}']
  end;
  TJMediaStore_Audio = class(TJavaGenericImport<JMediaStore_AudioClass, JMediaStore_Audio>) end;

  JAudio_AlbumColumnsClass = interface(IJavaClass)
    ['{98AF12FB-6DE3-4F9E-8B06-8463A45D06E2}']
    {class} function _GetALBUM: JString; cdecl;
    {class} function _GetALBUM_ART: JString; cdecl;
    {class} function _GetALBUM_ID: JString; cdecl;
    {class} function _GetALBUM_KEY: JString; cdecl;
    {class} function _GetARTIST: JString; cdecl;
    {class} function _GetFIRST_YEAR: JString; cdecl;
    {class} function _GetLAST_YEAR: JString; cdecl;
    {class} function _GetNUMBER_OF_SONGS: JString; cdecl;
    {class} function _GetNUMBER_OF_SONGS_FOR_ARTIST: JString; cdecl;
    {class} property ALBUM: JString read _GetALBUM;
    {class} property ALBUM_ART: JString read _GetALBUM_ART;
    {class} property ALBUM_ID: JString read _GetALBUM_ID;
    {class} property ALBUM_KEY: JString read _GetALBUM_KEY;
    {class} property ARTIST: JString read _GetARTIST;
    {class} property FIRST_YEAR: JString read _GetFIRST_YEAR;
    {class} property LAST_YEAR: JString read _GetLAST_YEAR;
    {class} property NUMBER_OF_SONGS: JString read _GetNUMBER_OF_SONGS;
    {class} property NUMBER_OF_SONGS_FOR_ARTIST: JString read _GetNUMBER_OF_SONGS_FOR_ARTIST;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$AlbumColumns')]
  JAudio_AlbumColumns = interface(IJavaInstance)
    ['{B212F20F-FD71-44F3-8D04-D8E75E357D47}']
  end;
  TJAudio_AlbumColumns = class(TJavaGenericImport<JAudio_AlbumColumnsClass, JAudio_AlbumColumns>) end;

  JAudio_AlbumsClass = interface(JObjectClass)
    ['{2A26AD71-03E9-4D6D-B102-8EA01278768D}']
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetENTRY_CONTENT_TYPE: JString; cdecl;
    {class} function _GetEXTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetINTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function init: JAudio_Albums; cdecl;
    {class} function getContentUri(volumeName: JString): Jnet_Uri; cdecl;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property ENTRY_CONTENT_TYPE: JString read _GetENTRY_CONTENT_TYPE;
    {class} property EXTERNAL_CONTENT_URI: Jnet_Uri read _GetEXTERNAL_CONTENT_URI;
    {class} property INTERNAL_CONTENT_URI: Jnet_Uri read _GetINTERNAL_CONTENT_URI;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$Albums')]
  JAudio_Albums = interface(JObject)
    ['{828C1395-B307-49DC-B92A-D7D54BA5F2F7}']
  end;
  TJAudio_Albums = class(TJavaGenericImport<JAudio_AlbumsClass, JAudio_Albums>) end;

  JAudio_ArtistColumnsClass = interface(IJavaClass)
    ['{8509DA18-5D02-41F0-8F88-2773FB4BA13D}']
    {class} function _GetARTIST: JString; cdecl;
    {class} function _GetARTIST_KEY: JString; cdecl;
    {class} function _GetNUMBER_OF_ALBUMS: JString; cdecl;
    {class} function _GetNUMBER_OF_TRACKS: JString; cdecl;
    {class} property ARTIST: JString read _GetARTIST;
    {class} property ARTIST_KEY: JString read _GetARTIST_KEY;
    {class} property NUMBER_OF_ALBUMS: JString read _GetNUMBER_OF_ALBUMS;
    {class} property NUMBER_OF_TRACKS: JString read _GetNUMBER_OF_TRACKS;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$ArtistColumns')]
  JAudio_ArtistColumns = interface(IJavaInstance)
    ['{F6666306-DFED-4271-ABB4-941BFBEF0EBE}']
  end;
  TJAudio_ArtistColumns = class(TJavaGenericImport<JAudio_ArtistColumnsClass, JAudio_ArtistColumns>) end;

  JAudio_ArtistsClass = interface(JObjectClass)
    ['{873AC565-C58A-444E-BDED-5E1FF5A6CBFF}']
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetENTRY_CONTENT_TYPE: JString; cdecl;
    {class} function _GetEXTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetINTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function init: JAudio_Artists; cdecl;
    {class} function getContentUri(volumeName: JString): Jnet_Uri; cdecl;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property ENTRY_CONTENT_TYPE: JString read _GetENTRY_CONTENT_TYPE;
    {class} property EXTERNAL_CONTENT_URI: Jnet_Uri read _GetEXTERNAL_CONTENT_URI;
    {class} property INTERNAL_CONTENT_URI: Jnet_Uri read _GetINTERNAL_CONTENT_URI;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$Artists')]
  JAudio_Artists = interface(JObject)
    ['{C5095A12-83FA-4BB2-B4F2-EF64F6AFB0A2}']
  end;
  TJAudio_Artists = class(TJavaGenericImport<JAudio_ArtistsClass, JAudio_Artists>) end;

  JArtists_AlbumsClass = interface(JObjectClass)
    ['{35A10FA0-4A8A-4DF3-A1F0-EE3B0D7495E0}']
    {class} function init: JArtists_Albums; cdecl;
    {class} function getContentUri(volumeName: JString; artistId: Int64): Jnet_Uri; cdecl;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$Artists$Albums')]
  JArtists_Albums = interface(JObject)
    ['{2CF80079-CF70-477E-9F0A-2C8DBE6C6023}']
  end;
  TJArtists_Albums = class(TJavaGenericImport<JArtists_AlbumsClass, JArtists_Albums>) end;

  JMediaStore_MediaColumnsClass = interface(JBaseColumnsClass)
    ['{E1FD16C8-BECB-4C8D-B895-2133F7F1C341}']
    {class} function _GetDATA: JString; cdecl;
    {class} function _GetDATE_ADDED: JString; cdecl;
    {class} function _GetDATE_MODIFIED: JString; cdecl;
    {class} function _GetDISPLAY_NAME: JString; cdecl;
    {class} function _GetHEIGHT: JString; cdecl;
    {class} function _GetMIME_TYPE: JString; cdecl;
    {class} function _GetSIZE: JString; cdecl;
    {class} function _GetTITLE: JString; cdecl;
    {class} function _GetWIDTH: JString; cdecl;
    {class} property DATA: JString read _GetDATA;
    {class} property DATE_ADDED: JString read _GetDATE_ADDED;
    {class} property DATE_MODIFIED: JString read _GetDATE_MODIFIED;
    {class} property DISPLAY_NAME: JString read _GetDISPLAY_NAME;
    {class} property HEIGHT: JString read _GetHEIGHT;
    {class} property MIME_TYPE: JString read _GetMIME_TYPE;
    {class} property SIZE: JString read _GetSIZE;
    {class} property TITLE: JString read _GetTITLE;
    {class} property WIDTH: JString read _GetWIDTH;
  end;

  [JavaSignature('android/provider/MediaStore$MediaColumns')]
  JMediaStore_MediaColumns = interface(JBaseColumns)
    ['{464D6D3C-96B3-46A3-9328-4D46DEDF10F4}']
  end;
  TJMediaStore_MediaColumns = class(TJavaGenericImport<JMediaStore_MediaColumnsClass, JMediaStore_MediaColumns>) end;

  JAudio_AudioColumnsClass = interface(JMediaStore_MediaColumnsClass)
    ['{A9488C47-84FD-4900-AA5A-6DDC65B00EAB}']
    {class} function _GetALBUM: JString; cdecl;
    {class} function _GetALBUM_ID: JString; cdecl;
    {class} function _GetALBUM_KEY: JString; cdecl;
    {class} function _GetARTIST: JString; cdecl;
    {class} function _GetARTIST_ID: JString; cdecl;
    {class} function _GetARTIST_KEY: JString; cdecl;
    {class} function _GetBOOKMARK: JString; cdecl;
    {class} function _GetCOMPOSER: JString; cdecl;
    {class} function _GetDURATION: JString; cdecl;
    {class} function _GetIS_ALARM: JString; cdecl;
    {class} function _GetIS_MUSIC: JString; cdecl;
    {class} function _GetIS_NOTIFICATION: JString; cdecl;
    {class} function _GetIS_PODCAST: JString; cdecl;
    {class} function _GetIS_RINGTONE: JString; cdecl;
    {class} function _GetTITLE_KEY: JString; cdecl;
    {class} function _GetTRACK: JString; cdecl;
    {class} function _GetYEAR: JString; cdecl;
    {class} property ALBUM: JString read _GetALBUM;
    {class} property ALBUM_ID: JString read _GetALBUM_ID;
    {class} property ALBUM_KEY: JString read _GetALBUM_KEY;
    {class} property ARTIST: JString read _GetARTIST;
    {class} property ARTIST_ID: JString read _GetARTIST_ID;
    {class} property ARTIST_KEY: JString read _GetARTIST_KEY;
    {class} property BOOKMARK: JString read _GetBOOKMARK;
    {class} property COMPOSER: JString read _GetCOMPOSER;
    {class} property DURATION: JString read _GetDURATION;
    {class} property IS_ALARM: JString read _GetIS_ALARM;
    {class} property IS_MUSIC: JString read _GetIS_MUSIC;
    {class} property IS_NOTIFICATION: JString read _GetIS_NOTIFICATION;
    {class} property IS_PODCAST: JString read _GetIS_PODCAST;
    {class} property IS_RINGTONE: JString read _GetIS_RINGTONE;
    {class} property TITLE_KEY: JString read _GetTITLE_KEY;
    {class} property TRACK: JString read _GetTRACK;
    {class} property YEAR: JString read _GetYEAR;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$AudioColumns')]
  JAudio_AudioColumns = interface(JMediaStore_MediaColumns)
    ['{A8403679-E9A9-416A-829E-F39D1E4772D2}']
  end;
  TJAudio_AudioColumns = class(TJavaGenericImport<JAudio_AudioColumnsClass, JAudio_AudioColumns>) end;

  JAudio_GenresClass = interface(JObjectClass)
    ['{2D5E7697-D2AE-469F-919A-C895055A7936}']
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetENTRY_CONTENT_TYPE: JString; cdecl;
    {class} function _GetEXTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetINTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function init: JAudio_Genres; cdecl;
    {class} function getContentUri(volumeName: JString): Jnet_Uri; cdecl;
    {class} function getContentUriForAudioId(volumeName: JString; audioId: Integer): Jnet_Uri; cdecl;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property ENTRY_CONTENT_TYPE: JString read _GetENTRY_CONTENT_TYPE;
    {class} property EXTERNAL_CONTENT_URI: Jnet_Uri read _GetEXTERNAL_CONTENT_URI;
    {class} property INTERNAL_CONTENT_URI: Jnet_Uri read _GetINTERNAL_CONTENT_URI;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$Genres')]
  JAudio_Genres = interface(JObject)
    ['{100DAE19-058A-48EA-B0DA-E9C18A2138C2}']
  end;
  TJAudio_Genres = class(TJavaGenericImport<JAudio_GenresClass, JAudio_Genres>) end;

  JGenres_MembersClass = interface(JObjectClass)
    ['{9F92E76B-593A-4B90-AA93-C6ACD6AB0E42}']
    {class} function _GetAUDIO_ID: JString; cdecl;
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetGENRE_ID: JString; cdecl;
    {class} function init: JGenres_Members; cdecl;
    {class} function getContentUri(volumeName: JString; genreId: Int64): Jnet_Uri; cdecl;
    {class} property AUDIO_ID: JString read _GetAUDIO_ID;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property GENRE_ID: JString read _GetGENRE_ID;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$Genres$Members')]
  JGenres_Members = interface(JObject)
    ['{C2CE0AE2-C138-4167-A4CB-3C66BC3460FD}']
  end;
  TJGenres_Members = class(TJavaGenericImport<JGenres_MembersClass, JGenres_Members>) end;

  JAudio_GenresColumnsClass = interface(IJavaClass)
    ['{3A8F64EE-DF92-4EE7-9199-28BE3DD9A3F7}']
    {class} function _GetNAME: JString; cdecl;
    {class} property NAME: JString read _GetNAME;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$GenresColumns')]
  JAudio_GenresColumns = interface(IJavaInstance)
    ['{90711D49-47C9-447C-B455-B3F3E57E100F}']
  end;
  TJAudio_GenresColumns = class(TJavaGenericImport<JAudio_GenresColumnsClass, JAudio_GenresColumns>) end;

  JAudio_MediaClass = interface(JObjectClass)
    ['{091F5BE5-A7B0-4613-875B-50FD1ECDCB21}']
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetENTRY_CONTENT_TYPE: JString; cdecl;
    {class} function _GetEXTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetEXTRA_MAX_BYTES: JString; cdecl;
    {class} function _GetINTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetRECORD_SOUND_ACTION: JString; cdecl;
    {class} function init: JAudio_Media; cdecl;
    {class} function getContentUri(volumeName: JString): Jnet_Uri; cdecl;
    {class} function getContentUriForPath(path: JString): Jnet_Uri; cdecl;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property ENTRY_CONTENT_TYPE: JString read _GetENTRY_CONTENT_TYPE;
    {class} property EXTERNAL_CONTENT_URI: Jnet_Uri read _GetEXTERNAL_CONTENT_URI;
    {class} property EXTRA_MAX_BYTES: JString read _GetEXTRA_MAX_BYTES;
    {class} property INTERNAL_CONTENT_URI: Jnet_Uri read _GetINTERNAL_CONTENT_URI;
    {class} property RECORD_SOUND_ACTION: JString read _GetRECORD_SOUND_ACTION;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$Media')]
  JAudio_Media = interface(JObject)
    ['{9071FFB7-40D5-4090-AA01-51DD92852D3D}']
  end;
  TJAudio_Media = class(TJavaGenericImport<JAudio_MediaClass, JAudio_Media>) end;

  JAudio_PlaylistsClass = interface(JObjectClass)
    ['{7C1CAE82-7939-4928-9E06-D8D7B8731381}']
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetENTRY_CONTENT_TYPE: JString; cdecl;
    {class} function _GetEXTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetINTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function init: JAudio_Playlists; cdecl;
    {class} function getContentUri(volumeName: JString): Jnet_Uri; cdecl;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property ENTRY_CONTENT_TYPE: JString read _GetENTRY_CONTENT_TYPE;
    {class} property EXTERNAL_CONTENT_URI: Jnet_Uri read _GetEXTERNAL_CONTENT_URI;
    {class} property INTERNAL_CONTENT_URI: Jnet_Uri read _GetINTERNAL_CONTENT_URI;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$Playlists')]
  JAudio_Playlists = interface(JObject)
    ['{8F3F37B9-A743-41A0-8E48-A4E0A339E338}']
  end;
  TJAudio_Playlists = class(TJavaGenericImport<JAudio_PlaylistsClass, JAudio_Playlists>) end;

  JPlaylists_MembersClass = interface(JObjectClass)
    ['{AF0599FB-D445-4BA5-9016-8A255805AA8E}']
    {class} function _GetAUDIO_ID: JString; cdecl;
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetPLAYLIST_ID: JString; cdecl;
    {class} function _GetPLAY_ORDER: JString; cdecl;
    {class} function _Get_ID: JString; cdecl;
    {class} function init: JPlaylists_Members; cdecl;
    {class} function getContentUri(volumeName: JString; playlistId: Int64): Jnet_Uri; cdecl;
    {class} function moveItem(res: JContentResolver; playlistId: Int64; from: Integer; to_: Integer): Boolean; cdecl;
    {class} property AUDIO_ID: JString read _GetAUDIO_ID;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property PLAYLIST_ID: JString read _GetPLAYLIST_ID;
    {class} property PLAY_ORDER: JString read _GetPLAY_ORDER;
    {class} property _ID: JString read _Get_ID;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$Playlists$Members')]
  JPlaylists_Members = interface(JObject)
    ['{704AE7AB-DEB5-4015-B94D-D7A3A14CB5FA}']
  end;
  TJPlaylists_Members = class(TJavaGenericImport<JPlaylists_MembersClass, JPlaylists_Members>) end;

  JAudio_PlaylistsColumnsClass = interface(IJavaClass)
    ['{D6BF287D-2B2D-43DC-B70B-82B3AF310A8A}']
    {class} function _GetDATA: JString; cdecl;
    {class} function _GetDATE_ADDED: JString; cdecl;
    {class} function _GetDATE_MODIFIED: JString; cdecl;
    {class} function _GetNAME: JString; cdecl;
    {class} property DATA: JString read _GetDATA;
    {class} property DATE_ADDED: JString read _GetDATE_ADDED;
    {class} property DATE_MODIFIED: JString read _GetDATE_MODIFIED;
    {class} property NAME: JString read _GetNAME;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$PlaylistsColumns')]
  JAudio_PlaylistsColumns = interface(IJavaInstance)
    ['{00754FBD-3E95-45F3-AAF3-C35C76BA486C}']
  end;
  TJAudio_PlaylistsColumns = class(TJavaGenericImport<JAudio_PlaylistsColumnsClass, JAudio_PlaylistsColumns>) end;

  JAudio_RadioClass = interface(JObjectClass)
    ['{B9F342D6-05BC-411D-BC29-80F199282EBD}']
    {class} function _GetENTRY_CONTENT_TYPE: JString; cdecl;
    {class} property ENTRY_CONTENT_TYPE: JString read _GetENTRY_CONTENT_TYPE;
  end;

  [JavaSignature('android/provider/MediaStore$Audio$Radio')]
  JAudio_Radio = interface(JObject)
    ['{56FC497D-5C81-4C14-9946-48E3BE08F048}']
  end;
  TJAudio_Radio = class(TJavaGenericImport<JAudio_RadioClass, JAudio_Radio>) end;

  JMediaStore_FilesClass = interface(JObjectClass)
    ['{68751751-AB25-4D16-9AE0-07B3F4168DCC}']
    {class} function init: JMediaStore_Files; cdecl;
    {class} function getContentUri(volumeName: JString): Jnet_Uri; cdecl; overload;
    {class} function getContentUri(volumeName: JString; rowId: Int64): Jnet_Uri; cdecl; overload;
  end;

  [JavaSignature('android/provider/MediaStore$Files')]
  JMediaStore_Files = interface(JObject)
    ['{D5BC722B-B676-42A4-8A64-450095C56B3F}']
  end;
  TJMediaStore_Files = class(TJavaGenericImport<JMediaStore_FilesClass, JMediaStore_Files>) end;

  JFiles_FileColumnsClass = interface(JMediaStore_MediaColumnsClass)
    ['{7B8F8B47-E137-4D52-9861-713F016D32DF}']
    {class} function _GetMEDIA_TYPE: JString; cdecl;
    {class} function _GetMEDIA_TYPE_AUDIO: Integer; cdecl;
    {class} function _GetMEDIA_TYPE_IMAGE: Integer; cdecl;
    {class} function _GetMEDIA_TYPE_NONE: Integer; cdecl;
    {class} function _GetMEDIA_TYPE_PLAYLIST: Integer; cdecl;
    {class} function _GetMEDIA_TYPE_VIDEO: Integer; cdecl;
    {class} function _GetMIME_TYPE: JString; cdecl;
    {class} function _GetPARENT: JString; cdecl;
    {class} function _GetTITLE: JString; cdecl;
    {class} property MEDIA_TYPE: JString read _GetMEDIA_TYPE;
    {class} property MEDIA_TYPE_AUDIO: Integer read _GetMEDIA_TYPE_AUDIO;
    {class} property MEDIA_TYPE_IMAGE: Integer read _GetMEDIA_TYPE_IMAGE;
    {class} property MEDIA_TYPE_NONE: Integer read _GetMEDIA_TYPE_NONE;
    {class} property MEDIA_TYPE_PLAYLIST: Integer read _GetMEDIA_TYPE_PLAYLIST;
    {class} property MEDIA_TYPE_VIDEO: Integer read _GetMEDIA_TYPE_VIDEO;
    {class} //MIME_TYPE is defined in parent interface
    {class} property PARENT: JString read _GetPARENT;
    {class} //TITLE is defined in parent interface
  end;

  [JavaSignature('android/provider/MediaStore$Files$FileColumns')]
  JFiles_FileColumns = interface(JMediaStore_MediaColumns)
    ['{B441D8C2-8F1C-4088-954E-53E85ADEAA10}']
  end;
  TJFiles_FileColumns = class(TJavaGenericImport<JFiles_FileColumnsClass, JFiles_FileColumns>) end;

  JMediaStore_ImagesClass = interface(JObjectClass)
    ['{F81B9015-5DDD-40B1-A2DD-752301D001BA}']
    {class} function init: JMediaStore_Images; cdecl;
  end;

  [JavaSignature('android/provider/MediaStore$Images')]
  JMediaStore_Images = interface(JObject)
    ['{52A5CB82-5EC5-41C2-A32D-DAB61080B566}']
  end;
  TJMediaStore_Images = class(TJavaGenericImport<JMediaStore_ImagesClass, JMediaStore_Images>) end;

  JImages_ImageColumnsClass = interface(JMediaStore_MediaColumnsClass)
    ['{05BF2BE0-ECA6-4780-8827-99C767171BE4}']
    {class} function _GetBUCKET_DISPLAY_NAME: JString; cdecl;
    {class} function _GetBUCKET_ID: JString; cdecl;
    {class} function _GetDATE_TAKEN: JString; cdecl;
    {class} function _GetDESCRIPTION: JString; cdecl;
    {class} function _GetIS_PRIVATE: JString; cdecl;
    {class} function _GetLATITUDE: JString; cdecl;
    {class} function _GetLONGITUDE: JString; cdecl;
    {class} function _GetMINI_THUMB_MAGIC: JString; cdecl;
    {class} function _GetORIENTATION: JString; cdecl;
    {class} function _GetPICASA_ID: JString; cdecl;
    {class} property BUCKET_DISPLAY_NAME: JString read _GetBUCKET_DISPLAY_NAME;
    {class} property BUCKET_ID: JString read _GetBUCKET_ID;
    {class} property DATE_TAKEN: JString read _GetDATE_TAKEN;
    {class} property DESCRIPTION: JString read _GetDESCRIPTION;
    {class} property IS_PRIVATE: JString read _GetIS_PRIVATE;
    {class} property LATITUDE: JString read _GetLATITUDE;
    {class} property LONGITUDE: JString read _GetLONGITUDE;
    {class} property MINI_THUMB_MAGIC: JString read _GetMINI_THUMB_MAGIC;
    {class} property ORIENTATION: JString read _GetORIENTATION;
    {class} property PICASA_ID: JString read _GetPICASA_ID;
  end;

  [JavaSignature('android/provider/MediaStore$Images$ImageColumns')]
  JImages_ImageColumns = interface(JMediaStore_MediaColumns)
    ['{0098B778-4993-4F4C-89E8-214907928444}']
  end;
  TJImages_ImageColumns = class(TJavaGenericImport<JImages_ImageColumnsClass, JImages_ImageColumns>) end;

  JImages_MediaClass = interface(JObjectClass)
    ['{01ABDE1D-B100-4BB4-9F36-39209366844E}']
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetEXTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetINTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function init: JImages_Media; cdecl;
    {class} function getBitmap(cr: JContentResolver; url: Jnet_Uri): JBitmap; cdecl;
    {class} function getContentUri(volumeName: JString): Jnet_Uri; cdecl;
    {class} function insertImage(cr: JContentResolver; imagePath: JString; name: JString; description: JString): JString; cdecl; overload;
    {class} function insertImage(cr: JContentResolver; source: JBitmap; title: JString; description: JString): JString; cdecl; overload;
    {class} function query(cr: JContentResolver; uri: Jnet_Uri; projection: TJavaObjectArray<JString>): JCursor; cdecl; overload;
    {class} function query(cr: JContentResolver; uri: Jnet_Uri; projection: TJavaObjectArray<JString>; where: JString; orderBy: JString): JCursor; cdecl; overload;
    {class} function query(cr: JContentResolver; uri: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; orderBy: JString): JCursor; cdecl; overload;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property EXTERNAL_CONTENT_URI: Jnet_Uri read _GetEXTERNAL_CONTENT_URI;
    {class} property INTERNAL_CONTENT_URI: Jnet_Uri read _GetINTERNAL_CONTENT_URI;
  end;

  [JavaSignature('android/provider/MediaStore$Images$Media')]
  JImages_Media = interface(JObject)
    ['{FCE5B254-93C2-4308-9296-9A78C66135D5}']
  end;
  TJImages_Media = class(TJavaGenericImport<JImages_MediaClass, JImages_Media>) end;

  JImages_ThumbnailsClass = interface(JObjectClass)
    ['{A25C11DA-B72B-480D-8A09-670018A80071}']
    {class} function _GetDATA: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetEXTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetFULL_SCREEN_KIND: Integer; cdecl;
    {class} function _GetHEIGHT: JString; cdecl;
    {class} function _GetIMAGE_ID: JString; cdecl;
    {class} function _GetINTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetKIND: JString; cdecl;
    {class} function _GetMICRO_KIND: Integer; cdecl;
    {class} function _GetMINI_KIND: Integer; cdecl;
    {class} function _GetTHUMB_DATA: JString; cdecl;
    {class} function _GetWIDTH: JString; cdecl;
    {class} function init: JImages_Thumbnails; cdecl;
    {class} procedure cancelThumbnailRequest(cr: JContentResolver; origId: Int64); cdecl; overload;
    {class} procedure cancelThumbnailRequest(cr: JContentResolver; origId: Int64; groupId: Int64); cdecl; overload;
    {class} function getContentUri(volumeName: JString): Jnet_Uri; cdecl;
    {class} function getThumbnail(cr: JContentResolver; origId: Int64; kind: Integer; options: JBitmapFactory_Options): JBitmap; cdecl; overload;
    {class} function getThumbnail(cr: JContentResolver; origId: Int64; groupId: Int64; kind: Integer; options: JBitmapFactory_Options): JBitmap; cdecl; overload;
    {class} function query(cr: JContentResolver; uri: Jnet_Uri; projection: TJavaObjectArray<JString>): JCursor; cdecl;
    {class} function queryMiniThumbnail(cr: JContentResolver; origId: Int64; kind: Integer; projection: TJavaObjectArray<JString>): JCursor; cdecl;
    {class} function queryMiniThumbnails(cr: JContentResolver; uri: Jnet_Uri; kind: Integer; projection: TJavaObjectArray<JString>): JCursor; cdecl;
    {class} property DATA: JString read _GetDATA;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property EXTERNAL_CONTENT_URI: Jnet_Uri read _GetEXTERNAL_CONTENT_URI;
    {class} property FULL_SCREEN_KIND: Integer read _GetFULL_SCREEN_KIND;
    {class} property HEIGHT: JString read _GetHEIGHT;
    {class} property IMAGE_ID: JString read _GetIMAGE_ID;
    {class} property INTERNAL_CONTENT_URI: Jnet_Uri read _GetINTERNAL_CONTENT_URI;
    {class} property KIND: JString read _GetKIND;
    {class} property MICRO_KIND: Integer read _GetMICRO_KIND;
    {class} property MINI_KIND: Integer read _GetMINI_KIND;
    {class} property THUMB_DATA: JString read _GetTHUMB_DATA;
    {class} property WIDTH: JString read _GetWIDTH;
  end;

  [JavaSignature('android/provider/MediaStore$Images$Thumbnails')]
  JImages_Thumbnails = interface(JObject)
    ['{29CB9363-CD45-4C6E-86EF-FD421A2C7A11}']
  end;
  TJImages_Thumbnails = class(TJavaGenericImport<JImages_ThumbnailsClass, JImages_Thumbnails>) end;

  JMediaStore_VideoClass = interface(JObjectClass)
    ['{D9A58E17-710A-4A56-9458-9EF0DB46F648}']
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function init: JMediaStore_Video; cdecl;
    {class} function query(cr: JContentResolver; uri: Jnet_Uri; projection: TJavaObjectArray<JString>): JCursor; cdecl;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/MediaStore$Video')]
  JMediaStore_Video = interface(JObject)
    ['{CAE402A2-BA43-49F5-AD99-E94DA89BD851}']
  end;
  TJMediaStore_Video = class(TJavaGenericImport<JMediaStore_VideoClass, JMediaStore_Video>) end;

  JVideo_MediaClass = interface(JObjectClass)
    ['{1689E04F-43C7-4B53-936B-886E4A5F677A}']
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetEXTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetINTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function init: JVideo_Media; cdecl;
    {class} function getContentUri(volumeName: JString): Jnet_Uri; cdecl;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property EXTERNAL_CONTENT_URI: Jnet_Uri read _GetEXTERNAL_CONTENT_URI;
    {class} property INTERNAL_CONTENT_URI: Jnet_Uri read _GetINTERNAL_CONTENT_URI;
  end;

  [JavaSignature('android/provider/MediaStore$Video$Media')]
  JVideo_Media = interface(JObject)
    ['{8B179599-8165-4E55-B17D-E576BC51E3C6}']
  end;
  TJVideo_Media = class(TJavaGenericImport<JVideo_MediaClass, JVideo_Media>) end;

  JVideo_ThumbnailsClass = interface(JObjectClass)
    ['{5E05E9B0-E775-4D97-A7DC-6C5A9DB081D0}']
    {class} function _GetDATA: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetEXTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetFULL_SCREEN_KIND: Integer; cdecl;
    {class} function _GetHEIGHT: JString; cdecl;
    {class} function _GetINTERNAL_CONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetKIND: JString; cdecl;
    {class} function _GetMICRO_KIND: Integer; cdecl;
    {class} function _GetMINI_KIND: Integer; cdecl;
    {class} function _GetVIDEO_ID: JString; cdecl;
    {class} function _GetWIDTH: JString; cdecl;
    {class} function init: JVideo_Thumbnails; cdecl;
    {class} procedure cancelThumbnailRequest(cr: JContentResolver; origId: Int64); cdecl; overload;
    {class} procedure cancelThumbnailRequest(cr: JContentResolver; origId: Int64; groupId: Int64); cdecl; overload;
    {class} function getContentUri(volumeName: JString): Jnet_Uri; cdecl;
    {class} function getThumbnail(cr: JContentResolver; origId: Int64; kind: Integer; options: JBitmapFactory_Options): JBitmap; cdecl; overload;
    {class} function getThumbnail(cr: JContentResolver; origId: Int64; groupId: Int64; kind: Integer; options: JBitmapFactory_Options): JBitmap; cdecl; overload;
    {class} property DATA: JString read _GetDATA;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property EXTERNAL_CONTENT_URI: Jnet_Uri read _GetEXTERNAL_CONTENT_URI;
    {class} property FULL_SCREEN_KIND: Integer read _GetFULL_SCREEN_KIND;
    {class} property HEIGHT: JString read _GetHEIGHT;
    {class} property INTERNAL_CONTENT_URI: Jnet_Uri read _GetINTERNAL_CONTENT_URI;
    {class} property KIND: JString read _GetKIND;
    {class} property MICRO_KIND: Integer read _GetMICRO_KIND;
    {class} property MINI_KIND: Integer read _GetMINI_KIND;
    {class} property VIDEO_ID: JString read _GetVIDEO_ID;
    {class} property WIDTH: JString read _GetWIDTH;
  end;

  [JavaSignature('android/provider/MediaStore$Video$Thumbnails')]
  JVideo_Thumbnails = interface(JObject)
    ['{67417EE7-B1A0-45B3-A1D2-B6ADFE8A5446}']
  end;
  TJVideo_Thumbnails = class(TJavaGenericImport<JVideo_ThumbnailsClass, JVideo_Thumbnails>) end;

  JVideo_VideoColumnsClass = interface(JMediaStore_MediaColumnsClass)
    ['{A2BE0519-5009-47E0-AA45-28A55F103AB9}']
    {class} function _GetALBUM: JString; cdecl;
    {class} function _GetARTIST: JString; cdecl;
    {class} function _GetBOOKMARK: JString; cdecl;
    {class} function _GetBUCKET_DISPLAY_NAME: JString; cdecl;
    {class} function _GetBUCKET_ID: JString; cdecl;
    {class} function _GetCATEGORY: JString; cdecl;
    {class} function _GetDATE_TAKEN: JString; cdecl;
    {class} function _GetDESCRIPTION: JString; cdecl;
    {class} function _GetDURATION: JString; cdecl;
    {class} function _GetIS_PRIVATE: JString; cdecl;
    {class} function _GetLANGUAGE: JString; cdecl;
    {class} function _GetLATITUDE: JString; cdecl;
    {class} function _GetLONGITUDE: JString; cdecl;
    {class} function _GetMINI_THUMB_MAGIC: JString; cdecl;
    {class} function _GetRESOLUTION: JString; cdecl;
    {class} function _GetTAGS: JString; cdecl;
    {class} property ALBUM: JString read _GetALBUM;
    {class} property ARTIST: JString read _GetARTIST;
    {class} property BOOKMARK: JString read _GetBOOKMARK;
    {class} property BUCKET_DISPLAY_NAME: JString read _GetBUCKET_DISPLAY_NAME;
    {class} property BUCKET_ID: JString read _GetBUCKET_ID;
    {class} property CATEGORY: JString read _GetCATEGORY;
    {class} property DATE_TAKEN: JString read _GetDATE_TAKEN;
    {class} property DESCRIPTION: JString read _GetDESCRIPTION;
    {class} property DURATION: JString read _GetDURATION;
    {class} property IS_PRIVATE: JString read _GetIS_PRIVATE;
    {class} property LANGUAGE: JString read _GetLANGUAGE;
    {class} property LATITUDE: JString read _GetLATITUDE;
    {class} property LONGITUDE: JString read _GetLONGITUDE;
    {class} property MINI_THUMB_MAGIC: JString read _GetMINI_THUMB_MAGIC;
    {class} property RESOLUTION: JString read _GetRESOLUTION;
    {class} property TAGS: JString read _GetTAGS;
  end;

  [JavaSignature('android/provider/MediaStore$Video$VideoColumns')]
  JVideo_VideoColumns = interface(JMediaStore_MediaColumns)
    ['{79F06E41-8BA5-483A-93F2-11E1CE4186F2}']
  end;
  TJVideo_VideoColumns = class(TJavaGenericImport<JVideo_VideoColumnsClass, JVideo_VideoColumns>) end;

  JOpenableColumnsClass = interface(IJavaClass)
    ['{C93AB313-45FA-49F2-9C32-83F4F92A1CF5}']
    {class} function _GetDISPLAY_NAME: JString; cdecl;
    {class} function _GetSIZE: JString; cdecl;
    {class} property DISPLAY_NAME: JString read _GetDISPLAY_NAME;
    {class} property SIZE: JString read _GetSIZE;
  end;

  [JavaSignature('android/provider/OpenableColumns')]
  JOpenableColumns = interface(IJavaInstance)
    ['{68A240FC-99B9-4153-9CE6-E15D4BD68F80}']
  end;
  TJOpenableColumns = class(TJavaGenericImport<JOpenableColumnsClass, JOpenableColumns>) end;

  JSearchRecentSuggestionsClass = interface(JObjectClass)
    ['{1F92F95B-3389-47E1-BE54-81F6764D2F1C}']
    {class} function _GetQUERIES_PROJECTION_1LINE: TJavaObjectArray<JString>; cdecl;
    {class} function _GetQUERIES_PROJECTION_2LINE: TJavaObjectArray<JString>; cdecl;
    {class} function _GetQUERIES_PROJECTION_DATE_INDEX: Integer; cdecl;
    {class} function _GetQUERIES_PROJECTION_DISPLAY1_INDEX: Integer; cdecl;
    {class} function _GetQUERIES_PROJECTION_DISPLAY2_INDEX: Integer; cdecl;
    {class} function _GetQUERIES_PROJECTION_QUERY_INDEX: Integer; cdecl;
    {class} function init(context: JContext; authority: JString; mode: Integer): JSearchRecentSuggestions; cdecl;
    {class} property QUERIES_PROJECTION_1LINE: TJavaObjectArray<JString> read _GetQUERIES_PROJECTION_1LINE;
    {class} property QUERIES_PROJECTION_2LINE: TJavaObjectArray<JString> read _GetQUERIES_PROJECTION_2LINE;
    {class} property QUERIES_PROJECTION_DATE_INDEX: Integer read _GetQUERIES_PROJECTION_DATE_INDEX;
    {class} property QUERIES_PROJECTION_DISPLAY1_INDEX: Integer read _GetQUERIES_PROJECTION_DISPLAY1_INDEX;
    {class} property QUERIES_PROJECTION_DISPLAY2_INDEX: Integer read _GetQUERIES_PROJECTION_DISPLAY2_INDEX;
    {class} property QUERIES_PROJECTION_QUERY_INDEX: Integer read _GetQUERIES_PROJECTION_QUERY_INDEX;
  end;

  [JavaSignature('android/provider/SearchRecentSuggestions')]
  JSearchRecentSuggestions = interface(JObject)
    ['{B35840AF-5E60-430E-B147-9F41195FC142}']
    procedure clearHistory; cdecl;
    procedure saveRecentQuery(queryString: JString; line2: JString); cdecl;
  end;
  TJSearchRecentSuggestions = class(TJavaGenericImport<JSearchRecentSuggestionsClass, JSearchRecentSuggestions>) end;

  JSettingsClass = interface(JObjectClass)
    ['{DA4ED294-FDE4-4090-BB0A-1013E7217DE7}']
    {class} function _GetACTION_ACCESSIBILITY_SETTINGS: JString; cdecl;
    {class} function _GetACTION_ADD_ACCOUNT: JString; cdecl;
    {class} function _GetACTION_AIRPLANE_MODE_SETTINGS: JString; cdecl;
    {class} function _GetACTION_APN_SETTINGS: JString; cdecl;
    {class} function _GetACTION_APPLICATION_DETAILS_SETTINGS: JString; cdecl;
    {class} function _GetACTION_APPLICATION_DEVELOPMENT_SETTINGS: JString; cdecl;
    {class} function _GetACTION_APPLICATION_SETTINGS: JString; cdecl;
    {class} function _GetACTION_BATTERY_SAVER_SETTINGS: JString; cdecl;
    {class} function _GetACTION_BLUETOOTH_SETTINGS: JString; cdecl;
    {class} function _GetACTION_CAPTIONING_SETTINGS: JString; cdecl;
    {class} function _GetACTION_CAST_SETTINGS: JString; cdecl;
    {class} function _GetACTION_DATA_ROAMING_SETTINGS: JString; cdecl;
    {class} function _GetACTION_DATE_SETTINGS: JString; cdecl;
    {class} function _GetACTION_DEVICE_INFO_SETTINGS: JString; cdecl;
    {class} function _GetACTION_DISPLAY_SETTINGS: JString; cdecl;
    {class} function _GetACTION_DREAM_SETTINGS: JString; cdecl;
    {class} function _GetACTION_HOME_SETTINGS: JString; cdecl;
    {class} function _GetACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS: JString; cdecl;
    {class} function _GetACTION_INPUT_METHOD_SETTINGS: JString; cdecl;
    {class} function _GetACTION_INPUT_METHOD_SUBTYPE_SETTINGS: JString; cdecl;
    {class} function _GetACTION_INTERNAL_STORAGE_SETTINGS: JString; cdecl;
    {class} function _GetACTION_LOCALE_SETTINGS: JString; cdecl;
    {class} function _GetACTION_LOCATION_SOURCE_SETTINGS: JString; cdecl;
    {class} function _GetACTION_MANAGE_ALL_APPLICATIONS_SETTINGS: JString; cdecl;
    {class} function _GetACTION_MANAGE_APPLICATIONS_SETTINGS: JString; cdecl;
    {class} function _GetACTION_MANAGE_OVERLAY_PERMISSION: JString; cdecl;
    {class} function _GetACTION_MANAGE_WRITE_SETTINGS: JString; cdecl;
    {class} function _GetACTION_MEMORY_CARD_SETTINGS: JString; cdecl;
    {class} function _GetACTION_NETWORK_OPERATOR_SETTINGS: JString; cdecl;
    {class} function _GetACTION_NFCSHARING_SETTINGS: JString; cdecl;
    {class} function _GetACTION_NFC_PAYMENT_SETTINGS: JString; cdecl;
    {class} function _GetACTION_NFC_SETTINGS: JString; cdecl;
    {class} function _GetACTION_NOTIFICATION_LISTENER_SETTINGS: JString; cdecl;
    {class} function _GetACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS: JString; cdecl;
    {class} function _GetACTION_PRINT_SETTINGS: JString; cdecl;
    {class} function _GetACTION_PRIVACY_SETTINGS: JString; cdecl;
    {class} function _GetACTION_QUICK_LAUNCH_SETTINGS: JString; cdecl;
    {class} function _GetACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS: JString; cdecl;
    {class} function _GetACTION_SEARCH_SETTINGS: JString; cdecl;
    {class} function _GetACTION_SECURITY_SETTINGS: JString; cdecl;
    {class} function _GetACTION_SETTINGS: JString; cdecl;
    {class} function _GetACTION_SHOW_REGULATORY_INFO: JString; cdecl;
    {class} function _GetACTION_SOUND_SETTINGS: JString; cdecl;
    {class} function _GetACTION_SYNC_SETTINGS: JString; cdecl;
    {class} function _GetACTION_USAGE_ACCESS_SETTINGS: JString; cdecl;
    {class} function _GetACTION_USER_DICTIONARY_SETTINGS: JString; cdecl;
    {class} function _GetACTION_VOICE_CONTROL_AIRPLANE_MODE: JString; cdecl;
    {class} function _GetACTION_VOICE_CONTROL_BATTERY_SAVER_MODE: JString; cdecl;
    {class} function _GetACTION_VOICE_CONTROL_DO_NOT_DISTURB_MODE: JString; cdecl;
    {class} function _GetACTION_VOICE_INPUT_SETTINGS: JString; cdecl;
    {class} function _GetACTION_WIFI_IP_SETTINGS: JString; cdecl;
    {class} function _GetACTION_WIFI_SETTINGS: JString; cdecl;
    {class} function _GetACTION_WIRELESS_SETTINGS: JString; cdecl;
    {class} function _GetAUTHORITY: JString; cdecl;
    {class} function _GetEXTRA_ACCOUNT_TYPES: JString; cdecl;
    {class} function _GetEXTRA_AIRPLANE_MODE_ENABLED: JString; cdecl;
    {class} function _GetEXTRA_AUTHORITIES: JString; cdecl;
    {class} function _GetEXTRA_BATTERY_SAVER_MODE_ENABLED: JString; cdecl;
    {class} function _GetEXTRA_DO_NOT_DISTURB_MODE_ENABLED: JString; cdecl;
    {class} function _GetEXTRA_DO_NOT_DISTURB_MODE_MINUTES: JString; cdecl;
    {class} function _GetEXTRA_INPUT_METHOD_ID: JString; cdecl;
    {class} function _GetINTENT_CATEGORY_USAGE_ACCESS_CONFIG: JString; cdecl;
    {class} function _GetMETADATA_USAGE_ACCESS_REASON: JString; cdecl;
    {class} function init: JSettings; cdecl;
    {class} function canDrawOverlays(context: JContext): Boolean; cdecl;
    {class} property ACTION_ACCESSIBILITY_SETTINGS: JString read _GetACTION_ACCESSIBILITY_SETTINGS;
    {class} property ACTION_ADD_ACCOUNT: JString read _GetACTION_ADD_ACCOUNT;
    {class} property ACTION_AIRPLANE_MODE_SETTINGS: JString read _GetACTION_AIRPLANE_MODE_SETTINGS;
    {class} property ACTION_APN_SETTINGS: JString read _GetACTION_APN_SETTINGS;
    {class} property ACTION_APPLICATION_DETAILS_SETTINGS: JString read _GetACTION_APPLICATION_DETAILS_SETTINGS;
    {class} property ACTION_APPLICATION_DEVELOPMENT_SETTINGS: JString read _GetACTION_APPLICATION_DEVELOPMENT_SETTINGS;
    {class} property ACTION_APPLICATION_SETTINGS: JString read _GetACTION_APPLICATION_SETTINGS;
    {class} property ACTION_BATTERY_SAVER_SETTINGS: JString read _GetACTION_BATTERY_SAVER_SETTINGS;
    {class} property ACTION_BLUETOOTH_SETTINGS: JString read _GetACTION_BLUETOOTH_SETTINGS;
    {class} property ACTION_CAPTIONING_SETTINGS: JString read _GetACTION_CAPTIONING_SETTINGS;
    {class} property ACTION_CAST_SETTINGS: JString read _GetACTION_CAST_SETTINGS;
    {class} property ACTION_DATA_ROAMING_SETTINGS: JString read _GetACTION_DATA_ROAMING_SETTINGS;
    {class} property ACTION_DATE_SETTINGS: JString read _GetACTION_DATE_SETTINGS;
    {class} property ACTION_DEVICE_INFO_SETTINGS: JString read _GetACTION_DEVICE_INFO_SETTINGS;
    {class} property ACTION_DISPLAY_SETTINGS: JString read _GetACTION_DISPLAY_SETTINGS;
    {class} property ACTION_DREAM_SETTINGS: JString read _GetACTION_DREAM_SETTINGS;
    {class} property ACTION_HOME_SETTINGS: JString read _GetACTION_HOME_SETTINGS;
    {class} property ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS: JString read _GetACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS;
    {class} property ACTION_INPUT_METHOD_SETTINGS: JString read _GetACTION_INPUT_METHOD_SETTINGS;
    {class} property ACTION_INPUT_METHOD_SUBTYPE_SETTINGS: JString read _GetACTION_INPUT_METHOD_SUBTYPE_SETTINGS;
    {class} property ACTION_INTERNAL_STORAGE_SETTINGS: JString read _GetACTION_INTERNAL_STORAGE_SETTINGS;
    {class} property ACTION_LOCALE_SETTINGS: JString read _GetACTION_LOCALE_SETTINGS;
    {class} property ACTION_LOCATION_SOURCE_SETTINGS: JString read _GetACTION_LOCATION_SOURCE_SETTINGS;
    {class} property ACTION_MANAGE_ALL_APPLICATIONS_SETTINGS: JString read _GetACTION_MANAGE_ALL_APPLICATIONS_SETTINGS;
    {class} property ACTION_MANAGE_APPLICATIONS_SETTINGS: JString read _GetACTION_MANAGE_APPLICATIONS_SETTINGS;
    {class} property ACTION_MANAGE_OVERLAY_PERMISSION: JString read _GetACTION_MANAGE_OVERLAY_PERMISSION;
    {class} property ACTION_MANAGE_WRITE_SETTINGS: JString read _GetACTION_MANAGE_WRITE_SETTINGS;
    {class} property ACTION_MEMORY_CARD_SETTINGS: JString read _GetACTION_MEMORY_CARD_SETTINGS;
    {class} property ACTION_NETWORK_OPERATOR_SETTINGS: JString read _GetACTION_NETWORK_OPERATOR_SETTINGS;
    {class} property ACTION_NFCSHARING_SETTINGS: JString read _GetACTION_NFCSHARING_SETTINGS;
    {class} property ACTION_NFC_PAYMENT_SETTINGS: JString read _GetACTION_NFC_PAYMENT_SETTINGS;
    {class} property ACTION_NFC_SETTINGS: JString read _GetACTION_NFC_SETTINGS;
    {class} property ACTION_NOTIFICATION_LISTENER_SETTINGS: JString read _GetACTION_NOTIFICATION_LISTENER_SETTINGS;
    {class} property ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS: JString read _GetACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS;
    {class} property ACTION_PRINT_SETTINGS: JString read _GetACTION_PRINT_SETTINGS;
    {class} property ACTION_PRIVACY_SETTINGS: JString read _GetACTION_PRIVACY_SETTINGS;
    {class} property ACTION_QUICK_LAUNCH_SETTINGS: JString read _GetACTION_QUICK_LAUNCH_SETTINGS;
    {class} property ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS: JString read _GetACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS;
    {class} property ACTION_SEARCH_SETTINGS: JString read _GetACTION_SEARCH_SETTINGS;
    {class} property ACTION_SECURITY_SETTINGS: JString read _GetACTION_SECURITY_SETTINGS;
    {class} property ACTION_SETTINGS: JString read _GetACTION_SETTINGS;
    {class} property ACTION_SHOW_REGULATORY_INFO: JString read _GetACTION_SHOW_REGULATORY_INFO;
    {class} property ACTION_SOUND_SETTINGS: JString read _GetACTION_SOUND_SETTINGS;
    {class} property ACTION_SYNC_SETTINGS: JString read _GetACTION_SYNC_SETTINGS;
    {class} property ACTION_USAGE_ACCESS_SETTINGS: JString read _GetACTION_USAGE_ACCESS_SETTINGS;
    {class} property ACTION_USER_DICTIONARY_SETTINGS: JString read _GetACTION_USER_DICTIONARY_SETTINGS;
    {class} property ACTION_VOICE_CONTROL_AIRPLANE_MODE: JString read _GetACTION_VOICE_CONTROL_AIRPLANE_MODE;
    {class} property ACTION_VOICE_CONTROL_BATTERY_SAVER_MODE: JString read _GetACTION_VOICE_CONTROL_BATTERY_SAVER_MODE;
    {class} property ACTION_VOICE_CONTROL_DO_NOT_DISTURB_MODE: JString read _GetACTION_VOICE_CONTROL_DO_NOT_DISTURB_MODE;
    {class} property ACTION_VOICE_INPUT_SETTINGS: JString read _GetACTION_VOICE_INPUT_SETTINGS;
    {class} property ACTION_WIFI_IP_SETTINGS: JString read _GetACTION_WIFI_IP_SETTINGS;
    {class} property ACTION_WIFI_SETTINGS: JString read _GetACTION_WIFI_SETTINGS;
    {class} property ACTION_WIRELESS_SETTINGS: JString read _GetACTION_WIRELESS_SETTINGS;
    {class} property AUTHORITY: JString read _GetAUTHORITY;
    {class} property EXTRA_ACCOUNT_TYPES: JString read _GetEXTRA_ACCOUNT_TYPES;
    {class} property EXTRA_AIRPLANE_MODE_ENABLED: JString read _GetEXTRA_AIRPLANE_MODE_ENABLED;
    {class} property EXTRA_AUTHORITIES: JString read _GetEXTRA_AUTHORITIES;
    {class} property EXTRA_BATTERY_SAVER_MODE_ENABLED: JString read _GetEXTRA_BATTERY_SAVER_MODE_ENABLED;
    {class} property EXTRA_DO_NOT_DISTURB_MODE_ENABLED: JString read _GetEXTRA_DO_NOT_DISTURB_MODE_ENABLED;
    {class} property EXTRA_DO_NOT_DISTURB_MODE_MINUTES: JString read _GetEXTRA_DO_NOT_DISTURB_MODE_MINUTES;
    {class} property EXTRA_INPUT_METHOD_ID: JString read _GetEXTRA_INPUT_METHOD_ID;
    {class} property INTENT_CATEGORY_USAGE_ACCESS_CONFIG: JString read _GetINTENT_CATEGORY_USAGE_ACCESS_CONFIG;
    {class} property METADATA_USAGE_ACCESS_REASON: JString read _GetMETADATA_USAGE_ACCESS_REASON;
  end;

  [JavaSignature('android/provider/Settings')]
  JSettings = interface(JObject)
    ['{296C670C-8213-4C1D-9C0C-928939EC7E14}']
  end;
  TJSettings = class(TJavaGenericImport<JSettingsClass, JSettings>) end;

  JSettings_NameValueTableClass = interface(JObjectClass)
    ['{38866C77-AF70-4058-818C-0A8DA4654E99}']
    {class} function _GetNAME: JString; cdecl;
    {class} function _GetVALUE: JString; cdecl;
    {class} function init: JSettings_NameValueTable; cdecl;
    {class} function getUriFor(uri: Jnet_Uri; name: JString): Jnet_Uri; cdecl;
    {class} property NAME: JString read _GetNAME;
    {class} property VALUE: JString read _GetVALUE;
  end;

  [JavaSignature('android/provider/Settings$NameValueTable')]
  JSettings_NameValueTable = interface(JObject)
    ['{F3A8C46A-507C-4F88-A045-8FE3B5E58945}']
  end;
  TJSettings_NameValueTable = class(TJavaGenericImport<JSettings_NameValueTableClass, JSettings_NameValueTable>) end;

  JSettings_GlobalClass = interface(JSettings_NameValueTableClass)
    ['{FFCD002F-D78F-46C7-9C25-A8B48EC838E9}']
    {class} function _GetADB_ENABLED: JString; cdecl;
    {class} function _GetAIRPLANE_MODE_ON: JString; cdecl;
    {class} function _GetAIRPLANE_MODE_RADIOS: JString; cdecl;
    {class} function _GetALWAYS_FINISH_ACTIVITIES: JString; cdecl;
    {class} function _GetANIMATOR_DURATION_SCALE: JString; cdecl;
    {class} function _GetAUTO_TIME: JString; cdecl;
    {class} function _GetAUTO_TIME_ZONE: JString; cdecl;
    {class} function _GetBLUETOOTH_ON: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDATA_ROAMING: JString; cdecl;
    {class} function _GetDEBUG_APP: JString; cdecl;
    {class} function _GetDEVELOPMENT_SETTINGS_ENABLED: JString; cdecl;
    {class} function _GetDEVICE_PROVISIONED: JString; cdecl;
    {class} function _GetHTTP_PROXY: JString; cdecl;
    {class} function _GetINSTALL_NON_MARKET_APPS: JString; cdecl;
    {class} function _GetMODE_RINGER: JString; cdecl;
    {class} function _GetNETWORK_PREFERENCE: JString; cdecl;
    {class} function _GetRADIO_BLUETOOTH: JString; cdecl;
    {class} function _GetRADIO_CELL: JString; cdecl;
    {class} function _GetRADIO_NFC: JString; cdecl;
    {class} function _GetRADIO_WIFI: JString; cdecl;
    {class} function _GetSHOW_PROCESSES: JString; cdecl;
    {class} function _GetSTAY_ON_WHILE_PLUGGED_IN: JString; cdecl;
    {class} function _GetSYS_PROP_SETTING_VERSION: JString; cdecl;
    {class} function _GetTRANSITION_ANIMATION_SCALE: JString; cdecl;
    {class} function _GetUSB_MASS_STORAGE_ENABLED: JString; cdecl;
    {class} function _GetUSE_GOOGLE_MAIL: JString; cdecl;
    {class} function _GetWAIT_FOR_DEBUGGER: JString; cdecl;
    {class} function _GetWIFI_DEVICE_OWNER_CONFIGS_LOCKDOWN: JString; cdecl;
    {class} function _GetWIFI_MAX_DHCP_RETRY_COUNT: JString; cdecl;
    {class} function _GetWIFI_MOBILE_DATA_TRANSITION_WAKELOCK_TIMEOUT_MS: JString; cdecl;
    {class} function _GetWIFI_NETWORKS_AVAILABLE_NOTIFICATION_ON: JString; cdecl;
    {class} function _GetWIFI_NETWORKS_AVAILABLE_REPEAT_DELAY: JString; cdecl;
    {class} function _GetWIFI_NUM_OPEN_NETWORKS_KEPT: JString; cdecl;
    {class} function _GetWIFI_ON: JString; cdecl;
    {class} function _GetWIFI_SLEEP_POLICY: JString; cdecl;
    {class} function _GetWIFI_SLEEP_POLICY_DEFAULT: Integer; cdecl;
    {class} function _GetWIFI_SLEEP_POLICY_NEVER: Integer; cdecl;
    {class} function _GetWIFI_SLEEP_POLICY_NEVER_WHILE_PLUGGED: Integer; cdecl;
    {class} function _GetWIFI_WATCHDOG_ON: JString; cdecl;
    {class} function _GetWINDOW_ANIMATION_SCALE: JString; cdecl;
    {class} function init: JSettings_Global; cdecl;
    {class} function getFloat(cr: JContentResolver; name: JString; def: Single): Single; cdecl; overload;
    {class} function getFloat(cr: JContentResolver; name: JString): Single; cdecl; overload;
    {class} function getInt(cr: JContentResolver; name: JString; def: Integer): Integer; cdecl; overload;
    {class} function getInt(cr: JContentResolver; name: JString): Integer; cdecl; overload;
    {class} function getLong(cr: JContentResolver; name: JString; def: Int64): Int64; cdecl; overload;
    {class} function getLong(cr: JContentResolver; name: JString): Int64; cdecl; overload;
    {class} function getString(resolver: JContentResolver; name: JString): JString; cdecl;
    {class} function getUriFor(name: JString): Jnet_Uri; cdecl;
    {class} function putFloat(cr: JContentResolver; name: JString; value: Single): Boolean; cdecl;
    {class} function putInt(cr: JContentResolver; name: JString; value: Integer): Boolean; cdecl;
    {class} function putLong(cr: JContentResolver; name: JString; value: Int64): Boolean; cdecl;
    {class} function putString(resolver: JContentResolver; name: JString; value: JString): Boolean; cdecl;
    {class} property ADB_ENABLED: JString read _GetADB_ENABLED;
    {class} property AIRPLANE_MODE_ON: JString read _GetAIRPLANE_MODE_ON;
    {class} property AIRPLANE_MODE_RADIOS: JString read _GetAIRPLANE_MODE_RADIOS;
    {class} property ALWAYS_FINISH_ACTIVITIES: JString read _GetALWAYS_FINISH_ACTIVITIES;
    {class} property ANIMATOR_DURATION_SCALE: JString read _GetANIMATOR_DURATION_SCALE;
    {class} property AUTO_TIME: JString read _GetAUTO_TIME;
    {class} property AUTO_TIME_ZONE: JString read _GetAUTO_TIME_ZONE;
    {class} property BLUETOOTH_ON: JString read _GetBLUETOOTH_ON;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DATA_ROAMING: JString read _GetDATA_ROAMING;
    {class} property DEBUG_APP: JString read _GetDEBUG_APP;
    {class} property DEVELOPMENT_SETTINGS_ENABLED: JString read _GetDEVELOPMENT_SETTINGS_ENABLED;
    {class} property DEVICE_PROVISIONED: JString read _GetDEVICE_PROVISIONED;
    {class} property HTTP_PROXY: JString read _GetHTTP_PROXY;
    {class} property INSTALL_NON_MARKET_APPS: JString read _GetINSTALL_NON_MARKET_APPS;
    {class} property MODE_RINGER: JString read _GetMODE_RINGER;
    {class} property NETWORK_PREFERENCE: JString read _GetNETWORK_PREFERENCE;
    {class} property RADIO_BLUETOOTH: JString read _GetRADIO_BLUETOOTH;
    {class} property RADIO_CELL: JString read _GetRADIO_CELL;
    {class} property RADIO_NFC: JString read _GetRADIO_NFC;
    {class} property RADIO_WIFI: JString read _GetRADIO_WIFI;
    {class} property SHOW_PROCESSES: JString read _GetSHOW_PROCESSES;
    {class} property STAY_ON_WHILE_PLUGGED_IN: JString read _GetSTAY_ON_WHILE_PLUGGED_IN;
    {class} property SYS_PROP_SETTING_VERSION: JString read _GetSYS_PROP_SETTING_VERSION;
    {class} property TRANSITION_ANIMATION_SCALE: JString read _GetTRANSITION_ANIMATION_SCALE;
    {class} property USB_MASS_STORAGE_ENABLED: JString read _GetUSB_MASS_STORAGE_ENABLED;
    {class} property USE_GOOGLE_MAIL: JString read _GetUSE_GOOGLE_MAIL;
    {class} property WAIT_FOR_DEBUGGER: JString read _GetWAIT_FOR_DEBUGGER;
    {class} property WIFI_DEVICE_OWNER_CONFIGS_LOCKDOWN: JString read _GetWIFI_DEVICE_OWNER_CONFIGS_LOCKDOWN;
    {class} property WIFI_MAX_DHCP_RETRY_COUNT: JString read _GetWIFI_MAX_DHCP_RETRY_COUNT;
    {class} property WIFI_MOBILE_DATA_TRANSITION_WAKELOCK_TIMEOUT_MS: JString read _GetWIFI_MOBILE_DATA_TRANSITION_WAKELOCK_TIMEOUT_MS;
    {class} property WIFI_NETWORKS_AVAILABLE_NOTIFICATION_ON: JString read _GetWIFI_NETWORKS_AVAILABLE_NOTIFICATION_ON;
    {class} property WIFI_NETWORKS_AVAILABLE_REPEAT_DELAY: JString read _GetWIFI_NETWORKS_AVAILABLE_REPEAT_DELAY;
    {class} property WIFI_NUM_OPEN_NETWORKS_KEPT: JString read _GetWIFI_NUM_OPEN_NETWORKS_KEPT;
    {class} property WIFI_ON: JString read _GetWIFI_ON;
    {class} property WIFI_SLEEP_POLICY: JString read _GetWIFI_SLEEP_POLICY;
    {class} property WIFI_SLEEP_POLICY_DEFAULT: Integer read _GetWIFI_SLEEP_POLICY_DEFAULT;
    {class} property WIFI_SLEEP_POLICY_NEVER: Integer read _GetWIFI_SLEEP_POLICY_NEVER;
    {class} property WIFI_SLEEP_POLICY_NEVER_WHILE_PLUGGED: Integer read _GetWIFI_SLEEP_POLICY_NEVER_WHILE_PLUGGED;
    {class} property WIFI_WATCHDOG_ON: JString read _GetWIFI_WATCHDOG_ON;
    {class} property WINDOW_ANIMATION_SCALE: JString read _GetWINDOW_ANIMATION_SCALE;
  end;

  [JavaSignature('android/provider/Settings$Global')]
  JSettings_Global = interface(JSettings_NameValueTable)
    ['{BE959C5F-1913-4DE9-ADF7-FDC2C040553E}']
  end;
  TJSettings_Global = class(TJavaGenericImport<JSettings_GlobalClass, JSettings_Global>) end;

  JSettings_SecureClass = interface(JSettings_NameValueTableClass)
    ['{242F3E98-E010-462C-B6DE-78C89954898F}']
    {class} function _GetACCESSIBILITY_DISPLAY_INVERSION_ENABLED: JString; cdecl;
    {class} function _GetACCESSIBILITY_ENABLED: JString; cdecl;
    {class} function _GetACCESSIBILITY_SPEAK_PASSWORD: JString; cdecl;
    {class} function _GetADB_ENABLED: JString; cdecl;
    {class} function _GetALLOWED_GEOLOCATION_ORIGINS: JString; cdecl;
    {class} function _GetALLOW_MOCK_LOCATION: JString; cdecl;
    {class} function _GetANDROID_ID: JString; cdecl;
    {class} function _GetBACKGROUND_DATA: JString; cdecl;
    {class} function _GetBLUETOOTH_ON: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDATA_ROAMING: JString; cdecl;
    {class} function _GetDEFAULT_INPUT_METHOD: JString; cdecl;
    {class} function _GetDEVELOPMENT_SETTINGS_ENABLED: JString; cdecl;
    {class} function _GetDEVICE_PROVISIONED: JString; cdecl;
    {class} function _GetENABLED_ACCESSIBILITY_SERVICES: JString; cdecl;
    {class} function _GetENABLED_INPUT_METHODS: JString; cdecl;
    {class} function _GetHTTP_PROXY: JString; cdecl;
    {class} function _GetINPUT_METHOD_SELECTOR_VISIBILITY: JString; cdecl;
    {class} function _GetINSTALL_NON_MARKET_APPS: JString; cdecl;
    {class} function _GetLOCATION_MODE: JString; cdecl;
    {class} function _GetLOCATION_MODE_BATTERY_SAVING: Integer; cdecl;
    {class} function _GetLOCATION_MODE_HIGH_ACCURACY: Integer; cdecl;
    {class} function _GetLOCATION_MODE_OFF: Integer; cdecl;
    {class} function _GetLOCATION_MODE_SENSORS_ONLY: Integer; cdecl;
    {class} function _GetLOCATION_PROVIDERS_ALLOWED: JString; cdecl;
    {class} function _GetLOCK_PATTERN_ENABLED: JString; cdecl;
    {class} function _GetLOCK_PATTERN_TACTILE_FEEDBACK_ENABLED: JString; cdecl;
    {class} function _GetLOCK_PATTERN_VISIBLE: JString; cdecl;
    {class} function _GetLOGGING_ID: JString; cdecl;
    {class} function _GetNETWORK_PREFERENCE: JString; cdecl;
    {class} function _GetPARENTAL_CONTROL_ENABLED: JString; cdecl;
    {class} function _GetPARENTAL_CONTROL_LAST_UPDATE: JString; cdecl;
    {class} function _GetPARENTAL_CONTROL_REDIRECT_URL: JString; cdecl;
    {class} function _GetSELECTED_INPUT_METHOD_SUBTYPE: JString; cdecl;
    {class} function _GetSETTINGS_CLASSNAME: JString; cdecl;
    {class} function _GetSKIP_FIRST_USE_HINTS: JString; cdecl;
    {class} function _GetSYS_PROP_SETTING_VERSION: JString; cdecl;
    {class} function _GetTOUCH_EXPLORATION_ENABLED: JString; cdecl;
    {class} function _GetTTS_DEFAULT_COUNTRY: JString; cdecl;
    {class} function _GetTTS_DEFAULT_LANG: JString; cdecl;
    {class} function _GetTTS_DEFAULT_PITCH: JString; cdecl;
    {class} function _GetTTS_DEFAULT_RATE: JString; cdecl;
    {class} function _GetTTS_DEFAULT_SYNTH: JString; cdecl;
    {class} function _GetTTS_DEFAULT_VARIANT: JString; cdecl;
    {class} function _GetTTS_ENABLED_PLUGINS: JString; cdecl;
    {class} function _GetTTS_USE_DEFAULTS: JString; cdecl;
    {class} function _GetUSB_MASS_STORAGE_ENABLED: JString; cdecl;
    {class} function _GetUSE_GOOGLE_MAIL: JString; cdecl;
    {class} function _GetWIFI_MAX_DHCP_RETRY_COUNT: JString; cdecl;
    {class} function _GetWIFI_MOBILE_DATA_TRANSITION_WAKELOCK_TIMEOUT_MS: JString; cdecl;
    {class} function _GetWIFI_NETWORKS_AVAILABLE_NOTIFICATION_ON: JString; cdecl;
    {class} function _GetWIFI_NETWORKS_AVAILABLE_REPEAT_DELAY: JString; cdecl;
    {class} function _GetWIFI_NUM_OPEN_NETWORKS_KEPT: JString; cdecl;
    {class} function _GetWIFI_ON: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_ACCEPTABLE_PACKET_LOSS_PERCENTAGE: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_AP_COUNT: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_BACKGROUND_CHECK_DELAY_MS: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_BACKGROUND_CHECK_ENABLED: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_BACKGROUND_CHECK_TIMEOUT_MS: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_INITIAL_IGNORED_PING_COUNT: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_MAX_AP_CHECKS: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_ON: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_PING_COUNT: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_PING_DELAY_MS: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_PING_TIMEOUT_MS: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_WATCH_LIST: JString; cdecl;
    {class} function init: JSettings_Secure; cdecl;
    {class} function getFloat(cr: JContentResolver; name: JString; def: Single): Single; cdecl; overload;
    {class} function getFloat(cr: JContentResolver; name: JString): Single; cdecl; overload;
    {class} function getInt(cr: JContentResolver; name: JString; def: Integer): Integer; cdecl; overload;
    {class} function getInt(cr: JContentResolver; name: JString): Integer; cdecl; overload;
    {class} function getLong(cr: JContentResolver; name: JString; def: Int64): Int64; cdecl; overload;
    {class} function getLong(cr: JContentResolver; name: JString): Int64; cdecl; overload;
    {class} function getString(resolver: JContentResolver; name: JString): JString; cdecl;
    {class} function getUriFor(name: JString): Jnet_Uri; cdecl;
    {class} function isLocationProviderEnabled(cr: JContentResolver; provider: JString): Boolean; cdecl;//Deprecated
    {class} function putFloat(cr: JContentResolver; name: JString; value: Single): Boolean; cdecl;
    {class} function putInt(cr: JContentResolver; name: JString; value: Integer): Boolean; cdecl;
    {class} function putLong(cr: JContentResolver; name: JString; value: Int64): Boolean; cdecl;
    {class} function putString(resolver: JContentResolver; name: JString; value: JString): Boolean; cdecl;
    {class} procedure setLocationProviderEnabled(cr: JContentResolver; provider: JString; enabled: Boolean); cdecl;//Deprecated
    {class} property ACCESSIBILITY_DISPLAY_INVERSION_ENABLED: JString read _GetACCESSIBILITY_DISPLAY_INVERSION_ENABLED;
    {class} property ACCESSIBILITY_ENABLED: JString read _GetACCESSIBILITY_ENABLED;
    {class} property ACCESSIBILITY_SPEAK_PASSWORD: JString read _GetACCESSIBILITY_SPEAK_PASSWORD;
    {class} property ADB_ENABLED: JString read _GetADB_ENABLED;
    {class} property ALLOWED_GEOLOCATION_ORIGINS: JString read _GetALLOWED_GEOLOCATION_ORIGINS;
    {class} property ALLOW_MOCK_LOCATION: JString read _GetALLOW_MOCK_LOCATION;
    {class} property ANDROID_ID: JString read _GetANDROID_ID;
    {class} property BACKGROUND_DATA: JString read _GetBACKGROUND_DATA;
    {class} property BLUETOOTH_ON: JString read _GetBLUETOOTH_ON;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DATA_ROAMING: JString read _GetDATA_ROAMING;
    {class} property DEFAULT_INPUT_METHOD: JString read _GetDEFAULT_INPUT_METHOD;
    {class} property DEVELOPMENT_SETTINGS_ENABLED: JString read _GetDEVELOPMENT_SETTINGS_ENABLED;
    {class} property DEVICE_PROVISIONED: JString read _GetDEVICE_PROVISIONED;
    {class} property ENABLED_ACCESSIBILITY_SERVICES: JString read _GetENABLED_ACCESSIBILITY_SERVICES;
    {class} property ENABLED_INPUT_METHODS: JString read _GetENABLED_INPUT_METHODS;
    {class} property HTTP_PROXY: JString read _GetHTTP_PROXY;
    {class} property INPUT_METHOD_SELECTOR_VISIBILITY: JString read _GetINPUT_METHOD_SELECTOR_VISIBILITY;
    {class} property INSTALL_NON_MARKET_APPS: JString read _GetINSTALL_NON_MARKET_APPS;
    {class} property LOCATION_MODE: JString read _GetLOCATION_MODE;
    {class} property LOCATION_MODE_BATTERY_SAVING: Integer read _GetLOCATION_MODE_BATTERY_SAVING;
    {class} property LOCATION_MODE_HIGH_ACCURACY: Integer read _GetLOCATION_MODE_HIGH_ACCURACY;
    {class} property LOCATION_MODE_OFF: Integer read _GetLOCATION_MODE_OFF;
    {class} property LOCATION_MODE_SENSORS_ONLY: Integer read _GetLOCATION_MODE_SENSORS_ONLY;
    {class} property LOCATION_PROVIDERS_ALLOWED: JString read _GetLOCATION_PROVIDERS_ALLOWED;
    {class} property LOCK_PATTERN_ENABLED: JString read _GetLOCK_PATTERN_ENABLED;
    {class} property LOCK_PATTERN_TACTILE_FEEDBACK_ENABLED: JString read _GetLOCK_PATTERN_TACTILE_FEEDBACK_ENABLED;
    {class} property LOCK_PATTERN_VISIBLE: JString read _GetLOCK_PATTERN_VISIBLE;
    {class} property LOGGING_ID: JString read _GetLOGGING_ID;
    {class} property NETWORK_PREFERENCE: JString read _GetNETWORK_PREFERENCE;
    {class} property PARENTAL_CONTROL_ENABLED: JString read _GetPARENTAL_CONTROL_ENABLED;
    {class} property PARENTAL_CONTROL_LAST_UPDATE: JString read _GetPARENTAL_CONTROL_LAST_UPDATE;
    {class} property PARENTAL_CONTROL_REDIRECT_URL: JString read _GetPARENTAL_CONTROL_REDIRECT_URL;
    {class} property SELECTED_INPUT_METHOD_SUBTYPE: JString read _GetSELECTED_INPUT_METHOD_SUBTYPE;
    {class} property SETTINGS_CLASSNAME: JString read _GetSETTINGS_CLASSNAME;
    {class} property SKIP_FIRST_USE_HINTS: JString read _GetSKIP_FIRST_USE_HINTS;
    {class} property SYS_PROP_SETTING_VERSION: JString read _GetSYS_PROP_SETTING_VERSION;
    {class} property TOUCH_EXPLORATION_ENABLED: JString read _GetTOUCH_EXPLORATION_ENABLED;
    {class} property TTS_DEFAULT_COUNTRY: JString read _GetTTS_DEFAULT_COUNTRY;
    {class} property TTS_DEFAULT_LANG: JString read _GetTTS_DEFAULT_LANG;
    {class} property TTS_DEFAULT_PITCH: JString read _GetTTS_DEFAULT_PITCH;
    {class} property TTS_DEFAULT_RATE: JString read _GetTTS_DEFAULT_RATE;
    {class} property TTS_DEFAULT_SYNTH: JString read _GetTTS_DEFAULT_SYNTH;
    {class} property TTS_DEFAULT_VARIANT: JString read _GetTTS_DEFAULT_VARIANT;
    {class} property TTS_ENABLED_PLUGINS: JString read _GetTTS_ENABLED_PLUGINS;
    {class} property TTS_USE_DEFAULTS: JString read _GetTTS_USE_DEFAULTS;
    {class} property USB_MASS_STORAGE_ENABLED: JString read _GetUSB_MASS_STORAGE_ENABLED;
    {class} property USE_GOOGLE_MAIL: JString read _GetUSE_GOOGLE_MAIL;
    {class} property WIFI_MAX_DHCP_RETRY_COUNT: JString read _GetWIFI_MAX_DHCP_RETRY_COUNT;
    {class} property WIFI_MOBILE_DATA_TRANSITION_WAKELOCK_TIMEOUT_MS: JString read _GetWIFI_MOBILE_DATA_TRANSITION_WAKELOCK_TIMEOUT_MS;
    {class} property WIFI_NETWORKS_AVAILABLE_NOTIFICATION_ON: JString read _GetWIFI_NETWORKS_AVAILABLE_NOTIFICATION_ON;
    {class} property WIFI_NETWORKS_AVAILABLE_REPEAT_DELAY: JString read _GetWIFI_NETWORKS_AVAILABLE_REPEAT_DELAY;
    {class} property WIFI_NUM_OPEN_NETWORKS_KEPT: JString read _GetWIFI_NUM_OPEN_NETWORKS_KEPT;
    {class} property WIFI_ON: JString read _GetWIFI_ON;
    {class} property WIFI_WATCHDOG_ACCEPTABLE_PACKET_LOSS_PERCENTAGE: JString read _GetWIFI_WATCHDOG_ACCEPTABLE_PACKET_LOSS_PERCENTAGE;
    {class} property WIFI_WATCHDOG_AP_COUNT: JString read _GetWIFI_WATCHDOG_AP_COUNT;
    {class} property WIFI_WATCHDOG_BACKGROUND_CHECK_DELAY_MS: JString read _GetWIFI_WATCHDOG_BACKGROUND_CHECK_DELAY_MS;
    {class} property WIFI_WATCHDOG_BACKGROUND_CHECK_ENABLED: JString read _GetWIFI_WATCHDOG_BACKGROUND_CHECK_ENABLED;
    {class} property WIFI_WATCHDOG_BACKGROUND_CHECK_TIMEOUT_MS: JString read _GetWIFI_WATCHDOG_BACKGROUND_CHECK_TIMEOUT_MS;
    {class} property WIFI_WATCHDOG_INITIAL_IGNORED_PING_COUNT: JString read _GetWIFI_WATCHDOG_INITIAL_IGNORED_PING_COUNT;
    {class} property WIFI_WATCHDOG_MAX_AP_CHECKS: JString read _GetWIFI_WATCHDOG_MAX_AP_CHECKS;
    {class} property WIFI_WATCHDOG_ON: JString read _GetWIFI_WATCHDOG_ON;
    {class} property WIFI_WATCHDOG_PING_COUNT: JString read _GetWIFI_WATCHDOG_PING_COUNT;
    {class} property WIFI_WATCHDOG_PING_DELAY_MS: JString read _GetWIFI_WATCHDOG_PING_DELAY_MS;
    {class} property WIFI_WATCHDOG_PING_TIMEOUT_MS: JString read _GetWIFI_WATCHDOG_PING_TIMEOUT_MS;
    {class} property WIFI_WATCHDOG_WATCH_LIST: JString read _GetWIFI_WATCHDOG_WATCH_LIST;
  end;

  [JavaSignature('android/provider/Settings$Secure')]
  JSettings_Secure = interface(JSettings_NameValueTable)
    ['{2DB590FD-770A-45A0-8923-84883FF0B03B}']
  end;
  TJSettings_Secure = class(TJavaGenericImport<JSettings_SecureClass, JSettings_Secure>) end;

  JSettings_SettingNotFoundExceptionClass = interface(JAndroidExceptionClass)
    ['{5CE395AE-F059-4125-9F72-3B29390BE29D}']
    {class} function init(msg: JString): JSettings_SettingNotFoundException; cdecl;
  end;

  [JavaSignature('android/provider/Settings$SettingNotFoundException')]
  JSettings_SettingNotFoundException = interface(JAndroidException)
    ['{1E398CF0-857F-40AC-A940-02474CAFA0AE}']
  end;
  TJSettings_SettingNotFoundException = class(TJavaGenericImport<JSettings_SettingNotFoundExceptionClass, JSettings_SettingNotFoundException>) end;

  JSettings_SystemClass = interface(JSettings_NameValueTableClass)
    ['{E632F660-1FE5-4669-9255-ED47ECAE3731}']
    {class} function _GetACCELEROMETER_ROTATION: JString; cdecl;
    {class} function _GetADB_ENABLED: JString; cdecl;
    {class} function _GetAIRPLANE_MODE_ON: JString; cdecl;
    {class} function _GetAIRPLANE_MODE_RADIOS: JString; cdecl;
    {class} function _GetALARM_ALERT: JString; cdecl;
    {class} function _GetALWAYS_FINISH_ACTIVITIES: JString; cdecl;
    {class} function _GetANDROID_ID: JString; cdecl;
    {class} function _GetANIMATOR_DURATION_SCALE: JString; cdecl;
    {class} function _GetAPPEND_FOR_LAST_AUDIBLE: JString; cdecl;
    {class} function _GetAUTO_TIME: JString; cdecl;
    {class} function _GetAUTO_TIME_ZONE: JString; cdecl;
    {class} function _GetBLUETOOTH_DISCOVERABILITY: JString; cdecl;
    {class} function _GetBLUETOOTH_DISCOVERABILITY_TIMEOUT: JString; cdecl;
    {class} function _GetBLUETOOTH_ON: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDATA_ROAMING: JString; cdecl;
    {class} function _GetDATE_FORMAT: JString; cdecl;
    {class} function _GetDEBUG_APP: JString; cdecl;
    {class} function _GetDEFAULT_ALARM_ALERT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_NOTIFICATION_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_RINGTONE_URI: Jnet_Uri; cdecl;
    {class} function _GetDEVICE_PROVISIONED: JString; cdecl;
    {class} function _GetDIM_SCREEN: JString; cdecl;
    {class} function _GetDTMF_TONE_TYPE_WHEN_DIALING: JString; cdecl;
    {class} function _GetDTMF_TONE_WHEN_DIALING: JString; cdecl;
    {class} function _GetEND_BUTTON_BEHAVIOR: JString; cdecl;
    {class} function _GetFONT_SCALE: JString; cdecl;
    {class} function _GetHAPTIC_FEEDBACK_ENABLED: JString; cdecl;
    {class} function _GetHTTP_PROXY: JString; cdecl;
    {class} function _GetINSTALL_NON_MARKET_APPS: JString; cdecl;
    {class} function _GetLOCATION_PROVIDERS_ALLOWED: JString; cdecl;
    {class} function _GetLOCK_PATTERN_ENABLED: JString; cdecl;
    {class} function _GetLOCK_PATTERN_TACTILE_FEEDBACK_ENABLED: JString; cdecl;
    {class} function _GetLOCK_PATTERN_VISIBLE: JString; cdecl;
    {class} function _GetLOGGING_ID: JString; cdecl;
    {class} function _GetMODE_RINGER: JString; cdecl;
    {class} function _GetMODE_RINGER_STREAMS_AFFECTED: JString; cdecl;
    {class} function _GetMUTE_STREAMS_AFFECTED: JString; cdecl;
    {class} function _GetNETWORK_PREFERENCE: JString; cdecl;
    {class} function _GetNEXT_ALARM_FORMATTED: JString; cdecl;
    {class} function _GetNOTIFICATION_SOUND: JString; cdecl;
    {class} function _GetPARENTAL_CONTROL_ENABLED: JString; cdecl;
    {class} function _GetPARENTAL_CONTROL_LAST_UPDATE: JString; cdecl;
    {class} function _GetPARENTAL_CONTROL_REDIRECT_URL: JString; cdecl;
    {class} function _GetRADIO_BLUETOOTH: JString; cdecl;
    {class} function _GetRADIO_CELL: JString; cdecl;
    {class} function _GetRADIO_NFC: JString; cdecl;
    {class} function _GetRADIO_WIFI: JString; cdecl;
    {class} function _GetRINGTONE: JString; cdecl;
    {class} function _GetSCREEN_BRIGHTNESS: JString; cdecl;
    {class} function _GetSCREEN_BRIGHTNESS_MODE: JString; cdecl;
    {class} function _GetSCREEN_BRIGHTNESS_MODE_AUTOMATIC: Integer; cdecl;
    {class} function _GetSCREEN_BRIGHTNESS_MODE_MANUAL: Integer; cdecl;
    {class} function _GetSCREEN_OFF_TIMEOUT: JString; cdecl;
    {class} function _GetSETTINGS_CLASSNAME: JString; cdecl;
    {class} function _GetSETUP_WIZARD_HAS_RUN: JString; cdecl;
    {class} function _GetSHOW_GTALK_SERVICE_STATUS: JString; cdecl;
    {class} function _GetSHOW_PROCESSES: JString; cdecl;
    {class} function _GetSHOW_WEB_SUGGESTIONS: JString; cdecl;
    {class} function _GetSOUND_EFFECTS_ENABLED: JString; cdecl;
    {class} function _GetSTAY_ON_WHILE_PLUGGED_IN: JString; cdecl;
    {class} function _GetSYS_PROP_SETTING_VERSION: JString; cdecl;
    {class} function _GetTEXT_AUTO_CAPS: JString; cdecl;
    {class} function _GetTEXT_AUTO_PUNCTUATE: JString; cdecl;
    {class} function _GetTEXT_AUTO_REPLACE: JString; cdecl;
    {class} function _GetTEXT_SHOW_PASSWORD: JString; cdecl;
    {class} function _GetTIME_12_24: JString; cdecl;
    {class} function _GetTRANSITION_ANIMATION_SCALE: JString; cdecl;
    {class} function _GetUSB_MASS_STORAGE_ENABLED: JString; cdecl;
    {class} function _GetUSER_ROTATION: JString; cdecl;
    {class} function _GetUSE_GOOGLE_MAIL: JString; cdecl;
    {class} function _GetVIBRATE_ON: JString; cdecl;
    {class} function _GetVIBRATE_WHEN_RINGING: JString; cdecl;
    {class} function _GetVOLUME_ALARM: JString; cdecl;
    {class} function _GetVOLUME_BLUETOOTH_SCO: JString; cdecl;
    {class} function _GetVOLUME_MUSIC: JString; cdecl;
    {class} function _GetVOLUME_NOTIFICATION: JString; cdecl;
    {class} function _GetVOLUME_RING: JString; cdecl;
    {class} function _GetVOLUME_SETTINGS: TJavaObjectArray<JString>; cdecl;
    {class} function _GetVOLUME_SYSTEM: JString; cdecl;
    {class} function _GetVOLUME_VOICE: JString; cdecl;
    {class} function _GetWAIT_FOR_DEBUGGER: JString; cdecl;
    {class} function _GetWALLPAPER_ACTIVITY: JString; cdecl;
    {class} function _GetWIFI_MAX_DHCP_RETRY_COUNT: JString; cdecl;
    {class} function _GetWIFI_MOBILE_DATA_TRANSITION_WAKELOCK_TIMEOUT_MS: JString; cdecl;
    {class} function _GetWIFI_NETWORKS_AVAILABLE_NOTIFICATION_ON: JString; cdecl;
    {class} function _GetWIFI_NETWORKS_AVAILABLE_REPEAT_DELAY: JString; cdecl;
    {class} function _GetWIFI_NUM_OPEN_NETWORKS_KEPT: JString; cdecl;
    {class} function _GetWIFI_ON: JString; cdecl;
    {class} function _GetWIFI_SLEEP_POLICY: JString; cdecl;
    {class} function _GetWIFI_SLEEP_POLICY_DEFAULT: Integer; cdecl;
    {class} function _GetWIFI_SLEEP_POLICY_NEVER: Integer; cdecl;
    {class} function _GetWIFI_SLEEP_POLICY_NEVER_WHILE_PLUGGED: Integer; cdecl;
    {class} function _GetWIFI_STATIC_DNS1: JString; cdecl;
    {class} function _GetWIFI_STATIC_DNS2: JString; cdecl;
    {class} function _GetWIFI_STATIC_GATEWAY: JString; cdecl;
    {class} function _GetWIFI_STATIC_IP: JString; cdecl;
    {class} function _GetWIFI_STATIC_NETMASK: JString; cdecl;
    {class} function _GetWIFI_USE_STATIC_IP: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_ACCEPTABLE_PACKET_LOSS_PERCENTAGE: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_AP_COUNT: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_BACKGROUND_CHECK_DELAY_MS: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_BACKGROUND_CHECK_ENABLED: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_BACKGROUND_CHECK_TIMEOUT_MS: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_INITIAL_IGNORED_PING_COUNT: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_MAX_AP_CHECKS: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_ON: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_PING_COUNT: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_PING_DELAY_MS: JString; cdecl;
    {class} function _GetWIFI_WATCHDOG_PING_TIMEOUT_MS: JString; cdecl;
    {class} function _GetWINDOW_ANIMATION_SCALE: JString; cdecl;
    {class} function init: JSettings_System; cdecl;
    {class} function canWrite(context: JContext): Boolean; cdecl;
    {class} procedure getConfiguration(cr: JContentResolver; outConfig: JConfiguration); cdecl;
    {class} function getFloat(cr: JContentResolver; name: JString; def: Single): Single; cdecl; overload;
    {class} function getFloat(cr: JContentResolver; name: JString): Single; cdecl; overload;
    {class} function getInt(cr: JContentResolver; name: JString; def: Integer): Integer; cdecl; overload;
    {class} function getInt(cr: JContentResolver; name: JString): Integer; cdecl; overload;
    {class} function getLong(cr: JContentResolver; name: JString; def: Int64): Int64; cdecl; overload;
    {class} function getLong(cr: JContentResolver; name: JString): Int64; cdecl; overload;
    {class} function getShowGTalkServiceStatus(cr: JContentResolver): Boolean; cdecl;//Deprecated
    {class} function getString(resolver: JContentResolver; name: JString): JString; cdecl;
    {class} function getUriFor(name: JString): Jnet_Uri; cdecl;
    {class} function putConfiguration(cr: JContentResolver; config: JConfiguration): Boolean; cdecl;
    {class} function putFloat(cr: JContentResolver; name: JString; value: Single): Boolean; cdecl;
    {class} function putInt(cr: JContentResolver; name: JString; value: Integer): Boolean; cdecl;
    {class} function putLong(cr: JContentResolver; name: JString; value: Int64): Boolean; cdecl;
    {class} function putString(resolver: JContentResolver; name: JString; value: JString): Boolean; cdecl;
    {class} procedure setShowGTalkServiceStatus(cr: JContentResolver; flag: Boolean); cdecl;//Deprecated
    {class} property ACCELEROMETER_ROTATION: JString read _GetACCELEROMETER_ROTATION;
    {class} property ADB_ENABLED: JString read _GetADB_ENABLED;
    {class} property AIRPLANE_MODE_ON: JString read _GetAIRPLANE_MODE_ON;
    {class} property AIRPLANE_MODE_RADIOS: JString read _GetAIRPLANE_MODE_RADIOS;
    {class} property ALARM_ALERT: JString read _GetALARM_ALERT;
    {class} property ALWAYS_FINISH_ACTIVITIES: JString read _GetALWAYS_FINISH_ACTIVITIES;
    {class} property ANDROID_ID: JString read _GetANDROID_ID;
    {class} property ANIMATOR_DURATION_SCALE: JString read _GetANIMATOR_DURATION_SCALE;
    {class} property APPEND_FOR_LAST_AUDIBLE: JString read _GetAPPEND_FOR_LAST_AUDIBLE;
    {class} property AUTO_TIME: JString read _GetAUTO_TIME;
    {class} property AUTO_TIME_ZONE: JString read _GetAUTO_TIME_ZONE;
    {class} property BLUETOOTH_DISCOVERABILITY: JString read _GetBLUETOOTH_DISCOVERABILITY;
    {class} property BLUETOOTH_DISCOVERABILITY_TIMEOUT: JString read _GetBLUETOOTH_DISCOVERABILITY_TIMEOUT;
    {class} property BLUETOOTH_ON: JString read _GetBLUETOOTH_ON;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DATA_ROAMING: JString read _GetDATA_ROAMING;
    {class} property DATE_FORMAT: JString read _GetDATE_FORMAT;
    {class} property DEBUG_APP: JString read _GetDEBUG_APP;
    {class} property DEFAULT_ALARM_ALERT_URI: Jnet_Uri read _GetDEFAULT_ALARM_ALERT_URI;
    {class} property DEFAULT_NOTIFICATION_URI: Jnet_Uri read _GetDEFAULT_NOTIFICATION_URI;
    {class} property DEFAULT_RINGTONE_URI: Jnet_Uri read _GetDEFAULT_RINGTONE_URI;
    {class} property DEVICE_PROVISIONED: JString read _GetDEVICE_PROVISIONED;
    {class} property DIM_SCREEN: JString read _GetDIM_SCREEN;
    {class} property DTMF_TONE_TYPE_WHEN_DIALING: JString read _GetDTMF_TONE_TYPE_WHEN_DIALING;
    {class} property DTMF_TONE_WHEN_DIALING: JString read _GetDTMF_TONE_WHEN_DIALING;
    {class} property END_BUTTON_BEHAVIOR: JString read _GetEND_BUTTON_BEHAVIOR;
    {class} property FONT_SCALE: JString read _GetFONT_SCALE;
    {class} property HAPTIC_FEEDBACK_ENABLED: JString read _GetHAPTIC_FEEDBACK_ENABLED;
    {class} property HTTP_PROXY: JString read _GetHTTP_PROXY;
    {class} property INSTALL_NON_MARKET_APPS: JString read _GetINSTALL_NON_MARKET_APPS;
    {class} property LOCATION_PROVIDERS_ALLOWED: JString read _GetLOCATION_PROVIDERS_ALLOWED;
    {class} property LOCK_PATTERN_ENABLED: JString read _GetLOCK_PATTERN_ENABLED;
    {class} property LOCK_PATTERN_TACTILE_FEEDBACK_ENABLED: JString read _GetLOCK_PATTERN_TACTILE_FEEDBACK_ENABLED;
    {class} property LOCK_PATTERN_VISIBLE: JString read _GetLOCK_PATTERN_VISIBLE;
    {class} property LOGGING_ID: JString read _GetLOGGING_ID;
    {class} property MODE_RINGER: JString read _GetMODE_RINGER;
    {class} property MODE_RINGER_STREAMS_AFFECTED: JString read _GetMODE_RINGER_STREAMS_AFFECTED;
    {class} property MUTE_STREAMS_AFFECTED: JString read _GetMUTE_STREAMS_AFFECTED;
    {class} property NETWORK_PREFERENCE: JString read _GetNETWORK_PREFERENCE;
    {class} property NEXT_ALARM_FORMATTED: JString read _GetNEXT_ALARM_FORMATTED;
    {class} property NOTIFICATION_SOUND: JString read _GetNOTIFICATION_SOUND;
    {class} property PARENTAL_CONTROL_ENABLED: JString read _GetPARENTAL_CONTROL_ENABLED;
    {class} property PARENTAL_CONTROL_LAST_UPDATE: JString read _GetPARENTAL_CONTROL_LAST_UPDATE;
    {class} property PARENTAL_CONTROL_REDIRECT_URL: JString read _GetPARENTAL_CONTROL_REDIRECT_URL;
    {class} property RADIO_BLUETOOTH: JString read _GetRADIO_BLUETOOTH;
    {class} property RADIO_CELL: JString read _GetRADIO_CELL;
    {class} property RADIO_NFC: JString read _GetRADIO_NFC;
    {class} property RADIO_WIFI: JString read _GetRADIO_WIFI;
    {class} property RINGTONE: JString read _GetRINGTONE;
    {class} property SCREEN_BRIGHTNESS: JString read _GetSCREEN_BRIGHTNESS;
    {class} property SCREEN_BRIGHTNESS_MODE: JString read _GetSCREEN_BRIGHTNESS_MODE;
    {class} property SCREEN_BRIGHTNESS_MODE_AUTOMATIC: Integer read _GetSCREEN_BRIGHTNESS_MODE_AUTOMATIC;
    {class} property SCREEN_BRIGHTNESS_MODE_MANUAL: Integer read _GetSCREEN_BRIGHTNESS_MODE_MANUAL;
    {class} property SCREEN_OFF_TIMEOUT: JString read _GetSCREEN_OFF_TIMEOUT;
    {class} property SETTINGS_CLASSNAME: JString read _GetSETTINGS_CLASSNAME;
    {class} property SETUP_WIZARD_HAS_RUN: JString read _GetSETUP_WIZARD_HAS_RUN;
    {class} property SHOW_GTALK_SERVICE_STATUS: JString read _GetSHOW_GTALK_SERVICE_STATUS;
    {class} property SHOW_PROCESSES: JString read _GetSHOW_PROCESSES;
    {class} property SHOW_WEB_SUGGESTIONS: JString read _GetSHOW_WEB_SUGGESTIONS;
    {class} property SOUND_EFFECTS_ENABLED: JString read _GetSOUND_EFFECTS_ENABLED;
    {class} property STAY_ON_WHILE_PLUGGED_IN: JString read _GetSTAY_ON_WHILE_PLUGGED_IN;
    {class} property SYS_PROP_SETTING_VERSION: JString read _GetSYS_PROP_SETTING_VERSION;
    {class} property TEXT_AUTO_CAPS: JString read _GetTEXT_AUTO_CAPS;
    {class} property TEXT_AUTO_PUNCTUATE: JString read _GetTEXT_AUTO_PUNCTUATE;
    {class} property TEXT_AUTO_REPLACE: JString read _GetTEXT_AUTO_REPLACE;
    {class} property TEXT_SHOW_PASSWORD: JString read _GetTEXT_SHOW_PASSWORD;
    {class} property TIME_12_24: JString read _GetTIME_12_24;
    {class} property TRANSITION_ANIMATION_SCALE: JString read _GetTRANSITION_ANIMATION_SCALE;
    {class} property USB_MASS_STORAGE_ENABLED: JString read _GetUSB_MASS_STORAGE_ENABLED;
    {class} property USER_ROTATION: JString read _GetUSER_ROTATION;
    {class} property USE_GOOGLE_MAIL: JString read _GetUSE_GOOGLE_MAIL;
    {class} property VIBRATE_ON: JString read _GetVIBRATE_ON;
    {class} property VIBRATE_WHEN_RINGING: JString read _GetVIBRATE_WHEN_RINGING;
    {class} property VOLUME_ALARM: JString read _GetVOLUME_ALARM;
    {class} property VOLUME_BLUETOOTH_SCO: JString read _GetVOLUME_BLUETOOTH_SCO;
    {class} property VOLUME_MUSIC: JString read _GetVOLUME_MUSIC;
    {class} property VOLUME_NOTIFICATION: JString read _GetVOLUME_NOTIFICATION;
    {class} property VOLUME_RING: JString read _GetVOLUME_RING;
    {class} property VOLUME_SETTINGS: TJavaObjectArray<JString> read _GetVOLUME_SETTINGS;
    {class} property VOLUME_SYSTEM: JString read _GetVOLUME_SYSTEM;
    {class} property VOLUME_VOICE: JString read _GetVOLUME_VOICE;
    {class} property WAIT_FOR_DEBUGGER: JString read _GetWAIT_FOR_DEBUGGER;
    {class} property WALLPAPER_ACTIVITY: JString read _GetWALLPAPER_ACTIVITY;
    {class} property WIFI_MAX_DHCP_RETRY_COUNT: JString read _GetWIFI_MAX_DHCP_RETRY_COUNT;
    {class} property WIFI_MOBILE_DATA_TRANSITION_WAKELOCK_TIMEOUT_MS: JString read _GetWIFI_MOBILE_DATA_TRANSITION_WAKELOCK_TIMEOUT_MS;
    {class} property WIFI_NETWORKS_AVAILABLE_NOTIFICATION_ON: JString read _GetWIFI_NETWORKS_AVAILABLE_NOTIFICATION_ON;
    {class} property WIFI_NETWORKS_AVAILABLE_REPEAT_DELAY: JString read _GetWIFI_NETWORKS_AVAILABLE_REPEAT_DELAY;
    {class} property WIFI_NUM_OPEN_NETWORKS_KEPT: JString read _GetWIFI_NUM_OPEN_NETWORKS_KEPT;
    {class} property WIFI_ON: JString read _GetWIFI_ON;
    {class} property WIFI_SLEEP_POLICY: JString read _GetWIFI_SLEEP_POLICY;
    {class} property WIFI_SLEEP_POLICY_DEFAULT: Integer read _GetWIFI_SLEEP_POLICY_DEFAULT;
    {class} property WIFI_SLEEP_POLICY_NEVER: Integer read _GetWIFI_SLEEP_POLICY_NEVER;
    {class} property WIFI_SLEEP_POLICY_NEVER_WHILE_PLUGGED: Integer read _GetWIFI_SLEEP_POLICY_NEVER_WHILE_PLUGGED;
    {class} property WIFI_STATIC_DNS1: JString read _GetWIFI_STATIC_DNS1;
    {class} property WIFI_STATIC_DNS2: JString read _GetWIFI_STATIC_DNS2;
    {class} property WIFI_STATIC_GATEWAY: JString read _GetWIFI_STATIC_GATEWAY;
    {class} property WIFI_STATIC_IP: JString read _GetWIFI_STATIC_IP;
    {class} property WIFI_STATIC_NETMASK: JString read _GetWIFI_STATIC_NETMASK;
    {class} property WIFI_USE_STATIC_IP: JString read _GetWIFI_USE_STATIC_IP;
    {class} property WIFI_WATCHDOG_ACCEPTABLE_PACKET_LOSS_PERCENTAGE: JString read _GetWIFI_WATCHDOG_ACCEPTABLE_PACKET_LOSS_PERCENTAGE;
    {class} property WIFI_WATCHDOG_AP_COUNT: JString read _GetWIFI_WATCHDOG_AP_COUNT;
    {class} property WIFI_WATCHDOG_BACKGROUND_CHECK_DELAY_MS: JString read _GetWIFI_WATCHDOG_BACKGROUND_CHECK_DELAY_MS;
    {class} property WIFI_WATCHDOG_BACKGROUND_CHECK_ENABLED: JString read _GetWIFI_WATCHDOG_BACKGROUND_CHECK_ENABLED;
    {class} property WIFI_WATCHDOG_BACKGROUND_CHECK_TIMEOUT_MS: JString read _GetWIFI_WATCHDOG_BACKGROUND_CHECK_TIMEOUT_MS;
    {class} property WIFI_WATCHDOG_INITIAL_IGNORED_PING_COUNT: JString read _GetWIFI_WATCHDOG_INITIAL_IGNORED_PING_COUNT;
    {class} property WIFI_WATCHDOG_MAX_AP_CHECKS: JString read _GetWIFI_WATCHDOG_MAX_AP_CHECKS;
    {class} property WIFI_WATCHDOG_ON: JString read _GetWIFI_WATCHDOG_ON;
    {class} property WIFI_WATCHDOG_PING_COUNT: JString read _GetWIFI_WATCHDOG_PING_COUNT;
    {class} property WIFI_WATCHDOG_PING_DELAY_MS: JString read _GetWIFI_WATCHDOG_PING_DELAY_MS;
    {class} property WIFI_WATCHDOG_PING_TIMEOUT_MS: JString read _GetWIFI_WATCHDOG_PING_TIMEOUT_MS;
    {class} property WINDOW_ANIMATION_SCALE: JString read _GetWINDOW_ANIMATION_SCALE;
  end;

  [JavaSignature('android/provider/Settings$System')]
  JSettings_System = interface(JSettings_NameValueTable)
    ['{E306E2DB-D461-4827-9D0D-E21DF13BB926}']
  end;
  TJSettings_System = class(TJavaGenericImport<JSettings_SystemClass, JSettings_System>) end;

  JSyncStateContractClass = interface(JObjectClass)
    ['{52C4E2D7-E8D9-4B81-9EE2-13089945D523}']
    {class} function init: JSyncStateContract; cdecl;
  end;

  [JavaSignature('android/provider/SyncStateContract')]
  JSyncStateContract = interface(JObject)
    ['{85043796-9477-4DB1-95DD-9AD7BE985712}']
  end;
  TJSyncStateContract = class(TJavaGenericImport<JSyncStateContractClass, JSyncStateContract>) end;

  JSyncStateContract_ColumnsClass = interface(JBaseColumnsClass)
    ['{2A1A3A43-15BD-40BF-8CAE-D86529C38491}']
    {class} function _GetACCOUNT_NAME: JString; cdecl;
    {class} function _GetACCOUNT_TYPE: JString; cdecl;
    {class} function _GetDATA: JString; cdecl;
    {class} property ACCOUNT_NAME: JString read _GetACCOUNT_NAME;
    {class} property ACCOUNT_TYPE: JString read _GetACCOUNT_TYPE;
    {class} property DATA: JString read _GetDATA;
  end;

  [JavaSignature('android/provider/SyncStateContract$Columns')]
  JSyncStateContract_Columns = interface(JBaseColumns)
    ['{62738508-F2E0-4EE2-89E2-57F10B1D5869}']
  end;
  TJSyncStateContract_Columns = class(TJavaGenericImport<JSyncStateContract_ColumnsClass, JSyncStateContract_Columns>) end;

  JSyncStateContract_ConstantsClass = interface(JObjectClass)
    ['{13965A6D-CFFD-4471-9B6D-E58B4673F910}']
    {class} function _GetCONTENT_DIRECTORY: JString; cdecl;
    {class} function init: JSyncStateContract_Constants; cdecl;
    {class} property CONTENT_DIRECTORY: JString read _GetCONTENT_DIRECTORY;
  end;

  [JavaSignature('android/provider/SyncStateContract$Constants')]
  JSyncStateContract_Constants = interface(JObject)
    ['{540C4A22-0C3F-4AB3-AF71-D227A2DADA77}']
  end;
  TJSyncStateContract_Constants = class(TJavaGenericImport<JSyncStateContract_ConstantsClass, JSyncStateContract_Constants>) end;

  JSyncStateContract_HelpersClass = interface(JObjectClass)
    ['{4B4C89EA-788B-4E3C-90B9-E56A611ED30A}']
    {class} function init: JSyncStateContract_Helpers; cdecl;
    {class} //function &get(provider: JContentProviderClient; uri: Jnet_Uri; account: JAccount): TJavaArray<Byte>; cdecl;
    {class} //function getWithUri(provider: JContentProviderClient; uri: Jnet_Uri; account: JAccount): TJavaObjectArray<JPair>; cdecl;
    {class} //function insert(provider: JContentProviderClient; uri: Jnet_Uri; account: JAccount; data: TJavaArray<Byte>): Jnet_Uri; cdecl;
    {class} //function newSetOperation(uri: Jnet_Uri; account: JAccount; data: TJavaArray<Byte>): JContentProviderOperation; cdecl;
    {class} function newUpdateOperation(uri: Jnet_Uri; data: TJavaArray<Byte>): JContentProviderOperation; cdecl;
    {class} //procedure &set(provider: JContentProviderClient; uri: Jnet_Uri; account: JAccount; data: TJavaArray<Byte>); cdecl;
    {class} procedure update(provider: JContentProviderClient; uri: Jnet_Uri; data: TJavaArray<Byte>); cdecl;
  end;

  [JavaSignature('android/provider/SyncStateContract$Helpers')]
  JSyncStateContract_Helpers = interface(JObject)
    ['{C649769F-D61C-406E-A8E9-2E2E0B77CD28}']
  end;
  TJSyncStateContract_Helpers = class(TJavaGenericImport<JSyncStateContract_HelpersClass, JSyncStateContract_Helpers>) end;

  JTelephonyClass = interface(JObjectClass)
    ['{79085FEA-1EDC-4515-9334-72C22E626FEC}']
  end;

  [JavaSignature('android/provider/Telephony')]
  JTelephony = interface(JObject)
    ['{4EDF8ADA-122C-406B-8273-FE0C90246436}']
  end;
  TJTelephony = class(TJavaGenericImport<JTelephonyClass, JTelephony>) end;

  JTelephony_BaseMmsColumnsClass = interface(JBaseColumnsClass)
    ['{0BA67BC8-576F-4135-BBE3-B0B50FA184AD}']
    {class} function _GetCONTENT_CLASS: JString; cdecl;
    {class} function _GetCONTENT_LOCATION: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCREATOR: JString; cdecl;
    {class} function _GetDATE: JString; cdecl;
    {class} function _GetDATE_SENT: JString; cdecl;
    {class} function _GetDELIVERY_REPORT: JString; cdecl;
    {class} function _GetDELIVERY_TIME: JString; cdecl;
    {class} function _GetEXPIRY: JString; cdecl;
    {class} function _GetLOCKED: JString; cdecl;
    {class} function _GetMESSAGE_BOX: JString; cdecl;
    {class} function _GetMESSAGE_BOX_ALL: Integer; cdecl;
    {class} function _GetMESSAGE_BOX_DRAFTS: Integer; cdecl;
    {class} function _GetMESSAGE_BOX_FAILED: Integer; cdecl;
    {class} function _GetMESSAGE_BOX_INBOX: Integer; cdecl;
    {class} function _GetMESSAGE_BOX_OUTBOX: Integer; cdecl;
    {class} function _GetMESSAGE_BOX_SENT: Integer; cdecl;
    {class} function _GetMESSAGE_CLASS: JString; cdecl;
    {class} function _GetMESSAGE_ID: JString; cdecl;
    {class} function _GetMESSAGE_SIZE: JString; cdecl;
    {class} function _GetMESSAGE_TYPE: JString; cdecl;
    {class} function _GetMMS_VERSION: JString; cdecl;
    {class} function _GetPRIORITY: JString; cdecl;
    {class} function _GetREAD: JString; cdecl;
    {class} function _GetREAD_REPORT: JString; cdecl;
    {class} function _GetREAD_STATUS: JString; cdecl;
    {class} function _GetREPORT_ALLOWED: JString; cdecl;
    {class} function _GetRESPONSE_STATUS: JString; cdecl;
    {class} function _GetRESPONSE_TEXT: JString; cdecl;
    {class} function _GetRETRIEVE_STATUS: JString; cdecl;
    {class} function _GetRETRIEVE_TEXT: JString; cdecl;
    {class} function _GetRETRIEVE_TEXT_CHARSET: JString; cdecl;
    {class} function _GetSEEN: JString; cdecl;
    {class} function _GetSTATUS: JString; cdecl;
    {class} function _GetSUBJECT: JString; cdecl;
    {class} function _GetSUBJECT_CHARSET: JString; cdecl;
    {class} function _GetSUBSCRIPTION_ID: JString; cdecl;
    {class} function _GetTEXT_ONLY: JString; cdecl;
    {class} function _GetTHREAD_ID: JString; cdecl;
    {class} function _GetTRANSACTION_ID: JString; cdecl;
    {class} property CONTENT_CLASS: JString read _GetCONTENT_CLASS;
    {class} property CONTENT_LOCATION: JString read _GetCONTENT_LOCATION;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CREATOR: JString read _GetCREATOR;
    {class} property DATE: JString read _GetDATE;
    {class} property DATE_SENT: JString read _GetDATE_SENT;
    {class} property DELIVERY_REPORT: JString read _GetDELIVERY_REPORT;
    {class} property DELIVERY_TIME: JString read _GetDELIVERY_TIME;
    {class} property EXPIRY: JString read _GetEXPIRY;
    {class} property LOCKED: JString read _GetLOCKED;
    {class} property MESSAGE_BOX: JString read _GetMESSAGE_BOX;
    {class} property MESSAGE_BOX_ALL: Integer read _GetMESSAGE_BOX_ALL;
    {class} property MESSAGE_BOX_DRAFTS: Integer read _GetMESSAGE_BOX_DRAFTS;
    {class} property MESSAGE_BOX_FAILED: Integer read _GetMESSAGE_BOX_FAILED;
    {class} property MESSAGE_BOX_INBOX: Integer read _GetMESSAGE_BOX_INBOX;
    {class} property MESSAGE_BOX_OUTBOX: Integer read _GetMESSAGE_BOX_OUTBOX;
    {class} property MESSAGE_BOX_SENT: Integer read _GetMESSAGE_BOX_SENT;
    {class} property MESSAGE_CLASS: JString read _GetMESSAGE_CLASS;
    {class} property MESSAGE_ID: JString read _GetMESSAGE_ID;
    {class} property MESSAGE_SIZE: JString read _GetMESSAGE_SIZE;
    {class} property MESSAGE_TYPE: JString read _GetMESSAGE_TYPE;
    {class} property MMS_VERSION: JString read _GetMMS_VERSION;
    {class} property PRIORITY: JString read _GetPRIORITY;
    {class} property READ: JString read _GetREAD;
    {class} property READ_REPORT: JString read _GetREAD_REPORT;
    {class} property READ_STATUS: JString read _GetREAD_STATUS;
    {class} property REPORT_ALLOWED: JString read _GetREPORT_ALLOWED;
    {class} property RESPONSE_STATUS: JString read _GetRESPONSE_STATUS;
    {class} property RESPONSE_TEXT: JString read _GetRESPONSE_TEXT;
    {class} property RETRIEVE_STATUS: JString read _GetRETRIEVE_STATUS;
    {class} property RETRIEVE_TEXT: JString read _GetRETRIEVE_TEXT;
    {class} property RETRIEVE_TEXT_CHARSET: JString read _GetRETRIEVE_TEXT_CHARSET;
    {class} property SEEN: JString read _GetSEEN;
    {class} property STATUS: JString read _GetSTATUS;
    {class} property SUBJECT: JString read _GetSUBJECT;
    {class} property SUBJECT_CHARSET: JString read _GetSUBJECT_CHARSET;
    {class} property SUBSCRIPTION_ID: JString read _GetSUBSCRIPTION_ID;
    {class} property TEXT_ONLY: JString read _GetTEXT_ONLY;
    {class} property THREAD_ID: JString read _GetTHREAD_ID;
    {class} property TRANSACTION_ID: JString read _GetTRANSACTION_ID;
  end;

  [JavaSignature('android/provider/Telephony$BaseMmsColumns')]
  JTelephony_BaseMmsColumns = interface(JBaseColumns)
    ['{FBD3186E-8FBF-40CB-AF1B-43F7F60B0986}']
  end;
  TJTelephony_BaseMmsColumns = class(TJavaGenericImport<JTelephony_BaseMmsColumnsClass, JTelephony_BaseMmsColumns>) end;

  JTelephony_CanonicalAddressesColumnsClass = interface(JBaseColumnsClass)
    ['{ACE60408-C59D-46A2-A992-FA683729C830}']
    {class} function _GetADDRESS: JString; cdecl;
    {class} property ADDRESS: JString read _GetADDRESS;
  end;

  [JavaSignature('android/provider/Telephony$CanonicalAddressesColumns')]
  JTelephony_CanonicalAddressesColumns = interface(JBaseColumns)
    ['{0F156C10-EB17-425E-B0DD-AED6A6CFAA28}']
  end;
  TJTelephony_CanonicalAddressesColumns = class(TJavaGenericImport<JTelephony_CanonicalAddressesColumnsClass, JTelephony_CanonicalAddressesColumns>) end;

  JTelephony_CarriersClass = interface(JObjectClass)
    ['{0FC03498-C70C-496C-95A0-7D394734C1C2}']
    {class} function _GetAPN: JString; cdecl;
    {class} function _GetAUTH_TYPE: JString; cdecl;
    {class} function _GetBEARER: JString; cdecl;
    {class} function _GetCARRIER_ENABLED: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetCURRENT: JString; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetMCC: JString; cdecl;
    {class} function _GetMMSC: JString; cdecl;
    {class} function _GetMMSPORT: JString; cdecl;
    {class} function _GetMMSPROXY: JString; cdecl;
    {class} function _GetMNC: JString; cdecl;
    {class} function _GetMVNO_MATCH_DATA: JString; cdecl;
    {class} function _GetMVNO_TYPE: JString; cdecl;
    {class} function _GetNAME: JString; cdecl;
    {class} function _GetNUMERIC: JString; cdecl;
    {class} function _GetPASSWORD: JString; cdecl;
    {class} function _GetPORT: JString; cdecl;
    {class} function _GetPROTOCOL: JString; cdecl;
    {class} function _GetPROXY: JString; cdecl;
    {class} function _GetROAMING_PROTOCOL: JString; cdecl;
    {class} function _GetSERVER: JString; cdecl;
    {class} function _GetSUBSCRIPTION_ID: JString; cdecl;
    {class} function _GetTYPE: JString; cdecl;
    {class} function _GetUSER: JString; cdecl;
    {class} property APN: JString read _GetAPN;
    {class} property AUTH_TYPE: JString read _GetAUTH_TYPE;
    {class} property BEARER: JString read _GetBEARER;
    {class} property CARRIER_ENABLED: JString read _GetCARRIER_ENABLED;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property CURRENT: JString read _GetCURRENT;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property MCC: JString read _GetMCC;
    {class} property MMSC: JString read _GetMMSC;
    {class} property MMSPORT: JString read _GetMMSPORT;
    {class} property MMSPROXY: JString read _GetMMSPROXY;
    {class} property MNC: JString read _GetMNC;
    {class} property MVNO_MATCH_DATA: JString read _GetMVNO_MATCH_DATA;
    {class} property MVNO_TYPE: JString read _GetMVNO_TYPE;
    {class} property NAME: JString read _GetNAME;
    {class} property NUMERIC: JString read _GetNUMERIC;
    {class} property PASSWORD: JString read _GetPASSWORD;
    {class} property PORT: JString read _GetPORT;
    {class} property PROTOCOL: JString read _GetPROTOCOL;
    {class} property PROXY: JString read _GetPROXY;
    {class} property ROAMING_PROTOCOL: JString read _GetROAMING_PROTOCOL;
    {class} property SERVER: JString read _GetSERVER;
    {class} property SUBSCRIPTION_ID: JString read _GetSUBSCRIPTION_ID;
    {class} property &TYPE: JString read _GetTYPE;
    {class} property USER: JString read _GetUSER;
  end;

  [JavaSignature('android/provider/Telephony$Carriers')]
  JTelephony_Carriers = interface(JObject)
    ['{0EF92345-677C-47FD-9A32-D44A12C7F77F}']
  end;
  TJTelephony_Carriers = class(TJavaGenericImport<JTelephony_CarriersClass, JTelephony_Carriers>) end;

  JTelephony_MmsClass = interface(JObjectClass)
    ['{20B4912F-5CD1-4CE1-BF80-9F00A94D49B3}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetREPORT_REQUEST_URI: Jnet_Uri; cdecl;
    {class} function _GetREPORT_STATUS_URI: Jnet_Uri; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property REPORT_REQUEST_URI: Jnet_Uri read _GetREPORT_REQUEST_URI;
    {class} property REPORT_STATUS_URI: Jnet_Uri read _GetREPORT_STATUS_URI;
  end;

  [JavaSignature('android/provider/Telephony$Mms')]
  JTelephony_Mms = interface(JObject)
    ['{83797E67-0B7F-453E-AED2-B8B675524C4A}']
  end;
  TJTelephony_Mms = class(TJavaGenericImport<JTelephony_MmsClass, JTelephony_Mms>) end;

  JMms_AddrClass = interface(JObjectClass)
    ['{E3D14342-1444-4200-A07C-76600A3C3385}']
    {class} function _GetADDRESS: JString; cdecl;
    {class} function _GetCHARSET: JString; cdecl;
    {class} function _GetCONTACT_ID: JString; cdecl;
    {class} function _GetMSG_ID: JString; cdecl;
    {class} function _GetTYPE: JString; cdecl;
    {class} property ADDRESS: JString read _GetADDRESS;
    {class} property CHARSET: JString read _GetCHARSET;
    {class} property CONTACT_ID: JString read _GetCONTACT_ID;
    {class} property MSG_ID: JString read _GetMSG_ID;
    {class} property &TYPE: JString read _GetTYPE;
  end;

  [JavaSignature('android/provider/Telephony$Mms$Addr')]
  JMms_Addr = interface(JObject)
    ['{499D6B85-356B-491F-9E5F-8818BFB4B928}']
  end;
  TJMms_Addr = class(TJavaGenericImport<JMms_AddrClass, JMms_Addr>) end;

  JMms_DraftClass = interface(JObjectClass)
    ['{3B39D5A3-2A6D-4F45-8A82-C78176EEB6B3}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Telephony$Mms$Draft')]
  JMms_Draft = interface(JObject)
    ['{534BE6AE-E6E4-4525-AFDC-7316486D6FEB}']
  end;
  TJMms_Draft = class(TJavaGenericImport<JMms_DraftClass, JMms_Draft>) end;

  JMms_InboxClass = interface(JObjectClass)
    ['{80DC10A8-EAF2-43B2-A03E-44F313F7E381}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Telephony$Mms$Inbox')]
  JMms_Inbox = interface(JObject)
    ['{0C95F27F-C414-4FF5-9950-D6F68B58538E}']
  end;
  TJMms_Inbox = class(TJavaGenericImport<JMms_InboxClass, JMms_Inbox>) end;

  JMms_IntentsClass = interface(JObjectClass)
    ['{3E27F783-EA15-4508-90EF-BA2285414942}']
    {class} function _GetCONTENT_CHANGED_ACTION: JString; cdecl;
    {class} function _GetDELETED_CONTENTS: JString; cdecl;
    {class} property CONTENT_CHANGED_ACTION: JString read _GetCONTENT_CHANGED_ACTION;
    {class} property DELETED_CONTENTS: JString read _GetDELETED_CONTENTS;
  end;

  [JavaSignature('android/provider/Telephony$Mms$Intents')]
  JMms_Intents = interface(JObject)
    ['{FE3EA2FA-B3DC-4C0A-AC6D-BBCE5C3A4863}']
  end;
  TJMms_Intents = class(TJavaGenericImport<JMms_IntentsClass, JMms_Intents>) end;

  JMms_OutboxClass = interface(JObjectClass)
    ['{C6E63581-C26E-4F7A-97A4-685782BCF5FB}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Telephony$Mms$Outbox')]
  JMms_Outbox = interface(JObject)
    ['{31A16F32-FD3D-413C-A41F-1DB314E8CA79}']
  end;
  TJMms_Outbox = class(TJavaGenericImport<JMms_OutboxClass, JMms_Outbox>) end;

  JMms_PartClass = interface(JObjectClass)
    ['{D4AE11E6-CBA4-4898-9C9E-D7562DBA9146}']
    {class} function _GetCHARSET: JString; cdecl;
    {class} function _GetCONTENT_DISPOSITION: JString; cdecl;
    {class} function _GetCONTENT_ID: JString; cdecl;
    {class} function _GetCONTENT_LOCATION: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCT_START: JString; cdecl;
    {class} function _GetCT_TYPE: JString; cdecl;
    {class} function _GetFILENAME: JString; cdecl;
    {class} function _GetMSG_ID: JString; cdecl;
    {class} function _GetNAME: JString; cdecl;
    {class} function _GetSEQ: JString; cdecl;
    {class} function _GetTEXT: JString; cdecl;
    {class} function _Get_DATA: JString; cdecl;
    {class} property CHARSET: JString read _GetCHARSET;
    {class} property CONTENT_DISPOSITION: JString read _GetCONTENT_DISPOSITION;
    {class} property CONTENT_ID: JString read _GetCONTENT_ID;
    {class} property CONTENT_LOCATION: JString read _GetCONTENT_LOCATION;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CT_START: JString read _GetCT_START;
    {class} property CT_TYPE: JString read _GetCT_TYPE;
    {class} property FILENAME: JString read _GetFILENAME;
    {class} property MSG_ID: JString read _GetMSG_ID;
    {class} property NAME: JString read _GetNAME;
    {class} property SEQ: JString read _GetSEQ;
    {class} property TEXT: JString read _GetTEXT;
    {class} property _DATA: JString read _Get_DATA;
  end;

  [JavaSignature('android/provider/Telephony$Mms$Part')]
  JMms_Part = interface(JObject)
    ['{05DB69D1-937F-40DB-B62B-9A2EEDDEC69B}']
  end;
  TJMms_Part = class(TJavaGenericImport<JMms_PartClass, JMms_Part>) end;

  JMms_RateClass = interface(JObjectClass)
    ['{2033F000-B2B3-40DC-A5F7-27A42580D397}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetSENT_TIME: JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property SENT_TIME: JString read _GetSENT_TIME;
  end;

  [JavaSignature('android/provider/Telephony$Mms$Rate')]
  JMms_Rate = interface(JObject)
    ['{DDB120C0-BDEC-424B-8550-0457B4F037F6}']
  end;
  TJMms_Rate = class(TJavaGenericImport<JMms_RateClass, JMms_Rate>) end;

  JMms_SentClass = interface(JObjectClass)
    ['{2849E779-E87C-4E37-809D-A9DAA6DC8870}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Telephony$Mms$Sent')]
  JMms_Sent = interface(JObject)
    ['{232C893E-E4A2-415E-814E-041B0DF4C921}']
  end;
  TJMms_Sent = class(TJavaGenericImport<JMms_SentClass, JMms_Sent>) end;

  JTelephony_MmsSmsClass = interface(JObjectClass)
    ['{3C641EB0-FC87-4680-9627-5B11B6787BA0}']
    {class} function _GetCONTENT_CONVERSATIONS_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_DRAFT_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_FILTER_BYPHONE_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_LOCKED_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_UNDELIVERED_URI: Jnet_Uri; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetERR_TYPE_GENERIC: Integer; cdecl;
    {class} function _GetERR_TYPE_GENERIC_PERMANENT: Integer; cdecl;
    {class} function _GetERR_TYPE_MMS_PROTO_PERMANENT: Integer; cdecl;
    {class} function _GetERR_TYPE_MMS_PROTO_TRANSIENT: Integer; cdecl;
    {class} function _GetERR_TYPE_SMS_PROTO_PERMANENT: Integer; cdecl;
    {class} function _GetERR_TYPE_SMS_PROTO_TRANSIENT: Integer; cdecl;
    {class} function _GetERR_TYPE_TRANSPORT_FAILURE: Integer; cdecl;
    {class} function _GetMMS_PROTO: Integer; cdecl;
    {class} function _GetNO_ERROR: Integer; cdecl;
    {class} function _GetSEARCH_URI: Jnet_Uri; cdecl;
    {class} function _GetSMS_PROTO: Integer; cdecl;
    {class} function _GetTYPE_DISCRIMINATOR_COLUMN: JString; cdecl;
    {class} property CONTENT_CONVERSATIONS_URI: Jnet_Uri read _GetCONTENT_CONVERSATIONS_URI;
    {class} property CONTENT_DRAFT_URI: Jnet_Uri read _GetCONTENT_DRAFT_URI;
    {class} property CONTENT_FILTER_BYPHONE_URI: Jnet_Uri read _GetCONTENT_FILTER_BYPHONE_URI;
    {class} property CONTENT_LOCKED_URI: Jnet_Uri read _GetCONTENT_LOCKED_URI;
    {class} property CONTENT_UNDELIVERED_URI: Jnet_Uri read _GetCONTENT_UNDELIVERED_URI;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property ERR_TYPE_GENERIC: Integer read _GetERR_TYPE_GENERIC;
    {class} property ERR_TYPE_GENERIC_PERMANENT: Integer read _GetERR_TYPE_GENERIC_PERMANENT;
    {class} property ERR_TYPE_MMS_PROTO_PERMANENT: Integer read _GetERR_TYPE_MMS_PROTO_PERMANENT;
    {class} property ERR_TYPE_MMS_PROTO_TRANSIENT: Integer read _GetERR_TYPE_MMS_PROTO_TRANSIENT;
    {class} property ERR_TYPE_SMS_PROTO_PERMANENT: Integer read _GetERR_TYPE_SMS_PROTO_PERMANENT;
    {class} property ERR_TYPE_SMS_PROTO_TRANSIENT: Integer read _GetERR_TYPE_SMS_PROTO_TRANSIENT;
    {class} property ERR_TYPE_TRANSPORT_FAILURE: Integer read _GetERR_TYPE_TRANSPORT_FAILURE;
    {class} property MMS_PROTO: Integer read _GetMMS_PROTO;
    {class} property NO_ERROR: Integer read _GetNO_ERROR;
    {class} property SEARCH_URI: Jnet_Uri read _GetSEARCH_URI;
    {class} property SMS_PROTO: Integer read _GetSMS_PROTO;
    {class} property TYPE_DISCRIMINATOR_COLUMN: JString read _GetTYPE_DISCRIMINATOR_COLUMN;
  end;

  [JavaSignature('android/provider/Telephony$MmsSms')]
  JTelephony_MmsSms = interface(JObject)
    ['{3E815C5F-4D4E-4978-8A73-1CFD0805A7D4}']
  end;
  TJTelephony_MmsSms = class(TJavaGenericImport<JTelephony_MmsSmsClass, JTelephony_MmsSms>) end;

  JMmsSms_PendingMessagesClass = interface(JObjectClass)
    ['{97162C4F-25C4-4E73-8645-FADA1D4BE903}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDUE_TIME: JString; cdecl;
    {class} function _GetERROR_CODE: JString; cdecl;
    {class} function _GetERROR_TYPE: JString; cdecl;
    {class} function _GetLAST_TRY: JString; cdecl;
    {class} function _GetMSG_ID: JString; cdecl;
    {class} function _GetMSG_TYPE: JString; cdecl;
    {class} function _GetPROTO_TYPE: JString; cdecl;
    {class} function _GetRETRY_INDEX: JString; cdecl;
    {class} function _GetSUBSCRIPTION_ID: JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DUE_TIME: JString read _GetDUE_TIME;
    {class} property ERROR_CODE: JString read _GetERROR_CODE;
    {class} property ERROR_TYPE: JString read _GetERROR_TYPE;
    {class} property LAST_TRY: JString read _GetLAST_TRY;
    {class} property MSG_ID: JString read _GetMSG_ID;
    {class} property MSG_TYPE: JString read _GetMSG_TYPE;
    {class} property PROTO_TYPE: JString read _GetPROTO_TYPE;
    {class} property RETRY_INDEX: JString read _GetRETRY_INDEX;
    {class} property SUBSCRIPTION_ID: JString read _GetSUBSCRIPTION_ID;
  end;

  [JavaSignature('android/provider/Telephony$MmsSms$PendingMessages')]
  JMmsSms_PendingMessages = interface(JObject)
    ['{F21A7B42-7627-4827-872F-59D88C82A23E}']
  end;
  TJMmsSms_PendingMessages = class(TJavaGenericImport<JMmsSms_PendingMessagesClass, JMmsSms_PendingMessages>) end;

  JTelephony_SmsClass = interface(JObjectClass)
    ['{B605F0BE-90F5-4818-B162-7E6C43CEDBAE}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function getDefaultSmsPackage(context: JContext): JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Telephony$Sms')]
  JTelephony_Sms = interface(JObject)
    ['{CA1CF7EA-132A-4DE2-A9B2-5279D88128BA}']
  end;
  TJTelephony_Sms = class(TJavaGenericImport<JTelephony_SmsClass, JTelephony_Sms>) end;

  JSms_ConversationsClass = interface(JObjectClass)
    ['{3C14EA81-5A19-41C6-BB41-0873237DB3CE}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetMESSAGE_COUNT: JString; cdecl;
    {class} function _GetSNIPPET: JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property MESSAGE_COUNT: JString read _GetMESSAGE_COUNT;
    {class} property SNIPPET: JString read _GetSNIPPET;
  end;

  [JavaSignature('android/provider/Telephony$Sms$Conversations')]
  JSms_Conversations = interface(JObject)
    ['{ADDA98B3-1697-4371-8CA4-0AE848096B0C}']
  end;
  TJSms_Conversations = class(TJavaGenericImport<JSms_ConversationsClass, JSms_Conversations>) end;

  JSms_DraftClass = interface(JObjectClass)
    ['{AFF518C1-0BBA-4F3B-B28A-0396F275D0CB}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Telephony$Sms$Draft')]
  JSms_Draft = interface(JObject)
    ['{08ECE613-10B9-4315-A766-9ED6A7E28FDA}']
  end;
  TJSms_Draft = class(TJavaGenericImport<JSms_DraftClass, JSms_Draft>) end;

  JSms_InboxClass = interface(JObjectClass)
    ['{3FAD811A-3B32-40CF-A211-2DF32E906E7B}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Telephony$Sms$Inbox')]
  JSms_Inbox = interface(JObject)
    ['{C10C2A3B-747E-4632-850A-6F1DD48577DB}']
  end;
  TJSms_Inbox = class(TJavaGenericImport<JSms_InboxClass, JSms_Inbox>) end;

  JSms_IntentsClass = interface(JObjectClass)
    ['{CE57F0D0-1D2F-4478-87E4-130009FC9D76}']
    {class} function _GetACTION_CHANGE_DEFAULT: JString; cdecl;
    {class} function _GetDATA_SMS_RECEIVED_ACTION: JString; cdecl;
    {class} function _GetEXTRA_PACKAGE_NAME: JString; cdecl;
    {class} function _GetRESULT_SMS_DUPLICATED: Integer; cdecl;
    {class} function _GetRESULT_SMS_GENERIC_ERROR: Integer; cdecl;
    {class} function _GetRESULT_SMS_HANDLED: Integer; cdecl;
    {class} function _GetRESULT_SMS_OUT_OF_MEMORY: Integer; cdecl;
    {class} function _GetRESULT_SMS_UNSUPPORTED: Integer; cdecl;
    {class} function _GetSIM_FULL_ACTION: JString; cdecl;
    {class} function _GetSMS_CB_RECEIVED_ACTION: JString; cdecl;
    {class} function _GetSMS_DELIVER_ACTION: JString; cdecl;
    {class} function _GetSMS_EMERGENCY_CB_RECEIVED_ACTION: JString; cdecl;
    {class} function _GetSMS_RECEIVED_ACTION: JString; cdecl;
    {class} function _GetSMS_REJECTED_ACTION: JString; cdecl;
    {class} function _GetSMS_SERVICE_CATEGORY_PROGRAM_DATA_RECEIVED_ACTION: JString; cdecl;
    {class} function _GetWAP_PUSH_DELIVER_ACTION: JString; cdecl;
    {class} function _GetWAP_PUSH_RECEIVED_ACTION: JString; cdecl;
    {class} function getMessagesFromIntent(intent: JIntent): TJavaObjectArray<JSmsMessage>; cdecl;
    {class} property ACTION_CHANGE_DEFAULT: JString read _GetACTION_CHANGE_DEFAULT;
    {class} property DATA_SMS_RECEIVED_ACTION: JString read _GetDATA_SMS_RECEIVED_ACTION;
    {class} property EXTRA_PACKAGE_NAME: JString read _GetEXTRA_PACKAGE_NAME;
    {class} property RESULT_SMS_DUPLICATED: Integer read _GetRESULT_SMS_DUPLICATED;
    {class} property RESULT_SMS_GENERIC_ERROR: Integer read _GetRESULT_SMS_GENERIC_ERROR;
    {class} property RESULT_SMS_HANDLED: Integer read _GetRESULT_SMS_HANDLED;
    {class} property RESULT_SMS_OUT_OF_MEMORY: Integer read _GetRESULT_SMS_OUT_OF_MEMORY;
    {class} property RESULT_SMS_UNSUPPORTED: Integer read _GetRESULT_SMS_UNSUPPORTED;
    {class} property SIM_FULL_ACTION: JString read _GetSIM_FULL_ACTION;
    {class} property SMS_CB_RECEIVED_ACTION: JString read _GetSMS_CB_RECEIVED_ACTION;
    {class} property SMS_DELIVER_ACTION: JString read _GetSMS_DELIVER_ACTION;
    {class} property SMS_EMERGENCY_CB_RECEIVED_ACTION: JString read _GetSMS_EMERGENCY_CB_RECEIVED_ACTION;
    {class} property SMS_RECEIVED_ACTION: JString read _GetSMS_RECEIVED_ACTION;
    {class} property SMS_REJECTED_ACTION: JString read _GetSMS_REJECTED_ACTION;
    {class} property SMS_SERVICE_CATEGORY_PROGRAM_DATA_RECEIVED_ACTION: JString read _GetSMS_SERVICE_CATEGORY_PROGRAM_DATA_RECEIVED_ACTION;
    {class} property WAP_PUSH_DELIVER_ACTION: JString read _GetWAP_PUSH_DELIVER_ACTION;
    {class} property WAP_PUSH_RECEIVED_ACTION: JString read _GetWAP_PUSH_RECEIVED_ACTION;
  end;

  [JavaSignature('android/provider/Telephony$Sms$Intents')]
  JSms_Intents = interface(JObject)
    ['{ED12877B-E026-43A5-8BDC-45D3D3FA547E}']
  end;
  TJSms_Intents = class(TJavaGenericImport<JSms_IntentsClass, JSms_Intents>) end;

  JSms_OutboxClass = interface(JObjectClass)
    ['{FB887BB3-9DAF-4D31-8FC7-DFC8BDF62960}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Telephony$Sms$Outbox')]
  JSms_Outbox = interface(JObject)
    ['{379D789B-00E4-461E-B4C0-1B4DEAB5811B}']
  end;
  TJSms_Outbox = class(TJavaGenericImport<JSms_OutboxClass, JSms_Outbox>) end;

  JSms_SentClass = interface(JObjectClass)
    ['{97A96EE8-E798-4079-8B4B-41B72B116B58}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
  end;

  [JavaSignature('android/provider/Telephony$Sms$Sent')]
  JSms_Sent = interface(JObject)
    ['{4518166B-05F7-4C90-88C6-CEEB85AC2A13}']
  end;
  TJSms_Sent = class(TJavaGenericImport<JSms_SentClass, JSms_Sent>) end;

  JTelephony_TextBasedSmsColumnsClass = interface(IJavaClass)
    ['{B7DAE0BB-DC73-4B8D-AC60-2DDFD18C7DDB}']
    {class} function _GetADDRESS: JString; cdecl;
    {class} function _GetBODY: JString; cdecl;
    {class} function _GetCREATOR: JString; cdecl;
    {class} function _GetDATE: JString; cdecl;
    {class} function _GetDATE_SENT: JString; cdecl;
    {class} function _GetERROR_CODE: JString; cdecl;
    {class} function _GetLOCKED: JString; cdecl;
    {class} function _GetMESSAGE_TYPE_ALL: Integer; cdecl;
    {class} function _GetMESSAGE_TYPE_DRAFT: Integer; cdecl;
    {class} function _GetMESSAGE_TYPE_FAILED: Integer; cdecl;
    {class} function _GetMESSAGE_TYPE_INBOX: Integer; cdecl;
    {class} function _GetMESSAGE_TYPE_OUTBOX: Integer; cdecl;
    {class} function _GetMESSAGE_TYPE_QUEUED: Integer; cdecl;
    {class} function _GetMESSAGE_TYPE_SENT: Integer; cdecl;
    {class} function _GetPERSON: JString; cdecl;
    {class} function _GetPROTOCOL: JString; cdecl;
    {class} function _GetREAD: JString; cdecl;
    {class} function _GetREPLY_PATH_PRESENT: JString; cdecl;
    {class} function _GetSEEN: JString; cdecl;
    {class} function _GetSERVICE_CENTER: JString; cdecl;
    {class} function _GetSTATUS: JString; cdecl;
    {class} function _GetSTATUS_COMPLETE: Integer; cdecl;
    {class} function _GetSTATUS_FAILED: Integer; cdecl;
    {class} function _GetSTATUS_NONE: Integer; cdecl;
    {class} function _GetSTATUS_PENDING: Integer; cdecl;
    {class} function _GetSUBJECT: JString; cdecl;
    {class} function _GetSUBSCRIPTION_ID: JString; cdecl;
    {class} function _GetTHREAD_ID: JString; cdecl;
    {class} function _GetTYPE: JString; cdecl;
    {class} property ADDRESS: JString read _GetADDRESS;
    {class} property BODY: JString read _GetBODY;
    {class} property CREATOR: JString read _GetCREATOR;
    {class} property DATE: JString read _GetDATE;
    {class} property DATE_SENT: JString read _GetDATE_SENT;
    {class} property ERROR_CODE: JString read _GetERROR_CODE;
    {class} property LOCKED: JString read _GetLOCKED;
    {class} property MESSAGE_TYPE_ALL: Integer read _GetMESSAGE_TYPE_ALL;
    {class} property MESSAGE_TYPE_DRAFT: Integer read _GetMESSAGE_TYPE_DRAFT;
    {class} property MESSAGE_TYPE_FAILED: Integer read _GetMESSAGE_TYPE_FAILED;
    {class} property MESSAGE_TYPE_INBOX: Integer read _GetMESSAGE_TYPE_INBOX;
    {class} property MESSAGE_TYPE_OUTBOX: Integer read _GetMESSAGE_TYPE_OUTBOX;
    {class} property MESSAGE_TYPE_QUEUED: Integer read _GetMESSAGE_TYPE_QUEUED;
    {class} property MESSAGE_TYPE_SENT: Integer read _GetMESSAGE_TYPE_SENT;
    {class} property PERSON: JString read _GetPERSON;
    {class} property PROTOCOL: JString read _GetPROTOCOL;
    {class} property READ: JString read _GetREAD;
    {class} property REPLY_PATH_PRESENT: JString read _GetREPLY_PATH_PRESENT;
    {class} property SEEN: JString read _GetSEEN;
    {class} property SERVICE_CENTER: JString read _GetSERVICE_CENTER;
    {class} property STATUS: JString read _GetSTATUS;
    {class} property STATUS_COMPLETE: Integer read _GetSTATUS_COMPLETE;
    {class} property STATUS_FAILED: Integer read _GetSTATUS_FAILED;
    {class} property STATUS_NONE: Integer read _GetSTATUS_NONE;
    {class} property STATUS_PENDING: Integer read _GetSTATUS_PENDING;
    {class} property SUBJECT: JString read _GetSUBJECT;
    {class} property SUBSCRIPTION_ID: JString read _GetSUBSCRIPTION_ID;
    {class} property THREAD_ID: JString read _GetTHREAD_ID;
    {class} property &TYPE: JString read _GetTYPE;
  end;

  [JavaSignature('android/provider/Telephony$TextBasedSmsColumns')]
  JTelephony_TextBasedSmsColumns = interface(IJavaInstance)
    ['{A4D2F073-BC84-4E66-AC1A-00EA7F4654F4}']
  end;
  TJTelephony_TextBasedSmsColumns = class(TJavaGenericImport<JTelephony_TextBasedSmsColumnsClass, JTelephony_TextBasedSmsColumns>) end;

  JTelephony_ThreadsClass = interface(JObjectClass)
    ['{43859060-43ED-4C50-96E0-AFEC41460397}']
    {class} function _GetBROADCAST_THREAD: Integer; cdecl;
    {class} function _GetCOMMON_THREAD: Integer; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetOBSOLETE_THREADS_URI: Jnet_Uri; cdecl;
    {class} function getOrCreateThreadId(context: JContext; recipient: JString): Int64; cdecl; overload;
    {class} function getOrCreateThreadId(context: JContext; recipients: JSet): Int64; cdecl; overload;
    {class} property BROADCAST_THREAD: Integer read _GetBROADCAST_THREAD;
    {class} property COMMON_THREAD: Integer read _GetCOMMON_THREAD;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property OBSOLETE_THREADS_URI: Jnet_Uri read _GetOBSOLETE_THREADS_URI;
  end;

  [JavaSignature('android/provider/Telephony$Threads')]
  JTelephony_Threads = interface(JObject)
    ['{9D44E8F4-6D30-457A-9CAC-0FBA6E419E1A}']
  end;
  TJTelephony_Threads = class(TJavaGenericImport<JTelephony_ThreadsClass, JTelephony_Threads>) end;

  JTelephony_ThreadsColumnsClass = interface(JBaseColumnsClass)
    ['{71A2C7B0-6DAC-4DDA-B733-F765C296070A}']
    {class} function _GetARCHIVED: JString; cdecl;
    {class} function _GetDATE: JString; cdecl;
    {class} function _GetERROR: JString; cdecl;
    {class} function _GetHAS_ATTACHMENT: JString; cdecl;
    {class} function _GetMESSAGE_COUNT: JString; cdecl;
    {class} function _GetREAD: JString; cdecl;
    {class} function _GetRECIPIENT_IDS: JString; cdecl;
    {class} function _GetSNIPPET: JString; cdecl;
    {class} function _GetSNIPPET_CHARSET: JString; cdecl;
    {class} function _GetTYPE: JString; cdecl;
    {class} property ARCHIVED: JString read _GetARCHIVED;
    {class} property DATE: JString read _GetDATE;
    {class} property ERROR: JString read _GetERROR;
    {class} property HAS_ATTACHMENT: JString read _GetHAS_ATTACHMENT;
    {class} property MESSAGE_COUNT: JString read _GetMESSAGE_COUNT;
    {class} property READ: JString read _GetREAD;
    {class} property RECIPIENT_IDS: JString read _GetRECIPIENT_IDS;
    {class} property SNIPPET: JString read _GetSNIPPET;
    {class} property SNIPPET_CHARSET: JString read _GetSNIPPET_CHARSET;
    {class} property &TYPE: JString read _GetTYPE;
  end;

  [JavaSignature('android/provider/Telephony$ThreadsColumns')]
  JTelephony_ThreadsColumns = interface(JBaseColumns)
    ['{B277060A-8F02-450E-9C54-84D567697DD1}']
  end;
  TJTelephony_ThreadsColumns = class(TJavaGenericImport<JTelephony_ThreadsColumnsClass, JTelephony_ThreadsColumns>) end;

  JUserDictionaryClass = interface(JObjectClass)
    ['{AE056B74-BB4E-4A68-AD7A-4972DE859D01}']
    {class} function _GetAUTHORITY: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function init: JUserDictionary; cdecl;
    {class} property AUTHORITY: JString read _GetAUTHORITY;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
  end;

  [JavaSignature('android/provider/UserDictionary')]
  JUserDictionary = interface(JObject)
    ['{0253D7A9-6E15-406B-A6DD-501E4E31452F}']
  end;
  TJUserDictionary = class(TJavaGenericImport<JUserDictionaryClass, JUserDictionary>) end;

  JUserDictionary_WordsClass = interface(JObjectClass)
    ['{906070B3-8F20-4983-8A60-2D81ADCEE971}']
    {class} function _GetAPP_ID: JString; cdecl;
    {class} function _GetCONTENT_ITEM_TYPE: JString; cdecl;
    {class} function _GetCONTENT_TYPE: JString; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDEFAULT_SORT_ORDER: JString; cdecl;
    {class} function _GetFREQUENCY: JString; cdecl;
    {class} function _GetLOCALE: JString; cdecl;
    {class} function _GetLOCALE_TYPE_ALL: Integer; cdecl;
    {class} function _GetLOCALE_TYPE_CURRENT: Integer; cdecl;
    {class} function _GetSHORTCUT: JString; cdecl;
    {class} function _GetWORD: JString; cdecl;
    {class} function _Get_ID: JString; cdecl;
    {class} function init: JUserDictionary_Words; cdecl;
    {class} procedure addWord(context: JContext; word: JString; frequency: Integer; localeType: Integer); cdecl; overload;//Deprecated
    {class} procedure addWord(context: JContext; word: JString; frequency: Integer; shortcut: JString; locale: JLocale); cdecl; overload;
    {class} property APP_ID: JString read _GetAPP_ID;
    {class} property CONTENT_ITEM_TYPE: JString read _GetCONTENT_ITEM_TYPE;
    {class} property CONTENT_TYPE: JString read _GetCONTENT_TYPE;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DEFAULT_SORT_ORDER: JString read _GetDEFAULT_SORT_ORDER;
    {class} property FREQUENCY: JString read _GetFREQUENCY;
    {class} property LOCALE: JString read _GetLOCALE;
    {class} property LOCALE_TYPE_ALL: Integer read _GetLOCALE_TYPE_ALL;
    {class} property LOCALE_TYPE_CURRENT: Integer read _GetLOCALE_TYPE_CURRENT;
    {class} property SHORTCUT: JString read _GetSHORTCUT;
    {class} property WORD: JString read _GetWORD;
    {class} property _ID: JString read _Get_ID;
  end;

  [JavaSignature('android/provider/UserDictionary$Words')]
  JUserDictionary_Words = interface(JObject)
    ['{B5F406C1-D387-4674-8F58-407A1A835C13}']
  end;
  TJUserDictionary_Words = class(TJavaGenericImport<JUserDictionary_WordsClass, JUserDictionary_Words>) end;

  JVoicemailContractClass = interface(JObjectClass)
    ['{C1ACEF9D-8E13-4C59-90AF-A0EC53AC2340}']
    {class} function _GetACTION_FETCH_VOICEMAIL: JString; cdecl;
    {class} function _GetACTION_NEW_VOICEMAIL: JString; cdecl;
    {class} function _GetAUTHORITY: JString; cdecl;
    {class} function _GetEXTRA_SELF_CHANGE: JString; cdecl;
    {class} function _GetPARAM_KEY_SOURCE_PACKAGE: JString; cdecl;
    {class} property ACTION_FETCH_VOICEMAIL: JString read _GetACTION_FETCH_VOICEMAIL;
    {class} property ACTION_NEW_VOICEMAIL: JString read _GetACTION_NEW_VOICEMAIL;
    {class} property AUTHORITY: JString read _GetAUTHORITY;
    {class} property EXTRA_SELF_CHANGE: JString read _GetEXTRA_SELF_CHANGE;
    {class} property PARAM_KEY_SOURCE_PACKAGE: JString read _GetPARAM_KEY_SOURCE_PACKAGE;
  end;

  [JavaSignature('android/provider/VoicemailContract')]
  JVoicemailContract = interface(JObject)
    ['{DA45A3AE-788A-4567-895D-972B3BF4DA89}']
  end;
  TJVoicemailContract = class(TJavaGenericImport<JVoicemailContractClass, JVoicemailContract>) end;

  JVoicemailContract_StatusClass = interface(JObjectClass)
    ['{556B834A-A1B6-4A3F-8C01-81C9AFEF2BC7}']
    {class} function _GetCONFIGURATION_STATE: JString; cdecl;
    {class} function _GetCONFIGURATION_STATE_CAN_BE_CONFIGURED: Integer; cdecl;
    {class} function _GetCONFIGURATION_STATE_NOT_CONFIGURED: Integer; cdecl;
    {class} function _GetCONFIGURATION_STATE_OK: Integer; cdecl;
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDATA_CHANNEL_STATE: JString; cdecl;
    {class} function _GetDATA_CHANNEL_STATE_NO_CONNECTION: Integer; cdecl;
    {class} function _GetDATA_CHANNEL_STATE_OK: Integer; cdecl;
    {class} function _GetDIR_TYPE: JString; cdecl;
    {class} function _GetITEM_TYPE: JString; cdecl;
    {class} function _GetNOTIFICATION_CHANNEL_STATE: JString; cdecl;
    {class} function _GetNOTIFICATION_CHANNEL_STATE_MESSAGE_WAITING: Integer; cdecl;
    {class} function _GetNOTIFICATION_CHANNEL_STATE_NO_CONNECTION: Integer; cdecl;
    {class} function _GetNOTIFICATION_CHANNEL_STATE_OK: Integer; cdecl;
    {class} function _GetPHONE_ACCOUNT_COMPONENT_NAME: JString; cdecl;
    {class} function _GetPHONE_ACCOUNT_ID: JString; cdecl;
    {class} function _GetSETTINGS_URI: JString; cdecl;
    {class} function _GetSOURCE_PACKAGE: JString; cdecl;
    {class} function _GetVOICEMAIL_ACCESS_URI: JString; cdecl;
    {class} function buildSourceUri(packageName: JString): Jnet_Uri; cdecl;
    {class} property CONFIGURATION_STATE: JString read _GetCONFIGURATION_STATE;
    {class} property CONFIGURATION_STATE_CAN_BE_CONFIGURED: Integer read _GetCONFIGURATION_STATE_CAN_BE_CONFIGURED;
    {class} property CONFIGURATION_STATE_NOT_CONFIGURED: Integer read _GetCONFIGURATION_STATE_NOT_CONFIGURED;
    {class} property CONFIGURATION_STATE_OK: Integer read _GetCONFIGURATION_STATE_OK;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DATA_CHANNEL_STATE: JString read _GetDATA_CHANNEL_STATE;
    {class} property DATA_CHANNEL_STATE_NO_CONNECTION: Integer read _GetDATA_CHANNEL_STATE_NO_CONNECTION;
    {class} property DATA_CHANNEL_STATE_OK: Integer read _GetDATA_CHANNEL_STATE_OK;
    {class} property DIR_TYPE: JString read _GetDIR_TYPE;
    {class} property ITEM_TYPE: JString read _GetITEM_TYPE;
    {class} property NOTIFICATION_CHANNEL_STATE: JString read _GetNOTIFICATION_CHANNEL_STATE;
    {class} property NOTIFICATION_CHANNEL_STATE_MESSAGE_WAITING: Integer read _GetNOTIFICATION_CHANNEL_STATE_MESSAGE_WAITING;
    {class} property NOTIFICATION_CHANNEL_STATE_NO_CONNECTION: Integer read _GetNOTIFICATION_CHANNEL_STATE_NO_CONNECTION;
    {class} property NOTIFICATION_CHANNEL_STATE_OK: Integer read _GetNOTIFICATION_CHANNEL_STATE_OK;
    {class} property PHONE_ACCOUNT_COMPONENT_NAME: JString read _GetPHONE_ACCOUNT_COMPONENT_NAME;
    {class} property PHONE_ACCOUNT_ID: JString read _GetPHONE_ACCOUNT_ID;
    {class} property SETTINGS_URI: JString read _GetSETTINGS_URI;
    {class} property SOURCE_PACKAGE: JString read _GetSOURCE_PACKAGE;
    {class} property VOICEMAIL_ACCESS_URI: JString read _GetVOICEMAIL_ACCESS_URI;
  end;

  [JavaSignature('android/provider/VoicemailContract$Status')]
  JVoicemailContract_Status = interface(JObject)
    ['{BB6D0E7D-48D7-4F15-9F84-69867E29D65C}']
  end;
  TJVoicemailContract_Status = class(TJavaGenericImport<JVoicemailContract_StatusClass, JVoicemailContract_Status>) end;

  JVoicemailContract_VoicemailsClass = interface(JObjectClass)
    ['{F1E6537F-292F-49F3-936A-60A5106676E9}']
    {class} function _GetCONTENT_URI: Jnet_Uri; cdecl;
    {class} function _GetDATE: JString; cdecl;
    {class} function _GetDELETED: JString; cdecl;
    {class} function _GetDIRTY: JString; cdecl;
    {class} function _GetDIR_TYPE: JString; cdecl;
    {class} function _GetDURATION: JString; cdecl;
    {class} function _GetHAS_CONTENT: JString; cdecl;
    {class} function _GetIS_READ: JString; cdecl;
    {class} function _GetITEM_TYPE: JString; cdecl;
    {class} function _GetMIME_TYPE: JString; cdecl;
    {class} function _GetNUMBER: JString; cdecl;
    {class} function _GetPHONE_ACCOUNT_COMPONENT_NAME: JString; cdecl;
    {class} function _GetPHONE_ACCOUNT_ID: JString; cdecl;
    {class} function _GetSOURCE_DATA: JString; cdecl;
    {class} function _GetSOURCE_PACKAGE: JString; cdecl;
    {class} function _GetTRANSCRIPTION: JString; cdecl;
    {class} function buildSourceUri(packageName: JString): Jnet_Uri; cdecl;
    {class} property CONTENT_URI: Jnet_Uri read _GetCONTENT_URI;
    {class} property DATE: JString read _GetDATE;
    {class} property DELETED: JString read _GetDELETED;
    {class} property DIRTY: JString read _GetDIRTY;
    {class} property DIR_TYPE: JString read _GetDIR_TYPE;
    {class} property DURATION: JString read _GetDURATION;
    {class} property HAS_CONTENT: JString read _GetHAS_CONTENT;
    {class} property IS_READ: JString read _GetIS_READ;
    {class} property ITEM_TYPE: JString read _GetITEM_TYPE;
    {class} property MIME_TYPE: JString read _GetMIME_TYPE;
    {class} property NUMBER: JString read _GetNUMBER;
    {class} property PHONE_ACCOUNT_COMPONENT_NAME: JString read _GetPHONE_ACCOUNT_COMPONENT_NAME;
    {class} property PHONE_ACCOUNT_ID: JString read _GetPHONE_ACCOUNT_ID;
    {class} property SOURCE_DATA: JString read _GetSOURCE_DATA;
    {class} property SOURCE_PACKAGE: JString read _GetSOURCE_PACKAGE;
    {class} property TRANSCRIPTION: JString read _GetTRANSCRIPTION;
  end;

  [JavaSignature('android/provider/VoicemailContract$Voicemails')]
  JVoicemailContract_Voicemails = interface(JObject)
    ['{4E57943B-60BB-4159-B61E-8A8390CBB320}']
  end;
  TJVoicemailContract_Voicemails = class(TJavaGenericImport<JVoicemailContract_VoicemailsClass, JVoicemailContract_Voicemails>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAlarmClock', TypeInfo(Androidapi.JNI.Provider.JAlarmClock));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JBaseColumns', TypeInfo(Androidapi.JNI.Provider.JBaseColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JBrowser', TypeInfo(Androidapi.JNI.Provider.JBrowser));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JBrowser_BookmarkColumns', TypeInfo(Androidapi.JNI.Provider.JBrowser_BookmarkColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JBrowser_SearchColumns', TypeInfo(Androidapi.JNI.Provider.JBrowser_SearchColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract', TypeInfo(Androidapi.JNI.Provider.JCalendarContract));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_Attendees', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_Attendees));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_CalendarAlerts', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_CalendarAlerts));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_CalendarCache', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_CalendarCache));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_CalendarEntity', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_CalendarEntity));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_Calendars', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_Calendars));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_Colors', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_Colors));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_EventDays', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_EventDays));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_Events', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_Events));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_EventsEntity', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_EventsEntity));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_ExtendedProperties', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_ExtendedProperties));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_Instances', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_Instances));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_Reminders', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_Reminders));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCalendarContract_SyncState', TypeInfo(Androidapi.JNI.Provider.JCalendarContract_SyncState));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCallLog', TypeInfo(Androidapi.JNI.Provider.JCallLog));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCallLog_Calls', TypeInfo(Androidapi.JNI.Provider.JCallLog_Calls));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts', TypeInfo(Androidapi.JNI.Provider.JContacts));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_ContactMethods', TypeInfo(Androidapi.JNI.Provider.JContacts_ContactMethods));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_ContactMethodsColumns', TypeInfo(Androidapi.JNI.Provider.JContacts_ContactMethodsColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_Extensions', TypeInfo(Androidapi.JNI.Provider.JContacts_Extensions));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_ExtensionsColumns', TypeInfo(Androidapi.JNI.Provider.JContacts_ExtensionsColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_GroupMembership', TypeInfo(Androidapi.JNI.Provider.JContacts_GroupMembership));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_Groups', TypeInfo(Androidapi.JNI.Provider.JContacts_Groups));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_GroupsColumns', TypeInfo(Androidapi.JNI.Provider.JContacts_GroupsColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_Intents', TypeInfo(Androidapi.JNI.Provider.JContacts_Intents));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JIntents_Insert', TypeInfo(Androidapi.JNI.Provider.JIntents_Insert));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JIntents_UI', TypeInfo(Androidapi.JNI.Provider.JIntents_UI));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_OrganizationColumns', TypeInfo(Androidapi.JNI.Provider.JContacts_OrganizationColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_Organizations', TypeInfo(Androidapi.JNI.Provider.JContacts_Organizations));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_People', TypeInfo(Androidapi.JNI.Provider.JContacts_People));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JPeople_ContactMethods', TypeInfo(Androidapi.JNI.Provider.JPeople_ContactMethods));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JPeople_Extensions', TypeInfo(Androidapi.JNI.Provider.JPeople_Extensions));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JPeople_Phones', TypeInfo(Androidapi.JNI.Provider.JPeople_Phones));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_PeopleColumns', TypeInfo(Androidapi.JNI.Provider.JContacts_PeopleColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_Phones', TypeInfo(Androidapi.JNI.Provider.JContacts_Phones));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_PhonesColumns', TypeInfo(Androidapi.JNI.Provider.JContacts_PhonesColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_Photos', TypeInfo(Androidapi.JNI.Provider.JContacts_Photos));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_PhotosColumns', TypeInfo(Androidapi.JNI.Provider.JContacts_PhotosColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_PresenceColumns', TypeInfo(Androidapi.JNI.Provider.JContacts_PresenceColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_Settings', TypeInfo(Androidapi.JNI.Provider.JContacts_Settings));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_SettingsColumns', TypeInfo(Androidapi.JNI.Provider.JContacts_SettingsColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract', TypeInfo(Androidapi.JNI.Provider.JContactsContract));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_AggregationExceptions', TypeInfo(Androidapi.JNI.Provider.JContactsContract_AggregationExceptions));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_CommonDataKinds', TypeInfo(Androidapi.JNI.Provider.JContactsContract_CommonDataKinds));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_BaseTypes', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_BaseTypes));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Callable', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Callable));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Contactables', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Contactables));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Email', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Email));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Event', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Event));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_GroupMembership', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_GroupMembership));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Identity', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Identity));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Im', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Im));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Nickname', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Nickname));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Note', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Note));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Organization', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Organization));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Phone', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Phone));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Photo', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Photo));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Relation', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Relation));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_SipAddress', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_SipAddress));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_StructuredName', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_StructuredName));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_StructuredPostal', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_StructuredPostal));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JCommonDataKinds_Website', TypeInfo(Androidapi.JNI.Provider.JCommonDataKinds_Website));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_Contacts', TypeInfo(Androidapi.JNI.Provider.JContactsContract_Contacts));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_AggregationSuggestions', TypeInfo(Androidapi.JNI.Provider.JContacts_AggregationSuggestions));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAggregationSuggestions_Builder', TypeInfo(Androidapi.JNI.Provider.JAggregationSuggestions_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_Data', TypeInfo(Androidapi.JNI.Provider.JContacts_Data));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_Entity', TypeInfo(Androidapi.JNI.Provider.JContacts_Entity));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContacts_Photo', TypeInfo(Androidapi.JNI.Provider.JContacts_Photo));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_Data', TypeInfo(Androidapi.JNI.Provider.JContactsContract_Data));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_DataUsageFeedback', TypeInfo(Androidapi.JNI.Provider.JContactsContract_DataUsageFeedback));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_DeletedContacts', TypeInfo(Androidapi.JNI.Provider.JContactsContract_DeletedContacts));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_Directory', TypeInfo(Androidapi.JNI.Provider.JContactsContract_Directory));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_DisplayNameSources', TypeInfo(Androidapi.JNI.Provider.JContactsContract_DisplayNameSources));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_DisplayPhoto', TypeInfo(Androidapi.JNI.Provider.JContactsContract_DisplayPhoto));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_FullNameStyle', TypeInfo(Androidapi.JNI.Provider.JContactsContract_FullNameStyle));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_Groups', TypeInfo(Androidapi.JNI.Provider.JContactsContract_Groups));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_Intents', TypeInfo(Androidapi.JNI.Provider.JContactsContract_Intents));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_Intents_Insert', TypeInfo(Androidapi.JNI.Provider.JContactsContract_Intents_Insert));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_PhoneLookup', TypeInfo(Androidapi.JNI.Provider.JContactsContract_PhoneLookup));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_PhoneticNameStyle', TypeInfo(Androidapi.JNI.Provider.JContactsContract_PhoneticNameStyle));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_PinnedPositions', TypeInfo(Androidapi.JNI.Provider.JContactsContract_PinnedPositions));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_StatusUpdates', TypeInfo(Androidapi.JNI.Provider.JContactsContract_StatusUpdates));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_Presence', TypeInfo(Androidapi.JNI.Provider.JContactsContract_Presence));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_Profile', TypeInfo(Androidapi.JNI.Provider.JContactsContract_Profile));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_ProfileSyncState', TypeInfo(Androidapi.JNI.Provider.JContactsContract_ProfileSyncState));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_ProviderStatus', TypeInfo(Androidapi.JNI.Provider.JContactsContract_ProviderStatus));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_QuickContact', TypeInfo(Androidapi.JNI.Provider.JContactsContract_QuickContact));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_RawContacts', TypeInfo(Androidapi.JNI.Provider.JContactsContract_RawContacts));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JRawContacts_Data', TypeInfo(Androidapi.JNI.Provider.JRawContacts_Data));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JRawContacts_DisplayPhoto', TypeInfo(Androidapi.JNI.Provider.JRawContacts_DisplayPhoto));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JRawContacts_Entity', TypeInfo(Androidapi.JNI.Provider.JRawContacts_Entity));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_RawContactsEntity', TypeInfo(Androidapi.JNI.Provider.JContactsContract_RawContactsEntity));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_SearchSnippets', TypeInfo(Androidapi.JNI.Provider.JContactsContract_SearchSnippets));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_Settings', TypeInfo(Androidapi.JNI.Provider.JContactsContract_Settings));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JContactsContract_SyncState', TypeInfo(Androidapi.JNI.Provider.JContactsContract_SyncState));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JDocumentsContract', TypeInfo(Androidapi.JNI.Provider.JDocumentsContract));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JDocumentsContract_Document', TypeInfo(Androidapi.JNI.Provider.JDocumentsContract_Document));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JDocumentsContract_Root', TypeInfo(Androidapi.JNI.Provider.JDocumentsContract_Root));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JDocumentsProvider', TypeInfo(Androidapi.JNI.Provider.JDocumentsProvider));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JLiveFolders', TypeInfo(Androidapi.JNI.Provider.JLiveFolders));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMediaStore', TypeInfo(Androidapi.JNI.Provider.JMediaStore));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMediaStore_Audio', TypeInfo(Androidapi.JNI.Provider.JMediaStore_Audio));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAudio_AlbumColumns', TypeInfo(Androidapi.JNI.Provider.JAudio_AlbumColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAudio_Albums', TypeInfo(Androidapi.JNI.Provider.JAudio_Albums));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAudio_ArtistColumns', TypeInfo(Androidapi.JNI.Provider.JAudio_ArtistColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAudio_Artists', TypeInfo(Androidapi.JNI.Provider.JAudio_Artists));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JArtists_Albums', TypeInfo(Androidapi.JNI.Provider.JArtists_Albums));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMediaStore_MediaColumns', TypeInfo(Androidapi.JNI.Provider.JMediaStore_MediaColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAudio_AudioColumns', TypeInfo(Androidapi.JNI.Provider.JAudio_AudioColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAudio_Genres', TypeInfo(Androidapi.JNI.Provider.JAudio_Genres));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JGenres_Members', TypeInfo(Androidapi.JNI.Provider.JGenres_Members));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAudio_GenresColumns', TypeInfo(Androidapi.JNI.Provider.JAudio_GenresColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAudio_Media', TypeInfo(Androidapi.JNI.Provider.JAudio_Media));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAudio_Playlists', TypeInfo(Androidapi.JNI.Provider.JAudio_Playlists));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JPlaylists_Members', TypeInfo(Androidapi.JNI.Provider.JPlaylists_Members));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAudio_PlaylistsColumns', TypeInfo(Androidapi.JNI.Provider.JAudio_PlaylistsColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JAudio_Radio', TypeInfo(Androidapi.JNI.Provider.JAudio_Radio));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMediaStore_Files', TypeInfo(Androidapi.JNI.Provider.JMediaStore_Files));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JFiles_FileColumns', TypeInfo(Androidapi.JNI.Provider.JFiles_FileColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMediaStore_Images', TypeInfo(Androidapi.JNI.Provider.JMediaStore_Images));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JImages_ImageColumns', TypeInfo(Androidapi.JNI.Provider.JImages_ImageColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JImages_Media', TypeInfo(Androidapi.JNI.Provider.JImages_Media));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JImages_Thumbnails', TypeInfo(Androidapi.JNI.Provider.JImages_Thumbnails));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMediaStore_Video', TypeInfo(Androidapi.JNI.Provider.JMediaStore_Video));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JVideo_Media', TypeInfo(Androidapi.JNI.Provider.JVideo_Media));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JVideo_Thumbnails', TypeInfo(Androidapi.JNI.Provider.JVideo_Thumbnails));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JVideo_VideoColumns', TypeInfo(Androidapi.JNI.Provider.JVideo_VideoColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JOpenableColumns', TypeInfo(Androidapi.JNI.Provider.JOpenableColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSearchRecentSuggestions', TypeInfo(Androidapi.JNI.Provider.JSearchRecentSuggestions));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSettings', TypeInfo(Androidapi.JNI.Provider.JSettings));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSettings_NameValueTable', TypeInfo(Androidapi.JNI.Provider.JSettings_NameValueTable));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSettings_Global', TypeInfo(Androidapi.JNI.Provider.JSettings_Global));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSettings_Secure', TypeInfo(Androidapi.JNI.Provider.JSettings_Secure));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSettings_SettingNotFoundException', TypeInfo(Androidapi.JNI.Provider.JSettings_SettingNotFoundException));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSettings_System', TypeInfo(Androidapi.JNI.Provider.JSettings_System));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSyncStateContract', TypeInfo(Androidapi.JNI.Provider.JSyncStateContract));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSyncStateContract_Columns', TypeInfo(Androidapi.JNI.Provider.JSyncStateContract_Columns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSyncStateContract_Constants', TypeInfo(Androidapi.JNI.Provider.JSyncStateContract_Constants));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSyncStateContract_Helpers', TypeInfo(Androidapi.JNI.Provider.JSyncStateContract_Helpers));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JTelephony', TypeInfo(Androidapi.JNI.Provider.JTelephony));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JTelephony_BaseMmsColumns', TypeInfo(Androidapi.JNI.Provider.JTelephony_BaseMmsColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JTelephony_CanonicalAddressesColumns', TypeInfo(Androidapi.JNI.Provider.JTelephony_CanonicalAddressesColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JTelephony_Carriers', TypeInfo(Androidapi.JNI.Provider.JTelephony_Carriers));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JTelephony_Mms', TypeInfo(Androidapi.JNI.Provider.JTelephony_Mms));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMms_Addr', TypeInfo(Androidapi.JNI.Provider.JMms_Addr));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMms_Draft', TypeInfo(Androidapi.JNI.Provider.JMms_Draft));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMms_Inbox', TypeInfo(Androidapi.JNI.Provider.JMms_Inbox));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMms_Intents', TypeInfo(Androidapi.JNI.Provider.JMms_Intents));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMms_Outbox', TypeInfo(Androidapi.JNI.Provider.JMms_Outbox));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMms_Part', TypeInfo(Androidapi.JNI.Provider.JMms_Part));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMms_Rate', TypeInfo(Androidapi.JNI.Provider.JMms_Rate));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMms_Sent', TypeInfo(Androidapi.JNI.Provider.JMms_Sent));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JTelephony_MmsSms', TypeInfo(Androidapi.JNI.Provider.JTelephony_MmsSms));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JMmsSms_PendingMessages', TypeInfo(Androidapi.JNI.Provider.JMmsSms_PendingMessages));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JTelephony_Sms', TypeInfo(Androidapi.JNI.Provider.JTelephony_Sms));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSms_Conversations', TypeInfo(Androidapi.JNI.Provider.JSms_Conversations));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSms_Draft', TypeInfo(Androidapi.JNI.Provider.JSms_Draft));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSms_Inbox', TypeInfo(Androidapi.JNI.Provider.JSms_Inbox));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSms_Intents', TypeInfo(Androidapi.JNI.Provider.JSms_Intents));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSms_Outbox', TypeInfo(Androidapi.JNI.Provider.JSms_Outbox));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JSms_Sent', TypeInfo(Androidapi.JNI.Provider.JSms_Sent));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JTelephony_TextBasedSmsColumns', TypeInfo(Androidapi.JNI.Provider.JTelephony_TextBasedSmsColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JTelephony_Threads', TypeInfo(Androidapi.JNI.Provider.JTelephony_Threads));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JTelephony_ThreadsColumns', TypeInfo(Androidapi.JNI.Provider.JTelephony_ThreadsColumns));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JUserDictionary', TypeInfo(Androidapi.JNI.Provider.JUserDictionary));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JUserDictionary_Words', TypeInfo(Androidapi.JNI.Provider.JUserDictionary_Words));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JVoicemailContract', TypeInfo(Androidapi.JNI.Provider.JVoicemailContract));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JVoicemailContract_Status', TypeInfo(Androidapi.JNI.Provider.JVoicemailContract_Status));
  TRegTypes.RegisterType('Androidapi.JNI.Provider.JVoicemailContract_Voicemails', TypeInfo(Androidapi.JNI.Provider.JVoicemailContract_Voicemails));
end;

initialization
  RegisterTypes;
end.


