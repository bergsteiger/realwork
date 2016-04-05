unit Common_FormDefinitions_Controls;
 {* �������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common_FormDefinitions_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "FormDefinitions" MUID: (4BD856E802F9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_TextForm: TvcmFormDescriptor = (rFormID : (rName : 'TextForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TTextForm }

const
 fm_enUnderControl: TvcmFormDescriptor = (rFormID : (rName : 'enUnderControl'; rID : 0); rFactory : nil);
  {* ������������� ����� TenUnderControl }

const
 fm_cfFolders: TvcmFormDescriptor = (rFormID : (rName : 'cfFolders'; rID : 0); rFactory : nil);
  {* ������������� ����� TcfFolders }

const
 fm_en_Navigator: TvcmFormDescriptor = (rFormID : (rName : 'en_Navigator'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_Navigator }

const
 fm_en_TasksPanel: TvcmFormDescriptor = (rFormID : (rName : 'en_TasksPanel'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_TasksPanel }

const
 fm_enCompInfo: TvcmFormDescriptor = (rFormID : (rName : 'enCompInfo'; rID : 0); rFactory : nil);
  {* ������������� ����� TenCompInfo }

const
 fm_efRubricator: TvcmFormDescriptor = (rFormID : (rName : 'efRubricator'; rID : 0); rFactory : nil);
  {* ������������� ����� TefRubricator }

const
 fm_enDiction: TvcmFormDescriptor = (rFormID : (rName : 'enDiction'; rID : 0); rFactory : nil);
  {* ������������� ����� TenDiction }

const
 fm_WarningForm: TvcmFormDescriptor = (rFormID : (rName : 'WarningForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TWarningForm }

const
 fm_efListInfo: TvcmFormDescriptor = (rFormID : (rName : 'efListInfo'; rID : 0); rFactory : nil);
  {* ������������� ����� TefListInfo }

const
 fm_en_CommonDiction: TvcmFormDescriptor = (rFormID : (rName : 'en_CommonDiction'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_CommonDiction }

const
 fm_en_MedicMainMenu: TvcmFormDescriptor = (rFormID : (rName : 'en_MedicMainMenu'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_MedicMainMenu }

const
 fm_en_MedicFirmList: TvcmFormDescriptor = (rFormID : (rName : 'en_MedicFirmList'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_MedicFirmList }

const
 fm_efList: TvcmFormDescriptor = (rFormID : (rName : 'efList'; rID : 0); rFactory : nil);
  {* ������������� ����� TefList }

const
 fm_en_ConfigurationList: TvcmFormDescriptor = (rFormID : (rName : 'en_ConfigurationList'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_ConfigurationList }

const
 fm_en_MainMenuNew: TvcmFormDescriptor = (rFormID : (rName : 'en_MainMenuNew'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_MainMenuNew }

const
 fm_NewBaseSearchForm: TvcmFormDescriptor = (rFormID : (rName : 'NewBaseSearchForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TNewBaseSearchForm }

const
 fm_AttributesForm: TvcmFormDescriptor = (rFormID : (rName : 'AttributesForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TAttributesForm }

const
 fm_BaseSearchContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'BaseSearchContainerForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TBaseSearchContainerForm }

const
 fm_DictionContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'DictionContainerForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TDictionContainerForm }

const
 fm_enFilters: TvcmFormDescriptor = (rFormID : (rName : 'enFilters'; rID : 0); rFactory : nil);
  {* ������������� ����� TenFilters }

const
 fm_efTreeAttributeFirstLevel: TvcmFormDescriptor = (rFormID : (rName : 'efTreeAttributeFirstLevel'; rID : 0); rFactory : nil);
  {* ������������� ����� TefTreeAttributeFirstLevel }

const
 fm_WarningBaloonForm: TvcmFormDescriptor = (rFormID : (rName : 'WarningBaloonForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TWarningBaloonForm }

const
 fm_enNewsLine: TvcmFormDescriptor = (rFormID : (rName : 'enNewsLine'; rID : 0); rFactory : nil);
  {* ������������� ����� TenNewsLine }

const
 fm_RedactionsForm: TvcmFormDescriptor = (rFormID : (rName : 'RedactionsForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TRedactionsForm }

const
 fm_SynchroView_WarningBaloonForm: TvcmFormDescriptor = (rFormID : (rName : 'SynchroView_WarningBaloonForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TSynchroView_WarningBaloonForm }

const
 fm_Translation_WarningBaloonForm: TvcmFormDescriptor = (rFormID : (rName : 'Translation_WarningBaloonForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TTranslation_WarningBaloonForm }

const
 fm_UserCR1_WarningBaloonForm: TvcmFormDescriptor = (rFormID : (rName : 'UserCR1_WarningBaloonForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TUserCR1_WarningBaloonForm }

const
 fm_UserCR2_WarningBaloonForm: TvcmFormDescriptor = (rFormID : (rName : 'UserCR2_WarningBaloonForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TUserCR2_WarningBaloonForm }

const
 fm_ContentsForm: TvcmFormDescriptor = (rFormID : (rName : 'ContentsForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TContentsForm }

const
 fm_enFoldersTree: TvcmFormDescriptor = (rFormID : (rName : 'enFoldersTree'; rID : 0); rFactory : nil);
  {* ������������� ����� TenFoldersTree }

const
 fm_enFoldersElementInfo: TvcmFormDescriptor = (rFormID : (rName : 'enFoldersElementInfo'; rID : 0); rFactory : nil);
  {* ������������� ����� TenFoldersElementInfo }

const
 fm_DocumentWithFlashForm: TvcmFormDescriptor = (rFormID : (rName : 'DocumentWithFlashForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TDocumentWithFlashForm }

const
 fm_en_ConsultationMark: TvcmFormDescriptor = (rFormID : (rName : 'en_ConsultationMark'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_ConsultationMark }

const
 fm_en_MedicListSynchroView: TvcmFormDescriptor = (rFormID : (rName : 'en_MedicListSynchroView'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_MedicListSynchroView }

const
 fm_fcSynchroView: TvcmFormDescriptor = (rFormID : (rName : 'fcSynchroView'; rID : 0); rFactory : nil);
  {* ������������� ����� TfcSynchroView }

const
 fm_ListAnalizeForm: TvcmFormDescriptor = (rFormID : (rName : 'ListAnalizeForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TListAnalizeForm }

const
 fm_en_MainMenuWithProfNews: TvcmFormDescriptor = (rFormID : (rName : 'en_MainMenuWithProfNews'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_MainMenuWithProfNews }

type
 TextFormDef = interface
  {* ����� ��������� }
  ['{8ACB63E9-6A17-415F-BFE3-8D61511C601D}']
 end;//TextFormDef

 UnderControlFormDef = interface
  ['{ACD2CD87-6FE5-492F-976F-4348A383BF97}']
 end;//UnderControlFormDef

 FoldersFormDef = interface
  ['{4A1A6578-DBB2-4906-8783-B6A5BCBCA088}']
 end;//FoldersFormDef

 NavigatorFormDef = interface
  ['{6388603E-9911-43DF-A22C-CCC3CCB22372}']
 end;//NavigatorFormDef

 TasksPanelFormDef = interface
  ['{887F34C2-8E6D-44F9-9391-507027ECFAF5}']
 end;//TasksPanelFormDef

 CompInfoFormDef = interface
  ['{86DFC074-D3D0-4F5B-8DDB-B6E8CDFA33AA}']
 end;//CompInfoFormDef

 RubricatorFormDef = interface
  ['{49FDA55C-09CF-423E-8240-FA97D3B1C207}']
 end;//RubricatorFormDef

 DictionFormDef = interface
  ['{60F17E02-B5D1-410D-ACBA-16A367568329}']
 end;//DictionFormDef

 WarningFormDef = interface
  ['{0AAB6E3F-20EB-4283-BA08-E1603435DDD6}']
 end;//WarningFormDef

 ListInfoFormDef = interface
  ['{9A45EE29-E530-4A45-85D6-9675376A12AC}']
 end;//ListInfoFormDef

 CommonDictionFormDef = interface
  ['{EDB1FC7A-DB33-49F5-88EC-15E56B59A0DE}']
 end;//CommonDictionFormDef

 MedicMainMenuFormDef = interface
  ['{F50B553F-F92F-4873-82BB-CAA7767E3097}']
 end;//MedicMainMenuFormDef

 MedicFirmListFormDef = interface
  ['{85A6D8F9-E5D6-45EA-9004-8538F8E513D6}']
 end;//MedicFirmListFormDef

 ListFormDef = interface
  ['{BF7F18F9-6941-488D-9BE5-371AE1EA472E}']
 end;//ListFormDef

 ConfigurationListFormDef = interface
  ['{8A34BB41-E03B-45A5-B7C5-7EC04753334A}']
 end;//ConfigurationListFormDef

 MainMenuNewFormDef = interface
  ['{2E6D908A-C0DB-436F-AE47-89A298BDBBB5}']
 end;//MainMenuNewFormDef

 NewBaseSearchFormDef = interface
  ['{AB0DFE94-2A12-4B52-80C6-98E46D13768F}']
 end;//NewBaseSearchFormDef

 AttributesFormDef = interface
  ['{9EF0A8D5-9E66-4BFF-AEE0-672270506C0C}']
 end;//AttributesFormDef

 BaseSearchContainerFormDef = interface
  ['{B1E54AB6-D337-4D4D-829C-F219D2F39748}']
 end;//BaseSearchContainerFormDef

 DictionContainerFormDef = interface
  ['{AD9EF8FF-A856-441F-A8B7-77647FA346D8}']
 end;//DictionContainerFormDef

 FiltersFormDef = interface
  ['{436DC061-D4D1-4456-9A2B-BF7B09A6C172}']
 end;//FiltersFormDef

 TreeAttributeFirstLevelFormDef = interface
  ['{E6F1CE94-1C05-438C-A808-992FCD40C689}']
 end;//TreeAttributeFirstLevelFormDef

 WarningBaloonFormDef = interface
  ['{14ECBB1A-A52D-4EB8-9FD3-B472BD01406F}']
 end;//WarningBaloonFormDef

 NewsLineFormDef = interface
  ['{F1C4DD99-E021-465F-8842-57B439369A4E}']
 end;//NewsLineFormDef

 RedactionsFormDef = interface
  ['{9E114303-2A58-4B41-A2D1-134991C22BCD}']
 end;//RedactionsFormDef

 SynchroView_WarningBaloonFormDef = interface
  ['{AFD90CF1-37EE-4274-8935-47EC7DED8822}']
 end;//SynchroView_WarningBaloonFormDef

 Translation_WarningBaloonFormDef = interface
  ['{C82DF82D-D0F2-4AD3-AA06-3157E24F056C}']
 end;//Translation_WarningBaloonFormDef

 UserCR1_WarningBaloonFormDef = interface
  ['{113639D8-8BC9-4FDF-A50C-843C06A5A53D}']
 end;//UserCR1_WarningBaloonFormDef

 UserCR2_WarningBaloonFormDef = interface
  ['{22D5A010-5992-44A4-A87B-F56E743574F0}']
 end;//UserCR2_WarningBaloonFormDef

 ContentsFormDef = interface
  ['{F1E84DA6-7FF6-4A9B-8275-DD06C94E4E93}']
 end;//ContentsFormDef

 FoldersTreeFormDef = interface
  ['{01A0763F-994B-421C-BCBE-5FF656B323F0}']
 end;//FoldersTreeFormDef

 FoldersElementInfoFormDef = interface
  ['{490FF980-A825-424A-8262-EC4000273F43}']
 end;//FoldersElementInfoFormDef

 DocumentWithFlashFormDef = interface
  ['{E7A6A10F-696D-4C58-8E40-E9AFBA8BAF09}']
 end;//DocumentWithFlashFormDef

 ConsultationMarkFormDef = interface
  ['{9815E072-8A98-4376-A3A9-DD632649188A}']
 end;//ConsultationMarkFormDef

 MedicListSynchroViewFormDef = interface
  ['{5D662DCD-C0B2-4A9B-80F4-A1DC3FAB673B}']
 end;//MedicListSynchroViewFormDef

 SynchroViewFormDef = interface
  ['{0BC86C4B-C105-40F7-ADB5-A5A24C3E9F45}']
 end;//SynchroViewFormDef

 ListAnalizeFormDef = interface
  ['{C7F290D3-3BBE-4F07-9748-231F70CB5C22}']
 end;//ListAnalizeFormDef

 MainMenuWithProfNewsFormDef = interface
  ['{38026B15-FE8E-4BAF-9B6F-1B7174C5523F}']
 end;//MainMenuWithProfNewsFormDef
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwString
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_Text_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Text
----
*������ �������������*:
[code]
'aControl' �����::Text TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Text_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_UnderControl_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� UnderControl
----
*������ �������������*:
[code]
'aControl' �����::UnderControl TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UnderControl_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_Folders_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Folders
----
*������ �������������*:
[code]
'aControl' �����::Folders TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Folders_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_Navigator_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Navigator
----
*������ �������������*:
[code]
'aControl' �����::Navigator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Navigator_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_TasksPanel_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� TasksPanel
----
*������ �������������*:
[code]
'aControl' �����::TasksPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TasksPanel_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_CompInfo_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� CompInfo
----
*������ �������������*:
[code]
'aControl' �����::CompInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_CompInfo_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_Rubricator_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Rubricator
----
*������ �������������*:
[code]
'aControl' �����::Rubricator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Rubricator_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_Diction_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Diction
----
*������ �������������*:
[code]
'aControl' �����::Diction TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Diction_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_Warning_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Warning
----
*������ �������������*:
[code]
'aControl' �����::Warning TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Warning_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_ListInfo_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� ListInfo
----
*������ �������������*:
[code]
'aControl' �����::ListInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ListInfo_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_CommonDiction_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� CommonDiction
----
*������ �������������*:
[code]
'aControl' �����::CommonDiction TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_CommonDiction_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_MedicMainMenu_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� MedicMainMenu
----
*������ �������������*:
[code]
'aControl' �����::MedicMainMenu TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MedicMainMenu_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_MedicFirmList_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� MedicFirmList
----
*������ �������������*:
[code]
'aControl' �����::MedicFirmList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MedicFirmList_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_List_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� List
----
*������ �������������*:
[code]
'aControl' �����::List TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_List_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_ConfigurationList_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� ConfigurationList
----
*������ �������������*:
[code]
'aControl' �����::ConfigurationList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ConfigurationList_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_MainMenuNew_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� MainMenuNew
----
*������ �������������*:
[code]
'aControl' �����::MainMenuNew TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MainMenuNew_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_NewBaseSearch_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� NewBaseSearch
----
*������ �������������*:
[code]
'aControl' �����::NewBaseSearch TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_NewBaseSearch_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_Attributes_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Attributes
----
*������ �������������*:
[code]
'aControl' �����::Attributes TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Attributes_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_BaseSearchContainer_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� BaseSearchContainer
----
*������ �������������*:
[code]
'aControl' �����::BaseSearchContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_BaseSearchContainer_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_DictionContainer_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� DictionContainer
----
*������ �������������*:
[code]
'aControl' �����::DictionContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_DictionContainer_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_Filters_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Filters
----
*������ �������������*:
[code]
'aControl' �����::Filters TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Filters_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_TreeAttributeFirstLevel_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� TreeAttributeFirstLevel
----
*������ �������������*:
[code]
'aControl' �����::TreeAttributeFirstLevel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TreeAttributeFirstLevel_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_WarningBaloon_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� WarningBaloon
----
*������ �������������*:
[code]
'aControl' �����::WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_WarningBaloon_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_NewsLine_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� NewsLine
----
*������ �������������*:
[code]
'aControl' �����::NewsLine TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_NewsLine_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_Redactions_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Redactions
----
*������ �������������*:
[code]
'aControl' �����::Redactions TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Redactions_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_SynchroView_WarningBaloon_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� SynchroView_WarningBaloon
----
*������ �������������*:
[code]
'aControl' �����::SynchroView_WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SynchroView_WarningBaloon_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_Translation_WarningBaloon_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Translation_WarningBaloon
----
*������ �������������*:
[code]
'aControl' �����::Translation_WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Translation_WarningBaloon_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_UserCR1_WarningBaloon_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� UserCR1_WarningBaloon
----
*������ �������������*:
[code]
'aControl' �����::UserCR1_WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserCR1_WarningBaloon_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_UserCR2_WarningBaloon_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� UserCR2_WarningBaloon
----
*������ �������������*:
[code]
'aControl' �����::UserCR2_WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserCR2_WarningBaloon_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_Contents_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Contents
----
*������ �������������*:
[code]
'aControl' �����::Contents TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Contents_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_FoldersTree_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� FoldersTree
----
*������ �������������*:
[code]
'aControl' �����::FoldersTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_FoldersTree_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_FoldersElementInfo_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� FoldersElementInfo
----
*������ �������������*:
[code]
'aControl' �����::FoldersElementInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_FoldersElementInfo_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_DocumentWithFlash_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� DocumentWithFlash
----
*������ �������������*:
[code]
'aControl' �����::DocumentWithFlash TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_DocumentWithFlash_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_ConsultationMark_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� ConsultationMark
----
*������ �������������*:
[code]
'aControl' �����::ConsultationMark TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ConsultationMark_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_MedicListSynchroView_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� MedicListSynchroView
----
*������ �������������*:
[code]
'aControl' �����::MedicListSynchroView TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MedicListSynchroView_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_SynchroView_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� SynchroView
----
*������ �������������*:
[code]
'aControl' �����::SynchroView TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SynchroView_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_ListAnalize_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� ListAnalize
----
*������ �������������*:
[code]
'aControl' �����::ListAnalize TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ListAnalize_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_MainMenuWithProfNews_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� MainMenuWithProfNews
----
*������ �������������*:
[code]
'aControl' �����::MainMenuWithProfNews TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MainMenuWithProfNews_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Text_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Text';
end;//Tkw_Form_Text_ID.GetWordNameForRegister

function Tkw_Form_Text_ID.GetString: AnsiString;
begin
 Result := 'TextForm';
end;//Tkw_Form_Text_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_UnderControl_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::UnderControl';
end;//Tkw_Form_UnderControl_ID.GetWordNameForRegister

function Tkw_Form_UnderControl_ID.GetString: AnsiString;
begin
 Result := 'enUnderControl';
end;//Tkw_Form_UnderControl_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Folders_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Folders';
end;//Tkw_Form_Folders_ID.GetWordNameForRegister

function Tkw_Form_Folders_ID.GetString: AnsiString;
begin
 Result := 'cfFolders';
end;//Tkw_Form_Folders_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Navigator_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Navigator';
end;//Tkw_Form_Navigator_ID.GetWordNameForRegister

function Tkw_Form_Navigator_ID.GetString: AnsiString;
begin
 Result := 'en_Navigator';
end;//Tkw_Form_Navigator_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_TasksPanel_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::TasksPanel';
end;//Tkw_Form_TasksPanel_ID.GetWordNameForRegister

function Tkw_Form_TasksPanel_ID.GetString: AnsiString;
begin
 Result := 'en_TasksPanel';
end;//Tkw_Form_TasksPanel_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_CompInfo_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::CompInfo';
end;//Tkw_Form_CompInfo_ID.GetWordNameForRegister

function Tkw_Form_CompInfo_ID.GetString: AnsiString;
begin
 Result := 'enCompInfo';
end;//Tkw_Form_CompInfo_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Rubricator_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Rubricator';
end;//Tkw_Form_Rubricator_ID.GetWordNameForRegister

function Tkw_Form_Rubricator_ID.GetString: AnsiString;
begin
 Result := 'efRubricator';
end;//Tkw_Form_Rubricator_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Diction_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Diction';
end;//Tkw_Form_Diction_ID.GetWordNameForRegister

function Tkw_Form_Diction_ID.GetString: AnsiString;
begin
 Result := 'enDiction';
end;//Tkw_Form_Diction_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Warning_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Warning';
end;//Tkw_Form_Warning_ID.GetWordNameForRegister

function Tkw_Form_Warning_ID.GetString: AnsiString;
begin
 Result := 'WarningForm';
end;//Tkw_Form_Warning_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_ListInfo_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ListInfo';
end;//Tkw_Form_ListInfo_ID.GetWordNameForRegister

function Tkw_Form_ListInfo_ID.GetString: AnsiString;
begin
 Result := 'efListInfo';
end;//Tkw_Form_ListInfo_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_CommonDiction_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::CommonDiction';
end;//Tkw_Form_CommonDiction_ID.GetWordNameForRegister

function Tkw_Form_CommonDiction_ID.GetString: AnsiString;
begin
 Result := 'en_CommonDiction';
end;//Tkw_Form_CommonDiction_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_MedicMainMenu_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MedicMainMenu';
end;//Tkw_Form_MedicMainMenu_ID.GetWordNameForRegister

function Tkw_Form_MedicMainMenu_ID.GetString: AnsiString;
begin
 Result := 'en_MedicMainMenu';
end;//Tkw_Form_MedicMainMenu_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_MedicFirmList_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MedicFirmList';
end;//Tkw_Form_MedicFirmList_ID.GetWordNameForRegister

function Tkw_Form_MedicFirmList_ID.GetString: AnsiString;
begin
 Result := 'en_MedicFirmList';
end;//Tkw_Form_MedicFirmList_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_List_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::List';
end;//Tkw_Form_List_ID.GetWordNameForRegister

function Tkw_Form_List_ID.GetString: AnsiString;
begin
 Result := 'efList';
end;//Tkw_Form_List_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_ConfigurationList_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ConfigurationList';
end;//Tkw_Form_ConfigurationList_ID.GetWordNameForRegister

function Tkw_Form_ConfigurationList_ID.GetString: AnsiString;
begin
 Result := 'en_ConfigurationList';
end;//Tkw_Form_ConfigurationList_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_MainMenuNew_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MainMenuNew';
end;//Tkw_Form_MainMenuNew_ID.GetWordNameForRegister

function Tkw_Form_MainMenuNew_ID.GetString: AnsiString;
begin
 Result := 'en_MainMenuNew';
end;//Tkw_Form_MainMenuNew_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_NewBaseSearch_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::NewBaseSearch';
end;//Tkw_Form_NewBaseSearch_ID.GetWordNameForRegister

function Tkw_Form_NewBaseSearch_ID.GetString: AnsiString;
begin
 Result := 'NewBaseSearchForm';
end;//Tkw_Form_NewBaseSearch_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Attributes_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Attributes';
end;//Tkw_Form_Attributes_ID.GetWordNameForRegister

function Tkw_Form_Attributes_ID.GetString: AnsiString;
begin
 Result := 'AttributesForm';
end;//Tkw_Form_Attributes_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_BaseSearchContainer_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::BaseSearchContainer';
end;//Tkw_Form_BaseSearchContainer_ID.GetWordNameForRegister

function Tkw_Form_BaseSearchContainer_ID.GetString: AnsiString;
begin
 Result := 'BaseSearchContainerForm';
end;//Tkw_Form_BaseSearchContainer_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_DictionContainer_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::DictionContainer';
end;//Tkw_Form_DictionContainer_ID.GetWordNameForRegister

function Tkw_Form_DictionContainer_ID.GetString: AnsiString;
begin
 Result := 'DictionContainerForm';
end;//Tkw_Form_DictionContainer_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Filters_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Filters';
end;//Tkw_Form_Filters_ID.GetWordNameForRegister

function Tkw_Form_Filters_ID.GetString: AnsiString;
begin
 Result := 'enFilters';
end;//Tkw_Form_Filters_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_TreeAttributeFirstLevel_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::TreeAttributeFirstLevel';
end;//Tkw_Form_TreeAttributeFirstLevel_ID.GetWordNameForRegister

function Tkw_Form_TreeAttributeFirstLevel_ID.GetString: AnsiString;
begin
 Result := 'efTreeAttributeFirstLevel';
end;//Tkw_Form_TreeAttributeFirstLevel_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_WarningBaloon_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::WarningBaloon';
end;//Tkw_Form_WarningBaloon_ID.GetWordNameForRegister

function Tkw_Form_WarningBaloon_ID.GetString: AnsiString;
begin
 Result := 'WarningBaloonForm';
end;//Tkw_Form_WarningBaloon_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_NewsLine_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::NewsLine';
end;//Tkw_Form_NewsLine_ID.GetWordNameForRegister

function Tkw_Form_NewsLine_ID.GetString: AnsiString;
begin
 Result := 'enNewsLine';
end;//Tkw_Form_NewsLine_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Redactions_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Redactions';
end;//Tkw_Form_Redactions_ID.GetWordNameForRegister

function Tkw_Form_Redactions_ID.GetString: AnsiString;
begin
 Result := 'RedactionsForm';
end;//Tkw_Form_Redactions_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_SynchroView_WarningBaloon_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::SynchroView_WarningBaloon';
end;//Tkw_Form_SynchroView_WarningBaloon_ID.GetWordNameForRegister

function Tkw_Form_SynchroView_WarningBaloon_ID.GetString: AnsiString;
begin
 Result := 'SynchroView_WarningBaloonForm';
end;//Tkw_Form_SynchroView_WarningBaloon_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Translation_WarningBaloon_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Translation_WarningBaloon';
end;//Tkw_Form_Translation_WarningBaloon_ID.GetWordNameForRegister

function Tkw_Form_Translation_WarningBaloon_ID.GetString: AnsiString;
begin
 Result := 'Translation_WarningBaloonForm';
end;//Tkw_Form_Translation_WarningBaloon_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_UserCR1_WarningBaloon_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::UserCR1_WarningBaloon';
end;//Tkw_Form_UserCR1_WarningBaloon_ID.GetWordNameForRegister

function Tkw_Form_UserCR1_WarningBaloon_ID.GetString: AnsiString;
begin
 Result := 'UserCR1_WarningBaloonForm';
end;//Tkw_Form_UserCR1_WarningBaloon_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_UserCR2_WarningBaloon_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::UserCR2_WarningBaloon';
end;//Tkw_Form_UserCR2_WarningBaloon_ID.GetWordNameForRegister

function Tkw_Form_UserCR2_WarningBaloon_ID.GetString: AnsiString;
begin
 Result := 'UserCR2_WarningBaloonForm';
end;//Tkw_Form_UserCR2_WarningBaloon_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Contents_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Contents';
end;//Tkw_Form_Contents_ID.GetWordNameForRegister

function Tkw_Form_Contents_ID.GetString: AnsiString;
begin
 Result := 'ContentsForm';
end;//Tkw_Form_Contents_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_FoldersTree_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::FoldersTree';
end;//Tkw_Form_FoldersTree_ID.GetWordNameForRegister

function Tkw_Form_FoldersTree_ID.GetString: AnsiString;
begin
 Result := 'enFoldersTree';
end;//Tkw_Form_FoldersTree_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_FoldersElementInfo_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::FoldersElementInfo';
end;//Tkw_Form_FoldersElementInfo_ID.GetWordNameForRegister

function Tkw_Form_FoldersElementInfo_ID.GetString: AnsiString;
begin
 Result := 'enFoldersElementInfo';
end;//Tkw_Form_FoldersElementInfo_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_DocumentWithFlash_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::DocumentWithFlash';
end;//Tkw_Form_DocumentWithFlash_ID.GetWordNameForRegister

function Tkw_Form_DocumentWithFlash_ID.GetString: AnsiString;
begin
 Result := 'DocumentWithFlashForm';
end;//Tkw_Form_DocumentWithFlash_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_ConsultationMark_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ConsultationMark';
end;//Tkw_Form_ConsultationMark_ID.GetWordNameForRegister

function Tkw_Form_ConsultationMark_ID.GetString: AnsiString;
begin
 Result := 'en_ConsultationMark';
end;//Tkw_Form_ConsultationMark_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_MedicListSynchroView_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MedicListSynchroView';
end;//Tkw_Form_MedicListSynchroView_ID.GetWordNameForRegister

function Tkw_Form_MedicListSynchroView_ID.GetString: AnsiString;
begin
 Result := 'en_MedicListSynchroView';
end;//Tkw_Form_MedicListSynchroView_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_SynchroView_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::SynchroView';
end;//Tkw_Form_SynchroView_ID.GetWordNameForRegister

function Tkw_Form_SynchroView_ID.GetString: AnsiString;
begin
 Result := 'fcSynchroView';
end;//Tkw_Form_SynchroView_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_ListAnalize_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ListAnalize';
end;//Tkw_Form_ListAnalize_ID.GetWordNameForRegister

function Tkw_Form_ListAnalize_ID.GetString: AnsiString;
begin
 Result := 'ListAnalizeForm';
end;//Tkw_Form_ListAnalize_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_MainMenuWithProfNews_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MainMenuWithProfNews';
end;//Tkw_Form_MainMenuWithProfNews_ID.GetWordNameForRegister

function Tkw_Form_MainMenuWithProfNews_ID.GetString: AnsiString;
begin
 Result := 'en_MainMenuWithProfNews';
end;//Tkw_Form_MainMenuWithProfNews_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_Form_Text_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Text_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_UnderControl_ID.RegisterInEngine;
 {* ����������� Tkw_Form_UnderControl_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Folders_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Folders_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Navigator_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Navigator_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_TasksPanel_ID.RegisterInEngine;
 {* ����������� Tkw_Form_TasksPanel_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_CompInfo_ID.RegisterInEngine;
 {* ����������� Tkw_Form_CompInfo_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Rubricator_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Rubricator_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Diction_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Diction_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Warning_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Warning_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_ListInfo_ID.RegisterInEngine;
 {* ����������� Tkw_Form_ListInfo_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_CommonDiction_ID.RegisterInEngine;
 {* ����������� Tkw_Form_CommonDiction_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_MedicMainMenu_ID.RegisterInEngine;
 {* ����������� Tkw_Form_MedicMainMenu_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_MedicFirmList_ID.RegisterInEngine;
 {* ����������� Tkw_Form_MedicFirmList_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_List_ID.RegisterInEngine;
 {* ����������� Tkw_Form_List_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_ConfigurationList_ID.RegisterInEngine;
 {* ����������� Tkw_Form_ConfigurationList_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_MainMenuNew_ID.RegisterInEngine;
 {* ����������� Tkw_Form_MainMenuNew_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_NewBaseSearch_ID.RegisterInEngine;
 {* ����������� Tkw_Form_NewBaseSearch_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Attributes_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Attributes_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_BaseSearchContainer_ID.RegisterInEngine;
 {* ����������� Tkw_Form_BaseSearchContainer_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_DictionContainer_ID.RegisterInEngine;
 {* ����������� Tkw_Form_DictionContainer_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Filters_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Filters_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_TreeAttributeFirstLevel_ID.RegisterInEngine;
 {* ����������� Tkw_Form_TreeAttributeFirstLevel_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_WarningBaloon_ID.RegisterInEngine;
 {* ����������� Tkw_Form_WarningBaloon_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_NewsLine_ID.RegisterInEngine;
 {* ����������� Tkw_Form_NewsLine_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Redactions_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Redactions_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_SynchroView_WarningBaloon_ID.RegisterInEngine;
 {* ����������� Tkw_Form_SynchroView_WarningBaloon_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Translation_WarningBaloon_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Translation_WarningBaloon_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_UserCR1_WarningBaloon_ID.RegisterInEngine;
 {* ����������� Tkw_Form_UserCR1_WarningBaloon_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_UserCR2_WarningBaloon_ID.RegisterInEngine;
 {* ����������� Tkw_Form_UserCR2_WarningBaloon_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Contents_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Contents_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_FoldersTree_ID.RegisterInEngine;
 {* ����������� Tkw_Form_FoldersTree_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_FoldersElementInfo_ID.RegisterInEngine;
 {* ����������� Tkw_Form_FoldersElementInfo_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_DocumentWithFlash_ID.RegisterInEngine;
 {* ����������� Tkw_Form_DocumentWithFlash_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_ConsultationMark_ID.RegisterInEngine;
 {* ����������� Tkw_Form_ConsultationMark_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_MedicListSynchroView_ID.RegisterInEngine;
 {* ����������� Tkw_Form_MedicListSynchroView_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_SynchroView_ID.RegisterInEngine;
 {* ����������� Tkw_Form_SynchroView_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_ListAnalize_ID.RegisterInEngine;
 {* ����������� Tkw_Form_ListAnalize_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_MainMenuWithProfNews_ID.RegisterInEngine;
 {* ����������� Tkw_Form_MainMenuWithProfNews_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
