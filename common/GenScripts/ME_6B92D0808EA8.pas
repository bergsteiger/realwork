unit ReleaseArchi2;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleaseArchi2 = class(TTestResultsPlace)
  {* ����� �� Archi2 (�������� �������) }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TReleaseArchi2
 
implementation

uses
 l3ImplUses
;

end.
