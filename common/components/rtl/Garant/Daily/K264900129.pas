unit K264900129;
 {* [$264900129] }

// ������: "w:\common\components\rtl\Garant\Daily\K264900129.pas"
// ���������: "TestCase"
// ������� ������: "K264900129" MUID: (4DB658500049)
// ��� ����: "TK264900129"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollByArrowAndCheckShapesTest
 , Types
;

type
 TK264900129 = class(TScrollByArrowAndCheckShapesTest)
  {* [$264900129] }
  protected
   function GetScrollCount: Integer; override;
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK264900129
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3InternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nevTools
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
 //#UC START# *4DB658500049impl_uses*
 //#UC END# *4DB658500049impl_uses*
;

function TK264900129.GetScrollCount: Integer;
//#UC START# *4D80BB670151_4DB658500049_var*
//#UC END# *4D80BB670151_4DB658500049_var*
begin
//#UC START# *4D80BB670151_4DB658500049_impl*
 Result := 50;
//#UC END# *4D80BB670151_4DB658500049_impl*
end;//TK264900129.GetScrollCount

{$If NOT Defined(NoVCM)}
function TK264900129.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4DB658500049_var*
//#UC END# *4C07AC6F036D_4DB658500049_var*
begin
//#UC START# *4C07AC6F036D_4DB658500049_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4DB658500049_impl*
end;//TK264900129.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK264900129.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4DB658500049_var*
//#UC END# *4C08CF700318_4DB658500049_var*
begin
//#UC START# *4C08CF700318_4DB658500049_impl*
 Result.X := 1000;
 Result.Y := 710;
//#UC END# *4C08CF700318_4DB658500049_impl*
end;//TK264900129.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK264900129.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK264900129.GetFolder

function TK264900129.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4DB658500049';
end;//TK264900129.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK264900129.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
