unit ImageEnPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\ImageEnPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ImageEnPack" MUID: (52E20EB3004D)

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
