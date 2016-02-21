unit ImageEnPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ImageEnPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
uses
 l3ImplUses
 , kwImageEnViewerSaveBitmap
 , ImageEnViewRegistrator
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

end.
