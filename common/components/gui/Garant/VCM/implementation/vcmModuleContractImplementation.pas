unit vcmModuleContractImplementation;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmModuleContractImplementation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmModuleContractImplementation" MUID: (57A0BF7D02BD)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
;

type
 TvcmModuleContractImplementation = class(Tl3ProtoObject)
  public
   class function DefaultContainer: IvcmContainer;
   class function CheckContainer(const aCont: IvcmContainer): IvcmContainer;
 end;//TvcmModuleContractImplementation
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmBase
 //#UC START# *57A0BF7D02BDimpl_uses*
 //#UC END# *57A0BF7D02BDimpl_uses*
;

class function TvcmModuleContractImplementation.DefaultContainer: IvcmContainer;
//#UC START# *57A0BFB00067_57A0BF7D02BD_var*
//#UC END# *57A0BFB00067_57A0BF7D02BD_var*
begin
//#UC START# *57A0BFB00067_57A0BF7D02BD_impl*
 Result := vcmDispatcher.FormDispatcher.CurrentMainForm.AsContainer;
//#UC END# *57A0BFB00067_57A0BF7D02BD_impl*
end;//TvcmModuleContractImplementation.DefaultContainer

class function TvcmModuleContractImplementation.CheckContainer(const aCont: IvcmContainer): IvcmContainer;
//#UC START# *57A0C00002B5_57A0BF7D02BD_var*
//#UC END# *57A0C00002B5_57A0BF7D02BD_var*
begin
//#UC START# *57A0C00002B5_57A0BF7D02BD_impl*
 if (aCont = nil) then
  Result := DefaultContainer
 else
  Result := aCont;
//#UC END# *57A0C00002B5_57A0BF7D02BD_impl*
end;//TvcmModuleContractImplementation.CheckContainer
{$IfEnd} // NOT Defined(NoVCM)

end.
