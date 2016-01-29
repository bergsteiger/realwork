unit vcmFormSetFormsCollection;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmFormSetFormsCollection.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::FormSets::TvcmFormSetFormsCollection
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  vcmFormSetFormsCollectionItemPrim,
  vcmFormSetFormsCollectionPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmFormSetFormsCollection = class(TvcmFormSetFormsCollectionPrim)
 public
 // public methods
   function FindItemByForm(const aForm: IvcmEntityForm): TvcmFormSetFormsCollectionItemPrim;
     {* ищет элемент коллекции соответствующий форме. }
 end;//TvcmFormSetFormsCollection
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  vcmFormSetFormsCollectionItem
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmFormSetFormsCollection

function TvcmFormSetFormsCollection.FindItemByForm(const aForm: IvcmEntityForm): TvcmFormSetFormsCollectionItemPrim;
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

{$IfEnd} //not NoVCM

end.