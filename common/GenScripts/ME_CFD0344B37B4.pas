unit ReleaseToK2;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleaseToK2 = class(TTestResultsPlace)
  {*  (�������� �������) }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TReleaseToK2
 
implementation

uses
 l3ImplUses
;

end.
