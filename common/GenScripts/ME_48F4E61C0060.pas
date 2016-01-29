unit evdInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
 , k2Interfaces
;

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
  function Store(aFormat: TevdClipboardFormat;
   const aPool: IStream;
   const aFilters: TevdTagGenerator;
   aFlags: TevdStoreFlags): Boolean; overload;
   {* сохраняет выделение в формате aFormat в Pool, который должен реализовывать IStream. }
 end;//IevdDataObject
 
 IevdExternalDocNumberToInternal = interface
  function ConvertExternalDocNumberToInternal(aDocID: Integer): Integer;
 end;//IevdExternalDocNumberToInternal
 
 TevdAddress = object
  {* Адрес ссылки }
 end;//TevdAddress
 
 IevdHyperlinkInfo = interface
  {* Информация о ссылке }
 end;//IevdHyperlinkInfo
 
implementation

uses
 l3ImplUses
 , evdTypes
;

end.
