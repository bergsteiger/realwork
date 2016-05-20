unit PrimFoldersInfo_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersInfo_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimFoldersInfo" MUID: (4AE9BEEF0229)
// Имя типа: "TPrimFoldersInfoForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Folders_Strange_Controls
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , FoldersDomainInterfaces
;

type
 // Child

 TPrimFoldersInfoForm = class({$If NOT Defined(NoVCM)}
 TvcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_ChildZone: TvtPanel;
    {* Поле для свойства ChildZone }
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure AdditionInfo_Close_Execute(aModalResult: Integer = Controls.mrCancel);
   procedure AdditionInfo_Close(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_SetState_Execute(aInfoType: TFoldersInfoType);
   procedure FolderElement_SetState(const aParams: IvcmExecuteParamsPrim);
  public
   property ChildZone: TvtPanel
    read f_ChildZone;
 end;//TPrimFoldersInfoForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , nsFolders
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimFoldersInfo_utFoldersInfoContainer_UserType
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки utFoldersInfoContainerLocalConstants }
 str_utFoldersInfoContainerCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFoldersInfoContainerCaption'; rValue : 'Свойства папок (модальный диалог)');
  {* Заголовок пользовательского типа "Свойства папок (модальный диалог)" }

procedure TPrimFoldersInfoForm.AdditionInfo_Close_Execute(aModalResult: Integer = Controls.mrCancel);
//#UC START# *4AE9BF890271_4AE9BEEF0229exec_var*
//#UC END# *4AE9BF890271_4AE9BEEF0229exec_var*
begin
//#UC START# *4AE9BF890271_4AE9BEEF0229exec_impl*
 ModalResult := aModalResult;
//#UC END# *4AE9BF890271_4AE9BEEF0229exec_impl*
end;//TPrimFoldersInfoForm.AdditionInfo_Close_Execute

procedure TPrimFoldersInfoForm.AdditionInfo_Close(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IAdditionInfo_Close_Params) do
  Self.AdditionInfo_Close_Execute(ModalResult);
end;//TPrimFoldersInfoForm.AdditionInfo_Close

procedure TPrimFoldersInfoForm.FolderElement_SetState_Execute(aInfoType: TFoldersInfoType);
//#UC START# *4AE9C01201BA_4AE9BEEF0229exec_var*
//#UC END# *4AE9C01201BA_4AE9BEEF0229exec_var*
begin
//#UC START# *4AE9C01201BA_4AE9BEEF0229exec_impl*
 CCaption := vcmCStr(cInfoCaptions[aInfoType]^);
//#UC END# *4AE9C01201BA_4AE9BEEF0229exec_impl*
end;//TPrimFoldersInfoForm.FolderElement_SetState_Execute

procedure TPrimFoldersInfoForm.FolderElement_SetState(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IFolderElement_SetState_Params) do
  Self.FolderElement_SetState_Execute(InfoType);
end;//TPrimFoldersInfoForm.FolderElement_SetState

procedure TPrimFoldersInfoForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AE9BEEF0229_var*
//#UC END# *4A8E8F2E0195_4AE9BEEF0229_var*
begin
//#UC START# *4A8E8F2E0195_4AE9BEEF0229_impl*
 inherited;
 with ChildZone do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
//#UC END# *4A8E8F2E0195_4AE9BEEF0229_impl*
end;//TPrimFoldersInfoForm.InitControls

procedure TPrimFoldersInfoForm.MakeControls;
begin
 inherited;
 with AddUsertype(utFoldersInfoContainerName,
  str_utFoldersInfoContainerCaption,
  str_utFoldersInfoContainerCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utFoldersInfoContainerName
 f_ChildZone := TvtPanel.Create(Self);
 f_ChildZone.Name := 'ChildZone';
 f_ChildZone.Parent := Self;
 with DefineZone(vcm_ztChild, f_ChildZone) do
 begin
 end;//with DefineZone(vcm_ztChild
end;//TPrimFoldersInfoForm.MakeControls

initialization
 str_utFoldersInfoContainerCaption.Init;
 {* Инициализация str_utFoldersInfoContainerCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersInfoForm);
 {* Регистрация PrimFoldersInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
