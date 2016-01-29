unit vcmEntitiesDefIterator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmEntitiesDefIterator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Implementation::TvcmEntitiesDefIterator
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
  vcmEntitiesDefList,
  vcmBase
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _ItemType_ = IvcmEntityDef;
 _ListType_ = TvcmEntitiesDefList;
 {$Include ..\implementation\vcmIterator.imp.pas}
 TvcmEntitiesDefIterator = class(_vcmIterator_, IvcmEntitiesDefIterator)
 protected
 // realized methods
   function Get_Next: IvcmEntityDef;
 end;//TvcmEntitiesDefIterator
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}

{$Include ..\implementation\vcmIterator.imp.pas}

// start class TvcmEntitiesDefIterator

function TvcmEntitiesDefIterator.Get_Next: IvcmEntityDef;
//#UC START# *49956DB300D6_5582C49B01E9get_var*
//#UC END# *49956DB300D6_5582C49B01E9get_var*
begin
//#UC START# *49956DB300D6_5582C49B01E9get_impl*
 Result := GetNext;
//#UC END# *49956DB300D6_5582C49B01E9get_impl*
end;//TvcmEntitiesDefIterator.Get_Next

{$IfEnd} //not NoVCM

end.