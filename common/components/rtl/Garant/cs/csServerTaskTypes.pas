unit csServerTaskTypes;

interface

uses
 csProcessTask,
 Classes, ActnList,
 CsDataPipe,
 dt_Types,
 l3ObjectRefList,
 l3Date,
 CsNotification,
 csCommandsTypes,
 ddProgressObj,
 csMessageManager,
 csDictEditQueryPrim,
 csUserEditQueryPrim,
 csRemoteDictEditQueryPrim,
 ddRunCommandTaskPrim,
 csDeleteDocsQueryPrim,
 ddProcessTaskPrim
 ;

type

(* TDictRec = record
             Family      : Integer;
             DictType    : Integer;
             Operation   : Integer;
             ID,
             ParentID,
             NextID      : LongInt;
            end;*)

 TDictEditQuery = class(TcsDictEditQueryPrim)
 public
  constructor Create(aUserID: TUserID); override;
  procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
  procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
 end;

 TGetDictEditQuery = class(TDictEditQuery)
  private
    f_Index: LongInt;
 public
  constructor Create(aUserID: TUserID; anIndex: Integer);
  procedure CommunicateWithServer(aPipe: TCsDataPipe); 
    property TaskIndex: LongInt read f_Index {write f_Index};
 end;

 TUserEditQuery = class(TcsUserEditQueryPrim)
 public
  constructor Create(aUserID: TUserID); override;
  procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
  procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
 end;

{$IFDEF RemoteDict} 
 TRemoteDictEditQuery = class(TcsRemoteDictEditQueryPrim)
(* private
  f_Data: PAnsiChar;
  f_FreeData: Boolean;*)
(*  procedure pm_SetData(const aValue: PAnsiChar);*)
 protected
  procedure Cleanup; override;
(*  function DataSize: Word;*)
 public
  constructor Create(aUserID: TUserID);
//  function _GetName: AnsiString;
  procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
  procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
 public
  Family       : Integer;
  DictType     : Integer;
  Operation    : Integer;
  ID,
  ParentID,
  NextID       : TDictID;
  NameCyr, NameShort, NameLat: AnsiString;
  IsPrivate    : TIsPrivate;
  IsNonPeriodic: TIsNonperiodic;
  DateToDelete : TstDate;
//  property Data: PAnsiChar read f_Data {write pm_SetData};
 end;
{$EndIf RemoteDict} 

 TDocArray = array of Longint;
 TDeleteDocsQuery = class(TcsDeleteDocsQueryPrim)
 private
  procedure pm_SetDocs(const Value: TDocArray);
 public
  constructor Create(aUserID: TUserID); override;
  property Docs: TDocArray write pm_SetDocs;
 end;

(* TddRunCommandTaskPrim = class(TddProcessTask)
 protected
  constructor Create(aUserID: TUserID); override;
 end;//TddRunCommandTaskPrim*)

 TddRunCommandTask = class(TddRunCommandTaskPrim)
 private
  f_Command: TcsCommand;
 protected
  procedure DoRun(const aContext: TddRunContext); override;
 public
  constructor Create(aUserID: TUserID; aCommand: TcsCommand);
//  property Command: TcsCommand {read f_Command} write f_Command;
 end;//TddRunCommandTask

implementation

uses
 CsTaskTypes, DT_Const, dt_AttrSchema, l3TempMemoryStream, l3Base, SysUtils, ddUtils, l3FileUtils,
 dt_DictConst, dt_DictTypes, DT_UserConst, l3Memory, StrUtils, DateUtils,
 ddServerTask;

constructor TGetDictEditQuery.Create(aUserID: TUserID; anIndex: Integer);
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
constructor TDictEditQuery.Create(aUserID: TUserID);
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

constructor TUserEditQuery.Create(aUserID: TUserID);
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

{$IFDEF RemoteDict}
constructor TRemoteDictEditQuery.Create(aUserID: TUserID);
begin
 inherited;
 //TaskType := cs_ttRemoteDictEdit;
 ID:= cUndefDictID;
 ParentID:= cUndefDictID;
 NextID:= cUndefDictID;
 IsNonPeriodic:= cEmptyByte;
 IsPrivate:= cEmptyByte;
// f_FreeData:= False;
end;

procedure TRemoteDictEditQuery.Cleanup;
begin
 inherited;
(* if f_FreeData then
  FreeMem(f_Data);*)
end;

(*end;*)

procedure TRemoteDictEditQuery.DoLoadFrom(aStream: TStream; aIsPipe: Boolean);
var
 l_DataSize: Integer;
begin
 inherited;
 with aStream do
 begin
  Read(Family, SizeOf(Family));
  Read(DictType, SizeOf(Integer));
  Read(Operation, SizeOf(Integer));
  Read(ID, SizeOf(ID));
  Read(ParentID, SizeOf(ParentID));
  Read(NextID, SizeOf(NextID));
  ReadString(aStream, NameCyr);
  ReadString(aStream, NameShort);
  ReadString(aStream, NameLat);
  Read(IsPrivate, SizeOf(IsPrivate));
  Read(IsNonPeriodic, SizeOf(IsNonPeriodic));
  Read(DateToDelete, SizeOf(TstDate));
  Read(l_DataSize, SizeOF(l_DataSize));
(*  f_FreeData:= True;
  if l_DataSize > 0 then begin
   GetMem(f_Data, l_DataSize);
   Read(f_Data[0], l_DataSize);
  end;*)
 end; // with aStream
end;

(*procedure TRemoteDictEditQuery.pm_SetData(const aValue: PAnsiChar);
var
 l_DataSize: Word;
begin
 f_FreeData:= True;
 l_DataSize:= DataSize;
 GetMem(f_Data, l_DataSize);
 l3Move(aValue[0], f_Data[0], l_DataSize);
end;*)

procedure TRemoteDictEditQuery.DoSaveTo(aStream: TStream; aIsPipe: Boolean);
var
 l_DataSize: Integer;
begin
 inherited;
 with aStream do
 begin
  Write(Family, SizeOf(Family));
  Write(DictType, SizeOf(Integer));
  Write(Operation, SizeOf(Integer));
  Write(ID, SizeOf(ID));
  Write(ParentID, SizeOf(ParentID));
  Write(NextID, SizeOf(NextID));
  WriteString(aStream, NameCyr);
  WriteString(aStream, NameShort);
  WriteString(aStream, NameLat);
  Write(IsPrivate, SizeOf(IsPrivate));
  write(IsNonPeriodic, SizeOf(IsNonPeriodic));
  Write(DateToDelete, SizeOf(TstDate));
(*  if f_Data <> nil then
  begin
   l_DataSize:= DataSize;
   Write(l_DataSize, SizeOF(l_DataSize));
   Write(f_Data[0], l_DataSize);
  end
  else *)begin
   l_DataSize := 0;
   Write(l_DataSize, SizeOF(l_DataSize));
  end;
 end; // with aStream
end;
{$EndIF RemoteDict}

{
******************************** TddProcessTask ********************************
}
constructor TDeleteDocsQuery.Create(aUserID: TUserID);
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

(*constructor TddRunCommandTaskPrim.Create(aUserID: TUserID);
begin
 inherited;
 TaskType := cs_ttRunCommand;
end;*)

constructor TddRunCommandTask.Create(aUserID: TUserID; aCommand: TcsCommand);
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
 RegisterTaskClass(cs_ttDictEdit, TDictEditQuery, 'изменение словар€');
 RegisterTaskClass(cs_ttUserEdit, TUserEditQuery, 'изменени€ данных пользователей');
 RegisterTaskClass(cs_ttDeleteDocs, TDeleteDocsQuery, '”даление документов');
 {$IFDEF RemoteDict}
 RegisterTaskClass(cs_ttRemoteDictEdit, TRemoteDictEditQuery, '”даленное редактирование словарей');
 {$EndIF RemoteDict}
 RegisterTaskClass(cs_ttRunCommand, TddRunCommandTask, '¬ыполнение команды на сервере');
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csServerTaskTypes.pas initialization leave'); {$EndIf}
end.
