unit kwIncluded;

interface

uses
 l3IntfUses
 , kwIncludedPrim
 , tfwScriptingInterfaces
;

type
 RkwIncluded = class of TkwIncluded;
 
 TkwIncluded = class(TkwIncludedPrim)
  procedure Create(const aFileName: AnsiString);
 end;//TkwIncluded
 
implementation

uses
 l3ImplUses
 , l3Parser
 , SysUtils
 , l3Filer
 , l3Types
 , l3Chars
 , kwCompiledIncluded
 , l3Base
 , tfwFileStreamFactory
;

end.
