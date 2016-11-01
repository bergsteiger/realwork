unit ncsClientFilesDeliverer;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsClientFilesDeliverer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsClientFilesDeliverer" MUID: (5811CF1B02E6)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , CsDataPipe
 , evdNcsTypes
 , Classes
;

type
 TncsClientFilesDeliverer = class(Tl3ProtoObject)
  private
   f_Terminating: Boolean;
   f_IsSuccess: Boolean;
   f_DataPipe: TCsDataPipe;
  private
   procedure SendCommand(aCommand: TncsDeliveryCommand);
   procedure FillTasksList(aList: TStringList);
   procedure FillStringList(aList: TStringList);
   function ReceiveOneTask(const aTaskID: AnsiString;
    var theSize: Int64): Boolean;
   function DoReceiveOneTask(const aTaskID: AnsiString;
    var theSize: Int64;
    var theWriteTime: Double;
    out theTargetFolder: AnsiString): TncsResultKind;
   procedure SendRequestNewFolder(const aTaskID: AnsiString;
    const aFolder: AnsiString);
   procedure SendDeliveryResult(const aTaskID: AnsiString;
    aResultKind: TncsResultKind);
   function CheckCancel: Boolean;
   procedure RequestTaskParams(const aTaskID: AnsiString;
    out theTargetFolder: AnsiString;
    aFilesList: TStringList;
    out aTotalSize: Int64);
  protected
   procedure CheckTaskExistence(const aTaskID: AnsiString); virtual; abstract;
   procedure RequestSendMessage(const aMessage: AnsiString); virtual; abstract;
   procedure ChangeResultFolder(const aTaskID: AnsiString;
    const aFolder: AnsiString); virtual; abstract;
   function RequestNewFolder(var theFolder: AnsiString): Boolean; virtual; abstract;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aPipe: TCsDataPipe); reintroduce;
   function CheckAndDelivery: Int64;
   procedure TerminateProcess;
  protected
   property DataPipe: TCsDataPipe
    read f_DataPipe;
  public
   property IsSuccess: Boolean
    read f_IsSuccess;
 end;//TncsClientFilesDeliverer
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3StopWatch
 , l3Base
 //#UC START# *5811CF1B02E6impl_uses*
 //#UC END# *5811CF1B02E6impl_uses*
;

constructor TncsClientFilesDeliverer.Create(aPipe: TCsDataPipe);
//#UC START# *5811CF7103B8_5811CF1B02E6_var*
//#UC END# *5811CF7103B8_5811CF1B02E6_var*
begin
//#UC START# *5811CF7103B8_5811CF1B02E6_impl*
 inherited Create;
 aPipe.SetRefTo(f_DataPipe);
//#UC END# *5811CF7103B8_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.Create

procedure TncsClientFilesDeliverer.SendCommand(aCommand: TncsDeliveryCommand);
//#UC START# *5811E3DA007F_5811CF1B02E6_var*
//#UC END# *5811E3DA007F_5811CF1B02E6_var*
begin
//#UC START# *5811E3DA007F_5811CF1B02E6_impl*
 DataPipe.WriteInteger(Ord(aCommand));
//#UC END# *5811E3DA007F_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.SendCommand

procedure TncsClientFilesDeliverer.FillTasksList(aList: TStringList);
//#UC START# *5811EF09025F_5811CF1B02E6_var*
//#UC END# *5811EF09025F_5811CF1B02E6_var*
begin
//#UC START# *5811EF09025F_5811CF1B02E6_impl*
 SendCommand(ncs_dcGetTasksList);
 DataPipe.WriteBufferFlush;
 FillStringList(aList);
//#UC END# *5811EF09025F_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.FillTasksList

procedure TncsClientFilesDeliverer.FillStringList(aList: TStringList);
//#UC START# *5811EF4602DA_5811CF1B02E6_var*
var
 l_Count: Integer;
 l_IDX: Integer;
//#UC END# *5811EF4602DA_5811CF1B02E6_var*
begin
//#UC START# *5811EF4602DA_5811CF1B02E6_impl*
 aList.Clear;
 l_Count := DataPipe.ReadInteger;
 for l_IDX := 1 to l_Count do
  aList.Add(DataPipe.ReadLn);
//#UC END# *5811EF4602DA_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.FillStringList

function TncsClientFilesDeliverer.ReceiveOneTask(const aTaskID: AnsiString;
 var theSize: Int64): Boolean;
//#UC START# *581307A700F1_5811CF1B02E6_var*
var
 l_WriteTime: Double;
 l_Watch: Tl3STopWatch;
 l_BytesProcessed: Int64;
 l_ResultKind: TncsResultKind;
 l_TryCount: Integer;
 l_TargetFolder: String;
 l_Folder: String;
const
 cMaxTryCount = 10;
 cTryDelay = 1000;
//#UC END# *581307A700F1_5811CF1B02E6_var*
begin
//#UC START# *581307A700F1_5811CF1B02E6_impl*
 l_WriteTime := 0;
 l_BytesProcessed := 0;
{$IFNDEF AQTIME_PROFILE}
 l_Watch.Reset;
 l_Watch.Start;
{$ENDIF AQTIME_PROFILE}
 try
  Result := False;
  if not CheckCancel then
   Exit;
  CheckTaskExistence(aTaskID);
  l_TryCount := 0;
  repeat
   l_ResultKind := DoReceiveOneTask(aTaskID, l_BytesProcessed, l_WriteTime, l_TargetFolder);
   inc(l_TryCount);
   if (l_ResultKind = ncs_rkRetry) and (l_TryCount < cMaxTryCount) then
   begin
{$IFNDEF AQTIME_PROFILE}
    l3System.Msg2Log('Не удается записать доставку, попытка номер %d', [l_TryCount + 1]);
    Sleep(cTryDelay);
{$ENDIF AQTIME_PROFILE}
   end;
  until (l_ResultKind <> ncs_rkRetry) or (l_TryCount = cMaxTryCount);


  case l_ResultKind of
   ncs_rkOk:
    begin
{$IFNDEF AQTIME_PROFILE}
     RequestSendMessage(Format('Результаты экспорта помещены в папку %s', [l_TargetFolder]));
{$ENDIF AQTIME_PROFILE}
     Result := True;
    end;
{$IFNDEF AQTIME_PROFILE}
   ncs_rkFail:
    begin
     RequestSendMessage(Format('Не удалось доставить результаты экспорта в папку %s', [l_TargetFolder]));
     Result := False;
    end;
   ncs_rkRetry:
    begin
     l_Folder := l_TargetFolder;
     if RequestNewFolder(l_Folder) then
     begin
      SendRequestNewFolder(aTaskID, l_Folder);
      ChangeResultFolder(aTaskID, l_Folder);
     end
     else
     begin
      l_ResultKind := ncs_rkFail;
      RequestSendMessage(Format('Не удалось доставить результаты экспорта в папку %s', [l_TargetFolder]));
     end;
     Result := True;
    end;
   ncs_rkEmpty:
    begin
     RequestSendMessage('Результаты экспорта не найдены. Все экспортируемые документы оказались пустыми');
     Result := True;
    end;
   else
    Assert(False);
{$ENDIF AQTIME_PROFILE}
  end;
  SendDeliveryResult(aTaskID, l_ResultKind);
  theSize := theSize + l_BytesProcessed;
 finally
{$IFNDEF AQTIME_PROFILE}
  l_Watch.Stop;
{$ENDIF AQTIME_PROFILE}
 end;
{$IFNDEF AQTIME_PROFILE}
 l3System.Msg2Log('Доставка задачи %s завершена - общее время %s ms', [aTaskID, FormatFloat('#,##0.000', l_Watch.Time * 1000)]);
 l3System.Msg2Log('  - объем %s kb', [FormatFloat('#,##0', l_BytesProcessed / 1024)]);
 l3System.Msg2Log('  - скорость %s kb/s', [FormatFloat('#,##0.000', l_BytesProcessed / 1024 / l_Watch.Time)]);
 l3System.Msg2Log('  - запись %s ms', [FormatFloat('#,##0.000', l_WriteTime * 1000)]);
 l3System.Msg2Log('  - скорость записи %s kb/s', [FormatFloat('#,##0.000', l_BytesProcessed / 1024 / l_WriteTime)], 5);
{$ENDIF AQTIME_PROFILE}

//#UC END# *581307A700F1_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.ReceiveOneTask

function TncsClientFilesDeliverer.DoReceiveOneTask(const aTaskID: AnsiString;
 var theSize: Int64;
 var theWriteTime: Double;
 out theTargetFolder: AnsiString): TncsResultKind;
//#UC START# *581318C90282_5811CF1B02E6_var*
var
 l_FilesList: TStringList;
 l_TotalSize: Int64;
//#UC END# *581318C90282_5811CF1B02E6_var*
begin
//#UC START# *581318C90282_5811CF1B02E6_impl*
 Result := ncs_rkFail;
 l_FilesList := TStringList.Create;
 try
  RequestTaskParams(aTaskID, theTargetFolder, l_FilesList, l_TotalSize);
  Assert(False);
//!! !!! Needs to be implemented !!!
 finally
  FreeAndNil(l_FilesList);
 end;
//#UC END# *581318C90282_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.DoReceiveOneTask

procedure TncsClientFilesDeliverer.SendRequestNewFolder(const aTaskID: AnsiString;
 const aFolder: AnsiString);
//#UC START# *58132BA400F6_5811CF1B02E6_var*
//#UC END# *58132BA400F6_5811CF1B02E6_var*
begin
//#UC START# *58132BA400F6_5811CF1B02E6_impl*
 SendCommand(ncs_dcCorrectTargetFolder);
 DataPipe.WriteLn(aTaskID);
 DataPipe.WriteLn(aFolder);
 DataPipe.WriteBufferFlush;
//#UC END# *58132BA400F6_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.SendRequestNewFolder

procedure TncsClientFilesDeliverer.SendDeliveryResult(const aTaskID: AnsiString;
 aResultKind: TncsResultKind);
//#UC START# *5813387000E7_5811CF1B02E6_var*
var
 l_Result: Integer;
//#UC END# *5813387000E7_5811CF1B02E6_var*
begin
//#UC START# *5813387000E7_5811CF1B02E6_impl*
 SendCommand(ncs_dcSetDeliveryResult);
 DataPipe.WriteLn(aTaskID);
 l_Result := Ord(aResultKind);
 DataPipe.WriteInteger(l_Result);
 DataPipe.WriteBufferFlush;
//#UC END# *5813387000E7_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.SendDeliveryResult

function TncsClientFilesDeliverer.CheckCancel: Boolean;
//#UC START# *581722FB0041_5811CF1B02E6_var*
//#UC END# *581722FB0041_5811CF1B02E6_var*
begin
//#UC START# *581722FB0041_5811CF1B02E6_impl*
 SendCommand(ncs_dcCheckAlive);
 DataPipe.WriteBoolean(f_Terminating);
 if DataPipe.ReadBoolean then
  f_Terminating := True;
 Result := f_Terminating;
//#UC END# *581722FB0041_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.CheckCancel

procedure TncsClientFilesDeliverer.RequestTaskParams(const aTaskID: AnsiString;
 out theTargetFolder: AnsiString;
 aFilesList: TStringList;
 out aTotalSize: Int64);
//#UC START# *5817381A013C_5811CF1B02E6_var*
//#UC END# *5817381A013C_5811CF1B02E6_var*
begin
//#UC START# *5817381A013C_5811CF1B02E6_impl*
 SendCommand(ncs_dcGetFilesList);
 DataPipe.WriteLn(aTaskID);
 theTargetFolder := DataPipe.ReadLn;
 FillStringList(aFilesList);
 aTotalSize := DataPipe.ReadInt64;
//#UC END# *5817381A013C_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.RequestTaskParams

function TncsClientFilesDeliverer.CheckAndDelivery: Int64;
//#UC START# *5811CF34007E_5811CF1B02E6_var*
var
 l_TasksList: TStringList;
 l_IDX: Integer;
//#UC END# *5811CF34007E_5811CF1B02E6_var*
begin
//#UC START# *5811CF34007E_5811CF1B02E6_impl*
 try
  f_IsSuccess := False;
  Result := 0;
  l_TasksList := TStringList.Create;
  try
   FillTasksList(l_TasksList);
   for l_IDX := 0 to l_TasksList.Count - 1 do
    if not ReceiveOneTask(l_TasksList[l_IDX], Result) then
     exit;
    f_IsSuccess := True; 
  finally
   FreeAndNil(l_TasksList);
  end;
 finally
  SendCommand(ncs_dcDoneProcess);
 end;
//#UC END# *5811CF34007E_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.CheckAndDelivery

procedure TncsClientFilesDeliverer.TerminateProcess;
//#UC START# *5811D0280291_5811CF1B02E6_var*
//#UC END# *5811D0280291_5811CF1B02E6_var*
begin
//#UC START# *5811D0280291_5811CF1B02E6_impl*
 f_Terminating := True;
//#UC END# *5811D0280291_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.TerminateProcess

procedure TncsClientFilesDeliverer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5811CF1B02E6_var*
//#UC END# *479731C50290_5811CF1B02E6_var*
begin
//#UC START# *479731C50290_5811CF1B02E6_impl*
 FreeAndNil(f_DataPipe);
 inherited;
//#UC END# *479731C50290_5811CF1B02E6_impl*
end;//TncsClientFilesDeliverer.Cleanup
{$IfEnd} // NOT Defined(Nemesis)

end.
