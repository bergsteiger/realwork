unit K480825135;
 {* [Requestlink:480825135] }

// ������: "w:\common\components\rtl\Garant\Daily\K480825135.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK480825135 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:480825135] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK480825135
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK480825135.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.9';
end;//TK480825135.GetFolder

function TK480825135.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '523AC3E40022';
end;//TK480825135.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK480825135.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
