unit K589860215;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K589860215.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.11::K589860215
//
// {Requestlink:589860215}
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
 TK589860215 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:589860215] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetEnablePictures: Boolean; override;
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK589860215
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK589860215

function TK589860215.GetFolder: AnsiString;
 {-}
begin
 Result := '7.11';
end;//TK589860215.GetFolder

function TK589860215.GetEnablePictures: Boolean;
//#UC START# *4D5BE2F500AD_54EECC4D02C8_var*
//#UC END# *4D5BE2F500AD_54EECC4D02C8_var*
begin
//#UC START# *4D5BE2F500AD_54EECC4D02C8_impl*
 Result := True;
//#UC END# *4D5BE2F500AD_54EECC4D02C8_impl*
end;//TK589860215.GetEnablePictures

function TK589860215.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '54EECC4D02C8';
end;//TK589860215.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK589860215.Suite);

end.