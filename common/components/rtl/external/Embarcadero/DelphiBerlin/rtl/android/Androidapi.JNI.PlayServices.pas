{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.PlayServices;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Java.Net,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Location,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.Support,
  Androidapi.JNI.Util,
  Androidapi.JNI.Widget;

type
// ===== Forward declarations =====

  Janalytics_CampaignTrackingReceiver = interface;//com.google.android.gms.analytics.CampaignTrackingReceiver
  Janalytics_CampaignTrackingService = interface;//com.google.android.gms.analytics.CampaignTrackingService
  Janalytics_ExceptionParser = interface;//com.google.android.gms.analytics.ExceptionParser
  Janalytics_ExceptionReporter = interface;//com.google.android.gms.analytics.ExceptionReporter
  JTrackerHandler = interface;//com.google.android.gms.analytics.TrackerHandler
  Janalytics_GoogleAnalytics = interface;//com.google.android.gms.analytics.GoogleAnalytics
  JHitBuilders = interface;//com.google.android.gms.analytics.HitBuilders
  JHitBuilders_HitBuilder = interface;//com.google.android.gms.analytics.HitBuilders$HitBuilder
  JHitBuilders_AppViewBuilder = interface;//com.google.android.gms.analytics.HitBuilders$AppViewBuilder
  JHitBuilders_EventBuilder = interface;//com.google.android.gms.analytics.HitBuilders$EventBuilder
  JHitBuilders_ExceptionBuilder = interface;//com.google.android.gms.analytics.HitBuilders$ExceptionBuilder
  JHitBuilders_ItemBuilder = interface;//com.google.android.gms.analytics.HitBuilders$ItemBuilder
  JHitBuilders_SocialBuilder = interface;//com.google.android.gms.analytics.HitBuilders$SocialBuilder
  JHitBuilders_TimingBuilder = interface;//com.google.android.gms.analytics.HitBuilders$TimingBuilder
  JHitBuilders_TransactionBuilder = interface;//com.google.android.gms.analytics.HitBuilders$TransactionBuilder
  Janalytics_Logger = interface;//com.google.android.gms.analytics.Logger
  JLogger_LogLevel = interface;//com.google.android.gms.analytics.Logger$LogLevel
  Janalytics_StandardExceptionParser = interface;//com.google.android.gms.analytics.StandardExceptionParser
  Janalytics_Tracker = interface;//com.google.android.gms.analytics.Tracker
  JFreezable = interface;//com.google.android.gms.common.data.Freezable
  JAppState = interface;//com.google.android.gms.appstate.AppState
  JDataBuffer = interface;//com.google.android.gms.common.data.DataBuffer
  JAppStateBuffer = interface;//com.google.android.gms.appstate.AppStateBuffer
  JAppStateManager = interface;//com.google.android.gms.appstate.AppStateManager
  JReleasable = interface;//com.google.android.gms.common.api.Releasable
  JAppStateManager_StateConflictResult = interface;//com.google.android.gms.appstate.AppStateManager$StateConflictResult
  Japi_Result = interface;//com.google.android.gms.common.api.Result
  JAppStateManager_StateDeletedResult = interface;//com.google.android.gms.appstate.AppStateManager$StateDeletedResult
  JAppStateManager_StateListResult = interface;//com.google.android.gms.appstate.AppStateManager$StateListResult
  JAppStateManager_StateLoadedResult = interface;//com.google.android.gms.appstate.AppStateManager$StateLoadedResult
  JAppStateManager_StateResult = interface;//com.google.android.gms.appstate.AppStateManager$StateResult
  JAppStateStatusCodes = interface;//com.google.android.gms.appstate.AppStateStatusCodes
  JGoogleAuthException = interface;//com.google.android.gms.auth.GoogleAuthException
  JGoogleAuthUtil = interface;//com.google.android.gms.auth.GoogleAuthUtil
  JUserRecoverableAuthException = interface;//com.google.android.gms.auth.UserRecoverableAuthException
  JGooglePlayServicesAvailabilityException = interface;//com.google.android.gms.auth.GooglePlayServicesAvailabilityException
  JUserRecoverableNotifiedException = interface;//com.google.android.gms.auth.UserRecoverableNotifiedException
  JApplicationMetadata = interface;//com.google.android.gms.cast.ApplicationMetadata
  JCast = interface;//com.google.android.gms.cast.Cast
  JCast_ApplicationConnectionResult = interface;//com.google.android.gms.cast.Cast$ApplicationConnectionResult
  JCast_CastApi = interface;//com.google.android.gms.cast.Cast$CastApi
  JCast_CastOptions = interface;//com.google.android.gms.cast.Cast$CastOptions
  JCastOptions_Builder = interface;//com.google.android.gms.cast.Cast$CastOptions$Builder
  JCast_Listener = interface;//com.google.android.gms.cast.Cast$Listener
  JCast_MessageReceivedCallback = interface;//com.google.android.gms.cast.Cast$MessageReceivedCallback
  JCastDevice = interface;//com.google.android.gms.cast.CastDevice
  JCastMediaControlIntent = interface;//com.google.android.gms.cast.CastMediaControlIntent
  JCastStatusCodes = interface;//com.google.android.gms.cast.CastStatusCodes
  JMediaInfo = interface;//com.google.android.gms.cast.MediaInfo
  JMediaInfo_Builder = interface;//com.google.android.gms.cast.MediaInfo$Builder
  JMediaMetadata = interface;//com.google.android.gms.cast.MediaMetadata
  JMediaMetadata_a = interface;//com.google.android.gms.cast.MediaMetadata$a
  JMediaStatus = interface;//com.google.android.gms.cast.MediaStatus
  JRemoteMediaPlayer = interface;//com.google.android.gms.cast.RemoteMediaPlayer
  JRemoteMediaPlayer_MediaChannelResult = interface;//com.google.android.gms.cast.RemoteMediaPlayer$MediaChannelResult
  JRemoteMediaPlayer_OnMetadataUpdatedListener = interface;//com.google.android.gms.cast.RemoteMediaPlayer$OnMetadataUpdatedListener
  JRemoteMediaPlayer_OnStatusUpdatedListener = interface;//com.google.android.gms.cast.RemoteMediaPlayer$OnStatusUpdatedListener
  JAccountPicker = interface;//com.google.android.gms.common.AccountPicker
  JConnectionResult = interface;//com.google.android.gms.common.ConnectionResult
  JErrorDialogFragment = interface;//com.google.android.gms.common.ErrorDialogFragment
  JGooglePlayServicesClient = interface;//com.google.android.gms.common.GooglePlayServicesClient
  JGooglePlayServicesClient_ConnectionCallbacks = interface;//com.google.android.gms.common.GooglePlayServicesClient$ConnectionCallbacks
  JGooglePlayServicesClient_OnConnectionFailedListener = interface;//com.google.android.gms.common.GooglePlayServicesClient$OnConnectionFailedListener
  JGooglePlayServicesNotAvailableException = interface;//com.google.android.gms.common.GooglePlayServicesNotAvailableException
  JUserRecoverableException = interface;//com.google.android.gms.common.UserRecoverableException
  JGooglePlayServicesRepairableException = interface;//com.google.android.gms.common.GooglePlayServicesRepairableException
  JGooglePlayServicesUtil = interface;//com.google.android.gms.common.GooglePlayServicesUtil
  JScopes = interface;//com.google.android.gms.common.Scopes
  JSignInButton = interface;//com.google.android.gms.common.SignInButton
  JKeepName = interface;//com.google.android.gms.common.annotation.KeepName
  JCommonStatusCodes = interface;//com.google.android.gms.common.api.CommonStatusCodes
  JGoogleApiClient = interface;//com.google.android.gms.common.api.GoogleApiClient
  JGoogleApiClient_ApiOptions = interface;//com.google.android.gms.common.api.GoogleApiClient$ApiOptions
  JGoogleApiClient_Builder = interface;//com.google.android.gms.common.api.GoogleApiClient$Builder
  JGoogleApiClient_ConnectionCallbacks = interface;//com.google.android.gms.common.api.GoogleApiClient$ConnectionCallbacks
  JGoogleApiClient_OnConnectionFailedListener = interface;//com.google.android.gms.common.api.GoogleApiClient$OnConnectionFailedListener
  JPendingResult = interface;//com.google.android.gms.common.api.PendingResult
  JResultCallback = interface;//com.google.android.gms.common.api.ResultCallback
  JScope = interface;//com.google.android.gms.common.api.Scope
  JStatus = interface;//com.google.android.gms.common.api.Status
  JStatusCreator = interface;//com.google.android.gms.common.api.StatusCreator
  JDataBufferUtils = interface;//com.google.android.gms.common.data.DataBufferUtils
  JDataHolder = interface;//com.google.android.gms.common.data.DataHolder
  JDataHolder_Builder = interface;//com.google.android.gms.common.data.DataHolder$Builder
  JDataHolderCreator = interface;//com.google.android.gms.common.data.DataHolderCreator
  JFilteredDataBuffer = interface;//com.google.android.gms.common.data.FilteredDataBuffer
  JFreezableUtils = interface;//com.google.android.gms.common.data.FreezableUtils
  JImageManager = interface;//com.google.android.gms.common.images.ImageManager
  JImageManager_ImageReceiver = interface;//com.google.android.gms.common.images.ImageManager$ImageReceiver
  JImageManager_OnImageLoadedListener = interface;//com.google.android.gms.common.images.ImageManager$OnImageLoadedListener
  JWebImage = interface;//com.google.android.gms.common.images.WebImage
  JSafeParcelable = interface;//com.google.android.gms.common.internal.safeparcel.SafeParcelable
  JContents = interface;//com.google.android.gms.drive.Contents
  JCreateFileActivityBuilder = interface;//com.google.android.gms.drive.CreateFileActivityBuilder
  JDrive = interface;//com.google.android.gms.drive.Drive
  JDriveApi = interface;//com.google.android.gms.drive.DriveApi
  JDriveApi_ContentsResult = interface;//com.google.android.gms.drive.DriveApi$ContentsResult
  JDriveApi_DriveIdResult = interface;//com.google.android.gms.drive.DriveApi$DriveIdResult
  JDriveApi_IntentSenderResult = interface;//com.google.android.gms.drive.DriveApi$IntentSenderResult
  JDriveApi_MetadataBufferResult = interface;//com.google.android.gms.drive.DriveApi$MetadataBufferResult
  JDriveApi_OnSyncFinishCallback = interface;//com.google.android.gms.drive.DriveApi$OnSyncFinishCallback
  JDriveResource = interface;//com.google.android.gms.drive.DriveResource
  JDriveFile = interface;//com.google.android.gms.drive.DriveFile
  JDriveFile_DownloadProgressListener = interface;//com.google.android.gms.drive.DriveFile$DownloadProgressListener
  JDriveFolder = interface;//com.google.android.gms.drive.DriveFolder
  JDriveFolder_DriveFileResult = interface;//com.google.android.gms.drive.DriveFolder$DriveFileResult
  JDriveFolder_DriveFolderResult = interface;//com.google.android.gms.drive.DriveFolder$DriveFolderResult
  JDriveId = interface;//com.google.android.gms.drive.DriveId
  JDriveResource_MetadataResult = interface;//com.google.android.gms.drive.DriveResource$MetadataResult
  JDriveStatusCodes = interface;//com.google.android.gms.drive.DriveStatusCodes
  JMetadata = interface;//com.google.android.gms.drive.Metadata
  JMetadataBuffer = interface;//com.google.android.gms.drive.MetadataBuffer
  JMetadataChangeSet = interface;//com.google.android.gms.drive.MetadataChangeSet
  JMetadataChangeSet_Builder = interface;//com.google.android.gms.drive.MetadataChangeSet$Builder
  JOpenFileActivityBuilder = interface;//com.google.android.gms.drive.OpenFileActivityBuilder
  JChangeEvent = interface;//com.google.android.gms.drive.events.ChangeEvent
  JConflictEvent = interface;//com.google.android.gms.drive.events.ConflictEvent
  JDriveEvent = interface;//com.google.android.gms.drive.events.DriveEvent
  JDriveEvent_Listener = interface;//com.google.android.gms.drive.events.DriveEvent$Listener
  JResourceEvent = interface;//com.google.android.gms.drive.events.ResourceEvent
  JAuthorizeAccessRequest = interface;//com.google.android.gms.drive.internal.AuthorizeAccessRequest
  JCloseContentsAndUpdateMetadataRequest = interface;//com.google.android.gms.drive.internal.CloseContentsAndUpdateMetadataRequest
  JCloseContentsRequest = interface;//com.google.android.gms.drive.internal.CloseContentsRequest
  JCreateContentsRequest = interface;//com.google.android.gms.drive.internal.CreateContentsRequest
  JCreateFileIntentSenderRequest = interface;//com.google.android.gms.drive.internal.CreateFileIntentSenderRequest
  JCreateFileRequest = interface;//com.google.android.gms.drive.internal.CreateFileRequest
  JCreateFolderRequest = interface;//com.google.android.gms.drive.internal.CreateFolderRequest
  JDisconnectRequest = interface;//com.google.android.gms.drive.internal.DisconnectRequest
  JGetMetadataRequest = interface;//com.google.android.gms.drive.internal.GetMetadataRequest
  JListParentsRequest = interface;//com.google.android.gms.drive.internal.ListParentsRequest
  JOnContentsResponse = interface;//com.google.android.gms.drive.internal.OnContentsResponse
  JOnDownloadProgressResponse = interface;//com.google.android.gms.drive.internal.OnDownloadProgressResponse
  JOnDriveIdResponse = interface;//com.google.android.gms.drive.internal.OnDriveIdResponse
  JOnEventResponse = interface;//com.google.android.gms.drive.internal.OnEventResponse
  JOnListEntriesResponse = interface;//com.google.android.gms.drive.internal.OnListEntriesResponse
  JOnListParentsResponse = interface;//com.google.android.gms.drive.internal.OnListParentsResponse
  JOnMetadataResponse = interface;//com.google.android.gms.drive.internal.OnMetadataResponse
  JOpenContentsRequest = interface;//com.google.android.gms.drive.internal.OpenContentsRequest
  JOpenFileIntentSenderRequest = interface;//com.google.android.gms.drive.internal.OpenFileIntentSenderRequest
  JQueryRequest = interface;//com.google.android.gms.drive.internal.QueryRequest
  JRemoveEventListenerRequest = interface;//com.google.android.gms.drive.internal.RemoveEventListenerRequest
  JTrashResourceRequest = interface;//com.google.android.gms.drive.internal.TrashResourceRequest
  JUpdateMetadataRequest = interface;//com.google.android.gms.drive.internal.UpdateMetadataRequest
  JMetadataField = interface;//com.google.android.gms.drive.metadata.MetadataField
  JCollectionMetadataField = interface;//com.google.android.gms.drive.metadata.CollectionMetadataField
  JOrderedMetadataField = interface;//com.google.android.gms.drive.metadata.OrderedMetadataField
  JMetadataBundle = interface;//com.google.android.gms.drive.metadata.internal.MetadataBundle
  Jquery_Filter = interface;//com.google.android.gms.drive.query.Filter
  JFilters = interface;//com.google.android.gms.drive.query.Filters
  JQuery = interface;//com.google.android.gms.drive.query.Query
  JQuery_Builder = interface;//com.google.android.gms.drive.query.Query$Builder
  JSearchableField = interface;//com.google.android.gms.drive.query.SearchableField
  JComparisonFilter = interface;//com.google.android.gms.drive.query.internal.ComparisonFilter
  JFieldOnlyFilter = interface;//com.google.android.gms.drive.query.internal.FieldOnlyFilter
  JFilterHolder = interface;//com.google.android.gms.drive.query.internal.FilterHolder
  JInFilter = interface;//com.google.android.gms.drive.query.internal.InFilter
  JLogicalFilter = interface;//com.google.android.gms.drive.query.internal.LogicalFilter
  JNotFilter = interface;//com.google.android.gms.drive.query.internal.NotFilter
  JOperator = interface;//com.google.android.gms.drive.query.internal.Operator
  JDataBufferAdapter = interface;//com.google.android.gms.drive.widget.DataBufferAdapter
  JLifecycleDelegate = interface;//com.google.android.gms.dynamic.LifecycleDelegate
  JGame = interface;//com.google.android.gms.games.Game
  JGameBuffer = interface;//com.google.android.gms.games.GameBuffer
  //JGameEntity = interface;//com.google.android.gms.games.GameEntity
  //JGameEntity_a = interface;//com.google.android.gms.games.GameEntity$a
  JGames = interface;//com.google.android.gms.games.Games
  JGames_GamesOptions = interface;//com.google.android.gms.games.Games$GamesOptions
  JGamesOptions_Builder = interface;//com.google.android.gms.games.Games$GamesOptions$Builder
  JGamesActivityResultCodes = interface;//com.google.android.gms.games.GamesActivityResultCodes
  JGamesMetadata = interface;//com.google.android.gms.games.GamesMetadata
  JGamesMetadata_LoadGamesResult = interface;//com.google.android.gms.games.GamesMetadata$LoadGamesResult
  JGamesStatusCodes = interface;//com.google.android.gms.games.GamesStatusCodes
  JNotifications = interface;//com.google.android.gms.games.Notifications
  JPageDirection = interface;//com.google.android.gms.games.PageDirection
  JPlayer = interface;//com.google.android.gms.games.Player
  JPlayerBuffer = interface;//com.google.android.gms.games.PlayerBuffer
  //JPlayerEntity = interface;//com.google.android.gms.games.PlayerEntity
  JPlayers = interface;//com.google.android.gms.games.Players
  JPlayers_LoadPlayersResult = interface;//com.google.android.gms.games.Players$LoadPlayersResult
  JAchievement = interface;//com.google.android.gms.games.achievement.Achievement
  JAchievementBuffer = interface;//com.google.android.gms.games.achievement.AchievementBuffer
  JAchievements = interface;//com.google.android.gms.games.achievement.Achievements
  JAchievements_LoadAchievementsResult = interface;//com.google.android.gms.games.achievement.Achievements$LoadAchievementsResult
  JAchievements_UpdateAchievementResult = interface;//com.google.android.gms.games.achievement.Achievements$UpdateAchievementResult
  JLeaderboard = interface;//com.google.android.gms.games.leaderboard.Leaderboard
  //JLeaderboardBuffer = interface;//com.google.android.gms.games.leaderboard.LeaderboardBuffer
  JLeaderboardScore = interface;//com.google.android.gms.games.leaderboard.LeaderboardScore
  JLeaderboardScoreBuffer = interface;//com.google.android.gms.games.leaderboard.LeaderboardScoreBuffer
  JLeaderboardVariant = interface;//com.google.android.gms.games.leaderboard.LeaderboardVariant
  JLeaderboards = interface;//com.google.android.gms.games.leaderboard.Leaderboards
  JLeaderboards_LeaderboardMetadataResult = interface;//com.google.android.gms.games.leaderboard.Leaderboards$LeaderboardMetadataResult
  JLeaderboards_LoadPlayerScoreResult = interface;//com.google.android.gms.games.leaderboard.Leaderboards$LoadPlayerScoreResult
  JLeaderboards_LoadScoresResult = interface;//com.google.android.gms.games.leaderboard.Leaderboards$LoadScoresResult
  JLeaderboards_SubmitScoreResult = interface;//com.google.android.gms.games.leaderboard.Leaderboards$SubmitScoreResult
  JScoreSubmissionData = interface;//com.google.android.gms.games.leaderboard.ScoreSubmissionData
  JScoreSubmissionData_Result = interface;//com.google.android.gms.games.leaderboard.ScoreSubmissionData$Result
  JInvitation = interface;//com.google.android.gms.games.multiplayer.Invitation
  //JInvitationBuffer = interface;//com.google.android.gms.games.multiplayer.InvitationBuffer
  //JInvitationEntity = interface;//com.google.android.gms.games.multiplayer.InvitationEntity
  JInvitations = interface;//com.google.android.gms.games.multiplayer.Invitations
  JInvitations_LoadInvitationsResult = interface;//com.google.android.gms.games.multiplayer.Invitations$LoadInvitationsResult
  JMultiplayer = interface;//com.google.android.gms.games.multiplayer.Multiplayer
  JOnInvitationReceivedListener = interface;//com.google.android.gms.games.multiplayer.OnInvitationReceivedListener
  JParticipant = interface;//com.google.android.gms.games.multiplayer.Participant
  JParticipantBuffer = interface;//com.google.android.gms.games.multiplayer.ParticipantBuffer
  //JParticipantEntity = interface;//com.google.android.gms.games.multiplayer.ParticipantEntity
  JParticipantResult = interface;//com.google.android.gms.games.multiplayer.ParticipantResult
  JParticipantResultCreator = interface;//com.google.android.gms.games.multiplayer.ParticipantResultCreator
  JParticipantUtils = interface;//com.google.android.gms.games.multiplayer.ParticipantUtils
  JParticipatable = interface;//com.google.android.gms.games.multiplayer.Participatable
  JRealTimeMessage = interface;//com.google.android.gms.games.multiplayer.realtime.RealTimeMessage
  JRealTimeMessageReceivedListener = interface;//com.google.android.gms.games.multiplayer.realtime.RealTimeMessageReceivedListener
  JRealTimeMultiplayer = interface;//com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer
  JRealTimeMultiplayer_ReliableMessageSentCallback = interface;//com.google.android.gms.games.multiplayer.realtime.RealTimeMultiplayer$ReliableMessageSentCallback
  Jrealtime_RealTimeSocket = interface;//com.google.android.gms.games.multiplayer.realtime.RealTimeSocket
  JRoom = interface;//com.google.android.gms.games.multiplayer.realtime.Room
  JRoomConfig = interface;//com.google.android.gms.games.multiplayer.realtime.RoomConfig
  JRoomConfig_Builder = interface;//com.google.android.gms.games.multiplayer.realtime.RoomConfig$Builder
  //JRoomEntity = interface;//com.google.android.gms.games.multiplayer.realtime.RoomEntity
  JRoomStatusUpdateListener = interface;//com.google.android.gms.games.multiplayer.realtime.RoomStatusUpdateListener
  JRoomUpdateListener = interface;//com.google.android.gms.games.multiplayer.realtime.RoomUpdateListener
  JLoadMatchesResponse = interface;//com.google.android.gms.games.multiplayer.turnbased.LoadMatchesResponse
  JOnTurnBasedMatchUpdateReceivedListener = interface;//com.google.android.gms.games.multiplayer.turnbased.OnTurnBasedMatchUpdateReceivedListener
  JTurnBasedMatch = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatch
  //JTurnBasedMatchBuffer = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchBuffer
  JTurnBasedMatchConfig = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchConfig
  JTurnBasedMatchConfig_1 = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchConfig$1
  JTurnBasedMatchConfig_Builder = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchConfig$Builder
  JTurnBasedMatchEntity = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchEntity
  JTurnBasedMatchEntityCreator = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchEntityCreator
  JTurnBasedMultiplayer = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer
  JTurnBasedMultiplayer_CancelMatchResult = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer$CancelMatchResult
  JTurnBasedMultiplayer_InitiateMatchResult = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer$InitiateMatchResult
  JTurnBasedMultiplayer_LeaveMatchResult = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer$LeaveMatchResult
  JTurnBasedMultiplayer_LoadMatchResult = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer$LoadMatchResult
  JTurnBasedMultiplayer_LoadMatchesResult = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer$LoadMatchesResult
  JTurnBasedMultiplayer_UpdateMatchResult = interface;//com.google.android.gms.games.multiplayer.turnbased.TurnBasedMultiplayer$UpdateMatchResult
  JGameRequest = interface;//com.google.android.gms.games.request.GameRequest
  //JGameRequestBuffer = interface;//com.google.android.gms.games.request.GameRequestBuffer
  JGameRequestEntity = interface;//com.google.android.gms.games.request.GameRequestEntity
  JGameRequestEntityCreator = interface;//com.google.android.gms.games.request.GameRequestEntityCreator
  JOnRequestReceivedListener = interface;//com.google.android.gms.games.request.OnRequestReceivedListener
  JRequests = interface;//com.google.android.gms.games.request.Requests
  JRequests_LoadRequestsResult = interface;//com.google.android.gms.games.request.Requests$LoadRequestsResult
  JRequests_UpdateRequestsResult = interface;//com.google.android.gms.games.request.Requests$UpdateRequestsResult
  JGoogleCloudMessaging = interface;//com.google.android.gms.gcm.GoogleCloudMessaging
  Jintents_Address = interface;//com.google.android.gms.identity.intents.Address
  JAddress_AddressOptions = interface;//com.google.android.gms.identity.intents.Address$AddressOptions
  JAddressConstants = interface;//com.google.android.gms.identity.intents.AddressConstants
  JAddressConstants_ErrorCodes = interface;//com.google.android.gms.identity.intents.AddressConstants$ErrorCodes
  JAddressConstants_Extras = interface;//com.google.android.gms.identity.intents.AddressConstants$Extras
  JAddressConstants_ResultCodes = interface;//com.google.android.gms.identity.intents.AddressConstants$ResultCodes
  JAddressConstants_Themes = interface;//com.google.android.gms.identity.intents.AddressConstants$Themes
  JUserAddressRequest = interface;//com.google.android.gms.identity.intents.UserAddressRequest
  JUserAddressRequest_Builder = interface;//com.google.android.gms.identity.intents.UserAddressRequest$Builder
  JCountrySpecification = interface;//com.google.android.gms.identity.intents.model.CountrySpecification
  JUserAddress = interface;//com.google.android.gms.identity.intents.model.UserAddress
  JActivityRecognitionClient = interface;//com.google.android.gms.location.ActivityRecognitionClient
  JActivityRecognitionResult = interface;//com.google.android.gms.location.ActivityRecognitionResult
  JActivityRecognitionResultCreator = interface;//com.google.android.gms.location.ActivityRecognitionResultCreator
  JDetectedActivity = interface;//com.google.android.gms.location.DetectedActivity
  JDetectedActivityCreator = interface;//com.google.android.gms.location.DetectedActivityCreator
  JGeofence = interface;//com.google.android.gms.location.Geofence
  JGeofence_Builder = interface;//com.google.android.gms.location.Geofence$Builder
  JGeofenceStatusCodes = interface;//com.google.android.gms.location.GeofenceStatusCodes
  JLocationClient = interface;//com.google.android.gms.location.LocationClient
  JLocationClient_OnAddGeofencesResultListener = interface;//com.google.android.gms.location.LocationClient$OnAddGeofencesResultListener
  JLocationClient_OnRemoveGeofencesResultListener = interface;//com.google.android.gms.location.LocationClient$OnRemoveGeofencesResultListener
  Jlocation_LocationListener = interface;//com.google.android.gms.location.LocationListener
  JLocationRequest = interface;//com.google.android.gms.location.LocationRequest
  JLocationRequestCreator = interface;//com.google.android.gms.location.LocationRequestCreator
  JLocationStatusCodes = interface;//com.google.android.gms.location.LocationStatusCodes
  JCameraUpdate = interface;//com.google.android.gms.maps.CameraUpdate
  JCameraUpdateFactory = interface;//com.google.android.gms.maps.CameraUpdateFactory
  JGoogleMap = interface;//com.google.android.gms.maps.GoogleMap
  JGoogleMap_CancelableCallback = interface;//com.google.android.gms.maps.GoogleMap$CancelableCallback
  JGoogleMap_InfoWindowAdapter = interface;//com.google.android.gms.maps.GoogleMap$InfoWindowAdapter
  JGoogleMap_OnCameraChangeListener = interface;//com.google.android.gms.maps.GoogleMap$OnCameraChangeListener
  JGoogleMap_OnInfoWindowClickListener = interface;//com.google.android.gms.maps.GoogleMap$OnInfoWindowClickListener
  JGoogleMap_OnMapClickListener = interface;//com.google.android.gms.maps.GoogleMap$OnMapClickListener
  JGoogleMap_OnMapLoadedCallback = interface;//com.google.android.gms.maps.GoogleMap$OnMapLoadedCallback
  JGoogleMap_OnMapLongClickListener = interface;//com.google.android.gms.maps.GoogleMap$OnMapLongClickListener
  JGoogleMap_OnMarkerClickListener = interface;//com.google.android.gms.maps.GoogleMap$OnMarkerClickListener
  JGoogleMap_OnMarkerDragListener = interface;//com.google.android.gms.maps.GoogleMap$OnMarkerDragListener
  JGoogleMap_OnMyLocationButtonClickListener = interface;//com.google.android.gms.maps.GoogleMap$OnMyLocationButtonClickListener
  JGoogleMap_OnMyLocationChangeListener = interface;//com.google.android.gms.maps.GoogleMap$OnMyLocationChangeListener
  JGoogleMap_SnapshotReadyCallback = interface;//com.google.android.gms.maps.GoogleMap$SnapshotReadyCallback
  JGoogleMapOptions = interface;//com.google.android.gms.maps.GoogleMapOptions
  JGoogleMapOptionsCreator = interface;//com.google.android.gms.maps.GoogleMapOptionsCreator
  JLocationSource = interface;//com.google.android.gms.maps.LocationSource
  JLocationSource_OnLocationChangedListener = interface;//com.google.android.gms.maps.LocationSource$OnLocationChangedListener
  JMapFragment = interface;//com.google.android.gms.maps.MapFragment
  JMapView = interface;//com.google.android.gms.maps.MapView
  JMapsInitializer = interface;//com.google.android.gms.maps.MapsInitializer
  JProjection = interface;//com.google.android.gms.maps.Projection
  JSupportMapFragment = interface;//com.google.android.gms.maps.SupportMapFragment
  JSupportMapFragment_a = interface;//com.google.android.gms.maps.SupportMapFragment$a
  //JSupportMapFragment_b = interface;//com.google.android.gms.maps.SupportMapFragment$b
  JUiSettings = interface;//com.google.android.gms.maps.UiSettings
  JICameraUpdateFactoryDelegate = interface;//com.google.android.gms.maps.internal.ICameraUpdateFactoryDelegate
  JIGoogleMapDelegate = interface;//com.google.android.gms.maps.internal.IGoogleMapDelegate
  JILocationSourceDelegate = interface;//com.google.android.gms.maps.internal.ILocationSourceDelegate
  JIMapFragmentDelegate = interface;//com.google.android.gms.maps.internal.IMapFragmentDelegate
  JIMapViewDelegate = interface;//com.google.android.gms.maps.internal.IMapViewDelegate
  JIProjectionDelegate = interface;//com.google.android.gms.maps.internal.IProjectionDelegate
  JIUiSettingsDelegate = interface;//com.google.android.gms.maps.internal.IUiSettingsDelegate
  JBitmapDescriptor = interface;//com.google.android.gms.maps.model.BitmapDescriptor
  JBitmapDescriptorFactory = interface;//com.google.android.gms.maps.model.BitmapDescriptorFactory
  JCameraPosition = interface;//com.google.android.gms.maps.model.CameraPosition
  JCameraPosition_Builder = interface;//com.google.android.gms.maps.model.CameraPosition$Builder
  JCameraPositionCreator = interface;//com.google.android.gms.maps.model.CameraPositionCreator
  JCircle = interface;//com.google.android.gms.maps.model.Circle
  JCircleOptions = interface;//com.google.android.gms.maps.model.CircleOptions
  JCircleOptionsCreator = interface;//com.google.android.gms.maps.model.CircleOptionsCreator
  JGroundOverlay = interface;//com.google.android.gms.maps.model.GroundOverlay
  JGroundOverlayOptions = interface;//com.google.android.gms.maps.model.GroundOverlayOptions
  JGroundOverlayOptionsCreator = interface;//com.google.android.gms.maps.model.GroundOverlayOptionsCreator
  JLatLng = interface;//com.google.android.gms.maps.model.LatLng
  JLatLngBounds = interface;//com.google.android.gms.maps.model.LatLngBounds
  JLatLngBounds_Builder = interface;//com.google.android.gms.maps.model.LatLngBounds$Builder
  JLatLngBoundsCreator = interface;//com.google.android.gms.maps.model.LatLngBoundsCreator
  JLatLngCreator = interface;//com.google.android.gms.maps.model.LatLngCreator
  JMarker = interface;//com.google.android.gms.maps.model.Marker
  JMarkerOptions = interface;//com.google.android.gms.maps.model.MarkerOptions
  JMarkerOptionsCreator = interface;//com.google.android.gms.maps.model.MarkerOptionsCreator
  JPolygon = interface;//com.google.android.gms.maps.model.Polygon
  JPolygonOptions = interface;//com.google.android.gms.maps.model.PolygonOptions
  JPolygonOptionsCreator = interface;//com.google.android.gms.maps.model.PolygonOptionsCreator
  JPolyline = interface;//com.google.android.gms.maps.model.Polyline
  JPolylineOptions = interface;//com.google.android.gms.maps.model.PolylineOptions
  JPolylineOptionsCreator = interface;//com.google.android.gms.maps.model.PolylineOptionsCreator
  JRuntimeRemoteException = interface;//com.google.android.gms.maps.model.RuntimeRemoteException
  JTile = interface;//com.google.android.gms.maps.model.Tile
  JTileCreator = interface;//com.google.android.gms.maps.model.TileCreator
  JTileOverlay = interface;//com.google.android.gms.maps.model.TileOverlay
  JTileOverlayOptions = interface;//com.google.android.gms.maps.model.TileOverlayOptions
  JTileOverlayOptionsCreator = interface;//com.google.android.gms.maps.model.TileOverlayOptionsCreator
  JTileProvider = interface;//com.google.android.gms.maps.model.TileProvider
  JUrlTileProvider = interface;//com.google.android.gms.maps.model.UrlTileProvider
  JVisibleRegion = interface;//com.google.android.gms.maps.model.VisibleRegion
  JVisibleRegionCreator = interface;//com.google.android.gms.maps.model.VisibleRegionCreator
  JIPolylineDelegate = interface;//com.google.android.gms.maps.model.internal.IPolylineDelegate
  JPanorama = interface;//com.google.android.gms.panorama.Panorama
  JPanorama_PanoramaResult = interface;//com.google.android.gms.panorama.Panorama$PanoramaResult
  JPanoramaClient = interface;//com.google.android.gms.panorama.PanoramaClient
  JPanoramaClient_OnPanoramaInfoLoadedListener = interface;//com.google.android.gms.panorama.PanoramaClient$OnPanoramaInfoLoadedListener
  Jplus_Account = interface;//com.google.android.gms.plus.Account
  JMoments = interface;//com.google.android.gms.plus.Moments
  JMoments_LoadMomentsResult = interface;//com.google.android.gms.plus.Moments$LoadMomentsResult
  JPeople = interface;//com.google.android.gms.plus.People
  JPeople_LoadPeopleResult = interface;//com.google.android.gms.plus.People$LoadPeopleResult
  JPeople_OrderBy = interface;//com.google.android.gms.plus.People$OrderBy
  JPlus = interface;//com.google.android.gms.plus.Plus
  JPlus_PlusOptions = interface;//com.google.android.gms.plus.Plus$PlusOptions
  JPlusOptions_Builder = interface;//com.google.android.gms.plus.Plus$PlusOptions$Builder
  JPlusClient = interface;//com.google.android.gms.plus.PlusClient
  JPlusClient_Builder = interface;//com.google.android.gms.plus.PlusClient$Builder
  JPlusClient_OnAccessRevokedListener = interface;//com.google.android.gms.plus.PlusClient$OnAccessRevokedListener
  JPlusClient_OnMomentsLoadedListener = interface;//com.google.android.gms.plus.PlusClient$OnMomentsLoadedListener
  JPlusClient_OnPeopleLoadedListener = interface;//com.google.android.gms.plus.PlusClient$OnPeopleLoadedListener
  JPlusClient_OrderBy = interface;//com.google.android.gms.plus.PlusClient$OrderBy
  JPlusOneButton = interface;//com.google.android.gms.plus.PlusOneButton
  JPlusOneButton_DefaultOnPlusOneClickListener = interface;//com.google.android.gms.plus.PlusOneButton$DefaultOnPlusOneClickListener
  JPlusOneButton_OnPlusOneClickListener = interface;//com.google.android.gms.plus.PlusOneButton$OnPlusOneClickListener
  JPlusOneDummyView = interface;//com.google.android.gms.plus.PlusOneDummyView
  JPlusShare = interface;//com.google.android.gms.plus.PlusShare
  JPlusShare_Builder = interface;//com.google.android.gms.plus.PlusShare$Builder
  JPlusCommonExtras = interface;//com.google.android.gms.plus.internal.PlusCommonExtras
  JItemScope = interface;//com.google.android.gms.plus.model.moments.ItemScope
  JItemScope_Builder = interface;//com.google.android.gms.plus.model.moments.ItemScope$Builder
  JMoment = interface;//com.google.android.gms.plus.model.moments.Moment
  JMoment_Builder = interface;//com.google.android.gms.plus.model.moments.Moment$Builder
  JMomentBuffer = interface;//com.google.android.gms.plus.model.moments.MomentBuffer
  JPerson = interface;//com.google.android.gms.plus.model.people.Person
  JPerson_AgeRange = interface;//com.google.android.gms.plus.model.people.Person$AgeRange
  JPerson_Cover = interface;//com.google.android.gms.plus.model.people.Person$Cover
  JCover_CoverInfo = interface;//com.google.android.gms.plus.model.people.Person$Cover$CoverInfo
  JCover_CoverPhoto = interface;//com.google.android.gms.plus.model.people.Person$Cover$CoverPhoto
  JCover_Layout = interface;//com.google.android.gms.plus.model.people.Person$Cover$Layout
  JPerson_Gender = interface;//com.google.android.gms.plus.model.people.Person$Gender
  JPerson_Image = interface;//com.google.android.gms.plus.model.people.Person$Image
  JPerson_Name = interface;//com.google.android.gms.plus.model.people.Person$Name
  JPerson_ObjectType = interface;//com.google.android.gms.plus.model.people.Person$ObjectType
  JPerson_Organizations = interface;//com.google.android.gms.plus.model.people.Person$Organizations
  JOrganizations_Type = interface;//com.google.android.gms.plus.model.people.Person$Organizations$Type
  JPerson_PlacesLived = interface;//com.google.android.gms.plus.model.people.Person$PlacesLived
  JPerson_RelationshipStatus = interface;//com.google.android.gms.plus.model.people.Person$RelationshipStatus
  JPerson_Urls = interface;//com.google.android.gms.plus.model.people.Person$Urls
  JUrls_Type = interface;//com.google.android.gms.plus.model.people.Person$Urls$Type
  JPersonBuffer = interface;//com.google.android.gms.plus.model.people.PersonBuffer
  JContainer = interface;//com.google.android.gms.tagmanager.Container
  JContainer_FunctionCallMacroCallback = interface;//com.google.android.gms.tagmanager.Container$FunctionCallMacroCallback
  JContainer_FunctionCallTagCallback = interface;//com.google.android.gms.tagmanager.Container$FunctionCallTagCallback
  JContainerHolder = interface;//com.google.android.gms.tagmanager.ContainerHolder
  JContainerHolder_ContainerAvailableListener = interface;//com.google.android.gms.tagmanager.ContainerHolder$ContainerAvailableListener
  JDataLayer = interface;//com.google.android.gms.tagmanager.DataLayer
  JInstallReferrerReceiver = interface;//com.google.android.gms.tagmanager.InstallReferrerReceiver
  JInstallReferrerService = interface;//com.google.android.gms.tagmanager.InstallReferrerService
  JPreviewActivity = interface;//com.google.android.gms.tagmanager.PreviewActivity
  JTagManager = interface;//com.google.android.gms.tagmanager.TagManager
  Jwallet_Address = interface;//com.google.android.gms.wallet.Address
  JCart = interface;//com.google.android.gms.wallet.Cart
  JCart_Builder = interface;//com.google.android.gms.wallet.Cart$Builder
  Jwallet_CountrySpecification = interface;//com.google.android.gms.wallet.CountrySpecification
  JEnableWalletOptimizationReceiver = interface;//com.google.android.gms.wallet.EnableWalletOptimizationReceiver
  JFullWallet = interface;//com.google.android.gms.wallet.FullWallet
  JFullWalletRequest = interface;//com.google.android.gms.wallet.FullWalletRequest
  JFullWalletRequest_Builder = interface;//com.google.android.gms.wallet.FullWalletRequest$Builder
  JInstrumentInfo = interface;//com.google.android.gms.wallet.InstrumentInfo
  JLineItem = interface;//com.google.android.gms.wallet.LineItem
  JLineItem_Builder = interface;//com.google.android.gms.wallet.LineItem$Builder
  JLineItem_Role = interface;//com.google.android.gms.wallet.LineItem$Role
  JLoyaltyWalletObject = interface;//com.google.android.gms.wallet.LoyaltyWalletObject
  JMaskedWallet = interface;//com.google.android.gms.wallet.MaskedWallet
  JMaskedWalletRequest = interface;//com.google.android.gms.wallet.MaskedWalletRequest
  JMaskedWalletRequest_Builder = interface;//com.google.android.gms.wallet.MaskedWalletRequest$Builder
  JNotifyTransactionStatusRequest = interface;//com.google.android.gms.wallet.NotifyTransactionStatusRequest
  JNotifyTransactionStatusRequest_Builder = interface;//com.google.android.gms.wallet.NotifyTransactionStatusRequest$Builder
  JNotifyTransactionStatusRequest_Status = interface;//com.google.android.gms.wallet.NotifyTransactionStatusRequest$Status
  JStatus_Error = interface;//com.google.android.gms.wallet.NotifyTransactionStatusRequest$Status$Error
  JOfferWalletObject = interface;//com.google.android.gms.wallet.OfferWalletObject
  JProxyCard = interface;//com.google.android.gms.wallet.ProxyCard
  JWallet = interface;//com.google.android.gms.wallet.Wallet
  JWallet_WalletOptions = interface;//com.google.android.gms.wallet.Wallet$WalletOptions
  JWalletOptions_Builder = interface;//com.google.android.gms.wallet.Wallet$WalletOptions$Builder
  JWalletClient = interface;//com.google.android.gms.wallet.WalletClient
  JWalletConstants = interface;//com.google.android.gms.wallet.WalletConstants

// ===== Interface declarations =====

  Janalytics_CampaignTrackingReceiverClass = interface(JBroadcastReceiverClass)
    ['{F3E58606-AF48-4E21-98FE-ABE70196526B}']
    {class} function init: Janalytics_CampaignTrackingReceiver; cdecl;
  end;

  [JavaSignature('com/google/android/gms/analytics/CampaignTrackingReceiver')]
  Janalytics_CampaignTrackingReceiver = interface(JBroadcastReceiver)
    ['{98DF24D4-3030-40D4-8B77-D2F81984DDB2}']
    procedure onReceive(ctx: JContext; intent: JIntent); cdecl;
  end;
  TJanalytics_CampaignTrackingReceiver = class(TJavaGenericImport<Janalytics_CampaignTrackingReceiverClass, Janalytics_CampaignTrackingReceiver>) end;

  Janalytics_CampaignTrackingServiceClass = interface(JIntentServiceClass)
    ['{A23838F9-0337-4A01-92EC-8D480F1A97CC}']
    {class} function init: Janalytics_CampaignTrackingService; cdecl; overload;
    {class} function init(name: JString): Janalytics_CampaignTrackingService; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/analytics/CampaignTrackingService')]
  Janalytics_CampaignTrackingService = interface(JIntentService)
    ['{47DE91BE-55C4-40B9-8B34-05752E464C0A}']
    procedure onHandleIntent(intent: JIntent); cdecl;
    procedure processIntent(context: JContext; intent: JIntent); cdecl;
  end;
  TJanalytics_CampaignTrackingService = class(TJavaGenericImport<Janalytics_CampaignTrackingServiceClass, Janalytics_CampaignTrackingService>) end;

  Janalytics_ExceptionParserClass = interface(IJavaClass)
    ['{9CAB938F-3B8C-4C6F-94FB-ED558C8F8114}']
  end;

  [JavaSignature('com/google/android/gms/analytics/ExceptionParser')]
  Janalytics_ExceptionParser = interface(IJavaInstance)
    ['{D718F45D-2BCA-4AEE-A3AF-78B396CA181E}']
    function getDescription(P1: JString; P2: JThrowable): JString; cdecl;
  end;
  TJanalytics_ExceptionParser = class(TJavaGenericImport<Janalytics_ExceptionParserClass, Janalytics_ExceptionParser>) end;

  Janalytics_ExceptionReporterClass = interface(JObjectClass)
    ['{4D7709D2-6B3D-4441-89DE-2EC4617DF77F}']
    {class} function init(tracker: Janalytics_Tracker; originalHandler: JThread_UncaughtExceptionHandler; context: JContext): Janalytics_ExceptionReporter; cdecl;
  end;

  [JavaSignature('com/google/android/gms/analytics/ExceptionReporter')]
  Janalytics_ExceptionReporter = interface(JObject)
    ['{B9BA7D69-40D6-4C13-A3CB-C9D07F52E9F6}']
    function getExceptionParser: Janalytics_ExceptionParser; cdecl;
    procedure setExceptionParser(exceptionParser: Janalytics_ExceptionParser); cdecl;
    procedure uncaughtException(t: JThread; e: JThrowable); cdecl;
  end;
  TJanalytics_ExceptionReporter = class(TJavaGenericImport<Janalytics_ExceptionReporterClass, Janalytics_ExceptionReporter>) end;

  JTrackerHandlerClass = interface(JObjectClass)
    ['{51B0872E-67AE-433D-8D58-2E70A31AB57C}']
  end;

  [JavaSignature('com/google/android/gms/analytics/TrackerHandler')]
  JTrackerHandler = interface(JObject)
    ['{1F0E87C7-6891-4163-8807-B20D4B21D886}']
  end;
  TJTrackerHandler = class(TJavaGenericImport<JTrackerHandlerClass, JTrackerHandler>) end;

  Janalytics_GoogleAnalyticsClass = interface(JTrackerHandlerClass)
    ['{F2E3C326-B039-4287-A4F0-9E245B3CEB58}']
    {class} function getInstance(context: JContext): Janalytics_GoogleAnalytics; cdecl;
  end;

  [JavaSignature('com/google/android/gms/analytics/GoogleAnalytics')]
  Janalytics_GoogleAnalytics = interface(JTrackerHandler)
    ['{33FBE395-24D8-4CB8-B8B5-FE0236155B42}']
    procedure dispatchLocalHits; cdecl;
    procedure enableAutoActivityReports(application: JApplication); cdecl;
    function getAppOptOut: Boolean; cdecl;
    function getLogger: Janalytics_Logger; cdecl;
    function isDryRunEnabled: Boolean; cdecl;
    function newTracker(trackingId: JString): Janalytics_Tracker; cdecl; overload;
    function newTracker(configResId: Integer): Janalytics_Tracker; cdecl; overload;
    procedure reportActivityStart(activity: JActivity); cdecl;
    procedure reportActivityStop(activity: JActivity); cdecl;
    procedure setAppOptOut(optOut: Boolean); cdecl;
    procedure setDryRun(dryRun: Boolean); cdecl;
    procedure setLocalDispatchPeriod(dispatchPeriodInSeconds: Integer); cdecl;
    procedure setLogger(logger: Janalytics_Logger); cdecl;
  end;
  TJanalytics_GoogleAnalytics = class(TJavaGenericImport<Janalytics_GoogleAnalyticsClass, Janalytics_GoogleAnalytics>) end;

  JHitBuildersClass = interface(JObjectClass)
    ['{2A9508B9-261E-440C-A0EA-44BC063C4451}']
    {class} function init: JHitBuilders; cdecl;
  end;

  [JavaSignature('com/google/android/gms/analytics/HitBuilders')]
  JHitBuilders = interface(JObject)
    ['{DF12701C-F5AC-47BD-96D3-02771A242CA2}']
  end;
  TJHitBuilders = class(TJavaGenericImport<JHitBuildersClass, JHitBuilders>) end;

  JHitBuilders_HitBuilderClass = interface(JObjectClass)
    ['{99EB8BD6-4CF8-4069-BDF1-86908E209537}']
  end;

  [JavaSignature('com/google/android/gms/analytics/HitBuilders$HitBuilder')]
  JHitBuilders_HitBuilder = interface(JObject)
    ['{B3538B0F-637F-4D53-ABBB-A3AF6BAA50AE}']
    function build: JMap; cdecl;
    function &set(paramName: JString; paramValue: JString): JHitBuilders_HitBuilder; cdecl;
    function setAll(params: JMap): JHitBuilders_HitBuilder; cdecl;
    function setCampaignParamsFromUrl(utmParams: JString): JHitBuilders_HitBuilder; cdecl;
    function setCustomDimension(index: Integer; dimension: JString): JHitBuilders_HitBuilder; cdecl;
    function setCustomMetric(index: Integer; metric: Single): JHitBuilders_HitBuilder; cdecl;
    function setNewSession: JHitBuilders_HitBuilder; cdecl;
    function setNonInteraction(nonInteraction: Boolean): JHitBuilders_HitBuilder; cdecl;
  end;
  TJHitBuilders_HitBuilder = class(TJavaGenericImport<JHitBuilders_HitBuilderClass, JHitBuilders_HitBuilder>) end;

  JHitBuilders_AppViewBuilderClass = interface(JHitBuilders_HitBuilderClass)
    ['{7DFC88F1-8A99-442D-9B88-4FA390782347}']
    {class} function init: JHitBuilders_AppViewBuilder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/analytics/HitBuilders$AppViewBuilder')]
  JHitBuilders_AppViewBuilder = interface(JHitBuilders_HitBuilder)
    ['{F0B7724E-19B5-4B30-8453-40C0FC96D2C4}']
    function build: JMap; cdecl;
  end;
  TJHitBuilders_AppViewBuilder = class(TJavaGenericImport<JHitBuilders_AppViewBuilderClass, JHitBuilders_AppViewBuilder>) end;

  JHitBuilders_EventBuilderClass = interface(JHitBuilders_HitBuilderClass)
    ['{0AD926F1-65A0-4D75-9E47-E79DBF9ADCB3}']
    {class} function init: JHitBuilders_EventBuilder; cdecl; overload;
    {class} function init(category: JString; action: JString): JHitBuilders_EventBuilder; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/analytics/HitBuilders$EventBuilder')]
  JHitBuilders_EventBuilder = interface(JHitBuilders_HitBuilder)
    ['{0958D4F8-7BA4-46E0-8241-47821CDECF52}']
    function build: JMap; cdecl;
    function setAction(action: JString): JHitBuilders_EventBuilder; cdecl;
    function setCategory(category: JString): JHitBuilders_EventBuilder; cdecl;
    function setLabel(label_: JString): JHitBuilders_EventBuilder; cdecl;
    function setValue(value: Int64): JHitBuilders_EventBuilder; cdecl;
  end;
  TJHitBuilders_EventBuilder = class(TJavaGenericImport<JHitBuilders_EventBuilderClass, JHitBuilders_EventBuilder>) end;

  JHitBuilders_ExceptionBuilderClass = interface(JHitBuilders_HitBuilderClass)
    ['{AFF3A07C-BC10-4793-8602-D12E46C6F24B}']
    {class} function init: JHitBuilders_ExceptionBuilder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/analytics/HitBuilders$ExceptionBuilder')]
  JHitBuilders_ExceptionBuilder = interface(JHitBuilders_HitBuilder)
    ['{EF322E05-72F4-4D94-A9CF-4ED675A45886}']
    function build: JMap; cdecl;
    function setDescription(description: JString): JHitBuilders_ExceptionBuilder; cdecl;
    function setFatal(fatal: Boolean): JHitBuilders_ExceptionBuilder; cdecl;
  end;
  TJHitBuilders_ExceptionBuilder = class(TJavaGenericImport<JHitBuilders_ExceptionBuilderClass, JHitBuilders_ExceptionBuilder>) end;

  JHitBuilders_ItemBuilderClass = interface(JHitBuilders_HitBuilderClass)
    ['{44DAF5BC-01B3-4F6F-BAC7-FE9665C28514}']
    {class} function init: JHitBuilders_ItemBuilder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/analytics/HitBuilders$ItemBuilder')]
  JHitBuilders_ItemBuilder = interface(JHitBuilders_HitBuilder)
    ['{D953FEE8-FF17-41BF-9B31-AD8D17CDB8BC}']
    function build: JMap; cdecl;
    function setCategory(category: JString): JHitBuilders_ItemBuilder; cdecl;
    function setCurrencyCode(currencyCode: JString): JHitBuilders_ItemBuilder; cdecl;
    function setName(name: JString): JHitBuilders_ItemBuilder; cdecl;
    function setPrice(price: Double): JHitBuilders_ItemBuilder; cdecl;
    function setQuantity(quantity: Int64): JHitBuilders_ItemBuilder; cdecl;
    function setSku(sku: JString): JHitBuilders_ItemBuilder; cdecl;
    function setTransactionId(transactionid: JString): JHitBuilders_ItemBuilder; cdecl;
  end;
  TJHitBuilders_ItemBuilder = class(TJavaGenericImport<JHitBuilders_ItemBuilderClass, JHitBuilders_ItemBuilder>) end;

  JHitBuilders_SocialBuilderClass = interface(JHitBuilders_HitBuilderClass)
    ['{CED624DA-C396-4D11-8683-DA696F34D7F3}']
    {class} function init: JHitBuilders_SocialBuilder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/analytics/HitBuilders$SocialBuilder')]
  JHitBuilders_SocialBuilder = interface(JHitBuilders_HitBuilder)
    ['{E5B73637-91CE-4980-A170-AB95D0B5C138}']
    function build: JMap; cdecl;
    function setAction(action: JString): JHitBuilders_SocialBuilder; cdecl;
    function setNetwork(network: JString): JHitBuilders_SocialBuilder; cdecl;
    function setTarget(target: JString): JHitBuilders_SocialBuilder; cdecl;
  end;
  TJHitBuilders_SocialBuilder = class(TJavaGenericImport<JHitBuilders_SocialBuilderClass, JHitBuilders_SocialBuilder>) end;

  JHitBuilders_TimingBuilderClass = interface(JHitBuilders_HitBuilderClass)
    ['{F86D2F79-0988-45AC-8411-DD1526EB02DF}']
    {class} function init: JHitBuilders_TimingBuilder; cdecl; overload;
    {class} function init(category: JString; variable: JString; value: Int64): JHitBuilders_TimingBuilder; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/analytics/HitBuilders$TimingBuilder')]
  JHitBuilders_TimingBuilder = interface(JHitBuilders_HitBuilder)
    ['{0DB1CBEB-D31A-46D5-BB9E-B4AC64CE511F}']
    function build: JMap; cdecl;
    function setCategory(category: JString): JHitBuilders_TimingBuilder; cdecl;
    function setLabel(label_: JString): JHitBuilders_TimingBuilder; cdecl;
    function setValue(value: Int64): JHitBuilders_TimingBuilder; cdecl;
    function setVariable(variable: JString): JHitBuilders_TimingBuilder; cdecl;
  end;
  TJHitBuilders_TimingBuilder = class(TJavaGenericImport<JHitBuilders_TimingBuilderClass, JHitBuilders_TimingBuilder>) end;

  JHitBuilders_TransactionBuilderClass = interface(JHitBuilders_HitBuilderClass)
    ['{B745F1C2-B442-4C10-8D4D-DF4D47D91B12}']
    {class} function init: JHitBuilders_TransactionBuilder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/analytics/HitBuilders$TransactionBuilder')]
  JHitBuilders_TransactionBuilder = interface(JHitBuilders_HitBuilder)
    ['{95FE4E3A-1875-4DA7-8BD2-B9997D1EA686}']
    function build: JMap; cdecl;
    function setAffiliation(affiliation: JString): JHitBuilders_TransactionBuilder; cdecl;
    function setCurrencyCode(currencyCode: JString): JHitBuilders_TransactionBuilder; cdecl;
    function setRevenue(revenue: Double): JHitBuilders_TransactionBuilder; cdecl;
    function setShipping(shipping: Double): JHitBuilders_TransactionBuilder; cdecl;
    function setTax(tax: Double): JHitBuilders_TransactionBuilder; cdecl;
    function setTransactionId(transactionid: JString): JHitBuilders_TransactionBuilder; cdecl;
  end;
  TJHitBuilders_TransactionBuilder = class(TJavaGenericImport<JHitBuilders_TransactionBuilderClass, JHitBuilders_TransactionBuilder>) end;

  Janalytics_LoggerClass = interface(IJavaClass)
    ['{7E767281-4B84-4A42-9037-5566624BA119}']
  end;

  [JavaSignature('com/google/android/gms/analytics/Logger')]
  Janalytics_Logger = interface(IJavaInstance)
    ['{6A8D0DBC-F547-40CA-B928-6C2010E259B9}']
    procedure error(P1: JString); cdecl; overload;
    procedure error(P1: JException); cdecl; overload;
    function getLogLevel: Integer; cdecl;
    procedure info(P1: JString); cdecl;
    procedure setLogLevel(P1: Integer); cdecl;
    procedure verbose(P1: JString); cdecl;
    procedure warn(P1: JString); cdecl;
  end;
  TJanalytics_Logger = class(TJavaGenericImport<Janalytics_LoggerClass, Janalytics_Logger>) end;

  JLogger_LogLevelClass = interface(JObjectClass)
    ['{3AC05087-151B-4E3D-AA61-CB981515BD67}']
    {class} function _GetERROR: Integer; cdecl;
    {class} function _GetINFO: Integer; cdecl;
    {class} function _GetVERBOSE: Integer; cdecl;
    {class} function _GetWARNING: Integer; cdecl;
    {class} function init: JLogger_LogLevel; cdecl;
    {class} property ERROR: Integer read _GetERROR;
    {class} property INFO: Integer read _GetINFO;
    {class} property VERBOSE: Integer read _GetVERBOSE;
    {class} property WARNING: Integer read _GetWARNING;
  end;

  [JavaSignature('com/google/android/gms/analytics/Logger$LogLevel')]
  JLogger_LogLevel = interface(JObject)
    ['{75FD636D-B99D-46AF-83E3-4E7A508D94F4}']
  end;
  TJLogger_LogLevel = class(TJavaGenericImport<JLogger_LogLevelClass, JLogger_LogLevel>) end;

  Janalytics_StandardExceptionParserClass = interface(JObjectClass)
    ['{830E5A8D-5DEA-41E8-BF80-157BD3994FA8}']
    {class} function init(context: JContext; additionalPackages: JCollection): Janalytics_StandardExceptionParser; cdecl;
  end;

  [JavaSignature('com/google/android/gms/analytics/StandardExceptionParser')]
  Janalytics_StandardExceptionParser = interface(JObject)
    ['{93243A7E-563E-4240-8E3E-1AC7E0155A3A}']
    function getDescription(threadName: JString; t: JThrowable): JString; cdecl; overload;
    procedure setIncludedPackages(context: JContext; additionalPackages: JCollection); cdecl;
  end;
  TJanalytics_StandardExceptionParser = class(TJavaGenericImport<Janalytics_StandardExceptionParserClass, Janalytics_StandardExceptionParser>) end;

  Janalytics_TrackerClass = interface(JObjectClass)
    ['{4BF50FD9-0FE9-458A-A4FE-72FE63EFECE6}']
  end;

  [JavaSignature('com/google/android/gms/analytics/Tracker')]
  Janalytics_Tracker = interface(JObject)
    ['{F5746171-0AC3-4EC9-9AB3-64E84C74B915}']
    procedure enableAdvertisingIdCollection(enabled: Boolean); cdecl;
    procedure enableAutoActivityTracking(enabled: Boolean); cdecl;
    function &get(key: JString): JString; cdecl;
    procedure send(params: JMap); cdecl;
    procedure &set(key: JString; value: JString); cdecl;
    procedure setAnonymizeIp(anonymize: Boolean); cdecl;
    procedure setAppId(appId: JString); cdecl;
    procedure setAppInstallerId(appInstallerId: JString); cdecl;
    procedure setAppName(appName: JString); cdecl;
    procedure setAppVersion(appVersion: JString); cdecl;
    procedure setClientId(clientId: JString); cdecl;
    procedure setEncoding(encoding: JString); cdecl;
    procedure setHostname(hostname: JString); cdecl;
    procedure setLanguage(language: JString); cdecl;
    procedure setLocation(location: JString); cdecl;
    procedure setPage(page: JString); cdecl;
    procedure setReferrer(referrer: JString); cdecl;
    procedure setSampleRate(sampleRate: Double); cdecl;
    procedure setScreenColors(screenColors: JString); cdecl;
    procedure setScreenName(screenName: JString); cdecl;
    procedure setScreenResolution(width: Integer; height: Integer); cdecl;
    procedure setSessionTimeout(sessionTimeout: Int64); cdecl;
    procedure setTitle(title: JString); cdecl;
    procedure setUseSecure(useSecure: Boolean); cdecl;
    procedure setViewportSize(viewportSize: JString); cdecl;
  end;
  TJanalytics_Tracker = class(TJavaGenericImport<Janalytics_TrackerClass, Janalytics_Tracker>) end;

  JFreezableClass = interface(IJavaClass)
    ['{7F96F79F-1482-4695-8F2F-F9B3ECD4D9C5}']
  end;

  [JavaSignature('com/google/android/gms/common/data/Freezable')]
  JFreezable = interface(IJavaInstance)
    ['{B39CBE77-7C0F-4FD9-BA32-ADA3BC739705}']
    function freeze: JObject; cdecl;
    function isDataValid: Boolean; cdecl;
  end;
  TJFreezable = class(TJavaGenericImport<JFreezableClass, JFreezable>) end;

  JAppStateClass = interface(JFreezableClass)
    ['{320912A0-C62F-4708-9F27-96135CE528C3}']
  end;

  [JavaSignature('com/google/android/gms/appstate/AppState')]
  JAppState = interface(JFreezable)
    ['{62158A4D-D6E4-4068-84F6-13B5EFAF242C}']
    function getConflictData: TJavaArray<Byte>; cdecl;
    function getConflictVersion: JString; cdecl;
    function getKey: Integer; cdecl;
    function getLocalData: TJavaArray<Byte>; cdecl;
    function getLocalVersion: JString; cdecl;
    function hasConflict: Boolean; cdecl;
  end;
  TJAppState = class(TJavaGenericImport<JAppStateClass, JAppState>) end;

  JDataBufferClass = interface(JObjectClass)
    ['{49C7D692-3653-40EB-B4D9-256184DAFDC3}']
  end;

  [JavaSignature('com/google/android/gms/common/data/DataBuffer')]
  JDataBuffer = interface(JObject)
    ['{E66E2584-412C-4878-B2BF-22E564A67E5B}']
    procedure close; cdecl;
    function describeContents: Integer; cdecl;
    function &get(P1: Integer): JObject; cdecl;
    function getCount: Integer; cdecl;
    function getMetadata: JBundle; cdecl;
    function isClosed: Boolean; cdecl;
    function iterator: JIterator; cdecl;
  end;
  TJDataBuffer = class(TJavaGenericImport<JDataBufferClass, JDataBuffer>) end;

  JAppStateBufferClass = interface(JDataBufferClass)
    ['{C12CC577-CE18-4694-884A-1D2F9ECEF29A}']
    {class} function init(dataHolder: JDataHolder): JAppStateBuffer; cdecl;
  end;

  [JavaSignature('com/google/android/gms/appstate/AppStateBuffer')]
  JAppStateBuffer = interface(JDataBuffer)
    ['{1568FAAC-8015-41E6-9533-29837363DE96}']
    function &get(position: Integer): JAppState; cdecl;
  end;
  TJAppStateBuffer = class(TJavaGenericImport<JAppStateBufferClass, JAppStateBuffer>) end;

  JAppStateManagerClass = interface(JObjectClass)
    ['{06185675-0342-4669-B5F1-D39C44BA5067}']
    {class} //function _GetAPI: JApi; cdecl;
    {class} function _GetSCOPE_APP_STATE: JScope; cdecl;
    {class} //function a(P1: JGoogleApiClient): Jdl; cdecl;
    {class} function delete(googleApiClient: JGoogleApiClient; stateKey: Integer): JPendingResult; cdecl;
    {class} function getMaxNumKeys(googleApiClient: JGoogleApiClient): Integer; cdecl;
    {class} function getMaxStateSize(googleApiClient: JGoogleApiClient): Integer; cdecl;
    {class} function list(googleApiClient: JGoogleApiClient): JPendingResult; cdecl;
    {class} function load(googleApiClient: JGoogleApiClient; stateKey: Integer): JPendingResult; cdecl;
    {class} function resolve(googleApiClient: JGoogleApiClient; stateKey: Integer; resolvedVersion: JString; resolvedData: TJavaArray<Byte>): JPendingResult; cdecl;
    {class} function signOut(googleApiClient: JGoogleApiClient): JPendingResult; cdecl;
    {class} procedure update(googleApiClient: JGoogleApiClient; stateKey: Integer; data: TJavaArray<Byte>); cdecl;
    {class} function updateImmediate(googleApiClient: JGoogleApiClient; stateKey: Integer; data: TJavaArray<Byte>): JPendingResult; cdecl;
    {class} //property API: JApi read _GetAPI;
    {class} property SCOPE_APP_STATE: JScope read _GetSCOPE_APP_STATE;
  end;

  [JavaSignature('com/google/android/gms/appstate/AppStateManager')]
  JAppStateManager = interface(JObject)
    ['{FD1D5764-0FED-4EDD-9494-FB6CD109D574}']
  end;
  TJAppStateManager = class(TJavaGenericImport<JAppStateManagerClass, JAppStateManager>) end;

  JReleasableClass = interface(IJavaClass)
    ['{5E17D634-822C-4CDE-8F5F-B9316E345B3D}']
  end;

  [JavaSignature('com/google/android/gms/common/api/Releasable')]
  JReleasable = interface(IJavaInstance)
    ['{9D70CB2A-6A75-4B67-9D01-AA61C573F79D}']
    procedure release; cdecl;
  end;
  TJReleasable = class(TJavaGenericImport<JReleasableClass, JReleasable>) end;

  JAppStateManager_StateConflictResultClass = interface(JReleasableClass)
    ['{2BDB023E-8465-4B69-9E2A-0C91AE4832DD}']
  end;

  [JavaSignature('com/google/android/gms/appstate/AppStateManager$StateConflictResult')]
  JAppStateManager_StateConflictResult = interface(JReleasable)
    ['{7081B7FA-F7C6-4814-A285-2A707EE34B89}']
    function getLocalData: TJavaArray<Byte>; cdecl;
    function getResolvedVersion: JString; cdecl;
    function getServerData: TJavaArray<Byte>; cdecl;
    function getStateKey: Integer; cdecl;
  end;
  TJAppStateManager_StateConflictResult = class(TJavaGenericImport<JAppStateManager_StateConflictResultClass, JAppStateManager_StateConflictResult>) end;

  Japi_ResultClass = interface(IJavaClass)
    ['{E73B3C27-9EB3-43F6-AEE5-9EE456C0BD14}']
  end;

  [JavaSignature('com/google/android/gms/common/api/Result')]
  Japi_Result = interface(IJavaInstance)
    ['{41994536-DC65-4D9F-A76B-8C53C141A5AD}']
    function getStatus: JStatus; cdecl;
  end;
  TJapi_Result = class(TJavaGenericImport<Japi_ResultClass, Japi_Result>) end;

  JAppStateManager_StateDeletedResultClass = interface(Japi_ResultClass)
    ['{EB1B8D46-F3F5-45E4-AF85-4F3BE419680D}']
  end;

  [JavaSignature('com/google/android/gms/appstate/AppStateManager$StateDeletedResult')]
  JAppStateManager_StateDeletedResult = interface(Japi_Result)
    ['{3143A54B-7A0D-491B-8263-D53B64B067A3}']
    function getStateKey: Integer; cdecl;
  end;
  TJAppStateManager_StateDeletedResult = class(TJavaGenericImport<JAppStateManager_StateDeletedResultClass, JAppStateManager_StateDeletedResult>) end;

  JAppStateManager_StateListResultClass = interface(Japi_ResultClass)
    ['{E1900EA9-62E7-4058-9EB9-5897DA95B275}']
  end;

  [JavaSignature('com/google/android/gms/appstate/AppStateManager$StateListResult')]
  JAppStateManager_StateListResult = interface(Japi_Result)
    ['{C624F404-3365-4952-A350-D0B49E538B3D}']
    function getStateBuffer: JAppStateBuffer; cdecl;
  end;
  TJAppStateManager_StateListResult = class(TJavaGenericImport<JAppStateManager_StateListResultClass, JAppStateManager_StateListResult>) end;

  JAppStateManager_StateLoadedResultClass = interface(JReleasableClass)
    ['{50AAE37D-726C-424B-93DA-C2DDE026F808}']
  end;

  [JavaSignature('com/google/android/gms/appstate/AppStateManager$StateLoadedResult')]
  JAppStateManager_StateLoadedResult = interface(JReleasable)
    ['{05350D68-3B57-420F-999F-7425697245B6}']
    function getLocalData: TJavaArray<Byte>; cdecl;
    function getStateKey: Integer; cdecl;
  end;
  TJAppStateManager_StateLoadedResult = class(TJavaGenericImport<JAppStateManager_StateLoadedResultClass, JAppStateManager_StateLoadedResult>) end;

  JAppStateManager_StateResultClass = interface(JReleasableClass)
    ['{2227736D-B90C-4397-BAD7-06EDFB2E1F82}']
  end;

  [JavaSignature('com/google/android/gms/appstate/AppStateManager$StateResult')]
  JAppStateManager_StateResult = interface(JReleasable)
    ['{A6A3EB30-919F-4D9D-AF7B-5F0A889890DB}']
    function getConflictResult: JAppStateManager_StateConflictResult; cdecl;
    function getLoadedResult: JAppStateManager_StateLoadedResult; cdecl;
  end;
  TJAppStateManager_StateResult = class(TJavaGenericImport<JAppStateManager_StateResultClass, JAppStateManager_StateResult>) end;

  JAppStateStatusCodesClass = interface(JObjectClass)
    ['{AE94F94B-73F7-4DFC-B89C-0B4D585B35BD}']
    {class} function _GetSTATUS_CLIENT_RECONNECT_REQUIRED: Integer; cdecl;
    {class} function _GetSTATUS_DEVELOPER_ERROR: Integer; cdecl;
    {class} function _GetSTATUS_INTERNAL_ERROR: Integer; cdecl;
    {class} function _GetSTATUS_INTERRUPTED: Integer; cdecl;
    {class} function _GetSTATUS_NETWORK_ERROR_NO_DATA: Integer; cdecl;
    {class} function _GetSTATUS_NETWORK_ERROR_OPERATION_DEFERRED: Integer; cdecl;
    {class} function _GetSTATUS_NETWORK_ERROR_OPERATION_FAILED: Integer; cdecl;
    {class} function _GetSTATUS_NETWORK_ERROR_STALE_DATA: Integer; cdecl;
    {class} function _GetSTATUS_OK: Integer; cdecl;
    {class} function _GetSTATUS_STATE_KEY_LIMIT_EXCEEDED: Integer; cdecl;
    {class} function _GetSTATUS_STATE_KEY_NOT_FOUND: Integer; cdecl;
    {class} function _GetSTATUS_TIMEOUT: Integer; cdecl;
    {class} function _GetSTATUS_WRITE_OUT_OF_DATE_VERSION: Integer; cdecl;
    {class} function _GetSTATUS_WRITE_SIZE_EXCEEDED: Integer; cdecl;
    {class} property STATUS_CLIENT_RECONNECT_REQUIRED: Integer read _GetSTATUS_CLIENT_RECONNECT_REQUIRED;
    {class} property STATUS_DEVELOPER_ERROR: Integer read _GetSTATUS_DEVELOPER_ERROR;
    {class} property STATUS_INTERNAL_ERROR: Integer read _GetSTATUS_INTERNAL_ERROR;
    {class} property STATUS_INTERRUPTED: Integer read _GetSTATUS_INTERRUPTED;
    {class} property STATUS_NETWORK_ERROR_NO_DATA: Integer read _GetSTATUS_NETWORK_ERROR_NO_DATA;
    {class} property STATUS_NETWORK_ERROR_OPERATION_DEFERRED: Integer read _GetSTATUS_NETWORK_ERROR_OPERATION_DEFERRED;
    {class} property STATUS_NETWORK_ERROR_OPERATION_FAILED: Integer read _GetSTATUS_NETWORK_ERROR_OPERATION_FAILED;
    {class} property STATUS_NETWORK_ERROR_STALE_DATA: Integer read _GetSTATUS_NETWORK_ERROR_STALE_DATA;
    {class} property STATUS_OK: Integer read _GetSTATUS_OK;
    {class} property STATUS_STATE_KEY_LIMIT_EXCEEDED: Integer read _GetSTATUS_STATE_KEY_LIMIT_EXCEEDED;
    {class} property STATUS_STATE_KEY_NOT_FOUND: Integer read _GetSTATUS_STATE_KEY_NOT_FOUND;
    {class} property STATUS_TIMEOUT: Integer read _GetSTATUS_TIMEOUT;
    {class} property STATUS_WRITE_OUT_OF_DATE_VERSION: Integer read _GetSTATUS_WRITE_OUT_OF_DATE_VERSION;
    {class} property STATUS_WRITE_SIZE_EXCEEDED: Integer read _GetSTATUS_WRITE_SIZE_EXCEEDED;
  end;

  [JavaSignature('com/google/android/gms/appstate/AppStateStatusCodes')]
  JAppStateStatusCodes = interface(JObject)
    ['{E554DD0C-0206-45A1-B47D-BFCD9E0EE1C4}']
  end;
  TJAppStateStatusCodes = class(TJavaGenericImport<JAppStateStatusCodesClass, JAppStateStatusCodes>) end;

  JGoogleAuthExceptionClass = interface(JExceptionClass)
    ['{24885575-796B-42F6-AAB7-585DEF967D34}']
    {class} function init(err: JString): JGoogleAuthException; cdecl;
  end;

  [JavaSignature('com/google/android/gms/auth/GoogleAuthException')]
  JGoogleAuthException = interface(JException)
    ['{CD1926C5-141D-497D-87E4-E7D7D978506B}']
  end;
  TJGoogleAuthException = class(TJavaGenericImport<JGoogleAuthExceptionClass, JGoogleAuthException>) end;

  JGoogleAuthUtilClass = interface(JObjectClass)
    ['{3EB073E2-78BC-422D-85BE-E79CE3D7F1A1}']
    {class} function _GetGOOGLE_ACCOUNT_TYPE: JString; cdecl;
    {class} function _GetKEY_ANDROID_PACKAGE_NAME: JString; cdecl;
    {class} function _GetKEY_CALLER_UID: JString; cdecl;
    {class} function _GetKEY_REQUEST_ACTIONS: JString; cdecl;
    {class} function _GetKEY_REQUEST_VISIBLE_ACTIVITIES: JString; cdecl;
    {class} function _GetKEY_SUPPRESS_PROGRESS_SCREEN: JString; cdecl;
    {class} procedure clearToken(context: JContext; token: JString); cdecl;
    {class} function getToken(context: JContext; accountName: JString; scope: JString): JString; cdecl; overload;
    {class} function getToken(context: JContext; accountName: JString; scope: JString; extras: JBundle): JString; cdecl; overload;
    {class} function getTokenWithNotification(context: JContext; accountName: JString; scope: JString; extras: JBundle): JString; cdecl; overload;
    {class} function getTokenWithNotification(context: JContext; accountName: JString; scope: JString; extras: JBundle; callback: JIntent): JString; cdecl; overload;
    {class} function getTokenWithNotification(context: JContext; accountName: JString; scope: JString; extras: JBundle; authority: JString; syncBundle: JBundle): JString; cdecl; overload;
    {class} procedure invalidateToken(context: JContext; token: JString); cdecl;
    {class} property GOOGLE_ACCOUNT_TYPE: JString read _GetGOOGLE_ACCOUNT_TYPE;
    {class} property KEY_ANDROID_PACKAGE_NAME: JString read _GetKEY_ANDROID_PACKAGE_NAME;
    {class} property KEY_CALLER_UID: JString read _GetKEY_CALLER_UID;
    {class} property KEY_REQUEST_ACTIONS: JString read _GetKEY_REQUEST_ACTIONS;
    {class} property KEY_REQUEST_VISIBLE_ACTIVITIES: JString read _GetKEY_REQUEST_VISIBLE_ACTIVITIES;
    {class} property KEY_SUPPRESS_PROGRESS_SCREEN: JString read _GetKEY_SUPPRESS_PROGRESS_SCREEN;
  end;

  [JavaSignature('com/google/android/gms/auth/GoogleAuthUtil')]
  JGoogleAuthUtil = interface(JObject)
    ['{B40125B3-21B6-4B54-893E-DAE1257A7986}']
  end;
  TJGoogleAuthUtil = class(TJavaGenericImport<JGoogleAuthUtilClass, JGoogleAuthUtil>) end;

  JUserRecoverableAuthExceptionClass = interface(JGoogleAuthExceptionClass)
    ['{B0EB85A3-956F-4683-96D6-6DE6F6269EC8}']
    {class} function init(msg: JString; intent: JIntent): JUserRecoverableAuthException; cdecl;
  end;

  [JavaSignature('com/google/android/gms/auth/UserRecoverableAuthException')]
  JUserRecoverableAuthException = interface(JGoogleAuthException)
    ['{078C9325-3395-4A9E-A68B-06CC6812B83E}']
    function getIntent: JIntent; cdecl;
  end;
  TJUserRecoverableAuthException = class(TJavaGenericImport<JUserRecoverableAuthExceptionClass, JUserRecoverableAuthException>) end;

  JGooglePlayServicesAvailabilityExceptionClass = interface(JUserRecoverableAuthExceptionClass)
    ['{A620FBE5-CFF1-4458-9E30-C51FD3900597}']
  end;

  [JavaSignature('com/google/android/gms/auth/GooglePlayServicesAvailabilityException')]
  JGooglePlayServicesAvailabilityException = interface(JUserRecoverableAuthException)
    ['{46FF4385-2E1E-4195-9018-ED62D4985AB5}']
    function getConnectionStatusCode: Integer; cdecl;
  end;
  TJGooglePlayServicesAvailabilityException = class(TJavaGenericImport<JGooglePlayServicesAvailabilityExceptionClass, JGooglePlayServicesAvailabilityException>) end;

  JUserRecoverableNotifiedExceptionClass = interface(JGoogleAuthExceptionClass)
    ['{039B6304-A9DB-4C6D-AA9A-DC21D7FA51D7}']
    {class} function init(err: JString): JUserRecoverableNotifiedException; cdecl;
  end;

  [JavaSignature('com/google/android/gms/auth/UserRecoverableNotifiedException')]
  JUserRecoverableNotifiedException = interface(JGoogleAuthException)
    ['{65AC8DD0-EEDF-41FE-86E0-459D38C0A468}']
  end;
  TJUserRecoverableNotifiedException = class(TJavaGenericImport<JUserRecoverableNotifiedExceptionClass, JUserRecoverableNotifiedException>) end;

  JApplicationMetadataClass = interface(JObjectClass)
    ['{6E7C58D6-63F2-4689-91A3-E2FAC7573F27}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/cast/ApplicationMetadata')]
  JApplicationMetadata = interface(JObject)
    ['{0664D21F-4983-490D-8DDB-D17A9D9BE8F5}']
    function areNamespacesSupported(namespaces: JList): Boolean; cdecl;
    function cR: Jnet_Uri; cdecl;
    function describeContents: Integer; cdecl;
    function getApplicationId: JString; cdecl;
    function getImages: JList; cdecl;
    function getName: JString; cdecl;
    function getSenderAppIdentifier: JString; cdecl;
    function isNamespaceSupported(namespace: JString): Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJApplicationMetadata = class(TJavaGenericImport<JApplicationMetadataClass, JApplicationMetadata>) end;

  JCastClass = interface(JObjectClass)
    ['{AED9839B-2909-46C1-9D4A-D2C1D96AF572}']
    {class} //function _GetAPI: JApi; cdecl;
    {class} function _GetCastApi: JCast_CastApi; cdecl;
    {class} function _GetEXTRA_APP_NO_LONGER_RUNNING: JString; cdecl;
    {class} function _GetMAX_MESSAGE_LENGTH: Integer; cdecl;
    {class} function _GetMAX_NAMESPACE_LENGTH: Integer; cdecl;
    {class} //property API: JApi read _GetAPI;
    {class} property CastApi: JCast_CastApi read _GetCastApi;
    {class} property EXTRA_APP_NO_LONGER_RUNNING: JString read _GetEXTRA_APP_NO_LONGER_RUNNING;
    {class} property MAX_MESSAGE_LENGTH: Integer read _GetMAX_MESSAGE_LENGTH;
    {class} property MAX_NAMESPACE_LENGTH: Integer read _GetMAX_NAMESPACE_LENGTH;
  end;

  [JavaSignature('com/google/android/gms/cast/Cast')]
  JCast = interface(JObject)
    ['{B563B78D-D4F1-407E-807F-556B11AA8B93}']
  end;
  TJCast = class(TJavaGenericImport<JCastClass, JCast>) end;

  JCast_ApplicationConnectionResultClass = interface(Japi_ResultClass)
    ['{CBDBE9ED-C0F8-468E-A3AF-8370B351807A}']
  end;

  [JavaSignature('com/google/android/gms/cast/Cast$ApplicationConnectionResult')]
  JCast_ApplicationConnectionResult = interface(Japi_Result)
    ['{8E0A6E27-F4C4-485E-85EE-2579439ECC5B}']
    function getApplicationMetadata: JApplicationMetadata; cdecl;
    function getApplicationStatus: JString; cdecl;
    function getSessionId: JString; cdecl;
    function getWasLaunched: Boolean; cdecl;
  end;
  TJCast_ApplicationConnectionResult = class(TJavaGenericImport<JCast_ApplicationConnectionResultClass, JCast_ApplicationConnectionResult>) end;

  JCast_CastApiClass = interface(IJavaClass)
    ['{A90C5FA8-ABC7-48FA-B17C-DAEC6D2C6844}']
  end;

  [JavaSignature('com/google/android/gms/cast/Cast$CastApi')]
  JCast_CastApi = interface(IJavaInstance)
    ['{BE686162-7E46-41F7-A0AD-5ADC0A5DD599}']
    function getApplicationMetadata(P1: JGoogleApiClient): JApplicationMetadata; cdecl;
    function getApplicationStatus(P1: JGoogleApiClient): JString; cdecl;
    function getVolume(P1: JGoogleApiClient): Double; cdecl;
    function isMute(P1: JGoogleApiClient): Boolean; cdecl;
    function joinApplication(P1: JGoogleApiClient): JPendingResult; cdecl; overload;
    function joinApplication(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl; overload;
    function joinApplication(P1: JGoogleApiClient; P2: JString; P3: JString): JPendingResult; cdecl; overload;
    function launchApplication(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl; overload;
    function launchApplication(P1: JGoogleApiClient; P2: JString; P3: Boolean): JPendingResult; cdecl; overload;
    function leaveApplication(P1: JGoogleApiClient): JPendingResult; cdecl;
    procedure removeMessageReceivedCallbacks(P1: JGoogleApiClient; P2: JString); cdecl;
    procedure requestStatus(P1: JGoogleApiClient); cdecl;
    function sendMessage(P1: JGoogleApiClient; P2: JString; P3: JString): JPendingResult; cdecl;
    procedure setMessageReceivedCallbacks(P1: JGoogleApiClient; P2: JString; P3: JCast_MessageReceivedCallback); cdecl;
    procedure setMute(P1: JGoogleApiClient; P2: Boolean); cdecl;
    procedure setVolume(P1: JGoogleApiClient; P2: Double); cdecl;
    function stopApplication(P1: JGoogleApiClient): JPendingResult; cdecl; overload;
    function stopApplication(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl; overload;
  end;
  TJCast_CastApi = class(TJavaGenericImport<JCast_CastApiClass, JCast_CastApi>) end;

  JCast_CastOptionsClass = interface(JObjectClass)
    ['{B7A38F42-EBDD-4E2A-AD70-5D07EFDECC37}']
    {class} function builder(castDevice: JCastDevice; castListener: JCast_Listener): JCastOptions_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/cast/Cast$CastOptions')]
  JCast_CastOptions = interface(JObject)
    ['{B26B134E-DBD1-4B98-8445-C3CD491AC82E}']
  end;
  TJCast_CastOptions = class(TJavaGenericImport<JCast_CastOptionsClass, JCast_CastOptions>) end;

  JCastOptions_BuilderClass = interface(JObjectClass)
    ['{541C795A-4CD5-47A6-ADF3-AC34FD7EDE4A}']
  end;

  [JavaSignature('com/google/android/gms/cast/Cast$CastOptions$Builder')]
  JCastOptions_Builder = interface(JObject)
    ['{E665E5F1-D850-41A5-9656-772FC1C5E83F}']
    function build: JCast_CastOptions; cdecl;
    function setVerboseLoggingEnabled(enabled: Boolean): JCastOptions_Builder; cdecl;
  end;
  TJCastOptions_Builder = class(TJavaGenericImport<JCastOptions_BuilderClass, JCastOptions_Builder>) end;

  JCast_ListenerClass = interface(JObjectClass)
    ['{440CFD20-1BC8-4E18-BF40-F4E03CAFF604}']
    {class} function init: JCast_Listener; cdecl;
  end;

  [JavaSignature('com/google/android/gms/cast/Cast$Listener')]
  JCast_Listener = interface(JObject)
    ['{BA2193D0-0399-4C8A-824E-9EF6E1AB8332}']
    procedure onApplicationDisconnected(statusCode: Integer); cdecl;
    procedure onApplicationStatusChanged; cdecl;
    procedure onVolumeChanged; cdecl;
  end;
  TJCast_Listener = class(TJavaGenericImport<JCast_ListenerClass, JCast_Listener>) end;

  JCast_MessageReceivedCallbackClass = interface(IJavaClass)
    ['{7711C874-51FF-44CC-AB54-A6CA46578326}']
  end;

  [JavaSignature('com/google/android/gms/cast/Cast$MessageReceivedCallback')]
  JCast_MessageReceivedCallback = interface(IJavaInstance)
    ['{16EE604E-4328-4614-A44A-C5C5D160DBC5}']
    procedure onMessageReceived(P1: JCastDevice; P2: JString; P3: JString); cdecl;
  end;
  TJCast_MessageReceivedCallback = class(TJavaGenericImport<JCast_MessageReceivedCallbackClass, JCast_MessageReceivedCallback>) end;

  JCastDeviceClass = interface(JObjectClass)
    ['{5C124F97-0E2B-4E05-A963-BF78C3C6B269}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function getFromBundle(extras: JBundle): JCastDevice; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/cast/CastDevice')]
  JCastDevice = interface(JObject)
    ['{990D34D2-8B42-4E93-9AC3-0A2A08063620}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getDeviceId: JString; cdecl;
    function getDeviceVersion: JString; cdecl;
    function getFriendlyName: JString; cdecl;
    function getIcon(preferredWidth: Integer; preferredHeight: Integer): JWebImage; cdecl;
    function getIcons: JList; cdecl;
    function getIpAddress: JInet4Address; cdecl;
    function getModelName: JString; cdecl;
    function getServicePort: Integer; cdecl;
    function hasIcons: Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isSameDevice(castDevice: JCastDevice): Boolean; cdecl;
    procedure putInBundle(bundle: JBundle); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJCastDevice = class(TJavaGenericImport<JCastDeviceClass, JCastDevice>) end;

  JCastMediaControlIntentClass = interface(JObjectClass)
    ['{0AF86901-D449-434C-B945-D5504E32D63E}']
    {class} function _GetACTION_SYNC_STATUS: JString; cdecl;
    {class} function _GetCATEGORY_CAST: JString; cdecl;
    {class} function _GetDEFAULT_MEDIA_RECEIVER_APPLICATION_ID: JString; cdecl;
    {class} function _GetERROR_CODE_REQUEST_FAILED: Integer; cdecl;
    {class} function _GetERROR_CODE_SESSION_START_FAILED: Integer; cdecl;
    {class} function _GetERROR_CODE_TEMPORARILY_DISCONNECTED: Integer; cdecl;
    {class} function _GetEXTRA_CAST_APPLICATION_ID: JString; cdecl;
    {class} function _GetEXTRA_CAST_RELAUNCH_APPLICATION: JString; cdecl;
    {class} function _GetEXTRA_CAST_STOP_APPLICATION_WHEN_SESSION_ENDS: JString; cdecl;
    {class} function _GetEXTRA_CUSTOM_DATA: JString; cdecl;
    {class} function _GetEXTRA_DEBUG_LOGGING_ENABLED: JString; cdecl;
    {class} function _GetEXTRA_ERROR_CODE: JString; cdecl;
    {class} function categoryForCast(applicationId: JString): JString; cdecl; overload;
    {class} function categoryForCast(namespaces: JCollection): JString; cdecl; overload;
    {class} function categoryForCast(applicationId: JString; namespaces: JCollection): JString; cdecl; overload;
    {class} function categoryForRemotePlayback: JString; cdecl; overload;
    {class} function categoryForRemotePlayback(applicationId: JString): JString; cdecl; overload;
    {class} property ACTION_SYNC_STATUS: JString read _GetACTION_SYNC_STATUS;
    {class} property CATEGORY_CAST: JString read _GetCATEGORY_CAST;
    {class} property DEFAULT_MEDIA_RECEIVER_APPLICATION_ID: JString read _GetDEFAULT_MEDIA_RECEIVER_APPLICATION_ID;
    {class} property ERROR_CODE_REQUEST_FAILED: Integer read _GetERROR_CODE_REQUEST_FAILED;
    {class} property ERROR_CODE_SESSION_START_FAILED: Integer read _GetERROR_CODE_SESSION_START_FAILED;
    {class} property ERROR_CODE_TEMPORARILY_DISCONNECTED: Integer read _GetERROR_CODE_TEMPORARILY_DISCONNECTED;
    {class} property EXTRA_CAST_APPLICATION_ID: JString read _GetEXTRA_CAST_APPLICATION_ID;
    {class} property EXTRA_CAST_RELAUNCH_APPLICATION: JString read _GetEXTRA_CAST_RELAUNCH_APPLICATION;
    {class} property EXTRA_CAST_STOP_APPLICATION_WHEN_SESSION_ENDS: JString read _GetEXTRA_CAST_STOP_APPLICATION_WHEN_SESSION_ENDS;
    {class} property EXTRA_CUSTOM_DATA: JString read _GetEXTRA_CUSTOM_DATA;
    {class} property EXTRA_DEBUG_LOGGING_ENABLED: JString read _GetEXTRA_DEBUG_LOGGING_ENABLED;
    {class} property EXTRA_ERROR_CODE: JString read _GetEXTRA_ERROR_CODE;
  end;

  [JavaSignature('com/google/android/gms/cast/CastMediaControlIntent')]
  JCastMediaControlIntent = interface(JObject)
    ['{AB265802-4D4F-4DC1-AC8F-E6F744523975}']
  end;
  TJCastMediaControlIntent = class(TJavaGenericImport<JCastMediaControlIntentClass, JCastMediaControlIntent>) end;

  JCastStatusCodesClass = interface(JObjectClass)
    ['{B9DBD5E3-7FF4-45D3-A2C0-67D3701D02F7}']
    {class} function _GetAPPLICATION_NOT_FOUND: Integer; cdecl;
    {class} function _GetAPPLICATION_NOT_RUNNING: Integer; cdecl;
    {class} function _GetAUTHENTICATION_FAILED: Integer; cdecl;
    {class} function _GetCANCELED: Integer; cdecl;
    {class} function _GetINTERNAL_ERROR: Integer; cdecl;
    {class} function _GetINTERRUPTED: Integer; cdecl;
    {class} function _GetINVALID_REQUEST: Integer; cdecl;
    {class} function _GetMESSAGE_SEND_BUFFER_TOO_FULL: Integer; cdecl;
    {class} function _GetMESSAGE_TOO_LARGE: Integer; cdecl;
    {class} function _GetNETWORK_ERROR: Integer; cdecl;
    {class} function _GetNOT_ALLOWED: Integer; cdecl;
    {class} function _GetSUCCESS: Integer; cdecl;
    {class} function _GetTIMEOUT: Integer; cdecl;
    {class} function _GetUNKNOWN_ERROR: Integer; cdecl;
    {class} property APPLICATION_NOT_FOUND: Integer read _GetAPPLICATION_NOT_FOUND;
    {class} property APPLICATION_NOT_RUNNING: Integer read _GetAPPLICATION_NOT_RUNNING;
    {class} property AUTHENTICATION_FAILED: Integer read _GetAUTHENTICATION_FAILED;
    {class} property CANCELED: Integer read _GetCANCELED;
    {class} property INTERNAL_ERROR: Integer read _GetINTERNAL_ERROR;
    {class} property INTERRUPTED: Integer read _GetINTERRUPTED;
    {class} property INVALID_REQUEST: Integer read _GetINVALID_REQUEST;
    {class} property MESSAGE_SEND_BUFFER_TOO_FULL: Integer read _GetMESSAGE_SEND_BUFFER_TOO_FULL;
    {class} property MESSAGE_TOO_LARGE: Integer read _GetMESSAGE_TOO_LARGE;
    {class} property NETWORK_ERROR: Integer read _GetNETWORK_ERROR;
    {class} property NOT_ALLOWED: Integer read _GetNOT_ALLOWED;
    {class} property SUCCESS: Integer read _GetSUCCESS;
    {class} property TIMEOUT: Integer read _GetTIMEOUT;
    {class} property UNKNOWN_ERROR: Integer read _GetUNKNOWN_ERROR;
  end;

  [JavaSignature('com/google/android/gms/cast/CastStatusCodes')]
  JCastStatusCodes = interface(JObject)
    ['{A2B1BAC2-BC25-4BDC-A3B3-46D0CC87A64F}']
  end;
  TJCastStatusCodes = class(TJavaGenericImport<JCastStatusCodesClass, JCastStatusCodes>) end;

  JMediaInfoClass = interface(JObjectClass)
    ['{4C5AF59B-5590-42AA-B036-147628231C70}']
    {class} function _GetSTREAM_TYPE_BUFFERED: Integer; cdecl;
    {class} function _GetSTREAM_TYPE_INVALID: Integer; cdecl;
    {class} function _GetSTREAM_TYPE_LIVE: Integer; cdecl;
    {class} function _GetSTREAM_TYPE_NONE: Integer; cdecl;
    {class} property STREAM_TYPE_BUFFERED: Integer read _GetSTREAM_TYPE_BUFFERED;
    {class} property STREAM_TYPE_INVALID: Integer read _GetSTREAM_TYPE_INVALID;
    {class} property STREAM_TYPE_LIVE: Integer read _GetSTREAM_TYPE_LIVE;
    {class} property STREAM_TYPE_NONE: Integer read _GetSTREAM_TYPE_NONE;
  end;

  [JavaSignature('com/google/android/gms/cast/MediaInfo')]
  JMediaInfo = interface(JObject)
    ['{25136F20-C7C0-4872-A2CD-68D451D1E862}']
    function cT: JJSONObject; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getContentId: JString; cdecl;
    function getContentType: JString; cdecl;
    function getCustomData: JJSONObject; cdecl;
    function getMetadata: JMediaMetadata; cdecl;
    function getStreamDuration: Int64; cdecl;
    function getStreamType: Integer; cdecl;
    function hashCode: Integer; cdecl;
  end;
  TJMediaInfo = class(TJavaGenericImport<JMediaInfoClass, JMediaInfo>) end;

  JMediaInfo_BuilderClass = interface(JObjectClass)
    ['{079C1A24-F256-47EC-88AE-0E27CF79C220}']
    {class} function init(contentId: JString): JMediaInfo_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/cast/MediaInfo$Builder')]
  JMediaInfo_Builder = interface(JObject)
    ['{AA043ED1-1216-4065-B542-683FAED2490D}']
    function build: JMediaInfo; cdecl;
    function setContentType(contentType: JString): JMediaInfo_Builder; cdecl;
    function setCustomData(customData: JJSONObject): JMediaInfo_Builder; cdecl;
    function setMetadata(metadata: JMediaMetadata): JMediaInfo_Builder; cdecl;
    function setStreamDuration(duration: Int64): JMediaInfo_Builder; cdecl;
    function setStreamType(streamType: Integer): JMediaInfo_Builder; cdecl;
  end;
  TJMediaInfo_Builder = class(TJavaGenericImport<JMediaInfo_BuilderClass, JMediaInfo_Builder>) end;

  JMediaMetadataClass = interface(JObjectClass)
    ['{51F15DFD-1B91-43AD-B028-57DFF7CBB5E9}']
    {class} function _GetKEY_ALBUM_ARTIST: JString; cdecl;
    {class} function _GetKEY_ALBUM_TITLE: JString; cdecl;
    {class} function _GetKEY_ARTIST: JString; cdecl;
    {class} function _GetKEY_BROADCAST_DATE: JString; cdecl;
    {class} function _GetKEY_COMPOSER: JString; cdecl;
    {class} function _GetKEY_CREATION_DATE: JString; cdecl;
    {class} function _GetKEY_DISC_NUMBER: JString; cdecl;
    {class} function _GetKEY_EPISODE_NUMBER: JString; cdecl;
    {class} function _GetKEY_HEIGHT: JString; cdecl;
    {class} function _GetKEY_LOCATION_LATITUDE: JString; cdecl;
    {class} function _GetKEY_LOCATION_LONGITUDE: JString; cdecl;
    {class} function _GetKEY_LOCATION_NAME: JString; cdecl;
    {class} function _GetKEY_RELEASE_DATE: JString; cdecl;
    {class} function _GetKEY_SEASON_NUMBER: JString; cdecl;
    {class} function _GetKEY_SERIES_TITLE: JString; cdecl;
    {class} function _GetKEY_STUDIO: JString; cdecl;
    {class} function _GetKEY_SUBTITLE: JString; cdecl;
    {class} function _GetKEY_TITLE: JString; cdecl;
    {class} function _GetKEY_TRACK_NUMBER: JString; cdecl;
    {class} function _GetKEY_WIDTH: JString; cdecl;
    {class} function _GetMEDIA_TYPE_GENERIC: Integer; cdecl;
    {class} function _GetMEDIA_TYPE_MOVIE: Integer; cdecl;
    {class} function _GetMEDIA_TYPE_MUSIC_TRACK: Integer; cdecl;
    {class} function _GetMEDIA_TYPE_PHOTO: Integer; cdecl;
    {class} function _GetMEDIA_TYPE_TV_SHOW: Integer; cdecl;
    {class} function _GetMEDIA_TYPE_USER: Integer; cdecl;
    {class} function init: JMediaMetadata; cdecl; overload;
    {class} function init(mediaType: Integer): JMediaMetadata; cdecl; overload;
    {class} property KEY_ALBUM_ARTIST: JString read _GetKEY_ALBUM_ARTIST;
    {class} property KEY_ALBUM_TITLE: JString read _GetKEY_ALBUM_TITLE;
    {class} property KEY_ARTIST: JString read _GetKEY_ARTIST;
    {class} property KEY_BROADCAST_DATE: JString read _GetKEY_BROADCAST_DATE;
    {class} property KEY_COMPOSER: JString read _GetKEY_COMPOSER;
    {class} property KEY_CREATION_DATE: JString read _GetKEY_CREATION_DATE;
    {class} property KEY_DISC_NUMBER: JString read _GetKEY_DISC_NUMBER;
    {class} property KEY_EPISODE_NUMBER: JString read _GetKEY_EPISODE_NUMBER;
    {class} property KEY_HEIGHT: JString read _GetKEY_HEIGHT;
    {class} property KEY_LOCATION_LATITUDE: JString read _GetKEY_LOCATION_LATITUDE;
    {class} property KEY_LOCATION_LONGITUDE: JString read _GetKEY_LOCATION_LONGITUDE;
    {class} property KEY_LOCATION_NAME: JString read _GetKEY_LOCATION_NAME;
    {class} property KEY_RELEASE_DATE: JString read _GetKEY_RELEASE_DATE;
    {class} property KEY_SEASON_NUMBER: JString read _GetKEY_SEASON_NUMBER;
    {class} property KEY_SERIES_TITLE: JString read _GetKEY_SERIES_TITLE;
    {class} property KEY_STUDIO: JString read _GetKEY_STUDIO;
    {class} property KEY_SUBTITLE: JString read _GetKEY_SUBTITLE;
    {class} property KEY_TITLE: JString read _GetKEY_TITLE;
    {class} property KEY_TRACK_NUMBER: JString read _GetKEY_TRACK_NUMBER;
    {class} property KEY_WIDTH: JString read _GetKEY_WIDTH;
    {class} property MEDIA_TYPE_GENERIC: Integer read _GetMEDIA_TYPE_GENERIC;
    {class} property MEDIA_TYPE_MOVIE: Integer read _GetMEDIA_TYPE_MOVIE;
    {class} property MEDIA_TYPE_MUSIC_TRACK: Integer read _GetMEDIA_TYPE_MUSIC_TRACK;
    {class} property MEDIA_TYPE_PHOTO: Integer read _GetMEDIA_TYPE_PHOTO;
    {class} property MEDIA_TYPE_TV_SHOW: Integer read _GetMEDIA_TYPE_TV_SHOW;
    {class} property MEDIA_TYPE_USER: Integer read _GetMEDIA_TYPE_USER;
  end;

  [JavaSignature('com/google/android/gms/cast/MediaMetadata')]
  JMediaMetadata = interface(JObject)
    ['{92FBCB86-A796-4BA0-AB2A-0ED83FD06AA3}']
    procedure addImage(image: JWebImage); cdecl;
    procedure b(P1: JJSONObject); cdecl;
    function cT: JJSONObject; cdecl;
    procedure clear; cdecl;
    procedure clearImages; cdecl;
    function containsKey(key: JString): Boolean; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getDate(key: JString): JCalendar; cdecl;
    function getDateAsString(key: JString): JString; cdecl;
    function getDouble(key: JString): Double; cdecl;
    function getImages: JList; cdecl;
    function getInt(key: JString): Integer; cdecl;
    function getMediaType: Integer; cdecl;
    function getString(key: JString): JString; cdecl;
    function hasImages: Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function keySet: JSet; cdecl;
    procedure putDate(key: JString; value: JCalendar); cdecl;
    procedure putDouble(key: JString; value: Double); cdecl;
    procedure putInt(key: JString; value: Integer); cdecl;
    procedure putString(key: JString; value: JString); cdecl;
  end;
  TJMediaMetadata = class(TJavaGenericImport<JMediaMetadataClass, JMediaMetadata>) end;

  JMediaMetadata_aClass = interface(JObjectClass)
    ['{7074DE1A-30F3-4342-98E6-3E7ED4B450C5}']
    {class} function init: JMediaMetadata_a; cdecl;
  end;

  [JavaSignature('com/google/android/gms/cast/MediaMetadata$a')]
  JMediaMetadata_a = interface(JObject)
    ['{1E212906-E742-4837-A7FC-8FA036ABF98A}']
    function M(P1: JString): JString; cdecl;
    function N(P1: JString): JString; cdecl;
    function O(P1: JString): Integer; cdecl;
    function a(P1: JString; P2: JString; P3: Integer): JMediaMetadata_a; cdecl;
  end;
  TJMediaMetadata_a = class(TJavaGenericImport<JMediaMetadata_aClass, JMediaMetadata_a>) end;

  JMediaStatusClass = interface(JObjectClass)
    ['{EEF9568F-8668-4744-9288-199E8AE4C2FD}']
    {class} function _GetCOMMAND_PAUSE: Int64; cdecl;
    {class} function _GetCOMMAND_SEEK: Int64; cdecl;
    {class} function _GetCOMMAND_SET_VOLUME: Int64; cdecl;
    {class} function _GetCOMMAND_SKIP_BACKWARD: Int64; cdecl;
    {class} function _GetCOMMAND_SKIP_FORWARD: Int64; cdecl;
    {class} function _GetCOMMAND_TOGGLE_MUTE: Int64; cdecl;
    {class} function _GetIDLE_REASON_CANCELED: Integer; cdecl;
    {class} function _GetIDLE_REASON_ERROR: Integer; cdecl;
    {class} function _GetIDLE_REASON_FINISHED: Integer; cdecl;
    {class} function _GetIDLE_REASON_INTERRUPTED: Integer; cdecl;
    {class} function _GetIDLE_REASON_NONE: Integer; cdecl;
    {class} function _GetPLAYER_STATE_BUFFERING: Integer; cdecl;
    {class} function _GetPLAYER_STATE_IDLE: Integer; cdecl;
    {class} function _GetPLAYER_STATE_PAUSED: Integer; cdecl;
    {class} function _GetPLAYER_STATE_PLAYING: Integer; cdecl;
    {class} function _GetPLAYER_STATE_UNKNOWN: Integer; cdecl;
    {class} function init(json: JJSONObject): JMediaStatus; cdecl;
    {class} property COMMAND_PAUSE: Int64 read _GetCOMMAND_PAUSE;
    {class} property COMMAND_SEEK: Int64 read _GetCOMMAND_SEEK;
    {class} property COMMAND_SET_VOLUME: Int64 read _GetCOMMAND_SET_VOLUME;
    {class} property COMMAND_SKIP_BACKWARD: Int64 read _GetCOMMAND_SKIP_BACKWARD;
    {class} property COMMAND_SKIP_FORWARD: Int64 read _GetCOMMAND_SKIP_FORWARD;
    {class} property COMMAND_TOGGLE_MUTE: Int64 read _GetCOMMAND_TOGGLE_MUTE;
    {class} property IDLE_REASON_CANCELED: Integer read _GetIDLE_REASON_CANCELED;
    {class} property IDLE_REASON_ERROR: Integer read _GetIDLE_REASON_ERROR;
    {class} property IDLE_REASON_FINISHED: Integer read _GetIDLE_REASON_FINISHED;
    {class} property IDLE_REASON_INTERRUPTED: Integer read _GetIDLE_REASON_INTERRUPTED;
    {class} property IDLE_REASON_NONE: Integer read _GetIDLE_REASON_NONE;
    {class} property PLAYER_STATE_BUFFERING: Integer read _GetPLAYER_STATE_BUFFERING;
    {class} property PLAYER_STATE_IDLE: Integer read _GetPLAYER_STATE_IDLE;
    {class} property PLAYER_STATE_PAUSED: Integer read _GetPLAYER_STATE_PAUSED;
    {class} property PLAYER_STATE_PLAYING: Integer read _GetPLAYER_STATE_PLAYING;
    {class} property PLAYER_STATE_UNKNOWN: Integer read _GetPLAYER_STATE_UNKNOWN;
  end;

  [JavaSignature('com/google/android/gms/cast/MediaStatus')]
  JMediaStatus = interface(JObject)
    ['{FBC913B4-7CB0-4540-9791-DFF88D16F092}']
    function a(P1: JJSONObject; P2: Integer): Integer; cdecl;
    function cU: Int64; cdecl;
    function getCustomData: JJSONObject; cdecl;
    function getIdleReason: Integer; cdecl;
    function getMediaInfo: JMediaInfo; cdecl;
    function getPlaybackRate: Double; cdecl;
    function getPlayerState: Integer; cdecl;
    function getStreamPosition: Int64; cdecl;
    function getStreamVolume: Double; cdecl;
    function isMediaCommandSupported(mediaCommand: Int64): Boolean; cdecl;
    function isMute: Boolean; cdecl;
  end;
  TJMediaStatus = class(TJavaGenericImport<JMediaStatusClass, JMediaStatus>) end;

  JRemoteMediaPlayerClass = interface(JObjectClass)
    ['{978A076F-412D-4AFD-9437-C738014F4FA4}']
    {class} function _GetRESUME_STATE_PAUSE: Integer; cdecl;
    {class} function _GetRESUME_STATE_PLAY: Integer; cdecl;
    {class} function _GetRESUME_STATE_UNCHANGED: Integer; cdecl;
    {class} function _GetSTATUS_CANCELED: Integer; cdecl;
    {class} function _GetSTATUS_FAILED: Integer; cdecl;
    {class} function _GetSTATUS_REPLACED: Integer; cdecl;
    {class} function _GetSTATUS_SUCCEEDED: Integer; cdecl;
    {class} function _GetSTATUS_TIMED_OUT: Integer; cdecl;
    {class} function init: JRemoteMediaPlayer; cdecl;
    {class} property RESUME_STATE_PAUSE: Integer read _GetRESUME_STATE_PAUSE;
    {class} property RESUME_STATE_PLAY: Integer read _GetRESUME_STATE_PLAY;
    {class} property RESUME_STATE_UNCHANGED: Integer read _GetRESUME_STATE_UNCHANGED;
    {class} property STATUS_CANCELED: Integer read _GetSTATUS_CANCELED;
    {class} property STATUS_FAILED: Integer read _GetSTATUS_FAILED;
    {class} property STATUS_REPLACED: Integer read _GetSTATUS_REPLACED;
    {class} property STATUS_SUCCEEDED: Integer read _GetSTATUS_SUCCEEDED;
    {class} property STATUS_TIMED_OUT: Integer read _GetSTATUS_TIMED_OUT;
  end;

  [JavaSignature('com/google/android/gms/cast/RemoteMediaPlayer')]
  JRemoteMediaPlayer = interface(JObject)
    ['{2A1A9AC4-0B19-4608-81C6-54605C71589C}']
    function getApproximateStreamPosition: Int64; cdecl;
    function getMediaInfo: JMediaInfo; cdecl;
    function getMediaStatus: JMediaStatus; cdecl;
    function getNamespace: JString; cdecl;
    function getStreamDuration: Int64; cdecl;
    function load(apiClient: JGoogleApiClient; mediaInfo: JMediaInfo): JPendingResult; cdecl; overload;
    function load(apiClient: JGoogleApiClient; mediaInfo: JMediaInfo; autoplay: Boolean): JPendingResult; cdecl; overload;
    function load(apiClient: JGoogleApiClient; mediaInfo: JMediaInfo; autoplay: Boolean; playPosition: Int64): JPendingResult; cdecl; overload;
    function load(apiClient: JGoogleApiClient; mediaInfo: JMediaInfo; autoplay: Boolean; playPosition: Int64; customData: JJSONObject): JPendingResult; cdecl; overload;
    procedure onMessageReceived(castDevice: JCastDevice; namespace: JString; message: JString); cdecl;
    function pause(apiClient: JGoogleApiClient): JPendingResult; cdecl; overload;
    function pause(apiClient: JGoogleApiClient; customData: JJSONObject): JPendingResult; cdecl; overload;
    function play(apiClient: JGoogleApiClient): JPendingResult; cdecl; overload;
    function play(apiClient: JGoogleApiClient; customData: JJSONObject): JPendingResult; cdecl; overload;
    function requestStatus(apiClient: JGoogleApiClient): JPendingResult; cdecl;
    function seek(apiClient: JGoogleApiClient; position: Int64): JPendingResult; cdecl; overload;
    function seek(apiClient: JGoogleApiClient; position: Int64; resumeState: Integer): JPendingResult; cdecl; overload;
    function seek(apiClient: JGoogleApiClient; position: Int64; resumeState: Integer; customData: JJSONObject): JPendingResult; cdecl; overload;
    procedure setOnMetadataUpdatedListener(listener: JRemoteMediaPlayer_OnMetadataUpdatedListener); cdecl;
    procedure setOnStatusUpdatedListener(listener: JRemoteMediaPlayer_OnStatusUpdatedListener); cdecl;
    function setStreamMute(apiClient: JGoogleApiClient; muteState: Boolean): JPendingResult; cdecl; overload;
    function setStreamMute(apiClient: JGoogleApiClient; muteState: Boolean; customData: JJSONObject): JPendingResult; cdecl; overload;
    function setStreamVolume(apiClient: JGoogleApiClient; volume: Double): JPendingResult; cdecl; overload;
    function setStreamVolume(apiClient: JGoogleApiClient; volume: Double; customData: JJSONObject): JPendingResult; cdecl; overload;
    function stop(apiClient: JGoogleApiClient): JPendingResult; cdecl; overload;
    function stop(apiClient: JGoogleApiClient; customData: JJSONObject): JPendingResult; cdecl; overload;
  end;
  TJRemoteMediaPlayer = class(TJavaGenericImport<JRemoteMediaPlayerClass, JRemoteMediaPlayer>) end;

  JRemoteMediaPlayer_MediaChannelResultClass = interface(Japi_ResultClass)
    ['{E961CD75-C1FE-4D75-95F3-3408C266116F}']
  end;

  [JavaSignature('com/google/android/gms/cast/RemoteMediaPlayer$MediaChannelResult')]
  JRemoteMediaPlayer_MediaChannelResult = interface(Japi_Result)
    ['{57045A6A-10F1-49DD-B11E-A02C07E359B9}']
  end;
  TJRemoteMediaPlayer_MediaChannelResult = class(TJavaGenericImport<JRemoteMediaPlayer_MediaChannelResultClass, JRemoteMediaPlayer_MediaChannelResult>) end;

  JRemoteMediaPlayer_OnMetadataUpdatedListenerClass = interface(IJavaClass)
    ['{73F2FDC3-7B35-4E64-8E8B-313217221771}']
  end;

  [JavaSignature('com/google/android/gms/cast/RemoteMediaPlayer$OnMetadataUpdatedListener')]
  JRemoteMediaPlayer_OnMetadataUpdatedListener = interface(IJavaInstance)
    ['{FD43EA62-B953-4F95-99F7-D0180F1E14D0}']
    procedure onMetadataUpdated; cdecl;
  end;
  TJRemoteMediaPlayer_OnMetadataUpdatedListener = class(TJavaGenericImport<JRemoteMediaPlayer_OnMetadataUpdatedListenerClass, JRemoteMediaPlayer_OnMetadataUpdatedListener>) end;

  JRemoteMediaPlayer_OnStatusUpdatedListenerClass = interface(IJavaClass)
    ['{82854D22-E9C1-448D-BF05-70577D4A8CD5}']
  end;

  [JavaSignature('com/google/android/gms/cast/RemoteMediaPlayer$OnStatusUpdatedListener')]
  JRemoteMediaPlayer_OnStatusUpdatedListener = interface(IJavaInstance)
    ['{C1C290AE-2BFE-4887-A287-2F6A357ACA6E}']
    procedure onStatusUpdated; cdecl;
  end;
  TJRemoteMediaPlayer_OnStatusUpdatedListener = class(TJavaGenericImport<JRemoteMediaPlayer_OnStatusUpdatedListenerClass, JRemoteMediaPlayer_OnStatusUpdatedListener>) end;

  JAccountPickerClass = interface(JObjectClass)
    ['{911C15A8-C95E-451F-8179-C537DAEEF9D5}']
    {class} //function a(P1: JAccount; P2: JArrayList; P3: TJavaObjectArray<JString>; P4: Boolean; P5: JString; P6: JString; P7: TJavaObjectArray<JString>; P8: JBundle; P9: Boolean): JIntent; cdecl; overload;
    {class} //function a(P1: JAccount; P2: JArrayList; P3: TJavaObjectArray<JString>; P4: Boolean; P5: JString; P6: JString; P7: TJavaObjectArray<JString>; P8: JBundle; P9: Boolean; P10: Integer; P11: Integer): JIntent; cdecl; overload;
    {class} //function newChooseAccountIntent(selectedAccount: JAccount; allowableAccounts: JArrayList; allowableAccountTypes: TJavaObjectArray<JString>; alwaysPromptForAccount: Boolean; descriptionOverrideText: JString; addAccountAuthTokenType: JString; addAccountRequiredFeatures: TJavaObjectArray<JString>; addAccountOptions: JBundle): JIntent; cdecl;
  end;

  [JavaSignature('com/google/android/gms/common/AccountPicker')]
  JAccountPicker = interface(JObject)
    ['{B0B75FAA-A0D7-45C1-A0BC-FF63522ED979}']
  end;
  TJAccountPicker = class(TJavaGenericImport<JAccountPickerClass, JAccountPicker>) end;

  JConnectionResultClass = interface(JObjectClass)
    ['{4A2A7E79-F9D7-4636-A3CF-C291BEF18896}']
    {class} function _GetCANCELED: Integer; cdecl;
    {class} function _GetDATE_INVALID: Integer; cdecl;
    {class} function _GetDEVELOPER_ERROR: Integer; cdecl;
    {class} function _GetDRIVE_EXTERNAL_STORAGE_REQUIRED: Integer; cdecl;
    {class} function _GetINTERNAL_ERROR: Integer; cdecl;
    {class} function _GetINTERRUPTED: Integer; cdecl;
    {class} function _GetINVALID_ACCOUNT: Integer; cdecl;
    {class} function _GetLICENSE_CHECK_FAILED: Integer; cdecl;
    {class} function _GetNETWORK_ERROR: Integer; cdecl;
    {class} function _GetRESOLUTION_REQUIRED: Integer; cdecl;
    {class} function _GetSERVICE_DISABLED: Integer; cdecl;
    {class} function _GetSERVICE_INVALID: Integer; cdecl;
    {class} function _GetSERVICE_MISSING: Integer; cdecl;
    {class} function _GetSERVICE_VERSION_UPDATE_REQUIRED: Integer; cdecl;
    {class} function _GetSIGN_IN_REQUIRED: Integer; cdecl;
    {class} function _GetSUCCESS: Integer; cdecl;
    {class} function _GetTIMEOUT: Integer; cdecl;
    {class} function _GetyI: JConnectionResult; cdecl;
    {class} function init(statusCode: Integer; pendingIntent: JPendingIntent): JConnectionResult; cdecl;
    {class} property CANCELED: Integer read _GetCANCELED;
    {class} property DATE_INVALID: Integer read _GetDATE_INVALID;
    {class} property DEVELOPER_ERROR: Integer read _GetDEVELOPER_ERROR;
    {class} property DRIVE_EXTERNAL_STORAGE_REQUIRED: Integer read _GetDRIVE_EXTERNAL_STORAGE_REQUIRED;
    {class} property INTERNAL_ERROR: Integer read _GetINTERNAL_ERROR;
    {class} property INTERRUPTED: Integer read _GetINTERRUPTED;
    {class} property INVALID_ACCOUNT: Integer read _GetINVALID_ACCOUNT;
    {class} property LICENSE_CHECK_FAILED: Integer read _GetLICENSE_CHECK_FAILED;
    {class} property NETWORK_ERROR: Integer read _GetNETWORK_ERROR;
    {class} property RESOLUTION_REQUIRED: Integer read _GetRESOLUTION_REQUIRED;
    {class} property SERVICE_DISABLED: Integer read _GetSERVICE_DISABLED;
    {class} property SERVICE_INVALID: Integer read _GetSERVICE_INVALID;
    {class} property SERVICE_MISSING: Integer read _GetSERVICE_MISSING;
    {class} property SERVICE_VERSION_UPDATE_REQUIRED: Integer read _GetSERVICE_VERSION_UPDATE_REQUIRED;
    {class} property SIGN_IN_REQUIRED: Integer read _GetSIGN_IN_REQUIRED;
    {class} property SUCCESS: Integer read _GetSUCCESS;
    {class} property TIMEOUT: Integer read _GetTIMEOUT;
    {class} property yI: JConnectionResult read _GetyI;
  end;

  [JavaSignature('com/google/android/gms/common/ConnectionResult')]
  JConnectionResult = interface(JObject)
    ['{A6C69B94-8D31-4C7B-9001-1DDF4A76D784}']
    function getErrorCode: Integer; cdecl;
    function getResolution: JPendingIntent; cdecl;
    function hasResolution: Boolean; cdecl;
    function isSuccess: Boolean; cdecl;
    procedure startResolutionForResult(activity: JActivity; requestCode: Integer); cdecl;
    function toString: JString; cdecl;
  end;
  TJConnectionResult = class(TJavaGenericImport<JConnectionResultClass, JConnectionResult>) end;

  JErrorDialogFragmentClass = interface(JDialogFragmentClass)
    ['{7A49EA83-0965-4F8A-84CE-1754BEBB46E0}']
    {class} function init: JErrorDialogFragment; cdecl;
    {class} function newInstance(dialog: JDialog): JErrorDialogFragment; cdecl; overload;
    {class} function newInstance(dialog: JDialog; cancelListener: JDialogInterface_OnCancelListener): JErrorDialogFragment; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/common/ErrorDialogFragment')]
  JErrorDialogFragment = interface(JDialogFragment)
    ['{394601FA-16C0-460F-BB3F-210C6C6F6E5B}']
    procedure onCancel(dialog: JDialogInterface); cdecl;
    function onCreateDialog(savedInstanceState: JBundle): JDialog; cdecl;
    procedure show(manager: JFragmentManager; tag: JString); cdecl;
  end;
  TJErrorDialogFragment = class(TJavaGenericImport<JErrorDialogFragmentClass, JErrorDialogFragment>) end;

  JGooglePlayServicesClientClass = interface(IJavaClass)
    ['{9FF85676-EBAE-4D2E-913C-E8EF99D1A388}']
  end;

  [JavaSignature('com/google/android/gms/common/GooglePlayServicesClient')]
  JGooglePlayServicesClient = interface(IJavaInstance)
    ['{70AFC0B8-8BC6-4BEA-88E4-CE8DB7F8F3CB}']
    procedure connect; cdecl;
    procedure disconnect; cdecl;
    function isConnected: Boolean; cdecl;
    function isConnecting: Boolean; cdecl;
    function isConnectionCallbacksRegistered(P1: JGooglePlayServicesClient_ConnectionCallbacks): Boolean; cdecl;
    function isConnectionFailedListenerRegistered(P1: JGooglePlayServicesClient_OnConnectionFailedListener): Boolean; cdecl;
    procedure registerConnectionCallbacks(P1: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure registerConnectionFailedListener(P1: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
    procedure unregisterConnectionCallbacks(P1: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure unregisterConnectionFailedListener(P1: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
  end;
  TJGooglePlayServicesClient = class(TJavaGenericImport<JGooglePlayServicesClientClass, JGooglePlayServicesClient>) end;

  JGooglePlayServicesClient_ConnectionCallbacksClass = interface(IJavaClass)
    ['{2830C271-7F66-4DA7-AD93-026E416C3FCC}']
  end;

  [JavaSignature('com/google/android/gms/common/GooglePlayServicesClient$ConnectionCallbacks')]
  JGooglePlayServicesClient_ConnectionCallbacks = interface(IJavaInstance)
    ['{4FB49886-F762-4DB3-A74C-75B5AF669744}']
    procedure onConnected(P1: JBundle); cdecl;
    procedure onDisconnected; cdecl;
  end;
  TJGooglePlayServicesClient_ConnectionCallbacks = class(TJavaGenericImport<JGooglePlayServicesClient_ConnectionCallbacksClass, JGooglePlayServicesClient_ConnectionCallbacks>) end;

  JGooglePlayServicesClient_OnConnectionFailedListenerClass = interface(IJavaClass)
    ['{76F1132D-CE19-4A91-B88D-15CCD337CEA6}']
  end;

  [JavaSignature('com/google/android/gms/common/GooglePlayServicesClient$OnConnectionFailedListener')]
  JGooglePlayServicesClient_OnConnectionFailedListener = interface(IJavaInstance)
    ['{00602635-A990-45A8-AE1E-037B00F8AD9B}']
    procedure onConnectionFailed(P1: JConnectionResult); cdecl;
  end;
  TJGooglePlayServicesClient_OnConnectionFailedListener = class(TJavaGenericImport<JGooglePlayServicesClient_OnConnectionFailedListenerClass, JGooglePlayServicesClient_OnConnectionFailedListener>) end;

  JGooglePlayServicesNotAvailableExceptionClass = interface(JExceptionClass)
    ['{B8297902-69BD-468A-BDB6-9E45162CD60B}']
    {class} function init(errorCode: Integer): JGooglePlayServicesNotAvailableException; cdecl;
  end;

  [JavaSignature('com/google/android/gms/common/GooglePlayServicesNotAvailableException')]
  JGooglePlayServicesNotAvailableException = interface(JException)
    ['{9F44824B-11B1-42A6-B5B4-D0660A1EA463}']
    function _GeterrorCode: Integer; cdecl;
    property errorCode: Integer read _GeterrorCode;
  end;
  TJGooglePlayServicesNotAvailableException = class(TJavaGenericImport<JGooglePlayServicesNotAvailableExceptionClass, JGooglePlayServicesNotAvailableException>) end;

  JUserRecoverableExceptionClass = interface(JExceptionClass)
    ['{9024EA92-BA9C-420C-871B-482511E2E366}']
    {class} function init(msg: JString; intent: JIntent): JUserRecoverableException; cdecl;
  end;

  [JavaSignature('com/google/android/gms/common/UserRecoverableException')]
  JUserRecoverableException = interface(JException)
    ['{7F19F1E5-147E-4690-9C75-F2A7CFE1EAF3}']
    function getIntent: JIntent; cdecl;
  end;
  TJUserRecoverableException = class(TJavaGenericImport<JUserRecoverableExceptionClass, JUserRecoverableException>) end;

  JGooglePlayServicesRepairableExceptionClass = interface(JUserRecoverableExceptionClass)
    ['{18FFB97E-3936-4548-A7B6-0F2D20FF49D5}']
  end;

  [JavaSignature('com/google/android/gms/common/GooglePlayServicesRepairableException')]
  JGooglePlayServicesRepairableException = interface(JUserRecoverableException)
    ['{F6CD5C46-329C-424C-B011-DCB95AB209F9}']
    function getConnectionStatusCode: Integer; cdecl;
  end;
  TJGooglePlayServicesRepairableException = class(TJavaGenericImport<JGooglePlayServicesRepairableExceptionClass, JGooglePlayServicesRepairableException>) end;

  JGooglePlayServicesUtilClass = interface(JObjectClass)
    ['{DEE7FB7C-B1A2-4098-9E42-67A2CF856C16}']
    {class} function _GetGMS_ERROR_DIALOG: JString; cdecl;
    {class} function _GetGOOGLE_PLAY_SERVICES_PACKAGE: JString; cdecl;
    {class} function _GetGOOGLE_PLAY_SERVICES_VERSION_CODE: Integer; cdecl;
    {class} function _GetGOOGLE_PLAY_STORE_PACKAGE: JString; cdecl;
    {class} function _GetyS: Boolean; cdecl;
    {class} procedure _SetyS(Value: Boolean); cdecl;
    {class} function _GetyT: Boolean; cdecl;
    {class} procedure _SetyT(Value: Boolean); cdecl;
    {class} function a(P1: JResources): Boolean; cdecl; overload;
    {class} function a(P1: JContext; P2: Integer; P3: Integer): JIntent; cdecl; overload;
    {class} function a(P1: Integer; P2: JActivity; P3: Integer; P4: JDialogInterface_OnCancelListener; P5: Integer): JDialog; cdecl; overload;
    {class} function b(P1: JContext; P2: Integer): JString; cdecl; overload;
    {class} function b(P1: JContext; P2: Integer; P3: Integer): JString; cdecl; overload;
    {class} function &do: Boolean; cdecl;
    {class} function getErrorDialog(errorCode: Integer; activity: JActivity; requestCode: Integer): JDialog; cdecl; overload;
    {class} function getErrorDialog(errorCode: Integer; activity: JActivity; requestCode: Integer; cancelListener: JDialogInterface_OnCancelListener): JDialog; cdecl; overload;
    {class} function getErrorPendingIntent(errorCode: Integer; context: JContext; requestCode: Integer): JPendingIntent; cdecl;
    {class} function getErrorString(errorCode: Integer): JString; cdecl;
    {class} function getOpenSourceSoftwareLicenseInfo(context: JContext): JString; cdecl;
    {class} function getRemoteContext(context: JContext): JContext; cdecl;
    {class} function getRemoteResource(context: JContext): JResources; cdecl;
    {class} function isGooglePlayServicesAvailable(context: JContext): Integer; cdecl;
    {class} function isUserRecoverableError(errorCode: Integer): Boolean; cdecl;
    {class} procedure s(P1: JContext); cdecl;
    {class} function showErrorDialogFragment(errorCode: Integer; activity: JActivity; requestCode: Integer): Boolean; cdecl; overload;
    {class} function showErrorDialogFragment(errorCode: Integer; activity: JActivity; requestCode: Integer; cancelListener: JDialogInterface_OnCancelListener): Boolean; cdecl; overload;
    {class} property GMS_ERROR_DIALOG: JString read _GetGMS_ERROR_DIALOG;
    {class} property GOOGLE_PLAY_SERVICES_PACKAGE: JString read _GetGOOGLE_PLAY_SERVICES_PACKAGE;
    {class} property GOOGLE_PLAY_SERVICES_VERSION_CODE: Integer read _GetGOOGLE_PLAY_SERVICES_VERSION_CODE;
    {class} property GOOGLE_PLAY_STORE_PACKAGE: JString read _GetGOOGLE_PLAY_STORE_PACKAGE;
    {class} property yS: Boolean read _GetyS write _SetyS;
    {class} property yT: Boolean read _GetyT write _SetyT;
  end;

  [JavaSignature('com/google/android/gms/common/GooglePlayServicesUtil')]
  JGooglePlayServicesUtil = interface(JObject)
    ['{3549FA2E-E8D1-4F37-A21B-B5E10E6169D1}']
  end;
  TJGooglePlayServicesUtil = class(TJavaGenericImport<JGooglePlayServicesUtilClass, JGooglePlayServicesUtil>) end;

  JScopesClass = interface(JObjectClass)
    ['{1044C4C8-7758-4235-AECE-92D3CD0D433A}']
    {class} function _GetAPP_STATE: JString; cdecl;
    {class} function _GetDRIVE_APPFOLDER: JString; cdecl;
    {class} function _GetDRIVE_FILE: JString; cdecl;
    {class} function _GetDRIVE_FULL: JString; cdecl;
    {class} function _GetGAMES: JString; cdecl;
    {class} function _GetPLUS_LOGIN: JString; cdecl;
    {class} function _GetPLUS_ME: JString; cdecl;
    {class} function _GetPROFILE: JString; cdecl;
    {class} property APP_STATE: JString read _GetAPP_STATE;
    {class} property DRIVE_APPFOLDER: JString read _GetDRIVE_APPFOLDER;
    {class} property DRIVE_FILE: JString read _GetDRIVE_FILE;
    {class} property DRIVE_FULL: JString read _GetDRIVE_FULL;
    {class} property GAMES: JString read _GetGAMES;
    {class} property PLUS_LOGIN: JString read _GetPLUS_LOGIN;
    {class} property PLUS_ME: JString read _GetPLUS_ME;
    {class} property PROFILE: JString read _GetPROFILE;
  end;

  [JavaSignature('com/google/android/gms/common/Scopes')]
  JScopes = interface(JObject)
    ['{A9A538A4-79B6-4891-B22A-D5487A03C1CF}']
  end;
  TJScopes = class(TJavaGenericImport<JScopesClass, JScopes>) end;

  JSignInButtonClass = interface(JFrameLayoutClass)
    ['{E2871683-3AFF-4060-8EA2-30A5CA64273E}']
    {class} function _GetCOLOR_DARK: Integer; cdecl;
    {class} function _GetCOLOR_LIGHT: Integer; cdecl;
    {class} function _GetSIZE_ICON_ONLY: Integer; cdecl;
    {class} function _GetSIZE_STANDARD: Integer; cdecl;
    {class} function _GetSIZE_WIDE: Integer; cdecl;
    {class} function init(context: JContext): JSignInButton; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JSignInButton; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyle: Integer): JSignInButton; cdecl; overload;
    {class} property COLOR_DARK: Integer read _GetCOLOR_DARK;
    {class} property COLOR_LIGHT: Integer read _GetCOLOR_LIGHT;
    {class} property SIZE_ICON_ONLY: Integer read _GetSIZE_ICON_ONLY;
    {class} property SIZE_STANDARD: Integer read _GetSIZE_STANDARD;
    {class} property SIZE_WIDE: Integer read _GetSIZE_WIDE;
  end;

  [JavaSignature('com/google/android/gms/common/SignInButton')]
  JSignInButton = interface(JFrameLayout)
    ['{3E380F90-B958-4997-B949-C77CDACDB789}']
    procedure onClick(view: JView); cdecl;
    procedure setColorScheme(colorScheme: Integer); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setOnClickListener(listener: JView_OnClickListener); cdecl;
    procedure setSize(buttonSize: Integer); cdecl;
    procedure setStyle(buttonSize: Integer; colorScheme: Integer); cdecl;
  end;
  TJSignInButton = class(TJavaGenericImport<JSignInButtonClass, JSignInButton>) end;

  JKeepNameClass = interface(JAnnotationClass)
    ['{56B49840-75B9-441A-8A62-C9291B24D047}']
  end;

  [JavaSignature('com/google/android/gms/common/annotation/KeepName')]
  JKeepName = interface(JAnnotation)
    ['{F3981EBA-3434-44B7-95EF-1512D87F07E2}']
  end;
  TJKeepName = class(TJavaGenericImport<JKeepNameClass, JKeepName>) end;

  JCommonStatusCodesClass = interface(JObjectClass)
    ['{7E439158-D82B-4B03-9A23-6BBB88D90A29}']
    {class} function _GetDATE_INVALID: Integer; cdecl;
    {class} function _GetDEVELOPER_ERROR: Integer; cdecl;
    {class} function _GetERROR: Integer; cdecl;
    {class} function _GetINTERNAL_ERROR: Integer; cdecl;
    {class} function _GetINTERRUPTED: Integer; cdecl;
    {class} function _GetINVALID_ACCOUNT: Integer; cdecl;
    {class} function _GetLICENSE_CHECK_FAILED: Integer; cdecl;
    {class} function _GetNETWORK_ERROR: Integer; cdecl;
    {class} function _GetRESOLUTION_REQUIRED: Integer; cdecl;
    {class} function _GetSERVICE_DISABLED: Integer; cdecl;
    {class} function _GetSERVICE_INVALID: Integer; cdecl;
    {class} function _GetSERVICE_MISSING: Integer; cdecl;
    {class} function _GetSERVICE_VERSION_UPDATE_REQUIRED: Integer; cdecl;
    {class} function _GetSIGN_IN_REQUIRED: Integer; cdecl;
    {class} function _GetSUCCESS: Integer; cdecl;
    {class} function _GetSUCCESS_CACHE: Integer; cdecl;
    {class} function _GetTIMEOUT: Integer; cdecl;
    {class} function getStatusCodeString(statusCode: Integer): JString; cdecl;
    {class} function init: JCommonStatusCodes; cdecl;
    {class} property DATE_INVALID: Integer read _GetDATE_INVALID;
    {class} property DEVELOPER_ERROR: Integer read _GetDEVELOPER_ERROR;
    {class} property ERROR: Integer read _GetERROR;
    {class} property INTERNAL_ERROR: Integer read _GetINTERNAL_ERROR;
    {class} property INTERRUPTED: Integer read _GetINTERRUPTED;
    {class} property INVALID_ACCOUNT: Integer read _GetINVALID_ACCOUNT;
    {class} property LICENSE_CHECK_FAILED: Integer read _GetLICENSE_CHECK_FAILED;
    {class} property NETWORK_ERROR: Integer read _GetNETWORK_ERROR;
    {class} property RESOLUTION_REQUIRED: Integer read _GetRESOLUTION_REQUIRED;
    {class} property SERVICE_DISABLED: Integer read _GetSERVICE_DISABLED;
    {class} property SERVICE_INVALID: Integer read _GetSERVICE_INVALID;
    {class} property SERVICE_MISSING: Integer read _GetSERVICE_MISSING;
    {class} property SERVICE_VERSION_UPDATE_REQUIRED: Integer read _GetSERVICE_VERSION_UPDATE_REQUIRED;
    {class} property SIGN_IN_REQUIRED: Integer read _GetSIGN_IN_REQUIRED;
    {class} property SUCCESS: Integer read _GetSUCCESS;
    {class} property SUCCESS_CACHE: Integer read _GetSUCCESS_CACHE;
    {class} property TIMEOUT: Integer read _GetTIMEOUT;
  end;

  [JavaSignature('com/google/android/gms/common/api/CommonStatusCodes')]
  JCommonStatusCodes = interface(JObject)
    ['{BDB21EAA-F613-4B7F-A956-629E7F1F3CC9}']
  end;
  TJCommonStatusCodes = class(TJavaGenericImport<JCommonStatusCodesClass, JCommonStatusCodes>) end;

  JGoogleApiClientClass = interface(IJavaClass)
    ['{39FBEEC6-35DC-4004-8C87-A46FF41D4B0C}']
  end;

  [JavaSignature('com/google/android/gms/common/api/GoogleApiClient')]
  JGoogleApiClient = interface(IJavaInstance)
    ['{79A91917-155C-4C04-8E26-2C497F3CE53D}']
    //function a(P1: JApi_b): JApi_a; cdecl; overload;
    //function a(P1: Japi_a_a): Japi_a_a; cdecl; overload;
    //function b(P1: Japi_a_a): Japi_a_a; cdecl;
    function blockingConnect(P1: Int64; P2: JTimeUnit): JConnectionResult; cdecl;
    procedure connect; cdecl;
    procedure disconnect; cdecl;
    function isConnected: Boolean; cdecl;
    function isConnecting: Boolean; cdecl;
    function isConnectionCallbacksRegistered(P1: JGoogleApiClient_ConnectionCallbacks): Boolean; cdecl;
    function isConnectionFailedListenerRegistered(P1: JGoogleApiClient_OnConnectionFailedListener): Boolean; cdecl;
    procedure reconnect; cdecl;
    procedure registerConnectionCallbacks(P1: JGoogleApiClient_ConnectionCallbacks); cdecl;
    procedure registerConnectionFailedListener(P1: JGoogleApiClient_OnConnectionFailedListener); cdecl;
    procedure unregisterConnectionCallbacks(P1: JGoogleApiClient_ConnectionCallbacks); cdecl;
    procedure unregisterConnectionFailedListener(P1: JGoogleApiClient_OnConnectionFailedListener); cdecl;
  end;
  TJGoogleApiClient = class(TJavaGenericImport<JGoogleApiClientClass, JGoogleApiClient>) end;

  JGoogleApiClient_ApiOptionsClass = interface(IJavaClass)
    ['{FC4A9996-CF91-430F-B365-01D348AD6387}']
  end;

  [JavaSignature('com/google/android/gms/common/api/GoogleApiClient$ApiOptions')]
  JGoogleApiClient_ApiOptions = interface(IJavaInstance)
    ['{5213FD65-89B7-4BE2-810D-5B59E2605DA5}']
  end;
  TJGoogleApiClient_ApiOptions = class(TJavaGenericImport<JGoogleApiClient_ApiOptionsClass, JGoogleApiClient_ApiOptions>) end;

  JGoogleApiClient_BuilderClass = interface(JObjectClass)
    ['{30B91F33-ECE1-497A-AA43-94DD64B81F49}']
    {class} function init(context: JContext): JGoogleApiClient_Builder; cdecl; overload;
    {class} function init(context: JContext; connectedListener: JGoogleApiClient_ConnectionCallbacks; connectionFailedListener: JGoogleApiClient_OnConnectionFailedListener): JGoogleApiClient_Builder; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/common/api/GoogleApiClient$Builder')]
  JGoogleApiClient_Builder = interface(JObject)
    ['{C40D55BB-AC6D-40FE-BEEB-701588835D98}']
    //function addApi(api: JApi): JGoogleApiClient_Builder; cdecl; overload;
    //function addApi(api: JApi; options: JGoogleApiClient_ApiOptions): JGoogleApiClient_Builder; cdecl; overload;
    function addConnectionCallbacks(listener: JGoogleApiClient_ConnectionCallbacks): JGoogleApiClient_Builder; cdecl;
    function addOnConnectionFailedListener(listener: JGoogleApiClient_OnConnectionFailedListener): JGoogleApiClient_Builder; cdecl;
    function addScope(scope: JScope): JGoogleApiClient_Builder; cdecl;
    function build: JGoogleApiClient; cdecl;
    //function dx: Jee; cdecl;
    function setAccountName(accountName: JString): JGoogleApiClient_Builder; cdecl;
    function setGravityForPopups(gravityForPopups: Integer): JGoogleApiClient_Builder; cdecl;
    function setHandler(handler: JHandler): JGoogleApiClient_Builder; cdecl;
    function setViewForPopups(viewForPopups: JView): JGoogleApiClient_Builder; cdecl;
    function useDefaultAccount: JGoogleApiClient_Builder; cdecl;
  end;
  TJGoogleApiClient_Builder = class(TJavaGenericImport<JGoogleApiClient_BuilderClass, JGoogleApiClient_Builder>) end;

  JGoogleApiClient_ConnectionCallbacksClass = interface(IJavaClass)
    ['{800647EA-E521-465F-AD7D-3F374C7BDE6F}']
    {class} function _GetCAUSE_NETWORK_LOST: Integer; cdecl;
    {class} function _GetCAUSE_SERVICE_DISCONNECTED: Integer; cdecl;
    {class} property CAUSE_NETWORK_LOST: Integer read _GetCAUSE_NETWORK_LOST;
    {class} property CAUSE_SERVICE_DISCONNECTED: Integer read _GetCAUSE_SERVICE_DISCONNECTED;
  end;

  [JavaSignature('com/google/android/gms/common/api/GoogleApiClient$ConnectionCallbacks')]
  JGoogleApiClient_ConnectionCallbacks = interface(IJavaInstance)
    ['{927F8504-B4D3-4C1F-A0CC-D1A4239420B1}']
    procedure onConnected(P1: JBundle); cdecl;
    procedure onConnectionSuspended(P1: Integer); cdecl;
  end;
  TJGoogleApiClient_ConnectionCallbacks = class(TJavaGenericImport<JGoogleApiClient_ConnectionCallbacksClass, JGoogleApiClient_ConnectionCallbacks>) end;

  JGoogleApiClient_OnConnectionFailedListenerClass = interface(JGooglePlayServicesClient_OnConnectionFailedListenerClass)
    ['{0C7E36A8-B337-4234-B11A-869737DFC94F}']
  end;

  [JavaSignature('com/google/android/gms/common/api/GoogleApiClient$OnConnectionFailedListener')]
  JGoogleApiClient_OnConnectionFailedListener = interface(JGooglePlayServicesClient_OnConnectionFailedListener)
    ['{17324E58-869C-4B80-A558-F0BDCC1E1F92}']
  end;
  TJGoogleApiClient_OnConnectionFailedListener = class(TJavaGenericImport<JGoogleApiClient_OnConnectionFailedListenerClass, JGoogleApiClient_OnConnectionFailedListener>) end;

  JPendingResultClass = interface(IJavaClass)
    ['{F4D25687-3A3B-4E07-AA64-216112D5EE36}']
  end;

  [JavaSignature('com/google/android/gms/common/api/PendingResult')]
  JPendingResult = interface(IJavaInstance)
    ['{18CC0862-D22D-4284-8F4F-65AB69D93849}']
    function await: Japi_Result; cdecl; overload;
    function await(P1: Int64; P2: JTimeUnit): Japi_Result; cdecl; overload;
    procedure setResultCallback(P1: JResultCallback); cdecl; overload;
    procedure setResultCallback(P1: JResultCallback; P2: Int64; P3: JTimeUnit); cdecl; overload;
  end;
  TJPendingResult = class(TJavaGenericImport<JPendingResultClass, JPendingResult>) end;

  JResultCallbackClass = interface(IJavaClass)
    ['{5C713C92-DB51-44A3-A818-4B55058050EF}']
  end;

  [JavaSignature('com/google/android/gms/common/api/ResultCallback')]
  JResultCallback = interface(IJavaInstance)
    ['{2AA7801D-1E93-45C2-A1E1-1B3BA073C3B5}']
    procedure onResult(P1: Japi_Result); cdecl;
  end;
  TJResultCallback = class(TJavaGenericImport<JResultCallbackClass, JResultCallback>) end;

  JScopeClass = interface(JObjectClass)
    ['{92B24AEE-2F21-4421-BEA0-56D622112E1C}']
    {class} function init(scopeUri: JString): JScope; cdecl;
  end;

  [JavaSignature('com/google/android/gms/common/api/Scope')]
  JScope = interface(JObject)
    ['{B2FA592B-4FAF-4B58-9C57-C9AF95F95FB9}']
    function dD: JString; cdecl;
  end;
  TJScope = class(TJavaGenericImport<JScopeClass, JScope>) end;

  JStatusClass = interface(JObjectClass)
    ['{03D89F5A-D17B-42E3-8CC2-BEEEE74EA2AA}']
    {class} function _GetCREATOR: JStatusCreator; cdecl;
    {class} function _GetzQ: JStatus; cdecl;
    {class} function _GetzR: JStatus; cdecl;
    {class} function _GetzS: JStatus; cdecl;
    {class} function init(statusCode: Integer): JStatus; cdecl; overload;
    {class} function init(statusCode: Integer; statusMessage: JString; pendingIntent: JPendingIntent): JStatus; cdecl; overload;
    {class} property CREATOR: JStatusCreator read _GetCREATOR;
    {class} property zQ: JStatus read _GetzQ;
    {class} property zR: JStatus read _GetzR;
    {class} property zS: JStatus read _GetzS;
  end;

  [JavaSignature('com/google/android/gms/common/api/Status')]
  JStatus = interface(JObject)
    ['{C7D91968-F802-4D4D-971C-299D4112A92F}']
    function dG: JConnectionResult; cdecl;
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getResolution: JPendingIntent; cdecl;
    function getStatus: JStatus; cdecl;
    function getStatusCode: Integer; cdecl;
    function hasResolution: Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isInterrupted: Boolean; cdecl;
    function isSuccess: Boolean; cdecl;
    procedure startResolutionForResult(activity: JActivity; requestCode: Integer); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJStatus = class(TJavaGenericImport<JStatusClass, JStatus>) end;

  JStatusCreatorClass = interface(JObjectClass)
    ['{1DC510EB-3EC0-4214-8D7E-863B7712EDFD}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JStatusCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/common/api/StatusCreator')]
  JStatusCreator = interface(JObject)
    ['{C143765D-7BD4-485D-9726-211069CE7258}']
    function createFromParcel(parcel: JParcel): JStatus; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JStatus>; cdecl;
  end;
  TJStatusCreator = class(TJavaGenericImport<JStatusCreatorClass, JStatusCreator>) end;

  JDataBufferUtilsClass = interface(JObjectClass)
    ['{A6F05052-1AD4-4A5F-9581-E6CD07AE5CA0}']
    {class} function freezeAndClose(buffer: JDataBuffer): JArrayList; cdecl;
    {class} function hasNextPage(buffer: JDataBuffer): Boolean; cdecl;
    {class} function hasPrevPage(buffer: JDataBuffer): Boolean; cdecl;
  end;

  [JavaSignature('com/google/android/gms/common/data/DataBufferUtils')]
  JDataBufferUtils = interface(JObject)
    ['{0E0D0AA8-DA82-4041-83E7-F5D1BC7E12F1}']
  end;
  TJDataBufferUtils = class(TJavaGenericImport<JDataBufferUtilsClass, JDataBufferUtils>) end;

  JDataHolderClass = interface(JObjectClass)
    ['{A4454701-C03F-4AEC-B610-92DB2EF77521}']
    {class} function _GetCREATOR: JDataHolderCreator; cdecl;
    {class} function builder(columns: TJavaObjectArray<JString>): JDataHolder_Builder; cdecl; overload;
    {class} function builder(columns: TJavaObjectArray<JString>; uniqueColumn: JString): JDataHolder_Builder; cdecl; overload;
    {class} function empty(statusCode: Integer): JDataHolder; cdecl; overload;
    {class} function empty(statusCode: Integer; metadata: JBundle): JDataHolder; cdecl; overload;
    {class} function init(cursor: JAbstractWindowedCursor; statusCode: Integer; metadata: JBundle): JDataHolder; cdecl; overload;
    {class} function init(columns: TJavaObjectArray<JString>; windows: TJavaObjectArray<JCursorWindow>; statusCode: Integer; metadata: JBundle): JDataHolder; cdecl; overload;
    {class} property CREATOR: JDataHolderCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/common/data/DataHolder')]
  JDataHolder = interface(JObject)
    ['{D1CA2B4D-272B-428F-96B7-64EAFB770E51}']
    function I(P1: Integer): Integer; cdecl;
    procedure c(P1: JObject); cdecl;
    procedure close; cdecl;
    procedure copyToBuffer(column: JString; row: Integer; windowIndex: Integer; dataOut: Jdatabase_CharArrayBuffer); cdecl;
    function describeContents: Integer; cdecl;
    function getBoolean(column: JString; row: Integer; windowIndex: Integer): Boolean; cdecl;
    function getByteArray(column: JString; row: Integer; windowIndex: Integer): TJavaArray<Byte>; cdecl;
    function getCount: Integer; cdecl;
    function getInteger(column: JString; row: Integer; windowIndex: Integer): Integer; cdecl;
    function getLong(column: JString; row: Integer; windowIndex: Integer): Int64; cdecl;
    function getMetadata: JBundle; cdecl;
    function getStatusCode: Integer; cdecl;
    function getString(column: JString; row: Integer; windowIndex: Integer): JString; cdecl;
    function hasColumn(column: JString): Boolean; cdecl;
    function hasNull(column: JString; row: Integer; windowIndex: Integer): Boolean; cdecl;
    function isClosed: Boolean; cdecl;
    function parseUri(column: JString; row: Integer; windowIndex: Integer): Jnet_Uri; cdecl;
    procedure validateContents; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJDataHolder = class(TJavaGenericImport<JDataHolderClass, JDataHolder>) end;

  JDataHolder_BuilderClass = interface(JObjectClass)
    ['{E93B37D3-B530-4551-A9C3-015AB867E2AF}']
  end;

  [JavaSignature('com/google/android/gms/common/data/DataHolder$Builder')]
  JDataHolder_Builder = interface(JObject)
    ['{AC62943F-A09F-4D21-9A7E-28B5EC92D603}']
    function build(statusCode: Integer): JDataHolder; cdecl; overload;
    function build(statusCode: Integer; metadata: JBundle): JDataHolder; cdecl; overload;
    function build(statusCode: Integer; metadata: JBundle; maxResults: Integer): JDataHolder; cdecl; overload;
    function getCount: Integer; cdecl;
    function removeRowsWithValue(column: JString; value: JObject): JDataHolder_Builder; cdecl;
    function sort(sortColumn: JString): JDataHolder_Builder; cdecl;
    function withRow(row: JHashMap): JDataHolder_Builder; cdecl; overload;
    function withRow(values: JContentValues): JDataHolder_Builder; cdecl; overload;
  end;
  TJDataHolder_Builder = class(TJavaGenericImport<JDataHolder_BuilderClass, JDataHolder_Builder>) end;

  JDataHolderCreatorClass = interface(JObjectClass)
    ['{C474CAB6-8473-48AA-AF66-88D4A0DCDC38}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JDataHolderCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/common/data/DataHolderCreator')]
  JDataHolderCreator = interface(JObject)
    ['{928F9B14-D7B1-4F6D-AD7E-FF0B7EEE7679}']
    function createFromParcel(parcel: JParcel): JDataHolder; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JDataHolder>; cdecl;
  end;
  TJDataHolderCreator = class(TJavaGenericImport<JDataHolderCreatorClass, JDataHolderCreator>) end;

  JFilteredDataBufferClass = interface(JDataBufferClass)
    ['{7EAE6C22-E046-43C4-AA51-F02E9A8FF37D}']
    {class} function init(dataBuffer: JDataBuffer): JFilteredDataBuffer; cdecl;
  end;

  [JavaSignature('com/google/android/gms/common/data/FilteredDataBuffer')]
  JFilteredDataBuffer = interface(JDataBuffer)
    ['{5092FE96-F7F3-4BDF-A23E-696035318BF6}']
    procedure close; cdecl;
    function &get(position: Integer): JObject; cdecl;
    function getMetadata: JBundle; cdecl;
    function isClosed: Boolean; cdecl;
  end;
  TJFilteredDataBuffer = class(TJavaGenericImport<JFilteredDataBufferClass, JFilteredDataBuffer>) end;

  JFreezableUtilsClass = interface(JObjectClass)
    ['{316D03A5-C5F1-4945-9C45-FFCB615A1EB0}']
    {class} function freeze(array_: TJavaObjectArray<JFreezable>): JArrayList; cdecl; overload;
    {class} function freeze(list: JArrayList): JArrayList; cdecl; overload;
    {class} function init: JFreezableUtils; cdecl;
  end;

  [JavaSignature('com/google/android/gms/common/data/FreezableUtils')]
  JFreezableUtils = interface(JObject)
    ['{E1F7BF21-8831-4863-B184-5EF34CE633A9}']
  end;
  TJFreezableUtils = class(TJavaGenericImport<JFreezableUtilsClass, JFreezableUtils>) end;

  JImageManagerClass = interface(JObjectClass)
    ['{A9B72249-08F9-4577-84D5-2D78D0799E1F}']
    {class} function a(P1: JContext; P2: Boolean): JImageManager; cdecl; overload;
    {class} function create(context: JContext): JImageManager; cdecl;
  end;

  [JavaSignature('com/google/android/gms/common/images/ImageManager')]
  JImageManager = interface(JObject)
    ['{87EDA32C-22FC-4A0A-B710-2DA3604AA1DD}']
    //procedure a(P1: Jimages_a); cdecl; overload;
    procedure loadImage(imageView: JImageView; uri: Jnet_Uri); cdecl; overload;
    procedure loadImage(imageView: JImageView; resId: Integer); cdecl; overload;
    procedure loadImage(listener: JImageManager_OnImageLoadedListener; uri: Jnet_Uri); cdecl; overload;
    procedure loadImage(listener: JImageManager_OnImageLoadedListener; uri: Jnet_Uri; defaultResId: Integer); cdecl; overload;
    procedure loadImage(imageView: JImageView; uri: Jnet_Uri; defaultResId: Integer); cdecl; overload;
  end;
  TJImageManager = class(TJavaGenericImport<JImageManagerClass, JImageManager>) end;

  JImageManager_ImageReceiverClass = interface(JResultReceiverClass)
    ['{1AE0CF58-2E8D-4C75-9A2C-6AC64EE3E1E3}']
  end;

  [JavaSignature('com/google/android/gms/common/images/ImageManager$ImageReceiver')]
  JImageManager_ImageReceiver = interface(JResultReceiver)
    ['{0838B663-4DED-43E3-9090-F800D721FD42}']
    //procedure c(P1: Jimages_a); cdecl;
    //procedure d(P1: Jimages_a); cdecl;
    procedure dN; cdecl;
    procedure onReceiveResult(resultCode: Integer; resultData: JBundle); cdecl;
  end;
  TJImageManager_ImageReceiver = class(TJavaGenericImport<JImageManager_ImageReceiverClass, JImageManager_ImageReceiver>) end;

  JImageManager_OnImageLoadedListenerClass = interface(IJavaClass)
    ['{4A5F4833-04FC-4164-99F6-96619A719D1F}']
  end;

  [JavaSignature('com/google/android/gms/common/images/ImageManager$OnImageLoadedListener')]
  JImageManager_OnImageLoadedListener = interface(IJavaInstance)
    ['{332D053E-9E93-4340-B0D6-BEA18CF1E0FF}']
    procedure onImageLoaded(P1: Jnet_Uri; P2: JDrawable; P3: Boolean); cdecl;
  end;
  TJImageManager_OnImageLoadedListener = class(TJavaGenericImport<JImageManager_OnImageLoadedListenerClass, JImageManager_OnImageLoadedListener>) end;

  JWebImageClass = interface(JObjectClass)
    ['{594BC431-A5C3-422B-9BF6-393B431FF083}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(url: Jnet_Uri): JWebImage; cdecl; overload;
    {class} function init(json: JJSONObject): JWebImage; cdecl; overload;
    {class} function init(url: Jnet_Uri; width: Integer; height: Integer): JWebImage; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/common/images/WebImage')]
  JWebImage = interface(JObject)
    ['{D1CFCDF0-FAA9-49A9-AA82-669DAFFBE12A}']
    function cT: JJSONObject; cdecl;
    function describeContents: Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getHeight: Integer; cdecl;
    function getUrl: Jnet_Uri; cdecl;
    function getWidth: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJWebImage = class(TJavaGenericImport<JWebImageClass, JWebImage>) end;

  JSafeParcelableClass = interface(JParcelableClass)
    ['{865435AB-F2E1-4DEF-B775-17CC0CAC9AED}']
    {class} function _GetNULL: JString; cdecl;
    {class} 
  end;

  [JavaSignature('com/google/android/gms/common/internal/safeparcel/SafeParcelable')]
  JSafeParcelable = interface(JParcelable)
    ['{0CBA956D-6EA5-41D8-8AFC-42759ADFD37B}']
  end;
  TJSafeParcelable = class(TJavaGenericImport<JSafeParcelableClass, JSafeParcelable>) end;

  JContentsClass = interface(JObjectClass)
    ['{EAAF17DA-DB45-4A7D-A139-3CA6B7801B34}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/Contents')]
  JContents = interface(JObject)
    ['{C4F9AA12-244B-4E21-BBC8-0B6669CB32BE}']
    procedure close; cdecl;
    function describeContents: Integer; cdecl;
    function eP: Integer; cdecl;
    function getDriveId: JDriveId; cdecl;
    function getInputStream: JInputStream; cdecl;
    function getMode: Integer; cdecl;
    function getOutputStream: JOutputStream; cdecl;
    function getParcelFileDescriptor: JParcelFileDescriptor; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJContents = class(TJavaGenericImport<JContentsClass, JContents>) end;

  JCreateFileActivityBuilderClass = interface(JObjectClass)
    ['{84F65D7D-83BB-4840-BCE1-A12264238278}']
    {class} function _GetEXTRA_RESPONSE_DRIVE_ID: JString; cdecl;
    {class} function init: JCreateFileActivityBuilder; cdecl;
    {class} property EXTRA_RESPONSE_DRIVE_ID: JString read _GetEXTRA_RESPONSE_DRIVE_ID;
  end;

  [JavaSignature('com/google/android/gms/drive/CreateFileActivityBuilder')]
  JCreateFileActivityBuilder = interface(JObject)
    ['{37F73C80-E500-4706-A032-CC4720DB2752}']
    function build(apiClient: JGoogleApiClient): JIntentSender; cdecl;
    function setActivityStartFolder(folder: JDriveId): JCreateFileActivityBuilder; cdecl;
    function setActivityTitle(title: JString): JCreateFileActivityBuilder; cdecl;
    function setInitialContents(contents: JContents): JCreateFileActivityBuilder; cdecl;
    function setInitialMetadata(metadataChangeSet: JMetadataChangeSet): JCreateFileActivityBuilder; cdecl;
  end;
  TJCreateFileActivityBuilder = class(TJavaGenericImport<JCreateFileActivityBuilderClass, JCreateFileActivityBuilder>) end;

  JDriveClass = interface(JObjectClass)
    ['{C9497912-3B5B-442C-AEF3-DE9B903D814F}']
    {class} //function _GetAPI: JApi; cdecl;
    {class} function _GetDa: JScope; cdecl;
    {class} //function _GetDb: Jdrive_c; cdecl;
    {class} function _GetDriveApi: JDriveApi; cdecl;
    {class} function _GetSCOPE_APPFOLDER: JScope; cdecl;
    {class} function _GetSCOPE_FILE: JScope; cdecl;
    {class} //function _Getva: JApi_b; cdecl;
    {class} //property API: JApi read _GetAPI;
    {class} property Da: JScope read _GetDa;
    {class} //property Db: Jdrive_c read _GetDb;
    {class} property DriveApi: JDriveApi read _GetDriveApi;
    {class} property SCOPE_APPFOLDER: JScope read _GetSCOPE_APPFOLDER;
    {class} property SCOPE_FILE: JScope read _GetSCOPE_FILE;
    {class} //property va: JApi_b read _Getva;
  end;

  [JavaSignature('com/google/android/gms/drive/Drive')]
  JDrive = interface(JObject)
    ['{A1931383-0BA0-4569-A8F0-40E95DD6D13C}']
  end;
  TJDrive = class(TJavaGenericImport<JDriveClass, JDrive>) end;

  JDriveApiClass = interface(IJavaClass)
    ['{B4FC4923-0F51-4E21-BADF-A08ABFDEC35B}']
  end;

  [JavaSignature('com/google/android/gms/drive/DriveApi')]
  JDriveApi = interface(IJavaInstance)
    ['{8146F844-13D5-4CDA-9455-6842EC9ADBCF}']
    function discardContents(P1: JGoogleApiClient; P2: JContents): JPendingResult; cdecl;
    function fetchDriveId(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
    function getAppFolder(P1: JGoogleApiClient): JDriveFolder; cdecl;
    function getFile(P1: JGoogleApiClient; P2: JDriveId): JDriveFile; cdecl;
    function getFolder(P1: JGoogleApiClient; P2: JDriveId): JDriveFolder; cdecl;
    function getRootFolder(P1: JGoogleApiClient): JDriveFolder; cdecl;
    function newContents(P1: JGoogleApiClient): JPendingResult; cdecl;
    function newCreateFileActivityBuilder: JCreateFileActivityBuilder; cdecl;
    function newOpenFileActivityBuilder: JOpenFileActivityBuilder; cdecl;
    function query(P1: JGoogleApiClient; P2: JQuery): JPendingResult; cdecl;
    function requestSync(P1: JGoogleApiClient): JPendingResult; cdecl;
  end;
  TJDriveApi = class(TJavaGenericImport<JDriveApiClass, JDriveApi>) end;

  JDriveApi_ContentsResultClass = interface(Japi_ResultClass)
    ['{13F292CA-48DA-4154-843D-AC3089840539}']
  end;

  [JavaSignature('com/google/android/gms/drive/DriveApi$ContentsResult')]
  JDriveApi_ContentsResult = interface(Japi_Result)
    ['{BF68FD14-A1A8-400C-91BD-E8AE55598AA6}']
    function getContents: JContents; cdecl;
  end;
  TJDriveApi_ContentsResult = class(TJavaGenericImport<JDriveApi_ContentsResultClass, JDriveApi_ContentsResult>) end;

  JDriveApi_DriveIdResultClass = interface(Japi_ResultClass)
    ['{3D597341-B081-48AA-AECB-20CBF3511ED2}']
  end;

  [JavaSignature('com/google/android/gms/drive/DriveApi$DriveIdResult')]
  JDriveApi_DriveIdResult = interface(Japi_Result)
    ['{415029D4-F53A-415B-9F11-859597659421}']
    function getDriveId: JDriveId; cdecl;
  end;
  TJDriveApi_DriveIdResult = class(TJavaGenericImport<JDriveApi_DriveIdResultClass, JDriveApi_DriveIdResult>) end;

  JDriveApi_IntentSenderResultClass = interface(Japi_ResultClass)
    ['{B9271349-1DD9-4E9A-9017-FB9E3404B1A9}']
  end;

  [JavaSignature('com/google/android/gms/drive/DriveApi$IntentSenderResult')]
  JDriveApi_IntentSenderResult = interface(Japi_Result)
    ['{6B897285-9532-4072-A3B3-4626F643417D}']
    function getIntentSender: JIntentSender; cdecl;
  end;
  TJDriveApi_IntentSenderResult = class(TJavaGenericImport<JDriveApi_IntentSenderResultClass, JDriveApi_IntentSenderResult>) end;

  JDriveApi_MetadataBufferResultClass = interface(Japi_ResultClass)
    ['{3BA42F1A-756F-4553-88C0-23FB4935A466}']
  end;

  [JavaSignature('com/google/android/gms/drive/DriveApi$MetadataBufferResult')]
  JDriveApi_MetadataBufferResult = interface(Japi_Result)
    ['{3D651B3E-C84E-42F1-ABA8-AE95868C5F3C}']
    function getMetadataBuffer: JMetadataBuffer; cdecl;
  end;
  TJDriveApi_MetadataBufferResult = class(TJavaGenericImport<JDriveApi_MetadataBufferResultClass, JDriveApi_MetadataBufferResult>) end;

  JDriveApi_OnSyncFinishCallbackClass = interface(IJavaClass)
    ['{A39B7603-7C5B-46B4-A1B3-0289FC8DB078}']
  end;

  [JavaSignature('com/google/android/gms/drive/DriveApi$OnSyncFinishCallback')]
  JDriveApi_OnSyncFinishCallback = interface(IJavaInstance)
    ['{A6E22EEE-E53C-4615-A3F8-E05AC7D66117}']
    procedure onSyncFinish(P1: JStatus); cdecl;
  end;
  TJDriveApi_OnSyncFinishCallback = class(TJavaGenericImport<JDriveApi_OnSyncFinishCallbackClass, JDriveApi_OnSyncFinishCallback>) end;

  JDriveResourceClass = interface(IJavaClass)
    ['{D7539428-9FB3-4A97-B180-506532FED495}']
  end;

  [JavaSignature('com/google/android/gms/drive/DriveResource')]
  JDriveResource = interface(IJavaInstance)
    ['{E76D8E38-4CA0-411F-8D66-6D406069FC5B}']
    function addChangeListener(P1: JGoogleApiClient; P2: JDriveEvent_Listener): JPendingResult; cdecl;
    function getDriveId: JDriveId; cdecl;
    function getMetadata(P1: JGoogleApiClient): JPendingResult; cdecl;
    function listParents(P1: JGoogleApiClient): JPendingResult; cdecl;
    function removeChangeListener(P1: JGoogleApiClient; P2: JDriveEvent_Listener): JPendingResult; cdecl;
    function updateMetadata(P1: JGoogleApiClient; P2: JMetadataChangeSet): JPendingResult; cdecl;
  end;
  TJDriveResource = class(TJavaGenericImport<JDriveResourceClass, JDriveResource>) end;

  JDriveFileClass = interface(JDriveResourceClass)
    ['{B0B5F653-D513-4097-8E44-FE33744CCC94}']
    {class} function _GetMODE_READ_ONLY: Integer; cdecl;
    {class} function _GetMODE_READ_WRITE: Integer; cdecl;
    {class} function _GetMODE_WRITE_ONLY: Integer; cdecl;
    {class} property MODE_READ_ONLY: Integer read _GetMODE_READ_ONLY;
    {class} property MODE_READ_WRITE: Integer read _GetMODE_READ_WRITE;
    {class} property MODE_WRITE_ONLY: Integer read _GetMODE_WRITE_ONLY;
  end;

  [JavaSignature('com/google/android/gms/drive/DriveFile')]
  JDriveFile = interface(JDriveResource)
    ['{76660E31-402B-428F-B8AA-A60E1A9B62CB}']
    function commitAndCloseContents(P1: JGoogleApiClient; P2: JContents): JPendingResult; cdecl; overload;
    function commitAndCloseContents(P1: JGoogleApiClient; P2: JContents; P3: JMetadataChangeSet): JPendingResult; cdecl; overload;
    function discardContents(P1: JGoogleApiClient; P2: JContents): JPendingResult; cdecl;
    function openContents(P1: JGoogleApiClient; P2: Integer; P3: JDriveFile_DownloadProgressListener): JPendingResult; cdecl;
  end;
  TJDriveFile = class(TJavaGenericImport<JDriveFileClass, JDriveFile>) end;

  JDriveFile_DownloadProgressListenerClass = interface(IJavaClass)
    ['{A4125D98-8BAB-48BF-84C3-B2E42712A819}']
  end;

  [JavaSignature('com/google/android/gms/drive/DriveFile$DownloadProgressListener')]
  JDriveFile_DownloadProgressListener = interface(IJavaInstance)
    ['{1F75E4F1-F712-4A63-8DF9-8F33A0C97ED5}']
    procedure onProgress(P1: Int64; P2: Int64); cdecl;
  end;
  TJDriveFile_DownloadProgressListener = class(TJavaGenericImport<JDriveFile_DownloadProgressListenerClass, JDriveFile_DownloadProgressListener>) end;

  JDriveFolderClass = interface(JDriveResourceClass)
    ['{EA9D663B-28A8-47C3-9187-004196F2CF01}']
    {class} function _GetMIME_TYPE: JString; cdecl;
    {class} property MIME_TYPE: JString read _GetMIME_TYPE;
  end;

  [JavaSignature('com/google/android/gms/drive/DriveFolder')]
  JDriveFolder = interface(JDriveResource)
    ['{7204CCCD-8C3D-4785-A619-2C045915467A}']
    function createFile(P1: JGoogleApiClient; P2: JMetadataChangeSet; P3: JContents): JPendingResult; cdecl;
    function createFolder(P1: JGoogleApiClient; P2: JMetadataChangeSet): JPendingResult; cdecl;
    function listChildren(P1: JGoogleApiClient): JPendingResult; cdecl;
    function queryChildren(P1: JGoogleApiClient; P2: JQuery): JPendingResult; cdecl;
  end;
  TJDriveFolder = class(TJavaGenericImport<JDriveFolderClass, JDriveFolder>) end;

  JDriveFolder_DriveFileResultClass = interface(Japi_ResultClass)
    ['{D137D607-2EBB-407C-84A7-3122F6ED410C}']
  end;

  [JavaSignature('com/google/android/gms/drive/DriveFolder$DriveFileResult')]
  JDriveFolder_DriveFileResult = interface(Japi_Result)
    ['{927EB119-66A6-40FF-80AF-9756880F1187}']
    function getDriveFile: JDriveFile; cdecl;
  end;
  TJDriveFolder_DriveFileResult = class(TJavaGenericImport<JDriveFolder_DriveFileResultClass, JDriveFolder_DriveFileResult>) end;

  JDriveFolder_DriveFolderResultClass = interface(Japi_ResultClass)
    ['{B3277743-8CD8-4A8B-A061-85A70C97B3B0}']
  end;

  [JavaSignature('com/google/android/gms/drive/DriveFolder$DriveFolderResult')]
  JDriveFolder_DriveFolderResult = interface(Japi_Result)
    ['{D04ED137-1BE0-486F-A7CB-0D0B727B43B9}']
    function getDriveFolder: JDriveFolder; cdecl;
  end;
  TJDriveFolder_DriveFolderResult = class(TJavaGenericImport<JDriveFolder_DriveFolderResultClass, JDriveFolder_DriveFolderResult>) end;

  JDriveIdClass = interface(JObjectClass)
    ['{97E12937-E8A6-4385-817F-C7ED09E9B6FB}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function aq(P1: JString): JDriveId; cdecl;
    {class} function decodeFromString(s: JString): JDriveId; cdecl;
    {class} function init(resourceId: JString; sqlId: Int64; databaseInstanceId: Int64): JDriveId; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/DriveId')]
  JDriveId = interface(JObject)
    ['{A00E5948-6744-4B0E-8AC3-19CFE3CBE19B}']
    function describeContents: Integer; cdecl;
    function encodeToString: JString; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getResourceId: JString; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJDriveId = class(TJavaGenericImport<JDriveIdClass, JDriveId>) end;

  JDriveResource_MetadataResultClass = interface(Japi_ResultClass)
    ['{B3C77824-61F7-41FA-A0C3-2E72D4F99BE4}']
  end;

  [JavaSignature('com/google/android/gms/drive/DriveResource$MetadataResult')]
  JDriveResource_MetadataResult = interface(Japi_Result)
    ['{0A42AA3F-F620-419D-A16A-2B7B400BE56B}']
    function getMetadata: JMetadata; cdecl;
  end;
  TJDriveResource_MetadataResult = class(TJavaGenericImport<JDriveResource_MetadataResultClass, JDriveResource_MetadataResult>) end;

  JDriveStatusCodesClass = interface(JCommonStatusCodesClass)
    ['{36BFD6ED-FCC3-43CF-B439-1FD32AE1B6E7}']
    {class} function _GetDRIVE_EXTERNAL_STORAGE_REQUIRED: Integer; cdecl;
    {class} property DRIVE_EXTERNAL_STORAGE_REQUIRED: Integer read _GetDRIVE_EXTERNAL_STORAGE_REQUIRED;
  end;

  [JavaSignature('com/google/android/gms/drive/DriveStatusCodes')]
  JDriveStatusCodes = interface(JCommonStatusCodes)
    ['{50671D89-6846-46E3-BEDD-96D263EA5A86}']
  end;
  TJDriveStatusCodes = class(TJavaGenericImport<JDriveStatusCodesClass, JDriveStatusCodes>) end;

  JMetadataClass = interface(JObjectClass)
    ['{BE88B839-5339-4905-9FF3-676606A3848D}']
    {class} function _GetCONTENT_AVAILABLE_LOCALLY: Integer; cdecl;
    {class} function _GetCONTENT_NOT_AVAILABLE_LOCALLY: Integer; cdecl;
    {class} function init: JMetadata; cdecl;
    {class} property CONTENT_AVAILABLE_LOCALLY: Integer read _GetCONTENT_AVAILABLE_LOCALLY;
    {class} property CONTENT_NOT_AVAILABLE_LOCALLY: Integer read _GetCONTENT_NOT_AVAILABLE_LOCALLY;
  end;

  [JavaSignature('com/google/android/gms/drive/Metadata')]
  JMetadata = interface(JObject)
    ['{C781BC71-DE69-4C56-9453-4AABECFC9838}']
    function getAlternateLink: JString; cdecl;
    function getContentAvailability: Integer; cdecl;
    function getCreatedDate: JDate; cdecl;
    function getDescription: JString; cdecl;
    function getDriveId: JDriveId; cdecl;
    function getEmbedLink: JString; cdecl;
    function getFileExtension: JString; cdecl;
    function getFileSize: Int64; cdecl;
    function getLastViewedByMeDate: JDate; cdecl;
    function getMimeType: JString; cdecl;
    function getModifiedByMeDate: JDate; cdecl;
    function getModifiedDate: JDate; cdecl;
    function getOriginalFilename: JString; cdecl;
    function getQuotaBytesUsed: Int64; cdecl;
    function getSharedWithMeDate: JDate; cdecl;
    function getTitle: JString; cdecl;
    function getWebContentLink: JString; cdecl;
    function getWebViewLink: JString; cdecl;
    function isEditable: Boolean; cdecl;
    function isFolder: Boolean; cdecl;
    function isInAppFolder: Boolean; cdecl;
    function isPinnable: Boolean; cdecl;
    function isPinned: Boolean; cdecl;
    function isRestricted: Boolean; cdecl;
    function isShared: Boolean; cdecl;
    function isStarred: Boolean; cdecl;
    function isTrashed: Boolean; cdecl;
    function isViewed: Boolean; cdecl;
  end;
  TJMetadata = class(TJavaGenericImport<JMetadataClass, JMetadata>) end;

  JMetadataBufferClass = interface(JDataBufferClass)
    ['{A448820D-F33B-4770-A339-70FC43CE5ADA}']
    {class} function init(dataHolder: JDataHolder; nextPageToken: JString): JMetadataBuffer; cdecl;
  end;

  [JavaSignature('com/google/android/gms/drive/MetadataBuffer')]
  JMetadataBuffer = interface(JDataBuffer)
    ['{04C40993-1C15-465A-9596-EF89689BBFFD}']
    function &get(row: Integer): JMetadata; cdecl;
    function getNextPageToken: JString; cdecl;
  end;
  TJMetadataBuffer = class(TJavaGenericImport<JMetadataBufferClass, JMetadataBuffer>) end;

  JMetadataChangeSetClass = interface(JObjectClass)
    ['{8C5A5B57-10D7-452B-9AAF-21097AB39D62}']
  end;

  [JavaSignature('com/google/android/gms/drive/MetadataChangeSet')]
  JMetadataChangeSet = interface(JObject)
    ['{B330CDE3-78CB-47E6-A7D3-B8EBA8F63027}']
    function eS: JMetadataBundle; cdecl;
    function getIndexableText: JString; cdecl;
    function getLastViewedByMeDate: JDate; cdecl;
    function getMimeType: JString; cdecl;
    function getTitle: JString; cdecl;
    function isPinned: JBoolean; cdecl;
    function isStarred: JBoolean; cdecl;
    function isViewed: JBoolean; cdecl;
  end;
  TJMetadataChangeSet = class(TJavaGenericImport<JMetadataChangeSetClass, JMetadataChangeSet>) end;

  JMetadataChangeSet_BuilderClass = interface(JObjectClass)
    ['{55EB8050-4CA9-40F0-A09A-26FC59E7499F}']
    {class} function init: JMetadataChangeSet_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/drive/MetadataChangeSet$Builder')]
  JMetadataChangeSet_Builder = interface(JObject)
    ['{5A5C927E-9F79-4375-931E-3FFF02799B2B}']
    function build: JMetadataChangeSet; cdecl;
    function setIndexableText(text: JString): JMetadataChangeSet_Builder; cdecl;
    function setLastViewedByMeDate(date: JDate): JMetadataChangeSet_Builder; cdecl;
    function setMimeType(mimeType: JString): JMetadataChangeSet_Builder; cdecl;
    function setPinned(pinned: Boolean): JMetadataChangeSet_Builder; cdecl;
    function setStarred(starred: Boolean): JMetadataChangeSet_Builder; cdecl;
    function setTitle(title: JString): JMetadataChangeSet_Builder; cdecl;
    function setViewed(viewed: Boolean): JMetadataChangeSet_Builder; cdecl;
  end;
  TJMetadataChangeSet_Builder = class(TJavaGenericImport<JMetadataChangeSet_BuilderClass, JMetadataChangeSet_Builder>) end;

  JOpenFileActivityBuilderClass = interface(JObjectClass)
    ['{15B09E0F-F942-4395-AAA9-DF9F8DF47412}']
    {class} function _GetEXTRA_RESPONSE_DRIVE_ID: JString; cdecl;
    {class} function init: JOpenFileActivityBuilder; cdecl;
    {class} property EXTRA_RESPONSE_DRIVE_ID: JString read _GetEXTRA_RESPONSE_DRIVE_ID;
  end;

  [JavaSignature('com/google/android/gms/drive/OpenFileActivityBuilder')]
  JOpenFileActivityBuilder = interface(JObject)
    ['{04221B2A-CB20-4386-AE49-7EFA0011E872}']
    function build(apiClient: JGoogleApiClient): JIntentSender; cdecl;
    function setActivityStartFolder(folder: JDriveId): JOpenFileActivityBuilder; cdecl;
    function setActivityTitle(title: JString): JOpenFileActivityBuilder; cdecl;
    function setMimeType(mimeTypes: TJavaObjectArray<JString>): JOpenFileActivityBuilder; cdecl;
  end;
  TJOpenFileActivityBuilder = class(TJavaGenericImport<JOpenFileActivityBuilderClass, JOpenFileActivityBuilder>) end;

  JChangeEventClass = interface(JObjectClass)
    ['{BCBFFE28-F86B-4D9F-9A6C-B2FE32874243}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/events/ChangeEvent')]
  JChangeEvent = interface(JObject)
    ['{6FF0DDE1-05E1-4A62-8074-67C1EF860ECA}']
    function describeContents: Integer; cdecl;
    function getDriveId: JDriveId; cdecl;
    function getType: Integer; cdecl;
    function hasContentChanged: Boolean; cdecl;
    function hasMetadataChanged: Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJChangeEvent = class(TJavaGenericImport<JChangeEventClass, JChangeEvent>) end;

  JConflictEventClass = interface(JObjectClass)
    ['{B100249C-AE0A-4B12-801B-A14DEFB2E552}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/events/ConflictEvent')]
  JConflictEvent = interface(JObject)
    ['{CBBEB3C6-5792-4B96-A7B3-E9DE5603E5CD}']
    function describeContents: Integer; cdecl;
    function getType: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJConflictEvent = class(TJavaGenericImport<JConflictEventClass, JConflictEvent>) end;

  JDriveEventClass = interface(JSafeParcelableClass)
    ['{04E9A822-E6E1-46A0-866F-50F1E3587192}']
    {class} function _GetTYPE_CHANGE: Integer; cdecl;
    {class} property TYPE_CHANGE: Integer read _GetTYPE_CHANGE;
  end;

  [JavaSignature('com/google/android/gms/drive/events/DriveEvent')]
  JDriveEvent = interface(JSafeParcelable)
    ['{6E8DAFB0-3D8E-4504-9014-2794E3776288}']
    function getType: Integer; cdecl;
  end;
  TJDriveEvent = class(TJavaGenericImport<JDriveEventClass, JDriveEvent>) end;

  JDriveEvent_ListenerClass = interface(IJavaClass)
    ['{49ABD2CC-0622-4D30-807E-F035F44BF491}']
  end;

  [JavaSignature('com/google/android/gms/drive/events/DriveEvent$Listener')]
  JDriveEvent_Listener = interface(IJavaInstance)
    ['{6AE500B2-4C09-49CB-A7A3-78CFC98A5D1A}']
    procedure onEvent(P1: JDriveEvent); cdecl;
  end;
  TJDriveEvent_Listener = class(TJavaGenericImport<JDriveEvent_ListenerClass, JDriveEvent_Listener>) end;

  JResourceEventClass = interface(JDriveEventClass)
    ['{180F1FFD-E9E0-48B9-9F16-AF42D72DA6B3}']
  end;

  [JavaSignature('com/google/android/gms/drive/events/ResourceEvent')]
  JResourceEvent = interface(JDriveEvent)
    ['{92F8B1F3-4755-4EFB-9CFC-48EF8A57DD05}']
    function getDriveId: JDriveId; cdecl;
  end;
  TJResourceEvent = class(TJavaGenericImport<JResourceEventClass, JResourceEvent>) end;

  JAuthorizeAccessRequestClass = interface(JObjectClass)
    ['{703BABB1-990B-4BEE-9FC2-426A3AAA6E0C}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/AuthorizeAccessRequest')]
  JAuthorizeAccessRequest = interface(JObject)
    ['{7AC4C1CB-40C6-47C7-8980-F290E6E43F67}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJAuthorizeAccessRequest = class(TJavaGenericImport<JAuthorizeAccessRequestClass, JAuthorizeAccessRequest>) end;

  JCloseContentsAndUpdateMetadataRequestClass = interface(JObjectClass)
    ['{2F8EFD84-129C-4CCE-BF15-22A1D8251A4F}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(id: JDriveId; metadataChangeSet: JMetadataBundle; contentsReference: JContents): JCloseContentsAndUpdateMetadataRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/CloseContentsAndUpdateMetadataRequest')]
  JCloseContentsAndUpdateMetadataRequest = interface(JObject)
    ['{A580F1BA-7610-468F-83D8-06349BD77433}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCloseContentsAndUpdateMetadataRequest = class(TJavaGenericImport<JCloseContentsAndUpdateMetadataRequestClass, JCloseContentsAndUpdateMetadataRequest>) end;

  JCloseContentsRequestClass = interface(JObjectClass)
    ['{BD41E91A-D31B-44A1-8D91-0AEEB45F2831}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(contentsReference: JContents; saveResults: Boolean): JCloseContentsRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/CloseContentsRequest')]
  JCloseContentsRequest = interface(JObject)
    ['{3F4550FA-80B1-41DB-9638-65F73D211D04}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCloseContentsRequest = class(TJavaGenericImport<JCloseContentsRequestClass, JCloseContentsRequest>) end;

  JCreateContentsRequestClass = interface(JObjectClass)
    ['{456083B4-5864-4E15-ADCD-313E4B9CBF60}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JCreateContentsRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/CreateContentsRequest')]
  JCreateContentsRequest = interface(JObject)
    ['{2EEC8177-2809-4FEC-81E9-A54128D6468D}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCreateContentsRequest = class(TJavaGenericImport<JCreateContentsRequestClass, JCreateContentsRequest>) end;

  JCreateFileIntentSenderRequestClass = interface(JObjectClass)
    ['{43078E19-34EC-4652-B11A-CE88136E9D27}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(metadata: JMetadataBundle; requestId: Integer; title: JString; startFolder: JDriveId): JCreateFileIntentSenderRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/CreateFileIntentSenderRequest')]
  JCreateFileIntentSenderRequest = interface(JObject)
    ['{0529CF4C-FDA5-4008-8194-5F88F25D07D3}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCreateFileIntentSenderRequest = class(TJavaGenericImport<JCreateFileIntentSenderRequestClass, JCreateFileIntentSenderRequest>) end;

  JCreateFileRequestClass = interface(JObjectClass)
    ['{6C4EF398-4217-469A-8965-1BE7E00DEAAB}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(parentDriveId: JDriveId; metadata: JMetadataBundle; contentsReference: JContents): JCreateFileRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/CreateFileRequest')]
  JCreateFileRequest = interface(JObject)
    ['{E8116A6B-23F3-498B-969B-9C855AB86666}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCreateFileRequest = class(TJavaGenericImport<JCreateFileRequestClass, JCreateFileRequest>) end;

  JCreateFolderRequestClass = interface(JObjectClass)
    ['{5E0B5FD4-8565-456E-9369-ED93D7B8CCF5}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(parentDriveId: JDriveId; metadata: JMetadataBundle): JCreateFolderRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/CreateFolderRequest')]
  JCreateFolderRequest = interface(JObject)
    ['{C6CAB0E8-C3CF-4981-A562-3BB6F9BB21FC}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCreateFolderRequest = class(TJavaGenericImport<JCreateFolderRequestClass, JCreateFolderRequest>) end;

  JDisconnectRequestClass = interface(JObjectClass)
    ['{6FB003C6-9E0D-4FEF-A42E-E6618AC6115F}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JDisconnectRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/DisconnectRequest')]
  JDisconnectRequest = interface(JObject)
    ['{3E56F32D-449E-46B8-951B-A9E64672C318}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJDisconnectRequest = class(TJavaGenericImport<JDisconnectRequestClass, JDisconnectRequest>) end;

  JGetMetadataRequestClass = interface(JObjectClass)
    ['{0C3B6DA1-FBCE-4BC5-8981-280C41797919}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(id: JDriveId): JGetMetadataRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/GetMetadataRequest')]
  JGetMetadataRequest = interface(JObject)
    ['{A7244965-712E-41BD-AD7C-E44671B6AB25}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJGetMetadataRequest = class(TJavaGenericImport<JGetMetadataRequestClass, JGetMetadataRequest>) end;

  JListParentsRequestClass = interface(JObjectClass)
    ['{BE333F8B-F71B-4397-83FA-CB40CCD6AAC0}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(id: JDriveId): JListParentsRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/ListParentsRequest')]
  JListParentsRequest = interface(JObject)
    ['{DA42E53C-B314-41B0-BD04-EB8593EF4E15}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJListParentsRequest = class(TJavaGenericImport<JListParentsRequestClass, JListParentsRequest>) end;

  JOnContentsResponseClass = interface(JObjectClass)
    ['{4F6303A9-9DE6-4ED4-8FAE-2C19C1FDB835}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/OnContentsResponse')]
  JOnContentsResponse = interface(JObject)
    ['{54F2EB29-A5C7-4427-9E54-026DFCCC2F51}']
    function describeContents: Integer; cdecl;
    function eX: JContents; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJOnContentsResponse = class(TJavaGenericImport<JOnContentsResponseClass, JOnContentsResponse>) end;

  JOnDownloadProgressResponseClass = interface(JObjectClass)
    ['{EE5D8E4A-5E3E-42D7-B6B5-FDB4BF02C830}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/OnDownloadProgressResponse')]
  JOnDownloadProgressResponse = interface(JObject)
    ['{C0362567-DB7B-4C6A-8ADE-C67348C46DD9}']
    function describeContents: Integer; cdecl;
    function eY: Int64; cdecl;
    function eZ: Int64; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJOnDownloadProgressResponse = class(TJavaGenericImport<JOnDownloadProgressResponseClass, JOnDownloadProgressResponse>) end;

  JOnDriveIdResponseClass = interface(JObjectClass)
    ['{DE318F5B-F089-4917-894A-0A9FB9959927}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/OnDriveIdResponse')]
  JOnDriveIdResponse = interface(JObject)
    ['{70AA2449-F37A-42CC-97B6-46637B5AE7B1}']
    function describeContents: Integer; cdecl;
    function getDriveId: JDriveId; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJOnDriveIdResponse = class(TJavaGenericImport<JOnDriveIdResponseClass, JOnDriveIdResponse>) end;

  JOnEventResponseClass = interface(JObjectClass)
    ['{B3C654CE-BFC2-4FA4-BD1B-86E2401B46F8}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/OnEventResponse')]
  JOnEventResponse = interface(JObject)
    ['{8E845694-F31F-440D-86F0-1A1F87D5F2C8}']
    function describeContents: Integer; cdecl;
    function fa: JChangeEvent; cdecl;
    function fb: JConflictEvent; cdecl;
    function getEventType: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJOnEventResponse = class(TJavaGenericImport<JOnEventResponseClass, JOnEventResponse>) end;

  JOnListEntriesResponseClass = interface(JObjectClass)
    ['{FB4B5DB1-E3BF-4D2E-9BC7-5079FCF518AB}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/OnListEntriesResponse')]
  JOnListEntriesResponse = interface(JObject)
    ['{016ACAE5-991B-48DB-8A67-0ACEAF78713D}']
    function describeContents: Integer; cdecl;
    function fc: JDataHolder; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJOnListEntriesResponse = class(TJavaGenericImport<JOnListEntriesResponseClass, JOnListEntriesResponse>) end;

  JOnListParentsResponseClass = interface(JObjectClass)
    ['{BDAB4DB6-0B67-4F77-AE2A-BAB40CAD1725}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/OnListParentsResponse')]
  JOnListParentsResponse = interface(JObject)
    ['{87B6201B-7ADD-4529-B8D7-0E5719CE98A0}']
    function describeContents: Integer; cdecl;
    function fd: JDataHolder; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJOnListParentsResponse = class(TJavaGenericImport<JOnListParentsResponseClass, JOnListParentsResponse>) end;

  JOnMetadataResponseClass = interface(JObjectClass)
    ['{A61B4397-A59E-4860-88AE-9B94BAED06ED}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/OnMetadataResponse')]
  JOnMetadataResponse = interface(JObject)
    ['{DB9FFE46-D10A-46FB-BB9A-B9100CFA449F}']
    function describeContents: Integer; cdecl;
    function fe: JMetadataBundle; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJOnMetadataResponse = class(TJavaGenericImport<JOnMetadataResponseClass, JOnMetadataResponse>) end;

  JOpenContentsRequestClass = interface(JObjectClass)
    ['{2D69DD0E-925D-472B-ACE6-7CDF6563538C}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(id: JDriveId; mode: Integer): JOpenContentsRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/OpenContentsRequest')]
  JOpenContentsRequest = interface(JObject)
    ['{8B495FCA-013D-45A2-A0CB-37FAD039AA88}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJOpenContentsRequest = class(TJavaGenericImport<JOpenContentsRequestClass, JOpenContentsRequest>) end;

  JOpenFileIntentSenderRequestClass = interface(JObjectClass)
    ['{6C2D23C8-15AB-4D39-8499-C84B8DD04F6E}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(title: JString; mimeTypes: TJavaObjectArray<JString>; startFolder: JDriveId): JOpenFileIntentSenderRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/OpenFileIntentSenderRequest')]
  JOpenFileIntentSenderRequest = interface(JObject)
    ['{703767B5-473B-4601-95A7-23C3F2D50473}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJOpenFileIntentSenderRequest = class(TJavaGenericImport<JOpenFileIntentSenderRequestClass, JOpenFileIntentSenderRequest>) end;

  JQueryRequestClass = interface(JObjectClass)
    ['{63B50DDA-5E95-4B2C-853E-00D4C93A7AE6}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(query: JQuery): JQueryRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/QueryRequest')]
  JQueryRequest = interface(JObject)
    ['{9530A37B-7E92-4D4D-AEE4-5C710F01A936}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJQueryRequest = class(TJavaGenericImport<JQueryRequestClass, JQueryRequest>) end;

  JRemoveEventListenerRequestClass = interface(JObjectClass)
    ['{783D58C4-C9BC-4DB3-8999-0A50B3487953}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(id: JDriveId; eventType: Integer): JRemoveEventListenerRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/RemoveEventListenerRequest')]
  JRemoveEventListenerRequest = interface(JObject)
    ['{A8153B3F-998A-4A95-88BF-FF6C5CA94CAB}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJRemoveEventListenerRequest = class(TJavaGenericImport<JRemoveEventListenerRequestClass, JRemoveEventListenerRequest>) end;

  JTrashResourceRequestClass = interface(JObjectClass)
    ['{D2456860-25F7-4A04-9AD3-2DDAE58BDA91}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/TrashResourceRequest')]
  JTrashResourceRequest = interface(JObject)
    ['{EEA4D549-6D68-4CEA-BA9A-EF7A2265FC19}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJTrashResourceRequest = class(TJavaGenericImport<JTrashResourceRequestClass, JTrashResourceRequest>) end;

  JUpdateMetadataRequestClass = interface(JObjectClass)
    ['{0A136A14-53D0-463E-B134-DABCB87851B4}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(id: JDriveId; metadataChangeSet: JMetadataBundle): JUpdateMetadataRequest; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/internal/UpdateMetadataRequest')]
  JUpdateMetadataRequest = interface(JObject)
    ['{72E8AB1A-A122-4191-A116-46F7FC5B9301}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJUpdateMetadataRequest = class(TJavaGenericImport<JUpdateMetadataRequestClass, JUpdateMetadataRequest>) end;

  JMetadataFieldClass = interface(JObjectClass)
    ['{F402C732-DD6A-4D5C-AFF4-7CA37A851B59}']
  end;

  [JavaSignature('com/google/android/gms/drive/metadata/MetadataField')]
  JMetadataField = interface(JObject)
    ['{16D67F4D-AAC3-4270-BADE-E267954B5884}']
    procedure a(P1: JObject; P2: JBundle); cdecl; overload;
    procedure a(P1: JDataHolder; P2: JMetadataBundle; P3: Integer; P4: Integer); cdecl; overload;
    function c(P1: JDataHolder; P2: Integer; P3: Integer): JObject; cdecl;
    function d(P1: JBundle): JObject; cdecl;
    function ff: JCollection; cdecl;
    function getName: JString; cdecl;
    function getVersionAdded: Integer; cdecl;
    function toString: JString; cdecl;
  end;
  TJMetadataField = class(TJavaGenericImport<JMetadataFieldClass, JMetadataField>) end;

  JCollectionMetadataFieldClass = interface(JMetadataFieldClass)
    ['{FE77FCD1-3142-4076-8575-D196DC8E9FE3}']
  end;

  [JavaSignature('com/google/android/gms/drive/metadata/CollectionMetadataField')]
  JCollectionMetadataField = interface(JMetadataField)
    ['{6EA59CB7-FF75-44EA-812E-101E6E902971}']
  end;
  TJCollectionMetadataField = class(TJavaGenericImport<JCollectionMetadataFieldClass, JCollectionMetadataField>) end;

  JOrderedMetadataFieldClass = interface(JMetadataFieldClass)
    ['{0E58ED4B-1EC5-4960-A79F-58770C856663}']
  end;

  [JavaSignature('com/google/android/gms/drive/metadata/OrderedMetadataField')]
  JOrderedMetadataField = interface(JMetadataField)
    ['{4D4DD38D-3999-4C7C-A4B6-BBAFB5F6719F}']
  end;
  TJOrderedMetadataField = class(TJavaGenericImport<JOrderedMetadataFieldClass, JOrderedMetadataField>) end;

  JMetadataBundleClass = interface(JObjectClass)
    ['{EEE83F1D-F47E-4D81-A158-D65BD519F6D7}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function a(P1: JMetadataBundle): JMetadataBundle; cdecl; overload;
    {class} function a(P1: JMetadataField; P2: JObject): JMetadataBundle; cdecl; overload;
    {class} function fh: JMetadataBundle; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/metadata/internal/MetadataBundle')]
  JMetadataBundle = interface(JObject)
    ['{14855C10-FC06-4A7C-8964-CF7BE2AF9BF0}']
    function a(P1: JMetadataField): JObject; cdecl; overload;
    procedure b(P1: JMetadataField; P2: JObject); cdecl;
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function fi: JSet; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJMetadataBundle = class(TJavaGenericImport<JMetadataBundleClass, JMetadataBundle>) end;

  Jquery_FilterClass = interface(IJavaClass)
    ['{1B69C288-A174-4723-8D53-1121EC0DC54A}']
  end;

  [JavaSignature('com/google/android/gms/drive/query/Filter')]
  Jquery_Filter = interface(IJavaInstance)
    ['{D73EA95A-3C8E-4E6F-8590-EED8625D80BC}']
  end;
  TJquery_Filter = class(TJavaGenericImport<Jquery_FilterClass, Jquery_Filter>) end;

  JFiltersClass = interface(JObjectClass)
    ['{2437EB61-FF1B-41C0-BC21-9F905D7A4813}']
    {class} function &and(filters: JIterable): Jquery_Filter; cdecl; overload;
    {class} function &and(filter: Jquery_Filter; additionalFilters: TJavaObjectArray<Jquery_Filter>): Jquery_Filter; cdecl; overload;
    {class} function &contains(field: JMetadataField; value: JString): Jquery_Filter; cdecl;
    {class} function eq(field: JMetadataField; value: JObject): Jquery_Filter; cdecl;
    {class} function greaterThan(field: JOrderedMetadataField; value: JComparable): Jquery_Filter; cdecl;
    {class} function greaterThanEquals(field: JOrderedMetadataField; value: JComparable): Jquery_Filter; cdecl;
    {class} function &in(field: JCollectionMetadataField; value: JObject): Jquery_Filter; cdecl;
    {class} function init: JFilters; cdecl;
    {class} function lessThan(field: JOrderedMetadataField; value: JComparable): Jquery_Filter; cdecl;
    {class} function lessThanEquals(field: JOrderedMetadataField; value: JComparable): Jquery_Filter; cdecl;
    {class} function &not(toNegate: Jquery_Filter): Jquery_Filter; cdecl;
    {class} function &or(filters: JIterable): Jquery_Filter; cdecl; overload;
    {class} function &or(filter: Jquery_Filter; additionalFilters: TJavaObjectArray<Jquery_Filter>): Jquery_Filter; cdecl; overload;
    {class} function sharedWithMe: Jquery_Filter; cdecl;
  end;

  [JavaSignature('com/google/android/gms/drive/query/Filters')]
  JFilters = interface(JObject)
    ['{8E0DC4EE-D01C-494F-825E-E583D9E57E62}']
  end;
  TJFilters = class(TJavaGenericImport<JFiltersClass, JFilters>) end;

  JQueryClass = interface(JObjectClass)
    ['{C6580A44-7023-4873-BA6B-DB0DFCFFD7DC}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/query/Query')]
  JQuery = interface(JObject)
    ['{6A47F39B-DDB1-4348-A52D-A8309CE8AA3D}']
    function describeContents: Integer; cdecl;
    function getFilter: Jquery_Filter; cdecl;
    function getPageToken: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJQuery = class(TJavaGenericImport<JQueryClass, JQuery>) end;

  JQuery_BuilderClass = interface(JObjectClass)
    ['{611286E5-5A78-4ABD-A343-66E41CD4C174}']
    {class} function init: JQuery_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/drive/query/Query$Builder')]
  JQuery_Builder = interface(JObject)
    ['{5D0255C7-F968-4DDB-9FA0-2B9F81052BB7}']
    function addFilter(filter: Jquery_Filter): JQuery_Builder; cdecl;
    function build: JQuery; cdecl;
    function setPageToken(token: JString): JQuery_Builder; cdecl;
  end;
  TJQuery_Builder = class(TJavaGenericImport<JQuery_BuilderClass, JQuery_Builder>) end;

  JSearchableFieldClass = interface(JObjectClass)
    ['{67D12463-603F-439D-AAFE-5025EAFD3EA0}']
    {class} function _GetEH: JOrderedMetadataField; cdecl;
    {class} function _GetIS_PINNED: JMetadataField; cdecl;
    {class} function _GetLAST_VIEWED_BY_ME: JOrderedMetadataField; cdecl;
    {class} function _GetMIME_TYPE: JMetadataField; cdecl;
    {class} function _GetMODIFIED_DATE: JOrderedMetadataField; cdecl;
    {class} function _GetPARENTS: JCollectionMetadataField; cdecl;
    {class} function _GetSTARRED: JMetadataField; cdecl;
    {class} function _GetTITLE: JMetadataField; cdecl;
    {class} function _GetTRASHED: JMetadataField; cdecl;
    {class} function init: JSearchableField; cdecl;
    {class} property EH: JOrderedMetadataField read _GetEH;
    {class} property IS_PINNED: JMetadataField read _GetIS_PINNED;
    {class} property LAST_VIEWED_BY_ME: JOrderedMetadataField read _GetLAST_VIEWED_BY_ME;
    {class} property MIME_TYPE: JMetadataField read _GetMIME_TYPE;
    {class} property MODIFIED_DATE: JOrderedMetadataField read _GetMODIFIED_DATE;
    {class} property PARENTS: JCollectionMetadataField read _GetPARENTS;
    {class} property STARRED: JMetadataField read _GetSTARRED;
    {class} property TITLE: JMetadataField read _GetTITLE;
    {class} property TRASHED: JMetadataField read _GetTRASHED;
  end;

  [JavaSignature('com/google/android/gms/drive/query/SearchableField')]
  JSearchableField = interface(JObject)
    ['{A16B38F0-A447-4AC2-A814-A7C9EDDEA423}']
  end;
  TJSearchableField = class(TJavaGenericImport<JSearchableFieldClass, JSearchableField>) end;

  JComparisonFilterClass = interface(JObjectClass)
    ['{E534AF17-32C2-4A35-A108-F7D9363CB21F}']
    {class} //function _GetCREATOR: Jquery_internal_a; cdecl;
    {class} function init(operator: JOperator; field: JMetadataField; value: JObject): JComparisonFilter; cdecl; overload;
    {class} //property CREATOR: Jquery_internal_a read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/query/internal/ComparisonFilter')]
  JComparisonFilter = interface(JObject)
    ['{1693B63E-62D3-41A2-BCB7-AE647C66BBD4}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJComparisonFilter = class(TJavaGenericImport<JComparisonFilterClass, JComparisonFilter>) end;

  JFieldOnlyFilterClass = interface(JObjectClass)
    ['{D89992E0-8BE0-4CF9-9787-F6B6054D2F30}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(field: JMetadataField): JFieldOnlyFilter; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/query/internal/FieldOnlyFilter')]
  JFieldOnlyFilter = interface(JObject)
    ['{3B75FB2F-9AA0-4A66-861A-A82E7526E64C}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJFieldOnlyFilter = class(TJavaGenericImport<JFieldOnlyFilterClass, JFieldOnlyFilter>) end;

  JFilterHolderClass = interface(JObjectClass)
    ['{5FCE4FFB-50BB-4E71-A49F-1F683F1BA27D}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(filter: Jquery_Filter): JFilterHolder; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/query/internal/FilterHolder')]
  JFilterHolder = interface(JObject)
    ['{E5AB07D1-BD87-4E4C-9CB9-10814214DB90}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJFilterHolder = class(TJavaGenericImport<JFilterHolderClass, JFilterHolder>) end;

  JInFilterClass = interface(JObjectClass)
    ['{1F3C0AED-0409-414F-8873-176A380B2C34}']
    {class} //function _GetCREATOR: Jquery_internal_e; cdecl;
    {class} function init(field: JCollectionMetadataField; value: JObject): JInFilter; cdecl; overload;
    {class} //property CREATOR: Jquery_internal_e read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/query/internal/InFilter')]
  JInFilter = interface(JObject)
    ['{CDD012EE-98B2-488F-BADB-72DD701F7947}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJInFilter = class(TJavaGenericImport<JInFilterClass, JInFilter>) end;

  JLogicalFilterClass = interface(JObjectClass)
    ['{5D123374-D8BB-44E2-A769-49DBFC5D22C4}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(operator: JOperator; filters: JIterable): JLogicalFilter; cdecl; overload;
    {class} function init(operator: JOperator; filter: Jquery_Filter; additionalFilters: TJavaObjectArray<Jquery_Filter>): JLogicalFilter; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/query/internal/LogicalFilter')]
  JLogicalFilter = interface(JObject)
    ['{827965A6-B044-4654-82A6-7ED005813BC0}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJLogicalFilter = class(TJavaGenericImport<JLogicalFilterClass, JLogicalFilter>) end;

  JNotFilterClass = interface(JObjectClass)
    ['{90D2D15A-3474-47CE-9653-059D3B3194C3}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(toNegate: Jquery_Filter): JNotFilter; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/drive/query/internal/NotFilter')]
  JNotFilter = interface(JObject)
    ['{918A49B6-E3CF-475D-9F03-DFB5906F6D3B}']
    function describeContents: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJNotFilter = class(TJavaGenericImport<JNotFilterClass, JNotFilter>) end;

  JOperatorClass = interface(JObjectClass)
    ['{644B403B-5A04-4DCF-86F4-9B679876374C}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFa: JOperator; cdecl;
    {class} function _GetFb: JOperator; cdecl;
    {class} function _GetFc: JOperator; cdecl;
    {class} function _GetFd: JOperator; cdecl;
    {class} function _GetFe: JOperator; cdecl;
    {class} function _GetFf: JOperator; cdecl;
    {class} function _GetFg: JOperator; cdecl;
    {class} function _GetFh: JOperator; cdecl;
    {class} function _GetFi: JOperator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property Fa: JOperator read _GetFa;
    {class} property Fb: JOperator read _GetFb;
    {class} property Fc: JOperator read _GetFc;
    {class} property Fd: JOperator read _GetFd;
    {class} property Fe: JOperator read _GetFe;
    {class} property Ff: JOperator read _GetFf;
    {class} property Fg: JOperator read _GetFg;
    {class} property Fh: JOperator read _GetFh;
    {class} property Fi: JOperator read _GetFi;
  end;

  [JavaSignature('com/google/android/gms/drive/query/internal/Operator')]
  JOperator = interface(JObject)
    ['{5495FF92-5AA0-4269-A97D-4A158942B6D6}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJOperator = class(TJavaGenericImport<JOperatorClass, JOperator>) end;

  JDataBufferAdapterClass = interface(JBaseAdapterClass)
    ['{D80F64FA-24B0-4D69-A00D-54490FBF7E2B}']
    {class} function init(context: JContext; resource: Integer): JDataBufferAdapter; cdecl; overload;
    {class} function init(context: JContext; resource: Integer; buffers: TJavaObjectArray<JDataBuffer>): JDataBufferAdapter; cdecl; overload;
    {class} function init(context: JContext; resource: Integer; objects: JList): JDataBufferAdapter; cdecl; overload;
    {class} function init(context: JContext; resource: Integer; textViewResourceId: Integer): JDataBufferAdapter; cdecl; overload;
    {class} function init(context: JContext; resource: Integer; textViewResourceId: Integer; buffers: TJavaObjectArray<JDataBuffer>): JDataBufferAdapter; cdecl; overload;
    {class} function init(context: JContext; resource: Integer; textViewResourceId: Integer; objects: JList): JDataBufferAdapter; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/drive/widget/DataBufferAdapter')]
  JDataBufferAdapter = interface(JBaseAdapter)
    ['{B785E4FF-C57F-43A3-8C48-B2B6F18ED520}']
    procedure append(buffer: JDataBuffer); cdecl;
    procedure clear; cdecl;
    function getContext: JContext; cdecl;
    function getCount: Integer; cdecl;
    function getDropDownView(position: Integer; convertView: JView; parent: JViewGroup): JView; cdecl;
    function getItem(position: Integer): JObject; cdecl;
    function getItemId(position: Integer): Int64; cdecl;
    function getView(position: Integer; convertView: JView; parent: JViewGroup): JView; cdecl;
    procedure notifyDataSetChanged; cdecl;
    procedure setDropDownViewResource(resource: Integer); cdecl;
    procedure setNotifyOnChange(notifyOnChange: Boolean); cdecl;
  end;
  TJDataBufferAdapter = class(TJavaGenericImport<JDataBufferAdapterClass, JDataBufferAdapter>) end;

  JLifecycleDelegateClass = interface(IJavaClass)
    ['{93A34221-28BF-4077-B5D5-49BA16213C08}']
  end;

  [JavaSignature('com/google/android/gms/dynamic/LifecycleDelegate')]
  JLifecycleDelegate = interface(IJavaInstance)
    ['{B7E98D3B-4DBE-4ED7-8BB5-0903FBE53E25}']
    procedure onCreate(P1: JBundle); cdecl;
    function onCreateView(P1: JLayoutInflater; P2: JViewGroup; P3: JBundle): JView; cdecl;
    procedure onDestroy; cdecl;
    procedure onDestroyView; cdecl;
    procedure onInflate(P1: JActivity; P2: JBundle; P3: JBundle); cdecl;
    procedure onLowMemory; cdecl;
    procedure onPause; cdecl;
    procedure onResume; cdecl;
    procedure onSaveInstanceState(P1: JBundle); cdecl;
    procedure onStart; cdecl;
    procedure onStop; cdecl;
  end;
  TJLifecycleDelegate = class(TJavaGenericImport<JLifecycleDelegateClass, JLifecycleDelegate>) end;

  JGameClass = interface(JParcelableClass)
    ['{5361CB92-B217-41D2-A914-E3E8F3A87693}']
  end;

  [JavaSignature('com/google/android/gms/games/Game')]
  JGame = interface(JParcelable)
    ['{2A83D53C-79C0-44CC-93B8-ECD4B0F08230}']
    function getAchievementTotalCount: Integer; cdecl;
    function getApplicationId: JString; cdecl;
    function getDescription: JString; cdecl; overload;
    procedure getDescription(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getDeveloperName: JString; cdecl; overload;
    procedure getDeveloperName(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getDisplayName: JString; cdecl; overload;
    procedure getDisplayName(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getFeaturedImageUri: Jnet_Uri; cdecl;
    function getFeaturedImageUrl: JString; cdecl;
    function getGameplayAclStatus: Integer; cdecl;
    function getHiResImageUri: Jnet_Uri; cdecl;
    function getHiResImageUrl: JString; cdecl;
    function getIconImageUri: Jnet_Uri; cdecl;
    function getIconImageUrl: JString; cdecl;
    function getInstancePackageName: JString; cdecl;
    function getLeaderboardCount: Integer; cdecl;
    function getPrimaryCategory: JString; cdecl;
    function getSecondaryCategory: JString; cdecl;
    function isInstanceInstalled: Boolean; cdecl;
    function isMuted: Boolean; cdecl;
    function isPlayEnabledGame: Boolean; cdecl;
    function isRealTimeMultiplayerEnabled: Boolean; cdecl;
    function isTurnBasedMultiplayerEnabled: Boolean; cdecl;
  end;
  TJGame = class(TJavaGenericImport<JGameClass, JGame>) end;

  JGameBufferClass = interface(JDataBufferClass)
    ['{C55FFCFE-4032-4AA2-B0DF-15E3988DE884}']
    {class} function init(dataHolder: JDataHolder): JGameBuffer; cdecl;
  end;

  [JavaSignature('com/google/android/gms/games/GameBuffer')]
  JGameBuffer = interface(JDataBuffer)
    ['{E2BDBCD5-6EF6-4F2B-B81D-215B1B3DB8F0}']
    function &get(position: Integer): JGame; cdecl;
  end;
  TJGameBuffer = class(TJavaGenericImport<JGameBufferClass, JGameBuffer>) end;

  // com.google.android.gms.games.GameEntity
  // com.google.android.gms.games.GameEntity$a
  JGamesClass = interface(JObjectClass)
    ['{269C54DC-B954-464E-9ECB-61D4A60D1536}']
    {class} //function _GetAPI: JApi; cdecl;
    {class} function _GetAchievements: JAchievements; cdecl;
    {class} function _GetEXTRA_PLAYER_IDS: JString; cdecl;
    {class} function _GetFY: JScope; cdecl;
    {class} //function _GetFZ: JApi; cdecl;
    {class} function _GetGa: JMultiplayer; cdecl;
    {class} function _GetGamesMetadata: JGamesMetadata; cdecl;
    {class} //function _GetGb: Jgw; cdecl;
    {class} function _GetInvitations: JInvitations; cdecl;
    {class} function _GetLeaderboards: JLeaderboards; cdecl;
    {class} function _GetNotifications: JNotifications; cdecl;
    {class} function _GetPlayers: JPlayers; cdecl;
    {class} function _GetRealTimeMultiplayer: JRealTimeMultiplayer; cdecl;
    {class} function _GetRequests: JRequests; cdecl;
    {class} function _GetSCOPE_GAMES: JScope; cdecl;
    {class} function _GetTurnBasedMultiplayer: JTurnBasedMultiplayer; cdecl;
    {class} //function c(P1: JGoogleApiClient): Jfx; cdecl;
    {class} function getAppId(apiClient: JGoogleApiClient): JString; cdecl;
    {class} function getCurrentAccountName(apiClient: JGoogleApiClient): JString; cdecl;
    {class} function getSdkVariant(apiClient: JGoogleApiClient): Integer; cdecl;
    {class} function getSettingsIntent(apiClient: JGoogleApiClient): JIntent; cdecl;
    {class} procedure setGravityForPopups(apiClient: JGoogleApiClient; gravity: Integer); cdecl;
    {class} procedure setViewForPopups(apiClient: JGoogleApiClient; gamesContentView: JView); cdecl;
    {class} function signOut(apiClient: JGoogleApiClient): JPendingResult; cdecl;
    {class} //property API: JApi read _GetAPI;
    {class} property Achievements: JAchievements read _GetAchievements;
    {class} property EXTRA_PLAYER_IDS: JString read _GetEXTRA_PLAYER_IDS;
    {class} property FY: JScope read _GetFY;
    {class} //property FZ: JApi read _GetFZ;
    {class} property Ga: JMultiplayer read _GetGa;
    {class} property GamesMetadata: JGamesMetadata read _GetGamesMetadata;
    {class} //property Gb: Jgw read _GetGb;
    {class} property Invitations: JInvitations read _GetInvitations;
    {class} property Leaderboards: JLeaderboards read _GetLeaderboards;
    {class} property Notifications: JNotifications read _GetNotifications;
    {class} property Players: JPlayers read _GetPlayers;
    {class} property RealTimeMultiplayer: JRealTimeMultiplayer read _GetRealTimeMultiplayer;
    {class} property Requests: JRequests read _GetRequests;
    {class} property SCOPE_GAMES: JScope read _GetSCOPE_GAMES;
    {class} property TurnBasedMultiplayer: JTurnBasedMultiplayer read _GetTurnBasedMultiplayer;
  end;

  [JavaSignature('com/google/android/gms/games/Games')]
  JGames = interface(JObject)
    ['{87631019-8EEA-40B4-84F3-2697344780EF}']
  end;
  TJGames = class(TJavaGenericImport<JGamesClass, JGames>) end;

  JGames_GamesOptionsClass = interface(JObjectClass)
    ['{7D29AA6B-95BE-4B8D-952D-1E474669D4BA}']
    {class} function builder: JGamesOptions_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/games/Games$GamesOptions')]
  JGames_GamesOptions = interface(JObject)
    ['{B2AB64B4-920E-4F48-B9E2-6290F83D31EA}']
  end;
  TJGames_GamesOptions = class(TJavaGenericImport<JGames_GamesOptionsClass, JGames_GamesOptions>) end;

  JGamesOptions_BuilderClass = interface(JObjectClass)
    ['{F3DCA98E-BCDA-40D4-AC8C-C4DF603880ED}']
  end;

  [JavaSignature('com/google/android/gms/games/Games$GamesOptions$Builder')]
  JGamesOptions_Builder = interface(JObject)
    ['{1D7C7B1B-8A96-4F7D-B42A-A4A9AE86448A}']
    function build: JGames_GamesOptions; cdecl;
    function setSdkVariant(variant: Integer): JGamesOptions_Builder; cdecl;
    function setShowConnectingPopup(showConnectingPopup: Boolean): JGamesOptions_Builder; cdecl; overload;
    function setShowConnectingPopup(showConnectingPopup: Boolean; gravity: Integer): JGamesOptions_Builder; cdecl; overload;
  end;
  TJGamesOptions_Builder = class(TJavaGenericImport<JGamesOptions_BuilderClass, JGamesOptions_Builder>) end;

  JGamesActivityResultCodesClass = interface(JObjectClass)
    ['{418F14A8-CD7D-4B64-9DBC-83742127DE67}']
    {class} function _GetRESULT_APP_MISCONFIGURED: Integer; cdecl;
    {class} function _GetRESULT_LEFT_ROOM: Integer; cdecl;
    {class} function _GetRESULT_LICENSE_FAILED: Integer; cdecl;
    {class} function _GetRESULT_NETWORK_FAILURE: Integer; cdecl;
    {class} function _GetRESULT_RECONNECT_REQUIRED: Integer; cdecl;
    {class} function _GetRESULT_SEND_REQUEST_FAILED: Integer; cdecl;
    {class} function _GetRESULT_SIGN_IN_FAILED: Integer; cdecl;
    {class} property RESULT_APP_MISCONFIGURED: Integer read _GetRESULT_APP_MISCONFIGURED;
    {class} property RESULT_LEFT_ROOM: Integer read _GetRESULT_LEFT_ROOM;
    {class} property RESULT_LICENSE_FAILED: Integer read _GetRESULT_LICENSE_FAILED;
    {class} property RESULT_NETWORK_FAILURE: Integer read _GetRESULT_NETWORK_FAILURE;
    {class} property RESULT_RECONNECT_REQUIRED: Integer read _GetRESULT_RECONNECT_REQUIRED;
    {class} property RESULT_SEND_REQUEST_FAILED: Integer read _GetRESULT_SEND_REQUEST_FAILED;
    {class} property RESULT_SIGN_IN_FAILED: Integer read _GetRESULT_SIGN_IN_FAILED;
  end;

  [JavaSignature('com/google/android/gms/games/GamesActivityResultCodes')]
  JGamesActivityResultCodes = interface(JObject)
    ['{1EB938AF-A0DC-4815-9D6A-E8A725450A25}']
  end;
  TJGamesActivityResultCodes = class(TJavaGenericImport<JGamesActivityResultCodesClass, JGamesActivityResultCodes>) end;

  JGamesMetadataClass = interface(IJavaClass)
    ['{631F557C-E7AF-4D5F-80BE-373E1A9BBBE6}']
  end;

  [JavaSignature('com/google/android/gms/games/GamesMetadata')]
  JGamesMetadata = interface(IJavaInstance)
    ['{428FE66C-F594-4302-AF4E-26F56160799D}']
    function getCurrentGame(P1: JGoogleApiClient): JGame; cdecl;
    function loadGame(P1: JGoogleApiClient): JPendingResult; cdecl;
  end;
  TJGamesMetadata = class(TJavaGenericImport<JGamesMetadataClass, JGamesMetadata>) end;

  JGamesMetadata_LoadGamesResultClass = interface(JReleasableClass)
    ['{EB4CEA92-E1D3-4264-B8E8-22E6ECD69CDF}']
  end;

  [JavaSignature('com/google/android/gms/games/GamesMetadata$LoadGamesResult')]
  JGamesMetadata_LoadGamesResult = interface(JReleasable)
    ['{1C72A026-D3AD-4ACD-8588-13AF795847D0}']
    function getGames: JGameBuffer; cdecl;
  end;
  TJGamesMetadata_LoadGamesResult = class(TJavaGenericImport<JGamesMetadata_LoadGamesResultClass, JGamesMetadata_LoadGamesResult>) end;

  JGamesStatusCodesClass = interface(JObjectClass)
    ['{DE1E7929-5A2D-47C0-8075-13A92BD5283F}']
    {class} function _GetSTATUS_ACHIEVEMENT_NOT_INCREMENTAL: Integer; cdecl;
    {class} function _GetSTATUS_ACHIEVEMENT_UNKNOWN: Integer; cdecl;
    {class} function _GetSTATUS_ACHIEVEMENT_UNLOCKED: Integer; cdecl;
    {class} function _GetSTATUS_ACHIEVEMENT_UNLOCK_FAILURE: Integer; cdecl;
    {class} function _GetSTATUS_APP_MISCONFIGURED: Integer; cdecl;
    {class} function _GetSTATUS_CLIENT_RECONNECT_REQUIRED: Integer; cdecl;
    {class} function _GetSTATUS_GAME_NOT_FOUND: Integer; cdecl;
    {class} function _GetSTATUS_INTERNAL_ERROR: Integer; cdecl;
    {class} function _GetSTATUS_INTERRUPTED: Integer; cdecl;
    {class} function _GetSTATUS_INVALID_REAL_TIME_ROOM_ID: Integer; cdecl;
    {class} function _GetSTATUS_LICENSE_CHECK_FAILED: Integer; cdecl;
    {class} function _GetSTATUS_MATCH_ERROR_ALREADY_REMATCHED: Integer; cdecl;
    {class} function _GetSTATUS_MATCH_ERROR_INACTIVE_MATCH: Integer; cdecl;
    {class} function _GetSTATUS_MATCH_ERROR_INVALID_MATCH_RESULTS: Integer; cdecl;
    {class} function _GetSTATUS_MATCH_ERROR_INVALID_MATCH_STATE: Integer; cdecl;
    {class} function _GetSTATUS_MATCH_ERROR_INVALID_PARTICIPANT_STATE: Integer; cdecl;
    {class} function _GetSTATUS_MATCH_ERROR_LOCALLY_MODIFIED: Integer; cdecl;
    {class} function _GetSTATUS_MATCH_ERROR_OUT_OF_DATE_VERSION: Integer; cdecl;
    {class} function _GetSTATUS_MATCH_NOT_FOUND: Integer; cdecl;
    {class} function _GetSTATUS_MULTIPLAYER_DISABLED: Integer; cdecl;
    {class} function _GetSTATUS_MULTIPLAYER_ERROR_CREATION_NOT_ALLOWED: Integer; cdecl;
    {class} function _GetSTATUS_MULTIPLAYER_ERROR_INVALID_MULTIPLAYER_TYPE: Integer; cdecl;
    {class} function _GetSTATUS_MULTIPLAYER_ERROR_INVALID_OPERATION: Integer; cdecl;
    {class} function _GetSTATUS_MULTIPLAYER_ERROR_NOT_TRUSTED_TESTER: Integer; cdecl;
    {class} function _GetSTATUS_NETWORK_ERROR_NO_DATA: Integer; cdecl;
    {class} function _GetSTATUS_NETWORK_ERROR_OPERATION_DEFERRED: Integer; cdecl;
    {class} function _GetSTATUS_NETWORK_ERROR_OPERATION_FAILED: Integer; cdecl;
    {class} function _GetSTATUS_NETWORK_ERROR_STALE_DATA: Integer; cdecl;
    {class} function _GetSTATUS_OK: Integer; cdecl;
    {class} function _GetSTATUS_OPERATION_IN_FLIGHT: Integer; cdecl;
    {class} function _GetSTATUS_PARTICIPANT_NOT_CONNECTED: Integer; cdecl;
    {class} function _GetSTATUS_REAL_TIME_CONNECTION_FAILED: Integer; cdecl;
    {class} function _GetSTATUS_REAL_TIME_INACTIVE_ROOM: Integer; cdecl;
    {class} function _GetSTATUS_REAL_TIME_MESSAGE_SEND_FAILED: Integer; cdecl;
    {class} function _GetSTATUS_REAL_TIME_ROOM_NOT_JOINED: Integer; cdecl;
    {class} function _GetSTATUS_REQUEST_UPDATE_PARTIAL_SUCCESS: Integer; cdecl;
    {class} function _GetSTATUS_REQUEST_UPDATE_TOTAL_FAILURE: Integer; cdecl;
    {class} function _GetSTATUS_TIMEOUT: Integer; cdecl;
    {class} property STATUS_ACHIEVEMENT_NOT_INCREMENTAL: Integer read _GetSTATUS_ACHIEVEMENT_NOT_INCREMENTAL;
    {class} property STATUS_ACHIEVEMENT_UNKNOWN: Integer read _GetSTATUS_ACHIEVEMENT_UNKNOWN;
    {class} property STATUS_ACHIEVEMENT_UNLOCKED: Integer read _GetSTATUS_ACHIEVEMENT_UNLOCKED;
    {class} property STATUS_ACHIEVEMENT_UNLOCK_FAILURE: Integer read _GetSTATUS_ACHIEVEMENT_UNLOCK_FAILURE;
    {class} property STATUS_APP_MISCONFIGURED: Integer read _GetSTATUS_APP_MISCONFIGURED;
    {class} property STATUS_CLIENT_RECONNECT_REQUIRED: Integer read _GetSTATUS_CLIENT_RECONNECT_REQUIRED;
    {class} property STATUS_GAME_NOT_FOUND: Integer read _GetSTATUS_GAME_NOT_FOUND;
    {class} property STATUS_INTERNAL_ERROR: Integer read _GetSTATUS_INTERNAL_ERROR;
    {class} property STATUS_INTERRUPTED: Integer read _GetSTATUS_INTERRUPTED;
    {class} property STATUS_INVALID_REAL_TIME_ROOM_ID: Integer read _GetSTATUS_INVALID_REAL_TIME_ROOM_ID;
    {class} property STATUS_LICENSE_CHECK_FAILED: Integer read _GetSTATUS_LICENSE_CHECK_FAILED;
    {class} property STATUS_MATCH_ERROR_ALREADY_REMATCHED: Integer read _GetSTATUS_MATCH_ERROR_ALREADY_REMATCHED;
    {class} property STATUS_MATCH_ERROR_INACTIVE_MATCH: Integer read _GetSTATUS_MATCH_ERROR_INACTIVE_MATCH;
    {class} property STATUS_MATCH_ERROR_INVALID_MATCH_RESULTS: Integer read _GetSTATUS_MATCH_ERROR_INVALID_MATCH_RESULTS;
    {class} property STATUS_MATCH_ERROR_INVALID_MATCH_STATE: Integer read _GetSTATUS_MATCH_ERROR_INVALID_MATCH_STATE;
    {class} property STATUS_MATCH_ERROR_INVALID_PARTICIPANT_STATE: Integer read _GetSTATUS_MATCH_ERROR_INVALID_PARTICIPANT_STATE;
    {class} property STATUS_MATCH_ERROR_LOCALLY_MODIFIED: Integer read _GetSTATUS_MATCH_ERROR_LOCALLY_MODIFIED;
    {class} property STATUS_MATCH_ERROR_OUT_OF_DATE_VERSION: Integer read _GetSTATUS_MATCH_ERROR_OUT_OF_DATE_VERSION;
    {class} property STATUS_MATCH_NOT_FOUND: Integer read _GetSTATUS_MATCH_NOT_FOUND;
    {class} property STATUS_MULTIPLAYER_DISABLED: Integer read _GetSTATUS_MULTIPLAYER_DISABLED;
    {class} property STATUS_MULTIPLAYER_ERROR_CREATION_NOT_ALLOWED: Integer read _GetSTATUS_MULTIPLAYER_ERROR_CREATION_NOT_ALLOWED;
    {class} property STATUS_MULTIPLAYER_ERROR_INVALID_MULTIPLAYER_TYPE: Integer read _GetSTATUS_MULTIPLAYER_ERROR_INVALID_MULTIPLAYER_TYPE;
    {class} property STATUS_MULTIPLAYER_ERROR_INVALID_OPERATION: Integer read _GetSTATUS_MULTIPLAYER_ERROR_INVALID_OPERATION;
    {class} property STATUS_MULTIPLAYER_ERROR_NOT_TRUSTED_TESTER: Integer read _GetSTATUS_MULTIPLAYER_ERROR_NOT_TRUSTED_TESTER;
    {class} property STATUS_NETWORK_ERROR_NO_DATA: Integer read _GetSTATUS_NETWORK_ERROR_NO_DATA;
    {class} property STATUS_NETWORK_ERROR_OPERATION_DEFERRED: Integer read _GetSTATUS_NETWORK_ERROR_OPERATION_DEFERRED;
    {class} property STATUS_NETWORK_ERROR_OPERATION_FAILED: Integer read _GetSTATUS_NETWORK_ERROR_OPERATION_FAILED;
    {class} property STATUS_NETWORK_ERROR_STALE_DATA: Integer read _GetSTATUS_NETWORK_ERROR_STALE_DATA;
    {class} property STATUS_OK: Integer read _GetSTATUS_OK;
    {class} property STATUS_OPERATION_IN_FLIGHT: Integer read _GetSTATUS_OPERATION_IN_FLIGHT;
    {class} property STATUS_PARTICIPANT_NOT_CONNECTED: Integer read _GetSTATUS_PARTICIPANT_NOT_CONNECTED;
    {class} property STATUS_REAL_TIME_CONNECTION_FAILED: Integer read _GetSTATUS_REAL_TIME_CONNECTION_FAILED;
    {class} property STATUS_REAL_TIME_INACTIVE_ROOM: Integer read _GetSTATUS_REAL_TIME_INACTIVE_ROOM;
    {class} property STATUS_REAL_TIME_MESSAGE_SEND_FAILED: Integer read _GetSTATUS_REAL_TIME_MESSAGE_SEND_FAILED;
    {class} property STATUS_REAL_TIME_ROOM_NOT_JOINED: Integer read _GetSTATUS_REAL_TIME_ROOM_NOT_JOINED;
    {class} property STATUS_REQUEST_UPDATE_PARTIAL_SUCCESS: Integer read _GetSTATUS_REQUEST_UPDATE_PARTIAL_SUCCESS;
    {class} property STATUS_REQUEST_UPDATE_TOTAL_FAILURE: Integer read _GetSTATUS_REQUEST_UPDATE_TOTAL_FAILURE;
    {class} property STATUS_TIMEOUT: Integer read _GetSTATUS_TIMEOUT;
  end;

  [JavaSignature('com/google/android/gms/games/GamesStatusCodes')]
  JGamesStatusCodes = interface(JObject)
    ['{EB8BFF3C-BC22-4FFE-AC43-9CB378D2DEF8}']
  end;
  TJGamesStatusCodes = class(TJavaGenericImport<JGamesStatusCodesClass, JGamesStatusCodes>) end;

  JNotificationsClass = interface(IJavaClass)
    ['{CB6E269B-8FB7-4AF7-845E-9EE2A7BCF3B4}']
    {class} function _GetNOTIFICATION_TYPES_ALL: Integer; cdecl;
    {class} function _GetNOTIFICATION_TYPES_MULTIPLAYER: Integer; cdecl;
    {class} function _GetNOTIFICATION_TYPE_INVITATION: Integer; cdecl;
    {class} function _GetNOTIFICATION_TYPE_MATCH_UPDATE: Integer; cdecl;
    {class} function _GetNOTIFICATION_TYPE_REQUEST: Integer; cdecl;
    {class} property NOTIFICATION_TYPES_ALL: Integer read _GetNOTIFICATION_TYPES_ALL;
    {class} property NOTIFICATION_TYPES_MULTIPLAYER: Integer read _GetNOTIFICATION_TYPES_MULTIPLAYER;
    {class} property NOTIFICATION_TYPE_INVITATION: Integer read _GetNOTIFICATION_TYPE_INVITATION;
    {class} property NOTIFICATION_TYPE_MATCH_UPDATE: Integer read _GetNOTIFICATION_TYPE_MATCH_UPDATE;
    {class} property NOTIFICATION_TYPE_REQUEST: Integer read _GetNOTIFICATION_TYPE_REQUEST;
  end;

  [JavaSignature('com/google/android/gms/games/Notifications')]
  JNotifications = interface(IJavaInstance)
    ['{47A7E2EC-ADA4-4FFF-8C37-B968CDF5A048}']
    procedure clear(P1: JGoogleApiClient; P2: Integer); cdecl;
    procedure clearAll(P1: JGoogleApiClient); cdecl;
  end;
  TJNotifications = class(TJavaGenericImport<JNotificationsClass, JNotifications>) end;

  JPageDirectionClass = interface(JObjectClass)
    ['{79519738-99BE-4131-987E-B1C3E9648B3C}']
    {class} function _GetNEXT: Integer; cdecl;
    {class} function _GetNONE: Integer; cdecl;
    {class} function _GetPREV: Integer; cdecl;
    {class} property NEXT: Integer read _GetNEXT;
    {class} property NONE: Integer read _GetNONE;
    {class} property PREV: Integer read _GetPREV;
  end;

  [JavaSignature('com/google/android/gms/games/PageDirection')]
  JPageDirection = interface(JObject)
    ['{9773AAC5-7C05-4C27-9814-DC5143192F70}']
  end;
  TJPageDirection = class(TJavaGenericImport<JPageDirectionClass, JPageDirection>) end;

  JPlayerClass = interface(JParcelableClass)
    ['{9DB5DC9B-3D32-4FBB-A863-6680D495678F}']
  end;

  [JavaSignature('com/google/android/gms/games/Player')]
  JPlayer = interface(JParcelable)
    ['{C4D9E51B-AAC2-45A6-9C13-6C8CBBBDA3ED}']
    function fl: Integer; cdecl;
    function getDisplayName: JString; cdecl; overload;
    procedure getDisplayName(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getHiResImageUri: Jnet_Uri; cdecl;
    function getHiResImageUrl: JString; cdecl;
    function getIconImageUri: Jnet_Uri; cdecl;
    function getIconImageUrl: JString; cdecl;
    function getLastPlayedWithTimestamp: Int64; cdecl;
    function getPlayerId: JString; cdecl;
    function getRetrievedTimestamp: Int64; cdecl;
    function hasHiResImage: Boolean; cdecl;
    function hasIconImage: Boolean; cdecl;
  end;
  TJPlayer = class(TJavaGenericImport<JPlayerClass, JPlayer>) end;

  JPlayerBufferClass = interface(JDataBufferClass)
    ['{210CFD2D-7964-4993-9337-FD7CBD357CD1}']
    {class} function init(dataHolder: JDataHolder): JPlayerBuffer; cdecl;
  end;

  [JavaSignature('com/google/android/gms/games/PlayerBuffer')]
  JPlayerBuffer = interface(JDataBuffer)
    ['{083864F7-7133-4CA0-B40A-8C8511571054}']
    function &get(position: Integer): JPlayer; cdecl;
  end;
  TJPlayerBuffer = class(TJavaGenericImport<JPlayerBufferClass, JPlayerBuffer>) end;

  // com.google.android.gms.games.PlayerEntity
  JPlayersClass = interface(IJavaClass)
    ['{997DF530-CCA2-4AFF-A5FD-02552539BE3E}']
    {class} function _GetEXTRA_PLAYER_SEARCH_RESULTS: JString; cdecl;
    {class} property EXTRA_PLAYER_SEARCH_RESULTS: JString read _GetEXTRA_PLAYER_SEARCH_RESULTS;
  end;

  [JavaSignature('com/google/android/gms/games/Players')]
  JPlayers = interface(IJavaInstance)
    ['{6EDFECAE-D2BB-41A7-87F1-74D98C6484BC}']
    function getCurrentPlayer(P1: JGoogleApiClient): JPlayer; cdecl;
    function getCurrentPlayerId(P1: JGoogleApiClient): JString; cdecl;
    function getPlayerSearchIntent(P1: JGoogleApiClient): JIntent; cdecl;
    function loadConnectedPlayers(P1: JGoogleApiClient; P2: Boolean): JPendingResult; cdecl;
    function loadInvitablePlayers(P1: JGoogleApiClient; P2: Integer; P3: Boolean): JPendingResult; cdecl;
    function loadMoreInvitablePlayers(P1: JGoogleApiClient; P2: Integer): JPendingResult; cdecl;
    function loadMoreRecentlyPlayedWithPlayers(P1: JGoogleApiClient; P2: Integer): JPendingResult; cdecl;
    function loadPlayer(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
    function loadRecentlyPlayedWithPlayers(P1: JGoogleApiClient; P2: Integer; P3: Boolean): JPendingResult; cdecl;
  end;
  TJPlayers = class(TJavaGenericImport<JPlayersClass, JPlayers>) end;

  JPlayers_LoadPlayersResultClass = interface(JReleasableClass)
    ['{E87493CB-BCD0-415E-9060-0BCE54F28F71}']
  end;

  [JavaSignature('com/google/android/gms/games/Players$LoadPlayersResult')]
  JPlayers_LoadPlayersResult = interface(JReleasable)
    ['{C89D8D08-FC88-477A-BB31-647B5BA24FFB}']
    function getPlayers: JPlayerBuffer; cdecl;
  end;
  TJPlayers_LoadPlayersResult = class(TJavaGenericImport<JPlayers_LoadPlayersResultClass, JPlayers_LoadPlayersResult>) end;

  JAchievementClass = interface(IJavaClass)
    ['{6C078B6F-C3B1-4E2F-8581-0EE09D429939}']
    {class} function _GetSTATE_HIDDEN: Integer; cdecl;
    {class} function _GetSTATE_REVEALED: Integer; cdecl;
    {class} function _GetSTATE_UNLOCKED: Integer; cdecl;
    {class} function _GetTYPE_INCREMENTAL: Integer; cdecl;
    {class} function _GetTYPE_STANDARD: Integer; cdecl;
    {class} property STATE_HIDDEN: Integer read _GetSTATE_HIDDEN;
    {class} property STATE_REVEALED: Integer read _GetSTATE_REVEALED;
    {class} property STATE_UNLOCKED: Integer read _GetSTATE_UNLOCKED;
    {class} property TYPE_INCREMENTAL: Integer read _GetTYPE_INCREMENTAL;
    {class} property TYPE_STANDARD: Integer read _GetTYPE_STANDARD;
  end;

  [JavaSignature('com/google/android/gms/games/achievement/Achievement')]
  JAchievement = interface(IJavaInstance)
    ['{D35D3651-5E50-47C1-89DF-3081A179593F}']
    function getAchievementId: JString; cdecl;
    function getCurrentSteps: Integer; cdecl;
    function getDescription: JString; cdecl; overload;
    procedure getDescription(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getFormattedCurrentSteps: JString; cdecl; overload;
    procedure getFormattedCurrentSteps(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getFormattedTotalSteps: JString; cdecl; overload;
    procedure getFormattedTotalSteps(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getLastUpdatedTimestamp: Int64; cdecl;
    function getName: JString; cdecl; overload;
    procedure getName(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getPlayer: JPlayer; cdecl;
    function getRevealedImageUri: Jnet_Uri; cdecl;
    function getState: Integer; cdecl;
    function getTotalSteps: Integer; cdecl;
    function getType: Integer; cdecl;
    function getUnlockedImageUri: Jnet_Uri; cdecl;
  end;
  TJAchievement = class(TJavaGenericImport<JAchievementClass, JAchievement>) end;

  JAchievementBufferClass = interface(JDataBufferClass)
    ['{14DB1E4E-61BF-4F67-9BC4-A300EB9D88A8}']
    {class} function init(dataHolder: JDataHolder): JAchievementBuffer; cdecl;
  end;

  [JavaSignature('com/google/android/gms/games/achievement/AchievementBuffer')]
  JAchievementBuffer = interface(JDataBuffer)
    ['{F91632A1-72D5-490F-9A8D-244A168006E1}']
    function &get(position: Integer): JAchievement; cdecl;
  end;
  TJAchievementBuffer = class(TJavaGenericImport<JAchievementBufferClass, JAchievementBuffer>) end;

  JAchievementsClass = interface(IJavaClass)
    ['{98E4622F-CC11-4475-89D3-A4F4A8F2691F}']
  end;

  [JavaSignature('com/google/android/gms/games/achievement/Achievements')]
  JAchievements = interface(IJavaInstance)
    ['{E54FE6A0-807F-4F10-8AC1-8B5BF034E4C9}']
    function getAchievementsIntent(P1: JGoogleApiClient): JIntent; cdecl;
    procedure increment(P1: JGoogleApiClient; P2: JString; P3: Integer); cdecl;
    function incrementImmediate(P1: JGoogleApiClient; P2: JString; P3: Integer): JPendingResult; cdecl;
    function load(P1: JGoogleApiClient; P2: Boolean): JPendingResult; cdecl;
    procedure reveal(P1: JGoogleApiClient; P2: JString); cdecl;
    function revealImmediate(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
    procedure setSteps(P1: JGoogleApiClient; P2: JString; P3: Integer); cdecl;
    function setStepsImmediate(P1: JGoogleApiClient; P2: JString; P3: Integer): JPendingResult; cdecl;
    procedure unlock(P1: JGoogleApiClient; P2: JString); cdecl;
    function unlockImmediate(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
  end;
  TJAchievements = class(TJavaGenericImport<JAchievementsClass, JAchievements>) end;

  JAchievements_LoadAchievementsResultClass = interface(JReleasableClass)
    ['{DBF0464C-2C73-43D6-B2E9-F4DA524D818B}']
  end;

  [JavaSignature('com/google/android/gms/games/achievement/Achievements$LoadAchievementsResult')]
  JAchievements_LoadAchievementsResult = interface(JReleasable)
    ['{2453524A-3AAC-44DB-90DA-700254628787}']
    function getAchievements: JAchievementBuffer; cdecl;
  end;
  TJAchievements_LoadAchievementsResult = class(TJavaGenericImport<JAchievements_LoadAchievementsResultClass, JAchievements_LoadAchievementsResult>) end;

  JAchievements_UpdateAchievementResultClass = interface(Japi_ResultClass)
    ['{34994F8B-EF0D-47D2-B3E5-F3E9095DB0AE}']
  end;

  [JavaSignature('com/google/android/gms/games/achievement/Achievements$UpdateAchievementResult')]
  JAchievements_UpdateAchievementResult = interface(Japi_Result)
    ['{1C10661F-8401-40C7-97BB-76780B2E89A3}']
    function getAchievementId: JString; cdecl;
  end;
  TJAchievements_UpdateAchievementResult = class(TJavaGenericImport<JAchievements_UpdateAchievementResultClass, JAchievements_UpdateAchievementResult>) end;

  JLeaderboardClass = interface(JFreezableClass)
    ['{8CB29239-FC13-4DB2-966D-77D576C18DDC}']
    {class} function _GetSCORE_ORDER_LARGER_IS_BETTER: Integer; cdecl;
    {class} function _GetSCORE_ORDER_SMALLER_IS_BETTER: Integer; cdecl;
    {class} property SCORE_ORDER_LARGER_IS_BETTER: Integer read _GetSCORE_ORDER_LARGER_IS_BETTER;
    {class} property SCORE_ORDER_SMALLER_IS_BETTER: Integer read _GetSCORE_ORDER_SMALLER_IS_BETTER;
  end;

  [JavaSignature('com/google/android/gms/games/leaderboard/Leaderboard')]
  JLeaderboard = interface(JFreezable)
    ['{353B79AC-19A2-42D4-AD92-A90808137FC3}']
    function getDisplayName: JString; cdecl; overload;
    procedure getDisplayName(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getGame: JGame; cdecl;
    function getIconImageUri: Jnet_Uri; cdecl;
    function getIconImageUrl: JString; cdecl;
    function getLeaderboardId: JString; cdecl;
    function getScoreOrder: Integer; cdecl;
    function getVariants: JArrayList; cdecl;
  end;
  TJLeaderboard = class(TJavaGenericImport<JLeaderboardClass, JLeaderboard>) end;

  // com.google.android.gms.games.leaderboard.LeaderboardBuffer
  JLeaderboardScoreClass = interface(JFreezableClass)
    ['{0326A2C8-D2D2-4F8D-BE0F-07703BB93916}']
    {class} function _GetLEADERBOARD_RANK_UNKNOWN: Integer; cdecl;
    {class} property LEADERBOARD_RANK_UNKNOWN: Integer read _GetLEADERBOARD_RANK_UNKNOWN;
  end;

  [JavaSignature('com/google/android/gms/games/leaderboard/LeaderboardScore')]
  JLeaderboardScore = interface(JFreezable)
    ['{11C06C5D-3D5E-4A10-A455-36A0F06D3206}']
    function getDisplayRank: JString; cdecl; overload;
    procedure getDisplayRank(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getDisplayScore: JString; cdecl; overload;
    procedure getDisplayScore(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getRank: Int64; cdecl;
    function getRawScore: Int64; cdecl;
    function getScoreHolder: JPlayer; cdecl;
    function getScoreHolderDisplayName: JString; cdecl; overload;
    procedure getScoreHolderDisplayName(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getScoreHolderHiResImageUri: Jnet_Uri; cdecl;
    function getScoreHolderHiResImageUrl: JString; cdecl;
    function getScoreHolderIconImageUri: Jnet_Uri; cdecl;
    function getScoreHolderIconImageUrl: JString; cdecl;
    function getScoreTag: JString; cdecl;
    function getTimestampMillis: Int64; cdecl;
  end;
  TJLeaderboardScore = class(TJavaGenericImport<JLeaderboardScoreClass, JLeaderboardScore>) end;

  JLeaderboardScoreBufferClass = interface(JDataBufferClass)
    ['{2170DADE-C803-4F52-9F02-F55510214415}']
    {class} function init(dataHolder: JDataHolder): JLeaderboardScoreBuffer; cdecl;
  end;

  [JavaSignature('com/google/android/gms/games/leaderboard/LeaderboardScoreBuffer')]
  JLeaderboardScoreBuffer = interface(JDataBuffer)
    ['{215A25BB-ACE6-43A5-9B5F-F1D1733A5F78}']
    //function fX: Jc; cdecl;
    function &get(position: Integer): JLeaderboardScore; cdecl;
  end;
  TJLeaderboardScoreBuffer = class(TJavaGenericImport<JLeaderboardScoreBufferClass, JLeaderboardScoreBuffer>) end;

  JLeaderboardVariantClass = interface(JFreezableClass)
    ['{3680A21A-CA98-4D19-9A6F-BE9A3BBC67B3}']
    {class} function _GetCOLLECTION_PUBLIC: Integer; cdecl;
    {class} function _GetCOLLECTION_SOCIAL: Integer; cdecl;
    {class} function _GetNUM_SCORES_UNKNOWN: Integer; cdecl;
    {class} function _GetNUM_TIME_SPANS: Integer; cdecl;
    {class} function _GetPLAYER_RANK_UNKNOWN: Integer; cdecl;
    {class} function _GetPLAYER_SCORE_UNKNOWN: Integer; cdecl;
    {class} function _GetTIME_SPAN_ALL_TIME: Integer; cdecl;
    {class} function _GetTIME_SPAN_DAILY: Integer; cdecl;
    {class} function _GetTIME_SPAN_WEEKLY: Integer; cdecl;
    {class} property COLLECTION_PUBLIC: Integer read _GetCOLLECTION_PUBLIC;
    {class} property COLLECTION_SOCIAL: Integer read _GetCOLLECTION_SOCIAL;
    {class} property NUM_SCORES_UNKNOWN: Integer read _GetNUM_SCORES_UNKNOWN;
    {class} property NUM_TIME_SPANS: Integer read _GetNUM_TIME_SPANS;
    {class} property PLAYER_RANK_UNKNOWN: Integer read _GetPLAYER_RANK_UNKNOWN;
    {class} property PLAYER_SCORE_UNKNOWN: Integer read _GetPLAYER_SCORE_UNKNOWN;
    {class} property TIME_SPAN_ALL_TIME: Integer read _GetTIME_SPAN_ALL_TIME;
    {class} property TIME_SPAN_DAILY: Integer read _GetTIME_SPAN_DAILY;
    {class} property TIME_SPAN_WEEKLY: Integer read _GetTIME_SPAN_WEEKLY;
  end;

  [JavaSignature('com/google/android/gms/games/leaderboard/LeaderboardVariant')]
  JLeaderboardVariant = interface(JFreezable)
    ['{7A5DDBB0-946F-4D3D-BE8D-317984BA5E31}']
    function ga: JString; cdecl;
    function gb: JString; cdecl;
    function gc: JString; cdecl;
    function getCollection: Integer; cdecl;
    function getDisplayPlayerRank: JString; cdecl;
    function getDisplayPlayerScore: JString; cdecl;
    function getNumScores: Int64; cdecl;
    function getPlayerRank: Int64; cdecl;
    function getPlayerScoreTag: JString; cdecl;
    function getRawPlayerScore: Int64; cdecl;
    function getTimeSpan: Integer; cdecl;
    function hasPlayerInfo: Boolean; cdecl;
  end;
  TJLeaderboardVariant = class(TJavaGenericImport<JLeaderboardVariantClass, JLeaderboardVariant>) end;

  JLeaderboardsClass = interface(IJavaClass)
    ['{927F1A30-2ECB-4E54-9369-D50D2F38DFBF}']
  end;

  [JavaSignature('com/google/android/gms/games/leaderboard/Leaderboards')]
  JLeaderboards = interface(IJavaInstance)
    ['{8EB67E34-0D05-4B8F-99C1-3DCDB5369553}']
    function getAllLeaderboardsIntent(P1: JGoogleApiClient): JIntent; cdecl;
    function getLeaderboardIntent(P1: JGoogleApiClient; P2: JString): JIntent; cdecl;
    function loadCurrentPlayerLeaderboardScore(P1: JGoogleApiClient; P2: JString; P3: Integer; P4: Integer): JPendingResult; cdecl;
    function loadLeaderboardMetadata(P1: JGoogleApiClient; P2: Boolean): JPendingResult; cdecl; overload;
    function loadLeaderboardMetadata(P1: JGoogleApiClient; P2: JString; P3: Boolean): JPendingResult; cdecl; overload;
    function loadMoreScores(P1: JGoogleApiClient; P2: JLeaderboardScoreBuffer; P3: Integer; P4: Integer): JPendingResult; cdecl;
    function loadPlayerCenteredScores(P1: JGoogleApiClient; P2: JString; P3: Integer; P4: Integer; P5: Integer): JPendingResult; cdecl; overload;
    function loadPlayerCenteredScores(P1: JGoogleApiClient; P2: JString; P3: Integer; P4: Integer; P5: Integer; P6: Boolean): JPendingResult; cdecl; overload;
    function loadTopScores(P1: JGoogleApiClient; P2: JString; P3: Integer; P4: Integer; P5: Integer): JPendingResult; cdecl; overload;
    function loadTopScores(P1: JGoogleApiClient; P2: JString; P3: Integer; P4: Integer; P5: Integer; P6: Boolean): JPendingResult; cdecl; overload;
    procedure submitScore(P1: JGoogleApiClient; P2: JString; P3: Int64); cdecl; overload;
    procedure submitScore(P1: JGoogleApiClient; P2: JString; P3: Int64; P4: JString); cdecl; overload;
    function submitScoreImmediate(P1: JGoogleApiClient; P2: JString; P3: Int64): JPendingResult; cdecl; overload;
    function submitScoreImmediate(P1: JGoogleApiClient; P2: JString; P3: Int64; P4: JString): JPendingResult; cdecl; overload;
  end;
  TJLeaderboards = class(TJavaGenericImport<JLeaderboardsClass, JLeaderboards>) end;

  JLeaderboards_LeaderboardMetadataResultClass = interface(JReleasableClass)
    ['{7BC6F7F7-ABDD-4B01-8669-6007561B59CA}']
  end;

  [JavaSignature('com/google/android/gms/games/leaderboard/Leaderboards$LeaderboardMetadataResult')]
  JLeaderboards_LeaderboardMetadataResult = interface(JReleasable)
    ['{AA65DC7C-E2DF-4A0B-AC01-C02B0B80804B}']
    //function getLeaderboards: JLeaderboardBuffer; cdecl;
  end;
  TJLeaderboards_LeaderboardMetadataResult = class(TJavaGenericImport<JLeaderboards_LeaderboardMetadataResultClass, JLeaderboards_LeaderboardMetadataResult>) end;

  JLeaderboards_LoadPlayerScoreResultClass = interface(Japi_ResultClass)
    ['{11E976CD-2F3A-48C3-A115-E3957AB1D7DE}']
  end;

  [JavaSignature('com/google/android/gms/games/leaderboard/Leaderboards$LoadPlayerScoreResult')]
  JLeaderboards_LoadPlayerScoreResult = interface(Japi_Result)
    ['{D52252A0-6FA5-4058-84C4-F49A442FC48B}']
    function getScore: JLeaderboardScore; cdecl;
  end;
  TJLeaderboards_LoadPlayerScoreResult = class(TJavaGenericImport<JLeaderboards_LoadPlayerScoreResultClass, JLeaderboards_LoadPlayerScoreResult>) end;

  JLeaderboards_LoadScoresResultClass = interface(JReleasableClass)
    ['{F20A7A11-6E84-470F-A60A-6ABD2B221B7F}']
  end;

  [JavaSignature('com/google/android/gms/games/leaderboard/Leaderboards$LoadScoresResult')]
  JLeaderboards_LoadScoresResult = interface(JReleasable)
    ['{7A715A42-23B2-49BD-9942-C8D1BD5CC812}']
    function getLeaderboard: JLeaderboard; cdecl;
    function getScores: JLeaderboardScoreBuffer; cdecl;
  end;
  TJLeaderboards_LoadScoresResult = class(TJavaGenericImport<JLeaderboards_LoadScoresResultClass, JLeaderboards_LoadScoresResult>) end;

  JLeaderboards_SubmitScoreResultClass = interface(JReleasableClass)
    ['{0B14FA7B-5E39-41D5-AB15-CD52B83B8F7C}']
  end;

  [JavaSignature('com/google/android/gms/games/leaderboard/Leaderboards$SubmitScoreResult')]
  JLeaderboards_SubmitScoreResult = interface(JReleasable)
    ['{CDE390C9-3897-4747-9A68-D0AB76264310}']
    function getScoreData: JScoreSubmissionData; cdecl;
  end;
  TJLeaderboards_SubmitScoreResult = class(TJavaGenericImport<JLeaderboards_SubmitScoreResultClass, JLeaderboards_SubmitScoreResult>) end;

  JScoreSubmissionDataClass = interface(JObjectClass)
    ['{0EE945FD-3FEB-4BB2-82A9-33440B8BAC04}']
    {class} function init(dataHolder: JDataHolder): JScoreSubmissionData; cdecl;
  end;

  [JavaSignature('com/google/android/gms/games/leaderboard/ScoreSubmissionData')]
  JScoreSubmissionData = interface(JObject)
    ['{87391FCC-42A2-489C-97D6-9174BF09CDA3}']
    function getLeaderboardId: JString; cdecl;
    function getPlayerId: JString; cdecl;
    function getScoreResult(timeSpan: Integer): JScoreSubmissionData_Result; cdecl;
    function toString: JString; cdecl;
  end;
  TJScoreSubmissionData = class(TJavaGenericImport<JScoreSubmissionDataClass, JScoreSubmissionData>) end;

  JScoreSubmissionData_ResultClass = interface(JObjectClass)
    ['{C15ACFF3-B196-4814-837D-EFABDB1BCA00}']
    {class} function init(rawScore: Int64; formattedScore: JString; scoreTag: JString; newBest: Boolean): JScoreSubmissionData_Result; cdecl;
  end;

  [JavaSignature('com/google/android/gms/games/leaderboard/ScoreSubmissionData$Result')]
  JScoreSubmissionData_Result = interface(JObject)
    ['{A3CFABE0-2EF6-4630-91F3-7E1E73448A24}']
    function _GetformattedScore: JString; cdecl;
    function _GetnewBest: Boolean; cdecl;
    function _GetrawScore: Int64; cdecl;
    function _GetscoreTag: JString; cdecl;
    function toString: JString; cdecl;
    property formattedScore: JString read _GetformattedScore;
    property newBest: Boolean read _GetnewBest;
    property rawScore: Int64 read _GetrawScore;
    property scoreTag: JString read _GetscoreTag;
  end;
  TJScoreSubmissionData_Result = class(TJavaGenericImport<JScoreSubmissionData_ResultClass, JScoreSubmissionData_Result>) end;

  JInvitationClass = interface(JParcelableClass)
    ['{14EB41F9-050E-4B83-B80C-BE0DAC596C38}']
    {class} function _GetINVITATION_TYPE_REAL_TIME: Integer; cdecl;
    {class} function _GetINVITATION_TYPE_TURN_BASED: Integer; cdecl;
    {class} property INVITATION_TYPE_REAL_TIME: Integer read _GetINVITATION_TYPE_REAL_TIME;
    {class} property INVITATION_TYPE_TURN_BASED: Integer read _GetINVITATION_TYPE_TURN_BASED;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/Invitation')]
  JInvitation = interface(JParcelable)
    ['{2F9236D2-0094-44BE-A00A-41D28EB1C749}']
    function getAvailableAutoMatchSlots: Integer; cdecl;
    function getCreationTimestamp: Int64; cdecl;
    function getGame: JGame; cdecl;
    function getInvitationId: JString; cdecl;
    function getInvitationType: Integer; cdecl;
    function getInviter: JParticipant; cdecl;
    function getVariant: Integer; cdecl;
  end;
  TJInvitation = class(TJavaGenericImport<JInvitationClass, JInvitation>) end;

  // com.google.android.gms.games.multiplayer.InvitationBuffer
  // com.google.android.gms.games.multiplayer.InvitationEntity
  JInvitationsClass = interface(IJavaClass)
    ['{E9282ACE-D9A7-416B-9FDB-D1AB883D642A}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/Invitations')]
  JInvitations = interface(IJavaInstance)
    ['{909B2FC5-1777-46B9-B757-44CE02353042}']
    function getInvitationInboxIntent(P1: JGoogleApiClient): JIntent; cdecl;
    function loadInvitations(P1: JGoogleApiClient): JPendingResult; cdecl; overload;
    function loadInvitations(P1: JGoogleApiClient; P2: Integer): JPendingResult; cdecl; overload;
    procedure registerInvitationListener(P1: JGoogleApiClient; P2: JOnInvitationReceivedListener); cdecl;
    procedure unregisterInvitationListener(P1: JGoogleApiClient); cdecl;
  end;
  TJInvitations = class(TJavaGenericImport<JInvitationsClass, JInvitations>) end;

  JInvitations_LoadInvitationsResultClass = interface(JReleasableClass)
    ['{B9D258BA-8C77-451E-84EC-1508E80BCB99}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/Invitations$LoadInvitationsResult')]
  JInvitations_LoadInvitationsResult = interface(JReleasable)
    ['{76A3BBD7-3854-4666-9C29-EA969DA7F5C1}']
    //function getInvitations: JInvitationBuffer; cdecl;
  end;
  TJInvitations_LoadInvitationsResult = class(TJavaGenericImport<JInvitations_LoadInvitationsResultClass, JInvitations_LoadInvitationsResult>) end;

  JMultiplayerClass = interface(IJavaClass)
    ['{E83EC182-095A-41DA-A92D-A7397CCB3D6E}']
    {class} function _GetEXTRA_EXCLUSIVE_BIT_MASK: JString; cdecl;
    {class} function _GetEXTRA_INVITATION: JString; cdecl;
    {class} function _GetEXTRA_MAX_AUTOMATCH_PLAYERS: JString; cdecl;
    {class} function _GetEXTRA_MIN_AUTOMATCH_PLAYERS: JString; cdecl;
    {class} function _GetEXTRA_ROOM: JString; cdecl;
    {class} function _GetEXTRA_TURN_BASED_MATCH: JString; cdecl;
    {class} function _GetMAX_RELIABLE_MESSAGE_LEN: Integer; cdecl;
    {class} function _GetMAX_UNRELIABLE_MESSAGE_LEN: Integer; cdecl;
    {class} function _GetSORT_ORDER_MOST_RECENT_FIRST: Integer; cdecl;
    {class} function _GetSORT_ORDER_SOCIAL_AGGREGATION: Integer; cdecl;
    {class} property EXTRA_EXCLUSIVE_BIT_MASK: JString read _GetEXTRA_EXCLUSIVE_BIT_MASK;
    {class} property EXTRA_INVITATION: JString read _GetEXTRA_INVITATION;
    {class} property EXTRA_MAX_AUTOMATCH_PLAYERS: JString read _GetEXTRA_MAX_AUTOMATCH_PLAYERS;
    {class} property EXTRA_MIN_AUTOMATCH_PLAYERS: JString read _GetEXTRA_MIN_AUTOMATCH_PLAYERS;
    {class} property EXTRA_ROOM: JString read _GetEXTRA_ROOM;
    {class} property EXTRA_TURN_BASED_MATCH: JString read _GetEXTRA_TURN_BASED_MATCH;
    {class} property MAX_RELIABLE_MESSAGE_LEN: Integer read _GetMAX_RELIABLE_MESSAGE_LEN;
    {class} property MAX_UNRELIABLE_MESSAGE_LEN: Integer read _GetMAX_UNRELIABLE_MESSAGE_LEN;
    {class} property SORT_ORDER_MOST_RECENT_FIRST: Integer read _GetSORT_ORDER_MOST_RECENT_FIRST;
    {class} property SORT_ORDER_SOCIAL_AGGREGATION: Integer read _GetSORT_ORDER_SOCIAL_AGGREGATION;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/Multiplayer')]
  JMultiplayer = interface(IJavaInstance)
    ['{014FC46E-CEEB-41A5-9C98-B9932BB8824A}']
  end;
  TJMultiplayer = class(TJavaGenericImport<JMultiplayerClass, JMultiplayer>) end;

  JOnInvitationReceivedListenerClass = interface(IJavaClass)
    ['{124C239D-5B88-4ED3-911D-F45488ECCB02}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/OnInvitationReceivedListener')]
  JOnInvitationReceivedListener = interface(IJavaInstance)
    ['{6860A363-DEA1-45A1-99C6-328598B0AE2A}']
    procedure onInvitationReceived(P1: JInvitation); cdecl;
    procedure onInvitationRemoved(P1: JString); cdecl;
  end;
  TJOnInvitationReceivedListener = class(TJavaGenericImport<JOnInvitationReceivedListenerClass, JOnInvitationReceivedListener>) end;

  JParticipantClass = interface(JParcelableClass)
    ['{0BE0B958-105E-4602-B807-5599272EFA4E}']
    {class} function _GetSTATUS_DECLINED: Integer; cdecl;
    {class} function _GetSTATUS_FINISHED: Integer; cdecl;
    {class} function _GetSTATUS_INVITED: Integer; cdecl;
    {class} function _GetSTATUS_JOINED: Integer; cdecl;
    {class} function _GetSTATUS_LEFT: Integer; cdecl;
    {class} function _GetSTATUS_NOT_INVITED_YET: Integer; cdecl;
    {class} function _GetSTATUS_UNRESPONSIVE: Integer; cdecl;
    {class} property STATUS_DECLINED: Integer read _GetSTATUS_DECLINED;
    {class} property STATUS_FINISHED: Integer read _GetSTATUS_FINISHED;
    {class} property STATUS_INVITED: Integer read _GetSTATUS_INVITED;
    {class} property STATUS_JOINED: Integer read _GetSTATUS_JOINED;
    {class} property STATUS_LEFT: Integer read _GetSTATUS_LEFT;
    {class} property STATUS_NOT_INVITED_YET: Integer read _GetSTATUS_NOT_INVITED_YET;
    {class} property STATUS_UNRESPONSIVE: Integer read _GetSTATUS_UNRESPONSIVE;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/Participant')]
  JParticipant = interface(JParcelable)
    ['{DC33E0EF-970D-4D19-97F5-7FAD48261851}']
    function ge: JString; cdecl;
    function getCapabilities: Integer; cdecl;
    function getDisplayName: JString; cdecl; overload;
    procedure getDisplayName(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getHiResImageUri: Jnet_Uri; cdecl;
    function getHiResImageUrl: JString; cdecl;
    function getIconImageUri: Jnet_Uri; cdecl;
    function getIconImageUrl: JString; cdecl;
    function getParticipantId: JString; cdecl;
    function getPlayer: JPlayer; cdecl;
    function getResult: JParticipantResult; cdecl;
    function getStatus: Integer; cdecl;
    function isConnectedToRoom: Boolean; cdecl;
  end;
  TJParticipant = class(TJavaGenericImport<JParticipantClass, JParticipant>) end;

  JParticipantBufferClass = interface(JDataBufferClass)
    ['{AABC49A4-2306-46B2-81E5-99EE05A6DDD5}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/ParticipantBuffer')]
  JParticipantBuffer = interface(JDataBuffer)
    ['{F756E11E-5E50-4947-BB3A-33A867A4FC43}']
    function &get(position: Integer): JParticipant; cdecl;
  end;
  TJParticipantBuffer = class(TJavaGenericImport<JParticipantBufferClass, JParticipantBuffer>) end;

  // com.google.android.gms.games.multiplayer.ParticipantEntity
  JParticipantResultClass = interface(JObjectClass)
    ['{3654CFE0-BB45-4A15-919D-3FE27E6F398C}']
    {class} function _GetCREATOR: JParticipantResultCreator; cdecl;
    {class} function _GetMATCH_RESULT_DISAGREED: Integer; cdecl;
    {class} function _GetMATCH_RESULT_DISCONNECT: Integer; cdecl;
    {class} function _GetMATCH_RESULT_LOSS: Integer; cdecl;
    {class} function _GetMATCH_RESULT_NONE: Integer; cdecl;
    {class} function _GetMATCH_RESULT_TIE: Integer; cdecl;
    {class} function _GetMATCH_RESULT_UNINITIALIZED: Integer; cdecl;
    {class} function _GetMATCH_RESULT_WIN: Integer; cdecl;
    {class} function _GetPLACING_UNINITIALIZED: Integer; cdecl;
    {class} function init(participantId: JString; result: Integer; placing: Integer): JParticipantResult; cdecl; overload;
    {class} function init(versionCode: Integer; participantId: JString; result: Integer; placing: Integer): JParticipantResult; cdecl; overload;
    {class} property CREATOR: JParticipantResultCreator read _GetCREATOR;
    {class} property MATCH_RESULT_DISAGREED: Integer read _GetMATCH_RESULT_DISAGREED;
    {class} property MATCH_RESULT_DISCONNECT: Integer read _GetMATCH_RESULT_DISCONNECT;
    {class} property MATCH_RESULT_LOSS: Integer read _GetMATCH_RESULT_LOSS;
    {class} property MATCH_RESULT_NONE: Integer read _GetMATCH_RESULT_NONE;
    {class} property MATCH_RESULT_TIE: Integer read _GetMATCH_RESULT_TIE;
    {class} property MATCH_RESULT_UNINITIALIZED: Integer read _GetMATCH_RESULT_UNINITIALIZED;
    {class} property MATCH_RESULT_WIN: Integer read _GetMATCH_RESULT_WIN;
    {class} property PLACING_UNINITIALIZED: Integer read _GetPLACING_UNINITIALIZED;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/ParticipantResult')]
  JParticipantResult = interface(JObject)
    ['{9162B2DC-A07C-472B-AC1E-EACBAA9323B0}']
    function describeContents: Integer; cdecl;
    function getParticipantId: JString; cdecl;
    function getPlacing: Integer; cdecl;
    function getResult: Integer; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJParticipantResult = class(TJavaGenericImport<JParticipantResultClass, JParticipantResult>) end;

  JParticipantResultCreatorClass = interface(JObjectClass)
    ['{79774C21-47E9-4A1C-9181-3737C3885F32}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JParticipantResultCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/ParticipantResultCreator')]
  JParticipantResultCreator = interface(JObject)
    ['{F909A55B-043D-451D-9E55-DA4966A030F4}']
    function createFromParcel(parcel: JParcel): JParticipantResult; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JParticipantResult>; cdecl;
  end;
  TJParticipantResultCreator = class(TJavaGenericImport<JParticipantResultCreatorClass, JParticipantResultCreator>) end;

  JParticipantUtilsClass = interface(JObjectClass)
    ['{72CD73A6-E7B1-46F7-9116-7394FDC35A03}']
    {class} function aE(P1: JString): Boolean; cdecl;
    {class} function getParticipantId(participants: JArrayList; playerId: JString): JString; cdecl;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/ParticipantUtils')]
  JParticipantUtils = interface(JObject)
    ['{245527FA-DD08-4626-BEDD-5D4976CFF950}']
  end;
  TJParticipantUtils = class(TJavaGenericImport<JParticipantUtilsClass, JParticipantUtils>) end;

  JParticipatableClass = interface(IJavaClass)
    ['{E9864B4D-9A42-4F31-9DDF-328F7281408D}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/Participatable')]
  JParticipatable = interface(IJavaInstance)
    ['{0DAC4927-D1B7-40F3-83DF-6C472854EF61}']
    function getParticipants: JArrayList; cdecl;
  end;
  TJParticipatable = class(TJavaGenericImport<JParticipatableClass, JParticipatable>) end;

  JRealTimeMessageClass = interface(JObjectClass)
    ['{E11642C1-4F49-4298-8B3F-DF46663B9BF2}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetRELIABLE: Integer; cdecl;
    {class} function _GetUNRELIABLE: Integer; cdecl;
    {class} function init(senderParticipantId: JString; messageData: TJavaArray<Byte>; isReliable: Integer): JRealTimeMessage; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property RELIABLE: Integer read _GetRELIABLE;
    {class} property UNRELIABLE: Integer read _GetUNRELIABLE;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/realtime/RealTimeMessage')]
  JRealTimeMessage = interface(JObject)
    ['{0CF40854-AF00-4EC0-9922-62E2400A17B0}']
    function describeContents: Integer; cdecl;
    function getMessageData: TJavaArray<Byte>; cdecl;
    function getSenderParticipantId: JString; cdecl;
    function isReliable: Boolean; cdecl;
    procedure writeToParcel(parcel: JParcel; flag: Integer); cdecl;
  end;
  TJRealTimeMessage = class(TJavaGenericImport<JRealTimeMessageClass, JRealTimeMessage>) end;

  JRealTimeMessageReceivedListenerClass = interface(IJavaClass)
    ['{41C291FA-37A2-4F78-B449-E48116C9DD87}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/realtime/RealTimeMessageReceivedListener')]
  JRealTimeMessageReceivedListener = interface(IJavaInstance)
    ['{487EE70C-69D6-46F9-935A-8BC45DD124D5}']
    procedure onRealTimeMessageReceived(P1: JRealTimeMessage); cdecl;
  end;
  TJRealTimeMessageReceivedListener = class(TJavaGenericImport<JRealTimeMessageReceivedListenerClass, JRealTimeMessageReceivedListener>) end;

  JRealTimeMultiplayerClass = interface(IJavaClass)
    ['{85AF3A85-3968-43A1-99B9-3455DFC448DE}']
    {class} function _GetREAL_TIME_MESSAGE_FAILED: Integer; cdecl;
    {class} property REAL_TIME_MESSAGE_FAILED: Integer read _GetREAL_TIME_MESSAGE_FAILED;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/realtime/RealTimeMultiplayer')]
  JRealTimeMultiplayer = interface(IJavaInstance)
    ['{1377745A-8BD4-4882-930B-9F3D011B7676}']
    procedure create(P1: JGoogleApiClient; P2: JRoomConfig); cdecl;
    procedure declineInvitation(P1: JGoogleApiClient; P2: JString); cdecl;
    procedure dismissInvitation(P1: JGoogleApiClient; P2: JString); cdecl;
    function getSelectOpponentsIntent(P1: JGoogleApiClient; P2: Integer; P3: Integer): JIntent; cdecl; overload;
    function getSelectOpponentsIntent(P1: JGoogleApiClient; P2: Integer; P3: Integer; P4: Boolean): JIntent; cdecl; overload;
    function getSocketForParticipant(P1: JGoogleApiClient; P2: JString; P3: JString): Jrealtime_RealTimeSocket; cdecl;
    function getWaitingRoomIntent(P1: JGoogleApiClient; P2: JRoom; P3: Integer): JIntent; cdecl;
    procedure join(P1: JGoogleApiClient; P2: JRoomConfig); cdecl;
    procedure leave(P1: JGoogleApiClient; P2: JRoomUpdateListener; P3: JString); cdecl;
    function sendReliableMessage(P1: JGoogleApiClient; P2: JRealTimeMultiplayer_ReliableMessageSentCallback; P3: TJavaArray<Byte>; P4: JString; P5: JString): Integer; cdecl;
    function sendUnreliableMessage(P1: JGoogleApiClient; P2: TJavaArray<Byte>; P3: JString; P4: JString): Integer; cdecl; overload;
    function sendUnreliableMessage(P1: JGoogleApiClient; P2: TJavaArray<Byte>; P3: JString; P4: JList): Integer; cdecl; overload;
    function sendUnreliableMessageToOthers(P1: JGoogleApiClient; P2: TJavaArray<Byte>; P3: JString): Integer; cdecl;
  end;
  TJRealTimeMultiplayer = class(TJavaGenericImport<JRealTimeMultiplayerClass, JRealTimeMultiplayer>) end;

  JRealTimeMultiplayer_ReliableMessageSentCallbackClass = interface(IJavaClass)
    ['{1A517252-E363-4184-ABC0-A73BF00FC4E2}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/realtime/RealTimeMultiplayer$ReliableMessageSentCallback')]
  JRealTimeMultiplayer_ReliableMessageSentCallback = interface(IJavaInstance)
    ['{757B7C6C-6FA6-448D-9AD0-8CD6C3A3B95B}']
    procedure onRealTimeMessageSent(P1: Integer; P2: Integer; P3: JString); cdecl;
  end;
  TJRealTimeMultiplayer_ReliableMessageSentCallback = class(TJavaGenericImport<JRealTimeMultiplayer_ReliableMessageSentCallbackClass, JRealTimeMultiplayer_ReliableMessageSentCallback>) end;

  Jrealtime_RealTimeSocketClass = interface(IJavaClass)
    ['{E903D887-CB5B-40E0-B54C-52E6B1C7ED86}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/realtime/RealTimeSocket')]
  Jrealtime_RealTimeSocket = interface(IJavaInstance)
    ['{1D1BD6F8-032B-43F5-8FAE-B8E37E7A3B85}']
    procedure close; cdecl;
    function getInputStream: JInputStream; cdecl;
    function getOutputStream: JOutputStream; cdecl;
    function getParcelFileDescriptor: JParcelFileDescriptor; cdecl;
    function isClosed: Boolean; cdecl;
  end;
  TJrealtime_RealTimeSocket = class(TJavaGenericImport<Jrealtime_RealTimeSocketClass, Jrealtime_RealTimeSocket>) end;

  JRoomClass = interface(JParcelableClass)
    ['{A93A517C-84FF-4021-929F-41332F02AA6B}']
    {class} function _GetROOM_STATUS_ACTIVE: Integer; cdecl;
    {class} function _GetROOM_STATUS_AUTO_MATCHING: Integer; cdecl;
    {class} function _GetROOM_STATUS_CONNECTING: Integer; cdecl;
    {class} function _GetROOM_STATUS_INVITING: Integer; cdecl;
    {class} function _GetROOM_VARIANT_DEFAULT: Integer; cdecl;
    {class} property ROOM_STATUS_ACTIVE: Integer read _GetROOM_STATUS_ACTIVE;
    {class} property ROOM_STATUS_AUTO_MATCHING: Integer read _GetROOM_STATUS_AUTO_MATCHING;
    {class} property ROOM_STATUS_CONNECTING: Integer read _GetROOM_STATUS_CONNECTING;
    {class} property ROOM_STATUS_INVITING: Integer read _GetROOM_STATUS_INVITING;
    {class} property ROOM_VARIANT_DEFAULT: Integer read _GetROOM_VARIANT_DEFAULT;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/realtime/Room')]
  JRoom = interface(JParcelable)
    ['{2C389670-651B-424F-88E5-93850089A77C}']
    function getAutoMatchCriteria: JBundle; cdecl;
    function getAutoMatchWaitEstimateSeconds: Integer; cdecl;
    function getCreationTimestamp: Int64; cdecl;
    function getCreatorId: JString; cdecl;
    function getDescription: JString; cdecl; overload;
    procedure getDescription(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getParticipant(P1: JString): JParticipant; cdecl;
    function getParticipantId(P1: JString): JString; cdecl;
    function getParticipantIds: JArrayList; cdecl;
    function getParticipantStatus(P1: JString): Integer; cdecl;
    function getRoomId: JString; cdecl;
    function getStatus: Integer; cdecl;
    function getVariant: Integer; cdecl;
  end;
  TJRoom = class(TJavaGenericImport<JRoomClass, JRoom>) end;

  JRoomConfigClass = interface(JObjectClass)
    ['{F272FA9D-AE37-41CD-ABD1-62727128BCF8}']
    {class} function builder(listener: JRoomUpdateListener): JRoomConfig_Builder; cdecl;
    {class} function createAutoMatchCriteria(minAutoMatchPlayers: Integer; maxAutoMatchPlayers: Integer; exclusiveBitMask: Int64): JBundle; cdecl;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/realtime/RoomConfig')]
  JRoomConfig = interface(JObject)
    ['{CD2AD528-203D-44D5-8DCF-8FAEA3584E38}']
    function getAutoMatchCriteria: JBundle; cdecl;
    function getInvitationId: JString; cdecl;
    function getInvitedPlayerIds: TJavaObjectArray<JString>; cdecl;
    function getMessageReceivedListener: JRealTimeMessageReceivedListener; cdecl;
    function getRoomStatusUpdateListener: JRoomStatusUpdateListener; cdecl;
    function getRoomUpdateListener: JRoomUpdateListener; cdecl;
    function getVariant: Integer; cdecl;
    function isSocketEnabled: Boolean; cdecl;
  end;
  TJRoomConfig = class(TJavaGenericImport<JRoomConfigClass, JRoomConfig>) end;

  JRoomConfig_BuilderClass = interface(JObjectClass)
    ['{A8118363-1188-4D23-B562-AA6C45827C8B}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/realtime/RoomConfig$Builder')]
  JRoomConfig_Builder = interface(JObject)
    ['{41897BC0-FFF0-4634-90AC-27DDB46B3B48}']
    function addPlayersToInvite(playerIds: TJavaObjectArray<JString>): JRoomConfig_Builder; cdecl; overload;
    function addPlayersToInvite(playerIds: JArrayList): JRoomConfig_Builder; cdecl; overload;
    function build: JRoomConfig; cdecl;
    function setAutoMatchCriteria(autoMatchCriteria: JBundle): JRoomConfig_Builder; cdecl;
    function setInvitationIdToAccept(invitationId: JString): JRoomConfig_Builder; cdecl;
    function setMessageReceivedListener(listener: JRealTimeMessageReceivedListener): JRoomConfig_Builder; cdecl;
    function setRoomStatusUpdateListener(listener: JRoomStatusUpdateListener): JRoomConfig_Builder; cdecl;
    function setSocketCommunicationEnabled(enableSockets: Boolean): JRoomConfig_Builder; cdecl;
    function setVariant(variant: Integer): JRoomConfig_Builder; cdecl;
  end;
  TJRoomConfig_Builder = class(TJavaGenericImport<JRoomConfig_BuilderClass, JRoomConfig_Builder>) end;

  // com.google.android.gms.games.multiplayer.realtime.RoomEntity
  JRoomStatusUpdateListenerClass = interface(IJavaClass)
    ['{EAA3385A-F22C-44E6-B87C-A07AF86EFDF0}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateListener')]
  JRoomStatusUpdateListener = interface(IJavaInstance)
    ['{4EEDB710-37CA-4B3B-937C-3F109DC26D4C}']
    procedure onConnectedToRoom(P1: JRoom); cdecl;
    procedure onDisconnectedFromRoom(P1: JRoom); cdecl;
    procedure onP2PConnected(P1: JString); cdecl;
    procedure onP2PDisconnected(P1: JString); cdecl;
    procedure onPeerDeclined(P1: JRoom; P2: JList); cdecl;
    procedure onPeerInvitedToRoom(P1: JRoom; P2: JList); cdecl;
    procedure onPeerJoined(P1: JRoom; P2: JList); cdecl;
    procedure onPeerLeft(P1: JRoom; P2: JList); cdecl;
    procedure onPeersConnected(P1: JRoom; P2: JList); cdecl;
    procedure onPeersDisconnected(P1: JRoom; P2: JList); cdecl;
    procedure onRoomAutoMatching(P1: JRoom); cdecl;
    procedure onRoomConnecting(P1: JRoom); cdecl;
  end;
  TJRoomStatusUpdateListener = class(TJavaGenericImport<JRoomStatusUpdateListenerClass, JRoomStatusUpdateListener>) end;

  JRoomUpdateListenerClass = interface(IJavaClass)
    ['{E5B9F101-A738-4ABE-8733-ACA0A36DFD70}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/realtime/RoomUpdateListener')]
  JRoomUpdateListener = interface(IJavaInstance)
    ['{F18EB4D8-5704-4A7D-AD45-1AD615E35C27}']
    procedure onJoinedRoom(P1: Integer; P2: JRoom); cdecl;
    procedure onLeftRoom(P1: Integer; P2: JString); cdecl;
    procedure onRoomConnected(P1: Integer; P2: JRoom); cdecl;
    procedure onRoomCreated(P1: Integer; P2: JRoom); cdecl;
  end;
  TJRoomUpdateListener = class(TJavaGenericImport<JRoomUpdateListenerClass, JRoomUpdateListener>) end;

  JLoadMatchesResponseClass = interface(JObjectClass)
    ['{B081ABD8-2F53-46B1-B89C-0559E90F4BA9}']
    {class} function init(matchData: JBundle): JLoadMatchesResponse; cdecl;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/LoadMatchesResponse')]
  JLoadMatchesResponse = interface(JObject)
    ['{F52AA703-4C0A-42D7-A9A1-B3CC13A0D115}']
    procedure close; cdecl;
    //function getCompletedMatches: JTurnBasedMatchBuffer; cdecl;
    //function getInvitations: JInvitationBuffer; cdecl;
    //function getMyTurnMatches: JTurnBasedMatchBuffer; cdecl;
    //function getTheirTurnMatches: JTurnBasedMatchBuffer; cdecl;
    function hasData: Boolean; cdecl;
  end;
  TJLoadMatchesResponse = class(TJavaGenericImport<JLoadMatchesResponseClass, JLoadMatchesResponse>) end;

  JOnTurnBasedMatchUpdateReceivedListenerClass = interface(IJavaClass)
    ['{2425C5EC-5536-48EC-91A3-0DF8959E4F83}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/OnTurnBasedMatchUpdateReceivedListener')]
  JOnTurnBasedMatchUpdateReceivedListener = interface(IJavaInstance)
    ['{9AEB8301-5B77-43D2-91AC-111E278D4B75}']
    procedure onTurnBasedMatchReceived(P1: JTurnBasedMatch); cdecl;
    procedure onTurnBasedMatchRemoved(P1: JString); cdecl;
  end;
  TJOnTurnBasedMatchUpdateReceivedListener = class(TJavaGenericImport<JOnTurnBasedMatchUpdateReceivedListenerClass, JOnTurnBasedMatchUpdateReceivedListener>) end;

  JTurnBasedMatchClass = interface(JParcelableClass)
    ['{FF01CCC0-34A7-4BB3-AD73-DC49D51B24C0}']
    {class} function _GetMATCH_STATUS_ACTIVE: Integer; cdecl;
    {class} function _GetMATCH_STATUS_AUTO_MATCHING: Integer; cdecl;
    {class} function _GetMATCH_STATUS_CANCELED: Integer; cdecl;
    {class} function _GetMATCH_STATUS_COMPLETE: Integer; cdecl;
    {class} function _GetMATCH_STATUS_EXPIRED: Integer; cdecl;
    {class} function _GetMATCH_TURN_STATUS_ALL: TJavaArray<Integer>; cdecl;
    {class} function _GetMATCH_TURN_STATUS_COMPLETE: Integer; cdecl;
    {class} function _GetMATCH_TURN_STATUS_INVITED: Integer; cdecl;
    {class} function _GetMATCH_TURN_STATUS_MY_TURN: Integer; cdecl;
    {class} function _GetMATCH_TURN_STATUS_THEIR_TURN: Integer; cdecl;
    {class} function _GetMATCH_VARIANT_DEFAULT: Integer; cdecl;
    {class} property MATCH_STATUS_ACTIVE: Integer read _GetMATCH_STATUS_ACTIVE;
    {class} property MATCH_STATUS_AUTO_MATCHING: Integer read _GetMATCH_STATUS_AUTO_MATCHING;
    {class} property MATCH_STATUS_CANCELED: Integer read _GetMATCH_STATUS_CANCELED;
    {class} property MATCH_STATUS_COMPLETE: Integer read _GetMATCH_STATUS_COMPLETE;
    {class} property MATCH_STATUS_EXPIRED: Integer read _GetMATCH_STATUS_EXPIRED;
    {class} property MATCH_TURN_STATUS_ALL: TJavaArray<Integer> read _GetMATCH_TURN_STATUS_ALL;
    {class} property MATCH_TURN_STATUS_COMPLETE: Integer read _GetMATCH_TURN_STATUS_COMPLETE;
    {class} property MATCH_TURN_STATUS_INVITED: Integer read _GetMATCH_TURN_STATUS_INVITED;
    {class} property MATCH_TURN_STATUS_MY_TURN: Integer read _GetMATCH_TURN_STATUS_MY_TURN;
    {class} property MATCH_TURN_STATUS_THEIR_TURN: Integer read _GetMATCH_TURN_STATUS_THEIR_TURN;
    {class} property MATCH_VARIANT_DEFAULT: Integer read _GetMATCH_VARIANT_DEFAULT;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMatch')]
  JTurnBasedMatch = interface(JParcelable)
    ['{A263A9BE-FFB2-44BF-B8EA-4BB0F67EE96B}']
    function canRematch: Boolean; cdecl;
    function getAutoMatchCriteria: JBundle; cdecl;
    function getAvailableAutoMatchSlots: Integer; cdecl;
    function getCreationTimestamp: Int64; cdecl;
    function getCreatorId: JString; cdecl;
    function getData: TJavaArray<Byte>; cdecl;
    function getDescription: JString; cdecl; overload;
    procedure getDescription(P1: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getDescriptionParticipant: JParticipant; cdecl;
    function getDescriptionParticipantId: JString; cdecl;
    function getGame: JGame; cdecl;
    function getLastUpdatedTimestamp: Int64; cdecl;
    function getLastUpdaterId: JString; cdecl;
    function getMatchId: JString; cdecl;
    function getMatchNumber: Integer; cdecl;
    function getParticipant(P1: JString): JParticipant; cdecl;
    function getParticipantId(P1: JString): JString; cdecl;
    function getParticipantIds: JArrayList; cdecl;
    function getParticipantStatus(P1: JString): Integer; cdecl;
    function getPendingParticipantId: JString; cdecl;
    function getPreviousMatchData: TJavaArray<Byte>; cdecl;
    function getRematchId: JString; cdecl;
    function getStatus: Integer; cdecl;
    function getTurnStatus: Integer; cdecl;
    function getVariant: Integer; cdecl;
    function getVersion: Integer; cdecl;
    function isLocallyModified: Boolean; cdecl;
  end;
  TJTurnBasedMatch = class(TJavaGenericImport<JTurnBasedMatchClass, JTurnBasedMatch>) end;

  // com.google.android.gms.games.multiplayer.turnbased.TurnBasedMatchBuffer
  JTurnBasedMatchConfigClass = interface(JObjectClass)
    ['{8FF8916D-1455-4878-8D2D-0A3344617B23}']
    {class} function builder: JTurnBasedMatchConfig_Builder; cdecl;
    {class} function createAutoMatchCriteria(minAutoMatchPlayers: Integer; maxAutoMatchPlayers: Integer; exclusiveBitMask: Int64): JBundle; cdecl;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchConfig')]
  JTurnBasedMatchConfig = interface(JObject)
    ['{BFB4DCEE-9010-4866-90D2-6B824FD222CF}']
    function getAutoMatchCriteria: JBundle; cdecl;
    function getInvitedPlayerIds: TJavaObjectArray<JString>; cdecl;
    function getMinPlayers: Integer; cdecl;
    function getVariant: Integer; cdecl;
  end;
  TJTurnBasedMatchConfig = class(TJavaGenericImport<JTurnBasedMatchConfigClass, JTurnBasedMatchConfig>) end;

  JTurnBasedMatchConfig_1Class = interface(JObjectClass)
    ['{9F69C313-F792-4937-903D-CAD6A5927B36}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchConfig$1')]
  JTurnBasedMatchConfig_1 = interface(JObject)
    ['{53D96BB6-D298-4ECD-B8CF-D35E0A809ED5}']
  end;
  TJTurnBasedMatchConfig_1 = class(TJavaGenericImport<JTurnBasedMatchConfig_1Class, JTurnBasedMatchConfig_1>) end;

  JTurnBasedMatchConfig_BuilderClass = interface(JObjectClass)
    ['{01885C73-E495-4B3E-9ECA-3E0F61297509}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchConfig$Builder')]
  JTurnBasedMatchConfig_Builder = interface(JObject)
    ['{715E0799-55C9-4F73-B30F-02EB83680F6D}']
    function addInvitedPlayer(playerId: JString): JTurnBasedMatchConfig_Builder; cdecl;
    function addInvitedPlayers(playerIds: JArrayList): JTurnBasedMatchConfig_Builder; cdecl;
    function build: JTurnBasedMatchConfig; cdecl;
    function setAutoMatchCriteria(autoMatchCriteria: JBundle): JTurnBasedMatchConfig_Builder; cdecl;
    function setMinPlayers(minPlayers: Integer): JTurnBasedMatchConfig_Builder; cdecl;
    function setVariant(variant: Integer): JTurnBasedMatchConfig_Builder; cdecl;
  end;
  TJTurnBasedMatchConfig_Builder = class(TJavaGenericImport<JTurnBasedMatchConfig_BuilderClass, JTurnBasedMatchConfig_Builder>) end;

  JTurnBasedMatchEntityClass = interface(JObjectClass)
    ['{E1226063-D86E-4EF8-AA31-7249458B537E}']
    {class} function _GetCREATOR: JTurnBasedMatchEntityCreator; cdecl;
    {class} function init(match: JTurnBasedMatch): JTurnBasedMatchEntity; cdecl; overload;
    {class} property CREATOR: JTurnBasedMatchEntityCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchEntity')]
  JTurnBasedMatchEntity = interface(JObject)
    ['{37E42546-F34D-4070-BE2E-69F2D85B3120}']
    function canRematch: Boolean; cdecl;
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function freeze: JTurnBasedMatch; cdecl;
    function getAutoMatchCriteria: JBundle; cdecl;
    function getAvailableAutoMatchSlots: Integer; cdecl;
    function getCreationTimestamp: Int64; cdecl;
    function getCreatorId: JString; cdecl;
    function getData: TJavaArray<Byte>; cdecl;
    function getDescription: JString; cdecl; overload;
    procedure getDescription(dataOut: Jdatabase_CharArrayBuffer); cdecl; overload;
    function getDescriptionParticipant: JParticipant; cdecl;
    function getDescriptionParticipantId: JString; cdecl;
    function getGame: JGame; cdecl;
    function getLastUpdatedTimestamp: Int64; cdecl;
    function getLastUpdaterId: JString; cdecl;
    function getMatchId: JString; cdecl;
    function getMatchNumber: Integer; cdecl;
    function getParticipant(participantId: JString): JParticipant; cdecl;
    function getParticipantId(playerId: JString): JString; cdecl;
    function getParticipantIds: JArrayList; cdecl;
    function getParticipantStatus(participantId: JString): Integer; cdecl;
    function getParticipants: JArrayList; cdecl;
    function getPendingParticipantId: JString; cdecl;
    function getPreviousMatchData: TJavaArray<Byte>; cdecl;
    function getRematchId: JString; cdecl;
    function getStatus: Integer; cdecl;
    function getTurnStatus: Integer; cdecl;
    function getVariant: Integer; cdecl;
    function getVersion: Integer; cdecl;
    function getVersionCode: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function isDataValid: Boolean; cdecl;
    function isLocallyModified: Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJTurnBasedMatchEntity = class(TJavaGenericImport<JTurnBasedMatchEntityClass, JTurnBasedMatchEntity>) end;

  JTurnBasedMatchEntityCreatorClass = interface(JObjectClass)
    ['{6CBB6D8E-2BCE-43E1-BC5D-F3BC19ABAA23}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JTurnBasedMatchEntityCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMatchEntityCreator')]
  JTurnBasedMatchEntityCreator = interface(JObject)
    ['{C6B6B6C1-28F6-46AA-9E48-59DCA8E12186}']
    function createFromParcel(parcel: JParcel): JTurnBasedMatchEntity; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JTurnBasedMatchEntity>; cdecl;
  end;
  TJTurnBasedMatchEntityCreator = class(TJavaGenericImport<JTurnBasedMatchEntityCreatorClass, JTurnBasedMatchEntityCreator>) end;

  JTurnBasedMultiplayerClass = interface(IJavaClass)
    ['{73895C07-5CE5-479E-BA58-67C479B75804}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMultiplayer')]
  JTurnBasedMultiplayer = interface(IJavaInstance)
    ['{4B0DF818-B2DF-4DEE-9380-30DB36D5A740}']
    function acceptInvitation(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
    function cancelMatch(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
    function createMatch(P1: JGoogleApiClient; P2: JTurnBasedMatchConfig): JPendingResult; cdecl;
    procedure declineInvitation(P1: JGoogleApiClient; P2: JString); cdecl;
    procedure dismissInvitation(P1: JGoogleApiClient; P2: JString); cdecl;
    procedure dismissMatch(P1: JGoogleApiClient; P2: JString); cdecl;
    function finishMatch(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl; overload;
    function finishMatch(P1: JGoogleApiClient; P2: JString; P3: TJavaArray<Byte>; P4: JList): JPendingResult; cdecl; overload;
    function finishMatch(P1: JGoogleApiClient; P2: JString; P3: TJavaArray<Byte>; P4: TJavaObjectArray<JParticipantResult>): JPendingResult; cdecl; overload;
    function getInboxIntent(P1: JGoogleApiClient): JIntent; cdecl;
    function getMaxMatchDataSize(P1: JGoogleApiClient): Integer; cdecl;
    function getSelectOpponentsIntent(P1: JGoogleApiClient; P2: Integer; P3: Integer): JIntent; cdecl; overload;
    function getSelectOpponentsIntent(P1: JGoogleApiClient; P2: Integer; P3: Integer; P4: Boolean): JIntent; cdecl; overload;
    function leaveMatch(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
    function leaveMatchDuringTurn(P1: JGoogleApiClient; P2: JString; P3: JString): JPendingResult; cdecl;
    function loadMatch(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
    function loadMatchesByStatus(P1: JGoogleApiClient; P2: TJavaArray<Integer>): JPendingResult; cdecl; overload;
    function loadMatchesByStatus(P1: JGoogleApiClient; P2: Integer; P3: TJavaArray<Integer>): JPendingResult; cdecl; overload;
    procedure registerMatchUpdateListener(P1: JGoogleApiClient; P2: JOnTurnBasedMatchUpdateReceivedListener); cdecl;
    function rematch(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
    function takeTurn(P1: JGoogleApiClient; P2: JString; P3: TJavaArray<Byte>; P4: JString): JPendingResult; cdecl; overload;
    function takeTurn(P1: JGoogleApiClient; P2: JString; P3: TJavaArray<Byte>; P4: JString; P5: TJavaObjectArray<JParticipantResult>): JPendingResult; cdecl; overload;
    function takeTurn(P1: JGoogleApiClient; P2: JString; P3: TJavaArray<Byte>; P4: JString; P5: JList): JPendingResult; cdecl; overload;
    procedure unregisterMatchUpdateListener(P1: JGoogleApiClient); cdecl;
  end;
  TJTurnBasedMultiplayer = class(TJavaGenericImport<JTurnBasedMultiplayerClass, JTurnBasedMultiplayer>) end;

  JTurnBasedMultiplayer_CancelMatchResultClass = interface(Japi_ResultClass)
    ['{00689D29-79E4-435C-B192-0459D98069D4}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMultiplayer$CancelMatchResult')]
  JTurnBasedMultiplayer_CancelMatchResult = interface(Japi_Result)
    ['{215C5A5C-60DE-4E1E-B985-AB83191706AF}']
    function getMatchId: JString; cdecl;
  end;
  TJTurnBasedMultiplayer_CancelMatchResult = class(TJavaGenericImport<JTurnBasedMultiplayer_CancelMatchResultClass, JTurnBasedMultiplayer_CancelMatchResult>) end;

  JTurnBasedMultiplayer_InitiateMatchResultClass = interface(Japi_ResultClass)
    ['{CDAEF6C0-647B-4312-82F2-C4001A7A6BD8}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMultiplayer$InitiateMatchResult')]
  JTurnBasedMultiplayer_InitiateMatchResult = interface(Japi_Result)
    ['{B15827DF-BFF6-4252-B8E0-09682BD9CD03}']
    function getMatch: JTurnBasedMatch; cdecl;
  end;
  TJTurnBasedMultiplayer_InitiateMatchResult = class(TJavaGenericImport<JTurnBasedMultiplayer_InitiateMatchResultClass, JTurnBasedMultiplayer_InitiateMatchResult>) end;

  JTurnBasedMultiplayer_LeaveMatchResultClass = interface(Japi_ResultClass)
    ['{DA0CCA23-9021-4661-8202-1E05C9647106}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMultiplayer$LeaveMatchResult')]
  JTurnBasedMultiplayer_LeaveMatchResult = interface(Japi_Result)
    ['{C33033C0-A7C7-4027-ACF2-7CA55314283C}']
    function getMatch: JTurnBasedMatch; cdecl;
  end;
  TJTurnBasedMultiplayer_LeaveMatchResult = class(TJavaGenericImport<JTurnBasedMultiplayer_LeaveMatchResultClass, JTurnBasedMultiplayer_LeaveMatchResult>) end;

  JTurnBasedMultiplayer_LoadMatchResultClass = interface(Japi_ResultClass)
    ['{E5B48A09-C6AE-4180-8F5A-1EF94CBBB9C8}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMultiplayer$LoadMatchResult')]
  JTurnBasedMultiplayer_LoadMatchResult = interface(Japi_Result)
    ['{4A00ED34-6B14-41D6-B473-38A27AFAE258}']
    function getMatch: JTurnBasedMatch; cdecl;
  end;
  TJTurnBasedMultiplayer_LoadMatchResult = class(TJavaGenericImport<JTurnBasedMultiplayer_LoadMatchResultClass, JTurnBasedMultiplayer_LoadMatchResult>) end;

  JTurnBasedMultiplayer_LoadMatchesResultClass = interface(JReleasableClass)
    ['{E624C2E0-1395-4E36-891B-53CB9F3AD6CB}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMultiplayer$LoadMatchesResult')]
  JTurnBasedMultiplayer_LoadMatchesResult = interface(JReleasable)
    ['{58CE62D7-DFDE-4998-9C85-09B98F206D2F}']
    function getMatches: JLoadMatchesResponse; cdecl;
  end;
  TJTurnBasedMultiplayer_LoadMatchesResult = class(TJavaGenericImport<JTurnBasedMultiplayer_LoadMatchesResultClass, JTurnBasedMultiplayer_LoadMatchesResult>) end;

  JTurnBasedMultiplayer_UpdateMatchResultClass = interface(Japi_ResultClass)
    ['{3F5FDD6B-7F93-4D99-989B-858C8195FF9A}']
  end;

  [JavaSignature('com/google/android/gms/games/multiplayer/turnbased/TurnBasedMultiplayer$UpdateMatchResult')]
  JTurnBasedMultiplayer_UpdateMatchResult = interface(Japi_Result)
    ['{AAB2F685-D99E-4D81-9377-C0120E886D92}']
    function getMatch: JTurnBasedMatch; cdecl;
  end;
  TJTurnBasedMultiplayer_UpdateMatchResult = class(TJavaGenericImport<JTurnBasedMultiplayer_UpdateMatchResultClass, JTurnBasedMultiplayer_UpdateMatchResult>) end;

  JGameRequestClass = interface(JParcelableClass)
    ['{6DAD5588-CD4D-469A-A7C0-5BF7CB1CED72}']
    {class} function _GetRECIPIENT_STATUS_ACCEPTED: Integer; cdecl;
    {class} function _GetRECIPIENT_STATUS_PENDING: Integer; cdecl;
    {class} function _GetTYPE_ALL: Integer; cdecl;
    {class} function _GetTYPE_GIFT: Integer; cdecl;
    {class} function _GetTYPE_WISH: Integer; cdecl;
    {class} property RECIPIENT_STATUS_ACCEPTED: Integer read _GetRECIPIENT_STATUS_ACCEPTED;
    {class} property RECIPIENT_STATUS_PENDING: Integer read _GetRECIPIENT_STATUS_PENDING;
    {class} property TYPE_ALL: Integer read _GetTYPE_ALL;
    {class} property TYPE_GIFT: Integer read _GetTYPE_GIFT;
    {class} property TYPE_WISH: Integer read _GetTYPE_WISH;
  end;

  [JavaSignature('com/google/android/gms/games/request/GameRequest')]
  JGameRequest = interface(JParcelable)
    ['{70609BDA-B518-4AD2-9FDE-30BF7DF43336}']
    function fU: JArrayList; cdecl;
    function getCreationTimestamp: Int64; cdecl;
    function getData: TJavaArray<Byte>; cdecl;
    function getExpirationTimestamp: Int64; cdecl;
    function getGame: JGame; cdecl;
    function getRecipient: JPlayer; cdecl;
    function getRecipientStatus: Integer; cdecl; overload;
    function getRecipientStatus(P1: JString): Integer; cdecl; overload;
    function getRequestId: JString; cdecl;
    function getSender: JPlayer; cdecl;
    function getType: Integer; cdecl;
    function isConsumed: Boolean; cdecl;
  end;
  TJGameRequest = class(TJavaGenericImport<JGameRequestClass, JGameRequest>) end;

  // com.google.android.gms.games.request.GameRequestBuffer
  JGameRequestEntityClass = interface(JObjectClass)
    ['{AB7AEABD-B81B-4280-8D5F-9A935E811E93}']
    {class} function _GetCREATOR: JGameRequestEntityCreator; cdecl;
    {class} function init(request: JGameRequest): JGameRequestEntity; cdecl; overload;
    {class} property CREATOR: JGameRequestEntityCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/games/request/GameRequestEntity')]
  JGameRequestEntity = interface(JObject)
    ['{4048B292-ADF1-4A22-B012-498F04F17F43}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function fU: JArrayList; cdecl;
    function freeze: JGameRequest; cdecl;
    function getCreationTimestamp: Int64; cdecl;
    function getData: TJavaArray<Byte>; cdecl;
    function getExpirationTimestamp: Int64; cdecl;
    function getGame: JGame; cdecl;
    function getRecipient: JPlayer; cdecl;
    function getRecipientStatus: Integer; cdecl; overload;
    function getRecipientStatus(playerId: JString): Integer; cdecl; overload;
    function getRequestId: JString; cdecl;
    function getSender: JPlayer; cdecl;
    function getType: Integer; cdecl;
    function getVersionCode: Integer; cdecl;
    function gf: JBundle; cdecl;
    function hashCode: Integer; cdecl;
    function isConsumed: Boolean; cdecl;
    function isDataValid: Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJGameRequestEntity = class(TJavaGenericImport<JGameRequestEntityClass, JGameRequestEntity>) end;

  JGameRequestEntityCreatorClass = interface(JObjectClass)
    ['{50DD5950-4AD4-454C-B289-F557D8EBB681}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JGameRequestEntityCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/games/request/GameRequestEntityCreator')]
  JGameRequestEntityCreator = interface(JObject)
    ['{9868F73A-2A83-42EA-9274-DAC09233DB3A}']
    function createFromParcel(parcel: JParcel): JGameRequestEntity; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JGameRequestEntity>; cdecl;
  end;
  TJGameRequestEntityCreator = class(TJavaGenericImport<JGameRequestEntityCreatorClass, JGameRequestEntityCreator>) end;

  JOnRequestReceivedListenerClass = interface(IJavaClass)
    ['{336594BE-184D-4760-B289-9F58F433E19D}']
  end;

  [JavaSignature('com/google/android/gms/games/request/OnRequestReceivedListener')]
  JOnRequestReceivedListener = interface(IJavaInstance)
    ['{DD30FCA8-4BE4-43D5-8F06-A7126CF9A61A}']
    procedure onRequestReceived(P1: JGameRequest); cdecl;
    procedure onRequestRemoved(P1: JString); cdecl;
  end;
  TJOnRequestReceivedListener = class(TJavaGenericImport<JOnRequestReceivedListenerClass, JOnRequestReceivedListener>) end;

  JRequestsClass = interface(IJavaClass)
    ['{6C6595E8-3441-4173-97CA-480352E053B0}']
    {class} function _GetEXTRA_REQUESTS: JString; cdecl;
    {class} function _GetREQUEST_DEFAULT_LIFETIME_DAYS: Integer; cdecl;
    {class} function _GetREQUEST_DIRECTION_INBOUND: Integer; cdecl;
    {class} function _GetREQUEST_DIRECTION_OUTBOUND: Integer; cdecl;
    {class} function _GetREQUEST_UPDATE_OUTCOME_FAIL: Integer; cdecl;
    {class} function _GetREQUEST_UPDATE_OUTCOME_RETRY: Integer; cdecl;
    {class} function _GetREQUEST_UPDATE_OUTCOME_SUCCESS: Integer; cdecl;
    {class} function _GetREQUEST_UPDATE_TYPE_ACCEPT: Integer; cdecl;
    {class} function _GetREQUEST_UPDATE_TYPE_DISMISS: Integer; cdecl;
    {class} function _GetSORT_ORDER_EXPIRING_SOON_FIRST: Integer; cdecl;
    {class} function _GetSORT_ORDER_SOCIAL_AGGREGATION: Integer; cdecl;
    {class} property EXTRA_REQUESTS: JString read _GetEXTRA_REQUESTS;
    {class} property REQUEST_DEFAULT_LIFETIME_DAYS: Integer read _GetREQUEST_DEFAULT_LIFETIME_DAYS;
    {class} property REQUEST_DIRECTION_INBOUND: Integer read _GetREQUEST_DIRECTION_INBOUND;
    {class} property REQUEST_DIRECTION_OUTBOUND: Integer read _GetREQUEST_DIRECTION_OUTBOUND;
    {class} property REQUEST_UPDATE_OUTCOME_FAIL: Integer read _GetREQUEST_UPDATE_OUTCOME_FAIL;
    {class} property REQUEST_UPDATE_OUTCOME_RETRY: Integer read _GetREQUEST_UPDATE_OUTCOME_RETRY;
    {class} property REQUEST_UPDATE_OUTCOME_SUCCESS: Integer read _GetREQUEST_UPDATE_OUTCOME_SUCCESS;
    {class} property REQUEST_UPDATE_TYPE_ACCEPT: Integer read _GetREQUEST_UPDATE_TYPE_ACCEPT;
    {class} property REQUEST_UPDATE_TYPE_DISMISS: Integer read _GetREQUEST_UPDATE_TYPE_DISMISS;
    {class} property SORT_ORDER_EXPIRING_SOON_FIRST: Integer read _GetSORT_ORDER_EXPIRING_SOON_FIRST;
    {class} property SORT_ORDER_SOCIAL_AGGREGATION: Integer read _GetSORT_ORDER_SOCIAL_AGGREGATION;
  end;

  [JavaSignature('com/google/android/gms/games/request/Requests')]
  JRequests = interface(IJavaInstance)
    ['{CBF33035-7D1A-491E-BF89-226CCB0D1880}']
    function acceptRequest(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
    function acceptRequests(P1: JGoogleApiClient; P2: JList): JPendingResult; cdecl;
    function dismissRequest(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
    function dismissRequests(P1: JGoogleApiClient; P2: JList): JPendingResult; cdecl;
    function getGameRequestsFromBundle(P1: JBundle): JArrayList; cdecl;
    function getGameRequestsFromInboxResponse(P1: JIntent): JArrayList; cdecl;
    function getInboxIntent(P1: JGoogleApiClient): JIntent; cdecl;
    function getMaxLifetimeDays(P1: JGoogleApiClient): Integer; cdecl;
    function getMaxPayloadSize(P1: JGoogleApiClient): Integer; cdecl;
    function getSendIntent(P1: JGoogleApiClient; P2: Integer; P3: TJavaArray<Byte>; P4: Integer; P5: JBitmap; P6: JString): JIntent; cdecl;
    function loadRequests(P1: JGoogleApiClient; P2: Integer; P3: Integer; P4: Integer): JPendingResult; cdecl;
    procedure registerRequestListener(P1: JGoogleApiClient; P2: JOnRequestReceivedListener); cdecl;
    procedure unregisterRequestListener(P1: JGoogleApiClient); cdecl;
  end;
  TJRequests = class(TJavaGenericImport<JRequestsClass, JRequests>) end;

  JRequests_LoadRequestsResultClass = interface(JReleasableClass)
    ['{AB63BE05-AE84-441E-B4AC-256BD71A0F54}']
  end;

  [JavaSignature('com/google/android/gms/games/request/Requests$LoadRequestsResult')]
  JRequests_LoadRequestsResult = interface(JReleasable)
    ['{90E3224D-5E03-4174-8216-2FFCBD9A49CF}']
    //function getRequests(P1: Integer): JGameRequestBuffer; cdecl;
  end;
  TJRequests_LoadRequestsResult = class(TJavaGenericImport<JRequests_LoadRequestsResultClass, JRequests_LoadRequestsResult>) end;

  JRequests_UpdateRequestsResultClass = interface(JReleasableClass)
    ['{071DD03A-A2FD-41A4-BDCC-0A481CA73422}']
  end;

  [JavaSignature('com/google/android/gms/games/request/Requests$UpdateRequestsResult')]
  JRequests_UpdateRequestsResult = interface(JReleasable)
    ['{1FF36067-6392-4CD1-BC48-932275820982}']
    function getRequestIds: JSet; cdecl;
    function getRequestOutcome(P1: JString): Integer; cdecl;
  end;
  TJRequests_UpdateRequestsResult = class(TJavaGenericImport<JRequests_UpdateRequestsResultClass, JRequests_UpdateRequestsResult>) end;

  JGoogleCloudMessagingClass = interface(JObjectClass)
    ['{452B4174-FF9C-48F5-9609-674C8206C28A}']
    {class} function _GetERROR_MAIN_THREAD: JString; cdecl;
    {class} function _GetERROR_SERVICE_NOT_AVAILABLE: JString; cdecl;
    {class} function _GetMESSAGE_TYPE_DELETED: JString; cdecl;
    {class} function _GetMESSAGE_TYPE_MESSAGE: JString; cdecl;
    {class} function _GetMESSAGE_TYPE_SEND_ERROR: JString; cdecl;
    {class} function getInstance(context: JContext): JGoogleCloudMessaging; cdecl;
    {class} function init: JGoogleCloudMessaging; cdecl;
    {class} property ERROR_MAIN_THREAD: JString read _GetERROR_MAIN_THREAD;
    {class} property ERROR_SERVICE_NOT_AVAILABLE: JString read _GetERROR_SERVICE_NOT_AVAILABLE;
    {class} property MESSAGE_TYPE_DELETED: JString read _GetMESSAGE_TYPE_DELETED;
    {class} property MESSAGE_TYPE_MESSAGE: JString read _GetMESSAGE_TYPE_MESSAGE;
    {class} property MESSAGE_TYPE_SEND_ERROR: JString read _GetMESSAGE_TYPE_SEND_ERROR;
  end;

  [JavaSignature('com/google/android/gms/gcm/GoogleCloudMessaging')]
  JGoogleCloudMessaging = interface(JObject)
    ['{A4F0B5B0-FCB2-45F8-A3CB-D37481F2FBD8}']
    procedure close; cdecl;
    function getMessageType(intent: JIntent): JString; cdecl;
    function register(senderIds: TJavaObjectArray<JString>): JString; cdecl;
    procedure send(to_: JString; msgId: JString; data: JBundle); cdecl; overload;
    procedure send(to_: JString; msgId: JString; timeToLive: Int64; data: JBundle); cdecl; overload;
    procedure unregister; cdecl;
  end;
  TJGoogleCloudMessaging = class(TJavaGenericImport<JGoogleCloudMessagingClass, JGoogleCloudMessaging>) end;

  Jintents_AddressClass = interface(JObjectClass)
    ['{DBF3A3AE-E129-45AC-A4D9-2C87DD1DAFBB}']
    {class} //function _GetAPI: JApi; cdecl;
    {class} function init: Jintents_Address; cdecl;
    {class} procedure requestUserAddress(googleApiClient: JGoogleApiClient; request: JUserAddressRequest; requestCode: Integer); cdecl;
    {class} //property API: JApi read _GetAPI;
  end;

  [JavaSignature('com/google/android/gms/identity/intents/Address')]
  Jintents_Address = interface(JObject)
    ['{2AC3757E-5A92-4C8A-95CB-DAFE3B20EA96}']
  end;
  TJintents_Address = class(TJavaGenericImport<Jintents_AddressClass, Jintents_Address>) end;

  JAddress_AddressOptionsClass = interface(JObjectClass)
    ['{3D8E2465-5B20-49C8-B6CB-A22E9CA07A8C}']
    {class} function init: JAddress_AddressOptions; cdecl; overload;
    {class} function init(theme: Integer): JAddress_AddressOptions; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/identity/intents/Address$AddressOptions')]
  JAddress_AddressOptions = interface(JObject)
    ['{DE0F410A-6A53-4C94-808C-DA5B1EAB3975}']
    function _Gettheme: Integer; cdecl;
    property theme: Integer read _Gettheme;
  end;
  TJAddress_AddressOptions = class(TJavaGenericImport<JAddress_AddressOptionsClass, JAddress_AddressOptions>) end;

  JAddressConstantsClass = interface(IJavaClass)
    ['{9B4E2D73-17C3-40A7-BC9B-F0CED8A55626}']
  end;

  [JavaSignature('com/google/android/gms/identity/intents/AddressConstants')]
  JAddressConstants = interface(IJavaInstance)
    ['{C5EB8FCB-B4BA-4377-9D58-BAD48980576A}']
  end;
  TJAddressConstants = class(TJavaGenericImport<JAddressConstantsClass, JAddressConstants>) end;

  JAddressConstants_ErrorCodesClass = interface(IJavaClass)
    ['{E14113DD-B9B4-417E-81BF-6604E2675651}']
    {class} function _GetERROR_CODE_NO_APPLICABLE_ADDRESSES: Integer; cdecl;
    {class} property ERROR_CODE_NO_APPLICABLE_ADDRESSES: Integer read _GetERROR_CODE_NO_APPLICABLE_ADDRESSES;
  end;

  [JavaSignature('com/google/android/gms/identity/intents/AddressConstants$ErrorCodes')]
  JAddressConstants_ErrorCodes = interface(IJavaInstance)
    ['{666CB3AB-56A5-44F5-B458-12A5E36A0B6F}']
  end;
  TJAddressConstants_ErrorCodes = class(TJavaGenericImport<JAddressConstants_ErrorCodesClass, JAddressConstants_ErrorCodes>) end;

  JAddressConstants_ExtrasClass = interface(IJavaClass)
    ['{549D643A-E12F-4138-BD39-79B0518F40A7}']
    {class} function _GetEXTRA_ADDRESS: JString; cdecl;
    {class} function _GetEXTRA_ERROR_CODE: JString; cdecl;
    {class} property EXTRA_ADDRESS: JString read _GetEXTRA_ADDRESS;
    {class} property EXTRA_ERROR_CODE: JString read _GetEXTRA_ERROR_CODE;
  end;

  [JavaSignature('com/google/android/gms/identity/intents/AddressConstants$Extras')]
  JAddressConstants_Extras = interface(IJavaInstance)
    ['{6F864646-3C19-47D0-8920-E258F135BB7C}']
  end;
  TJAddressConstants_Extras = class(TJavaGenericImport<JAddressConstants_ExtrasClass, JAddressConstants_Extras>) end;

  JAddressConstants_ResultCodesClass = interface(IJavaClass)
    ['{5F369424-C926-4B91-907A-D248459BE02A}']
    {class} function _GetRESULT_ERROR: Integer; cdecl;
    {class} property RESULT_ERROR: Integer read _GetRESULT_ERROR;
  end;

  [JavaSignature('com/google/android/gms/identity/intents/AddressConstants$ResultCodes')]
  JAddressConstants_ResultCodes = interface(IJavaInstance)
    ['{BED01B31-C1C4-4F8B-8FAD-1F0E0A2A6636}']
  end;
  TJAddressConstants_ResultCodes = class(TJavaGenericImport<JAddressConstants_ResultCodesClass, JAddressConstants_ResultCodes>) end;

  JAddressConstants_ThemesClass = interface(IJavaClass)
    ['{94A8196A-D22C-4F10-8A71-BE510ADCB6B6}']
    {class} function _GetTHEME_HOLO_DARK: Integer; cdecl;
    {class} function _GetTHEME_HOLO_LIGHT: Integer; cdecl;
    {class} property THEME_HOLO_DARK: Integer read _GetTHEME_HOLO_DARK;
    {class} property THEME_HOLO_LIGHT: Integer read _GetTHEME_HOLO_LIGHT;
  end;

  [JavaSignature('com/google/android/gms/identity/intents/AddressConstants$Themes')]
  JAddressConstants_Themes = interface(IJavaInstance)
    ['{4DE2D115-7F21-4716-915E-76B606E59EF7}']
  end;
  TJAddressConstants_Themes = class(TJavaGenericImport<JAddressConstants_ThemesClass, JAddressConstants_Themes>) end;

  JUserAddressRequestClass = interface(JObjectClass)
    ['{7769F733-61A6-4ED8-9898-9FB3C4846183}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function newBuilder: JUserAddressRequest_Builder; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/identity/intents/UserAddressRequest')]
  JUserAddressRequest = interface(JObject)
    ['{99E3E81E-CB5D-4FB7-808C-44BC38D6B7F7}']
    function describeContents: Integer; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJUserAddressRequest = class(TJavaGenericImport<JUserAddressRequestClass, JUserAddressRequest>) end;

  JUserAddressRequest_BuilderClass = interface(JObjectClass)
    ['{56B47CD2-8B63-4F0B-BB68-0EB44ADD96C2}']
  end;

  [JavaSignature('com/google/android/gms/identity/intents/UserAddressRequest$Builder')]
  JUserAddressRequest_Builder = interface(JObject)
    ['{2E269938-5C3C-4061-8D5C-A401679EB227}']
    function addAllowedCountrySpecification(countrySpecification: JCountrySpecification): JUserAddressRequest_Builder; cdecl;
    function addAllowedCountrySpecifications(countrySpecifications: JCollection): JUserAddressRequest_Builder; cdecl;
    function build: JUserAddressRequest; cdecl;
  end;
  TJUserAddressRequest_Builder = class(TJavaGenericImport<JUserAddressRequest_BuilderClass, JUserAddressRequest_Builder>) end;

  JCountrySpecificationClass = interface(JObjectClass)
    ['{2D2AFA53-034E-44CB-9A89-7412861AC785}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(countryCode: JString): JCountrySpecification; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/identity/intents/model/CountrySpecification')]
  JCountrySpecification = interface(JObject)
    ['{E113A36B-85D5-49EF-AFAF-E1970E16C43C}']
    function describeContents: Integer; cdecl;
    function getCountryCode: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCountrySpecification = class(TJavaGenericImport<JCountrySpecificationClass, JCountrySpecification>) end;

  JUserAddressClass = interface(JObjectClass)
    ['{183AC8EE-44C2-4A5F-ABBE-C991DACC2F93}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function fromIntent(data: JIntent): JUserAddress; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/identity/intents/model/UserAddress')]
  JUserAddress = interface(JObject)
    ['{23D9A9E0-C6CC-4336-83E6-67FAE1D26C9F}']
    function describeContents: Integer; cdecl;
    function getAddress1: JString; cdecl;
    function getAddress2: JString; cdecl;
    function getAddress3: JString; cdecl;
    function getAddress4: JString; cdecl;
    function getAddress5: JString; cdecl;
    function getAdministrativeArea: JString; cdecl;
    function getCompanyName: JString; cdecl;
    function getCountryCode: JString; cdecl;
    function getEmailAddress: JString; cdecl;
    function getLocality: JString; cdecl;
    function getName: JString; cdecl;
    function getPhoneNumber: JString; cdecl;
    function getPostalCode: JString; cdecl;
    function getSortingCode: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    function isPostBox: Boolean; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJUserAddress = class(TJavaGenericImport<JUserAddressClass, JUserAddress>) end;

  JActivityRecognitionClientClass = interface(JObjectClass)
    ['{95B0BA47-C41F-422C-BDB9-5E46A67A208E}']
    {class} function init(context: JContext; connectedListener: JGooglePlayServicesClient_ConnectionCallbacks; connectionFailedListener: JGooglePlayServicesClient_OnConnectionFailedListener): JActivityRecognitionClient; cdecl;
  end;

  [JavaSignature('com/google/android/gms/location/ActivityRecognitionClient')]
  JActivityRecognitionClient = interface(JObject)
    ['{2F41C8A5-18B8-495C-B359-D9BE961E5AD3}']
    procedure connect; cdecl;
    procedure disconnect; cdecl;
    function isConnected: Boolean; cdecl;
    function isConnecting: Boolean; cdecl;
    function isConnectionCallbacksRegistered(listener: JGooglePlayServicesClient_ConnectionCallbacks): Boolean; cdecl;
    function isConnectionFailedListenerRegistered(listener: JGooglePlayServicesClient_OnConnectionFailedListener): Boolean; cdecl;
    procedure registerConnectionCallbacks(listener: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure registerConnectionFailedListener(listener: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
    procedure removeActivityUpdates(callbackIntent: JPendingIntent); cdecl;
    procedure requestActivityUpdates(detectionIntervalMillis: Int64; callbackIntent: JPendingIntent); cdecl;
    procedure unregisterConnectionCallbacks(listener: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure unregisterConnectionFailedListener(listener: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
  end;
  TJActivityRecognitionClient = class(TJavaGenericImport<JActivityRecognitionClientClass, JActivityRecognitionClient>) end;

  JActivityRecognitionResultClass = interface(JObjectClass)
    ['{454FB055-9DBD-42AB-898C-FEA2F58D210B}']
    {class} function _GetCREATOR: JActivityRecognitionResultCreator; cdecl;
    {class} function _GetEXTRA_ACTIVITY_RESULT: JString; cdecl;
    {class} function extractResult(intent: JIntent): JActivityRecognitionResult; cdecl;
    {class} function hasResult(intent: JIntent): Boolean; cdecl;
    {class} function init(probableActivities: JList; time: Int64; elapsedRealtimeMillis: Int64): JActivityRecognitionResult; cdecl; overload;
    {class} function init(mostProbableActivity: JDetectedActivity; time: Int64; elapsedRealtimeMillis: Int64): JActivityRecognitionResult; cdecl; overload;
    {class} function init(versionCode: Integer; probableActivities: JList; timeMillis: Int64; elapsedRealtimeMillis: Int64): JActivityRecognitionResult; cdecl; overload;
    {class} property CREATOR: JActivityRecognitionResultCreator read _GetCREATOR;
    {class} property EXTRA_ACTIVITY_RESULT: JString read _GetEXTRA_ACTIVITY_RESULT;
  end;

  [JavaSignature('com/google/android/gms/location/ActivityRecognitionResult')]
  JActivityRecognitionResult = interface(JObject)
    ['{D9E1E70E-2A71-4999-9A98-8A3FC0137BB3}']
    function describeContents: Integer; cdecl;
    function getActivityConfidence(activityType: Integer): Integer; cdecl;
    function getElapsedRealtimeMillis: Int64; cdecl;
    function getMostProbableActivity: JDetectedActivity; cdecl;
    function getProbableActivities: JList; cdecl;
    function getTime: Int64; cdecl;
    function getVersionCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJActivityRecognitionResult = class(TJavaGenericImport<JActivityRecognitionResultClass, JActivityRecognitionResult>) end;

  JActivityRecognitionResultCreatorClass = interface(JObjectClass)
    ['{6A3F9406-3D43-411E-8C6B-9EFD51DAD599}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JActivityRecognitionResultCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/location/ActivityRecognitionResultCreator')]
  JActivityRecognitionResultCreator = interface(JObject)
    ['{0CD362C5-4246-4771-9F67-0079A2D4889A}']
    function createFromParcel(parcel: JParcel): JActivityRecognitionResult; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JActivityRecognitionResult>; cdecl;
  end;
  TJActivityRecognitionResultCreator = class(TJavaGenericImport<JActivityRecognitionResultCreatorClass, JActivityRecognitionResultCreator>) end;

  JDetectedActivityClass = interface(JObjectClass)
    ['{4BF1C57E-0AC8-498A-9EE6-506F8D632C07}']
    {class} function _GetCREATOR: JDetectedActivityCreator; cdecl;
    {class} function _GetIN_VEHICLE: Integer; cdecl;
    {class} function _GetON_BICYCLE: Integer; cdecl;
    {class} function _GetON_FOOT: Integer; cdecl;
    {class} function _GetSTILL: Integer; cdecl;
    {class} function _GetTILTING: Integer; cdecl;
    {class} function _GetUNKNOWN: Integer; cdecl;
    {class} function init(activityType: Integer; confidence: Integer): JDetectedActivity; cdecl; overload;
    {class} function init(versionCode: Integer; activityType: Integer; confidence: Integer): JDetectedActivity; cdecl; overload;
    {class} property CREATOR: JDetectedActivityCreator read _GetCREATOR;
    {class} property IN_VEHICLE: Integer read _GetIN_VEHICLE;
    {class} property ON_BICYCLE: Integer read _GetON_BICYCLE;
    {class} property ON_FOOT: Integer read _GetON_FOOT;
    {class} property STILL: Integer read _GetSTILL;
    {class} property TILTING: Integer read _GetTILTING;
    {class} property UNKNOWN: Integer read _GetUNKNOWN;
  end;

  [JavaSignature('com/google/android/gms/location/DetectedActivity')]
  JDetectedActivity = interface(JObject)
    ['{8A5265C3-15DA-4CEC-87AF-F46270E042F6}']
    function describeContents: Integer; cdecl;
    function getConfidence: Integer; cdecl;
    function getType: Integer; cdecl;
    function getVersionCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJDetectedActivity = class(TJavaGenericImport<JDetectedActivityClass, JDetectedActivity>) end;

  JDetectedActivityCreatorClass = interface(JObjectClass)
    ['{73440C81-DB55-48AC-983D-0B5D428937A2}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JDetectedActivityCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/location/DetectedActivityCreator')]
  JDetectedActivityCreator = interface(JObject)
    ['{8FB1C7BF-D0DF-4BD7-B5FE-B9B5EA0C0A1B}']
    function createFromParcel(parcel: JParcel): JDetectedActivity; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JDetectedActivity>; cdecl;
  end;
  TJDetectedActivityCreator = class(TJavaGenericImport<JDetectedActivityCreatorClass, JDetectedActivityCreator>) end;

  JGeofenceClass = interface(IJavaClass)
    ['{CF428A28-2F37-48E7-9D9F-C67737813FE0}']
    {class} function _GetGEOFENCE_TRANSITION_DWELL: Integer; cdecl;
    {class} function _GetGEOFENCE_TRANSITION_ENTER: Integer; cdecl;
    {class} function _GetGEOFENCE_TRANSITION_EXIT: Integer; cdecl;
    {class} function _GetNEVER_EXPIRE: Int64; cdecl;
    {class} property GEOFENCE_TRANSITION_DWELL: Integer read _GetGEOFENCE_TRANSITION_DWELL;
    {class} property GEOFENCE_TRANSITION_ENTER: Integer read _GetGEOFENCE_TRANSITION_ENTER;
    {class} property GEOFENCE_TRANSITION_EXIT: Integer read _GetGEOFENCE_TRANSITION_EXIT;
    {class} property NEVER_EXPIRE: Int64 read _GetNEVER_EXPIRE;
  end;

  [JavaSignature('com/google/android/gms/location/Geofence')]
  JGeofence = interface(IJavaInstance)
    ['{03F411F4-AF94-4BCE-B572-036C56891F2B}']
    function getRequestId: JString; cdecl;
  end;
  TJGeofence = class(TJavaGenericImport<JGeofenceClass, JGeofence>) end;

  JGeofence_BuilderClass = interface(JObjectClass)
    ['{1B065D39-AA46-4D6C-90DB-9E097BAE3C0A}']
    {class} function init: JGeofence_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/location/Geofence$Builder')]
  JGeofence_Builder = interface(JObject)
    ['{64706B21-BE55-455E-8488-7A316C9184CE}']
    function build: JGeofence; cdecl;
    function setCircularRegion(latitude: Double; longitude: Double; radius: Single): JGeofence_Builder; cdecl;
    function setExpirationDuration(durationMillis: Int64): JGeofence_Builder; cdecl;
    function setLoiteringDelay(loiteringDelayMs: Integer): JGeofence_Builder; cdecl;
    function setNotificationResponsiveness(notificationResponsivenessMs: Integer): JGeofence_Builder; cdecl;
    function setRequestId(requestId: JString): JGeofence_Builder; cdecl;
    function setTransitionTypes(transitionTypes: Integer): JGeofence_Builder; cdecl;
  end;
  TJGeofence_Builder = class(TJavaGenericImport<JGeofence_BuilderClass, JGeofence_Builder>) end;

  JGeofenceStatusCodesClass = interface(JCommonStatusCodesClass)
    ['{B47354B9-C242-4A10-9B83-BDCA3C4747F1}']
    {class} function _GetGEOFENCE_NOT_AVAILABLE: Integer; cdecl;
    {class} function _GetGEOFENCE_TOO_MANY_GEOFENCES: Integer; cdecl;
    {class} function _GetGEOFENCE_TOO_MANY_PENDING_INTENTS: Integer; cdecl;
    {class} property GEOFENCE_NOT_AVAILABLE: Integer read _GetGEOFENCE_NOT_AVAILABLE;
    {class} property GEOFENCE_TOO_MANY_GEOFENCES: Integer read _GetGEOFENCE_TOO_MANY_GEOFENCES;
    {class} property GEOFENCE_TOO_MANY_PENDING_INTENTS: Integer read _GetGEOFENCE_TOO_MANY_PENDING_INTENTS;
  end;

  [JavaSignature('com/google/android/gms/location/GeofenceStatusCodes')]
  JGeofenceStatusCodes = interface(JCommonStatusCodes)
    ['{63DCF9DB-94B3-4594-8897-E2A31B5EB7ED}']
  end;
  TJGeofenceStatusCodes = class(TJavaGenericImport<JGeofenceStatusCodesClass, JGeofenceStatusCodes>) end;

  JLocationClientClass = interface(JObjectClass)
    ['{19DD64B8-D7AB-46B0-8B0D-1BCE42BED9E8}']
    {class} function _GetKEY_LOCATION_CHANGED: JString; cdecl;
    {class} function _GetKEY_MOCK_LOCATION: JString; cdecl;
    {class} function getErrorCode(intent: JIntent): Integer; cdecl;
    {class} function getGeofenceTransition(intent: JIntent): Integer; cdecl;
    {class} function getTriggeringGeofences(intent: JIntent): JList; cdecl;
    {class} function hasError(intent: JIntent): Boolean; cdecl;
    {class} function init(context: JContext; connectionCallbacks: JGooglePlayServicesClient_ConnectionCallbacks; connectionFailedListener: JGooglePlayServicesClient_OnConnectionFailedListener): JLocationClient; cdecl;
    {class} property KEY_LOCATION_CHANGED: JString read _GetKEY_LOCATION_CHANGED;
    {class} property KEY_MOCK_LOCATION: JString read _GetKEY_MOCK_LOCATION;
  end;

  [JavaSignature('com/google/android/gms/location/LocationClient')]
  JLocationClient = interface(JObject)
    ['{259FAD38-6C6B-4F7A-AB03-F40E8B41FF0E}']
    procedure addGeofences(geofences: JList; pendingIntent: JPendingIntent; listener: JLocationClient_OnAddGeofencesResultListener); cdecl;
    procedure connect; cdecl;
    procedure disconnect; cdecl;
    function getLastLocation: JLocation; cdecl;
    function isConnected: Boolean; cdecl;
    function isConnecting: Boolean; cdecl;
    function isConnectionCallbacksRegistered(listener: JGooglePlayServicesClient_ConnectionCallbacks): Boolean; cdecl;
    function isConnectionFailedListenerRegistered(listener: JGooglePlayServicesClient_OnConnectionFailedListener): Boolean; cdecl;
    procedure registerConnectionCallbacks(listener: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure registerConnectionFailedListener(listener: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
    procedure removeGeofences(geofenceRequestIds: JList; listener: JLocationClient_OnRemoveGeofencesResultListener); cdecl; overload;
    procedure removeGeofences(pendingIntent: JPendingIntent; listener: JLocationClient_OnRemoveGeofencesResultListener); cdecl; overload;
    procedure removeLocationUpdates(callbackIntent: JPendingIntent); cdecl; overload;
    procedure removeLocationUpdates(listener: Jlocation_LocationListener); cdecl; overload;
    procedure requestLocationUpdates(request: JLocationRequest; listener: Jlocation_LocationListener); cdecl; overload;
    procedure requestLocationUpdates(request: JLocationRequest; callbackIntent: JPendingIntent); cdecl; overload;
    procedure requestLocationUpdates(request: JLocationRequest; listener: Jlocation_LocationListener; looper: JLooper); cdecl; overload;
    procedure setMockLocation(mockLocation: JLocation); cdecl;
    procedure setMockMode(isMockMode: Boolean); cdecl;
    procedure unregisterConnectionCallbacks(listener: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure unregisterConnectionFailedListener(listener: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
  end;
  TJLocationClient = class(TJavaGenericImport<JLocationClientClass, JLocationClient>) end;

  JLocationClient_OnAddGeofencesResultListenerClass = interface(IJavaClass)
    ['{6F178CD1-33E6-47D5-BA34-1C1C6C0CD9E9}']
  end;

  [JavaSignature('com/google/android/gms/location/LocationClient$OnAddGeofencesResultListener')]
  JLocationClient_OnAddGeofencesResultListener = interface(IJavaInstance)
    ['{699002BC-F53B-4868-88FA-884F26323132}']
    procedure onAddGeofencesResult(P1: Integer; P2: TJavaObjectArray<JString>); cdecl;
  end;
  TJLocationClient_OnAddGeofencesResultListener = class(TJavaGenericImport<JLocationClient_OnAddGeofencesResultListenerClass, JLocationClient_OnAddGeofencesResultListener>) end;

  JLocationClient_OnRemoveGeofencesResultListenerClass = interface(IJavaClass)
    ['{592937ED-EA3B-43A9-9B13-BF89F0B46332}']
  end;

  [JavaSignature('com/google/android/gms/location/LocationClient$OnRemoveGeofencesResultListener')]
  JLocationClient_OnRemoveGeofencesResultListener = interface(IJavaInstance)
    ['{B3640090-9A62-45D6-949E-6B8253D9785F}']
    procedure onRemoveGeofencesByPendingIntentResult(P1: Integer; P2: JPendingIntent); cdecl;
    procedure onRemoveGeofencesByRequestIdsResult(P1: Integer; P2: TJavaObjectArray<JString>); cdecl;
  end;
  TJLocationClient_OnRemoveGeofencesResultListener = class(TJavaGenericImport<JLocationClient_OnRemoveGeofencesResultListenerClass, JLocationClient_OnRemoveGeofencesResultListener>) end;

  Jlocation_LocationListenerClass = interface(IJavaClass)
    ['{FCF58DA8-B892-497A-A676-40D6D32A4DE9}']
  end;

  [JavaSignature('com/google/android/gms/location/LocationListener')]
  Jlocation_LocationListener = interface(IJavaInstance)
    ['{01DB4B21-C92D-4BBC-8D21-D8270F4C0370}']
    procedure onLocationChanged(P1: JLocation); cdecl;
  end;
  TJlocation_LocationListener = class(TJavaGenericImport<Jlocation_LocationListenerClass, Jlocation_LocationListener>) end;

  JLocationRequestClass = interface(JObjectClass)
    ['{05119402-67C2-4B28-9127-852977268AC1}']
    {class} function _GetCREATOR: JLocationRequestCreator; cdecl;
    {class} function _GetPRIORITY_BALANCED_POWER_ACCURACY: Integer; cdecl;
    {class} function _GetPRIORITY_HIGH_ACCURACY: Integer; cdecl;
    {class} function _GetPRIORITY_LOW_POWER: Integer; cdecl;
    {class} function _GetPRIORITY_NO_POWER: Integer; cdecl;
    {class} function bj(P1: Integer): JString; cdecl;
    {class} function create: JLocationRequest; cdecl;
    {class} function init: JLocationRequest; cdecl; overload;
    {class} property CREATOR: JLocationRequestCreator read _GetCREATOR;
    {class} property PRIORITY_BALANCED_POWER_ACCURACY: Integer read _GetPRIORITY_BALANCED_POWER_ACCURACY;
    {class} property PRIORITY_HIGH_ACCURACY: Integer read _GetPRIORITY_HIGH_ACCURACY;
    {class} property PRIORITY_LOW_POWER: Integer read _GetPRIORITY_LOW_POWER;
    {class} property PRIORITY_NO_POWER: Integer read _GetPRIORITY_NO_POWER;
  end;

  [JavaSignature('com/google/android/gms/location/LocationRequest')]
  JLocationRequest = interface(JObject)
    ['{C5E84DA4-6E65-4EBC-85C2-E084C59E736B}']
    function describeContents: Integer; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function getExpirationTime: Int64; cdecl;
    function getFastestInterval: Int64; cdecl;
    function getInterval: Int64; cdecl;
    function getNumUpdates: Integer; cdecl;
    function getPriority: Integer; cdecl;
    function getSmallestDisplacement: Single; cdecl;
    function hashCode: Integer; cdecl;
    function setExpirationDuration(millis: Int64): JLocationRequest; cdecl;
    function setExpirationTime(millis: Int64): JLocationRequest; cdecl;
    function setFastestInterval(millis: Int64): JLocationRequest; cdecl;
    function setInterval(millis: Int64): JLocationRequest; cdecl;
    function setNumUpdates(numUpdates: Integer): JLocationRequest; cdecl;
    function setPriority(priority: Integer): JLocationRequest; cdecl;
    function setSmallestDisplacement(smallestDisplacementMeters: Single): JLocationRequest; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(parcel: JParcel; flags: Integer); cdecl;
  end;
  TJLocationRequest = class(TJavaGenericImport<JLocationRequestClass, JLocationRequest>) end;

  JLocationRequestCreatorClass = interface(JObjectClass)
    ['{B08AC569-2E09-4BA7-A642-8E124C566B70}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JLocationRequestCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/location/LocationRequestCreator')]
  JLocationRequestCreator = interface(JObject)
    ['{35AA2153-52CF-4BEE-82EC-6A666A3961C6}']
    function createFromParcel(parcel: JParcel): JLocationRequest; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JLocationRequest>; cdecl;
  end;
  TJLocationRequestCreator = class(TJavaGenericImport<JLocationRequestCreatorClass, JLocationRequestCreator>) end;

  JLocationStatusCodesClass = interface(JObjectClass)
    ['{0571787B-F88E-41B1-A5CC-3681EB3C4590}']
    {class} function _GetERROR: Integer; cdecl;
    {class} function _GetGEOFENCE_NOT_AVAILABLE: Integer; cdecl;
    {class} function _GetGEOFENCE_TOO_MANY_GEOFENCES: Integer; cdecl;
    {class} function _GetGEOFENCE_TOO_MANY_PENDING_INTENTS: Integer; cdecl;
    {class} function _GetSUCCESS: Integer; cdecl;
    {class} function bl(P1: Integer): Integer; cdecl;
    {class} property ERROR: Integer read _GetERROR;
    {class} property GEOFENCE_NOT_AVAILABLE: Integer read _GetGEOFENCE_NOT_AVAILABLE;
    {class} property GEOFENCE_TOO_MANY_GEOFENCES: Integer read _GetGEOFENCE_TOO_MANY_GEOFENCES;
    {class} property GEOFENCE_TOO_MANY_PENDING_INTENTS: Integer read _GetGEOFENCE_TOO_MANY_PENDING_INTENTS;
    {class} property SUCCESS: Integer read _GetSUCCESS;
  end;

  [JavaSignature('com/google/android/gms/location/LocationStatusCodes')]
  JLocationStatusCodes = interface(JObject)
    ['{47492F6A-FD16-40E4-945F-9F9979B4B620}']
  end;
  TJLocationStatusCodes = class(TJavaGenericImport<JLocationStatusCodesClass, JLocationStatusCodes>) end;

  JCameraUpdateClass = interface(JObjectClass)
    ['{7A21197F-BCBA-493B-B258-0631CADCB0FF}']
  end;

  [JavaSignature('com/google/android/gms/maps/CameraUpdate')]
  JCameraUpdate = interface(JObject)
    ['{11606994-4F45-4D5B-BA4E-22ABCAFE5A15}']
  end;
  TJCameraUpdate = class(TJavaGenericImport<JCameraUpdateClass, JCameraUpdate>) end;

  JCameraUpdateFactoryClass = interface(JObjectClass)
    ['{67303D3C-CEA1-4D27-A15B-64C19309A076}']
    {class} function newCameraPosition(cameraPosition: JCameraPosition): JCameraUpdate; cdecl;
    {class} function newLatLng(latLng: JLatLng): JCameraUpdate; cdecl;
    {class} function newLatLngBounds(bounds: JLatLngBounds; padding: Integer): JCameraUpdate; cdecl; overload;
    {class} function newLatLngBounds(bounds: JLatLngBounds; width: Integer; height: Integer; padding: Integer): JCameraUpdate; cdecl; overload;
    {class} function newLatLngZoom(latLng: JLatLng; zoom: Single): JCameraUpdate; cdecl;
    {class} function scrollBy(xPixel: Single; yPixel: Single): JCameraUpdate; cdecl;
    {class} function zoomBy(amount: Single): JCameraUpdate; cdecl; overload;
    {class} function zoomBy(amount: Single; focus: JPoint): JCameraUpdate; cdecl; overload;
    {class} function zoomIn: JCameraUpdate; cdecl;
    {class} function zoomOut: JCameraUpdate; cdecl;
    {class} function zoomTo(zoom: Single): JCameraUpdate; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/CameraUpdateFactory')]
  JCameraUpdateFactory = interface(JObject)
    ['{4E9D6497-D772-4A4C-9E34-48B7B1EED438}']
  end;
  TJCameraUpdateFactory = class(TJavaGenericImport<JCameraUpdateFactoryClass, JCameraUpdateFactory>) end;

  JGoogleMapClass = interface(JObjectClass)
    ['{400A62AC-F9F5-403A-91B0-CCA7F0FCFFA2}']
    {class} function _GetMAP_TYPE_HYBRID: Integer; cdecl;
    {class} function _GetMAP_TYPE_NONE: Integer; cdecl;
    {class} function _GetMAP_TYPE_NORMAL: Integer; cdecl;
    {class} function _GetMAP_TYPE_SATELLITE: Integer; cdecl;
    {class} function _GetMAP_TYPE_TERRAIN: Integer; cdecl;
    {class} property MAP_TYPE_HYBRID: Integer read _GetMAP_TYPE_HYBRID;
    {class} property MAP_TYPE_NONE: Integer read _GetMAP_TYPE_NONE;
    {class} property MAP_TYPE_NORMAL: Integer read _GetMAP_TYPE_NORMAL;
    {class} property MAP_TYPE_SATELLITE: Integer read _GetMAP_TYPE_SATELLITE;
    {class} property MAP_TYPE_TERRAIN: Integer read _GetMAP_TYPE_TERRAIN;
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap')]
  JGoogleMap = interface(JObject)
    ['{A525ED9B-BBC7-4848-9D2B-680E9D578195}']
    function addCircle(options: JCircleOptions): JCircle; cdecl;
    function addGroundOverlay(options: JGroundOverlayOptions): JGroundOverlay; cdecl;
    function addMarker(options: JMarkerOptions): JMarker; cdecl;
    function addPolygon(options: JPolygonOptions): JPolygon; cdecl;
    function addPolyline(options: JPolylineOptions): JPolyline; cdecl;
    function addTileOverlay(options: JTileOverlayOptions): JTileOverlay; cdecl;
    procedure animateCamera(update: JCameraUpdate); cdecl; overload;
    procedure animateCamera(update: JCameraUpdate; callback: JGoogleMap_CancelableCallback); cdecl; overload;
    procedure animateCamera(update: JCameraUpdate; durationMs: Integer; callback: JGoogleMap_CancelableCallback); cdecl; overload;
    procedure clear; cdecl;
    function getCameraPosition: JCameraPosition; cdecl;
    function getMapType: Integer; cdecl;
    function getMaxZoomLevel: Single; cdecl;
    function getMinZoomLevel: Single; cdecl;
    function getMyLocation: JLocation; cdecl;
    function getProjection: JProjection; cdecl;
    function getUiSettings: JUiSettings; cdecl;
    function isBuildingsEnabled: Boolean; cdecl;
    function isIndoorEnabled: Boolean; cdecl;
    function isMyLocationEnabled: Boolean; cdecl;
    function isTrafficEnabled: Boolean; cdecl;
    procedure moveCamera(update: JCameraUpdate); cdecl;
    procedure setBuildingsEnabled(enabled: Boolean); cdecl;
    function setIndoorEnabled(enabled: Boolean): Boolean; cdecl;
    procedure setInfoWindowAdapter(adapter: JGoogleMap_InfoWindowAdapter); cdecl;
    procedure setLocationSource(source: JLocationSource); cdecl;
    procedure setMapType(type_: Integer); cdecl;
    procedure setMyLocationEnabled(enabled: Boolean); cdecl;
    procedure setOnCameraChangeListener(listener: JGoogleMap_OnCameraChangeListener); cdecl;
    procedure setOnInfoWindowClickListener(listener: JGoogleMap_OnInfoWindowClickListener); cdecl;
    procedure setOnMapClickListener(listener: JGoogleMap_OnMapClickListener); cdecl;
    procedure setOnMapLoadedCallback(callback: JGoogleMap_OnMapLoadedCallback); cdecl;
    procedure setOnMapLongClickListener(listener: JGoogleMap_OnMapLongClickListener); cdecl;
    procedure setOnMarkerClickListener(listener: JGoogleMap_OnMarkerClickListener); cdecl;
    procedure setOnMarkerDragListener(listener: JGoogleMap_OnMarkerDragListener); cdecl;
    procedure setOnMyLocationButtonClickListener(listener: JGoogleMap_OnMyLocationButtonClickListener); cdecl;
    procedure setOnMyLocationChangeListener(listener: JGoogleMap_OnMyLocationChangeListener); cdecl;
    procedure setPadding(left: Integer; top: Integer; right: Integer; bottom: Integer); cdecl;
    procedure setTrafficEnabled(enabled: Boolean); cdecl;
    procedure snapshot(callback: JGoogleMap_SnapshotReadyCallback); cdecl; overload;
    procedure snapshot(callback: JGoogleMap_SnapshotReadyCallback; bitmap: JBitmap); cdecl; overload;
    procedure stopAnimation; cdecl;
  end;
  TJGoogleMap = class(TJavaGenericImport<JGoogleMapClass, JGoogleMap>) end;

  JGoogleMap_CancelableCallbackClass = interface(IJavaClass)
    ['{9614115C-26C0-42A4-BC6B-8C5C07FFE24B}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$CancelableCallback')]
  JGoogleMap_CancelableCallback = interface(IJavaInstance)
    ['{D1AC9707-AC15-4906-A687-B3A628DECC9D}']
    procedure onCancel; cdecl;
    procedure onFinish; cdecl;
  end;
  TJGoogleMap_CancelableCallback = class(TJavaGenericImport<JGoogleMap_CancelableCallbackClass, JGoogleMap_CancelableCallback>) end;

  JGoogleMap_InfoWindowAdapterClass = interface(IJavaClass)
    ['{4767E38C-50FA-43D2-A353-6562739F9B82}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$InfoWindowAdapter')]
  JGoogleMap_InfoWindowAdapter = interface(IJavaInstance)
    ['{DFF8DAEB-2C2B-44CC-9688-B88308CB1025}']
    function getInfoContents(P1: JMarker): JView; cdecl;
    function getInfoWindow(P1: JMarker): JView; cdecl;
  end;
  TJGoogleMap_InfoWindowAdapter = class(TJavaGenericImport<JGoogleMap_InfoWindowAdapterClass, JGoogleMap_InfoWindowAdapter>) end;

  JGoogleMap_OnCameraChangeListenerClass = interface(IJavaClass)
    ['{DCCF80DA-1231-4C0C-9161-93BA6A899D9A}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$OnCameraChangeListener')]
  JGoogleMap_OnCameraChangeListener = interface(IJavaInstance)
    ['{599287B7-6F74-4D70-822D-9C55486B2C89}']
    procedure onCameraChange(P1: JCameraPosition); cdecl;
  end;
  TJGoogleMap_OnCameraChangeListener = class(TJavaGenericImport<JGoogleMap_OnCameraChangeListenerClass, JGoogleMap_OnCameraChangeListener>) end;

  JGoogleMap_OnInfoWindowClickListenerClass = interface(IJavaClass)
    ['{020474F8-83E2-4E62-A37E-F07D54D4298A}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$OnInfoWindowClickListener')]
  JGoogleMap_OnInfoWindowClickListener = interface(IJavaInstance)
    ['{FB213E06-A38F-4C91-998D-AB98AF202C29}']
    procedure onInfoWindowClick(P1: JMarker); cdecl;
  end;
  TJGoogleMap_OnInfoWindowClickListener = class(TJavaGenericImport<JGoogleMap_OnInfoWindowClickListenerClass, JGoogleMap_OnInfoWindowClickListener>) end;

  JGoogleMap_OnMapClickListenerClass = interface(IJavaClass)
    ['{0964A15E-AF26-4F35-8AC8-BB937E0A68B5}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$OnMapClickListener')]
  JGoogleMap_OnMapClickListener = interface(IJavaInstance)
    ['{B1E14548-02B7-4168-AEB6-26A64E23FC91}']
    procedure onMapClick(P1: JLatLng); cdecl;
  end;
  TJGoogleMap_OnMapClickListener = class(TJavaGenericImport<JGoogleMap_OnMapClickListenerClass, JGoogleMap_OnMapClickListener>) end;

  JGoogleMap_OnMapLoadedCallbackClass = interface(IJavaClass)
    ['{9C276FB8-9468-4FD0-99B6-5C75B16448E0}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$OnMapLoadedCallback')]
  JGoogleMap_OnMapLoadedCallback = interface(IJavaInstance)
    ['{0B425EB3-1B2A-4936-851A-0DD6BE9CDD88}']
    procedure onMapLoaded; cdecl;
  end;
  TJGoogleMap_OnMapLoadedCallback = class(TJavaGenericImport<JGoogleMap_OnMapLoadedCallbackClass, JGoogleMap_OnMapLoadedCallback>) end;

  JGoogleMap_OnMapLongClickListenerClass = interface(IJavaClass)
    ['{17AD8C33-1410-4CB4-8DCA-9E4FF3A872BA}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$OnMapLongClickListener')]
  JGoogleMap_OnMapLongClickListener = interface(IJavaInstance)
    ['{F0789EA1-C5E2-4269-A67A-5FF1B0482CA5}']
    procedure onMapLongClick(P1: JLatLng); cdecl;
  end;
  TJGoogleMap_OnMapLongClickListener = class(TJavaGenericImport<JGoogleMap_OnMapLongClickListenerClass, JGoogleMap_OnMapLongClickListener>) end;

  JGoogleMap_OnMarkerClickListenerClass = interface(IJavaClass)
    ['{0726010E-E833-4431-B205-F5D1978508F4}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$OnMarkerClickListener')]
  JGoogleMap_OnMarkerClickListener = interface(IJavaInstance)
    ['{C3FD23CC-A959-4720-A91D-22074E303764}']
    function onMarkerClick(P1: JMarker): Boolean; cdecl;
  end;
  TJGoogleMap_OnMarkerClickListener = class(TJavaGenericImport<JGoogleMap_OnMarkerClickListenerClass, JGoogleMap_OnMarkerClickListener>) end;

  JGoogleMap_OnMarkerDragListenerClass = interface(IJavaClass)
    ['{6E1353C5-A89C-4DAD-9613-1029DA10D9E4}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$OnMarkerDragListener')]
  JGoogleMap_OnMarkerDragListener = interface(IJavaInstance)
    ['{F4D0B32E-859B-47D6-8ECD-573590756CD9}']
    procedure onMarkerDrag(P1: JMarker); cdecl;
    procedure onMarkerDragEnd(P1: JMarker); cdecl;
    procedure onMarkerDragStart(P1: JMarker); cdecl;
  end;
  TJGoogleMap_OnMarkerDragListener = class(TJavaGenericImport<JGoogleMap_OnMarkerDragListenerClass, JGoogleMap_OnMarkerDragListener>) end;

  JGoogleMap_OnMyLocationButtonClickListenerClass = interface(IJavaClass)
    ['{69815418-ECFB-4F8B-8CCF-062E5BA9DCAD}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$OnMyLocationButtonClickListener')]
  JGoogleMap_OnMyLocationButtonClickListener = interface(IJavaInstance)
    ['{BE4965DB-A640-42DA-9AD2-1F96425737F1}']
    function onMyLocationButtonClick: Boolean; cdecl;
  end;
  TJGoogleMap_OnMyLocationButtonClickListener = class(TJavaGenericImport<JGoogleMap_OnMyLocationButtonClickListenerClass, JGoogleMap_OnMyLocationButtonClickListener>) end;

  JGoogleMap_OnMyLocationChangeListenerClass = interface(IJavaClass)
    ['{A016AFD3-AE05-4306-80C4-DDED25000E54}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$OnMyLocationChangeListener')]
  JGoogleMap_OnMyLocationChangeListener = interface(IJavaInstance)
    ['{44089694-6E57-4859-939D-97E59C7BAAAE}']
    procedure onMyLocationChange(P1: JLocation); cdecl;
  end;
  TJGoogleMap_OnMyLocationChangeListener = class(TJavaGenericImport<JGoogleMap_OnMyLocationChangeListenerClass, JGoogleMap_OnMyLocationChangeListener>) end;

  JGoogleMap_SnapshotReadyCallbackClass = interface(IJavaClass)
    ['{61B0A354-3EDF-4C4C-AFA1-31C9ECD7E7CD}']
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMap$SnapshotReadyCallback')]
  JGoogleMap_SnapshotReadyCallback = interface(IJavaInstance)
    ['{53C58A5E-B8D3-4999-924B-8D053025EA12}']
    procedure onSnapshotReady(P1: JBitmap); cdecl;
  end;
  TJGoogleMap_SnapshotReadyCallback = class(TJavaGenericImport<JGoogleMap_SnapshotReadyCallbackClass, JGoogleMap_SnapshotReadyCallback>) end;

  JGoogleMapOptionsClass = interface(JObjectClass)
    ['{6858A5C7-54A7-40DE-9A0C-1DC32ED24A12}']
    {class} function _GetCREATOR: JGoogleMapOptionsCreator; cdecl;
    {class} function createFromAttributes(context: JContext; attrs: JAttributeSet): JGoogleMapOptions; cdecl;
    {class} function init: JGoogleMapOptions; cdecl; overload;
    {class} property CREATOR: JGoogleMapOptionsCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMapOptions')]
  JGoogleMapOptions = interface(JObject)
    ['{DC638BBD-E6D4-4F74-B531-53B24E101B06}']
    function camera(camera: JCameraPosition): JGoogleMapOptions; cdecl;
    function compassEnabled(enabled: Boolean): JGoogleMapOptions; cdecl;
    function describeContents: Integer; cdecl;
    function getCamera: JCameraPosition; cdecl;
    function getCompassEnabled: JBoolean; cdecl;
    function getMapType: Integer; cdecl;
    function getRotateGesturesEnabled: JBoolean; cdecl;
    function getScrollGesturesEnabled: JBoolean; cdecl;
    function getTiltGesturesEnabled: JBoolean; cdecl;
    function getUseViewLifecycleInFragment: JBoolean; cdecl;
    function getZOrderOnTop: JBoolean; cdecl;
    function getZoomControlsEnabled: JBoolean; cdecl;
    function getZoomGesturesEnabled: JBoolean; cdecl;
    function mapType(mapType: Integer): JGoogleMapOptions; cdecl;
    function rotateGesturesEnabled(enabled: Boolean): JGoogleMapOptions; cdecl;
    function scrollGesturesEnabled(enabled: Boolean): JGoogleMapOptions; cdecl;
    function tiltGesturesEnabled(enabled: Boolean): JGoogleMapOptions; cdecl;
    function useViewLifecycleInFragment(useViewLifecycleInFragment: Boolean): JGoogleMapOptions; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    function zOrderOnTop(zOrderOnTop: Boolean): JGoogleMapOptions; cdecl;
    function zoomControlsEnabled(enabled: Boolean): JGoogleMapOptions; cdecl;
    function zoomGesturesEnabled(enabled: Boolean): JGoogleMapOptions; cdecl;
  end;
  TJGoogleMapOptions = class(TJavaGenericImport<JGoogleMapOptionsClass, JGoogleMapOptions>) end;

  JGoogleMapOptionsCreatorClass = interface(JObjectClass)
    ['{68020886-D22F-40EC-AEBD-8AA7C4AC9F82}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JGoogleMapOptionsCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/GoogleMapOptionsCreator')]
  JGoogleMapOptionsCreator = interface(JObject)
    ['{D51A1302-2923-4015-9A0D-1D9AFE11B17B}']
    function createFromParcel(parcel: JParcel): JGoogleMapOptions; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JGoogleMapOptions>; cdecl;
  end;
  TJGoogleMapOptionsCreator = class(TJavaGenericImport<JGoogleMapOptionsCreatorClass, JGoogleMapOptionsCreator>) end;

  JLocationSourceClass = interface(IJavaClass)
    ['{DD46DE05-8B4F-47D2-8910-3B19D7FD9939}']
  end;

  [JavaSignature('com/google/android/gms/maps/LocationSource')]
  JLocationSource = interface(IJavaInstance)
    ['{DE211F4A-D940-4E56-AAE3-21F7A885E2FE}']
    procedure activate(P1: JLocationSource_OnLocationChangedListener); cdecl;
    procedure deactivate; cdecl;
  end;
  TJLocationSource = class(TJavaGenericImport<JLocationSourceClass, JLocationSource>) end;

  JLocationSource_OnLocationChangedListenerClass = interface(IJavaClass)
    ['{C1885854-F25B-4E28-8AB9-2052BFBAA973}']
  end;

  [JavaSignature('com/google/android/gms/maps/LocationSource$OnLocationChangedListener')]
  JLocationSource_OnLocationChangedListener = interface(IJavaInstance)
    ['{8A25D8FD-F6ED-4D09-A98C-BA569E82D7BB}']
    procedure onLocationChanged(P1: JLocation); cdecl;
  end;
  TJLocationSource_OnLocationChangedListener = class(TJavaGenericImport<JLocationSource_OnLocationChangedListenerClass, JLocationSource_OnLocationChangedListener>) end;

  JMapFragmentClass = interface(JFragmentClass)
    ['{F06BD952-32D9-492A-A0D3-40B2F488D619}']
    {class} function init: JMapFragment; cdecl;
    {class} function newInstance: JMapFragment; cdecl; overload;
    {class} function newInstance(options: JGoogleMapOptions): JMapFragment; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/maps/MapFragment')]
  JMapFragment = interface(JFragment)
    ['{DA91ED13-88F8-4FE5-B934-14853D60E7FD}']
    function getMap: JGoogleMap; cdecl;
    procedure onActivityCreated(savedInstanceState: JBundle); cdecl;
    procedure onAttach(activity: JActivity); cdecl;
    procedure onCreate(savedInstanceState: JBundle); cdecl;
    function onCreateView(inflater: JLayoutInflater; container: JViewGroup; savedInstanceState: JBundle): JView; cdecl;
    procedure onDestroy; cdecl;
    procedure onDestroyView; cdecl;
    procedure onInflate(activity: JActivity; attrs: JAttributeSet; savedInstanceState: JBundle); cdecl;
    procedure onLowMemory; cdecl;
    procedure onPause; cdecl;
    procedure onResume; cdecl;
    procedure onSaveInstanceState(outState: JBundle); cdecl;
    procedure setArguments(args: JBundle); cdecl;
  end;
  TJMapFragment = class(TJavaGenericImport<JMapFragmentClass, JMapFragment>) end;

  JMapViewClass = interface(JFrameLayoutClass)
    ['{1EE5FDF1-67E7-4FC9-AA41-D5B05E629B84}']
    {class} function init(context: JContext): JMapView; cdecl; overload;
    {class} function init(context: JContext; options: JGoogleMapOptions): JMapView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JMapView; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet; defStyle: Integer): JMapView; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/maps/MapView')]
  JMapView = interface(JFrameLayout)
    ['{FDC9DF68-5392-450C-A85C-E33754D8BFAD}']
    function getMap: JGoogleMap; cdecl;
    procedure onCreate(savedInstanceState: JBundle); cdecl;
    procedure onDestroy; cdecl;
    procedure onLowMemory; cdecl;
    procedure onPause; cdecl;
    procedure onResume; cdecl;
    procedure onSaveInstanceState(outState: JBundle); cdecl;
  end;
  TJMapView = class(TJavaGenericImport<JMapViewClass, JMapView>) end;

  JMapsInitializerClass = interface(JObjectClass)
    ['{589D1A92-1661-448C-9560-8F20ABA1157C}']
    {class} function initialize(context: JContext): Integer; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/MapsInitializer')]
  JMapsInitializer = interface(JObject)
    ['{8708DF65-6068-4C6E-B345-603FC91F7C6A}']
  end;
  TJMapsInitializer = class(TJavaGenericImport<JMapsInitializerClass, JMapsInitializer>) end;

  JProjectionClass = interface(JObjectClass)
    ['{39569102-F14D-4DC9-9FC6-CEA9F4431A79}']
  end;

  [JavaSignature('com/google/android/gms/maps/Projection')]
  JProjection = interface(JObject)
    ['{6B32610E-3FC7-4956-AD4B-3472F4023DC7}']
    function fromScreenLocation(point: JPoint): JLatLng; cdecl;
    function getVisibleRegion: JVisibleRegion; cdecl;
    function toScreenLocation(location: JLatLng): JPoint; cdecl;
  end;
  TJProjection = class(TJavaGenericImport<JProjectionClass, JProjection>) end;

  JSupportMapFragmentClass = interface(Japp_FragmentClass)
    ['{4DCB1F0B-DEE3-47DE-BFB4-5A343A3F2A7C}']
    {class} function init: JSupportMapFragment; cdecl;
    {class} function newInstance: JSupportMapFragment; cdecl; overload;
    {class} function newInstance(options: JGoogleMapOptions): JSupportMapFragment; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/maps/SupportMapFragment')]
  JSupportMapFragment = interface(Japp_Fragment)
    ['{4E4C9D9E-DDAA-4A2C-9C97-AA1C20C5DA3B}']
    function getMap: JGoogleMap; cdecl;
    procedure onActivityCreated(savedInstanceState: JBundle); cdecl;
    procedure onAttach(activity: JActivity); cdecl;
    procedure onCreate(savedInstanceState: JBundle); cdecl;
    function onCreateView(inflater: JLayoutInflater; container: JViewGroup; savedInstanceState: JBundle): JView; cdecl;
    procedure onDestroy; cdecl;
    procedure onDestroyView; cdecl;
    procedure onInflate(activity: JActivity; attrs: JAttributeSet; savedInstanceState: JBundle); cdecl;
    procedure onLowMemory; cdecl;
    procedure onPause; cdecl;
    procedure onResume; cdecl;
    procedure onSaveInstanceState(outState: JBundle); cdecl;
    procedure setArguments(args: JBundle); cdecl;
  end;
  TJSupportMapFragment = class(TJavaGenericImport<JSupportMapFragmentClass, JSupportMapFragment>) end;

  JSupportMapFragment_aClass = interface(JObjectClass)
    ['{2C50D5E0-2D20-45A6-80EB-CD5F7F89CF87}']
    {class} function init(P1: Japp_Fragment; P2: JIMapFragmentDelegate): JSupportMapFragment_a; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/SupportMapFragment$a')]
  JSupportMapFragment_a = interface(JObject)
    ['{6B59FE2C-9E3E-4C60-854A-EDF56CE7F90E}']
    function gV: JIMapFragmentDelegate; cdecl;
    procedure onCreate(savedInstanceState: JBundle); cdecl;
    function onCreateView(inflater: JLayoutInflater; container: JViewGroup; savedInstanceState: JBundle): JView; cdecl;
    procedure onDestroy; cdecl;
    procedure onDestroyView; cdecl;
    procedure onInflate(activity: JActivity; attrs: JBundle; savedInstanceState: JBundle); cdecl;
    procedure onLowMemory; cdecl;
    procedure onPause; cdecl;
    procedure onResume; cdecl;
    procedure onSaveInstanceState(outState: JBundle); cdecl;
    procedure onStart; cdecl;
    procedure onStop; cdecl;
  end;
  TJSupportMapFragment_a = class(TJavaGenericImport<JSupportMapFragment_aClass, JSupportMapFragment_a>) end;

  // com.google.android.gms.maps.SupportMapFragment$b
  JUiSettingsClass = interface(JObjectClass)
    ['{E177867D-1013-41DC-8CC9-61E764F41FC2}']
  end;

  [JavaSignature('com/google/android/gms/maps/UiSettings')]
  JUiSettings = interface(JObject)
    ['{C166F17B-4B44-4A09-8542-222C1668594A}']
    function isCompassEnabled: Boolean; cdecl;
    function isMyLocationButtonEnabled: Boolean; cdecl;
    function isRotateGesturesEnabled: Boolean; cdecl;
    function isScrollGesturesEnabled: Boolean; cdecl;
    function isTiltGesturesEnabled: Boolean; cdecl;
    function isZoomControlsEnabled: Boolean; cdecl;
    function isZoomGesturesEnabled: Boolean; cdecl;
    procedure setAllGesturesEnabled(enabled: Boolean); cdecl;
    procedure setCompassEnabled(enabled: Boolean); cdecl;
    procedure setMyLocationButtonEnabled(enabled: Boolean); cdecl;
    procedure setRotateGesturesEnabled(enabled: Boolean); cdecl;
    procedure setScrollGesturesEnabled(enabled: Boolean); cdecl;
    procedure setTiltGesturesEnabled(enabled: Boolean); cdecl;
    procedure setZoomControlsEnabled(enabled: Boolean); cdecl;
    procedure setZoomGesturesEnabled(enabled: Boolean); cdecl;
  end;
  TJUiSettings = class(TJavaGenericImport<JUiSettingsClass, JUiSettings>) end;

  JICameraUpdateFactoryDelegateClass = interface(JIInterfaceClass)
    ['{07D64056-52B1-4C96-8CFB-37F9B8858E1F}']
  end;

  [JavaSignature('com/google/android/gms/maps/internal/ICameraUpdateFactoryDelegate')]
  JICameraUpdateFactoryDelegate = interface(JIInterface)
    ['{8304CE07-A2B8-4DE3-AEDA-741DA2821D85}']
    //function newCameraPosition(P1: JCameraPosition): Jb; cdecl;
    //function newLatLng(P1: JLatLng): Jb; cdecl;
    //function newLatLngBounds(P1: JLatLngBounds; P2: Integer): Jb; cdecl;
    //function newLatLngBoundsWithSize(P1: JLatLngBounds; P2: Integer; P3: Integer; P4: Integer): Jb; cdecl;
    //function newLatLngZoom(P1: JLatLng; P2: Single): Jb; cdecl;
    //function scrollBy(P1: Single; P2: Single): Jb; cdecl;
    //function zoomBy(P1: Single): Jb; cdecl;
    //function zoomByWithFocus(P1: Single; P2: Integer; P3: Integer): Jb; cdecl;
    //function zoomIn: Jb; cdecl;
    //function zoomOut: Jb; cdecl;
    //function zoomTo(P1: Single): Jb; cdecl;
  end;
  TJICameraUpdateFactoryDelegate = class(TJavaGenericImport<JICameraUpdateFactoryDelegateClass, JICameraUpdateFactoryDelegate>) end;

  JIGoogleMapDelegateClass = interface(JIInterfaceClass)
    ['{8F1C7FEB-7BD3-4EAA-B99B-59A74CC7B8C7}']
  end;

  [JavaSignature('com/google/android/gms/maps/internal/IGoogleMapDelegate')]
  JIGoogleMapDelegate = interface(JIInterface)
    ['{7154878F-75B5-4D54-8126-D0FF7F396E90}']
    //function addCircle(P1: JCircleOptions): Jmodel_internal_b; cdecl;
    //function addGroundOverlay(P1: JGroundOverlayOptions): Jinternal_c; cdecl;
    //function addMarker(P1: JMarkerOptions): Jinternal_d; cdecl;
    //function addPolygon(P1: JPolygonOptions): Je; cdecl;
    function addPolyline(P1: JPolylineOptions): JIPolylineDelegate; cdecl;
    //function addTileOverlay(P1: JTileOverlayOptions): Jf; cdecl;
    //procedure animateCamera(P1: Jb); cdecl;
    //procedure animateCameraWithCallback(P1: Jb; P2: Jinternal_b); cdecl;
    //procedure animateCameraWithDurationAndCallback(P1: Jb; P2: Integer; P3: Jinternal_b); cdecl;
    procedure clear; cdecl;
    function getCameraPosition: JCameraPosition; cdecl;
    function getMapType: Integer; cdecl;
    function getMaxZoomLevel: Single; cdecl;
    function getMinZoomLevel: Single; cdecl;
    function getMyLocation: JLocation; cdecl;
    function getProjection: JIProjectionDelegate; cdecl;
    //function getTestingHelper: Jb; cdecl;
    function getUiSettings: JIUiSettingsDelegate; cdecl;
    function isBuildingsEnabled: Boolean; cdecl;
    function isIndoorEnabled: Boolean; cdecl;
    function isMyLocationEnabled: Boolean; cdecl;
    function isTrafficEnabled: Boolean; cdecl;
    //procedure moveCamera(P1: Jb); cdecl;
    procedure setBuildingsEnabled(P1: Boolean); cdecl;
    function setIndoorEnabled(P1: Boolean): Boolean; cdecl;
    //procedure setInfoWindowAdapter(P1: Jmaps_internal_d); cdecl;
    procedure setLocationSource(P1: JILocationSourceDelegate); cdecl;
    procedure setMapType(P1: Integer); cdecl;
    procedure setMyLocationEnabled(P1: Boolean); cdecl;
    //procedure setOnCameraChangeListener(P1: Jinternal_e); cdecl;
    //procedure setOnInfoWindowClickListener(P1: Jinternal_f); cdecl;
    //procedure setOnMapClickListener(P1: Jinternal_h); cdecl;
    //procedure setOnMapLoadedCallback(P1: Ji); cdecl;
    //procedure setOnMapLongClickListener(P1: Jj); cdecl;
    //procedure setOnMarkerClickListener(P1: Jk); cdecl;
    //procedure setOnMarkerDragListener(P1: Jl); cdecl;
    //procedure setOnMyLocationButtonClickListener(P1: Jm); cdecl;
    //procedure setOnMyLocationChangeListener(P1: Jinternal_n); cdecl;
    procedure setPadding(P1: Integer; P2: Integer; P3: Integer; P4: Integer); cdecl;
    procedure setTrafficEnabled(P1: Boolean); cdecl;
    //procedure snapshot(P1: Jo; P2: Jb); cdecl;
    procedure stopAnimation; cdecl;
  end;
  TJIGoogleMapDelegate = class(TJavaGenericImport<JIGoogleMapDelegateClass, JIGoogleMapDelegate>) end;

  JILocationSourceDelegateClass = interface(JIInterfaceClass)
    ['{9E105F6A-9DDF-42A1-A1B9-05CA3D9A48C8}']
  end;

  [JavaSignature('com/google/android/gms/maps/internal/ILocationSourceDelegate')]
  JILocationSourceDelegate = interface(JIInterface)
    ['{33B90AE3-00D3-4025-BC1F-D0D25CCAE092}']
    //procedure activate(P1: Jinternal_g); cdecl;
    procedure deactivate; cdecl;
  end;
  TJILocationSourceDelegate = class(TJavaGenericImport<JILocationSourceDelegateClass, JILocationSourceDelegate>) end;

  JIMapFragmentDelegateClass = interface(JIInterfaceClass)
    ['{2C6919E8-96C5-400E-A665-6CDC244D5A89}']
  end;

  [JavaSignature('com/google/android/gms/maps/internal/IMapFragmentDelegate')]
  JIMapFragmentDelegate = interface(JIInterface)
    ['{1B884F8B-0474-4C3C-A3F1-D28FC74C8F1F}']
    function getMap: JIGoogleMapDelegate; cdecl;
    function isReady: Boolean; cdecl;
    procedure onCreate(P1: JBundle); cdecl;
    //function onCreateView(P1: Jb; P2: Jb; P3: JBundle): Jb; cdecl;
    procedure onDestroy; cdecl;
    procedure onDestroyView; cdecl;
    //procedure onInflate(P1: Jb; P2: JGoogleMapOptions; P3: JBundle); cdecl;
    procedure onLowMemory; cdecl;
    procedure onPause; cdecl;
    procedure onResume; cdecl;
    procedure onSaveInstanceState(P1: JBundle); cdecl;
  end;
  TJIMapFragmentDelegate = class(TJavaGenericImport<JIMapFragmentDelegateClass, JIMapFragmentDelegate>) end;

  JIMapViewDelegateClass = interface(JIInterfaceClass)
    ['{24E152A6-AAD0-41CE-873A-CB4042EAB3DA}']
  end;

  [JavaSignature('com/google/android/gms/maps/internal/IMapViewDelegate')]
  JIMapViewDelegate = interface(JIInterface)
    ['{92FC30C9-99E2-4EC7-A051-53499F82D965}']
    function getMap: JIGoogleMapDelegate; cdecl;
    //function getView: Jb; cdecl;
    procedure onCreate(P1: JBundle); cdecl;
    procedure onDestroy; cdecl;
    procedure onLowMemory; cdecl;
    procedure onPause; cdecl;
    procedure onResume; cdecl;
    procedure onSaveInstanceState(P1: JBundle); cdecl;
  end;
  TJIMapViewDelegate = class(TJavaGenericImport<JIMapViewDelegateClass, JIMapViewDelegate>) end;

  JIProjectionDelegateClass = interface(JIInterfaceClass)
    ['{198CE567-66D1-47CB-A9F9-EF5753805C59}']
  end;

  [JavaSignature('com/google/android/gms/maps/internal/IProjectionDelegate')]
  JIProjectionDelegate = interface(JIInterface)
    ['{93D6C3BF-8B87-48B0-BB99-0A216589089A}']
    //function fromScreenLocation(P1: Jb): JLatLng; cdecl;
    function getVisibleRegion: JVisibleRegion; cdecl;
    //function toScreenLocation(P1: JLatLng): Jb; cdecl;
  end;
  TJIProjectionDelegate = class(TJavaGenericImport<JIProjectionDelegateClass, JIProjectionDelegate>) end;

  JIUiSettingsDelegateClass = interface(JIInterfaceClass)
    ['{6B0678EE-DEF6-4D18-B5A4-32AE60895ABA}']
  end;

  [JavaSignature('com/google/android/gms/maps/internal/IUiSettingsDelegate')]
  JIUiSettingsDelegate = interface(JIInterface)
    ['{D43A9F19-A008-4E96-9779-009F6373AC2D}']
    function isCompassEnabled: Boolean; cdecl;
    function isMyLocationButtonEnabled: Boolean; cdecl;
    function isRotateGesturesEnabled: Boolean; cdecl;
    function isScrollGesturesEnabled: Boolean; cdecl;
    function isTiltGesturesEnabled: Boolean; cdecl;
    function isZoomControlsEnabled: Boolean; cdecl;
    function isZoomGesturesEnabled: Boolean; cdecl;
    procedure setAllGesturesEnabled(P1: Boolean); cdecl;
    procedure setCompassEnabled(P1: Boolean); cdecl;
    procedure setMyLocationButtonEnabled(P1: Boolean); cdecl;
    procedure setRotateGesturesEnabled(P1: Boolean); cdecl;
    procedure setScrollGesturesEnabled(P1: Boolean); cdecl;
    procedure setTiltGesturesEnabled(P1: Boolean); cdecl;
    procedure setZoomControlsEnabled(P1: Boolean); cdecl;
    procedure setZoomGesturesEnabled(P1: Boolean); cdecl;
  end;
  TJIUiSettingsDelegate = class(TJavaGenericImport<JIUiSettingsDelegateClass, JIUiSettingsDelegate>) end;

  JBitmapDescriptorClass = interface(JObjectClass)
    ['{B3AC0084-AD2D-4B7C-A2E6-46E1F05DB7F6}']
  end;

  [JavaSignature('com/google/android/gms/maps/model/BitmapDescriptor')]
  JBitmapDescriptor = interface(JObject)
    ['{650F87E1-F0BF-4270-8ADC-11941A7015AB}']
    //function gK: Jb; cdecl;
  end;
  TJBitmapDescriptor = class(TJavaGenericImport<JBitmapDescriptorClass, JBitmapDescriptor>) end;

  JBitmapDescriptorFactoryClass = interface(JObjectClass)
    ['{88545E48-00BE-4AEB-BF98-78308F5AB256}']
    {class} function _GetHUE_AZURE: Single; cdecl;
    {class} function _GetHUE_BLUE: Single; cdecl;
    {class} function _GetHUE_CYAN: Single; cdecl;
    {class} function _GetHUE_GREEN: Single; cdecl;
    {class} function _GetHUE_MAGENTA: Single; cdecl;
    {class} function _GetHUE_ORANGE: Single; cdecl;
    {class} function _GetHUE_RED: Single; cdecl;
    {class} function _GetHUE_ROSE: Single; cdecl;
    {class} function _GetHUE_VIOLET: Single; cdecl;
    {class} function _GetHUE_YELLOW: Single; cdecl;
    {class} //procedure a(P1: Jinternal_a); cdecl;
    {class} function defaultMarker: JBitmapDescriptor; cdecl; overload;
    {class} function defaultMarker(hue: Single): JBitmapDescriptor; cdecl; overload;
    {class} function fromAsset(assetName: JString): JBitmapDescriptor; cdecl;
    {class} function fromBitmap(image: JBitmap): JBitmapDescriptor; cdecl;
    {class} function fromFile(fileName: JString): JBitmapDescriptor; cdecl;
    {class} function fromPath(absolutePath: JString): JBitmapDescriptor; cdecl;
    {class} function fromResource(resourceId: Integer): JBitmapDescriptor; cdecl;
    {class} property HUE_AZURE: Single read _GetHUE_AZURE;
    {class} property HUE_BLUE: Single read _GetHUE_BLUE;
    {class} property HUE_CYAN: Single read _GetHUE_CYAN;
    {class} property HUE_GREEN: Single read _GetHUE_GREEN;
    {class} property HUE_MAGENTA: Single read _GetHUE_MAGENTA;
    {class} property HUE_ORANGE: Single read _GetHUE_ORANGE;
    {class} property HUE_RED: Single read _GetHUE_RED;
    {class} property HUE_ROSE: Single read _GetHUE_ROSE;
    {class} property HUE_VIOLET: Single read _GetHUE_VIOLET;
    {class} property HUE_YELLOW: Single read _GetHUE_YELLOW;
  end;

  [JavaSignature('com/google/android/gms/maps/model/BitmapDescriptorFactory')]
  JBitmapDescriptorFactory = interface(JObject)
    ['{83007807-E8EE-43BD-9312-78943B089FD5}']
  end;
  TJBitmapDescriptorFactory = class(TJavaGenericImport<JBitmapDescriptorFactoryClass, JBitmapDescriptorFactory>) end;

  JCameraPositionClass = interface(JObjectClass)
    ['{BBC26A98-4E32-43A4-A67C-B0FF586E1071}']
    {class} function _GetCREATOR: JCameraPositionCreator; cdecl;
    {class} function builder: JCameraPosition_Builder; cdecl; overload;
    {class} function builder(camera: JCameraPosition): JCameraPosition_Builder; cdecl; overload;
    {class} function createFromAttributes(context: JContext; attrs: JAttributeSet): JCameraPosition; cdecl;
    {class} function fromLatLngZoom(target: JLatLng; zoom: Single): JCameraPosition; cdecl;
    {class} function init(target: JLatLng; zoom: Single; tilt: Single; bearing: Single): JCameraPosition; cdecl; overload;
    {class} property CREATOR: JCameraPositionCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/maps/model/CameraPosition')]
  JCameraPosition = interface(JObject)
    ['{CBD6FBEA-582B-473B-959B-C7EB300574A2}']
    function _Getbearing: Single; cdecl;
    function _Gettarget: JLatLng; cdecl;
    function _Gettilt: Single; cdecl;
    function _Getzoom: Single; cdecl;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    property bearing: Single read _Getbearing;
    property target: JLatLng read _Gettarget;
    property tilt: Single read _Gettilt;
    property zoom: Single read _Getzoom;
  end;
  TJCameraPosition = class(TJavaGenericImport<JCameraPositionClass, JCameraPosition>) end;

  JCameraPosition_BuilderClass = interface(JObjectClass)
    ['{84517F2E-069C-457D-B297-C29BCEA99D39}']
    {class} function init: JCameraPosition_Builder; cdecl; overload;
    {class} function init(previous: JCameraPosition): JCameraPosition_Builder; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/maps/model/CameraPosition$Builder')]
  JCameraPosition_Builder = interface(JObject)
    ['{10539B19-24B1-414A-A8C9-09FF64A805A1}']
    function bearing(bearing: Single): JCameraPosition_Builder; cdecl;
    function build: JCameraPosition; cdecl;
    function target(location: JLatLng): JCameraPosition_Builder; cdecl;
    function tilt(tilt: Single): JCameraPosition_Builder; cdecl;
    function zoom(zoom: Single): JCameraPosition_Builder; cdecl;
  end;
  TJCameraPosition_Builder = class(TJavaGenericImport<JCameraPosition_BuilderClass, JCameraPosition_Builder>) end;

  JCameraPositionCreatorClass = interface(JObjectClass)
    ['{04C0775C-11D5-402C-B7CA-E1AB6C45E868}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JCameraPositionCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/CameraPositionCreator')]
  JCameraPositionCreator = interface(JObject)
    ['{F0A53DA0-6E24-48D0-BA90-2D15862EAE2C}']
    function createFromParcel(parcel: JParcel): JCameraPosition; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JCameraPosition>; cdecl;
  end;
  TJCameraPositionCreator = class(TJavaGenericImport<JCameraPositionCreatorClass, JCameraPositionCreator>) end;

  JCircleClass = interface(JObjectClass)
    ['{EEB20939-CDBA-4C8C-BB4E-EA9F3FB16A14}']
    {class} //function init(delegate: Jmodel_internal_b): JCircle; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/model/Circle')]
  JCircle = interface(JObject)
    ['{D1408DBE-690F-45FD-A740-8D2FA4E10CED}']
    function equals(other: JObject): Boolean; cdecl;
    function getCenter: JLatLng; cdecl;
    function getFillColor: Integer; cdecl;
    function getId: JString; cdecl;
    function getRadius: Double; cdecl;
    function getStrokeColor: Integer; cdecl;
    function getStrokeWidth: Single; cdecl;
    function getZIndex: Single; cdecl;
    function hashCode: Integer; cdecl;
    function isVisible: Boolean; cdecl;
    procedure remove; cdecl;
    procedure setCenter(center: JLatLng); cdecl;
    procedure setFillColor(color: Integer); cdecl;
    procedure setRadius(radius: Double); cdecl;
    procedure setStrokeColor(color: Integer); cdecl;
    procedure setStrokeWidth(width: Single); cdecl;
    procedure setVisible(visible: Boolean); cdecl;
    procedure setZIndex(zIndex: Single); cdecl;
  end;
  TJCircle = class(TJavaGenericImport<JCircleClass, JCircle>) end;

  JCircleOptionsClass = interface(JObjectClass)
    ['{D055A38E-CD1E-41B4-B6A0-F6EDF0869544}']
    {class} function _GetCREATOR: JCircleOptionsCreator; cdecl;
    {class} function init: JCircleOptions; cdecl; overload;
    {class} property CREATOR: JCircleOptionsCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/maps/model/CircleOptions')]
  JCircleOptions = interface(JObject)
    ['{5EB2D906-C70F-48BC-A34B-BA102162163A}']
    function center(center: JLatLng): JCircleOptions; cdecl;
    function describeContents: Integer; cdecl;
    function fillColor(color: Integer): JCircleOptions; cdecl;
    function getCenter: JLatLng; cdecl;
    function getFillColor: Integer; cdecl;
    function getRadius: Double; cdecl;
    function getStrokeColor: Integer; cdecl;
    function getStrokeWidth: Single; cdecl;
    function getZIndex: Single; cdecl;
    function isVisible: Boolean; cdecl;
    function radius(radius: Double): JCircleOptions; cdecl;
    function strokeColor(color: Integer): JCircleOptions; cdecl;
    function strokeWidth(width: Single): JCircleOptions; cdecl;
    function visible(visible: Boolean): JCircleOptions; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    function zIndex(zIndex: Single): JCircleOptions; cdecl;
  end;
  TJCircleOptions = class(TJavaGenericImport<JCircleOptionsClass, JCircleOptions>) end;

  JCircleOptionsCreatorClass = interface(JObjectClass)
    ['{0600AB5B-B6EA-4D7D-A8A0-3F70729792A8}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JCircleOptionsCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/CircleOptionsCreator')]
  JCircleOptionsCreator = interface(JObject)
    ['{B6976977-6EDF-45B0-9167-3AB2D82A3444}']
    function createFromParcel(parcel: JParcel): JCircleOptions; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JCircleOptions>; cdecl;
  end;
  TJCircleOptionsCreator = class(TJavaGenericImport<JCircleOptionsCreatorClass, JCircleOptionsCreator>) end;

  JGroundOverlayClass = interface(JObjectClass)
    ['{71A8228E-C56A-4DEE-B5DE-600E6FE8F24D}']
    {class} //function init(delegate: Jinternal_c): JGroundOverlay; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/model/GroundOverlay')]
  JGroundOverlay = interface(JObject)
    ['{D9C7E7CE-26CA-4B65-B2B3-5A1C57E3AE3F}']
    function equals(other: JObject): Boolean; cdecl;
    function getBearing: Single; cdecl;
    function getBounds: JLatLngBounds; cdecl;
    function getHeight: Single; cdecl;
    function getId: JString; cdecl;
    function getPosition: JLatLng; cdecl;
    function getTransparency: Single; cdecl;
    function getWidth: Single; cdecl;
    function getZIndex: Single; cdecl;
    function hashCode: Integer; cdecl;
    function isVisible: Boolean; cdecl;
    procedure remove; cdecl;
    procedure setBearing(bearing: Single); cdecl;
    procedure setDimensions(width: Single); cdecl; overload;
    procedure setDimensions(width: Single; height: Single); cdecl; overload;
    procedure setImage(image: JBitmapDescriptor); cdecl;
    procedure setPosition(latLng: JLatLng); cdecl;
    procedure setPositionFromBounds(bounds: JLatLngBounds); cdecl;
    procedure setTransparency(transparency: Single); cdecl;
    procedure setVisible(visible: Boolean); cdecl;
    procedure setZIndex(zIndex: Single); cdecl;
  end;
  TJGroundOverlay = class(TJavaGenericImport<JGroundOverlayClass, JGroundOverlay>) end;

  JGroundOverlayOptionsClass = interface(JObjectClass)
    ['{BAAAFFA3-3D94-421F-A2A0-BAFEC6D6DB68}']
    {class} function _GetCREATOR: JGroundOverlayOptionsCreator; cdecl;
    {class} function _GetNO_DIMENSION: Single; cdecl;
    {class} function init: JGroundOverlayOptions; cdecl; overload;
    {class} property CREATOR: JGroundOverlayOptionsCreator read _GetCREATOR;
    {class} property NO_DIMENSION: Single read _GetNO_DIMENSION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/GroundOverlayOptions')]
  JGroundOverlayOptions = interface(JObject)
    ['{9109D62E-A7BA-44ED-9BB3-9460A31F3B94}']
    function anchor(u: Single; v: Single): JGroundOverlayOptions; cdecl;
    function bearing(bearing: Single): JGroundOverlayOptions; cdecl;
    function describeContents: Integer; cdecl;
    function getAnchorU: Single; cdecl;
    function getAnchorV: Single; cdecl;
    function getBearing: Single; cdecl;
    function getBounds: JLatLngBounds; cdecl;
    function getHeight: Single; cdecl;
    function getImage: JBitmapDescriptor; cdecl;
    function getLocation: JLatLng; cdecl;
    function getTransparency: Single; cdecl;
    function getWidth: Single; cdecl;
    function getZIndex: Single; cdecl;
    function image(image: JBitmapDescriptor): JGroundOverlayOptions; cdecl;
    function isVisible: Boolean; cdecl;
    function position(location: JLatLng; width: Single): JGroundOverlayOptions; cdecl; overload;
    function position(location: JLatLng; width: Single; height: Single): JGroundOverlayOptions; cdecl; overload;
    function positionFromBounds(bounds: JLatLngBounds): JGroundOverlayOptions; cdecl;
    function transparency(transparency: Single): JGroundOverlayOptions; cdecl;
    function visible(visible: Boolean): JGroundOverlayOptions; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    function zIndex(zIndex: Single): JGroundOverlayOptions; cdecl;
  end;
  TJGroundOverlayOptions = class(TJavaGenericImport<JGroundOverlayOptionsClass, JGroundOverlayOptions>) end;

  JGroundOverlayOptionsCreatorClass = interface(JObjectClass)
    ['{C3F20BFE-B3FC-4137-9159-3574BC5BDEA6}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JGroundOverlayOptionsCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/GroundOverlayOptionsCreator')]
  JGroundOverlayOptionsCreator = interface(JObject)
    ['{07A591A3-7878-4DB7-BD5D-12BE6AFBEA9B}']
    function createFromParcel(parcel: JParcel): JGroundOverlayOptions; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JGroundOverlayOptions>; cdecl;
  end;
  TJGroundOverlayOptionsCreator = class(TJavaGenericImport<JGroundOverlayOptionsCreatorClass, JGroundOverlayOptionsCreator>) end;

  JLatLngClass = interface(JObjectClass)
    ['{009A2FD1-2E26-4E50-8D97-FF49B8D3E134}']
    {class} function _GetCREATOR: JLatLngCreator; cdecl;
    {class} function init(latitude: Double; longitude: Double): JLatLng; cdecl; overload;
    {class} property CREATOR: JLatLngCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/maps/model/LatLng')]
  JLatLng = interface(JObject)
    ['{1612BD16-050A-4E8E-BBFF-1447D11BED15}']
    function _Getlatitude: Double; cdecl;
    function _Getlongitude: Double; cdecl;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    property latitude: Double read _Getlatitude;
    property longitude: Double read _Getlongitude;
  end;
  TJLatLng = class(TJavaGenericImport<JLatLngClass, JLatLng>) end;

  JLatLngBoundsClass = interface(JObjectClass)
    ['{E18E597F-AE80-4248-A4D1-CE1F3202668C}']
    {class} function _GetCREATOR: JLatLngBoundsCreator; cdecl;
    {class} function builder: JLatLngBounds_Builder; cdecl;
    {class} function init(southwest: JLatLng; northeast: JLatLng): JLatLngBounds; cdecl; overload;
    {class} property CREATOR: JLatLngBoundsCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/maps/model/LatLngBounds')]
  JLatLngBounds = interface(JObject)
    ['{65EF16BB-A68A-43E0-BC7D-0FBFE1321A73}']
    function _Getnortheast: JLatLng; cdecl;
    function _Getsouthwest: JLatLng; cdecl;
    function &contains(point: JLatLng): Boolean; cdecl;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getCenter: JLatLng; cdecl;
    function hashCode: Integer; cdecl;
    function including(point: JLatLng): JLatLngBounds; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    property northeast: JLatLng read _Getnortheast;
    property southwest: JLatLng read _Getsouthwest;
  end;
  TJLatLngBounds = class(TJavaGenericImport<JLatLngBoundsClass, JLatLngBounds>) end;

  JLatLngBounds_BuilderClass = interface(JObjectClass)
    ['{FD670806-8BF8-4499-A135-6A46A4905B7C}']
    {class} function init: JLatLngBounds_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/model/LatLngBounds$Builder')]
  JLatLngBounds_Builder = interface(JObject)
    ['{BC10B895-4AAC-4B39-9F7A-207B7D80DFE4}']
    function build: JLatLngBounds; cdecl;
    function include(point: JLatLng): JLatLngBounds_Builder; cdecl;
  end;
  TJLatLngBounds_Builder = class(TJavaGenericImport<JLatLngBounds_BuilderClass, JLatLngBounds_Builder>) end;

  JLatLngBoundsCreatorClass = interface(JObjectClass)
    ['{EEEFE6B4-19BB-4232-9E02-76E5ACE5D368}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JLatLngBoundsCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/LatLngBoundsCreator')]
  JLatLngBoundsCreator = interface(JObject)
    ['{F0D25814-494C-4A0E-85D8-5D3CD81E9808}']
    function createFromParcel(parcel: JParcel): JLatLngBounds; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JLatLngBounds>; cdecl;
  end;
  TJLatLngBoundsCreator = class(TJavaGenericImport<JLatLngBoundsCreatorClass, JLatLngBoundsCreator>) end;

  JLatLngCreatorClass = interface(JObjectClass)
    ['{099B3392-8621-4CD8-BEA3-6CC7E4A6A503}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JLatLngCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/LatLngCreator')]
  JLatLngCreator = interface(JObject)
    ['{5292361B-08AD-434C-9772-C69A062D115D}']
    function createFromParcel(parcel: JParcel): JLatLng; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JLatLng>; cdecl;
  end;
  TJLatLngCreator = class(TJavaGenericImport<JLatLngCreatorClass, JLatLngCreator>) end;

  JMarkerClass = interface(JObjectClass)
    ['{4A8555E9-4F3A-4C8A-A75E-17FB0015ABBB}']
    {class} //function init(delegate: Jinternal_d): JMarker; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/model/Marker')]
  JMarker = interface(JObject)
    ['{16BF016C-85CC-4E27-A86A-A066BDDCA0B7}']
    function equals(other: JObject): Boolean; cdecl;
    function getAlpha: Single; cdecl;
    function getId: JString; cdecl;
    function getPosition: JLatLng; cdecl;
    function getRotation: Single; cdecl;
    function getSnippet: JString; cdecl;
    function getTitle: JString; cdecl;
    function hashCode: Integer; cdecl;
    procedure hideInfoWindow; cdecl;
    function isDraggable: Boolean; cdecl;
    function isFlat: Boolean; cdecl;
    function isInfoWindowShown: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    procedure remove; cdecl;
    procedure setAlpha(alpha: Single); cdecl;
    procedure setAnchor(anchorU: Single; anchorV: Single); cdecl;
    procedure setDraggable(draggable: Boolean); cdecl;
    procedure setFlat(flat: Boolean); cdecl;
    procedure setIcon(icon: JBitmapDescriptor); cdecl;
    procedure setInfoWindowAnchor(anchorU: Single; anchorV: Single); cdecl;
    procedure setPosition(latlng: JLatLng); cdecl;
    procedure setRotation(rotation: Single); cdecl;
    procedure setSnippet(snippet: JString); cdecl;
    procedure setTitle(title: JString); cdecl;
    procedure setVisible(visible: Boolean); cdecl;
    procedure showInfoWindow; cdecl;
  end;
  TJMarker = class(TJavaGenericImport<JMarkerClass, JMarker>) end;

  JMarkerOptionsClass = interface(JObjectClass)
    ['{BDD0C13B-A5CE-4FD0-85E0-268A9170847F}']
    {class} function _GetCREATOR: JMarkerOptionsCreator; cdecl;
    {class} function init: JMarkerOptions; cdecl; overload;
    {class} property CREATOR: JMarkerOptionsCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/maps/model/MarkerOptions')]
  JMarkerOptions = interface(JObject)
    ['{60B30661-9D1C-4E6F-999B-0F7F13556E9B}']
    function alpha(alpha: Single): JMarkerOptions; cdecl;
    function anchor(u: Single; v: Single): JMarkerOptions; cdecl;
    function describeContents: Integer; cdecl;
    function draggable(draggable: Boolean): JMarkerOptions; cdecl;
    function flat(flat: Boolean): JMarkerOptions; cdecl;
    function getAlpha: Single; cdecl;
    function getAnchorU: Single; cdecl;
    function getAnchorV: Single; cdecl;
    function getIcon: JBitmapDescriptor; cdecl;
    function getInfoWindowAnchorU: Single; cdecl;
    function getInfoWindowAnchorV: Single; cdecl;
    function getPosition: JLatLng; cdecl;
    function getRotation: Single; cdecl;
    function getSnippet: JString; cdecl;
    function getTitle: JString; cdecl;
    function icon(icon: JBitmapDescriptor): JMarkerOptions; cdecl;
    function infoWindowAnchor(u: Single; v: Single): JMarkerOptions; cdecl;
    function isDraggable: Boolean; cdecl;
    function isFlat: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    function position(position: JLatLng): JMarkerOptions; cdecl;
    function rotation(rotation: Single): JMarkerOptions; cdecl;
    function snippet(snippet: JString): JMarkerOptions; cdecl;
    function title(title: JString): JMarkerOptions; cdecl;
    function visible(visible: Boolean): JMarkerOptions; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJMarkerOptions = class(TJavaGenericImport<JMarkerOptionsClass, JMarkerOptions>) end;

  JMarkerOptionsCreatorClass = interface(JObjectClass)
    ['{EF695BEB-416A-44B7-8CDB-597D8729AC3B}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JMarkerOptionsCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/MarkerOptionsCreator')]
  JMarkerOptionsCreator = interface(JObject)
    ['{15AE8D0F-3846-479E-AD98-4CF627C8C80C}']
    function createFromParcel(parcel: JParcel): JMarkerOptions; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JMarkerOptions>; cdecl;
  end;
  TJMarkerOptionsCreator = class(TJavaGenericImport<JMarkerOptionsCreatorClass, JMarkerOptionsCreator>) end;

  JPolygonClass = interface(JObjectClass)
    ['{C32F88C3-3863-4316-AB9E-99F6501F709C}']
    {class} //function init(delegate: Je): JPolygon; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/model/Polygon')]
  JPolygon = interface(JObject)
    ['{BECE8208-AA23-48F1-AC07-849EBCABB32E}']
    function equals(other: JObject): Boolean; cdecl;
    function getFillColor: Integer; cdecl;
    function getHoles: JList; cdecl;
    function getId: JString; cdecl;
    function getPoints: JList; cdecl;
    function getStrokeColor: Integer; cdecl;
    function getStrokeWidth: Single; cdecl;
    function getZIndex: Single; cdecl;
    function hashCode: Integer; cdecl;
    function isGeodesic: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    procedure remove; cdecl;
    procedure setFillColor(color: Integer); cdecl;
    procedure setGeodesic(geodesic: Boolean); cdecl;
    procedure setHoles(holes: JList); cdecl;
    procedure setPoints(points: JList); cdecl;
    procedure setStrokeColor(color: Integer); cdecl;
    procedure setStrokeWidth(width: Single); cdecl;
    procedure setVisible(visible: Boolean); cdecl;
    procedure setZIndex(zIndex: Single); cdecl;
  end;
  TJPolygon = class(TJavaGenericImport<JPolygonClass, JPolygon>) end;

  JPolygonOptionsClass = interface(JObjectClass)
    ['{035017D5-E83D-4EBD-9159-872BB97687F8}']
    {class} function _GetCREATOR: JPolygonOptionsCreator; cdecl;
    {class} function init: JPolygonOptions; cdecl; overload;
    {class} property CREATOR: JPolygonOptionsCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/maps/model/PolygonOptions')]
  JPolygonOptions = interface(JObject)
    ['{D44C6C92-3D47-4E5F-8BA2-0AF69743B24E}']
    function add(points: TJavaObjectArray<JLatLng>): JPolygonOptions; cdecl; overload;
    function add(point: JLatLng): JPolygonOptions; cdecl; overload;
    function addAll(points: JIterable): JPolygonOptions; cdecl;
    function addHole(points: JIterable): JPolygonOptions; cdecl;
    function describeContents: Integer; cdecl;
    function fillColor(color: Integer): JPolygonOptions; cdecl;
    function geodesic(geodesic: Boolean): JPolygonOptions; cdecl;
    function getFillColor: Integer; cdecl;
    function getHoles: JList; cdecl;
    function getPoints: JList; cdecl;
    function getStrokeColor: Integer; cdecl;
    function getStrokeWidth: Single; cdecl;
    function getZIndex: Single; cdecl;
    function isGeodesic: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    function strokeColor(color: Integer): JPolygonOptions; cdecl;
    function strokeWidth(width: Single): JPolygonOptions; cdecl;
    function visible(visible: Boolean): JPolygonOptions; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    function zIndex(zIndex: Single): JPolygonOptions; cdecl;
  end;
  TJPolygonOptions = class(TJavaGenericImport<JPolygonOptionsClass, JPolygonOptions>) end;

  JPolygonOptionsCreatorClass = interface(JObjectClass)
    ['{451873CB-B4E7-4D10-AE9A-D8C2CDAF40BC}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JPolygonOptionsCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/PolygonOptionsCreator')]
  JPolygonOptionsCreator = interface(JObject)
    ['{FEF5C156-01D6-4A8B-96CF-A4330BE7FDB5}']
    function createFromParcel(parcel: JParcel): JPolygonOptions; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JPolygonOptions>; cdecl;
  end;
  TJPolygonOptionsCreator = class(TJavaGenericImport<JPolygonOptionsCreatorClass, JPolygonOptionsCreator>) end;

  JPolylineClass = interface(JObjectClass)
    ['{E56467A2-5381-457A-B96F-E67567F6FABB}']
    {class} function init(delegate: JIPolylineDelegate): JPolyline; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/model/Polyline')]
  JPolyline = interface(JObject)
    ['{803D778F-39F8-4FF2-B9E5-8EC0BD513133}']
    function equals(other: JObject): Boolean; cdecl;
    function getColor: Integer; cdecl;
    function getId: JString; cdecl;
    function getPoints: JList; cdecl;
    function getWidth: Single; cdecl;
    function getZIndex: Single; cdecl;
    function hashCode: Integer; cdecl;
    function isGeodesic: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    procedure remove; cdecl;
    procedure setColor(color: Integer); cdecl;
    procedure setGeodesic(geodesic: Boolean); cdecl;
    procedure setPoints(points: JList); cdecl;
    procedure setVisible(visible: Boolean); cdecl;
    procedure setWidth(width: Single); cdecl;
    procedure setZIndex(zIndex: Single); cdecl;
  end;
  TJPolyline = class(TJavaGenericImport<JPolylineClass, JPolyline>) end;

  JPolylineOptionsClass = interface(JObjectClass)
    ['{73CA0FF0-3ECB-493C-822E-0D9E24EDD021}']
    {class} function _GetCREATOR: JPolylineOptionsCreator; cdecl;
    {class} function init: JPolylineOptions; cdecl; overload;
    {class} property CREATOR: JPolylineOptionsCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/maps/model/PolylineOptions')]
  JPolylineOptions = interface(JObject)
    ['{029E45C1-C7B8-4FDB-B575-B222EC3DE59F}']
    function add(points: TJavaObjectArray<JLatLng>): JPolylineOptions; cdecl; overload;
    function add(point: JLatLng): JPolylineOptions; cdecl; overload;
    function addAll(points: JIterable): JPolylineOptions; cdecl;
    function color(color: Integer): JPolylineOptions; cdecl;
    function describeContents: Integer; cdecl;
    function geodesic(geodesic: Boolean): JPolylineOptions; cdecl;
    function getColor: Integer; cdecl;
    function getPoints: JList; cdecl;
    function getWidth: Single; cdecl;
    function getZIndex: Single; cdecl;
    function isGeodesic: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    function visible(visible: Boolean): JPolylineOptions; cdecl;
    function width(width: Single): JPolylineOptions; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    function zIndex(zIndex: Single): JPolylineOptions; cdecl;
  end;
  TJPolylineOptions = class(TJavaGenericImport<JPolylineOptionsClass, JPolylineOptions>) end;

  JPolylineOptionsCreatorClass = interface(JObjectClass)
    ['{B9E9D567-F636-4201-B628-1311E77AE1E2}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JPolylineOptionsCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/PolylineOptionsCreator')]
  JPolylineOptionsCreator = interface(JObject)
    ['{70DBFF19-B3CA-4C01-9995-38FE447E483E}']
    function createFromParcel(parcel: JParcel): JPolylineOptions; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JPolylineOptions>; cdecl;
  end;
  TJPolylineOptionsCreator = class(TJavaGenericImport<JPolylineOptionsCreatorClass, JPolylineOptionsCreator>) end;

  JRuntimeRemoteExceptionClass = interface(JRuntimeExceptionClass)
    ['{75B6D1D4-4516-4CE8-9B0A-2BCCDA0A51B5}']
    {class} function init(e: JRemoteException): JRuntimeRemoteException; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/model/RuntimeRemoteException')]
  JRuntimeRemoteException = interface(JRuntimeException)
    ['{E6608F23-8EE1-4056-8FB7-CF5C8927EB08}']
  end;
  TJRuntimeRemoteException = class(TJavaGenericImport<JRuntimeRemoteExceptionClass, JRuntimeRemoteException>) end;

  JTileClass = interface(JObjectClass)
    ['{83027546-0EC6-4279-8EE9-9C7D5916EF94}']
    {class} function _GetCREATOR: JTileCreator; cdecl;
    {class} function init(width: Integer; height: Integer; data: TJavaArray<Byte>): JTile; cdecl; overload;
    {class} property CREATOR: JTileCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/maps/model/Tile')]
  JTile = interface(JObject)
    ['{B5DD3D4F-FD9D-431B-BD30-919E328BE40C}']
    function _Getdata: TJavaArray<Byte>; cdecl;
    function _Getheight: Integer; cdecl;
    function _Getwidth: Integer; cdecl;
    function describeContents: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    property data: TJavaArray<Byte> read _Getdata;
    property height: Integer read _Getheight;
    property width: Integer read _Getwidth;
  end;
  TJTile = class(TJavaGenericImport<JTileClass, JTile>) end;

  JTileCreatorClass = interface(JObjectClass)
    ['{D8F0B5B9-8A38-48EA-BE7E-C66EE65155DE}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JTileCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/TileCreator')]
  JTileCreator = interface(JObject)
    ['{D3FF7500-ABCA-4029-A885-7BCBC7411DE1}']
    function createFromParcel(parcel: JParcel): JTile; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JTile>; cdecl;
  end;
  TJTileCreator = class(TJavaGenericImport<JTileCreatorClass, JTileCreator>) end;

  JTileOverlayClass = interface(JObjectClass)
    ['{048A54CE-D00A-4604-A37D-AD23D52380E8}']
    {class} //function init(delegate: Jf): JTileOverlay; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/model/TileOverlay')]
  JTileOverlay = interface(JObject)
    ['{46B2D846-DF98-4A3A-9141-280BBB683586}']
    procedure clearTileCache; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getFadeIn: Boolean; cdecl;
    function getId: JString; cdecl;
    function getZIndex: Single; cdecl;
    function hashCode: Integer; cdecl;
    function isVisible: Boolean; cdecl;
    procedure remove; cdecl;
    procedure setFadeIn(fadeIn: Boolean); cdecl;
    procedure setVisible(visible: Boolean); cdecl;
    procedure setZIndex(zIndex: Single); cdecl;
  end;
  TJTileOverlay = class(TJavaGenericImport<JTileOverlayClass, JTileOverlay>) end;

  JTileOverlayOptionsClass = interface(JObjectClass)
    ['{C3818656-1176-498F-A0E8-106091DEAE4B}']
    {class} function _GetCREATOR: JTileOverlayOptionsCreator; cdecl;
    {class} function init: JTileOverlayOptions; cdecl; overload;
    {class} property CREATOR: JTileOverlayOptionsCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/maps/model/TileOverlayOptions')]
  JTileOverlayOptions = interface(JObject)
    ['{514FFD3B-E0C2-4AD5-89EE-3EB07D1D03AF}']
    function describeContents: Integer; cdecl;
    function fadeIn(fadeIn: Boolean): JTileOverlayOptions; cdecl;
    function getFadeIn: Boolean; cdecl;
    function getTileProvider: JTileProvider; cdecl;
    function getZIndex: Single; cdecl;
    function isVisible: Boolean; cdecl;
    function tileProvider(tileProvider: JTileProvider): JTileOverlayOptions; cdecl;
    function visible(visible: Boolean): JTileOverlayOptions; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    function zIndex(zIndex: Single): JTileOverlayOptions; cdecl;
  end;
  TJTileOverlayOptions = class(TJavaGenericImport<JTileOverlayOptionsClass, JTileOverlayOptions>) end;

  JTileOverlayOptionsCreatorClass = interface(JObjectClass)
    ['{E18C25A6-E13E-4A67-A7B3-73BD8A7DFF05}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JTileOverlayOptionsCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/TileOverlayOptionsCreator')]
  JTileOverlayOptionsCreator = interface(JObject)
    ['{269B57A3-0663-46A7-BD9D-976C9BE7D2C6}']
    function createFromParcel(parcel: JParcel): JTileOverlayOptions; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JTileOverlayOptions>; cdecl;
  end;
  TJTileOverlayOptionsCreator = class(TJavaGenericImport<JTileOverlayOptionsCreatorClass, JTileOverlayOptionsCreator>) end;

  JTileProviderClass = interface(IJavaClass)
    ['{D6128829-67DB-49E4-AB8A-D4ED01E19A11}']
    {class} function _GetNO_TILE: JTile; cdecl;
    {class} property NO_TILE: JTile read _GetNO_TILE;
  end;

  [JavaSignature('com/google/android/gms/maps/model/TileProvider')]
  JTileProvider = interface(IJavaInstance)
    ['{C1D85B3E-623F-4F8C-8CAA-8BFBFC944C61}']
    function getTile(P1: Integer; P2: Integer; P3: Integer): JTile; cdecl;
  end;
  TJTileProvider = class(TJavaGenericImport<JTileProviderClass, JTileProvider>) end;

  JUrlTileProviderClass = interface(JObjectClass)
    ['{34E3DD57-5F4F-4236-99BA-3341D5560F82}']
    {class} function init(width: Integer; height: Integer): JUrlTileProvider; cdecl;
  end;

  [JavaSignature('com/google/android/gms/maps/model/UrlTileProvider')]
  JUrlTileProvider = interface(JObject)
    ['{34F7AB9C-B88F-46BB-BFD6-8EC61EB9E58B}']
    function getTile(x: Integer; y: Integer; zoom: Integer): JTile; cdecl;
    function getTileUrl(P1: Integer; P2: Integer; P3: Integer): JURL; cdecl;
  end;
  TJUrlTileProvider = class(TJavaGenericImport<JUrlTileProviderClass, JUrlTileProvider>) end;

  JVisibleRegionClass = interface(JObjectClass)
    ['{C83C8AE5-7C11-407C-A342-3DE928A8E39B}']
    {class} function _GetCREATOR: JVisibleRegionCreator; cdecl;
    {class} function init(nearLeft: JLatLng; nearRight: JLatLng; farLeft: JLatLng; farRight: JLatLng; latLngBounds: JLatLngBounds): JVisibleRegion; cdecl; overload;
    {class} property CREATOR: JVisibleRegionCreator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/maps/model/VisibleRegion')]
  JVisibleRegion = interface(JObject)
    ['{669FB7E8-207E-4C0A-8882-F056813AB68C}']
    function _GetfarLeft: JLatLng; cdecl;
    function _GetfarRight: JLatLng; cdecl;
    function _GetlatLngBounds: JLatLngBounds; cdecl;
    function _GetnearLeft: JLatLng; cdecl;
    function _GetnearRight: JLatLng; cdecl;
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
    property farLeft: JLatLng read _GetfarLeft;
    property farRight: JLatLng read _GetfarRight;
    property latLngBounds: JLatLngBounds read _GetlatLngBounds;
    property nearLeft: JLatLng read _GetnearLeft;
    property nearRight: JLatLng read _GetnearRight;
  end;
  TJVisibleRegion = class(TJavaGenericImport<JVisibleRegionClass, JVisibleRegion>) end;

  JVisibleRegionCreatorClass = interface(JObjectClass)
    ['{F0ADE27E-6E2F-44CA-B534-65FA78D66A75}']
    {class} function _GetCONTENT_DESCRIPTION: Integer; cdecl;
    {class} function init: JVisibleRegionCreator; cdecl;
    {class} property CONTENT_DESCRIPTION: Integer read _GetCONTENT_DESCRIPTION;
  end;

  [JavaSignature('com/google/android/gms/maps/model/VisibleRegionCreator')]
  JVisibleRegionCreator = interface(JObject)
    ['{77DB84F4-D2D3-42A0-A53A-B50B3BC12993}']
    function createFromParcel(parcel: JParcel): JVisibleRegion; cdecl;
    function newArray(size: Integer): TJavaObjectArray<JVisibleRegion>; cdecl;
  end;
  TJVisibleRegionCreator = class(TJavaGenericImport<JVisibleRegionCreatorClass, JVisibleRegionCreator>) end;

  JIPolylineDelegateClass = interface(JIInterfaceClass)
    ['{B7D05429-CC28-46F2-9BFD-3889D67A17D8}']
  end;

  [JavaSignature('com/google/android/gms/maps/model/internal/IPolylineDelegate')]
  JIPolylineDelegate = interface(JIInterface)
    ['{E6343847-B189-40EB-8B0B-D37417218452}']
    function equalsRemote(P1: JIPolylineDelegate): Boolean; cdecl;
    function getColor: Integer; cdecl;
    function getId: JString; cdecl;
    function getPoints: JList; cdecl;
    function getWidth: Single; cdecl;
    function getZIndex: Single; cdecl;
    function hashCodeRemote: Integer; cdecl;
    function isGeodesic: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    procedure remove; cdecl;
    procedure setColor(P1: Integer); cdecl;
    procedure setGeodesic(P1: Boolean); cdecl;
    procedure setPoints(P1: JList); cdecl;
    procedure setVisible(P1: Boolean); cdecl;
    procedure setWidth(P1: Single); cdecl;
    procedure setZIndex(P1: Single); cdecl;
  end;
  TJIPolylineDelegate = class(TJavaGenericImport<JIPolylineDelegateClass, JIPolylineDelegate>) end;

  JPanoramaClass = interface(JObjectClass)
    ['{B0D507FB-1009-4A6F-B8AD-9D189A889109}']
    {class} //function _GetAPI: JApi; cdecl;
    {class} function loadPanoramaInfo(client: JGoogleApiClient; uri: Jnet_Uri): JPendingResult; cdecl;
    {class} function loadPanoramaInfoAndGrantAccess(client: JGoogleApiClient; uri: Jnet_Uri): JPendingResult; cdecl;
    {class} //property API: JApi read _GetAPI;
  end;

  [JavaSignature('com/google/android/gms/panorama/Panorama')]
  JPanorama = interface(JObject)
    ['{A564B0E0-77F7-4982-B49F-DDF89FF5F557}']
  end;
  TJPanorama = class(TJavaGenericImport<JPanoramaClass, JPanorama>) end;

  JPanorama_PanoramaResultClass = interface(Japi_ResultClass)
    ['{58A22AAC-838F-48F2-8EF5-66CE8B0A3004}']
  end;

  [JavaSignature('com/google/android/gms/panorama/Panorama$PanoramaResult')]
  JPanorama_PanoramaResult = interface(Japi_Result)
    ['{BA75192D-1960-46E8-9BEA-2052821D5504}']
    function getViewerIntent: JIntent; cdecl;
  end;
  TJPanorama_PanoramaResult = class(TJavaGenericImport<JPanorama_PanoramaResultClass, JPanorama_PanoramaResult>) end;

  JPanoramaClientClass = interface(JObjectClass)
    ['{688D7707-E775-4552-B421-F6037A124F89}']
    {class} function init(context: JContext; connectionCallbacks: JGooglePlayServicesClient_ConnectionCallbacks; connectionFailedListener: JGooglePlayServicesClient_OnConnectionFailedListener): JPanoramaClient; cdecl;
  end;

  [JavaSignature('com/google/android/gms/panorama/PanoramaClient')]
  JPanoramaClient = interface(JObject)
    ['{142D7115-631D-45B3-A430-7602789E78F9}']
    procedure connect; cdecl;
    procedure disconnect; cdecl;
    function isConnected: Boolean; cdecl;
    function isConnecting: Boolean; cdecl;
    function isConnectionCallbacksRegistered(listener: JGooglePlayServicesClient_ConnectionCallbacks): Boolean; cdecl;
    function isConnectionFailedListenerRegistered(listener: JGooglePlayServicesClient_OnConnectionFailedListener): Boolean; cdecl;
    procedure loadPanoramaInfo(listener: JPanoramaClient_OnPanoramaInfoLoadedListener; uri: Jnet_Uri); cdecl;
    procedure loadPanoramaInfoAndGrantAccess(listener: JPanoramaClient_OnPanoramaInfoLoadedListener; uri: Jnet_Uri); cdecl;
    procedure registerConnectionCallbacks(listener: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure registerConnectionFailedListener(listener: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
    procedure unregisterConnectionCallbacks(listener: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure unregisterConnectionFailedListener(listener: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
  end;
  TJPanoramaClient = class(TJavaGenericImport<JPanoramaClientClass, JPanoramaClient>) end;

  JPanoramaClient_OnPanoramaInfoLoadedListenerClass = interface(IJavaClass)
    ['{98EE122A-4A2E-4086-947A-CAE0E786F3DC}']
  end;

  [JavaSignature('com/google/android/gms/panorama/PanoramaClient$OnPanoramaInfoLoadedListener')]
  JPanoramaClient_OnPanoramaInfoLoadedListener = interface(IJavaInstance)
    ['{2EEE0D0D-9E71-4292-B757-2B5A8DC23C92}']
    procedure onPanoramaInfoLoaded(P1: JConnectionResult; P2: JIntent); cdecl;
  end;
  TJPanoramaClient_OnPanoramaInfoLoadedListener = class(TJavaGenericImport<JPanoramaClient_OnPanoramaInfoLoadedListenerClass, JPanoramaClient_OnPanoramaInfoLoadedListener>) end;

  Jplus_AccountClass = interface(IJavaClass)
    ['{CAEF528A-BC1B-4666-89C9-66BC7205C1DA}']
  end;

  [JavaSignature('com/google/android/gms/plus/Account')]
  Jplus_Account = interface(IJavaInstance)
    ['{EA2ADA8B-4C5A-410A-A206-C57DF1F32738}']
    procedure clearDefaultAccount(P1: JGoogleApiClient); cdecl;
    function getAccountName(P1: JGoogleApiClient): JString; cdecl;
    function revokeAccessAndDisconnect(P1: JGoogleApiClient): JPendingResult; cdecl;
  end;
  TJplus_Account = class(TJavaGenericImport<Jplus_AccountClass, Jplus_Account>) end;

  JMomentsClass = interface(IJavaClass)
    ['{E9FD16F1-8122-459A-86C4-8020AC20066C}']
  end;

  [JavaSignature('com/google/android/gms/plus/Moments')]
  JMoments = interface(IJavaInstance)
    ['{B742048D-C2B1-4955-B36B-B9AEE1D1C6CE}']
    function load(P1: JGoogleApiClient): JPendingResult; cdecl; overload;
    function load(P1: JGoogleApiClient; P2: Integer; P3: JString; P4: Jnet_Uri; P5: JString; P6: JString): JPendingResult; cdecl; overload;
    function remove(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl;
    function write(P1: JGoogleApiClient; P2: JMoment): JPendingResult; cdecl;
  end;
  TJMoments = class(TJavaGenericImport<JMomentsClass, JMoments>) end;

  JMoments_LoadMomentsResultClass = interface(JReleasableClass)
    ['{236E2B93-CDDB-4AF8-8F9A-DA87783210E9}']
  end;

  [JavaSignature('com/google/android/gms/plus/Moments$LoadMomentsResult')]
  JMoments_LoadMomentsResult = interface(JReleasable)
    ['{D3228DB1-E049-43C8-96E3-98CB2A71DD67}']
    function getMomentBuffer: JMomentBuffer; cdecl;
    function getNextPageToken: JString; cdecl;
    function getUpdated: JString; cdecl;
  end;
  TJMoments_LoadMomentsResult = class(TJavaGenericImport<JMoments_LoadMomentsResultClass, JMoments_LoadMomentsResult>) end;

  JPeopleClass = interface(IJavaClass)
    ['{2F96F9C5-A73C-4E48-8688-893A5D2A9371}']
  end;

  [JavaSignature('com/google/android/gms/plus/People')]
  JPeople = interface(IJavaInstance)
    ['{F6F545BD-AD06-48B9-9D56-E2FB5B3715B1}']
    function getCurrentPerson(P1: JGoogleApiClient): JPerson; cdecl;
    function load(P1: JGoogleApiClient; P2: JCollection): JPendingResult; cdecl; overload;
    function load(P1: JGoogleApiClient; P2: TJavaObjectArray<JString>): JPendingResult; cdecl; overload;
    function loadConnected(P1: JGoogleApiClient): JPendingResult; cdecl;
    function loadVisible(P1: JGoogleApiClient; P2: JString): JPendingResult; cdecl; overload;
    function loadVisible(P1: JGoogleApiClient; P2: Integer; P3: JString): JPendingResult; cdecl; overload;
  end;
  TJPeople = class(TJavaGenericImport<JPeopleClass, JPeople>) end;

  JPeople_LoadPeopleResultClass = interface(JReleasableClass)
    ['{36BFFCBF-81CA-4428-A00E-4B0784BAE332}']
  end;

  [JavaSignature('com/google/android/gms/plus/People$LoadPeopleResult')]
  JPeople_LoadPeopleResult = interface(JReleasable)
    ['{C729EF0D-B552-4F08-9545-82B89909B8E3}']
    function getNextPageToken: JString; cdecl;
    function getPersonBuffer: JPersonBuffer; cdecl;
  end;
  TJPeople_LoadPeopleResult = class(TJavaGenericImport<JPeople_LoadPeopleResultClass, JPeople_LoadPeopleResult>) end;

  JPeople_OrderByClass = interface(IJavaClass)
    ['{9D5D8170-C24A-4CF8-8F13-0A73E6BE817E}']
    {class} function _GetALPHABETICAL: Integer; cdecl;
    {class} function _GetBEST: Integer; cdecl;
    {class} property ALPHABETICAL: Integer read _GetALPHABETICAL;
    {class} property BEST: Integer read _GetBEST;
  end;

  [JavaSignature('com/google/android/gms/plus/People$OrderBy')]
  JPeople_OrderBy = interface(IJavaInstance)
    ['{F9795555-737C-4DB4-B622-AC5B3B2F4171}']
  end;
  TJPeople_OrderBy = class(TJavaGenericImport<JPeople_OrderByClass, JPeople_OrderBy>) end;

  JPlusClass = interface(JObjectClass)
    ['{648B9F94-0955-48F5-9DC5-2100CE513C4D}']
    {class} //function _GetAPI: JApi; cdecl;
    {class} function _GetAccountApi: Jplus_Account; cdecl;
    {class} function _GetMomentsApi: JMoments; cdecl;
    {class} function _GetPeopleApi: JPeople; cdecl;
    {class} //function _GetQK: Jplus_a; cdecl;
    {class} function _GetSCOPE_PLUS_LOGIN: JScope; cdecl;
    {class} function _GetSCOPE_PLUS_PROFILE: JScope; cdecl;
    {class} //function a(P1: JGoogleApiClient; P2: JApi_b): Jplus_internal_e; cdecl;
    {class} //property API: JApi read _GetAPI;
    {class} property AccountApi: Jplus_Account read _GetAccountApi;
    {class} property MomentsApi: JMoments read _GetMomentsApi;
    {class} property PeopleApi: JPeople read _GetPeopleApi;
    {class} //property QK: Jplus_a read _GetQK;
    {class} property SCOPE_PLUS_LOGIN: JScope read _GetSCOPE_PLUS_LOGIN;
    {class} property SCOPE_PLUS_PROFILE: JScope read _GetSCOPE_PLUS_PROFILE;
  end;

  [JavaSignature('com/google/android/gms/plus/Plus')]
  JPlus = interface(JObject)
    ['{67C5123D-AC48-4C05-BD4B-418B6F32BF0D}']
  end;
  TJPlus = class(TJavaGenericImport<JPlusClass, JPlus>) end;

  JPlus_PlusOptionsClass = interface(JObjectClass)
    ['{1D95C460-2E41-4509-94FB-0B7885DD7042}']
    {class} function builder: JPlusOptions_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/plus/Plus$PlusOptions')]
  JPlus_PlusOptions = interface(JObject)
    ['{E15C8E82-5F60-48D2-8625-728B5206251B}']
  end;
  TJPlus_PlusOptions = class(TJavaGenericImport<JPlus_PlusOptionsClass, JPlus_PlusOptions>) end;

  JPlusOptions_BuilderClass = interface(JObjectClass)
    ['{B1C7D100-8E1C-463C-A6C5-CC83BF82DF9B}']
    {class} function init: JPlusOptions_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/plus/Plus$PlusOptions$Builder')]
  JPlusOptions_Builder = interface(JObject)
    ['{83B7AA12-B9AB-4233-946D-E23D0C84DA67}']
    function addActivityTypes(activityTypes: TJavaObjectArray<JString>): JPlusOptions_Builder; cdecl;
    function build: JPlus_PlusOptions; cdecl;
    function setServerClientId(clientId: JString): JPlusOptions_Builder; cdecl;
  end;
  TJPlusOptions_Builder = class(TJavaGenericImport<JPlusOptions_BuilderClass, JPlusOptions_Builder>) end;

  JPlusClientClass = interface(JObjectClass)
    ['{2AA2BFD3-460D-4079-AD6A-957E42CC2FF4}']
  end;

  [JavaSignature('com/google/android/gms/plus/PlusClient')]
  JPlusClient = interface(JObject)
    ['{EAB6DF55-278D-473C-BA80-D1B2C1C0F2BC}']
    procedure clearDefaultAccount; cdecl;
    procedure connect; cdecl;
    procedure disconnect; cdecl;
    function getAccountName: JString; cdecl;
    function getCurrentPerson: JPerson; cdecl;
    function isConnected: Boolean; cdecl;
    function isConnecting: Boolean; cdecl;
    function isConnectionCallbacksRegistered(listener: JGooglePlayServicesClient_ConnectionCallbacks): Boolean; cdecl;
    function isConnectionFailedListenerRegistered(listener: JGooglePlayServicesClient_OnConnectionFailedListener): Boolean; cdecl;
    procedure loadMoments(listener: JPlusClient_OnMomentsLoadedListener); cdecl; overload;
    procedure loadMoments(listener: JPlusClient_OnMomentsLoadedListener; maxResults: Integer; pageToken: JString; targetUrl: Jnet_Uri; type_: JString; userId: JString); cdecl; overload;
    procedure loadPeople(listener: JPlusClient_OnPeopleLoadedListener; personIds: JCollection); cdecl; overload;
    procedure loadPeople(listener: JPlusClient_OnPeopleLoadedListener; personIds: TJavaObjectArray<JString>); cdecl; overload;
    procedure loadVisiblePeople(listener: JPlusClient_OnPeopleLoadedListener; pageToken: JString); cdecl; overload;
    procedure loadVisiblePeople(listener: JPlusClient_OnPeopleLoadedListener; orderBy: Integer; pageToken: JString); cdecl; overload;
    procedure registerConnectionCallbacks(listener: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure registerConnectionFailedListener(listener: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
    procedure removeMoment(momentId: JString); cdecl;
    procedure revokeAccessAndDisconnect(listener: JPlusClient_OnAccessRevokedListener); cdecl;
    procedure unregisterConnectionCallbacks(listener: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure unregisterConnectionFailedListener(listener: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
    procedure writeMoment(moment: JMoment); cdecl;
  end;
  TJPlusClient = class(TJavaGenericImport<JPlusClientClass, JPlusClient>) end;

  JPlusClient_BuilderClass = interface(JObjectClass)
    ['{DBA13DC0-04DE-4A35-9287-C39E7D157EE6}']
    {class} function init(context: JContext; connectionCallbacks: JGooglePlayServicesClient_ConnectionCallbacks; connectionFailedListener: JGooglePlayServicesClient_OnConnectionFailedListener): JPlusClient_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/plus/PlusClient$Builder')]
  JPlusClient_Builder = interface(JObject)
    ['{29ED300A-FFB2-4DB9-8DED-319CABCE900B}']
    function build: JPlusClient; cdecl;
    function clearScopes: JPlusClient_Builder; cdecl;
    function setAccountName(accountName: JString): JPlusClient_Builder; cdecl;
    function setActions(actions: TJavaObjectArray<JString>): JPlusClient_Builder; cdecl;
    function setScopes(scopes: TJavaObjectArray<JString>): JPlusClient_Builder; cdecl;
  end;
  TJPlusClient_Builder = class(TJavaGenericImport<JPlusClient_BuilderClass, JPlusClient_Builder>) end;

  JPlusClient_OnAccessRevokedListenerClass = interface(IJavaClass)
    ['{37BBB8DE-48CE-4DDE-94D7-ECD2D634F555}']
  end;

  [JavaSignature('com/google/android/gms/plus/PlusClient$OnAccessRevokedListener')]
  JPlusClient_OnAccessRevokedListener = interface(IJavaInstance)
    ['{339A35F4-5039-4539-84E1-A54BB83E8462}']
    procedure onAccessRevoked(P1: JConnectionResult); cdecl;
  end;
  TJPlusClient_OnAccessRevokedListener = class(TJavaGenericImport<JPlusClient_OnAccessRevokedListenerClass, JPlusClient_OnAccessRevokedListener>) end;

  JPlusClient_OnMomentsLoadedListenerClass = interface(IJavaClass)
    ['{3BAE124C-4C24-4365-B6CB-EC63C78CCD71}']
  end;

  [JavaSignature('com/google/android/gms/plus/PlusClient$OnMomentsLoadedListener')]
  JPlusClient_OnMomentsLoadedListener = interface(IJavaInstance)
    ['{05069DAE-57BB-4F77-BAC6-3C57DFD827CF}']
    procedure onMomentsLoaded(P1: JConnectionResult; P2: JMomentBuffer; P3: JString; P4: JString); cdecl;
  end;
  TJPlusClient_OnMomentsLoadedListener = class(TJavaGenericImport<JPlusClient_OnMomentsLoadedListenerClass, JPlusClient_OnMomentsLoadedListener>) end;

  JPlusClient_OnPeopleLoadedListenerClass = interface(IJavaClass)
    ['{3ED45DFB-197C-41ED-8DF6-E73FA84D02E8}']
  end;

  [JavaSignature('com/google/android/gms/plus/PlusClient$OnPeopleLoadedListener')]
  JPlusClient_OnPeopleLoadedListener = interface(IJavaInstance)
    ['{4ECCBDF1-0DB9-48F9-BF3C-15F7B09E12E7}']
    procedure onPeopleLoaded(P1: JConnectionResult; P2: JPersonBuffer; P3: JString); cdecl;
  end;
  TJPlusClient_OnPeopleLoadedListener = class(TJavaGenericImport<JPlusClient_OnPeopleLoadedListenerClass, JPlusClient_OnPeopleLoadedListener>) end;

  JPlusClient_OrderByClass = interface(IJavaClass)
    ['{318FADB7-DFAB-4ABF-8CD2-01240A277164}']
    {class} function _GetALPHABETICAL: Integer; cdecl;
    {class} function _GetBEST: Integer; cdecl;
    {class} property ALPHABETICAL: Integer read _GetALPHABETICAL;
    {class} property BEST: Integer read _GetBEST;
  end;

  [JavaSignature('com/google/android/gms/plus/PlusClient$OrderBy')]
  JPlusClient_OrderBy = interface(IJavaInstance)
    ['{3335E9DA-CE30-42BB-B782-4AB6DBA68373}']
  end;
  TJPlusClient_OrderBy = class(TJavaGenericImport<JPlusClient_OrderByClass, JPlusClient_OrderBy>) end;

  JPlusOneButtonClass = interface(JFrameLayoutClass)
    ['{3657EE37-DA35-4156-BE68-79159FB480AD}']
    {class} function _GetANNOTATION_BUBBLE: Integer; cdecl;
    {class} function _GetANNOTATION_INLINE: Integer; cdecl;
    {class} function _GetANNOTATION_NONE: Integer; cdecl;
    {class} function _GetDEFAULT_ACTIVITY_REQUEST_CODE: Integer; cdecl;
    {class} function _GetSIZE_MEDIUM: Integer; cdecl;
    {class} function _GetSIZE_SMALL: Integer; cdecl;
    {class} function _GetSIZE_STANDARD: Integer; cdecl;
    {class} function _GetSIZE_TALL: Integer; cdecl;
    {class} function init(context: JContext): JPlusOneButton; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JPlusOneButton; cdecl; overload;
    {class} property ANNOTATION_BUBBLE: Integer read _GetANNOTATION_BUBBLE;
    {class} property ANNOTATION_INLINE: Integer read _GetANNOTATION_INLINE;
    {class} property ANNOTATION_NONE: Integer read _GetANNOTATION_NONE;
    {class} property DEFAULT_ACTIVITY_REQUEST_CODE: Integer read _GetDEFAULT_ACTIVITY_REQUEST_CODE;
    {class} property SIZE_MEDIUM: Integer read _GetSIZE_MEDIUM;
    {class} property SIZE_SMALL: Integer read _GetSIZE_SMALL;
    {class} property SIZE_STANDARD: Integer read _GetSIZE_STANDARD;
    {class} property SIZE_TALL: Integer read _GetSIZE_TALL;
  end;

  [JavaSignature('com/google/android/gms/plus/PlusOneButton')]
  JPlusOneButton = interface(JFrameLayout)
    ['{673E8BED-682D-4DD7-AFE5-24B67EB89D9E}']
    procedure initialize(url: JString; activityRequestCode: Integer); cdecl; overload;
    procedure initialize(url: JString; plusOneClickListener: JPlusOneButton_OnPlusOneClickListener); cdecl; overload;
    procedure setAnnotation(annotation: Integer); cdecl;
    procedure setOnPlusOneClickListener(listener: JPlusOneButton_OnPlusOneClickListener); cdecl;
    procedure setSize(size: Integer); cdecl;
  end;
  TJPlusOneButton = class(TJavaGenericImport<JPlusOneButtonClass, JPlusOneButton>) end;

  JPlusOneButton_DefaultOnPlusOneClickListenerClass = interface(JObjectClass)
    ['{C32D6623-7C69-4984-897E-6CFEFD16D5C0}']
    {class} function init(proxy: JPlusOneButton; P2: JPlusOneButton_OnPlusOneClickListener): JPlusOneButton_DefaultOnPlusOneClickListener; cdecl;
  end;

  [JavaSignature('com/google/android/gms/plus/PlusOneButton$DefaultOnPlusOneClickListener')]
  JPlusOneButton_DefaultOnPlusOneClickListener = interface(JObject)
    ['{14A21E34-B2CD-4AFA-87E8-9AF8AA7BEB2B}']
    procedure onClick(view: JView); cdecl;
    procedure onPlusOneClick(intent: JIntent); cdecl;
  end;
  TJPlusOneButton_DefaultOnPlusOneClickListener = class(TJavaGenericImport<JPlusOneButton_DefaultOnPlusOneClickListenerClass, JPlusOneButton_DefaultOnPlusOneClickListener>) end;

  JPlusOneButton_OnPlusOneClickListenerClass = interface(IJavaClass)
    ['{42763D8A-94F3-4096-9C01-EBDF8ED918EC}']
  end;

  [JavaSignature('com/google/android/gms/plus/PlusOneButton$OnPlusOneClickListener')]
  JPlusOneButton_OnPlusOneClickListener = interface(IJavaInstance)
    ['{5F317FCE-AD9C-4B7F-BA9A-5E76573B8DC2}']
    procedure onPlusOneClick(P1: JIntent); cdecl;
  end;
  TJPlusOneButton_OnPlusOneClickListener = class(TJavaGenericImport<JPlusOneButton_OnPlusOneClickListenerClass, JPlusOneButton_OnPlusOneClickListener>) end;

  JPlusOneDummyViewClass = interface(JFrameLayoutClass)
    ['{6A8BC622-0DEA-4EF4-B278-B4B5B63161F8}']
    {class} function _GetTAG: JString; cdecl;
    {class} function init(context: JContext; size: Integer): JPlusOneDummyView; cdecl;
    {class} property TAG: JString read _GetTAG;
  end;

  [JavaSignature('com/google/android/gms/plus/PlusOneDummyView')]
  JPlusOneDummyView = interface(JFrameLayout)
    ['{A3ACF6ED-DE0E-43C6-924E-858C7F67599B}']
  end;
  TJPlusOneDummyView = class(TJavaGenericImport<JPlusOneDummyViewClass, JPlusOneDummyView>) end;

  JPlusShareClass = interface(JObjectClass)
    ['{F5B23902-E272-45DE-B1D8-79F147BC1153}']
    {class} function _GetEXTRA_CALL_TO_ACTION: JString; cdecl;
    {class} function _GetEXTRA_CONTENT_DEEP_LINK_ID: JString; cdecl;
    {class} function _GetEXTRA_CONTENT_DEEP_LINK_METADATA: JString; cdecl;
    {class} function _GetEXTRA_CONTENT_URL: JString; cdecl;
    {class} function _GetEXTRA_IS_INTERACTIVE_POST: JString; cdecl;
    {class} function _GetEXTRA_SENDER_ID: JString; cdecl;
    {class} function _GetKEY_CALL_TO_ACTION_DEEP_LINK_ID: JString; cdecl;
    {class} function _GetKEY_CALL_TO_ACTION_LABEL: JString; cdecl;
    {class} function _GetKEY_CALL_TO_ACTION_URL: JString; cdecl;
    {class} function _GetKEY_CONTENT_DEEP_LINK_METADATA_DESCRIPTION: JString; cdecl;
    {class} function _GetKEY_CONTENT_DEEP_LINK_METADATA_THUMBNAIL_URL: JString; cdecl;
    {class} function _GetKEY_CONTENT_DEEP_LINK_METADATA_TITLE: JString; cdecl;
    {class} function _GetPARAM_CONTENT_DEEP_LINK_ID: JString; cdecl;
    {class} function a(P1: JString; P2: JString; P3: Jnet_Uri): JBundle; cdecl;
    {class} function createPerson(id: JString; displayName: JString): JPerson; cdecl;
    {class} function getDeepLinkId(intent: JIntent): JString; cdecl;
    {class} property EXTRA_CALL_TO_ACTION: JString read _GetEXTRA_CALL_TO_ACTION;
    {class} property EXTRA_CONTENT_DEEP_LINK_ID: JString read _GetEXTRA_CONTENT_DEEP_LINK_ID;
    {class} property EXTRA_CONTENT_DEEP_LINK_METADATA: JString read _GetEXTRA_CONTENT_DEEP_LINK_METADATA;
    {class} property EXTRA_CONTENT_URL: JString read _GetEXTRA_CONTENT_URL;
    {class} property EXTRA_IS_INTERACTIVE_POST: JString read _GetEXTRA_IS_INTERACTIVE_POST;
    {class} property EXTRA_SENDER_ID: JString read _GetEXTRA_SENDER_ID;
    {class} property KEY_CALL_TO_ACTION_DEEP_LINK_ID: JString read _GetKEY_CALL_TO_ACTION_DEEP_LINK_ID;
    {class} property KEY_CALL_TO_ACTION_LABEL: JString read _GetKEY_CALL_TO_ACTION_LABEL;
    {class} property KEY_CALL_TO_ACTION_URL: JString read _GetKEY_CALL_TO_ACTION_URL;
    {class} property KEY_CONTENT_DEEP_LINK_METADATA_DESCRIPTION: JString read _GetKEY_CONTENT_DEEP_LINK_METADATA_DESCRIPTION;
    {class} property KEY_CONTENT_DEEP_LINK_METADATA_THUMBNAIL_URL: JString read _GetKEY_CONTENT_DEEP_LINK_METADATA_THUMBNAIL_URL;
    {class} property KEY_CONTENT_DEEP_LINK_METADATA_TITLE: JString read _GetKEY_CONTENT_DEEP_LINK_METADATA_TITLE;
    {class} property PARAM_CONTENT_DEEP_LINK_ID: JString read _GetPARAM_CONTENT_DEEP_LINK_ID;
  end;

  [JavaSignature('com/google/android/gms/plus/PlusShare')]
  JPlusShare = interface(JObject)
    ['{B5154807-934B-4AEA-B761-7B3E99A5F5C7}']
  end;
  TJPlusShare = class(TJavaGenericImport<JPlusShareClass, JPlusShare>) end;

  JPlusShare_BuilderClass = interface(JObjectClass)
    ['{452E7438-523E-49EE-8D62-DC1F947CB0F0}']
    {class} function init(context: JContext): JPlusShare_Builder; cdecl; overload;
    {class} function init(launchingActivity: JActivity): JPlusShare_Builder; cdecl; overload;
    {class} function init(launchingActivity: JActivity; plusClient: JPlusClient): JPlusShare_Builder; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/plus/PlusShare$Builder')]
  JPlusShare_Builder = interface(JObject)
    ['{84FC9DA5-38FA-4A1F-AB92-0E3DCF29AD94}']
    function addCallToAction(label_: JString; uri: Jnet_Uri; deepLinkId: JString): JPlusShare_Builder; cdecl;
    function addStream(streamUri: Jnet_Uri): JPlusShare_Builder; cdecl;
    function getIntent: JIntent; cdecl;
    function setContentDeepLinkId(deepLinkId: JString): JPlusShare_Builder; cdecl; overload;
    function setContentDeepLinkId(deepLinkId: JString; title: JString; description: JString; thumbnailUri: Jnet_Uri): JPlusShare_Builder; cdecl; overload;
    function setContentUrl(uri: Jnet_Uri): JPlusShare_Builder; cdecl;
    function setRecipients(recipientList: JList): JPlusShare_Builder; cdecl; overload;
    function setRecipients(user: JPerson; recipientList: JList): JPlusShare_Builder; cdecl; overload;
    function setStream(streamUri: Jnet_Uri): JPlusShare_Builder; cdecl;
    function setText(text: JCharSequence): JPlusShare_Builder; cdecl;
    function setType(mimeType: JString): JPlusShare_Builder; cdecl;
  end;
  TJPlusShare_Builder = class(TJavaGenericImport<JPlusShare_BuilderClass, JPlusShare_Builder>) end;

  JPlusCommonExtrasClass = interface(JObjectClass)
    ['{90BF2FA8-0757-4289-BF48-62B51B34B736}']
    {class} //function _GetCREATOR: Jplus_internal_f; cdecl;
    {class} function _GetTAG: JString; cdecl;
    {class} procedure _SetTAG(Value: JString); cdecl;
    {class} function init: JPlusCommonExtras; cdecl; overload;
    {class} //property CREATOR: Jplus_internal_f read _GetCREATOR;
    {class} property TAG: JString read _GetTAG write _SetTAG;
  end;

  [JavaSignature('com/google/android/gms/plus/internal/PlusCommonExtras')]
  JPlusCommonExtras = interface(JObject)
    ['{1DFA6828-65ED-4482-9BCD-E2D3F8CE4FE3}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getVersionCode: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function ho: JString; cdecl;
    function hp: JString; cdecl;
    procedure m(P1: JBundle); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJPlusCommonExtras = class(TJavaGenericImport<JPlusCommonExtrasClass, JPlusCommonExtras>) end;

  JItemScopeClass = interface(JFreezableClass)
    ['{236B5A11-B17F-4B73-AB0B-3CEE2FD976B6}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/moments/ItemScope')]
  JItemScope = interface(JFreezable)
    ['{B5E3B8DA-655E-4DE0-9E9E-C2E2EAD3A645}']
    function getAbout: JItemScope; cdecl;
    function getAdditionalName: JList; cdecl;
    function getAddress: JItemScope; cdecl;
    function getAddressCountry: JString; cdecl;
    function getAddressLocality: JString; cdecl;
    function getAddressRegion: JString; cdecl;
    function getAssociated_media: JList; cdecl;
    function getAttendeeCount: Integer; cdecl;
    function getAttendees: JList; cdecl;
    function getAudio: JItemScope; cdecl;
    function getAuthor: JList; cdecl;
    function getBestRating: JString; cdecl;
    function getBirthDate: JString; cdecl;
    function getByArtist: JItemScope; cdecl;
    function getCaption: JString; cdecl;
    function getContentSize: JString; cdecl;
    function getContentUrl: JString; cdecl;
    function getContributor: JList; cdecl;
    function getDateCreated: JString; cdecl;
    function getDateModified: JString; cdecl;
    function getDatePublished: JString; cdecl;
    function getDescription: JString; cdecl;
    function getDuration: JString; cdecl;
    function getEmbedUrl: JString; cdecl;
    function getEndDate: JString; cdecl;
    function getFamilyName: JString; cdecl;
    function getGender: JString; cdecl;
    function getGeo: JItemScope; cdecl;
    function getGivenName: JString; cdecl;
    function getHeight: JString; cdecl;
    function getId: JString; cdecl;
    function getImage: JString; cdecl;
    function getInAlbum: JItemScope; cdecl;
    function getLatitude: Double; cdecl;
    function getLocation: JItemScope; cdecl;
    function getLongitude: Double; cdecl;
    function getName: JString; cdecl;
    function getPartOfTVSeries: JItemScope; cdecl;
    function getPerformers: JList; cdecl;
    function getPlayerType: JString; cdecl;
    function getPostOfficeBoxNumber: JString; cdecl;
    function getPostalCode: JString; cdecl;
    function getRatingValue: JString; cdecl;
    function getReviewRating: JItemScope; cdecl;
    function getStartDate: JString; cdecl;
    function getStreetAddress: JString; cdecl;
    function getText: JString; cdecl;
    function getThumbnail: JItemScope; cdecl;
    function getThumbnailUrl: JString; cdecl;
    function getTickerSymbol: JString; cdecl;
    function getType: JString; cdecl;
    function getUrl: JString; cdecl;
    function getWidth: JString; cdecl;
    function getWorstRating: JString; cdecl;
    function hasAbout: Boolean; cdecl;
    function hasAdditionalName: Boolean; cdecl;
    function hasAddress: Boolean; cdecl;
    function hasAddressCountry: Boolean; cdecl;
    function hasAddressLocality: Boolean; cdecl;
    function hasAddressRegion: Boolean; cdecl;
    function hasAssociated_media: Boolean; cdecl;
    function hasAttendeeCount: Boolean; cdecl;
    function hasAttendees: Boolean; cdecl;
    function hasAudio: Boolean; cdecl;
    function hasAuthor: Boolean; cdecl;
    function hasBestRating: Boolean; cdecl;
    function hasBirthDate: Boolean; cdecl;
    function hasByArtist: Boolean; cdecl;
    function hasCaption: Boolean; cdecl;
    function hasContentSize: Boolean; cdecl;
    function hasContentUrl: Boolean; cdecl;
    function hasContributor: Boolean; cdecl;
    function hasDateCreated: Boolean; cdecl;
    function hasDateModified: Boolean; cdecl;
    function hasDatePublished: Boolean; cdecl;
    function hasDescription: Boolean; cdecl;
    function hasDuration: Boolean; cdecl;
    function hasEmbedUrl: Boolean; cdecl;
    function hasEndDate: Boolean; cdecl;
    function hasFamilyName: Boolean; cdecl;
    function hasGender: Boolean; cdecl;
    function hasGeo: Boolean; cdecl;
    function hasGivenName: Boolean; cdecl;
    function hasHeight: Boolean; cdecl;
    function hasId: Boolean; cdecl;
    function hasImage: Boolean; cdecl;
    function hasInAlbum: Boolean; cdecl;
    function hasLatitude: Boolean; cdecl;
    function hasLocation: Boolean; cdecl;
    function hasLongitude: Boolean; cdecl;
    function hasName: Boolean; cdecl;
    function hasPartOfTVSeries: Boolean; cdecl;
    function hasPerformers: Boolean; cdecl;
    function hasPlayerType: Boolean; cdecl;
    function hasPostOfficeBoxNumber: Boolean; cdecl;
    function hasPostalCode: Boolean; cdecl;
    function hasRatingValue: Boolean; cdecl;
    function hasReviewRating: Boolean; cdecl;
    function hasStartDate: Boolean; cdecl;
    function hasStreetAddress: Boolean; cdecl;
    function hasText: Boolean; cdecl;
    function hasThumbnail: Boolean; cdecl;
    function hasThumbnailUrl: Boolean; cdecl;
    function hasTickerSymbol: Boolean; cdecl;
    function hasType: Boolean; cdecl;
    function hasUrl: Boolean; cdecl;
    function hasWidth: Boolean; cdecl;
    function hasWorstRating: Boolean; cdecl;
  end;
  TJItemScope = class(TJavaGenericImport<JItemScopeClass, JItemScope>) end;

  JItemScope_BuilderClass = interface(JObjectClass)
    ['{D190EF3D-EEB6-4FDB-B3FC-67C90C5B9758}']
    {class} function init: JItemScope_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/plus/model/moments/ItemScope$Builder')]
  JItemScope_Builder = interface(JObject)
    ['{56EBB360-26B6-419C-9094-9E4CCFD02E67}']
    function build: JItemScope; cdecl;
    function setAbout(about: JItemScope): JItemScope_Builder; cdecl;
    function setAdditionalName(additionalName: JList): JItemScope_Builder; cdecl;
    function setAddress(address: JItemScope): JItemScope_Builder; cdecl;
    function setAddressCountry(addressCountry: JString): JItemScope_Builder; cdecl;
    function setAddressLocality(addressLocality: JString): JItemScope_Builder; cdecl;
    function setAddressRegion(addressRegion: JString): JItemScope_Builder; cdecl;
    function setAssociated_media(associated_media: JList): JItemScope_Builder; cdecl;
    function setAttendeeCount(attendeeCount: Integer): JItemScope_Builder; cdecl;
    function setAttendees(attendees: JList): JItemScope_Builder; cdecl;
    function setAudio(audio: JItemScope): JItemScope_Builder; cdecl;
    function setAuthor(author: JList): JItemScope_Builder; cdecl;
    function setBestRating(bestRating: JString): JItemScope_Builder; cdecl;
    function setBirthDate(birthDate: JString): JItemScope_Builder; cdecl;
    function setByArtist(byArtist: JItemScope): JItemScope_Builder; cdecl;
    function setCaption(caption: JString): JItemScope_Builder; cdecl;
    function setContentSize(contentSize: JString): JItemScope_Builder; cdecl;
    function setContentUrl(contentUrl: JString): JItemScope_Builder; cdecl;
    function setContributor(contributor: JList): JItemScope_Builder; cdecl;
    function setDateCreated(dateCreated: JString): JItemScope_Builder; cdecl;
    function setDateModified(dateModified: JString): JItemScope_Builder; cdecl;
    function setDatePublished(datePublished: JString): JItemScope_Builder; cdecl;
    function setDescription(description: JString): JItemScope_Builder; cdecl;
    function setDuration(duration: JString): JItemScope_Builder; cdecl;
    function setEmbedUrl(embedUrl: JString): JItemScope_Builder; cdecl;
    function setEndDate(endDate: JString): JItemScope_Builder; cdecl;
    function setFamilyName(familyName: JString): JItemScope_Builder; cdecl;
    function setGender(gender: JString): JItemScope_Builder; cdecl;
    function setGeo(geo: JItemScope): JItemScope_Builder; cdecl;
    function setGivenName(givenName: JString): JItemScope_Builder; cdecl;
    function setHeight(height: JString): JItemScope_Builder; cdecl;
    function setId(id: JString): JItemScope_Builder; cdecl;
    function setImage(image: JString): JItemScope_Builder; cdecl;
    function setInAlbum(inAlbum: JItemScope): JItemScope_Builder; cdecl;
    function setLatitude(latitude: Double): JItemScope_Builder; cdecl;
    function setLocation(location: JItemScope): JItemScope_Builder; cdecl;
    function setLongitude(longitude: Double): JItemScope_Builder; cdecl;
    function setName(name: JString): JItemScope_Builder; cdecl;
    function setPartOfTVSeries(partOfTVSeries: JItemScope): JItemScope_Builder; cdecl;
    function setPerformers(performers: JList): JItemScope_Builder; cdecl;
    function setPlayerType(playerType: JString): JItemScope_Builder; cdecl;
    function setPostOfficeBoxNumber(postOfficeBoxNumber: JString): JItemScope_Builder; cdecl;
    function setPostalCode(postalCode: JString): JItemScope_Builder; cdecl;
    function setRatingValue(ratingValue: JString): JItemScope_Builder; cdecl;
    function setReviewRating(reviewRating: JItemScope): JItemScope_Builder; cdecl;
    function setStartDate(startDate: JString): JItemScope_Builder; cdecl;
    function setStreetAddress(streetAddress: JString): JItemScope_Builder; cdecl;
    function setText(text: JString): JItemScope_Builder; cdecl;
    function setThumbnail(thumbnail: JItemScope): JItemScope_Builder; cdecl;
    function setThumbnailUrl(thumbnailUrl: JString): JItemScope_Builder; cdecl;
    function setTickerSymbol(tickerSymbol: JString): JItemScope_Builder; cdecl;
    function setType(type_: JString): JItemScope_Builder; cdecl;
    function setUrl(url: JString): JItemScope_Builder; cdecl;
    function setWidth(width: JString): JItemScope_Builder; cdecl;
    function setWorstRating(worstRating: JString): JItemScope_Builder; cdecl;
  end;
  TJItemScope_Builder = class(TJavaGenericImport<JItemScope_BuilderClass, JItemScope_Builder>) end;

  JMomentClass = interface(JFreezableClass)
    ['{4F99F47F-21F8-4492-98A3-1EAC01C6E87A}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/moments/Moment')]
  JMoment = interface(JFreezable)
    ['{313E023A-E21E-4C51-A33B-98FD3FE5BD5C}']
    function getId: JString; cdecl;
    function getResult: JItemScope; cdecl;
    function getStartDate: JString; cdecl;
    function getTarget: JItemScope; cdecl;
    function getType: JString; cdecl;
    function hasId: Boolean; cdecl;
    function hasResult: Boolean; cdecl;
    function hasStartDate: Boolean; cdecl;
    function hasTarget: Boolean; cdecl;
    function hasType: Boolean; cdecl;
  end;
  TJMoment = class(TJavaGenericImport<JMomentClass, JMoment>) end;

  JMoment_BuilderClass = interface(JObjectClass)
    ['{02E48441-AAC0-4256-AB90-E655FE75E9C3}']
    {class} function init: JMoment_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/plus/model/moments/Moment$Builder')]
  JMoment_Builder = interface(JObject)
    ['{7C265211-A570-404E-AE7E-D29FCD819EE9}']
    function build: JMoment; cdecl;
    function setId(id: JString): JMoment_Builder; cdecl;
    function setResult(result: JItemScope): JMoment_Builder; cdecl;
    function setStartDate(startDate: JString): JMoment_Builder; cdecl;
    function setTarget(target: JItemScope): JMoment_Builder; cdecl;
    function setType(type_: JString): JMoment_Builder; cdecl;
  end;
  TJMoment_Builder = class(TJavaGenericImport<JMoment_BuilderClass, JMoment_Builder>) end;

  JMomentBufferClass = interface(JDataBufferClass)
    ['{416E2747-6851-4A1B-8EBE-F614C92C251D}']
    {class} function init(dataHolder: JDataHolder): JMomentBuffer; cdecl;
  end;

  [JavaSignature('com/google/android/gms/plus/model/moments/MomentBuffer')]
  JMomentBuffer = interface(JDataBuffer)
    ['{B8DEF9D3-75C0-4C86-A439-6612B998A9EA}']
    function &get(position: Integer): JMoment; cdecl;
  end;
  TJMomentBuffer = class(TJavaGenericImport<JMomentBufferClass, JMomentBuffer>) end;

  JPersonClass = interface(JFreezableClass)
    ['{73914393-03C0-47A6-8267-A900E6A8E1FE}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person')]
  JPerson = interface(JFreezable)
    ['{BA0A0480-FDFF-4DFC-BB62-5E4C7CA1693B}']
    function getAboutMe: JString; cdecl;
    function getAgeRange: JPerson_AgeRange; cdecl;
    function getBirthday: JString; cdecl;
    function getBraggingRights: JString; cdecl;
    function getCircledByCount: Integer; cdecl;
    function getCover: JPerson_Cover; cdecl;
    function getCurrentLocation: JString; cdecl;
    function getDisplayName: JString; cdecl;
    function getGender: Integer; cdecl;
    function getId: JString; cdecl;
    function getImage: JPerson_Image; cdecl;
    function getLanguage: JString; cdecl;
    function getName: JPerson_Name; cdecl;
    function getNickname: JString; cdecl;
    function getObjectType: Integer; cdecl;
    function getOrganizations: JList; cdecl;
    function getPlacesLived: JList; cdecl;
    function getPlusOneCount: Integer; cdecl;
    function getRelationshipStatus: Integer; cdecl;
    function getTagline: JString; cdecl;
    function getUrl: JString; cdecl;
    function getUrls: JList; cdecl;
    function hasAboutMe: Boolean; cdecl;
    function hasAgeRange: Boolean; cdecl;
    function hasBirthday: Boolean; cdecl;
    function hasBraggingRights: Boolean; cdecl;
    function hasCircledByCount: Boolean; cdecl;
    function hasCover: Boolean; cdecl;
    function hasCurrentLocation: Boolean; cdecl;
    function hasDisplayName: Boolean; cdecl;
    function hasGender: Boolean; cdecl;
    function hasId: Boolean; cdecl;
    function hasImage: Boolean; cdecl;
    function hasIsPlusUser: Boolean; cdecl;
    function hasLanguage: Boolean; cdecl;
    function hasName: Boolean; cdecl;
    function hasNickname: Boolean; cdecl;
    function hasObjectType: Boolean; cdecl;
    function hasOrganizations: Boolean; cdecl;
    function hasPlacesLived: Boolean; cdecl;
    function hasPlusOneCount: Boolean; cdecl;
    function hasRelationshipStatus: Boolean; cdecl;
    function hasTagline: Boolean; cdecl;
    function hasUrl: Boolean; cdecl;
    function hasUrls: Boolean; cdecl;
    function hasVerified: Boolean; cdecl;
    function isPlusUser: Boolean; cdecl;
    function isVerified: Boolean; cdecl;
  end;
  TJPerson = class(TJavaGenericImport<JPersonClass, JPerson>) end;

  JPerson_AgeRangeClass = interface(JFreezableClass)
    ['{755F2210-AB4C-4A53-B17E-3D9CC136167A}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$AgeRange')]
  JPerson_AgeRange = interface(JFreezable)
    ['{F89766AD-8608-40F8-984E-2239413488D2}']
    function getMax: Integer; cdecl;
    function getMin: Integer; cdecl;
    function hasMax: Boolean; cdecl;
    function hasMin: Boolean; cdecl;
  end;
  TJPerson_AgeRange = class(TJavaGenericImport<JPerson_AgeRangeClass, JPerson_AgeRange>) end;

  JPerson_CoverClass = interface(JFreezableClass)
    ['{2A01AA50-3C30-46A4-A619-A5F534ECE9AF}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$Cover')]
  JPerson_Cover = interface(JFreezable)
    ['{E13C8C39-D1B3-4E10-9548-2FEF8EF93128}']
    function getCoverInfo: JCover_CoverInfo; cdecl;
    function getCoverPhoto: JCover_CoverPhoto; cdecl;
    function getLayout: Integer; cdecl;
    function hasCoverInfo: Boolean; cdecl;
    function hasCoverPhoto: Boolean; cdecl;
    function hasLayout: Boolean; cdecl;
  end;
  TJPerson_Cover = class(TJavaGenericImport<JPerson_CoverClass, JPerson_Cover>) end;

  JCover_CoverInfoClass = interface(JFreezableClass)
    ['{5B6BC276-5F96-4282-98A4-9790D72CAF54}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$Cover$CoverInfo')]
  JCover_CoverInfo = interface(JFreezable)
    ['{006DC380-FDF0-4FA3-9F8C-217EA45B4B5E}']
    function getLeftImageOffset: Integer; cdecl;
    function getTopImageOffset: Integer; cdecl;
    function hasLeftImageOffset: Boolean; cdecl;
    function hasTopImageOffset: Boolean; cdecl;
  end;
  TJCover_CoverInfo = class(TJavaGenericImport<JCover_CoverInfoClass, JCover_CoverInfo>) end;

  JCover_CoverPhotoClass = interface(JFreezableClass)
    ['{5E73FFC1-DF5D-41C2-A163-0673962BE9AE}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$Cover$CoverPhoto')]
  JCover_CoverPhoto = interface(JFreezable)
    ['{33A3B764-B1B4-4E0F-B4C7-DAD6578FBCCD}']
    function getHeight: Integer; cdecl;
    function getUrl: JString; cdecl;
    function getWidth: Integer; cdecl;
    function hasHeight: Boolean; cdecl;
    function hasUrl: Boolean; cdecl;
    function hasWidth: Boolean; cdecl;
  end;
  TJCover_CoverPhoto = class(TJavaGenericImport<JCover_CoverPhotoClass, JCover_CoverPhoto>) end;

  JCover_LayoutClass = interface(JObjectClass)
    ['{5E0959E7-198F-427F-A926-C97B63E79B11}']
    {class} function _GetBANNER: Integer; cdecl;
    {class} property BANNER: Integer read _GetBANNER;
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$Cover$Layout')]
  JCover_Layout = interface(JObject)
    ['{E7631A78-F831-4040-ACA8-C44B23E692AC}']
  end;
  TJCover_Layout = class(TJavaGenericImport<JCover_LayoutClass, JCover_Layout>) end;

  JPerson_GenderClass = interface(JObjectClass)
    ['{C5EFF326-3D1E-47C0-8380-08A20A233161}']
    {class} function _GetFEMALE: Integer; cdecl;
    {class} function _GetMALE: Integer; cdecl;
    {class} function _GetOTHER: Integer; cdecl;
    {class} property FEMALE: Integer read _GetFEMALE;
    {class} property MALE: Integer read _GetMALE;
    {class} property OTHER: Integer read _GetOTHER;
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$Gender')]
  JPerson_Gender = interface(JObject)
    ['{281D7398-5B5B-48D1-B017-BC092805F5AF}']
  end;
  TJPerson_Gender = class(TJavaGenericImport<JPerson_GenderClass, JPerson_Gender>) end;

  JPerson_ImageClass = interface(JFreezableClass)
    ['{6DB0FFAC-5A6D-4DAB-A867-62C95962B79A}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$Image')]
  JPerson_Image = interface(JFreezable)
    ['{2EAA856D-748D-46BE-91E6-1B6ECF906959}']
    function getUrl: JString; cdecl;
    function hasUrl: Boolean; cdecl;
  end;
  TJPerson_Image = class(TJavaGenericImport<JPerson_ImageClass, JPerson_Image>) end;

  JPerson_NameClass = interface(JFreezableClass)
    ['{1F3419CD-2F77-4055-9DF0-19AF842C36F3}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$Name')]
  JPerson_Name = interface(JFreezable)
    ['{1524AC78-0D17-4E1F-9374-6DAE864F2F3D}']
    function getFamilyName: JString; cdecl;
    function getFormatted: JString; cdecl;
    function getGivenName: JString; cdecl;
    function getHonorificPrefix: JString; cdecl;
    function getHonorificSuffix: JString; cdecl;
    function getMiddleName: JString; cdecl;
    function hasFamilyName: Boolean; cdecl;
    function hasFormatted: Boolean; cdecl;
    function hasGivenName: Boolean; cdecl;
    function hasHonorificPrefix: Boolean; cdecl;
    function hasHonorificSuffix: Boolean; cdecl;
    function hasMiddleName: Boolean; cdecl;
  end;
  TJPerson_Name = class(TJavaGenericImport<JPerson_NameClass, JPerson_Name>) end;

  JPerson_ObjectTypeClass = interface(JObjectClass)
    ['{F7264D9D-1876-4E97-ACA0-A612669722C4}']
    {class} function _GetPAGE: Integer; cdecl;
    {class} function _GetPERSON: Integer; cdecl;
    {class} property PAGE: Integer read _GetPAGE;
    {class} property PERSON: Integer read _GetPERSON;
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$ObjectType')]
  JPerson_ObjectType = interface(JObject)
    ['{5286AD08-0594-46C2-91CC-A7BF5AF29B32}']
  end;
  TJPerson_ObjectType = class(TJavaGenericImport<JPerson_ObjectTypeClass, JPerson_ObjectType>) end;

  JPerson_OrganizationsClass = interface(JFreezableClass)
    ['{518FDD9A-EFE3-4253-8BE6-7EF263AD3213}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$Organizations')]
  JPerson_Organizations = interface(JFreezable)
    ['{E6C4E8DE-9009-459D-956F-6C8440A3D70B}']
    function getDepartment: JString; cdecl;
    function getDescription: JString; cdecl;
    function getEndDate: JString; cdecl;
    function getLocation: JString; cdecl;
    function getName: JString; cdecl;
    function getStartDate: JString; cdecl;
    function getTitle: JString; cdecl;
    function getType: Integer; cdecl;
    function hasDepartment: Boolean; cdecl;
    function hasDescription: Boolean; cdecl;
    function hasEndDate: Boolean; cdecl;
    function hasLocation: Boolean; cdecl;
    function hasName: Boolean; cdecl;
    function hasPrimary: Boolean; cdecl;
    function hasStartDate: Boolean; cdecl;
    function hasTitle: Boolean; cdecl;
    function hasType: Boolean; cdecl;
    function isPrimary: Boolean; cdecl;
  end;
  TJPerson_Organizations = class(TJavaGenericImport<JPerson_OrganizationsClass, JPerson_Organizations>) end;

  JOrganizations_TypeClass = interface(JObjectClass)
    ['{F3B7E31B-1878-4F86-BDF0-14672C1CB488}']
    {class} function _GetSCHOOL: Integer; cdecl;
    {class} function _GetWORK: Integer; cdecl;
    {class} property SCHOOL: Integer read _GetSCHOOL;
    {class} property WORK: Integer read _GetWORK;
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$Organizations$Type')]
  JOrganizations_Type = interface(JObject)
    ['{D2D199DB-8AE7-41D8-BE84-4BFA75045008}']
  end;
  TJOrganizations_Type = class(TJavaGenericImport<JOrganizations_TypeClass, JOrganizations_Type>) end;

  JPerson_PlacesLivedClass = interface(JFreezableClass)
    ['{92550503-05E8-4307-AEC2-A3BFD35FEE3C}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$PlacesLived')]
  JPerson_PlacesLived = interface(JFreezable)
    ['{087C2C27-6FA3-4A64-A848-530978D04BD9}']
    function getValue: JString; cdecl;
    function hasPrimary: Boolean; cdecl;
    function hasValue: Boolean; cdecl;
    function isPrimary: Boolean; cdecl;
  end;
  TJPerson_PlacesLived = class(TJavaGenericImport<JPerson_PlacesLivedClass, JPerson_PlacesLived>) end;

  JPerson_RelationshipStatusClass = interface(JObjectClass)
    ['{16F8D0BC-2ECD-47A3-810F-425D0B22BC00}']
    {class} function _GetENGAGED: Integer; cdecl;
    {class} function _GetIN_A_RELATIONSHIP: Integer; cdecl;
    {class} function _GetIN_CIVIL_UNION: Integer; cdecl;
    {class} function _GetIN_DOMESTIC_PARTNERSHIP: Integer; cdecl;
    {class} function _GetITS_COMPLICATED: Integer; cdecl;
    {class} function _GetMARRIED: Integer; cdecl;
    {class} function _GetOPEN_RELATIONSHIP: Integer; cdecl;
    {class} function _GetSINGLE: Integer; cdecl;
    {class} function _GetWIDOWED: Integer; cdecl;
    {class} property ENGAGED: Integer read _GetENGAGED;
    {class} property IN_A_RELATIONSHIP: Integer read _GetIN_A_RELATIONSHIP;
    {class} property IN_CIVIL_UNION: Integer read _GetIN_CIVIL_UNION;
    {class} property IN_DOMESTIC_PARTNERSHIP: Integer read _GetIN_DOMESTIC_PARTNERSHIP;
    {class} property ITS_COMPLICATED: Integer read _GetITS_COMPLICATED;
    {class} property MARRIED: Integer read _GetMARRIED;
    {class} property OPEN_RELATIONSHIP: Integer read _GetOPEN_RELATIONSHIP;
    {class} property SINGLE: Integer read _GetSINGLE;
    {class} property WIDOWED: Integer read _GetWIDOWED;
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$RelationshipStatus')]
  JPerson_RelationshipStatus = interface(JObject)
    ['{16665CEF-172C-493B-A0E3-A300E3569328}']
  end;
  TJPerson_RelationshipStatus = class(TJavaGenericImport<JPerson_RelationshipStatusClass, JPerson_RelationshipStatus>) end;

  JPerson_UrlsClass = interface(JFreezableClass)
    ['{F4F0CAD5-A2F2-4749-BA4B-294B87D8827A}']
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$Urls')]
  JPerson_Urls = interface(JFreezable)
    ['{75FAAEDA-782C-46FA-9A33-33C1D2CE45CB}']
    function getLabel: JString; cdecl;
    function getType: Integer; cdecl;
    function getValue: JString; cdecl;
    function hasLabel: Boolean; cdecl;
    function hasType: Boolean; cdecl;
    function hasValue: Boolean; cdecl;
  end;
  TJPerson_Urls = class(TJavaGenericImport<JPerson_UrlsClass, JPerson_Urls>) end;

  JUrls_TypeClass = interface(JObjectClass)
    ['{FCDE35BA-BA1A-4AAB-A7B8-BA4BA79C6116}']
    {class} function _GetCONTRIBUTOR: Integer; cdecl;
    {class} function _GetOTHER: Integer; cdecl;
    {class} function _GetOTHER_PROFILE: Integer; cdecl;
    {class} function _GetWEBSITE: Integer; cdecl;
    {class} property CONTRIBUTOR: Integer read _GetCONTRIBUTOR;
    {class} property OTHER: Integer read _GetOTHER;
    {class} property OTHER_PROFILE: Integer read _GetOTHER_PROFILE;
    {class} property WEBSITE: Integer read _GetWEBSITE;
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/Person$Urls$Type')]
  JUrls_Type = interface(JObject)
    ['{B7224F92-BC58-4572-88F0-8AA7266F7B88}']
  end;
  TJUrls_Type = class(TJavaGenericImport<JUrls_TypeClass, JUrls_Type>) end;

  JPersonBufferClass = interface(JDataBufferClass)
    ['{4AEB7532-3916-4C78-BD28-EDEF098AD60E}']
    {class} function init(dataHolder: JDataHolder): JPersonBuffer; cdecl;
  end;

  [JavaSignature('com/google/android/gms/plus/model/people/PersonBuffer')]
  JPersonBuffer = interface(JDataBuffer)
    ['{E90B2976-B2D6-4A8E-979A-6A26C86DAC66}']
    function &get(position: Integer): JPerson; cdecl;
  end;
  TJPersonBuffer = class(TJavaGenericImport<JPersonBufferClass, JPersonBuffer>) end;

  JContainerClass = interface(JObjectClass)
    ['{13D42C8A-CC12-4879-86A5-D097640A9ACB}']
  end;

  [JavaSignature('com/google/android/gms/tagmanager/Container')]
  JContainer = interface(JObject)
    ['{CD237D96-0AF8-4906-A086-4431D98EAB8B}']
    function getBoolean(key: JString): Boolean; cdecl;
    function getContainerId: JString; cdecl;
    function getDouble(key: JString): Double; cdecl;
    function getLastRefreshTime: Int64; cdecl;
    function getLong(key: JString): Int64; cdecl;
    function getString(key: JString): JString; cdecl;
    function isDefault: Boolean; cdecl;
    procedure registerFunctionCallMacroCallback(customMacroName: JString; customMacroCallback: JContainer_FunctionCallMacroCallback); cdecl;
    procedure registerFunctionCallTagCallback(customTagName: JString; customTagCallback: JContainer_FunctionCallTagCallback); cdecl;
    procedure unregisterFunctionCallMacroCallback(customMacroName: JString); cdecl;
    procedure unregisterFunctionCallTagCallback(customTagName: JString); cdecl;
  end;
  TJContainer = class(TJavaGenericImport<JContainerClass, JContainer>) end;

  JContainer_FunctionCallMacroCallbackClass = interface(IJavaClass)
    ['{485AB590-5BDD-4D8A-9C78-0FEDDF841BE9}']
  end;

  [JavaSignature('com/google/android/gms/tagmanager/Container$FunctionCallMacroCallback')]
  JContainer_FunctionCallMacroCallback = interface(IJavaInstance)
    ['{F4067FF1-6061-4523-B3FB-2D9777A8FA15}']
    function getValue(P1: JString; P2: JMap): JObject; cdecl;
  end;
  TJContainer_FunctionCallMacroCallback = class(TJavaGenericImport<JContainer_FunctionCallMacroCallbackClass, JContainer_FunctionCallMacroCallback>) end;

  JContainer_FunctionCallTagCallbackClass = interface(IJavaClass)
    ['{20439BC6-EE43-46F4-A936-A888E7F926B4}']
  end;

  [JavaSignature('com/google/android/gms/tagmanager/Container$FunctionCallTagCallback')]
  JContainer_FunctionCallTagCallback = interface(IJavaInstance)
    ['{85D4D602-8D35-4B7E-944D-5AD730F45C90}']
    procedure execute(P1: JString; P2: JMap); cdecl;
  end;
  TJContainer_FunctionCallTagCallback = class(TJavaGenericImport<JContainer_FunctionCallTagCallbackClass, JContainer_FunctionCallTagCallback>) end;

  JContainerHolderClass = interface(JReleasableClass)
    ['{335F9D22-4ABC-49B5-8C5A-71C48797785C}']
  end;

  [JavaSignature('com/google/android/gms/tagmanager/ContainerHolder')]
  JContainerHolder = interface(JReleasable)
    ['{02879145-964B-4057-8DE6-275AB693AB2D}']
    function getContainer: JContainer; cdecl;
    procedure refresh; cdecl;
    procedure setContainerAvailableListener(P1: JContainerHolder_ContainerAvailableListener); cdecl;
  end;
  TJContainerHolder = class(TJavaGenericImport<JContainerHolderClass, JContainerHolder>) end;

  JContainerHolder_ContainerAvailableListenerClass = interface(IJavaClass)
    ['{0AD01FA3-2890-4255-87FC-3C8BD2BAC95C}']
  end;

  [JavaSignature('com/google/android/gms/tagmanager/ContainerHolder$ContainerAvailableListener')]
  JContainerHolder_ContainerAvailableListener = interface(IJavaInstance)
    ['{F5BB73DB-4803-48F7-96FA-EF480247B297}']
    procedure onContainerAvailable(P1: JContainerHolder; P2: JString); cdecl;
  end;
  TJContainerHolder_ContainerAvailableListener = class(TJavaGenericImport<JContainerHolder_ContainerAvailableListenerClass, JContainerHolder_ContainerAvailableListener>) end;

  JDataLayerClass = interface(JObjectClass)
    ['{EEF9D7D5-1942-4FF5-ABD7-6A714657E5D5}']
    {class} function _GetEVENT_KEY: JString; cdecl;
    {class} function _GetOBJECT_NOT_PRESENT: JObject; cdecl;
    {class} function listOf(objects: TJavaObjectArray<JObject>): JList; cdecl;
    {class} function mapOf(objects: TJavaObjectArray<JObject>): JMap; cdecl;
    {class} property EVENT_KEY: JString read _GetEVENT_KEY;
    {class} property OBJECT_NOT_PRESENT: JObject read _GetOBJECT_NOT_PRESENT;
  end;

  [JavaSignature('com/google/android/gms/tagmanager/DataLayer')]
  JDataLayer = interface(JObject)
    ['{A4A6A3D2-4262-4BF4-A5B8-998408F6C99A}']
    function &get(key: JString): JObject; cdecl;
    procedure push(update: JMap); cdecl; overload;
    procedure push(key: JString; value: JObject); cdecl; overload;
    procedure pushEvent(eventName: JString; update: JMap); cdecl;
  end;
  TJDataLayer = class(TJavaGenericImport<JDataLayerClass, JDataLayer>) end;

  JInstallReferrerReceiverClass = interface(JBroadcastReceiverClass)
    ['{5587357D-D93E-4F59-A5AC-AFEC11FE6C55}']
    {class} function init: JInstallReferrerReceiver; cdecl;
  end;

  [JavaSignature('com/google/android/gms/tagmanager/InstallReferrerReceiver')]
  JInstallReferrerReceiver = interface(JBroadcastReceiver)
    ['{3D002A39-17ED-4CA2-9559-440DDDCE210B}']
    procedure onReceive(context: JContext; intent: JIntent); cdecl;
  end;
  TJInstallReferrerReceiver = class(TJavaGenericImport<JInstallReferrerReceiverClass, JInstallReferrerReceiver>) end;

  JInstallReferrerServiceClass = interface(JIntentServiceClass)
    ['{3B3C22BC-FC4C-47E0-BC33-7EEB6DEFE319}']
    {class} function init: JInstallReferrerService; cdecl; overload;
    {class} function init(name: JString): JInstallReferrerService; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/tagmanager/InstallReferrerService')]
  JInstallReferrerService = interface(JIntentService)
    ['{A69BD9BA-391B-415B-BFD6-7DB066917D97}']
  end;
  TJInstallReferrerService = class(TJavaGenericImport<JInstallReferrerServiceClass, JInstallReferrerService>) end;

  JPreviewActivityClass = interface(JActivityClass)
    ['{8D0A3E1C-3597-4AD0-8417-2988199FEAEB}']
    {class} function init: JPreviewActivity; cdecl;
  end;

  [JavaSignature('com/google/android/gms/tagmanager/PreviewActivity')]
  JPreviewActivity = interface(JActivity)
    ['{7F3FC8F2-6FBE-47E2-BB05-F85BE168246D}']
    procedure onCreate(savedInstanceState: JBundle); cdecl;
  end;
  TJPreviewActivity = class(TJavaGenericImport<JPreviewActivityClass, JPreviewActivity>) end;

  JTagManagerClass = interface(JObjectClass)
    ['{6C3D6F8E-D79D-426D-9BE4-891CBA998101}']
    {class} function getInstance(context: JContext): JTagManager; cdecl;
  end;

  [JavaSignature('com/google/android/gms/tagmanager/TagManager')]
  JTagManager = interface(JObject)
    ['{A192709D-F3F8-4D98-8039-41E91B79026D}']
    function getDataLayer: JDataLayer; cdecl;
    function loadContainerDefaultOnly(containerId: JString; defaultContainerResourceId: Integer): JPendingResult; cdecl; overload;
    function loadContainerDefaultOnly(containerId: JString; defaultContainerResourceId: Integer; handler: JHandler): JPendingResult; cdecl; overload;
    function loadContainerPreferFresh(containerId: JString; defaultContainerResourceId: Integer): JPendingResult; cdecl; overload;
    function loadContainerPreferFresh(containerId: JString; defaultContainerResourceId: Integer; handler: JHandler): JPendingResult; cdecl; overload;
    function loadContainerPreferNonDefault(containerId: JString; defaultContainerResourceId: Integer): JPendingResult; cdecl; overload;
    function loadContainerPreferNonDefault(containerId: JString; defaultContainerResourceId: Integer; handler: JHandler): JPendingResult; cdecl; overload;
    procedure setVerboseLoggingEnabled(enableVerboseLogging: Boolean); cdecl;
  end;
  TJTagManager = class(TJavaGenericImport<JTagManagerClass, JTagManager>) end;

  Jwallet_AddressClass = interface(JObjectClass)
    ['{39C12781-F4F3-4349-A2D3-A49142481D4D}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/Address')]
  Jwallet_Address = interface(JObject)
    ['{B4F52D95-46DC-4740-B373-5212AD663A61}']
    function describeContents: Integer; cdecl;
    function getAddress1: JString; cdecl;
    function getAddress2: JString; cdecl;
    function getAddress3: JString; cdecl;
    function getCity: JString; cdecl;
    function getCompanyName: JString; cdecl;
    function getCountryCode: JString; cdecl;
    function getName: JString; cdecl;
    function getPhoneNumber: JString; cdecl;
    function getPostalCode: JString; cdecl;
    function getState: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    function isPostBox: Boolean; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJwallet_Address = class(TJavaGenericImport<Jwallet_AddressClass, Jwallet_Address>) end;

  JCartClass = interface(JObjectClass)
    ['{26AAB1B5-B511-4AAA-B0DF-0A0612A41EF7}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function newBuilder: JCart_Builder; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/Cart')]
  JCart = interface(JObject)
    ['{3C3D2A7B-1A86-4DA4-ACBE-5EB51278A239}']
    function describeContents: Integer; cdecl;
    function getCurrencyCode: JString; cdecl;
    function getLineItems: JArrayList; cdecl;
    function getTotalPrice: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJCart = class(TJavaGenericImport<JCartClass, JCart>) end;

  JCart_BuilderClass = interface(JObjectClass)
    ['{1376ACBA-687D-4934-9688-DC123BC32E49}']
  end;

  [JavaSignature('com/google/android/gms/wallet/Cart$Builder')]
  JCart_Builder = interface(JObject)
    ['{A4F94163-6853-49DF-93CB-8A369E1D053E}']
    function addLineItem(lineItem: JLineItem): JCart_Builder; cdecl;
    function build: JCart; cdecl;
    function setCurrencyCode(currencyCode: JString): JCart_Builder; cdecl;
    function setLineItems(lineItems: JList): JCart_Builder; cdecl;
    function setTotalPrice(totalPrice: JString): JCart_Builder; cdecl;
  end;
  TJCart_Builder = class(TJavaGenericImport<JCart_BuilderClass, JCart_Builder>) end;

  Jwallet_CountrySpecificationClass = interface(JObjectClass)
    ['{4997A236-245A-4B17-8899-61486D997BA5}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(countryCode: JString): Jwallet_CountrySpecification; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/CountrySpecification')]
  Jwallet_CountrySpecification = interface(JObject)
    ['{DE1D89EF-8B1A-4AC2-8943-043DCAD14641}']
    function describeContents: Integer; cdecl;
    function getCountryCode: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJwallet_CountrySpecification = class(TJavaGenericImport<Jwallet_CountrySpecificationClass, Jwallet_CountrySpecification>) end;

  JEnableWalletOptimizationReceiverClass = interface(JBroadcastReceiverClass)
    ['{9597C68F-0413-4E15-B626-2DF40B6FF267}']
    {class} function init: JEnableWalletOptimizationReceiver; cdecl;
  end;

  [JavaSignature('com/google/android/gms/wallet/EnableWalletOptimizationReceiver')]
  JEnableWalletOptimizationReceiver = interface(JBroadcastReceiver)
    ['{E74CC918-923A-4333-8FB8-650BE14BAD2E}']
    procedure onReceive(context: JContext; intent: JIntent); cdecl;
  end;
  TJEnableWalletOptimizationReceiver = class(TJavaGenericImport<JEnableWalletOptimizationReceiverClass, JEnableWalletOptimizationReceiver>) end;

  JFullWalletClass = interface(JObjectClass)
    ['{D7E7B05D-5A06-44C9-93FF-1C31E27266B9}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/FullWallet')]
  JFullWallet = interface(JObject)
    ['{E8A45B58-79DA-4038-BCB3-23D9D0801F23}']
    function describeContents: Integer; cdecl;
    function getBillingAddress: Jwallet_Address; cdecl;
    function getBuyerBillingAddress: JUserAddress; cdecl;
    function getBuyerShippingAddress: JUserAddress; cdecl;
    function getEmail: JString; cdecl;
    function getGoogleTransactionId: JString; cdecl;
    function getInstrumentInfos: TJavaObjectArray<JInstrumentInfo>; cdecl;
    function getMerchantTransactionId: JString; cdecl;
    function getPaymentDescriptions: TJavaObjectArray<JString>; cdecl;
    function getProxyCard: JProxyCard; cdecl;
    function getShippingAddress: Jwallet_Address; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJFullWallet = class(TJavaGenericImport<JFullWalletClass, JFullWallet>) end;

  JFullWalletRequestClass = interface(JObjectClass)
    ['{A357FE59-2715-4A82-A348-50FA98BDB1FD}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function newBuilder: JFullWalletRequest_Builder; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/FullWalletRequest')]
  JFullWalletRequest = interface(JObject)
    ['{82DE62CE-5CC6-41C4-A753-2E6E742EB44D}']
    function describeContents: Integer; cdecl;
    function getCart: JCart; cdecl;
    function getGoogleTransactionId: JString; cdecl;
    function getMerchantTransactionId: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJFullWalletRequest = class(TJavaGenericImport<JFullWalletRequestClass, JFullWalletRequest>) end;

  JFullWalletRequest_BuilderClass = interface(JObjectClass)
    ['{E09F8266-2115-4FAD-8B01-396EE097479F}']
  end;

  [JavaSignature('com/google/android/gms/wallet/FullWalletRequest$Builder')]
  JFullWalletRequest_Builder = interface(JObject)
    ['{9CA179E6-EFD1-47D9-B3AC-07310F0C4D78}']
    function build: JFullWalletRequest; cdecl;
    function setCart(cart: JCart): JFullWalletRequest_Builder; cdecl;
    function setGoogleTransactionId(googleTransactionId: JString): JFullWalletRequest_Builder; cdecl;
    function setMerchantTransactionId(merchantTransactionId: JString): JFullWalletRequest_Builder; cdecl;
  end;
  TJFullWalletRequest_Builder = class(TJavaGenericImport<JFullWalletRequest_BuilderClass, JFullWalletRequest_Builder>) end;

  JInstrumentInfoClass = interface(JObjectClass)
    ['{3791B20A-AC75-446B-8572-3A5BFD82911C}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/InstrumentInfo')]
  JInstrumentInfo = interface(JObject)
    ['{8B7F951C-78F8-43B8-A16A-9EE82781FF6B}']
    function describeContents: Integer; cdecl;
    function getInstrumentDetails: JString; cdecl;
    function getInstrumentType: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJInstrumentInfo = class(TJavaGenericImport<JInstrumentInfoClass, JInstrumentInfo>) end;

  JLineItemClass = interface(JObjectClass)
    ['{EE3060C3-96EA-4421-BF1F-2EB1630F8F6F}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function newBuilder: JLineItem_Builder; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/LineItem')]
  JLineItem = interface(JObject)
    ['{6FD105BC-96DA-444E-A4FA-9A66C212EC56}']
    function describeContents: Integer; cdecl;
    function getCurrencyCode: JString; cdecl;
    function getDescription: JString; cdecl;
    function getQuantity: JString; cdecl;
    function getRole: Integer; cdecl;
    function getTotalPrice: JString; cdecl;
    function getUnitPrice: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJLineItem = class(TJavaGenericImport<JLineItemClass, JLineItem>) end;

  JLineItem_BuilderClass = interface(JObjectClass)
    ['{42664D59-4303-413B-BD74-CB1BD5EECABB}']
  end;

  [JavaSignature('com/google/android/gms/wallet/LineItem$Builder')]
  JLineItem_Builder = interface(JObject)
    ['{946ACD0E-DAF5-4D99-9BF8-B6083D016050}']
    function build: JLineItem; cdecl;
    function setCurrencyCode(currencyCode: JString): JLineItem_Builder; cdecl;
    function setDescription(description: JString): JLineItem_Builder; cdecl;
    function setQuantity(quantity: JString): JLineItem_Builder; cdecl;
    function setRole(role: Integer): JLineItem_Builder; cdecl;
    function setTotalPrice(totalPrice: JString): JLineItem_Builder; cdecl;
    function setUnitPrice(unitPrice: JString): JLineItem_Builder; cdecl;
  end;
  TJLineItem_Builder = class(TJavaGenericImport<JLineItem_BuilderClass, JLineItem_Builder>) end;

  JLineItem_RoleClass = interface(IJavaClass)
    ['{6A88CA39-D9DF-421C-BA64-67B2C93C1AE5}']
    {class} function _GetREGULAR: Integer; cdecl;
    {class} function _GetSHIPPING: Integer; cdecl;
    {class} function _GetTAX: Integer; cdecl;
    {class} property REGULAR: Integer read _GetREGULAR;
    {class} property SHIPPING: Integer read _GetSHIPPING;
    {class} property TAX: Integer read _GetTAX;
  end;

  [JavaSignature('com/google/android/gms/wallet/LineItem$Role')]
  JLineItem_Role = interface(IJavaInstance)
    ['{5EEECE7B-F9D9-4E72-87D7-CEABE8A4A17D}']
  end;
  TJLineItem_Role = class(TJavaGenericImport<JLineItem_RoleClass, JLineItem_Role>) end;

  JLoyaltyWalletObjectClass = interface(JObjectClass)
    ['{3C7F4444-DAA6-4653-9B19-FFE34F5E2B0E}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/LoyaltyWalletObject')]
  JLoyaltyWalletObject = interface(JObject)
    ['{4DFDEF7E-4F39-4550-9DAB-18A871A4889C}']
    function describeContents: Integer; cdecl;
    function getAccountId: JString; cdecl;
    function getAccountName: JString; cdecl;
    function getBarcodeAlternateText: JString; cdecl;
    function getBarcodeType: JString; cdecl;
    function getBarcodeValue: JString; cdecl;
    function getId: JString; cdecl;
    function getIssuerName: JString; cdecl;
    function getProgramName: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJLoyaltyWalletObject = class(TJavaGenericImport<JLoyaltyWalletObjectClass, JLoyaltyWalletObject>) end;

  JMaskedWalletClass = interface(JObjectClass)
    ['{4FE56C09-FF5A-4D50-9676-01D64D9A94FD}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/MaskedWallet')]
  JMaskedWallet = interface(JObject)
    ['{DA630E66-38E2-42C0-ADD0-3A8CCDB5958E}']
    function describeContents: Integer; cdecl;
    function getBillingAddress: Jwallet_Address; cdecl;
    function getBuyerBillingAddress: JUserAddress; cdecl;
    function getBuyerShippingAddress: JUserAddress; cdecl;
    function getEmail: JString; cdecl;
    function getGoogleTransactionId: JString; cdecl;
    function getInstrumentInfos: TJavaObjectArray<JInstrumentInfo>; cdecl;
    function getLoyaltyWalletObjects: TJavaObjectArray<JLoyaltyWalletObject>; cdecl;
    function getMerchantTransactionId: JString; cdecl;
    function getOfferWalletObjects: TJavaObjectArray<JOfferWalletObject>; cdecl;
    function getPaymentDescriptions: TJavaObjectArray<JString>; cdecl;
    function getShippingAddress: Jwallet_Address; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJMaskedWallet = class(TJavaGenericImport<JMaskedWalletClass, JMaskedWallet>) end;

  JMaskedWalletRequestClass = interface(JObjectClass)
    ['{C3DF4C6B-EF6D-45BE-94B6-856DEC328C30}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function newBuilder: JMaskedWalletRequest_Builder; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/MaskedWalletRequest')]
  JMaskedWalletRequest = interface(JObject)
    ['{9E280C32-1C2A-48FD-BFD9-4EB5DB0B016B}']
    function allowDebitCard: Boolean; cdecl;
    function allowPrepaidCard: Boolean; cdecl;
    function describeContents: Integer; cdecl;
    function getAllowedCountrySpecificationsForShipping: JArrayList; cdecl;
    function getAllowedShippingCountrySpecifications: TJavaObjectArray<Jwallet_CountrySpecification>; cdecl;
    function getCart: JCart; cdecl;
    function getCurrencyCode: JString; cdecl;
    function getEstimatedTotalPrice: JString; cdecl;
    function getMerchantName: JString; cdecl;
    function getMerchantTransactionId: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    function isBillingAgreement: Boolean; cdecl;
    function isPhoneNumberRequired: Boolean; cdecl;
    function isShippingAddressRequired: Boolean; cdecl;
    function shouldRetrieveWalletObjects: Boolean; cdecl;
    function useMinimalBillingAddress: Boolean; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJMaskedWalletRequest = class(TJavaGenericImport<JMaskedWalletRequestClass, JMaskedWalletRequest>) end;

  JMaskedWalletRequest_BuilderClass = interface(JObjectClass)
    ['{0CB024E2-4CB5-4CBB-9A42-4A64F63C4572}']
  end;

  [JavaSignature('com/google/android/gms/wallet/MaskedWalletRequest$Builder')]
  JMaskedWalletRequest_Builder = interface(JObject)
    ['{E6567874-D318-4191-BAF9-079E8760212D}']
    function addAllowedCountrySpecificationForShipping(countrySpecification: JCountrySpecification): JMaskedWalletRequest_Builder; cdecl;
    function addAllowedCountrySpecificationsForShipping(countrySpecifications: JCollection): JMaskedWalletRequest_Builder; cdecl;
    function build: JMaskedWalletRequest; cdecl;
    function setAllowDebitCard(allowDebitCard: Boolean): JMaskedWalletRequest_Builder; cdecl;
    function setAllowPrepaidCard(allowPrepaidCard: Boolean): JMaskedWalletRequest_Builder; cdecl;
    function setCart(cart: JCart): JMaskedWalletRequest_Builder; cdecl;
    function setCurrencyCode(currencyCode: JString): JMaskedWalletRequest_Builder; cdecl;
    function setEstimatedTotalPrice(estimatedTotalPrice: JString): JMaskedWalletRequest_Builder; cdecl;
    function setIsBillingAgreement(isBillingAgreement: Boolean): JMaskedWalletRequest_Builder; cdecl;
    function setMerchantName(merchantName: JString): JMaskedWalletRequest_Builder; cdecl;
    function setMerchantTransactionId(merchantTransactionId: JString): JMaskedWalletRequest_Builder; cdecl;
    function setPhoneNumberRequired(phoneNumberRequired: Boolean): JMaskedWalletRequest_Builder; cdecl;
    function setShippingAddressRequired(shippingAddressRequired: Boolean): JMaskedWalletRequest_Builder; cdecl;
    function setShouldRetrieveWalletObjects(shouldRetrieveWalletObjects: Boolean): JMaskedWalletRequest_Builder; cdecl;
    function setUseMinimalBillingAddress(useMinimalBillingAddress: Boolean): JMaskedWalletRequest_Builder; cdecl;
  end;
  TJMaskedWalletRequest_Builder = class(TJavaGenericImport<JMaskedWalletRequest_BuilderClass, JMaskedWalletRequest_Builder>) end;

  JNotifyTransactionStatusRequestClass = interface(JObjectClass)
    ['{4836ECDC-66DD-4350-AFD5-077764AD6EB6}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function newBuilder: JNotifyTransactionStatusRequest_Builder; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/NotifyTransactionStatusRequest')]
  JNotifyTransactionStatusRequest = interface(JObject)
    ['{7FAB9A55-328E-4C86-940A-23FEBAAF6C3F}']
    function describeContents: Integer; cdecl;
    function getDetailedReason: JString; cdecl;
    function getGoogleTransactionId: JString; cdecl;
    function getStatus: Integer; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJNotifyTransactionStatusRequest = class(TJavaGenericImport<JNotifyTransactionStatusRequestClass, JNotifyTransactionStatusRequest>) end;

  JNotifyTransactionStatusRequest_BuilderClass = interface(JObjectClass)
    ['{45A9D9CC-4C12-461D-ABCD-31C5EA4EE960}']
  end;

  [JavaSignature('com/google/android/gms/wallet/NotifyTransactionStatusRequest$Builder')]
  JNotifyTransactionStatusRequest_Builder = interface(JObject)
    ['{CBFADF37-0283-4657-9873-725A5E30984D}']
    function build: JNotifyTransactionStatusRequest; cdecl;
    function setDetailedReason(detailedReason: JString): JNotifyTransactionStatusRequest_Builder; cdecl;
    function setGoogleTransactionId(googleTransactionId: JString): JNotifyTransactionStatusRequest_Builder; cdecl;
    function setStatus(status: Integer): JNotifyTransactionStatusRequest_Builder; cdecl;
  end;
  TJNotifyTransactionStatusRequest_Builder = class(TJavaGenericImport<JNotifyTransactionStatusRequest_BuilderClass, JNotifyTransactionStatusRequest_Builder>) end;

  JNotifyTransactionStatusRequest_StatusClass = interface(IJavaClass)
    ['{3CE3433B-3BD2-4DDC-AA92-EF0E2DBB7892}']
    {class} function _GetSUCCESS: Integer; cdecl;
    {class} property SUCCESS: Integer read _GetSUCCESS;
  end;

  [JavaSignature('com/google/android/gms/wallet/NotifyTransactionStatusRequest$Status')]
  JNotifyTransactionStatusRequest_Status = interface(IJavaInstance)
    ['{4923FE24-E229-4A2C-AD97-B9233635FF8C}']
  end;
  TJNotifyTransactionStatusRequest_Status = class(TJavaGenericImport<JNotifyTransactionStatusRequest_StatusClass, JNotifyTransactionStatusRequest_Status>) end;

  JStatus_ErrorClass = interface(IJavaClass)
    ['{66265EE6-C7C3-405B-A515-3C76B2EA7C12}']
    {class} function _GetAVS_DECLINE: Integer; cdecl;
    {class} function _GetBAD_CARD: Integer; cdecl;
    {class} function _GetBAD_CVC: Integer; cdecl;
    {class} function _GetDECLINED: Integer; cdecl;
    {class} function _GetFRAUD_DECLINE: Integer; cdecl;
    {class} function _GetOTHER: Integer; cdecl;
    {class} function _GetUNKNOWN: Integer; cdecl;
    {class} property AVS_DECLINE: Integer read _GetAVS_DECLINE;
    {class} property BAD_CARD: Integer read _GetBAD_CARD;
    {class} property BAD_CVC: Integer read _GetBAD_CVC;
    {class} property DECLINED: Integer read _GetDECLINED;
    {class} property FRAUD_DECLINE: Integer read _GetFRAUD_DECLINE;
    {class} property OTHER: Integer read _GetOTHER;
    {class} property UNKNOWN: Integer read _GetUNKNOWN;
  end;

  [JavaSignature('com/google/android/gms/wallet/NotifyTransactionStatusRequest$Status$Error')]
  JStatus_Error = interface(IJavaInstance)
    ['{56B47111-CA28-49D0-9DD8-0D0947076CAE}']
  end;
  TJStatus_Error = class(TJavaGenericImport<JStatus_ErrorClass, JStatus_Error>) end;

  JOfferWalletObjectClass = interface(JObjectClass)
    ['{F0BB4A58-DC78-4BED-9AA5-C48D4A95772A}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/OfferWalletObject')]
  JOfferWalletObject = interface(JObject)
    ['{9F21BF81-A8B3-4F34-B83E-2C13916A9DCB}']
    function describeContents: Integer; cdecl;
    function getId: JString; cdecl;
    function getRedemptionCode: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJOfferWalletObject = class(TJavaGenericImport<JOfferWalletObjectClass, JOfferWalletObject>) end;

  JProxyCardClass = interface(JObjectClass)
    ['{BA83B757-C4FC-41DB-B648-5E20A9085ABA}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('com/google/android/gms/wallet/ProxyCard')]
  JProxyCard = interface(JObject)
    ['{5028EF53-E2FE-4F59-950A-DB373434285F}']
    function describeContents: Integer; cdecl;
    function getCvn: JString; cdecl;
    function getExpirationMonth: Integer; cdecl;
    function getExpirationYear: Integer; cdecl;
    function getPan: JString; cdecl;
    function getVersionCode: Integer; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJProxyCard = class(TJavaGenericImport<JProxyCardClass, JProxyCard>) end;

  JWalletClass = interface(JObjectClass)
    ['{7575E6CB-2C74-41C5-87F1-DD647C08968B}']
    {class} //function _GetAPI: JApi; cdecl;
    {class} procedure changeMaskedWallet(googleApiClient: JGoogleApiClient; googleTransactionId: JString; merchantTransactionId: JString; requestCode: Integer); cdecl;
    {class} procedure checkForPreAuthorization(googleApiClient: JGoogleApiClient; requestCode: Integer); cdecl;
    {class} procedure loadFullWallet(googleApiClient: JGoogleApiClient; request: JFullWalletRequest; requestCode: Integer); cdecl;
    {class} procedure loadMaskedWallet(googleApiClient: JGoogleApiClient; request: JMaskedWalletRequest; requestCode: Integer); cdecl;
    {class} procedure notifyTransactionStatus(googleApiClient: JGoogleApiClient; request: JNotifyTransactionStatusRequest); cdecl;
    {class} //property API: JApi read _GetAPI;
  end;

  [JavaSignature('com/google/android/gms/wallet/Wallet')]
  JWallet = interface(JObject)
    ['{31E9E303-DA39-4C47-8AC1-FC0EC22F029A}']
  end;
  TJWallet = class(TJavaGenericImport<JWalletClass, JWallet>) end;

  JWallet_WalletOptionsClass = interface(JObjectClass)
    ['{7B45115E-23E1-4566-A12C-787B10672B14}']
  end;

  [JavaSignature('com/google/android/gms/wallet/Wallet$WalletOptions')]
  JWallet_WalletOptions = interface(JObject)
    ['{08BE6E71-06F7-464A-9C44-F5D59A5E821B}']
    function _Getenvironment: Integer; cdecl;
    function _Gettheme: Integer; cdecl;
    property environment: Integer read _Getenvironment;
    property theme: Integer read _Gettheme;
  end;
  TJWallet_WalletOptions = class(TJavaGenericImport<JWallet_WalletOptionsClass, JWallet_WalletOptions>) end;

  JWalletOptions_BuilderClass = interface(JObjectClass)
    ['{2D7F47EC-DF04-49AE-8744-CFFFDA9EE280}']
    {class} function init: JWalletOptions_Builder; cdecl;
  end;

  [JavaSignature('com/google/android/gms/wallet/Wallet$WalletOptions$Builder')]
  JWalletOptions_Builder = interface(JObject)
    ['{AAC458C7-384E-4216-8311-100622FC1903}']
    function build: JWallet_WalletOptions; cdecl;
    function setEnvironment(environment: Integer): JWalletOptions_Builder; cdecl;
    function setTheme(theme: Integer): JWalletOptions_Builder; cdecl;
  end;
  TJWalletOptions_Builder = class(TJavaGenericImport<JWalletOptions_BuilderClass, JWalletOptions_Builder>) end;

  JWalletClientClass = interface(JObjectClass)
    ['{F9EF54F5-1893-4D5A-A831-4F29751E0F39}']
    {class} function init(activity: JActivity; environment: Integer; accountName: JString; connectionCallbacks: JGooglePlayServicesClient_ConnectionCallbacks; connectionFailedListener: JGooglePlayServicesClient_OnConnectionFailedListener): JWalletClient; cdecl; overload;
    {class} function init(activity: JActivity; environment: Integer; accountName: JString; theme: Integer; connectionCallbacks: JGooglePlayServicesClient_ConnectionCallbacks; connectionFailedListener: JGooglePlayServicesClient_OnConnectionFailedListener): JWalletClient; cdecl; overload;
  end;

  [JavaSignature('com/google/android/gms/wallet/WalletClient')]
  JWalletClient = interface(JObject)
    ['{3B50C6A1-9FD5-4FE1-BAAB-1519EA350155}']
    procedure changeMaskedWallet(googleTransactionId: JString; merchantTransactionId: JString; requestCode: Integer); cdecl;
    procedure checkForPreAuthorization(requestCode: Integer); cdecl;
    procedure connect; cdecl;
    procedure disconnect; cdecl;
    function isConnected: Boolean; cdecl;
    function isConnecting: Boolean; cdecl;
    function isConnectionCallbacksRegistered(listener: JGooglePlayServicesClient_ConnectionCallbacks): Boolean; cdecl;
    function isConnectionFailedListenerRegistered(listener: JGooglePlayServicesClient_OnConnectionFailedListener): Boolean; cdecl;
    procedure loadFullWallet(request: JFullWalletRequest; requestCode: Integer); cdecl;
    procedure loadMaskedWallet(request: JMaskedWalletRequest; requestCode: Integer); cdecl;
    procedure notifyTransactionStatus(request: JNotifyTransactionStatusRequest); cdecl;
    procedure registerConnectionCallbacks(listener: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure registerConnectionFailedListener(listener: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
    procedure unregisterConnectionCallbacks(listener: JGooglePlayServicesClient_ConnectionCallbacks); cdecl;
    procedure unregisterConnectionFailedListener(listener: JGooglePlayServicesClient_OnConnectionFailedListener); cdecl;
  end;
  TJWalletClient = class(TJavaGenericImport<JWalletClientClass, JWalletClient>) end;

  JWalletConstantsClass = interface(JObjectClass)
    ['{01A525AF-D011-466F-A6E4-FEE7DF74ABA9}']
    {class} function _GetACTION_ENABLE_WALLET_OPTIMIZATION: JString; cdecl;
    {class} function _GetENVIRONMENT_PRODUCTION: Integer; cdecl;
    {class} function _GetENVIRONMENT_SANDBOX: Integer; cdecl;
    {class} function _GetENVIRONMENT_STRICT_SANDBOX: Integer; cdecl;
    {class} function _GetERROR_CODE_AUTHENTICATION_FAILURE: Integer; cdecl;
    {class} function _GetERROR_CODE_BUYER_ACCOUNT_ERROR: Integer; cdecl;
    {class} function _GetERROR_CODE_INVALID_PARAMETERS: Integer; cdecl;
    {class} function _GetERROR_CODE_INVALID_TRANSACTION: Integer; cdecl;
    {class} function _GetERROR_CODE_MERCHANT_ACCOUNT_ERROR: Integer; cdecl;
    {class} function _GetERROR_CODE_SERVICE_UNAVAILABLE: Integer; cdecl;
    {class} function _GetERROR_CODE_SPENDING_LIMIT_EXCEEDED: Integer; cdecl;
    {class} function _GetERROR_CODE_UNKNOWN: Integer; cdecl;
    {class} function _GetERROR_CODE_UNSUPPORTED_API_VERSION: Integer; cdecl;
    {class} function _GetEXTRA_ERROR_CODE: JString; cdecl;
    {class} function _GetEXTRA_FULL_WALLET: JString; cdecl;
    {class} function _GetEXTRA_IS_USER_PREAUTHORIZED: JString; cdecl;
    {class} function _GetEXTRA_MASKED_WALLET: JString; cdecl;
    {class} function _GetRESULT_ERROR: Integer; cdecl;
    {class} function _GetTHEME_HOLO_DARK: Integer; cdecl;
    {class} function _GetTHEME_HOLO_LIGHT: Integer; cdecl;
    {class} //function _GetZy: JAccount; cdecl;
    {class} property ACTION_ENABLE_WALLET_OPTIMIZATION: JString read _GetACTION_ENABLE_WALLET_OPTIMIZATION;
    {class} property ENVIRONMENT_PRODUCTION: Integer read _GetENVIRONMENT_PRODUCTION;
    {class} property ENVIRONMENT_SANDBOX: Integer read _GetENVIRONMENT_SANDBOX;
    {class} property ENVIRONMENT_STRICT_SANDBOX: Integer read _GetENVIRONMENT_STRICT_SANDBOX;
    {class} property ERROR_CODE_AUTHENTICATION_FAILURE: Integer read _GetERROR_CODE_AUTHENTICATION_FAILURE;
    {class} property ERROR_CODE_BUYER_ACCOUNT_ERROR: Integer read _GetERROR_CODE_BUYER_ACCOUNT_ERROR;
    {class} property ERROR_CODE_INVALID_PARAMETERS: Integer read _GetERROR_CODE_INVALID_PARAMETERS;
    {class} property ERROR_CODE_INVALID_TRANSACTION: Integer read _GetERROR_CODE_INVALID_TRANSACTION;
    {class} property ERROR_CODE_MERCHANT_ACCOUNT_ERROR: Integer read _GetERROR_CODE_MERCHANT_ACCOUNT_ERROR;
    {class} property ERROR_CODE_SERVICE_UNAVAILABLE: Integer read _GetERROR_CODE_SERVICE_UNAVAILABLE;
    {class} property ERROR_CODE_SPENDING_LIMIT_EXCEEDED: Integer read _GetERROR_CODE_SPENDING_LIMIT_EXCEEDED;
    {class} property ERROR_CODE_UNKNOWN: Integer read _GetERROR_CODE_UNKNOWN;
    {class} property ERROR_CODE_UNSUPPORTED_API_VERSION: Integer read _GetERROR_CODE_UNSUPPORTED_API_VERSION;
    {class} property EXTRA_ERROR_CODE: JString read _GetEXTRA_ERROR_CODE;
    {class} property EXTRA_FULL_WALLET: JString read _GetEXTRA_FULL_WALLET;
    {class} property EXTRA_IS_USER_PREAUTHORIZED: JString read _GetEXTRA_IS_USER_PREAUTHORIZED;
    {class} property EXTRA_MASKED_WALLET: JString read _GetEXTRA_MASKED_WALLET;
    {class} property RESULT_ERROR: Integer read _GetRESULT_ERROR;
    {class} property THEME_HOLO_DARK: Integer read _GetTHEME_HOLO_DARK;
    {class} property THEME_HOLO_LIGHT: Integer read _GetTHEME_HOLO_LIGHT;
    {class} //property Zy: JAccount read _GetZy;
  end;

  [JavaSignature('com/google/android/gms/wallet/WalletConstants')]
  JWalletConstants = interface(JObject)
    ['{13B4F268-3BBC-47D7-9F9B-753692FCE265}']
  end;
  TJWalletConstants = class(TJavaGenericImport<JWalletConstantsClass, JWalletConstants>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Janalytics_CampaignTrackingReceiver', TypeInfo(Androidapi.JNI.PlayServices.Janalytics_CampaignTrackingReceiver));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Janalytics_CampaignTrackingService', TypeInfo(Androidapi.JNI.PlayServices.Janalytics_CampaignTrackingService));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Janalytics_ExceptionParser', TypeInfo(Androidapi.JNI.PlayServices.Janalytics_ExceptionParser));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Janalytics_ExceptionReporter', TypeInfo(Androidapi.JNI.PlayServices.Janalytics_ExceptionReporter));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTrackerHandler', TypeInfo(Androidapi.JNI.PlayServices.JTrackerHandler));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Janalytics_GoogleAnalytics', TypeInfo(Androidapi.JNI.PlayServices.Janalytics_GoogleAnalytics));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JHitBuilders', TypeInfo(Androidapi.JNI.PlayServices.JHitBuilders));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JHitBuilders_HitBuilder', TypeInfo(Androidapi.JNI.PlayServices.JHitBuilders_HitBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JHitBuilders_AppViewBuilder', TypeInfo(Androidapi.JNI.PlayServices.JHitBuilders_AppViewBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JHitBuilders_EventBuilder', TypeInfo(Androidapi.JNI.PlayServices.JHitBuilders_EventBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JHitBuilders_ExceptionBuilder', TypeInfo(Androidapi.JNI.PlayServices.JHitBuilders_ExceptionBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JHitBuilders_ItemBuilder', TypeInfo(Androidapi.JNI.PlayServices.JHitBuilders_ItemBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JHitBuilders_SocialBuilder', TypeInfo(Androidapi.JNI.PlayServices.JHitBuilders_SocialBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JHitBuilders_TimingBuilder', TypeInfo(Androidapi.JNI.PlayServices.JHitBuilders_TimingBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JHitBuilders_TransactionBuilder', TypeInfo(Androidapi.JNI.PlayServices.JHitBuilders_TransactionBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Janalytics_Logger', TypeInfo(Androidapi.JNI.PlayServices.Janalytics_Logger));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLogger_LogLevel', TypeInfo(Androidapi.JNI.PlayServices.JLogger_LogLevel));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Janalytics_StandardExceptionParser', TypeInfo(Androidapi.JNI.PlayServices.Janalytics_StandardExceptionParser));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Janalytics_Tracker', TypeInfo(Androidapi.JNI.PlayServices.Janalytics_Tracker));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JFreezable', TypeInfo(Androidapi.JNI.PlayServices.JFreezable));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAppState', TypeInfo(Androidapi.JNI.PlayServices.JAppState));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDataBuffer', TypeInfo(Androidapi.JNI.PlayServices.JDataBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAppStateBuffer', TypeInfo(Androidapi.JNI.PlayServices.JAppStateBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAppStateManager', TypeInfo(Androidapi.JNI.PlayServices.JAppStateManager));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JReleasable', TypeInfo(Androidapi.JNI.PlayServices.JReleasable));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAppStateManager_StateConflictResult', TypeInfo(Androidapi.JNI.PlayServices.JAppStateManager_StateConflictResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Japi_Result', TypeInfo(Androidapi.JNI.PlayServices.Japi_Result));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAppStateManager_StateDeletedResult', TypeInfo(Androidapi.JNI.PlayServices.JAppStateManager_StateDeletedResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAppStateManager_StateListResult', TypeInfo(Androidapi.JNI.PlayServices.JAppStateManager_StateListResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAppStateManager_StateLoadedResult', TypeInfo(Androidapi.JNI.PlayServices.JAppStateManager_StateLoadedResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAppStateManager_StateResult', TypeInfo(Androidapi.JNI.PlayServices.JAppStateManager_StateResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAppStateStatusCodes', TypeInfo(Androidapi.JNI.PlayServices.JAppStateStatusCodes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleAuthException', TypeInfo(Androidapi.JNI.PlayServices.JGoogleAuthException));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleAuthUtil', TypeInfo(Androidapi.JNI.PlayServices.JGoogleAuthUtil));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JUserRecoverableAuthException', TypeInfo(Androidapi.JNI.PlayServices.JUserRecoverableAuthException));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGooglePlayServicesAvailabilityException', TypeInfo(Androidapi.JNI.PlayServices.JGooglePlayServicesAvailabilityException));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JUserRecoverableNotifiedException', TypeInfo(Androidapi.JNI.PlayServices.JUserRecoverableNotifiedException));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JApplicationMetadata', TypeInfo(Androidapi.JNI.PlayServices.JApplicationMetadata));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCast', TypeInfo(Androidapi.JNI.PlayServices.JCast));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCast_ApplicationConnectionResult', TypeInfo(Androidapi.JNI.PlayServices.JCast_ApplicationConnectionResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCast_CastApi', TypeInfo(Androidapi.JNI.PlayServices.JCast_CastApi));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCast_CastOptions', TypeInfo(Androidapi.JNI.PlayServices.JCast_CastOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCastOptions_Builder', TypeInfo(Androidapi.JNI.PlayServices.JCastOptions_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCast_Listener', TypeInfo(Androidapi.JNI.PlayServices.JCast_Listener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCast_MessageReceivedCallback', TypeInfo(Androidapi.JNI.PlayServices.JCast_MessageReceivedCallback));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCastDevice', TypeInfo(Androidapi.JNI.PlayServices.JCastDevice));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCastMediaControlIntent', TypeInfo(Androidapi.JNI.PlayServices.JCastMediaControlIntent));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCastStatusCodes', TypeInfo(Androidapi.JNI.PlayServices.JCastStatusCodes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMediaInfo', TypeInfo(Androidapi.JNI.PlayServices.JMediaInfo));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMediaInfo_Builder', TypeInfo(Androidapi.JNI.PlayServices.JMediaInfo_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMediaMetadata', TypeInfo(Androidapi.JNI.PlayServices.JMediaMetadata));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMediaMetadata_a', TypeInfo(Androidapi.JNI.PlayServices.JMediaMetadata_a));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMediaStatus', TypeInfo(Androidapi.JNI.PlayServices.JMediaStatus));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRemoteMediaPlayer', TypeInfo(Androidapi.JNI.PlayServices.JRemoteMediaPlayer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRemoteMediaPlayer_MediaChannelResult', TypeInfo(Androidapi.JNI.PlayServices.JRemoteMediaPlayer_MediaChannelResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRemoteMediaPlayer_OnMetadataUpdatedListener', TypeInfo(Androidapi.JNI.PlayServices.JRemoteMediaPlayer_OnMetadataUpdatedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRemoteMediaPlayer_OnStatusUpdatedListener', TypeInfo(Androidapi.JNI.PlayServices.JRemoteMediaPlayer_OnStatusUpdatedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAccountPicker', TypeInfo(Androidapi.JNI.PlayServices.JAccountPicker));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JConnectionResult', TypeInfo(Androidapi.JNI.PlayServices.JConnectionResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JErrorDialogFragment', TypeInfo(Androidapi.JNI.PlayServices.JErrorDialogFragment));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGooglePlayServicesClient', TypeInfo(Androidapi.JNI.PlayServices.JGooglePlayServicesClient));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGooglePlayServicesClient_ConnectionCallbacks', TypeInfo(Androidapi.JNI.PlayServices.JGooglePlayServicesClient_ConnectionCallbacks));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGooglePlayServicesClient_OnConnectionFailedListener', TypeInfo(Androidapi.JNI.PlayServices.JGooglePlayServicesClient_OnConnectionFailedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGooglePlayServicesNotAvailableException', TypeInfo(Androidapi.JNI.PlayServices.JGooglePlayServicesNotAvailableException));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JUserRecoverableException', TypeInfo(Androidapi.JNI.PlayServices.JUserRecoverableException));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGooglePlayServicesRepairableException', TypeInfo(Androidapi.JNI.PlayServices.JGooglePlayServicesRepairableException));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGooglePlayServicesUtil', TypeInfo(Androidapi.JNI.PlayServices.JGooglePlayServicesUtil));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JScopes', TypeInfo(Androidapi.JNI.PlayServices.JScopes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JSignInButton', TypeInfo(Androidapi.JNI.PlayServices.JSignInButton));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JKeepName', TypeInfo(Androidapi.JNI.PlayServices.JKeepName));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCommonStatusCodes', TypeInfo(Androidapi.JNI.PlayServices.JCommonStatusCodes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleApiClient', TypeInfo(Androidapi.JNI.PlayServices.JGoogleApiClient));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleApiClient_ApiOptions', TypeInfo(Androidapi.JNI.PlayServices.JGoogleApiClient_ApiOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleApiClient_Builder', TypeInfo(Androidapi.JNI.PlayServices.JGoogleApiClient_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleApiClient_ConnectionCallbacks', TypeInfo(Androidapi.JNI.PlayServices.JGoogleApiClient_ConnectionCallbacks));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleApiClient_OnConnectionFailedListener', TypeInfo(Androidapi.JNI.PlayServices.JGoogleApiClient_OnConnectionFailedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPendingResult', TypeInfo(Androidapi.JNI.PlayServices.JPendingResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JResultCallback', TypeInfo(Androidapi.JNI.PlayServices.JResultCallback));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JScope', TypeInfo(Androidapi.JNI.PlayServices.JScope));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JStatus', TypeInfo(Androidapi.JNI.PlayServices.JStatus));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JStatusCreator', TypeInfo(Androidapi.JNI.PlayServices.JStatusCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDataBufferUtils', TypeInfo(Androidapi.JNI.PlayServices.JDataBufferUtils));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDataHolder', TypeInfo(Androidapi.JNI.PlayServices.JDataHolder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDataHolder_Builder', TypeInfo(Androidapi.JNI.PlayServices.JDataHolder_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDataHolderCreator', TypeInfo(Androidapi.JNI.PlayServices.JDataHolderCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JFilteredDataBuffer', TypeInfo(Androidapi.JNI.PlayServices.JFilteredDataBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JFreezableUtils', TypeInfo(Androidapi.JNI.PlayServices.JFreezableUtils));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JImageManager', TypeInfo(Androidapi.JNI.PlayServices.JImageManager));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JImageManager_ImageReceiver', TypeInfo(Androidapi.JNI.PlayServices.JImageManager_ImageReceiver));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JImageManager_OnImageLoadedListener', TypeInfo(Androidapi.JNI.PlayServices.JImageManager_OnImageLoadedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JWebImage', TypeInfo(Androidapi.JNI.PlayServices.JWebImage));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JSafeParcelable', TypeInfo(Androidapi.JNI.PlayServices.JSafeParcelable));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JContents', TypeInfo(Androidapi.JNI.PlayServices.JContents));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCreateFileActivityBuilder', TypeInfo(Androidapi.JNI.PlayServices.JCreateFileActivityBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDrive', TypeInfo(Androidapi.JNI.PlayServices.JDrive));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveApi', TypeInfo(Androidapi.JNI.PlayServices.JDriveApi));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveApi_ContentsResult', TypeInfo(Androidapi.JNI.PlayServices.JDriveApi_ContentsResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveApi_DriveIdResult', TypeInfo(Androidapi.JNI.PlayServices.JDriveApi_DriveIdResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveApi_IntentSenderResult', TypeInfo(Androidapi.JNI.PlayServices.JDriveApi_IntentSenderResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveApi_MetadataBufferResult', TypeInfo(Androidapi.JNI.PlayServices.JDriveApi_MetadataBufferResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveApi_OnSyncFinishCallback', TypeInfo(Androidapi.JNI.PlayServices.JDriveApi_OnSyncFinishCallback));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveResource', TypeInfo(Androidapi.JNI.PlayServices.JDriveResource));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveFile', TypeInfo(Androidapi.JNI.PlayServices.JDriveFile));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveFile_DownloadProgressListener', TypeInfo(Androidapi.JNI.PlayServices.JDriveFile_DownloadProgressListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveFolder', TypeInfo(Androidapi.JNI.PlayServices.JDriveFolder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveFolder_DriveFileResult', TypeInfo(Androidapi.JNI.PlayServices.JDriveFolder_DriveFileResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveFolder_DriveFolderResult', TypeInfo(Androidapi.JNI.PlayServices.JDriveFolder_DriveFolderResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveId', TypeInfo(Androidapi.JNI.PlayServices.JDriveId));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveResource_MetadataResult', TypeInfo(Androidapi.JNI.PlayServices.JDriveResource_MetadataResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveStatusCodes', TypeInfo(Androidapi.JNI.PlayServices.JDriveStatusCodes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMetadata', TypeInfo(Androidapi.JNI.PlayServices.JMetadata));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMetadataBuffer', TypeInfo(Androidapi.JNI.PlayServices.JMetadataBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMetadataChangeSet', TypeInfo(Androidapi.JNI.PlayServices.JMetadataChangeSet));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMetadataChangeSet_Builder', TypeInfo(Androidapi.JNI.PlayServices.JMetadataChangeSet_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOpenFileActivityBuilder', TypeInfo(Androidapi.JNI.PlayServices.JOpenFileActivityBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JChangeEvent', TypeInfo(Androidapi.JNI.PlayServices.JChangeEvent));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JConflictEvent', TypeInfo(Androidapi.JNI.PlayServices.JConflictEvent));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveEvent', TypeInfo(Androidapi.JNI.PlayServices.JDriveEvent));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDriveEvent_Listener', TypeInfo(Androidapi.JNI.PlayServices.JDriveEvent_Listener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JResourceEvent', TypeInfo(Androidapi.JNI.PlayServices.JResourceEvent));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAuthorizeAccessRequest', TypeInfo(Androidapi.JNI.PlayServices.JAuthorizeAccessRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCloseContentsAndUpdateMetadataRequest', TypeInfo(Androidapi.JNI.PlayServices.JCloseContentsAndUpdateMetadataRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCloseContentsRequest', TypeInfo(Androidapi.JNI.PlayServices.JCloseContentsRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCreateContentsRequest', TypeInfo(Androidapi.JNI.PlayServices.JCreateContentsRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCreateFileIntentSenderRequest', TypeInfo(Androidapi.JNI.PlayServices.JCreateFileIntentSenderRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCreateFileRequest', TypeInfo(Androidapi.JNI.PlayServices.JCreateFileRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCreateFolderRequest', TypeInfo(Androidapi.JNI.PlayServices.JCreateFolderRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDisconnectRequest', TypeInfo(Androidapi.JNI.PlayServices.JDisconnectRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGetMetadataRequest', TypeInfo(Androidapi.JNI.PlayServices.JGetMetadataRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JListParentsRequest', TypeInfo(Androidapi.JNI.PlayServices.JListParentsRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOnContentsResponse', TypeInfo(Androidapi.JNI.PlayServices.JOnContentsResponse));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOnDownloadProgressResponse', TypeInfo(Androidapi.JNI.PlayServices.JOnDownloadProgressResponse));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOnDriveIdResponse', TypeInfo(Androidapi.JNI.PlayServices.JOnDriveIdResponse));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOnEventResponse', TypeInfo(Androidapi.JNI.PlayServices.JOnEventResponse));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOnListEntriesResponse', TypeInfo(Androidapi.JNI.PlayServices.JOnListEntriesResponse));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOnListParentsResponse', TypeInfo(Androidapi.JNI.PlayServices.JOnListParentsResponse));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOnMetadataResponse', TypeInfo(Androidapi.JNI.PlayServices.JOnMetadataResponse));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOpenContentsRequest', TypeInfo(Androidapi.JNI.PlayServices.JOpenContentsRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOpenFileIntentSenderRequest', TypeInfo(Androidapi.JNI.PlayServices.JOpenFileIntentSenderRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JQueryRequest', TypeInfo(Androidapi.JNI.PlayServices.JQueryRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRemoveEventListenerRequest', TypeInfo(Androidapi.JNI.PlayServices.JRemoveEventListenerRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTrashResourceRequest', TypeInfo(Androidapi.JNI.PlayServices.JTrashResourceRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JUpdateMetadataRequest', TypeInfo(Androidapi.JNI.PlayServices.JUpdateMetadataRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMetadataField', TypeInfo(Androidapi.JNI.PlayServices.JMetadataField));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCollectionMetadataField', TypeInfo(Androidapi.JNI.PlayServices.JCollectionMetadataField));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOrderedMetadataField', TypeInfo(Androidapi.JNI.PlayServices.JOrderedMetadataField));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMetadataBundle', TypeInfo(Androidapi.JNI.PlayServices.JMetadataBundle));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Jquery_Filter', TypeInfo(Androidapi.JNI.PlayServices.Jquery_Filter));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JFilters', TypeInfo(Androidapi.JNI.PlayServices.JFilters));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JQuery', TypeInfo(Androidapi.JNI.PlayServices.JQuery));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JQuery_Builder', TypeInfo(Androidapi.JNI.PlayServices.JQuery_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JSearchableField', TypeInfo(Androidapi.JNI.PlayServices.JSearchableField));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JComparisonFilter', TypeInfo(Androidapi.JNI.PlayServices.JComparisonFilter));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JFieldOnlyFilter', TypeInfo(Androidapi.JNI.PlayServices.JFieldOnlyFilter));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JFilterHolder', TypeInfo(Androidapi.JNI.PlayServices.JFilterHolder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JInFilter', TypeInfo(Androidapi.JNI.PlayServices.JInFilter));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLogicalFilter', TypeInfo(Androidapi.JNI.PlayServices.JLogicalFilter));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JNotFilter', TypeInfo(Androidapi.JNI.PlayServices.JNotFilter));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOperator', TypeInfo(Androidapi.JNI.PlayServices.JOperator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDataBufferAdapter', TypeInfo(Androidapi.JNI.PlayServices.JDataBufferAdapter));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLifecycleDelegate', TypeInfo(Androidapi.JNI.PlayServices.JLifecycleDelegate));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGame', TypeInfo(Androidapi.JNI.PlayServices.JGame));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGameBuffer', TypeInfo(Androidapi.JNI.PlayServices.JGameBuffer));
  //TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGameEntity', TypeInfo(Androidapi.JNI.PlayServices.JGameEntity));
  //TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGameEntity_a', TypeInfo(Androidapi.JNI.PlayServices.JGameEntity_a));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGames', TypeInfo(Androidapi.JNI.PlayServices.JGames));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGames_GamesOptions', TypeInfo(Androidapi.JNI.PlayServices.JGames_GamesOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGamesOptions_Builder', TypeInfo(Androidapi.JNI.PlayServices.JGamesOptions_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGamesActivityResultCodes', TypeInfo(Androidapi.JNI.PlayServices.JGamesActivityResultCodes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGamesMetadata', TypeInfo(Androidapi.JNI.PlayServices.JGamesMetadata));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGamesMetadata_LoadGamesResult', TypeInfo(Androidapi.JNI.PlayServices.JGamesMetadata_LoadGamesResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGamesStatusCodes', TypeInfo(Androidapi.JNI.PlayServices.JGamesStatusCodes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JNotifications', TypeInfo(Androidapi.JNI.PlayServices.JNotifications));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPageDirection', TypeInfo(Androidapi.JNI.PlayServices.JPageDirection));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlayer', TypeInfo(Androidapi.JNI.PlayServices.JPlayer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlayerBuffer', TypeInfo(Androidapi.JNI.PlayServices.JPlayerBuffer));
  //TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlayerEntity', TypeInfo(Androidapi.JNI.PlayServices.JPlayerEntity));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlayers', TypeInfo(Androidapi.JNI.PlayServices.JPlayers));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlayers_LoadPlayersResult', TypeInfo(Androidapi.JNI.PlayServices.JPlayers_LoadPlayersResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAchievement', TypeInfo(Androidapi.JNI.PlayServices.JAchievement));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAchievementBuffer', TypeInfo(Androidapi.JNI.PlayServices.JAchievementBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAchievements', TypeInfo(Androidapi.JNI.PlayServices.JAchievements));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAchievements_LoadAchievementsResult', TypeInfo(Androidapi.JNI.PlayServices.JAchievements_LoadAchievementsResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAchievements_UpdateAchievementResult', TypeInfo(Androidapi.JNI.PlayServices.JAchievements_UpdateAchievementResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLeaderboard', TypeInfo(Androidapi.JNI.PlayServices.JLeaderboard));
  //TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLeaderboardBuffer', TypeInfo(Androidapi.JNI.PlayServices.JLeaderboardBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLeaderboardScore', TypeInfo(Androidapi.JNI.PlayServices.JLeaderboardScore));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLeaderboardScoreBuffer', TypeInfo(Androidapi.JNI.PlayServices.JLeaderboardScoreBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLeaderboardVariant', TypeInfo(Androidapi.JNI.PlayServices.JLeaderboardVariant));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLeaderboards', TypeInfo(Androidapi.JNI.PlayServices.JLeaderboards));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLeaderboards_LeaderboardMetadataResult', TypeInfo(Androidapi.JNI.PlayServices.JLeaderboards_LeaderboardMetadataResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLeaderboards_LoadPlayerScoreResult', TypeInfo(Androidapi.JNI.PlayServices.JLeaderboards_LoadPlayerScoreResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLeaderboards_LoadScoresResult', TypeInfo(Androidapi.JNI.PlayServices.JLeaderboards_LoadScoresResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLeaderboards_SubmitScoreResult', TypeInfo(Androidapi.JNI.PlayServices.JLeaderboards_SubmitScoreResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JScoreSubmissionData', TypeInfo(Androidapi.JNI.PlayServices.JScoreSubmissionData));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JScoreSubmissionData_Result', TypeInfo(Androidapi.JNI.PlayServices.JScoreSubmissionData_Result));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JInvitation', TypeInfo(Androidapi.JNI.PlayServices.JInvitation));
  //TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JInvitationBuffer', TypeInfo(Androidapi.JNI.PlayServices.JInvitationBuffer));
  //TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JInvitationEntity', TypeInfo(Androidapi.JNI.PlayServices.JInvitationEntity));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JInvitations', TypeInfo(Androidapi.JNI.PlayServices.JInvitations));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JInvitations_LoadInvitationsResult', TypeInfo(Androidapi.JNI.PlayServices.JInvitations_LoadInvitationsResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMultiplayer', TypeInfo(Androidapi.JNI.PlayServices.JMultiplayer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOnInvitationReceivedListener', TypeInfo(Androidapi.JNI.PlayServices.JOnInvitationReceivedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JParticipant', TypeInfo(Androidapi.JNI.PlayServices.JParticipant));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JParticipantBuffer', TypeInfo(Androidapi.JNI.PlayServices.JParticipantBuffer));
  //TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JParticipantEntity', TypeInfo(Androidapi.JNI.PlayServices.JParticipantEntity));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JParticipantResult', TypeInfo(Androidapi.JNI.PlayServices.JParticipantResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JParticipantResultCreator', TypeInfo(Androidapi.JNI.PlayServices.JParticipantResultCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JParticipantUtils', TypeInfo(Androidapi.JNI.PlayServices.JParticipantUtils));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JParticipatable', TypeInfo(Androidapi.JNI.PlayServices.JParticipatable));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRealTimeMessage', TypeInfo(Androidapi.JNI.PlayServices.JRealTimeMessage));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRealTimeMessageReceivedListener', TypeInfo(Androidapi.JNI.PlayServices.JRealTimeMessageReceivedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRealTimeMultiplayer', TypeInfo(Androidapi.JNI.PlayServices.JRealTimeMultiplayer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRealTimeMultiplayer_ReliableMessageSentCallback', TypeInfo(Androidapi.JNI.PlayServices.JRealTimeMultiplayer_ReliableMessageSentCallback));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Jrealtime_RealTimeSocket', TypeInfo(Androidapi.JNI.PlayServices.Jrealtime_RealTimeSocket));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRoom', TypeInfo(Androidapi.JNI.PlayServices.JRoom));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRoomConfig', TypeInfo(Androidapi.JNI.PlayServices.JRoomConfig));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRoomConfig_Builder', TypeInfo(Androidapi.JNI.PlayServices.JRoomConfig_Builder));
  //TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRoomEntity', TypeInfo(Androidapi.JNI.PlayServices.JRoomEntity));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRoomStatusUpdateListener', TypeInfo(Androidapi.JNI.PlayServices.JRoomStatusUpdateListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRoomUpdateListener', TypeInfo(Androidapi.JNI.PlayServices.JRoomUpdateListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLoadMatchesResponse', TypeInfo(Androidapi.JNI.PlayServices.JLoadMatchesResponse));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOnTurnBasedMatchUpdateReceivedListener', TypeInfo(Androidapi.JNI.PlayServices.JOnTurnBasedMatchUpdateReceivedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMatch', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMatch));
  //TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMatchBuffer', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMatchBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMatchConfig', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMatchConfig));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMatchConfig_1', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMatchConfig_1));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMatchConfig_Builder', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMatchConfig_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMatchEntity', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMatchEntity));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMatchEntityCreator', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMatchEntityCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMultiplayer', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMultiplayer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_CancelMatchResult', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_CancelMatchResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_InitiateMatchResult', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_InitiateMatchResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_LeaveMatchResult', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_LeaveMatchResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_LoadMatchResult', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_LoadMatchResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_LoadMatchesResult', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_LoadMatchesResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_UpdateMatchResult', TypeInfo(Androidapi.JNI.PlayServices.JTurnBasedMultiplayer_UpdateMatchResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGameRequest', TypeInfo(Androidapi.JNI.PlayServices.JGameRequest));
  //TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGameRequestBuffer', TypeInfo(Androidapi.JNI.PlayServices.JGameRequestBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGameRequestEntity', TypeInfo(Androidapi.JNI.PlayServices.JGameRequestEntity));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGameRequestEntityCreator', TypeInfo(Androidapi.JNI.PlayServices.JGameRequestEntityCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOnRequestReceivedListener', TypeInfo(Androidapi.JNI.PlayServices.JOnRequestReceivedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRequests', TypeInfo(Androidapi.JNI.PlayServices.JRequests));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRequests_LoadRequestsResult', TypeInfo(Androidapi.JNI.PlayServices.JRequests_LoadRequestsResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRequests_UpdateRequestsResult', TypeInfo(Androidapi.JNI.PlayServices.JRequests_UpdateRequestsResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleCloudMessaging', TypeInfo(Androidapi.JNI.PlayServices.JGoogleCloudMessaging));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Jintents_Address', TypeInfo(Androidapi.JNI.PlayServices.Jintents_Address));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAddress_AddressOptions', TypeInfo(Androidapi.JNI.PlayServices.JAddress_AddressOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAddressConstants', TypeInfo(Androidapi.JNI.PlayServices.JAddressConstants));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAddressConstants_ErrorCodes', TypeInfo(Androidapi.JNI.PlayServices.JAddressConstants_ErrorCodes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAddressConstants_Extras', TypeInfo(Androidapi.JNI.PlayServices.JAddressConstants_Extras));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAddressConstants_ResultCodes', TypeInfo(Androidapi.JNI.PlayServices.JAddressConstants_ResultCodes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JAddressConstants_Themes', TypeInfo(Androidapi.JNI.PlayServices.JAddressConstants_Themes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JUserAddressRequest', TypeInfo(Androidapi.JNI.PlayServices.JUserAddressRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JUserAddressRequest_Builder', TypeInfo(Androidapi.JNI.PlayServices.JUserAddressRequest_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCountrySpecification', TypeInfo(Androidapi.JNI.PlayServices.JCountrySpecification));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JUserAddress', TypeInfo(Androidapi.JNI.PlayServices.JUserAddress));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JActivityRecognitionClient', TypeInfo(Androidapi.JNI.PlayServices.JActivityRecognitionClient));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JActivityRecognitionResult', TypeInfo(Androidapi.JNI.PlayServices.JActivityRecognitionResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JActivityRecognitionResultCreator', TypeInfo(Androidapi.JNI.PlayServices.JActivityRecognitionResultCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDetectedActivity', TypeInfo(Androidapi.JNI.PlayServices.JDetectedActivity));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDetectedActivityCreator', TypeInfo(Androidapi.JNI.PlayServices.JDetectedActivityCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGeofence', TypeInfo(Androidapi.JNI.PlayServices.JGeofence));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGeofence_Builder', TypeInfo(Androidapi.JNI.PlayServices.JGeofence_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGeofenceStatusCodes', TypeInfo(Androidapi.JNI.PlayServices.JGeofenceStatusCodes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLocationClient', TypeInfo(Androidapi.JNI.PlayServices.JLocationClient));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLocationClient_OnAddGeofencesResultListener', TypeInfo(Androidapi.JNI.PlayServices.JLocationClient_OnAddGeofencesResultListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLocationClient_OnRemoveGeofencesResultListener', TypeInfo(Androidapi.JNI.PlayServices.JLocationClient_OnRemoveGeofencesResultListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Jlocation_LocationListener', TypeInfo(Androidapi.JNI.PlayServices.Jlocation_LocationListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLocationRequest', TypeInfo(Androidapi.JNI.PlayServices.JLocationRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLocationRequestCreator', TypeInfo(Androidapi.JNI.PlayServices.JLocationRequestCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLocationStatusCodes', TypeInfo(Androidapi.JNI.PlayServices.JLocationStatusCodes));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCameraUpdate', TypeInfo(Androidapi.JNI.PlayServices.JCameraUpdate));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCameraUpdateFactory', TypeInfo(Androidapi.JNI.PlayServices.JCameraUpdateFactory));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_CancelableCallback', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_CancelableCallback));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_InfoWindowAdapter', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_InfoWindowAdapter));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_OnCameraChangeListener', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_OnCameraChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_OnInfoWindowClickListener', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_OnInfoWindowClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_OnMapClickListener', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_OnMapClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_OnMapLoadedCallback', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_OnMapLoadedCallback));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_OnMapLongClickListener', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_OnMapLongClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_OnMarkerClickListener', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_OnMarkerClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_OnMarkerDragListener', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_OnMarkerDragListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_OnMyLocationButtonClickListener', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_OnMyLocationButtonClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_OnMyLocationChangeListener', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_OnMyLocationChangeListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMap_SnapshotReadyCallback', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMap_SnapshotReadyCallback));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMapOptions', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMapOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGoogleMapOptionsCreator', TypeInfo(Androidapi.JNI.PlayServices.JGoogleMapOptionsCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLocationSource', TypeInfo(Androidapi.JNI.PlayServices.JLocationSource));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLocationSource_OnLocationChangedListener', TypeInfo(Androidapi.JNI.PlayServices.JLocationSource_OnLocationChangedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMapFragment', TypeInfo(Androidapi.JNI.PlayServices.JMapFragment));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMapView', TypeInfo(Androidapi.JNI.PlayServices.JMapView));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMapsInitializer', TypeInfo(Androidapi.JNI.PlayServices.JMapsInitializer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JProjection', TypeInfo(Androidapi.JNI.PlayServices.JProjection));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JSupportMapFragment', TypeInfo(Androidapi.JNI.PlayServices.JSupportMapFragment));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JSupportMapFragment_a', TypeInfo(Androidapi.JNI.PlayServices.JSupportMapFragment_a));
  //TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JSupportMapFragment_b', TypeInfo(Androidapi.JNI.PlayServices.JSupportMapFragment_b));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JUiSettings', TypeInfo(Androidapi.JNI.PlayServices.JUiSettings));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JICameraUpdateFactoryDelegate', TypeInfo(Androidapi.JNI.PlayServices.JICameraUpdateFactoryDelegate));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JIGoogleMapDelegate', TypeInfo(Androidapi.JNI.PlayServices.JIGoogleMapDelegate));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JILocationSourceDelegate', TypeInfo(Androidapi.JNI.PlayServices.JILocationSourceDelegate));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JIMapFragmentDelegate', TypeInfo(Androidapi.JNI.PlayServices.JIMapFragmentDelegate));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JIMapViewDelegate', TypeInfo(Androidapi.JNI.PlayServices.JIMapViewDelegate));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JIProjectionDelegate', TypeInfo(Androidapi.JNI.PlayServices.JIProjectionDelegate));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JIUiSettingsDelegate', TypeInfo(Androidapi.JNI.PlayServices.JIUiSettingsDelegate));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JBitmapDescriptor', TypeInfo(Androidapi.JNI.PlayServices.JBitmapDescriptor));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JBitmapDescriptorFactory', TypeInfo(Androidapi.JNI.PlayServices.JBitmapDescriptorFactory));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCameraPosition', TypeInfo(Androidapi.JNI.PlayServices.JCameraPosition));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCameraPosition_Builder', TypeInfo(Androidapi.JNI.PlayServices.JCameraPosition_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCameraPositionCreator', TypeInfo(Androidapi.JNI.PlayServices.JCameraPositionCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCircle', TypeInfo(Androidapi.JNI.PlayServices.JCircle));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCircleOptions', TypeInfo(Androidapi.JNI.PlayServices.JCircleOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCircleOptionsCreator', TypeInfo(Androidapi.JNI.PlayServices.JCircleOptionsCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGroundOverlay', TypeInfo(Androidapi.JNI.PlayServices.JGroundOverlay));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGroundOverlayOptions', TypeInfo(Androidapi.JNI.PlayServices.JGroundOverlayOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JGroundOverlayOptionsCreator', TypeInfo(Androidapi.JNI.PlayServices.JGroundOverlayOptionsCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLatLng', TypeInfo(Androidapi.JNI.PlayServices.JLatLng));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLatLngBounds', TypeInfo(Androidapi.JNI.PlayServices.JLatLngBounds));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLatLngBounds_Builder', TypeInfo(Androidapi.JNI.PlayServices.JLatLngBounds_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLatLngBoundsCreator', TypeInfo(Androidapi.JNI.PlayServices.JLatLngBoundsCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLatLngCreator', TypeInfo(Androidapi.JNI.PlayServices.JLatLngCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMarker', TypeInfo(Androidapi.JNI.PlayServices.JMarker));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMarkerOptions', TypeInfo(Androidapi.JNI.PlayServices.JMarkerOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMarkerOptionsCreator', TypeInfo(Androidapi.JNI.PlayServices.JMarkerOptionsCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPolygon', TypeInfo(Androidapi.JNI.PlayServices.JPolygon));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPolygonOptions', TypeInfo(Androidapi.JNI.PlayServices.JPolygonOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPolygonOptionsCreator', TypeInfo(Androidapi.JNI.PlayServices.JPolygonOptionsCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPolyline', TypeInfo(Androidapi.JNI.PlayServices.JPolyline));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPolylineOptions', TypeInfo(Androidapi.JNI.PlayServices.JPolylineOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPolylineOptionsCreator', TypeInfo(Androidapi.JNI.PlayServices.JPolylineOptionsCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JRuntimeRemoteException', TypeInfo(Androidapi.JNI.PlayServices.JRuntimeRemoteException));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTile', TypeInfo(Androidapi.JNI.PlayServices.JTile));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTileCreator', TypeInfo(Androidapi.JNI.PlayServices.JTileCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTileOverlay', TypeInfo(Androidapi.JNI.PlayServices.JTileOverlay));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTileOverlayOptions', TypeInfo(Androidapi.JNI.PlayServices.JTileOverlayOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTileOverlayOptionsCreator', TypeInfo(Androidapi.JNI.PlayServices.JTileOverlayOptionsCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTileProvider', TypeInfo(Androidapi.JNI.PlayServices.JTileProvider));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JUrlTileProvider', TypeInfo(Androidapi.JNI.PlayServices.JUrlTileProvider));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JVisibleRegion', TypeInfo(Androidapi.JNI.PlayServices.JVisibleRegion));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JVisibleRegionCreator', TypeInfo(Androidapi.JNI.PlayServices.JVisibleRegionCreator));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JIPolylineDelegate', TypeInfo(Androidapi.JNI.PlayServices.JIPolylineDelegate));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPanorama', TypeInfo(Androidapi.JNI.PlayServices.JPanorama));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPanorama_PanoramaResult', TypeInfo(Androidapi.JNI.PlayServices.JPanorama_PanoramaResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPanoramaClient', TypeInfo(Androidapi.JNI.PlayServices.JPanoramaClient));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPanoramaClient_OnPanoramaInfoLoadedListener', TypeInfo(Androidapi.JNI.PlayServices.JPanoramaClient_OnPanoramaInfoLoadedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Jplus_Account', TypeInfo(Androidapi.JNI.PlayServices.Jplus_Account));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMoments', TypeInfo(Androidapi.JNI.PlayServices.JMoments));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMoments_LoadMomentsResult', TypeInfo(Androidapi.JNI.PlayServices.JMoments_LoadMomentsResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPeople', TypeInfo(Androidapi.JNI.PlayServices.JPeople));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPeople_LoadPeopleResult', TypeInfo(Androidapi.JNI.PlayServices.JPeople_LoadPeopleResult));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPeople_OrderBy', TypeInfo(Androidapi.JNI.PlayServices.JPeople_OrderBy));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlus', TypeInfo(Androidapi.JNI.PlayServices.JPlus));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlus_PlusOptions', TypeInfo(Androidapi.JNI.PlayServices.JPlus_PlusOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusOptions_Builder', TypeInfo(Androidapi.JNI.PlayServices.JPlusOptions_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusClient', TypeInfo(Androidapi.JNI.PlayServices.JPlusClient));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusClient_Builder', TypeInfo(Androidapi.JNI.PlayServices.JPlusClient_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusClient_OnAccessRevokedListener', TypeInfo(Androidapi.JNI.PlayServices.JPlusClient_OnAccessRevokedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusClient_OnMomentsLoadedListener', TypeInfo(Androidapi.JNI.PlayServices.JPlusClient_OnMomentsLoadedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusClient_OnPeopleLoadedListener', TypeInfo(Androidapi.JNI.PlayServices.JPlusClient_OnPeopleLoadedListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusClient_OrderBy', TypeInfo(Androidapi.JNI.PlayServices.JPlusClient_OrderBy));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusOneButton', TypeInfo(Androidapi.JNI.PlayServices.JPlusOneButton));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusOneButton_DefaultOnPlusOneClickListener', TypeInfo(Androidapi.JNI.PlayServices.JPlusOneButton_DefaultOnPlusOneClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusOneButton_OnPlusOneClickListener', TypeInfo(Androidapi.JNI.PlayServices.JPlusOneButton_OnPlusOneClickListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusOneDummyView', TypeInfo(Androidapi.JNI.PlayServices.JPlusOneDummyView));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusShare', TypeInfo(Androidapi.JNI.PlayServices.JPlusShare));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusShare_Builder', TypeInfo(Androidapi.JNI.PlayServices.JPlusShare_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPlusCommonExtras', TypeInfo(Androidapi.JNI.PlayServices.JPlusCommonExtras));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JItemScope', TypeInfo(Androidapi.JNI.PlayServices.JItemScope));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JItemScope_Builder', TypeInfo(Androidapi.JNI.PlayServices.JItemScope_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMoment', TypeInfo(Androidapi.JNI.PlayServices.JMoment));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMoment_Builder', TypeInfo(Androidapi.JNI.PlayServices.JMoment_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMomentBuffer', TypeInfo(Androidapi.JNI.PlayServices.JMomentBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPerson', TypeInfo(Androidapi.JNI.PlayServices.JPerson));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPerson_AgeRange', TypeInfo(Androidapi.JNI.PlayServices.JPerson_AgeRange));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPerson_Cover', TypeInfo(Androidapi.JNI.PlayServices.JPerson_Cover));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCover_CoverInfo', TypeInfo(Androidapi.JNI.PlayServices.JCover_CoverInfo));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCover_CoverPhoto', TypeInfo(Androidapi.JNI.PlayServices.JCover_CoverPhoto));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCover_Layout', TypeInfo(Androidapi.JNI.PlayServices.JCover_Layout));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPerson_Gender', TypeInfo(Androidapi.JNI.PlayServices.JPerson_Gender));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPerson_Image', TypeInfo(Androidapi.JNI.PlayServices.JPerson_Image));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPerson_Name', TypeInfo(Androidapi.JNI.PlayServices.JPerson_Name));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPerson_ObjectType', TypeInfo(Androidapi.JNI.PlayServices.JPerson_ObjectType));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPerson_Organizations', TypeInfo(Androidapi.JNI.PlayServices.JPerson_Organizations));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOrganizations_Type', TypeInfo(Androidapi.JNI.PlayServices.JOrganizations_Type));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPerson_PlacesLived', TypeInfo(Androidapi.JNI.PlayServices.JPerson_PlacesLived));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPerson_RelationshipStatus', TypeInfo(Androidapi.JNI.PlayServices.JPerson_RelationshipStatus));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPerson_Urls', TypeInfo(Androidapi.JNI.PlayServices.JPerson_Urls));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JUrls_Type', TypeInfo(Androidapi.JNI.PlayServices.JUrls_Type));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPersonBuffer', TypeInfo(Androidapi.JNI.PlayServices.JPersonBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JContainer', TypeInfo(Androidapi.JNI.PlayServices.JContainer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JContainer_FunctionCallMacroCallback', TypeInfo(Androidapi.JNI.PlayServices.JContainer_FunctionCallMacroCallback));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JContainer_FunctionCallTagCallback', TypeInfo(Androidapi.JNI.PlayServices.JContainer_FunctionCallTagCallback));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JContainerHolder', TypeInfo(Androidapi.JNI.PlayServices.JContainerHolder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JContainerHolder_ContainerAvailableListener', TypeInfo(Androidapi.JNI.PlayServices.JContainerHolder_ContainerAvailableListener));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JDataLayer', TypeInfo(Androidapi.JNI.PlayServices.JDataLayer));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JInstallReferrerReceiver', TypeInfo(Androidapi.JNI.PlayServices.JInstallReferrerReceiver));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JInstallReferrerService', TypeInfo(Androidapi.JNI.PlayServices.JInstallReferrerService));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JPreviewActivity', TypeInfo(Androidapi.JNI.PlayServices.JPreviewActivity));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JTagManager', TypeInfo(Androidapi.JNI.PlayServices.JTagManager));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Jwallet_Address', TypeInfo(Androidapi.JNI.PlayServices.Jwallet_Address));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCart', TypeInfo(Androidapi.JNI.PlayServices.JCart));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JCart_Builder', TypeInfo(Androidapi.JNI.PlayServices.JCart_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.Jwallet_CountrySpecification', TypeInfo(Androidapi.JNI.PlayServices.Jwallet_CountrySpecification));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JEnableWalletOptimizationReceiver', TypeInfo(Androidapi.JNI.PlayServices.JEnableWalletOptimizationReceiver));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JFullWallet', TypeInfo(Androidapi.JNI.PlayServices.JFullWallet));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JFullWalletRequest', TypeInfo(Androidapi.JNI.PlayServices.JFullWalletRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JFullWalletRequest_Builder', TypeInfo(Androidapi.JNI.PlayServices.JFullWalletRequest_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JInstrumentInfo', TypeInfo(Androidapi.JNI.PlayServices.JInstrumentInfo));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLineItem', TypeInfo(Androidapi.JNI.PlayServices.JLineItem));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLineItem_Builder', TypeInfo(Androidapi.JNI.PlayServices.JLineItem_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLineItem_Role', TypeInfo(Androidapi.JNI.PlayServices.JLineItem_Role));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JLoyaltyWalletObject', TypeInfo(Androidapi.JNI.PlayServices.JLoyaltyWalletObject));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMaskedWallet', TypeInfo(Androidapi.JNI.PlayServices.JMaskedWallet));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMaskedWalletRequest', TypeInfo(Androidapi.JNI.PlayServices.JMaskedWalletRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JMaskedWalletRequest_Builder', TypeInfo(Androidapi.JNI.PlayServices.JMaskedWalletRequest_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JNotifyTransactionStatusRequest', TypeInfo(Androidapi.JNI.PlayServices.JNotifyTransactionStatusRequest));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JNotifyTransactionStatusRequest_Builder', TypeInfo(Androidapi.JNI.PlayServices.JNotifyTransactionStatusRequest_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JNotifyTransactionStatusRequest_Status', TypeInfo(Androidapi.JNI.PlayServices.JNotifyTransactionStatusRequest_Status));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JStatus_Error', TypeInfo(Androidapi.JNI.PlayServices.JStatus_Error));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JOfferWalletObject', TypeInfo(Androidapi.JNI.PlayServices.JOfferWalletObject));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JProxyCard', TypeInfo(Androidapi.JNI.PlayServices.JProxyCard));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JWallet', TypeInfo(Androidapi.JNI.PlayServices.JWallet));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JWallet_WalletOptions', TypeInfo(Androidapi.JNI.PlayServices.JWallet_WalletOptions));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JWalletOptions_Builder', TypeInfo(Androidapi.JNI.PlayServices.JWalletOptions_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JWalletClient', TypeInfo(Androidapi.JNI.PlayServices.JWalletClient));
  TRegTypes.RegisterType('Androidapi.JNI.PlayServices.JWalletConstants', TypeInfo(Androidapi.JNI.PlayServices.JWalletConstants));
end;

initialization
  RegisterTypes;
end.


