unit K253668417;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K253668417.pas"
// Начат: 16.02.2011 17:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K253668417
//
// {RequestLink:253668417}
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
 TK253668417 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:253668417] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetEnablePictures: Boolean; override;
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK253668417
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK253668417

function TK253668417.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK253668417.GetFolder

function TK253668417.GetEnablePictures: Boolean;
//#UC START# *4D5BE2F500AD_4D5BE28703A0_var*
//#UC END# *4D5BE2F500AD_4D5BE28703A0_var*
begin
//#UC START# *4D5BE2F500AD_4D5BE28703A0_impl*
 Result := true;
//#UC END# *4D5BE2F500AD_4D5BE28703A0_impl*
end;//TK253668417.GetEnablePictures

function TK253668417.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D5BE28703A0';
end;//TK253668417.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK253668417.Suite);

end.