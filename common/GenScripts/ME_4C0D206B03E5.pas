unit K217680060;
 {* [RequestLink:217680060] }

// ������: "w:\common\components\rtl\Garant\Daily\K217680060.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK217680060 = class(TScrollTest)
  {* [RequestLink:217680060] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217680060
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

function TK217680060.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK217680060.GetFolder

function TK217680060.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C0D206B03E5';
end;//TK217680060.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217680060.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
