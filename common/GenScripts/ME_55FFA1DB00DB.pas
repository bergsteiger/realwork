unit ExportByMainRelNamedTest;
 {* Экспорт документов в один NSRC со справками, разделённые по мейнам с помощью шаблона имени. (DivideBy = divNone) }

// Модуль: "w:\archi\source\projects\ImportExportTest\ExportByMainRelNamedTest.pas"
// Стереотип: "TestCase"

{$Include ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportByMainRelNamedTest = class(TExportPipeTestPrim)
  {* Экспорт документов в один NSRC со справками, разделённые по мейнам с помощью шаблона имени. (DivideBy = divNone) }
  protected
   procedure TuneExportPipe; override;
    {* Процедура настройки трубы. Метод для перекрытия в потомках. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TExportByMainRelNamedTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TExportByMainRelNamedTest.TuneExportPipe;
 {* Процедура настройки трубы. Метод для перекрытия в потомках. }
//#UC START# *55EEA16603AE_55FFA1DB00DB_var*
//#UC END# *55EEA16603AE_55FFA1DB00DB_var*
begin
//#UC START# *55EEA16603AE_55FFA1DB00DB_impl*
 Pipe.AllPartsDivideBy([]);
 Pipe.FileMask[edpReference] := l3CStr('rel_%main%');
//#UC END# *55EEA16603AE_55FFA1DB00DB_impl*
end;//TExportByMainRelNamedTest.TuneExportPipe

function TExportByMainRelNamedTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ExportPipeTests';
end;//TExportByMainRelNamedTest.GetFolder

function TExportByMainRelNamedTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55FFA1DB00DB';
end;//TExportByMainRelNamedTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TExportByMainRelNamedTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
