unit callMSSRunner;

interface

uses
 l3IntfUses
;

type
 TcallMSSRunner = class
  procedure Run;
 end;//TcallMSSRunner
 
implementation

uses
 l3ImplUses
 , kwMain
 , tfwDefaultScriptCaller
 , l3String
 , tfwConsoleScriptCaller
 , tfwScriptEngine
 , tfwScriptEngineEX
 , SysUtils
 , l3FileUtils
 , l3Base
 , Windows
 , StrUtils
 , l3StringList
 , tfwOutToFileScriptCaller
;

end.
