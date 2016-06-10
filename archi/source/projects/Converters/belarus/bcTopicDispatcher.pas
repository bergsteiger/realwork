unit bcTopicDispatcher;

{ $Id: bcTopicDispatcher.pas,v 1.7 2016/04/12 12:44:21 fireton Exp $ }

interface
uses
 l3ProtoObject,
 l3Interfaces,
 bcInterfaces,

 dt_Table;

type
 TbcTopicDispatcher = class(Tl3ProtoObject, IbcTopicDispatcher)
 private
  f_Table: TdtTable;
  f_NextTopicNo: Longword;
  f_Allocated: Integer;
  procedure CreateTable(const aTablePath: AnsiString);
 protected
  procedure Cleanup; override;
  function GetTopic(const aBelNum: Tl3WString; aAddNum: Integer = 0; aOnlyIfExists: Boolean = True): Longword;
 public
  constructor Create(const aPath: AnsiString);
  class function Make(const aTablePath: AnsiString): IbcTopicDispatcher;
 end;

implementation

uses
 SysUtils,
 HT_Const,
 HT_Dll,
 l3String,
 l3Except,
 dtIntf,
 dt_Err,
 dt_Sab;

const
 cBelNumLen = 15;
type
 TbcBelNumArr = array[1..cBelNumLen] of AnsiChar;

 TbcDispRec = packed record
  rBelNum     : TbcBelNumArr;
  rAdditional : Longword;
  rArchNum    : Longword;
 end;

 PbcDispResRec = ^TbcDispResRec;
 TbcDispResRec = packed record
  rRecNo      : Longword;
  rBelNum     : TbcBelNumArr;
  rAdditional : Longword;
  rArchNum    : Longword;
 end;

const
 cDispatchTblStruct : array[1..4] of ThtElementInfo = (
  (wLength: cBelNumLen; wOffset: 0;  cClass: EC_FIELD; cType: ET_CHAR; cKey: EK_COMMON; mName: 'BELNUM'),  // номер топика Беларусского
  (wLength:  0;         wOffset: 0;  cClass: EC_FIELD; cType: ET_DWRD; cKey: EK_COMMON; mName: 'ADDNUM'),  // дополнительный номер
  (wLength:  0;         wOffset: 0;  cClass: EC_FIELD; cType: ET_DWRD; cKey: EK_COMMON; mName: 'ARCHNUM'), // номер топика Архивариуса
  (wLength:  2;         wOffset: 1;  cClass: EC_GROUP; cType: ET_CHAR; cKey: EK_UNIQUE; mName: 'UNIKEY')
 );

 // ADDNUM - дополнительный номер. 0 - это сам документ, от 1 и дальше - это объекты внутри документа (картинки),
 // MaxInt - это справка к документу.

 dtfBelNum     = 1;
 dtfAdditional = 2;
 dtfArchNum    = 3;
 dtfUnikey     = 4;

 cStartTopicsFrom = 79000000;
 cMaxTopicNum     = 79999999;

constructor TbcTopicDispatcher.Create(const aPath: AnsiString);
var
 l_Sab: ISab;
begin
 inherited Create;
 if not FileExists(aPath+'.HTB') then
  CreateTable(aPath);
 f_Table := TdtTable.CreateWithOpen(aPath, '', '', TAB_SHARE);
 l_Sab := MakeAllRecords(f_Table);
 f_NextTopicNo := l_Sab.GetMaxValue(dtfArchNum) + 1; // потому что каждый второй - это номер справки
 if f_NextTopicNo < cStartTopicsFrom then
  f_NextTopicNo := cStartTopicsFrom;
end;

procedure TbcTopicDispatcher.Cleanup;
begin
 if f_Allocated > 0 then
  f_Table.UpdateTbl;
 FreeAndNil(f_Table);
 inherited;
end;

procedure TbcTopicDispatcher.CreateTable(const aTablePath: AnsiString);
var
 l_H: ThtTblHandle;
begin
 Ht(htTableCreate(PAnsiChar(aTablePath), @cDispatchTblStruct, High(cDispatchTblStruct), nil, nil, nil, TAB_PRIVATE or TAB_ANSI, l_H));
 htTableClose(l_H);
end;

function TbcTopicDispatcher.GetTopic(const aBelNum: Tl3WString; aAddNum: Integer = 0; aOnlyIfExists: Boolean = True):
 Longword;
var
 l_Str: Il3CString;
 l_BelNum: TbcBelNumArr;
 l_ArNum: LongWord;
 l_Sab: ISab;
 l_SC: ISabCursor;
 l_Rec: TbcDispRec;
begin
 l_Str := l3Upper(aBelNum);
 l3PCharLenToArray(l_BelNum, cBelNumLen, l_Str.AsWStr);
 l_Sab := MakeSab(f_Table);
 if aOnlyIfExists then
 begin
  l_Sab.Select(dtfBelNum, l_BelNum);
  if l_Sab.Count = 0 then
  begin
   Result := 0;
   Exit;
  end;
 end;
 l_Rec.rBelNum := l_BelNum;
 l_Rec.rAdditional := aAddNum;
 l_Sab.Select(dtfUnikey, l_Rec);
 if l_Sab.Count > 0 then
 begin
  l_SC := l_Sab.MakeSabCursor([dtfArchNum]); //([0, 1, 2, 3]);
  l_ArNum := {PbcDispResRec}PLongWord(l_SC.GetItem(0))^;//.rArchNum;
 end
 else
 begin
  if f_NextTopicNo > cMaxTopicNum then
   raise El3Error.Create('Исчерпан диапазон топиков!');
  l_ArNum := f_NextTopicNo;
  Inc(f_NextTopicNo);
  l_Rec.rBelNum := l_BelNum;
  l_Rec.rAdditional := aAddNum;
  l_Rec.rArchNum := l_ArNum;
  f_Table.AddRec(@l_Rec);
  Inc(f_Allocated);
  if f_Allocated > 5000 then
  begin
   f_Table.UpdateTbl;
   f_Allocated := 0;
  end; 
 end;
 Result := l_ArNum;
end;

class function TbcTopicDispatcher.Make(const aTablePath: AnsiString): IbcTopicDispatcher;
var
 l_Inst: TbcTopicDispatcher;
begin
 l_Inst := TbcTopicDispatcher.Create(aTablePath);
 try
  Result := l_Inst;
 finally
  FreeAndNil(l_Inst);
 end;
end;

end.