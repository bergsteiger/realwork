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
  (* - ������� ������ ���������� *)

  cTabIconListIndex                    = 1;
  (* - ������ *)

  cTabIconDocumentNormalIndex          = 2;
  (* - �������� *)

  cTabIconDocumentPreactiveIndex       = 3;
  (* - �� ���������� � ���� �������� ��������� *)

  cTabIconDocumentAbolishedIndex       = 4;
  (* - ���������� ���� �������� ��������� *)

  cTabIconDocumentNewRedactionIndex    = 5;
  (* - �������� ��������� *)

  cTabIconAACIndex                     = 6;
  (* - ��� *)

  cTabIconDrugIndex                    = 7;
  (* - ������������� �������� *)

  cTabIconDrugSpecialIndex             = 8;

  cTabIconDrugAnnuledIndex             = 9;
  (* - �������������� ������������� �������� *)

  cTabIconMedicFirmIndex               = 10;
  (* - ����������� ����� *)

  cTabIconMedicDictionaryIndex         = 11;
  (* - ������� ������ *)

  cTabIconDictionaryIndex              = 12;
  (* - �������� ������� *)

  cTabIconAttributeSearchIndex         = 13;
  (* - ����� �� ���������� *)

  cTabIconSituationSearchIndex         = 14;
  (* - ����� �� �������� *)

  cTabIconPublishSourceSearchIndex     = 15;
  (* - ����� �� ��������� ������������� *)

  cTabIconLegislationReviewSearchIndex = 16;
  (* - ����� ��������� ���������������� ����� *)

  cTabIconDrugSearchIndex              = 17;
  (* - ����� �������������� �������� *)

  cTabIconCompareEditionsIndex         = 18;
  (* - ��������� �������� *)

  cTabIconChangesBetweenEditionsIndex  = 19;
  (* - ����� ������� ��������� *)

  cTabIconPrimeIndex                   = 20;
  (* - �������� ����� ����� *)

  cTabIconIpharmMainMenuIndex          = 21;
  (* - �������� ���� ������� *)

  cTabIconConsultationIndex            = 24;
  (* - ������������ *)

  cTabIconComplectInfoIndex            = 23;
  (* - ���������� � ��������� *)

  cTabIconLawSupportOnlineIndex        = 24;
  (* - �������� ��������� ������ *)

  cTabIconRubricatorIndex              = 25;
  (* - ���������� *)

  cTabIconBaseSearchIndex              = 26;
  (* - ������� ����� *)

  cTabIconPrintPreviewIndex            = 27;
  (* - ��������������� �������� *)

  cTabIconNewsOnlineIndex              = 28;
  (* - ������� ������ *)

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
