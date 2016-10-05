unit msmShowInNavigator;

// Модуль: "w:\common\components\gui\Garant\msm\msmShowInNavigator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmShowInNavigator" MUID: (57CEBC210073)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListToTreeOperation
 , msmOperations
;

type
 TmsmShowInNavigator = class(TmsmListToTreeOperation)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
   procedure InitOperationParams(var theParams: TmsmOperationParams); override;
 end;//TmsmShowInNavigator

implementation

uses
 l3ImplUses
 //#UC START# *57CEBC210073impl_uses*
 , l3InterfacesMisc
 //#UC END# *57CEBC210073impl_uses*
;

procedure TmsmShowInNavigator.DoDoIt;
//#UC START# *57CEB1F602D1_57CEBC210073_var*
//#UC END# *57CEB1F602D1_57CEBC210073_var*
begin
//#UC START# *57CEB1F602D1_57CEBC210073_impl*
 ModelToFire.CurrentElement := ModelToListen.CurrentElement;
//#UC END# *57CEB1F602D1_57CEBC210073_impl*
end;//TmsmShowInNavigator.DoDoIt

function TmsmShowInNavigator.GetEnabled: Boolean;
//#UC START# *57EB6D020381_57CEBC210073_var*
//#UC END# *57EB6D020381_57CEBC210073_var*
begin
//#UC START# *57EB6D020381_57CEBC210073_impl*
 Result := false;
 if l3IEQ(ModelToFire, ModelToListen) then
  Exit;
 Result := (ModelToListen.CurrentElement <> nil);
//#UC END# *57EB6D020381_57CEBC210073_impl*
end;//TmsmShowInNavigator.GetEnabled

procedure TmsmShowInNavigator.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57CEBC210073_var*
//#UC END# *57EBADA9033E_57CEBC210073_var*
begin
//#UC START# *57EBADA9033E_57CEBC210073_impl*
 inherited;
 theParams.rImageIndex := 30;
//#UC END# *57EBADA9033E_57CEBC210073_impl*
end;//TmsmShowInNavigator.InitOperationParams

end.
