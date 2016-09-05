unit K598131905;
 {* [Requestlink:598131905] }

// ������: "w:\common\components\rtl\Garant\Daily\K598131905.pas"
// ���������: "TestCase"
// ������� ������: "K598131905" MUID: (553F694701F4)
// ��� ����: "TK598131905"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK598131905 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:598131905] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK598131905
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *553F694701F4impl_uses*
 //#UC END# *553F694701F4impl_uses*
;

function TK598131905.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK598131905.GetFolder

function TK598131905.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '553F694701F4';
end;//TK598131905.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK598131905.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
