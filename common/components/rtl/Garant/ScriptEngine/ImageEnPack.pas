unit ImageEnPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ImageEnPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ImageEnPack" MUID: (52E20EB3004D)

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
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

end.
