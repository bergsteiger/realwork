unit vgEffect;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgEffect.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgEffect
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

uses
  Classes,

  vgTypes,
  vgObject,

  vg_scene,
  vgBitmap
  ;

type
  TvgEffect = class(TvgObject)
  private
    FEnabled: boolean;
    FTrigger: string;
    procedure SetEnabled(const Value: boolean);
  protected
    DisablePaint: boolean;
    AfterPaint: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    function GetRect(const ARect: TvgRect): TvgRect; virtual;
    function GetOffset: TvgPoint; virtual;
    procedure ProcessEffect(Canvas: TvgCanvas; const Visual: TvgBitmap; const Data: single); virtual;
    procedure ApplyTrigger(AInstance: TvgObject; ATrigger: string); virtual;
    procedure UpdateParentEffects;
    property GetDisablePaint: boolean read DisablePaint;
  published
    property Trigger: string read FTrigger write FTrigger;
    property Enabled: boolean read FEnabled write SetEnabled default true;
  end;

implementation

uses
  SysUtils,
  TypInfo
  ;

{ TvgEffect ===================================================================}

constructor TvgEffect.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := true;
end;

procedure TvgEffect.Cleanup;
begin
  inherited;
end;

function TvgEffect.GetOffset: TvgPoint;          
begin

end;

function TvgEffect.GetRect(const ARect: TvgRect): TvgRect;
begin
  Result := ARect;
end;

procedure TvgEffect.ApplyTrigger(AInstance: TvgObject; ATrigger: string);
var
  StartValue: boolean;
  Line, Setter, Prop, Value: AnsiString;
begin
  if FTrigger = '' then Exit;
  if AInstance = nil then Exit;
  if Pos(LowerCase(ATrigger), LowerCase(FTrigger)) = 0 then Exit;

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
    end;
    Setter := vgGetToken(Line, ';');
  end;
  Enabled := StartValue;
end;

type
  TvgHackVisualObject = class(TvgVisualObject)
  end;//TvgHackVisualObject

procedure TvgEffect.UpdateParentEffects;
var
  SaveEnabled: boolean;
begin
  if not (csLoading in ComponentState) then
    if (Parent <> nil) and (Parent.isVisual) then
    begin
      TvgVisualObject(Parent).UpdateEffects;
      TvgHackVisualObject(TvgVisualObject(Parent)).FNeedRecalcUpdateRect := true;
      // update if enabled = false (erase effect )
      SaveEnabled := FEnabled;
      FEnabled := true;
      TvgVisualObject(Parent).Repaint;
      FEnabled := SaveEnabled;
    end;//(Parent <> nil) and (Parent.isVisual)
end;

procedure TvgEffect.ProcessEffect(Canvas: TvgCanvas;
  const Visual: TvgBitmap; const Data: single);
begin
end;

procedure TvgEffect.SetEnabled(const Value: boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if FEnabled then
    begin
      if (Parent <> nil) and (Parent.isVisual) then
        TvgHackVisualObject(TvgVisualObject(Parent)).RecalcHasEffect;
    end;//FEnabled
    UpdateParentEffects;
  end;
end;

end.