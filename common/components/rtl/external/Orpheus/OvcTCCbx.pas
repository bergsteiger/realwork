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
{*                  OVCTCCBX.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTCCBx;
  {-Orpheus Table Cell - combo box type}

interface

uses
  {$IFDEF Win32}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  SysUtils, Messages,
  Graphics, Classes, Controls, Forms, StdCtrls, Menus,
  OvcData, OvcConst, OvcBase, OvcMisc,
  OvcTCmmn, OvcTCell, OvcTGPns, OvcTable, OvcTCStr;

type
  TOvcTCComboBoxState = (otlbsUp, otlbsDown);

type
  TOvcTCComboBoxEdit = class(TCustomComboBox)
    protected {private}
      {.Z+}
      FCell     : TOvcBaseTableCell;

      EditField : HWnd;
      PrevEditWndProc : pointer;
      NewEditWndProc  : pointer;
      {.Z-}

    protected
      {.Z+}
      procedure EditWindowProc(var Msg : TMessage);
      function  FilterWMKEYDOWN(var Msg : TWMKey) : boolean;

      procedure WMChar(var Msg : TWMKey); message WM_CHAR;
      procedure WMGetDlgCode(var Msg : TMessage); message WM_GETDLGCODE;
      procedure WMKeyDown(var Msg : TWMKey); message WM_KEYDOWN;
      procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
      procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
      {.Z-}

    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      procedure CreateWnd; override;

      property CellOwner : TOvcBaseTableCell
         read FCell write FCell;
  end;


  TOvcTCCustomComboBox = class(TOvcTCBaseString)
    protected {private}
      {.Z+}
      {property fields - even size}
      FDropDownCount : Integer;
      FEdit          : TOvcTCComboBoxEdit;
      FItems         : TStrings;
      FMaxLength     : word;

      {property fields - odd size}
      FStyle         : TComboBoxStyle;
      FAutoAdvanceChar      : boolean;
      FAutoAdvanceLeftRight : boolean;
      FSaveStringValue : boolean;
      FSorted        : boolean;
      FShowButton    : boolean;
      FUseRunTimeItems : boolean;

      {events}
      FOnChange      : TNotifyEvent;
      FOnDropDown    : TNotifyEvent;
      FOnDrawItem    : TDrawItemEvent;
      FOnMeasureItem : TMeasureItemEvent;
      {.Z-}

    protected
      {.Z+}
      function GetCellEditor : TControl; override;

      procedure SetItems(I : TStrings);
      procedure SetShowButton(SB : boolean);
      procedure SetSorted(S : boolean);

      procedure DrawArrow(Canvas   : TCanvas;
                    const CellRect : TRect;
                    const CellAttr : TOvcCellAttributes);
      procedure DrawButton(Canvas   : TCanvas;
                     const CellRect : TRect);

      procedure tcPaint(TableCanvas : TCanvas;
                  const CellRect    : TRect;
                        RowNum      : TRowNum;
                        ColNum      : TColNum;
                  const CellAttr    : TOvcCellAttributes;
                        Data        : pointer); override;
      {.Z-}

      {properties}
      property AutoAdvanceChar : boolean
         read FAutoAdvanceChar write FAutoAdvanceChar;

      property AutoAdvanceLeftRight : boolean
         read FAutoAdvanceLeftRight write FAutoAdvanceLeftRight;

      property DropDownCount : Integer
         read FDropDownCount write FDropDownCount;

      property Items : TStrings
         read FItems write SetItems;

      property MaxLength : word
         read FMaxLength write FMaxLength;

      property SaveStringValue : boolean
         read FSaveStringValue write FSaveStringValue;

      property Sorted : boolean
         read FSorted write SetSorted;

      property ShowButton : boolean
         read FShowButton write SetShowButton
         default true;

      property Style : TComboBoxStyle
         read FStyle write FStyle;

      property UseRunTimeItems : boolean
         read FUseRunTimeItems write FUseRunTimeItems;

      {events}
      property OnChange : TNotifyEvent
         read FOnChange write FOnChange;

      property OnDropDown: TNotifyEvent
         read FOnDropDown write FOnDropDown;

      property OnDrawItem: TDrawItemEvent
         read FOnDrawItem write FOnDrawItem;

      property OnMeasureItem: TMeasureItemEvent
         read FOnMeasureItem write FOnMeasureItem;

    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      function CreateEditControl : TOvcTCComboBoxEdit; virtual;

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
  end;

  TOvcTCComboBox = class(TOvcTCCustomComboBox)
    published
      property AcceptActivationClick;
      property Access;
      property Adjust;
      property AutoAdvanceChar;
      property AutoAdvanceLeftRight;
      property Color;
      property DropDownCount default 8;
      property Font;
      property Hint;
      property Items;
      property ShowHint;
      property Margin;
      property MaxLength;
      property SaveStringValue;
      property Sorted default false;
      property ShowButton;
      property Style;
      property Table;
      property TableColor;
      property TableFont;
      property TextHiColor;
      property TextStyle;
      property UseRunTimeItems;

      {events inherited from custom ancestor}
      property OnChange;
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnDrawItem;
      property OnDropDown;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMeasureItem;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnOwnerDraw;
  end;

implementation

const
  ComboBoxHeight = 24;

{$IFDEF Win32}
var
{$ELSE}
const
{$ENDIF}
  ComboBoxResourceCount : longint = 0;

var
  ComboBoxBitmap : TBitmap;
  ComboBoxButtonWidth : Integer;

{===TOvcTCComboBoxEdit================================================}
constructor TOvcTCComboBoxEdit.Create(AOwner : TComponent);
  begin
    inherited Create(AOwner);
    NewEditWndProc := Classes.MakeObjectInstance(EditWindowProc);
  end;
{--------}
destructor TOvcTCComboBoxEdit.Destroy;
  begin
    if (Style = csDropDown) or (Style = csSimple) then          {!!.12}
      SetWindowLong(EditField, GWL_WNDPROC, longint(PrevEditWndProc));
    Classes.FreeObjectInstance(NewEditWndProc);
    inherited Destroy;
  end;
{--------}
procedure TOvcTCComboBoxEdit.CreateWnd;
  begin
    inherited CreateWnd;

    if (Style = csDropDown) or (Style = csSimple) then          {!!.12}
      begin
        EditField := GetWindow(Handle, GW_CHILD);
        if (Style = csSimple) then
          EditField := GetWindow(EditField, GW_HWNDNEXT);
        PrevEditWndProc := pointer(GetWindowLong(EditField, GWL_WNDPROC));
        SetWindowLong(EditField, GWL_WNDPROC, longint(NewEditWndProc));
      end;
  end;
{--------}
procedure TOvcTCComboBoxEdit.EditWindowProc(var Msg : TMessage);
  var
    GridUsedIt : boolean;
    KeyMsg : TWMKey absolute Msg;
  begin
    GridUsedIt := false;
    if (Msg.Msg = WM_KEYDOWN) then
      GridUsedIt := FilterWMKEYDOWN(KeyMsg)
    else if (Msg.Msg = WM_CHAR) then
      if (KeyMsg.CharCode = 9) or
         (KeyMsg.CharCode = 13) or
         (KeyMsg.CharCode = 27) then
        GridUsedIt := true;
    if not GridUsedIt then
      with Msg do
        Result := CallWindowProc(PrevEditWndProc, EditField, Msg, wParam, lParam);
  end;
{--------}
function  TOvcTCComboBoxEdit.FilterWMKEYDOWN(var Msg : TWMKey) : boolean;
  procedure GetSelection(var S, E : word);
    type
      LH = record L, H : word; end;
    var
      GetSel : longint;
    begin
      GetSel := SendMessage(EditField, EM_GETSEL, 0, 0);
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
                  csDropDown, csSimple :
                    if TOvcTCCustomComboBox(CellOwner).AutoAdvanceLeftRight then
                      begin
                        GetSelection(SStart, SEnd);
                        if (SStart = SEnd) and (SStart = 0) then
                          PassItOn := true;
                      end;
                else                                            {!!.12}
                  PassItOn := true;                             {!!.12}
                end;{case}
              end;
            VK_RIGHT :
              begin
                case Style of
                  csDropDown, csSimple :
                    if TOvcTCCustomComboBox(CellOwner).AutoAdvanceLeftRight then
                      begin
                        GetSelection(SStart, SEnd);
                        if ((SStart = SEnd) or (SStart = 0)) and
                           (SEnd = GetTextLen) then
                          PassItOn := true;
                      end;
                else                                            {!!.12}
                  PassItOn := true;                             {!!.12}
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
{--------}
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
{--------}
procedure TOvcTCComboBoxEdit.WMGetDlgCode(var Msg : TMessage);
  begin
    inherited;
    if CellOwner.TableWantsTab then
      Msg.Result := Msg.Result or DLGC_WANTTAB;
  end;
{--------}
procedure TOvcTCComboBoxEdit.WMKeyDown(var Msg : TWMKey);
  var
    GridUsedIt : boolean;
  begin
    if (Style <> csDropDown) and (Style <> csSimple) then       {!!.12}
      begin
        GridUsedIt := FilterWMKEYDOWN(Msg);
        if not GridUsedIt then
          inherited;
      end
    else
      inherited;
  end;
{--------}
procedure TOvcTCComboBoxEdit.WMKillFocus(var Msg : TWMKillFocus);
  begin
    inherited;
    {combobox posts cbn_killfocus message to table}
    if not (Owner as TOvcCustomTable).StopEditingState(true) then SetFocus;

  end;
{--------}
procedure TOvcTCComboBoxEdit.WMSetFocus(var Msg : TWMSetFocus);
  begin
    inherited;
    CellOwner.PostMessageToTable(ctim_SetFocus, Msg.FocusedWnd, 0);
  end;
{====================================================================}


{===TOvcTCCustomComboBox=============================================}
constructor TOvcTCCustomComboBox.Create(AOwner : TComponent);
  begin
    inherited Create(AOwner);
    FItems := TStringList.Create;
    FDropDownCount := 8;
    if (ComboBoxResourceCount = 0) then
      begin
        ComboBoxBitMap := TBitMap.Create;          
        ComboBoxBitMap.Handle := LoadOvcBaseBitMap('OVCTCCOMBOARROW');
        ComboBoxButtonWidth := ComboBoxBitMap.Width + 11;
      end;
    inc(ComboBoxResourceCount);
    FAcceptActivationClick := true;
    FShowButton := true;
  end;
{--------}
destructor TOvcTCCustomComboBox.Destroy;
  begin
    FItems.Free;
    dec(ComboBoxResourceCount);
    if (ComboBoxResourceCount = 0) then
      ComboBoxBitMap.Free;
    inherited Destroy;
  end;
{--------}
function TOvcTCCustomComboBox.CreateEditControl : TOvcTCComboBoxEdit;
  begin
    Result := TOvcTCComboBoxEdit.Create(FTable);
  end;
{--------}
procedure TOvcTCCustomComboBox.DrawArrow(Canvas   : TCanvas;
                                   const CellRect : TRect;
                                   const CellAttr : TOvcCellAttributes);
  var
    ArrowDim : Integer;
    X, Y     : Integer;
    LeftPoint, RightPoint, BottomPoint : TPoint;
    Width    : integer;
    Height   : integer;
    R        : TRect;
  begin
    R := CellRect;
    R.Left := R.Right - ComboBoxButtonWidth;
    Width := R.Right - R.Left;
    Height := R.Bottom - R.Top;
    with Canvas do
      begin
        Brush.Color := CellAttr.caColor;
        FillRect(R);
        Pen.Color := CellAttr.caFont.Color;
        Brush.Color := Pen.Color;
        ArrowDim := MinI(Width, Height) div 3;
        X := R.Left + (Width - ArrowDim) div 2;
        Y := R.Top + (Height - ArrowDim) div 2;
        LeftPoint := Point(X, Y);
        RightPoint := Point(X+ArrowDim, Y);
        BottomPoint := Point(X+(ArrowDim div 2), Y+ArrowDim);
        Polygon([LeftPoint, RightPoint, BottomPoint]);
      end;
  end;
{--------}
procedure TOvcTCCustomComboBox.DrawButton(Canvas       : TCanvas;
                                    const CellRect     : TRect);
  var
    EffCellWidth : Integer;
    Wd, Ht       : Integer;
    TopPixel     : Integer;
    BotPixel     : Integer;
    LeftPixel    : Integer;
    RightPixel   : Integer;
    SrcRect      : TRect;
    DestRect     : TRect;
    ButtonRect   : TRect;
  begin
    {Calculate the effective cell width (the cell width less the size
     of the button)}
    EffCellWidth := CellRect.Right - CellRect.Left - ComboBoxButtonWidth;

    {Calculate the black border's rectangle}
    LeftPixel := CellRect.Left + EffCellWidth;
    RightPixel := CellRect.Right - 1;
    TopPixel := CellRect.Top + 1;
    BotPixel := CellRect.Bottom - 1;
    ButtonRect := Rect(LeftPixel, TopPixel, RightPixel, BotPixel);

    {Paint the button}
    with Canvas do
      begin
        {FIRST: paint the black border around the button}
        Pen.Color := clBlack;
        Pen.Width := 1;
        Brush.Color := clBtnFace;
        {Note: Rectangle excludes the Right and bottom pixels}
        Rectangle(LeftPixel, TopPixel, RightPixel, BotPixel);
        {SECOND: paint the highlight border on left/top sides}
        {decrement drawing area}
        inc(TopPixel);
        dec(BotPixel);
        inc(LeftPixel);
        dec(RightPixel);
        {Note: PolyLine excludes the end points of a line segment,
               but since the end points are generally used as the
               starting point of the next we must adjust for it.}
        Pen.Color := clBtnHighlight;
        PolyLine([Point(RightPixel-1, TopPixel),
                  Point(LeftPixel, TopPixel),
                  Point(LeftPixel, BotPixel)]);
        {THIRD: paint the highlight border on bottom/right sides}
        Pen.Color := clBtnShadow;
        PolyLine([Point(LeftPixel, BotPixel-1),
                  Point(RightPixel-1, BotPixel-1),
                  Point(RightPixel-1, TopPixel-1)]);
        inc(TopPixel);
        dec(BotPixel);
        inc(LeftPixel);
        dec(RightPixel);
        PolyLine([Point(LeftPixel, BotPixel-1),
                  Point(RightPixel-1, BotPixel-1),
                  Point(RightPixel-1, TopPixel-1)]);
        {THIRD: paint the arrow bitmap}
        Wd := ComboBoxBitMap.Width;
        Ht := ComboBoxBitMap.Height;
        SrcRect := Rect(0, 0, Wd, Ht);
        with DestRect do
          begin
            Left := CellRect.Left + EffCellWidth + 5;
            Top := CellRect.Top +
                   ((CellRect.Bottom - CellRect.Top - Ht) div 2);
            Right := Left + Wd;
            Bottom := Top + Ht;
          end;
        BrushCopy(DestRect, ComboBoxBitMap, SrcRect, clSilver);
      end;
  end;
{--------}
function TOvcTCCustomComboBox.EditHandle : THandle;
  begin
    if Assigned(FEdit) then
      Result := FEdit.Handle
    else
      Result := 0;
  end;
{--------}
procedure TOvcTCCustomComboBox.EditHide;
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
procedure TOvcTCCustomComboBox.EditMove(CellRect : TRect);
  var
    EditHandle : HWND;
    NewTop : Integer;
  begin
    if Assigned(FEdit) then
      begin
        EditHandle := FEdit.Handle;
        with CellRect do
          begin
            NewTop := Top;
            if FEdit.Ctl3D then                                 {!!.10}
              InflateRect(CellRect, -1, -1);                    {!!.10}
            SetWindowPos(EditHandle, HWND_TOP,
                         Left, NewTop, Right-Left, ComboBoxHeight,
                         SWP_SHOWWINDOW or SWP_NOREDRAW or SWP_NOZORDER);
          end;
        InvalidateRect(EditHandle, nil, false);
        UpdateWindow(EditHandle);
      end;
  end;
{--------}
function TOvcTCCustomComboBox.GetCellEditor : TControl;
  begin
    Result := FEdit;
  end;
{--------}
procedure TOvcTCCustomComboBox.tcPaint(TableCanvas : TCanvas;
                                 const CellRect    : TRect;
                                       RowNum      : TRowNum;
                                       ColNum      : TColNum;
                                 const CellAttr    : TOvcCellAttributes;
                                       Data        : pointer);
  var
    ItemRec : PCellComboBoxInfo absolute Data;
    ActiveRow : TRowNum;
    ActiveCol : TColNum;
    R         : TRect;
    S         : ShortString;
    OurItems  : TStrings;
  begin
    {Note: Data is a pointer to an integer, or to an integer and a
           shortstring. The first is used for drop down listboxes
           (only) and the latter with simple and drop down combo boxes}

    {If the cell is invisible let the ancestor to all the work}
    if (CellAttr.caAccess = otxInvisible) then
      begin
        inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, nil);
        Exit;
      end;

    {If we have valid data, get the string to display from the stringlist
     or from the Data pointer. }
    S := '';
    if (Data <> nil) then
      begin
        if UseRunTimeItems then
          OurItems := ItemRec^.RTItems
        else
          OurItems := Items;
        if (0 <= ItemRec^.Index) and (ItemRec^.Index < OurItems.Count) then
          S := OurItems[ItemRec^.Index]
        else if (Style = csDropDownList) or (Style = csDropDown) or (Style = csSimple) then {!!.12}
          if UseRunTimeItems then
            {$IFDEF CBuilder}
            S := StrPas(ItemRec^.RTSt)
            {$ELSE}
            S := ItemRec^.RTSt
            {$ENDIF}
          else
            {$IFDEF CBuilder}
            S := StrPas(ItemRec^.St);
            {$ELSE}
            S := ItemRec^.St;
            {$ENDIF}
      end
    {Otherwise, mock up a string in design mode.}
    else if (csDesigning in ComponentState) and (Items.Count > 0) then
      S := Items[RowNum mod Items.Count];

    {Are we just displaying a button on the active cell?}
    if ShowButton then
      begin
        {If we are not the active cell, let the ancestor do the painting (we only
         paint a button when the cell is the active one)}
        ActiveRow := tcRetrieveTableActiveRow;
        ActiveCol := tcRetrieveTableActiveCol;
        if (ActiveRow <> RowNum) or (ActiveCol <> ColNum) then
          begin
            inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, @S);
            Exit;
          end;
        {Calculate the effective cell width (the cell width less the size
         of the button)}
        R := CellRect;
        dec(R.Right, ComboBoxButtonWidth);
        {Paint the string in this restricted rectangle}
        inherited tcPaint(TableCanvas, R, RowNum, ColNum, CellAttr, @S);
        {Paint the button on the right side}
        DrawButton(TableCanvas, CellRect);
      end
    {Otherwise, we are just drawing arrows all the time}
    else
      begin
        {Calculate the effective cell width (the cell width less the size
         of the button)}
        R := CellRect;
        dec(R.Right, ComboBoxButtonWidth);
        {Paint the string in this restricted rectangle}
        inherited tcPaint(TableCanvas, R, RowNum, ColNum, CellAttr, @S);
        {Paint the arrow on the right side}
        DrawArrow(TableCanvas, CellRect, CellAttr);
      end;
  end;
{--------}
procedure TOvcTCCustomComboBox.SaveEditedData(Data : pointer);
  var
    ItemRec : PCellComboBoxInfo absolute Data;
  begin
    if Assigned(Data) then
      begin
        ItemRec^.Index := FEdit.ItemIndex;
        if (Style = csDropDown) or (Style = csSimple) or SaveStringValue then {!!.12}
          begin
            if (ItemRec^.Index = -1) then
              if UseRunTimeItems then
                {$IFDEF CBuilder}
                StrPCopy(ItemRec^.RTSt, Copy(FEdit.Text, 1, MaxLength))
                {$ELSE}
                ItemRec^.RTSt := Copy(FEdit.Text, 1, MaxLength)
                {$ENDIF}
              else
                {$IFDEF CBuilder}
                StrPCopy(ItemRec^.St, Copy(FEdit.Text, 1, MaxLength))
                {$ELSE}
                ItemRec^.St := Copy(FEdit.Text, 1, MaxLength)
                {$ENDIF}
            else
              if UseRunTimeItems then
                {$IFDEF CBuilder}
                StrPCopy(ItemRec^.RTSt, Copy(ItemRec^.RTItems[ItemRec^.Index], 1, MaxLength))
                {$ELSE}
                ItemRec^.RTSt := Copy(ItemRec^.RTItems[ItemRec^.Index], 1, MaxLength)
                {$ENDIF}
              else
                {$IFDEF CBuilder}
                StrPCopy(ItemRec^.St, Copy(Items[ItemRec^.Index], 1, MaxLength));
                {$ELSE}
                ItemRec^.St := Copy(Items[ItemRec^.Index], 1, MaxLength);
                {$ENDIF}
          end;
      end;
  end;
{--------}
procedure TOvcTCCustomComboBox.SetItems(I : TStrings);
  begin
    FItems.Assign(I);
    if Sorted then
      TStringList(FItems).Sorted := true;
    tcDoCfgChanged;
  end;
{--------}
procedure TOvcTCCustomComboBox.SetShowButton(SB : boolean);
  begin
    if (SB <> ShowButton) then
      begin
        FShowButton := SB;
        tcDoCfgChanged;
      end;
  end;
{--------}
procedure TOvcTCCustomComboBox.SetSorted(S : boolean);
  begin
    if (S <> Sorted) then
      begin
        FSorted := S;
        if Sorted then
          TStringList(Items).Sorted := true;
        tcDoCfgChanged;
      end;
  end;
{--------}
procedure TOvcTCCustomComboBox.StartEditing(RowNum : TRowNum; ColNum : TColNum;
                                           CellRect : TRect;
                                     const CellAttr : TOvcCellAttributes;
                                           CellStyle: TOvcTblEditorStyle;
                                           Data : pointer);
  var
    ItemRec : PCellComboBoxInfo absolute Data;
  begin
    FEdit := CreateEditControl;
    with FEdit do
      begin
        Color := CellAttr.caColor;
        Ctl3D := false;
        case CellStyle of
          tes3D     : Ctl3D := true;
        end;{case}
        Left := CellRect.Left;
        Top := CellRect.Top;
        Width := CellRect.Right - CellRect.Left;
        Font := CellAttr.caFont;
        Font.Color := CellAttr.caFontColor;
        MaxLength := Self.MaxLength;
        Hint := Self.Hint;
        ShowHint := Self.ShowHint;
        Visible := true;
        CellOwner := Self;
        TabStop := false;
        Parent := FTable;
        DropDownCount := Self.DropDownCount;
        Sorted := Self.Sorted;
        Style := Self.Style;
        if UseRunTimeItems then
          Items := ItemRec^.RTItems
        else
          Items := Self.Items;
        if Data = nil then
          ItemIndex := -1
        else
          begin
            ItemIndex := ItemRec^.Index;
            if (ItemIndex = -1) and
               ((Style = csDropDown) or (Style = csSimple)) then       {!!.13}
              if UseRunTimeItems then
                {$IFDEF CBuilder}
                Text := StrPas(ItemRec^.RTSt)
                {$ELSE}
                Text := ItemRec^.RTSt
                {$ENDIF}
              else
                {$IFDEF CBuilder}
                Text := StrPas(ItemRec^.St)
                {$ELSE}
                Text := ItemRec^.St;
                {$ENDIF}
          end;

        OnChange := Self.OnChange;
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
      end;
  end;
{--------}
procedure TOvcTCCustomComboBox.StopEditing(SaveValue : boolean;
                                          Data : pointer);
  var
    ItemRec : PCellComboBoxInfo absolute Data;
  begin
    if SaveValue and Assigned(Data) then
      begin
        ItemRec^.Index := FEdit.ItemIndex;
        if (Style = csDropDown) or (Style = csSimple) or SaveStringValue then {!!.12}
          begin
            if (ItemRec^.Index = -1) then
              if UseRunTimeItems then
                {$IFDEF CBuilder}
                StrPCopy(ItemRec^.RTSt, Copy(FEdit.Text, 1, MaxLength))
                {$ELSE}
                ItemRec^.RTSt := Copy(FEdit.Text, 1, MaxLength)
                {$ENDIF}
              else
                {$IFDEF CBuilder}
                StrPCopy(ItemRec^.St, Copy(FEdit.Text, 1, MaxLength))
                {$ELSE}
                ItemRec^.St := Copy(FEdit.Text, 1, MaxLength)
                {$ENDIF}
            else
              if UseRunTimeItems then
                {$IFDEF CBuilder}
                StrPCopy(ItemRec^.RTSt, Copy(ItemRec^.RTItems[ItemRec^.Index], 1, MaxLength))
                {$ELSE}
                ItemRec^.RTSt := Copy(ItemRec^.RTItems[ItemRec^.Index], 1, MaxLength)
                {$ENDIF}
              else
                {$IFDEF CBuilder}
                StrPCopy(ItemRec^.St, Copy(Items[ItemRec^.Index], 1, MaxLength));
                {$ELSE}
                ItemRec^.St := Copy(Items[ItemRec^.Index], 1, MaxLength);
                {$ENDIF}
          end;
      end;
    FEdit.Free;
    FEdit := nil;
  end;
{====================================================================}

end.