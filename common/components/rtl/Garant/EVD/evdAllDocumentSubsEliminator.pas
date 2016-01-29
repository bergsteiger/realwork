unit evdAllDocumentSubsEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evdAllDocumentSubsEliminator.pas"
// Начат: 29.09.2011 17:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdAllDocumentSubsEliminator
//
// Фильтр, выкидывающий ВСЕ сабы документа из обратного индекса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2TagFilter
  ;

type
 TevdAllDocumentSubsEliminator = class(Tk2TagFilter)
  {* Фильтр, выкидывающий ВСЕ сабы документа из обратного индекса }
 protected
 // overridden protected methods
   function NeedTranslateChildToNextPrim(anOpenMode: Tk2TagFilterOpenMode): Boolean; override;
 end;//TevdAllDocumentSubsEliminator

implementation

uses
  DocSubLayer_Const,
  DocumentSub_Const
  ;

// start class TevdAllDocumentSubsEliminator

function TevdAllDocumentSubsEliminator.NeedTranslateChildToNextPrim(anOpenMode: Tk2TagFilterOpenMode): Boolean;
//#UC START# *4E15CBD5018B_4E8478090254_var*
//#UC END# *4E15CBD5018B_4E8478090254_var*
begin
//#UC START# *4E15CBD5018B_4E8478090254_impl*
 Result := not CurrentType.IsKindOf(k2_typDocSubLayer) AND
           not CurrentType.IsKindOf(k2_typDocumentSub);
//#UC END# *4E15CBD5018B_4E8478090254_impl*
end;//TevdAllDocumentSubsEliminator.NeedTranslateChildToNextPrim

end.