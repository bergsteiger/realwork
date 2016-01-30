unit CommonArchiWords;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\CommonArchiWords.pas"
// Стереотип: "UtilityPack"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwArchiNewDocument
 , kwClearDataBase
 , kwArchiCloseDocument
 , kwArchiOpenDocument
 , kwArchiNewDocumentPrim
 , kwGetActiveEditorPageName
 , kwArchiNewEmptyDocument
 , kwSetActivePage
 , kwShowMailMessage
 , archiDocEditorWindowWordsPack
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
