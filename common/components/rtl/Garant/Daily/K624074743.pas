unit K624074743;
 {* [Requestlink:624074743] }

// ������: "w:\common\components\rtl\Garant\Daily\K624074743.pas"
// ���������: "TestCase"
// ������� ������: "K624074743" MUID: (575FF5110334)
// ��� ����: "TK624074743"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK624074743 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:624074743] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK624074743
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *575FF5110334impl_uses*
 //#UC END# *575FF5110334impl_uses*
;

function TK624074743.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK624074743.GetFolder

function TK624074743.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '575FF5110334';
end;//TK624074743.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK624074743.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
