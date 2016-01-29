unit tfwScriptingExceptions;

interface

uses
 l3IntfUses
 , SysUtils
;

type
 EtfwException = class(Exception)
 end;//EtfwException
 
 EtfwCheckPrim = class(EtfwException)
  procedure IsTrue(aCondition: Boolean;
   const aMessage: AnsiString);
  procedure Fail(const aMessage: AnsiString);
 end;//EtfwCheckPrim
 
 EtfwCheck = class(EtfwCheckPrim)
 end;//EtfwCheck
 
implementation

uses
 l3ImplUses
;

end.
