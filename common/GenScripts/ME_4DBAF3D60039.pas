unit kwDEFAULT;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwDEFAULT = class(TtfwRegisterableWord)
  {* ���������� ����� ��� ����������� ����� �� ��������� � ���������������� Case. �� ������������� ��� ������� ������. }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDEFAULT
 
implementation

uses
 l3ImplUses
;

end.
