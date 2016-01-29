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
{*                  OVCTCEDT.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTCEdt;
  {-Orpheus Table Cell - Windows edit Control type}

interface

uses
  {$IFDEF Win32}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  SysUtils, Messages,
  Graphics, Classes, Controls, Forms, StdCtrls, Menus,
  OvcData, OvcConst, OvcBase,
  OvcTCmmn, OvcTCell, OvcTGRes, OvcTable, OvcTCStr;

type
  TOvcTCStringEdit = class(TEdit)
    protected {private}
      {.Z+}
      FCell : TOvcBaseTableCell;
      {.Z-}

    protected
      {.Z+}
      procedure WMChar(var Msg : TWMKey); message WM_CHAR;
      procedure WMGetDlgCode(var Msg : TMessage); message WM_GETDLGCODE;
      procedure WMKeyDown(var Msg : TWMKey); message WM_KEYDOWN;
      procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
      procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;

      property CellOwner : TOvcBaseTableCell
         read FCell write FCell;
      {.Z-}
  end;

  TOvcTCCustomString = class(TOvcTCBaseString)
    protected {private}
      {.Z+}
      FEdit        : TOvcTCStringEdit;
      FMaxLength   : word;
      FAutoAdvanceChar      : boolean;
      FAutoAdvanceLeftRight : boolean;
      {.Z-}

    protected
      {.Z+}
      function GetCellEditor : TControl; override;
      function GetModified : boolean;
      {.Z-}

      property AutoAdvanceChar : boolean
         read FAutoAdvanceChar write FAutoAdvanceChar;

      property AutoAdvanceLeftRight : boolean
         read FAutoAdvanceLeftRight write FAutoAdvanceLeftRight;

      property MaxLength : word
         read FMaxLength write FMaxLength;

    public
      function CreateEditControl(AOwner : TComponent) : TOvcTCStringEdit; virtual;

      function  EditHandle : THandle; override;
      procedure EditHide; override;
      procedure EditMove(CellRect : TRect); override;

      procedure SaveEditedData(Data : pointer); override;
      procedure StartEditing(RowNum : TRowNum; ColNum : TColNum;
                             CellRect : TRect;
                       const CellAttr : TOvcCellAttributes;
                             CellStyle: TOvcTblEditorStyle;
                             Data : pointer); override;
      procedure StopEditing(SaveValue : boolean;
                            Data : pointer); override;

      property Modified : boolean
         read GetModified;
  end;

  TOvcTCString = class(TOvcTCCustomString)
    published
      {properties inherited from custom ancestor}
      property Access;
      property Adjust;
      property AutoAdvanceChar;
      property AutoAdvanceLeftRight;
      property Color;
      property Font;
      property Hint;
      property Margin;
      property MaxLength;
      property ShowHint;
      property Table;
      property TableColor;
      property TableFont;
      property TextHiColor;
      property TextStyle;
      property UseWordWrap;
      property UseASCIIZStrings;

      {events inherited from custom ancestor}
      property OnChange;
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnOwnerDraw;
    public
      constructor Create(AOwner : TComponent); override;
  end;

type
  TOvcTCMemoEdit = class(TMemo)
    protected {private}
      {.Z+}
      FCell : TOvcBaseTableCell;
      {.Z-}

    protected
      {.Z+}
      procedure WMChar(var Msg : TWMKey); message WM_CHAR;
      procedure WMGetDlgCode(var Msg : TMessage); message WM_GETDLGCODE;
      procedure WMKeyDown(var Msg : TWMKey); message WM_KEYDOWN;
      procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
      procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
      {.Z-}

      property CellOwner : TOvcBaseTableCell
         read FCell write FCell;
  end;

  TOvcTCCustomMemo = class(TOvcTCBaseString)
    protected {private}
      {.Z+}
      FEdit        : TOvcTCMemoEdit;
      FMaxLength   : word;
      FWantReturns : boolean;
      FWantTabs    : boolean;
      {.Z-}

    protected
      {.Z+}
      function GetCellEditor : TControl; override;
      function GetModified : boolean;
      {.Z-}

      property MaxLength : word
         read FMaxLength write FMaxLength;

      property WantReturns : boolean
         read FWantReturns write FWantReturns;

      property WantTabs : boolean
         read FWantTabs write FWantTabs;

    public
      constructor Create(AOwner : TComponent); override;
      function CreateEditControl(AOwner : TComponent) : TOvcTCMemoEdit; virtual;

      function  EditHandle : THandle; override;
      procedure EditHide; override;
      procedure EditMove(CellRect : TRect); override;
      procedure SaveEditedData(Data : pointer); override;              {!!.16}
      procedure StartEditing(RowNum : TRowNum; ColNum : TColNum;
                             CellRect : TRect;
                       const CellAttr : TOvcCellAttributes;
                             CellStyle: TOvcTblEditorStyle;
                             Data : pointer); override;
      procedure StopEditing(SaveValue : boolean;
                            Data : pointer); override;

      property Modified : boolean
         read GetModified;
  end;

  TOvcTCMemo = class(TOvcTCCustomMemo)
    published
      {properties inherited from custom ancestor}
      property Access;
      property Adjust;
      property Color;
      property Font;
      property Hint;
      property Margin;
      property MaxLength;
      property ShowHint;
      property Table;
      property TableColor;
      property TableFont;
      property TextHiColor;
      property TextStyle;
      property WantReturns;
      property WantTabs;

      {events inherited from custom ancestor}
      property OnChange;
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnOwnerDraw;
  end;

implementation


{===TOvcTCCustomString===============================================}
function TOvcTCCustomString.CreateEditControl(AOwner : TComponent) : TOvcTCStringEdit;
  begin
    Result := TOvcTCStringEdit.Create(AOwner);
  end;
{--------}
function TOvcTCCustomString.EditHandle : THandle;
  begin
    if Assigned(FEdit) then
      Result := FEdit.Handle
    else
      Result := 0;
  end;
{--------}
procedure TOvcTCCustomString.EditHide;
  begin
    if Assigned(FEdit) then
      with FEdit do
        begin
          SetWindowPos(FEdit.Handle, HWND_TOP,
                       0, 0, 0, 0,
                       SWP_HIDEWINDOW or SWP_NOREDRAW or SWP_NOZORDER);
        end;
  end;
{--------}
procedure TOvcTCCustomString.EditMove(CellRect : TRect);
  var
    EditHandle : HWND;
  begin
    if Assigned(FEdit) then
      begin
        EditHandle := FEdit.Handle;
        with CellRect do
          SetWindowPos(EditHandle, HWND_TOP,
                       Left, Top, Right-Left, Bottom-Top,
                       SWP_SHOWWINDOW or SWP_NOREDRAW or SWP_NOZORDER);
        InvalidateRect(EditHandle, nil, false);
        UpdateWindow(EditHandle);
      end;
  end;
{--------}
function TOvcTCCustomString.GetCellEditor : TControl;
  begin
    Result := FEdit;
  end;
{--------}
function TOvcTCCustomString.GetModified : boolean;
  begin
    if Assigned(FEdit) then
         Result := FEdit.Modified
    else Result := false;
  end ;
{--------}
procedure TOvcTCCustomString.SaveEditedData(Data : pointer);
  begin
    if Assigned(Data) then
      if UseASCIIZStrings then
        {$IfDef XE}
        assert(false)
        {$Else}
        FEdit.GetTextBuf(PAnsiChar(Data), succ(MaxLength))
        {$EndIf}
      else
        POvcShortString(Data)^ := Copy(FEdit.Text, 1, MaxLength);
  end;
{--------}
procedure TOvcTCCustomString.StartEditing(RowNum : TRowNum; ColNum : TColNum;
                                          CellRect : TRect;
                                    const CellAttr : TOvcCellAttributes;
                                          CellStyle: TOvcTblEditorStyle;
                                          Data : pointer);
  begin
    FEdit := CreateEditControl(FTable);
    with FEdit do
      begin
        if UseASCIIZStrings then
          begin
            if (Data = nil) then
              SetTextBuf('')
            else
        {$IfDef XE}
        assert(false);
        {$Else}
              SetTextBuf(PAnsiChar(Data));
              {$EndIf}
          end
        else
          begin
            if (Data = nil) then
              Text := ''
            else
              Text := POvcShortString(Data)^;
          end;
        Color := CellAttr.caColor;
        Font := CellAttr.caFont;
        Font.Color := CellAttr.caFontColor;
        Left := CellRect.Left;
        Top := CellRect.Top;
        Width := CellRect.Right - CellRect.Left;
        Height := CellRect.Bottom - CellRect.Top;
        TabStop := false;
        CellOwner := Self;
        MaxLength := Self.MaxLength;
        Hint := Self.Hint;
        ShowHint := Self.ShowHint;
        Parent := FTable;
        BorderStyle := bsNone;
        Ctl3D := false;
        case CellStyle of
          tesBorder : BorderStyle := bsSingle;
          tes3D     : Ctl3D := true;
        end;{case}

        OnChange := Self.OnChange;
        OnClick := Self.OnClick;
        OnDblClick := Self.OnDblClick;
        OnDragDrop := Self.OnDragDrop;
        OnDragOver := Self.OnDragOver;
        OnEndDrag := Self.OnEndDrag;
        OnEnter := Self.OnEnter;
        OnExit := Self.OnExit;
        OnKeyDown := Self.OnKeyDown;
        OnKeyPress := Self.OnKeyPress;
        OnKeyUp := Self.OnKeyUp;
        OnMouseDown := Self.OnMouseDown;
        OnMouseMove := Self.OnMouseMove;
        OnMouseUp := Self.OnMouseUp;
      end;
  end;
{--------}
procedure TOvcTCCustomString.StopEditing(SaveValue : boolean;
                                         Data : pointer);

  begin
    try
      if SaveValue and Assigned(Data) then
        if UseASCIIZStrings then
        {$IfDef XE}
        assert(false)
        {$Else}
          FEdit.GetTextBuf(PAnsiChar(Data), succ(MaxLength))
        {$EndIf}
        else
          POvcShortString(Data)^ := Copy(FEdit.Text, 1, MaxLength);
    finally
      FEdit.Free;
      FEdit := nil;
    end;
  end;
{====================================================================}


{===TOvcTCStringEdit===============================================}
procedure TOvcTCStringEdit.WMChar(var Msg : TWMKey);
  var
    CurText : string;
  begin
    if (Msg.CharCode <> 13) and     {Enter}
       (Msg.CharCode <> 9) and      {Tab}
       (Msg.CharCode <> 27) then    {Escape}
      inherited;
    if TOvcTCCustomString(CellOwner).AutoAdvanceChar then
      begin
        CurText := Text;
        if (length(CurText) >= MaxLength) then
          begin
            FillChar(Msg, sizeof(Msg), 0);
            with Msg do
              begin
                Msg := WM_KEYDOWN;
                CharCode := VK_RIGHT;
              end;
            CellOwner.SendKeyToTable(Msg);
          end;
      end;
  end;
{--------}
procedure TOvcTCStringEdit.WMGetDlgCode(var Msg : TMessage);
  begin
    inherited;
    if CellOwner.TableWantsTab then
      Msg.Result := Msg.Result or DLGC_WANTTAB;
    if CellOwner.TableWantsEnter then
      Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
  end;
{--------}
procedure TOvcTCStringEdit.WMKeyDown(var Msg : TWMKey);
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
    SStart, SEnd : word;
  begin
    GridUsedIt := false;
    GridReply := otkDontCare;
    if (CellOwner <> nil) then
      GridReply := CellOwner.FilterTableKey(Msg);
    case GridReply of
      otkMustHave :
        begin
          CellOwner.SendKeyToTable(Msg);
          GridUsedIt := true;
        end;
      otkWouldLike :
        case Msg.CharCode of
          VK_PRIOR, VK_NEXT, VK_UP, VK_DOWN :
            begin
              CellOwner.SendKeyToTable(Msg);
              GridUsedIt := true;
            end;
          VK_LEFT :
            if TOvcTCCustomString(CellOwner).AutoAdvanceLeftRight then
              begin
                GetSelection(SStart, SEnd);
                if (SStart = SEnd) and (SStart = 0) then
                  begin
                    CellOwner.SendKeyToTable(Msg);
                    GridUsedIt := true;
                  end;
              end;
          VK_RIGHT :
            if TOvcTCCustomString(CellOwner).AutoAdvanceLeftRight then
              begin
                GetSelection(SStart, SEnd);
                if ((SStart = SEnd) or (SStart = 0)) and (SEnd = GetTextLen) then
                  begin
                    CellOwner.SendKeyToTable(Msg);
                    GridUsedIt := true;
                  end;
              end;
        end;
    end;{case}

    if not GridUsedIt then
      inherited;
  end;
{--------}
procedure TOvcTCStringEdit.WMKillFocus(var Msg : TWMKillFocus);
  begin
    inherited;
    CellOwner.PostMessageToTable(ctim_KillFocus, Msg.FocusedWnd, 0);
  end;
{--------}
procedure TOvcTCStringEdit.WMSetFocus(var Msg : TWMSetFocus);
  begin
    inherited;
    CellOwner.PostMessageToTable(ctim_SetFocus, Msg.FocusedWnd, 0);
  end;
{====================================================================}




{===TOvcTCCustomMemo=================================================}
constructor TOvcTCCustomMemo.Create(AOwner : TComponent);
  begin
    inherited Create(AOwner);
    UseASCIIZStrings := true;
    UseWordWrap := true;
  end;
{--------}
function TOvcTCCustomMemo.CreateEditControl(AOwner : TComponent) : TOvcTCMemoEdit;
  begin
    Result := TOvcTCMemoEdit.Create(AOwner);
  end;
{--------}
function TOvcTCCustomMemo.EditHandle : THandle;
  begin
    if Assigned(FEdit) then
      Result := FEdit.Handle
    else
      Result := 0;
  end;
{--------}
procedure TOvcTCCustomMemo.EditHide;
  begin
    if Assigned(FEdit) then
      with FEdit do
        begin
          SetWindowPos(FEdit.Handle, HWND_TOP,
                       0, 0, 0, 0,
                       SWP_HIDEWINDOW or SWP_NOREDRAW or SWP_NOZORDER);
        end;
  end;
{--------}
procedure TOvcTCCustomMemo.EditMove(CellRect : TRect);
  begin
    if Assigned(FEdit) then
      begin
        with CellRect do
          SetWindowPos(FEdit.Handle, HWND_TOP,
                       Left, Top, Right-Left, Bottom-Top,
                       SWP_SHOWWINDOW or SWP_NOREDRAW or SWP_NOZORDER);
        InvalidateRect(FEdit.Handle, nil, false);
        UpdateWindow(FEdit.Handle);
      end;
  end;
{--------}
function TOvcTCCustomMemo.GetCellEditor : TControl;
  begin
    Result := FEdit;
  end;
{--------}
function TOvcTCCustomMemo.GetModified : boolean;
  begin
    if Assigned(FEdit) then
         Result := FEdit.Modified
    else Result := false;
  end ;
{--------}
procedure TOvcTCCustomMemo.StartEditing(RowNum : TRowNum; ColNum : TColNum;
                                           CellRect : TRect;
                                     const CellAttr : TOvcCellAttributes;
                                           CellStyle: TOvcTblEditorStyle;
                                           Data : pointer);
  begin
    FEdit := CreateEditControl(FTable);
    with FEdit do
      begin
        if (Data = nil) then
          SetTextBuf('')
        else
        {$IfDef XE}
        assert(false);
        {$Else}
          SetTextBuf(PAnsiChar(Data));
          {$EndIf}
        Color := CellAttr.caColor;
        Font := CellAttr.caFont;
        Font.Color := CellAttr.caFontColor;
        MaxLength := Self.MaxLength;
        WantReturns := Self.WantReturns;
        WantTabs := Self.WantTabs;
        Left := CellRect.Left;
        Top := CellRect.Top;
        Width := CellRect.Right - CellRect.Left;
        Height := CellRect.Bottom - CellRect.Top;
        Visible := true;
        TabStop := false;
        CellOwner := Self;
        Hint := Self.Hint;
        ShowHint := Self.ShowHint;
        Parent := FTable;
        BorderStyle := bsNone;
        Ctl3D := false;
        case CellStyle of
          tesBorder : BorderStyle := bsSingle;
          tes3D     : Ctl3D := true;
        end;{case}

        OnChange := Self.OnChange;
        OnClick := Self.OnClick;
        OnDblClick := Self.OnDblClick;
        OnDragDrop := Self.OnDragDrop;
        OnDragOver := Self.OnDragOver;
        OnEndDrag := Self.OnEndDrag;
        OnEnter := Self.OnEnter;
        OnExit := Self.OnExit;
        OnKeyDown := Self.OnKeyDown;
        OnKeyPress := Self.OnKeyPress;
        OnKeyUp := Self.OnKeyUp;
        OnMouseDown := Self.OnMouseDown;
        OnMouseMove := Self.OnMouseMove;
        OnMouseUp := Self.OnMouseUp;
      end;
  end;
{--------}
procedure TOvcTCCustomMemo.StopEditing(SaveValue : boolean;
                                       Data : pointer);
  begin
    try
      if SaveValue and Assigned(Data) then
        {$IfDef XE}
        assert(false);
        {$Else}
        FEdit.GetTextBuf(PAnsiChar(Data), succ(MaxLength));
        {$EndIf}
    finally
      FEdit.Free;
      FEdit := nil;
    end;
  end;

{!!.16}
procedure TOvcTCCustomMemo.SaveEditedData(Data : pointer);
begin
  {stub out abstract method so BCB doesn't see this as an abstract class}
end;

{====================================================================}


{===TOvcTCMemoEdit===============================================}
procedure TOvcTCMemoEdit.WMChar(var Msg : TWMKey);
  begin
    if (not CellOwner.TableWantsTab) or
       (Msg.CharCode <> 9) then
      inherited;
  end;
{--------}
procedure TOvcTCMemoEdit.WMGetDlgCode(var Msg : TMessage);
  begin
    inherited;
    if CellOwner.TableWantsTab then
      Msg.Result := Msg.Result or DLGC_WANTTAB;
  end;
{--------}
procedure TOvcTCMemoEdit.WMKeyDown(var Msg : TWMKey);
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
    SStart, SEnd : word;
  begin
    GridUsedIt := false;
    GridReply := otkDontCare;
    if (CellOwner <> nil) then
      GridReply := CellOwner.FilterTableKey(Msg);
    case GridReply of
      otkMustHave :
        begin
          CellOwner.SendKeyToTable(Msg);
          GridUsedIt := true;
        end;
      otkWouldLike :
        case Msg.CharCode of
          VK_RETURN :
            if not WantReturns then
              begin
                CellOwner.SendKeyToTable(Msg);
                GridUsedIt := true;
              end;
          VK_LEFT :
            begin
              GetSelection(SStart, SEnd);
              if (SStart = SEnd) and (SStart = 0) then
                begin
                  CellOwner.SendKeyToTable(Msg);
                  GridUsedIt := true;
                end;
            end;
          VK_RIGHT :
            begin
              GetSelection(SStart, SEnd);
              if ((SStart = SEnd) or (SStart = 0)) and (SEnd = GetTextLen) then
                begin
                  CellOwner.SendKeyToTable(Msg);
                  GridUsedIt := true;
                end;
            end;
        end;
    end;{case}

    if not GridUsedIt then
      inherited;
  end;
{--------}
procedure TOvcTCMemoEdit.WMKillFocus(var Msg : TWMKillFocus);
  begin
    inherited;
    CellOwner.PostMessageToTable(ctim_KillFocus, Msg.FocusedWnd, 0);
  end;
{--------}
procedure TOvcTCMemoEdit.WMSetFocus(var Msg : TWMSetFocus);
  begin
    inherited;
    CellOwner.PostMessageToTable(ctim_SetFocus, Msg.FocusedWnd, 0);
  end;
{====================================================================}

{===TOvcTCString===============================================}
constructor TOvcTCString.Create(AOwner : TComponent);
  begin
    inherited Create(AOwner);
  end;


end.