unit ItsLAW;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TItsLAW = class(TTestResultsPlace)
  {* ����� ��� ���������� ����� }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TItsLAW
 
implementation

uses
 l3ImplUses
;

end.
