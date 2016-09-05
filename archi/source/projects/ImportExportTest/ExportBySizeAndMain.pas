unit ExportBySizeAndMain;
 {* Экспорт, разделённый по размеру и мейну (мейн - в шаблонах имён файлов) }

// Модуль: "w:\archi\source\projects\ImportExportTest\ExportBySizeAndMain.pas"
// Стереотип: "TestCase"
// Элемент модели: "ExportBySizeAndMain" MUID: (55FFF13302B8)
// Имя типа: "TExportBySizeAndMain"

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportBySizeAndMain = class(TExportPipeTestPrim)
  {* Экспорт, разделённый по размеру и мейну (мейн - в шаблонах имён файлов) }
  protected
   procedure TuneExportPipe; override;
    {* Процедура настройки трубы. Метод для перекрытия в потомках. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TExportBySizeAndMain
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
 , ddPipeOutInterfaces
 , l3Base
 //#UC START# *55FFF13302B8impl_uses*
 //#UC END# *55FFF13302B8impl_uses*
;

procedure TExportBySizeAndMain.TuneExportPipe;
 {* Процедура настройки трубы. Метод для перекрытия в потомках. }
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
 {* Папка в которую входит тест }
begin
 Result := 'ExportPipeTests';
end;//TExportBySizeAndMain.GetFolder

function TExportBySizeAndMain.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55FFF13302B8';
end;//TExportBySizeAndMain.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TExportBySizeAndMain.Suite);
{$IfEnd} // Defined(nsTest)

end.
