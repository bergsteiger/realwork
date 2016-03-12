unit fsAACContents;
 {* Сборка для документа ОГЛАВЛЕНИЯ ААК }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\fsAACContents.pas"
// Стереотип: "VCMFormSetFactory"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , AACContentsContainer_Form
 , AACContainerPrim_AACContentsContainer_UserType
 , WorkWithDocumentInterfaces
 , Common_FormDefinitions_Controls
 , DocumentUserTypes_dftAACContentsLeft_UserType
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3Interfaces
 , DocumentUserTypes_dftAACContentsRight_UserType
;

type
 // Left

 // Right

 // AACContainer

 Tfs_AACContents = {final} class(TvcmFormSetFactory)
  {* Сборка для документа ОГЛАВЛЕНИЯ ААК }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function AACContainer_Parent_AACContentsContainer_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для AACContainer }
   function Left_Child_dftAACContentsLeft_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Left }
   function Right_Main_dftAACContentsRight_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Right }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_AACContents;
    {* Метод получения экземпляра синглетона Tfs_AACContents }
 end;//Tfs_AACContents
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_Tfs_AACContents: Tfs_AACContents = nil;
 {* Экземпляр синглетона Tfs_AACContents }

procedure Tfs_AACContentsFree;
 {* Метод освобождения экземпляра синглетона Tfs_AACContents }
begin
 l3Free(g_Tfs_AACContents);
end;//Tfs_AACContentsFree

function Tfs_AACContents.AACContainer_Parent_AACContentsContainer_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для AACContainer }
//#UC START# *F555D8D7FD5B_4FF4428702F0_var*
//#UC END# *F555D8D7FD5B_4FF4428702F0_var*
begin
//#UC START# *F555D8D7FD5B_4FF4428702F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *F555D8D7FD5B_4FF4428702F0_impl*
end;//Tfs_AACContents.AACContainer_Parent_AACContentsContainer_NeedMakeForm

function Tfs_AACContents.Left_Child_dftAACContentsLeft_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Left }
//#UC START# *0CFD7C2853E7_4FF4428702F0_var*
//#UC END# *0CFD7C2853E7_4FF4428702F0_var*
begin
//#UC START# *0CFD7C2853E7_4FF4428702F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *0CFD7C2853E7_4FF4428702F0_impl*
end;//Tfs_AACContents.Left_Child_dftAACContentsLeft_NeedMakeForm

function Tfs_AACContents.Right_Main_dftAACContentsRight_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Right }
//#UC START# *88C068C02878_4FF4428702F0_var*
//#UC END# *88C068C02878_4FF4428702F0_var*
begin
//#UC START# *88C068C02878_4FF4428702F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *88C068C02878_4FF4428702F0_impl*
end;//Tfs_AACContents.Right_Main_dftAACContentsRight_NeedMakeForm

class function Tfs_AACContents.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_AACContents <> nil;
end;//Tfs_AACContents.Exists

class function Tfs_AACContents.Instance: Tfs_AACContents;
 {* Метод получения экземпляра синглетона Tfs_AACContents }
begin
 if (g_Tfs_AACContents = nil) then
 begin
  l3System.AddExitProc(Tfs_AACContentsFree);
  g_Tfs_AACContents := Create;
 end;
 Result := g_Tfs_AACContents;
end;//Tfs_AACContents.Instance

procedure Tfs_AACContents.InitFields;
//#UC START# *47A042E100E2_4FF4428702F0_var*
//#UC END# *47A042E100E2_4FF4428702F0_var*
begin
//#UC START# *47A042E100E2_4FF4428702F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4FF4428702F0_impl*
end;//Tfs_AACContents.InitFields

class function Tfs_AACContents.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4FF4428702F0_var*
//#UC END# *4FFE854A009B_4FF4428702F0_var*
begin
//#UC START# *4FFE854A009B_4FF4428702F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4FF4428702F0_impl*
end;//Tfs_AACContents.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
