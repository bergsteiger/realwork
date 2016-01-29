{**********************************************************}
{                                                          }
{           CodeGear Delphi Runtime Library                }
{                                                          }
{ Delphi-Objective-C Bridge                                }
{ Interfaces for Cocoa framework AssetsLibrary             }
{                                                          }
{ Copyright (c) 2010, Apple Inc. All rights reserved.      }
{                                                          }
{ Translator: Embarcadero Technologies, Inc.               }
{   Copyright(c) 2012-2013 Embarcadero Technologies, Inc.  }
{                                                          }
{**********************************************************}

unit iOSapi.AssetsLibrary;

interface

uses Macapi.ObjectiveC, iOSapi.CocoaTypes, iOSapi.Foundation, iOSapi.CoreGraphics;


// ===== External functions =====

const
  libAssetsLibrary = '/System/Library/Frameworks/AssetsLibrary.framework/AssetsLibrary';

  ALAssetOrientationUp = 0;
  ALAssetOrientationDown = 1;
  ALAssetOrientationLeft = 2;
  ALAssetOrientationRight = 3;
  ALAssetOrientationUpMirrored = 4;
  ALAssetOrientationDownMirrored = 5;
  ALAssetOrientationLeftMirrored = 6;
  ALAssetOrientationRightMirrored = 7;
  ALAssetsGroupLibrary = 1 shl 0;
  ALAssetsGroupAlbum = 1 shl 1;
  ALAssetsGroupEvent = 1 shl 2;
  ALAssetsGroupFaces = 1 shl 3;
  ALAssetsGroupSavedPhotos = 1 shl 4;
  ALAssetsGroupPhotoStream = 1 shl 5;
  ALAssetsGroupAll = $FFFFFFFF;
  ALAssetsLibraryUnknownError = -1;
  ALAssetsLibraryWriteFailedError = -3300;
  ALAssetsLibraryWriteBusyError = -3301;
  ALAssetsLibraryWriteInvalidDataError = -3302;
  ALAssetsLibraryWriteIncompatibleDataError = -3303;
  ALAssetsLibraryWriteDataEncodingError = -3304;
  ALAssetsLibraryWriteDiskSpaceError = -3305;
  ALAssetsLibraryDataUnavailableError = -3310;
  ALAssetsLibraryAccessUserDeniedError = -3311;
  ALAssetsLibraryAccessGloballyDeniedError = -3312;


// Typedefs and structs
{$M+}
type
  ALAssetsGroupType = NSUInteger;
  ALAssetOrientation = NSUInteger;
  NSEnumerationOptions = NSUInteger;

type
{$M+}
// ===== Forward declarations =====

  ALAsset = interface;
  ALAssetRepresentation = interface;
  ALAssetsFilter = interface;
  ALAssetsGroup = interface;
  ALAssetsLibrary = interface;

// ===== Interface declarations =====

  TALAssetsLibraryWriteImageCompletionBlock = procedure(assetURL: NSURL; error: NSError) of object;
  TALAssetsLibraryWriteVideoCompletionBlock = TALAssetsLibraryWriteImageCompletionBlock;
  ALAssetClass = interface(NSObjectClass)
    ['{CC79E0D9-CF57-4421-931A-6663290C5BB7}']
  end;
  ALAsset = interface(NSObject)
    ['{D4605158-C1DB-4B1A-9290-E97DB2AC8DE4}']
    function valueForProperty(prop: NSString): Pointer; cdecl;
    function defaultRepresentation: ALAssetRepresentation; cdecl;
    function representationForUTI(representationUTI: NSString): ALAssetRepresentation; cdecl;
    function thumbnail: CGImageRef; cdecl;
    function aspectRatioThumbnail: CGImageRef; cdecl;
    procedure writeModifiedImageDataToSavedPhotosAlbum(imageData: NSData; metadata: NSDictionary; completionBlock: TALAssetsLibraryWriteImageCompletionBlock); cdecl;
    procedure writeModifiedVideoAtPathToSavedPhotosAlbum(videoPathURL: NSURL; completionBlock: TALAssetsLibraryWriteVideoCompletionBlock); cdecl;
    function originalAsset: ALAsset; cdecl;
    function isEditable: Boolean; cdecl;
    procedure setImageData(imageData: NSData; metadata: NSDictionary; completionBlock: TALAssetsLibraryWriteImageCompletionBlock); cdecl;
    procedure setVideoAtPath(videoPathURL: NSURL; completionBlock: TALAssetsLibraryWriteVideoCompletionBlock); cdecl;
  end;
  TALAsset = class(TOCGenericImport<ALAssetClass, ALAsset>)  end;

  ALAssetRepresentationClass = interface(NSObjectClass)
    ['{1E006316-0C13-4E3B-99E1-59D6EAC567AF}']
  end;
  ALAssetRepresentation = interface(NSObject)
    ['{218F152C-1746-4343-A528-BAAA35A4B876}']
    function UTI: NSString; cdecl;
    function dimensions: CGSize; cdecl;
    function size: Int64; cdecl;
    function getBytes(buffer: PByte; fromOffset: Int64; length: NSUInteger; error: PNSError): NSUInteger; cdecl;
    function fullResultionImage: CGImageRef; cdecl;
    function CGImageWithOptions(options: NSDictionary): CGImageRef; cdecl;
    function url: NSURL; cdecl;
    function metadata: NSDictionary; cdecl;
    function orientation: ALAssetOrientation; cdecl;
    function scale: Single; cdecl;
    function filename: NSString; cdecl;
  end;
  TALAssetRepresentation = class(TOCGenericImport<ALAssetRepresentationClass, ALAssetRepresentation>)  end;

  ALAssetsFilterClass = interface(NSObjectClass)
    ['{7A435CEA-DFC1-4D83-BD21-7C6209DFB5C4}']
    {class} function allPhotos: ALAssetsFilter; cdecl;
    {class} function allVideos: ALAssetsFilter; cdecl;
    {class} function allAssets: ALAssetsFilter; cdecl;
  end;
  ALAssetsFilter = interface(NSObject)
    ['{5550DF06-FCB7-4C12-A1EA-050359A2FDA0}']
  end;
  TALAssetsFilterClass = class(TOCGenericImport<ALAssetsFilterClass, AlAssetsFilter>)  end;

  TALAssetsGroupEnumerationResultsBlock = procedure(result: ALAsset; index: NSUInteger; stop: PBoolean) of object;
  ALAssetsGroupClass = interface(NSObjectClass)
    ['{B771635F-9445-4B21-BC2E-5C6DD4DB299E}']
  end;
  ALAssetsGroup = interface(NSObject)
    ['{A1DF4E3A-DC2F-4C67-9030-BDB68D11757F}']
    function valueForProperty(prop: NSString): Pointer; cdecl;
    function posterImage: CGImageRef; cdecl;
    procedure setAssetsFilter(filter: ALAssetsFilter); cdecl;
    function numberOfAssets: NSInteger; cdecl;
    procedure enumerateAssetsUsingBlock(enumerationBlock: TALAssetsGroupEnumerationResultsBlock); cdecl;
    procedure enumerateAssetsWithOptions(options: NSEnumerationOptions; usingBlock: TALAssetsGroupEnumerationResultsBlock); cdecl;
    procedure enumerateAssetsAtIndexes(inetsSet: NSIndexSet; options: NSEnumerationOptions; usingBlock: TALAssetsGroupEnumerationResultsBlock); cdecl;
    function isEditable: Boolean; cdecl;
    function addAsset(asset: ALAsset): Boolean; cdecl;
  end;
  TALAssetsGroup = class(TOCGenericImport<ALAssetsGroupClass, ALAssetsGroup>)  end;

  TALAssetsLibraryGroupsEnumerationResultsBlock = procedure(group: ALAssetsGroup; stop: PBoolean) of object;
  TALAssetsLibraryAccessFailureBlock = procedure(error: NSError) of object;
  TALAssetsLibraryAssetForURLResultBlock = procedure(asset: ALAsset) of object;
  TALAssetsLibraryGroupResultBlock = procedure(group: ALAssetsGroup) of object;
  ALAssetsLibraryClass = interface(NSObjectClass)
    ['{5BFDC638-76DC-456A-B9A6-BC969F7FD4FB}']
  end;
  ALAssetsLibrary = interface(NSObject)
    ['{359971A2-64E4-4FAA-9FB4-4AE79B51F987}']
    procedure enumerateGroupsWithTypes(types: ALAssetsGroupType; usingBlock: TALAssetsLibraryGroupsEnumerationResultsBlock; failureBlock: TALAssetsLibraryAccessFailureBlock); cdecl;
    procedure assetForURL(assetURL: NSURL; resultBlock: TALAssetsLibraryAssetForURLResultBlock; failureBlock: TALAssetsLibraryAccessFailureBlock); cdecl;
    procedure groupForURL(groupURL: NSURL; resultBlock: TALAssetsLibraryGroupResultBlock; failureBlock: TALAssetsLibraryAccessFailureBlock); cdecl;
    procedure addAssetsGroupAlbumWithName(name: NSString; resultBlock: TALAssetsLibraryGroupResultBlock; failureBlock: TALAssetsLibraryAccessFailureBlock); cdecl;
    procedure writeImageToSavedPhotosAlbum(imageRef: CGImageRef; orientation: ALAssetOrientation; completionBlock: TALAssetsLibraryWriteImageCompletionBlock); cdecl; overload;
    procedure writeImageToSavedPhotosAlbum(imageRef: CGImageRef; metadata: NSDictionary; completionBlock: TALAssetsLibraryWriteImageCompletionBlock); cdecl; overload;
    procedure writeImageDataToSavedPhotosAlbum(imageData: NSData; metadata: NSDictionary; completionBlock: TALAssetsLibraryWriteImageCompletionBlock); cdecl;
    procedure writeVideoAtPathToSavedPhotosAlbum(videoPathURL: NSURL; completionBlock: TALAssetsLibraryWriteVideoCompletionBlock); cdecl;
    function videoAtPathIsCompatibleWithSavedPhotosAlbum(videoPathURL: NSURL): Boolean; cdecl;
  end;

// exported string consts


implementation

end.
