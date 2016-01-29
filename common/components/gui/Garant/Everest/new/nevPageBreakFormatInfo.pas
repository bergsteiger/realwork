unit nevPageBreakFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevPageBreakFormatInfo.pas"
// Начат: 14.09.2011 15:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevPageBreakFormatInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevLeafRenderInfo,
  nevBase
  ;

type
 TnevPageBreakFormatInfo = class(TnevLeafRenderInfo)
 protected
 // overridden protected methods
   procedure DoRecalc(const aView: InevViewMetrics); override;
 end;//TnevPageBreakFormatInfo

implementation

uses
  k2Tags
  ;

// start class TnevPageBreakFormatInfo

procedure TnevPageBreakFormatInfo.DoRecalc(const aView: InevViewMetrics);
//#UC START# *4E7094780214_4E7094F60213_var*
//#UC END# *4E7094780214_4E7094F60213_var*
begin
//#UC START# *4E7094780214_4E7094F60213_impl*
 {$IfDef Nemesis}
 if not aView.ShowSpecial then
  WHeight(0)
 else
 {$EndIf Nemesis}
  WHeight(Obj.AsObject.IntA[k2_tiHeight]);
 WWidth(Obj.AsObject.IntA[k2_tiWidth]);
 wMap(nil);
//#UC END# *4E7094780214_4E7094F60213_impl*
end;//TnevPageBreakFormatInfo.DoRecalc

end.