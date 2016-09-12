unit msmOpenInNewWindow;

// Модуль: "w:\common\components\gui\Garant\msm\msmOpenInNewWindow.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmOpenInNewWindow" MUID: (57CED1F0037B)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeOperation
;

type
 TmsmOpenInNewWindow = class(TmsmListLikeOperation)
  protected
   procedure DoDoIt; override;
 end;//TmsmOpenInNewWindow

implementation

uses
 l3ImplUses
 , msmOpenService
 //#UC START# *57CED1F0037Bimpl_uses*
 //#UC END# *57CED1F0037Bimpl_uses*
;

procedure TmsmOpenInNewWindow.DoDoIt;
//#UC START# *57CEB1F602D1_57CED1F0037B_var*
//#UC END# *57CEB1F602D1_57CED1F0037B_var*
begin
//#UC START# *57CEB1F602D1_57CED1F0037B_impl*
 TmsmOpenService.Instance.OpenListInNewWindow(Self.Model.CurrentElement);
//#UC END# *57CEB1F602D1_57CED1F0037B_impl*
end;//TmsmOpenInNewWindow.DoDoIt

end.
