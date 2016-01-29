unit K260442347;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K260442347.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRC 7.7::K260442347
//
// [$260442347]
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
  EVDtoNSRCWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK260442347 = class(TEVDtoNSRCWriterTest)
  {* [$260442347] }
 protected
 // realized methods
   function IsNSRCPlus: Boolean; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK260442347
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK260442347

function TK260442347.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_4DB0266702AF_var*
//#UC END# *4B8545CC03D2_4DB0266702AF_var*
begin
//#UC START# *4B8545CC03D2_4DB0266702AF_impl*
 Result := False;
//#UC END# *4B8545CC03D2_4DB0266702AF_impl*
end;//TK260442347.IsNSRCPlus

function TK260442347.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRC 7.7';
end;//TK260442347.GetFolder

function TK260442347.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DB0266702AF';
end;//TK260442347.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK260442347.Suite);

end.