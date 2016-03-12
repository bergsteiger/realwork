unit fsCompareEditions;
 {* ��������� �������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\fsCompareEditions.pas"
// ���������: "VCMFormSetFactory"

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
 , DocumentInterfaces
 , RightEdition_Form
 , PrimRightEdition_utRightEdition_UserType
;

type
 // Left

 // Right

 // EditionsContainer

 Tfs_CompareEditions = {final} class(TvcmFormSetFactory)
  {* ��������� �������� ��������� }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function EditionsContainer_Parent_utEditionsContainer_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� EditionsContainer }
   function Left_Child_utLeftEdition_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Left }
   function Right_Main_utRightEdition_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Right }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: Tfs_CompareEditions;
    {* ����� ��������� ���������� ���������� Tfs_CompareEditions }
 end;//Tfs_CompareEditions
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 , SysUtils
 , l3Base
 , CompareEditions_FormDefinitions_Controls
;

{$If NOT Defined(NoVCM)}
var g_Tfs_CompareEditions: Tfs_CompareEditions = nil;
 {* ��������� ���������� Tfs_CompareEditions }

const
 {* ������������ ������ CompareEditionsCaptionLocalConstants }
 str_fsCompareEditionsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsCompareEditionsCaption'; rValue : '��������� ��������');
  {* ��������� ������� ������ ���� "CompareEditions" }

procedure Tfs_CompareEditionsFree;
 {* ����� ������������ ���������� ���������� Tfs_CompareEditions }
begin
 l3Free(g_Tfs_CompareEditions);
end;//Tfs_CompareEditionsFree

function Tfs_CompareEditions.EditionsContainer_Parent_utEditionsContainer_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� EditionsContainer }
//#UC START# *220564C38BDB_4A6EBF8301FA_var*
//#UC END# *220564C38BDB_4A6EBF8301FA_var*
begin
//#UC START# *220564C38BDB_4A6EBF8301FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *220564C38BDB_4A6EBF8301FA_impl*
end;//Tfs_CompareEditions.EditionsContainer_Parent_utEditionsContainer_NeedMakeForm

function Tfs_CompareEditions.Left_Child_utLeftEdition_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Left }
//#UC START# *2F2577A83E0B_4A6EBF8301FA_var*
//#UC END# *2F2577A83E0B_4A6EBF8301FA_var*
begin
//#UC START# *2F2577A83E0B_4A6EBF8301FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *2F2577A83E0B_4A6EBF8301FA_impl*
end;//Tfs_CompareEditions.Left_Child_utLeftEdition_NeedMakeForm

function Tfs_CompareEditions.Right_Main_utRightEdition_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Right }
//#UC START# *B8C95E6B157E_4A6EBF8301FA_var*
//#UC END# *B8C95E6B157E_4A6EBF8301FA_var*
begin
//#UC START# *B8C95E6B157E_4A6EBF8301FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *B8C95E6B157E_4A6EBF8301FA_impl*
end;//Tfs_CompareEditions.Right_Main_utRightEdition_NeedMakeForm

class function Tfs_CompareEditions.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tfs_CompareEditions <> nil;
end;//Tfs_CompareEditions.Exists

class function Tfs_CompareEditions.Instance: Tfs_CompareEditions;
 {* ����� ��������� ���������� ���������� Tfs_CompareEditions }
begin
 if (g_Tfs_CompareEditions = nil) then
 begin
  l3System.AddExitProc(Tfs_CompareEditionsFree);
  g_Tfs_CompareEditions := Create;
 end;
 Result := g_Tfs_CompareEditions;
end;//Tfs_CompareEditions.Instance

procedure Tfs_CompareEditions.InitFields;
//#UC START# *47A042E100E2_4A6EBF8301FA_var*
//#UC END# *47A042E100E2_4A6EBF8301FA_var*
begin
//#UC START# *47A042E100E2_4A6EBF8301FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4A6EBF8301FA_impl*
end;//Tfs_CompareEditions.InitFields

class function Tfs_CompareEditions.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4A6EBF8301FA_var*
//#UC END# *4FFE854A009B_4A6EBF8301FA_var*
begin
//#UC START# *4FFE854A009B_4A6EBF8301FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4A6EBF8301FA_impl*
end;//Tfs_CompareEditions.GetInstance

initialization
 str_fsCompareEditionsCaption.Init;
 {* ������������� str_fsCompareEditionsCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
