{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


type
  _statvfs = record
    f_bsize: Cardinal;      // File system block size
    f_frsize: Cardinal;     // Fundamental file system block size
    f_blocks: fsblkcnt_t;   // Blocks on FS in units of f_frsize
    f_bfree: fsblkcnt_t;    // Free blocks
    f_bavail: fsblkcnt_t;   // Blocks available to non-root
    f_files: fsfilcnt_t;    // Total inodes
    f_ffree: fsfilcnt_t;    // Free inodes
    f_favail: fsfilcnt_t;   // Free inodes for non-root
    f_fsid: Cardinal;       // Filesystem ID
    f_flag: Cardinal;       // Bit mask of values
    f_namemax: Cardinal;    // Max file name length
  end;
  {$EXTERNALSYM _statvfs}
  Pstatvfs = ^_statvfs;
  {$EXTERNALSYM Pstatvfs}

const
  ST_RDONLY = $00000001;    // Read-only file system
  {$EXTERNALSYM ST_RDONLY}
  ST_NOSUID = $00000002;    // Does not honor setuid/setgid
  {$EXTERNALSYM ST_NOSUID}
