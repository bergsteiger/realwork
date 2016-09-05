unit evPersistentDataObjectEx;

// Модуль: "w:\common\components\gui\Garant\Everest\evPersistentDataObjectEx.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevPersistentDataObjectEx" MUID: (48F89F4302E3)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evPersistentDataObject
 , nevTools
;

type
 TevPersistentDataObjectEx = class(TevPersistentDataObject)
  protected
   function Holder: InevObjectHolder;
   function Sharp: Boolean; override;
 end;//TevPersistentDataObjectEx

implementation

uses
 l3ImplUses
 , nevPersistentDocumentContainer
 //#UC START# *48F89F4302E3impl_uses*
 //#UC END# *48F89F4302E3impl_uses*
;

function TevPersistentDataObjectEx.Holder: InevObjectHolder;
//#UC START# *48F89F810133_48F89F4302E3_var*
//#UC END# *48F89F810133_48F89F4302E3_var*
begin
//#UC START# *48F89F810133_48F89F4302E3_impl*
 Result := TnevPersistentDocumentContainer.Make;
//#UC END# *48F89F810133_48F89F4302E3_impl*
end;//TevPersistentDataObjectEx.Holder

function TevPersistentDataObjectEx.Sharp: Boolean;
//#UC START# *48F479680376_48F89F4302E3_var*
//#UC END# *48F479680376_48F89F4302E3_var*
begin
//#UC START# *48F479680376_48F89F4302E3_impl*
 Result := true;
//#UC END# *48F479680376_48F89F4302E3_impl*
end;//TevPersistentDataObjectEx.Sharp

end.
