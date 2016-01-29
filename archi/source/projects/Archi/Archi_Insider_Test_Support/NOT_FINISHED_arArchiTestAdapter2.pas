unit NOT_FINISHED_arArchiTestAdapter2;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/NOT_FINISHED_arArchiTestAdapter2.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::arArchiTestAdapter2
//
// Времянка для подключения модулей не на модели, т.к. даже при частичном переносе требуется их
// перемещение. А это мешает.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
procedure ArMakeChangeDoc;
procedure ArInsertDocChanges;
procedure ArIniRecSetZoom(aZoom: Integer);
function ArIniRecGetZoom: Integer;
procedure ArShowMailWindow(aIndex: Integer);
procedure AcEndDragAndDrop;
procedure AcSetExpiredStyle(anID: Integer);
procedure AcCorrectRelatedText(const aFileName: AnsiString);
procedure AcMakePreview;
procedure AcSaveDocAs(const aFileName: AnsiString);
procedure AcSaveTextAs(const aFileName: AnsiString);
procedure ArClearTemplateStorage;
procedure AcMainFormFormClose;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// unit methods

procedure ArMakeChangeDoc;
//#UC START# *4E4B6340031F_4E4B5F29031C_var*
//#UC END# *4E4B6340031F_4E4B5F29031C_var*
begin
//#UC START# *4E4B6340031F_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E4B6340031F_4E4B5F29031C_impl*
end;//ArMakeChangeDoc

procedure ArInsertDocChanges;
//#UC START# *4E4B637A01C7_4E4B5F29031C_var*
//#UC END# *4E4B637A01C7_4E4B5F29031C_var*
begin
//#UC START# *4E4B637A01C7_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E4B637A01C7_4E4B5F29031C_impl*
end;//ArInsertDocChanges

procedure ArIniRecSetZoom(aZoom: Integer);
//#UC START# *4E83092C0076_4E4B5F29031C_var*
//#UC END# *4E83092C0076_4E4B5F29031C_var*
begin
//#UC START# *4E83092C0076_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E83092C0076_4E4B5F29031C_impl*
end;//ArIniRecSetZoom

function ArIniRecGetZoom: Integer;
//#UC START# *4E83095902EB_4E4B5F29031C_var*
//#UC END# *4E83095902EB_4E4B5F29031C_var*
begin
//#UC START# *4E83095902EB_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E83095902EB_4E4B5F29031C_impl*
end;//ArIniRecGetZoom

procedure ArShowMailWindow(aIndex: Integer);
//#UC START# *4F0C276F03DC_4E4B5F29031C_var*
//#UC END# *4F0C276F03DC_4E4B5F29031C_var*
begin
//#UC START# *4F0C276F03DC_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F0C276F03DC_4E4B5F29031C_impl*
end;//ArShowMailWindow

procedure AcEndDragAndDrop;
//#UC START# *4F0C37850322_4E4B5F29031C_var*
var
 l_Message: TMessage;
//#UC END# *4F0C37850322_4E4B5F29031C_var*
begin
//#UC START# *4F0C37850322_4E4B5F29031C_impl*
{$IFDEF InsiderTest}
 with (aControl as TCustomEditorWindow) do
 begin
  DDSupport.DragDataType := arHyperLinkID;
  DDSupport.AnswerData := @DDHLink;
  DDHLink.Family := DocFamily;
  DDHLink.Doc := CurDocument.DocID;
  WMDropAccepted(l_Message);
  DDSupport.Stop(True);
 end; // with (aControl as TCustomEditorWindow) do
{$ENDIF InsiderTest}
//#UC END# *4F0C37850322_4E4B5F29031C_impl*
end;//AcEndDragAndDrop

procedure AcSetExpiredStyle(anID: Integer);
//#UC START# *4F22AE6C0165_4E4B5F29031C_var*
//#UC END# *4F22AE6C0165_4E4B5F29031C_var*
begin
//#UC START# *4F22AE6C0165_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F22AE6C0165_4E4B5F29031C_impl*
end;//AcSetExpiredStyle

procedure AcCorrectRelatedText(const aFileName: AnsiString);
//#UC START# *526E5BAA00E9_4E4B5F29031C_var*
//#UC END# *526E5BAA00E9_4E4B5F29031C_var*
begin
//#UC START# *526E5BAA00E9_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *526E5BAA00E9_4E4B5F29031C_impl*
end;//AcCorrectRelatedText

procedure AcMakePreview;
//#UC START# *530B2FD003B4_4E4B5F29031C_var*
//#UC END# *530B2FD003B4_4E4B5F29031C_var*
begin
//#UC START# *530B2FD003B4_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *530B2FD003B4_4E4B5F29031C_impl*
end;//AcMakePreview

procedure AcSaveDocAs(const aFileName: AnsiString);
//#UC START# *537075A70219_4E4B5F29031C_var*
//#UC END# *537075A70219_4E4B5F29031C_var*
begin
//#UC START# *537075A70219_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *537075A70219_4E4B5F29031C_impl*
end;//AcSaveDocAs

procedure AcSaveTextAs(const aFileName: AnsiString);
//#UC START# *537D965101BA_4E4B5F29031C_var*
//#UC END# *537D965101BA_4E4B5F29031C_var*
begin
//#UC START# *537D965101BA_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *537D965101BA_4E4B5F29031C_impl*
end;//AcSaveTextAs

procedure ArClearTemplateStorage;
//#UC START# *53B648700029_4E4B5F29031C_var*
//#UC END# *53B648700029_4E4B5F29031C_var*
begin
//#UC START# *53B648700029_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B648700029_4E4B5F29031C_impl*
end;//ArClearTemplateStorage

procedure AcMainFormFormClose;
//#UC START# *53EB4DC6007B_4E4B5F29031C_var*
//#UC END# *53EB4DC6007B_4E4B5F29031C_var*
begin
//#UC START# *53EB4DC6007B_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *53EB4DC6007B_4E4B5F29031C_impl*
end;//AcMainFormFormClose
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.