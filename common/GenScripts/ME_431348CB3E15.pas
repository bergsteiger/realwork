unit ReleasetoK;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleasetoK = class(TTestResultsPlace)
  {* ����������� ����� ��� �� (�������� �������) }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TReleasetoK
 
implementation

uses
 l3ImplUses
;

end.
