unit vcmOperationsDefIterator;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmOperationsDefIterator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmOperationsDefIterator" MUID: (5582C4210160)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
 , vcmOperationDefList
 , vcmBase
;

type
 _ItemType_ = IvcmOperationDef;
 _ListType_ = TvcmOperationDefList;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmIterator.imp.pas}
 TvcmOperationsDefIterator = class(_vcmIterator_, IvcmOperationsDefIterator)
  protected
   function Get_Next: IvcmOperationDef;
 end;//TvcmOperationsDefIterator
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmIterator.imp.pas}

function TvcmOperationsDefIterator.Get_Next: IvcmOperationDef;
//#UC START# *4995645B02C7_5582C4210160get_var*
//#UC END# *4995645B02C7_5582C4210160get_var*
begin
//#UC START# *4995645B02C7_5582C4210160get_impl*
 Result := GetNext;
//#UC END# *4995645B02C7_5582C4210160get_impl*
end;//TvcmOperationsDefIterator.Get_Next
{$IfEnd} // NOT Defined(NoVCM)

end.
