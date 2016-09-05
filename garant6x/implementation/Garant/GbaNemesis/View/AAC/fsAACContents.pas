unit fsAACContents;
 {* Сборка для документа ОГЛАВЛЕНИЯ ААК }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\fsAACContents.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "AACContents" MUID: (4FF4428702F0)
// Имя типа: "Tfs_AACContents"

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
 , l3Interfaces
 , bsTypesNew
 , DocumentUserTypes_dftAACContentsRight_UserType
;

type
 Tfs_AACContents = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Сборка для документа ОГЛАВЛЕНИЯ ААК }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function AACContainerParentAACContentsContainerNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для AACContainer }
   function LeftChildDftAACContentsLeftNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Left }
   function RightMainDftAACContentsRightNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Right }
   class function Instance: Tfs_AACContents;
    {* Метод получения экземпляра синглетона Tfs_AACContents }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_AACContents
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *4FF4428702F0impl_uses*
 //#UC END# *4FF4428702F0impl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_AACContents: Tfs_AACContents = nil;
 {* Экземпляр синглетона Tfs_AACContents }

procedure Tfs_AACContentsFree;
 {* Метод освобождения экземпляра синглетона Tfs_AACContents }
begin
 l3Free(g_Tfs_AACContents);
end;//Tfs_AACContentsFree

function Tfs_AACContents.AACContainerParentAACContentsContainerNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для AACContainer }
var
 l_UseCase : IsdsAAC;
begin
 if Supports(aDataSource, IsdsAAC, l_UseCase) then
  try
   aNew := l_UseCase.Container;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AACContents.AACContainerParentAACContentsContainerNeedMakeForm

function Tfs_AACContents.LeftChildDftAACContentsLeftNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Left }
var
 l_UseCase : IsdsAAC;
begin
 if Supports(aDataSource, IsdsAAC, l_UseCase) then
  try
   aNew := l_UseCase.Left;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AACContents.LeftChildDftAACContentsLeftNeedMakeForm

function Tfs_AACContents.RightMainDftAACContentsRightNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Right }
var
 l_UseCase : IsdsAAC;
begin
 if Supports(aDataSource, IsdsAAC, l_UseCase) then
  try
   aNew := l_UseCase.Right;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_AACContents.RightMainDftAACContentsRightNeedMakeForm

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

class function Tfs_AACContents.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_AACContents <> nil;
end;//Tfs_AACContents.Exists

procedure Tfs_AACContents.InitFields;
begin
 inherited;
 with AddZone('AACContainer', vcm_ztParent, fm_AACContentsContainerForm) do
 begin
  UserType := AACContentsContainer;
  with AddZone('Left', vcm_ztChild, fm_TextForm) do
  begin
   UserType := dftAACContentsLeft;
   OnNeedMakeForm := LeftChildDftAACContentsLeftNeedMakeForm;
  end;
  with AddZone('Right', vcm_ztMain, fm_TextForm) do
  begin
   UserType := dftAACContentsRight;
   OnNeedMakeForm := RightMainDftAACContentsRightNeedMakeForm;
  end;
  OnNeedMakeForm := AACContainerParentAACContentsContainerNeedMakeForm;
 end;
 OwnerForm := 0;
end;//Tfs_AACContents.InitFields

class function Tfs_AACContents.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_AACContents.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
