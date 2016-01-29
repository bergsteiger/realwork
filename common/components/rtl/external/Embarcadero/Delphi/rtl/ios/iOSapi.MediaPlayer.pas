{**********************************************************}
{                                                          }
{           CodeGear Delphi Runtime Library                }
{                                                          }
{ Delphi-Objective-C Bridge                                }
{ Interfaces for Cocoa framework MediaPlayer               }
{                                                          }
{ Copyright (c) 2008-2011 Apple Inc. All rights reserved.  }
{                                                          }
{ Translator: Embarcadero Technologies, Inc.               }
{   Copyright(c) 2012-2013 Embarcadero Technologies, Inc.  }
{                                                          }
{**********************************************************}

unit iOSapi.MediaPlayer;

interface

uses Macapi.ObjectiveC, Macapi.ObjCRuntime, iOSapi.CocoaTypes, iOSapi.Foundation, iOSapi.UIKit, iOSapi.CoreGraphics;

const
  MPMediaGroupingAlbum = 1;
  MPMediaGroupingAlbumArtist = 3;
  MPMediaGroupingArtist = 2;
  MPMediaGroupingComposer = 4;
  MPMediaGroupingGenre = 5;
  MPMediaGroupingPlaylist = 6;
  MPMediaGroupingPodcastTitle = 7;
  MPMediaGroupingTitle = 0;
  MPMediaPlaylistAttributeGenius = 4;
  MPMediaPlaylistAttributeNone = 0;
  MPMediaPlaylistAttributeOnTheGo = 1;
  MPMediaPlaylistAttributeSmart = 2;
  MPMediaPredicateComparisonContains = 1;
  MPMediaPredicateComparisonEqualTo = 0;
  MPMediaTypeAny = -1;
  MPMediaTypeAnyAudio = 255;
  MPMediaTypeAnyVideo = 65280;
  MPMediaTypeAudioBook = 4;
  MPMediaTypeAudioITunesU = 8;
  MPMediaTypeMovie = 256;
  MPMediaTypeMusic = 1;
  MPMediaTypeMusicVideo = 2048;
  MPMediaTypePodcast = 2;
  MPMediaTypeTVShow = 512;
  MPMediaTypeVideoITunesU = 4096;
  MPMediaTypeVideoPodcast = 1024;
  MPMovieControlModeDefault = 0;
  MPMovieControlModeHidden = 2;
  MPMovieControlModeVolumeOnly = 1;
  MPMovieControlStyleDefault = 1;
  MPMovieControlStyleEmbedded = 1;
  MPMovieControlStyleFullscreen = 2;
  MPMovieControlStyleNone = 0;
  MPMovieFinishReasonPlaybackEnded = 0;
  MPMovieFinishReasonPlaybackError = 1;
  MPMovieFinishReasonUserExited = 2;
  MPMovieLoadStatePlayable = 1;
  MPMovieLoadStatePlaythroughOK = 2;
  MPMovieLoadStateStalled = 4;
  MPMovieLoadStateUnknown = 0;
  MPMovieMediaTypeMaskAudio = 2;
  MPMovieMediaTypeMaskNone = 0;
  MPMovieMediaTypeMaskVideo = 1;
  MPMoviePlaybackStateInterrupted = 3;
  MPMoviePlaybackStatePaused = 2;
  MPMoviePlaybackStatePlaying = 1;
  MPMoviePlaybackStateSeekingBackward = 5;
  MPMoviePlaybackStateSeekingForward = 4;
  MPMoviePlaybackStateStopped = 0;
  MPMovieRepeatModeNone = 0;
  MPMovieRepeatModeOne = 1;
  MPMovieScalingModeAspectFill = 2;
  MPMovieScalingModeAspectFit = 1;
  MPMovieScalingModeFill = 3;
  MPMovieScalingModeNone = 0;
  MPMovieSourceTypeFile = 1;
  MPMovieSourceTypeStreaming = 2;
  MPMovieSourceTypeUnknown = 0;
  MPMovieTimeOptionExact = 1;
  MPMovieTimeOptionNearestKeyFrame = 0;
  MPMusicPlaybackStateInterrupted = 3;
  MPMusicPlaybackStatePaused = 2;
  MPMusicPlaybackStatePlaying = 1;
  MPMusicPlaybackStateSeekingBackward = 5;
  MPMusicPlaybackStateSeekingForward = 4;
  MPMusicPlaybackStateStopped = 0;
  MPMusicRepeatModeAll = 3;
  MPMusicRepeatModeDefault = 0;
  MPMusicRepeatModeNone = 1;
  MPMusicRepeatModeOne = 2;
  MPMusicShuffleModeAlbums = 3;
  MPMusicShuffleModeDefault = 0;
  MPMusicShuffleModeOff = 1;
  MPMusicShuffleModeSongs = 2;

// ===== External functions =====

const
  libMediaPlayer = '/System/Library/Frameworks/MediaPlayer.framework/MediaPlayer';

// ===== Typedefs and structs =====
type
{$M+}
  MPMediaGrouping = NSInteger;
  MPMediaPredicateComparison = NSInteger;
  MPMediaType = NSInteger;
  MPMovieControlStyle = NSInteger;
  MPMovieFinishReason = NSInteger;
  MPMovieLoadState = NSInteger;
  MPMovieMediaTypeMask = NSInteger;
  MPMoviePlaybackState = NSInteger;
  MPMovieRepeatMode = NSInteger;
  MPMovieScalingMode = NSInteger;
  MPMovieSourceType = NSInteger;
  MPMovieTimeOption = NSInteger;
  MPMusicPlaybackState = NSInteger;
  MPMusicRepeatMode = NSInteger;
  MPMusicShuffleMode = NSInteger;

procedure MPVolumeSettingsAlertHide; cdecl; external libMediaPlayer name _PU + 'MPVolumeSettingsAlertHide';
function MPVolumeSettingsAlertIsVisible: Boolean; cdecl; external libMediaPlayer name _PU + 'MPVolumeSettingsAlertIsVisible';
procedure MPVolumeSettingsAlertShow; cdecl; external libMediaPlayer name _PU + 'MPVolumeSettingsAlertShow';

type
{$M+}
// ===== Forward declarations =====

  MPMediaPickerControllerDelegate = interface;

  MPMoviePlayerController = interface;
  MPMusicPlayerController = interface;
  MPMovieErrorLogEvent = interface;
  MPMovieAccessLogEvent = interface;
  MPMovieErrorLog = interface;
  MPVolumeView = interface;
  MPNowPlayingInfoCenter = interface;
  MPTimedMetadata = interface;
  MPMediaEntity = interface;
  MPMediaLibrary = interface;
  MPMediaItemArtwork = interface;
  MPMediaPropertyPredicate = interface;
  MPMediaQuerySection = interface;
  MPMovieAccessLog = interface;
  MPMediaQuery = interface;
  MPMediaItem = interface;
  MPMoviePlayerViewController = interface;
  MPMediaPickerController = interface;
  MPMediaItemCollection = interface;

// ===== Interface declarations =====

  MPMoviePlayerControllerClass = interface(NSObjectClass)
    ['{D03E6638-4E23-4E84-9F1D-77352CF215F4}']
  end;
  MPMoviePlayerController = interface(NSObject)
    ['{8C2105E8-2B61-444D-9AC5-6370C1F06A46}']
    function accessLog: MPMovieAccessLog; cdecl;
    function allowsAirPlay: Boolean; cdecl;
    function backgroundColor: UIColor; cdecl;
    function backgroundView: UIView; cdecl;
    procedure cancelAllThumbnailImageRequests; cdecl;
    function contentURL: NSURL; cdecl;
    function controlStyle: MPMovieControlStyle; cdecl;
    function duration: NSTimeInterval; cdecl;
    function endPlaybackTime: NSTimeInterval; cdecl;
    function errorLog: MPMovieErrorLog; cdecl;
    function initWithContentURL(url: NSURL): Pointer; cdecl;
    function initialPlaybackTime: NSTimeInterval; cdecl;
    function isAirPlayVideoActive: Boolean; cdecl;
    function isFullscreen: Boolean; cdecl;
    function loadState: MPMovieLoadState; cdecl;
//    function movieControlMode: MPMovieControlMode; cdecl; //deprecated
    function movieMediaTypes: MPMovieMediaTypeMask; cdecl;
    function movieSourceType: MPMovieSourceType; cdecl;
    function naturalSize: CGSize; cdecl;
    function playableDuration: NSTimeInterval; cdecl;
    function playbackState: MPMoviePlaybackState; cdecl;
    function repeatMode: MPMovieRepeatMode; cdecl;
    procedure requestThumbnailImagesAtTimes(playbackTimes: NSArray; timeOption: MPMovieTimeOption); cdecl;
    function scalingMode: MPMovieScalingMode; cdecl;
    procedure setAllowsAirPlay(allowsAirPlay: Boolean); cdecl;
    procedure setBackgroundColor(backgroundColor: UIColor); cdecl;
    procedure setContentURL(contentURL: NSURL); cdecl;
    procedure setControlStyle(controlStyle: MPMovieControlStyle); cdecl;
    procedure setEndPlaybackTime(endPlaybackTime: NSTimeInterval); cdecl;
    procedure setFullscreen(fullscreen: Boolean); cdecl; overload;
    procedure setFullscreen(fullscreen: Boolean; animated: Boolean); cdecl; overload;
    procedure setInitialPlaybackTime(initialPlaybackTime: NSTimeInterval); cdecl;
//    procedure setMovieControlMode(movieControlMode: MPMovieControlMode); cdecl; // deprecated
    procedure setMovieSourceType(movieSourceType: MPMovieSourceType); cdecl;
    procedure setRepeatMode(repeatMode: MPMovieRepeatMode); cdecl;
    procedure setScalingMode(scalingMode: MPMovieScalingMode); cdecl;
    procedure setShouldAutoplay(shouldAutoplay: Boolean); cdecl;
    procedure setUseApplicationAudioSession(useApplicationAudioSession: Boolean); cdecl;
    function shouldAutoplay: Boolean; cdecl;
    function thumbnailImageAtTime(playbackTime: NSTimeInterval; timeOption: MPMovieTimeOption): UIImage; cdecl;
    function timedMetadata: NSArray; cdecl;
    function useApplicationAudioSession: Boolean; cdecl;
    function view: UIView; cdecl;
  end;
  TMPMoviePlayerController = class(TOCGenericImport<MPMoviePlayerControllerClass, MPMoviePlayerController>)  end;

  MPMusicPlayerControllerClass = interface(NSObjectClass)
    ['{A8BB0A1F-CF69-43AE-A308-2515A413274A}']
    {class} function applicationMusicPlayer: Pointer; cdecl;
    {class} function iPodMusicPlayer: Pointer; cdecl;
  end;
  MPMusicPlayerController = interface(NSObject)
    ['{A37F2D41-2CF8-488A-9989-38D58DF897C0}']
    procedure beginGeneratingPlaybackNotifications; cdecl;
    procedure beginSeekingBackward; cdecl;
    procedure beginSeekingForward; cdecl;
    function currentPlaybackTime: NSTimeInterval; cdecl;
    procedure endGeneratingPlaybackNotifications; cdecl;
    procedure endSeeking; cdecl;
    function indexOfNowPlayingItem: NSUInteger; cdecl;
    function nowPlayingItem: MPMediaItem; cdecl;
    procedure pause; cdecl;
    procedure play; cdecl;
    function playbackState: MPMusicPlaybackState; cdecl;
    function repeatMode: MPMusicRepeatMode; cdecl;
    procedure setCurrentPlaybackTime(currentPlaybackTime: NSTimeInterval); cdecl;
    procedure setNowPlayingItem(nowPlayingItem: MPMediaItem); cdecl;
    procedure setQueueWithItemCollection(itemCollection: MPMediaItemCollection); cdecl;
    procedure setQueueWithQuery(query: MPMediaQuery); cdecl;
    procedure setRepeatMode(repeatMode: MPMusicRepeatMode); cdecl;
    procedure setShuffleMode(shuffleMode: MPMusicShuffleMode); cdecl;
    procedure setVolume(volume: Single); cdecl;
    function shuffleMode: MPMusicShuffleMode; cdecl;
    procedure skipToBeginning; cdecl;
    procedure skipToNextItem; cdecl;
    procedure skipToPreviousItem; cdecl;
    procedure stop; cdecl;
    function volume: Single; cdecl;
  end;
  TMPMusicPlayerController = class(TOCGenericImport<MPMusicPlayerControllerClass, MPMusicPlayerController>)  end;

  MPMovieErrorLogEventClass = interface(NSObjectClass)
    ['{CB09AAE2-B9DD-4E09-9511-D9C08AD457DB}']
  end;
  MPMovieErrorLogEvent = interface(NSObject)
    ['{E4EDC760-F8BB-42B2-BA3C-C9606CFAC50F}']
    function URI: NSString; cdecl;
    function date: NSDate; cdecl;
    function errorComment: NSString; cdecl;
    function errorDomain: NSString; cdecl;
    function errorStatusCode: NSInteger; cdecl;
    function playbackSessionID: NSString; cdecl;
    function serverAddress: NSString; cdecl;
  end;
  TMPMovieErrorLogEvent = class(TOCGenericImport<MPMovieErrorLogEventClass, MPMovieErrorLogEvent>)  end;

  MPMovieAccessLogEventClass = interface(NSObjectClass)
    ['{114E931A-A4D1-46B9-90EC-EF1BC2F4ECDA}']
  end;
  MPMovieAccessLogEvent = interface(NSObject)
    ['{7AAF41DA-D917-45A2-AAE7-856BA010DA5F}']
    function URI: NSString; cdecl;
    function durationWatched: NSTimeInterval; cdecl;
    function indicatedBitrate: double; cdecl;
    function numberOfBytesTransferred: Int64; cdecl;
    function numberOfDroppedVideoFrames: NSInteger; cdecl;
    function numberOfSegmentsDownloaded: NSUInteger; cdecl;
    function numberOfServerAddressChanges: NSUInteger; cdecl;
    function numberOfStalls: NSInteger; cdecl;
    function observedBitrate: double; cdecl;
    function playbackSessionID: NSString; cdecl;
    function playbackStartDate: NSDate; cdecl;
    function playbackStartOffset: NSTimeInterval; cdecl;
    function segmentsDownloadedDuration: NSTimeInterval; cdecl;
    function serverAddress: NSString; cdecl;
  end;
  TMPMovieAccessLogEvent = class(TOCGenericImport<MPMovieAccessLogEventClass, MPMovieAccessLogEvent>)  end;

  MPMovieErrorLogClass = interface(NSObjectClass)
    ['{DB4928FF-89C7-4FC1-8130-7E2BCE3E1D08}']
  end;
  MPMovieErrorLog = interface(NSObject)
    ['{A30C424C-7B0A-448B-9DB5-332B8BDD9749}']
    function events: NSArray; cdecl;
    function extendedLogData: NSData; cdecl;
    function extendedLogDataStringEncoding: NSStringEncoding; cdecl;
  end;
  TMPMovieErrorLog = class(TOCGenericImport<MPMovieErrorLogClass, MPMovieErrorLog>)  end;

  MPVolumeViewClass = interface(UIViewClass)
    ['{77BCCDB1-6A06-43F4-B57D-965346426888}']
  end;
  MPVolumeView = interface(UIView)
    ['{F55C8146-7D21-4607-B6E1-75B0E40D8DA3}']
    procedure setShowsRouteButton(showsRouteButton: Boolean); cdecl;
    procedure setShowsVolumeSlider(showsVolumeSlider: Boolean); cdecl;
    function showsRouteButton: Boolean; cdecl;
    function showsVolumeSlider: Boolean; cdecl;
    function sizeThatFits(size: CGSize): CGSize; cdecl;
  end;
  TMPVolumeView = class(TOCGenericImport<MPVolumeViewClass, MPVolumeView>)  end;

  MPNowPlayingInfoCenterClass = interface(NSObjectClass)
    ['{0AFA71E9-2FA5-44CF-A5A2-82F0A7DC7A52}']
    {class} function defaultCenter: Pointer; cdecl;
  end;
  MPNowPlayingInfoCenter = interface(NSObject)
    ['{250A112D-7C42-4FBC-8357-CA29F387DCBE}']
    function nowPlayingInfo: NSDictionary; cdecl;
    procedure setNowPlayingInfo(nowPlayingInfo: NSDictionary); cdecl;
  end;
  TMPNowPlayingInfoCenter = class(TOCGenericImport<MPNowPlayingInfoCenterClass, MPNowPlayingInfoCenter>)  end;

  MPTimedMetadataClass = interface(NSObjectClass)
    ['{E54D9B82-D7C5-4F8F-8C59-652BCF105601}']
  end;
  MPTimedMetadata = interface(NSObject)
    ['{613C0A9B-09D6-4D19-9A71-E3DE91479DCF}']
    function allMetadata: NSDictionary; cdecl;
    function key: NSString; cdecl;
    function keyspace: NSString; cdecl;
    function timestamp: NSTimeInterval; cdecl;
    function value: Pointer; cdecl;
  end;
  TMPTimedMetadata = class(TOCGenericImport<MPTimedMetadataClass, MPTimedMetadata>)  end;

  MPMediaEntityClass = interface(NSObjectClass)
    ['{71287020-7E31-4C94-B1BB-302EC7BCA7BC}']
    {class} function canFilterByProperty(property_: NSString): Boolean; cdecl;
  end;
  MPMediaEntity = interface(NSObject)
    ['{DEAEFF9D-1AF5-4F2D-BAE7-B2A01A78C399}']
    function valueForProperty(property_: NSString): Pointer; cdecl;
  end;
  TMPMediaEntity = class(TOCGenericImport<MPMediaEntityClass, MPMediaEntity>)  end;

  MPMediaLibraryClass = interface(NSObjectClass)
    ['{9385AEC7-2001-4FA2-8BEB-1D92D3D5740E}']
    {class} function defaultMediaLibrary: Pointer; cdecl;
  end;
  MPMediaLibrary = interface(NSObject)
    ['{51AC6FEB-9559-4D57-BFE4-30E8E4FFFDF7}']
    procedure beginGeneratingLibraryChangeNotifications; cdecl;
    procedure endGeneratingLibraryChangeNotifications; cdecl;
    function lastModifiedDate: NSDate; cdecl;
  end;
  TMPMediaLibrary = class(TOCGenericImport<MPMediaLibraryClass, MPMediaLibrary>)  end;

  MPMediaItemArtworkClass = interface(NSObjectClass)
    ['{E745306C-DC9B-4AA5-AE2B-C5206742828D}']
  end;
  MPMediaItemArtwork = interface(NSObject)
    ['{2BE234AD-D57A-407D-9164-CDB2A9334E64}']
    function bounds: CGRect; cdecl;
    function imageCropRect: CGRect; cdecl;
    function imageWithSize(size: CGSize): UIImage; cdecl;
    function initWithImage(image: UIImage): Pointer; cdecl;
  end;
  TMPMediaItemArtwork = class(TOCGenericImport<MPMediaItemArtworkClass, MPMediaItemArtwork>)  end;

  MPMediaPredicateClass = interface(NSObjectClass)
    ['{B2146295-4920-470C-A78F-C00C83C9513F}']
  end;
  MPMediaPredicate = interface(NSObject)
    ['{32F1A9FA-BDF8-4B39-AC51-09CC67988CFD}']
  end;
  TMPMediaPredicate = class(TOCGenericImport<MPMediaPredicateClass, MPMediaPredicate>)  end;

  MPMediaPropertyPredicateClass = interface(MPMediaPredicateClass)
    ['{C73CCF7B-0708-4C25-9587-F2BFF8159DDE}']
    {class} function predicateWithValue(value: Pointer; forProperty: NSString): Pointer; cdecl; overload;
    {class} function predicateWithValue(value: Pointer; forProperty: NSString; comparisonType: MPMediaPredicateComparison): Pointer; cdecl; overload;
  end;
  MPMediaPropertyPredicate = interface(MPMediaPredicate)
    ['{66CF22E1-05F7-4248-92ED-26A218C59EEA}']
    function comparisonType: MPMediaPredicateComparison; cdecl;
    function value: Pointer; cdecl;
  end;
  TMPMediaPropertyPredicate = class(TOCGenericImport<MPMediaPropertyPredicateClass, MPMediaPropertyPredicate>)  end;

  MPMediaQuerySectionClass = interface(NSObjectClass)
    ['{B6C43755-9EC6-42BE-A0FC-53D17CA17F88}']
  end;
  MPMediaQuerySection = interface(NSObject)
    ['{82C4032F-7AD6-448D-A762-B8D28FA52CDA}']
    function range: NSRange; cdecl;
    function title: NSString; cdecl;
  end;
  TMPMediaQuerySection = class(TOCGenericImport<MPMediaQuerySectionClass, MPMediaQuerySection>)  end;

  MPMovieAccessLogClass = interface(NSObjectClass)
    ['{7CB52822-F8F1-42ED-93E3-B452BBBC9E05}']
  end;
  MPMovieAccessLog = interface(NSObject)
    ['{6CD7F56C-1EAE-4D13-8961-7602DAD90CEF}']
    function events: NSArray; cdecl;
    function extendedLogData: NSData; cdecl;
    function extendedLogDataStringEncoding: NSStringEncoding; cdecl;
  end;
  TMPMovieAccessLog = class(TOCGenericImport<MPMovieAccessLogClass, MPMovieAccessLog>)  end;

  MPMediaQueryClass = interface(NSObjectClass)
    ['{7AAF113C-8F84-4AE1-BD0F-E0325E3B5249}']
    {class} function albumsQuery: Pointer; cdecl;
    {class} function artistsQuery: Pointer; cdecl;
    {class} function audiobooksQuery: Pointer; cdecl;
    {class} function compilationsQuery: Pointer; cdecl;
    {class} function composersQuery: Pointer; cdecl;
    {class} function genresQuery: Pointer; cdecl;
    {class} function playlistsQuery: Pointer; cdecl;
    {class} function podcastsQuery: Pointer; cdecl;
    {class} function songsQuery: Pointer; cdecl;
  end;
  MPMediaQuery = interface(NSObject)
    ['{71EEF474-F196-4594-B03B-20737789786C}']
    procedure addFilterPredicate(predicate: MPMediaPredicate); cdecl;
    function collectionSections: NSArray; cdecl;
    function collections: NSArray; cdecl;
    function filterPredicates: NSSet; cdecl;
    function groupingType: MPMediaGrouping; cdecl;
    function init: Pointer; cdecl;
    function initWithFilterPredicates(filterPredicates: NSSet): Pointer; cdecl;
    function itemSections: NSArray; cdecl;
    function items: NSArray; cdecl;
    procedure removeFilterPredicate(predicate: MPMediaPredicate); cdecl;
    procedure setFilterPredicates(filterPredicates: NSSet); cdecl;
    procedure setGroupingType(groupingType: MPMediaGrouping); cdecl;
  end;
  TMPMediaQuery = class(TOCGenericImport<MPMediaQueryClass, MPMediaQuery>)  end;

  MPMediaItemClass = interface(MPMediaEntityClass)
    ['{B91ECF7B-4F97-47A7-BC18-AFFFAE69D74F}']
    {class} function persistentIDPropertyForGroupingType(groupingType: MPMediaGrouping): NSString; cdecl;
    {class} function titlePropertyForGroupingType(groupingType: MPMediaGrouping): NSString; cdecl;
  end;
  MPMediaItem = interface(MPMediaEntity)
    ['{E931A458-F08D-4678-B52D-6EB0C5E4A2FB}']
  end;
  TMPMediaItem = class(TOCGenericImport<MPMediaItemClass, MPMediaItem>)  end;

  MPMoviePlayerViewControllerClass = interface(UIViewControllerClass)
    ['{140CAD86-4F5C-455B-9B6C-19DBB7D2B0F9}']
  end;
  MPMoviePlayerViewController = interface(UIViewController)
    ['{E81DC647-B84E-43DB-8BF9-4ABB1EBFBA65}']
    function initWithContentURL(contentURL: NSURL): Pointer; cdecl;
    function moviePlayer: MPMoviePlayerController; cdecl;
    function shouldAutorotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation): Boolean; cdecl;
  end;
  TMPMoviePlayerViewController = class(TOCGenericImport<MPMoviePlayerViewControllerClass, MPMoviePlayerViewController>)  end;

  MPMediaPickerControllerClass = interface(UIViewControllerClass)
    ['{B72B8461-793C-4D8B-B82C-E7B2EBD60A62}']
  end;
  MPMediaPickerController = interface(UIViewController)
    ['{7B8C41D2-8F50-42BC-8AA5-84A4DD6CF886}']
    function allowsPickingMultipleItems: Boolean; cdecl;
    function delegate: Pointer; cdecl;
    function init: Pointer; cdecl;
    function initWithMediaTypes(mediaTypes: MPMediaType): Pointer; cdecl;
    function mediaTypes: MPMediaType; cdecl;
    function prompt: NSString; cdecl;
    procedure setAllowsPickingMultipleItems(allowsPickingMultipleItems: Boolean); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setPrompt(prompt: NSString); cdecl;
  end;
  TMPMediaPickerController = class(TOCGenericImport<MPMediaPickerControllerClass, MPMediaPickerController>)  end;

  MPMediaItemCollectionClass = interface(MPMediaEntityClass)
    ['{46C65217-9BDD-4C23-BC0F-AD9F6F99F8DE}']
    {class} function collectionWithItems(items: NSArray): Pointer; cdecl;
  end;
  MPMediaItemCollection = interface(MPMediaEntity)
    ['{B35D202B-C3FD-4C11-A434-76D1C796BEA2}']
    function count: NSUInteger; cdecl;
    function initWithItems(items: NSArray): Pointer; cdecl;
    function items: NSArray; cdecl;
    function mediaTypes: MPMediaType; cdecl;
    function representativeItem: MPMediaItem; cdecl;
  end;
  TMPMediaItemCollection = class(TOCGenericImport<MPMediaItemCollectionClass, MPMediaItemCollection>)  end;

 // ===== Protocol declarations =====

  MPMediaPickerControllerDelegate = interface(IObjectiveC)
    ['{EB070067-8836-47FE-A13C-3E3779C2EA47}']
    procedure mediaPicker(mediaPicker: MPMediaPickerController; didPickMediaItems: MPMediaItemCollection); cdecl;
    procedure mediaPickerDidCancel(mediaPicker: MPMediaPickerController); cdecl;
  end;
  MPMediaPlayback = interface
    ['{1E3280B8-F3ED-41D3-8C7A-65C3A2DA1306}']
    procedure beginSeekingBackward; cdecl;
    procedure beginSeekingForward; cdecl;
    function currentPlaybackRate: Single; cdecl;
    function currentPlaybackTime: NSTimeInterval; cdecl;
    procedure endSeeking; cdecl;
    function isPreparedToPlay: Boolean; cdecl;
    procedure pause; cdecl;
    procedure play; cdecl;
    procedure prepareToPlay; cdecl;
    procedure setCurrentPlaybackRate(currentPlaybackRate: Single); cdecl;
    procedure setCurrentPlaybackTime(currentPlaybackTime: NSTimeInterval); cdecl;
    procedure stop; cdecl;
  end;

implementation

{$IF defined(IOS) and NOT defined(CPUARM)}
uses
  Posix.Dlfcn;

var
  MPModule: THandle;

initialization
  MPModule := dlopen(MarshaledAString(libMediaPlayer), RTLD_LAZY);

finalization
  dlclose(MPModule);
{$ENDIF IOS}

end.
