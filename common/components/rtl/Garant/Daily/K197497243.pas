unit K197497243;
 {* [$199590833]. }

// ������: "w:\common\components\rtl\Garant\Daily\K197497243.pas"
// ���������: "TestCase"
// ������� ������: "K197497243" MUID: (4BAC89240185)
// ��� ����: "TK197497243"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK197497243 = class(TEVDtoBothNSRCWriterTest)
  {* [$199590833]. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK197497243
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4BAC89240185impl_uses*
 //#UC END# *4BAC89240185impl_uses*
;

function TK197497243.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK197497243.GetFolder

function TK197497243.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BAC89240185';
end;//TK197497243.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK197497243.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
