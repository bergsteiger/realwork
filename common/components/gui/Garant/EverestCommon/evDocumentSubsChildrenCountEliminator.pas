unit evDocumentSubsChildrenCountEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/EverestCommon/evDocumentSubsChildrenCountEliminator.pas"
// Начат: 19.09.2011 18:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EverestCommon::Generators::TevDocumentSubsChildrenCountEliminator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  k2TagFilter,
  l3Variant
  ;

type
 TevDocumentSubsChildrenCountEliminator = class(Tk2TagFilter)
 protected
 // overridden protected methods
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevDocumentSubsChildrenCountEliminator

implementation

uses
  Document_Const,
  k2Tags
  ;

// start class TevDocumentSubsChildrenCountEliminator

procedure TevDocumentSubsChildrenCountEliminator.DoAddAtomEx(AtomIndex: Integer;
  const Value: Ik2Variant);
//#UC START# *4A2D1634025B_4E7754BD01BA_var*
//#UC END# *4A2D1634025B_4E7754BD01BA_var*
begin
//#UC START# *4A2D1634025B_4E7754BD01BA_impl*
 if (AtomIndex = k2_tiChildren) then
  if CurrentType.IsKindOf(k2_typDocument_Subs) then
   Exit;
 inherited;
//#UC END# *4A2D1634025B_4E7754BD01BA_impl*
end;//TevDocumentSubsChildrenCountEliminator.DoAddAtomEx

end.