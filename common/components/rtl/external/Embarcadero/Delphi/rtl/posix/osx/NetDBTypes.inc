{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

const 
  _PATH_HEQUIV = '/etc/hosts.equiv' platform;
  {$EXTERNALSYM _PATH_HEQUIV}
  _PATH_HOSTS = '/etc/hosts' platform;
  {$EXTERNALSYM _PATH_HOSTS}
  _PATH_NETWORKS = '/etc/networks' platform;
  {$EXTERNALSYM _PATH_NETWORKS}
  _PATH_PROTOCOLS = '/etc/protocols' platform;
  {$EXTERNALSYM _PATH_PROTOCOLS}
  _PATH_SERVICES = '/etc/services' platform;
  {$EXTERNALSYM _PATH_SERVICES}

type
  hostent = record
    hname: MarshaledAString;
    h_aliases: PMarshaledAString;
    h_addrtype: Integer;
    h_length: Integer;
    case Byte of
      0: (h_addr_list: PMarshaledAString);     { List of addresses from name server.  }
      1: (h_addr: PMarshaledAString);          { Address, for backward compatibility. }
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

  servent = record
    s_name: MarshaledAString;
    s_aliases: PMarshaledAString;
    s_port: Integer;
    s_proto: MarshaledAString;
  end;
  {$EXTERNALSYM servent}
  Pservent = ^servent;

  protoent = record
    p_name: MarshaledAString;
    p_aliases: PMarshaledAString;
    p_proto: Integer;
  end;
  {$EXTERNALSYM protoent}
  Pprotoent = ^protoent;

  rpcent = record
    r_name: MarshaledAString;
    r_aliases: PMarshaledAString;
    r_proto: Integer;
  end;
  {$EXTERNALSYM rpcent}
  Prpcent = ^rpcent;

const
  IPPORT_RESERVED = 1024;
  {$EXTERNALSYM IPPORT_RESERVED}

type
  PAddrInfo = ^addrinfo;
  addrinfo = record
    ai_flags: Integer;
    ai_family: Integer;
    ai_socktype: Integer;
    ai_protocol: Integer;
    ai_addrlen: socklen_t;
    ai_canonname: MarshaledAString;
    ai_addr: PSockAddr;
    ai_next: PAddrInfo;
  end;
  {$EXTERNALSYM addrinfo}


const
{ Error return codes from gethostbyname() and gethostbyaddr()
(left in h_errno). }
  NETDB_INTERNAL = -1 platform; { see errno }
  {$EXTERNALSYM NETDB_INTERNAL}
  NETDB_SUCCESS = 0 platform; { no problem }
  {$EXTERNALSYM NETDB_SUCCESS}
  HOST_NOT_FOUND = 1 platform; { Authoritative Answer Host not found }
  {$EXTERNALSYM HOST_NOT_FOUND}
  TRY_AGAIN = 2 platform; { Non-Authoritative Host not found, or SERVERFAIL }
  {$EXTERNALSYM TRY_AGAIN}
  NO_RECOVERY = 3 platform; { Non recoverable errors, FORMERR, REFUSED, NOTIMP }
  {$EXTERNALSYM NO_RECOVERY}
  NO_DATA = 4 platform; { Valid name, no data record of requested type }
  {$EXTERNALSYM NO_DATA}
  NO_ADDRESS = NO_DATA platform; { no address, look for MX record }
  {$EXTERNALSYM NO_ADDRESS}

{ Error return codes from getaddrinfo() }

  EAI_ADDRFAMILY = 1 platform; { address family for hostname not supported }
  {$EXTERNALSYM EAI_ADDRFAMILY}
  EAI_AGAIN = 2; { temporary failure in name resolution }
  {$EXTERNALSYM EAI_AGAIN}
  EAI_BADFLAGS = 3; { invalid value for ai_flags }
  {$EXTERNALSYM EAI_BADFLAGS}
  EAI_FAIL = 4; { non-recoverable failure in name resolution }
  {$EXTERNALSYM EAI_FAIL}
  EAI_FAMILY = 5; { ai_family not supported }
  {$EXTERNALSYM EAI_FAMILY}
  EAI_MEMORY = 6; { memory allocation failure }
  {$EXTERNALSYM EAI_MEMORY}
  EAI_NODATA = 7 platform; { no address associated with hostname }
  {$EXTERNALSYM EAI_NODATA}
  EAI_NONAME = 8; { hostname nor servname provided, or not known }
  {$EXTERNALSYM EAI_NONAME}
  EAI_SERVICE = 9; { servname not supported for ai_socktype }
  {$EXTERNALSYM EAI_SERVICE}
  EAI_SOCKTYPE = 10; { ai_socktype not supported }
  {$EXTERNALSYM EAI_SOCKTYPE}
  EAI_SYSTEM = 11; { system error returned in errno }
  {$EXTERNALSYM EAI_SYSTEM}
  EAI_BADHINTS = 12 platform; { invalid value for hints }
  {$EXTERNALSYM EAI_BADHINTS}
  EAI_PROTOCOL = 13 platform; { resolved protocol is unknown }
  {$EXTERNALSYM EAI_PROTOCOL}
  EAI_OVERFLOW = 14; { argument buffer overflow }
  {$EXTERNALSYM EAI_OVERFLOW}
  EAI_MAX = 15 platform;
  {$EXTERNALSYM EAI_MAX}

{ Flag values for getaddrinfo() }
  AI_PASSIVE = $00000001; { get address to use bind() }
  {$EXTERNALSYM AI_PASSIVE}
  AI_CANONNAME = $00000002; { fill ai_canonname }
  {$EXTERNALSYM AI_CANONNAME}
  AI_NUMERICHOST = $00000004; { prevent host name resolution }
  {$EXTERNALSYM AI_NUMERICHOST}
  AI_NUMERICSERV = $00001000; { prevent service name resolution }
  {$EXTERNALSYM AI_NUMERICSERV}
  AI_ALL = $00000100; { IPv6 and IPv4-mapped (with AI_V4MAPPED) }
  {$EXTERNALSYM AI_ALL}
  AI_V4MAPPED_CFG = $00000200 platform; { accept IPv4-mapped if kernel supports }
  {$EXTERNALSYM AI_V4MAPPED_CFG}
  AI_ADDRCONFIG = $00000400; { only if any address is assigned }
  {$EXTERNALSYM AI_ADDRCONFIG}
  AI_V4MAPPED = $00000800; { accept IPv4-mapped IPv6 address }
  {$EXTERNALSYM AI_V4MAPPED}
{ valid flags for addrinfo (not a standard def, apps should not use it) }
  AI_MASK = (AI_PASSIVE or AI_CANONNAME or AI_NUMERICHOST or
    AI_NUMERICSERV or AI_ADDRCONFIG) platform;
  {$EXTERNALSYM AI_MASK}
{ special recommended flags for getipnodebyname }
  AI_DEFAULT = (AI_V4MAPPED_CFG or AI_ADDRCONFIG) platform;
  {$EXTERNALSYM AI_DEFAULT}

{ Constants for getnameinfo() }
  NI_MAXHOST = 1025;
  {$EXTERNALSYM NI_MAXHOST}
  NI_MAXSERV = 32;
  {$EXTERNALSYM NI_MAXSERV}
{ Flag values for getnameinfo() }
  NI_NOFQDN       = $0001;
  {$EXTERNALSYM NI_NOFQDN}
  NI_NUMERICHOST  = $0002;
  {$EXTERNALSYM NI_NUMERICHOST}
  NI_NAMEREQD     = $0004;
  {$EXTERNALSYM NI_NAMEREQD}
  NI_NUMERICSERV  = $0008;
  {$EXTERNALSYM NI_NUMERICSERV}
  NI_WITHSCOPEID = $0020 platform; //TODO: is this NI_NUMERICSCOPE?
  {$EXTERNALSYM NI_WITHSCOPEID}
  NI_DGRAM        = $0010;
  {$EXTERNALSYM NI_DGRAM}
  
{ Scope delimiter for getaddrinfo(), getnameinfo().  }
  SCOPE_DELIMITER       = '%' platform;
  {$EXTERNALSYM SCOPE_DELIMITER}
