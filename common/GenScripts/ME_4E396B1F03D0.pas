unit K278136024;
 {* [RequestLink:278136024] }

// ������: "w:\common\components\rtl\Garant\Daily\K278136024.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WikiToEVDWriterTest
;

type
 TK278136024 = class(TWikiToEVDWriterTest)
  {* [RequestLink:278136024] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK278136024
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK278136024.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7 Lulin';
end;//TK278136024.GetFolder

function TK278136024.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E396B1F03D0';
end;//TK278136024.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK278136024.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
