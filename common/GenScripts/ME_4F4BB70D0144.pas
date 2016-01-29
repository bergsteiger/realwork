unit kwForwardDeclaration;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwDictionaryPrim
 , l3Interfaces
 , l3Variant
;

type
 TkwForwardDeclaration = class(TtfwWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwForwardDeclaration
 
implementation

uses
 l3ImplUses
 , SysUtils
 , tfwClassRef
 , kwForwardDeclarationHolder
;

end.
