unit alcuMultiChangeHyperLinksRequest;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuMultiChangeHyperLinksRequest.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMultiChangeHyperLinksRequest" MUID: (5804C11A02A3)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuWaitableRequest
 {$If NOT Defined(Nemesis)}
 , csMultiChangeHyperLinks
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiChangeHyperLinksReply
 {$IfEnd} // NOT Defined(Nemesis)
 , k2Base
 {$If NOT Defined(Nemesis)}
 , ddProcessTaskPrim
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuMultiChangeHyperLinksRequest = class(TalcuWaitableRequest)
  private
   f_Message: TcsMultiChangeHyperLinks;
   f_Reply: TcsMultiChangeHyperLinksReply;
  protected
   procedure pm_SetMessage(aValue: TcsMultiChangeHyperLinks);
   procedure pm_SetReply(aValue: TcsMultiChangeHyperLinksReply);
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
   property Message: TcsMultiChangeHyperLinks
    read f_Message
    write pm_SetMessage;
   property Reply: TcsMultiChangeHyperLinksReply
    read f_Reply
    write pm_SetReply;
 end;//TalcuMultiChangeHyperLinksRequest
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , l3Types
 , l3StopWatch
 , SysUtils
 , arDirectMultiChangeHyperLinksHelper
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Doc
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Base
 , MultiChangeHyperLinksRequest_Const
 //#UC START# *5804C11A02A3impl_uses*
 //#UC END# *5804C11A02A3impl_uses*
;

procedure TalcuMultiChangeHyperLinksRequest.pm_SetMessage(aValue: TcsMultiChangeHyperLinks);
//#UC START# *5804C13702E9_5804C11A02A3set_var*
//#UC END# *5804C13702E9_5804C11A02A3set_var*
begin
//#UC START# *5804C13702E9_5804C11A02A3set_impl*
 aValue.SetRefTo(f_Message);
//#UC END# *5804C13702E9_5804C11A02A3set_impl*
end;//TalcuMultiChangeHyperLinksRequest.pm_SetMessage

procedure TalcuMultiChangeHyperLinksRequest.pm_SetReply(aValue: TcsMultiChangeHyperLinksReply);
//#UC START# *5804C15C0158_5804C11A02A3set_var*
//#UC END# *5804C15C0158_5804C11A02A3set_var*
begin
//#UC START# *5804C15C0158_5804C11A02A3set_impl*
 aValue.SetRefTo(f_Reply);
//#UC END# *5804C15C0158_5804C11A02A3set_impl*
end;//TalcuMultiChangeHyperLinksRequest.pm_SetReply

procedure TalcuMultiChangeHyperLinksRequest.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5804C11A02A3_var*
//#UC END# *479731C50290_5804C11A02A3_var*
begin
//#UC START# *479731C50290_5804C11A02A3_impl*
 FreeAndNil(f_Message);
 FreeAndNil(f_Reply);
 inherited;
//#UC END# *479731C50290_5804C11A02A3_impl*
end;//TalcuMultiChangeHyperLinksRequest.Cleanup

{$If NOT Defined(Nemesis)}
procedure TalcuMultiChangeHyperLinksRequest.DoRun(const aContext: TddRunContext);
//#UC START# *53A2EEE90097_5804C11A02A3_var*
var
 l_Helper: TarDirectMultiChangeHyperLinksHelper;
 l_Counter: Tl3StopWatch;
 l_Sab: ISab;
//#UC END# *53A2EEE90097_5804C11A02A3_var*
begin
//#UC START# *53A2EEE90097_5804C11A02A3_impl*
 l_Counter.Reset;
 l_Counter.Start;
 try
  try
   DocumentServer.Family := f_Message.FamilyID;
   l_Sab := MakeValueSet(DocumentServer.FileTbl, fID_Fld, f_Message.DocumentIDList);
   try
    l_Helper := TarDirectMultiChangeHyperLinksHelper.Create(f_Message.FamilyID, f_Message.OldDocID, f_Message.NewDocID, l_Sab);
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
  l3System.Msg2Log('Remote multi change hyperlinks exec - %s', [FormatFloat('#,##0 ms', l_Counter.Time * 1000)], l3_msgLevel10);
 end;
//#UC END# *53A2EEE90097_5804C11A02A3_impl*
end;//TalcuMultiChangeHyperLinksRequest.DoRun
{$IfEnd} // NOT Defined(Nemesis)

{$If NOT Defined(Nemesis)}
procedure TalcuMultiChangeHyperLinksRequest.DoAbort;
//#UC START# *57C4135700F7_5804C11A02A3_var*
//#UC END# *57C4135700F7_5804C11A02A3_var*
begin
//#UC START# *57C4135700F7_5804C11A02A3_impl*
 f_Reply.ErrorMessage := 'Операция прервана';
 SignalReady;
//#UC END# *57C4135700F7_5804C11A02A3_impl*
end;//TalcuMultiChangeHyperLinksRequest.DoAbort
{$IfEnd} // NOT Defined(Nemesis)

class function TalcuMultiChangeHyperLinksRequest.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typMultiChangeHyperLinksRequest;
end;//TalcuMultiChangeHyperLinksRequest.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
