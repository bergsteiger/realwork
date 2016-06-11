{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.CommonTypes;

interface

{$MINENUMSIZE 4}

uses
  Winapi.Foundation,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types;

{$SCOPEDENUMS ON}

type
  // Windows.Foundation.Collections Enums
  // Windows.Foundation.Collections.CollectionChange
  CollectionChange = (
    Reset = 0,
    ItemInserted = 1,
    ItemRemoved = 2,
    ItemChanged = 3
  );
  PCollectionChange = ^CollectionChange;



  // Windows.System Enums
  // Windows.System.Power.BatteryStatus
  Power_BatteryStatus = (
    NotPresent = 0,
    Discharging = 1,
    Idle = 2,
    Charging = 3
  );
  PPower_BatteryStatus = ^Power_BatteryStatus;

  // Windows.System.Power.EnergySaverStatus
  Power_EnergySaverStatus = (
    Disabled = 0,
    Off = 1,
    On = 2
  );
  PPower_EnergySaverStatus = ^Power_EnergySaverStatus;

  // Windows.System.Power.PowerSupplyStatus
  Power_PowerSupplyStatus = (
    NotPresent = 0,
    Inadequate = 1,
    Adequate = 2
  );
  PPower_PowerSupplyStatus = ^Power_PowerSupplyStatus;

  // Windows.System.AppMemoryUsageLevel
  AppMemoryUsageLevel = (
    Low = 0,
    Medium = 1,
    High = 2
  );
  PAppMemoryUsageLevel = ^AppMemoryUsageLevel;

  // Windows.System.Threading.WorkItemPriority
  Threading_WorkItemPriority = (
    Low = -1,
    Normal = 0,
    High = 1
  );
  PThreading_WorkItemPriority = ^Threading_WorkItemPriority;

  // Windows.System.Threading.WorkItemOptions
  Threading_WorkItemOptions = (
    None = 0,
    TimeSliced = 1
  );
  PThreading_WorkItemOptions = ^Threading_WorkItemOptions;

  // Windows.System.ProcessorArchitecture
  ProcessorArchitecture = (
    X86 = 0,
    Arm = 5,
    X64 = 9,
    Neutral = 11,
    Unknown = 65535
  );
  PProcessorArchitecture = ^ProcessorArchitecture;

  // Windows.System.VirtualKeyModifiers
  VirtualKeyModifiers = (
    None = 0,
    Control = 1,
    Menu = 2,
    Shift = 4,
    Windows = 8
  );
  PVirtualKeyModifiers = ^VirtualKeyModifiers;

  // Windows.System.VirtualKey
  VirtualKey = (
    None = 0,
    LeftButton = 1,
    RightButton = 2,
    Cancel = 3,
    MiddleButton = 4,
    XButton1 = 5,
    XButton2 = 6,
    Back = 8,
    Tab = 9,
    Clear = 12,
    Enter = 13,
    Shift = 16,
    Control = 17,
    Menu = 18,
    Pause = 19,
    CapitalLock = 20,
    Kana = 21,
    Hangul = 21,
    Junja = 23,
    Final = 24,
    Hanja = 25,
    Kanji = 25,
    Escape = 27,
    Convert = 28,
    NonConvert = 29,
    Accept = 30,
    ModeChange = 31,
    Space = 32,
    PageUp = 33,
    PageDown = 34,
    &End = 35,
    Home = 36,
    Left = 37,
    Up = 38,
    Right = 39,
    Down = 40,
    Select = 41,
    Print = 42,
    Execute = 43,
    Snapshot = 44,
    Insert = 45,
    Delete = 46,
    Help = 47,
    Number0 = 48,
    Number1 = 49,
    Number2 = 50,
    Number3 = 51,
    Number4 = 52,
    Number5 = 53,
    Number6 = 54,
    Number7 = 55,
    Number8 = 56,
    Number9 = 57,
    A = 65,
    B = 66,
    C = 67,
    D = 68,
    E = 69,
    F = 70,
    G = 71,
    H = 72,
    I = 73,
    J = 74,
    K = 75,
    L = 76,
    M = 77,
    N = 78,
    O = 79,
    P = 80,
    Q = 81,
    R = 82,
    S = 83,
    T = 84,
    U = 85,
    V = 86,
    W = 87,
    X = 88,
    Y = 89,
    Z = 90,
    LeftWindows = 91,
    RightWindows = 92,
    Application = 93,
    Sleep = 95,
    NumberPad0 = 96,
    NumberPad1 = 97,
    NumberPad2 = 98,
    NumberPad3 = 99,
    NumberPad4 = 100,
    NumberPad5 = 101,
    NumberPad6 = 102,
    NumberPad7 = 103,
    NumberPad8 = 104,
    NumberPad9 = 105,
    Multiply = 106,
    Add = 107,
    Separator = 108,
    Subtract = 109,
    Decimal = 110,
    Divide = 111,
    F1 = 112,
    F2 = 113,
    F3 = 114,
    F4 = 115,
    F5 = 116,
    F6 = 117,
    F7 = 118,
    F8 = 119,
    F9 = 120,
    F10 = 121,
    F11 = 122,
    F12 = 123,
    F13 = 124,
    F14 = 125,
    F15 = 126,
    F16 = 127,
    F17 = 128,
    F18 = 129,
    F19 = 130,
    F20 = 131,
    F21 = 132,
    F22 = 133,
    F23 = 134,
    F24 = 135,
    NavigationView = 136,
    NavigationMenu = 137,
    NavigationUp = 138,
    NavigationDown = 139,
    NavigationLeft = 140,
    NavigationRight = 141,
    NavigationAccept = 142,
    NavigationCancel = 143,
    NumberKeyLock = 144,
    Scroll = 145,
    LeftShift = 160,
    RightShift = 161,
    LeftControl = 162,
    RightControl = 163,
    LeftMenu = 164,
    RightMenu = 165,
    GoBack = 166,
    GoForward = 167,
    Refresh = 168,
    Stop = 169,
    Search = 170,
    Favorites = 171,
    GoHome = 172,
    GamepadA = 195,
    GamepadB = 196,
    GamepadX = 197,
    GamepadY = 198,
    GamepadRightShoulder = 199,
    GamepadLeftShoulder = 200,
    GamepadLeftTrigger = 201,
    GamepadRightTrigger = 202,
    GamepadDPadUp = 203,
    GamepadDPadDown = 204,
    GamepadDPadLeft = 205,
    GamepadDPadRight = 206,
    GamepadMenu = 207,
    GamepadView = 208,
    GamepadLeftThumbstickButton = 209,
    GamepadRightThumbstickButton = 210,
    GamepadLeftThumbstickUp = 211,
    GamepadLeftThumbstickDown = 212,
    GamepadLeftThumbstickRight = 213,
    GamepadLeftThumbstickLeft = 214,
    GamepadRightThumbstickUp = 215,
    GamepadRightThumbstickDown = 216,
    GamepadRightThumbstickRight = 217,
    GamepadRightThumbstickLeft = 218
  );
  PVirtualKey = ^VirtualKey;

  // Windows.System.UserAuthenticationStatus
  UserAuthenticationStatus = (
    Unauthenticated = 0,
    LocallyAuthenticated = 1,
    RemotelyAuthenticated = 2
  );
  PUserAuthenticationStatus = ^UserAuthenticationStatus;

  // Windows.System.UserType
  UserType = (
    LocalUser = 0,
    RemoteUser = 1,
    LocalGuest = 2,
    RemoteGuest = 3
  );
  PUserType = ^UserType;

  // Windows.System.UserPictureSize
  UserPictureSize = (
    Size64x64 = 0,
    Size208x208 = 1,
    Size424x424 = 2,
    Size1080x1080 = 3
  );
  PUserPictureSize = ^UserPictureSize;

  // Windows.System.UserWatcherStatus
  UserWatcherStatus = (
    Created = 0,
    Started = 1,
    EnumerationCompleted = 2,
    Stopping = 3,
    Stopped = 4,
    Aborted = 5
  );
  PUserWatcherStatus = ^UserWatcherStatus;

  // Windows.System.LaunchQuerySupportType
  LaunchQuerySupportType = (
    Uri = 0,
    UriForResults = 1
  );
  PLaunchQuerySupportType = ^LaunchQuerySupportType;

  // Windows.System.LaunchQuerySupportStatus
  LaunchQuerySupportStatus = (
    Available = 0,
    AppNotInstalled = 1,
    AppUnavailable = 2,
    NotSupported = 3,
    Unknown = 4
  );
  PLaunchQuerySupportStatus = ^LaunchQuerySupportStatus;

  // Windows.System.LaunchUriStatus
  LaunchUriStatus = (
    Success = 0,
    AppUnavailable = 1,
    ProtocolUnavailable = 2,
    Unknown = 3
  );
  PLaunchUriStatus = ^LaunchUriStatus;

  // Windows.System.ShutdownKind
  ShutdownKind = (
    Shutdown = 0,
    Restart = 1
  );
  PShutdownKind = ^ShutdownKind;

  // Windows.System.UserProfile.AccountPictureKind
  UserProfile_AccountPictureKind = (
    SmallImage = 0,
    LargeImage = 1,
    Video = 2
  );
  PUserProfile_AccountPictureKind = ^UserProfile_AccountPictureKind;

  // Windows.System.UserProfile.SetAccountPictureResult
  UserProfile_SetAccountPictureResult = (
    Success = 0,
    ChangeDisabled = 1,
    LargeOrDynamicError = 2,
    VideoFrameSizeError = 3,
    FileSizeError = 4,
    Failure = 5
  );
  PUserProfile_SetAccountPictureResult = ^UserProfile_SetAccountPictureResult;

  // Windows.System.UserProfile.SetImageFeedResult
  UserProfile_SetImageFeedResult = (
    Success = 0,
    ChangeDisabled = 1,
    UserCanceled = 2
  );
  PUserProfile_SetImageFeedResult = ^UserProfile_SetImageFeedResult;


  // Windows.System Records
  // Windows.System.SystemManagementContract
  SystemManagementContract = record
  end;
  PSystemManagementContract = ^SystemManagementContract;

  // Windows.System.UserProfile.UserProfileLockScreenContract
  UserProfile_UserProfileLockScreenContract = record
  end;
  PUserProfile_UserProfileLockScreenContract = ^UserProfile_UserProfileLockScreenContract;

  // Windows.System.Profile.SystemManufacturers.SystemManufacturersContract
  Profile_SystemManufacturers_SystemManufacturersContract = record
  end;
  PProfile_SystemManufacturers_SystemManufacturersContract = ^Profile_SystemManufacturers_SystemManufacturersContract;

  // Windows.System.UserProfile.UserProfileContract
  UserProfile_UserProfileContract = record
  end;
  PUserProfile_UserProfileContract = ^UserProfile_UserProfileContract;

  // Windows.System.Profile.ProfileHardwareTokenContract
  Profile_ProfileHardwareTokenContract = record
  end;
  PProfile_ProfileHardwareTokenContract = ^Profile_ProfileHardwareTokenContract;

  // Windows.System.Profile.ProfileRetailInfoContract
  Profile_ProfileRetailInfoContract = record
  end;
  PProfile_ProfileRetailInfoContract = ^Profile_ProfileRetailInfoContract;



  // Windows.Services Enums
  // Windows.Services.Maps.MapRouteOptimization
  Maps_MapRouteOptimization = (
    Time = 0,
    Distance = 1,
    TimeWithTraffic = 2
  );
  PMaps_MapRouteOptimization = ^Maps_MapRouteOptimization;

  // Windows.Services.Maps.MapRouteRestrictions
  Maps_MapRouteRestrictions = (
    None = 0,
    Highways = 1,
    TollRoads = 2,
    Ferries = 4,
    Tunnels = 8,
    DirtRoads = 16,
    Motorail = 32
  );
  PMaps_MapRouteRestrictions = ^Maps_MapRouteRestrictions;

  // Windows.Services.Maps.MapRouteManeuverKind
  Maps_MapRouteManeuverKind = (
    None = 0,
    Start = 1,
    Stopover = 2,
    StopoverResume = 3,
    &End = 4,
    GoStraight = 5,
    UTurnLeft = 6,
    UTurnRight = 7,
    TurnKeepLeft = 8,
    TurnKeepRight = 9,
    TurnLightLeft = 10,
    TurnLightRight = 11,
    TurnLeft = 12,
    TurnRight = 13,
    TurnHardLeft = 14,
    TurnHardRight = 15,
    FreewayEnterLeft = 16,
    FreewayEnterRight = 17,
    FreewayLeaveLeft = 18,
    FreewayLeaveRight = 19,
    FreewayContinueLeft = 20,
    FreewayContinueRight = 21,
    TrafficCircleLeft = 22,
    TrafficCircleRight = 23,
    TakeFerry = 24
  );
  PMaps_MapRouteManeuverKind = ^Maps_MapRouteManeuverKind;

  // Windows.Services.Maps.MapManeuverNotices
  Maps_MapManeuverNotices = (
    None = 0,
    Toll = 1,
    Unpaved = 2
  );
  PMaps_MapManeuverNotices = ^Maps_MapManeuverNotices;

  // Windows.Services.Maps.MapLocationFinderStatus
  Maps_MapLocationFinderStatus = (
    Success = 0,
    UnknownError = 1,
    InvalidCredentials = 2,
    BadLocation = 3,
    IndexFailure = 4,
    NetworkFailure = 5,
    NotSupported = 6
  );
  PMaps_MapLocationFinderStatus = ^Maps_MapLocationFinderStatus;

  // Windows.Services.Maps.MapRouteFinderStatus
  Maps_MapRouteFinderStatus = (
    Success = 0,
    UnknownError = 1,
    InvalidCredentials = 2,
    NoRouteFound = 3,
    NoRouteFoundWithGivenOptions = 4,
    StartPointNotFound = 5,
    EndPointNotFound = 6,
    NoPedestrianRouteFound = 7,
    NetworkFailure = 8,
    NotSupported = 9
  );
  PMaps_MapRouteFinderStatus = ^Maps_MapRouteFinderStatus;

  // Windows.Services.Maps.Guidance.GuidanceManeuverKind
  Maps_Guidance_GuidanceManeuverKind = (
    None = 0,
    GoStraight = 1,
    UTurnRight = 2,
    UTurnLeft = 3,
    TurnKeepRight = 4,
    TurnLightRight = 5,
    TurnRight = 6,
    TurnHardRight = 7,
    KeepMiddle = 8,
    TurnKeepLeft = 9,
    TurnLightLeft = 10,
    TurnLeft = 11,
    TurnHardLeft = 12,
    FreewayEnterRight = 13,
    FreewayEnterLeft = 14,
    FreewayLeaveRight = 15,
    FreewayLeaveLeft = 16,
    FreewayKeepRight = 17,
    FreewayKeepLeft = 18,
    TrafficCircleRight1 = 19,
    TrafficCircleRight2 = 20,
    TrafficCircleRight3 = 21,
    TrafficCircleRight4 = 22,
    TrafficCircleRight5 = 23,
    TrafficCircleRight6 = 24,
    TrafficCircleRight7 = 25,
    TrafficCircleRight8 = 26,
    TrafficCircleRight9 = 27,
    TrafficCircleRight10 = 28,
    TrafficCircleRight11 = 29,
    TrafficCircleRight12 = 30,
    TrafficCircleLeft1 = 31,
    TrafficCircleLeft2 = 32,
    TrafficCircleLeft3 = 33,
    TrafficCircleLeft4 = 34,
    TrafficCircleLeft5 = 35,
    TrafficCircleLeft6 = 36,
    TrafficCircleLeft7 = 37,
    TrafficCircleLeft8 = 38,
    TrafficCircleLeft9 = 39,
    TrafficCircleLeft10 = 40,
    TrafficCircleLeft11 = 41,
    TrafficCircleLeft12 = 42,
    Start = 43,
    &End = 44,
    TakeFerry = 45,
    PassTransitStation = 46,
    LeaveTransitStation = 47
  );
  PMaps_Guidance_GuidanceManeuverKind = ^Maps_Guidance_GuidanceManeuverKind;

  // Windows.Services.Maps.Guidance.GuidanceMode
  Maps_Guidance_GuidanceMode = (
    None = 0,
    Simulation = 1,
    Navigation = 2,
    Tracking = 3
  );
  PMaps_Guidance_GuidanceMode = ^Maps_Guidance_GuidanceMode;

  // Windows.Services.Maps.Guidance.GuidanceAudioMeasurementSystem
  Maps_Guidance_GuidanceAudioMeasurementSystem = (
    Meters = 0,
    MilesAndYards = 1,
    MilesAndFeet = 2
  );
  PMaps_Guidance_GuidanceAudioMeasurementSystem = ^Maps_Guidance_GuidanceAudioMeasurementSystem;

  // Windows.Services.Maps.Guidance.GuidanceAudioNotifications
  Maps_Guidance_GuidanceAudioNotifications = (
    None = 0,
    Maneuver = 1,
    Route = 2,
    Gps = 4,
    SpeedLimit = 8,
    Traffic = 16,
    TrafficCamera = 32
  );
  PMaps_Guidance_GuidanceAudioNotifications = ^Maps_Guidance_GuidanceAudioNotifications;

  // Windows.Services.Maps.Guidance.GuidanceLaneMarkers
  Maps_Guidance_GuidanceLaneMarkers = (
    None = 0,
    LightRight = 1,
    Right = 2,
    HardRight = 4,
    Straight = 8,
    UTurnLeft = 16,
    HardLeft = 32,
    Left = 64,
    LightLeft = 128,
    UTurnRight = 256,
    Unknown = -1
  );
  PMaps_Guidance_GuidanceLaneMarkers = ^Maps_Guidance_GuidanceLaneMarkers;

  // Windows.Services.Maps.LocalSearch.LocalLocationFinderStatus
  Maps_LocalSearch_LocalLocationFinderStatus = (
    Success = 0,
    UnknownError = 1,
    InvalidCredentials = 2,
    InvalidCategory = 3,
    InvalidSearchTerm = 4,
    InvalidSearchArea = 5,
    NetworkFailure = 6,
    NotSupported = 7
  );
  PMaps_LocalSearch_LocalLocationFinderStatus = ^Maps_LocalSearch_LocalLocationFinderStatus;


  // Windows.Services Records
  // Windows.Services.Maps.GuidanceContract
  Maps_GuidanceContract = record
  end;
  PMaps_GuidanceContract = ^Maps_GuidanceContract;

  // Windows.Services.Maps.LocalSearchContract
  Maps_LocalSearchContract = record
  end;
  PMaps_LocalSearchContract = ^Maps_LocalSearchContract;



  // Windows.Storage Enums
  // Windows.Storage.Pickers.Provider.AddFileResult
  Pickers_Provider_AddFileResult = (
    Added = 0,
    AlreadyAdded = 1,
    NotAllowed = 2,
    Unavailable = 3
  );
  PPickers_Provider_AddFileResult = ^Pickers_Provider_AddFileResult;

  // Windows.Storage.Pickers.Provider.FileSelectionMode
  Pickers_Provider_FileSelectionMode = (
    Single = 0,
    Multiple = 1
  );
  PPickers_Provider_FileSelectionMode = ^Pickers_Provider_FileSelectionMode;

  // Windows.Storage.Pickers.Provider.SetFileNameResult
  Pickers_Provider_SetFileNameResult = (
    Succeeded = 0,
    NotAllowed = 1,
    Unavailable = 2
  );
  PPickers_Provider_SetFileNameResult = ^Pickers_Provider_SetFileNameResult;

  // Windows.Storage.Provider.CachedFileTarget
  Provider_CachedFileTarget = (
    Local = 0,
    Remote = 1
  );
  PProvider_CachedFileTarget = ^Provider_CachedFileTarget;

  // Windows.Storage.Provider.UIStatus
  Provider_UIStatus = (
    Unavailable = 0,
    Hidden = 1,
    Visible = 2,
    Complete = 3
  );
  PProvider_UIStatus = ^Provider_UIStatus;

  // Windows.Storage.FileProperties.PropertyPrefetchOptions
  FileProperties_PropertyPrefetchOptions = (
    None = 0,
    MusicProperties = 1,
    VideoProperties = 2,
    ImageProperties = 4,
    DocumentProperties = 8,
    BasicProperties = 16
  );
  PFileProperties_PropertyPrefetchOptions = ^FileProperties_PropertyPrefetchOptions;

  // Windows.Storage.FileProperties.ThumbnailType
  FileProperties_ThumbnailType = (
    Image = 0,
    Icon = 1
  );
  PFileProperties_ThumbnailType = ^FileProperties_ThumbnailType;

  // Windows.Storage.FileProperties.ThumbnailMode
  FileProperties_ThumbnailMode = (
    PicturesView = 0,
    VideosView = 1,
    MusicView = 2,
    DocumentsView = 3,
    ListView = 4,
    SingleItem = 5
  );
  PFileProperties_ThumbnailMode = ^FileProperties_ThumbnailMode;

  // Windows.Storage.FileProperties.ThumbnailOptions
  FileProperties_ThumbnailOptions = (
    None = 0,
    ReturnOnlyIfCached = 1,
    ResizeThumbnail = 2,
    UseCurrentScale = 4
  );
  PFileProperties_ThumbnailOptions = ^FileProperties_ThumbnailOptions;

  // Windows.Storage.FileProperties.PhotoOrientation
  FileProperties_PhotoOrientation = (
    Unspecified = 0,
    Normal = 1,
    FlipHorizontal = 2,
    Rotate180 = 3,
    FlipVertical = 4,
    Transpose = 5,
    Rotate270 = 6,
    Transverse = 7,
    Rotate90 = 8
  );
  PFileProperties_PhotoOrientation = ^FileProperties_PhotoOrientation;

  // Windows.Storage.FileProperties.VideoOrientation
  FileProperties_VideoOrientation = (
    Normal = 0,
    Rotate90 = 90,
    Rotate180 = 180,
    Rotate270 = 270
  );
  PFileProperties_VideoOrientation = ^FileProperties_VideoOrientation;

  // Windows.Storage.KnownLibraryId
  KnownLibraryId = (
    Music = 0,
    Pictures = 1,
    Videos = 2,
    Documents = 3
  );
  PKnownLibraryId = ^KnownLibraryId;

  // Windows.Storage.CreationCollisionOption
  CreationCollisionOption = (
    GenerateUniqueName = 0,
    ReplaceExisting = 1,
    FailIfExists = 2,
    OpenIfExists = 3
  );
  PCreationCollisionOption = ^CreationCollisionOption;

  // Windows.Storage.NameCollisionOption
  NameCollisionOption = (
    GenerateUniqueName = 0,
    ReplaceExisting = 1,
    FailIfExists = 2
  );
  PNameCollisionOption = ^NameCollisionOption;

  // Windows.Storage.StorageDeleteOption
  StorageDeleteOption = (
    Default = 0,
    PermanentDelete = 1
  );
  PStorageDeleteOption = ^StorageDeleteOption;

  // Windows.Storage.StorageItemTypes
  StorageItemTypes = (
    None = 0,
    &File = 1,
    Folder = 2
  );
  PStorageItemTypes = ^StorageItemTypes;

  // Windows.Storage.FileAttributes
  FileAttributes = (
    Normal = 0,
    ReadOnly = 1,
    Directory = 16,
    Archive = 32,
    Temporary = 256,
    LocallyIncomplete = 512
  );
  PFileAttributes = ^FileAttributes;

  // Windows.Storage.FileAccessMode
  FileAccessMode = (
    Read = 0,
    ReadWrite = 1
  );
  PFileAccessMode = ^FileAccessMode;

  // Windows.Storage.Search.DateStackOption
  Search_DateStackOption = (
    None = 0,
    Year = 1,
    Month = 2
  );
  PSearch_DateStackOption = ^Search_DateStackOption;

  // Windows.Storage.Search.IndexerOption
  Search_IndexerOption = (
    UseIndexerWhenAvailable = 0,
    OnlyUseIndexer = 1,
    DoNotUseIndexer = 2
  );
  PSearch_IndexerOption = ^Search_IndexerOption;

  // Windows.Storage.Search.FolderDepth
  Search_FolderDepth = (
    Shallow = 0,
    Deep = 1
  );
  PSearch_FolderDepth = ^Search_FolderDepth;

  // Windows.Storage.Search.CommonFileQuery
  Search_CommonFileQuery = (
    DefaultQuery = 0,
    OrderByName = 1,
    OrderByTitle = 2,
    OrderByMusicProperties = 3,
    OrderBySearchRank = 4,
    OrderByDate = 5
  );
  PSearch_CommonFileQuery = ^Search_CommonFileQuery;

  // Windows.Storage.Search.CommonFolderQuery
  Search_CommonFolderQuery = (
    DefaultQuery = 0,
    GroupByYear = 100,
    GroupByMonth = 101,
    GroupByArtist = 102,
    GroupByAlbum = 103,
    GroupByAlbumArtist = 104,
    GroupByComposer = 105,
    GroupByGenre = 106,
    GroupByPublishedYear = 107,
    GroupByRating = 108,
    GroupByTag = 109,
    GroupByAuthor = 110,
    GroupByType = 111
  );
  PSearch_CommonFolderQuery = ^Search_CommonFolderQuery;

  // Windows.Storage.Search.IndexedState
  Search_IndexedState = (
    Unknown = 0,
    NotIndexed = 1,
    PartiallyIndexed = 2,
    FullyIndexed = 3
  );
  PSearch_IndexedState = ^Search_IndexedState;

  // Windows.Storage.StreamedFileFailureMode
  StreamedFileFailureMode = (
    Failed = 0,
    CurrentlyUnavailable = 1,
    Incomplete = 2
  );
  PStreamedFileFailureMode = ^StreamedFileFailureMode;

  // Windows.Storage.Provider.FileUpdateStatus
  Provider_FileUpdateStatus = (
    Incomplete = 0,
    Complete = 1,
    UserInputNeeded = 2,
    CurrentlyUnavailable = 3,
    Failed = 4,
    CompleteAndRenamed = 5
  );
  PProvider_FileUpdateStatus = ^Provider_FileUpdateStatus;

  // Windows.Storage.Provider.CachedFileOptions
  Provider_CachedFileOptions = (
    None = 0,
    RequireUpdateOnAccess = 1,
    UseCachedFileWhenOffline = 2,
    DenyAccessWhenOffline = 4
  );
  PProvider_CachedFileOptions = ^Provider_CachedFileOptions;

  // Windows.Storage.Provider.ReadActivationMode
  Provider_ReadActivationMode = (
    NotNeeded = 0,
    BeforeAccess = 1
  );
  PProvider_ReadActivationMode = ^Provider_ReadActivationMode;

  // Windows.Storage.Provider.WriteActivationMode
  Provider_WriteActivationMode = (
    ReadOnly = 0,
    NotNeeded = 1,
    AfterWrite = 2
  );
  PProvider_WriteActivationMode = ^Provider_WriteActivationMode;

  // Windows.Storage.StorageOpenOptions
  StorageOpenOptions = (
    None = 0,
    AllowOnlyReaders = 1
  );
  PStorageOpenOptions = ^StorageOpenOptions;

  // Windows.Storage.AccessCache.AccessCacheOptions
  AccessCache_AccessCacheOptions = (
    None = 0,
    DisallowUserInput = 1,
    FastLocationsOnly = 2,
    UseReadOnlyCachedCopy = 4,
    SuppressAccessTimeUpdate = 8
  );
  PAccessCache_AccessCacheOptions = ^AccessCache_AccessCacheOptions;

  // Windows.Storage.AccessCache.RecentStorageItemVisibility
  AccessCache_RecentStorageItemVisibility = (
    AppOnly = 0,
    AppAndSystem = 1
  );
  PAccessCache_RecentStorageItemVisibility = ^AccessCache_RecentStorageItemVisibility;

  // Windows.Storage.Pickers.PickerViewMode
  Pickers_PickerViewMode = (
    List = 0,
    Thumbnail = 1
  );
  PPickers_PickerViewMode = ^Pickers_PickerViewMode;

  // Windows.Storage.Pickers.PickerLocationId
  Pickers_PickerLocationId = (
    DocumentsLibrary = 0,
    ComputerFolder = 1,
    Desktop = 2,
    Downloads = 3,
    HomeGroup = 4,
    MusicLibrary = 5,
    PicturesLibrary = 6,
    VideosLibrary = 7,
    Objects3D = 8,
    Unspecified = 9
  );
  PPickers_PickerLocationId = ^Pickers_PickerLocationId;

  // Windows.Storage.ApplicationDataLocality
  ApplicationDataLocality = (
    Local = 0,
    Roaming = 1,
    Temporary = 2,
    LocalCache = 3
  );
  PApplicationDataLocality = ^ApplicationDataLocality;

  // Windows.Storage.ApplicationDataCreateDisposition
  ApplicationDataCreateDisposition = (
    Always = 0,
    Existing = 1
  );
  PApplicationDataCreateDisposition = ^ApplicationDataCreateDisposition;

  // Windows.Storage.Compression.CompressAlgorithm
  Compression_CompressAlgorithm = (
    InvalidAlgorithm = 0,
    NullAlgorithm = 1,
    Mszip = 2,
    Xpress = 3,
    XpressHuff = 4,
    Lzms = 5
  );
  PCompression_CompressAlgorithm = ^Compression_CompressAlgorithm;


  // Windows.Storage Records
  // Windows.Storage.Search.SortEntry
  Search_SortEntry = record
    PropertyName: HSTRING;
    AscendingOrder: Boolean;
  end;
  PSearch_SortEntry = ^Search_SortEntry;

  // Windows.Storage.AccessCache.AccessListEntry
  AccessCache_AccessListEntry = record
    Token: HSTRING;
    Metadata: HSTRING;
  end;
  PAccessCache_AccessListEntry = ^AccessCache_AccessListEntry;



  // Windows.Storage.Streams Enums
  // Windows.Storage.Streams.ByteOrder
  ByteOrder = (
    LittleEndian = 0,
    BigEndian = 1
  );
  PByteOrder = ^ByteOrder;

  // Windows.Storage.Streams.UnicodeEncoding
  UnicodeEncoding = (
    Utf8 = 0,
    Utf16LE = 1,
    Utf16BE = 2
  );
  PUnicodeEncoding = ^UnicodeEncoding;

  // Windows.Storage.Streams.InputStreamOptions
  InputStreamOptions = (
    None = 0,
    Partial = 1,
    ReadAhead = 2
  );
  PInputStreamOptions = ^InputStreamOptions;



  // Windows.ApplicationModel Enums
  // Windows.ApplicationModel.AppService.AppServiceClosedStatus
  AppService_AppServiceClosedStatus = (
    Completed = 0,
    Canceled = 1,
    ResourceLimitsExceeded = 2,
    Unknown = 3
  );
  PAppService_AppServiceClosedStatus = ^AppService_AppServiceClosedStatus;

  // Windows.ApplicationModel.AppService.AppServiceConnectionStatus
  AppService_AppServiceConnectionStatus = (
    Success = 0,
    AppNotInstalled = 1,
    AppUnavailable = 2,
    AppServiceUnavailable = 3,
    Unknown = 4
  );
  PAppService_AppServiceConnectionStatus = ^AppService_AppServiceConnectionStatus;

  // Windows.ApplicationModel.AppService.AppServiceResponseStatus
  AppService_AppServiceResponseStatus = (
    Success = 0,
    Failure = 1,
    ResourceLimitsExceeded = 2,
    Unknown = 3
  );
  PAppService_AppServiceResponseStatus = ^AppService_AppServiceResponseStatus;

  // Windows.ApplicationModel.Appointments.AppointmentStoreAccessType
  Appointments_AppointmentStoreAccessType = (
    AppCalendarsReadWrite = 0,
    AllCalendarsReadOnly = 1,
    AllCalendarsReadWrite = 2
  );
  PAppointments_AppointmentStoreAccessType = ^Appointments_AppointmentStoreAccessType;

  // Windows.ApplicationModel.Appointments.AppointmentSensitivity
  Appointments_AppointmentSensitivity = (
    Public = 0,
    Private = 1
  );
  PAppointments_AppointmentSensitivity = ^Appointments_AppointmentSensitivity;

  // Windows.ApplicationModel.Appointments.AppointmentBusyStatus
  Appointments_AppointmentBusyStatus = (
    Busy = 0,
    Tentative = 1,
    Free = 2,
    OutOfOffice = 3,
    WorkingElsewhere = 4
  );
  PAppointments_AppointmentBusyStatus = ^Appointments_AppointmentBusyStatus;

  // Windows.ApplicationModel.Appointments.AppointmentParticipantResponse
  Appointments_AppointmentParticipantResponse = (
    None = 0,
    Tentative = 1,
    Accepted = 2,
    Declined = 3,
    Unknown = 4
  );
  PAppointments_AppointmentParticipantResponse = ^Appointments_AppointmentParticipantResponse;

  // Windows.ApplicationModel.Appointments.AppointmentParticipantRole
  Appointments_AppointmentParticipantRole = (
    RequiredAttendee = 0,
    OptionalAttendee = 1,
    Resource = 2
  );
  PAppointments_AppointmentParticipantRole = ^Appointments_AppointmentParticipantRole;

  // Windows.ApplicationModel.Appointments.AppointmentRecurrenceUnit
  Appointments_AppointmentRecurrenceUnit = (
    Daily = 0,
    Weekly = 1,
    Monthly = 2,
    MonthlyOnDay = 3,
    Yearly = 4,
    YearlyOnDay = 5
  );
  PAppointments_AppointmentRecurrenceUnit = ^Appointments_AppointmentRecurrenceUnit;

  // Windows.ApplicationModel.Appointments.AppointmentDaysOfWeek
  Appointments_AppointmentDaysOfWeek = (
    None = 0,
    Sunday = 1,
    Monday = 2,
    Tuesday = 4,
    Wednesday = 8,
    Thursday = 16,
    Friday = 32,
    Saturday = 64
  );
  PAppointments_AppointmentDaysOfWeek = ^Appointments_AppointmentDaysOfWeek;

  // Windows.ApplicationModel.Appointments.AppointmentWeekOfMonth
  Appointments_AppointmentWeekOfMonth = (
    First = 0,
    Second = 1,
    Third = 2,
    Fourth = 3,
    Last = 4
  );
  PAppointments_AppointmentWeekOfMonth = ^Appointments_AppointmentWeekOfMonth;

  // Windows.ApplicationModel.Appointments.AppointmentCalendarSyncStatus
  Appointments_AppointmentCalendarSyncStatus = (
    Idle = 0,
    Syncing = 1,
    UpToDate = 2,
    AuthenticationError = 3,
    PolicyError = 4,
    UnknownError = 5
  );
  PAppointments_AppointmentCalendarSyncStatus = ^Appointments_AppointmentCalendarSyncStatus;

  // Windows.ApplicationModel.Appointments.RecurrenceType
  Appointments_RecurrenceType = (
    Master = 0,
    Instance = 1,
    ExceptionInstance = 2
  );
  PAppointments_RecurrenceType = ^Appointments_RecurrenceType;

  // Windows.ApplicationModel.Appointments.AppointmentDetailsKind
  Appointments_AppointmentDetailsKind = (
    PlainText = 0,
    Html = 1
  );
  PAppointments_AppointmentDetailsKind = ^Appointments_AppointmentDetailsKind;

  // Windows.ApplicationModel.Appointments.FindAppointmentCalendarsOptions
  Appointments_FindAppointmentCalendarsOptions = (
    None = 0,
    IncludeHidden = 1
  );
  PAppointments_FindAppointmentCalendarsOptions = ^Appointments_FindAppointmentCalendarsOptions;

  // Windows.ApplicationModel.Appointments.AppointmentSummaryCardView
  Appointments_AppointmentSummaryCardView = (
    System = 0,
    App = 1
  );
  PAppointments_AppointmentSummaryCardView = ^Appointments_AppointmentSummaryCardView;

  // Windows.ApplicationModel.Appointments.AppointmentCalendarOtherAppReadAccess
  Appointments_AppointmentCalendarOtherAppReadAccess = (
    SystemOnly = 0,
    Limited = 1,
    Full = 2
  );
  PAppointments_AppointmentCalendarOtherAppReadAccess = ^Appointments_AppointmentCalendarOtherAppReadAccess;

  // Windows.ApplicationModel.Appointments.AppointmentCalendarOtherAppWriteAccess
  Appointments_AppointmentCalendarOtherAppWriteAccess = (
    None = 0,
    SystemOnly = 1
  );
  PAppointments_AppointmentCalendarOtherAppWriteAccess = ^Appointments_AppointmentCalendarOtherAppWriteAccess;

  // Windows.ApplicationModel.Appointments.AppointmentConflictType
  Appointments_AppointmentConflictType = (
    None = 0,
    Adjacent = 1,
    Overlap = 2
  );
  PAppointments_AppointmentConflictType = ^Appointments_AppointmentConflictType;

  // Windows.ApplicationModel.Appointments.AppointmentStoreChangeType
  Appointments_AppointmentStoreChangeType = (
    AppointmentCreated = 0,
    AppointmentModified = 1,
    AppointmentDeleted = 2,
    ChangeTrackingLost = 3,
    CalendarCreated = 4,
    CalendarModified = 5,
    CalendarDeleted = 6
  );
  PAppointments_AppointmentStoreChangeType = ^Appointments_AppointmentStoreChangeType;

  // Windows.ApplicationModel.Chat.ChatMessageStatus
  Chat_ChatMessageStatus = (
    Draft = 0,
    Sending = 1,
    Sent = 2,
    SendRetryNeeded = 3,
    SendFailed = 4,
    Received = 5,
    ReceiveDownloadNeeded = 6,
    ReceiveDownloadFailed = 7,
    ReceiveDownloading = 8,
    Deleted = 9,
    Declined = 10,
    Cancelled = 11,
    Recalled = 12,
    ReceiveRetryNeeded = 13
  );
  PChat_ChatMessageStatus = ^Chat_ChatMessageStatus;

  // Windows.ApplicationModel.Chat.ChatMessageKind
  Chat_ChatMessageKind = (
    Standard = 0,
    FileTransferRequest = 1,
    TransportCustom = 2,
    JoinedConversation = 3,
    LeftConversation = 4,
    OtherParticipantJoinedConversation = 5,
    OtherParticipantLeftConversation = 6
  );
  PChat_ChatMessageKind = ^Chat_ChatMessageKind;

  // Windows.ApplicationModel.Chat.ChatMessageOperatorKind
  Chat_ChatMessageOperatorKind = (
    Unspecified = 0,
    Sms = 1,
    Mms = 2,
    Rcs = 3
  );
  PChat_ChatMessageOperatorKind = ^Chat_ChatMessageOperatorKind;

  // Windows.ApplicationModel.Chat.ChatMessageChangeType
  Chat_ChatMessageChangeType = (
    MessageCreated = 0,
    MessageModified = 1,
    MessageDeleted = 2,
    ChangeTrackingLost = 3
  );
  PChat_ChatMessageChangeType = ^Chat_ChatMessageChangeType;

  // Windows.ApplicationModel.Chat.ChatMessageValidationStatus
  Chat_ChatMessageValidationStatus = (
    Valid = 0,
    NoRecipients = 1,
    InvalidData = 2,
    MessageTooLarge = 3,
    TooManyRecipients = 4,
    TransportInactive = 5,
    TransportNotFound = 6,
    TooManyAttachments = 7,
    InvalidRecipients = 8,
    InvalidBody = 9,
    InvalidOther = 10
  );
  PChat_ChatMessageValidationStatus = ^Chat_ChatMessageValidationStatus;

  // Windows.ApplicationModel.Chat.ChatConversationThreadingKind
  Chat_ChatConversationThreadingKind = (
    Participants = 0,
    ContactId = 1,
    ConversationId = 2,
    Custom = 3
  );
  PChat_ChatConversationThreadingKind = ^Chat_ChatConversationThreadingKind;

  // Windows.ApplicationModel.Chat.ChatStoreChangedEventKind
  Chat_ChatStoreChangedEventKind = (
    NotificationsMissed = 0,
    StoreModified = 1,
    MessageCreated = 2,
    MessageModified = 3,
    MessageDeleted = 4,
    ConversationModified = 5,
    ConversationDeleted = 6,
    ConversationTransportDeleted = 7
  );
  PChat_ChatStoreChangedEventKind = ^Chat_ChatStoreChangedEventKind;

  // Windows.ApplicationModel.Chat.ChatTransportErrorCodeCategory
  Chat_ChatTransportErrorCodeCategory = (
    None = 0,
    Http = 1,
    Network = 2,
    MmsServer = 3
  );
  PChat_ChatTransportErrorCodeCategory = ^Chat_ChatTransportErrorCodeCategory;

  // Windows.ApplicationModel.Chat.ChatTransportInterpretedErrorCode
  Chat_ChatTransportInterpretedErrorCode = (
    None = 0,
    Unknown = 1,
    InvalidRecipientAddress = 2,
    NetworkConnectivity = 3,
    ServiceDenied = 4,
    Timeout = 5
  );
  PChat_ChatTransportInterpretedErrorCode = ^Chat_ChatTransportInterpretedErrorCode;

  // Windows.ApplicationModel.Chat.ChatMessageTransportKind
  Chat_ChatMessageTransportKind = (
    Text = 0,
    Untriaged = 1,
    Blocked = 2,
    Custom = 3
  );
  PChat_ChatMessageTransportKind = ^Chat_ChatMessageTransportKind;

  // Windows.ApplicationModel.Chat.RcsServiceKind
  Chat_RcsServiceKind = (
    Chat = 0,
    GroupChat = 1,
    FileTransfer = 2,
    Capability = 3
  );
  PChat_RcsServiceKind = ^Chat_RcsServiceKind;

  // Windows.ApplicationModel.Chat.ChatItemKind
  Chat_ChatItemKind = (
    Message = 0,
    Conversation = 1
  );
  PChat_ChatItemKind = ^Chat_ChatItemKind;

  // Windows.ApplicationModel.Email.EmailStoreAccessType
  Email_EmailStoreAccessType = (
    AppMailboxesReadWrite = 0,
    AllMailboxesLimitedReadWrite = 1
  );
  PEmail_EmailStoreAccessType = ^Email_EmailStoreAccessType;

  // Windows.ApplicationModel.Email.EmailMessageBodyKind
  Email_EmailMessageBodyKind = (
    Html = 0,
    PlainText = 1
  );
  PEmail_EmailMessageBodyKind = ^Email_EmailMessageBodyKind;

  // Windows.ApplicationModel.Email.EmailAttachmentDownloadState
  Email_EmailAttachmentDownloadState = (
    NotDownloaded = 0,
    Downloading = 1,
    Downloaded = 2,
    Failed = 3
  );
  PEmail_EmailAttachmentDownloadState = ^Email_EmailAttachmentDownloadState;

  // Windows.ApplicationModel.Email.EmailMessageDownloadState
  Email_EmailMessageDownloadState = (
    PartiallyDownloaded = 0,
    Downloading = 1,
    Downloaded = 2,
    Failed = 3
  );
  PEmail_EmailMessageDownloadState = ^Email_EmailMessageDownloadState;

  // Windows.ApplicationModel.Email.EmailSpecialFolderKind
  Email_EmailSpecialFolderKind = (
    None = 0,
    Root = 1,
    Inbox = 2,
    Outbox = 3,
    Drafts = 4,
    DeletedItems = 5,
    Sent = 6
  );
  PEmail_EmailSpecialFolderKind = ^Email_EmailSpecialFolderKind;

  // Windows.ApplicationModel.Email.EmailQueryKind
  Email_EmailQueryKind = (
    All = 0,
    Important = 1,
    Flagged = 2,
    Unread = 3,
    Read = 4,
    Unseen = 5
  );
  PEmail_EmailQueryKind = ^Email_EmailQueryKind;

  // Windows.ApplicationModel.Email.EmailMailboxChangeType
  Email_EmailMailboxChangeType = (
    MessageCreated = 0,
    MessageModified = 1,
    MessageDeleted = 2,
    FolderCreated = 3,
    FolderModified = 4,
    FolderDeleted = 5,
    ChangeTrackingLost = 6
  );
  PEmail_EmailMailboxChangeType = ^Email_EmailMailboxChangeType;

  // Windows.ApplicationModel.Email.EmailQuerySortDirection
  Email_EmailQuerySortDirection = (
    Descending = 0,
    Ascending = 1
  );
  PEmail_EmailQuerySortDirection = ^Email_EmailQuerySortDirection;

  // Windows.ApplicationModel.Email.EmailQuerySortProperty
  Email_EmailQuerySortProperty = (
    Date = 0
  );
  PEmail_EmailQuerySortProperty = ^Email_EmailQuerySortProperty;

  // Windows.ApplicationModel.Email.EmailQuerySearchFields
  Email_EmailQuerySearchFields = (
    None = 0,
    Subject = 1,
    Sender = 2,
    Preview = 4,
    Recipients = 8,
    All = -1
  );
  PEmail_EmailQuerySearchFields = ^Email_EmailQuerySearchFields;

  // Windows.ApplicationModel.Email.EmailBatchStatus
  Email_EmailBatchStatus = (
    Success = 0,
    ServerSearchSyncManagerError = 1,
    ServerSearchUnknownError = 2
  );
  PEmail_EmailBatchStatus = ^Email_EmailBatchStatus;

  // Windows.ApplicationModel.Email.EmailMessageResponseKind
  Email_EmailMessageResponseKind = (
    None = 0,
    Reply = 1,
    ReplyAll = 2,
    Forward = 3
  );
  PEmail_EmailMessageResponseKind = ^Email_EmailMessageResponseKind;

  // Windows.ApplicationModel.Email.EmailMeetingResponseType
  Email_EmailMeetingResponseType = (
    Accept = 0,
    Decline = 1,
    Tentative = 2
  );
  PEmail_EmailMeetingResponseType = ^Email_EmailMeetingResponseType;

  // Windows.ApplicationModel.Email.EmailMailboxActionKind
  Email_EmailMailboxActionKind = (
    MarkMessageAsSeen = 0,
    MarkMessageRead = 1,
    ChangeMessageFlagState = 2,
    MoveMessage = 3,
    SaveDraft = 4,
    SendMessage = 5,
    CreateResponseReplyMessage = 6,
    CreateResponseReplyAllMessage = 7,
    CreateResponseForwardMessage = 8,
    MoveFolder = 9,
    MarkFolderForSyncEnabled = 10
  );
  PEmail_EmailMailboxActionKind = ^Email_EmailMailboxActionKind;

  // Windows.ApplicationModel.Email.EmailImportance
  Email_EmailImportance = (
    Normal = 0,
    High = 1,
    Low = 2
  );
  PEmail_EmailImportance = ^Email_EmailImportance;

  // Windows.ApplicationModel.Email.EmailFlagState
  Email_EmailFlagState = (
    Unflagged = 0,
    Flagged = 1,
    Completed = 2,
    Cleared = 3
  );
  PEmail_EmailFlagState = ^Email_EmailFlagState;

  // Windows.ApplicationModel.Email.EmailMailboxSyncStatus
  Email_EmailMailboxSyncStatus = (
    Idle = 0,
    Syncing = 1,
    UpToDate = 2,
    AuthenticationError = 3,
    PolicyError = 4,
    UnknownError = 5
  );
  PEmail_EmailMailboxSyncStatus = ^Email_EmailMailboxSyncStatus;

  // Windows.ApplicationModel.Email.EmailMailboxOtherAppReadAccess
  Email_EmailMailboxOtherAppReadAccess = (
    SystemOnly = 0,
    Full = 1
  );
  PEmail_EmailMailboxOtherAppReadAccess = ^Email_EmailMailboxOtherAppReadAccess;

  // Windows.ApplicationModel.Email.EmailMailboxOtherAppWriteAccess
  Email_EmailMailboxOtherAppWriteAccess = (
    None = 0,
    Limited = 1
  );
  PEmail_EmailMailboxOtherAppWriteAccess = ^Email_EmailMailboxOtherAppWriteAccess;

  // Windows.ApplicationModel.Email.EmailMailboxAllowedSmimeEncryptionAlgorithmNegotiation
  Email_EmailMailboxAllowedSmimeEncryptionAlgorithmNegotiation = (
    None = 0,
    StrongAlgorithm = 1,
    AnyAlgorithm = 2
  );
  PEmail_EmailMailboxAllowedSmimeEncryptionAlgorithmNegotiation = ^Email_EmailMailboxAllowedSmimeEncryptionAlgorithmNegotiation;

  // Windows.ApplicationModel.Email.EmailMailboxSmimeEncryptionAlgorithm
  Email_EmailMailboxSmimeEncryptionAlgorithm = (
    Any = 0,
    TripleDes = 1,
    Des = 2,
    RC2128Bit = 3,
    RC264Bit = 4,
    RC240Bit = 5
  );
  PEmail_EmailMailboxSmimeEncryptionAlgorithm = ^Email_EmailMailboxSmimeEncryptionAlgorithm;

  // Windows.ApplicationModel.Email.EmailMailboxSmimeSigningAlgorithm
  Email_EmailMailboxSmimeSigningAlgorithm = (
    Any = 0,
    Sha1 = 1,
    MD5 = 2
  );
  PEmail_EmailMailboxSmimeSigningAlgorithm = ^Email_EmailMailboxSmimeSigningAlgorithm;

  // Windows.ApplicationModel.Email.EmailMailboxAutoReplyMessageResponseKind
  Email_EmailMailboxAutoReplyMessageResponseKind = (
    Html = 0,
    PlainText = 1
  );
  PEmail_EmailMailboxAutoReplyMessageResponseKind = ^Email_EmailMailboxAutoReplyMessageResponseKind;

  // Windows.ApplicationModel.Email.EmailQuerySearchScope
  Email_EmailQuerySearchScope = (
    Local = 0,
    Server = 1
  );
  PEmail_EmailQuerySearchScope = ^Email_EmailQuerySearchScope;

  // Windows.ApplicationModel.ExtendedExecution.ExtendedExecutionReason
  ExtendedExecution_ExtendedExecutionReason = (
    Unspecified = 0,
    LocationTracking = 1,
    SavingData = 2
  );
  PExtendedExecution_ExtendedExecutionReason = ^ExtendedExecution_ExtendedExecutionReason;

  // Windows.ApplicationModel.ExtendedExecution.ExtendedExecutionResult
  ExtendedExecution_ExtendedExecutionResult = (
    Allowed = 0,
    Denied = 1
  );
  PExtendedExecution_ExtendedExecutionResult = ^ExtendedExecution_ExtendedExecutionResult;

  // Windows.ApplicationModel.ExtendedExecution.ExtendedExecutionRevokedReason
  ExtendedExecution_ExtendedExecutionRevokedReason = (
    Resumed = 0,
    SystemPolicy = 1
  );
  PExtendedExecution_ExtendedExecutionRevokedReason = ^ExtendedExecution_ExtendedExecutionRevokedReason;

  // Windows.ApplicationModel.ExtendedExecution.Foreground.ExtendedExecutionForegroundResult
  ExtendedExecution_Foreground_ExtendedExecutionForegroundResult = (
    Allowed = 0,
    Denied = 1
  );
  PExtendedExecution_Foreground_ExtendedExecutionForegroundResult = ^ExtendedExecution_Foreground_ExtendedExecutionForegroundResult;

  // Windows.ApplicationModel.ExtendedExecution.Foreground.ExtendedExecutionForegroundRevokedReason
  ExtendedExecution_Foreground_ExtendedExecutionForegroundRevokedReason = (
    Resumed = 0,
    SystemPolicy = 1
  );
  PExtendedExecution_Foreground_ExtendedExecutionForegroundRevokedReason = ^ExtendedExecution_Foreground_ExtendedExecutionForegroundRevokedReason;

  // Windows.ApplicationModel.ExtendedExecution.Foreground.ExtendedExecutionForegroundReason
  ExtendedExecution_Foreground_ExtendedExecutionForegroundReason = (
    Unspecified = 0,
    SavingData = 1,
    BackgroundAudio = 2,
    Unconstrained = 3
  );
  PExtendedExecution_Foreground_ExtendedExecutionForegroundReason = ^ExtendedExecution_Foreground_ExtendedExecutionForegroundReason;

  // Windows.ApplicationModel.Calls.PhoneCallHistoryEntryOtherAppReadAccess
  Calls_PhoneCallHistoryEntryOtherAppReadAccess = (
    Full = 0,
    SystemOnly = 1
  );
  PCalls_PhoneCallHistoryEntryOtherAppReadAccess = ^Calls_PhoneCallHistoryEntryOtherAppReadAccess;

  // Windows.ApplicationModel.Calls.PhoneCallHistoryEntryMedia
  Calls_PhoneCallHistoryEntryMedia = (
    Audio = 0,
    Video = 1
  );
  PCalls_PhoneCallHistoryEntryMedia = ^Calls_PhoneCallHistoryEntryMedia;

  // Windows.ApplicationModel.Calls.PhoneCallHistoryEntryRawAddressKind
  Calls_PhoneCallHistoryEntryRawAddressKind = (
    PhoneNumber = 0,
    Custom = 1
  );
  PCalls_PhoneCallHistoryEntryRawAddressKind = ^Calls_PhoneCallHistoryEntryRawAddressKind;

  // Windows.ApplicationModel.Calls.PhoneCallHistoryEntryQueryDesiredMedia
  Calls_PhoneCallHistoryEntryQueryDesiredMedia = (
    None = 0,
    Audio = 1,
    Video = 2,
    All = -1
  );
  PCalls_PhoneCallHistoryEntryQueryDesiredMedia = ^Calls_PhoneCallHistoryEntryQueryDesiredMedia;

  // Windows.ApplicationModel.Calls.PhoneCallHistoryStoreAccessType
  Calls_PhoneCallHistoryStoreAccessType = (
    AppEntriesReadWrite = 0,
    AllEntriesLimitedReadWrite = 1,
    AllEntriesReadWrite = 2
  );
  PCalls_PhoneCallHistoryStoreAccessType = ^Calls_PhoneCallHistoryStoreAccessType;

  // Windows.ApplicationModel.Calls.PhoneCallHistorySourceIdKind
  Calls_PhoneCallHistorySourceIdKind = (
    CellularPhoneLineId = 0,
    PackageFamilyName = 1
  );
  PCalls_PhoneCallHistorySourceIdKind = ^Calls_PhoneCallHistorySourceIdKind;

  // Windows.ApplicationModel.UserDataAccounts.UserDataAccountOtherAppReadAccess
  UserDataAccounts_UserDataAccountOtherAppReadAccess = (
    SystemOnly = 0,
    Full = 1
  );
  PUserDataAccounts_UserDataAccountOtherAppReadAccess = ^UserDataAccounts_UserDataAccountOtherAppReadAccess;

  // Windows.ApplicationModel.UserDataAccounts.UserDataAccountStoreAccessType
  UserDataAccounts_UserDataAccountStoreAccessType = (
    AllAccountsReadOnly = 0,
    AppAccountsReadWrite = 1
  );
  PUserDataAccounts_UserDataAccountStoreAccessType = ^UserDataAccounts_UserDataAccountStoreAccessType;

  // Windows.ApplicationModel.UserDataAccounts.UserDataAccountContentKinds
  UserDataAccounts_UserDataAccountContentKinds = (
    Email = 1,
    Contact = 2,
    Appointment = 4
  );
  PUserDataAccounts_UserDataAccountContentKinds = ^UserDataAccounts_UserDataAccountContentKinds;

  // Windows.ApplicationModel.UserDataAccounts.SystemAccess.DeviceAccountServerType
  UserDataAccounts_SystemAccess_DeviceAccountServerType = (
    Exchange = 0,
    Pop = 1,
    Imap = 2
  );
  PUserDataAccounts_SystemAccess_DeviceAccountServerType = ^UserDataAccounts_SystemAccess_DeviceAccountServerType;

  // Windows.ApplicationModel.Activation.ApplicationExecutionState
  Activation_ApplicationExecutionState = (
    NotRunning = 0,
    Running = 1,
    Suspended = 2,
    Terminated = 3,
    ClosedByUser = 4
  );
  PActivation_ApplicationExecutionState = ^Activation_ApplicationExecutionState;

  // Windows.ApplicationModel.Activation.ActivationKind
  Activation_ActivationKind = (
    Launch = 0,
    Search = 1,
    ShareTarget = 2,
    &File = 3,
    Protocol = 4,
    FileOpenPicker = 5,
    FileSavePicker = 6,
    CachedFileUpdater = 7,
    ContactPicker = 8,
    Device = 9,
    PrintTaskSettings = 10,
    CameraSettings = 11,
    RestrictedLaunch = 12,
    AppointmentsProvider = 13,
    Contact = 14,
    LockScreenCall = 15,
    VoiceCommand = 16,
    LockScreen = 17,
    PickerReturned = 1000,
    WalletAction = 1001,
    PickFileContinuation = 1002,
    PickSaveFileContinuation = 1003,
    PickFolderContinuation = 1004,
    WebAuthenticationBrokerContinuation = 1005,
    WebAccountProvider = 1006,
    ComponentUI = 1007,
    ProtocolForResults = 1009,
    ToastNotification = 1010,
    DialReceiver = 1012
  );
  PActivation_ActivationKind = ^Activation_ActivationKind;

  // Windows.ApplicationModel.Resources.Core.ResourceQualifierPersistence
  Resources_Core_ResourceQualifierPersistence = (
    None = 0,
    LocalMachine = 1
  );
  PResources_Core_ResourceQualifierPersistence = ^Resources_Core_ResourceQualifierPersistence;

  // Windows.ApplicationModel.Store.Preview.InstallControl.AppInstallState
  Store_Preview_InstallControl_AppInstallState = (
    Pending = 0,
    Starting = 1,
    AcquiringLicense = 2,
    Downloading = 3,
    RestoringData = 4,
    Installing = 5,
    Completed = 6,
    Canceled = 7,
    Paused = 8,
    Error = 9,
    PausedLowBattery = 10,
    PausedWiFiRecommended = 11,
    PausedWiFiRequired = 12,
    ReadyToDownload = 13
  );
  PStore_Preview_InstallControl_AppInstallState = ^Store_Preview_InstallControl_AppInstallState;

  // Windows.ApplicationModel.Store.Preview.InstallControl.AppInstallType
  Store_Preview_InstallControl_AppInstallType = (
    Install = 0,
    Update = 1,
    Repair = 2
  );
  PStore_Preview_InstallControl_AppInstallType = ^Store_Preview_InstallControl_AppInstallType;

  // Windows.ApplicationModel.Store.Preview.InstallControl.AutoUpdateSetting
  Store_Preview_InstallControl_AutoUpdateSetting = (
    Disabled = 0,
    Enabled = 1,
    DisabledByPolicy = 2,
    EnabledByPolicy = 3
  );
  PStore_Preview_InstallControl_AutoUpdateSetting = ^Store_Preview_InstallControl_AutoUpdateSetting;

  // Windows.ApplicationModel.Store.Preview.StorePreviewProductPurchaseStatus
  Store_Preview_StorePreviewProductPurchaseStatus = (
    Succeeded = 0,
    AlreadyPurchased = 1,
    NotFulfilled = 2,
    NotPurchased = 3
  );
  PStore_Preview_StorePreviewProductPurchaseStatus = ^Store_Preview_StorePreviewProductPurchaseStatus;

  // Windows.ApplicationModel.Store.Preview.StoreSystemFeature
  Store_Preview_StoreSystemFeature = (
    ArchitectureX86 = 0,
    ArchitectureX64 = 1,
    ArchitectureArm = 2,
    DirectX9 = 3,
    DirectX10 = 4,
    DirectX11 = 5,
    D3D12HardwareFL11 = 6,
    D3D12HardwareFL12 = 7,
    Memory300MB = 8,
    Memory750MB = 9,
    Memory1GB = 10,
    Memory2GB = 11,
    CameraFront = 12,
    CameraRear = 13,
    Gyroscope = 14,
    Hover = 15,
    Magnetometer = 16,
    Nfc = 17,
    Resolution720P = 18,
    ResolutionWvga = 19,
    ResolutionWvgaOr720P = 20,
    ResolutionWxga = 21,
    ResolutionWvgaOrWxga = 22,
    ResolutionWxgaOr720P = 23
  );
  PStore_Preview_StoreSystemFeature = ^Store_Preview_StoreSystemFeature;

  // Windows.ApplicationModel.Store.ProductPurchaseStatus
  Store_ProductPurchaseStatus = (
    Succeeded = 0,
    AlreadyPurchased = 1,
    NotFulfilled = 2,
    NotPurchased = 3
  );
  PStore_ProductPurchaseStatus = ^Store_ProductPurchaseStatus;

  // Windows.ApplicationModel.Store.ProductType
  Store_ProductType = (
    Unknown = 0,
    Durable = 1,
    Consumable = 2
  );
  PStore_ProductType = ^Store_ProductType;

  // Windows.ApplicationModel.Store.FulfillmentResult
  Store_FulfillmentResult = (
    Succeeded = 0,
    NothingToFulfill = 1,
    PurchasePending = 2,
    PurchaseReverted = 3,
    ServerError = 4
  );
  PStore_FulfillmentResult = ^Store_FulfillmentResult;

  // Windows.ApplicationModel.VoiceCommands.VoiceCommandContentTileType
  VoiceCommands_VoiceCommandContentTileType = (
    TitleOnly = 0,
    TitleWithText = 1,
    TitleWith68x68Icon = 2,
    TitleWith68x68IconAndText = 3,
    TitleWith68x92Icon = 4,
    TitleWith68x92IconAndText = 5,
    TitleWith280x140Icon = 6,
    TitleWith280x140IconAndText = 7
  );
  PVoiceCommands_VoiceCommandContentTileType = ^VoiceCommands_VoiceCommandContentTileType;

  // Windows.ApplicationModel.VoiceCommands.VoiceCommandCompletionReason
  VoiceCommands_VoiceCommandCompletionReason = (
    Unknown = 0,
    CommunicationFailed = 1,
    ResourceLimitsExceeded = 2,
    Canceled = 3,
    TimeoutExceeded = 4,
    AppLaunched = 5,
    Completed = 6
  );
  PVoiceCommands_VoiceCommandCompletionReason = ^VoiceCommands_VoiceCommandCompletionReason;

  // Windows.ApplicationModel.Wallet.WalletBarcodeSymbology
  Wallet_WalletBarcodeSymbology = (
    Invalid = 0,
    Upca = 1,
    Upce = 2,
    Ean13 = 3,
    Ean8 = 4,
    Itf = 5,
    Code39 = 6,
    Code128 = 7,
    Qr = 8,
    Pdf417 = 9,
    Aztec = 10,
    Custom = 100000
  );
  PWallet_WalletBarcodeSymbology = ^Wallet_WalletBarcodeSymbology;

  // Windows.ApplicationModel.Wallet.WalletDetailViewPosition
  Wallet_WalletDetailViewPosition = (
    Hidden = 0,
    HeaderField1 = 1,
    HeaderField2 = 2,
    PrimaryField1 = 3,
    PrimaryField2 = 4,
    SecondaryField1 = 5,
    SecondaryField2 = 6,
    SecondaryField3 = 7,
    SecondaryField4 = 8,
    SecondaryField5 = 9,
    CenterField1 = 10,
    FooterField1 = 11,
    FooterField2 = 12,
    FooterField3 = 13,
    FooterField4 = 14
  );
  PWallet_WalletDetailViewPosition = ^Wallet_WalletDetailViewPosition;

  // Windows.ApplicationModel.Wallet.WalletSummaryViewPosition
  Wallet_WalletSummaryViewPosition = (
    Hidden = 0,
    Field1 = 1,
    Field2 = 2
  );
  PWallet_WalletSummaryViewPosition = ^Wallet_WalletSummaryViewPosition;

  // Windows.ApplicationModel.Wallet.WalletItemKind
  Wallet_WalletItemKind = (
    Invalid = 0,
    Deal = 1,
    General = 2,
    PaymentInstrument = 3,
    Ticket = 4,
    BoardingPass = 5,
    MembershipCard = 6
  );
  PWallet_WalletItemKind = ^Wallet_WalletItemKind;

  // Windows.ApplicationModel.Wallet.System.WalletItemAppAssociation
  Wallet_System_WalletItemAppAssociation = (
    None = 0,
    AppInstalled = 1,
    AppNotInstalled = 2
  );
  PWallet_System_WalletItemAppAssociation = ^Wallet_System_WalletItemAppAssociation;

  // Windows.ApplicationModel.Resources.Management.IndexedResourceType
  Resources_Management_IndexedResourceType = (
    &String = 0,
    Path = 1,
    EmbeddedData = 2
  );
  PResources_Management_IndexedResourceType = ^Resources_Management_IndexedResourceType;

  // Windows.ApplicationModel.Search.Core.SearchSuggestionKind
  Search_Core_SearchSuggestionKind = (
    Query = 0,
    Result = 1,
    Separator = 2
  );
  PSearch_Core_SearchSuggestionKind = ^Search_Core_SearchSuggestionKind;

  // Windows.ApplicationModel.Wallet.WalletActionKind
  Wallet_WalletActionKind = (
    OpenItem = 0,
    Transaction = 1,
    MoreTransactions = 2,
    Message = 3,
    Verb = 4
  );
  PWallet_WalletActionKind = ^Wallet_WalletActionKind;


  // Windows.ApplicationModel Records
  // Windows.ApplicationModel.Resources.Core.ResourceLayoutInfo
  Resources_Core_ResourceLayoutInfo = record
    MajorVersion: Cardinal;
    MinorVersion: Cardinal;
    ResourceSubtreeCount: Cardinal;
    NamedResourceCount: Cardinal;
    Checksum: Integer;
  end;
  PResources_Core_ResourceLayoutInfo = ^Resources_Core_ResourceLayoutInfo;

  // Windows.ApplicationModel.PackageVersion
  PackageVersion = record
    Major: Word;
    Minor: Word;
    Build: Word;
    Revision: Word;
  end;
  PPackageVersion = ^PackageVersion;

  // Windows.ApplicationModel.Activation.ActivationCameraSettingsContract
  Activation_ActivationCameraSettingsContract = record
  end;
  PActivation_ActivationCameraSettingsContract = ^Activation_ActivationCameraSettingsContract;

  // Windows.ApplicationModel.Resources.Management.ResourceIndexerContract
  Resources_Management_ResourceIndexerContract = record
  end;
  PResources_Management_ResourceIndexerContract = ^Resources_Management_ResourceIndexerContract;

  // Windows.ApplicationModel.Activation.ActivatedEventsContract
  Activation_ActivatedEventsContract = record
  end;
  PActivation_ActivatedEventsContract = ^Activation_ActivatedEventsContract;

  // Windows.ApplicationModel.Activation.ContactActivatedEventsContract
  Activation_ContactActivatedEventsContract = record
  end;
  PActivation_ContactActivatedEventsContract = ^Activation_ContactActivatedEventsContract;

  // Windows.ApplicationModel.Activation.WebUISearchActivatedEventsContract
  Activation_WebUISearchActivatedEventsContract = record
  end;
  PActivation_WebUISearchActivatedEventsContract = ^Activation_WebUISearchActivatedEventsContract;

  // Windows.ApplicationModel.Calls.LockScreenCallContract
  Calls_LockScreenCallContract = record
  end;
  PCalls_LockScreenCallContract = ^Calls_LockScreenCallContract;

  // Windows.ApplicationModel.Search.Core.SearchCoreContract
  Search_Core_SearchCoreContract = record
  end;
  PSearch_Core_SearchCoreContract = ^Search_Core_SearchCoreContract;

  // Windows.ApplicationModel.Search.SearchContract
  Search_SearchContract = record
  end;
  PSearch_SearchContract = ^Search_SearchContract;

  // Windows.ApplicationModel.Wallet.WalletContract
  Wallet_WalletContract = record
  end;
  PWallet_WalletContract = ^Wallet_WalletContract;



  // Windows.ApplicationModel.Background Enums
  // Windows.ApplicationModel.Background.ApplicationTriggerResult
  ApplicationTriggerResult = (
    Allowed = 0,
    CurrentlyRunning = 1,
    DisabledByPolicy = 2,
    UnknownError = 3
  );
  PApplicationTriggerResult = ^ApplicationTriggerResult;

  // Windows.ApplicationModel.Background.BackgroundAccessStatus
  BackgroundAccessStatus = (
    Unspecified = 0,
    AllowedWithAlwaysOnRealTimeConnectivity = 1,
    AllowedMayUseActiveRealTimeConnectivity = 2,
    Denied = 3
  );
  PBackgroundAccessStatus = ^BackgroundAccessStatus;

  // Windows.ApplicationModel.Background.MediaProcessingTriggerResult
  MediaProcessingTriggerResult = (
    Allowed = 0,
    CurrentlyRunning = 1,
    DisabledByPolicy = 2,
    UnknownError = 3
  );
  PMediaProcessingTriggerResult = ^MediaProcessingTriggerResult;

  // Windows.ApplicationModel.Background.BackgroundWorkCostValue
  BackgroundWorkCostValue = (
    Low = 0,
    Medium = 1,
    High = 2
  );
  PBackgroundWorkCostValue = ^BackgroundWorkCostValue;

  // Windows.ApplicationModel.Background.BackgroundTaskCancellationReason
  BackgroundTaskCancellationReason = (
    Abort = 0,
    Terminating = 1,
    LoggingOff = 2,
    ServicingUpdate = 3,
    IdleTask = 4,
    Uninstall = 5,
    ConditionLoss = 6,
    SystemPolicy = 7,
    QuietHoursEntered = 8,
    ExecutionTimeExceeded = 9,
    ResourceRevocation = 10,
    EnergySaver = 11
  );
  PBackgroundTaskCancellationReason = ^BackgroundTaskCancellationReason;

  // Windows.ApplicationModel.Background.BackgroundTaskThrottleCounter
  BackgroundTaskThrottleCounter = (
    All = 0,
    Cpu = 1,
    Network = 2
  );
  PBackgroundTaskThrottleCounter = ^BackgroundTaskThrottleCounter;

  // Windows.ApplicationModel.Background.SystemTriggerType
  SystemTriggerType = (
    Invalid = 0,
    SmsReceived = 1,
    UserPresent = 2,
    UserAway = 3,
    NetworkStateChange = 4,
    ControlChannelReset = 5,
    InternetAvailable = 6,
    SessionConnected = 7,
    ServicingComplete = 8,
    LockScreenApplicationAdded = 9,
    LockScreenApplicationRemoved = 10,
    TimeZoneChange = 11,
    OnlineIdConnectedStateChange = 12,
    BackgroundWorkCostChange = 13,
    PowerStateChange = 14
  );
  PSystemTriggerType = ^SystemTriggerType;

  // Windows.ApplicationModel.Background.SystemConditionType
  SystemConditionType = (
    Invalid = 0,
    UserPresent = 1,
    UserNotPresent = 2,
    InternetAvailable = 3,
    InternetNotAvailable = 4,
    SessionConnected = 5,
    SessionDisconnected = 6,
    FreeNetworkAvailable = 7,
    BackgroundWorkCostNotHigh = 8
  );
  PSystemConditionType = ^SystemConditionType;

  // Windows.ApplicationModel.Background.DeviceTriggerResult
  DeviceTriggerResult = (
    Allowed = 0,
    DeniedByUser = 1,
    DeniedBySystem = 2,
    LowBattery = 3
  );
  PDeviceTriggerResult = ^DeviceTriggerResult;

  // Windows.ApplicationModel.Background.LocationTriggerType
  LocationTriggerType = (
    Geofence = 0
  );
  PLocationTriggerType = ^LocationTriggerType;

  // Windows.ApplicationModel.Background.AlarmAccessStatus
  AlarmAccessStatus = (
    Unspecified = 0,
    AllowedWithWakeupCapability = 1,
    AllowedWithoutWakeupCapability = 2,
    Denied = 3
  );
  PAlarmAccessStatus = ^AlarmAccessStatus;


  // Windows.ApplicationModel.Background Records
  // Windows.ApplicationModel.Background.BackgroundAlarmApplicationContract
  BackgroundAlarmApplicationContract = record
  end;
  PBackgroundAlarmApplicationContract = ^BackgroundAlarmApplicationContract;



  // Windows.ApplicationModel.Contacts Enums
  // Windows.ApplicationModel.Contacts.ContactFieldType
  ContactFieldType = (
    Email = 0,
    PhoneNumber = 1,
    Location = 2,
    InstantMessage = 3,
    Custom = 4,
    ConnectedServiceAccount = 5,
    ImportantDate = 6,
    Address = 7,
    SignificantOther = 8,
    Notes = 9,
    Website = 10,
    JobInfo = 11
  );
  PContactFieldType = ^ContactFieldType;

  // Windows.ApplicationModel.Contacts.ContactSelectionMode
  ContactSelectionMode = (
    Contacts = 0,
    Fields = 1
  );
  PContactSelectionMode = ^ContactSelectionMode;

  // Windows.ApplicationModel.Contacts.ContactEmailKind
  ContactEmailKind = (
    Personal = 0,
    Work = 1,
    Other = 2
  );
  PContactEmailKind = ^ContactEmailKind;

  // Windows.ApplicationModel.Contacts.ContactPhoneKind
  ContactPhoneKind = (
    Home = 0,
    Mobile = 1,
    Work = 2,
    Other = 3,
    Pager = 4,
    BusinessFax = 5,
    HomeFax = 6,
    Company = 7,
    Assistant = 8,
    Radio = 9
  );
  PContactPhoneKind = ^ContactPhoneKind;

  // Windows.ApplicationModel.Contacts.ContactAddressKind
  ContactAddressKind = (
    Home = 0,
    Work = 1,
    Other = 2
  );
  PContactAddressKind = ^ContactAddressKind;

  // Windows.ApplicationModel.Contacts.ContactDateKind
  ContactDateKind = (
    Birthday = 0,
    Anniversary = 1,
    Other = 2
  );
  PContactDateKind = ^ContactDateKind;

  // Windows.ApplicationModel.Contacts.ContactChangeType
  ContactChangeType = (
    Created = 0,
    Modified = 1,
    Deleted = 2,
    ChangeTrackingLost = 3
  );
  PContactChangeType = ^ContactChangeType;

  // Windows.ApplicationModel.Contacts.ContactRelationship
  ContactRelationship = (
    Other = 0,
    Spouse = 1,
    Partner = 2,
    Sibling = 3,
    Parent = 4,
    Child = 5
  );
  PContactRelationship = ^ContactRelationship;

  // Windows.ApplicationModel.Contacts.ContactQueryDesiredFields
  ContactQueryDesiredFields = (
    None = 0,
    PhoneNumber = 1,
    EmailAddress = 2,
    PostalAddress = 4
  );
  PContactQueryDesiredFields = ^ContactQueryDesiredFields;

  // Windows.ApplicationModel.Contacts.ContactQuerySearchFields
  ContactQuerySearchFields = (
    None = 0,
    Name = 1,
    Email = 2,
    Phone = 4,
    All = -1
  );
  PContactQuerySearchFields = ^ContactQuerySearchFields;

  // Windows.ApplicationModel.Contacts.ContactQuerySearchScope
  ContactQuerySearchScope = (
    Local = 0,
    Server = 1
  );
  PContactQuerySearchScope = ^ContactQuerySearchScope;

  // Windows.ApplicationModel.Contacts.ContactStoreAccessType
  ContactStoreAccessType = (
    AppContactsReadWrite = 0,
    AllContactsReadOnly = 1,
    AllContactsReadWrite = 2
  );
  PContactStoreAccessType = ^ContactStoreAccessType;

  // Windows.ApplicationModel.Contacts.ContactAnnotationStoreAccessType
  ContactAnnotationStoreAccessType = (
    AppAnnotationsReadWrite = 0,
    AllAnnotationsReadWrite = 1
  );
  PContactAnnotationStoreAccessType = ^ContactAnnotationStoreAccessType;

  // Windows.ApplicationModel.Contacts.ContactListOtherAppReadAccess
  ContactListOtherAppReadAccess = (
    SystemOnly = 0,
    Limited = 1,
    Full = 2
  );
  PContactListOtherAppReadAccess = ^ContactListOtherAppReadAccess;

  // Windows.ApplicationModel.Contacts.ContactListOtherAppWriteAccess
  ContactListOtherAppWriteAccess = (
    None = 0,
    SystemOnly = 1
  );
  PContactListOtherAppWriteAccess = ^ContactListOtherAppWriteAccess;

  // Windows.ApplicationModel.Contacts.ContactMatchReasonKind
  ContactMatchReasonKind = (
    Name = 0,
    EmailAddress = 1,
    PhoneNumber = 2,
    JobInfo = 3,
    YomiName = 4,
    Other = 5
  );
  PContactMatchReasonKind = ^ContactMatchReasonKind;

  // Windows.ApplicationModel.Contacts.ContactBatchStatus
  ContactBatchStatus = (
    Success = 0,
    ServerSearchSyncManagerError = 1,
    ServerSearchUnknownError = 2
  );
  PContactBatchStatus = ^ContactBatchStatus;

  // Windows.ApplicationModel.Contacts.ContactAnnotationOperations
  ContactAnnotationOperations = (
    None = 0,
    ContactProfile = 1,
    Message = 2,
    AudioCall = 4,
    VideoCall = 8,
    SocialFeeds = 16
  );
  PContactAnnotationOperations = ^ContactAnnotationOperations;

  // Windows.ApplicationModel.Contacts.ContactNameOrder
  ContactNameOrder = (
    FirstNameLastName = 0,
    LastNameFirstName = 1
  );
  PContactNameOrder = ^ContactNameOrder;

  // Windows.ApplicationModel.Contacts.ContactListSyncStatus
  ContactListSyncStatus = (
    Idle = 0,
    Syncing = 1,
    UpToDate = 2,
    AuthenticationError = 3,
    PolicyError = 4,
    UnknownError = 5
  );
  PContactListSyncStatus = ^ContactListSyncStatus;

  // Windows.ApplicationModel.Contacts.ContactCardHeaderKind
  ContactCardHeaderKind = (
    Default = 0,
    Basic = 1,
    Enterprise = 2
  );
  PContactCardHeaderKind = ^ContactCardHeaderKind;

  // Windows.ApplicationModel.Contacts.ContactCardTabKind
  ContactCardTabKind = (
    Default = 0,
    Email = 1,
    Messaging = 2,
    Phone = 3,
    Video = 4
  );
  PContactCardTabKind = ^ContactCardTabKind;

  // Windows.ApplicationModel.Contacts.ContactFieldCategory
  ContactFieldCategory = (
    None = 0,
    Home = 1,
    Work = 2,
    Mobile = 3,
    Other = 4
  );
  PContactFieldCategory = ^ContactFieldCategory;

  // Windows.ApplicationModel.Contacts.Provider.AddContactResult
  Provider_AddContactResult = (
    Added = 0,
    AlreadyAdded = 1,
    Unavailable = 2
  );
  PProvider_AddContactResult = ^Provider_AddContactResult;



  // Windows.ApplicationModel.DataTransfer Enums
  // Windows.ApplicationModel.DataTransfer.DataPackageOperation
  DataPackageOperation = (
    None = 0,
    Copy = 1,
    Move = 2,
    Link = 4
  );
  PDataPackageOperation = ^DataPackageOperation;

  // Windows.ApplicationModel.DataTransfer.DragDrop.DragDropModifiers
  DragDrop_DragDropModifiers = (
    None = 0,
    Shift = 1,
    Control = 2,
    Alt = 4,
    LeftButton = 8,
    MiddleButton = 16,
    RightButton = 32
  );
  PDragDrop_DragDropModifiers = ^DragDrop_DragDropModifiers;

  // Windows.ApplicationModel.DataTransfer.DragDrop.Core.CoreDragUIContentMode
  DragDrop_Core_CoreDragUIContentMode = (
    Auto = 0,
    Deferred = 1
  );
  PDragDrop_Core_CoreDragUIContentMode = ^DragDrop_Core_CoreDragUIContentMode;



  // Windows.Data Enums
  // Windows.Data.Json.JsonValueType
  Json_JsonValueType = (
    Null = 0,
    Boolean = 1,
    Number = 2,
    &String = 3,
    &Array = 4,
    &Object = 5
  );
  PJson_JsonValueType = ^Json_JsonValueType;

  // Windows.Data.Json.JsonErrorStatus
  Json_JsonErrorStatus = (
    Unknown = 0,
    InvalidJsonString = 1,
    InvalidJsonNumber = 2,
    JsonValueNotFound = 3,
    ImplementationLimit = 4
  );
  PJson_JsonErrorStatus = ^Json_JsonErrorStatus;

  // Windows.Data.Pdf.PdfPageRotation
  Pdf_PdfPageRotation = (
    Normal = 0,
    Rotate90 = 1,
    Rotate180 = 2,
    Rotate270 = 3
  );
  PPdf_PdfPageRotation = ^Pdf_PdfPageRotation;

  // Windows.Data.Xml.Dom.NodeType
  Xml_Dom_NodeType = (
    Invalid = 0,
    ElementNode = 1,
    AttributeNode = 2,
    TextNode = 3,
    DataSectionNode = 4,
    EntityReferenceNode = 5,
    EntityNode = 6,
    ProcessingInstructionNode = 7,
    CommentNode = 8,
    DocumentNode = 9,
    DocumentTypeNode = 10,
    DocumentFragmentNode = 11,
    NotationNode = 12
  );
  PXml_Dom_NodeType = ^Xml_Dom_NodeType;

  // Windows.Data.Text.UnicodeGeneralCategory
  Text_UnicodeGeneralCategory = (
    UppercaseLetter = 0,
    LowercaseLetter = 1,
    TitlecaseLetter = 2,
    ModifierLetter = 3,
    OtherLetter = 4,
    NonspacingMark = 5,
    SpacingCombiningMark = 6,
    EnclosingMark = 7,
    DecimalDigitNumber = 8,
    LetterNumber = 9,
    OtherNumber = 10,
    SpaceSeparator = 11,
    LineSeparator = 12,
    ParagraphSeparator = 13,
    Control = 14,
    Format = 15,
    Surrogate = 16,
    PrivateUse = 17,
    ConnectorPunctuation = 18,
    DashPunctuation = 19,
    OpenPunctuation = 20,
    ClosePunctuation = 21,
    InitialQuotePunctuation = 22,
    FinalQuotePunctuation = 23,
    OtherPunctuation = 24,
    MathSymbol = 25,
    CurrencySymbol = 26,
    ModifierSymbol = 27,
    OtherSymbol = 28,
    NotAssigned = 29
  );
  PText_UnicodeGeneralCategory = ^Text_UnicodeGeneralCategory;

  // Windows.Data.Text.UnicodeNumericType
  Text_UnicodeNumericType = (
    None = 0,
    Decimal = 1,
    Digit = 2,
    Numeric = 3
  );
  PText_UnicodeNumericType = ^Text_UnicodeNumericType;

  // Windows.Data.Text.AlternateNormalizationFormat
  Text_AlternateNormalizationFormat = (
    NotNormalized = 0,
    Number = 1,
    Currency = 3,
    Date = 4,
    Time = 5
  );
  PText_AlternateNormalizationFormat = ^Text_AlternateNormalizationFormat;


  // Windows.Data Records
  // Windows.Data.Text.TextSegment
  Text_TextSegment = record
    StartPosition: Cardinal;
    Length: Cardinal;
  end;
  PText_TextSegment = ^Text_TextSegment;



  // Windows.Devices Enums
  // Windows.Devices.HumanInterfaceDevice.HidReportType
  HumanInterfaceDevice_HidReportType = (
    Input = 0,
    Output = 1,
    Feature = 2
  );
  PHumanInterfaceDevice_HidReportType = ^HumanInterfaceDevice_HidReportType;

  // Windows.Devices.HumanInterfaceDevice.HidCollectionType
  HumanInterfaceDevice_HidCollectionType = (
    Physical = 0,
    Application = 1,
    Logical = 2,
    Report = 3,
    NamedArray = 4,
    UsageSwitch = 5,
    UsageModifier = 6,
    Other = 7
  );
  PHumanInterfaceDevice_HidCollectionType = ^HumanInterfaceDevice_HidCollectionType;

  // Windows.Devices.Input.PointerDeviceType
  Input_PointerDeviceType = (
    Touch = 0,
    Pen = 1,
    Mouse = 2
  );
  PInput_PointerDeviceType = ^Input_PointerDeviceType;

  // Windows.Devices.Perception.PerceptionFrameSourceAccessStatus
  Perception_PerceptionFrameSourceAccessStatus = (
    Unspecified = 0,
    Allowed = 1,
    DeniedByUser = 2,
    DeniedBySystem = 3
  );
  PPerception_PerceptionFrameSourceAccessStatus = ^Perception_PerceptionFrameSourceAccessStatus;

  // Windows.Devices.Perception.PerceptionFrameSourcePropertyChangeStatus
  Perception_PerceptionFrameSourcePropertyChangeStatus = (
    Unknown = 0,
    Accepted = 1,
    LostControl = 2,
    PropertyNotSupported = 3,
    PropertyReadOnly = 4,
    ValueOutOfRange = 5
  );
  PPerception_PerceptionFrameSourcePropertyChangeStatus = ^Perception_PerceptionFrameSourcePropertyChangeStatus;

  // Windows.Devices.Radios.RadioState
  Radios_RadioState = (
    Unknown = 0,
    On = 1,
    Off = 2,
    Disabled = 3
  );
  PRadios_RadioState = ^Radios_RadioState;

  // Windows.Devices.Radios.RadioKind
  Radios_RadioKind = (
    Other = 0,
    WiFi = 1,
    MobileBroadband = 2,
    Bluetooth = 3,
    FM = 4
  );
  PRadios_RadioKind = ^Radios_RadioKind;

  // Windows.Devices.Radios.RadioAccessStatus
  Radios_RadioAccessStatus = (
    Unspecified = 0,
    Allowed = 1,
    DeniedByUser = 2,
    DeniedBySystem = 3
  );
  PRadios_RadioAccessStatus = ^Radios_RadioAccessStatus;

  // Windows.Devices.SerialCommunication.SerialParity
  SerialCommunication_SerialParity = (
    None = 0,
    Odd = 1,
    Even = 2,
    Mark = 3,
    Space = 4
  );
  PSerialCommunication_SerialParity = ^SerialCommunication_SerialParity;

  // Windows.Devices.SerialCommunication.SerialHandshake
  SerialCommunication_SerialHandshake = (
    None = 0,
    RequestToSend = 1,
    XOnXOff = 2,
    RequestToSendXOnXOff = 3
  );
  PSerialCommunication_SerialHandshake = ^SerialCommunication_SerialHandshake;

  // Windows.Devices.SerialCommunication.SerialStopBitCount
  SerialCommunication_SerialStopBitCount = (
    One = 0,
    OnePointFive = 1,
    Two = 2
  );
  PSerialCommunication_SerialStopBitCount = ^SerialCommunication_SerialStopBitCount;

  // Windows.Devices.SerialCommunication.SerialError
  SerialCommunication_SerialError = (
    Frame = 0,
    BufferOverrun = 1,
    ReceiveFull = 2,
    ReceiveParity = 3,
    TransmitFull = 4
  );
  PSerialCommunication_SerialError = ^SerialCommunication_SerialError;

  // Windows.Devices.SerialCommunication.SerialPinChange
  SerialCommunication_SerialPinChange = (
    BreakSignal = 0,
    CarrierDetect = 1,
    ClearToSend = 2,
    DataSetReady = 3,
    RingIndicator = 4
  );
  PSerialCommunication_SerialPinChange = ^SerialCommunication_SerialPinChange;

  // Windows.Devices.SmartCards.SmartCardReaderKind
  SmartCards_SmartCardReaderKind = (
    Any = 0,
    Generic = 1,
    Tpm = 2,
    Nfc = 3,
    Uicc = 4
  );
  PSmartCards_SmartCardReaderKind = ^SmartCards_SmartCardReaderKind;

  // Windows.Devices.SmartCards.SmartCardReaderStatus
  SmartCards_SmartCardReaderStatus = (
    Disconnected = 0,
    Ready = 1,
    Exclusive = 2
  );
  PSmartCards_SmartCardReaderStatus = ^SmartCards_SmartCardReaderStatus;

  // Windows.Devices.SmartCards.SmartCardStatus
  SmartCards_SmartCardStatus = (
    Disconnected = 0,
    Ready = 1,
    Shared = 2,
    Exclusive = 3,
    Unresponsive = 4
  );
  PSmartCards_SmartCardStatus = ^SmartCards_SmartCardStatus;

  // Windows.Devices.SmartCards.SmartCardPinCharacterPolicyOption
  SmartCards_SmartCardPinCharacterPolicyOption = (
    Allow = 0,
    RequireAtLeastOne = 1,
    Disallow = 2
  );
  PSmartCards_SmartCardPinCharacterPolicyOption = ^SmartCards_SmartCardPinCharacterPolicyOption;

  // Windows.Devices.Usb.UsbTransferDirection
  Usb_UsbTransferDirection = (
    Out = 0,
    &In = 1
  );
  PUsb_UsbTransferDirection = ^Usb_UsbTransferDirection;

  // Windows.Devices.Usb.UsbEndpointType
  Usb_UsbEndpointType = (
    Control = 0,
    Isochronous = 1,
    Bulk = 2,
    Interrupt = 3
  );
  PUsb_UsbEndpointType = ^Usb_UsbEndpointType;

  // Windows.Devices.Usb.UsbControlRecipient
  Usb_UsbControlRecipient = (
    Device = 0,
    SpecifiedInterface = 1,
    Endpoint = 2,
    Other = 3,
    DefaultInterface = 4
  );
  PUsb_UsbControlRecipient = ^Usb_UsbControlRecipient;

  // Windows.Devices.Usb.UsbControlTransferType
  Usb_UsbControlTransferType = (
    Standard = 0,
    &Class = 1,
    Vendor = 2
  );
  PUsb_UsbControlTransferType = ^Usb_UsbControlTransferType;

  // Windows.Devices.Usb.UsbReadOptions
  Usb_UsbReadOptions = (
    None = 0,
    AutoClearStall = 1,
    OverrideAutomaticBufferManagement = 2,
    IgnoreShortPacket = 4,
    AllowPartialReads = 8
  );
  PUsb_UsbReadOptions = ^Usb_UsbReadOptions;

  // Windows.Devices.Usb.UsbWriteOptions
  Usb_UsbWriteOptions = (
    None = 0,
    AutoClearStall = 1,
    ShortPacketTerminate = 2
  );
  PUsb_UsbWriteOptions = ^Usb_UsbWriteOptions;

  // Windows.Devices.WiFi.WiFiNetworkKind
  WiFi_WiFiNetworkKind = (
    Any = 0,
    Infrastructure = 1,
    Adhoc = 2
  );
  PWiFi_WiFiNetworkKind = ^WiFi_WiFiNetworkKind;

  // Windows.Devices.WiFi.WiFiPhyKind
  WiFi_WiFiPhyKind = (
    Unknown = 0,
    Fhss = 1,
    Dsss = 2,
    IRBaseband = 3,
    Ofdm = 4,
    Hrdsss = 5,
    Erp = 6,
    HT = 7,
    Vht = 8
  );
  PWiFi_WiFiPhyKind = ^WiFi_WiFiPhyKind;

  // Windows.Devices.WiFi.WiFiAccessStatus
  WiFi_WiFiAccessStatus = (
    Unspecified = 0,
    Allowed = 1,
    DeniedByUser = 2,
    DeniedBySystem = 3
  );
  PWiFi_WiFiAccessStatus = ^WiFi_WiFiAccessStatus;

  // Windows.Devices.WiFi.WiFiReconnectionKind
  WiFi_WiFiReconnectionKind = (
    Automatic = 0,
    Manual = 1
  );
  PWiFi_WiFiReconnectionKind = ^WiFi_WiFiReconnectionKind;

  // Windows.Devices.WiFi.WiFiConnectionStatus
  WiFi_WiFiConnectionStatus = (
    UnspecifiedFailure = 0,
    Success = 1,
    AccessRevoked = 2,
    InvalidCredential = 3,
    NetworkNotAvailable = 4,
    Timeout = 5,
    UnsupportedAuthenticationProtocol = 6
  );
  PWiFi_WiFiConnectionStatus = ^WiFi_WiFiConnectionStatus;

  // Windows.Devices.WiFiDirect.WiFiDirectConnectionStatus
  WiFiDirect_WiFiDirectConnectionStatus = (
    Disconnected = 0,
    Connected = 1
  );
  PWiFiDirect_WiFiDirectConnectionStatus = ^WiFiDirect_WiFiDirectConnectionStatus;

  // Windows.Devices.WiFiDirect.WiFiDirectError
  WiFiDirect_WiFiDirectError = (
    Success = 0,
    RadioNotAvailable = 1,
    ResourceInUse = 2
  );
  PWiFiDirect_WiFiDirectError = ^WiFiDirect_WiFiDirectError;

  // Windows.Devices.WiFiDirect.WiFiDirectDeviceSelectorType
  WiFiDirect_WiFiDirectDeviceSelectorType = (
    DeviceInterface = 0,
    AssociationEndpoint = 1
  );
  PWiFiDirect_WiFiDirectDeviceSelectorType = ^WiFiDirect_WiFiDirectDeviceSelectorType;

  // Windows.Devices.WiFiDirect.WiFiDirectAdvertisementListenStateDiscoverability
  WiFiDirect_WiFiDirectAdvertisementListenStateDiscoverability = (
    None = 0,
    Normal = 1,
    Intensive = 2
  );
  PWiFiDirect_WiFiDirectAdvertisementListenStateDiscoverability = ^WiFiDirect_WiFiDirectAdvertisementListenStateDiscoverability;

  // Windows.Devices.WiFiDirect.WiFiDirectAdvertisementPublisherStatus
  WiFiDirect_WiFiDirectAdvertisementPublisherStatus = (
    Created = 0,
    Started = 1,
    Stopped = 2,
    Aborted = 3
  );
  PWiFiDirect_WiFiDirectAdvertisementPublisherStatus = ^WiFiDirect_WiFiDirectAdvertisementPublisherStatus;

  // Windows.Devices.WiFiDirect.Services.WiFiDirectServiceConfigurationMethod
  WiFiDirect_Services_WiFiDirectServiceConfigurationMethod = (
    Default = 0,
    PinDisplay = 1,
    PinEntry = 2
  );
  PWiFiDirect_Services_WiFiDirectServiceConfigurationMethod = ^WiFiDirect_Services_WiFiDirectServiceConfigurationMethod;

  // Windows.Devices.WiFiDirect.Services.WiFiDirectServiceStatus
  WiFiDirect_Services_WiFiDirectServiceStatus = (
    Available = 0,
    Busy = 1,
    Custom = 2
  );
  PWiFiDirect_Services_WiFiDirectServiceStatus = ^WiFiDirect_Services_WiFiDirectServiceStatus;

  // Windows.Devices.WiFiDirect.Services.WiFiDirectServiceSessionStatus
  WiFiDirect_Services_WiFiDirectServiceSessionStatus = (
    Closed = 0,
    Initiated = 1,
    Requested = 2,
    Open = 3
  );
  PWiFiDirect_Services_WiFiDirectServiceSessionStatus = ^WiFiDirect_Services_WiFiDirectServiceSessionStatus;

  // Windows.Devices.WiFiDirect.Services.WiFiDirectServiceSessionErrorStatus
  WiFiDirect_Services_WiFiDirectServiceSessionErrorStatus = (
    Ok = 0,
    Disassociated = 1,
    LocalClose = 2,
    RemoteClose = 3,
    SystemFailure = 4,
    NoResponseFromRemote = 5
  );
  PWiFiDirect_Services_WiFiDirectServiceSessionErrorStatus = ^WiFiDirect_Services_WiFiDirectServiceSessionErrorStatus;

  // Windows.Devices.WiFiDirect.Services.WiFiDirectServiceAdvertisementStatus
  WiFiDirect_Services_WiFiDirectServiceAdvertisementStatus = (
    Created = 0,
    Started = 1,
    Stopped = 2,
    Aborted = 3
  );
  PWiFiDirect_Services_WiFiDirectServiceAdvertisementStatus = ^WiFiDirect_Services_WiFiDirectServiceAdvertisementStatus;

  // Windows.Devices.WiFiDirect.Services.WiFiDirectServiceError
  WiFiDirect_Services_WiFiDirectServiceError = (
    Success = 0,
    RadioNotAvailable = 1,
    ResourceInUse = 2,
    UnsupportedHardware = 3,
    NoHardware = 4
  );
  PWiFiDirect_Services_WiFiDirectServiceError = ^WiFiDirect_Services_WiFiDirectServiceError;

  // Windows.Devices.WiFiDirect.Services.WiFiDirectServiceIPProtocol
  WiFiDirect_Services_WiFiDirectServiceIPProtocol = (
    Tcp = 6,
    Udp = 17
  );
  PWiFiDirect_Services_WiFiDirectServiceIPProtocol = ^WiFiDirect_Services_WiFiDirectServiceIPProtocol;

  // Windows.Devices.Adc.Provider.ProviderAdcChannelMode
  Adc_Provider_ProviderAdcChannelMode = (
    SingleEnded = 0,
    Differential = 1
  );
  PAdc_Provider_ProviderAdcChannelMode = ^Adc_Provider_ProviderAdcChannelMode;

  // Windows.Devices.Adc.AdcChannelMode
  Adc_AdcChannelMode = (
    SingleEnded = 0,
    Differential = 1
  );
  PAdc_AdcChannelMode = ^Adc_AdcChannelMode;

  // Windows.Devices.Gpio.GpioSharingMode
  Gpio_GpioSharingMode = (
    Exclusive = 0,
    SharedReadOnly = 1
  );
  PGpio_GpioSharingMode = ^Gpio_GpioSharingMode;

  // Windows.Devices.Gpio.GpioOpenStatus
  Gpio_GpioOpenStatus = (
    PinOpened = 0,
    PinUnavailable = 1,
    SharingViolation = 2
  );
  PGpio_GpioOpenStatus = ^Gpio_GpioOpenStatus;

  // Windows.Devices.Gpio.GpioPinDriveMode
  Gpio_GpioPinDriveMode = (
    Input = 0,
    Output = 1,
    InputPullUp = 2,
    InputPullDown = 3,
    OutputOpenDrain = 4,
    OutputOpenDrainPullUp = 5,
    OutputOpenSource = 6,
    OutputOpenSourcePullDown = 7
  );
  PGpio_GpioPinDriveMode = ^Gpio_GpioPinDriveMode;

  // Windows.Devices.Gpio.GpioPinValue
  Gpio_GpioPinValue = (
    Low = 0,
    High = 1
  );
  PGpio_GpioPinValue = ^Gpio_GpioPinValue;

  // Windows.Devices.Gpio.GpioPinEdge
  Gpio_GpioPinEdge = (
    FallingEdge = 0,
    RisingEdge = 1
  );
  PGpio_GpioPinEdge = ^Gpio_GpioPinEdge;

  // Windows.Devices.I2c.I2cBusSpeed
  I2c_I2cBusSpeed = (
    StandardMode = 0,
    FastMode = 1
  );
  PI2c_I2cBusSpeed = ^I2c_I2cBusSpeed;

  // Windows.Devices.I2c.I2cTransferStatus
  I2c_I2cTransferStatus = (
    FullTransfer = 0,
    PartialTransfer = 1,
    SlaveAddressNotAcknowledged = 2
  );
  PI2c_I2cTransferStatus = ^I2c_I2cTransferStatus;

  // Windows.Devices.I2c.I2cSharingMode
  I2c_I2cSharingMode = (
    Exclusive = 0,
    Shared = 1
  );
  PI2c_I2cSharingMode = ^I2c_I2cSharingMode;

  // Windows.Devices.Pwm.PwmPulsePolarity
  Pwm_PwmPulsePolarity = (
    ActiveHigh = 0,
    ActiveLow = 1
  );
  PPwm_PwmPulsePolarity = ^Pwm_PwmPulsePolarity;

  // Windows.Devices.Spi.SpiMode
  Spi_SpiMode = (
    Mode0 = 0,
    Mode1 = 1,
    Mode2 = 2,
    Mode3 = 3
  );
  PSpi_SpiMode = ^Spi_SpiMode;

  // Windows.Devices.Spi.SpiSharingMode
  Spi_SpiSharingMode = (
    Exclusive = 0,
    Shared = 1
  );
  PSpi_SpiSharingMode = ^Spi_SpiSharingMode;

  // Windows.Devices.Custom.IOControlAccessMode
  Custom_IOControlAccessMode = (
    Any = 0,
    Read = 1,
    Write = 2,
    ReadWrite = 3
  );
  PCustom_IOControlAccessMode = ^Custom_IOControlAccessMode;

  // Windows.Devices.Custom.IOControlBufferingMethod
  Custom_IOControlBufferingMethod = (
    Buffered = 0,
    DirectInput = 1,
    DirectOutput = 2,
    Neither = 3
  );
  PCustom_IOControlBufferingMethod = ^Custom_IOControlBufferingMethod;

  // Windows.Devices.Custom.DeviceAccessMode
  Custom_DeviceAccessMode = (
    Read = 0,
    Write = 1,
    ReadWrite = 2
  );
  PCustom_DeviceAccessMode = ^Custom_DeviceAccessMode;

  // Windows.Devices.Custom.DeviceSharingMode
  Custom_DeviceSharingMode = (
    Shared = 0,
    Exclusive = 1
  );
  PCustom_DeviceSharingMode = ^Custom_DeviceSharingMode;

  // Windows.Devices.Portable.ServiceDeviceType
  Portable_ServiceDeviceType = (
    CalendarService = 0,
    ContactsService = 1,
    DeviceStatusService = 2,
    NotesService = 3,
    RingtonesService = 4,
    SmsService = 5,
    TasksService = 6
  );
  PPortable_ServiceDeviceType = ^Portable_ServiceDeviceType;

  // Windows.Devices.Printers.Extensions.Print3DWorkflowStatus
  Printers_Extensions_Print3DWorkflowStatus = (
    Abandoned = 0,
    Canceled = 1,
    Failed = 2,
    Submitted = 3
  );
  PPrinters_Extensions_Print3DWorkflowStatus = ^Printers_Extensions_Print3DWorkflowStatus;

  // Windows.Devices.Printers.Extensions.Print3DWorkflowDetail
  Printers_Extensions_Print3DWorkflowDetail = (
    Unknown = 0,
    ModelExceedsPrintBed = 1,
    UploadFailed = 2,
    InvalidMaterialSelection = 3,
    InvalidModel = 4,
    ModelNotManifold = 5,
    InvalidPrintTicket = 6
  );
  PPrinters_Extensions_Print3DWorkflowDetail = ^Printers_Extensions_Print3DWorkflowDetail;


  // Windows.Devices Records
  // Windows.Devices.Printers.PrintersContract
  Printers_PrintersContract = record
  end;
  PPrinters_PrintersContract = ^Printers_PrintersContract;

  // Windows.Devices.Input.PointerDeviceUsage
  Input_PointerDeviceUsage = record
    UsagePage: Cardinal;
    Usage: Cardinal;
    MinLogical: Integer;
    MaxLogical: Integer;
    MinPhysical: Integer;
    MaxPhysical: Integer;
    &Unit: Cardinal;
    PhysicalMultiplier: Single;
  end;
  PInput_PointerDeviceUsage = ^Input_PointerDeviceUsage;

  // Windows.Devices.Input.MouseDelta
  Input_MouseDelta = record
    X: Integer;
    Y: Integer;
  end;
  PInput_MouseDelta = ^Input_MouseDelta;

  // Windows.Devices.DevicesLowLevelContract
  DevicesLowLevelContract = record
  end;
  PDevicesLowLevelContract = ^DevicesLowLevelContract;

  // Windows.Devices.I2c.I2cTransferResult
  I2c_I2cTransferResult = record
    Status: I2c_I2cTransferStatus;
    BytesTransferred: Cardinal;
  end;
  PI2c_I2cTransferResult = ^I2c_I2cTransferResult;

  // Windows.Devices.Custom.CustomDeviceContract
  Custom_CustomDeviceContract = record
  end;
  PCustom_CustomDeviceContract = ^Custom_CustomDeviceContract;

  // Windows.Devices.Portable.PortableDeviceContract
  Portable_PortableDeviceContract = record
  end;
  PPortable_PortableDeviceContract = ^Portable_PortableDeviceContract;

  // Windows.Devices.Printers.Extensions.ExtensionsContract
  Printers_Extensions_ExtensionsContract = record
  end;
  PPrinters_Extensions_ExtensionsContract = ^Printers_Extensions_ExtensionsContract;



  // Windows.Devices.AllJoyn Enums
  // Windows.Devices.AllJoyn.AllJoynAuthenticationMechanism
  AllJoynAuthenticationMechanism = (
    None = 0,
    SrpAnonymous = 1,
    SrpLogon = 2,
    EcdheNull = 3,
    EcdhePsk = 4,
    EcdheEcdsa = 5
  );
  PAllJoynAuthenticationMechanism = ^AllJoynAuthenticationMechanism;

  // Windows.Devices.AllJoyn.AllJoynBusAttachmentState
  AllJoynBusAttachmentState = (
    Disconnected = 0,
    Connecting = 1,
    Connected = 2,
    Disconnecting = 3
  );
  PAllJoynBusAttachmentState = ^AllJoynBusAttachmentState;

  // Windows.Devices.AllJoyn.AllJoynTrafficType
  AllJoynTrafficType = (
    Unknown = 0,
    Messages = 1,
    RawUnreliable = 2,
    RawReliable = 4
  );
  PAllJoynTrafficType = ^AllJoynTrafficType;

  // Windows.Devices.AllJoyn.AllJoynSessionLostReason
  AllJoynSessionLostReason = (
    None = 0,
    ProducerLeftSession = 1,
    ProducerClosedAbruptly = 2,
    RemovedByProducer = 3,
    LinkTimeout = 4,
    Other = 5
  );
  PAllJoynSessionLostReason = ^AllJoynSessionLostReason;



  // Windows.Devices.Bluetooth.Advertisement Enums
  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEScanningMode
  BluetoothLEScanningMode = (
    Passive = 0,
    Active = 1
  );
  PBluetoothLEScanningMode = ^BluetoothLEScanningMode;

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementFlags
  BluetoothLEAdvertisementFlags = (
    None = 0,
    LimitedDiscoverableMode = 1,
    GeneralDiscoverableMode = 2,
    ClassicNotSupported = 4,
    DualModeControllerCapable = 8,
    DualModeHostCapable = 16
  );
  PBluetoothLEAdvertisementFlags = ^BluetoothLEAdvertisementFlags;

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementType
  BluetoothLEAdvertisementType = (
    ConnectableUndirected = 0,
    ConnectableDirected = 1,
    ScannableUndirected = 2,
    NonConnectableUndirected = 3,
    ScanResponse = 4
  );
  PBluetoothLEAdvertisementType = ^BluetoothLEAdvertisementType;

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementWatcherStatus
  BluetoothLEAdvertisementWatcherStatus = (
    Created = 0,
    Started = 1,
    Stopping = 2,
    Stopped = 3,
    Aborted = 4
  );
  PBluetoothLEAdvertisementWatcherStatus = ^BluetoothLEAdvertisementWatcherStatus;

  // Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementPublisherStatus
  BluetoothLEAdvertisementPublisherStatus = (
    Created = 0,
    Waiting = 1,
    Started = 2,
    Stopping = 3,
    Stopped = 4,
    Aborted = 5
  );
  PBluetoothLEAdvertisementPublisherStatus = ^BluetoothLEAdvertisementPublisherStatus;



  // Windows.Devices.Bluetooth Enums
  // Windows.Devices.Bluetooth.BluetoothCacheMode
  BluetoothCacheMode = (
    Cached = 0,
    Uncached = 1
  );
  PBluetoothCacheMode = ^BluetoothCacheMode;

  // Windows.Devices.Bluetooth.BluetoothMajorClass
  BluetoothMajorClass = (
    Miscellaneous = 0,
    Computer = 1,
    Phone = 2,
    NetworkAccessPoint = 3,
    AudioVideo = 4,
    Peripheral = 5,
    Imaging = 6,
    Wearable = 7,
    Toy = 8,
    Health = 9
  );
  PBluetoothMajorClass = ^BluetoothMajorClass;

  // Windows.Devices.Bluetooth.BluetoothMinorClass
  BluetoothMinorClass = (
    Uncategorized = 0,
    ComputerDesktop = 1,
    ComputerServer = 2,
    ComputerLaptop = 3,
    ComputerHandheld = 4,
    ComputerPalmSize = 5,
    ComputerWearable = 6,
    ComputerTablet = 7,
    PhoneCellular = 1,
    PhoneCordless = 2,
    PhoneSmartPhone = 3,
    PhoneWired = 4,
    PhoneIsdn = 5,
    NetworkFullyAvailable = 0,
    NetworkUsed01To17Percent = 8,
    NetworkUsed17To33Percent = 16,
    NetworkUsed33To50Percent = 24,
    NetworkUsed50To67Percent = 32,
    NetworkUsed67To83Percent = 40,
    NetworkUsed83To99Percent = 48,
    NetworkNoServiceAvailable = 56,
    AudioVideoWearableHeadset = 1,
    AudioVideoHandsFree = 2,
    AudioVideoMicrophone = 4,
    AudioVideoLoudspeaker = 5,
    AudioVideoHeadphones = 6,
    AudioVideoPortableAudio = 7,
    AudioVideoCarAudio = 8,
    AudioVideoSetTopBox = 9,
    AudioVideoHifiAudioDevice = 10,
    AudioVideoVcr = 11,
    AudioVideoVideoCamera = 12,
    AudioVideoCamcorder = 13,
    AudioVideoVideoMonitor = 14,
    AudioVideoVideoDisplayAndLoudspeaker = 15,
    AudioVideoVideoConferencing = 16,
    AudioVideoGamingOrToy = 18,
    PeripheralJoystick = 1,
    PeripheralGamepad = 2,
    PeripheralRemoteControl = 3,
    PeripheralSensing = 4,
    PeripheralDigitizerTablet = 5,
    PeripheralCardReader = 6,
    PeripheralDigitalPen = 7,
    PeripheralHandheldScanner = 8,
    PeripheralHandheldGesture = 9,
    WearableWristwatch = 1,
    WearablePager = 2,
    WearableJacket = 3,
    WearableHelmet = 4,
    WearableGlasses = 5,
    ToyRobot = 1,
    ToyVehicle = 2,
    ToyDoll = 3,
    ToyController = 4,
    ToyGame = 5,
    HealthBloodPressureMonitor = 1,
    HealthThermometer = 2,
    HealthWeighingScale = 3,
    HealthGlucoseMeter = 4,
    HealthPulseOximeter = 5,
    HealthHeartRateMonitor = 6,
    HealthHealthDataDisplay = 7,
    HealthStepCounter = 8,
    HealthBodyCompositionAnalyzer = 9,
    HealthPeakFlowMonitor = 10,
    HealthMedicationMonitor = 11,
    HealthKneeProsthesis = 12,
    HealthAnkleProsthesis = 13,
    HealthGenericHealthManager = 14,
    HealthPersonalMobilityDevice = 15
  );
  PBluetoothMinorClass = ^BluetoothMinorClass;

  // Windows.Devices.Bluetooth.BluetoothServiceCapabilities
  BluetoothServiceCapabilities = (
    None = 0,
    LimitedDiscoverableMode = 1,
    PositioningService = 8,
    NetworkingService = 16,
    RenderingService = 32,
    CapturingService = 64,
    ObjectTransferService = 128,
    AudioService = 256,
    TelephoneService = 512,
    InformationService = 1024
  );
  PBluetoothServiceCapabilities = ^BluetoothServiceCapabilities;

  // Windows.Devices.Bluetooth.BluetoothConnectionStatus
  BluetoothConnectionStatus = (
    Disconnected = 0,
    Connected = 1
  );
  PBluetoothConnectionStatus = ^BluetoothConnectionStatus;

  // Windows.Devices.Bluetooth.BluetoothError
  BluetoothError = (
    Success = 0,
    RadioNotAvailable = 1,
    ResourceInUse = 2,
    DeviceNotConnected = 3,
    OtherError = 4,
    DisabledByPolicy = 5,
    NotSupported = 6
  );
  PBluetoothError = ^BluetoothError;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattCharacteristicProperties
  GenericAttributeProfile_GattCharacteristicProperties = (
    None = 0,
    Broadcast = 1,
    Read = 2,
    WriteWithoutResponse = 4,
    Write = 8,
    Notify = 16,
    Indicate = 32,
    AuthenticatedSignedWrites = 64,
    ExtendedProperties = 128,
    ReliableWrites = 256,
    WritableAuxiliaries = 512
  );
  PGenericAttributeProfile_GattCharacteristicProperties = ^GenericAttributeProfile_GattCharacteristicProperties;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattClientCharacteristicConfigurationDescriptorValue
  GenericAttributeProfile_GattClientCharacteristicConfigurationDescriptorValue = (
    None = 0,
    Notify = 1,
    Indicate = 2
  );
  PGenericAttributeProfile_GattClientCharacteristicConfigurationDescriptorValue = ^GenericAttributeProfile_GattClientCharacteristicConfigurationDescriptorValue;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattProtectionLevel
  GenericAttributeProfile_GattProtectionLevel = (
    Plain = 0,
    AuthenticationRequired = 1,
    EncryptionRequired = 2,
    EncryptionAndAuthenticationRequired = 3
  );
  PGenericAttributeProfile_GattProtectionLevel = ^GenericAttributeProfile_GattProtectionLevel;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattWriteOption
  GenericAttributeProfile_GattWriteOption = (
    WriteWithResponse = 0,
    WriteWithoutResponse = 1
  );
  PGenericAttributeProfile_GattWriteOption = ^GenericAttributeProfile_GattWriteOption;

  // Windows.Devices.Bluetooth.GenericAttributeProfile.GattCommunicationStatus
  GenericAttributeProfile_GattCommunicationStatus = (
    Success = 0,
    Unreachable = 1
  );
  PGenericAttributeProfile_GattCommunicationStatus = ^GenericAttributeProfile_GattCommunicationStatus;



  // Windows.Devices.Enumeration Enums
  // Windows.Devices.Enumeration.DeviceClass
  DeviceClass = (
    All = 0,
    AudioCapture = 1,
    AudioRender = 2,
    PortableStorageDevice = 3,
    VideoCapture = 4,
    ImageScanner = 5,
    Location = 6
  );
  PDeviceClass = ^DeviceClass;

  // Windows.Devices.Enumeration.DeviceWatcherStatus
  DeviceWatcherStatus = (
    Created = 0,
    Started = 1,
    EnumerationCompleted = 2,
    Stopping = 3,
    Stopped = 4,
    Aborted = 5
  );
  PDeviceWatcherStatus = ^DeviceWatcherStatus;

  // Windows.Devices.Enumeration.Panel
  Panel = (
    Unknown = 0,
    Front = 1,
    Back = 2,
    Top = 3,
    Bottom = 4,
    Left = 5,
    Right = 6
  );
  PPanel = ^Panel;

  // Windows.Devices.Enumeration.DeviceInformationKind
  DeviceInformationKind = (
    Unknown = 0,
    DeviceInterface = 1,
    DeviceContainer = 2,
    Device = 3,
    DeviceInterfaceClass = 4,
    AssociationEndpoint = 5,
    AssociationEndpointContainer = 6,
    AssociationEndpointService = 7
  );
  PDeviceInformationKind = ^DeviceInformationKind;

  // Windows.Devices.Enumeration.DeviceWatcherEventKind
  DeviceWatcherEventKind = (
    Add = 0,
    Update = 1,
    Remove = 2
  );
  PDeviceWatcherEventKind = ^DeviceWatcherEventKind;

  // Windows.Devices.Enumeration.DevicePairingResultStatus
  DevicePairingResultStatus = (
    Paired = 0,
    NotReadyToPair = 1,
    NotPaired = 2,
    AlreadyPaired = 3,
    ConnectionRejected = 4,
    TooManyConnections = 5,
    HardwareFailure = 6,
    AuthenticationTimeout = 7,
    AuthenticationNotAllowed = 8,
    AuthenticationFailure = 9,
    NoSupportedProfiles = 10,
    ProtectionLevelCouldNotBeMet = 11,
    AccessDenied = 12,
    InvalidCeremonyData = 13
  );
  PDevicePairingResultStatus = ^DevicePairingResultStatus;

  // Windows.Devices.Enumeration.DevicePairingProtectionLevel
  DevicePairingProtectionLevel = (
    Default = 0,
    None = 1,
    Encryption = 2,
    EncryptionAndAuthentication = 3
  );
  PDevicePairingProtectionLevel = ^DevicePairingProtectionLevel;

  // Windows.Devices.Enumeration.DeviceAccessStatus
  DeviceAccessStatus = (
    Unspecified = 0,
    Allowed = 1,
    DeniedByUser = 2,
    DeniedBySystem = 3
  );
  PDeviceAccessStatus = ^DeviceAccessStatus;

  // Windows.Devices.Enumeration.DevicePickerDisplayStatusOptions
  DevicePickerDisplayStatusOptions = (
    None = 0,
    ShowProgress = 1,
    ShowDisconnectButton = 2,
    ShowRetryButton = 4
  );
  PDevicePickerDisplayStatusOptions = ^DevicePickerDisplayStatusOptions;

  // Windows.Devices.Enumeration.Pnp.PnpObjectType
  Pnp_PnpObjectType = (
    Unknown = 0,
    DeviceInterface = 1,
    DeviceContainer = 2,
    Device = 3,
    DeviceInterfaceClass = 4,
    AssociationEndpoint = 5,
    AssociationEndpointContainer = 6,
    AssociationEndpointService = 7
  );
  PPnp_PnpObjectType = ^Pnp_PnpObjectType;



  // Windows.Devices.Geolocation Enums
  // Windows.Devices.Geolocation.Geofencing.MonitoredGeofenceStates
  Geofencing_MonitoredGeofenceStates = (
    None = 0,
    Entered = 1,
    Exited = 2,
    Removed = 4
  );
  PGeofencing_MonitoredGeofenceStates = ^Geofencing_MonitoredGeofenceStates;

  // Windows.Devices.Geolocation.Geofencing.GeofenceState
  Geofencing_GeofenceState = (
    None = 0,
    Entered = 1,
    Exited = 2,
    Removed = 4
  );
  PGeofencing_GeofenceState = ^Geofencing_GeofenceState;

  // Windows.Devices.Geolocation.Geofencing.GeofenceMonitorStatus
  Geofencing_GeofenceMonitorStatus = (
    Ready = 0,
    Initializing = 1,
    NoData = 2,
    Disabled = 3,
    NotInitialized = 4,
    NotAvailable = 5
  );
  PGeofencing_GeofenceMonitorStatus = ^Geofencing_GeofenceMonitorStatus;

  // Windows.Devices.Geolocation.Geofencing.GeofenceRemovalReason
  Geofencing_GeofenceRemovalReason = (
    Used = 0,
    Expired = 1
  );
  PGeofencing_GeofenceRemovalReason = ^Geofencing_GeofenceRemovalReason;

  // Windows.Devices.Geolocation.PositionAccuracy
  PositionAccuracy = (
    Default = 0,
    High = 1
  );
  PPositionAccuracy = ^PositionAccuracy;

  // Windows.Devices.Geolocation.PositionStatus
  PositionStatus = (
    Ready = 0,
    Initializing = 1,
    NoData = 2,
    Disabled = 3,
    NotInitialized = 4,
    NotAvailable = 5
  );
  PPositionStatus = ^PositionStatus;

  // Windows.Devices.Geolocation.PositionSource
  PositionSource = (
    Cellular = 0,
    Satellite = 1,
    WiFi = 2,
    IPAddress = 3,
    Unknown = 4
  );
  PPositionSource = ^PositionSource;

  // Windows.Devices.Geolocation.GeoshapeType
  GeoshapeType = (
    Geopoint = 0,
    Geocircle = 1,
    Geopath = 2,
    GeoboundingBox = 3
  );
  PGeoshapeType = ^GeoshapeType;

  // Windows.Devices.Geolocation.AltitudeReferenceSystem
  AltitudeReferenceSystem = (
    Unspecified = 0,
    Terrain = 1,
    Ellipsoid = 2,
    Geoid = 3,
    Surface = 4
  );
  PAltitudeReferenceSystem = ^AltitudeReferenceSystem;

  // Windows.Devices.Geolocation.GeolocationAccessStatus
  GeolocationAccessStatus = (
    Unspecified = 0,
    Allowed = 1,
    Denied = 2
  );
  PGeolocationAccessStatus = ^GeolocationAccessStatus;


  // Windows.Devices.Geolocation Records
  // Windows.Devices.Geolocation.BasicGeoposition
  BasicGeoposition = record
    Latitude: Double;
    Longitude: Double;
    Altitude: Double;
  end;
  PBasicGeoposition = ^BasicGeoposition;



  // Windows.Devices.Midi Enums
  // Windows.Devices.Midi.MidiMessageType
  MidiMessageType = (
    None = 0,
    NoteOff = 128,
    NoteOn = 144,
    PolyphonicKeyPressure = 160,
    ControlChange = 176,
    ProgramChange = 192,
    ChannelPressure = 208,
    PitchBendChange = 224,
    SystemExclusive = 240,
    MidiTimeCode = 241,
    SongPositionPointer = 242,
    SongSelect = 243,
    TuneRequest = 246,
    TimingClock = 248,
    Start = 250,
    Continue = 251,
    Stop = 252,
    ActiveSensing = 254,
    SystemReset = 255
  );
  PMidiMessageType = ^MidiMessageType;



  // Windows.Devices.PointOfService Enums
  // Windows.Devices.PointOfService.UnifiedPosErrorSeverity
  UnifiedPosErrorSeverity = (
    UnknownErrorSeverity = 0,
    Warning = 1,
    Recoverable = 2,
    Unrecoverable = 3,
    AssistanceRequired = 4,
    Fatal = 5
  );
  PUnifiedPosErrorSeverity = ^UnifiedPosErrorSeverity;

  // Windows.Devices.PointOfService.UnifiedPosPowerReportingType
  UnifiedPosPowerReportingType = (
    UnknownPowerReportingType = 0,
    Standard = 1,
    Advanced = 2
  );
  PUnifiedPosPowerReportingType = ^UnifiedPosPowerReportingType;

  // Windows.Devices.PointOfService.UnifiedPosHealthCheckLevel
  UnifiedPosHealthCheckLevel = (
    UnknownHealthCheckLevel = 0,
    POSInternal = 1,
    External = 2,
    Interactive = 3
  );
  PUnifiedPosHealthCheckLevel = ^UnifiedPosHealthCheckLevel;

  // Windows.Devices.PointOfService.UnifiedPosErrorReason
  UnifiedPosErrorReason = (
    UnknownErrorReason = 0,
    NoService = 1,
    Disabled = 2,
    Illegal = 3,
    NoHardware = 4,
    Closed = 5,
    Offline = 6,
    Failure = 7,
    Timeout = 8,
    Busy = 9,
    Extended = 10
  );
  PUnifiedPosErrorReason = ^UnifiedPosErrorReason;

  // Windows.Devices.PointOfService.MagneticStripeReaderAuthenticationLevel
  MagneticStripeReaderAuthenticationLevel = (
    NotSupported = 0,
    Optional = 1,
    Required = 2
  );
  PMagneticStripeReaderAuthenticationLevel = ^MagneticStripeReaderAuthenticationLevel;

  // Windows.Devices.PointOfService.PosPrinterMapMode
  PosPrinterMapMode = (
    Dots = 0,
    Twips = 1,
    English = 2,
    Metric = 3
  );
  PPosPrinterMapMode = ^PosPrinterMapMode;

  // Windows.Devices.PointOfService.PosPrinterCartridgeSensors
  PosPrinterCartridgeSensors = (
    None = 0,
    Removed = 1,
    Empty = 2,
    HeadCleaning = 4,
    NearEnd = 8
  );
  PPosPrinterCartridgeSensors = ^PosPrinterCartridgeSensors;

  // Windows.Devices.PointOfService.PosPrinterColorCapabilities
  PosPrinterColorCapabilities = (
    None = 0,
    Primary = 1,
    Custom1 = 2,
    Custom2 = 4,
    Custom3 = 8,
    Custom4 = 16,
    Custom5 = 32,
    Custom6 = 64,
    Cyan = 128,
    Magenta = 256,
    Yellow = 512,
    Full = 1024
  );
  PPosPrinterColorCapabilities = ^PosPrinterColorCapabilities;

  // Windows.Devices.PointOfService.PosPrinterColorCartridge
  PosPrinterColorCartridge = (
    Unknown = 0,
    Primary = 1,
    Custom1 = 2,
    Custom2 = 3,
    Custom3 = 4,
    Custom4 = 5,
    Custom5 = 6,
    Custom6 = 7,
    Cyan = 8,
    Magenta = 9,
    Yellow = 10
  );
  PPosPrinterColorCartridge = ^PosPrinterColorCartridge;

  // Windows.Devices.PointOfService.PosPrinterMarkFeedCapabilities
  PosPrinterMarkFeedCapabilities = (
    None = 0,
    ToTakeUp = 1,
    ToCutter = 2,
    ToCurrentTopOfForm = 4,
    ToNextTopOfForm = 8
  );
  PPosPrinterMarkFeedCapabilities = ^PosPrinterMarkFeedCapabilities;

  // Windows.Devices.PointOfService.PosPrinterRuledLineCapabilities
  PosPrinterRuledLineCapabilities = (
    None = 0,
    Horizontal = 1,
    Vertical = 2
  );
  PPosPrinterRuledLineCapabilities = ^PosPrinterRuledLineCapabilities;

  // Windows.Devices.PointOfService.PosPrinterPrintSide
  PosPrinterPrintSide = (
    Unknown = 0,
    Side1 = 1,
    Side2 = 2
  );
  PPosPrinterPrintSide = ^PosPrinterPrintSide;

  // Windows.Devices.PointOfService.PosPrinterLineDirection
  PosPrinterLineDirection = (
    Horizontal = 0,
    Vertical = 1
  );
  PPosPrinterLineDirection = ^PosPrinterLineDirection;

  // Windows.Devices.PointOfService.PosPrinterLineStyle
  PosPrinterLineStyle = (
    SingleSolid = 0,
    DoubleSolid = 1,
    Broken = 2,
    Chain = 3
  );
  PPosPrinterLineStyle = ^PosPrinterLineStyle;

  // Windows.Devices.PointOfService.PosPrinterMarkFeedKind
  PosPrinterMarkFeedKind = (
    ToTakeUp = 0,
    ToCutter = 1,
    ToCurrentTopOfForm = 2,
    ToNextTopOfForm = 3
  );
  PPosPrinterMarkFeedKind = ^PosPrinterMarkFeedKind;

  // Windows.Devices.PointOfService.PosPrinterAlignment
  PosPrinterAlignment = (
    Left = 0,
    Center = 1,
    Right = 2
  );
  PPosPrinterAlignment = ^PosPrinterAlignment;

  // Windows.Devices.PointOfService.PosPrinterBarcodeTextPosition
  PosPrinterBarcodeTextPosition = (
    None = 0,
    Above = 1,
    Below = 2
  );
  PPosPrinterBarcodeTextPosition = ^PosPrinterBarcodeTextPosition;

  // Windows.Devices.PointOfService.PosPrinterRotation
  PosPrinterRotation = (
    Normal = 0,
    Right90 = 1,
    Left90 = 2,
    Rotate180 = 3
  );
  PPosPrinterRotation = ^PosPrinterRotation;

  // Windows.Devices.PointOfService.PosPrinterStatusKind
  PosPrinterStatusKind = (
    Online = 0,
    Off = 1,
    Offline = 2,
    OffOrOffline = 3,
    Extended = 4
  );
  PPosPrinterStatusKind = ^PosPrinterStatusKind;

  // Windows.Devices.PointOfService.CashDrawerStatusKind
  CashDrawerStatusKind = (
    Online = 0,
    Off = 1,
    Offline = 2,
    OffOrOffline = 3,
    Extended = 4
  );
  PCashDrawerStatusKind = ^CashDrawerStatusKind;

  // Windows.Devices.PointOfService.BarcodeScannerStatus
  BarcodeScannerStatus = (
    Online = 0,
    Off = 1,
    Offline = 2,
    OffOrOffline = 3,
    Extended = 4
  );
  PBarcodeScannerStatus = ^BarcodeScannerStatus;

  // Windows.Devices.PointOfService.MagneticStripeReaderStatus
  MagneticStripeReaderStatus = (
    Unauthenticated = 0,
    Authenticated = 1,
    Extended = 2
  );
  PMagneticStripeReaderStatus = ^MagneticStripeReaderStatus;

  // Windows.Devices.PointOfService.MagneticStripeReaderAuthenticationProtocol
  MagneticStripeReaderAuthenticationProtocol = (
    None = 0,
    ChallengeResponse = 1
  );
  PMagneticStripeReaderAuthenticationProtocol = ^MagneticStripeReaderAuthenticationProtocol;

  // Windows.Devices.PointOfService.MagneticStripeReaderTrackIds
  MagneticStripeReaderTrackIds = (
    None = 0,
    Track1 = 1,
    Track2 = 2,
    Track3 = 4,
    Track4 = 8
  );
  PMagneticStripeReaderTrackIds = ^MagneticStripeReaderTrackIds;

  // Windows.Devices.PointOfService.MagneticStripeReaderErrorReportingType
  MagneticStripeReaderErrorReportingType = (
    CardLevel = 0,
    TrackLevel = 1
  );
  PMagneticStripeReaderErrorReportingType = ^MagneticStripeReaderErrorReportingType;

  // Windows.Devices.PointOfService.MagneticStripeReaderTrackErrorType
  MagneticStripeReaderTrackErrorType = (
    None = 0,
    StartSentinelError = 1,
    EndSentinelError = 2,
    ParityError = 3,
    LrcError = 4,
    Unknown = -1
  );
  PMagneticStripeReaderTrackErrorType = ^MagneticStripeReaderTrackErrorType;



  // Windows.Devices.Scanners Enums
  // Windows.Devices.Scanners.ImageScannerFormat
  ImageScannerFormat = (
    Jpeg = 0,
    Png = 1,
    DeviceIndependentBitmap = 2,
    Tiff = 3,
    Xps = 4,
    OpenXps = 5,
    Pdf = 6
  );
  PImageScannerFormat = ^ImageScannerFormat;

  // Windows.Devices.Scanners.ImageScannerAutoCroppingMode
  ImageScannerAutoCroppingMode = (
    Disabled = 0,
    SingleRegion = 1,
    MultipleRegion = 2
  );
  PImageScannerAutoCroppingMode = ^ImageScannerAutoCroppingMode;

  // Windows.Devices.Scanners.ImageScannerColorMode
  ImageScannerColorMode = (
    Color = 0,
    Grayscale = 1,
    Monochrome = 2,
    AutoColor = 3
  );
  PImageScannerColorMode = ^ImageScannerColorMode;

  // Windows.Devices.Scanners.ImageScannerScanSource
  ImageScannerScanSource = (
    Default = 0,
    Flatbed = 1,
    Feeder = 2,
    AutoConfigured = 3
  );
  PImageScannerScanSource = ^ImageScannerScanSource;


  // Windows.Devices.Scanners Records
  // Windows.Devices.Scanners.ScannerDeviceContract
  ScannerDeviceContract = record
  end;
  PScannerDeviceContract = ^ScannerDeviceContract;

  // Windows.Devices.Scanners.ImageScannerResolution
  ImageScannerResolution = record
    DpiX: Single;
    DpiY: Single;
  end;
  PImageScannerResolution = ^ImageScannerResolution;



  // Windows.Devices.Sensors Enums
  // Windows.Devices.Sensors.MagnetometerAccuracy
  MagnetometerAccuracy = (
    Unknown = 0,
    Unreliable = 1,
    Approximate = 2,
    High = 3
  );
  PMagnetometerAccuracy = ^MagnetometerAccuracy;

  // Windows.Devices.Sensors.ActivityType
  ActivityType = (
    Unknown = 0,
    Idle = 1,
    Stationary = 2,
    Fidgeting = 3,
    Walking = 4,
    Running = 5,
    InVehicle = 6,
    Biking = 7
  );
  PActivityType = ^ActivityType;

  // Windows.Devices.Sensors.ActivitySensorReadingConfidence
  ActivitySensorReadingConfidence = (
    High = 0,
    Low = 1
  );
  PActivitySensorReadingConfidence = ^ActivitySensorReadingConfidence;

  // Windows.Devices.Sensors.SensorReadingType
  SensorReadingType = (
    Absolute = 0,
    Relative = 1
  );
  PSensorReadingType = ^SensorReadingType;

  // Windows.Devices.Sensors.SimpleOrientation
  SimpleOrientation = (
    NotRotated = 0,
    Rotated90DegreesCounterclockwise = 1,
    Rotated180DegreesCounterclockwise = 2,
    Rotated270DegreesCounterclockwise = 3,
    Faceup = 4,
    Facedown = 5
  );
  PSimpleOrientation = ^SimpleOrientation;

  // Windows.Devices.Sensors.PedometerStepKind
  PedometerStepKind = (
    Unknown = 0,
    Walking = 1,
    Running = 2
  );
  PPedometerStepKind = ^PedometerStepKind;



  // Windows.Devices.Sms Enums
  // Windows.Devices.Sms.SmsMessageClass
  SmsMessageClass = (
    None = 0,
    Class0 = 1,
    Class1 = 2,
    Class2 = 3,
    Class3 = 4
  );
  PSmsMessageClass = ^SmsMessageClass;

  // Windows.Devices.Sms.SmsMessageType
  SmsMessageType = (
    Binary = 0,
    Text = 1,
    Wap = 2,
    App = 3,
    Broadcast = 4,
    Voicemail = 5,
    Status = 6
  );
  PSmsMessageType = ^SmsMessageType;

  // Windows.Devices.Sms.CellularClass
  CellularClass = (
    None = 0,
    Gsm = 1,
    Cdma = 2
  );
  PCellularClass = ^CellularClass;

  // Windows.Devices.Sms.SmsDataFormat
  SmsDataFormat = (
    Unknown = 0,
    CdmaSubmit = 1,
    GsmSubmit = 2,
    CdmaDeliver = 3,
    GsmDeliver = 4
  );
  PSmsDataFormat = ^SmsDataFormat;

  // Windows.Devices.Sms.SmsEncoding
  SmsEncoding = (
    Unknown = 0,
    Optimal = 1,
    SevenBitAscii = 2,
    Unicode = 3,
    GsmSevenBit = 4,
    EightBit = 5,
    Latin = 6,
    Korean = 7,
    IA5 = 8,
    ShiftJis = 9,
    LatinHebrew = 10
  );
  PSmsEncoding = ^SmsEncoding;

  // Windows.Devices.Sms.SmsGeographicalScope
  SmsGeographicalScope = (
    None = 0,
    CellWithImmediateDisplay = 1,
    LocationArea = 2,
    Plmn = 3,
    Cell = 4
  );
  PSmsGeographicalScope = ^SmsGeographicalScope;

  // Windows.Devices.Sms.SmsBroadcastType
  SmsBroadcastType = (
    Other = 0,
    CmasPresidential = 1,
    CmasExtreme = 2,
    CmasSevere = 3,
    CmasAmber = 4,
    CmasTest = 5,
    EUAlert1 = 6,
    EUAlert2 = 7,
    EUAlert3 = 8,
    EUAlertAmber = 9,
    EUAlertInfo = 10,
    EtwsEarthquake = 11,
    EtwsTsunami = 12,
    EtwsTsunamiAndEarthquake = 13,
    LatAlertLocal = 14
  );
  PSmsBroadcastType = ^SmsBroadcastType;

  // Windows.Devices.Sms.SmsDeviceStatus
  SmsDeviceStatus = (
    Off = 0,
    Ready = 1,
    SimNotInserted = 2,
    BadSim = 3,
    DeviceFailure = 4,
    SubscriptionNotActivated = 5,
    DeviceLocked = 6,
    DeviceBlocked = 7
  );
  PSmsDeviceStatus = ^SmsDeviceStatus;

  // Windows.Devices.Sms.SmsModemErrorCode
  SmsModemErrorCode = (
    Other = 0,
    MessagingNetworkError = 1,
    SmsOperationNotSupportedByDevice = 2,
    SmsServiceNotSupportedByNetwork = 3,
    DeviceFailure = 4,
    MessageNotEncodedProperly = 5,
    MessageTooLarge = 6,
    DeviceNotReady = 7,
    NetworkNotReady = 8,
    InvalidSmscAddress = 9,
    NetworkFailure = 10,
    FixedDialingNumberRestricted = 11
  );
  PSmsModemErrorCode = ^SmsModemErrorCode;

  // Windows.Devices.Sms.SmsFilterActionType
  SmsFilterActionType = (
    AcceptImmediately = 0,
    Drop = 1,
    Peek = 2,
    Accept = 3
  );
  PSmsFilterActionType = ^SmsFilterActionType;

  // Windows.Devices.Sms.SmsMessageFilter
  SmsMessageFilter = (
    All = 0,
    Unread = 1,
    Read = 2,
    Sent = 3,
    Draft = 4
  );
  PSmsMessageFilter = ^SmsMessageFilter;


  // Windows.Devices.Sms Records
  // Windows.Devices.Sms.SmsEncodedLength
  SmsEncodedLength = record
    SegmentCount: Cardinal;
    CharacterCountLastSegment: Cardinal;
    CharactersPerSegment: Cardinal;
    ByteCountLastSegment: Cardinal;
    BytesPerSegment: Cardinal;
  end;
  PSmsEncodedLength = ^SmsEncodedLength;

  // Windows.Devices.Sms.LegacySmsApiContract
  LegacySmsApiContract = record
  end;
  PLegacySmsApiContract = ^LegacySmsApiContract;



  // Windows.Gaming Enums
  // Windows.Gaming.Input.GamepadButtons
  Input_GamepadButtons = (
    None = 0,
    Menu = 1,
    View = 2,
    A = 4,
    B = 8,
    X = 16,
    Y = 32,
    DPadUp = 64,
    DPadDown = 128,
    DPadLeft = 256,
    DPadRight = 512,
    LeftShoulder = 1024,
    RightShoulder = 2048,
    LeftThumbstick = 4096,
    RightThumbstick = 8192
  );
  PInput_GamepadButtons = ^Input_GamepadButtons;

  // Windows.Gaming.XboxLive.Storage.GameSaveErrorStatus
  XboxLive_Storage_GameSaveErrorStatus = (
    Ok = 0,
    Abort = -2147467260,
    InvalidContainerName = -2138898431,
    NoAccess = -2138898430,
    OutOfLocalStorage = -2138898429,
    UserCanceled = -2138898428,
    UpdateTooBig = -2138898427,
    QuotaExceeded = -2138898426,
    ProvidedBufferTooSmall = -2138898425,
    BlobNotFound = -2138898424,
    NoXboxLiveInfo = -2138898423,
    ContainerNotInSync = -2138898422,
    ContainerSyncFailed = -2138898421,
    UserHasNoXboxLiveInfo = -2138898420,
    ObjectExpired = -2138898419
  );
  PXboxLive_Storage_GameSaveErrorStatus = ^XboxLive_Storage_GameSaveErrorStatus;

  // Windows.Gaming.Preview.GamesEnumeration.GameListCategory
  Preview_GamesEnumeration_GameListCategory = (
    Candidate = 0,
    ConfirmedBySystem = 1,
    ConfirmedByUser = 2
  );
  PPreview_GamesEnumeration_GameListCategory = ^Preview_GamesEnumeration_GameListCategory;


  // Windows.Gaming Records
  // Windows.Gaming.Input.GamepadReading
  Input_GamepadReading = record
    Timestamp: UInt64;
    Buttons: Input_GamepadButtons;
    LeftTrigger: Double;
    RightTrigger: Double;
    LeftThumbstickX: Double;
    LeftThumbstickY: Double;
    RightThumbstickX: Double;
    RightThumbstickY: Double;
  end;
  PInput_GamepadReading = ^Input_GamepadReading;

  // Windows.Gaming.Input.GamepadVibration
  Input_GamepadVibration = record
    LeftMotor: Double;
    RightMotor: Double;
    LeftTrigger: Double;
    RightTrigger: Double;
  end;
  PInput_GamepadVibration = ^Input_GamepadVibration;

  // Windows.Gaming.XboxLive.StorageApiContract
  XboxLive_StorageApiContract = record
  end;
  PXboxLive_StorageApiContract = ^XboxLive_StorageApiContract;

  // Windows.Gaming.Preview.GamesEnumerationContract
  Preview_GamesEnumerationContract = record
  end;
  PPreview_GamesEnumerationContract = ^Preview_GamesEnumerationContract;



  // Windows.Globalization Enums
  // Windows.Globalization.DayOfWeek
  DayOfWeek = (
    Sunday = 0,
    Monday = 1,
    Tuesday = 2,
    Wednesday = 3,
    Thursday = 4,
    Friday = 5,
    Saturday = 6
  );
  PDayOfWeek = ^DayOfWeek;

  // Windows.Globalization.DateTimeFormatting.YearFormat
  DateTimeFormatting_YearFormat = (
    None = 0,
    Default = 1,
    Abbreviated = 2,
    Full = 3
  );
  PDateTimeFormatting_YearFormat = ^DateTimeFormatting_YearFormat;

  // Windows.Globalization.DateTimeFormatting.MonthFormat
  DateTimeFormatting_MonthFormat = (
    None = 0,
    Default = 1,
    Abbreviated = 2,
    Full = 3,
    Numeric = 4
  );
  PDateTimeFormatting_MonthFormat = ^DateTimeFormatting_MonthFormat;

  // Windows.Globalization.DateTimeFormatting.DayOfWeekFormat
  DateTimeFormatting_DayOfWeekFormat = (
    None = 0,
    Default = 1,
    Abbreviated = 2,
    Full = 3
  );
  PDateTimeFormatting_DayOfWeekFormat = ^DateTimeFormatting_DayOfWeekFormat;

  // Windows.Globalization.DateTimeFormatting.DayFormat
  DateTimeFormatting_DayFormat = (
    None = 0,
    Default = 1
  );
  PDateTimeFormatting_DayFormat = ^DateTimeFormatting_DayFormat;

  // Windows.Globalization.DateTimeFormatting.HourFormat
  DateTimeFormatting_HourFormat = (
    None = 0,
    Default = 1
  );
  PDateTimeFormatting_HourFormat = ^DateTimeFormatting_HourFormat;

  // Windows.Globalization.DateTimeFormatting.MinuteFormat
  DateTimeFormatting_MinuteFormat = (
    None = 0,
    Default = 1
  );
  PDateTimeFormatting_MinuteFormat = ^DateTimeFormatting_MinuteFormat;

  // Windows.Globalization.DateTimeFormatting.SecondFormat
  DateTimeFormatting_SecondFormat = (
    None = 0,
    Default = 1
  );
  PDateTimeFormatting_SecondFormat = ^DateTimeFormatting_SecondFormat;

  // Windows.Globalization.NumberFormatting.RoundingAlgorithm
  NumberFormatting_RoundingAlgorithm = (
    None = 0,
    RoundDown = 1,
    RoundUp = 2,
    RoundTowardsZero = 3,
    RoundAwayFromZero = 4,
    RoundHalfDown = 5,
    RoundHalfUp = 6,
    RoundHalfTowardsZero = 7,
    RoundHalfAwayFromZero = 8,
    RoundHalfToEven = 9,
    RoundHalfToOdd = 10
  );
  PNumberFormatting_RoundingAlgorithm = ^NumberFormatting_RoundingAlgorithm;

  // Windows.Globalization.NumberFormatting.CurrencyFormatterMode
  NumberFormatting_CurrencyFormatterMode = (
    UseSymbol = 0,
    UseCurrencyCode = 1
  );
  PNumberFormatting_CurrencyFormatterMode = ^NumberFormatting_CurrencyFormatterMode;


  // Windows.Globalization Records
  // Windows.Globalization.GlobalizationJapanesePhoneticAnalyzerContract
  GlobalizationJapanesePhoneticAnalyzerContract = record
  end;
  PGlobalizationJapanesePhoneticAnalyzerContract = ^GlobalizationJapanesePhoneticAnalyzerContract;



  // Windows.Graphics Enums
  // Windows.Graphics.Display.DisplayOrientations
  Display_DisplayOrientations = (
    None = 0,
    Landscape = 1,
    Portrait = 2,
    LandscapeFlipped = 4,
    PortraitFlipped = 8
  );
  PDisplay_DisplayOrientations = ^Display_DisplayOrientations;

  // Windows.Graphics.Display.ResolutionScale
  Display_ResolutionScale = (
    Invalid = 0,
    Scale100Percent = 100,
    Scale120Percent = 120,
    Scale125Percent = 125,
    Scale140Percent = 140,
    Scale150Percent = 150,
    Scale160Percent = 160,
    Scale175Percent = 175,
    Scale180Percent = 180,
    Scale200Percent = 200,
    Scale225Percent = 225,
    Scale250Percent = 250,
    Scale300Percent = 300,
    Scale350Percent = 350,
    Scale400Percent = 400,
    Scale450Percent = 450,
    Scale500Percent = 500
  );
  PDisplay_ResolutionScale = ^Display_ResolutionScale;

  // Windows.Graphics.Imaging.BitmapInterpolationMode
  Imaging_BitmapInterpolationMode = (
    NearestNeighbor = 0,
    Linear = 1,
    Cubic = 2,
    Fant = 3
  );
  PImaging_BitmapInterpolationMode = ^Imaging_BitmapInterpolationMode;

  // Windows.Graphics.Imaging.BitmapFlip
  Imaging_BitmapFlip = (
    None = 0,
    Horizontal = 1,
    Vertical = 2
  );
  PImaging_BitmapFlip = ^Imaging_BitmapFlip;

  // Windows.Graphics.Imaging.BitmapRotation
  Imaging_BitmapRotation = (
    None = 0,
    Clockwise90Degrees = 1,
    Clockwise180Degrees = 2,
    Clockwise270Degrees = 3
  );
  PImaging_BitmapRotation = ^Imaging_BitmapRotation;

  // Windows.Graphics.Imaging.ColorManagementMode
  Imaging_ColorManagementMode = (
    DoNotColorManage = 0,
    ColorManageToSRgb = 1
  );
  PImaging_ColorManagementMode = ^Imaging_ColorManagementMode;

  // Windows.Graphics.Imaging.ExifOrientationMode
  Imaging_ExifOrientationMode = (
    IgnoreExifOrientation = 0,
    RespectExifOrientation = 1
  );
  PImaging_ExifOrientationMode = ^Imaging_ExifOrientationMode;

  // Windows.Graphics.Imaging.PngFilterMode
  Imaging_PngFilterMode = (
    Automatic = 0,
    None = 1,
    Sub = 2,
    Up = 3,
    Average = 4,
    Paeth = 5,
    Adaptive = 6
  );
  PImaging_PngFilterMode = ^Imaging_PngFilterMode;

  // Windows.Graphics.Imaging.TiffCompressionMode
  Imaging_TiffCompressionMode = (
    Automatic = 0,
    None = 1,
    Ccitt3 = 2,
    Ccitt4 = 3,
    Lzw = 4,
    Rle = 5,
    Zip = 6,
    LzwhDifferencing = 7
  );
  PImaging_TiffCompressionMode = ^Imaging_TiffCompressionMode;

  // Windows.Graphics.Imaging.JpegSubsamplingMode
  Imaging_JpegSubsamplingMode = (
    Default = 0,
    Y4Cb2Cr0 = 1,
    Y4Cb2Cr2 = 2,
    Y4Cb4Cr4 = 3
  );
  PImaging_JpegSubsamplingMode = ^Imaging_JpegSubsamplingMode;

  // Windows.Graphics.Imaging.BitmapPixelFormat
  Imaging_BitmapPixelFormat = (
    Unknown = 0,
    Rgba16 = 12,
    Rgba8 = 30,
    Gray16 = 57,
    Gray8 = 62,
    Bgra8 = 87,
    Nv12 = 103,
    Yuy2 = 107
  );
  PImaging_BitmapPixelFormat = ^Imaging_BitmapPixelFormat;

  // Windows.Graphics.Imaging.BitmapAlphaMode
  Imaging_BitmapAlphaMode = (
    Premultiplied = 0,
    Straight = 1,
    Ignore = 2
  );
  PImaging_BitmapAlphaMode = ^Imaging_BitmapAlphaMode;

  // Windows.Graphics.Imaging.BitmapBufferAccessMode
  Imaging_BitmapBufferAccessMode = (
    Read = 0,
    ReadWrite = 1,
    Write = 2
  );
  PImaging_BitmapBufferAccessMode = ^Imaging_BitmapBufferAccessMode;

  // Windows.Graphics.Printing.OptionDetails.PrintOptionStates
  Printing_OptionDetails_PrintOptionStates = (
    None = 0,
    Enabled = 1,
    Constrained = 2
  );
  PPrinting_OptionDetails_PrintOptionStates = ^Printing_OptionDetails_PrintOptionStates;

  // Windows.Graphics.Printing.OptionDetails.PrintOptionType
  Printing_OptionDetails_PrintOptionType = (
    Unknown = 0,
    Number = 1,
    Text = 2,
    ItemList = 3
  );
  PPrinting_OptionDetails_PrintOptionType = ^Printing_OptionDetails_PrintOptionType;

  // Windows.Graphics.Printing.PrintMediaSize
  Printing_PrintMediaSize = (
    Default = 0,
    NotAvailable = 1,
    PrinterCustom = 2,
    BusinessCard = 3,
    CreditCard = 4,
    IsoA0 = 5,
    IsoA1 = 6,
    IsoA10 = 7,
    IsoA2 = 8,
    IsoA3 = 9,
    IsoA3Extra = 10,
    IsoA3Rotated = 11,
    IsoA4 = 12,
    IsoA4Extra = 13,
    IsoA4Rotated = 14,
    IsoA5 = 15,
    IsoA5Extra = 16,
    IsoA5Rotated = 17,
    IsoA6 = 18,
    IsoA6Rotated = 19,
    IsoA7 = 20,
    IsoA8 = 21,
    IsoA9 = 22,
    IsoB0 = 23,
    IsoB1 = 24,
    IsoB10 = 25,
    IsoB2 = 26,
    IsoB3 = 27,
    IsoB4 = 28,
    IsoB4Envelope = 29,
    IsoB5Envelope = 30,
    IsoB5Extra = 31,
    IsoB7 = 32,
    IsoB8 = 33,
    IsoB9 = 34,
    IsoC0 = 35,
    IsoC1 = 36,
    IsoC10 = 37,
    IsoC2 = 38,
    IsoC3 = 39,
    IsoC3Envelope = 40,
    IsoC4 = 41,
    IsoC4Envelope = 42,
    IsoC5 = 43,
    IsoC5Envelope = 44,
    IsoC6 = 45,
    IsoC6C5Envelope = 46,
    IsoC6Envelope = 47,
    IsoC7 = 48,
    IsoC8 = 49,
    IsoC9 = 50,
    IsoDLEnvelope = 51,
    IsoDLEnvelopeRotated = 52,
    IsoSRA3 = 53,
    Japan2LPhoto = 54,
    JapanChou3Envelope = 55,
    JapanChou3EnvelopeRotated = 56,
    JapanChou4Envelope = 57,
    JapanChou4EnvelopeRotated = 58,
    JapanDoubleHagakiPostcard = 59,
    JapanDoubleHagakiPostcardRotated = 60,
    JapanHagakiPostcard = 61,
    JapanHagakiPostcardRotated = 62,
    JapanKaku2Envelope = 63,
    JapanKaku2EnvelopeRotated = 64,
    JapanKaku3Envelope = 65,
    JapanKaku3EnvelopeRotated = 66,
    JapanLPhoto = 67,
    JapanQuadrupleHagakiPostcard = 68,
    JapanYou1Envelope = 69,
    JapanYou2Envelope = 70,
    JapanYou3Envelope = 71,
    JapanYou4Envelope = 72,
    JapanYou4EnvelopeRotated = 73,
    JapanYou6Envelope = 74,
    JapanYou6EnvelopeRotated = 75,
    JisB0 = 76,
    JisB1 = 77,
    JisB10 = 78,
    JisB2 = 79,
    JisB3 = 80,
    JisB4 = 81,
    JisB4Rotated = 82,
    JisB5 = 83,
    JisB5Rotated = 84,
    JisB6 = 85,
    JisB6Rotated = 86,
    JisB7 = 87,
    JisB8 = 88,
    JisB9 = 89,
    NorthAmerica10x11 = 90,
    NorthAmerica10x12 = 91,
    NorthAmerica10x14 = 92,
    NorthAmerica11x17 = 93,
    NorthAmerica14x17 = 94,
    NorthAmerica4x6 = 95,
    NorthAmerica4x8 = 96,
    NorthAmerica5x7 = 97,
    NorthAmerica8x10 = 98,
    NorthAmerica9x11 = 99,
    NorthAmericaArchitectureASheet = 100,
    NorthAmericaArchitectureBSheet = 101,
    NorthAmericaArchitectureCSheet = 102,
    NorthAmericaArchitectureDSheet = 103,
    NorthAmericaArchitectureESheet = 104,
    NorthAmericaCSheet = 105,
    NorthAmericaDSheet = 106,
    NorthAmericaESheet = 107,
    NorthAmericaExecutive = 108,
    NorthAmericaGermanLegalFanfold = 109,
    NorthAmericaGermanStandardFanfold = 110,
    NorthAmericaLegal = 111,
    NorthAmericaLegalExtra = 112,
    NorthAmericaLetter = 113,
    NorthAmericaLetterExtra = 114,
    NorthAmericaLetterPlus = 115,
    NorthAmericaLetterRotated = 116,
    NorthAmericaMonarchEnvelope = 117,
    NorthAmericaNote = 118,
    NorthAmericaNumber10Envelope = 119,
    NorthAmericaNumber10EnvelopeRotated = 120,
    NorthAmericaNumber11Envelope = 121,
    NorthAmericaNumber12Envelope = 122,
    NorthAmericaNumber14Envelope = 123,
    NorthAmericaNumber9Envelope = 124,
    NorthAmericaPersonalEnvelope = 125,
    NorthAmericaQuarto = 126,
    NorthAmericaStatement = 127,
    NorthAmericaSuperA = 128,
    NorthAmericaSuperB = 129,
    NorthAmericaTabloid = 130,
    NorthAmericaTabloidExtra = 131,
    OtherMetricA3Plus = 132,
    OtherMetricA4Plus = 133,
    OtherMetricFolio = 134,
    OtherMetricInviteEnvelope = 135,
    OtherMetricItalianEnvelope = 136,
    Prc10Envelope = 137,
    Prc10EnvelopeRotated = 138,
    Prc16K = 139,
    Prc16KRotated = 140,
    Prc1Envelope = 141,
    Prc1EnvelopeRotated = 142,
    Prc2Envelope = 143,
    Prc2EnvelopeRotated = 144,
    Prc32K = 145,
    Prc32KBig = 146,
    Prc32KRotated = 147,
    Prc3Envelope = 148,
    Prc3EnvelopeRotated = 149,
    Prc4Envelope = 150,
    Prc4EnvelopeRotated = 151,
    Prc5Envelope = 152,
    Prc5EnvelopeRotated = 153,
    Prc6Envelope = 154,
    Prc6EnvelopeRotated = 155,
    Prc7Envelope = 156,
    Prc7EnvelopeRotated = 157,
    Prc8Envelope = 158,
    Prc8EnvelopeRotated = 159,
    Prc9Envelope = 160,
    Prc9EnvelopeRotated = 161,
    Roll04Inch = 162,
    Roll06Inch = 163,
    Roll08Inch = 164,
    Roll12Inch = 165,
    Roll15Inch = 166,
    Roll18Inch = 167,
    Roll22Inch = 168,
    Roll24Inch = 169,
    Roll30Inch = 170,
    Roll36Inch = 171,
    Roll54Inch = 172
  );
  PPrinting_PrintMediaSize = ^Printing_PrintMediaSize;

  // Windows.Graphics.Printing.PrintMediaType
  Printing_PrintMediaType = (
    Default = 0,
    NotAvailable = 1,
    PrinterCustom = 2,
    AutoSelect = 3,
    Archival = 4,
    BackPrintFilm = 5,
    Bond = 6,
    CardStock = 7,
    Continuous = 8,
    EnvelopePlain = 9,
    EnvelopeWindow = 10,
    Fabric = 11,
    HighResolution = 12,
    &Label = 13,
    MultiLayerForm = 14,
    MultiPartForm = 15,
    Photographic = 16,
    PhotographicFilm = 17,
    PhotographicGlossy = 18,
    PhotographicHighGloss = 19,
    PhotographicMatte = 20,
    PhotographicSatin = 21,
    PhotographicSemiGloss = 22,
    Plain = 23,
    Screen = 24,
    ScreenPaged = 25,
    Stationery = 26,
    TabStockFull = 27,
    TabStockPreCut = 28,
    Transparency = 29,
    TShirtTransfer = 30,
    None = 31
  );
  PPrinting_PrintMediaType = ^Printing_PrintMediaType;

  // Windows.Graphics.Printing.PrintOrientation
  Printing_PrintOrientation = (
    Default = 0,
    NotAvailable = 1,
    PrinterCustom = 2,
    Portrait = 3,
    PortraitFlipped = 4,
    Landscape = 5,
    LandscapeFlipped = 6
  );
  PPrinting_PrintOrientation = ^Printing_PrintOrientation;

  // Windows.Graphics.Printing.PrintQuality
  Printing_PrintQuality = (
    Default = 0,
    NotAvailable = 1,
    PrinterCustom = 2,
    Automatic = 3,
    Draft = 4,
    Fax = 5,
    High = 6,
    Normal = 7,
    Photographic = 8,
    Text = 9
  );
  PPrinting_PrintQuality = ^Printing_PrintQuality;

  // Windows.Graphics.Printing.PrintColorMode
  Printing_PrintColorMode = (
    Default = 0,
    NotAvailable = 1,
    PrinterCustom = 2,
    Color = 3,
    Grayscale = 4,
    Monochrome = 5
  );
  PPrinting_PrintColorMode = ^Printing_PrintColorMode;

  // Windows.Graphics.Printing.PrintDuplex
  Printing_PrintDuplex = (
    Default = 0,
    NotAvailable = 1,
    PrinterCustom = 2,
    OneSided = 3,
    TwoSidedShortEdge = 4,
    TwoSidedLongEdge = 5
  );
  PPrinting_PrintDuplex = ^Printing_PrintDuplex;

  // Windows.Graphics.Printing.PrintCollation
  Printing_PrintCollation = (
    Default = 0,
    NotAvailable = 1,
    PrinterCustom = 2,
    Collated = 3,
    Uncollated = 4
  );
  PPrinting_PrintCollation = ^Printing_PrintCollation;

  // Windows.Graphics.Printing.PrintStaple
  Printing_PrintStaple = (
    Default = 0,
    NotAvailable = 1,
    PrinterCustom = 2,
    None = 3,
    StapleTopLeft = 4,
    StapleTopRight = 5,
    StapleBottomLeft = 6,
    StapleBottomRight = 7,
    StapleDualLeft = 8,
    StapleDualRight = 9,
    StapleDualTop = 10,
    StapleDualBottom = 11,
    SaddleStitch = 12
  );
  PPrinting_PrintStaple = ^Printing_PrintStaple;

  // Windows.Graphics.Printing.PrintHolePunch
  Printing_PrintHolePunch = (
    Default = 0,
    NotAvailable = 1,
    PrinterCustom = 2,
    None = 3,
    LeftEdge = 4,
    RightEdge = 5,
    TopEdge = 6,
    BottomEdge = 7
  );
  PPrinting_PrintHolePunch = ^Printing_PrintHolePunch;

  // Windows.Graphics.Printing.PrintBinding
  Printing_PrintBinding = (
    Default = 0,
    NotAvailable = 1,
    PrinterCustom = 2,
    None = 3,
    Bale = 4,
    BindBottom = 5,
    BindLeft = 6,
    BindRight = 7,
    BindTop = 8,
    Booklet = 9,
    EdgeStitchBottom = 10,
    EdgeStitchLeft = 11,
    EdgeStitchRight = 12,
    EdgeStitchTop = 13,
    Fold = 14,
    JogOffset = 15,
    Trim = 16
  );
  PPrinting_PrintBinding = ^Printing_PrintBinding;

  // Windows.Graphics.Printing.PrintTaskCompletion
  Printing_PrintTaskCompletion = (
    Abandoned = 0,
    Canceled = 1,
    Failed = 2,
    Submitted = 3
  );
  PPrinting_PrintTaskCompletion = ^Printing_PrintTaskCompletion;

  // Windows.Graphics.DirectX.Direct3D11.Direct3DUsage
  DirectX_Direct3D11_Direct3DUsage = (
    Default = 0,
    Immutable = 1,
    Dynamic = 2,
    Staging = 3
  );
  PDirectX_Direct3D11_Direct3DUsage = ^DirectX_Direct3D11_Direct3DUsage;

  // Windows.Graphics.DirectX.Direct3D11.Direct3DBindings
  DirectX_Direct3D11_Direct3DBindings = (
    VertexBuffer = 1,
    IndexBuffer = 2,
    ConstantBuffer = 4,
    ShaderResource = 8,
    StreamOutput = 16,
    RenderTarget = 32,
    DepthStencil = 64,
    UnorderedAccess = 128,
    Decoder = 512,
    VideoEncoder = 1024
  );
  PDirectX_Direct3D11_Direct3DBindings = ^DirectX_Direct3D11_Direct3DBindings;

  // Windows.Graphics.DirectX.DirectXPixelFormat
  DirectX_DirectXPixelFormat = (
    Unknown = 0,
    R32G32B32A32Typeless = 1,
    R32G32B32A32Float = 2,
    R32G32B32A32UInt = 3,
    R32G32B32A32Int = 4,
    R32G32B32Typeless = 5,
    R32G32B32Float = 6,
    R32G32B32UInt = 7,
    R32G32B32Int = 8,
    R16G16B16A16Typeless = 9,
    R16G16B16A16Float = 10,
    R16G16B16A16UIntNormalized = 11,
    R16G16B16A16UInt = 12,
    R16G16B16A16IntNormalized = 13,
    R16G16B16A16Int = 14,
    R32G32Typeless = 15,
    R32G32Float = 16,
    R32G32UInt = 17,
    R32G32Int = 18,
    R32G8X24Typeless = 19,
    D32FloatS8X24UInt = 20,
    R32FloatX8X24Typeless = 21,
    X32TypelessG8X24UInt = 22,
    R10G10B10A2Typeless = 23,
    R10G10B10A2UIntNormalized = 24,
    R10G10B10A2UInt = 25,
    R11G11B10Float = 26,
    R8G8B8A8Typeless = 27,
    R8G8B8A8UIntNormalized = 28,
    R8G8B8A8UIntNormalizedSrgb = 29,
    R8G8B8A8UInt = 30,
    R8G8B8A8IntNormalized = 31,
    R8G8B8A8Int = 32,
    R16G16Typeless = 33,
    R16G16Float = 34,
    R16G16UIntNormalized = 35,
    R16G16UInt = 36,
    R16G16IntNormalized = 37,
    R16G16Int = 38,
    R32Typeless = 39,
    D32Float = 40,
    R32Float = 41,
    R32UInt = 42,
    R32Int = 43,
    R24G8Typeless = 44,
    D24UIntNormalizedS8UInt = 45,
    R24UIntNormalizedX8Typeless = 46,
    X24TypelessG8UInt = 47,
    R8G8Typeless = 48,
    R8G8UIntNormalized = 49,
    R8G8UInt = 50,
    R8G8IntNormalized = 51,
    R8G8Int = 52,
    R16Typeless = 53,
    R16Float = 54,
    D16UIntNormalized = 55,
    R16UIntNormalized = 56,
    R16UInt = 57,
    R16IntNormalized = 58,
    R16Int = 59,
    R8Typeless = 60,
    R8UIntNormalized = 61,
    R8UInt = 62,
    R8IntNormalized = 63,
    R8Int = 64,
    A8UIntNormalized = 65,
    R1UIntNormalized = 66,
    R9G9B9E5SharedExponent = 67,
    R8G8B8G8UIntNormalized = 68,
    G8R8G8B8UIntNormalized = 69,
    BC1Typeless = 70,
    BC1UIntNormalized = 71,
    BC1UIntNormalizedSrgb = 72,
    BC2Typeless = 73,
    BC2UIntNormalized = 74,
    BC2UIntNormalizedSrgb = 75,
    BC3Typeless = 76,
    BC3UIntNormalized = 77,
    BC3UIntNormalizedSrgb = 78,
    BC4Typeless = 79,
    BC4UIntNormalized = 80,
    BC4IntNormalized = 81,
    BC5Typeless = 82,
    BC5UIntNormalized = 83,
    BC5IntNormalized = 84,
    B5G6R5UIntNormalized = 85,
    B5G5R5A1UIntNormalized = 86,
    B8G8R8A8UIntNormalized = 87,
    B8G8R8X8UIntNormalized = 88,
    R10G10B10XRBiasA2UIntNormalized = 89,
    B8G8R8A8Typeless = 90,
    B8G8R8A8UIntNormalizedSrgb = 91,
    B8G8R8X8Typeless = 92,
    B8G8R8X8UIntNormalizedSrgb = 93,
    BC6HTypeless = 94,
    BC6H16UnsignedFloat = 95,
    BC6H16Float = 96,
    BC7Typeless = 97,
    BC7UIntNormalized = 98,
    BC7UIntNormalizedSrgb = 99,
    Ayuv = 100,
    Y410 = 101,
    Y416 = 102,
    NV12 = 103,
    P010 = 104,
    P016 = 105,
    Opaque420 = 106,
    Yuy2 = 107,
    Y210 = 108,
    Y216 = 109,
    NV11 = 110,
    AI44 = 111,
    IA44 = 112,
    P8 = 113,
    A8P8 = 114,
    B4G4R4A4UIntNormalized = 115,
    P208 = 130,
    V208 = 131,
    V408 = 132
  );
  PDirectX_DirectXPixelFormat = ^DirectX_DirectXPixelFormat;

  // Windows.Graphics.Printing3D.Print3DTaskDetail
  Printing3D_Print3DTaskDetail = (
    Unknown = 0,
    ModelExceedsPrintBed = 1,
    UploadFailed = 2,
    InvalidMaterialSelection = 3,
    InvalidModel = 4,
    ModelNotManifold = 5,
    InvalidPrintTicket = 6
  );
  PPrinting3D_Print3DTaskDetail = ^Printing3D_Print3DTaskDetail;

  // Windows.Graphics.Printing3D.Print3DTaskCompletion
  Printing3D_Print3DTaskCompletion = (
    Abandoned = 0,
    Canceled = 1,
    Failed = 2,
    Slicing = 3,
    Submitted = 4
  );
  PPrinting3D_Print3DTaskCompletion = ^Printing3D_Print3DTaskCompletion;

  // Windows.Graphics.Printing3D.Printing3DBufferFormat
  Printing3D_Printing3DBufferFormat = (
    Unknown = 0,
    R32G32B32A32Float = 2,
    R32G32B32A32UInt = 3,
    R32G32B32Float = 6,
    R32G32B32UInt = 7
  );
  PPrinting3D_Printing3DBufferFormat = ^Printing3D_Printing3DBufferFormat;

  // Windows.Graphics.Printing3D.Printing3DMeshVerificationMode
  Printing3D_Printing3DMeshVerificationMode = (
    FindFirstError = 0,
    FindAllErrors = 1
  );
  PPrinting3D_Printing3DMeshVerificationMode = ^Printing3D_Printing3DMeshVerificationMode;

  // Windows.Graphics.Printing3D.Printing3DModelUnit
  Printing3D_Printing3DModelUnit = (
    Meter = 0,
    Micron = 1,
    Millimeter = 2,
    Centimeter = 3,
    Inch = 4,
    Foot = 5
  );
  PPrinting3D_Printing3DModelUnit = ^Printing3D_Printing3DModelUnit;

  // Windows.Graphics.Printing3D.Printing3DTextureEdgeBehavior
  Printing3D_Printing3DTextureEdgeBehavior = (
    None = 0,
    Wrap = 1,
    Mirror = 2,
    Clamp = 3
  );
  PPrinting3D_Printing3DTextureEdgeBehavior = ^Printing3D_Printing3DTextureEdgeBehavior;

  // Windows.Graphics.Printing3D.Printing3DObjectType
  Printing3D_Printing3DObjectType = (
    Model = 0,
    Support = 1,
    Others = 2
  );
  PPrinting3D_Printing3DObjectType = ^Printing3D_Printing3DObjectType;


  // Windows.Graphics Records
  // Windows.Graphics.Imaging.BitmapBounds
  Imaging_BitmapBounds = record
    X: Cardinal;
    Y: Cardinal;
    Width: Cardinal;
    Height: Cardinal;
  end;
  PImaging_BitmapBounds = ^Imaging_BitmapBounds;

  // Windows.Graphics.Imaging.BitmapSize
  Imaging_BitmapSize = record
    Width: Cardinal;
    Height: Cardinal;
  end;
  PImaging_BitmapSize = ^Imaging_BitmapSize;

  // Windows.Graphics.Imaging.BitmapPlaneDescription
  Imaging_BitmapPlaneDescription = record
    StartIndex: Integer;
    Width: Integer;
    Height: Integer;
    Stride: Integer;
  end;
  PImaging_BitmapPlaneDescription = ^Imaging_BitmapPlaneDescription;

  // Windows.Graphics.Printing.PrintPageDescription
  Printing_PrintPageDescription = record
    PageSize: TSizeF;
    ImageableRect: TRectF;
    DpiX: Cardinal;
    DpiY: Cardinal;
  end;
  PPrinting_PrintPageDescription = ^Printing_PrintPageDescription;

  // Windows.Graphics.DirectX.Direct3D11.Direct3DMultisampleDescription
  DirectX_Direct3D11_Direct3DMultisampleDescription = record
    Count: Integer;
    Quality: Integer;
  end;
  PDirectX_Direct3D11_Direct3DMultisampleDescription = ^DirectX_Direct3D11_Direct3DMultisampleDescription;

  // Windows.Graphics.DirectX.Direct3D11.Direct3DSurfaceDescription
  DirectX_Direct3D11_Direct3DSurfaceDescription = record
    Width: Integer;
    Height: Integer;
    Format: DirectX_DirectXPixelFormat;
    MultisampleDescription: DirectX_Direct3D11_Direct3DMultisampleDescription;
  end;
  PDirectX_Direct3D11_Direct3DSurfaceDescription = ^DirectX_Direct3D11_Direct3DSurfaceDescription;

  // Windows.Graphics.Printing3D.Printing3DContract
  Printing3D_Printing3DContract = record
  end;
  PPrinting3D_Printing3DContract = ^Printing3D_Printing3DContract;

  // Windows.Graphics.Printing3D.Printing3DBufferDescription
  Printing3D_Printing3DBufferDescription = record
    Format: Printing3D_Printing3DBufferFormat;
    Stride: Cardinal;
  end;
  PPrinting3D_Printing3DBufferDescription = ^Printing3D_Printing3DBufferDescription;



  // Windows.Management Enums
  // Windows.Management.Deployment.DeploymentProgressState
  Deployment_DeploymentProgressState = (
    Queued = 0,
    Processing = 1
  );
  PDeployment_DeploymentProgressState = ^Deployment_DeploymentProgressState;

  // Windows.Management.Deployment.DeploymentOptions
  Deployment_DeploymentOptions = (
    None = 0,
    ForceApplicationShutdown = 1,
    DevelopmentMode = 2,
    InstallAllResources = 32,
    ForceTargetApplicationShutdown = 64
  );
  PDeployment_DeploymentOptions = ^Deployment_DeploymentOptions;

  // Windows.Management.Deployment.RemovalOptions
  Deployment_RemovalOptions = (
    None = 0,
    PreserveApplicationData = 4096
  );
  PDeployment_RemovalOptions = ^Deployment_RemovalOptions;

  // Windows.Management.Deployment.PackageTypes
  Deployment_PackageTypes = (
    None = 0,
    Main = 1,
    Framework = 2,
    Resource = 4,
    Bundle = 8,
    Xap = 16
  );
  PDeployment_PackageTypes = ^Deployment_PackageTypes;

  // Windows.Management.Deployment.PackageInstallState
  Deployment_PackageInstallState = (
    NotInstalled = 0,
    Staged = 1,
    Installed = 2
  );
  PDeployment_PackageInstallState = ^Deployment_PackageInstallState;

  // Windows.Management.Deployment.PackageState
  Deployment_PackageState = (
    Normal = 0,
    LicenseInvalid = 1,
    Modified = 2,
    Tampered = 3
  );
  PDeployment_PackageState = ^Deployment_PackageState;

  // Windows.Management.Deployment.PackageStatus
  Deployment_PackageStatus = (
    OK = 0,
    LicenseIssue = 1,
    Modified = 2,
    Tampered = 4,
    Disabled = 8
  );
  PDeployment_PackageStatus = ^Deployment_PackageStatus;


  // Windows.Management Records
  // Windows.Management.Deployment.DeploymentProgress
  Deployment_DeploymentProgress = record
    state: Deployment_DeploymentProgressState;
    percentage: Cardinal;
  end;
  PDeployment_DeploymentProgress = ^Deployment_DeploymentProgress;

  // Windows.Management.Deployment.Preview.DeploymentPreviewContract
  Deployment_Preview_DeploymentPreviewContract = record
  end;
  PDeployment_Preview_DeploymentPreviewContract = ^Deployment_Preview_DeploymentPreviewContract;

  // Windows.Management.Workplace.WorkplaceSettingsContract
  Workplace_WorkplaceSettingsContract = record
  end;
  PWorkplace_WorkplaceSettingsContract = ^Workplace_WorkplaceSettingsContract;



  // Windows.Media Enums
  // Windows.Media.Capture.CameraCaptureUIMode
  Capture_CameraCaptureUIMode = (
    PhotoOrVideo = 0,
    Photo = 1,
    Video = 2
  );
  PCapture_CameraCaptureUIMode = ^Capture_CameraCaptureUIMode;

  // Windows.Media.Capture.CameraCaptureUIPhotoFormat
  Capture_CameraCaptureUIPhotoFormat = (
    Jpeg = 0,
    Png = 1,
    JpegXR = 2
  );
  PCapture_CameraCaptureUIPhotoFormat = ^Capture_CameraCaptureUIPhotoFormat;

  // Windows.Media.Capture.CameraCaptureUIVideoFormat
  Capture_CameraCaptureUIVideoFormat = (
    Mp4 = 0,
    Wmv = 1
  );
  PCapture_CameraCaptureUIVideoFormat = ^Capture_CameraCaptureUIVideoFormat;

  // Windows.Media.Capture.CameraCaptureUIMaxVideoResolution
  Capture_CameraCaptureUIMaxVideoResolution = (
    HighestAvailable = 0,
    LowDefinition = 1,
    StandardDefinition = 2,
    HighDefinition = 3
  );
  PCapture_CameraCaptureUIMaxVideoResolution = ^Capture_CameraCaptureUIMaxVideoResolution;

  // Windows.Media.Capture.CameraCaptureUIMaxPhotoResolution
  Capture_CameraCaptureUIMaxPhotoResolution = (
    HighestAvailable = 0,
    VerySmallQvga = 1,
    SmallVga = 2,
    MediumXga = 3,
    Large3M = 4,
    VeryLarge5M = 5
  );
  PCapture_CameraCaptureUIMaxPhotoResolution = ^Capture_CameraCaptureUIMaxPhotoResolution;

  // Windows.Media.AudioBufferAccessMode
  AudioBufferAccessMode = (
    Read = 0,
    ReadWrite = 1,
    Write = 2
  );
  PAudioBufferAccessMode = ^AudioBufferAccessMode;

  // Windows.Media.Audio.AudioGraphCreationStatus
  Audio_AudioGraphCreationStatus = (
    Success = 0,
    DeviceNotAvailable = 1,
    FormatNotSupported = 2,
    UnknownFailure = 3
  );
  PAudio_AudioGraphCreationStatus = ^Audio_AudioGraphCreationStatus;

  // Windows.Media.Audio.QuantumSizeSelectionMode
  Audio_QuantumSizeSelectionMode = (
    SystemDefault = 0,
    LowestLatency = 1,
    ClosestToDesired = 2
  );
  PAudio_QuantumSizeSelectionMode = ^Audio_QuantumSizeSelectionMode;

  // Windows.Media.Audio.AudioDeviceNodeCreationStatus
  Audio_AudioDeviceNodeCreationStatus = (
    Success = 0,
    DeviceNotAvailable = 1,
    FormatNotSupported = 2,
    UnknownFailure = 3,
    AccessDenied = 4
  );
  PAudio_AudioDeviceNodeCreationStatus = ^Audio_AudioDeviceNodeCreationStatus;

  // Windows.Media.Audio.AudioFileNodeCreationStatus
  Audio_AudioFileNodeCreationStatus = (
    Success = 0,
    FileNotFound = 1,
    InvalidFileType = 2,
    FormatNotSupported = 3,
    UnknownFailure = 4
  );
  PAudio_AudioFileNodeCreationStatus = ^Audio_AudioFileNodeCreationStatus;

  // Windows.Media.Audio.AudioGraphUnrecoverableError
  Audio_AudioGraphUnrecoverableError = (
    None = 0,
    AudioDeviceLost = 1,
    AudioSessionDisconnected = 2,
    UnknownFailure = 3
  );
  PAudio_AudioGraphUnrecoverableError = ^Audio_AudioGraphUnrecoverableError;

  // Windows.Media.Casting.CastingPlaybackTypes
  Casting_CastingPlaybackTypes = (
    None = 0,
    Audio = 1,
    Video = 2,
    Picture = 4
  );
  PCasting_CastingPlaybackTypes = ^Casting_CastingPlaybackTypes;

  // Windows.Media.Casting.CastingConnectionErrorStatus
  Casting_CastingConnectionErrorStatus = (
    Succeeded = 0,
    DeviceDidNotRespond = 1,
    DeviceError = 2,
    DeviceLocked = 3,
    ProtectedPlaybackFailed = 4,
    InvalidCastingSource = 5,
    Unknown = 6
  );
  PCasting_CastingConnectionErrorStatus = ^Casting_CastingConnectionErrorStatus;

  // Windows.Media.Casting.CastingConnectionState
  Casting_CastingConnectionState = (
    Disconnected = 0,
    Connected = 1,
    Rendering = 2,
    Disconnecting = 3,
    Connecting = 4
  );
  PCasting_CastingConnectionState = ^Casting_CastingConnectionState;

  // Windows.Media.DialProtocol.DialAppState
  DialProtocol_DialAppState = (
    Unknown = 0,
    Stopped = 1,
    Running = 2,
    NetworkFailure = 3
  );
  PDialProtocol_DialAppState = ^DialProtocol_DialAppState;

  // Windows.Media.DialProtocol.DialAppLaunchResult
  DialProtocol_DialAppLaunchResult = (
    Launched = 0,
    FailedToLaunch = 1,
    NotFound = 2,
    NetworkFailure = 3
  );
  PDialProtocol_DialAppLaunchResult = ^DialProtocol_DialAppLaunchResult;

  // Windows.Media.DialProtocol.DialAppStopResult
  DialProtocol_DialAppStopResult = (
    Stopped = 0,
    StopFailed = 1,
    OperationNotSupported = 2,
    NetworkFailure = 3
  );
  PDialProtocol_DialAppStopResult = ^DialProtocol_DialAppStopResult;

  // Windows.Media.DialProtocol.DialDeviceDisplayStatus
  DialProtocol_DialDeviceDisplayStatus = (
    None = 0,
    Connecting = 1,
    Connected = 2,
    Disconnecting = 3,
    Disconnected = 4,
    Error = 5
  );
  PDialProtocol_DialDeviceDisplayStatus = ^DialProtocol_DialDeviceDisplayStatus;

  // Windows.Media.Editing.VideoFramePrecision
  Editing_VideoFramePrecision = (
    NearestFrame = 0,
    NearestKeyFrame = 1
  );
  PEditing_VideoFramePrecision = ^Editing_VideoFramePrecision;

  // Windows.Media.Editing.MediaTrimmingPreference
  Editing_MediaTrimmingPreference = (
    Fast = 0,
    Precise = 1
  );
  PEditing_MediaTrimmingPreference = ^Editing_MediaTrimmingPreference;

  // Windows.Media.Render.AudioRenderCategory
  Render_AudioRenderCategory = (
    Other = 0,
    ForegroundOnlyMedia = 1,
    BackgroundCapableMedia = 2,
    Communications = 3,
    Alerts = 4,
    SoundEffects = 5,
    GameEffects = 6,
    GameMedia = 7,
    GameChat = 8,
    Speech = 9,
    Movie = 10,
    Media = 11
  );
  PRender_AudioRenderCategory = ^Render_AudioRenderCategory;

  // Windows.Media.Effects.AudioEffectType
  Effects_AudioEffectType = (
    Other = 0,
    AcousticEchoCancellation = 1,
    NoiseSuppression = 2,
    AutomaticGainControl = 3,
    BeamForming = 4,
    ConstantToneRemoval = 5,
    Equalizer = 6,
    LoudnessEqualizer = 7,
    BassBoost = 8,
    VirtualSurround = 9,
    VirtualHeadphones = 10,
    SpeakerFill = 11,
    RoomCorrection = 12,
    BassManagement = 13,
    EnvironmentalEffects = 14,
    SpeakerProtection = 15,
    SpeakerCompensation = 16,
    DynamicRangeCompression = 17
  );
  PEffects_AudioEffectType = ^Effects_AudioEffectType;

  // Windows.Media.Import.PhotoImportStage
  Import_PhotoImportStage = (
    NotStarted = 0,
    FindingItems = 1,
    ImportingItems = 2,
    DeletingImportedItemsFromSource = 3
  );
  PImport_PhotoImportStage = ^Import_PhotoImportStage;

  // Windows.Media.Import.PhotoImportAccessMode
  Import_PhotoImportAccessMode = (
    ReadWrite = 0,
    ReadOnly = 1,
    ReadAndDelete = 2
  );
  PImport_PhotoImportAccessMode = ^Import_PhotoImportAccessMode;

  // Windows.Media.Import.PhotoImportImportMode
  Import_PhotoImportImportMode = (
    ImportEverything = 0,
    IgnoreSidecars = 1,
    IgnoreSiblings = 2,
    IgnoreSidecarsAndSiblings = 3
  );
  PImport_PhotoImportImportMode = ^Import_PhotoImportImportMode;

  // Windows.Media.Import.PhotoImportSourceType
  Import_PhotoImportSourceType = (
    Generic = 0,
    Camera = 1,
    MediaPlayer = 2,
    Phone = 3,
    Video = 4,
    PersonalInfoManager = 5,
    AudioRecorder = 6
  );
  PImport_PhotoImportSourceType = ^Import_PhotoImportSourceType;

  // Windows.Media.Import.PhotoImportContentType
  Import_PhotoImportContentType = (
    Unknown = 0,
    Image = 1,
    Video = 2
  );
  PImport_PhotoImportContentType = ^Import_PhotoImportContentType;

  // Windows.Media.Import.PhotoImportPowerSource
  Import_PhotoImportPowerSource = (
    Unknown = 0,
    Battery = 1,
    External = 2
  );
  PImport_PhotoImportPowerSource = ^Import_PhotoImportPowerSource;

  // Windows.Media.Import.PhotoImportStorageMediumType
  Import_PhotoImportStorageMediumType = (
    Undefined = 0,
    Fixed = 1,
    Removable = 2
  );
  PImport_PhotoImportStorageMediumType = ^Import_PhotoImportStorageMediumType;

  // Windows.Media.Import.PhotoImportContentTypeFilter
  Import_PhotoImportContentTypeFilter = (
    OnlyImages = 0,
    OnlyVideos = 1,
    ImagesAndVideos = 2
  );
  PImport_PhotoImportContentTypeFilter = ^Import_PhotoImportContentTypeFilter;

  // Windows.Media.Import.PhotoImportItemSelectionMode
  Import_PhotoImportItemSelectionMode = (
    SelectAll = 0,
    SelectNone = 1,
    SelectNew = 2
  );
  PImport_PhotoImportItemSelectionMode = ^Import_PhotoImportItemSelectionMode;

  // Windows.Media.Import.PhotoImportConnectionTransport
  Import_PhotoImportConnectionTransport = (
    Unknown = 0,
    Usb = 1,
    IP = 2,
    Bluetooth = 3
  );
  PImport_PhotoImportConnectionTransport = ^Import_PhotoImportConnectionTransport;

  // Windows.Media.Import.PhotoImportSubfolderCreationMode
  Import_PhotoImportSubfolderCreationMode = (
    DoNotCreateSubfolders = 0,
    CreateSubfoldersFromFileDate = 1,
    CreateSubfoldersFromExifDate = 2,
    KeepOriginalFolderStructure = 3
  );
  PImport_PhotoImportSubfolderCreationMode = ^Import_PhotoImportSubfolderCreationMode;

  // Windows.Media.SoundLevel
  SoundLevel = (
    Muted = 0,
    Low = 1,
    Full = 2
  );
  PSoundLevel = ^SoundLevel;

  // Windows.Media.Playback.MediaPlayerState
  Playback_MediaPlayerState = (
    Closed = 0,
    Opening = 1,
    Buffering = 2,
    Playing = 3,
    Paused = 4,
    Stopped = 5
  );
  PPlayback_MediaPlayerState = ^Playback_MediaPlayerState;

  // Windows.Media.Playback.MediaPlayerError
  Playback_MediaPlayerError = (
    Unknown = 0,
    Aborted = 1,
    NetworkError = 2,
    DecodingError = 3,
    SourceNotSupported = 4
  );
  PPlayback_MediaPlayerError = ^Playback_MediaPlayerError;

  // Windows.Media.Playback.MediaPlayerAudioCategory
  Playback_MediaPlayerAudioCategory = (
    Other = 0,
    Communications = 3,
    Alerts = 4,
    SoundEffects = 5,
    GameEffects = 6,
    GameMedia = 7,
    GameChat = 8,
    Speech = 9,
    Movie = 10,
    Media = 11
  );
  PPlayback_MediaPlayerAudioCategory = ^Playback_MediaPlayerAudioCategory;

  // Windows.Media.Playback.MediaPlayerAudioDeviceType
  Playback_MediaPlayerAudioDeviceType = (
    Console = 0,
    Multimedia = 1,
    Communications = 2
  );
  PPlayback_MediaPlayerAudioDeviceType = ^Playback_MediaPlayerAudioDeviceType;

  // Windows.Media.PlayTo.PlayToConnectionState
  PlayTo_PlayToConnectionState = (
    Disconnected = 0,
    Connected = 1,
    Rendering = 2
  );
  PPlayTo_PlayToConnectionState = ^PlayTo_PlayToConnectionState;

  // Windows.Media.PlayTo.PlayToConnectionError
  PlayTo_PlayToConnectionError = (
    None = 0,
    DeviceNotResponding = 1,
    DeviceError = 2,
    DeviceLocked = 3,
    ProtectedPlaybackFailed = 4
  );
  PPlayTo_PlayToConnectionError = ^PlayTo_PlayToConnectionError;

  // Windows.Media.Protection.PlayReady.PlayReadyDecryptorSetup
  Protection_PlayReady_PlayReadyDecryptorSetup = (
    Uninitialized = 0,
    OnDemand = 1
  );
  PProtection_PlayReady_PlayReadyDecryptorSetup = ^Protection_PlayReady_PlayReadyDecryptorSetup;

  // Windows.Media.Protection.PlayReady.PlayReadyEncryptionAlgorithm
  Protection_PlayReady_PlayReadyEncryptionAlgorithm = (
    Unprotected = 0,
    Aes128Ctr = 1,
    Cocktail = 4,
    Uninitialized = 2147483647
  );
  PProtection_PlayReady_PlayReadyEncryptionAlgorithm = ^Protection_PlayReady_PlayReadyEncryptionAlgorithm;

  // Windows.Media.Protection.PlayReady.PlayReadyHardwareDRMFeatures
  Protection_PlayReady_PlayReadyHardwareDRMFeatures = (
    HardwareDRM = 1,
    HEVC = 2
  );
  PProtection_PlayReady_PlayReadyHardwareDRMFeatures = ^Protection_PlayReady_PlayReadyHardwareDRMFeatures;

  // Windows.Media.Protection.PlayReady.PlayReadyITADataFormat
  Protection_PlayReady_PlayReadyITADataFormat = (
    SerializedProperties = 0,
    SerializedProperties_WithContentProtectionWrapper = 1
  );
  PProtection_PlayReady_PlayReadyITADataFormat = ^Protection_PlayReady_PlayReadyITADataFormat;

  // Windows.Media.Protection.PlayReady.NDCertificateType
  Protection_PlayReady_NDCertificateType = (
    Unknown = 0,
    PC = 1,
    Device = 2,
    Domain = 3,
    Issuer = 4,
    CrlSigner = 5,
    Service = 6,
    Silverlight = 7,
    Application = 8,
    Metering = 9,
    KeyFileSigner = 10,
    Server = 11,
    LicenseSigner = 12
  );
  PProtection_PlayReady_NDCertificateType = ^Protection_PlayReady_NDCertificateType;

  // Windows.Media.Protection.PlayReady.NDCertificatePlatformID
  Protection_PlayReady_NDCertificatePlatformID = (
    Windows = 0,
    OSX = 1,
    WindowsOnARM = 2,
    WindowsMobile7 = 5,
    iOSOnARM = 6,
    XBoxOnPPC = 7,
    WindowsPhone8OnARM = 8,
    WindowsPhone8OnX86 = 9,
    XboxOne = 10,
    AndroidOnARM = 11,
    WindowsPhone81OnARM = 12,
    WindowsPhone81OnX86 = 13
  );
  PProtection_PlayReady_NDCertificatePlatformID = ^Protection_PlayReady_NDCertificatePlatformID;

  // Windows.Media.Protection.PlayReady.NDCertificateFeature
  Protection_PlayReady_NDCertificateFeature = (
    Transmitter = 1,
    Receiver = 2,
    SharedCertificate = 3,
    SecureClock = 4,
    AntiRollBackClock = 5,
    CRLS = 9,
    PlayReady3Features = 13
  );
  PProtection_PlayReady_NDCertificateFeature = ^Protection_PlayReady_NDCertificateFeature;

  // Windows.Media.Protection.PlayReady.NDProximityDetectionType
  Protection_PlayReady_NDProximityDetectionType = (
    UDP = 1,
    TCP = 2,
    TransportAgnostic = 4
  );
  PProtection_PlayReady_NDProximityDetectionType = ^Protection_PlayReady_NDProximityDetectionType;

  // Windows.Media.Protection.PlayReady.NDMediaStreamType
  Protection_PlayReady_NDMediaStreamType = (
    Audio = 1,
    Video = 2
  );
  PProtection_PlayReady_NDMediaStreamType = ^Protection_PlayReady_NDMediaStreamType;

  // Windows.Media.Protection.PlayReady.NDContentIDType
  Protection_PlayReady_NDContentIDType = (
    KeyID = 1,
    PlayReadyObject = 2,
    Custom = 3
  );
  PProtection_PlayReady_NDContentIDType = ^Protection_PlayReady_NDContentIDType;

  // Windows.Media.Protection.PlayReady.NDClosedCaptionFormat
  Protection_PlayReady_NDClosedCaptionFormat = (
    ATSC = 0,
    SCTE20 = 1,
    Unknown = 2
  );
  PProtection_PlayReady_NDClosedCaptionFormat = ^Protection_PlayReady_NDClosedCaptionFormat;

  // Windows.Media.Protection.PlayReady.NDStartAsyncOptions
  Protection_PlayReady_NDStartAsyncOptions = (
    MutualAuthentication = 1,
    WaitForLicenseDescriptor = 2
  );
  PProtection_PlayReady_NDStartAsyncOptions = ^Protection_PlayReady_NDStartAsyncOptions;

  // Windows.Media.SpeechRecognition.SpeechRecognitionConstraintProbability
  SpeechRecognition_SpeechRecognitionConstraintProbability = (
    Default = 0,
    Min = 1,
    Max = 2
  );
  PSpeechRecognition_SpeechRecognitionConstraintProbability = ^SpeechRecognition_SpeechRecognitionConstraintProbability;

  // Windows.Media.SpeechRecognition.SpeechRecognitionConfidence
  SpeechRecognition_SpeechRecognitionConfidence = (
    High = 0,
    Medium = 1,
    Low = 2,
    Rejected = 3
  );
  PSpeechRecognition_SpeechRecognitionConfidence = ^SpeechRecognition_SpeechRecognitionConfidence;

  // Windows.Media.SpeechRecognition.SpeechRecognitionScenario
  SpeechRecognition_SpeechRecognitionScenario = (
    WebSearch = 0,
    Dictation = 1,
    FormFilling = 2
  );
  PSpeechRecognition_SpeechRecognitionScenario = ^SpeechRecognition_SpeechRecognitionScenario;

  // Windows.Media.SpeechRecognition.SpeechRecognitionConstraintType
  SpeechRecognition_SpeechRecognitionConstraintType = (
    Topic = 0,
    List = 1,
    Grammar = 2,
    VoiceCommandDefinition = 3
  );
  PSpeechRecognition_SpeechRecognitionConstraintType = ^SpeechRecognition_SpeechRecognitionConstraintType;

  // Windows.Media.SpeechRecognition.SpeechRecognizerState
  SpeechRecognition_SpeechRecognizerState = (
    Idle = 0,
    Capturing = 1,
    Processing = 2,
    SoundStarted = 3,
    SoundEnded = 4,
    SpeechDetected = 5,
    Paused = 6
  );
  PSpeechRecognition_SpeechRecognizerState = ^SpeechRecognition_SpeechRecognizerState;

  // Windows.Media.SpeechRecognition.SpeechRecognitionAudioProblem
  SpeechRecognition_SpeechRecognitionAudioProblem = (
    None = 0,
    TooNoisy = 1,
    NoSignal = 2,
    TooLoud = 3,
    TooQuiet = 4,
    TooFast = 5,
    TooSlow = 6
  );
  PSpeechRecognition_SpeechRecognitionAudioProblem = ^SpeechRecognition_SpeechRecognitionAudioProblem;

  // Windows.Media.SpeechRecognition.SpeechRecognitionResultStatus
  SpeechRecognition_SpeechRecognitionResultStatus = (
    Success = 0,
    TopicLanguageNotSupported = 1,
    GrammarLanguageMismatch = 2,
    GrammarCompilationFailure = 3,
    AudioQualityFailure = 4,
    UserCanceled = 5,
    Unknown = 6,
    TimeoutExceeded = 7,
    PauseLimitExceeded = 8,
    NetworkFailure = 9,
    MicrophoneUnavailable = 10
  );
  PSpeechRecognition_SpeechRecognitionResultStatus = ^SpeechRecognition_SpeechRecognitionResultStatus;

  // Windows.Media.SpeechRecognition.SpeechContinuousRecognitionMode
  SpeechRecognition_SpeechContinuousRecognitionMode = (
    Default = 0,
    PauseOnRecognition = 1
  );
  PSpeechRecognition_SpeechContinuousRecognitionMode = ^SpeechRecognition_SpeechContinuousRecognitionMode;

  // Windows.Media.SpeechSynthesis.VoiceGender
  SpeechSynthesis_VoiceGender = (
    Male = 0,
    Female = 1
  );
  PSpeechSynthesis_VoiceGender = ^SpeechSynthesis_VoiceGender;

  // Windows.Media.MediaPlaybackType
  MediaPlaybackType = (
    Unknown = 0,
    Music = 1,
    Video = 2,
    Image = 3
  );
  PMediaPlaybackType = ^MediaPlaybackType;

  // Windows.Media.MediaPlaybackAutoRepeatMode
  MediaPlaybackAutoRepeatMode = (
    None = 0,
    Track = 1,
    List = 2
  );
  PMediaPlaybackAutoRepeatMode = ^MediaPlaybackAutoRepeatMode;

  // Windows.Media.MediaPlaybackStatus
  MediaPlaybackStatus = (
    Closed = 0,
    Changing = 1,
    Stopped = 2,
    Playing = 3,
    Paused = 4
  );
  PMediaPlaybackStatus = ^MediaPlaybackStatus;

  // Windows.Media.SystemMediaTransportControlsButton
  SystemMediaTransportControlsButton = (
    Play = 0,
    Pause = 1,
    Stop = 2,
    &Record = 3,
    FastForward = 4,
    Rewind = 5,
    Next = 6,
    Previous = 7,
    ChannelUp = 8,
    ChannelDown = 9
  );
  PSystemMediaTransportControlsButton = ^SystemMediaTransportControlsButton;

  // Windows.Media.SystemMediaTransportControlsProperty
  SystemMediaTransportControlsProperty = (
    SoundLevel = 0
  );
  PSystemMediaTransportControlsProperty = ^SystemMediaTransportControlsProperty;

  // Windows.Media.AudioProcessing
  AudioProcessing = (
    Default = 0,
    Raw = 1
  );
  PAudioProcessing = ^AudioProcessing;

  // Windows.Media.Transcoding.MediaVideoProcessingAlgorithm
  Transcoding_MediaVideoProcessingAlgorithm = (
    Default = 0,
    MrfCrf444 = 1
  );
  PTranscoding_MediaVideoProcessingAlgorithm = ^Transcoding_MediaVideoProcessingAlgorithm;

  // Windows.Media.Capture.MediaCategory
  Capture_MediaCategory = (
    Other = 0,
    Communications = 1,
    Media = 2,
    GameChat = 3,
    Speech = 4
  );
  PCapture_MediaCategory = ^Capture_MediaCategory;

  // Windows.Media.Capture.MediaStreamType
  Capture_MediaStreamType = (
    VideoPreview = 0,
    VideoRecord = 1,
    Audio = 2,
    Photo = 3
  );
  PCapture_MediaStreamType = ^Capture_MediaStreamType;

  // Windows.Media.Capture.StreamingCaptureMode
  Capture_StreamingCaptureMode = (
    AudioAndVideo = 0,
    Audio = 1,
    Video = 2
  );
  PCapture_StreamingCaptureMode = ^Capture_StreamingCaptureMode;

  // Windows.Media.Capture.VideoRotation
  Capture_VideoRotation = (
    None = 0,
    Clockwise90Degrees = 1,
    Clockwise180Degrees = 2,
    Clockwise270Degrees = 3
  );
  PCapture_VideoRotation = ^Capture_VideoRotation;

  // Windows.Media.Capture.PhotoCaptureSource
  Capture_PhotoCaptureSource = (
    Auto = 0,
    VideoPreview = 1,
    Photo = 2
  );
  PCapture_PhotoCaptureSource = ^Capture_PhotoCaptureSource;

  // Windows.Media.Capture.VideoDeviceCharacteristic
  Capture_VideoDeviceCharacteristic = (
    AllStreamsIndependent = 0,
    PreviewRecordStreamsIdentical = 1,
    PreviewPhotoStreamsIdentical = 2,
    RecordPhotoStreamsIdentical = 3,
    AllStreamsIdentical = 4
  );
  PCapture_VideoDeviceCharacteristic = ^Capture_VideoDeviceCharacteristic;

  // Windows.Media.Capture.PowerlineFrequency
  Capture_PowerlineFrequency = (
    Disabled = 0,
    FiftyHertz = 1,
    SixtyHertz = 2
  );
  PCapture_PowerlineFrequency = ^Capture_PowerlineFrequency;

  // Windows.Media.Capture.MediaCaptureThermalStatus
  Capture_MediaCaptureThermalStatus = (
    Normal = 0,
    Overheated = 1
  );
  PCapture_MediaCaptureThermalStatus = ^Capture_MediaCaptureThermalStatus;

  // Windows.Media.Capture.KnownVideoProfile
  Capture_KnownVideoProfile = (
    VideoRecording = 0,
    HighQualityPhoto = 1,
    BalancedVideoAndPhoto = 2,
    VideoConferencing = 3,
    PhotoSequence = 4
  );
  PCapture_KnownVideoProfile = ^Capture_KnownVideoProfile;

  // Windows.Media.Effects.MediaMemoryTypes
  Effects_MediaMemoryTypes = (
    Gpu = 0,
    Cpu = 1,
    GpuAndCpu = 2
  );
  PEffects_MediaMemoryTypes = ^Effects_MediaMemoryTypes;

  // Windows.Media.Effects.MediaEffectClosedReason
  Effects_MediaEffectClosedReason = (
    Done = 0,
    UnknownError = 1,
    UnsupportedEncodingFormat = 2,
    EffectCurrentlyUnloaded = 3
  );
  PEffects_MediaEffectClosedReason = ^Effects_MediaEffectClosedReason;

  // Windows.Media.Protection.RevocationAndRenewalReasons
  Protection_RevocationAndRenewalReasons = (
    UserModeComponentLoad = 1,
    KernelModeComponentLoad = 2,
    AppComponent = 4,
    GlobalRevocationListLoadFailed = 16,
    InvalidGlobalRevocationListSignature = 32,
    GlobalRevocationListAbsent = 4096,
    ComponentRevoked = 8192,
    InvalidComponentCertificateExtendedKeyUse = 16384,
    ComponentCertificateRevoked = 32768,
    InvalidComponentCertificateRoot = 65536,
    ComponentHighSecurityCertificateRevoked = 131072,
    ComponentLowSecurityCertificateRevoked = 262144,
    BootDriverVerificationFailed = 1048576,
    ComponentSignedWithTestCertificate = 16777216,
    EncryptionFailure = 268435456
  );
  PProtection_RevocationAndRenewalReasons = ^Protection_RevocationAndRenewalReasons;

  // Windows.Media.Protection.GraphicsTrustStatus
  Protection_GraphicsTrustStatus = (
    TrustNotRequired = 0,
    TrustEstablished = 1,
    EnvironmentNotSupported = 2,
    DriverNotSupported = 3,
    DriverSigningFailure = 4,
    UnknownFailure = 5
  );
  PProtection_GraphicsTrustStatus = ^Protection_GraphicsTrustStatus;

  // Windows.Media.Core.MediaStreamSourceClosedReason
  Core_MediaStreamSourceClosedReason = (
    Done = 0,
    UnknownError = 1,
    AppReportedError = 2,
    UnsupportedProtectionSystem = 3,
    ProtectionSystemFailure = 4,
    UnsupportedEncodingFormat = 5,
    MissingSampleRequestedEventHandler = 6
  );
  PCore_MediaStreamSourceClosedReason = ^Core_MediaStreamSourceClosedReason;

  // Windows.Media.Core.MediaStreamSourceErrorStatus
  Core_MediaStreamSourceErrorStatus = (
    Other = 0,
    OutOfMemory = 1,
    FailedToOpenFile = 2,
    FailedToConnectToServer = 3,
    ConnectionToServerLost = 4,
    UnspecifiedNetworkError = 5,
    DecodeError = 6,
    UnsupportedMediaFormat = 7
  );
  PCore_MediaStreamSourceErrorStatus = ^Core_MediaStreamSourceErrorStatus;

  // Windows.Media.Core.MseReadyState
  Core_MseReadyState = (
    Closed = 0,
    Open = 1,
    Ended = 2
  );
  PCore_MseReadyState = ^Core_MseReadyState;

  // Windows.Media.Core.MseEndOfStreamStatus
  Core_MseEndOfStreamStatus = (
    Success = 0,
    NetworkError = 1,
    DecodeError = 2,
    UnknownError = 3
  );
  PCore_MseEndOfStreamStatus = ^Core_MseEndOfStreamStatus;

  // Windows.Media.Core.MseAppendMode
  Core_MseAppendMode = (
    Segments = 0,
    Sequence = 1
  );
  PCore_MseAppendMode = ^Core_MseAppendMode;

  // Windows.Media.Transcoding.TranscodeFailureReason
  Transcoding_TranscodeFailureReason = (
    None = 0,
    Unknown = 1,
    InvalidProfile = 2,
    CodecNotFound = 3
  );
  PTranscoding_TranscodeFailureReason = ^Transcoding_TranscodeFailureReason;

  // Windows.Media.Core.FaceDetectionMode
  Core_FaceDetectionMode = (
    HighPerformance = 0,
    Balanced = 1,
    HighQuality = 2
  );
  PCore_FaceDetectionMode = ^Core_FaceDetectionMode;

  // Windows.Media.Core.VideoStabilizationEffectEnabledChangedReason
  Core_VideoStabilizationEffectEnabledChangedReason = (
    Programmatic = 0,
    PixelRateTooHigh = 1,
    RunningSlowly = 2
  );
  PCore_VideoStabilizationEffectEnabledChangedReason = ^Core_VideoStabilizationEffectEnabledChangedReason;

  // Windows.Media.ClosedCaptioning.ClosedCaptionStyle
  ClosedCaptioning_ClosedCaptionStyle = (
    Default = 0,
    MonospacedWithSerifs = 1,
    ProportionalWithSerifs = 2,
    MonospacedWithoutSerifs = 3,
    ProportionalWithoutSerifs = 4,
    Casual = 5,
    Cursive = 6,
    SmallCapitals = 7
  );
  PClosedCaptioning_ClosedCaptionStyle = ^ClosedCaptioning_ClosedCaptionStyle;

  // Windows.Media.ClosedCaptioning.ClosedCaptionEdgeEffect
  ClosedCaptioning_ClosedCaptionEdgeEffect = (
    Default = 0,
    None = 1,
    Raised = 2,
    Depressed = 3,
    Uniform = 4,
    DropShadow = 5
  );
  PClosedCaptioning_ClosedCaptionEdgeEffect = ^ClosedCaptioning_ClosedCaptionEdgeEffect;

  // Windows.Media.ClosedCaptioning.ClosedCaptionOpacity
  ClosedCaptioning_ClosedCaptionOpacity = (
    Default = 0,
    OneHundredPercent = 1,
    SeventyFivePercent = 2,
    TwentyFivePercent = 3,
    ZeroPercent = 4
  );
  PClosedCaptioning_ClosedCaptionOpacity = ^ClosedCaptioning_ClosedCaptionOpacity;

  // Windows.Media.ClosedCaptioning.ClosedCaptionColor
  ClosedCaptioning_ClosedCaptionColor = (
    Default = 0,
    White = 1,
    Black = 2,
    Red = 3,
    Green = 4,
    Blue = 5,
    Yellow = 6,
    Magenta = 7,
    Cyan = 8
  );
  PClosedCaptioning_ClosedCaptionColor = ^ClosedCaptioning_ClosedCaptionColor;

  // Windows.Media.ClosedCaptioning.ClosedCaptionSize
  ClosedCaptioning_ClosedCaptionSize = (
    Default = 0,
    FiftyPercent = 1,
    OneHundredPercent = 2,
    OneHundredFiftyPercent = 3,
    TwoHundredPercent = 4
  );
  PClosedCaptioning_ClosedCaptionSize = ^ClosedCaptioning_ClosedCaptionSize;

  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceCreationStatus
  Streaming_Adaptive_AdaptiveMediaSourceCreationStatus = (
    Success = 0,
    ManifestDownloadFailure = 1,
    ManifestParseFailure = 2,
    UnsupportedManifestContentType = 3,
    UnsupportedManifestVersion = 4,
    UnsupportedManifestProfile = 5,
    UnknownFailure = 6
  );
  PStreaming_Adaptive_AdaptiveMediaSourceCreationStatus = ^Streaming_Adaptive_AdaptiveMediaSourceCreationStatus;

  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceResourceType
  Streaming_Adaptive_AdaptiveMediaSourceResourceType = (
    Manifest = 0,
    InitializationSegment = 1,
    MediaSegment = 2,
    Key = 3,
    InitializationVector = 4
  );
  PStreaming_Adaptive_AdaptiveMediaSourceResourceType = ^Streaming_Adaptive_AdaptiveMediaSourceResourceType;

  // Windows.Media.Core.MediaTrackKind
  Core_MediaTrackKind = (
    Audio = 0,
    Video = 1,
    TimedMetadata = 2
  );
  PCore_MediaTrackKind = ^Core_MediaTrackKind;

  // Windows.Media.Core.TimedMetadataKind
  Core_TimedMetadataKind = (
    Caption = 0,
    Chapter = 1,
    Custom = 2,
    Data = 3,
    Description = 4,
    Subtitle = 5
  );
  PCore_TimedMetadataKind = ^Core_TimedMetadataKind;

  // Windows.Media.Core.TimedMetadataTrackErrorCode
  Core_TimedMetadataTrackErrorCode = (
    None = 0,
    DataFormatError = 1,
    NetworkError = 2,
    InternalError = 3
  );
  PCore_TimedMetadataTrackErrorCode = ^Core_TimedMetadataTrackErrorCode;

  // Windows.Media.Core.TimedTextScrollMode
  Core_TimedTextScrollMode = (
    Popon = 0,
    Rollup = 1
  );
  PCore_TimedTextScrollMode = ^Core_TimedTextScrollMode;

  // Windows.Media.Core.TimedTextUnit
  Core_TimedTextUnit = (
    Pixels = 0,
    Percentage = 1
  );
  PCore_TimedTextUnit = ^Core_TimedTextUnit;

  // Windows.Media.Core.TimedTextWritingMode
  Core_TimedTextWritingMode = (
    LeftRightTopBottom = 0,
    RightLeftTopBottom = 1,
    TopBottomRightLeft = 2,
    TopBottomLeftRight = 3,
    LeftRight = 4,
    RightLeft = 5,
    TopBottom = 6
  );
  PCore_TimedTextWritingMode = ^Core_TimedTextWritingMode;

  // Windows.Media.Core.TimedTextDisplayAlignment
  Core_TimedTextDisplayAlignment = (
    Before = 0,
    After = 1,
    Center = 2
  );
  PCore_TimedTextDisplayAlignment = ^Core_TimedTextDisplayAlignment;

  // Windows.Media.Core.TimedTextLineAlignment
  Core_TimedTextLineAlignment = (
    Start = 0,
    &End = 1,
    Center = 2
  );
  PCore_TimedTextLineAlignment = ^Core_TimedTextLineAlignment;

  // Windows.Media.Core.TimedTextWrapping
  Core_TimedTextWrapping = (
    NoWrap = 0,
    Wrap = 1
  );
  PCore_TimedTextWrapping = ^Core_TimedTextWrapping;

  // Windows.Media.Core.TimedTextWeight
  Core_TimedTextWeight = (
    Normal = 400,
    Bold = 700
  );
  PCore_TimedTextWeight = ^Core_TimedTextWeight;

  // Windows.Media.Core.TimedTextFlowDirection
  Core_TimedTextFlowDirection = (
    LeftToRight = 0,
    RightToLeft = 1
  );
  PCore_TimedTextFlowDirection = ^Core_TimedTextFlowDirection;

  // Windows.Media.Playback.MediaPlaybackItemErrorCode
  Playback_MediaPlaybackItemErrorCode = (
    None = 0,
    Aborted = 1,
    NetworkError = 2,
    DecodeError = 3,
    SourceNotSupportedError = 4,
    EncryptionError = 5
  );
  PPlayback_MediaPlaybackItemErrorCode = ^Playback_MediaPlaybackItemErrorCode;

  // Windows.Media.Playback.FailedMediaStreamKind
  Playback_FailedMediaStreamKind = (
    Unknown = 0,
    Audio = 1,
    Video = 2
  );
  PPlayback_FailedMediaStreamKind = ^Playback_FailedMediaStreamKind;

  // Windows.Media.Playback.TimedMetadataTrackPresentationMode
  Playback_TimedMetadataTrackPresentationMode = (
    Disabled = 0,
    Hidden = 1,
    ApplicationPresented = 2,
    PlatformPresented = 3
  );
  PPlayback_TimedMetadataTrackPresentationMode = ^Playback_TimedMetadataTrackPresentationMode;

  // Windows.Media.ContentRestrictions.RatedContentCategory
  ContentRestrictions_RatedContentCategory = (
    General = 0,
    Application = 1,
    Game = 2,
    Movie = 3,
    Television = 4,
    Music = 5
  );
  PContentRestrictions_RatedContentCategory = ^ContentRestrictions_RatedContentCategory;

  // Windows.Media.ContentRestrictions.ContentAccessRestrictionLevel
  ContentRestrictions_ContentAccessRestrictionLevel = (
    Allow = 0,
    Warn = 1,
    Block = 2,
    Hide = 3
  );
  PContentRestrictions_ContentAccessRestrictionLevel = ^ContentRestrictions_ContentAccessRestrictionLevel;

  // Windows.Media.Playlists.PlaylistFormat
  Playlists_PlaylistFormat = (
    WindowsMedia = 0,
    Zune = 1,
    M3u = 2
  );
  PPlaylists_PlaylistFormat = ^Playlists_PlaylistFormat;

  // Windows.Media.Capture.AppCaptureVideoEncodingBitrateMode
  Capture_AppCaptureVideoEncodingBitrateMode = (
    Custom = 0,
    High = 1,
    Standard = 2
  );
  PCapture_AppCaptureVideoEncodingBitrateMode = ^Capture_AppCaptureVideoEncodingBitrateMode;

  // Windows.Media.Capture.AppCaptureVideoEncodingResolutionMode
  Capture_AppCaptureVideoEncodingResolutionMode = (
    Custom = 0,
    High = 1,
    Standard = 2
  );
  PCapture_AppCaptureVideoEncodingResolutionMode = ^Capture_AppCaptureVideoEncodingResolutionMode;

  // Windows.Media.Capture.AppCaptureHistoricalBufferLengthUnit
  Capture_AppCaptureHistoricalBufferLengthUnit = (
    Megabytes = 0,
    Seconds = 1
  );
  PCapture_AppCaptureHistoricalBufferLengthUnit = ^Capture_AppCaptureHistoricalBufferLengthUnit;

  // Windows.Media.Protection.RenewalStatus
  Protection_RenewalStatus = (
    NotStarted = 0,
    UpdatesInProgress = 1,
    UserCancelled = 2,
    AppComponentsMayNeedUpdating = 3,
    NoComponentsFound = 4
  );
  PProtection_RenewalStatus = ^Protection_RenewalStatus;


  // Windows.Media Records
  // Windows.Media.Import.PhotoImportProgress
  Import_PhotoImportProgress = record
    ItemsImported: Cardinal;
    TotalItemsToImport: Cardinal;
    BytesImported: UInt64;
    TotalBytesToImport: UInt64;
    ImportProgress: Double;
  end;
  PImport_PhotoImportProgress = ^Import_PhotoImportProgress;

  // Windows.Media.Capture.WhiteBalanceGain
  Capture_WhiteBalanceGain = record
    R: Double;
    G: Double;
    B: Double;
  end;
  PCapture_WhiteBalanceGain = ^Capture_WhiteBalanceGain;

  // Windows.Media.Core.MseTimeRange
  Core_MseTimeRange = record
    Start: TimeSpan;
    &End: TimeSpan;
  end;
  PCore_MseTimeRange = ^Core_MseTimeRange;

  // Windows.Media.Core.TimedTextPadding
  Core_TimedTextPadding = record
    Before: Double;
    After: Double;
    Start: Double;
    &End: Double;
    &Unit: Core_TimedTextUnit;
  end;
  PCore_TimedTextPadding = ^Core_TimedTextPadding;

  // Windows.Media.Core.TimedTextSize
  Core_TimedTextSize = record
    Height: Double;
    Width: Double;
    &Unit: Core_TimedTextUnit;
  end;
  PCore_TimedTextSize = ^Core_TimedTextSize;

  // Windows.Media.Core.TimedTextDouble
  Core_TimedTextDouble = record
    Value: Double;
    &Unit: Core_TimedTextUnit;
  end;
  PCore_TimedTextDouble = ^Core_TimedTextDouble;

  // Windows.Media.Core.TimedTextPoint
  Core_TimedTextPoint = record
    X: Double;
    Y: Double;
    &Unit: Core_TimedTextUnit;
  end;
  PCore_TimedTextPoint = ^Core_TimedTextPoint;

  // Windows.Media.Playlists.PlaylistsContract
  Playlists_PlaylistsContract = record
  end;
  PPlaylists_PlaylistsContract = ^Playlists_PlaylistsContract;

  // Windows.Media.Capture.AppCaptureContract
  Capture_AppCaptureContract = record
  end;
  PCapture_AppCaptureContract = ^Capture_AppCaptureContract;

  // Windows.Media.Capture.CameraCaptureUIContract
  Capture_CameraCaptureUIContract = record
  end;
  PCapture_CameraCaptureUIContract = ^Capture_CameraCaptureUIContract;

  // Windows.Media.MediaControlContract
  MediaControlContract = record
  end;
  PMediaControlContract = ^MediaControlContract;

  // Windows.Media.Protection.ProtectionRenewalContract
  Protection_ProtectionRenewalContract = record
  end;
  PProtection_ProtectionRenewalContract = ^Protection_ProtectionRenewalContract;



  // Windows.Media.Devices Enums
  // Windows.Media.Devices.TelephonyKey
  TelephonyKey = (
    D0 = 0,
    D1 = 1,
    D2 = 2,
    D3 = 3,
    D4 = 4,
    D5 = 5,
    D6 = 6,
    D7 = 7,
    D8 = 8,
    D9 = 9,
    Star = 10,
    Pound = 11,
    A = 12,
    B = 13,
    C = 14,
    D = 15
  );
  PTelephonyKey = ^TelephonyKey;

  // Windows.Media.Devices.AudioDeviceRole
  AudioDeviceRole = (
    Default = 0,
    Communications = 1
  );
  PAudioDeviceRole = ^AudioDeviceRole;

  // Windows.Media.Devices.IsoSpeedPreset
  IsoSpeedPreset = (
    Auto = 0,
    Iso50 = 1,
    Iso80 = 2,
    Iso100 = 3,
    Iso200 = 4,
    Iso400 = 5,
    Iso800 = 6,
    Iso1600 = 7,
    Iso3200 = 8,
    Iso6400 = 9,
    Iso12800 = 10,
    Iso25600 = 11
  );
  PIsoSpeedPreset = ^IsoSpeedPreset;

  // Windows.Media.Devices.CaptureSceneMode
  CaptureSceneMode = (
    Auto = 0,
    Manual = 1,
    Macro = 2,
    Portrait = 3,
    Sport = 4,
    Snow = 5,
    Night = 6,
    Beach = 7,
    Sunset = 8,
    Candlelight = 9,
    Landscape = 10,
    NightPortrait = 11,
    Backlit = 12
  );
  PCaptureSceneMode = ^CaptureSceneMode;

  // Windows.Media.Devices.MediaCaptureFocusState
  MediaCaptureFocusState = (
    Uninitialized = 0,
    Lost = 1,
    Searching = 2,
    Focused = 3,
    Failed = 4
  );
  PMediaCaptureFocusState = ^MediaCaptureFocusState;

  // Windows.Media.Devices.CameraStreamState
  CameraStreamState = (
    NotStreaming = 0,
    Streaming = 1,
    BlockedForPrivacy = 2,
    Shutdown = 3
  );
  PCameraStreamState = ^CameraStreamState;

  // Windows.Media.Devices.MediaCapturePauseBehavior
  MediaCapturePauseBehavior = (
    RetainHardwareResources = 0,
    ReleaseHardwareResources = 1
  );
  PMediaCapturePauseBehavior = ^MediaCapturePauseBehavior;

  // Windows.Media.Devices.AdvancedPhotoMode
  AdvancedPhotoMode = (
    Auto = 0,
    Standard = 1,
    Hdr = 2
  );
  PAdvancedPhotoMode = ^AdvancedPhotoMode;

  // Windows.Media.Devices.ColorTemperaturePreset
  ColorTemperaturePreset = (
    Auto = 0,
    Manual = 1,
    Cloudy = 2,
    Daylight = 3,
    Flash = 4,
    Fluorescent = 5,
    Tungsten = 6,
    Candlelight = 7
  );
  PColorTemperaturePreset = ^ColorTemperaturePreset;

  // Windows.Media.Devices.ZoomTransitionMode
  ZoomTransitionMode = (
    Auto = 0,
    Direct = 1,
    Smooth = 2
  );
  PZoomTransitionMode = ^ZoomTransitionMode;

  // Windows.Media.Devices.FocusPreset
  FocusPreset = (
    Auto = 0,
    Manual = 1,
    AutoMacro = 2,
    AutoNormal = 3,
    AutoInfinity = 4,
    AutoHyperfocal = 5
  );
  PFocusPreset = ^FocusPreset;

  // Windows.Media.Devices.FocusMode
  FocusMode = (
    Auto = 0,
    Single = 1,
    Continuous = 2,
    Manual = 3
  );
  PFocusMode = ^FocusMode;

  // Windows.Media.Devices.ManualFocusDistance
  ManualFocusDistance = (
    Infinity = 0,
    Hyperfocal = 1,
    Nearest = 2
  );
  PManualFocusDistance = ^ManualFocusDistance;

  // Windows.Media.Devices.AutoFocusRange
  AutoFocusRange = (
    FullRange = 0,
    Macro = 1,
    Normal = 2
  );
  PAutoFocusRange = ^AutoFocusRange;

  // Windows.Media.Devices.RegionOfInterestType
  RegionOfInterestType = (
    Unknown = 0,
    Face = 1
  );
  PRegionOfInterestType = ^RegionOfInterestType;

  // Windows.Media.Devices.HdrVideoMode
  HdrVideoMode = (
    Off = 0,
    On = 1,
    Auto = 2
  );
  PHdrVideoMode = ^HdrVideoMode;

  // Windows.Media.Devices.OpticalImageStabilizationMode
  OpticalImageStabilizationMode = (
    Off = 0,
    On = 1,
    Auto = 2
  );
  POpticalImageStabilizationMode = ^OpticalImageStabilizationMode;

  // Windows.Media.Devices.CaptureUse
  CaptureUse = (
    None = 0,
    Photo = 1,
    Video = 2
  );
  PCaptureUse = ^CaptureUse;

  // Windows.Media.Devices.MediaCaptureOptimization
  MediaCaptureOptimization = (
    Default = 0,
    Quality = 1,
    Latency = 2,
    Power = 3,
    LatencyThenQuality = 4,
    LatencyThenPower = 5,
    PowerAndQuality = 6
  );
  PMediaCaptureOptimization = ^MediaCaptureOptimization;

  // Windows.Media.Devices.Core.FrameFlashMode
  Core_FrameFlashMode = (
    Disable = 0,
    Enable = 1,
    Global = 2
  );
  PCore_FrameFlashMode = ^Core_FrameFlashMode;


  // Windows.Media.Devices Records
  // Windows.Media.Devices.CallControlContract
  CallControlContract = record
  end;
  PCallControlContract = ^CallControlContract;



  // Windows.Media.MediaProperties Enums
  // Windows.Media.MediaProperties.MediaPixelFormat
  MediaPixelFormat = (
    Nv12 = 0,
    Bgra8 = 1
  );
  PMediaPixelFormat = ^MediaPixelFormat;

  // Windows.Media.MediaProperties.MediaThumbnailFormat
  MediaThumbnailFormat = (
    Bmp = 0,
    Bgra8 = 1
  );
  PMediaThumbnailFormat = ^MediaThumbnailFormat;

  // Windows.Media.MediaProperties.AudioEncodingQuality
  AudioEncodingQuality = (
    Auto = 0,
    High = 1,
    Medium = 2,
    Low = 3
  );
  PAudioEncodingQuality = ^AudioEncodingQuality;

  // Windows.Media.MediaProperties.VideoEncodingQuality
  VideoEncodingQuality = (
    Auto = 0,
    HD1080p = 1,
    HD720p = 2,
    Wvga = 3,
    Ntsc = 4,
    Pal = 5,
    Vga = 6,
    Qvga = 7
  );
  PVideoEncodingQuality = ^VideoEncodingQuality;

  // Windows.Media.MediaProperties.MediaRotation
  MediaRotation = (
    None = 0,
    Clockwise90Degrees = 1,
    Clockwise180Degrees = 2,
    Clockwise270Degrees = 3
  );
  PMediaRotation = ^MediaRotation;

  // Windows.Media.MediaProperties.MediaMirroringOptions
  MediaMirroringOptions = (
    None = 0,
    Horizontal = 1,
    Vertical = 2
  );
  PMediaMirroringOptions = ^MediaMirroringOptions;



  // Windows.Networking Enums
  // Windows.Networking.BackgroundTransfer.BackgroundTransferStatus
  BackgroundTransfer_BackgroundTransferStatus = (
    Idle = 0,
    Running = 1,
    PausedByApplication = 2,
    PausedCostedNetwork = 3,
    PausedNoNetwork = 4,
    Completed = 5,
    Canceled = 6,
    Error = 7,
    PausedSystemPolicy = 32
  );
  PBackgroundTransfer_BackgroundTransferStatus = ^BackgroundTransfer_BackgroundTransferStatus;

  // Windows.Networking.BackgroundTransfer.BackgroundTransferCostPolicy
  BackgroundTransfer_BackgroundTransferCostPolicy = (
    Default = 0,
    UnrestrictedOnly = 1,
    Always = 2
  );
  PBackgroundTransfer_BackgroundTransferCostPolicy = ^BackgroundTransfer_BackgroundTransferCostPolicy;

  // Windows.Networking.BackgroundTransfer.BackgroundTransferPriority
  BackgroundTransfer_BackgroundTransferPriority = (
    Default = 0,
    High = 1
  );
  PBackgroundTransfer_BackgroundTransferPriority = ^BackgroundTransfer_BackgroundTransferPriority;

  // Windows.Networking.BackgroundTransfer.BackgroundTransferBehavior
  BackgroundTransfer_BackgroundTransferBehavior = (
    Parallel = 0,
    Serialized = 1
  );
  PBackgroundTransfer_BackgroundTransferBehavior = ^BackgroundTransfer_BackgroundTransferBehavior;

  // Windows.Networking.ServiceDiscovery.Dnssd.DnssdRegistrationStatus
  ServiceDiscovery_Dnssd_DnssdRegistrationStatus = (
    Success = 0,
    InvalidServiceName = 1,
    ServerError = 2,
    SecurityError = 3
  );
  PServiceDiscovery_Dnssd_DnssdRegistrationStatus = ^ServiceDiscovery_Dnssd_DnssdRegistrationStatus;

  // Windows.Networking.ServiceDiscovery.Dnssd.DnssdServiceWatcherStatus
  ServiceDiscovery_Dnssd_DnssdServiceWatcherStatus = (
    Created = 0,
    Started = 1,
    EnumerationCompleted = 2,
    Stopping = 3,
    Stopped = 4,
    Aborted = 5
  );
  PServiceDiscovery_Dnssd_DnssdServiceWatcherStatus = ^ServiceDiscovery_Dnssd_DnssdServiceWatcherStatus;

  // Windows.Networking.HostNameSortOptions
  HostNameSortOptions = (
    None = 0,
    OptimizeForLongConnections = 2
  );
  PHostNameSortOptions = ^HostNameSortOptions;

  // Windows.Networking.HostNameType
  HostNameType = (
    DomainName = 0,
    Ipv4 = 1,
    Ipv6 = 2,
    Bluetooth = 3
  );
  PHostNameType = ^HostNameType;

  // Windows.Networking.DomainNameType
  DomainNameType = (
    Suffix = 0,
    FullyQualified = 1
  );
  PDomainNameType = ^DomainNameType;

  // Windows.Networking.PushNotifications.PushNotificationType
  PushNotifications_PushNotificationType = (
    Toast = 0,
    Tile = 1,
    Badge = 2,
    Raw = 3,
    TileFlyout = 4
  );
  PPushNotifications_PushNotificationType = ^PushNotifications_PushNotificationType;

  // Windows.Networking.XboxLive.XboxLiveNetworkAccessKind
  XboxLive_XboxLiveNetworkAccessKind = (
    Open = 0,
    Moderate = 1,
    Strict = 2
  );
  PXboxLive_XboxLiveNetworkAccessKind = ^XboxLive_XboxLiveNetworkAccessKind;

  // Windows.Networking.XboxLive.XboxLiveSocketKind
  XboxLive_XboxLiveSocketKind = (
    None = 0,
    Datagram = 1,
    Stream = 2
  );
  PXboxLive_XboxLiveSocketKind = ^XboxLive_XboxLiveSocketKind;

  // Windows.Networking.XboxLive.XboxLiveEndpointPairCreationBehaviors
  XboxLive_XboxLiveEndpointPairCreationBehaviors = (
    None = 0,
    ReevaluatePath = 1
  );
  PXboxLive_XboxLiveEndpointPairCreationBehaviors = ^XboxLive_XboxLiveEndpointPairCreationBehaviors;

  // Windows.Networking.XboxLive.XboxLiveEndpointPairCreationStatus
  XboxLive_XboxLiveEndpointPairCreationStatus = (
    Succeeded = 0,
    NoLocalNetworks = 1,
    NoCompatibleNetworkPaths = 2,
    LocalSystemNotAuthorized = 3,
    Canceled = 4,
    TimedOut = 5,
    RemoteSystemNotAuthorized = 6,
    RefusedDueToConfiguration = 7,
    UnexpectedInternalError = 8
  );
  PXboxLive_XboxLiveEndpointPairCreationStatus = ^XboxLive_XboxLiveEndpointPairCreationStatus;

  // Windows.Networking.XboxLive.XboxLiveEndpointPairState
  XboxLive_XboxLiveEndpointPairState = (
    Invalid = 0,
    CreatingOutbound = 1,
    CreatingInbound = 2,
    Ready = 3,
    DeletingLocally = 4,
    RemoteEndpointTerminating = 5,
    Deleted = 6
  );
  PXboxLive_XboxLiveEndpointPairState = ^XboxLive_XboxLiveEndpointPairState;

  // Windows.Networking.XboxLive.XboxLiveQualityOfServiceMetric
  XboxLive_XboxLiveQualityOfServiceMetric = (
    AverageLatencyInMilliseconds = 0,
    MinLatencyInMilliseconds = 1,
    MaxLatencyInMilliseconds = 2,
    AverageOutboundBitsPerSecond = 3,
    MinOutboundBitsPerSecond = 4,
    MaxOutboundBitsPerSecond = 5,
    AverageInboundBitsPerSecond = 6,
    MinInboundBitsPerSecond = 7,
    MaxInboundBitsPerSecond = 8
  );
  PXboxLive_XboxLiveQualityOfServiceMetric = ^XboxLive_XboxLiveQualityOfServiceMetric;

  // Windows.Networking.XboxLive.XboxLiveQualityOfServiceMeasurementStatus
  XboxLive_XboxLiveQualityOfServiceMeasurementStatus = (
    NotStarted = 0,
    InProgress = 1,
    InProgressWithProvisionalResults = 2,
    Succeeded = 3,
    NoLocalNetworks = 4,
    NoCompatibleNetworkPaths = 5,
    LocalSystemNotAuthorized = 6,
    Canceled = 7,
    TimedOut = 8,
    RemoteSystemNotAuthorized = 9,
    RefusedDueToConfiguration = 10,
    UnexpectedInternalError = 11
  );
  PXboxLive_XboxLiveQualityOfServiceMeasurementStatus = ^XboxLive_XboxLiveQualityOfServiceMeasurementStatus;


  // Windows.Networking Records
  // Windows.Networking.BackgroundTransfer.BackgroundDownloadProgress
  BackgroundTransfer_BackgroundDownloadProgress = record
    BytesReceived: UInt64;
    TotalBytesToReceive: UInt64;
    Status: BackgroundTransfer_BackgroundTransferStatus;
    HasResponseChanged: Boolean;
    HasRestarted: Boolean;
  end;
  PBackgroundTransfer_BackgroundDownloadProgress = ^BackgroundTransfer_BackgroundDownloadProgress;

  // Windows.Networking.BackgroundTransfer.BackgroundUploadProgress
  BackgroundTransfer_BackgroundUploadProgress = record
    BytesReceived: UInt64;
    BytesSent: UInt64;
    TotalBytesToReceive: UInt64;
    TotalBytesToSend: UInt64;
    Status: BackgroundTransfer_BackgroundTransferStatus;
    HasResponseChanged: Boolean;
    HasRestarted: Boolean;
  end;
  PBackgroundTransfer_BackgroundUploadProgress = ^BackgroundTransfer_BackgroundUploadProgress;

  // Windows.Networking.XboxLive.XboxLiveSecureSocketsContract
  XboxLive_XboxLiveSecureSocketsContract = record
  end;
  PXboxLive_XboxLiveSecureSocketsContract = ^XboxLive_XboxLiveSecureSocketsContract;



  // Windows.Networking.Connectivity Enums
  // Windows.Networking.Connectivity.NetworkCostType
  NetworkCostType = (
    Unknown = 0,
    Unrestricted = 1,
    Fixed = 2,
    Variable = 3
  );
  PNetworkCostType = ^NetworkCostType;

  // Windows.Networking.Connectivity.NetworkConnectivityLevel
  NetworkConnectivityLevel = (
    None = 0,
    LocalAccess = 1,
    ConstrainedInternetAccess = 2,
    InternetAccess = 3
  );
  PNetworkConnectivityLevel = ^NetworkConnectivityLevel;

  // Windows.Networking.Connectivity.NetworkTypes
  NetworkTypes = (
    None = 0,
    Internet = 1,
    PrivateNetwork = 2
  );
  PNetworkTypes = ^NetworkTypes;

  // Windows.Networking.Connectivity.RoamingStates
  RoamingStates = (
    None = 0,
    NotRoaming = 1,
    Roaming = 2
  );
  PRoamingStates = ^RoamingStates;

  // Windows.Networking.Connectivity.NetworkAuthenticationType
  NetworkAuthenticationType = (
    None = 0,
    Unknown = 1,
    Open80211 = 2,
    SharedKey80211 = 3,
    Wpa = 4,
    WpaPsk = 5,
    WpaNone = 6,
    Rsna = 7,
    RsnaPsk = 8,
    Ihv = 9
  );
  PNetworkAuthenticationType = ^NetworkAuthenticationType;

  // Windows.Networking.Connectivity.NetworkEncryptionType
  NetworkEncryptionType = (
    None = 0,
    Unknown = 1,
    Wep = 2,
    Wep40 = 3,
    Wep104 = 4,
    Tkip = 5,
    Ccmp = 6,
    WpaUseGroup = 7,
    RsnUseGroup = 8,
    Ihv = 9
  );
  PNetworkEncryptionType = ^NetworkEncryptionType;

  // Windows.Networking.Connectivity.DomainConnectivityLevel
  DomainConnectivityLevel = (
    None = 0,
    Unauthenticated = 1,
    Authenticated = 2
  );
  PDomainConnectivityLevel = ^DomainConnectivityLevel;

  // Windows.Networking.Connectivity.DataUsageGranularity
  DataUsageGranularity = (
    PerMinute = 0,
    PerHour = 1,
    PerDay = 2,
    Total = 3
  );
  PDataUsageGranularity = ^DataUsageGranularity;

  // Windows.Networking.Connectivity.CellularApnAuthenticationType
  CellularApnAuthenticationType = (
    None = 0,
    Pap = 1,
    Chap = 2,
    Mschapv2 = 3
  );
  PCellularApnAuthenticationType = ^CellularApnAuthenticationType;

  // Windows.Networking.Connectivity.TriStates
  TriStates = (
    DoNotCare = 0,
    No = 1,
    Yes = 2
  );
  PTriStates = ^TriStates;

  // Windows.Networking.Connectivity.WwanNetworkRegistrationState
  WwanNetworkRegistrationState = (
    None = 0,
    Deregistered = 1,
    Searching = 2,
    Home = 3,
    Roaming = 4,
    Partner = 5,
    Denied = 6
  );
  PWwanNetworkRegistrationState = ^WwanNetworkRegistrationState;

  // Windows.Networking.Connectivity.WwanDataClass
  WwanDataClass = (
    None = 0,
    Gprs = 1,
    Edge = 2,
    Umts = 4,
    Hsdpa = 8,
    Hsupa = 16,
    LteAdvanced = 32,
    Cdma1xRtt = 65536,
    Cdma1xEvdo = 131072,
    Cdma1xEvdoRevA = 262144,
    Cdma1xEvdv = 524288,
    Cdma3xRtt = 1048576,
    Cdma1xEvdoRevB = 2097152,
    CdmaUmb = 4194304,
    Custom = -2147483648
  );
  PWwanDataClass = ^WwanDataClass;


  // Windows.Networking.Connectivity Records
  // Windows.Networking.Connectivity.NetworkUsageStates
  NetworkUsageStates = record
    Roaming: TriStates;
    Shared: TriStates;
  end;
  PNetworkUsageStates = ^NetworkUsageStates;

  // Windows.Networking.Connectivity.WwanContract
  WwanContract = record
  end;
  PWwanContract = ^WwanContract;



  // Windows.Networking.NetworkOperators Enums
  // Windows.Networking.NetworkOperators.DataClasses
  DataClasses = (
    None = 0,
    Gprs = 1,
    Edge = 2,
    Umts = 4,
    Hsdpa = 8,
    Hsupa = 16,
    LteAdvanced = 32,
    Cdma1xRtt = 65536,
    Cdma1xEvdo = 131072,
    Cdma1xEvdoRevA = 262144,
    Cdma1xEvdv = 524288,
    Cdma3xRtt = 1048576,
    Cdma1xEvdoRevB = 2097152,
    CdmaUmb = 4194304,
    Custom = -2147483648
  );
  PDataClasses = ^DataClasses;

  // Windows.Networking.NetworkOperators.MobileBroadbandDeviceType
  MobileBroadbandDeviceType = (
    Unknown = 0,
    Embedded = 1,
    Removable = 2,
    Remote = 3
  );
  PMobileBroadbandDeviceType = ^MobileBroadbandDeviceType;

  // Windows.Networking.NetworkOperators.NetworkDeviceStatus
  NetworkDeviceStatus = (
    DeviceNotReady = 0,
    DeviceReady = 1,
    SimNotInserted = 2,
    BadSim = 3,
    DeviceHardwareFailure = 4,
    AccountNotActivated = 5,
    DeviceLocked = 6,
    DeviceBlocked = 7
  );
  PNetworkDeviceStatus = ^NetworkDeviceStatus;

  // Windows.Networking.NetworkOperators.NetworkRegistrationState
  NetworkRegistrationState = (
    None = 0,
    Deregistered = 1,
    Searching = 2,
    Home = 3,
    Roaming = 4,
    Partner = 5,
    Denied = 6
  );
  PNetworkRegistrationState = ^NetworkRegistrationState;

  // Windows.Networking.NetworkOperators.MobileBroadbandRadioState
  MobileBroadbandRadioState = (
    Off = 0,
    On = 1
  );
  PMobileBroadbandRadioState = ^MobileBroadbandRadioState;

  // Windows.Networking.NetworkOperators.NetworkOperatorEventMessageType
  NetworkOperatorEventMessageType = (
    Gsm = 0,
    Cdma = 1,
    Ussd = 2,
    DataPlanThresholdReached = 3,
    DataPlanReset = 4,
    DataPlanDeleted = 5,
    ProfileConnected = 6,
    ProfileDisconnected = 7,
    RegisteredRoaming = 8,
    RegisteredHome = 9,
    TetheringEntitlementCheck = 10,
    TetheringOperationalStateChanged = 11,
    TetheringNumberOfClientsChanged = 12
  );
  PNetworkOperatorEventMessageType = ^NetworkOperatorEventMessageType;

  // Windows.Networking.NetworkOperators.MobileBroadbandAccountWatcherStatus
  MobileBroadbandAccountWatcherStatus = (
    Created = 0,
    Started = 1,
    EnumerationCompleted = 2,
    Stopped = 3,
    Aborted = 4
  );
  PMobileBroadbandAccountWatcherStatus = ^MobileBroadbandAccountWatcherStatus;

  // Windows.Networking.NetworkOperators.TetheringOperationalState
  TetheringOperationalState = (
    Unknown = 0,
    On = 1,
    Off = 2,
    InTransition = 3
  );
  PTetheringOperationalState = ^TetheringOperationalState;

  // Windows.Networking.NetworkOperators.TetheringCapability
  TetheringCapability = (
    Enabled = 0,
    DisabledByGroupPolicy = 1,
    DisabledByHardwareLimitation = 2,
    DisabledByOperator = 3,
    DisabledBySku = 4,
    DisabledByRequiredAppNotInstalled = 5,
    DisabledDueToUnknownCause = 6,
    DisabledBySystemCapability = 7
  );
  PTetheringCapability = ^TetheringCapability;

  // Windows.Networking.NetworkOperators.TetheringOperationStatus
  TetheringOperationStatus = (
    Success = 0,
    Unknown = 1,
    MobileBroadbandDeviceOff = 2,
    WiFiDeviceOff = 3,
    EntitlementCheckTimeout = 4,
    EntitlementCheckFailure = 5,
    OperationInProgress = 6
  );
  PTetheringOperationStatus = ^TetheringOperationStatus;

  // Windows.Networking.NetworkOperators.MobileBroadbandPinLockState
  MobileBroadbandPinLockState = (
    Unknown = 0,
    Unlocked = 1,
    PinRequired = 2,
    PinUnblockKeyRequired = 3
  );
  PMobileBroadbandPinLockState = ^MobileBroadbandPinLockState;

  // Windows.Networking.NetworkOperators.MobileBroadbandPinType
  MobileBroadbandPinType = (
    None = 0,
    Custom = 1,
    Pin1 = 2,
    Pin2 = 3,
    SimPin = 4,
    FirstSimPin = 5,
    NetworkPin = 6,
    NetworkSubsetPin = 7,
    ServiceProviderPin = 8,
    CorporatePin = 9,
    SubsidyLock = 10
  );
  PMobileBroadbandPinType = ^MobileBroadbandPinType;

  // Windows.Networking.NetworkOperators.MobileBroadbandPinFormat
  MobileBroadbandPinFormat = (
    Unknown = 0,
    Numeric = 1,
    Alphanumeric = 2
  );
  PMobileBroadbandPinFormat = ^MobileBroadbandPinFormat;

  // Windows.Networking.NetworkOperators.MobileBroadbandUiccAppOperationStatus
  MobileBroadbandUiccAppOperationStatus = (
    Success = 0,
    InvalidUiccFilePath = 1,
    AccessConditionNotHeld = 2,
    UiccBusy = 3
  );
  PMobileBroadbandUiccAppOperationStatus = ^MobileBroadbandUiccAppOperationStatus;

  // Windows.Networking.NetworkOperators.UiccAppKind
  UiccAppKind = (
    Unknown = 0,
    MF = 1,
    MFSim = 2,
    MFRuim = 3,
    USim = 4,
    CSim = 5,
    ISim = 6
  );
  PUiccAppKind = ^UiccAppKind;

  // Windows.Networking.NetworkOperators.UiccAppRecordKind
  UiccAppRecordKind = (
    Unknown = 0,
    Transparent = 1,
    RecordOriented = 2
  );
  PUiccAppRecordKind = ^UiccAppRecordKind;

  // Windows.Networking.NetworkOperators.UiccAccessCondition
  UiccAccessCondition = (
    AlwaysAllowed = 0,
    Pin1 = 1,
    Pin2 = 2,
    Pin3 = 3,
    Pin4 = 4,
    Administrative5 = 5,
    Administrative6 = 6,
    NeverAllowed = 7
  );
  PUiccAccessCondition = ^UiccAccessCondition;

  // Windows.Networking.NetworkOperators.HotspotAuthenticationResponseCode
  HotspotAuthenticationResponseCode = (
    NoError = 0,
    LoginSucceeded = 50,
    LoginFailed = 100,
    RadiusServerError = 102,
    NetworkAdministratorError = 105,
    LoginAborted = 151,
    AccessGatewayInternalError = 255
  );
  PHotspotAuthenticationResponseCode = ^HotspotAuthenticationResponseCode;

  // Windows.Networking.NetworkOperators.ProfileMediaType
  ProfileMediaType = (
    Wlan = 0,
    Wwan = 1
  );
  PProfileMediaType = ^ProfileMediaType;

  // Windows.Networking.NetworkOperators.UssdResultCode
  UssdResultCode = (
    NoActionRequired = 0,
    ActionRequired = 1,
    Terminated = 2,
    OtherLocalClient = 3,
    OperationNotSupported = 4,
    NetworkTimeout = 5
  );
  PUssdResultCode = ^UssdResultCode;


  // Windows.Networking.NetworkOperators Records
  // Windows.Networking.NetworkOperators.ProfileUsage
  ProfileUsage = record
    UsageInMegabytes: Cardinal;
    LastSyncTime: DateTime;
  end;
  PProfileUsage = ^ProfileUsage;

  // Windows.Networking.NetworkOperators.LegacyNetworkOperatorsContract
  LegacyNetworkOperatorsContract = record
  end;
  PLegacyNetworkOperatorsContract = ^LegacyNetworkOperatorsContract;



  // Windows.Networking.Proximity Enums
  // Windows.Networking.Proximity.TriggeredConnectState
  TriggeredConnectState = (
    PeerFound = 0,
    Listening = 1,
    Connecting = 2,
    Completed = 3,
    Canceled = 4,
    Failed = 5
  );
  PTriggeredConnectState = ^TriggeredConnectState;

  // Windows.Networking.Proximity.PeerWatcherStatus
  PeerWatcherStatus = (
    Created = 0,
    Started = 1,
    EnumerationCompleted = 2,
    Stopping = 3,
    Stopped = 4,
    Aborted = 5
  );
  PPeerWatcherStatus = ^PeerWatcherStatus;

  // Windows.Networking.Proximity.PeerDiscoveryTypes
  PeerDiscoveryTypes = (
    None = 0,
    Browse = 1,
    Triggered = 2
  );
  PPeerDiscoveryTypes = ^PeerDiscoveryTypes;

  // Windows.Networking.Proximity.PeerRole
  PeerRole = (
    Peer = 0,
    Host = 1,
    Client = 2
  );
  PPeerRole = ^PeerRole;



  // Windows.Networking.Sockets Enums
  // Windows.Networking.Sockets.SocketMessageType
  SocketMessageType = (
    Binary = 0,
    Utf8 = 1
  );
  PSocketMessageType = ^SocketMessageType;

  // Windows.Networking.Sockets.SocketProtectionLevel
  SocketProtectionLevel = (
    PlainSocket = 0,
    Ssl = 1,
    SslAllowNullEncryption = 2,
    BluetoothEncryptionAllowNullAuthentication = 3,
    BluetoothEncryptionWithAuthentication = 4,
    Ssl3AllowWeakEncryption = 5,
    Tls10 = 6,
    Tls11 = 7,
    Tls12 = 8
  );
  PSocketProtectionLevel = ^SocketProtectionLevel;

  // Windows.Networking.Sockets.SocketQualityOfService
  SocketQualityOfService = (
    Normal = 0,
    LowLatency = 1
  );
  PSocketQualityOfService = ^SocketQualityOfService;

  // Windows.Networking.Sockets.SocketErrorStatus
  SocketErrorStatus = (
    Unknown = 0,
    OperationAborted = 1,
    HttpInvalidServerResponse = 2,
    ConnectionTimedOut = 3,
    AddressFamilyNotSupported = 4,
    SocketTypeNotSupported = 5,
    HostNotFound = 6,
    NoDataRecordOfRequestedType = 7,
    NonAuthoritativeHostNotFound = 8,
    ClassTypeNotFound = 9,
    AddressAlreadyInUse = 10,
    CannotAssignRequestedAddress = 11,
    ConnectionRefused = 12,
    NetworkIsUnreachable = 13,
    UnreachableHost = 14,
    NetworkIsDown = 15,
    NetworkDroppedConnectionOnReset = 16,
    SoftwareCausedConnectionAbort = 17,
    ConnectionResetByPeer = 18,
    HostIsDown = 19,
    NoAddressesFound = 20,
    TooManyOpenFiles = 21,
    MessageTooLong = 22,
    CertificateExpired = 23,
    CertificateUntrustedRoot = 24,
    CertificateCommonNameIsIncorrect = 25,
    CertificateWrongUsage = 26,
    CertificateRevoked = 27,
    CertificateNoRevocationCheck = 28,
    CertificateRevocationServerOffline = 29,
    CertificateIsInvalid = 30
  );
  PSocketErrorStatus = ^SocketErrorStatus;

  // Windows.Networking.Sockets.SocketSslErrorSeverity
  SocketSslErrorSeverity = (
    None = 0,
    Ignorable = 1,
    Fatal = 2
  );
  PSocketSslErrorSeverity = ^SocketSslErrorSeverity;

  // Windows.Networking.Sockets.SocketActivityKind
  SocketActivityKind = (
    None = 0,
    StreamSocketListener = 1,
    DatagramSocket = 2,
    StreamSocket = 3
  );
  PSocketActivityKind = ^SocketActivityKind;

  // Windows.Networking.Sockets.SocketActivityTriggerReason
  SocketActivityTriggerReason = (
    None = 0,
    SocketActivity = 1,
    ConnectionAccepted = 2,
    KeepAliveTimerExpired = 3,
    SocketClosed = 4
  );
  PSocketActivityTriggerReason = ^SocketActivityTriggerReason;

  // Windows.Networking.Sockets.SocketActivityConnectedStandbyAction
  SocketActivityConnectedStandbyAction = (
    DoNotWake = 0,
    Wake = 1
  );
  PSocketActivityConnectedStandbyAction = ^SocketActivityConnectedStandbyAction;

  // Windows.Networking.Sockets.ControlChannelTriggerStatus
  ControlChannelTriggerStatus = (
    HardwareSlotRequested = 0,
    SoftwareSlotAllocated = 1,
    HardwareSlotAllocated = 2,
    PolicyError = 3,
    SystemError = 4,
    TransportDisconnected = 5,
    ServiceUnavailable = 6
  );
  PControlChannelTriggerStatus = ^ControlChannelTriggerStatus;

  // Windows.Networking.Sockets.ControlChannelTriggerResourceType
  ControlChannelTriggerResourceType = (
    RequestSoftwareSlot = 0,
    RequestHardwareSlot = 1
  );
  PControlChannelTriggerResourceType = ^ControlChannelTriggerResourceType;

  // Windows.Networking.Sockets.ControlChannelTriggerResetReason
  ControlChannelTriggerResetReason = (
    FastUserSwitched = 0,
    LowPowerExit = 1,
    QuietHoursExit = 2,
    ApplicationRestart = 3
  );
  PControlChannelTriggerResetReason = ^ControlChannelTriggerResetReason;


  // Windows.Networking.Sockets Records
  // Windows.Networking.Sockets.RoundTripTimeStatistics
  RoundTripTimeStatistics = record
    Variance: Cardinal;
    Max: Cardinal;
    Min: Cardinal;
    Sum: Cardinal;
  end;
  PRoundTripTimeStatistics = ^RoundTripTimeStatistics;

  // Windows.Networking.Sockets.BandwidthStatistics
  BandwidthStatistics = record
    OutboundBitsPerSecond: UInt64;
    InboundBitsPerSecond: UInt64;
    OutboundBitsPerSecondInstability: UInt64;
    InboundBitsPerSecondInstability: UInt64;
    OutboundBandwidthPeaked: Boolean;
    InboundBandwidthPeaked: Boolean;
  end;
  PBandwidthStatistics = ^BandwidthStatistics;

  // Windows.Networking.Sockets.ControlChannelTriggerContract
  ControlChannelTriggerContract = record
  end;
  PControlChannelTriggerContract = ^ControlChannelTriggerContract;



  // Windows.Networking.Vpn Enums
  // Windows.Networking.Vpn.VpnDataPathType
  VpnDataPathType = (
    Send = 0,
    Receive = 1
  );
  PVpnDataPathType = ^VpnDataPathType;

  // Windows.Networking.Vpn.VpnChannelActivityEventType
  VpnChannelActivityEventType = (
    Idle = 0,
    Active = 1
  );
  PVpnChannelActivityEventType = ^VpnChannelActivityEventType;

  // Windows.Networking.Vpn.VpnCredentialType
  VpnCredentialType = (
    UsernamePassword = 0,
    UsernameOtpPin = 1,
    UsernamePasswordAndPin = 2,
    UsernamePasswordChange = 3,
    SmartCard = 4,
    ProtectedCertificate = 5,
    UnProtectedCertificate = 6
  );
  PVpnCredentialType = ^VpnCredentialType;

  // Windows.Networking.Vpn.VpnPacketBufferStatus
  VpnPacketBufferStatus = (
    Ok = 0,
    InvalidBufferSize = 1
  );
  PVpnPacketBufferStatus = ^VpnPacketBufferStatus;

  // Windows.Networking.Vpn.VpnChannelRequestCredentialsOptions
  VpnChannelRequestCredentialsOptions = (
    None = 0,
    Retrying = 1,
    UseForSingleSignIn = 2
  );
  PVpnChannelRequestCredentialsOptions = ^VpnChannelRequestCredentialsOptions;

  // Windows.Networking.Vpn.VpnDomainNameType
  VpnDomainNameType = (
    Suffix = 0,
    FullyQualified = 1,
    Reserved = 65535
  );
  PVpnDomainNameType = ^VpnDomainNameType;

  // Windows.Networking.Vpn.VpnAppIdType
  VpnAppIdType = (
    PackageFamilyName = 0,
    FullyQualifiedBinaryName = 1,
    FilePath = 2
  );
  PVpnAppIdType = ^VpnAppIdType;

  // Windows.Networking.Vpn.VpnIPProtocol
  VpnIPProtocol = (
    None = 0,
    Tcp = 6,
    Udp = 17,
    Icmp = 1,
    Ipv6Icmp = 58,
    Igmp = 2,
    Pgm = 113
  );
  PVpnIPProtocol = ^VpnIPProtocol;

  // Windows.Networking.Vpn.VpnRoutingPolicyType
  VpnRoutingPolicyType = (
    SplitRouting = 0,
    ForceAllTrafficOverVpn = 1
  );
  PVpnRoutingPolicyType = ^VpnRoutingPolicyType;

  // Windows.Networking.Vpn.VpnNativeProtocolType
  VpnNativeProtocolType = (
    Pptp = 0,
    L2tp = 1,
    IpsecIkev2 = 2
  );
  PVpnNativeProtocolType = ^VpnNativeProtocolType;

  // Windows.Networking.Vpn.VpnAuthenticationMethod
  VpnAuthenticationMethod = (
    Mschapv2 = 0,
    Eap = 1,
    Certificate = 2,
    PresharedKey = 3
  );
  PVpnAuthenticationMethod = ^VpnAuthenticationMethod;

  // Windows.Networking.Vpn.VpnManagementErrorStatus
  VpnManagementErrorStatus = (
    Ok = 0,
    Other = 1,
    InvalidXmlSyntax = 2,
    ProfileNameTooLong = 3,
    ProfileInvalidAppId = 4,
    AccessDenied = 5
  );
  PVpnManagementErrorStatus = ^VpnManagementErrorStatus;



  // Windows.Security Enums
  // Windows.Security.EnterpriseData.ProtectionPolicyEvaluationResult
  EnterpriseData_ProtectionPolicyEvaluationResult = (
    Allowed = 0,
    Blocked = 1,
    ConsentRequired = 2
  );
  PEnterpriseData_ProtectionPolicyEvaluationResult = ^EnterpriseData_ProtectionPolicyEvaluationResult;

  // Windows.Security.Authentication.OnlineId.CredentialPromptType
  Authentication_OnlineId_CredentialPromptType = (
    PromptIfNeeded = 0,
    RetypeCredentials = 1,
    DoNotPrompt = 2
  );
  PAuthentication_OnlineId_CredentialPromptType = ^Authentication_OnlineId_CredentialPromptType;

  // Windows.Security.Authentication.Web.Provider.WebAccountProviderOperationKind
  Authentication_Web_Provider_WebAccountProviderOperationKind = (
    RequestToken = 0,
    GetTokenSilently = 1,
    AddAccount = 2,
    ManageAccount = 3,
    DeleteAccount = 4,
    RetrieveCookies = 5,
    SignOutAccount = 6
  );
  PAuthentication_Web_Provider_WebAccountProviderOperationKind = ^Authentication_Web_Provider_WebAccountProviderOperationKind;

  // Windows.Security.Authentication.Web.Core.WebTokenRequestPromptType
  Authentication_Web_Core_WebTokenRequestPromptType = (
    Default = 0,
    ForceAuthentication = 1
  );
  PAuthentication_Web_Core_WebTokenRequestPromptType = ^Authentication_Web_Core_WebTokenRequestPromptType;

  // Windows.Security.Authentication.Web.TokenBindingKeyType
  Authentication_Web_TokenBindingKeyType = (
    Rsa2048 = 0,
    EcdsaP256 = 1
  );
  PAuthentication_Web_TokenBindingKeyType = ^Authentication_Web_TokenBindingKeyType;

  // Windows.Security.Authentication.Web.Provider.WebAccountSelectionOptions
  Authentication_Web_Provider_WebAccountSelectionOptions = (
    Default = 0,
    New = 1
  );
  PAuthentication_Web_Provider_WebAccountSelectionOptions = ^Authentication_Web_Provider_WebAccountSelectionOptions;

  // Windows.Security.Authentication.Web.Provider.WebAccountClientViewType
  Authentication_Web_Provider_WebAccountClientViewType = (
    IdOnly = 0,
    IdAndProperties = 1
  );
  PAuthentication_Web_Provider_WebAccountClientViewType = ^Authentication_Web_Provider_WebAccountClientViewType;

  // Windows.Security.Authentication.Web.Provider.WebAccountScope
  Authentication_Web_Provider_WebAccountScope = (
    PerUser = 0,
    PerApplication = 1
  );
  PAuthentication_Web_Provider_WebAccountScope = ^Authentication_Web_Provider_WebAccountScope;

  // Windows.Security.Authentication.Web.Core.WebTokenRequestStatus
  Authentication_Web_Core_WebTokenRequestStatus = (
    Success = 0,
    UserCancel = 1,
    AccountSwitch = 2,
    UserInteractionRequired = 3,
    AccountProviderNotAvailable = 4,
    ProviderError = 5
  );
  PAuthentication_Web_Core_WebTokenRequestStatus = ^Authentication_Web_Core_WebTokenRequestStatus;

  // Windows.Security.Authentication.Web.WebAuthenticationStatus
  Authentication_Web_WebAuthenticationStatus = (
    Success = 0,
    UserCancel = 1,
    ErrorHttp = 2
  );
  PAuthentication_Web_WebAuthenticationStatus = ^Authentication_Web_WebAuthenticationStatus;

  // Windows.Security.Authentication.Web.WebAuthenticationOptions
  Authentication_Web_WebAuthenticationOptions = (
    None = 0,
    SilentMode = 1,
    UseTitle = 2,
    UseHttpPost = 4,
    UseCorporateNetwork = 8
  );
  PAuthentication_Web_WebAuthenticationOptions = ^Authentication_Web_WebAuthenticationOptions;

  // Windows.Security.EnterpriseData.FileProtectionStatus
  EnterpriseData_FileProtectionStatus = (
    Undetermined = 0,
    Unknown = 0,
    Unprotected = 1,
    Revoked = 2,
    Protected = 3,
    ProtectedByOtherUser = 4,
    ProtectedToOtherEnterprise = 5,
    NotProtectable = 6,
    ProtectedToOtherIdentity = 7
  );
  PEnterpriseData_FileProtectionStatus = ^EnterpriseData_FileProtectionStatus;

  // Windows.Security.EnterpriseData.ProtectedImportExportStatus
  EnterpriseData_ProtectedImportExportStatus = (
    Ok = 0,
    Undetermined = 1,
    Unprotected = 2,
    Revoked = 3,
    NotRoamable = 4,
    ProtectedToOtherIdentity = 5
  );
  PEnterpriseData_ProtectedImportExportStatus = ^EnterpriseData_ProtectedImportExportStatus;

  // Windows.Security.EnterpriseData.DataProtectionStatus
  EnterpriseData_DataProtectionStatus = (
    ProtectedToOtherIdentity = 0,
    Protected = 1,
    Revoked = 2,
    Unprotected = 3
  );
  PEnterpriseData_DataProtectionStatus = ^EnterpriseData_DataProtectionStatus;

  // Windows.Security.ExchangeActiveSyncProvisioning.EasRequireEncryptionResult
  ExchangeActiveSyncProvisioning_EasRequireEncryptionResult = (
    NotEvaluated = 0,
    Compliant = 1,
    CanBeCompliant = 2,
    NotProvisionedOnAllVolumes = 3,
    DeFixedDataNotSupported = 4,
    FixedDataNotSupported = 4,
    DeHardwareNotCompliant = 5,
    HardwareNotCompliant = 5,
    DeWinReNotConfigured = 6,
    LockNotConfigured = 6,
    DeProtectionSuspended = 7,
    ProtectionSuspended = 7,
    DeOsVolumeNotProtected = 8,
    OsVolumeNotProtected = 8,
    DeProtectionNotYetEnabled = 9,
    ProtectionNotYetEnabled = 9,
    NoFeatureLicense = 10,
    OsNotProtected = 11,
    UnexpectedFailure = 12
  );
  PExchangeActiveSyncProvisioning_EasRequireEncryptionResult = ^ExchangeActiveSyncProvisioning_EasRequireEncryptionResult;

  // Windows.Security.ExchangeActiveSyncProvisioning.EasEncryptionProviderType
  ExchangeActiveSyncProvisioning_EasEncryptionProviderType = (
    NotEvaluated = 0,
    WindowsEncryption = 1,
    OtherEncryption = 2
  );
  PExchangeActiveSyncProvisioning_EasEncryptionProviderType = ^ExchangeActiveSyncProvisioning_EasEncryptionProviderType;

  // Windows.Security.ExchangeActiveSyncProvisioning.EasMinPasswordLengthResult
  ExchangeActiveSyncProvisioning_EasMinPasswordLengthResult = (
    NotEvaluated = 0,
    Compliant = 1,
    CanBeCompliant = 2,
    RequestedPolicyIsStricter = 3,
    RequestedPolicyNotEnforceable = 4,
    InvalidParameter = 5,
    CurrentUserHasBlankPassword = 6,
    AdminsHaveBlankPassword = 7,
    UserCannotChangePassword = 8,
    AdminsCannotChangePassword = 9,
    LocalControlledUsersCannotChangePassword = 10,
    ConnectedAdminsProviderPolicyIsWeak = 11,
    ConnectedUserProviderPolicyIsWeak = 12,
    ChangeConnectedAdminsPassword = 13,
    ChangeConnectedUserPassword = 14
  );
  PExchangeActiveSyncProvisioning_EasMinPasswordLengthResult = ^ExchangeActiveSyncProvisioning_EasMinPasswordLengthResult;

  // Windows.Security.ExchangeActiveSyncProvisioning.EasDisallowConvenienceLogonResult
  ExchangeActiveSyncProvisioning_EasDisallowConvenienceLogonResult = (
    NotEvaluated = 0,
    Compliant = 1,
    CanBeCompliant = 2,
    RequestedPolicyIsStricter = 3
  );
  PExchangeActiveSyncProvisioning_EasDisallowConvenienceLogonResult = ^ExchangeActiveSyncProvisioning_EasDisallowConvenienceLogonResult;

  // Windows.Security.ExchangeActiveSyncProvisioning.EasMinPasswordComplexCharactersResult
  ExchangeActiveSyncProvisioning_EasMinPasswordComplexCharactersResult = (
    NotEvaluated = 0,
    Compliant = 1,
    CanBeCompliant = 2,
    RequestedPolicyIsStricter = 3,
    RequestedPolicyNotEnforceable = 4,
    InvalidParameter = 5,
    CurrentUserHasBlankPassword = 6,
    AdminsHaveBlankPassword = 7,
    UserCannotChangePassword = 8,
    AdminsCannotChangePassword = 9,
    LocalControlledUsersCannotChangePassword = 10,
    ConnectedAdminsProviderPolicyIsWeak = 11,
    ConnectedUserProviderPolicyIsWeak = 12,
    ChangeConnectedAdminsPassword = 13,
    ChangeConnectedUserPassword = 14
  );
  PExchangeActiveSyncProvisioning_EasMinPasswordComplexCharactersResult = ^ExchangeActiveSyncProvisioning_EasMinPasswordComplexCharactersResult;

  // Windows.Security.ExchangeActiveSyncProvisioning.EasPasswordExpirationResult
  ExchangeActiveSyncProvisioning_EasPasswordExpirationResult = (
    NotEvaluated = 0,
    Compliant = 1,
    CanBeCompliant = 2,
    RequestedPolicyIsStricter = 3,
    RequestedExpirationIncompatible = 4,
    InvalidParameter = 5,
    UserCannotChangePassword = 6,
    AdminsCannotChangePassword = 7,
    LocalControlledUsersCannotChangePassword = 8
  );
  PExchangeActiveSyncProvisioning_EasPasswordExpirationResult = ^ExchangeActiveSyncProvisioning_EasPasswordExpirationResult;

  // Windows.Security.ExchangeActiveSyncProvisioning.EasPasswordHistoryResult
  ExchangeActiveSyncProvisioning_EasPasswordHistoryResult = (
    NotEvaluated = 0,
    Compliant = 1,
    CanBeCompliant = 2,
    RequestedPolicyIsStricter = 3,
    InvalidParameter = 4
  );
  PExchangeActiveSyncProvisioning_EasPasswordHistoryResult = ^ExchangeActiveSyncProvisioning_EasPasswordHistoryResult;

  // Windows.Security.ExchangeActiveSyncProvisioning.EasMaxPasswordFailedAttemptsResult
  ExchangeActiveSyncProvisioning_EasMaxPasswordFailedAttemptsResult = (
    NotEvaluated = 0,
    Compliant = 1,
    CanBeCompliant = 2,
    RequestedPolicyIsStricter = 3,
    InvalidParameter = 4
  );
  PExchangeActiveSyncProvisioning_EasMaxPasswordFailedAttemptsResult = ^ExchangeActiveSyncProvisioning_EasMaxPasswordFailedAttemptsResult;

  // Windows.Security.ExchangeActiveSyncProvisioning.EasMaxInactivityTimeLockResult
  ExchangeActiveSyncProvisioning_EasMaxInactivityTimeLockResult = (
    NotEvaluated = 0,
    Compliant = 1,
    CanBeCompliant = 2,
    RequestedPolicyIsStricter = 3,
    InvalidParameter = 4
  );
  PExchangeActiveSyncProvisioning_EasMaxInactivityTimeLockResult = ^ExchangeActiveSyncProvisioning_EasMaxInactivityTimeLockResult;


  // Windows.Security Records
  // Windows.Security.EnterpriseData.EnterpriseDataContract
  EnterpriseData_EnterpriseDataContract = record
  end;
  PEnterpriseData_EnterpriseDataContract = ^EnterpriseData_EnterpriseDataContract;

  // Windows.Security.ExchangeActiveSyncProvisioning.EasContract
  ExchangeActiveSyncProvisioning_EasContract = record
  end;
  PExchangeActiveSyncProvisioning_EasContract = ^ExchangeActiveSyncProvisioning_EasContract;



  // Windows.Security.Credentials Enums
  // Windows.Security.Credentials.UI.AuthenticationProtocol
  UI_AuthenticationProtocol = (
    Basic = 0,
    Digest = 1,
    Ntlm = 2,
    Kerberos = 3,
    Negotiate = 4,
    CredSsp = 5,
    Custom = 6
  );
  PUI_AuthenticationProtocol = ^UI_AuthenticationProtocol;

  // Windows.Security.Credentials.UI.CredentialSaveOption
  UI_CredentialSaveOption = (
    Unselected = 0,
    Selected = 1,
    Hidden = 2
  );
  PUI_CredentialSaveOption = ^UI_CredentialSaveOption;

  // Windows.Security.Credentials.UI.UserConsentVerifierAvailability
  UI_UserConsentVerifierAvailability = (
    Available = 0,
    DeviceNotPresent = 1,
    NotConfiguredForUser = 2,
    DisabledByPolicy = 3,
    DeviceBusy = 4
  );
  PUI_UserConsentVerifierAvailability = ^UI_UserConsentVerifierAvailability;

  // Windows.Security.Credentials.UI.UserConsentVerificationResult
  UI_UserConsentVerificationResult = (
    Verified = 0,
    DeviceNotPresent = 1,
    NotConfiguredForUser = 2,
    DisabledByPolicy = 3,
    DeviceBusy = 4,
    RetriesExhausted = 5,
    Canceled = 6
  );
  PUI_UserConsentVerificationResult = ^UI_UserConsentVerificationResult;

  // Windows.Security.Credentials.WebAccountState
  WebAccountState = (
    None = 0,
    Connected = 1,
    Error = 2
  );
  PWebAccountState = ^WebAccountState;

  // Windows.Security.Credentials.WebAccountPictureSize
  WebAccountPictureSize = (
    Size64x64 = 64,
    Size208x208 = 208,
    Size424x424 = 424,
    Size1080x1080 = 1080
  );
  PWebAccountPictureSize = ^WebAccountPictureSize;

  // Windows.Security.Credentials.KeyCredentialStatus
  KeyCredentialStatus = (
    Success = 0,
    UnknownError = 1,
    NotFound = 2,
    UserCanceled = 3,
    UserPrefersPassword = 4,
    CredentialAlreadyExists = 5,
    SecurityDeviceLocked = 6
  );
  PKeyCredentialStatus = ^KeyCredentialStatus;

  // Windows.Security.Credentials.KeyCredentialAttestationStatus
  KeyCredentialAttestationStatus = (
    Success = 0,
    UnknownError = 1,
    NotSupported = 2,
    TemporaryFailure = 3
  );
  PKeyCredentialAttestationStatus = ^KeyCredentialAttestationStatus;

  // Windows.Security.Credentials.KeyCredentialCreationOption
  KeyCredentialCreationOption = (
    ReplaceExisting = 0,
    FailIfExists = 1
  );
  PKeyCredentialCreationOption = ^KeyCredentialCreationOption;



  // Windows.Security.Cryptography Enums
  // Windows.Security.Cryptography.Certificates.EnrollKeyUsages
  Certificates_EnrollKeyUsages = (
    None = 0,
    Decryption = 1,
    Signing = 2,
    KeyAgreement = 4,
    All = 16777215
  );
  PCertificates_EnrollKeyUsages = ^Certificates_EnrollKeyUsages;

  // Windows.Security.Cryptography.Certificates.KeyProtectionLevel
  Certificates_KeyProtectionLevel = (
    NoConsent = 0,
    ConsentOnly = 1,
    ConsentWithPassword = 2,
    ConsentWithFingerprint = 3
  );
  PCertificates_KeyProtectionLevel = ^Certificates_KeyProtectionLevel;

  // Windows.Security.Cryptography.Certificates.ExportOption
  Certificates_ExportOption = (
    NotExportable = 0,
    Exportable = 1
  );
  PCertificates_ExportOption = ^Certificates_ExportOption;

  // Windows.Security.Cryptography.Certificates.KeySize
  Certificates_KeySize = (
    Invalid = 0,
    Rsa2048 = 2048,
    Rsa4096 = 4096
  );
  PCertificates_KeySize = ^Certificates_KeySize;

  // Windows.Security.Cryptography.Certificates.InstallOptions
  Certificates_InstallOptions = (
    None = 0,
    DeleteExpired = 1
  );
  PCertificates_InstallOptions = ^Certificates_InstallOptions;

  // Windows.Security.Cryptography.Certificates.CertificateChainPolicy
  Certificates_CertificateChainPolicy = (
    Base = 0,
    Ssl = 1,
    NTAuthentication = 2,
    MicrosoftRoot = 3
  );
  PCertificates_CertificateChainPolicy = ^Certificates_CertificateChainPolicy;

  // Windows.Security.Cryptography.Certificates.ChainValidationResult
  Certificates_ChainValidationResult = (
    Success = 0,
    Untrusted = 1,
    Revoked = 2,
    Expired = 3,
    IncompleteChain = 4,
    InvalidSignature = 5,
    WrongUsage = 6,
    InvalidName = 7,
    InvalidCertificateAuthorityPolicy = 8,
    BasicConstraintsError = 9,
    UnknownCriticalExtension = 10,
    RevocationInformationMissing = 11,
    RevocationFailure = 12,
    OtherErrors = 13
  );
  PCertificates_ChainValidationResult = ^Certificates_ChainValidationResult;

  // Windows.Security.Cryptography.Certificates.SignatureValidationResult
  Certificates_SignatureValidationResult = (
    Success = 0,
    InvalidParameter = 1,
    BadMessage = 2,
    InvalidSignature = 3,
    OtherErrors = 4
  );
  PCertificates_SignatureValidationResult = ^Certificates_SignatureValidationResult;

  // Windows.Security.Cryptography.Core.CryptographicPrivateKeyBlobType
  Core_CryptographicPrivateKeyBlobType = (
    Pkcs8RawPrivateKeyInfo = 0,
    Pkcs1RsaPrivateKey = 1,
    BCryptPrivateKey = 2,
    Capi1PrivateKey = 3,
    BCryptEccFullPrivateKey = 4
  );
  PCore_CryptographicPrivateKeyBlobType = ^Core_CryptographicPrivateKeyBlobType;

  // Windows.Security.Cryptography.Core.CryptographicPublicKeyBlobType
  Core_CryptographicPublicKeyBlobType = (
    X509SubjectPublicKeyInfo = 0,
    Pkcs1RsaPublicKey = 1,
    BCryptPublicKey = 2,
    Capi1PublicKey = 3,
    BCryptEccFullPublicKey = 4
  );
  PCore_CryptographicPublicKeyBlobType = ^Core_CryptographicPublicKeyBlobType;

  // Windows.Security.Cryptography.Core.Capi1KdfTargetAlgorithm
  Core_Capi1KdfTargetAlgorithm = (
    NotAes = 0,
    Aes = 1
  );
  PCore_Capi1KdfTargetAlgorithm = ^Core_Capi1KdfTargetAlgorithm;

  // Windows.Security.Cryptography.Core.CryptographicPadding
  Core_CryptographicPadding = (
    None = 0,
    RsaOaep = 1,
    RsaPkcs1V15 = 2,
    RsaPss = 3
  );
  PCore_CryptographicPadding = ^Core_CryptographicPadding;

  // Windows.Security.Cryptography.BinaryStringEncoding
  BinaryStringEncoding = (
    Utf8 = 0,
    Utf16LE = 1,
    Utf16BE = 2
  );
  PBinaryStringEncoding = ^BinaryStringEncoding;



  // Windows.UI Enums
  // Windows.UI.ApplicationSettings.WebAccountAction
  ApplicationSettings_WebAccountAction = (
    Reconnect = 0,
    Remove = 1,
    ViewDetails = 2,
    Manage = 3,
    More = 4
  );
  PApplicationSettings_WebAccountAction = ^ApplicationSettings_WebAccountAction;

  // Windows.UI.ApplicationSettings.SupportedWebAccountActions
  ApplicationSettings_SupportedWebAccountActions = (
    None = 0,
    Reconnect = 1,
    Remove = 2,
    ViewDetails = 4,
    Manage = 8,
    More = 16
  );
  PApplicationSettings_SupportedWebAccountActions = ^ApplicationSettings_SupportedWebAccountActions;

  // Windows.UI.Popups.MessageDialogOptions
  Popups_MessageDialogOptions = (
    None = 0,
    AcceptUserInputAfterDelay = 1
  );
  PPopups_MessageDialogOptions = ^Popups_MessageDialogOptions;

  // Windows.UI.Popups.Placement
  Popups_Placement = (
    Default = 0,
    Above = 1,
    Below = 2,
    Left = 3,
    Right = 4
  );
  PPopups_Placement = ^Popups_Placement;

  // Windows.UI.StartScreen.TileOptions
  StartScreen_TileOptions = (
    None = 0,
    ShowNameOnLogo = 1,
    ShowNameOnWideLogo = 2,
    CopyOnDeployment = 4
  );
  PStartScreen_TileOptions = ^StartScreen_TileOptions;

  // Windows.UI.StartScreen.TileSize
  StartScreen_TileSize = (
    Default = 0,
    Square30x30 = 1,
    Square70x70 = 2,
    Square150x150 = 3,
    Wide310x150 = 4,
    Square310x310 = 5,
    Square71x71 = 6,
    Square44x44 = 7
  );
  PStartScreen_TileSize = ^StartScreen_TileSize;

  // Windows.UI.StartScreen.ForegroundText
  StartScreen_ForegroundText = (
    Dark = 0,
    Light = 1
  );
  PStartScreen_ForegroundText = ^StartScreen_ForegroundText;

  // Windows.UI.ApplicationSettings.SettingsEdgeLocation
  ApplicationSettings_SettingsEdgeLocation = (
    Right = 0,
    Left = 1
  );
  PApplicationSettings_SettingsEdgeLocation = ^ApplicationSettings_SettingsEdgeLocation;


  // Windows.UI Records
  // Windows.UI.Color
  Color = record
    A: Byte;
    R: Byte;
    G: Byte;
    B: Byte;
  end;
  PColor = ^Color;

  // Windows.UI.ApplicationSettings.ApplicationsSettingsContract
  ApplicationSettings_ApplicationsSettingsContract = record
  end;
  PApplicationSettings_ApplicationsSettingsContract = ^ApplicationSettings_ApplicationsSettingsContract;



  // Windows.UI.Composition Enums
  // Windows.UI.Composition.AnimationEndReason
  AnimationEndReason = (
    Stopped = 0,
    Completed = 1,
    Disconnected = 2
  );
  PAnimationEndReason = ^AnimationEndReason;

  // Windows.UI.Composition.AnimationIterationBehavior
  AnimationIterationBehavior = (
    Count = 0,
    Forever = 1
  );
  PAnimationIterationBehavior = ^AnimationIterationBehavior;

  // Windows.UI.Composition.AnimationStopBehavior
  AnimationStopBehavior = (
    LeaveCurrentValue = 0,
    SetToInitialValue = 1,
    SetToFinalValue = 2
  );
  PAnimationStopBehavior = ^AnimationStopBehavior;

  // Windows.UI.Composition.CompositionEffectFactoryLoadStatus
  CompositionEffectFactoryLoadStatus = (
    Success = 0,
    EffectTooComplex = 1,
    Other = 2
  );
  PCompositionEffectFactoryLoadStatus = ^CompositionEffectFactoryLoadStatus;

  // Windows.UI.Composition.CompositionGetValueStatus
  CompositionGetValueStatus = (
    Succeeded = 0,
    TypeMismatch = 1,
    NotFound = 2
  );
  PCompositionGetValueStatus = ^CompositionGetValueStatus;

  // Windows.UI.Composition.CompositionImageLoadStatus
  CompositionImageLoadStatus = (
    Success = 0,
    FileAccessError = 1,
    DecodeError = 2,
    NotEnoughResources = 3,
    Other = 4
  );
  PCompositionImageLoadStatus = ^CompositionImageLoadStatus;

  // Windows.UI.Composition.CompositionImageProgressStage
  CompositionImageProgressStage = (
    None = 0,
    HeaderDecoded = 30
  );
  PCompositionImageProgressStage = ^CompositionImageProgressStage;

  // Windows.UI.Composition.CompositionStretch
  CompositionStretch = (
    None = 0,
    Fill = 1,
    Uniform = 2,
    UniformToFill = 3
  );
  PCompositionStretch = ^CompositionStretch;



  // Windows.UI.Core Enums
  // Windows.UI.Core.CoreWindowActivationState
  CoreWindowActivationState = (
    CodeActivated = 0,
    Deactivated = 1,
    PointerActivated = 2
  );
  PCoreWindowActivationState = ^CoreWindowActivationState;

  // Windows.UI.Core.CoreCursorType
  CoreCursorType = (
    Arrow = 0,
    Cross = 1,
    Custom = 2,
    Hand = 3,
    Help = 4,
    IBeam = 5,
    SizeAll = 6,
    SizeNortheastSouthwest = 7,
    SizeNorthSouth = 8,
    SizeNorthwestSoutheast = 9,
    SizeWestEast = 10,
    UniversalNo = 11,
    UpArrow = 12,
    Wait = 13
  );
  PCoreCursorType = ^CoreCursorType;

  // Windows.UI.Core.CoreDispatcherPriority
  CoreDispatcherPriority = (
    Idle = -2,
    Low = -1,
    Normal = 0,
    High = 1
  );
  PCoreDispatcherPriority = ^CoreDispatcherPriority;

  // Windows.UI.Core.CoreProcessEventsOption
  CoreProcessEventsOption = (
    ProcessOneAndAllPending = 0,
    ProcessOneIfPresent = 1,
    ProcessUntilQuit = 2,
    ProcessAllIfPresent = 3
  );
  PCoreProcessEventsOption = ^CoreProcessEventsOption;

  // Windows.UI.Core.CoreWindowFlowDirection
  CoreWindowFlowDirection = (
    LeftToRight = 0,
    RightToLeft = 1
  );
  PCoreWindowFlowDirection = ^CoreWindowFlowDirection;

  // Windows.UI.Core.CoreVirtualKeyStates
  CoreVirtualKeyStates = (
    None = 0,
    Down = 1,
    Locked = 2
  );
  PCoreVirtualKeyStates = ^CoreVirtualKeyStates;

  // Windows.UI.Core.CoreAcceleratorKeyEventType
  CoreAcceleratorKeyEventType = (
    Character = 2,
    DeadCharacter = 3,
    KeyDown = 0,
    KeyUp = 1,
    SystemCharacter = 6,
    SystemDeadCharacter = 7,
    SystemKeyDown = 4,
    SystemKeyUp = 5,
    UnicodeCharacter = 8
  );
  PCoreAcceleratorKeyEventType = ^CoreAcceleratorKeyEventType;

  // Windows.UI.Core.CoreProximityEvaluationScore
  CoreProximityEvaluationScore = (
    Closest = 0,
    Farthest = 2147483647
  );
  PCoreProximityEvaluationScore = ^CoreProximityEvaluationScore;

  // Windows.UI.Core.CoreInputDeviceTypes
  CoreInputDeviceTypes = (
    None = 0,
    Touch = 1,
    Pen = 2,
    Mouse = 4
  );
  PCoreInputDeviceTypes = ^CoreInputDeviceTypes;

  // Windows.UI.Core.AppViewBackButtonVisibility
  AppViewBackButtonVisibility = (
    Visible = 0,
    Collapsed = 1
  );
  PAppViewBackButtonVisibility = ^AppViewBackButtonVisibility;

  // Windows.UI.Core.AnimationMetrics.PropertyAnimationType
  AnimationMetrics_PropertyAnimationType = (
    Scale = 0,
    Translation = 1,
    Opacity = 2
  );
  PAnimationMetrics_PropertyAnimationType = ^AnimationMetrics_PropertyAnimationType;

  // Windows.UI.Core.AnimationMetrics.AnimationEffect
  AnimationMetrics_AnimationEffect = (
    Expand = 0,
    Collapse = 1,
    Reposition = 2,
    FadeIn = 3,
    FadeOut = 4,
    AddToList = 5,
    DeleteFromList = 6,
    AddToGrid = 7,
    DeleteFromGrid = 8,
    AddToSearchGrid = 9,
    DeleteFromSearchGrid = 10,
    AddToSearchList = 11,
    DeleteFromSearchList = 12,
    ShowEdgeUI = 13,
    ShowPanel = 14,
    HideEdgeUI = 15,
    HidePanel = 16,
    ShowPopup = 17,
    HidePopup = 18,
    PointerDown = 19,
    PointerUp = 20,
    DragSourceStart = 21,
    DragSourceEnd = 22,
    TransitionContent = 23,
    Reveal = 24,
    Hide = 25,
    DragBetweenEnter = 26,
    DragBetweenLeave = 27,
    SwipeSelect = 28,
    SwipeDeselect = 29,
    SwipeReveal = 30,
    EnterPage = 31,
    TransitionPage = 32,
    CrossFade = 33,
    Peek = 34,
    UpdateBadge = 35
  );
  PAnimationMetrics_AnimationEffect = ^AnimationMetrics_AnimationEffect;

  // Windows.UI.Core.AnimationMetrics.AnimationEffectTarget
  AnimationMetrics_AnimationEffectTarget = (
    Primary = 0,
    Added = 1,
    Affected = 2,
    Background = 3,
    Content = 4,
    Deleted = 5,
    Deselected = 6,
    DragSource = 7,
    Hidden = 8,
    Incoming = 9,
    Outgoing = 10,
    Outline = 11,
    Remaining = 12,
    Revealed = 13,
    RowIn = 14,
    RowOut = 15,
    Selected = 16,
    Selection = 17,
    Shown = 18,
    Tapped = 19
  );
  PAnimationMetrics_AnimationEffectTarget = ^AnimationMetrics_AnimationEffectTarget;


  // Windows.UI.Core Records
  // Windows.UI.Core.CorePhysicalKeyStatus
  CorePhysicalKeyStatus = record
    RepeatCount: Cardinal;
    ScanCode: Cardinal;
    IsExtendedKey: Boolean;
    IsMenuKeyDown: Boolean;
    WasKeyDown: Boolean;
    IsKeyReleased: Boolean;
  end;
  PCorePhysicalKeyStatus = ^CorePhysicalKeyStatus;

  // Windows.UI.Core.CoreProximityEvaluation
  CoreProximityEvaluation = record
    Score: Integer;
    AdjustedPoint: TPointF;
  end;
  PCoreProximityEvaluation = ^CoreProximityEvaluation;

  // Windows.UI.Core.AnimationMetrics.AnimationMetricsContract
  AnimationMetrics_AnimationMetricsContract = record
  end;
  PAnimationMetrics_AnimationMetricsContract = ^AnimationMetrics_AnimationMetricsContract;

  // Windows.UI.Core.CoreWindowDialogsContract
  CoreWindowDialogsContract = record
  end;
  PCoreWindowDialogsContract = ^CoreWindowDialogsContract;



  // Windows.UI.Input.Inking Enums
  // Windows.UI.Input.Inking.InkPresenterPredefinedConfiguration
  InkPresenterPredefinedConfiguration = (
    SimpleSinglePointer = 0,
    SimpleMultiplePointer = 1
  );
  PInkPresenterPredefinedConfiguration = ^InkPresenterPredefinedConfiguration;

  // Windows.UI.Input.Inking.InkInputRightDragAction
  InkInputRightDragAction = (
    LeaveUnprocessed = 0,
    AllowProcessing = 1
  );
  PInkInputRightDragAction = ^InkInputRightDragAction;

  // Windows.UI.Input.Inking.InkInputProcessingMode
  InkInputProcessingMode = (
    None = 0,
    Inking = 1,
    Erasing = 2
  );
  PInkInputProcessingMode = ^InkInputProcessingMode;

  // Windows.UI.Input.Inking.InkManipulationMode
  InkManipulationMode = (
    Inking = 0,
    Erasing = 1,
    Selecting = 2
  );
  PInkManipulationMode = ^InkManipulationMode;

  // Windows.UI.Input.Inking.InkRecognitionTarget
  InkRecognitionTarget = (
    All = 0,
    Selected = 1,
    Recent = 2
  );
  PInkRecognitionTarget = ^InkRecognitionTarget;

  // Windows.UI.Input.Inking.PenTipShape
  PenTipShape = (
    Circle = 0,
    Rectangle = 1
  );
  PPenTipShape = ^PenTipShape;



  // Windows.UI.Input Enums
  // Windows.UI.Input.EdgeGestureKind
  EdgeGestureKind = (
    Touch = 0,
    Keyboard = 1,
    Mouse = 2
  );
  PEdgeGestureKind = ^EdgeGestureKind;

  // Windows.UI.Input.HoldingState
  HoldingState = (
    Started = 0,
    Completed = 1,
    Canceled = 2
  );
  PHoldingState = ^HoldingState;

  // Windows.UI.Input.DraggingState
  DraggingState = (
    Started = 0,
    Continuing = 1,
    Completed = 2
  );
  PDraggingState = ^DraggingState;

  // Windows.UI.Input.CrossSlidingState
  CrossSlidingState = (
    Started = 0,
    Dragging = 1,
    Selecting = 2,
    SelectSpeedBumping = 3,
    SpeedBumping = 4,
    Rearranging = 5,
    Completed = 6
  );
  PCrossSlidingState = ^CrossSlidingState;

  // Windows.UI.Input.GestureSettings
  GestureSettings = (
    None = 0,
    Tap = 1,
    DoubleTap = 2,
    Hold = 4,
    HoldWithMouse = 8,
    RightTap = 16,
    Drag = 32,
    ManipulationTranslateX = 64,
    ManipulationTranslateY = 128,
    ManipulationTranslateRailsX = 256,
    ManipulationTranslateRailsY = 512,
    ManipulationRotate = 1024,
    ManipulationScale = 2048,
    ManipulationTranslateInertia = 4096,
    ManipulationRotateInertia = 8192,
    ManipulationScaleInertia = 16384,
    CrossSlide = 32768,
    ManipulationMultipleFingerPanning = 65536
  );
  PGestureSettings = ^GestureSettings;

  // Windows.UI.Input.PointerUpdateKind
  PointerUpdateKind = (
    Other = 0,
    LeftButtonPressed = 1,
    LeftButtonReleased = 2,
    RightButtonPressed = 3,
    RightButtonReleased = 4,
    MiddleButtonPressed = 5,
    MiddleButtonReleased = 6,
    XButton1Pressed = 7,
    XButton1Released = 8,
    XButton2Pressed = 9,
    XButton2Released = 10
  );
  PPointerUpdateKind = ^PointerUpdateKind;


  // Windows.UI.Input Records
  // Windows.UI.Input.ManipulationDelta
  ManipulationDelta = record
    Translation: TPointF;
    Scale: Single;
    Rotation: Single;
    Expansion: Single;
  end;
  PManipulationDelta = ^ManipulationDelta;

  // Windows.UI.Input.ManipulationVelocities
  ManipulationVelocities = record
    Linear: TPointF;
    Angular: Single;
    Expansion: Single;
  end;
  PManipulationVelocities = ^ManipulationVelocities;

  // Windows.UI.Input.CrossSlideThresholds
  CrossSlideThresholds = record
    SelectionStart: Single;
    SpeedBumpStart: Single;
    SpeedBumpEnd: Single;
    RearrangeStart: Single;
  end;
  PCrossSlideThresholds = ^CrossSlideThresholds;



  // Windows.UI.Notifications Enums
  // Windows.UI.Notifications.NotificationSetting
  NotificationSetting = (
    Enabled = 0,
    DisabledForApplication = 1,
    DisabledForUser = 2,
    DisabledByGroupPolicy = 3,
    DisabledByManifest = 4
  );
  PNotificationSetting = ^NotificationSetting;

  // Windows.UI.Notifications.ToastDismissalReason
  ToastDismissalReason = (
    UserCanceled = 0,
    ApplicationHidden = 1,
    TimedOut = 2
  );
  PToastDismissalReason = ^ToastDismissalReason;

  // Windows.UI.Notifications.BadgeTemplateType
  BadgeTemplateType = (
    BadgeGlyph = 0,
    BadgeNumber = 1
  );
  PBadgeTemplateType = ^BadgeTemplateType;

  // Windows.UI.Notifications.TileFlyoutTemplateType
  TileFlyoutTemplateType = (
    TileFlyoutTemplate01 = 0
  );
  PTileFlyoutTemplateType = ^TileFlyoutTemplateType;

  // Windows.UI.Notifications.TileTemplateType
  TileTemplateType = (
    TileSquareImage = 0,
    TileSquareBlock = 1,
    TileSquareText01 = 2,
    TileSquareText02 = 3,
    TileSquareText03 = 4,
    TileSquareText04 = 5,
    TileSquarePeekImageAndText01 = 6,
    TileSquarePeekImageAndText02 = 7,
    TileSquarePeekImageAndText03 = 8,
    TileSquarePeekImageAndText04 = 9,
    TileWideImage = 10,
    TileWideImageCollection = 11,
    TileWideImageAndText01 = 12,
    TileWideImageAndText02 = 13,
    TileWideBlockAndText01 = 14,
    TileWideBlockAndText02 = 15,
    TileWidePeekImageCollection01 = 16,
    TileWidePeekImageCollection02 = 17,
    TileWidePeekImageCollection03 = 18,
    TileWidePeekImageCollection04 = 19,
    TileWidePeekImageCollection05 = 20,
    TileWidePeekImageCollection06 = 21,
    TileWidePeekImageAndText01 = 22,
    TileWidePeekImageAndText02 = 23,
    TileWidePeekImage01 = 24,
    TileWidePeekImage02 = 25,
    TileWidePeekImage03 = 26,
    TileWidePeekImage04 = 27,
    TileWidePeekImage05 = 28,
    TileWidePeekImage06 = 29,
    TileWideSmallImageAndText01 = 30,
    TileWideSmallImageAndText02 = 31,
    TileWideSmallImageAndText03 = 32,
    TileWideSmallImageAndText04 = 33,
    TileWideSmallImageAndText05 = 34,
    TileWideText01 = 35,
    TileWideText02 = 36,
    TileWideText03 = 37,
    TileWideText04 = 38,
    TileWideText05 = 39,
    TileWideText06 = 40,
    TileWideText07 = 41,
    TileWideText08 = 42,
    TileWideText09 = 43,
    TileWideText10 = 44,
    TileWideText11 = 45,
    TileSquare150x150Image = 0,
    TileSquare150x150Block = 1,
    TileSquare150x150Text01 = 2,
    TileSquare150x150Text02 = 3,
    TileSquare150x150Text03 = 4,
    TileSquare150x150Text04 = 5,
    TileSquare150x150PeekImageAndText01 = 6,
    TileSquare150x150PeekImageAndText02 = 7,
    TileSquare150x150PeekImageAndText03 = 8,
    TileSquare150x150PeekImageAndText04 = 9,
    TileWide310x150Image = 10,
    TileWide310x150ImageCollection = 11,
    TileWide310x150ImageAndText01 = 12,
    TileWide310x150ImageAndText02 = 13,
    TileWide310x150BlockAndText01 = 14,
    TileWide310x150BlockAndText02 = 15,
    TileWide310x150PeekImageCollection01 = 16,
    TileWide310x150PeekImageCollection02 = 17,
    TileWide310x150PeekImageCollection03 = 18,
    TileWide310x150PeekImageCollection04 = 19,
    TileWide310x150PeekImageCollection05 = 20,
    TileWide310x150PeekImageCollection06 = 21,
    TileWide310x150PeekImageAndText01 = 22,
    TileWide310x150PeekImageAndText02 = 23,
    TileWide310x150PeekImage01 = 24,
    TileWide310x150PeekImage02 = 25,
    TileWide310x150PeekImage03 = 26,
    TileWide310x150PeekImage04 = 27,
    TileWide310x150PeekImage05 = 28,
    TileWide310x150PeekImage06 = 29,
    TileWide310x150SmallImageAndText01 = 30,
    TileWide310x150SmallImageAndText02 = 31,
    TileWide310x150SmallImageAndText03 = 32,
    TileWide310x150SmallImageAndText04 = 33,
    TileWide310x150SmallImageAndText05 = 34,
    TileWide310x150Text01 = 35,
    TileWide310x150Text02 = 36,
    TileWide310x150Text03 = 37,
    TileWide310x150Text04 = 38,
    TileWide310x150Text05 = 39,
    TileWide310x150Text06 = 40,
    TileWide310x150Text07 = 41,
    TileWide310x150Text08 = 42,
    TileWide310x150Text09 = 43,
    TileWide310x150Text10 = 44,
    TileWide310x150Text11 = 45,
    TileSquare310x310BlockAndText01 = 46,
    TileSquare310x310BlockAndText02 = 47,
    TileSquare310x310Image = 48,
    TileSquare310x310ImageAndText01 = 49,
    TileSquare310x310ImageAndText02 = 50,
    TileSquare310x310ImageAndTextOverlay01 = 51,
    TileSquare310x310ImageAndTextOverlay02 = 52,
    TileSquare310x310ImageAndTextOverlay03 = 53,
    TileSquare310x310ImageCollectionAndText01 = 54,
    TileSquare310x310ImageCollectionAndText02 = 55,
    TileSquare310x310ImageCollection = 56,
    TileSquare310x310SmallImagesAndTextList01 = 57,
    TileSquare310x310SmallImagesAndTextList02 = 58,
    TileSquare310x310SmallImagesAndTextList03 = 59,
    TileSquare310x310SmallImagesAndTextList04 = 60,
    TileSquare310x310Text01 = 61,
    TileSquare310x310Text02 = 62,
    TileSquare310x310Text03 = 63,
    TileSquare310x310Text04 = 64,
    TileSquare310x310Text05 = 65,
    TileSquare310x310Text06 = 66,
    TileSquare310x310Text07 = 67,
    TileSquare310x310Text08 = 68,
    TileSquare310x310TextList01 = 69,
    TileSquare310x310TextList02 = 70,
    TileSquare310x310TextList03 = 71,
    TileSquare310x310SmallImageAndText01 = 72,
    TileSquare310x310SmallImagesAndTextList05 = 73,
    TileSquare310x310Text09 = 74,
    TileSquare71x71IconWithBadge = 75,
    TileSquare150x150IconWithBadge = 76,
    TileWide310x150IconWithBadgeAndText = 77,
    TileSquare71x71Image = 78,
    TileTall150x310Image = 79
  );
  PTileTemplateType = ^TileTemplateType;

  // Windows.UI.Notifications.ToastTemplateType
  ToastTemplateType = (
    ToastImageAndText01 = 0,
    ToastImageAndText02 = 1,
    ToastImageAndText03 = 2,
    ToastImageAndText04 = 3,
    ToastText01 = 4,
    ToastText02 = 5,
    ToastText03 = 6,
    ToastText04 = 7
  );
  PToastTemplateType = ^ToastTemplateType;

  // Windows.UI.Notifications.PeriodicUpdateRecurrence
  PeriodicUpdateRecurrence = (
    HalfHour = 0,
    Hour = 1,
    SixHours = 2,
    TwelveHours = 3,
    Daily = 4
  );
  PPeriodicUpdateRecurrence = ^PeriodicUpdateRecurrence;

  // Windows.UI.Notifications.ToastHistoryChangedType
  ToastHistoryChangedType = (
    Cleared = 0,
    Removed = 1,
    Expired = 2,
    Added = 3
  );
  PToastHistoryChangedType = ^ToastHistoryChangedType;



  // Windows.UI.Text Enums
  // Windows.UI.Text.CaretType
  CaretType = (
    Normal = 0,
    Null = 1
  );
  PCaretType = ^CaretType;

  // Windows.UI.Text.FindOptions
  FindOptions = (
    None = 0,
    Word = 2,
    &Case = 4
  );
  PFindOptions = ^FindOptions;

  // Windows.UI.Text.FormatEffect
  FormatEffect = (
    Off = 0,
    On = 1,
    Toggle = 2,
    Undefined = 3
  );
  PFormatEffect = ^FormatEffect;

  // Windows.UI.Text.HorizontalCharacterAlignment
  HorizontalCharacterAlignment = (
    Left = 0,
    Right = 1,
    Center = 2
  );
  PHorizontalCharacterAlignment = ^HorizontalCharacterAlignment;

  // Windows.UI.Text.LetterCase
  LetterCase = (
    Lower = 0,
    Upper = 1
  );
  PLetterCase = ^LetterCase;

  // Windows.UI.Text.LineSpacingRule
  LineSpacingRule = (
    Undefined = 0,
    Single = 1,
    OneAndHalf = 2,
    Double = 3,
    AtLeast = 4,
    Exactly = 5,
    Multiple = 6,
    Percent = 7
  );
  PLineSpacingRule = ^LineSpacingRule;

  // Windows.UI.Text.LinkType
  LinkType = (
    Undefined = 0,
    NotALink = 1,
    ClientLink = 2,
    FriendlyLinkName = 3,
    FriendlyLinkAddress = 4,
    AutoLink = 5,
    AutoLinkEmail = 6,
    AutoLinkPhone = 7,
    AutoLinkPath = 8
  );
  PLinkType = ^LinkType;

  // Windows.UI.Text.MarkerAlignment
  MarkerAlignment = (
    Undefined = 0,
    Left = 1,
    Center = 2,
    Right = 3
  );
  PMarkerAlignment = ^MarkerAlignment;

  // Windows.UI.Text.MarkerStyle
  MarkerStyle = (
    Undefined = 0,
    Parenthesis = 1,
    Parentheses = 2,
    Period = 3,
    Plain = 4,
    Minus = 5,
    NoNumber = 6
  );
  PMarkerStyle = ^MarkerStyle;

  // Windows.UI.Text.MarkerType
  MarkerType = (
    Undefined = 0,
    None = 1,
    Bullet = 2,
    Arabic = 3,
    LowercaseEnglishLetter = 4,
    UppercaseEnglishLetter = 5,
    LowercaseRoman = 6,
    UppercaseRoman = 7,
    UnicodeSequence = 8,
    CircledNumber = 9,
    BlackCircleWingding = 10,
    WhiteCircleWingding = 11,
    ArabicWide = 12,
    SimplifiedChinese = 13,
    TraditionalChinese = 14,
    JapanSimplifiedChinese = 15,
    JapanKorea = 16,
    ArabicDictionary = 17,
    ArabicAbjad = 18,
    Hebrew = 19,
    ThaiAlphabetic = 20,
    ThaiNumeric = 21,
    DevanagariVowel = 22,
    DevanagariConsonant = 23,
    DevanagariNumeric = 24
  );
  PMarkerType = ^MarkerType;

  // Windows.UI.Text.ParagraphAlignment
  ParagraphAlignment = (
    Undefined = 0,
    Left = 1,
    Center = 2,
    Right = 3,
    Justify = 4
  );
  PParagraphAlignment = ^ParagraphAlignment;

  // Windows.UI.Text.ParagraphStyle
  ParagraphStyle = (
    Undefined = 0,
    None = 1,
    Normal = 2,
    Heading1 = 3,
    Heading2 = 4,
    Heading3 = 5,
    Heading4 = 6,
    Heading5 = 7,
    Heading6 = 8,
    Heading7 = 9,
    Heading8 = 10,
    Heading9 = 11
  );
  PParagraphStyle = ^ParagraphStyle;

  // Windows.UI.Text.PointOptions
  PointOptions = (
    None = 0,
    IncludeInset = 1,
    Start = 32,
    ClientCoordinates = 256,
    AllowOffClient = 512,
    Transform = 1024,
    NoHorizontalScroll = 65536,
    NoVerticalScroll = 262144
  );
  PPointOptions = ^PointOptions;

  // Windows.UI.Text.RangeGravity
  RangeGravity = (
    UIBehavior = 0,
    Backward = 1,
    Forward = 2,
    Inward = 3,
    Outward = 4
  );
  PRangeGravity = ^RangeGravity;

  // Windows.UI.Text.SelectionOptions
  SelectionOptions = (
    StartActive = 1,
    AtEndOfLine = 2,
    Overtype = 4,
    Active = 8,
    Replace = 16
  );
  PSelectionOptions = ^SelectionOptions;

  // Windows.UI.Text.SelectionType
  SelectionType = (
    None = 0,
    InsertionPoint = 1,
    Normal = 2,
    InlineShape = 7,
    Shape = 8
  );
  PSelectionType = ^SelectionType;

  // Windows.UI.Text.TabAlignment
  TabAlignment = (
    Left = 0,
    Center = 1,
    Right = 2,
    Decimal = 3,
    Bar = 4
  );
  PTabAlignment = ^TabAlignment;

  // Windows.UI.Text.TabLeader
  TabLeader = (
    Spaces = 0,
    Dots = 1,
    Dashes = 2,
    Lines = 3,
    ThickLines = 4,
    Equals = 5
  );
  PTabLeader = ^TabLeader;

  // Windows.UI.Text.TextGetOptions
  TextGetOptions = (
    None = 0,
    AdjustCrlf = 1,
    UseCrlf = 2,
    UseObjectText = 4,
    AllowFinalEop = 8,
    NoHidden = 32,
    IncludeNumbering = 64,
    FormatRtf = 8192
  );
  PTextGetOptions = ^TextGetOptions;

  // Windows.UI.Text.TextSetOptions
  TextSetOptions = (
    None = 0,
    UnicodeBidi = 1,
    Unlink = 8,
    Unhide = 16,
    CheckTextLimit = 32,
    FormatRtf = 8192,
    ApplyRtfDocumentDefaults = 16384
  );
  PTextSetOptions = ^TextSetOptions;

  // Windows.UI.Text.TextRangeUnit
  TextRangeUnit = (
    Character = 0,
    Word = 1,
    Sentence = 2,
    Paragraph = 3,
    Line = 4,
    Story = 5,
    Screen = 6,
    Section = 7,
    Window = 8,
    CharacterFormat = 9,
    ParagraphFormat = 10,
    &Object = 11,
    HardParagraph = 12,
    Cluster = 13,
    Bold = 14,
    Italic = 15,
    Underline = 16,
    Strikethrough = 17,
    ProtectedText = 18,
    Link = 19,
    SmallCaps = 20,
    AllCaps = 21,
    Hidden = 22,
    Outline = 23,
    Shadow = 24,
    Imprint = 25,
    Disabled = 26,
    Revised = 27,
    Subscript = 28,
    Superscript = 29,
    FontBound = 30,
    LinkProtected = 31
  );
  PTextRangeUnit = ^TextRangeUnit;

  // Windows.UI.Text.TextScript
  TextScript = (
    Undefined = 0,
    Ansi = 1,
    EastEurope = 2,
    Cyrillic = 3,
    Greek = 4,
    Turkish = 5,
    Hebrew = 6,
    Arabic = 7,
    Baltic = 8,
    Vietnamese = 9,
    Default = 10,
    Symbol = 11,
    Thai = 12,
    ShiftJis = 13,
    GB2312 = 14,
    Hangul = 15,
    Big5 = 16,
    PC437 = 17,
    Oem = 18,
    Mac = 19,
    Armenian = 20,
    Syriac = 21,
    Thaana = 22,
    Devanagari = 23,
    Bengali = 24,
    Gurmukhi = 25,
    Gujarati = 26,
    Oriya = 27,
    Tamil = 28,
    Telugu = 29,
    Kannada = 30,
    Malayalam = 31,
    Sinhala = 32,
    Lao = 33,
    Tibetan = 34,
    Myanmar = 35,
    Georgian = 36,
    Jamo = 37,
    Ethiopic = 38,
    Cherokee = 39,
    Aboriginal = 40,
    Ogham = 41,
    Runic = 42,
    Khmer = 43,
    Mongolian = 44,
    Braille = 45,
    Yi = 46,
    Limbu = 47,
    TaiLe = 48,
    NewTaiLue = 49,
    SylotiNagri = 50,
    Kharoshthi = 51,
    Kayahli = 52,
    UnicodeSymbol = 53,
    Emoji = 54,
    Glagolitic = 55,
    Lisu = 56,
    Vai = 57,
    NKo = 58,
    Osmanya = 59,
    PhagsPa = 60,
    Gothic = 61,
    Deseret = 62,
    Tifinagh = 63
  );
  PTextScript = ^TextScript;

  // Windows.UI.Text.UnderlineType
  UnderlineType = (
    Undefined = 0,
    None = 1,
    Single = 2,
    Words = 3,
    Double = 4,
    Dotted = 5,
    Dash = 6,
    DashDot = 7,
    DashDotDot = 8,
    Wave = 9,
    Thick = 10,
    Thin = 11,
    DoubleWave = 12,
    HeavyWave = 13,
    LongDash = 14,
    ThickDash = 15,
    ThickDashDot = 16,
    ThickDashDotDot = 17,
    ThickDotted = 18,
    ThickLongDash = 19
  );
  PUnderlineType = ^UnderlineType;

  // Windows.UI.Text.VerticalCharacterAlignment
  VerticalCharacterAlignment = (
    Top = 0,
    Baseline = 1,
    Bottom = 2
  );
  PVerticalCharacterAlignment = ^VerticalCharacterAlignment;

  // Windows.UI.Text.Core.CoreTextInputScope
  Core_CoreTextInputScope = (
    Default = 0,
    Url = 1,
    FilePath = 2,
    FileName = 3,
    EmailUserName = 4,
    EmailAddress = 5,
    UserName = 6,
    PersonalFullName = 7,
    PersonalNamePrefix = 8,
    PersonalGivenName = 9,
    PersonalMiddleName = 10,
    PersonalSurname = 11,
    PersonalNameSuffix = 12,
    Address = 13,
    AddressPostalCode = 14,
    AddressStreet = 15,
    AddressStateOrProvince = 16,
    AddressCity = 17,
    AddressCountryName = 18,
    AddressCountryShortName = 19,
    CurrencyAmountAndSymbol = 20,
    CurrencyAmount = 21,
    Date = 22,
    DateMonth = 23,
    DateDay = 24,
    DateYear = 25,
    DateMonthName = 26,
    DateDayName = 27,
    Number = 29,
    SingleCharacter = 30,
    Password = 31,
    TelephoneNumber = 32,
    TelephoneCountryCode = 33,
    TelephoneAreaCode = 34,
    TelephoneLocalNumber = 35,
    Time = 36,
    TimeHour = 37,
    TimeMinuteOrSecond = 38,
    NumberFullWidth = 39,
    AlphanumericHalfWidth = 40,
    AlphanumericFullWidth = 41,
    CurrencyChinese = 42,
    Bopomofo = 43,
    Hiragana = 44,
    KatakanaHalfWidth = 45,
    KatakanaFullWidth = 46,
    Hanja = 47,
    HangulHalfWidth = 48,
    HangulFullWidth = 49,
    Search = 50,
    Formula = 51,
    SearchIncremental = 52,
    ChineseHalfWidth = 53,
    ChineseFullWidth = 54,
    NativeScript = 55,
    Text = 57,
    Chat = 58,
    NameOrPhoneNumber = 59,
    EmailUserNameOrAddress = 60,
    Private = 61,
    Maps = 62,
    PasswordNumeric = 63,
    FormulaNumber = 67
  );
  PCore_CoreTextInputScope = ^Core_CoreTextInputScope;

  // Windows.UI.Text.Core.CoreTextInputPaneDisplayPolicy
  Core_CoreTextInputPaneDisplayPolicy = (
    Automatic = 0,
    Manual = 1
  );
  PCore_CoreTextInputPaneDisplayPolicy = ^Core_CoreTextInputPaneDisplayPolicy;

  // Windows.UI.Text.Core.CoreTextTextUpdatingResult
  Core_CoreTextTextUpdatingResult = (
    Succeeded = 0,
    Failed = 1
  );
  PCore_CoreTextTextUpdatingResult = ^Core_CoreTextTextUpdatingResult;

  // Windows.UI.Text.Core.CoreTextSelectionUpdatingResult
  Core_CoreTextSelectionUpdatingResult = (
    Succeeded = 0,
    Failed = 1
  );
  PCore_CoreTextSelectionUpdatingResult = ^Core_CoreTextSelectionUpdatingResult;

  // Windows.UI.Text.Core.CoreTextFormatUpdatingResult
  Core_CoreTextFormatUpdatingResult = (
    Succeeded = 0,
    Failed = 1
  );
  PCore_CoreTextFormatUpdatingResult = ^Core_CoreTextFormatUpdatingResult;

  // Windows.UI.Text.Core.CoreTextFormatUpdatingReason
  Core_CoreTextFormatUpdatingReason = (
    None = 0,
    CompositionUnconverted = 1,
    CompositionConverted = 2,
    CompositionTargetUnconverted = 3,
    CompositionTargetConverted = 4
  );
  PCore_CoreTextFormatUpdatingReason = ^Core_CoreTextFormatUpdatingReason;

  // Windows.UI.Text.FontStretch
  FontStretch = (
    Undefined = 0,
    UltraCondensed = 1,
    ExtraCondensed = 2,
    Condensed = 3,
    SemiCondensed = 4,
    Normal = 5,
    SemiExpanded = 6,
    Expanded = 7,
    ExtraExpanded = 8,
    UltraExpanded = 9
  );
  PFontStretch = ^FontStretch;

  // Windows.UI.Text.FontStyle
  FontStyle = (
    Normal = 0,
    Oblique = 1,
    Italic = 2
  );
  PFontStyle = ^FontStyle;


  // Windows.UI.Text Records
  // Windows.UI.Text.Core.CoreTextRange
  Core_CoreTextRange = record
    StartCaretPosition: Integer;
    EndCaretPosition: Integer;
  end;
  PCore_CoreTextRange = ^Core_CoreTextRange;

  // Windows.UI.Text.FontWeight
  FontWeight = record
    Weight: Word;
  end;
  PFontWeight = ^FontWeight;



  // Windows.UI.ViewManagement Enums
  // Windows.UI.ViewManagement.ApplicationViewState
  ApplicationViewState = (
    FullScreenLandscape = 0,
    Filled = 1,
    Snapped = 2,
    FullScreenPortrait = 3
  );
  PApplicationViewState = ^ApplicationViewState;

  // Windows.UI.ViewManagement.ApplicationViewOrientation
  ApplicationViewOrientation = (
    Landscape = 0,
    Portrait = 1
  );
  PApplicationViewOrientation = ^ApplicationViewOrientation;

  // Windows.UI.ViewManagement.ApplicationViewSwitchingOptions
  ApplicationViewSwitchingOptions = (
    Default = 0,
    SkipAnimation = 1,
    ConsolidateViews = 2
  );
  PApplicationViewSwitchingOptions = ^ApplicationViewSwitchingOptions;

  // Windows.UI.ViewManagement.ViewSizePreference
  ViewSizePreference = (
    Default = 0,
    UseLess = 1,
    UseHalf = 2,
    UseMore = 3,
    UseMinimum = 4,
    UseNone = 5
  );
  PViewSizePreference = ^ViewSizePreference;

  // Windows.UI.ViewManagement.ApplicationViewBoundsMode
  ApplicationViewBoundsMode = (
    UseVisible = 0,
    UseCoreWindow = 1
  );
  PApplicationViewBoundsMode = ^ApplicationViewBoundsMode;

  // Windows.UI.ViewManagement.FullScreenSystemOverlayMode
  FullScreenSystemOverlayMode = (
    Standard = 0,
    Minimal = 1
  );
  PFullScreenSystemOverlayMode = ^FullScreenSystemOverlayMode;

  // Windows.UI.ViewManagement.ApplicationViewWindowingMode
  ApplicationViewWindowingMode = (
    Auto = 0,
    PreferredLaunchViewSize = 1,
    FullScreen = 2
  );
  PApplicationViewWindowingMode = ^ApplicationViewWindowingMode;

  // Windows.UI.ViewManagement.UserInteractionMode
  UserInteractionMode = (
    Mouse = 0,
    Touch = 1
  );
  PUserInteractionMode = ^UserInteractionMode;

  // Windows.UI.ViewManagement.HandPreference
  HandPreference = (
    LeftHanded = 0,
    RightHanded = 1
  );
  PHandPreference = ^HandPreference;

  // Windows.UI.ViewManagement.UIColorType
  UIColorType = (
    Background = 0,
    Foreground = 1,
    AccentDark3 = 2,
    AccentDark2 = 3,
    AccentDark1 = 4,
    Accent = 5,
    AccentLight1 = 6,
    AccentLight2 = 7,
    AccentLight3 = 8,
    Complement = 9
  );
  PUIColorType = ^UIColorType;

  // Windows.UI.ViewManagement.UIElementType
  UIElementType = (
    ActiveCaption = 0,
    Background = 1,
    ButtonFace = 2,
    ButtonText = 3,
    CaptionText = 4,
    GrayText = 5,
    Highlight = 6,
    HighlightText = 7,
    Hotlight = 8,
    InactiveCaption = 9,
    InactiveCaptionText = 10,
    Window = 11,
    WindowText = 12
  );
  PUIElementType = ^UIElementType;



  // Windows.UI.WebUI Enums
  // Windows.UI.WebUI.PrintContent
  PrintContent = (
    AllPages = 0,
    CurrentPage = 1,
    CustomPageRange = 2,
    CurrentSelection = 3
  );
  PPrintContent = ^PrintContent;



  // Windows.UI.Xaml Enums
  // Windows.UI.Xaml.Documents.LogicalDirection
  Documents_LogicalDirection = (
    Backward = 0,
    Forward = 1
  );
  PDocuments_LogicalDirection = ^Documents_LogicalDirection;

  // Windows.UI.Xaml.Documents.UnderlineStyle
  Documents_UnderlineStyle = (
    None = 0,
    Single = 1
  );
  PDocuments_UnderlineStyle = ^Documents_UnderlineStyle;

  // Windows.UI.Xaml.Controls.CandidateWindowAlignment
  Controls_CandidateWindowAlignment = (
    Default = 0,
    BottomEdge = 1
  );
  PControls_CandidateWindowAlignment = ^Controls_CandidateWindowAlignment;

  // Windows.UI.Xaml.Controls.ClickMode
  Controls_ClickMode = (
    Release = 0,
    Press = 1,
    Hover = 2
  );
  PControls_ClickMode = ^Controls_ClickMode;

  // Windows.UI.Xaml.Controls.IncrementalLoadingTrigger
  Controls_IncrementalLoadingTrigger = (
    None = 0,
    Edge = 1
  );
  PControls_IncrementalLoadingTrigger = ^Controls_IncrementalLoadingTrigger;

  // Windows.UI.Xaml.Controls.ItemsUpdatingScrollMode
  Controls_ItemsUpdatingScrollMode = (
    KeepItemsInView = 0,
    KeepScrollOffset = 1
  );
  PControls_ItemsUpdatingScrollMode = ^Controls_ItemsUpdatingScrollMode;

  // Windows.UI.Xaml.Controls.ListViewReorderMode
  Controls_ListViewReorderMode = (
    Disabled = 0,
    Enabled = 1
  );
  PControls_ListViewReorderMode = ^Controls_ListViewReorderMode;

  // Windows.UI.Xaml.Controls.ListViewSelectionMode
  Controls_ListViewSelectionMode = (
    None = 0,
    Single = 1,
    Multiple = 2,
    Extended = 3
  );
  PControls_ListViewSelectionMode = ^Controls_ListViewSelectionMode;

  // Windows.UI.Xaml.Controls.Orientation
  Controls_Orientation = (
    Vertical = 0,
    Horizontal = 1
  );
  PControls_Orientation = ^Controls_Orientation;

  // Windows.UI.Xaml.Controls.PanelScrollingDirection
  Controls_PanelScrollingDirection = (
    None = 0,
    Forward = 1,
    Backward = 2
  );
  PControls_PanelScrollingDirection = ^Controls_PanelScrollingDirection;

  // Windows.UI.Xaml.Controls.PasswordRevealMode
  Controls_PasswordRevealMode = (
    Peek = 0,
    Hidden = 1,
    Visible = 2
  );
  PControls_PasswordRevealMode = ^Controls_PasswordRevealMode;

  // Windows.UI.Xaml.Controls.ScrollBarVisibility
  Controls_ScrollBarVisibility = (
    Disabled = 0,
    Auto = 1,
    Hidden = 2,
    Visible = 3
  );
  PControls_ScrollBarVisibility = ^Controls_ScrollBarVisibility;

  // Windows.UI.Xaml.Controls.ScrollIntoViewAlignment
  Controls_ScrollIntoViewAlignment = (
    Default = 0,
    Leading = 1
  );
  PControls_ScrollIntoViewAlignment = ^Controls_ScrollIntoViewAlignment;

  // Windows.UI.Xaml.Controls.ScrollMode
  Controls_ScrollMode = (
    Disabled = 0,
    Enabled = 1,
    Auto = 2
  );
  PControls_ScrollMode = ^Controls_ScrollMode;

  // Windows.UI.Xaml.Controls.SelectionMode
  Controls_SelectionMode = (
    Single = 0,
    Multiple = 1,
    Extended = 2
  );
  PControls_SelectionMode = ^Controls_SelectionMode;

  // Windows.UI.Xaml.Controls.SnapPointsType
  Controls_SnapPointsType = (
    None = 0,
    Optional = 1,
    Mandatory = 2,
    OptionalSingle = 3,
    MandatorySingle = 4
  );
  PControls_SnapPointsType = ^Controls_SnapPointsType;

  // Windows.UI.Xaml.Controls.StretchDirection
  Controls_StretchDirection = (
    UpOnly = 0,
    DownOnly = 1,
    Both = 2
  );
  PControls_StretchDirection = ^Controls_StretchDirection;

  // Windows.UI.Xaml.Controls.VirtualizationMode
  Controls_VirtualizationMode = (
    Standard = 0,
    Recycling = 1
  );
  PControls_VirtualizationMode = ^Controls_VirtualizationMode;

  // Windows.UI.Xaml.Controls.ZoomMode
  Controls_ZoomMode = (
    Disabled = 0,
    Enabled = 1
  );
  PControls_ZoomMode = ^Controls_ZoomMode;

  // Windows.UI.Xaml.Controls.Primitives.GeneratorDirection
  Controls_Primitives_GeneratorDirection = (
    Forward = 0,
    Backward = 1
  );
  PControls_Primitives_GeneratorDirection = ^Controls_Primitives_GeneratorDirection;

  // Windows.UI.Xaml.Controls.Primitives.GroupHeaderPlacement
  Controls_Primitives_GroupHeaderPlacement = (
    Top = 0,
    Left = 1
  );
  PControls_Primitives_GroupHeaderPlacement = ^Controls_Primitives_GroupHeaderPlacement;

  // Windows.UI.Xaml.Controls.Primitives.PlacementMode
  Controls_Primitives_PlacementMode = (
    Bottom = 2,
    Left = 9,
    Mouse = 7,
    Right = 4,
    Top = 10
  );
  PControls_Primitives_PlacementMode = ^Controls_Primitives_PlacementMode;

  // Windows.UI.Xaml.Controls.Primitives.ScrollEventType
  Controls_Primitives_ScrollEventType = (
    SmallDecrement = 0,
    SmallIncrement = 1,
    LargeDecrement = 2,
    LargeIncrement = 3,
    ThumbPosition = 4,
    ThumbTrack = 5,
    First = 6,
    Last = 7,
    EndScroll = 8
  );
  PControls_Primitives_ScrollEventType = ^Controls_Primitives_ScrollEventType;

  // Windows.UI.Xaml.Controls.Primitives.ScrollingIndicatorMode
  Controls_Primitives_ScrollingIndicatorMode = (
    None = 0,
    TouchIndicator = 1,
    MouseIndicator = 2
  );
  PControls_Primitives_ScrollingIndicatorMode = ^Controls_Primitives_ScrollingIndicatorMode;

  // Windows.UI.Xaml.Controls.Primitives.SliderSnapsTo
  Controls_Primitives_SliderSnapsTo = (
    StepValues = 0,
    Ticks = 1
  );
  PControls_Primitives_SliderSnapsTo = ^Controls_Primitives_SliderSnapsTo;

  // Windows.UI.Xaml.Controls.Primitives.SnapPointsAlignment
  Controls_Primitives_SnapPointsAlignment = (
    Near = 0,
    Center = 1,
    Far = 2
  );
  PControls_Primitives_SnapPointsAlignment = ^Controls_Primitives_SnapPointsAlignment;

  // Windows.UI.Xaml.Controls.Primitives.TickPlacement
  Controls_Primitives_TickPlacement = (
    None = 0,
    TopLeft = 1,
    BottomRight = 2,
    Outside = 3,
    &Inline = 4
  );
  PControls_Primitives_TickPlacement = ^Controls_Primitives_TickPlacement;

  // Windows.UI.Xaml.Printing.PreviewPageCountType
  Printing_PreviewPageCountType = (
    Final = 0,
    Intermediate = 1
  );
  PPrinting_PreviewPageCountType = ^Printing_PreviewPageCountType;

  // Windows.UI.Xaml.Navigation.NavigationCacheMode
  Navigation_NavigationCacheMode = (
    Disabled = 0,
    Required = 1,
    Enabled = 2
  );
  PNavigation_NavigationCacheMode = ^Navigation_NavigationCacheMode;

  // Windows.UI.Xaml.Navigation.NavigationMode
  Navigation_NavigationMode = (
    New = 0,
    Back = 1,
    Forward = 2,
    Refresh = 3
  );
  PNavigation_NavigationMode = ^Navigation_NavigationMode;

  // Windows.UI.Xaml.Interop.NotifyCollectionChangedAction
  Interop_NotifyCollectionChangedAction = (
    Add = 0,
    Remove = 1,
    Replace = 2,
    Move = 3,
    Reset = 4
  );
  PInterop_NotifyCollectionChangedAction = ^Interop_NotifyCollectionChangedAction;

  // Windows.UI.Xaml.Media.MediaElementState
  Media_MediaElementState = (
    Closed = 0,
    Opening = 1,
    Buffering = 2,
    Playing = 3,
    Paused = 4,
    Stopped = 5
  );
  PMedia_MediaElementState = ^Media_MediaElementState;

  // Windows.UI.Xaml.Controls.AppBarClosedDisplayMode
  Controls_AppBarClosedDisplayMode = (
    Compact = 0,
    Minimal = 1,
    Hidden = 2
  );
  PControls_AppBarClosedDisplayMode = ^Controls_AppBarClosedDisplayMode;

  // Windows.UI.Xaml.Controls.AutoSuggestionBoxTextChangeReason
  Controls_AutoSuggestionBoxTextChangeReason = (
    UserInput = 0,
    ProgrammaticChange = 1,
    SuggestionChosen = 2
  );
  PControls_AutoSuggestionBoxTextChangeReason = ^Controls_AutoSuggestionBoxTextChangeReason;

  // Windows.UI.Xaml.Controls.CalendarViewDisplayMode
  Controls_CalendarViewDisplayMode = (
    Month = 0,
    Year = 1,
    Decade = 2
  );
  PControls_CalendarViewDisplayMode = ^Controls_CalendarViewDisplayMode;

  // Windows.UI.Xaml.Controls.CalendarViewSelectionMode
  Controls_CalendarViewSelectionMode = (
    None = 0,
    Single = 1,
    Multiple = 2
  );
  PControls_CalendarViewSelectionMode = ^Controls_CalendarViewSelectionMode;

  // Windows.UI.Xaml.Controls.ContentDialogResult
  Controls_ContentDialogResult = (
    None = 0,
    Primary = 1,
    Secondary = 2
  );
  PControls_ContentDialogResult = ^Controls_ContentDialogResult;

  // Windows.UI.Xaml.Controls.SplitViewDisplayMode
  Controls_SplitViewDisplayMode = (
    Overlay = 0,
    &Inline = 1,
    CompactOverlay = 2,
    CompactInline = 3
  );
  PControls_SplitViewDisplayMode = ^Controls_SplitViewDisplayMode;

  // Windows.UI.Xaml.Controls.SplitViewPanePlacement
  Controls_SplitViewPanePlacement = (
    Left = 0,
    Right = 1
  );
  PControls_SplitViewPanePlacement = ^Controls_SplitViewPanePlacement;

  // Windows.UI.Xaml.Controls.Symbol
  Controls_Symbol = (
    Previous = 57600,
    Next = 57601,
    Play = 57602,
    Pause = 57603,
    Edit = 57604,
    Save = 57605,
    Clear = 57606,
    Delete = 57607,
    Remove = 57608,
    Add = 57609,
    Cancel = 57610,
    Accept = 57611,
    More = 57612,
    Redo = 57613,
    Undo = 57614,
    Home = 57615,
    Up = 57616,
    Forward = 57617,
    Back = 57618,
    Favorite = 57619,
    Camera = 57620,
    Setting = 57621,
    Video = 57622,
    Sync = 57623,
    Download = 57624,
    Mail = 57625,
    Find = 57626,
    Help = 57627,
    Upload = 57628,
    Emoji = 57629,
    TwoPage = 57630,
    LeaveChat = 57631,
    MailForward = 57632,
    Clock = 57633,
    Send = 57634,
    Crop = 57635,
    RotateCamera = 57636,
    People = 57637,
    OpenPane = 57638,
    ClosePane = 57639,
    World = 57640,
    Flag = 57641,
    PreviewLink = 57642,
    Globe = 57643,
    Trim = 57644,
    AttachCamera = 57645,
    ZoomIn = 57646,
    Bookmarks = 57647,
    Document = 57648,
    ProtectedDocument = 57649,
    Page = 57650,
    Bullets = 57651,
    Comment = 57652,
    MailFilled = 57653,
    ContactInfo = 57654,
    HangUp = 57655,
    ViewAll = 57656,
    MapPin = 57657,
    Phone = 57658,
    VideoChat = 57659,
    Switch = 57660,
    Contact = 57661,
    Rename = 57662,
    Pin = 57665,
    MusicInfo = 57666,
    Go = 57667,
    Keyboard = 57668,
    DockLeft = 57669,
    DockRight = 57670,
    DockBottom = 57671,
    Remote = 57672,
    Refresh = 57673,
    Rotate = 57674,
    Shuffle = 57675,
    List = 57676,
    Shop = 57677,
    SelectAll = 57678,
    Orientation = 57679,
    Import = 57680,
    ImportAll = 57681,
    BrowsePhotos = 57685,
    WebCam = 57686,
    Pictures = 57688,
    SaveLocal = 57689,
    Caption = 57690,
    Stop = 57691,
    ShowResults = 57692,
    Volume = 57693,
    Repair = 57694,
    Message = 57695,
    Page2 = 57696,
    CalendarDay = 57697,
    CalendarWeek = 57698,
    Calendar = 57699,
    Character = 57700,
    MailReplyAll = 57701,
    Read = 57702,
    Link = 57703,
    Account = 57704,
    ShowBcc = 57705,
    HideBcc = 57706,
    Cut = 57707,
    Attach = 57708,
    Paste = 57709,
    Filter = 57710,
    Copy = 57711,
    Emoji2 = 57712,
    Important = 57713,
    MailReply = 57714,
    SlideShow = 57715,
    Sort = 57716,
    Manage = 57720,
    AllApps = 57721,
    DisconnectDrive = 57722,
    MapDrive = 57723,
    NewWindow = 57724,
    OpenWith = 57725,
    ContactPresence = 57729,
    Priority = 57730,
    GoToToday = 57732,
    Font = 57733,
    FontColor = 57734,
    Contact2 = 57735,
    Folder = 57736,
    Audio = 57737,
    Placeholder = 57738,
    View = 57739,
    SetLockScreen = 57740,
    SetTile = 57741,
    ClosedCaption = 57744,
    StopSlideShow = 57745,
    Permissions = 57746,
    Highlight = 57747,
    DisableUpdates = 57748,
    UnFavorite = 57749,
    UnPin = 57750,
    OpenLocal = 57751,
    Mute = 57752,
    Italic = 57753,
    Underline = 57754,
    Bold = 57755,
    MoveToFolder = 57756,
    LikeDislike = 57757,
    Dislike = 57758,
    Like = 57759,
    AlignRight = 57760,
    AlignCenter = 57761,
    AlignLeft = 57762,
    Zoom = 57763,
    ZoomOut = 57764,
    OpenFile = 57765,
    OtherUser = 57766,
    Admin = 57767,
    Street = 57795,
    Map = 57796,
    ClearSelection = 57797,
    FontDecrease = 57798,
    FontIncrease = 57799,
    FontSize = 57800,
    CellPhone = 57801,
    ReShare = 57802,
    Tag = 57803,
    RepeatOne = 57804,
    RepeatAll = 57805,
    OutlineStar = 57806,
    SolidStar = 57807,
    Calculator = 57808,
    Directions = 57809,
    Target = 57810,
    &Library = 57811,
    PhoneBook = 57812,
    Memo = 57813,
    Microphone = 57814,
    PostUpdate = 57815,
    BackToWindow = 57816,
    FullScreen = 57817,
    NewFolder = 57818,
    CalendarReply = 57819,
    UnSyncFolder = 57821,
    ReportHacked = 57822,
    SyncFolder = 57823,
    BlockContact = 57824,
    SwitchApps = 57825,
    AddFriend = 57826,
    TouchPointer = 57827,
    GoToStart = 57828,
    ZeroBars = 57829,
    OneBar = 57830,
    TwoBars = 57831,
    ThreeBars = 57832,
    FourBars = 57833,
    Scan = 58004,
    Preview = 58005
  );
  PControls_Symbol = ^Controls_Symbol;

  // Windows.UI.Xaml.Controls.WebViewExecutionMode
  Controls_WebViewExecutionMode = (
    SameThread = 0,
    SeparateThread = 1
  );
  PControls_WebViewExecutionMode = ^Controls_WebViewExecutionMode;

  // Windows.UI.Xaml.Controls.WebViewPermissionState
  Controls_WebViewPermissionState = (
    Unknown = 0,
    Defer = 1,
    Allow = 2,
    Deny = 3
  );
  PControls_WebViewPermissionState = ^Controls_WebViewPermissionState;

  // Windows.UI.Xaml.Controls.WebViewPermissionType
  Controls_WebViewPermissionType = (
    Geolocation = 0,
    UnlimitedIndexedDBQuota = 1,
    Media = 2
  );
  PControls_WebViewPermissionType = ^Controls_WebViewPermissionType;

  // Windows.UI.Xaml.Controls.Primitives.ListViewItemPresenterCheckMode
  Controls_Primitives_ListViewItemPresenterCheckMode = (
    &Inline = 0,
    Overlay = 1
  );
  PControls_Primitives_ListViewItemPresenterCheckMode = ^Controls_Primitives_ListViewItemPresenterCheckMode;

  // Windows.UI.Xaml.ApplicationTheme
  ApplicationTheme = (
    Light = 0,
    Dark = 1
  );
  PApplicationTheme = ^ApplicationTheme;

  // Windows.UI.Xaml.DurationType
  DurationType = (
    Automatic = 0,
    TimeSpan = 1,
    Forever = 2
  );
  PDurationType = ^DurationType;

  // Windows.UI.Xaml.ElementTheme
  ElementTheme = (
    Default = 0,
    Light = 1,
    Dark = 2
  );
  PElementTheme = ^ElementTheme;

  // Windows.UI.Xaml.FlowDirection
  FlowDirection = (
    LeftToRight = 0,
    RightToLeft = 1
  );
  PFlowDirection = ^FlowDirection;

  // Windows.UI.Xaml.FocusState
  FocusState = (
    Unfocused = 0,
    Pointer = 1,
    Keyboard = 2,
    Programmatic = 3
  );
  PFocusState = ^FocusState;

  // Windows.UI.Xaml.FontCapitals
  FontCapitals = (
    Normal = 0,
    AllSmallCaps = 1,
    SmallCaps = 2,
    AllPetiteCaps = 3,
    PetiteCaps = 4,
    Unicase = 5,
    Titling = 6
  );
  PFontCapitals = ^FontCapitals;

  // Windows.UI.Xaml.FontEastAsianLanguage
  FontEastAsianLanguage = (
    Normal = 0,
    HojoKanji = 1,
    Jis04 = 2,
    Jis78 = 3,
    Jis83 = 4,
    Jis90 = 5,
    NlcKanji = 6,
    Simplified = 7,
    Traditional = 8,
    TraditionalNames = 9
  );
  PFontEastAsianLanguage = ^FontEastAsianLanguage;

  // Windows.UI.Xaml.FontEastAsianWidths
  FontEastAsianWidths = (
    Normal = 0,
    Full = 1,
    Half = 2,
    Proportional = 3,
    Quarter = 4,
    Third = 5
  );
  PFontEastAsianWidths = ^FontEastAsianWidths;

  // Windows.UI.Xaml.FontFraction
  FontFraction = (
    Normal = 0,
    Stacked = 1,
    Slashed = 2
  );
  PFontFraction = ^FontFraction;

  // Windows.UI.Xaml.FontNumeralAlignment
  FontNumeralAlignment = (
    Normal = 0,
    Proportional = 1,
    Tabular = 2
  );
  PFontNumeralAlignment = ^FontNumeralAlignment;

  // Windows.UI.Xaml.FontNumeralStyle
  FontNumeralStyle = (
    Normal = 0,
    Lining = 1,
    OldStyle = 2
  );
  PFontNumeralStyle = ^FontNumeralStyle;

  // Windows.UI.Xaml.FontVariants
  FontVariants = (
    Normal = 0,
    Superscript = 1,
    Subscript = 2,
    Ordinal = 3,
    Inferior = 4,
    Ruby = 5
  );
  PFontVariants = ^FontVariants;

  // Windows.UI.Xaml.GridUnitType
  GridUnitType = (
    Auto = 0,
    Pixel = 1,
    Star = 2
  );
  PGridUnitType = ^GridUnitType;

  // Windows.UI.Xaml.HorizontalAlignment
  HorizontalAlignment = (
    Left = 0,
    Center = 1,
    Right = 2,
    Stretch = 3
  );
  PHorizontalAlignment = ^HorizontalAlignment;

  // Windows.UI.Xaml.LineStackingStrategy
  LineStackingStrategy = (
    MaxHeight = 0,
    BlockLineHeight = 1,
    BaselineToBaseline = 2
  );
  PLineStackingStrategy = ^LineStackingStrategy;

  // Windows.UI.Xaml.OpticalMarginAlignment
  OpticalMarginAlignment = (
    None = 0,
    TrimSideBearings = 1
  );
  POpticalMarginAlignment = ^OpticalMarginAlignment;

  // Windows.UI.Xaml.TextAlignment
  TextAlignment = (
    Center = 0,
    Left = 1,
    Right = 2,
    Justify = 3,
    DetectFromContent = 4
  );
  PTextAlignment = ^TextAlignment;

  // Windows.UI.Xaml.TextLineBounds
  TextLineBounds = (
    Full = 0,
    TrimToCapHeight = 1,
    TrimToBaseline = 2,
    Tight = 3
  );
  PTextLineBounds = ^TextLineBounds;

  // Windows.UI.Xaml.TextReadingOrder
  TextReadingOrder = (
    Default = 0,
    UseFlowDirection = 0,
    DetectFromContent = 1
  );
  PTextReadingOrder = ^TextReadingOrder;

  // Windows.UI.Xaml.TextTrimming
  TextTrimming = (
    None = 0,
    CharacterEllipsis = 1,
    WordEllipsis = 2,
    Clip = 3
  );
  PTextTrimming = ^TextTrimming;

  // Windows.UI.Xaml.TextWrapping
  TextWrapping = (
    NoWrap = 1,
    Wrap = 2,
    WrapWholeWords = 3
  );
  PTextWrapping = ^TextWrapping;

  // Windows.UI.Xaml.VerticalAlignment
  VerticalAlignment = (
    Top = 0,
    Center = 1,
    Bottom = 2,
    Stretch = 3
  );
  PVerticalAlignment = ^VerticalAlignment;

  // Windows.UI.Xaml.Visibility
  Visibility = (
    Visible = 0,
    Collapsed = 1
  );
  PVisibility = ^Visibility;

  // Windows.UI.Xaml.Media.AlignmentX
  Media_AlignmentX = (
    Left = 0,
    Center = 1,
    Right = 2
  );
  PMedia_AlignmentX = ^Media_AlignmentX;

  // Windows.UI.Xaml.Media.AlignmentY
  Media_AlignmentY = (
    Top = 0,
    Center = 1,
    Bottom = 2
  );
  PMedia_AlignmentY = ^Media_AlignmentY;

  // Windows.UI.Xaml.Media.AudioCategory
  Media_AudioCategory = (
    Other = 0,
    ForegroundOnlyMedia = 1,
    BackgroundCapableMedia = 2,
    Communications = 3,
    Alerts = 4,
    SoundEffects = 5,
    GameEffects = 6,
    GameMedia = 7,
    GameChat = 8,
    Speech = 9,
    Movie = 10,
    Media = 11
  );
  PMedia_AudioCategory = ^Media_AudioCategory;

  // Windows.UI.Xaml.Media.AudioDeviceType
  Media_AudioDeviceType = (
    Console = 0,
    Multimedia = 1,
    Communications = 2
  );
  PMedia_AudioDeviceType = ^Media_AudioDeviceType;

  // Windows.UI.Xaml.Media.BrushMappingMode
  Media_BrushMappingMode = (
    Absolute = 0,
    RelativeToBoundingBox = 1
  );
  PMedia_BrushMappingMode = ^Media_BrushMappingMode;

  // Windows.UI.Xaml.Media.ColorInterpolationMode
  Media_ColorInterpolationMode = (
    ScRgbLinearInterpolation = 0,
    SRgbLinearInterpolation = 1
  );
  PMedia_ColorInterpolationMode = ^Media_ColorInterpolationMode;

  // Windows.UI.Xaml.Media.ElementCompositeMode
  Media_ElementCompositeMode = (
    Inherit = 0,
    SourceOver = 1,
    MinBlend = 2
  );
  PMedia_ElementCompositeMode = ^Media_ElementCompositeMode;

  // Windows.UI.Xaml.Media.FillRule
  Media_FillRule = (
    EvenOdd = 0,
    Nonzero = 1
  );
  PMedia_FillRule = ^Media_FillRule;

  // Windows.UI.Xaml.Media.GradientSpreadMethod
  Media_GradientSpreadMethod = (
    Pad = 0,
    Reflect = 1,
    &Repeat = 2
  );
  PMedia_GradientSpreadMethod = ^Media_GradientSpreadMethod;

  // Windows.UI.Xaml.Media.MediaCanPlayResponse
  Media_MediaCanPlayResponse = (
    NotSupported = 0,
    Maybe = 1,
    Probably = 2
  );
  PMedia_MediaCanPlayResponse = ^Media_MediaCanPlayResponse;

  // Windows.UI.Xaml.Media.PenLineCap
  Media_PenLineCap = (
    Flat = 0,
    Square = 1,
    Round = 2,
    Triangle = 3
  );
  PMedia_PenLineCap = ^Media_PenLineCap;

  // Windows.UI.Xaml.Media.PenLineJoin
  Media_PenLineJoin = (
    Miter = 0,
    Bevel = 1,
    Round = 2
  );
  PMedia_PenLineJoin = ^Media_PenLineJoin;

  // Windows.UI.Xaml.Media.Stereo3DVideoPackingMode
  Media_Stereo3DVideoPackingMode = (
    None = 0,
    SideBySide = 1,
    TopBottom = 2
  );
  PMedia_Stereo3DVideoPackingMode = ^Media_Stereo3DVideoPackingMode;

  // Windows.UI.Xaml.Media.Stereo3DVideoRenderMode
  Media_Stereo3DVideoRenderMode = (
    Mono = 0,
    Stereo = 1
  );
  PMedia_Stereo3DVideoRenderMode = ^Media_Stereo3DVideoRenderMode;

  // Windows.UI.Xaml.Media.Stretch
  Media_Stretch = (
    None = 0,
    Fill = 1,
    Uniform = 2,
    UniformToFill = 3
  );
  PMedia_Stretch = ^Media_Stretch;

  // Windows.UI.Xaml.Media.StyleSimulations
  Media_StyleSimulations = (
    None = 0,
    BoldSimulation = 1,
    ItalicSimulation = 2,
    BoldItalicSimulation = 3
  );
  PMedia_StyleSimulations = ^Media_StyleSimulations;

  // Windows.UI.Xaml.Media.SweepDirection
  Media_SweepDirection = (
    Counterclockwise = 0,
    Clockwise = 1
  );
  PMedia_SweepDirection = ^Media_SweepDirection;

  // Windows.UI.Xaml.Media.Animation.ClockState
  Media_Animation_ClockState = (
    Active = 0,
    Filling = 1,
    Stopped = 2
  );
  PMedia_Animation_ClockState = ^Media_Animation_ClockState;

  // Windows.UI.Xaml.Media.Animation.EasingMode
  Media_Animation_EasingMode = (
    EaseOut = 0,
    EaseIn = 1,
    EaseInOut = 2
  );
  PMedia_Animation_EasingMode = ^Media_Animation_EasingMode;

  // Windows.UI.Xaml.Media.Animation.FillBehavior
  Media_Animation_FillBehavior = (
    HoldEnd = 0,
    Stop = 1
  );
  PMedia_Animation_FillBehavior = ^Media_Animation_FillBehavior;

  // Windows.UI.Xaml.Media.Animation.RepeatBehaviorType
  Media_Animation_RepeatBehaviorType = (
    Count = 0,
    Duration = 1,
    Forever = 2
  );
  PMedia_Animation_RepeatBehaviorType = ^Media_Animation_RepeatBehaviorType;

  // Windows.UI.Xaml.Input.FocusNavigationDirection
  Input_FocusNavigationDirection = (
    Next = 0,
    Previous = 1,
    Up = 2,
    Down = 3,
    Left = 4,
    Right = 5,
    None = 6
  );
  PInput_FocusNavigationDirection = ^Input_FocusNavigationDirection;

  // Windows.UI.Xaml.Input.InputScopeNameValue
  Input_InputScopeNameValue = (
    Default = 0,
    Url = 1,
    EmailSmtpAddress = 5,
    PersonalFullName = 7,
    CurrencyAmountAndSymbol = 20,
    CurrencyAmount = 21,
    DateMonthNumber = 23,
    DateDayNumber = 24,
    DateYear = 25,
    Digits = 28,
    Number = 29,
    Password = 31,
    TelephoneNumber = 32,
    TelephoneCountryCode = 33,
    TelephoneAreaCode = 34,
    TelephoneLocalNumber = 35,
    TimeHour = 37,
    TimeMinutesOrSeconds = 38,
    NumberFullWidth = 39,
    AlphanumericHalfWidth = 40,
    AlphanumericFullWidth = 41,
    Hiragana = 44,
    KatakanaHalfWidth = 45,
    KatakanaFullWidth = 46,
    Hanja = 47,
    HangulHalfWidth = 48,
    HangulFullWidth = 49,
    Search = 50,
    Formula = 51,
    SearchIncremental = 52,
    ChineseHalfWidth = 53,
    ChineseFullWidth = 54,
    NativeScript = 55,
    Text = 57,
    Chat = 58,
    NameOrPhoneNumber = 59,
    EmailNameOrAddress = 60,
    Maps = 62,
    NumericPassword = 63,
    NumericPin = 64,
    AlphanumericPin = 65,
    FormulaNumber = 67
  );
  PInput_InputScopeNameValue = ^Input_InputScopeNameValue;

  // Windows.UI.Xaml.Input.KeyboardNavigationMode
  Input_KeyboardNavigationMode = (
    Local = 0,
    Cycle = 1,
    Once = 2
  );
  PInput_KeyboardNavigationMode = ^Input_KeyboardNavigationMode;

  // Windows.UI.Xaml.Input.ManipulationModes
  Input_ManipulationModes = (
    None = 0,
    TranslateX = 1,
    TranslateY = 2,
    TranslateRailsX = 4,
    TranslateRailsY = 8,
    Rotate = 16,
    Scale = 32,
    TranslateInertia = 64,
    RotateInertia = 128,
    ScaleInertia = 256,
    All = 65535,
    System = 65536
  );
  PInput_ManipulationModes = ^Input_ManipulationModes;

  // Windows.UI.Xaml.Media.Imaging.BitmapCreateOptions
  Media_Imaging_BitmapCreateOptions = (
    None = 0,
    IgnoreImageCache = 8
  );
  PMedia_Imaging_BitmapCreateOptions = ^Media_Imaging_BitmapCreateOptions;

  // Windows.UI.Xaml.Media.Imaging.DecodePixelType
  Media_Imaging_DecodePixelType = (
    Physical = 0,
    Logical = 1
  );
  PMedia_Imaging_DecodePixelType = ^Media_Imaging_DecodePixelType;

  // Windows.UI.Xaml.Controls.Primitives.AnimationDirection
  Controls_Primitives_AnimationDirection = (
    Left = 0,
    Top = 1,
    Right = 2,
    Bottom = 3
  );
  PControls_Primitives_AnimationDirection = ^Controls_Primitives_AnimationDirection;

  // Windows.UI.Xaml.Controls.Primitives.ComponentResourceLocation
  Controls_Primitives_ComponentResourceLocation = (
    Application = 0,
    Nested = 1
  );
  PControls_Primitives_ComponentResourceLocation = ^Controls_Primitives_ComponentResourceLocation;

  // Windows.UI.Xaml.Controls.Primitives.EdgeTransitionLocation
  Controls_Primitives_EdgeTransitionLocation = (
    Left = 0,
    Top = 1,
    Right = 2,
    Bottom = 3
  );
  PControls_Primitives_EdgeTransitionLocation = ^Controls_Primitives_EdgeTransitionLocation;

  // Windows.UI.Xaml.Controls.Primitives.FlyoutPlacementMode
  Controls_Primitives_FlyoutPlacementMode = (
    Top = 0,
    Bottom = 1,
    Left = 2,
    Right = 3,
    Full = 4
  );
  PControls_Primitives_FlyoutPlacementMode = ^Controls_Primitives_FlyoutPlacementMode;

  // Windows.UI.Xaml.Automation.AnnotationType
  Automation_AnnotationType = (
    Unknown = 60000,
    SpellingError = 60001,
    GrammarError = 60002,
    Comment = 60003,
    FormulaError = 60004,
    TrackChanges = 60005,
    Header = 60006,
    Footer = 60007,
    Highlighted = 60008,
    Endnote = 60009,
    Footnote = 60010
  );
  PAutomation_AnnotationType = ^Automation_AnnotationType;

  // Windows.UI.Xaml.Automation.AutomationTextEditChangeType
  Automation_AutomationTextEditChangeType = (
    None = 0,
    AutoCorrect = 1,
    Composition = 2,
    CompositionFinalized = 3
  );
  PAutomation_AutomationTextEditChangeType = ^Automation_AutomationTextEditChangeType;

  // Windows.UI.Xaml.Automation.DockPosition
  Automation_DockPosition = (
    Top = 0,
    Left = 1,
    Bottom = 2,
    Right = 3,
    Fill = 4,
    None = 5
  );
  PAutomation_DockPosition = ^Automation_DockPosition;

  // Windows.UI.Xaml.Automation.ExpandCollapseState
  Automation_ExpandCollapseState = (
    Collapsed = 0,
    Expanded = 1,
    PartiallyExpanded = 2,
    LeafNode = 3
  );
  PAutomation_ExpandCollapseState = ^Automation_ExpandCollapseState;

  // Windows.UI.Xaml.Automation.RowOrColumnMajor
  Automation_RowOrColumnMajor = (
    RowMajor = 0,
    ColumnMajor = 1,
    Indeterminate = 2
  );
  PAutomation_RowOrColumnMajor = ^Automation_RowOrColumnMajor;

  // Windows.UI.Xaml.Automation.ScrollAmount
  Automation_ScrollAmount = (
    LargeDecrement = 0,
    SmallDecrement = 1,
    NoAmount = 2,
    LargeIncrement = 3,
    SmallIncrement = 4
  );
  PAutomation_ScrollAmount = ^Automation_ScrollAmount;

  // Windows.UI.Xaml.Automation.SupportedTextSelection
  Automation_SupportedTextSelection = (
    None = 0,
    Single = 1,
    Multiple = 2
  );
  PAutomation_SupportedTextSelection = ^Automation_SupportedTextSelection;

  // Windows.UI.Xaml.Automation.SynchronizedInputType
  Automation_SynchronizedInputType = (
    KeyUp = 1,
    KeyDown = 2,
    LeftMouseUp = 4,
    LeftMouseDown = 8,
    RightMouseUp = 16,
    RightMouseDown = 32
  );
  PAutomation_SynchronizedInputType = ^Automation_SynchronizedInputType;

  // Windows.UI.Xaml.Automation.ToggleState
  Automation_ToggleState = (
    Off = 0,
    On = 1,
    Indeterminate = 2
  );
  PAutomation_ToggleState = ^Automation_ToggleState;

  // Windows.UI.Xaml.Automation.WindowInteractionState
  Automation_WindowInteractionState = (
    Running = 0,
    Closing = 1,
    ReadyForUserInteraction = 2,
    BlockedByModalWindow = 3,
    NotResponding = 4
  );
  PAutomation_WindowInteractionState = ^Automation_WindowInteractionState;

  // Windows.UI.Xaml.Automation.WindowVisualState
  Automation_WindowVisualState = (
    Normal = 0,
    Maximized = 1,
    Minimized = 2
  );
  PAutomation_WindowVisualState = ^Automation_WindowVisualState;

  // Windows.UI.Xaml.Automation.ZoomUnit
  Automation_ZoomUnit = (
    NoAmount = 0,
    LargeDecrement = 1,
    SmallDecrement = 2,
    LargeIncrement = 3,
    SmallIncrement = 4
  );
  PAutomation_ZoomUnit = ^Automation_ZoomUnit;

  // Windows.UI.Xaml.Automation.Peers.AccessibilityView
  Automation_Peers_AccessibilityView = (
    Raw = 0,
    Control = 1,
    Content = 2
  );
  PAutomation_Peers_AccessibilityView = ^Automation_Peers_AccessibilityView;

  // Windows.UI.Xaml.Automation.Peers.AutomationControlType
  Automation_Peers_AutomationControlType = (
    Button = 0,
    Calendar = 1,
    CheckBox = 2,
    ComboBox = 3,
    Edit = 4,
    Hyperlink = 5,
    Image = 6,
    ListItem = 7,
    List = 8,
    Menu = 9,
    MenuBar = 10,
    MenuItem = 11,
    ProgressBar = 12,
    RadioButton = 13,
    ScrollBar = 14,
    Slider = 15,
    Spinner = 16,
    StatusBar = 17,
    Tab = 18,
    TabItem = 19,
    Text = 20,
    ToolBar = 21,
    ToolTip = 22,
    Tree = 23,
    TreeItem = 24,
    Custom = 25,
    Group = 26,
    Thumb = 27,
    DataGrid = 28,
    DataItem = 29,
    Document = 30,
    SplitButton = 31,
    Window = 32,
    Pane = 33,
    Header = 34,
    HeaderItem = 35,
    Table = 36,
    TitleBar = 37,
    Separator = 38,
    SemanticZoom = 39,
    AppBar = 40
  );
  PAutomation_Peers_AutomationControlType = ^Automation_Peers_AutomationControlType;

  // Windows.UI.Xaml.Automation.Peers.AutomationEvents
  Automation_Peers_AutomationEvents = (
    ToolTipOpened = 0,
    ToolTipClosed = 1,
    MenuOpened = 2,
    MenuClosed = 3,
    AutomationFocusChanged = 4,
    InvokePatternOnInvoked = 5,
    SelectionItemPatternOnElementAddedToSelection = 6,
    SelectionItemPatternOnElementRemovedFromSelection = 7,
    SelectionItemPatternOnElementSelected = 8,
    SelectionPatternOnInvalidated = 9,
    TextPatternOnTextSelectionChanged = 10,
    TextPatternOnTextChanged = 11,
    AsyncContentLoaded = 12,
    PropertyChanged = 13,
    StructureChanged = 14,
    DragStart = 15,
    DragCancel = 16,
    DragComplete = 17,
    DragEnter = 18,
    DragLeave = 19,
    Dropped = 20,
    LiveRegionChanged = 21,
    InputReachedTarget = 22,
    InputReachedOtherElement = 23,
    InputDiscarded = 24,
    WindowClosed = 25,
    WindowOpened = 26,
    ConversionTargetChanged = 27,
    TextEditTextChanged = 28
  );
  PAutomation_Peers_AutomationEvents = ^Automation_Peers_AutomationEvents;

  // Windows.UI.Xaml.Automation.Peers.AutomationLiveSetting
  Automation_Peers_AutomationLiveSetting = (
    Off = 0,
    Polite = 1,
    Assertive = 2
  );
  PAutomation_Peers_AutomationLiveSetting = ^Automation_Peers_AutomationLiveSetting;

  // Windows.UI.Xaml.Automation.Peers.AutomationNavigationDirection
  Automation_Peers_AutomationNavigationDirection = (
    Parent = 0,
    NextSibling = 1,
    PreviousSibling = 2,
    FirstChild = 3,
    LastChild = 4
  );
  PAutomation_Peers_AutomationNavigationDirection = ^Automation_Peers_AutomationNavigationDirection;

  // Windows.UI.Xaml.Automation.Peers.AutomationOrientation
  Automation_Peers_AutomationOrientation = (
    None = 0,
    Horizontal = 1,
    Vertical = 2
  );
  PAutomation_Peers_AutomationOrientation = ^Automation_Peers_AutomationOrientation;

  // Windows.UI.Xaml.Automation.Peers.AutomationStructureChangeType
  Automation_Peers_AutomationStructureChangeType = (
    ChildAdded = 0,
    ChildRemoved = 1,
    ChildrenInvalidated = 2,
    ChildrenBulkAdded = 3,
    ChildrenBulkRemoved = 4,
    ChildrenReordered = 5
  );
  PAutomation_Peers_AutomationStructureChangeType = ^Automation_Peers_AutomationStructureChangeType;

  // Windows.UI.Xaml.Automation.Peers.PatternInterface
  Automation_Peers_PatternInterface = (
    Invoke = 0,
    Selection = 1,
    Value = 2,
    RangeValue = 3,
    Scroll = 4,
    ScrollItem = 5,
    ExpandCollapse = 6,
    Grid = 7,
    GridItem = 8,
    MultipleView = 9,
    Window = 10,
    SelectionItem = 11,
    Dock = 12,
    Table = 13,
    TableItem = 14,
    Toggle = 15,
    Transform = 16,
    Text = 17,
    ItemContainer = 18,
    VirtualizedItem = 19,
    Text2 = 20,
    TextChild = 21,
    TextRange = 22,
    Annotation = 23,
    Drag = 24,
    DropTarget = 25,
    ObjectModel = 26,
    Spreadsheet = 27,
    SpreadsheetItem = 28,
    Styles = 29,
    Transform2 = 30,
    SynchronizedInput = 31,
    TextEdit = 32,
    CustomNavigation = 33
  );
  PAutomation_Peers_PatternInterface = ^Automation_Peers_PatternInterface;

  // Windows.UI.Xaml.Automation.Text.TextPatternRangeEndpoint
  Automation_Text_TextPatternRangeEndpoint = (
    Start = 0,
    &End = 1
  );
  PAutomation_Text_TextPatternRangeEndpoint = ^Automation_Text_TextPatternRangeEndpoint;

  // Windows.UI.Xaml.Automation.Text.TextUnit
  Automation_Text_TextUnit = (
    Character = 0,
    Format = 1,
    Word = 2,
    Line = 3,
    Paragraph = 4,
    Page = 5,
    Document = 6
  );
  PAutomation_Text_TextUnit = ^Automation_Text_TextUnit;

  // Windows.UI.Xaml.Data.BindingMode
  Data_BindingMode = (
    OneWay = 1,
    OneTime = 2,
    TwoWay = 3
  );
  PData_BindingMode = ^Data_BindingMode;

  // Windows.UI.Xaml.Data.RelativeSourceMode
  Data_RelativeSourceMode = (
    None = 0,
    TemplatedParent = 1,
    Self = 2
  );
  PData_RelativeSourceMode = ^Data_RelativeSourceMode;

  // Windows.UI.Xaml.Data.UpdateSourceTrigger
  Data_UpdateSourceTrigger = (
    Default = 0,
    PropertyChanged = 1,
    Explicit = 2
  );
  PData_UpdateSourceTrigger = ^Data_UpdateSourceTrigger;

  // Windows.UI.Xaml.Interop.TypeKind
  Interop_TypeKind = (
    Primitive = 0,
    Metadata = 1,
    Custom = 2
  );
  PInterop_TypeKind = ^Interop_TypeKind;

  // Windows.UI.Xaml.AutomationTextAttributesEnum
  AutomationTextAttributesEnum = (
    AnimationStyleAttribute = 40000,
    BackgroundColorAttribute = 40001,
    BulletStyleAttribute = 40002,
    CapStyleAttribute = 40003,
    CultureAttribute = 40004,
    FontNameAttribute = 40005,
    FontSizeAttribute = 40006,
    FontWeightAttribute = 40007,
    ForegroundColorAttribute = 40008,
    HorizontalTextAlignmentAttribute = 40009,
    IndentationFirstLineAttribute = 40010,
    IndentationLeadingAttribute = 40011,
    IndentationTrailingAttribute = 40012,
    IsHiddenAttribute = 40013,
    IsItalicAttribute = 40014,
    IsReadOnlyAttribute = 40015,
    IsSubscriptAttribute = 40016,
    IsSuperscriptAttribute = 40017,
    MarginBottomAttribute = 40018,
    MarginLeadingAttribute = 40019,
    MarginTopAttribute = 40020,
    MarginTrailingAttribute = 40021,
    OutlineStylesAttribute = 40022,
    OverlineColorAttribute = 40023,
    OverlineStyleAttribute = 40024,
    StrikethroughColorAttribute = 40025,
    StrikethroughStyleAttribute = 40026,
    TabsAttribute = 40027,
    TextFlowDirectionsAttribute = 40028,
    UnderlineColorAttribute = 40029,
    UnderlineStyleAttribute = 40030,
    AnnotationTypesAttribute = 40031,
    AnnotationObjectsAttribute = 40032,
    StyleNameAttribute = 40033,
    StyleIdAttribute = 40034,
    LinkAttribute = 40035,
    IsActiveAttribute = 40036,
    SelectionActiveEndAttribute = 40037,
    CaretPositionAttribute = 40038,
    CaretBidiModeAttribute = 40039
  );
  PAutomationTextAttributesEnum = ^AutomationTextAttributesEnum;

  // Windows.UI.Xaml.Automation.AutomationActiveEnd
  Automation_AutomationActiveEnd = (
    None = 0,
    Start = 1,
    &End = 2
  );
  PAutomation_AutomationActiveEnd = ^Automation_AutomationActiveEnd;

  // Windows.UI.Xaml.Automation.AutomationAnimationStyle
  Automation_AutomationAnimationStyle = (
    None = 0,
    LasVegasLights = 1,
    BlinkingBackground = 2,
    SparkleText = 3,
    MarchingBlackAnts = 4,
    MarchingRedAnts = 5,
    Shimmer = 6,
    Other = 7
  );
  PAutomation_AutomationAnimationStyle = ^Automation_AutomationAnimationStyle;

  // Windows.UI.Xaml.Automation.AutomationBulletStyle
  Automation_AutomationBulletStyle = (
    None = 0,
    HollowRoundBullet = 1,
    FilledRoundBullet = 2,
    HollowSquareBullet = 3,
    FilledSquareBullet = 4,
    DashBullet = 5,
    Other = 6
  );
  PAutomation_AutomationBulletStyle = ^Automation_AutomationBulletStyle;

  // Windows.UI.Xaml.Automation.AutomationCaretBidiMode
  Automation_AutomationCaretBidiMode = (
    LTR = 0,
    RTL = 1
  );
  PAutomation_AutomationCaretBidiMode = ^Automation_AutomationCaretBidiMode;

  // Windows.UI.Xaml.Automation.AutomationCaretPosition
  Automation_AutomationCaretPosition = (
    Unknown = 0,
    EndOfLine = 1,
    BeginningOfLine = 2
  );
  PAutomation_AutomationCaretPosition = ^Automation_AutomationCaretPosition;

  // Windows.UI.Xaml.Automation.AutomationFlowDirections
  Automation_AutomationFlowDirections = (
    Default = 0,
    RightToLeft = 1,
    BottomToTop = 2,
    Vertical = 3
  );
  PAutomation_AutomationFlowDirections = ^Automation_AutomationFlowDirections;

  // Windows.UI.Xaml.Automation.AutomationOutlineStyles
  Automation_AutomationOutlineStyles = (
    None = 0,
    Outline = 1,
    Shadow = 2,
    Engraved = 3,
    Embossed = 4
  );
  PAutomation_AutomationOutlineStyles = ^Automation_AutomationOutlineStyles;

  // Windows.UI.Xaml.Automation.AutomationStyleId
  Automation_AutomationStyleId = (
    Heading1 = 70001,
    Heading2 = 70002,
    Heading3 = 70003,
    Heading4 = 70004,
    Heading5 = 70005,
    Heading6 = 70006,
    Heading7 = 70007,
    Heading8 = 70008,
    Heading9 = 70009,
    Title = 70010,
    Subtitle = 70011,
    Normal = 70012,
    Emphasis = 70013,
    Quote = 70014,
    BulletedList = 70015
  );
  PAutomation_AutomationStyleId = ^Automation_AutomationStyleId;

  // Windows.UI.Xaml.Automation.AutomationTextDecorationLineStyle
  Automation_AutomationTextDecorationLineStyle = (
    None = 0,
    Single = 1,
    WordsOnly = 2,
    Double = 3,
    Dot = 4,
    Dash = 5,
    DashDot = 6,
    DashDotDot = 7,
    Wavy = 8,
    ThickSingle = 9,
    DoubleWavy = 10,
    ThickWavy = 11,
    LongDash = 12,
    ThickDash = 13,
    ThickDashDot = 14,
    ThickDashDotDot = 15,
    ThickDot = 16,
    ThickLongDash = 17,
    Other = 18
  );
  PAutomation_AutomationTextDecorationLineStyle = ^Automation_AutomationTextDecorationLineStyle;

  // Windows.UI.Xaml.Controls.Maps.MapAnimationKind
  Controls_Maps_MapAnimationKind = (
    Default = 0,
    None = 1,
    Linear = 2,
    Bow = 3
  );
  PControls_Maps_MapAnimationKind = ^Controls_Maps_MapAnimationKind;

  // Windows.UI.Xaml.Controls.Maps.MapColorScheme
  Controls_Maps_MapColorScheme = (
    Light = 0,
    Dark = 1
  );
  PControls_Maps_MapColorScheme = ^Controls_Maps_MapColorScheme;

  // Windows.UI.Xaml.Controls.Maps.MapElementCollisionBehavior
  Controls_Maps_MapElementCollisionBehavior = (
    Hide = 0,
    RemainVisible = 1
  );
  PControls_Maps_MapElementCollisionBehavior = ^Controls_Maps_MapElementCollisionBehavior;

  // Windows.UI.Xaml.Controls.Maps.MapInteractionMode
  Controls_Maps_MapInteractionMode = (
    Auto = 0,
    Disabled = 1,
    GestureOnly = 2,
    ControlOnly = 3,
    GestureAndControl = 4
  );
  PControls_Maps_MapInteractionMode = ^Controls_Maps_MapInteractionMode;

  // Windows.UI.Xaml.Controls.Maps.MapLoadingStatus
  Controls_Maps_MapLoadingStatus = (
    Loading = 0,
    Loaded = 1
  );
  PControls_Maps_MapLoadingStatus = ^Controls_Maps_MapLoadingStatus;

  // Windows.UI.Xaml.Controls.Maps.MapPanInteractionMode
  Controls_Maps_MapPanInteractionMode = (
    Auto = 0,
    Disabled = 1
  );
  PControls_Maps_MapPanInteractionMode = ^Controls_Maps_MapPanInteractionMode;

  // Windows.UI.Xaml.Controls.Maps.MapStyle
  Controls_Maps_MapStyle = (
    None = 0,
    Road = 1,
    Aerial = 2,
    AerialWithRoads = 3,
    Terrain = 4,
    Aerial3D = 5,
    Aerial3DWithRoads = 6
  );
  PControls_Maps_MapStyle = ^Controls_Maps_MapStyle;

  // Windows.UI.Xaml.Controls.Maps.MapTileLayer
  Controls_Maps_MapTileLayer = (
    LabelOverlay = 0,
    RoadOverlay = 1,
    AreaOverlay = 2,
    BackgroundOverlay = 3,
    BackgroundReplacement = 4
  );
  PControls_Maps_MapTileLayer = ^Controls_Maps_MapTileLayer;

  // Windows.UI.Xaml.Controls.Maps.MapWatermarkMode
  Controls_Maps_MapWatermarkMode = (
    Automatic = 0,
    On = 1
  );
  PControls_Maps_MapWatermarkMode = ^Controls_Maps_MapWatermarkMode;

  // Windows.UI.Xaml.Controls.ListPickerFlyoutSelectionMode
  Controls_ListPickerFlyoutSelectionMode = (
    Single = 0,
    Multiple = 1
  );
  PControls_ListPickerFlyoutSelectionMode = ^Controls_ListPickerFlyoutSelectionMode;

  // Windows.UI.Xaml.Controls.PivotSlideInAnimationGroup
  Controls_PivotSlideInAnimationGroup = (
    Default = 0,
    GroupOne = 1,
    GroupTwo = 2,
    GroupThree = 3
  );
  PControls_PivotSlideInAnimationGroup = ^Controls_PivotSlideInAnimationGroup;


  // Windows.UI.Xaml Records
  // Windows.UI.Xaml.CornerRadius
  CornerRadius = record
    TopLeft: Double;
    TopRight: Double;
    BottomRight: Double;
    BottomLeft: Double;
  end;
  PCornerRadius = ^CornerRadius;

  // Windows.UI.Xaml.Duration
  Duration = record
    TimeSpan: TimeSpan;
    &Type: DurationType;
  end;
  PDuration = ^Duration;

  // Windows.UI.Xaml.GridLength
  GridLength = record
    Value: Double;
    GridUnitType: GridUnitType;
  end;
  PGridLength = ^GridLength;

  // Windows.UI.Xaml.Thickness
  Thickness = record
    Left: Double;
    Top: Double;
    Right: Double;
    Bottom: Double;
  end;
  PThickness = ^Thickness;

  // Windows.UI.Xaml.Media.Matrix
  Media_Matrix = record
    M11: Double;
    M12: Double;
    M21: Double;
    M22: Double;
    OffsetX: Double;
    OffsetY: Double;
  end;
  PMedia_Matrix = ^Media_Matrix;

  // Windows.UI.Xaml.Media.Animation.KeyTime
  Media_Animation_KeyTime = record
    TimeSpan: TimeSpan;
  end;
  PMedia_Animation_KeyTime = ^Media_Animation_KeyTime;

  // Windows.UI.Xaml.Media.Animation.RepeatBehavior
  Media_Animation_RepeatBehavior = record
    Count: Double;
    Duration: TimeSpan;
    &Type: Media_Animation_RepeatBehaviorType;
  end;
  PMedia_Animation_RepeatBehavior = ^Media_Animation_RepeatBehavior;

  // Windows.UI.Xaml.Controls.Primitives.GeneratorPosition
  Controls_Primitives_GeneratorPosition = record
    Index: Integer;
    Offset: Integer;
  end;
  PControls_Primitives_GeneratorPosition = ^Controls_Primitives_GeneratorPosition;

  // Windows.UI.Xaml.Automation.Peers.RawElementProviderRuntimeId
  Automation_Peers_RawElementProviderRuntimeId = record
    Part1: Cardinal;
    Part2: Cardinal;
  end;
  PAutomation_Peers_RawElementProviderRuntimeId = ^Automation_Peers_RawElementProviderRuntimeId;

  // Windows.UI.Xaml.Data.LoadMoreItemsResult
  Data_LoadMoreItemsResult = record
    Count: Cardinal;
  end;
  PData_LoadMoreItemsResult = ^Data_LoadMoreItemsResult;

  // Windows.UI.Xaml.Media.Media3D.Matrix3D
  Media_Media3D_Matrix3D = record
    M11: Double;
    M12: Double;
    M13: Double;
    M14: Double;
    M21: Double;
    M22: Double;
    M23: Double;
    M24: Double;
    M31: Double;
    M32: Double;
    M33: Double;
    M34: Double;
    OffsetX: Double;
    OffsetY: Double;
    OffsetZ: Double;
    M44: Double;
  end;
  PMedia_Media3D_Matrix3D = ^Media_Media3D_Matrix3D;

  // Windows.UI.Xaml.Markup.XamlBinaryWriterErrorInformation
  Markup_XamlBinaryWriterErrorInformation = record
    InputStreamIndex: Cardinal;
    LineNumber: Cardinal;
    LinePosition: Cardinal;
  end;
  PMarkup_XamlBinaryWriterErrorInformation = ^Markup_XamlBinaryWriterErrorInformation;

  // Windows.UI.Xaml.Markup.XmlnsDefinition
  Markup_XmlnsDefinition = record
    XmlNamespace: HSTRING;
    Namespace: HSTRING;
  end;
  PMarkup_XmlnsDefinition = ^Markup_XmlnsDefinition;

  // Windows.UI.Xaml.Interop.TypeName
  Interop_TypeName = record
    Name: HSTRING;
    Kind: Interop_TypeKind;
  end;
  PInterop_TypeName = ^Interop_TypeName;

  // Windows.UI.Xaml.Controls.Maps.MapZoomLevelRange
  Controls_Maps_MapZoomLevelRange = record
    Min: Double;
    Max: Double;
  end;
  PControls_Maps_MapZoomLevelRange = ^Controls_Maps_MapZoomLevelRange;

  // Windows.UI.Xaml.Hosting.HostingContract
  Hosting_HostingContract = record
  end;
  PHosting_HostingContract = ^Hosting_HostingContract;



  // Windows.Web Enums
  // Windows.Web.Http.HttpVersion
  Http_HttpVersion = (
    None = 0,
    Http10 = 1,
    Http11 = 2,
    Http20 = 3
  );
  PHttp_HttpVersion = ^Http_HttpVersion;

  // Windows.Web.Http.HttpCompletionOption
  Http_HttpCompletionOption = (
    ResponseContentRead = 0,
    ResponseHeadersRead = 1
  );
  PHttp_HttpCompletionOption = ^Http_HttpCompletionOption;

  // Windows.Web.Http.HttpStatusCode
  Http_HttpStatusCode = (
    None = 0,
    Continue = 100,
    SwitchingProtocols = 101,
    Processing = 102,
    Ok = 200,
    Created = 201,
    Accepted = 202,
    NonAuthoritativeInformation = 203,
    NoContent = 204,
    ResetContent = 205,
    PartialContent = 206,
    MultiStatus = 207,
    AlreadyReported = 208,
    IMUsed = 226,
    MultipleChoices = 300,
    MovedPermanently = 301,
    Found = 302,
    SeeOther = 303,
    NotModified = 304,
    UseProxy = 305,
    TemporaryRedirect = 307,
    PermanentRedirect = 308,
    BadRequest = 400,
    Unauthorized = 401,
    PaymentRequired = 402,
    Forbidden = 403,
    NotFound = 404,
    MethodNotAllowed = 405,
    NotAcceptable = 406,
    ProxyAuthenticationRequired = 407,
    RequestTimeout = 408,
    Conflict = 409,
    Gone = 410,
    LengthRequired = 411,
    PreconditionFailed = 412,
    RequestEntityTooLarge = 413,
    RequestUriTooLong = 414,
    UnsupportedMediaType = 415,
    RequestedRangeNotSatisfiable = 416,
    ExpectationFailed = 417,
    UnprocessableEntity = 422,
    Locked = 423,
    FailedDependency = 424,
    UpgradeRequired = 426,
    PreconditionRequired = 428,
    TooManyRequests = 429,
    RequestHeaderFieldsTooLarge = 431,
    InternalServerError = 500,
    NotImplemented = 501,
    BadGateway = 502,
    ServiceUnavailable = 503,
    GatewayTimeout = 504,
    HttpVersionNotSupported = 505,
    VariantAlsoNegotiates = 506,
    InsufficientStorage = 507,
    LoopDetected = 508,
    NotExtended = 510,
    NetworkAuthenticationRequired = 511
  );
  PHttp_HttpStatusCode = ^Http_HttpStatusCode;

  // Windows.Web.Http.HttpProgressStage
  Http_HttpProgressStage = (
    None = 0,
    DetectingProxy = 10,
    ResolvingName = 20,
    ConnectingToServer = 30,
    NegotiatingSsl = 40,
    SendingHeaders = 50,
    SendingContent = 60,
    WaitingForResponse = 70,
    ReceivingHeaders = 80,
    ReceivingContent = 90
  );
  PHttp_HttpProgressStage = ^Http_HttpProgressStage;

  // Windows.Web.Http.HttpResponseMessageSource
  Http_HttpResponseMessageSource = (
    None = 0,
    Cache = 1,
    Network = 2
  );
  PHttp_HttpResponseMessageSource = ^Http_HttpResponseMessageSource;

  // Windows.Web.Http.Filters.HttpCacheReadBehavior
  Http_Filters_HttpCacheReadBehavior = (
    Default = 0,
    MostRecent = 1,
    OnlyFromCache = 2
  );
  PHttp_Filters_HttpCacheReadBehavior = ^Http_Filters_HttpCacheReadBehavior;

  // Windows.Web.Http.Filters.HttpCacheWriteBehavior
  Http_Filters_HttpCacheWriteBehavior = (
    Default = 0,
    NoCache = 1
  );
  PHttp_Filters_HttpCacheWriteBehavior = ^Http_Filters_HttpCacheWriteBehavior;

  // Windows.Web.WebErrorStatus
  WebErrorStatus = (
    Unknown = 0,
    CertificateCommonNameIsIncorrect = 1,
    CertificateExpired = 2,
    CertificateContainsErrors = 3,
    CertificateRevoked = 4,
    CertificateIsInvalid = 5,
    ServerUnreachable = 6,
    Timeout = 7,
    ErrorHttpInvalidServerResponse = 8,
    ConnectionAborted = 9,
    ConnectionReset = 10,
    Disconnected = 11,
    HttpToHttpsOnRedirection = 12,
    HttpsToHttpOnRedirection = 13,
    CannotConnect = 14,
    HostNameNotResolved = 15,
    OperationCanceled = 16,
    RedirectFailed = 17,
    UnexpectedStatusCode = 18,
    UnexpectedRedirection = 19,
    UnexpectedClientError = 20,
    UnexpectedServerError = 21,
    MultipleChoices = 300,
    MovedPermanently = 301,
    Found = 302,
    SeeOther = 303,
    NotModified = 304,
    UseProxy = 305,
    TemporaryRedirect = 307,
    BadRequest = 400,
    Unauthorized = 401,
    PaymentRequired = 402,
    Forbidden = 403,
    NotFound = 404,
    MethodNotAllowed = 405,
    NotAcceptable = 406,
    ProxyAuthenticationRequired = 407,
    RequestTimeout = 408,
    Conflict = 409,
    Gone = 410,
    LengthRequired = 411,
    PreconditionFailed = 412,
    RequestEntityTooLarge = 413,
    RequestUriTooLong = 414,
    UnsupportedMediaType = 415,
    RequestedRangeNotSatisfiable = 416,
    ExpectationFailed = 417,
    InternalServerError = 500,
    NotImplemented = 501,
    BadGateway = 502,
    ServiceUnavailable = 503,
    GatewayTimeout = 504,
    HttpVersionNotSupported = 505
  );
  PWebErrorStatus = ^WebErrorStatus;

  // Windows.Web.Syndication.SyndicationFormat
  Syndication_SyndicationFormat = (
    Atom10 = 0,
    Rss20 = 1,
    Rss10 = 2,
    Rss092 = 3,
    Rss091 = 4,
    Atom03 = 5
  );
  PSyndication_SyndicationFormat = ^Syndication_SyndicationFormat;

  // Windows.Web.Syndication.SyndicationErrorStatus
  Syndication_SyndicationErrorStatus = (
    Unknown = 0,
    MissingRequiredElement = 1,
    MissingRequiredAttribute = 2,
    InvalidXml = 3,
    UnexpectedContent = 4,
    UnsupportedFormat = 5
  );
  PSyndication_SyndicationErrorStatus = ^Syndication_SyndicationErrorStatus;

  // Windows.Web.Syndication.SyndicationTextType
  Syndication_SyndicationTextType = (
    Text = 0,
    Html = 1,
    Xhtml = 2
  );
  PSyndication_SyndicationTextType = ^Syndication_SyndicationTextType;

  // Windows.Web.Http.Diagnostics.HttpDiagnosticRequestInitiator
  Http_Diagnostics_HttpDiagnosticRequestInitiator = (
    ParsedElement = 0,
    Script = 1,
    Image = 2,
    Link = 3,
    Style = 4,
    XmlHttpRequest = 5,
    Media = 6,
    HtmlDownload = 7,
    Prefetch = 8,
    Other = 9
  );
  PHttp_Diagnostics_HttpDiagnosticRequestInitiator = ^Http_Diagnostics_HttpDiagnosticRequestInitiator;


  // Windows.Web Records
  // Windows.Web.Http.HttpProgress
  Http_HttpProgress = record
    Stage: Http_HttpProgressStage;
    BytesSent: UInt64;
    TotalBytesToSend: IReference_1__UInt64;
    BytesReceived: UInt64;
    TotalBytesToReceive: IReference_1__UInt64;
    Retries: Cardinal;
  end;
  PHttp_HttpProgress = ^Http_HttpProgress;

  // Windows.Web.Syndication.RetrievalProgress
  Syndication_RetrievalProgress = record
    BytesRetrieved: Cardinal;
    TotalBytesToRetrieve: Cardinal;
  end;
  PSyndication_RetrievalProgress = ^Syndication_RetrievalProgress;

  // Windows.Web.Syndication.TransferProgress
  Syndication_TransferProgress = record
    BytesSent: Cardinal;
    TotalBytesToSend: Cardinal;
    BytesRetrieved: Cardinal;
    TotalBytesToRetrieve: Cardinal;
  end;
  PSyndication_TransferProgress = ^Syndication_TransferProgress;

  // Windows.Web.Http.Diagnostics.HttpDiagnosticsContract
  Http_Diagnostics_HttpDiagnosticsContract = record
  end;
  PHttp_Diagnostics_HttpDiagnosticsContract = ^Http_Diagnostics_HttpDiagnosticsContract;




implementation

end.
