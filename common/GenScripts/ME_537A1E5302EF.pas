unit ToK2;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TToK2 = class(TTestResultsPlace)
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TToK2
 
implementation

uses
 l3ImplUses
;

end.
