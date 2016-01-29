{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 2001, EldoS, Akzhan Abdulin        }
{                                                    }
{====================================================}

(*

Version History

05/06/2003

  Fixed the problem with setting image index from application

02/12/2003

  Fixed various issues with image name and image draw positioning

10/18/2002

  When drawing large image, the rightmost column of image pixels was not painted. Fixed.

08/06/2002

  Fixed the "List index out of bounds" error when UseImageInames is true and image
  index is -1.

06/09/2002

  Fixed getter for the ImageIndex

05/31/2002

  Changed Name parameter in OnImageName event to TElFString to provide Unicode support
  Fixed programmatic setting of ImageIndex

04/23/2002

  ImageIndex was offset by 2 when ShowEmptyValue was true. Fixed.

03/26/2002

  Now it is possible to specify the name for empty value
  and to draw the name instead of the index

03/06/2002

  Added unicode hint

01/11/2002

  Fixed painting of the image in the combo box

12/24/2001

  Fixed ShowEmptyValue behaviour when ItemIndex is changed programmatically

12/16/2001

  Now the image is drawn to the left from the edit box
  Added ShowEmptyValue property

10/02/2001

  Added ManualEdit property

07/15/2001 (c) Akzhan Abdulin

  Initiated (tested under Delphi 5 only)

*)

unit ElImgCombo;

{$I '..\ElPack.inc'}

interface

uses
  Windows,
  Messages,
  Classes,
  {$ifdef VCL_4_USED}
  ImgList,
  {$endif}
  Controls,
  StdCtrls,

  CommCtrl,
{$ifdef VCL_6_USED}
  Types,
{$endif}
  ElTools,
  ElEdits,
  ElCombos,
{$ifdef ELPACK_UNICODE}
  ElUnicodeStrings,
{$endif}
  ElStrUtils
  , ELVclUtils
  ;

type

{$ifdef MSWINDOWS}
{$ifdef ELPACK_UNICODE}
  TElFStrings = TElWideStrings;
  TElFStringList = TElWideStringList;
{$else}
  TElFStrings = TStrings;
  TElFStringList = TStringList;
{$endif}
{$else}
  TElFStrings = TElWideStrings;
  TElFStringList = TElWideStringList;
{$endif}


  TElImageNameEvent = procedure(Sender : TObject; Index : integer; var Text : TElFString) of object;

  TElImageComboBox = class(TCustomElComboBox)
  private
    FChLink   : TChangeLink;
    FImages   : TImageList;
    FAChLink   : TChangeLink;
    FAlphaImages   : TImageList;
    FModified : Boolean;
    FImageNames: TElFStrings;
    IOffs: Integer;
    FUseImageNames: Boolean;

    procedure ImagesChanged(Sender : TObject);
    procedure SetImages(const Value: TImageList);
    procedure SetAlphaImages(const Value: TImageList);
    procedure Remake;
    function GetImageIndex: Integer;
    procedure SetImageIndex(const Value: Integer);
    procedure SetModified(const Value: Boolean);
    procedure SetImageNames(Value: TElFStrings);
  protected
    FOnImageName: TElImageNameEvent;
    FManualEdit: Boolean;
    FEmptyValueText: string;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DoDropDown; override;
    procedure DblClick; override;
    procedure DoChange; override;
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState); override;
    procedure TriggerImageNameEvent(Index : Integer; var Text : TElFString);
        virtual;
    procedure SetManualEdit(Value: Boolean);
    function GetShowEmptyValue: Boolean;
    procedure SetShowEmptyValue(Value: Boolean);
    procedure Loaded; override;
    procedure SetEmptyValueText(const Value: string);
    procedure RebuildList;
    function GetItemWidth(Index: Integer): Integer; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetEditRect(Value : TRect); override;
    procedure Paint; override;
    procedure KeyPress(var Key : char); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // property ItemIndex : integer read GetImageIndex write SetImageIndex;
  published

    property Images: TImageList read FImages write SetImages;
    property AlphaForImages: TImageList read FAlphaImages write SetAlphaImages;
    property ImageIndex: Integer read GetImageIndex write SetImageIndex default -1;
    property Modified: Boolean read FModified write SetModified;
    property ManualEdit: Boolean read FManualEdit write SetManualEdit default true;
    property ShowEmptyValue: Boolean read GetShowEmptyValue write SetShowEmptyValue
        default true;
    property EmptyValueText: string read FEmptyValueText write SetEmptyValueText;

    property OnImageName: TElImageNameEvent read FOnImageName write FOnImageName;
    property ImageNames: TElFStrings read FImageNames write SetImageNames;
    property UseImageNames: Boolean read FUseImageNames write FUseImageNames default false;

    property ButtonArrowColor;

    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property ListTransparentSelection;
    property ListColor;
    property ListImageForm;
    property ListInvertSelection;
    property UseBackground;
    property OnDropDown;
    property AdjustDropDownPos;
    property ShowLineHint;
    property HorizontalScroll;
    property OnDrawItem;
    property OnMeasureItem;
    property DropDownAlignment;

    // inherited from TCustomElButtonEdit
    property AlignBottom;
    property AutoSize;
    property BorderSides;
    property Transparent;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

{$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm;
{$ENDIF}

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    // inherited from TCustomElEdit
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseSystemMenu;

    property Alignment;

    property Background;
    property ButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;
{$ENDIF}
    property ButtonColor;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonHint;
    property ButtonOldStyled;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;
    property ButtonShowBorder;
    property ButtonVisible;
    property ButtonWidth;

    property AltButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property AltButtonClickSound;
    property AltButtonDownSound;
    property AltButtonUpSound;
    property AltButtonSoundMap;
{$ENDIF}
    property AltButtonColor;
    property AltButtonDown;
    property AltButtonEnabled;
    property AltButtonFlat;
    property AltButtonGlyph;
    property AltButtonHint;
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonOldStyled;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShowBorder;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property OnAltButtonClick;

    // VCL properties
    property BorderStyle;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
{$IFDEF VCL_4_USED}
    property OnEndDock;
{$ENDIF}
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF VCL_4_USED}
    property OnStartDock;
{$ENDIF}

{$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DoubleBuffered;
    property DragKind;
{$ENDIF}
  end;

implementation

uses
  Graphics,
  SysUtils;

{ TElImageIndexEdit }

procedure TElImageComboBox.DoChange;
var i : integer;
begin
  if ManualEdit then
  begin
    i := StrToIntDef(Text, -2);
    if ((i = -2) and (Text <> '-2')) or (FImages = nil) or (not (InRange(0, FImages.Count - 1, i))) then
    begin
      Text := IntToStr(ImageIndex);
    end
    else
    begin
      ItemIndex := i - IOffs;
    end;
  end;
  SetModified(True);
  Invalidate;
end;

constructor TElImageComboBox.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csDoubleClicks];
  ControlStyle := ControlStyle - [csSetCaption];
  FChLink  := TChangeLink.Create;
  FChLink.OnChange := ImagesChanged;
  FAChLink  := TChangeLink.Create;
  FAChLink.OnChange := ImagesChanged;
  IOffs := -1;
  FEmptyValueText := '-1';
  FImageNames := TElFStringList.Create;
  FUseImageNames := false;
  FManualEdit := true;
  Style := csOwnerDrawFixed;
  ReadOnly := false;
end;

procedure TElImageComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  //Params.style := Params.style or CBS_OWNERDRAWFIXED;
end;

procedure TElImageComboBox.CreateWnd;
var S : TElFString;
begin
  inherited CreateWnd;
  RebuildList;
  if ShowEmptyValue and (inherited Items[0] = '') and (IOffs = -1) then
  begin
    TriggerImageNameEvent(-1, S);
    Text := S;
  end;
end;

procedure TElImageComboBox.DblClick;
var
  NewImageIndex: Integer;
begin
  if Assigned(Images) and (Images.Count > 0) then
  begin
    NewImageIndex := ImageIndex;
    if NewImageIndex < -1 then
    begin
      NewImageIndex := -1;
    end;
    if (NewImageIndex >= -1) and (Succ(NewImageIndex) < Images.Count) then
    begin
      Inc(NewImageIndex);
    end
    else
    begin
      NewImageIndex := -1;
    end;
    if ImageIndex <> NewImageIndex then
    begin
      ImageIndex := NewImageIndex;
      SetModified(True);
    end;
  end;
  SelectAll;
end;

destructor TElImageComboBox.Destroy;
begin
  FChLink.Free;
  FAChLink.Free;
  FImageNames.Free;
  inherited;
end;

procedure TElImageComboBox.DrawItem(Index: Integer; Rect: TRect; State:
    {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState);
var
  ATextRect: TRect;
  PrevBrushColor: TColor;
  AText : TElFString;
  BMP, amBMP : TBitmap;
begin
  {$ifdef VCL_4_USED}
  TControlCanvas(Canvas).UpdateTextFlags;
  {$endif}
  ATextRect := Rect;
  // AText := inherited Items[Index];
  TriggerImageNameEvent(Index + IOffs, AText);
  //if not (odComboBoxEdit in State) then
  //  Canvas.FillRect(Rect);
  if Images <> nil then
  begin
    Inc(ATextRect.Left, 1 + Images.Width + 1);
    with Rect do
    begin
      PrevBrushColor := Canvas.Brush.Color;
      Canvas.Brush.Color := clWindow;
      Canvas.FillRect(Classes.Rect(Left, Top, ATextRect.Left, Bottom));
      Canvas.Brush.Color := PrevBrushColor;
    end;
    if (FAlphaImages <> nil) and (Index + IOffs < FAlphaImages.Count) then
    begin
      BMP := TBitmap.Create;
      BMP.Width := Images.Width;
      BMP.Height := Images.Height;
      ImageList_DrawEx(Images.Handle, Index + IOffs, BMP.Canvas.Handle, 0, 0, 0, 0,
        clNone, clNone, ILD_Normal);

      amBMP := TBitmap.Create;
      amBMP.Width := FAlphaImages.Width;
      amBMP.Height := FAlphaImages.Height;
      ImageList_DrawEx(FAlphaImages.Handle, Index + IOffs, amBMP.Canvas.Handle, 0, 0, 0, 0,
        clNone, clNone, ILD_Normal);

      AlphaCopyRect2(Canvas.Handle,
                     Classes.rect(Rect.Left+1, Rect.Top, Rect.Left+BMP.Width+1,
                                  Rect.Top+BMP.Height), BMP.Canvas.Handle,
                     Classes.rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

      BMP.Free;
      amBMP.Free;
    end
    else
      Images.Draw(Canvas, Rect.Left + 1, Rect.Top + (Rect.Bottom - Rect.Top - Images.Height) div 2, Index + IOffs);
  end;
  with ATextRect, Canvas do
    TextRect(ATextRect, Left + 1, (Top + Bottom - TextHeight(AText)) div 2, AText);
end;

procedure TElImageComboBox.DoDropDown;
begin
  //if Self.DroppedDown then
  //  RebuildList;
  inherited;
end;

function TElImageComboBox.GetImageIndex: Integer;
var i : integer;
    // S : TElFString;
begin
  i := (inherited ItemIndex) + ioffs;
  if i = -2 then
    i := -1;
  result := i;
end;

procedure TElImageComboBox.ImagesChanged(Sender: TObject);
begin
  Remake;
end;

procedure TElImageComboBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if (AComponent = Images) and (Operation = opRemove) then Images := nil;
  if (AComponent = FAlphaImages) and (Operation = opRemove) then AlphaForImages := nil;
end;

procedure TElImageComboBox.Remake;
begin
  SendCancelMode(Self);
  if (Images <> nil) and (ItemHeight < Images.Height + GetSystemMetrics(SM_CYEDGE) * 2) then
    ItemHeight := Images.Height + 2;
  RebuildList;
  SetEditRect(ClientRect);
end;

procedure TElImageComboBox.SetImageIndex(const Value: Integer);
var s : TElFString;
    i : integer;
begin
  if HandleAllocated then
  begin
    i := Value - IOffs;
    inherited ItemIndex := i;
    //SendMessage(Handle, CB_SETCURSEL, i, 0);
    if (Value = -1) and ShowEmptyValue then
      s := Self.EmptyValueText
    else
      s := IntToStr(Value);
    TriggerImageNameEvent(Value, S);
    SendMessage(Handle, WM_SETTEXT, 0, Integer(PChar(String(S))));
  end
  else
    Text := IntToStr(Value);
  Invalidate;
end;

procedure TElImageComboBox.SetImages(const Value: TImageList);
begin
  if FImages <> Value then
  begin
    if Assigned(FImages) then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FImages.ComponentState) then
        FImages.RemoveFreeNotification(Self);
      {$endif}
      FImages.UnregisterChanges(FChLink);
    end;
    FImages := Value;
    if Assigned(FImages) then
    begin
      FImages.RegisterChanges(FChLink);
      FImages.FreeNotification(Self);
    end;
    Remake;
  end;
end;

procedure TElImageComboBox.SetAlphaImages(const Value: TImageList);
begin
  if FAlphaImages <> Value then
  begin
    if Assigned(FAlphaImages) then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FAlphaImages.ComponentState) then
        FAlphaImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaImages.UnregisterChanges(FAChLink);
    end;
    FAlphaImages := Value;
    if Assigned(FAlphaImages) then
    begin
      FAlphaImages.RegisterChanges(FAChLink);
      FAlphaImages.FreeNotification(Self);
    end;
    Remake;
  end;
end;

procedure TElImageComboBox.SetModified(const Value: Boolean);
begin
  if not (csLoading in ComponentState) then
  begin
    FModified := Value;
    if Modified then
    begin
      Inherited Change;
    end;
  end;
end;

procedure TElImageComboBox.TriggerImageNameEvent(Index : Integer; var Text :
    TElFString);
begin
  if (FUseImageNames) and InRange(0, FImageNames.Count - 1, Index) then
    Text := FImageNames.Strings[Index]
  else
  if Index = -1 then
    Text := EmptyValueText
  else
    Text := IntToStr(Index{ + IOffs});

  if Assigned(FOnImageName) then
    FOnImageName(Self, Index, Text);
end;

procedure TElImageComboBox.SetManualEdit(Value: Boolean);
begin
  if FManualEdit <> Value then
  begin
    FManualEdit := Value;
    ReadOnly := not FManualEdit;
  end;
end;

function TElImageComboBox.GetShowEmptyValue: Boolean;
begin
  Result := IOffs = -1;
end;

procedure TElImageComboBox.SetShowEmptyValue(Value: Boolean);
begin
  if Value then
    IOffs := -1
  else
    IOffs := 0;
  Invalidate;
end;

procedure TElImageComboBox.Loaded;
begin
  inherited;
  Remake;
end;

procedure TElImageComboBox.SetEmptyValueText(const Value: string);
begin
  if FEmptyValueText <> Value then
  begin
    FEmptyValueText := Value;
    if ShowEmptyValue then
    begin
      inherited Items[0] := FEmptyValueText;
      if ItemIndex = 0 then
        Text := FEmptyValueText;
    end;
  end;
end;

procedure TElImageComboBox.SetImageNames(Value: TElFStrings);
begin
  FImageNames.Assign(Value);
end;

procedure TElImageComboBox.RebuildList;
var
  I   : Integer;
  AText : TElFString;
begin
  with inherited Items do
  begin
    Clear;
    if IOffs <> 0 then
      inherited Items.Add(EmptyValueText);
    if Images = nil then Exit;
    for I := 0 to Images.Count - 1 do
    begin
      AText := IntToStr(i);
      TriggerImageNameEvent(i, AText);
      inherited Items.Add(AText);
    end;
    if (ItemIndex = - 1) or (ShowEmptyValue) then
    begin
      inherited ItemIndex := 0;
    end;
  end;
end;

function TElImageComboBox.GetItemWidth(Index: Integer): Integer;
var
  S: TElFString;
begin
  TriggerImageNameEvent(Index + IOffs, S);
  Result := Canvas.TextWidth(S);
  if Images <> nil then
    inc(Result, Images.Width + 2);
end;

procedure TElImageComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('AutoCompletion', FakeBoolean, nil, false);
    Filer.DefineProperty('HorizontalScroll', FakeBoolean, nil, false);
    Filer.DefineProperty('ItemIndex', FakeInteger, nil, false);
    Filer.DefineProperty('ItemHeight', FakeInteger, nil, false);
    Filer.DefineProperty('Text', FakeStr, nil, false);
  end;
  // Filer.DefineProperty('ReadOnly', ReadReadOnly, nil, false);
end;

procedure TElImageComboBox.SetEditRect(Value : TRect);
begin
  if Images <> nil then
    LeftMargin := Images.Width + 2
  else
    LeftMargin := 1;

  inherited SetEditRect(Value);
end;

procedure TElImageComboBox.Paint;
var i  : integer;
    R,
    R1 : TRect;
    BMP,
    amBMP : TBitmap;
    Canvas : TCanvas;
begin
  if ManualEdit then
  begin
    i := FItemIndex;
    FItemIndex := -1;
    inherited;
    FItemIndex := i;
  end
  else
  begin
    inherited;
    i := FItemIndex;
  end;
  if i > -1 then
  begin
    Canvas := TCanvas.Create;
    Canvas.Handle := GetDC(Handle);

    R := Classes.Rect(0, 0, Images.Width, ClientHeight);
    CenterRects(Images.Width, R.Right - R.Left, Images.Height, R.Bottom - R.Top, R1);
    OffsetRect(R1, R.Left + 1, R.Top);

    i := ImageIndex;

    if (FAlphaImages <> nil) and (I < FAlphaImages.Count) then
    begin
      BMP := TBitmap.Create;
      BMP.Width := Images.Width;
      BMP.Height := Images.Height;
      ImageList_DrawEx(Images.Handle, I, BMP.Canvas.Handle, 0, 0, 0, 0,
        clNone, clNone, ILD_Normal);

      amBMP := TBitmap.Create;
      amBMP.Width := FAlphaImages.Width;
      amBMP.Height := FAlphaImages.Height;
      ImageList_DrawEx(FAlphaImages.Handle, I, amBMP.Canvas.Handle, 0, 0, 0, 0,
        clNone, clNone, ILD_Normal);

      AlphaCopyRect2(Canvas.Handle, R1, BMP.Canvas.Handle, rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

      BMP.Free;
      amBMP.Free;
    end
    else
      ImageList_Draw(Images.Handle, I, Canvas.Handle, R1.Left, R1.Top, ILD_NORMAL);
    ReleaseDC(Handle, Canvas.Handle);
    Canvas.Handle := 0;
    Canvas.Free;
  end;

end;

procedure TElImageComboBox.KeyPress(var Key : char);
const
  AllowedKeys = ['0'..'9', '-', #8];
begin
  if (not (Key in AllowedKeys)) or ((Key = '-') and (SelStart > 0) and (SelLength < Length(Text))) or (not ManualEdit) then Key := #0;
  inherited KeyPress(Key);
end; {KeyPress}

end.
