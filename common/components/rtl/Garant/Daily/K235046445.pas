unit K235046445;
 {* [RequestLink:235046445] }

// ������: "w:\common\components\rtl\Garant\Daily\K235046445.pas"
// ���������: "TestCase"
// ������� ������: "K235046445" MUID: (4C8E144B0381)
// ��� ����: "TK235046445"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK235046445 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:235046445] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235046445
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4C8E144B0381impl_uses*
 //#UC END# *4C8E144B0381impl_uses*
;

function TK235046445.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235046445.GetFolder

function TK235046445.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C8E144B0381';
end;//TK235046445.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235046445.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
