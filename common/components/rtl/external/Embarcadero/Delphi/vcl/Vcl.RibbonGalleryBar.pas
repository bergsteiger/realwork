{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.RibbonGalleryBar;

interface

uses
  Vcl.ActnPopup, Vcl.ActnMan, Vcl.ActnMenus, Vcl.ActnCtrls, Winapi.Windows, System.Types, Vcl.Graphics,
  Vcl.Controls, System.Classes, Vcl.ActnList, Vcl.Menus, Winapi.Messages, Vcl.XPActnCtrls, Vcl.RibbonActnMenus;

type
  TCustomRibbonGalleryPopupBar = class(TRibbonActionPopupMenu)
  private
    FItemsPerRow: Integer;
    FRowWidth: Integer;
    procedure AlignGalleryControls;
  protected
    procedure SetColorMap(const Value: TCustomActionBarColorMap); override;
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    function DoGetControlClass(AnItem: TActionClientItem): TCustomActionControlClass; override;
    procedure CreateControls; override;
  end;

  TRibbonGalleryPopupBar = class(TCustomRibbonGalleryPopupBar)
  end;

  TCustomRibbonGalleryBar = class(TActionToolBar)
  private
    FShowItemCaptions: Boolean;
    FItemsPerRow: Integer;
    procedure SetItemsPerRow(const Value: Integer);
    procedure SetShowItemCaptions(const Value: Boolean);
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
    function CreateControl(AnItem: TActionClientItem): TCustomActionControl; override;
    procedure DoDropCategory(Source: TCategoryDragObject; const X: Integer; const Y: Integer); override;
    property ShowItemCaptions: Boolean read FShowItemCaptions write SetShowItemCaptions default False;
    property ItemsPerRow: Integer read FItemsPerRow write SetItemsPerRow default 3;
  published
    property Align default alNone;
  end;

  TRibbonGalleryBar = class(TCustomRibbonGalleryBar)
  published
    property Items;
    property ShowItemCaptions;
    property ItemsPerRow;
  end;

  TRibbonPopupGalleryBar = class(TRibbonGalleryBar)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure DisplayGallery(AX, AY: Integer);
  end;

implementation

uses
  System.Math, Vcl.Forms, Vcl.RibbonActnCtrls;

type
  TCategoryItem = class
  private
    FItems: TList;
  public
    CategoryName: string;
    Control: TControl;
    procedure AddItems(AControl: TControl);
    constructor Create;
    destructor Destroy; override;
  end;

{ TCustomRibbonGalleryBar }

procedure TCustomRibbonGalleryBar.AlignControls(AControl: TControl; var Rect: TRect);
var
  I, J: Integer;
  LY: Integer;
  LX: Integer;
  LRowCnt: Integer;
  LCategoryList: TStringList;
  LItem: TCategoryItem;
  LCategory: string;
  LIdx: Integer;
  LControl: TCustomActionControl;
  LPrevHeight: Integer;
  LCtrlWidth: Integer;
begin
  LY := 0;
  LX := 0;
  LRowCnt := 1;
  LPrevHeight := 44;
  LCategoryList := TStringList.Create;
  try
    for I := 0 to ControlCount - 1 do
    begin
      if Controls[I].Action <> nil then
        LCategory := StripHotKey(TCustomAction(Controls[I].Action).Category)
      else
        LCategory := StripHotKey(TCustomActionControl(Controls[I]).Caption);
      LIdx := LCategoryList.IndexOf(LCategory);
      if LIdx = -1 then
      begin
        LItem := TCategoryItem.Create;
        LItem.CategoryName := LCategory;
        LCategoryList.AddObject(LCategory, LItem);
      end
      else
        LItem := TCategoryItem(LCategoryList.Objects[LIdx]);

      if TCustomActionControl(Controls[I]).Action = nil then
        LItem.Control := TCustomActionControl(Controls[I])
      else
        LItem.AddItems(Controls[I]);
    end;

    for I := 0 to LCategoryList.Count - 1 do
    begin
      LItem := TCategoryItem(LCategoryList.Objects[I]);
      if LRowCnt <> 1 then
      begin
        Inc(LY, LPrevHeight);
        LX := 0;
      end;
      if LItem.Control <> nil then
      begin
        LItem.Control.Top := LY;
        LItem.Control.Left := LX;
        LItem.Control.Width := Width;
        Inc(LY, LItem.Control.Height + 2);
        LRowCnt := 1;
        for J := 0 to LItem.FItems.Count - 1 do
        begin
          LControl := TCustomActionControl(LItem.FItems[J]);
          begin
            if LRowCnt = FItemsPerRow + 1 then
            begin
              LRowCnt := 1;
              Inc(LY, LControl.Height);
              LX := 0;
            end;
            begin
              Inc(LRowCnt);
              LControl.CalcBounds;
              LControl.Top := LY;
              LControl.Width := LControl.Width;
              LControl.Left := LX;
              LPrevHeight := LControl.Height;
              Inc(LX, LControl.Width);
            end;
          end;
        end;
      end;
    end;
    if LCategoryList.Count > 0 then
    begin
      if TCategoryItem(LCategoryList.Objects[0]).FItems.Count > 0 then
      begin
        LCtrlWidth := TControl(TCategoryItem(LCategoryList.Objects[0]).FItems[0]).Width;
        Width := Max(Width, FItemsPerRow * LCtrlWidth);
      end;
    end;
  finally
    LCategoryList.Free;
  end;
end;

constructor TCustomRibbonGalleryBar.Create(AOwner: TComponent);
begin
  inherited;
  FShowItemCaptions := False;
  FItemsPerRow := 3;
  Align := alNone;
end;

function TCustomRibbonGalleryBar.CreateControl(
  AnItem: TActionClientItem): TCustomActionControl;
begin
  Result := inherited CreateControl(AnItem);
  AnItem.ShowCaption := FShowItemCaptions;
end;

procedure TCustomRibbonGalleryBar.DoDropCategory(Source: TCategoryDragObject; const X,
  Y: Integer);
var
  I: Integer;
  Idx: Integer;
  Ctrl: TCustomActionControl;
  lItem: TActionClientItem;
begin
  Idx := 0;
  Ctrl := FindNearestControl(Point(X, Y));
  if Assigned(Ctrl) then
    Idx := Ctrl.ActionClient.Index;
  for i := Source.ActionCount - 1 downto 0 do
    TActionClientItem(ActionClient.Items.Insert(Idx)).Action := Source.Actions[I];
  lItem := ActionClient.Items.Insert(0) as TActionClientItem;
  lItem.Action := nil;
  lItem.Caption := Source.Category;
  lItem.Tag := -1;
end;

procedure TCustomRibbonGalleryBar.SetItemsPerRow(const Value: Integer);
begin
  if FItemsPerRow <> Value then
  begin
    FItemsPerRow := Value;
    Realign;
  end;
end;

procedure TCustomRibbonGalleryBar.SetShowItemCaptions(const Value: Boolean);
begin
  if FShowItemCaptions <> Value then
  begin
    FShowItemCaptions := Value;
    RecreateControls;
  end;
end;

{ TCategoryItem }

procedure TCategoryItem.AddItems(AControl: TControl);
begin
  FItems.Add(AControl);
end;

constructor TCategoryItem.Create;
begin
  inherited;
  FItems := TList.Create;
end;

destructor TCategoryItem.Destroy;
begin
  FItems.Free;
  inherited;
end;

{ TRibbonPopupGalleryBar }

procedure TRibbonPopupGalleryBar.Assign(Source: TPersistent);
begin
  Items.Assign((Source as TRibbonGalleryBar).Items);
end;

procedure TRibbonPopupGalleryBar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if not (Parent is TCustomForm) then
      Style := Style and not WS_CHILD or WS_POPUP or WS_CLIPSIBLINGS or
        WS_CLIPCHILDREN or WS_OVERLAPPED;
    WindowClass.Style := CS_SAVEBITS or CS_DBLCLKS or not (CS_HREDRAW or not CS_VREDRAW);
    // CS_DROPSHADOW requires Windows XP or above
//    if CheckWin32Version(5, 1) and Shadow then
//      WindowClass.Style := WindowClass.style or CS_DROPSHADOW;
    if not DesignMode then
      ExStyle := ExStyle or WS_EX_TOPMOST;
  end;
end;

procedure TRibbonPopupGalleryBar.DisplayGallery(AX, AY: Integer);
begin
  if not HasItems then
    Exit;
  ParentWindow := Application.Handle;
  SetBounds(AX, AY, Width, Height);
  PersistentHotKeys := True;
  ColorMap := Self.ColorMap;
  Visible := True;
end;

{ TCustomRibbonGalleryPopupBar }

procedure TCustomRibbonGalleryPopupBar.AlignControls(AControl: TControl; var Rect: TRect);
var
  LProps: TGalleryProperties;
begin
  if Assigned(ParentControl) then
  begin
    LProps := TGalleryProperties(ParentControl.ActionClient.CommandProperties);
    if LProps.GalleryType = gtDropDown then
    begin
      inherited;
      Exit;
    end;
    FItemsPerRow := LProps.ItemsPerRow;
    if AControl = nil then
      AlignGalleryControls;
    if AControl is TRibbonSeparator then
      AControl.Width := Width;
  end;
end;

procedure TCustomRibbonGalleryPopupBar.AlignGalleryControls;
var
  I, J: Integer;
  LY: Integer;
  LX: Integer;
  LRowCnt: Integer;
  LCategoryList: TStringList;
  LItem: TCategoryItem;
  LCategory: string;
  LIdx: Integer;
  LControl: TCustomActionControl;
  LPrevHeight: Integer;
  LCtrlWidth: Integer;
begin
  if FItemsPerRow <= 0 then
    FItemsPerRow := 4; // default value
  LY := 0;
  LX := 0;
  LRowCnt := 1;
  LPrevHeight := 44;
  LCategoryList := TStringList.Create;
  try
    for I := 0 to ControlCount - 1 do
    begin
      if Controls[I].Action <> nil then
        LCategory := StripHotKey(TCustomAction(Controls[I].Action).Category)
      else
        LCategory := StripHotKey(TCustomActionControl(Controls[I]).Caption);
      LIdx := LCategoryList.IndexOf(LCategory);
      if LIdx = -1 then
      begin
        LItem := TCategoryItem.Create;
        LItem.CategoryName := LCategory;
        LCategoryList.AddObject(LCategory, LItem);
      end
      else
        LItem := TCategoryItem(LCategoryList.Objects[LIdx]);
      if TCustomActionControl(Controls[I]).Action = nil then
        LItem.Control := TCustomActionControl(Controls[I])
      else
        LItem.AddItems(Controls[I]);
    end;
    for I := 0 to LCategoryList.Count - 1 do
    begin
      LItem := TCategoryItem(LCategoryList.Objects[I]);
      if LRowCnt <> 1 then
      begin
        Inc(LY, LPrevHeight);
        LX := 0;
      end;
      if LItem.Control <> nil then
      begin
        LItem.Control.Top := LY;
        LItem.Control.Left := LX;
        LItem.Control.Width := Width;
        Inc(LY, LItem.Control.Height + 2);
        LRowCnt := 1;
        for J := 0 to LItem.FItems.Count - 1 do
        begin
          lControl := TCustomActionControl(LItem.FItems[J]);
          begin
            if LRowCnt = FItemsPerRow + 1 then
            begin
              LRowCnt := 1;
              Inc(LY, lControl.Height);
              LX := 0;
            end;
            begin
              Inc(LRowCnt);
              lControl.CalcBounds;
              LControl.SetBounds(LX, LY, LControl.Width, LControl.Height);
              LPrevHeight := LControl.Height;
              Inc(LX, lControl.Width);
              if FRowWidth = 0 then
                FRowWidth := (FItemsPerRow * lControl.Width);
            end;
          end;
        end;
      end;
    end;
    if LCategoryList.Count > 0 then
    begin
      for I := 0 to LCategoryList.Count - 1 do
      begin
        if TCategoryItem(LCategoryList.Objects[I]).FItems.Count > 0 then
        begin
          LCtrlWidth := TControl(TCategoryItem(LCategoryList.Objects[I]).FItems[0]).Width;
          Width := Max(Width, FItemsPerRow * LCtrlWidth);
          Break;
        end;
      end;
    end;
    for I := 0 to LCategoryList.Count - 1 do
      TCategoryItem(LCategoryList.Objects[I]).Free;
  finally
    LCategoryList.Free;
  end;
end;

procedure TCustomRibbonGalleryPopupBar.CreateControls;
var
  LProps: TGalleryProperties;
begin
  inherited;
  LProps := TGalleryProperties(ParentControl.ActionClient.CommandProperties);
  if LProps.GalleryType = gtDropDown then
    Exit;
  AlignGalleryControls;
end;

function TCustomRibbonGalleryPopupBar.DoGetControlClass(AnItem: TActionClientItem): TCustomActionControlClass;
var
  LProps: TGalleryProperties;
begin
  LProps := TGalleryProperties(ParentControl.ActionClient.CommandProperties);
  if AnItem.CommandStyle = csSeparator then
    Result := TRibbonSeparator
  else if (AnItem.CommandStyle = csMenu) and
    (TMenuProperties(AnItem.CommandProperties).ShowRichContent) then
    Result := TRibbonRichContentItem
  else if not AnItem.ShowCaption then
    Result := TRibbonGalleryMenuItem
  else if LProps.GalleryType = gtGrid then
    Result := TRibbonGalleryMenuItem
  else
    Result := TRibbonMenuItem;
end;

procedure TCustomRibbonGalleryPopupBar.SetColorMap(const Value: TCustomActionBarColorMap);
begin
  inherited;
  Width := FRowWidth;
  Invalidate;
  if HandleAllocated then
    SendMessage(Handle, WM_NCPAINT, 1, 0);
end;

end.
