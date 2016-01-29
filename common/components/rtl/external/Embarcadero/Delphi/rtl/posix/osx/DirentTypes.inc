{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

const
//  NAME_MAX = 255;
  NAME_MAX = 1024;
  {$EXTERNALSYM NAME_MAX}

type
  dirent = record
    d_ino: UInt64;
    d_seekoff: UInt64;
    d_reclen: Word platform;
    d_namelen: Word platform;
    d_type: Byte platform;
    d_name: array [0..NAME_MAX - 1] of Byte;
  end;
  {$EXTERNALSYM dirent}
  Pdirent = ^dirent;
  PPdirent = ^Pdirent;

{ This is the data type of directory stream objects.
   The actual structure is opaque to users.  }
   //TODO: Why are we hiding DIRs members from users? 
type
  __dirstream = {packed} record end; // Opaque record.
  //{$EXTERNALSYM __dirstream}
  DIR = __dirstream;
  //{$EXTERNALSYM DIR}
  PDIR = ^DIR;
type 
  TSelectorProc = function(const p1: Pdirent): Integer; cdecl;
  TCompareProc = function(const p1, p2: Pdirent): Integer; cdecl;

