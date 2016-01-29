unit evDocumentEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evDocumentEliminator.pas"
// Начат: 21.07.2011 18:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevDocumentEliminator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2TagFilter
  ;

type
 TevDocumentEliminator = class(Tk2TagFilter)
 protected
 // overridden protected methods
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevDocumentEliminator

implementation

uses
  Document_Const
  ;

// start class TevDocumentEliminator

function TevDocumentEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4E2836190160_var*
//#UC END# *4CA3006302BC_4E2836190160_var*
begin
//#UC START# *4CA3006302BC_4E2836190160_impl*
 Result := not CurrentType.IsKindOf(k2_typDocument);
//#UC END# *4CA3006302BC_4E2836190160_impl*
end;//TevDocumentEliminator.NeedTranslateChildToNext

end.