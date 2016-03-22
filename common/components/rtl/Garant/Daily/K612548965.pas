unit K612548965;
 {* [Requestlink:612548965] }

// ������: "w:\common\components\rtl\Garant\Daily\K612548965.pas"
// ���������: "TestCase"
// ������� ������: "K612548965" MUID: (565EB4980024)
// ��� ����: "TK612548965"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK612548965 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:612548965] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK612548965
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK612548965.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK612548965.GetFolder

function TK612548965.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '565EB4980024';
end;//TK612548965.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK612548965.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
