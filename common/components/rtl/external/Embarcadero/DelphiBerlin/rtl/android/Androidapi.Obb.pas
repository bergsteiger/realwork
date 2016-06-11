{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Obb;

interface

uses Posix.SysTypes;

(*$HPPEMIT '#include <android/obb.h>' *)

{$I Androidapi.inc}

const
  AOBBINFO_OVERLAY = $0001;
  {$EXTERNALSYM AOBBINFO_OVERLAY}

type
  AObbInfo = record end;
  {$EXTERNALSYM AObbInfo}
  
  PAObbInfo = ^AObbInfo;


{ Scan an OBB and get information about it. }
function AObbScanner_getObbInfo(const FileName: MarshaledAString): PAObbInfo; cdecl;
  external AndroidLib name 'AObbScanner_getObbInfo';
{$EXTERNALSYM AObbScanner_getObbInfo}

{ Destroy the AObbInfo object. You must call this when finished with the object. }
procedure AObbInfo_delete(ObbInfo: PAObbInfo); cdecl;
  external AndroidLib name 'AObbInfo_delete';
{$EXTERNALSYM AObbInfo_delete}

{ Get the package name for the OBB. }
function AObbInfo_getPackageName(ObbInfo: PAObbInfo): MarshaledAString; cdecl;
  external AndroidLib name 'AObbInfo_getPackageName';
{$EXTERNALSYM AObbInfo_getPackageName}

{ Get the version of an OBB file. }
function AObbInfo_getVersion(ObbInfo: PAObbInfo): Int32; cdecl;
  external AndroidLib name 'AObbInfo_getVersion';
{$EXTERNALSYM AObbInfo_getVersion}

{ Get the flags of an OBB file. }

function AObbInfo_getFlags(ObbInfo: PAObbInfo): Int32; cdecl;
  external AndroidLib name 'AObbInfo_getFlags';
{$EXTERNALSYM AObbInfo_getFlags}


implementation

end.
