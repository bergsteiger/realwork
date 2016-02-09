unit CommentAndScrollTest;
 {* ���� ��� ���������� � �������� ����������� � ������������ ��������������. }

// ������: "w:\common\components\gui\Garant\Daily\CommentAndScrollTest.pas"
// ���������: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextEditorVisitor
 , nevTools
 , PrimTextLoad_Form
;

type
 TCommentAndScrollTest = {abstract} class(TTextEditorVisitor)
  {* ���� ��� ���������� � �������� ����������� � ������������ ��������������. }
  protected
   procedure MoveCursor4Insert(aForm: TPrimTextLoadForm); virtual;
    {* ����������� ������ ����� �������� �����������. }
   function GetUserComment(const aPoint: InevBasePoint): InevBasePoint; virtual;
    {* �������� ���������������� ����������� }
   procedure DoScroll(aForm: TPrimTextLoadForm); virtual;
    {* ��������� ������ � ��������� (���� �����). }
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   procedure CheckTopAnchor(const aView: InevInputView); override;
    {* ��������� ����� ������ ��������� ����� ��������� ��������� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function F1Like: Boolean; override;
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TCommentAndScrollTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , evOp
 , evTypes
 , l3Base
 , CommentPara_Const
 , eeEditorExport
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TCommentAndScrollTest.MoveCursor4Insert(aForm: TPrimTextLoadForm);
 {* ����������� ������ ����� �������� �����������. }
//#UC START# *4CA2F33F01E5_4C9CA365006C_var*
var
 i : Integer;
//#UC END# *4CA2F33F01E5_4C9CA365006C_var*
begin
//#UC START# *4CA2F33F01E5_4C9CA365006C_impl*
 for i := 0 to 5 do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocParaDown);
//#UC END# *4CA2F33F01E5_4C9CA365006C_impl*
end;//TCommentAndScrollTest.MoveCursor4Insert

function TCommentAndScrollTest.GetUserComment(const aPoint: InevBasePoint): InevBasePoint;
 {* �������� ���������������� ����������� }
//#UC START# *4CA982110056_4C9CA365006C_var*
//#UC END# *4CA982110056_4C9CA365006C_var*
begin
//#UC START# *4CA982110056_4C9CA365006C_impl*
 Result := aPoint;
 while not Result.AsObject.IsKindOf(k2_typCommentPara) do
  Result := Result.Inner;
//#UC END# *4CA982110056_4C9CA365006C_impl*
end;//TCommentAndScrollTest.GetUserComment

procedure TCommentAndScrollTest.DoScroll(aForm: TPrimTextLoadForm);
 {* ��������� ������ � ��������� (���� �����). }
//#UC START# *4CA982800281_4C9CA365006C_var*
//#UC END# *4CA982800281_4C9CA365006C_var*
begin
//#UC START# *4CA982800281_4C9CA365006C_impl*

//#UC END# *4CA982800281_4C9CA365006C_impl*
end;//TCommentAndScrollTest.DoScroll

procedure TCommentAndScrollTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4C9CA365006C_var*
var
 l_UserComment : InevBasePoint;
 l_PID         : Integer;
 i             : Integer;
//#UC END# *4BE419AF0217_4C9CA365006C_var*
begin
//#UC START# *4BE419AF0217_4C9CA365006C_impl*
 aForm.Text.Select(ev_stDocument);
 aForm.Text.Copy;
 MoveCursor4Insert(aForm);
 (aForm.Text as TeeEditorExport).InsertUserComment;
 aForm.Text.Paste;
 l3System.ClearClipboard;
 l_UserComment := GetUserComment(aForm.Text.Selection.Cursor);
 DoScroll(aForm);
 l_PID := l_UserComment.Obj^.PID;
 l_UserComment.Obj^.OwnerObj.SubRange(aForm.Text.View, l_PID + 1, l_PID + 1).Modify.Delete(aForm.Text.View);
 ScrollByLine(aForm, 1, True, False);
 CheckTopAnchor(aForm.Text.View);
//#UC END# *4BE419AF0217_4C9CA365006C_impl*
end;//TCommentAndScrollTest.DoVisit

procedure TCommentAndScrollTest.CheckTopAnchor(const aView: InevInputView);
 {* ��������� ����� ������ ��������� ����� ��������� ��������� }
//#UC START# *4C1F0A260192_4C9CA365006C_var*
//#UC END# *4C1F0A260192_4C9CA365006C_var*
begin
//#UC START# *4C1F0A260192_4C9CA365006C_impl*
 CheckFalse(aView.TopAnchor.Inner.AsObject.IsKindOf(k2_typCommentPara), '����������� �� ��� �������! � TopAnchor ��� ��� ������!');
//#UC END# *4C1F0A260192_4C9CA365006C_impl*
end;//TCommentAndScrollTest.CheckTopAnchor

function TCommentAndScrollTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TCommentAndScrollTest.GetFolder

function TCommentAndScrollTest.F1Like: Boolean;
//#UC START# *4C9B31F6015E_4C9CA365006C_var*
//#UC END# *4C9B31F6015E_4C9CA365006C_var*
begin
//#UC START# *4C9B31F6015E_4C9CA365006C_impl*
 Result := True;
//#UC END# *4C9B31F6015E_4C9CA365006C_impl*
end;//TCommentAndScrollTest.F1Like

function TCommentAndScrollTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C9CA365006C';
end;//TCommentAndScrollTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
