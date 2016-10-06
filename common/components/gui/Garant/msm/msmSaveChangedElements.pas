unit msmSaveChangedElements;

// Модуль: "w:\common\components\gui\Garant\msm\msmSaveChangedElements.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmSaveChangedElements" MUID: (57E10D840208)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmOperation
 , msmOperations
;

type
 TmsmSaveChangedElements = class(TmsmOperation)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
   procedure InitOperationParams(var theParams: TmsmOperationParams); override;
 end;//TmsmSaveChangedElements

implementation

uses
 l3ImplUses
 , msmChangedElements
 //#UC START# *57E10D840208impl_uses*
 //#UC END# *57E10D840208impl_uses*
;

procedure TmsmSaveChangedElements.DoDoIt;
//#UC START# *57CEB1F602D1_57E10D840208_var*
//#UC END# *57CEB1F602D1_57E10D840208_var*
begin
//#UC START# *57CEB1F602D1_57E10D840208_impl*
 TmsmChangedElements.Instance.Save;
//#UC END# *57CEB1F602D1_57E10D840208_impl*
end;//TmsmSaveChangedElements.DoDoIt

function TmsmSaveChangedElements.GetEnabled: Boolean;
//#UC START# *57EB6D020381_57E10D840208_var*
//#UC END# *57EB6D020381_57E10D840208_var*
begin
//#UC START# *57EB6D020381_57E10D840208_impl*
 Result := not TmsmChangedElements.Instance.Empty;
//#UC END# *57EB6D020381_57E10D840208_impl*
end;//TmsmSaveChangedElements.GetEnabled

procedure TmsmSaveChangedElements.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57E10D840208_var*
//#UC END# *57EBADA9033E_57E10D840208_var*
begin
//#UC START# *57EBADA9033E_57E10D840208_impl*
 inherited;
 theParams.rImageIndex := 22;
 theParams.SetShortCut('Ctrl+S');
//#UC END# *57EBADA9033E_57E10D840208_impl*
end;//TmsmSaveChangedElements.InitOperationParams

end.
