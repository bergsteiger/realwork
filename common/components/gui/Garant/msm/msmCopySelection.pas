unit msmCopySelection;

// Модуль: "w:\common\components\gui\Garant\msm\msmCopySelection.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmCopySelection" MUID: (57E2607203E3)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeOperation
 , msmOperations
;

type
 TmsmCopySelection = class(TmsmListLikeOperation)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
   procedure InitOperationParams(var theParams: TmsmOperationParams); override;
 end;//TmsmCopySelection

implementation

uses
 l3ImplUses
 , msmElementSelectionDataObject
 //#UC START# *57E2607203E3impl_uses*
 , l3Base
 //#UC END# *57E2607203E3impl_uses*
;

procedure TmsmCopySelection.DoDoIt;
//#UC START# *57CEB1F602D1_57E2607203E3_var*
//#UC END# *57CEB1F602D1_57E2607203E3_var*
begin
//#UC START# *57CEB1F602D1_57E2607203E3_impl*
 l3System.SetClipboardData(TmsmElementSelectionDataObject.Make(Model.Selection));
//#UC END# *57CEB1F602D1_57E2607203E3_impl*
end;//TmsmCopySelection.DoDoIt

function TmsmCopySelection.GetEnabled: Boolean;
//#UC START# *57EB6D020381_57E2607203E3_var*
//#UC END# *57EB6D020381_57E2607203E3_var*
begin
//#UC START# *57EB6D020381_57E2607203E3_impl*
 Result := false;
 if (Model.Selection = nil) then
  Exit;
 if Model.Selection.Empty AND (Model.Selection.CurrentElement = nil) then
  Exit;
 Result := true;
//#UC END# *57EB6D020381_57E2607203E3_impl*
end;//TmsmCopySelection.GetEnabled

procedure TmsmCopySelection.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57E2607203E3_var*
//#UC END# *57EBADA9033E_57E2607203E3_var*
begin
//#UC START# *57EBADA9033E_57E2607203E3_impl*
 inherited;
 theParams.rImageIndex := 9;
//#UC END# *57EBADA9033E_57E2607203E3_impl*
end;//TmsmCopySelection.InitOperationParams

end.
