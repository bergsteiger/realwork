unit K252086528;
 {* [$252086528] }

// ������: "w:\common\components\rtl\Garant\Daily\K252086528.pas"
// ���������: "TestCase"
// ������� ������: "K252086528" MUID: (4D46BC0D00F9)
// ��� ����: "TK252086528"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , OutlinerWithEVDStyleNodes
;

type
 TK252086528 = class(TOutlinerWithEVDStyleNodes)
  {* [$252086528] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK252086528
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

function TK252086528.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK252086528.GetFolder

function TK252086528.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D46BC0D00F9';
end;//TK252086528.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK252086528.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
