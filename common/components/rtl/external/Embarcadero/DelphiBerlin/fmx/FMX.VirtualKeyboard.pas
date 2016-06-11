{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.VirtualKeyboard;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, FMX.Types;

type
  IFMXVirtualKeyboardService = interface(IInterface)
    ['{BB6F6668-C582-42E4-A766-863C1B9139D2}']
    function ShowVirtualKeyboard(const AControl: TFmxObject): Boolean;
    function HideVirtualKeyboard: Boolean;
    procedure SetTransientState(Value: Boolean);
    ///	<summary>
    ///	  Returns the current state of the virtual keyboard (onscreen keyboard).
    ///	</summary>
    function GetVirtualKeyboardState: TVirtualKeyboardStates;
    property VirtualKeyboardState: TVirtualKeyboardStates read GetVirtualKeyboardState;
  end;

  TVirtualKeyboardToolButton = class;

{ Additional toolbar above virtual keyboard in iOS }
  IFMXVirtualKeyboardToolbarService = interface(IInterface)
    ['{CE7795C2-4399-4094-BF58-2E69CEA71D57}']
    procedure SetToolbarEnabled(const Value: Boolean);
    function IsToolbarEnabled: Boolean;
    procedure SetHideKeyboardButtonVisibility(const Value: Boolean);
    function IsHideKeyboardButtonVisible: Boolean;
    //
    function AddButton(const Title: string; ExecuteEvent: TNotifyEvent): TVirtualKeyboardToolButton;
    procedure DeleteButton(const Index: Integer);
    function ButtonsCount: Integer;
    function GetButtonByIndex(const Index: Integer): TVirtualKeyboardToolButton;
    procedure ClearButtons;
  end;

  TVirtualKeyboardToolButton = class
  private
    FTitle: string;
    FOnExecute: TNotifyEvent;
    procedure SetTitle(const Value: string);
  protected
    procedure DoChanged; virtual; abstract;
  public
    procedure DoExecute;
    //
    property Title: string read FTitle write SetTitle;
    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;
  end;

implementation

uses
  System.SysUtils
  {$IFDEF IOS}
  , FMX.VirtualKeyboard.iOS
  {$ENDIF};


{ TVirtualKeyboardToolbarButton }

procedure TVirtualKeyboardToolButton.DoExecute;
begin
  if Assigned(FOnExecute) then
    FOnExecute(Self);
end;

procedure TVirtualKeyboardToolButton.SetTitle(const Value: string);
begin
  if not SameText(FTitle, Value) then
  begin
    FTitle := Value;
    DoChanged;
  end;
end;

end.
