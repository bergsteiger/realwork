unit DictionInterfaces;
 {* ���������� ��� ������ � �������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\DictionInterfaces.pas"
// ���������: "ControllerInterfaces"
// ������� ������: "DictionInterfaces" MUID: (491D57C802CD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3TreeInterfaces
 , bsTypes
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , DocumentAndListInterfaces
 , CommonDictionInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , QueryCardInterfaces
 , DictionInterfacesPrim
 , l3InternalInterfaces
 , l3Interfaces
 , DynamicTreeUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Types
 , DocumentInterfaces
 , DocumentUnit
 , bsTypesNew
 , DynamicDocListUnit
 , PrimPrimListInterfaces
 , nsTypes
 , AdapterFacade
;

type
 InsLangToContextMap = interface
  ['{E8C780B1-C226-4065-9287-D4CDC58C6F29}']
  function pm_GetByLang(aLang: TbsLanguage): InscContextFilterState;
  procedure pm_SetByLang(aLang: TbsLanguage;
   const aValue: InscContextFilterState);
  procedure Subscribe(const aNotifySource: Il3ContextFilterNotifySource);
  procedure Unsubscribe(const aNotifySource: Il3ContextFilterNotifySource);
  property ByLang[aLang: TbsLanguage]: InscContextFilterState
   read pm_GetByLang
   write pm_SetByLang;
 end;//InsLangToContextMap

 IbsDictionListener = interface(IbsCommonDictionListener)
  {* ��������� ������� ������ ������� ����� ������ ���������� }
  ['{A9A4196C-CD68-47BA-8DED-97CC7084AB53}']
  procedure UpdateLanguage(aLanguage: TbsLanguage);
   {* �������� ���� ������ ���������� }
 end;//IbsDictionListener

 IdsDiction = interface(IdsCommonDiction)
  {* ������ ���������� }
  ['{D97C5B61-097A-4C19-95EF-1C5820AD89EB}']
  function pm_GetLanguage: TbsLanguage;
  procedure pm_SetLanguage(aValue: TbsLanguage);
  function pm_GetContextMap: InsLangToContextMap;
  procedure pm_SetContextMap(const aValue: InsLangToContextMap);
  property Language: TbsLanguage
   read pm_GetLanguage
   write pm_SetLanguage;
  property ContextMap: InsLangToContextMap
   read pm_GetContextMap
   write pm_SetContextMap;
 end;//IdsDiction

 IdDiction = interface(IdCommonDiction)
  {* ������ ��������� ������� }
  ['{9BE60C81-85BB-4DBB-AC9A-CA023E09BA3C}']
  function pm_GetLanguages: TbsLanguages;
  procedure pm_SetLanguages(aValue: TbsLanguages);
  function pm_GetRefTranslationCount: Integer;
  function pm_GetIsShowLiteratureList: Boolean;
  procedure pm_SetIsShowLiteratureList(aValue: Boolean);
  function pm_GetContextMap: InsLangToContextMap;
  procedure pm_SetContextMap(const aValue: InsLangToContextMap);
  function pm_GetCurrentLanguage: TbsLanguage;
  procedure pm_SetCurrentLanguage(aValue: TbsLanguage);
  function pm_GetRefTranslation(aIndex: Integer): IvcmFormDataSourceRef;
  property Languages: TbsLanguages
   read pm_GetLanguages
   write pm_SetLanguages;
  property refTranslationCount: Integer
   read pm_GetRefTranslationCount;
  property IsShowLiteratureList: Boolean
   read pm_GetIsShowLiteratureList
   write pm_SetIsShowLiteratureList;
  property ContextMap: InsLangToContextMap
   read pm_GetContextMap
   write pm_SetContextMap;
  property CurrentLanguage: TbsLanguage
   read pm_GetCurrentLanguage
   write pm_SetCurrentLanguage;
  property refTranslation[aIndex: Integer]: IvcmFormDataSourceRef
   read pm_GetRefTranslation;
 end;//IdDiction

 IdeDiction = interface(IdeCommonDiction)
  {* ������ ��� ������ �������� ������� }
  ['{A16C999F-97F3-416A-A277-572CDB3E8896}']
  function pm_GetDictLanguage: TbsLanguage;
  procedure pm_SetDictLanguage(aValue: TbsLanguage);
  function pm_GetContextMap: InsLangToContextMap;
  procedure pm_SetContextMap(const aValue: InsLangToContextMap);
  property DictLanguage: TbsLanguage
   read pm_GetDictLanguage
   write pm_SetDictLanguage;
  property ContextMap: InsLangToContextMap
   read pm_GetContextMap
   write pm_SetContextMap;
 end;//IdeDiction

 IsdsDiction = interface(IsdsCommonDiction)
  {* �������� ������� }
  ['{5F50593A-39D2-4EC7-9410-0A4FEE1DB991}']
  function pm_GetDsDiction: IdsDiction;
  function pm_GetTranslationForms: Integer;
  function pm_GetDefaultLanguage: TbsLanguage;
  function pm_GetDsTranslate(aLanguageId: Integer): IdsDictionDocument;
  function pm_GetContextMap: InsLangToContextMap;
  procedure OpenLiteratureList;
   {* ������� ������ ���������� ��� ��������� ������� }
  function IsShowLiteratureList: Boolean;
  property dsDiction: IdsDiction
   read pm_GetDsDiction;
  property TranslationForms: Integer
   read pm_GetTranslationForms;
   {* ���������� ���� � ��������� (�� ���������� ��������� ������) }
  property DefaultLanguage: TbsLanguage
   read pm_GetDefaultLanguage;
   {* ���� �� ���������, ������������ ��� ��������� ��������� �������� ��������� ������� }
  property dsTranslate[aLanguageId: Integer]: IdsDictionDocument
   read pm_GetDsTranslate;
   {* �������� ������ ������ ��� ���������� ����� }
  property ContextMap: InsLangToContextMap
   read pm_GetContextMap;
 end;//IsdsDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
