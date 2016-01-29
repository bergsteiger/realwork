{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Ani;

interface

uses
  System.Classes, System.Types, System.UITypes, System.Rtti, FMX.Types;

type

  TCustomPropertyAnimation = class(TAnimation)
  private
  protected
    FInstance: TObject;
    FRttiProperty: TRttiProperty;

    FPath, FPropertyName: string;
    function FindProperty: Boolean;
  public
    property PropertyName: string read FPropertyName write FPropertyName;
    procedure Start; override;
    procedure Stop; override;
  end;

{ TFloatAnimation }

  TFloatAnimation = class(TCustomPropertyAnimation)
  private
    FStartFloat: Single;
    FStopFloat: Single;
    FStartFromCurrent: Boolean;
  protected
    procedure ProcessAnimation; override;
    procedure FirstFrame; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AnimationType default TAnimationType.atIn;
    property AutoReverse default False;
    property Enabled default False;
    property Delay;
    property Duration nodefault;
    property Interpolation default TInterpolationType.itLinear;
    property Inverse default False;
    property Loop default False;
    property OnProcess;
    property OnFinish;
    property PropertyName;
    property StartValue: Single read FStartFloat write FStartFloat stored True nodefault;
    property StartFromCurrent: Boolean read FStartFromCurrent write FStartFromCurrent default False;
    property StopValue: Single read FStopFloat write FStopFloat stored True nodefault;
    property Trigger;
    property TriggerInverse;
  end;

{ TIntAnimation }

  TIntAnimation = class(TCustomPropertyAnimation)
  private
    FStartValue: Integer;
    FStopValue: Integer;
    FStartFromCurrent: Boolean;
  protected
    procedure ProcessAnimation; override;
    procedure FirstFrame; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AnimationType default TAnimationType.atIn;
    property AutoReverse default False;
    property Enabled default False;
    property Delay;
    property Duration nodefault;
    property Interpolation default TInterpolationType.itLinear;
    property Inverse default False;
    property Loop default False;
    property OnProcess;
    property OnFinish;
    property PropertyName;
    property StartValue: Integer read FStartValue write FStartValue stored True nodefault;
    property StartFromCurrent: Boolean read FStartFromCurrent write FStartFromCurrent default False;
    property StopValue: Integer read FStopValue write FStopValue stored True nodefault;
    property Trigger;
    property TriggerInverse;
  end;

{ TColorAnimation }

  TColorAnimation = class(TCustomPropertyAnimation)
  private
    FStartColor: TAlphaColor;
    FStopColor: TAlphaColor;
    FStartFromCurrent: Boolean;
  protected
    procedure ProcessAnimation; override;
    procedure FirstFrame; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AnimationType default TAnimationType.atIn;
    property AutoReverse default False;
    property Enabled default False;
    property Delay;
    property Duration nodefault;
    property Interpolation default TInterpolationType.itLinear;
    property Inverse default False;
    property Loop default False;
    property OnProcess;
    property OnFinish;
    property PropertyName;
    property StartValue: TAlphaColor read FStartColor write FStartColor;
    property StartFromCurrent: Boolean read FStartFromCurrent write FStartFromCurrent default False;
    property StopValue: TAlphaColor read FStopColor write FStopColor;
    property Trigger;
    property TriggerInverse;
  end;

{ TGradientAnimation }

  TGradientAnimation = class(TCustomPropertyAnimation)
  private
    FStartGradient: TGradient;
    FStopGradient: TGradient;
    FStartFromCurrent: Boolean;
    procedure SetStartGradient(const Value: TGradient);
    procedure SetStopGradient(const Value: TGradient);
  protected
    procedure ProcessAnimation; override;
    procedure FirstFrame; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AnimationType default TAnimationType.atIn;
    property AutoReverse default False;
    property Enabled default False;
    property Delay;
    property Duration nodefault;
    property Interpolation default TInterpolationType.itLinear;
    property Inverse default False;
    property Loop default False;
    property OnProcess;
    property OnFinish;
    property PropertyName;
    property StartValue: TGradient read FStartGradient write SetStartGradient;
    property StartFromCurrent: Boolean read FStartFromCurrent write FStartFromCurrent default False;
    property StopValue: TGradient read FStopGradient write SetStopGradient;
    property Trigger;
    property TriggerInverse;
  end;

{ TRectAnimation }

  TRectAnimation = class(TCustomPropertyAnimation)
  private
    FStartRect: TBounds;
    FCurrent: TBounds;
    FStopRect: TBounds;
    FStartFromCurrent: Boolean;
    procedure SetStartRect(const Value: TBounds);
    procedure SetStopRect(const Value: TBounds);
  protected
    procedure ProcessAnimation; override;
    procedure FirstFrame; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AnimationType default TAnimationType.atIn;
    property AutoReverse default False;
    property Enabled default False;
    property Delay;
    property Duration nodefault;
    property Interpolation default TInterpolationType.itLinear;
    property Inverse default False;
    property Loop default False;
    property OnProcess;
    property OnFinish;
    property PropertyName;
    property StartValue: TBounds read FStartRect write SetStartRect;
    property StartFromCurrent: Boolean read FStartFromCurrent write FStartFromCurrent default False;
    property StopValue: TBounds read FStopRect write SetStopRect;
    property Trigger;
    property TriggerInverse;
  end;

{ TBitmapAnimation }

  TBitmapAnimation = class(TCustomPropertyAnimation)
  private
    FStartBitmap: TBitmap;
    FStopBitmap: TBitmap;
    FCurrent: TBitmap;
    procedure SetStartBitmap(Value: TBitmap);
    procedure SetStopBitmap(Value: TBitmap);
  protected
    procedure ProcessAnimation; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AnimationType default TAnimationType.atIn;
    property AutoReverse default False;
    property Enabled default False;
    property Delay;
    property Duration nodefault;
    property Interpolation default TInterpolationType.itLinear;
    property Inverse default False;
    property Loop default False;
    property OnProcess;
    property OnFinish;
    property PropertyName;
    property StartValue: TBitmap read FStartBitmap write SetStartBitmap;
    property StopValue: TBitmap read FStopBitmap write SetStopBitmap;
    property Trigger;
    property TriggerInverse;
  end;

{ TBitmapListAnimation }

  TBitmapListAnimation = class(TCustomPropertyAnimation)
  private
    FCurrent: TBitmap;
    FAnimationCount: Integer;
    FAnimationBitmap: TBitmap;
    FLastAnimationStep: Integer;
    FAnimationRowCount: Integer;
    procedure SetAnimationBitmap(Value: TBitmap);
    procedure SetAnimationRowCount(const Value: Integer);
  protected
    procedure ProcessAnimation; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AnimationBitmap: TBitmap read FAnimationBitmap write SetAnimationBitmap;
    property AnimationCount: Integer read FAnimationCount write FAnimationCount;
    property AnimationRowCount: Integer read FAnimationRowCount write SetAnimationRowCount default 1;
    property AnimationType default TAnimationType.atIn;
    property AutoReverse default False;
    property Enabled default False;
    property Delay;
    property Duration nodefault;
    property Interpolation default TInterpolationType.itLinear;
    property Inverse default False;
    property Loop default False;
    property OnProcess;
    property OnFinish;
    property PropertyName;
    property Trigger;
    property TriggerInverse;
  end;

{ Key Animations }

{ TKey }

  TKey = class(TCollectionItem)
  private
    FKey: Single;
    procedure SetKey(const Value: Single);
  published
    property Key: Single read FKey write SetKey;
  end;

{ TKeys }

  TKeys = class(TCollection)
  public
    function FindKeys(const Time: Single; var Key1, Key2: TKey): Boolean;
  end;

{ TColorKey }

  TColorKey = class(TKey)
  private
    FValue: TAlphaColor;
  published
    property Value: TAlphaColor read FValue write FValue;
  end;

{ TColorKeyAnimation }

  TColorKeyAnimation = class(TCustomPropertyAnimation)
  private
    FKeys: TKeys;
    FStartFromCurrent: Boolean;
  protected
    procedure ProcessAnimation; override;
    procedure FirstFrame; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AnimationType default TAnimationType.atIn;
    property AutoReverse default False;
    property Enabled default False;
    property Delay;
    property Duration nodefault;
    property Interpolation default TInterpolationType.itLinear;
    property Inverse default False;
    property Keys: TKeys read FKeys write FKeys;
    property Loop default False;
    property OnProcess;
    property OnFinish;
    property PropertyName;
    property StartFromCurrent: Boolean read FStartFromCurrent write FStartFromCurrent;
    property Trigger;
    property TriggerInverse;
  end;

{ TFloatKey }

  TFloatKey = class(TKey)
  private
    FValue: Single;
  published
    property Value: Single read FValue write FValue;
  end;

{ TFloatKeyAnimation }

  TFloatKeyAnimation = class(TCustomPropertyAnimation)
  private
    FKeys: TKeys;
    FStartFromCurrent: Boolean;
  protected
    procedure ProcessAnimation; override;
    procedure FirstFrame; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AnimationType default TAnimationType.atIn;
    property AutoReverse default False;
    property Enabled default False;
    property Delay;
    property Duration nodefault;
    property Interpolation default TInterpolationType.itLinear;
    property Inverse default False;
    property Keys: TKeys read FKeys write FKeys;
    property Loop default False;
    property OnProcess;
    property OnFinish;
    property PropertyName;
    property StartFromCurrent: Boolean read FStartFromCurrent write FStartFromCurrent;
    property Trigger;
    property TriggerInverse;
  end;

implementation

uses
  System.UIConsts, System.Math, System.TypInfo, System.SysUtils, System.Generics.Collections;

{ TCustomPropertyAnimation }

function TCustomPropertyAnimation.FindProperty: Boolean;
var
  Persistent: string;
  Comp: TFmxObject;
  I: Integer;
  T: TRttiType;
  P: TRttiProperty;
  Properties: TList<TRttiProperty>;
begin
  Result := False;

  if Assigned(Parent) and (FPropertyName <> '') then
  begin
    if not Assigned(FInstance) then
    begin
      FInstance := Parent;
      FPath := FPropertyName;
      while FPath.Contains('.') do
      begin
        Persistent := GetToken(FPath, '.');
        T := SharedContext.GetType(FInstance.ClassInfo);
        if Assigned(T) then
        begin
          P := T.GetProperty(Persistent);
          if Assigned(P) and (P.PropertyType.IsInstance) then
            FInstance := P.GetValue(FInstance).AsObject
          else
          if Assigned(Parent) then
          begin
            for I := 0 to Parent.ChildrenCount - 1 do
              if CompareText(Parent.Children[I].Name, Persistent) = 0 then
              begin
                Comp := Parent.Children[I];
                T := SharedContext.GetType(Comp.ClassInfo);
                if Assigned(T) then
                begin
                  P := T.GetProperty(FPath);
                  if Assigned(P) then
                  begin
                    FInstance := Comp;
                    Break;
                  end;
                end;
              end;
          end;
        end;
      end;
      if Assigned(FInstance) then
      begin

        if not ClonePropertiesCache.TryGetValue(FInstance.ClassName, Properties) then
        begin
          Properties := TList<TRttiProperty>.Create;
          ClonePropertiesCache.Add(FInstance.ClassName, Properties);
        end;

        for P in Properties do
          if P.Name = FPath then
          begin
            FRttiProperty := P;
            Break;
          end;

        if FRttiProperty = nil then
        begin
          T := SharedContext.GetType(FInstance.ClassInfo);
          FRttiProperty := T.GetProperty(FPath);
          if FRttiProperty <> nil then
            Properties.Add(FRttiProperty);
        end;
        Result := Assigned(FRttiProperty);
      end;
    end
    else
      Result := True;
  end;
end;

procedure TCustomPropertyAnimation.Start;
begin
  if FindProperty then
    inherited;
end;

procedure TCustomPropertyAnimation.Stop;
begin
  inherited;
  FInstance := nil;
end;

{ TFloatAnimation }

constructor TFloatAnimation.Create(AOwner: TComponent);
begin
  inherited;
  Duration := 0.2;
  FStartFloat := 0;
  FStopFloat := 0;
end;

procedure TFloatAnimation.FirstFrame;
var
  T: TRttiType;
  P: TRttiProperty;
begin
  if StartFromCurrent then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and (P.PropertyType.TypeKind = tkFloat) then
        StartValue := P.GetValue(FInstance).AsExtended;
    end;
  end;
end;

procedure TFloatAnimation.ProcessAnimation;
var
  T: TRttiType;
  P: TRttiProperty;
begin
  if Assigned(FInstance) then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and (P.PropertyType.TypeKind = tkFloat) then
        P.SetValue(FInstance, InterpolateSingle(FStartFloat, FStopFloat, NormalizedTime));
    end;
  end;
end;

{ TIntAnimation }

constructor TIntAnimation.Create(AOwner: TComponent);
begin
  inherited;
  Duration := 0.2;
  FStartValue := 0;
  FStopValue := 0;
end;

procedure TIntAnimation.FirstFrame;
var
  T: TRttiType;
  P: TRttiProperty;
begin
  if StartFromCurrent then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and (P.PropertyType.TypeKind in [tkInteger, tkFloat]) then
        StartValue := Round(P.GetValue(FInstance).AsExtended);
    end;
  end;
end;

procedure TIntAnimation.ProcessAnimation;
var
  T: TRttiType;
  P: TRttiProperty;
begin
  if Assigned(FInstance) then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and (P.PropertyType.TypeKind in [tkInteger, tkFloat]) then
        P.SetValue(FInstance, Round(InterpolateSingle(FStartValue, FStopValue, NormalizedTime)));
    end;
  end;
end;

{ TColorAnimation }

constructor TColorAnimation.Create(AOwner: TComponent);
begin
  inherited;
  Duration := 0.2;
  FStartColor := $FFFFFFFF;
  FStartColor := $FFFFFFFF;
end;

procedure TColorAnimation.FirstFrame;
var
  T: TRttiType;
  P: TRttiProperty;
begin
  if StartFromCurrent then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and (P.PropertyType.IsOrdinal) then
        StartValue := TAlphaColor(P.GetValue(FInstance).AsOrdinal);
    end;
  end;
end;

procedure TColorAnimation.ProcessAnimation;
var
  T: TRttiType;
  P: TRttiProperty;
begin
  if Assigned(FInstance) then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and (P.PropertyType.IsOrdinal) then
        P.SetValue(FInstance, InterpolateColor(FStartColor, FStopColor, NormalizedTime));
    end;
  end;
end;

{ TGradientAnimation }

constructor TGradientAnimation.Create(AOwner: TComponent);
begin
  inherited;
  Duration := 0.2;
  FStartGradient := TGradient.Create;
  FStopGradient := TGradient.Create;
end;

destructor TGradientAnimation.Destroy;
begin
  FreeAndNil(FStartGradient);
  FreeAndNil(FStopGradient);
  inherited;
end;

procedure TGradientAnimation.FirstFrame;
var
  T: TRttiType;
  P: TRttiProperty;
begin
  if StartFromCurrent then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and (P.PropertyType.IsInstance) then
        StartValue := TGradient(P.GetValue(FInstance).AsObject);
    end;
  end;
end;

procedure TGradientAnimation.ProcessAnimation;
var
  T: TRttiType;
  P: TRttiProperty;
  I: Integer;
  TargetGradientTmp: TGradient;
begin
  if Assigned(FInstance) then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and P.PropertyType.IsInstance then
      begin
        TargetGradientTmp := TGradient(P.GetValue(FInstance).AsObject);
        for I := 0 to TargetGradientTmp.Points.Count - 1 do
        begin
          if (I < FStopGradient.Points.Count) and (I < FStartGradient.Points.Count) then
            TargetGradientTmp.Points[I].Color :=
              FMX.Types.InterpolateColor(FStartGradient.Points[I].Color,
                                         FStopGradient.Points[I].Color,
                                         NormalizedTime);
        end;
        TargetGradientTmp.Change;
      end;
    end;
  end;
end;

procedure TGradientAnimation.SetStartGradient(const Value: TGradient);
begin
  FStartGradient.Assign(Value);
end;

procedure TGradientAnimation.SetStopGradient(const Value: TGradient);
begin
  FStopGradient.Assign(Value);
end;

{ TRectAnimation }

constructor TRectAnimation.Create(AOwner: TComponent);
begin
  inherited;
  Duration := 0.2;
  FStartRect := TBounds.Create(RectF(0, 0, 0, 0));
  FStopRect := TBounds.Create(RectF(0, 0, 0, 0));
  FCurrent := TBounds.Create(RectF(0, 0, 0, 0));
end;

destructor TRectAnimation.Destroy;
begin
  FreeAndNil(FCurrent);
  FreeAndNil(FStartRect);
  FreeAndNil(FStopRect);
  inherited;
end;

procedure TRectAnimation.FirstFrame;
begin
  if StartFromCurrent then
  begin
    if Assigned(FRttiProperty) and (FRttiProperty.PropertyType.IsInstance) then
      TBounds(FRttiProperty.GetValue(FInstance).AsObject).Assign(FCurrent);
  end;
end;

procedure TRectAnimation.ProcessAnimation;
begin
  if Assigned(FInstance) then
  begin
    { calc value }
    FCurrent.Left := InterpolateSingle(FStartRect.Left, FStopRect.Left,
      NormalizedTime);
    FCurrent.Top := InterpolateSingle(FStartRect.Top, FStopRect.Top,
      NormalizedTime);
    FCurrent.Right := InterpolateSingle(FStartRect.Right, FStopRect.Right,
      NormalizedTime);
    FCurrent.Bottom := InterpolateSingle(FStartRect.Bottom, FStopRect.Bottom,
      NormalizedTime);

    if Assigned(FRttiProperty) and (FRttiProperty.PropertyType.IsInstance) then
      TBounds(FRttiProperty.GetValue(FInstance).AsObject).Assign(FCurrent);
  end;
end;

procedure TRectAnimation.SetStartRect(const Value: TBounds);
begin
  FStartRect.Assign(Value);
end;

procedure TRectAnimation.SetStopRect(const Value: TBounds);
begin
  FStopRect.Assign(Value);
end;

{ TBitmapAnimation }

constructor TBitmapAnimation.Create(AOwner: TComponent);
begin
  inherited;
  Duration := 0.2;
  FStartBitmap := TBitmap.Create(1, 1);
  FStopBitmap := TBitmap.Create(1, 1);
  FCurrent := TBitmap.Create(1, 1);
end;

destructor TBitmapAnimation.Destroy;
begin
  FreeAndNil(FCurrent);
  FreeAndNil(FStartBitmap);
  FreeAndNil(FStopBitmap);
  inherited;
end;

procedure TBitmapAnimation.ProcessAnimation;
var
  T: TRttiType;
  P: TRttiProperty;
  Value: TPersistent;
begin
  if Assigned(FInstance) then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and (P.PropertyType.IsInstance) then
      begin
        Value := TPersistent(P.GetValue(FInstance).AsObject);
        if Assigned(Value) and (Value is TPersistent) then
        begin
          if Inverse then
          begin
            { assign to start }
            FCurrent.SetSize(FStopBitmap.Width, FStopBitmap.Height);
            { draw final with alpha }
            if FCurrent.Canvas.BeginScene then
            try
              FCurrent.Canvas.Clear(0);
              FCurrent.Canvas.DrawBitmap(FStopBitmap,
                RectF(0, 0, FCurrent.Width, FCurrent.Height),
                RectF(0, 0, FStopBitmap.Width, FStopBitmap.Height),
                NormalizedTime);
              FCurrent.Canvas.DrawBitmap(FStartBitmap,
                RectF(0, 0, FCurrent.Width, FCurrent.Height),
                RectF(0, 0, FStartBitmap.Width, FStartBitmap.Height),
                1 - NormalizedTime);
            finally
              FCurrent.Canvas.EndScene;
            end;
          end
          else
          begin
            { assign to start }
            FCurrent.SetSize(FStartBitmap.Width, FStartBitmap.Height);
            { draw final with alpha }
            if FCurrent.Canvas.BeginScene then
            try
              FCurrent.Canvas.Clear(0);
              FCurrent.Canvas.DrawBitmap(FStartBitmap,
                RectF(0, 0, FCurrent.Width, FCurrent.Height),
                RectF(0, 0, FStartBitmap.Width, FStartBitmap.Height),
                1 - NormalizedTime);
              FCurrent.Canvas.DrawBitmap(FStopBitmap,
                RectF(0, 0, FCurrent.Width, FCurrent.Height),
                RectF(0, 0, FStopBitmap.Width, FStopBitmap.Height),
                NormalizedTime);
            finally
              FCurrent.Canvas.EndScene;
            end;
          end;
          { assign }
          TPersistent(Value).Assign(FCurrent);
        end;
      end;
    end;
  end;
end;

procedure TBitmapAnimation.SetStartBitmap(Value: TBitmap);
begin
  FStartBitmap.Assign(Value);
end;

procedure TBitmapAnimation.SetStopBitmap(Value: TBitmap);
begin
  FStopBitmap.Assign(Value);
end;

{ TBitmapListAnimation }

constructor TBitmapListAnimation.Create(AOwner: TComponent);
begin
  inherited;
  Duration := 0.2;
  FCurrent := TBitmap.Create(0, 0);
  FAnimationBitmap := TBitmap.Create(0, 0);
  FAnimationCount := 1;
  FAnimationRowCount := 1;
  FLastAnimationStep := 0;
end;

destructor TBitmapListAnimation.Destroy;
begin
  FreeAndNil(FCurrent);
  FreeAndNil(FAnimationBitmap);
  inherited;
end;

procedure TBitmapListAnimation.ProcessAnimation;
var
  T: TRttiType;
  P: TRttiProperty;
  Value: TObject;
  TopPos, LeftPos, CurrentIndex: Integer;
  NowValue: Single;
  B: TBitmap;
  AnimationColCount: Integer;
begin
  if Assigned(FInstance) then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and (P.PropertyType.IsInstance) then
      begin
        Value := P.GetValue(FInstance).AsObject;
        B := FAnimationBitmap.ResourceBitmap;
        if not Assigned(B) then
          B := FAnimationBitmap;
        if Assigned(Value) and (Value is TBitmap) and not (B.IsEmpty) then
        begin
          NowValue := InterpolateSingle(0, FAnimationCount, NormalizedTime);

          if FAnimationCount mod FAnimationRowCount = 0 then
            AnimationColCount := FAnimationCount div FAnimationRowCount
          else
            AnimationColCount := FAnimationCount div FAnimationRowCount + 1;
          FCurrent.SetSize(B.Width div AnimationColCount, B.Height div FAnimationRowCount);

          CurrentIndex := Trunc(NowValue);
          if CurrentIndex > FAnimationCount - 1 then
            CurrentIndex := FAnimationCount - 1;

          LeftPos := (CurrentIndex mod AnimationColCount) * (B.Width div AnimationColCount);
          TopPos := (CurrentIndex div AnimationColCount) * (B.Height div AnimationRowCount);

          if FCurrent.Canvas.BeginScene then
          try
            FCurrent.Canvas.Clear(0);
            FCurrent.Canvas.DrawBitmap(B,
              RectF(LeftPos, TopPos, LeftPos + FCurrent.Width, TopPos + FCurrent.Height),
              RectF(0, 0, FCurrent.Width, FCurrent.Height), 1);
          finally
            FCurrent.Canvas.EndScene;
          end;

          TPersistent(Value).Assign(FCurrent);
        end;
      end;
    end;
  end;
end;

procedure TBitmapListAnimation.SetAnimationBitmap(Value: TBitmap);
begin
  FAnimationBitmap.Assign(Value);
end;

procedure TBitmapListAnimation.SetAnimationRowCount(const Value: Integer);
begin
  FAnimationRowCount := Value;
  if FAnimationRowCount < 1 then
    FAnimationRowCount := 1;
end;

{ Key Animation }

{ TKey }

procedure TKey.SetKey(const Value: Single);
begin
  FKey := Value;
  if FKey < 0 then
    FKey := 0;
  if FKey > 1 then
    FKey := 1;
end;

{ TKeys }

function TKeys.FindKeys(const Time: Single; var Key1, Key2: TKey): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Count < 2 then
    Exit;
  for i := 0 to Count - 2 do
    if ((Time >= TKey(Items[i]).Key) and (Time <= TKey(Items[i + 1]).Key)) then
    begin
      Result := True;
      Key1 := TKey(Items[i]);
      Key2 := TKey(Items[i + 1]);
      Exit;
    end;
end;

{ TColorKeyAnimation }

constructor TColorKeyAnimation.Create(AOwner: TComponent);
begin
  inherited;
  FKeys := TKeys.Create(TColorKey);
end;

destructor TColorKeyAnimation.Destroy;
begin
  FreeAndNil(FKeys);
  inherited;
end;

procedure TColorKeyAnimation.FirstFrame;
var
  T: TRttiType;
  P: TRttiProperty;
begin
  if StartFromCurrent then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and (P.PropertyType.IsOrdinal) and (Keys.Count > 0) then
        TColorKey(Keys.Items[0]).Value := P.GetValue(FInstance).AsOrdinal;
    end;
  end;
end;

procedure TColorKeyAnimation.ProcessAnimation;
var
  T: TRttiType;
  P: TRttiProperty;
  Key1, Key2: TKey;
begin
  if Assigned(FInstance) then
  begin
    if FKeys.FindKeys(NormalizedTime, Key1, Key2) then
    begin
      if (TFloatKey(Key2).Key - TFloatKey(Key1).Key) = 0 then
        Exit;
      T := SharedContext.GetType(FInstance.ClassInfo);
      if Assigned(T) then
      begin
        P := T.GetProperty(FPath);
        if Assigned(P) and (P.PropertyType.IsOrdinal) then
          P.SetValue(FInstance,
            InterpolateColor(TColorKey(Key1).Value,
            TColorKey(Key2).Value,
            (NormalizedTime - TFloatKey(Key1).Key) / (TFloatKey(Key2).Key -
            TFloatKey(Key1).Key)));
      end;
    end;
  end;
end;

{ TFloatKeyAnimation }

constructor TFloatKeyAnimation.Create(AOwner: TComponent);
begin
  inherited;
  FKeys := TKeys.Create(TFloatKey);
end;

destructor TFloatKeyAnimation.Destroy;
begin
  FreeAndNil(FKeys);
  inherited;
end;

procedure TFloatKeyAnimation.FirstFrame;
var
  T: TRttiType;
  P: TRttiProperty;
begin
  if StartFromCurrent then
  begin
    T := SharedContext.GetType(FInstance.ClassInfo);
    if Assigned(T) then
    begin
      P := T.GetProperty(FPath);
      if Assigned(P) and (P.PropertyType.IsOrdinal) and (Keys.Count > 0) then
        TFloatKey(Keys.Items[0]).Value := P.GetValue(FInstance).AsExtended;
    end;
  end;
end;

procedure TFloatKeyAnimation.ProcessAnimation;
var
  T: TRttiType;
  P: TRttiProperty;
  Key1, Key2: TKey;
begin
  if Assigned(FInstance) then
  begin
    if FKeys.FindKeys(NormalizedTime, Key1, Key2) then
    begin
      if (TFloatKey(Key2).Key - TFloatKey(Key1).Key) = 0 then
        Exit;
      T := SharedContext.GetType(FInstance.ClassInfo);
      if Assigned(T) then
      begin
        P := T.GetProperty(FPath);
        if Assigned(P) and (P.PropertyType.TypeKind = tkFloat) then
          P.SetValue(FInstance, InterpolateSingle(TFloatKey(Key1).Value, TFloatKey(Key2).Value,
            (NormalizedTime - TFloatKey(Key1).Key) / (TFloatKey(Key2).Key - TFloatKey(Key1).Key)))
        else if Assigned(P) and (P.PropertyType.IsOrdinal) then
          P.SetValue(FInstance, Round(InterpolateSingle(TFloatKey(Key1).Value, TFloatKey(Key2).Value,
            (NormalizedTime - TFloatKey(Key1).Key) / (TFloatKey(Key2).Key - TFloatKey(Key1).Key))));
      end;
    end;
  end;
end;

initialization
  RegisterFmxClasses([TColorAnimation, TGradientAnimation, TFloatAnimation, TIntAnimation,
    TRectAnimation, TBitmapAnimation, TBitmapListAnimation, TColorKeyAnimation,
    TFloatKeyAnimation]);
end.

