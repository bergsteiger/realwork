unit CommentInTableAndScrollTest;

interface

uses
 l3IntfUses
 , CommentAndScrollTest
 , nevTools
 , PrimTextLoad_Form
;

type
 TCommentInTableAndScrollTest = class(TCommentAndScrollTest)
  {* ���� ������� ���������� � ������� }
  function IsUserComment(const aView: InevInputView): Boolean;
   {* ��������� ��������� �� ����� �� ���������������� �����������. }
 end;//TCommentInTableAndScrollTest
 
implementation

uses
 l3ImplUses
 , evOp
 , TableCell_Const
 , SBSCell_Const
 , CommentPara_Const
 , l3Variant
 , TestFrameWork
;

end.
