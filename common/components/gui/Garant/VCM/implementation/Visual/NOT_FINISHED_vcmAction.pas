unit NOT_FINISHED_vcmAction;
 {* Базовая операция библиотеки vcm для привязки к меню. }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\NOT_FINISHED_vcmAction.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmAction" MUID: (47E761BB02FE)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3PureMixIns
;

type
 _l3Unknown_Parent_ = TCustomAction;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvcmAction = class(_l3Unknown_)
  {* Базовая операция библиотеки vcm для привязки к меню. }
  protected
   procedure DoUpdate; virtual;
 end;//TvcmAction
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

procedure TvcmAction.DoUpdate;
//#UC START# *47E766E10053_47E761BB02FE_var*
//#UC END# *47E766E10053_47E761BB02FE_var*
begin
//#UC START# *47E766E10053_47E761BB02FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E766E10053_47E761BB02FE_impl*
end;//TvcmAction.DoUpdate

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmAction);
 {* Регистрация TvcmAction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
