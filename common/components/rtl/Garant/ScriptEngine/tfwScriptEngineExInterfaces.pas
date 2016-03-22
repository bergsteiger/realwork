unit tfwScriptEngineExInterfaces;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngineExInterfaces.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "tfwScriptEngineExInterfaces" MUID: (55E9A8990116)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryList
 , tfwInitedDictionariesList
 , tfwMainDictionary
 , tfwWordRefList
;

type
 ItfwScriptEngineEx = interface
  ['{E6A6471F-967A-49B5-B0AB-E86FDFC44EB4}']
  function Get_Dictionaries: TtfwDictionaryList;
  function Get_InitedDictionaries: TtfwInitedDictionariesList;
  function Get_MainDictionary: TtfwMainDictionary;
  function Get_DisabledForHelp: TtfwWordRefList;
  property Dictionaries: TtfwDictionaryList
   read Get_Dictionaries;
  property InitedDictionaries: TtfwInitedDictionariesList
   read Get_InitedDictionaries;
  property MainDictionary: TtfwMainDictionary
   read Get_MainDictionary;
  property DisabledForHelp: TtfwWordRefList
   read Get_DisabledForHelp;
 end;//ItfwScriptEngineEx
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoScripts)

end.
