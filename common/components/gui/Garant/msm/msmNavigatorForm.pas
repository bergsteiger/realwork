unit msmNavigatorForm;

// Модуль: "w:\common\components\gui\Garant\msm\msmNavigatorForm.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmNavigatorForm" MUID: (57B6C2D500AE)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmRefcountedForm
 //#UC START# *57B6C2D500AEintf_uses*
 //#UC END# *57B6C2D500AEintf_uses*
;

type
 //#UC START# *57B6C2D500AEci*
 //#UC END# *57B6C2D500AEci*
 //#UC START# *57B6C2D500AEcit*
 //#UC END# *57B6C2D500AEcit*
 TmsmNavigatorForm = class(TmsmRefcountedForm)
 //#UC START# *57B6C2D500AEpubl*
 //#UC END# *57B6C2D500AEpubl*
 end;//TmsmNavigatorForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57B6C2D500AEimpl_uses*
 //#UC END# *57B6C2D500AEimpl_uses*
;

//#UC START# *57B6C2D500AEimpl*
{$R *.dfm}
//#UC END# *57B6C2D500AEimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmNavigatorForm);
 {* Регистрация TmsmNavigatorForm }
{$IfEnd} // NOT Defined(NoScripts)

end.
