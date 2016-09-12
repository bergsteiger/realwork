unit alcuUploadDocRequest;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuUploadDocRequest.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuUploadDocRequest" MUID: (57D659B902A8)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuWaitableRequest
 {$If NOT Defined(Nemesis)}
 , csUploadDocStream
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csUploadDocStreamReply
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_IFltr
 {$IfEnd} // NOT Defined(Nemesis)
 , k2Base
 {$If NOT Defined(Nemesis)}
 , ddProcessTaskPrim
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuUploadDocRequest = class(TalcuWaitableRequest)
  private
   f_Message: TcsUploadDocStream;
   f_Reply: TcsUploadDocStreamReply;
   f_OnEraseNotify: TdtOnEraseAttrRecords;
  protected
   procedure pm_SetMessage(aValue: TcsUploadDocStream);
   procedure pm_SetReply(aValue: TcsUploadDocStreamReply);
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
   property Message: TcsUploadDocStream
    read f_Message
    write pm_SetMessage;
   property Reply: TcsUploadDocStreamReply
    read f_Reply
    write pm_SetReply;
   property OnEraseNotify: TdtOnEraseAttrRecords
    read f_OnEraseNotify
    write f_OnEraseNotify;
 end;//TalcuUploadDocRequest
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , l3Filer
 , SysUtils
 , nevInternalInterfaces
 , l3Interfaces
 , evdNativeWriter
 , evdNativeReader
 , arDocAttributesMixer
 , l3StopWatch
 , m3DBInterfaces
 , m3DBFiler
 {$If NOT Defined(Nemesis)}
 , dt_Serv
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Types
 , dt_Types
 , l3Base
 , UploadDocRequest_Const
 //#UC START# *57D659B902A8impl_uses*
 //#UC END# *57D659B902A8impl_uses*
;

procedure TalcuUploadDocRequest.pm_SetMessage(aValue: TcsUploadDocStream);
//#UC START# *57D65B91025A_57D659B902A8set_var*
//#UC END# *57D65B91025A_57D659B902A8set_var*
begin
//#UC START# *57D65B91025A_57D659B902A8set_impl*
 aValue.SetRefTo(f_Message);
//#UC END# *57D65B91025A_57D659B902A8set_impl*
end;//TalcuUploadDocRequest.pm_SetMessage

procedure TalcuUploadDocRequest.pm_SetReply(aValue: TcsUploadDocStreamReply);
//#UC START# *57D65BA4026B_57D659B902A8set_var*
//#UC END# *57D65BA4026B_57D659B902A8set_var*
begin
//#UC START# *57D65BA4026B_57D659B902A8set_impl*
 aValue.SetRefTo(f_Reply);
//#UC END# *57D65BA4026B_57D659B902A8set_impl*
end;//TalcuUploadDocRequest.pm_SetReply

procedure TalcuUploadDocRequest.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57D659B902A8_var*
//#UC END# *479731C50290_57D659B902A8_var*
begin
//#UC START# *479731C50290_57D659B902A8_impl*
 FreeAndNil(f_Message);
 FreeAndNil(f_Reply);
 inherited;
//#UC END# *479731C50290_57D659B902A8_impl*
end;//TalcuUploadDocRequest.Cleanup

{$If NOT Defined(Nemesis)}
procedure TalcuUploadDocRequest.DoRun(const aContext: TddRunContext);
//#UC START# *53A2EEE90097_57D659B902A8_var*
var
 l_DB: Im3DB;
 l_ComStream: IStream;
 l_NeedOpenFiler: Boolean;
 l_WriteFiler: Tl3CustomFiler;
 l_ReadFiler: Tl3CustomFiler;
 l_Generator: Tk2TagGenerator;
 l_Counter: Tl3StopWatch;
//#UC END# *53A2EEE90097_57D659B902A8_var*
begin
//#UC START# *53A2EEE90097_57D659B902A8_impl*
 l_NeedOpenFiler := False;
 l_Counter.Reset;
 l_Counter.Start;
 try
  try
   l_DB := dtGetDB(f_Message.DocFamily);
   try
    l_WriteFiler := Tm3DBFiler.Create(l_DB, f_Message.DocID, f_Message.DocPart);
   finally
    l_DB := nil;
   end;//try..finally
   try
    l_WriteFiler.Mode := l3_fmReadWrite;
    l_NeedOpenFiler := (f_Message.DocClass <> dtNone) and f_Message.NeedSaveText;
    if l_NeedOpenFiler then
     l_WriteFiler.Open;
    try
     if f_Message.IsClassChanged and (Tm3DBFiler(l_WriteFiler).Part <> nil) then
      Tm3DBFiler(l_WriteFiler).Part.Info := Tm3DBDocumentInfo_C(ord(f_Message.DocClass));


     l_Generator := nil;
     try
      if f_Message.NeedSaveText then
      begin
       TevdNativeWriter.SetTo(l_Generator);
       with TevdNativeWriter(l_Generator) do
       begin
        Filer := l_WriteFiler;
        Binary := true;
       end;
      end;

      if f_Message.ParseToDB then
       BuildDocSavePipe(f_Message.DocFamily, f_Message.DocID, f_Message.IsObjTopic, f_OnEraseNotify, l_Generator);

      TevdNativeReader.SetTo(l_Generator);
      l_ComStream := f_Message.Data as IStream;
      try
       l_ReadFiler := Tl3CustomFiler.Create(nil);
       l_ReadFiler.COMStream := l_ComStream;
      finally
       l_ComStream := nil;
      end;
      try
       TevdNativeReader(l_Generator).Filer := l_ReadFiler;
       TevdNativeReader(l_Generator).Execute;
      finally
       FreeAndNil(l_ReadFiler);
      end;
     finally
      FreeAndNil(l_Generator);
     end;
    finally
     if l_NeedOpenFiler then
      l_WriteFiler.Open;
    end;
   finally
    FreeAndNil(l_WriteFiler);
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
  l3System.Msg2Log('Remote write document - %s', [FormatFloat('#,##0 ms', l_Counter.Time * 1000)], l3_msgLevel10);
 end;
//#UC END# *53A2EEE90097_57D659B902A8_impl*
end;//TalcuUploadDocRequest.DoRun
{$IfEnd} // NOT Defined(Nemesis)

{$If NOT Defined(Nemesis)}
procedure TalcuUploadDocRequest.DoAbort;
//#UC START# *57C4135700F7_57D659B902A8_var*
//#UC END# *57C4135700F7_57D659B902A8_var*
begin
//#UC START# *57C4135700F7_57D659B902A8_impl*
 f_Reply.ErrorMessage := 'Операция прервана';
 SignalReady;
//#UC END# *57C4135700F7_57D659B902A8_impl*
end;//TalcuUploadDocRequest.DoAbort
{$IfEnd} // NOT Defined(Nemesis)

class function TalcuUploadDocRequest.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typUploadDocRequest;
end;//TalcuUploadDocRequest.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
