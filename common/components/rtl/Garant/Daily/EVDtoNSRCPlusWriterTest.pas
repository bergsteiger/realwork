unit EVDtoNSRCPlusWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/EVDtoNSRCPlusWriterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::TEVDtoNSRCPlusWriterTest
//
// Тест записи в NSRC+
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
 TEVDtoNSRCPlusWriterTest = {abstract} class(TEVDtoNSRCWriterTest)
  {* Тест записи в NSRC+ }
 protected
 // realized methods
   function IsNSRCPlus: Boolean; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoNSRCPlusWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoNSRCPlusWriterTest

function TEVDtoNSRCPlusWriterTest.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_4B853E7501DF_var*
//#UC END# *4B8545CC03D2_4B853E7501DF_var*
begin
//#UC START# *4B8545CC03D2_4B853E7501DF_impl*
 Result := true;
//#UC END# *4B8545CC03D2_4B853E7501DF_impl*
end;//TEVDtoNSRCPlusWriterTest.IsNSRCPlus

function TEVDtoNSRCPlusWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TEVDtoNSRCPlusWriterTest.GetFolder

function TEVDtoNSRCPlusWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B853E7501DF';
end;//TEVDtoNSRCPlusWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.