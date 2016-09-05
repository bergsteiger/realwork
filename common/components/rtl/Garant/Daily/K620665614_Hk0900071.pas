unit K620665614_Hk0900071;
 {* [RequestLink:620665614] }

// ������: "w:\common\components\rtl\Garant\Daily\K620665614_Hk0900071.pas"
// ���������: "TestCase"
// ������� ������: "K620665614_Hk0900071" MUID: (56FA6D77032E)
// ��� ����: "TK620665614_Hk0900071"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620665614_Hk0900071 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620665614] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK620665614_Hk0900071
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56FA6D77032Eimpl_uses*
 //#UC END# *56FA6D77032Eimpl_uses*
;

function TK620665614_Hk0900071.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK620665614_Hk0900071.GetFolder

function TK620665614_Hk0900071.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56FA6D77032E';
end;//TK620665614_Hk0900071.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620665614_Hk0900071.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
