unit evdInterfaces;
 {* Интерфейсы для обработки объектов на базе EVD }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , k2Interfaces
;

const
 evd_DefaultStoreFlags = [evd_sfStoreParaEnd];

type
 TevdStoreFlag = (
  evd_sfInternal
  , evd_sfChildrenOnly
  , evd_sfStoreParaEnd
  , evd_sfOnlyFirstCell
 );//TevdStoreFlag

 TevdStoreFlags = set of TevdStoreFlag;

 TevdClipboardFormat = Tl3ClipboardFormat;

 TevdTagGenerator = Ik2TagGenerator;

 IevdDataObject = interface
  ['{E6851658-F80E-48ED-A2E9-043D34096EBB}']
  function Store(aFormat: TevdClipboardFormat;
   const aPool: IStream;
   const aFilters: TevdTagGenerator;
   aFlags: TevdStoreFlags = DefaultStoreFlags): Boolean; overload;
   {* сохраняет выделение в формате aFormat в Pool, который должен реализовывать IStream. }
 end;//IevdDataObject

 IevdExternalDocNumberToInternal = interface
  ['{D74DA2A1-6425-4307-8458-661386227ACD}']
  function ConvertExternalDocNumberToInternal(aDocID: Integer): Integer;
 end;//IevdExternalDocNumberToInternal

 TevdAddress = object
  {* Адрес ссылки }
  public
   DocID: Integer;
    {* Идентификатор документа }
   SubID: Integer;
    {* Идентификатор метки }
   TypeID: Integer;
   RevisionID: Integer;
 end;//TevdAddress

 IevdHyperlinkInfo = interface
  {* Информация о ссылке }
  ['{CF4E3A81-B898-4C91-9A46-9ECDEB78A9EA}']
  function Get_Text: Il3CString;
  function Get_Address: TevdAddress;
  function Get_AppInfo: Il3CString;
  property Text: Il3CString
   read Get_Text;
   {* Текст ссылки }
  property Address: TevdAddress
   read Get_Address;
   {* Адрес }
  property AppInfo: Il3CString
   read Get_AppInfo;
   {* Информация о приложении }
 end;//IevdHyperlinkInfo

function TevdAddress_E: TevdAddress;

implementation

uses
 l3ImplUses
 , evdTypes
;

function TevdAddress_E: TevdAddress;
//#UC START# *4CDD3B0E02A6_48F4941A0249_var*
//#UC END# *4CDD3B0E02A6_48F4941A0249_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4CDD3B0E02A6_48F4941A0249_impl*
 Result.TypeID := ev_NullAddressType;
//#UC END# *4CDD3B0E02A6_48F4941A0249_impl*
end;//TevdAddress_E

end.
