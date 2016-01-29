unit arOneTaskDeliverer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Processing"
// Модуль: "w:/archi/source/projects/Archi/Processing/arOneTaskDeliverer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi::Processing::ExportDelivery::TarOneTaskDeliverer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  l3ProtoObject,
  ddProgressObj
  {$If not defined(Nemesis)}
  ,
  ncsMessageInterfaces
  {$IfEnd} //not Nemesis
  ,
  evdNcsTypes
  {$If not defined(Nemesis)}
  ,
  ncsGetTaskDescriptionReply
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}
type
 TarOneTaskDeliverer = class(Tl3ProtoObject)
 private
 // private fields
   f_Transporter : IncsTransporter;
   f_TaskID : AnsiString;
   f_Reply : TncsGetTaskDescriptionReply;
   f_ProgressDescription : AnsiString;
   f_ProgressPercent : Integer;
   f_Progressor : TddProgressObject;
 private
 // private methods
   procedure ProgressUpdate(Sender: TObject;
     aTotalPercent: Integer);
   procedure SetProgress(aNewPercent: Integer;
     const aNewDescription: AnsiString);
 protected
 // property methods
   function pm_GetTargetFolder: AnsiString;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aTransporter: IncsTransporter;
     const aTaskID: AnsiString); reintroduce;
   function Execute: TncsResultKind;
 public
 // public properties
   property TargetFolder: AnsiString
     read pm_GetTargetFolder;
 end;//TarOneTaskDeliverer
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  ncsTaskProgress
  {$IfEnd} //not Nemesis
  ,
  SysUtils
  {$If not defined(Nemesis)}
  ,
  ncsGetTaskDescription
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsMessage
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  ncsFileListDeliverer
  {$IfEnd} //not Nemesis
  ,
  l3Base
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}

// start class TarOneTaskDeliverer

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
//#UC END# *546AFEF1001C_546AFE0D01CB_impl*
end;//TarOneTaskDeliverer.Create

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
     Exit;
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

{$IfEnd} //AppClientSide

end.