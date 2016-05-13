unit EVDtoHTMLwoCSS;

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoHTMLwoCSS.pas"
// ���������: "TestCase"
// ������� ������: "EVDtoHTMLwoCSS" MUID: (573591C90195)
// ��� ����: "TEVDtoHTMLwoCSS"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLTest
 , ddHTMLWriter
;

type
 TEVDtoHTMLwoCSS = {abstract} class(TEVDtoHTMLTest)
  protected
   procedure TuningHTMLGenerator(aHTMLReader: TddHTMLGenerator); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDtoHTMLwoCSS
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TEVDtoHTMLwoCSS.TuningHTMLGenerator(aHTMLReader: TddHTMLGenerator);
//#UC START# *56D9300D018D_573591C90195_var*
//#UC END# *56D9300D018D_573591C90195_var*
begin
//#UC START# *56D9300D018D_573591C90195_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D9300D018D_573591C90195_impl*
end;//TEVDtoHTMLwoCSS.TuningHTMLGenerator

function TEVDtoHTMLwoCSS.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'HTML';
end;//TEVDtoHTMLwoCSS.GetFolder

function TEVDtoHTMLwoCSS.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '573591C90195';
end;//TEVDtoHTMLwoCSS.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
