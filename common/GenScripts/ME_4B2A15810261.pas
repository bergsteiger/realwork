unit DailyTest_TestLibrary;

// Модуль: "w:\common\components\rtl\Garant\Daily\DailyTest_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "DailyTest" MUID: (4B2A15810261)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DailyTest_Core_TestUnit
 , DailyTest_Write_TestUnit
 , DailyTest_RTF_TestUnit
 , DailyTest_EVD_TestUnit
 , DailyTest_NSRCTests_TestUnit
 , DailyTest_EditorTests_TestUnit
 , DailyTest_GZip_TestUnit
 , DailyTest_7_6_TestUnit
 , DailyTest_NSRC_7_6_TestUnit
 , DailyTest_OutlinerTests_TestUnit
 , DailyTest_7_7_TestUnit
 , DailyTest_Wiki_TestUnit
 , DailyTest_HTML_TestUnit
 , DailyTest_NSRC_7_7_TestUnit
 , DailyTest_7_5_TestUnit
 , DailyTest_ScriptTest_TestUnit
 , DailyTest_7_7_Lulin_TestUnit
 , DailyTest_XML_TestUnit
 , DailyTest_7_8_TestUnit
 , DailyTest_SandBoxTests_TestUnit
 , DailyTest_RegExp_TestUnit
 , DailyTest_AppConfig_TestUnit
 , DailyTest_7_9_TestUnit
 , DailyTest_7_10_TestUnit
 , DailyTest_BadEVD_TestUnit
 , DailyTest_RenderFormula_TestUnit
 , DailyTest_7_11_TestUnit
 , DailyTest_Containers_TestUnit
 , DailyTest_DecorText_TestUnit
 , DailyTest_Unicode_TestUnit
 , DailyTest_7_12_TestUnit
 , DailyTest_Diff_TestUnit
 , DailyTest_CrossSegments_TestUnit
 {$If NOT Defined(NoVCM)}
 , TestFormsTest_TestLibrary
 {$IfEnd} // NOT Defined(NoVCM)
 , Abstract_Tests_TestLibrary
 , ScriptTestLibrary_TestLibrary
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
