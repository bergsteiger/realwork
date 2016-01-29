unit Scripter.imp;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
;

type
 _Scripter_ = class
  {* Парень умеющий выполнять скрипты }
  procedure Script(const aString: AnsiString);
  procedure ScriptFromFile(const aFileName: AnsiString);
  function ResolveScriptFilePath(const aFileName: AnsiString): AnsiString;
 end;//_Scripter_
 
implementation

uses
 l3ImplUses
 , tfwScriptEngine
;

end.
