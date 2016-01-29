unit EVDtoXMLWiterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/EVDtoXMLWiterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::XML::EVDtoXMLWiterTest
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
  XMLWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoXMLWiterTest = {abstract} class(TXMLWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TEVDtoXMLWiterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoXMLWiterTest

procedure TEVDtoXMLWiterTest.DoIt;
//#UC START# *5036347502D4_503632E400D2_var*
//#UC END# *5036347502D4_503632E400D2_var*
begin
//#UC START# *5036347502D4_503632E400D2_impl*
 EVDtoXML(KPage + '.evd');
//#UC END# *5036347502D4_503632E400D2_impl*
end;//TEVDtoXMLWiterTest.DoIt

function TEVDtoXMLWiterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'XML';
end;//TEVDtoXMLWiterTest.GetFolder

function TEVDtoXMLWiterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '503632E400D2';
end;//TEVDtoXMLWiterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.