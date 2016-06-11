{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

type

  pad4_t = array [0..3] of byte;
  {$EXTERNALSYM pad4_t}
  Ppad4_t = ^pad4_t;
  {$EXTERNALSYM Ppad4_t}

  _stat = record
    st_dev: UInt64;          // device
    __pad0:	pad4_t;

    __st_ino: UInt32;
    st_mode: UInt32;        // protection
    st_nlink: UInt32;       //  number of hard links

    st_uid: uid_t;          // user ID of owner
    st_gid: gid_t;          // group ID of owner

    st_rdev: UInt64;        // device type (if inode device)
    __pad3: pad4_t;

    st_size: Int64;         // total size, in bytes
    st_blksize: Int32;      // blocksize for filesystem I/O
    st_blocks: UInt64;      // number of blocks allocated

    st_atime: UInt32;       // time of last access
    st_atime_nsec : UInt32;

    st_mtime: UInt32;       // time of last modification
    st_mtimensec: UInt32;

    st_ctime: UInt32;       // time of last change
    st_ctimensec: UInt32;

    st_ino: UInt64;

  end;
  {$EXTERNALSYM _stat}
  P_stat = ^_stat;

const
{ File type }
  S_IFMT       = $0000F000;   // [XSI] type of file mask
  {$EXTERNALSYM S_IFMT}
  S_IFSOCK     = $0000c000;   // [XSI] socket
  {$EXTERNALSYM S_IFSOCK}
  S_IFLNK      = $0000a000;   // [XSI] symbolic link
  {$EXTERNALSYM S_IFLNK}
  S_IFREG      = $00008000;   // [XSI] regular
  {$EXTERNALSYM S_IFREG}
  S_IFBLK      = $00006000;   // [XSI] block special
  {$EXTERNALSYM S_IFBLK}
  S_IFDIR      = $00004000;   // [XSI] directory
  {$EXTERNALSYM S_IFDIR}
  S_IFCHR      = $00002000;   // [XSI] character special
  {$EXTERNALSYM S_IFCHR}
  S_IFIFO      = $00001000;   // [XSI] named pipe (fifo)
  {$EXTERNALSYM S_IFIFO}
  S_ISUID      = $00000800;
  {$EXTERNALSYM S_ISUID}
  S_ISGID      = $00000400;
  {$EXTERNALSYM S_ISGID}
  S_ISVTX      = $00000200;
  {$EXTERNALSYM S_ISVTX}

  S_IRWXU       = $01C0;
  {$EXTERNALSYM S_IRWXU}
  S_IRUSR       = $0100;
  {$EXTERNALSYM S_IRUSR}
  S_IWUSR       = $0080;
  {$EXTERNALSYM S_IWUSR}
  S_IXUSR       = $0040;
  {$EXTERNALSYM S_IXUSR}

  S_IRWXG       = $0038; // Read, write, and execute by group.
  {$EXTERNALSYM S_IRWXG}
  S_IRGRP       = $0020; // Read by group.
  {$EXTERNALSYM S_IRGRP}
  S_IWGRP       = $0010; // Write by group.
  {$EXTERNALSYM S_IWGRP}
  S_IXGRP       = $0008; // Execute by group.
  {$EXTERNALSYM S_IXGRP}

  S_IRWXO       = $0007; // Read, write, and execute by others.
  {$EXTERNALSYM S_IRWXO}
  S_IROTH       = $0004; // Read by others.
  {$EXTERNALSYM S_IROTH}
  S_IWOTH       = $0002; // Write by others.
  {$EXTERNALSYM S_IWOTH}
  S_IXOTH       = $0001; // Execute by others.
  {$EXTERNALSYM S_IXOTH}

