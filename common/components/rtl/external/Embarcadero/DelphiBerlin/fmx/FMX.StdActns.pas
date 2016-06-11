{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.StdActns;

interface

{$SCOPEDENUMS ON}

uses
  System.SysUtils, System.UITypes, System.Classes, FMX.Platform, FMX.ActnList, FMX.Types, FMX.Controls,
  FMX.VirtualKeyboard;

const
  DefaultMaxValue = 100.0;

type
  /// <summary>This action executes in order to trigger the OnHint event on all
  /// the hint receivers in the active form.</summary>
  THintAction = class(TCustomAction)
  public
    /// <summary>Default constructor.</summary>
    constructor Create(AOwner: TComponent); override;
    /// <summary>This execution causes all the hint receivers registered in the active form to be triggered.</summary>
    function Execute: Boolean; override;
  published
    property Hint;
  end;

  TSysCommonAction = class (TCustomAction)
  private
    FOnCanActionExec: TCanActionExecEvent;
  protected
    function GetDefaultText(const Template: string): string;
    function CanActionExec: boolean; virtual;
  public
    function Update: Boolean; override;
  published
    property CustomText;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property UnsupportedArchitectures;
    property OnCanActionExec: TCanActionExecEvent read FOnCanActionExec write FOnCanActionExec;
    property OnUpdate;
    property OnHint;
  end;

  TFileExit = class(TSysCommonAction)
  protected
    function IsSupportedInterface: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure CustomTextChanged; override;
  published
    property ShortCut default scCommand or vkQ;
    property UnsupportedPlatforms default [TOSVersion.TPlatform.pfiOS];
  end;

  TWindowClose = class(TSysCommonAction)
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure CustomTextChanged; override;
    function Update: Boolean; override;
    constructor Create(AOwner: TComponent); override;
  published
    property ShortCut default scCommand or vkW;
    property UnsupportedPlatforms;
    property OnExecute;
  end;

  TFileHideApp = class(TSysCommonAction)
  private
    FHideAppService: IFMXHideAppService;
  protected
    function IsSupportedInterface: boolean; override;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure CustomTextChanged; override;
    function Update: Boolean; override;
    constructor Create(AOwner: TComponent); override;
  published
    property ShortCut default scCommand or vkH;
    property UnsupportedPlatforms default TOSVersion.AllPlatforms - [TOSVersion.TPlatform.pfMacOS];
    property OnExecute;
  end;

  TFileHideAppOthers = class(TFileHideApp)
  private
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure CustomTextChanged; override;
    constructor Create(AOwner: TComponent); override;
  published
    property ShortCut default scAlt or scCommand or vkH;
  end;

  TObjectViewAction = class (TCustomViewAction)
  private
    procedure SetFmxObject(const Value: TFmxObject);
    function GetFmxObject: TFmxObject;
  protected
    procedure SetComponent(const Value: TComponent); override;
    function ComponentText: string; override;
    procedure DoCreateComponent(var NewComponent: TComponent); override;
  public
    property FmxObject: TFmxObject read GetFmxObject write SetFmxObject;
  end;

  TVirtualKeyboard = class(TObjectViewAction)
  private
    FService: IFMXVirtualKeyboardService;
  protected
  public
    function IsSupportedInterface: boolean; override;
    procedure ExecuteTarget(Target: TObject); override;
    function Update: Boolean; override;
  published
    property Text;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property UnsupportedArchitectures;
    property UnsupportedPlatforms;
    property OnUpdate;
    property FmxObject;
  end;

{ TViewAction }

  TViewAction = class (TObjectViewAction)
  private
  protected
    procedure SetComponent(const Value: TComponent); override;
  public
    procedure ExecuteTarget(Target: TObject); override;
    function Update: Boolean; override;
  published
    property Text;
    property Enabled;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property UnsupportedArchitectures;
    property UnsupportedPlatforms;
    property OnUpdate;
    property FmxObject;
    property OnCreateComponent;
    property OnBeforeShow;
    property OnAfterShow;
  end;

  /// <summary>This class associates a floating-point number Value with methods
  /// and properties used for handling Value between the values specified by Min
  /// and Max.</summary>
  TBaseValueRange = class (TPersistent)
  private
    FMax: Double;
    FMin: Double;
    FViewportSize: Double;
    FFrequency: Double;
    FValue: Double;
  protected
  public
    property Min: Double read FMin write FMin;
    property Max: Double read FMax write FMax;
    property Value: Double read FValue write FValue;
    property Frequency: Double read FFrequency write FFrequency;
    property ViewportSize: Double read FViewportSize write FViewportSize;
    procedure Assign(Source: TPersistent); override;
    function Equals(Obj: TObject): Boolean; override;
    function Same(Obj: TBaseValueRange): boolean; virtual;

  end;

  TCustomValueRangeClass = class of TCustomValueRange;

  /// <summary>Extends the TBaseValueRange class providing methods and
  /// properties used to control the correctness of the Value handling within
  /// its Min to Max range.</summary>
  TCustomValueRange = class (TBaseValueRange)
  private
    FInitialized: Boolean;
    [Weak] FOwner: TComponent;
    FOwnerAction: TCustomAction;
    FNew: TBaseValueRange;
    FOld: TBaseValueRange;
    FTmp: TBaseValueRange;
    FRelativeValue: Double;
    FUpdateCount: Integer;
    FChanging: Boolean;
    FIsChanged: Boolean;
    FBeforeChange: TNotifyEvent;
    FAfterChange: TNotifyEvent;
    FOnChanged: TNotifyEvent;
    FTracking: Boolean;
    FOnTrackingChange: TNotifyEvent;
    FIncrement: Double;
    FLastValue: Double;
    procedure IntChanged;
    function GetMax: Double; inline;
    procedure SetMax(const AValue: Double);
    function GetMin: Double; inline;
    procedure SetMin(const AValue: Double);
    function GetValue: Double; inline;
    procedure SetValue(const AValue: Double);
    function GetFrequency: Double; inline;
    procedure SetFrequency(const AValue: Double);
    function GetViewportSize: Double; inline;
    procedure SetViewportSize(const AValue: Double);
    procedure SetRelativeValue(const AValue: Double);
    procedure SetTracking(const Value: Boolean);
    procedure SetIncrement(const Value: Double);
  protected
    procedure DoBeforeChange; virtual;
    procedure DoChanged; virtual;
    procedure DoAfterChange; virtual;
    procedure DoTrackingChange; virtual;
    property Initialized: boolean read FInitialized;
    function GetOwner: TPersistent; override;

    function MaxStored: Boolean; virtual;
    function MinStored: Boolean; virtual;
    function ValueStored: Boolean; virtual;
    function FrequencyStored: Boolean; virtual;
    function ViewportSizeStored: Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetNamePath: string; override;
    /// <summary>
    /// This function returns True, if all the properties (Min, Max, Value, etc.) have default values.
    /// </summary>
    function IsEmpty: boolean; virtual;
    /// <summary>
    ///   Sets default values to all properties (Min, Max, Value, etc.).
    /// </summary>
    procedure Clear; virtual;
    /// <summary>
    ///  If this property is true, the event BeforeChange, AfterChange occur with any change.
    ///  Otherwise, they occur only after the property is accept the truth.
    /// </summary>
    property Tracking: boolean read FTracking write SetTracking;
    /// <summary>
    ///  This method is caused after property Min, Max, Value, etc. set new values.
    ///  If the owner is loading, or UpdateCount > 0 then events calling, else IsChanged property accepts value true.
    /// </summary>
    /// <param name="IgnoreLoading">
    ///  If this parameter is set to True, then the state csLoading ignored
    /// </param>
    /// <remarks>
    ///  After loading, the owner shall check value of IsChanged property and call the Changed method
    ///  </remarks>
    procedure Changed(const IgnoreLoading: boolean = false);
    property IsChanged: boolean read FIsChanged;
    /// <summary>
    /// The new values. see <see cref="BeforeChange"/>
    /// </summary>
    property New: TBaseValueRange read FNew;
    property Min: Double read GetMin write SetMin stored MinStored nodefault;
    property Max: Double read GetMax write SetMax stored MaxStored nodefault;
    property Value: Double read GetValue write SetValue stored ValueStored nodefault;
    property Frequency: Double read GetFrequency write SetFrequency stored FrequencyStored nodefault;
    property ViewportSize: Double read GetViewportSize write SetViewportSize stored ViewportSizeStored nodefault;
    property RelativeValue: Double read FRelativeValue write SetRelativeValue stored False nodefault;

    property LastValue: Double read FLastValue write FLastValue;
    property Increment: Double read FIncrement write SetIncrement;
    function Inc: boolean;
    function Dec: boolean;

    property Owner: TComponent read FOwner;
    procedure BeginUpdate;
    procedure EndUpdate;
    property UpdateCount: integer read FUpdateCount;
    /// <summary>
    /// This property indicates that the class is in a state where is being processed change.
    /// </summary>
    property Changing: boolean read FChanging;
    /// <summary>
    /// This event is raised before the changes take effect.
    /// Value property, and others contain the old values.
    /// To receive new values, see <see cref="New"/>
    /// </summary>
    /// <remarks>
    ///  This event occurs only if the property Tracking is set to true
    /// </remarks>
    property BeforeChange: TNotifyEvent read FBeforeChange write FBeforeChange;
    /// <summary>
    /// This event is raised after the changes take effect, and before AfterChange.
    /// </summary>
    /// <remarks>
    ///  This event always occurs, even if the property Tracking is set to false
    /// </remarks>
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    /// <summary>
    /// This event is raised after the changes take effect.
    /// Value property, and others contain the new values.
    /// </summary>
    /// <remarks>
    ///  This event occurs only if the property Tracking is set to true
    /// </remarks>
    property AfterChange: TNotifyEvent read FAfterChange write FAfterChange;
    /// <summary>
    /// This event is raised after the property Tracking has changed
    /// </summary>
    property OnTrackingChange: TNotifyEvent read FOnTrackingChange write FOnTrackingChange;
  end;

  /// <summary>Extends the TCustomValueRange class declaring Value, Min, Max,
  /// and some other properties to be published.</summary>
  TValueRange = class (TCustomValueRange)
  published
    property Min;
    property Max;
    property Value;
    property Frequency;
    property ViewportSize;
    property RelativeValue;
  end;

  /// <summary>The base class for actions (without published properties) that
  /// can be used by controls having ValueRange-type properties.</summary>
  TCustomValueRangeAction = class (TCustomControlAction)
  private
    FValueRange: TCustomValueRange;
    function GetValueRange: TCustomValueRange;
    procedure SetValueRange(const Value: TCustomValueRange);
  protected
    function CreateValueRange: TCustomValueRange; virtual;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ValueRange: TCustomValueRange read GetValueRange write SetValueRange;
  end;

  /// <summary>Class that can be used by controls having ValueRange-type
  /// properties.</summary>
  TValueRangeAction = class (TCustomValueRangeAction)
  protected
    function CreateValueRange: TCustomValueRange; override;
  published
    property AutoCheck;
    property Text;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property ShortCut;
    property SecondaryShortCuts;
    property Visible;
    property UnsupportedArchitectures;
    property UnsupportedPlatforms;
    property OnExecute;
    property OnUpdate;
    property PopupMenu;
    property ValueRange;
  end;

  /// <summary>Class responsible for the communication between an action of type
  /// TValueRangeAction and a control that implements the IValueRange
  /// interface.</summary>
  TValueRangeActionLink = class (TControlActionLink)
  protected
    function IsValueRangeLinked: boolean;
    procedure SetValueRange(const AValue: TBaseValueRange); virtual;
  end;

  /// <summary>This interface declares methods for setting and getting the
  /// ValueRange property.</summary>
  IValueRange = interface
    ['{6DFA65EF-A8BF-4D58-9655-664B50C30312}']
    function GetValueRange: TCustomValueRange;
    procedure SetValueRange(const AValue: TCustomValueRange);
    property ValueRange: TCustomValueRange read GetValueRange write SetValueRange;
  end;


implementation

uses
  System.Actions, System.RTLConsts, System.TypInfo, System.Math, FMX.Consts, FMX.Forms;

type
  TOpenCustomAction = class (TCustomAction)
  end;

  TOpenFmxObject = class (TFmxObject)
  end;

  TOpenControl = class (TControl)
  end;

{ TSysCommonAction }

function TSysCommonAction.GetDefaultText(const Template: string): string;
var S: string;
begin
  if CustomText <> '' then
  begin
    Result := CustomText;
  end
  else
  begin
    if csDesigning in ComponentState then
      S := SAppDesign
    else
      S := Application.Title;
    if S = '' then
      S := Application.DefaultTitle;
    S := Format(Template, [S]);
    Result := S;
  end;
end;

function TSysCommonAction.CanActionExec: boolean;
begin
  Result := True;
  if Assigned(FOnCanActionExec) then
    FOnCanActionExec(self, Result);
end;

function TSysCommonAction.Update: Boolean;
begin
  if Supported and ([csLoading, csDestroying] * ComponentState = []) then
  begin
    CustomTextChanged;
  end;
  result := inherited Update;
end;

{$REGION 'implementation of TFileExit'}
{ TFileExit }

constructor TFileExit.Create(AOwner: TComponent);
begin
  inherited;
  UnsupportedPlatforms := [TOSVersion.TPlatform.pfiOS];
  HideIfUnsupportedInterface := True;
  ShortCut := scCommand or vkQ; { 4177 }
end;

procedure TFileExit.ExecuteTarget(Target: TObject);
begin
  if Supported and (Application <> nil) then
  begin
    if Assigned(OnCanActionExec) or (Application.MainForm = nil) then
      if CanActionExec then
      begin
        if Screen <> nil then
          Screen.ActiveForm := nil;
        Application.Terminate
      end
      else
        Exit
    else
      Application.MainForm.Close;
  end;
end;

function TFileExit.HandlesTarget(Target: TObject): Boolean;
begin
  Result := Supported;
end;

function TFileExit.IsSupportedInterface: Boolean;
var
  ApplicationService: IFMXApplicationService;
begin
  Result := TPlatformServices.Current.SupportsPlatformService(IFMXApplicationService, ApplicationService) and
    not ApplicationService.Terminating;
end;

procedure TFileExit.CustomTextChanged;
begin
  Text := GetDefaultText(SMenuAppQuit);
end;

{ TWindowClose }

constructor TWindowClose.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := scCommand or vkW; { 4183 }
  //UnsupportedPlatforms := [TOSVersion.TPlatform.pfWindows];
end;

procedure TWindowClose.CustomTextChanged;
begin
  if CustomText <> '' then
  begin
    Text := CustomText;
  end
  else
  begin
    Text := SMenuCloseWindow;
  end;
end;

procedure TWindowClose.ExecuteTarget(Target: TObject);
var
  Form: TCommonCustomForm;
begin
  if Supported and (Screen <> nil) then
  begin
    Form := Screen.ActiveForm;
    if (Form <> nil) and (not (TFmxFormState.Modal in Form.FormState)) and CanActionExec then
      Form.Close;
  end;
end;

function TWindowClose.Update: Boolean;
var
  Form: TCommonCustomForm;
begin
  Result := inherited Update;
  if not Result then
  begin
    if Supported and (Screen <> nil) then
    begin
      Form := Screen.ActiveForm;
      Enabled := (Form <> nil) and (not (TFmxFormState.Modal in Form.FormState));
    end
    else
      Enabled := False;
  end;
end;

function TWindowClose.HandlesTarget(Target: TObject): Boolean;
begin
  Result := Supported and not Assigned(OnExecute);
end;

{$ENDREGION}

{ TFileHideApp }

constructor TFileHideApp.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := scCommand or vkH; { 4168 }
  HideIfUnsupportedInterface := True;
  UnsupportedPlatforms := TOSVersion.AllPlatforms - [TOSVersion.TPlatform.pfMacOS];
  TPlatformServices.Current.SupportsPlatformService(IFMXHideAppService, FHideAppService);
end;

procedure TFileHideApp.CustomTextChanged;
begin
  Text := GetDefaultText(SMenuAppHide);
end;

function TFileHideApp.HandlesTarget(Target: TObject): Boolean;
begin
  Result := Supported and not Assigned(OnExecute);
end;

function TFileHideApp.IsSupportedInterface: boolean;
begin
  Result := FHideAppService <> nil;
end;

procedure TFileHideApp.ExecuteTarget(Target: TObject);
begin
  if IsSupportedInterface then
    FHideAppService.Hidden := not FHideAppService.Hidden;
end;

function TFileHideApp.Update: Boolean;
begin
  Result := inherited Update;
  if not Result then
  begin
    if Supported and (FHideAppService <> nil) then
      Enabled := not FHideAppService.Hidden;
  end;
end;

{ TFileHideOtherApp }

constructor TFileHideAppOthers.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := scAlt or scCommand or vkH; { 36936 }
end;

procedure TFileHideAppOthers.CustomTextChanged;
begin
  Text := SMenuAppHideOthers;
end;

procedure TFileHideAppOthers.ExecuteTarget(Target: TObject);
begin
  if FHideAppService <> nil then
    FHideAppService.HideOthers;
end;

{ TObjectViewAction }

function TObjectViewAction.GetFmxObject: TFmxObject;
begin
  Result := TFmxObject(Component);
end;

procedure TObjectViewAction.SetFmxObject(const Value: TFmxObject);
begin
  Component := Value;
end;

procedure TObjectViewAction.SetComponent(const Value: TComponent);
begin
  if (Value <> nil) and (not (Value is TFmxObject)) then
    raise EActionError.CreateFmt(SEUseHeirs, [TFmxObject.ClassName]);
  inherited;
end;

function TObjectViewAction.ComponentText: string;
var
  Caption: ICaption;
begin
  Result := inherited;
  if Result.IsEmpty and Supports(Component, ICaption, Caption) then
    Result := Caption.Text;
end;

procedure TObjectViewAction.DoCreateComponent(var NewComponent: TComponent);
begin
  inherited;
  if NewComponent <> nil then
  begin
    if not (NewComponent is TFmxObject) then
    begin
      FreeAndNil(NewComponent);
      raise EActionError.CreateFmt(SEUseHeirs, [TFmxObject.ClassName]);
    end;
  end;
end;

{ TVirtualKeyboard }

function TVirtualKeyboard.IsSupportedInterface: boolean;
begin
  Result := TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, FService);
end;

procedure TVirtualKeyboard.ExecuteTarget(Target: TObject);
var
  Obj: TFmxObject;
  State: TVirtualKeyboardStates;
begin
  if (FService = nil) and (not IsSupportedInterface) then
  begin
    Enabled := False;
    raise EUnsupportedPlatformService.Create('IFMXVirtualKeyboardService');
  end;
  try
    if (FService <> nil) then
    begin
      State := FService.VirtualKeyboardState;
      if TVirtualKeyboardState.Error in State then
        Enabled := False
      else
      begin
        if not (TVirtualKeyboardState.Visible in State) then
        begin
          if FmxObject <> nil then
            Obj := FmxObject
          else
            Obj := Screen.GetObjectByTarget(Target);
          Checked := FService.ShowVirtualKeyboard(Obj);
        end
        else
        begin
          if (not (TVirtualKeyboardState.AutoShow in State)) and (FService.HideVirtualKeyboard) then
            Checked := False;
        end;
      end;
    end;
  except
    Enabled := False;
    raise;
  end;
  inherited;
end;

function TVirtualKeyboard.Update: Boolean;
var
  State: TVirtualKeyboardStates;
begin
  result := inherited Update;
  if (FService <> nil) then
  begin
    State := FService.VirtualKeyboardState;
    if TVirtualKeyboardState.Error in State then
    begin
      Enabled := False;
      Checked := False;
    end
    else
      Checked := TVirtualKeyboardState.Visible in State;
  end;
end;

{$REGION 'implementation of TViewAction'}
{ TViewAction }

procedure TViewAction.ExecuteTarget(Target: TObject);
var NewComponent: TComponent;
    CanShow: boolean;
begin
  if Component = nil then
  begin
    NewComponent := nil;
    DoCreateComponent(NewComponent);
    Component := NewComponent;
  end;
  if Component <> nil then
  begin
    CanShow := True;
    if Component is TControl then
    begin
      if not TControl(Component).Visible then
        DoBeforeShow(CanShow);
      if CanShow then
      begin
        TControl(Component).Visible := True;
        if TControl(Component).Visible then
          DoAfterShow;
      end;
    end
    else if Component is TCommonCustomForm then
    begin
      if not TCommonCustomForm(Component).Visible then
        DoBeforeShow(CanShow);
      if CanShow then
      begin
        if not TCommonCustomForm(Component).Visible then
          TCommonCustomForm(Component).Show;
        TCommonCustomForm(Component).BringToFront;
        TCommonCustomForm(Component).Activate;
        Checked := TCommonCustomForm(Component).Visible and TCommonCustomForm(Component).Active;
        if TCommonCustomForm(Component).Visible then
          DoAfterShow;
      end;
    end;
  end;
  inherited;
end;

function TViewAction.Update: Boolean;
begin
  if Component is TCommonCustomForm then
    Checked := TCommonCustomForm(Component).Visible and TCommonCustomForm(Component).Active;
  result := inherited Update;
end;

procedure TViewAction.SetComponent(const Value: TComponent);
var IsDefaultText: boolean;
    OldObject: TOpenFmxObject;
begin
  if (Value <> nil) and (not (Value is TFmxObject)) then
    raise EActionError.CreateFmt(SEUseHeirs, [TFmxObject.ClassName]);
  if Component <> Value then
  begin
    IsDefaultText := (Text = '') or
                     (Text = Name) or
                     ((Component <> nil) and (Component.Name = Text)) or
                     (Text = ComponentText);
    if Component is TFmxObject then
      OldObject := TOpenFmxObject(Component)
    else
      OldObject := nil;
    inherited;
    if (OldObject <> nil) and (OldObject.Action = self) then
      OldObject.Action := nil;
    if (Component is TFmxObject) then
    begin
      if IsDefaultText then
        Text := ComponentText;
      TOpenFmxObject(Component).Action := self;
    end;
    if Component = nil then
      Checked := False;
  end;
end;

{$ENDREGION}

{$REGION 'implementation of TBaseValueRange'}

{ TBaseValueRange }

procedure TBaseValueRange.Assign(Source: TPersistent);
begin
  if Source is TBaseValueRange then
  begin
    FMin := TBaseValueRange(Source).Min;
    FMax := TBaseValueRange(Source).Max;
    FValue := TBaseValueRange(Source).Value;
    FViewportSize := TBaseValueRange(Source).ViewportSize;
    FFrequency := TBaseValueRange(Source).Frequency;
  end
  else
    inherited;
end;

function TBaseValueRange.Equals(Obj: TObject): Boolean;
begin
  Result := inherited Equals(Obj);
  if (not Result) and (Obj is TBaseValueRange) then
  begin
    Result := (FMin = TBaseValueRange(Obj).Min) and
              (FMax = TBaseValueRange(Obj).Max) and
              (FValue = TBaseValueRange(Obj).Value) and
              (FViewportSize = TBaseValueRange(Obj).ViewportSize) and
              (FFrequency = TBaseValueRange(Obj).Frequency);
  end;
end;

function TBaseValueRange.Same(Obj: TBaseValueRange): boolean;
begin
  Result := SameValue(FMin, Obj.Min) and
            SameValue(FMax, Obj.Max) and
            SameValue(FValue, Obj.Value) and
            SameValue(FViewportSize, Obj.ViewportSize) and
            SameValue(FFrequency, Obj.Frequency);
end;

{$ENDREGION}

{$REGION 'implementation of TCustomValueRange'}
{ TCustomValueRange }

constructor TCustomValueRange.Create(AOwner: TComponent);
begin
  if AOwner = nil then
    raise EActionError.CreateFmt(SParamIsNil, ['AOwner']);
  inherited Create;
  FTracking := True;
  FNew := TBaseValueRange.Create;
  FOwner := AOwner;
  BeginUpdate;
  try
    Clear;
  finally
    EndUpdate;
  end;
  if FOwner is TCustomAction then
    FOwnerAction := TCustomAction(FOwner);
  FInitialized := True;
end;

destructor TCustomValueRange.Destroy;
begin
  FreeAndNil(FTmp);
  FreeAndNil(FOld);
  FreeAndNil(FNew);
  inherited;
end;

procedure TCustomValueRange.SetTracking(const Value: Boolean);
begin
  if FTracking <> Value then
  begin
    FTracking := Value;
    if FTracking then
    begin
      if FTmp = nil then
        FTmp := TBaseValueRange.Create;
      FTmp.Assign(Self);
      FInitialized := False;
      try
        Assign(FOld);
      finally
        FInitialized := True;
      end;
      Assign(FTmp);
    end
    else
    begin
      if FOld = nil then
        FOld := TBaseValueRange.Create;
      FOld.Assign(Self);
    end;
    DoTrackingChange;
  end;
end;

procedure TCustomValueRange.BeginUpdate;
begin
  System.inc(FUpdateCount);
end;

procedure TCustomValueRange.EndUpdate;
begin
  if FUpdateCount > 0 then
    System.Dec(FUpdateCount);
  if (FUpdateCount = 0) and
     FIsChanged and
     ((not FInitialized) or (([csLoading, csDestroying] * FOwner.ComponentState) = [])) then
    IntChanged;
end;

procedure TCustomValueRange.DoBeforeChange;
var
  I: Integer;
  A: TOpenCustomAction;
begin
  if FOwnerAction <> nil then
  begin
    A := TOpenCustomAction(FOwnerAction);
    for I := 0 to A.ClientCount - 1 do
      if A.Clients[I] is TValueRangeActionLink then
        TValueRangeActionLink(A.Clients[I]).SetValueRange(FNew);
    TOpenCustomAction(FOwnerAction).Change;
  end;
  if Assigned(FBeforeChange) then
    FBeforeChange(self);
end;

procedure TCustomValueRange.DoAfterChange;
begin
  if Assigned(FAfterChange) then
    FAfterChange(self);
end;

procedure TCustomValueRange.DoChanged;
begin
  if Assigned(FOnChanged) then
    FOnChanged(self);
end;

procedure TCustomValueRange.DoTrackingChange;
begin
  if Assigned(FOnTrackingChange) then
    FOnTrackingChange(Self);
end;

procedure TCustomValueRange.IntChanged;
var LIsChanged: boolean;
begin
  LIsChanged := False;
  if FChanging then Exit;
  try
    FChanging := True;
    FNew.FViewportSize := System.Math.Max(FNew.FViewportSize, 0);
    FNew.FFrequency := System.Math.Max(FNew.FFrequency, 0);
    FNew.FMax := System.Math.Max(FNew.FMax, FNew.FMin + FNew.FViewportSize);

    FNew.FValue := System.Math.Min(System.Math.Max(FNew.FValue, FNew.FMin), FNew.FMax - FNew.FViewportSize);
    if SameValue(FNew.FValue, FNew.FMin) then
      FNew.FValue := FNew.FMin
    else if SameValue(FNew.FValue, FNew.FMax - FNew.FViewportSize) then
      FNew.FValue := FNew.FMax - FNew.FViewportSize
    else
    begin
      if FNew.FFrequency <> 0 then
        FNew.FValue := Round(FNew.FValue / FNew.FFrequency) * FNew.FFrequency;
      FNew.FValue := System.Math.Min(System.Math.Max(FNew.FValue, FNew.FMin), FNew.FMax - FNew.FViewportSize);
    end;

    if not FNew.Same(self) then
    try
      FRelativeValue := FNew.FMax - FNew.FMin - FNew.FViewportSize;
      if FRelativeValue <= 0 then
        FRelativeValue := 1
      else
      begin
        FRelativeValue := (FNew.FValue - FNew.FMin) / FRelativeValue;
        if CompareValue(FRelativeValue, 1) >= 0 then
          FRelativeValue := 1;
        if CompareValue(FRelativeValue, 0) <= 0 then
          FRelativeValue := 0;
      end;
      if FInitialized then
      begin
        if FTracking then
          DoBeforeChange;
        LIsChanged := True;
      end;
    finally
      FViewportSize := FNew.FViewportSize;
      FFrequency := FNew.FFrequency;
      FMin := FNew.FMin;
      FMax := FNew.FMax;
      FValue := FNew.FValue;
    end;
  finally
    FChanging := False;
    FIsChanged := False;
  end;
  if LIsChanged then
  begin
    DoChanged;
    if FTracking then
      DoAfterChange;
  end;
end;

procedure TCustomValueRange.Changed(const IgnoreLoading: boolean = false);
var St: TComponentState;
begin
  St := [csDestroying];
  if not IgnoreLoading then St := St + [csLoading];

  if (FUpdateCount = 0) and
     ((not FInitialized) or ((St * FOwner.ComponentState) = [])) then
    IntChanged
  else
    FIsChanged := True;
end;

function TCustomValueRange.IsEmpty: boolean;
begin
  Result := not (MaxStored or
                 MinStored or
                 ValueStored or
                 FrequencyStored or
                 ViewportSizeStored);
end;

procedure TCustomValueRange.Clear;
begin
  BeginUpdate;
  try
    self.Min := 0;
    self.Max := DefaultMaxValue;
    self.Value := 0;
    self.ViewportSize := 0;
    self.Frequency := 0;
  finally
    EndUpdate;
  end;
end;

procedure TCustomValueRange.Assign(Source: TPersistent);
begin
  if not Equals(Source) then
  begin
    BeginUpdate;
    try
      if Source = nil then
        Clear
      else if Source is TBaseValueRange then
      begin
        self.Min := TBaseValueRange(Source).Min;
        self.Max := TBaseValueRange(Source).Max;
        self.Value := TBaseValueRange(Source).Value;
        self.ViewportSize := TBaseValueRange(Source).ViewportSize;
        self.Frequency := TBaseValueRange(Source).Frequency;
        if Source is TCustomValueRange then
        begin
          FLastValue := TCustomValueRange(Source).LastValue;
          Increment := TCustomValueRange(Source).Increment;
        end;
      end
      else
        inherited Assign(Source);
    finally
      EndUpdate;
    end;
  end;
end;

function TCustomValueRange.GetNamePath: string;
begin
  Result := Format('Value: %0:f (%1:f .. %2:f)', [Value, Min, Max]);
end;

function TCustomValueRange.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TCustomValueRange.Dec: boolean;
var N: Int64;
    Tmp: Double;
begin
  Result := False;
  if (FIncrement > 0) and (UpdateCount = 0) then
  begin
    if (FLastValue > Min) then
    begin
      if FLastValue > Max then
        N := Ceil ((FLastValue - Max) / FIncrement)
      else
        N := 1;
      Tmp := FLastValue - (N * FIncrement);
      try
        Value := Tmp;
      finally
        FLastValue := Tmp;
      end;
      Result := True;
    end;
  end;
end;

function TCustomValueRange.Inc: boolean;
var N: Int64;
    Tmp: Double;
begin
  Result := False;
  if (FIncrement > 0) and (UpdateCount = 0) then
  begin
    if (FLastValue < Max) then
    begin
      if FLastValue < Min then
        N := Ceil ((Min - FLastValue) / FIncrement)
      else
        N := 1;
      Tmp := FLastValue + (N * FIncrement);
      try
        Value := Tmp;
      finally
        FLastValue := Tmp;
      end;
      Result := True;
    end;
  end;
end;

procedure TCustomValueRange.SetIncrement(const Value: Double);
begin
  if Value < 0 then
    raise EPropertyError.Create(SInvalidPropertyValue);
  FIncrement := Value;
end;

{$REGION 'Stored Get Set methods'}

function TCustomValueRange.FrequencyStored: Boolean;
begin
  Result := FFrequency <> 0;
end;

function TCustomValueRange.MaxStored: Boolean;
begin
  Result := FMax <> DefaultMaxValue;
end;

function TCustomValueRange.MinStored: Boolean;
begin
  Result := FMin <> 0;
end;

function TCustomValueRange.ValueStored: Boolean;
begin
  Result := FValue <> 0;
end;

function TCustomValueRange.ViewportSizeStored: Boolean;
begin
  Result := ViewportSize <> 0;
end;

function TCustomValueRange.GetFrequency: Double;
begin
  Result := FFrequency;
end;

function TCustomValueRange.GetMax: Double;
begin
  Result := FMax
end;

function TCustomValueRange.GetMin: Double;
begin
  Result := FMin;
end;

function TCustomValueRange.GetValue: Double;
begin
  Result := FValue;
end;

function TCustomValueRange.GetViewportSize: Double;
begin
  Result := FViewportSize;
end;

procedure TCustomValueRange.SetFrequency(const AValue: Double);
begin
  if Frequency <> AValue then
  begin
    FNew.FFrequency := AValue;
    Changed;
  end;
end;

procedure TCustomValueRange.SetMax(const AValue: Double);
begin
  if Max <> AValue then
  begin
    FNew.FMax := AValue;
    Changed;
  end;
end;

procedure TCustomValueRange.SetMin(const AValue: Double);
begin
  if Min <> AValue then
  begin
    FNew.FMin := AValue;
    Changed;
  end;
end;

procedure TCustomValueRange.SetValue(const AValue: Double);
begin
  if Value <> AValue then
  begin
    FNew.FValue := AValue;
    FLastValue := AValue;
    Changed;
  end;
end;

procedure TCustomValueRange.SetViewportSize(const AValue: Double);
begin
  if ViewportSize <> AValue then
  begin
    FNew.FViewportSize := AValue;
    Changed;
  end;
end;

procedure TCustomValueRange.SetRelativeValue(const AValue: Double);
var V, NewValue: Double;
begin
  V := System.Math.Min(System.Math.Max(AValue, 0), 1);
  if FRelativeValue <> V then
  begin
    NewValue := Max - Min - ViewportSize;
    if NewValue > 0 then
      Value := Min + NewValue * V;
  end;
end;

{$ENDREGION}
{$ENDREGION}

{$REGION 'implementation of TCustomValueRangeAction'}
{ TCustomValueRangeAction }

constructor TCustomValueRangeAction.Create(AOwner: TComponent);
begin
  inherited;
  FValueRange := CreateValueRange;
  if FValueRange = nil then
    FValueRange := TCustomValueRange.Create(self);
end;

function TCustomValueRangeAction.CreateValueRange: TCustomValueRange;
begin
  Result := nil;
end;

destructor TCustomValueRangeAction.Destroy;
begin
  FreeAndNil(FValueRange);
  inherited;
end;

function TCustomValueRangeAction.GetValueRange: TCustomValueRange;
begin
  Result := FValueRange;
end;

procedure TCustomValueRangeAction.SetValueRange(const Value: TCustomValueRange);
begin
  FValueRange.Assign(Value);
end;

procedure TCustomValueRangeAction.Loaded;
begin
  if (FValueRange.FIsChanged) and (FValueRange.FUpdateCount = 0) then
    FValueRange.IntChanged;
  inherited;
end;
{$ENDREGION}

{$REGION 'implementation of TValueRangeAction'}
{ TValueRangeAction }

function TValueRangeAction.CreateValueRange: TCustomValueRange;
begin
  Result := TValueRange.Create(self);
end;
{$ENDREGION}

{$REGION 'implementation of TValueRangeActionLink'}
{ TValueRangeActionLink }

function TValueRangeActionLink.IsValueRangeLinked: boolean;
var ObjValue: IValueRange;
begin
  Result := (Client <> nil) and
            (TOpenControl(Client).QueryInterface(IValueRange, ObjValue) = S_OK) and
            (Action is TCustomValueRangeAction) and
            (ObjValue.ValueRange <> nil) and
            (ObjValue.ValueRange.Same(TCustomValueRangeAction(Action).ValueRange));
end;

procedure TValueRangeActionLink.SetValueRange(const AValue: TBaseValueRange);
var ObjValue: IValueRange;
begin
  if IsValueRangeLinked and
     (TOpenControl(Client).QueryInterface(IValueRange, ObjValue) = S_OK) then
    ObjValue.ValueRange.Assign(AValue);
end;
{$ENDREGION}

{$REGION 'implementation of THintAction'}
{ THintAction }

constructor THintAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DisableIfNoHandler := False;
end;

function THintAction.Execute: Boolean;
var
  LRegistry: IHintRegistry;
begin
  if Supports(Application.MainForm, IHintRegistry, LRegistry) then
  begin
    LRegistry.TriggerHints;
    Result := True;
  end
  else
    Result := False;
end;

{$ENDREGION}

end.
