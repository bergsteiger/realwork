unit csLineRequest;
{ «апрос очереди заданий сервера }

{ $Id: csLineRequest.pas,v 1.17 2016/06/16 05:39:57 lukyanets Exp $ }

// $Log: csLineRequest.pas,v $
// Revision 1.17  2016/06/16 05:39:57  lukyanets
// ѕересаживаем UserManager на новые рельсы
//
// Revision 1.16  2015/01/22 14:31:37  lukyanets
// ѕереносим отсылку задачи в более правильное место
//
// Revision 1.15  2014/09/22 12:54:10  lukyanets
// ¬ычитывали таск не того класса.
//
// Revision 1.14  2014/07/07 12:03:52  lulin
// - движемс€ к константности TaskType.
//
// Revision 1.13  2014/07/04 11:59:48  lulin
// - движемс€ к константности TaskType.
//
// Revision 1.12  2014/07/03 15:20:05  lulin
// - чистим код.
//
// Revision 1.11  2014/06/17 11:50:58  lulin
// - убираем ненужный параметр, он и так потом из потока читаетс€.
//
// Revision 1.10  2014/06/17 10:33:28  lulin
// - переименовываем метод, чтобы название отражало его суть.
//
// Revision 1.9  2014/02/12 12:35:25  lulin
// - рефакторим списки заданий.
//
// Revision 1.8  2012/11/01 09:43:22  lulin
// - забыл точку с зап€той.
//
// Revision 1.7  2012/11/01 07:45:44  lulin
// - делаем возможность логировани€ процесса загрузки модулей.
//
// Revision 1.6  2011/12/08 12:31:29  narry
// ќтображаетс€ не вс€ очередь заданий (304874341)
//
// Revision 1.5  2010/07/15 05:45:42  narry
// - K226003695
//

{$I csDefine.inc}

interface

uses
  CsDataPipe,
  csRequestTask,
  l3ObjectRefList,
  daTypes,
  
  ddTaskItemList,
  csLineRequestPrim
  ;

type
 TcsLineRequest = class(TcsLineRequestPrim)
 private
  f_TaskList: TddTaskItemList;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aUserID: TdaUserID); override;
  procedure SaveRequestToPipe(aPipe: TCsDataPipe); override;
  property TaskList: TddTaskItemList read f_TaskList;
 end;//TcsLineRequest

implementation

uses CsTaskTypes, l3Base, l3Memory, ddServerTask, Classes, l3LongintList,
 SysUtils;

{
******************************** TddRequestTask ********************************
}
constructor TcsLineRequest.Create(aUserID: TdaUserID);
begin
 inherited;
 f_TaskList := TddTaskItemList.Make;
 //TaskType := cs_ttLine
end;

procedure TcsLineRequest.Cleanup;
begin
 l3Free(f_TaskList);
 inherited;
end;

procedure TcsLineRequest.SaveRequestToPipe(aPipe: TCsDataPipe);
var
 i: Integer;
 l_Count: Integer;
 l_Task: TddTaskItem;
 l_Stream: TStream;
 l_SizeList: Tl3longintList;
 l_Pos: Longint;
begin
 inherited;
 f_TaskList.Clear;
 l_Count := aPipe.ReadInteger;
 l_SizeList:= Tl3LongintList.Make;
 try
  {$IFDEF csNewQueueTaskLine}
  for i:= 0 to Pred(l_Count) do
   l_SizeList.Add(aPipe.ReadInteger);
  {$ENDIF}
  l_Stream := Tl3MemoryStream.Make;
  try
   aPipe.ReadStream(l_Stream);
   l_Stream.Seek(0, 0);
   for i:= 0 to Pred(l_Count) do
   begin
    l_Task := TddTaskItem.MakeFrom(l_Stream, '', False);
    try
     if l_Task <> nil then
      f_TaskList.Add(l_Task)
     else
     begin
      {$IFNDEF csNewQueueTaskLine}
      l3System.Msg2log('ќшибка получени€ очереди заданий. ѕолучено %d из %d заданий', [i, l_Count]);
      break;
      {$ELSE}
      l_Pos:= l_Stream.Position;

      // ¬ принципе, можно создавать базового предка
      l_Task:= TddTaskItem.Create({nil, }UserID);
      l_Task.LoadFrom(l_Stream, true);
      f_TaskList.Add(l_Task);
      l_Stream.Position:= l_Pos;
      l_Stream.Seek(l_SizeList[i], soFromCurrent);
      {$ENDIF}
     end;
    finally
     FreeAndNil(l_Task);
    end;
   end; // for i
  finally
   FreeAndNil(l_Stream);
  end;
 finally
  FreeAndNil(l_SizeList);
 end;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csLineRequest.pas initialization enter'); {$EndIf}
 RegisterTaskClass(cs_ttLine, TcsLineRequest, 'запрос очереди');
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\cs\csLineRequest.pas initialization leave'); {$EndIf}
end.
