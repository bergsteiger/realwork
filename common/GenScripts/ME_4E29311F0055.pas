unit kwObjectCreate;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwObjectCreate = class(TtfwRegisterableWord)
  {* ��������� ��������������� �������� �����-������� ��� ������.
*������:* aClass .Create
aClass - ����� �����.

���� ������ ������ VCM-����� �� �������������� ������� ��������� � ������ �������. }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwObjectCreate
 
implementation

uses
 l3ImplUses
 , vcmEntityForm
 , Forms
 , vcmBase
 , vcmForm
 , Controls
 , StdRes
 , afwAnswer
;

end.
