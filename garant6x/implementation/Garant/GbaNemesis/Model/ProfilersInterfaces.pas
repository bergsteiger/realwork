unit ProfilersInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Model"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Model/ProfilersInterfaces.pas"
// �����: 10.02.2009 16:17
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 ������� ����������� ���������� �������::LegalDomain::Model::ProfilersInterfaces
//
// ���������� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(vcmUseProfilers)}
type
 InsProfiler = interface(IUnknown)
  {* ������� ��������� }
   ['{1D763660-D3D4-4061-8A81-9DC23C13C651}']
   procedure Start;
     {* ������ �����, ���������� ����� ��������� ������ }
   procedure Finish;
     {* ��������� ��������� }
 end;//InsProfiler

 IprDocument = interface(InsProfiler)
  {* ������������ ��������� ��� ������� ������� �������� ��������� }
   ['{B2515E49-A19D-4049-9919-56F7EC28A7EE}']
   procedure FormSetCreated;
     {* ������ ������� }
   procedure DocumentReceived;
     {* �������� ������� � �������� }
   procedure DocumentPainted;
     {* �������� ��������� }
   procedure ContentsTreeOpened;
     {* ������� ��������� ��������� }
 end;//IprDocument

 IprQueryCard = interface(InsProfiler)
  {* ������������ ��� ������� �������� �������� �������� }
   ['{789A98FD-0CF4-4201-A45E-C561BB951454}']
 end;//IprQueryCard

 IprListAfterSearch = interface(InsProfiler)
  {* �������� ������ ����� ������ }
   ['{C6674B5C-2E96-4BCC-B125-0B65DE2E3258}']
 end;//IprListAfterSearch

 IprMainMenu = interface(InsProfiler)
  {* �������� ��������� ���� }
   ['{39745C2C-BFC7-49B0-8354-6BF3FA66C8E3}']
 end;//IprMainMenu

 InsProfilersManager = interface(IUnknown)
  {* �������� ����������� }
   ['{8E294A8A-F992-453E-BEFE-15A04CE9950C}']
   function pm_GetDocument: IprDocument;
   function pm_GetQueryCard: IprQueryCard;
   function pm_GetListAfterSearch: IprListAfterSearch;
   function pm_GetMainMenu: IprMainMenu;
   property Document: IprDocument
     read pm_GetDocument;
     {* ��������� ��������� }
   property QueryCard: IprQueryCard
     read pm_GetQueryCard;
     {* ��������� �������� ������� }
   property ListAfterSearch: IprListAfterSearch
     read pm_GetListAfterSearch;
     {* �������� ��������� ����� ������ }
   property MainMenu: IprMainMenu
     read pm_GetMainMenu;
     {* �������� ��������� ���� }
 end;//InsProfilersManager
{$IfEnd} //vcmUseProfilers

implementation

end.