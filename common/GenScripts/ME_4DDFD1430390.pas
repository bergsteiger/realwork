unit tfwString;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , TypInfo
;

type
 TtfwString = class(TtfwRegisterableWord)
  {* ������� ������ ��� ���������� ���� � �������. }
  function GetString: AnsiString;
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwString
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3Except
 , tfwScriptingTypes
;

end.
