unit ExportToSeparateNSRTest;
 {* Экспорт в NSRC, разделённые по топикам. }

// Модуль: "w:\archi\source\projects\ImportExportTest\ExportToSeparateNSRTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "ExportToSeparateNSRTest" MUID: (55F28FE60235)
// Имя типа: "TExportToSeparateNSRTest"

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportToSeparateNSRTest = class(TExportPipeTestPrim)
  {* Экспорт в NSRC, разделённые по топикам. }
  protected
   procedure TuneExportPipe; override;
    {* Процедура настройки трубы. Метод для перекрытия в потомках. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TExportToSeparateNSRTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
 , ddPipeOutInterfaces
 , l3Base
;

procedure TExportToSeparateNSRTest.TuneExportPipe;
 {* Процедура настройки трубы. Метод для перекрытия в потомках. }
//#UC START# *55EEA16603AE_55F28FE60235_var*
//#UC END# *55EEA16603AE_55F28FE60235_var*
begin
//#UC START# *55EEA16603AE_55F28FE60235_impl*
 Pipe.AllPartsDivideBy([edbTopic]);
//#UC END# *55EEA16603AE_55F28FE60235_impl*
end;//TExportToSeparateNSRTest.TuneExportPipe

function TExportToSeparateNSRTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ExportPipeTests';
end;//TExportToSeparateNSRTest.GetFolder

function TExportToSeparateNSRTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55F28FE60235';
end;//TExportToSeparateNSRTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TExportToSeparateNSRTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
