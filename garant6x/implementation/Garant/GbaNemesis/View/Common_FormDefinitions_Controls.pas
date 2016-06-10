unit Common_FormDefinitions_Controls;
 {* Описания форм }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common_FormDefinitions_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "FormDefinitions" MUID: (4BD856E802F9)

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
  {* Идентификатор формы TTextForm }
 fm_enUnderControl: TvcmFormDescriptor = (rFormID : (rName : 'enUnderControl'; rID : 0); rFactory : nil);
  {* Идентификатор формы TenUnderControl }
 fm_cfFolders: TvcmFormDescriptor = (rFormID : (rName : 'cfFolders'; rID : 0); rFactory : nil);
  {* Идентификатор формы TcfFolders }
 fm_en_Navigator: TvcmFormDescriptor = (rFormID : (rName : 'en_Navigator'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_Navigator }
 fm_en_TasksPanel: TvcmFormDescriptor = (rFormID : (rName : 'en_TasksPanel'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_TasksPanel }
 fm_enCompInfo: TvcmFormDescriptor = (rFormID : (rName : 'enCompInfo'; rID : 0); rFactory : nil);
  {* Идентификатор формы TenCompInfo }
 fm_efRubricator: TvcmFormDescriptor = (rFormID : (rName : 'efRubricator'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefRubricator }
 fm_enDiction: TvcmFormDescriptor = (rFormID : (rName : 'enDiction'; rID : 0); rFactory : nil);
  {* Идентификатор формы TenDiction }
 fm_WarningForm: TvcmFormDescriptor = (rFormID : (rName : 'WarningForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TWarningForm }
 fm_efListInfo: TvcmFormDescriptor = (rFormID : (rName : 'efListInfo'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefListInfo }
 fm_en_CommonDiction: TvcmFormDescriptor = (rFormID : (rName : 'en_CommonDiction'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_CommonDiction }
 fm_en_MedicMainMenu: TvcmFormDescriptor = (rFormID : (rName : 'en_MedicMainMenu'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_MedicMainMenu }
 fm_en_MedicFirmList: TvcmFormDescriptor = (rFormID : (rName : 'en_MedicFirmList'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_MedicFirmList }
 fm_efList: TvcmFormDescriptor = (rFormID : (rName : 'efList'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefList }
 fm_en_ConfigurationList: TvcmFormDescriptor = (rFormID : (rName : 'en_ConfigurationList'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_ConfigurationList }
 fm_en_MainMenuNew: TvcmFormDescriptor = (rFormID : (rName : 'en_MainMenuNew'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_MainMenuNew }
 fm_NewBaseSearchForm: TvcmFormDescriptor = (rFormID : (rName : 'NewBaseSearchForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TNewBaseSearchForm }
 fm_AttributesForm: TvcmFormDescriptor = (rFormID : (rName : 'AttributesForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TAttributesForm }
 fm_BaseSearchContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'BaseSearchContainerForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TBaseSearchContainerForm }
 fm_DictionContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'DictionContainerForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TDictionContainerForm }
 fm_enFilters: TvcmFormDescriptor = (rFormID : (rName : 'enFilters'; rID : 0); rFactory : nil);
  {* Идентификатор формы TenFilters }
 fm_efTreeAttributeFirstLevel: TvcmFormDescriptor = (rFormID : (rName : 'efTreeAttributeFirstLevel'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefTreeAttributeFirstLevel }
 fm_WarningBaloonForm: TvcmFormDescriptor = (rFormID : (rName : 'WarningBaloonForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TWarningBaloonForm }
 fm_enNewsLine: TvcmFormDescriptor = (rFormID : (rName : 'enNewsLine'; rID : 0); rFactory : nil);
  {* Идентификатор формы TenNewsLine }
 fm_RedactionsForm: TvcmFormDescriptor = (rFormID : (rName : 'RedactionsForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TRedactionsForm }
 fm_SynchroView_WarningBaloonForm: TvcmFormDescriptor = (rFormID : (rName : 'SynchroView_WarningBaloonForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TSynchroView_WarningBaloonForm }
 fm_Translation_WarningBaloonForm: TvcmFormDescriptor = (rFormID : (rName : 'Translation_WarningBaloonForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TTranslation_WarningBaloonForm }
 fm_UserCR1_WarningBaloonForm: TvcmFormDescriptor = (rFormID : (rName : 'UserCR1_WarningBaloonForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TUserCR1_WarningBaloonForm }
 fm_UserCR2_WarningBaloonForm: TvcmFormDescriptor = (rFormID : (rName : 'UserCR2_WarningBaloonForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TUserCR2_WarningBaloonForm }
 fm_ContentsForm: TvcmFormDescriptor = (rFormID : (rName : 'ContentsForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TContentsForm }
 fm_enFoldersTree: TvcmFormDescriptor = (rFormID : (rName : 'enFoldersTree'; rID : 0); rFactory : nil);
  {* Идентификатор формы TenFoldersTree }
 fm_enFoldersElementInfo: TvcmFormDescriptor = (rFormID : (rName : 'enFoldersElementInfo'; rID : 0); rFactory : nil);
  {* Идентификатор формы TenFoldersElementInfo }
 fm_DocumentWithFlashForm: TvcmFormDescriptor = (rFormID : (rName : 'DocumentWithFlashForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TDocumentWithFlashForm }
 fm_en_ConsultationMark: TvcmFormDescriptor = (rFormID : (rName : 'en_ConsultationMark'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_ConsultationMark }
 fm_en_MedicListSynchroView: TvcmFormDescriptor = (rFormID : (rName : 'en_MedicListSynchroView'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_MedicListSynchroView }
 fm_fcSynchroView: TvcmFormDescriptor = (rFormID : (rName : 'fcSynchroView'; rID : 0); rFactory : nil);
  {* Идентификатор формы TfcSynchroView }
 fm_ListAnalizeForm: TvcmFormDescriptor = (rFormID : (rName : 'ListAnalizeForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TListAnalizeForm }
 fm_en_MainMenuWithProfNews: TvcmFormDescriptor = (rFormID : (rName : 'en_MainMenuWithProfNews'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_MainMenuWithProfNews }

type
 TextFormDef = interface
  {* Текст документа }
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
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
