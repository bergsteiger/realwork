unit ncsServerFilesDeliverer;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsServerFilesDeliverer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsServerFilesDeliverer" MUID: (5810A0CC0383)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , CsDataPipe
 , evdNcsTypes
 , Classes
;

type
 PncsServerFilesDeliverer = ^TncsServerFilesDeliverer;

 TncsServerFilesDeliverer = class(Tl3ProtoObject)
  private
   f_Terminating: Boolean;
   f_Stopped: Boolean;
   f_DataPipe: TCsDataPipe;
  private
   function GetCommand: TncsDeliveryCommand;
   procedure SendStringList(aList: TStringList);
   procedure SendTasksList;
   procedure CorrectTargetFolder;
   procedure SetDeliveryResult;
  protected
   procedure FillTasksList(aList: TStringList); virtual; abstract;
   procedure DoCorrectTargetFolder(const aTaskID: AnsiString;
    const aNewFolder: AnsiString); virtual; abstract;
   procedure DoSetDeliveryResult(const aTaskID: AnsiString;
    aResult: TncsResultKind); virtual; abstract;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aPipe: TCsDataPipe); reintroduce;
   procedure TerminateProcess;
   procedure ProcessCommands;
  protected
   property DataPipe: TCsDataPipe
    read f_DataPipe;
 end;//TncsServerFilesDeliverer
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *5810A0CC0383impl_uses*
 //#UC END# *5810A0CC0383impl_uses*
;

constructor TncsServerFilesDeliverer.Create(aPipe: TCsDataPipe);
//#UC START# *5810A1E7027C_5810A0CC0383_var*
//#UC END# *5810A1E7027C_5810A0CC0383_var*
begin
//#UC START# *5810A1E7027C_5810A0CC0383_impl*
 inherited Create;
 aPipe.SetRefTo(f_DataPipe);
//#UC END# *5810A1E7027C_5810A0CC0383_impl*
end;//TncsServerFilesDeliverer.Create

function TncsServerFilesDeliverer.GetCommand: TncsDeliveryCommand;
//#UC START# *5811A6F4011C_5810A0CC0383_var*
//#UC END# *5811A6F4011C_5810A0CC0383_var*
begin
//#UC START# *5811A6F4011C_5810A0CC0383_impl*
 Result := TncsDeliveryCommand(DataPipe.ReadInteger);
//#UC END# *5811A6F4011C_5810A0CC0383_impl*
end;//TncsServerFilesDeliverer.GetCommand

procedure TncsServerFilesDeliverer.SendStringList(aList: TStringList);
//#UC START# *5811EF6E00F7_5810A0CC0383_var*
var
 l_List: TStringList;
 l_IDX: Integer;
//#UC END# *5811EF6E00F7_5810A0CC0383_var*
begin
//#UC START# *5811EF6E00F7_5810A0CC0383_impl*
 DataPipe.WriteInteger(aList.Count);
 for l_IDX := 0 to aList.Count - 1 do
  DataPipe.WriteLn(aList[l_IDX]);
//#UC END# *5811EF6E00F7_5810A0CC0383_impl*
end;//TncsServerFilesDeliverer.SendStringList

procedure TncsServerFilesDeliverer.SendTasksList;
//#UC START# *5811EF870053_5810A0CC0383_var*
var
 l_List: TStringList;
//#UC END# *5811EF870053_5810A0CC0383_var*
begin
//#UC START# *5811EF870053_5810A0CC0383_impl*
 l_List := TStringList.Create;
 try
  FillTasksList(l_List);
  SendStringList(l_List);
 finally
  FreeAndNil(l_List);
 end;
//#UC END# *5811EF870053_5810A0CC0383_impl*
end;//TncsServerFilesDeliverer.SendTasksList

procedure TncsServerFilesDeliverer.CorrectTargetFolder;
//#UC START# *58133D0403B9_5810A0CC0383_var*
//#UC END# *58133D0403B9_5810A0CC0383_var*
begin
//#UC START# *58133D0403B9_5810A0CC0383_impl*
 DoCorrectTargetFolder(DataPipe.ReadLn, DataPipe.ReadLn);
//#UC END# *58133D0403B9_5810A0CC0383_impl*
end;//TncsServerFilesDeliverer.CorrectTargetFolder

procedure TncsServerFilesDeliverer.SetDeliveryResult;
//#UC START# *58133D11024D_5810A0CC0383_var*
var
 l_TaskID: String;
 l_Result: Integer;
//#UC END# *58133D11024D_5810A0CC0383_var*
begin
//#UC START# *58133D11024D_5810A0CC0383_impl*
 l_TaskID := DataPipe.ReadLn;
 l_Result := DataPipe.ReadInteger;
 DoSetDeliveryResult(l_TaskID, TncsResultKind(l_Result));
//#UC END# *58133D11024D_5810A0CC0383_impl*
end;//TncsServerFilesDeliverer.SetDeliveryResult

procedure TncsServerFilesDeliverer.TerminateProcess;
//#UC START# *5811A63E0083_5810A0CC0383_var*
//#UC END# *5811A63E0083_5810A0CC0383_var*
begin
//#UC START# *5811A63E0083_5810A0CC0383_impl*
 f_Terminating := True;
//#UC END# *5811A63E0083_5810A0CC0383_impl*
end;//TncsServerFilesDeliverer.TerminateProcess

procedure TncsServerFilesDeliverer.ProcessCommands;
//#UC START# *5811A656035A_5810A0CC0383_var*
//#UC END# *5811A656035A_5810A0CC0383_var*
begin
//#UC START# *5811A656035A_5810A0CC0383_impl*
 while not f_Stopped do
 begin
  case GetCommand of
   ncs_dcGetTasksList: SendTasksList;
//   ncs_dcGetFilesList
//   ncs_dcGetFileCRC
//   ncs_dcGetFile
//   ncs_dcGetTargetFolder
//   ncs_dcSetProgress
   ncs_dcSetDeliveryResult: SetDeliveryResult;
   ncs_dcCorrectTargetFolder: CorrectTargetFolder;
//   ncs_dcCheckAlive
   ncs_dcDoneProcess: f_Stopped := True;
  end;
 end;
//#UC END# *5811A656035A_5810A0CC0383_impl*
end;//TncsServerFilesDeliverer.ProcessCommands

procedure TncsServerFilesDeliverer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5810A0CC0383_var*
//#UC END# *479731C50290_5810A0CC0383_var*
begin
//#UC START# *479731C50290_5810A0CC0383_impl*
 FreeAndNil(f_DataPipe);
 inherited;
//#UC END# *479731C50290_5810A0CC0383_impl*
end;//TncsServerFilesDeliverer.Cleanup
{$IfEnd} // NOT Defined(Nemesis)

end.
