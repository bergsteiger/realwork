unit K606129271;
 {* [RequestLink:606129271] }

// ������: "w:\common\components\rtl\Garant\Daily\K606129271.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK606129271 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:606129271] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK606129271
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606129271.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK606129271.GetFolder

function TK606129271.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55DD9698034F';
end;//TK606129271.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606129271.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
