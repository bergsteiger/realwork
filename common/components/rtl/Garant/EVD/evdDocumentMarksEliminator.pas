unit evdDocumentMarksEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evdDocumentMarksEliminator.pas"
// Начат: 06.09.2011 20:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdDocumentMarksEliminator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2Base,
  l3Variant
  ;

type
 TevdDocumentMarksEliminator = class(TevdLeafParaFilter)
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
     {* Определяет нужно ли фильтровать переданный абзац }
 end;//TevdDocumentMarksEliminator

implementation

uses
  DocSubLayer_Const,
  evdTypes,
  k2Tags
  ;

// start class TevdDocumentMarksEliminator

function TevdDocumentMarksEliminator.ParaTypeForFiltering: Tk2Type;
//#UC START# *49E488070386_4E664CB30360_var*
//#UC END# *49E488070386_4E664CB30360_var*
begin
//#UC START# *49E488070386_4E664CB30360_impl*
 Result := k2_typDocSubLayer;
//#UC END# *49E488070386_4E664CB30360_impl*
end;//TevdDocumentMarksEliminator.ParaTypeForFiltering

function TevdDocumentMarksEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
//#UC START# *49E48829016F_4E664CB30360_var*
//#UC END# *49E48829016F_4E664CB30360_var*
begin
//#UC START# *49E48829016F_4E664CB30360_impl*
 Result := aLeaf.IntA[k2_tiHandle] <> Ord(ev_sbtMark);
//#UC END# *49E48829016F_4E664CB30360_impl*
end;//TevdDocumentMarksEliminator.NeedWritePara

end.