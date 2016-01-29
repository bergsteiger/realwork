unit kwCompiledWordPrim;

interface

uses
 l3IntfUses
 , kwCompiledWordPrimPrim
 , tfwScriptingInterfaces
 , tfwKeyWordPrim
 , tfwWordRefList
;

type
 RkwCompiledWordPrim = class of TkwCompiledWordPrim;
 
 TkwCompiledWordPrim = class(TkwCompiledWordPrimPrim)
  procedure Create(aWordProducer: TtfwWord;
   aPrevFinder: TtfwWord;
   aTypeInfo: TtfwWordInfo;
   const aCtx: TtfwContext;
   aKey: TtfwKeyWordPrim);
  function GetCode(const aCtx: TtfwContext): TtfwWordRefList;
 end;//TkwCompiledWordPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
