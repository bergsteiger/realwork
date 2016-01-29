unit K532630317;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K532630317.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRC 7.7::K532630317
//
// {Requestlink:532630317}
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
 TK532630317 = class(TEVDtoNSRCWriterTest)
  {* [Requestlink:532630317] }
 protected
 // realized methods
   function IsNSRCPlus: Boolean; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK532630317
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK532630317

function TK532630317.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_5369D18401D2_var*
//#UC END# *4B8545CC03D2_5369D18401D2_var*
begin
//#UC START# *4B8545CC03D2_5369D18401D2_impl*
 Result := False;
//#UC END# *4B8545CC03D2_5369D18401D2_impl*
end;//TK532630317.IsNSRCPlus

function TK532630317.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRC 7.7';
end;//TK532630317.GetFolder

function TK532630317.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5369D18401D2';
end;//TK532630317.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK532630317.Suite);

end.