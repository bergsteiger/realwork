unit L3XMLWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/L3XMLWriterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::XML::L3XMLWriterTest
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
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TL3XMLWriterTest = class(TBaseTest)
 private
 // private methods
   procedure BuildXML;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TL3XMLWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Interfaces,
  l3XMLWriter,
  SysUtils,
  l3Filer,
  l3Types,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TL3XMLWriterTest

procedure TL3XMLWriterTest.BuildXML;
//#UC START# *55AE3F340080_55AE3EAE00F3_var*
var
 l_Filer: Tl3DOSFiler;
 l_FN : AnsiString;
 l_XML: Il3XMLWriter;
//#UC END# *55AE3F340080_55AE3EAE00F3_var*
begin
//#UC START# *55AE3F340080_55AE3EAE00F3_impl*
 l_FN := FileFromCurrent(ClassName+'_result.xml');
 l_Filer := Tl3DOSFiler.Make(l_FN, l3_fmWrite);
 try
  l_XML := Tl3XMLWriter.Make(l_Filer);
  try
   l_XML.Start;
   try
    l_XML.OpenLevel('data', 'attr="12345"');
    try
     l_XML.OpenLevel('element', 'xyz="5"');
      l_XML.PutData('Это строка, содержащая странные символы. <такие вот> и &');
     l_XML.CloseLevel;
     l_XML.OpenLevel('rows', 'some="15"');
      l_XML.OpenSubLevel('id="1"');
       l_XML.PutData('data string 1');
      l_XML.CloseLevel;
      l_XML.OpenSubLevel('id="2"');
       l_XML.PutData('data string 2');
      l_XML.CloseLevel;
      l_XML.OpenSubLevel('id="3"');
       l_XML.PutData('data string 3');
      l_XML.CloseLevel;
     l_XML.CloseLevel;
    finally
     l_XML.CloseLevel;
    end;
   finally
    l_XML.Finish;
   end;
  finally
   l_XML := nil;
  end;
 finally
  FreeAndNil(l_Filer);
 end;
 CheckWithEtalon(l_FN, #0);
//#UC END# *55AE3F340080_55AE3EAE00F3_impl*
end;//TL3XMLWriterTest.BuildXML

procedure TL3XMLWriterTest.DoIt;
//#UC START# *55AE76C10243_55AE3EAE00F3_var*
//#UC END# *55AE76C10243_55AE3EAE00F3_var*
begin
//#UC START# *55AE76C10243_55AE3EAE00F3_impl*
 BuildXML;
//#UC END# *55AE76C10243_55AE3EAE00F3_impl*
end;//TL3XMLWriterTest.DoIt

function TL3XMLWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'XML';
end;//TL3XMLWriterTest.GetFolder

function TL3XMLWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55AE3EAE00F3';
end;//TL3XMLWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TL3XMLWriterTest.Suite);

end.