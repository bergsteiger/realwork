unit K423621421;
 {* [RequestLink:423621421] }

// ������: "w:\common\components\rtl\Garant\Daily\K423621421.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoXMLWiterTest
;

type
 TK423621421 = class(TEVDtoXMLWiterTest)
  {* [RequestLink:423621421] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK423621421
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK423621421.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK423621421.GetFolder

function TK423621421.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50F53E7D02BE';
end;//TK423621421.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK423621421.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
