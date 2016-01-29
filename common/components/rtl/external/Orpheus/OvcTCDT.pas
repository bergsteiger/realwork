{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$G+} {286 Instructions}
{$I+} {Input/Output-Checking}
{$N+} {Numeric Coprocessor}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}

{*********************************************************}
{*                  OVCTCDT.PAS V                        *}
{*    Copyright (c) TurboPower Software Co 1995,1996     *}
{*                 All rights reserved.                  *}
{*********************************************************}

unit OvcTCDT;
  {-Orpheus Table Cell - Date Editor type}

interface

uses
  SysUtils, WinTypes, WinProcs, Messages,
  Graphics, Classes, Controls, Forms, StdCtrls, Menus,
  OvcData, OvcConst, OvcBase, OvcDt,
  OvcTCmmn, OvcTCell, OvcTGPns, OvcTable, OvcTCStr, StDate,
  ToolEdit,

  vtDateEdit
  ;

type
  TOvcTCDateEdit = class(TvtCustomDateEdit{TCustomDateEdit})
    {.Z+}
    protected {private}
      FCell     : TOvcBaseTableCell;

      {EditField : HWnd;
      PrevEditWndProc : pointer;
      NewEditWndProc  : pointer;}

    protected
      {procedure EditWindowProc(var Msg : TMessage);
      function  FilterWMKEYDOWN(var Msg : TWMKey) : boolean;

      procedure WMChar(var Msg : TWMKey); message WM_CHAR;
      procedure WMGetDlgCode(var Msg : TMessage); message WM_GETDLGCODE;
      procedure WMKeyDown(var Msg : TWMKey); message WM_KEYDOWN;}
      {.Z-}

    public
      {constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      procedure CreateWnd; override;
       }
      property CellOwner : TOvcBaseTableCell read FCell write FCell;
  end;


  TOvcTCCustomDate = class(TOvcTCBaseString)
    {.Z+}
    protected {private}
      FEdit          : TOvcTCDateEdit;
      FOnChange      : TNotifyEvent;
      FOnDropDown    : TNotifyEvent;
      FOnDrawItem    : TDrawItemEvent;
      FOnMeasureItem : TMeasureItemEvent;

    protected

      {.Z-}
      {property OnChange : TNotifyEvent read FOnChange write FOnChange;
      property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
      property OnDrawItem: TDrawItemEvent read FOnDrawItem write FOnDrawItem;
      property OnMeasureItem: TMeasureItemEvent read FOnMeasureItem write FOnMeasureItem;
       }
    public
     { constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      }
      function  EditHandle : THandle; override;
      procedure EditHide; override;
      procedure EditMove(CellRect : TRect); override;

      procedure tcPaint(TableCanvas : TCanvas;
                  const CellRect    : TRect;
                        RowNum      : TRowNum;
                        ColNum      : TColNum;
                  const CellAttr    : TOvcCellAttributes;
                        Data        : pointer); override;

     procedure StartEditing(RowNum : TRowNum; ColNum : TColNum;
                             CellRect : TRect;
                       const CellAttr : TOvcCellAttributes;
                             CellStyle: TOvcTblEditorStyle;
                             Data : pointer); override;

 {     procedure StartEditing(RowNum : TRowNum; ColNum : TColNum; CellRect : TRect;
                             const CellAttr : TOvcCellAttributes;
                             Data : pointer); override;
  }
      procedure StopEditing(SaveValue : boolean; Data : pointer); override;
  end;

  TOvcTCDate = class(TOvcTCCustomDate)
    published
      property Access;
      property Adjust;
      property Color;
      property Font;
      property Hint;
      property ShowHint;
      property Margin;
      {property MaxLength;}
      property Table;
      property TableColor;
      property TableFont;

      {events inherited from custom ancestor}
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
  end;

implementation

uses
 l3DateSt
 ;

{const
  ComboBoxHeight = 24;

const
  ComboBoxResourceCount : longint = 0;}
{var
  ComboBoxBitmap : TBitmap;
  ComboBoxButtonWidth : integer;
 }
{===TOvcTCComboBoxEdit================================================}

(*
constructor TOvcTCComboBoxEdit.Create(AOwner : TComponent);
  begin
    inherited Create(AOwner);
    NewEditWndProc := MakeObjectInstance(EditWindowProc);
  end;

destructor TOvcTCComboBoxEdit.Destroy;
  begin
    {if (Style <> csDropDownList) then
      SetWindowLong(EditField, GWL_WNDPROC, longint(PrevEditWndProc));}
    FreeObjectInstance(NewEditWndProc);
    inherited Destroy;
  end;

procedure TOvcTCComboBoxEdit.CreateWnd;
  begin
    inherited CreateWnd;

    if (Style <> csDropDownList) then
      begin
        EditField := GetWindow(Handle, GW_CHILD);
        if (Style = csSimple) then
          EditField := GetWindow(EditField, GW_HWNDNEXT);
        PrevEditWndProc := pointer(GetWindowLong(EditField, GWL_WNDPROC));
        SetWindowLong(EditField, GWL_WNDPROC, longint(NewEditWndProc));
      end;
  end;

procedure TOvcTCComboBoxEdit.EditWindowProc(var Msg : TMessage);
  var
    GridUsedIt : boolean;
    KeyMsg : TWMKey absolute Msg;
  begin
    GridUsedIt := false;
    if (Msg.Msg = WM_KEYDOWN) then
      GridUsedIt := FilterWMKEYDOWN(KeyMsg)
    else if (Msg.Msg = WM_CHAR) then                            {!!.02}
      if (KeyMsg.CharCode = 9) or                               {!!.02}
         (KeyMsg.CharCode = 13) or                              {!!.02}
         (KeyMsg.CharCode = 27) then                            {!!.02}
        GridUsedIt := true;                                     {!!.02}
    if not GridUsedIt then
      with Msg do
        Result := CallWindowProc(PrevEditWndProc, EditField, Msg, wParam, lParam); {!!.03}
  end;

function  TOvcTCComboBoxEdit.FilterWMKEYDOWN(var Msg : TWMKey) : boolean;
  procedure GetSelection(var S, E : word);
    type
      LH = record L, H : word; end;
    var
      GetSel : longint;
    begin
      GetSel := SendMessage(EditField, EM_GETSEL, 0, 0);        {!!.02}
      S := LH(GetSel).L;
      E := LH(GetSel).H;
    end;
  var
    GridReply    : TOvcTblKeyNeeds;
    SStart, SEnd : word;
    GridUsedIt   : boolean;
    PassIton     : boolean;
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
        begin
          PassItOn := false;
          case Msg.CharCode of
            VK_LEFT :
              begin
                case Style of
                  csDropDownList :
                    PassItOn := true;
                  csDropDown, csSimple :
                    if TOvcTCCustomComboBox(CellOwner).AutoAdvanceLeftRight then
                      begin
                        GetSelection(SStart, SEnd);
                        if (SStart = SEnd) and (SStart = 0) then
                          PassItOn := true;
                      end;
                end;{case}
              end;
            VK_RIGHT :
              begin
                case Style of
                  csDropDownList :
                    PassItOn := true;
                  csDropDown, csSimple :
                    if TOvcTCCustomComboBox(CellOwner).AutoAdvanceLeftRight then
                      begin
                        GetSelection(SStart, SEnd);
                        if ((SStart = SEnd) or (SStart = 0)) and
                           (SEnd = GetTextLen) then
                          PassItOn := true;
                      end;
                end;{case}
              end;
          end;{case}
          if PassItOn then
            begin
              CellOwner.SendKeyToTable(Msg);
              GridUsedIt := true;
            end;
        end;
    end;{case}
    Result := GridUsedIt;
  end;

procedure TOvcTCComboBoxEdit.WMChar(var Msg : TWMKey);
  var
    CurText : string;
  begin
    inherited;
    if TOvcTCCustomComboBox(CellOwner).AutoAdvanceChar then
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

procedure TOvcTCComboBoxEdit.WMGetDlgCode(var Msg : TMessage);
  begin
    inherited;
    if CellOwner.TableWantsTab then
      Msg.Result := Msg.Result or DLGC_WANTTAB;
    if CellOwner.TableWantsEnter then                           {!!.03}
      Msg.Result := Msg.Result or DLGC_WANTALLKEYS;             {!!.03}
  end;

procedure TOvcTCComboBoxEdit.WMKeyDown(var Msg : TWMKey);
  var
    GridUsedIt : boolean;
  begin
    if Style = csDropDownList then                              {!!.02}
      begin                                                     {!!.02}
        GridUsedIt := FilterWMKEYDOWN(Msg);
        if not GridUsedIt then
          inherited;
      end                                                       {!!.02}
    else                                                        {!!.02}
      inherited;                                                {!!.02}
  end;
 *)
{=====================================================================}

{===TOvcTCCustomComboBox==============================================}

(*
constructor TOvcTCCustomComboBox.Create(AOwner : TComponent);
  begin
    inherited Create(AOwner);
    FAcceptActivationClick := true;                             {!!.01}
  end;
{--------}
destructor TOvcTCCustomComboBox.Destroy;
  begin
    dec(ComboBoxResourceCount);
    if (ComboBoxResourceCount = 0) then
      ComboBoxBitMap.Free;
    inherited Destroy;
  end;
*)

function TOvcTCCustomDate.EditHandle : THandle;
  begin
    if Assigned(FEdit) then
      Result := FEdit.Handle
    else
      Result := 0;
  end;

procedure TOvcTCCustomDate.EditHide;
  begin
    if Assigned(FEdit) then
      with FEdit do
        begin
          WinProcs.SetWindowPos(FEdit.Handle, HWND_TOP,
                                0, 0, 0, 0,
                                SWP_HIDEWINDOW or SWP_NOREDRAW or SWP_NOZORDER);
        end;
  end;
{--------}
procedure TOvcTCCustomDate.EditMove(CellRect : TRect);
  var
    EditHandle : HWND;
    NewTop : integer;
  begin
    {This is complicated by the fact that combo boxes have a single
     set height (24)}
    if Assigned(FEdit) then
      begin
        EditHandle := FEdit.Handle;
        with CellRect do
          begin
            NewTop := Top;
            WinProcs.SetWindowPos(EditHandle, HWND_TOP,
                                  Left, NewTop, Right-Left, Bottom-Top,
                                  SWP_SHOWWINDOW or SWP_NOREDRAW or SWP_NOZORDER);
          end;
        InvalidateRect(EditHandle, nil, false);
        UpdateWindow(EditHandle);
      end;
  end;
{--------}
{procedure TOvcTCCustomDate.Paint(Canvas : TCanvas;
                                    RowNum : TRowNum; ColNum : TColNum;
                                    CellWidth, CellHeight : integer;
                                    const CellAttr : TOvcCellAttributes;
                                    Data : pointer);  }

procedure TOvcTCCustomDate.tcPaint(TableCanvas : TCanvas;
                                    const CellRect    : TRect;
                                    RowNum      : TRowNum;
                                    ColNum      : TColNum;
                                    const CellAttr    : TOvcCellAttributes;
                                    Data        : pointer); 


  var
    S : ShortString;
    {Day, Month, Year : Integer;}
  begin
    S := '';
    if (Data <> nil) and (TOVCDate(Data^) <> BadDate) then
     try
      S := l3DateToStr(OvcDateToDateTime(TOvcDate(Data^)), 'd mmmm yyyy')
     except
      S := '';
     end;
    inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, @S);

    {Paint(Canvas, RowNum, ColNum, CellWidth, CellHeight, CellAttr, @S);}
  end;

procedure TOvcTCCustomDate.StartEditing(RowNum : TRowNum; ColNum : TColNum;
                                        CellRect : TRect;
                                  const CellAttr : TOvcCellAttributes;
                                        CellStyle: TOvcTblEditorStyle;
                                        Data : pointer);

  begin
    FEdit := TOvcTCDateEdit.Create(FTable);
    with FEdit do
      begin
        Color := CellAttr.caColor;
        Left := CellRect.Left;
        {NewTop := CellRect.Top;
        Top := NewTop;}
        Top := CellRect.Top-1;
        Width := CellRect.Right - CellRect.Left;
        Height := CellRect.Bottom - CellRect.Top - 2;

        Font := CellAttr.caFont;
        Font.Color := CellAttr.caFontColor;
        {MaxLength := Self.MaxLength;}
        Hint := Self.Hint;
        ShowHint := Self.ShowHint;
        Visible := true;
        CellOwner := Self;
        TabStop := false;
        Parent := FTable;
        if (Height > CellRect.Bottom - CellRect.Top)
         then TOvcTable(FTable).Rows.Height[RowNum] := Height;
        Ctl3D := false;
        {DropDownCount := Self.DropDownCount;}
        {Sorted := Self.Sorted;}
        {Style := Self.Style;}
        {Items := Self.Items;}
        EditMask := GetDateMask;
        if Data = nil
         then Date:=0
         else Date:=OvcDateToDateTime(TOvcDate(Data^));

        BorderStyle:=bsNone;
        {OnChange := Self.OnChange;
        OnClick := Self.OnClick;
        OnDblClick := Self.OnDblClick;
        OnDragDrop := Self.OnDragDrop;
        OnDragOver := Self.OnDragOver;
        OnDrawItem := Self.OnDrawItem;
        OnDropDown := Self.OnDropDown;
        OnEndDrag := Self.OnEndDrag;
        OnEnter := Self.OnEnter;
        OnExit := Self.OnExit;
        OnKeyDown := Self.OnKeyDown;
        OnKeyPress := Self.OnKeyPress;
        OnKeyUp := Self.OnKeyUp;
        OnMeasureItem := Self.OnMeasureItem;
        OnMouseDown := Self.OnMouseDown;
        OnMouseMove := Self.OnMouseMove;
        OnMouseUp := Self.OnMouseUp;
       }
      end;
  end;
{--------}
procedure TOvcTCCustomDate.StopEditing(SaveValue : boolean; Data : pointer);
  begin
   if SaveValue and Assigned(Data) then
    begin
     TOVCDate(Data^):=DateTimeToOvcDate(FEdit.Date);
    end;
    FEdit.Free;
    FEdit := nil;
  end;
end.
