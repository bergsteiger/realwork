{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: PropKey.h                              }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.PropKey;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses Winapi.ActiveX;

{$HPPEMIT '#include <propkey.h>'}

const 
//-----------------------------------------------------------------------------
// Audio properties

//  Name:     System.Audio.ChannelCount -- PKEY_Audio_ChannelCount
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_AudioSummaryInformation) {64440490-4C8B-11D1-8B70-080036B11A03}, 7 (PIDASI_CHANNEL_COUNT)
//
//  Indicates the channel count for the audio file.  Values: 1 (mono), 2 (stereo).
  PKEY_Audio_ChannelCount : TPropertyKey = (
    fmtid : '{64440490-4C8B-11D1-8B70-080036B11A03}'; pid : 7);
  {$EXTERNALSYM PKEY_Audio_ChannelCount}

// Possible discrete values for PKEY_Audio_ChannelCount are:
  AUDIO_CHANNELCOUNT_MONO =              1;
  {$EXTERNALSYM AUDIO_CHANNELCOUNT_MONO}
  AUDIO_CHANNELCOUNT_STEREO =            2;
  {$EXTERNALSYM AUDIO_CHANNELCOUNT_STEREO}

//  Name:     System.Audio.Compression -- PKEY_Audio_Compression
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_AudioSummaryInformation) {64440490-4C8B-11D1-8B70-080036B11A03}, 10 (PIDASI_COMPRESSION)
//
//  
  PKEY_Audio_Compression : TPropertyKey = (
    fmtid : '{64440490-4C8B-11D1-8B70-080036B11A03}'; pid : 10);
  {$EXTERNALSYM PKEY_Audio_Compression}

//  Name:     System.Audio.EncodingBitrate -- PKEY_Audio_EncodingBitrate
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_AudioSummaryInformation) {64440490-4C8B-11D1-8B70-080036B11A03}, 4 (PIDASI_AVG_DATA_RATE)
//
//  Indicates the average data rate in Hz for the audio file in "bits per second".
  PKEY_Audio_EncodingBitrate : TPropertyKey = (
    fmtid : '{64440490-4C8B-11D1-8B70-080036B11A03}'; pid : 4);
  {$EXTERNALSYM PKEY_Audio_EncodingBitrate}

//  Name:     System.Audio.Format -- PKEY_Audio_Format
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)  Legacy code may treat this as VT_BSTR.
//  FormatID: (FMTID_AudioSummaryInformation) {64440490-4C8B-11D1-8B70-080036B11A03}, 2 (PIDASI_FORMAT)
//
//  Indicates the format of the audio file.
  PKEY_Audio_Format : TPropertyKey = (
    fmtid : '{64440490-4C8B-11D1-8B70-080036B11A03}'; pid : 2);
  {$EXTERNALSYM PKEY_Audio_Format}

//  Name:     System.Audio.IsVariableBitRate -- PKEY_Audio_IsVariableBitRate
//  Type:     Boolean -- VT_BOOL
//  FormatID: {E6822FEE-8C17-4D62-823C-8E9CFCBD1D5C}, 100
  PKEY_Audio_IsVariableBitRate : TPropertyKey = (
    fmtid : '{E6822FEE-8C17-4D62-823C-8E9CFCBD1D5C}'; pid : 100);
  {$EXTERNALSYM PKEY_Audio_IsVariableBitRate}

//  Name:     System.Audio.PeakValue -- PKEY_Audio_PeakValue
//  Type:     UInt32 -- VT_UI4
//  FormatID: {2579E5D0-1116-4084-BD9A-9B4F7CB4DF5E}, 100
  PKEY_Audio_PeakValue : TPropertyKey = (
    fmtid : '{2579E5D0-1116-4084-BD9A-9B4F7CB4DF5E}'; pid : 100);
  {$EXTERNALSYM PKEY_Audio_PeakValue}

//  Name:     System.Audio.SampleRate -- PKEY_Audio_SampleRate
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_AudioSummaryInformation) {64440490-4C8B-11D1-8B70-080036B11A03}, 5 (PIDASI_SAMPLE_RATE)
//
//  Indicates the audio sample rate for the audio file in "samples per second".
  PKEY_Audio_SampleRate : TPropertyKey = (
    fmtid : '{64440490-4C8B-11D1-8B70-080036B11A03}'; pid : 5);
  {$EXTERNALSYM PKEY_Audio_SampleRate}

//  Name:     System.Audio.SampleSize -- PKEY_Audio_SampleSize
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_AudioSummaryInformation) {64440490-4C8B-11D1-8B70-080036B11A03}, 6 (PIDASI_SAMPLE_SIZE)
//
//  Indicates the audio sample size for the audio file in "bits per sample".
  PKEY_Audio_SampleSize : TPropertyKey = (
    fmtid : '{64440490-4C8B-11D1-8B70-080036B11A03}'; pid : 6);
  {$EXTERNALSYM PKEY_Audio_SampleSize}

//  Name:     System.Audio.StreamName -- PKEY_Audio_StreamName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_AudioSummaryInformation) {64440490-4C8B-11D1-8B70-080036B11A03}, 9 (PIDASI_STREAM_NAME)
//
//  
  PKEY_Audio_StreamName : TPropertyKey = (
    fmtid : '{64440490-4C8B-11D1-8B70-080036B11A03}'; pid : 9);
  {$EXTERNALSYM PKEY_Audio_StreamName}

//  Name:     System.Audio.StreamNumber -- PKEY_Audio_StreamNumber
//  Type:     UInt16 -- VT_UI2
//  FormatID: (FMTID_AudioSummaryInformation) {64440490-4C8B-11D1-8B70-080036B11A03}, 8 (PIDASI_STREAM_NUMBER)
//
//  
  PKEY_Audio_StreamNumber : TPropertyKey = (
    fmtid : '{64440490-4C8B-11D1-8B70-080036B11A03}'; pid : 8);
  {$EXTERNALSYM PKEY_Audio_StreamNumber}

 
 
//-----------------------------------------------------------------------------
// Calendar properties

//  Name:     System.Calendar.Duration -- PKEY_Calendar_Duration
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {293CA35A-09AA-4DD2-B180-1FE245728A52}, 100
//
//  The duration as specified in a string.
  PKEY_Calendar_Duration : TPropertyKey = (
    fmtid : '{293CA35A-09AA-4DD2-B180-1FE245728A52}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_Duration}

//  Name:     System.Calendar.IsOnline -- PKEY_Calendar_IsOnline
//  Type:     Boolean -- VT_BOOL
//  FormatID: {BFEE9149-E3E2-49A7-A862-C05988145CEC}, 100
//
//  Identifies if the event is an online event.
  PKEY_Calendar_IsOnline : TPropertyKey = (
    fmtid : '{BFEE9149-E3E2-49A7-A862-C05988145CEC}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_IsOnline}

//  Name:     System.Calendar.IsRecurring -- PKEY_Calendar_IsRecurring
//  Type:     Boolean -- VT_BOOL
//  FormatID: {315B9C8D-80A9-4EF9-AE16-8E746DA51D70}, 100
  PKEY_Calendar_IsRecurring : TPropertyKey = (
    fmtid : '{315B9C8D-80A9-4EF9-AE16-8E746DA51D70}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_IsRecurring}

//  Name:     System.Calendar.Location -- PKEY_Calendar_Location
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {F6272D18-CECC-40B1-B26A-3911717AA7BD}, 100
  PKEY_Calendar_Location : TPropertyKey = (
    fmtid : '{F6272D18-CECC-40B1-B26A-3911717AA7BD}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_Location}

//  Name:     System.Calendar.OptionalAttendeeAddresses -- PKEY_Calendar_OptionalAttendeeAddresses
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {D55BAE5A-3892-417A-A649-C6AC5AAAEAB3}, 100
  PKEY_Calendar_OptionalAttendeeAddresses : TPropertyKey = (
    fmtid : '{D55BAE5A-3892-417A-A649-C6AC5AAAEAB3}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_OptionalAttendeeAddresses}

//  Name:     System.Calendar.OptionalAttendeeNames -- PKEY_Calendar_OptionalAttendeeNames
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {09429607-582D-437F-84C3-DE93A2B24C3C}, 100
  PKEY_Calendar_OptionalAttendeeNames : TPropertyKey = (
    fmtid : '{09429607-582D-437F-84C3-DE93A2B24C3C}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_OptionalAttendeeNames}

//  Name:     System.Calendar.OrganizerAddress -- PKEY_Calendar_OrganizerAddress
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {744C8242-4DF5-456C-AB9E-014EFB9021E3}, 100
//
//  Address of the organizer organizing the event.
  PKEY_Calendar_OrganizerAddress : TPropertyKey = (
    fmtid : '{744C8242-4DF5-456C-AB9E-014EFB9021E3}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_OrganizerAddress}

//  Name:     System.Calendar.OrganizerName -- PKEY_Calendar_OrganizerName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {AAA660F9-9865-458E-B484-01BC7FE3973E}, 100
//
//  Name of the organizer organizing the event.
  PKEY_Calendar_OrganizerName : TPropertyKey = (
    fmtid : '{AAA660F9-9865-458E-B484-01BC7FE3973E}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_OrganizerName}

//  Name:     System.Calendar.ReminderTime -- PKEY_Calendar_ReminderTime
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {72FC5BA4-24F9-4011-9F3F-ADD27AFAD818}, 100
  PKEY_Calendar_ReminderTime : TPropertyKey = (
    fmtid : '{72FC5BA4-24F9-4011-9F3F-ADD27AFAD818}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_ReminderTime}

//  Name:     System.Calendar.RequiredAttendeeAddresses -- PKEY_Calendar_RequiredAttendeeAddresses
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {0BA7D6C3-568D-4159-AB91-781A91FB71E5}, 100
  PKEY_Calendar_RequiredAttendeeAddresses : TPropertyKey = (
    fmtid : '{0BA7D6C3-568D-4159-AB91-781A91FB71E5}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_RequiredAttendeeAddresses}

//  Name:     System.Calendar.RequiredAttendeeNames -- PKEY_Calendar_RequiredAttendeeNames
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {B33AF30B-F552-4584-936C-CB93E5CDA29F}, 100
  PKEY_Calendar_RequiredAttendeeNames : TPropertyKey = (
    fmtid : '{B33AF30B-F552-4584-936C-CB93E5CDA29F}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_RequiredAttendeeNames}

//  Name:     System.Calendar.Resources -- PKEY_Calendar_Resources
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {00F58A38-C54B-4C40-8696-97235980EAE1}, 100
  PKEY_Calendar_Resources : TPropertyKey = (
    fmtid : '{00F58A38-C54B-4C40-8696-97235980EAE1}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_Resources}

//  Name:     System.Calendar.ResponseStatus -- PKEY_Calendar_ResponseStatus
//  Type:     UInt16 -- VT_UI2
//  FormatID: {188C1F91-3C40-4132-9EC5-D8B03B72A8A2}, 100
//  
//  This property stores the status of the user responses to meetings in her calendar.
  PKEY_Calendar_ResponseStatus : TPropertyKey = (
    fmtid : '{188C1F91-3C40-4132-9EC5-D8B03B72A8A2}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_ResponseStatus}

// Possible discrete values for PKEY_Calendar_ResponseStatus are:
  CALENDAR_RESPONSESTATUS_NONE =         0;
  {$EXTERNALSYM CALENDAR_RESPONSESTATUS_NONE}
  CALENDAR_RESPONSESTATUS_ORGANIZED =    1;
  {$EXTERNALSYM CALENDAR_RESPONSESTATUS_ORGANIZED}
  CALENDAR_RESPONSESTATUS_TENTATIVE =    2;
  {$EXTERNALSYM CALENDAR_RESPONSESTATUS_TENTATIVE}
  CALENDAR_RESPONSESTATUS_ACCEPTED =     3;
  {$EXTERNALSYM CALENDAR_RESPONSESTATUS_ACCEPTED}
  CALENDAR_RESPONSESTATUS_DECLINED =     4;
  {$EXTERNALSYM CALENDAR_RESPONSESTATUS_DECLINED}
  CALENDAR_RESPONSESTATUS_NOTRESPONDED =  5;
  {$EXTERNALSYM CALENDAR_RESPONSESTATUS_NOTRESPONDED}

//  Name:     System.Calendar.ShowTimeAs -- PKEY_Calendar_ShowTimeAs
//  Type:     UInt16 -- VT_UI2
//  FormatID: {5BF396D4-5EB2-466F-BDE9-2FB3F2361D6E}, 100
//
//  
  PKEY_Calendar_ShowTimeAs : TPropertyKey = (
    fmtid : '{5BF396D4-5EB2-466F-BDE9-2FB3F2361D6E}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_ShowTimeAs}

// Possible discrete values for PKEY_Calendar_ShowTimeAs are:
  CALENDAR_SHOWTIMEAS_FREE =             0;
  {$EXTERNALSYM CALENDAR_SHOWTIMEAS_FREE}
  CALENDAR_SHOWTIMEAS_TENTATIVE =        1;
  {$EXTERNALSYM CALENDAR_SHOWTIMEAS_TENTATIVE}
  CALENDAR_SHOWTIMEAS_BUSY =             2;
  {$EXTERNALSYM CALENDAR_SHOWTIMEAS_BUSY}
  CALENDAR_SHOWTIMEAS_OOF =              3;
  {$EXTERNALSYM CALENDAR_SHOWTIMEAS_OOF}

//  Name:     System.Calendar.ShowTimeAsText -- PKEY_Calendar_ShowTimeAsText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {53DA57CF-62C0-45C4-81DE-7610BCEFD7F5}, 100
//  
//  This is the user-friendly form of System.Calendar.ShowTimeAs.  Not intended to be parsed 
//  programmatically.
  PKEY_Calendar_ShowTimeAsText : TPropertyKey = (
    fmtid : '{53DA57CF-62C0-45C4-81DE-7610BCEFD7F5}'; pid : 100);
  {$EXTERNALSYM PKEY_Calendar_ShowTimeAsText}
 
//-----------------------------------------------------------------------------
// Communication properties



//  Name:     System.Communication.AccountName -- PKEY_Communication_AccountName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 9
//
//  Account Name
  PKEY_Communication_AccountName : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 9);
  {$EXTERNALSYM PKEY_Communication_AccountName}

//  Name:     System.Communication.DateItemExpires -- PKEY_Communication_DateItemExpires
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {428040AC-A177-4C8A-9760-F6F761227F9A}, 100
//  
//  Date the item expires due to the retention policy.
  PKEY_Communication_DateItemExpires : TPropertyKey = (
    fmtid : '{428040AC-A177-4C8A-9760-F6F761227F9A}'; pid : 100);
  {$EXTERNALSYM PKEY_Communication_DateItemExpires}

//  Name:     System.Communication.FollowupIconIndex -- PKEY_Communication_FollowupIconIndex
//  Type:     Int32 -- VT_I4
//  FormatID: {83A6347E-6FE4-4F40-BA9C-C4865240D1F4}, 100
//  
//  This is the icon index used on messages marked for followup.
  PKEY_Communication_FollowupIconIndex : TPropertyKey = (
    fmtid : '{83A6347E-6FE4-4F40-BA9C-C4865240D1F4}'; pid : 100);
  {$EXTERNALSYM PKEY_Communication_FollowupIconIndex}

//  Name:     System.Communication.HeaderItem -- PKEY_Communication_HeaderItem
//  Type:     Boolean -- VT_BOOL
//  FormatID: {C9C34F84-2241-4401-B607-BD20ED75AE7F}, 100
//  
//  This property will be true if the item is a header item which means the item hasn't been fully downloaded.
  PKEY_Communication_HeaderItem : TPropertyKey = (
    fmtid : '{C9C34F84-2241-4401-B607-BD20ED75AE7F}'; pid : 100);
  {$EXTERNALSYM PKEY_Communication_HeaderItem}

//  Name:     System.Communication.PolicyTag -- PKEY_Communication_PolicyTag
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {EC0B4191-AB0B-4C66-90B6-C6637CDEBBAB}, 100
//  
//  This a string used to identify the retention policy applied to the item.
  PKEY_Communication_PolicyTag : TPropertyKey = (
    fmtid : '{EC0B4191-AB0B-4C66-90B6-C6637CDEBBAB}'; pid : 100);
  {$EXTERNALSYM PKEY_Communication_PolicyTag}

//  Name:     System.Communication.SecurityFlags -- PKEY_Communication_SecurityFlags
//  Type:     Int32 -- VT_I4
//  FormatID: {8619A4B6-9F4D-4429-8C0F-B996CA59E335}, 100
//  
//  Security flags associated with the item to know if the item is encrypted, signed or DRM enabled.
  PKEY_Communication_SecurityFlags : TPropertyKey = (
    fmtid : '{8619A4B6-9F4D-4429-8C0F-B996CA59E335}'; pid : 100);
  {$EXTERNALSYM PKEY_Communication_SecurityFlags}

//  Name:     System.Communication.Suffix -- PKEY_Communication_Suffix
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {807B653A-9E91-43EF-8F97-11CE04EE20C5}, 100
  PKEY_Communication_Suffix : TPropertyKey = (
    fmtid : '{807B653A-9E91-43EF-8F97-11CE04EE20C5}'; pid : 100);
  {$EXTERNALSYM PKEY_Communication_Suffix}

//  Name:     System.Communication.TaskStatus -- PKEY_Communication_TaskStatus
//  Type:     UInt16 -- VT_UI2
//  FormatID: {BE1A72C6-9A1D-46B7-AFE7-AFAF8CEF4999}, 100
  PKEY_Communication_TaskStatus : TPropertyKey = (
    fmtid : '{BE1A72C6-9A1D-46B7-AFE7-AFAF8CEF4999}'; pid : 100);
  {$EXTERNALSYM PKEY_Communication_TaskStatus}

// Possible discrete values for PKEY_Communication_TaskStatus are:
  TASKSTATUS_NOTSTARTED =                0;
  {$EXTERNALSYM TASKSTATUS_NOTSTARTED}
  TASKSTATUS_INPROGRESS =                1;
  {$EXTERNALSYM TASKSTATUS_INPROGRESS}
  TASKSTATUS_COMPLETE =                  2;
  {$EXTERNALSYM TASKSTATUS_COMPLETE}
  TASKSTATUS_WAITING =                   3;
  {$EXTERNALSYM TASKSTATUS_WAITING}
  TASKSTATUS_DEFERRED =                  4;
  {$EXTERNALSYM TASKSTATUS_DEFERRED}

//  Name:     System.Communication.TaskStatusText -- PKEY_Communication_TaskStatusText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {A6744477-C237-475B-A075-54F34498292A}, 100
//  
//  This is the user-friendly form of System.Communication.TaskStatus.  Not intended to be parsed 
//  programmatically.
  PKEY_Communication_TaskStatusText : TPropertyKey = (
    fmtid : '{A6744477-C237-475B-A075-54F34498292A}'; pid : 100);
  {$EXTERNALSYM PKEY_Communication_TaskStatusText}
 
//-----------------------------------------------------------------------------
// Computer properties



//  Name:     System.Computer.DecoratedFreeSpace -- PKEY_Computer_DecoratedFreeSpace
//  Type:     Multivalue UInt64 -- VT_VECTOR | VT_UI8  (For variants: VT_ARRAY | VT_UI8)
//  FormatID: (FMTID_Volume) {9B174B35-40FF-11D2-A27E-00C04FC30871}, 7  (Filesystem Volume Properties)
//
//  Free space and total space: "%s free of %s"
  PKEY_Computer_DecoratedFreeSpace : TPropertyKey = (
    fmtid : '{9B174B35-40FF-11D2-A27E-00C04FC30871}'; pid : 7);
  {$EXTERNALSYM PKEY_Computer_DecoratedFreeSpace}
 
//-----------------------------------------------------------------------------
// Contact properties



//  Name:     System.Contact.Anniversary -- PKEY_Contact_Anniversary
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {9AD5BADB-CEA7-4470-A03D-B84E51B9949E}, 100
  PKEY_Contact_Anniversary : TPropertyKey = (
    fmtid : '{9AD5BADB-CEA7-4470-A03D-B84E51B9949E}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_Anniversary}

//  Name:     System.Contact.AssistantName -- PKEY_Contact_AssistantName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {CD102C9C-5540-4A88-A6F6-64E4981C8CD1}, 100
  PKEY_Contact_AssistantName : TPropertyKey = (
    fmtid : '{CD102C9C-5540-4A88-A6F6-64E4981C8CD1}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_AssistantName}

//  Name:     System.Contact.AssistantTelephone -- PKEY_Contact_AssistantTelephone
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {9A93244D-A7AD-4FF8-9B99-45EE4CC09AF6}, 100
  PKEY_Contact_AssistantTelephone : TPropertyKey = (
    fmtid : '{9A93244D-A7AD-4FF8-9B99-45EE4CC09AF6}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_AssistantTelephone}

//  Name:     System.Contact.Birthday -- PKEY_Contact_Birthday
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 47
  PKEY_Contact_Birthday : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 47);
  {$EXTERNALSYM PKEY_Contact_Birthday}

//  Name:     System.Contact.BusinessAddress -- PKEY_Contact_BusinessAddress
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {730FB6DD-CF7C-426B-A03F-BD166CC9EE24}, 100
  PKEY_Contact_BusinessAddress : TPropertyKey = (
    fmtid : '{730FB6DD-CF7C-426B-A03F-BD166CC9EE24}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_BusinessAddress}

//  Name:     System.Contact.BusinessAddressCity -- PKEY_Contact_BusinessAddressCity
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {402B5934-EC5A-48C3-93E6-85E86A2D934E}, 100
  PKEY_Contact_BusinessAddressCity : TPropertyKey = (
    fmtid : '{402B5934-EC5A-48C3-93E6-85E86A2D934E}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_BusinessAddressCity}

//  Name:     System.Contact.BusinessAddressCountry -- PKEY_Contact_BusinessAddressCountry
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {B0B87314-FCF6-4FEB-8DFF-A50DA6AF561C}, 100
  PKEY_Contact_BusinessAddressCountry : TPropertyKey = (
    fmtid : '{B0B87314-FCF6-4FEB-8DFF-A50DA6AF561C}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_BusinessAddressCountry}

//  Name:     System.Contact.BusinessAddressPostalCode -- PKEY_Contact_BusinessAddressPostalCode
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E1D4A09E-D758-4CD1-B6EC-34A8B5A73F80}, 100
  PKEY_Contact_BusinessAddressPostalCode : TPropertyKey = (
    fmtid : '{E1D4A09E-D758-4CD1-B6EC-34A8B5A73F80}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_BusinessAddressPostalCode}

//  Name:     System.Contact.BusinessAddressPostOfficeBox -- PKEY_Contact_BusinessAddressPostOfficeBox
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {BC4E71CE-17F9-48D5-BEE9-021DF0EA5409}, 100
  PKEY_Contact_BusinessAddressPostOfficeBox : TPropertyKey = (
    fmtid : '{BC4E71CE-17F9-48D5-BEE9-021DF0EA5409}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_BusinessAddressPostOfficeBox}

//  Name:     System.Contact.BusinessAddressState -- PKEY_Contact_BusinessAddressState
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {446F787F-10C4-41CB-A6C4-4D0343551597}, 100
  PKEY_Contact_BusinessAddressState : TPropertyKey = (
    fmtid : '{446F787F-10C4-41CB-A6C4-4D0343551597}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_BusinessAddressState}

//  Name:     System.Contact.BusinessAddressStreet -- PKEY_Contact_BusinessAddressStreet
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {DDD1460F-C0BF-4553-8CE4-10433C908FB0}, 100
  PKEY_Contact_BusinessAddressStreet : TPropertyKey = (
    fmtid : '{DDD1460F-C0BF-4553-8CE4-10433C908FB0}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_BusinessAddressStreet}

//  Name:     System.Contact.BusinessFaxNumber -- PKEY_Contact_BusinessFaxNumber
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {91EFF6F3-2E27-42CA-933E-7C999FBE310B}, 100
//
//  Business fax number of the contact.
  PKEY_Contact_BusinessFaxNumber : TPropertyKey = (
    fmtid : '{91EFF6F3-2E27-42CA-933E-7C999FBE310B}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_BusinessFaxNumber}

//  Name:     System.Contact.BusinessHomePage -- PKEY_Contact_BusinessHomePage
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {56310920-2491-4919-99CE-EADB06FAFDB2}, 100
  PKEY_Contact_BusinessHomePage : TPropertyKey = (
    fmtid : '{56310920-2491-4919-99CE-EADB06FAFDB2}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_BusinessHomePage}

//  Name:     System.Contact.BusinessTelephone -- PKEY_Contact_BusinessTelephone
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {6A15E5A0-0A1E-4CD7-BB8C-D2F1B0C929BC}, 100
  PKEY_Contact_BusinessTelephone : TPropertyKey = (
    fmtid : '{6A15E5A0-0A1E-4CD7-BB8C-D2F1B0C929BC}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_BusinessTelephone}

//  Name:     System.Contact.CallbackTelephone -- PKEY_Contact_CallbackTelephone
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {BF53D1C3-49E0-4F7F-8567-5A821D8AC542}, 100
  PKEY_Contact_CallbackTelephone : TPropertyKey = (
    fmtid : '{BF53D1C3-49E0-4F7F-8567-5A821D8AC542}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_CallbackTelephone}

//  Name:     System.Contact.CarTelephone -- PKEY_Contact_CarTelephone
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {8FDC6DEA-B929-412B-BA90-397A257465FE}, 100
  PKEY_Contact_CarTelephone : TPropertyKey = (
    fmtid : '{8FDC6DEA-B929-412B-BA90-397A257465FE}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_CarTelephone}

//  Name:     System.Contact.Children -- PKEY_Contact_Children
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {D4729704-8EF1-43EF-9024-2BD381187FD5}, 100
  PKEY_Contact_Children : TPropertyKey = (
    fmtid : '{D4729704-8EF1-43EF-9024-2BD381187FD5}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_Children}

//  Name:     System.Contact.CompanyMainTelephone -- PKEY_Contact_CompanyMainTelephone
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {8589E481-6040-473D-B171-7FA89C2708ED}, 100
  PKEY_Contact_CompanyMainTelephone : TPropertyKey = (
    fmtid : '{8589E481-6040-473D-B171-7FA89C2708ED}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_CompanyMainTelephone}

//  Name:     System.Contact.Department -- PKEY_Contact_Department
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {FC9F7306-FF8F-4D49-9FB6-3FFE5C0951EC}, 100
  PKEY_Contact_Department : TPropertyKey = (
    fmtid : '{FC9F7306-FF8F-4D49-9FB6-3FFE5C0951EC}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_Department}

//  Name:     System.Contact.EmailAddress -- PKEY_Contact_EmailAddress
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {F8FA7FA3-D12B-4785-8A4E-691A94F7A3E7}, 100
  PKEY_Contact_EmailAddress : TPropertyKey = (
    fmtid : '{F8FA7FA3-D12B-4785-8A4E-691A94F7A3E7}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_EmailAddress}

//  Name:     System.Contact.EmailAddress2 -- PKEY_Contact_EmailAddress2
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {38965063-EDC8-4268-8491-B7723172CF29}, 100
  PKEY_Contact_EmailAddress2 : TPropertyKey = (
    fmtid : '{38965063-EDC8-4268-8491-B7723172CF29}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_EmailAddress2}

//  Name:     System.Contact.EmailAddress3 -- PKEY_Contact_EmailAddress3
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {644D37B4-E1B3-4BAD-B099-7E7C04966ACA}, 100
  PKEY_Contact_EmailAddress3 : TPropertyKey = (
    fmtid : '{644D37B4-E1B3-4BAD-B099-7E7C04966ACA}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_EmailAddress3}

//  Name:     System.Contact.EmailAddresses -- PKEY_Contact_EmailAddresses
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {84D8F337-981D-44B3-9615-C7596DBA17E3}, 100
  PKEY_Contact_EmailAddresses : TPropertyKey = (
    fmtid : '{84D8F337-981D-44B3-9615-C7596DBA17E3}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_EmailAddresses}

//  Name:     System.Contact.EmailName -- PKEY_Contact_EmailName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {CC6F4F24-6083-4BD4-8754-674D0DE87AB8}, 100
  PKEY_Contact_EmailName : TPropertyKey = (
    fmtid : '{CC6F4F24-6083-4BD4-8754-674D0DE87AB8}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_EmailName}

//  Name:     System.Contact.FileAsName -- PKEY_Contact_FileAsName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {F1A24AA7-9CA7-40F6-89EC-97DEF9FFE8DB}, 100
  PKEY_Contact_FileAsName : TPropertyKey = (
    fmtid : '{F1A24AA7-9CA7-40F6-89EC-97DEF9FFE8DB}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_FileAsName}

//  Name:     System.Contact.FirstName -- PKEY_Contact_FirstName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {14977844-6B49-4AAD-A714-A4513BF60460}, 100
  PKEY_Contact_FirstName : TPropertyKey = (
    fmtid : '{14977844-6B49-4AAD-A714-A4513BF60460}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_FirstName}

//  Name:     System.Contact.FullName -- PKEY_Contact_FullName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {635E9051-50A5-4BA2-B9DB-4ED056C77296}, 100
  PKEY_Contact_FullName : TPropertyKey = (
    fmtid : '{635E9051-50A5-4BA2-B9DB-4ED056C77296}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_FullName}

//  Name:     System.Contact.Gender -- PKEY_Contact_Gender
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {3C8CEE58-D4F0-4CF9-B756-4E5D24447BCD}, 100
  PKEY_Contact_Gender : TPropertyKey = (
    fmtid : '{3C8CEE58-D4F0-4CF9-B756-4E5D24447BCD}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_Gender}

//  Name:     System.Contact.GenderValue -- PKEY_Contact_GenderValue
//  Type:     UInt16 -- VT_UI2
//  FormatID: {3C8CEE58-D4F0-4CF9-B756-4E5D24447BCD}, 101
  PKEY_Contact_GenderValue : TPropertyKey = (
    fmtid : '{3C8CEE58-D4F0-4CF9-B756-4E5D24447BCD}'; pid : 101);
  {$EXTERNALSYM PKEY_Contact_GenderValue}

// Possible discrete values for PKEY_Contact_GenderValue are:
  GENDERVALUE_UNSPECIFIED =              0;
  {$EXTERNALSYM GENDERVALUE_UNSPECIFIED}
  GENDERVALUE_FEMALE =                   1;
  {$EXTERNALSYM GENDERVALUE_FEMALE}
  GENDERVALUE_MALE =                     2;
  {$EXTERNALSYM GENDERVALUE_MALE}

//  Name:     System.Contact.Hobbies -- PKEY_Contact_Hobbies
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {5DC2253F-5E11-4ADF-9CFE-910DD01E3E70}, 100
  PKEY_Contact_Hobbies : TPropertyKey = (
    fmtid : '{5DC2253F-5E11-4ADF-9CFE-910DD01E3E70}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_Hobbies}

//  Name:     System.Contact.HomeAddress -- PKEY_Contact_HomeAddress
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {98F98354-617A-46B8-8560-5B1B64BF1F89}, 100
  PKEY_Contact_HomeAddress : TPropertyKey = (
    fmtid : '{98F98354-617A-46B8-8560-5B1B64BF1F89}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_HomeAddress}

//  Name:     System.Contact.HomeAddressCity -- PKEY_Contact_HomeAddressCity
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 65
  PKEY_Contact_HomeAddressCity : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 65);
  {$EXTERNALSYM PKEY_Contact_HomeAddressCity}

//  Name:     System.Contact.HomeAddressCountry -- PKEY_Contact_HomeAddressCountry
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {08A65AA1-F4C9-43DD-9DDF-A33D8E7EAD85}, 100
  PKEY_Contact_HomeAddressCountry : TPropertyKey = (
    fmtid : '{08A65AA1-F4C9-43DD-9DDF-A33D8E7EAD85}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_HomeAddressCountry}

//  Name:     System.Contact.HomeAddressPostalCode -- PKEY_Contact_HomeAddressPostalCode
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {8AFCC170-8A46-4B53-9EEE-90BAE7151E62}, 100
  PKEY_Contact_HomeAddressPostalCode : TPropertyKey = (
    fmtid : '{8AFCC170-8A46-4B53-9EEE-90BAE7151E62}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_HomeAddressPostalCode}

//  Name:     System.Contact.HomeAddressPostOfficeBox -- PKEY_Contact_HomeAddressPostOfficeBox
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {7B9F6399-0A3F-4B12-89BD-4ADC51C918AF}, 100
  PKEY_Contact_HomeAddressPostOfficeBox : TPropertyKey = (
    fmtid : '{7B9F6399-0A3F-4B12-89BD-4ADC51C918AF}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_HomeAddressPostOfficeBox}

//  Name:     System.Contact.HomeAddressState -- PKEY_Contact_HomeAddressState
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C89A23D0-7D6D-4EB8-87D4-776A82D493E5}, 100
  PKEY_Contact_HomeAddressState : TPropertyKey = (
    fmtid : '{C89A23D0-7D6D-4EB8-87D4-776A82D493E5}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_HomeAddressState}

//  Name:     System.Contact.HomeAddressStreet -- PKEY_Contact_HomeAddressStreet
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {0ADEF160-DB3F-4308-9A21-06237B16FA2A}, 100
  PKEY_Contact_HomeAddressStreet : TPropertyKey = (
    fmtid : '{0ADEF160-DB3F-4308-9A21-06237B16FA2A}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_HomeAddressStreet}

//  Name:     System.Contact.HomeFaxNumber -- PKEY_Contact_HomeFaxNumber
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {660E04D6-81AB-4977-A09F-82313113AB26}, 100
  PKEY_Contact_HomeFaxNumber : TPropertyKey = (
    fmtid : '{660E04D6-81AB-4977-A09F-82313113AB26}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_HomeFaxNumber}

//  Name:     System.Contact.HomeTelephone -- PKEY_Contact_HomeTelephone
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 20
  PKEY_Contact_HomeTelephone : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 20);
  {$EXTERNALSYM PKEY_Contact_HomeTelephone}

//  Name:     System.Contact.IMAddress -- PKEY_Contact_IMAddress
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {D68DBD8A-3374-4B81-9972-3EC30682DB3D}, 100
  PKEY_Contact_IMAddress : TPropertyKey = (
    fmtid : '{D68DBD8A-3374-4B81-9972-3EC30682DB3D}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_IMAddress}

//  Name:     System.Contact.Initials -- PKEY_Contact_Initials
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {F3D8F40D-50CB-44A2-9718-40CB9119495D}, 100
  PKEY_Contact_Initials : TPropertyKey = (
    fmtid : '{F3D8F40D-50CB-44A2-9718-40CB9119495D}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_Initials}

//  Name:     System.Contact.JA.CompanyNamePhonetic -- PKEY_Contact_JA_CompanyNamePhonetic
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {897B3694-FE9E-43E6-8066-260F590C0100}, 2
//  
//  
  PKEY_Contact_JA_CompanyNamePhonetic : TPropertyKey = (
    fmtid : '{897B3694-FE9E-43E6-8066-260F590C0100}'; pid : 2);
  {$EXTERNALSYM PKEY_Contact_JA_CompanyNamePhonetic}

//  Name:     System.Contact.JA.FirstNamePhonetic -- PKEY_Contact_JA_FirstNamePhonetic
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {897B3694-FE9E-43E6-8066-260F590C0100}, 3
//  
//  
  PKEY_Contact_JA_FirstNamePhonetic : TPropertyKey = (
    fmtid : '{897B3694-FE9E-43E6-8066-260F590C0100}'; pid : 3);
  {$EXTERNALSYM PKEY_Contact_JA_FirstNamePhonetic}

//  Name:     System.Contact.JA.LastNamePhonetic -- PKEY_Contact_JA_LastNamePhonetic
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {897B3694-FE9E-43E6-8066-260F590C0100}, 4
//  
//  
  PKEY_Contact_JA_LastNamePhonetic : TPropertyKey = (
    fmtid : '{897B3694-FE9E-43E6-8066-260F590C0100}'; pid : 4);
  {$EXTERNALSYM PKEY_Contact_JA_LastNamePhonetic}

//  Name:     System.Contact.JobTitle -- PKEY_Contact_JobTitle
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 6
  PKEY_Contact_JobTitle : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 6);
  {$EXTERNALSYM PKEY_Contact_JobTitle}

//  Name:     System.Contact.Label -- PKEY_Contact_Label
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {97B0AD89-DF49-49CC-834E-660974FD755B}, 100
  PKEY_Contact_Label : TPropertyKey = (
    fmtid : '{97B0AD89-DF49-49CC-834E-660974FD755B}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_Label}

//  Name:     System.Contact.LastName -- PKEY_Contact_LastName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {8F367200-C270-457C-B1D4-E07C5BCD90C7}, 100
  PKEY_Contact_LastName : TPropertyKey = (
    fmtid : '{8F367200-C270-457C-B1D4-E07C5BCD90C7}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_LastName}

//  Name:     System.Contact.MailingAddress -- PKEY_Contact_MailingAddress
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C0AC206A-827E-4650-95AE-77E2BB74FCC9}, 100
  PKEY_Contact_MailingAddress : TPropertyKey = (
    fmtid : '{C0AC206A-827E-4650-95AE-77E2BB74FCC9}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_MailingAddress}

//  Name:     System.Contact.MiddleName -- PKEY_Contact_MiddleName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 71
  PKEY_Contact_MiddleName : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 71);
  {$EXTERNALSYM PKEY_Contact_MiddleName}

//  Name:     System.Contact.MobileTelephone -- PKEY_Contact_MobileTelephone
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 35
  PKEY_Contact_MobileTelephone : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 35);
  {$EXTERNALSYM PKEY_Contact_MobileTelephone}

//  Name:     System.Contact.NickName -- PKEY_Contact_NickName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 74
  PKEY_Contact_NickName : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 74);
  {$EXTERNALSYM PKEY_Contact_NickName}

//  Name:     System.Contact.OfficeLocation -- PKEY_Contact_OfficeLocation
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 7
  PKEY_Contact_OfficeLocation : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 7);
  {$EXTERNALSYM PKEY_Contact_OfficeLocation}

//  Name:     System.Contact.OtherAddress -- PKEY_Contact_OtherAddress
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {508161FA-313B-43D5-83A1-C1ACCF68622C}, 100
  PKEY_Contact_OtherAddress : TPropertyKey = (
    fmtid : '{508161FA-313B-43D5-83A1-C1ACCF68622C}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_OtherAddress}

//  Name:     System.Contact.OtherAddressCity -- PKEY_Contact_OtherAddressCity
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {6E682923-7F7B-4F0C-A337-CFCA296687BF}, 100
  PKEY_Contact_OtherAddressCity : TPropertyKey = (
    fmtid : '{6E682923-7F7B-4F0C-A337-CFCA296687BF}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_OtherAddressCity}

//  Name:     System.Contact.OtherAddressCountry -- PKEY_Contact_OtherAddressCountry
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {8F167568-0AAE-4322-8ED9-6055B7B0E398}, 100
  PKEY_Contact_OtherAddressCountry : TPropertyKey = (
    fmtid : '{8F167568-0AAE-4322-8ED9-6055B7B0E398}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_OtherAddressCountry}

//  Name:     System.Contact.OtherAddressPostalCode -- PKEY_Contact_OtherAddressPostalCode
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {95C656C1-2ABF-4148-9ED3-9EC602E3B7CD}, 100
  PKEY_Contact_OtherAddressPostalCode : TPropertyKey = (
    fmtid : '{95C656C1-2ABF-4148-9ED3-9EC602E3B7CD}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_OtherAddressPostalCode}

//  Name:     System.Contact.OtherAddressPostOfficeBox -- PKEY_Contact_OtherAddressPostOfficeBox
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {8B26EA41-058F-43F6-AECC-4035681CE977}, 100
  PKEY_Contact_OtherAddressPostOfficeBox : TPropertyKey = (
    fmtid : '{8B26EA41-058F-43F6-AECC-4035681CE977}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_OtherAddressPostOfficeBox}

//  Name:     System.Contact.OtherAddressState -- PKEY_Contact_OtherAddressState
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {71B377D6-E570-425F-A170-809FAE73E54E}, 100
  PKEY_Contact_OtherAddressState : TPropertyKey = (
    fmtid : '{71B377D6-E570-425F-A170-809FAE73E54E}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_OtherAddressState}

//  Name:     System.Contact.OtherAddressStreet -- PKEY_Contact_OtherAddressStreet
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {FF962609-B7D6-4999-862D-95180D529AEA}, 100
  PKEY_Contact_OtherAddressStreet : TPropertyKey = (
    fmtid : '{FF962609-B7D6-4999-862D-95180D529AEA}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_OtherAddressStreet}

//  Name:     System.Contact.PagerTelephone -- PKEY_Contact_PagerTelephone
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {D6304E01-F8F5-4F45-8B15-D024A6296789}, 100
  PKEY_Contact_PagerTelephone : TPropertyKey = (
    fmtid : '{D6304E01-F8F5-4F45-8B15-D024A6296789}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_PagerTelephone}

//  Name:     System.Contact.PersonalTitle -- PKEY_Contact_PersonalTitle
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 69
  PKEY_Contact_PersonalTitle : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 69);
  {$EXTERNALSYM PKEY_Contact_PersonalTitle}

//  Name:     System.Contact.PrimaryAddressCity -- PKEY_Contact_PrimaryAddressCity
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C8EA94F0-A9E3-4969-A94B-9C62A95324E0}, 100
  PKEY_Contact_PrimaryAddressCity : TPropertyKey = (
    fmtid : '{C8EA94F0-A9E3-4969-A94B-9C62A95324E0}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_PrimaryAddressCity}

//  Name:     System.Contact.PrimaryAddressCountry -- PKEY_Contact_PrimaryAddressCountry
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E53D799D-0F3F-466E-B2FF-74634A3CB7A4}, 100
  PKEY_Contact_PrimaryAddressCountry : TPropertyKey = (
    fmtid : '{E53D799D-0F3F-466E-B2FF-74634A3CB7A4}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_PrimaryAddressCountry}

//  Name:     System.Contact.PrimaryAddressPostalCode -- PKEY_Contact_PrimaryAddressPostalCode
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {18BBD425-ECFD-46EF-B612-7B4A6034EDA0}, 100
  PKEY_Contact_PrimaryAddressPostalCode : TPropertyKey = (
    fmtid : '{18BBD425-ECFD-46EF-B612-7B4A6034EDA0}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_PrimaryAddressPostalCode}

//  Name:     System.Contact.PrimaryAddressPostOfficeBox -- PKEY_Contact_PrimaryAddressPostOfficeBox
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {DE5EF3C7-46E1-484E-9999-62C5308394C1}, 100
  PKEY_Contact_PrimaryAddressPostOfficeBox : TPropertyKey = (
    fmtid : '{DE5EF3C7-46E1-484E-9999-62C5308394C1}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_PrimaryAddressPostOfficeBox}

//  Name:     System.Contact.PrimaryAddressState -- PKEY_Contact_PrimaryAddressState
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {F1176DFE-7138-4640-8B4C-AE375DC70A6D}, 100
  PKEY_Contact_PrimaryAddressState : TPropertyKey = (
    fmtid : '{F1176DFE-7138-4640-8B4C-AE375DC70A6D}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_PrimaryAddressState}

//  Name:     System.Contact.PrimaryAddressStreet -- PKEY_Contact_PrimaryAddressStreet
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {63C25B20-96BE-488F-8788-C09C407AD812}, 100
  PKEY_Contact_PrimaryAddressStreet : TPropertyKey = (
    fmtid : '{63C25B20-96BE-488F-8788-C09C407AD812}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_PrimaryAddressStreet}

//  Name:     System.Contact.PrimaryEmailAddress -- PKEY_Contact_PrimaryEmailAddress
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 48
  PKEY_Contact_PrimaryEmailAddress : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 48);
  {$EXTERNALSYM PKEY_Contact_PrimaryEmailAddress}

//  Name:     System.Contact.PrimaryTelephone -- PKEY_Contact_PrimaryTelephone
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 25
  PKEY_Contact_PrimaryTelephone : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 25);
  {$EXTERNALSYM PKEY_Contact_PrimaryTelephone}

//  Name:     System.Contact.Profession -- PKEY_Contact_Profession
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {7268AF55-1CE4-4F6E-A41F-B6E4EF10E4A9}, 100
  PKEY_Contact_Profession : TPropertyKey = (
    fmtid : '{7268AF55-1CE4-4F6E-A41F-B6E4EF10E4A9}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_Profession}

//  Name:     System.Contact.SpouseName -- PKEY_Contact_SpouseName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {9D2408B6-3167-422B-82B0-F583B7A7CFE3}, 100
  PKEY_Contact_SpouseName : TPropertyKey = (
    fmtid : '{9D2408B6-3167-422B-82B0-F583B7A7CFE3}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_SpouseName}

//  Name:     System.Contact.Suffix -- PKEY_Contact_Suffix
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {176DC63C-2688-4E89-8143-A347800F25E9}, 73
  PKEY_Contact_Suffix : TPropertyKey = (
    fmtid : '{176DC63C-2688-4E89-8143-A347800F25E9}'; pid : 73);
  {$EXTERNALSYM PKEY_Contact_Suffix}

//  Name:     System.Contact.TelexNumber -- PKEY_Contact_TelexNumber
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C554493C-C1F7-40C1-A76C-EF8C0614003E}, 100
  PKEY_Contact_TelexNumber : TPropertyKey = (
    fmtid : '{C554493C-C1F7-40C1-A76C-EF8C0614003E}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_TelexNumber}

//  Name:     System.Contact.TTYTDDTelephone -- PKEY_Contact_TTYTDDTelephone
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {AAF16BAC-2B55-45E6-9F6D-415EB94910DF}, 100
  PKEY_Contact_TTYTDDTelephone : TPropertyKey = (
    fmtid : '{AAF16BAC-2B55-45E6-9F6D-415EB94910DF}'; pid : 100);
  {$EXTERNALSYM PKEY_Contact_TTYTDDTelephone}

//  Name:     System.Contact.WebPage -- PKEY_Contact_WebPage
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 18
  PKEY_Contact_WebPage : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 18);
  {$EXTERNALSYM PKEY_Contact_WebPage}
 
//-----------------------------------------------------------------------------
// Core properties



//  Name:     System.AcquisitionID -- PKEY_AcquisitionID
//  Type:     Int32 -- VT_I4
//  FormatID: {65A98875-3C80-40AB-ABBC-EFDAF77DBEE2}, 100
//
//  Hash to determine acquisition session.
  PKEY_AcquisitionID : TPropertyKey = (
    fmtid : '{65A98875-3C80-40AB-ABBC-EFDAF77DBEE2}'; pid : 100);
  {$EXTERNALSYM PKEY_AcquisitionID}

//  Name:     System.ApplicationName -- PKEY_ApplicationName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)  Legacy code may treat this as VT_LPSTR.
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 18 (PIDSI_APPNAME)
//
//  
  PKEY_ApplicationName : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 18);
  {$EXTERNALSYM PKEY_ApplicationName}

//  Name:     System.Author -- PKEY_Author
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)  Legacy code may treat this as VT_LPSTR.
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 4 (PIDSI_AUTHOR)
//
//  
  PKEY_Author : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 4);
  {$EXTERNALSYM PKEY_Author}

//  Name:     System.Capacity -- PKEY_Capacity
//  Type:     UInt64 -- VT_UI8
//  FormatID: (FMTID_Volume) {9B174B35-40FF-11D2-A27E-00C04FC30871}, 3 (PID_VOLUME_CAPACITY)  (Filesystem Volume Properties)
//
//  The amount of total space in bytes.
  PKEY_Capacity : TPropertyKey = (
    fmtid : '{9B174B35-40FF-11D2-A27E-00C04FC30871}'; pid : 3);
  {$EXTERNALSYM PKEY_Capacity}

//  Name:     System.Category -- PKEY_Category
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 2 (PIDDSI_CATEGORY)
//
//  Legacy code treats this as VT_LPSTR.
  PKEY_Category : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 2);
  {$EXTERNALSYM PKEY_Category}

//  Name:     System.Comment -- PKEY_Comment
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)  Legacy code may treat this as VT_LPSTR.
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 6 (PIDSI_COMMENTS)
//
//  Comments.
  PKEY_Comment : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 6);
  {$EXTERNALSYM PKEY_Comment}

//  Name:     System.Company -- PKEY_Company
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 15 (PIDDSI_COMPANY)
//
//  The company or publisher.
  PKEY_Company : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 15);
  {$EXTERNALSYM PKEY_Company}

//  Name:     System.ComputerName -- PKEY_ComputerName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 5 (PID_COMPUTERNAME)
//
//  
  PKEY_ComputerName : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 5);
  {$EXTERNALSYM PKEY_ComputerName}

//  Name:     System.ContainedItems -- PKEY_ContainedItems
//  Type:     Multivalue Guid -- VT_VECTOR | VT_CLSID  (For variants: VT_ARRAY | VT_CLSID)
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 29
//  
//  The list of type of items, this item contains. For example, this item contains urls, attachments etc.
//  This is represented as a vector array of GUIDs where each GUID represents certain type.
  PKEY_ContainedItems : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 29);
  {$EXTERNALSYM PKEY_ContainedItems}

//  Name:     System.ContentStatus -- PKEY_ContentStatus
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 27
  PKEY_ContentStatus : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 27);
  {$EXTERNALSYM PKEY_ContentStatus}

//  Name:     System.ContentType -- PKEY_ContentType
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 26
  PKEY_ContentType : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 26);
  {$EXTERNALSYM PKEY_ContentType}

//  Name:     System.Copyright -- PKEY_Copyright
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 11 (PIDMSI_COPYRIGHT)
//
//  
  PKEY_Copyright : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 11);
  {$EXTERNALSYM PKEY_Copyright}

//  Name:     System.DateAccessed -- PKEY_DateAccessed
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: (FMTID_Storage) {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 16 (PID_STG_ACCESSTIME)
//
//  The time of the last access to the item.  The Indexing Service friendly name is 'access'.
  PKEY_DateAccessed : TPropertyKey = (
    fmtid : '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid : 16);
  {$EXTERNALSYM PKEY_DateAccessed}

//  Name:     System.DateAcquired -- PKEY_DateAcquired
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {2CBAA8F5-D81F-47CA-B17A-F8D822300131}, 100
//  
//  The time the file entered the system via acquisition.  This is not the same as System.DateImported.
//  Examples are when pictures are acquired from a camera, or when music is purchased online.
  PKEY_DateAcquired : TPropertyKey = (
    fmtid : '{2CBAA8F5-D81F-47CA-B17A-F8D822300131}'; pid : 100);
  {$EXTERNALSYM PKEY_DateAcquired}

//  Name:     System.DateArchived -- PKEY_DateArchived
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {43F8D7B7-A444-4F87-9383-52271C9B915C}, 100
  PKEY_DateArchived : TPropertyKey = (
    fmtid : '{43F8D7B7-A444-4F87-9383-52271C9B915C}'; pid : 100);
  {$EXTERNALSYM PKEY_DateArchived}

//  Name:     System.DateCompleted -- PKEY_DateCompleted
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {72FAB781-ACDA-43E5-B155-B2434F85E678}, 100
  PKEY_DateCompleted : TPropertyKey = (
    fmtid : '{72FAB781-ACDA-43E5-B155-B2434F85E678}'; pid : 100);
  {$EXTERNALSYM PKEY_DateCompleted}

//  Name:     System.DateCreated -- PKEY_DateCreated
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: (FMTID_Storage) {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 15 (PID_STG_CREATETIME)
//
//  The date and time the item was created. The Indexing Service friendly name is 'create'.
  PKEY_DateCreated : TPropertyKey = (
    fmtid : '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid : 15);
  {$EXTERNALSYM PKEY_DateCreated}

//  Name:     System.DateImported -- PKEY_DateImported
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 18258
//
//  The time the file is imported into a separate database.  This is not the same as System.DateAcquired.  (Eg, 2003:05:22 13:55:04)
  PKEY_DateImported : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 18258);
  {$EXTERNALSYM PKEY_DateImported}

//  Name:     System.DateModified -- PKEY_DateModified
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: (FMTID_Storage) {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 14 (PID_STG_WRITETIME)
//
//  The date and time of the last write to the item. The Indexing Service friendly name is 'write'.
  PKEY_DateModified : TPropertyKey = (
    fmtid : '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid : 14);
  {$EXTERNALSYM PKEY_DateModified}

//  Name:     System.DueDate -- PKEY_DueDate
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {3F8472B5-E0AF-4DB2-8071-C53FE76AE7CE}, 100
  PKEY_DueDate : TPropertyKey = (
    fmtid : '{3F8472B5-E0AF-4DB2-8071-C53FE76AE7CE}'; pid : 100);
  {$EXTERNALSYM PKEY_DueDate}

//  Name:     System.EndDate -- PKEY_EndDate
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {C75FAA05-96FD-49E7-9CB4-9F601082D553}, 100
  PKEY_EndDate : TPropertyKey = (
    fmtid : '{C75FAA05-96FD-49E7-9CB4-9F601082D553}'; pid : 100);
  {$EXTERNALSYM PKEY_EndDate}

//  Name:     System.FileAllocationSize -- PKEY_FileAllocationSize
//  Type:     UInt64 -- VT_UI8
//  FormatID: (FMTID_Storage) {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 18 (PID_STG_ALLOCSIZE)
//
//  
  PKEY_FileAllocationSize : TPropertyKey = (
    fmtid : '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid : 18);
  {$EXTERNALSYM PKEY_FileAllocationSize}

//  Name:     System.FileAttributes -- PKEY_FileAttributes
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_Storage) {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 13 (PID_STG_ATTRIBUTES)
//  
//  This is the WIN32_FIND_DATA dwFileAttributes for the file-based item.
  PKEY_FileAttributes : TPropertyKey = (
    fmtid : '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid : 13);
  {$EXTERNALSYM PKEY_FileAttributes}

//  Name:     System.FileCount -- PKEY_FileCount
//  Type:     UInt64 -- VT_UI8
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 12
//
//  
  PKEY_FileCount : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 12);
  {$EXTERNALSYM PKEY_FileCount}

//  Name:     System.FileDescription -- PKEY_FileDescription
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSFMTID_VERSION) {0CEF7D53-FA64-11D1-A203-0000F81FEDEE}, 3 (PIDVSI_FileDescription)
//  
//  This is a user-friendly description of the file.
  PKEY_FileDescription : TPropertyKey = (
    fmtid : '{0CEF7D53-FA64-11D1-A203-0000F81FEDEE}'; pid : 3);
  {$EXTERNALSYM PKEY_FileDescription}

//  Name:     System.FileExtension -- PKEY_FileExtension
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E4F10A3C-49E6-405D-8288-A23BD4EEAA6C}, 100
//  
//  This is the file extension of the file based item, including the leading period.  
//  
//  If System.FileName is VT_EMPTY, then this property should be too.  Otherwise, it should be derived
//  appropriately by the data source from System.FileName.  If System.FileName does not have a file 
//  extension, this value should be VT_EMPTY.
//  
//  To obtain the type of any item (including an item that is not a file), use System.ItemType.
//  
//  Example values:
//  
//      If the path is...                     The property value is...
//      -----------------                     ------------------------
//      "c:\foo\bar\hello.txt"                ".txt"
//      "\\server\share\mydir\goodnews.doc"   ".doc"
//      "\\server\share\numbers.xls"          ".xls"
//      "\\server\share\folder"               VT_EMPTY
//      "c:\foo\MyFolder"                     VT_EMPTY
//      [desktop]                             VT_EMPTY
  PKEY_FileExtension : TPropertyKey = (
    fmtid : '{E4F10A3C-49E6-405D-8288-A23BD4EEAA6C}'; pid : 100);
  {$EXTERNALSYM PKEY_FileExtension}

//  Name:     System.FileFRN -- PKEY_FileFRN
//  Type:     UInt64 -- VT_UI8
//  FormatID: (FMTID_Storage) {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 21 (PID_STG_FRN)
//  
//  This is the unique file ID, also known as the File Reference Number. For a given file, this is the same value
//  as is found in the structure variable FILE_ID_BOTH_DIR_INFO.FileId, via GetFileInformationByHandleEx().
  PKEY_FileFRN : TPropertyKey = (
    fmtid : '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid : 21);
  {$EXTERNALSYM PKEY_FileFRN}

//  Name:     System.FileName -- PKEY_FileName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {41CF5AE0-F75A-4806-BD87-59C7D9248EB9}, 100
//  
//  This is the file name (including extension) of the file.
//  
//  It is possible that the item might not exist on a filesystem (ie, it may not be opened 
//  using CreateFile).  Nonetheless, if the item is represented as a file from the logical sense 
//  (and its name follows standard Win32 file-naming syntax), then the data source should emit this property.
//  
//  If an item is not a file, then the value for this property is VT_EMPTY.  See 
//  System.ItemNameDisplay.
//  
//  This has the same value as System.ParsingName for items that are provided by the Shell's file folder.
//  
//  Example values:
//  
//      If the path is...                     The property value is...
//      -----------------                     ------------------------
//      "c:\foo\bar\hello.txt"                "hello.txt"
//      "\\server\share\mydir\goodnews.doc"   "goodnews.doc"
//      "\\server\share\numbers.xls"          "numbers.xls"
//      "c:\foo\MyFolder"                     "MyFolder"
//      (email message)                       VT_EMPTY
//      (song on portable device)             "song.wma"
  PKEY_FileName : TPropertyKey = (
    fmtid : '{41CF5AE0-F75A-4806-BD87-59C7D9248EB9}'; pid : 100);
  {$EXTERNALSYM PKEY_FileName}

//  Name:     System.FileOwner -- PKEY_FileOwner
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_Misc) {9B174B34-40FF-11D2-A27E-00C04FC30871}, 4 (PID_MISC_OWNER)
//  
//  This is the owner of the file, according to the file system.
  PKEY_FileOwner : TPropertyKey = (
    fmtid : '{9B174B34-40FF-11D2-A27E-00C04FC30871}'; pid : 4);
  {$EXTERNALSYM PKEY_FileOwner}

//  Name:     System.FileVersion -- PKEY_FileVersion
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSFMTID_VERSION) {0CEF7D53-FA64-11D1-A203-0000F81FEDEE}, 4 (PIDVSI_FileVersion)
//
//  
  PKEY_FileVersion : TPropertyKey = (
    fmtid : '{0CEF7D53-FA64-11D1-A203-0000F81FEDEE}'; pid : 4);
  {$EXTERNALSYM PKEY_FileVersion}

//  Name:     System.FindData -- PKEY_FindData
//  Type:     Buffer -- VT_VECTOR | VT_UI1  (For variants: VT_ARRAY | VT_UI1)
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 0 (PID_FINDDATA)
//
//  WIN32_FIND_DATAW in buffer of bytes.
  PKEY_FindData : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 0);
  {$EXTERNALSYM PKEY_FindData}

//  Name:     System.FlagColor -- PKEY_FlagColor
//  Type:     UInt16 -- VT_UI2
//  FormatID: {67DF94DE-0CA7-4D6F-B792-053A3E4F03CF}, 100
//
//  
  PKEY_FlagColor : TPropertyKey = (
    fmtid : '{67DF94DE-0CA7-4D6F-B792-053A3E4F03CF}'; pid : 100);
  {$EXTERNALSYM PKEY_FlagColor}

// Possible discrete values for PKEY_FlagColor are:
  FLAGCOLOR_PURPLE =                     1;
  {$EXTERNALSYM FLAGCOLOR_PURPLE}
  FLAGCOLOR_ORANGE =                     2;
  {$EXTERNALSYM FLAGCOLOR_ORANGE}
  FLAGCOLOR_GREEN =                      3;
  {$EXTERNALSYM FLAGCOLOR_GREEN}
  FLAGCOLOR_YELLOW =                     4;
  {$EXTERNALSYM FLAGCOLOR_YELLOW}
  FLAGCOLOR_BLUE =                       5;
  {$EXTERNALSYM FLAGCOLOR_BLUE}
  FLAGCOLOR_RED =                        6;
  {$EXTERNALSYM FLAGCOLOR_RED}

//  Name:     System.FlagColorText -- PKEY_FlagColorText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {45EAE747-8E2A-40AE-8CBF-CA52ABA6152A}, 100
//
//  This is the user-friendly form of System.FlagColor.  Not intended to be parsed
//  programmatically.
  PKEY_FlagColorText : TPropertyKey = (
    fmtid : '{45EAE747-8E2A-40AE-8CBF-CA52ABA6152A}'; pid : 100);
  {$EXTERNALSYM PKEY_FlagColorText}

//  Name:     System.FlagStatus -- PKEY_FlagStatus
//  Type:     Int32 -- VT_I4
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 12
//
//  Status of Flag.  Values: (0=none 1=white 2=Red).  cdoPR_FLAG_STATUS
  PKEY_FlagStatus : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 12);
  {$EXTERNALSYM PKEY_FlagStatus}

// Possible discrete values for PKEY_FlagStatus are:
  FLAGSTATUS_NOTFLAGGED =                0;
  {$EXTERNALSYM FLAGSTATUS_NOTFLAGGED}
  FLAGSTATUS_COMPLETED =                 1;
  {$EXTERNALSYM FLAGSTATUS_COMPLETED}
  FLAGSTATUS_FOLLOWUP =                  2;
  {$EXTERNALSYM FLAGSTATUS_FOLLOWUP}

//  Name:     System.FlagStatusText -- PKEY_FlagStatusText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {DC54FD2E-189D-4871-AA01-08C2F57A4ABC}, 100
//  
//  This is the user-friendly form of System.FlagStatus.  Not intended to be parsed 
//  programmatically.
  PKEY_FlagStatusText : TPropertyKey = (
    fmtid : '{DC54FD2E-189D-4871-AA01-08C2F57A4ABC}'; pid : 100);
  {$EXTERNALSYM PKEY_FlagStatusText}

//  Name:     System.FreeSpace -- PKEY_FreeSpace
//  Type:     UInt64 -- VT_UI8
//  FormatID: (FMTID_Volume) {9B174B35-40FF-11D2-A27E-00C04FC30871}, 2 (PID_VOLUME_FREE)  (Filesystem Volume Properties)
//
//  The amount of free space in bytes.
  PKEY_FreeSpace : TPropertyKey = (
    fmtid : '{9B174B35-40FF-11D2-A27E-00C04FC30871}'; pid : 2);
  {$EXTERNALSYM PKEY_FreeSpace}

//  Name:     System.FullText -- PKEY_FullText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {1E3EE840-BC2B-476C-8237-2ACD1A839B22}, 6
//  
//  This PKEY is used to specify search terms that should be applied as broadly as possible,
//  across all valid properties for the data source(s) being searched.  It should not be
//  emitted from a data source.
  PKEY_FullText : TPropertyKey = (
    fmtid : '{1E3EE840-BC2B-476C-8237-2ACD1A839B22}'; pid : 6);
  {$EXTERNALSYM PKEY_FullText}

//  Name:     System.Identity -- PKEY_Identity
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {A26F4AFC-7346-4299-BE47-EB1AE613139F}, 100
  PKEY_Identity : TPropertyKey = (
    fmtid : '{A26F4AFC-7346-4299-BE47-EB1AE613139F}'; pid : 100);
  {$EXTERNALSYM PKEY_Identity}

//  Name:     System.Identity.Blob -- PKEY_Identity_Blob
//  Type:     Blob -- VT_BLOB
//  FormatID: {8C3B93A4-BAED-1A83-9A32-102EE313F6EB}, 100
//
//  Blob used to import/export identities
  PKEY_Identity_Blob : TPropertyKey = (
    fmtid : '{8C3B93A4-BAED-1A83-9A32-102EE313F6EB}'; pid : 100);
  {$EXTERNALSYM PKEY_Identity_Blob}

//  Name:     System.Identity.DisplayName -- PKEY_Identity_DisplayName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {7D683FC9-D155-45A8-BB1F-89D19BCB792F}, 100
//
//  Display Name
  PKEY_Identity_DisplayName : TPropertyKey = (
    fmtid : '{7D683FC9-D155-45A8-BB1F-89D19BCB792F}'; pid : 100);
  {$EXTERNALSYM PKEY_Identity_DisplayName}

//  Name:     System.Identity.IsMeIdentity -- PKEY_Identity_IsMeIdentity
//  Type:     Boolean -- VT_BOOL
//  FormatID: {A4108708-09DF-4377-9DFC-6D99986D5A67}, 100
//
//  Is it Me Identity
  PKEY_Identity_IsMeIdentity : TPropertyKey = (
    fmtid : '{A4108708-09DF-4377-9DFC-6D99986D5A67}'; pid : 100);
  {$EXTERNALSYM PKEY_Identity_IsMeIdentity}

//  Name:     System.Identity.PrimaryEmailAddress -- PKEY_Identity_PrimaryEmailAddress
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {FCC16823-BAED-4F24-9B32-A0982117F7FA}, 100
//
//  Primary Email Address
  PKEY_Identity_PrimaryEmailAddress : TPropertyKey = (
    fmtid : '{FCC16823-BAED-4F24-9B32-A0982117F7FA}'; pid : 100);
  {$EXTERNALSYM PKEY_Identity_PrimaryEmailAddress}

//  Name:     System.Identity.ProviderID -- PKEY_Identity_ProviderID
//  Type:     Guid -- VT_CLSID
//  FormatID: {74A7DE49-FA11-4D3D-A006-DB7E08675916}, 100
//
//  Provider ID
  PKEY_Identity_ProviderID : TPropertyKey = (
    fmtid : '{74A7DE49-FA11-4D3D-A006-DB7E08675916}'; pid : 100);
  {$EXTERNALSYM PKEY_Identity_ProviderID}

//  Name:     System.Identity.UniqueID -- PKEY_Identity_UniqueID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E55FC3B0-2B60-4220-918E-B21E8BF16016}, 100
//
//  Unique ID
  PKEY_Identity_UniqueID : TPropertyKey = (
    fmtid : '{E55FC3B0-2B60-4220-918E-B21E8BF16016}'; pid : 100);
  {$EXTERNALSYM PKEY_Identity_UniqueID}

//  Name:     System.Identity.UserName -- PKEY_Identity_UserName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C4322503-78CA-49C6-9ACC-A68E2AFD7B6B}, 100
//
//  Identity User Name
  PKEY_Identity_UserName : TPropertyKey = (
    fmtid : '{C4322503-78CA-49C6-9ACC-A68E2AFD7B6B}'; pid : 100);
  {$EXTERNALSYM PKEY_Identity_UserName}

//  Name:     System.IdentityProvider.Name -- PKEY_IdentityProvider_Name
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {B96EFF7B-35CA-4A35-8607-29E3A54C46EA}, 100
//
//  Identity Provider Name
  PKEY_IdentityProvider_Name : TPropertyKey = (
    fmtid : '{B96EFF7B-35CA-4A35-8607-29E3A54C46EA}'; pid : 100);
  {$EXTERNALSYM PKEY_IdentityProvider_Name}

//  Name:     System.IdentityProvider.Picture -- PKEY_IdentityProvider_Picture
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {2425166F-5642-4864-992F-98FD98F294C3}, 100
//
//  Picture for the Identity Provider
  PKEY_IdentityProvider_Picture : TPropertyKey = (
    fmtid : '{2425166F-5642-4864-992F-98FD98F294C3}'; pid : 100);
  {$EXTERNALSYM PKEY_IdentityProvider_Picture}

//  Name:     System.ImageParsingName -- PKEY_ImageParsingName
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {D7750EE0-C6A4-48EC-B53E-B87B52E6D073}, 100
  PKEY_ImageParsingName : TPropertyKey = (
    fmtid : '{D7750EE0-C6A4-48EC-B53E-B87B52E6D073}'; pid : 100);
  {$EXTERNALSYM PKEY_ImageParsingName}

//  Name:     System.Importance -- PKEY_Importance
//  Type:     Int32 -- VT_I4
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 11
  PKEY_Importance : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 11);
  {$EXTERNALSYM PKEY_Importance}

// Possible range of values for PKEY_Importance are:
  IMPORTANCE_LOW_MIN =                   0;
  {$EXTERNALSYM IMPORTANCE_LOW_MIN}
  IMPORTANCE_LOW_SET =                   1;
  {$EXTERNALSYM IMPORTANCE_LOW_SET}
  IMPORTANCE_LOW_MAX =                   1;
  {$EXTERNALSYM IMPORTANCE_LOW_MAX}

  IMPORTANCE_NORMAL_MIN =                2;
  {$EXTERNALSYM IMPORTANCE_NORMAL_MIN}
  IMPORTANCE_NORMAL_SET =                3;
  {$EXTERNALSYM IMPORTANCE_NORMAL_SET}
  IMPORTANCE_NORMAL_MAX =                4;
  {$EXTERNALSYM IMPORTANCE_NORMAL_MAX}

  IMPORTANCE_HIGH_MIN =                  5;
  {$EXTERNALSYM IMPORTANCE_HIGH_MIN}
  IMPORTANCE_HIGH_SET =                  5;
  {$EXTERNALSYM IMPORTANCE_HIGH_SET}
  IMPORTANCE_HIGH_MAX =                  5;
  {$EXTERNALSYM IMPORTANCE_HIGH_MAX}


//  Name:     System.ImportanceText -- PKEY_ImportanceText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {A3B29791-7713-4E1D-BB40-17DB85F01831}, 100
//  
//  This is the user-friendly form of System.Importance.  Not intended to be parsed 
//  programmatically.
  PKEY_ImportanceText : TPropertyKey = (
    fmtid : '{A3B29791-7713-4E1D-BB40-17DB85F01831}'; pid : 100);
  {$EXTERNALSYM PKEY_ImportanceText}

//  Name:     System.IsAttachment -- PKEY_IsAttachment
//  Type:     Boolean -- VT_BOOL
//  FormatID: {F23F425C-71A1-4FA8-922F-678EA4A60408}, 100
//
//  Identifies if this item is an attachment.
  PKEY_IsAttachment : TPropertyKey = (
    fmtid : '{F23F425C-71A1-4FA8-922F-678EA4A60408}'; pid : 100);
  {$EXTERNALSYM PKEY_IsAttachment}

//  Name:     System.IsDefaultNonOwnerSaveLocation -- PKEY_IsDefaultNonOwnerSaveLocation
//  Type:     Boolean -- VT_BOOL
//  FormatID: {5D76B67F-9B3D-44BB-B6AE-25DA4F638A67}, 5
//
//  Identifies the default save location for a library for non-owners of the library
  PKEY_IsDefaultNonOwnerSaveLocation : TPropertyKey = (
    fmtid : '{5D76B67F-9B3D-44BB-B6AE-25DA4F638A67}'; pid : 5);
  {$EXTERNALSYM PKEY_IsDefaultNonOwnerSaveLocation}

//  Name:     System.IsDefaultSaveLocation -- PKEY_IsDefaultSaveLocation
//  Type:     Boolean -- VT_BOOL
//  FormatID: {5D76B67F-9B3D-44BB-B6AE-25DA4F638A67}, 3
//
//  Identifies the default save location for a library for the owner of the library
  PKEY_IsDefaultSaveLocation : TPropertyKey = (
    fmtid : '{5D76B67F-9B3D-44BB-B6AE-25DA4F638A67}'; pid : 3);
  {$EXTERNALSYM PKEY_IsDefaultSaveLocation}

//  Name:     System.IsDeleted -- PKEY_IsDeleted
//  Type:     Boolean -- VT_BOOL
//  FormatID: {5CDA5FC8-33EE-4FF3-9094-AE7BD8868C4D}, 100
  PKEY_IsDeleted : TPropertyKey = (
    fmtid : '{5CDA5FC8-33EE-4FF3-9094-AE7BD8868C4D}'; pid : 100);
  {$EXTERNALSYM PKEY_IsDeleted}

//  Name:     System.IsEncrypted -- PKEY_IsEncrypted
//  Type:     Boolean -- VT_BOOL
//  FormatID: {90E5E14E-648B-4826-B2AA-ACAF790E3513}, 10
//
//  Is the item encrypted?
  PKEY_IsEncrypted : TPropertyKey = (
    fmtid : '{90E5E14E-648B-4826-B2AA-ACAF790E3513}'; pid : 10);
  {$EXTERNALSYM PKEY_IsEncrypted}

//  Name:     System.IsFlagged -- PKEY_IsFlagged
//  Type:     Boolean -- VT_BOOL
//  FormatID: {5DA84765-E3FF-4278-86B0-A27967FBDD03}, 100
  PKEY_IsFlagged : TPropertyKey = (
    fmtid : '{5DA84765-E3FF-4278-86B0-A27967FBDD03}'; pid : 100);
  {$EXTERNALSYM PKEY_IsFlagged}

//  Name:     System.IsFlaggedComplete -- PKEY_IsFlaggedComplete
//  Type:     Boolean -- VT_BOOL
//  FormatID: {A6F360D2-55F9-48DE-B909-620E090A647C}, 100
  PKEY_IsFlaggedComplete : TPropertyKey = (
    fmtid : '{A6F360D2-55F9-48DE-B909-620E090A647C}'; pid : 100);
  {$EXTERNALSYM PKEY_IsFlaggedComplete}

//  Name:     System.IsIncomplete -- PKEY_IsIncomplete
//  Type:     Boolean -- VT_BOOL
//  FormatID: {346C8BD1-2E6A-4C45-89A4-61B78E8E700F}, 100
//
//  Identifies if the message was not completely received for some error condition.
  PKEY_IsIncomplete : TPropertyKey = (
    fmtid : '{346C8BD1-2E6A-4C45-89A4-61B78E8E700F}'; pid : 100);
  {$EXTERNALSYM PKEY_IsIncomplete}

//  Name:     System.IsPinnedToNameSpaceTree -- PKEY_IsPinnedToNameSpaceTree
//  Type:     Boolean -- VT_BOOL
//  FormatID: {5D76B67F-9B3D-44BB-B6AE-25DA4F638A67}, 2
//
//  A bool value to know if a shell folder is pinned to the navigation pane
  PKEY_IsPinnedToNameSpaceTree : TPropertyKey = (
    fmtid : '{5D76B67F-9B3D-44BB-B6AE-25DA4F638A67}'; pid : 2);
  {$EXTERNALSYM PKEY_IsPinnedToNameSpaceTree}

//  Name:     System.IsRead -- PKEY_IsRead
//  Type:     Boolean -- VT_BOOL
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 10
//
//  Has the item been read?
  PKEY_IsRead : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 10);
  {$EXTERNALSYM PKEY_IsRead}

//  Name:     System.IsSearchOnlyItem -- PKEY_IsSearchOnlyItem
//  Type:     Boolean -- VT_BOOL
//  FormatID: {5D76B67F-9B3D-44BB-B6AE-25DA4F638A67}, 4
//
//  Identifies if a location or a library is search only
  PKEY_IsSearchOnlyItem : TPropertyKey = (
    fmtid : '{5D76B67F-9B3D-44BB-B6AE-25DA4F638A67}'; pid : 4);
  {$EXTERNALSYM PKEY_IsSearchOnlyItem}

//  Name:     System.IsSendToTarget -- PKEY_IsSendToTarget
//  Type:     Boolean -- VT_BOOL
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 33
//
//  Provided by certain shell folders. Return TRUE if the folder is a valid Send To target.
  PKEY_IsSendToTarget : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 33);
  {$EXTERNALSYM PKEY_IsSendToTarget}

//  Name:     System.IsShared -- PKEY_IsShared
//  Type:     Boolean -- VT_BOOL
//  FormatID: {EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902}, 100
//
//  Is this item shared?  This only checks for ACLs that are not inherited.
  PKEY_IsShared : TPropertyKey = (
    fmtid : '{EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902}'; pid : 100);
  {$EXTERNALSYM PKEY_IsShared}

//  Name:     System.ItemAuthors -- PKEY_ItemAuthors
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {D0A04F0A-462A-48A4-BB2F-3706E88DBD7D}, 100
//  
//  This is the generic list of authors associated with an item. 
//  
//  For example, the artist name for a track is the item author.
  PKEY_ItemAuthors : TPropertyKey = (
    fmtid : '{D0A04F0A-462A-48A4-BB2F-3706E88DBD7D}'; pid : 100);
  {$EXTERNALSYM PKEY_ItemAuthors}

//  Name:     System.ItemClassType -- PKEY_ItemClassType
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {048658AD-2DB8-41A4-BBB6-AC1EF1207EB1}, 100
  PKEY_ItemClassType : TPropertyKey = (
    fmtid : '{048658AD-2DB8-41A4-BBB6-AC1EF1207EB1}'; pid : 100);
  {$EXTERNALSYM PKEY_ItemClassType}

//  Name:     System.ItemDate -- PKEY_ItemDate
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {F7DB74B4-4287-4103-AFBA-F1B13DCD75CF}, 100
//  
//  This is the main date for an item. The date of interest. 
//  
//  For example, for photos this maps to System.Photo.DateTaken.
  PKEY_ItemDate : TPropertyKey = (
    fmtid : '{F7DB74B4-4287-4103-AFBA-F1B13DCD75CF}'; pid : 100);
  {$EXTERNALSYM PKEY_ItemDate}

//  Name:     System.ItemFolderNameDisplay -- PKEY_ItemFolderNameDisplay
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_Storage) {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 2 (PID_STG_DIRECTORY)
//  
//  This is the user-friendly display name of the parent folder of an item.
//  
//  If System.ItemFolderPathDisplay is VT_EMPTY, then this property should be too.  Otherwise, it 
//  should be derived appropriately by the data source from System.ItemFolderPathDisplay.
//  
//  Example values:
//  
//      If the path is...                     The property value is...
//      -----------------                     ------------------------
//      "c:\foo\bar\hello.txt"                "bar"
//      "\\server\share\mydir\goodnews.doc"   "mydir"
//      "\\server\share\numbers.xls"          "share"
//      "c:\foo\MyFolder"                     "foo"
//      "/Mailbox Account/Inbox/'Re: Hello!'" "Inbox"
  PKEY_ItemFolderNameDisplay : TPropertyKey = (
    fmtid : '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid : 2);
  {$EXTERNALSYM PKEY_ItemFolderNameDisplay}

//  Name:     System.ItemFolderPathDisplay -- PKEY_ItemFolderPathDisplay
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 6
//  
//  This is the user-friendly display path of the parent folder of an item.
//  
//  If System.ItemPathDisplay is VT_EMPTY, then this property should be too.  Otherwise, it should 
//  be derived appropriately by the data source from System.ItemPathDisplay.
//  
//  Example values:
//  
//      If the path is...                     The property value is...
//      -----------------                     ------------------------
//      "c:\foo\bar\hello.txt"                "c:\foo\bar"
//      "\\server\share\mydir\goodnews.doc"   "\\server\share\mydir"
//      "\\server\share\numbers.xls"          "\\server\share"
//      "c:\foo\MyFolder"                     "c:\foo"
//      "/Mailbox Account/Inbox/'Re: Hello!'" "/Mailbox Account/Inbox"
  PKEY_ItemFolderPathDisplay : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 6);
  {$EXTERNALSYM PKEY_ItemFolderPathDisplay}

//  Name:     System.ItemFolderPathDisplayNarrow -- PKEY_ItemFolderPathDisplayNarrow
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {DABD30ED-0043-4789-A7F8-D013A4736622}, 100
//  
//  This is the user-friendly display path of the parent folder of an item.  The format of the string
//  should be tailored such that the folder name comes first, to optimize for a narrow viewing column.
//  
//  If the folder is a file folder, the value includes localized names if they are present.
//  
//  If System.ItemFolderPathDisplay is VT_EMPTY, then this property should be too.  Otherwise, it should
//  be derived appropriately by the data source from System.ItemFolderPathDisplay.
//  
//  Example values:
//  
//      If the path is...                     The property value is...
//      -----------------                     ------------------------
//      "c:\foo\bar\hello.txt"                "bar (c:\foo)"
//      "\\server\share\mydir\goodnews.doc"   "mydir (\\server\share)"
//      "\\server\share\numbers.xls"          "share (\\server)"
//      "c:\foo\MyFolder"                     "foo (c:\)"
//      "/Mailbox Account/Inbox/'Re: Hello!'" "Inbox (/Mailbox Account)"
  PKEY_ItemFolderPathDisplayNarrow : TPropertyKey = (
    fmtid : '{DABD30ED-0043-4789-A7F8-D013A4736622}'; pid : 100);
  {$EXTERNALSYM PKEY_ItemFolderPathDisplayNarrow}

//  Name:     System.ItemName -- PKEY_ItemName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {6B8DA074-3B5C-43BC-886F-0A2CDCE00B6F}, 100
//  
//  This is the base-name of the System.ItemNameDisplay.
//  
//  If the item is a file this property
//  includes the extension in all cases, and will be localized if a localized name is available.
//  
//  If the item is a message, then the value of this property does not include the forwarding or
//  reply prefixes (see System.ItemNamePrefix).
  PKEY_ItemName : TPropertyKey = (
    fmtid : '{6B8DA074-3B5C-43BC-886F-0A2CDCE00B6F}'; pid : 100);
  {$EXTERNALSYM PKEY_ItemName}

//  Name:     System.ItemNameDisplay -- PKEY_ItemNameDisplay
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_Storage) {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 10 (PID_STG_NAME)
//  
//  This is the display name in "most complete" form.  This is the best effort unique representation
//  of the name of an item that makes sense for end users to read.  It is the concatentation of
//  System.ItemNamePrefix and System.ItemName.
//  
//  If the item is a file this property
//  includes the extension in all cases, and will be localized if a localized name is available.
//  
//  There are acceptable cases when System.FileName is not VT_EMPTY, yet the value of this property 
//  is completely different.  Email messages are a key example.  If the item is an email message, 
//  the item name is likely the subject.  In that case, the value must be the concatenation of the
//  System.ItemNamePrefix and System.ItemName.  Since the value of System.ItemNamePrefix excludes
//  any trailing whitespace, the concatenation must include a whitespace when generating System.ItemNameDisplay.
//  
//  Note that this property is not guaranteed to be unique, but the idea is to promote the most likely
//  candidate that can be unique and also makes sense for end users. For example, for documents, you
//  might think about using System.Title as the System.ItemNameDisplay, but in practice the title of
//  the documents may not be useful or unique enough to be of value as the sole System.ItemNameDisplay.  
//  Instead, providing the value of System.FileName as the value of System.ItemNameDisplay is a better
//  candidate.  In Windows Mail, the emails are stored in the file system as .eml files and the 
//  System.FileName for those files are not human-friendly as they contain GUIDs. In this example, 
//  promoting System.Subject as System.ItemNameDisplay makes more sense.
//  
//  Compatibility notes:
//  
//  Shell folder implementations on Vista: use PKEY_ItemNameDisplay for the name column when
//  you want Explorer to call ISF::GetDisplayNameOf(SHGDN_NORMAL) to get the value of the name. Use
//  another PKEY (like PKEY_ItemName) when you want Explorer to call either the folder's property store or
//  ISF2::GetDetailsEx in order to get the value of the name.
//  
//  Shell folder implementations on XP: the first column needs to be the name column, and Explorer
//  will call ISF::GetDisplayNameOf to get the value of the name.  The PKEY/SCID does not matter.
//  
//  Example values:
//  
//      File:          "hello.txt"
//      Message:       "Re: Let's talk about Tom's argyle socks!"
//      Device folder: "song.wma"
//      Folder:        "Documents"
  PKEY_ItemNameDisplay : TPropertyKey = (
    fmtid : '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid : 10);
  {$EXTERNALSYM PKEY_ItemNameDisplay}

//  Name:     System.ItemNamePrefix -- PKEY_ItemNamePrefix
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {D7313FF1-A77A-401C-8C99-3DBDD68ADD36}, 100
//  
//  This is the prefix of an item, used for email messages.
//  where the subject begins with "Re:" which is the prefix.
//  
//  If the item is a file, then the value of this property is VT_EMPTY.
//  
//  If the item is a message, then the value of this property is the forwarding or reply 
//  prefixes (including delimiting colon, but no whitespace), or VT_EMPTY if there is no prefix.
//  
//  Example values:
//  
//  System.ItemNamePrefix    System.ItemName      System.ItemNameDisplay
//  ---------------------    -------------------  ----------------------
//  VT_EMPTY                 "Great day"          "Great day"
//  "Re:"                    "Great day"          "Re: Great day"
//  "Fwd: "                  "Monthly budget"     "Fwd: Monthly budget"
//  VT_EMPTY                 "accounts.xls"       "accounts.xls"
  PKEY_ItemNamePrefix : TPropertyKey = (
    fmtid : '{D7313FF1-A77A-401C-8C99-3DBDD68ADD36}'; pid : 100);
  {$EXTERNALSYM PKEY_ItemNamePrefix}

//  Name:     System.ItemParticipants -- PKEY_ItemParticipants
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {D4D0AA16-9948-41A4-AA85-D97FF9646993}, 100
//  
//  This is the generic list of people associated with an item and who contributed 
//  to the item. 
//  
//  For example, this is the combination of people in the To list, Cc list and 
//  sender of an email message.
  PKEY_ItemParticipants : TPropertyKey = (
    fmtid : '{D4D0AA16-9948-41A4-AA85-D97FF9646993}'; pid : 100);
  {$EXTERNALSYM PKEY_ItemParticipants}

//  Name:     System.ItemPathDisplay -- PKEY_ItemPathDisplay
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 7
//  
//  This is the user-friendly display path to the item.
//  
//  If the item is a file or folder this property
//  includes the extension in all cases, and will be localized if a localized name is available.
//  
//  For other items,this is the user-friendly equivalent, assuming the item exists in hierarchical storage.
//  
//  Unlike System.ItemUrl, this property value does not include the URL scheme.
//  
//  To parse an item path, use System.ItemUrl or System.ParsingPath.  To reference shell 
//  namespace items using shell APIs, use System.ParsingPath.
//  
//  Example values:
//  
//      If the path is...                     The property value is...
//      -----------------                     ------------------------
//      "c:\foo\bar\hello.txt"                "c:\foo\bar\hello.txt"
//      "\\server\share\mydir\goodnews.doc"   "\\server\share\mydir\goodnews.doc"
//      "\\server\share\numbers.xls"          "\\server\share\numbers.xls"
//      "c:\foo\MyFolder"                     "c:\foo\MyFolder"
//      "/Mailbox Account/Inbox/'Re: Hello!'" "/Mailbox Account/Inbox/'Re: Hello!'"
  PKEY_ItemPathDisplay : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 7);
  {$EXTERNALSYM PKEY_ItemPathDisplay}

//  Name:     System.ItemPathDisplayNarrow -- PKEY_ItemPathDisplayNarrow
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 8
//  
//  This is the user-friendly display path to the item. The format of the string should be 
//  tailored such that the name comes first, to optimize for a narrow viewing column.
//  
//  If the item is a file, the value excludes the file extension, and includes localized names if they are present.
//  If the item is a message, the value includes the System.ItemNamePrefix.
//  
//  To parse an item path, use System.ItemUrl or System.ParsingPath.
//  
//  Example values:
//  
//      If the path is...                     The property value is...
//      -----------------                     ------------------------
//      "c:\foo\bar\hello.txt"                "hello (c:\foo\bar)"
//      "\\server\share\mydir\goodnews.doc"   "goodnews (\\server\share\mydir)"
//      "\\server\share\folder"               "folder (\\server\share)"
//      "c:\foo\MyFolder"                     "MyFolder (c:\foo)"
//      "/Mailbox Account/Inbox/'Re: Hello!'" "Re: Hello! (/Mailbox Account/Inbox)"
  PKEY_ItemPathDisplayNarrow : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 8);
  {$EXTERNALSYM PKEY_ItemPathDisplayNarrow}

//  Name:     System.ItemType -- PKEY_ItemType
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 11
//  
//  This is the canonical type of the item and is intended to be programmatically
//  parsed.
//  
//  If there is no canonical type, the value is VT_EMPTY.
//  
//  If the item is a file (ie, System.FileName is not VT_EMPTY), the value is the same as
//  System.FileExtension.
//  
//  Use System.ItemTypeText when you want to display the type to end users in a view.  (If
//   the item is a file, passing the System.ItemType value to PSFormatForDisplay will
//   result in the same value as System.ItemTypeText.)
//  
//  Example values:
//  
//      If the path is...                     The property value is...
//      -----------------                     ------------------------
//      "c:\foo\bar\hello.txt"                ".txt"
//      "\\server\share\mydir\goodnews.doc"   ".doc"
//      "\\server\share\folder"               "Directory"
//      "c:\foo\MyFolder"                     "Directory"
//      [desktop]                             "Folder"
//      "/Mailbox Account/Inbox/'Re: Hello!'" "MAPI/IPM.Message"
  PKEY_ItemType : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 11);
  {$EXTERNALSYM PKEY_ItemType}

//  Name:     System.ItemTypeText -- PKEY_ItemTypeText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_Storage) {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 4 (PID_STG_STORAGETYPE)
//  
//  This is the user friendly type name of the item.  This is not intended to be
//  programmatically parsed.
//  
//  If System.ItemType is VT_EMPTY, the value of this property is also VT_EMPTY.
//  
//  If the item is a file, the value of this property is the same as if you passed the 
//  file's System.ItemType value to PSFormatForDisplay.
//  
//  This property should not be confused with System.Kind, where System.Kind is a high-level
//  user friendly kind name. For example, for a document, System.Kind = "Document" and 
//  System.Item.Type = ".doc" and System.Item.TypeText = "Microsoft Word Document"
//  
//  Example values:
//  
//      If the path is...                     The property value is...
//      -----------------                     ------------------------
//      "c:\foo\bar\hello.txt"                "Text File"
//      "\\server\share\mydir\goodnews.doc"   "Microsoft Word Document"
//      "\\server\share\folder"               "File Folder"
//      "c:\foo\MyFolder"                     "File Folder"
//      "/Mailbox Account/Inbox/'Re: Hello!'" "Outlook E-Mail Message"
  PKEY_ItemTypeText : TPropertyKey = (
    fmtid : '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid : 4);
  {$EXTERNALSYM PKEY_ItemTypeText}

//  Name:     System.ItemUrl -- PKEY_ItemUrl
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_Query) {49691C90-7E17-101A-A91C-08002B2ECDA9}, 9 (DISPID_QUERY_VIRTUALPATH)
//  
//  This always represents a well formed URL that points to the item.  
//  
//  To reference shell namespace items using shell APIs, use System.ParsingPath.
//  
//  Example values:
//  
//      Files:    "file:///c:/foo/bar/hello.txt"
//                "csc://{GUID}/..."
//      Messages: "mapi://..."
  PKEY_ItemUrl : TPropertyKey = (
    fmtid : '{49691C90-7E17-101A-A91C-08002B2ECDA9}'; pid : 9);
  {$EXTERNALSYM PKEY_ItemUrl}

//  Name:     System.Keywords -- PKEY_Keywords
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)  Legacy code may treat this as VT_LPSTR.
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 5 (PIDSI_KEYWORDS)
//
//  The keywords for the item.  Also referred to as tags.
  PKEY_Keywords : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 5);
  {$EXTERNALSYM PKEY_Keywords}

//  Name:     System.Kind -- PKEY_Kind
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {1E3EE840-BC2B-476C-8237-2ACD1A839B22}, 3
//  
//  System.Kind is used to map extensions to various .Search folders.
//  Extensions are mapped to Kinds at HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\KindMap
//  The list of kinds is not extensible.
  PKEY_Kind : TPropertyKey = (
    fmtid : '{1E3EE840-BC2B-476C-8237-2ACD1A839B22}'; pid : 3);
  {$EXTERNALSYM PKEY_Kind}

// Possible discrete values for PKEY_Kind are:
  KIND_CALENDAR =                        'calendar';
  {$EXTERNALSYM KIND_CALENDAR}
  KIND_COMMUNICATION =                   'communication';
  {$EXTERNALSYM KIND_COMMUNICATION}
  KIND_CONTACT =                         'contact';
  {$EXTERNALSYM KIND_CONTACT}
  KIND_DOCUMENT =                        'document';
  {$EXTERNALSYM KIND_DOCUMENT}
  KIND_EMAIL =                           'email';
  {$EXTERNALSYM KIND_EMAIL}
  KIND_FEED =                            'feed';
  {$EXTERNALSYM KIND_FEED}
  KIND_FOLDER =                          'folder';
  {$EXTERNALSYM KIND_FOLDER}
  KIND_GAME =                            'game';
  {$EXTERNALSYM KIND_GAME}
  KIND_INSTANTMESSAGE =                  'instantmessage';
  {$EXTERNALSYM KIND_INSTANTMESSAGE}
  KIND_JOURNAL =                         'journal';
  {$EXTERNALSYM KIND_JOURNAL}
  KIND_LINK =                            'link';
  {$EXTERNALSYM KIND_LINK}
  KIND_MOVIE =                           'movie';
  {$EXTERNALSYM KIND_MOVIE}
  KIND_MUSIC =                           'music';
  {$EXTERNALSYM KIND_MUSIC}
  KIND_NOTE =                            'note';
  {$EXTERNALSYM KIND_NOTE}
  KIND_PICTURE =                         'picture';
  {$EXTERNALSYM KIND_PICTURE}
  KIND_PROGRAM =                         'program';
  {$EXTERNALSYM KIND_PROGRAM}
  KIND_RECORDEDTV =                      'recordedtv';
  {$EXTERNALSYM KIND_RECORDEDTV}
  KIND_SEARCHFOLDER =                    'searchfolder';
  {$EXTERNALSYM KIND_SEARCHFOLDER}
  KIND_TASK =                            'task';
  {$EXTERNALSYM KIND_TASK}
  KIND_VIDEO =                           'video';
  {$EXTERNALSYM KIND_VIDEO}
  KIND_WEBHISTORY =                      'webhistory';
  {$EXTERNALSYM KIND_WEBHISTORY}

//  Name:     System.KindText -- PKEY_KindText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {F04BEF95-C585-4197-A2B7-DF46FDC9EE6D}, 100
//  
//  This is the user-friendly form of System.Kind.  Not intended to be parsed 
//  programmatically.
  PKEY_KindText : TPropertyKey = (
    fmtid : '{F04BEF95-C585-4197-A2B7-DF46FDC9EE6D}'; pid : 100);
  {$EXTERNALSYM PKEY_KindText}

//  Name:     System.Language -- PKEY_Language
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 28
//
//  
  PKEY_Language : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 28);
  {$EXTERNALSYM PKEY_Language}

//  Name:     System.MileageInformation -- PKEY_MileageInformation
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {FDF84370-031A-4ADD-9E91-0D775F1C6605}, 100
  PKEY_MileageInformation : TPropertyKey = (
    fmtid : '{FDF84370-031A-4ADD-9E91-0D775F1C6605}'; pid : 100);
  {$EXTERNALSYM PKEY_MileageInformation}

//  Name:     System.MIMEType -- PKEY_MIMEType
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {0B63E350-9CCC-11D0-BCDB-00805FCCCE04}, 5
//
//  The MIME type.  Eg, for EML files: 'message/rfc822'.
  PKEY_MIMEType : TPropertyKey = (
    fmtid : '{0B63E350-9CCC-11D0-BCDB-00805FCCCE04}'; pid : 5);
  {$EXTERNALSYM PKEY_MIMEType}

//  Name:     System.Null -- PKEY_Null
//  Type:     Null -- VT_NULL
//  FormatID: {00000000-0000-0000-0000-000000000000}, 0
  PKEY_Null : TPropertyKey = (
    fmtid : '{00000000-0000-0000-0000-000000000000}'; pid : 0);
  {$EXTERNALSYM PKEY_Null}

//  Name:     System.OfflineAvailability -- PKEY_OfflineAvailability
//  Type:     UInt32 -- VT_UI4
//  FormatID: {A94688B6-7D9F-4570-A648-E3DFC0AB2B3F}, 100
  PKEY_OfflineAvailability : TPropertyKey = (
    fmtid : '{A94688B6-7D9F-4570-A648-E3DFC0AB2B3F}'; pid : 100);
  {$EXTERNALSYM PKEY_OfflineAvailability}

// Possible discrete values for PKEY_OfflineAvailability are:
  OFFLINEAVAILABILITY_NOT_AVAILABLE =    0;
  {$EXTERNALSYM OFFLINEAVAILABILITY_NOT_AVAILABLE}
  OFFLINEAVAILABILITY_AVAILABLE =        1;
  {$EXTERNALSYM OFFLINEAVAILABILITY_AVAILABLE}
  OFFLINEAVAILABILITY_ALWAYS_AVAILABLE =  2;
  {$EXTERNALSYM OFFLINEAVAILABILITY_ALWAYS_AVAILABLE}

//  Name:     System.OfflineStatus -- PKEY_OfflineStatus
//  Type:     UInt32 -- VT_UI4
//  FormatID: {6D24888F-4718-4BDA-AFED-EA0FB4386CD8}, 100
  PKEY_OfflineStatus : TPropertyKey = (
    fmtid : '{6D24888F-4718-4BDA-AFED-EA0FB4386CD8}'; pid : 100);
  {$EXTERNALSYM PKEY_OfflineStatus}

// Possible discrete values for PKEY_OfflineStatus are:
  OFFLINESTATUS_ONLINE =                 0;
  {$EXTERNALSYM OFFLINESTATUS_ONLINE}
  OFFLINESTATUS_OFFLINE =                1;
  {$EXTERNALSYM OFFLINESTATUS_OFFLINE}
  OFFLINESTATUS_OFFLINE_FORCED =         2;
  {$EXTERNALSYM OFFLINESTATUS_OFFLINE_FORCED}
  OFFLINESTATUS_OFFLINE_SLOW =           3;
  {$EXTERNALSYM OFFLINESTATUS_OFFLINE_SLOW}
  OFFLINESTATUS_OFFLINE_ERROR =          4;
  {$EXTERNALSYM OFFLINESTATUS_OFFLINE_ERROR}
  OFFLINESTATUS_OFFLINE_ITEM_VERSION_CONFLICT =  5;
  {$EXTERNALSYM OFFLINESTATUS_OFFLINE_ITEM_VERSION_CONFLICT}
  OFFLINESTATUS_OFFLINE_SUSPENDED =      6;
  {$EXTERNALSYM OFFLINESTATUS_OFFLINE_SUSPENDED}

//  Name:     System.OriginalFileName -- PKEY_OriginalFileName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSFMTID_VERSION) {0CEF7D53-FA64-11D1-A203-0000F81FEDEE}, 6
//  
//  
  PKEY_OriginalFileName : TPropertyKey = (
    fmtid : '{0CEF7D53-FA64-11D1-A203-0000F81FEDEE}'; pid : 6);
  {$EXTERNALSYM PKEY_OriginalFileName}

//  Name:     System.OwnerSID -- PKEY_OwnerSID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {5D76B67F-9B3D-44BB-B6AE-25DA4F638A67}, 6
//
//  SID of the user that owns the library.
  PKEY_OwnerSID : TPropertyKey = (
    fmtid : '{5D76B67F-9B3D-44BB-B6AE-25DA4F638A67}'; pid : 6);
  {$EXTERNALSYM PKEY_OwnerSID}

//  Name:     System.ParentalRating -- PKEY_ParentalRating
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 21 (PIDMSI_PARENTAL_RATING)
//
//  
  PKEY_ParentalRating : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 21);
  {$EXTERNALSYM PKEY_ParentalRating}

//  Name:     System.ParentalRatingReason -- PKEY_ParentalRatingReason
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {10984E0A-F9F2-4321-B7EF-BAF195AF4319}, 100
  PKEY_ParentalRatingReason : TPropertyKey = (
    fmtid : '{10984E0A-F9F2-4321-B7EF-BAF195AF4319}'; pid : 100);
  {$EXTERNALSYM PKEY_ParentalRatingReason}

//  Name:     System.ParentalRatingsOrganization -- PKEY_ParentalRatingsOrganization
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {A7FE0840-1344-46F0-8D37-52ED712A4BF9}, 100
  PKEY_ParentalRatingsOrganization : TPropertyKey = (
    fmtid : '{A7FE0840-1344-46F0-8D37-52ED712A4BF9}'; pid : 100);
  {$EXTERNALSYM PKEY_ParentalRatingsOrganization}

//  Name:     System.ParsingBindContext -- PKEY_ParsingBindContext
//  Type:     Any -- VT_NULL  Legacy code may treat this as VT_UNKNOWN.
//  FormatID: {DFB9A04D-362F-4CA3-B30B-0254B17B5B84}, 100
//  
//  used to get the IBindCtx for an item for parsing
  PKEY_ParsingBindContext : TPropertyKey = (
    fmtid : '{DFB9A04D-362F-4CA3-B30B-0254B17B5B84}'; pid : 100);
  {$EXTERNALSYM PKEY_ParsingBindContext}

//  Name:     System.ParsingName -- PKEY_ParsingName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 24
//  
//  The shell namespace name of an item relative to a parent folder.  This name may be passed to 
//  IShellFolder::ParseDisplayName() of the parent shell folder.
  PKEY_ParsingName : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 24);
  {$EXTERNALSYM PKEY_ParsingName}

//  Name:     System.ParsingPath -- PKEY_ParsingPath
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 30
//  
//  This is the shell namespace path to the item.  This path may be passed to 
//  SHParseDisplayName to parse the path to the correct shell folder.
//  
//  If the item is a file, the value is identical to System.ItemPathDisplay.
//  
//  If the item cannot be accessed through the shell namespace, this value is VT_EMPTY.
  PKEY_ParsingPath : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 30);
  {$EXTERNALSYM PKEY_ParsingPath}

//  Name:     System.PerceivedType -- PKEY_PerceivedType
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 9
//
//  The perceived type of a shell item, based upon its canonical type.
  PKEY_PerceivedType : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 9);
  {$EXTERNALSYM PKEY_PerceivedType}

// For the enumerated values of PKEY_PerceivedType, see the PERCEIVED_TYPE_* values in shtypes.idl.

//  Name:     System.PercentFull -- PKEY_PercentFull
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_Volume) {9B174B35-40FF-11D2-A27E-00C04FC30871}, 5  (Filesystem Volume Properties)
//
//  The amount filled as a percentage, multiplied by 100 (ie, the valid range is 0 through 100).
  PKEY_PercentFull : TPropertyKey = (
    fmtid : '{9B174B35-40FF-11D2-A27E-00C04FC30871}'; pid : 5);
  {$EXTERNALSYM PKEY_PercentFull}

//  Name:     System.Priority -- PKEY_Priority
//  Type:     UInt16 -- VT_UI2
//  FormatID: {9C1FCF74-2D97-41BA-B4AE-CB2E3661A6E4}, 5
//
//  
  PKEY_Priority : TPropertyKey = (
    fmtid : '{9C1FCF74-2D97-41BA-B4AE-CB2E3661A6E4}'; pid : 5);
  {$EXTERNALSYM PKEY_Priority}

// Possible discrete values for PKEY_Priority are:
  PRIORITY_PROP_LOW =                    0;
  {$EXTERNALSYM PRIORITY_PROP_LOW}
  PRIORITY_PROP_NORMAL =                 1;
  {$EXTERNALSYM PRIORITY_PROP_NORMAL}
  PRIORITY_PROP_HIGH =                   2;
  {$EXTERNALSYM PRIORITY_PROP_HIGH}

//  Name:     System.PriorityText -- PKEY_PriorityText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {D98BE98B-B86B-4095-BF52-9D23B2E0A752}, 100
//  
//  This is the user-friendly form of System.Priority.  Not intended to be parsed 
//  programmatically.
  PKEY_PriorityText : TPropertyKey = (
    fmtid : '{D98BE98B-B86B-4095-BF52-9D23B2E0A752}'; pid : 100);
  {$EXTERNALSYM PKEY_PriorityText}

//  Name:     System.Project -- PKEY_Project
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {39A7F922-477C-48DE-8BC8-B28441E342E3}, 100
  PKEY_Project : TPropertyKey = (
    fmtid : '{39A7F922-477C-48DE-8BC8-B28441E342E3}'; pid : 100);
  {$EXTERNALSYM PKEY_Project}

//  Name:     System.ProviderItemID -- PKEY_ProviderItemID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {F21D9941-81F0-471A-ADEE-4E74B49217ED}, 100
//  
//  
  PKEY_ProviderItemID : TPropertyKey = (
    fmtid : '{F21D9941-81F0-471A-ADEE-4E74B49217ED}'; pid : 100);
  {$EXTERNALSYM PKEY_ProviderItemID}

//  Name:     System.Rating -- PKEY_Rating
//  Type:     UInt32 -- VT_UI4
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 9 (PIDMSI_RATING)
//  
//  Indicates the users preference rating of an item on a scale of 0-99 (0 = unrated, 1-12 = One Star, 
//  13-37 = Two Stars, 38-62 = Three Stars, 63-87 = Four Stars, 88-99 = Five Stars).
  PKEY_Rating : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 9);
  {$EXTERNALSYM PKEY_Rating}

// Use the following constants to convert between visual stars and the ratings value:
  RATING_UNRATED_MIN =                   0;
  {$EXTERNALSYM RATING_UNRATED_MIN}
  RATING_UNRATED_SET =                   0;
  {$EXTERNALSYM RATING_UNRATED_SET}
  RATING_UNRATED_MAX =                   0;
  {$EXTERNALSYM RATING_UNRATED_MAX}

  RATING_ONE_STAR_MIN =                  1;
  {$EXTERNALSYM RATING_ONE_STAR_MIN}
  RATING_ONE_STAR_SET =                  1;
  {$EXTERNALSYM RATING_ONE_STAR_SET}
  RATING_ONE_STAR_MAX =                  12;
  {$EXTERNALSYM RATING_ONE_STAR_MAX}

  RATING_TWO_STARS_MIN =                 13;
  {$EXTERNALSYM RATING_TWO_STARS_MIN}
  RATING_TWO_STARS_SET =                 25;
  {$EXTERNALSYM RATING_TWO_STARS_SET}
  RATING_TWO_STARS_MAX =                 37;
  {$EXTERNALSYM RATING_TWO_STARS_MAX}

  RATING_THREE_STARS_MIN =               38;
  {$EXTERNALSYM RATING_THREE_STARS_MIN}
  RATING_THREE_STARS_SET =               50;
  {$EXTERNALSYM RATING_THREE_STARS_SET}
  RATING_THREE_STARS_MAX =               62;
  {$EXTERNALSYM RATING_THREE_STARS_MAX}

  RATING_FOUR_STARS_MIN =                63;
  {$EXTERNALSYM RATING_FOUR_STARS_MIN}
  RATING_FOUR_STARS_SET =                75;
  {$EXTERNALSYM RATING_FOUR_STARS_SET}
  RATING_FOUR_STARS_MAX =                87;
  {$EXTERNALSYM RATING_FOUR_STARS_MAX}

  RATING_FIVE_STARS_MIN =                88;
  {$EXTERNALSYM RATING_FIVE_STARS_MIN}
  RATING_FIVE_STARS_SET =                99;
  {$EXTERNALSYM RATING_FIVE_STARS_SET}
  RATING_FIVE_STARS_MAX =                99;
  {$EXTERNALSYM RATING_FIVE_STARS_MAX}


//  Name:     System.RatingText -- PKEY_RatingText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {90197CA7-FD8F-4E8C-9DA3-B57E1E609295}, 100
//  
//  This is the user-friendly form of System.Rating.  Not intended to be parsed 
//  programmatically.
  PKEY_RatingText : TPropertyKey = (
    fmtid : '{90197CA7-FD8F-4E8C-9DA3-B57E1E609295}'; pid : 100);
  {$EXTERNALSYM PKEY_RatingText}

//  Name:     System.Sensitivity -- PKEY_Sensitivity
//  Type:     UInt16 -- VT_UI2
//  FormatID: {F8D3F6AC-4874-42CB-BE59-AB454B30716A}, 100
//
//  
  PKEY_Sensitivity : TPropertyKey = (
    fmtid : '{F8D3F6AC-4874-42CB-BE59-AB454B30716A}'; pid : 100);
  {$EXTERNALSYM PKEY_Sensitivity}

// Possible discrete values for PKEY_Sensitivity are:
  SENSITIVITY_PROP_NORMAL =              0;
  {$EXTERNALSYM SENSITIVITY_PROP_NORMAL}
  SENSITIVITY_PROP_PERSONAL =            1;
  {$EXTERNALSYM SENSITIVITY_PROP_PERSONAL}
  SENSITIVITY_PROP_PRIVATE =             2;
  {$EXTERNALSYM SENSITIVITY_PROP_PRIVATE}
  SENSITIVITY_PROP_CONFIDENTIAL =        3;
  {$EXTERNALSYM SENSITIVITY_PROP_CONFIDENTIAL}

//  Name:     System.SensitivityText -- PKEY_SensitivityText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {D0C7F054-3F72-4725-8527-129A577CB269}, 100
//  
//  This is the user-friendly form of System.Sensitivity.  Not intended to be parsed 
//  programmatically.
  PKEY_SensitivityText : TPropertyKey = (
    fmtid : '{D0C7F054-3F72-4725-8527-129A577CB269}'; pid : 100);
  {$EXTERNALSYM PKEY_SensitivityText}

//  Name:     System.SFGAOFlags -- PKEY_SFGAOFlags
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 25
//
//  IShellFolder::GetAttributesOf flags, with SFGAO_PKEYSFGAOMASK attributes masked out.
  PKEY_SFGAOFlags : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 25);
  {$EXTERNALSYM PKEY_SFGAOFlags}

//  Name:     System.SharedWith -- PKEY_SharedWith
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902}, 200
//
//  Who is the item shared with?
  PKEY_SharedWith : TPropertyKey = (
    fmtid : '{EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902}'; pid : 200);
  {$EXTERNALSYM PKEY_SharedWith}

//  Name:     System.ShareUserRating -- PKEY_ShareUserRating
//  Type:     UInt32 -- VT_UI4
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 12 (PIDMSI_SHARE_USER_RATING)
//
//  
  PKEY_ShareUserRating : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 12);
  {$EXTERNALSYM PKEY_ShareUserRating}

//  Name:     System.SharingStatus -- PKEY_SharingStatus
//  Type:     UInt32 -- VT_UI4
//  FormatID: {EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902}, 300
//
//  What is the item's sharing status (not shared, shared, everyone (homegroup or everyone), or private)?
  PKEY_SharingStatus : TPropertyKey = (
    fmtid : '{EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902}'; pid : 300);
  {$EXTERNALSYM PKEY_SharingStatus}

// Possible discrete values for PKEY_SharingStatus are:
  SHARINGSTATUS_NOTSHARED =              0;
  {$EXTERNALSYM SHARINGSTATUS_NOTSHARED}
  SHARINGSTATUS_SHARED =                 1;
  {$EXTERNALSYM SHARINGSTATUS_SHARED}
  SHARINGSTATUS_PRIVATE =                2;
  {$EXTERNALSYM SHARINGSTATUS_PRIVATE}
  SHARINGSTATUS_EVERYONE =               3;
  {$EXTERNALSYM SHARINGSTATUS_EVERYONE}

//  Name:     System.Shell.OmitFromView -- PKEY_Shell_OmitFromView
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {DE35258C-C695-4CBC-B982-38B0AD24CED0}, 2
//  
//  Set this to a string value of 'True' to omit this item from shell views
  PKEY_Shell_OmitFromView : TPropertyKey = (
    fmtid : '{DE35258C-C695-4CBC-B982-38B0AD24CED0}'; pid : 2);
  {$EXTERNALSYM PKEY_Shell_OmitFromView}

//  Name:     System.SimpleRating -- PKEY_SimpleRating
//  Type:     UInt32 -- VT_UI4
//  FormatID: {A09F084E-AD41-489F-8076-AA5BE3082BCA}, 100
//  
//  Indicates the users preference rating of an item on a scale of 0-5 (0=unrated, 1=One Star, 2=Two Stars, 3=Three Stars,
//  4=Four Stars, 5=Five Stars)
  PKEY_SimpleRating : TPropertyKey = (
    fmtid : '{A09F084E-AD41-489F-8076-AA5BE3082BCA}'; pid : 100);
  {$EXTERNALSYM PKEY_SimpleRating}

//  Name:     System.Size -- PKEY_Size
//  Type:     UInt64 -- VT_UI8
//  FormatID: (FMTID_Storage) {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 12 (PID_STG_SIZE)
//
//  
  PKEY_Size : TPropertyKey = (
    fmtid : '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid : 12);
  {$EXTERNALSYM PKEY_Size}

//  Name:     System.SoftwareUsed -- PKEY_SoftwareUsed
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 305
//
//  PropertyTagSoftwareUsed
  PKEY_SoftwareUsed : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 305);
  {$EXTERNALSYM PKEY_SoftwareUsed}

//  Name:     System.SourceItem -- PKEY_SourceItem
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {668CDFA5-7A1B-4323-AE4B-E527393A1D81}, 100
  PKEY_SourceItem : TPropertyKey = (
    fmtid : '{668CDFA5-7A1B-4323-AE4B-E527393A1D81}'; pid : 100);
  {$EXTERNALSYM PKEY_SourceItem}

//  Name:     System.StartDate -- PKEY_StartDate
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {48FD6EC8-8A12-4CDF-A03E-4EC5A511EDDE}, 100
  PKEY_StartDate : TPropertyKey = (
    fmtid : '{48FD6EC8-8A12-4CDF-A03E-4EC5A511EDDE}'; pid : 100);
  {$EXTERNALSYM PKEY_StartDate}

//  Name:     System.Status -- PKEY_Status
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_IntSite) {000214A1-0000-0000-C000-000000000046}, 9
  PKEY_Status : TPropertyKey = (
    fmtid : '{000214A1-0000-0000-C000-000000000046}'; pid : 9);
  {$EXTERNALSYM PKEY_Status}

//  Name:     System.Subject -- PKEY_Subject
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 3 (PIDSI_SUBJECT)
//
//  
  PKEY_Subject : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 3);
  {$EXTERNALSYM PKEY_Subject}

//  Name:     System.Thumbnail -- PKEY_Thumbnail
//  Type:     Clipboard -- VT_CF
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 17 (PIDSI_THUMBNAIL)
//
//  A data that represents the thumbnail in VT_CF format.
  PKEY_Thumbnail : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 17);
  {$EXTERNALSYM PKEY_Thumbnail}

//  Name:     System.ThumbnailCacheId -- PKEY_ThumbnailCacheId
//  Type:     UInt64 -- VT_UI8
//  FormatID: {446D16B1-8DAD-4870-A748-402EA43D788C}, 100
//  
//  Unique value that can be used as a key to cache thumbnails. The value changes when the name, volume, or data modified 
//  of an item changes.
  PKEY_ThumbnailCacheId : TPropertyKey = (
    fmtid : '{446D16B1-8DAD-4870-A748-402EA43D788C}'; pid : 100);
  {$EXTERNALSYM PKEY_ThumbnailCacheId}

//  Name:     System.ThumbnailStream -- PKEY_ThumbnailStream
//  Type:     Stream -- VT_STREAM
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 27
//
//  Data that represents the thumbnail in VT_STREAM format that GDI+/WindowsCodecs supports (jpg, png, etc).
  PKEY_ThumbnailStream : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 27);
  {$EXTERNALSYM PKEY_ThumbnailStream}

//  Name:     System.Title -- PKEY_Title
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)  Legacy code may treat this as VT_LPSTR.
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 2 (PIDSI_TITLE)
//
//  Title of item.
  PKEY_Title : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 2);
  {$EXTERNALSYM PKEY_Title}

//  Name:     System.TotalFileSize -- PKEY_TotalFileSize
//  Type:     UInt64 -- VT_UI8
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 14
//
//  
  PKEY_TotalFileSize : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 14);
  {$EXTERNALSYM PKEY_TotalFileSize}

//  Name:     System.Trademarks -- PKEY_Trademarks
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSFMTID_VERSION) {0CEF7D53-FA64-11D1-A203-0000F81FEDEE}, 9 (PIDVSI_Trademarks)
//
//  
  PKEY_Trademarks : TPropertyKey = (
    fmtid : '{0CEF7D53-FA64-11D1-A203-0000F81FEDEE}'; pid : 9);
  {$EXTERNALSYM PKEY_Trademarks}
 
//-----------------------------------------------------------------------------
// Devices properties



//  Name:     System.DeviceInterface.PrinterDriverName -- PKEY_DeviceInterface_PrinterDriverName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {AFC47170-14F5-498C-8F30-B0D19BE449C6}, 11
//
//  Printer information Driver Name.
  PKEY_DeviceInterface_PrinterDriverName : TPropertyKey = (
    fmtid : '{AFC47170-14F5-498C-8F30-B0D19BE449C6}'; pid : 11);
  {$EXTERNALSYM PKEY_DeviceInterface_PrinterDriverName}

//  Name:     System.DeviceInterface.PrinterName -- PKEY_DeviceInterface_PrinterName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {0A7B84EF-0C27-463F-84EF-06C5070001BE}, 10
//
//  Printer information Printer Name.
  PKEY_DeviceInterface_PrinterName : TPropertyKey = (
    fmtid : '{0A7B84EF-0C27-463F-84EF-06C5070001BE}'; pid : 10);
  {$EXTERNALSYM PKEY_DeviceInterface_PrinterName}

//  Name:     System.DeviceInterface.PrinterPortName -- PKEY_DeviceInterface_PrinterPortName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {EEC7B761-6F94-41B1-949F-C729720DD13C}, 12
//
//  Printer information Port Name.
  PKEY_DeviceInterface_PrinterPortName : TPropertyKey = (
    fmtid : '{EEC7B761-6F94-41B1-949F-C729720DD13C}'; pid : 12);
  {$EXTERNALSYM PKEY_DeviceInterface_PrinterPortName}

//  Name:     System.Devices.Address -- PKEY_Devices_Address
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 51
//
//  Device address. This will be particular to the transport of the device.
  PKEY_Devices_Address : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 51);
  {$EXTERNALSYM PKEY_Devices_Address}

//  Name:     System.Devices.Authenticated -- PKEY_Devices_IsAuthenticated
//  Type:     Boolean -- VT_BOOL
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 54
//
//  Device authentication state. If VARIANT_TRUE, the device is authenticated and trusted.
  PKEY_Devices_IsAuthenticated : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 54);
  {$EXTERNALSYM PKEY_Devices_IsAuthenticated}

//  Name:     System.Devices.BatteryLife -- PKEY_Devices_BatteryLife
//  Type:     Byte -- VT_UI1
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 10
//
//  Remaining battery life of the device as an integer between 0 and 100 percent.
  PKEY_Devices_BatteryLife : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 10);
  {$EXTERNALSYM PKEY_Devices_BatteryLife}

//  Name:     System.Devices.BatteryPlusCharging -- PKEY_Devices_BatteryPlusCharging
//  Type:     Byte -- VT_UI1
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 22
//
//  Remaining battery life of the device as an integer between 0 and 100 percent and the device's charging state.
  PKEY_Devices_BatteryPlusCharging : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 22);
  {$EXTERNALSYM PKEY_Devices_BatteryPlusCharging}

//  Name:     System.Devices.BatteryPlusChargingText -- PKEY_Devices_BatteryPlusChargingText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 23
//
//  Remaining battery life of the device and the device's charging state as a string.
  PKEY_Devices_BatteryPlusChargingText : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 23);
  {$EXTERNALSYM PKEY_Devices_BatteryPlusChargingText}

//  Name:     System.Devices.Category -- PKEY_Devices_Category_Desc_Singular
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 91
//
//  Singular form of device category.
  PKEY_Devices_Category_Desc_Singular : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 91);
  {$EXTERNALSYM PKEY_Devices_Category_Desc_Singular}

//  Name:     System.Devices.CategoryGroup -- PKEY_Devices_CategoryGroup_Desc
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 94
//
//  Plural form of device category.
  PKEY_Devices_CategoryGroup_Desc : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 94);
  {$EXTERNALSYM PKEY_Devices_CategoryGroup_Desc}

//  Name:     System.Devices.CategoryPlural -- PKEY_Devices_Category_Desc_Plural
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 92
//
//  Plural form of device category.
  PKEY_Devices_Category_Desc_Plural : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 92);
  {$EXTERNALSYM PKEY_Devices_Category_Desc_Plural}

//  Name:     System.Devices.ChargingState -- PKEY_Devices_ChargingState
//  Type:     Byte -- VT_UI1
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 11
//
//  Boolean value representing if the device is currently charging.
  PKEY_Devices_ChargingState : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 11);
  {$EXTERNALSYM PKEY_Devices_ChargingState}

//  Name:     System.Devices.Connected -- PKEY_Devices_IsConnected
//  Type:     Boolean -- VT_BOOL
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 55
//
//  Device connection state. If VARIANT_TRUE, indicates the device is currently connected to the computer.
  PKEY_Devices_IsConnected : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 55);
  {$EXTERNALSYM PKEY_Devices_IsConnected}

//  Name:     System.Devices.ContainerId -- PKEY_Devices_ContainerId
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {8C7ED206-3F8A-4827-B3AB-AE9E1FAEFC6C}, 2
//
//  Device container ID.
  PKEY_Devices_ContainerId : TPropertyKey = (
    fmtid : '{8C7ED206-3F8A-4827-B3AB-AE9E1FAEFC6C}'; pid : 2);
  {$EXTERNALSYM PKEY_Devices_ContainerId}

//  Name:     System.Devices.DeviceConnected -- PKEY_Devices_DeviceConnected
//  Type:     Boolean -- VT_BOOL
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 16
//
//  Boolean property indicating if the device has a data connection to the PC.
  PKEY_Devices_DeviceConnected : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 16);
  {$EXTERNALSYM PKEY_Devices_DeviceConnected}

//  Name:     System.Devices.DeviceDescription1 -- PKEY_Devices_DeviceDescription1
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 81
//
//  First line of descriptive text about the device.
  PKEY_Devices_DeviceDescription1 : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 81);
  {$EXTERNALSYM PKEY_Devices_DeviceDescription1}

//  Name:     System.Devices.DeviceDescription2 -- PKEY_Devices_DeviceDescription2
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 82
//
//  Second line of descriptive text about the device.
  PKEY_Devices_DeviceDescription2 : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 82);
  {$EXTERNALSYM PKEY_Devices_DeviceDescription2}

//  Name:     System.Devices.DeviceNetworkBytesReceived -- PKEY_Devices_DeviceNetworkBytesReceived
//  Type:     UInt64 -- VT_UI8
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 20
//
//  Number of bytes received on the PC from the device.
  PKEY_Devices_DeviceNetworkBytesReceived : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 20);
  {$EXTERNALSYM PKEY_Devices_DeviceNetworkBytesReceived}

//  Name:     System.Devices.DeviceNetworkBytesSent -- PKEY_Devices_DeviceNetworkBytesSent
//  Type:     UInt64 -- VT_UI8
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 19
//
//  Number of bytes sent from the PC to the device.
  PKEY_Devices_DeviceNetworkBytesSent : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 19);
  {$EXTERNALSYM PKEY_Devices_DeviceNetworkBytesSent}

//  Name:     System.Devices.DeviceNetworkConnection -- PKEY_Devices_DeviceNetworkConnection
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 17
//
//  Aggregate property representing the device's data connection to the internet.
  PKEY_Devices_DeviceNetworkConnection : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 17);
  {$EXTERNALSYM PKEY_Devices_DeviceNetworkConnection}

//  Name:     System.Devices.DeviceNetworkConnectionName -- PKEY_Devices_DeviceNetworkConnectionName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 18
//
//  Name of the device's data connection to the internet.
  PKEY_Devices_DeviceNetworkConnectionName : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 18);
  {$EXTERNALSYM PKEY_Devices_DeviceNetworkConnectionName}

//  Name:     System.Devices.DeviceNetworkUptime -- PKEY_Devices_DeviceNetworkUptime
//  Type:     Int64 -- VT_I8
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 21
//
//  Length of time the PC has been connected to the device.
  PKEY_Devices_DeviceNetworkUptime : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 21);
  {$EXTERNALSYM PKEY_Devices_DeviceNetworkUptime}

//  Name:     System.Devices.DiscoveryMethod -- PKEY_Devices_DiscoveryMethod
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 52
//
//  Device discovery method. This indicates on what transport or physical connection the device is discovered.
  PKEY_Devices_DiscoveryMethod : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 52);
  {$EXTERNALSYM PKEY_Devices_DiscoveryMethod}

//  Name:     System.Devices.Encrypted -- PKEY_Devices_IsEncrypted
//  Type:     Boolean -- VT_BOOL
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 53
//
//  Device connection encryption state. If VARIANT_TRUE, the connection to the device is encrypted.
  PKEY_Devices_IsEncrypted : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 53);
  {$EXTERNALSYM PKEY_Devices_IsEncrypted}

//  Name:     System.Devices.FriendlyName -- PKEY_Devices_FriendlyName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {656A3BB3-ECC0-43FD-8477-4AE0404A96CD}, 12288
//
//  Device friendly name.
  PKEY_Devices_FriendlyName : TPropertyKey = (
    fmtid : '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid : 12288);
  {$EXTERNALSYM PKEY_Devices_FriendlyName}

//  Name:     System.Devices.FunctionPaths -- PKEY_Devices_FunctionPaths
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {D08DD4C0-3A9E-462E-8290-7B636B2576B9}, 3
//
//  Available functions for this device.
  PKEY_Devices_FunctionPaths : TPropertyKey = (
    fmtid : '{D08DD4C0-3A9E-462E-8290-7B636B2576B9}'; pid : 3);
  {$EXTERNALSYM PKEY_Devices_FunctionPaths}

//  Name:     System.Devices.InterfacePaths -- PKEY_Devices_InterfacePaths
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {D08DD4C0-3A9E-462E-8290-7B636B2576B9}, 2
//
//  Available interfaces for this device.
  PKEY_Devices_InterfacePaths : TPropertyKey = (
    fmtid : '{D08DD4C0-3A9E-462E-8290-7B636B2576B9}'; pid : 2);
  {$EXTERNALSYM PKEY_Devices_InterfacePaths}

//  Name:     System.Devices.InternetConnected -- PKEY_Devices_InternetConnected
//  Type:     Boolean -- VT_BOOL
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 15
//
//  Boolean property indicating if the device is connected to the internet.
  PKEY_Devices_InternetConnected : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 15);
  {$EXTERNALSYM PKEY_Devices_InternetConnected}

//  Name:     System.Devices.IsDefault -- PKEY_Devices_IsDefaultDevice
//  Type:     Boolean -- VT_BOOL
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 86
//
//  If VARIANT_TRUE, the device is not working properly.
  PKEY_Devices_IsDefaultDevice : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 86);
  {$EXTERNALSYM PKEY_Devices_IsDefaultDevice}

//  Name:     System.Devices.IsNetworkConnected -- PKEY_Devices_IsNetworkDevice
//  Type:     Boolean -- VT_BOOL
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 85
//
//  If VARIANT_TRUE, the device is not working properly.
  PKEY_Devices_IsNetworkDevice : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 85);
  {$EXTERNALSYM PKEY_Devices_IsNetworkDevice}

//  Name:     System.Devices.IsShared -- PKEY_Devices_IsSharedDevice
//  Type:     Boolean -- VT_BOOL
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 84
//
//  If VARIANT_TRUE, the device is not working properly.
  PKEY_Devices_IsSharedDevice : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 84);
  {$EXTERNALSYM PKEY_Devices_IsSharedDevice}

//  Name:     System.Devices.LastConnected -- PKEY_Devices_Last_Connected
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 67
//
//  Timestamp of last successful connection to the device from the computer.
  PKEY_Devices_Last_Connected : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 67);
  {$EXTERNALSYM PKEY_Devices_Last_Connected}

//  Name:     System.Devices.LastSeen -- PKEY_Devices_Last_Seen
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 66
//
//  Timestamp of last time device was discovered by any method from the computer.
  PKEY_Devices_Last_Seen : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 66);
  {$EXTERNALSYM PKEY_Devices_Last_Seen}

//  Name:     System.Devices.LaunchDXPFromExplorer -- PKEY_Devices_LaunchDXPFromExplorer
//  Type:     Boolean -- VT_BOOL
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 77
//
//  Indicates whether to launch DXP or not
  PKEY_Devices_LaunchDXPFromExplorer : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 77);
  {$EXTERNALSYM PKEY_Devices_LaunchDXPFromExplorer}

//  Name:     System.Devices.LocalMachine -- PKEY_Devices_IsLocalMachine
//  Type:     Boolean -- VT_BOOL
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 70
//
//  If VARIANT_TRUE, the device in question is actually the computer.
  PKEY_Devices_IsLocalMachine : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 70);
  {$EXTERNALSYM PKEY_Devices_IsLocalMachine}

//  Name:     System.Devices.Manufacturer -- PKEY_Devices_Manufacturer
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {656A3BB3-ECC0-43FD-8477-4AE0404A96CD}, 8192
//
//  Device manufacturer.
  PKEY_Devices_Manufacturer : TPropertyKey = (
    fmtid : '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid : 8192);
  {$EXTERNALSYM PKEY_Devices_Manufacturer}

//  Name:     System.Devices.MissedCalls -- PKEY_Devices_MissedCalls
//  Type:     Byte -- VT_UI1
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 5
//
//  Number of missed calls on the device.
  PKEY_Devices_MissedCalls : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 5);
  {$EXTERNALSYM PKEY_Devices_MissedCalls}

//  Name:     System.Devices.ModelName -- PKEY_Devices_ModelName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {656A3BB3-ECC0-43FD-8477-4AE0404A96CD}, 8194
//
//  Model name of the device.
  PKEY_Devices_ModelName : TPropertyKey = (
    fmtid : '{656A3BB3-ECC0-43FD-8477-4AE0404A96CD}'; pid : 8194);
  {$EXTERNALSYM PKEY_Devices_ModelName}

//  Name:     System.Devices.NetworkName -- PKEY_Devices_NetworkName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 7
//
//  Name of the device's network.
  PKEY_Devices_NetworkName : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 7);
  {$EXTERNALSYM PKEY_Devices_NetworkName}

//  Name:     System.Devices.NetworkType -- PKEY_Devices_NetworkType
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 8
//
//  String representing the type of the device's network.
  PKEY_Devices_NetworkType : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 8);
  {$EXTERNALSYM PKEY_Devices_NetworkType}

//  Name:     System.Devices.NewPictures -- PKEY_Devices_NewPictures
//  Type:     UInt16 -- VT_UI2
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 4
//
//  Number of new pictures on the device.
  PKEY_Devices_NewPictures : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 4);
  {$EXTERNALSYM PKEY_Devices_NewPictures}

//  Name:     System.Devices.Notification -- PKEY_Devices_Notification
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {06704B0C-E830-4C81-9178-91E4E95A80A0}, 3
//
//  Device Notification Property.
  PKEY_Devices_Notification : TPropertyKey = (
    fmtid : '{06704B0C-E830-4C81-9178-91E4E95A80A0}'; pid : 3);
  {$EXTERNALSYM PKEY_Devices_Notification}

//  Name:     System.Devices.Notifications.LowBattery -- PKEY_Devices_Notification_LowBattery
//  Type:     Byte -- VT_UI1
//  FormatID: {C4C07F2B-8524-4E66-AE3A-A6235F103BEB}, 2
//
//  Device Low Battery Notification.
  PKEY_Devices_Notification_LowBattery : TPropertyKey = (
    fmtid : '{C4C07F2B-8524-4E66-AE3A-A6235F103BEB}'; pid : 2);
  {$EXTERNALSYM PKEY_Devices_Notification_LowBattery}

//  Name:     System.Devices.Notifications.MissedCall -- PKEY_Devices_Notification_MissedCall
//  Type:     Byte -- VT_UI1
//  FormatID: {6614EF48-4EFE-4424-9EDA-C79F404EDF3E}, 2
//
//  Device Missed Call Notification.
  PKEY_Devices_Notification_MissedCall : TPropertyKey = (
    fmtid : '{6614EF48-4EFE-4424-9EDA-C79F404EDF3E}'; pid : 2);
  {$EXTERNALSYM PKEY_Devices_Notification_MissedCall}

//  Name:     System.Devices.Notifications.NewMessage -- PKEY_Devices_Notification_NewMessage
//  Type:     Byte -- VT_UI1
//  FormatID: {2BE9260A-2012-4742-A555-F41B638B7DCB}, 2
//
//  Device New Message Notification.
  PKEY_Devices_Notification_NewMessage : TPropertyKey = (
    fmtid : '{2BE9260A-2012-4742-A555-F41B638B7DCB}'; pid : 2);
  {$EXTERNALSYM PKEY_Devices_Notification_NewMessage}

//  Name:     System.Devices.Notifications.NewVoicemail -- PKEY_Devices_Notification_NewVoicemail
//  Type:     Byte -- VT_UI1
//  FormatID: {59569556-0A08-4212-95B9-FAE2AD6413DB}, 2
//
//  Device Voicemail Notification.
  PKEY_Devices_Notification_NewVoicemail : TPropertyKey = (
    fmtid : '{59569556-0A08-4212-95B9-FAE2AD6413DB}'; pid : 2);
  {$EXTERNALSYM PKEY_Devices_Notification_NewVoicemail}

//  Name:     System.Devices.Notifications.StorageFull -- PKEY_Devices_Notification_StorageFull
//  Type:     UInt64 -- VT_UI8
//  FormatID: {A0E00EE1-F0C7-4D41-B8E7-26A7BD8D38B0}, 2
//
//  Device Storage Full Notification.
  PKEY_Devices_Notification_StorageFull : TPropertyKey = (
    fmtid : '{A0E00EE1-F0C7-4D41-B8E7-26A7BD8D38B0}'; pid : 2);
  {$EXTERNALSYM PKEY_Devices_Notification_StorageFull}

//  Name:     System.Devices.Notifications.StorageFullLinkText -- PKEY_Devices_Notification_StorageFullLinkText
//  Type:     UInt64 -- VT_UI8
//  FormatID: {A0E00EE1-F0C7-4D41-B8E7-26A7BD8D38B0}, 3
//
//  Link Text for the Device Storage Full Notification.
  PKEY_Devices_Notification_StorageFullLinkText : TPropertyKey = (
    fmtid : '{A0E00EE1-F0C7-4D41-B8E7-26A7BD8D38B0}'; pid : 3);
  {$EXTERNALSYM PKEY_Devices_Notification_StorageFullLinkText}

//  Name:     System.Devices.NotificationStore -- PKEY_Devices_NotificationStore
//  Type:     Object -- VT_UNKNOWN
//  FormatID: {06704B0C-E830-4C81-9178-91E4E95A80A0}, 2
//
//  Device Notification Store.
  PKEY_Devices_NotificationStore : TPropertyKey = (
    fmtid : '{06704B0C-E830-4C81-9178-91E4E95A80A0}'; pid : 2);
  {$EXTERNALSYM PKEY_Devices_NotificationStore}

//  Name:     System.Devices.NotWorkingProperly -- PKEY_Devices_IsNotWorkingProperly
//  Type:     Boolean -- VT_BOOL
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 83
//
//  If VARIANT_TRUE, the device is not working properly.
  PKEY_Devices_IsNotWorkingProperly : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 83);
  {$EXTERNALSYM PKEY_Devices_IsNotWorkingProperly}

//  Name:     System.Devices.Paired -- PKEY_Devices_IsPaired
//  Type:     Boolean -- VT_BOOL
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 56
//
//  Device paired state. If VARIANT_TRUE, indicates the device is not paired with the computer.
  PKEY_Devices_IsPaired : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 56);
  {$EXTERNALSYM PKEY_Devices_IsPaired}

//  Name:     System.Devices.PrimaryCategory -- PKEY_Devices_PrimaryCategory
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {D08DD4C0-3A9E-462E-8290-7B636B2576B9}, 10
//
//  Primary category group for this device.
  PKEY_Devices_PrimaryCategory : TPropertyKey = (
    fmtid : '{D08DD4C0-3A9E-462E-8290-7B636B2576B9}'; pid : 10);
  {$EXTERNALSYM PKEY_Devices_PrimaryCategory}

//  Name:     System.Devices.Roaming -- PKEY_Devices_Roaming
//  Type:     Byte -- VT_UI1
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 9
//
//  Status indicator used to indicate if the device is roaming.
  PKEY_Devices_Roaming : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 9);
  {$EXTERNALSYM PKEY_Devices_Roaming}

//  Name:     System.Devices.SafeRemovalRequired -- PKEY_Devices_SafeRemovalRequired
//  Type:     Boolean -- VT_BOOL
//  FormatID: {AFD97640-86A3-4210-B67C-289C41AABE55}, 2
//
//  Indicates if a device requires safe removal or not
  PKEY_Devices_SafeRemovalRequired : TPropertyKey = (
    fmtid : '{AFD97640-86A3-4210-B67C-289C41AABE55}'; pid : 2);
  {$EXTERNALSYM PKEY_Devices_SafeRemovalRequired}

//  Name:     System.Devices.SignalStrength -- PKEY_Devices_SignalStrength
//  Type:     Byte -- VT_UI1
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 2
//
//  Device signal strength.
  PKEY_Devices_SignalStrength : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 2);
  {$EXTERNALSYM PKEY_Devices_SignalStrength}

//  Name:     System.Devices.Status1 -- PKEY_Devices_Status1
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {D08DD4C0-3A9E-462E-8290-7B636B2576B9}, 257
//
//  1st line of device status.
  PKEY_Devices_Status1 : TPropertyKey = (
    fmtid : '{D08DD4C0-3A9E-462E-8290-7B636B2576B9}'; pid : 257);
  {$EXTERNALSYM PKEY_Devices_Status1}

//  Name:     System.Devices.Status2 -- PKEY_Devices_Status2
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {D08DD4C0-3A9E-462E-8290-7B636B2576B9}, 258
//
//  2nd line of device status.
  PKEY_Devices_Status2 : TPropertyKey = (
    fmtid : '{D08DD4C0-3A9E-462E-8290-7B636B2576B9}'; pid : 258);
  {$EXTERNALSYM PKEY_Devices_Status2}

//  Name:     System.Devices.StorageCapacity -- PKEY_Devices_StorageCapacity
//  Type:     UInt64 -- VT_UI8
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 12
//
//  Total storage capacity of the device.
  PKEY_Devices_StorageCapacity : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 12);
  {$EXTERNALSYM PKEY_Devices_StorageCapacity}

//  Name:     System.Devices.StorageFreeSpace -- PKEY_Devices_StorageFreeSpace
//  Type:     UInt64 -- VT_UI8
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 13
//
//  Total free space of the storage of the device.
  PKEY_Devices_StorageFreeSpace : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 13);
  {$EXTERNALSYM PKEY_Devices_StorageFreeSpace}

//  Name:     System.Devices.StorageFreeSpacePercent -- PKEY_Devices_StorageFreeSpacePercent
//  Type:     UInt32 -- VT_UI4
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 14
//
//  Total free space of the storage of the device as a percentage.
  PKEY_Devices_StorageFreeSpacePercent : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 14);
  {$EXTERNALSYM PKEY_Devices_StorageFreeSpacePercent}

//  Name:     System.Devices.TextMessages -- PKEY_Devices_TextMessages
//  Type:     Byte -- VT_UI1
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 3
//
//  Number of unread text messages on the device.
  PKEY_Devices_TextMessages : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 3);
  {$EXTERNALSYM PKEY_Devices_TextMessages}

//  Name:     System.Devices.Version -- PKEY_Devices_Version
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {78C34FC8-104A-4ACA-9EA4-524D52996E57}, 65
//
//  Device version.
  PKEY_Devices_Version : TPropertyKey = (
    fmtid : '{78C34FC8-104A-4ACA-9EA4-524D52996E57}'; pid : 65);
  {$EXTERNALSYM PKEY_Devices_Version}

//  Name:     System.Devices.Voicemail -- PKEY_Devices_Voicemail
//  Type:     Byte -- VT_UI1
//  FormatID: {49CD1F76-5626-4B17-A4E8-18B4AA1A2213}, 6
//
//  Status indicator used to indicate if the device has voicemail.
  PKEY_Devices_Voicemail : TPropertyKey = (
    fmtid : '{49CD1F76-5626-4B17-A4E8-18B4AA1A2213}'; pid : 6);
  {$EXTERNALSYM PKEY_Devices_Voicemail}
 
//-----------------------------------------------------------------------------
// Document properties



//  Name:     System.Document.ByteCount -- PKEY_Document_ByteCount
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 4 (PIDDSI_BYTECOUNT)
//
//  
  PKEY_Document_ByteCount : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 4);
  {$EXTERNALSYM PKEY_Document_ByteCount}

//  Name:     System.Document.CharacterCount -- PKEY_Document_CharacterCount
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 16 (PIDSI_CHARCOUNT)
//
//  
  PKEY_Document_CharacterCount : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 16);
  {$EXTERNALSYM PKEY_Document_CharacterCount}

//  Name:     System.Document.ClientID -- PKEY_Document_ClientID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {276D7BB0-5B34-4FB0-AA4B-158ED12A1809}, 100
  PKEY_Document_ClientID : TPropertyKey = (
    fmtid : '{276D7BB0-5B34-4FB0-AA4B-158ED12A1809}'; pid : 100);
  {$EXTERNALSYM PKEY_Document_ClientID}

//  Name:     System.Document.Contributor -- PKEY_Document_Contributor
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {F334115E-DA1B-4509-9B3D-119504DC7ABB}, 100
  PKEY_Document_Contributor : TPropertyKey = (
    fmtid : '{F334115E-DA1B-4509-9B3D-119504DC7ABB}'; pid : 100);
  {$EXTERNALSYM PKEY_Document_Contributor}

//  Name:     System.Document.DateCreated -- PKEY_Document_DateCreated
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 12 (PIDSI_CREATE_DTM)
//  
//  This property is stored in the document, not obtained from the file system.
  PKEY_Document_DateCreated : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 12);
  {$EXTERNALSYM PKEY_Document_DateCreated}

//  Name:     System.Document.DatePrinted -- PKEY_Document_DatePrinted
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 11 (PIDSI_LASTPRINTED)
//
//  Legacy name: "DocLastPrinted".
  PKEY_Document_DatePrinted : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 11);
  {$EXTERNALSYM PKEY_Document_DatePrinted}

//  Name:     System.Document.DateSaved -- PKEY_Document_DateSaved
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 13 (PIDSI_LASTSAVE_DTM)
//
//  Legacy name: "DocLastSavedTm".
  PKEY_Document_DateSaved : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 13);
  {$EXTERNALSYM PKEY_Document_DateSaved}

//  Name:     System.Document.Division -- PKEY_Document_Division
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {1E005EE6-BF27-428B-B01C-79676ACD2870}, 100
  PKEY_Document_Division : TPropertyKey = (
    fmtid : '{1E005EE6-BF27-428B-B01C-79676ACD2870}'; pid : 100);
  {$EXTERNALSYM PKEY_Document_Division}

//  Name:     System.Document.DocumentID -- PKEY_Document_DocumentID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E08805C8-E395-40DF-80D2-54F0D6C43154}, 100
  PKEY_Document_DocumentID : TPropertyKey = (
    fmtid : '{E08805C8-E395-40DF-80D2-54F0D6C43154}'; pid : 100);
  {$EXTERNALSYM PKEY_Document_DocumentID}

//  Name:     System.Document.HiddenSlideCount -- PKEY_Document_HiddenSlideCount
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 9 (PIDDSI_HIDDENCOUNT)
//
//  
  PKEY_Document_HiddenSlideCount : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 9);
  {$EXTERNALSYM PKEY_Document_HiddenSlideCount}

//  Name:     System.Document.LastAuthor -- PKEY_Document_LastAuthor
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 8 (PIDSI_LASTAUTHOR)
//
//  
  PKEY_Document_LastAuthor : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 8);
  {$EXTERNALSYM PKEY_Document_LastAuthor}

//  Name:     System.Document.LineCount -- PKEY_Document_LineCount
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 5 (PIDDSI_LINECOUNT)
//
//  
  PKEY_Document_LineCount : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 5);
  {$EXTERNALSYM PKEY_Document_LineCount}

//  Name:     System.Document.Manager -- PKEY_Document_Manager
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 14 (PIDDSI_MANAGER)
//
//  
  PKEY_Document_Manager : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 14);
  {$EXTERNALSYM PKEY_Document_Manager}

//  Name:     System.Document.MultimediaClipCount -- PKEY_Document_MultimediaClipCount
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 10 (PIDDSI_MMCLIPCOUNT)
//
//  
  PKEY_Document_MultimediaClipCount : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 10);
  {$EXTERNALSYM PKEY_Document_MultimediaClipCount}

//  Name:     System.Document.NoteCount -- PKEY_Document_NoteCount
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 8 (PIDDSI_NOTECOUNT)
//
//  
  PKEY_Document_NoteCount : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 8);
  {$EXTERNALSYM PKEY_Document_NoteCount}

//  Name:     System.Document.PageCount -- PKEY_Document_PageCount
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 14 (PIDSI_PAGECOUNT)
//
//  
  PKEY_Document_PageCount : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 14);
  {$EXTERNALSYM PKEY_Document_PageCount}

//  Name:     System.Document.ParagraphCount -- PKEY_Document_ParagraphCount
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 6 (PIDDSI_PARCOUNT)
//
//  
  PKEY_Document_ParagraphCount : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 6);
  {$EXTERNALSYM PKEY_Document_ParagraphCount}

//  Name:     System.Document.PresentationFormat -- PKEY_Document_PresentationFormat
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 3 (PIDDSI_PRESFORMAT)
//
//  
  PKEY_Document_PresentationFormat : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 3);
  {$EXTERNALSYM PKEY_Document_PresentationFormat}

//  Name:     System.Document.RevisionNumber -- PKEY_Document_RevisionNumber
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 9 (PIDSI_REVNUMBER)
//
//  
  PKEY_Document_RevisionNumber : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 9);
  {$EXTERNALSYM PKEY_Document_RevisionNumber}

//  Name:     System.Document.Security -- PKEY_Document_Security
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 19
//
//  Access control information, from SummaryInfo propset
  PKEY_Document_Security : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 19);
  {$EXTERNALSYM PKEY_Document_Security}

//  Name:     System.Document.SlideCount -- PKEY_Document_SlideCount
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 7 (PIDDSI_SLIDECOUNT)
//
//  
  PKEY_Document_SlideCount : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 7);
  {$EXTERNALSYM PKEY_Document_SlideCount}

//  Name:     System.Document.Template -- PKEY_Document_Template
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 7 (PIDSI_TEMPLATE)
//
//  
  PKEY_Document_Template : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 7);
  {$EXTERNALSYM PKEY_Document_Template}

//  Name:     System.Document.TotalEditingTime -- PKEY_Document_TotalEditingTime
//  Type:     UInt64 -- VT_UI8
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 10 (PIDSI_EDITTIME)
//
//  100ns units, not milliseconds. VT_FILETIME for IPropertySetStorage handlers (legacy)
  PKEY_Document_TotalEditingTime : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 10);
  {$EXTERNALSYM PKEY_Document_TotalEditingTime}

//  Name:     System.Document.Version -- PKEY_Document_Version
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_DocumentSummaryInformation) {D5CDD502-2E9C-101B-9397-08002B2CF9AE}, 29
  PKEY_Document_Version : TPropertyKey = (
    fmtid : '{D5CDD502-2E9C-101B-9397-08002B2CF9AE}'; pid : 29);
  {$EXTERNALSYM PKEY_Document_Version}

//  Name:     System.Document.WordCount -- PKEY_Document_WordCount
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_SummaryInformation) {F29F85E0-4FF9-1068-AB91-08002B27B3D9}, 15 (PIDSI_WORDCOUNT)
//
//  
  PKEY_Document_WordCount : TPropertyKey = (
    fmtid : '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}'; pid : 15);
  {$EXTERNALSYM PKEY_Document_WordCount}

 
 
//-----------------------------------------------------------------------------
// DRM properties

//  Name:     System.DRM.DatePlayExpires -- PKEY_DRM_DatePlayExpires
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: (FMTID_DRM) {AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED}, 6 (PIDDRSI_PLAYEXPIRES)
//
//  Indicates when play expires for digital rights management.
  PKEY_DRM_DatePlayExpires : TPropertyKey = (
    fmtid : '{AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED}'; pid : 6);
  {$EXTERNALSYM PKEY_DRM_DatePlayExpires}

//  Name:     System.DRM.DatePlayStarts -- PKEY_DRM_DatePlayStarts
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: (FMTID_DRM) {AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED}, 5 (PIDDRSI_PLAYSTARTS)
//
//  Indicates when play starts for digital rights management.
  PKEY_DRM_DatePlayStarts : TPropertyKey = (
    fmtid : '{AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED}'; pid : 5);
  {$EXTERNALSYM PKEY_DRM_DatePlayStarts}

//  Name:     System.DRM.Description -- PKEY_DRM_Description
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_DRM) {AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED}, 3 (PIDDRSI_DESCRIPTION)
//
//  Displays the description for digital rights management.
  PKEY_DRM_Description : TPropertyKey = (
    fmtid : '{AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED}'; pid : 3);
  {$EXTERNALSYM PKEY_DRM_Description}

//  Name:     System.DRM.IsProtected -- PKEY_DRM_IsProtected
//  Type:     Boolean -- VT_BOOL
//  FormatID: (FMTID_DRM) {AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED}, 2 (PIDDRSI_PROTECTED)
//
//  
  PKEY_DRM_IsProtected : TPropertyKey = (
    fmtid : '{AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED}'; pid : 2);
  {$EXTERNALSYM PKEY_DRM_IsProtected}

//  Name:     System.DRM.PlayCount -- PKEY_DRM_PlayCount
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_DRM) {AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED}, 4 (PIDDRSI_PLAYCOUNT)
//
//  Indicates the play count for digital rights management.
  PKEY_DRM_PlayCount : TPropertyKey = (
    fmtid : '{AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED}'; pid : 4);
  {$EXTERNALSYM PKEY_DRM_PlayCount}
 
//-----------------------------------------------------------------------------
// GPS properties

//  Name:     System.GPS.Altitude -- PKEY_GPS_Altitude
//  Type:     Double -- VT_R8
//  FormatID: {827EDB4F-5B73-44A7-891D-FDFFABEA35CA}, 100
//  
//  Indicates the altitude based on the reference in PKEY_GPS_AltitudeRef.  Calculated from PKEY_GPS_AltitudeNumerator and 
//  PKEY_GPS_AltitudeDenominator
  PKEY_GPS_Altitude : TPropertyKey = (
    fmtid : '{827EDB4F-5B73-44A7-891D-FDFFABEA35CA}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_Altitude}

//  Name:     System.GPS.AltitudeDenominator -- PKEY_GPS_AltitudeDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {78342DCB-E358-4145-AE9A-6BFE4E0F9F51}, 100
//
//  Denominator of PKEY_GPS_Altitude
  PKEY_GPS_AltitudeDenominator : TPropertyKey = (
    fmtid : '{78342DCB-E358-4145-AE9A-6BFE4E0F9F51}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_AltitudeDenominator}

//  Name:     System.GPS.AltitudeNumerator -- PKEY_GPS_AltitudeNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {2DAD1EB7-816D-40D3-9EC3-C9773BE2AADE}, 100
//
//  Numerator of PKEY_GPS_Altitude
  PKEY_GPS_AltitudeNumerator : TPropertyKey = (
    fmtid : '{2DAD1EB7-816D-40D3-9EC3-C9773BE2AADE}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_AltitudeNumerator}

//  Name:     System.GPS.AltitudeRef -- PKEY_GPS_AltitudeRef
//  Type:     Byte -- VT_UI1
//  FormatID: {46AC629D-75EA-4515-867F-6DC4321C5844}, 100
//
//  Indicates the reference for the altitude property. (eg: above sea level, below sea level, absolute value)
  PKEY_GPS_AltitudeRef : TPropertyKey = (
    fmtid : '{46AC629D-75EA-4515-867F-6DC4321C5844}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_AltitudeRef}

//  Name:     System.GPS.AreaInformation -- PKEY_GPS_AreaInformation
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {972E333E-AC7E-49F1-8ADF-A70D07A9BCAB}, 100
//
//  Represents the name of the GPS area
  PKEY_GPS_AreaInformation : TPropertyKey = (
    fmtid : '{972E333E-AC7E-49F1-8ADF-A70D07A9BCAB}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_AreaInformation}

//  Name:     System.GPS.Date -- PKEY_GPS_Date
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {3602C812-0F3B-45F0-85AD-603468D69423}, 100
//
//  Date and time of the GPS record
  PKEY_GPS_Date : TPropertyKey = (
    fmtid : '{3602C812-0F3B-45F0-85AD-603468D69423}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_Date}

//  Name:     System.GPS.DestBearing -- PKEY_GPS_DestBearing
//  Type:     Double -- VT_R8
//  FormatID: {C66D4B3C-E888-47CC-B99F-9DCA3EE34DEA}, 100
//  
//  Indicates the bearing to the destination point.  Calculated from PKEY_GPS_DestBearingNumerator and 
//  PKEY_GPS_DestBearingDenominator.
  PKEY_GPS_DestBearing : TPropertyKey = (
    fmtid : '{C66D4B3C-E888-47CC-B99F-9DCA3EE34DEA}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestBearing}

//  Name:     System.GPS.DestBearingDenominator -- PKEY_GPS_DestBearingDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {7ABCF4F8-7C3F-4988-AC91-8D2C2E97ECA5}, 100
//
//  Denominator of PKEY_GPS_DestBearing
  PKEY_GPS_DestBearingDenominator : TPropertyKey = (
    fmtid : '{7ABCF4F8-7C3F-4988-AC91-8D2C2E97ECA5}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestBearingDenominator}

//  Name:     System.GPS.DestBearingNumerator -- PKEY_GPS_DestBearingNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {BA3B1DA9-86EE-4B5D-A2A4-A271A429F0CF}, 100
//
//  Numerator of PKEY_GPS_DestBearing
  PKEY_GPS_DestBearingNumerator : TPropertyKey = (
    fmtid : '{BA3B1DA9-86EE-4B5D-A2A4-A271A429F0CF}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestBearingNumerator}

//  Name:     System.GPS.DestBearingRef -- PKEY_GPS_DestBearingRef
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {9AB84393-2A0F-4B75-BB22-7279786977CB}, 100
//
//  Indicates the reference used for the giving the bearing to the destination point.  (eg: true direction, magnetic direction)
  PKEY_GPS_DestBearingRef : TPropertyKey = (
    fmtid : '{9AB84393-2A0F-4B75-BB22-7279786977CB}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestBearingRef}

//  Name:     System.GPS.DestDistance -- PKEY_GPS_DestDistance
//  Type:     Double -- VT_R8
//  FormatID: {A93EAE04-6804-4F24-AC81-09B266452118}, 100
//  
//  Indicates the distance to the destination point.  Calculated from PKEY_GPS_DestDistanceNumerator and 
//  PKEY_GPS_DestDistanceDenominator.
  PKEY_GPS_DestDistance : TPropertyKey = (
    fmtid : '{A93EAE04-6804-4F24-AC81-09B266452118}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestDistance}

//  Name:     System.GPS.DestDistanceDenominator -- PKEY_GPS_DestDistanceDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {9BC2C99B-AC71-4127-9D1C-2596D0D7DCB7}, 100
//
//  Denominator of PKEY_GPS_DestDistance
  PKEY_GPS_DestDistanceDenominator : TPropertyKey = (
    fmtid : '{9BC2C99B-AC71-4127-9D1C-2596D0D7DCB7}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestDistanceDenominator}

//  Name:     System.GPS.DestDistanceNumerator -- PKEY_GPS_DestDistanceNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {2BDA47DA-08C6-4FE1-80BC-A72FC517C5D0}, 100
//
//  Numerator of PKEY_GPS_DestDistance
  PKEY_GPS_DestDistanceNumerator : TPropertyKey = (
    fmtid : '{2BDA47DA-08C6-4FE1-80BC-A72FC517C5D0}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestDistanceNumerator}

//  Name:     System.GPS.DestDistanceRef -- PKEY_GPS_DestDistanceRef
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {ED4DF2D3-8695-450B-856F-F5C1C53ACB66}, 100
//
//  Indicates the unit used to express the distance to the destination.  (eg: kilometers, miles, knots)
  PKEY_GPS_DestDistanceRef : TPropertyKey = (
    fmtid : '{ED4DF2D3-8695-450B-856F-F5C1C53ACB66}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestDistanceRef}

//  Name:     System.GPS.DestLatitude -- PKEY_GPS_DestLatitude
//  Type:     Multivalue Double -- VT_VECTOR | VT_R8  (For variants: VT_ARRAY | VT_R8)
//  FormatID: {9D1D7CC5-5C39-451C-86B3-928E2D18CC47}, 100
//  
//  Indicates the latitude of the destination point.  This is an array of three values.  Index 0 is the degrees, index 1 
//  is the minutes, index 2 is the seconds.  Each is calculated from the values in PKEY_GPS_DestLatitudeNumerator and 
//  PKEY_GPS_DestLatitudeDenominator.
  PKEY_GPS_DestLatitude : TPropertyKey = (
    fmtid : '{9D1D7CC5-5C39-451C-86B3-928E2D18CC47}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestLatitude}

//  Name:     System.GPS.DestLatitudeDenominator -- PKEY_GPS_DestLatitudeDenominator
//  Type:     Multivalue UInt32 -- VT_VECTOR | VT_UI4  (For variants: VT_ARRAY | VT_UI4)
//  FormatID: {3A372292-7FCA-49A7-99D5-E47BB2D4E7AB}, 100
//
//  Denominator of PKEY_GPS_DestLatitude
  PKEY_GPS_DestLatitudeDenominator : TPropertyKey = (
    fmtid : '{3A372292-7FCA-49A7-99D5-E47BB2D4E7AB}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestLatitudeDenominator}

//  Name:     System.GPS.DestLatitudeNumerator -- PKEY_GPS_DestLatitudeNumerator
//  Type:     Multivalue UInt32 -- VT_VECTOR | VT_UI4  (For variants: VT_ARRAY | VT_UI4)
//  FormatID: {ECF4B6F6-D5A6-433C-BB92-4076650FC890}, 100
//
//  Numerator of PKEY_GPS_DestLatitude
  PKEY_GPS_DestLatitudeNumerator : TPropertyKey = (
    fmtid : '{ECF4B6F6-D5A6-433C-BB92-4076650FC890}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestLatitudeNumerator}

//  Name:     System.GPS.DestLatitudeRef -- PKEY_GPS_DestLatitudeRef
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {CEA820B9-CE61-4885-A128-005D9087C192}, 100
//
//  Indicates whether the latitude destination point is north or south latitude
  PKEY_GPS_DestLatitudeRef : TPropertyKey = (
    fmtid : '{CEA820B9-CE61-4885-A128-005D9087C192}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestLatitudeRef}

//  Name:     System.GPS.DestLongitude -- PKEY_GPS_DestLongitude
//  Type:     Multivalue Double -- VT_VECTOR | VT_R8  (For variants: VT_ARRAY | VT_R8)
//  FormatID: {47A96261-CB4C-4807-8AD3-40B9D9DBC6BC}, 100
//  
//  Indicates the latitude of the destination point.  This is an array of three values.  Index 0 is the degrees, index 1 
//  is the minutes, index 2 is the seconds.  Each is calculated from the values in PKEY_GPS_DestLongitudeNumerator and 
//  PKEY_GPS_DestLongitudeDenominator.
  PKEY_GPS_DestLongitude : TPropertyKey = (
    fmtid : '{47A96261-CB4C-4807-8AD3-40B9D9DBC6BC}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestLongitude}

//  Name:     System.GPS.DestLongitudeDenominator -- PKEY_GPS_DestLongitudeDenominator
//  Type:     Multivalue UInt32 -- VT_VECTOR | VT_UI4  (For variants: VT_ARRAY | VT_UI4)
//  FormatID: {425D69E5-48AD-4900-8D80-6EB6B8D0AC86}, 100
//
//  Denominator of PKEY_GPS_DestLongitude
  PKEY_GPS_DestLongitudeDenominator : TPropertyKey = (
    fmtid : '{425D69E5-48AD-4900-8D80-6EB6B8D0AC86}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestLongitudeDenominator}

//  Name:     System.GPS.DestLongitudeNumerator -- PKEY_GPS_DestLongitudeNumerator
//  Type:     Multivalue UInt32 -- VT_VECTOR | VT_UI4  (For variants: VT_ARRAY | VT_UI4)
//  FormatID: {A3250282-FB6D-48D5-9A89-DBCACE75CCCF}, 100
//
//  Numerator of PKEY_GPS_DestLongitude
  PKEY_GPS_DestLongitudeNumerator : TPropertyKey = (
    fmtid : '{A3250282-FB6D-48D5-9A89-DBCACE75CCCF}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestLongitudeNumerator}

//  Name:     System.GPS.DestLongitudeRef -- PKEY_GPS_DestLongitudeRef
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {182C1EA6-7C1C-4083-AB4B-AC6C9F4ED128}, 100
//
//  Indicates whether the longitude destination point is east or west longitude
  PKEY_GPS_DestLongitudeRef : TPropertyKey = (
    fmtid : '{182C1EA6-7C1C-4083-AB4B-AC6C9F4ED128}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DestLongitudeRef}

//  Name:     System.GPS.Differential -- PKEY_GPS_Differential
//  Type:     UInt16 -- VT_UI2
//  FormatID: {AAF4EE25-BD3B-4DD7-BFC4-47F77BB00F6D}, 100
//
//  Indicates whether differential correction was applied to the GPS receiver
  PKEY_GPS_Differential : TPropertyKey = (
    fmtid : '{AAF4EE25-BD3B-4DD7-BFC4-47F77BB00F6D}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_Differential}

//  Name:     System.GPS.DOP -- PKEY_GPS_DOP
//  Type:     Double -- VT_R8
//  FormatID: {0CF8FB02-1837-42F1-A697-A7017AA289B9}, 100
//
//  Indicates the GPS DOP (data degree of precision).  Calculated from PKEY_GPS_DOPNumerator and PKEY_GPS_DOPDenominator
  PKEY_GPS_DOP : TPropertyKey = (
    fmtid : '{0CF8FB02-1837-42F1-A697-A7017AA289B9}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DOP}

//  Name:     System.GPS.DOPDenominator -- PKEY_GPS_DOPDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {A0BE94C5-50BA-487B-BD35-0654BE8881ED}, 100
//
//  Denominator of PKEY_GPS_DOP
  PKEY_GPS_DOPDenominator : TPropertyKey = (
    fmtid : '{A0BE94C5-50BA-487B-BD35-0654BE8881ED}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DOPDenominator}

//  Name:     System.GPS.DOPNumerator -- PKEY_GPS_DOPNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {47166B16-364F-4AA0-9F31-E2AB3DF449C3}, 100
//
//  Numerator of PKEY_GPS_DOP
  PKEY_GPS_DOPNumerator : TPropertyKey = (
    fmtid : '{47166B16-364F-4AA0-9F31-E2AB3DF449C3}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_DOPNumerator}

//  Name:     System.GPS.ImgDirection -- PKEY_GPS_ImgDirection
//  Type:     Double -- VT_R8
//  FormatID: {16473C91-D017-4ED9-BA4D-B6BAA55DBCF8}, 100
//  
//  Indicates direction of the image when it was captured.  Calculated from PKEY_GPS_ImgDirectionNumerator and 
//  PKEY_GPS_ImgDirectionDenominator.
  PKEY_GPS_ImgDirection : TPropertyKey = (
    fmtid : '{16473C91-D017-4ED9-BA4D-B6BAA55DBCF8}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_ImgDirection}

//  Name:     System.GPS.ImgDirectionDenominator -- PKEY_GPS_ImgDirectionDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {10B24595-41A2-4E20-93C2-5761C1395F32}, 100
//
//  Denominator of PKEY_GPS_ImgDirection
  PKEY_GPS_ImgDirectionDenominator : TPropertyKey = (
    fmtid : '{10B24595-41A2-4E20-93C2-5761C1395F32}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_ImgDirectionDenominator}

//  Name:     System.GPS.ImgDirectionNumerator -- PKEY_GPS_ImgDirectionNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {DC5877C7-225F-45F7-BAC7-E81334B6130A}, 100
//
//  Numerator of PKEY_GPS_ImgDirection
  PKEY_GPS_ImgDirectionNumerator : TPropertyKey = (
    fmtid : '{DC5877C7-225F-45F7-BAC7-E81334B6130A}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_ImgDirectionNumerator}

//  Name:     System.GPS.ImgDirectionRef -- PKEY_GPS_ImgDirectionRef
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {A4AAA5B7-1AD0-445F-811A-0F8F6E67F6B5}, 100
//
//  Indicates reference for giving the direction of the image when it was captured.  (eg: true direction, magnetic direction)
  PKEY_GPS_ImgDirectionRef : TPropertyKey = (
    fmtid : '{A4AAA5B7-1AD0-445F-811A-0F8F6E67F6B5}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_ImgDirectionRef}

//  Name:     System.GPS.Latitude -- PKEY_GPS_Latitude
//  Type:     Multivalue Double -- VT_VECTOR | VT_R8  (For variants: VT_ARRAY | VT_R8)
//  FormatID: {8727CFFF-4868-4EC6-AD5B-81B98521D1AB}, 100
//  
//  Indicates the latitude.  This is an array of three values.  Index 0 is the degrees, index 1 is the minutes, index 2 
//  is the seconds.  Each is calculated from the values in PKEY_GPS_LatitudeNumerator and PKEY_GPS_LatitudeDenominator.
  PKEY_GPS_Latitude : TPropertyKey = (
    fmtid : '{8727CFFF-4868-4EC6-AD5B-81B98521D1AB}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_Latitude}

//  Name:     System.GPS.LatitudeDenominator -- PKEY_GPS_LatitudeDenominator
//  Type:     Multivalue UInt32 -- VT_VECTOR | VT_UI4  (For variants: VT_ARRAY | VT_UI4)
//  FormatID: {16E634EE-2BFF-497B-BD8A-4341AD39EEB9}, 100
//
//  Denominator of PKEY_GPS_Latitude
  PKEY_GPS_LatitudeDenominator : TPropertyKey = (
    fmtid : '{16E634EE-2BFF-497B-BD8A-4341AD39EEB9}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_LatitudeDenominator}

//  Name:     System.GPS.LatitudeNumerator -- PKEY_GPS_LatitudeNumerator
//  Type:     Multivalue UInt32 -- VT_VECTOR | VT_UI4  (For variants: VT_ARRAY | VT_UI4)
//  FormatID: {7DDAAAD1-CCC8-41AE-B750-B2CB8031AEA2}, 100
//
//  Numerator of PKEY_GPS_Latitude
  PKEY_GPS_LatitudeNumerator : TPropertyKey = (
    fmtid : '{7DDAAAD1-CCC8-41AE-B750-B2CB8031AEA2}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_LatitudeNumerator}

//  Name:     System.GPS.LatitudeRef -- PKEY_GPS_LatitudeRef
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {029C0252-5B86-46C7-ACA0-2769FFC8E3D4}, 100
//
//  Indicates whether latitude is north or south latitude 
  PKEY_GPS_LatitudeRef : TPropertyKey = (
    fmtid : '{029C0252-5B86-46C7-ACA0-2769FFC8E3D4}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_LatitudeRef}

//  Name:     System.GPS.Longitude -- PKEY_GPS_Longitude
//  Type:     Multivalue Double -- VT_VECTOR | VT_R8  (For variants: VT_ARRAY | VT_R8)
//  FormatID: {C4C4DBB2-B593-466B-BBDA-D03D27D5E43A}, 100
//  
//  Indicates the longitude.  This is an array of three values.  Index 0 is the degrees, index 1 is the minutes, index 2 
//  is the seconds.  Each is calculated from the values in PKEY_GPS_LongitudeNumerator and PKEY_GPS_LongitudeDenominator.
  PKEY_GPS_Longitude : TPropertyKey = (
    fmtid : '{C4C4DBB2-B593-466B-BBDA-D03D27D5E43A}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_Longitude}

//  Name:     System.GPS.LongitudeDenominator -- PKEY_GPS_LongitudeDenominator
//  Type:     Multivalue UInt32 -- VT_VECTOR | VT_UI4  (For variants: VT_ARRAY | VT_UI4)
//  FormatID: {BE6E176C-4534-4D2C-ACE5-31DEDAC1606B}, 100
//
//  Denominator of PKEY_GPS_Longitude
  PKEY_GPS_LongitudeDenominator : TPropertyKey = (
    fmtid : '{BE6E176C-4534-4D2C-ACE5-31DEDAC1606B}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_LongitudeDenominator}

//  Name:     System.GPS.LongitudeNumerator -- PKEY_GPS_LongitudeNumerator
//  Type:     Multivalue UInt32 -- VT_VECTOR | VT_UI4  (For variants: VT_ARRAY | VT_UI4)
//  FormatID: {02B0F689-A914-4E45-821D-1DDA452ED2C4}, 100
//
//  Numerator of PKEY_GPS_Longitude
  PKEY_GPS_LongitudeNumerator : TPropertyKey = (
    fmtid : '{02B0F689-A914-4E45-821D-1DDA452ED2C4}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_LongitudeNumerator}

//  Name:     System.GPS.LongitudeRef -- PKEY_GPS_LongitudeRef
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {33DCF22B-28D5-464C-8035-1EE9EFD25278}, 100
//
//  Indicates whether longitude is east or west longitude
  PKEY_GPS_LongitudeRef : TPropertyKey = (
    fmtid : '{33DCF22B-28D5-464C-8035-1EE9EFD25278}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_LongitudeRef}

//  Name:     System.GPS.MapDatum -- PKEY_GPS_MapDatum
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {2CA2DAE6-EDDC-407D-BEF1-773942ABFA95}, 100
//
//  Indicates the geodetic survey data used by the GPS receiver
  PKEY_GPS_MapDatum : TPropertyKey = (
    fmtid : '{2CA2DAE6-EDDC-407D-BEF1-773942ABFA95}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_MapDatum}

//  Name:     System.GPS.MeasureMode -- PKEY_GPS_MeasureMode
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {A015ED5D-AAEA-4D58-8A86-3C586920EA0B}, 100
//
//  Indicates the GPS measurement mode.  (eg: 2-dimensional, 3-dimensional)
  PKEY_GPS_MeasureMode : TPropertyKey = (
    fmtid : '{A015ED5D-AAEA-4D58-8A86-3C586920EA0B}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_MeasureMode}

//  Name:     System.GPS.ProcessingMethod -- PKEY_GPS_ProcessingMethod
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {59D49E61-840F-4AA9-A939-E2099B7F6399}, 100
//
//  Indicates the name of the method used for location finding
  PKEY_GPS_ProcessingMethod : TPropertyKey = (
    fmtid : '{59D49E61-840F-4AA9-A939-E2099B7F6399}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_ProcessingMethod}

//  Name:     System.GPS.Satellites -- PKEY_GPS_Satellites
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {467EE575-1F25-4557-AD4E-B8B58B0D9C15}, 100
//
//  Indicates the GPS satellites used for measurements
  PKEY_GPS_Satellites : TPropertyKey = (
    fmtid : '{467EE575-1F25-4557-AD4E-B8B58B0D9C15}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_Satellites}

//  Name:     System.GPS.Speed -- PKEY_GPS_Speed
//  Type:     Double -- VT_R8
//  FormatID: {DA5D0862-6E76-4E1B-BABD-70021BD25494}, 100
//  
//  Indicates the speed of the GPS receiver movement.  Calculated from PKEY_GPS_SpeedNumerator and 
//  PKEY_GPS_SpeedDenominator.
  PKEY_GPS_Speed : TPropertyKey = (
    fmtid : '{DA5D0862-6E76-4E1B-BABD-70021BD25494}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_Speed}

//  Name:     System.GPS.SpeedDenominator -- PKEY_GPS_SpeedDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {7D122D5A-AE5E-4335-8841-D71E7CE72F53}, 100
//
//  Denominator of PKEY_GPS_Speed
  PKEY_GPS_SpeedDenominator : TPropertyKey = (
    fmtid : '{7D122D5A-AE5E-4335-8841-D71E7CE72F53}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_SpeedDenominator}

//  Name:     System.GPS.SpeedNumerator -- PKEY_GPS_SpeedNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {ACC9CE3D-C213-4942-8B48-6D0820F21C6D}, 100
//
//  Numerator of PKEY_GPS_Speed
  PKEY_GPS_SpeedNumerator : TPropertyKey = (
    fmtid : '{ACC9CE3D-C213-4942-8B48-6D0820F21C6D}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_SpeedNumerator}

//  Name:     System.GPS.SpeedRef -- PKEY_GPS_SpeedRef
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {ECF7F4C9-544F-4D6D-9D98-8AD79ADAF453}, 100
//  
//  Indicates the unit used to express the speed of the GPS receiver movement.  (eg: kilometers per hour, 
//  miles per hour, knots).
  PKEY_GPS_SpeedRef : TPropertyKey = (
    fmtid : '{ECF7F4C9-544F-4D6D-9D98-8AD79ADAF453}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_SpeedRef}

//  Name:     System.GPS.Status -- PKEY_GPS_Status
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {125491F4-818F-46B2-91B5-D537753617B2}, 100
//  
//  Indicates the status of the GPS receiver when the image was recorded.  (eg: measurement in progress, 
//  measurement interoperability).
  PKEY_GPS_Status : TPropertyKey = (
    fmtid : '{125491F4-818F-46B2-91B5-D537753617B2}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_Status}

//  Name:     System.GPS.Track -- PKEY_GPS_Track
//  Type:     Double -- VT_R8
//  FormatID: {76C09943-7C33-49E3-9E7E-CDBA872CFADA}, 100
//  
//  Indicates the direction of the GPS receiver movement.  Calculated from PKEY_GPS_TrackNumerator and 
//  PKEY_GPS_TrackDenominator.
  PKEY_GPS_Track : TPropertyKey = (
    fmtid : '{76C09943-7C33-49E3-9E7E-CDBA872CFADA}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_Track}

//  Name:     System.GPS.TrackDenominator -- PKEY_GPS_TrackDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {C8D1920C-01F6-40C0-AC86-2F3A4AD00770}, 100
//
//  Denominator of PKEY_GPS_Track
  PKEY_GPS_TrackDenominator : TPropertyKey = (
    fmtid : '{C8D1920C-01F6-40C0-AC86-2F3A4AD00770}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_TrackDenominator}

//  Name:     System.GPS.TrackNumerator -- PKEY_GPS_TrackNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {702926F4-44A6-43E1-AE71-45627116893B}, 100
//
//  Numerator of PKEY_GPS_Track
  PKEY_GPS_TrackNumerator : TPropertyKey = (
    fmtid : '{702926F4-44A6-43E1-AE71-45627116893B}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_TrackNumerator}

//  Name:     System.GPS.TrackRef -- PKEY_GPS_TrackRef
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {35DBE6FE-44C3-4400-AAAE-D2C799C407E8}, 100
//
//  Indicates reference for the direction of the GPS receiver movement.  (eg: true direction, magnetic direction)
  PKEY_GPS_TrackRef : TPropertyKey = (
    fmtid : '{35DBE6FE-44C3-4400-AAAE-D2C799C407E8}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_TrackRef}

//  Name:     System.GPS.VersionID -- PKEY_GPS_VersionID
//  Type:     Buffer -- VT_VECTOR | VT_UI1  (For variants: VT_ARRAY | VT_UI1)
//  FormatID: {22704DA4-C6B2-4A99-8E56-F16DF8C92599}, 100
//
//  Indicates the version of the GPS information
  PKEY_GPS_VersionID : TPropertyKey = (
    fmtid : '{22704DA4-C6B2-4A99-8E56-F16DF8C92599}'; pid : 100);
  {$EXTERNALSYM PKEY_GPS_VersionID}
 
//-----------------------------------------------------------------------------
// Image properties



//  Name:     System.Image.BitDepth -- PKEY_Image_BitDepth
//  Type:     UInt32 -- VT_UI4
//  FormatID: (PSGUID_IMAGESUMMARYINFORMATION) {6444048F-4C8B-11D1-8B70-080036B11A03}, 7 (PIDISI_BITDEPTH)
//
//  
  PKEY_Image_BitDepth : TPropertyKey = (
    fmtid : '{6444048F-4C8B-11D1-8B70-080036B11A03}'; pid : 7);
  {$EXTERNALSYM PKEY_Image_BitDepth}

//  Name:     System.Image.ColorSpace -- PKEY_Image_ColorSpace
//  Type:     UInt16 -- VT_UI2
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 40961
//
//  PropertyTagExifColorSpace
  PKEY_Image_ColorSpace : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 40961);
  {$EXTERNALSYM PKEY_Image_ColorSpace}

// Possible discrete values for PKEY_Image_ColorSpace are:
  IMAGE_COLORSPACE_SRGB =                1;
  {$EXTERNALSYM IMAGE_COLORSPACE_SRGB}
  IMAGE_COLORSPACE_UNCALIBRATED =        $FFFF;
  {$EXTERNALSYM IMAGE_COLORSPACE_UNCALIBRATED}

//  Name:     System.Image.CompressedBitsPerPixel -- PKEY_Image_CompressedBitsPerPixel
//  Type:     Double -- VT_R8
//  FormatID: {364B6FA9-37AB-482A-BE2B-AE02F60D4318}, 100
//
//  Calculated from PKEY_Image_CompressedBitsPerPixelNumerator and PKEY_Image_CompressedBitsPerPixelDenominator.
  PKEY_Image_CompressedBitsPerPixel : TPropertyKey = (
    fmtid : '{364B6FA9-37AB-482A-BE2B-AE02F60D4318}'; pid : 100);
  {$EXTERNALSYM PKEY_Image_CompressedBitsPerPixel}

//  Name:     System.Image.CompressedBitsPerPixelDenominator -- PKEY_Image_CompressedBitsPerPixelDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {1F8844E1-24AD-4508-9DFD-5326A415CE02}, 100
//
//  Denominator of PKEY_Image_CompressedBitsPerPixel.
  PKEY_Image_CompressedBitsPerPixelDenominator : TPropertyKey = (
    fmtid : '{1F8844E1-24AD-4508-9DFD-5326A415CE02}'; pid : 100);
  {$EXTERNALSYM PKEY_Image_CompressedBitsPerPixelDenominator}

//  Name:     System.Image.CompressedBitsPerPixelNumerator -- PKEY_Image_CompressedBitsPerPixelNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {D21A7148-D32C-4624-8900-277210F79C0F}, 100
//
//  Numerator of PKEY_Image_CompressedBitsPerPixel.
  PKEY_Image_CompressedBitsPerPixelNumerator : TPropertyKey = (
    fmtid : '{D21A7148-D32C-4624-8900-277210F79C0F}'; pid : 100);
  {$EXTERNALSYM PKEY_Image_CompressedBitsPerPixelNumerator}

//  Name:     System.Image.Compression -- PKEY_Image_Compression
//  Type:     UInt16 -- VT_UI2
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 259
//
//  Indicates the image compression level.  PropertyTagCompression.
  PKEY_Image_Compression : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 259);
  {$EXTERNALSYM PKEY_Image_Compression}

// Possible discrete values for PKEY_Image_Compression are:
  IMAGE_COMPRESSION_UNCOMPRESSED =       1;
  {$EXTERNALSYM IMAGE_COMPRESSION_UNCOMPRESSED}
  IMAGE_COMPRESSION_CCITT_T3 =           2;
  {$EXTERNALSYM IMAGE_COMPRESSION_CCITT_T3}
  IMAGE_COMPRESSION_CCITT_T4 =           3;
  {$EXTERNALSYM IMAGE_COMPRESSION_CCITT_T4}
  IMAGE_COMPRESSION_CCITT_T6 =           4;
  {$EXTERNALSYM IMAGE_COMPRESSION_CCITT_T6}
  IMAGE_COMPRESSION_LZW =                5;
  {$EXTERNALSYM IMAGE_COMPRESSION_LZW}
  IMAGE_COMPRESSION_JPEG =               6;
  {$EXTERNALSYM IMAGE_COMPRESSION_JPEG}
  IMAGE_COMPRESSION_PACKBITS =           32773;
  {$EXTERNALSYM IMAGE_COMPRESSION_PACKBITS}

//  Name:     System.Image.CompressionText -- PKEY_Image_CompressionText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {3F08E66F-2F44-4BB9-A682-AC35D2562322}, 100
//  
//  This is the user-friendly form of System.Image.Compression.  Not intended to be parsed 
//  programmatically.
  PKEY_Image_CompressionText : TPropertyKey = (
    fmtid : '{3F08E66F-2F44-4BB9-A682-AC35D2562322}'; pid : 100);
  {$EXTERNALSYM PKEY_Image_CompressionText}

//  Name:     System.Image.Dimensions -- PKEY_Image_Dimensions
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_IMAGESUMMARYINFORMATION) {6444048F-4C8B-11D1-8B70-080036B11A03}, 13 (PIDISI_DIMENSIONS)
//
//  Indicates the dimensions of the image.
  PKEY_Image_Dimensions : TPropertyKey = (
    fmtid : '{6444048F-4C8B-11D1-8B70-080036B11A03}'; pid : 13);
  {$EXTERNALSYM PKEY_Image_Dimensions}

//  Name:     System.Image.HorizontalResolution -- PKEY_Image_HorizontalResolution
//  Type:     Double -- VT_R8
//  FormatID: (PSGUID_IMAGESUMMARYINFORMATION) {6444048F-4C8B-11D1-8B70-080036B11A03}, 5 (PIDISI_RESOLUTIONX)
//
//  
  PKEY_Image_HorizontalResolution : TPropertyKey = (
    fmtid : '{6444048F-4C8B-11D1-8B70-080036B11A03}'; pid : 5);
  {$EXTERNALSYM PKEY_Image_HorizontalResolution}

//  Name:     System.Image.HorizontalSize -- PKEY_Image_HorizontalSize
//  Type:     UInt32 -- VT_UI4
//  FormatID: (PSGUID_IMAGESUMMARYINFORMATION) {6444048F-4C8B-11D1-8B70-080036B11A03}, 3 (PIDISI_CX)
//
//  
  PKEY_Image_HorizontalSize : TPropertyKey = (
    fmtid : '{6444048F-4C8B-11D1-8B70-080036B11A03}'; pid : 3);
  {$EXTERNALSYM PKEY_Image_HorizontalSize}

//  Name:     System.Image.ImageID -- PKEY_Image_ImageID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {10DABE05-32AA-4C29-BF1A-63E2D220587F}, 100
  PKEY_Image_ImageID : TPropertyKey = (
    fmtid : '{10DABE05-32AA-4C29-BF1A-63E2D220587F}'; pid : 100);
  {$EXTERNALSYM PKEY_Image_ImageID}

//  Name:     System.Image.ResolutionUnit -- PKEY_Image_ResolutionUnit
//  Type:     Int16 -- VT_I2
//  FormatID: {19B51FA6-1F92-4A5C-AB48-7DF0ABD67444}, 100
  PKEY_Image_ResolutionUnit : TPropertyKey = (
    fmtid : '{19B51FA6-1F92-4A5C-AB48-7DF0ABD67444}'; pid : 100);
  {$EXTERNALSYM PKEY_Image_ResolutionUnit}

//  Name:     System.Image.VerticalResolution -- PKEY_Image_VerticalResolution
//  Type:     Double -- VT_R8
//  FormatID: (PSGUID_IMAGESUMMARYINFORMATION) {6444048F-4C8B-11D1-8B70-080036B11A03}, 6 (PIDISI_RESOLUTIONY)
//
//  
  PKEY_Image_VerticalResolution : TPropertyKey = (
    fmtid : '{6444048F-4C8B-11D1-8B70-080036B11A03}'; pid : 6);
  {$EXTERNALSYM PKEY_Image_VerticalResolution}

//  Name:     System.Image.VerticalSize -- PKEY_Image_VerticalSize
//  Type:     UInt32 -- VT_UI4
//  FormatID: (PSGUID_IMAGESUMMARYINFORMATION) {6444048F-4C8B-11D1-8B70-080036B11A03}, 4 (PIDISI_CY)
//
//  
  PKEY_Image_VerticalSize : TPropertyKey = (
    fmtid : '{6444048F-4C8B-11D1-8B70-080036B11A03}'; pid : 4);
  {$EXTERNALSYM PKEY_Image_VerticalSize}

 
 
//-----------------------------------------------------------------------------
// Journal properties

//  Name:     System.Journal.Contacts -- PKEY_Journal_Contacts
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {DEA7C82C-1D89-4A66-9427-A4E3DEBABCB1}, 100
  PKEY_Journal_Contacts : TPropertyKey = (
    fmtid : '{DEA7C82C-1D89-4A66-9427-A4E3DEBABCB1}'; pid : 100);
  {$EXTERNALSYM PKEY_Journal_Contacts}

//  Name:     System.Journal.EntryType -- PKEY_Journal_EntryType
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {95BEB1FC-326D-4644-B396-CD3ED90E6DDF}, 100
  PKEY_Journal_EntryType : TPropertyKey = (
    fmtid : '{95BEB1FC-326D-4644-B396-CD3ED90E6DDF}'; pid : 100);
  {$EXTERNALSYM PKEY_Journal_EntryType}
 
//-----------------------------------------------------------------------------
// LayoutPattern properties



//  Name:     System.LayoutPattern.ContentViewModeForBrowse -- PKEY_LayoutPattern_ContentViewModeForBrowse
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 500
//  
//  Specifies the layout pattern that the content view mode should apply for this item in the context of browsing.
//  Register the regvalue under the name of "ContentViewModeLayoutPatternForBrowse".
  PKEY_LayoutPattern_ContentViewModeForBrowse : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 500);
  {$EXTERNALSYM PKEY_LayoutPattern_ContentViewModeForBrowse}

// Possible discrete values for PKEY_LayoutPattern_ContentViewModeForBrowse are:
  LAYOUTPATTERN_CVMFB_ALPHA =            'alpha';
  {$EXTERNALSYM LAYOUTPATTERN_CVMFB_ALPHA}
  LAYOUTPATTERN_CVMFB_BETA =             'beta';
  {$EXTERNALSYM LAYOUTPATTERN_CVMFB_BETA}
  LAYOUTPATTERN_CVMFB_GAMMA =            'gamma';
  {$EXTERNALSYM LAYOUTPATTERN_CVMFB_GAMMA}
  LAYOUTPATTERN_CVMFB_DELTA =            'delta';
  {$EXTERNALSYM LAYOUTPATTERN_CVMFB_DELTA}
  LAYOUTPATTERN_CVMFB_EPSILON =          'epsilon';
  {$EXTERNALSYM LAYOUTPATTERN_CVMFB_EPSILON}

//  Name:     System.LayoutPattern.ContentViewModeForSearch -- PKEY_LayoutPattern_ContentViewModeForSearch
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 501
//  
//  Specifies the layout pattern that the content view mode should apply for this item in the context of searching.
//  Register the regvalue under the name of "ContentViewModeLayoutPatternForSearch".
  PKEY_LayoutPattern_ContentViewModeForSearch : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 501);
  {$EXTERNALSYM PKEY_LayoutPattern_ContentViewModeForSearch}

// Possible discrete values for PKEY_LayoutPattern_ContentViewModeForSearch are:
  LAYOUTPATTERN_CVMFS_ALPHA =            'alpha';
  {$EXTERNALSYM LAYOUTPATTERN_CVMFS_ALPHA}
  LAYOUTPATTERN_CVMFS_BETA =             'beta';
  {$EXTERNALSYM LAYOUTPATTERN_CVMFS_BETA}
  LAYOUTPATTERN_CVMFS_GAMMA =            'gamma';
  {$EXTERNALSYM LAYOUTPATTERN_CVMFS_GAMMA}
  LAYOUTPATTERN_CVMFS_DELTA =            'delta';
  {$EXTERNALSYM LAYOUTPATTERN_CVMFS_DELTA}
  LAYOUTPATTERN_CVMFS_EPSILON =          'epsilon';
  {$EXTERNALSYM LAYOUTPATTERN_CVMFS_EPSILON}
 
//-----------------------------------------------------------------------------
// Link properties



//  Name:     System.Link.Arguments -- PKEY_Link_Arguments
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {436F2667-14E2-4FEB-B30A-146C53B5B674}, 100
  PKEY_Link_Arguments : TPropertyKey = (
    fmtid : '{436F2667-14E2-4FEB-B30A-146C53B5B674}'; pid : 100);
  {$EXTERNALSYM PKEY_Link_Arguments}

//  Name:     System.Link.Comment -- PKEY_Link_Comment
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_LINK) {B9B4B3FC-2B51-4A42-B5D8-324146AFCF25}, 5
  PKEY_Link_Comment : TPropertyKey = (
    fmtid : '{B9B4B3FC-2B51-4A42-B5D8-324146AFCF25}'; pid : 5);
  {$EXTERNALSYM PKEY_Link_Comment}

//  Name:     System.Link.DateVisited -- PKEY_Link_DateVisited
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {5CBF2787-48CF-4208-B90E-EE5E5D420294}, 23  (PKEYs relating to URLs.  Used by IE History.)
  PKEY_Link_DateVisited : TPropertyKey = (
    fmtid : '{5CBF2787-48CF-4208-B90E-EE5E5D420294}'; pid : 23);
  {$EXTERNALSYM PKEY_Link_DateVisited}

//  Name:     System.Link.Description -- PKEY_Link_Description
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {5CBF2787-48CF-4208-B90E-EE5E5D420294}, 21  (PKEYs relating to URLs.  Used by IE History.)
  PKEY_Link_Description : TPropertyKey = (
    fmtid : '{5CBF2787-48CF-4208-B90E-EE5E5D420294}'; pid : 21);
  {$EXTERNALSYM PKEY_Link_Description}

//  Name:     System.Link.Status -- PKEY_Link_Status
//  Type:     Int32 -- VT_I4
//  FormatID: (PSGUID_LINK) {B9B4B3FC-2B51-4A42-B5D8-324146AFCF25}, 3 (PID_LINK_TARGET_TYPE)
//
//  
  PKEY_Link_Status : TPropertyKey = (
    fmtid : '{B9B4B3FC-2B51-4A42-B5D8-324146AFCF25}'; pid : 3);
  {$EXTERNALSYM PKEY_Link_Status}

// Possible discrete values for PKEY_Link_Status are:
  LINK_STATUS_RESOLVED =                 1;
  {$EXTERNALSYM LINK_STATUS_RESOLVED}
  LINK_STATUS_BROKEN =                   2;
  {$EXTERNALSYM LINK_STATUS_BROKEN}

//  Name:     System.Link.TargetExtension -- PKEY_Link_TargetExtension
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {7A7D76F4-B630-4BD7-95FF-37CC51A975C9}, 2
//
//  The file extension of the link target.  See System.File.Extension
  PKEY_Link_TargetExtension : TPropertyKey = (
    fmtid : '{7A7D76F4-B630-4BD7-95FF-37CC51A975C9}'; pid : 2);
  {$EXTERNALSYM PKEY_Link_TargetExtension}

//  Name:     System.Link.TargetParsingPath -- PKEY_Link_TargetParsingPath
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_LINK) {B9B4B3FC-2B51-4A42-B5D8-324146AFCF25}, 2 (PID_LINK_TARGET)
//  
//  This is the shell namespace path to the target of the link item.  This path may be passed to 
//  SHParseDisplayName to parse the path to the correct shell folder.
//  
//  If the target item is a file, the value is identical to System.ItemPathDisplay.
//  
//  If the target item cannot be accessed through the shell namespace, this value is VT_EMPTY.
  PKEY_Link_TargetParsingPath : TPropertyKey = (
    fmtid : '{B9B4B3FC-2B51-4A42-B5D8-324146AFCF25}'; pid : 2);
  {$EXTERNALSYM PKEY_Link_TargetParsingPath}

//  Name:     System.Link.TargetSFGAOFlags -- PKEY_Link_TargetSFGAOFlags
//  Type:     UInt32 -- VT_UI4
//  FormatID: (PSGUID_LINK) {B9B4B3FC-2B51-4A42-B5D8-324146AFCF25}, 8
//  
//  IShellFolder::GetAttributesOf flags for the target of a link, with SFGAO_PKEYSFGAOMASK 
//  attributes masked out.
  PKEY_Link_TargetSFGAOFlags : TPropertyKey = (
    fmtid : '{B9B4B3FC-2B51-4A42-B5D8-324146AFCF25}'; pid : 8);
  {$EXTERNALSYM PKEY_Link_TargetSFGAOFlags}
 
//-----------------------------------------------------------------------------
// Media properties



//  Name:     System.Media.AuthorUrl -- PKEY_Media_AuthorUrl
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 32 (PIDMSI_AUTHOR_URL)
//
//  
  PKEY_Media_AuthorUrl : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 32);
  {$EXTERNALSYM PKEY_Media_AuthorUrl}

//  Name:     System.Media.AverageLevel -- PKEY_Media_AverageLevel
//  Type:     UInt32 -- VT_UI4
//  FormatID: {09EDD5B6-B301-43C5-9990-D00302EFFD46}, 100
  PKEY_Media_AverageLevel : TPropertyKey = (
    fmtid : '{09EDD5B6-B301-43C5-9990-D00302EFFD46}'; pid : 100);
  {$EXTERNALSYM PKEY_Media_AverageLevel}

//  Name:     System.Media.ClassPrimaryID -- PKEY_Media_ClassPrimaryID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 13 (PIDMSI_CLASS_PRIMARY_ID)
//
//  
  PKEY_Media_ClassPrimaryID : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 13);
  {$EXTERNALSYM PKEY_Media_ClassPrimaryID}

//  Name:     System.Media.ClassSecondaryID -- PKEY_Media_ClassSecondaryID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 14 (PIDMSI_CLASS_SECONDARY_ID)
//
//  
  PKEY_Media_ClassSecondaryID : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 14);
  {$EXTERNALSYM PKEY_Media_ClassSecondaryID}

//  Name:     System.Media.CollectionGroupID -- PKEY_Media_CollectionGroupID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 24 (PIDMSI_COLLECTION_GROUP_ID)
//
//  
  PKEY_Media_CollectionGroupID : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 24);
  {$EXTERNALSYM PKEY_Media_CollectionGroupID}

//  Name:     System.Media.CollectionID -- PKEY_Media_CollectionID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 25 (PIDMSI_COLLECTION_ID)
//
//  
  PKEY_Media_CollectionID : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 25);
  {$EXTERNALSYM PKEY_Media_CollectionID}

//  Name:     System.Media.ContentDistributor -- PKEY_Media_ContentDistributor
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 18 (PIDMSI_CONTENTDISTRIBUTOR)
//
//  
  PKEY_Media_ContentDistributor : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 18);
  {$EXTERNALSYM PKEY_Media_ContentDistributor}

//  Name:     System.Media.ContentID -- PKEY_Media_ContentID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 26 (PIDMSI_CONTENT_ID)
//
//  
  PKEY_Media_ContentID : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 26);
  {$EXTERNALSYM PKEY_Media_ContentID}

//  Name:     System.Media.CreatorApplication -- PKEY_Media_CreatorApplication
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 27 (PIDMSI_TOOL_NAME)
//
//  
  PKEY_Media_CreatorApplication : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 27);
  {$EXTERNALSYM PKEY_Media_CreatorApplication}

//  Name:     System.Media.CreatorApplicationVersion -- PKEY_Media_CreatorApplicationVersion
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 28 (PIDMSI_TOOL_VERSION)
//
//  
  PKEY_Media_CreatorApplicationVersion : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 28);
  {$EXTERNALSYM PKEY_Media_CreatorApplicationVersion}

//  Name:     System.Media.DateEncoded -- PKEY_Media_DateEncoded
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {2E4B640D-5019-46D8-8881-55414CC5CAA0}, 100
//
//  DateTime is in UTC (in the doc, not file system).
  PKEY_Media_DateEncoded : TPropertyKey = (
    fmtid : '{2E4B640D-5019-46D8-8881-55414CC5CAA0}'; pid : 100);
  {$EXTERNALSYM PKEY_Media_DateEncoded}

//  Name:     System.Media.DateReleased -- PKEY_Media_DateReleased
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {DE41CC29-6971-4290-B472-F59F2E2F31E2}, 100
  PKEY_Media_DateReleased : TPropertyKey = (
    fmtid : '{DE41CC29-6971-4290-B472-F59F2E2F31E2}'; pid : 100);
  {$EXTERNALSYM PKEY_Media_DateReleased}

//  Name:     System.Media.Duration -- PKEY_Media_Duration
//  Type:     UInt64 -- VT_UI8
//  FormatID: (FMTID_AudioSummaryInformation) {64440490-4C8B-11D1-8B70-080036B11A03}, 3 (PIDASI_TIMELENGTH)
//
//  100ns units, not milliseconds
  PKEY_Media_Duration : TPropertyKey = (
    fmtid : '{64440490-4C8B-11D1-8B70-080036B11A03}'; pid : 3);
  {$EXTERNALSYM PKEY_Media_Duration}

//  Name:     System.Media.DVDID -- PKEY_Media_DVDID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 15 (PIDMSI_DVDID)
//
//  
  PKEY_Media_DVDID : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 15);
  {$EXTERNALSYM PKEY_Media_DVDID}

//  Name:     System.Media.EncodedBy -- PKEY_Media_EncodedBy
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 36 (PIDMSI_ENCODED_BY)
//
//  
  PKEY_Media_EncodedBy : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 36);
  {$EXTERNALSYM PKEY_Media_EncodedBy}

//  Name:     System.Media.EncodingSettings -- PKEY_Media_EncodingSettings
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 37 (PIDMSI_ENCODING_SETTINGS)
//
//  
  PKEY_Media_EncodingSettings : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 37);
  {$EXTERNALSYM PKEY_Media_EncodingSettings}

//  Name:     System.Media.FrameCount -- PKEY_Media_FrameCount
//  Type:     UInt32 -- VT_UI4
//  FormatID: (PSGUID_IMAGESUMMARYINFORMATION) {6444048F-4C8B-11D1-8B70-080036B11A03}, 12 (PIDISI_FRAMECOUNT)
//
//  Indicates the frame count for the image.
  PKEY_Media_FrameCount : TPropertyKey = (
    fmtid : '{6444048F-4C8B-11D1-8B70-080036B11A03}'; pid : 12);
  {$EXTERNALSYM PKEY_Media_FrameCount}

//  Name:     System.Media.MCDI -- PKEY_Media_MCDI
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 16 (PIDMSI_MCDI)
//
//  
  PKEY_Media_MCDI : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 16);
  {$EXTERNALSYM PKEY_Media_MCDI}

//  Name:     System.Media.MetadataContentProvider -- PKEY_Media_MetadataContentProvider
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 17 (PIDMSI_PROVIDER)
//
//  
  PKEY_Media_MetadataContentProvider : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 17);
  {$EXTERNALSYM PKEY_Media_MetadataContentProvider}

//  Name:     System.Media.Producer -- PKEY_Media_Producer
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 22 (PIDMSI_PRODUCER)
//
//  
  PKEY_Media_Producer : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 22);
  {$EXTERNALSYM PKEY_Media_Producer}

//  Name:     System.Media.PromotionUrl -- PKEY_Media_PromotionUrl
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 33 (PIDMSI_PROMOTION_URL)
//
//  
  PKEY_Media_PromotionUrl : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 33);
  {$EXTERNALSYM PKEY_Media_PromotionUrl}

//  Name:     System.Media.ProtectionType -- PKEY_Media_ProtectionType
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 38
//  
//  If media is protected, how is it protected?
  PKEY_Media_ProtectionType : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 38);
  {$EXTERNALSYM PKEY_Media_ProtectionType}

//  Name:     System.Media.ProviderRating -- PKEY_Media_ProviderRating
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 39
//  
//  Rating (0 - 99) supplied by metadata provider
  PKEY_Media_ProviderRating : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 39);
  {$EXTERNALSYM PKEY_Media_ProviderRating}

//  Name:     System.Media.ProviderStyle -- PKEY_Media_ProviderStyle
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 40
//  
//  Style of music or video, supplied by metadata provider
  PKEY_Media_ProviderStyle : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 40);
  {$EXTERNALSYM PKEY_Media_ProviderStyle}

//  Name:     System.Media.Publisher -- PKEY_Media_Publisher
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 30 (PIDMSI_PUBLISHER)
//
//  
  PKEY_Media_Publisher : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 30);
  {$EXTERNALSYM PKEY_Media_Publisher}

//  Name:     System.Media.SubscriptionContentId -- PKEY_Media_SubscriptionContentId
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {9AEBAE7A-9644-487D-A92C-657585ED751A}, 100
  PKEY_Media_SubscriptionContentId : TPropertyKey = (
    fmtid : '{9AEBAE7A-9644-487D-A92C-657585ED751A}'; pid : 100);
  {$EXTERNALSYM PKEY_Media_SubscriptionContentId}

//  Name:     System.Media.SubTitle -- PKEY_Media_SubTitle
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 38 (PIDSI_MUSIC_SUB_TITLE)
//
//  
  PKEY_Media_SubTitle : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 38);
  {$EXTERNALSYM PKEY_Media_SubTitle}

//  Name:     System.Media.UniqueFileIdentifier -- PKEY_Media_UniqueFileIdentifier
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 35 (PIDMSI_UNIQUE_FILE_IDENTIFIER)
//
//  
  PKEY_Media_UniqueFileIdentifier : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 35);
  {$EXTERNALSYM PKEY_Media_UniqueFileIdentifier}

//  Name:     System.Media.UserNoAutoInfo -- PKEY_Media_UserNoAutoInfo
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 41
//  
//  If true, do NOT alter this file's metadata. Set by user.
  PKEY_Media_UserNoAutoInfo : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 41);
  {$EXTERNALSYM PKEY_Media_UserNoAutoInfo}

//  Name:     System.Media.UserWebUrl -- PKEY_Media_UserWebUrl
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 34 (PIDMSI_USER_WEB_URL)
//
//  
  PKEY_Media_UserWebUrl : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 34);
  {$EXTERNALSYM PKEY_Media_UserWebUrl}

//  Name:     System.Media.Writer -- PKEY_Media_Writer
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 23 (PIDMSI_WRITER)
//
//  
  PKEY_Media_Writer : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 23);
  {$EXTERNALSYM PKEY_Media_Writer}

//  Name:     System.Media.Year -- PKEY_Media_Year
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 5 (PIDSI_MUSIC_YEAR)
//
//  
  PKEY_Media_Year : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 5);
  {$EXTERNALSYM PKEY_Media_Year}
 
//-----------------------------------------------------------------------------
// Message properties



//  Name:     System.Message.AttachmentContents -- PKEY_Message_AttachmentContents
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {3143BF7C-80A8-4854-8880-E2E40189BDD0}, 100
  PKEY_Message_AttachmentContents : TPropertyKey = (
    fmtid : '{3143BF7C-80A8-4854-8880-E2E40189BDD0}'; pid : 100);
  {$EXTERNALSYM PKEY_Message_AttachmentContents}

//  Name:     System.Message.AttachmentNames -- PKEY_Message_AttachmentNames
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 21
//
//  The names of the attachments in a message
  PKEY_Message_AttachmentNames : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 21);
  {$EXTERNALSYM PKEY_Message_AttachmentNames}

//  Name:     System.Message.BccAddress -- PKEY_Message_BccAddress
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 2
//
//  Addresses in Bcc: field
  PKEY_Message_BccAddress : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 2);
  {$EXTERNALSYM PKEY_Message_BccAddress}

//  Name:     System.Message.BccName -- PKEY_Message_BccName
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 3
//
//  person names in Bcc: field
  PKEY_Message_BccName : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 3);
  {$EXTERNALSYM PKEY_Message_BccName}

//  Name:     System.Message.CcAddress -- PKEY_Message_CcAddress
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 4
//
//  Addresses in Cc: field
  PKEY_Message_CcAddress : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 4);
  {$EXTERNALSYM PKEY_Message_CcAddress}

//  Name:     System.Message.CcName -- PKEY_Message_CcName
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 5
//
//  person names in Cc: field
  PKEY_Message_CcName : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 5);
  {$EXTERNALSYM PKEY_Message_CcName}

//  Name:     System.Message.ConversationID -- PKEY_Message_ConversationID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {DC8F80BD-AF1E-4289-85B6-3DFC1B493992}, 100
  PKEY_Message_ConversationID : TPropertyKey = (
    fmtid : '{DC8F80BD-AF1E-4289-85B6-3DFC1B493992}'; pid : 100);
  {$EXTERNALSYM PKEY_Message_ConversationID}

//  Name:     System.Message.ConversationIndex -- PKEY_Message_ConversationIndex
//  Type:     Buffer -- VT_VECTOR | VT_UI1  (For variants: VT_ARRAY | VT_UI1)
//  FormatID: {DC8F80BD-AF1E-4289-85B6-3DFC1B493992}, 101
//  
//  
  PKEY_Message_ConversationIndex : TPropertyKey = (
    fmtid : '{DC8F80BD-AF1E-4289-85B6-3DFC1B493992}'; pid : 101);
  {$EXTERNALSYM PKEY_Message_ConversationIndex}

//  Name:     System.Message.DateReceived -- PKEY_Message_DateReceived
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 20
//
//  Date and Time communication was received
  PKEY_Message_DateReceived : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 20);
  {$EXTERNALSYM PKEY_Message_DateReceived}

//  Name:     System.Message.DateSent -- PKEY_Message_DateSent
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 19
//
//  Date and Time communication was sent
  PKEY_Message_DateSent : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 19);
  {$EXTERNALSYM PKEY_Message_DateSent}

//  Name:     System.Message.Flags -- PKEY_Message_Flags
//  Type:     Int32 -- VT_I4
//  FormatID: {A82D9EE7-CA67-4312-965E-226BCEA85023}, 100
//  
//  These are flags associated with email messages to know if a read receipt is pending, etc.
//  The values stored here by Outlook are defined for PR_MESSAGE_FLAGS on MSDN. 
  PKEY_Message_Flags : TPropertyKey = (
    fmtid : '{A82D9EE7-CA67-4312-965E-226BCEA85023}'; pid : 100);
  {$EXTERNALSYM PKEY_Message_Flags}

//  Name:     System.Message.FromAddress -- PKEY_Message_FromAddress
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 13
  PKEY_Message_FromAddress : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 13);
  {$EXTERNALSYM PKEY_Message_FromAddress}

//  Name:     System.Message.FromName -- PKEY_Message_FromName
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 14
//
//  Address in from field as person name
  PKEY_Message_FromName : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 14);
  {$EXTERNALSYM PKEY_Message_FromName}

//  Name:     System.Message.HasAttachments -- PKEY_Message_HasAttachments
//  Type:     Boolean -- VT_BOOL
//  FormatID: {9C1FCF74-2D97-41BA-B4AE-CB2E3661A6E4}, 8
//
//  
  PKEY_Message_HasAttachments : TPropertyKey = (
    fmtid : '{9C1FCF74-2D97-41BA-B4AE-CB2E3661A6E4}'; pid : 8);
  {$EXTERNALSYM PKEY_Message_HasAttachments}

//  Name:     System.Message.IsFwdOrReply -- PKEY_Message_IsFwdOrReply
//  Type:     Int32 -- VT_I4
//  FormatID: {9A9BC088-4F6D-469E-9919-E705412040F9}, 100
  PKEY_Message_IsFwdOrReply : TPropertyKey = (
    fmtid : '{9A9BC088-4F6D-469E-9919-E705412040F9}'; pid : 100);
  {$EXTERNALSYM PKEY_Message_IsFwdOrReply}

//  Name:     System.Message.MessageClass -- PKEY_Message_MessageClass
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {CD9ED458-08CE-418F-A70E-F912C7BB9C5C}, 103
//  
//  What type of outlook msg this is (meeting, task, mail, etc.)
  PKEY_Message_MessageClass : TPropertyKey = (
    fmtid : '{CD9ED458-08CE-418F-A70E-F912C7BB9C5C}'; pid : 103);
  {$EXTERNALSYM PKEY_Message_MessageClass}

//  Name:     System.Message.ProofInProgress -- PKEY_Message_ProofInProgress
//  Type:     Boolean -- VT_BOOL
//  FormatID: {9098F33C-9A7D-48A8-8DE5-2E1227A64E91}, 100
//  
//  This property will be true if the message junk email proofing is still in progress.
  PKEY_Message_ProofInProgress : TPropertyKey = (
    fmtid : '{9098F33C-9A7D-48A8-8DE5-2E1227A64E91}'; pid : 100);
  {$EXTERNALSYM PKEY_Message_ProofInProgress}

//  Name:     System.Message.SenderAddress -- PKEY_Message_SenderAddress
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {0BE1C8E7-1981-4676-AE14-FDD78F05A6E7}, 100
  PKEY_Message_SenderAddress : TPropertyKey = (
    fmtid : '{0BE1C8E7-1981-4676-AE14-FDD78F05A6E7}'; pid : 100);
  {$EXTERNALSYM PKEY_Message_SenderAddress}

//  Name:     System.Message.SenderName -- PKEY_Message_SenderName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {0DA41CFA-D224-4A18-AE2F-596158DB4B3A}, 100
  PKEY_Message_SenderName : TPropertyKey = (
    fmtid : '{0DA41CFA-D224-4A18-AE2F-596158DB4B3A}'; pid : 100);
  {$EXTERNALSYM PKEY_Message_SenderName}

//  Name:     System.Message.Store -- PKEY_Message_Store
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 15
//
//  The store (aka protocol handler) FILE, MAIL, OUTLOOKEXPRESS
  PKEY_Message_Store : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 15);
  {$EXTERNALSYM PKEY_Message_Store}

//  Name:     System.Message.ToAddress -- PKEY_Message_ToAddress
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 16
//
//  Addresses in To: field
  PKEY_Message_ToAddress : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 16);
  {$EXTERNALSYM PKEY_Message_ToAddress}

//  Name:     System.Message.ToDoFlags -- PKEY_Message_ToDoFlags
//  Type:     Int32 -- VT_I4
//  FormatID: {1F856A9F-6900-4ABA-9505-2D5F1B4D66CB}, 100
//  
//  Flags associated with a message flagged to know if it's still active, if it was custom flagged, etc.
  PKEY_Message_ToDoFlags : TPropertyKey = (
    fmtid : '{1F856A9F-6900-4ABA-9505-2D5F1B4D66CB}'; pid : 100);
  {$EXTERNALSYM PKEY_Message_ToDoFlags}

//  Name:     System.Message.ToDoTitle -- PKEY_Message_ToDoTitle
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {BCCC8A3C-8CEF-42E5-9B1C-C69079398BC7}, 100
  PKEY_Message_ToDoTitle : TPropertyKey = (
    fmtid : '{BCCC8A3C-8CEF-42E5-9B1C-C69079398BC7}'; pid : 100);
  {$EXTERNALSYM PKEY_Message_ToDoTitle}

//  Name:     System.Message.ToName -- PKEY_Message_ToName
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}, 17
//
//  Person names in To: field
  PKEY_Message_ToName : TPropertyKey = (
    fmtid : '{E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD}'; pid : 17);
  {$EXTERNALSYM PKEY_Message_ToName}
 
//-----------------------------------------------------------------------------
// Music properties

//  Name:     System.Music.AlbumArtist -- PKEY_Music_AlbumArtist
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 13 (PIDSI_MUSIC_ALBUM_ARTIST)
//
//  
  PKEY_Music_AlbumArtist : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 13);
  {$EXTERNALSYM PKEY_Music_AlbumArtist}

//  Name:     System.Music.AlbumID -- PKEY_Music_AlbumID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 100
//  
//  Concatenation of System.Music.AlbumArtist and System.Music.AlbumTitle, suitable for indexing and display.
//  Used to differentiate albums with the same title from different artists.
  PKEY_Music_AlbumID : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 100);
  {$EXTERNALSYM PKEY_Music_AlbumID}

//  Name:     System.Music.AlbumTitle -- PKEY_Music_AlbumTitle
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 4 (PIDSI_MUSIC_ALBUM)
//
//  
  PKEY_Music_AlbumTitle : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 4);
  {$EXTERNALSYM PKEY_Music_AlbumTitle}

//  Name:     System.Music.Artist -- PKEY_Music_Artist
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 2 (PIDSI_MUSIC_ARTIST)
//
//  
  PKEY_Music_Artist : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 2);
  {$EXTERNALSYM PKEY_Music_Artist}

//  Name:     System.Music.BeatsPerMinute -- PKEY_Music_BeatsPerMinute
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 35 (PIDSI_MUSIC_BEATS_PER_MINUTE)
//
//  
  PKEY_Music_BeatsPerMinute : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 35);
  {$EXTERNALSYM PKEY_Music_BeatsPerMinute}

//  Name:     System.Music.Composer -- PKEY_Music_Composer
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 19 (PIDMSI_COMPOSER)
//
//  
  PKEY_Music_Composer : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 19);
  {$EXTERNALSYM PKEY_Music_Composer}

//  Name:     System.Music.Conductor -- PKEY_Music_Conductor
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 36 (PIDSI_MUSIC_CONDUCTOR)
//
//  
  PKEY_Music_Conductor : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 36);
  {$EXTERNALSYM PKEY_Music_Conductor}

//  Name:     System.Music.ContentGroupDescription -- PKEY_Music_ContentGroupDescription
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 33 (PIDSI_MUSIC_CONTENT_GROUP_DESCRIPTION)
//
//  
  PKEY_Music_ContentGroupDescription : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 33);
  {$EXTERNALSYM PKEY_Music_ContentGroupDescription}

//  Name:     System.Music.Genre -- PKEY_Music_Genre
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 11 (PIDSI_MUSIC_GENRE)
//
//  
  PKEY_Music_Genre : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 11);
  {$EXTERNALSYM PKEY_Music_Genre}

//  Name:     System.Music.InitialKey -- PKEY_Music_InitialKey
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 34 (PIDSI_MUSIC_INITIAL_KEY)
//
//  
  PKEY_Music_InitialKey : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 34);
  {$EXTERNALSYM PKEY_Music_InitialKey}

//  Name:     System.Music.Lyrics -- PKEY_Music_Lyrics
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 12 (PIDSI_MUSIC_LYRICS)
//
//  
  PKEY_Music_Lyrics : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 12);
  {$EXTERNALSYM PKEY_Music_Lyrics}

//  Name:     System.Music.Mood -- PKEY_Music_Mood
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 39 (PIDSI_MUSIC_MOOD)
//
//  
  PKEY_Music_Mood : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 39);
  {$EXTERNALSYM PKEY_Music_Mood}

//  Name:     System.Music.PartOfSet -- PKEY_Music_PartOfSet
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 37 (PIDSI_MUSIC_PART_OF_SET)
//
//  
  PKEY_Music_PartOfSet : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 37);
  {$EXTERNALSYM PKEY_Music_PartOfSet}

//  Name:     System.Music.Period -- PKEY_Music_Period
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 31 (PIDMSI_PERIOD)
//
//  
  PKEY_Music_Period : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 31);
  {$EXTERNALSYM PKEY_Music_Period}

//  Name:     System.Music.SynchronizedLyrics -- PKEY_Music_SynchronizedLyrics
//  Type:     Blob -- VT_BLOB
//  FormatID: {6B223B6A-162E-4AA9-B39F-05D678FC6D77}, 100
  PKEY_Music_SynchronizedLyrics : TPropertyKey = (
    fmtid : '{6B223B6A-162E-4AA9-B39F-05D678FC6D77}'; pid : 100);
  {$EXTERNALSYM PKEY_Music_SynchronizedLyrics}

//  Name:     System.Music.TrackNumber -- PKEY_Music_TrackNumber
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_MUSIC) {56A3372E-CE9C-11D2-9F0E-006097C686F6}, 7 (PIDSI_MUSIC_TRACK)
//
//  
  PKEY_Music_TrackNumber : TPropertyKey = (
    fmtid : '{56A3372E-CE9C-11D2-9F0E-006097C686F6}'; pid : 7);
  {$EXTERNALSYM PKEY_Music_TrackNumber}

 
 
//-----------------------------------------------------------------------------
// Note properties

//  Name:     System.Note.Color -- PKEY_Note_Color
//  Type:     UInt16 -- VT_UI2
//  FormatID: {4776CAFA-BCE4-4CB1-A23E-265E76D8EB11}, 100
  PKEY_Note_Color : TPropertyKey = (
    fmtid : '{4776CAFA-BCE4-4CB1-A23E-265E76D8EB11}'; pid : 100);
  {$EXTERNALSYM PKEY_Note_Color}

// Possible discrete values for PKEY_Note_Color are:
  NOTE_COLOR_BLUE =                      0;
  {$EXTERNALSYM NOTE_COLOR_BLUE}
  NOTE_COLOR_GREEN =                     1;
  {$EXTERNALSYM NOTE_COLOR_GREEN}
  NOTE_COLOR_PINK =                      2;
  {$EXTERNALSYM NOTE_COLOR_PINK}
  NOTE_COLOR_YELLOW =                    3;
  {$EXTERNALSYM NOTE_COLOR_YELLOW}
  NOTE_COLOR_WHITE =                     4;
  {$EXTERNALSYM NOTE_COLOR_WHITE}
  NOTE_COLOR_LIGHTGREEN =                5;
  {$EXTERNALSYM NOTE_COLOR_LIGHTGREEN}

//  Name:     System.Note.ColorText -- PKEY_Note_ColorText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {46B4E8DE-CDB2-440D-885C-1658EB65B914}, 100
//  
//  This is the user-friendly form of System.Note.Color.  Not intended to be parsed 
//  programmatically.
  PKEY_Note_ColorText : TPropertyKey = (
    fmtid : '{46B4E8DE-CDB2-440D-885C-1658EB65B914}'; pid : 100);
  {$EXTERNALSYM PKEY_Note_ColorText}
 
//-----------------------------------------------------------------------------
// Photo properties



//  Name:     System.Photo.Aperture -- PKEY_Photo_Aperture
//  Type:     Double -- VT_R8
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 37378
//
//  PropertyTagExifAperture.  Calculated from PKEY_Photo_ApertureNumerator and PKEY_Photo_ApertureDenominator
  PKEY_Photo_Aperture : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 37378);
  {$EXTERNALSYM PKEY_Photo_Aperture}

//  Name:     System.Photo.ApertureDenominator -- PKEY_Photo_ApertureDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {E1A9A38B-6685-46BD-875E-570DC7AD7320}, 100
//
//  Denominator of PKEY_Photo_Aperture
  PKEY_Photo_ApertureDenominator : TPropertyKey = (
    fmtid : '{E1A9A38B-6685-46BD-875E-570DC7AD7320}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ApertureDenominator}

//  Name:     System.Photo.ApertureNumerator -- PKEY_Photo_ApertureNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {0337ECEC-39FB-4581-A0BD-4C4CC51E9914}, 100
//
//  Numerator of PKEY_Photo_Aperture
  PKEY_Photo_ApertureNumerator : TPropertyKey = (
    fmtid : '{0337ECEC-39FB-4581-A0BD-4C4CC51E9914}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ApertureNumerator}

//  Name:     System.Photo.Brightness -- PKEY_Photo_Brightness
//  Type:     Double -- VT_R8
//  FormatID: {1A701BF6-478C-4361-83AB-3701BB053C58}, 100 (PropertyTagExifBrightness)
//  
//  This is the brightness of the photo.
//  
//  Calculated from PKEY_Photo_BrightnessNumerator and PKEY_Photo_BrightnessDenominator.
//  
//  The units are "APEX", normally in the range of -99.99 to 99.99. If the numerator of 
//  the recorded value is FFFFFFFF.H, "Unknown" should be indicated.
  PKEY_Photo_Brightness : TPropertyKey = (
    fmtid : '{1A701BF6-478C-4361-83AB-3701BB053C58}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_Brightness}

//  Name:     System.Photo.BrightnessDenominator -- PKEY_Photo_BrightnessDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {6EBE6946-2321-440A-90F0-C043EFD32476}, 100
//
//  Denominator of PKEY_Photo_Brightness
  PKEY_Photo_BrightnessDenominator : TPropertyKey = (
    fmtid : '{6EBE6946-2321-440A-90F0-C043EFD32476}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_BrightnessDenominator}

//  Name:     System.Photo.BrightnessNumerator -- PKEY_Photo_BrightnessNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {9E7D118F-B314-45A0-8CFB-D654B917C9E9}, 100
//
//  Numerator of PKEY_Photo_Brightness
  PKEY_Photo_BrightnessNumerator : TPropertyKey = (
    fmtid : '{9E7D118F-B314-45A0-8CFB-D654B917C9E9}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_BrightnessNumerator}

//  Name:     System.Photo.CameraManufacturer -- PKEY_Photo_CameraManufacturer
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 271 (PropertyTagEquipMake)
//
//  
  PKEY_Photo_CameraManufacturer : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 271);
  {$EXTERNALSYM PKEY_Photo_CameraManufacturer}

//  Name:     System.Photo.CameraModel -- PKEY_Photo_CameraModel
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 272 (PropertyTagEquipModel)
//
//  
  PKEY_Photo_CameraModel : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 272);
  {$EXTERNALSYM PKEY_Photo_CameraModel}

//  Name:     System.Photo.CameraSerialNumber -- PKEY_Photo_CameraSerialNumber
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 273
//
//  Serial number of camera that produced this photo
  PKEY_Photo_CameraSerialNumber : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 273);
  {$EXTERNALSYM PKEY_Photo_CameraSerialNumber}

//  Name:     System.Photo.Contrast -- PKEY_Photo_Contrast
//  Type:     UInt32 -- VT_UI4
//  FormatID: {2A785BA9-8D23-4DED-82E6-60A350C86A10}, 100
//  
//  This indicates the direction of contrast processing applied by the camera 
//  when the image was shot.
  PKEY_Photo_Contrast : TPropertyKey = (
    fmtid : '{2A785BA9-8D23-4DED-82E6-60A350C86A10}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_Contrast}

// Possible discrete values for PKEY_Photo_Contrast are:
  PHOTO_CONTRAST_NORMAL =                0;
  {$EXTERNALSYM PHOTO_CONTRAST_NORMAL}
  PHOTO_CONTRAST_SOFT =                  1;
  {$EXTERNALSYM PHOTO_CONTRAST_SOFT}
  PHOTO_CONTRAST_HARD =                  2;
  {$EXTERNALSYM PHOTO_CONTRAST_HARD}

//  Name:     System.Photo.ContrastText -- PKEY_Photo_ContrastText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {59DDE9F2-5253-40EA-9A8B-479E96C6249A}, 100
//  
//  This is the user-friendly form of System.Photo.Contrast.  Not intended to be parsed 
//  programmatically.
  PKEY_Photo_ContrastText : TPropertyKey = (
    fmtid : '{59DDE9F2-5253-40EA-9A8B-479E96C6249A}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ContrastText}

//  Name:     System.Photo.DateTaken -- PKEY_Photo_DateTaken
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 36867
//
//  PropertyTagExifDTOrig
  PKEY_Photo_DateTaken : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 36867);
  {$EXTERNALSYM PKEY_Photo_DateTaken}

//  Name:     System.Photo.DigitalZoom -- PKEY_Photo_DigitalZoom
//  Type:     Double -- VT_R8
//  FormatID: {F85BF840-A925-4BC2-B0C4-8E36B598679E}, 100
//
//  PropertyTagExifDigitalZoom.  Calculated from PKEY_Photo_DigitalZoomNumerator and PKEY_Photo_DigitalZoomDenominator
  PKEY_Photo_DigitalZoom : TPropertyKey = (
    fmtid : '{F85BF840-A925-4BC2-B0C4-8E36B598679E}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_DigitalZoom}

//  Name:     System.Photo.DigitalZoomDenominator -- PKEY_Photo_DigitalZoomDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {745BAF0E-E5C1-4CFB-8A1B-D031A0A52393}, 100
//
//  Denominator of PKEY_Photo_DigitalZoom
  PKEY_Photo_DigitalZoomDenominator : TPropertyKey = (
    fmtid : '{745BAF0E-E5C1-4CFB-8A1B-D031A0A52393}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_DigitalZoomDenominator}

//  Name:     System.Photo.DigitalZoomNumerator -- PKEY_Photo_DigitalZoomNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {16CBB924-6500-473B-A5BE-F1599BCBE413}, 100
//
//  Numerator of PKEY_Photo_DigitalZoom
  PKEY_Photo_DigitalZoomNumerator : TPropertyKey = (
    fmtid : '{16CBB924-6500-473B-A5BE-F1599BCBE413}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_DigitalZoomNumerator}

//  Name:     System.Photo.Event -- PKEY_Photo_Event
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 18248
//
//  The event at which the photo was taken
  PKEY_Photo_Event : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 18248);
  {$EXTERNALSYM PKEY_Photo_Event}

//  Name:     System.Photo.EXIFVersion -- PKEY_Photo_EXIFVersion
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {D35F743A-EB2E-47F2-A286-844132CB1427}, 100
//
//  The EXIF version.
  PKEY_Photo_EXIFVersion : TPropertyKey = (
    fmtid : '{D35F743A-EB2E-47F2-A286-844132CB1427}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_EXIFVersion}

//  Name:     System.Photo.ExposureBias -- PKEY_Photo_ExposureBias
//  Type:     Double -- VT_R8
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 37380
//
//  PropertyTagExifExposureBias.  Calculated from PKEY_Photo_ExposureBiasNumerator and PKEY_Photo_ExposureBiasDenominator
  PKEY_Photo_ExposureBias : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 37380);
  {$EXTERNALSYM PKEY_Photo_ExposureBias}

//  Name:     System.Photo.ExposureBiasDenominator -- PKEY_Photo_ExposureBiasDenominator
//  Type:     Int32 -- VT_I4
//  FormatID: {AB205E50-04B7-461C-A18C-2F233836E627}, 100
//
//  Denominator of PKEY_Photo_ExposureBias
  PKEY_Photo_ExposureBiasDenominator : TPropertyKey = (
    fmtid : '{AB205E50-04B7-461C-A18C-2F233836E627}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ExposureBiasDenominator}

//  Name:     System.Photo.ExposureBiasNumerator -- PKEY_Photo_ExposureBiasNumerator
//  Type:     Int32 -- VT_I4
//  FormatID: {738BF284-1D87-420B-92CF-5834BF6EF9ED}, 100
//
//  Numerator of PKEY_Photo_ExposureBias
  PKEY_Photo_ExposureBiasNumerator : TPropertyKey = (
    fmtid : '{738BF284-1D87-420B-92CF-5834BF6EF9ED}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ExposureBiasNumerator}

//  Name:     System.Photo.ExposureIndex -- PKEY_Photo_ExposureIndex
//  Type:     Double -- VT_R8
//  FormatID: {967B5AF8-995A-46ED-9E11-35B3C5B9782D}, 100
//
//  PropertyTagExifExposureIndex.  Calculated from PKEY_Photo_ExposureIndexNumerator and PKEY_Photo_ExposureIndexDenominator
  PKEY_Photo_ExposureIndex : TPropertyKey = (
    fmtid : '{967B5AF8-995A-46ED-9E11-35B3C5B9782D}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ExposureIndex}

//  Name:     System.Photo.ExposureIndexDenominator -- PKEY_Photo_ExposureIndexDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {93112F89-C28B-492F-8A9D-4BE2062CEE8A}, 100
//
//  Denominator of PKEY_Photo_ExposureIndex
  PKEY_Photo_ExposureIndexDenominator : TPropertyKey = (
    fmtid : '{93112F89-C28B-492F-8A9D-4BE2062CEE8A}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ExposureIndexDenominator}

//  Name:     System.Photo.ExposureIndexNumerator -- PKEY_Photo_ExposureIndexNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {CDEDCF30-8919-44DF-8F4C-4EB2FFDB8D89}, 100
//
//  Numerator of PKEY_Photo_ExposureIndex
  PKEY_Photo_ExposureIndexNumerator : TPropertyKey = (
    fmtid : '{CDEDCF30-8919-44DF-8F4C-4EB2FFDB8D89}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ExposureIndexNumerator}

//  Name:     System.Photo.ExposureProgram -- PKEY_Photo_ExposureProgram
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 34850 (PropertyTagExifExposureProg)
//
//  
  PKEY_Photo_ExposureProgram : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 34850);
  {$EXTERNALSYM PKEY_Photo_ExposureProgram}

// Possible discrete values for PKEY_Photo_ExposureProgram are:
  PHOTO_EXPOSUREPROGRAM_UNKNOWN =        0;
  {$EXTERNALSYM PHOTO_EXPOSUREPROGRAM_UNKNOWN}
  PHOTO_EXPOSUREPROGRAM_MANUAL =         1;
  {$EXTERNALSYM PHOTO_EXPOSUREPROGRAM_MANUAL}
  PHOTO_EXPOSUREPROGRAM_NORMAL =         2;
  {$EXTERNALSYM PHOTO_EXPOSUREPROGRAM_NORMAL}
  PHOTO_EXPOSUREPROGRAM_APERTURE =       3;
  {$EXTERNALSYM PHOTO_EXPOSUREPROGRAM_APERTURE}
  PHOTO_EXPOSUREPROGRAM_SHUTTER =        4;
  {$EXTERNALSYM PHOTO_EXPOSUREPROGRAM_SHUTTER}
  PHOTO_EXPOSUREPROGRAM_CREATIVE =       5;
  {$EXTERNALSYM PHOTO_EXPOSUREPROGRAM_CREATIVE}
  PHOTO_EXPOSUREPROGRAM_ACTION =         6;
  {$EXTERNALSYM PHOTO_EXPOSUREPROGRAM_ACTION}
  PHOTO_EXPOSUREPROGRAM_PORTRAIT =       7;
  {$EXTERNALSYM PHOTO_EXPOSUREPROGRAM_PORTRAIT}
  PHOTO_EXPOSUREPROGRAM_LANDSCAPE =      8;
  {$EXTERNALSYM PHOTO_EXPOSUREPROGRAM_LANDSCAPE}

//  Name:     System.Photo.ExposureProgramText -- PKEY_Photo_ExposureProgramText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {FEC690B7-5F30-4646-AE47-4CAAFBA884A3}, 100
//  
//  This is the user-friendly form of System.Photo.ExposureProgram.  Not intended to be parsed 
//  programmatically.
  PKEY_Photo_ExposureProgramText : TPropertyKey = (
    fmtid : '{FEC690B7-5F30-4646-AE47-4CAAFBA884A3}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ExposureProgramText}

//  Name:     System.Photo.ExposureTime -- PKEY_Photo_ExposureTime
//  Type:     Double -- VT_R8
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 33434
//
//  PropertyTagExifExposureTime.  Calculated from  PKEY_Photo_ExposureTimeNumerator and PKEY_Photo_ExposureTimeDenominator
  PKEY_Photo_ExposureTime : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 33434);
  {$EXTERNALSYM PKEY_Photo_ExposureTime}

//  Name:     System.Photo.ExposureTimeDenominator -- PKEY_Photo_ExposureTimeDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {55E98597-AD16-42E0-B624-21599A199838}, 100
//
//  Denominator of PKEY_Photo_ExposureTime
  PKEY_Photo_ExposureTimeDenominator : TPropertyKey = (
    fmtid : '{55E98597-AD16-42E0-B624-21599A199838}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ExposureTimeDenominator}

//  Name:     System.Photo.ExposureTimeNumerator -- PKEY_Photo_ExposureTimeNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {257E44E2-9031-4323-AC38-85C552871B2E}, 100
//
//  Numerator of PKEY_Photo_ExposureTime
  PKEY_Photo_ExposureTimeNumerator : TPropertyKey = (
    fmtid : '{257E44E2-9031-4323-AC38-85C552871B2E}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ExposureTimeNumerator}

//  Name:     System.Photo.Flash -- PKEY_Photo_Flash
//  Type:     Byte -- VT_UI1
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 37385
//
//  PropertyTagExifFlash
  PKEY_Photo_Flash : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 37385);
  {$EXTERNALSYM PKEY_Photo_Flash}

// Possible discrete values for PKEY_Photo_Flash are:
  PHOTO_FLASH_NONE =                     0;
  {$EXTERNALSYM PHOTO_FLASH_NONE}
  PHOTO_FLASH_FLASH =                    1;
  {$EXTERNALSYM PHOTO_FLASH_FLASH}
  PHOTO_FLASH_WITHOUTSTROBE =            5;
  {$EXTERNALSYM PHOTO_FLASH_WITHOUTSTROBE}
  PHOTO_FLASH_WITHSTROBE =               7;
  {$EXTERNALSYM PHOTO_FLASH_WITHSTROBE}
  PHOTO_FLASH_FLASH_COMPULSORY =         9;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_COMPULSORY}
  PHOTO_FLASH_FLASH_COMPULSORY_NORETURNLIGHT =  13;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_COMPULSORY_NORETURNLIGHT}
  PHOTO_FLASH_FLASH_COMPULSORY_RETURNLIGHT =  15;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_COMPULSORY_RETURNLIGHT}
  PHOTO_FLASH_NONE_COMPULSORY =          16;
  {$EXTERNALSYM PHOTO_FLASH_NONE_COMPULSORY}
  PHOTO_FLASH_NONE_AUTO =                24;
  {$EXTERNALSYM PHOTO_FLASH_NONE_AUTO}
  PHOTO_FLASH_FLASH_AUTO =               25;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_AUTO}
  PHOTO_FLASH_FLASH_AUTO_NORETURNLIGHT =  29;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_AUTO_NORETURNLIGHT}
  PHOTO_FLASH_FLASH_AUTO_RETURNLIGHT =   31;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_AUTO_RETURNLIGHT}
  PHOTO_FLASH_NOFUNCTION =               32;
  {$EXTERNALSYM PHOTO_FLASH_NOFUNCTION}
  PHOTO_FLASH_FLASH_REDEYE =             65;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_REDEYE}
  PHOTO_FLASH_FLASH_REDEYE_NORETURNLIGHT =  69;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_REDEYE_NORETURNLIGHT}
  PHOTO_FLASH_FLASH_REDEYE_RETURNLIGHT =  71;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_REDEYE_RETURNLIGHT}
  PHOTO_FLASH_FLASH_COMPULSORY_REDEYE =  73;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_COMPULSORY_REDEYE}
  PHOTO_FLASH_FLASH_COMPULSORY_REDEYE_NORETURNLIGHT =  77;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_COMPULSORY_REDEYE_NORETURNLIGHT}
  PHOTO_FLASH_FLASH_COMPULSORY_REDEYE_RETURNLIGHT =  79;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_COMPULSORY_REDEYE_RETURNLIGHT}
  PHOTO_FLASH_FLASH_AUTO_REDEYE =        89;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_AUTO_REDEYE}
  PHOTO_FLASH_FLASH_AUTO_REDEYE_NORETURNLIGHT =  93;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_AUTO_REDEYE_NORETURNLIGHT}
  PHOTO_FLASH_FLASH_AUTO_REDEYE_RETURNLIGHT =  95;
  {$EXTERNALSYM PHOTO_FLASH_FLASH_AUTO_REDEYE_RETURNLIGHT}

//  Name:     System.Photo.FlashEnergy -- PKEY_Photo_FlashEnergy
//  Type:     Double -- VT_R8
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 41483
//
//  PropertyTagExifFlashEnergy.  Calculated from PKEY_Photo_FlashEnergyNumerator and PKEY_Photo_FlashEnergyDenominator
  PKEY_Photo_FlashEnergy : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 41483);
  {$EXTERNALSYM PKEY_Photo_FlashEnergy}

//  Name:     System.Photo.FlashEnergyDenominator -- PKEY_Photo_FlashEnergyDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {D7B61C70-6323-49CD-A5FC-C84277162C97}, 100
//
//  Denominator of PKEY_Photo_FlashEnergy
  PKEY_Photo_FlashEnergyDenominator : TPropertyKey = (
    fmtid : '{D7B61C70-6323-49CD-A5FC-C84277162C97}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FlashEnergyDenominator}

//  Name:     System.Photo.FlashEnergyNumerator -- PKEY_Photo_FlashEnergyNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {FCAD3D3D-0858-400F-AAA3-2F66CCE2A6BC}, 100
//
//  Numerator of PKEY_Photo_FlashEnergy
  PKEY_Photo_FlashEnergyNumerator : TPropertyKey = (
    fmtid : '{FCAD3D3D-0858-400F-AAA3-2F66CCE2A6BC}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FlashEnergyNumerator}

//  Name:     System.Photo.FlashManufacturer -- PKEY_Photo_FlashManufacturer
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {AABAF6C9-E0C5-4719-8585-57B103E584FE}, 100
  PKEY_Photo_FlashManufacturer : TPropertyKey = (
    fmtid : '{AABAF6C9-E0C5-4719-8585-57B103E584FE}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FlashManufacturer}

//  Name:     System.Photo.FlashModel -- PKEY_Photo_FlashModel
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {FE83BB35-4D1A-42E2-916B-06F3E1AF719E}, 100
  PKEY_Photo_FlashModel : TPropertyKey = (
    fmtid : '{FE83BB35-4D1A-42E2-916B-06F3E1AF719E}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FlashModel}

//  Name:     System.Photo.FlashText -- PKEY_Photo_FlashText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {6B8B68F6-200B-47EA-8D25-D8050F57339F}, 100
//  
//  This is the user-friendly form of System.Photo.Flash.  Not intended to be parsed 
//  programmatically.
  PKEY_Photo_FlashText : TPropertyKey = (
    fmtid : '{6B8B68F6-200B-47EA-8D25-D8050F57339F}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FlashText}

//  Name:     System.Photo.FNumber -- PKEY_Photo_FNumber
//  Type:     Double -- VT_R8
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 33437
//
//  PropertyTagExifFNumber.  Calculated from PKEY_Photo_FNumberNumerator and PKEY_Photo_FNumberDenominator
  PKEY_Photo_FNumber : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 33437);
  {$EXTERNALSYM PKEY_Photo_FNumber}

//  Name:     System.Photo.FNumberDenominator -- PKEY_Photo_FNumberDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {E92A2496-223B-4463-A4E3-30EABBA79D80}, 100
//
//  Denominator of PKEY_Photo_FNumber
  PKEY_Photo_FNumberDenominator : TPropertyKey = (
    fmtid : '{E92A2496-223B-4463-A4E3-30EABBA79D80}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FNumberDenominator}

//  Name:     System.Photo.FNumberNumerator -- PKEY_Photo_FNumberNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {1B97738A-FDFC-462F-9D93-1957E08BE90C}, 100
//
//  Numerator of PKEY_Photo_FNumber
  PKEY_Photo_FNumberNumerator : TPropertyKey = (
    fmtid : '{1B97738A-FDFC-462F-9D93-1957E08BE90C}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FNumberNumerator}

//  Name:     System.Photo.FocalLength -- PKEY_Photo_FocalLength
//  Type:     Double -- VT_R8
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 37386
//
//  PropertyTagExifFocalLength.  Calculated from PKEY_Photo_FocalLengthNumerator and PKEY_Photo_FocalLengthDenominator
  PKEY_Photo_FocalLength : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 37386);
  {$EXTERNALSYM PKEY_Photo_FocalLength}

//  Name:     System.Photo.FocalLengthDenominator -- PKEY_Photo_FocalLengthDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {305BC615-DCA1-44A5-9FD4-10C0BA79412E}, 100
//
//  Denominator of PKEY_Photo_FocalLength
  PKEY_Photo_FocalLengthDenominator : TPropertyKey = (
    fmtid : '{305BC615-DCA1-44A5-9FD4-10C0BA79412E}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FocalLengthDenominator}

//  Name:     System.Photo.FocalLengthInFilm -- PKEY_Photo_FocalLengthInFilm
//  Type:     UInt16 -- VT_UI2
//  FormatID: {A0E74609-B84D-4F49-B860-462BD9971F98}, 100
  PKEY_Photo_FocalLengthInFilm : TPropertyKey = (
    fmtid : '{A0E74609-B84D-4F49-B860-462BD9971F98}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FocalLengthInFilm}

//  Name:     System.Photo.FocalLengthNumerator -- PKEY_Photo_FocalLengthNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {776B6B3B-1E3D-4B0C-9A0E-8FBAF2A8492A}, 100
//
//  Numerator of PKEY_Photo_FocalLength
  PKEY_Photo_FocalLengthNumerator : TPropertyKey = (
    fmtid : '{776B6B3B-1E3D-4B0C-9A0E-8FBAF2A8492A}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FocalLengthNumerator}

//  Name:     System.Photo.FocalPlaneXResolution -- PKEY_Photo_FocalPlaneXResolution
//  Type:     Double -- VT_R8
//  FormatID: {CFC08D97-C6F7-4484-89DD-EBEF4356FE76}, 100
//  
//  PropertyTagExifFocalXRes.  Calculated from PKEY_Photo_FocalPlaneXResolutionNumerator and 
//  PKEY_Photo_FocalPlaneXResolutionDenominator.
  PKEY_Photo_FocalPlaneXResolution : TPropertyKey = (
    fmtid : '{CFC08D97-C6F7-4484-89DD-EBEF4356FE76}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FocalPlaneXResolution}

//  Name:     System.Photo.FocalPlaneXResolutionDenominator -- PKEY_Photo_FocalPlaneXResolutionDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {0933F3F5-4786-4F46-A8E8-D64DD37FA521}, 100
//
//  Denominator of PKEY_Photo_FocalPlaneXResolution
  PKEY_Photo_FocalPlaneXResolutionDenominator : TPropertyKey = (
    fmtid : '{0933F3F5-4786-4F46-A8E8-D64DD37FA521}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FocalPlaneXResolutionDenominator}

//  Name:     System.Photo.FocalPlaneXResolutionNumerator -- PKEY_Photo_FocalPlaneXResolutionNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {DCCB10AF-B4E2-4B88-95F9-031B4D5AB490}, 100
//
//  Numerator of PKEY_Photo_FocalPlaneXResolution
  PKEY_Photo_FocalPlaneXResolutionNumerator : TPropertyKey = (
    fmtid : '{DCCB10AF-B4E2-4B88-95F9-031B4D5AB490}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FocalPlaneXResolutionNumerator}

//  Name:     System.Photo.FocalPlaneYResolution -- PKEY_Photo_FocalPlaneYResolution
//  Type:     Double -- VT_R8
//  FormatID: {4FFFE4D0-914F-4AC4-8D6F-C9C61DE169B1}, 100
//  
//  PropertyTagExifFocalYRes.  Calculated from PKEY_Photo_FocalPlaneYResolutionNumerator and 
//  PKEY_Photo_FocalPlaneYResolutionDenominator.
  PKEY_Photo_FocalPlaneYResolution : TPropertyKey = (
    fmtid : '{4FFFE4D0-914F-4AC4-8D6F-C9C61DE169B1}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FocalPlaneYResolution}

//  Name:     System.Photo.FocalPlaneYResolutionDenominator -- PKEY_Photo_FocalPlaneYResolutionDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {1D6179A6-A876-4031-B013-3347B2B64DC8}, 100
//
//  Denominator of PKEY_Photo_FocalPlaneYResolution
  PKEY_Photo_FocalPlaneYResolutionDenominator : TPropertyKey = (
    fmtid : '{1D6179A6-A876-4031-B013-3347B2B64DC8}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FocalPlaneYResolutionDenominator}

//  Name:     System.Photo.FocalPlaneYResolutionNumerator -- PKEY_Photo_FocalPlaneYResolutionNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {A2E541C5-4440-4BA8-867E-75CFC06828CD}, 100
//
//  Numerator of PKEY_Photo_FocalPlaneYResolution
  PKEY_Photo_FocalPlaneYResolutionNumerator : TPropertyKey = (
    fmtid : '{A2E541C5-4440-4BA8-867E-75CFC06828CD}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_FocalPlaneYResolutionNumerator}

//  Name:     System.Photo.GainControl -- PKEY_Photo_GainControl
//  Type:     Double -- VT_R8
//  FormatID: {FA304789-00C7-4D80-904A-1E4DCC7265AA}, 100 (PropertyTagExifGainControl)
//  
//  This indicates the degree of overall image gain adjustment.
//  
//  Calculated from PKEY_Photo_GainControlNumerator and PKEY_Photo_GainControlDenominator.
  PKEY_Photo_GainControl : TPropertyKey = (
    fmtid : '{FA304789-00C7-4D80-904A-1E4DCC7265AA}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_GainControl}

// Possible discrete values for PKEY_Photo_GainControl are:
  PHOTO_GAINCONTROL_NONE =               0.0;
  {$EXTERNALSYM PHOTO_GAINCONTROL_NONE}
  PHOTO_GAINCONTROL_LOWGAINUP =          1.0;
  {$EXTERNALSYM PHOTO_GAINCONTROL_LOWGAINUP}
  PHOTO_GAINCONTROL_HIGHGAINUP =         2.0;
  {$EXTERNALSYM PHOTO_GAINCONTROL_HIGHGAINUP}
  PHOTO_GAINCONTROL_LOWGAINDOWN =        3.0;
  {$EXTERNALSYM PHOTO_GAINCONTROL_LOWGAINDOWN}
  PHOTO_GAINCONTROL_HIGHGAINDOWN =       4.0;
  {$EXTERNALSYM PHOTO_GAINCONTROL_HIGHGAINDOWN}

//  Name:     System.Photo.GainControlDenominator -- PKEY_Photo_GainControlDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {42864DFD-9DA4-4F77-BDED-4AAD7B256735}, 100
//
//  Denominator of PKEY_Photo_GainControl
  PKEY_Photo_GainControlDenominator : TPropertyKey = (
    fmtid : '{42864DFD-9DA4-4F77-BDED-4AAD7B256735}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_GainControlDenominator}

//  Name:     System.Photo.GainControlNumerator -- PKEY_Photo_GainControlNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {8E8ECF7C-B7B8-4EB8-A63F-0EE715C96F9E}, 100
//
//  Numerator of PKEY_Photo_GainControl
  PKEY_Photo_GainControlNumerator : TPropertyKey = (
    fmtid : '{8E8ECF7C-B7B8-4EB8-A63F-0EE715C96F9E}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_GainControlNumerator}

//  Name:     System.Photo.GainControlText -- PKEY_Photo_GainControlText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C06238B2-0BF9-4279-A723-25856715CB9D}, 100
//  
//  This is the user-friendly form of System.Photo.GainControl.  Not intended to be parsed 
//  programmatically.
  PKEY_Photo_GainControlText : TPropertyKey = (
    fmtid : '{C06238B2-0BF9-4279-A723-25856715CB9D}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_GainControlText}

//  Name:     System.Photo.ISOSpeed -- PKEY_Photo_ISOSpeed
//  Type:     UInt16 -- VT_UI2
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 34855
//
//  PropertyTagExifISOSpeed
  PKEY_Photo_ISOSpeed : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 34855);
  {$EXTERNALSYM PKEY_Photo_ISOSpeed}

//  Name:     System.Photo.LensManufacturer -- PKEY_Photo_LensManufacturer
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E6DDCAF7-29C5-4F0A-9A68-D19412EC7090}, 100
  PKEY_Photo_LensManufacturer : TPropertyKey = (
    fmtid : '{E6DDCAF7-29C5-4F0A-9A68-D19412EC7090}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_LensManufacturer}

//  Name:     System.Photo.LensModel -- PKEY_Photo_LensModel
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {E1277516-2B5F-4869-89B1-2E585BD38B7A}, 100
  PKEY_Photo_LensModel : TPropertyKey = (
    fmtid : '{E1277516-2B5F-4869-89B1-2E585BD38B7A}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_LensModel}

//  Name:     System.Photo.LightSource -- PKEY_Photo_LightSource
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 37384
//
//  PropertyTagExifLightSource
  PKEY_Photo_LightSource : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 37384);
  {$EXTERNALSYM PKEY_Photo_LightSource}

// Possible discrete values for PKEY_Photo_LightSource are:
  PHOTO_LIGHTSOURCE_UNKNOWN =            0;
  {$EXTERNALSYM PHOTO_LIGHTSOURCE_UNKNOWN}
  PHOTO_LIGHTSOURCE_DAYLIGHT =           1;
  {$EXTERNALSYM PHOTO_LIGHTSOURCE_DAYLIGHT}
  PHOTO_LIGHTSOURCE_FLUORESCENT =        2;
  {$EXTERNALSYM PHOTO_LIGHTSOURCE_FLUORESCENT}
  PHOTO_LIGHTSOURCE_TUNGSTEN =           3;
  {$EXTERNALSYM PHOTO_LIGHTSOURCE_TUNGSTEN}
  PHOTO_LIGHTSOURCE_STANDARD_A =         17;
  {$EXTERNALSYM PHOTO_LIGHTSOURCE_STANDARD_A}
  PHOTO_LIGHTSOURCE_STANDARD_B =         18;
  {$EXTERNALSYM PHOTO_LIGHTSOURCE_STANDARD_B}
  PHOTO_LIGHTSOURCE_STANDARD_C =         19;
  {$EXTERNALSYM PHOTO_LIGHTSOURCE_STANDARD_C}
  PHOTO_LIGHTSOURCE_D55 =                20;
  {$EXTERNALSYM PHOTO_LIGHTSOURCE_D55}
  PHOTO_LIGHTSOURCE_D65 =                21;
  {$EXTERNALSYM PHOTO_LIGHTSOURCE_D65}
  PHOTO_LIGHTSOURCE_D75 =                22;
  {$EXTERNALSYM PHOTO_LIGHTSOURCE_D75}

//  Name:     System.Photo.MakerNote -- PKEY_Photo_MakerNote
//  Type:     Buffer -- VT_VECTOR | VT_UI1  (For variants: VT_ARRAY | VT_UI1)
//  FormatID: {FA303353-B659-4052-85E9-BCAC79549B84}, 100
  PKEY_Photo_MakerNote : TPropertyKey = (
    fmtid : '{FA303353-B659-4052-85E9-BCAC79549B84}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_MakerNote}

//  Name:     System.Photo.MakerNoteOffset -- PKEY_Photo_MakerNoteOffset
//  Type:     UInt64 -- VT_UI8
//  FormatID: {813F4124-34E6-4D17-AB3E-6B1F3C2247A1}, 100
  PKEY_Photo_MakerNoteOffset : TPropertyKey = (
    fmtid : '{813F4124-34E6-4D17-AB3E-6B1F3C2247A1}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_MakerNoteOffset}

//  Name:     System.Photo.MaxAperture -- PKEY_Photo_MaxAperture
//  Type:     Double -- VT_R8
//  FormatID: {08F6D7C2-E3F2-44FC-AF1E-5AA5C81A2D3E}, 100
//
//  Calculated from PKEY_Photo_MaxApertureNumerator and PKEY_Photo_MaxApertureDenominator
  PKEY_Photo_MaxAperture : TPropertyKey = (
    fmtid : '{08F6D7C2-E3F2-44FC-AF1E-5AA5C81A2D3E}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_MaxAperture}

//  Name:     System.Photo.MaxApertureDenominator -- PKEY_Photo_MaxApertureDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {C77724D4-601F-46C5-9B89-C53F93BCEB77}, 100
//
//  Denominator of PKEY_Photo_MaxAperture
  PKEY_Photo_MaxApertureDenominator : TPropertyKey = (
    fmtid : '{C77724D4-601F-46C5-9B89-C53F93BCEB77}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_MaxApertureDenominator}

//  Name:     System.Photo.MaxApertureNumerator -- PKEY_Photo_MaxApertureNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {C107E191-A459-44C5-9AE6-B952AD4B906D}, 100
//
//  Numerator of PKEY_Photo_MaxAperture
  PKEY_Photo_MaxApertureNumerator : TPropertyKey = (
    fmtid : '{C107E191-A459-44C5-9AE6-B952AD4B906D}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_MaxApertureNumerator}

//  Name:     System.Photo.MeteringMode -- PKEY_Photo_MeteringMode
//  Type:     UInt16 -- VT_UI2
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 37383
//
//  PropertyTagExifMeteringMode
  PKEY_Photo_MeteringMode : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 37383);
  {$EXTERNALSYM PKEY_Photo_MeteringMode}

// Possible discrete values for PKEY_Photo_MeteringMode are:
  PHOTO_METERINGMODE_UNKNOWN =           0;
  {$EXTERNALSYM PHOTO_METERINGMODE_UNKNOWN}
  PHOTO_METERINGMODE_AVERAGE =           1;
  {$EXTERNALSYM PHOTO_METERINGMODE_AVERAGE}
  PHOTO_METERINGMODE_CENTER =            2;
  {$EXTERNALSYM PHOTO_METERINGMODE_CENTER}
  PHOTO_METERINGMODE_SPOT =              3;
  {$EXTERNALSYM PHOTO_METERINGMODE_SPOT}
  PHOTO_METERINGMODE_MULTISPOT =         4;
  {$EXTERNALSYM PHOTO_METERINGMODE_MULTISPOT}
  PHOTO_METERINGMODE_PATTERN =           5;
  {$EXTERNALSYM PHOTO_METERINGMODE_PATTERN}
  PHOTO_METERINGMODE_PARTIAL =           6;
  {$EXTERNALSYM PHOTO_METERINGMODE_PARTIAL}

//  Name:     System.Photo.MeteringModeText -- PKEY_Photo_MeteringModeText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {F628FD8C-7BA8-465A-A65B-C5AA79263A9E}, 100
//  
//  This is the user-friendly form of System.Photo.MeteringMode.  Not intended to be parsed 
//  programmatically.
  PKEY_Photo_MeteringModeText : TPropertyKey = (
    fmtid : '{F628FD8C-7BA8-465A-A65B-C5AA79263A9E}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_MeteringModeText}

//  Name:     System.Photo.Orientation -- PKEY_Photo_Orientation
//  Type:     UInt16 -- VT_UI2
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 274 (PropertyTagOrientation)
//  
//  This is the image orientation viewed in terms of rows and columns.
  PKEY_Photo_Orientation : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 274);
  {$EXTERNALSYM PKEY_Photo_Orientation}

// Possible discrete values for PKEY_Photo_Orientation are:
  PHOTO_ORIENTATION_NORMAL =             1;
  {$EXTERNALSYM PHOTO_ORIENTATION_NORMAL}
  PHOTO_ORIENTATION_FLIPHORIZONTAL =     2;
  {$EXTERNALSYM PHOTO_ORIENTATION_FLIPHORIZONTAL}
  PHOTO_ORIENTATION_ROTATE180 =          3;
  {$EXTERNALSYM PHOTO_ORIENTATION_ROTATE180}
  PHOTO_ORIENTATION_FLIPVERTICAL =       4;
  {$EXTERNALSYM PHOTO_ORIENTATION_FLIPVERTICAL}
  PHOTO_ORIENTATION_TRANSPOSE =          5;
  {$EXTERNALSYM PHOTO_ORIENTATION_TRANSPOSE}
  PHOTO_ORIENTATION_ROTATE270 =          6;
  {$EXTERNALSYM PHOTO_ORIENTATION_ROTATE270}
  PHOTO_ORIENTATION_TRANSVERSE =         7;
  {$EXTERNALSYM PHOTO_ORIENTATION_TRANSVERSE}
  PHOTO_ORIENTATION_ROTATE90 =           8;
  {$EXTERNALSYM PHOTO_ORIENTATION_ROTATE90}

//  Name:     System.Photo.OrientationText -- PKEY_Photo_OrientationText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {A9EA193C-C511-498A-A06B-58E2776DCC28}, 100
//  
//  This is the user-friendly form of System.Photo.Orientation.  Not intended to be parsed 
//  programmatically.
  PKEY_Photo_OrientationText : TPropertyKey = (
    fmtid : '{A9EA193C-C511-498A-A06B-58E2776DCC28}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_OrientationText}

//  Name:     System.Photo.PeopleNames -- PKEY_Photo_PeopleNames
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)  Legacy code may treat this as VT_LPSTR.
//  FormatID: {E8309B6E-084C-49B4-B1FC-90A80331B638}, 100
//
//  The people tags on an image.
  PKEY_Photo_PeopleNames : TPropertyKey = (
    fmtid : '{E8309B6E-084C-49B4-B1FC-90A80331B638}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_PeopleNames}

//  Name:     System.Photo.PhotometricInterpretation -- PKEY_Photo_PhotometricInterpretation
//  Type:     UInt16 -- VT_UI2
//  FormatID: {341796F1-1DF9-4B1C-A564-91BDEFA43877}, 100
//  
//  This is the pixel composition. In JPEG compressed data, a JPEG marker is used 
//  instead of this property.
  PKEY_Photo_PhotometricInterpretation : TPropertyKey = (
    fmtid : '{341796F1-1DF9-4B1C-A564-91BDEFA43877}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_PhotometricInterpretation}

// Possible discrete values for PKEY_Photo_PhotometricInterpretation are:
  PHOTO_PHOTOMETRIC_RGB =                2;
  {$EXTERNALSYM PHOTO_PHOTOMETRIC_RGB}
  PHOTO_PHOTOMETRIC_YCBCR =              6;
  {$EXTERNALSYM PHOTO_PHOTOMETRIC_YCBCR}

//  Name:     System.Photo.PhotometricInterpretationText -- PKEY_Photo_PhotometricInterpretationText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {821437D6-9EAB-4765-A589-3B1CBBD22A61}, 100
//  
//  This is the user-friendly form of System.Photo.PhotometricInterpretation.  Not intended to be parsed 
//  programmatically.
  PKEY_Photo_PhotometricInterpretationText : TPropertyKey = (
    fmtid : '{821437D6-9EAB-4765-A589-3B1CBBD22A61}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_PhotometricInterpretationText}

//  Name:     System.Photo.ProgramMode -- PKEY_Photo_ProgramMode
//  Type:     UInt32 -- VT_UI4
//  FormatID: {6D217F6D-3F6A-4825-B470-5F03CA2FBE9B}, 100
//  
//  This is the class of the program used by the camera to set exposure when the 
//  picture is taken.
  PKEY_Photo_ProgramMode : TPropertyKey = (
    fmtid : '{6D217F6D-3F6A-4825-B470-5F03CA2FBE9B}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ProgramMode}

// Possible discrete values for PKEY_Photo_ProgramMode are:
  PHOTO_PROGRAMMODE_NOTDEFINED =         0;
  {$EXTERNALSYM PHOTO_PROGRAMMODE_NOTDEFINED}
  PHOTO_PROGRAMMODE_MANUAL =             1;
  {$EXTERNALSYM PHOTO_PROGRAMMODE_MANUAL}
  PHOTO_PROGRAMMODE_NORMAL =             2;
  {$EXTERNALSYM PHOTO_PROGRAMMODE_NORMAL}
  PHOTO_PROGRAMMODE_APERTURE =           3;
  {$EXTERNALSYM PHOTO_PROGRAMMODE_APERTURE}
  PHOTO_PROGRAMMODE_SHUTTER =            4;
  {$EXTERNALSYM PHOTO_PROGRAMMODE_SHUTTER}
  PHOTO_PROGRAMMODE_CREATIVE =           5;
  {$EXTERNALSYM PHOTO_PROGRAMMODE_CREATIVE}
  PHOTO_PROGRAMMODE_ACTION =             6;
  {$EXTERNALSYM PHOTO_PROGRAMMODE_ACTION}
  PHOTO_PROGRAMMODE_PORTRAIT =           7;
  {$EXTERNALSYM PHOTO_PROGRAMMODE_PORTRAIT}
  PHOTO_PROGRAMMODE_LANDSCAPE =          8;
  {$EXTERNALSYM PHOTO_PROGRAMMODE_LANDSCAPE}

//  Name:     System.Photo.ProgramModeText -- PKEY_Photo_ProgramModeText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {7FE3AA27-2648-42F3-89B0-454E5CB150C3}, 100
//  
//  This is the user-friendly form of System.Photo.ProgramMode.  Not intended to be parsed 
//  programmatically.
  PKEY_Photo_ProgramModeText : TPropertyKey = (
    fmtid : '{7FE3AA27-2648-42F3-89B0-454E5CB150C3}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ProgramModeText}

//  Name:     System.Photo.RelatedSoundFile -- PKEY_Photo_RelatedSoundFile
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {318A6B45-087F-4DC2-B8CC-05359551FC9E}, 100
  PKEY_Photo_RelatedSoundFile : TPropertyKey = (
    fmtid : '{318A6B45-087F-4DC2-B8CC-05359551FC9E}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_RelatedSoundFile}

//  Name:     System.Photo.Saturation -- PKEY_Photo_Saturation
//  Type:     UInt32 -- VT_UI4
//  FormatID: {49237325-A95A-4F67-B211-816B2D45D2E0}, 100
//  
//  This indicates the direction of saturation processing applied by the camera when 
//  the image was shot.
  PKEY_Photo_Saturation : TPropertyKey = (
    fmtid : '{49237325-A95A-4F67-B211-816B2D45D2E0}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_Saturation}

// Possible discrete values for PKEY_Photo_Saturation are:
  PHOTO_SATURATION_NORMAL =              0;
  {$EXTERNALSYM PHOTO_SATURATION_NORMAL}
  PHOTO_SATURATION_LOW =                 1;
  {$EXTERNALSYM PHOTO_SATURATION_LOW}
  PHOTO_SATURATION_HIGH =                2;
  {$EXTERNALSYM PHOTO_SATURATION_HIGH}

//  Name:     System.Photo.SaturationText -- PKEY_Photo_SaturationText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {61478C08-B600-4A84-BBE4-E99C45F0A072}, 100
//  
//  This is the user-friendly form of System.Photo.Saturation.  Not intended to be parsed 
//  programmatically.
  PKEY_Photo_SaturationText : TPropertyKey = (
    fmtid : '{61478C08-B600-4A84-BBE4-E99C45F0A072}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_SaturationText}

//  Name:     System.Photo.Sharpness -- PKEY_Photo_Sharpness
//  Type:     UInt32 -- VT_UI4
//  FormatID: {FC6976DB-8349-4970-AE97-B3C5316A08F0}, 100
//  
//  This indicates the direction of sharpness processing applied by the camera when 
//  the image was shot.
  PKEY_Photo_Sharpness : TPropertyKey = (
    fmtid : '{FC6976DB-8349-4970-AE97-B3C5316A08F0}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_Sharpness}

// Possible discrete values for PKEY_Photo_Sharpness are:
  PHOTO_SHARPNESS_NORMAL =               0;
  {$EXTERNALSYM PHOTO_SHARPNESS_NORMAL}
  PHOTO_SHARPNESS_SOFT =                 1;
  {$EXTERNALSYM PHOTO_SHARPNESS_SOFT}
  PHOTO_SHARPNESS_HARD =                 2;
  {$EXTERNALSYM PHOTO_SHARPNESS_HARD}

//  Name:     System.Photo.SharpnessText -- PKEY_Photo_SharpnessText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {51EC3F47-DD50-421D-8769-334F50424B1E}, 100
//  
//  This is the user-friendly form of System.Photo.Sharpness.  Not intended to be parsed 
//  programmatically.
  PKEY_Photo_SharpnessText : TPropertyKey = (
    fmtid : '{51EC3F47-DD50-421D-8769-334F50424B1E}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_SharpnessText}

//  Name:     System.Photo.ShutterSpeed -- PKEY_Photo_ShutterSpeed
//  Type:     Double -- VT_R8
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 37377
//
//  PropertyTagExifShutterSpeed.  Calculated from PKEY_Photo_ShutterSpeedNumerator and PKEY_Photo_ShutterSpeedDenominator
  PKEY_Photo_ShutterSpeed : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 37377);
  {$EXTERNALSYM PKEY_Photo_ShutterSpeed}

//  Name:     System.Photo.ShutterSpeedDenominator -- PKEY_Photo_ShutterSpeedDenominator
//  Type:     Int32 -- VT_I4
//  FormatID: {E13D8975-81C7-4948-AE3F-37CAE11E8FF7}, 100
//
//  Denominator of PKEY_Photo_ShutterSpeed
  PKEY_Photo_ShutterSpeedDenominator : TPropertyKey = (
    fmtid : '{E13D8975-81C7-4948-AE3F-37CAE11E8FF7}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ShutterSpeedDenominator}

//  Name:     System.Photo.ShutterSpeedNumerator -- PKEY_Photo_ShutterSpeedNumerator
//  Type:     Int32 -- VT_I4
//  FormatID: {16EA4042-D6F4-4BCA-8349-7C78D30FB333}, 100
//
//  Numerator of PKEY_Photo_ShutterSpeed
  PKEY_Photo_ShutterSpeedNumerator : TPropertyKey = (
    fmtid : '{16EA4042-D6F4-4BCA-8349-7C78D30FB333}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_ShutterSpeedNumerator}

//  Name:     System.Photo.SubjectDistance -- PKEY_Photo_SubjectDistance
//  Type:     Double -- VT_R8
//  FormatID: (FMTID_ImageProperties) {14B81DA1-0135-4D31-96D9-6CBFC9671A99}, 37382
//
//  PropertyTagExifSubjectDist.  Calculated from PKEY_Photo_SubjectDistanceNumerator and PKEY_Photo_SubjectDistanceDenominator
  PKEY_Photo_SubjectDistance : TPropertyKey = (
    fmtid : '{14B81DA1-0135-4D31-96D9-6CBFC9671A99}'; pid : 37382);
  {$EXTERNALSYM PKEY_Photo_SubjectDistance}

//  Name:     System.Photo.SubjectDistanceDenominator -- PKEY_Photo_SubjectDistanceDenominator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {0C840A88-B043-466D-9766-D4B26DA3FA77}, 100
//
//  Denominator of PKEY_Photo_SubjectDistance
  PKEY_Photo_SubjectDistanceDenominator : TPropertyKey = (
    fmtid : '{0C840A88-B043-466D-9766-D4B26DA3FA77}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_SubjectDistanceDenominator}

//  Name:     System.Photo.SubjectDistanceNumerator -- PKEY_Photo_SubjectDistanceNumerator
//  Type:     UInt32 -- VT_UI4
//  FormatID: {8AF4961C-F526-43E5-AA81-DB768219178D}, 100
//
//  Numerator of PKEY_Photo_SubjectDistance
  PKEY_Photo_SubjectDistanceNumerator : TPropertyKey = (
    fmtid : '{8AF4961C-F526-43E5-AA81-DB768219178D}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_SubjectDistanceNumerator}

//  Name:     System.Photo.TagViewAggregate -- PKEY_Photo_TagViewAggregate
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)  Legacy code may treat this as VT_LPSTR.
//  FormatID: {B812F15D-C2D8-4BBF-BACD-79744346113F}, 100
//
//  A read-only aggregation of tag-like properties for use in building views.
  PKEY_Photo_TagViewAggregate : TPropertyKey = (
    fmtid : '{B812F15D-C2D8-4BBF-BACD-79744346113F}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_TagViewAggregate}

//  Name:     System.Photo.TranscodedForSync -- PKEY_Photo_TranscodedForSync
//  Type:     Boolean -- VT_BOOL
//  FormatID: {9A8EBB75-6458-4E82-BACB-35C0095B03BB}, 100
  PKEY_Photo_TranscodedForSync : TPropertyKey = (
    fmtid : '{9A8EBB75-6458-4E82-BACB-35C0095B03BB}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_TranscodedForSync}

//  Name:     System.Photo.WhiteBalance -- PKEY_Photo_WhiteBalance
//  Type:     UInt32 -- VT_UI4
//  FormatID: {EE3D3D8A-5381-4CFA-B13B-AAF66B5F4EC9}, 100
//  
//  This indicates the white balance mode set when the image was shot.
  PKEY_Photo_WhiteBalance : TPropertyKey = (
    fmtid : '{EE3D3D8A-5381-4CFA-B13B-AAF66B5F4EC9}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_WhiteBalance}

// Possible discrete values for PKEY_Photo_WhiteBalance are:
  PHOTO_WHITEBALANCE_AUTO =              0;
  {$EXTERNALSYM PHOTO_WHITEBALANCE_AUTO}
  PHOTO_WHITEBALANCE_MANUAL =            1;
  {$EXTERNALSYM PHOTO_WHITEBALANCE_MANUAL}

//  Name:     System.Photo.WhiteBalanceText -- PKEY_Photo_WhiteBalanceText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {6336B95E-C7A7-426D-86FD-7AE3D39C84B4}, 100
//  
//  This is the user-friendly form of System.Photo.WhiteBalance.  Not intended to be parsed 
//  programmatically.
  PKEY_Photo_WhiteBalanceText : TPropertyKey = (
    fmtid : '{6336B95E-C7A7-426D-86FD-7AE3D39C84B4}'; pid : 100);
  {$EXTERNALSYM PKEY_Photo_WhiteBalanceText}
 
//-----------------------------------------------------------------------------
// PropGroup properties

//  Name:     System.PropGroup.Advanced -- PKEY_PropGroup_Advanced
//  Type:     Null -- VT_NULL
//  FormatID: {900A403B-097B-4B95-8AE2-071FDAEEB118}, 100
  PKEY_PropGroup_Advanced : TPropertyKey = (
    fmtid : '{900A403B-097B-4B95-8AE2-071FDAEEB118}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Advanced}

//  Name:     System.PropGroup.Audio -- PKEY_PropGroup_Audio
//  Type:     Null -- VT_NULL
//  FormatID: {2804D469-788F-48AA-8570-71B9C187E138}, 100
  PKEY_PropGroup_Audio : TPropertyKey = (
    fmtid : '{2804D469-788F-48AA-8570-71B9C187E138}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Audio}

//  Name:     System.PropGroup.Calendar -- PKEY_PropGroup_Calendar
//  Type:     Null -- VT_NULL
//  FormatID: {9973D2B5-BFD8-438A-BA94-5349B293181A}, 100
  PKEY_PropGroup_Calendar : TPropertyKey = (
    fmtid : '{9973D2B5-BFD8-438A-BA94-5349B293181A}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Calendar}

//  Name:     System.PropGroup.Camera -- PKEY_PropGroup_Camera
//  Type:     Null -- VT_NULL
//  FormatID: {DE00DE32-547E-4981-AD4B-542F2E9007D8}, 100
  PKEY_PropGroup_Camera : TPropertyKey = (
    fmtid : '{DE00DE32-547E-4981-AD4B-542F2E9007D8}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Camera}

//  Name:     System.PropGroup.Contact -- PKEY_PropGroup_Contact
//  Type:     Null -- VT_NULL
//  FormatID: {DF975FD3-250A-4004-858F-34E29A3E37AA}, 100
  PKEY_PropGroup_Contact : TPropertyKey = (
    fmtid : '{DF975FD3-250A-4004-858F-34E29A3E37AA}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Contact}

//  Name:     System.PropGroup.Content -- PKEY_PropGroup_Content
//  Type:     Null -- VT_NULL
//  FormatID: {D0DAB0BA-368A-4050-A882-6C010FD19A4F}, 100
  PKEY_PropGroup_Content : TPropertyKey = (
    fmtid : '{D0DAB0BA-368A-4050-A882-6C010FD19A4F}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Content}

//  Name:     System.PropGroup.Description -- PKEY_PropGroup_Description
//  Type:     Null -- VT_NULL
//  FormatID: {8969B275-9475-4E00-A887-FF93B8B41E44}, 100
  PKEY_PropGroup_Description : TPropertyKey = (
    fmtid : '{8969B275-9475-4E00-A887-FF93B8B41E44}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Description}

//  Name:     System.PropGroup.FileSystem -- PKEY_PropGroup_FileSystem
//  Type:     Null -- VT_NULL
//  FormatID: {E3A7D2C1-80FC-4B40-8F34-30EA111BDC2E}, 100
  PKEY_PropGroup_FileSystem : TPropertyKey = (
    fmtid : '{E3A7D2C1-80FC-4B40-8F34-30EA111BDC2E}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_FileSystem}

//  Name:     System.PropGroup.General -- PKEY_PropGroup_General
//  Type:     Null -- VT_NULL
//  FormatID: {CC301630-B192-4C22-B372-9F4C6D338E07}, 100
  PKEY_PropGroup_General : TPropertyKey = (
    fmtid : '{CC301630-B192-4C22-B372-9F4C6D338E07}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_General}

//  Name:     System.PropGroup.GPS -- PKEY_PropGroup_GPS
//  Type:     Null -- VT_NULL
//  FormatID: {F3713ADA-90E3-4E11-AAE5-FDC17685B9BE}, 100
  PKEY_PropGroup_GPS : TPropertyKey = (
    fmtid : '{F3713ADA-90E3-4E11-AAE5-FDC17685B9BE}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_GPS}

//  Name:     System.PropGroup.Image -- PKEY_PropGroup_Image
//  Type:     Null -- VT_NULL
//  FormatID: {E3690A87-0FA8-4A2A-9A9F-FCE8827055AC}, 100
  PKEY_PropGroup_Image : TPropertyKey = (
    fmtid : '{E3690A87-0FA8-4A2A-9A9F-FCE8827055AC}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Image}

//  Name:     System.PropGroup.Media -- PKEY_PropGroup_Media
//  Type:     Null -- VT_NULL
//  FormatID: {61872CF7-6B5E-4B4B-AC2D-59DA84459248}, 100
  PKEY_PropGroup_Media : TPropertyKey = (
    fmtid : '{61872CF7-6B5E-4B4B-AC2D-59DA84459248}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Media}

//  Name:     System.PropGroup.MediaAdvanced -- PKEY_PropGroup_MediaAdvanced
//  Type:     Null -- VT_NULL
//  FormatID: {8859A284-DE7E-4642-99BA-D431D044B1EC}, 100
  PKEY_PropGroup_MediaAdvanced : TPropertyKey = (
    fmtid : '{8859A284-DE7E-4642-99BA-D431D044B1EC}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_MediaAdvanced}

//  Name:     System.PropGroup.Message -- PKEY_PropGroup_Message
//  Type:     Null -- VT_NULL
//  FormatID: {7FD7259D-16B4-4135-9F97-7C96ECD2FA9E}, 100
  PKEY_PropGroup_Message : TPropertyKey = (
    fmtid : '{7FD7259D-16B4-4135-9F97-7C96ECD2FA9E}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Message}

//  Name:     System.PropGroup.Music -- PKEY_PropGroup_Music
//  Type:     Null -- VT_NULL
//  FormatID: {68DD6094-7216-40F1-A029-43FE7127043F}, 100
  PKEY_PropGroup_Music : TPropertyKey = (
    fmtid : '{68DD6094-7216-40F1-A029-43FE7127043F}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Music}

//  Name:     System.PropGroup.Origin -- PKEY_PropGroup_Origin
//  Type:     Null -- VT_NULL
//  FormatID: {2598D2FB-5569-4367-95DF-5CD3A177E1A5}, 100
  PKEY_PropGroup_Origin : TPropertyKey = (
    fmtid : '{2598D2FB-5569-4367-95DF-5CD3A177E1A5}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Origin}

//  Name:     System.PropGroup.PhotoAdvanced -- PKEY_PropGroup_PhotoAdvanced
//  Type:     Null -- VT_NULL
//  FormatID: {0CB2BF5A-9EE7-4A86-8222-F01E07FDADAF}, 100
  PKEY_PropGroup_PhotoAdvanced : TPropertyKey = (
    fmtid : '{0CB2BF5A-9EE7-4A86-8222-F01E07FDADAF}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_PhotoAdvanced}

//  Name:     System.PropGroup.RecordedTV -- PKEY_PropGroup_RecordedTV
//  Type:     Null -- VT_NULL
//  FormatID: {E7B33238-6584-4170-A5C0-AC25EFD9DA56}, 100
  PKEY_PropGroup_RecordedTV : TPropertyKey = (
    fmtid : '{E7B33238-6584-4170-A5C0-AC25EFD9DA56}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_RecordedTV}

//  Name:     System.PropGroup.Video -- PKEY_PropGroup_Video
//  Type:     Null -- VT_NULL
//  FormatID: {BEBE0920-7671-4C54-A3EB-49FDDFC191EE}, 100
  PKEY_PropGroup_Video : TPropertyKey = (
    fmtid : '{BEBE0920-7671-4C54-A3EB-49FDDFC191EE}'; pid : 100);
  {$EXTERNALSYM PKEY_PropGroup_Video}
 
//-----------------------------------------------------------------------------
// PropList properties



//  Name:     System.InfoTipText -- PKEY_InfoTipText
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 17
//  
//  The text (with formatted property values) to show in the infotip.
  PKEY_InfoTipText : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 17);
  {$EXTERNALSYM PKEY_InfoTipText}

//  Name:     System.PropList.ConflictPrompt -- PKEY_PropList_ConflictPrompt
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 11
//  
//  The list of properties to show in the file operation conflict resolution dialog. Properties with empty 
//  values will not be displayed. Register under the regvalue of "ConflictPrompt".
  PKEY_PropList_ConflictPrompt : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 11);
  {$EXTERNALSYM PKEY_PropList_ConflictPrompt}

//  Name:     System.PropList.ContentViewModeForBrowse -- PKEY_PropList_ContentViewModeForBrowse
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 13
//  
//  The list of properties to show in the content view mode of an item in the context of browsing.
//  Register the regvalue under the name of "ContentViewModeForBrowse".
  PKEY_PropList_ContentViewModeForBrowse : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 13);
  {$EXTERNALSYM PKEY_PropList_ContentViewModeForBrowse}

//  Name:     System.PropList.ContentViewModeForSearch -- PKEY_PropList_ContentViewModeForSearch
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 14
//  
//  The list of properties to show in the content view mode of an item in the context of searching.
//  Register the regvalue under the name of "ContentViewModeForSearch".
  PKEY_PropList_ContentViewModeForSearch : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 14);
  {$EXTERNALSYM PKEY_PropList_ContentViewModeForSearch}

//  Name:     System.PropList.ExtendedTileInfo -- PKEY_PropList_ExtendedTileInfo
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 9
//  
//  The list of properties to show in the listview on extended tiles. Register under the regvalue of 
//  "ExtendedTileInfo".
  PKEY_PropList_ExtendedTileInfo : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 9);
  {$EXTERNALSYM PKEY_PropList_ExtendedTileInfo}

//  Name:     System.PropList.FileOperationPrompt -- PKEY_PropList_FileOperationPrompt
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 10
//  
//  The list of properties to show in the file operation confirmation dialog. Properties with empty values 
//  will not be displayed. If this list is not specified, then the InfoTip property list is used instead. 
//  Register under the regvalue of "FileOperationPrompt".
  PKEY_PropList_FileOperationPrompt : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 10);
  {$EXTERNALSYM PKEY_PropList_FileOperationPrompt}

//  Name:     System.PropList.FullDetails -- PKEY_PropList_FullDetails
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 2
//  
//  The list of all the properties to show in the details page.  Property groups can be included in this list 
//  in order to more easily organize the UI.  Register under the regvalue of "FullDetails".
  PKEY_PropList_FullDetails : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 2);
  {$EXTERNALSYM PKEY_PropList_FullDetails}

//  Name:     System.PropList.InfoTip -- PKEY_PropList_InfoTip
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 4 (PID_PROPLIST_INFOTIP)
//  
//  The list of properties to show in the infotip. Properties with empty values will not be displayed. Register 
//  under the regvalue of "InfoTip".
  PKEY_PropList_InfoTip : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 4);
  {$EXTERNALSYM PKEY_PropList_InfoTip}

//  Name:     System.PropList.NonPersonal -- PKEY_PropList_NonPersonal
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {49D1091F-082E-493F-B23F-D2308AA9668C}, 100
//  
//  The list of properties that are considered 'non-personal'. When told to remove all non-personal properties 
//  from a given file, the system will leave these particular properties untouched. Register under the regvalue 
//  of "NonPersonal".
  PKEY_PropList_NonPersonal : TPropertyKey = (
    fmtid : '{49D1091F-082E-493F-B23F-D2308AA9668C}'; pid : 100);
  {$EXTERNALSYM PKEY_PropList_NonPersonal}

//  Name:     System.PropList.PreviewDetails -- PKEY_PropList_PreviewDetails
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 8
//
//  The list of properties to display in the preview pane.  Register under the regvalue of "PreviewDetails".
  PKEY_PropList_PreviewDetails : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 8);
  {$EXTERNALSYM PKEY_PropList_PreviewDetails}

//  Name:     System.PropList.PreviewTitle -- PKEY_PropList_PreviewTitle
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 6
//  
//  The one or two properties to display in the preview pane title section.  The optional second property is 
//  displayed as a subtitle.  Register under the regvalue of "PreviewTitle".
  PKEY_PropList_PreviewTitle : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 6);
  {$EXTERNALSYM PKEY_PropList_PreviewTitle}

//  Name:     System.PropList.QuickTip -- PKEY_PropList_QuickTip
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 5 (PID_PROPLIST_QUICKTIP)
//  
//  The list of properties to show in the infotip when the item is on a slow network. Properties with empty 
//  values will not be displayed. Register under the regvalue of "QuickTip".
  PKEY_PropList_QuickTip : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 5);
  {$EXTERNALSYM PKEY_PropList_QuickTip}

//  Name:     System.PropList.TileInfo -- PKEY_PropList_TileInfo
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {C9944A21-A406-48FE-8225-AEC7E24C211B}, 3 (PID_PROPLIST_TILEINFO)
//  
//  The list of properties to show in the listview on tiles. Register under the regvalue of "TileInfo".
  PKEY_PropList_TileInfo : TPropertyKey = (
    fmtid : '{C9944A21-A406-48FE-8225-AEC7E24C211B}'; pid : 3);
  {$EXTERNALSYM PKEY_PropList_TileInfo}

//  Name:     System.PropList.XPDetailsPanel -- PKEY_PropList_XPDetailsPanel
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_WebView) {F2275480-F782-4291-BD94-F13693513AEC}, 0 (PID_DISPLAY_PROPERTIES)
//
//  The list of properties to display in the XP webview details panel. Obsolete.
  PKEY_PropList_XPDetailsPanel : TPropertyKey = (
    fmtid : '{F2275480-F782-4291-BD94-F13693513AEC}'; pid : 0);
  {$EXTERNALSYM PKEY_PropList_XPDetailsPanel}
 
//-----------------------------------------------------------------------------
// RecordedTV properties



//  Name:     System.RecordedTV.ChannelNumber -- PKEY_RecordedTV_ChannelNumber
//  Type:     UInt32 -- VT_UI4
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 7
//
//  Example: 42
  PKEY_RecordedTV_ChannelNumber : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 7);
  {$EXTERNALSYM PKEY_RecordedTV_ChannelNumber}

//  Name:     System.RecordedTV.Credits -- PKEY_RecordedTV_Credits
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 4
//
//  Example: "Don Messick/Frank Welker/Casey Kasem/Heather North/Nicole Jaffe;;;"
  PKEY_RecordedTV_Credits : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 4);
  {$EXTERNALSYM PKEY_RecordedTV_Credits}

//  Name:     System.RecordedTV.DateContentExpires -- PKEY_RecordedTV_DateContentExpires
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 15
  PKEY_RecordedTV_DateContentExpires : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 15);
  {$EXTERNALSYM PKEY_RecordedTV_DateContentExpires}

//  Name:     System.RecordedTV.EpisodeName -- PKEY_RecordedTV_EpisodeName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 2
//
//  Example: "Nowhere to Hyde"
  PKEY_RecordedTV_EpisodeName : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 2);
  {$EXTERNALSYM PKEY_RecordedTV_EpisodeName}

//  Name:     System.RecordedTV.IsATSCContent -- PKEY_RecordedTV_IsATSCContent
//  Type:     Boolean -- VT_BOOL
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 16
  PKEY_RecordedTV_IsATSCContent : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 16);
  {$EXTERNALSYM PKEY_RecordedTV_IsATSCContent}

//  Name:     System.RecordedTV.IsClosedCaptioningAvailable -- PKEY_RecordedTV_IsClosedCaptioningAvailable
//  Type:     Boolean -- VT_BOOL
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 12
  PKEY_RecordedTV_IsClosedCaptioningAvailable : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 12);
  {$EXTERNALSYM PKEY_RecordedTV_IsClosedCaptioningAvailable}

//  Name:     System.RecordedTV.IsDTVContent -- PKEY_RecordedTV_IsDTVContent
//  Type:     Boolean -- VT_BOOL
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 17
  PKEY_RecordedTV_IsDTVContent : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 17);
  {$EXTERNALSYM PKEY_RecordedTV_IsDTVContent}

//  Name:     System.RecordedTV.IsHDContent -- PKEY_RecordedTV_IsHDContent
//  Type:     Boolean -- VT_BOOL
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 18
  PKEY_RecordedTV_IsHDContent : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 18);
  {$EXTERNALSYM PKEY_RecordedTV_IsHDContent}

//  Name:     System.RecordedTV.IsRepeatBroadcast -- PKEY_RecordedTV_IsRepeatBroadcast
//  Type:     Boolean -- VT_BOOL
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 13
  PKEY_RecordedTV_IsRepeatBroadcast : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 13);
  {$EXTERNALSYM PKEY_RecordedTV_IsRepeatBroadcast}

//  Name:     System.RecordedTV.IsSAP -- PKEY_RecordedTV_IsSAP
//  Type:     Boolean -- VT_BOOL
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 14
  PKEY_RecordedTV_IsSAP : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 14);
  {$EXTERNALSYM PKEY_RecordedTV_IsSAP}

//  Name:     System.RecordedTV.NetworkAffiliation -- PKEY_RecordedTV_NetworkAffiliation
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {2C53C813-FB63-4E22-A1AB-0B331CA1E273}, 100
  PKEY_RecordedTV_NetworkAffiliation : TPropertyKey = (
    fmtid : '{2C53C813-FB63-4E22-A1AB-0B331CA1E273}'; pid : 100);
  {$EXTERNALSYM PKEY_RecordedTV_NetworkAffiliation}

//  Name:     System.RecordedTV.OriginalBroadcastDate -- PKEY_RecordedTV_OriginalBroadcastDate
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {4684FE97-8765-4842-9C13-F006447B178C}, 100
  PKEY_RecordedTV_OriginalBroadcastDate : TPropertyKey = (
    fmtid : '{4684FE97-8765-4842-9C13-F006447B178C}'; pid : 100);
  {$EXTERNALSYM PKEY_RecordedTV_OriginalBroadcastDate}

//  Name:     System.RecordedTV.ProgramDescription -- PKEY_RecordedTV_ProgramDescription
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 3
  PKEY_RecordedTV_ProgramDescription : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 3);
  {$EXTERNALSYM PKEY_RecordedTV_ProgramDescription}

//  Name:     System.RecordedTV.RecordingTime -- PKEY_RecordedTV_RecordingTime
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {A5477F61-7A82-4ECA-9DDE-98B69B2479B3}, 100
  PKEY_RecordedTV_RecordingTime : TPropertyKey = (
    fmtid : '{A5477F61-7A82-4ECA-9DDE-98B69B2479B3}'; pid : 100);
  {$EXTERNALSYM PKEY_RecordedTV_RecordingTime}

//  Name:     System.RecordedTV.StationCallSign -- PKEY_RecordedTV_StationCallSign
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {6D748DE2-8D38-4CC3-AC60-F009B057C557}, 5
//
//  Example: "TOONP"
  PKEY_RecordedTV_StationCallSign : TPropertyKey = (
    fmtid : '{6D748DE2-8D38-4CC3-AC60-F009B057C557}'; pid : 5);
  {$EXTERNALSYM PKEY_RecordedTV_StationCallSign}

//  Name:     System.RecordedTV.StationName -- PKEY_RecordedTV_StationName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {1B5439E7-EBA1-4AF8-BDD7-7AF1D4549493}, 100
  PKEY_RecordedTV_StationName : TPropertyKey = (
    fmtid : '{1B5439E7-EBA1-4AF8-BDD7-7AF1D4549493}'; pid : 100);
  {$EXTERNALSYM PKEY_RecordedTV_StationName}
 
//-----------------------------------------------------------------------------
// Search properties



//  Name:     System.Search.AutoSummary -- PKEY_Search_AutoSummary
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {560C36C0-503A-11CF-BAA1-00004C752A9A}, 2
//
//  General Summary of the document.
  PKEY_Search_AutoSummary : TPropertyKey = (
    fmtid : '{560C36C0-503A-11CF-BAA1-00004C752A9A}'; pid : 2);
  {$EXTERNALSYM PKEY_Search_AutoSummary}

//  Name:     System.Search.ContainerHash -- PKEY_Search_ContainerHash
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {BCEEE283-35DF-4D53-826A-F36A3EEFC6BE}, 100
//
//  Hash code used to identify attachments to be deleted based on a common container url
  PKEY_Search_ContainerHash : TPropertyKey = (
    fmtid : '{BCEEE283-35DF-4D53-826A-F36A3EEFC6BE}'; pid : 100);
  {$EXTERNALSYM PKEY_Search_ContainerHash}

//  Name:     System.Search.Contents -- PKEY_Search_Contents
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_Storage) {B725F130-47EF-101A-A5F1-02608C9EEBAC}, 19 (PID_STG_CONTENTS)
//  
//  The contents of the item. This property is for query restrictions only; it cannot be retrieved in a 
//  query result. The Indexing Service friendly name is 'contents'.
  PKEY_Search_Contents : TPropertyKey = (
    fmtid : '{B725F130-47EF-101A-A5F1-02608C9EEBAC}'; pid : 19);
  {$EXTERNALSYM PKEY_Search_Contents}

//  Name:     System.Search.EntryID -- PKEY_Search_EntryID
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_Query) {49691C90-7E17-101A-A91C-08002B2ECDA9}, 5 (PROPID_QUERY_WORKID)
//  
//  The entry ID for an item within a given catalog in the Windows Search Index.
//  This value may be recycled, and therefore is not considered unique over time.
  PKEY_Search_EntryID : TPropertyKey = (
    fmtid : '{49691C90-7E17-101A-A91C-08002B2ECDA9}'; pid : 5);
  {$EXTERNALSYM PKEY_Search_EntryID}

//  Name:     System.Search.ExtendedProperties -- PKEY_Search_ExtendedProperties
//  Type:     Blob -- VT_BLOB
//  FormatID: {7B03B546-FA4F-4A52-A2FE-03D5311E5865}, 100
  PKEY_Search_ExtendedProperties : TPropertyKey = (
    fmtid : '{7B03B546-FA4F-4A52-A2FE-03D5311E5865}'; pid : 100);
  {$EXTERNALSYM PKEY_Search_ExtendedProperties}

//  Name:     System.Search.GatherTime -- PKEY_Search_GatherTime
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {0B63E350-9CCC-11D0-BCDB-00805FCCCE04}, 8
//
//  The Datetime that the Windows Search Gatherer process last pushed properties of this document to the Windows Search Gatherer Plugins.
  PKEY_Search_GatherTime : TPropertyKey = (
    fmtid : '{0B63E350-9CCC-11D0-BCDB-00805FCCCE04}'; pid : 8);
  {$EXTERNALSYM PKEY_Search_GatherTime}

//  Name:     System.Search.HitCount -- PKEY_Search_HitCount
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_Query) {49691C90-7E17-101A-A91C-08002B2ECDA9}, 4 (PROPID_QUERY_HITCOUNT)
//  
//  When using CONTAINS over the Windows Search Index, this is the number of matches of the term.
//  If there are multiple CONTAINS, an AND computes the min number of hits and an OR the max number of hits.
  PKEY_Search_HitCount : TPropertyKey = (
    fmtid : '{49691C90-7E17-101A-A91C-08002B2ECDA9}'; pid : 4);
  {$EXTERNALSYM PKEY_Search_HitCount}

//  Name:     System.Search.IsClosedDirectory -- PKEY_Search_IsClosedDirectory
//  Type:     Boolean -- VT_BOOL
//  FormatID: {0B63E343-9CCC-11D0-BCDB-00805FCCCE04}, 23
//
//  If this property is emitted with a value of TRUE, then it indicates that this URL's last modified time applies to all of it's children, and if this URL is deleted then all of it's children are deleted as well.  For example, this would be emitted as TRUE when emitting the URL of an email so that all attachments are tied to the last modified time of that email.
  PKEY_Search_IsClosedDirectory : TPropertyKey = (
    fmtid : '{0B63E343-9CCC-11D0-BCDB-00805FCCCE04}'; pid : 23);
  {$EXTERNALSYM PKEY_Search_IsClosedDirectory}

//  Name:     System.Search.IsFullyContained -- PKEY_Search_IsFullyContained
//  Type:     Boolean -- VT_BOOL
//  FormatID: {0B63E343-9CCC-11D0-BCDB-00805FCCCE04}, 24
//
//  Any child URL of a URL which has System.Search.IsClosedDirectory=TRUE must emit System.Search.IsFullyContained=TRUE.  This ensures that the URL is not deleted at the end of a crawl because it hasn't been visited (which is the normal mechanism for detecting deletes).  For example an email attachment would emit this property
  PKEY_Search_IsFullyContained : TPropertyKey = (
    fmtid : '{0B63E343-9CCC-11D0-BCDB-00805FCCCE04}'; pid : 24);
  {$EXTERNALSYM PKEY_Search_IsFullyContained}

//  Name:     System.Search.QueryFocusedSummary -- PKEY_Search_QueryFocusedSummary
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {560C36C0-503A-11CF-BAA1-00004C752A9A}, 3
//
//  Query Focused Summary of the document.
  PKEY_Search_QueryFocusedSummary : TPropertyKey = (
    fmtid : '{560C36C0-503A-11CF-BAA1-00004C752A9A}'; pid : 3);
  {$EXTERNALSYM PKEY_Search_QueryFocusedSummary}

//  Name:     System.Search.QueryFocusedSummaryWithFallback -- PKEY_Search_QueryFocusedSummaryWithFallback
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {560C36C0-503A-11CF-BAA1-00004C752A9A}, 4
//
//  Query Focused Summary of the document, if none is available it returns the AutoSummary.
  PKEY_Search_QueryFocusedSummaryWithFallback : TPropertyKey = (
    fmtid : '{560C36C0-503A-11CF-BAA1-00004C752A9A}'; pid : 4);
  {$EXTERNALSYM PKEY_Search_QueryFocusedSummaryWithFallback}

//  Name:     System.Search.Rank -- PKEY_Search_Rank
//  Type:     Int32 -- VT_I4
//  FormatID: (FMTID_Query) {49691C90-7E17-101A-A91C-08002B2ECDA9}, 3 (PROPID_QUERY_RANK)
//  
//  Relevance rank of row. Ranges from 0-1000. Larger numbers = better matches.  Query-time only.
  PKEY_Search_Rank : TPropertyKey = (
    fmtid : '{49691C90-7E17-101A-A91C-08002B2ECDA9}'; pid : 3);
  {$EXTERNALSYM PKEY_Search_Rank}

//  Name:     System.Search.Store -- PKEY_Search_Store
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {A06992B3-8CAF-4ED7-A547-B259E32AC9FC}, 100
//
//  The identifier for the protocol handler that produced this item. (E.g. MAPI, CSC, FILE etc.)
  PKEY_Search_Store : TPropertyKey = (
    fmtid : '{A06992B3-8CAF-4ED7-A547-B259E32AC9FC}'; pid : 100);
  {$EXTERNALSYM PKEY_Search_Store}

//  Name:     System.Search.UrlToIndex -- PKEY_Search_UrlToIndex
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {0B63E343-9CCC-11D0-BCDB-00805FCCCE04}, 2
//
//  This property should be emitted by a container IFilter for each child URL within the container.  The children will eventually be crawled by the indexer if they are within scope.
  PKEY_Search_UrlToIndex : TPropertyKey = (
    fmtid : '{0B63E343-9CCC-11D0-BCDB-00805FCCCE04}'; pid : 2);
  {$EXTERNALSYM PKEY_Search_UrlToIndex}

//  Name:     System.Search.UrlToIndexWithModificationTime -- PKEY_Search_UrlToIndexWithModificationTime
//  Type:     Multivalue Any -- VT_VECTOR | VT_NULL  (For variants: VT_ARRAY | VT_NULL)
//  FormatID: {0B63E343-9CCC-11D0-BCDB-00805FCCCE04}, 12
//
//  This property is the same as System.Search.UrlToIndex except that it includes the time the URL was last modified.  This is an optimization for the indexer as it doesn't have to call back into the protocol handler to ask for this information to determine if the content needs to be indexed again.  The property is a vector with two elements, a VT_LPWSTR with the URL and a VT_FILETIME for the last modified time.
  PKEY_Search_UrlToIndexWithModificationTime : TPropertyKey = (
    fmtid : '{0B63E343-9CCC-11D0-BCDB-00805FCCCE04}'; pid : 12);
  {$EXTERNALSYM PKEY_Search_UrlToIndexWithModificationTime}
 
//-----------------------------------------------------------------------------
// Shell properties



//  Name:     System.DescriptionID -- PKEY_DescriptionID
//  Type:     Buffer -- VT_VECTOR | VT_UI1  (For variants: VT_ARRAY | VT_UI1)
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 2 (PID_DESCRIPTIONID)
//
//  The contents of a SHDESCRIPTIONID structure as a buffer of bytes.
  PKEY_DescriptionID : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 2);
  {$EXTERNALSYM PKEY_DescriptionID}

//  Name:     System.InternalName -- PKEY_InternalName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSFMTID_VERSION) {0CEF7D53-FA64-11D1-A203-0000F81FEDEE}, 5 (PIDVSI_InternalName)
//
//  
  PKEY_InternalName : TPropertyKey = (
    fmtid : '{0CEF7D53-FA64-11D1-A203-0000F81FEDEE}'; pid : 5);
  {$EXTERNALSYM PKEY_InternalName}

//  Name:     System.Link.TargetSFGAOFlagsStrings -- PKEY_Link_TargetSFGAOFlagsStrings
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {D6942081-D53B-443D-AD47-5E059D9CD27A}, 3
//  
//  Expresses the SFGAO flags of a link as string values and is used as a query optimization.  See 
//  PKEY_Shell_SFGAOFlagsStrings for possible values of this.
  PKEY_Link_TargetSFGAOFlagsStrings : TPropertyKey = (
    fmtid : '{D6942081-D53B-443D-AD47-5E059D9CD27A}'; pid : 3);
  {$EXTERNALSYM PKEY_Link_TargetSFGAOFlagsStrings}

//  Name:     System.Link.TargetUrl -- PKEY_Link_TargetUrl
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {5CBF2787-48CF-4208-B90E-EE5E5D420294}, 2  (PKEYs relating to URLs.  Used by IE History.)
  PKEY_Link_TargetUrl : TPropertyKey = (
    fmtid : '{5CBF2787-48CF-4208-B90E-EE5E5D420294}'; pid : 2);
  {$EXTERNALSYM PKEY_Link_TargetUrl}

//  Name:     System.NamespaceCLSID -- PKEY_NamespaceCLSID
//  Type:     Guid -- VT_CLSID
//  FormatID: (FMTID_ShellDetails) {28636AA6-953D-11D2-B5D6-00C04FD918D0}, 6
//
//  The CLSID of the name space extension for an item, the object that implements IShellFolder for this item
  PKEY_NamespaceCLSID : TPropertyKey = (
    fmtid : '{28636AA6-953D-11D2-B5D6-00C04FD918D0}'; pid : 6);
  {$EXTERNALSYM PKEY_NamespaceCLSID}

//  Name:     System.Shell.SFGAOFlagsStrings -- PKEY_Shell_SFGAOFlagsStrings
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: {D6942081-D53B-443D-AD47-5E059D9CD27A}, 2
//
//  Expresses the SFGAO flags as string values and is used as a query optimization.
  PKEY_Shell_SFGAOFlagsStrings : TPropertyKey = (
    fmtid : '{D6942081-D53B-443D-AD47-5E059D9CD27A}'; pid : 2);
  {$EXTERNALSYM PKEY_Shell_SFGAOFlagsStrings}

// Possible discrete values for PKEY_Shell_SFGAOFlagsStrings are:
  SFGAOSTR_FILESYS =                     'filesys';     // SFGAO_FILESYSTEM
  {$EXTERNALSYM SFGAOSTR_FILESYS}
  SFGAOSTR_FILEANC =                     'fileanc';     // SFGAO_FILESYSANCESTOR
  {$EXTERNALSYM SFGAOSTR_FILEANC}
  SFGAOSTR_STORAGEANC =                  'storageanc';  // SFGAO_STORAGEANCESTOR
  {$EXTERNALSYM SFGAOSTR_STORAGEANC}
  SFGAOSTR_STREAM =                      'stream';      // SFGAO_STREAM
  {$EXTERNALSYM SFGAOSTR_STREAM}
  SFGAOSTR_LINK =                        'link';        // SFGAO_LINK
  {$EXTERNALSYM SFGAOSTR_LINK}
  SFGAOSTR_HIDDEN =                      'hidden';      // SFGAO_HIDDEN
  {$EXTERNALSYM SFGAOSTR_HIDDEN}
  SFGAOSTR_SUPERHIDDEN =                 'superhidden'; // SFGAO_SUPERHIDDEN
  {$EXTERNALSYM SFGAOSTR_SUPERHIDDEN}
  SFGAOSTR_FOLDER =                      'folder';      // SFGAO_FOLDER
  {$EXTERNALSYM SFGAOSTR_FOLDER}
  SFGAOSTR_NONENUM =                     'nonenum';     // SFGAO_NONENUMERATED
  {$EXTERNALSYM SFGAOSTR_NONENUM}
  SFGAOSTR_BROWSABLE =                   'browsable';   // SFGAO_BROWSABLE
  {$EXTERNALSYM SFGAOSTR_BROWSABLE}
 
//-----------------------------------------------------------------------------
// Software properties



//  Name:     System.AppUserModel.ExcludeFromShowInNewInstall -- PKEY_AppUserModel_ExcludeFromShowInNewInstall
//  Type:     Boolean -- VT_BOOL
//  FormatID: {9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}, 8
  PKEY_AppUserModel_ExcludeFromShowInNewInstall : TPropertyKey = (
    fmtid : '{9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}'; pid : 8);
  {$EXTERNALSYM PKEY_AppUserModel_ExcludeFromShowInNewInstall}

//  Name:     System.AppUserModel.ID -- PKEY_AppUserModel_ID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}, 5
  PKEY_AppUserModel_ID : TPropertyKey = (
    fmtid : '{9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}'; pid : 5);
  {$EXTERNALSYM PKEY_AppUserModel_ID}

//  Name:     System.AppUserModel.IsDestListSeparator -- PKEY_AppUserModel_IsDestListSeparator
//  Type:     Boolean -- VT_BOOL
//  FormatID: {9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}, 6
  PKEY_AppUserModel_IsDestListSeparator : TPropertyKey = (
    fmtid : '{9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}'; pid : 6);
  {$EXTERNALSYM PKEY_AppUserModel_IsDestListSeparator}

//  Name:     System.AppUserModel.RelaunchCommand -- PKEY_AppUserModel_RelaunchCommand
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}, 2
  PKEY_AppUserModel_RelaunchCommand : TPropertyKey = (
    fmtid : '{9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}'; pid : 2);
  {$EXTERNALSYM PKEY_AppUserModel_RelaunchCommand}

//  Name:     System.AppUserModel.RelaunchDisplayNameResource -- PKEY_AppUserModel_RelaunchDisplayNameResource
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}, 4
  PKEY_AppUserModel_RelaunchDisplayNameResource : TPropertyKey = (
    fmtid : '{9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}'; pid : 4);
  {$EXTERNALSYM PKEY_AppUserModel_RelaunchDisplayNameResource}

//  Name:     System.AppUserModel.RelaunchIconResource -- PKEY_AppUserModel_RelaunchIconResource
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}, 3
  PKEY_AppUserModel_RelaunchIconResource : TPropertyKey = (
    fmtid : '{9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}'; pid : 3);
  {$EXTERNALSYM PKEY_AppUserModel_RelaunchIconResource}

//  Name:     System.Software.DateLastUsed -- PKEY_Software_DateLastUsed
//  Type:     DateTime -- VT_FILETIME  (For variants: VT_DATE)
//  FormatID: {841E4F90-FF59-4D16-8947-E81BBFFAB36D}, 16
//  
//  
  PKEY_Software_DateLastUsed : TPropertyKey = (
    fmtid : '{841E4F90-FF59-4D16-8947-E81BBFFAB36D}'; pid : 16);
  {$EXTERNALSYM PKEY_Software_DateLastUsed}

//  Name:     System.Software.ProductName -- PKEY_Software_ProductName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (PSFMTID_VERSION) {0CEF7D53-FA64-11D1-A203-0000F81FEDEE}, 7
//  
//  
  PKEY_Software_ProductName : TPropertyKey = (
    fmtid : '{0CEF7D53-FA64-11D1-A203-0000F81FEDEE}'; pid : 7);
  {$EXTERNALSYM PKEY_Software_ProductName}
 
//-----------------------------------------------------------------------------
// Sync properties



//  Name:     System.Sync.Comments -- PKEY_Sync_Comments
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {7BD5533E-AF15-44DB-B8C8-BD6624E1D032}, 13
  PKEY_Sync_Comments : TPropertyKey = (
    fmtid : '{7BD5533E-AF15-44DB-B8C8-BD6624E1D032}'; pid : 13);
  {$EXTERNALSYM PKEY_Sync_Comments}

//  Name:     System.Sync.ConflictDescription -- PKEY_Sync_ConflictDescription
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {CE50C159-2FB8-41FD-BE68-D3E042E274BC}, 4
  PKEY_Sync_ConflictDescription : TPropertyKey = (
    fmtid : '{CE50C159-2FB8-41FD-BE68-D3E042E274BC}'; pid : 4);
  {$EXTERNALSYM PKEY_Sync_ConflictDescription}

//  Name:     System.Sync.ConflictFirstLocation -- PKEY_Sync_ConflictFirstLocation
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {CE50C159-2FB8-41FD-BE68-D3E042E274BC}, 6
  PKEY_Sync_ConflictFirstLocation : TPropertyKey = (
    fmtid : '{CE50C159-2FB8-41FD-BE68-D3E042E274BC}'; pid : 6);
  {$EXTERNALSYM PKEY_Sync_ConflictFirstLocation}

//  Name:     System.Sync.ConflictSecondLocation -- PKEY_Sync_ConflictSecondLocation
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {CE50C159-2FB8-41FD-BE68-D3E042E274BC}, 7
  PKEY_Sync_ConflictSecondLocation : TPropertyKey = (
    fmtid : '{CE50C159-2FB8-41FD-BE68-D3E042E274BC}'; pid : 7);
  {$EXTERNALSYM PKEY_Sync_ConflictSecondLocation}

//  Name:     System.Sync.HandlerCollectionID -- PKEY_Sync_HandlerCollectionID
//  Type:     Guid -- VT_CLSID
//  FormatID: {7BD5533E-AF15-44DB-B8C8-BD6624E1D032}, 2
  PKEY_Sync_HandlerCollectionID : TPropertyKey = (
    fmtid : '{7BD5533E-AF15-44DB-B8C8-BD6624E1D032}'; pid : 2);
  {$EXTERNALSYM PKEY_Sync_HandlerCollectionID}

//  Name:     System.Sync.HandlerID -- PKEY_Sync_HandlerID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {7BD5533E-AF15-44DB-B8C8-BD6624E1D032}, 3
  PKEY_Sync_HandlerID : TPropertyKey = (
    fmtid : '{7BD5533E-AF15-44DB-B8C8-BD6624E1D032}'; pid : 3);
  {$EXTERNALSYM PKEY_Sync_HandlerID}

//  Name:     System.Sync.HandlerName -- PKEY_Sync_HandlerName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {CE50C159-2FB8-41FD-BE68-D3E042E274BC}, 2
  PKEY_Sync_HandlerName : TPropertyKey = (
    fmtid : '{CE50C159-2FB8-41FD-BE68-D3E042E274BC}'; pid : 2);
  {$EXTERNALSYM PKEY_Sync_HandlerName}

//  Name:     System.Sync.HandlerType -- PKEY_Sync_HandlerType
//  Type:     UInt32 -- VT_UI4
//  FormatID: {7BD5533E-AF15-44DB-B8C8-BD6624E1D032}, 8
//  
//  
  PKEY_Sync_HandlerType : TPropertyKey = (
    fmtid : '{7BD5533E-AF15-44DB-B8C8-BD6624E1D032}'; pid : 8);
  {$EXTERNALSYM PKEY_Sync_HandlerType}

// Possible discrete values for PKEY_Sync_HandlerType are:
  SYNC_HANDLERTYPE_OTHER =               0;
  {$EXTERNALSYM SYNC_HANDLERTYPE_OTHER}
  SYNC_HANDLERTYPE_PROGRAMS =            1;
  {$EXTERNALSYM SYNC_HANDLERTYPE_PROGRAMS}
  SYNC_HANDLERTYPE_DEVICES =             2;
  {$EXTERNALSYM SYNC_HANDLERTYPE_DEVICES}
  SYNC_HANDLERTYPE_FOLDERS =             3;
  {$EXTERNALSYM SYNC_HANDLERTYPE_FOLDERS}
  SYNC_HANDLERTYPE_WEBSERVICES =         4;
  {$EXTERNALSYM SYNC_HANDLERTYPE_WEBSERVICES}
  SYNC_HANDLERTYPE_COMPUTERS =           5;
  {$EXTERNALSYM SYNC_HANDLERTYPE_COMPUTERS}

//  Name:     System.Sync.HandlerTypeLabel -- PKEY_Sync_HandlerTypeLabel
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {7BD5533E-AF15-44DB-B8C8-BD6624E1D032}, 9
//  
//  
  PKEY_Sync_HandlerTypeLabel : TPropertyKey = (
    fmtid : '{7BD5533E-AF15-44DB-B8C8-BD6624E1D032}'; pid : 9);
  {$EXTERNALSYM PKEY_Sync_HandlerTypeLabel}

//  Name:     System.Sync.ItemID -- PKEY_Sync_ItemID
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {7BD5533E-AF15-44DB-B8C8-BD6624E1D032}, 6
  PKEY_Sync_ItemID : TPropertyKey = (
    fmtid : '{7BD5533E-AF15-44DB-B8C8-BD6624E1D032}'; pid : 6);
  {$EXTERNALSYM PKEY_Sync_ItemID}

//  Name:     System.Sync.ItemName -- PKEY_Sync_ItemName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {CE50C159-2FB8-41FD-BE68-D3E042E274BC}, 3
  PKEY_Sync_ItemName : TPropertyKey = (
    fmtid : '{CE50C159-2FB8-41FD-BE68-D3E042E274BC}'; pid : 3);
  {$EXTERNALSYM PKEY_Sync_ItemName}

//  Name:     System.Sync.ProgressPercentage -- PKEY_Sync_ProgressPercentage
//  Type:     UInt32 -- VT_UI4
//  FormatID: {7BD5533E-AF15-44DB-B8C8-BD6624E1D032}, 23
//
//  An integer value between 0 and 100 representing the percentage completed.
  PKEY_Sync_ProgressPercentage : TPropertyKey = (
    fmtid : '{7BD5533E-AF15-44DB-B8C8-BD6624E1D032}'; pid : 23);
  {$EXTERNALSYM PKEY_Sync_ProgressPercentage}

//  Name:     System.Sync.State -- PKEY_Sync_State
//  Type:     UInt32 -- VT_UI4
//  FormatID: {7BD5533E-AF15-44DB-B8C8-BD6624E1D032}, 24
//
//  Sync state.
  PKEY_Sync_State : TPropertyKey = (
    fmtid : '{7BD5533E-AF15-44DB-B8C8-BD6624E1D032}'; pid : 24);
  {$EXTERNALSYM PKEY_Sync_State}

// Possible discrete values for PKEY_Sync_State are:
  SYNC_STATE_NOTSETUP =                  0;
  {$EXTERNALSYM SYNC_STATE_NOTSETUP}
  SYNC_STATE_SYNCNOTRUN =                1;
  {$EXTERNALSYM SYNC_STATE_SYNCNOTRUN}
  SYNC_STATE_IDLE =                      2;
  {$EXTERNALSYM SYNC_STATE_IDLE}
  SYNC_STATE_ERROR =                     3;
  {$EXTERNALSYM SYNC_STATE_ERROR}
  SYNC_STATE_PENDING =                   4;
  {$EXTERNALSYM SYNC_STATE_PENDING}
  SYNC_STATE_SYNCING =                   5;
  {$EXTERNALSYM SYNC_STATE_SYNCING}

//  Name:     System.Sync.Status -- PKEY_Sync_Status
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {7BD5533E-AF15-44DB-B8C8-BD6624E1D032}, 10
  PKEY_Sync_Status : TPropertyKey = (
    fmtid : '{7BD5533E-AF15-44DB-B8C8-BD6624E1D032}'; pid : 10);
  {$EXTERNALSYM PKEY_Sync_Status}
 
//-----------------------------------------------------------------------------
// Task properties

//  Name:     System.Task.BillingInformation -- PKEY_Task_BillingInformation
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {D37D52C6-261C-4303-82B3-08B926AC6F12}, 100
  PKEY_Task_BillingInformation : TPropertyKey = (
    fmtid : '{D37D52C6-261C-4303-82B3-08B926AC6F12}'; pid : 100);
  {$EXTERNALSYM PKEY_Task_BillingInformation}

//  Name:     System.Task.CompletionStatus -- PKEY_Task_CompletionStatus
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {084D8A0A-E6D5-40DE-BF1F-C8820E7C877C}, 100
  PKEY_Task_CompletionStatus : TPropertyKey = (
    fmtid : '{084D8A0A-E6D5-40DE-BF1F-C8820E7C877C}'; pid : 100);
  {$EXTERNALSYM PKEY_Task_CompletionStatus}

//  Name:     System.Task.Owner -- PKEY_Task_Owner
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: {08C7CC5F-60F2-4494-AD75-55E3E0B5ADD0}, 100
  PKEY_Task_Owner : TPropertyKey = (
    fmtid : '{08C7CC5F-60F2-4494-AD75-55E3E0B5ADD0}'; pid : 100);
  {$EXTERNALSYM PKEY_Task_Owner}

 
 
//-----------------------------------------------------------------------------
// Video properties

//  Name:     System.Video.Compression -- PKEY_Video_Compression
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 10 (PIDVSI_COMPRESSION)
//
//  Indicates the level of compression for the video stream.  "Compression".
  PKEY_Video_Compression : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 10);
  {$EXTERNALSYM PKEY_Video_Compression}

//  Name:     System.Video.Director -- PKEY_Video_Director
//  Type:     Multivalue String -- VT_VECTOR | VT_LPWSTR  (For variants: VT_ARRAY | VT_BSTR)
//  FormatID: (PSGUID_MEDIAFILESUMMARYINFORMATION) {64440492-4C8B-11D1-8B70-080036B11A03}, 20 (PIDMSI_DIRECTOR)
//
//  
  PKEY_Video_Director : TPropertyKey = (
    fmtid : '{64440492-4C8B-11D1-8B70-080036B11A03}'; pid : 20);
  {$EXTERNALSYM PKEY_Video_Director}

//  Name:     System.Video.EncodingBitrate -- PKEY_Video_EncodingBitrate
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 8 (PIDVSI_DATA_RATE)
//
//  Indicates the data rate in "bits per second" for the video stream. "DataRate".
  PKEY_Video_EncodingBitrate : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 8);
  {$EXTERNALSYM PKEY_Video_EncodingBitrate}

//  Name:     System.Video.FourCC -- PKEY_Video_FourCC
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 44
//  
//  Indicates the 4CC for the video stream.
  PKEY_Video_FourCC : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 44);
  {$EXTERNALSYM PKEY_Video_FourCC}

//  Name:     System.Video.FrameHeight -- PKEY_Video_FrameHeight
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 4
//
//  Indicates the frame height for the video stream.
  PKEY_Video_FrameHeight : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 4);
  {$EXTERNALSYM PKEY_Video_FrameHeight}

//  Name:     System.Video.FrameRate -- PKEY_Video_FrameRate
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 6 (PIDVSI_FRAME_RATE)
//
//  Indicates the frame rate in "frames per millisecond" for the video stream.  "FrameRate".
  PKEY_Video_FrameRate : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 6);
  {$EXTERNALSYM PKEY_Video_FrameRate}

//  Name:     System.Video.FrameWidth -- PKEY_Video_FrameWidth
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 3
//
//  Indicates the frame width for the video stream.
  PKEY_Video_FrameWidth : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 3);
  {$EXTERNALSYM PKEY_Video_FrameWidth}

//  Name:     System.Video.HorizontalAspectRatio -- PKEY_Video_HorizontalAspectRatio
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 42
//  
//  Indicates the horizontal portion of the aspect ratio. The X portion of XX:YY,
//  like 16:9.
  PKEY_Video_HorizontalAspectRatio : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 42);
  {$EXTERNALSYM PKEY_Video_HorizontalAspectRatio}

//  Name:     System.Video.SampleSize -- PKEY_Video_SampleSize
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 9 (PIDVSI_SAMPLE_SIZE)
//
//  Indicates the sample size in bits for the video stream.  "SampleSize".
  PKEY_Video_SampleSize : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 9);
  {$EXTERNALSYM PKEY_Video_SampleSize}

//  Name:     System.Video.StreamName -- PKEY_Video_StreamName
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 2 (PIDVSI_STREAM_NAME)
//
//  Indicates the name for the video stream. "StreamName".
  PKEY_Video_StreamName : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 2);
  {$EXTERNALSYM PKEY_Video_StreamName}

//  Name:     System.Video.StreamNumber -- PKEY_Video_StreamNumber
//  Type:     UInt16 -- VT_UI2
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 11 (PIDVSI_STREAM_NUMBER)
//
//  "Stream Number".
  PKEY_Video_StreamNumber : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 11);
  {$EXTERNALSYM PKEY_Video_StreamNumber}

//  Name:     System.Video.TotalBitrate -- PKEY_Video_TotalBitrate
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 43 (PIDVSI_TOTAL_BITRATE)
//
//  Indicates the total data rate in "bits per second" for all video and audio streams.
  PKEY_Video_TotalBitrate : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 43);
  {$EXTERNALSYM PKEY_Video_TotalBitrate}

//  Name:     System.Video.VerticalAspectRatio -- PKEY_Video_VerticalAspectRatio
//  Type:     UInt32 -- VT_UI4
//  FormatID: (FMTID_VideoSummaryInformation) {64440491-4C8B-11D1-8B70-080036B11A03}, 45
//  
//  Indicates the vertical portion of the aspect ratio. The Y portion of 
//  XX:YY, like 16:9.
  PKEY_Video_VerticalAspectRatio : TPropertyKey = (
    fmtid : '{64440491-4C8B-11D1-8B70-080036B11A03}'; pid : 45);
  {$EXTERNALSYM PKEY_Video_VerticalAspectRatio}
 
//-----------------------------------------------------------------------------
// Volume properties



//  Name:     System.Volume.FileSystem -- PKEY_Volume_FileSystem
//  Type:     String -- VT_LPWSTR  (For variants: VT_BSTR)
//  FormatID: (FMTID_Volume) {9B174B35-40FF-11D2-A27E-00C04FC30871}, 4 (PID_VOLUME_FILESYSTEM)  (Filesystem Volume Properties)
//
//  Indicates the filesystem of the volume.
  PKEY_Volume_FileSystem : TPropertyKey = (
    fmtid : '{9B174B35-40FF-11D2-A27E-00C04FC30871}'; pid : 4);
  {$EXTERNALSYM PKEY_Volume_FileSystem}

//  Name:     System.Volume.IsMappedDrive -- PKEY_Volume_IsMappedDrive
//  Type:     Boolean -- VT_BOOL
//  FormatID: {149C0B69-2C2D-48FC-808F-D318D78C4636}, 2
  PKEY_Volume_IsMappedDrive : TPropertyKey = (
    fmtid : '{149C0B69-2C2D-48FC-808F-D318D78C4636}'; pid : 2);
  {$EXTERNALSYM PKEY_Volume_IsMappedDrive}

//  Name:     System.Volume.IsRoot -- PKEY_Volume_IsRoot
//  Type:     Boolean -- VT_BOOL
//  FormatID: (FMTID_Volume) {9B174B35-40FF-11D2-A27E-00C04FC30871}, 10  (Filesystem Volume Properties)
//
//  
  PKEY_Volume_IsRoot : TPropertyKey = (
    fmtid : '{9B174B35-40FF-11D2-A27E-00C04FC30871}'; pid : 10);
  {$EXTERNALSYM PKEY_Volume_IsRoot}

implementation

end.
