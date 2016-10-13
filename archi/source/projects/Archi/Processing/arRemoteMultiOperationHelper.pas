unit arRemoteMultiOperationHelper;

// Модуль: "w:\archi\source\projects\Archi\Processing\arRemoteMultiOperationHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarRemoteMultiOperationHelper" MUID: (57EE4A3201F3)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arCustomMultiOperationHelper
 {$If NOT Defined(Nemesis)}
 , csMultiOperation
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiOperationReply
 {$IfEnd} // NOT Defined(Nemesis)
 , daTypes
 , l3MarshalledTypes
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 , l3DatLst
;

type
 TarRemoteMultiOperationHelper = class(TarCustomMultiOperationHelper)
  private
   f_Message: TcsMultiOperation;
   f_Reply: TcsMultiOperationReply;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aFamilyID: TdaFamilyID;
    anOperation: TarMultiOperation;
    const aDocsList: ISab); reintroduce;
   procedure ModifyDocs; override;
   function HasErrorDocs: Boolean; override;
   procedure FillErrorDocsList(aList: Tl3StringDataList); override;
   function ProcessedDocsCount: Integer; override;
 end;//TarRemoteMultiOperationHelper
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , ArchiUserRequestManager
 , evdTasksHelpers
 {$If NOT Defined(Nemesis)}
 , ncsMessage
 {$IfEnd} // NOT Defined(Nemesis)
 , daDataProvider
 //#UC START# *57EE4A3201F3impl_uses*
 //#UC END# *57EE4A3201F3impl_uses*
;

constructor TarRemoteMultiOperationHelper.Create(aFamilyID: TdaFamilyID;
 anOperation: TarMultiOperation;
 const aDocsList: ISab);
//#UC START# *57EE606D010C_57EE4A3201F3_var*
//#UC END# *57EE606D010C_57EE4A3201F3_var*
begin
//#UC START# *57EE606D010C_57EE4A3201F3_impl*
 inherited Create(aFamilyID, anOperation, aDocsList);
 f_Reply := nil;
 f_Message := TcsMultiOperation.Create;
 f_Message.UserID := GlobalDataProvider.UserID;
 f_Message.FamilyID := FamilyID;
 f_Message.Operation := Operation;
 dtCopyValuesSabToList(aDocsList, f_Message.DocumentIDList);
//#UC END# *57EE606D010C_57EE4A3201F3_impl*
end;//TarRemoteMultiOperationHelper.Create

procedure TarRemoteMultiOperationHelper.ModifyDocs;
//#UC START# *57ED15AC02A7_57EE4A3201F3_var*
var
 l_Reply: TncsReply;
//#UC END# *57ED15AC02A7_57EE4A3201F3_var*
begin
//#UC START# *57ED15AC02A7_57EE4A3201F3_impl*
 l_Reply := ArchiRequestManager.SendRequestWithReply(f_Message);
 if (l_Reply = nil) or not (l_Reply is TcsMultiOperationReply) then
  raise Exception.Create('Нет связи с сервером');
 f_Reply := l_Reply as TcsMultiOperationReply;
 if not f_Reply.IsSuccess then
  raise Exception.Create(f_Reply.ErrorMessage);
//#UC END# *57ED15AC02A7_57EE4A3201F3_impl*
end;//TarRemoteMultiOperationHelper.ModifyDocs

function TarRemoteMultiOperationHelper.HasErrorDocs: Boolean;
//#UC START# *57FB778D0148_57EE4A3201F3_var*
//#UC END# *57FB778D0148_57EE4A3201F3_var*
begin
//#UC START# *57FB778D0148_57EE4A3201F3_impl*
 Result := Assigned(f_Reply) and (f_Reply.RejectedIDList.Count > 0);
//#UC END# *57FB778D0148_57EE4A3201F3_impl*
end;//TarRemoteMultiOperationHelper.HasErrorDocs

procedure TarRemoteMultiOperationHelper.FillErrorDocsList(aList: Tl3StringDataList);
//#UC START# *57FB77AB0147_57EE4A3201F3_var*
var
 l_ID: Cardinal;
 l_Str: AnsiString;
 l_IDX: Integer;
//#UC END# *57FB77AB0147_57EE4A3201F3_var*
begin
//#UC START# *57FB77AB0147_57EE4A3201F3_impl*
 aList.Clear;
 aList.DataSize := SizeOf(l_ID);
 for l_IDX := 0 to f_Reply.RejectedIDList.Count - 1 do
 begin
  f_Reply.RejectedIDList.GetValue(l_IDX, l_ID, l_Str);
  aList.AddStr(l_Str, @l_ID);
 end;
//#UC END# *57FB77AB0147_57EE4A3201F3_impl*
end;//TarRemoteMultiOperationHelper.FillErrorDocsList

function TarRemoteMultiOperationHelper.ProcessedDocsCount: Integer;
//#UC START# *57FDE80903AE_57EE4A3201F3_var*
//#UC END# *57FDE80903AE_57EE4A3201F3_var*
begin
//#UC START# *57FDE80903AE_57EE4A3201F3_impl*
 if Assigned(f_Reply) then
  Result := f_Reply.ProcessedCount
 else
  Result := 0;
//#UC END# *57FDE80903AE_57EE4A3201F3_impl*
end;//TarRemoteMultiOperationHelper.ProcessedDocsCount

procedure TarRemoteMultiOperationHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57EE4A3201F3_var*
//#UC END# *479731C50290_57EE4A3201F3_var*
begin
//#UC START# *479731C50290_57EE4A3201F3_impl*
 FreeAndNil(f_Message);
 FreeAndNil(f_Reply);
 inherited;
//#UC END# *479731C50290_57EE4A3201F3_impl*
end;//TarRemoteMultiOperationHelper.Cleanup
{$IfEnd} // Defined(AppClientSide)

end.
