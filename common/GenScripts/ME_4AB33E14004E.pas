unit NOT_FINISHED_vcmModule;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\NOT_FINISHED_vcmModule.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmModule" MUID: (4AB33E14004E)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , Classes
 , vcmBase
 , l3PureMixIns
;

type
 RvcmModule = class of TvcmModule;

 _l3Unknown_Parent_ = TComponent;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvcmModule = class(_l3Unknown_)
  protected
   class procedure GetEntityForms(aList: TvcmClassList); virtual;
 end;//TvcmModule
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

class procedure TvcmModule.GetEntityForms(aList: TvcmClassList);
//#UC START# *577A5A440158_4AB33E14004E_var*
//#UC END# *577A5A440158_4AB33E14004E_var*
begin
//#UC START# *577A5A440158_4AB33E14004E_impl*
 !!! Needs to be implemented !!!
//#UC END# *577A5A440158_4AB33E14004E_impl*
end;//TvcmModule.GetEntityForms

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmModule);
 {* Регистрация TvcmModule }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
