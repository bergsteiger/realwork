unit evdChildrenCountEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evdChildrenCountEliminator.pas"
// Начат: 29.09.2011 15:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdChildrenCountEliminator
//
// Выкидавает ChildrenCount из потока генерации, чтобы не распределялась лишняя память при
// буферизации на проходе
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
 TevdChildrenCountEliminator = class(Tk2TagFilter)
  {* Выкидавает ChildrenCount из потока генерации, чтобы не распределялась лишняя память при буферизации на проходе }
 protected
 // overridden protected methods
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevdChildrenCountEliminator

implementation

uses
  k2Tags
  ;

// start class TevdChildrenCountEliminator

procedure TevdChildrenCountEliminator.DoAddAtomEx(AtomIndex: Integer;
  const Value: Ik2Variant);
//#UC START# *4A2D1634025B_4E84542E03B5_var*
//#UC END# *4A2D1634025B_4E84542E03B5_var*
begin
//#UC START# *4A2D1634025B_4E84542E03B5_impl*
 if (AtomIndex = k2_tiChildren) then
  Exit;
 inherited;
//#UC END# *4A2D1634025B_4E84542E03B5_impl*
end;//TevdChildrenCountEliminator.DoAddAtomEx

end.