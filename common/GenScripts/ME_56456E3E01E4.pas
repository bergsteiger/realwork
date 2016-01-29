unit tfwOutToFileScriptCaller;

interface

uses
 l3IntfUses
 , tfwConsoleScriptCaller
 , l3Filer
 , tfwScriptingInterfaces
 , l3Interfaces
;

type
 TtfwOutToFileScriptCaller = class(TtfwConsoleScriptCaller)
  procedure Create(const aFileName: AnsiString);
  function Make(const aFileName: AnsiString): ItfwScriptCaller;
 end;//TtfwOutToFileScriptCaller
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , l3String
 , l3Chars
;

end.
