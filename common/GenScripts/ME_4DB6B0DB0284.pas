unit toK64;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TtoK64 = class(TTestResultsPlace)
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TtoK64
 
implementation

uses
 l3ImplUses
;

end.
