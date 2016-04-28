unit kwCommonArchiWords;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwCommonArchiWords.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "kwCommonArchiWords" MUID: (4F619597030C)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwMainFormFindDocuments
 , kwBaseExport
 , kwBaseRelCorrecter
 , kwPreview
 , kwSearchWinSaveDocumentList
 , kwMainFormClearHistory
 , kwEditorTextSaveAs
 , kwClearTemplateStorage
 , kwMainFormFormClose
 , kwDialogsLockDocumentGetSkipMode
 , kwDialogsLockDocumentSetSkipMode
 , AttributeExplorerWordsPack
 , kwClearConfig
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
