unit vcmFormSetFormsCollection;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollection.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmFormSetFormsCollection" MUID: (4FFC32B60282)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmFormSetFormsCollectionPrim
 , vcmFormSetFormsCollectionItemPrim
 , vcmInterfaces
;

type
 TvcmFormSetFormsCollection = class(TvcmFormSetFormsCollectionPrim)
  public
   function FindItemByForm(const aForm: IvcmEntityForm): TvcmFormSetFormsCollectionItemPrim;
    {* ищет элемент коллекции соответствующий форме. }
 end;//TvcmFormSetFormsCollection
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmFormSetFormsCollectionItem
 //#UC START# *4FFC32B60282impl_uses*
 //#UC END# *4FFC32B60282impl_uses*
;

function TvcmFormSetFormsCollection.FindItemByForm(const aForm: IvcmEntityForm): TvcmFormSetFormsCollectionItemPrim;
 {* ищет элемент коллекции соответствующий форме. }
//#UC START# *511CF09301D0_4FFC32B60282_var*
var
 l_Index : Integer;
//#UC END# *511CF09301D0_4FFC32B60282_var*
begin
//#UC START# *511CF09301D0_4FFC32B60282_impl*
 Result := nil;
 for l_Index := 0 to Pred(Count) do
  if TvcmFormSetFormsCollectionItem(Items[l_Index]).IsSame(aForm) then
  begin
   Result := Items[l_Index];
   Break;
  end;//if TvcmFormSetFormsCollectionItem(Items[
//#UC END# *511CF09301D0_4FFC32B60282_impl*
end;//TvcmFormSetFormsCollection.FindItemByForm
{$IfEnd} // NOT Defined(NoVCM)

end.
