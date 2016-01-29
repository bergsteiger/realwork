unit ExportToSeparateNSRTest;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportToSeparateNSRTest = class(TExportPipeTestPrim)
  {* Экспорт в NSRC, разделённые по топикам. }
  procedure TuneExportPipe;
   {* Процедура настройки трубы. Метод для перекрытия в потомках. }
 end;//TExportToSeparateNSRTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
