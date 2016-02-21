unit K213713837;
 {* [$213713837] }

// ������: "w:\common\components\rtl\Garant\Daily\K213713837.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , SelectPtTest
 , nevTools
 , l3Units
;

type
 TK213713837 = class(TSelectPtTest)
  {* [$213713837] }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* ���������� �����, �� ������� ����� ������������������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK213713837
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TK213713837.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
//#UC START# *4BF4E6A00093_4BF4E93C03C3_var*
//#UC END# *4BF4E6A00093_4BF4E93C03C3_var*
begin
//#UC START# *4BF4E6A00093_4BF4E93C03C3_impl*
 Result := aDocument.AsList.Para[2]; // �������
 Result := Result.AsList.Para[2]; // ������
 Result := Result.AsList.Para[3]; // ������
 Result := Result.AsList.Para[Result.ChildrenCount - 1]; // �����
//#UC END# *4BF4E6A00093_4BF4E93C03C3_impl*
end;//TK213713837.GetInnerPara

function TK213713837.GetPoint(const aMap: InevMap): Tl3Point;
 {* ���������� �����, �� ������� ����� ������������������. }
//#UC START# *4C3C927B027E_4BF4E93C03C3_var*
//#UC END# *4C3C927B027E_4BF4E93C03C3_var*
begin
//#UC START# *4C3C927B027E_4BF4E93C03C3_impl*
 Result := l3Point(aMap.Bounds.Left + 500, aMap.Bounds.Bottom + 500);
//#UC END# *4C3C927B027E_4BF4E93C03C3_impl*
end;//TK213713837.GetPoint

function TK213713837.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK213713837.GetFolder

function TK213713837.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BF4E93C03C3';
end;//TK213713837.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK213713837.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
