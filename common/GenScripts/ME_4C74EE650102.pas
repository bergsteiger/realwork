unit K233014742;
 {* [RequestLink:233014742] }

// ������: "w:\common\components\rtl\Garant\Daily\K233014742.pas"
// ���������: "TestCase"
// ������� ������: "K233014742" MUID: (4C74EE650102)
// ��� ����: "TK233014742"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , GZipTest
;

type
 TK233014742 = class(TGZipTest)
  {* [RequestLink:233014742] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK233014742
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK233014742.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK233014742.GetFolder

function TK233014742.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C74EE650102';
end;//TK233014742.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK233014742.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
