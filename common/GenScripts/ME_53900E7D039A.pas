unit K540412066;
 {* [Requestlink:540412066] }

// ������: "w:\common\components\rtl\Garant\Daily\K540412066.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK540412066 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:540412066] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK540412066
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK540412066.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK540412066.GetFolder

function TK540412066.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53900E7D039A';
end;//TK540412066.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK540412066.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
