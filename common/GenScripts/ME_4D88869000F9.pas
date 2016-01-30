unit K258610458;
 {* [$258610458] }

// ������: "w:\common\components\rtl\Garant\Daily\K258610458.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MouseSelectPtTest
 , nevTools
 , l3Units
;

type
 TK258610458 = class(TMouseSelectPtTest)
  {* [$258610458] }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CheckTopAnchor(const aView: InevInputView); override;
    {* ��������� ����� ������ ��������� ����� ��������� ��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* ���������� �����, �� ������� ����� ������������������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK258610458
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK258610458.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
//#UC START# *4BF4E6A00093_4D88869000F9_var*
//#UC END# *4BF4E6A00093_4D88869000F9_var*
begin
//#UC START# *4BF4E6A00093_4D88869000F9_impl*
 Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[0];
                          //^- �������     ^- ������      ^- ������
//#UC END# *4BF4E6A00093_4D88869000F9_impl*
end;//TK258610458.GetInnerPara

{$If NOT Defined(NoVCM)}
function TK258610458.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4D88869000F9_var*
//#UC END# *4C07AC6F036D_4D88869000F9_var*
begin
//#UC START# *4C07AC6F036D_4D88869000F9_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4D88869000F9_impl*
end;//TK258610458.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TK258610458.CheckTopAnchor(const aView: InevInputView);
 {* ��������� ����� ������ ��������� ����� ��������� ��������� }
//#UC START# *4C1F0A260192_4D88869000F9_var*
//#UC END# *4C1F0A260192_4D88869000F9_var*
begin
//#UC START# *4C1F0A260192_4D88869000F9_impl*
 Check(aView.TopAnchor.AtStart);
//#UC END# *4C1F0A260192_4D88869000F9_impl*
end;//TK258610458.CheckTopAnchor
{$IfEnd} // NOT Defined(NoVCM)

function TK258610458.GetPoint(const aMap: InevMap): Tl3Point;
 {* ���������� �����, �� ������� ����� ������������������. }
//#UC START# *4C3C927B027E_4D88869000F9_var*
//#UC END# *4C3C927B027E_4D88869000F9_var*
begin
//#UC START# *4C3C927B027E_4D88869000F9_impl*
 Assert(aMap <> nil);
 Result.X := aMap.Bounds.Left + 50;
 Result.Y := aMap.Bounds.Bottom - 200;
//#UC END# *4C3C927B027E_4D88869000F9_impl*
end;//TK258610458.GetPoint

function TK258610458.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK258610458.GetFolder

function TK258610458.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D88869000F9';
end;//TK258610458.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK258610458.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
