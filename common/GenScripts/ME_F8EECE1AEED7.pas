unit ReleaseItsLAW;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleaseItsLAW = class(TTestResultsPlace)
  {*  (�������� �������) }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TReleaseItsLAW
 
implementation

uses
 l3ImplUses
;

end.
