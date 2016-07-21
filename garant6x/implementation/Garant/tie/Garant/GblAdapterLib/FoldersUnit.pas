unit FoldersUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\FoldersUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Folders" MUID: (4570501E037A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , BaseTreeSupportUnit
 , FiltersUnit
 , UnderControlUnit
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
  function GetId: TFolderId; stdcall;
  procedure GetCreationDate; stdcall;
  procedure SaveConsultationToXml(xml_file_path: PAnsiChar); stdcall;
   {* ��������� ���������� � ��������, �������������� �������� ����� ������������ � xml. }
  procedure SaveToXml(xml_file_path: PAnsiChar); stdcall; { can raise AccessDenied, InvalidEntityType }
  procedure LoadFromXml(xml_file_path: PAnsiChar); stdcall; { can raise AccessDenied, InvalidEntityType }
   {* ��������� ���������� �� xml � ����� (������, �������������). }
  procedure SaveToIntegrationXml(out aRet
   {* IString }); stdcall; { can raise InvalidEntityType }
   {* ��������� ���� ��� ���������� ���������� }
  function CanSaveConsultationToXml: ByteBool; stdcall;
   {* ��������� ����� �� ������������ ���� ��������� � xml. }
  function CanSaveToXml: ByteBool; stdcall;
   {* ��������� ����� �� ���� ���� ��������� � xml. }
  function CanLoadFromXml: ByteBool; stdcall;
   {* ��������� ����� �� � ���� ��������� ������ �� xml. }
  function CanSaveToIntegrationXml: ByteBool; stdcall;
   {* ����� �� ���� ���� ��������� ��� ���������� ���������� }
  procedure GetPid; stdcall;
  property Id: TFolderId
   read GetId;
   {* ������� ���� }
  property CreationDate: 
   read GetCreationDate;
   {* ���� �������� }
 end;//IFoldersNode

 IFolder = interface;

 IFolders = interface(IBaseCatalog)
  {* ��������� (��������) �������������� ������ � ������� �����. ������ �������� ��� ����� (Folder). }
  ['{085870DB-A1B6-48E7-ADDD-3C9F3911FEF5}']
  procedure CreateFolder(out aRet
   {* IFolder }); stdcall;
   {* ������� �����, ���������� ����� ��������� ��������� BaseEntity ���� Folder. }
  procedure FindFolderNode(id: TFolderId
   {* ������������� ���� �����. };
   out aRet
   {* IFoldersNode }); stdcall;
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
  function Done: ByteBool; stdcall;
 end;//IDoneNotifier

 IFolder = interface(IEntityBase)
  {* ���������� BaseEntity ����������� ������� ������� ����� �����. }
  ['{4B736A91-FDC7-4F00-B445-9C91CE120AB9}']
  function GetShared: ByteBool; stdcall;
  procedure SetShared(const aValue: ByteBool); stdcall;
  function GetExternal: ByteBool; stdcall;
  function CanShare: ByteBool; stdcall;
   {* ����� �� ��������� ����� }
  property Shared: ByteBool
   read GetShared
   write SetShared;
   {* ��� ������� ������. ������� ���� ��� ����� �������� �������������, �.� ������� ������ �������������.
����. ������� ����� ����� �������� ��������������.
��� ������� �������� ������ ������� � ������� ����� ������������ ���������� ConstantModify. }
  property External: ByteBool
   read GetExternal;
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
  done_notifier: ;
  folder: ;
 end;//TNotifyData

 IExternalFoldersChangeNotifier = interface
  {* ��������� ����������� ��������� ��������� �����. }
  ['{9AFA9214-42F7-439F-97DB-EB7827289CE0}']
  procedure Fire(const data: TNotifyData
   {* ������ �����������. }); stdcall;
   {* ��������� ��������� �����. ��� ���� ���������� ���������� ������ ���������������� ���������� �����, �������� ����������� ��������� �������� �����. }
 end;//IExternalFoldersChangeNotifier

implementation

uses
 l3ImplUses
;

end.
