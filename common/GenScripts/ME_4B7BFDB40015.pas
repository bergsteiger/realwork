unit toK;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TtoK = class(TTestResultsPlace)
  {* ����������� ����� ��� �� }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TtoK
 
implementation

uses
 l3ImplUses
 , SHDTestScriptEngine
;

end.
