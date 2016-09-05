unit csUserDefinedExport;
{ ������� �� �������, ������� ����������� � �������� �������������� }


interface

uses
 csProcessTask,
 Classes,
 daTypes,
 csUserDefinedExportTaskPrim
 ;

type
 TcsUserDefinedExport = class(TcsUserDefinedExportTaskPrim)
 protected
  procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
 public
  constructor Create(aUserID: TdaUserID); override;
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
constructor TcsUserDefinedExport.Create(aUserID: TdaUserID);
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
 RegisterTaskClass(cs_ttUserDefinedExport, TcsUserDefinedExport, '���������� ������� �� �������');
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csUserDefinedExport.pas initialization leave'); {$EndIf}
end.
