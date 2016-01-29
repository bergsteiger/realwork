unit IWHTMLControls;
{PUBDIST}

interface

uses
  Classes,
  IWHTMLTag,
  IWScriptEvents,
  IWControl;

type
  TIWHRule = class(TIWControl)
  //TODO: add a percentage prop
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML: TIWHTMLTag; override;
  published
  end;

  TIWList = class(TIWControl)
  protected
    FNumbered: Boolean;
    FItems: TStrings;
    //
    procedure SetItems(AValue: TStrings);
    procedure SetNumbered(const AValue: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
  published
    property Font;
    property Items: TStrings read FItems write SetItems;
    property Numbered: boolean read FNumbered write SetNumbered;
  end;

  TIWLinkBase = class(TIWControl)
  public
    constructor Create(AOwner: TComponent); override;
    function RenderStyle: string; override;
  published
    property Color;
    property Caption;
    property Enabled;
    property ExtraTagParams;
    property Font;
    property ScriptEvents;
  end;

  TIWURLTarget = class(TPersistent)
  protected
    FHeight: integer;
    FLeft: integer;
    FResizable: boolean;
    FScrollbars: boolean;
    FToolbar: Boolean;
    FTop: integer;
    FWidth: integer;
    FWindowName: string;
  public
    constructor Create; virtual;
  published
    property Height: Integer read FHeight write FHeight;
    property Left: Integer read FLeft write FLeft;
    property Resizable: Boolean read FResizable write FResizable;
    property Scrollbars: boolean read FScrollbars write FScrollbars;
    property Toolbar: Boolean read FToolbar write FToolbar;
    property Top: Integer read FTop write FTop;
    property Width: Integer read FWidth write FWidth;
    property WindowName: string read FWindowName write FWindowName;
  end;

  TIWLink = class(TIWLinkBase)
  protected
    procedure Submit(const AValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML: TIWHTMLTag; override;
    procedure HookEvents(AScriptEvents: TIWScriptEvents); override;
  published
    property DoSubmitValidation;
    //
    property OnClick;
  end;

  TIWCustomURL = class(TIWLinkBase)
  protected
    FTargetOptions: TIWURLTarget;
    FTerminateApp: boolean;
    FUseTarget: boolean;
    FURL: string;
    //
    procedure SetTerminateApp(const AValue: boolean);
    procedure SetUseTarget(const AValue: boolean);
    procedure HookEvents(AScriptEvents: TIWScriptEvents); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
  published
    property TargetOptions: TIWURLTarget read FTargetOptions write FTargetOptions;
    property TerminateApp: boolean read FTerminateApp write FTerminateApp;
    property UseTarget: boolean read FUseTarget write FUseTarget;
  end;

  TIWURL = class(TIWCustomURL)
  published
    property URL: string read FURL write FURL;
  end;

  TWIAppletAlignment = (aaTop, aaMiddle, aaBottom, aaLeft, aaRight);

  TIWApplet = class(TIWControl)
  protected
    FAlignment: TWIAppletAlignment;
    FAltText: string;
    FAppletName: string;
    FArchive: string;
    FClassFile: string;
    FCodeBase: string;
    FHorizSpace: Integer;
    FParams: TStrings;
    FVertSpace: Integer;
    //
    procedure SetParams(const AValue: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
  published
    property Alignment: TWIAppletAlignment read FAlignment write FAlignment;
    property AltText: string read FAltText write FAltText;
    property AppletName: string read FAppletName write FAppletName;
    property Archive: string read FArchive write FArchive;
    property ClassFile: string read FClassFile write FClassFile;
    //@@ Specifies the code base for the applet. If CodeBase is and empty string, the applet
    //is assumed to be in the files directory.
    property CodeBase: string read FCodeBase write FCodeBase;
    property HorizSpace: Integer read FHorizSpace write FHorizSpace;
    property Params: TStrings read FParams write SetParams;
    property VertSpace: Integer read FVertSpace write FVertSpace;
  end;

implementation

uses
  {$IFDEF Linux}QGraphics, {$ELSE}Graphics, {$ENDIF}
  IWCompLabel,
  SysUtils, SWSystem{, IWHTMLTag};

{ TIWHRule }

constructor TIWHRule.Create(AOwner: TComponent);
begin
  inherited;
  Width := 100;
  Height := 3;
end;

function TIWHRule.RenderHTML: TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('HR'); try
    Result.AddIntegerParam('WIDTH', Width);
  except FreeAndNil(Result); raise; end;
end;

{ TIWList }

constructor TIWList.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TStringList.Create;
  Height := 24;
  Width := 116;
end;

destructor TIWList.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TIWList.RenderHTML: TIWHTMLTag;
var
  i: Integer;
begin
  Result := nil;
  if Items.Count > 0 then begin
    Result := TIWHTMLTag.CreateTag('table');
    try
      for i := 0 to Items.Count - 1 do begin
        with Result.Contents.AddTag('TR') do begin
          with Contents.AddTag('TD') do begin
            if Numbered then begin
              Contents.AddText(IntToStr(i + 1) + '.');
            end else begin
              Contents.AddText(Chr(149));
            end;
          end;
          with Contents.AddTag('TD') do begin
            Contents.AddText(Items[i]);
          end;
        end;
      end;
      if Result.Contents.Count = 0 then
        Result.Contents.AddText('');
    except
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

procedure TIWList.SetItems(AValue: TStrings);
begin
  FItems.Assign(AValue);
  Invalidate;
end;

procedure TIWList.SetNumbered(const AValue: Boolean);
begin
  FNumbered := AValue;
  Invalidate;
end;

{ TIWLink }

constructor TIWLink.Create(AOwner: TComponent);
begin
  inherited;
  // Default to false for links.
  DoSubmitValidation := False;
end;

procedure TIWLink.HookEvents(AScriptEvents: TIWScriptEvents);
begin
  inherited HookEvents(AScriptEvents);
  if Enabled then begin
    AScriptEvents.HookEvent('OnClick', SubmitHandler(''));
  end;
end;

function TIWLink.RenderHTML: TIWHTMLTag;
var
  LLabel: TIWLabel;
begin
  if Enabled then begin
    Result := TIWHTMLTag.CreateTag('A'); try
      Result.AddStringParam('HREF', '#');
      Result.Contents.AddText(Caption);
    except FreeAndNil(Result); raise; end;  
  end else begin
    LLabel := TIWLabel.Create(self); try
      LLabel.Name := HTMLName;
      LLabel.Caption := Caption;
      LLabel.Font.Assign(Font);
      LLabel.Width := Width;
      LLabel.Height := Height;
      LLabel.Visible := true;
      Result := LLabel.RenderHTML;
    finally FreeAndNil(LLabel); end;
  end;
end;

procedure TIWLink.Submit(const AValue: string);
begin
  if Assigned(OnClick) then begin
    OnClick(Self);
  end;
end;

{ TIWLinkBase }

constructor TIWLinkBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSupportsSubmit := True;
  FSupportedScriptEvents := 'OnClick,OnDblClick,OnKeyDown,OnKeyPress,OnKeyUp,OnMouseDown,OnMouseOut'
    + ',OnMouseUp,OnMouseOver';
  Width := 65;
  Height := 17;
  Color := clNone;
end;

function TIWLinkBase.RenderStyle: string;
begin
  result := inherited RenderStyle + iif(Color <> clNone, 'color: ' + ColorToRGBString(Color) + ';');
end;

{ TIWURLTarget }

constructor TIWURLTarget.Create;
begin
  inherited;
  // These are the target window coords, not TIWRURLTarget's
  Left := -1;
  Top := -1;
  Width := -1;
  Height := -1;
  Resizable := True;
  ScrollBars := True;
end;

{ TIWCustomURL }

constructor TIWCustomURL.Create(AOwner: TComponent);
begin
  inherited;
  FTargetOptions := TIWURLTarget.Create;
end;

destructor TIWCustomURL.Destroy;
begin
  FreeAndNil(FTargetOptions);
  inherited;
end;

procedure TIWCustomURL.HookEvents(AScriptEvents: TIWScriptEvents);
begin
  inherited HookEvents(AScriptEvents);
  if Enabled then begin
  // TODO: Move OnClick code here
  end;
end;

function TIWCustomURL.RenderHTML: TIWHTMLTag;
var
  LURL: string;
  LResult: String;
begin
  if not Enabled then begin
    Result := TIWHTMLTag.CreateTag('SPAN'); try
      Result.Contents.AddText(Caption);
    except FreeAndNil(Result); raise; end;
  end else begin
    Result := TIWHTMLTag.CreateTag('A'); try
      // other than http or https? IE5 doesnt like mailto: (and possibly others) in LoadURL
      if not (AnsiSameText(Copy(FURL, 1, 7), 'http://') or AnsiSameText(Copy(FURL, 1, 8), 'https://'))
        then begin
          Result.AddStringParam('HREF', FURL);
      end else begin
        Result.AddStringParam('HREF', '#');
        if UseTarget then begin
          LResult := '';
          with TargetOptions do begin
            // personalbar
            // menubar
            // location - If yes, creates a Location entry field.
            // status - statusbar
            if Resizable then begin
              LResult := LResult + ',resizable=yes';
            end else begin
              LResult := LResult + ',resizable=no';
            end;
            if Toolbar then begin
              LResult := LResult + ',toolbar=yes';
            end else begin
              LResult := LResult + ',toolbar=no';
            end;
            if Scrollbars then begin
              LResult := LResult + ',scrollbars=yes';
            end else begin
              LResult := LResult + ',scrollbars=no';
            end;
            if Left > -1 then begin
              LResult := LResult + ',left=' + IntToStr(Left);
            end;
            if Top > -1 then begin
              LResult := LResult + ',top=' + IntToStr(Top);
            end;
            if Width > -1 then begin
              LResult := LResult + ',width=' + IntToStr(Width);
            end;
            if Height > -1 then begin
              LResult := LResult + ',height=' + IntToStr(Height);
            end;
          end;
          Result.AddStringParam('OnClick', 'NewWindow(''' + FURL + ''', ''' + TargetOptions.WindowName
            + ''',''' + Copy(LResult, 2, MaxInt) + ''')');
        end else begin
          LURL := FURL;
          if TerminateApp then begin
            if SameText(Copy(LURL, 1, 7), 'http://') then begin
              Delete(LURL, 1, 7);
            end;
            LURL := '/STOP/' + WebApplication.AppID + '/' + LURL;
          end;
          Result.AddStringParam('OnClick', 'parent.LoadURL(''' + LURL + ''')');
        end;
      end;
      HintEvents(Result, iif(Hint, Hint, FURL));
      Result.Contents.AddText(Caption);
    except FreeAndNil(Result); raise; end;
  end;
end;

procedure TIWCustomURL.SetTerminateApp(const AValue: boolean);
begin
  FTerminateApp := AValue;
  if AValue then begin
    FUseTarget := False;
  end;
end;

procedure TIWCustomURL.SetUseTarget(const AValue: boolean);
begin
  FUseTarget := AValue;
  if AValue then begin
    FTerminateApp := False;
  end;
end;

{ TIWApplet }

constructor TIWApplet.Create(AOwner: TComponent);
begin
  inherited;
  FParams := TStringList.Create;
  Height := 200;
  Width := 200;
end;

destructor TIWApplet.Destroy;
begin
  FreeAndNil(FParams);
  inherited;
end;

function TIWApplet.RenderHTML: TIWHTMLTag;
var
  i: Integer;
  LAlign: string;
begin
  case Alignment of
    aaTop: LAlign := 'top';
    aaMiddle: LAlign := 'middle';
    aaBottom: LAlign := 'bottom';
    aaLeft: LAlign := 'left';
    aaRight: LAlign := 'right';
  end;
  Result := TIWHTMLTag.CreateTag('APPLET'); try
    Result.AddStringParam('CODE', ClassFile);
    Result.AddIntegerParam('HEIGHT', Height);
    Result.AddIntegerParam('WIDTH', Width);
    Result.AddStringParam('ALIGN', LAlign);
    Result.AddStringParam('CODEBASE', iif(CodeBase, CodeBase, WebApplication.URLBase + '/Files/'));
    Result.Add(iif(AppletName, ' NAME=' + AppletName));
    Result.Add(iif(Height > 0, ' HSPACE=' + IntToStr(HorizSpace)));
    Result.Add(iif(Height > 0, ' VSPACE=' + IntToStr(VertSpace)));
    Result.Add(iif(AltText, ' ALT=' + AltText + ''));
    Result.Add(iif(Archive, ' ARCHIVE=' + Archive + ''));

    for i := 0 to Params.Count - 1 do begin
      with Result.Contents.AddTag('PARAM') do begin
        AddStringParam('NAME', Self.Params.Names[i]);
        AddStringParam('VALUE', Self.Params.Values[Self.Params.Names[i]]);
      end;
    end;
  except FreeAndNil(Result); raise; end;
end;

procedure TIWApplet.SetParams(const AValue: TStrings);
begin
  FParams.Assign(AValue);
end;

end.
