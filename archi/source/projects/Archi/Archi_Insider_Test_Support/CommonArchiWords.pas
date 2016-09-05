unit CommonArchiWords;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\CommonArchiWords.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "CommonArchiWords" MUID: (4E4A1982012A)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

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
 //#UC START# *4E4A1982012Aimpl_uses*
 //#UC END# *4E4A1982012Aimpl_uses*
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
