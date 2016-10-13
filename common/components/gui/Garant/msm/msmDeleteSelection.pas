unit msmDeleteSelection;

// Модуль: "w:\common\components\gui\Garant\msm\msmDeleteSelection.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmDeleteSelection" MUID: (57F7B70C0310)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeOperation
 , msmOperations
;

type
 TmsmDeleteSelection = class(TmsmListLikeOperation)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
   procedure InitOperationParams(var theParams: TmsmOperationParams); override;
 end;//TmsmDeleteSelection

implementation

uses
 l3ImplUses
 //#UC START# *57F7B70C0310impl_uses*
 //#UC END# *57F7B70C0310impl_uses*
;

procedure TmsmDeleteSelection.DoDoIt;
//#UC START# *57CEB1F602D1_57F7B70C0310_var*
//#UC END# *57CEB1F602D1_57F7B70C0310_var*
begin
//#UC START# *57CEB1F602D1_57F7B70C0310_impl*
 Model.DeleteSelection;
//#UC END# *57CEB1F602D1_57F7B70C0310_impl*
end;//TmsmDeleteSelection.DoDoIt

function TmsmDeleteSelection.GetEnabled: Boolean;
//#UC START# *57EB6D020381_57F7B70C0310_var*
//#UC END# *57EB6D020381_57F7B70C0310_var*
begin
//#UC START# *57EB6D020381_57F7B70C0310_impl*
 Result := Model.CanDeleteSelection;
//#UC END# *57EB6D020381_57F7B70C0310_impl*
end;//TmsmDeleteSelection.GetEnabled

procedure TmsmDeleteSelection.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57F7B70C0310_var*
//#UC END# *57EBADA9033E_57F7B70C0310_var*
begin
//#UC START# *57EBADA9033E_57F7B70C0310_impl*
 inherited;
 theParams.rImageIndex := 5;
 theParams.SetShortCut('Del');
//#UC END# *57EBADA9033E_57F7B70C0310_impl*
end;//TmsmDeleteSelection.InitOperationParams

end.
