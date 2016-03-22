unit K404357586;
 {* [Requestlink:404357586] }

// ������: "w:\common\components\rtl\Garant\Daily\K404357586.pas"
// ���������: "TestCase"
// ������� ������: "K404357586" MUID: (50C9836002B6)
// ��� ����: "TK404357586"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK404357586 = class(TNSRCtoEVDTest)
  {* [Requestlink:404357586] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK404357586
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK404357586.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TK404357586.GetFolder

function TK404357586.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50C9836002B6';
end;//TK404357586.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK404357586.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
