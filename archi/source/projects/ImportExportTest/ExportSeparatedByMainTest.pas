unit ExportSeparatedByMainTest;
 {* Экспорт в NSRC, разделённые по мейну, с помощью свойства DivideBy }

// Модуль: "w:\archi\source\projects\ImportExportTest\ExportSeparatedByMainTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "ExportSeparatedByMainTest" MUID: (55FFA0290014)
// Имя типа: "TExportSeparatedByMainTest"

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportSeparatedByMainTest = class(TExportPipeTestPrim)
  {* Экспорт в NSRC, разделённые по мейну, с помощью свойства DivideBy }
  protected
   procedure TuneExportPipe; override;
    {* Процедура настройки трубы. Метод для перекрытия в потомках. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TExportSeparatedByMainTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
 , ddPipeOutInterfaces
 , l3Base
 //#UC START# *55FFA0290014impl_uses*
 //#UC END# *55FFA0290014impl_uses*
;

procedure TExportSeparatedByMainTest.TuneExportPipe;
 {* Процедура настройки трубы. Метод для перекрытия в потомках. }
//#UC START# *55EEA16603AE_55FFA0290014_var*
//#UC END# *55EEA16603AE_55FFA0290014_var*
begin
//#UC START# *55EEA16603AE_55FFA0290014_impl*
 Pipe.AllPartsDivideBy([edbAccGroup]);
//#UC END# *55EEA16603AE_55FFA0290014_impl*
end;//TExportSeparatedByMainTest.TuneExportPipe

function TExportSeparatedByMainTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ExportPipeTests';
end;//TExportSeparatedByMainTest.GetFolder

function TExportSeparatedByMainTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55FFA0290014';
end;//TExportSeparatedByMainTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TExportSeparatedByMainTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
