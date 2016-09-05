unit K620665614_B20410989;
 {* [RequestLink:620665614] }

// ������: "w:\common\components\rtl\Garant\Daily\K620665614_B20410989.pas"
// ���������: "TestCase"
// ������� ������: "K620665614_B20410989" MUID: (56FA6CCB0243)
// ��� ����: "TK620665614_B20410989"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620665614_B20410989 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620665614] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620665614_B20410989
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56FA6CCB0243impl_uses*
 //#UC END# *56FA6CCB0243impl_uses*
;

function TK620665614_B20410989.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620665614_B20410989.GetFolder

function TK620665614_B20410989.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56FA6CCB0243';
end;//TK620665614_B20410989.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620665614_B20410989.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
