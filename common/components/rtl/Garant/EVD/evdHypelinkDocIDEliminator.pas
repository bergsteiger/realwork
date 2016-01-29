unit evdHypelinkDocIDEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/evdHypelinkDocIDEliminator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdHypelinkDocIDEliminator
//
// Обнуляет DocID у ссылок. Создан для тестов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2TagFilter,
  l3Variant
  ;

type
 TevdHypelinkDocIDEliminator = class(Tk2TagFilter)
  {* Обнуляет DocID у ссылок. Создан для тестов. }
 protected
 // overridden protected methods
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevdHypelinkDocIDEliminator

implementation

uses
  k2Tags,
  Address_Const
  ;

// start class TevdHypelinkDocIDEliminator

procedure TevdHypelinkDocIDEliminator.DoAddAtomEx(AtomIndex: Integer;
  const Value: Ik2Variant);
//#UC START# *4A2D1634025B_4F33BAE302FA_var*
//#UC END# *4A2D1634025B_4F33BAE302FA_var*
begin
//#UC START# *4A2D1634025B_4F33BAE302FA_impl*
 if AtomIndex = k2_tiInternalHandle then Exit;
 if CurrentType.IsKindOf(k2_typAddress) and (AtomIndex = k2_tiDocID) then
  Exit;
 inherited;
//#UC END# *4A2D1634025B_4F33BAE302FA_impl*
end;//TevdHypelinkDocIDEliminator.DoAddAtomEx

end.