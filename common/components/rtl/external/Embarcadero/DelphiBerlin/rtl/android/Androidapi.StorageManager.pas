{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.StorageManager;

interface

(*$HPPEMIT '#include <android/storage_manager.h>' *)

{$I Androidapi.inc}

const
  { The OBB container is now mounted and ready for use. Can be returned
    as the status for callbacks made during asynchronous OBB actions.
  }
  AOBB_STATE_MOUNTED = 1;
  {$EXTERNALSYM AOBB_STATE_MOUNTED}

  { The OBB container is now unmounted and not usable. Can be returned
    as the status for callbacks made during asynchronous OBB actions. }
  AOBB_STATE_UNMOUNTED = 2;
  {$EXTERNALSYM AOBB_STATE_UNMOUNTED}

  { There was an internal system error encountered while trying to
    mount the OBB. Can be returned as the status for callbacks made
    during asynchronous OBB actions. }
  AOBB_STATE_ERROR_INTERNAL = 20;
  {$EXTERNALSYM AOBB_STATE_ERROR_INTERNAL}

  { The OBB could not be mounted by the system. Can be returned as the
    status for callbacks made during asynchronous OBB actions. }
  AOBB_STATE_ERROR_COULD_NOT_MOUNT = 21;
  {$EXTERNALSYM AOBB_STATE_ERROR_COULD_NOT_MOUNT}

  { The OBB could not be unmounted. This most likely indicates that a
    file is in use on the OBB. Can be returned as the status for
    callbacks made during asynchronous OBB actions. }
  AOBB_STATE_ERROR_COULD_NOT_UNMOUNT = 22;
  {$EXTERNALSYM AOBB_STATE_ERROR_COULD_NOT_UNMOUNT}

  { A call was made to unmount the OBB when it was not mounted. Can be
    returned as the status for callbacks made during asynchronous OBB
    actions. }
  AOBB_STATE_ERROR_NOT_MOUNTED = 23;
  {$EXTERNALSYM AOBB_STATE_ERROR_NOT_MOUNTED}

  { The OBB has already been mounted. Can be returned as the status for
    callbacks made during asynchronous OBB actions. }
  AOBB_STATE_ERROR_ALREADY_MOUNTED = 24;
  {$EXTERNALSYM AOBB_STATE_ERROR_ALREADY_MOUNTED}

  { The current application does not have permission to use this OBB.
    This could be because the OBB indicates it's owned by a different
    package. Can be returned as the status for callbacks made during
    asynchronous OBB actions. }
  AOBB_STATE_ERROR_PERMISSION_DENIED = 25;
  {$EXTERNALSYM AOBB_STATE_ERROR_PERMISSION_DENIED}


type
  AStorageManager = record end;
  {$EXTERNALSYM AStorageManager}

  PAStorageManager = ^AStorageManager;

  AStorageManager_obbCallbackFunc = procedure(const Filename: MarshaledAString; const State: Int32; Data: Pointer);
  {$EXTERNALSYM AStorageManager_obbCallbackFunc}

  TAStorageManager_obbCallbackFunc = AStorageManager_obbCallbackFunc;
 

{ Obtains a new instance of AStorageManager. }
function AStorageManager_new: PAStorageManager; cdecl;
  external AndroidLib name 'AStorageManager_new';
{$EXTERNALSYM AStorageManager_new}

{ Release AStorageManager instance. }
procedure AStorageManager_delete(StorageManager: PAStorageManager); cdecl;
  external AndroidLib name 'AStorageManager_delete';
{$EXTERNALSYM AStorageManager_delete}


{ Attempts to mount an OBB file. This is an asynchronous operation. }
procedure AStorageManager_mountObb(StorageManager: PAStorageManager; const Filename: MarshaledAString; const Key: MarshaledAString;
        CallbackFunction: AStorageManager_obbCallbackFunc; Data: Pointer); cdecl;
  external AndroidLib name 'AStorageManager_mountObb';
{$EXTERNALSYM AStorageManager_mountObb}

{ Attempts to unmount an OBB file. This is an asynchronous operation. }
procedure AStorageManager_unmountObb(StorageManager: PAStorageManager; const Filename: MarshaledAString; const Force: Integer;
        CallbackFunction: AStorageManager_obbCallbackFunc; Data: Pointer);
  external AndroidLib name 'AStorageManager_unmountObb';
{$EXTERNALSYM AStorageManager_unmountObb}

{ Check whether an OBB is mounted. }
function AStorageManager_isObbMounted(StorageManager: PAStorageManager; const Filename: MarshaledAString): Integer; cdecl;
  external AndroidLib name 'AStorageManager_isObbMounted';
{$EXTERNALSYM AStorageManager_isObbMounted}

{ Get the mounted path for an OBB. }
function AStorageManager_getMountedObbPath(StorageManager: PAStorageManager; const Filename: MarshaledAString): MarshaledAString; cdecl;
  external AndroidLib name 'AStorageManager_getMountedObbPath';
{$EXTERNALSYM AStorageManager_getMountedObbPath}

implementation

end.
