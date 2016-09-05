unit SupportKeyWords;

// Модуль: "w:\common\components\rtl\Garant\Keywords4Daily\SupportKeyWords.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "SupportKeyWords" MUID: (509A5D0D0141)

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
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *509A5D0D0141impl_uses*
 //#UC END# *509A5D0D0141impl_uses*
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
