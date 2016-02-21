unit evSchemaWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\evSchemaWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwRegisterSchema
 , kwStyleTableSaveToFile
 , kwStyleTableChanging
 , kwStyleTableChanged
 , kwEvdBin2EvdTxt
 , kwCFHTML
 , kwCFXML
 , kwCFEVEREST
 , kwCFRTF
 , kwCFEVERESTBIN
 , kwCFPDF
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
