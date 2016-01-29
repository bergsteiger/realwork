unit MainMenuUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/MainMenuUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::MainMenu
//
// �������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  DynamicTreeUnit
  ;

type
 TSectionType = (
  {* ��� ������ �� }
   ST_FINANCE // ������ � �������
 , ST_HR // ������ ��� ����������
 , ST_LEGAL // ������ ��� �������
 , ST_BUDGET_ORGS // ��������� �����������
 , ST_LAW_FOR_ALL // ����� ��� ����
 , ST_BUSINESS_REFERENCES // ������-�������
 , ST_CHANGES_IN_LEGISLATION // ��������� � ����������������
 );//TSectionType

 ISectionItem = interface(IUnknown)
  {* ������� ������� �� }
   ['{257ACC4A-9B2A-4AD1-B238-0CDCE6A5406E}']
   function GetCaption: IString; stdcall;
   procedure Open(out aRet {: IUnknown}); stdcall;
     {* �������� �������� �������� (����� ���� IQuery, IDocument, INodeBase, IString) }
   property caption: IString
     read GetCaption;
     {* ��� }
 end;//ISectionItem

 ISectionItemList = array of ISectionItem;

 ISection = interface(IUnknown)
   ['{BBB2D3C6-226C-4A9F-AAC6-32775E30B7C7}']
   function GetCaption: IString; stdcall;
   procedure GetItems(out aRet {: ISectionItemList}); stdcall;
     {* �������� �������� ������� �� }
   property caption: IString
     read GetCaption;
     {* ��� }
 end;//ISection

 IMainMenu = interface(IUnknown)
  {* �������� ���� }
   ['{7EAB7EE0-39FB-42FD-BE38-AF667AE0466E}']
   procedure GetBaseSearchPanes(out aRet {: INodeBase}); stdcall;
     {* �������� ������ ������� ������� ������ }
   procedure GetSection(aType: TSectionType; out aRet {: ISection}); stdcall;
     {* �������� ������ ������ �� �� ���� }
 end;//IMainMenu

implementation

end.