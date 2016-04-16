unit K336663851;
 {* [RequestLink:336663851] }

// ������: "w:\common\components\rtl\Garant\Daily\K336663851.pas"
// ���������: "TestCase"
// ������� ������: "K336663851" MUID: (4F5C42640316)
// ��� ����: "TK336663851"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , PreviewTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK336663851 = class({$If NOT Defined(NoVCM)}
 TPreviewTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:336663851] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK336663851
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
function TK336663851.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7 Lulin';
end;//TK336663851.GetFolder

function TK336663851.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F5C42640316';
end;//TK336663851.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK336663851.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
