unit tfwMainDictionaryWordsPack;

interface

uses
 l3IntfUses
 , tfwMainDictionary
 , tfwScriptingInterfaces
 , tfwClassLike
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopMainDictionaryCompiledCode = class(TtfwClassLike)
  {* Слово скрипта pop:MainDictionary:CompiledCode
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aMainDictionary pop:MainDictionary:CompiledCode >>> l_TtfwWord
[code]  }
  function CompiledCode(const aCtx: TtfwContext;
   aMainDictionary: TtfwMainDictionary): TtfwWord;
   {* Реализация слова скрипта pop:MainDictionary:CompiledCode }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopMainDictionaryCompiledCode
 
end.
