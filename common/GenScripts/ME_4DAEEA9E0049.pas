unit tfwScriptEngine;

interface

uses
 l3IntfUses
 , tfwStreamFactory
 , tfwScriptingInterfaces
 , tfwStringStreamFactory
 , tfwFileStreamFactory
;

type
 TtfwScriptEngine = class
  {* Машина для исполнения скриптов. Базовый класс. }
  procedure Script(aStream: TtfwStreamFactory;
   const aCaller: ItfwScriptCaller); overload;
  procedure Script(const aString: AnsiString;
   const aCaller: ItfwScriptCaller); overload;
  procedure ScriptFromFile(const aFileName: AnsiString;
   const aCaller: ItfwScriptCaller);
 end;//TtfwScriptEngine
 
implementation

uses
 l3ImplUses
 , l3String
 , kwEmitString
 , kwTryFinally
 , kwMain
 , kwCompiledWord
 , l3Base
 , tfwAutoregisteredDiction
 , tfwParser
 , SysUtils
 , l3Chars
 , TypInfo
 , l3Types
;

end.
