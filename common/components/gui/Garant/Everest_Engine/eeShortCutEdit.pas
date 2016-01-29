unit eeShortCutEdit;

{$I eeDefine.inc}

interface

uses
  Windows,
  Messages,
  Graphics,
  SysUtils,
  Classes,
  Controls,
  StdCtrls,
  Menus;

type

  TeeCustomShortCutEdit = class(TCustomEdit)
  private
   fShortCut: TShortCut;
  protected
    function  DoKeyDown(var Msg: TWMKeyDown): Boolean;
    procedure WMChar(Var Msg: TWMChar); message WM_CHAR;
    procedure WMKeyDown(Var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure WMSysKeyDown(var Msg: TWMSysKeyDown); message WM_SYSKEYDOWN;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure SetShortCut(aShortCut: TShortCut);
  public
    property ShortCut: TShortCut read fShortCut write SetShortCut;
  end;

  TeeShortCutEdit = class(TeeCustomShortCutEdit)
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

 function ShortCutToTextExt(aShortCut: TShortCut): string;
implementation

uses
 StrUtils;

var
 g_ReservedShortCutArray : array of TShortCut;

procedure Register;
begin
 RegisterComponents('Everest', [TeeShortCutEdit]);
end;

function TeeCustomShortCutEdit.DoKeyDown(var Msg: TWMKeyDown): Boolean;
var
 l_ShortCut   : TShortCut;
 l_ShiftState : TShiftState;
 i            : Integer;
begin
 Result := false;
 case Msg.CharCode of
  VK_SHIFT,
  VK_CONTROL,
  VK_MENU, //VK_ALT
  VK_CAPITAL,
  VK_NUMLOCK,
  VK_SCROLL:
  begin
   Text := '';
   Exit;
  end;
 end;
 l_ShiftState := [];
 if (GetKeyState(VK_SHIFT) and $8000) <> 0 then
  l_ShiftState := l_ShiftState + [ssShift];
 if (GetKeyState(VK_CONTROL) and $8000) <> 0 then
  l_ShiftState := l_ShiftState + [ssCtrl];
 if (GetKeyState(VK_MENU) and $8000) <> 0 then
  l_ShiftState := l_ShiftState + [ssAlt];
 l_ShortCut := Menus.ShortCut(Msg.CharCode, l_ShiftState);
 for i := 0 to Length(g_ReservedShortCutArray) - 1 do
  if l_ShortCut = g_ReservedShortCutArray[i] then
   l_ShortCut := 0;
 ShortCut := l_ShortCut;
end;

procedure TeeCustomShortCutEdit.WMChar(Var Msg: TWMChar);
begin
 Exit;
end;

procedure TeeCustomShortCutEdit.WMKeyDown(Var Msg: TWMKeyDown);
begin
 DoKeyDown(Msg);
end;

procedure TeeCustomShortCutEdit.WMSysKeyDown(var Msg: TWMSysKeyDown);
begin
 DoKeyDown(Msg);
end;

procedure TeeCustomShortCutEdit.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
 inherited;
 if csDesigning in ComponentState then
  Msg.Result := DLGC_STATIC
 else
  Msg.Result := Msg.Result or DLGC_WANTCHARS or DLGC_WANTARROWS or
                DLGC_WANTALLKEYS{ or DLGC_WANTTAB};
end;

function ShortCutToTextExt(aShortCut: TShortCut): string;
begin
 if aShortCut = 0 then
  Result := ''
 else
  Result := ShortCutToText(aShortCut);
end;

procedure TeeCustomShortCutEdit.SetShortCut(aShortCut: TShortCut);
begin
 fShortCut := aShortCut;
 Text := ShortCutToTextExt(aShortCut);
end;

procedure AddReservedShortCut(aShortCut : TShortCut);
var
 l_Length : Integer;
begin
 l_Length := Length(g_ReservedShortCutArray);
 SetLength(g_ReservedShortCutArray, l_Length + 1);
 g_ReservedShortCutArray[l_Length] := aShortCut;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\everest_engine\bcb\eeShortCutEdit.pas initialization enter'); {$EndIf}

SetLength(g_ReservedShortCutArray, 0);
AddReservedShortCut(Menus.ShortCut(115, [ssAlt])); //Alt+F4
AddReservedShortCut(Menus.ShortCut(32, [ssAlt])); //Alt+Space
//AddReservedShortCut(Menus.ShortCut(, [ssAlt])); //Alt+Tab
AddReservedShortCut(Menus.ShortCut(27, [ssAlt])); //Alt+Esc
AddReservedShortCut(Menus.ShortCut(121, [])); //F10
AddReservedShortCut(Menus.ShortCut(121, [ssShift])); //Shift+F10
AddReservedShortCut(Menus.ShortCut(27, [ssCtrl])); //Ctrl+Esc

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\everest_engine\bcb\eeShortCutEdit.pas initialization leave'); {$EndIf}
finalization

end.
