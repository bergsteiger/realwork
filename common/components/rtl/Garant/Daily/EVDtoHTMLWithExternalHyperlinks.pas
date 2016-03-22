unit EVDtoHTMLWithExternalHyperlinks;

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoHTMLWithExternalHyperlinks.pas"
// ���������: "TestCase"
// ������� ������: "EVDtoHTMLWithExternalHyperlinks" MUID: (56D9305C01DD)
// ��� ����: "TEVDtoHTMLWithExternalHyperlinks"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLTest
 , ddHTMLWriter
;

type
 TEVDtoHTMLWithExternalHyperlinks = {abstract} class(TEVDtoHTMLTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   procedure TuningHTMLGenerator(aHTMLReader: TddHTMLGenerator); override;
 end;//TEVDtoHTMLWithExternalHyperlinks
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TEVDtoHTMLWithExternalHyperlinks.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'HTML';
end;//TEVDtoHTMLWithExternalHyperlinks.GetFolder

function TEVDtoHTMLWithExternalHyperlinks.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56D9305C01DD';
end;//TEVDtoHTMLWithExternalHyperlinks.GetModelElementGUID

procedure TEVDtoHTMLWithExternalHyperlinks.TuningHTMLGenerator(aHTMLReader: TddHTMLGenerator);
//#UC START# *56D9300D018D_56D9305C01DD_var*
//#UC END# *56D9300D018D_56D9305C01DD_var*
begin
//#UC START# *56D9300D018D_56D9305C01DD_impl*
 aHTMLReader.UseExternalLinks := True;
 aHTMLReader.WriteFirstHyperlink := True;
//#UC END# *56D9300D018D_56D9305C01DD_impl*
end;//TEVDtoHTMLWithExternalHyperlinks.TuningHTMLGenerator
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
