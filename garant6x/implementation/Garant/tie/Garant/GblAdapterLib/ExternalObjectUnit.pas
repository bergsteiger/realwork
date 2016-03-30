unit ExternalObjectUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ExternalObjectUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "ExternalObject" MUID: (45ED922F00A4)

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
   {* Картинка в формате BMP. }
  , EOT_JPG
  , EOT_PNG
  , EOT_GIF
  , EOT_RTF
   {* Текст в формате RTF. }
  , EOT_XLS
   {* Таблица в формате XLS. }
  , EOT_MP3
  , EOT_EVD
  , EOT_TIF
  , EOT_PDF
  , EOT_PPT
   {* Файлы PowerPoint }
  , EOT_CDR
   {* Файлы CorelDraw }
  , EOT_DOC
   {* Документ Word }
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
   {* Ссылка на внешние ресурсы в стандарте URL. }
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
   {* Общий размер возвращаемых данных. }
  property DataPointer: pointer
   read GetDataPointer;
   {* Указатель на буфер с данными. }
  property Name: IString
   read GetName;
   {* Имя внешнего объекта. }
  property Extension: IString
   read GetExtension;
   {* расширение для файла (вместе с лидирующей точкой) на диске }
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
