unit TextEditorVisitor;

interface

uses
 l3IntfUses
 , TextEditorVisitorPrim
;

type
 TTextEditorVisitor = class(TTextEditorVisitorPrim)
  {* ����, ���������� � ������� ��������� ����� ��������, �� �� ���������� ��� }
  procedure DoIt;
   {* ���������� ���� ����� }
  function GetNormalFontSize: Integer;
   {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
  function MaxHeight: Integer;
   {* ���� ������������ �� 0, �� ����� ����������� ���� ������� ������ �� FormExtent.Y �� MaxHeight }
 end;//TTextEditorVisitor
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evStyleInterface
 , TestFrameWork
;

end.
