unit EVDtoHTMLTest;

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoHTMLTest.pas"
// ���������: "TestCase"
// ������� ������: "EVDtoHTMLTest" MUID: (516E734901D3)
// ��� ����: "TEVDtoHTMLTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWriterTest
;

type
 TEVDtoHTMLTest = {abstract} class(TEVDtoHTMLWriterTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  published
   procedure DoIt;
 end;//TEVDtoHTMLTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TEVDtoHTMLTest.DoIt;
//#UC START# *516E73710182_516E734901D3_var*
//#UC END# *516E73710182_516E734901D3_var*
begin
//#UC START# *516E73710182_516E734901D3_impl*
 EVDtoHTML(KPage + '.evd');
//#UC END# *516E73710182_516E734901D3_impl*
end;//TEVDtoHTMLTest.DoIt

function TEVDtoHTMLTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'HTML';
end;//TEVDtoHTMLTest.GetFolder

function TEVDtoHTMLTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '516E734901D3';
end;//TEVDtoHTMLTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
