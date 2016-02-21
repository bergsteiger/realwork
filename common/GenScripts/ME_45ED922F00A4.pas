unit ExternalObjectUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ExternalObjectUnit.pas"
// ���������: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
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
  function Get_url: IString;
  property url: IString
   read Get_url;
   {* ������ �� ������� ������� � ��������� URL. }
 end;//IExternalLink

 IExternalObject = interface
  ['{A57F5CFD-DA48-4769-97D6-B63FEF94B81C}']
  function Get_data_size: Cardinal;
  function Get_data_pointer: pointer;
  function Get_name: IString;
  function Get_extension: IString;
  function Get_data_type: TExternalObjectType;
  property data_size: Cardinal
   read Get_data_size;
   {* ����� ������ ������������ ������. }
  property data_pointer: pointer
   read Get_data_pointer;
   {* ��������� �� ����� � �������. }
  property name: IString
   read Get_name;
   {* ��� �������� �������. }
  property extension: IString
   read Get_extension;
   {* ���������� ��� ����� (������ � ���������� ������) �� ����� }
  property data_type: TExternalObjectType
   read Get_data_type;
 end;//IExternalObject

 ISplashScreen = interface(IExternalObject)
  ['{6F8DC97E-13B6-446A-A55D-B24A5232F52E}']
  function Get_show_time: short;
  function Get_owner_caption: IString;
  function Get_owner: IString;
  property show_time: short
   read Get_show_time;
  property owner_caption: IString
   read Get_owner_caption;
  property owner: IString
   read Get_owner;
 end;//ISplashScreen

class function make(url: PAnsiChar): BadFactoryType;
class function make: BadFactoryType; overload;
class function make(const obj): BadFactoryType; overload;
class function make(is_start: Boolean;
 x: short;
 y: short;
 flash_available: Boolean): BadFactoryType; { can raise CanNotFindData }
 {* is_start - �������� ��� ������
x,y - ���������� ������
flash_available -�������� �� ����� ���� ������� }

implementation

uses
 l3ImplUses
;

class function make(url: PAnsiChar): BadFactoryType;
var
 l_Inst : IExternalLink;
begin
 l_Inst := Create(url);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IExternalObject;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const obj): BadFactoryType;
var
 l_Inst : IExternalObject;
begin
 l_Inst := Create(obj);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(is_start: Boolean;
 x: short;
 y: short;
 flash_available: Boolean): BadFactoryType; { can raise CanNotFindData }
 {* is_start - �������� ��� ������
x,y - ���������� ������
flash_available -�������� �� ����� ���� ������� }
var
 l_Inst : ISplashScreen;
begin
 l_Inst := Create(is_start, x, y, flash_available);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
