unit K252524299;
 {* [$252524299] }

// ������: "w:\common\components\rtl\Garant\Daily\K252524299.pas"
// ���������: "TestCase"
// ������� ������: "K252524299" MUID: (4D5A463C02C1)
// ��� ����: "TK252524299"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TabInTableTest
 , nevTools
;

type
 TK252524299 = class(TTabInTableTest)
  {* [$252524299] }
  protected
   procedure CheckPoint(const aCellPoint: InevBasePoint); override;
   function GetDownMoveCount: Integer; override;
    {* ���������� �������� ���� }
   function GetTabMoveCount: Integer; override;
    {* ���������� �������� �� ���������� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK252524299
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
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
;

procedure TK252524299.CheckPoint(const aCellPoint: InevBasePoint);
//#UC START# *4D5A4CA602E5_4D5A463C02C1_var*
//#UC END# *4D5A4CA602E5_4D5A463C02C1_var*
begin
//#UC START# *4D5A4CA602E5_4D5A463C02C1_impl*
 Check((aCellPoint.Obj.PID = 0) and (aCellPoint.ParentPoint.Obj.PID = 4));
//#UC END# *4D5A4CA602E5_4D5A463C02C1_impl*
end;//TK252524299.CheckPoint

function TK252524299.GetDownMoveCount: Integer;
 {* ���������� �������� ���� }
//#UC START# *4D5A4CD801F7_4D5A463C02C1_var*
//#UC END# *4D5A4CD801F7_4D5A463C02C1_var*
begin
//#UC START# *4D5A4CD801F7_4D5A463C02C1_impl*
 Result := 3;
//#UC END# *4D5A4CD801F7_4D5A463C02C1_impl*
end;//TK252524299.GetDownMoveCount

function TK252524299.GetTabMoveCount: Integer;
 {* ���������� �������� �� ���������� }
//#UC START# *4D5A4CFB029F_4D5A463C02C1_var*
//#UC END# *4D5A4CFB029F_4D5A463C02C1_var*
begin
//#UC START# *4D5A4CFB029F_4D5A463C02C1_impl*
 Result := 1;
//#UC END# *4D5A4CFB029F_4D5A463C02C1_impl*
end;//TK252524299.GetTabMoveCount

function TK252524299.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK252524299.GetFolder

function TK252524299.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D5A463C02C1';
end;//TK252524299.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK252524299.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
