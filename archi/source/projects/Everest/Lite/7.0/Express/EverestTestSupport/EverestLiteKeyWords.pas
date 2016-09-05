unit EverestLiteKeyWords;

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\EverestLiteKeyWords.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "EverestLiteKeyWords" MUID: (512D9BE30122)

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
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *512D9BE30122impl_uses*
 //#UC END# *512D9BE30122impl_uses*
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
