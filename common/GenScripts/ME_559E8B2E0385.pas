unit tfwDictionaryEx;

interface

uses
 l3IntfUses
 , tfwDictionaryExPrim
 , tfwScriptingInterfaces
 , tfwDictionaryPtrList
 , l3Interfaces
 , tfwStreamFactory
 , tfwInitCodeWord
 , tfwDictionary
 , tfwInitedDictionariesList
;

type
 TtfwDictionaryEx = class(TtfwDictionaryExPrim)
  function FindInUsedDictionary(anOther: TtfwDictionary;
   const aName: Il3CString): TtfwKeyWord;
  procedure RunInitCode(aRunned: TtfwInitedDictionariesList;
   const aCtx: TtfwContext);
  procedure EnterCode(const aCtx: TtfwContext);
  procedure LeaveCode(const aCtx: TtfwContext);
  procedure UseDictionary(aDictionary: TtfwDictionaryEx);
  procedure Create(aFile: TtfwStreamFactory;
   const aUsed: array of TtfwDictionaryEx); overload;
  procedure ExportDictionary(aDictionary: TtfwDictionaryEx);
  procedure Create(const aFileName: Il3CString;
   const aUsed: array of TtfwDictionaryEx); overload;
  procedure AddCodePart(aWord: TtfwWord;
   const aCtx: TtfwContext;
   aSNI: TtfwSuppressNextImmediate);
   {* Добавляет скомпилированный код к текущему компилируемуму слову }
 end;//TtfwDictionaryEx
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Math
 , tfwAutoregisteredDiction
 , l3String
 , tfwDictionaryExWordsPack
;

end.
