unit alcuMultiOperationRequest;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuMultiOperationRequest.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMultiOperationRequest" MUID: (57F206DC02EB)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuWaitableRequest
 {$If NOT Defined(Nemesis)}
 , csMultiOperation
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiOperationReply
 {$IfEnd} // NOT Defined(Nemesis)
 , k2Base
 {$If NOT Defined(Nemesis)}
 , ddProcessTaskPrim
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuMultiOperationRequest = class(TalcuWaitableRequest)
  private
   f_Message: TcsMultiOperation;
   f_Reply: TcsMultiOperationReply;
  protected
   procedure pm_SetMessage(aValue: TcsMultiOperation);
   procedure pm_SetReply(aValue: TcsMultiOperationReply);
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
   property Message: TcsMultiOperation
    read f_Message
    write pm_SetMessage;
   property Reply: TcsMultiOperationReply
    read f_Reply
    write pm_SetReply;
 end;//TalcuMultiOperationRequest
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , l3Types
 , l3StopWatch
 , SysUtils
 , TypInfo
 , l3Base
 , l3IDList
 , arDirectMultiOperationHelper
 , l3MarshalledTypes
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Doc
 {$IfEnd} // NOT Defined(Nemesis)
 , MultiOperationRequest_Const
 //#UC START# *57F206DC02EBimpl_uses*
 //#UC END# *57F206DC02EBimpl_uses*
;

procedure TalcuMultiOperationRequest.pm_SetMessage(aValue: TcsMultiOperation);
//#UC START# *57F207570275_57F206DC02EBset_var*
//#UC END# *57F207570275_57F206DC02EBset_var*
begin
//#UC START# *57F207570275_57F206DC02EBset_impl*
 aValue.SetRefTo(f_Message);
//#UC END# *57F207570275_57F206DC02EBset_impl*
end;//TalcuMultiOperationRequest.pm_SetMessage

procedure TalcuMultiOperationRequest.pm_SetReply(aValue: TcsMultiOperationReply);
//#UC START# *57F20770026C_57F206DC02EBset_var*
//#UC END# *57F20770026C_57F206DC02EBset_var*
begin
//#UC START# *57F20770026C_57F206DC02EBset_impl*
 aValue.SetRefTo(f_Reply);
//#UC END# *57F20770026C_57F206DC02EBset_impl*
end;//TalcuMultiOperationRequest.pm_SetReply

procedure TalcuMultiOperationRequest.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57F206DC02EB_var*
//#UC END# *479731C50290_57F206DC02EB_var*
begin
//#UC START# *479731C50290_57F206DC02EB_impl*
 FreeAndNil(f_Message);
 FreeAndNil(f_Reply);
 inherited;
//#UC END# *479731C50290_57F206DC02EB_impl*
end;//TalcuMultiOperationRequest.Cleanup

{$If NOT Defined(Nemesis)}
procedure TalcuMultiOperationRequest.DoRun(const aContext: TddRunContext);
//#UC START# *53A2EEE90097_57F206DC02EB_var*
var
 l_Helper: TarDirectMultiOperationHelper;
 l_Counter: Tl3StopWatch;
 l_Sab: ISab;
//#UC END# *53A2EEE90097_57F206DC02EB_var*
begin
//#UC START# *53A2EEE90097_57F206DC02EB_impl*
 l_Counter.Reset;
 l_Counter.Start;
 try
  try
   DocumentServer.Family := f_Message.FamilyID;
   l_Sab := MakeValueSet(DocumentServer.FileTbl, fID_Fld, f_Message.DocIDList);
   try
    l_Helper := TarDirectMultiOperationHelper.Create(f_Message.FamilyID, f_Message.Operation, l_Sab);
   finally
    l_Sab := nil;
   end;
   try
    l_Helper.ModifyDocs;
   finally
    FreeAndNil(l_Helper);
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
  l_Counter.Stop;
  SignalReady;
  l3System.Msg2Log('Remote multioperation (%s) exec - %s', [GetEnumName(TypeInfo(TarMultiOperation), Ord(f_Message.Operation)), FormatFloat('#,##0 ms', l_Counter.Time * 1000)], l3_msgLevel10);
 end;
//#UC END# *53A2EEE90097_57F206DC02EB_impl*
end;//TalcuMultiOperationRequest.DoRun
{$IfEnd} // NOT Defined(Nemesis)

{$If NOT Defined(Nemesis)}
procedure TalcuMultiOperationRequest.DoAbort;
//#UC START# *57C4135700F7_57F206DC02EB_var*
//#UC END# *57C4135700F7_57F206DC02EB_var*
begin
//#UC START# *57C4135700F7_57F206DC02EB_impl*
 f_Reply.ErrorMessage := 'Операция прервана';
 SignalReady;
//#UC END# *57C4135700F7_57F206DC02EB_impl*
end;//TalcuMultiOperationRequest.DoAbort
{$IfEnd} // NOT Defined(Nemesis)

class function TalcuMultiOperationRequest.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typMultiOperationRequest;
end;//TalcuMultiOperationRequest.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
