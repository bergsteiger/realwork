unit ExportByMainRelNamedTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SimpleTests"
// Модуль: "W:/archi/source/projects/ImportExportTest/ExportByMainRelNamedTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$ImportExprortTest::SimpleTests::ExportPipeTests::ExportByMainRelNamedTest
//
// Экспорт документов в один NSRC со справками, разделённые по мейнам с помощью шаблона имени.
// (DivideBy = divNone)
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
 TExportByMainRelNamedTest = class(TExportPipeTestPrim)
  {* Экспорт документов в один NSRC со справками, разделённые по мейнам с помощью шаблона имени. (DivideBy = divNone) }
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
 end;//TExportByMainRelNamedTest
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

// start class TExportByMainRelNamedTest

procedure TExportByMainRelNamedTest.TuneExportPipe;
//#UC START# *55EEA16603AE_55FFA1DB00DB_var*
//#UC END# *55EEA16603AE_55FFA1DB00DB_var*
begin
//#UC START# *55EEA16603AE_55FFA1DB00DB_impl*
 Pipe.AllPartsDivideBy([]);
 Pipe.FileMask[edpReference] := l3CStr('rel_%main%');
//#UC END# *55EEA16603AE_55FFA1DB00DB_impl*
end;//TExportByMainRelNamedTest.TuneExportPipe

function TExportByMainRelNamedTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'ExportPipeTests';
end;//TExportByMainRelNamedTest.GetFolder

function TExportByMainRelNamedTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55FFA1DB00DB';
end;//TExportByMainRelNamedTest.GetModelElementGUID

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TExportByMainRelNamedTest.Suite);

end.