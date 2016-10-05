unit alcuMultiModifyDocsRequest;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuMultiModifyDocsRequest.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMultiModifyDocsRequest" MUID: (57E4EE570331)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuWaitableRequest
 {$If NOT Defined(Nemesis)}
 , csMultiModifyDocs
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiModifyDocsReply
 {$IfEnd} // NOT Defined(Nemesis)
 , k2Base
 {$If NOT Defined(Nemesis)}
 , ddProcessTaskPrim
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuMultiModifyDocsRequest = class(TalcuWaitableRequest)
  private
   f_Message: TcsMultiModifyDocs;
   f_Reply: TcsMultiModifyDocsReply;
  protected
   procedure pm_SetMessage(aValue: TcsMultiModifyDocs);
   procedure pm_SetReply(aValue: TcsMultiModifyDocsReply);
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
   property Message: TcsMultiModifyDocs
    read f_Message
    write pm_SetMessage;
   property Reply: TcsMultiModifyDocsReply
    read f_Reply
    write pm_SetReply;
 end;//TalcuMultiModifyDocsRequest
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , evdNativeWriter
 , nevInternalInterfaces
 , SysUtils
 , l3StopWatch
 , arDocAttributesMixer
 , l3Base
 , l3Filer
 , evdNativeReader
 , l3IDList
 , arDirectMultiModifyDocsHelper
 , l3DatLst
 , evdTasksHelpers
 , l3Types
 , MultiModifyDocsRequest_Const
 //#UC START# *57E4EE570331impl_uses*
 //#UC END# *57E4EE570331impl_uses*
;

procedure TalcuMultiModifyDocsRequest.pm_SetMessage(aValue: TcsMultiModifyDocs);
//#UC START# *57E4EE7C0269_57E4EE570331set_var*
//#UC END# *57E4EE7C0269_57E4EE570331set_var*
begin
//#UC START# *57E4EE7C0269_57E4EE570331set_impl*
 aValue.SetRefTo(f_Message);
//#UC END# *57E4EE7C0269_57E4EE570331set_impl*
end;//TalcuMultiModifyDocsRequest.pm_SetMessage

procedure TalcuMultiModifyDocsRequest.pm_SetReply(aValue: TcsMultiModifyDocsReply);
//#UC START# *57E4EE9900E4_57E4EE570331set_var*
//#UC END# *57E4EE9900E4_57E4EE570331set_var*
begin
//#UC START# *57E4EE9900E4_57E4EE570331set_impl*
 aValue.SetRefTo(f_Reply);
//#UC END# *57E4EE9900E4_57E4EE570331set_impl*
end;//TalcuMultiModifyDocsRequest.pm_SetReply

procedure TalcuMultiModifyDocsRequest.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E4EE570331_var*
//#UC END# *479731C50290_57E4EE570331_var*
begin
//#UC START# *479731C50290_57E4EE570331_impl*
 FreeAndNil(f_Message);
 FreeAndNil(f_Reply);
 inherited;
//#UC END# *479731C50290_57E4EE570331_impl*
end;//TalcuMultiModifyDocsRequest.Cleanup

{$If NOT Defined(Nemesis)}
procedure TalcuMultiModifyDocsRequest.DoRun(const aContext: TddRunContext);
//#UC START# *53A2EEE90097_57E4EE570331_var*
var
 l_Helper: TarDirectMultiModifyDocsHelper;

 l_ReadFiler: Tl3CustomFiler;
 l_Generator: Tk2TagGenerator;
 l_Counter: Tl3StopWatch;
 l_IDList: Tl3IDList;
 l_DataList: Tl3StringDataList;
 l_RejectedList: RejectedIDListHelper;
 l_ID: Cardinal;
 l_IDX: Integer;
//#UC END# *53A2EEE90097_57E4EE570331_var*
begin
//#UC START# *53A2EEE90097_57E4EE570331_impl*
 l_Counter.Reset;
 l_Counter.Start;
 try
  l_IDList := Tl3IDList.Create;
  try
   f_Message.DocIDList.ToList(l_IDList);
   l_Helper := TarDirectMultiModifyDocsHelper.Create(f_Message.ActionType,
    f_Message.FamilyID, f_Message.AnouncedDate, l_IDList as Il3IDList);
  finally
   FreeAndNil(l_IDList);
  end;
  try
   try
    l_Generator := nil;
    l_Helper.Generator.SetRefTo(l_Generator);
    try
     TevdNativeReader.SetTo(l_Generator);
     l_ReadFiler := MakeFilerForMessage(f_Message.Data);
     try
      TevdNativeReader(l_Generator).Filer := l_ReadFiler;
      try
       try
        TevdNativeReader(l_Generator).Execute;
       except
        l_Helper.SignalException;
        raise;
       end;
      finally
       l_Helper.ModifyDocs;
      end;
     finally
      FreeAndNil(l_ReadFiler);
     end;
    finally
     FreeAndNil(l_Generator);
    end;

    if l_Helper.HasLockedDocs then
    begin
     l_RejectedList := f_Reply.RejectedIDList;
     l_DataList := Tl3StringDataList.Create;
     try
      l_Helper.FillLockedList(l_DataList);
      Assert(l_DataList.DataSize <= SizeOf(l_ID));
      for l_IDX := 0 to l_DataList.Count - 1 do
      begin
        l_ID := 0;
        System.Move(l_DataList.Data[l_IDX]^, l_ID, l_DataList.DataSize);
        l_RejectedList.Add(l_ID, l_DataList.PasStr[l_IDX]);
      end;
     finally
      FreeAndNil(l_DataList);
     end;
    end;

    f_Reply.ErrorMessage := '';
    f_Reply.IsSuccess := True;
   except
    on E: Exception do
    begin
     f_Reply.ErrorMessage := E.Message;
     f_Reply.IsSuccess := False;
     l_Helper.SignalException;
     l3System.Exception2Log(E);
    end;
   end;
  finally
   FreeAndNil(l_Helper);
  end;
 finally
  l_Counter.Stop;
  SignalReady;
  l3System.Msg2Log('Remote multimodify documents - %s', [FormatFloat('#,##0 ms', l_Counter.Time * 1000)], l3_msgLevel10);
 end;
//#UC END# *53A2EEE90097_57E4EE570331_impl*
end;//TalcuMultiModifyDocsRequest.DoRun
{$IfEnd} // NOT Defined(Nemesis)

{$If NOT Defined(Nemesis)}
procedure TalcuMultiModifyDocsRequest.DoAbort;
//#UC START# *57C4135700F7_57E4EE570331_var*
//#UC END# *57C4135700F7_57E4EE570331_var*
begin
//#UC START# *57C4135700F7_57E4EE570331_impl*
 f_Reply.ErrorMessage := 'Операция прервана';
 SignalReady;
//#UC END# *57C4135700F7_57E4EE570331_impl*
end;//TalcuMultiModifyDocsRequest.DoAbort
{$IfEnd} // NOT Defined(Nemesis)

class function TalcuMultiModifyDocsRequest.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typMultiModifyDocsRequest;
end;//TalcuMultiModifyDocsRequest.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
