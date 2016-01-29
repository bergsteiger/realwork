unit ExportToSingleNSRTest;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportToSingleNSRTest = class(TExportPipeTestPrim)
  {* Экспорт в один NSRC }
  procedure TuneExportPipe;
   {* Процедура настройки трубы. Метод для перекрытия в потомках. }
 end;//TExportToSingleNSRTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
