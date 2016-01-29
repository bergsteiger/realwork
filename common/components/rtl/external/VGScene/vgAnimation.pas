unit vgAnimation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgAnimation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgAnimation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$IfNDef NoVGScene}

uses
  Classes,

  vgTypes,
  vgObject
  ;

type
  TvgAnimation = class(TvgObject)
  private
    FDuration: single;
    FDelay, FDelayTime: single;
    FTime: single;
    FInverse: boolean;
    FTrigger, FTriggerInverse: string;
    FLoop: boolean;
    FPause: boolean;
  protected
    FRunning: boolean;
  private
    FOnFinish: TNotifyEvent;
    FOnProcess: TNotifyEvent;
    FHideOnFinish: boolean;
    FInterpolation: TvgInterpolationType;
    FAnimationType: TvgAnimationType;
    FEnabled: boolean;
    FAutoReverse: boolean;
    procedure SetEnabled(const Value: boolean);
  protected
    function NormalizedTime: single;
    procedure ProcessAnimation; virtual;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    procedure Start; virtual;
    procedure Stop; virtual;
    procedure StopAtCurrent; virtual;
    procedure StartTrigger(AInstance: TvgObject; ATrigger: string); virtual;
    procedure ProcessTick(time, deltaTime: single);
    property Running: boolean read FRunning;
    property Pause: boolean read FPause write FPause;
  published
    property AnimationType: TvgAnimationType read FAnimationType write FAnimationType default vgAnimationIn;
    property AutoReverse: boolean read FAutoReverse write FAutoReverse default false;
    property Enabled: boolean read FEnabled write SetEnabled default false;
    property Delay: single read FDelay write FDelay;
    property Duration: single read FDuration write FDuration;
    property Interpolation: TvgInterpolationType read FInterpolation write FInterpolation default vgInterpolationLinear;
    property Inverse: boolean read FInverse write FInverse default false;
    property HideOnFinish: boolean read FHideOnFinish write FHideOnFinish default false;
    property Loop: boolean read FLoop write FLoop default false;
    property Trigger: string read FTrigger write FTrigger;
    property TriggerInverse: string read FTriggerInverse write FTriggerInverse;
    property OnProcess: TNotifyEvent read FOnProcess write FOnProcess;
    property OnFinish: TNotifyEvent read FOnFinish write FOnFinish;
  end;

{$EndIf  NoVGScene}

implementation

{$IfNDef NoVGScene}

uses
  Windows,

  SysUtils,

  TypInfo,
  
  vg_Scene,

  vgObjectList
  ;

{ TvgAnimation ===================================================================}

type
  TvgAniThread = class(TvgTimer)
  private
    FAniList: TvgObjectList;
    FStartTime, FTime, FDeltaTime: single;
    procedure OneStep;
    procedure DoSyncTimer(Sender: TObject);
  protected
  public
    constructor Create;
    destructor Destroy; override;
  end;

  {$IFDEF NOVCL}
  function GetTickCount: single;
  var
    H, M, S, MS: word;
  begin
    DecodeTime(time, H, M, S, MS);
    Result := ((((H * 60 * 60) + (M * 60) + S) * 1000) + MS);
  end;
  {$ENDIF}

{ TvgAniThread }

constructor TvgAniThread.Create;
begin
  inherited Create(nil);
  Interval := Trunc(1000 / 30);
  OnTimer := DoSyncTimer;

  FAniList := TvgObjectList.Create;
  FStartTime := GetTickCount / 1000;
end;

destructor TvgAniThread.Destroy;
begin
  FreeAndNil(FAniList);
  inherited;
end;

procedure TvgAniThread.DoSyncTimer(Sender: TObject);
begin
  OneStep;
end;

procedure TvgAniThread.OneStep;
var
  i: integer;
  NewTime: single;
begin
  NewTime := (GetTickCount / 1000) - FStartTime;
  if NewTime <= FTime then Exit;
  FDeltaTime := NewTime - FTime;
  FTime := NewTime;
  if FAniList.Count > 0 then
  begin
    i := FAniList.Count - 1;
    while i >= 0 do
    begin
      if TvgAnimation(FAniList[i]).FRunning then
      begin
        if (TvgAnimation(FAniList[i]).BindingName <> '') and
           (CompareText(TvgAnimation(FAniList[i]).BindingName, 'caret') = 0) then
        begin
          TvgAnimation(FAniList[i]).Tag := TvgAnimation(FAniList[i]).Tag + 1;
          if TvgAnimation(FAniList[i]).Tag mod 3 = 0 then
          begin
            TvgAnimation(FAniList[i]).ProcessTick(FTime, FDeltaTime);
          end;
        end
        else
          TvgAnimation(FAniList[i]).ProcessTick(FTime, FDeltaTime);
      end;
      Dec(i);
      if i >= FAniList.Count then
        i := FAniList.Count - 1;
    end;
  end;
end;

constructor TvgAnimation.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := false;
  Duration := 0.2;
end;

procedure TvgAnimation.Cleanup;
begin
  if aniThread <> nil then
  begin
    TvgAniThread(aniThread).FAniList.Remove(Self);
  end;
  inherited;
end;

procedure TvgAnimation.Loaded;
begin
  inherited;
  if not(Assigned(FScene)
         and {$IfDef vgDesign}(FScene.GetDesignTime){$Else}false{$EndIf}) and
     Enabled then
    Start;
end;

procedure TvgAnimation.SetEnabled(const Value: boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if not (Assigned(Scene)
            and {$IfDef vgDesign}Scene.GetDesignTime{$Else}false{$EndIf}) and
       not (csLoading in ComponentState) then
    begin
      if FEnabled then
        Start
      else
        Stop;
    end;
  end;//FEnabled <> Value
end;

function TvgAnimation.NormalizedTime: single;
begin
  if (FDuration > 0) and (FDelayTime <= 0) then
  begin
    case FInterpolation of
      vgInterpolationLinear: Result:= vgInterpolateLinear(FTime, 0, 1, FDuration);
      vgInterpolationQuadratic: Result:= vgInterpolateQuad(FTime, 0, 1, FDuration, FAnimationType);
      vgInterpolationCubic: Result:= vgInterpolateCubic(FTime, 0, 1, FDuration, FAnimationType);
      vgInterpolationQuartic: Result:= vgInterpolateQuart(FTime, 0, 1, FDuration, FAnimationType);
      vgInterpolationQuintic: Result:= vgInterpolateQuint(FTime, 0, 1, FDuration, FAnimationType);
      vgInterpolationSinusoidal: Result:= vgInterpolateSine(FTime, 0, 1, FDuration, FAnimationType);
      vgInterpolationExponential: Result:= vgInterpolateExpo(FTime, 0, 1, FDuration, FAnimationType);
      vgInterpolationCircular: Result:= vgInterpolateCirc(FTime, 0, 1, FDuration, FAnimationType);
      vgInterpolationElastic: Result:= vgInterpolateElastic(FTime, 0, 1, FDuration, 0, 0, FAnimationType);
      vgInterpolationBack: Result:= vgInterpolateBack(FTime, 0, 1, FDuration, 0, FAnimationType);
      vgInterpolationBounce: Result:= vgInterpolateBounce(FTime, 0, 1, FDuration, FAnimationType);
    end;
  end
  else
    Result := 0;
end;

procedure TvgAnimation.ProcessAnimation;
begin
end;

procedure TvgAnimation.ProcessTick(time, deltaTime: single);
begin
  inherited;
  {$IfDef vgDesign}
  if Assigned(FScene) and (FScene.GetDesignTime) then Exit;
  {$EndIf vgDesign}
  if csDestroying in ComponentState then Exit;

  if (Parent <> nil) and (Parent.IsVisual) and (not TvgVisualObject(Parent).Visible) then
    Stop;

  if not FRunning then Exit;
  if FPause then Exit;

  if (FDelay > 0) and (FDelayTime <> 0) then
  begin
    if FDelayTime > 0 then
    begin
      FDelayTime := FDelayTime - deltaTime;
      if FDelayTime <= 0 then
      begin
        Start;
        FDelayTime := 0;
      end;
    end;
    Exit;
  end;

  if FInverse then
    FTime := FTime - deltaTime
  else
    FTime := FTime + deltaTime;
  if FTime >= FDuration then
  begin
    FTime := FDuration;
    if FLoop then
    begin
      if FAutoReverse then
      begin
        FInverse := true;
        FTime := FDuration;
      end
      else
        FTime := 0;
    end
    else
      FRunning := false;
  end
  else
  if FTime <= 0 then
  begin
    FTime := 0;
    if FLoop then
    begin
      if FAutoReverse then
      begin
        FInverse := false;
        FTime := 0;
      end
      else
        FTime := FDuration;
    end
    else
      FRunning := false;
  end;

  ProcessAnimation;
  if Assigned(FOnProcess) then FOnProcess(Self);

  if (FScene <> nil) then
    if not FRunning then
    begin
      if aniThread <> nil then
        TvgAniThread(aniThread).FAniList.Remove(Self);
      if Assigned(FOnFinish) then FOnFinish(Self);
    end;
end;

procedure TvgAnimation.Start;
begin
  if (Parent <> nil) and (Parent.IsVisual) and (not TvgVisualObject(Parent).Visible) then Exit;
  if (Abs(FDuration) < 0.001) or (FScene = nil) or
     (Assigned(FScene) and {$IfDef vgDesign}(FScene.GetDesignTime){$Else}false{$EndIf}) then
  begin
    { imediatly animation }
    FDelayTime := 0;
    if FInverse then
    begin
      FTime := 0;
      FDuration := 1;
    end
    else
    begin
      FTime := 1;
      FDuration := 1;
    end;
    FRunning := true;
    ProcessAnimation;
    FRunning := false;
    FTime := 0;
    FDuration := 0.00001;
    if Assigned(FOnFinish) then FOnFinish(Self);
    FEnabled := false;
  end
  else
  begin
    FDelayTime := FDelay;
    FRunning := true;
    if FInverse then
      FTime := FDuration
    else
      FTime := 0;
    if FDelay = 0 then
      ProcessAnimation;

    if (FScene <> nil) then
    begin
      if aniThread = nil then
        aniThread := TvgAniThread.Create;

      if TvgAniThread(aniThread).FAniList.IndexOf(Self) < 0 then
        TvgAniThread(aniThread).FAniList.Add(Self);
    end;
    FEnabled := true;
  end;
end;

procedure TvgAnimation.Stop;
begin
  if not FRunning then Exit;

  if aniThread <> nil then
  begin
    TvgAniThread(aniThread).FAniList.Remove(Self);
  end;

  if FInverse then
    FTime := 0
  else
    FTime := FDuration;
  ProcessAnimation;
  FRunning := false;
  FEnabled := false;
  if Assigned(FOnFinish) then FOnFinish(Self);
end;

procedure TvgAnimation.StopAtCurrent;
begin
  if not FRunning then Exit;

  if aniThread <> nil then
  begin
    TvgAniThread(aniThread).FAniList.Remove(Self);
  end;

  if FInverse then
    FTime := 0
  else
    FTime := FDuration;
  FRunning := false;
  FEnabled := false;
  if Assigned(FOnFinish) then FOnFinish(Self);
end;

procedure TvgAnimation.StartTrigger(AInstance: TvgObject; ATrigger: string);
var
  StartValue: boolean;
  Line, Setter, Prop, Value: AnsiString;
begin
  if AInstance = nil then Exit;
  if (FTriggerInverse <> '') and (Pos(LowerCase(ATrigger), LowerCase(FTriggerInverse)) > 0) then
  begin
    Line := FTriggerInverse;
    Setter := vgGetToken(Line, ';');
    StartValue := false;
    while Setter <> '' do
    begin
      Prop := vgGetToken(Setter, '=');
      Value := Setter;
      if GetPropInfo(AInstance, Prop, [{$IFDEF FPC}tkBool{$ELSE}tkEnumeration{$ENDIF}]) <> nil then
      begin
        {$IFDEF FPC}
        StartValue := false;
        if (CompareText(Value, 'true') = 0) and (GetOrdProp(AInstance, Prop) > 0) then
          StartValue := true;
        if (CompareText(Value, 'false') = 0) and (GetOrdProp(AInstance, Prop) = 0) then
          StartValue := true;
        {$ELSE}
        StartValue := CompareText(GetEnumProp(AInstance, Prop), Value) = 0;
        {$ENDIF}
        if not StartValue then Break;
      end;
      Setter := vgGetToken(Line, ';');
    end;
    if StartValue then
    begin
      Inverse := true;
      Start;
      Exit;
    end;
  end;
  if (FTrigger <> '') and (Pos(LowerCase(ATrigger), LowerCase(FTrigger)) > 0) then
  begin
    Line := FTrigger;
    Setter := vgGetToken(Line, ';');
    StartValue := false;
    while Setter <> '' do
    begin
      Prop := vgGetToken(Setter, '=');
      Value := Setter;
      if GetPropInfo(AInstance, Prop, [{$IFDEF FPC}tkBool{$ELSE}tkEnumeration{$ENDIF}]) <> nil then
      begin
        {$IFDEF FPC}
        StartValue := false;
        if (CompareText(Value, 'true') = 0) and (GetOrdProp(AInstance, Prop) > 0) then
          StartValue := true;
        if (CompareText(Value, 'false') = 0) and (GetOrdProp(AInstance, Prop) = 0) then
          StartValue := true;
        {$ELSE}
        StartValue := CompareText(GetEnumProp(AInstance, Prop), Value) = 0;
        {$ENDIF}
        if not StartValue then Exit;
      end;
      Setter := vgGetToken(Line, ';');
    end;
    if StartValue then
    begin
      if FTriggerInverse <> '' then
        Inverse := false;
      Start;
    end;
  end;
end;

{$EndIf  NoVGScene}

end.