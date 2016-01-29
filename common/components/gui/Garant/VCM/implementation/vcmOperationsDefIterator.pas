unit vcmOperationsDefIterator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmOperationsDefIterator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Implementation::TvcmOperationsDefIterator
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
  vcmUserControls,
  vcmOperationDefList,
  vcmBase
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _ItemType_ = IvcmOperationDef;
 _ListType_ = TvcmOperationDefList;
 {$Include ..\implementation\vcmIterator.imp.pas}
 TvcmOperationsDefIterator = class(_vcmIterator_, IvcmOperationsDefIterator)
 protected
 // realized methods
   function Get_Next: IvcmOperationDef;
 end;//TvcmOperationsDefIterator
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}

{$Include ..\implementation\vcmIterator.imp.pas}

// start class TvcmOperationsDefIterator

function TvcmOperationsDefIterator.Get_Next: IvcmOperationDef;
//#UC START# *4995645B02C7_5582C4210160get_var*
//#UC END# *4995645B02C7_5582C4210160get_var*
begin
//#UC START# *4995645B02C7_5582C4210160get_impl*
 Result := GetNext;
//#UC END# *4995645B02C7_5582C4210160get_impl*
end;//TvcmOperationsDefIterator.Get_Next

{$IfEnd} //not NoVCM

end.