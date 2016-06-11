{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ Absolute file name for network data base files.  }
const
  _PATH_HEQUIV          = '/system/etc/hosts.equiv' platform;
  {$EXTERNALSYM _PATH_HEQUIV}
  _PATH_HOSTS           = '/system/etc/hosts' platform;
  {$EXTERNALSYM _PATH_HOSTS}
  _PATH_NETWORKS        = '/system/etc/networks' platform;
  {$EXTERNALSYM _PATH_NETWORKS}
  _PATH_PROTOCOLS       = '/system/etc/protocols' platform;
  {$EXTERNALSYM _PATH_PROTOCOLS}
  _PATH_SERVICES        = '/system/etc/services' platform;
  {$EXTERNALSYM _PATH_SERVICES}

  MAXHOSTNAMELEN = 256;
  {$EXTERNALSYM MAXHOSTNAMELEN}

  HOST_NOT_FOUND        = 1 platform;       { Authoritative Answer Host not found.  }
  {$EXTERNALSYM HOST_NOT_FOUND}
  TRY_AGAIN             = 2 platform;       { Non-Authoritative Host not found, or SERVERFAIL.  }
  {$EXTERNALSYM TRY_AGAIN}
  NO_RECOVERY           = 3 platform;       { Non recoverable errors, FORMERR, REFUSED, NOTIMP.  }
  {$EXTERNALSYM NO_RECOVERY}
  NO_DATA               = 4 platform;       { Valid name, no data record of requested type.  }
  {$EXTERNALSYM NO_DATA}
  NETDB_INTERNAL        = -1 platform;      { See errno.  }
  {$EXTERNALSYM NETDB_INTERNAL}
  NETDB_SUCCESS         = 0 platform;       { No problem.  }
  {$EXTERNALSYM NETDB_SUCCESS}
  NO_ADDRESS            = NO_DATA platform; { No address, look for MX record.  }
  {$EXTERNALSYM NO_ADDRESS}

{ Scope delimiter for getaddrinfo(), getnameinfo().  }
  SCOPE_DELIMITER       = '%' platform;
  {$EXTERNALSYM SCOPE_DELIMITER}

type
  hostent = record
    h_name: MarshaledAString;
    h_aliases: PMarshaledAString;
    h_addrtype: Integer;
    h_length: Integer;
    h_addr_list: PMarshaledAString;
//    h_addr: h_addr_list[0];
  end;
  {$EXTERNALSYM hostent}
  Phostent = ^hostent;

  netent = record
    n_name: MarshaledAString;
    n_aliases: PMarshaledAString;
    n_addrtype: Integer;
    n_net: UInt32;
  end;
  {$EXTERNALSYM netent}
  Pnetent = ^netent;

  protoent = record
    p_name: MarshaledAString;
    p_aliases: PMarshaledAString;
    p_proto: Integer;
  end;
  {$EXTERNALSYM protoent}
  Pprotoent = ^protoent;

  servent = record
    s_name: MarshaledAString;
    s_aliases: PMarshaledAString;
    s_port: Integer;
    s_proto: MarshaledAString;
  end;
  {$EXTERNALSYM servent}
  Pservent = ^servent;

const
  IPPORT_RESERVED = 1024;
  {$EXTERNALSYM IPPORT_RESERVED}

type
  Paddrinfo = ^addrinfo;

  addrinfo = record
    ai_flags: Integer;
    ai_family: Integer;
    ai_socktype: Integer;
    ai_protocol: Integer;
    ai_addrlen: socklen_t;
    ai_canonname: MarshaledAString;
    ai_addr: Psockaddr;
    ai_next: Paddrinfo;
  end;
  {$EXTERNALSYM addrinfo}

  //TODO: gaicb

const


{ Possible values for `ai_flags' field in `addrinfo' structure.}
  AI_PASSIVE = $0001; { Socket address is intended for `bind'.}
  {$EXTERNALSYM AI_PASSIVE}
  AI_CANONNAME = $0002; { Request for canonical name.}
  {$EXTERNALSYM AI_CANONNAME}
  AI_NUMERICHOST = $0004; { Don't use name resolution.}
  {$EXTERNALSYM AI_NUMERICHOST}
  AI_V4MAPPED = $0800; { IPv4 mapped addresses are acceptable.}
  {$EXTERNALSYM AI_V4MAPPED}
  AI_ALL = $0100; { Return IPv4 mapped and IPv6 addresses.}
  {$EXTERNALSYM AI_ALL}
  AI_ADDRCONFIG = $0400; { Use configuration of this host to
                           choose returned address type..  }
  {$EXTERNALSYM AI_ADDRCONFIG}
  AI_V4MAPPED_CFG = $0200;
  {$EXTERNALSYM AI_V4MAPPED_CFG}
  AI_DEFAULT = (AI_V4MAPPED_CFG or AI_ADDRCONFIG) platform;
  {$EXTERNALSYM AI_DEFAULT}
  AI_NUMERICSERV = $0008 platform; { Don't use name resolution.  }
  {$EXTERNALSYM AI_NUMERICSERV}
   AI_MASK = (AI_PASSIVE or AI_CANONNAME or AI_NUMERICHOST or
    AI_NUMERICSERV or AI_ADDRCONFIG) platform;
  {$EXTERNALSYM AI_MASK}


{ Error values for `getaddrinfo' function.  }
  EAI_BADFLAGS = 3; { Invalid value for `ai_flags' field.  }
  {$EXTERNALSYM EAI_BADFLAGS}
  EAI_NONAME = 8; { NAME or SERVICE is unknown.  }
  {$EXTERNALSYM EAI_NONAME}
  EAI_AGAIN = 2; { Temporary failure in name resolution.  }
  {$EXTERNALSYM EAI_AGAIN}
  EAI_FAIL = 4; { Non-recoverable failure in name res.  }
  {$EXTERNALSYM EAI_FAIL}
  EAI_FAMILY = 5; { `ai_family' not supported.  }
  {$EXTERNALSYM EAI_FAMILY}
  EAI_SOCKTYPE = 10; { `ai_socktype' not supported.  }
  {$EXTERNALSYM EAI_SOCKTYPE}
  EAI_SERVICE = 9; { SERVICE not supported for `ai_socktype'.  }
  {$EXTERNALSYM EAI_SERVICE}
  EAI_MEMORY = 6; { Memory allocation failure.  }
  {$EXTERNALSYM EAI_MEMORY}
  EAI_SYSTEM = 11; { System error returned in `errno'.  }
  {$EXTERNALSYM EAI_SYSTEM}
  EAI_OVERFLOW = 14; { Argument buffer overflow.  }
  {$EXTERNALSYM EAI_OVERFLOW}
  EAI_BADHINTS = 12;  { Invalid value for hints }
  {$EXTERNALSYM EAI_BADHINTS}
  EAI_PROTOCOL = 13; { Resolved protocol is unknown }
  {$EXTERNALSYM EAI_PROTOCOL}
  EAI_MAX = 15;
  {$EXTERNALSYM EAI_MAX}
  EAI_NODATA = 7 platform; { No address associated with NAME.  }
  {$EXTERNALSYM EAI_NODATA}
  EAI_ADDRFAMILY = 1 platform; { Address family for NAME not supported.  }
  {$EXTERNALSYM EAI_ADDRFAMILY}

  NI_MAXHOST      = 1025 platform;
  {$EXTERNALSYM NI_MAXHOST     }
  NI_MAXSERV      = 32 platform;
  {$EXTERNALSYM NI_MAXSERV     }

  NI_NUMERICHOST = $2; { Don't try to look up hostname.  }
  {$EXTERNALSYM NI_NUMERICHOST}
  NI_NUMERICSERV = $8; { Don't convert port number to name.  }
  {$EXTERNALSYM NI_NUMERICSERV}
  NI_NOFQDN = $1; { Only return nodename portion.  }
  {$EXTERNALSYM NI_NOFQDN}
  NI_NAMEREQD = $4; { Don't return numeric addresses.  }
  {$EXTERNALSYM NI_NAMEREQD}
  NI_DGRAM = $10; { Look up UDP service rather than TCP.  }
  {$EXTERNALSYM NI_DGRAM}

