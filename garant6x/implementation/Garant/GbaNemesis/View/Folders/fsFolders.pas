unit fsFolders;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\fsFolders.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "Folders" MUID: (4AA4B2ED00FE)
// Имя типа: "Tfs_Folders"

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
 , PrimFolders_utFolders_UserType
 , Common_FormDefinitions_Controls
 , FoldersInterfaces
 , PrimFoldersTree_utFoldersTree_UserType
 , PrimFoldersElementInfo_utFoldersProperty_UserType
;

type
 Tfs_Folders = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetCanSaveFormSetToHistory(const aFormSet: IvcmFormSet): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function CfFoldersNavigatorUtFoldersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для cfFolders }
   function EnFoldersTreeUtFoldersTreeParentUtFoldersTreeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для enFoldersTree_utFoldersTree }
   function EnFoldersElementInfoUtFoldersPropertyChildUtFoldersPropertyNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для enFoldersElementInfo_utFoldersProperty }
   class function Instance: Tfs_Folders;
    {* Метод получения экземпляра синглетона Tfs_Folders }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_Folders
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 //#UC START# *4AA4B2ED00FEimpl_uses*
 //#UC END# *4AA4B2ED00FEimpl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_Folders: Tfs_Folders = nil;
 {* Экземпляр синглетона Tfs_Folders }

const
 {* Локализуемые строки Folders }
 str_fsFoldersCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsFoldersCaption'; rValue : 'Папки');
  {* Заголовок фабрики сборки форм "Folders$FSF" }

procedure Tfs_FoldersFree;
 {* Метод освобождения экземпляра синглетона Tfs_Folders }
begin
 l3Free(g_Tfs_Folders);
end;//Tfs_FoldersFree

function Tfs_Folders.CfFoldersNavigatorUtFoldersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для cfFolders }
var
 l_UseCase : IsdsFolders;
begin
 if Supports(aDataSource, IsdsFolders, l_UseCase) then
  try
  //#UC START# *4FFAA4A801DDNeedMake_impl*
   aNew := l_UseCase.dsFolders;
  //#UC END# *4FFAA4A801DDNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Folders.CfFoldersNavigatorUtFoldersNeedMakeForm

function Tfs_Folders.EnFoldersTreeUtFoldersTreeParentUtFoldersTreeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для enFoldersTree_utFoldersTree }
var
 l_UseCase : IsdsFolders;
begin
 if Supports(aDataSource, IsdsFolders, l_UseCase) then
  try
  //#UC START# *4FFAA5950031NeedMake_impl*
   aNew := l_UseCase.dsFoldersTree;
  //#UC END# *4FFAA5950031NeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Folders.EnFoldersTreeUtFoldersTreeParentUtFoldersTreeNeedMakeForm

function Tfs_Folders.EnFoldersElementInfoUtFoldersPropertyChildUtFoldersPropertyNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для enFoldersElementInfo_utFoldersProperty }
var
 l_UseCase : IsdsFolders;
begin
 if Supports(aDataSource, IsdsFolders, l_UseCase) then
  try
  //#UC START# *4FFAA604019FNeedMake_impl*
   aNew := l_UseCase.dsFolderElement;
  //#UC END# *4FFAA604019FNeedMake_impl*
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Folders.EnFoldersElementInfoUtFoldersPropertyChildUtFoldersPropertyNeedMakeForm

class function Tfs_Folders.Instance: Tfs_Folders;
 {* Метод получения экземпляра синглетона Tfs_Folders }
begin
 if (g_Tfs_Folders = nil) then
 begin
  l3System.AddExitProc(Tfs_FoldersFree);
  g_Tfs_Folders := Create;
 end;
 Result := g_Tfs_Folders;
end;//Tfs_Folders.Instance

class function Tfs_Folders.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Folders <> nil;
end;//Tfs_Folders.Exists

procedure Tfs_Folders.InitFields;
begin
 inherited;
 with AddZone('cfFolders', vcm_ztNavigator, fm_cfFolders) do
 begin
  UserType := utFolders;
  with AddZone('enFoldersTree_utFoldersTree', vcm_ztParent, fm_enFoldersTree) do
  begin
   UserType := utFoldersTree;
   OnNeedMakeForm := EnFoldersTreeUtFoldersTreeParentUtFoldersTreeNeedMakeForm;
  end;
  with AddZone('enFoldersElementInfo_utFoldersProperty', vcm_ztChild, fm_enFoldersElementInfo) do
  begin
   UserType := utFoldersProperty;
   OnNeedMakeForm := EnFoldersElementInfoUtFoldersPropertyChildUtFoldersPropertyNeedMakeForm;
  end;
  OnNeedMakeForm := CfFoldersNavigatorUtFoldersNeedMakeForm;
 end;
 Caption := str_fsFoldersCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_Folders.InitFields

class function Tfs_Folders.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_Folders.GetInstance

function Tfs_Folders.DoGetCanSaveFormSetToHistory(const aFormSet: IvcmFormSet): Boolean;
//#UC START# *55E020470097_4AA4B2ED00FE_var*
//#UC END# *55E020470097_4AA4B2ED00FE_var*
begin
//#UC START# *55E020470097_4AA4B2ED00FE_impl*
 Result := False;
//#UC END# *55E020470097_4AA4B2ED00FE_impl*
end;//Tfs_Folders.DoGetCanSaveFormSetToHistory

initialization
 str_fsFoldersCaption.Init;
 {* Инициализация str_fsFoldersCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
