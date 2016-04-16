unit fsDiction;
 {* ������ ���� ��������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\fsDiction.pas"
// ���������: "VCMFormSetFactory"
// ������� ������: "Diction" MUID: (4A9D19450248)
// ��� ����: "Tfs_Diction"

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
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DictionContainerUserTypes_slqtDiction_UserType
 , Common_FormDefinitions_Controls
 , CommonDictionInterfaces
 , DocumentUserTypes_dftDictEntry_UserType
 , DocumentAndListInterfaces
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentUnit
 , bsTypesNew
 , PrimDiction_utDiction_UserType
 , l3InternalInterfaces
 , l3TreeInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , PrimChild_cutForDiction_UserType
 , F1Like_FormDefinitions_Controls
 , DocumentUserTypes_dftDictSubEntry_UserType
 , DictionInterfaces
 , DictionInterfacesPrim
 , DynamicTreeUnit
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
;

type
 // DictEntry

 // Diction

 // DictSubEntry

 // Attribute

 // Child

 // DictionContainer

 Tfs_Diction = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* ������ ���� ��������� ������� }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoMakeFormSetCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoMakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoMakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function DictionContainer_Parent_slqtDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� DictionContainer }
   function DictEntry_Parent_dftDictEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� DictEntry }
   function Diction_Navigator_utDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Diction }
   function Child_Child_cutForDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Child }
   function DictSubEntry_Child_dftDictSubEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� DictSubEntry }
   procedure DictSubEntry_Child_dftDictSubEntryGetFormCount(const aDataSource: IvcmFormSetDataSource;
    out aCount: Integer);
    {* ���������� OnFormCount ��� DictSubEntry }
   function Attribute_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* ���������� OnNeedMakeForm ��� Attribute }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   procedure DoGetMainImageIndex(aSender: TObject;
    const aDataSource: IvcmFormSetDataSource;
    var aImageIndex: Integer);
    {* ���������� OnGetMainImageIndex ��� Diction$FS }
   procedure DoGetMainCaption(aSender: TObject;
    const aDataSource: IvcmFormSetDataSource;
    var aCaption: Il3CString);
    {* ���������� GetMainCaption ��� Diction$FS }
   class function Instance: Tfs_Diction;
    {* ����� ��������� ���������� ���������� Tfs_Diction }
 end;//Tfs_Diction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , bsUtils
 , SysUtils
 , nsDocumentTools
 , l3String
 , l3MessageID
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_Tfs_Diction: Tfs_Diction = nil;
 {* ��������� ���������� Tfs_Diction }

const
 {* ������������ ������ Tab consts }
 str_DictionFormSetCaptionPrefix: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DictionFormSetCaptionPrefix'; rValue : '����� ��������� ������');
  {* '����� ��������� ������' }
 {* ������������ ������ Diction$FSCaptionLocalConstants }
 str_fsDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDictionCaption'; rValue : '�������� �������');
  {* ��������� ������� ������ ���� "Diction$FS" }

procedure Tfs_DictionFree;
 {* ����� ������������ ���������� ���������� Tfs_Diction }
begin
 l3Free(g_Tfs_Diction);
end;//Tfs_DictionFree

function Tfs_Diction.DictionContainer_Parent_slqtDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� DictionContainer }
//#UC START# *B6E2EA9874BB_4A9D19450248_var*
//#UC END# *B6E2EA9874BB_4A9D19450248_var*
begin
//#UC START# *B6E2EA9874BB_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *B6E2EA9874BB_4A9D19450248_impl*
end;//Tfs_Diction.DictionContainer_Parent_slqtDiction_NeedMakeForm

function Tfs_Diction.DictEntry_Parent_dftDictEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� DictEntry }
//#UC START# *956E84A5725C_4A9D19450248_var*
//#UC END# *956E84A5725C_4A9D19450248_var*
begin
//#UC START# *956E84A5725C_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *956E84A5725C_4A9D19450248_impl*
end;//Tfs_Diction.DictEntry_Parent_dftDictEntry_NeedMakeForm

function Tfs_Diction.Diction_Navigator_utDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Diction }
//#UC START# *F7505AA053D6_4A9D19450248_var*
//#UC END# *F7505AA053D6_4A9D19450248_var*
begin
//#UC START# *F7505AA053D6_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *F7505AA053D6_4A9D19450248_impl*
end;//Tfs_Diction.Diction_Navigator_utDiction_NeedMakeForm

function Tfs_Diction.Child_Child_cutForDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Child }
//#UC START# *F7E18EECF870_4A9D19450248_var*
//#UC END# *F7E18EECF870_4A9D19450248_var*
begin
//#UC START# *F7E18EECF870_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *F7E18EECF870_4A9D19450248_impl*
end;//Tfs_Diction.Child_Child_cutForDiction_NeedMakeForm

function Tfs_Diction.DictSubEntry_Child_dftDictSubEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� DictSubEntry }
//#UC START# *2E81DBAB301C_4A9D19450248_var*
//#UC END# *2E81DBAB301C_4A9D19450248_var*
begin
//#UC START# *2E81DBAB301C_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *2E81DBAB301C_4A9D19450248_impl*
end;//Tfs_Diction.DictSubEntry_Child_dftDictSubEntry_NeedMakeForm

procedure Tfs_Diction.DictSubEntry_Child_dftDictSubEntryGetFormCount(const aDataSource: IvcmFormSetDataSource;
 out aCount: Integer);
 {* ���������� OnFormCount ��� DictSubEntry }
//#UC START# *CF6948E21F14_4A9D19450248_var*
var
 l_SDS: IsdsDiction;
//#UC END# *CF6948E21F14_4A9D19450248_var*
begin
//#UC START# *CF6948E21F14_4A9D19450248_impl*
 aCount := 0;
 if Supports(aDataSource, IsdsDiction, l_SDS) then
 try
  aCount := l_SDS.TranslationForms;
 finally
  l_SDS := nil;
 end;//try..finally
//#UC END# *CF6948E21F14_4A9D19450248_impl*
end;//Tfs_Diction.DictSubEntry_Child_dftDictSubEntryGetFormCount

function Tfs_Diction.Attribute_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* ���������� OnNeedMakeForm ��� Attribute }
//#UC START# *28D865AEFFD5_4A9D19450248_var*
//#UC END# *28D865AEFFD5_4A9D19450248_var*
begin
//#UC START# *28D865AEFFD5_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *28D865AEFFD5_4A9D19450248_impl*
end;//Tfs_Diction.Attribute_Child_fDocAttribute_NeedMakeForm

class function Tfs_Diction.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tfs_Diction <> nil;
end;//Tfs_Diction.Exists

procedure Tfs_Diction.DoGetMainImageIndex(aSender: TObject;
 const aDataSource: IvcmFormSetDataSource;
 var aImageIndex: Integer);
 {* ���������� OnGetMainImageIndex ��� Diction$FS }
//#UC START# *C82B5B254974_4A9D19450248_var*
var
 l_SDS: IsdsDiction;
//#UC END# *C82B5B254974_4A9D19450248_var*
begin
//#UC START# *C82B5B254974_4A9D19450248_impl*
 if Supports(aDataSource, IsdsDiction, l_SDS) then
  aImageIndex := bsLanguageImage(l_SDS.DefaultLanguage);
//#UC END# *C82B5B254974_4A9D19450248_impl*
end;//Tfs_Diction.DoGetMainImageIndex

procedure Tfs_Diction.DoGetMainCaption(aSender: TObject;
 const aDataSource: IvcmFormSetDataSource;
 var aCaption: Il3CString);
 {* ���������� GetMainCaption ��� Diction$FS }
//#UC START# *616F19145E64_4A9D19450248_var*
var
 l_SDS: IsdsDiction;
//#UC END# *616F19145E64_4A9D19450248_var*
begin
//#UC START# *616F19145E64_4A9D19450248_impl*
 if Supports(aDataSource, IsdsDiction, l_SDS) then
  aCaption := bsLanguageCaption(l_SDS.DefaultLanguage);
//#UC END# *616F19145E64_4A9D19450248_impl*
end;//Tfs_Diction.DoGetMainCaption

class function Tfs_Diction.Instance: Tfs_Diction;
 {* ����� ��������� ���������� ���������� Tfs_Diction }
begin
 if (g_Tfs_Diction = nil) then
 begin
  l3System.AddExitProc(Tfs_DictionFree);
  g_Tfs_Diction := Create;
 end;
 Result := g_Tfs_Diction;
end;//Tfs_Diction.Instance

procedure Tfs_Diction.InitFields;
//#UC START# *47A042E100E2_4A9D19450248_var*
//#UC END# *47A042E100E2_4A9D19450248_var*
begin
//#UC START# *47A042E100E2_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4A9D19450248_impl*
end;//Tfs_Diction.InitFields

class function Tfs_Diction.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4A9D19450248_var*
//#UC END# *4FFE854A009B_4A9D19450248_var*
begin
//#UC START# *4FFE854A009B_4A9D19450248_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4A9D19450248_impl*
end;//Tfs_Diction.GetInstance

function Tfs_Diction.DoMakeFormSetCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352A903E5_4A9D19450248_var*
var
 l_TabCaption: IvcmCString;
//#UC END# *54B352A903E5_4A9D19450248_var*
begin
//#UC START# *54B352A903E5_4A9D19450248_impl*
 l_TabCaption := DoMakeFormSetTabCaption(aDataSource);
 Result := l3Cat([str_DictionFormSetCaptionPrefix.AsCStr, l3CStr(' : '), l_TabCaption]);
//#UC END# *54B352A903E5_4A9D19450248_impl*
end;//Tfs_Diction.DoMakeFormSetCaption

function Tfs_Diction.DoMakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352D401E5_4A9D19450248_var*
var
 l_sds: IsdsDiction;
//#UC END# *54B352D401E5_4A9D19450248_var*
begin
//#UC START# *54B352D401E5_4A9D19450248_impl*
 if Supports(aDataSource, IsdsDiction, l_sds) and
    (l_sds.DocInfo <> nil) and
    (l_sds.DocInfo.Doc <> nil) then
  Result := nsGetDocumentName(l_sds.DocInfo.Doc)
 else
  Result := nil;
//#UC END# *54B352D401E5_4A9D19450248_impl*
end;//Tfs_Diction.DoMakeFormSetTabCaption

function Tfs_Diction.DoMakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString;
//#UC START# *54B352FB03A1_4A9D19450248_var*
//#UC END# *54B352FB03A1_4A9D19450248_var*
begin
//#UC START# *54B352FB03A1_4A9D19450248_impl*
 Result := DoMakeFormSetCaption(aDataSource);
//#UC END# *54B352FB03A1_4A9D19450248_impl*
end;//Tfs_Diction.DoMakeFormSetTabHint

initialization
 str_DictionFormSetCaptionPrefix.Init;
 {* ������������� str_DictionFormSetCaptionPrefix }
 str_fsDictionCaption.Init;
 {* ������������� str_fsDictionCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
