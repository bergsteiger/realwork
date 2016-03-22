unit K297705917;
 {* [RequestLink:297705917] }

// ������: "w:\common\components\rtl\Garant\Daily\K297705917.pas"
// ���������: "TestCase"
// ������� ������: "K297705917" MUID: (4EBB8F4E0388)
// ��� ����: "TK297705917"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AllChildreCountTest
;

type
 TK297705917 = class(TAllChildreCountTest)
  {* [RequestLink:297705917] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK297705917
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

function TK297705917.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK297705917.GetFolder

function TK297705917.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4EBB8F4E0388';
end;//TK297705917.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK297705917.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
