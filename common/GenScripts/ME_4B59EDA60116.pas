unit StyleCtoStyleJTest;
 {* [$180060974] }

// ������: "w:\common\components\rtl\Garant\Daily\StyleCtoStyleJTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCWriterTest
;

type
 TStyleCtoStyleJTest = class(TNSRCWriterTest)
  {* [$180060974] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  public
   procedure DoIt;
   procedure ToOldNSRC;
 end;//TStyleCtoStyleJTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TStyleCtoStyleJTest.DoIt;
//#UC START# *4B59EDC70252_4B59EDA60116_var*
//#UC END# *4B59EDC70252_4B59EDA60116_var*
begin
//#UC START# *4B59EDC70252_4B59EDA60116_impl*
 NSRCtoNSRC('6.nsr', true);
//#UC END# *4B59EDC70252_4B59EDA60116_impl*
end;//TStyleCtoStyleJTest.DoIt

procedure TStyleCtoStyleJTest.ToOldNSRC;
//#UC START# *4B59F9D70110_4B59EDA60116_var*
//#UC END# *4B59F9D70110_4B59EDA60116_var*
begin
//#UC START# *4B59F9D70110_4B59EDA60116_impl*
 NSRCtoNSRC('6.nsr', false);
//#UC END# *4B59F9D70110_4B59EDA60116_impl*
end;//TStyleCtoStyleJTest.ToOldNSRC

function TStyleCtoStyleJTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TStyleCtoStyleJTest.GetFolder

function TStyleCtoStyleJTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4B59EDA60116';
end;//TStyleCtoStyleJTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TStyleCtoStyleJTest.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
