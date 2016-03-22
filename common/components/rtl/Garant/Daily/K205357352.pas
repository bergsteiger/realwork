unit K205357352;
 {* [$205357352] }

// ������: "w:\common\components\rtl\Garant\Daily\K205357352.pas"
// ���������: "TestCase"
// ������� ������: "K205357352" MUID: (4BCEF18800CE)
// ��� ����: "TK205357352"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK205357352 = class(TEVDtoBothNSRCWriterTest)
  {* [$205357352] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK205357352
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK205357352.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK205357352.GetFolder

function TK205357352.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BCEF18800CE';
end;//TK205357352.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK205357352.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
