unit EverestLiteKeyWords;

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\EverestLiteKeyWords.pas"
// Стереотип: "ScriptKeywordsPack"

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
 , kwCreate
 , kwOpen
 , kwCloseActiveWindow
 , kwSaveWithOtherExtention
 , kwOpenWith
 , kwIsPreviewInProgress
 , archiEditorWindowWordsPack
 , tfwScriptingTypes
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
