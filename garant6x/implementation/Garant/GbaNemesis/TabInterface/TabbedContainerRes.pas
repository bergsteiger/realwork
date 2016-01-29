unit TabbedContainerRes;

interface

uses
  SysUtils,
  Classes,
  ImgList,
  vtPngImgList,
  nsTabbedInterfaceTypes;

type
  TTabbedContainerRes = class(TDataModule)
    ilTabImages: TvtNonFixedPngImageList;
  private
    function pm_GetIconIndex(aIconType: TnsTabIconType): Integer;
  public
    property IconIndex[IconType: TnsTabIconType]: Integer
      read pm_GetIconIndex;
  end;

  function nsTabbedContainerRes: TTabbedContainerRes;

implementation

{$R *.dfm}

uses
 Forms,
 vtPngImgListUtils;

const
  cTabIconMainIndex                    = 0;
  (* - главная иконка приложения *)

  cTabIconListIndex                    = 1;
  (* - список *)

  cTabIconDocumentNormalIndex          = 2;
  (* - документ *)

  cTabIconDocumentPreactiveIndex       = 3;
  (* - не вступившая в силу редакция документа *)

  cTabIconDocumentAbolishedIndex       = 4;
  (* - утратившая силу редакция документа *)

  cTabIconDocumentNewRedactionIndex    = 5;
  (* - редакция документа *)

  cTabIconAACIndex                     = 6;
  (* - ААК *)

  cTabIconDrugIndex                    = 7;
  (* - лекарственное средство *)

  cTabIconDrugSpecialIndex             = 8;

  cTabIconDrugAnnuledIndex             = 9;
  (* - ануллированные лекарственные срдества *)

  cTabIconMedicFirmIndex               = 10;
  (* - медицинские фирмы *)

  cTabIconMedicDictionaryIndex         = 11;
  (* - словарь инфарм *)

  cTabIconDictionaryIndex              = 12;
  (* - толковый словарь *)

  cTabIconAttributeSearchIndex         = 13;
  (* - поиск по реквизитам *)

  cTabIconSituationSearchIndex         = 14;
  (* - поиск по ситуации *)

  cTabIconPublishSourceSearchIndex     = 15;
  (* - поиск по источнику опубликования *)

  cTabIconLegislationReviewSearchIndex = 16;
  (* - обзор изменений законодательства Прайм *)

  cTabIconDrugSearchIndex              = 17;
  (* - поиск лекарственного средства *)

  cTabIconCompareEditionsIndex         = 18;
  (* - сравнение редакций *)

  cTabIconChangesBetweenEditionsIndex  = 19;
  (* - обзор измений документа *)

  cTabIconPrimeIndex                   = 20;
  (* - документ ленты Прайм *)

  cTabIconIpharmMainMenuIndex          = 21;
  (* - основное меню Инфарма *)

  cTabIconConsultationIndex            = 24;
  (* - консультация *)

  cTabIconComplectInfoIndex            = 23;
  (* - информация о комплекте *)

  cTabIconLawSupportOnlineIndex        = 24;
  (* - правовая поддержка онлайн *)

  cTabIconRubricatorIndex              = 25;
  (* - рубрикатор *)

  cTabIconBaseSearchIndex              = 26;
  (* - базовый поиск *)

  cTabIconPrintPreviewIndex            = 27;
  (* - Предварительный просмотр *)

  cTabIconNewsOnlineIndex              = 28;
  (* - Новости онлайн *)

  cIconTypesArr: array[TnsTabIconType] of Integer =
  (
   cTabIconMainIndex,                      //   titMain
   cTabIconListIndex,                      //   titList
   cTabIconDocumentNormalIndex,            //   titDocumentNormal
   cTabIconDocumentPreactiveIndex,         //   titDocumentPreactive
   cTabIconDocumentAbolishedIndex,         //   titDocumentAbolished
   cTabIconDocumentNewRedactionIndex,      //   titDocumentNewRedaction
   cTabIconAACIndex,                       //   titAAC
   cTabIconDrugIndex,                      //   titDrug
   cTabIconDrugSpecialIndex,               //   titDrugSpecial
   cTabIconDrugAnnuledIndex,               //   titDrugAnnuled
   cTabIconMedicFirmIndex,                 //   titMedicFirm
   cTabIconMedicDictionaryIndex,           //   titMedicDictionary
   cTabIconDictionaryIndex,                //   titDictionary
   cTabIconAttributeSearchIndex,           //   titAttributeSearch
   cTabIconPublishSourceSearchIndex,       //   titPublishSourceSearch
   cTabIconLegislationReviewSearchIndex,   //   titLegislationReviewSearch
   cTabIconDrugSearchIndex,                //   titDrugSearch
   cTabIconCompareEditionsIndex,           //   titCompareEditions
   cTabIconChangesBetweenEditionsIndex,    //   titChangesBetweenEditions
   cTabIconSituationSearchIndex,           //   titSituationSearch
   cTabIconPrimeIndex,                     //   titPrime
   cTabIconIpharmMainMenuIndex,            //   titInpharmMainMenu
   cTabIconConsultationIndex,              //   titConsultation
   cTabIconComplectInfoIndex,              //   titComplectInfo
   cTabIconLawSupportOnlineIndex,          //   titLawSupportOnline
   cTabIconRubricatorIndex,                //   titRubricator
   cTabIconBaseSearchIndex,                //   titBaseSearch
   cTabIconPrintPreviewIndex,              //   titPrintPreview
   cTabIconNewsOnlineIndex                 //   titNewsOnline
  );//cIconTypesArr

var
 g_nsTabbedContainerRes: TTabbedContainerRes;

function nsTabbedContainerRes: TTabbedContainerRes;
begin
 if (g_nsTabbedContainerRes = nil) then
  Application.CreateForm(TTabbedContainerRes, g_nsTabbedContainerRes);
 Result := g_nsTabbedContainerRes;
end;

{ TTabbedContainerRes }

function TTabbedContainerRes.pm_GetIconIndex(
  aIconType: TnsTabIconType): Integer;
begin
 Result := cIconTypesArr[aIconType];
end;

initialization
 AddImageListCreator(@nsTabbedContainerRes);

end.
