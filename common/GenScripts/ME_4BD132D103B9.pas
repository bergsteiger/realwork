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
  function revision_check_enabled: Boolean;
   {* ��������� �� ������ �������� ������� ���������� (��� �������������� ������) }
  function get_url_for_document(doc_id: Cardinal;
   para_id: Cardinal): IString;
   {* �������� URL ��� ��������� ��������� }
  function is_internet_agent_enabled: Boolean;
   {* �������� �� ��������-�����. }
  function get_url_for_internet_version: IString;
   {* �������� URL ��� �������� ������ }
  function show_warning: Boolean;
   {* ����� �� ���������� ������ �� ���������� ������ �������� }
 end;//IInternetSupport

 IDecisionsArchiveSupport = interface
  {* ��������� ������� � ������� �������� ������� }
  ['{CD81011E-549D-406A-964C-9FE291552EB4}']
  function get_archive_url: IString;
   {* �������� ������ ��� �������� �� ����� �������� ������� }
  function archive_available: Boolean;
   {* ����� �������� ������� �������� }
 end;//IDecisionsArchiveSupport

class function make: BadFactoryType;
 {* ������� }
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
 {* ������� }
var
 l_Inst : IInternetSupport;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IDecisionsArchiveSupport;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
