unit PrimBaseSearchInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Search"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Search/PrimBaseSearchInterfaces.pas"
// �����: 11.03.2011 14:19
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Common For Shell And Monitoring::Search::Search::PrimBaseSearchInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
type
 InsBaseSearchResultProcessor = interface(IUnknown)
   ['{C3264FA1-C168-4D5E-94B7-3D7DE897A780}']
   procedure SearchResultEmpty(TryFullList: Boolean);
   procedure SearchResultExists;
   procedure AnotherSearchSuccessed;
   procedure AnotherSearchCancelled;
 end;//InsBaseSearchResultProcessor
{$IfEnd} //not Admin

implementation

end.