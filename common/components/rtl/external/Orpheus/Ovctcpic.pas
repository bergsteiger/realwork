{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCTCPIC.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTCPic;
  {-Orpheus Table Cell - Picture field type}

interface

uses
  {$IFDEF Win32}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  SysUtils, Messages,
  Graphics, Classes, Controls, Forms, StdCtrls, Menus,
  OvcData, OvcConst, OvcBase, OvcCaret, OvcColor,
  OvcCmd, OvcEF, OvcPF,
  OvcTCmmn, OvcTCell, OvcTGRes, OvcTable, OvcTCStr, OvcTCBEF;

type
  {The editor class for TOvcTCPictureField cell components}
  TOvcTCPictureFieldEdit = class(TOvcPictureField)
    protected {private}
      {.Z+}
      FCell : TOvcBaseTableCell;
      {.Z-}

    protected
      {.Z+}
      procedure efMoveFocusToNextField; override;
      procedure efMoveFocusToPrevField; override;

      procedure WMChar(var Msg : TWMKey); message WM_CHAR;
      procedure WMGetDlgCode(var Msg : TMessage); message WM_GETDLGCODE;
      procedure WMKeyDown(var Msg : TWMKey); message WM_KEYDOWN;
      procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
      procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
      {.Z-}

    public
      property CellOwner : TOvcBaseTableCell
         read FCell write FCell;
  end;

  {The picture field cell component class}
  TOvcTCCustomPictureField = class(TOvcTCBaseEntryField)
    protected
      {.Z+}
      function GetCellEditor : TControl; override;
      function GetDataType : TPictureDataType;
      function GetEpoch : integer;
      function GetPictureMask : string;

      procedure SetDataType(DT : TPictureDataType);
      procedure SetEpoch(E : integer);
      procedure SetPictureMask(const PM : string);
      {.Z-}

      property DataType : TPictureDataType
         read GetDataType write SetDataType;

      property Epoch : integer
         read GetEpoch write SetEpoch;

      property PictureMask : string
         read GetPictureMask write SetPictureMask;

    public
      function CreateEntryField(AOwner : TComponent) : TOvcBaseEntryField; override;
  end;

  TOvcTCPictureField = class(TOvcTCCustomPictureField)
    published
      {inherited from ancestor}
      property DataType;
      property PictureMask;
      property MaxLength;

      property Access;
      property Adjust;
      property AutoAdvanceChar;
      property AutoAdvanceLeftRight;
      property AutoSelect;
      property BeepOnError;
      property CaretIns;
      property CaretOvr;
      property CaretToEnd;
      property Color;
      property ControlCharColor;
      property DecimalPlaces;
      property Epoch;
      property Font;
      property ForceInsert;
      property ForceOvertype;
      property HighlightColors;
      property Hint;
      property InsertPushes;
      property Margin;
      property PadChar;
      property PasswordChar;
      property PasswordMode;
      property RangeHi stored False;
      property RangeLo stored False;
      property RightAlign;                                      {!!.10}
      property RightJustify;
      property ShowHint;
      property StripLiterals;
      property Table;
      property TableColor;
      property TableFont;
      property TextHiColor;
      property TextMargin;
      property TextStyle;
      property TrimBlanks;

      {events inherited from custom ancestor}
      property OnChange;
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnEnter;
      property OnError;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnOwnerDraw;
      property OnUserCommand;
      property OnUserValidation;
  end;


implementation


{===TOvcTCCustomPictureField=========================================}
function TOvcTCCustomPictureField.CreateEntryField(AOwner : TComponent) : TOvcBaseEntryField;
  begin
    Result := TOvcTCPictureFieldEdit.Create(AOwner);
    TOvcTCPictureFieldEdit(Result).CellOwner := Self;
  end;
{--------}
function TOvcTCCustomPictureField.GetCellEditor : TControl;
  begin
    Result := FEdit;
  end;
{--------}
function TOvcTCCustomPictureField.GetDataType : TPictureDataType;
  begin
    if Assigned(FEdit) then
      Result := TOvcTCPictureFieldEdit(FEdit).DataType
    else
      Result := pftString;
  end;
{--------}
function TOvcTCCustomPictureField.GetEpoch : integer;
  begin
    if Assigned(FEdit) then
      Result := TOvcTCPictureFieldEdit(FEdit).Epoch
    else
      Result := 0;
  end;
{--------}
function TOvcTCCustomPictureField.GetPictureMask : string;
  begin
    if Assigned(FEdit) then
      Result := TOvcTCPictureFieldEdit(FEdit).PictureMask
    else
      Result := 'XXXXXXXXXXXXXXX';
  end;
{--------}
procedure TOvcTCCustomPictureField.SetDataType(DT : TPictureDataType);
  begin
    if Assigned(FEdit) then
      begin
        TOvcTCPictureFieldEdit(FEdit).DataType := DT;
        TOvcTCPictureFieldEdit(FEditDisplay).DataType := DT;
      end;
  end;
{--------}
procedure TOvcTCCustomPictureField.SetEpoch(E : integer);
  begin
    if Assigned(FEdit) then
      begin
        TOvcTCPictureFieldEdit(FEdit).Epoch := E;
        TOvcTCPictureFieldEdit(FEditDisplay).Epoch := E;
      end;
  end;
{--------}
procedure TOvcTCCustomPictureField.SetPictureMask(const PM : string);
  begin
    if Assigned(FEdit) then
      begin
        TOvcTCPictureFieldEdit(FEdit).PictureMask := PM;
        TOvcTCPictureFieldEdit(FEditDisplay).PictureMask := PM;
        {force re-initialization of internal flags}                    {!!.13}
        TOvcTCPictureFieldEdit(FEdit).RecreateWnd;                     {!!.13}
        TOvcTCPictureFieldEdit(FEditDisplay).RecreateWnd;              {!!.13}
      end;
  end;
{====================================================================}


{===TOvcTCPictureFieldEdit==============================================}
procedure TOvcTCPictureFieldEdit.efMoveFocusToNextField;
  var
    Msg : TWMKey;
  begin
    FillChar(Msg, sizeof(Msg), 0);
    with Msg do
      begin
        Msg := WM_KEYDOWN;
        CharCode := VK_RIGHT;
      end;
    CellOwner.SendKeyToTable(Msg);
  end;
{--------}
procedure TOvcTCPictureFieldEdit.efMoveFocusToPrevField;
  var
    Msg : TWMKey;
  begin
    FillChar(Msg, sizeof(Msg), 0);
    with Msg do
      begin
        Msg := WM_KEYDOWN;
        CharCode := VK_LEFT;
      end;
    CellOwner.SendKeyToTable(Msg);
  end;
{--------}
procedure TOvcTCPictureFieldEdit.WMChar(var Msg : TWMKey);
  begin
    if (Msg.CharCode <> 9) then {filter tab characters}
      inherited;
  end;
{--------}
procedure TOvcTCPictureFieldEdit.WMGetDlgCode(var Msg : TMessage);
  begin
    inherited;
    if CellOwner.TableWantsTab then
      Msg.Result := Msg.Result or DLGC_WANTTAB;
    if CellOwner.TableWantsEnter then
      Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
  end;
{--------}
procedure TOvcTCPictureFieldEdit.WMKeyDown(var Msg : TWMKey);
  procedure GetSelection(var S, E : word);
    type
      LH = record L, H : word; end;
    var
      GetSel : longint;
    begin
      GetSel := SendMessage(Handle, EM_GETSEL, 0, 0);
      S := LH(GetSel).L;
      E := LH(GetSel).H;
    end;
  var
    GridReply : TOvcTblKeyNeeds;
    GridUsedIt : boolean;
  begin
    GridUsedIt := false;
    GridReply := otkDontCare;
    if (CellOwner <> nil) then
      GridReply := CellOwner.FilterTableKey(Msg);
    case GridReply of
      otkMustHave :
        begin
          {the entry field must also process this key - to restore its contents}
          if (Msg.CharCode = VK_ESCAPE) then
            Restore;

          CellOwner.SendKeyToTable(Msg);
          GridUsedIt := true;
        end;
      otkWouldLike :
        case Msg.CharCode of
          VK_PRIOR, VK_NEXT, VK_UP, VK_DOWN :
            begin
              if ValidateSelf then
                begin
                  CellOwner.SendKeyToTable(Msg);
                  GridUsedIt := true;
                end;
            end;
          {Note: VK_LEFT, VK_RIGHT are processed by efMoveFocusToNext(Next)Field}
        end;
    end;{case}

    if not GridUsedIt then
      inherited;
  end;
{--------}
procedure TOvcTCPictureFieldEdit.WMKillFocus(var Msg : TWMKillFocus);
  begin
    inherited;
    CellOwner.PostMessageToTable(ctim_KillFocus, Msg.FocusedWnd, LastError);
  end;
{--------}
procedure TOvcTCPictureFieldEdit.WMSetFocus(var Msg : TWMSetFocus);
  begin
    inherited;
    CellOwner.PostMessageToTable(ctim_SetFocus, Msg.FocusedWnd, 0);
  end;
{====================================================================}

end.