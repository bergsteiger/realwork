unit fsTips;
 {* ������ ��� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\fsTips.pas"
// ���������: "VCMFormSetFactory"
// ������� ������: "Tips" MUID: (4AA12AC20374)
// ��� ����: "Tfs_Tips"

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
 , DocumentUserTypes_dftTips_UserType
 , Common_FormDefinitions_Controls
 , DocumentAndListInterfaces
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentUnit
 , l3Interfaces
 , bsTypesNew
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
 , l3InternalInterfaces
 , l3TreeInterfaces
 , PrimCommonDiction_utTips_UserType
 , CommonDictionInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
;

type
 Tfs_Tips = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* ������ ��� }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function TextFormParentDftTipsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� TextForm }
   function AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Attributes }
   function CommonDictionNavigatorUtTipsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� CommonDiction }
   class function Instance: Tfs_Tips;
    {* ����� ��������� ���������� ���������� Tfs_Tips }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tfs_Tips
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_Tfs_Tips: Tfs_Tips = nil;
 {* ��������� ���������� Tfs_Tips }

const
 {* ������������ ������ TipsCaptionLocalConstants }
 str_fsTipsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsTipsCaption'; rValue : '#1057#1086#1074#1077#1090 #1076#1085#1103');
  {* ��������� ������� ������ ���� "Tips" }

procedure Tfs_TipsFree;
 {* ����� ������������ ���������� ���������� Tfs_Tips }
begin
 l3Free(g_Tfs_Tips);
end;//Tfs_TipsFree

function Tfs_Tips.TextFormParentDftTipsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� TextForm }
var
 l_UseCase : IsdsBaseDocument;
begin
 if Supports(aDataSource, IsdsBaseDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsDocument;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Tips.TextFormParentDftTipsNeedMakeForm

function Tfs_Tips.AttributesChildFDocAttributeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Attributes }
var
 l_UseCase : IsdsBaseDocumentWithAttributes;
begin
 if Supports(aDataSource, IsdsBaseDocumentWithAttributes, l_UseCase) then
  try
   aNew := l_UseCase.dsAttributes;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Tips.AttributesChildFDocAttributeNeedMakeForm

function Tfs_Tips.CommonDictionNavigatorUtTipsNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� CommonDiction }
var
 l_UseCase : IsdsCommonDiction;
begin
 if Supports(aDataSource, IsdsCommonDiction, l_UseCase) then
  try
   aNew := l_UseCase.dsContents;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_Tips.CommonDictionNavigatorUtTipsNeedMakeForm

class function Tfs_Tips.Instance: Tfs_Tips;
 {* ����� ��������� ���������� ���������� Tfs_Tips }
begin
 if (g_Tfs_Tips = nil) then
 begin
  l3System.AddExitProc(Tfs_TipsFree);
  g_Tfs_Tips := Create;
 end;
 Result := g_Tfs_Tips;
end;//Tfs_Tips.Instance

class function Tfs_Tips.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tfs_Tips <> nil;
end;//Tfs_Tips.Exists

procedure Tfs_Tips.InitFields;
begin
 inherited;
 with AddZone('TextForm', vcm_ztParent, fm_TextForm) do
 begin
  UserType := dftTips;
  OnNeedMakeForm := TextFormParentDftTipsNeedMakeForm;
 end;
 with AddZone('Attributes', vcm_ztChild, fm_AttributesForm) do
 begin
  UserType := fDocAttribute;
  OnNeedMakeForm := AttributesChildFDocAttributeNeedMakeForm;
 end;
 with AddZone('CommonDiction', vcm_ztNavigator, fm_en_CommonDiction) do
 begin
  UserType := utTips;
  ActivateIfUpdate := wafAlways;
  OnNeedMakeForm := CommonDictionNavigatorUtTipsNeedMakeForm;
 end;
 Caption := str_fsTipsCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_Tips.InitFields

class function Tfs_Tips.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_Tips.GetInstance

initialization
 str_fsTipsCaption.Init;
 {* ������������� str_fsTipsCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
