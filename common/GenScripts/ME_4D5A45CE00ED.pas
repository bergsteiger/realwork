unit TabInTableTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , nevTools
 , PrimTextLoad_Form
;

type
 TTabInTableTest = class(TTextEditorVisitor)
  {* ������������ ��������� ���������� � ������� }
  procedure CheckPoint(const aCellPoint: InevBasePoint);
  function GetDownMoveCount: Integer;
   {* ���������� �������� ���� }
  function GetTabMoveCount: Integer;
   {* ���������� �������� �� ���������� }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TTabInTableTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
