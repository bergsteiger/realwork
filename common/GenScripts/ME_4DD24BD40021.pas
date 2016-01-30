unit MainMenuUnit;
 {* �������� ���� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\MainMenuUnit.pas"
// ���������: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , DynamicTreeUnit
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
  function Get_caption: IString;
  function open: IUnknown;
   {* �������� �������� �������� (����� ���� IQuery, IDocument, INodeBase, IString) }
  property caption: IString
   read Get_caption;
   {* ��� }
 end;//ISectionItem

 ISectionItemList = array of ISectionItem;

 ISection = interface
  ['{BBB2D3C6-226C-4A9F-AAC6-32775E30B7C7}']
  function Get_caption: IString;
  class function make: BadFactoryType;
  function get_items: ISectionItemList;
   {* �������� �������� ������� �� }
  property caption: IString
   read Get_caption;
   {* ��� }
 end;//ISection

 IMainMenu = interface
  {* �������� ���� }
  ['{7EAB7EE0-39FB-42FD-BE38-AF667AE0466E}']
  function get_base_search_panes: INodeBase;
   {* �������� ������ ������� ������� ������ }
  function get_section(type: TSectionType): ISection;
   {* �������� ������ ������ �� �� ���� }
 end;//IMainMenu

class function make(section_item): BadFactoryType;
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make(section_item): BadFactoryType;
var
 l_Inst : ISectionItem;
begin
 l_Inst := Create(section_item);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IMainMenu;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
