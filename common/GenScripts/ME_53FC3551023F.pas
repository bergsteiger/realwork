unit kwTestResolveInputFilePath;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwTestResolveInputFilePath = class(TtfwRegisterableWord)
  {* *��������:* ��������� � ����� ����� ���� � ���������� TestSet, ��� �������� �������� �����.
*������*
[code]
aFileName test:ResolveInputFilePath
[code]
��� aFileName - ��� ����� ��� ���� (!).
��������� ���������� � ����. }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTestResolveInputFilePath
 
implementation

uses
 l3ImplUses
;

end.
