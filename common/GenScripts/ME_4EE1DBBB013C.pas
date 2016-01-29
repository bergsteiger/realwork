unit tfwInteger;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , TypInfo
;

type
 TtfwInteger = class(TtfwRegisterableWord)
  {* ������� ������ ��� ���������� ���� � �������. }
  function GetInteger: Integer;
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwInteger
 
implementation

uses
 l3ImplUses
 , l3Except
 , l3Base
;

end.
