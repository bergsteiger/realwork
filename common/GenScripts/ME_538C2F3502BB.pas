unit RTFtoEVDWithiddenTextExtractor;

// ������: "w:\common\components\rtl\Garant\Daily\RTFtoEVDWithiddenTextExtractor.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
 , l3Variant
;

type
 TRTFtoEVDWithiddenTextExtractor = {abstract} class(TRTFtoEVDWriterTest)
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TRTFtoEVDWithiddenTextExtractor
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , dd_lcHiddenTextExtractor
 , TestFrameWork
;

procedure TRTFtoEVDWithiddenTextExtractor.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_538C2F3502BB_var*
//#UC END# *4C07BCBE01F2_538C2F3502BB_var*
begin
//#UC START# *4C07BCBE01F2_538C2F3502BB_impl*
 Tdd_lcHiddenTextExtractor.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_538C2F3502BB_impl*
end;//TRTFtoEVDWithiddenTextExtractor.SetFilters

function TRTFtoEVDWithiddenTextExtractor.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'RTF';
end;//TRTFtoEVDWithiddenTextExtractor.GetFolder

function TRTFtoEVDWithiddenTextExtractor.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '538C2F3502BB';
end;//TRTFtoEVDWithiddenTextExtractor.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
