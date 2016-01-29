unit ExportSeparatedBySizeTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SimpleTests"
// Модуль: "W:/archi/source/projects/ImportExportTest/ExportSeparatedBySizeTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$ImportExprortTest::SimpleTests::ExportPipeTests::ExportSeparatedBySizeTest
//
// Экспорт в NSRC, разделённые по размеру с помощью свойства DivideBy
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
 TExportSeparatedBySizeTest = class(TExportPipeTestPrim)
  {* Экспорт в NSRC, разделённые по размеру с помощью свойства DivideBy }
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
 end;//TExportSeparatedBySizeTest
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

// start class TExportSeparatedBySizeTest

procedure TExportSeparatedBySizeTest.TuneExportPipe;
//#UC START# *55EEA16603AE_55FFA0650118_var*
//#UC END# *55EEA16603AE_55FFA0650118_var*
begin
//#UC START# *55EEA16603AE_55FFA0650118_impl*
 Pipe.AllPartsDivideBy([edbSize]);
 Pipe.OutputFileSize := 4096;
//#UC END# *55EEA16603AE_55FFA0650118_impl*
end;//TExportSeparatedBySizeTest.TuneExportPipe

function TExportSeparatedBySizeTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'ExportPipeTests';
end;//TExportSeparatedBySizeTest.GetFolder

function TExportSeparatedBySizeTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55FFA0650118';
end;//TExportSeparatedBySizeTest.GetModelElementGUID

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TExportSeparatedBySizeTest.Suite);

end.