unit tfwRegisterableWordPrim;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
;

type
 TtfwRegisterableWordPrim = class(TtfwWord)
  function RegisterInstance(const aName: AnsiString): Boolean;
  function Register(const aName: AnsiString): Boolean;
  function ReallyNeedRegister: Boolean;
  procedure RegisterInEngine;
  function GetWordNameForRegister: AnsiString;
 end;//TtfwRegisterableWordPrim
 
implementation

uses
 l3ImplUses
 , tfwAutoregisteredDiction
;

end.
