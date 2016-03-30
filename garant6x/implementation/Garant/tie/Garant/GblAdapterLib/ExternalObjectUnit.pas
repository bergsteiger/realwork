unit ExternalObjectUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ExternalObjectUnit.pas"
// ���������: "Interfaces"
// ������� ������: "ExternalObject" MUID: (45ED922F00A4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , BaseTreeSupportUnit
;

type
 TExternalObjectType = (
  EOT_PIC
   {* �������� � ������� BMP. }
  , EOT_JPG
  , EOT_PNG
  , EOT_GIF
  , EOT_RTF
   {* ����� � ������� RTF. }
  , EOT_XLS
   {* ������� � ������� XLS. }
  , EOT_MP3
  , EOT_EVD
  , EOT_TIF
  , EOT_PDF
  , EOT_PPT
   {* ����� PowerPoint }
  , EOT_CDR
   {* ����� CorelDraw }
  , EOT_DOC
   {* �������� Word }
  , EOT_DOCX
  , EOT_XLSX
  , EOT_XML
  , EOT_XSD
  , EOT_USR
 );//TExternalObjectType

 IExternalLink = interface
  ['{533104AC-5A1B-41B9-8ACC-C929C2B96678}']
  function GetUrl: IString; stdcall;
  property Url: IString
   read GetUrl;
   {* ������ �� ������� ������� � ��������� URL. }
 end;//IExternalLink

 IExternalObject = interface
  ['{A57F5CFD-DA48-4769-97D6-B63FEF94B81C}']
  function GetDataSize: Cardinal; stdcall;
  function GetDataPointer: pointer; stdcall;
  function GetName: IString; stdcall;
  function GetExtension: IString; stdcall;
  function GetDataType: TExternalObjectType; stdcall;
  property DataSize: Cardinal
   read GetDataSize;
   {* ����� ������ ������������ ������. }
  property DataPointer: pointer
   read GetDataPointer;
   {* ��������� �� ����� � �������. }
  property Name: IString
   read GetName;
   {* ��� �������� �������. }
  property Extension: IString
   read GetExtension;
   {* ���������� ��� ����� (������ � ���������� ������) �� ����� }
  property DataType: TExternalObjectType
   read GetDataType;
 end;//IExternalObject

 ISplashScreen = interface(IExternalObject)
  ['{6F8DC97E-13B6-446A-A55D-B24A5232F52E}']
  function GetShowTime: short; stdcall;
  function GetOwnerCaption: IString; stdcall;
  function GetOwner: IString; stdcall;
  property ShowTime: short
   read GetShowTime;
  property OwnerCaption: IString
   read GetOwnerCaption;
  property Owner: IString
   read GetOwner;
 end;//ISplashScreen

implementation

uses
 l3ImplUses
;

end.
