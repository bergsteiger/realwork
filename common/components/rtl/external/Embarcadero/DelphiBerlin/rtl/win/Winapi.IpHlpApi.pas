{******************************************************************************}
{                                                                              }
{ Internet Protocol Helper API interface Unit for Object Pascal                }
{                                                                              }
{ Portions created by Microsoft are Copyright (C) 1995-2001 Microsoft          }
{ Corporation. All Rights Reserved.                                            }
{                                                                              }
{ The original file is: iphlpapi.h, released August 2000. The original Pascal  }
{ code is: IpHlpApi.pas, released September 2000. The initial developer of the }
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

// $Id: JwaIpHlpApi.pas,v 1.11 2007/09/05 11:58:50 dezipaitor Exp $
unit Winapi.IpHlpApi;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT ''}
{$HPPEMIT '#include "iphlpapi.h"'}
{$HPPEMIT ''}

interface

uses
  Winapi.Windows, Winapi.WinSock, Winapi.IpTypes, Winapi.IpRtrMib, Winapi.IpExport;

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// IPRTRMIB.H has the definitions of the strcutures used to set and get     //
// information                                                              //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

// #include <iprtrmib.h>
// #include <ipexport.h>
// #include <iptypes.h>

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// The GetXXXTable APIs take a buffer and a size of buffer.  If the buffer  //
// is not large enough, the APIs return ERROR_INSUFFICIENT_BUFFER  and      //
// *pdwSize is the required buffer size                                     //
// The bOrder is a BOOLEAN, which if TRUE sorts the table according to      //
// MIB-II (RFC XXXX)                                                        //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Retrieves the number of interfaces in the system. These include LAN and  //
// WAN interfaces                                                           //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function GetNumberOfInterfaces(var pdwNumIf: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetNumberOfInterfaces}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Gets the MIB-II ifEntry                                                  //
// The dwIndex field of the MIB_IFROW should be set to the index of the     //
// interface being queried                                                  //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function GetIfEntry(pIfRow: PMIB_IFROW): DWORD; stdcall;
{$EXTERNALSYM GetIfEntry}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Gets the MIB-II IfTable                                                  //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function GetIfTable(pIfTable: PMIB_IFTABLE; var pdwSize: ULONG; bOrder: BOOL): DWORD; stdcall;
{$EXTERNALSYM GetIfTable}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Gets the Interface to IP Address mapping                                 //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function GetIpAddrTable(pIpAddrTable: PMIB_IPADDRTABLE; var pdwSize: ULONG; bOrder: BOOL): DWORD; stdcall;
{$EXTERNALSYM GetIpAddrTable}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Gets the current IP Address to Physical Address (ARP) mapping            //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function GetIpNetTable(pIpNetTable: PMIB_IPNETTABLE; var pdwSize: ULONG; bOrder: BOOL): DWORD; stdcall;
{$EXTERNALSYM GetIpNetTable}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Gets the IP Routing Table  (RFX XXXX)                                    //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function GetIpForwardTable(pIpForwardTable: PMIB_IPFORWARDTABLE; var pdwSize: ULONG;
  bOrder: BOOL): DWORD; stdcall;
{$EXTERNALSYM GetIpForwardTable}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Gets TCP Connection/UDP Listener Table                                   //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function GetTcpTable(pTcpTable: PMIB_TCPTABLE; var pdwSize: DWORD; bOrder: BOOL): DWORD; stdcall;
{$EXTERNALSYM GetTcpTable}

function GetUdpTable(pUdpTable: PMIB_UDPTABLE; var pdwSize: DWORD; bOrder: BOOL): DWORD; stdcall;
{$EXTERNALSYM GetUdpTable}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Gets IP/ICMP/TCP/UDP Statistics                                          //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function GetIpStatistics(var pStats: MIB_IPSTATS): DWORD; stdcall;
{$EXTERNALSYM GetIpStatistics}

function GetIpStatisticsEx(pStats: PMIB_IPSTATS; dwFamily: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetIpStatisticsEx}

function GetIcmpStatistics(var pStats: MIB_ICMP): DWORD; stdcall;
{$EXTERNALSYM GetIcmpStatistics}

function GetIcmpStatisticsEx(pStats: PMIB_ICMP_EX; dwFamily: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetIcmpStatisticsEx}

function GetTcpStatistics(var pStats: MIB_TCPSTATS): DWORD; stdcall;
{$EXTERNALSYM GetTcpStatistics}

function GetTcpStatisticsEx(pStats: PMIB_TCPSTATS; dwFamily: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetTcpStatisticsEx}

function GetUdpStatistics(var pStats: MIB_UDPSTATS): DWORD; stdcall;
{$EXTERNALSYM GetUdpStatistics}

function GetUdpStatisticsEx(pStats: PMIB_UDPSTATS; dwFamily: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetUdpStatisticsEx}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Used to set the ifAdminStatus on an interface.  The only fields of the   //
// MIB_IFROW that are relevant are the dwIndex (index of the interface      //
// whose status needs to be set) and the dwAdminStatus which can be either  //
// MIB_IF_ADMIN_STATUS_UP or MIB_IF_ADMIN_STATUS_DOWN                       //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function SetIfEntry(const pIfRow: MIB_IFROW): DWORD; stdcall;
{$EXTERNALSYM SetIfEntry}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Used to create, modify or delete a route.  In all cases the              //
// dwForwardIfIndex, dwForwardDest, dwForwardMask, dwForwardNextHop and     //
// dwForwardPolicy MUST BE SPECIFIED. Currently dwForwardPolicy is unused   //
// and MUST BE 0.                                                           //
// For a set, the complete MIB_IPFORWARDROW structure must be specified     //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function CreateIpForwardEntry(const pRoute: MIB_IPFORWARDROW): DWORD; stdcall;
{$EXTERNALSYM CreateIpForwardEntry}

function SetIpForwardEntry(const pRoute: MIB_IPFORWARDROW): DWORD; stdcall;
{$EXTERNALSYM SetIpForwardEntry}

function DeleteIpForwardEntry(const pRoute: MIB_IPFORWARDROW): DWORD; stdcall;
{$EXTERNALSYM DeleteIpForwardEntry}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Used to set the ipForwarding to ON or OFF (currently only ON->OFF is     //
// allowed) and to set the defaultTTL.  If only one of the fields needs to  //
// be modified and the other needs to be the same as before the other field //
// needs to be set to MIB_USE_CURRENT_TTL or MIB_USE_CURRENT_FORWARDING as  //
// the case may be                                                          //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function SetIpStatistics(const pIpStats: MIB_IPSTATS): DWORD; stdcall;
{$EXTERNALSYM SetIpStatistics}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Used to set the defaultTTL.                                              //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function SetIpTTL(nTTL: UINT): DWORD; stdcall;
{$EXTERNALSYM SetIpTTL}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Used to create, modify or delete an ARP entry.  In all cases the dwIndex //
// dwAddr field MUST BE SPECIFIED.                                          //
// For a set, the complete MIB_IPNETROW structure must be specified         //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function CreateIpNetEntry(const pArpEntry: MIB_IPNETROW): DWORD; stdcall;
{$EXTERNALSYM CreateIpNetEntry}

function SetIpNetEntry(const pArpEntry: MIB_IPNETROW): DWORD; stdcall;
{$EXTERNALSYM SetIpNetEntry}

function DeleteIpNetEntry(const pArpEntry: MIB_IPNETROW): DWORD; stdcall;
{$EXTERNALSYM DeleteIpNetEntry}

function FlushIpNetTable(dwIfIndex: DWORD): DWORD; stdcall;
{$EXTERNALSYM FlushIpNetTable}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Used to create or delete a Proxy ARP entry. The dwIndex is the index of  //
// the interface on which to PARP for the dwAddress.  If the interface is   //
// of a type that doesnt support ARP, e.g. PPP, then the call will fail     //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function CreateProxyArpEntry(dwAddress, dwMask, dwIfIndex: DWORD): DWORD; stdcall;
{$EXTERNALSYM CreateProxyArpEntry}

function DeleteProxyArpEntry(dwAddress, dwMask, dwIfIndex: DWORD): DWORD; stdcall;
{$EXTERNALSYM DeleteProxyArpEntry}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Used to set the state of a TCP Connection. The only state that it can be //
// set to is MIB_TCP_STATE_DELETE_TCB.  The complete MIB_TCPROW structure   //
// MUST BE SPECIFIED                                                        //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function SetTcpEntry(const pTcpRow: MIB_TCPROW): DWORD; stdcall;
{$EXTERNALSYM SetTcpEntry}

function GetInterfaceInfo(pIfTable: PIP_INTERFACE_INFO; var dwOutBufLen: ULONG): DWORD; stdcall;
{$EXTERNALSYM GetInterfaceInfo}

function GetUniDirectionalAdapterInfo(pIPIfInfo: PIP_UNIDIRECTIONAL_ADAPTER_ADDRESS;
  var dwOutBufLen: ULONG): DWORD; stdcall;
{$EXTERNALSYM GetUniDirectionalAdapterInfo(OUT PIP_UNIDIRECTIONAL_ADAPTER_ADDRESS pIPIfInfo}

function NhpAllocateAndGetInterfaceInfoFromStack(out ppTable: PIP_INTERFACE_NAME_INFO;
  pdwCount: PDWORD; bOrder: BOOL; hHeap: THandle; dwFlags: DWORD): DWORD; stdcall;
{$EXTERNALSYM NhpAllocateAndGetInterfaceInfoFromStack}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Gets the "best" outgoing interface for the specified destination address //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function GetBestInterface(dwDestAddr: IPAddr; var pdwBestIfIndex: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetBestInterface}

function GetBestInterfaceEx(pDestAddr: PSockAddr; var pdwBestIfIndex: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetBestInterfaceEx}

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
// Gets the best (longest matching prefix) route for the given destination  //
// If the source address is also specified (i.e. is not 0x00000000), and    //
// there are multiple "best" routes to the given destination, the returned  //
// route will be one that goes out over the interface which has an address  //
// that matches the source address                                          //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

function GetBestRoute(dwDestAddr, dwSourceAddr: DWORD; pBestRoute: PMIB_IPFORWARDROW): DWORD; stdcall;
{$EXTERNALSYM GetBestRoute}

function NotifyAddrChange(var Handle: THandle; overlapped: POVERLAPPED): DWORD; stdcall;
{$EXTERNALSYM NotifyAddrChange}

function NotifyRouteChange(var Handle: THandle; overlapped: POVERLAPPED): DWORD; stdcall;
{$EXTERNALSYM NotifyRouteChange}

function CancelIPChangeNotify(notifyOverlapped: POVERLAPPED): BOOL; stdcall;
{$EXTERNALSYM CancelIPChangeNotify}

function GetAdapterIndex(AdapterName: LPWSTR; var IfIndex: ULONG): DWORD; stdcall;
{$EXTERNALSYM GetAdapterIndex}

function AddIPAddress(Address: IPAddr; IpMask: IPMask; IfIndex: DWORD;
  var NTEContext, NTEInstance: ULONG): DWORD; stdcall;
{$EXTERNALSYM AddIPAddress}

function DeleteIPAddress(NTEContext: ULONG): DWORD; stdcall;
{$EXTERNALSYM DeleteIPAddress}

function GetNetworkParams(pFixedInfo: PFIXED_INFO; var pOutBufLen: ULONG): DWORD; stdcall;
{$EXTERNALSYM GetNetworkParams}

function GetAdaptersInfo(pAdapterInfo: PIP_ADAPTER_INFO; var pOutBufLen: ULONG): DWORD; stdcall;
{$EXTERNALSYM GetAdaptersInfo}

function GetAdapterOrderMap: PIP_ADAPTER_ORDER_MAP; stdcall;
{$EXTERNALSYM GetAdapterOrderMap}

//
// The following functions require Winsock2.
//

function GetAdaptersAddresses(Family: ULONG; Flags: DWORD; Reserved: PVOID;
  pAdapterAddresses: PIP_ADAPTER_ADDRESSES; pOutBufLen: PULONG): DWORD; stdcall;
{$EXTERNALSYM GetAdaptersAddresses}

function GetPerAdapterInfo(IfIndex: ULONG; pPerAdapterInfo: PIP_PER_ADAPTER_INFO;
  var pOutBufLen: ULONG): DWORD; stdcall;
{$EXTERNALSYM GetPerAdapterInfo}

function IpReleaseAddress(const AdapterInfo: IP_ADAPTER_INDEX_MAP): DWORD; stdcall;
{$EXTERNALSYM IpReleaseAddress}

function IpRenewAddress(const AdapterInfo: IP_ADAPTER_INDEX_MAP): DWORD; stdcall;
{$EXTERNALSYM IpRenewAddress}

function SendARP(const DestIP, SrcIP: IPAddr; pMacAddr: PULONG; var PhyAddrLen: ULONG): DWORD; stdcall;
{$EXTERNALSYM SendARP}

function GetRTTAndHopCount(DestIpAddress: IPAddr; var HopCount: ULONG;
  MaxHops: ULONG; var RTT: ULONG): BOOL; stdcall;
{$EXTERNALSYM GetRTTAndHopCount}

function GetFriendlyIfIndex(IfIndex: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetFriendlyIfIndex}

function EnableRouter(var pHandle: THandle; pOverlapped: POVERLAPPED): DWORD; stdcall;
{$EXTERNALSYM EnableRouter}

function UnenableRouter(pOverlapped: POVERLAPPED; lpdwEnableCount: LPDWORD): DWORD; stdcall;
{$EXTERNALSYM UnenableRouter}

function DisableMediaSense(var pHandle: THandle; pOverLapped: POVERLAPPED): DWORD; stdcall;
{$EXTERNALSYM DisableMediaSense}

function RestoreMediaSense(pOverlapped: POVERLAPPED; lpdwEnableCount: LPDWORD): DWORD; stdcall;
{$EXTERNALSYM RestoreMediaSense}

function GetIpErrorString(ErrorCode: IP_STATUS; Buffer: PWCHAR; var Size: DWORD): DWORD; stdcall;
{$EXTERNALSYM GetIpErrorString}

implementation
//uses ...



const
  iphlpapilib = 'iphlpapi.dll';

function GetNumberOfInterfaces; external iphlpapilib name 'GetNumberOfInterfaces';
function GetIfEntry; external iphlpapilib name 'GetIfEntry';
function GetIfTable; external iphlpapilib name 'GetIfTable';
function GetIpAddrTable; external iphlpapilib name 'GetIpAddrTable';
function GetIpNetTable; external iphlpapilib name 'GetIpNetTable';
function GetIpForwardTable; external iphlpapilib name 'GetIpForwardTable';
function GetTcpTable; external iphlpapilib name 'GetTcpTable';
function GetUdpTable; external iphlpapilib name 'GetUdpTable';
function GetIpStatistics; external iphlpapilib name 'GetIpStatistics';
function GetIpStatisticsEx; external iphlpapilib name 'GetIpStatisticsEx';
function GetIcmpStatistics; external iphlpapilib name 'GetIcmpStatistics';
function GetIcmpStatisticsEx; external iphlpapilib name 'GetIcmpStatisticsEx';
function GetTcpStatistics; external iphlpapilib name 'GetTcpStatistics';
function GetTcpStatisticsEx; external iphlpapilib name 'GetTcpStatisticsEx';
function GetUdpStatistics; external iphlpapilib name 'GetUdpStatistics';
function GetUdpStatisticsEx; external iphlpapilib name 'GetUdpStatisticsEx';
function SetIfEntry; external iphlpapilib name 'SetIfEntry';
function CreateIpForwardEntry; external iphlpapilib name 'CreateIpForwardEntry';
function SetIpForwardEntry; external iphlpapilib name 'SetIpForwardEntry';
function DeleteIpForwardEntry; external iphlpapilib name 'DeleteIpForwardEntry';
function SetIpStatistics; external iphlpapilib name 'SetIpStatistics';
function SetIpTTL; external iphlpapilib name 'SetIpTTL';
function CreateIpNetEntry; external iphlpapilib name 'CreateIpNetEntry';
function SetIpNetEntry; external iphlpapilib name 'SetIpNetEntry';
function DeleteIpNetEntry; external iphlpapilib name 'DeleteIpNetEntry';
function FlushIpNetTable; external iphlpapilib name 'FlushIpNetTable';
function CreateProxyArpEntry; external iphlpapilib name 'CreateProxyArpEntry';
function DeleteProxyArpEntry; external iphlpapilib name 'DeleteProxyArpEntry';
function SetTcpEntry; external iphlpapilib name 'SetTcpEntry';
function GetInterfaceInfo; external iphlpapilib name 'GetInterfaceInfo';
function GetUniDirectionalAdapterInfo; external iphlpapilib name 'GetUniDirectionalAdapterInfo';
function NhpAllocateAndGetInterfaceInfoFromStack; external iphlpapilib name 'NhpAllocateAndGetInterfaceInfoFromStack';
function GetBestInterface; external iphlpapilib name 'GetBestInterface';
function GetBestInterfaceEx; external iphlpapilib name 'GetBestInterfaceEx';
function GetBestRoute; external iphlpapilib name 'GetBestRoute';
function NotifyAddrChange; external iphlpapilib name 'NotifyAddrChange';
function NotifyRouteChange; external iphlpapilib name 'NotifyRouteChange';
function CancelIPChangeNotify; external iphlpapilib name 'CancelIPChangeNotify';
function GetAdapterIndex; external iphlpapilib name 'GetAdapterIndex';
function AddIPAddress; external iphlpapilib name 'AddIPAddress';
function DeleteIPAddress; external iphlpapilib name 'DeleteIPAddress';
function GetNetworkParams; external iphlpapilib name 'GetNetworkParams';
function GetAdaptersInfo; external iphlpapilib name 'GetAdaptersInfo';
function GetAdapterOrderMap; external iphlpapilib name 'GetAdapterOrderMap';
function GetAdaptersAddresses; external iphlpapilib name 'GetAdaptersAddresses';
function GetPerAdapterInfo; external iphlpapilib name 'GetPerAdapterInfo';
function IpReleaseAddress; external iphlpapilib name 'IpReleaseAddress';
function IpRenewAddress; external iphlpapilib name 'IpRenewAddress';
function SendARP; external iphlpapilib name 'SendARP';
function GetRTTAndHopCount; external iphlpapilib name 'GetRTTAndHopCount';
function GetFriendlyIfIndex; external iphlpapilib name 'GetFriendlyIfIndex';
function EnableRouter; external iphlpapilib name 'EnableRouter';
function UnenableRouter; external iphlpapilib name 'UnenableRouter';
function DisableMediaSense; external iphlpapilib name 'DisableMediaSense';
function RestoreMediaSense; external iphlpapilib name 'RestoreMediaSense';
function GetIpErrorString; external iphlpapilib name 'GetIpErrorString';

end.

