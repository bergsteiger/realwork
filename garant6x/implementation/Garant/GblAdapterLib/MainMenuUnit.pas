unit MainMenuUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/MainMenuUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::MainMenu
//
// �������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	IOUnit
	, DynamicTreeUnit
	//#UC START# *4423F94903C8_4DD24BD40021_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_4DD24BD40021_UNIT_FOR_Stream*
	;

type

ISectionItem = interface;
{ - ��������������� �������� ISectionItem. }

ISectionItemList = interface;
{ - ��������������� �������� ISectionItemList. }

ISection = interface;
{ - ��������������� �������� ISection. }

IMainMenu = interface;
{ - ��������������� �������� IMainMenu. }


// ��� ������ ��
PSectionType = ^TSectionType;
TSectionType = (
	ST_FINANCE // ������ � �������
	, ST_HR // ������ ��� ����������
	, ST_LEGAL // ������ ��� �������
	, ST_BUDGET_ORGS // ��������� �����������
	, ST_GOS_ZAKUPKI // ����������
	, ST_LAW_FOR_ALL // ����� ��� ����
	, ST_BUSINESS_REFERENCES // ������-�������
	, ST_CHANGES_IN_LEGISLATION // ��������� � ����������������
);

// ������� ������� ��
ISectionItem = interface (IInterface) ['{257ACC4A-9B2A-4AD1-B238-0CDCE6A5406E}']
	function DontUseMe: Pointer;
	// ���
	procedure GetCaption (out aRet {: IString}); stdcall;

	// �������� �������� �������� (����� ���� IQuery, IDocument, INodeBase, IString)
	procedure Open (
		out aRet {: IUnknown}
	); stdcall;
end;

ISectionItemList = interface(IInterface)
['{F4314383-3A43-4E2F-908F-257AE0A67C62}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: ISectionItem); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: ISectionItem); stdcall;
      {-}
  // public methods
    function  Add(const anItem: ISectionItem): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: ISectionItem); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//ISectionItemList

ISection = interface (IInterface) ['{BBB2D3C6-226C-4A9F-AAC6-32775E30B7C7}']
	function DontUseMe: Pointer;
	// ���
	procedure GetCaption (out aRet {: IString}); stdcall;

	// �������� �������� ������� ��
	procedure GetItems (
		out aRet {: ISectionItemList}
	); stdcall;
end;

// �������� ����
IMainMenu = interface (IInterface) ['{7EAB7EE0-39FB-42FD-BE38-AF667AE0466E}']
	function DontUseMe: Pointer;
	// �������� ������ ������� ������� ������
	procedure GetBaseSearchPanes (
		out aRet {: INodeBase}
	); stdcall;

	// �������� ������ ������ �� �� ����
	procedure GetSection (
		aType: TSectionType;
		out aRet {: ISection}
	); stdcall;
end;

implementation
end.