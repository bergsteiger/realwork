unit vcmEntitiesDefIterator;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmEntitiesDefIterator.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmInterfaces
 , vcmEntitiesDefList
 , vcmBase
;

type
 _ItemType_ = IvcmEntityDef;
 _ListType_ = TvcmEntitiesDefList;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmIterator.imp.pas}
 TvcmEntitiesDefIterator = class(_vcmIterator_, IvcmEntitiesDefIterator)
  protected
   function Get_Next: IvcmEntityDef;
 end;//TvcmEntitiesDefIterator
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmIterator.imp.pas}

function TvcmEntitiesDefIterator.Get_Next: IvcmEntityDef;
//#UC START# *49956DB300D6_5582C49B01E9get_var*
//#UC END# *49956DB300D6_5582C49B01E9get_var*
begin
//#UC START# *49956DB300D6_5582C49B01E9get_impl*
 Result := GetNext;
//#UC END# *49956DB300D6_5582C49B01E9get_impl*
end;//TvcmEntitiesDefIterator.Get_Next
{$IfEnd} // NOT Defined(NoVCM)

end.
