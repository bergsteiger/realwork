unit alcuTaskFileTransferServices;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuTaskFileTransferServices.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::TaskSend::TalcuTaskFileTransferServices
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  l3ProtoObject
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsMessageInterfaces
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuTaskFileTransferServices = class(Tl3ProtoObject {$If not defined(Nemesis)}, IcsFileTransferServices{$IfEnd} //not Nemesis
 )
 private
 // private fields
   f_Transporter : IncsTransporter;
   f_TaskID : AnsiString;
 protected
 // realized methods
   {$If not defined(Nemesis)}
   function TransferFile(const aTargetFolder: AnsiString;
    const aSourceFileName: AnsiString;
    const aTargetFileName: AnsiString): Boolean;
   {$IfEnd} //not Nemesis
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aTransporter: IncsTransporter;
     const aTaskID: AnsiString); reintroduce;
   class function Make(const aTransporter: IncsTransporter;
     const aTaskID: AnsiString): IcsFileTransferServices; reintroduce;
     {* Сигнатура фабрики TalcuTaskFileTransferServices.Make }
 end;//TalcuTaskFileTransferServices
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  ncsGetTaskDescriptionReply
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsGetPartialTaskDescription
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsOneFileDeliverer
  {$IfEnd} //not Nemesis
  ,
  SysUtils
  {$If not defined(Nemesis)}
  ,
  ncsMessage
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsFileDescHelper
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsFileDesc
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuTaskFileTransferServices

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
end;

{$If not defined(Nemesis)}
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
{$IfEnd} //not Nemesis

procedure TalcuTaskFileTransferServices.Cleanup;
//#UC START# *479731C50290_54B638150163_var*
//#UC END# *479731C50290_54B638150163_var*
begin
//#UC START# *479731C50290_54B638150163_impl*
 f_Transporter := nil;
 inherited;
//#UC END# *479731C50290_54B638150163_impl*
end;//TalcuTaskFileTransferServices.Cleanup

{$IfEnd} //ServerTasks

end.