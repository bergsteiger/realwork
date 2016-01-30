unit RTFtoEVDWithiddenTextExtractor;

// Модуль: "w:\common\components\rtl\Garant\Daily\RTFtoEVDWithiddenTextExtractor.pas"
// Стереотип: "TestCase"

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
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
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
 {* Папка в которую входит тест }
begin
 Result := 'RTF';
end;//TRTFtoEVDWithiddenTextExtractor.GetFolder

function TRTFtoEVDWithiddenTextExtractor.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '538C2F3502BB';
end;//TRTFtoEVDWithiddenTextExtractor.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
