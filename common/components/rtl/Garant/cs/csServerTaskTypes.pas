unit csServerTaskTypes;

interface

uses
 csProcessTask,
 Classes, ActnList,
 CsDataPipe,
 daTypes,
 l3ObjectRefList,
 l3Date,
 CsNotification,
 csCommandsTypes,
 ddProgressObj,
 csMessageManager,
 csDictEditQueryPrim,
 csUserEditQueryPrim,
 ddRunCommandTaskPrim,
 csDeleteDocsQueryPrim,
 ddProcessTaskPrim
 ;

type

 TDictEditQuery = class(TcsDictEditQueryPrim)
 public
  constructor Create(aUserID: TdaUserID); override;
  procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
  procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
 end;

 TGetDictEditQuery = class(TDictEditQuery)
  private
    f_Index: LongInt;
 public
  constructor Create(aUserID: TdaUserID; anIndex: Integer);
  procedure CommunicateWithServer(aPipe: TCsDataPipe); 
    property TaskIndex: LongInt read f_Index {write f_Index};
 end;

 TUserEditQuery = class(TcsUserEditQueryPrim)
 public
  constructor Create(aUserID: TdaUserID); override;
  procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
  procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
 end;

 TDocArray = array of Longint;
 TDeleteDocsQuery = class(TcsDeleteDocsQueryPrim)
 private
  procedure pm_SetDocs(const Value: TDocArray);
 public
  constructor Create(aUserID: TdaUserID); override;
  property Docs: TDocArray write pm_SetDocs;
 end;

(* TddRunCommandTaskPrim = class(TddProcessTask)
 protected
  constructor Create(aUserID: TdaUserID); override;
 end;//TddRunCommandTaskPrim*)

 TddRunCommandTask = class(TddRunCommandTaskPrim)
 private
  f_Command: TcsCommand;
 protected
  procedure DoRun(const aContext: TddRunContext); override;
 public
  constructor Create(aUserID: TdaUserID; aCommand: TcsCommand);
//  property Command: TcsCommand {read f_Command} write f_Command;
 end;//TddRunCommandTask

implementation

uses
 CsTaskTypes, DT_Const, dt_AttrSchema, l3TempMemoryStream, l3Base, SysUtils, ddUtils, l3FileUtils,
 dt_DictConst, dt_DictTypes, l3Memory, StrUtils, DateUtils,
 ddServerTask;

constructor TGetDictEditQuery.Create(aUserID: TdaUserID; anIndex: Integer);
begin
 inherited Create(aUserID);
 f_Index := anIndex;
end;

procedure TGetDictEditQuery.CommunicateWithServer(aPipe: TCsDataPipe);
begin
 aPipe.WriteInteger(TaskIndex);
(* with {aPipe, }DictInfo do
 begin*)
  Family := aPipe.ReadInteger;
  DictType := aPipe.ReadInteger;
  Operation := aPipe.ReadInteger;
  ID := aPipe.ReadInteger;
  ParentID := aPipe.ReadInteger;
  NextID := aPipe.ReadInteger;
(* end;*)
end;

{
******************************** TddProcessTask ********************************
}
constructor TDictEditQuery.Create(aUserID: TdaUserID);
begin
 inherited;
 //TaskType := cs_ttDictEdit;
end;

procedure TDictEditQuery.DoLoadFrom(aStream: TStream; aIsPipe: Boolean);
begin
 inherited;
(* with aStream{, DictInfo} do*)
 begin
  Family := ReadInteger(aStream);
  DictType := ReadInteger(aStream);
  Operation := ReadInteger(aStream);
  ID := ReadInteger(aStream);
  ParentID := ReadInteger(aStream);
  NextID := ReadInteger(aStream);
 end;
end;

procedure TDictEditQuery.DoSaveTo(aStream: TStream; aIsPipe: Boolean);
begin
 inherited;
(* with aStream{, DictInfo} do*)
 begin
  WriteInteger(aStream, Family);
  WriteInteger(aStream, DictType);
  WriteInteger(aStream, Operation);
  WriteInteger(aStream, ID);
  WriteInteger(aStream, ParentID);
  WriteInteger(aStream, NextID);
 end;
end;

constructor TUserEditQuery.Create(aUserID: TdaUserID);
begin
 inherited;
 //TaskType := cs_ttUserEdit;
end;

procedure TUserEditQuery.DoLoadFrom(aStream: TStream; aIsPipe: Boolean);
begin
 inherited;
 IsGroup := ReadBoolean(aStream);
 ID := ReadInteger(aStream);
end;

procedure TUserEditQuery.DoSaveTo(aStream: TStream; aIsPipe: Boolean);
begin
 inherited;
 WriteBoolean(aStream, IsGroup);
 WriteInteger(aStream, ID);
end;
{
******************************** TddProcessTask ********************************
}
constructor TDeleteDocsQuery.Create(aUserID: TdaUserID);
begin
 inherited;
 //TaskType := cs_ttDeleteDocs;
end;

procedure TDeleteDocsQuery.pm_SetDocs(const Value: TDocArray);
var
 l_index: Integer;
begin
 DocumentIDList.Clear;
 for l_index := 0 to pred(Length(Value)) do
  DocumentIDList.Add(Value[l_index]);
end;

(*constructor TddRunCommandTaskPrim.Create(aUserID: TdaUserID);
begin
 inherited;
 TaskType := cs_ttRunCommand;
end;*)

constructor TddRunCommandTask.Create(aUserID: TdaUserID; aCommand: TcsCommand);
begin
 inherited Create(aUserID);
 f_Command := aCommand;
end;

procedure TddRunCommandTask.DoRun(const aContext: TddRunContext);
begin
 f_Command.Execute(Self);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csServerTaskTypes.pas initialization enter'); {$EndIf}
 RegisterTaskClass(cs_ttDictEdit, TDictEditQuery, 'изменение словаря');
 RegisterTaskClass(cs_ttUserEdit, TUserEditQuery, 'изменения данных пользователей');
 RegisterTaskClass(cs_ttDeleteDocs, TDeleteDocsQuery, 'Удаление документов');
 RegisterTaskClass(cs_ttRunCommand, TddRunCommandTask, 'Выполнение команды на сервере');
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csServerTaskTypes.pas initialization leave'); {$EndIf}
end.
