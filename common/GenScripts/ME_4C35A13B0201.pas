unit Archi2;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TArchi2 = class(TTestResultsPlace)
  {* ����� �� Archi2 }
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
 end;//TArchi2
 
implementation

uses
 l3ImplUses
;

end.
