unit ReleasetoK64;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleasetoK64 = class(TTestResultsPlace)
  {*  (�������� �������) }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TReleasetoK64
 
implementation

uses
 l3ImplUses
;

end.
