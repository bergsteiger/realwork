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
 // enFoldersTree_utFoldersTree

 // enFoldersElementInfo_utFoldersProperty

 // cfFolders

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
   function cfFolders_Navigator_utFolders_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для cfFolders }
   function enFoldersTree_utFoldersTree_Parent_utFoldersTree_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для enFoldersTree_utFoldersTree }
   function enFoldersElementInfo_utFoldersProperty_Child_utFoldersProperty_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для enFoldersElementInfo_utFoldersProperty }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_Folders;
    {* Метод получения экземпляра синглетона Tfs_Folders }
 end;//Tfs_Folders
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_Tfs_Folders: Tfs_Folders = nil;
 {* Экземпляр синглетона Tfs_Folders }

const
 {* Локализуемые строки Folders$FSFCaptionLocalConstants }
 str_fsFoldersCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsFoldersCaption'; rValue : 'Папки');
  {* Заголовок фабрики сборки форм "Folders$FSF" }

procedure Tfs_FoldersFree;
 {* Метод освобождения экземпляра синглетона Tfs_Folders }
begin
 l3Free(g_Tfs_Folders);
end;//Tfs_FoldersFree

function Tfs_Folders.cfFolders_Navigator_utFolders_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для cfFolders }
//#UC START# *C0B08AD85726_4AA4B2ED00FE_var*
//#UC END# *C0B08AD85726_4AA4B2ED00FE_var*
begin
//#UC START# *C0B08AD85726_4AA4B2ED00FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *C0B08AD85726_4AA4B2ED00FE_impl*
end;//Tfs_Folders.cfFolders_Navigator_utFolders_NeedMakeForm

function Tfs_Folders.enFoldersTree_utFoldersTree_Parent_utFoldersTree_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для enFoldersTree_utFoldersTree }
//#UC START# *49E15BACC408_4AA4B2ED00FE_var*
//#UC END# *49E15BACC408_4AA4B2ED00FE_var*
begin
//#UC START# *49E15BACC408_4AA4B2ED00FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E15BACC408_4AA4B2ED00FE_impl*
end;//Tfs_Folders.enFoldersTree_utFoldersTree_Parent_utFoldersTree_NeedMakeForm

function Tfs_Folders.enFoldersElementInfo_utFoldersProperty_Child_utFoldersProperty_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для enFoldersElementInfo_utFoldersProperty }
//#UC START# *60EE3E3C50F2_4AA4B2ED00FE_var*
//#UC END# *60EE3E3C50F2_4AA4B2ED00FE_var*
begin
//#UC START# *60EE3E3C50F2_4AA4B2ED00FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *60EE3E3C50F2_4AA4B2ED00FE_impl*
end;//Tfs_Folders.enFoldersElementInfo_utFoldersProperty_Child_utFoldersProperty_NeedMakeForm

class function Tfs_Folders.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Folders <> nil;
end;//Tfs_Folders.Exists

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

procedure Tfs_Folders.InitFields;
//#UC START# *47A042E100E2_4AA4B2ED00FE_var*
//#UC END# *47A042E100E2_4AA4B2ED00FE_var*
begin
//#UC START# *47A042E100E2_4AA4B2ED00FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA4B2ED00FE_impl*
end;//Tfs_Folders.InitFields

class function Tfs_Folders.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA4B2ED00FE_var*
//#UC END# *4FFE854A009B_4AA4B2ED00FE_var*
begin
//#UC START# *4FFE854A009B_4AA4B2ED00FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA4B2ED00FE_impl*
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
