unit K600945017;
 {* [Requestlink:600945017] }

// ������: "w:\common\components\rtl\Garant\Daily\K600945017.pas"
// ���������: "TestCase"
// ������� ������: "K600945017" MUID: (5575812A00AE)
// ��� ����: "TK600945017"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK600945017 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:600945017] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK600945017
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK600945017.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK600945017.GetFolder

function TK600945017.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5575812A00AE';
end;//TK600945017.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK600945017.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
