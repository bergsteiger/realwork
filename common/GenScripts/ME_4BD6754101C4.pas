unit K206504312;
 {* [RequestLink:206504312] }

// ������: "w:\common\components\rtl\Garant\Daily\K206504312.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK206504312 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:206504312] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK206504312
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK206504312.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK206504312.GetFolder

function TK206504312.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BD6754101C4';
end;//TK206504312.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK206504312.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
