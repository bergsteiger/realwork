unit ExportBySizeAndMain;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SimpleTests"
// Модуль: "W:/archi/source/projects/ImportExportTest/ExportBySizeAndMain.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$ImportExprortTest::SimpleTests::ExportPipeTests::ExportBySizeAndMain
//
// Экспорт, разделённый по размеру и мейну (мейн - в шаблонах имён файлов)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include W:\archi\source\projects\ImportExportTest.inc}

interface

{$If defined(nsTest)}
uses
  ExportPipeTestPrim
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TExportBySizeAndMain = class(TExportPipeTestPrim)
  {* Экспорт, разделённый по размеру и мейну (мейн - в шаблонах имён файлов) }
 protected
 // realized methods
   procedure TuneExportPipe; override;
     {* Процедура настройки трубы. Метод для перекрытия в потомках. }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TExportBySizeAndMain
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  TestFrameWork,
  ddPipeOutInterfaces,
  l3Base
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TExportBySizeAndMain

procedure TExportBySizeAndMain.TuneExportPipe;
//#UC START# *55EEA16603AE_55FFF13302B8_var*
//#UC END# *55EEA16603AE_55FFF13302B8_var*
begin
//#UC START# *55EEA16603AE_55FFF13302B8_impl*
 Pipe.AllPartsDivideBy([edbSize]);
 Pipe.OutputFileSize := 4096;
 Pipe.FileMask[edpReference] := l3CStr('rel_%main%');
 Pipe.FileMask[edpDocument] := l3CStr('doc_%main%');
//#UC END# *55EEA16603AE_55FFF13302B8_impl*
end;//TExportBySizeAndMain.TuneExportPipe

function TExportBySizeAndMain.GetFolder: AnsiString;
 {-}
begin
 Result := 'ExportPipeTests';
end;//TExportBySizeAndMain.GetFolder

function TExportBySizeAndMain.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55FFF13302B8';
end;//TExportBySizeAndMain.GetModelElementGUID

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TExportBySizeAndMain.Suite);

end.