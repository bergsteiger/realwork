unit vgVisual;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgVisual.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgVisual
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

  vgVisualObject,
  vgPersistent
  ;

type
  TvgVisual = class(TvgPersistent)
  private
    FOnChanged: TNotifyEvent;
  protected  
    FVisualObject: TvgVisualObject;
  private
    procedure SetVisualObject(const Value: TvgVisualObject);
  public
    constructor Create;
    procedure Cleanup; override;
    procedure Assign(Source: TPersistent); override;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  published
    property VisualObject: TvgVisualObject read FVisualObject write SetVisualObject;
  end;

{$EndIf  NoVGScene}

implementation

{$IfNDef NoVGScene}

// start class TvgVisual

{ TvgVisual ===================================================================}

constructor TvgVisual.Create;
begin
  inherited;
end;

procedure TvgVisual.Assign(Source: TPersistent);
begin
  if Source is TvgVisual then
  begin
    VisualObject := TvgVisual(Source).VisualObject;
  end
  else
    inherited;
end;

procedure TvgVisual.Cleanup;
begin
  if FVisualObject <> nil then
  begin
    FVisualObject.RemoveFreeNotify(Self);
    FVisualObject := nil;
  end;
  inherited;
end;

procedure TvgVisual.SetVisualObject(const Value: TvgVisualObject);
begin
  if FVisualObject <> Value then
  begin
    if FVisualObject <> nil then
      FVisualObject.RemoveFreeNotify(Self);
    FVisualObject := Value;
    if Assigned(FOnChanged) then FOnChanged(Self);
    if FVisualObject <> nil then
      FVisualObject.AddFreeNotify(Self);
  end;
end;

{$EndIf  NoVGScene}

end.
