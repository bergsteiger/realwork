unit fsFolders;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/fsFolders.pas"
// Начат: 27.08.2009 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFolders$UC::Folders$FSF
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  ,
  FoldersInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  PrimFolders_utFolders_UserType,
  PrimFoldersTree_utFoldersTree_UserType,
  Common_FormDefinitions_Controls,
  PrimFoldersElementInfo_utFoldersProperty_UserType
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_Folders = {final fsf} class(TvcmFormSetFactory)
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoGetCanSaveFormSetToHistory(const aFormSet: IvcmFormSet): Boolean; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
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
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_Folders;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_Folders
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  l3MessageID,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_Folders

var g_Tfs_Folders : Tfs_Folders = nil;

procedure Tfs_FoldersFree;
begin
 l3Free(g_Tfs_Folders);
end;

class function Tfs_Folders.Instance: Tfs_Folders;
begin
 if (g_Tfs_Folders = nil) then
 begin
  l3System.AddExitProc(Tfs_FoldersFree);
  g_Tfs_Folders := Create;
 end;
 Result := g_Tfs_Folders;
end;

var
    { Локализуемые строки Folders$FSFCaptionLocalConstants }
   str_fsFoldersCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsFoldersCaption'; rValue : 'Папки');
    { Заголовок фабрики сборки форм "Folders$FSF" }

// start class Tfs_Folders

function Tfs_Folders.CfFoldersNavigatorUtFoldersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
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

class function Tfs_Folders.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_Folders <> nil;
end;//Tfs_Folders.Exists

procedure Tfs_Folders.InitFields;
 {-}
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

{$If not defined(NoVCM)}
class function Tfs_Folders.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_Folders.GetInstance
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function Tfs_Folders.DoGetCanSaveFormSetToHistory(const aFormSet: IvcmFormSet): Boolean;
//#UC START# *55E020470097_4AA4B2ED00FE_var*
//#UC END# *55E020470097_4AA4B2ED00FE_var*
begin
//#UC START# *55E020470097_4AA4B2ED00FE_impl*
 Result := False;
//#UC END# *55E020470097_4AA4B2ED00FE_impl*
end;//Tfs_Folders.DoGetCanSaveFormSetToHistory
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsFoldersCaption
 str_fsFoldersCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.