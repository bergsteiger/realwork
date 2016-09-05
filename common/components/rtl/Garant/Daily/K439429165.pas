unit K439429165;
 {* [Requestlink:439429165] }

// ������: "w:\common\components\rtl\Garant\Daily\K439429165.pas"
// ���������: "TestCase"
// ������� ������: "K439429165" MUID: (514850F50232)
// ��� ����: "TK439429165"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK439429165 = class(TEVDtoNSRCPlusWriterTest)
  {* [Requestlink:439429165] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK439429165
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *514850F50232impl_uses*
 //#UC END# *514850F50232impl_uses*
;

function TK439429165.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK439429165.GetFolder

function TK439429165.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '514850F50232';
end;//TK439429165.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK439429165.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
