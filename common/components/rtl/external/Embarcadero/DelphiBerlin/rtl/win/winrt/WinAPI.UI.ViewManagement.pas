{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.UI.ViewManagement;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.UI,
  Winapi.UI.Core,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Devices.Enumeration,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}



type
  // Forward declare interfaces
  // Windows.Foundation.IReference`1<Windows.UI.ViewManagement.UIElementType>
  IReference_1__UIElementType = interface;
  PIReference_1__UIElementType = ^IReference_1__UIElementType;


  // Emit Forwarded interfaces
  // Windows.UI.ViewManagement Interfaces
  // Windows.Foundation.IReference`1<Windows.UI.ViewManagement.UIElementType>
  IReference_1__UIElementType = interface(IInspectable)
  ['{455ACF7B-8F11-5BB9-93BE-7A214CD5A134}']
    function get_Value: UIElementType; safecall;
    property Value: UIElementType read get_Value;
  end;


  // Emit Forwarded classes

implementation

  // Emit Classes Implementation

end.
