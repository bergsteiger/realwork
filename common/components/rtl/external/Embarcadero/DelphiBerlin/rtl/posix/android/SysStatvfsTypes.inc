{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

type
  _statvfs = record// Renamed from statvfs to avoid identifer conflict
    f_bsize: LongWord;
    f_frsize: LongWord;
    f_blocks: fsblkcnt_t;
    f_bfree: fsblkcnt_t;
    f_bavail: fsblkcnt_t;
    f_files: fsfilcnt_t;
    f_ffree: fsfilcnt_t;
    f_favail: fsfilcnt_t;
    f_fsid: LongWord;
    f_flag: LongWord;
    f_namemax: LongWord;
    __f_spare: packed array[0..6-1] of Integer;
  end;
  {$EXTERNALSYM _statvfs}
  Pstatvfs = ^_statvfs;

  _statvfs64 = record // Renamed from statvfs64 to avoid identifer conflict
    f_bsize: LongWord;
    f_frsize: LongWord;
    f_blocks: fsblkcnt64_t;
    f_bfree: fsblkcnt64_t;
    f_bavail: fsblkcnt64_t;
    f_files: fsfilcnt64_t;
    f_ffree: fsfilcnt64_t;
    f_favail: fsfilcnt64_t;
    f_fsid: LongWord;
    f_flag: LongWord;
    f_namemax: LongWord;
    __f_spare: packed array[0..6-1] of Integer;
  end;
  {$EXTERNALSYM _statvfs64}
  Pstatvfs64 = ^_statvfs64;

const
  ST_RDONLY = 1;                { Mount read-only.  }
  {$EXTERNALSYM ST_RDONLY}
  ST_NOSUID = 2;                { Ignore suid and sgid bits.  }
  {$EXTERNALSYM ST_NOSUID}
  ST_NODEV = 4 platform;        { Disallow access to device special files.  }
  {$EXTERNALSYM ST_NODEV}
  ST_NOEXEC = 8 platform;       { Disallow program execution.  }
  {$EXTERNALSYM ST_NOEXEC}
  ST_SYNCHRONOUS = 16 platform; { Writes are synced at once.  }
  {$EXTERNALSYM ST_SYNCHRONOUS}
  ST_MANDLOCK = 64 platform;    { Allow mandatory locks on an FS.  }
  {$EXTERNALSYM ST_MANDLOCK}
  ST_WRITE = 128 platform;      { Write on file/directory/symlink.  }
  {$EXTERNALSYM ST_WRITE}
  ST_APPEND = 256 platform;     { Append-only file.  }
  {$EXTERNALSYM ST_APPEND}
  ST_IMMUTABLE = 512 platform;  { Immutable file.  }
  {$EXTERNALSYM ST_IMMUTABLE}
  ST_NOATIME = 1024 platform;   { Do not update access times.  }
  {$EXTERNALSYM ST_NOATIME}
  ST_NODIRATIME = 2048 platform;{ Do not update directory access times.  }
  {$EXTERNALSYM ST_NODIRATIME}
  ST_RELATIME = 4096 platform;  { Update atime relative to mtime/ctime. }
  {$EXTERNALSYM ST_RELATIME}
