unit csCommonDataRequest;

interface

uses
  CsDataPipe,
  csRequestTask,
  ddServerTask,
  daTypes,
  csServerTaskTypes,
  ddCommonDataRequestPrim
  ;

type
(* TddCommonDataRequestPrim = class(TddRequestTask)
 public
  constructor Create(aUserID: TdaUserID); override;
 end;//TddCommonDataRequestPrim*)

 TddCommonDataRequest = class(TddCommonDataRequestPrim)
 private
  f_Data: TDeleteDocsQuery{TddTaskItem};
  f_DataIndex: Integer;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aUserID: TdaUserID; aDataIndex: Integer); //override;
  procedure SaveRequestToPipe(aPipe: TCsDataPipe); override;
  property DeleteDocsQuery: TDeleteDocsQuery{TddTaskItem} read f_Data{ write f_Data};
  property DataIndex: Integer read f_DataIndex {write f_DataIndex};
 end;//TddCommonDataRequest

implementation

uses
  CsTaskTypes,
  l3Base,
  l3Memory
  ;

(*constructor TddCommonDataRequestPrim.Create(aUserID: TdaUserID);
begin
 inherited;
 TaskType := cs_ttCommonData;
end;*)

{
******************************** TddProcessTask ********************************
}
constructor TddCommonDataRequest.Create(aUserID: TdaUserID; aDataIndex: Integer);
begin
 inherited Create(aUserID);
 f_DataIndex := aDataIndex;
 //TaskType := cs_ttCommonData;
end;

procedure TddCommonDataRequest.Cleanup;
begin
 l3Free(f_Data);
 inherited;
end;

procedure TddCommonDataRequest.SaveRequestToPipe(aPipe: TCsDataPipe);
var
 l_Stream: Tl3MemoryStream;
 l_Data : TddTaskItem;
begin
 aPipe.WriteInteger(f_DataIndex);
 l_Stream:= Tl3MemoryStream.Create;
 try
  aPipe.ReadStream(l_Stream);
  l_Stream.Seek(0, 0);
  Assert(f_Data = nil);
  l_Data := TddTaskItem.MakeFrom(l_Stream, '', True);
  f_Data := l_Data As TDeleteDocsQuery;
 finally
  l3Free(l_Stream);
 end;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csCommonDataRequest.pas initialization enter'); {$EndIf}
 RegisterTaskClass(cs_ttCommonData, TddCommonDataRequest, 'Общие данные');
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csCommonDataRequest.pas initialization leave'); {$EndIf}
end.
