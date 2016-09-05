unit alcuTaskFileTransferServices;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskFileTransferServices.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuTaskFileTransferServices" MUID: (54B638150163)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsMessageInterfaces
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuTaskFileTransferServices = class(Tl3ProtoObject{$If NOT Defined(Nemesis)}
 , IcsFileTransferServices
 {$IfEnd} // NOT Defined(Nemesis)
 )
  private
   f_Transporter: IncsTransporter;
   f_TaskID: AnsiString;
  protected
   {$If NOT Defined(Nemesis)}
   function TransferFile(const aTargetFolder: AnsiString;
    const aSourceFileName: AnsiString;
    const aTargetFileName: AnsiString): Boolean;
   {$IfEnd} // NOT Defined(Nemesis)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTransporter: IncsTransporter;
    const aTaskID: AnsiString); reintroduce;
   class function Make(const aTransporter: IncsTransporter;
    const aTaskID: AnsiString): IcsFileTransferServices; reintroduce;
 end;//TalcuTaskFileTransferServices
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , ncsGetTaskDescriptionReply
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsGetPartialTaskDescription
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsOneFileDeliverer
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , ncsMessage
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsFileDescHelper
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsFileDesc
 {$IfEnd} // NOT Defined(Nemesis)
 //#UC START# *54B638150163impl_uses*
 //#UC END# *54B638150163impl_uses*
;

constructor TalcuTaskFileTransferServices.Create(const aTransporter: IncsTransporter;
 const aTaskID: AnsiString);
//#UC START# *54B64A7C0177_54B638150163_var*
//#UC END# *54B64A7C0177_54B638150163_var*
begin
//#UC START# *54B64A7C0177_54B638150163_impl*
 inherited Create;
 f_Transporter := aTransporter;
 f_TaskID := aTaskID;
//#UC END# *54B64A7C0177_54B638150163_impl*
end;//TalcuTaskFileTransferServices.Create

class function TalcuTaskFileTransferServices.Make(const aTransporter: IncsTransporter;
 const aTaskID: AnsiString): IcsFileTransferServices;
var
 l_Inst : TalcuTaskFileTransferServices;
begin
 l_Inst := Create(aTransporter, aTaskID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TalcuTaskFileTransferServices.Make

{$If NOT Defined(Nemesis)}
function TalcuTaskFileTransferServices.TransferFile(const aTargetFolder: AnsiString;
 const aSourceFileName: AnsiString;
 const aTargetFileName: AnsiString): Boolean;
//#UC START# *54B62A0501D7_54B638150163_var*
var
 l_Message: TncsGetPartialTaskDescription;
 l_Reply: TncsGetTaskDescriptionReply;
 l_Deliverer: TncsOneFileDeliverer;
 l_RawReply: TncsMessage;
 l_FileList: FileDescHelper;
 l_FileDesc: TncsFileDesc;
//#UC END# *54B62A0501D7_54B638150163_var*
begin
//#UC START# *54B62A0501D7_54B638150163_impl*
 Result := False;
 if not f_Transporter.Processing then
  Exit;
 l_Reply := nil;
 l_Message := TncsGetPartialTaskDescription.Create;
 try
  l_Message.TaskID := f_TaskID;
  l_Message.FileName := aSourceFileName;
  f_Transporter.Send(l_Message);
  l_RawReply := nil;
  if f_Transporter.WaitForReply(l_Message, l_RawReply) then
  try
   if l_RawReply is TncsGetTaskDescriptionReply then
   begin
    l_Reply := TncsGetTaskDescriptionReply(l_RawReply);
    l_FileList := l_Reply.FileDesc;
    try
     Assert(l_FileList.Count < 2);
     if l_FileList.Count = 1 then
     begin
      l_FileDesc := TncsFileDesc.Create;
      try
       l_FileDesc.SetTaggedData(l_FileList.Files[0]);
       l_Deliverer := TncsOneFileDeliverer.Create(f_Transporter, f_TaskID, IncludeTrailingPathDelimiter(aTargetFolder), l_FileDesc);
       try
        if l_Deliverer.DoProcess(nil) then
        begin
         Result := True;
         l_Deliverer.CommitDelivery;
        end;
       finally
        FreeAndNil(l_Deliverer);
       end;
      finally
       FreeAndNil(l_FileDesc);
      end;
     end;
    finally
     l_FileList := nil;
    end;
   end;
  finally
   FreeAndNil(l_RawReply);
  end;
 finally
  FreeAndNil(l_Message);
 end;
//#UC END# *54B62A0501D7_54B638150163_impl*
end;//TalcuTaskFileTransferServices.TransferFile
{$IfEnd} // NOT Defined(Nemesis)

procedure TalcuTaskFileTransferServices.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54B638150163_var*
//#UC END# *479731C50290_54B638150163_var*
begin
//#UC START# *479731C50290_54B638150163_impl*
 f_Transporter := nil;
 inherited;
//#UC END# *479731C50290_54B638150163_impl*
end;//TalcuTaskFileTransferServices.Cleanup
{$IfEnd} // Defined(ServerTasks)

end.
