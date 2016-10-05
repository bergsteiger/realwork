unit msmGenerateElement;

// Модуль: "w:\common\components\gui\Garant\msm\msmGenerateElement.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmGenerateElement" MUID: (57DFE4880208)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeOperation
 , msmOperations
;

type
 TmsmGenerateElement = class(TmsmListLikeOperation)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
   procedure InitOperationParams(var theParams: TmsmOperationParams); override;
 end;//TmsmGenerateElement

implementation

uses
 l3ImplUses
 , msmModelElementMethodCaller
 //#UC START# *57DFE4880208impl_uses*
 //, msmBaseModelElement
 , msmChangedElements
 //#UC END# *57DFE4880208impl_uses*
;

procedure TmsmGenerateElement.DoDoIt;
//#UC START# *57CEB1F602D1_57DFE4880208_var*
//#UC END# *57CEB1F602D1_57DFE4880208_var*
begin
//#UC START# *57CEB1F602D1_57DFE4880208_impl*
 Assert(Model.CurrentElement <> nil);
 TmsmChangedElements.Instance.Save;
 Model.CurrentElement.Call([], 'GenerateElement');
 //TmsmModelElementMethodCaller.RawCall(Model.CurrentElement.MainWord, 'GenerateElement');
//#UC END# *57CEB1F602D1_57DFE4880208_impl*
end;//TmsmGenerateElement.DoDoIt

function TmsmGenerateElement.GetEnabled: Boolean;
//#UC START# *57EB6D020381_57DFE4880208_var*
//#UC END# *57EB6D020381_57DFE4880208_var*
begin
//#UC START# *57EB6D020381_57DFE4880208_impl*
 Result := (Model.CurrentElement <> nil);
//#UC END# *57EB6D020381_57DFE4880208_impl*
end;//TmsmGenerateElement.GetEnabled

procedure TmsmGenerateElement.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57DFE4880208_var*
//#UC END# *57EBADA9033E_57DFE4880208_var*
begin
//#UC START# *57EBADA9033E_57DFE4880208_impl*
 inherited;
 theParams.rImageIndex := 111;
//#UC END# *57EBADA9033E_57DFE4880208_impl*
end;//TmsmGenerateElement.InitOperationParams

end.
