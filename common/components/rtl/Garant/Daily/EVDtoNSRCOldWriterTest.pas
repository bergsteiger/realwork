unit EVDtoNSRCOldWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/EVDtoNSRCOldWriterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::TEVDtoNSRCOldWriterTest
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
 TEVDtoNSRCOldWriterTest = {abstract} class(TEVDtoNSRCWriterTest)
 protected
 // realized methods
   function IsNSRCPlus: Boolean; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoNSRCOldWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoNSRCOldWriterTest

function TEVDtoNSRCOldWriterTest.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_4B8546940034_var*
//#UC END# *4B8545CC03D2_4B8546940034_var*
begin
//#UC START# *4B8545CC03D2_4B8546940034_impl*
 Result := false;
//#UC END# *4B8545CC03D2_4B8546940034_impl*
end;//TEVDtoNSRCOldWriterTest.IsNSRCPlus

function TEVDtoNSRCOldWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TEVDtoNSRCOldWriterTest.GetFolder

function TEVDtoNSRCOldWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B8546940034';
end;//TEVDtoNSRCOldWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.