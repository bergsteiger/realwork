unit K415728258;
 {* [Requestlink:415728258] }

// ������: "w:\common\components\rtl\Garant\Daily\K415728258.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK415728258 = class(TNSRCtoEVDTest)
  {* [Requestlink:415728258] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK415728258
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK415728258.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TK415728258.GetFolder

function TK415728258.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50C8994600FD';
end;//TK415728258.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK415728258.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
