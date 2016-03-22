unit DictionInterfaces;
 {* Интерфейсы для работы с толковым словарём }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\DictionInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "DictionInterfaces" MUID: (491D57C802CD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , l3TreeInterfaces
 , bsTypes
 , CommonDictionInterfaces
 , l3InternalInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
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
 , DictionInterfacesPrim
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
  {* Слушатель событий бизнес объекта формы список толкований }
  ['{A9A4196C-CD68-47BA-8DED-97CC7084AB53}']
  procedure UpdateLanguage(aLanguage: TbsLanguage);
   {* обновить язык списка толкований }
 end;//IbsDictionListener

 IdsDiction = interface(IdsCommonDiction)
  {* Список толкований }
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
  {* Данные толкового словаря }
  ['{9BE60C81-85BB-4DBB-AC9A-CA023E09BA3C}']
  function pm_GetLanguages: TbsLanguages;
  procedure pm_SetLanguages(aValue: TbsLanguages);
  function pm_GetrefTranslationCount: Integer;
  function pm_GetIsShowLiteratureList: Boolean;
  procedure pm_SetIsShowLiteratureList(aValue: Boolean);
  function pm_GetContextMap: InsLangToContextMap;
  procedure pm_SetContextMap(const aValue: InsLangToContextMap);
  function pm_GetrefTranslation(aIndex: Integer): IvcmFormDataSourceRef;
  property Languages: TbsLanguages
   read pm_GetLanguages
   write pm_SetLanguages;
  property refTranslationCount: Integer
   read pm_GetrefTranslationCount;
  property IsShowLiteratureList: Boolean
   read pm_GetIsShowLiteratureList
   write pm_SetIsShowLiteratureList;
  property ContextMap: InsLangToContextMap
   read pm_GetContextMap
   write pm_SetContextMap;
  property refTranslation[aIndex: Integer]: IvcmFormDataSourceRef
   read pm_GetrefTranslation;
 end;//IdDiction

 IdeDiction = interface(IdeCommonDiction)
  {* Данные для сборки Толковый словарь }
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
  {* Толковый словарь }
  ['{5F50593A-39D2-4EC7-9410-0A4FEE1DB991}']
  function pm_GetdsDiction: IdsDiction;
  function pm_GetTranslationForms: Integer;
  function pm_GetDefaultLanguage: TbsLanguage;
  function pm_GetdsTranslate(aLanguageId: Integer): IdsDictionDocument;
  function pm_GetContextMap: InsLangToContextMap;
  procedure OpenLiteratureList;
   {* открыть список литературы для толкового словаря }
  function IsShowLiteratureList: Boolean;
  property dsDiction: IdsDiction
   read pm_GetdsDiction;
  property TranslationForms: Integer
   read pm_GetTranslationForms;
   {* количество форм с переводом (по количеству возможных языков) }
  property DefaultLanguage: TbsLanguage
   read pm_GetDefaultLanguage;
   {* язык по умолчанию, используется для установки фиктивной закладки толкового словаря }
  property dsTranslate[aLanguageId: Integer]: IdsDictionDocument
   read pm_GetdsTranslate;
   {* получить бизнес объект для указанного языка }
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
