unit MainMenuUnit;
 {* �������� ���� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\MainMenuUnit.pas"
// ���������: "Interfaces"
// ������� ������: "MainMenu" MUID: (4DD24BD40021)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DynamicTreeUnit
 , BannerUnit
;

type
 TSectionType = (
  {* ��� ������ �� }
  ST_FINANCE
   {* ������ � ������� }
  , ST_HR
   {* ������ ��� ���������� }
  , ST_LEGAL
   {* ������ ��� ������� }
  , ST_BUDGET_ORGS
   {* ��������� ����������� }
  , ST_GOS_ZAKUPKI
   {* ���������� }
  , ST_LAW_FOR_ALL
   {* ����� ��� ���� }
  , ST_BUSINESS_REFERENCES
   {* ������-������� }
  , ST_CHANGES_IN_LEGISLATION
   {* ��������� � ���������������� }
 );//TSectionType

 ISectionItem = interface
  {* ������� ������� �� }
  ['{257ACC4A-9B2A-4AD1-B238-0CDCE6A5406E}']
  procedure GetCaption; stdcall;
  procedure Open(out aRet
   {* IUnknown }); stdcall;
   {* �������� �������� �������� (����� ���� IQuery, IDocument, INodeBase, IString, IBookmark) }
  property Caption: 
   read GetCaption;
   {* ��� }
 end;//ISectionItem

 ISectionItemList = array of ISectionItem;

 ISection = interface
  ['{BBB2D3C6-226C-4A9F-AAC6-32775E30B7C7}']
  procedure GetCaption; stdcall;
  procedure GetItems(out aRet
   {* ISectionItemList }); stdcall;
   {* �������� �������� ������� �� }
  property Caption: 
   read GetCaption;
   {* ��� }
 end;//ISection

 IMainMenuSection = interface
  ['{9B596AAB-BF7B-41A0-978D-3FAD93DC180C}']
  procedure GetCaption; stdcall;
  procedure GetItems(out aRet
   {* ISectionItemList }); stdcall;
   {* �������� �������� ������� �� }
  function GetNewsSectionIndex: Integer; stdcall;
   {* �������� ��� ����. ������ ������ � ��������� ������ }
  procedure GetBanner(out aRet
   {* IBanner }); stdcall;
  property Caption: 
   read GetCaption;
   {* ��� }
 end;//IMainMenuSection

 IMainMenuSectionList = array of IMainMenuSection;

 IMainMenu = interface
  {* �������� ���� }
  ['{7EAB7EE0-39FB-42FD-BE38-AF667AE0466E}']
  procedure GetBaseSearchPanes(out aRet
   {* INodeBase }); stdcall;
   {* �������� ������ ������� ������� ������ }
  procedure GetSection(type: TSectionType;
   out aRet
   {* ISection }); stdcall;
   {* �������� ������ ������ �� �� ���� }
  procedure GetProfessionSectionList(out aRet
   {* IMainMenuSectionList }); stdcall;
   {* ������ ������ ����. ���� }
  procedure GetNewsSectionList(out aRet
   {* IMainMenuSectionList }); stdcall;
   {* ������ ��������� ������ �� }
  procedure GetBusinessReferenceSection(out aRet
   {* IMainMenuSection }); stdcall;
   {* ������ ������-������� }
  procedure GetChangesInLegislationSection(out aRet
   {* IMainMenuSection }); stdcall;
   {* ������ ��������� �  ���������������� }
 end;//IMainMenu

implementation

uses
 l3ImplUses
;

end.
