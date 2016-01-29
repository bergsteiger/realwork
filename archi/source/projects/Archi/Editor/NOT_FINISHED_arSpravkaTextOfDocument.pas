unit NOT_FINISHED_arSpravkaTextOfDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editor"
// Модуль: "w:/archi/source/projects/Archi/Editor/NOT_FINISHED_arSpravkaTextOfDocument.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi::Editor::DocIntf::TarSpravkaTextOfDocument
//
// ТextSource для справки.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  arTextOfDocument,
  nevTools
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}
type
 TarSpravkaTextOfDocument = class(TarTextOfDocument)
  {* ТextSource для справки. }
 protected
 // overridden protected methods
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TarSpravkaTextOfDocument
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  arSpravkaDocumentContainer
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}

// start class TarSpravkaTextOfDocument

function TarSpravkaTextOfDocument.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_4F9502130133_var*
//#UC END# *482D9A030221_4F9502130133_var*
begin
//#UC START# *482D9A030221_4F9502130133_impl*
 !!! Needs to be implemented !!!
//#UC END# *482D9A030221_4F9502130133_impl*
end;//TarSpravkaTextOfDocument.DoMakeDocumentContainer

{$IfEnd} //AppClientSide

end.