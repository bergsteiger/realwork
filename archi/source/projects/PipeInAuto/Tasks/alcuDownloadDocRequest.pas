unit alcuDownloadDocRequest;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuDownloadDocRequest.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuDownloadDocRequest" MUID: (57C3FAF20200)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuWaitableRequest
 {$If NOT Defined(Nemesis)}
 , csDownloadDocStream
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csDownloadDocStreamReply
 {$IfEnd} // NOT Defined(Nemesis)
 , k2Base
 {$If NOT Defined(Nemesis)}
 , ddProcessTaskPrim
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuDownloadDocRequest = class(TalcuWaitableRequest)
  private
   f_Message: TcsDownloadDocStream;
   f_Reply: TcsDownloadDocStreamReply;
  protected
   procedure pm_SetMessage(aValue: TcsDownloadDocStream);
   procedure pm_SetReply(aValue: TcsDownloadDocStreamReply);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(Nemesis)}
   procedure DoRun(const aContext: TddRunContext); override;
   {$IfEnd} // NOT Defined(Nemesis)
   {$If NOT Defined(Nemesis)}
   procedure DoAbort; override;
   {$IfEnd} // NOT Defined(Nemesis)
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Message: TcsDownloadDocStream
    read f_Message
    write pm_SetMessage;
   property Reply: TcsDownloadDocStreamReply
    read f_Reply
    write pm_SetReply;
 end;//TalcuDownloadDocRequest
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , SysUtils
 , nevInternalInterfaces
 , l3Filer
 , evdNativeWriter
 , evdNativeReader
 , l3Interfaces
 , arDocAttributesMixer
 , m4DocumentAddress
 , m3DocumentAddress
 , l3Base
 , l3StopWatch
 , l3Types
 , DownloadDocRequest_Const
 //#UC START# *57C3FAF20200impl_uses*
 //#UC END# *57C3FAF20200impl_uses*
;

procedure TalcuDownloadDocRequest.pm_SetMessage(aValue: TcsDownloadDocStream);
//#UC START# *57C3FB090381_57C3FAF20200set_var*
//#UC END# *57C3FB090381_57C3FAF20200set_var*
begin
//#UC START# *57C3FB090381_57C3FAF20200set_impl*
 aValue.SetRefTo(f_Message);
//#UC END# *57C3FB090381_57C3FAF20200set_impl*
end;//TalcuDownloadDocRequest.pm_SetMessage

procedure TalcuDownloadDocRequest.pm_SetReply(aValue: TcsDownloadDocStreamReply);
//#UC START# *57C3FB2E0376_57C3FAF20200set_var*
//#UC END# *57C3FB2E0376_57C3FAF20200set_var*
begin
//#UC START# *57C3FB2E0376_57C3FAF20200set_impl*
 aValue.SetRefTo(f_Reply);
//#UC END# *57C3FB2E0376_57C3FAF20200set_impl*
end;//TalcuDownloadDocRequest.pm_SetReply

procedure TalcuDownloadDocRequest.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57C3FAF20200_var*
//#UC END# *479731C50290_57C3FAF20200_var*
begin
//#UC START# *479731C50290_57C3FAF20200_impl*
 FreeAndNil(f_Message);
 FreeAndNil(f_Reply);
 inherited;
//#UC END# *479731C50290_57C3FAF20200_impl*
end;//TalcuDownloadDocRequest.Cleanup

{$If NOT Defined(Nemesis)}
procedure TalcuDownloadDocRequest.DoRun(const aContext: TddRunContext);
//#UC START# *53A2EEE90097_57C3FAF20200_var*
var
 l_Gen: Tk2TagGenerator;
 l_ReadFiler : Tl3CustomFiler;
 l_WriteFiler : Tl3CustomFiler;
 l_ComStream: IStream;
 l_FoundSelector: Tm4Addresses;
 l_IDX: Integer;
 l_Address: Tm3DocumentAddress;
 l_Counter: Tl3StopWatch;
//#UC END# *53A2EEE90097_57C3FAF20200_var*
begin
//#UC START# *53A2EEE90097_57C3FAF20200_impl*
 l_Counter.Reset;
 l_Counter.Start;
 try
  try
   l_Gen := nil;
   try
    TevdNativeWriter.SetTo(l_Gen);
    l_ComStream := f_Reply.Data as IStream;
    try
     l_WriteFiler := Tl3CustomFiler.Create;
     try
      l_WriteFiler.COMStream := l_ComStream;
      (l_Gen as TevdNativeWriter).Filer := l_WriteFiler;
      (l_Gen as TevdNativeWriter).Binary := True;
     finally
      FreeAndNil(l_WriteFiler);
     end;
    finally
     l_ComStream := nil;
    end;
    l_ReadFiler := nil;
    if f_Message.FoundSelector.Count = 0 then
     l_FoundSelector := nil
    else
     l_FoundSelector := Tm4Addresses.Make;
    try
     for l_IDX := 0 to f_Message.FoundSelector.Count - 1 do
     begin
      f_Message.FoundSelector.GetValue(l_IDX, l_Address.rPara, l_Address.rWord, l_Address.rDocument);
      l_FoundSelector.Add(l_Address);
     end;
     BuildDocLoadPipe(f_Message.DocFamily, f_Message.DocID, f_Message.IsObjTopic, Tk2TypeTable.GetInstance.TypeByName[f_Message.DocumentType],
      f_Message.DocPart, f_Message.Level, f_Message.WithAttr, f_Message.DocPartSel, l_FoundSelector, l_Gen, l_ReadFiler);
    finally
     FreeAndNil(l_FoundSelector);
    end;
    try
     TevdNativeReader.SetTo(l_Gen);
     TevdNativeReader(l_Gen).Filer := l_ReadFiler;
     TevdNativeReader(l_Gen).Execute;
    finally
     FreeAndNil(l_ReadFiler);
    end;
   finally
    FreeAndNil(l_Gen);
   end;
   f_Reply.ErrorMessage := '';
   f_Reply.IsSuccess := True;
  except
   on E: Exception do
   begin
    f_Reply.ErrorMessage := E.Message;
    f_Reply.IsSuccess := False;
   end;
  end;
 finally
  l_Counter.Stop;
  SignalReady;
  l3System.Msg2Log('Remote read document - %s', [FormatFloat('#,##0 ms', l_Counter.Time * 1000)], l3_msgLevel10);
 end;
//#UC END# *53A2EEE90097_57C3FAF20200_impl*
end;//TalcuDownloadDocRequest.DoRun
{$IfEnd} // NOT Defined(Nemesis)

{$If NOT Defined(Nemesis)}
procedure TalcuDownloadDocRequest.DoAbort;
//#UC START# *57C4135700F7_57C3FAF20200_var*
//#UC END# *57C4135700F7_57C3FAF20200_var*
begin
//#UC START# *57C4135700F7_57C3FAF20200_impl*
 f_Reply.ErrorMessage := 'Операция прервана';
 SignalReady;
//#UC END# *57C4135700F7_57C3FAF20200_impl*
end;//TalcuDownloadDocRequest.DoAbort
{$IfEnd} // NOT Defined(Nemesis)

class function TalcuDownloadDocRequest.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typDownloadDocRequest;
end;//TalcuDownloadDocRequest.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
