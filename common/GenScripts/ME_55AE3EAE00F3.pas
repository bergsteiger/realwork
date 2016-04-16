unit L3XMLWriterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\L3XMLWriterTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "L3XMLWriterTest" MUID: (55AE3EAE00F3)
// Имя типа: "TL3XMLWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TL3XMLWriterTest = class({$If NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  private
   procedure BuildXML;
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TL3XMLWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Interfaces
 , l3XMLWriter
 , SysUtils
 , l3Filer
 , l3Types
 , TestFrameWork
;

{$If NOT Defined(NotTunedDUnit)}
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
 {* Папка в которую входит тест }
begin
 Result := 'XML';
end;//TL3XMLWriterTest.GetFolder

function TL3XMLWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55AE3EAE00F3';
end;//TL3XMLWriterTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TL3XMLWriterTest.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
