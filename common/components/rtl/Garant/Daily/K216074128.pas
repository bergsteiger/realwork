unit K216074128;
 {* [$216074128] }

// ������: "w:\common\components\rtl\Garant\Daily\K216074128.pas"
// ���������: "TestCase"
// ������� ������: "K216074128" MUID: (4BFE3F220082)
// ��� ����: "TK216074128"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollAndSelectPtTest
 , nevTools
 , l3Units
;

type
 TK216074128 = class(TScrollAndSelectPtTest)
  {* [$216074128] }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
   function GetScrollCount: Integer; override;
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* ���������� �����, �� ������� ����� ������������������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK216074128
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

function TK216074128.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
//#UC START# *4BF4E6A00093_4BFE3F220082_var*
//#UC END# *4BF4E6A00093_4BFE3F220082_var*
begin
//#UC START# *4BF4E6A00093_4BFE3F220082_impl*
 Result := aDocument.AsList.Para[1]; // �������
 Result := Result.AsList.Para[8]; // ������
 Result := Result.AsList.Para[0]; // ������
//#UC END# *4BF4E6A00093_4BFE3F220082_impl*
end;//TK216074128.GetInnerPara

function TK216074128.GetScrollCount: Integer;
//#UC START# *4BFE40CD0337_4BFE3F220082_var*
//#UC END# *4BFE40CD0337_4BFE3F220082_var*
begin
//#UC START# *4BFE40CD0337_4BFE3F220082_impl*
 Result := 3;
//#UC END# *4BFE40CD0337_4BFE3F220082_impl*
end;//TK216074128.GetScrollCount

function TK216074128.GetPoint(const aMap: InevMap): Tl3Point;
 {* ���������� �����, �� ������� ����� ������������������. }
//#UC START# *4C3C927B027E_4BFE3F220082_var*
//#UC END# *4C3C927B027E_4BFE3F220082_var*
begin
//#UC START# *4C3C927B027E_4BFE3F220082_impl*
 Result := l3Point(aMap.Bounds.Left - 500, aMap.Bounds.Bottom);
//#UC END# *4C3C927B027E_4BFE3F220082_impl*
end;//TK216074128.GetPoint

function TK216074128.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK216074128.GetFolder

function TK216074128.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BFE3F220082';
end;//TK216074128.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK216074128.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
