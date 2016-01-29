unit kwSystemIncluded;

interface

uses
 l3IntfUses
 , kwIncludedPrim
 , tfwStreamFactory
 , tfwScriptingInterfaces
;

type
 TkwSystemIncluded = class(TkwIncludedPrim)
  procedure Create(aStream: TtfwStreamFactory);
 end;//TkwSystemIncluded
 
implementation

uses
 l3ImplUses
 , tfwCOMStreamFactory
 , SysUtils
;

end.
