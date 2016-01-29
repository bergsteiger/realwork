{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Fmx.Bind.Navigator;

interface

uses
  System.Classes, System.SysUtils, System.Types, System.UITypes, FMX.Types, FMX.Objects, FMX.Layouts, FMX.Edit,
  FMX.Controls, FMX.StdCtrls, FMX.ExtCtrls, FMX.Dialogs, Data.Bind.Components, Data.Bind.Controls,
  FMX.ActnList;

const
  InitRepeatPause = 400;  { pause before repeat timer (ms) }
  RepeatPause     = 100;  { pause before hint window displays (ms)}
  SpaceSize       =  5;   { size of space between special buttons }

type
  EBindNavException = class(Exception);
  TBindNavButton = class;

  TBindNavGlyph = (ngEnabled, ngDisabled);
  TBindNavigateBtn = TNavigateButton;
  TBindNavButtonSet = TNavigateButtons;

  TBindNavButtonStyle = set of (nsAllowTimer, nsFocusRect);

  EBindNavClick = procedure (Sender: TObject; Button: TBindNavigateBtn) of object;


{ TvgDBNavigator }

  TCustomBindNavigator = class (TLayout, IBindNavigator)
  private
    FController: TBindNavigatorController;
    FVisibleButtons: TBindNavButtonSet;
    FHints: TStrings;
    FDefHints: TStrings;
    ButtonWidth: Integer;
    MinBtnSize: TPoint;
    FOnNavClick: EBindNavClick;
    FBeforeAction: EBindNavClick;
    FocusedButton: TBindNavigateBtn;
    FConfirmDelete: Boolean;
    FyRadius: single;
    FxRadius: single;
    FCornerType: TCornerType;
    FCorners: TCorners;
    FBindScopeName: string;
    procedure BtnMouseDown (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: single);
    procedure ClickHandler(Sender: TObject);
    function GetDataSource: TBaseLinkingBindSource;
    function GetHints: TStrings;
    procedure HintsChanged(Sender: TObject);
    procedure InitButtons;
    procedure InitHints;
    procedure SetDataSource(Value: TBaseLinkingBindSource);
    procedure SetHints(Value: TStrings);
    procedure SetSize(var W: single;var H: single);
    procedure SetVisible(Value: TBindNavButtonSet); reintroduce;
    procedure SetCornerType(const Value: TCornerType);
    procedure SetxRadius(const Value: single);
    procedure SetyRadius(const Value: single);
    function IsCornersStored: Boolean;
    procedure SetCorners(const Value: TCorners);
    procedure OnActiveChanged(Sender: TObject);
    procedure OnDataChanged(Sender: TObject);
    procedure OnEditingChanged(Sender: TObject);
    procedure ReadBindScope(Reader: TReader);
  protected
    Buttons: array[TBindNavigateBtn] of TBindNavButton;
    procedure DefineProperties(Filer: TFiler);  override;
    procedure DataChanged;
    procedure EditingChanged;
    procedure ActiveChanged;
    procedure Loaded; override;
    procedure DoRealign; override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure CalcMinSize(var W, H: single);
    property Hints: TStrings read GetHints write SetHints;
    property ShowHint;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BtnClick(Index: TBindNavigateBtn); virtual;
    property DataSource: TBaseLinkingBindSource read GetDataSource write SetDataSource;
    property VisibleButtons: TBindNavButtonSet read FVisibleButtons write SetVisible
      default NavigatorDefaultButtons;
    property Align;
    property Enabled;
    property CornerType: TCornerType read FCornerType write SetCornerType default TCornerType.ctRound;
    [Stored('IsCornersStored')]
    property Corners: TCorners read FCorners write SetCorners stored IsCornersStored;
    property xRadius: single read FxRadius write SetxRadius;
    property yRadius: single read FyRadius write SetyRadius;
//    property Hints: TStrings read GetHints write SetHints;
    [Default(True)]
    property ConfirmDelete: Boolean read FConfirmDelete write FConfirmDelete default True;
//    property ShowHint;
    property Visible;
    property BeforeAction: EBindNavClick read FBeforeAction write FBeforeAction;
    property OnClick: EBindNavClick read FOnNavClick write FOnNavClick;
  end;

  TBindNavigator = class(TCustomBindNavigator)
  protected
    property Hints;
    property ShowHint;
  published
    property DataSource;
    property VisibleButtons;
    property Align;
    property Enabled;
    property CornerType;
    property Corners;
    property xRadius;
    property yRadius;
//    property Hints;
    property ConfirmDelete;
//    property ShowHint;
    property Visible;
    property BeforeAction;
    property OnClick;
  end;

{ TvgNavButton }

  TBindNavButton = class(TCornerButton)
  private
    FIndex: TBindNavigateBtn;
    FNavStyle: TBindNavButtonStyle;
    FRepeatTimer: TTimer;
    FPath: TPath;
    procedure TimerExpired(Sender: TObject);
  protected
    procedure ApplyStyle; override;
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: single); override;
    property NavStyle: TBindNavButtonStyle read FNavStyle write FNavStyle;
    property Index : TBindNavigateBtn read FIndex write FIndex;
  end;


  { BindSource actions }

  TFMXBindNavigateAction = class(TAction)
  private
    FController: TBindNavigatorController;
    FButton: TNavigateButton;
    function GetDataSource: TBaseLinkingBindSource;
    procedure SetDataSource(Value: TBaseLinkingBindSource);
    function InvokeController(Target: TObject;
      AProc: TProc<TBindNavigatorController>): Boolean;
  protected
    property Controller: TBindNavigatorController read FController;
  public
    constructor Create(AComponent: TComponent); overload; override;
    constructor Create(AComponent: TComponent; AButton: TNavigateButton); reintroduce; overload;
    destructor Destroy; override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  published
    property DataSource: TBaseLinkingBindSource read GetDataSource write SetDataSource;
  end;

  TFMXBindNavigateFirst = class(TFMXBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TFMXBindNavigatePrior = class(TFMXBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TFMXBindNavigateNext = class(TFMXBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TFMXBindNavigateLast = class(TFMXBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TFMXBindNavigateInsert = class(TFMXBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TFMXBindNavigateDelete = class(TFMXBindNavigateAction)
  private
    FConfirmDelete: Boolean;
  public
    constructor Create(AComponent: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    [Default(True)]
    property ConfirmDelete: Boolean read FConfirmDelete write FConfirmDelete default True;
  end;

  TFMXBindNavigateEdit = class(TFMXBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TFMXBindNavigatePost = class(TFMXBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TFMXBindNavigateCancel = class(TFMXBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TFMXBindNavigateRefresh = class(TFMXBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TFMXBindNavigateApplyUpdates = class(TFMXBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;

  TFMXBindNavigateCancelUpdates = class(TFMXBindNavigateAction)
  public
    constructor Create(AComponent: TComponent); override;
  end;


implementation

uses System.Math, Data.Bind.Consts;

const
  MaxMapSize = (MaxInt div 2) div SizeOf(Integer);  { 250 million }


var
  BtnTypeName: array[TBindNavigateBtn] of PChar = ('FIRST', 'PRIOR', 'NEXT',
    'LAST', 'INSERT', 'DELETE', 'EDIT', 'POST', 'CANCEL', 'REFRESH', 'APPLYUPDATES', 'CANCELUPDATES');
  BtnTypePath: array[TBindNavigateBtn] of string = (
    'M 361.374,349.551 L 325.968,315.176 L 361.374,280.801 Z M 323.202,349.551 L 287.797,315.176 L 323.202,280.801 Z M 286.357,349.551 L 279.277,349.551 L 279.277,280.801 L 286.357,280.801 Z',
    'M 327.076,346.113 L 291.667,311.738 L 327.076,277.363 Z ',
    'M 341.236,311.738 L 305.830,346.113 L 305.830,277.363 Z ',
    'M 361.374,349.551 L 354.294,349.551 L 354.294,280.801 L 361.374,280.801 Z M 352.854,315.176 L 317.448,349.551 L 317.448,280.801 Z M 314.682,315.176 L 279.277,349.551 L 279.277,280.801 Z',
    // plus
    'M 315.303,336.714 L 315.303,315.122 L 293.228,315.122 L 293.228,306.099 L 315.303,306.099 L 315.303,284.668 L 324.706,284.668 L 324.706,306.099 L 346.781,306.099 L 346.781,315.122 L '+
    '324.706,315.122 L 324.706,336.714 Z ',
    // minus
    'M 286.766,375.304 L 286.766,364.321 L 352.763,364.321 L 352.763,375.304 Z ',
    // edit
    'M 350.074,271.455 L 350.074,350.947 L 289.995,350.947 L 289.995,271.455 Z M 347.362,274.087 L 292.704,274.087 L 292.704,348.315 L 347.362,348.315 Z M 300.892,337.681 L 300.892,335.049'+
    ' L 339.121,335.049 L 339.121,337.681 Z M 300.892,327.100 L 300.892,324.468 L 339.121,324.468 L 339.121,327.100 Z M 300.892,316.519 L 300.892,313.887 L 339.121,313.887 L 339.121,316.519 '+
    'Z M 300.892,305.884 L 300.892,303.252 L 339.121,303.252 L 339.121,305.884 Z M 300.892,295.249 L 300.892,292.617 L 339.121,292.617 L 339.121,295.249 Z M 300.892,284.668 L 300.892,282.036 L'+
    ' 339.121,282.036 L 339.121,284.668 Z ',
    // post
    'M 358.467,266.729 L '+
    '360.400,269.414 C 352.512,275.181 '+
    '343.733,284.064 334.069,296.058 L '+
    '334.069,296.058 C 324.407,308.056 '+
    '317.029,319.261 311.940,329.678 L '+
    '311.940,329.678 L 307.844,332.363 '+
    'C 304.454,334.659 302.148,336.358 '+
    '300.929,337.466 L 300.929,337.466 '+
    'C 300.452,335.787 299.402,333.028 '+
    '297.777,329.194 L 297.777,329.194 '+
    'L 296.229,325.703 C '+
    '294.017,320.695 291.959,316.989 '+
    '290.059,314.588 L 290.059,314.588 '+
    'C 288.159,312.191 286.031,310.597 '+
    '283.671,309.805 L 283.671,309.805 '+
    'C 287.656,305.726 291.308,303.685 '+
    '294.625,303.682 L 294.625,303.682 '+
    'C 297.465,303.685 300.620,307.428 '+
    '304.085,314.907 L 304.085,314.907 '+
    'L 305.800,318.667 C '+
    '312.034,308.465 320.037,298.549 '+
    '329.809,288.915 L 329.809,288.915 '+
    'C 339.584,279.283 349.135,271.888 '+
    '358.467,266.729 L 358.467,266.729 '+
    'Z ',
    // cancel
    'M 319.704,321.353 L 318.875,322.480 C 313.121,330.933 308.402,335.160 304.712,335.156 L 304.712,335.156 C 300.472,335.160 296.306,331.813 292.211,325.112 L 292.211,325.112 C 292.765,325.153 293.171,325.169 293.426,325.166 L 293.426,325.166 '+
    'C 298.260,325.169 '+
    '303.645,321.588 309.580,314.424 L 309.580,314.424 L 311.074,312.598 L 309.140,310.557 C 303.719,304.974 301.006,300.231 301.006,296.323 L 301.006,296.323 C 301.006,293.141 303.977,289.381 309.912,285.044 L 309.912,285.044 C 310.761,290.596 '+
    '313.289,296.004 '+
    '317.492,301.265 L 317.492,301.265 L 319.150,303.306 L 320.480,301.641 C 326.640,294.017 332.226,290.204 337.241,290.200 L 337.241,290.200 C 341.152,290.204 344.123,293.087 346.150,298.848 L 346.150,298.848 C 345.559,298.781 345.136,298.744 '+
    '344.878,298.740 '+
    'L 344.878,298.740 C 343.109,298.744 340.618,299.898 337.409,302.208 L 337.409,302.208 C 334.200,304.518 331.490,307.123 329.275,310.020 L 329.275,310.020 L 327.617,312.222 L 329.221,313.726 C 335.160,319.315 341.357,322.108 347.809,322.104 '+
    'L 347.809,322.104 '+
    'C 344.344,328.912 340.729,332.313 336.966,332.310 L 336.966,332.310 C 333.575,332.313 328.667,329.413 322.249,323.608 L 322.249,323.608 Z ',
    // refresh
    'M 354.848,307.012 C 354.848,312.779 353.633,318.224 351.196,323.340 L 351.196,323.340 C '+
    '348.614,328.677 344.999,332.994 340.353,336.284 L 340.353,336.284 L 346.493,340.957 L '+
    '326.744,346.113 L 328.570,327.046 L 334.102,331.289 C 339.819,326.388 342.676,319.567 '+
    '342.676,310.825 L 342.676,310.825 C 342.676,299.620 337.180,290.865 326.190,284.561 L '+
    '326.190,284.561 L 333.159,271.401 C 339.947,274.590 345.298,279.515 349.205,286.172 L '+
    '349.205,286.172 C 352.968,292.550 354.848,299.496 354.848,307.012 L 354.848,307.012 Z M '+
    '312.581,332.954 L 305.609,346.113 C 298.861,342.931 293.530,338.006 289.623,331.343 L '+
    '289.623,331.343 C 285.823,324.971 283.923,318.026 283.923,310.503 L 283.923,310.503 C '+
    '283.923,304.742 285.158,299.297 287.629,294.175 L 287.629,294.175 C 290.214,288.844 '+
    '293.809,284.527 298.418,281.230 L 298.418,281.230 L 292.278,276.504 L 312.027,271.401 L '+
    '310.201,290.469 L 304.669,286.226 C 298.955,291.133 296.095,297.955 296.095,306.689 L '+
    '296.095,306.689 C 296.095,317.902 301.590,326.656 312.581,332.954 L 312.581,332.954 Z ',
    // applyupdates

    'M 237.84375 119.5 L 125.09375 209.09375 L 215.3125 209.09375 L 215.3125 262.84375 L '+
    '260.40625 262.84375 L 260.40625 209.09375 L 350.625 209.09375 L 237.84375 119.5 z M '+
    '215.3125 286.84375 L 215.3125 334.53125 L 260.40625 334.53125 L 260.40625 286.84375 '+
    'L 215.3125 286.84375 z M 559.71875 305.6875 C 527.77175 323.1575 495.08856 348.1955 '+
    '461.625 380.8125 C 428.17171 413.43627 400.77886 447.01531 379.4375 481.5625 L 373.5625 '+
    '468.8125 C 361.70047 443.48623 350.87865 430.8227 341.15625 430.8125 C 329.80088 '+
    '430.82266 317.29843 437.71847 303.65625 451.53125 C 311.73543 454.21321 319.02682 '+
    '459.633 325.53125 467.75 C 332.03567 475.88054 339.08373 488.41633 346.65625 505.375 '+
    'L 351.96875 517.1875 C 357.53175 530.17063 361.11705 539.53316 362.75 545.21875 C '+
    '366.92311 541.4667 374.83223 535.71256 386.4375 527.9375 L 400.4375 518.84375 C '+
    '417.85908 483.5685 443.11079 445.62904 476.1875 405 C 509.27108 364.38453 539.34011 '+
    '334.31013 566.34375 314.78125 L 559.71875 305.6875 z M 215.3125 358.5 L 215.3125 '+
    '406.21875 L 260.40625 406.21875 L 260.40625 358.5 L 215.3125 358.5 z M 215.3125 '+
    '430.1875 L 215.3125 477.875 L 260.40625 477.875 L 260.40625 430.1875 L 215.3125 430.1875 z',

    // cancel updates


    'M 237.75 174.75 L 124.96875 264.3125 L 215.1875 264.3125 L 215.1875 318.09375 '+
    'L 260.28125 318.09375 L 260.28125 264.3125 L 350.5 264.3125 L 237.75 174.75 z '+
    'M 215.1875 342.0625 L 215.1875 389.75 L 260.28125 389.75 L 260.28125 342.0625 '+
    'L 215.1875 342.0625 z M 392.75 355.25 C 363.74963 376.80355 349.21875 395.49893 '+
    '349.21875 411.3125 C 349.21875 430.73405 362.47996 454.31669 388.96875 482.0625 '+
    'L 398.40625 492.1875 L 391.125 501.28125 C 362.12464 536.88414 335.80802 554.67165 '+
    '312.1875 554.65625 C 310.94149 554.67116 308.95702 554.57876 306.25 554.375 C '+
    '326.25952 587.67692 346.59447 604.3323 367.3125 604.3125 C 385.34306 604.33239 '+
    '408.4153 583.32131 436.53125 541.3125 L 440.59375 535.71875 L 453.03125 546.90625 '+
    'C 484.39171 575.75532 508.36796 590.17165 524.9375 590.15625 C 543.32477 590.17115 '+
    '560.97511 573.27117 577.90625 539.4375 C 546.37966 539.45737 516.11366 525.58812 '+
    '487.09375 497.8125 L 479.25 490.3125 L 487.34375 479.375 C 498.16697 464.9778 '+
    '511.41351 452.04249 527.09375 440.5625 C 542.77397 429.0825 554.94984 423.3323 '+
    '563.59375 423.3125 C 564.85444 423.33239 566.92467 423.54203 569.8125 423.875 C '+
    '559.9079 395.24459 545.39168 380.8948 526.28125 380.875 C 501.7763 380.89488 '+
    '474.4748 399.86106 444.375 437.75 L 437.875 446.03125 L 429.78125 435.875 C '+
    '409.244 409.72944 396.89849 382.84173 392.75 355.25 z M 215.1875 413.71875 L '+
    '215.1875 461.4375 L 260.28125 461.4375 L 260.28125 413.71875 L 215.1875 413.71875 z'+
    ' M 215.1875 485.40625 L 215.1875 533.09375 L 260.28125 533.09375 L 260.28125 '+
    '485.40625 L 215.1875 485.40625 z'
  );

constructor TCustomBindNavigator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCorners := AllCorners;
  FxRadius := 4;
  FyRadius := 4;
  FController := TBindNavigatorController.Create(Self);
  FController.OnEditingChanged := OnEditingChanged;
  FController.OnDataChanged := OnDataChanged;
  FController.OnActiveChanged := OnActiveChanged;
  FVisibleButtons := NavigatorDefaultButtons;
  FHints := TStringList.Create;
  TStringList(FHints).OnChange := HintsChanged;
  InitButtons;
  InitHints;
  Width := 241;
  Height := 25;
  ButtonWidth := 0;
  FocusedButton := nbFirst;
  FConfirmDelete := True;
  SetAcceptsControls(False);
end;

destructor TCustomBindNavigator.Destroy;
begin
  FDefHints.Free;
  FController.Free;
  FHints.Free;
  inherited Destroy;
end;

procedure TCustomBindNavigator.DefineProperties(Filer: TFiler);
begin
  // For backwards compatibility
  Filer.DefineProperty('BindScope', ReadBindScope, nil, False);
end;

procedure TCustomBindNavigator.ReadBindScope(Reader: TReader);
begin
  FBindScopeName := Reader.ReadIdent;
end;

procedure TCustomBindNavigator.OnEditingChanged(Sender: TObject);
begin
  Self.EditingChanged;
end;

procedure TCustomBindNavigator.OnActiveChanged(Sender: TObject);
begin
  Self.ActiveChanged;
end;

procedure TCustomBindNavigator.OnDataChanged(Sender: TObject);
begin
  Self.DataChanged;
end;

procedure TCustomBindNavigator.InitButtons;
var
  I: TBindNavigateBtn;
  Btn: TBindNavButton;
  X: single;
  ResName: string;
begin
  MinBtnSize := TPoint.Create(20, 18);
  X := 0;
  for I := Low(Buttons) to High(Buttons) do
  begin
    Btn := TBindNavButton.Create (Self);
    Btn.Index := I;
    Btn.Visible := I in FVisibleButtons;
    Btn.Enabled := True;
    Btn.SetBounds(X, 0, MinBtnSize.X, MinBtnSize.Y);
    FmtStr(ResName, 'dbn_%s', [BtnTypeName[I]]);
//    Btn.Glyph.LoadFromResourceName(HInstance, ResName);
//    Btn.NumGlyphs := 2;
    Btn.Enabled := False;
    Btn.Enabled := True;
    Btn.OnClick := ClickHandler;
    Btn.OnMouseDown := BtnMouseDown;
    Btn.Parent := Self;
    Buttons[I] := Btn;
    X := X + MinBtnSize.X;

    Btn.FPath := TPath.Create(Self);
    Btn.FPath.Parent := Btn;
    Btn.FPath.Width := 18;
    Btn.FPath.Height := 18;
    Btn.FPath.Align := TAlignLayout.alCenter;
    Btn.FPath.HitTest := false;
    Btn.FPath.Locked := true;
    Btn.FPath.Stored := false;
    Btn.FPath.Data.Data := BtnTypePath[I];
    Btn.FPath.WrapMode := TPathWrapMode.pwFit;
    Btn.FPath.Stroke.Kind := TBrushKind.bkNone;
  end;
  Buttons[nbPrior].NavStyle := Buttons[nbPrior].NavStyle + [nsAllowTimer];
  Buttons[nbNext].NavStyle  := Buttons[nbNext].NavStyle + [nsAllowTimer];
end;

procedure TCustomBindNavigator.InitHints;
//var
//  I: Integer;
//  J: TBindNavigateBtn;
begin
(*  if not Assigned(FDefHints) then
  begin
    FDefHints := TStringList.Create;
    for J := Low(Buttons) to High(Buttons) do
      FDefHints.Add(LoadResString(BtnHintId[J]));
  end;
  for J := Low(Buttons) to High(Buttons) do
    Buttons[J].Hint := FDefHints[Ord(J)];
  J := Low(Buttons);
  for I := 0 to (FHints.Count - 1) do
  begin
    if FHints.Strings[I] <> '' then Buttons[J].Hint := FHints.Strings[I];
    if J = High(Buttons) then Exit;
    Inc(J);
  end; *)
end;

procedure TCustomBindNavigator.HintsChanged(Sender: TObject);
begin
  InitHints;
end;

procedure TCustomBindNavigator.SetHints(Value: TStrings);
begin
  if Value.Text = FDefHints.Text then
    FHints.Clear else
    FHints.Assign(Value);
end;

function TCustomBindNavigator.GetHints: TStrings;
begin
  if (csDesigning in ComponentState) and not (csWriting in ComponentState) and
     not (csReading in ComponentState) and (FHints.Count = 0) then
    Result := FDefHints else
    Result := FHints;
end;

procedure TCustomBindNavigator.SetVisible(Value: TBindNavButtonSet);
var
  I: TBindNavigateBtn;
  W, H: single;
begin
  W := Width;
  H := Height;
  FVisibleButtons := Value;
  for I := Low(Buttons) to High(Buttons) do
    Buttons[I].Visible := I in FVisibleButtons;
  SetSize(W, H);
  if (W <> Width) or (H <> Height) then
    SetBounds(Position.X, Position.Y, W, H);
end;

procedure TCustomBindNavigator.CalcMinSize(var W, H: single);
var
  Count: Integer;
  I: TBindNavigateBtn;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[nbFirst] = nil then Exit;

  Count := 0;
  for I := Low(Buttons) to High(Buttons) do
    if Buttons[I].Visible then
      Inc(Count);
  if Count = 0 then Inc(Count);

  W := Max(W, Count * MinBtnSize.X);
  H := Max(H, MinBtnSize.Y);

  if Align = TAlignLayout.alNone then
    W := Trunc(W / Count) * Count;
end;

procedure TCustomBindNavigator.SetSize(var W: single; var H: single);
var
  Count: Integer;
  I: TBindNavigateBtn;
  Space, Temp, Remain: single;
  X: single;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[nbFirst] = nil then Exit;

  CalcMinSize(W, H);

  Count := 0;
  for I := Low(Buttons) to High(Buttons) do
    if Buttons[I].Visible then
      Inc(Count);
  if Count = 0 then Inc(Count);

  ButtonWidth := trunc(W / Count);
  Temp := Count * ButtonWidth;
  if Align = TAlignLayout.alNone then W := Temp;

  X := 0;
  Remain := W - Temp;
  Temp := Count div 2;
  for I := Low(Buttons) to High(Buttons) do
  begin
    if Buttons[I].Visible then
    begin
      if X = 0 then
        Buttons[I].Corners := [TCorner.crTopLeft] * FCorners + [TCorner.crBottomLeft] * FCorners
      else
      if X > Width - (ButtonWidth * 1.5) then
        Buttons[I].Corners := [TCorner.crTopRight] * FCorners + [TCorner.crBottomRight] * FCorners
      else
        Buttons[I].Corners := [];
      Buttons[I].xRadius := FxRadius;
      Buttons[I].yRadius := FyRadius;
      Buttons[I].CornerType := FCornerType;
      Buttons[I].ApplyStyleLookup; // Cause resources to be instantiated
      Buttons[I].ApplyStyle;

      Space := 0;
      if Remain <> 0 then
      begin
        Temp := Temp - Remain;
        if Temp < 0 then
        begin
          Temp := Temp + Count;
          Space := 1;
        end;
      end;
      Buttons[I].SetBounds(X, 0, ButtonWidth + Space, Height);
      X := X + ButtonWidth + Space;
    end
    else
      Buttons[I].SetBounds (Width + 1, 0, ButtonWidth, Height);
  end;
end;

procedure TCustomBindNavigator.DoRealign;
var
  W, H: single;
begin
  inherited ;
  W := Width;
  H := Height;
  SetSize(W, H);
end;

procedure TCustomBindNavigator.ClickHandler(Sender: TObject);
begin
  BtnClick (TBindNavButton (Sender).Index);
end;

procedure TCustomBindNavigator.BtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: single);
var
  OldFocus: TBindNavigateBtn;
begin
  OldFocus := FocusedButton;
  FocusedButton := TBindNavButton(Sender).Index;
  if IsFocused then
  begin
    SetFocus;
  end
  else
  if CanFocus and (IsFocused) and (OldFocus <> FocusedButton) then
  begin
    Buttons[OldFocus].Repaint;
    Buttons[FocusedButton].Repaint;
  end;
end;

procedure TCustomBindNavigator.BtnClick(Index: TBindNavigateBtn);
begin
  if (DataSource <> nil) then // and (FDataLink.DataSource.State <> dsInactive) then
  begin
    if not (csDesigning in ComponentState) and Assigned(FBeforeAction) then
      FBeforeAction(Self, Index);
    FController.ExecuteButton(Index,
       function: Boolean
       begin
          Result := not FConfirmDelete or
            (MessageDlg(TranslateText(SDeleteRecordQuestion), TMsgDlgType.mtConfirmation, mbOKCancel, 0) <> mrCancel);
       end
      );
  end;
  if not (csDesigning in ComponentState) and Assigned(FOnNavClick) then
    FOnNavClick(Self, Index);
end;

procedure TCustomBindNavigator.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
//var
//  NewFocus: TBindNavigateBtn;
//  OldFocus: TBindNavigateBtn;
begin
(*  OldFocus := FocusedButton;
  case Key of
    VK_RIGHT:
      begin
        if OldFocus < High(Buttons) then
        begin
          NewFocus := OldFocus;
          repeat
            NewFocus := Succ(NewFocus);
          until (NewFocus = High(Buttons)) or (Buttons[NewFocus].Visible);
          if Buttons[NewFocus].Visible then
          begin
            FocusedButton := NewFocus;
            Buttons[OldFocus].Invalidate;
            Buttons[NewFocus].Invalidate;
          end;
        end;
      end;
    VK_LEFT:
      begin
        NewFocus := FocusedButton;
        repeat
          if NewFocus > Low(Buttons) then
            NewFocus := Pred(NewFocus);
        until (NewFocus = Low(Buttons)) or (Buttons[NewFocus].Visible);
        if NewFocus <> FocusedButton then
        begin
          FocusedButton := NewFocus;
          Buttons[OldFocus].Invalidate;
          Buttons[FocusedButton].Invalidate;
        end;
      end;
    VK_SPACE:
      begin
        if Buttons[FocusedButton].Enabled then
          Buttons[FocusedButton].Click;
      end;
  end; *)
end;

procedure TCustomBindNavigator.DataChanged;
begin
  FController.EnableButtons(NavigatorScrollButtons + [nbDelete, nbApplyUpdates, nbCancelUpdates], Enabled,
    procedure(AButton: TNavigateButton; AEnabled: Boolean)
    begin
      Buttons[AButton].Enabled := AEnabled;
    end);
end;

procedure TCustomBindNavigator.EditingChanged;
begin
  FController.EnableButtons(NavigatorEditButtons - [nbDelete], Enabled,
    procedure(AButton: TNavigateButton; AEnabled: Boolean)
    begin
      Buttons[AButton].Enabled := AEnabled;
    end);
end;

procedure TCustomBindNavigator.ActiveChanged;
begin
  if not (Enabled and FController.Active) then
    FController.DisableButtons(
      procedure(AButton: TNavigateButton; AEnabled: Boolean)
      begin
        Buttons[AButton].Enabled := AEnabled;
      end)
  else
    FController.EnableButtons(NavigatorButtons, Enabled,
      procedure(AButton: TNavigateButton; AEnabled: Boolean)
      begin
        Buttons[AButton].Enabled := AEnabled;
      end);
end;

procedure TCustomBindNavigator.SetDataSource(Value: TBaseLinkingBindSource);
begin
  FController.DataSource := Value;
  if not (csLoading in ComponentState) then
    ActiveChanged;
//  if Value <> nil then Value.FreeNotification(Self);
end;

function TCustomBindNavigator.GetDataSource: TBaseLinkingBindSource;
begin
  Result := FController.DataSource as TBaseLinkingBindSource;
end;

procedure TCustomBindNavigator.Loaded;
var
  W, H: single;
  I: Integer;
begin
  inherited Loaded;
  if (DataSource = nil) and (FBindScopeName <> '') then
  begin
    // Resolve bindscope reference for backward compatibility
    if Owner <> nil then
      for I := 0 to Owner.ComponentCount - 1 do
        if (Owner.Components[I] is TBaseLinkingBindSource) and
          (Owner.Components[I].Name = FBindScopeName) then
        begin
          DataSource := Owner.Components[I] as TBaseLinkingBindSource;
        end;
  end;

  W := Width;
  H := Height;
  SetSize(W, H);
  if (W <> Width) or (H <> Height) then
    SetBounds(Position.X, Position.Y, W, H);
  InitHints;
  ActiveChanged;
end;

procedure TCustomBindNavigator.SetCornerType(const Value: TCornerType);
begin
  if FCornerType <> Value then
  begin
    FCornerType := Value;
    Realign;
  end;
end;

procedure TCustomBindNavigator.SetxRadius(const Value: single);
begin
  if FxRadius <> Value then
  begin
    FxRadius := Value;
    Realign;
  end;
end;

procedure TCustomBindNavigator.SetyRadius(const Value: single);
begin
  if FyRadius <> Value then
  begin
    FyRadius := Value;
    Realign;
  end;
end;

function TCustomBindNavigator.IsCornersStored: Boolean;
begin
  Result := FCorners <> AllCorners;
end;

procedure TCustomBindNavigator.SetCorners(const Value: TCorners);
begin
  if FCorners <> Value then
  begin
    FCorners := Value;
    Realign;
  end;
end;

{ TvgNavButton }

constructor TBindNavButton.Create(AOwner: TComponent);
begin
  inherited;
  CanFocus := false;
  Locked := true;
  Stored := false;
end;

destructor TBindNavButton.Destroy;
begin
  if FRepeatTimer <> nil then
    FRepeatTimer.Free;
  inherited Destroy;
end;

function TBindNavButton.GetDefaultStyleLookupName: string;
begin
  Result := 'CornerButtonStyle';
end;

procedure TBindNavButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: single);
begin
  inherited MouseDown (Button, Shift, X, Y);
  if nsAllowTimer in FNavStyle then
  begin
    if FRepeatTimer = nil then
      FRepeatTimer := TTimer.Create(Self);

    FRepeatTimer.OnTimer := TimerExpired;
    FRepeatTimer.Interval := InitRepeatPause;
    FRepeatTimer.Enabled  := True;
  end;
end;

procedure TBindNavButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: single);
begin
  inherited MouseUp (Button, Shift, X, Y);
  if FRepeatTimer <> nil then
    FRepeatTimer.Enabled  := False;
end;

procedure TBindNavButton.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := RepeatPause;
  if (IsPressed) then
  begin
    try
      Click;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
  end;
end;

procedure TBindNavButton.ApplyStyle;
var
  S: TObject;
begin
  inherited;
  { from style }
  if FPath <> nil then
  begin
    S := FindStyleResource('text');
    if (S <> nil) and (S is TShape) then
      FPath.Fill.Assign(TShape(S).Fill) // XE2
    else if (S <> nil) and (S is TText) then
      FPath.Fill.Color := TText(S).Color;  // XE3
  end;

end;


{ TBindNavigateAction }

function TFMXBindNavigateAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := DataSource <> nil;
end;

constructor TFMXBindNavigateAction.Create(AComponent: TComponent);
begin
  inherited;
  FController := TBindNavigatorController.Create(Self);
end;

constructor TFMXBindNavigateAction.Create(AComponent: TComponent;
  AButton: TNavigateButton);
begin
  inherited Create(AComponent);
  FButton := AButton;
  FController := TBindNavigatorController.Create(Self);
end;

destructor TFMXBindNavigateAction.Destroy;
begin
  FController.Free;
  inherited;
end;

procedure TFMXBindNavigateAction.ExecuteTarget(Target: TObject);
begin
  InvokeController(Target,
    procedure(AController: TBindNavigatorController)
    begin
      AController.ExecuteButton(FButton, nil);
    end);

end;

function TFMXBindNavigateAction.GetDataSource: TBaseLinkingBindSource;
begin
  Result := FController.DataSource as TBaseLinkingBindSource
end;

procedure TFMXBindNavigateAction.SetDataSource(Value: TBaseLinkingBindSource);
begin
  FController.DataSource := Value;
end;

procedure TFMXBindNavigateAction.UpdateTarget(Target: TObject);
begin
  if not InvokeController(Target,
    procedure(AController: TBindNavigatorController)
    begin
      AController.EnableButtons([FButton], True,
        procedure(AButton: TNavigateButton; AEnabled: Boolean)
        begin
          Enabled := AEnabled;
        end);
    end) then
    Enabled := False;
end;

function TFMXBindNavigateAction.InvokeController(Target: TObject; AProc: TProc<TBindNavigatorController>): Boolean;
begin
  Result := DataSource <> nil;
  if Result then
    AProc(FController)
end;

{ TBindNavigateFirst }

constructor TFMXBindNavigateFirst.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbFirst);
end;

{ TBindNavigatePrior }

constructor TFMXBindNavigatePrior.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbPrior);
end;


{ TBindNavigateNext }

constructor TFMXBindNavigateNext.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbNext)

end;

{ TBindNavigateLast }

constructor TFMXBindNavigateLast.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbLast)

end;

{ TBindNavigateInsert }

constructor TFMXBindNavigateInsert.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbInsert)

end;

{ TBindNavigateDelete }

constructor TFMXBindNavigateDelete.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbDelete);
  FConfirmDelete := True;

end;

procedure TFMXBindNavigateDelete.ExecuteTarget(Target: TObject);
begin
  InvokeController(Target,
    procedure(AController: TBindNavigatorController)
    begin
      AController.ExecuteButton(FButton,
        function: Boolean
        begin
          Result := not FConfirmDelete or
            (MessageDlg(TranslateText(SDeleteRecordQuestion), TMsgDlgType.mtConfirmation, mbOKCancel, 0) <> mrCancel);
        end);
    end);
end;

{ TBindNavigateEdit }

constructor TFMXBindNavigateEdit.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbEdit)

end;

{ TBindNavigatePost }

constructor TFMXBindNavigatePost.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbPost)

end;

{ TBindNavigateCancel }

constructor TFMXBindNavigateCancel.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbCancel)

end;

{ TBindNavigateRefresh }

constructor TFMXBindNavigateRefresh.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbRefresh)

end;

{ TBindNavigateApplyUpdates }

constructor TFMXBindNavigateApplyUpdates.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbApplyUpdates)

end;

{ TBindNavigateCancelUpdates }

constructor TFMXBindNavigateCancelUpdates.Create(AComponent: TComponent);
begin
  inherited Create(AComponent, TNavigateButton.nbCancelUpdates)

end;

end.

