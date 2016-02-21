unit fsViewChangedFragments;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\fsViewChangedFragments.pas"
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
 , ChangesBetweenEditons_Form
 , PrimChangesBetweenEditons_DocumentChanges_UserType
 , ChangesBetweenEditionsInterfaces
 , DocumentUnit
 , nevTools
 , DocumentInterfaces
;

type
 // Parent

 Tfs_ViewChangedFragments = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Parent_Parent_DocumentChanges_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Parent }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: Tfs_ViewChangedFragments;
    {* ����� ��������� ���������� ���������� Tfs_ViewChangedFragments }
 end;//Tfs_ViewChangedFragments
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tfs_ViewChangedFragments: Tfs_ViewChangedFragments = nil;
 {* ��������� ���������� Tfs_ViewChangedFragments }

procedure Tfs_ViewChangedFragmentsFree;
 {* ����� ������������ ���������� ���������� Tfs_ViewChangedFragments }
begin
 l3Free(g_Tfs_ViewChangedFragments);
end;//Tfs_ViewChangedFragmentsFree

function Tfs_ViewChangedFragments.Parent_Parent_DocumentChanges_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Parent }
//#UC START# *9C7EE9D70E75_4DDCBC5C0211_var*
//#UC END# *9C7EE9D70E75_4DDCBC5C0211_var*
begin
//#UC START# *9C7EE9D70E75_4DDCBC5C0211_impl*
 !!! Needs to be implemented !!!
//#UC END# *9C7EE9D70E75_4DDCBC5C0211_impl*
end;//Tfs_ViewChangedFragments.Parent_Parent_DocumentChanges_NeedMakeForm

class function Tfs_ViewChangedFragments.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tfs_ViewChangedFragments <> nil;
end;//Tfs_ViewChangedFragments.Exists

class function Tfs_ViewChangedFragments.Instance: Tfs_ViewChangedFragments;
 {* ����� ��������� ���������� ���������� Tfs_ViewChangedFragments }
begin
 if (g_Tfs_ViewChangedFragments = nil) then
 begin
  l3System.AddExitProc(Tfs_ViewChangedFragmentsFree);
  g_Tfs_ViewChangedFragments := Create;
 end;
 Result := g_Tfs_ViewChangedFragments;
end;//Tfs_ViewChangedFragments.Instance

procedure Tfs_ViewChangedFragments.InitFields;
//#UC START# *47A042E100E2_4DDCBC5C0211_var*
//#UC END# *47A042E100E2_4DDCBC5C0211_var*
begin
//#UC START# *47A042E100E2_4DDCBC5C0211_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4DDCBC5C0211_impl*
end;//Tfs_ViewChangedFragments.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_ViewChangedFragments.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4DDCBC5C0211_var*
//#UC END# *4FFE854A009B_4DDCBC5C0211_var*
begin
//#UC START# *4FFE854A009B_4DDCBC5C0211_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4DDCBC5C0211_impl*
end;//Tfs_ViewChangedFragments.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
