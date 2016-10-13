unit alcuDeliveryProfileTask;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
  Classes,

  ddProcessTaskPrim,

  csProcessTask,
  csDeliveryProfileTask
  ;

type
 TalcuDeliveryProfileTask = class(TcsDeliveryProfileTask)
 private
 protected
  procedure DoRun(const aContext: TddRunContext); override;
 public
  class function CanAsyncRun: Boolean; override;
 end;//TalcuDeliveryProfileTask

implementation

uses
 SysUtils,

 csTaskTypes,

 ddServerTask
 ;


{ TalcuDeliveryProfileTask }

class function TalcuDeliveryProfileTask.CanAsyncRun: Boolean;
begin
 Result := False;
end;

procedure TalcuDeliveryProfileTask.DoRun(const aContext: TddRunContext);
begin
// DoNothing
end;

initialization
 RegisterTaskClass(cs_ttDeliveryProfile, TalcuDeliveryProfileTask, 'Проверка скорости доставки');

end.
