unit BadEVDTest;

// ������: "w:\common\components\rtl\Garant\Daily\BadEVDTest.pas"
// ���������: "TestCase"
// ������� ������: "TBadEVDTest" MUID: (53BC0D3900DF)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
 , l3Variant
;

type
 TBadEVDTest = {abstract} class(TEVDtoEVDWriterTest)
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TBadEVDTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evdBadEVDToEmptyDocumentTranslator
 , TestFrameWork
;

procedure TBadEVDTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_53BC0D3900DF_var*
//#UC END# *4C07BCBE01F2_53BC0D3900DF_var*
begin
//#UC START# *4C07BCBE01F2_53BC0D3900DF_impl*
 TevdBadEVDToEmptyDocumentTranslator.SetTo(theGenerator, nil, 0);
//#UC END# *4C07BCBE01F2_53BC0D3900DF_impl*
end;//TBadEVDTest.SetFilters

function TBadEVDTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'BadEVD';
end;//TBadEVDTest.GetFolder

function TBadEVDTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53BC0D3900DF';
end;//TBadEVDTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
