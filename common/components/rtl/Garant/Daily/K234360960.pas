unit K234360960;
 {* [$234360960] }

// ������: "w:\common\components\rtl\Garant\Daily\K234360960.pas"
// ���������: "TestCase"
// ������� ������: "K234360960" MUID: (4CAACC7903BC)
// ��� ����: "TK234360960"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , InsertRowTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK234360960 = class({$If NOT Defined(NoVCM)}
 TInsertRowTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [$234360960] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK234360960
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
function TK234360960.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK234360960.GetFolder

function TK234360960.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CAACC7903BC';
end;//TK234360960.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK234360960.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
