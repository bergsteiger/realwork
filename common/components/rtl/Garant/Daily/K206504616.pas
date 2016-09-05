unit K206504616;
 {* [RequestLink:206504616] }

// ������: "w:\common\components\rtl\Garant\Daily\K206504616.pas"
// ���������: "TestCase"
// ������� ������: "K206504616" MUID: (4BD5703301E8)
// ��� ����: "TK206504616"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK206504616 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:206504616] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK206504616
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4BD5703301E8impl_uses*
 //#UC END# *4BD5703301E8impl_uses*
;

function TK206504616.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK206504616.GetFolder

function TK206504616.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BD5703301E8';
end;//TK206504616.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK206504616.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
