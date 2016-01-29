unit CommentAndScrollTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , nevTools
 , PrimTextLoad_Form
;

type
 TCommentAndScrollTest = class(TTextEditorVisitor)
  {* ���� ��� ���������� � �������� ����������� � ������������ ��������������. }
  procedure MoveCursor4Insert(aForm: TPrimTextLoadForm);
   {* ����������� ������ ����� �������� �����������. }
  function GetUserComment(const aPoint: InevBasePoint): InevBasePoint;
   {* �������� ���������������� ����������� }
  procedure DoScroll(aForm: TPrimTextLoadForm);
   {* ��������� ������ � ��������� (���� �����). }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TCommentAndScrollTest
 
implementation

uses
 l3ImplUses
 , evCursorTools
 , evOp
 , evTypes
 , l3Base
 , CommentPara_Const
 , eeEditorExport
 , TestFrameWork
;

end.
