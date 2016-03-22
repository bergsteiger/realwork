unit ExportSeparatedBySizeTest;
 {* Экспорт в NSRC, разделённые по размеру с помощью свойства DivideBy }

// Модуль: "w:\archi\source\projects\ImportExportTest\ExportSeparatedBySizeTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "ExportSeparatedBySizeTest" MUID: (55FFA0650118)
// Имя типа: "TExportSeparatedBySizeTest"

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportSeparatedBySizeTest = class(TExportPipeTestPrim)
  {* Экспорт в NSRC, разделённые по размеру с помощью свойства DivideBy }
  protected
   procedure TuneExportPipe; override;
    {* Процедура настройки трубы. Метод для перекрытия в потомках. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TExportSeparatedBySizeTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
 , ddPipeOutInterfaces
 , l3Base
;

procedure TExportSeparatedBySizeTest.TuneExportPipe;
 {* Процедура настройки трубы. Метод для перекрытия в потомках. }
//#UC START# *55EEA16603AE_55FFA0650118_var*
//#UC END# *55EEA16603AE_55FFA0650118_var*
begin
//#UC START# *55EEA16603AE_55FFA0650118_impl*
 Pipe.AllPartsDivideBy([edbSize]);
 Pipe.OutputFileSize := 4096;
//#UC END# *55EEA16603AE_55FFA0650118_impl*
end;//TExportSeparatedBySizeTest.TuneExportPipe

function TExportSeparatedBySizeTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ExportPipeTests';
end;//TExportSeparatedBySizeTest.GetFolder

function TExportSeparatedBySizeTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55FFA0650118';
end;//TExportSeparatedBySizeTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TExportSeparatedBySizeTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
