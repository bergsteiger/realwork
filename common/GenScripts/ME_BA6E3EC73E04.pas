unit ReleaseToK;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleaseToK = class(TTestResultsPlace)
  {*  (�������� �������) }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TReleaseToK
 
implementation

uses
 l3ImplUses
;

end.
