unit fsDocumentWithFlash;
 {* ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\fsDocumentWithFlash.pas"
// ���������: "VCMFormSetFactory"
// ������� ������: "DocumentWithFlash" MUID: (4AA126F9032A)
// ��� ����: "Tfs_DocumentWithFlash"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , fsAbstractDocument
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentWithFlashUserTypes_dwftMain_UserType
 , Common_FormDefinitions_Controls
 , DocInfoInterfaces
 , DocumentInterfaces
 , nevTools
 , bsTypes
 , evdInterfaces
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3Interfaces
;

type
 // Text

 Tfs_DocumentWithFlash = {final} class(Tfs_AbstractDocument)
  {* ����� }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Text_Parent_dwftMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Text }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: Tfs_DocumentWithFlash;
    {* ����� ��������� ���������� ���������� Tfs_DocumentWithFlash }
 end;//Tfs_DocumentWithFlash
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

var g_Tfs_DocumentWithFlash: Tfs_DocumentWithFlash = nil;
 {* ��������� ���������� Tfs_DocumentWithFlash }

const
 {* ������������ ������ DocumentWithFlash$FSFCaptionLocalConstants }
 str_fsDocumentWithFlashCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDocumentWithFlashCaption'; rValue : '�����');
  {* ��������� ������� ������ ���� "DocumentWithFlash$FSF" }

procedure Tfs_DocumentWithFlashFree;
 {* ����� ������������ ���������� ���������� Tfs_DocumentWithFlash }
begin
 l3Free(g_Tfs_DocumentWithFlash);
end;//Tfs_DocumentWithFlashFree

function Tfs_DocumentWithFlash.Text_Parent_dwftMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Text }
//#UC START# *7296B8CF664D_4AA126F9032A_var*
//#UC END# *7296B8CF664D_4AA126F9032A_var*
begin
//#UC START# *7296B8CF664D_4AA126F9032A_impl*
 !!! Needs to be implemented !!!
//#UC END# *7296B8CF664D_4AA126F9032A_impl*
end;//Tfs_DocumentWithFlash.Text_Parent_dwftMain_NeedMakeForm

class function Tfs_DocumentWithFlash.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tfs_DocumentWithFlash <> nil;
end;//Tfs_DocumentWithFlash.Exists

class function Tfs_DocumentWithFlash.Instance: Tfs_DocumentWithFlash;
 {* ����� ��������� ���������� ���������� Tfs_DocumentWithFlash }
begin
 if (g_Tfs_DocumentWithFlash = nil) then
 begin
  l3System.AddExitProc(Tfs_DocumentWithFlashFree);
  g_Tfs_DocumentWithFlash := Create;
 end;
 Result := g_Tfs_DocumentWithFlash;
end;//Tfs_DocumentWithFlash.Instance

procedure Tfs_DocumentWithFlash.InitFields;
//#UC START# *47A042E100E2_4AA126F9032A_var*
//#UC END# *47A042E100E2_4AA126F9032A_var*
begin
//#UC START# *47A042E100E2_4AA126F9032A_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA126F9032A_impl*
end;//Tfs_DocumentWithFlash.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_DocumentWithFlash.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA126F9032A_var*
//#UC END# *4FFE854A009B_4AA126F9032A_var*
begin
//#UC START# *4FFE854A009B_4AA126F9032A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA126F9032A_impl*
end;//Tfs_DocumentWithFlash.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_fsDocumentWithFlashCaption.Init;
 {* ������������� str_fsDocumentWithFlashCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
