unit tfwStringConstantRegistrator;

interface

uses
 l3IntfUses
 , tfwString
 , l3Interfaces
 , tfwScriptingInterfaces
;

type
 TtfwStringConstantRegistrator = class(TtfwString)
  function Register(const aName: AnsiString;
   const aValue: Il3CString): Boolean;
 end;//TtfwStringConstantRegistrator
 
implementation

uses
 l3ImplUses
 , l3String
 , SysUtils
;

end.
