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
 , SysUtils
 , nevInternalInterfaces
 , evdNativeReader
 , arDirectSaveDocumentHelper
 , l3StopWatch
 , l3Base
 , arDocAttributesMixer
 , l3Filer
 , l3Types
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
 l_Helper: TarDirectSaveDocumentHelper;

 l_ReadFiler: Tl3CustomFiler;
 l_Generator: Tk2TagGenerator;
 l_Counter: Tl3StopWatch;
//#UC END# *53A2EEE90097_57D659B902A8_var*
begin
//#UC START# *53A2EEE90097_57D659B902A8_impl*
 l_Counter.Reset;
 l_Counter.Start;
 try
  l_Helper := TarDirectSaveDocumentHelper.Create(f_Message.DocFamily, f_Message.DocID,
   f_Message.DocClass, f_Message.DocPart, f_Message.ParseToDB, f_Message.NeedSaveText,
   f_Message.IsClassChanged, f_OnEraseNotify, f_Message.IsObjTopic);
  try
   try
    l_Generator := nil;
    l_Helper.Generator.SetRefTo(l_Generator);
    try
     TevdNativeReader.SetTo(l_Generator);
     l_ReadFiler := MakeFilerForMessage(f_Message.Data);
     try
      TevdNativeReader(l_Generator).Filer := l_ReadFiler;
      TevdNativeReader(l_Generator).Execute;
      l_Helper.SaveDoc;
     finally
      FreeAndNil(l_ReadFiler);
     end;
    finally
     FreeAndNil(l_Generator);
    end;
    f_Reply.ErrorMessage := '';
    f_Reply.IsSuccess := True;
   except
    on E: Exception do
    begin
     f_Reply.ErrorMessage := E.Message;
     f_Reply.IsSuccess := False;
     l_Helper.HandleException;
     l3System.Exception2Log(E);
    end;
   end;
  finally
   FreeAndNil(l_Helper);
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
