{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
{$ALIGN 4}
  _stat = record
    st_dev: dev_t;         // device
    st_mode: mode_t;       // protection
    st_nlink: nlink_t;     // number of hard links
    st_ino: UInt64;        // inode ino64_t
    st_uid: uid_t;         // user ID of owner
    st_gid: gid_t;         // group ID of owner
    st_rdev: dev_t;        // device type (if inode device)
    st_atime: time_t;      // time of last access
    st_atimensec: Int32;
    st_mtime: time_t;      // time of last modification
    st_mtimensec: Int32;
    st_ctime: time_t;      // time of last change
    st_ctimensec: Int32;
    st_birthtime: time_t;  // file creation time
    st_birthtimensec: Int32;

    st_size: off_t;        // total size, in bytes
    st_blocks: blkcnt_t;   // number of blocks allocated
    st_blksize: blksize_t; // blocksize for filesystem I/O

    st_flags: UInt32;      // user defined flags for file
    st_gen: UInt32;        // file generation number

    __unused1: Int32;
    __unused2: Int64;
    __unused3: Int64;
  end;
  {$EXTERNALSYM _stat}
  P_stat = ^_stat;
{$ALIGN ON}

const
{ File type }
  S_IFMT       = $0000F000;   // [XSI] type of file mask
  {$EXTERNALSYM S_IFMT  }
  S_IFIFO      = $00001000;   // [XSI] named pipe (fifo)
  {$EXTERNALSYM S_IFIFO }
  S_IFCHR      = $00002000;   // [XSI] character special
  {$EXTERNALSYM S_IFCHR }
  S_IFDIR      = $00004000;   // [XSI] directory
  {$EXTERNALSYM S_IFDIR }
  S_IFBLK      = $00006000;   // [XSI] block special
  {$EXTERNALSYM S_IFBLK }
  S_IFREG      = $00008000;   // [XSI] regular
  {$EXTERNALSYM S_IFREG }
  S_IFLNK      = $0000A000;   // [XSI] symbolic link
  {$EXTERNALSYM S_IFLNK }
  S_IFSOCK     = $0000C000;   // [XSI] socket
  {$EXTERNALSYM S_IFSOCK}
  S_IFWHT      = $0000E000;   // whiteout
  {$EXTERNALSYM S_IFWHT }

{ File mode }
  // Read, write, execute/search by owner
  S_IRWXU      = $000001C0;   // [XSI] RWX mask for owner
  {$EXTERNALSYM S_IRWXU }
  S_IRUSR      = $00000100;   // [XSI] R for owner
  {$EXTERNALSYM S_IRUSR }
  S_IWUSR      = $00000080;   // [XSI] W for owner
  {$EXTERNALSYM S_IWUSR }
  S_IXUSR      = $00000040;   // [XSI] X for owner
  {$EXTERNALSYM S_IXUSR }

  // Read, write, execute/search by group
  S_IRWXG      = $00000038;   // [XSI] RWX mask for group
  {$EXTERNALSYM S_IRWXG }
  S_IRGRP      = $00000020;   // [XSI] R for group
  {$EXTERNALSYM S_IRGRP }
  S_IWGRP      = $00000010;   // [XSI] W for group
  {$EXTERNALSYM S_IWGRP }
  S_IXGRP      = $00000008;   // [XSI] X for group
  {$EXTERNALSYM S_IXGRP }

  // Read, write, execute/search by others
  S_IRWXO      = $00000007;   // [XSI] RWX mask for other
  {$EXTERNALSYM S_IRWXO }
  S_IROTH      = $00000004;   // [XSI] R for other
  {$EXTERNALSYM S_IROTH }
  S_IWOTH      = $00000002;   // [XSI] W for other
  {$EXTERNALSYM S_IWOTH }
  S_IXOTH      = $00000001;   // [XSI] X for other
  {$EXTERNALSYM S_IXOTH }

  S_ISUID      = $00000800;   // [XSI] set user id on execution
  {$EXTERNALSYM S_ISUID }
  S_ISGID      = $00000400;   // [XSI] set group id on execution
  {$EXTERNALSYM S_ISGID }
  S_ISVTX      = $00000200;   // [XSI] directory restricted delete
  {$EXTERNALSYM S_ISVTX }

  S_ISTXT      = S_ISVTX;     // sticky bit: not supported
  {$EXTERNALSYM S_ISTXT }
  S_IREAD      = S_IRUSR;     // backward compatability
  {$EXTERNALSYM S_IREAD }
  S_IWRITE     = S_IWUSR;     // backward compatability
  {$EXTERNALSYM S_IWRITE}
  S_IEXEC      = S_IXUSR;     // backward compatability
  {$EXTERNALSYM S_IEXEC }
