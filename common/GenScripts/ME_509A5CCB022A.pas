unit kwLoadFromFile;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwLoadFromFile = class(TtfwRegisterableWord)
  {* ��������� ���� � ����� ��������� ������ TPrimTextLoadForm. 
*������:* ���_����� LoadFromFile
*����������:* ������ ���������� ��� ������ DailyTests � ���������� ��������� form:Needs. ��� ����� ����� �������� ��� ���� - ����� ������������� �������� ���� � ������ ��� ������. }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwLoadFromFile
 
implementation

uses
 l3ImplUses
 , PrimTextLoad_Form
 , Document_Const
;

end.
