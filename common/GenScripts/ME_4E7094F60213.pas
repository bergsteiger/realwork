unit nevPageBreakFormatInfo;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevPageBreakFormatInfo.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevLeafRenderInfo
 , nevBase
;

type
 TnevPageBreakFormatInfo = class(TnevLeafRenderInfo)
  protected
   procedure DoRecalc(const aView: InevViewMetrics); override;
 end;//TnevPageBreakFormatInfo

implementation

uses
 l3ImplUses
 , k2Tags
;

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
