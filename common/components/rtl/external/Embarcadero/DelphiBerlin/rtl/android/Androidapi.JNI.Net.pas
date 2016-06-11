{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Net;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.Java.Net,
  Androidapi.JNI.Java.Security,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os;

type
// ===== Forward declarations =====

  JCaptivePortal = interface;//android.net.CaptivePortal
  JConnectivityManager = interface;//android.net.ConnectivityManager
  JConnectivityManager_NetworkCallback = interface;//android.net.ConnectivityManager$NetworkCallback
  JConnectivityManager_OnNetworkActiveListener = interface;//android.net.ConnectivityManager$OnNetworkActiveListener
  Jnet_Credentials = interface;//android.net.Credentials
  JDhcpInfo = interface;//android.net.DhcpInfo
  JIpPrefix = interface;//android.net.IpPrefix
  JLinkAddress = interface;//android.net.LinkAddress
  JLinkProperties = interface;//android.net.LinkProperties
  JLocalServerSocket = interface;//android.net.LocalServerSocket
  JLocalSocket = interface;//android.net.LocalSocket
  JLocalSocketAddress = interface;//android.net.LocalSocketAddress
  JLocalSocketAddress_Namespace = interface;//android.net.LocalSocketAddress$Namespace
  JMailTo = interface;//android.net.MailTo
  JNetwork = interface;//android.net.Network
  JNetworkCapabilities = interface;//android.net.NetworkCapabilities
  JNetworkInfo = interface;//android.net.NetworkInfo
  JNetworkInfo_DetailedState = interface;//android.net.NetworkInfo$DetailedState
  JNetworkInfo_State = interface;//android.net.NetworkInfo$State
  JNetworkRequest = interface;//android.net.NetworkRequest
  JNetworkRequest_Builder = interface;//android.net.NetworkRequest$Builder
  Jnet_ParseException = interface;//android.net.ParseException
  Jnet_Proxy = interface;//android.net.Proxy
  JProxyInfo = interface;//android.net.ProxyInfo
  JPskKeyManager = interface;//android.net.PskKeyManager
  Jnet_RouteInfo = interface;//android.net.RouteInfo
  JSSLCertificateSocketFactory = interface;//android.net.SSLCertificateSocketFactory
  JSSLSessionCache = interface;//android.net.SSLSessionCache
  JTrafficStats = interface;//android.net.TrafficStats
  Jnet_Uri = interface;//android.net.Uri
  JUri_Builder = interface;//android.net.Uri$Builder
  JUrlQuerySanitizer = interface;//android.net.UrlQuerySanitizer
  JUrlQuerySanitizer_IllegalCharacterValueSanitizer = interface;//android.net.UrlQuerySanitizer$IllegalCharacterValueSanitizer
  JUrlQuerySanitizer_ParameterValuePair = interface;//android.net.UrlQuerySanitizer$ParameterValuePair
  JUrlQuerySanitizer_ValueSanitizer = interface;//android.net.UrlQuerySanitizer$ValueSanitizer
  //JVpnService = interface;//android.net.VpnService
  JVpnService_Builder = interface;//android.net.VpnService$Builder
  JHttpResponseCache = interface;//android.net.http.HttpResponseCache
  JSslCertificate = interface;//android.net.http.SslCertificate
  JSslCertificate_DName = interface;//android.net.http.SslCertificate$DName
  JSslError = interface;//android.net.http.SslError
  JX509TrustManagerExtensions = interface;//android.net.http.X509TrustManagerExtensions
  JNsdManager = interface;//android.net.nsd.NsdManager
  JNsdManager_DiscoveryListener = interface;//android.net.nsd.NsdManager$DiscoveryListener
  JNsdManager_RegistrationListener = interface;//android.net.nsd.NsdManager$RegistrationListener
  JNsdManager_ResolveListener = interface;//android.net.nsd.NsdManager$ResolveListener
  JNsdServiceInfo = interface;//android.net.nsd.NsdServiceInfo
  JAudioCodec = interface;//android.net.rtp.AudioCodec
  JAudioGroup = interface;//android.net.rtp.AudioGroup
  JRtpStream = interface;//android.net.rtp.RtpStream
  JAudioStream = interface;//android.net.rtp.AudioStream
  JSipAudioCall = interface;//android.net.sip.SipAudioCall
  JSipAudioCall_Listener = interface;//android.net.sip.SipAudioCall$Listener
  JSipErrorCode = interface;//android.net.sip.SipErrorCode
  JSipException = interface;//android.net.sip.SipException
  JSipManager = interface;//android.net.sip.SipManager
  JSipProfile = interface;//android.net.sip.SipProfile
  JSipProfile_Builder = interface;//android.net.sip.SipProfile$Builder
  JSipRegistrationListener = interface;//android.net.sip.SipRegistrationListener
  JSipSession = interface;//android.net.sip.SipSession
  JSipSession_Listener = interface;//android.net.sip.SipSession$Listener
  JSipSession_State = interface;//android.net.sip.SipSession$State
  JScanResult = interface;//android.net.wifi.ScanResult
  JSupplicantState = interface;//android.net.wifi.SupplicantState
  JWifiConfiguration = interface;//android.net.wifi.WifiConfiguration
  JWifiConfiguration_AuthAlgorithm = interface;//android.net.wifi.WifiConfiguration$AuthAlgorithm
  JWifiConfiguration_GroupCipher = interface;//android.net.wifi.WifiConfiguration$GroupCipher
  JWifiConfiguration_KeyMgmt = interface;//android.net.wifi.WifiConfiguration$KeyMgmt
  JWifiConfiguration_PairwiseCipher = interface;//android.net.wifi.WifiConfiguration$PairwiseCipher
  JWifiConfiguration_Protocol = interface;//android.net.wifi.WifiConfiguration$Protocol
  JWifiConfiguration_Status = interface;//android.net.wifi.WifiConfiguration$Status
  JWifiEnterpriseConfig = interface;//android.net.wifi.WifiEnterpriseConfig
  JWifiEnterpriseConfig_Eap = interface;//android.net.wifi.WifiEnterpriseConfig$Eap
  JWifiEnterpriseConfig_Phase2 = interface;//android.net.wifi.WifiEnterpriseConfig$Phase2
  JWifiInfo = interface;//android.net.wifi.WifiInfo
  JWifiManager = interface;//android.net.wifi.WifiManager
  JWifiManager_MulticastLock = interface;//android.net.wifi.WifiManager$MulticastLock
  JWifiManager_WifiLock = interface;//android.net.wifi.WifiManager$WifiLock
  JWifiManager_WpsCallback = interface;//android.net.wifi.WifiManager$WpsCallback
  JWpsInfo = interface;//android.net.wifi.WpsInfo
  JWifiP2pConfig = interface;//android.net.wifi.p2p.WifiP2pConfig
  JWifiP2pDevice = interface;//android.net.wifi.p2p.WifiP2pDevice
  JWifiP2pDeviceList = interface;//android.net.wifi.p2p.WifiP2pDeviceList
  JWifiP2pGroup = interface;//android.net.wifi.p2p.WifiP2pGroup
  JWifiP2pInfo = interface;//android.net.wifi.p2p.WifiP2pInfo
  JWifiP2pManager = interface;//android.net.wifi.p2p.WifiP2pManager
  JWifiP2pManager_ActionListener = interface;//android.net.wifi.p2p.WifiP2pManager$ActionListener
  JWifiP2pManager_Channel = interface;//android.net.wifi.p2p.WifiP2pManager$Channel
  JWifiP2pManager_ChannelListener = interface;//android.net.wifi.p2p.WifiP2pManager$ChannelListener
  JWifiP2pManager_ConnectionInfoListener = interface;//android.net.wifi.p2p.WifiP2pManager$ConnectionInfoListener
  JWifiP2pManager_DnsSdServiceResponseListener = interface;//android.net.wifi.p2p.WifiP2pManager$DnsSdServiceResponseListener
  JWifiP2pManager_DnsSdTxtRecordListener = interface;//android.net.wifi.p2p.WifiP2pManager$DnsSdTxtRecordListener
  JWifiP2pManager_GroupInfoListener = interface;//android.net.wifi.p2p.WifiP2pManager$GroupInfoListener
  JWifiP2pManager_PeerListListener = interface;//android.net.wifi.p2p.WifiP2pManager$PeerListListener
  JWifiP2pManager_ServiceResponseListener = interface;//android.net.wifi.p2p.WifiP2pManager$ServiceResponseListener
  JWifiP2pManager_UpnpServiceResponseListener = interface;//android.net.wifi.p2p.WifiP2pManager$UpnpServiceResponseListener
  JWifiP2pServiceInfo = interface;//android.net.wifi.p2p.nsd.WifiP2pServiceInfo
  JWifiP2pDnsSdServiceInfo = interface;//android.net.wifi.p2p.nsd.WifiP2pDnsSdServiceInfo
  JWifiP2pServiceRequest = interface;//android.net.wifi.p2p.nsd.WifiP2pServiceRequest
  JWifiP2pDnsSdServiceRequest = interface;//android.net.wifi.p2p.nsd.WifiP2pDnsSdServiceRequest
  JWifiP2pUpnpServiceInfo = interface;//android.net.wifi.p2p.nsd.WifiP2pUpnpServiceInfo
  JWifiP2pUpnpServiceRequest = interface;//android.net.wifi.p2p.nsd.WifiP2pUpnpServiceRequest

// ===== Interface declarations =====

  JCaptivePortalClass = interface(JObjectClass)
    ['{7DFB7B36-59D5-405E-9DE8-E0DF58B16896}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/CaptivePortal')]
  JCaptivePortal = interface(JObject)
    ['{2AABBCBD-CDF6-4E74-90C4-EB9A987AA631}']
    function describeContents: Integer; cdecl;
    procedure ignoreNetwork; cdecl;
    procedure reportCaptivePortalDismissed; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJCaptivePortal = class(TJavaGenericImport<JCaptivePortalClass, JCaptivePortal>) end;

  JConnectivityManagerClass = interface(JObjectClass)
    ['{BEFD9BFE-5C37-4A44-9EF3-E194A9046AC1}']
    {class} function _GetACTION_BACKGROUND_DATA_SETTING_CHANGED: JString; cdecl;
    {class} function _GetACTION_CAPTIVE_PORTAL_SIGN_IN: JString; cdecl;
    {class} function _GetCONNECTIVITY_ACTION: JString; cdecl;
    {class} function _GetDEFAULT_NETWORK_PREFERENCE: Integer; cdecl;
    {class} function _GetEXTRA_CAPTIVE_PORTAL: JString; cdecl;
    {class} function _GetEXTRA_EXTRA_INFO: JString; cdecl;
    {class} function _GetEXTRA_IS_FAILOVER: JString; cdecl;
    {class} function _GetEXTRA_NETWORK: JString; cdecl;
    {class} function _GetEXTRA_NETWORK_INFO: JString; cdecl;
    {class} function _GetEXTRA_NETWORK_REQUEST: JString; cdecl;
    {class} function _GetEXTRA_NETWORK_TYPE: JString; cdecl;
    {class} function _GetEXTRA_NO_CONNECTIVITY: JString; cdecl;
    {class} function _GetEXTRA_OTHER_NETWORK_INFO: JString; cdecl;
    {class} function _GetEXTRA_REASON: JString; cdecl;
    {class} function _GetTYPE_BLUETOOTH: Integer; cdecl;
    {class} function _GetTYPE_DUMMY: Integer; cdecl;
    {class} function _GetTYPE_ETHERNET: Integer; cdecl;
    {class} function _GetTYPE_MOBILE: Integer; cdecl;
    {class} function _GetTYPE_MOBILE_DUN: Integer; cdecl;
    {class} function _GetTYPE_MOBILE_HIPRI: Integer; cdecl;
    {class} function _GetTYPE_MOBILE_MMS: Integer; cdecl;
    {class} function _GetTYPE_MOBILE_SUPL: Integer; cdecl;
    {class} function _GetTYPE_VPN: Integer; cdecl;
    {class} function _GetTYPE_WIFI: Integer; cdecl;
    {class} function _GetTYPE_WIMAX: Integer; cdecl;
    {class} function getProcessDefaultNetwork: JNetwork; cdecl;//Deprecated
    {class} function isNetworkTypeValid(networkType: Integer): Boolean; cdecl;//Deprecated
    {class} function setProcessDefaultNetwork(network: JNetwork): Boolean; cdecl;//Deprecated
    {class} property ACTION_BACKGROUND_DATA_SETTING_CHANGED: JString read _GetACTION_BACKGROUND_DATA_SETTING_CHANGED;
    {class} property ACTION_CAPTIVE_PORTAL_SIGN_IN: JString read _GetACTION_CAPTIVE_PORTAL_SIGN_IN;
    {class} property CONNECTIVITY_ACTION: JString read _GetCONNECTIVITY_ACTION;
    {class} property DEFAULT_NETWORK_PREFERENCE: Integer read _GetDEFAULT_NETWORK_PREFERENCE;
    {class} property EXTRA_CAPTIVE_PORTAL: JString read _GetEXTRA_CAPTIVE_PORTAL;
    {class} property EXTRA_EXTRA_INFO: JString read _GetEXTRA_EXTRA_INFO;
    {class} property EXTRA_IS_FAILOVER: JString read _GetEXTRA_IS_FAILOVER;
    {class} property EXTRA_NETWORK: JString read _GetEXTRA_NETWORK;
    {class} property EXTRA_NETWORK_INFO: JString read _GetEXTRA_NETWORK_INFO;
    {class} property EXTRA_NETWORK_REQUEST: JString read _GetEXTRA_NETWORK_REQUEST;
    {class} property EXTRA_NETWORK_TYPE: JString read _GetEXTRA_NETWORK_TYPE;
    {class} property EXTRA_NO_CONNECTIVITY: JString read _GetEXTRA_NO_CONNECTIVITY;
    {class} property EXTRA_OTHER_NETWORK_INFO: JString read _GetEXTRA_OTHER_NETWORK_INFO;
    {class} property EXTRA_REASON: JString read _GetEXTRA_REASON;
    {class} property TYPE_BLUETOOTH: Integer read _GetTYPE_BLUETOOTH;
    {class} property TYPE_DUMMY: Integer read _GetTYPE_DUMMY;
    {class} property TYPE_ETHERNET: Integer read _GetTYPE_ETHERNET;
    {class} property TYPE_MOBILE: Integer read _GetTYPE_MOBILE;
    {class} property TYPE_MOBILE_DUN: Integer read _GetTYPE_MOBILE_DUN;
    {class} property TYPE_MOBILE_HIPRI: Integer read _GetTYPE_MOBILE_HIPRI;
    {class} property TYPE_MOBILE_MMS: Integer read _GetTYPE_MOBILE_MMS;
    {class} property TYPE_MOBILE_SUPL: Integer read _GetTYPE_MOBILE_SUPL;
    {class} property TYPE_VPN: Integer read _GetTYPE_VPN;
    {class} property TYPE_WIFI: Integer read _GetTYPE_WIFI;
    {class} property TYPE_WIMAX: Integer read _GetTYPE_WIMAX;
  end;

  [JavaSignature('android/net/ConnectivityManager')]
  JConnectivityManager = interface(JObject)
    ['{B3A3E3BA-1E2F-4634-9E54-79F414E0813A}']
    procedure addDefaultNetworkActiveListener(l: JConnectivityManager_OnNetworkActiveListener); cdecl;
    function bindProcessToNetwork(network: JNetwork): Boolean; cdecl;
    function getActiveNetwork: JNetwork; cdecl;
    function getActiveNetworkInfo: JNetworkInfo; cdecl;
    function getAllNetworkInfo: TJavaObjectArray<JNetworkInfo>; cdecl;//Deprecated
    function getAllNetworks: TJavaObjectArray<JNetwork>; cdecl;
    function getBackgroundDataSetting: Boolean; cdecl;//Deprecated
    function getBoundNetworkForProcess: JNetwork; cdecl;
    function getDefaultProxy: JProxyInfo; cdecl;
    function getLinkProperties(network: JNetwork): JLinkProperties; cdecl;
    function getNetworkCapabilities(network: JNetwork): JNetworkCapabilities; cdecl;
    function getNetworkInfo(networkType: Integer): JNetworkInfo; cdecl; overload;//Deprecated
    function getNetworkInfo(network: JNetwork): JNetworkInfo; cdecl; overload;
    function getNetworkPreference: Integer; cdecl;//Deprecated
    function isActiveNetworkMetered: Boolean; cdecl;
    function isDefaultNetworkActive: Boolean; cdecl;
    procedure registerNetworkCallback(request: JNetworkRequest; networkCallback: JConnectivityManager_NetworkCallback); cdecl; overload;
    //procedure registerNetworkCallback(request: JNetworkRequest; operation: JPendingIntent); cdecl; overload;
    //procedure releaseNetworkRequest(operation: JPendingIntent); cdecl;
    procedure removeDefaultNetworkActiveListener(l: JConnectivityManager_OnNetworkActiveListener); cdecl;
    procedure reportBadNetwork(network: JNetwork); cdecl;//Deprecated
    procedure reportNetworkConnectivity(network: JNetwork; hasConnectivity: Boolean); cdecl;
    function requestBandwidthUpdate(network: JNetwork): Boolean; cdecl;
    procedure requestNetwork(request: JNetworkRequest; networkCallback: JConnectivityManager_NetworkCallback); cdecl; overload;
    //procedure requestNetwork(request: JNetworkRequest; operation: JPendingIntent); cdecl; overload;
    function requestRouteToHost(networkType: Integer; hostAddress: Integer): Boolean; cdecl;//Deprecated
    procedure setNetworkPreference(preference: Integer); cdecl;//Deprecated
    function startUsingNetworkFeature(networkType: Integer; feature: JString): Integer; cdecl;//Deprecated
    function stopUsingNetworkFeature(networkType: Integer; feature: JString): Integer; cdecl;//Deprecated
    procedure unregisterNetworkCallback(networkCallback: JConnectivityManager_NetworkCallback); cdecl; overload;
    //procedure unregisterNetworkCallback(operation: JPendingIntent); cdecl; overload;
  end;
  TJConnectivityManager = class(TJavaGenericImport<JConnectivityManagerClass, JConnectivityManager>) end;

  JConnectivityManager_NetworkCallbackClass = interface(JObjectClass)
    ['{FACA61E5-51BE-40EE-926D-4B9CC89C753A}']
    {class} function init: JConnectivityManager_NetworkCallback; cdecl;
  end;

  [JavaSignature('android/net/ConnectivityManager$NetworkCallback')]
  JConnectivityManager_NetworkCallback = interface(JObject)
    ['{BAE23872-6136-41C5-98F8-0A99D4217666}']
    procedure onAvailable(network: JNetwork); cdecl;
    procedure onCapabilitiesChanged(network: JNetwork; networkCapabilities: JNetworkCapabilities); cdecl;
    procedure onLinkPropertiesChanged(network: JNetwork; linkProperties: JLinkProperties); cdecl;
    procedure onLosing(network: JNetwork; maxMsToLive: Integer); cdecl;
    procedure onLost(network: JNetwork); cdecl;
  end;
  TJConnectivityManager_NetworkCallback = class(TJavaGenericImport<JConnectivityManager_NetworkCallbackClass, JConnectivityManager_NetworkCallback>) end;

  JConnectivityManager_OnNetworkActiveListenerClass = interface(IJavaClass)
    ['{1E79C682-34E5-4020-8142-CE9C6AF3054D}']
  end;

  [JavaSignature('android/net/ConnectivityManager$OnNetworkActiveListener')]
  JConnectivityManager_OnNetworkActiveListener = interface(IJavaInstance)
    ['{B3A1F8B2-A775-4883-BBB4-72CC948A73CE}']
    procedure onNetworkActive; cdecl;
  end;
  TJConnectivityManager_OnNetworkActiveListener = class(TJavaGenericImport<JConnectivityManager_OnNetworkActiveListenerClass, JConnectivityManager_OnNetworkActiveListener>) end;

  Jnet_CredentialsClass = interface(JObjectClass)
    ['{7945AFF6-6B7E-494E-8F69-E0729616FB7D}']
    {class} function init(pid: Integer; uid: Integer; gid: Integer): Jnet_Credentials; cdecl;
  end;

  [JavaSignature('android/net/Credentials')]
  Jnet_Credentials = interface(JObject)
    ['{9684E3E3-17DB-4157-88F6-8ED3AA37FD33}']
    function getGid: Integer; cdecl;
    function getPid: Integer; cdecl;
    function getUid: Integer; cdecl;
  end;
  TJnet_Credentials = class(TJavaGenericImport<Jnet_CredentialsClass, Jnet_Credentials>) end;

  JDhcpInfoClass = interface(JObjectClass)
    ['{D9CB198A-3E3F-40F8-8F10-B46CF06EE695}']
    {class} function init: JDhcpInfo; cdecl;
  end;

  [JavaSignature('android/net/DhcpInfo')]
  JDhcpInfo = interface(JObject)
    ['{15AE9247-20B6-412F-8A84-1A6EE8290F09}']
    function _Getdns1: Integer; cdecl;
    procedure _Setdns1(Value: Integer); cdecl;
    function _Getdns2: Integer; cdecl;
    procedure _Setdns2(Value: Integer); cdecl;
    function _Getgateway: Integer; cdecl;
    procedure _Setgateway(Value: Integer); cdecl;
    function _GetipAddress: Integer; cdecl;
    procedure _SetipAddress(Value: Integer); cdecl;
    function _GetleaseDuration: Integer; cdecl;
    procedure _SetleaseDuration(Value: Integer); cdecl;
    function _Getnetmask: Integer; cdecl;
    procedure _Setnetmask(Value: Integer); cdecl;
    function _GetserverAddress: Integer; cdecl;
    procedure _SetserverAddress(Value: Integer); cdecl;
    function toString: JString; cdecl;
    property dns1: Integer read _Getdns1 write _Setdns1;
    property dns2: Integer read _Getdns2 write _Setdns2;
    property gateway: Integer read _Getgateway write _Setgateway;
    property ipAddress: Integer read _GetipAddress write _SetipAddress;
    property leaseDuration: Integer read _GetleaseDuration write _SetleaseDuration;
    property netmask: Integer read _Getnetmask write _Setnetmask;
    property serverAddress: Integer read _GetserverAddress write _SetserverAddress;
  end;
  TJDhcpInfo = class(TJavaGenericImport<JDhcpInfoClass, JDhcpInfo>) end;

  JIpPrefixClass = interface(JObjectClass)
    ['{98BB4D07-AE46-47B2-8B66-B345256D5D89}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/IpPrefix')]
  JIpPrefix = interface(JObject)
    ['{4F0565A3-8FE5-46DA-8618-C7487E9A9FA8}']
    function &contains(address: JInetAddress): Boolean; cdecl;
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getAddress: JInetAddress; cdecl;
    function getPrefixLength: Integer; cdecl;
    function getRawAddress: TJavaArray<Byte>; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJIpPrefix = class(TJavaGenericImport<JIpPrefixClass, JIpPrefix>) end;

  JLinkAddressClass = interface(JObjectClass)
    ['{B5DAFF73-84C5-438B-83F4-56D01B8B9AD3}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/LinkAddress')]
  JLinkAddress = interface(JObject)
    ['{6B250E90-A674-4C44-966D-D399AEF49B8F}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getAddress: JInetAddress; cdecl;
    function getFlags: Integer; cdecl;
    function getPrefixLength: Integer; cdecl;
    function getScope: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJLinkAddress = class(TJavaGenericImport<JLinkAddressClass, JLinkAddress>) end;

  JLinkPropertiesClass = interface(JObjectClass)
    ['{2E2B6CEE-8281-4BFA-BB02-6A5641E1721E}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/LinkProperties')]
  JLinkProperties = interface(JObject)
    ['{58F5C8CE-C6BB-499D-96B9-20D0C6713D1A}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getDnsServers: JList; cdecl;
    function getDomains: JString; cdecl;
    function getHttpProxy: JProxyInfo; cdecl;
    function getInterfaceName: JString; cdecl;
    function getLinkAddresses: JList; cdecl;
    function getRoutes: JList; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJLinkProperties = class(TJavaGenericImport<JLinkPropertiesClass, JLinkProperties>) end;

  JLocalServerSocketClass = interface(JObjectClass)
    ['{B54083B7-63F8-4FEF-9DBF-CC7DC1AC6BFD}']
    {class} function init(name: JString): JLocalServerSocket; cdecl; overload;
    {class} function init(fd: JFileDescriptor): JLocalServerSocket; cdecl; overload;
  end;

  [JavaSignature('android/net/LocalServerSocket')]
  JLocalServerSocket = interface(JObject)
    ['{C54EEEF3-11C0-4B7D-9539-A0AE3D7DB6A7}']
    function accept: JLocalSocket; cdecl;
    procedure close; cdecl;
    function getFileDescriptor: JFileDescriptor; cdecl;
    function getLocalSocketAddress: JLocalSocketAddress; cdecl;
  end;
  TJLocalServerSocket = class(TJavaGenericImport<JLocalServerSocketClass, JLocalServerSocket>) end;

  JLocalSocketClass = interface(JObjectClass)
    ['{EBA731DA-98DE-49CA-BADC-02431412792F}']
    {class} function _GetSOCKET_DGRAM: Integer; cdecl;
    {class} function _GetSOCKET_SEQPACKET: Integer; cdecl;
    {class} function _GetSOCKET_STREAM: Integer; cdecl;
    {class} function init: JLocalSocket; cdecl; overload;
    {class} function init(sockType: Integer): JLocalSocket; cdecl; overload;
    {class} property SOCKET_DGRAM: Integer read _GetSOCKET_DGRAM;
    {class} property SOCKET_SEQPACKET: Integer read _GetSOCKET_SEQPACKET;
    {class} property SOCKET_STREAM: Integer read _GetSOCKET_STREAM;
  end;

  [JavaSignature('android/net/LocalSocket')]
  JLocalSocket = interface(JObject)
    ['{9F048906-3CE2-4B1F-AAF2-C92E28948A5D}']
    procedure bind(bindpoint: JLocalSocketAddress); cdecl;
    procedure close; cdecl;
    procedure connect(endpoint: JLocalSocketAddress); cdecl; overload;
    procedure connect(endpoint: JLocalSocketAddress; timeout: Integer); cdecl; overload;
    function getAncillaryFileDescriptors: TJavaObjectArray<JFileDescriptor>; cdecl;
    function getFileDescriptor: JFileDescriptor; cdecl;
    function getInputStream: JInputStream; cdecl;
    function getLocalSocketAddress: JLocalSocketAddress; cdecl;
    function getOutputStream: JOutputStream; cdecl;
    function getPeerCredentials: Jnet_Credentials; cdecl;
    function getReceiveBufferSize: Integer; cdecl;
    function getRemoteSocketAddress: JLocalSocketAddress; cdecl;
    function getSendBufferSize: Integer; cdecl;
    function getSoTimeout: Integer; cdecl;
    function isBound: Boolean; cdecl;
    function isClosed: Boolean; cdecl;
    function isConnected: Boolean; cdecl;
    function isInputShutdown: Boolean; cdecl;
    function isOutputShutdown: Boolean; cdecl;
    procedure setFileDescriptorsForSend(fds: TJavaObjectArray<JFileDescriptor>); cdecl;
    procedure setReceiveBufferSize(size: Integer); cdecl;
    procedure setSendBufferSize(n: Integer); cdecl;
    procedure setSoTimeout(n: Integer); cdecl;
    procedure shutdownInput; cdecl;
    procedure shutdownOutput; cdecl;
    function toString: JString; cdecl;
  end;
  TJLocalSocket = class(TJavaGenericImport<JLocalSocketClass, JLocalSocket>) end;

  JLocalSocketAddressClass = interface(JObjectClass)
    ['{372D6A57-0BC1-4814-97FB-AA10CEBD0E98}']
    {class} function init(name: JString; namespace: JLocalSocketAddress_Namespace): JLocalSocketAddress; cdecl; overload;
    {class} function init(name: JString): JLocalSocketAddress; cdecl; overload;
  end;

  [JavaSignature('android/net/LocalSocketAddress')]
  JLocalSocketAddress = interface(JObject)
    ['{75D02414-2370-48CF-BDAA-C17AC96D3389}']
    function getName: JString; cdecl;
    function getNamespace: JLocalSocketAddress_Namespace; cdecl;
  end;
  TJLocalSocketAddress = class(TJavaGenericImport<JLocalSocketAddressClass, JLocalSocketAddress>) end;

  JLocalSocketAddress_NamespaceClass = interface(JEnumClass)
    ['{FB572783-A894-4F07-90B7-228491F57729}']
    {class} function _GetABSTRACT: JLocalSocketAddress_Namespace; cdecl;
    {class} function _GetFILESYSTEM: JLocalSocketAddress_Namespace; cdecl;
    {class} function _GetRESERVED: JLocalSocketAddress_Namespace; cdecl;
    {class} function valueOf(name: JString): JLocalSocketAddress_Namespace; cdecl;
    {class} function values: TJavaObjectArray<JLocalSocketAddress_Namespace>; cdecl;
    {class} property &ABSTRACT: JLocalSocketAddress_Namespace read _GetABSTRACT;
    {class} property FILESYSTEM: JLocalSocketAddress_Namespace read _GetFILESYSTEM;
    {class} property RESERVED: JLocalSocketAddress_Namespace read _GetRESERVED;
  end;

  [JavaSignature('android/net/LocalSocketAddress$Namespace')]
  JLocalSocketAddress_Namespace = interface(JEnum)
    ['{92A66884-68BE-4017-A67C-2538BB9A391B}']
  end;
  TJLocalSocketAddress_Namespace = class(TJavaGenericImport<JLocalSocketAddress_NamespaceClass, JLocalSocketAddress_Namespace>) end;

  JMailToClass = interface(JObjectClass)
    ['{35E239FE-8BDD-4895-A86E-0D7F6DA123AD}']
    {class} function _GetMAILTO_SCHEME: JString; cdecl;
    {class} function isMailTo(url: JString): Boolean; cdecl;
    {class} function parse(url: JString): JMailTo; cdecl;
    {class} property MAILTO_SCHEME: JString read _GetMAILTO_SCHEME;
  end;

  [JavaSignature('android/net/MailTo')]
  JMailTo = interface(JObject)
    ['{3A23F169-EAF1-4408-9437-246008CCF9AB}']
    function getBody: JString; cdecl;
    function getCc: JString; cdecl;
    function getHeaders: JMap; cdecl;
    function getSubject: JString; cdecl;
    function getTo: JString; cdecl;
    function toString: JString; cdecl;
  end;
  TJMailTo = class(TJavaGenericImport<JMailToClass, JMailTo>) end;

  JNetworkClass = interface(JObjectClass)
    ['{AE027C0D-2183-437C-BAAD-E0BFC70212C8}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/Network')]
  JNetwork = interface(JObject)
    ['{76EC6273-4555-471E-BD82-A52A85C611BF}']
    procedure bindSocket(socket: JDatagramSocket); cdecl; overload;
    procedure bindSocket(socket: JSocket); cdecl; overload;
    procedure bindSocket(fd: JFileDescriptor); cdecl; overload;
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getAllByName(host: JString): TJavaObjectArray<JInetAddress>; cdecl;
    function getByName(host: JString): JInetAddress; cdecl;
    function getNetworkHandle: Int64; cdecl;
    function getSocketFactory: Jnet_SocketFactory; cdecl;
    function hashCode: Integer; cdecl;
    function openConnection(url: JURL): JURLConnection; cdecl; overload;
    function openConnection(url: JURL; proxy: JProxy): JURLConnection; cdecl; overload;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJNetwork = class(TJavaGenericImport<JNetworkClass, JNetwork>) end;

  JNetworkCapabilitiesClass = interface(JObjectClass)
    ['{E908BEFD-1FFE-4DBA-B9F3-48CE1E205BDE}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetNET_CAPABILITY_CAPTIVE_PORTAL: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_CBS: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_DUN: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_EIMS: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_FOTA: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_IA: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_IMS: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_INTERNET: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_MMS: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_NOT_METERED: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_NOT_RESTRICTED: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_NOT_VPN: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_RCS: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_SUPL: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_TRUSTED: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_VALIDATED: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_WIFI_P2P: Integer; cdecl;
    {class} function _GetNET_CAPABILITY_XCAP: Integer; cdecl;
    {class} function _GetTRANSPORT_BLUETOOTH: Integer; cdecl;
    {class} function _GetTRANSPORT_CELLULAR: Integer; cdecl;
    {class} function _GetTRANSPORT_ETHERNET: Integer; cdecl;
    {class} function _GetTRANSPORT_VPN: Integer; cdecl;
    {class} function _GetTRANSPORT_WIFI: Integer; cdecl;
    {class} function init(nc: JNetworkCapabilities): JNetworkCapabilities; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property NET_CAPABILITY_CAPTIVE_PORTAL: Integer read _GetNET_CAPABILITY_CAPTIVE_PORTAL;
    {class} property NET_CAPABILITY_CBS: Integer read _GetNET_CAPABILITY_CBS;
    {class} property NET_CAPABILITY_DUN: Integer read _GetNET_CAPABILITY_DUN;
    {class} property NET_CAPABILITY_EIMS: Integer read _GetNET_CAPABILITY_EIMS;
    {class} property NET_CAPABILITY_FOTA: Integer read _GetNET_CAPABILITY_FOTA;
    {class} property NET_CAPABILITY_IA: Integer read _GetNET_CAPABILITY_IA;
    {class} property NET_CAPABILITY_IMS: Integer read _GetNET_CAPABILITY_IMS;
    {class} property NET_CAPABILITY_INTERNET: Integer read _GetNET_CAPABILITY_INTERNET;
    {class} property NET_CAPABILITY_MMS: Integer read _GetNET_CAPABILITY_MMS;
    {class} property NET_CAPABILITY_NOT_METERED: Integer read _GetNET_CAPABILITY_NOT_METERED;
    {class} property NET_CAPABILITY_NOT_RESTRICTED: Integer read _GetNET_CAPABILITY_NOT_RESTRICTED;
    {class} property NET_CAPABILITY_NOT_VPN: Integer read _GetNET_CAPABILITY_NOT_VPN;
    {class} property NET_CAPABILITY_RCS: Integer read _GetNET_CAPABILITY_RCS;
    {class} property NET_CAPABILITY_SUPL: Integer read _GetNET_CAPABILITY_SUPL;
    {class} property NET_CAPABILITY_TRUSTED: Integer read _GetNET_CAPABILITY_TRUSTED;
    {class} property NET_CAPABILITY_VALIDATED: Integer read _GetNET_CAPABILITY_VALIDATED;
    {class} property NET_CAPABILITY_WIFI_P2P: Integer read _GetNET_CAPABILITY_WIFI_P2P;
    {class} property NET_CAPABILITY_XCAP: Integer read _GetNET_CAPABILITY_XCAP;
    {class} property TRANSPORT_BLUETOOTH: Integer read _GetTRANSPORT_BLUETOOTH;
    {class} property TRANSPORT_CELLULAR: Integer read _GetTRANSPORT_CELLULAR;
    {class} property TRANSPORT_ETHERNET: Integer read _GetTRANSPORT_ETHERNET;
    {class} property TRANSPORT_VPN: Integer read _GetTRANSPORT_VPN;
    {class} property TRANSPORT_WIFI: Integer read _GetTRANSPORT_WIFI;
  end;

  [JavaSignature('android/net/NetworkCapabilities')]
  JNetworkCapabilities = interface(JObject)
    ['{E9EBA97B-F82A-41BA-8170-537E131E0533}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getLinkDownstreamBandwidthKbps: Integer; cdecl;
    function getLinkUpstreamBandwidthKbps: Integer; cdecl;
    function hasCapability(capability: Integer): Boolean; cdecl;
    function hasTransport(transportType: Integer): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJNetworkCapabilities = class(TJavaGenericImport<JNetworkCapabilitiesClass, JNetworkCapabilities>) end;

  JNetworkInfoClass = interface(JObjectClass)
    ['{AAA1F0A5-4A11-4FAA-BBA9-3AD780E30619}']
  end;

  [JavaSignature('android/net/NetworkInfo')]
  JNetworkInfo = interface(JObject)
    ['{B271626D-7A97-44DB-AF7D-B6E7B1FE94EC}']
    function getDetailedState: JNetworkInfo_DetailedState; cdecl;
    function getExtraInfo: JString; cdecl;
    function getReason: JString; cdecl;
    function getState: JNetworkInfo_State; cdecl;
    function getSubtype: Integer; cdecl;
    function getSubtypeName: JString; cdecl;
    function getType: Integer; cdecl;
    function getTypeName: JString; cdecl;
    function isAvailable: Boolean; cdecl;
    function isConnected: Boolean; cdecl;
    function isConnectedOrConnecting: Boolean; cdecl;
    function isFailover: Boolean; cdecl;
    function isRoaming: Boolean; cdecl;
    function toString: JString; cdecl;
  end;
  TJNetworkInfo = class(TJavaGenericImport<JNetworkInfoClass, JNetworkInfo>) end;

  JNetworkInfo_DetailedStateClass = interface(JEnumClass)
    ['{23C018BA-81E4-4B2E-B369-9CF46B9A5DAF}']
    {class} function _GetAUTHENTICATING: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetBLOCKED: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetCAPTIVE_PORTAL_CHECK: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetCONNECTED: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetCONNECTING: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetDISCONNECTED: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetDISCONNECTING: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetFAILED: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetIDLE: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetOBTAINING_IPADDR: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetSCANNING: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetSUSPENDED: JNetworkInfo_DetailedState; cdecl;
    {class} function _GetVERIFYING_POOR_LINK: JNetworkInfo_DetailedState; cdecl;
    {class} function valueOf(name: JString): JNetworkInfo_DetailedState; cdecl;
    {class} function values: TJavaObjectArray<JNetworkInfo_DetailedState>; cdecl;
    {class} property AUTHENTICATING: JNetworkInfo_DetailedState read _GetAUTHENTICATING;
    {class} property BLOCKED: JNetworkInfo_DetailedState read _GetBLOCKED;
    {class} property CAPTIVE_PORTAL_CHECK: JNetworkInfo_DetailedState read _GetCAPTIVE_PORTAL_CHECK;
    {class} property CONNECTED: JNetworkInfo_DetailedState read _GetCONNECTED;
    {class} property CONNECTING: JNetworkInfo_DetailedState read _GetCONNECTING;
    {class} property DISCONNECTED: JNetworkInfo_DetailedState read _GetDISCONNECTED;
    {class} property DISCONNECTING: JNetworkInfo_DetailedState read _GetDISCONNECTING;
    {class} property FAILED: JNetworkInfo_DetailedState read _GetFAILED;
    {class} property IDLE: JNetworkInfo_DetailedState read _GetIDLE;
    {class} property OBTAINING_IPADDR: JNetworkInfo_DetailedState read _GetOBTAINING_IPADDR;
    {class} property SCANNING: JNetworkInfo_DetailedState read _GetSCANNING;
    {class} property SUSPENDED: JNetworkInfo_DetailedState read _GetSUSPENDED;
    {class} property VERIFYING_POOR_LINK: JNetworkInfo_DetailedState read _GetVERIFYING_POOR_LINK;
  end;

  [JavaSignature('android/net/NetworkInfo$DetailedState')]
  JNetworkInfo_DetailedState = interface(JEnum)
    ['{E755D6D6-0DB0-4231-A31B-5AA4E74A4F9F}']
  end;
  TJNetworkInfo_DetailedState = class(TJavaGenericImport<JNetworkInfo_DetailedStateClass, JNetworkInfo_DetailedState>) end;

  JNetworkInfo_StateClass = interface(JEnumClass)
    ['{07095450-13CB-41C7-B482-88392CFB2D09}']
    {class} function _GetCONNECTED: JNetworkInfo_State; cdecl;
    {class} function _GetCONNECTING: JNetworkInfo_State; cdecl;
    {class} function _GetDISCONNECTED: JNetworkInfo_State; cdecl;
    {class} function _GetDISCONNECTING: JNetworkInfo_State; cdecl;
    {class} function _GetSUSPENDED: JNetworkInfo_State; cdecl;
    {class} function _GetUNKNOWN: JNetworkInfo_State; cdecl;
    {class} function valueOf(name: JString): JNetworkInfo_State; cdecl;
    {class} function values: TJavaObjectArray<JNetworkInfo_State>; cdecl;
    {class} property CONNECTED: JNetworkInfo_State read _GetCONNECTED;
    {class} property CONNECTING: JNetworkInfo_State read _GetCONNECTING;
    {class} property DISCONNECTED: JNetworkInfo_State read _GetDISCONNECTED;
    {class} property DISCONNECTING: JNetworkInfo_State read _GetDISCONNECTING;
    {class} property SUSPENDED: JNetworkInfo_State read _GetSUSPENDED;
    {class} property UNKNOWN: JNetworkInfo_State read _GetUNKNOWN;
  end;

  [JavaSignature('android/net/NetworkInfo$State')]
  JNetworkInfo_State = interface(JEnum)
    ['{B057DB6E-72E5-448C-AF59-986D4DE7B578}']
  end;
  TJNetworkInfo_State = class(TJavaGenericImport<JNetworkInfo_StateClass, JNetworkInfo_State>) end;

  JNetworkRequestClass = interface(JObjectClass)
    ['{8BDD713E-715C-4BB4-A42B-23B6D0044D65}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/NetworkRequest')]
  JNetworkRequest = interface(JObject)
    ['{966B3886-AD63-4D8E-8573-D8D997A2933D}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJNetworkRequest = class(TJavaGenericImport<JNetworkRequestClass, JNetworkRequest>) end;

  JNetworkRequest_BuilderClass = interface(JObjectClass)
    ['{0DE74060-F025-40C9-8334-05CDECEED85F}']
    {class} function init: JNetworkRequest_Builder; cdecl;
  end;

  [JavaSignature('android/net/NetworkRequest$Builder')]
  JNetworkRequest_Builder = interface(JObject)
    ['{AA7B1C54-8947-4A75-AEAB-8983141D28A7}']
    function addCapability(capability: Integer): JNetworkRequest_Builder; cdecl;
    function addTransportType(transportType: Integer): JNetworkRequest_Builder; cdecl;
    function build: JNetworkRequest; cdecl;
    function removeCapability(capability: Integer): JNetworkRequest_Builder; cdecl;
    function removeTransportType(transportType: Integer): JNetworkRequest_Builder; cdecl;
    function setNetworkSpecifier(networkSpecifier: JString): JNetworkRequest_Builder; cdecl;
  end;
  TJNetworkRequest_Builder = class(TJavaGenericImport<JNetworkRequest_BuilderClass, JNetworkRequest_Builder>) end;

  Jnet_ParseExceptionClass = interface(JRuntimeExceptionClass)
    ['{4F9C6D21-B0AE-4700-BF40-09AA0DB05F03}']
  end;

  [JavaSignature('android/net/ParseException')]
  Jnet_ParseException = interface(JRuntimeException)
    ['{C1D0ABEE-7343-482A-8F4B-13C2DF665FEF}']
    function _Getresponse: JString; cdecl;
    procedure _Setresponse(Value: JString); cdecl;
    property response: JString read _Getresponse write _Setresponse;
  end;
  TJnet_ParseException = class(TJavaGenericImport<Jnet_ParseExceptionClass, Jnet_ParseException>) end;

  Jnet_ProxyClass = interface(JObjectClass)
    ['{083E9E07-5502-458C-A6F8-84B869142B56}']
    {class} function _GetEXTRA_PROXY_INFO: JString; cdecl;
    {class} function _GetPROXY_CHANGE_ACTION: JString; cdecl;
    {class} function init: Jnet_Proxy; cdecl;
    {class} function getDefaultHost: JString; cdecl;//Deprecated
    {class} function getDefaultPort: Integer; cdecl;//Deprecated
    {class} //function getHost(ctx: JContext): JString; cdecl;//Deprecated
    {class} //function getPort(ctx: JContext): Integer; cdecl;//Deprecated
    {class} property EXTRA_PROXY_INFO: JString read _GetEXTRA_PROXY_INFO;
    {class} property PROXY_CHANGE_ACTION: JString read _GetPROXY_CHANGE_ACTION;
  end;

  [JavaSignature('android/net/Proxy')]
  Jnet_Proxy = interface(JObject)
    ['{45FB13E6-66A7-494A-9415-0BBC01167F35}']
  end;
  TJnet_Proxy = class(TJavaGenericImport<Jnet_ProxyClass, Jnet_Proxy>) end;

  JProxyInfoClass = interface(JObjectClass)
    ['{31E4D1A9-4E97-4F30-819F-61909D0CFB8A}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function buildDirectProxy(host: JString; port: Integer): JProxyInfo; cdecl; overload;
    {class} function buildDirectProxy(host: JString; port: Integer; exclList: JList): JProxyInfo; cdecl; overload;
    {class} function buildPacProxy(pacUri: Jnet_Uri): JProxyInfo; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/ProxyInfo')]
  JProxyInfo = interface(JObject)
    ['{7EDC72B5-DE1F-4F6F-8E52-EF201FAD6806}']
    function equals(o: JObject): Boolean; cdecl;
    function getExclusionList: TJavaObjectArray<JString>; cdecl;
    function getHost: JString; cdecl;
    function getPacFileUrl: Jnet_Uri; cdecl;
    function getPort: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
  end;
  TJProxyInfo = class(TJavaGenericImport<JProxyInfoClass, JProxyInfo>) end;

  JPskKeyManagerClass = interface(JObjectClass)
    ['{41FA5AF2-3C2E-4875-8337-D20F87EC8D84}']
    {class} function _GetMAX_IDENTITY_HINT_LENGTH_BYTES: Integer; cdecl;
    {class} function _GetMAX_IDENTITY_LENGTH_BYTES: Integer; cdecl;
    {class} function _GetMAX_KEY_LENGTH_BYTES: Integer; cdecl;
    {class} function init: JPskKeyManager; cdecl;
    {class} property MAX_IDENTITY_HINT_LENGTH_BYTES: Integer read _GetMAX_IDENTITY_HINT_LENGTH_BYTES;
    {class} property MAX_IDENTITY_LENGTH_BYTES: Integer read _GetMAX_IDENTITY_LENGTH_BYTES;
    {class} property MAX_KEY_LENGTH_BYTES: Integer read _GetMAX_KEY_LENGTH_BYTES;
  end;

  [JavaSignature('android/net/PskKeyManager')]
  JPskKeyManager = interface(JObject)
    ['{BD180E6F-10EF-4E79-B9A7-5E56CB152C10}']
    function chooseClientKeyIdentity(identityHint: JString; socket: JSocket): JString; cdecl; overload;
    function chooseClientKeyIdentity(identityHint: JString; engine: JSSLEngine): JString; cdecl; overload;
    function chooseServerKeyIdentityHint(socket: JSocket): JString; cdecl; overload;
    function chooseServerKeyIdentityHint(engine: JSSLEngine): JString; cdecl; overload;
  //  function getKey(identityHint: JString; identity: JString; socket: JSocket): JSecretKey; cdecl; overload;
  //  function getKey(identityHint: JString; identity: JString; engine: JSSLEngine): JSecretKey; cdecl; overload;
  end;
  TJPskKeyManager = class(TJavaGenericImport<JPskKeyManagerClass, JPskKeyManager>) end;

  Jnet_RouteInfoClass = interface(JObjectClass)
    ['{C12F65E4-E16F-448F-8AB3-DDE945F3E1B8}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/RouteInfo')]
  Jnet_RouteInfo = interface(JObject)
    ['{6198031B-E49A-4F15-9701-CE9BB025A3C2}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getDestination: JIpPrefix; cdecl;
    function getGateway: JInetAddress; cdecl;
    function getInterface: JString; cdecl;
    function hashCode: Integer; cdecl;
    function isDefaultRoute: Boolean; cdecl;
    function matches(destination: JInetAddress): Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJnet_RouteInfo = class(TJavaGenericImport<Jnet_RouteInfoClass, Jnet_RouteInfo>) end;

  JSSLCertificateSocketFactoryClass = interface(Jssl_SSLSocketFactoryClass)
    ['{9D55AD48-6A40-4A25-9D2E-85BEF8D07520}']
    {class} function init(handshakeTimeoutMillis: Integer): JSSLCertificateSocketFactory; cdecl;//Deprecated
    {class} function getDefault(handshakeTimeoutMillis: Integer): Jnet_SocketFactory; cdecl; overload;
    {class} function getDefault(handshakeTimeoutMillis: Integer; cache: JSSLSessionCache): Jssl_SSLSocketFactory; cdecl; overload;
    {class} //function getHttpSocketFactory(handshakeTimeoutMillis: Integer; cache: JSSLSessionCache): JSSLSocketFactory; cdecl;//Deprecated
    {class} function getInsecure(handshakeTimeoutMillis: Integer; cache: JSSLSessionCache): Jssl_SSLSocketFactory; cdecl;
  end;

  [JavaSignature('android/net/SSLCertificateSocketFactory')]
  JSSLCertificateSocketFactory = interface(Jssl_SSLSocketFactory)
    ['{1A6F8032-14A4-4C59-94E8-A4D6FAAB2ED2}']
    function createSocket(k: JSocket; host: JString; port: Integer; close: Boolean): JSocket; cdecl; overload;
    function createSocket: JSocket; cdecl; overload;
    function createSocket(addr: JInetAddress; port: Integer; localAddr: JInetAddress; localPort: Integer): JSocket; cdecl; overload;
    function createSocket(addr: JInetAddress; port: Integer): JSocket; cdecl; overload;
    function createSocket(host: JString; port: Integer; localAddr: JInetAddress; localPort: Integer): JSocket; cdecl; overload;
    function createSocket(host: JString; port: Integer): JSocket; cdecl; overload;
    function getDefaultCipherSuites: TJavaObjectArray<JString>; cdecl;
    function getNpnSelectedProtocol(socket: JSocket): TJavaArray<Byte>; cdecl;
    function getSupportedCipherSuites: TJavaObjectArray<JString>; cdecl;
    procedure setHostname(socket: JSocket; hostName: JString); cdecl;
    procedure setKeyManagers(keyManagers: TJavaObjectArray<JKeyManager>); cdecl;
    procedure setNpnProtocols(npnProtocols: TJavaBiArray<Byte>); cdecl;
    procedure setTrustManagers(trustManager: TJavaObjectArray<JTrustManager>); cdecl;
    procedure setUseSessionTickets(socket: JSocket; useSessionTickets: Boolean); cdecl;
  end;
  TJSSLCertificateSocketFactory = class(TJavaGenericImport<JSSLCertificateSocketFactoryClass, JSSLCertificateSocketFactory>) end;

  JSSLSessionCacheClass = interface(JObjectClass)
    ['{61DD6AD3-8B19-43E5-94CC-524F255B844A}']
    {class} function init(dir: JFile): JSSLSessionCache; cdecl; overload;
    {class} //function init(context: JContext): JSSLSessionCache; cdecl; overload;
  end;

  [JavaSignature('android/net/SSLSessionCache')]
  JSSLSessionCache = interface(JObject)
    ['{7E18FF5B-86E4-418E-BF7C-6D9F5A959B42}']
  end;
  TJSSLSessionCache = class(TJavaGenericImport<JSSLSessionCacheClass, JSSLSessionCache>) end;

  JTrafficStatsClass = interface(JObjectClass)
    ['{971C68C9-ABA0-4ED9-A1C7-16A08AF59605}']
    {class} function _GetUNSUPPORTED: Integer; cdecl;
    {class} function init: JTrafficStats; cdecl;
    {class} procedure clearThreadStatsTag; cdecl;
    {class} function getMobileRxBytes: Int64; cdecl;
    {class} function getMobileRxPackets: Int64; cdecl;
    {class} function getMobileTxBytes: Int64; cdecl;
    {class} function getMobileTxPackets: Int64; cdecl;
    {class} function getThreadStatsTag: Integer; cdecl;
    {class} function getTotalRxBytes: Int64; cdecl;
    {class} function getTotalRxPackets: Int64; cdecl;
    {class} function getTotalTxBytes: Int64; cdecl;
    {class} function getTotalTxPackets: Int64; cdecl;
    {class} function getUidRxBytes(uid: Integer): Int64; cdecl;
    {class} function getUidRxPackets(uid: Integer): Int64; cdecl;
    {class} function getUidTcpRxBytes(uid: Integer): Int64; cdecl;//Deprecated
    {class} function getUidTcpRxSegments(uid: Integer): Int64; cdecl;//Deprecated
    {class} function getUidTcpTxBytes(uid: Integer): Int64; cdecl;//Deprecated
    {class} function getUidTcpTxSegments(uid: Integer): Int64; cdecl;//Deprecated
    {class} function getUidTxBytes(uid: Integer): Int64; cdecl;
    {class} function getUidTxPackets(uid: Integer): Int64; cdecl;
    {class} function getUidUdpRxBytes(uid: Integer): Int64; cdecl;//Deprecated
    {class} function getUidUdpRxPackets(uid: Integer): Int64; cdecl;//Deprecated
    {class} function getUidUdpTxBytes(uid: Integer): Int64; cdecl;//Deprecated
    {class} function getUidUdpTxPackets(uid: Integer): Int64; cdecl;//Deprecated
    {class} procedure incrementOperationCount(operationCount: Integer); cdecl; overload;
    {class} procedure incrementOperationCount(tag: Integer; operationCount: Integer); cdecl; overload;
    {class} procedure setThreadStatsTag(tag: Integer); cdecl;
    {class} procedure tagSocket(socket: JSocket); cdecl;
    {class} procedure untagSocket(socket: JSocket); cdecl;
    {class} property UNSUPPORTED: Integer read _GetUNSUPPORTED;
  end;

  [JavaSignature('android/net/TrafficStats')]
  JTrafficStats = interface(JObject)
    ['{98FB5C1E-E7AB-4130-9EEB-2DADA2B3C015}']
  end;
  TJTrafficStats = class(TJavaGenericImport<JTrafficStatsClass, JTrafficStats>) end;

  Jnet_UriClass = interface(JObjectClass)
    ['{26008A37-774A-4F63-817A-639A3B749539}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetEMPTY: Jnet_Uri; cdecl;
    {class} function decode(s: JString): JString; cdecl;
    {class} function encode(s: JString): JString; cdecl; overload;
    {class} function encode(s: JString; allow: JString): JString; cdecl; overload;
    {class} function fromFile(file_: JFile): Jnet_Uri; cdecl;
    {class} function fromParts(scheme: JString; ssp: JString; fragment: JString): Jnet_Uri; cdecl;
    {class} function parse(uriString: JString): Jnet_Uri; cdecl;
    {class} function withAppendedPath(baseUri: Jnet_Uri; pathSegment: JString): Jnet_Uri; cdecl;
    {class} procedure writeToParcel(out_: JParcel; uri: Jnet_Uri); cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property EMPTY: Jnet_Uri read _GetEMPTY;
  end;

  [JavaSignature('android/net/Uri')]
  Jnet_Uri = interface(JObject)
    ['{FBC1913D-A35B-4E62-ABD1-7575BEC0488E}']
    function buildUpon: JUri_Builder; cdecl;
    function compareTo(other: Jnet_Uri): Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getAuthority: JString; cdecl;
    function getBooleanQueryParameter(key: JString; defaultValue: Boolean): Boolean; cdecl;
    function getEncodedAuthority: JString; cdecl;
    function getEncodedFragment: JString; cdecl;
    function getEncodedPath: JString; cdecl;
    function getEncodedQuery: JString; cdecl;
    function getEncodedSchemeSpecificPart: JString; cdecl;
    function getEncodedUserInfo: JString; cdecl;
    function getFragment: JString; cdecl;
    function getHost: JString; cdecl;
    function getLastPathSegment: JString; cdecl;
    function getPath: JString; cdecl;
    function getPathSegments: JList; cdecl;
    function getPort: Integer; cdecl;
    function getQuery: JString; cdecl;
    function getQueryParameter(key: JString): JString; cdecl;
    function getQueryParameterNames: JSet; cdecl;
    function getQueryParameters(key: JString): JList; cdecl;
    function getScheme: JString; cdecl;
    function getSchemeSpecificPart: JString; cdecl;
    function getUserInfo: JString; cdecl;
    function hashCode: Integer; cdecl;
    function isAbsolute: Boolean; cdecl;
    function isHierarchical: Boolean; cdecl;
    function isOpaque: Boolean; cdecl;
    function isRelative: Boolean; cdecl;
    function normalizeScheme: Jnet_Uri; cdecl;
    function toString: JString; cdecl;
  end;
  TJnet_Uri = class(TJavaGenericImport<Jnet_UriClass, Jnet_Uri>) end;

  JUri_BuilderClass = interface(JObjectClass)
    ['{A28CFEC0-2796-4427-A612-4F8D7389ECEB}']
    {class} function init: JUri_Builder; cdecl;
  end;

  [JavaSignature('android/net/Uri$Builder')]
  JUri_Builder = interface(JObject)
    ['{764C6F4F-0EE9-4CC4-98C4-C2FDE6E73B7A}']
    function appendEncodedPath(newSegment: JString): JUri_Builder; cdecl;
    function appendPath(newSegment: JString): JUri_Builder; cdecl;
    function appendQueryParameter(key: JString; value: JString): JUri_Builder; cdecl;
    function authority(authority: JString): JUri_Builder; cdecl;
    function build: Jnet_Uri; cdecl;
    function clearQuery: JUri_Builder; cdecl;
    function encodedAuthority(authority: JString): JUri_Builder; cdecl;
    function encodedFragment(fragment: JString): JUri_Builder; cdecl;
    function encodedOpaquePart(opaquePart: JString): JUri_Builder; cdecl;
    function encodedPath(path: JString): JUri_Builder; cdecl;
    function encodedQuery(query: JString): JUri_Builder; cdecl;
    function fragment(fragment: JString): JUri_Builder; cdecl;
    function opaquePart(opaquePart: JString): JUri_Builder; cdecl;
    function path(path: JString): JUri_Builder; cdecl;
    function query(query: JString): JUri_Builder; cdecl;
    function scheme(scheme: JString): JUri_Builder; cdecl;
    function toString: JString; cdecl;
  end;
  TJUri_Builder = class(TJavaGenericImport<JUri_BuilderClass, JUri_Builder>) end;

  JUrlQuerySanitizerClass = interface(JObjectClass)
    ['{22D8C5C5-F858-4034-88C1-C2459E81E112}']
    {class} function init: JUrlQuerySanitizer; cdecl; overload;
    {class} function init(url: JString): JUrlQuerySanitizer; cdecl; overload;
    {class} function getAllButNulAndAngleBracketsLegal: JUrlQuerySanitizer_ValueSanitizer; cdecl;
    {class} function getAllButNulLegal: JUrlQuerySanitizer_ValueSanitizer; cdecl;
    {class} function getAllButWhitespaceLegal: JUrlQuerySanitizer_ValueSanitizer; cdecl;
    {class} function getAllIllegal: JUrlQuerySanitizer_ValueSanitizer; cdecl;
    {class} function getAmpAndSpaceLegal: JUrlQuerySanitizer_ValueSanitizer; cdecl;
    {class} function getAmpLegal: JUrlQuerySanitizer_ValueSanitizer; cdecl;
    {class} function getSpaceLegal: JUrlQuerySanitizer_ValueSanitizer; cdecl;
    {class} function getUrlAndSpaceLegal: JUrlQuerySanitizer_ValueSanitizer; cdecl;
    {class} function getUrlLegal: JUrlQuerySanitizer_ValueSanitizer; cdecl;
  end;

  [JavaSignature('android/net/UrlQuerySanitizer')]
  JUrlQuerySanitizer = interface(JObject)
    ['{2475AD87-4B23-40DE-B157-60C6A65B7BFD}']
    function getAllowUnregisteredParamaters: Boolean; cdecl;
    function getEffectiveValueSanitizer(parameter: JString): JUrlQuerySanitizer_ValueSanitizer; cdecl;
    function getParameterList: JList; cdecl;
    function getParameterSet: JSet; cdecl;
    function getPreferFirstRepeatedParameter: Boolean; cdecl;
    function getUnregisteredParameterValueSanitizer: JUrlQuerySanitizer_ValueSanitizer; cdecl;
    function getValue(parameter: JString): JString; cdecl;
    function getValueSanitizer(parameter: JString): JUrlQuerySanitizer_ValueSanitizer; cdecl;
    function hasParameter(parameter: JString): Boolean; cdecl;
    procedure parseQuery(query: JString); cdecl;
    procedure parseUrl(url: JString); cdecl;
    procedure registerParameter(parameter: JString; valueSanitizer: JUrlQuerySanitizer_ValueSanitizer); cdecl;
    procedure registerParameters(parameters: TJavaObjectArray<JString>; valueSanitizer: JUrlQuerySanitizer_ValueSanitizer); cdecl;
    procedure setAllowUnregisteredParamaters(allowUnregisteredParamaters: Boolean); cdecl;
    procedure setPreferFirstRepeatedParameter(preferFirstRepeatedParameter: Boolean); cdecl;
    procedure setUnregisteredParameterValueSanitizer(sanitizer: JUrlQuerySanitizer_ValueSanitizer); cdecl;
    function unescape(string_: JString): JString; cdecl;
  end;
  TJUrlQuerySanitizer = class(TJavaGenericImport<JUrlQuerySanitizerClass, JUrlQuerySanitizer>) end;

  JUrlQuerySanitizer_IllegalCharacterValueSanitizerClass = interface(JObjectClass)
    ['{EEE055D8-32B1-49CD-AFF3-DA14E32AF8B2}']
    {class} function _GetALL_BUT_NUL_AND_ANGLE_BRACKETS_LEGAL: Integer; cdecl;
    {class} function _GetALL_BUT_NUL_LEGAL: Integer; cdecl;
    {class} function _GetALL_BUT_WHITESPACE_LEGAL: Integer; cdecl;
    {class} function _GetALL_ILLEGAL: Integer; cdecl;
    {class} function _GetALL_OK: Integer; cdecl;
    {class} function _GetALL_WHITESPACE_OK: Integer; cdecl;
    {class} function _GetAMP_AND_SPACE_LEGAL: Integer; cdecl;
    {class} function _GetAMP_LEGAL: Integer; cdecl;
    {class} function _GetAMP_OK: Integer; cdecl;
    {class} function _GetDQUOTE_OK: Integer; cdecl;
    {class} function _GetGT_OK: Integer; cdecl;
    {class} function _GetLT_OK: Integer; cdecl;
    {class} function _GetNON_7_BIT_ASCII_OK: Integer; cdecl;
    {class} function _GetNUL_OK: Integer; cdecl;
    {class} function _GetOTHER_WHITESPACE_OK: Integer; cdecl;
    {class} function _GetPCT_OK: Integer; cdecl;
    {class} function _GetSCRIPT_URL_OK: Integer; cdecl;
    {class} function _GetSPACE_LEGAL: Integer; cdecl;
    {class} function _GetSPACE_OK: Integer; cdecl;
    {class} function _GetSQUOTE_OK: Integer; cdecl;
    {class} function _GetURL_AND_SPACE_LEGAL: Integer; cdecl;
    {class} function _GetURL_LEGAL: Integer; cdecl;
    {class} function init(flags: Integer): JUrlQuerySanitizer_IllegalCharacterValueSanitizer; cdecl;
    {class} property ALL_BUT_NUL_AND_ANGLE_BRACKETS_LEGAL: Integer read _GetALL_BUT_NUL_AND_ANGLE_BRACKETS_LEGAL;
    {class} property ALL_BUT_NUL_LEGAL: Integer read _GetALL_BUT_NUL_LEGAL;
    {class} property ALL_BUT_WHITESPACE_LEGAL: Integer read _GetALL_BUT_WHITESPACE_LEGAL;
    {class} property ALL_ILLEGAL: Integer read _GetALL_ILLEGAL;
    {class} property ALL_OK: Integer read _GetALL_OK;
    {class} property ALL_WHITESPACE_OK: Integer read _GetALL_WHITESPACE_OK;
    {class} property AMP_AND_SPACE_LEGAL: Integer read _GetAMP_AND_SPACE_LEGAL;
    {class} property AMP_LEGAL: Integer read _GetAMP_LEGAL;
    {class} property AMP_OK: Integer read _GetAMP_OK;
    {class} property DQUOTE_OK: Integer read _GetDQUOTE_OK;
    {class} property GT_OK: Integer read _GetGT_OK;
    {class} property LT_OK: Integer read _GetLT_OK;
    {class} property NON_7_BIT_ASCII_OK: Integer read _GetNON_7_BIT_ASCII_OK;
    {class} property NUL_OK: Integer read _GetNUL_OK;
    {class} property OTHER_WHITESPACE_OK: Integer read _GetOTHER_WHITESPACE_OK;
    {class} property PCT_OK: Integer read _GetPCT_OK;
    {class} property SCRIPT_URL_OK: Integer read _GetSCRIPT_URL_OK;
    {class} property SPACE_LEGAL: Integer read _GetSPACE_LEGAL;
    {class} property SPACE_OK: Integer read _GetSPACE_OK;
    {class} property SQUOTE_OK: Integer read _GetSQUOTE_OK;
    {class} property URL_AND_SPACE_LEGAL: Integer read _GetURL_AND_SPACE_LEGAL;
    {class} property URL_LEGAL: Integer read _GetURL_LEGAL;
  end;

  [JavaSignature('android/net/UrlQuerySanitizer$IllegalCharacterValueSanitizer')]
  JUrlQuerySanitizer_IllegalCharacterValueSanitizer = interface(JObject)
    ['{78B43961-AA50-497C-84D8-35F7DEFA0DB3}']
    function sanitize(value: JString): JString; cdecl;
  end;
  TJUrlQuerySanitizer_IllegalCharacterValueSanitizer = class(TJavaGenericImport<JUrlQuerySanitizer_IllegalCharacterValueSanitizerClass, JUrlQuerySanitizer_IllegalCharacterValueSanitizer>) end;

  JUrlQuerySanitizer_ParameterValuePairClass = interface(JObjectClass)
    ['{11CD7EEA-5780-434D-A1BE-FC2475589D93}']
    {class} function init(parameter: JString; value: JString): JUrlQuerySanitizer_ParameterValuePair; cdecl;
  end;

  [JavaSignature('android/net/UrlQuerySanitizer$ParameterValuePair')]
  JUrlQuerySanitizer_ParameterValuePair = interface(JObject)
    ['{A76C91ED-7A5C-46A5-81A2-38A2F4FF9551}']
    function _GetmParameter: JString; cdecl;
    procedure _SetmParameter(Value: JString); cdecl;
    function _GetmValue: JString; cdecl;
    procedure _SetmValue(Value: JString); cdecl;
    property mParameter: JString read _GetmParameter write _SetmParameter;
    property mValue: JString read _GetmValue write _SetmValue;
  end;
  TJUrlQuerySanitizer_ParameterValuePair = class(TJavaGenericImport<JUrlQuerySanitizer_ParameterValuePairClass, JUrlQuerySanitizer_ParameterValuePair>) end;

  JUrlQuerySanitizer_ValueSanitizerClass = interface(IJavaClass)
    ['{7CE445EF-AD82-4C81-BF3E-F5E9F7E085EB}']
  end;

  [JavaSignature('android/net/UrlQuerySanitizer$ValueSanitizer')]
  JUrlQuerySanitizer_ValueSanitizer = interface(IJavaInstance)
    ['{748C377B-1C9B-4602-B488-DBEC1A034D70}']
    function sanitize(value: JString): JString; cdecl;
  end;
  TJUrlQuerySanitizer_ValueSanitizer = class(TJavaGenericImport<JUrlQuerySanitizer_ValueSanitizerClass, JUrlQuerySanitizer_ValueSanitizer>) end;

  // android.net.VpnService
  JVpnService_BuilderClass = interface(JObjectClass)
    ['{F6E76953-EF29-4A89-A854-FF49C09A0590}']
    {class} function init: JVpnService_Builder; cdecl;
  end;

  [JavaSignature('android/net/VpnService$Builder')]
  JVpnService_Builder = interface(JObject)
    ['{947B9F4C-6722-4706-839B-6B9BC06AE2FA}']
    function addAddress(address: JInetAddress; prefixLength: Integer): JVpnService_Builder; cdecl; overload;
    function addAddress(address: JString; prefixLength: Integer): JVpnService_Builder; cdecl; overload;
    function addAllowedApplication(packageName: JString): JVpnService_Builder; cdecl;
    function addDisallowedApplication(packageName: JString): JVpnService_Builder; cdecl;
    function addDnsServer(address: JInetAddress): JVpnService_Builder; cdecl; overload;
    function addDnsServer(address: JString): JVpnService_Builder; cdecl; overload;
    function addRoute(address: JInetAddress; prefixLength: Integer): JVpnService_Builder; cdecl; overload;
    function addRoute(address: JString; prefixLength: Integer): JVpnService_Builder; cdecl; overload;
    function addSearchDomain(domain: JString): JVpnService_Builder; cdecl;
    function allowBypass: JVpnService_Builder; cdecl;
    function allowFamily(family: Integer): JVpnService_Builder; cdecl;
    function establish: JParcelFileDescriptor; cdecl;
    function setBlocking(blocking: Boolean): JVpnService_Builder; cdecl;
    //function setConfigureIntent(intent: JPendingIntent): JVpnService_Builder; cdecl;
    function setMtu(mtu: Integer): JVpnService_Builder; cdecl;
    function setSession(session: JString): JVpnService_Builder; cdecl;
    function setUnderlyingNetworks(networks: TJavaObjectArray<JNetwork>): JVpnService_Builder; cdecl;
  end;
  TJVpnService_Builder = class(TJavaGenericImport<JVpnService_BuilderClass, JVpnService_Builder>) end;

  JHttpResponseCacheClass = interface(JResponseCacheClass)
    ['{423ADA1E-2EC4-48A6-B45C-E94C16CB2DE2}']
    {class} function getInstalled: JHttpResponseCache; cdecl;
    {class} function install(directory: JFile; maxSize: Int64): JHttpResponseCache; cdecl;
  end;

  [JavaSignature('android/net/http/HttpResponseCache')]
  JHttpResponseCache = interface(JResponseCache)
    ['{A78C1FFC-572F-4155-B25D-BD32134BFABB}']
    procedure close; cdecl;
    procedure delete; cdecl;
    procedure flush; cdecl;
    function &get(uri: JURI; requestMethod: JString; requestHeaders: JMap): JCacheResponse; cdecl;
    function getHitCount: Integer; cdecl;
    function getNetworkCount: Integer; cdecl;
    function getRequestCount: Integer; cdecl;
    function maxSize: Int64; cdecl;
    function put(uri: JURI; urlConnection: JURLConnection): JCacheRequest; cdecl;
    function size: Int64; cdecl;
  end;
  TJHttpResponseCache = class(TJavaGenericImport<JHttpResponseCacheClass, JHttpResponseCache>) end;

  JSslCertificateClass = interface(JObjectClass)
    ['{015060F6-A45B-43B1-99F2-25FF14860D34}']
    {class} function init(issuedTo: JString; issuedBy: JString; validNotBefore: JString; validNotAfter: JString): JSslCertificate; cdecl; overload;//Deprecated
    {class} function init(issuedTo: JString; issuedBy: JString; validNotBefore: JDate; validNotAfter: JDate): JSslCertificate; cdecl; overload;//Deprecated
    {class} function init(certificate: JX509Certificate): JSslCertificate; cdecl; overload;
    {class} function restoreState(bundle: JBundle): JSslCertificate; cdecl;
    {class} function saveState(certificate: JSslCertificate): JBundle; cdecl;
  end;

  [JavaSignature('android/net/http/SslCertificate')]
  JSslCertificate = interface(JObject)
    ['{71905E46-8089-401A-ACA0-7C8CAB5BDCFB}']
    function getIssuedBy: JSslCertificate_DName; cdecl;
    function getIssuedTo: JSslCertificate_DName; cdecl;
    function getValidNotAfter: JString; cdecl;//Deprecated
    function getValidNotAfterDate: JDate; cdecl;
    function getValidNotBefore: JString; cdecl;//Deprecated
    function getValidNotBeforeDate: JDate; cdecl;
    function toString: JString; cdecl;
  end;
  TJSslCertificate = class(TJavaGenericImport<JSslCertificateClass, JSslCertificate>) end;

  JSslCertificate_DNameClass = interface(JObjectClass)
    ['{0E7DC9E1-A295-4FB0-B51C-58BC02DD2443}']
    {class} function init(dName: JString): JSslCertificate_DName; cdecl;
  end;

  [JavaSignature('android/net/http/SslCertificate$DName')]
  JSslCertificate_DName = interface(JObject)
    ['{EC2D4B89-D8F4-4D92-8861-C012DB574347}']
    function getCName: JString; cdecl;
    function getDName: JString; cdecl;
    function getOName: JString; cdecl;
    function getUName: JString; cdecl;
  end;
  TJSslCertificate_DName = class(TJavaGenericImport<JSslCertificate_DNameClass, JSslCertificate_DName>) end;

  JSslErrorClass = interface(JObjectClass)
    ['{46C60DBF-8FB1-4C8B-912D-AA3914A70766}']
    {class} function _GetSSL_DATE_INVALID: Integer; cdecl;
    {class} function _GetSSL_EXPIRED: Integer; cdecl;
    {class} function _GetSSL_IDMISMATCH: Integer; cdecl;
    {class} function _GetSSL_INVALID: Integer; cdecl;
    {class} function _GetSSL_MAX_ERROR: Integer; cdecl;
    {class} function _GetSSL_NOTYETVALID: Integer; cdecl;
    {class} function _GetSSL_UNTRUSTED: Integer; cdecl;
    {class} function init(error: Integer; certificate: JSslCertificate): JSslError; cdecl; overload;//Deprecated
    {class} function init(error: Integer; certificate: JX509Certificate): JSslError; cdecl; overload;//Deprecated
    {class} function init(error: Integer; certificate: JSslCertificate; url: JString): JSslError; cdecl; overload;
    {class} function init(error: Integer; certificate: JX509Certificate; url: JString): JSslError; cdecl; overload;
    {class} property SSL_DATE_INVALID: Integer read _GetSSL_DATE_INVALID;
    {class} property SSL_EXPIRED: Integer read _GetSSL_EXPIRED;
    {class} property SSL_IDMISMATCH: Integer read _GetSSL_IDMISMATCH;
    {class} property SSL_INVALID: Integer read _GetSSL_INVALID;
    {class} property SSL_MAX_ERROR: Integer read _GetSSL_MAX_ERROR;
    {class} property SSL_NOTYETVALID: Integer read _GetSSL_NOTYETVALID;
    {class} property SSL_UNTRUSTED: Integer read _GetSSL_UNTRUSTED;
  end;

  [JavaSignature('android/net/http/SslError')]
  JSslError = interface(JObject)
    ['{F52273BE-40F1-4502-9E59-72B4E06C0A47}']
    function addError(error: Integer): Boolean; cdecl;
    function getCertificate: JSslCertificate; cdecl;
    function getPrimaryError: Integer; cdecl;
    function getUrl: JString; cdecl;
    function hasError(error: Integer): Boolean; cdecl;
    function toString: JString; cdecl;
  end;
  TJSslError = class(TJavaGenericImport<JSslErrorClass, JSslError>) end;

  JX509TrustManagerExtensionsClass = interface(JObjectClass)
    ['{C2B35291-4228-4954-9EAF-A99E596F9F70}']
    {class} function init(tm: JX509TrustManager): JX509TrustManagerExtensions; cdecl;
  end;

  [JavaSignature('android/net/http/X509TrustManagerExtensions')]
  JX509TrustManagerExtensions = interface(JObject)
    ['{600A4824-9BE9-4BBD-B8F4-9F698DC6015E}']
    function checkServerTrusted(chain: TJavaObjectArray<JX509Certificate>; authType: JString; host: JString): JList; cdecl;
    function isUserAddedCertificate(cert: JX509Certificate): Boolean; cdecl;
  end;
  TJX509TrustManagerExtensions = class(TJavaGenericImport<JX509TrustManagerExtensionsClass, JX509TrustManagerExtensions>) end;

  JNsdManagerClass = interface(JObjectClass)
    ['{64105EE7-4229-4EBC-BECF-F8A59225B42F}']
    {class} function _GetACTION_NSD_STATE_CHANGED: JString; cdecl;
    {class} function _GetEXTRA_NSD_STATE: JString; cdecl;
    {class} function _GetFAILURE_ALREADY_ACTIVE: Integer; cdecl;
    {class} function _GetFAILURE_INTERNAL_ERROR: Integer; cdecl;
    {class} function _GetFAILURE_MAX_LIMIT: Integer; cdecl;
    {class} function _GetNSD_STATE_DISABLED: Integer; cdecl;
    {class} function _GetNSD_STATE_ENABLED: Integer; cdecl;
    {class} function _GetPROTOCOL_DNS_SD: Integer; cdecl;
    {class} property ACTION_NSD_STATE_CHANGED: JString read _GetACTION_NSD_STATE_CHANGED;
    {class} property EXTRA_NSD_STATE: JString read _GetEXTRA_NSD_STATE;
    {class} property FAILURE_ALREADY_ACTIVE: Integer read _GetFAILURE_ALREADY_ACTIVE;
    {class} property FAILURE_INTERNAL_ERROR: Integer read _GetFAILURE_INTERNAL_ERROR;
    {class} property FAILURE_MAX_LIMIT: Integer read _GetFAILURE_MAX_LIMIT;
    {class} property NSD_STATE_DISABLED: Integer read _GetNSD_STATE_DISABLED;
    {class} property NSD_STATE_ENABLED: Integer read _GetNSD_STATE_ENABLED;
    {class} property PROTOCOL_DNS_SD: Integer read _GetPROTOCOL_DNS_SD;
  end;

  [JavaSignature('android/net/nsd/NsdManager')]
  JNsdManager = interface(JObject)
    ['{A62E010F-FAEB-46CA-AA65-EBB36CC675C4}']
    procedure discoverServices(serviceType: JString; protocolType: Integer; listener: JNsdManager_DiscoveryListener); cdecl;
    procedure registerService(serviceInfo: JNsdServiceInfo; protocolType: Integer; listener: JNsdManager_RegistrationListener); cdecl;
    procedure resolveService(serviceInfo: JNsdServiceInfo; listener: JNsdManager_ResolveListener); cdecl;
    procedure stopServiceDiscovery(listener: JNsdManager_DiscoveryListener); cdecl;
    procedure unregisterService(listener: JNsdManager_RegistrationListener); cdecl;
  end;
  TJNsdManager = class(TJavaGenericImport<JNsdManagerClass, JNsdManager>) end;

  JNsdManager_DiscoveryListenerClass = interface(IJavaClass)
    ['{511F2509-D476-4326-84D2-8DEBC96D7661}']
  end;

  [JavaSignature('android/net/nsd/NsdManager$DiscoveryListener')]
  JNsdManager_DiscoveryListener = interface(IJavaInstance)
    ['{057C86EA-2122-4285-9FBE-97738F7C88E5}']
    procedure onDiscoveryStarted(serviceType: JString); cdecl;
    procedure onDiscoveryStopped(serviceType: JString); cdecl;
    procedure onServiceFound(serviceInfo: JNsdServiceInfo); cdecl;
    procedure onServiceLost(serviceInfo: JNsdServiceInfo); cdecl;
    procedure onStartDiscoveryFailed(serviceType: JString; errorCode: Integer); cdecl;
    procedure onStopDiscoveryFailed(serviceType: JString; errorCode: Integer); cdecl;
  end;
  TJNsdManager_DiscoveryListener = class(TJavaGenericImport<JNsdManager_DiscoveryListenerClass, JNsdManager_DiscoveryListener>) end;

  JNsdManager_RegistrationListenerClass = interface(IJavaClass)
    ['{D3DC5E79-7DC6-4118-B653-B61AB1557062}']
  end;

  [JavaSignature('android/net/nsd/NsdManager$RegistrationListener')]
  JNsdManager_RegistrationListener = interface(IJavaInstance)
    ['{D5E1A337-1954-4D1D-8A9F-2FE84FA754BC}']
    procedure onRegistrationFailed(serviceInfo: JNsdServiceInfo; errorCode: Integer); cdecl;
    procedure onServiceRegistered(serviceInfo: JNsdServiceInfo); cdecl;
    procedure onServiceUnregistered(serviceInfo: JNsdServiceInfo); cdecl;
    procedure onUnregistrationFailed(serviceInfo: JNsdServiceInfo; errorCode: Integer); cdecl;
  end;
  TJNsdManager_RegistrationListener = class(TJavaGenericImport<JNsdManager_RegistrationListenerClass, JNsdManager_RegistrationListener>) end;

  JNsdManager_ResolveListenerClass = interface(IJavaClass)
    ['{8AA4124E-568A-45E7-9E06-01EFA7F5B12F}']
  end;

  [JavaSignature('android/net/nsd/NsdManager$ResolveListener')]
  JNsdManager_ResolveListener = interface(IJavaInstance)
    ['{E8171715-94F9-4977-BE5F-61499FA18842}']
    procedure onResolveFailed(serviceInfo: JNsdServiceInfo; errorCode: Integer); cdecl;
    procedure onServiceResolved(serviceInfo: JNsdServiceInfo); cdecl;
  end;
  TJNsdManager_ResolveListener = class(TJavaGenericImport<JNsdManager_ResolveListenerClass, JNsdManager_ResolveListener>) end;

  JNsdServiceInfoClass = interface(JObjectClass)
    ['{A0A690C6-19AD-4DFF-BB84-3E8281EE928A}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JNsdServiceInfo; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/nsd/NsdServiceInfo')]
  JNsdServiceInfo = interface(JObject)
    ['{9B224A2D-23FB-4D64-B4D8-B98184D455E3}']
    function describeContents: Integer; cdecl;
    function getAttributes: TJavaObjectArray<JMap>; cdecl;
    function getHost: JInetAddress; cdecl;
    function getPort: Integer; cdecl;
    function getServiceName: JString; cdecl;
    function getServiceType: JString; cdecl;
    procedure removeAttribute(key: JString); cdecl;
    procedure setAttribute(key: JString; value: JString); cdecl;
    procedure setHost(s: JInetAddress); cdecl;
    procedure setPort(p: Integer); cdecl;
    procedure setServiceName(s: JString); cdecl;
    procedure setServiceType(s: JString); cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJNsdServiceInfo = class(TJavaGenericImport<JNsdServiceInfoClass, JNsdServiceInfo>) end;

  JAudioCodecClass = interface(JObjectClass)
    ['{D0BBEEA8-326A-426C-BB18-AA66DC82D8FD}']
    {class} function _GetAMR: JAudioCodec; cdecl;
    {class} function _GetGSM: JAudioCodec; cdecl;
    {class} function _GetGSM_EFR: JAudioCodec; cdecl;
    {class} function _GetPCMA: JAudioCodec; cdecl;
    {class} function _GetPCMU: JAudioCodec; cdecl;
    {class} function getCodec(type_: Integer; rtpmap: JString; fmtp: JString): JAudioCodec; cdecl;
    {class} function getCodecs: TJavaObjectArray<JAudioCodec>; cdecl;
    {class} property AMR: JAudioCodec read _GetAMR;
    {class} property GSM: JAudioCodec read _GetGSM;
    {class} property GSM_EFR: JAudioCodec read _GetGSM_EFR;
    {class} property PCMA: JAudioCodec read _GetPCMA;
    {class} property PCMU: JAudioCodec read _GetPCMU;
  end;

  [JavaSignature('android/net/rtp/AudioCodec')]
  JAudioCodec = interface(JObject)
    ['{5D3EAB7F-26CC-45EB-A6F5-1696F429EFD6}']
    function _Getfmtp: JString; cdecl;
    function _Getrtpmap: JString; cdecl;
    function _Gettype: Integer; cdecl;
    property fmtp: JString read _Getfmtp;
    property rtpmap: JString read _Getrtpmap;
    property &type: Integer read _Gettype;
  end;
  TJAudioCodec = class(TJavaGenericImport<JAudioCodecClass, JAudioCodec>) end;

  JAudioGroupClass = interface(JObjectClass)
    ['{FC090273-E720-4111-97EF-F79D17C3CE60}']
    {class} function _GetMODE_ECHO_SUPPRESSION: Integer; cdecl;
    {class} function _GetMODE_MUTED: Integer; cdecl;
    {class} function _GetMODE_NORMAL: Integer; cdecl;
    {class} function _GetMODE_ON_HOLD: Integer; cdecl;
    {class} function init: JAudioGroup; cdecl;
    {class} property MODE_ECHO_SUPPRESSION: Integer read _GetMODE_ECHO_SUPPRESSION;
    {class} property MODE_MUTED: Integer read _GetMODE_MUTED;
    {class} property MODE_NORMAL: Integer read _GetMODE_NORMAL;
    {class} property MODE_ON_HOLD: Integer read _GetMODE_ON_HOLD;
  end;

  [JavaSignature('android/net/rtp/AudioGroup')]
  JAudioGroup = interface(JObject)
    ['{B0C3CC5C-C61A-4EC7-87FF-CE5F74CD9E3F}']
    procedure clear; cdecl;
    function getMode: Integer; cdecl;
    function getStreams: TJavaObjectArray<JAudioStream>; cdecl;
    procedure sendDtmf(event: Integer); cdecl;
    procedure setMode(mode: Integer); cdecl;
  end;
  TJAudioGroup = class(TJavaGenericImport<JAudioGroupClass, JAudioGroup>) end;

  JRtpStreamClass = interface(JObjectClass)
    ['{F31C4CE4-0378-4F3D-AE1E-79E2E13662A4}']
    {class} function _GetMODE_NORMAL: Integer; cdecl;
    {class} function _GetMODE_RECEIVE_ONLY: Integer; cdecl;
    {class} function _GetMODE_SEND_ONLY: Integer; cdecl;
    {class} property MODE_NORMAL: Integer read _GetMODE_NORMAL;
    {class} property MODE_RECEIVE_ONLY: Integer read _GetMODE_RECEIVE_ONLY;
    {class} property MODE_SEND_ONLY: Integer read _GetMODE_SEND_ONLY;
  end;

  [JavaSignature('android/net/rtp/RtpStream')]
  JRtpStream = interface(JObject)
    ['{9D96096E-B8D2-440A-81C8-318487A5E656}']
    procedure associate(address: JInetAddress; port: Integer); cdecl;
    function getLocalAddress: JInetAddress; cdecl;
    function getLocalPort: Integer; cdecl;
    function getMode: Integer; cdecl;
    function getRemoteAddress: JInetAddress; cdecl;
    function getRemotePort: Integer; cdecl;
    function isBusy: Boolean; cdecl;
    procedure release; cdecl;
    procedure setMode(mode: Integer); cdecl;
  end;
  TJRtpStream = class(TJavaGenericImport<JRtpStreamClass, JRtpStream>) end;

  JAudioStreamClass = interface(JRtpStreamClass)
    ['{B15F1BC2-3A36-4000-AE22-40D8C8F6674C}']
    {class} function init(address: JInetAddress): JAudioStream; cdecl;
  end;

  [JavaSignature('android/net/rtp/AudioStream')]
  JAudioStream = interface(JRtpStream)
    ['{17FFCFDF-7FC5-46AB-81FF-82A4D2611968}']
    function getCodec: JAudioCodec; cdecl;
    function getDtmfType: Integer; cdecl;
    function getGroup: JAudioGroup; cdecl;
    function isBusy: Boolean; cdecl;
    procedure join(group: JAudioGroup); cdecl;
    procedure setCodec(codec: JAudioCodec); cdecl;
    procedure setDtmfType(type_: Integer); cdecl;
  end;
  TJAudioStream = class(TJavaGenericImport<JAudioStreamClass, JAudioStream>) end;

  JSipAudioCallClass = interface(JObjectClass)
    ['{29F8DAE8-810C-47D5-9CCB-550AD83F7B64}']
    {class} //function init(context: JContext; localProfile: JSipProfile): JSipAudioCall; cdecl;
  end;

  [JavaSignature('android/net/sip/SipAudioCall')]
  JSipAudioCall = interface(JObject)
    ['{C202D741-9EF4-46FC-B44E-71A47E1BE0B2}']
    procedure answerCall(timeout: Integer); cdecl;
    procedure attachCall(session: JSipSession; sessionDescription: JString); cdecl;
    procedure close; cdecl;
    procedure continueCall(timeout: Integer); cdecl;
    procedure endCall; cdecl;
    function getLocalProfile: JSipProfile; cdecl;
    function getPeerProfile: JSipProfile; cdecl;
    function getState: Integer; cdecl;
    procedure holdCall(timeout: Integer); cdecl;
    function isInCall: Boolean; cdecl;
    function isMuted: Boolean; cdecl;
    function isOnHold: Boolean; cdecl;
    procedure makeCall(peerProfile: JSipProfile; sipSession: JSipSession; timeout: Integer); cdecl;
    procedure sendDtmf(code: Integer); cdecl; overload;
    procedure sendDtmf(code: Integer; result: JMessage); cdecl; overload;
    procedure setListener(listener: JSipAudioCall_Listener); cdecl; overload;
    procedure setListener(listener: JSipAudioCall_Listener; callbackImmediately: Boolean); cdecl; overload;
    procedure setSpeakerMode(speakerMode: Boolean); cdecl;
    procedure startAudio; cdecl;
    procedure toggleMute; cdecl;
  end;
  TJSipAudioCall = class(TJavaGenericImport<JSipAudioCallClass, JSipAudioCall>) end;

  JSipAudioCall_ListenerClass = interface(JObjectClass)
    ['{F1832CF9-0244-4455-8D81-05CAD7E54EB0}']
    {class} function init: JSipAudioCall_Listener; cdecl;
  end;

  [JavaSignature('android/net/sip/SipAudioCall$Listener')]
  JSipAudioCall_Listener = interface(JObject)
    ['{86A44DF0-7A35-4BD1-9A83-0757D773FFDB}']
    procedure onCallBusy(call: JSipAudioCall); cdecl;
    procedure onCallEnded(call: JSipAudioCall); cdecl;
    procedure onCallEstablished(call: JSipAudioCall); cdecl;
    procedure onCallHeld(call: JSipAudioCall); cdecl;
    procedure onCalling(call: JSipAudioCall); cdecl;
    procedure onChanged(call: JSipAudioCall); cdecl;
    procedure onError(call: JSipAudioCall; errorCode: Integer; errorMessage: JString); cdecl;
    procedure onReadyToCall(call: JSipAudioCall); cdecl;
    procedure onRinging(call: JSipAudioCall; caller: JSipProfile); cdecl;
    procedure onRingingBack(call: JSipAudioCall); cdecl;
  end;
  TJSipAudioCall_Listener = class(TJavaGenericImport<JSipAudioCall_ListenerClass, JSipAudioCall_Listener>) end;

  JSipErrorCodeClass = interface(JObjectClass)
    ['{420819AC-E331-4259-82CC-8E5FACC4DEDD}']
    {class} function _GetCLIENT_ERROR: Integer; cdecl;
    {class} function _GetCROSS_DOMAIN_AUTHENTICATION: Integer; cdecl;
    {class} function _GetDATA_CONNECTION_LOST: Integer; cdecl;
    {class} function _GetINVALID_CREDENTIALS: Integer; cdecl;
    {class} function _GetINVALID_REMOTE_URI: Integer; cdecl;
    {class} function _GetIN_PROGRESS: Integer; cdecl;
    {class} function _GetNO_ERROR: Integer; cdecl;
    {class} function _GetPEER_NOT_REACHABLE: Integer; cdecl;
    {class} function _GetSERVER_ERROR: Integer; cdecl;
    {class} function _GetSERVER_UNREACHABLE: Integer; cdecl;
    {class} function _GetSOCKET_ERROR: Integer; cdecl;
    {class} function _GetTIME_OUT: Integer; cdecl;
    {class} function _GetTRANSACTION_TERMINTED: Integer; cdecl;
    {class} function toString(errorCode: Integer): JString; cdecl;
    {class} property CLIENT_ERROR: Integer read _GetCLIENT_ERROR;
    {class} property CROSS_DOMAIN_AUTHENTICATION: Integer read _GetCROSS_DOMAIN_AUTHENTICATION;
    {class} property DATA_CONNECTION_LOST: Integer read _GetDATA_CONNECTION_LOST;
    {class} property INVALID_CREDENTIALS: Integer read _GetINVALID_CREDENTIALS;
    {class} property INVALID_REMOTE_URI: Integer read _GetINVALID_REMOTE_URI;
    {class} property IN_PROGRESS: Integer read _GetIN_PROGRESS;
    {class} property NO_ERROR: Integer read _GetNO_ERROR;
    {class} property PEER_NOT_REACHABLE: Integer read _GetPEER_NOT_REACHABLE;
    {class} property SERVER_ERROR: Integer read _GetSERVER_ERROR;
    {class} property SERVER_UNREACHABLE: Integer read _GetSERVER_UNREACHABLE;
    {class} property SOCKET_ERROR: Integer read _GetSOCKET_ERROR;
    {class} property TIME_OUT: Integer read _GetTIME_OUT;
    {class} property TRANSACTION_TERMINTED: Integer read _GetTRANSACTION_TERMINTED;
  end;

  [JavaSignature('android/net/sip/SipErrorCode')]
  JSipErrorCode = interface(JObject)
    ['{1982EB59-8190-461C-9973-F4BB2158F96C}']
  end;
  TJSipErrorCode = class(TJavaGenericImport<JSipErrorCodeClass, JSipErrorCode>) end;

  JSipExceptionClass = interface(JExceptionClass)
    ['{2ADC2EBC-0A64-489D-A63A-4C8F3E7299C6}']
    {class} function init: JSipException; cdecl; overload;
    {class} function init(message: JString): JSipException; cdecl; overload;
    {class} function init(message: JString; cause: JThrowable): JSipException; cdecl; overload;
  end;

  [JavaSignature('android/net/sip/SipException')]
  JSipException = interface(JException)
    ['{68E78C59-1BC1-487E-8F4A-4A1D85DF67A9}']
  end;
  TJSipException = class(TJavaGenericImport<JSipExceptionClass, JSipException>) end;

  JSipManagerClass = interface(JObjectClass)
    ['{7778D960-3D28-4DCF-953C-DBB3B8540864}']
    {class} function _GetEXTRA_CALL_ID: JString; cdecl;
    {class} function _GetEXTRA_OFFER_SD: JString; cdecl;
    {class} function _GetINCOMING_CALL_RESULT_CODE: Integer; cdecl;
    {class} //function getCallId(incomingCallIntent: JIntent): JString; cdecl;
    {class} //function getOfferSessionDescription(incomingCallIntent: JIntent): JString; cdecl;
    {class} //function isApiSupported(context: JContext): Boolean; cdecl;
    {class} //function isIncomingCallIntent(intent: JIntent): Boolean; cdecl;
    {class} //function isSipWifiOnly(context: JContext): Boolean; cdecl;
    {class} //function isVoipSupported(context: JContext): Boolean; cdecl;
    {class} //function newInstance(context: JContext): JSipManager; cdecl;
    {class} property EXTRA_CALL_ID: JString read _GetEXTRA_CALL_ID;
    {class} property EXTRA_OFFER_SD: JString read _GetEXTRA_OFFER_SD;
    {class} property INCOMING_CALL_RESULT_CODE: Integer read _GetINCOMING_CALL_RESULT_CODE;
  end;

  [JavaSignature('android/net/sip/SipManager')]
  JSipManager = interface(JObject)
    ['{85E28BFD-DFF2-4513-9054-1D4C01C9DDD3}']
    procedure close(localProfileUri: JString); cdecl;
    function createSipSession(localProfile: JSipProfile; listener: JSipSession_Listener): JSipSession; cdecl;
    //function getSessionFor(incomingCallIntent: JIntent): JSipSession; cdecl;
    function isOpened(localProfileUri: JString): Boolean; cdecl;
    function isRegistered(localProfileUri: JString): Boolean; cdecl;
    function makeAudioCall(localProfile: JSipProfile; peerProfile: JSipProfile; listener: JSipAudioCall_Listener; timeout: Integer): JSipAudioCall; cdecl; overload;
    function makeAudioCall(localProfileUri: JString; peerProfileUri: JString; listener: JSipAudioCall_Listener; timeout: Integer): JSipAudioCall; cdecl; overload;
    procedure open(localProfile: JSipProfile); cdecl; overload;
    //procedure open(localProfile: JSipProfile; incomingCallPendingIntent: JPendingIntent; listener: JSipRegistrationListener); cdecl; overload;
    procedure register(localProfile: JSipProfile; expiryTime: Integer; listener: JSipRegistrationListener); cdecl;
    procedure setRegistrationListener(localProfileUri: JString; listener: JSipRegistrationListener); cdecl;
    //function takeAudioCall(incomingCallIntent: JIntent; listener: JSipAudioCall_Listener): JSipAudioCall; cdecl;
    procedure unregister(localProfile: JSipProfile; listener: JSipRegistrationListener); cdecl;
  end;
  TJSipManager = class(TJavaGenericImport<JSipManagerClass, JSipManager>) end;

  JSipProfileClass = interface(JObjectClass)
    ['{FAC70DC6-3FE4-445E-BA99-8D7D34C26870}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/sip/SipProfile')]
  JSipProfile = interface(JObject)
    ['{9BCA051D-AED4-447D-80E8-B142B27CE630}']
    function describeContents: Integer; cdecl;
    function getAuthUserName: JString; cdecl;
    function getAutoRegistration: Boolean; cdecl;
    function getDisplayName: JString; cdecl;
    function getPassword: JString; cdecl;
    function getPort: Integer; cdecl;
    function getProfileName: JString; cdecl;
    function getProtocol: JString; cdecl;
    function getProxyAddress: JString; cdecl;
    function getSendKeepAlive: Boolean; cdecl;
    function getSipDomain: JString; cdecl;
    function getUriString: JString; cdecl;
    function getUserName: JString; cdecl;
    procedure writeToParcel(out_: JParcel; flags: Integer); cdecl;
  end;
  TJSipProfile = class(TJavaGenericImport<JSipProfileClass, JSipProfile>) end;

  JSipProfile_BuilderClass = interface(JObjectClass)
    ['{05283EF7-C2F7-47BC-A5BE-F8DF295D7382}']
    {class} function init(profile: JSipProfile): JSipProfile_Builder; cdecl; overload;
    {class} function init(uriString: JString): JSipProfile_Builder; cdecl; overload;
    {class} function init(username: JString; serverDomain: JString): JSipProfile_Builder; cdecl; overload;
  end;

  [JavaSignature('android/net/sip/SipProfile$Builder')]
  JSipProfile_Builder = interface(JObject)
    ['{767B596B-BC13-4F29-ABE4-AFD83577826B}']
    function build: JSipProfile; cdecl;
    function setAuthUserName(name: JString): JSipProfile_Builder; cdecl;
    function setAutoRegistration(flag: Boolean): JSipProfile_Builder; cdecl;
    function setDisplayName(displayName: JString): JSipProfile_Builder; cdecl;
    function setOutboundProxy(outboundProxy: JString): JSipProfile_Builder; cdecl;
    function setPassword(password: JString): JSipProfile_Builder; cdecl;
    function setPort(port: Integer): JSipProfile_Builder; cdecl;
    function setProfileName(name: JString): JSipProfile_Builder; cdecl;
    function setProtocol(protocol: JString): JSipProfile_Builder; cdecl;
    function setSendKeepAlive(flag: Boolean): JSipProfile_Builder; cdecl;
  end;
  TJSipProfile_Builder = class(TJavaGenericImport<JSipProfile_BuilderClass, JSipProfile_Builder>) end;

  JSipRegistrationListenerClass = interface(IJavaClass)
    ['{4E6C2090-2E90-4D70-B89B-7A99F778DA2D}']
  end;

  [JavaSignature('android/net/sip/SipRegistrationListener')]
  JSipRegistrationListener = interface(IJavaInstance)
    ['{1ED240E6-DDEF-4626-9EA2-C62B459A5F6A}']
    procedure onRegistering(localProfileUri: JString); cdecl;
    procedure onRegistrationDone(localProfileUri: JString; expiryTime: Int64); cdecl;
    procedure onRegistrationFailed(localProfileUri: JString; errorCode: Integer; errorMessage: JString); cdecl;
  end;
  TJSipRegistrationListener = class(TJavaGenericImport<JSipRegistrationListenerClass, JSipRegistrationListener>) end;

  JSipSessionClass = interface(JObjectClass)
    ['{3D6D2C96-28DF-4254-A175-60FF059BA313}']
  end;

  [JavaSignature('android/net/sip/SipSession')]
  JSipSession = interface(JObject)
    ['{F76E851E-8DF2-47FF-ACF1-38177E0DAD5A}']
    procedure answerCall(sessionDescription: JString; timeout: Integer); cdecl;
    procedure changeCall(sessionDescription: JString; timeout: Integer); cdecl;
    procedure endCall; cdecl;
    function getCallId: JString; cdecl;
    function getLocalIp: JString; cdecl;
    function getLocalProfile: JSipProfile; cdecl;
    function getPeerProfile: JSipProfile; cdecl;
    function getState: Integer; cdecl;
    function isInCall: Boolean; cdecl;
    procedure makeCall(callee: JSipProfile; sessionDescription: JString; timeout: Integer); cdecl;
    procedure register(duration: Integer); cdecl;
    procedure setListener(listener: JSipSession_Listener); cdecl;
    procedure unregister; cdecl;
  end;
  TJSipSession = class(TJavaGenericImport<JSipSessionClass, JSipSession>) end;

  JSipSession_ListenerClass = interface(JObjectClass)
    ['{76664C9D-D8F9-42D0-8A2D-D54BF3F3B962}']
    {class} function init: JSipSession_Listener; cdecl;
  end;

  [JavaSignature('android/net/sip/SipSession$Listener')]
  JSipSession_Listener = interface(JObject)
    ['{AE555B3F-03D9-42B0-ADEC-F928509A13EE}']
    procedure onCallBusy(session: JSipSession); cdecl;
    procedure onCallChangeFailed(session: JSipSession; errorCode: Integer; errorMessage: JString); cdecl;
    procedure onCallEnded(session: JSipSession); cdecl;
    procedure onCallEstablished(session: JSipSession; sessionDescription: JString); cdecl;
    procedure onCalling(session: JSipSession); cdecl;
    procedure onError(session: JSipSession; errorCode: Integer; errorMessage: JString); cdecl;
    procedure onRegistering(session: JSipSession); cdecl;
    procedure onRegistrationDone(session: JSipSession; duration: Integer); cdecl;
    procedure onRegistrationFailed(session: JSipSession; errorCode: Integer; errorMessage: JString); cdecl;
    procedure onRegistrationTimeout(session: JSipSession); cdecl;
    procedure onRinging(session: JSipSession; caller: JSipProfile; sessionDescription: JString); cdecl;
    procedure onRingingBack(session: JSipSession); cdecl;
  end;
  TJSipSession_Listener = class(TJavaGenericImport<JSipSession_ListenerClass, JSipSession_Listener>) end;

  JSipSession_StateClass = interface(JObjectClass)
    ['{7DBF834C-22CD-4A2E-9210-DC1C419B8B8E}']
    {class} function _GetDEREGISTERING: Integer; cdecl;
    {class} function _GetINCOMING_CALL: Integer; cdecl;
    {class} function _GetINCOMING_CALL_ANSWERING: Integer; cdecl;
    {class} function _GetIN_CALL: Integer; cdecl;
    {class} function _GetNOT_DEFINED: Integer; cdecl;
    {class} function _GetOUTGOING_CALL: Integer; cdecl;
    {class} function _GetOUTGOING_CALL_CANCELING: Integer; cdecl;
    {class} function _GetOUTGOING_CALL_RING_BACK: Integer; cdecl;
    {class} function _GetPINGING: Integer; cdecl;
    {class} function _GetREADY_TO_CALL: Integer; cdecl;
    {class} function _GetREGISTERING: Integer; cdecl;
    {class} function toString(state: Integer): JString; cdecl;
    {class} property DEREGISTERING: Integer read _GetDEREGISTERING;
    {class} property INCOMING_CALL: Integer read _GetINCOMING_CALL;
    {class} property INCOMING_CALL_ANSWERING: Integer read _GetINCOMING_CALL_ANSWERING;
    {class} property IN_CALL: Integer read _GetIN_CALL;
    {class} property NOT_DEFINED: Integer read _GetNOT_DEFINED;
    {class} property OUTGOING_CALL: Integer read _GetOUTGOING_CALL;
    {class} property OUTGOING_CALL_CANCELING: Integer read _GetOUTGOING_CALL_CANCELING;
    {class} property OUTGOING_CALL_RING_BACK: Integer read _GetOUTGOING_CALL_RING_BACK;
    {class} property PINGING: Integer read _GetPINGING;
    {class} property READY_TO_CALL: Integer read _GetREADY_TO_CALL;
    {class} property REGISTERING: Integer read _GetREGISTERING;
  end;

  [JavaSignature('android/net/sip/SipSession$State')]
  JSipSession_State = interface(JObject)
    ['{C759EABE-2AE4-458F-A9DD-608B3C0E9121}']
  end;
  TJSipSession_State = class(TJavaGenericImport<JSipSession_StateClass, JSipSession_State>) end;

  JScanResultClass = interface(JObjectClass)
    ['{6C743694-E698-4C31-805F-13546BC872D7}']
    {class} function _GetCHANNEL_WIDTH_160MHZ: Integer; cdecl;
    {class} function _GetCHANNEL_WIDTH_20MHZ: Integer; cdecl;
    {class} function _GetCHANNEL_WIDTH_40MHZ: Integer; cdecl;
    {class} function _GetCHANNEL_WIDTH_80MHZ: Integer; cdecl;
    {class} function _GetCHANNEL_WIDTH_80MHZ_PLUS_MHZ: Integer; cdecl;
    {class} property CHANNEL_WIDTH_160MHZ: Integer read _GetCHANNEL_WIDTH_160MHZ;
    {class} property CHANNEL_WIDTH_20MHZ: Integer read _GetCHANNEL_WIDTH_20MHZ;
    {class} property CHANNEL_WIDTH_40MHZ: Integer read _GetCHANNEL_WIDTH_40MHZ;
    {class} property CHANNEL_WIDTH_80MHZ: Integer read _GetCHANNEL_WIDTH_80MHZ;
    {class} property CHANNEL_WIDTH_80MHZ_PLUS_MHZ: Integer read _GetCHANNEL_WIDTH_80MHZ_PLUS_MHZ;
  end;

  [JavaSignature('android/net/wifi/ScanResult')]
  JScanResult = interface(JObject)
    ['{A50FF87A-D68A-4CCC-B186-D06D51E76145}']
    function _GetBSSID: JString; cdecl;
    procedure _SetBSSID(Value: JString); cdecl;
    function _GetSSID: JString; cdecl;
    procedure _SetSSID(Value: JString); cdecl;
    function _Getcapabilities: JString; cdecl;
    procedure _Setcapabilities(Value: JString); cdecl;
    function _GetcenterFreq0: Integer; cdecl;
    procedure _SetcenterFreq0(Value: Integer); cdecl;
    function _GetcenterFreq1: Integer; cdecl;
    procedure _SetcenterFreq1(Value: Integer); cdecl;
    function _GetchannelWidth: Integer; cdecl;
    procedure _SetchannelWidth(Value: Integer); cdecl;
    function _Getfrequency: Integer; cdecl;
    procedure _Setfrequency(Value: Integer); cdecl;
    function _Getlevel: Integer; cdecl;
    procedure _Setlevel(Value: Integer); cdecl;
    function _GetoperatorFriendlyName: JCharSequence; cdecl;
    procedure _SetoperatorFriendlyName(Value: JCharSequence); cdecl;
    function _Gettimestamp: Int64; cdecl;
    procedure _Settimestamp(Value: Int64); cdecl;
    function _GetvenueName: JCharSequence; cdecl;
    procedure _SetvenueName(Value: JCharSequence); cdecl;
    function is80211mcResponder: Boolean; cdecl;
    function isPasspointNetwork: Boolean; cdecl;
    function toString: JString; cdecl;
    property BSSID: JString read _GetBSSID write _SetBSSID;
    property SSID: JString read _GetSSID write _SetSSID;
    property capabilities: JString read _Getcapabilities write _Setcapabilities;
    property centerFreq0: Integer read _GetcenterFreq0 write _SetcenterFreq0;
    property centerFreq1: Integer read _GetcenterFreq1 write _SetcenterFreq1;
    property channelWidth: Integer read _GetchannelWidth write _SetchannelWidth;
    property frequency: Integer read _Getfrequency write _Setfrequency;
    property level: Integer read _Getlevel write _Setlevel;
    property operatorFriendlyName: JCharSequence read _GetoperatorFriendlyName write _SetoperatorFriendlyName;
    property timestamp: Int64 read _Gettimestamp write _Settimestamp;
    property venueName: JCharSequence read _GetvenueName write _SetvenueName;
  end;
  TJScanResult = class(TJavaGenericImport<JScanResultClass, JScanResult>) end;

  JSupplicantStateClass = interface(JEnumClass)
    ['{11D5113E-AE84-4F4C-832D-5F9E78A93530}']
    {class} function _GetASSOCIATED: JSupplicantState; cdecl;
    {class} function _GetASSOCIATING: JSupplicantState; cdecl;
    {class} function _GetAUTHENTICATING: JSupplicantState; cdecl;
    {class} function _GetCOMPLETED: JSupplicantState; cdecl;
    {class} function _GetDISCONNECTED: JSupplicantState; cdecl;
    {class} function _GetDORMANT: JSupplicantState; cdecl;
    {class} function _GetFOUR_WAY_HANDSHAKE: JSupplicantState; cdecl;
    {class} function _GetGROUP_HANDSHAKE: JSupplicantState; cdecl;
    {class} function _GetINACTIVE: JSupplicantState; cdecl;
    {class} function _GetINTERFACE_DISABLED: JSupplicantState; cdecl;
    {class} function _GetINVALID: JSupplicantState; cdecl;
    {class} function _GetSCANNING: JSupplicantState; cdecl;
    {class} function _GetUNINITIALIZED: JSupplicantState; cdecl;
    {class} function isValidState(state: JSupplicantState): Boolean; cdecl;
    {class} function valueOf(name: JString): JSupplicantState; cdecl;
    {class} function values: TJavaObjectArray<JSupplicantState>; cdecl;
    {class} property ASSOCIATED: JSupplicantState read _GetASSOCIATED;
    {class} property ASSOCIATING: JSupplicantState read _GetASSOCIATING;
    {class} property AUTHENTICATING: JSupplicantState read _GetAUTHENTICATING;
    {class} property COMPLETED: JSupplicantState read _GetCOMPLETED;
    {class} property DISCONNECTED: JSupplicantState read _GetDISCONNECTED;
    {class} property DORMANT: JSupplicantState read _GetDORMANT;
    {class} property FOUR_WAY_HANDSHAKE: JSupplicantState read _GetFOUR_WAY_HANDSHAKE;
    {class} property GROUP_HANDSHAKE: JSupplicantState read _GetGROUP_HANDSHAKE;
    {class} property INACTIVE: JSupplicantState read _GetINACTIVE;
    {class} property INTERFACE_DISABLED: JSupplicantState read _GetINTERFACE_DISABLED;
    {class} property INVALID: JSupplicantState read _GetINVALID;
    {class} property SCANNING: JSupplicantState read _GetSCANNING;
    {class} property UNINITIALIZED: JSupplicantState read _GetUNINITIALIZED;
  end;

  [JavaSignature('android/net/wifi/SupplicantState')]
  JSupplicantState = interface(JEnum)
    ['{1733F9B5-2434-461F-8DF6-F23617BFA5D8}']
  end;
  TJSupplicantState = class(TJavaGenericImport<JSupplicantStateClass, JSupplicantState>) end;

  JWifiConfigurationClass = interface(JObjectClass)
    ['{C8BFCCBF-51DC-4210-9559-EFF599859A26}']
    {class} function init: JWifiConfiguration; cdecl;
  end;

  [JavaSignature('android/net/wifi/WifiConfiguration')]
  JWifiConfiguration = interface(JObject)
    ['{ED67818C-4A3D-441D-987A-9E8826085924}']
    function _GetBSSID: JString; cdecl;
    procedure _SetBSSID(Value: JString); cdecl;
    function _GetFQDN: JString; cdecl;
    procedure _SetFQDN(Value: JString); cdecl;
    function _GetSSID: JString; cdecl;
    procedure _SetSSID(Value: JString); cdecl;
    function _GetallowedAuthAlgorithms: JBitSet; cdecl;
    procedure _SetallowedAuthAlgorithms(Value: JBitSet); cdecl;
    function _GetallowedGroupCiphers: JBitSet; cdecl;
    procedure _SetallowedGroupCiphers(Value: JBitSet); cdecl;
    function _GetallowedKeyManagement: JBitSet; cdecl;
    procedure _SetallowedKeyManagement(Value: JBitSet); cdecl;
    function _GetallowedPairwiseCiphers: JBitSet; cdecl;
    procedure _SetallowedPairwiseCiphers(Value: JBitSet); cdecl;
    function _GetallowedProtocols: JBitSet; cdecl;
    procedure _SetallowedProtocols(Value: JBitSet); cdecl;
    function _GetenterpriseConfig: JWifiEnterpriseConfig; cdecl;
    procedure _SetenterpriseConfig(Value: JWifiEnterpriseConfig); cdecl;
    function _GethiddenSSID: Boolean; cdecl;
    procedure _SethiddenSSID(Value: Boolean); cdecl;
    function _GetnetworkId: Integer; cdecl;
    procedure _SetnetworkId(Value: Integer); cdecl;
    function _GetpreSharedKey: JString; cdecl;
    procedure _SetpreSharedKey(Value: JString); cdecl;
    function _Getpriority: Integer; cdecl;
    procedure _Setpriority(Value: Integer); cdecl;
    function _GetproviderFriendlyName: JString; cdecl;
    procedure _SetproviderFriendlyName(Value: JString); cdecl;
    function _GetroamingConsortiumIds: TJavaArray<Int64>; cdecl;
    procedure _SetroamingConsortiumIds(Value: TJavaArray<Int64>); cdecl;
    function _Getstatus: Integer; cdecl;
    procedure _Setstatus(Value: Integer); cdecl;
    function _GetwepKeys: TJavaObjectArray<JString>; cdecl;
    procedure _SetwepKeys(Value: TJavaObjectArray<JString>); cdecl;
    function _GetwepTxKeyIndex: Integer; cdecl;
    procedure _SetwepTxKeyIndex(Value: Integer); cdecl;
    function isPasspoint: Boolean; cdecl;
    function toString: JString; cdecl;
    property BSSID: JString read _GetBSSID write _SetBSSID;
    property FQDN: JString read _GetFQDN write _SetFQDN;
    property SSID: JString read _GetSSID write _SetSSID;
    property allowedAuthAlgorithms: JBitSet read _GetallowedAuthAlgorithms write _SetallowedAuthAlgorithms;
    property allowedGroupCiphers: JBitSet read _GetallowedGroupCiphers write _SetallowedGroupCiphers;
    property allowedKeyManagement: JBitSet read _GetallowedKeyManagement write _SetallowedKeyManagement;
    property allowedPairwiseCiphers: JBitSet read _GetallowedPairwiseCiphers write _SetallowedPairwiseCiphers;
    property allowedProtocols: JBitSet read _GetallowedProtocols write _SetallowedProtocols;
    property enterpriseConfig: JWifiEnterpriseConfig read _GetenterpriseConfig write _SetenterpriseConfig;
    property hiddenSSID: Boolean read _GethiddenSSID write _SethiddenSSID;
    property networkId: Integer read _GetnetworkId write _SetnetworkId;
    property preSharedKey: JString read _GetpreSharedKey write _SetpreSharedKey;
    property priority: Integer read _Getpriority write _Setpriority;
    property providerFriendlyName: JString read _GetproviderFriendlyName write _SetproviderFriendlyName;
    property roamingConsortiumIds: TJavaArray<Int64> read _GetroamingConsortiumIds write _SetroamingConsortiumIds;
    property status: Integer read _Getstatus write _Setstatus;
    property wepKeys: TJavaObjectArray<JString> read _GetwepKeys write _SetwepKeys;
    property wepTxKeyIndex: Integer read _GetwepTxKeyIndex write _SetwepTxKeyIndex;
  end;
  TJWifiConfiguration = class(TJavaGenericImport<JWifiConfigurationClass, JWifiConfiguration>) end;

  JWifiConfiguration_AuthAlgorithmClass = interface(JObjectClass)
    ['{047D5EC9-9464-4C1F-972A-F1BE5E10672E}']
    {class} function _GetLEAP: Integer; cdecl;
    {class} function _GetOPEN: Integer; cdecl;
    {class} function _GetSHARED: Integer; cdecl;
    {class} function _Getstrings: TJavaObjectArray<JString>; cdecl;
    {class} function _GetvarName: JString; cdecl;
    {class} property LEAP: Integer read _GetLEAP;
    {class} property OPEN: Integer read _GetOPEN;
    {class} property SHARED: Integer read _GetSHARED;
    {class} property strings: TJavaObjectArray<JString> read _Getstrings;
    {class} property varName: JString read _GetvarName;
  end;

  [JavaSignature('android/net/wifi/WifiConfiguration$AuthAlgorithm')]
  JWifiConfiguration_AuthAlgorithm = interface(JObject)
    ['{2258AEE7-6025-42A4-9812-F8340FDC38EE}']
  end;
  TJWifiConfiguration_AuthAlgorithm = class(TJavaGenericImport<JWifiConfiguration_AuthAlgorithmClass, JWifiConfiguration_AuthAlgorithm>) end;

  JWifiConfiguration_GroupCipherClass = interface(JObjectClass)
    ['{001FFC70-CA9D-415E-BB87-15BB196C6671}']
    {class} function _GetCCMP: Integer; cdecl;
    {class} function _GetTKIP: Integer; cdecl;
    {class} function _GetWEP104: Integer; cdecl;
    {class} function _GetWEP40: Integer; cdecl;
    {class} function _Getstrings: TJavaObjectArray<JString>; cdecl;
    {class} function _GetvarName: JString; cdecl;
    {class} property CCMP: Integer read _GetCCMP;
    {class} property TKIP: Integer read _GetTKIP;
    {class} property WEP104: Integer read _GetWEP104;
    {class} property WEP40: Integer read _GetWEP40;
    {class} property strings: TJavaObjectArray<JString> read _Getstrings;
    {class} property varName: JString read _GetvarName;
  end;

  [JavaSignature('android/net/wifi/WifiConfiguration$GroupCipher')]
  JWifiConfiguration_GroupCipher = interface(JObject)
    ['{B1180E11-3616-45A4-A088-FB7D2964AA75}']
  end;
  TJWifiConfiguration_GroupCipher = class(TJavaGenericImport<JWifiConfiguration_GroupCipherClass, JWifiConfiguration_GroupCipher>) end;

  JWifiConfiguration_KeyMgmtClass = interface(JObjectClass)
    ['{EC2914FD-30CD-463D-A620-178C20486690}']
    {class} function _GetIEEE8021X: Integer; cdecl;
    {class} function _GetNONE: Integer; cdecl;
    {class} function _GetWPA_EAP: Integer; cdecl;
    {class} function _GetWPA_PSK: Integer; cdecl;
    {class} function _Getstrings: TJavaObjectArray<JString>; cdecl;
    {class} function _GetvarName: JString; cdecl;
    {class} property IEEE8021X: Integer read _GetIEEE8021X;
    {class} property NONE: Integer read _GetNONE;
    {class} property WPA_EAP: Integer read _GetWPA_EAP;
    {class} property WPA_PSK: Integer read _GetWPA_PSK;
    {class} property strings: TJavaObjectArray<JString> read _Getstrings;
    {class} property varName: JString read _GetvarName;
  end;

  [JavaSignature('android/net/wifi/WifiConfiguration$KeyMgmt')]
  JWifiConfiguration_KeyMgmt = interface(JObject)
    ['{75054BB4-74D2-4C59-95FE-F1B32C1DAAAE}']
  end;
  TJWifiConfiguration_KeyMgmt = class(TJavaGenericImport<JWifiConfiguration_KeyMgmtClass, JWifiConfiguration_KeyMgmt>) end;

  JWifiConfiguration_PairwiseCipherClass = interface(JObjectClass)
    ['{186CC97E-C88C-49C5-AC1C-40679A9E0827}']
    {class} function _GetCCMP: Integer; cdecl;
    {class} function _GetNONE: Integer; cdecl;
    {class} function _GetTKIP: Integer; cdecl;
    {class} function _Getstrings: TJavaObjectArray<JString>; cdecl;
    {class} function _GetvarName: JString; cdecl;
    {class} property CCMP: Integer read _GetCCMP;
    {class} property NONE: Integer read _GetNONE;
    {class} property TKIP: Integer read _GetTKIP;
    {class} property strings: TJavaObjectArray<JString> read _Getstrings;
    {class} property varName: JString read _GetvarName;
  end;

  [JavaSignature('android/net/wifi/WifiConfiguration$PairwiseCipher')]
  JWifiConfiguration_PairwiseCipher = interface(JObject)
    ['{10CF8A7C-307F-45DD-87AD-AAE724FD9486}']
  end;
  TJWifiConfiguration_PairwiseCipher = class(TJavaGenericImport<JWifiConfiguration_PairwiseCipherClass, JWifiConfiguration_PairwiseCipher>) end;

  JWifiConfiguration_ProtocolClass = interface(JObjectClass)
    ['{1FD6FF63-356B-41B1-BD8D-B6C8666BAD18}']
    {class} function _GetRSN: Integer; cdecl;
    {class} function _GetWPA: Integer; cdecl;
    {class} function _Getstrings: TJavaObjectArray<JString>; cdecl;
    {class} function _GetvarName: JString; cdecl;
    {class} property RSN: Integer read _GetRSN;
    {class} property WPA: Integer read _GetWPA;
    {class} property strings: TJavaObjectArray<JString> read _Getstrings;
    {class} property varName: JString read _GetvarName;
  end;

  [JavaSignature('android/net/wifi/WifiConfiguration$Protocol')]
  JWifiConfiguration_Protocol = interface(JObject)
    ['{E6C85E59-1C0B-4562-933A-63DDC77383CC}']
  end;
  TJWifiConfiguration_Protocol = class(TJavaGenericImport<JWifiConfiguration_ProtocolClass, JWifiConfiguration_Protocol>) end;

  JWifiConfiguration_StatusClass = interface(JObjectClass)
    ['{20D5CCD8-896F-47DD-A0F3-7D00B5CE8A10}']
    {class} function _GetCURRENT: Integer; cdecl;
    {class} function _GetDISABLED: Integer; cdecl;
    {class} function _GetENABLED: Integer; cdecl;
    {class} function _Getstrings: TJavaObjectArray<JString>; cdecl;
    {class} property CURRENT: Integer read _GetCURRENT;
    {class} property DISABLED: Integer read _GetDISABLED;
    {class} property ENABLED: Integer read _GetENABLED;
    {class} property strings: TJavaObjectArray<JString> read _Getstrings;
  end;

  [JavaSignature('android/net/wifi/WifiConfiguration$Status')]
  JWifiConfiguration_Status = interface(JObject)
    ['{F808D628-9382-4509-BD14-BF697EB5A088}']
  end;
  TJWifiConfiguration_Status = class(TJavaGenericImport<JWifiConfiguration_StatusClass, JWifiConfiguration_Status>) end;

  JWifiEnterpriseConfigClass = interface(JObjectClass)
    ['{8583C57E-0204-4BC8-B0D5-8B25DA81985B}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JWifiEnterpriseConfig; cdecl; overload;
    {class} function init(source: JWifiEnterpriseConfig): JWifiEnterpriseConfig; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/wifi/WifiEnterpriseConfig')]
  JWifiEnterpriseConfig = interface(JObject)
    ['{B822B902-C591-48D1-BEFF-56FC393A03A7}']
    function describeContents: Integer; cdecl;
    function getAltSubjectMatch: JString; cdecl;
    function getAnonymousIdentity: JString; cdecl;
    function getCaCertificate: JX509Certificate; cdecl;
    function getClientCertificate: JX509Certificate; cdecl;
    function getDomainSuffixMatch: JString; cdecl;
    function getEapMethod: Integer; cdecl;
    function getIdentity: JString; cdecl;
    function getPassword: JString; cdecl;
    function getPhase2Method: Integer; cdecl;
    function getPlmn: JString; cdecl;
    function getRealm: JString; cdecl;
    function getSubjectMatch: JString; cdecl;//Deprecated
    procedure setAltSubjectMatch(altSubjectMatch: JString); cdecl;
    procedure setAnonymousIdentity(anonymousIdentity: JString); cdecl;
    procedure setCaCertificate(cert: JX509Certificate); cdecl;
    procedure setClientKeyEntry(privateKey: JPrivateKey; clientCertificate: JX509Certificate); cdecl;
    procedure setDomainSuffixMatch(domain: JString); cdecl;
    procedure setEapMethod(eapMethod: Integer); cdecl;
    procedure setIdentity(identity: JString); cdecl;
    procedure setPassword(password: JString); cdecl;
    procedure setPhase2Method(phase2Method: Integer); cdecl;
    procedure setPlmn(plmn: JString); cdecl;
    procedure setRealm(realm: JString); cdecl;
    procedure setSubjectMatch(subjectMatch: JString); cdecl;//Deprecated
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJWifiEnterpriseConfig = class(TJavaGenericImport<JWifiEnterpriseConfigClass, JWifiEnterpriseConfig>) end;

  JWifiEnterpriseConfig_EapClass = interface(JObjectClass)
    ['{CFCC6A75-76D5-4094-902D-8B73B1E3888E}']
    {class} function _GetAKA: Integer; cdecl;
    {class} function _GetAKA_PRIME: Integer; cdecl;
    {class} function _GetNONE: Integer; cdecl;
    {class} function _GetPEAP: Integer; cdecl;
    {class} function _GetPWD: Integer; cdecl;
    {class} function _GetSIM: Integer; cdecl;
    {class} function _GetTLS: Integer; cdecl;
    {class} function _GetTTLS: Integer; cdecl;
    {class} property AKA: Integer read _GetAKA;
    {class} property AKA_PRIME: Integer read _GetAKA_PRIME;
    {class} property NONE: Integer read _GetNONE;
    {class} property PEAP: Integer read _GetPEAP;
    {class} property PWD: Integer read _GetPWD;
    {class} property SIM: Integer read _GetSIM;
    {class} property TLS: Integer read _GetTLS;
    {class} property TTLS: Integer read _GetTTLS;
  end;

  [JavaSignature('android/net/wifi/WifiEnterpriseConfig$Eap')]
  JWifiEnterpriseConfig_Eap = interface(JObject)
    ['{4880D3DC-10FE-4740-A2DE-BB9EC21EED0B}']
  end;
  TJWifiEnterpriseConfig_Eap = class(TJavaGenericImport<JWifiEnterpriseConfig_EapClass, JWifiEnterpriseConfig_Eap>) end;

  JWifiEnterpriseConfig_Phase2Class = interface(JObjectClass)
    ['{D9150CF8-D11C-4D58-94DF-56BA5805D44E}']
    {class} function _GetGTC: Integer; cdecl;
    {class} function _GetMSCHAP: Integer; cdecl;
    {class} function _GetMSCHAPV2: Integer; cdecl;
    {class} function _GetNONE: Integer; cdecl;
    {class} function _GetPAP: Integer; cdecl;
    {class} property GTC: Integer read _GetGTC;
    {class} property MSCHAP: Integer read _GetMSCHAP;
    {class} property MSCHAPV2: Integer read _GetMSCHAPV2;
    {class} property NONE: Integer read _GetNONE;
    {class} property PAP: Integer read _GetPAP;
  end;

  [JavaSignature('android/net/wifi/WifiEnterpriseConfig$Phase2')]
  JWifiEnterpriseConfig_Phase2 = interface(JObject)
    ['{47DF010A-28A3-4F03-B88E-FD4F1BCD32EC}']
  end;
  TJWifiEnterpriseConfig_Phase2 = class(TJavaGenericImport<JWifiEnterpriseConfig_Phase2Class, JWifiEnterpriseConfig_Phase2>) end;

  JWifiInfoClass = interface(JObjectClass)
    ['{8CC8F57E-4945-400E-9F19-626BDDCB496A}']
    {class} function _GetFREQUENCY_UNITS: JString; cdecl;
    {class} function _GetLINK_SPEED_UNITS: JString; cdecl;
    {class} function getDetailedStateOf(suppState: JSupplicantState): JNetworkInfo_DetailedState; cdecl;
    {class} property FREQUENCY_UNITS: JString read _GetFREQUENCY_UNITS;
    {class} property LINK_SPEED_UNITS: JString read _GetLINK_SPEED_UNITS;
  end;

  [JavaSignature('android/net/wifi/WifiInfo')]
  JWifiInfo = interface(JObject)
    ['{D1AC40A2-AD68-4A81-ABD0-A0476CA41C22}']
    function getBSSID: JString; cdecl;
    function getFrequency: Integer; cdecl;
    function getHiddenSSID: Boolean; cdecl;
    function getIpAddress: Integer; cdecl;
    function getLinkSpeed: Integer; cdecl;
    function getMacAddress: JString; cdecl;
    function getNetworkId: Integer; cdecl;
    function getRssi: Integer; cdecl;
    function getSSID: JString; cdecl;
    function getSupplicantState: JSupplicantState; cdecl;
    function toString: JString; cdecl;
  end;
  TJWifiInfo = class(TJavaGenericImport<JWifiInfoClass, JWifiInfo>) end;

  JWifiManagerClass = interface(JObjectClass)
    ['{A3559F69-A273-4480-972E-48D2381B1F93}']
    {class} function _GetACTION_PICK_WIFI_NETWORK: JString; cdecl;
    {class} function _GetACTION_REQUEST_SCAN_ALWAYS_AVAILABLE: JString; cdecl;
    {class} function _GetERROR_AUTHENTICATING: Integer; cdecl;
    {class} function _GetEXTRA_BSSID: JString; cdecl;
    {class} function _GetEXTRA_NETWORK_INFO: JString; cdecl;
    {class} function _GetEXTRA_NEW_RSSI: JString; cdecl;
    {class} function _GetEXTRA_NEW_STATE: JString; cdecl;
    {class} function _GetEXTRA_PREVIOUS_WIFI_STATE: JString; cdecl;
    {class} function _GetEXTRA_RESULTS_UPDATED: JString; cdecl;
    {class} function _GetEXTRA_SUPPLICANT_CONNECTED: JString; cdecl;
    {class} function _GetEXTRA_SUPPLICANT_ERROR: JString; cdecl;
    {class} function _GetEXTRA_WIFI_INFO: JString; cdecl;
    {class} function _GetEXTRA_WIFI_STATE: JString; cdecl;
    {class} function _GetNETWORK_IDS_CHANGED_ACTION: JString; cdecl;
    {class} function _GetNETWORK_STATE_CHANGED_ACTION: JString; cdecl;
    {class} function _GetRSSI_CHANGED_ACTION: JString; cdecl;
    {class} function _GetSCAN_RESULTS_AVAILABLE_ACTION: JString; cdecl;
    {class} function _GetSUPPLICANT_CONNECTION_CHANGE_ACTION: JString; cdecl;
    {class} function _GetSUPPLICANT_STATE_CHANGED_ACTION: JString; cdecl;
    {class} function _GetWIFI_MODE_FULL: Integer; cdecl;
    {class} function _GetWIFI_MODE_FULL_HIGH_PERF: Integer; cdecl;
    {class} function _GetWIFI_MODE_SCAN_ONLY: Integer; cdecl;
    {class} function _GetWIFI_STATE_CHANGED_ACTION: JString; cdecl;
    {class} function _GetWIFI_STATE_DISABLED: Integer; cdecl;
    {class} function _GetWIFI_STATE_DISABLING: Integer; cdecl;
    {class} function _GetWIFI_STATE_ENABLED: Integer; cdecl;
    {class} function _GetWIFI_STATE_ENABLING: Integer; cdecl;
    {class} function _GetWIFI_STATE_UNKNOWN: Integer; cdecl;
    {class} function _GetWPS_AUTH_FAILURE: Integer; cdecl;
    {class} function _GetWPS_OVERLAP_ERROR: Integer; cdecl;
    {class} function _GetWPS_TIMED_OUT: Integer; cdecl;
    {class} function _GetWPS_TKIP_ONLY_PROHIBITED: Integer; cdecl;
    {class} function _GetWPS_WEP_PROHIBITED: Integer; cdecl;
    {class} function calculateSignalLevel(rssi: Integer; numLevels: Integer): Integer; cdecl;
    {class} function compareSignalLevel(rssiA: Integer; rssiB: Integer): Integer; cdecl;
    {class} property ACTION_PICK_WIFI_NETWORK: JString read _GetACTION_PICK_WIFI_NETWORK;
    {class} property ACTION_REQUEST_SCAN_ALWAYS_AVAILABLE: JString read _GetACTION_REQUEST_SCAN_ALWAYS_AVAILABLE;
    {class} property ERROR_AUTHENTICATING: Integer read _GetERROR_AUTHENTICATING;
    {class} property EXTRA_BSSID: JString read _GetEXTRA_BSSID;
    {class} property EXTRA_NETWORK_INFO: JString read _GetEXTRA_NETWORK_INFO;
    {class} property EXTRA_NEW_RSSI: JString read _GetEXTRA_NEW_RSSI;
    {class} property EXTRA_NEW_STATE: JString read _GetEXTRA_NEW_STATE;
    {class} property EXTRA_PREVIOUS_WIFI_STATE: JString read _GetEXTRA_PREVIOUS_WIFI_STATE;
    {class} property EXTRA_RESULTS_UPDATED: JString read _GetEXTRA_RESULTS_UPDATED;
    {class} property EXTRA_SUPPLICANT_CONNECTED: JString read _GetEXTRA_SUPPLICANT_CONNECTED;
    {class} property EXTRA_SUPPLICANT_ERROR: JString read _GetEXTRA_SUPPLICANT_ERROR;
    {class} property EXTRA_WIFI_INFO: JString read _GetEXTRA_WIFI_INFO;
    {class} property EXTRA_WIFI_STATE: JString read _GetEXTRA_WIFI_STATE;
    {class} property NETWORK_IDS_CHANGED_ACTION: JString read _GetNETWORK_IDS_CHANGED_ACTION;
    {class} property NETWORK_STATE_CHANGED_ACTION: JString read _GetNETWORK_STATE_CHANGED_ACTION;
    {class} property RSSI_CHANGED_ACTION: JString read _GetRSSI_CHANGED_ACTION;
    {class} property SCAN_RESULTS_AVAILABLE_ACTION: JString read _GetSCAN_RESULTS_AVAILABLE_ACTION;
    {class} property SUPPLICANT_CONNECTION_CHANGE_ACTION: JString read _GetSUPPLICANT_CONNECTION_CHANGE_ACTION;
    {class} property SUPPLICANT_STATE_CHANGED_ACTION: JString read _GetSUPPLICANT_STATE_CHANGED_ACTION;
    {class} property WIFI_MODE_FULL: Integer read _GetWIFI_MODE_FULL;
    {class} property WIFI_MODE_FULL_HIGH_PERF: Integer read _GetWIFI_MODE_FULL_HIGH_PERF;
    {class} property WIFI_MODE_SCAN_ONLY: Integer read _GetWIFI_MODE_SCAN_ONLY;
    {class} property WIFI_STATE_CHANGED_ACTION: JString read _GetWIFI_STATE_CHANGED_ACTION;
    {class} property WIFI_STATE_DISABLED: Integer read _GetWIFI_STATE_DISABLED;
    {class} property WIFI_STATE_DISABLING: Integer read _GetWIFI_STATE_DISABLING;
    {class} property WIFI_STATE_ENABLED: Integer read _GetWIFI_STATE_ENABLED;
    {class} property WIFI_STATE_ENABLING: Integer read _GetWIFI_STATE_ENABLING;
    {class} property WIFI_STATE_UNKNOWN: Integer read _GetWIFI_STATE_UNKNOWN;
    {class} property WPS_AUTH_FAILURE: Integer read _GetWPS_AUTH_FAILURE;
    {class} property WPS_OVERLAP_ERROR: Integer read _GetWPS_OVERLAP_ERROR;
    {class} property WPS_TIMED_OUT: Integer read _GetWPS_TIMED_OUT;
    {class} property WPS_TKIP_ONLY_PROHIBITED: Integer read _GetWPS_TKIP_ONLY_PROHIBITED;
    {class} property WPS_WEP_PROHIBITED: Integer read _GetWPS_WEP_PROHIBITED;
  end;

  [JavaSignature('android/net/wifi/WifiManager')]
  JWifiManager = interface(JObject)
    ['{7411ED93-E0EC-4DBC-979A-5B895346DA34}']
    function addNetwork(config: JWifiConfiguration): Integer; cdecl;
    procedure cancelWps(listener: JWifiManager_WpsCallback); cdecl;
    function createMulticastLock(tag: JString): JWifiManager_MulticastLock; cdecl;
    function createWifiLock(lockType: Integer; tag: JString): JWifiManager_WifiLock; cdecl; overload;
    function createWifiLock(tag: JString): JWifiManager_WifiLock; cdecl; overload;
    function disableNetwork(netId: Integer): Boolean; cdecl;
    function disconnect: Boolean; cdecl;
    function enableNetwork(netId: Integer; disableOthers: Boolean): Boolean; cdecl;
    function getConfiguredNetworks: JList; cdecl;
    function getConnectionInfo: JWifiInfo; cdecl;
    function getDhcpInfo: JDhcpInfo; cdecl;
    function getScanResults: JList; cdecl;
    function getWifiState: Integer; cdecl;
    function is5GHzBandSupported: Boolean; cdecl;
    function isDeviceToApRttSupported: Boolean; cdecl;
    function isEnhancedPowerReportingSupported: Boolean; cdecl;
    function isP2pSupported: Boolean; cdecl;
    function isPreferredNetworkOffloadSupported: Boolean; cdecl;
    function isScanAlwaysAvailable: Boolean; cdecl;
    function isTdlsSupported: Boolean; cdecl;
    function isWifiEnabled: Boolean; cdecl;
    function pingSupplicant: Boolean; cdecl;
    function reassociate: Boolean; cdecl;
    function reconnect: Boolean; cdecl;
    function removeNetwork(netId: Integer): Boolean; cdecl;
    function saveConfiguration: Boolean; cdecl;
    procedure setTdlsEnabled(remoteIPAddress: JInetAddress; enable: Boolean); cdecl;
    procedure setTdlsEnabledWithMacAddress(remoteMacAddress: JString; enable: Boolean); cdecl;
    function setWifiEnabled(enabled: Boolean): Boolean; cdecl;
    function startScan: Boolean; cdecl;
    procedure startWps(config: JWpsInfo; listener: JWifiManager_WpsCallback); cdecl;
    function updateNetwork(config: JWifiConfiguration): Integer; cdecl;
  end;
  TJWifiManager = class(TJavaGenericImport<JWifiManagerClass, JWifiManager>) end;

  JWifiManager_MulticastLockClass = interface(JObjectClass)
    ['{5A3A1B1D-84FB-4E49-8D92-47A2881314CC}']
  end;

  [JavaSignature('android/net/wifi/WifiManager$MulticastLock')]
  JWifiManager_MulticastLock = interface(JObject)
    ['{682F61D0-82D8-484F-8EA8-72BDF4DD7FA9}']
    procedure acquire; cdecl;
    function isHeld: Boolean; cdecl;
    procedure release; cdecl;
    procedure setReferenceCounted(refCounted: Boolean); cdecl;
    function toString: JString; cdecl;
  end;
  TJWifiManager_MulticastLock = class(TJavaGenericImport<JWifiManager_MulticastLockClass, JWifiManager_MulticastLock>) end;

  JWifiManager_WifiLockClass = interface(JObjectClass)
    ['{AE9D4E26-7200-4F0B-A2B7-C0DFA79A4340}']
  end;

  [JavaSignature('android/net/wifi/WifiManager$WifiLock')]
  JWifiManager_WifiLock = interface(JObject)
    ['{43789DF1-6903-4338-A5A6-A6C101944654}']
    procedure acquire; cdecl;
    function isHeld: Boolean; cdecl;
    procedure release; cdecl;
    procedure setReferenceCounted(refCounted: Boolean); cdecl;
    procedure setWorkSource(ws: JWorkSource); cdecl;
    function toString: JString; cdecl;
  end;
  TJWifiManager_WifiLock = class(TJavaGenericImport<JWifiManager_WifiLockClass, JWifiManager_WifiLock>) end;

  JWifiManager_WpsCallbackClass = interface(JObjectClass)
    ['{716B5FDE-D3A4-424E-BDC4-D94C40950BEA}']
    {class} function init: JWifiManager_WpsCallback; cdecl;
  end;

  [JavaSignature('android/net/wifi/WifiManager$WpsCallback')]
  JWifiManager_WpsCallback = interface(JObject)
    ['{977FA6F7-2F9D-4BAF-90C3-38784542235B}']
    procedure onFailed(reason: Integer); cdecl;
    procedure onStarted(pin: JString); cdecl;
    procedure onSucceeded; cdecl;
  end;
  TJWifiManager_WpsCallback = class(TJavaGenericImport<JWifiManager_WpsCallbackClass, JWifiManager_WpsCallback>) end;

  JWpsInfoClass = interface(JObjectClass)
    ['{994C4858-2798-441A-9D35-B111C5EC0932}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetDISPLAY: Integer; cdecl;
    {class} function _GetINVALID: Integer; cdecl;
    {class} function _GetKEYPAD: Integer; cdecl;
    {class} function _GetLABEL: Integer; cdecl;
    {class} function _GetPBC: Integer; cdecl;
    {class} function init: JWpsInfo; cdecl; overload;
    {class} function init(source: JWpsInfo): JWpsInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property DISPLAY: Integer read _GetDISPLAY;
    {class} property INVALID: Integer read _GetINVALID;
    {class} property KEYPAD: Integer read _GetKEYPAD;
    {class} property &LABEL: Integer read _GetLABEL;
    {class} property PBC: Integer read _GetPBC;
  end;

  [JavaSignature('android/net/wifi/WpsInfo')]
  JWpsInfo = interface(JObject)
    ['{41B1A223-EFB9-4FA6-8C56-8153780CBC4B}']
    function _GetBSSID: JString; cdecl;
    procedure _SetBSSID(Value: JString); cdecl;
    function _Getpin: JString; cdecl;
    procedure _Setpin(Value: JString); cdecl;
    function _Getsetup: Integer; cdecl;
    procedure _Setsetup(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property BSSID: JString read _GetBSSID write _SetBSSID;
    property pin: JString read _Getpin write _Setpin;
    property setup: Integer read _Getsetup write _Setsetup;
  end;
  TJWpsInfo = class(TJavaGenericImport<JWpsInfoClass, JWpsInfo>) end;

  JWifiP2pConfigClass = interface(JObjectClass)
    ['{4A30B857-FDFC-4000-9937-04E0B0D2F7F4}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JWifiP2pConfig; cdecl; overload;
    {class} function init(source: JWifiP2pConfig): JWifiP2pConfig; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pConfig')]
  JWifiP2pConfig = interface(JObject)
    ['{CB589540-23B7-4A91-B60D-A7EACC74983F}']
    function _GetdeviceAddress: JString; cdecl;
    procedure _SetdeviceAddress(Value: JString); cdecl;
    function _GetgroupOwnerIntent: Integer; cdecl;
    procedure _SetgroupOwnerIntent(Value: Integer); cdecl;
    function _Getwps: JWpsInfo; cdecl;
    procedure _Setwps(Value: JWpsInfo); cdecl;
    function describeContents: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property deviceAddress: JString read _GetdeviceAddress write _SetdeviceAddress;
    property groupOwnerIntent: Integer read _GetgroupOwnerIntent write _SetgroupOwnerIntent;
    property wps: JWpsInfo read _Getwps write _Setwps;
  end;
  TJWifiP2pConfig = class(TJavaGenericImport<JWifiP2pConfigClass, JWifiP2pConfig>) end;

  JWifiP2pDeviceClass = interface(JObjectClass)
    ['{D419A55A-3668-4DBB-800B-E6BCD534FC72}']
    {class} function _GetAVAILABLE: Integer; cdecl;
    {class} function _GetCONNECTED: Integer; cdecl;
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function _GetFAILED: Integer; cdecl;
    {class} function _GetINVITED: Integer; cdecl;
    {class} function _GetUNAVAILABLE: Integer; cdecl;
    {class} function init: JWifiP2pDevice; cdecl; overload;
    {class} function init(source: JWifiP2pDevice): JWifiP2pDevice; cdecl; overload;
    {class} property AVAILABLE: Integer read _GetAVAILABLE;
    {class} property CONNECTED: Integer read _GetCONNECTED;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
    {class} property FAILED: Integer read _GetFAILED;
    {class} property INVITED: Integer read _GetINVITED;
    {class} property UNAVAILABLE: Integer read _GetUNAVAILABLE;
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pDevice')]
  JWifiP2pDevice = interface(JObject)
    ['{06F8260A-0BD9-4B81-AF3B-4FF3AC9E8DB9}']
    function _GetdeviceAddress: JString; cdecl;
    procedure _SetdeviceAddress(Value: JString); cdecl;
    function _GetdeviceName: JString; cdecl;
    procedure _SetdeviceName(Value: JString); cdecl;
    function _GetprimaryDeviceType: JString; cdecl;
    procedure _SetprimaryDeviceType(Value: JString); cdecl;
    function _GetsecondaryDeviceType: JString; cdecl;
    procedure _SetsecondaryDeviceType(Value: JString); cdecl;
    function _Getstatus: Integer; cdecl;
    procedure _Setstatus(Value: Integer); cdecl;
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function isGroupOwner: Boolean; cdecl;
    function isServiceDiscoveryCapable: Boolean; cdecl;
    function toString: JString; cdecl;
    function wpsDisplaySupported: Boolean; cdecl;
    function wpsKeypadSupported: Boolean; cdecl;
    function wpsPbcSupported: Boolean; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property deviceAddress: JString read _GetdeviceAddress write _SetdeviceAddress;
    property deviceName: JString read _GetdeviceName write _SetdeviceName;
    property primaryDeviceType: JString read _GetprimaryDeviceType write _SetprimaryDeviceType;
    property secondaryDeviceType: JString read _GetsecondaryDeviceType write _SetsecondaryDeviceType;
    property status: Integer read _Getstatus write _Setstatus;
  end;
  TJWifiP2pDevice = class(TJavaGenericImport<JWifiP2pDeviceClass, JWifiP2pDevice>) end;

  JWifiP2pDeviceListClass = interface(JObjectClass)
    ['{8237D0CE-EBAD-45E7-A56C-2B75CEEC7F62}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JWifiP2pDeviceList; cdecl; overload;
    {class} function init(source: JWifiP2pDeviceList): JWifiP2pDeviceList; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pDeviceList')]
  JWifiP2pDeviceList = interface(JObject)
    ['{E42ECFA9-7A11-4722-9466-C0AE0B6D029B}']
    function describeContents: Integer; cdecl;
    function &get(deviceAddress: JString): JWifiP2pDevice; cdecl;
    function getDeviceList: JCollection; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJWifiP2pDeviceList = class(TJavaGenericImport<JWifiP2pDeviceListClass, JWifiP2pDeviceList>) end;

  JWifiP2pGroupClass = interface(JObjectClass)
    ['{FBFBF497-23D1-4C59-8330-F6CE4F11D213}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JWifiP2pGroup; cdecl; overload;
    {class} function init(source: JWifiP2pGroup): JWifiP2pGroup; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pGroup')]
  JWifiP2pGroup = interface(JObject)
    ['{5DCCFEDD-4EE6-45C6-B385-C7C1DE690FDB}']
    function describeContents: Integer; cdecl;
    function getClientList: JCollection; cdecl;
    function getInterface: JString; cdecl;
    function getNetworkName: JString; cdecl;
    function getOwner: JWifiP2pDevice; cdecl;
    function getPassphrase: JString; cdecl;
    function isGroupOwner: Boolean; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJWifiP2pGroup = class(TJavaGenericImport<JWifiP2pGroupClass, JWifiP2pGroup>) end;

  JWifiP2pInfoClass = interface(JObjectClass)
    ['{50C3454D-B3BF-4A59-8702-B14F497E9855}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init: JWifiP2pInfo; cdecl; overload;
    {class} function init(source: JWifiP2pInfo): JWifiP2pInfo; cdecl; overload;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pInfo')]
  JWifiP2pInfo = interface(JObject)
    ['{354CD0A4-C949-472F-B47D-34D503AC96EA}']
    function _GetgroupFormed: Boolean; cdecl;
    procedure _SetgroupFormed(Value: Boolean); cdecl;
    function _GetgroupOwnerAddress: JInetAddress; cdecl;
    procedure _SetgroupOwnerAddress(Value: JInetAddress); cdecl;
    function _GetisGroupOwner: Boolean; cdecl;
    procedure _SetisGroupOwner(Value: Boolean); cdecl;
    function describeContents: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
    property groupFormed: Boolean read _GetgroupFormed write _SetgroupFormed;
    property groupOwnerAddress: JInetAddress read _GetgroupOwnerAddress write _SetgroupOwnerAddress;
    property isGroupOwner: Boolean read _GetisGroupOwner write _SetisGroupOwner;
  end;
  TJWifiP2pInfo = class(TJavaGenericImport<JWifiP2pInfoClass, JWifiP2pInfo>) end;

  JWifiP2pManagerClass = interface(JObjectClass)
    ['{5CFA2312-7CE2-43C5-9171-E5095050F14C}']
    {class} function _GetBUSY: Integer; cdecl;
    {class} function _GetERROR: Integer; cdecl;
    {class} function _GetEXTRA_DISCOVERY_STATE: JString; cdecl;
    {class} function _GetEXTRA_NETWORK_INFO: JString; cdecl;
    {class} function _GetEXTRA_P2P_DEVICE_LIST: JString; cdecl;
    {class} function _GetEXTRA_WIFI_P2P_DEVICE: JString; cdecl;
    {class} function _GetEXTRA_WIFI_P2P_GROUP: JString; cdecl;
    {class} function _GetEXTRA_WIFI_P2P_INFO: JString; cdecl;
    {class} function _GetEXTRA_WIFI_STATE: JString; cdecl;
    {class} function _GetNO_SERVICE_REQUESTS: Integer; cdecl;
    {class} function _GetP2P_UNSUPPORTED: Integer; cdecl;
    {class} function _GetWIFI_P2P_CONNECTION_CHANGED_ACTION: JString; cdecl;
    {class} function _GetWIFI_P2P_DISCOVERY_CHANGED_ACTION: JString; cdecl;
    {class} function _GetWIFI_P2P_DISCOVERY_STARTED: Integer; cdecl;
    {class} function _GetWIFI_P2P_DISCOVERY_STOPPED: Integer; cdecl;
    {class} function _GetWIFI_P2P_PEERS_CHANGED_ACTION: JString; cdecl;
    {class} function _GetWIFI_P2P_STATE_CHANGED_ACTION: JString; cdecl;
    {class} function _GetWIFI_P2P_STATE_DISABLED: Integer; cdecl;
    {class} function _GetWIFI_P2P_STATE_ENABLED: Integer; cdecl;
    {class} function _GetWIFI_P2P_THIS_DEVICE_CHANGED_ACTION: JString; cdecl;
    {class} property BUSY: Integer read _GetBUSY;
    {class} property ERROR: Integer read _GetERROR;
    {class} property EXTRA_DISCOVERY_STATE: JString read _GetEXTRA_DISCOVERY_STATE;
    {class} property EXTRA_NETWORK_INFO: JString read _GetEXTRA_NETWORK_INFO;
    {class} property EXTRA_P2P_DEVICE_LIST: JString read _GetEXTRA_P2P_DEVICE_LIST;
    {class} property EXTRA_WIFI_P2P_DEVICE: JString read _GetEXTRA_WIFI_P2P_DEVICE;
    {class} property EXTRA_WIFI_P2P_GROUP: JString read _GetEXTRA_WIFI_P2P_GROUP;
    {class} property EXTRA_WIFI_P2P_INFO: JString read _GetEXTRA_WIFI_P2P_INFO;
    {class} property EXTRA_WIFI_STATE: JString read _GetEXTRA_WIFI_STATE;
    {class} property NO_SERVICE_REQUESTS: Integer read _GetNO_SERVICE_REQUESTS;
    {class} property P2P_UNSUPPORTED: Integer read _GetP2P_UNSUPPORTED;
    {class} property WIFI_P2P_CONNECTION_CHANGED_ACTION: JString read _GetWIFI_P2P_CONNECTION_CHANGED_ACTION;
    {class} property WIFI_P2P_DISCOVERY_CHANGED_ACTION: JString read _GetWIFI_P2P_DISCOVERY_CHANGED_ACTION;
    {class} property WIFI_P2P_DISCOVERY_STARTED: Integer read _GetWIFI_P2P_DISCOVERY_STARTED;
    {class} property WIFI_P2P_DISCOVERY_STOPPED: Integer read _GetWIFI_P2P_DISCOVERY_STOPPED;
    {class} property WIFI_P2P_PEERS_CHANGED_ACTION: JString read _GetWIFI_P2P_PEERS_CHANGED_ACTION;
    {class} property WIFI_P2P_STATE_CHANGED_ACTION: JString read _GetWIFI_P2P_STATE_CHANGED_ACTION;
    {class} property WIFI_P2P_STATE_DISABLED: Integer read _GetWIFI_P2P_STATE_DISABLED;
    {class} property WIFI_P2P_STATE_ENABLED: Integer read _GetWIFI_P2P_STATE_ENABLED;
    {class} property WIFI_P2P_THIS_DEVICE_CHANGED_ACTION: JString read _GetWIFI_P2P_THIS_DEVICE_CHANGED_ACTION;
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pManager')]
  JWifiP2pManager = interface(JObject)
    ['{BBB52E97-1661-4589-9567-CE7C9CE6A659}']
    procedure addLocalService(c: JWifiP2pManager_Channel; servInfo: JWifiP2pServiceInfo; listener: JWifiP2pManager_ActionListener); cdecl;
    procedure addServiceRequest(c: JWifiP2pManager_Channel; req: JWifiP2pServiceRequest; listener: JWifiP2pManager_ActionListener); cdecl;
    procedure cancelConnect(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_ActionListener); cdecl;
    procedure clearLocalServices(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_ActionListener); cdecl;
    procedure clearServiceRequests(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_ActionListener); cdecl;
    procedure connect(c: JWifiP2pManager_Channel; config: JWifiP2pConfig; listener: JWifiP2pManager_ActionListener); cdecl;
    procedure createGroup(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_ActionListener); cdecl;
    procedure discoverPeers(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_ActionListener); cdecl;
    procedure discoverServices(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_ActionListener); cdecl;
    //function initialize(srcContext: JContext; srcLooper: JLooper; listener: JWifiP2pManager_ChannelListener): JWifiP2pManager_Channel; cdecl;
    procedure removeGroup(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_ActionListener); cdecl;
    procedure removeLocalService(c: JWifiP2pManager_Channel; servInfo: JWifiP2pServiceInfo; listener: JWifiP2pManager_ActionListener); cdecl;
    procedure removeServiceRequest(c: JWifiP2pManager_Channel; req: JWifiP2pServiceRequest; listener: JWifiP2pManager_ActionListener); cdecl;
    procedure requestConnectionInfo(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_ConnectionInfoListener); cdecl;
    procedure requestGroupInfo(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_GroupInfoListener); cdecl;
    procedure requestPeers(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_PeerListListener); cdecl;
    procedure setDnsSdResponseListeners(c: JWifiP2pManager_Channel; servListener: JWifiP2pManager_DnsSdServiceResponseListener; txtListener: JWifiP2pManager_DnsSdTxtRecordListener); cdecl;
    procedure setServiceResponseListener(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_ServiceResponseListener); cdecl;
    procedure setUpnpServiceResponseListener(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_UpnpServiceResponseListener); cdecl;
    procedure stopPeerDiscovery(c: JWifiP2pManager_Channel; listener: JWifiP2pManager_ActionListener); cdecl;
  end;
  TJWifiP2pManager = class(TJavaGenericImport<JWifiP2pManagerClass, JWifiP2pManager>) end;

  JWifiP2pManager_ActionListenerClass = interface(IJavaClass)
    ['{3AD00615-4939-47A4-B581-5DE0C6F47538}']
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pManager$ActionListener')]
  JWifiP2pManager_ActionListener = interface(IJavaInstance)
    ['{B8864602-8BF3-40CE-8266-9697ED1A15A8}']
    procedure onFailure(reason: Integer); cdecl;
    procedure onSuccess; cdecl;
  end;
  TJWifiP2pManager_ActionListener = class(TJavaGenericImport<JWifiP2pManager_ActionListenerClass, JWifiP2pManager_ActionListener>) end;

  JWifiP2pManager_ChannelClass = interface(JObjectClass)
    ['{64B53A0B-FC52-44F2-83EB-00A6295BD465}']
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pManager$Channel')]
  JWifiP2pManager_Channel = interface(JObject)
    ['{7B2371D8-425F-4749-A48A-2726F8DA17F9}']
  end;
  TJWifiP2pManager_Channel = class(TJavaGenericImport<JWifiP2pManager_ChannelClass, JWifiP2pManager_Channel>) end;

  JWifiP2pManager_ChannelListenerClass = interface(IJavaClass)
    ['{26D04B51-E7B1-47E7-ACE5-B05CA7FBC538}']
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pManager$ChannelListener')]
  JWifiP2pManager_ChannelListener = interface(IJavaInstance)
    ['{9CA87220-9212-465A-92E4-020256D1451C}']
    procedure onChannelDisconnected; cdecl;
  end;
  TJWifiP2pManager_ChannelListener = class(TJavaGenericImport<JWifiP2pManager_ChannelListenerClass, JWifiP2pManager_ChannelListener>) end;

  JWifiP2pManager_ConnectionInfoListenerClass = interface(IJavaClass)
    ['{D5B27DFE-BBB6-4E6C-BA65-2A989D55C48E}']
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pManager$ConnectionInfoListener')]
  JWifiP2pManager_ConnectionInfoListener = interface(IJavaInstance)
    ['{4F55CE0F-3E51-40F8-9F4E-5F550128AC9D}']
    procedure onConnectionInfoAvailable(info: JWifiP2pInfo); cdecl;
  end;
  TJWifiP2pManager_ConnectionInfoListener = class(TJavaGenericImport<JWifiP2pManager_ConnectionInfoListenerClass, JWifiP2pManager_ConnectionInfoListener>) end;

  JWifiP2pManager_DnsSdServiceResponseListenerClass = interface(IJavaClass)
    ['{DF15DDED-A4F6-48C9-B10B-528A2E9E45FC}']
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pManager$DnsSdServiceResponseListener')]
  JWifiP2pManager_DnsSdServiceResponseListener = interface(IJavaInstance)
    ['{77AE336C-B73B-4A83-B292-BD854F84E10D}']
    procedure onDnsSdServiceAvailable(instanceName: JString; registrationType: JString; srcDevice: JWifiP2pDevice); cdecl;
  end;
  TJWifiP2pManager_DnsSdServiceResponseListener = class(TJavaGenericImport<JWifiP2pManager_DnsSdServiceResponseListenerClass, JWifiP2pManager_DnsSdServiceResponseListener>) end;

  JWifiP2pManager_DnsSdTxtRecordListenerClass = interface(IJavaClass)
    ['{3571DE02-6E77-4298-BDFF-067A51D8B0FC}']
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pManager$DnsSdTxtRecordListener')]
  JWifiP2pManager_DnsSdTxtRecordListener = interface(IJavaInstance)
    ['{9F272607-82A1-4091-8838-31CD35F978D5}']
    procedure onDnsSdTxtRecordAvailable(fullDomainName: JString; txtRecordMap: JMap; srcDevice: JWifiP2pDevice); cdecl;
  end;
  TJWifiP2pManager_DnsSdTxtRecordListener = class(TJavaGenericImport<JWifiP2pManager_DnsSdTxtRecordListenerClass, JWifiP2pManager_DnsSdTxtRecordListener>) end;

  JWifiP2pManager_GroupInfoListenerClass = interface(IJavaClass)
    ['{29EC2167-C496-4C80-A422-F84B971F3DAA}']
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pManager$GroupInfoListener')]
  JWifiP2pManager_GroupInfoListener = interface(IJavaInstance)
    ['{AE493F09-9C2C-4722-8D9A-4EE41EBC6207}']
    procedure onGroupInfoAvailable(group: JWifiP2pGroup); cdecl;
  end;
  TJWifiP2pManager_GroupInfoListener = class(TJavaGenericImport<JWifiP2pManager_GroupInfoListenerClass, JWifiP2pManager_GroupInfoListener>) end;

  JWifiP2pManager_PeerListListenerClass = interface(IJavaClass)
    ['{8E6C4B5B-BF16-4B48-89AF-13FD643C59CA}']
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pManager$PeerListListener')]
  JWifiP2pManager_PeerListListener = interface(IJavaInstance)
    ['{EA3E1199-816E-4282-A416-63A503F53C51}']
    procedure onPeersAvailable(peers: JWifiP2pDeviceList); cdecl;
  end;
  TJWifiP2pManager_PeerListListener = class(TJavaGenericImport<JWifiP2pManager_PeerListListenerClass, JWifiP2pManager_PeerListListener>) end;

  JWifiP2pManager_ServiceResponseListenerClass = interface(IJavaClass)
    ['{A29A52CF-7E70-4B10-B93B-C46276009C23}']
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pManager$ServiceResponseListener')]
  JWifiP2pManager_ServiceResponseListener = interface(IJavaInstance)
    ['{04BB3063-ADCD-40B7-A1DF-BEC996191CF5}']
    procedure onServiceAvailable(protocolType: Integer; responseData: TJavaArray<Byte>; srcDevice: JWifiP2pDevice); cdecl;
  end;
  TJWifiP2pManager_ServiceResponseListener = class(TJavaGenericImport<JWifiP2pManager_ServiceResponseListenerClass, JWifiP2pManager_ServiceResponseListener>) end;

  JWifiP2pManager_UpnpServiceResponseListenerClass = interface(IJavaClass)
    ['{3D411E85-C979-485B-AD2D-5897CFE85888}']
  end;

  [JavaSignature('android/net/wifi/p2p/WifiP2pManager$UpnpServiceResponseListener')]
  JWifiP2pManager_UpnpServiceResponseListener = interface(IJavaInstance)
    ['{F393404C-A30A-4DC0-BF13-A72914318B52}']
    procedure onUpnpServiceAvailable(uniqueServiceNames: JList; srcDevice: JWifiP2pDevice); cdecl;
  end;
  TJWifiP2pManager_UpnpServiceResponseListener = class(TJavaGenericImport<JWifiP2pManager_UpnpServiceResponseListenerClass, JWifiP2pManager_UpnpServiceResponseListener>) end;

  JWifiP2pServiceInfoClass = interface(JObjectClass)
    ['{4B80F940-17A7-4465-91AF-55DBC7ABAC07}']
    {class} function _GetSERVICE_TYPE_ALL: Integer; cdecl;
    {class} function _GetSERVICE_TYPE_BONJOUR: Integer; cdecl;
    {class} function _GetSERVICE_TYPE_UPNP: Integer; cdecl;
    {class} function _GetSERVICE_TYPE_VENDOR_SPECIFIC: Integer; cdecl;
    {class} property SERVICE_TYPE_ALL: Integer read _GetSERVICE_TYPE_ALL;
    {class} property SERVICE_TYPE_BONJOUR: Integer read _GetSERVICE_TYPE_BONJOUR;
    {class} property SERVICE_TYPE_UPNP: Integer read _GetSERVICE_TYPE_UPNP;
    {class} property SERVICE_TYPE_VENDOR_SPECIFIC: Integer read _GetSERVICE_TYPE_VENDOR_SPECIFIC;
  end;

  [JavaSignature('android/net/wifi/p2p/nsd/WifiP2pServiceInfo')]
  JWifiP2pServiceInfo = interface(JObject)
    ['{B6A5469F-3DC7-433C-B9A6-606E02D8AB45}']
    function equals(o: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
  end;
  TJWifiP2pServiceInfo = class(TJavaGenericImport<JWifiP2pServiceInfoClass, JWifiP2pServiceInfo>) end;

  JWifiP2pDnsSdServiceInfoClass = interface(JWifiP2pServiceInfoClass)
    ['{2A2827FF-7B46-422F-8724-43BC73C3F2CC}']
    {class} function newInstance(instanceName: JString; serviceType: JString; txtMap: JMap): JWifiP2pDnsSdServiceInfo; cdecl;
  end;

  [JavaSignature('android/net/wifi/p2p/nsd/WifiP2pDnsSdServiceInfo')]
  JWifiP2pDnsSdServiceInfo = interface(JWifiP2pServiceInfo)
    ['{D45C7279-6F15-461A-B3BF-9117D962DFA3}']
  end;
  TJWifiP2pDnsSdServiceInfo = class(TJavaGenericImport<JWifiP2pDnsSdServiceInfoClass, JWifiP2pDnsSdServiceInfo>) end;

  JWifiP2pServiceRequestClass = interface(JObjectClass)
    ['{414BAED5-AF35-4585-BE98-1D7196128792}']
    {class} function newInstance(protocolType: Integer; queryData: JString): JWifiP2pServiceRequest; cdecl; overload;
    {class} function newInstance(protocolType: Integer): JWifiP2pServiceRequest; cdecl; overload;
  end;

  [JavaSignature('android/net/wifi/p2p/nsd/WifiP2pServiceRequest')]
  JWifiP2pServiceRequest = interface(JObject)
    ['{46EC5CA0-626B-45C7-A383-6B5E2B87DCE2}']
    function equals(o: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
  end;
  TJWifiP2pServiceRequest = class(TJavaGenericImport<JWifiP2pServiceRequestClass, JWifiP2pServiceRequest>) end;

  JWifiP2pDnsSdServiceRequestClass = interface(JWifiP2pServiceRequestClass)
    ['{653F2652-7FAE-495C-8642-A5716FD93CD7}']
    {class} function newInstance: JWifiP2pDnsSdServiceRequest; cdecl; overload;
    {class} function newInstance(serviceType: JString): JWifiP2pDnsSdServiceRequest; cdecl; overload;
    {class} function newInstance(instanceName: JString; serviceType: JString): JWifiP2pDnsSdServiceRequest; cdecl; overload;
  end;

  [JavaSignature('android/net/wifi/p2p/nsd/WifiP2pDnsSdServiceRequest')]
  JWifiP2pDnsSdServiceRequest = interface(JWifiP2pServiceRequest)
    ['{0512A2E8-9545-41C3-8E6A-906C67AF2B21}']
  end;
  TJWifiP2pDnsSdServiceRequest = class(TJavaGenericImport<JWifiP2pDnsSdServiceRequestClass, JWifiP2pDnsSdServiceRequest>) end;

  JWifiP2pUpnpServiceInfoClass = interface(JWifiP2pServiceInfoClass)
    ['{C28ED2C4-0436-4EF5-82F2-306A35B0A0AE}']
    {class} function newInstance(uuid: JString; device: JString; services: JList): JWifiP2pUpnpServiceInfo; cdecl;
  end;

  [JavaSignature('android/net/wifi/p2p/nsd/WifiP2pUpnpServiceInfo')]
  JWifiP2pUpnpServiceInfo = interface(JWifiP2pServiceInfo)
    ['{2A62D732-7ED7-4A5F-8423-BD92091D384B}']
  end;
  TJWifiP2pUpnpServiceInfo = class(TJavaGenericImport<JWifiP2pUpnpServiceInfoClass, JWifiP2pUpnpServiceInfo>) end;

  JWifiP2pUpnpServiceRequestClass = interface(JWifiP2pServiceRequestClass)
    ['{52AAD8A3-3D84-4A6A-B8D3-19C33C9ADEBC}']
    {class} function newInstance: JWifiP2pUpnpServiceRequest; cdecl; overload;
    {class} function newInstance(st: JString): JWifiP2pUpnpServiceRequest; cdecl; overload;
  end;

  [JavaSignature('android/net/wifi/p2p/nsd/WifiP2pUpnpServiceRequest')]
  JWifiP2pUpnpServiceRequest = interface(JWifiP2pServiceRequest)
    ['{F884C7CB-175F-46B2-B9FD-E0336737535C}']
  end;
  TJWifiP2pUpnpServiceRequest = class(TJavaGenericImport<JWifiP2pUpnpServiceRequestClass, JWifiP2pUpnpServiceRequest>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Net.JCaptivePortal', TypeInfo(Androidapi.JNI.Net.JCaptivePortal));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JConnectivityManager', TypeInfo(Androidapi.JNI.Net.JConnectivityManager));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JConnectivityManager_NetworkCallback', TypeInfo(Androidapi.JNI.Net.JConnectivityManager_NetworkCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JConnectivityManager_OnNetworkActiveListener', TypeInfo(Androidapi.JNI.Net.JConnectivityManager_OnNetworkActiveListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Jnet_Credentials', TypeInfo(Androidapi.JNI.Net.Jnet_Credentials));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JDhcpInfo', TypeInfo(Androidapi.JNI.Net.JDhcpInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JIpPrefix', TypeInfo(Androidapi.JNI.Net.JIpPrefix));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JLinkAddress', TypeInfo(Androidapi.JNI.Net.JLinkAddress));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JLinkProperties', TypeInfo(Androidapi.JNI.Net.JLinkProperties));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JLocalServerSocket', TypeInfo(Androidapi.JNI.Net.JLocalServerSocket));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JLocalSocket', TypeInfo(Androidapi.JNI.Net.JLocalSocket));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JLocalSocketAddress', TypeInfo(Androidapi.JNI.Net.JLocalSocketAddress));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JLocalSocketAddress_Namespace', TypeInfo(Androidapi.JNI.Net.JLocalSocketAddress_Namespace));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JMailTo', TypeInfo(Androidapi.JNI.Net.JMailTo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNetwork', TypeInfo(Androidapi.JNI.Net.JNetwork));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNetworkCapabilities', TypeInfo(Androidapi.JNI.Net.JNetworkCapabilities));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNetworkInfo', TypeInfo(Androidapi.JNI.Net.JNetworkInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNetworkInfo_DetailedState', TypeInfo(Androidapi.JNI.Net.JNetworkInfo_DetailedState));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNetworkInfo_State', TypeInfo(Androidapi.JNI.Net.JNetworkInfo_State));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNetworkRequest', TypeInfo(Androidapi.JNI.Net.JNetworkRequest));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNetworkRequest_Builder', TypeInfo(Androidapi.JNI.Net.JNetworkRequest_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Jnet_ParseException', TypeInfo(Androidapi.JNI.Net.Jnet_ParseException));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Jnet_Proxy', TypeInfo(Androidapi.JNI.Net.Jnet_Proxy));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JProxyInfo', TypeInfo(Androidapi.JNI.Net.JProxyInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JPskKeyManager', TypeInfo(Androidapi.JNI.Net.JPskKeyManager));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Jnet_RouteInfo', TypeInfo(Androidapi.JNI.Net.Jnet_RouteInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSSLCertificateSocketFactory', TypeInfo(Androidapi.JNI.Net.JSSLCertificateSocketFactory));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSSLSessionCache', TypeInfo(Androidapi.JNI.Net.JSSLSessionCache));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JTrafficStats', TypeInfo(Androidapi.JNI.Net.JTrafficStats));
  TRegTypes.RegisterType('Androidapi.JNI.Net.Jnet_Uri', TypeInfo(Androidapi.JNI.Net.Jnet_Uri));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JUri_Builder', TypeInfo(Androidapi.JNI.Net.JUri_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JUrlQuerySanitizer', TypeInfo(Androidapi.JNI.Net.JUrlQuerySanitizer));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JUrlQuerySanitizer_IllegalCharacterValueSanitizer', TypeInfo(Androidapi.JNI.Net.JUrlQuerySanitizer_IllegalCharacterValueSanitizer));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JUrlQuerySanitizer_ParameterValuePair', TypeInfo(Androidapi.JNI.Net.JUrlQuerySanitizer_ParameterValuePair));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JUrlQuerySanitizer_ValueSanitizer', TypeInfo(Androidapi.JNI.Net.JUrlQuerySanitizer_ValueSanitizer));
  //TRegTypes.RegisterType('Androidapi.JNI.Net.JVpnService', TypeInfo(Androidapi.JNI.Net.JVpnService));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JVpnService_Builder', TypeInfo(Androidapi.JNI.Net.JVpnService_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JHttpResponseCache', TypeInfo(Androidapi.JNI.Net.JHttpResponseCache));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSslCertificate', TypeInfo(Androidapi.JNI.Net.JSslCertificate));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSslCertificate_DName', TypeInfo(Androidapi.JNI.Net.JSslCertificate_DName));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSslError', TypeInfo(Androidapi.JNI.Net.JSslError));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JX509TrustManagerExtensions', TypeInfo(Androidapi.JNI.Net.JX509TrustManagerExtensions));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNsdManager', TypeInfo(Androidapi.JNI.Net.JNsdManager));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNsdManager_DiscoveryListener', TypeInfo(Androidapi.JNI.Net.JNsdManager_DiscoveryListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNsdManager_RegistrationListener', TypeInfo(Androidapi.JNI.Net.JNsdManager_RegistrationListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNsdManager_ResolveListener', TypeInfo(Androidapi.JNI.Net.JNsdManager_ResolveListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JNsdServiceInfo', TypeInfo(Androidapi.JNI.Net.JNsdServiceInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JAudioCodec', TypeInfo(Androidapi.JNI.Net.JAudioCodec));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JAudioGroup', TypeInfo(Androidapi.JNI.Net.JAudioGroup));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JRtpStream', TypeInfo(Androidapi.JNI.Net.JRtpStream));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JAudioStream', TypeInfo(Androidapi.JNI.Net.JAudioStream));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSipAudioCall', TypeInfo(Androidapi.JNI.Net.JSipAudioCall));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSipAudioCall_Listener', TypeInfo(Androidapi.JNI.Net.JSipAudioCall_Listener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSipErrorCode', TypeInfo(Androidapi.JNI.Net.JSipErrorCode));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSipException', TypeInfo(Androidapi.JNI.Net.JSipException));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSipManager', TypeInfo(Androidapi.JNI.Net.JSipManager));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSipProfile', TypeInfo(Androidapi.JNI.Net.JSipProfile));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSipProfile_Builder', TypeInfo(Androidapi.JNI.Net.JSipProfile_Builder));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSipRegistrationListener', TypeInfo(Androidapi.JNI.Net.JSipRegistrationListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSipSession', TypeInfo(Androidapi.JNI.Net.JSipSession));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSipSession_Listener', TypeInfo(Androidapi.JNI.Net.JSipSession_Listener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSipSession_State', TypeInfo(Androidapi.JNI.Net.JSipSession_State));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JScanResult', TypeInfo(Androidapi.JNI.Net.JScanResult));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JSupplicantState', TypeInfo(Androidapi.JNI.Net.JSupplicantState));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiConfiguration', TypeInfo(Androidapi.JNI.Net.JWifiConfiguration));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiConfiguration_AuthAlgorithm', TypeInfo(Androidapi.JNI.Net.JWifiConfiguration_AuthAlgorithm));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiConfiguration_GroupCipher', TypeInfo(Androidapi.JNI.Net.JWifiConfiguration_GroupCipher));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiConfiguration_KeyMgmt', TypeInfo(Androidapi.JNI.Net.JWifiConfiguration_KeyMgmt));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiConfiguration_PairwiseCipher', TypeInfo(Androidapi.JNI.Net.JWifiConfiguration_PairwiseCipher));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiConfiguration_Protocol', TypeInfo(Androidapi.JNI.Net.JWifiConfiguration_Protocol));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiConfiguration_Status', TypeInfo(Androidapi.JNI.Net.JWifiConfiguration_Status));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiEnterpriseConfig', TypeInfo(Androidapi.JNI.Net.JWifiEnterpriseConfig));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiEnterpriseConfig_Eap', TypeInfo(Androidapi.JNI.Net.JWifiEnterpriseConfig_Eap));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiEnterpriseConfig_Phase2', TypeInfo(Androidapi.JNI.Net.JWifiEnterpriseConfig_Phase2));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiInfo', TypeInfo(Androidapi.JNI.Net.JWifiInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiManager', TypeInfo(Androidapi.JNI.Net.JWifiManager));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiManager_MulticastLock', TypeInfo(Androidapi.JNI.Net.JWifiManager_MulticastLock));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiManager_WifiLock', TypeInfo(Androidapi.JNI.Net.JWifiManager_WifiLock));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiManager_WpsCallback', TypeInfo(Androidapi.JNI.Net.JWifiManager_WpsCallback));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWpsInfo', TypeInfo(Androidapi.JNI.Net.JWpsInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pConfig', TypeInfo(Androidapi.JNI.Net.JWifiP2pConfig));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pDevice', TypeInfo(Androidapi.JNI.Net.JWifiP2pDevice));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pDeviceList', TypeInfo(Androidapi.JNI.Net.JWifiP2pDeviceList));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pGroup', TypeInfo(Androidapi.JNI.Net.JWifiP2pGroup));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pInfo', TypeInfo(Androidapi.JNI.Net.JWifiP2pInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pManager', TypeInfo(Androidapi.JNI.Net.JWifiP2pManager));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pManager_ActionListener', TypeInfo(Androidapi.JNI.Net.JWifiP2pManager_ActionListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pManager_Channel', TypeInfo(Androidapi.JNI.Net.JWifiP2pManager_Channel));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pManager_ChannelListener', TypeInfo(Androidapi.JNI.Net.JWifiP2pManager_ChannelListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pManager_ConnectionInfoListener', TypeInfo(Androidapi.JNI.Net.JWifiP2pManager_ConnectionInfoListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pManager_DnsSdServiceResponseListener', TypeInfo(Androidapi.JNI.Net.JWifiP2pManager_DnsSdServiceResponseListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pManager_DnsSdTxtRecordListener', TypeInfo(Androidapi.JNI.Net.JWifiP2pManager_DnsSdTxtRecordListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pManager_GroupInfoListener', TypeInfo(Androidapi.JNI.Net.JWifiP2pManager_GroupInfoListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pManager_PeerListListener', TypeInfo(Androidapi.JNI.Net.JWifiP2pManager_PeerListListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pManager_ServiceResponseListener', TypeInfo(Androidapi.JNI.Net.JWifiP2pManager_ServiceResponseListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pManager_UpnpServiceResponseListener', TypeInfo(Androidapi.JNI.Net.JWifiP2pManager_UpnpServiceResponseListener));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pServiceInfo', TypeInfo(Androidapi.JNI.Net.JWifiP2pServiceInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pDnsSdServiceInfo', TypeInfo(Androidapi.JNI.Net.JWifiP2pDnsSdServiceInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pServiceRequest', TypeInfo(Androidapi.JNI.Net.JWifiP2pServiceRequest));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pDnsSdServiceRequest', TypeInfo(Androidapi.JNI.Net.JWifiP2pDnsSdServiceRequest));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pUpnpServiceInfo', TypeInfo(Androidapi.JNI.Net.JWifiP2pUpnpServiceInfo));
  TRegTypes.RegisterType('Androidapi.JNI.Net.JWifiP2pUpnpServiceRequest', TypeInfo(Androidapi.JNI.Net.JWifiP2pUpnpServiceRequest));
end;

initialization
  RegisterTypes;
end.


