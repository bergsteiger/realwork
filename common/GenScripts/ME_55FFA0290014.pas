unit ExportSeparatedByMainTest;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportSeparatedByMainTest = class(TExportPipeTestPrim)
  {* Экспорт в NSRC, разделённые по мейну, с помощью свойства DivideBy }
  procedure TuneExportPipe;
   {* Процедура настройки трубы. Метод для перекрытия в потомках. }
 end;//TExportSeparatedByMainTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
