{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.UI.WebUI;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.ApplicationModel,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}



type
  // Forward declare interfaces
  // Windows.UI.WebUI.ActivatedEventHandler
  ActivatedEventHandler = interface;
  PActivatedEventHandler = ^ActivatedEventHandler;

  // Windows.UI.WebUI.ResumingEventHandler
  ResumingEventHandler = interface;
  PResumingEventHandler = ^ResumingEventHandler;


  // Emit Forwarded interfaces
  // Windows.UI.WebUI Interfaces
  // Windows.UI.WebUI.ActivatedEventHandler
  ActivatedEventHandler = interface(IUnknown)
  ['{50F1E730-C5D1-4B6B-9ADB-8A11756BE29C}']
    procedure Invoke(sender: IInspectable; eventArgs: Activation_IActivatedEventArgs); safecall;
  end;

  // Windows.UI.WebUI.ResumingEventHandler
  ResumingEventHandler = interface(IUnknown)
  ['{26599BA9-A22D-4806-A728-ACADC1D075FA}']
    procedure Invoke(sender: IInspectable); safecall;
  end;


  // Emit Forwarded classes

implementation

  // Emit Classes Implementation

end.
