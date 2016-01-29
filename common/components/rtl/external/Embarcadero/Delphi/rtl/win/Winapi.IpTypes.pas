{******************************************************************************}
{                                                                              }
{ Internet Protocol Helper API interface Unit for Object Pascal                }
{                                                                              }
{ Portions created by Microsoft are Copyright (C) 1995-2001 Microsoft          }
{ Corporation. All Rights Reserved.                                            }
{                                                                              }
{ The original file is: iptypes.h, released July 2000. The original Pascal     }
{ code is: IpTypes.pas, released September 2000. The initial developer of the  }
{ Pascal code is Marcel van Brakel (brakelm att chello dott nl).               }
{                                                                              }
{ Portions created by Marcel van Brakel are Copyright (C) 1999-2001            }
{ Marcel van Brakel. All Rights Reserved.                                      }
{                                                                              }
{ Contributor(s): John C. Penman (jcp att craiglockhart dott com)              }
{                 Vladimir Vassiliev (voldemarv att hotpop dott com)           }
{                                                                              }
{ Obtained through: Joint Endeavour of Delphi Innovators (Project JEDI)        }
{                                                                              }
{ You may retrieve the latest version of this file at the Project JEDI         }
{ APILIB home page, located at http://jedi-apilib.sourceforge.net              }
{                                                                              }
{ The contents of this file are used with permission, subject to the Mozilla   }
{ Public License Version 1.1 (the "License"); you may not use this file except }
{ in compliance with the License. You may obtain a copy of the License at      }
{ http://www.mozilla.org/MPL/MPL-1.1.html                                      }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ Alternatively, the contents of this file may be used under the terms of the  }
{ GNU Lesser General Public License (the  "LGPL License"), in which case the   }
{ provisions of the LGPL License are applicable instead of those above.        }
{ If you wish to allow use of your version of this file only under the terms   }
{ of the LGPL License and not to allow others to use your version of this file }
{ under the MPL, indicate your decision by deleting  the provisions above and  }
{ replace  them with the notice and other provisions required by the LGPL      }
{ License.  If you do not delete the provisions above, a recipient may use     }
{ your version of this file under either the MPL or the LGPL License.          }
{                                                                              }
{ For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html }
{                                                                              }
{******************************************************************************}

// $Id: Winapi.IpTypes.pas,v 1.2 2013/05/24 13:31:00 lulin Exp $
unit Winapi.IpTypes;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT ''}
{$HPPEMIT '#include "iptypes.h"'}
{$HPPEMIT ''}

(*$HPPEMIT 'namespace Winapi'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT 'namespace Iptypes'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT 'typedef IP_ADAPTER_UNICAST_ADDRESS TIpAdapterUnicastAddress;'*)
(*$HPPEMIT 'typedef IP_ADAPTER_ANYCAST_ADDRESS TIpAdapterAnycaseAddress;'*)
(*$HPPEMIT 'typedef IP_ADAPTER_MULTICAST_ADDRESS TIpAdapterMulticastAddress;'*)
(*$HPPEMIT 'typedef IP_ADAPTER_DNS_SERVER_ADDRESS TIpAdapterDnsServerAddress;'*)
(*$HPPEMIT 'typedef IP_ADAPTER_PREFIX TIpAdapterPrefix;'*)
(*$HPPEMIT 'typedef IP_ADAPTER_ADDRESSES TIpAdapterAddresses;'*)
(*$HPPEMIT 'typedef IP_PER_ADAPTER_INFO TIpPerAdapterInfo;'*)
(*$HPPEMIT '}'*)
(*$HPPEMIT '}'*)

interface

uses
  Winapi.Windows, Winapi.WinSock;


type
  sockaddr = sockaddr_in;
  {$EXTERNALSYM sockaddr}

  PSOCKADDR = ^SOCKADDR;
  {$EXTERNALSYM PSOCKADDR}

type
  LPSOCKADDR = PSOCKADDR;
  {$EXTERNALSYM LPSOCKADDR}

  _SOCKET_ADDRESS = record
    lpSockaddr: LPSOCKADDR;
    iSockaddrLength: Integer;
  end;
  {$EXTERNALSYM _SOCKET_ADDRESS}
  SOCKET_ADDRESS = _SOCKET_ADDRESS;
  {$EXTERNALSYM SOCKET_ADDRESS}
  PSOCKET_ADDRESS = ^SOCKET_ADDRESS;
  {$EXTERNALSYM PSOCKET_ADDRESS}
  LPSOCKET_ADDRESS = PSOCKET_ADDRESS;
  {$EXTERNALSYM LPSOCKET_ADDRESS}
  TSocketAddress = SOCKET_ADDRESS;
  PSocketAddress = LPSOCKET_ADDRESS;

type
  // #include <time.h>  // TODO
  time_t = NativeInt;
  {$EXTERNALSYM time_t}

// Definitions and structures used by getnetworkparams and getadaptersinfo apis

const
  MAX_ADAPTER_DESCRIPTION_LENGTH = 128; // arb.
  {$EXTERNALSYM MAX_ADAPTER_DESCRIPTION_LENGTH}
  MAX_ADAPTER_NAME_LENGTH        = 256; // arb.
  {$EXTERNALSYM MAX_ADAPTER_NAME_LENGTH}
  MAX_ADAPTER_ADDRESS_LENGTH     = 8; // arb.
  {$EXTERNALSYM MAX_ADAPTER_ADDRESS_LENGTH}
  DEFAULT_MINIMUM_ENTITIES       = 32; // arb.
  {$EXTERNALSYM DEFAULT_MINIMUM_ENTITIES}
  MAX_HOSTNAME_LEN               = 128; // arb.
  {$EXTERNALSYM MAX_HOSTNAME_LEN}
  MAX_DOMAIN_NAME_LEN            = 128; // arb.
  {$EXTERNALSYM MAX_DOMAIN_NAME_LEN}
  MAX_SCOPE_ID_LEN               = 256; // arb.
  {$EXTERNALSYM MAX_SCOPE_ID_LEN}

//
// types
//

// Node Type

  BROADCAST_NODETYPE    = 1;
  {$EXTERNALSYM BROADCAST_NODETYPE}
  PEER_TO_PEER_NODETYPE = 2;
  {$EXTERNALSYM PEER_TO_PEER_NODETYPE}
  MIXED_NODETYPE        = 4;
  {$EXTERNALSYM MIXED_NODETYPE}
  HYBRID_NODETYPE       = 8;
  {$EXTERNALSYM HYBRID_NODETYPE}

//
// IP_ADDRESS_STRING - store an IP address as a dotted decimal string
//

type
  PIP_MASK_STRING = ^IP_MASK_STRING;
  {$EXTERNALSYM PIP_MASK_STRING}
  IP_ADDRESS_STRING = record
    S: array [0..15] of AnsiChar;
  end;
  {$EXTERNALSYM IP_ADDRESS_STRING}
  PIP_ADDRESS_STRING = ^IP_ADDRESS_STRING;
  {$EXTERNALSYM PIP_ADDRESS_STRING}
  IP_MASK_STRING = IP_ADDRESS_STRING;
  {$EXTERNALSYM IP_MASK_STRING}
  TIpAddressString = IP_ADDRESS_STRING;
  PIpAddressString = PIP_MASK_STRING;

//
// IP_ADDR_STRING - store an IP address with its corresponding subnet mask,
// both as dotted decimal strings
//

  PIP_ADDR_STRING = ^IP_ADDR_STRING;
  {$EXTERNALSYM PIP_ADDR_STRING}
  _IP_ADDR_STRING = record
    Next: PIP_ADDR_STRING;
    IpAddress: IP_ADDRESS_STRING;
    IpMask: IP_MASK_STRING;
    Context: DWORD;
  end;
  {$EXTERNALSYM _IP_ADDR_STRING}
  IP_ADDR_STRING = _IP_ADDR_STRING;
  {$EXTERNALSYM IP_ADDR_STRING}
  TIpAddrString = IP_ADDR_STRING;
  PIpAddrString = PIP_ADDR_STRING;

//
// ADAPTER_INFO - per-adapter information. All IP addresses are stored as
// strings
//

  PIP_ADAPTER_INFO = ^IP_ADAPTER_INFO;
  {$EXTERNALSYM PIP_ADAPTER_INFO}
  _IP_ADAPTER_INFO = record
    Next: PIP_ADAPTER_INFO;
    ComboIndex: DWORD;
    AdapterName: array [0..MAX_ADAPTER_NAME_LENGTH + 3] of AnsiChar;
    Description: array [0..MAX_ADAPTER_DESCRIPTION_LENGTH + 3] of AnsiChar;
    AddressLength: UINT;
    Address: array [0..MAX_ADAPTER_ADDRESS_LENGTH - 1] of BYTE;
    Index: DWORD;
    Type_: UINT;
    DhcpEnabled: UINT;
    CurrentIpAddress: PIP_ADDR_STRING;
    IpAddressList: IP_ADDR_STRING;
    GatewayList: IP_ADDR_STRING;
    DhcpServer: IP_ADDR_STRING;
    HaveWins: BOOL;
    PrimaryWinsServer: IP_ADDR_STRING;
    SecondaryWinsServer: IP_ADDR_STRING;
    LeaseObtained: time_t;
    LeaseExpires: time_t;
  end;
  {$EXTERNALSYM _IP_ADAPTER_INFO}
  IP_ADAPTER_INFO = _IP_ADAPTER_INFO;
  {$EXTERNALSYM IP_ADAPTER_INFO}
  TIpAdapterInfo = IP_ADAPTER_INFO;
  PIpAdapterInfo = PIP_ADAPTER_INFO;

//
// The following types require Winsock2.
//

  IP_PREFIX_ORIGIN = (
    IpPrefixOriginOther,
    IpPrefixOriginManual,
    IpPrefixOriginWellKnown,
    IpPrefixOriginDhcp,
    IpPrefixOriginRouterAdvertisement);
  {$EXTERNALSYM IP_PREFIX_ORIGIN}
  TIpPrefixOrigin = IP_PREFIX_ORIGIN;

  IP_SUFFIX_ORIGIN = (
    IpSuffixOriginOther,
    IpSuffixOriginManual,
    IpSuffixOriginWellKnown,
    IpSuffixOriginDhcp,
    IpSuffixOriginLinkLayerAddress,
    IpSuffixOriginRandom);
  {$EXTERNALSYM IP_SUFFIX_ORIGIN}
  TIpSuffixOrigin = IP_SUFFIX_ORIGIN;

  IP_DAD_STATE = (
    IpDadStateInvalid,
    IpDadStateTentative,
    IpDadStateDuplicate,
    IpDadStateDeprecated,
    IpDadStatePreferred);
  {$EXTERNALSYM IP_DAD_STATE}
  TIpDadState = IP_DAD_STATE;

  PIP_ADAPTER_UNICAST_ADDRESS = ^_IP_ADAPTER_UNICAST_ADDRESS;
  {$EXTERNALSYM PIP_ADAPTER_UNICAST_ADDRESS}
  _IP_ADAPTER_UNICAST_ADDRESS = record
    Union: record
      case Integer of
        0: (
          Alignment: ULONGLONG);
        1: (
          Length: ULONG;
          Flags: DWORD);
    end;
    Next: PIP_ADAPTER_UNICAST_ADDRESS;
    Address: SOCKET_ADDRESS;

    PrefixOrigin: IP_PREFIX_ORIGIN;
    SuffixOrigin: IP_SUFFIX_ORIGIN;
    DadState: IP_DAD_STATE;

    ValidLifetime: ULONG;
    PreferredLifetime: ULONG;
    LeaseLifetime: ULONG;
    OnLinkPrefixLength: UCHAR;
  end;
  {$EXTERNALSYM _IP_ADAPTER_UNICAST_ADDRESS}
  IP_ADAPTER_UNICAST_ADDRESS = _IP_ADAPTER_UNICAST_ADDRESS;
  {$EXTERNALSYM IP_ADAPTER_UNICAST_ADDRESS}
  TIpAdapterUnicastAddress = IP_ADAPTER_UNICAST_ADDRESS;
  {$EXTERNALSYM TIpAdapterUnicastAddress}
  PIpAdapterUnicastAddress = PIP_ADAPTER_UNICAST_ADDRESS;

  PIP_ADAPTER_ANYCAST_ADDRESS = ^_IP_ADAPTER_ANYCAST_ADDRESS;
  {$EXTERNALSYM PIP_ADAPTER_ANYCAST_ADDRESS}
  _IP_ADAPTER_ANYCAST_ADDRESS = record
    Union: record
      case Integer of
        0: (
          Alignment: ULONGLONG);
        1: (
          Length: ULONG;
          Flags: DWORD);
    end;
    Next: PIP_ADAPTER_ANYCAST_ADDRESS;
    Address: SOCKET_ADDRESS;
  end;
  {$EXTERNALSYM _IP_ADAPTER_ANYCAST_ADDRESS}
  IP_ADAPTER_ANYCAST_ADDRESS = _IP_ADAPTER_ANYCAST_ADDRESS;
  {$EXTERNALSYM IP_ADAPTER_ANYCAST_ADDRESS}
  TIpAdapterAnycaseAddress = IP_ADAPTER_ANYCAST_ADDRESS;
  {$EXTERNALSYM TIpAdapterAnycaseAddress}

  PIpAdapterAnycaseAddress = PIP_ADAPTER_ANYCAST_ADDRESS;

  PIP_ADAPTER_MULTICAST_ADDRESS = ^_IP_ADAPTER_MULTICAST_ADDRESS;
  {$EXTERNALSYM PIP_ADAPTER_MULTICAST_ADDRESS}
  _IP_ADAPTER_MULTICAST_ADDRESS = record
    Union: record
      case Integer of
        0: (
          Alignment: ULONGLONG);
        1: (
          Length: ULONG;
          Flags: DWORD);
    end;
    Next: PIP_ADAPTER_MULTICAST_ADDRESS;
    Address: SOCKET_ADDRESS;
  end;
  {$EXTERNALSYM _IP_ADAPTER_MULTICAST_ADDRESS}
  IP_ADAPTER_MULTICAST_ADDRESS = _IP_ADAPTER_MULTICAST_ADDRESS;
  {$EXTERNALSYM IP_ADAPTER_MULTICAST_ADDRESS}
  TIpAdapterMulticastAddress = IP_ADAPTER_MULTICAST_ADDRESS;
  {$EXTERNALSYM TIpAdapterMulticastAddress}
  PIpAdapterMulticastAddress = PIP_ADAPTER_MULTICAST_ADDRESS;

//
// Per-address Flags
//

const
  IP_ADAPTER_ADDRESS_DNS_ELIGIBLE = $01;
  {$EXTERNALSYM IP_ADAPTER_ADDRESS_DNS_ELIGIBLE}
  IP_ADAPTER_ADDRESS_TRANSIENT    = $02;
  {$EXTERNALSYM IP_ADAPTER_ADDRESS_TRANSIENT}

type
  PIP_ADAPTER_DNS_SERVER_ADDRESS = ^_IP_ADAPTER_DNS_SERVER_ADDRESS;
  {$EXTERNALSYM PIP_ADAPTER_DNS_SERVER_ADDRESS}
  _IP_ADAPTER_DNS_SERVER_ADDRESS = record
    Union: record
      case Integer of
        0: (
          Alignment: ULONGLONG);
        1: (
          Length: ULONG;
          Reserved: DWORD);
    end;
    Next: PIP_ADAPTER_DNS_SERVER_ADDRESS;
    Address: SOCKET_ADDRESS;
  end;
  {$EXTERNALSYM _IP_ADAPTER_DNS_SERVER_ADDRESS}
  IP_ADAPTER_DNS_SERVER_ADDRESS = _IP_ADAPTER_DNS_SERVER_ADDRESS;
  {$EXTERNALSYM IP_ADAPTER_DNS_SERVER_ADDRESS}
  TIpAdapterDnsServerAddress = IP_ADAPTER_DNS_SERVER_ADDRESS;
  {$EXTERNALSYM TIpAdapterDnsServerAddress}
  PIpAdapterDnsServerAddress = PIP_ADAPTER_DNS_SERVER_ADDRESS;

  PIP_ADAPTER_WINS_SERVER_ADDRESS_LH = ^_IP_ADAPTER_WINS_SERVER_ADDRESS_LH;
  {$EXTERNALSYM PIP_ADAPTER_WINS_SERVER_ADDRESS_LH}
  _IP_ADAPTER_WINS_SERVER_ADDRESS_LH = record
    Union: record
      case Integer of
        0: (
          Alignment: ULONGLONG);
        1: (
          Length: ULONG;
          Reserved: DWORD);
    end;
    Next: PIP_ADAPTER_WINS_SERVER_ADDRESS_LH;
    Address: SOCKET_ADDRESS;
  end;
  {$EXTERNALSYM _IP_ADAPTER_WINS_SERVER_ADDRESS_LH}
  IP_ADAPTER_WINS_SERVER_ADDRESS_LH = _IP_ADAPTER_WINS_SERVER_ADDRESS_LH;
  {$EXTERNALSYM IP_ADAPTER_WINS_SERVER_ADDRESS_LH}

  PIP_ADAPTER_GATEWAY_ADDRESS_LH = ^_IP_ADAPTER_GATEWAY_ADDRESS_LH;
  {$EXTERNALSYM PIP_ADAPTER_GATEWAY_ADDRESS_LH}
  _IP_ADAPTER_GATEWAY_ADDRESS_LH = record
    Union: record
      case Integer of
        0: (
          Alignment: ULONGLONG);
        1: (
          Length: ULONG;
          Reserved: DWORD);
    end;
    Next: PIP_ADAPTER_GATEWAY_ADDRESS_LH;
    Address: SOCKET_ADDRESS;
  end;
  {$EXTERNALSYM _IP_ADAPTER_GATEWAY_ADDRESS_LH}
  IP_ADAPTER_GATEWAY_ADDRESS_LH = _IP_ADAPTER_GATEWAY_ADDRESS_LH;
  {$EXTERNALSYM IP_ADAPTER_GATEWAY_ADDRESS_LH}

  PIP_ADAPTER_PREFIX = ^IP_ADAPTER_PREFIX;
  {$EXTERNALSYM PIP_ADAPTER_PREFIX}
  _IP_ADAPTER_PREFIX = record
    Union: record
    case Integer of
      0: (
        Alignment: ULONGLONG);
      1: (
        Length: ULONG;
        Flags: DWORD);
    end;
    Next: PIP_ADAPTER_PREFIX;
    Address: SOCKET_ADDRESS;
    PrefixLength: ULONG;
  end;
  {$EXTERNALSYM _IP_ADAPTER_PREFIX}
  IP_ADAPTER_PREFIX = _IP_ADAPTER_PREFIX;
  {$EXTERNALSYM IP_ADAPTER_PREFIX}
  TIpAdapterPrefix = IP_ADAPTER_PREFIX;
  {$EXTERNALSYM TIpAdapterPrefix}
  PIpAdapterPrefix = PIP_ADAPTER_PREFIX;

//
// Per-adapter Flags
//

const
  IP_ADAPTER_DDNS_ENABLED            = $01;
  {$EXTERNALSYM IP_ADAPTER_DDNS_ENABLED}
  IP_ADAPTER_REGISTER_ADAPTER_SUFFIX = $02;
  {$EXTERNALSYM IP_ADAPTER_REGISTER_ADAPTER_SUFFIX}
  IP_ADAPTER_DHCP_ENABLED            = $04;
  {$EXTERNALSYM IP_ADAPTER_DHCP_ENABLED}
  IP_ADAPTER_RECEIVE_ONLY            = $08;
  {$EXTERNALSYM IP_ADAPTER_RECEIVE_ONLY}
  IP_ADAPTER_NO_MULTICAST            = $10;
  {$EXTERNALSYM IP_ADAPTER_NO_MULTICAST}
  IP_ADAPTER_IPV6_OTHER_STATEFUL_CONFIG = $20;
  {$EXTERNALSYM IP_ADAPTER_IPV6_OTHER_STATEFUL_CONFIG}

//
// OperStatus values from RFC 2863
//

type
  IF_OPER_STATUS = (
    IfOperStatusUp,
    IfOperStatusDown,
    IfOperStatusTesting,
    IfOperStatusUnknown,
    IfOperStatusDormant,
    IfOperStatusNotPresent,
    IfOperStatusLowerLayerDown);
  {$EXTERNALSYM IF_OPER_STATUS}
  TIfOperStatus = IF_OPER_STATUS;

//
// Scope levels from RFC 2373 used with ZoneIndices array.
//

const
  ScopeLevelInterface    = 1;
  {$EXTERNALSYM ScopeLevelInterface}
  ScopeLevelLink         = 2;
  {$EXTERNALSYM ScopeLevelLink}
  ScopeLevelSubnet       = 3;
  {$EXTERNALSYM ScopeLevelSubnet}
  ScopeLevelAdmin        = 4;
  {$EXTERNALSYM ScopeLevelAdmin}
  ScopeLevelSite         = 5;
  {$EXTERNALSYM ScopeLevelSite}
  ScopeLevelOrganization = 8;
  {$EXTERNALSYM ScopeLevelOrganization}
  ScopeLevelGlobal       = 14;
  {$EXTERNALSYM ScopeLevelGlobal}
  MAX_DHCPV6_DUID_LENGTH = 130;
  {$EXTERNALSYM MAX_DHCPV6_DUID_LENGTH}
  MAX_DNS_SUFFIX_STRING_LENGTH = 256;
  {$EXTERNALSYM MAX_DNS_SUFFIX_STRING_LENGTH}

type
  SCOPE_LEVEL = DWORD;
  {$EXTERNALSYM SCOPE_LEVEL}
  TScopeLevel = SCOPE_LEVEL;
  {$EXTERNALSYM TScopeLevel}
  IFTYPE = ULONG;
  {$EXTERNALSYM IFTYPE}
  IF_INDEX = ULONG;
  {$EXTERNALSYM IF_INDEX}
  NET_IF_COMPARTMENT_ID = UINT32;
  {$EXTERNALSYM NET_IF_COMPARTMENT_ID}
  NET_IF_NETWORK_GUID = TGUID;
  {$EXTERNALSYM NET_IF_NETWORK_GUID}

  IF_LUID = record
    case Integer of
      0: (
          Value: ULONG64);
      1: (
          Info: ULONG64);
  end;
  {$EXTERNALSYM IF_LUID}

  TNetIfConnectionType = (
    NetIfConnectionDedicated,
    NetIfConnectionPassive,
    NetIfConnectionDemand,
    NetIfConnectionMaximum);
  NET_IF_CONNECTION_TYPE = TNetIfConnectionType;
  {$EXTERNALSYM NET_IF_CONNECTION_TYPE}

  TTunnelType = (
    TunnelTypeNone,
    TunnelTypeOther,
    TunnelTypeDirect,
    TunnelType6To4,
    TunnelTypeIsatap,
    TunnelTypeTeredo,
    TunnelTypeIPHTTPS);
  TUNNEL_TYPE = TTunnelType;
  {$EXTERNALSYM TUNNEL_TYPE}

   PIP_ADAPTER_DNS_SUFFIX = ^_IP_ADAPTER_DNS_SUFFIX;
   {$EXTERNALSYM PIP_ADAPTER_DNS_SUFFIX}
  _IP_ADAPTER_DNS_SUFFIX = record
    Next: PIP_ADAPTER_DNS_SUFFIX;
    AString: array[0..MAX_DNS_SUFFIX_STRING_LENGTH - 1] of WCHAR;
  end;
  {$EXTERNALSYM _IP_ADAPTER_DNS_SUFFIX}
  IP_ADAPTER_DNS_SUFFIX = _IP_ADAPTER_DNS_SUFFIX;
  {$EXTERNALSYM IP_ADAPTER_DNS_SUFFIX}

  PIP_ADAPTER_ADDRESSES = ^_IP_ADAPTER_ADDRESSES;
  {$EXTERNALSYM PIP_ADAPTER_ADDRESSES}
  _IP_ADAPTER_ADDRESSES = record
    Union: record
      case Integer of
        0: (
          Alignment: ULONGLONG);
        1: (
          Length: ULONG;
          IfIndex: DWORD);
    end;
    Next: PIP_ADAPTER_ADDRESSES;
    AdapterName: PAnsiChar;
    FirstUnicastAddress: PIP_ADAPTER_UNICAST_ADDRESS;
    FirstAnycastAddress: PIP_ADAPTER_ANYCAST_ADDRESS;
    FirstMulticastAddress: PIP_ADAPTER_MULTICAST_ADDRESS;
    FirstDnsServerAddress: PIP_ADAPTER_DNS_SERVER_ADDRESS;
    DnsSuffix: PWCHAR;
    Description: PWCHAR;
    FriendlyName: PWCHAR;
    PhysicalAddress: array [0..MAX_ADAPTER_ADDRESS_LENGTH - 1] of BYTE;
    PhysicalAddressLength: DWORD;
    Flags: DWORD;
    Mtu: DWORD;
    IfType: IFTYPE;
    OperStatus: IF_OPER_STATUS;
    Ipv6IfIndex: IF_INDEX;
    ZoneIndices: array [0..15] of DWORD;
    FirstPrefix: PIP_ADAPTER_PREFIX;
    TransmitLinkSpeed: ULONG64;
    ReceiveLinkSpeed: ULONG64;
    FirstWinsServerAddress: PIP_ADAPTER_WINS_SERVER_ADDRESS_LH;
    FirstGatewayAddress: PIP_ADAPTER_GATEWAY_ADDRESS_LH;
    Ipv4Metric: ULONG;
    Ipv6Metric: ULONG;
    Luid: IF_LUID;
    Dhcpv4Server: SOCKET_ADDRESS;
    CompartmentId: NET_IF_COMPARTMENT_ID;
    NetworkGuid: NET_IF_NETWORK_GUID;
    ConnectionType: NET_IF_CONNECTION_TYPE;
    TunnelType: TUNNEL_TYPE;
    //
    // DHCP v6 Info.
    //
    Dhcpv6Server: SOCKET_ADDRESS;
    Dhcpv6ClientDuid: array [0..MAX_DHCPV6_DUID_LENGTH - 1] of Byte;
    Dhcpv6ClientDuidLength: ULONG;
    Dhcpv6Iaid: ULONG;
    FirstDnsSuffix: PIP_ADAPTER_DNS_SUFFIX;
  end;
  {$EXTERNALSYM _IP_ADAPTER_ADDRESSES}
  IP_ADAPTER_ADDRESSES = _IP_ADAPTER_ADDRESSES;
  {$EXTERNALSYM IP_ADAPTER_ADDRESSES}
  TIpAdapterAddresses = IP_ADAPTER_ADDRESSES;
  {$EXTERNALSYM TIpAdapterAddresses}
  PIpAdapterAddresses = PIP_ADAPTER_ADDRESSES;


  PIP_ADAPTER_ADDRESSES_XP = ^_IP_ADAPTER_ADDRESSES_XP;
  {$EXTERNALSYM PIP_ADAPTER_ADDRESSES_XP}
  _IP_ADAPTER_ADDRESSES_XP = record
    Union: record
      case Integer of
        0: (
          Alignment: ULONGLONG);
        1: (
          Length: ULONG;
          IfIndex: DWORD);
    end;
    Next: PIP_ADAPTER_ADDRESSES;
    AdapterName: PAnsiChar;
    FirstUnicastAddress: PIP_ADAPTER_UNICAST_ADDRESS;
    FirstAnycastAddress: PIP_ADAPTER_ANYCAST_ADDRESS;
    FirstMulticastAddress: PIP_ADAPTER_MULTICAST_ADDRESS;
    FirstDnsServerAddress: PIP_ADAPTER_DNS_SERVER_ADDRESS;
    DnsSuffix: PWCHAR;
    Description: PWCHAR;
    FriendlyName: PWCHAR;
    PhysicalAddress: array [0..MAX_ADAPTER_ADDRESS_LENGTH - 1] of BYTE;
    PhysicalAddressLength: DWORD;
    Flags: DWORD;
    Mtu: DWORD;
    IfType: DWORD;
    OperStatus: IF_OPER_STATUS;
    Ipv6IfIndex: DWORD;
    ZoneIndices: array [0..15] of DWORD;
    FirstPrefix: PIP_ADAPTER_PREFIX;
  end;
  {$EXTERNALSYM _IP_ADAPTER_ADDRESSES_XP}
  IP_ADAPTER_ADDRESSES_XP = _IP_ADAPTER_ADDRESSES_XP;
  {$EXTERNALSYM IP_ADAPTER_ADDRESSES_XP}

//
// Flags used as argument to GetAdaptersAddresses().
// "SKIP" flags are added when the default is to include the information.
// "INCLUDE" flags are added when the default is to skip the information.
//

const
  GAA_FLAG_SKIP_UNICAST     = $0001;
  {$EXTERNALSYM GAA_FLAG_SKIP_UNICAST}
  GAA_FLAG_SKIP_ANYCAST     = $0002;
  {$EXTERNALSYM GAA_FLAG_SKIP_ANYCAST}
  GAA_FLAG_SKIP_MULTICAST   = $0004;
  {$EXTERNALSYM GAA_FLAG_SKIP_MULTICAST}
  GAA_FLAG_SKIP_DNS_SERVER  = $0008;
  {$EXTERNALSYM GAA_FLAG_SKIP_DNS_SERVER}
  GAA_FLAG_INCLUDE_PREFIX   = $0010;
  {$EXTERNALSYM GAA_FLAG_INCLUDE_PREFIX}
  GAA_FLAG_SKIP_FRIENDLY_NAME = $0020;
  {$EXTERNALSYM GAA_FLAG_SKIP_FRIENDLY_NAME}

//
// IP_PER_ADAPTER_INFO - per-adapter IP information such as DNS server list.
//

type
  PIP_PER_ADAPTER_INFO = ^IP_PER_ADAPTER_INFO;
  {$EXTERNALSYM PIP_PER_ADAPTER_INFO}
  _IP_PER_ADAPTER_INFO = record
    AutoconfigEnabled: UINT;
    AutoconfigActive: UINT;
    CurrentDnsServer: PIP_ADDR_STRING;
    DnsServerList: IP_ADDR_STRING;
  end;
  {$EXTERNALSYM _IP_PER_ADAPTER_INFO}
  IP_PER_ADAPTER_INFO = _IP_PER_ADAPTER_INFO;
  {$EXTERNALSYM IP_PER_ADAPTER_INFO}
  TIpPerAdapterInfo = IP_PER_ADAPTER_INFO;
  {$EXTERNALSYM TIpPerAdapterInfo}
  PIpPerAdapterInfo = PIP_PER_ADAPTER_INFO;

//
// FIXED_INFO - the set of IP-related information which does not depend on DHCP
//

  PFIXED_INFO = ^FIXED_INFO;
  {$EXTERNALSYM PFIXED_INFO}
  FIXED_INFO = record
    HostName: array [0..MAX_HOSTNAME_LEN + 3] of AnsiChar;
    DomainName: array[0..MAX_DOMAIN_NAME_LEN + 3] of AnsiChar;
    CurrentDnsServer: PIP_ADDR_STRING;
    DnsServerList: IP_ADDR_STRING;
    NodeType: UINT;
    ScopeId: array [0..MAX_SCOPE_ID_LEN + 3] of AnsiChar;
    EnableRouting: UINT;
    EnableProxy: UINT;
    EnableDns: UINT;
  end;
  {$EXTERNALSYM FIXED_INFO}
  TFixedInfo = FIXED_INFO;
  PFixedInfo = PFIXED_INFO;

  IP_INTERFACE_NAME_INFO = record
    Index: ULONG;      // Interface Index
    MediaType: ULONG;  // Interface Types - see ipifcons.h
    ConnectionType: UCHAR;
    AccessType: UCHAR;
    DeviceGuid: TGUID; // Device GUID is the guid of the device
                       // that IP exposes
    InterfaceGuid: TGUID; // Interface GUID, if not GUID_NULL is the
                          // GUID for the interface mapped to the device.
  end;
  {$EXTERNALSYM IP_INTERFACE_NAME_INFO}
  PIP_INTERFACE_NAME_INFO = ^IP_INTERFACE_NAME_INFO;
  {$EXTERNALSYM PIP_INTERFACE_NAME_INFO}
  TIpInterfaceNameInfo = IP_INTERFACE_NAME_INFO;
  PIpInterfaceNameInfo = ^IP_INTERFACE_NAME_INFO;

implementation
//uses ...

end.

