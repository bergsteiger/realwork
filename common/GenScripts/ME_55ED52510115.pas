unit ExportPipeTestPrim;

interface

uses
 l3IntfUses
 , archiDBTest
 , ExportPipe
;

type
 TExportPipeTestPrim = class(TarchiDBTest)
  procedure FillDocSub;
   {* Формирование выборки для экспорта (она одна для всех потомков) }
  procedure TuneExportPipe;
   {* Процедура настройки трубы. Метод для перекрытия в потомках. }
  procedure DoExport;
   {* Собственно, экспорт }
  procedure InternalExport;
  procedure CompareResults;
  function GetResultHeaderStartingChar: AnsiChar;
  procedure CheckNumberOfTopicsInResult;
 end;//TExportPipeTestPrim
 
implementation

uses
 l3ImplUses
 , dt_Sab
 , dt_Const
 , dt_Renum
 , dt_Doc
 , dt_LinkServ
 , SysUtils
 , TestFrameWork
 , ddPipeOutInterfaces
 , l3Base
 , dtIntf
 , dt_Types
 , l3FileUtils
 , ddFileIterator
 , KTestRunner
 , l3Filer
 , l3Interfaces
 , l3String
;

end.
