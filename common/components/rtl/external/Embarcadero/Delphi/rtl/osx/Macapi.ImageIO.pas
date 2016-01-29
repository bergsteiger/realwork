{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework ImageIO 
//
unit Macapi.ImageIO;

{$WEAKPACKAGEUNIT}

interface

uses
  Macapi.CocoaTypes,
  Macapi.CoreFoundation;

const
  kCGImageStatusComplete = 0;
  kCGImageStatusIncomplete = -1;
  kCGImageStatusInvalidData = -4;
  kCGImageStatusReadingHeader = -2;
  kCGImageStatusUnexpectedEOF = -5;
  kCGImageStatusUnknownType = -3;

// ===== External functions =====

const
  libImageIO = '/System/Library/Frameworks/ApplicationServices.framework/Frameworks/ImageIO.framework/ImageIO';

procedure CGImageDestinationAddImage(idst: CGImageDestinationRef; image: CGImageRef; properties: CFDictionaryRef); cdecl; external libImageIO name _PU + 'CGImageDestinationAddImage';
procedure CGImageDestinationAddImageFromSource(idst: CGImageDestinationRef; isrc: CGImageSourceRef; index: Longword; properties: CFDictionaryRef); cdecl; external libImageIO name _PU + 'CGImageDestinationAddImageFromSource';
function CGImageDestinationCopyTypeIdentifiers: CFArrayRef; cdecl; external libImageIO name _PU + 'CGImageDestinationCopyTypeIdentifiers';
function CGImageDestinationCreateWithData(data: CFMutableDataRef; type_: CFStringRef; count: Longword; options: CFDictionaryRef): CGImageDestinationRef; cdecl; external libImageIO name _PU + 'CGImageDestinationCreateWithData';
function CGImageDestinationCreateWithDataConsumer(consumer: CGDataConsumerRef; type_: CFStringRef; count: Longword; options: CFDictionaryRef): CGImageDestinationRef; cdecl; external libImageIO name _PU + 'CGImageDestinationCreateWithDataConsumer';
function CGImageDestinationCreateWithURL(url: CFURLRef; type_: CFStringRef; count: Longword; options: CFDictionaryRef): CGImageDestinationRef; cdecl; external libImageIO name _PU + 'CGImageDestinationCreateWithURL';
function CGImageDestinationFinalize(idst: CGImageDestinationRef): Integer; cdecl; external libImageIO name _PU + 'CGImageDestinationFinalize';
function CGImageDestinationGetTypeID: CFTypeID; cdecl; external libImageIO name _PU + 'CGImageDestinationGetTypeID';
procedure CGImageDestinationSetProperties(idst: CGImageDestinationRef; properties: CFDictionaryRef); cdecl; external libImageIO name _PU + 'CGImageDestinationSetProperties';
function CGImageSourceCopyProperties(isrc: CGImageSourceRef; options: CFDictionaryRef): CFDictionaryRef; cdecl; external libImageIO name _PU + 'CGImageSourceCopyProperties';
function CGImageSourceCopyPropertiesAtIndex(isrc: CGImageSourceRef; index: Longword; options: CFDictionaryRef): CFDictionaryRef; cdecl; external libImageIO name _PU + 'CGImageSourceCopyPropertiesAtIndex';
function CGImageSourceCopyTypeIdentifiers: CFArrayRef; cdecl; external libImageIO name _PU + 'CGImageSourceCopyTypeIdentifiers';
function CGImageSourceCreateImageAtIndex(isrc: CGImageSourceRef; index: Longword; options: CFDictionaryRef): CGImageRef; cdecl; external libImageIO name _PU + 'CGImageSourceCreateImageAtIndex';
function CGImageSourceCreateIncremental(options: CFDictionaryRef): CGImageSourceRef; cdecl; external libImageIO name _PU + 'CGImageSourceCreateIncremental';
function CGImageSourceCreateThumbnailAtIndex(isrc: CGImageSourceRef; index: Longword; options: CFDictionaryRef): CGImageRef; cdecl; external libImageIO name _PU + 'CGImageSourceCreateThumbnailAtIndex';
function CGImageSourceCreateWithData(data: CFDataRef; options: CFDictionaryRef): CGImageSourceRef; cdecl; external libImageIO name _PU + 'CGImageSourceCreateWithData';
function CGImageSourceCreateWithDataProvider(provider: CGDataProviderRef; options: CFDictionaryRef): CGImageSourceRef; cdecl; external libImageIO name _PU + 'CGImageSourceCreateWithDataProvider';
function CGImageSourceCreateWithURL(url: CFURLRef; options: CFDictionaryRef): CGImageSourceRef; cdecl; external libImageIO name _PU + 'CGImageSourceCreateWithURL';
function CGImageSourceGetCount(isrc: CGImageSourceRef): Longword; cdecl; external libImageIO name _PU + 'CGImageSourceGetCount';
function CGImageSourceGetStatus(isrc: CGImageSourceRef): CGImageSourceStatus; cdecl; external libImageIO name _PU + 'CGImageSourceGetStatus';
function CGImageSourceGetStatusAtIndex(isrc: CGImageSourceRef; index: Longword): CGImageSourceStatus; cdecl; external libImageIO name _PU + 'CGImageSourceGetStatusAtIndex';
function CGImageSourceGetType(isrc: CGImageSourceRef): CFStringRef; cdecl; external libImageIO name _PU + 'CGImageSourceGetType';
function CGImageSourceGetTypeID: CFTypeID; cdecl; external libImageIO name _PU + 'CGImageSourceGetTypeID';
procedure CGImageSourceUpdateData(isrc: CGImageSourceRef; data: CFDataRef; final: Integer); cdecl; external libImageIO name _PU + 'CGImageSourceUpdateData';
procedure CGImageSourceUpdateDataProvider(isrc: CGImageSourceRef; provider: CGDataProviderRef; final: Integer); cdecl; external libImageIO name _PU + 'CGImageSourceUpdateDataProvider';

implementation
end.
