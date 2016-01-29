unit evdDocumentBookmarksEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evdDocumentBookmarksEliminator.pas"
// Начат: 07.09.2011 15:09
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdDocumentBookmarksEliminator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  evdDocumentMarksEliminator,
  l3Variant
  ;

type
 TevdDocumentBookmarksEliminator = class(TevdDocumentMarksEliminator)
 protected
 // overridden protected methods
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
     {* Определяет нужно ли фильтровать переданный абзац }
 end;//TevdDocumentBookmarksEliminator

implementation

uses
  evdTypes,
  k2Tags
  ;

// start class TevdDocumentBookmarksEliminator

function TevdDocumentBookmarksEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
//#UC START# *49E48829016F_4E6750EF020D_var*
//#UC END# *49E48829016F_4E6750EF020D_var*
begin
//#UC START# *49E48829016F_4E6750EF020D_impl*
 Result := aLeaf.IntA[k2_tiHandle] <> Ord(ev_sbtBookmark);
//#UC END# *49E48829016F_4E6750EF020D_impl*
end;//TevdDocumentBookmarksEliminator.NeedWritePara

end.