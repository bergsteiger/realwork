unit DrawSelectionInTableTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , evDelayedPaintersSpy
 , PrimTextLoad_Form
 , Types
;

type
 TDrawSelectionInTableTest = class(TTextEditorVisitor, IevDelayedPainterLogger)
  {* ���� ��� �������� ������������ ��������� ��������� � ������� }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
  function OpenSelectionLog: AnsiString;
  procedure CloseSelectionLog(const aLogName: AnsiString);
 end;//TDrawSelectionInTableTest
 
implementation

uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
 , evOp
 , evCursorTools
;

end.
