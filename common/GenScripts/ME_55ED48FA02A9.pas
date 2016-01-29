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
  {* ����� ������� pop:MainDictionary:CompiledCode
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aMainDictionary pop:MainDictionary:CompiledCode >>> l_TtfwWord
[code]  }
  function CompiledCode(const aCtx: TtfwContext;
   aMainDictionary: TtfwMainDictionary): TtfwWord;
   {* ���������� ����� ������� pop:MainDictionary:CompiledCode }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopMainDictionaryCompiledCode
 
end.
