unit evdScriptHyperlinkEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evdScriptHyperlinkEliminator.pas"
// Начат: 10.06.2012 18:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevdScriptHyperlinkEliminator
//
// Фильтр, отрезающий ссылки на скрипты
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdHyperlinkEliminator,
  l3Variant
  ;

type
 TevdScriptHyperlinkEliminator = class(TevdHyperlinkEliminator)
  {* Фильтр, отрезающий ссылки на скрипты }
 protected
 // overridden protected methods
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
     {* Определяет нужно ли фильтровать переданный абзац }
 end;//TevdScriptHyperlinkEliminator

implementation

uses
  k2Tags,
  l3String,
  evdTypes
  ;

// start class TevdScriptHyperlinkEliminator

function TevdScriptHyperlinkEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
//#UC START# *49E48829016F_4F352A840264_var*
//#UC END# *49E48829016F_4F352A840264_var*
begin
//#UC START# *49E48829016F_4F352A840264_impl*
 Result := True;
 if Result then
  if l3Starts('script:', aLeaf.PCharLenA[k2_tiURL]) OR
     ((aLeaf.ChildrenCount > 0) AND
      (aLeaf.Child[0].IntA[k2_tiType] = CI_SCRIPT)) then
   Result := false
  else
   Result := true;
//#UC END# *49E48829016F_4F352A840264_impl*
end;//TevdScriptHyperlinkEliminator.NeedWritePara

end.