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
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *52E20EB3004Dimpl_uses*
 //#UC END# *52E20EB3004Dimpl_uses*
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

end.
