{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.Java.Net;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.Java.Security,
  Androidapi.JNI.JavaTypes;

type
// ===== Forward declarations =====

  JCacheRequest = interface;//java.net.CacheRequest
  JCacheResponse = interface;//java.net.CacheResponse
  Jnet_ContentHandler = interface;//java.net.ContentHandler
  JContentHandlerFactory = interface;//java.net.ContentHandlerFactory
  JDatagramPacket = interface;//java.net.DatagramPacket
  JDatagramSocket = interface;//java.net.DatagramSocket
  JDatagramSocketImpl = interface;//java.net.DatagramSocketImpl
  JDatagramSocketImplFactory = interface;//java.net.DatagramSocketImplFactory
  JFileNameMap = interface;//java.net.FileNameMap
  JURLConnection = interface;//java.net.URLConnection
  JHttpURLConnection = interface;//java.net.HttpURLConnection
  JInetAddress = interface;//java.net.InetAddress
  JInet4Address = interface;//java.net.Inet4Address
  JInet6Address = interface;//java.net.Inet6Address
  JSocketAddress = interface;//java.net.SocketAddress
  JInetSocketAddress = interface;//java.net.InetSocketAddress
  JNetworkInterface = interface;//java.net.NetworkInterface
  JProxy = interface;//java.net.Proxy
  JProxy_Type = interface;//java.net.Proxy$Type
  JResponseCache = interface;//java.net.ResponseCache
  JServerSocket = interface;//java.net.ServerSocket
  JSocket = interface;//java.net.Socket
  JSocketImpl = interface;//java.net.SocketImpl
  JSocketImplFactory = interface;//java.net.SocketImplFactory
  JURI = interface;//java.net.URI
  JURL = interface;//java.net.URL
  JURLStreamHandler = interface;//java.net.URLStreamHandler
  JURLStreamHandlerFactory = interface;//java.net.URLStreamHandlerFactory
  JServerSocketFactory = interface;//javax.net.ServerSocketFactory
  Jnet_SocketFactory = interface;//javax.net.SocketFactory
  JHostnameVerifier = interface;//javax.net.ssl.HostnameVerifier
  JHttpsURLConnection = interface;//javax.net.ssl.HttpsURLConnection
  JKeyManager = interface;//javax.net.ssl.KeyManager
  JKeyManagerFactory = interface;//javax.net.ssl.KeyManagerFactory
  JManagerFactoryParameters = interface;//javax.net.ssl.ManagerFactoryParameters
  JSSLContext = interface;//javax.net.ssl.SSLContext
  JSSLEngine = interface;//javax.net.ssl.SSLEngine
  JSSLEngineResult = interface;//javax.net.ssl.SSLEngineResult
  JSSLEngineResult_HandshakeStatus = interface;//javax.net.ssl.SSLEngineResult$HandshakeStatus
  JSSLEngineResult_Status = interface;//javax.net.ssl.SSLEngineResult$Status
  JSSLParameters = interface;//javax.net.ssl.SSLParameters
  JSSLServerSocketFactory = interface;//javax.net.ssl.SSLServerSocketFactory
  JSSLSession = interface;//javax.net.ssl.SSLSession
  JSSLSessionContext = interface;//javax.net.ssl.SSLSessionContext
  Jssl_SSLSocketFactory = interface;//javax.net.ssl.SSLSocketFactory
  JTrustManager = interface;//javax.net.ssl.TrustManager
  JTrustManagerFactory = interface;//javax.net.ssl.TrustManagerFactory
  JX509KeyManager = interface;//javax.net.ssl.X509KeyManager
  JX509TrustManager = interface;//javax.net.ssl.X509TrustManager

// ===== Interface declarations =====

  JCacheRequestClass = interface(JObjectClass)
    ['{D36EC641-6B9D-46D0-B123-5EA7BE16D112}']
    {class} function init: JCacheRequest; cdecl;
  end;

  [JavaSignature('java/net/CacheRequest')]
  JCacheRequest = interface(JObject)
    ['{CF398AA9-E113-42FB-9F46-F383FAAADB4B}']
    procedure abort; cdecl;
    function getBody: JOutputStream; cdecl;
  end;
  TJCacheRequest = class(TJavaGenericImport<JCacheRequestClass, JCacheRequest>) end;

  JCacheResponseClass = interface(JObjectClass)
    ['{E685129F-73FD-4DEE-AB8A-B7835E8F8328}']
    {class} function init: JCacheResponse; cdecl;
  end;

  [JavaSignature('java/net/CacheResponse')]
  JCacheResponse = interface(JObject)
    ['{92BF69EB-CECF-4AFC-9389-4CAE451B41ED}']
    function getBody: JInputStream; cdecl;
    function getHeaders: JMap; cdecl;
  end;
  TJCacheResponse = class(TJavaGenericImport<JCacheResponseClass, JCacheResponse>) end;

  Jnet_ContentHandlerClass = interface(JObjectClass)
    ['{BC2D6F56-52C9-43EC-94BA-CE531E710CDD}']
    {class} function init: Jnet_ContentHandler; cdecl;
  end;

  [JavaSignature('java/net/ContentHandler')]
  Jnet_ContentHandler = interface(JObject)
    ['{2DB56D97-EA55-4AF4-8891-3FA76F459DAF}']
    function getContent(uConn: JURLConnection): JObject; cdecl; overload;
    function getContent(uConn: JURLConnection; types: TJavaObjectArray<Jlang_Class>): JObject; cdecl; overload;
  end;
  TJnet_ContentHandler = class(TJavaGenericImport<Jnet_ContentHandlerClass, Jnet_ContentHandler>) end;

  JContentHandlerFactoryClass = interface(IJavaClass)
    ['{84FB0402-3D19-4B41-961D-5E0960A4BF47}']
  end;

  [JavaSignature('java/net/ContentHandlerFactory')]
  JContentHandlerFactory = interface(IJavaInstance)
    ['{19888BC1-C4B8-4ED1-8596-611F57F04D4D}']
    function createContentHandler(contentType: JString): Jnet_ContentHandler; cdecl;
  end;
  TJContentHandlerFactory = class(TJavaGenericImport<JContentHandlerFactoryClass, JContentHandlerFactory>) end;

  JDatagramPacketClass = interface(JObjectClass)
    ['{4BCE7F27-040D-4DBA-8F3D-D4CECB6501EC}']
    {class} function init(data: TJavaArray<Byte>; length: Integer): JDatagramPacket; cdecl; overload;
    {class} function init(data: TJavaArray<Byte>; offset: Integer; length: Integer): JDatagramPacket; cdecl; overload;
    {class} function init(data: TJavaArray<Byte>; offset: Integer; length: Integer; host: JInetAddress; aPort: Integer): JDatagramPacket; cdecl; overload;
    {class} function init(data: TJavaArray<Byte>; length: Integer; host: JInetAddress; port: Integer): JDatagramPacket; cdecl; overload;
    {class} function init(data: TJavaArray<Byte>; length: Integer; sockAddr: JSocketAddress): JDatagramPacket; cdecl; overload;
    {class} function init(data: TJavaArray<Byte>; offset: Integer; length: Integer; sockAddr: JSocketAddress): JDatagramPacket; cdecl; overload;
  end;

  [JavaSignature('java/net/DatagramPacket')]
  JDatagramPacket = interface(JObject)
    ['{10CA443B-A668-47A8-BF8E-4C95A97ED561}']
    function getAddress: JInetAddress; cdecl;
    function getData: TJavaArray<Byte>; cdecl;
    function getLength: Integer; cdecl;
    function getOffset: Integer; cdecl;
    function getPort: Integer; cdecl;
    function getSocketAddress: JSocketAddress; cdecl;
    procedure setAddress(addr: JInetAddress); cdecl;
    procedure setData(data: TJavaArray<Byte>; offset: Integer; byteCount: Integer); cdecl; overload;
    procedure setData(buf: TJavaArray<Byte>); cdecl; overload;
    procedure setLength(length: Integer); cdecl;
    procedure setPort(aPort: Integer); cdecl;
    procedure setSocketAddress(sockAddr: JSocketAddress); cdecl;
  end;
  TJDatagramPacket = class(TJavaGenericImport<JDatagramPacketClass, JDatagramPacket>) end;

  JDatagramSocketClass = interface(JObjectClass)
    ['{0F66163B-C40D-48E1-A9C1-06CFEB60D382}']
    {class} function init: JDatagramSocket; cdecl; overload;
    {class} function init(aPort: Integer): JDatagramSocket; cdecl; overload;
    {class} function init(aPort: Integer; addr: JInetAddress): JDatagramSocket; cdecl; overload;
    {class} function init(localAddr: JSocketAddress): JDatagramSocket; cdecl; overload;
    {class} procedure setDatagramSocketImplFactory(fac: JDatagramSocketImplFactory); cdecl;
  end;

  [JavaSignature('java/net/DatagramSocket')]
  JDatagramSocket = interface(JObject)
    ['{A72F09A9-7901-41BE-AAF9-CE4D38CA39A0}']
    procedure bind(localAddr: JSocketAddress); cdecl;
    procedure close; cdecl;
    procedure connect(peer: JSocketAddress); cdecl; overload;
    procedure connect(address: JInetAddress; port: Integer); cdecl; overload;
    procedure disconnect; cdecl;
    function getBroadcast: Boolean; cdecl;
    function getChannel: JDatagramChannel; cdecl;
    function getInetAddress: JInetAddress; cdecl;
    function getLocalAddress: JInetAddress; cdecl;
    function getLocalPort: Integer; cdecl;
    function getLocalSocketAddress: JSocketAddress; cdecl;
    function getPort: Integer; cdecl;
    function getReceiveBufferSize: Integer; cdecl;
    function getRemoteSocketAddress: JSocketAddress; cdecl;
    function getReuseAddress: Boolean; cdecl;
    function getSendBufferSize: Integer; cdecl;
    function getSoTimeout: Integer; cdecl;
    function getTrafficClass: Integer; cdecl;
    function isBound: Boolean; cdecl;
    function isClosed: Boolean; cdecl;
    function isConnected: Boolean; cdecl;
    procedure receive(pack: JDatagramPacket); cdecl;
    procedure send(pack: JDatagramPacket); cdecl;
    procedure setBroadcast(broadcast: Boolean); cdecl;
    procedure setReceiveBufferSize(size: Integer); cdecl;
    procedure setReuseAddress(reuse: Boolean); cdecl;
    procedure setSendBufferSize(size: Integer); cdecl;
    procedure setSoTimeout(timeout: Integer); cdecl;
    procedure setTrafficClass(value: Integer); cdecl;
  end;
  TJDatagramSocket = class(TJavaGenericImport<JDatagramSocketClass, JDatagramSocket>) end;

  JDatagramSocketImplClass = interface(JObjectClass)
    ['{A50B237A-F40E-46AB-B83F-79EB87DEB1AD}']
    {class} function init: JDatagramSocketImpl; cdecl;
  end;

  [JavaSignature('java/net/DatagramSocketImpl')]
  JDatagramSocketImpl = interface(JObject)
    ['{FFE4E364-CF9B-443F-BE0B-44A6334B3325}']
  end;
  TJDatagramSocketImpl = class(TJavaGenericImport<JDatagramSocketImplClass, JDatagramSocketImpl>) end;

  JDatagramSocketImplFactoryClass = interface(IJavaClass)
    ['{4E896116-9C88-44E6-813E-084FD44707E7}']
  end;

  [JavaSignature('java/net/DatagramSocketImplFactory')]
  JDatagramSocketImplFactory = interface(IJavaInstance)
    ['{0936C4BF-2746-4093-8BDE-F260F9AC7278}']
    function createDatagramSocketImpl: JDatagramSocketImpl; cdecl;
  end;
  TJDatagramSocketImplFactory = class(TJavaGenericImport<JDatagramSocketImplFactoryClass, JDatagramSocketImplFactory>) end;

  JFileNameMapClass = interface(IJavaClass)
    ['{1A47F358-1E33-4E1B-B024-22A77BBFA3A4}']
  end;

  [JavaSignature('java/net/FileNameMap')]
  JFileNameMap = interface(IJavaInstance)
    ['{66E2FAD8-8B79-4E8F-BCE8-A88B68A4F094}']
    function getContentTypeFor(filename: JString): JString; cdecl;
  end;
  TJFileNameMap = class(TJavaGenericImport<JFileNameMapClass, JFileNameMap>) end;

  JURLConnectionClass = interface(JObjectClass)
    ['{1E41F00D-AF0A-4B08-94F3-0D5B93B249AC}']
    {class} function getDefaultAllowUserInteraction: Boolean; cdecl;
    {class} function getDefaultRequestProperty(field: JString): JString; cdecl;//Deprecated
    {class} function getFileNameMap: JFileNameMap; cdecl;
    {class} function guessContentTypeFromName(url: JString): JString; cdecl;
    {class} function guessContentTypeFromStream(is_: JInputStream): JString; cdecl;
    {class} procedure setContentHandlerFactory(contentFactory: JContentHandlerFactory); cdecl;
    {class} procedure setDefaultAllowUserInteraction(allows: Boolean); cdecl;
    {class} procedure setDefaultRequestProperty(field: JString; value: JString); cdecl;//Deprecated
    {class} procedure setFileNameMap(map: JFileNameMap); cdecl;
  end;

  [JavaSignature('java/net/URLConnection')]
  JURLConnection = interface(JObject)
    ['{81A3990E-E273-4A22-9380-7FFFD145261A}']
    procedure addRequestProperty(field: JString; newValue: JString); cdecl;
    procedure connect; cdecl;
    function getAllowUserInteraction: Boolean; cdecl;
    function getConnectTimeout: Integer; cdecl;
    function getContent: JObject; cdecl; overload;
    function getContent(types: TJavaObjectArray<Jlang_Class>): JObject; cdecl; overload;
    function getContentEncoding: JString; cdecl;
    function getContentLength: Integer; cdecl;
    function getContentType: JString; cdecl;
    function getDate: Int64; cdecl;
    function getDefaultUseCaches: Boolean; cdecl;
    function getDoInput: Boolean; cdecl;
    function getDoOutput: Boolean; cdecl;
    function getExpiration: Int64; cdecl;
    function getHeaderField(pos: Integer): JString; cdecl; overload;
    function getHeaderField(key: JString): JString; cdecl; overload;
    function getHeaderFieldDate(field: JString; defaultValue: Int64): Int64; cdecl;
    function getHeaderFieldInt(field: JString; defaultValue: Integer): Integer; cdecl;
    function getHeaderFieldKey(posn: Integer): JString; cdecl;
    function getHeaderFields: JMap; cdecl;
    function getIfModifiedSince: Int64; cdecl;
    function getInputStream: JInputStream; cdecl;
    function getLastModified: Int64; cdecl;
    function getOutputStream: JOutputStream; cdecl;
    function getPermission: JPermission; cdecl;
    function getReadTimeout: Integer; cdecl;
    function getRequestProperties: JMap; cdecl;
    function getRequestProperty(field: JString): JString; cdecl;
    function getURL: JURL; cdecl;
    function getUseCaches: Boolean; cdecl;
    procedure setAllowUserInteraction(newValue: Boolean); cdecl;
    procedure setConnectTimeout(timeoutMillis: Integer); cdecl;
    procedure setDefaultUseCaches(newValue: Boolean); cdecl;
    procedure setDoInput(newValue: Boolean); cdecl;
    procedure setDoOutput(newValue: Boolean); cdecl;
    procedure setIfModifiedSince(newValue: Int64); cdecl;
    procedure setReadTimeout(timeoutMillis: Integer); cdecl;
    procedure setRequestProperty(field: JString; newValue: JString); cdecl;
    procedure setUseCaches(newValue: Boolean); cdecl;
    function toString: JString; cdecl;
  end;
  TJURLConnection = class(TJavaGenericImport<JURLConnectionClass, JURLConnection>) end;

  JHttpURLConnectionClass = interface(JURLConnectionClass)
    ['{AFFFAD91-C0D9-4691-9F26-A8B154AF909A}']
    {class} function _GetHTTP_ACCEPTED: Integer; cdecl;
    {class} function _GetHTTP_BAD_GATEWAY: Integer; cdecl;
    {class} function _GetHTTP_BAD_METHOD: Integer; cdecl;
    {class} function _GetHTTP_BAD_REQUEST: Integer; cdecl;
    {class} function _GetHTTP_CLIENT_TIMEOUT: Integer; cdecl;
    {class} function _GetHTTP_CONFLICT: Integer; cdecl;
    {class} function _GetHTTP_CREATED: Integer; cdecl;
    {class} function _GetHTTP_ENTITY_TOO_LARGE: Integer; cdecl;
    {class} function _GetHTTP_FORBIDDEN: Integer; cdecl;
    {class} function _GetHTTP_GATEWAY_TIMEOUT: Integer; cdecl;
    {class} function _GetHTTP_GONE: Integer; cdecl;
    {class} function _GetHTTP_INTERNAL_ERROR: Integer; cdecl;
    {class} function _GetHTTP_LENGTH_REQUIRED: Integer; cdecl;
    {class} function _GetHTTP_MOVED_PERM: Integer; cdecl;
    {class} function _GetHTTP_MOVED_TEMP: Integer; cdecl;
    {class} function _GetHTTP_MULT_CHOICE: Integer; cdecl;
    {class} function _GetHTTP_NOT_ACCEPTABLE: Integer; cdecl;
    {class} function _GetHTTP_NOT_AUTHORITATIVE: Integer; cdecl;
    {class} function _GetHTTP_NOT_FOUND: Integer; cdecl;
    {class} function _GetHTTP_NOT_IMPLEMENTED: Integer; cdecl;
    {class} function _GetHTTP_NOT_MODIFIED: Integer; cdecl;
    {class} function _GetHTTP_NO_CONTENT: Integer; cdecl;
    {class} function _GetHTTP_OK: Integer; cdecl;
    {class} function _GetHTTP_PARTIAL: Integer; cdecl;
    {class} function _GetHTTP_PAYMENT_REQUIRED: Integer; cdecl;
    {class} function _GetHTTP_PRECON_FAILED: Integer; cdecl;
    {class} function _GetHTTP_PROXY_AUTH: Integer; cdecl;
    {class} function _GetHTTP_REQ_TOO_LONG: Integer; cdecl;
    {class} function _GetHTTP_RESET: Integer; cdecl;
    {class} function _GetHTTP_SEE_OTHER: Integer; cdecl;
    {class} function _GetHTTP_SERVER_ERROR: Integer; cdecl;
    {class} function _GetHTTP_UNAUTHORIZED: Integer; cdecl;
    {class} function _GetHTTP_UNAVAILABLE: Integer; cdecl;
    {class} function _GetHTTP_UNSUPPORTED_TYPE: Integer; cdecl;
    {class} function _GetHTTP_USE_PROXY: Integer; cdecl;
    {class} function _GetHTTP_VERSION: Integer; cdecl;
    {class} function getFollowRedirects: Boolean; cdecl;
    {class} procedure setFollowRedirects(auto: Boolean); cdecl;
    {class} property HTTP_ACCEPTED: Integer read _GetHTTP_ACCEPTED;
    {class} property HTTP_BAD_GATEWAY: Integer read _GetHTTP_BAD_GATEWAY;
    {class} property HTTP_BAD_METHOD: Integer read _GetHTTP_BAD_METHOD;
    {class} property HTTP_BAD_REQUEST: Integer read _GetHTTP_BAD_REQUEST;
    {class} property HTTP_CLIENT_TIMEOUT: Integer read _GetHTTP_CLIENT_TIMEOUT;
    {class} property HTTP_CONFLICT: Integer read _GetHTTP_CONFLICT;
    {class} property HTTP_CREATED: Integer read _GetHTTP_CREATED;
    {class} property HTTP_ENTITY_TOO_LARGE: Integer read _GetHTTP_ENTITY_TOO_LARGE;
    {class} property HTTP_FORBIDDEN: Integer read _GetHTTP_FORBIDDEN;
    {class} property HTTP_GATEWAY_TIMEOUT: Integer read _GetHTTP_GATEWAY_TIMEOUT;
    {class} property HTTP_GONE: Integer read _GetHTTP_GONE;
    {class} property HTTP_INTERNAL_ERROR: Integer read _GetHTTP_INTERNAL_ERROR;
    {class} property HTTP_LENGTH_REQUIRED: Integer read _GetHTTP_LENGTH_REQUIRED;
    {class} property HTTP_MOVED_PERM: Integer read _GetHTTP_MOVED_PERM;
    {class} property HTTP_MOVED_TEMP: Integer read _GetHTTP_MOVED_TEMP;
    {class} property HTTP_MULT_CHOICE: Integer read _GetHTTP_MULT_CHOICE;
    {class} property HTTP_NOT_ACCEPTABLE: Integer read _GetHTTP_NOT_ACCEPTABLE;
    {class} property HTTP_NOT_AUTHORITATIVE: Integer read _GetHTTP_NOT_AUTHORITATIVE;
    {class} property HTTP_NOT_FOUND: Integer read _GetHTTP_NOT_FOUND;
    {class} property HTTP_NOT_IMPLEMENTED: Integer read _GetHTTP_NOT_IMPLEMENTED;
    {class} property HTTP_NOT_MODIFIED: Integer read _GetHTTP_NOT_MODIFIED;
    {class} property HTTP_NO_CONTENT: Integer read _GetHTTP_NO_CONTENT;
    {class} property HTTP_OK: Integer read _GetHTTP_OK;
    {class} property HTTP_PARTIAL: Integer read _GetHTTP_PARTIAL;
    {class} property HTTP_PAYMENT_REQUIRED: Integer read _GetHTTP_PAYMENT_REQUIRED;
    {class} property HTTP_PRECON_FAILED: Integer read _GetHTTP_PRECON_FAILED;
    {class} property HTTP_PROXY_AUTH: Integer read _GetHTTP_PROXY_AUTH;
    {class} property HTTP_REQ_TOO_LONG: Integer read _GetHTTP_REQ_TOO_LONG;
    {class} property HTTP_RESET: Integer read _GetHTTP_RESET;
    {class} property HTTP_SEE_OTHER: Integer read _GetHTTP_SEE_OTHER;
    {class} property HTTP_SERVER_ERROR: Integer read _GetHTTP_SERVER_ERROR;
    {class} property HTTP_UNAUTHORIZED: Integer read _GetHTTP_UNAUTHORIZED;
    {class} property HTTP_UNAVAILABLE: Integer read _GetHTTP_UNAVAILABLE;
    {class} property HTTP_UNSUPPORTED_TYPE: Integer read _GetHTTP_UNSUPPORTED_TYPE;
    {class} property HTTP_USE_PROXY: Integer read _GetHTTP_USE_PROXY;
    {class} property HTTP_VERSION: Integer read _GetHTTP_VERSION;
  end;

  [JavaSignature('java/net/HttpURLConnection')]
  JHttpURLConnection = interface(JURLConnection)
    ['{B83F875D-71D7-4629-B008-9289FC607C98}']
    procedure disconnect; cdecl;
    function getContentEncoding: JString; cdecl;
    function getErrorStream: JInputStream; cdecl;
    function getHeaderFieldDate(field: JString; defaultValue: Int64): Int64; cdecl;
    function getInstanceFollowRedirects: Boolean; cdecl;
    function getPermission: JPermission; cdecl;
    function getRequestMethod: JString; cdecl;
    function getResponseCode: Integer; cdecl;
    function getResponseMessage: JString; cdecl;
    procedure setChunkedStreamingMode(chunkLength: Integer); cdecl;
    procedure setFixedLengthStreamingMode(contentLength: Int64); cdecl; overload;
    procedure setFixedLengthStreamingMode(contentLength: Integer); cdecl; overload;
    procedure setInstanceFollowRedirects(followRedirects: Boolean); cdecl;
    procedure setRequestMethod(method: JString); cdecl;
    function usingProxy: Boolean; cdecl;
  end;
  TJHttpURLConnection = class(TJavaGenericImport<JHttpURLConnectionClass, JHttpURLConnection>) end;

  JInetAddressClass = interface(JObjectClass)
    ['{492EE337-5445-46CE-94D6-942FAEFF4CFA}']
    {class} function getAllByName(host: JString): TJavaObjectArray<JInetAddress>; cdecl;
    {class} function getByAddress(ipAddress: TJavaArray<Byte>): JInetAddress; cdecl; overload;
    {class} function getByAddress(hostName: JString; ipAddress: TJavaArray<Byte>): JInetAddress; cdecl; overload;
    {class} function getByName(host: JString): JInetAddress; cdecl;
    {class} function getLocalHost: JInetAddress; cdecl;
    {class} function getLoopbackAddress: JInetAddress; cdecl;
  end;

  [JavaSignature('java/net/InetAddress')]
  JInetAddress = interface(JObject)
    ['{B6B43DAF-D7CE-4794-AC69-E787DADC9035}']
    function equals(obj: JObject): Boolean; cdecl;
    function getAddress: TJavaArray<Byte>; cdecl;
    function getCanonicalHostName: JString; cdecl;
    function getHostAddress: JString; cdecl;
    function getHostName: JString; cdecl;
    function hashCode: Integer; cdecl;
    function isAnyLocalAddress: Boolean; cdecl;
    function isLinkLocalAddress: Boolean; cdecl;
    function isLoopbackAddress: Boolean; cdecl;
    function isMCGlobal: Boolean; cdecl;
    function isMCLinkLocal: Boolean; cdecl;
    function isMCNodeLocal: Boolean; cdecl;
    function isMCOrgLocal: Boolean; cdecl;
    function isMCSiteLocal: Boolean; cdecl;
    function isMulticastAddress: Boolean; cdecl;
    function isReachable(timeout: Integer): Boolean; cdecl; overload;
    function isReachable(networkInterface: JNetworkInterface; ttl: Integer; timeout: Integer): Boolean; cdecl; overload;
    function isSiteLocalAddress: Boolean; cdecl;
    function toString: JString; cdecl;
  end;
  TJInetAddress = class(TJavaGenericImport<JInetAddressClass, JInetAddress>) end;

  JInet4AddressClass = interface(JInetAddressClass)
    ['{60903748-BDC9-4C60-8683-4B5D22432958}']
  end;

  [JavaSignature('java/net/Inet4Address')]
  JInet4Address = interface(JInetAddress)
    ['{0C7F53CB-4917-4653-829B-B70619BCF0D5}']
    function isAnyLocalAddress: Boolean; cdecl;
    function isLinkLocalAddress: Boolean; cdecl;
    function isLoopbackAddress: Boolean; cdecl;
    function isMCGlobal: Boolean; cdecl;
    function isMCLinkLocal: Boolean; cdecl;
    function isMCNodeLocal: Boolean; cdecl;
    function isMCOrgLocal: Boolean; cdecl;
    function isMCSiteLocal: Boolean; cdecl;
    function isMulticastAddress: Boolean; cdecl;
    function isSiteLocalAddress: Boolean; cdecl;
  end;
  TJInet4Address = class(TJavaGenericImport<JInet4AddressClass, JInet4Address>) end;

  JInet6AddressClass = interface(JInetAddressClass)
    ['{D49DB1D9-4A6E-4A91-B376-5DAA96802A0F}']
    {class} function getByAddress(host: JString; addr: TJavaArray<Byte>; scope_id: Integer): JInet6Address; cdecl; overload;
    {class} function getByAddress(host: JString; addr: TJavaArray<Byte>; nif: JNetworkInterface): JInet6Address; cdecl; overload;
  end;

  [JavaSignature('java/net/Inet6Address')]
  JInet6Address = interface(JInetAddress)
    ['{42E7D54F-1482-4691-8919-6280C467B0DF}']
    function getScopeId: Integer; cdecl;
    function getScopedInterface: JNetworkInterface; cdecl;
    function isAnyLocalAddress: Boolean; cdecl;
    function isIPv4CompatibleAddress: Boolean; cdecl;
    function isLinkLocalAddress: Boolean; cdecl;
    function isLoopbackAddress: Boolean; cdecl;
    function isMCGlobal: Boolean; cdecl;
    function isMCLinkLocal: Boolean; cdecl;
    function isMCNodeLocal: Boolean; cdecl;
    function isMCOrgLocal: Boolean; cdecl;
    function isMCSiteLocal: Boolean; cdecl;
    function isMulticastAddress: Boolean; cdecl;
    function isSiteLocalAddress: Boolean; cdecl;
    function toString: JString; cdecl;
  end;
  TJInet6Address = class(TJavaGenericImport<JInet6AddressClass, JInet6Address>) end;

  JSocketAddressClass = interface(JObjectClass)
    ['{60D20DB8-E40A-4A52-9EFD-00CA47BB770C}']
    {class} function init: JSocketAddress; cdecl;
  end;

  [JavaSignature('java/net/SocketAddress')]
  JSocketAddress = interface(JObject)
    ['{942580A2-69D7-4E40-8DE0-87D70A5961E0}']
  end;
  TJSocketAddress = class(TJavaGenericImport<JSocketAddressClass, JSocketAddress>) end;

  JInetSocketAddressClass = interface(JSocketAddressClass)
    ['{12E81771-62EC-45BD-B615-621F654E27E3}']
    {class} function init(port: Integer): JInetSocketAddress; cdecl; overload;
    {class} function init(address: JInetAddress; port: Integer): JInetSocketAddress; cdecl; overload;
    {class} function init(host: JString; port: Integer): JInetSocketAddress; cdecl; overload;
    {class} function createUnresolved(host: JString; port: Integer): JInetSocketAddress; cdecl;
  end;

  [JavaSignature('java/net/InetSocketAddress')]
  JInetSocketAddress = interface(JSocketAddress)
    ['{14EAE4FF-039F-4FC8-8734-667C436EA016}']
    function equals(socketAddr: JObject): Boolean; cdecl;
    function getAddress: JInetAddress; cdecl;
    function getHostName: JString; cdecl;
    function getHostString: JString; cdecl;
    function getPort: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function isUnresolved: Boolean; cdecl;
    function toString: JString; cdecl;
  end;
  TJInetSocketAddress = class(TJavaGenericImport<JInetSocketAddressClass, JInetSocketAddress>) end;

  JNetworkInterfaceClass = interface(JObjectClass)
    ['{BB9045C7-8663-41A9-83E4-12C122370595}']
    {class} function getByIndex(index: Integer): JNetworkInterface; cdecl;
    {class} function getByInetAddress(address: JInetAddress): JNetworkInterface; cdecl;
    {class} function getByName(interfaceName: JString): JNetworkInterface; cdecl;
    {class} function getNetworkInterfaces: JEnumeration; cdecl;
  end;

  [JavaSignature('java/net/NetworkInterface')]
  JNetworkInterface = interface(JObject)
    ['{15C9BDCC-62F9-405C-B889-F50A5F9B6ABF}']
    function equals(obj: JObject): Boolean; cdecl;
    function getDisplayName: JString; cdecl;
    function getHardwareAddress: TJavaArray<Byte>; cdecl;
    function getIndex: Integer; cdecl;
    function getInetAddresses: JEnumeration; cdecl;
    function getInterfaceAddresses: JList; cdecl;
    function getMTU: Integer; cdecl;
    function getName: JString; cdecl;
    function getParent: JNetworkInterface; cdecl;
    function getSubInterfaces: JEnumeration; cdecl;
    function hashCode: Integer; cdecl;
    function isLoopback: Boolean; cdecl;
    function isPointToPoint: Boolean; cdecl;
    function isUp: Boolean; cdecl;
    function isVirtual: Boolean; cdecl;
    function supportsMulticast: Boolean; cdecl;
    function toString: JString; cdecl;
  end;
  TJNetworkInterface = class(TJavaGenericImport<JNetworkInterfaceClass, JNetworkInterface>) end;

  JProxyClass = interface(JObjectClass)
    ['{048E50A7-1BAE-4279-A463-E3902204EC7A}']
    {class} function _GetNO_PROXY: JProxy; cdecl;
    {class} function init(type_: JProxy_Type; sa: JSocketAddress): JProxy; cdecl;
    {class} property NO_PROXY: JProxy read _GetNO_PROXY;
  end;

  [JavaSignature('java/net/Proxy')]
  JProxy = interface(JObject)
    ['{E39BB6C6-22C5-46E8-8069-7190553008E9}']
    function address: JSocketAddress; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    function &type: JProxy_Type; cdecl;
  end;
  TJProxy = class(TJavaGenericImport<JProxyClass, JProxy>) end;

  JProxy_TypeClass = interface(JEnumClass)
    ['{0ED40B46-7D55-478F-89C7-09417890A5AF}']
    {class} function _GetDIRECT: JProxy_Type; cdecl;
    {class} function _GetHTTP: JProxy_Type; cdecl;
    {class} function _GetSOCKS: JProxy_Type; cdecl;
    {class} function valueOf(name: JString): JProxy_Type; cdecl;
    {class} function values: TJavaObjectArray<JProxy_Type>; cdecl;
    {class} property DIRECT: JProxy_Type read _GetDIRECT;
    {class} property HTTP: JProxy_Type read _GetHTTP;
    {class} property SOCKS: JProxy_Type read _GetSOCKS;
  end;

  [JavaSignature('java/net/Proxy$Type')]
  JProxy_Type = interface(JEnum)
    ['{BCD6DC15-85B1-44DA-8772-10FC2727FD38}']
  end;
  TJProxy_Type = class(TJavaGenericImport<JProxy_TypeClass, JProxy_Type>) end;

  JResponseCacheClass = interface(JObjectClass)
    ['{D813947F-B9AE-41F0-B400-46BA236FD5C8}']
    {class} function init: JResponseCache; cdecl;
    {class} function getDefault: JResponseCache; cdecl;
    {class} procedure setDefault(responseCache: JResponseCache); cdecl;
  end;

  [JavaSignature('java/net/ResponseCache')]
  JResponseCache = interface(JObject)
    ['{07B7E607-A0CF-47A2-95EE-A8A0E0735C7F}']
    function &get(uri: JURI; requestMethod: JString; requestHeaders: JMap): JCacheResponse; cdecl;
    function put(uri: JURI; connection: JURLConnection): JCacheRequest; cdecl;
  end;
  TJResponseCache = class(TJavaGenericImport<JResponseCacheClass, JResponseCache>) end;

  JServerSocketClass = interface(JObjectClass)
    ['{F387AEB9-A572-4E58-B1A1-F23460842F07}']
    {class} function init: JServerSocket; cdecl; overload;
    {class} function init(port: Integer): JServerSocket; cdecl; overload;
    {class} function init(port: Integer; backlog: Integer): JServerSocket; cdecl; overload;
    {class} function init(port: Integer; backlog: Integer; localAddress: JInetAddress): JServerSocket; cdecl; overload;
    {class} procedure setSocketFactory(aFactory: JSocketImplFactory); cdecl;
  end;

  [JavaSignature('java/net/ServerSocket')]
  JServerSocket = interface(JObject)
    ['{2626AEBA-E1F8-4E6F-AE4E-747C2AC1005D}']
    function accept: JSocket; cdecl;
    procedure bind(localAddr: JSocketAddress); cdecl; overload;
    procedure bind(localAddr: JSocketAddress; backlog: Integer); cdecl; overload;
    procedure close; cdecl;
    function getChannel: JServerSocketChannel; cdecl;
    function getInetAddress: JInetAddress; cdecl;
    function getLocalPort: Integer; cdecl;
    function getLocalSocketAddress: JSocketAddress; cdecl;
    function getReceiveBufferSize: Integer; cdecl;
    function getReuseAddress: Boolean; cdecl;
    function getSoTimeout: Integer; cdecl;
    function isBound: Boolean; cdecl;
    function isClosed: Boolean; cdecl;
    procedure setPerformancePreferences(connectionTime: Integer; latency: Integer; bandwidth: Integer); cdecl;
    procedure setReceiveBufferSize(size: Integer); cdecl;
    procedure setReuseAddress(reuse: Boolean); cdecl;
    procedure setSoTimeout(timeout: Integer); cdecl;
    function toString: JString; cdecl;
  end;
  TJServerSocket = class(TJavaGenericImport<JServerSocketClass, JServerSocket>) end;

  JSocketClass = interface(JObjectClass)
    ['{DB5E8FED-7D12-4514-B19B-AF6DF5F6FC01}']
    {class} function init: JSocket; cdecl; overload;
    {class} function init(proxy: JProxy): JSocket; cdecl; overload;
    {class} function init(dstName: JString; dstPort: Integer): JSocket; cdecl; overload;
    {class} function init(dstName: JString; dstPort: Integer; localAddress: JInetAddress; localPort: Integer): JSocket; cdecl; overload;
    {class} function init(hostName: JString; port: Integer; streaming: Boolean): JSocket; cdecl; overload;//Deprecated
    {class} function init(dstAddress: JInetAddress; dstPort: Integer): JSocket; cdecl; overload;
    {class} function init(dstAddress: JInetAddress; dstPort: Integer; localAddress: JInetAddress; localPort: Integer): JSocket; cdecl; overload;
    {class} function init(addr: JInetAddress; port: Integer; streaming: Boolean): JSocket; cdecl; overload;//Deprecated
    {class} procedure setSocketImplFactory(fac: JSocketImplFactory); cdecl;
  end;

  [JavaSignature('java/net/Socket')]
  JSocket = interface(JObject)
    ['{211F5BA9-1676-41BF-AA86-3FFDD53632F0}']
    procedure bind(localAddr: JSocketAddress); cdecl;
    procedure close; cdecl;
    procedure connect(remoteAddr: JSocketAddress); cdecl; overload;
    procedure connect(remoteAddr: JSocketAddress; timeout: Integer); cdecl; overload;
    function getChannel: JSocketChannel; cdecl;
    function getInetAddress: JInetAddress; cdecl;
    function getInputStream: JInputStream; cdecl;
    function getKeepAlive: Boolean; cdecl;
    function getLocalAddress: JInetAddress; cdecl;
    function getLocalPort: Integer; cdecl;
    function getLocalSocketAddress: JSocketAddress; cdecl;
    function getOOBInline: Boolean; cdecl;
    function getOutputStream: JOutputStream; cdecl;
    function getPort: Integer; cdecl;
    function getReceiveBufferSize: Integer; cdecl;
    function getRemoteSocketAddress: JSocketAddress; cdecl;
    function getReuseAddress: Boolean; cdecl;
    function getSendBufferSize: Integer; cdecl;
    function getSoLinger: Integer; cdecl;
    function getSoTimeout: Integer; cdecl;
    function getTcpNoDelay: Boolean; cdecl;
    function getTrafficClass: Integer; cdecl;
    function isBound: Boolean; cdecl;
    function isClosed: Boolean; cdecl;
    function isConnected: Boolean; cdecl;
    function isInputShutdown: Boolean; cdecl;
    function isOutputShutdown: Boolean; cdecl;
    procedure sendUrgentData(value: Integer); cdecl;
    procedure setKeepAlive(keepAlive: Boolean); cdecl;
    procedure setOOBInline(oobinline: Boolean); cdecl;
    procedure setPerformancePreferences(connectionTime: Integer; latency: Integer; bandwidth: Integer); cdecl;
    procedure setReceiveBufferSize(size: Integer); cdecl;
    procedure setReuseAddress(reuse: Boolean); cdecl;
    procedure setSendBufferSize(size: Integer); cdecl;
    procedure setSoLinger(on: Boolean; timeout: Integer); cdecl;
    procedure setSoTimeout(timeout: Integer); cdecl;
    procedure setTcpNoDelay(on: Boolean); cdecl;
    procedure setTrafficClass(value: Integer); cdecl;
    procedure shutdownInput; cdecl;
    procedure shutdownOutput; cdecl;
    function toString: JString; cdecl;
  end;
  TJSocket = class(TJavaGenericImport<JSocketClass, JSocket>) end;

  JSocketImplClass = interface(JObjectClass)
    ['{115EBD14-0CFA-4AF7-B9C9-764D7B87A468}']
    {class} function init: JSocketImpl; cdecl;
  end;

  [JavaSignature('java/net/SocketImpl')]
  JSocketImpl = interface(JObject)
    ['{B35C8A07-5814-4987-A2C2-E331D82D5A1B}']
    function toString: JString; cdecl;
  end;
  TJSocketImpl = class(TJavaGenericImport<JSocketImplClass, JSocketImpl>) end;

  JSocketImplFactoryClass = interface(IJavaClass)
    ['{AABBCC1A-57AD-4EA8-ADE7-D9B6A7C2B866}']
  end;

  [JavaSignature('java/net/SocketImplFactory')]
  JSocketImplFactory = interface(IJavaInstance)
    ['{B4CAFC5B-CE9F-4934-8739-8EE50CD7F227}']
    function createSocketImpl: JSocketImpl; cdecl;
  end;
  TJSocketImplFactory = class(TJavaGenericImport<JSocketImplFactoryClass, JSocketImplFactory>) end;

  JURIClass = interface(JObjectClass)
    ['{248E7A13-8C00-4246-B62A-26973AF67439}']
    {class} function init(spec: JString): JURI; cdecl; overload;
    {class} function init(scheme: JString; schemeSpecificPart: JString; fragment: JString): JURI; cdecl; overload;
    {class} function init(scheme: JString; userInfo: JString; host: JString; port: Integer; path: JString; query: JString; fragment: JString): JURI; cdecl; overload;
    {class} function init(scheme: JString; host: JString; path: JString; fragment: JString): JURI; cdecl; overload;
    {class} function init(scheme: JString; authority: JString; path: JString; query: JString; fragment: JString): JURI; cdecl; overload;
    {class} function create(uri: JString): JURI; cdecl;
  end;

  [JavaSignature('java/net/URI')]
  JURI = interface(JObject)
    ['{621C74EA-9C1E-4279-9DFF-253F28359DB1}']
    function compareTo(uri: JURI): Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getAuthority: JString; cdecl;
    function getFragment: JString; cdecl;
    function getHost: JString; cdecl;
    function getPath: JString; cdecl;
    function getPort: Integer; cdecl;
    function getQuery: JString; cdecl;
    function getRawAuthority: JString; cdecl;
    function getRawFragment: JString; cdecl;
    function getRawPath: JString; cdecl;
    function getRawQuery: JString; cdecl;
    function getRawSchemeSpecificPart: JString; cdecl;
    function getRawUserInfo: JString; cdecl;
    function getScheme: JString; cdecl;
    function getSchemeSpecificPart: JString; cdecl;
    function getUserInfo: JString; cdecl;
    function hashCode: Integer; cdecl;
    function isAbsolute: Boolean; cdecl;
    function isOpaque: Boolean; cdecl;
    function normalize: JURI; cdecl;
    function parseServerAuthority: JURI; cdecl;
    function relativize(relative: JURI): JURI; cdecl;
    function resolve(relative: JURI): JURI; cdecl; overload;
    function resolve(relative: JString): JURI; cdecl; overload;
    function toASCIIString: JString; cdecl;
    function toString: JString; cdecl;
    function toURL: JURL; cdecl;
  end;
  TJURI = class(TJavaGenericImport<JURIClass, JURI>) end;

  JURLClass = interface(JObjectClass)
    ['{BE22C128-8F58-4B04-A961-76BCD93FCBBD}']
    {class} function init(spec: JString): JURL; cdecl; overload;
    {class} function init(context: JURL; spec: JString): JURL; cdecl; overload;
    {class} function init(context: JURL; spec: JString; handler: JURLStreamHandler): JURL; cdecl; overload;
    {class} function init(protocol: JString; host: JString; file_: JString): JURL; cdecl; overload;
    {class} function init(protocol: JString; host: JString; port: Integer; file_: JString): JURL; cdecl; overload;
    {class} function init(protocol: JString; host: JString; port: Integer; file_: JString; handler: JURLStreamHandler): JURL; cdecl; overload;
    {class} procedure setURLStreamHandlerFactory(factory: JURLStreamHandlerFactory); cdecl;
  end;

  [JavaSignature('java/net/URL')]
  JURL = interface(JObject)
    ['{BCC8860A-E48B-4894-95A9-26B3AFDF3EDC}']
    function equals(o: JObject): Boolean; cdecl;
    function getAuthority: JString; cdecl;
    function getContent: JObject; cdecl; overload;
    function getContent(types: TJavaObjectArray<Jlang_Class>): JObject; cdecl; overload;
    function getDefaultPort: Integer; cdecl;
    function getFile: JString; cdecl;
    function getHost: JString; cdecl;
    function getPath: JString; cdecl;
    function getPort: Integer; cdecl;
    function getProtocol: JString; cdecl;
    function getQuery: JString; cdecl;
    function getRef: JString; cdecl;
    function getUserInfo: JString; cdecl;
    function hashCode: Integer; cdecl;
    function openConnection: JURLConnection; cdecl; overload;
    function openConnection(proxy: JProxy): JURLConnection; cdecl; overload;
    function openStream: JInputStream; cdecl;
    function sameFile(otherURL: JURL): Boolean; cdecl;
    function toExternalForm: JString; cdecl;
    function toString: JString; cdecl;
    function toURI: JURI; cdecl;
  end;
  TJURL = class(TJavaGenericImport<JURLClass, JURL>) end;

  JURLStreamHandlerClass = interface(JObjectClass)
    ['{8304BD07-354D-40DA-9F39-B863F9F124A4}']
    {class} function init: JURLStreamHandler; cdecl;
  end;

  [JavaSignature('java/net/URLStreamHandler')]
  JURLStreamHandler = interface(JObject)
    ['{EA0348E3-8A6E-491D-86E9-C36120279679}']
  end;
  TJURLStreamHandler = class(TJavaGenericImport<JURLStreamHandlerClass, JURLStreamHandler>) end;

  JURLStreamHandlerFactoryClass = interface(IJavaClass)
    ['{EFF1D603-CDE5-4858-948E-2871F2E373F3}']
  end;

  [JavaSignature('java/net/URLStreamHandlerFactory')]
  JURLStreamHandlerFactory = interface(IJavaInstance)
    ['{8893C36E-5F82-4B08-8229-EE4A2A1E9BFC}']
    function createURLStreamHandler(protocol: JString): JURLStreamHandler; cdecl;
  end;
  TJURLStreamHandlerFactory = class(TJavaGenericImport<JURLStreamHandlerFactoryClass, JURLStreamHandlerFactory>) end;

  JServerSocketFactoryClass = interface(JObjectClass)
    ['{7E3304CF-103B-4DD1-B1B3-5BF686D3838A}']
    {class} function getDefault: JServerSocketFactory; cdecl;
  end;

  [JavaSignature('javax/net/ServerSocketFactory')]
  JServerSocketFactory = interface(JObject)
    ['{AE28B65C-1BC3-4FF1-B4A0-D42276761437}']
    function createServerSocket: JServerSocket; cdecl; overload;
    function createServerSocket(port: Integer): JServerSocket; cdecl; overload;
    function createServerSocket(port: Integer; backlog: Integer): JServerSocket; cdecl; overload;
    function createServerSocket(port: Integer; backlog: Integer; iAddress: JInetAddress): JServerSocket; cdecl; overload;
  end;
  TJServerSocketFactory = class(TJavaGenericImport<JServerSocketFactoryClass, JServerSocketFactory>) end;

  Jnet_SocketFactoryClass = interface(JObjectClass)
    ['{80B284D0-84F4-4C1A-8CC1-D98B0C1B0AFC}']
    {class} function getDefault: Jnet_SocketFactory; cdecl;
  end;

  [JavaSignature('javax/net/SocketFactory')]
  Jnet_SocketFactory = interface(JObject)
    ['{A0B638C3-8814-4356-B0EE-A398E4EAFDA9}']
    function createSocket: JSocket; cdecl; overload;
    function createSocket(host: JString; port: Integer): JSocket; cdecl; overload;
    function createSocket(host: JString; port: Integer; localHost: JInetAddress; localPort: Integer): JSocket; cdecl; overload;
    function createSocket(host: JInetAddress; port: Integer): JSocket; cdecl; overload;
    function createSocket(address: JInetAddress; port: Integer; localAddress: JInetAddress; localPort: Integer): JSocket; cdecl; overload;
  end;
  TJnet_SocketFactory = class(TJavaGenericImport<Jnet_SocketFactoryClass, Jnet_SocketFactory>) end;

  JHostnameVerifierClass = interface(IJavaClass)
    ['{4C9B1E29-39D4-4124-8BBC-7827D45EB16B}']
  end;

  [JavaSignature('javax/net/ssl/HostnameVerifier')]
  JHostnameVerifier = interface(IJavaInstance)
    ['{550462A6-05E0-4E07-9D81-3F5A8613F787}']
    function verify(hostname: JString; session: JSSLSession): Boolean; cdecl;
  end;
  TJHostnameVerifier = class(TJavaGenericImport<JHostnameVerifierClass, JHostnameVerifier>) end;

  JHttpsURLConnectionClass = interface(JHttpURLConnectionClass)
    ['{A4110139-AC54-4852-A7EE-2C3DFF71DA76}']
    {class} function getDefaultHostnameVerifier: JHostnameVerifier; cdecl;
    {class} function getDefaultSSLSocketFactory: Jssl_SSLSocketFactory; cdecl;
    {class} procedure setDefaultHostnameVerifier(v: JHostnameVerifier); cdecl;
    {class} procedure setDefaultSSLSocketFactory(sf: Jssl_SSLSocketFactory); cdecl;
  end;

  [JavaSignature('javax/net/ssl/HttpsURLConnection')]
  JHttpsURLConnection = interface(JHttpURLConnection)
    ['{69D72BE0-8A67-4107-88DB-57ACF8204FE8}']
    function getCipherSuite: JString; cdecl;
    function getHostnameVerifier: JHostnameVerifier; cdecl;
    function getLocalCertificates: TJavaObjectArray<JCertificate>; cdecl;
    function getLocalPrincipal: JPrincipal; cdecl;
    function getPeerPrincipal: JPrincipal; cdecl;
    function getSSLSocketFactory: Jssl_SSLSocketFactory; cdecl;
    function getServerCertificates: TJavaObjectArray<JCertificate>; cdecl;
    procedure setHostnameVerifier(v: JHostnameVerifier); cdecl;
    procedure setSSLSocketFactory(sf: Jssl_SSLSocketFactory); cdecl;
  end;
  TJHttpsURLConnection = class(TJavaGenericImport<JHttpsURLConnectionClass, JHttpsURLConnection>) end;

  JKeyManagerClass = interface(IJavaClass)
    ['{21F40812-C2DB-4D37-A88C-424FB51C75E0}']
  end;

  [JavaSignature('javax/net/ssl/KeyManager')]
  JKeyManager = interface(IJavaInstance)
    ['{5B24A8D6-C338-4D60-8836-61572B51D66D}']
  end;
  TJKeyManager = class(TJavaGenericImport<JKeyManagerClass, JKeyManager>) end;

  JKeyManagerFactoryClass = interface(JObjectClass)
    ['{8E3CB328-DC3A-4C08-BD80-6B708E222A88}']
    {class} function getDefaultAlgorithm: JString; cdecl;
    {class} function getInstance(algorithm: JString): JKeyManagerFactory; cdecl; overload;
    {class} function getInstance(algorithm: JString; provider: JString): JKeyManagerFactory; cdecl; overload;
    {class} function getInstance(algorithm: JString; provider: JProvider): JKeyManagerFactory; cdecl; overload;
  end;

  [JavaSignature('javax/net/ssl/KeyManagerFactory')]
  JKeyManagerFactory = interface(JObject)
    ['{B9E8F2EF-F22B-4B4C-A66D-0F9999DF5111}']
    function getAlgorithm: JString; cdecl;
    function getKeyManagers: TJavaObjectArray<JKeyManager>; cdecl;
    function getProvider: JProvider; cdecl;
    procedure init(ks: JKeyStore; password: TJavaArray<Char>); cdecl; overload;
    procedure init(spec: JManagerFactoryParameters); cdecl; overload;
  end;
  TJKeyManagerFactory = class(TJavaGenericImport<JKeyManagerFactoryClass, JKeyManagerFactory>) end;

  JManagerFactoryParametersClass = interface(IJavaClass)
    ['{FF4318C7-BC46-4379-BD8D-D861CFFECAFC}']
  end;

  [JavaSignature('javax/net/ssl/ManagerFactoryParameters')]
  JManagerFactoryParameters = interface(IJavaInstance)
    ['{F2FDD21B-EEBE-4832-B2ED-6EFFEEB0B835}']
  end;
  TJManagerFactoryParameters = class(TJavaGenericImport<JManagerFactoryParametersClass, JManagerFactoryParameters>) end;

  JSSLContextClass = interface(JObjectClass)
    ['{ECA2D26C-92C5-4B93-939E-8A26B85CA07D}']
    {class} function getDefault: JSSLContext; cdecl;
    {class} function getInstance(protocol: JString): JSSLContext; cdecl; overload;
    {class} function getInstance(protocol: JString; provider: JString): JSSLContext; cdecl; overload;
    {class} function getInstance(protocol: JString; provider: JProvider): JSSLContext; cdecl; overload;
    {class} procedure setDefault(sslContext: JSSLContext); cdecl;
  end;

  [JavaSignature('javax/net/ssl/SSLContext')]
  JSSLContext = interface(JObject)
    ['{265755CC-73B3-4A0E-9211-049A7B57809E}']
    function createSSLEngine: JSSLEngine; cdecl; overload;
    function createSSLEngine(peerHost: JString; peerPort: Integer): JSSLEngine; cdecl; overload;
    function getClientSessionContext: JSSLSessionContext; cdecl;
    function getDefaultSSLParameters: JSSLParameters; cdecl;
    function getProtocol: JString; cdecl;
    function getProvider: JProvider; cdecl;
    function getServerSessionContext: JSSLSessionContext; cdecl;
    function getServerSocketFactory: JSSLServerSocketFactory; cdecl;
    function getSocketFactory: Jssl_SSLSocketFactory; cdecl;
    function getSupportedSSLParameters: JSSLParameters; cdecl;
    procedure init(km: TJavaObjectArray<JKeyManager>; tm: TJavaObjectArray<JTrustManager>; sr: JSecureRandom); cdecl;
  end;
  TJSSLContext = class(TJavaGenericImport<JSSLContextClass, JSSLContext>) end;

  JSSLEngineClass = interface(JObjectClass)
    ['{BAAABE20-6E5F-4021-B7CD-182A2264C7DA}']
  end;

  [JavaSignature('javax/net/ssl/SSLEngine')]
  JSSLEngine = interface(JObject)
    ['{012D2973-85C8-4763-8883-A4EAECC3A570}']
    procedure beginHandshake; cdecl;
    procedure closeInbound; cdecl;
    procedure closeOutbound; cdecl;
    function getDelegatedTask: JRunnable; cdecl;
    function getEnableSessionCreation: Boolean; cdecl;
    function getEnabledCipherSuites: TJavaObjectArray<JString>; cdecl;
    function getEnabledProtocols: TJavaObjectArray<JString>; cdecl;
    function getHandshakeStatus: JSSLEngineResult_HandshakeStatus; cdecl;
    function getNeedClientAuth: Boolean; cdecl;
    function getPeerHost: JString; cdecl;
    function getPeerPort: Integer; cdecl;
    function getSSLParameters: JSSLParameters; cdecl;
    function getSession: JSSLSession; cdecl;
    function getSupportedCipherSuites: TJavaObjectArray<JString>; cdecl;
    function getSupportedProtocols: TJavaObjectArray<JString>; cdecl;
    function getUseClientMode: Boolean; cdecl;
    function getWantClientAuth: Boolean; cdecl;
    function isInboundDone: Boolean; cdecl;
    function isOutboundDone: Boolean; cdecl;
    procedure setEnableSessionCreation(flag: Boolean); cdecl;
    procedure setEnabledCipherSuites(suites: TJavaObjectArray<JString>); cdecl;
    procedure setEnabledProtocols(protocols: TJavaObjectArray<JString>); cdecl;
    procedure setNeedClientAuth(need: Boolean); cdecl;
    procedure setSSLParameters(p: JSSLParameters); cdecl;
    procedure setUseClientMode(mode: Boolean); cdecl;
    procedure setWantClientAuth(want: Boolean); cdecl;
    function unwrap(src: JByteBuffer; dsts: TJavaObjectArray<JByteBuffer>; offset: Integer; length: Integer): JSSLEngineResult; cdecl; overload;
    function unwrap(src: JByteBuffer; dst: JByteBuffer): JSSLEngineResult; cdecl; overload;
    function unwrap(src: JByteBuffer; dsts: TJavaObjectArray<JByteBuffer>): JSSLEngineResult; cdecl; overload;
    function wrap(srcs: TJavaObjectArray<JByteBuffer>; offset: Integer; length: Integer; dst: JByteBuffer): JSSLEngineResult; cdecl; overload;
    function wrap(srcs: TJavaObjectArray<JByteBuffer>; dst: JByteBuffer): JSSLEngineResult; cdecl; overload;
    function wrap(src: JByteBuffer; dst: JByteBuffer): JSSLEngineResult; cdecl; overload;
  end;
  TJSSLEngine = class(TJavaGenericImport<JSSLEngineClass, JSSLEngine>) end;

  JSSLEngineResultClass = interface(JObjectClass)
    ['{F8F1D25C-A489-4F86-BCEB-CC48F7AC2994}']
    {class} function init(status: JSSLEngineResult_Status; handshakeStatus: JSSLEngineResult_HandshakeStatus; bytesConsumed: Integer; bytesProduced: Integer): JSSLEngineResult; cdecl;
  end;

  [JavaSignature('javax/net/ssl/SSLEngineResult')]
  JSSLEngineResult = interface(JObject)
    ['{C4F26352-D6EF-4DF7-8EBF-22F65BA5BC3A}']
    function bytesConsumed: Integer; cdecl;
    function bytesProduced: Integer; cdecl;
    function getHandshakeStatus: JSSLEngineResult_HandshakeStatus; cdecl;
    function getStatus: JSSLEngineResult_Status; cdecl;
    function toString: JString; cdecl;
  end;
  TJSSLEngineResult = class(TJavaGenericImport<JSSLEngineResultClass, JSSLEngineResult>) end;

  JSSLEngineResult_HandshakeStatusClass = interface(JEnumClass)
    ['{39AAE6A5-C19F-41CD-BBC8-393E2FCD6AFF}']
    {class} function _GetFINISHED: JSSLEngineResult_HandshakeStatus; cdecl;
    {class} function _GetNEED_TASK: JSSLEngineResult_HandshakeStatus; cdecl;
    {class} function _GetNEED_UNWRAP: JSSLEngineResult_HandshakeStatus; cdecl;
    {class} function _GetNEED_WRAP: JSSLEngineResult_HandshakeStatus; cdecl;
    {class} function _GetNOT_HANDSHAKING: JSSLEngineResult_HandshakeStatus; cdecl;
    {class} function valueOf(name: JString): JSSLEngineResult_HandshakeStatus; cdecl;
    {class} function values: TJavaObjectArray<JSSLEngineResult_HandshakeStatus>; cdecl;
    {class} property FINISHED: JSSLEngineResult_HandshakeStatus read _GetFINISHED;
    {class} property NEED_TASK: JSSLEngineResult_HandshakeStatus read _GetNEED_TASK;
    {class} property NEED_UNWRAP: JSSLEngineResult_HandshakeStatus read _GetNEED_UNWRAP;
    {class} property NEED_WRAP: JSSLEngineResult_HandshakeStatus read _GetNEED_WRAP;
    {class} property NOT_HANDSHAKING: JSSLEngineResult_HandshakeStatus read _GetNOT_HANDSHAKING;
  end;

  [JavaSignature('javax/net/ssl/SSLEngineResult$HandshakeStatus')]
  JSSLEngineResult_HandshakeStatus = interface(JEnum)
    ['{421FAE1D-BB23-4B9D-A8F0-27751CF8B1E0}']
  end;
  TJSSLEngineResult_HandshakeStatus = class(TJavaGenericImport<JSSLEngineResult_HandshakeStatusClass, JSSLEngineResult_HandshakeStatus>) end;

  JSSLEngineResult_StatusClass = interface(JEnumClass)
    ['{FEAE2C82-9632-460B-8579-805E32F2C367}']
    {class} function _GetBUFFER_OVERFLOW: JSSLEngineResult_Status; cdecl;
    {class} function _GetBUFFER_UNDERFLOW: JSSLEngineResult_Status; cdecl;
    {class} function _GetCLOSED: JSSLEngineResult_Status; cdecl;
    {class} function _GetOK: JSSLEngineResult_Status; cdecl;
    {class} function valueOf(name: JString): JSSLEngineResult_Status; cdecl;
    {class} function values: TJavaObjectArray<JSSLEngineResult_Status>; cdecl;
    {class} property BUFFER_OVERFLOW: JSSLEngineResult_Status read _GetBUFFER_OVERFLOW;
    {class} property BUFFER_UNDERFLOW: JSSLEngineResult_Status read _GetBUFFER_UNDERFLOW;
    {class} property CLOSED: JSSLEngineResult_Status read _GetCLOSED;
    {class} property OK: JSSLEngineResult_Status read _GetOK;
  end;

  [JavaSignature('javax/net/ssl/SSLEngineResult$Status')]
  JSSLEngineResult_Status = interface(JEnum)
    ['{5BF63075-A1E1-4B56-A3E8-A469C9F9E077}']
  end;
  TJSSLEngineResult_Status = class(TJavaGenericImport<JSSLEngineResult_StatusClass, JSSLEngineResult_Status>) end;

  JSSLParametersClass = interface(JObjectClass)
    ['{3AE4F5A2-6FE0-4F13-BD73-DB3DB1312ABA}']
    {class} function init: JSSLParameters; cdecl; overload;
    {class} function init(cipherSuites: TJavaObjectArray<JString>): JSSLParameters; cdecl; overload;
    {class} function init(cipherSuites: TJavaObjectArray<JString>; protocols: TJavaObjectArray<JString>): JSSLParameters; cdecl; overload;
  end;

  [JavaSignature('javax/net/ssl/SSLParameters')]
  JSSLParameters = interface(JObject)
    ['{8F0342F0-7FC5-494A-984F-7A12BCCDB1EE}']
    function getCipherSuites: TJavaObjectArray<JString>; cdecl;
    function getNeedClientAuth: Boolean; cdecl;
    function getProtocols: TJavaObjectArray<JString>; cdecl;
    function getWantClientAuth: Boolean; cdecl;
    procedure setCipherSuites(cipherSuites: TJavaObjectArray<JString>); cdecl;
    procedure setNeedClientAuth(needClientAuth: Boolean); cdecl;
    procedure setProtocols(protocols: TJavaObjectArray<JString>); cdecl;
    procedure setWantClientAuth(wantClientAuth: Boolean); cdecl;
  end;
  TJSSLParameters = class(TJavaGenericImport<JSSLParametersClass, JSSLParameters>) end;

  JSSLServerSocketFactoryClass = interface(JServerSocketFactoryClass)
    ['{D9E9A467-AEB3-4D12-8C2D-F736D3DEE702}']
    {class} function getDefault: JServerSocketFactory; cdecl;
  end;

  [JavaSignature('javax/net/ssl/SSLServerSocketFactory')]
  JSSLServerSocketFactory = interface(JServerSocketFactory)
    ['{E98E0C65-85C2-43B3-BC05-AA0469744526}']
    function getDefaultCipherSuites: TJavaObjectArray<JString>; cdecl;
    function getSupportedCipherSuites: TJavaObjectArray<JString>; cdecl;
  end;
  TJSSLServerSocketFactory = class(TJavaGenericImport<JSSLServerSocketFactoryClass, JSSLServerSocketFactory>) end;

  JSSLSessionClass = interface(IJavaClass)
    ['{C6972B16-AD10-4299-BCEB-8984204AB41E}']
  end;

  [JavaSignature('javax/net/ssl/SSLSession')]
  JSSLSession = interface(IJavaInstance)
    ['{77CF05C7-35CD-4DA0-9CCA-1300E7780808}']
    function getApplicationBufferSize: Integer; cdecl;
    function getCipherSuite: JString; cdecl;
    function getCreationTime: Int64; cdecl;
    function getId: TJavaArray<Byte>; cdecl;
    function getLastAccessedTime: Int64; cdecl;
    function getLocalCertificates: TJavaObjectArray<JCertificate>; cdecl;
    function getLocalPrincipal: JPrincipal; cdecl;
    function getPacketBufferSize: Integer; cdecl;
    function getPeerCertificateChain: TJavaObjectArray<Jcert_X509Certificate>; cdecl;
    function getPeerCertificates: TJavaObjectArray<JCertificate>; cdecl;
    function getPeerHost: JString; cdecl;
    function getPeerPort: Integer; cdecl;
    function getPeerPrincipal: JPrincipal; cdecl;
    function getProtocol: JString; cdecl;
    function getSessionContext: JSSLSessionContext; cdecl;
    function getValue(name: JString): JObject; cdecl;
    function getValueNames: TJavaObjectArray<JString>; cdecl;
    procedure invalidate; cdecl;
    function isValid: Boolean; cdecl;
    procedure putValue(name: JString; value: JObject); cdecl;
    procedure removeValue(name: JString); cdecl;
  end;
  TJSSLSession = class(TJavaGenericImport<JSSLSessionClass, JSSLSession>) end;

  JSSLSessionContextClass = interface(IJavaClass)
    ['{E7289973-3A07-44F8-AB30-F73387E95E40}']
  end;

  [JavaSignature('javax/net/ssl/SSLSessionContext')]
  JSSLSessionContext = interface(IJavaInstance)
    ['{85F3AEDC-01A1-4365-8096-27F150D132FA}']
    function getIds: TJavaObjectArray<JEnumeration>; cdecl;
    function getSession(sessionId: TJavaArray<Byte>): JSSLSession; cdecl;
    function getSessionCacheSize: Integer; cdecl;
    function getSessionTimeout: Integer; cdecl;
    procedure setSessionCacheSize(size: Integer); cdecl;
    procedure setSessionTimeout(seconds: Integer); cdecl;
  end;
  TJSSLSessionContext = class(TJavaGenericImport<JSSLSessionContextClass, JSSLSessionContext>) end;

  Jssl_SSLSocketFactoryClass = interface(Jnet_SocketFactoryClass)
    ['{3EAA39D3-A9AA-44A7-8F6E-D9C807FE607D}']
    {class} function init: Jssl_SSLSocketFactory; cdecl;
    {class} function getDefault: Jnet_SocketFactory; cdecl;
  end;

  [JavaSignature('javax/net/ssl/SSLSocketFactory')]
  Jssl_SSLSocketFactory = interface(Jnet_SocketFactory)
    ['{7F1F07B3-D38E-4C4B-AF90-A79EE2B8D53B}']
    function createSocket(s: JSocket; host: JString; port: Integer; autoClose: Boolean): JSocket; cdecl;
    function getDefaultCipherSuites: TJavaObjectArray<JString>; cdecl;
    function getSupportedCipherSuites: TJavaObjectArray<JString>; cdecl;
  end;
  TJssl_SSLSocketFactory = class(TJavaGenericImport<Jssl_SSLSocketFactoryClass, Jssl_SSLSocketFactory>) end;

  JTrustManagerClass = interface(IJavaClass)
    ['{0856E6B9-F405-4346-B20D-E9E20425EFC2}']
  end;

  [JavaSignature('javax/net/ssl/TrustManager')]
  JTrustManager = interface(IJavaInstance)
    ['{A6DD0C52-928E-4E65-980F-9167C55840FA}']
  end;
  TJTrustManager = class(TJavaGenericImport<JTrustManagerClass, JTrustManager>) end;

  JTrustManagerFactoryClass = interface(JObjectClass)
    ['{0BE1CDA3-C6D6-4A69-88EE-C349F77BEAB5}']
    {class} function getDefaultAlgorithm: JString; cdecl;
    {class} function getInstance(algorithm: JString): JTrustManagerFactory; cdecl; overload;
    {class} function getInstance(algorithm: JString; provider: JString): JTrustManagerFactory; cdecl; overload;
    {class} function getInstance(algorithm: JString; provider: JProvider): JTrustManagerFactory; cdecl; overload;
  end;

  [JavaSignature('javax/net/ssl/TrustManagerFactory')]
  JTrustManagerFactory = interface(JObject)
    ['{F907542C-2731-4410-93E0-76986A871C2D}']
    function getAlgorithm: JString; cdecl;
    function getProvider: JProvider; cdecl;
    function getTrustManagers: TJavaObjectArray<JTrustManager>; cdecl;
    procedure init(ks: JKeyStore); cdecl; overload;
    procedure init(spec: JManagerFactoryParameters); cdecl; overload;
  end;
  TJTrustManagerFactory = class(TJavaGenericImport<JTrustManagerFactoryClass, JTrustManagerFactory>) end;

  JX509KeyManagerClass = interface(JKeyManagerClass)
    ['{BAC0E0B6-EA29-4228-AC17-AF9A7BA85B5C}']
  end;

  [JavaSignature('javax/net/ssl/X509KeyManager')]
  JX509KeyManager = interface(JKeyManager)
    ['{6B79A5A5-619D-44E9-90B4-4B0369F96055}']
    function chooseClientAlias(keyType: TJavaObjectArray<JString>; issuers: TJavaObjectArray<JPrincipal>; socket: JSocket): JString; cdecl;
    function chooseServerAlias(keyType: JString; issuers: TJavaObjectArray<JPrincipal>; socket: JSocket): JString; cdecl;
    function getCertificateChain(alias: JString): TJavaObjectArray<JX509Certificate>; cdecl;
    function getClientAliases(keyType: JString; issuers: TJavaObjectArray<JPrincipal>): TJavaObjectArray<JString>; cdecl;
    function getPrivateKey(alias: JString): JPrivateKey; cdecl;
    function getServerAliases(keyType: JString; issuers: TJavaObjectArray<JPrincipal>): TJavaObjectArray<JString>; cdecl;
  end;
  TJX509KeyManager = class(TJavaGenericImport<JX509KeyManagerClass, JX509KeyManager>) end;

  JX509TrustManagerClass = interface(JTrustManagerClass)
    ['{7684B973-52C4-49C0-BE3D-9CD5C97C9062}']
  end;

  [JavaSignature('javax/net/ssl/X509TrustManager')]
  JX509TrustManager = interface(JTrustManager)
    ['{B1BE4FF6-227F-4672-B975-C55D8CCD53D5}']
    procedure checkClientTrusted(chain: TJavaObjectArray<JX509Certificate>; authType: JString); cdecl;
    procedure checkServerTrusted(chain: TJavaObjectArray<JX509Certificate>; authType: JString); cdecl;
    function getAcceptedIssuers: TJavaObjectArray<JX509Certificate>; cdecl;
  end;
  TJX509TrustManager = class(TJavaGenericImport<JX509TrustManagerClass, JX509TrustManager>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JCacheRequest', TypeInfo(Androidapi.JNI.Java.Net.JCacheRequest));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JCacheResponse', TypeInfo(Androidapi.JNI.Java.Net.JCacheResponse));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.Jnet_ContentHandler', TypeInfo(Androidapi.JNI.Java.Net.Jnet_ContentHandler));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JContentHandlerFactory', TypeInfo(Androidapi.JNI.Java.Net.JContentHandlerFactory));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JDatagramPacket', TypeInfo(Androidapi.JNI.Java.Net.JDatagramPacket));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JDatagramSocket', TypeInfo(Androidapi.JNI.Java.Net.JDatagramSocket));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JDatagramSocketImpl', TypeInfo(Androidapi.JNI.Java.Net.JDatagramSocketImpl));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JDatagramSocketImplFactory', TypeInfo(Androidapi.JNI.Java.Net.JDatagramSocketImplFactory));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JFileNameMap', TypeInfo(Androidapi.JNI.Java.Net.JFileNameMap));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JURLConnection', TypeInfo(Androidapi.JNI.Java.Net.JURLConnection));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JHttpURLConnection', TypeInfo(Androidapi.JNI.Java.Net.JHttpURLConnection));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JInetAddress', TypeInfo(Androidapi.JNI.Java.Net.JInetAddress));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JInet4Address', TypeInfo(Androidapi.JNI.Java.Net.JInet4Address));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JInet6Address', TypeInfo(Androidapi.JNI.Java.Net.JInet6Address));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSocketAddress', TypeInfo(Androidapi.JNI.Java.Net.JSocketAddress));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JInetSocketAddress', TypeInfo(Androidapi.JNI.Java.Net.JInetSocketAddress));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JNetworkInterface', TypeInfo(Androidapi.JNI.Java.Net.JNetworkInterface));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JProxy', TypeInfo(Androidapi.JNI.Java.Net.JProxy));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JProxy_Type', TypeInfo(Androidapi.JNI.Java.Net.JProxy_Type));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JResponseCache', TypeInfo(Androidapi.JNI.Java.Net.JResponseCache));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JServerSocket', TypeInfo(Androidapi.JNI.Java.Net.JServerSocket));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSocket', TypeInfo(Androidapi.JNI.Java.Net.JSocket));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSocketImpl', TypeInfo(Androidapi.JNI.Java.Net.JSocketImpl));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSocketImplFactory', TypeInfo(Androidapi.JNI.Java.Net.JSocketImplFactory));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JURI', TypeInfo(Androidapi.JNI.Java.Net.JURI));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JURL', TypeInfo(Androidapi.JNI.Java.Net.JURL));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JURLStreamHandler', TypeInfo(Androidapi.JNI.Java.Net.JURLStreamHandler));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JURLStreamHandlerFactory', TypeInfo(Androidapi.JNI.Java.Net.JURLStreamHandlerFactory));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JServerSocketFactory', TypeInfo(Androidapi.JNI.Java.Net.JServerSocketFactory));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.Jnet_SocketFactory', TypeInfo(Androidapi.JNI.Java.Net.Jnet_SocketFactory));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JHostnameVerifier', TypeInfo(Androidapi.JNI.Java.Net.JHostnameVerifier));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JHttpsURLConnection', TypeInfo(Androidapi.JNI.Java.Net.JHttpsURLConnection));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JKeyManager', TypeInfo(Androidapi.JNI.Java.Net.JKeyManager));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JKeyManagerFactory', TypeInfo(Androidapi.JNI.Java.Net.JKeyManagerFactory));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JManagerFactoryParameters', TypeInfo(Androidapi.JNI.Java.Net.JManagerFactoryParameters));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSSLContext', TypeInfo(Androidapi.JNI.Java.Net.JSSLContext));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSSLEngine', TypeInfo(Androidapi.JNI.Java.Net.JSSLEngine));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSSLEngineResult', TypeInfo(Androidapi.JNI.Java.Net.JSSLEngineResult));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSSLEngineResult_HandshakeStatus', TypeInfo(Androidapi.JNI.Java.Net.JSSLEngineResult_HandshakeStatus));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSSLEngineResult_Status', TypeInfo(Androidapi.JNI.Java.Net.JSSLEngineResult_Status));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSSLParameters', TypeInfo(Androidapi.JNI.Java.Net.JSSLParameters));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSSLServerSocketFactory', TypeInfo(Androidapi.JNI.Java.Net.JSSLServerSocketFactory));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSSLSession', TypeInfo(Androidapi.JNI.Java.Net.JSSLSession));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JSSLSessionContext', TypeInfo(Androidapi.JNI.Java.Net.JSSLSessionContext));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.Jssl_SSLSocketFactory', TypeInfo(Androidapi.JNI.Java.Net.Jssl_SSLSocketFactory));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JTrustManager', TypeInfo(Androidapi.JNI.Java.Net.JTrustManager));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JTrustManagerFactory', TypeInfo(Androidapi.JNI.Java.Net.JTrustManagerFactory));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JX509KeyManager', TypeInfo(Androidapi.JNI.Java.Net.JX509KeyManager));
  TRegTypes.RegisterType('Androidapi.JNI.Java.Net.JX509TrustManager', TypeInfo(Androidapi.JNI.Java.Net.JX509TrustManager));
end;

initialization
  RegisterTypes;
end.


