unit K541120799;
 {* [Requestlink:541120799] }

// ������: "w:\common\components\rtl\Garant\Daily\K541120799.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK541120799 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:541120799] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK541120799
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK541120799.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK541120799.GetFolder

function TK541120799.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5398289A01EB';
end;//TK541120799.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK541120799.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
