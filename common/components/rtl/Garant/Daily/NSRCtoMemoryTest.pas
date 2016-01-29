unit NSRCtoMemoryTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/NSRCtoMemoryTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::NSRCtoMemoryTest
//
// Тест чтения NSRC в память
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
 TNSRCtoMemoryTest = {abstract} class(TNSRCWriterTest)
  {* Тест чтения NSRC в память }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TNSRCtoMemoryTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TNSRCtoMemoryTest

procedure TNSRCtoMemoryTest.DoIt;
//#UC START# *4B8547F30147_4B8549760232_var*
//#UC END# *4B8547F30147_4B8549760232_var*
begin
//#UC START# *4B8547F30147_4B8549760232_impl*
 NSRCtoMemory(KPage + '.nsr');
//#UC END# *4B8547F30147_4B8549760232_impl*
end;//TNSRCtoMemoryTest.DoIt

function TNSRCtoMemoryTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TNSRCtoMemoryTest.GetFolder

function TNSRCtoMemoryTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B8549760232';
end;//TNSRCtoMemoryTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.