unit DOCtoEVDWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/DOCtoEVDWriterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::RTF::DOCtoEVDWriterTest
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
  RTFReaderTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TDOCtoEVDWriterTest = {abstract} class(TRTFReaderTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TDOCtoEVDWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TDOCtoEVDWriterTest

procedure TDOCtoEVDWriterTest.DoIt;
//#UC START# *514C0F5E0247_514C0F2903BB_var*
//#UC END# *514C0F5E0247_514C0F2903BB_var*
begin
//#UC START# *514C0F5E0247_514C0F2903BB_impl*
 RTFtoEVD(KPage + '.doc');
//#UC END# *514C0F5E0247_514C0F2903BB_impl*
end;//TDOCtoEVDWriterTest.DoIt

function TDOCtoEVDWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'RTF';
end;//TDOCtoEVDWriterTest.GetFolder

function TDOCtoEVDWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '514C0F2903BB';
end;//TDOCtoEVDWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.