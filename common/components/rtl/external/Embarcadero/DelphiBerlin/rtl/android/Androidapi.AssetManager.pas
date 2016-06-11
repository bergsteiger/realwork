{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.AssetManager;

interface

uses Posix.StdDef, Posix.SysTypes;

(*$HPPEMIT '#include <android/asset_manager.h>' *)

{$I Androidapi.inc}

{ Available modes for opening assets }
const
  AASSET_MODE_UNKNOWN   = 0;
  {$EXTERNALSYM AASSET_MODE_UNKNOWN}
  AASSET_MODE_RANDOM    = 1;
  {$EXTERNALSYM AASSET_MODE_RANDOM}
  AASSET_MODE_STREAMING = 2;
  {$EXTERNALSYM AASSET_MODE_STREAMING}
  AASSET_MODE_BUFFER    = 3;
  {$EXTERNALSYM AASSET_MODE_BUFFER}

type
  AAssetManager = record end;
  {$EXTERNALSYM AAssetManager}
  PAAssetManager = ^AAssetManager;

  AAssetDir = record end;
  {$EXTERNALSYM AAssetDir}
  PAAssetDir = ^AAssetDir;

  AAsset = record end;
  {$EXTERNALSYM AAsset}
  PAAsset = ^AAsset;


{ Open the named directory within the asset hierarchy.  The directory can then
  be inspected with the AAssetDir functions.  To open the top-level directory,
  pass in "" as the dirName.
  
  The object returned here should be freed by calling AAssetDir_close().
}
function AAssetManager_openDir(AssetManager: PAAssetManager; const DirectoryName: MarshaledAString): PAAssetDir; cdecl;
  external AndroidLib name 'AAssetManager_openDir'
{$EXTERNALSYM AAssetManager_openDir}

{ Open an asset.
  The object returned here should be freed by calling AAsset_close().
 }
function AAssetManager_open(AssetManager: PAAssetManager; const FileName: MarshaledAString; Mode: Integer): PAAsset; cdecl;
  external AndroidLib name 'AAssetManager_open'
{$EXTERNALSYM AAssetManager_open}

{ Iterate over the files in an asset directory.  A NULL string is returned
  when all the file names have been returned.
 
  The returned file name is suitable for passing to AAssetManager_open().
 
  The string returned here is owned by the AssetDir implementation and is not
  guaranteed to remain valid if any other calls are made on this AAssetDir
  instance.
}
function AAssetDir_getNextFileName(AssetDirectory: PAAssetDir): MarshaledAString; cdecl;
  external AndroidLib name 'AAssetDir_getNextFileName'
{$EXTERNALSYM AAssetDir_getNextFileName}

{ Reset the iteration state of AAssetDir_getNextFileName() to the beginning.
}
procedure AAssetDir_rewind(AssetDirectory: PAAssetDir); cdecl;
  external AndroidLib name 'AAssetDir_rewind'
{$EXTERNALSYM AAssetDir_rewind}

{ Close an opened AAssetDir, freeing any related resources.
}
procedure AAssetDir_close(AssetDirectory: PAAssetDir); cdecl;
  external AndroidLib name 'AAssetDir_close'
{$EXTERNALSYM AAssetDir_close}

{ Attempt to read 'count' bytes of data from the current offset.
 
  Returns the number of bytes read, zero on EOF, or < 0 on error.
}
function AAsset_read(Asset: PAAsset; Buffer: Pointer; Count: size_t): Integer; cdecl;
  external AndroidLib name 'AAsset_read'
{$EXTERNALSYM AAsset_read}

{ Seek to the specified offset within the asset data.  'whence' uses the
  same constants as lseek()/fseek().
 
  Returns the new position on success, or (off_t) -1 on error.
}
function AAsset_seek(Asset: PAAsset; Offset: off_t; Whence: Integer): off_t; cdecl;
  external AndroidLib name 'AAsset_seek'
{$EXTERNALSYM AAsset_seek}

{ Close the asset, freeing all associated resources.
}
procedure AAsset_close(Asset: PAAsset); cdecl;
  external AndroidLib name 'AAsset_close'
{$EXTERNALSYM AAsset_close}

{ Get a pointer to a buffer holding the entire contents of the assset.
  
  Returns nil on failure.
}
function AAsset_getBuffer(Asset: PAAsset): Pointer; cdecl;
  external AndroidLib name 'AAsset_getBuffer'
{$EXTERNALSYM AAsset_getBuffer}

{ Report the total size of the asset data.
}
function AAsset_getLength(Asset: PAAsset): off_t; cdecl;
  external AndroidLib name 'AAsset_getLength'
{$EXTERNALSYM AAsset_getLength}

{ Report the total amount of asset data that can be read from the current position.
}
function AAsset_getRemainingLength(Asset: PAAsset): off_t; cdecl;
  external AndroidLib name 'AAsset_getRemainingLength'
{$EXTERNALSYM AAsset_getRemainingLength}

{ Open a new file descriptor that can be used to read the asset data.
 
  Returns < 0 if direct fd access is not possible (for example, if the asset is
  compressed).
}
function AAsset_openFileDescriptor(Asset: PAAsset; OutStart, PutLength: Poff_t): Integer; cdecl;
  external AndroidLib name 'AAsset_openFileDescriptor'
{$EXTERNALSYM AAsset_openFileDescriptor}

{ Returns whether this asset's internal buffer is allocated in ordinary RAM (i.e. not
  mmapped).
}
function AAsset_isAllocated(asset: PAAsset): Integer; cdecl;
  external AndroidLib name 'AAsset_isAllocated'
{$EXTERNALSYM AAsset_isAllocated}

implementation

end.
