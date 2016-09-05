unit fsCompareEditions;
 {* Сравнение редакций документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\fsCompareEditions.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "CompareEditions" MUID: (4A6EBF8301FA)
// Имя типа: "Tfs_CompareEditions"

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
 , EditionsContainer_Form
 , PrimEditionsContainer_utEditionsContainer_UserType
 , EditionsInterfaces
 , l3Interfaces
 , DocumentUnit
 , LeftEdition_Form
 , PrimLeftEdition_utLeftEdition_UserType
 , nevTools
 , eeInterfaces
 , l3Tree_TLB
 , afwInterfaces
 , FoldersDomainInterfaces
 , Base_Operations_F1Services_Contracts
 , DocumentInterfaces
 , RightEdition_Form
 , PrimRightEdition_utRightEdition_UserType
;

type
 Tfs_CompareEditions = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Сравнение редакций документа }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function EditionsContainerParentUtEditionsContainerNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для EditionsContainer }
   function LeftChildUtLeftEditionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Left }
   function RightMainUtRightEditionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Right }
   class function Instance: Tfs_CompareEditions;
    {* Метод получения экземпляра синглетона Tfs_CompareEditions }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_CompareEditions
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
 , CompareEditions_FormDefinitions_Controls
 //#UC START# *4A6EBF8301FAimpl_uses*
 //#UC END# *4A6EBF8301FAimpl_uses*
;

{$If NOT Defined(NoVCM)}
var g_Tfs_CompareEditions: Tfs_CompareEditions = nil;
 {* Экземпляр синглетона Tfs_CompareEditions }

const
 {* Локализуемые строки CompareEditionsCaptionLocalConstants }
 str_fsCompareEditionsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsCompareEditionsCaption'; rValue : 'Сравнение редакций');
  {* Заголовок фабрики сборки форм "CompareEditions" }

procedure Tfs_CompareEditionsFree;
 {* Метод освобождения экземпляра синглетона Tfs_CompareEditions }
begin
 l3Free(g_Tfs_CompareEditions);
end;//Tfs_CompareEditionsFree

function Tfs_CompareEditions.EditionsContainerParentUtEditionsContainerNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для EditionsContainer }
var
 l_UseCase : IsdsCompareEditions;
begin
 if Supports(aDataSource, IsdsCompareEditions, l_UseCase) then
  try
   aNew := l_UseCase.EditionsContainerData;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_CompareEditions.EditionsContainerParentUtEditionsContainerNeedMakeForm

function Tfs_CompareEditions.LeftChildUtLeftEditionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Left }
var
 l_UseCase : IsdsCompareEditions;
begin
 if Supports(aDataSource, IsdsCompareEditions, l_UseCase) then
  try
   aNew := l_UseCase.Left;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_CompareEditions.LeftChildUtLeftEditionNeedMakeForm

function Tfs_CompareEditions.RightMainUtRightEditionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Right }
var
 l_UseCase : IsdsCompareEditions;
begin
 if Supports(aDataSource, IsdsCompareEditions, l_UseCase) then
  try
   aNew := l_UseCase.Right;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_CompareEditions.RightMainUtRightEditionNeedMakeForm

class function Tfs_CompareEditions.Instance: Tfs_CompareEditions;
 {* Метод получения экземпляра синглетона Tfs_CompareEditions }
begin
 if (g_Tfs_CompareEditions = nil) then
 begin
  l3System.AddExitProc(Tfs_CompareEditionsFree);
  g_Tfs_CompareEditions := Create;
 end;
 Result := g_Tfs_CompareEditions;
end;//Tfs_CompareEditions.Instance

class function Tfs_CompareEditions.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_CompareEditions <> nil;
end;//Tfs_CompareEditions.Exists

procedure Tfs_CompareEditions.InitFields;
begin
 inherited;
 with AddZone('EditionsContainer', vcm_ztParent, fm_EditionsContainerForm) do
 begin
  UserType := utEditionsContainer;
  with AddZone('Left', vcm_ztChild, fm_LeftEditionForm) do
  begin
   UserType := utLeftEdition;
   OnNeedMakeForm := LeftChildUtLeftEditionNeedMakeForm;
  end;
  with AddZone('Right', vcm_ztMain, fm_RightEditionForm) do
  begin
   UserType := utRightEdition;
   OnNeedMakeForm := RightMainUtRightEditionNeedMakeForm;
  end;
  OnNeedMakeForm := EditionsContainerParentUtEditionsContainerNeedMakeForm;
 end;
 Caption := str_fsCompareEditionsCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_CompareEditions.InitFields

class function Tfs_CompareEditions.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_CompareEditions.GetInstance

initialization
 str_fsCompareEditionsCaption.Init;
 {* Инициализация str_fsCompareEditionsCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
