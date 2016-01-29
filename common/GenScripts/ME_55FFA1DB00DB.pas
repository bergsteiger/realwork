unit ExportByMainRelNamedTest;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportByMainRelNamedTest = class(TExportPipeTestPrim)
  {* Экспорт документов в один NSRC со справками, разделённые по мейнам с помощью шаблона имени. (DivideBy = divNone) }
  procedure TuneExportPipe;
   {* Процедура настройки трубы. Метод для перекрытия в потомках. }
 end;//TExportByMainRelNamedTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
