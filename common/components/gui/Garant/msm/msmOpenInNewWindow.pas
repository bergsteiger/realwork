unit msmOpenInNewWindow;

// Модуль: "w:\common\components\gui\Garant\msm\msmOpenInNewWindow.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmOpenInNewWindow" MUID: (57CED1F0037B)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeOperation
 , msmOperations
;

type
 TmsmOpenInNewWindow = class(TmsmListLikeOperation)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
   procedure InitOperationParams(var theParams: TmsmOperationParams); override;
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

function TmsmOpenInNewWindow.GetEnabled: Boolean;
//#UC START# *57EB6D020381_57CED1F0037B_var*
//#UC END# *57EB6D020381_57CED1F0037B_var*
begin
//#UC START# *57EB6D020381_57CED1F0037B_impl*
 Result := (Self.Model.CurrentElement <> nil);
//#UC END# *57EB6D020381_57CED1F0037B_impl*
end;//TmsmOpenInNewWindow.GetEnabled

procedure TmsmOpenInNewWindow.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57CED1F0037B_var*
//#UC END# *57EBADA9033E_57CED1F0037B_var*
begin
//#UC START# *57EBADA9033E_57CED1F0037B_impl*
 inherited;
 theParams.rImageIndex := 45;
//#UC END# *57EBADA9033E_57CED1F0037B_impl*
end;//TmsmOpenInNewWindow.InitOperationParams

end.
