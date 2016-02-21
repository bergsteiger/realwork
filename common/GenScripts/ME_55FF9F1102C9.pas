unit ExportToSingleNSRTest;
 {* Экспорт в один NSRC }

// Модуль: "w:\archi\source\projects\ImportExportTest\ExportToSingleNSRTest.pas"
// Стереотип: "TestCase"

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportToSingleNSRTest = class(TExportPipeTestPrim)
  {* Экспорт в один NSRC }
  protected
   procedure TuneExportPipe; override;
    {* Процедура настройки трубы. Метод для перекрытия в потомках. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TExportToSingleNSRTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
 , ddPipeOutInterfaces
 , l3Base
;

procedure TExportToSingleNSRTest.TuneExportPipe;
 {* Процедура настройки трубы. Метод для перекрытия в потомках. }
//#UC START# *55EEA16603AE_55FF9F1102C9_var*
//#UC END# *55EEA16603AE_55FF9F1102C9_var*
begin
//#UC START# *55EEA16603AE_55FF9F1102C9_impl*
 Pipe.AllPartsDivideBy([]);
//#UC END# *55EEA16603AE_55FF9F1102C9_impl*
end;//TExportToSingleNSRTest.TuneExportPipe

function TExportToSingleNSRTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ExportPipeTests';
end;//TExportToSingleNSRTest.GetFolder

function TExportToSingleNSRTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55FF9F1102C9';
end;//TExportToSingleNSRTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TExportToSingleNSRTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
