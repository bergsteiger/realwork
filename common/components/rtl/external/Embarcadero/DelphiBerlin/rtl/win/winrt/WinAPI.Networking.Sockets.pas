{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Networking.Sockets;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.Networking,
  Winapi.Networking.Connectivity,
  Winapi.Security.Cryptography,
  Winapi.Security.Credentials,
  // Internal Uses...
  Winapi.Storage.Streams,
  Winapi.Foundation,
  Winapi.Foundation.Collections,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Networking.Sockets Class Names
  // Windows.Networking.Sockets.DatagramSocket
  // DualAPI
  SDatagramSocket = 'Windows.Networking.Sockets.DatagramSocket';
  // Windows.Networking.Sockets.StreamSocket
  // DualAPI
  SStreamSocket = 'Windows.Networking.Sockets.StreamSocket';
  // Windows.Networking.Sockets.StreamSocketListener
  // DualAPI
  SStreamSocketListener = 'Windows.Networking.Sockets.StreamSocketListener';
  // Windows.Networking.Sockets.DatagramSocketControl
  // DualAPI
  SDatagramSocketControl = 'Windows.Networking.Sockets.DatagramSocketControl';
  // Windows.Networking.Sockets.DatagramSocketInformation
  // DualAPI
  SDatagramSocketInformation = 'Windows.Networking.Sockets.DatagramSocketInformation';
  // Windows.Networking.Sockets.DatagramSocketMessageReceivedEventArgs
  // DualAPI
  SDatagramSocketMessageReceivedEventArgs = 'Windows.Networking.Sockets.DatagramSocketMessageReceivedEventArgs';
  // Windows.Networking.Sockets.StreamSocketControl
  // DualAPI
  SStreamSocketControl = 'Windows.Networking.Sockets.StreamSocketControl';
  // Windows.Networking.Sockets.StreamSocketInformation
  // DualAPI
  SStreamSocketInformation = 'Windows.Networking.Sockets.StreamSocketInformation';
  // Windows.Networking.Sockets.StreamSocketListenerControl
  // DualAPI
  SStreamSocketListenerControl = 'Windows.Networking.Sockets.StreamSocketListenerControl';
  // Windows.Networking.Sockets.StreamSocketListenerInformation
  // DualAPI
  SStreamSocketListenerInformation = 'Windows.Networking.Sockets.StreamSocketListenerInformation';
  // Windows.Networking.Sockets.StreamSocketListenerConnectionReceivedEventArgs
  // DualAPI
  SStreamSocketListenerConnectionReceivedEventArgs = 'Windows.Networking.Sockets.StreamSocketListenerConnectionReceivedEventArgs';
  // Windows.Networking.Sockets.WebSocketClosedEventArgs
  // DualAPI
  SWebSocketClosedEventArgs = 'Windows.Networking.Sockets.WebSocketClosedEventArgs';
  // Windows.Networking.Sockets.MessageWebSocketControl
  // DualAPI
  SMessageWebSocketControl = 'Windows.Networking.Sockets.MessageWebSocketControl';
  // Windows.Networking.Sockets.MessageWebSocketInformation
  // DualAPI
  SMessageWebSocketInformation = 'Windows.Networking.Sockets.MessageWebSocketInformation';
  // Windows.Networking.Sockets.MessageWebSocket
  // DualAPI
  SMessageWebSocket = 'Windows.Networking.Sockets.MessageWebSocket';
  // Windows.Networking.Sockets.MessageWebSocketMessageReceivedEventArgs
  // DualAPI
  SMessageWebSocketMessageReceivedEventArgs = 'Windows.Networking.Sockets.MessageWebSocketMessageReceivedEventArgs';
  // Windows.Networking.Sockets.StreamWebSocketControl
  // DualAPI
  SStreamWebSocketControl = 'Windows.Networking.Sockets.StreamWebSocketControl';
  // Windows.Networking.Sockets.StreamWebSocketInformation
  // DualAPI
  SStreamWebSocketInformation = 'Windows.Networking.Sockets.StreamWebSocketInformation';
  // Windows.Networking.Sockets.StreamWebSocket
  // DualAPI
  SStreamWebSocket = 'Windows.Networking.Sockets.StreamWebSocket';
  // Windows.Networking.Sockets.SocketError
  // DualAPI
  SSocketError = 'Windows.Networking.Sockets.SocketError';
  // Windows.Networking.Sockets.WebSocketError
  // DualAPI
  SWebSocketError = 'Windows.Networking.Sockets.WebSocketError';


type
  // Forward declare interfaces
  // Windows.Networking.Sockets.IStreamSocketListenerControl
  IStreamSocketListenerControl = interface;
  PIStreamSocketListenerControl = ^IStreamSocketListenerControl;

  // Windows.Networking.Sockets.IStreamSocketListenerInformation
  IStreamSocketListenerInformation = interface;
  PIStreamSocketListenerInformation = ^IStreamSocketListenerInformation;

  // Windows.Networking.Sockets.IStreamSocketControl
  IStreamSocketControl = interface;
  PIStreamSocketControl = ^IStreamSocketControl;

  // Windows.Networking.Sockets.IStreamSocketInformation
  IStreamSocketInformation = interface;
  PIStreamSocketInformation = ^IStreamSocketInformation;

  // Windows.Networking.Sockets.IStreamSocket
  IStreamSocket = interface;
  PIStreamSocket = ^IStreamSocket;

  // Windows.Networking.Sockets.IStreamSocketListenerConnectionReceivedEventArgs
  IStreamSocketListenerConnectionReceivedEventArgs = interface;
  PIStreamSocketListenerConnectionReceivedEventArgs = ^IStreamSocketListenerConnectionReceivedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.Sockets.IStreamSocketListener,Windows.Networking.Sockets.IStreamSocketListenerConnectionReceivedEventArgs>
  TypedEventHandler_2__IStreamSocketListener__IStreamSocketListenerConnectionReceivedEventArgs = interface;
  PTypedEventHandler_2__IStreamSocketListener__IStreamSocketListenerConnectionReceivedEventArgs = ^TypedEventHandler_2__IStreamSocketListener__IStreamSocketListenerConnectionReceivedEventArgs;

  // Windows.Networking.Sockets.IStreamSocketListener
  IStreamSocketListener = interface;
  PIStreamSocketListener = ^IStreamSocketListener;

  // Windows.Networking.Sockets.IDatagramSocketControl
  IDatagramSocketControl = interface;
  PIDatagramSocketControl = ^IDatagramSocketControl;

  // Windows.Networking.Sockets.IDatagramSocketInformation
  IDatagramSocketInformation = interface;
  PIDatagramSocketInformation = ^IDatagramSocketInformation;

  // Windows.Networking.Sockets.IDatagramSocketMessageReceivedEventArgs
  IDatagramSocketMessageReceivedEventArgs = interface;
  PIDatagramSocketMessageReceivedEventArgs = ^IDatagramSocketMessageReceivedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.Sockets.IDatagramSocket,Windows.Networking.Sockets.IDatagramSocketMessageReceivedEventArgs>
  TypedEventHandler_2__IDatagramSocket__IDatagramSocketMessageReceivedEventArgs = interface;
  PTypedEventHandler_2__IDatagramSocket__IDatagramSocketMessageReceivedEventArgs = ^TypedEventHandler_2__IDatagramSocket__IDatagramSocketMessageReceivedEventArgs;

  // Windows.Networking.Sockets.IDatagramSocket
  IDatagramSocket = interface;
  PIDatagramSocket = ^IDatagramSocket;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.Sockets.IStreamSocket>
  AsyncOperationCompletedHandler_1__IStreamSocket = interface;
  PAsyncOperationCompletedHandler_1__IStreamSocket = ^AsyncOperationCompletedHandler_1__IStreamSocket;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.Sockets.IStreamSocket>
  IAsyncOperation_1__IStreamSocket = interface;
  PIAsyncOperation_1__IStreamSocket = ^IAsyncOperation_1__IStreamSocket;

  // Windows.Networking.Sockets.ISocketActivityContext
  ISocketActivityContext = interface;
  PISocketActivityContext = ^ISocketActivityContext;

  // Windows.Networking.Sockets.IMessageWebSocketMessageReceivedEventArgs
  IMessageWebSocketMessageReceivedEventArgs = interface;
  PIMessageWebSocketMessageReceivedEventArgs = ^IMessageWebSocketMessageReceivedEventArgs;

  // Windows.Networking.Sockets.IWebSocketClosedEventArgs
  IWebSocketClosedEventArgs = interface;
  PIWebSocketClosedEventArgs = ^IWebSocketClosedEventArgs;

  // Windows.Networking.Sockets.IDatagramSocketControl2
  IDatagramSocketControl2 = interface;
  PIDatagramSocketControl2 = ^IDatagramSocketControl2;

  // Windows.Networking.Sockets.IDatagramSocketControl3
  IDatagramSocketControl3 = interface;
  PIDatagramSocketControl3 = ^IDatagramSocketControl3;

  // Windows.Networking.Sockets.IDatagramSocketStatics
  IDatagramSocketStatics = interface;
  PIDatagramSocketStatics = ^IDatagramSocketStatics;

  // Windows.Networking.Sockets.IDatagramSocket2
  IDatagramSocket2 = interface;
  PIDatagramSocket2 = ^IDatagramSocket2;

  // Windows.Networking.Sockets.IDatagramSocket3
  IDatagramSocket3 = interface;
  PIDatagramSocket3 = ^IDatagramSocket3;

  // Windows.Networking.Sockets.IStreamSocketInformation2
  IStreamSocketInformation2 = interface;
  PIStreamSocketInformation2 = ^IStreamSocketInformation2;

  // Windows.Networking.Sockets.IStreamSocketControl2
  IStreamSocketControl2 = interface;
  PIStreamSocketControl2 = ^IStreamSocketControl2;

  // Windows.Networking.Sockets.IStreamSocketControl3
  IStreamSocketControl3 = interface;
  PIStreamSocketControl3 = ^IStreamSocketControl3;

  // Windows.Networking.Sockets.IStreamSocket2
  IStreamSocket2 = interface;
  PIStreamSocket2 = ^IStreamSocket2;

  // Windows.Networking.Sockets.IStreamSocket3
  IStreamSocket3 = interface;
  PIStreamSocket3 = ^IStreamSocket3;

  // Windows.Networking.Sockets.IStreamSocketListenerControl2
  IStreamSocketListenerControl2 = interface;
  PIStreamSocketListenerControl2 = ^IStreamSocketListenerControl2;

  // Windows.Networking.Sockets.IStreamSocketListener2
  IStreamSocketListener2 = interface;
  PIStreamSocketListener2 = ^IStreamSocketListener2;

  // Windows.Networking.Sockets.IStreamSocketListener3
  IStreamSocketListener3 = interface;
  PIStreamSocketListener3 = ^IStreamSocketListener3;

  // Windows.Networking.Sockets.IWebSocketControl
  IWebSocketControl = interface;
  PIWebSocketControl = ^IWebSocketControl;

  // Windows.Networking.Sockets.IWebSocketInformation
  IWebSocketInformation = interface;
  PIWebSocketInformation = ^IWebSocketInformation;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.Sockets.IWebSocket,Windows.Networking.Sockets.IWebSocketClosedEventArgs>
  TypedEventHandler_2__IWebSocket__IWebSocketClosedEventArgs = interface;
  PTypedEventHandler_2__IWebSocket__IWebSocketClosedEventArgs = ^TypedEventHandler_2__IWebSocket__IWebSocketClosedEventArgs;

  // Windows.Networking.Sockets.IWebSocket
  IWebSocket = interface;
  PIWebSocket = ^IWebSocket;

  // Windows.Networking.Sockets.IMessageWebSocketControl
  IMessageWebSocketControl = interface;
  PIMessageWebSocketControl = ^IMessageWebSocketControl;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.Sockets.IMessageWebSocket,Windows.Networking.Sockets.IMessageWebSocketMessageReceivedEventArgs>
  TypedEventHandler_2__IMessageWebSocket__IMessageWebSocketMessageReceivedEventArgs = interface;
  PTypedEventHandler_2__IMessageWebSocket__IMessageWebSocketMessageReceivedEventArgs = ^TypedEventHandler_2__IMessageWebSocket__IMessageWebSocketMessageReceivedEventArgs;

  // Windows.Networking.Sockets.IMessageWebSocket
  IMessageWebSocket = interface;
  PIMessageWebSocket = ^IMessageWebSocket;

  // Windows.Networking.Sockets.IStreamWebSocketControl
  IStreamWebSocketControl = interface;
  PIStreamWebSocketControl = ^IStreamWebSocketControl;

  // Windows.Networking.Sockets.IStreamWebSocket
  IStreamWebSocket = interface;
  PIStreamWebSocket = ^IStreamWebSocket;

  // Windows.Networking.Sockets.ISocketErrorStatics
  ISocketErrorStatics = interface;
  PISocketErrorStatics = ^ISocketErrorStatics;

  // Windows.Networking.Sockets.IWebSocketErrorStatics
  IWebSocketErrorStatics = interface;
  PIWebSocketErrorStatics = ^IWebSocketErrorStatics;

  // Windows.Networking.Sockets.IControlChannelTriggerResetEventDetails
  IControlChannelTriggerResetEventDetails = interface;
  PIControlChannelTriggerResetEventDetails = ^IControlChannelTriggerResetEventDetails;


  // Emit Forwarded interfaces
  // Windows.Networking.Sockets Interfaces
  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketListenerControl
  [WinRTClassNameAttribute(SStreamSocketListenerControl)]
  IStreamSocketListenerControl = interface(IInspectable)
  ['{20D8C576-8D8A-4DBA-9722-A16C4D984980}']
    function get_QualityOfService: SocketQualityOfService; safecall;
    procedure put_QualityOfService(value: SocketQualityOfService); safecall;
    property QualityOfService: SocketQualityOfService read get_QualityOfService write put_QualityOfService;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketListenerInformation
  [WinRTClassNameAttribute(SStreamSocketListenerInformation)]
  IStreamSocketListenerInformation = interface(IInspectable)
  ['{E62BA82F-A63A-430B-BF62-29E93E5633B4}']
    function get_LocalPort: HSTRING; safecall;
    property LocalPort: HSTRING read get_LocalPort;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketControl
  [WinRTClassNameAttribute(SStreamSocketControl)]
  IStreamSocketControl = interface(IInspectable)
  ['{FE25ADF1-92AB-4AF3-9992-0F4C85E36CC4}']
    function get_NoDelay: Boolean; safecall;
    procedure put_NoDelay(value: Boolean); safecall;
    function get_KeepAlive: Boolean; safecall;
    procedure put_KeepAlive(value: Boolean); safecall;
    function get_OutboundBufferSizeInBytes: Cardinal; safecall;
    procedure put_OutboundBufferSizeInBytes(value: Cardinal); safecall;
    function get_QualityOfService: SocketQualityOfService; safecall;
    procedure put_QualityOfService(value: SocketQualityOfService); safecall;
    function get_OutboundUnicastHopLimit: Byte; safecall;
    procedure put_OutboundUnicastHopLimit(value: Byte); safecall;
    property KeepAlive: Boolean read get_KeepAlive write put_KeepAlive;
    property NoDelay: Boolean read get_NoDelay write put_NoDelay;
    property OutboundBufferSizeInBytes: Cardinal read get_OutboundBufferSizeInBytes write put_OutboundBufferSizeInBytes;
    property OutboundUnicastHopLimit: Byte read get_OutboundUnicastHopLimit write put_OutboundUnicastHopLimit;
    property QualityOfService: SocketQualityOfService read get_QualityOfService write put_QualityOfService;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketInformation
  [WinRTClassNameAttribute(SStreamSocketInformation)]
  IStreamSocketInformation = interface(IInspectable)
  ['{3B80AE30-5E68-4205-88F0-DC85D2E25DED}']
    function get_LocalAddress: IHostName; safecall;
    function get_LocalPort: HSTRING; safecall;
    function get_RemoteHostName: IHostName; safecall;
    function get_RemoteAddress: IHostName; safecall;
    function get_RemoteServiceName: HSTRING; safecall;
    function get_RemotePort: HSTRING; safecall;
    function get_RoundTripTimeStatistics: RoundTripTimeStatistics; safecall;
    function get_BandwidthStatistics: BandwidthStatistics; safecall;
    function get_ProtectionLevel: SocketProtectionLevel; safecall;
    function get_SessionKey: IBuffer; safecall;
    property BandwidthStatistics: BandwidthStatistics read get_BandwidthStatistics;
    property LocalAddress: IHostName read get_LocalAddress;
    property LocalPort: HSTRING read get_LocalPort;
    property ProtectionLevel: SocketProtectionLevel read get_ProtectionLevel;
    property RemoteAddress: IHostName read get_RemoteAddress;
    property RemoteHostName: IHostName read get_RemoteHostName;
    property RemotePort: HSTRING read get_RemotePort;
    property RemoteServiceName: HSTRING read get_RemoteServiceName;
    property RoundTripTimeStatistics: RoundTripTimeStatistics read get_RoundTripTimeStatistics;
    property SessionKey: IBuffer read get_SessionKey;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocket
  [WinRTClassNameAttribute(SStreamSocket)]
  IStreamSocket = interface(IInspectable)
  ['{69A22CF3-FC7B-4857-AF38-F6E7DE6A5B49}']
    function get_Control: IStreamSocketControl; safecall;
    function get_Information: IStreamSocketInformation; safecall;
    function get_InputStream: IInputStream; safecall;
    function get_OutputStream: IOutputStream; safecall;
    function ConnectAsync(endpointPair: IEndpointPair): IAsyncAction; overload; safecall;
    function ConnectAsync(remoteHostName: IHostName; remoteServiceName: HSTRING): IAsyncAction; overload; safecall;
    function ConnectAsync(endpointPair: IEndpointPair; protectionLevel: SocketProtectionLevel): IAsyncAction; overload; safecall;
    function ConnectAsync(remoteHostName: IHostName; remoteServiceName: HSTRING; protectionLevel: SocketProtectionLevel): IAsyncAction; overload; safecall;
    function UpgradeToSslAsync(protectionLevel: SocketProtectionLevel; validationHostName: IHostName): IAsyncAction; safecall;
    property Control: IStreamSocketControl read get_Control;
    property Information: IStreamSocketInformation read get_Information;
    property InputStream: IInputStream read get_InputStream;
    property OutputStream: IOutputStream read get_OutputStream;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketListenerConnectionReceivedEventArgs
  [WinRTClassNameAttribute(SStreamSocketListenerConnectionReceivedEventArgs)]
  IStreamSocketListenerConnectionReceivedEventArgs = interface(IInspectable)
  ['{0C472EA9-373F-447B-85B1-DDD4548803BA}']
    function get_Socket: IStreamSocket; safecall;
    property Socket: IStreamSocket read get_Socket;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.Sockets.IStreamSocketListener,Windows.Networking.Sockets.IStreamSocketListenerConnectionReceivedEventArgs>
  TypedEventHandler_2__IStreamSocketListener__IStreamSocketListenerConnectionReceivedEventArgs_Delegate_Base = interface(IUnknown)
  ['{33D00D41-C94F-5A61-9AB7-280DCEFA0B08}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.Sockets.IStreamSocketListener,Windows.Networking.Sockets.IStreamSocketListenerConnectionReceivedEventArgs>
  TypedEventHandler_2__IStreamSocketListener__IStreamSocketListenerConnectionReceivedEventArgs = interface(TypedEventHandler_2__IStreamSocketListener__IStreamSocketListenerConnectionReceivedEventArgs_Delegate_Base)
  ['{53211835-FF9E-59A6-AB04-69DD8BA5D368}']
    procedure Invoke(sender: IStreamSocketListener; args: IStreamSocketListenerConnectionReceivedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketListener
  [WinRTClassNameAttribute(SStreamSocketListener)]
  IStreamSocketListener = interface(IInspectable)
  ['{FF513437-DF9F-4DF0-BF82-0EC5D7B35AAE}']
    function get_Control: IStreamSocketListenerControl; safecall;
    function get_Information: IStreamSocketListenerInformation; safecall;
    function BindServiceNameAsync(localServiceName: HSTRING): IAsyncAction; safecall;
    function BindEndpointAsync(localHostName: IHostName; localServiceName: HSTRING): IAsyncAction; safecall;
    function add_ConnectionReceived(eventHandler: TypedEventHandler_2__IStreamSocketListener__IStreamSocketListenerConnectionReceivedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ConnectionReceived(eventCookie: EventRegistrationToken); safecall;
    property Control: IStreamSocketListenerControl read get_Control;
    property Information: IStreamSocketListenerInformation read get_Information;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IDatagramSocketControl
  [WinRTClassNameAttribute(SDatagramSocketControl)]
  IDatagramSocketControl = interface(IInspectable)
  ['{52AC3F2E-349A-4135-BB58-B79B2647D390}']
    function get_QualityOfService: SocketQualityOfService; safecall;
    procedure put_QualityOfService(value: SocketQualityOfService); safecall;
    function get_OutboundUnicastHopLimit: Byte; safecall;
    procedure put_OutboundUnicastHopLimit(value: Byte); safecall;
    property OutboundUnicastHopLimit: Byte read get_OutboundUnicastHopLimit write put_OutboundUnicastHopLimit;
    property QualityOfService: SocketQualityOfService read get_QualityOfService write put_QualityOfService;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IDatagramSocketInformation
  [WinRTClassNameAttribute(SDatagramSocketInformation)]
  IDatagramSocketInformation = interface(IInspectable)
  ['{5F1A569A-55FB-48CD-9706-7A974F7B1585}']
    function get_LocalAddress: IHostName; safecall;
    function get_LocalPort: HSTRING; safecall;
    function get_RemoteAddress: IHostName; safecall;
    function get_RemotePort: HSTRING; safecall;
    property LocalAddress: IHostName read get_LocalAddress;
    property LocalPort: HSTRING read get_LocalPort;
    property RemoteAddress: IHostName read get_RemoteAddress;
    property RemotePort: HSTRING read get_RemotePort;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IDatagramSocketMessageReceivedEventArgs
  [WinRTClassNameAttribute(SDatagramSocketMessageReceivedEventArgs)]
  IDatagramSocketMessageReceivedEventArgs = interface(IInspectable)
  ['{9E2DDCA2-1712-4CE4-B179-8C652C6D107E}']
    function get_RemoteAddress: IHostName; safecall;
    function get_RemotePort: HSTRING; safecall;
    function get_LocalAddress: IHostName; safecall;
    function GetDataReader: IDataReader; safecall;
    function GetDataStream: IInputStream; safecall;
    property LocalAddress: IHostName read get_LocalAddress;
    property RemoteAddress: IHostName read get_RemoteAddress;
    property RemotePort: HSTRING read get_RemotePort;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.Sockets.IDatagramSocket,Windows.Networking.Sockets.IDatagramSocketMessageReceivedEventArgs>
  TypedEventHandler_2__IDatagramSocket__IDatagramSocketMessageReceivedEventArgs_Delegate_Base = interface(IUnknown)
  ['{4482E19B-2389-5767-9B0B-8D7A8EF55743}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.Sockets.IDatagramSocket,Windows.Networking.Sockets.IDatagramSocketMessageReceivedEventArgs>
  TypedEventHandler_2__IDatagramSocket__IDatagramSocketMessageReceivedEventArgs = interface(TypedEventHandler_2__IDatagramSocket__IDatagramSocketMessageReceivedEventArgs_Delegate_Base)
  ['{0A89BF8D-AD86-5D61-957C-6E8AC88380B4}']
    procedure Invoke(sender: IDatagramSocket; args: IDatagramSocketMessageReceivedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IDatagramSocket
  [WinRTClassNameAttribute(SDatagramSocket)]
  IDatagramSocket = interface(IInspectable)
  ['{7FE25BBB-C3BC-4677-8446-CA28A465A3AF}']
    function get_Control: IDatagramSocketControl; safecall;
    function get_Information: IDatagramSocketInformation; safecall;
    function get_OutputStream: IOutputStream; safecall;
    function ConnectAsync(remoteHostName: IHostName; remoteServiceName: HSTRING): IAsyncAction; overload; safecall;
    function ConnectAsync(endpointPair: IEndpointPair): IAsyncAction; overload; safecall;
    function BindServiceNameAsync(localServiceName: HSTRING): IAsyncAction; safecall;
    function BindEndpointAsync(localHostName: IHostName; localServiceName: HSTRING): IAsyncAction; safecall;
    procedure JoinMulticastGroup(host: IHostName); safecall;
    function GetOutputStreamAsync(remoteHostName: IHostName; remoteServiceName: HSTRING): IAsyncOperation_1__IOutputStream; overload; safecall;
    function GetOutputStreamAsync(endpointPair: IEndpointPair): IAsyncOperation_1__IOutputStream; overload; safecall;
    function add_MessageReceived(eventHandler: TypedEventHandler_2__IDatagramSocket__IDatagramSocketMessageReceivedEventArgs): EventRegistrationToken; safecall;
    procedure remove_MessageReceived(eventCookie: EventRegistrationToken); safecall;
    property Control: IDatagramSocketControl read get_Control;
    property Information: IDatagramSocketInformation read get_Information;
    property OutputStream: IOutputStream read get_OutputStream;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.Sockets.IStreamSocket>
  AsyncOperationCompletedHandler_1__IStreamSocket_Delegate_Base = interface(IUnknown)
  ['{71B5D99E-3854-5E9A-B4DC-D1B58BF198FC}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.Sockets.IStreamSocket>
  AsyncOperationCompletedHandler_1__IStreamSocket = interface(AsyncOperationCompletedHandler_1__IStreamSocket_Delegate_Base)
  ['{A5755FC7-E478-5709-91EB-F4DE6C94B875}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IStreamSocket; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.Sockets.IStreamSocket>
  IAsyncOperation_1__IStreamSocket_Base = interface(IInspectable)
  ['{FB3E3D3C-6FE5-5E27-A132-902247E2A93E}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.Sockets.IStreamSocket>
  IAsyncOperation_1__IStreamSocket = interface(IAsyncOperation_1__IStreamSocket_Base)
  ['{673D41A9-FA65-5D68-A1A0-DC2E97A32F4A}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IStreamSocket); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IStreamSocket; safecall;
    function GetResults: IStreamSocket; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IStreamSocket read get_Completed write put_Completed;
  end;

  // Windows.Networking.Sockets.ISocketActivityContext
  ISocketActivityContext = interface(IInspectable)
  ['{43B04D64-4C85-4396-A637-1D973F6EBD49}']
    function get_Data: IBuffer; safecall;
    property Data: IBuffer read get_Data;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IMessageWebSocketMessageReceivedEventArgs
  [WinRTClassNameAttribute(SMessageWebSocketMessageReceivedEventArgs)]
  IMessageWebSocketMessageReceivedEventArgs = interface(IInspectable)
  ['{478C22AC-4C4B-42ED-9ED7-1EF9F94FA3D5}']
    function get_MessageType: SocketMessageType; safecall;
    function GetDataReader: IDataReader; safecall;
    function GetDataStream: IInputStream; safecall;
    property MessageType: SocketMessageType read get_MessageType;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IWebSocketClosedEventArgs
  [WinRTClassNameAttribute(SWebSocketClosedEventArgs)]
  IWebSocketClosedEventArgs = interface(IInspectable)
  ['{CEB78D07-D0A8-4703-A091-C8C2C0915BC3}']
    function get_Code: Word; safecall;
    function get_Reason: HSTRING; safecall;
    property Code: Word read get_Code;
    property Reason: HSTRING read get_Reason;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IDatagramSocketControl2
  IDatagramSocketControl2 = interface(IInspectable)
  ['{33EAD5C2-979C-4415-82A1-3CFAF646C192}']
    function get_InboundBufferSizeInBytes: Cardinal; safecall;
    procedure put_InboundBufferSizeInBytes(value: Cardinal); safecall;
    function get_DontFragment: Boolean; safecall;
    procedure put_DontFragment(value: Boolean); safecall;
    property DontFragment: Boolean read get_DontFragment write put_DontFragment;
    property InboundBufferSizeInBytes: Cardinal read get_InboundBufferSizeInBytes write put_InboundBufferSizeInBytes;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IDatagramSocketControl3
  IDatagramSocketControl3 = interface(IInspectable)
  ['{D4EB8256-1F6D-4598-9B57-D42A001DF349}']
    function get_MulticastOnly: Boolean; safecall;
    procedure put_MulticastOnly(value: Boolean); safecall;
    property MulticastOnly: Boolean read get_MulticastOnly write put_MulticastOnly;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IDatagramSocketStatics
  [WinRTClassNameAttribute(SDatagramSocket)]
  IDatagramSocketStatics = interface(IInspectable)
  ['{E9C62AEE-1494-4A21-BB7E-8589FC751D9D}']
    function GetEndpointPairsAsync(remoteHostName: IHostName; remoteServiceName: HSTRING): IAsyncOperation_1__IVectorView_1__IEndpointPair; overload; safecall;
    function GetEndpointPairsAsync(remoteHostName: IHostName; remoteServiceName: HSTRING; sortOptions: HostNameSortOptions): IAsyncOperation_1__IVectorView_1__IEndpointPair; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IDatagramSocket2
  IDatagramSocket2 = interface(IInspectable)
  ['{D83BA354-9A9D-4185-A20A-1424C9C2A7CD}']
    function BindServiceNameAsync(localServiceName: HSTRING; adapter: INetworkAdapter): IAsyncAction; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IDatagramSocket3
  IDatagramSocket3 = interface(IInspectable)
  ['{37544F09-AB92-4306-9AC1-0C381283D9C6}']
    function CancelIOAsync: IAsyncAction; safecall;
    procedure EnableTransferOwnership(taskId: TGuid); overload; safecall;
    procedure EnableTransferOwnership(taskId: TGuid; connectedStandbyAction: SocketActivityConnectedStandbyAction); overload; safecall;
    procedure TransferOwnership(socketId: HSTRING); overload; safecall;
    procedure TransferOwnership(socketId: HSTRING; data: ISocketActivityContext); overload; safecall;
    procedure TransferOwnership(socketId: HSTRING; data: ISocketActivityContext; keepAliveTime: TimeSpan); overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketInformation2
  IStreamSocketInformation2 = interface(IInspectable)
  ['{12C28452-4BDC-4EE4-976A-CF130E9D92E3}']
    function get_ServerCertificateErrorSeverity: SocketSslErrorSeverity; safecall;
    function get_ServerCertificateErrors: IVectorView_1__Certificates_ChainValidationResult; safecall;
    function get_ServerCertificate: Certificates_ICertificate; safecall;
    function get_ServerIntermediateCertificates: IVectorView_1__Certificates_ICertificate; safecall;
    property ServerCertificate: Certificates_ICertificate read get_ServerCertificate;
    property ServerCertificateErrorSeverity: SocketSslErrorSeverity read get_ServerCertificateErrorSeverity;
    property ServerCertificateErrors: IVectorView_1__Certificates_ChainValidationResult read get_ServerCertificateErrors;
    property ServerIntermediateCertificates: IVectorView_1__Certificates_ICertificate read get_ServerIntermediateCertificates;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketControl2
  IStreamSocketControl2 = interface(IInspectable)
  ['{C2D09A56-060F-44C1-B8E2-1FBF60BD62C5}']
    function get_IgnorableServerCertificateErrors: IVector_1__Certificates_ChainValidationResult; safecall;
    property IgnorableServerCertificateErrors: IVector_1__Certificates_ChainValidationResult read get_IgnorableServerCertificateErrors;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketControl3
  IStreamSocketControl3 = interface(IInspectable)
  ['{C56A444C-4E74-403E-894C-B31CAE5C7342}']
    function get_SerializeConnectionAttempts: Boolean; safecall;
    procedure put_SerializeConnectionAttempts(value: Boolean); safecall;
    function get_ClientCertificate: Certificates_ICertificate; safecall;
    procedure put_ClientCertificate(value: Certificates_ICertificate); safecall;
    property ClientCertificate: Certificates_ICertificate read get_ClientCertificate write put_ClientCertificate;
    property SerializeConnectionAttempts: Boolean read get_SerializeConnectionAttempts write put_SerializeConnectionAttempts;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocket2
  IStreamSocket2 = interface(IInspectable)
  ['{29D0E575-F314-4D09-ADF0-0FBD967FBD9F}']
    function ConnectAsync(remoteHostName: IHostName; remoteServiceName: HSTRING; protectionLevel: SocketProtectionLevel; adapter: INetworkAdapter): IAsyncAction; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocket3
  IStreamSocket3 = interface(IInspectable)
  ['{3F430B00-9D28-4854-BAC3-2301941EC223}']
    function CancelIOAsync: IAsyncAction; safecall;
    procedure EnableTransferOwnership(taskId: TGuid); overload; safecall;
    procedure EnableTransferOwnership(taskId: TGuid; connectedStandbyAction: SocketActivityConnectedStandbyAction); overload; safecall;
    procedure TransferOwnership(socketId: HSTRING); overload; safecall;
    procedure TransferOwnership(socketId: HSTRING; data: ISocketActivityContext); overload; safecall;
    procedure TransferOwnership(socketId: HSTRING; data: ISocketActivityContext; keepAliveTime: TimeSpan); overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketListenerControl2
  IStreamSocketListenerControl2 = interface(IInspectable)
  ['{948BB665-2C3E-404B-B8B0-8EB249A2B0A1}']
    function get_NoDelay: Boolean; safecall;
    procedure put_NoDelay(value: Boolean); safecall;
    function get_KeepAlive: Boolean; safecall;
    procedure put_KeepAlive(value: Boolean); safecall;
    function get_OutboundBufferSizeInBytes: Cardinal; safecall;
    procedure put_OutboundBufferSizeInBytes(value: Cardinal); safecall;
    function get_OutboundUnicastHopLimit: Byte; safecall;
    procedure put_OutboundUnicastHopLimit(value: Byte); safecall;
    property KeepAlive: Boolean read get_KeepAlive write put_KeepAlive;
    property NoDelay: Boolean read get_NoDelay write put_NoDelay;
    property OutboundBufferSizeInBytes: Cardinal read get_OutboundBufferSizeInBytes write put_OutboundBufferSizeInBytes;
    property OutboundUnicastHopLimit: Byte read get_OutboundUnicastHopLimit write put_OutboundUnicastHopLimit;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketListener2
  IStreamSocketListener2 = interface(IInspectable)
  ['{658DC13E-BB3E-4458-B232-ED1088694B98}']
    function BindServiceNameAsync(localServiceName: HSTRING; protectionLevel: SocketProtectionLevel): IAsyncAction; overload; safecall;
    function BindServiceNameAsync(localServiceName: HSTRING; protectionLevel: SocketProtectionLevel; adapter: INetworkAdapter): IAsyncAction; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamSocketListener3
  IStreamSocketListener3 = interface(IInspectable)
  ['{4798201C-BDF8-4919-8542-28D450E74507}']
    function CancelIOAsync: IAsyncAction; safecall;
    procedure EnableTransferOwnership(taskId: TGuid); overload; safecall;
    procedure EnableTransferOwnership(taskId: TGuid; connectedStandbyAction: SocketActivityConnectedStandbyAction); overload; safecall;
    procedure TransferOwnership(socketId: HSTRING); overload; safecall;
    procedure TransferOwnership(socketId: HSTRING; data: ISocketActivityContext); overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IWebSocketControl
  IWebSocketControl = interface(IInspectable)
  ['{2EC4BDC3-D9A5-455A-9811-DE24D45337E9}']
    function get_OutboundBufferSizeInBytes: Cardinal; safecall;
    procedure put_OutboundBufferSizeInBytes(value: Cardinal); safecall;
    function get_ServerCredential: IPasswordCredential; safecall;
    procedure put_ServerCredential(value: IPasswordCredential); safecall;
    function get_ProxyCredential: IPasswordCredential; safecall;
    procedure put_ProxyCredential(value: IPasswordCredential); safecall;
    function get_SupportedProtocols: IVector_1__HSTRING; safecall;
    property OutboundBufferSizeInBytes: Cardinal read get_OutboundBufferSizeInBytes write put_OutboundBufferSizeInBytes;
    property ProxyCredential: IPasswordCredential read get_ProxyCredential write put_ProxyCredential;
    property ServerCredential: IPasswordCredential read get_ServerCredential write put_ServerCredential;
    property SupportedProtocols: IVector_1__HSTRING read get_SupportedProtocols;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IWebSocketInformation
  [WinRTClassNameAttribute(SStreamWebSocketInformation)]
  IWebSocketInformation = interface(IInspectable)
  ['{5E01E316-C92A-47A5-B25F-07847639D181}']
    function get_LocalAddress: IHostName; safecall;
    function get_BandwidthStatistics: BandwidthStatistics; safecall;
    function get_Protocol: HSTRING; safecall;
    property BandwidthStatistics: BandwidthStatistics read get_BandwidthStatistics;
    property LocalAddress: IHostName read get_LocalAddress;
    property Protocol: HSTRING read get_Protocol;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.Sockets.IWebSocket,Windows.Networking.Sockets.IWebSocketClosedEventArgs>
  TypedEventHandler_2__IWebSocket__IWebSocketClosedEventArgs = interface(IUnknown)
  ['{90FF48E9-4B0F-595B-A91E-E6669261220C}']
    procedure Invoke(sender: IWebSocket; args: IWebSocketClosedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IWebSocket
  IWebSocket = interface(IInspectable)
  ['{F877396F-99B1-4E18-BC08-850C9ADF156E}']
    function get_OutputStream: IOutputStream; safecall;
    function ConnectAsync(uri: IUriRuntimeClass): IAsyncAction; safecall;
    procedure SetRequestHeader(headerName: HSTRING; headerValue: HSTRING); safecall;
    function add_Closed(eventHandler: TypedEventHandler_2__IWebSocket__IWebSocketClosedEventArgs): EventRegistrationToken; safecall;
    procedure remove_Closed(eventCookie: EventRegistrationToken); safecall;
    procedure Close(code: Word; reason: HSTRING); safecall;
    property OutputStream: IOutputStream read get_OutputStream;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IMessageWebSocketControl
  [WinRTClassNameAttribute(SMessageWebSocketControl)]
  IMessageWebSocketControl = interface(IInspectable)
  ['{8118388A-C629-4F0A-80FB-81FC05538862}']
    function get_MaxMessageSize: Cardinal; safecall;
    procedure put_MaxMessageSize(value: Cardinal); safecall;
    function get_MessageType: SocketMessageType; safecall;
    procedure put_MessageType(value: SocketMessageType); safecall;
    property MaxMessageSize: Cardinal read get_MaxMessageSize write put_MaxMessageSize;
    property MessageType: SocketMessageType read get_MessageType write put_MessageType;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.Sockets.IMessageWebSocket,Windows.Networking.Sockets.IMessageWebSocketMessageReceivedEventArgs>
  TypedEventHandler_2__IMessageWebSocket__IMessageWebSocketMessageReceivedEventArgs_Delegate_Base = interface(IUnknown)
  ['{DE980538-6DCD-52B0-802F-4B6CF59A01AB}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Networking.Sockets.IMessageWebSocket,Windows.Networking.Sockets.IMessageWebSocketMessageReceivedEventArgs>
  TypedEventHandler_2__IMessageWebSocket__IMessageWebSocketMessageReceivedEventArgs = interface(TypedEventHandler_2__IMessageWebSocket__IMessageWebSocketMessageReceivedEventArgs_Delegate_Base)
  ['{4648E17B-49F1-5F4F-ADCE-761EC022B556}']
    procedure Invoke(sender: IMessageWebSocket; args: IMessageWebSocketMessageReceivedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IMessageWebSocket
  [WinRTClassNameAttribute(SMessageWebSocket)]
  IMessageWebSocket = interface(IInspectable)
  ['{33727D08-34D5-4746-AD7B-8DDE5BC2EF88}']
    function get_Control: IMessageWebSocketControl; safecall;
    function get_Information: IWebSocketInformation; safecall;
    function add_MessageReceived(eventHandler: TypedEventHandler_2__IMessageWebSocket__IMessageWebSocketMessageReceivedEventArgs): EventRegistrationToken; safecall;
    procedure remove_MessageReceived(eventCookie: EventRegistrationToken); safecall;
    property Control: IMessageWebSocketControl read get_Control;
    property Information: IWebSocketInformation read get_Information;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamWebSocketControl
  [WinRTClassNameAttribute(SStreamWebSocketControl)]
  IStreamWebSocketControl = interface(IInspectable)
  ['{B4F478B1-A45A-48DB-953A-645B7D964C07}']
    function get_NoDelay: Boolean; safecall;
    procedure put_NoDelay(value: Boolean); safecall;
    property NoDelay: Boolean read get_NoDelay write put_NoDelay;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IStreamWebSocket
  [WinRTClassNameAttribute(SStreamWebSocket)]
  IStreamWebSocket = interface(IInspectable)
  ['{BD4A49D8-B289-45BB-97EB-C7525205A843}']
    function get_Control: IStreamWebSocketControl; safecall;
    function get_Information: IWebSocketInformation; safecall;
    function get_InputStream: IInputStream; safecall;
    property Control: IStreamWebSocketControl read get_Control;
    property Information: IWebSocketInformation read get_Information;
    property InputStream: IInputStream read get_InputStream;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.ISocketErrorStatics
  [WinRTClassNameAttribute(SSocketError)]
  ISocketErrorStatics = interface(IInspectable)
  ['{828337F4-7D56-4D8E-B7B4-A07DD7C1BCA9}']
    function GetStatus(hresult: Integer): SocketErrorStatus; safecall;
  end;

  // DualAPI Interface
  // Windows.Networking.Sockets.IWebSocketErrorStatics
  [WinRTClassNameAttribute(SWebSocketError)]
  IWebSocketErrorStatics = interface(IInspectable)
  ['{27CDF35B-1F61-4709-8E02-61283ADA4E9D}']
    function GetStatus(hresult: Integer): WebErrorStatus; safecall;
  end;

  // Windows.Networking.Sockets.IControlChannelTriggerResetEventDetails
  IControlChannelTriggerResetEventDetails = interface(IInspectable)
  ['{6851038E-8EC4-42FE-9BB2-21E91B7BFCB1}']
    function get_ResetReason: ControlChannelTriggerResetReason; safecall;
    function get_HardwareSlotReset: Boolean; safecall;
    function get_SoftwareSlotReset: Boolean; safecall;
    property HardwareSlotReset: Boolean read get_HardwareSlotReset;
    property ResetReason: ControlChannelTriggerResetReason read get_ResetReason;
    property SoftwareSlotReset: Boolean read get_SoftwareSlotReset;
  end;


  // Emit Forwarded classes
  // Windows.Networking.Sockets.DatagramSocket
  // DualAPI
  TDatagramSocket = class(TWinRTGenericImportSI<IDatagramSocketStatics, IDatagramSocket>)
  public
    // -> IDatagramSocketStatics
    class function GetEndpointPairsAsync(remoteHostName: IHostName; remoteServiceName: HSTRING): IAsyncOperation_1__IVectorView_1__IEndpointPair; overload; static; inline;
    class function GetEndpointPairsAsync(remoteHostName: IHostName; remoteServiceName: HSTRING; sortOptions: HostNameSortOptions): IAsyncOperation_1__IVectorView_1__IEndpointPair; overload; static; inline;
  end;

  // Windows.Networking.Sockets.StreamSocket
  // DualAPI
  TStreamSocket = class(TWinRTGenericImportI<IStreamSocket>) end;

  // Windows.Networking.Sockets.StreamSocketListener
  // DualAPI
  TStreamSocketListener = class(TWinRTGenericImportI<IStreamSocketListener>) end;

  // Windows.Networking.Sockets.DatagramSocketControl
  // DualAPI

  // Windows.Networking.Sockets.DatagramSocketInformation
  // DualAPI

  // Windows.Networking.Sockets.DatagramSocketMessageReceivedEventArgs
  // DualAPI

  // Windows.Networking.Sockets.StreamSocketControl
  // DualAPI

  // Windows.Networking.Sockets.StreamSocketInformation
  // DualAPI

  // Windows.Networking.Sockets.StreamSocketListenerControl
  // DualAPI

  // Windows.Networking.Sockets.StreamSocketListenerInformation
  // DualAPI

  // Windows.Networking.Sockets.StreamSocketListenerConnectionReceivedEventArgs
  // DualAPI

  // Windows.Networking.Sockets.WebSocketClosedEventArgs
  // DualAPI

  // Windows.Networking.Sockets.MessageWebSocketControl
  // DualAPI

  // Windows.Networking.Sockets.MessageWebSocketInformation
  // DualAPI

  // Windows.Networking.Sockets.MessageWebSocket
  // DualAPI
  TMessageWebSocket = class(TWinRTGenericImportI<IMessageWebSocket>) end;

  // Windows.Networking.Sockets.MessageWebSocketMessageReceivedEventArgs
  // DualAPI

  // Windows.Networking.Sockets.StreamWebSocketControl
  // DualAPI

  // Windows.Networking.Sockets.StreamWebSocketInformation
  // DualAPI

  // Windows.Networking.Sockets.StreamWebSocket
  // DualAPI
  TStreamWebSocket = class(TWinRTGenericImportI<IStreamWebSocket>) end;

  // Windows.Networking.Sockets.SocketError
  // DualAPI
  TSocketError = class(TWinRTGenericImportS<ISocketErrorStatics>)
  public
    // -> ISocketErrorStatics
    class function GetStatus(hresult: Integer): SocketErrorStatus; static; inline;
  end;

  // Windows.Networking.Sockets.WebSocketError
  // DualAPI
  TWebSocketError = class(TWinRTGenericImportS<IWebSocketErrorStatics>)
  public
    // -> IWebSocketErrorStatics
    class function GetStatus(hresult: Integer): WebErrorStatus; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TDatagramSocket }

class function TDatagramSocket.GetEndpointPairsAsync(remoteHostName: IHostName; remoteServiceName: HSTRING): IAsyncOperation_1__IVectorView_1__IEndpointPair;
begin
  Result := Statics.GetEndpointPairsAsync(remoteHostName, remoteServiceName);
end;

class function TDatagramSocket.GetEndpointPairsAsync(remoteHostName: IHostName; remoteServiceName: HSTRING; sortOptions: HostNameSortOptions): IAsyncOperation_1__IVectorView_1__IEndpointPair;
begin
  Result := Statics.GetEndpointPairsAsync(remoteHostName, remoteServiceName, sortOptions);
end;


 { TStreamSocket }

 { TStreamSocketListener }

 { TMessageWebSocket }

 { TStreamWebSocket }

 { TSocketError }

class function TSocketError.GetStatus(hresult: Integer): SocketErrorStatus;
begin
  Result := Statics.GetStatus(hresult);
end;


 { TWebSocketError }

class function TWebSocketError.GetStatus(hresult: Integer): WebErrorStatus;
begin
  Result := Statics.GetStatus(hresult);
end;



end.
