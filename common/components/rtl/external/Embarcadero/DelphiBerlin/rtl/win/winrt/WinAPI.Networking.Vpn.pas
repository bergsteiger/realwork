{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Networking.Vpn;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.Networking,
  Winapi.Security.Credentials,
  Winapi.Security.Cryptography,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Storage.Streams,
  Winapi.Foundation.Collections,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}



type
  // Forward declare interfaces
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.Vpn.VpnManagementErrorStatus>
  AsyncOperationCompletedHandler_1__VpnManagementErrorStatus = interface;
  PAsyncOperationCompletedHandler_1__VpnManagementErrorStatus = ^AsyncOperationCompletedHandler_1__VpnManagementErrorStatus;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.Vpn.VpnManagementErrorStatus>
  IAsyncOperation_1__VpnManagementErrorStatus = interface;
  PIAsyncOperation_1__VpnManagementErrorStatus = ^IAsyncOperation_1__VpnManagementErrorStatus;


  // Emit Forwarded interfaces
  // Windows.Networking.Vpn Interfaces
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Networking.Vpn.VpnManagementErrorStatus>
  AsyncOperationCompletedHandler_1__VpnManagementErrorStatus = interface(IUnknown)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__VpnManagementErrorStatus; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Networking.Vpn.VpnManagementErrorStatus>
  IAsyncOperation_1__VpnManagementErrorStatus = interface(IInspectable)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__VpnManagementErrorStatus); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__VpnManagementErrorStatus; safecall;
    function GetResults: VpnManagementErrorStatus; safecall;
    property Completed: AsyncOperationCompletedHandler_1__VpnManagementErrorStatus read get_Completed write put_Completed;
  end;


  // Emit Forwarded classes

implementation

  // Emit Classes Implementation

end.
