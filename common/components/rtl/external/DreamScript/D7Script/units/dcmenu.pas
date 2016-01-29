{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcmenu;

interface
{$I dc.inc}

uses
  windows, forms, classes, menus, graphics, controls, commctrl, sysutils,
  messages, dcconsts, dcsystem, dcdreamlib, dccommon;

type
  {$IFNDEF D3}
  TCustomForm = TForm;
  {$ENDIF}

  TDCMenu = class;

  TItemInfo = class(TCollectionItem)
  private
    fMenu: TMenuItem;
    fImage: TBitmap;

    procedure _SetMenu(val: TMenuItem);
    procedure SetMenu(val: TMenuItem);
    procedure SetImage(val: TBitmap);
    function GetDCMenu: TDCMenu;
  protected
    {$IFDEF D3}
    function GetDisplayName: string; override;
    {$ENDIF}
    function GetCaption: string;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property DCMenu: TDCMenu read GetDCMenu;
  published
    {$IFNDEF D3}
    property Caption: string read GetCaption;
    {$ENDIF}
    property MenuItem: TMenuItem read fMenu write SetMenu;
    property Image: TBitmap read fImage write SetImage;
  end;

  TDCMenuItems = class(TCollection)
  private
    fDCMenu: TDCMenu;
    function GetItem(Index: Integer): TItemInfo;
    procedure SetItem(Index: Integer; Value: TItemInfo);
  protected
    {$IFDEF D3}
    function GetOwner: TPersistent; override;
    {$ENDIF}
  public
    constructor Create(menu: TDCMenu);
    function Add: TItemInfo;
    property Items[Index: Integer]: TItemInfo read GetItem write SetItem; default;
  end;

  TDCMenu = class(TComponent)
  private
    fItems: TDCMenuItems;
    fFont: TFont;
    fCheckImage: TBitmap;
    fRadioImage: TBitmap;
    fSunk: boolean;
    fImageWidth: integer;
    fImageHeight: integer;

    fOldWindProc: integer;
    fHatchBitmap: TBitmap;
    fTempBmp: TBitmap;

    fTPUHandle: THandle;
    FNewTPUtilWndProcInstance: pointer;
    FOldTPUtilWndProc: pointer;

    fHookProcInst: integer;
    fForm: TCustomForm;
    fRaisedItem: TMenuItem;
    fRaisedRect: TRect;
    fPosInfos: TList;
    fInMenuLoop: boolean;
    fHooked: boolean;
    inmenuchange: boolean;
    fTempCanvas: TCanvas;
    fLastHookedHandle: THandle;

    FVersion: TDCVersion;

    fItemInfoList, fMenuItemList: TList;

    function ProcessAccel(Message: TWMMenuChar): Integer;
    procedure HookForm;
    procedure SetItems(val: TDCMenuItems);
    procedure HookProc(var Message: TMessage);
    function FindItem(AMenu: TMenuItem): TItemInfo;
    procedure Hook;
    procedure UnHook;
    procedure GetImageListSize(var iwidth, iheight: integer);
    procedure NewTPUtilWndProc(var Message: TMessage);
    procedure SetFont(val: TFont);
    procedure GetSize(item: TMenuItem; var Size: TSize);
    function ItemHasPicture(item: TMenuItem): boolean;
    procedure MsgHook(var Msg: TMsg);
    function FindPosInfo(item: TMenuItem): integer;
    procedure AddPosInfo(aItem: TMenuItem; aRect: TRect);
    procedure EnterMenuLoop;
    procedure ExitMenuLoop;
    procedure RaiseMenuItem(NewRaisedItem: TMenuItem);
    function GetMenuCheckSize: integer;
    procedure SetCheckImage(val: TBitmap);
    procedure SetRadioImage(val: TBitmap);
    procedure ResetItems;
    procedure ModifyMenuItems(Item: TMenuItem; newflags: integer);
  protected
    procedure CMMenuItemInserted(var Message: TMessage); message CM_MenuItemInserted;

    function MeasureItem(Message: TWMMeasureItem): boolean;
    function DrawItem(Message: TWMDrawItem): boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;

    property MenuCheckSize: integer read GetMenuCheckSize;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CheckImage: TBitmap read fCheckImage write SetCheckImage;
    property Font: TFont read fFont write SetFont;
    property ImageWidth: integer read fImageWidth write fImageWidth default 16;
    property ImageHeight: integer read fImageHeight write fImageHeight default 16;

    property MenuItems: TDCMenuItems read fItems write SetItems;
    property RadioImage: TBitmap read fRadioImage write SetRadioImage;
    property SunkSelected: boolean read fSunk write fSunk default true;
    property Version: TDCVersion read FVersion write FVersion stored false;
  end;
  {
    TDCMenuEdit = class(TDefaultEditor)
      procedure ExecuteVerb(Index: Integer); override;
      function GetVerb(Index: Integer): string; override;
      function GetVerbCount: Integer; override;
    end;
   }

function GetRealMenuIndex(menuitem: TMenuItem): integer;
procedure DrawGrayText(DC: THandle; R: TRect; const Text: string;
  flags: integer; IsText3D: Boolean);
procedure DrawBeveledRect(DC: THandle; const R: TRect; color1, color2: TColor);

implementation

{------------------------------------------------------------------}

function GetRealMenuIndex(menuitem: TMenuItem): integer;
var
  i: integer;
begin
  result := menuitem.MenuIndex;
  for i := result downto 0 do
    if not menuitem.Parent.Items[i].Visible then
      dec(result);
end;

{------------------------------------------------------------------}

procedure DrawGrayText(DC: THandle; R: TRect; const Text: string;
  flags: integer; IsText3D: Boolean);
var
  oldbkmode: integer;
  oldcolor: integer;
begin
  oldbkmode := SetBkMode(DC, TRANSPARENT);
  oldcolor := SetTextColor(DC, ColorToRGB(clBtnHighlight));
  if IsText3D then
  begin
    DrawText(DC, PChar(Text), Length(Text), R, flags);
    OffsetRect(r, -1, -1);
  end;
  SetTextColor(DC, ColorToRGB(clBtnShadow));
  DrawText(DC, PChar(Text), Length(Text), R, flags);

  SetTextColor(DC, oldcolor);
  SetBkMode(DC, oldbkmode);
end;

{------------------------------------------------------------------}

procedure DrawBeveledRect(DC: THandle; const R: TRect; color1, color2: TColor);
var
  oldpen: THandle;
  pen1: THandle;
  pen2: THandle;

begin
  with R do
  begin
    pen1 := CreatePen(PS_SOLID, 1, ColorToRGB(color1));
    pen2 := CreatePen(PS_SOLID, 1, ColorToRGB(color2));

    oldpen := SelectObject(DC, pen1);
    MoveToEx(DC, Left, bottom - 1, nil);
    LineTo(DC, Left, Top);
    LineTo(DC, Right, Top);

    SelectObject(DC, pen2);
    LineTo(DC, Right, Bottom - 1);
    LineTo(DC, Left, Bottom - 1);

    SelectObject(DC, oldpen);
    DeleteObject(pen1);
    DeleteObject(pen2);
  end;
end;

{------------------------------------------------------------------}

function IsMainMenuItem(mitem: TMenuItem): boolean;
begin
  result := (mitem <> nil) and (TCustomForm(mitem.Owner).Menu <> nil) and
    (TCustomForm(mitem.Owner).Menu.Items = mitem.Parent);
end;

{------------------------------------------------------------------}

var
  fHookList: TList;
  fHook: THandle;

type
  TMenuPosInfo = class
  public
    item: TMenuItem;
    irect: TRect;
  end;

function GetMsgHook(nCode: Integer; wParam: Longint; var Msg: TMsg): Longint; stdcall;
var
  i: integer;
begin
  Result := CallNextHookEx(fHook, nCode, wParam, Longint(@Msg));
  if (nCode >= 0) then
    for i := 0 to fHookList.Count - 1 do
      TDCMenu(fHookList[i]).MsgHook(Msg);
end;

{------------------------------------------------------------------}

procedure AddHook(dcmenu: TDCMenu);
begin
  if fHookList.Count = 0 then
    fHook := SetWindowsHookEx(WH_GETMESSAGE, @GetMsgHook, 0, GetCurrentThreadID);

  fHookList.Add(dcmenu);
end;

{------------------------------------------------------------------}

procedure RemoveHook(dcmenu: TDCMenu);
begin
  fHookList.Remove(dcmenu);

  if fHookList.Count = 0 then
    UnhookWindowsHookEx(fHook);
end;

{------------------------------------------------------------------}

{$IFDEF D3}

function TItemInfo.GetDisplayName: string;
begin
  result := GetCaption;
  if Result = '' then
    Result := inherited GetDisplayName;
end;
{$ENDIF}

function TItemInfo.GetCaption: string;
begin
  if fMenu <> nil then
    result := fMenu.Name
  else
    result := '';
end;

{------------------------------------------------------------------}

constructor TItemInfo.Create(Collection: TCollection);
begin
  inherited;
  fImage := TBitmap.Create;
  DCMenu.fItemInfoList.Add(Self);
end;

{------------------------------------------------------------------}

destructor TItemInfo.Destroy;
begin
  DCMenu.fItemInfoList.Remove(Self);
  SetMenu(nil);
  fImage.Free;
  inherited;
end;

{------------------------------------------------------------------}

function TItemInfo.GetDCMenu: TDCMenu;
begin
  result := TDCMenuItems(Collection).fDCMenu;
end;

{------------------------------------------------------------------}

procedure TItemInfo.SetImage(val: TBitmap);
begin
  if IsMainMenuItem(fMenu) and (val <> nil) then
    raise Exception.Create(sErrMainMenuImage);

  fImage.Assign(val);
  //  fImage.Dormant;
end;

{------------------------------------------------------------------}

procedure TItemInfo.SetMenu(val: TMenuItem);
begin
  if (val <> nil) and (DCMenu <> nil) and (DCMenu.FindItem(val) <> nil) then
    raise Exception.Create(sErrInfoAlreadySet);

  _SetMenu(val);
  if DCMenu.fform.HandleAllocated then
    DrawMenuBar(DCMenu.fform.Handle);
end;

{------------------------------------------------------------------}

procedure ModifyItem(item: TMenuItem; newflags: integer; data: pchar);
var
  flags: integer;
  index: integer;
  id: integer;
begin
  if (item = nil) or not item.visible then
    exit;
  flags := newflags;
  with item do
  begin
    if item.Checked then
      flags := flags or MF_CHECKED;

    if item.Enabled then
      flags := flags or MF_ENABLED
    else
      flags := flags or (MF_DISABLED or MF_GRAYED);

    if Caption = '-' then
      flags := flags or MF_SEPARATOR;

    case Break of
      mbBreak: flags := flags or MF_MENUBREAK;
      mbBarBreak: flags := flags or MF_MENUBARBREAK;
    end;

    if Count > 0 then
    begin
      flags := flags or MF_POPUP;
      id := handle;
    end
    else
      id := Command;
  end;

  if IsMainMenuItem(item) then
  begin
    flags := flags or MF_BYCOMMAND;
    index := item.Command;
  end
  else
  begin
    flags := flags or MF_BYPOSITION;
    index := GetRealMenuIndex(item);
  end;

  ModifyMenu(item.Parent.Handle, index, flags, id, data);
end;

{------------------------------------------------------------------}

procedure TDCMenu.ModifyMenuItems(Item: TMenuItem; newflags: integer);
var
  i: integer;
  mitem: TMenuItem;
  iteminfo: TItemInfo;
begin
  if Assigned(Item.Parent) then
    for i := 0 to Item.Parent.Count - 1 do
    begin
      mitem := Item.Parent.Items[i];
      if mitem.visible and (mitem.caption <> '-') then
      begin
        fMenuItemList.Add(mitem);
        iteminfo := FindItem(mitem);
        if iteminfo <> nil then
        begin
          if newflags <> 0 then
            ModifyItem(mitem, newflags, pchar(iteminfo))
        end
        else
          ModifyItem(mitem, newflags, pchar(mitem));
      end;
    end;
end;

{------------------------------------------------------------------}

procedure TItemInfo._SetMenu(val: TMenuItem);
var
  minfo: TMenuItemInfo;
  h: THandle;

var
  i: integer;
begin
  if (val <> nil) and not (csLoading in DCMenu.ComponentState) then
  begin
    minfo.cbSize := sizeof(minfo);
    minfo.fMask := MIIM_DATA;
    i := GetRealMenuIndex(val);
    h := val.Parent.Handle;
    GetMenuItemInfo(h, i, true, minfo);
    if minfo.dwItemData = DWORD(self) then
      exit;
  end;

  if IsMainMenuItem(val) then
    fImage.Assign(nil);

  if csDesigning in DCMenu.ComponentState then
  begin
    fMenu := val;
    exit;
  end;

  if (fmenu <> nil) then
    DCMenu.ModifyMenuItems(fmenu, 0);

  fMenu := val;
  if val <> nil then
  begin
    val.FreeNotification(DCMenu);
    DCMenu.ModifyMenuItems(fmenu, MFT_OWNERDRAW);
    ModifyItem(fMenu, MFT_OWNERDRAW, PChar(self));
  end;
end;

{******************************************************************}

constructor TDCMenuItems.Create(menu: TDCMenu);
begin
  inherited Create(TItemInfo);
  fDCMenu := menu;
end;

{------------------------------------------------------------------}

{$IFDEF D3}

function TDCMenuItems.GetOwner: TPersistent;
begin
  result := fDCMenu;
end;
{$ENDIF}

{------------------------------------------------------------------}

function TDCMenuItems.Add: TItemInfo;
begin
  Result := TItemInfo(inherited Add);
end;

{------------------------------------------------------------------}

function TDCMenuItems.GetItem(Index: Integer): TItemInfo;
begin
  Result := TItemInfo(inherited GetItem(Index));
end;

{------------------------------------------------------------------}

procedure TDCMenuItems.SetItem(Index: Integer; Value: TItemInfo);
begin
  inherited SetItem(Index, Value);
end;

{------------------------------------------------------------------}

type
  TMControl = class(TWinControl)
  end;

  {******************************************************************}

constructor TDCMenu.Create(AOwner: TComponent);
var
  i: integer;
  j: integer;
begin
  if not (AOwner is TCustomForm) then
    raise Exception.Create(sErrNotAForm);

  with AOwner do
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TDCMenu then
        raise Exception.Create(sErrMultipleInstance);

  inherited Create(AOwner);
  fTempCanvas := TCanvas.Create;
  fImageWidth := 16;
  fImageHeight := 16;
  fSunk := true;
  fItems := TDCMenuItems.Create(self);
  fHatchBitmap := TBitmap.Create;
  fPosInfos := TList.Create;
  fTempBmp := TBitmap.Create;
  fFont := TFont.Create;
  fInMenuLoop := False;
  with fHatchBitmap, Canvas do
  begin
    Width := 8;
    Height := 8;
    Brush.Color := clBtnHighlight;
    FillRect(Rect(0, 0, 7, 7));
    for i := 0 to 3 do
      for j := 0 to 3 do
      begin
        Pixels[i * 2, j * 2] := clMenu;
        Pixels[i * 2 + 1, j * 2 + 1] := clMenu;
      end;
  end;
  fCheckImage := TBitmap.Create;
  fRadioImage := TBitmap.Create;

  fItemInfoList := TList.Create;
  fMenuItemList := TList.Create;

  fForm := TCustomForm(Owner);
  if not (csDesigning in ComponentState) then
  begin
    fHookProcInst := integer(MakeObjectInstance(HookProc));
    HookForm;
    RegisterNotifier(self);
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenu.HookForm;
var
  fproc: integer;
begin
  fproc := GetWindowLong(fForm.Handle, GWL_WNDPROC);
  if fProc = fHookProcInst then
    exit;

  if fForm.Handle = fLastHookedHandle then
    exit;

  fOldWindProc := fProc;
  fLastHookedHandle := fForm.Handle;
  SetWindowLong(fLastHookedHandle, GWL_WNDPROC, fHookProcInst);
  DrawMenuBar(fLastHookedHandle);
end;

{------------------------------------------------------------------}

procedure TDCMenu.Loaded;
var
  i: integer;
begin
  inherited;

  with MenuItems do
    for i := 0 to Count - 1 do
      CorrectBitmap(TItemInfo(Items[i]).Image);

  CorrectBitmap(CheckImage);
  CorrectBitmap(RadioImage);

  Hook;
  DrawMenuBar(fForm.Handle);
end;

{------------------------------------------------------------------}

destructor TDCMenu.Destroy;
begin
  UnHook;
  UnRegisterNotifier(self);
  FreeList(fPosInfos,fPosInfos);
  fItems.Free;
  fHatchBitmap.Free;
  fTempBmp.Free;
  fFont.Free;
  fRadioImage.Free;
  fCheckImage.Free;
  fTempCanvas.Free;

  fItemInfoList.Free;
  fMenuItemList.Free;

  inherited;
end;

{------------------------------------------------------------------}

function TDCMenu.GetMenuCheckSize: integer;
begin
  result := GetSystemMetrics(SM_CXMENUCHECK)
end;

{------------------------------------------------------------------}

procedure TDCMenu.GetSize(item: TMenuItem; var Size: TSize);
var
  dc: THandle;
  oldfont: THandle;
  r: TRect;
  text: string;
  scut: TShortCut;
  i: integer;
  scutsize: integer;
begin
  dc := GetDC(0);
  oldfont := SelectObject(dc, fFont.Handle);
  scutsize := 0;
  for i := 0 to item.Parent.Count - 1 do
  begin
    scut := item.Parent.Items[i].ShortCut;
    text := ShortCutToText(scut);
    SetRectEmpty(r);
    DrawText(dc, PChar(text), length(text), r, DT_CALCRECT);
    if r.Right > scutsize then
      scutsize := r.right;
  end;

  try
    SetRectEmpty(r);
    DrawText(dc, PChar(item.Caption), length(item.Caption), r, DT_CALCRECT);
    Size.Cx := r.Right;

    if scutsize <> 0 then
      inc(size.cx, scutsize);

    size.cy := r.Bottom;
  finally
    SelectObject(dc, oldfont);
    ReleaseDC(0, dc);
  end;
end;

{------------------------------------------------------------------}

function TDCMenu.FindItem(AMenu: TMenuItem): TItemInfo;
var
  i: integer;
begin
  for i := 0 to fItems.Count - 1 do
    if TItemInfo(fItems.GetItem(i)).fMenu = AMenu then
    begin
      result := TItemInfo(fItems.GetItem(i));
      exit;
    end;

  result := nil;
end;

{------------------------------------------------------------------}

procedure TDCMenu.Notification(AComponent: TComponent; Operation: TOperation);
var
  iteminfo: TItemInfo;
begin
  inherited;
  if (Operation = opRemove) then
    if (AComponent is TMenuItem) then
    begin
      iteminfo := FindItem(TMenuItem(AComponent));
      if iteminfo <> nil then
      begin
        iteminfo.SetMenu(nil);
        iteminfo.Free;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCMenu.SetItems(val: TDCMenuItems);
begin
  fItems.Assign(val);
end;

{------------------------------------------------------------------}

procedure TDCMenu.SetFont(val: TFont);
begin
  fFont.Assign(val);
end;

{------------------------------------------------------------------}

procedure TDCMenu.GetImageListSize(var iwidth, iheight: integer);
begin
  iwidth := fImageWidth + 2;
  iheight := fImageHeight + 2;
end;

{------------------------------------------------------------------}

function TDCMenu.ItemHasPicture(item: TMenuItem): boolean;
var
  mi: TMenuItem;
  i: integer;
  ii: TItemInfo;

begin
  result := false;
  for i := 0 to item.Parent.Count - 1 do
  begin
    mi := item.Parent.Items[i];
    ii := FindItem(mi);
    if (ii <> nil) and (ii.fImage <> nil) and not ii.fImage.Empty then
    begin
      result := true;
      break;
    end;
  end;
end;

{------------------------------------------------------------------}

function TDCMenu.MeasureItem(Message: TWMMeasureItem): boolean;
var
  Size: TSize;
  iheight: integer;
  iwidth: integer;
  mitem: TMenuItem;
begin
  mitem := nil;
  with Message.MeasureItemStruct^ do
  begin
    if fItemInfoList.IndexOf(Pointer(itemData)) >= 0 then
      mitem := TItemInfo(itemData).fmenu
    else if fMenuItemList.IndexOf(Pointer(itemData)) >= 0 then
      mitem := TMenuItem(itemData);

    Result := mitem <> nil;
    if Result then
    begin
      GetImageListSize(iwidth, iheight);
      GetSize(mitem, Size);

      if ItemHasPicture(mitem) then
      begin
        ItemHeight := max(Size.cy, iheight + 1);
        ItemWidth := Size.cx + iwidth + 1;
      end
      else
      begin
        ItemHeight := Size.cy + 4;
        ItemWidth := Size.cx;
      end;
      if not IsMainMenuItem(mitem) then
        inc(ItemWidth, MenuCheckSize + 2);

      Message.Result := 1;
    end;
  end;
end;

{------------------------------------------------------------------}

function TDCMenu.DrawItem(Message: TWMDrawItem): boolean;
var
  iheight: integer;
  iwidth: integer;
  Size: TSize;
  r: TRect;
  itop: integer;
  iBitmap: TBitmap;
  mitem: TMenuItem;
  brush: THandle;
  rheight: integer;
  color1: integer;
  color2: integer;
  fChecked: boolean;
  fSelected: boolean;
  fDisabled: boolean;
  HasImage: boolean;
  IsText3D: boolean;
  fOldFont: THandle;
  drawtextflag: integer;
  r2: TRect;
  st: string;

  procedure DrawDisabled;
  const
    ROP_DSPDxax = $00E20746;
  var
    X, Y: integer;
    tc: TColor;
    fBmp: TBitmap;
  begin
    with Message.DrawItemStruct^ do
    begin
      if HasImage then
      begin
        fBmp := TBitmap.Create;
        try
          fBmp.Assign(ibitmap);
          tc := fBmp.Canvas.Pixels[0, fBmp.Height - 1];
          for X := 0 to fBmp.Width - 1 do
            for Y := 0 to fBmp.Height - 1 do
              if fBmp.Canvas.Pixels[X, Y] = tc then
                fBmp.Canvas.Pixels[X, Y] := clWhite;
          fBmp.Monochrome := True;
          with fTempBmp do
          begin
            Width := iwidth + 4;
            Height := iheight + 4;
            Canvas.Brush.Color := clMenu;
            Canvas.FillRect(Rect(0, 0, Width, Height));
            X := (Width - ibitmap.Width) div 2;
            Y := (Height - ibitmap.Height) div 2;
            Canvas.Brush.Color := clBtnHighlight;
            Windows.SetTextColor(Canvas.Handle, clWhite);
            Windows.SetBkColor(Canvas.Handle, clBlack);
            BitBlt(Canvas.Handle, X + 1, Y + 1, Width, Height,
              fBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
            Canvas.Brush.Color := clBtnShadow;
            Windows.SetTextColor(Canvas.Handle, clWhite);
            Windows.SetBkColor(Canvas.Handle, clBlack);
            BitBlt(Canvas.Handle, X, Y, Width, Height,
              fBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
            BitBlt(hDC, rcItem.Left, iTop, iWidth, iHeight,
              Canvas.Handle, 2, 2, SRCCOPY);
          end;
        finally
          fBmp.Free;
        end;
        inc(r.Left, iwidth + 2);
      end;

      if fSelected and not (fsunk and IsMainMenuItem(mitem)) then
      begin
        brush := CreateSolidBrush(ColorToRGB(clHighLight));
        SetTextColor(hDC, ColorToRGB(clHighLightText));
      end
      else
      begin
        brush := CreateSolidBrush(ColorToRGB(clMenu));
        SetTextColor(hDC, ColorToRGB(clMenuText));
      end;

      if fSelected then
      begin
        color1 := clBtnHighlight;
        color2 := clBtnShadow;
      end
      else
      begin
        color1 := clMenu;
        color2 := color1;
      end;
      with rcItem do
        DrawBeveledRect(hDC, Rect(Left, Top, Left + IWidth, Bottom), color1, color2);

      SetBkMode(hDC, TRANSPARENT);
      FillRect(hDC, r, brush);

      if not HasImage then
        inc(r.left, iwidth + 2);

      inc(r.left, 2);

      IsText3D := not fSelected or (fsunk and IsMainMenuItem(mitem));
      fOldFont := SelectObject(hDC, fFont.Handle);
      DrawGrayText(hDC, r, mitem.Caption, drawtextflag, IsText3D);
      drawtextflag := DT_VCENTER or DT_SINGLELINE or DT_RIGHT;
      st := ShortCutToText(mitem.ShortCut);
      dec(r.right, MenuCheckSize);
      DrawGrayText(hDC, r, st, drawtextflag, IsText3D);
      SelectObject(hDC, fOldFont);
      DeleteObject(brush);
    end;
  end;

begin
  with Message.DrawItemStruct^ do
  begin
    mitem := nil;
    iBitmap := nil;

    if fItemInfoList.IndexOf(Pointer(itemData)) >= 0 then
    begin
      mitem := TItemInfo(itemData).fmenu;
      iBitmap := TItemInfo(itemData).fImage;
    end
    else if fMenuItemList.IndexOf(Pointer(itemData)) >= 0 then
      mitem := TMenuItem(itemData);

    Result := mitem <> nil;
    if Result then
    begin
      if IsMainMenuItem(mitem) then
        AddPosInfo(mitem, rcitem)
      else
        asm nop;
        end;

      fChecked := ItemState and ODS_CHECKED <> 0;
      fSelected := ItemState and ODS_SELECTED <> 0;
      fDisabled := ItemState and ODS_DISABLED <> 0;

      drawtextflag := DT_VCENTER or DT_SINGLELINE;

      if IsMainMenuItem(mitem) then
        drawtextflag := drawtextflag or DT_CENTER;

      if (iBitmap = nil) and fChecked then
        if mitem.RadioItem then
          iBitmap := fRadioImage
        else
          iBitmap := fCheckImage;

      GetSize(mitem, Size);
      if ItemHasPicture(mitem) then
        GetImageListSize(iwidth, iheight)
      else
      begin
        IHeight := 0;
        if IsMainMenuItem(mitem) then
          IWidth := 0
        else
          IWidth := MenuCheckSize;
      end;

      rheight := rcItem.Bottom - rcItem.Top;
      itop := rcItem.Top + (rheight - iheight) div 2;

      r := rcItem;
      HasImage := (iBitmap <> nil) and not iBitmap.Empty;
      if fDisabled then
        DrawDisabled
      else
      begin
        if HasImage then
        begin
          if fChecked then
          begin
            color1 := clBtnShadow;
            color2 := clBtnHighlight;
            if not fSelected then
              brush := CreatePatternBrush(fHatchBitmap.Handle)
            else
              brush := CreateSolidBrush(ColorToRGB(clMenu));

            FillRect(hDC, Rect(rcItem.Left - 1, iTop - 2, rcItem.Left + iwidth - 1, iTop + 2 + iheight), brush);
            DeleteObject(brush);
          end
          else if fSelected then
          begin
            color1 := clBtnHighlight;
            color2 := clBtnShadow;
          end
          else
          begin
            color1 := clmenu;
            color2 := color1;
          end;
          {$IFDEF D3}
          if (Win32Platform = VER_PLATFORM_WIN32_NT) then
            {$ENDIF}
            with iBitmap do
              TransparentBitBlt(Canvas.Handle, hDC, Rect(0, 0, width, height),
                TransparentColor, rcItem.Left + 1, iTop + 1)
                {$IFDEF D3}
          else
          begin
            fTempCanvas.Handle := hDC;
            iBitmap.Transparent := true;
            fTempCanvas.Draw(rcItem.Left + 1, iTop + 1, iBitmap);
            fTempCanvas.Handle := 0;
          end;
          {$ELSE}
              ;
          {$ENDIF}
          with rcItem do
            DrawBeveledRect(hDC, Rect(Left, Top, Left + IWidth, Bottom), color1, color2);

          if iwidth <> 0 then
            inc(r.left, iwidth + 2);
        end;
        if fSelected and not (fsunk and IsMainMenuItem(mitem)) then
        begin
          brush := CreateSolidBrush(ColorToRGB(clHighLight));
          SetTextColor(hDC, ColorToRGB(clHighLightText));
        end
        else
        begin
          brush := CreateSolidBrush(ColorToRGB(clMenu));
          SetTextColor(hDC, ColorToRGB(clMenuText));
        end;

        SetBkMode(hDC, TRANSPARENT);
        FillRect(hDC, r, brush);

        r2 := r;
        Inc(r2.Bottom);
        if IsMainMenuItem(mitem) then
          if fSunk and fSelected then
            DrawBeveledRect(hDC, r2, clBtnShadow, clBtnHighlight)
          else
            DrawBeveledRect(hDC, r2, clMenu, clMenu);

        DeleteObject(brush);
        if not HasImage then
          inc(r.left, iwidth + 2);

        if iwidth > 0 then
          inc(r.left, 2);

        fOldFont := SelectObject(hDC, fFont.Handle);

        DrawText(hDC, PChar(mitem.Caption), length(mitem.Caption), r, drawtextflag);
        if not IsMainMenuItem(mitem) then
        begin
          drawtextflag := DT_VCENTER or DT_SINGLELINE or DT_RIGHT;
          st := ShortCutToText(mitem.ShortCut);
          dec(r.right, MenuCheckSize);
          DrawText(hDC, PChar(st), length(st), r, drawtextflag);
        end;

        SelectObject(hDC, fOldFont);
      end;
    end;
  end;
end;

{------------------------------------------------------------------}

function TDCMenu.FindPosInfo(item: TMenuItem): integer;
var
  i: integer;
begin
  for i := 0 to fPosInfos.Count - 1 do
    if TMenuPosInfo(fPosInfos[i]).item = item then
    begin
      result := i;
      exit;
    end;
  result := -1;
end;

{------------------------------------------------------------------}

procedure TDCMenu.AddPosInfo(aItem: TMenuItem; aRect: TRect);
var
  i: integer;
  info: TMenuPosInfo;
begin
  i := FindPosInfo(aitem);
  if i = -1 then
  begin
    info := TMenuPosInfo.Create;
    fPosInfos.Add(info);
  end
  else
    info := TMenuPosInfo(fPosInfos[i]);

  with info do
  begin
    item := aItem;
    iRect := aRect;
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenu.Hook;
begin
  if csDesigning in ComponentState then
    exit;

  fTPUHandle := FindWindow('TPUtilWindow', ''); //don't resource
  while (fTPUHandle <> 0) and
    (DWORD(GetWindowLong(fTPUHandle, GWL_HINSTANCE)) <> hInstance) and
    (GetNextWindow(FTPUHandle, GW_HWNDNEXT) <> fTPUHandle) do
    fTPUHandle := GetNextWindow(FTPUHandle, GW_HWNDNEXT);

  if (FTPUHandle <> 0) and (DWORD(GetWindowLong(fTPUHandle, GWL_HINSTANCE)) = hInstance) then
  begin
    FNewTPUtilWndProcInstance := MakeObjectInstance(NewTPUtilWndProc);
    FOldTPUtilWndProc := Pointer(GetWindowLong(FTPUHandle, GWL_WNDPROC));
    SetWindowLong(FTPUHandle, GWL_WNDPROC, Longint(FNewTPUtilWndProcInstance));
  end;

  AddHook(self);
  fHooked := true;
end;

{------------------------------------------------------------------}

procedure TDCMenu.UnHook;
begin
  if {(csDesigning in ComponentState) or} not fhooked then
    exit;

  SetWindowLong(FTPUHandle, GWL_WNDPROC, Longint(FOldTPUtilWndProc));
  FreeObjectInstance(FNewTPUtilWndProcInstance);

  if fForm.HandleAllocated then
    SetWindowLong(fForm.Handle, GWL_WNDPROC, fOldWindProc);
  FreeObjectInstance(pointer(fHookProcInst));

  RemoveHook(self);
end;

{------------------------------------------------------------------}

procedure TDCMenu.RaiseMenuItem(NewRaisedItem: TMenuItem);
var
  r: TRect;
  i: integer;
  dc: THandle;
begin
  if NewRaisedItem <> fRaisedItem then
  begin
    dc := GetWindowDC(fForm.Handle);
    SetRectEmpty(r);
    if NewRaisedItem <> nil then
    begin
      i := FindPosInfo(NewRaisedItem);
      if i >= 0 then
        r := TMenuPosInfo(fPosInfos[i]).iRect;
    end;

    if fRaisedItem <> nil then
      DrawBeveledRect(DC, fRaisedRect, clMenu, clMenu);

    if NewRaisedItem <> nil then
    begin
      DrawBeveledRect(DC, r, clBtnHighlight, clBtnShadow);
      fRaisedRect := r;
    end;

    fRaisedItem := NewRaisedItem;
    ReleaseDC(fForm.Handle, dc);
  end
end;

{------------------------------------------------------------------}

procedure TDCMenu.MsgHook(var Msg: TMsg);
var
  NonClientMetrics: TNonClientMetrics;
  r: TRect;
  r2: TRect;
  fItem: TMenuItem;
  i: integer;

begin
  fItem := nil;
  with Msg do
  begin
    if not fInMenuLoop and (message = WM_MOUSEMOVE) or (message = WM_NCMOUSEMOVE)
      and (hWnd = fForm.Handle) then
    begin
      NonClientMetrics.cbSize := sizeof(NonClientMetrics);
      SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0);

      for i := 0 to fPosInfos.Count - 1 do
        with TMenuPosInfo(fPosInfos[i]) do
        begin
          r := irect;
          r2 := r;
          with NonClientMetrics do
            OffsetRect(r2, 0, -integer(iMenuHeight) - integer(iCaptionHeight) - integer(iBorderWidth));
          ClientToScreen(fForm.Handle, r2.TopLeft);
          ClientToScreen(fForm.Handle, r2.BottomRight);
          if PtInRect(r2, pt) then
          begin
            fItem := item;
            r := irect;
            break;
          end;
        end;
    end;
    RaiseMenuItem(fItem);
    HookForm;
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenu.EnterMenuLoop;
begin
  fInMenuLoop := true;
  RaiseMenuItem(nil);
end;

{------------------------------------------------------------------}

procedure TDCMenu.ExitMenuLoop;
begin
  fInMenuLoop := false;
end;

{------------------------------------------------------------------}

function TDCMenu.ProcessAccel(Message: TWMMenuChar): Integer;

  function FindAccelerator(MenuItems: TMenuItem): Integer;
  var
    i: Integer;
  begin
    result := -1;
    if (csDesigning in ComponentState) then
      exit;

    for i := 0 to MenuItems.Count - 1 do
    begin
      if (MenuItems.Handle <> Message.Menu) then
        Result := FindAccelerator(MenuItems[i])
      else if IsAccel(Word(Message.User), MenuItems[i].Caption) then
        result := GetRealMenuIndex(MenuItems[i]);

      if result >= 0 then
        break;
    end;
  end;

var
  i: integer;
  info: TItemInfo;
begin
  Result := -1;
  for i := 0 to fItems.Count - 1 do
  begin
    info := TItemInfo(fItems.Items[i]);
    if Assigned(info.fMenu) and Assigned(info.fMenu.Parent) then
      Result := FindAccelerator(info.fMenu.Parent);
    if result <> -1 then
      break;
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenu.CMMenuItemInserted(var Message: TMessage);
var
  mitem: TMenuItem;
begin
  mitem := TMenuItem(Message.wParam);
  ClearList(fPosInfos);
  //  ModifyItem(mitem, MFT_OWNERDRAW, pchar(mitem));
  ModifyMenuItems(mitem, MFT_OWNERDRAW);
  //  ResetItems;
  DrawMenuBar(fForm.Handle);
  //  ModifyMenuItems(mitem, 0);
end;

{------------------------------------------------------------------}

procedure TDCMenu.ResetItems;
var
  ItemsList: TSortedList;
  i: integer;
  k: integer;
  mitem: TMenuItem;
begin
  ItemsList := nil;
  if not inmenuchange or (csLoading in ComponentState) then
  try
    ItemsList := TSortedList.Create;
    inmenuchange := true;
    for i := 0 to MenuItems.Count - 1 do
      with TItemInfo(MenuItems.Items[i]) do
        if not ((fmenu = nil) or (fmenu.Parent = nil) or IsMainMenuItem(fMenu)) then
        begin
          for k := 0 to fMenu.Parent.Count - 1 do
          begin
            mitem := fMenu.Parent.Items[k];
            if mitem.visible and (mitem.caption <> '-') then
              ItemsList.Add(mitem);
          end;
          ModifyItem(fMenu, MFT_OWNERDRAW, PChar(MenuItems.Items[i]));
        end;

    for i := 0 to MenuItems.Count - 1 do
      with TItemInfo(MenuItems.Items[i]) do
        ItemsList.Remove(fMenu);

    for i := 0 to ItemsList.Count - 1 do
      ModifyItem(ItemsList[i], MFT_OWNERDRAW, PChar(ItemsList[i]));
  finally
    inmenuchange := false;
    ItemsList.Free;
  end;
  //  ClearList(fPosInfos);
  //  DrawMenuBar(fForm.Handle);
end;

{------------------------------------------------------------------}

procedure TDCMenu.HookProc(var Message: TMessage);
var
  i: integer;
begin
  case Message.Msg of
    CM_MENUCHANGED: ResetItems;
    WM_MENUCHAR:
      begin
        i := ProcessAccel(TWMMenuChar(Message));
        if i >= 0 then
        begin
          Message.Result := MAKELRESULT(i, 2);
          exit;
        end;
      end;
    WM_ENTERMENULOOP: EnterMenuLoop;
    WM_EXITMENULOOP: ExitMenuLoop;
    WM_MEASUREITEM:
      if (TWMMeasureItem(Message).idCtl = 0) and
        MeasureItem(TWMMeasureItem(Message)) then exit;
    WM_DRAWITEM:
      if (TWMDrawItem(Message).DrawItemStruct^.CtlType = ODT_MENU) and
        DrawItem(TWMDrawItem(Message)) then
        exit;
    WM_INITMENUPOPUP: exit;
  end;
  with Message do
    Result := CallWindowProc(pointer(fOldWindProc), fForm.Handle, Msg, WParam, LParam);
end;

{------------------------------------------------------------------}

procedure TDCMenu.NewTPUtilWndProc(var Message: TMessage);
var
  i: integer;
begin
  case Message.Msg of
    WM_DRAWITEM:
      if (TWMDrawItem(Message).DrawItemStruct^.CtlType = ODT_MENU) and
        DrawItem(TWMDrawItem(Message)) then
      begin
        Message.Result := 1;
        exit;
      end;

    WM_MEASUREITEM:
      if (TWMMeasureItem(Message).idCtl = 0) and
        MeasureItem(TWMMeasureItem(Message)) then
      begin
        Message.Result := 1;
        exit;
      end;

    WM_MENUCHAR:
      begin
        i := ProcessAccel(TWMMenuChar(Message));
        if i >= 0 then
        begin
          Message.Result := MAKELRESULT(i, 2);
          exit;
        end;
      end;
  end;

  with Message do
    Result := CallWindowProc(FOldTPUtilWndProc, FTPUHandle, Msg, WParam, LParam);
end;

{------------------------------------------------------------------}

procedure TDCMenu.SetCheckImage(val: TBitmap);
begin
  fCheckImage.Assign(val);
end;

{------------------------------------------------------------------}

procedure TDCMenu.SetRadioImage(val: TBitmap);
begin
  fRadioImage.Assign(val);
end;

{******************************************************************}
(*
procedure TDCMenuEdit.ExecuteVerb(Index: Integer);
begin
  CallPropertyEdit(Component, 'MenuItems'); //don't resource
end;

{------------------------------------------------------------------}

function TDCMenuEdit.GetVerb(Index: Integer): string;
begin
  result := SVerbMenuItems;
end;

{------------------------------------------------------------------}

function TDCMenuEdit.GetVerbCount: Integer;
begin
  result := 1;
end;
*)

procedure _Register;
begin
  //RegisterComponentEditor(TDCMenu, TDCMenuEdit);
end;

{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{------------------------------------------------------------------}

initialization
  fHookList := TList.Create;
  RunRegister;
finalization
  fHookList.Free;
end.
