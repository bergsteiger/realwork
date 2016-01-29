unit K219119831;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K219119831.pas"
// Начат: 18.06.2010
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K219119831
//
// {RequestLink:219119831}
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
  EVDtoEVDWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK219119831 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:219119831] }
 protected
 // overridden protected methods
   function UseFullEVDReader: Boolean; override;
     {* Использовать ли ПОЛНЫЙ evdReader (с чтением текста тоже) }
   function DisableParserLog: Boolean; override;
     {* Запретить парсеру выводить в лог }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK219119831
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK219119831

function TK219119831.UseFullEVDReader: Boolean;
//#UC START# *4C1B2B0203A2_4C1B2A4701FC_var*
//#UC END# *4C1B2B0203A2_4C1B2A4701FC_var*
begin
//#UC START# *4C1B2B0203A2_4C1B2A4701FC_impl*
 Result := true;
//#UC END# *4C1B2B0203A2_4C1B2A4701FC_impl*
end;//TK219119831.UseFullEVDReader

function TK219119831.DisableParserLog: Boolean;
//#UC START# *4C1B47BA03AC_4C1B2A4701FC_var*
//#UC END# *4C1B47BA03AC_4C1B2A4701FC_var*
begin
//#UC START# *4C1B47BA03AC_4C1B2A4701FC_impl*
 Result := true;
//#UC END# *4C1B47BA03AC_4C1B2A4701FC_impl*
end;//TK219119831.DisableParserLog

function TK219119831.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK219119831.GetFolder

function TK219119831.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C1B2A4701FC';
end;//TK219119831.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK219119831.Suite);

end.