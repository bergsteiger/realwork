{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcpalet;

interface
{$I dc.inc}
uses
  dcpalette,
  windows,messages,classes,sysutils,graphics,controls,forms,buttons,comctrls,
  commctrl,menus,dcsystem,dcdreamlib,dcapi,dcconsts, dccommon, dcgen,
  {$IFDEF D3}activex{$ELSE}ole2, olectl{$ENDIF}

  {$IFDEF D6}, Variants {$ENDIF}
  ;

type
  TDCPageControl=class(TPageControl)
  private
    FPredefinedPages  : TStrings;
    FInternalPages    : TStrings;
    FOnlyDefinedItems : boolean;
    FUseGlobalOptions : boolean ;
    FVersion          : TDCVersion;
//    FBorderStyle      : TBorderStyle;
//    procedure SetBorderStyle(V:TBorderStyle);
    procedure RefreshActivePage;
    procedure SetPredefinedPages(V:TStrings);
    procedure SetOnlyDefinedItems(Value :boolean);
    procedure PagesOnChange(Sender:TObject);
    procedure SetUseGlobalOptions(Value : boolean);
    procedure LoadGlobalOptions; virtual;
  protected
    procedure UpdatePagePositions;
    function  PageByCaption(const Caption:String):TTabSheet;
    procedure InitData;virtual;
    function  PageByItemName(const Page ,AName :string):string;
    procedure Loaded;override;
    property  InternalPages:TStrings Read FInternalPages;
//    procedure CreateParams(var Params: TCreateParams);override;
  public
    procedure RefreshData;virtual;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property PredefinedPages:TStrings Read FPredefinedPages Write SetPredefinedPages;
    property OnlyDefinedItems : boolean read FOnlyDefinedItems write SetOnlyDefinedItems;
    property UseGlobalOptions : boolean read FUseGlobalOptions write SetUseGlobalOptions;
  published
    property ActivePage stored False;
    property Caption;
    property Version : TDCVersion read FVersion write FVersion stored false;
//    property BorderStyle:TBorderStyle Read FBorderStyle Write SetBorderStyle;
//    property Ctl3d;
  end;

  TNewFormPageControl = class(TDCPageControl)
  private
    FCnt : integer;
    FImageList : TImageList;
    FNewPages :  TObject;
    procedure IntersectWithPages(Item : TObject;const APage , AName ,AResName :string);
    function  NewExtCallBack(Item:TObjectParamListItem;const AParams:Array of variant; Var Finish:boolean):Variant;
    procedure ListDblClick(Sender:TObject);
    procedure LoadGlobalOptions; override;
  protected
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy; override;
    procedure RefreshData;override;
  published
    property PredefinedPages;
    property OnDblClick;
    property OnlyDefinedItems;
    property UseGlobalOptions;
  end;


  TDCCompPalette = class(TDCComponentPalette);
(*
  TOnGetHintEvent = procedure(Sender : TObject; var AHint : string) of object;


  TDCCompPalette=class(TDCPageControl)
  private
    FUpdateSheet:TTabSheet;
    FShiftState:TShiftState;
    FButtonDatas:TCollection;
    MouseButtonWidth:Integer;
    MouseButtonHeight:Integer;
    FOnSelectButton:TNotifyEvent;
    FMouseGlyph:TBitmap;
    FControlClass:String;
    FOnPagesChanged:TNotifyEvent;
    FMultiLine : boolean;
    FOnGetButtonHint : TOnGetHintEvent;
//     fEnableActiveX : boolean;

    function GetActivePage:TTabSheet;
    procedure SetActivePage(V:TTabSheet);
    procedure RefreshPage(Page:TTabSheet);
    procedure SetMouseGlyph(Value:TBitmap);
    procedure DeleteEmptyPages;
    procedure PagesChanged; // calls OnPagesChanged event
    Function  CreateButton:TObject; // creates palette button and assign default parameters
    procedure OnInvalidate(Sender:TObject); // calls invalidate
    procedure AddCompButton(const Page :string; ButtonClass:TComponentClass; // creates component button
      PackageID:THandle);
    procedure PressMouseButtons(A:TTabSheet);// presses mouse buttons on all pages except page A
    procedure RealignControls; // realign buttons on all pages
    procedure RealignForPage(A:TTabSheet); // realign buttons on specified page
    procedure SelectButton; // notify designer that button was clicked and calls OnClickEvent
    procedure MouseButtonClick(Sender:TObject);// event of all mouse buttons
    procedure CompMouseDown(Sender: TObject; Button: TMouseButton;
                 Shift: TShiftState; X, Y: Integer);
    procedure CompClick(Sender:TObject);
    function  GetClassNameForButton(Button:TObject):String;//return classname for a given palette button
    procedure LoadActiveXConfig; // loads ActiveX configuration, call it only once!!!
    procedure AddComponentsForPackage(AHandle:THandle);
    procedure LoadGlobalOptions; override;
  protected
    procedure Change; override;
    procedure WMSIZE(Var M:TMessage);message WM_SIZE;
    procedure CMPACKAGEUNLOADED(Var M:TMessage);message CM_PACKAGEUNLOADED;
    procedure CMREGISTERCOMPS(Var M:TMessage);message CM_REGISTERCOMPS;
    procedure cmObjectChanged(Var M:TMessage);message cm_ObjectChanged;
    procedure CMOBJINSERT(Var M:TMessage);message CM_OBJINSERT;
    procedure CMREGISTERACTIVEX(Var M:TMessage);message CM_REGISTERACTIVEX;
    procedure CMUNREGISTERACTIVEX(Var M:TMessage);message CM_UNREGISTERACTIVEX;
    function  SheetByName(const AName:String):TTabSheet;
    procedure GetButtonHint(var AHint : string); virtual;

  public
    procedure InitData;override;
    procedure RefreshData;override;
    procedure SelectMouseButton;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure DelActiveX(const AGUID:TGUID);
    procedure AddActiveX(Var AGuid,ATypeLib; Const AHint:string;
      APicModule:THandle; APicIndex:integer);
    procedure UpdateHints;
    property ControlClass:String Read FControlClass;
    property ShiftState:TShiftState Read FShiftState;
  published
    property ActivePage Read GetActivePage Write SetActivePage stored False;
    property MouseGlyph:TBitmap Read FMouseGlyph Write SetMouseGlyph;
    property MultiLine : boolean  read FMultiLine;
    property PredefinedPages;
    property OnlyDefinedItems;

//     property EnableActiveX : boolean read fEnableActiveX write SetEnableActiveX;

    property OnSelectButton:TNotifyEvent Read FOnSelectButton Write FOnSelectButton;
    property OnPagesChanged:TNotifyEvent Read FOnPagesChanged Write FOnPagesChanged;
    property OnGetButtonHint : TOnGetHintEvent read FOnGetButtonHint write FOnGetButtonHint;

    property UseGlobalOptions;
  end;

  TDCPaletteSheet=class(TTabSheet)
  private
    FTopLine:Integer;
    FCanMoveDown:Boolean;
    FButtonsLoaded:boolean;
  protected
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    procedure CreateParams(var Params: TCreateParams);override;
  public
    constructor Create(AOwner:TComponent);override;
  end;

*)
  TPageControlOptions =  class(TOptionExt)
  private
    FPageItems : TStrings;
    procedure  SetPageItems(Value: TStrings);
    procedure  PageItemsChanged(Sender : TObject);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure InitValues; override;
  published
    property PageItems : TStrings read FPageItems write SetPageItems;
  end;

  TPaletteOptions = class(TPageControlOptions)
  protected
    procedure Update; override;
  public
    function  GetKey : string; override;
    procedure InitValues; override;
  end;

  TNewFormOptions = class(TPageControlOptions)
  protected
    procedure Update; override;
  public
    function  GetKey : string; override;
    procedure InitValues; override;
  end;

  TPaletteList = class(TList)
  private
    function GetPalette (index : integer) : TDCCompPalette;
  public
    property Palettes[index : Integer]: TDCCompPalette read GetPalette; default;
  end;

  TNewFormControlList = class(TList)
  private
    function GetNewFormControl(index : integer) : TNewFormPageControl;
  public
    property NewFormControls[index : Integer]: TNewFormPageControl read GetNewFormControl; default;
  end;

  TCompPaletteOptions = class(TPersistent)
  private
    fPredefinedPages  : TStrings;
    fOnlyDefinedItems : boolean;
    fCustomizePalette : boolean;
    fUseActiveX       : boolean;
    FOnGetButtonHint  : TOnGetHintEvent;

    procedure SetPredefinedPages(val : TStrings);
  public
    constructor Create;
    destructor  Destroy; override;
  published
    property CustomizePalette : boolean read fCustomizePalette write fCustomizePalette;
    property UseActiveX       : boolean read fUseActiveX write fUseActiveX;
    property OnlyDefinedItems : boolean read fOnlyDefinedItems write fOnlyDefinedItems;
    property PredefinedPages  : TStrings read fPredefinedPages write SetPredefinedPages;
    property OnGetButtonHint : TOnGetHintEvent read FOnGetButtonHint write FOnGetButtonHint;
  end;

const
   cPaletteButtonSize=26;
const
  GlogalUseActiveX : boolean = true;
  
procedure ConvertPalettePages(FromPages,ToPages : TStrings);
function PaletteList : TPaletteList;
function NewFormControlList : TNewFormControlList;
function GlobalPaletteOptions : TPaletteOptions;
function GlobalNewFormControlOptions: TNewFormOptions;
procedure AssignPalettePages(Pages : TStrings);
procedure AssignNewFormPages(Pages : TStrings);

implementation

constructor TCompPaletteOptions.Create;
begin
  inherited;
  fPredefinedPages := TStringList.Create;
end;

{------------------------------------------------------------------}

destructor  TCompPaletteOptions.Destroy;
begin
  fPredefinedPages.Free;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCompPaletteOptions.SetPredefinedPages(val : TStrings);
begin
  fPredefinedPages.Assign(val);
end;

{******************************************************************}

{var
  PaletteImages     : TImageList;}

type
  TItemRec = class
  private
    FPage  : string;
    Findex : integer;
    FPageIndex : integer;
  public
    constructor Create(const APage:string;AIndex,APageIndex:integer);
    property Page:String Read FPage;
    property Index:Integer Read FIndex;
    property PageIndex:Integer Read FPageIndex;
  end;

  TNewItemRec = class
  public
    Item      : TObject;
    Page      : string;
    ItemName  : string;
    ResName   : string;
    Index     : integer;
    PageIndex : integer;
    constructor Create(AItem:TObject;const APage,AName,AResName : string ;AIndex,APageIndex:integer);
  end;

  TPagesList = class(TSortedList)
    function Compare(Item1, Item2: Pointer):integer;override;
  end;

{  TDCPaletteButton = class(TGraphicControl)
  private
    FImageIndex     : integer;
    FDown           : boolean;
    FMouseInControl : boolean;
    FShiftPressed   : boolean;
    FGroupIndex     : integer;
    FFlat           : boolean;
    FAllowAllUp     : boolean;
    FDragging       : boolean;
    //procedure  SetImageIndex(Value :integer);
    procedure  SetDown(Value :boolean);
    procedure  SetGlyph(Value:TBitmap);
    function   GetGlyph : TBitmap;
    procedure  SetAllowAllUp(Value :boolean);
    procedure  SetGroupIndex(Value :integer);
    procedure  GlyphChanged(Sender:TObject);
    procedure  UpdateExclusive;
    procedure  ChangeGlyph(Glyph : TBitmap );
  protected
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;  X, Y: Integer); override;
    procedure WMLButtonDblClk(var Message: TWMLButtonDown); message WM_LBUTTONDBLCLK;
  public
    constructor Create(AOwner : TComponent); override;
    property Down  : boolean read FDown write SetDown;
    property Glyph : TBitmap read GetGlyph write SetGlyph;
    property Flat  : boolean read FFlat write FFlat;
    //property ImageIndex : integer read FImageIndex write SetImageIndex;
  published
    property AllowAllUp : boolean read FAllowAllUp write SetAllowAllUp;
    property GroupIndex : integer read FGroupIndex write SetGroupIndex;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;
}

{  TPaletteButton = class(TDCPaletteButton)
  private
    fClassName : string;
  end;}

{  TButtonData=class(TCollectionItem)
  public
    FButton:TPaletteButton;
    FTypeLib:TGUID;
    FGUID:TGUID;
  end;
}

const
  MouseButtonTag=-1;
  ActiveXTag=-2;
  NeedDestroyTag=-3;
//var
//  Pattern           : TBitmap;
//  GlobalImageIndex  : integer;
//  PaletteGlyph      : TBitmap;

{-------------------------------------------------------------------------}

procedure AssignPalettePages(Pages : TStrings);
begin
  With TStringList(Pages) do
  begin
    BeginUpdate;
    Clear;
    Add(SPalStandard);
    Add(SPalAdditional);
    Add(SPalWin32);
    Add(SPalSystem);
    Add(SPalDataAccess);
    Add(SPalDataControls);
    Add(SPalMidas);
    Add(SPalDecisionCube);
    Add(SPalQReport);
    Add(SPalDialogs);
    Add(SPalWin31);
    Add(SPalDream);
    Add(SPalDreamTree);
    Add(SPalDreamMemo);
    Add(SPalDreamEdit);
    Add(SPalActiveX);
    EndUpdate;
  end;
end;

{-------------------------------------------------------------------------}

procedure AssignNewFormPages(Pages : TStrings);
begin
  with TStringList(Pages) do
  begin
    BeginUpdate;
    Clear;
    Add(SProject);
    Add(SPageForm);
    Add(SPageReport);
    Add(SPageUnit);
    Add(SPageDataModule);
    Add(SPageNew);
    EndUpdate;
  end;
end;

{-------TDCPageControl----------------------------------------------}

procedure ConvertPalettePages(FromPages,ToPages : TStrings);
var
  i  : integer;
  j  : integer;
  s  : string;
  sl : TStringList;
begin
  with ToPages do
  begin
    ClearStrings(ToPages);
    sl := TStringList.Create;
    try
      for i:= 0 to FromPages.Count-1 do
      begin
        s := Trim(FromPages.Names[i]);
        sl.CommaText := RemoveCharSet([' '], ExtractValuePart(FromPages.Strings[i]));
        for j := 0 to sl.Count - 1 do
        begin
          AddObject(sl.Strings[j] ,TItemRec.Create(s,j,i));
        end;
      end;
    finally
      sl.Free;
    end;
  end;
end;

{-------------------------------------------------------------------------}

constructor TItemRec.Create(const APage:string;AIndex,APageIndex:integer);
begin
  inherited Create;
  FPage  := APage;
  FIndex := AIndex;
  FPageIndex := APageIndex;
end;

{-------------------------------------------------------------------------}

constructor TDCPageControl.Create(AOwner:TComponent);
begin
  inherited;
  FPredefinedPages:=TStringList.Create;
  FInternalPages :=CreateSortedStringList;
  TStringList(FPredefinedPages).OnChange:=PagesOnChange;
//  FBorderStyle := bsSingle;
end;

{-------------------------------------------------------------------------}

procedure TDCPageControl.InitData;
begin
  RefreshData;
  ActivePage:=nil;
  RefreshActivePage;
  Change;
end;

{-------------------------------------------------------------------------}

procedure TDCPageControl.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    InitData;
end;

{-------------------------------------------------------------------------}

destructor TDCPageControl.Destroy;
begin
  FPredefinedPages.Free;
  ClearStrings(FInternalPages);
  FInternalPages.Free;
  inherited;
end;

{-------------------------------------------------------------------------}

procedure TDCPageControl.UpdatePagePositions;
var
  i:Integer;
  Page:TTabSheet;
  TempStrings:TStringList;
  PageName : string;
begin
  TempStrings:=TStringList.Create;
  With TempStrings do
  try
    for i:=0 to FPredefinedPages.Count-1 do
    begin
      with FPredefinedPages do
      begin
        PageName := Trim(Names[i]);
        if PageName = '' then
          PageName := Strings[i];
      end;
      Page:=PageByCaption(PageName);
      If (Page<>nil) and (IndexOf(PageName)<0) then
        AddObject(PageName,Page);
    end;
    for i:=0 to Count-1 do
      TTabSheet(Objects[i]).PageIndex:=i;
  finally
    Free;
  end;
  RefreshActivePage;
end;

{-------------------------------------------------------------------------}

procedure TDCPageControl.PagesOnChange(Sender:TObject);
begin
  if (not HandleAllocated) then
    exit;
  RefreshData;
end;

{-------------------------------------------------------------------------}

function TDCPageControl.PageByItemName(const Page ,AName :string) : string;
var
  i: integer;
begin
  if FOnlyDefinedItems then
    result := ''
  else
    result := Page;
  with TStringList(FInternalPages) do
    if Find(RemoveCharSet([' '],AName),i) then
      result := TItemRec(Objects[i]).Page;
end;

{-------------------------------------------------------------------------}

procedure TDCPageControl.SetPredefinedPages(V:TStrings);
begin
  FPredefinedPages.Assign(V);
end;

{-------------------------------------------------------------------------}

procedure TDCPageControl.SetOnlyDefinedItems(Value :boolean);
begin
  if FOnlyDefinedItems <> Value then
  begin
    FOnlyDefinedItems := Value ;
    RefreshData;
    Change;
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCPageControl.SetUseGlobalOptions(Value : boolean);
begin
  if FUseGlobalOptions <> Value then
  begin
    FUseGlobalOptions := Value;
    if Value then
      LoadGlobalOptions;
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCPageControl.LoadGlobalOptions;
begin
end;

{-------------------------------------------------------------------------}

procedure TDCPageControl.RefreshData;
begin
  if csDesigning in ComponentState then
    exit;
  ConvertPalettePages(PredefinedPages,FInternalPages);
end;

{-------------------------------------------------------------------------}

procedure TDCPageControl.RefreshActivePage;
begin
  If (ActivePage=nil) and (PageCount>0) then
    ActivePage:=Pages[0];
end;

{-------------------------------------------------------------------------}

function TDCPageControl.PageByCaption(const Caption:String):TTabSheet;
var
  i:Integer;
begin
  Result:=nil;
  for i:=0 to PageCount-1 do
    if CompareText(Pages[i].Caption,Caption)=0 then
    begin
      Result:=Pages[i];
      break;
    end;
end;

(*
{---------TDCPaletteButton----------------------------------------------}

constructor TDCPaletteButton.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
//  Color := clBtnFace;
  FImageIndex := GlobalImageIndex;
  inc(GlobalImageIndex);
  PaletteImages.Add(nil,nil);
  Width  := 25;
  Height := 25;
end;

{------------------------------------------------------------------}

procedure TDCPaletteButton.CMMouseEnter(var Message: TMessage);
var
  i : integer;
begin
  inherited;
  if not FMouseInControl then
  begin
    FMouseInControl := True;
    Repaint;
    with Parent do
      for i := 0 to ControlCount - 1 do
        if (Controls[i] is TDCPaletteButton) and (Controls[i] <> Self) then
          with TDCPaletteButton(Controls[i]) do
            if FMouseInControl then
            begin
              FMouseInControl := false;
              Invalidate;
            end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPaletteButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if FMouseInControl then
  begin
    FMouseInControl := False;
    Invalidate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPaletteButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if ssLeft in Shift then
  begin
    FShiftPressed := (Tag <> - 1) and (ssShift in Shift);
    if not FDown then
      SetDown(True);
    FDragging := True;
  end;

end;

{------------------------------------------------------------------}

procedure TDCPaletteButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DoClick: Boolean;
begin
  inherited;
  if FDragging then
  begin
    FDragging := False;
     DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
    if FGroupIndex = 0 then
    begin
      FDown := false;
      FMouseInControl := False;
      if DoClick then
        Invalidate;
    end
    else
      Repaint;
    if FDown{DoClick} then
      Click;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPaletteButton.WMLButtonDblClk(var Message: TWMLButtonDown);
begin
  inherited;
  if FDown then DblClick;
end;

{------------------------------------------------------------------}

procedure TDCPaletteButton.CMButtonPressed(var Message: TMessage);
var
  Sender: TDCPaletteButton;
begin
  if Message.WParam = FGroupIndex then
  begin
    If not (TObject(Message.LParam) is TDCPaletteButton) then
      exit;
    Sender := TDCPaletteButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;
        Invalidate;
      end;
      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPaletteButton.Paint;
const
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  PaintRect: TRect;
  Offset: TPoint;
begin
  PaintRect := Rect(0, 0, Width, Height);
  if FDown  and  FShiftPressed then
  begin
    if FShiftPressed  then
      with Canvas do
      begin
        Brush.Color := $0ff8080;
        FrameRect(PaintRect);
      end
  end
  else
  if FDown or  FMouseInControl  or  (csDesigning in ComponentState) then
    DrawEdge(Canvas.Handle, PaintRect, DownStyles[FDown],BF_RECT);
  InflateRect(PaintRect, -1, -1);
  if FDown then
  begin
    Canvas.Brush.Bitmap := Pattern;
    Canvas.FillRect(PaintRect);
    Offset.X := 1;
    Offset.Y := 1;
  end
  else
  begin
    Offset.X := 0;
    Offset.Y := 0;
  end;

  if Width > PaletteImages.Width then
    inc(Offset.X, (Width - PaletteImages.Width) div 2);
  if Height > PaletteImages.Height then
    inc(Offset.Y, (Height - PaletteImages.Height) div 2);

  ImageList_Draw(PaletteImages.Handle,FImageIndex,Canvas.Handle,Offset.X,Offset.Y,ILD_TRANSPARENT);
end;

{------------------------------------------------------------------}
{
procedure  TDCPaletteButton.SetImageIndex(Value :integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Repaint;
  end;
end;
 }
{------------------------------------------------------------------}

procedure  TDCPaletteButton.SetDown(Value :boolean);
begin
  if FDown <> Value then
  begin
    if FDown and (not FAllowAllUp) then Exit;
    FDown := Value;
    Repaint;
    if FDown then
      UpdateExclusive;
  end;
end;

{------------------------------------------------------------------}

procedure  TDCPaletteButton.SetAllowAllUp(Value :boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

{------------------------------------------------------------------}

procedure  TDCPaletteButton.SetGroupIndex(Value :integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

{------------------------------------------------------------------}

procedure  TDCPaletteButton.SetGlyph(Value:TBitmap);
begin
  PaletteGlyph.OnChange := nil;
  PaletteGlyph.Assign(Value);
  ChangeGlyph(Value);
  PaletteGlyph.OnChange := GlyphChanged;
end;

{------------------------------------------------------------------}

function   TDCPaletteButton.GetGlyph : TBitmap;
begin
  PaletteGlyph.OnChange := GlyphChanged;
  result := PaletteGlyph;
end;

{------------------------------------------------------------------}

procedure  TDCPaletteButton.GlyphChanged(Sender:TObject);
begin
  ChangeGlyph(PaletteGlyph);
end;

{------------------------------------------------------------------}

procedure  TDCPaletteButton.ChangeGlyph(Glyph : TBitmap );
var
  Bmp  : TBitmap;
  offx : integer;
  offy : integer;
begin

  with  PaletteImages do
    if (Width > Glyph.Width) or (Height > Glyph.Height) then
    begin
      offx := (Width - Glyph.Width) div 2 ;
      offy := (Height- Glyph.Height) div 2 ;
      Bmp := TBitmap.Create;
      try
        Bmp.Assign(Glyph);
        Bmp.Width := Width;
        Bmp.Height:= Height;
        with Bmp , Canvas do
        begin
          Brush.Color := Glyph.TransparentColor;
          FillRect(Rect(0,0,Width,Height));
          Draw(offx,offy,Glyph);
        end;
        ChangeImageList(PaletteImages,Bmp,Bmp.TransparentColor,FImageIndex);
      finally
        Bmp.Free;
      end;
    end
    else
    if (Width < Glyph.Width) or (Height > Glyph.Height) then
    begin
      Bmp := TBitmap.Create;
      try
        Bmp.Width := Width;
        Bmp.Height:= Height;
        offx := (Glyph.Width - Width) div 2 ;
        offy := (Glyph.Height - Height) div 2 ;
        Bmp.Canvas.Draw(- offx, - offy, Glyph);
        ChangeImageList(PaletteImages,Bmp,Bmp.TransparentColor,FImageIndex);
      finally
        Bmp.Free;
      end;
    end
    else
      ChangeImageList(PaletteImages,Glyph,Glyph.TransparentColor,FImageIndex);

end;

{------------------------------------------------------------------}

procedure TDCPaletteButton.UpdateExclusive;
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := Longint(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
  end;
end;

{------------------------------------------------------------------}

procedure InitPaletteButtons;
begin
  Pattern := TBitmap.Create;
  CreateBrushPattern(Pattern);
  PaletteImages := TImageList.Create(nil);
  PaletteImages.Width := 28;
  PaletteImages.Height := 28;
  GlobalImageIndex := 0;
  PaletteGlyph := TBitmap.Create;
end;

{------------------------------------------------------------------}

procedure DonePaletteButtons;
begin
  Pattern.Free;
  PaletteImages.Free;
  PaletteGlyph.Free;
end;
*)

{---------TDCCompPalette------------------------------------------------}
(*
procedure TDCCompPalette.WMSIZE(Var M:TMessage);
begin
  inherited;
  RealignControls;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.CMOBJINSERT(Var M:TMessage);
begin
  If not (ssShift in ShiftState) then
    SelectMouseButton;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.CMREGISTERCOMPS(Var M:TMessage);
begin
  RefreshData;
end;

{-------------------------------------------------------------------------}

{procedure TDCCompPalette.CMPACKAGELOADED(Var M:TMessage);
begin
  AddComponentsForPackage(M.wparam);
end;}

{-------------------------------------------------------------------------}

procedure TDCCompPalette.CMPACKAGEUNLOADED(Var M:TMessage);
begin
  RefreshData;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.MouseButtonClick(Sender:TObject);
begin
  SelectMouseButton;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.SelectButton;
begin
  DesignerInsertClass:=FControlClass;
  BroadCastToNotifiers(Self,CM_PALETTECLICK,Integer(FControlClass),Byte(ShiftState));
  If ssDouble in ShiftState then
    DesignerInsertClass:='';
  If Assigned(FOnSelectButton) then
    FOnSelectButton(Self);
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.RefreshPage(Page:TTabSheet);
begin

  If (Page=nil) then
    exit;
  If TDCPaletteSheet(Page).FButtonsLoaded=False then
  begin
    FUpdateSheet:=Page;
    try
      RefreshData;
      TDCPaletteSheet(Page).FButtonsLoaded:=True;
    finally
      FUpdateSheet:=nil;
    end;
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.Change;
begin
  if Tabindex < 0 then
  begin
    inherited;
    exit;
  end;
  RefreshPage(TDCPaletteSheet(Tabs.Objects[TabIndex]));
  inherited;
  PressMouseButtons(TDCPaletteSheet(ActivePage));
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.PressMouseButtons(A:TTabSheet);
Var
  i:Integer;
begin
  For i:=0 to ComponentCount-1 do
    If (Components[i] is TPaletteButton) and (Components[i].Tag=MouseButtonTag) and
       ((TPaletteButton(Components[i]).Parent<>A) or (A=nil)) then
     TPaletteButton(Components[i]).Down:=True;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.CompClick(Sender:TObject);
begin
  SelectButton;

  If ssDouble in ShiftState then
    SelectMouseButton;
end;

{-------------------------------------------------------------------------}

function TDCCompPalette.GetClassNameForButton(Button:TObject):String;
Var
  i:Integer;
begin
  If TPaletteButton(Button).Tag=ActiveXTag then
    begin
      for i:=0 to FButtonDatas.Count-1 do
        with TButtonData(FButtonDatas.Items[i]) do
          if Pointer(FButton)=Pointer(Button) then
          begin
            Result:=GUIDToString(FGUID);
            exit;
          end;
      Result:='';
    end
  else
    Result:= TPaletteButton(Button).fClassName;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.CompMouseDown(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
begin
  PressMouseButtons(TDCPaletteSheet(TPaletteButton(Sender).Parent));
  FControlClass:=GetClassNameForButton(Sender);
  FShiftState:=Shift;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.LoadGlobalOptions;
begin
  with GlobalPaletteOptions do
    self.PredefinedPages :=  PageItems;
end;

{-------------------------------------------------------------------------}

{procedure TDCCompPalette.SetEnableActiveX(val : boolean);
begin
  if val <> fEnableActiveX then
    begin
      fEnableActiveX := val;
    end;
end;}

{-------------------------------------------------------------------------}

Function TDCCompPalette.SheetByName(Const AName:String):TTabSheet;
Var
  SelectBut:TPaletteButton;
begin
  Result:=TDCPaletteSheet(PageByCaption(AName));
  If (Result<>nil) then
  begin
    Result.Tag:=0;
    exit;
  end;
  Result := TDCPaletteSheet.Create (self);


  with Result do
  begin
    Caption := AName;
    SelectBut := TPaletteButton.Create(self);
    with TPaletteButton(selectbut) do
    begin
      Glyph := MouseGlyph;
      Tag:=MouseButtonTag;
      {$IFDEF D3}
      flat := true;
      {$ENDIF}
      GroupIndex:=1;
      Width:=cPaletteButtonSize;
      Height:=cPaletteButtonSize;
      AllowAllUp := False;
      Down := True;
      OnClick := MouseButtonClick;
      MouseButtonWidth:=Width;
      MouseButtonHeight:=Height;
    end;
    InsertControl(SelectBut);
    Result.PageControl:=Self;
  end;
end;

{-------------------------------------------------------------------------}


constructor TDCpaletteSheet.Create(AOwner:TComponent);
begin
  inherited;
  FCanMoveDown:=True;
end;

{-------------------------------------------------------------------------}

procedure TDCpaletteSheet.WMVScroll(var Msg: TWMVScroll);
begin
  if Visible and CanFocus and TabStop and not (csDesigning in ComponentState) then
    SetFocus;
  Case Msg.ScrollCode of
{    SB_THUMBPOSITION:
        ScrollScreenVert(Pos-WinLine);
    SB_THUMBTRACK:
      if (eoThumbTracking in FOptions) then
        ScrollScreenVert(Pos-WinLine);
    SB_BOTTOM:
      JumpToFileEnd;
    SB_TOP:
      JumpToFileBegin;}

    SB_PAGEUP,SB_LINEUP:
      If FTopLine>0 then
      begin
        Dec(FTopLine);
        TDCCompPalette(PageControl).RealignForPage(Self);
      end;
    SB_PAGEDOWN,SB_LINEDOWN:
      If FCanMoveDown then
      begin
        Inc(FTopLine);
        TDCCompPalette(PageControl).RealignForPage(Self);
      end;
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCpaletteSheet.CreateParams(var Params: TCreateParams);
begin
  Inherited Createparams(Params);
  With Params do
  begin
    Style := Style or WS_VSCROLL;
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.PagesChanged;
begin
  If Assigned(FOnPagesChanged) then
    FOnPagesChanged(Self);
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.CMUNREGISTERACTIVEX(Var M:TMessage);
Var
  D:TAxControlInfo;
begin
  D:=TAxControlInfo(M.wParam);
  With D do
  If IsEqualGUID(TypeLib,GUID_NULL)
  then
    DelActiveX(GUID)
  else
    DelActiveX(TypeLib);
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.CMREGISTERACTIVEX(Var M:TMessage);
Var
  D:TAxControlInfo;
  HandleList:TList;
  i:Integer;

  procedure AddButton(A:TAxControlInfo);
  Var
    H:THandle;
  begin
    With A do
    begin
      H:=LoadLibrary(PChar(PictureFile));
      If H<>0 then
        HandleList.Add(Pointer(H));
      GetButtonHint(Hint);
      AddActiveX(Guid,TypeLib,Hint,H,PictureIndex);
    end;
  end;

begin

  D:=TAxControlInfo(M.wParam);
  HandleList:=TList.Create;
  With D do
  try
    If IsEqualGUID(GUID_NULL,TypeLib)
    then
      AddButton(D)
    else
      for i:=0 to D.Collection.Count-1 do
        if IsEqualGUID(TypeLib,TAxControlInfo(D.Collection.Items[i]).TypeLib) then
          AddButton(TAxControlInfo(D.Collection.Items[i]));

  finally
    for i:=0 to HandleList.Count-1 do
      FreeLibrary(Integer(HandleList[i]));
    HandleList.Free;
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.AddActiveX(Var AGuid,ATypeLib; Const AHint:string;
            APicModule:THandle;APicIndex:integer);
Var
  TabSheet:TDCPaletteSheet;
  Button:TPaletteButton;
  NeedUpdate : boolean;
begin
  NeedUpdate := PageByCaption(SPalActiveX) = nil;
  TabSheet:=TDCPaletteSheet(SheetByName(SPalActiveX));
  if NeedUpdate then
    UpdatePagePositions;
  Button:=TPaletteButton(CreateButton);
  With Button do
  begin
    Hint:=AHint;
    Tag:=ActiveXTag;
    If (APicModule<>0) and (FindResource(APicModule, PChar(APicIndex), RT_BITMAP)<>0)
    then
      Glyph.LoadFromResourceID(APicModule,APicIndex)
    else
      LoadUnknownGlyph(Glyph);
  end;
  With TButtonData(FButtonDatas.Add) do
  begin
    FButton:=Button;
    FTypeLib:=TGUID(ATypeLib);
    FGUID:=TGUID(AGUID);
  end;
  TabSheet.InsertControl(Button);
  RealignForPage(TabSheet);
  Button.Visible:=True;
end;

{-------------------------------------------------------------------------}

Function TDCCompPalette.CreateButton:TObject;
begin
  Result:=TPaletteButton.Create(Self);
  With TPaletteButton(Result) do
  begin
    {$IFDEF D3}
    Flat:=True;
    {$ENDIF}
    GroupIndex:=1;
    AllowAllUp:=False;
    Width:=cPaletteButtonSize;
    Height:=cPaletteButtonSize;
    ShowHint:=True;
    OnMouseDown:=CompMouseDown;
    OnClick:=CompClick;
    Visible:=False;
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.GetButtonHint(var AHint : string);
begin
  if Assigned(FOnGetButtonHint) then
    FOnGetButtonHint(Self, AHint);
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.UpdateHints;
var
  s : string;
  i : integer;
begin
  if not Assigned(FOnGetButtonHint) then
    exit;
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TPaletteButton then
      with TPaletteButton(Components[i]) do
      begin
        s := Hint;
        GetButtonHint(s);
        Hint := s;
      end;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.AddCompButton(const Page :string; ButtonClass:TComponentClass;PackageID:THandle);
Var
  SelectBut     : TPaletteButton;
  ButtonHint    : string;
  APage         : string;
  OldSheet      : TDCPaletteSheet;
  Sheet         : TDCPaletteSheet;
  ButtonCreated : boolean;
  bClassName    : string;
  Idx           : integer;

  function FindButton(const ACLassName:String):TPaletteButton;
  Var
    i:Integer;
  begin
    for i:=0 to ComponentCount-1 do
      if (Components[i] is TPaletteButton) and
          (Components[i].Tag<>ActiveXTag) and
        (CompareText(AClassName ,TPaletteButton(Components[i]).FClassName)=0) then
      begin
        Result:=TPaletteButton(Components[i]);
        exit;
      end;
    Result:=nil;
  end;

begin

  APage := PageByItemName(Page ,ButtonClass.ClassName);
  if (APage = '') or (CompareText(APage, SVerbHidden)=0) then
    exit;
  with TStringList(FInternalPages) do
    if Find(RemoveCharSet([' '], APage), Idx) and (CompareText(TItemRec(Objects[Idx]).Page, SVerbHidden) = 0) then
      exit;

  Sheet:=TDCPaletteSheet(SheetByName(APage));
  If (not Sheet.FButtonsLoaded) and (Sheet<>FUpdateSheet) then
    exit;

  bClassName := ButtonClass.ClassName;

  if (length(bClassName) > 0) and (CompareText(Copy(bClassName,1,Length(ClassPrefix)), ClassPrefix) = 0) then
    ButtonHint := copy(bClassName, 2, MaxInt)
  else
    ButtonHint := bClassName;

  SelectBut:=FindButton(bClassName);
  ButtonCreated:=SelectBut=nil;
  If ButtonCreated then
    SelectBut:=TPaletteButton(CreateButton);
  With TPaletteButton(SelectBut) do
  begin
    Tag:=PackageID;
    If ButtonCreated then
    begin
      GetButtonHint(ButtonHint);
      Hint:=ButtonHint;
      fClassName := bClassName;
      LoadBitmapForClass(Glyph,ButtonClass);
    end;
    OldSheet:=TDCPaletteSheet(SelectBut.Parent);
    If OldSheet<>Sheet then
    begin
      SelectBut.Parent:=Sheet;
      RealignForPage(Sheet);
      If OldSheet<>nil then
        RealignForPage(OldSheet);
    end;
    Visible:=True;
  end;
end;


{-------------------------------------------------------------------------}

procedure TDCCompPalette.RealignForPage(A:TTabSheet);
Var
  i,ATop,AWidth,ALeft,AHeight:Integer;
begin
  If (ActivePage=nil) {or (FUpdateCount>0)} then exit;
  ATop:=(-1)*TDCPaletteSheet(A).FTopLine*MouseButtonHeight;
  ALeft:=MouseButtonWidth;
  AWidth:=ActivePage.ClientWidth;
  AHeight:=ActivePage.ClientHeight;
  For i:=0 to ComponentCount-1 do
    If (Components[i] is TPaletteButton) and (TPaletteButton(Components[i]).Parent=A)
      and (Components[i].Tag<>MouseButtonTag)
    then
    With TPaletteButton(Components[i]) do
    begin
      If ALeft+Width>AWidth then
      begin
        Inc(ATop,Height);
        If ATop=0
        then
          ALeft:=MouseButtonWidth
        else
          ALeft:=0;
      end;
      Top:=ATop;
      Left:=ALeft;
      TDCPaletteSheet(A).FCanMoveDown:=(Top+Height>AHeight) or (Left>=AWidth);
      inc(ALeft,Width);
    end;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.RealignControls;
Var
  i:Integer;
begin
  For i:=0 to PageCount-1 do
  begin
    TDCPaletteSheet(Pages[i]).FTopLine:=0;
    RealignForPage(TDCPaletteSheet(Pages[i]));
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.DelActiveX(const AGUID : TGUID);
var
  i:Integer;
begin
  for i:=FButtonDatas.Count-1 downto 0 do
    with TButtonData(FButtonDatas.Items[i]) do
      if IsEqualGUID(AGUID,FGUID) or IsEqualGUID(AGUID,FTypeLib) then
      begin
        FButton.Free;
        Free;
      end;

  RealignControls;
  DeleteEmptyPages;
  SelectMouseButton;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.RefreshData;
Var
  i:Integer;
begin
  if csDesigning in ComponentState then
    exit;

  inherited;

    For i:=ComponentCount-1 downto 0 do
      if ((Components[i] is TPaletteButton)
      and (Components[i].Tag<>ActiveXTag)
      and (Components[i].Tag<>MouseButtonTag)) or
        (Components[i] is TDCPaletteSheet)
      then
        Components[i].Tag:=NeedDestroyTag;

    AddComponentsForPackage(INVALID_HANDLE_VALUE);

    For i:=ComponentCount-1 downto 0 do
      If (Components[i].Tag=NeedDestroyTag) then
      begin
        if (Components[i] is TPaletteButton) then
          Components[i].Free
        else
        if (Components[i] is TDCPaletteSheet) then
          TDCPaletteSheet(Components[i]).FButtonsLoaded:=True;
      end;

    DeleteEmptyPages;
    RealignControls;
    UpdatePagePositions;
    PagesChanged;
    SelectMouseButton;
    PostMessage(Handle,cm_ObjectChanged,0,0);
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.cmObjectChanged(Var M:TMessage);
begin
  Change;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.DeleteEmptyPages;
Var
  i:Integer;
  A:TDCPaletteSheet;
  isDeleted:Boolean;

  procedure DelMouseButton(A:TDCPaletteSheet);
  Var
    i:Integer;
  begin
    For i:=ComponentCount-1 downto 0 do
      If (Components[i] is TPaletteButton) and (TPaletteButton(Components[i]).Parent=A) then
      begin
        TPaletteButton(Components[i]).Parent:=nil;
        Components[i].Free;
      end;
  end;


  function IsEmptyPage(A:TDCPaletteSheet):Boolean;
  Var
    i:Integer;
  begin
    Result:=False;
    If not A.FButtonsLoaded then
      exit;
    for i:=0 to ComponentCount-1 do
      If (Components[i] is TPaletteButton) and (TPaletteButton(Components[i]).Parent=A)
        and (Components[i].Tag<>MouseButtonTag) then exit;
    Result:=True;
  end;


begin
  isDeleted:=False;
  For I:=PageCount-1 downto 0 do
    If isEmptyPage(TDCPaletteSheet(Pages[i])) then
    begin
      A:=TDCPaletteSheet(Pages[i]);
      DelMouseButton(A);
      A.PageControl:=nil;
      A.Parent:=nil;
      A.Free;
      isDeleted:=True;
    end;
  If (IsDeleted) then
    RefreshActivePage;
  PagesChanged;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.SetMouseGlyph(Value:TBitmap);
begin
  FMouseGlyph.Assign(Value);
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.SelectMouseButton;
begin
  FControlClass:='';
  DesignerInsertClass:='';
  FShiftState:=[];
  PressMouseButtons(nil);
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.LoadActiveXConfig;
Var
  Col:TAxControlCollection;
  TempGUID:TGUID;
  AxInfo:TAxControlInfo;
  i:Integer;
  gcount : integer;
begin
  gcount := App.GUIDS.Count;
  if gcount = 0 then
    exit;

  Col := TAxControlCollection.Create;
  with App do
    try
      for i := 0 to gcount - 1 do
      begin
        TempGUID := StringToGuid(GUIDS[i]);
        AxInfo := Col.ItemByGUID(TempGUID);
        if AxInfo <> nil then
          Perform(CM_REGISTERACTIVEX,Integer(AxInfo),0);
      end;
    finally
      Col.Free;
    end;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.InitData;
begin
  if GlogalUseActiveX then
    LoadActiveXConfig;
  inherited;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.OnInvalidate(Sender:TObject);
begin
  Invalidate;
end;

{-------------------------------------------------------------------------}

constructor TDCCompPalette.Create(AOwner:TComponent);
begin
  inherited;
  FButtonDatas:=TCollection.Create(TButtonData);
//  fEnableActiveX := true;

  AssignPalettePages(PredefinedPages);

  FMouseGlyph:=TBitmap.Create;

  LoadBitmapFromResource(FMouseGlyph, 'PAL_MOUSEGLYPH'); //don't resource

  FMouseGlyph.OnChange:=OnInvalidate;

  TabStop:=False;
  RegisterNotifier(Self);
  PaletteList.Add(Self);
  Caption:=SComPal;
end;

{-------------------------------------------------------------------------}

procedure TDCCompPalette.AddComponentsForPackage(AHandle:THandle);
var
  i : integer;
begin
  with ClassItems do
    for i := 0 to Count - 1 do
      With TClassItem(Items[i]) do
        if ((AHandle=PackageHandle) or (AHandle=INVALID_HANDLE_VALUE)) and
           (Categories * [icNoIcon, icShowinPalette] = [icShowInPalette]) and
           ClassPtr.InheritsFrom(TComponent) then
            AddCompButton(PalettePage , TComponentClass(ClassPtr) , PackageHandle);
end;

{-------------------------------------------------------------------------}

destructor TDCCompPalette.Destroy;
begin
  UnregisterNotifier(Self);
  PaletteList.Remove(Self);
  FButtonDatas.Free;
  FMouseGlyph.Free;
  inherited;
end;

{------------------------------------------------------------------}

function TDCCompPalette.GetActivePage:TTabSheet;
begin
  Result:=inherited ActivePage;
end;

{------------------------------------------------------------------}

procedure TDCCompPalette.SetActivePage(V:TTabSheet);
begin
  If V<>ActivePage then
  begin
    RefreshPage(TDCPaletteSheet(V));
    inherited ActivePage:=V;
  end;
end;


*)
{-----------TNewFormPageControl-------------------------------------}

constructor TNewFormPageControl.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FImageList := TImageList.Create(self);
  FImageList.Width := 32;
  FImageList.Height := 32;
  FNewPages := TPagesList.Create;
  AssignNewFormPages(PredefinedPages );
  NewFormControlList.Add(Self);
end;

{-------------------------------------------------------------------------}

destructor TNewFormPageControl.Destroy;
begin
  FreeSortedList(TPagesList(FNewPages),FNewPages);
  NewFormControlList.Remove(Self);
  inherited Destroy;
end;

{-------------------------------------------------------------------------}

procedure TNewFormPageControl.ListDblClick(Sender:TObject);
begin
  if assigned(OnDblClick) then
    OnDblClick(Self);
end;

{-------------------------------------------------------------------------}

procedure TNewFormPageControl.RefreshData;
var
  i: integer;

  procedure FillPages;
  Var
    i : integer;
    Tab : TTabSheet;
    ListView:TListView;
  begin
    for i:= 0 to TPagesList(FNewPages).Count - 1 do
      with TNewItemRec(TPagesList(FNewPages).Items[i]) do
      begin
        Tab := PageByCaption(Page);
        If Tab = nil then
        begin
          Tab := CreateNewTabSheet(Self);
          Tab.Caption := Page;
          ListView := TListView.Create(self);
          With ListView do
          begin
            Parent:=Tab;
            ViewStyle := vsIcon;
            LargeImages:=FImageList;
            Align:=alClient;
            HideSelection:=False;
            OnDblClick:=ListDblClick;
            ReadOnly:=True;
          end;
        end
        else
          ListView:=TListView(Tab.Controls[0]);
        If not AddIconFromAnyResource(FImageList,ResName) then
        AddIconFromAnyResource(FImageList,'NEWDEFAULT');//don't resource

        with ListView.Items.Add do
        begin
          Caption := ItemName;
          ImageIndex:=FImageList.Count-1;
          Data := Item;
        end;
        ListView.Selected:=ListView.Items[0];
        ListView.ItemFocused:=ListView.Items[0];
      end;
  end;

  procedure UpdatePages;
  begin
    FCnt := 0;
    ClearSortedList(TPagesList(FNewPages));
    ObjectParamList.ForEveryClass(_TIDEObject,[0],NewExtCallBack);
    FillPages;
  end;

begin
  if csDesigning in ComponentState then
    exit;

  inherited;

  For i:=ControlCount-1 downto 0 do
    if (Controls[i] is TTabSheet)  then
      Controls[i].Free;

  UpdatePages;
  UpdatePagePositions;
end;

{-------------------------------------------------------------------------}

procedure TNewFormPageControl.IntersectWithPages(Item : TObject;const APage , AName ,AResName :string);
var
  i : integer;
begin
  with TStringList(InternalPages) do
    if Find(RemoveCharSet([' '],AName),i) then
      with TItemRec(Objects[i]) do
        TPagesList(FNewPages).Add(TNewItemRec.Create(Item,Page,AName,AResName,Index,PageIndex))
      else
        if not OnlyDefinedItems then
        begin
          dec(Fcnt);
          TPagesList(FNewPages).Add(TNewItemRec.Create(Item,APage,AName,AResName,Fcnt,PredefinedPages.IndexOf(APage)));
        end;
end;

{-------------------------------------------------------------------------}

function TNewFormPageControl.NewExtCallBack(Item:TObjectParamListItem;const AParams:Array of variant;
      Var Finish:boolean):Variant;
Var
  PageName : string;
  ItemName : string;
  ResName  : string;
  tmp      : string;
  idx      : integer;
begin
  With Item do
  begin
    If Params[SNewPageCaption]=NULL then
      exit;
    PageName := Params[SNewPageCaption];
    ItemName := Params[SNewCaption];
    ResName  := Params[SNewResName];

    tmp := PageByItemName(PageName,RemoveCharSet([' '],ItemName));

    if (tmp = '') or (CompareText(tmp,SVerbHidden)=0) then
      exit;

     with TStringList(FInternalPages) do
      if Find(RemoveCharSet([' '], PageName), Idx) and (CompareText(TItemRec(Objects[Idx]).Page, SVerbHidden) = 0) then
        exit;

    if (Item.ClassPtr <> nil) and (CompareText(PageByItemName(PageName,Item.ClassPtr.ClassName),SVerbHidden)=0) then
      exit;
    IntersectWithPages(Item,PageName , ItemName , ResName);
  end;
end;

{-------------------------------------------------------------------------}

procedure TNewFormPageControl.LoadGlobalOptions;
begin
  with GlobalNewFormControlOptions do
    self.PredefinedPages :=  PageItems;
end;


{----------TNewItemRec-----------------------------------------------}

constructor TNewItemRec.Create(AItem:TObject;const APage,AName,AResName : string ;AIndex,APageIndex:integer);
begin
  inherited Create;
  Page      := APage;
  ItemName  := AName;
  ResName   := AResName;
  Index     := AIndex;
  PageIndex := APageIndex;
  Item      := AItem;

end;

{------------------------------------------------------------------}

function TPagesList.Compare(Item1, Item2: Pointer):integer;
  function CompareInt(a , b:integer) : integer;
  begin
    if (a >= 0) and (b >= 0) then
      result := a - b
    else
      result := b - a
  end;
begin
  result := CompareInt(TNewItemRec(Item1).PageIndex,TNewItemRec(Item2).PageIndex);
  if result = 0 then
    result := CompareInt(TNewItemRec(Item1).Index,TNewItemRec(Item2).Index);

end;

{*********************************************************************}
var
  FPaletteList : TPaletteList = nil;
  FNewFormControlList : TNewFormControlList=nil;

function TPaletteList.GetPalette (index : integer) : TDCCompPalette;
begin
  result := TDCCompPalette(Items[Index]);
end;

{------------------------------------------------------------------}

function TNewFormControlList.GetNewFormControl(index : integer) : TNewFormPageControl;
begin
  result := TNewFormPageControl(Items[Index]);
end;

{------------------------------------------------------------------}

function PaletteList : TPaletteList;
begin
  if FPaletteList = nil then
    FPaletteList := TPaletteList.Create;
  result := FPaletteList;
end;

{------------------------------------------------------------------}

function NewFormControlList : TNewFormControlList;
begin
  if FNewFormControlList = nil then
    FNewFormControlList := TNewFormControlList.Create;
  result := FNewFormControlList;
end;

function GlobalPaletteOptions : TPaletteOptions;
begin
  result := TPaletteOptions(GetOptionsByClass(TPaletteOptions));
end;

{------------------------------------------------------------------}

function GlobalNewFormControlOptions: TNewFormOptions;
begin
  result := TNewFormOptions(GetOptionsByClass(TNewFormOptions));
end;

{-----TPageControlOptions----------------------------------------------------}


constructor TPageControlOptions.Create;
begin
  FPageItems := TStringList.Create;
  inherited Create;
end;

{------------------------------------------------------------------}

destructor TPageControlOptions.Destroy;
begin
  FPageItems.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure  TPageControlOptions.SetPageItems(Value: TStrings);
begin
  FPageItems.Assign(Value);
end;

{------------------------------------------------------------------}

procedure  TPageControlOptions.PageItemsChanged(Sender : TObject);
begin
  Update;
end;

{------------------------------------------------------------------}

procedure TPageControlOptions.InitValues;
begin
  TStringList(FPageItems).OnChange := PageItemsChanged;
end;

{------------------------------------------------------------------}

procedure TPaletteOptions.Update;
var
  i : integer;
begin
  if UpdateDisabled then
    exit;

  with PaletteList do
    for i := 0 to Count - 1 do
      with Palettes[i] do
        if UseGlobalOptions then
          LoadGlobalOptions;
end;

{------------------------------------------------------------------}

function  TPaletteOptions.GetKey : string;
begin
  result := 'ComponentPalette\'; //don't resource
end;

{------------------------------------------------------------------}

procedure TPaletteOptions.InitValues;
begin
  AssignPalettePages(FPageItems);
  inherited;
end;

{-----TNewFormOptions----------------------------------------------}

procedure TNewFormOptions.Update;
var
  i : integer;
begin
  if UpdateDisabled then
    exit;

  with NewFormControlList do
    for i := 0 to Count - 1 do
      with NewFormControls[i] do
        if UseGlobalOptions then
          LoadGlobalOptions;

end;

{------------------------------------------------------------------}

function  TNewFormOptions.GetKey : string;
begin
  result := 'NewFormControl\'; //don't resource
end;

{------------------------------------------------------------------}

procedure TNewFormOptions.InitValues;
begin
  with TStringList(FPageItems) do
  begin
    BeginUpdate;
    Add(SProject);
    Add(SPageForm);
    Add(SPageReport);
    Add(SPageUnit);
    Add(SPageDataModule);
    Add(SPageNew);
    EndUpdate;
  end;
  inherited;
end;

{------------------------------------------------------------------}

{--------------------------------------------}

{procedure TDCPageControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  UpdateParamsWithBorderStyle(Params,FBorderStyle,Ctl3d);
end;}

{------------------------------------------------------------------}

{procedure TDCPageControl.SetBorderStyle(V:TBorderStyle);
begin
  If FBorderStyle<>V then
  begin
    FBorderStyle:=V;
    RecreateWnd;
  end;
end;}

{------------------------------------------------------------------}

initialization
//  InitPaletteButtons;
finalization
//  DonePaletteButtons;
  FPaletteList.Free;
  FNewFormControlList.Free;
end.
