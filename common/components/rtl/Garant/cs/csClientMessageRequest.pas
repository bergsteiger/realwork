unit csClientMessageRequest;

interface

uses
  Classes, CsDataPipe, csRequestTask, CsNotification,
  daTypes,
  ddServerTask,
  ddClientMessagePrim
  ;

type
 TddClientMessage = class(TddClientMessagePrim)
 private
(*  f_Data: Integer;
  f_NotifyType: TCsNotificationType;
  f_Text: AnsiString;*)
  f_TryCount: Integer;
 protected
  procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
 public
  constructor Create(aUserID: TdaUserID; aData: Integer; aType: TCsNotificationType; const aText: AnsiString); reintroduce; overload;
  constructor Create(aUserID: TdaUserID; aStream: TStream; aIsPipe: Boolean); reintroduce; overload;
  function CompareWith(anObject: TddClientMessage): Integer; //override;
        {* - функция сравнения объекта с различного рода значениями. }
(*  procedure FromPipe(aDataPipe: TcsDataPipe);*)
  procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
(*  property Data: Integer read f_Data {write f_Data};
  property NotifyType: TCsNotificationType read f_NotifyType {write f_NotifyType};
  property Text: AnsiString read f_Text {write f_Text};*)
  property TryCount: Integer read f_TryCount write f_TryCount;
 end;//TddClientMessage

implementation

uses
  Math,
  SysUtils,
  evdTaskTypes
  ;

constructor TddClientMessage.Create(aUserID: TdaUserID; aData: Integer; aType: TCsNotificationType; const aText: AnsiString);
begin
 inherited Create(aUserID, SomeFixedDate);
 //TaskType := cs_ttClientMessage;
 //Self.DateW := SomeFixedDate;
 // - на самом деле - всё равно, лишь бы - константа
 //   иначе EVD-теги для даты с бешенной скоростью создаются
 Self.Data := aData;
 Self.NotifyType := aType;
 Self.Text := aText;
end;

constructor TddClientMessage.Create(aUserID: TdaUserID; aStream: TStream; aIsPipe: Boolean);
begin
 Create(aUserID, 0, ntEmpty, '');
 LoadFrom(aStream, aIsPipe);
end;

function TddClientMessage.CompareWith(anObject: TddClientMessage): Integer;
begin
 if (Self = anObject) then
  Result := 0
 else
 begin
  Result := CompareValue(Data, anObject.Data);
  if (Result = 0) then
   Result := CompareValue(Ord(NotifyType), Ord(anObject.NotifyType));
  if (Result = 0) then
   Result := CompareStr(Text, anObject.Text);
 end;//Self = anObject
end;

procedure TddClientMessage.DoLoadFrom(aStream: TStream; aIsPipe: Boolean);
begin
 inherited;
 NotifyType := TCsNotificationType(ReadInteger(aStream));
 Data := ReadInteger(aStream);
 Text := ReadString(aStream);
end;

procedure TddClientMessage.DoSaveTo(aStream: TStream; aIsPipe: Boolean);
begin
 inherited;
 WriteInteger(aStream, Ord(NotifyType));
 WriteInteger(aStream, Data);
 WriteString(aStream, Text);
end;

end.
