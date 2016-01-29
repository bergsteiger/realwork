unit vcmUserTypesIterator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmUserTypesIterator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Implementation::TvcmUserTypesIterator
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
  vcmUserTypeDefList,
  vcmBase
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _ListType_ = TvcmUserTypeDefList;
 _ItemType_ = IvcmUserTypeDef;
 {$Include ..\implementation\vcmIterator.imp.pas}
 TvcmUserTypesIterator = class(_vcmIterator_, IvcmUserTypesIterator)
 protected
 // realized methods
   function Next: IvcmUserTypeDef;
 public
 // public methods
   class function Make(aList: TvcmUserTypeDefList): IvcmUserTypesIterator; reintroduce;
 end;//TvcmUserTypesIterator
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}

{$Include ..\implementation\vcmIterator.imp.pas}

// start class TvcmUserTypesIterator

class function TvcmUserTypesIterator.Make(aList: TvcmUserTypeDefList): IvcmUserTypesIterator;
var
 l_Inst : TvcmUserTypesIterator;
begin
 l_Inst := Create(aList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmUserTypesIterator.Next: IvcmUserTypeDef;
//#UC START# *499560C601FD_5582C3AD0167_var*
//#UC END# *499560C601FD_5582C3AD0167_var*
begin
//#UC START# *499560C601FD_5582C3AD0167_impl*
 Result := GetNext;
//#UC END# *499560C601FD_5582C3AD0167_impl*
end;//TvcmUserTypesIterator.Next

{$IfEnd} //not NoVCM

end.