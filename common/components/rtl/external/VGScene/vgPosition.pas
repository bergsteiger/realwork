unit vgPosition;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgPosition.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgPosition
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

  //vgNonModelTypes,
  vgTypes,
  vgPersistent
  ;


{$IfDef Nemesis}
 {$Define vgNoDefaults}
{$EndIf Nemesis}

type
  TvgPosition = class(TvgPersistent)
  private
    FOnChange: TNotifyEvent;
  protected
    FY: single;
    FX: single;
  private
    {$IfNDef vgNoDefaults}
    FDefaultValue: TvgPoint;
    {$EndIf  vgNoDefaults}
  protected
    procedure SetPoint(const Value: TvgPoint);
  private
    procedure SetX(const Value: single);
    procedure SetY(const Value: single);
    function GetPoint: TvgPoint;
    function GetVector: TvgVector;
    procedure SetVector(const Value: TvgVector);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadPoint(Reader: TReader);
    procedure WritePoint(Writer: TWriter);
    {$IfNDef DesignTimeLibrary}
    class function IsCacheable : Boolean; override;
    {$EndIf  DesignTimeLibrary}
  public
    constructor Create(const ADefaultValue: TvgPoint); virtual;
    procedure Assign(Source: TPersistent); override;
    function Empty: boolean;
    procedure Reflect(const Normal: TvgVector);
    property Point: TvgPoint read GetPoint write SetPoint;
    property Vector: TvgVector read GetVector write SetVector;
    {$IfNDef vgNoDefaults}
    property DefaultValue: TvgPoint read FDefaultValue write FDefaultValue;
    {$EndIf  vgNoDefaults}
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property X: single read FX write SetX stored false;
    property Y: single read FY write SetY stored false;
  end;

{$EndIf  NoVGScene}

implementation

{$IfNDef NoVGScene}

uses
  vg_scene
  ;

{ TvgPosition }

constructor TvgPosition.Create(const ADefaultValue: TvgPoint);
begin
  inherited Create;
  {$IfNDef vgNoDefaults}
  FDefaultValue := ADefaultValue;
  {$EndIf vgNoDefaults}
  FX := aDefaultValue.X;
  FY := aDefaultValue.Y;
end;

procedure TvgPosition.Assign(Source: TPersistent);
begin
  if Source is TvgPosition then
  begin
    Point := TvgPosition(Source).Point;
  end
  else
    inherited
end;

function TvgPosition.Empty: boolean;
begin
  Result := (FX = 0) and (FY = 0);
end;

procedure TvgPosition.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Point', ReadPoint, WritePoint,
   {$IfNDef vgNoDefaults}
   (FX <> DefaultValue.X) or (FY <> DefaultValue.Y)
   {$Else  vgNoDefaults}
   true
   {$EndIf vgNoDefaults}
   );
end;

procedure TvgPosition.ReadPoint(Reader: TReader);
begin
  Point := vgStringToPoint(Reader.ReadString);
end;

procedure TvgPosition.WritePoint(Writer: TWriter);
begin
  Writer.WriteString(vgPointToString(Point));
end;

{$IfNDef DesignTimeLibrary}
class function TvgPosition.IsCacheable : Boolean;
begin
 Result := true;
end;
{$EndIf  DesignTimeLibrary}

function TvgPosition.GetPoint: TvgPoint;
begin
  Result := vgPoint(Fx, Fy);
end;

procedure TvgPosition.SetPoint(const Value: TvgPoint);
begin
  Fx := Value.X;
  Fy := Value.Y;
  if Assigned(OnChange) then
    OnChange(Self);
end;

procedure TvgPosition.SetX(const Value: single);
begin
  if FX <> Value then
  begin
    FX := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TvgPosition.SetY(const Value: single);
begin
  if FY <> Value then
  begin
    FY := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

function TvgPosition.GetVector: TvgVector;
begin
  Result := vgVector(FX, FY);
end;

procedure TvgPosition.SetVector(const Value: TvgVector);
begin
  Point := vgPoint(Value.X, Value.Y);
end;

procedure TvgPosition.Reflect(const Normal: TvgVector);
begin
  Vector := vgVectorReflect(Vector, Normal);
end;

{$EndIf  NoVGScene}

end.