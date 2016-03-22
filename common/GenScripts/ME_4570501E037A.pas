unit FoldersUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\FoldersUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Folders" MUID: (4570501E037A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTreeSupportUnit
 , UnderControlUnit
 , BaseTypesUnit
 , IOUnit
 , ContextSearchSupportUnit
;

const
 {* �������� flags ���  �������� FoldersNode. }
 NF_CONTROLLED: Cardinal = 1;
  {* ����������� ������� ����� �� ��������. }
 NF_SHARED: Cardinal = 2;
  {* �������� �� ���� ���� (���� �����). }
 NF_EXTERNAL: Cardinal = 4;
  {* ������� ����. }
 NF_IN_SHARED: Cardinal = 8;
  {* ���������� �� ���� ���� � ������� �����. }
 NF_HAS_SHARED: Cardinal = 16;
  {* ���� �� � ���� ���� (���� �����) �������� �����. }
 NF_COMMENTS: Cardinal = 32;
  {* ����� ��� ����������� }
 NF_IN_COMMENTS: Cardinal = 64;
  {* ������� ������ ����� ��� ����������� }
 NF_COMMON: Cardinal = 128;
  {* ����� ����� }
 NF_USER: Cardinal = 256;
  {* ����� ������ ����� ����� (�� ������ �������������) }
 NF_MY_DOCUMENTS: Cardinal = 512;
  {* ����� ��� ��������� }
 NF_MY_CONSULTATIONS: Cardinal = 1024;
  {* ����� ��� ������������ }
 NF_FOLDER_SENT: Cardinal = 2048;
  {* ����� ��� ������������/������� � ��������� }
 NF_FOLDER_RECEIVED: Cardinal = 4096;
  {* ����� ��� ������������/������ }
 NF_CONSULTATION_SENT: Cardinal = 8192;
  {* ������������ �� �������� CS_SENT }
 NF_PAYMENT_REQUEST: Cardinal = 16384;
  {* ������������ �� �������� CS_PAYMAND_REQUEST (��������� ������) }
 NF_ANSWER_RECEIVED: Cardinal = 32768;
  {* ������������ �� �������� CS_ANSWER_RECEIVED (������� �����) }
 NF_ANSWER_READ: Cardinal = 65536;
  {* ������������ �� �������� CS_ANSWER_READ (����� ��������) }
 NF_ESTIMATION_SENT: Cardinal = 131072;
  {* ������������ �� �������� CS_ESTIMATION_SENT (���������� ������) }
 NF_FOLDER_DRAFTS: Cardinal = 262144;
  {* ����� ��� ������������/��������� ������� }
 NF_FOLDER_PAYMENT_REFUSAL: Cardinal = 524288;
  {* ����� ��� ������������/���������������� }
 NF_DRAFTS: Cardinal = 1048576;
  {* ������������ �� �������� CS_DRAFTS (���������, �� ��� �� ������������ ������������) }
 NF_PAYMENT_REFUSAL: Cardinal = 2097152;
  {* ������������ �� �������� CS_PAYMENT_REFUSAL (������������ � ���������������� �������) }
 NF_PAYMENT_CONFIRM: Cardinal = 4194304;
  {* ������������ �� �������� CS_PAYMENT_CONFIRM (������������ � �������������� �������) }
 NF_VALIDATION_FAILED: Cardinal = 8388608;
  {* ������������ �� �������� CS_VALIDATION_FAILED (������������ �� ����������, ��� ��� ���� ��������������) }

type
 TFolderId = Cardinal;
  {* ��� �������� ���� }

 IFolders = interface;

 IFoldersNode = interface(INode)
  {* ������������������ ���� ��� �����. ������ �������������� ������� "���� ��������".
�������� Caption � Hint �������������� �� Node ����������� ����� ��� �������� � ���������������� ����������� ��������������.
� �������� BaseEntity ���� ����� ��������� �������� �� ��������, ������, ������ ��� ���������� ���� (Folder). ����� � ����� ���� ��������� (����� ����) ���������� ��� �������� � ����, ������ ����� ����� ��������� ���������� (�.�. ��������� ����� ���� �� ������ �� ����� ��������� ����� �������� ������������ � ���). }
  ['{6B1E4393-7BE4-4201-A8F9-D3C817C440B5}']
  function Get_id: TFolderId;
  function Get_creation_date: TDate;
  procedure save_consultation_to_xml(xml_file_path: PAnsiChar);
   {* ��������� ���������� � ��������, �������������� �������� ����� ������������ � xml. }
  procedure save_to_xml(xml_file_path: PAnsiChar); { can raise AccessDenied, InvalidEntityType }
  procedure load_from_xml(xml_file_path: PAnsiChar); { can raise AccessDenied, InvalidEntityType }
   {* ��������� ���������� �� xml � ����� (������, �������������). }
  function save_to_integration_xml: IString; { can raise InvalidEntityType }
   {* ��������� ���� ��� ���������� ���������� }
  function can_save_consultation_to_xml: Boolean;
   {* ��������� ����� �� ������������ ���� ��������� � xml. }
  function can_save_to_xml: Boolean;
   {* ��������� ����� �� ���� ���� ��������� � xml. }
  function can_load_from_xml: Boolean;
   {* ��������� ����� �� � ���� ��������� ������ �� xml. }
  function can_save_to_integration_xml: Boolean;
   {* ����� �� ���� ���� ��������� ��� ���������� ���������� }
  procedure get_pid;
  property id: TFolderId
   read Get_id;
   {* ������� ���� }
  property creation_date: TDate
   read Get_creation_date;
   {* ���� �������� }
 end;//IFoldersNode

 IFolder = interface;

 IFolders = interface(IBaseCatalog)
  {* ��������� (��������) �������������� ������ � ������� �����. ������ �������� ��� ����� (Folder). }
  ['{085870DB-A1B6-48E7-ADDD-3C9F3911FEF5}']
  function create_folder: IFolder;
   {* ������� �����, ���������� ����� ��������� ��������� BaseEntity ���� Folder. }
  function find_folder_node(id: TFolderId
   {* ������������� ���� �����. }): IFoldersNode;
   {* ����� ���� ����� �� ��� ��������������. ���� �� ������ �� CanNotFindData. }
 end;//IFolders

 TNotifyStatus = (
  {* ������ ��������� �����. }
  NS_NODE
   {* �������� ��������� �����. �������� ��� ��������/��������� ���� �� �������� �����. }
  , NS_CONTENT
   {* �������� ���������� �����, �������� ��� �����, �����������, ����, � �.�. }
 );//TNotifyStatus

 IDoneNotifier = interface
  ['{B9089580-C0F0-43C8-B449-B2AA3A0D4FFF}']
  function done: Boolean;
 end;//IDoneNotifier

 IFolder = interface(IEntityBase)
  {* ���������� BaseEntity ����������� ������� ������� ����� �����. }
  ['{4B736A91-FDC7-4F00-B445-9C91CE120AB9}']
  function Get_shared: Boolean;
  procedure Set_shared(aValue: Boolean);
  function Get_external: Boolean;
  function can_share: Boolean;
   {* ����� �� ��������� ����� }
  function As_INamedElement: INamedElement;
   {* ����� ���������� ������ ���������� � INamedElement }
  property shared: Boolean
   read Get_shared
   write Set_shared;
   {* ��� ������� ������. ������� ���� ��� ����� �������� �������������, �.� ������� ������ �������������.
����. ������� ����� ����� �������� ��������������.
��� ������� �������� ������ ������� � ������� ����� ������������ ���������� ConstantModify. }
  property external: Boolean
   read Get_external;
   {* ��� ������� ������. 
������� ���� ��� ����� �������� ������� (�.�. �� ����������� � ������������� ������� ������������). }
 end;//IFolder

 TFoldersItemType = (
  {* �������� object_type ���  �������� FolderNode. }
  FIT_BOOKMARK
   {* ��������� Bookamark }
  , FIT_LIST
   {* ��������� List }
  , FIT_QUERY
   {* ��������� Query }
  , FIT_FOLDER
   {* ������������ ������� (�����) }
  , FIT_CONSULTATION
   {* ������������ }
  , FIT_PHARM_LIST
   {* ������ ���. ���������� }
  , FIT_PHARM_BOOKMARK
   {* �������� �� ���. �������� }
  , FIT_OLD_HISTORY
   {* ������ �� ������ ������ ������ }
 );//TFoldersItemType

 TNotifyData = record
  {* ������ ����������� �� ��������� �����. }
  status: TNotifyStatus;
   {* ������ ���������. }
  done_notifier: IDoneNotifier;
  folder: IFoldersNode;
 end;//TNotifyData

 IExternalFoldersChangeNotifier = interface
  {* ��������� ����������� ��������� ��������� �����. }
  ['{9AFA9214-42F7-439F-97DB-EB7827289CE0}']
  procedure fire(const data: TNotifyData
   {* ������ �����������. });
   {* ��������� ��������� �����. ��� ���� ���������� ���������� ������ ���������������� ���������� �����, �������� ����������� ��������� �������� �����. }
 end;//IExternalFoldersChangeNotifier

class function make(const content;
 var folders: IFolders): BadFactoryType;
class function make: BadFactoryType;
class function make(const folder_content;
 var folders_node: IFoldersNode): INamedElement;

implementation

uses
 l3ImplUses
;

class function make(const content;
 var folders: IFolders): BadFactoryType;
var
 l_Inst : IFoldersNode;
begin
 l_Inst := Create(content, folders);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IFolders;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const folder_content;
 var folders_node: IFoldersNode): INamedElement;
var
 l_Inst : IFolder;
begin
 l_Inst := Create(folder_content, folders_node);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
