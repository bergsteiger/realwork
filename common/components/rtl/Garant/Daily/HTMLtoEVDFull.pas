unit HTMLtoEVDFull;

// ������: "w:\common\components\rtl\Garant\Daily\HTMLtoEVDFull.pas"
// ���������: "TestCase"
// ������� ������: "HTMLtoEVDFull" MUID: (56D6CCB60125)
// ��� ����: "THTMLtoEVDFull"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
 , ddHTMLReader
;

type
 THTMLtoEVDFull = {abstract} class(THTMLtoEVDTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   procedure TuningReader(aHTMLReader: TddHTMLReader); override;
 end;//THTMLtoEVDFull
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function THTMLtoEVDFull.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'HTML';
end;//THTMLtoEVDFull.GetFolder

function THTMLtoEVDFull.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56D6CCB60125';
end;//THTMLtoEVDFull.GetModelElementGUID

procedure THTMLtoEVDFull.TuningReader(aHTMLReader: TddHTMLReader);
//#UC START# *56A613A30375_56D6CCB60125_var*
//#UC END# *56A613A30375_56D6CCB60125_var*
begin
//#UC START# *56A613A30375_56D6CCB60125_impl*
 aHTMLReader.Lite := False;
//#UC END# *56A613A30375_56D6CCB60125_impl*
end;//THTMLtoEVDFull.TuningReader
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
