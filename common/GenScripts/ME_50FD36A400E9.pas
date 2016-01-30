unit K424399558;
 {* [RequestLink:424399558] }

// ������: "w:\common\components\rtl\Garant\Daily\K424399558.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoXMLWiterTest
;

type
 TK424399558 = class(TEVDtoXMLWiterTest)
  {* [RequestLink:424399558] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK424399558
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK424399558.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK424399558.GetFolder

function TK424399558.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50FD36A400E9';
end;//TK424399558.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK424399558.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
