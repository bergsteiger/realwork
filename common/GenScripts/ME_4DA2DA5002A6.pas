unit K259164768;
 {* [$259164768] }

// ������: "w:\common\components\rtl\Garant\Daily\K259164768.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DrawTest
 , Types
;

type
 TK259164768 = class(TDrawTest)
  {* [$259164768] }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK259164768
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
function TK259164768.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4DA2DA5002A6_var*
//#UC END# *4C08CF700318_4DA2DA5002A6_var*
begin
//#UC START# *4C08CF700318_4DA2DA5002A6_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4DA2DA5002A6_impl*
end;//TK259164768.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK259164768.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK259164768.GetFolder

function TK259164768.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4DA2DA5002A6';
end;//TK259164768.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK259164768.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
