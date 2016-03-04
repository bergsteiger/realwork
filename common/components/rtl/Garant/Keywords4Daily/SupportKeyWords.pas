unit SupportKeyWords;

// Модуль: "w:\common\components\rtl\Garant\Keywords4Daily\SupportKeyWords.pas"
// Стереотип: "ScriptKeywordsPack"

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , kwLoadFromFile
 , kwSetFontSize
 , kwGetFontSize
 , tfwScriptingTypes
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
