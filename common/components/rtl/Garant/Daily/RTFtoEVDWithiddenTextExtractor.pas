unit RTFtoEVDWithiddenTextExtractor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/RTFtoEVDWithiddenTextExtractor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::RTF::RTFtoEVDWithiddenTextExtractor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  RTFtoEVDWriterTest,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TRTFtoEVDWithiddenTextExtractor = {abstract} class(TRTFtoEVDWriterTest)
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TRTFtoEVDWithiddenTextExtractor
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  dd_lcHiddenTextExtractor,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TRTFtoEVDWithiddenTextExtractor

procedure TRTFtoEVDWithiddenTextExtractor.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_538C2F3502BB_var*
//#UC END# *4C07BCBE01F2_538C2F3502BB_var*
begin
//#UC START# *4C07BCBE01F2_538C2F3502BB_impl*
 Tdd_lcHiddenTextExtractor.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_538C2F3502BB_impl*
end;//TRTFtoEVDWithiddenTextExtractor.SetFilters

function TRTFtoEVDWithiddenTextExtractor.GetFolder: AnsiString;
 {-}
begin
 Result := 'RTF';
end;//TRTFtoEVDWithiddenTextExtractor.GetFolder

function TRTFtoEVDWithiddenTextExtractor.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '538C2F3502BB';
end;//TRTFtoEVDWithiddenTextExtractor.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.