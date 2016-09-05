unit K453164226;
 {* [Requestlink:453164226] }

// ������: "w:\common\components\rtl\Garant\Daily\K453164226.pas"
// ���������: "TestCase"
// ������� ������: "K453164226" MUID: (51962A2800DD)
// ��� ����: "TK453164226"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK453164226 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:453164226] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK453164226
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *51962A2800DDimpl_uses*
 //#UC END# *51962A2800DDimpl_uses*
;

function TK453164226.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK453164226.GetFolder

function TK453164226.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51962A2800DD';
end;//TK453164226.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK453164226.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
