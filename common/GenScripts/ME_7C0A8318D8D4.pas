unit ReleasetoKT;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleasetoKT = class(TTestResultsPlace)
  {* ���������� ����� ��������� � ����� (�������� �������) }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TReleasetoKT
 
implementation

uses
 l3ImplUses
;

end.
