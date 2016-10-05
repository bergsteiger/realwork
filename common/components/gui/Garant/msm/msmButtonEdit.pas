unit msmButtonEdit;

// Модуль: "w:\common\components\gui\Garant\msm\msmButtonEdit.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmButtonEdit" MUID: (57E450D600BF)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , ctButtonEdit
 , CustomElGraphicButton
 //#UC START# *57E450D600BFintf_uses*
 //#UC END# *57E450D600BFintf_uses*
;

type
 TmsmButtonEditButton = TCustomElGraphicButton;

 //#UC START# *57E450D600BFci*
 //#UC END# *57E450D600BFci*
 //#UC START# *57E450D600BFcit*
 //#UC END# *57E450D600BFcit*
 TmsmButtonEdit = class(TctButtonEdit)
 //#UC START# *57E450D600BFpubl*
  public
   property Button;
   property OnButtonClick;
   property OnReturn;
 //#UC END# *57E450D600BFpubl*
 end;//TmsmButtonEdit

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57E450D600BFimpl_uses*
 //#UC END# *57E450D600BFimpl_uses*
;

//#UC START# *57E450D600BFimpl*
//#UC END# *57E450D600BFimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmButtonEdit);
 {* Регистрация TmsmButtonEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
