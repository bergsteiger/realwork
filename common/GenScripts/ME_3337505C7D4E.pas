unit ReleaseToK3;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleaseToK3 = class(TTestResultsPlace)
  {*  (�������� �������) }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TReleaseToK3
 
implementation

uses
 l3ImplUses
;

end.
