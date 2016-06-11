{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


type 
  socklen_t = UInt32;
  {$EXTERNALSYM socklen_t}
  Psocklen_t = ^socklen_t;

  sa_family_t = Word;
  {$EXTERNALSYM sa_family_t}
  Psa_family_t = ^sa_family_t;

  msghdr = record
    msg_name: Pointer;                  // Address to send to/receive from.
    msg_namelen: Integer;               // Length of address data.

    msg_iov: Piovec;                    // Vector of data to send/receive into.
    msg_iovlen: size_t;                 // Number of elements in the vector.

    msg_control: Pointer;               // Ancillary data (eg BSD filedesc passing).
    msg_controllen: size_t;             // Ancillary data buffer length.

    msg_flags: UInt32;	                // Flags on received message.
  end;
  {$EXTERNALSYM msghdr}
  Pmsghdr = ^msghdr;


  cmsghdr = record
    cmsg_len: size_t;
    cmsg_level: Integer;
    cmsg_type: Integer;
  end;
  {$EXTERNALSYM cmsghdr}
  Pcmsghdr = ^cmsghdr;

  linger = record
    l_onoff: Integer;
    l_linger: Integer;
  end;
  {$EXTERNALSYM linger}
  PLinger = ^linger;

const

  SOCK_STREAM     = 1;
  {$EXTERNALSYM SOCK_STREAM}
  SOCK_DGRAM      = 2;
  {$EXTERNALSYM SOCK_DGRAM}
  SOCK_RAW        = 3;
  {$EXTERNALSYM SOCK_RAW}
  SOCK_RDM        = 4;
  {$EXTERNALSYM SOCK_RDM}
  SOCK_SEQPACKET  = 5;
  {$EXTERNALSYM SOCK_SEQPACKET}

  SOL_SOCKET      = $1;
  {$EXTERNALSYM SOL_SOCKET}

  SO_DEBUG      = 1;
  {$EXTERNALSYM SO_DEBUG}
  SO_REUSEADDR  = 2;
  {$EXTERNALSYM SO_REUSEADDR}
  SO_TYPE       = 3;
  {$EXTERNALSYM SO_TYPE}
  SO_ERROR      = 4;
  {$EXTERNALSYM SO_ERROR}
  SO_DONTROUTE  = 5;
  {$EXTERNALSYM SO_DONTROUTE}
  SO_BROADCAST  = 6;
  {$EXTERNALSYM SO_BROADCAST}
  SO_SNDBUF     = 7;
  {$EXTERNALSYM SO_SNDBUF}
  SO_RCVBUF     = 8;
  {$EXTERNALSYM SO_RCVBUF}
  SO_KEEPALIVE  = 9;
  {$EXTERNALSYM SO_KEEPALIVE}
  SO_OOBINLINE  = 10;
  {$EXTERNALSYM SO_OOBINLINE}
  SO_LINGER     = 13;
  {$EXTERNALSYM SO_LINGER}
  SO_RCVLOWAT   = 18;
  {$EXTERNALSYM SO_RCVLOWAT}
  SO_SNDLOWAT   = 19;
  {$EXTERNALSYM SO_SNDLOWAT}
  SO_RCVTIMEO   = 20;
  {$EXTERNALSYM SO_RCVTIMEO}
  SO_SNDTIMEO   = 21;
  {$EXTERNALSYM SO_SNDTIMEO}
  SO_ACCEPTCONN = 30;
  {$EXTERNALSYM SO_ACCEPTCONN}


  SOMAXCONN       = 128;
  {$EXTERNALSYM SOMAXCONN}

type

  sockaddr = record
    sa_family: sa_family_t;
    sa_data: packed array[0..13] of Byte;
  end;
  {$EXTERNALSYM sockaddr}
  Psockaddr = ^sockaddr;

  __ss_aligntype = UInt32;
  {$EXTERNALSYM __ss_aligntype}

const
  _SS_SIZE = 128;
  {$EXTERNALSYM _SS_SIZE}
  _SS_PADSIZE = _SS_SIZE - (2 * SizeOf(__ss_aligntype));
  {$EXTERNALSYM _SS_PADSIZE}

type
  sockaddr_storage = record
    ss_family: sa_family_t;
    ss_align: UInt32;
    ss_padding: array [0.._SS_PADSIZE-1] of Byte;
  end;
  {$EXTERNALSYM sockaddr_storage}
  Psockaddr_storage = ^sockaddr_storage;

const
  { Bits in the FLAGS argument to `send', `recv', et al. }
  MSG_OOB       = $01;                  // Process out-of-band data.
  {$EXTERNALSYM MSG_OOB}
  MSG_PEEK      = $02;                  // Peek at incoming messages.
  {$EXTERNALSYM MSG_PEEK}
  MSG_DONTROUTE = $04;                  // Don't use local routing.
  {$EXTERNALSYM MSG_DONTROUTE}
  MSG_CTRUNC    = $08;                  // Control data lost before delivery.
  {$EXTERNALSYM MSG_CTRUNC}
  MSG_TRUNC     = $20;
  {$EXTERNALSYM MSG_TRUNC}
  MSG_EOR       = $80;                  // End of record.
  {$EXTERNALSYM MSG_EOR}
  MSG_WAITALL   = $100;                 // Wait for a full request.
  {$EXTERNALSYM MSG_WAITALL}
  MSG_NOSIGNAL  = $4000 platform;      // Do not generate SIGPIPE.
  {$EXTERNALSYM MSG_NOSIGNAL}

  { Address families. }
  AF_UNSPEC     = 0;
  {$EXTERNALSYM AF_UNSPEC}
  AF_UNIX       = 1;
  {$EXTERNALSYM AF_UNIX}
  AF_INET       = 2;
  {$EXTERNALSYM AF_INET}
  AF_INET6      = 10;
  {$EXTERNALSYM AF_INET6}

  { Protocol families (platform specific) }
  PF_UNSPEC     = AF_UNSPEC platform;
  {$EXTERNALSYM PF_UNSPEC}
  PF_UNIX       = AF_UNIX platform;
  {$EXTERNALSYM PF_UNIX}
  PF_INET       = AF_INET platform;
  {$EXTERNALSYM PF_INET}
  PF_INET6      = AF_INET6 platform;
  {$EXTERNALSYM PF_INET6}

  { The following constants should be used for the second parameter of `shutdown'. }
  SHUT_RD         = 0;
  {$EXTERNALSYM SHUT_RD}
  SHUT_RDWR       = 1;
  {$EXTERNALSYM SHUT_RDWR}
  SHUT_WR         = 2;
  {$EXTERNALSYM SHUT_WR}

