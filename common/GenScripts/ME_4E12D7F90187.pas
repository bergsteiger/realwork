unit K272666734;
 {* [$272666734] }

// ������: "w:\common\components\rtl\Garant\Daily\K272666734.pas"
// ���������: "TestCase"
// ������� ������: "K272666734" MUID: (4E12D7F90187)
// ��� ����: "TK272666734"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RowSelectionTest
 , nevTools
 , l3Units
;

type
 TK272666734 = class(TRowSelectionTest)
  {* [$272666734] }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* ���������� �����, �� ������� ����� ������������������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK272666734
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

function TK272666734.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
//#UC START# *4BF4E6A00093_4E12D7F90187_var*
//#UC END# *4BF4E6A00093_4E12D7F90187_var*
begin
//#UC START# *4BF4E6A00093_4E12D7F90187_impl*
 Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[0];
                          //^- �������     ^- ������      ^- ������
//#UC END# *4BF4E6A00093_4E12D7F90187_impl*
end;//TK272666734.GetInnerPara

{$If NOT Defined(NoVCM)}
function TK272666734.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4E12D7F90187_var*
//#UC END# *4C07AC6F036D_4E12D7F90187_var*
begin
//#UC START# *4C07AC6F036D_4E12D7F90187_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4E12D7F90187_impl*
end;//TK272666734.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

function TK272666734.GetPoint(const aMap: InevMap): Tl3Point;
 {* ���������� �����, �� ������� ����� ������������������. }
//#UC START# *4C3C927B027E_4E12D7F90187_var*
//#UC END# *4C3C927B027E_4E12D7F90187_var*
begin
//#UC START# *4C3C927B027E_4E12D7F90187_impl*
 Result.X := aMap.Bounds.Left - 5;
 Result.Y := aMap.Bounds.Top + 70;
//#UC END# *4C3C927B027E_4E12D7F90187_impl*
end;//TK272666734.GetPoint

function TK272666734.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK272666734.GetFolder

function TK272666734.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E12D7F90187';
end;//TK272666734.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK272666734.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
