{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.ApkExpansion;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os;

type
// ===== Forward declarations =====

  JAPEZProvider = interface;//com.android.vending.expansion.zipfile.APEZProvider
  JAPKExpansionSupport = interface;//com.android.vending.expansion.zipfile.APKExpansionSupport
  JZipResourceFile = interface;//com.android.vending.expansion.zipfile.ZipResourceFile
  JZipResourceFile_ZipEntryRO = interface;//com.android.vending.expansion.zipfile.ZipResourceFile$ZipEntryRO
  JApkAlarmReceiver = interface;//com.embarcadero.expansion.ApkAlarmReceiver
  JApkBaseDownloader = interface;//com.embarcadero.expansion.ApkBaseDownloader
  JApkDownloaderClient = interface;//com.embarcadero.expansion.ApkDownloaderClient
  JApkDownloaderListener = interface;//com.embarcadero.expansion.ApkDownloaderListener
  JCustomIntentService = interface;//com.google.android.vending.expansion.downloader.impl.CustomIntentService
  JDownloaderService = interface;//com.google.android.vending.expansion.downloader.impl.DownloaderService
  JApkDownloaderService = interface;//com.embarcadero.expansion.ApkDownloaderService
  JApkFileInfo = interface;//com.embarcadero.expansion.ApkFileInfo
  JApkFilesHelper = interface;//com.embarcadero.expansion.ApkFilesHelper
  JObb = interface;//com.embarcadero.expansion.Obb
  JObb_ObbListener = interface;//com.embarcadero.expansion.Obb$ObbListener
  JDownloaderActivity = interface;//com.embarcadero.expansion.activityimpl.DownloaderActivity
  JDownloaderActivityConfig = interface;//com.embarcadero.expansion.activityimpl.DownloaderActivityConfig
  JDownloaderActivityLauncher = interface;//com.embarcadero.expansion.activityimpl.DownloaderActivityLauncher
  JNativeDownloaderLauncher = interface;//com.embarcadero.expansion.nativeimpl.NativeDownloaderLauncher
  JConstants = interface;//com.google.android.vending.expansion.downloader.Constants
  JDownloadProgressInfo = interface;//com.google.android.vending.expansion.downloader.DownloadProgressInfo
  JDownloaderClientMarshaller = interface;//com.google.android.vending.expansion.downloader.DownloaderClientMarshaller
  JDownloaderServiceMarshaller = interface;//com.google.android.vending.expansion.downloader.DownloaderServiceMarshaller
  JHelpers = interface;//com.google.android.vending.expansion.downloader.Helpers
  JIDownloaderClient = interface;//com.google.android.vending.expansion.downloader.IDownloaderClient
  JIDownloaderService = interface;//com.google.android.vending.expansion.downloader.IDownloaderService
  JIStub = interface;//com.google.android.vending.expansion.downloader.IStub
  JNotificationLabels = interface;//com.google.android.vending.expansion.downloader.NotificationLabels
  JCustomNotificationFactory = interface;//com.google.android.vending.expansion.downloader.impl.CustomNotificationFactory
  JDownloadInfo = interface;//com.google.android.vending.expansion.downloader.impl.DownloadInfo
  JDownloadNotification = interface;//com.google.android.vending.expansion.downloader.impl.DownloadNotification
  JDownloadNotification_ICustomNotification = interface;//com.google.android.vending.expansion.downloader.impl.DownloadNotification$ICustomNotification
  JDownloadThread = interface;//com.google.android.vending.expansion.downloader.impl.DownloadThread
  JDownloaderService_GenerateSaveFileError = interface;//com.google.android.vending.expansion.downloader.impl.DownloaderService$GenerateSaveFileError
  JDownloadsDB = interface;//com.google.android.vending.expansion.downloader.impl.DownloadsDB
  JDownloadsDB_DownloadColumns = interface;//com.google.android.vending.expansion.downloader.impl.DownloadsDB$DownloadColumns
  JDownloadsDB_MetadataColumns = interface;//com.google.android.vending.expansion.downloader.impl.DownloadsDB$MetadataColumns
  JHttpDateTime = interface;//com.google.android.vending.expansion.downloader.impl.HttpDateTime
  JV14CustomNotification = interface;//com.google.android.vending.expansion.downloader.impl.V14CustomNotification
  JV3CustomNotification = interface;//com.google.android.vending.expansion.downloader.impl.V3CustomNotification

// ===== Interface declarations =====

  JAPEZProviderClass = interface(JContentProviderClass)
    ['{E26ADD72-3ABD-4FEA-BED4-CC8CC3B16D49}']
    {class} function _GetALL_FIELDS: TJavaObjectArray<JString>; cdecl;
    {class} function _GetALL_FIELDS_INT: TJavaArray<Integer>; cdecl;
    {class} function _GetCOMPLEN_IDX: Integer; cdecl;
    {class} function _GetCOMPRESSEDLEN: JString; cdecl;
    {class} function _GetCOMPRESSIONTYPE: JString; cdecl;
    {class} function _GetCOMPTYPE_IDX: Integer; cdecl;
    {class} function _GetCRC32: JString; cdecl;
    {class} function _GetCRC_IDX: Integer; cdecl;
    {class} function _GetFILEID: JString; cdecl;
    {class} function _GetFILEID_IDX: Integer; cdecl;
    {class} function _GetFILENAME: JString; cdecl;
    {class} function _GetFILENAME_IDX: Integer; cdecl;
    {class} function _GetMODIFICATION: JString; cdecl;
    {class} function _GetMOD_IDX: Integer; cdecl;
    {class} function _GetUNCOMPLEN_IDX: Integer; cdecl;
    {class} function _GetUNCOMPRESSEDLEN: JString; cdecl;
    {class} function _GetZIPFILE: JString; cdecl;
    {class} function _GetZIPFILE_IDX: Integer; cdecl;
    {class} function init: JAPEZProvider; cdecl;
    {class} property ALL_FIELDS: TJavaObjectArray<JString> read _GetALL_FIELDS;
    {class} property ALL_FIELDS_INT: TJavaArray<Integer> read _GetALL_FIELDS_INT;
    {class} property COMPLEN_IDX: Integer read _GetCOMPLEN_IDX;
    {class} property COMPRESSEDLEN: JString read _GetCOMPRESSEDLEN;
    {class} property COMPRESSIONTYPE: JString read _GetCOMPRESSIONTYPE;
    {class} property COMPTYPE_IDX: Integer read _GetCOMPTYPE_IDX;
    {class} property CRC32: JString read _GetCRC32;
    {class} property CRC_IDX: Integer read _GetCRC_IDX;
    {class} property FILEID: JString read _GetFILEID;
    {class} property FILEID_IDX: Integer read _GetFILEID_IDX;
    {class} property FILENAME: JString read _GetFILENAME;
    {class} property FILENAME_IDX: Integer read _GetFILENAME_IDX;
    {class} property MODIFICATION: JString read _GetMODIFICATION;
    {class} property MOD_IDX: Integer read _GetMOD_IDX;
    {class} property UNCOMPLEN_IDX: Integer read _GetUNCOMPLEN_IDX;
    {class} property UNCOMPRESSEDLEN: JString read _GetUNCOMPRESSEDLEN;
    {class} property ZIPFILE: JString read _GetZIPFILE;
    {class} property ZIPFILE_IDX: Integer read _GetZIPFILE_IDX;
  end;

  [JavaSignature('com/android/vending/expansion/zipfile/APEZProvider')]
  JAPEZProvider = interface(JContentProvider)
    ['{3B3FD75B-DED0-4A72-B479-FF9B97236122}']
    function applyBatch(operations: JArrayList): TJavaObjectArray<JContentProviderResult>; cdecl;
    function delete(arg0: Jnet_Uri; arg1: JString; arg2: TJavaObjectArray<JString>): Integer; cdecl;
    function getAuthority: JString; cdecl;
    function getType(uri: Jnet_Uri): JString; cdecl;
    function insert(uri: Jnet_Uri; values: JContentValues): Jnet_Uri; cdecl;
    function onCreate: Boolean; cdecl;
    function openAssetFile(uri: Jnet_Uri; mode: JString): JAssetFileDescriptor; cdecl;
    function openFile(uri: Jnet_Uri; mode: JString): JParcelFileDescriptor; cdecl;
    function query(uri: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>; sortOrder: JString): JCursor; cdecl;
    function update(uri: Jnet_Uri; values: JContentValues; selection: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
  end;
  TJAPEZProvider = class(TJavaGenericImport<JAPEZProviderClass, JAPEZProvider>) end;

  JAPKExpansionSupportClass = interface(JObjectClass)
    ['{B82F8FBA-AE89-402F-A482-D5EA88561B45}']
    {class} function init: JAPKExpansionSupport; cdecl;
    {class} function getAPKExpansionZipFile(ctx: JContext; mainVersion: Integer; patchVersion: Integer): JZipResourceFile; cdecl;
    {class} function getResourceZipFile(expansionFiles: TJavaObjectArray<JString>): JZipResourceFile; cdecl;
  end;

  [JavaSignature('com/android/vending/expansion/zipfile/APKExpansionSupport')]
  JAPKExpansionSupport = interface(JObject)
    ['{062184CE-7401-498E-BD7C-1929B9EFC7F2}']
  end;
  TJAPKExpansionSupport = class(TJavaGenericImport<JAPKExpansionSupportClass, JAPKExpansionSupport>) end;

  JZipResourceFileClass = interface(JObjectClass)
    ['{69F1BD88-F6CC-45B5-8FD2-A34D003C1642}']
    {class} function init(zipFileName: JString): JZipResourceFile; cdecl;
  end;

  [JavaSignature('com/android/vending/expansion/zipfile/ZipResourceFile')]
  JZipResourceFile = interface(JObject)
    ['{84984AFD-9A67-4A07-9660-921BC4C7B1CF}']
    function _GetmZipFiles: JHashMap; cdecl;
    procedure _SetmZipFiles(Value: JHashMap); cdecl;
    function getAllEntries: TJavaObjectArray<JZipResourceFile_ZipEntryRO>; cdecl;
    function getAssetFileDescriptor(assetPath: JString): JAssetFileDescriptor; cdecl;
    function getInputStream(assetPath: JString): JInputStream; cdecl;
    property mZipFiles: JHashMap read _GetmZipFiles write _SetmZipFiles;
  end;
  TJZipResourceFile = class(TJavaGenericImport<JZipResourceFileClass, JZipResourceFile>) end;

  JZipResourceFile_ZipEntryROClass = interface(JObjectClass)
    ['{437CD8DF-9215-4B25-A6A1-D41E4948F191}']
    {class} function init(zipFileName: JString; file_: JFile; fileName: JString): JZipResourceFile_ZipEntryRO; cdecl;
  end;

  [JavaSignature('com/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO')]
  JZipResourceFile_ZipEntryRO = interface(JObject)
    ['{F0695EE3-93F6-479E-B462-3A927EF83EC2}']
    function _GetmCRC32: Int64; cdecl;
    procedure _SetmCRC32(Value: Int64); cdecl;
    function _GetmCompressedLength: Int64; cdecl;
    procedure _SetmCompressedLength(Value: Int64); cdecl;
    function _GetmFile: JFile; cdecl;
    function _GetmFileName: JString; cdecl;
    function _GetmLocalHdrOffset: Int64; cdecl;
    procedure _SetmLocalHdrOffset(Value: Int64); cdecl;
    function _GetmMethod: Integer; cdecl;
    procedure _SetmMethod(Value: Integer); cdecl;
    function _GetmOffset: Int64; cdecl;
    procedure _SetmOffset(Value: Int64); cdecl;
    function _GetmUncompressedLength: Int64; cdecl;
    procedure _SetmUncompressedLength(Value: Int64); cdecl;
    function _GetmWhenModified: Int64; cdecl;
    procedure _SetmWhenModified(Value: Int64); cdecl;
    function _GetmZipFileName: JString; cdecl;
    function getAssetFileDescriptor: JAssetFileDescriptor; cdecl;
    function getOffset: Int64; cdecl;
    function getZipFile: JFile; cdecl;
    function getZipFileName: JString; cdecl;
    function isUncompressed: Boolean; cdecl;
    procedure setOffsetFromFile(f: JRandomAccessFile; buf: JByteBuffer); cdecl;
    property mCRC32: Int64 read _GetmCRC32 write _SetmCRC32;
    property mCompressedLength: Int64 read _GetmCompressedLength write _SetmCompressedLength;
    property mFile: JFile read _GetmFile;
    property mFileName: JString read _GetmFileName;
    property mLocalHdrOffset: Int64 read _GetmLocalHdrOffset write _SetmLocalHdrOffset;
    property mMethod: Integer read _GetmMethod write _SetmMethod;
    property mOffset: Int64 read _GetmOffset write _SetmOffset;
    property mUncompressedLength: Int64 read _GetmUncompressedLength write _SetmUncompressedLength;
    property mWhenModified: Int64 read _GetmWhenModified write _SetmWhenModified;
    property mZipFileName: JString read _GetmZipFileName;
  end;
  TJZipResourceFile_ZipEntryRO = class(TJavaGenericImport<JZipResourceFile_ZipEntryROClass, JZipResourceFile_ZipEntryRO>) end;

  JApkAlarmReceiverClass = interface(JBroadcastReceiverClass)
    ['{C65FE68B-E670-412D-BC27-63F090AA06B2}']
    {class} function init: JApkAlarmReceiver; cdecl;
  end;

  [JavaSignature('com/embarcadero/expansion/ApkAlarmReceiver')]
  JApkAlarmReceiver = interface(JBroadcastReceiver)
    ['{81DBEE4F-5150-4C40-A733-6004BF9A200A}']
    procedure onReceive(context: JContext; intent: JIntent); cdecl;
  end;
  TJApkAlarmReceiver = class(TJavaGenericImport<JApkAlarmReceiverClass, JApkAlarmReceiver>) end;

  JApkBaseDownloaderClass = interface(JObjectClass)
    ['{5872D446-A340-44F6-A11B-0DC74BC28120}']
    {class} function init(publicKey: JString; salt: TJavaArray<Byte>; apks: TJavaObjectArray<JApkFileInfo>): JApkBaseDownloader; cdecl;
  end;

  [JavaSignature('com/embarcadero/expansion/ApkBaseDownloader')]
  JApkBaseDownloader = interface(JObject)
    ['{EE973BF3-2B7A-456A-A600-2A997B6CC81F}']
    procedure setNotificationLabels(labels: JHashMap); cdecl;
  end;
  TJApkBaseDownloader = class(TJavaGenericImport<JApkBaseDownloaderClass, JApkBaseDownloader>) end;

  JApkDownloaderClientClass = interface(JObjectClass)
    ['{16A14F76-6178-4719-8138-47AD32E513F5}']
    {class} function init(activity: JActivity; xAPKS: TJavaObjectArray<JApkFileInfo>; downloaderListener: JApkDownloaderListener): JApkDownloaderClient; cdecl;
  end;

  [JavaSignature('com/embarcadero/expansion/ApkDownloaderClient')]
  JApkDownloaderClient = interface(JObject)
    ['{2890DE6A-89C6-4AFC-AD89-A27DA56B3DA1}']
    function getDownloaderClientStub: JIStub; cdecl;
    function getDownloaderService: JIDownloaderService; cdecl;
    function launch: Boolean; cdecl;
    procedure onDownloadProgress(progress: JDownloadProgressInfo); cdecl;
    procedure onDownloadStateChanged(newState: Integer); cdecl;
    procedure onServiceConnected(m: JMessenger); cdecl;
  end;
  TJApkDownloaderClient = class(TJavaGenericImport<JApkDownloaderClientClass, JApkDownloaderClient>) end;

  JApkDownloaderListenerClass = interface(IJavaClass)
    ['{ADA57B92-707B-469B-90B7-34D3BD123EB4}']
  end;

  [JavaSignature('com/embarcadero/expansion/ApkDownloaderListener')]
  JApkDownloaderListener = interface(IJavaInstance)
    ['{782B8878-9306-4A8C-A2FC-093A82144484}']
    procedure onDownloadProgress(progress: JDownloadProgressInfo); cdecl;
    procedure onDownloadStateChanged(newState: Integer); cdecl;
  end;
  TJApkDownloaderListener = class(TJavaGenericImport<JApkDownloaderListenerClass, JApkDownloaderListener>) end;

  JCustomIntentServiceClass = interface(JServiceClass)
    ['{847A1962-3CB2-4980-B2AF-F1D559D224F7}']
    {class} function init(paramString: JString): JCustomIntentService; cdecl;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/CustomIntentService')]
  JCustomIntentService = interface(JService)
    ['{BA491650-C614-4C1C-836A-A8B0BA7DBCF2}']
    function onBind(paramIntent: JIntent): JIBinder; cdecl;
    procedure onCreate; cdecl;
    procedure onDestroy; cdecl;
    procedure onStart(paramIntent: JIntent; startId: Integer); cdecl;
    function onStartCommand(paramIntent: JIntent; flags: Integer; startId: Integer): Integer; cdecl;
    procedure setIntentRedelivery(enabled: Boolean); cdecl;
  end;
  TJCustomIntentService = class(TJavaGenericImport<JCustomIntentServiceClass, JCustomIntentService>) end;

  JDownloaderServiceClass = interface(JCustomIntentServiceClass)
    ['{2F4F734A-5053-469C-A97C-2BD2AF8D24BF}']
    {class} function _GetACTION_DOWNLOADS_CHANGED: JString; cdecl;
    {class} function _GetACTION_DOWNLOAD_COMPLETE: JString; cdecl;
    {class} function _GetACTION_DOWNLOAD_STATUS: JString; cdecl;
    {class} function _GetDOWNLOAD_REQUIRED: Integer; cdecl;
    {class} function _GetEXTRA_FILE_NAME: JString; cdecl;
    {class} function _GetEXTRA_IS_WIFI_REQUIRED: JString; cdecl;
    {class} function _GetEXTRA_MESSAGE_HANDLER: JString; cdecl;
    {class} function _GetEXTRA_PACKAGE_NAME: JString; cdecl;
    {class} function _GetEXTRA_PENDING_INTENT: JString; cdecl;
    {class} function _GetEXTRA_STATUS_CURRENT_FILE_SIZE: JString; cdecl;
    {class} function _GetEXTRA_STATUS_CURRENT_PROGRESS: JString; cdecl;
    {class} function _GetEXTRA_STATUS_STATE: JString; cdecl;
    {class} function _GetEXTRA_STATUS_TOTAL_PROGRESS: JString; cdecl;
    {class} function _GetEXTRA_STATUS_TOTAL_SIZE: JString; cdecl;
    {class} function _GetLVL_CHECK_REQUIRED: Integer; cdecl;
    {class} function _GetNETWORK_CANNOT_USE_ROAMING: Integer; cdecl;
    {class} function _GetNETWORK_MOBILE: Integer; cdecl;
    {class} function _GetNETWORK_NO_CONNECTION: Integer; cdecl;
    {class} function _GetNETWORK_OK: Integer; cdecl;
    {class} function _GetNETWORK_RECOMMENDED_UNUSABLE_DUE_TO_SIZE: Integer; cdecl;
    {class} function _GetNETWORK_TYPE_DISALLOWED_BY_REQUESTOR: Integer; cdecl;
    {class} function _GetNETWORK_UNUSABLE_DUE_TO_SIZE: Integer; cdecl;
    {class} function _GetNETWORK_WIFI: Integer; cdecl;
    {class} function _GetNO_DOWNLOAD_REQUIRED: Integer; cdecl;
    {class} function _GetSTATUS_CANNOT_RESUME: Integer; cdecl;
    {class} function _GetSTATUS_FILE_ALREADY_EXISTS_ERROR: Integer; cdecl;
    {class} function _GetSTATUS_FILE_DELIVERED_INCORRECTLY: Integer; cdecl;
    {class} function _GetSTATUS_FORBIDDEN: Integer; cdecl;
    {class} function _GetSTATUS_PAUSED_BY_APP: Integer; cdecl;
    {class} function _GetSTATUS_PENDING: Integer; cdecl;
    {class} function _GetSTATUS_QUEUED_FOR_WIFI: Integer; cdecl;
    {class} function _GetSTATUS_QUEUED_FOR_WIFI_OR_CELLULAR_PERMISSION: Integer; cdecl;
    {class} function _GetSTATUS_RUNNING: Integer; cdecl;
    {class} function _GetSTATUS_UNKNOWN_ERROR: Integer; cdecl;
    {class} function _GetSTATUS_WAITING_FOR_NETWORK: Integer; cdecl;
    {class} function _GetSTATUS_WAITING_TO_RETRY: Integer; cdecl;
    {class} function init: JDownloaderService; cdecl;
    {class} function isStatusClientError(status: Integer): Boolean; cdecl;
    {class} function isStatusCompleted(status: Integer): Boolean; cdecl;
    {class} function isStatusError(status: Integer): Boolean; cdecl;
    {class} function isStatusInformational(status: Integer): Boolean; cdecl;
    {class} function isStatusServerError(status: Integer): Boolean; cdecl;
    {class} function isStatusSuccess(status: Integer): Boolean; cdecl;
    {class} function startDownloadServiceIfRequired(context: JContext; intent: JIntent; serviceClass: Jlang_Class): Integer; cdecl; overload;
    {class} function startDownloadServiceIfRequired(context: JContext; pendingIntent: JPendingIntent; serviceClass: Jlang_Class): Integer; cdecl; overload;
    {class} function startDownloadServiceIfRequired(context: JContext; pendingIntent: JPendingIntent; classPackage: JString; className: JString): Integer; cdecl; overload;
    {class} property ACTION_DOWNLOADS_CHANGED: JString read _GetACTION_DOWNLOADS_CHANGED;
    {class} property ACTION_DOWNLOAD_COMPLETE: JString read _GetACTION_DOWNLOAD_COMPLETE;
    {class} property ACTION_DOWNLOAD_STATUS: JString read _GetACTION_DOWNLOAD_STATUS;
    {class} property DOWNLOAD_REQUIRED: Integer read _GetDOWNLOAD_REQUIRED;
    {class} property EXTRA_FILE_NAME: JString read _GetEXTRA_FILE_NAME;
    {class} property EXTRA_IS_WIFI_REQUIRED: JString read _GetEXTRA_IS_WIFI_REQUIRED;
    {class} property EXTRA_MESSAGE_HANDLER: JString read _GetEXTRA_MESSAGE_HANDLER;
    {class} property EXTRA_PACKAGE_NAME: JString read _GetEXTRA_PACKAGE_NAME;
    {class} property EXTRA_PENDING_INTENT: JString read _GetEXTRA_PENDING_INTENT;
    {class} property EXTRA_STATUS_CURRENT_FILE_SIZE: JString read _GetEXTRA_STATUS_CURRENT_FILE_SIZE;
    {class} property EXTRA_STATUS_CURRENT_PROGRESS: JString read _GetEXTRA_STATUS_CURRENT_PROGRESS;
    {class} property EXTRA_STATUS_STATE: JString read _GetEXTRA_STATUS_STATE;
    {class} property EXTRA_STATUS_TOTAL_PROGRESS: JString read _GetEXTRA_STATUS_TOTAL_PROGRESS;
    {class} property EXTRA_STATUS_TOTAL_SIZE: JString read _GetEXTRA_STATUS_TOTAL_SIZE;
    {class} property LVL_CHECK_REQUIRED: Integer read _GetLVL_CHECK_REQUIRED;
    {class} property NETWORK_CANNOT_USE_ROAMING: Integer read _GetNETWORK_CANNOT_USE_ROAMING;
    {class} property NETWORK_MOBILE: Integer read _GetNETWORK_MOBILE;
    {class} property NETWORK_NO_CONNECTION: Integer read _GetNETWORK_NO_CONNECTION;
    {class} property NETWORK_OK: Integer read _GetNETWORK_OK;
    {class} property NETWORK_RECOMMENDED_UNUSABLE_DUE_TO_SIZE: Integer read _GetNETWORK_RECOMMENDED_UNUSABLE_DUE_TO_SIZE;
    {class} property NETWORK_TYPE_DISALLOWED_BY_REQUESTOR: Integer read _GetNETWORK_TYPE_DISALLOWED_BY_REQUESTOR;
    {class} property NETWORK_UNUSABLE_DUE_TO_SIZE: Integer read _GetNETWORK_UNUSABLE_DUE_TO_SIZE;
    {class} property NETWORK_WIFI: Integer read _GetNETWORK_WIFI;
    {class} property NO_DOWNLOAD_REQUIRED: Integer read _GetNO_DOWNLOAD_REQUIRED;
    {class} property STATUS_CANNOT_RESUME: Integer read _GetSTATUS_CANNOT_RESUME;
    {class} property STATUS_FILE_ALREADY_EXISTS_ERROR: Integer read _GetSTATUS_FILE_ALREADY_EXISTS_ERROR;
    {class} property STATUS_FILE_DELIVERED_INCORRECTLY: Integer read _GetSTATUS_FILE_DELIVERED_INCORRECTLY;
    {class} property STATUS_FORBIDDEN: Integer read _GetSTATUS_FORBIDDEN;
    {class} property STATUS_PAUSED_BY_APP: Integer read _GetSTATUS_PAUSED_BY_APP;
    {class} property STATUS_PENDING: Integer read _GetSTATUS_PENDING;
    {class} property STATUS_QUEUED_FOR_WIFI: Integer read _GetSTATUS_QUEUED_FOR_WIFI;
    {class} property STATUS_QUEUED_FOR_WIFI_OR_CELLULAR_PERMISSION: Integer read _GetSTATUS_QUEUED_FOR_WIFI_OR_CELLULAR_PERMISSION;
    {class} property STATUS_RUNNING: Integer read _GetSTATUS_RUNNING;
    {class} property STATUS_UNKNOWN_ERROR: Integer read _GetSTATUS_UNKNOWN_ERROR;
    {class} property STATUS_WAITING_FOR_NETWORK: Integer read _GetSTATUS_WAITING_FOR_NETWORK;
    {class} property STATUS_WAITING_TO_RETRY: Integer read _GetSTATUS_WAITING_TO_RETRY;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/DownloaderService')]
  JDownloaderService = interface(JCustomIntentService)
    ['{2DFE6D5F-4CC2-4712-B66C-A12CBB7116D1}']
    function generateSaveFile(filename: JString; filesize: Int64): JString; cdecl;
    function generateTempSaveFileName(fileName: JString): JString; cdecl;
    function getAlarmReceiverClassName: JString; cdecl;
    function getControl: Integer; cdecl;
    function getLogMessageForNetworkError(networkError: Integer): JString; cdecl;
    function getNetworkAvailabilityState(db: JDownloadsDB): Integer; cdecl;
    function getPublicKey: JString; cdecl;
    function getSALT: TJavaArray<Byte>; cdecl;
    function getStatus: Integer; cdecl;
    function handleFileUpdated(db: JDownloadsDB; index: Integer; filename: JString; fileSize: Int64): Boolean; cdecl;
    function isWiFi: Boolean; cdecl;
    procedure notifyUpdateBytes(totalBytesSoFar: Int64); cdecl;
    function onBind(paramIntent: JIntent): JIBinder; cdecl;
    procedure onClientUpdated(clientMessenger: JMessenger); cdecl;
    procedure onCreate; cdecl;
    procedure onDestroy; cdecl;
    procedure requestAbortDownload; cdecl;
    procedure requestContinueDownload; cdecl;
    procedure requestDownloadStatus; cdecl;
    procedure requestPauseDownload; cdecl;
    procedure setDownloadFlags(flags: Integer); cdecl;
    procedure updateLVL(context: JContext); cdecl;
  end;
  TJDownloaderService = class(TJavaGenericImport<JDownloaderServiceClass, JDownloaderService>) end;

  JApkDownloaderServiceClass = interface(JDownloaderServiceClass)
    ['{C34557AF-1EA4-4EEF-A3A0-74886F5F57E4}']
    {class} function _GetBASE64_PUBLIC_KEY: JString; cdecl;
    {class} procedure _SetBASE64_PUBLIC_KEY(Value: JString); cdecl;
    {class} function _GetSALT: TJavaArray<Byte>; cdecl;
    {class} procedure _SetSALT(Value: TJavaArray<Byte>); cdecl;
    {class} function _GetxAPKS: TJavaObjectArray<JApkFileInfo>; cdecl;
    {class} procedure _SetxAPKS(Value: TJavaObjectArray<JApkFileInfo>); cdecl;
    {class} function init: JApkDownloaderService; cdecl;
    {class} property BASE64_PUBLIC_KEY: JString read _GetBASE64_PUBLIC_KEY write _SetBASE64_PUBLIC_KEY;
    {class} property SALT: TJavaArray<Byte> read _GetSALT write _SetSALT;
    {class} property xAPKS: TJavaObjectArray<JApkFileInfo> read _GetxAPKS write _SetxAPKS;
  end;

  [JavaSignature('com/embarcadero/expansion/ApkDownloaderService')]
  JApkDownloaderService = interface(JDownloaderService)
    ['{5441EB6E-2512-44F1-A240-45B5B751E161}']
    function getAlarmReceiverClassName: JString; cdecl;
    function getPublicKey: JString; cdecl;
    function getSALT: TJavaArray<Byte>; cdecl;
  end;
  TJApkDownloaderService = class(TJavaGenericImport<JApkDownloaderServiceClass, JApkDownloaderService>) end;

  JApkFileInfoClass = interface(JObjectClass)
    ['{639B498E-2CC7-4675-B82B-D96A60BEE247}']
    {class} function init(isMain: Boolean; fileVersion: Integer; fileSize: Int64; encriptKey: JString): JApkFileInfo; cdecl;
  end;

  [JavaSignature('com/embarcadero/expansion/ApkFileInfo')]
  JApkFileInfo = interface(JObject)
    ['{57422024-F0E6-43BA-9A35-79F369A7A0A9}']
    function _GetmEncriptKey: JString; cdecl;
    function _GetmFileSize: Int64; cdecl;
    function _GetmFileVersion: Integer; cdecl;
    function _GetmIsMain: Boolean; cdecl;
    function getObb(c: JContext): JObb; cdecl;
    property mEncriptKey: JString read _GetmEncriptKey;
    property mFileSize: Int64 read _GetmFileSize;
    property mFileVersion: Integer read _GetmFileVersion;
    property mIsMain: Boolean read _GetmIsMain;
  end;
  TJApkFileInfo = class(TJavaGenericImport<JApkFileInfoClass, JApkFileInfo>) end;

  JApkFilesHelperClass = interface(JObjectClass)
    ['{FF77F727-F74E-4B87-91F8-0E1FDDF42F2C}']
    {class} function init: JApkFilesHelper; cdecl;
    {class} function areExpansionFilesDelivered(c: JContext; xAPKS: TJavaObjectArray<JApkFileInfo>): Boolean; cdecl; overload;
    {class} function areExpansionFilesDelivered(c: JContext; xAPKS: TJavaObjectArray<JApkFileInfo>; deleteFileOnMismatch: Boolean): Boolean; cdecl; overload;
    {class} function doesExpansionFileExist(c: JContext; isMain: Boolean; fileVersion: Integer; fileSize: Int64; deleteFileOnMismatch: Boolean): Boolean; cdecl;
    {class} function doesFileExist(c: JContext; fileName: JString; fileSize: Int64; deleteFileOnMismatch: Boolean): Boolean; cdecl;
    {class} function getExpansionFileName(c: JContext; isMain: Boolean; fileVersion: Integer): JString; cdecl;
    {class} function getExpansionFilePath(c: JContext; isMain: Boolean; fileVersion: Integer): JString; cdecl;
    {class} function getMountedObbPath(c: JContext; filePath: JString): JString; cdecl;
  end;

  [JavaSignature('com/embarcadero/expansion/ApkFilesHelper')]
  JApkFilesHelper = interface(JObject)
    ['{6765E9A5-5B12-43CB-B883-F40D37C87F16}']
  end;
  TJApkFilesHelper = class(TJavaGenericImport<JApkFilesHelperClass, JApkFilesHelper>) end;

  JObbClass = interface(JOnObbStateChangeListenerClass)
    ['{9C53DC45-B0E1-427F-A0F5-0E5C22B9369C}']
    {class} function init(c: JContext; a: JApkFileInfo): JObb; cdecl;
  end;

  [JavaSignature('com/embarcadero/expansion/Obb')]
  JObb = interface(JOnObbStateChangeListener)
    ['{4CBDC758-C2BC-4247-A342-8C23905A5CCF}']
    function getMountedObbPath: JString; cdecl;
    function getName: JString; cdecl;
    function getPath: JString; cdecl;
    function getResourcePath(filePath: JString): JString; cdecl;
    function isMounted: Boolean; cdecl;
    procedure mount; cdecl;
    procedure onObbStateChange(path: JString; state: Integer); cdecl;
    procedure setListener(listener: JObb_ObbListener); cdecl;
    procedure umount(force: Boolean); cdecl;
  end;
  TJObb = class(TJavaGenericImport<JObbClass, JObb>) end;

  JObb_ObbListenerClass = interface(IJavaClass)
    ['{C4E05674-A415-484C-84BA-B3F6DCFEA0A1}']
  end;

  [JavaSignature('com/embarcadero/expansion/Obb$ObbListener')]
  JObb_ObbListener = interface(IJavaInstance)
    ['{710A8D6A-4E6B-44A7-A552-4BFCE8939BBE}']
    procedure onObbStateChange(path: JString; state: Integer); cdecl;
  end;
  TJObb_ObbListener = class(TJavaGenericImport<JObb_ObbListenerClass, JObb_ObbListener>) end;

  JDownloaderActivityClass = interface(JActivityClass)
    ['{23019048-ECDC-412F-9492-7AEEC11FF854}']
    {class} function _GetTITLE: JString; cdecl;
    {class} procedure _SetTITLE(Value: JString); cdecl;
    {class} function _GetisAlive: Boolean; cdecl;
    {class} procedure _SetisAlive(Value: Boolean); cdecl;
    {class} function _GetmEnabled: Boolean; cdecl;
    {class} procedure _SetmEnabled(Value: Boolean); cdecl;
    {class} function init: JDownloaderActivity; cdecl;
    {class} property TITLE: JString read _GetTITLE write _SetTITLE;
    {class} property isAlive: Boolean read _GetisAlive write _SetisAlive;
    {class} property mEnabled: Boolean read _GetmEnabled write _SetmEnabled;
  end;

  [JavaSignature('com/embarcadero/expansion/activityimpl/DownloaderActivity')]
  JDownloaderActivity = interface(JActivity)
    ['{3ED370EB-155B-4FC5-9C26-0E27F7D52A7F}']
    procedure onBackPressed; cdecl;
    procedure onCreate(savedInstanceState: JBundle); cdecl;
    procedure onDownloadProgress(progress: JDownloadProgressInfo); cdecl;
    procedure onDownloadStateChanged(newState: Integer); cdecl;
  end;
  TJDownloaderActivity = class(TJavaGenericImport<JDownloaderActivityClass, JDownloaderActivity>) end;

  JDownloaderActivityConfigClass = interface(JObjectClass)
    ['{613A6437-5781-4281-8BA0-DCFF254B93D7}']
    {class} function _Getapp_name: JString; cdecl;
    {class} procedure _Setapp_name(Value: JString); cdecl;
    {class} function _GetrequestCode: JString; cdecl;
    {class} procedure _SetrequestCode(Value: JString); cdecl;
    {class} function _Gettext_button_cancel: JString; cdecl;
    {class} procedure _Settext_button_cancel(Value: JString); cdecl;
    {class} function _Gettext_button_cancel_verify: JString; cdecl;
    {class} procedure _Settext_button_cancel_verify(Value: JString); cdecl;
    {class} function _Gettext_button_pause: JString; cdecl;
    {class} procedure _Settext_button_pause(Value: JString); cdecl;
    {class} function _Gettext_button_resume: JString; cdecl;
    {class} procedure _Settext_button_resume(Value: JString); cdecl;
    {class} function _Gettext_button_resume_cellular: JString; cdecl;
    {class} procedure _Settext_button_resume_cellular(Value: JString); cdecl;
    {class} function _Gettext_button_wifi_settings: JString; cdecl;
    {class} procedure _Settext_button_wifi_settings(Value: JString); cdecl;
    {class} function _Gettext_cancel: JString; cdecl;
    {class} procedure _Settext_cancel(Value: JString); cdecl;
    {class} function _Gettext_ok: JString; cdecl;
    {class} procedure _Settext_ok(Value: JString); cdecl;
    {class} function _Gettext_paused_cellular: JString; cdecl;
    {class} procedure _Settext_paused_cellular(Value: JString); cdecl;
    {class} function _Gettext_paused_cellular_2: JString; cdecl;
    {class} procedure _Settext_paused_cellular_2(Value: JString); cdecl;
    {class} function _Gettext_validation_complete: JString; cdecl;
    {class} procedure _Settext_validation_complete(Value: JString); cdecl;
    {class} function _Gettext_validation_failed: JString; cdecl;
    {class} procedure _Settext_validation_failed(Value: JString); cdecl;
    {class} function _Gettext_verifying_download: JString; cdecl;
    {class} procedure _Settext_verifying_download(Value: JString); cdecl;
    {class} function _Gettitle: JString; cdecl;
    {class} procedure _Settitle(Value: JString); cdecl;
    {class} function init: JDownloaderActivityConfig; cdecl;
    {class} property app_name: JString read _Getapp_name write _Setapp_name;
    {class} property requestCode: JString read _GetrequestCode write _SetrequestCode;
    {class} property text_button_cancel: JString read _Gettext_button_cancel write _Settext_button_cancel;
    {class} property text_button_cancel_verify: JString read _Gettext_button_cancel_verify write _Settext_button_cancel_verify;
    {class} property text_button_pause: JString read _Gettext_button_pause write _Settext_button_pause;
    {class} property text_button_resume: JString read _Gettext_button_resume write _Settext_button_resume;
    {class} property text_button_resume_cellular: JString read _Gettext_button_resume_cellular write _Settext_button_resume_cellular;
    {class} property text_button_wifi_settings: JString read _Gettext_button_wifi_settings write _Settext_button_wifi_settings;
    {class} property text_cancel: JString read _Gettext_cancel write _Settext_cancel;
    {class} property text_ok: JString read _Gettext_ok write _Settext_ok;
    {class} property text_paused_cellular: JString read _Gettext_paused_cellular write _Settext_paused_cellular;
    {class} property text_paused_cellular_2: JString read _Gettext_paused_cellular_2 write _Settext_paused_cellular_2;
    {class} property text_validation_complete: JString read _Gettext_validation_complete write _Settext_validation_complete;
    {class} property text_validation_failed: JString read _Gettext_validation_failed write _Settext_validation_failed;
    {class} property text_verifying_download: JString read _Gettext_verifying_download write _Settext_verifying_download;
    {class} property title: JString read _Gettitle write _Settitle;
  end;

  [JavaSignature('com/embarcadero/expansion/activityimpl/DownloaderActivityConfig')]
  JDownloaderActivityConfig = interface(JObject)
    ['{71310121-4259-4779-95DA-425B21F4DF9C}']
  end;
  TJDownloaderActivityConfig = class(TJavaGenericImport<JDownloaderActivityConfigClass, JDownloaderActivityConfig>) end;

  JDownloaderActivityLauncherClass = interface(JApkBaseDownloaderClass)
    ['{DA7CEE58-DE43-462C-85ED-028F530527D7}']
    {class} function init(publicKey: JString; salt: TJavaArray<Byte>; apks: TJavaObjectArray<JApkFileInfo>): JDownloaderActivityLauncher; cdecl;
  end;

  [JavaSignature('com/embarcadero/expansion/activityimpl/DownloaderActivityLauncher')]
  JDownloaderActivityLauncher = interface(JApkBaseDownloader)
    ['{CD906884-35CF-4556-AD44-63994C47E721}']
    function launch(activity: JActivity; requestCode: Integer): Boolean; cdecl;
    procedure setActivityEnabled(enable: Boolean); cdecl;
    procedure setDownloaderLabels(labels: JHashMap); cdecl;
  end;
  TJDownloaderActivityLauncher = class(TJavaGenericImport<JDownloaderActivityLauncherClass, JDownloaderActivityLauncher>) end;

  JNativeDownloaderLauncherClass = interface(JApkBaseDownloaderClass)
    ['{CD90EE03-C9A8-4115-ADCA-97E7B23FB76B}']
    {class} function init(publicKey: JString; salt: TJavaArray<Byte>; apks: TJavaObjectArray<JApkFileInfo>): JNativeDownloaderLauncher; cdecl;
  end;

  [JavaSignature('com/embarcadero/expansion/nativeimpl/NativeDownloaderLauncher')]
  JNativeDownloaderLauncher = interface(JApkBaseDownloader)
    ['{4A21AA69-7067-42A4-BA61-37A7A43A23BA}']
    procedure connect(c: JContext); cdecl;
    procedure disconnect(c: JContext); cdecl;
    function getDownloaderClientStup: JIStub; cdecl;
    function getDownloaderService: JIDownloaderService; cdecl;
    function launch(activity: JActivity; listener: JApkDownloaderListener): Boolean; cdecl;
    procedure requestAbortDownload; cdecl;
    procedure requestContinueDownload; cdecl;
    procedure requestPauseDownload; cdecl;
  end;
  TJNativeDownloaderLauncher = class(TJavaGenericImport<JNativeDownloaderLauncherClass, JNativeDownloaderLauncher>) end;

  JConstantsClass = interface(JObjectClass)
    ['{BAD49A84-76B7-441E-840A-75BFA37F76AE}']
    {class} function _GetACTION_HIDE: JString; cdecl;
    {class} function _GetACTION_LIST: JString; cdecl;
    {class} function _GetACTION_OPEN: JString; cdecl;
    {class} function _GetACTION_RETRY: JString; cdecl;
    {class} function _GetACTIVE_THREAD_WATCHDOG: Int64; cdecl;
    {class} function _GetBUFFER_SIZE: Integer; cdecl;
    {class} function _GetDEFAULT_USER_AGENT: JString; cdecl;
    {class} function _GetEXP_PATH: JString; cdecl;
    {class} function _GetFILENAME_SEQUENCE_SEPARATOR: JString; cdecl;
    {class} function _GetLOGV: Boolean; cdecl;
    {class} function _GetLOGVV: Boolean; cdecl;
    {class} function _GetLOGX: Boolean; cdecl;
    {class} function _GetMAX_DOWNLOADS: Integer; cdecl;
    {class} function _GetMAX_REDIRECTS: Integer; cdecl;
    {class} function _GetMAX_RETRIES: Integer; cdecl;
    {class} function _GetMAX_RETRY_AFTER: Integer; cdecl;
    {class} function _GetMIN_ARTIFICIAL_ERROR_STATUS: Integer; cdecl;
    {class} function _GetMIN_PROGRESS_STEP: Integer; cdecl;
    {class} function _GetMIN_PROGRESS_TIME: Int64; cdecl;
    {class} function _GetMIN_RETRY_AFTER: Integer; cdecl;
    {class} function _GetRETRY_FIRST_DELAY: Integer; cdecl;
    {class} function _GetSTATUS_BAD_REQUEST: Integer; cdecl;
    {class} function _GetSTATUS_CANCELED: Integer; cdecl;
    {class} function _GetSTATUS_CANNOT_RESUME: Integer; cdecl;
    {class} function _GetSTATUS_DEVICE_NOT_FOUND_ERROR: Integer; cdecl;
    {class} function _GetSTATUS_FILE_ALREADY_EXISTS_ERROR: Integer; cdecl;
    {class} function _GetSTATUS_FILE_ERROR: Integer; cdecl;
    {class} function _GetSTATUS_HTTP_DATA_ERROR: Integer; cdecl;
    {class} function _GetSTATUS_HTTP_EXCEPTION: Integer; cdecl;
    {class} function _GetSTATUS_INSUFFICIENT_SPACE_ERROR: Integer; cdecl;
    {class} function _GetSTATUS_LENGTH_REQUIRED: Integer; cdecl;
    {class} function _GetSTATUS_NOT_ACCEPTABLE: Integer; cdecl;
    {class} function _GetSTATUS_PRECONDITION_FAILED: Integer; cdecl;
    {class} function _GetSTATUS_SUCCESS: Integer; cdecl;
    {class} function _GetSTATUS_TOO_MANY_REDIRECTS: Integer; cdecl;
    {class} function _GetSTATUS_UNHANDLED_HTTP_CODE: Integer; cdecl;
    {class} function _GetSTATUS_UNHANDLED_REDIRECT: Integer; cdecl;
    {class} function _GetSTATUS_UNKNOWN_ERROR: Integer; cdecl;
    {class} function _GetTAG: JString; cdecl;
    {class} function _GetWATCHDOG_WAKE_TIMER: Int64; cdecl;
    {class} function init: JConstants; cdecl;
    {class} property ACTION_HIDE: JString read _GetACTION_HIDE;
    {class} property ACTION_LIST: JString read _GetACTION_LIST;
    {class} property ACTION_OPEN: JString read _GetACTION_OPEN;
    {class} property ACTION_RETRY: JString read _GetACTION_RETRY;
    {class} property ACTIVE_THREAD_WATCHDOG: Int64 read _GetACTIVE_THREAD_WATCHDOG;
    {class} property BUFFER_SIZE: Integer read _GetBUFFER_SIZE;
    {class} property DEFAULT_USER_AGENT: JString read _GetDEFAULT_USER_AGENT;
    {class} property EXP_PATH: JString read _GetEXP_PATH;
    {class} property FILENAME_SEQUENCE_SEPARATOR: JString read _GetFILENAME_SEQUENCE_SEPARATOR;
    {class} property LOGV: Boolean read _GetLOGV;
    {class} property LOGVV: Boolean read _GetLOGVV;
    {class} property LOGX: Boolean read _GetLOGX;
    {class} property MAX_DOWNLOADS: Integer read _GetMAX_DOWNLOADS;
    {class} property MAX_REDIRECTS: Integer read _GetMAX_REDIRECTS;
    {class} property MAX_RETRIES: Integer read _GetMAX_RETRIES;
    {class} property MAX_RETRY_AFTER: Integer read _GetMAX_RETRY_AFTER;
    {class} property MIN_ARTIFICIAL_ERROR_STATUS: Integer read _GetMIN_ARTIFICIAL_ERROR_STATUS;
    {class} property MIN_PROGRESS_STEP: Integer read _GetMIN_PROGRESS_STEP;
    {class} property MIN_PROGRESS_TIME: Int64 read _GetMIN_PROGRESS_TIME;
    {class} property MIN_RETRY_AFTER: Integer read _GetMIN_RETRY_AFTER;
    {class} property RETRY_FIRST_DELAY: Integer read _GetRETRY_FIRST_DELAY;
    {class} property STATUS_BAD_REQUEST: Integer read _GetSTATUS_BAD_REQUEST;
    {class} property STATUS_CANCELED: Integer read _GetSTATUS_CANCELED;
    {class} property STATUS_CANNOT_RESUME: Integer read _GetSTATUS_CANNOT_RESUME;
    {class} property STATUS_DEVICE_NOT_FOUND_ERROR: Integer read _GetSTATUS_DEVICE_NOT_FOUND_ERROR;
    {class} property STATUS_FILE_ALREADY_EXISTS_ERROR: Integer read _GetSTATUS_FILE_ALREADY_EXISTS_ERROR;
    {class} property STATUS_FILE_ERROR: Integer read _GetSTATUS_FILE_ERROR;
    {class} property STATUS_HTTP_DATA_ERROR: Integer read _GetSTATUS_HTTP_DATA_ERROR;
    {class} property STATUS_HTTP_EXCEPTION: Integer read _GetSTATUS_HTTP_EXCEPTION;
    {class} property STATUS_INSUFFICIENT_SPACE_ERROR: Integer read _GetSTATUS_INSUFFICIENT_SPACE_ERROR;
    {class} property STATUS_LENGTH_REQUIRED: Integer read _GetSTATUS_LENGTH_REQUIRED;
    {class} property STATUS_NOT_ACCEPTABLE: Integer read _GetSTATUS_NOT_ACCEPTABLE;
    {class} property STATUS_PRECONDITION_FAILED: Integer read _GetSTATUS_PRECONDITION_FAILED;
    {class} property STATUS_SUCCESS: Integer read _GetSTATUS_SUCCESS;
    {class} property STATUS_TOO_MANY_REDIRECTS: Integer read _GetSTATUS_TOO_MANY_REDIRECTS;
    {class} property STATUS_UNHANDLED_HTTP_CODE: Integer read _GetSTATUS_UNHANDLED_HTTP_CODE;
    {class} property STATUS_UNHANDLED_REDIRECT: Integer read _GetSTATUS_UNHANDLED_REDIRECT;
    {class} property STATUS_UNKNOWN_ERROR: Integer read _GetSTATUS_UNKNOWN_ERROR;
    {class} property TAG: JString read _GetTAG;
    {class} property WATCHDOG_WAKE_TIMER: Int64 read _GetWATCHDOG_WAKE_TIMER;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/Constants')]
  JConstants = interface(JObject)
    ['{A453331C-B467-49F3-813F-42088D599D91}']
  end;
  TJConstants = class(TJavaGenericImport<JConstantsClass, JConstants>) end;

  JDownloadProgressInfoClass = interface(JObjectClass)
    ['{881ECB1E-C9CC-4787-9B0D-F57D90261FFD}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(p: JParcel): JDownloadProgressInfo; cdecl; overload;
    {class} function init(overallTotal: Int64; overallProgress: Int64; timeRemaining: Int64; currentSpeed: Single): JDownloadProgressInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/DownloadProgressInfo')]
  JDownloadProgressInfo = interface(JObject)
    ['{3798A8DB-D57D-4516-ABEC-1442E421C3A3}']
    function _GetmCurrentSpeed: Single; cdecl;
    procedure _SetmCurrentSpeed(Value: Single); cdecl;
    function _GetmOverallProgress: Int64; cdecl;
    procedure _SetmOverallProgress(Value: Int64); cdecl;
    function _GetmOverallTotal: Int64; cdecl;
    procedure _SetmOverallTotal(Value: Int64); cdecl;
    function _GetmTimeRemaining: Int64; cdecl;
    procedure _SetmTimeRemaining(Value: Int64); cdecl;
    function describeContents: Integer; cdecl;
    procedure writeToParcel(p: JParcel; i: Integer); cdecl;
    property mCurrentSpeed: Single read _GetmCurrentSpeed write _SetmCurrentSpeed;
    property mOverallProgress: Int64 read _GetmOverallProgress write _SetmOverallProgress;
    property mOverallTotal: Int64 read _GetmOverallTotal write _SetmOverallTotal;
    property mTimeRemaining: Int64 read _GetmTimeRemaining write _SetmTimeRemaining;
  end;
  TJDownloadProgressInfo = class(TJavaGenericImport<JDownloadProgressInfoClass, JDownloadProgressInfo>) end;

  JDownloaderClientMarshallerClass = interface(JObjectClass)
    ['{75A82EEA-6851-420D-94F6-FD0ECA9F2DE5}']
    {class} function _GetDOWNLOAD_REQUIRED: Integer; cdecl;
    {class} function _GetLVL_CHECK_REQUIRED: Integer; cdecl;
    {class} function _GetMSG_ONDOWNLOADPROGRESS: Integer; cdecl;
    {class} function _GetMSG_ONDOWNLOADSTATE_CHANGED: Integer; cdecl;
    {class} function _GetMSG_ONSERVICECONNECTED: Integer; cdecl;
    {class} function _GetNO_DOWNLOAD_REQUIRED: Integer; cdecl;
    {class} function _GetPARAM_MESSENGER: JString; cdecl;
    {class} function _GetPARAM_NEW_STATE: JString; cdecl;
    {class} function _GetPARAM_PROGRESS: JString; cdecl;
    {class} function init: JDownloaderClientMarshaller; cdecl;
    {class} function CreateProxy(msg: JMessenger): JIDownloaderClient; cdecl;
    {class} function CreateStub(itf: JIDownloaderClient; downloaderService: Jlang_Class): JIStub; cdecl;
    {class} function startDownloadServiceIfRequired(context: JContext; notificationClient: JPendingIntent; serviceClass: Jlang_Class): Integer; cdecl; overload;
    {class} function startDownloadServiceIfRequired(context: JContext; notificationClient: JIntent; serviceClass: Jlang_Class): Integer; cdecl; overload;
    {class} property DOWNLOAD_REQUIRED: Integer read _GetDOWNLOAD_REQUIRED;
    {class} property LVL_CHECK_REQUIRED: Integer read _GetLVL_CHECK_REQUIRED;
    {class} property MSG_ONDOWNLOADPROGRESS: Integer read _GetMSG_ONDOWNLOADPROGRESS;
    {class} property MSG_ONDOWNLOADSTATE_CHANGED: Integer read _GetMSG_ONDOWNLOADSTATE_CHANGED;
    {class} property MSG_ONSERVICECONNECTED: Integer read _GetMSG_ONSERVICECONNECTED;
    {class} property NO_DOWNLOAD_REQUIRED: Integer read _GetNO_DOWNLOAD_REQUIRED;
    {class} property PARAM_MESSENGER: JString read _GetPARAM_MESSENGER;
    {class} property PARAM_NEW_STATE: JString read _GetPARAM_NEW_STATE;
    {class} property PARAM_PROGRESS: JString read _GetPARAM_PROGRESS;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/DownloaderClientMarshaller')]
  JDownloaderClientMarshaller = interface(JObject)
    ['{86C0E465-3E15-47C3-8021-19E7D3E46A16}']
  end;
  TJDownloaderClientMarshaller = class(TJavaGenericImport<JDownloaderClientMarshallerClass, JDownloaderClientMarshaller>) end;

  JDownloaderServiceMarshallerClass = interface(JObjectClass)
    ['{C0AA10E1-4A1A-40AA-A7B5-E700C2F8179F}']
    {class} function _GetMSG_REQUEST_ABORT_DOWNLOAD: Integer; cdecl;
    {class} function _GetMSG_REQUEST_CLIENT_UPDATE: Integer; cdecl;
    {class} function _GetMSG_REQUEST_CONTINUE_DOWNLOAD: Integer; cdecl;
    {class} function _GetMSG_REQUEST_DOWNLOAD_STATE: Integer; cdecl;
    {class} function _GetMSG_REQUEST_PAUSE_DOWNLOAD: Integer; cdecl;
    {class} function _GetMSG_SET_DOWNLOAD_FLAGS: Integer; cdecl;
    {class} function _GetPARAMS_FLAGS: JString; cdecl;
    {class} function _GetPARAM_MESSENGER: JString; cdecl;
    {class} function init: JDownloaderServiceMarshaller; cdecl;
    {class} function CreateProxy(msg: JMessenger): JIDownloaderService; cdecl;
    {class} function CreateStub(itf: JIDownloaderService): JIStub; cdecl;
    {class} property MSG_REQUEST_ABORT_DOWNLOAD: Integer read _GetMSG_REQUEST_ABORT_DOWNLOAD;
    {class} property MSG_REQUEST_CLIENT_UPDATE: Integer read _GetMSG_REQUEST_CLIENT_UPDATE;
    {class} property MSG_REQUEST_CONTINUE_DOWNLOAD: Integer read _GetMSG_REQUEST_CONTINUE_DOWNLOAD;
    {class} property MSG_REQUEST_DOWNLOAD_STATE: Integer read _GetMSG_REQUEST_DOWNLOAD_STATE;
    {class} property MSG_REQUEST_PAUSE_DOWNLOAD: Integer read _GetMSG_REQUEST_PAUSE_DOWNLOAD;
    {class} property MSG_SET_DOWNLOAD_FLAGS: Integer read _GetMSG_SET_DOWNLOAD_FLAGS;
    {class} property PARAMS_FLAGS: JString read _GetPARAMS_FLAGS;
    {class} property PARAM_MESSENGER: JString read _GetPARAM_MESSENGER;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/DownloaderServiceMarshaller')]
  JDownloaderServiceMarshaller = interface(JObject)
    ['{8F9F546F-191C-4489-8222-7E979F78F41A}']
  end;
  TJDownloaderServiceMarshaller = class(TJavaGenericImport<JDownloaderServiceMarshallerClass, JDownloaderServiceMarshaller>) end;

  JHelpersClass = interface(JObjectClass)
    ['{A1509108-FA42-4AE4-A17B-29DCB2DABCE0}']
    {class} function _GetsRandom: JRandom; cdecl;
    {class} procedure _SetsRandom(Value: JRandom); cdecl;
    {class} function doesFileExist(c: JContext; fileName: JString; fileSize: Int64; deleteFileOnMismatch: Boolean): Boolean; cdecl;
    {class} function generateSaveFileName(c: JContext; fileName: JString): JString; cdecl;
    {class} function getAvailableBytes(root: JFile): Int64; cdecl;
    {class} function getDownloadProgressPercent(overallProgress: Int64; overallTotal: Int64): JString; cdecl;
    {class} function getDownloadProgressString(overallProgress: Int64; overallTotal: Int64): JString; cdecl;
    {class} function getDownloadProgressStringNotification(overallProgress: Int64; overallTotal: Int64): JString; cdecl;
    {class} function getDownloaderStringResourceIDFromState(state: Integer): JString; cdecl;
    {class} function getExpansionAPKFileName(c: JContext; mainFile: Boolean; versionCode: Integer): JString; cdecl;
    {class} function getFilesystemRoot(path: JString): JFile; cdecl;
    {class} function getSaveFilePath(c: JContext): JString; cdecl;
    {class} function getSpeedString(bytesPerMillisecond: Single): JString; cdecl;
    {class} function getTimeRemaining(durationInMilliseconds: Int64): JString; cdecl;
    {class} function isExternalMediaMounted: Boolean; cdecl;
    {class} function isFilenameValid(filename: JString): Boolean; cdecl;
    {class} property sRandom: JRandom read _GetsRandom write _SetsRandom;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/Helpers')]
  JHelpers = interface(JObject)
    ['{0024D8E0-E52D-47C1-95D5-414438B5AAFD}']
  end;
  TJHelpers = class(TJavaGenericImport<JHelpersClass, JHelpers>) end;

  JIDownloaderClientClass = interface(IJavaClass)
    ['{8159CCD5-7CC0-4895-AD28-8FFFA4662F17}']
    {class} function _GetSTATE_COMPLETED: Integer; cdecl;
    {class} function _GetSTATE_CONNECTING: Integer; cdecl;
    {class} function _GetSTATE_DOWNLOADING: Integer; cdecl;
    {class} function _GetSTATE_FAILED: Integer; cdecl;
    {class} function _GetSTATE_FAILED_CANCELED: Integer; cdecl;
    {class} function _GetSTATE_FAILED_FETCHING_URL: Integer; cdecl;
    {class} function _GetSTATE_FAILED_SDCARD_FULL: Integer; cdecl;
    {class} function _GetSTATE_FAILED_UNLICENSED: Integer; cdecl;
    {class} function _GetSTATE_FETCHING_URL: Integer; cdecl;
    {class} function _GetSTATE_IDLE: Integer; cdecl;
    {class} function _GetSTATE_PAUSED_BY_REQUEST: Integer; cdecl;
    {class} function _GetSTATE_PAUSED_NEED_CELLULAR_PERMISSION: Integer; cdecl;
    {class} function _GetSTATE_PAUSED_NEED_WIFI: Integer; cdecl;
    {class} function _GetSTATE_PAUSED_NETWORK_SETUP_FAILURE: Integer; cdecl;
    {class} function _GetSTATE_PAUSED_NETWORK_UNAVAILABLE: Integer; cdecl;
    {class} function _GetSTATE_PAUSED_ROAMING: Integer; cdecl;
    {class} function _GetSTATE_PAUSED_SDCARD_UNAVAILABLE: Integer; cdecl;
    {class} function _GetSTATE_PAUSED_WIFI_DISABLED: Integer; cdecl;
    {class} function _GetSTATE_PAUSED_WIFI_DISABLED_NEED_CELLULAR_PERMISSION: Integer; cdecl;
    {class} property STATE_COMPLETED: Integer read _GetSTATE_COMPLETED;
    {class} property STATE_CONNECTING: Integer read _GetSTATE_CONNECTING;
    {class} property STATE_DOWNLOADING: Integer read _GetSTATE_DOWNLOADING;
    {class} property STATE_FAILED: Integer read _GetSTATE_FAILED;
    {class} property STATE_FAILED_CANCELED: Integer read _GetSTATE_FAILED_CANCELED;
    {class} property STATE_FAILED_FETCHING_URL: Integer read _GetSTATE_FAILED_FETCHING_URL;
    {class} property STATE_FAILED_SDCARD_FULL: Integer read _GetSTATE_FAILED_SDCARD_FULL;
    {class} property STATE_FAILED_UNLICENSED: Integer read _GetSTATE_FAILED_UNLICENSED;
    {class} property STATE_FETCHING_URL: Integer read _GetSTATE_FETCHING_URL;
    {class} property STATE_IDLE: Integer read _GetSTATE_IDLE;
    {class} property STATE_PAUSED_BY_REQUEST: Integer read _GetSTATE_PAUSED_BY_REQUEST;
    {class} property STATE_PAUSED_NEED_CELLULAR_PERMISSION: Integer read _GetSTATE_PAUSED_NEED_CELLULAR_PERMISSION;
    {class} property STATE_PAUSED_NEED_WIFI: Integer read _GetSTATE_PAUSED_NEED_WIFI;
    {class} property STATE_PAUSED_NETWORK_SETUP_FAILURE: Integer read _GetSTATE_PAUSED_NETWORK_SETUP_FAILURE;
    {class} property STATE_PAUSED_NETWORK_UNAVAILABLE: Integer read _GetSTATE_PAUSED_NETWORK_UNAVAILABLE;
    {class} property STATE_PAUSED_ROAMING: Integer read _GetSTATE_PAUSED_ROAMING;
    {class} property STATE_PAUSED_SDCARD_UNAVAILABLE: Integer read _GetSTATE_PAUSED_SDCARD_UNAVAILABLE;
    {class} property STATE_PAUSED_WIFI_DISABLED: Integer read _GetSTATE_PAUSED_WIFI_DISABLED;
    {class} property STATE_PAUSED_WIFI_DISABLED_NEED_CELLULAR_PERMISSION: Integer read _GetSTATE_PAUSED_WIFI_DISABLED_NEED_CELLULAR_PERMISSION;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/IDownloaderClient')]
  JIDownloaderClient = interface(IJavaInstance)
    ['{E35F3579-F34C-48D4-8657-37970D83E7B1}']
    procedure onDownloadProgress(progress: JDownloadProgressInfo); cdecl;
    procedure onDownloadStateChanged(newState: Integer); cdecl;
    procedure onServiceConnected(m: JMessenger); cdecl;
  end;
  TJIDownloaderClient = class(TJavaGenericImport<JIDownloaderClientClass, JIDownloaderClient>) end;

  JIDownloaderServiceClass = interface(IJavaClass)
    ['{41544B3F-F012-4833-8764-661EDF6F52C3}']
    {class} function _GetFLAGS_DOWNLOAD_OVER_CELLULAR: Integer; cdecl;
    {class} property FLAGS_DOWNLOAD_OVER_CELLULAR: Integer read _GetFLAGS_DOWNLOAD_OVER_CELLULAR;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/IDownloaderService')]
  JIDownloaderService = interface(IJavaInstance)
    ['{0D21EF00-EF7F-47D7-971C-4A9D263AA7FC}']
    procedure onClientUpdated(clientMessenger: JMessenger); cdecl;
    procedure requestAbortDownload; cdecl;
    procedure requestContinueDownload; cdecl;
    procedure requestDownloadStatus; cdecl;
    procedure requestPauseDownload; cdecl;
    procedure setDownloadFlags(flags: Integer); cdecl;
  end;
  TJIDownloaderService = class(TJavaGenericImport<JIDownloaderServiceClass, JIDownloaderService>) end;

  JIStubClass = interface(IJavaClass)
    ['{7DE9F188-261B-4291-8D56-CEFDA3A45919}']
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/IStub')]
  JIStub = interface(IJavaInstance)
    ['{B84B97DB-7E4D-410E-A35B-2FC426E3BB0E}']
    procedure connect(c: JContext); cdecl;
    procedure disconnect(c: JContext); cdecl;
    function getMessenger: JMessenger; cdecl;
  end;
  TJIStub = class(TJavaGenericImport<JIStubClass, JIStub>) end;

  JNotificationLabelsClass = interface(JObjectClass)
    ['{4A8A2C31-B5DB-41B5-A3B4-4BDF61B5D2EF}']
    {class} function _Getkilobytes_per_second: JString; cdecl;
    {class} procedure _Setkilobytes_per_second(Value: JString); cdecl;
    {class} function _Getnotification_download_complete: JString; cdecl;
    {class} procedure _Setnotification_download_complete(Value: JString); cdecl;
    {class} function _Getnotification_download_failed: JString; cdecl;
    {class} procedure _Setnotification_download_failed(Value: JString); cdecl;
    {class} function _Getstate_completed: JString; cdecl;
    {class} procedure _Setstate_completed(Value: JString); cdecl;
    {class} function _Getstate_connecting: JString; cdecl;
    {class} procedure _Setstate_connecting(Value: JString); cdecl;
    {class} function _Getstate_downloading: JString; cdecl;
    {class} procedure _Setstate_downloading(Value: JString); cdecl;
    {class} function _Getstate_failed: JString; cdecl;
    {class} procedure _Setstate_failed(Value: JString); cdecl;
    {class} function _Getstate_failed_cancelled: JString; cdecl;
    {class} procedure _Setstate_failed_cancelled(Value: JString); cdecl;
    {class} function _Getstate_failed_fetching_url: JString; cdecl;
    {class} procedure _Setstate_failed_fetching_url(Value: JString); cdecl;
    {class} function _Getstate_failed_sdcard_full: JString; cdecl;
    {class} procedure _Setstate_failed_sdcard_full(Value: JString); cdecl;
    {class} function _Getstate_failed_unlicensed: JString; cdecl;
    {class} procedure _Setstate_failed_unlicensed(Value: JString); cdecl;
    {class} function _Getstate_fetching_url: JString; cdecl;
    {class} procedure _Setstate_fetching_url(Value: JString); cdecl;
    {class} function _Getstate_idle: JString; cdecl;
    {class} procedure _Setstate_idle(Value: JString); cdecl;
    {class} function _Getstate_paused_by_request: JString; cdecl;
    {class} procedure _Setstate_paused_by_request(Value: JString); cdecl;
    {class} function _Getstate_paused_network_setup_failure: JString; cdecl;
    {class} procedure _Setstate_paused_network_setup_failure(Value: JString); cdecl;
    {class} function _Getstate_paused_network_unavailable: JString; cdecl;
    {class} procedure _Setstate_paused_network_unavailable(Value: JString); cdecl;
    {class} function _Getstate_paused_roaming: JString; cdecl;
    {class} procedure _Setstate_paused_roaming(Value: JString); cdecl;
    {class} function _Getstate_paused_sdcard_unavailable: JString; cdecl;
    {class} procedure _Setstate_paused_sdcard_unavailable(Value: JString); cdecl;
    {class} function _Getstate_paused_wifi_disabled: JString; cdecl;
    {class} procedure _Setstate_paused_wifi_disabled(Value: JString); cdecl;
    {class} function _Getstate_paused_wifi_unavailable: JString; cdecl;
    {class} procedure _Setstate_paused_wifi_unavailable(Value: JString); cdecl;
    {class} function _Getstate_unknown: JString; cdecl;
    {class} procedure _Setstate_unknown(Value: JString); cdecl;
    {class} function _Gettime_remaining: JString; cdecl;
    {class} procedure _Settime_remaining(Value: JString); cdecl;
    {class} function _Gettime_remaining_notification: JString; cdecl;
    {class} procedure _Settime_remaining_notification(Value: JString); cdecl;
    {class} function init: JNotificationLabels; cdecl;
    {class} property kilobytes_per_second: JString read _Getkilobytes_per_second write _Setkilobytes_per_second;
    {class} property notification_download_complete: JString read _Getnotification_download_complete write _Setnotification_download_complete;
    {class} property notification_download_failed: JString read _Getnotification_download_failed write _Setnotification_download_failed;
    {class} property state_completed: JString read _Getstate_completed write _Setstate_completed;
    {class} property state_connecting: JString read _Getstate_connecting write _Setstate_connecting;
    {class} property state_downloading: JString read _Getstate_downloading write _Setstate_downloading;
    {class} property state_failed: JString read _Getstate_failed write _Setstate_failed;
    {class} property state_failed_cancelled: JString read _Getstate_failed_cancelled write _Setstate_failed_cancelled;
    {class} property state_failed_fetching_url: JString read _Getstate_failed_fetching_url write _Setstate_failed_fetching_url;
    {class} property state_failed_sdcard_full: JString read _Getstate_failed_sdcard_full write _Setstate_failed_sdcard_full;
    {class} property state_failed_unlicensed: JString read _Getstate_failed_unlicensed write _Setstate_failed_unlicensed;
    {class} property state_fetching_url: JString read _Getstate_fetching_url write _Setstate_fetching_url;
    {class} property state_idle: JString read _Getstate_idle write _Setstate_idle;
    {class} property state_paused_by_request: JString read _Getstate_paused_by_request write _Setstate_paused_by_request;
    {class} property state_paused_network_setup_failure: JString read _Getstate_paused_network_setup_failure write _Setstate_paused_network_setup_failure;
    {class} property state_paused_network_unavailable: JString read _Getstate_paused_network_unavailable write _Setstate_paused_network_unavailable;
    {class} property state_paused_roaming: JString read _Getstate_paused_roaming write _Setstate_paused_roaming;
    {class} property state_paused_sdcard_unavailable: JString read _Getstate_paused_sdcard_unavailable write _Setstate_paused_sdcard_unavailable;
    {class} property state_paused_wifi_disabled: JString read _Getstate_paused_wifi_disabled write _Setstate_paused_wifi_disabled;
    {class} property state_paused_wifi_unavailable: JString read _Getstate_paused_wifi_unavailable write _Setstate_paused_wifi_unavailable;
    {class} property state_unknown: JString read _Getstate_unknown write _Setstate_unknown;
    {class} property time_remaining: JString read _Gettime_remaining write _Settime_remaining;
    {class} property time_remaining_notification: JString read _Gettime_remaining_notification write _Settime_remaining_notification;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/NotificationLabels')]
  JNotificationLabels = interface(JObject)
    ['{C15E6974-1B42-4F31-83B9-385D6936F367}']
  end;
  TJNotificationLabels = class(TJavaGenericImport<JNotificationLabelsClass, JNotificationLabels>) end;

  JCustomNotificationFactoryClass = interface(JObjectClass)
    ['{7F8598EB-108D-49B1-8A24-1DCAC828734C}']
    {class} function init: JCustomNotificationFactory; cdecl;
    {class} function createCustomNotification: JDownloadNotification_ICustomNotification; cdecl;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/CustomNotificationFactory')]
  JCustomNotificationFactory = interface(JObject)
    ['{FC2DE5B2-6F5C-424E-A8A3-47071E65B729}']
  end;
  TJCustomNotificationFactory = class(TJavaGenericImport<JCustomNotificationFactoryClass, JCustomNotificationFactory>) end;

  JDownloadInfoClass = interface(JObjectClass)
    ['{F3074D64-CC05-491E-BBD6-4222F2AE918D}']
    {class} function init(index: Integer; fileName: JString; pkg: JString): JDownloadInfo; cdecl;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/DownloadInfo')]
  JDownloadInfo = interface(JObject)
    ['{BE027323-52FF-4D36-8793-F04E2FF47E1E}']
    function _GetmControl: Integer; cdecl;
    procedure _SetmControl(Value: Integer); cdecl;
    function _GetmCurrentBytes: Int64; cdecl;
    procedure _SetmCurrentBytes(Value: Int64); cdecl;
    function _GetmETag: JString; cdecl;
    procedure _SetmETag(Value: JString); cdecl;
    function _GetmFileName: JString; cdecl;
    function _GetmFuzz: Integer; cdecl;
    procedure _SetmFuzz(Value: Integer); cdecl;
    function _GetmIndex: Integer; cdecl;
    function _GetmLastMod: Int64; cdecl;
    procedure _SetmLastMod(Value: Int64); cdecl;
    function _GetmNumFailed: Integer; cdecl;
    procedure _SetmNumFailed(Value: Integer); cdecl;
    function _GetmRedirectCount: Integer; cdecl;
    procedure _SetmRedirectCount(Value: Integer); cdecl;
    function _GetmRetryAfter: Integer; cdecl;
    procedure _SetmRetryAfter(Value: Integer); cdecl;
    function _GetmStatus: Integer; cdecl;
    procedure _SetmStatus(Value: Integer); cdecl;
    function _GetmTotalBytes: Int64; cdecl;
    procedure _SetmTotalBytes(Value: Int64); cdecl;
    function _GetmUri: JString; cdecl;
    procedure _SetmUri(Value: JString); cdecl;
    procedure logVerboseInfo; cdecl;
    procedure resetDownload; cdecl;
    function restartTime(now: Int64): Int64; cdecl;
    property mControl: Integer read _GetmControl write _SetmControl;
    property mCurrentBytes: Int64 read _GetmCurrentBytes write _SetmCurrentBytes;
    property mETag: JString read _GetmETag write _SetmETag;
    property mFileName: JString read _GetmFileName;
    property mFuzz: Integer read _GetmFuzz write _SetmFuzz;
    property mIndex: Integer read _GetmIndex;
    property mLastMod: Int64 read _GetmLastMod write _SetmLastMod;
    property mNumFailed: Integer read _GetmNumFailed write _SetmNumFailed;
    property mRedirectCount: Integer read _GetmRedirectCount write _SetmRedirectCount;
    property mRetryAfter: Integer read _GetmRetryAfter write _SetmRetryAfter;
    property mStatus: Integer read _GetmStatus write _SetmStatus;
    property mTotalBytes: Int64 read _GetmTotalBytes write _SetmTotalBytes;
    property mUri: JString read _GetmUri write _SetmUri;
  end;
  TJDownloadInfo = class(TJavaGenericImport<JDownloadInfoClass, JDownloadInfo>) end;

  JDownloadNotificationClass = interface(JObjectClass)
    ['{92E75B92-17A5-49AA-8C2B-0866FD212482}']
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/DownloadNotification')]
  JDownloadNotification = interface(JObject)
    ['{637B8622-9735-48D9-99DD-ECE406B60F73}']
    function getClientIntent: JPendingIntent; cdecl;
    procedure onDownloadProgress(progress: JDownloadProgressInfo); cdecl;
    procedure onDownloadStateChanged(newState: Integer); cdecl;
    procedure onServiceConnected(m: JMessenger); cdecl;
    procedure resendState; cdecl;
    procedure setClientIntent(mClientIntent: JPendingIntent); cdecl;
    procedure setMessenger(msg: JMessenger); cdecl;
  end;
  TJDownloadNotification = class(TJavaGenericImport<JDownloadNotificationClass, JDownloadNotification>) end;

  JDownloadNotification_ICustomNotificationClass = interface(IJavaClass)
    ['{8158EF16-A61B-4085-9B67-7A7BD35D139B}']
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/DownloadNotification$ICustomNotification')]
  JDownloadNotification_ICustomNotification = interface(IJavaInstance)
    ['{56E88756-E5A1-47EF-8506-84EB871A0EE8}']
    procedure setCurrentBytes(currentBytes: Int64); cdecl;
    procedure setIcon(iconResource: Integer); cdecl;
    procedure setPendingIntent(mContentIntent: JPendingIntent); cdecl;
    procedure setTicker(ticker: JCharSequence); cdecl;
    procedure setTimeRemaining(timeRemaining: Int64); cdecl;
    procedure setTitle(title: JCharSequence); cdecl;
    procedure setTotalBytes(totalBytes: Int64); cdecl;
    function updateNotification(c: JContext): JNotification; cdecl;
  end;
  TJDownloadNotification_ICustomNotification = class(TJavaGenericImport<JDownloadNotification_ICustomNotificationClass, JDownloadNotification_ICustomNotification>) end;

  JDownloadThreadClass = interface(JObjectClass)
    ['{1BDE2D91-16DD-4B28-A84A-7D73A434B5AA}']
    {class} function init(info: JDownloadInfo; service: JDownloaderService; notification: JDownloadNotification): JDownloadThread; cdecl;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/DownloadThread')]
  JDownloadThread = interface(JObject)
    ['{4F1F71DC-33F8-4F2D-B528-ED3397ABE958}']
    //function getPreferredHttpHost(context: JContext; url: JString): JHttpHost; cdecl;
    procedure run; cdecl;
  end;
  TJDownloadThread = class(TJavaGenericImport<JDownloadThreadClass, JDownloadThread>) end;

  JDownloaderService_GenerateSaveFileErrorClass = interface(JExceptionClass)
    ['{AD77F5D6-1F2A-4BAE-B67F-C7637A7B3CFD}']
    {class} function init(status: Integer; message: JString): JDownloaderService_GenerateSaveFileError; cdecl;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/DownloaderService$GenerateSaveFileError')]
  JDownloaderService_GenerateSaveFileError = interface(JException)
    ['{329A95DC-A15B-4B76-B251-145B96A34D64}']
  end;
  TJDownloaderService_GenerateSaveFileError = class(TJavaGenericImport<JDownloaderService_GenerateSaveFileErrorClass, JDownloaderService_GenerateSaveFileError>) end;

  JDownloadsDBClass = interface(JObjectClass)
    ['{6A0BA0DE-13E4-48F2-B4CB-730B6BB30451}']
    {class} function _GetLOG_TAG: JString; cdecl;
    {class} function getDB(paramContext: JContext): JDownloadsDB; cdecl;
    {class} property LOG_TAG: JString read _GetLOG_TAG;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/DownloadsDB')]
  JDownloadsDB = interface(JObject)
    ['{47CC25B2-3ADA-4611-83ED-E834E01C3C1D}']
    procedure close; cdecl;
    function getDownloadInfoFromCursor(cur: JCursor): JDownloadInfo; cdecl;
    function getDownloads: TJavaObjectArray<JDownloadInfo>; cdecl;
    function getFlags: Integer; cdecl;
    function getIDByIndex(index: Integer): Int64; cdecl;
    function getIDForDownloadInfo(di: JDownloadInfo): Int64; cdecl;
    function getLastCheckedVersionCode: Integer; cdecl;
    function isDownloadRequired: Boolean; cdecl;
    procedure setDownloadInfoFromCursor(di: JDownloadInfo; cur: JCursor); cdecl;
    function updateDownload(di: JDownloadInfo): Boolean; cdecl; overload;
    function updateDownload(di: JDownloadInfo; cv: JContentValues): Boolean; cdecl; overload;
    procedure updateDownloadCurrentBytes(di: JDownloadInfo); cdecl;
    function updateFlags(flags: Integer): Boolean; cdecl;
    function updateFromDb(di: JDownloadInfo): Boolean; cdecl;
    function updateMetadata(cv: JContentValues): Boolean; cdecl; overload;
    function updateMetadata(apkVersion: Integer; downloadStatus: Integer): Boolean; cdecl; overload;
    function updateStatus(status: Integer): Boolean; cdecl;
  end;
  TJDownloadsDB = class(TJavaGenericImport<JDownloadsDBClass, JDownloadsDB>) end;

  JDownloadsDB_DownloadColumnsClass = interface(JObjectClass)
    ['{309FB969-9E60-4FEE-9083-5708B1FEB032}']
    {class} function _GetCONTROL: JString; cdecl;
    {class} function _GetCURRENTBYTES: JString; cdecl;
    {class} function _GetETAG: JString; cdecl;
    {class} function _GetFILENAME: JString; cdecl;
    {class} function _GetINDEX: JString; cdecl;
    {class} function _GetLASTMOD: JString; cdecl;
    {class} function _GetNUM_FAILED: JString; cdecl;
    {class} function _GetREDIRECT_COUNT: JString; cdecl;
    {class} function _GetRETRY_AFTER: JString; cdecl;
    {class} function _GetSCHEMA: TJavaObjectBiArray<JString>; cdecl;
    {class} function _GetSTATUS: JString; cdecl;
    {class} function _GetTABLE_NAME: JString; cdecl;
    {class} function _GetTOTALBYTES: JString; cdecl;
    {class} function _GetURI: JString; cdecl;
    {class} function _Get_ID: JString; cdecl;
    {class} function init: JDownloadsDB_DownloadColumns; cdecl;
    {class} property CONTROL: JString read _GetCONTROL;
    {class} property CURRENTBYTES: JString read _GetCURRENTBYTES;
    {class} property ETAG: JString read _GetETAG;
    {class} property FILENAME: JString read _GetFILENAME;
    {class} property INDEX: JString read _GetINDEX;
    {class} property LASTMOD: JString read _GetLASTMOD;
    {class} property NUM_FAILED: JString read _GetNUM_FAILED;
    {class} property REDIRECT_COUNT: JString read _GetREDIRECT_COUNT;
    {class} property RETRY_AFTER: JString read _GetRETRY_AFTER;
    {class} property SCHEMA: TJavaObjectBiArray<JString> read _GetSCHEMA;
    {class} property STATUS: JString read _GetSTATUS;
    {class} property TABLE_NAME: JString read _GetTABLE_NAME;
    {class} property TOTALBYTES: JString read _GetTOTALBYTES;
    {class} property URI: JString read _GetURI;
    {class} property _ID: JString read _Get_ID;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/DownloadsDB$DownloadColumns')]
  JDownloadsDB_DownloadColumns = interface(JObject)
    ['{70F2EEAB-F288-4E3C-A81F-86DAAB2E3810}']
  end;
  TJDownloadsDB_DownloadColumns = class(TJavaGenericImport<JDownloadsDB_DownloadColumnsClass, JDownloadsDB_DownloadColumns>) end;

  JDownloadsDB_MetadataColumnsClass = interface(JObjectClass)
    ['{8DFD2602-E83D-44A1-AA48-1AC95679C976}']
    {class} function _GetAPKVERSION: JString; cdecl;
    {class} function _GetDOWNLOAD_STATUS: JString; cdecl;
    {class} function _GetFLAGS: JString; cdecl;
    {class} function _GetSCHEMA: TJavaObjectBiArray<JString>; cdecl;
    {class} function _GetTABLE_NAME: JString; cdecl;
    {class} function _Get_ID: JString; cdecl;
    {class} function init: JDownloadsDB_MetadataColumns; cdecl;
    {class} property APKVERSION: JString read _GetAPKVERSION;
    {class} property DOWNLOAD_STATUS: JString read _GetDOWNLOAD_STATUS;
    {class} property FLAGS: JString read _GetFLAGS;
    {class} property SCHEMA: TJavaObjectBiArray<JString> read _GetSCHEMA;
    {class} property TABLE_NAME: JString read _GetTABLE_NAME;
    {class} property _ID: JString read _Get_ID;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/DownloadsDB$MetadataColumns')]
  JDownloadsDB_MetadataColumns = interface(JObject)
    ['{96D3961A-9DEF-4421-9BA9-0927F877356F}']
  end;
  TJDownloadsDB_MetadataColumns = class(TJavaGenericImport<JDownloadsDB_MetadataColumnsClass, JDownloadsDB_MetadataColumns>) end;

  JHttpDateTimeClass = interface(JObjectClass)
    ['{E5F4C13B-B479-41BB-AB05-9D6E1881D102}']
    {class} function init: JHttpDateTime; cdecl;
    {class} function parse(timeString: JString): Int64; cdecl;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/HttpDateTime')]
  JHttpDateTime = interface(JObject)
    ['{686B6AD2-8C07-48F0-AE6F-12278C24A12E}']
  end;
  TJHttpDateTime = class(TJavaGenericImport<JHttpDateTimeClass, JHttpDateTime>) end;

  JV14CustomNotificationClass = interface(JObjectClass)
    ['{D16E2048-BF59-443A-A0D7-446AB9F09FE9}']
    {class} function init: JV14CustomNotification; cdecl;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/V14CustomNotification')]
  JV14CustomNotification = interface(JObject)
    ['{EB90C5CB-A513-4FF8-9327-E7FF28DF2AEC}']
    procedure setCurrentBytes(currentBytes: Int64); cdecl;
    procedure setIcon(icon: Integer); cdecl;
    procedure setPendingIntent(contentIntent: JPendingIntent); cdecl;
    procedure setTicker(ticker: JCharSequence); cdecl;
    procedure setTimeRemaining(timeRemaining: Int64); cdecl;
    procedure setTitle(title: JCharSequence); cdecl;
    procedure setTotalBytes(totalBytes: Int64); cdecl;
    function updateNotification(c: JContext): JNotification; cdecl;
  end;
  TJV14CustomNotification = class(TJavaGenericImport<JV14CustomNotificationClass, JV14CustomNotification>) end;

  JV3CustomNotificationClass = interface(JObjectClass)
    ['{4E619072-0DB1-4DBD-A7D8-F8DA4BC36366}']
    {class} function init: JV3CustomNotification; cdecl;
  end;

  [JavaSignature('com/google/android/vending/expansion/downloader/impl/V3CustomNotification')]
  JV3CustomNotification = interface(JObject)
    ['{AF9A3534-5317-46CD-A1E2-03D78E324E8E}']
    procedure setCurrentBytes(currentBytes: Int64); cdecl;
    procedure setIcon(icon: Integer); cdecl;
    procedure setPendingIntent(contentIntent: JPendingIntent); cdecl;
    procedure setTicker(ticker: JCharSequence); cdecl;
    procedure setTimeRemaining(timeRemaining: Int64); cdecl;
    procedure setTitle(title: JCharSequence); cdecl;
    procedure setTotalBytes(totalBytes: Int64); cdecl;
    function updateNotification(c: JContext): JNotification; cdecl;
  end;
  TJV3CustomNotification = class(TJavaGenericImport<JV3CustomNotificationClass, JV3CustomNotification>) end;


  TDownloadStateKind = (
    STATE_IDLE = 1,
    STATE_FETCHING_URL = 2,
    STATE_CONNECTING = 3,
    STATE_DOWNLOADING = 4,
    STATE_COMPLETED = 5,
    STATE_PAUSED_NETWORK_UNAVAILABLE = 6,
    STATE_PAUSED_BY_REQUEST = 7,
    STATE_PAUSED_WIFI_DISABLED_NEED_CELLULAR_PERMISSION = 8,
    STATE_PAUSED_NEED_CELLULAR_PERMISSION = 9,
    STATE_PAUSED_WIFI_DISABLED = 10,
    STATE_PAUSED_NEED_WIFI = 11,
    STATE_PAUSED_ROAMING = 12,
    STATE_PAUSED_NETWORK_SETUP_FAILURE = 13,
    STATE_PAUSED_SDCARD_UNAVAILABLE = 14,
    STATE_FAILED_UNLICENSED = 15,
    STATE_FAILED_FETCHING_URL = 16,
    STATE_FAILED_SDCARD_FULL = 17,
    STATE_FAILED_CANCELED = 18,
    STATE_FAILED = 19
  );

  TObbStateKind = (
    ERROR_INTERNAL = 20,
    ERROR_COULD_NOT_MOUNT = 21,
    ERROR_COULD_NOT_UNMOUNT = 22,
    ERROR_NOT_MOUNTED = 23,
    ERROR_ALREADY_MOUNTED = 24,
    ERROR_PERMISSION_DENIED = 25,
    MOUNTED = 1,
    UNMOUNTED = 2
  );

  TObb = class;

  TDownloadProgressInfo = record
    OverallTotal,
    OverallProgress,
    TimeRemaining: Int64;
    CurrentSpeed: Single;
  end;

  TApkFileInfo = record
    IsMainFile: Boolean;
    FileVersion: Integer;
    FileSize: Int64;
    EncriptKey: string;
    function GetObb: TObb;
    function ToJApkFileInfo: JApkFileInfo;
  end;

  TApkExpansion = class
  public
    class function AreFilesDelivered(MainFile: TApkFileInfo): Boolean; overload;
    class function AreFilesDelivered(MainFile, PatchFile: TApkFileInfo): Boolean; overload;
  end;

  TOnObbStateChangeCallback = procedure(Obb: TObb; const State: TObbStateKind) of object;

  TObb = class(TJavaLocal, JObb_ObbListener)
  private
    FObb: JObb;
    FOnStateChange: TOnObbStateChangeCallback;
  public
    constructor Create(ApkFile: TApkFileInfo); overload;
    function GetName: string;
    function GetPath: string;
    function GetMountedPath: string;
    function GetResourcePath(filePath: string): string;
    function IsMounted: Boolean;
    procedure Mount(Callback: TOnObbStateChangeCallback);
    procedure onObbStateChange(path: JString; state: Integer); cdecl;
    procedure Unmount(Callback: TOnObbStateChangeCallback; Force: Boolean);
  end;
  {
  TOnActivityDownloaderFinish = procedure(ResultCode: Integer) of object;

  TActivityDownloader = class
  const
    kActivityResultCode = 1000;
  private
    FDownloader: JDownloaderActivityLauncher;
    FOnFinish: TOnActivityDownloaderFinish;
    procedure ResultCallback(const Sender: TObject; const M: TMessage);
  public
    constructor Create(PublicKey: string; Salt: array of Byte; MainFile: TApkFileInfo); overload;
    constructor Create(PublicKey: string; Salt: array of Byte; MainFile, PatchFile: TApkFileInfo); overload;
    function Launch(Callback: TOnActivityDownloaderFinish): Boolean;
    procedure SetNotificationLabels(Labels: TDictionary<string, string>);
    procedure SetDownloaderLabels(Labels: TDictionary<string, string>);
  end;
  }

  TOnDownloadStateChange = procedure(NewState: TDownloadStateKind) of object;
  TOnDownloadProgress = procedure(DownloadInfo: TDownloadProgressInfo) of object;

  TNativeDownloader = class(TJavaLocal, JApkDownloaderListener)
  private
    FDownloader: JNativeDownloaderLauncher;
    FStateChangeCallback: TOnDownloadStateChange;
    FDownloadProgressCallback: TOnDownloadProgress;
    FMainFile, FPatchFile: TApkFileInfo;
  public
    constructor Create(PublicKey: string; Salt: array of Byte; MainFile: TApkFileInfo); overload;
    constructor Create(PublicKey: string; Salt: array of Byte; MainFile, PatchFile: TApkFileInfo); overload;
    procedure ClearCallbacks;
    procedure DoLaunch;
    function Launch(StateChangeCallback: TOnDownloadStateChange; DownloadProgressCallback: TOnDownloadProgress): Boolean;
    procedure requestAbortDownload;
    procedure requestContinueDownload;
    procedure requestPauseDownload;
    procedure onDownloadProgress(progress: JDownloadProgressInfo); cdecl;
    procedure onDownloadStateChanged(newState: Integer); cdecl;
    procedure onStart;
    procedure onStop;
  end;

  TRunMethod = procedure of object;
  TUIThread = class(TJavaLocal, JRunnable)
  private
    FRunMethod: TRunMethod;
  public
    constructor Create(RunMethod: TRunMethod); overload;
    procedure run; cdecl;
  end;

 implementation

uses
  System.Classes,
  System.Messaging,
  Generics.Collections,
  Androidapi.NativeActivity,
  Androidapi.Helpers,
  Androidapi.JNI.Embarcadero;


var
  NativeDownloaderInstance: TNativeDownloader;
  UIThread: TUIThread;

  // Helpers

  function DictionaryToJMap(Dictionary: TDictionary<string, string>): JHashMap;
  var
    Key, Value: string;
  begin
    Result := TJHashMap.JavaClass.init;
    for Key in Dictionary.Keys do
    begin
      Dictionary.TryGetValue(Key, Value);
      Result.put(StringToJString(Key), StringToJString(Value));
    end;
  end;

  function ByteArrayToJArray(ByteArray: array of Byte): TJavaArray<System.Byte>;
  var
    I, Len: Integer;
  begin
    Len := Length(ByteArray);
    Result := TJavaArray<System.Byte>.Create(Len);
    for I := 0 to Len - 1 do
      Result.Items[I] := ByteArray[I];
  end;

  function StringToJStringNull(Str: string): JString;
  begin
    if Str = '' then Result := nil
    else Result := StringToJString(Str)
  end;

  function CreateApkList(MainFile, PatchFile: TApkFileInfo): TJavaObjectArray<JApkFileInfo>;
  var
    ApkNum: Integer;
  begin
    // Only get into account Patch file if Main file exists
    ApkNum := 0;
    if MainFile.FileSize <> 0 then
    begin
      Inc(ApkNum);
      if PatchFile.FileSize <> 0 then
        Inc(ApkNum);
    end;

    if ApkNum > 0 then
    begin
      Result := TJavaObjectArray<JApkFileInfo>.Create(ApkNum);
      if MainFile.FileSize <> 0 then
        Result.Items[0] := MainFile.ToJApkFileInfo;

      if PatchFile.FileSize <> 0 then
        Result.Items[1] := PatchFile.ToJApkFileInfo;
    end;
  end;

  procedure NativeActivityOnStart(ANativeActivity: PANativeActivity);
  begin
    NativeDownloaderInstance.OnStart;
  end;

  procedure NativeActivityOnStop(ANativeActivity: PANativeActivity);
  begin
    NativeDownloaderInstance.OnStop;
  end;

  function GetFMXNativeActivity: JFMXNativeActivity;
  begin
    Result := TJFMXNativeActivity.Wrap(System.JavaContext);
  end;

  { TUIThread }

  constructor TUIThread.Create(RunMethod: TRunMethod);
  begin
    FRunMethod := RunMethod;
    Create;
  end;
  procedure TUIThread.run; cdecl;
  begin
    FRunMethod;
  end;

  { TApkFileInfo }

  function TApkFileInfo.ToJApkFileInfo: JApkFileInfo;
  begin
    Result := TJApkFileInfo.JavaClass.init(IsMainFile,FileVersion, FileSize, StringToJStringNull(EncriptKey));
  end;

  function TApkFileInfo.GetObb: TObb;
  begin
    if TJApkFilesHelper.JavaClass.doesExpansionFileExist(GetFMXNativeActivity, IsMainFile, FileVersion, FileSize, False) then
      Result := TObb.Create(Self)
    else
      Result := nil;
  end;

  class function TApkExpansion.AreFilesDelivered(MainFile: TApkFileInfo): Boolean;
  begin
    Result := TJApkFilesHelper.JavaClass.doesExpansionFileExist(GetFMXNativeActivity, MainFile.IsMainFile, MainFile.FileVersion, MainFile.FileSize, False);
  end;

  class function TApkExpansion.AreFilesDelivered(MainFile, PatchFile: TApkFileInfo): Boolean;
  begin
    Result := TJApkFilesHelper.JavaClass.doesExpansionFileExist(GetFMXNativeActivity, MainFile.IsMainFile, MainFile.FileVersion, MainFile.FileSize, False)
          and TJApkFilesHelper.JavaClass.doesExpansionFileExist(GetFMXNativeActivity, PatchFile.IsMainFile, PatchFile.FileVersion, PatchFile.FileSize, False);
  end;

  { TObb }

  constructor TObb.Create(ApkFile: TApkFileInfo);
  begin
    Create;
    FObb := TJObb.JavaClass.init(GetFMXNativeActivity, ApkFile.ToJApkFileInfo);
    FObb.setListener(Self);
  end;

  function TObb.GetName: string;
  begin
    Result := JStringToString(FObb.getName);
  end;

  function TObb.GetPath: string;
  begin
    Result := JStringToString(FObb.getPath);
  end;

  function TObb.GetMountedPath: string;
  begin
    Result := JStringToString(FObb.getMountedObbPath);
  end;

  function TObb.GetResourcePath(filePath: string): string;
  begin
    Result := JStringToString(FObb.getResourcePath(StringToJString(filePath)));
  end;

  procedure TObb.Mount(Callback: TOnObbStateChangeCallback);
  begin
    FOnStateChange := Callback;
    FObb.mount;
  end;

  procedure TObb.Unmount(Callback: TOnObbStateChangeCallback; Force: Boolean);
  begin
    FOnStateChange := Callback;
    FObb.umount(Force);
  end;

  function TObb.IsMounted: Boolean;
  begin
    Result := FObb.isMounted;
  end;

  procedure TObb.onObbStateChange(path: JString; state: Integer); cdecl;
  begin
    if Assigned(FOnStateChange) then
      TThread.Synchronize(nil, procedure begin
        FOnStateChange(Self, TObbStateKind(state));
      end);
  end;

  { TActivityDownloader }
  {
  constructor TActivityDownloader.Create(PublicKey: string; Salt: array of Byte; MainFile, PatchFile: TApkFileInfo);
  begin
    FDownloader := TJDownloaderActivityLauncher.JavaClass.init(
      StringToJString(PublicKey),ByteArrayToJArray(Salt), CreateApkList(MainFile, PatchFile));
    Create;
  end;

  constructor TActivityDownloader.Create(PublicKey: string; Salt: array of Byte; MainFile: TApkFileInfo);
  var
    Empty: TApkFileInfo;
  begin
    Create(PublicKey, Salt, MainFile, Empty);
  end;

  function TActivityDownloader.Launch(Callback: TOnActivityDownloaderFinish): Boolean;
  begin
    if Assigned(Callback) then
      FOnFinish := Callback;
    TMessageManager.DefaultManager.SubscribeToMessage(TMessageResultNotification, ResultCallback);
    Result := FDownloader.launch(GetFMXNativeActivity, kActivityResultCode);
  end;

  procedure TActivityDownloader.SetNotificationLabels(Labels: TDictionary<string, string>);
  begin
    FDownloader.setNotificationLabels(DictionaryToJMap(Labels));
  end;

  procedure TActivityDownloader.SetDownloaderLabels(Labels: TDictionary<string, string>);
  begin
    FDownloader.SetDownloaderLabels(DictionaryToJMap(Labels));
  end;

  procedure TActivityDownloader.ResultCallback(const Sender: TObject; const M: TMessage);
  begin
    if TMessageResultNotification(M).RequestCode = kActivityResultCode then
    begin
      FDownloader.setActivityEnabled(False);
      if Assigned(FOnFinish) then
        TThread.Synchronize(nil, procedure begin
          FOnFinish(TMessageResultNotification(M).ResultCode);
        end);
    end;
  end;
  }

  { TNativeDownloader }

  constructor TNativeDownloader.Create(PublicKey: string; Salt: array of Byte; MainFile, PatchFile: TApkFileInfo);
  begin
    FMainFile := MainFile;
    FPatchFile := FPatchFile;
    FDownloader := TJNativeDownloaderLauncher.JavaClass.init(StringToJString(PublicKey), ByteArrayToJArray(Salt),
      CreateApkList(MainFile, PatchFile));
    Create;
  end;

  constructor TNativeDownloader.Create(PublicKey: string; Salt: array of Byte; MainFile: TApkFileInfo);
  var
    Empty: TApkFileInfo;
  begin
    Create(PublicKey, Salt, MainFile, Empty);
  end;

  function TNativeDownloader.Launch(StateChangeCallback: TOnDownloadStateChange; DownloadProgressCallback: TOnDownloadProgress): Boolean;
  var
    PNativeActivity: PANativeActivity;
  begin
    Result := not TApkExpansion.AreFilesDelivered(FMainFile, FPatchFile);
    if Result then
    begin
      // Callbacks
      PNativeActivity := PANativeActivity(System.DelphiActivity);
      PNativeActivity^.callbacks^.onStart := @NativeActivityOnStart;
      PNativeActivity^.callbacks^.onStop := @NativeActivityOnStop;
      FStateChangeCallback := StateChangeCallback;
      FDownloadProgressCallback := DownloadProgressCallback;
      // Save the receiver object for the callbacks
      NativeDownloaderInstance := Self;
      // Run in ui thread
      UIThread := TUIThread.Create(DoLaunch);
      GetFMXNativeActivity.runOnUiThread(UIThread);
    end;
  end;

  procedure TNativeDownloader.DoLaunch;
  begin
    FDownloader.launch(GetFMXNativeActivity,Self);
    onStart;
  end;

  procedure TNativeDownloader.ClearCallbacks;
  begin
    FStateChangeCallback := nil;
    FDownloadProgressCallback := nil;
  end;

  procedure TNativeDownloader.requestAbortDownload;
  begin
    FDownloader.requestAbortDownload;
  end;

  procedure TNativeDownloader.requestContinueDownload;
  begin
    FDownloader.requestContinueDownload;
    FDownloader.connect(GetFMXNativeActivity); // re-connect to retrieve notifications
  end;

  procedure TNativeDownloader.requestPauseDownload;
  begin
    FDownloader.requestPauseDownload;
  end;

  procedure TNativeDownloader.onDownloadProgress(progress: JDownloadProgressInfo); cdecl;
  var
    ProgressInfo: TDownloadProgressInfo;
  begin
    if Assigned(FDownloadProgressCallback) then
    begin
      ProgressInfo.OverallTotal := progress.mOverallTotal;
      ProgressInfo.OverallProgress := progress.mOverallProgress;
      ProgressInfo.TimeRemaining := progress.mTimeRemaining;
      ProgressInfo.CurrentSpeed := progress.mCurrentSpeed;
      TThread.Synchronize(nil, procedure begin
        FDownloadProgressCallback(ProgressInfo);
      end);
    end;
  end;

  procedure TNativeDownloader.onDownloadStateChanged(newState: Integer); cdecl;
  begin
    if Assigned(FStateChangeCallback) then
      TThread.Synchronize(nil, procedure begin
        FStateChangeCallback(TDownloadStateKind(newState));
      end);
  end;

  procedure TNativeDownloader.onStart;
  begin
    FDownloader.connect(GetFMXNativeActivity);
  end;

  procedure TNativeDownloader.onStop;
  begin
    FDownloader.disconnect(GetFMXNativeActivity);
  end;


procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JAPEZProvider', TypeInfo(Androidapi.JNI.ApkExpansion.JAPEZProvider));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JAPKExpansionSupport', TypeInfo(Androidapi.JNI.ApkExpansion.JAPKExpansionSupport));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JZipResourceFile', TypeInfo(Androidapi.JNI.ApkExpansion.JZipResourceFile));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JZipResourceFile_ZipEntryRO', TypeInfo(Androidapi.JNI.ApkExpansion.JZipResourceFile_ZipEntryRO));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JApkAlarmReceiver', TypeInfo(Androidapi.JNI.ApkExpansion.JApkAlarmReceiver));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JApkBaseDownloader', TypeInfo(Androidapi.JNI.ApkExpansion.JApkBaseDownloader));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JApkDownloaderClient', TypeInfo(Androidapi.JNI.ApkExpansion.JApkDownloaderClient));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JApkDownloaderListener', TypeInfo(Androidapi.JNI.ApkExpansion.JApkDownloaderListener));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JCustomIntentService', TypeInfo(Androidapi.JNI.ApkExpansion.JCustomIntentService));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloaderService', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloaderService));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JApkDownloaderService', TypeInfo(Androidapi.JNI.ApkExpansion.JApkDownloaderService));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JApkFileInfo', TypeInfo(Androidapi.JNI.ApkExpansion.JApkFileInfo));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JApkFilesHelper', TypeInfo(Androidapi.JNI.ApkExpansion.JApkFilesHelper));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JObb', TypeInfo(Androidapi.JNI.ApkExpansion.JObb));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JObb_ObbListener', TypeInfo(Androidapi.JNI.ApkExpansion.JObb_ObbListener));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloaderActivity', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloaderActivity));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloaderActivityConfig', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloaderActivityConfig));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloaderActivityLauncher', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloaderActivityLauncher));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JNativeDownloaderLauncher', TypeInfo(Androidapi.JNI.ApkExpansion.JNativeDownloaderLauncher));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JConstants', TypeInfo(Androidapi.JNI.ApkExpansion.JConstants));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloadProgressInfo', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloadProgressInfo));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloaderClientMarshaller', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloaderClientMarshaller));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloaderServiceMarshaller', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloaderServiceMarshaller));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JHelpers', TypeInfo(Androidapi.JNI.ApkExpansion.JHelpers));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JIDownloaderClient', TypeInfo(Androidapi.JNI.ApkExpansion.JIDownloaderClient));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JIDownloaderService', TypeInfo(Androidapi.JNI.ApkExpansion.JIDownloaderService));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JIStub', TypeInfo(Androidapi.JNI.ApkExpansion.JIStub));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JNotificationLabels', TypeInfo(Androidapi.JNI.ApkExpansion.JNotificationLabels));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JCustomNotificationFactory', TypeInfo(Androidapi.JNI.ApkExpansion.JCustomNotificationFactory));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloadInfo', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloadInfo));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloadNotification', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloadNotification));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloadNotification_ICustomNotification', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloadNotification_ICustomNotification));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloadThread', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloadThread));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloaderService_GenerateSaveFileError', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloaderService_GenerateSaveFileError));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloadsDB', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloadsDB));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloadsDB_DownloadColumns', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloadsDB_DownloadColumns));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JDownloadsDB_MetadataColumns', TypeInfo(Androidapi.JNI.ApkExpansion.JDownloadsDB_MetadataColumns));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JHttpDateTime', TypeInfo(Androidapi.JNI.ApkExpansion.JHttpDateTime));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JV14CustomNotification', TypeInfo(Androidapi.JNI.ApkExpansion.JV14CustomNotification));
  TRegTypes.RegisterType('Androidapi.JNI.ApkExpansion.JV3CustomNotification', TypeInfo(Androidapi.JNI.ApkExpansion.JV3CustomNotification));
end;

initialization
  RegisterTypes;
end.




