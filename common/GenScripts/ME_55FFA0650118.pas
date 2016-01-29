unit ExportSeparatedBySizeTest;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportSeparatedBySizeTest = class(TExportPipeTestPrim)
  {* Экспорт в NSRC, разделённые по размеру с помощью свойства DivideBy }
  procedure TuneExportPipe;
   {* Процедура настройки трубы. Метод для перекрытия в потомках. }
 end;//TExportSeparatedBySizeTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
