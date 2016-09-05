unit K272666721;
 {* [$272666721] }

// ������: "w:\common\components\rtl\Garant\Daily\K272666721.pas"
// ���������: "TestCase"
// ������� ������: "K272666721" MUID: (4E158C2C0116)
// ��� ����: "TK272666721"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , InsertSectionBreak
 , evCustomEditorWindow
;

type
 TK272666721 = class(TInsertSectionBreak)
  {* [$272666721] }
  protected
   function MoveCursorCount: Integer; override;
   procedure CheckPara(const aText: TevCustomEditorWindow); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK272666721
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevBase
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4E158C2C0116impl_uses*
 //#UC END# *4E158C2C0116impl_uses*
;

function TK272666721.MoveCursorCount: Integer;
//#UC START# *4E158FBB0190_4E158C2C0116_var*
//#UC END# *4E158FBB0190_4E158C2C0116_var*
begin
//#UC START# *4E158FBB0190_4E158C2C0116_impl*
 Result := 3;
//#UC END# *4E158FBB0190_4E158C2C0116_impl*
end;//TK272666721.MoveCursorCount

procedure TK272666721.CheckPara(const aText: TevCustomEditorWindow);
//#UC START# *4E15941B03E7_4E158C2C0116_var*
var
 l_UpperFI: TnevFormatInfoPrim;
 l_LowerFI: TnevFormatInfoPrim;
//#UC END# *4E15941B03E7_4E158C2C0116_var*
begin
//#UC START# *4E15941B03E7_4E158C2C0116_impl*
 l_UpperFI := aText.View.FormatInfoByPoint(aText.Document.Para[1].MakePoint);
 l_LowerFI := aText.View.FormatInfoByPoint(aText.Document.Para[aText.Document.ChildrenCount - 1].MakePoint);
 Check(l_UpperFI.RLimitWidth <> l_LowerFI.RLimitWidth, '������� ������, � ������ ���������� ����������!');
//#UC END# *4E15941B03E7_4E158C2C0116_impl*
end;//TK272666721.CheckPara

function TK272666721.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK272666721.GetFolder

function TK272666721.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E158C2C0116';
end;//TK272666721.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK272666721.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
