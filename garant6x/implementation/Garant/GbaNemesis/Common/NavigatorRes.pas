unit NavigatorRes;

interface

uses
  SysUtils,
  Classes,
  ImgList,
  Controls,

  vtPngImgList,

  BaseTypesUnit,
  DynamicTreeUnit
  ;

type
  TnsNavigatorRes = class(TDataModule)
    NavigatorItemsImageList: TvtPngImageList;
  end;

const
 cimgFolder                  = 0;
   {* - Псевдоэлемент - папка. }
 cimgRubricator              = 1;
   {* - Навигатор по классификатору.}
 cimgAttributeSearch         = 2;
   {* - Поиск по атрибутам.}
 cimgSituationSearch         = 3;
   {* - Поиск по ситуации.}
 cimgPublishSourceSearch     = 4;
   {* - Поиск по источнику опубликования.}
 cimgUpdate                  = 5;
   {* - Обновление.}
 cimgConfigurationList       = 6;
   {* - Список конфигураций.}
 cimgList                    = 7;
   {* - Список.}
 cimgComplectInfo            = 8;
   {* - Информация о комплекте.}
 cimgDocument                = 9;
   {* - Документ.}
 cimgLawNavigatorFolder      = 10;
   {* - Папка "Правовой навигатор".}
 cimgBusinessInfoFolder      = 11;
   {* - Папка "Справочная информация".}
 cimgSearchFolder            = 12;
   {* - Папка "Поиск".}
 cimgUpdateFolder            = 13;
   {* - Папка "Обновление".}
 cimgRecentlyDocumentsFolder = 14;
   {* - Папка "Последние открытые документы".}
 cimgExplanatoryDictionary   = 15;
   {* - Поиск толкования.}
 cimgUnknownElement          = 16;
   {* - неизвестный листьевой элемент.}
 cimgPrime                   = 17;
   {* - Папка "Прайм".}
 cimgLegislationReview       = 18;
   {* - Обзор законодательства.}
 cimgMyNewsLine              = 19;
   {* - Моя новостная лента.}
 cimgSearchWithLawSupport    = 20;
   {* - Поиск с правовой поддержкой. }
 cimgLawSupport              = 21;
   {* - Правовая поддержка. }
 cImgInpharmSearch           = 22;
   {* - Поиск лекарственного препарата }
 cImgInpharm                 = 23;
   {* - Блок Инфарм }
 cImgInpharmDrugs            = 24;
   {* - Список препаратов }
 cImgInpharmFirms            = 25;
   {* - Список фирм }
 cImgInpharmDiction          = 26;
   {* - Словарь мед.терминов }

function GetMainMenuImageIndex(const aNode     : INodeBase;
                               const aMenuItem : TNavigatorMenuItemType) : Integer;
  {* - возвращает идентификатор иконки по типу пункта меню. }

function nsNavigatorRes: TnsNavigatorRes;

implementation

uses
  Forms
  ;

var
 g_NavigatorRes: TnsNavigatorRes = nil;

function nsNavigatorRes: TnsNavigatorRes;
begin
 if (g_NavigatorRes = nil) then
  g_NavigatorRes := TnsNavigatorRes.Create(Application);
 Result := g_NavigatorRes;
end;

function GetMainMenuImageIndex(const aNode     : INodeBase;
                               const aMenuItem : TNavigatorMenuItemType) : Integer;
  {* - возвращает идентификатор иконки по типу пункта меню. }
begin
 case aMenuItem of
  // Навигатор по классификатору.
  NM_RUBRICATOR:
   Result := cimgRubricator;
  // Поиск по атрибутам.
  NM_ATTRIBUTE_SEARCH:
   Result := cimgAttributeSearch;
  // Поиск по ситуации.
  NM_SITUATION_SEARCH:
   Result := cimgSituationSearch;
  // Поиск по источнику опубликования.
  NM_PUBLISH_SOURCE_SEARCH:
   Result := cimgPublishSourceSearch;
  // Обновление.
  NM_UPDATE:
   Result := cimgUpdate;
  // Список конфигураций.
  NM_CONFIGURATION_LIST:
   Result := cimgConfigurationList;
  // Информация о комплекте.
  NM_COMPLECT_INFO:
   Result := cimgComplectInfo;
  // Документ
  NM_DOCUMENT:
   Result := cimgDocument;
  // Папка "Правовой навигатор"
  NM_LAW_NAVIGATOR_FOLDER:
   Result := cimgLawNavigatorFolder;
  // Папка "Справочная информация"
  NM_BUSINESS_INFO_FOLDER:
   Result := cimgBusinessInfoFolder;
  // Папка "Поиск"
  NM_SEARCH_FOLDER:
   Result := cimgSearchFolder;
  // Папка "Обновление"
  NM_UPDATE_FOLDER:
   Result := cimgUpdateFolder;
  // Папка "Последние открытые документы"
  NM_RECENTLY_DOCUMENTS_FOLDER:
   Result := cimgRecentlyDocumentsFolder;
  // Поиск толкования
  NM_EXPLANATORY_DICTIONARY:
   Result := cimgExplanatoryDictionary;
  //
  NM_PRIME_FOLDER:
   Result := cimgPrime;
  // Обзор законодательства
  NM_REVIEW:
   Result := cimgLegislationReview;
  // Моя новостная лента
  NM_NEWS_LINE:
   Result := cimgMyNewsLine;
  NM_SEARCH_WITH_LAW_SUPPORT:
   Result := cimgSearchWithLawSupport;
  NM_LAW_SUPPORT:
   Result := cimgLawSupport;
  NM_PHARM_SEARCH:
   Result := cImgInpharmSearch;
  NM_INPHARM:
   Result := cImgInpharm;
  NM_PHARM_LEK:
   Result := cImgInpharmDrugs;
  NM_PHARM_FIRMS:
   Result := cImgInpharmFirms;
  NM_PHARM_DICT:
   Result := cImgInpharmDiction;
  else
   // Папка:
   if aNode.HasChildren then
    Result := cimgFolder
   // Список:
   else
    Result := cimgList;
 end;
end;

{$R *.dfm}

end.
