unit K251334429;
 {* [$251334429] }

// ������: "w:\common\components\rtl\Garant\Daily\K251334429.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DrawTest
 , Types
;

type
 TK251334429 = class(TDrawTest)
  {* [$251334429] }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK251334429
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , nevTools
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
function TK251334429.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4D42A997020E_var*
//#UC END# *4C08CF700318_4D42A997020E_var*
begin
//#UC START# *4C08CF700318_4D42A997020E_impl*
 Result.X := 1024;
 Result.Y := 710; 
//#UC END# *4C08CF700318_4D42A997020E_impl*
end;//TK251334429.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK251334429.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK251334429.GetFolder

function TK251334429.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D42A997020E';
end;//TK251334429.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK251334429.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
