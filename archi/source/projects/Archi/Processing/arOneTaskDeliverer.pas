unit arOneTaskDeliverer;

// Модуль: "w:\archi\source\projects\Archi\Processing\arOneTaskDeliverer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarOneTaskDeliverer" MUID: (546AFE0D01CB)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsGetTaskDescriptionReply
 {$IfEnd} // NOT Defined(Nemesis)
 , ddProgressObj
 , evdNcsTypes
;

type
 TarOneTaskDeliverer = class(Tl3ProtoObject)
  private
   f_Transporter: IncsTransporter;
   f_TaskID: AnsiString;
   f_Reply: TncsGetTaskDescriptionReply;
   f_ProgressDescription: AnsiString;
   f_ProgressPercent: Integer;
   f_Progressor: TddProgressObject;
   f_ReceiveTime: Double;
  private
   procedure ProgressUpdate(Sender: TObject;
    aTotalPercent: Integer);
   procedure SetProgress(aNewPercent: Integer;
    const aNewDescription: AnsiString);
  protected
   function pm_GetTargetFolder: AnsiString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTransporter: IncsTransporter;
    const aTaskID: AnsiString); reintroduce;
   function Execute: TncsResultKind;
  public
   property TargetFolder: AnsiString
    read pm_GetTargetFolder;
   property ReceiveTime: Double
    read f_ReceiveTime;
 end;//TarOneTaskDeliverer
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , ncsGetTaskDescription
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsMessage
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsFileListDeliverer
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Base
 {$If NOT Defined(Nemesis)}
 , ncsTaskProgress
 {$IfEnd} // NOT Defined(Nemesis)
 //#UC START# *546AFE0D01CBimpl_uses*
 //#UC END# *546AFE0D01CBimpl_uses*
;

function TarOneTaskDeliverer.pm_GetTargetFolder: AnsiString;
//#UC START# *546AFEAB00E6_546AFE0D01CBget_var*
//#UC END# *546AFEAB00E6_546AFE0D01CBget_var*
begin
//#UC START# *546AFEAB00E6_546AFE0D01CBget_impl*
 if Assigned(f_Reply) then
  Result := f_Reply.LocalFolder
 else
  Result := '';
//#UC END# *546AFEAB00E6_546AFE0D01CBget_impl*
end;//TarOneTaskDeliverer.pm_GetTargetFolder

constructor TarOneTaskDeliverer.Create(const aTransporter: IncsTransporter;
 const aTaskID: AnsiString);
//#UC START# *546AFEF1001C_546AFE0D01CB_var*
//#UC END# *546AFEF1001C_546AFE0D01CB_var*
begin
//#UC START# *546AFEF1001C_546AFE0D01CB_impl*
 inherited Create;
 f_Transporter := aTransporter;
 f_TaskID := aTaskID;
 f_Progressor := TddProgressObject.Create;
 f_Progressor.AllowProgressDecrement := True;
 f_Progressor.OnUpdate := ProgressUpdate;
 f_ReceiveTime := 0;
//#UC END# *546AFEF1001C_546AFE0D01CB_impl*
end;//TarOneTaskDeliverer.Create

procedure TarOneTaskDeliverer.ProgressUpdate(Sender: TObject;
 aTotalPercent: Integer);
//#UC START# *5474528D0320_546AFE0D01CB_var*
//#UC END# *5474528D0320_546AFE0D01CB_var*
begin
//#UC START# *5474528D0320_546AFE0D01CB_impl*
 SetProgress(f_Progressor.TotalPercent, f_Progressor.Caption);
//#UC END# *5474528D0320_546AFE0D01CB_impl*
end;//TarOneTaskDeliverer.ProgressUpdate

procedure TarOneTaskDeliverer.SetProgress(aNewPercent: Integer;
 const aNewDescription: AnsiString);
//#UC START# *547452F8012B_546AFE0D01CB_var*
var
 l_Message: TncsTaskProgress;
//#UC END# *547452F8012B_546AFE0D01CB_var*
begin
//#UC START# *547452F8012B_546AFE0D01CB_impl*
 if (f_ProgressPercent <> aNewPercent) or (f_ProgressDescription <> aNewDescription) then
 begin
  f_ProgressPercent := aNewPercent;
  f_ProgressDescription := aNewDescription;
  l_Message := TncsTaskProgress.Create;
  try
   l_Message.TaskID := f_TaskID;
   l_Message.Percent := f_ProgressPercent;
   l_Message.Description := f_ProgressDescription;
   if f_Transporter.Processing then
    f_Transporter.Send(l_Message)
   else
    l3System.Msg2Log('ALERT - SetProgress on disconected result delivery');
  finally
   FreeAndNil(l_Message);
  end;
 end;
//#UC END# *547452F8012B_546AFE0D01CB_impl*
end;//TarOneTaskDeliverer.SetProgress

function TarOneTaskDeliverer.Execute: TncsResultKind;
//#UC START# *546AFE51021F_546AFE0D01CB_var*
var
 l_TaskDesc: TncsGetTaskDescription;
 l_Reply: TncsMessage;
 l_Deliverer: TncsFileListDeliverer;
const
 cMap: array [Boolean] of TncsResultKind = (ncs_rkFail, ncs_rkOk);
//#UC END# *546AFE51021F_546AFE0D01CB_var*
begin
//#UC START# *546AFE51021F_546AFE0D01CB_impl*
 Result := ncs_rkFail;
 l_TaskDesc := TncsGetTaskDescription.Create;
 try
  l_TaskDesc.TaskID := f_TaskID;
  f_Transporter.Send(l_TaskDesc);
  l_Reply := nil;
  try
   if f_Transporter.WaitForReply(l_TaskDesc, l_Reply) then
   begin
    if not f_Transporter.Processing then
    begin
     l3System.Msg2Log('Обшика доставки - обрыв связи');
     Exit;
    end;
    l_Reply.SetRefTo(f_Reply);
    l_Deliverer := TncsFileListDeliverer.Create(f_Transporter, f_Progressor, f_TaskID, f_Reply.LocalFolder);
    try
     try
      try
       Result := cMap[l_Deliverer.Execute(f_Reply.FileDesc)];
      except
       on E: Exception do
       begin
        l3System.Exception2Log(E);
        raise;
       end;
      end;
     except
      on EOSError do
       Result := ncs_rkRetry;
      on EInOutError do
       Result := ncs_rkRetry;
      on EncsEmptyResults do
       Result := ncs_rkEmpty;
     end;
    finally
     f_ReceiveTime := f_ReceiveTime + l_Deliverer.ReceiveTime;
     FreeAndNil(l_Deliverer);
    end;
   end;
  finally
   FreeAndNil(l_Reply)
  end;
 finally
  FreeAndNil(l_TaskDesc);
 end;
//#UC END# *546AFE51021F_546AFE0D01CB_impl*
end;//TarOneTaskDeliverer.Execute

procedure TarOneTaskDeliverer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_546AFE0D01CB_var*
//#UC END# *479731C50290_546AFE0D01CB_var*
begin
//#UC START# *479731C50290_546AFE0D01CB_impl*
 f_Transporter := nil;
 FreeAndNil(f_Reply);
 FreeAndNil(f_Progressor);
 inherited;
//#UC END# *479731C50290_546AFE0D01CB_impl*
end;//TarOneTaskDeliverer.Cleanup
{$IfEnd} // Defined(AppClientSide)

end.
