unit ToK3;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TToK3 = class(TTestResultsPlace)
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TToK3
 
implementation

uses
 l3ImplUses
;

end.
