unit K434763341;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K434763341.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.8::K434763341
//
// {RequestLink:434763341}
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
  RTFtoEVDWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK434763341 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:434763341] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function TreatExceptionAsSuccess: Boolean; override;
 end;//TK434763341
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK434763341

function TK434763341.GetFolder: AnsiString;
 {-}
begin
 Result := '7.8';
end;//TK434763341.GetFolder

function TK434763341.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '514034BD01D7';
end;//TK434763341.GetModelElementGUID

function TK434763341.TreatExceptionAsSuccess: Boolean;
//#UC START# *51406117007F_514034BD01D7_var*
//#UC END# *51406117007F_514034BD01D7_var*
begin
//#UC START# *51406117007F_514034BD01D7_impl*
 Result := True;
//#UC END# *51406117007F_514034BD01D7_impl*
end;//TK434763341.TreatExceptionAsSuccess

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK434763341.Suite);

end.