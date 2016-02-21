unit K208699964;
 {* [RequestLink:208699964] }

// ������: "w:\common\components\rtl\Garant\Daily\K208699964.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK208699964 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:208699964] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK208699964
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK208699964.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK208699964.GetFolder

function TK208699964.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BDAC30B0188';
end;//TK208699964.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK208699964.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
