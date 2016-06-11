{*******************************************************}
{                                                       }
{           Delphi FireMonkey Mobile Services           }
{                                                       }
{     Description of interfaces for operation with      }
{        media storage (Audios, Videos, Images)         }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MediaLibrary;

interface

{$SCOPEDENUMS ON}
{$HPPEMIT LINKUNIT}
uses
  System.Types, System.Messaging, FMX.Types, FMX.Controls, FMX.Graphics;

type
  IFMXImageManagerService = interface;
  IFMXTakenImageService = interface;
  IFMXCameraService = interface;
  IFMXAudioManagerService = interface;
  IFMXTakenAudioService = interface;
  IFMXVideoManagerService = interface;
  IFMXPhotoLibrary = interface;

{$REGION 'Image manager services'}
  TImageOrientation = (Up, Right, Down, Left);

  /// <summary>Record that contains the geographical coordinates of the place
  /// where a photo is taken.</summary>
  TLocationInfo = record
    Latitude: Double;
    Longitude: Double;
  end;

  /// <summary>TImageInfo defines an image with meta information.</summary>
  TImageInfo = class abstract
  public
    // Image context
    function Bitmap: TBitmap; virtual; abstract;
    // Date of shooting of the photo
    function DateTaken: TDateTime; virtual; abstract;
    // Camera orientation at the moment of photo shooting
    function Orientation: TImageOrientation; virtual; abstract;
    // Geographical coordinates of a place of a picture 
    function LocationInfo: TLocationInfo; virtual; abstract;
  end;
  
  TImages = array of TImageInfo;

  /// <summary>Interface of images manager</summary>
  IFMXImageManagerService = interface (IInterface)
    ['{F06A5B8F-D4BC-4A0D-AD91-BF49208861E4}']
    // Returns the image on an index
    function GetImage(const Index: Integer): TImageInfo;
    // Returns all images from mobile store
    function GetAllImages: TImages;
    // Returns count of all images from mobile store
    function GetCount: Integer;
    // Insert image into mobile store
    procedure InsertImage(const Bitmap: TBitmap);
  end;

  { IFMXPhotoLibrary }

  /// <summary>Result of saving image to system photo library</summary>
  TWriteImageCompletionEvent = procedure (const ASaved: Boolean; const AResultMessage: string) of object;

  /// <summary>Saves image to System Photos Album</summary>
  IFMXPhotoLibrary = interface
    ['{D10DE62A-7398-4BC6-AA4C-AF5F4382BC46}']
    /// <summary>Adds specified image to photo album. When operation is completed, this method will cause
    /// <c>AWriteImageCompletionEvent</c> with results of saving</summary>
    procedure AddImageToSavedPhotosAlbum(const ABitmap: TBitmap; const AWriteImageCompletionEvent: TWriteImageCompletionEvent = nil);
  end;

  TOnDidCancelTaking = procedure of object;
  TOnDidFinishTaking = procedure (Image: TBitmap) of object;

  TMessageDidCancelTaking = class(TMessage);
  TMessageDidFinishTakingImageFromCamera = class(TMessage<TBitmap>);
  TMessageDidFinishTakingImageFromLibrary = class(TMessage<TBitmap>);

  /// <summary>TParamsPhotoQuery is a record that contains query information to
  /// take photos from the library, and from the camera.</summary>
  TParamsPhotoQuery = record
    /// <summary>Maximum required size of getting image</summary>
    RequiredResolution: TSize;
    /// <summary>Need edit image after getting or not?</summary>
    Editable: Boolean;
    /// <summary>Need to save got image to system photo library</summary>
    NeedSaveToAlbum: Boolean;
    /// <summary>Callback, which is called, when image is got from device</summary>
    OnDidFinishTaking: TOnDidFinishTaking;
    /// <summary>Callback, which is called, when user cancel process of getting image</summary>
    OnDidCancelTaking: TOnDidCancelTaking;
  end;

  /// <summary>Pick image from Photo Library. Call native UI picker</summary>
  IFMXTakenImageService = interface
    ['{5DADF207-B6CE-4C3A-9E0F-C45B39128DA5}']
    procedure TakeImageFromLibrary(const AControl: TControl; const ARequiredResolution: TSize; const AEditable: Boolean;
      const AOnDidFinishTaking: TOnDidFinishTaking; const AOnDidCancelTaking: TOnDidCancelTaking); overload;
        deprecated 'Use the similar method with another parameters';
    /// <summary>Sends request on getting photo from system Photo Library</summary>
    procedure TakeImageFromLibrary(const AControl: TControl; const AParams: TParamsPhotoQuery); overload;
  end;

  /// <summary>Get photo from device's camera</summary>
  IFMXCameraService = interface
    ['{6779963D-633A-4ED0-80C8-C71AB4E26D91}']
    procedure TakePhoto(const AControl: TControl; const ARequiredResolution: TSize; const AEditable: Boolean;
      const AOnDidFinishTaking: TOnDidFinishTaking; const AOnDidCancelTaking: TOnDidCancelTaking); overload;
        deprecated 'Use the similar method with another parameters';
    /// <summary>Sends request on getting photo from system camera</summary>
    procedure TakePhoto(const AControl: TControl; const AParams: TParamsPhotoQuery); overload;
  end;
{$ENDREGION}

{$REGION 'Audio manager services'}
  /// <summary>TMediaInfo is the base class to define media
  /// information.</summary>
  TMediaInfo = class (TObject);
  TPlayList = array of TMediaInfo;

  /// <summary>TAudioInfo defines an audio media file.</summary>
  TAudioInfo = class abstract (TMediaInfo)
  public
    function Title: string; virtual; abstract;
    function Artist: string; virtual; abstract;
    function AlbumTitle: string; virtual; abstract;
    function AlbumArtist: string; virtual; abstract;
    function Genre: string; virtual; abstract;
    function Composer: string; virtual; abstract;
    function Duration: TTime; virtual; abstract;
    function AlbumTrackNumber: Cardinal; virtual; abstract;
    function DiscNumber: Cardinal; virtual; abstract;
    function Lyrics: string; virtual; abstract;
    function DiscCover: TBitmap; virtual; abstract;
  end;
  TAudios = array of TAudioInfo;

  /// <summary>TAlbum defines an audio album.</summary>
  TAlbum = class abstract
  public
    function Title: string; virtual; abstract;
    function Artist: string; virtual; abstract;
    function NumberOfSongs: Cardinal; virtual; abstract;
    function Cover: TBitmap; virtual; abstract;
  end;
  TAlbums = array of TAlbum;

  /// <summary>TArtist defines a singer artist.</summary>
  TArtist = class abstract
  public
    function Artist: string; virtual; abstract;
    function NumberOfSongs: Integer; virtual; abstract;
  end;
  TArtists = array of TArtist;

  /// <summary>TGenre defines the genre for audio media files.</summary>
  TGenre = class abstract
  public
    function Genre: string; virtual; abstract;
    function CountSongs: Cardinal; virtual; abstract;
  end;
  TGenres = array of TGenre;

  /// <summary>Interface of audio manager</summary>
  IFMXAudioManagerService = interface (IInterface)
    ['{E2D6C4F8-F365-4E24-A461-C48288E4C710}']
    function GetAudio(const Index: Integer): TAudioInfo;
    function GetAudios: TAudios; overload;
    function GetAudios(const Album: TAlbum): TAudios; overload;
    function GetAudios(const Artist: TArtist): TAudios; overload;
    function GetAudios(const Genre: TGenre): TAudios; overload;
    function GetAlbums: TAlbums;
    function GetArtists: TArtists;
    function GetGenres: TGenres;
  end;

  /// <summary>Pick image from iPod Library. Uses native UI picker</summary>
  IFMXTakenAudioService = interface (IInterface)
    ['{7114C6A2-2A2A-4CDA-AB63-291C7C8D440E}']
    function GetAudioFromLibrary: TAudios;
  end;
{$ENDREGION}

{$REGION 'Video manager services'}
  /// <summary>TVideoInfo defines a video media file.</summary>
  TVideoInfo = class abstract(TMediaInfo)
  public
    function Title: string; virtual; abstract;
    function AlbumTitle: string; virtual; abstract;
    function Artist: string; virtual; abstract;
    function Duration: TTime; virtual; abstract;
    function Resolution: TSize; virtual; abstract;
    function Thumb: TBitmap; virtual; abstract;
  end;
  TVideos = array of TVideoInfo;

  /// <summary>Interface of video manager</summary>
  IFMXVideoManagerService = interface (IInterface)
    ['{C61ECA12-EF39-4FAF-A301-B8BA43F425BD}']
    function GetVideoFromLibrary: TVideos;
    function GetVideo(const Index: Integer): TVideoInfo;
    function GetAllVideos: TVideos; 
  end;
{$ENDREGION}

{$REGION 'Share Text and Image with other native services'}

  IFMXShareSheetActionsService = interface
  ['{79FCC7B1-C5BF-4533-B31E-084F1A6E2264}']
    procedure Share(const AControl: TControl; const AText: string; const AImage: TBitmap);
  end;

{$ENDREGION}

implementation

uses
{$IFDEF IOS}
  FMX.MediaLibrary.iOS,
{$ENDIF}
{$IFDEF ANDROID}
  FMX.MediaLibrary.Android,
{$ENDIF}
  System.TypInfo;

initialization
{$IF Defined(IOS) OR Defined(ANDROID)}
  RegisterMediaLibraryServices;
{$ENDIF}
end.
