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
   {* - ������������� - �����. }
 cimgRubricator              = 1;
   {* - ��������� �� ��������������.}
 cimgAttributeSearch         = 2;
   {* - ����� �� ���������.}
 cimgSituationSearch         = 3;
   {* - ����� �� ��������.}
 cimgPublishSourceSearch     = 4;
   {* - ����� �� ��������� �������������.}
 cimgUpdate                  = 5;
   {* - ����������.}
 cimgConfigurationList       = 6;
   {* - ������ ������������.}
 cimgList                    = 7;
   {* - ������.}
 cimgComplectInfo            = 8;
   {* - ���������� � ���������.}
 cimgDocument                = 9;
   {* - ��������.}
 cimgLawNavigatorFolder      = 10;
   {* - ����� "�������� ���������".}
 cimgBusinessInfoFolder      = 11;
   {* - ����� "���������� ����������".}
 cimgSearchFolder            = 12;
   {* - ����� "�����".}
 cimgUpdateFolder            = 13;
   {* - ����� "����������".}
 cimgRecentlyDocumentsFolder = 14;
   {* - ����� "��������� �������� ���������".}
 cimgExplanatoryDictionary   = 15;
   {* - ����� ����������.}
 cimgUnknownElement          = 16;
   {* - ����������� ��������� �������.}
 cimgPrime                   = 17;
   {* - ����� "�����".}
 cimgLegislationReview       = 18;
   {* - ����� ����������������.}
 cimgMyNewsLine              = 19;
   {* - ��� ��������� �����.}
 cimgSearchWithLawSupport    = 20;
   {* - ����� � �������� ����������. }
 cimgLawSupport              = 21;
   {* - �������� ���������. }
 cImgInpharmSearch           = 22;
   {* - ����� �������������� ��������� }
 cImgInpharm                 = 23;
   {* - ���� ������ }
 cImgInpharmDrugs            = 24;
   {* - ������ ���������� }
 cImgInpharmFirms            = 25;
   {* - ������ ���� }
 cImgInpharmDiction          = 26;
   {* - ������� ���.�������� }

function GetMainMenuImageIndex(const aNode     : INodeBase;
                               const aMenuItem : TNavigatorMenuItemType) : Integer;
  {* - ���������� ������������� ������ �� ���� ������ ����. }

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
  {* - ���������� ������������� ������ �� ���� ������ ����. }
begin
 case aMenuItem of
  // ��������� �� ��������������.
  NM_RUBRICATOR:
   Result := cimgRubricator;
  // ����� �� ���������.
  NM_ATTRIBUTE_SEARCH:
   Result := cimgAttributeSearch;
  // ����� �� ��������.
  NM_SITUATION_SEARCH:
   Result := cimgSituationSearch;
  // ����� �� ��������� �������������.
  NM_PUBLISH_SOURCE_SEARCH:
   Result := cimgPublishSourceSearch;
  // ����������.
  NM_UPDATE:
   Result := cimgUpdate;
  // ������ ������������.
  NM_CONFIGURATION_LIST:
   Result := cimgConfigurationList;
  // ���������� � ���������.
  NM_COMPLECT_INFO:
   Result := cimgComplectInfo;
  // ��������
  NM_DOCUMENT:
   Result := cimgDocument;
  // ����� "�������� ���������"
  NM_LAW_NAVIGATOR_FOLDER:
   Result := cimgLawNavigatorFolder;
  // ����� "���������� ����������"
  NM_BUSINESS_INFO_FOLDER:
   Result := cimgBusinessInfoFolder;
  // ����� "�����"
  NM_SEARCH_FOLDER:
   Result := cimgSearchFolder;
  // ����� "����������"
  NM_UPDATE_FOLDER:
   Result := cimgUpdateFolder;
  // ����� "��������� �������� ���������"
  NM_RECENTLY_DOCUMENTS_FOLDER:
   Result := cimgRecentlyDocumentsFolder;
  // ����� ����������
  NM_EXPLANATORY_DICTIONARY:
   Result := cimgExplanatoryDictionary;
  //
  NM_PRIME_FOLDER:
   Result := cimgPrime;
  // ����� ����������������
  NM_REVIEW:
   Result := cimgLegislationReview;
  // ��� ��������� �����
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
   // �����:
   if aNode.HasChildren then
    Result := cimgFolder
   // ������:
   else
    Result := cimgList;
 end;
end;

{$R *.dfm}

end.
