unit ExportBySizeAndMain;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportBySizeAndMain = class(TExportPipeTestPrim)
  {* Экспорт, разделённый по размеру и мейну (мейн - в шаблонах имён файлов) }
  procedure TuneExportPipe;
   {* Процедура настройки трубы. Метод для перекрытия в потомках. }
 end;//TExportBySizeAndMain
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
