unit csUserDefinedExport;
{ Задание на экспорт, которое выполняется с заданной периодичностью }


interface

uses
 csProcessTask,
 Classes,
 DT_types,
 csUserDefinedExportTaskPrim
 ;

type
 TcsUserDefinedExport = class(TcsUserDefinedExportTaskPrim)
 protected
  procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
 public
  constructor Create(aUserID: TUserID); override;
  procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
 end;//TcsUserDefinedExport

implementation

uses
 CsTaskTypes,
 ddServerTask,
 SysUtils
 ;

{
****************************** TddExportTaskItem *******************************
}
constructor TcsUserDefinedExport.Create(aUserID: TUserID);
begin
 inherited;
 //TaskType := cs_ttUserDefinedExport;
end;

procedure TcsUserDefinedExport.DoLoadFrom(aStream: TStream; aIsPipe: Boolean);
begin
  inherited;
  TimeToRun := ReadDateTime(aStream);
  QueryFile := ReadFileFrom(aStream, TaskFolder);
end;

procedure TcsUserDefinedExport.DoSaveTo(aStream: TStream; aIsPipe: Boolean);
begin
  inherited;
  WriteDateTime(aStream, TimeToRun);
  WriteFileTo(aStream, QueryFile);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csUserDefinedExport.pas initialization enter'); {$EndIf}
 RegisterTaskClass(cs_ttUserDefinedExport, TcsUserDefinedExport, 'Выполнение команды на сервере');
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csUserDefinedExport.pas initialization leave'); {$EndIf}
end.
