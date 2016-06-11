{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.UI;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.Security.Credentials,
  Winapi.Foundation,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}



type
  // Forward declare interfaces
  // Windows.Foundation.IReference`1<Windows.UI.Color>
  IReference_1__Color = interface;
  PIReference_1__Color = ^IReference_1__Color;


  // Emit Forwarded interfaces
  // Windows.UI Interfaces
  // Windows.Foundation.IReference`1<Windows.UI.Color>
  IReference_1__Color = interface(IInspectable)
  ['{455ACF7B-8F11-5BB9-93BE-7A214CD5A134}']
    function get_Value: Color; safecall;
    property Value: Color read get_Value;
  end;


  // Emit Forwarded classes

implementation

  // Emit Classes Implementation

end.
