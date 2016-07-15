unit PostingOrder_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PostingOrder_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4C84EDB403D2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Op_SearchSupport_ActivatePostingsListForm = {final} class
  {* Класс для вызова операции SearchSupport.ActivatePostingsListForm }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции SearchSupport.ActivatePostingsListForm у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции SearchSupport.ActivatePostingsListForm у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции SearchSupport.ActivatePostingsListForm у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции SearchSupport.ActivatePostingsListForm у контейнера }
   class procedure Broadcast;
    {* Вызов операции SearchSupport.ActivatePostingsListForm у всех зарегистрированных сущностей }
 end;//Op_SearchSupport_ActivatePostingsListForm

const
 en_PostingToolBar = 'PostingToolBar';
 en_capPostingToolBar = 'Панель новостей';
 op_ptNewTheme = 'ptNewTheme';
 op_capptNewTheme = '';
 op_ptEditPosting = 'ptEditPosting';
 op_capptEditPosting = '';
 op_ptDeletePosting = 'ptDeletePosting';
 op_capptDeletePosting = '';
 op_SavePostList = 'SavePostList';
 op_capSavePostList = '';
 op_ExportSelected = 'ExportSelected';
 op_capExportSelected = '';
 en_SearchSupport = 'SearchSupport';
 en_capSearchSupport = '';
 op_ActivatePostingsListForm = 'ActivatePostingsListForm';
 op_capActivatePostingsListForm = '';

var opcode_PostingToolBar_ptNewTheme: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_PostingToolBar_ptEditPosting: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_PostingToolBar_ptDeletePosting: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_PostingToolBar_SavePostList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_PostingToolBar_ExportSelected: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SearchSupport_ActivatePostingsListForm: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchSupport.ActivatePostingsListForm у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_SearchSupport_ActivatePostingsListForm, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции SearchSupport.ActivatePostingsListForm у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_SearchSupport_ActivatePostingsListForm, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции SearchSupport.ActivatePostingsListForm у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class function Op_SearchSupport_ActivatePostingsListForm.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchSupport.ActivatePostingsListForm у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchSupport_ActivatePostingsListForm.Call

class procedure Op_SearchSupport_ActivatePostingsListForm.Broadcast;
 {* Вызов операции SearchSupport.ActivatePostingsListForm у всех зарегистрированных сущностей }
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := vcmParams;
  vcmDispatcher.EntityOperationBroadcast(opcode_SearchSupport_ActivatePostingsListForm, l_Params);
 end//vcmDispatcher <> nil
end;//Op_SearchSupport_ActivatePostingsListForm.Broadcast

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_PostingToolBar, op_ptNewTheme, en_capPostingToolBar, op_capptNewTheme, False, True, opcode_PostingToolBar_ptNewTheme)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_PostingToolBar, op_ptEditPosting, en_capPostingToolBar, op_capptEditPosting, False, True, opcode_PostingToolBar_ptEditPosting)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_PostingToolBar, op_ptDeletePosting, en_capPostingToolBar, op_capptDeletePosting, False, True, opcode_PostingToolBar_ptDeletePosting)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_PostingToolBar, op_SavePostList, en_capPostingToolBar, op_capSavePostList, False, False, opcode_PostingToolBar_SavePostList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_PostingToolBar, op_ExportSelected, en_capPostingToolBar, op_capExportSelected, False, False, opcode_PostingToolBar_ExportSelected)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SearchSupport, op_ActivatePostingsListForm, en_capSearchSupport, op_capActivatePostingsListForm, True, False, opcode_SearchSupport_ActivatePostingsListForm)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin)

end.
