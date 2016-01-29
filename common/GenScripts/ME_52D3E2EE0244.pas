unit kwCompiledVar.imp;

interface

uses
 l3IntfUses
 , tfwTypeInfo
 , tfwScriptingInterfaces
;

type
 _kwCompiledVar_ = class(MtfwWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//_kwCompiledVar_
 
implementation

uses
 l3ImplUses
 , l3Base
 , TypInfo
 , l3String
;

end.
