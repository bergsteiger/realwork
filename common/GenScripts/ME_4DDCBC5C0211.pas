unit fsViewChangedFragments;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\fsViewChangedFragments.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "ViewChangedFragments" MUID: (4DDCBC5C0211)
// Имя типа: "Tfs_ViewChangedFragments"

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
 , ChangesBetweenEditons_Form
 , PrimChangesBetweenEditons_DocumentChanges_UserType
 , ChangesBetweenEditionsInterfaces
 , DocumentUnit
 , nevTools
 , DocumentInterfaces
;

type
 Tfs_ViewChangedFragments = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function ParentParentDocumentChangesNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Parent }
   class function Instance: Tfs_ViewChangedFragments;
    {* Метод получения экземпляра синглетона Tfs_ViewChangedFragments }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_ViewChangedFragments
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_Tfs_ViewChangedFragments: Tfs_ViewChangedFragments = nil;
 {* Экземпляр синглетона Tfs_ViewChangedFragments }

procedure Tfs_ViewChangedFragmentsFree;
 {* Метод освобождения экземпляра синглетона Tfs_ViewChangedFragments }
begin
 l3Free(g_Tfs_ViewChangedFragments);
end;//Tfs_ViewChangedFragmentsFree

function Tfs_ViewChangedFragments.ParentParentDocumentChangesNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Parent }
var
 l_UseCase : IsdsChangesBetweenEditions;
begin
 if Supports(aDataSource, IsdsChangesBetweenEditions, l_UseCase) then
  try
   aNew := l_UseCase.Changes;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_ViewChangedFragments.ParentParentDocumentChangesNeedMakeForm

class function Tfs_ViewChangedFragments.Instance: Tfs_ViewChangedFragments;
 {* Метод получения экземпляра синглетона Tfs_ViewChangedFragments }
begin
 if (g_Tfs_ViewChangedFragments = nil) then
 begin
  l3System.AddExitProc(Tfs_ViewChangedFragmentsFree);
  g_Tfs_ViewChangedFragments := Create;
 end;
 Result := g_Tfs_ViewChangedFragments;
end;//Tfs_ViewChangedFragments.Instance

class function Tfs_ViewChangedFragments.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_ViewChangedFragments <> nil;
end;//Tfs_ViewChangedFragments.Exists

procedure Tfs_ViewChangedFragments.InitFields;
begin
 inherited;
 with AddZone('Parent', vcm_ztParent, fm_ChangesBetweenEditonsForm) do
 begin
  UserType := DocumentChanges;
  OnNeedMakeForm := ParentParentDocumentChangesNeedMakeForm;
 end;
 OwnerForm := 0;
end;//Tfs_ViewChangedFragments.InitFields

class function Tfs_ViewChangedFragments.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_ViewChangedFragments.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
