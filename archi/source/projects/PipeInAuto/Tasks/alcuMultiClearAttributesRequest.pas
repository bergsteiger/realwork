unit alcuMultiClearAttributesRequest;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuMultiClearAttributesRequest.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMultiClearAttributesRequest" MUID: (57ECC59F00D4)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuWaitableRequest
 {$If NOT Defined(Nemesis)}
 , csMultiClearAttributes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiClearAttributesReply
 {$IfEnd} // NOT Defined(Nemesis)
 , k2Base
 {$If NOT Defined(Nemesis)}
 , ddProcessTaskPrim
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuMultiClearAttributesRequest = class(TalcuWaitableRequest)
  private
   f_Message: TcsMultiClearAttributes;
   f_Reply: TcsMultiClearAttributesReply;
  protected
   procedure pm_SetMessage(aValue: TcsMultiClearAttributes);
   procedure pm_SetReply(aValue: TcsMultiClearAttributesReply);
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
   property Message: TcsMultiClearAttributes
    read f_Message
    write pm_SetMessage;
   property Reply: TcsMultiClearAttributesReply
    read f_Reply
    write pm_SetReply;
 end;//TalcuMultiClearAttributesRequest
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , l3Types
 , l3StopWatch
 , SysUtils
 , evdTasksHelpers
 , l3IDList
 , l3DatLst
 , l3Base
 , arDirectMultiClearAttributesHelper
 , daTypes
 , MultiClearAttributesRequest_Const
 //#UC START# *57ECC59F00D4impl_uses*
 //#UC END# *57ECC59F00D4impl_uses*
;

procedure TalcuMultiClearAttributesRequest.pm_SetMessage(aValue: TcsMultiClearAttributes);
//#UC START# *57ECC5BA02DA_57ECC59F00D4set_var*
//#UC END# *57ECC5BA02DA_57ECC59F00D4set_var*
begin
//#UC START# *57ECC5BA02DA_57ECC59F00D4set_impl*
 aValue.SetRefTo(f_Message);
//#UC END# *57ECC5BA02DA_57ECC59F00D4set_impl*
end;//TalcuMultiClearAttributesRequest.pm_SetMessage

procedure TalcuMultiClearAttributesRequest.pm_SetReply(aValue: TcsMultiClearAttributesReply);
//#UC START# *57ECC5D70126_57ECC59F00D4set_var*
//#UC END# *57ECC5D70126_57ECC59F00D4set_var*
begin
//#UC START# *57ECC5D70126_57ECC59F00D4set_impl*
 aValue.SetRefTo(f_Reply);
//#UC END# *57ECC5D70126_57ECC59F00D4set_impl*
end;//TalcuMultiClearAttributesRequest.pm_SetReply

procedure TalcuMultiClearAttributesRequest.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57ECC59F00D4_var*
//#UC END# *479731C50290_57ECC59F00D4_var*
begin
//#UC START# *479731C50290_57ECC59F00D4_impl*
 FreeAndNil(f_Message);
 FreeAndNil(f_Reply);
 inherited;
//#UC END# *479731C50290_57ECC59F00D4_impl*
end;//TalcuMultiClearAttributesRequest.Cleanup

{$If NOT Defined(Nemesis)}
procedure TalcuMultiClearAttributesRequest.DoRun(const aContext: TddRunContext);
//#UC START# *53A2EEE90097_57ECC59F00D4_var*
var
 l_Helper: TarDirectMultiClearAttributesHelper;
 l_IDList: Tl3IDList;
 l_SelectedArray: TdaDictionaryTypeArray;
 l_IDX: Integer;
 l_RejectedList: RejectedIDListHelper;
 l_Counter: Tl3StopWatch;
 l_DataList: Tl3StringDataList;
 l_ID: Cardinal;
//#UC END# *53A2EEE90097_57ECC59F00D4_var*
begin
//#UC START# *53A2EEE90097_57ECC59F00D4_impl*
 l_Counter.Reset;
 l_Counter.Start;
 try
  l_IDList := Tl3IDList.Create;
  try
   f_Message.DocIDList.ToList(l_IDList);
   SetLength(l_SelectedArray, f_Message.Attributes.Count);
   for l_IDX := Low(l_SelectedArray) to High(l_SelectedArray) do
    l_SelectedArray[l_IDX] := TdaDictionaryType(f_Message.Attributes.Items[l_IDX]);
   l_Helper := TarDirectMultiClearAttributesHelper.Create(f_Message.FamilyID, l_IDList, f_Message.RightsNeeded, l_SelectedArray);
  finally
   FreeAndNil(l_IDList);
  end;
  try
   try
    l_Helper.ClearAttributes;
    if l_Helper.HasRejectedDocs then
    begin
     l_RejectedList := f_Reply.RejectedIDList;
     l_DataList := Tl3StringDataList.Create;
     try
      l_Helper.FillRejectedList(l_DataList);
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
//#UC END# *53A2EEE90097_57ECC59F00D4_impl*
end;//TalcuMultiClearAttributesRequest.DoRun
{$IfEnd} // NOT Defined(Nemesis)

{$If NOT Defined(Nemesis)}
procedure TalcuMultiClearAttributesRequest.DoAbort;
//#UC START# *57C4135700F7_57ECC59F00D4_var*
//#UC END# *57C4135700F7_57ECC59F00D4_var*
begin
//#UC START# *57C4135700F7_57ECC59F00D4_impl*
 f_Reply.ErrorMessage := 'Операция прервана';
 SignalReady;
//#UC END# *57C4135700F7_57ECC59F00D4_impl*
end;//TalcuMultiClearAttributesRequest.DoAbort
{$IfEnd} // NOT Defined(Nemesis)

class function TalcuMultiClearAttributesRequest.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typMultiClearAttributesRequest;
end;//TalcuMultiClearAttributesRequest.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
