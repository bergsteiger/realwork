unit EVDtoRTFWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/EVDtoRTFWriterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::RTF::EVDtoRTFWriterTest
//
// Тест преобразования EVD в RTF
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
  RTFWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoRTFWriterTest = {abstract} class(TRTFWriterTest)
  {* Тест преобразования EVD в RTF }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TEVDtoRTFWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoRTFWriterTest

procedure TEVDtoRTFWriterTest.DoIt;
//#UC START# *4BACF19600F5_4BACF173038C_var*
//#UC END# *4BACF19600F5_4BACF173038C_var*
begin
//#UC START# *4BACF19600F5_4BACF173038C_impl*
 EVDtoRTF(KPage + '.evd', true);
//#UC END# *4BACF19600F5_4BACF173038C_impl*
end;//TEVDtoRTFWriterTest.DoIt

function TEVDtoRTFWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'RTF';
end;//TEVDtoRTFWriterTest.GetFolder

function TEVDtoRTFWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BACF173038C';
end;//TEVDtoRTFWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.