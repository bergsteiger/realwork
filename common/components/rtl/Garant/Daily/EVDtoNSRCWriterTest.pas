unit EVDtoNSRCWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/EVDtoNSRCWriterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::TEVDtoNSRCWriterTest
//
// Тест записи из EVD в NSRC
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
  NSRCWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoNSRCWriterTest = {abstract} class(TNSRCWriterTest)
  {* Тест записи из EVD в NSRC }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function IsNSRCPlus: Boolean; virtual; abstract;
 published
 // published methods
   procedure DoIt;
 end;//TEVDtoNSRCWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Except,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoNSRCWriterTest

procedure TEVDtoNSRCWriterTest.DoIt;
//#UC START# *4B853EA60332_4B85456C0154_var*
//#UC END# *4B853EA60332_4B85456C0154_var*
begin
//#UC START# *4B853EA60332_4B85456C0154_impl*
(* try*)
  EVDtoNSRC(KPage + '.evd', IsNSRCPlus);
(* except
  on E : El3BadPictureFormat do
   if not AcceptBadPictureFormat then
    raise;
 end;//try..except*)
//#UC END# *4B853EA60332_4B85456C0154_impl*
end;//TEVDtoNSRCWriterTest.DoIt

function TEVDtoNSRCWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TEVDtoNSRCWriterTest.GetFolder

function TEVDtoNSRCWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B85456C0154';
end;//TEVDtoNSRCWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.