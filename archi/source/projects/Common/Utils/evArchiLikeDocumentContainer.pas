unit evArchiLikeDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Utils"
// Модуль: "w:/archi/source/projects/Common/Utils/evArchiLikeDocumentContainer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$common::Utils::EditorCommon::TevArchiLikeDocumentContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
  nevPrintableDocumentContainer
  ;

type
 TevArchiLikeDocumentContainer = class(TnevPrintableDocumentContainer)
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 end;//TevArchiLikeDocumentContainer

implementation

uses
  l3Base
  ;

// start class TevArchiLikeDocumentContainer

procedure TevArchiLikeDocumentContainer.Cleanup;
//#UC START# *479731C50290_50F8F97E0292_var*
//#UC END# *479731C50290_50F8F97E0292_var*
begin
//#UC START# *479731C50290_50F8F97E0292_impl*
 inherited;
//#UC END# *479731C50290_50F8F97E0292_impl*
end;//TevArchiLikeDocumentContainer.Cleanup

end.