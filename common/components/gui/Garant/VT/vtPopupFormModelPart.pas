unit vtPopupFormModelPart;

// Модуль: "w:\common\components\gui\Garant\VT\vtPopupFormModelPart.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtPopupFormModelPart" MUID: (4D9058880214)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vtPopupForm
 , vcmExternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Types
;

type
 TTailRects = array [TvtTailPosition] of TRect;

 TPopupFormBoundsRects = record
  rInited: Boolean;
  rV: TTailRects;
 end;//TPopupFormBoundsRects

 TvtPopupFormModelPart = class(TvtPopupForm, IvcmDatasourceChangeListener)
  protected
   procedure DataSourceChanged(aControl: TControl);
 end;//TvtPopupFormModelPart
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TvtPopupFormModelPart.DataSourceChanged(aControl: TControl);
//#UC START# *4D905A2A00D6_4D9058880214_var*
var
 l_L : IvcmDatasourceChangeListener;
//#UC END# *4D905A2A00D6_4D9058880214_var*
begin
//#UC START# *4D905A2A00D6_4D9058880214_impl*
 if Supports(Owner, IvcmDatasourceChangeListener, l_L) then
  try
   l_L.DataSourceChanged(aControl);
  finally
   l_L := nil;
  end;//try..finally
//#UC END# *4D905A2A00D6_4D9058880214_impl*
end;//TvtPopupFormModelPart.DataSourceChanged

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtPopupFormModelPart);
 {* Регистрация TvtPopupFormModelPart }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM)

end.
