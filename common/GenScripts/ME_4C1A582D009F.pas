unit K206079241;
 {* [RequestLink:206079241]. }

// ������: "w:\common\components\rtl\Garant\Daily\K206079241.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
;

type
 TK206079241 = class(TScrollTest)
  {* [RequestLink:206079241]. }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK206079241
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

{$If NOT Defined(NoVCM)}
function TK206079241.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4C1A582D009F_var*
//#UC END# *4C08CF700318_4C1A582D009F_var*
begin
//#UC START# *4C08CF700318_4C1A582D009F_impl*
 Result.X := 1024;
 Result.Y := 768;
//#UC END# *4C08CF700318_4C1A582D009F_impl*
end;//TK206079241.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK206079241.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK206079241.GetFolder

function TK206079241.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C1A582D009F';
end;//TK206079241.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK206079241.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
