unit NOT_FINISHED_arArchiTestAdapter2;
 {* Времянка для подключения модулей не на модели, т.к. даже при частичном переносе требуется их перемещение. А это мешает. }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\NOT_FINISHED_arArchiTestAdapter2.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "arArchiTestAdapter2" MUID: (4E4B5F29031C)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;

procedure arMakeChangeDoc;
procedure arInsertDocChanges;
procedure arIniRecSetZoom(aZoom: Integer);
function arIniRecGetZoom: Integer;
procedure arShowMailWindow(aIndex: Integer);
procedure acEndDragAndDrop;
procedure acSetExpiredStyle(anID: Integer);
procedure acCorrectRelatedText(const aFileName: AnsiString);
procedure acMakePreview;
procedure acSaveDocAs(const aFileName: AnsiString);
procedure acSaveTextAs(const aFileName: AnsiString);
procedure arClearTemplateStorage;
procedure acMainFormFormClose;
procedure acClearConfig;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *4E4B5F29031Cimpl_uses*
 //#UC END# *4E4B5F29031Cimpl_uses*
;

procedure arMakeChangeDoc;
//#UC START# *4E4B6340031F_4E4B5F29031C_var*
//#UC END# *4E4B6340031F_4E4B5F29031C_var*
begin
//#UC START# *4E4B6340031F_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E4B6340031F_4E4B5F29031C_impl*
end;//arMakeChangeDoc

procedure arInsertDocChanges;
//#UC START# *4E4B637A01C7_4E4B5F29031C_var*
//#UC END# *4E4B637A01C7_4E4B5F29031C_var*
begin
//#UC START# *4E4B637A01C7_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E4B637A01C7_4E4B5F29031C_impl*
end;//arInsertDocChanges

procedure arIniRecSetZoom(aZoom: Integer);
//#UC START# *4E83092C0076_4E4B5F29031C_var*
//#UC END# *4E83092C0076_4E4B5F29031C_var*
begin
//#UC START# *4E83092C0076_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E83092C0076_4E4B5F29031C_impl*
end;//arIniRecSetZoom

function arIniRecGetZoom: Integer;
//#UC START# *4E83095902EB_4E4B5F29031C_var*
//#UC END# *4E83095902EB_4E4B5F29031C_var*
begin
//#UC START# *4E83095902EB_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E83095902EB_4E4B5F29031C_impl*
end;//arIniRecGetZoom

procedure arShowMailWindow(aIndex: Integer);
//#UC START# *4F0C276F03DC_4E4B5F29031C_var*
//#UC END# *4F0C276F03DC_4E4B5F29031C_var*
begin
//#UC START# *4F0C276F03DC_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F0C276F03DC_4E4B5F29031C_impl*
end;//arShowMailWindow

procedure acEndDragAndDrop;
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
end;//acEndDragAndDrop

procedure acSetExpiredStyle(anID: Integer);
//#UC START# *4F22AE6C0165_4E4B5F29031C_var*
//#UC END# *4F22AE6C0165_4E4B5F29031C_var*
begin
//#UC START# *4F22AE6C0165_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F22AE6C0165_4E4B5F29031C_impl*
end;//acSetExpiredStyle

procedure acCorrectRelatedText(const aFileName: AnsiString);
//#UC START# *526E5BAA00E9_4E4B5F29031C_var*
//#UC END# *526E5BAA00E9_4E4B5F29031C_var*
begin
//#UC START# *526E5BAA00E9_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *526E5BAA00E9_4E4B5F29031C_impl*
end;//acCorrectRelatedText

procedure acMakePreview;
//#UC START# *530B2FD003B4_4E4B5F29031C_var*
//#UC END# *530B2FD003B4_4E4B5F29031C_var*
begin
//#UC START# *530B2FD003B4_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *530B2FD003B4_4E4B5F29031C_impl*
end;//acMakePreview

procedure acSaveDocAs(const aFileName: AnsiString);
//#UC START# *537075A70219_4E4B5F29031C_var*
//#UC END# *537075A70219_4E4B5F29031C_var*
begin
//#UC START# *537075A70219_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *537075A70219_4E4B5F29031C_impl*
end;//acSaveDocAs

procedure acSaveTextAs(const aFileName: AnsiString);
//#UC START# *537D965101BA_4E4B5F29031C_var*
//#UC END# *537D965101BA_4E4B5F29031C_var*
begin
//#UC START# *537D965101BA_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *537D965101BA_4E4B5F29031C_impl*
end;//acSaveTextAs

procedure arClearTemplateStorage;
//#UC START# *53B648700029_4E4B5F29031C_var*
//#UC END# *53B648700029_4E4B5F29031C_var*
begin
//#UC START# *53B648700029_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B648700029_4E4B5F29031C_impl*
end;//arClearTemplateStorage

procedure acMainFormFormClose;
//#UC START# *53EB4DC6007B_4E4B5F29031C_var*
//#UC END# *53EB4DC6007B_4E4B5F29031C_var*
begin
//#UC START# *53EB4DC6007B_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *53EB4DC6007B_4E4B5F29031C_impl*
end;//acMainFormFormClose

procedure acClearConfig;
//#UC START# *56A09EF601E1_4E4B5F29031C_var*
//#UC END# *56A09EF601E1_4E4B5F29031C_var*
begin
//#UC START# *56A09EF601E1_4E4B5F29031C_impl*
 !!! Needs to be implemented !!!
//#UC END# *56A09EF601E1_4E4B5F29031C_impl*
end;//acClearConfig
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
