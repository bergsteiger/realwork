//      - This has been tested to work with IE 6 and NS 6 in Delphi 6 only.  No other
//        browsers or Delphi versions have been tested.
//      - There are more features supported by the javascript that are not yet implemented
//      - When AutoPopup=False, onclicks are not being fired.
//      - Designtime rendering needs to be improved
//      ------------------------------------------------------------------------------
//

unit IWCompMenu;

interface

uses
{$IFDEF Linux}
  QControls, QGraphics, QMenus,
{$ELSE}
  Controls,
  Graphics,
  Menus,
{$ENDIF}
  Classes, IWAppForm, IWHTMLTag,
  IWControl, IWServerControllerBase, IWModuleController, IWLayoutMgr, SWSystem;

type
  TIWMenuFont = class(TPersistent)
  protected
    FOnChanged: TNotifyEvent;
    FStyle: TFontStyles;
    FSize: integer;
    FFontName: string;
    FColor: TColor;

    function GetText: string;
    procedure SetColor(Value: TColor);
    procedure SetFontName(Value: string);
    procedure SetSize(Value: integer);
    procedure SetStyle(Value: TFontStyles);
  public
    constructor Create;
  published
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property Color: TColor read FColor write SetColor;
    property Name: string read FFontName write SetFontName;
    property Size: integer read FSize write SetSize;
    property Style: TFontStyles read FStyle write SetStyle;
    property Text: string read GetText;
  end;

type
  TWIMenuItemAlignment = (maLeft, maRight, maBottom, maTop, maCenter);

const
  WIMenuItemAlignmentNames: array[TWIMenuItemAlignment] of string =
  ('left', 'right', 'bottom', 'top', 'center');

type
  TIWMenuStyle = class(TPersistent)
  protected
    FOnChanged: TNotifyEvent;
    FHeight: integer;
    FWidth: integer;
    FHighLightTextColor: TColor;
    FHighLightColor: TColor;
    FColor: TColor;
    FBorder: boolean;
    FIWFont: TIWMenuFont;
    FAlignment: TWIMenuItemAlignment;
    // Set this to 1 if you want the sub-menus of this level to "slide" open in a animated clip effect. - Value: 0 || 1
    FAnimation: boolean;
    // If you have clip spesified you can set how many pixels it will clip each timer
    // in here to control the speed of the animation. - Value: px
    FAnimationSpeed: integer;
    // This is the speed of the timer for the clip effect.
    // Play with this and the clippx to get the desired speed for the clip effect
    // (be carefull though and try and keep this value as high or possible
    // or you can get problems with NS4). - Value: milliseconds
    FAnimationInterval: integer;

    procedure Changed(Sender: TObject);
    procedure SetFont(Value: TIWMenuFont);
    procedure SetHeight(Value: integer);
    procedure SetWidth(Value: integer);
    procedure SetColor(Value: TColor);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property Alignment: TWIMenuItemAlignment read FAlignment write FAlignment;
    property Animation: boolean read FAnimation write FAnimation;
    property AnimationSpeed: integer read FAnimationSpeed write FAnimationSpeed;
    property AnimationInterval: integer read FAnimationInterval write FAnimationInterval;
    property Border: boolean read FBorder write FBorder;
    property Color: TColor read FColor write SetColor;
    property Font: TIWMenuFont read FIWFont write SetFont;
    property Height: integer read FHeight write SetHeight;
    property HighLightTextColor: TColor read FHighLightTextColor write FHighLightTextColor;
    property HighlightColor: TColor read FHighlightColor write FHighlightColor;
    property Width: integer read FWidth write SetWidth;
  end;

type
 //	this is used to create the hidden submit code
  TIWMenuItem = class(TIWControl)
  protected
    FMenuItem: TMenuItem;

    procedure Submit(const AValue: string); override;
    procedure SetMenuItem(Value: TMenuItem);
  published
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
  end;

type
  TIWMenuItemDef = class(TCollectionItem)
  protected
    FItem: TIWMenuItem;
    procedure Submit(const AValue: string);
    function GetDisplayName: string; override;
    procedure SetMenuItem(const Value: TMenuItem);
    function GetMenuItem: TMenuItem;
  public
    constructor Create(AOwner: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Item: TIWMenuItem read FItem write FItem;
  published
    property MenuItem: TMenuItem read GetMenuItem write SetMenuItem;
  end;

type
  TIWMenuItems = class(TCollection)
  protected
    FOwner: TPersistent;
    function GetItem(Index: Integer): TIWMenuItemDef;
    procedure SetItem(Index: Integer; const Value: TIWMenuItemDef);
    function GetOwner: TPersistent; override;
  public
    constructor Create(Owner: TPersistent);
    function Add: TIWMenuItemDef;
    property Items[Index: Integer]: TIWMenuItemDef read GetItem write SetItem; default;
  end;

type
  TIWMenuOrientation = (iwOHorizontal, iwOVertical);
  TIWSpaceItems = (itsNone, itsEvenlySpaced);
  TIWMenuAutoSize = (mnaNone, mnaFullWidth, mnaFullHeight);

  TIWMenu = class(TIWControl)
  protected
    FAutoSize: TIWMenuAutoSize;
    FAttachedMenu: TMainMenu;
    FTimeOut: integer;
    FMenuLeft: integer;
    FMenuTop: integer;
    FPadding: integer;
    FTextOffset: integer;
    FItemSpacing: TIWSpaceItems;
    FAutoPopup: boolean;
    FFrameName: string;
    //FMenuHeight: integer;
    //FMenuWidth: integer;
    FMenuStyle: TIWMenuStyle;
    FMenuItemStyle: TIWMenuStyle;
    FOrientation: TIWMenuOrientation;
    FItems: TIWMenuItems;
    //
    procedure SetIWAutoSize(const Value: TIWMenuAutoSize);
    procedure OnChanged(Sender: TObject);
    procedure SetMenuStyle(Value: TIWMenuStyle);
    procedure SetMenuItemStyle(Value: TIWMenuStyle);
    procedure SetOrientation(Value: TIWMenuOrientation);
    procedure SetAttachedMenu(Value: TMainMenu);
    procedure SetItemSpacing(Value: TIWSpaceItems);
    procedure SetAutoPopup(Value: boolean);
    procedure SetItems(Value: TIWMenuItems);
    procedure SetPadding(Value: integer);
    procedure SetTextOffset(Value: integer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function RenderHTML: TIWHTMLTag; override;
    {property MenuLeft: integer read FMenuLeft write FMenuLeft;
    property MenuTop: integer read FMenuTop write FMenuTop;}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Submit(const AValue: string); override;

    property TextOffset: integer read FTextOffset;
  published
    property AttachedMenu: TMainMenu read FAttachedMenu write SetAttachedMenu;
    property ItemSpacing: TIWSpaceItems read FItemSpacing write SetItemSpacing;
    //property AutoPopup: boolean read FAutoPopup write SetAutoPopup; KNOWN BUG: when false, onclicks will not work.  Just commented out to reduce confusion.
    property AutoSize: TIWMenuAutoSize read FAutoSize write SetIWAutoSize;
    property MenuStyle: TIWMenuStyle read FMenuStyle write SetMenuStyle;
    property MenuItemStyle: TIWMenuStyle read FMenuItemStyle write SetMenuItemStyle;
    property Orientation: TIWMenuOrientation read FOrientation write SetOrientation;
    property TimeOut: integer read FTimeOut write FTimeOut;

    // Removed properties from ver 1.0
    //property Items: TIWmenuItems read FItems write SetItems;  Hiding to simplify use.
    //property FrameName: string read FFrameName write FFrameName; not compatible with iw4.x
    //property MenuHeight: integer read FMenuHeight write SetMenuHeight;
    //property MenuWidth: integer read FMenuWidth write SetMenuWidth;
    //property Padding: integer read FPadding write SetPadding;

  end;
// Procs used during Paint
function FixCaption(Value: string): string;

implementation

uses
{$IFDEF Linux}
  QForms,
  Types,
{$ELSE}
  Forms,
  Windows,
{$ENDIF}
  IWApplication, SysUtils, IWServer, IWForm;

type
  TCharSet = set of char;

function TrimCharRight(Value: string; Chars: TCharSet): string;
begin
  if Value <> '' then
  begin
    while (Length(Value) > 0) and (Value[Length(Value)] in Chars) do
      delete(Value, Length(Value), 1);
  end;
  Result := Value;
end;

function TrimCharLeft(Value: string; Chars: TCharSet): string;
begin
  if Length(Value) > 0 then
  begin
    while (Length(Value) > 0) and (Value[1] in Chars) do
      delete(Value, 1, 1);
  end;
  Result := Value;
end;

function FixCaption(Value: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to length(value) do
  begin
    if value[i] <> '&' then
      Result := Result + Value[i];
  end;
end;

//
//	Make sure that the double quotes (") are correctly formatted
//

function DQuoteStr(const Value: string): string;
begin
  Result := '"' + TrimCharRight(TrimCharLeft(Value, ['''', '"']), ['''', '"']) + '"';
end;

{ TIWMenuItem }

procedure TIWMenuItem.Submit(const AValue: string);
begin
  if Assigned(FMenuItem) then
  begin
    if Assigned(FMenuItem.OnClick) then
      FMenuItem.OnClick(FMenuItem);
  end;
end;

procedure TIWMenuItem.SetMenuItem(Value: TMenuItem);
begin
  FMenuItem := Value;
end;

{ TIWMenuStyle }

constructor TIWMenuStyle.Create;
begin
  inherited Create;
  Alignment := maBottom;
  Animation := false;
  AnimationSpeed := 4;
  AnimationInterval := 20;
  FHeight := 20;
  FWidth := 100;
  FHighLightTextColor := clHighlightText;
  FHighlightColor := clHighlight;
  FColor := clMenu;
  FBorder := true;
  // Set the Font defaults
  FIWFont := TIWMenuFont.Create;
  FIWFont.OnChanged := Changed;
  FIWFont.Name := 'arial,helvetica';
  FIWFont.Size := 12;
  FIWFont.Style := [fsbold];
  FIWFont.Color := clWindowText;
end;

destructor TIWMenuStyle.Destroy;
begin
  FreeAndNil(FIWFont);
  inherited;
end;

procedure TIWMenuStyle.Changed(Sender: TObject);
begin
  if Assigned(OnChanged) then
    OnChanged(Self);
end;

procedure TIWMenuStyle.SetFont(Value: TIWMenuFont);
begin
  FIWFont.Assign(Value);
  Changed(Self);
end;

procedure TIWMenuStyle.SetHeight(Value: integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    Changed(Self);
  end;
end;

procedure TIWMenuStyle.SetWidth(Value: integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    Changed(Self);
  end;
end;

procedure TIWMenuStyle.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed(Self);
  end;
end;

{ TIWMenuFont }

constructor TIWMenuFont.Create;
begin
  inherited Create;
  FFontName := 'arial,helvetica';
  FSize := 12;
  FStyle := [fsBold];
end;

procedure TIWMenuFont.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if Assigned(OnChanged) then
      OnChanged(Self);
  end;
end;

procedure TIWMenuFont.SetFontName(Value: string);
begin
  if FFontName <> Value then
  begin
    FFontName := Value;
    if Assigned(OnChanged) then
      OnChanged(Self);
  end;
end;

procedure TIWMenuFont.SetSize(Value: integer);
begin
  if FSize <> Value then
  begin
    FSize := Value;
    if Assigned(OnChanged) then
      OnChanged(Self);
  end;
end;

procedure TIWMenuFont.SetStyle(Value: TFontStyles);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    if Assigned(OnChanged) then
      OnChanged(Self);
  end;
end;

function TIWMenuFont.GetText: string;
var
  Temp: string;
begin
  Temp := '';
  if FFontName <> '' then
    Temp := Temp + 'font-family:' + FFontName + ';';
  if FSize > 0 then
    Temp := Temp + 'font-size:' + IntToStr(FSize) + 'px;';

  if FStyle <> [] then
  begin
    if fsBold in FStyle then
      Temp := Temp + 'font-weight:bold;';
    if fsItalic in FStyle then
      Temp := Temp + 'font:italic;';
    if fsUnderline in FStyle then
      Temp := Temp + 'text-decoration:underline;';
  end;
  Result := Temp;
end;

{ TIWMenu }

constructor TIWMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FItems := TIWMenuItems.Create(Self);
  FMenuStyle := TIWMenuStyle.Create;
  FMenuItemStyle := TIWMenuStyle.Create;

  FMenuStyle.OnChanged := OnChanged;
  FMenuItemStyle.OnChanged := OnChanged;

  //FrameName := ''; // No frames
  //MenuWidth := -1; // full screen width
  FAutoSize := mnaNone;
  Orientation := iwOHorizontal;
  TimeOut := 1000;
  Height := 20;
  Width := 200;
  FTextOffset := 30;
  ItemSpacing := itsNone;
  FAutoPopUp := true;
  FRenderSize := true;

  FSupportsSubmit := true;

  if not FDesignMode then begin
    GIWServer.AddInternalFile('IW_JS_IWMENU');
  end;

  with FMenuStyle do
  begin
    Height := 20;
    Width := 100;
    HighlightColor := clHighLight;
    HighLightTextColor := clHighLightText;
    Color := clMenu;
    Border := false;
    Font.Name := 'arial,helvetica';
    Font.Size := 12;
    Font.Style := [fsBold];
    Font.Color := clMenuText;
  end;

  with FMenuItemStyle do
  begin
    Height := 18;
    Width := 120;
    HighlightColor := clHighLight;
    HighLightTextColor := clHighLightText;
    Color := clMenu;
    Border := true;
    Font.Name := 'arial,helvetica';
    Font.Size := 11;
    Font.Style := [fsBold];
    Font.Color := clMenuText;
  end;
end;

destructor TIWMenu.Destroy;
begin
  FreeAndNil(FMenuStyle);
  FreeAndNil(FMenuItemStyle);
  FreeAndNil(FItems);
  inherited;
end;

procedure TIWMenu.SetOrientation(Value: TIWMenuOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    Invalidate;
  end;
end;

procedure TIWMenu.SetMenuStyle(Value: TIWMenuStyle);
begin
  FMenuStyle.Assign(Value);
  Invalidate;
end;

procedure TIWMenu.SetMenuItemStyle(Value: TIWMenuStyle);
begin
  FMenuItemStyle.Assign(Value);
  Invalidate;
end;

procedure TIWMenu.SetAttachedMenu(Value: TMainMenu);
begin
  FAttachedMenu := Value;
  Invalidate;
end;

procedure TIWMenu.SetItemSpacing(Value: TIWSpaceItems);
begin
  if FItemSpacing <> Value then
  begin
    FItemSpacing := Value;
    if FItemSpacing = itsNone then
      FAutoSize := mnaNone;

    Invalidate;
  end;
end;

procedure TIWMenu.SetAutoPopup(Value: boolean);
begin
  if FAutoPopup <> Value then
  begin
    FAutoPopup := Value;
    Invalidate;
  end;
end;

procedure TIWMenu.SetItems(Value: TIWMenuItems);
begin
  FItems := Value;
  Invalidate;
end;

procedure TIWMenu.SetPadding(Value: integer);
begin
  if FPadding <> Value then
  begin
    FPadding := Value;
    Invalidate;
  end;
end;

procedure TIWMenu.SetTextOffset(Value: integer);
begin
  if FTextOffset <> Value then
  begin
    FTextOffset := Value;
    Invalidate;
  end;
end;

procedure TIWMenu.OnChanged(Sender: TObject);
begin
  Invalidate;
end;

//
//	THIS IS THE JAVASCRIPT/HTML VERSION OF THE CODE
//

function TIWMenu.RenderHTML: TIWHTMLTag;
var
  MenuName: string;

  function AddMenuProperty(Option: string; Value: string): string; overload;
  begin
    Result := MenuName + '.' + Option + '=' + DQuoteStr(Value) + ';' + EOL;
  end;

  function AddMenuProperty(Option: string; Value: integer): string; overload;
  begin
    Result := MenuName + '.' + Option + '=' + IntToStr(Value) + ';' + EOL;
  end;

  function AddProperty(Option: string; Value: string): string; overload;
  begin
    Result := Option + '=' + DQuoteStr(Value) + ';' + EOL;
  end;

  function AddProperty(Option: string; Value: integer): string; overload;
  begin
    Result := Option + '=' + IntToStr(Value) + ';' + EOL;
  end;

  function SetMenuProperties(MenuLevel: integer; AMenuStyle: TIWMenuStyle;
    AOffsetX: integer; AOffsetY: integer): string;
  var
    MenuLevelStr: string;
  begin
    MenuLevelStr := MenuName + '.level[' + IntToStr(MenuLevel) + ']';
    // Apply a default Font Style
    if AMenuStyle.Font.Name = '' then
    begin
      AMenuStyle.Font.Name := 'arial,helvetica';
      AMenuStyle.Font.size := 12;
      AMenuStyle.Font.Style := [fsbold];
    end;

    Result := MenuLevelStr + '=new Array(); ' + EOL
      + MenuLevelStr + '.width=' + IntToStr(AMenuStyle.Width) + ';' + EOL
      + MenuLevelStr + '.height=' + IntToStr(AMenuStyle.Height) + ';' + EOL
      + MenuLevelStr + '.bgcoloroff=' + DQuoteStr(ColorToRGBString(AMenuStyle.Color)) + ';' + EOL
      + MenuLevelStr + '.bgcoloron=' + DQuoteStr(ColorToRGBString(AMenuStyle.HighlightColor)) + ';' + EOL
      + MenuLevelStr + '.textcolor=' + DQuoteStr(ColorToRGBString(AMenuStyle.Font.Color)) + ';' + EOL
      + MenuLevelStr + '.hovercolor=' + DQuoteStr(ColorToRGBString(AMenuStyle.HighLightTextColor)) + ';' + EOL
      + MenuLevelStr + '.style=' + DQuoteStr(AMenuStyle.Font.Text) + ';' + EOL;

    if AMenuStyle.Animation then
    begin
      // Include animation (if required)
      Result := Result
        + MenuLevelStr + '.clip=' + IntToStr(Ord(AMenuStyle.Animation)) + ';' + EOL
        + MenuLevelStr + '.clippx=' + IntToStr(AMenuStyle.AnimationSpeed) + ';' + EOL
        + MenuLevelStr + '.cliptim=' + IntToStr(AMenuStyle.AnimationInterval) + ';' + EOL;
    end;

    //	Fix these
    Result := Result
      + MenuLevelStr + '.border=' + IntToStr(Ord(AMenuStyle.Border)) + ';' + EOL
      + MenuLevelStr + '.bordercolor=' + DQuoteStr(ColorToRGBString(AMenuStyle.HighlightColor)) + ';' + EOL
      + MenuLevelStr + '.offsetX=' + IntToStr(AOffsetX) + ';' + EOL
      + MenuLevelStr + '.offsetY=' + IntToStr(AOffsetY) + ';' + EOL
      + MenuLevelStr + '.align=' + DQuoteStr(WIMenuItemAlignmentNames[AMenuStyle.Alignment]) + ';' + EOL;
  end;

  function CreateMenu(FunctionName: string; ParentMenu: string; AText: string;
    LinkAddr: string;
    Target: string = '';
    AWidth: integer = 0;
    AHeight: integer = 0;
    AImage1: string = '';
    AImage2: string = '';
    AColor: TColor = clMenu;
    AHighlightColor: TColor = clHighLight;
    ATextColor: TColor = clMenuText;
    AHighLightTextColor: TColor = clHighlightText;
    AOnClickEvent: string = '';
    AOnMouseOverEvent: string = '';
    AOnMouseOutEvent: string = ''
    ): string;
  begin
    //  if Seperator then make visible area as small as possible
    //  this is a temporary fix, until something better comes along
    if AText = '-' then
      AHeight := 1;
    //	No need to send redundant info when not required
    //	!! need to check to which options are ACTUALLY REQUIRED for menu to work correctly
    if (AWidth > 0) or (AHeight > 0) or (AOnClickEvent <> '') then
    begin
      Result := MenuName + '.makeMenu(' + QuotedStr(FunctionName) + ',' +
        QuotedStr(ParentMenu) + ',' +
        QuotedStr('&nbsp;' + AText) + ',' +
        QuotedStr(LinkAddr) + ',' +
        QuotedStr(Target) + ',' +
        IntToStr(AWidth) + ',' +
        IntToStr(AHeight) + ',' +
        QuotedStr(AImage1) + ',' +
        QuotedStr(AImage2) + ',' +
        QuotedStr(ColorToRGBString(AColor)) + ',' +
        QuotedStr(ColorToRGBString(AHighlightColor)) + ',' +
        QuotedStr(ColorToRGBString(ATextColor)) + ',' +
        QuotedStr(ColorToRGBString(AHighLightTextColor)) + ',' +
        QuotedStr(AOnClickEvent) + ',' +
        QuotedStr(AOnMouseOverEvent) + ',' +
        QuotedStr(AOnMouseOutEvent) +
        ');' + EOL;
    end else
    begin
      Result := MenuName + '.makeMenu(' + QuotedStr(FunctionName) + ',' +
        QuotedStr(ParentMenu) + ',' +
        QuotedStr('&nbsp;' + AText) + ',' +
        QuotedStr(LinkAddr) + ',' +
        QuotedStr(Target) +
        ');' + EOL;
    end;
  end;

  function AddSubMenu(FunctionName: string; ParentMenu: string; AText: string; LinkAddr: string;
    Target: string = '';
    AWidth: integer = 0; AHeight: integer = 0;
    AImage1: string = '';
    AImage2: string = '';
    AColor: TColor = clMenu;
    AHighlightColor: TColor = clHighlight;
    ATextColor: TColor = clMenuText;
    AHighlightTextColor: TColor = clHighlightText;
    AOnClickEvent: string = '';
    AOnMouseOverEvent: string = '';
    AOnMouseOutEvent: string = ''
    ): string;
  begin
    Result := CreateMenu(FunctionName, ParentMenu, AText, LinkAddr, Target,
      AWidth, AHeight, AImage1, AImage2,
      AColor, AHighlightColor, ATextColor, AHighlightTextColor,
      AOnClickEvent, AOnMouseOverEvent, AOnMouseOutEvent);
  end;

  function AddMainMenu(FunctionName: string;
    AText: string;
    LinkAddr: string = '';
    Target: string = '';
    AWidth: integer = 0;
    AHeight: integer = 0;
    AImage1: string = '';
    AImage2: string = '';
    AColor: TColor = clMenu;
    AHighlightColor: TColor = clHighlight;
    ATextColor: TColor = clMenuText;
    AHighlightTextColor: TColor = clHighlightText;
    AOnClickEvent: string = '';
    AOnMouseOverEvent: string = '';
    AOnMouseOutEvent: string = ''
    ): string;
  begin
    Result := CreateMenu(FunctionName, '', AText, LinkAddr, Target,
      AWidth, AHeight, AImage1, AImage2,
      AColor, AHighlightColor, ATextColor, AHighlightTextColor,
      AOnClickEvent, AOnMouseOverEvent, AOnMouseOutEvent)
  end;

  //
  //	Auto-Create the submit links if none where manually created
  //
  procedure BuildSubMenusSubmit(SubMenuItem: TMenuItem);
  var
    IDX: integer;
    ASubItem: TMenuItem;
    TempDef: TIWMenuItemDef;
  begin
    for IDX := 0 to SubMenuItem.Count - 1 do
    begin
      ASubItem := SubMenuItem.Items[IDX];
      if ASubItem.Visible and ASubItem.Enabled then
      begin
        TempDef := FItems.Add;
        TempDef.MenuItem := ASubItem;
        Owner.InsertComponent(TempDef.Item);
        //TIWAppForm(Owner).AddToControlList(TempDef.Item,'');

        // Recurse any sub-menus
        if ASubItem.Count > 0 then
          BuildSubMenusSubmit(ASubItem);
      end;
    end; // for
  end;

  //
  //  Create the sub-menu items and events
  //
  procedure BuildSubMenus(var MenuItems: string; ParentName: string; SubMenuItem: TMenuItem);
  var
    IDX, IDx2: integer;
    ASubItem: TMenuItem;
    AName: string;
    OnClickEvent: string;
  begin
    for IDX := 0 to SubMenuItem.Count - 1 do
    begin
      ASubItem := SubMenuItem.Items[IDX];
      if ASubItem.Visible and ASubItem.Enabled then
      begin
        //	Build the Submit event based on the Attached MenuItem, exclude Seperators "-"
        OnClickEvent := '';
        if (ASubItem.Caption <> '-') and (Assigned(ASubItem.OnClick)) then
        begin
          for IDx2 := 0 to FItems.Count - 1 do
          begin
            if FItems.Items[idx2].MenuItem = ASubItem then
            begin
              OnClickEvent :=
                'parent.SubmitClick("' + HTMLName + '", "' + FItems.Items[idx2].Item.Name + '")';
                // 'parent.SubmitClick("' + FItems.Items[idx2].Item.Name + '")';
              break;
            end;
          end; //	for
        end; //	if

        AName := ParentName + '_' + IntToStr(IDX);
        MenuItems := MenuItems + AddSubMenu(AName, ParentName,
          {Text} FixCaption(ASubItem.Caption),
          {LinkAddr}'', {Target} '',
          {AWidth} 0, {AHeight} 0,
          {Image1}'', {Image2} '',
          MenuItemStyle.Color, MenuItemStyle.HighlightColor,
          MenuItemStyle.Font.Color, MenuItemStyle.HighlightTextColor,
          OnClickEvent, {OnMouseOverEvent} '', {AOnMouseOutEvent} '');
        // Recurse any sub-menus
        if ASubItem.Count > 0 then
          BuildSubMenus(MenuItems, AName, ASubItem);
      end;
    end; // for
  end;

var
  MenuItemCount: integer;
  ASubItem: TMenuItem;
  IDx, IDx2: integer;
  MenuItems: string;
  Properties: string;
  TempDef: TIWMenuItemDef;
begin
  Result := nil;
  if Assigned(FAttachedMenu) and (FAttachedMenu.Items.Count > 0) then
  begin
    // Make the Attached Menu's name the actual menu Name
    MenuName := HTMLName + '_comp';
    MenuItems := '';
    MenuItemCount := FAttachedMenu.Items.Count;

    if FItems.Count = 0 then
    begin
      //  Auto-Create the submit links if none where manually created
      for IDX := 0 to MenuItemCount - 1 do
      begin
        ASubItem := FAttachedMenu.Items[IDX];
        if ASubItem.Visible and ASubItem.Enabled then
        begin
          TempDef := FItems.Add;
          TempDef.MenuItem := ASubItem;
          Owner.InsertComponent(TempDef.Item);
          if ASubItem.Count > 0 then
            BuildSubMenusSubmit(ASubItem);
        end;
      end; // for
    end else
    begin
      // Auto link the Submit links to the Owner form
      // you need this to make sure intraweb creates the necessary submit code
      for IDx := 0 to FItems.Count - 1 do
      begin
        // Need to check if the Submit code/component was previously attached
        // this occurs when refreshing a page
        if Owner.FindComponent(FItems.Items[idx].Item.Name) = nil then
          Owner.InsertComponent(FItems.Items[idx].Item);
      end; //	for
    end;

    // Create the Menus
    MenuItemCount := FAttachedMenu.Items.Count;

    for IDX := 0 to MenuItemCount - 1 do
    begin
      ASubItem := FAttachedMenu.Items[IDX];
      if ASubItem.Visible and ASubItem.Enabled then
      begin
        if ASubItem.Count > 0 then
        begin
          MenuItems := MenuItems + AddMainMenu('mnu' + IntToStr(IDX), FixCaption(FAttachedMenu.Items[IDX].Caption));
          BuildSubMenus(MenuItems, 'mnu' + IntToStr(IDX), ASubItem);
        end else
        begin
   //	Build the Submit event based on the Attached MenuItem, exclude Seperators "-"
          //	Main Menu Item without Sub-Menus
          if (ASubItem.Caption <> '-') and (Assigned(ASubItem.OnClick)) then
          begin
            for IDx2 := 0 to FItems.Count - 1 do
            begin
              if FItems.Items[idx2].MenuItem = ASubItem then
              begin
                MenuItems := MenuItems + AddMainMenu('mnu' + IntToStr(IDX), {Text} ASubItem.Caption,
                      {LinkAddr}'', {Target} '',
                             {AWidth} 0, {AHeight} 0,
                             {Image1}'', {Image2} '',
                  MenuStyle.Color, MenuStyle.HighlightColor,
                  MenuStyle.Font.Color, MenuStyle.HighlightTextColor,
                  // 'parent.SubmitClick("' + FItems.Items[idx2].Item.Name + '")',
                  'parent.SubmitClick("' + HTMLName + '", "' + FItems.Items[idx2].Item.Name + '")',
                             {OnMouseOverEvent}'', {AOnMouseOutEvent} '');
                break;
              end;
            end; //	for
          end; //	if
        end;
      end;
    end;
  end else
    exit;
  //------------------------------------------------
  //  Menu is assumed to be attached at this point,
  //  otherwise there's no point in creating the script
  //------------------------------------------------
  Properties := AddMenuProperty('useNS4links', 1)
    + AddMenuProperty('checkselect', 0)
    + AddMenuProperty('pagecheck', 1)
    + AddMenuProperty('useclick', Ord(not FAutoPopup))
    + AddMenuProperty('checkscroll', 2)
    + AddMenuProperty('resizecheck', 1)
    + AddMenuProperty('wait', FTimeOut)
    + AddMenuProperty('usebar', 1)
    + AddMenuProperty('barcolor', ColorToRGBString(FMenuStyle.Color));
  {if FrameName <> '' then
  begin
    // use frames ??
    Properties := Properties + AddMenuProperty('useframes', 1) + AddMenuProperty('frame', FrameName)
  end;}
  Properties := Properties + AddMenuProperty('useframes', 0);

  // Check for maximum width/Height settings
  if FAutoSize = mnaFullWidth then
    Properties := Properties + AddMenuProperty('barwidth', '100%')
  else
    Properties := Properties + AddMenuProperty('barwidth', MenuStyle.Width);

  if FAutoSize = mnaFullHeight then
    Properties := Properties + AddMenuProperty('barheight', '100%')
  else
    Properties := Properties + AddMenuProperty('barheight', MenuStyle.Height);

  if Orientation = iwOHorizontal then
  begin
    Properties := Properties + AddMenuProperty('bary', 'menu')
      + AddMenuProperty('barx', '0')
      + AddMenuProperty('rows', 1) // only one row
  end else
  begin
    Properties := Properties + AddMenuProperty('bary', '0')
      + AddMenuProperty('barx', 'menu')
      + AddMenuProperty('rows', 0)
  end;

  Properties := Properties + AddMenuProperty('barinheritborder', 0)
    + AddMenuProperty('fromleft', Left)
    + AddMenuProperty('fromtop', Top)
    + AddMenuProperty('pxbetween', FPadding);

  if FItemSpacing = itsEvenlySpaced then
  begin
    if Orientation = iwOHorizontal then
    begin
      Properties := Properties + AddProperty('avail', IntToStr(FTextOffset) + '+((toppage.x2-' + IntToStr(FTextOffset { + 30}) + ')/' + IntToStr(MenuItemCount) + ')');
      // Set Padding of Main Menu Items
      Properties := Properties + MenuName + '.menuplacement=new Array(' + IntToStr(FTextOffset) + ',avail';
      for IDX := 2 to MenuItemCount - 2 do
        Properties := Properties + ',avail+"*' + IntToStr(IDX) + '"';
      Properties := Properties + ',avail+"*' + IntToStr(MenuItemCount - 1) + '");' + EOL;
    end else
    begin
      Properties := Properties + AddProperty('avail', IntToStr(FTextOffset) + '+((toppage.y2-' + IntToStr(FTextOffset { + 30}) + ')/' + IntToStr(MenuItemCount) + ')');
      // Set Padding of Main Menu Items
      Properties := Properties + MenuName + '.menuplacement=new Array(' + IntToStr(FTextOffset) + ',avail';
      for IDX := 2 to MenuItemCount - 2 do
        Properties := Properties + ',avail+"*' + IntToStr(IDX) + '"';
      Properties := Properties + ',avail+"*' + IntToStr(MenuItemCount - 1) + '");' + EOL;
    end;
  end else
  begin
    if Orientation = iwOHorizontal then
    begin
      Properties := Properties + AddProperty('avail', FTextOffset);
      // Set Padding of Main Menu Items
      Properties := Properties + MenuName + '.menuplacement=new Array(' + IntToStr(FTextOffset);
      for IDX := 1 to MenuItemCount - 1 do
        Properties := Properties + ',' + IntToStr(FTextOffset + (MenuStyle.Width * IDX));
      Properties := Properties + ');' + EOL;
    end else
    begin
      Properties := Properties + AddProperty('avail', FTextOffset);
      // Set Padding of Main Menu Items
      Properties := Properties + MenuName + '.menuplacement=new Array(' + IntToStr(FTextOffset);
      for IDX := 1 to MenuItemCount - 1 do
        Properties := Properties + ',' + IntToStr(FTextOffset + ((MenuStyle.Height * IDX)));
      Properties := Properties + ');' + EOL;
    end;
  end;

  // Set Main Menu and Sub-Menu Styles
  Properties := Properties + SetMenuProperties(0 {MainMenu items}, FMenuStyle, 0, 0)
    + SetMenuProperties(1 {all-Sub-menu items}, FMenuItemStyle, -1, -1);

  AddScriptFile('/js/IWMenu.js');

  Result := TIWHTMLTag.CreateTag('DIV'); try
    Result.AddStringParam('ID', HTMLName);
    Result.AddStringParam('NAME', HTMLName);
    with Result.Contents.AddTag('script') do begin
      AddStringParam('language', 'Javascript');
      Contents.AddText(MenuName + ' = new makeCompMenu(' + DQuoteStr(MenuName) + ');' + EOL
        + Properties + EOL
        + MenuItems + EOL
        + MenuName + '.makeStyle();' + EOL
        + MenuName + '.construct();');
    end;
  except FreeAndNil(Result); raise; end;
end;

procedure TIWMenu.Notification(AComponent: TComponent;
  Operation: TOperation);
{Var
  i: integer;}  
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then begin
    if AComponent = FAttachedMenu then
    begin
      FAttachedMenu := nil;
      Invalidate;
    end;
  end;
  if not (csDesigning in ComponentState) and (AComponent is TMenuItem) then begin
    {if Operation = opRemove then begin
      for i := 0 to FItems.Count - 1 do
        if FItems[i].MenuItem = AComponent then begin
          FItems.Delete(i);
          break;
        end;
    end;
    if Operation = opInsert then begin}
      FItems.Clear;
    // end;
  end;
end;

procedure TIWMenu.SetIWAutoSize(const Value: TIWMenuAutoSize);
begin
  FAutoSize := Value;
  if Value <> mnaNone then
    ItemSpacing := itsEvenlySpaced;
  Invalidate;
end;

procedure TIWMenu.Submit(const AValue: string);
Var
  LIWMenuItem: TIWControl;
begin
  LIWMenuItem := TIWControl(Owner.FindComponent(AValue));
  if (LIWMenuItem <> nil) and (LIWMenuItem is TIWMenuItem) then begin
    LIWMenuItem.DoSubmit('');
  end;
end;

{ TIWMenuItemDef }

constructor TIWMenuItemDef.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  FItem := TIWMenuItem.Create(nil);
  FItem.FSupportsSubmit := True;
  FItem.FSupportedScriptEvents := 'OnClick';
    //	this is what we will prefix all submit components with to make them unique (?)
  FItem.Name := 'sub';
end;

destructor TIWMenuItemDef.Destroy;
begin
  FreeAndNil(FItem);
  inherited Destroy;
end;

procedure TIWMenuItemDef.Submit(const AValue: string);
begin
  if Assigned(FItem) then
  begin
    if Assigned(FItem.FMenuItem) then
    begin
      if Assigned(FItem.FMenuItem.OnClick) then
        FItem.FMenuItem.OnClick(FItem.FMenuItem);
    end;
  end;
end;

procedure TIWMenuItemDef.Assign(Source: TPersistent);
begin
  if Source is TIWMenuItemDef then
    FItem.FMenuItem := TIWMenuItemDef(Source).FItem.FMenuItem
  else
    inherited Assign(Source);
end;

function TIWMenuItemDef.GetDisplayName: string;
begin
  if Assigned(FItem) then
  begin
    if Assigned(FItem.FMenuItem) then
      Result := FItem.FMenuItem.Name;
    if Result = '' then
    begin
      Result := inherited GetDisplayName;
    end;
  end else
    Result := inherited GetDisplayName;
end;

procedure TIWMenuItemDef.SetMenuItem(const Value: TMenuItem);
begin
  if Assigned(FItem) then
  begin
    FItem.MenuItem := Value;
    // prefix all submit components with "Sub"to make them unique (?)
    FItem.Name := 'sub' + Value.Name;
  end;
end;

function TIWMenuItemDef.GetMenuItem: TMenuItem;
begin
  if Assigned(FItem) then
    Result := FItem.MenuItem
  else
    Result := nil;
end;

{ TIWMenuItems }

function TIWMenuItems.Add: TIWMenuItemDef;
begin
  Result := TIWMenuItemDef(inherited Add);
end;

constructor TIWMenuItems.Create(Owner: TPersistent);
begin
  inherited Create(TIWMenuItemDef);
  FOwner := Owner;
end;

function TIWMenuItems.GetItem(Index: Integer): TIWMenuItemDef;
begin
  Result := TIWMenuItemDef(inherited GetItem(Index));
end;

function TIWMenuItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TIWMenuItems.SetItem(Index: Integer; const Value: TIWMenuItemDef);
begin
  inherited SetItem(Index, Value);
end;

end.



