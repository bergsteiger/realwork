unit ToK;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TToK = class(TTestResultsPlace)
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TToK
 
implementation

uses
 l3ImplUses
;

end.
