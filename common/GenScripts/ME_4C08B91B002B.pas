unit K210436976;
 {* [RequestLink:210436976] }

// ������: "w:\common\components\rtl\Garant\Daily\K210436976.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

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
 TK210436976 = class(TScrollTest)
  {* [RequestLink:210436976] }
  protected
   {$If NOT Defined(NoVCM)}
   function WebStyle: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK210436976
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
function TK210436976.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4C08B91B002B_var*
//#UC END# *4C08CF4300BE_4C08B91B002B_var*
begin
//#UC START# *4C08CF4300BE_4C08B91B002B_impl*
 Result := false;
//#UC END# *4C08CF4300BE_4C08B91B002B_impl*
end;//TK210436976.WebStyle

function TK210436976.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4C08B91B002B_var*
//#UC END# *4C08CF700318_4C08B91B002B_var*
begin
//#UC START# *4C08CF700318_4C08B91B002B_impl*
 Result.X := 1024;
 Result.Y := 768;
//#UC END# *4C08CF700318_4C08B91B002B_impl*
end;//TK210436976.FormExtent

function TK210436976.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK210436976.GetFolder

function TK210436976.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C08B91B002B';
end;//TK210436976.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210436976.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
