unit tfwInitCodeWord;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwDictionaryExPrim
 , tfwDictionaryPrim
 , l3Interfaces
 , l3Variant
;

type
 TtfwInitCodeWord = class(TtfwWord)
  procedure Create(aDictionary: TtfwDictionaryExPrim);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwInitCodeWord
 
implementation

uses
 l3ImplUses
 , tfwDictionaryEx
 , tfwAutoregisteredDiction
 , kwForwardDeclarationHolder
 , SysUtils
;

end.
