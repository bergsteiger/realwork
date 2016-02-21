unit CommentInTableAndScrollTest;
 {* ���� ������� ���������� � ������� }

// ������: "w:\common\components\gui\Garant\Daily\CommentInTableAndScrollTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , CommentAndScrollTest
 , nevTools
 , PrimTextLoad_Form
;

type
 TCommentInTableAndScrollTest = {abstract} class(TCommentAndScrollTest)
  {* ���� ������� ���������� � ������� }
  private
   function IsUserComment(const aView: InevInputView): Boolean;
    {* ��������� ��������� �� ����� �� ���������������� �����������. }
  protected
   procedure CheckTopAnchor(const aView: InevInputView); override;
    {* ��������� ����� ������ ��������� ����� ��������� ��������� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   procedure MoveCursor4Insert(aForm: TPrimTextLoadForm); override;
    {* ����������� ������ ����� �������� �����������. }
   function GetUserComment(const aPoint: InevBasePoint): InevBasePoint; override;
    {* �������� ���������������� ����������� }
   procedure DoScroll(aForm: TPrimTextLoadForm); override;
    {* ��������� ������ � ��������� (���� �����). }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TCommentInTableAndScrollTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , evOp
 , TableCell_Const
 , SBSCell_Const
 , CommentPara_Const
 , l3Variant
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TCommentInTableAndScrollTest.IsUserComment(const aView: InevInputView): Boolean;
 {* ��������� ��������� �� ����� �� ���������������� �����������. }
//#UC START# *4CA983690025_4CA2F3AA0033_var*
var
 l_Real   : InevBasePoint;
 l_Anchor : InevBasePoint;
//#UC END# *4CA983690025_4CA2F3AA0033_var*
begin
//#UC START# *4CA983690025_4CA2F3AA0033_impl*
 Result := False;
 l_Anchor := aView.TopAnchor;
 while l_Anchor <> nil do
 begin
  if l_Anchor.AsObject.IsKindOf(k2_typCommentPara) then
  begin
   Result := True;
   Break;
  end; // if l_Anchor.IsKindOf(k2_typCommentPara) then
  if l_Anchor.HasBaseLine then
   l_Anchor := l_Anchor.InnerFor(l_Anchor.Obj^.ToList.Obj[0], l_Real)
  else
   l_Anchor := l_Anchor.Inner;
 end; // while l_Anchor <> nil do
//#UC END# *4CA983690025_4CA2F3AA0033_impl*
end;//TCommentInTableAndScrollTest.IsUserComment

procedure TCommentInTableAndScrollTest.CheckTopAnchor(const aView: InevInputView);
 {* ��������� ����� ������ ��������� ����� ��������� ��������� }
//#UC START# *4C1F0A260192_4CA2F3AA0033_var*
//#UC END# *4C1F0A260192_4CA2F3AA0033_var*
begin
//#UC START# *4C1F0A260192_4CA2F3AA0033_impl*
 CheckFalse(IsUserComment(aView), '����������� �� ��� �������! � TopAnchor ��� ��� ������!');
//#UC END# *4C1F0A260192_4CA2F3AA0033_impl*
end;//TCommentInTableAndScrollTest.CheckTopAnchor

function TCommentInTableAndScrollTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TCommentInTableAndScrollTest.GetFolder

procedure TCommentInTableAndScrollTest.MoveCursor4Insert(aForm: TPrimTextLoadForm);
 {* ����������� ������ ����� �������� �����������. }
//#UC START# *4CA2F33F01E5_4CA2F3AA0033_var*
var
 l_Tag: Tl3Variant;
//#UC END# *4CA2F33F01E5_4CA2F3AA0033_var*
begin
//#UC START# *4CA2F33F01E5_4CA2F3AA0033_impl*
 l_Tag := aForm.Text.Selection.Cursor.MostInner.AsObject.Owner;
 while not l_Tag.IsKindOf(k2_typTableCell) or l_Tag.IsKindOf(k2_typSBSCell) do
 begin
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown);
  l_Tag := aForm.Text.Selection.Cursor.MostInner.AsObject.Owner;
 end; // while not l_Tag.IsKindOf(k2_typTableCell) ...
 aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown);
 //aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown); 
//#UC END# *4CA2F33F01E5_4CA2F3AA0033_impl*
end;//TCommentInTableAndScrollTest.MoveCursor4Insert

function TCommentInTableAndScrollTest.GetUserComment(const aPoint: InevBasePoint): InevBasePoint;
 {* �������� ���������������� ����������� }
//#UC START# *4CA982110056_4CA2F3AA0033_var*
var
 l_PrevPoint: InevBasePoint;
//#UC END# *4CA982110056_4CA2F3AA0033_var*
begin
//#UC START# *4CA982110056_4CA2F3AA0033_impl*
 Result := aPoint;
 while not Result.AsObject.IsKindOf(k2_typCommentPara) do
 begin
  l_PrevPoint := Result;
  Result := Result.Inner;
  if Result = nil then
   Result := l_PrevPoint.Obj^.ToList.Obj[l_PrevPoint.Obj^.AsObject.ChildrenCount - 1].MakePoint;
 end; // while not Result.IsKindOf(k2_typCommentPara) do
//#UC END# *4CA982110056_4CA2F3AA0033_impl*
end;//TCommentInTableAndScrollTest.GetUserComment

procedure TCommentInTableAndScrollTest.DoScroll(aForm: TPrimTextLoadForm);
 {* ��������� ������ � ��������� (���� �����). }
//#UC START# *4CA982800281_4CA2F3AA0033_var*
//#UC END# *4CA982800281_4CA2F3AA0033_var*
begin
//#UC START# *4CA982800281_4CA2F3AA0033_impl*
 while not IsUserComment(aForm.Text.View) do
  ScrollByLine(aForm, 1, False, False);
//#UC END# *4CA982800281_4CA2F3AA0033_impl*
end;//TCommentInTableAndScrollTest.DoScroll

function TCommentInTableAndScrollTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA2F3AA0033';
end;//TCommentInTableAndScrollTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
