unit InternetSupportUnit;
 {* �����������, ��������� ����� �������� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\InternetSupportUnit.pas"
// ���������: "Interfaces"
// ������� ������: "InternetSupport" MUID: (4BD132D103B9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
;

type
 IInternetSupport = interface
  {* ��������� ������ ������������� ����� internet }
  ['{7DF56131-CBD6-47F5-B8B1-495409AFE6E4}']
  function RevisionCheckEnabled: ByteBool; stdcall;
   {* ��������� �� ������ �������� ������� ���������� (��� �������������� ������) }
  function GetUrlForDocument(doc_id: Cardinal;
   para_id: Cardinal): IString; stdcall;
   {* �������� URL ��� ��������� ��������� }
  function IsInternetAgentEnabled: ByteBool; stdcall;
   {* �������� �� ��������-�����. }
  function GetUrlForInternetVersion: IString; stdcall;
   {* �������� URL ��� �������� ������ }
  function ShowWarning: ByteBool; stdcall;
   {* ����� �� ���������� ������ �� ���������� ������ �������� }
 end;//IInternetSupport

 IDecisionsArchiveSupport = interface
  {* ��������� ������� � ������� �������� ������� }
  ['{CD81011E-549D-406A-964C-9FE291552EB4}']
  function GetArchiveUrl: IString; stdcall;
   {* �������� ������ ��� �������� �� ����� �������� ������� }
  function ArchiveAvailable: ByteBool; stdcall;
   {* ����� �������� ������� �������� }
  function SearchServerAvailable: ByteBool; stdcall;
   {* �������� ����������� ������� ������ � ������� }
  function GetSearchServerUrl(const query: IString): IString; stdcall;
 end;//IDecisionsArchiveSupport

implementation

uses
 l3ImplUses
;

end.
