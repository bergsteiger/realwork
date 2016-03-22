unit K235058888;
 {* [$235058888] }

// ������: "w:\common\components\rtl\Garant\Daily\K235058888.pas"
// ���������: "TestCase"
// ������� ������: "K235058888" MUID: (4CA1AB5B0396)
// ��� ����: "TK235058888"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK235058888 = class(TEVDtoBothNSRCWriterTest)
  {* [$235058888] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235058888
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235058888.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235058888.GetFolder

function TK235058888.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA1AB5B0396';
end;//TK235058888.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235058888.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
