unit toKT;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TtoKT = class(TTestResultsPlace)
  {* ���������� ����� ��������� � ����� }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TtoKT
 
implementation

uses
 l3ImplUses
;

end.
