unit tfwClassLike;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , kwCompiledWordPrimPrim
 , tfwWordRefList
;

type
 TtfwClassLikeRunner = class(TkwCompiledWordPrimPrim)
  procedure Create(aWordProducer: TtfwWord;
   const aCtx: TtfwContext;
   aLeftWordRefs: TtfwWordRefList);
  procedure PushParams(const aCtx: TtfwContext);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwClassLikeRunner
 
 TtfwClassLike = class(TtfwRegisterableWord)
  function BindParams: Boolean;
  function StrictChecking: Boolean;
 end;//TtfwClassLike
 
implementation

uses
 l3ImplUses
 , kwCompiledWordPrim
 , TypInfo
 , tfwValueTypes
 , SysUtils
;

end.
