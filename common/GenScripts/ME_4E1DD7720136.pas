unit evHyperlinkProxy;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevNavigation
 , evdTypes
 , nevTools
 , afwNavigation
 , l3Types
 , l3Variant
 , l3Interfaces
;

type
 TevHyperlinkProxy = class(Tl3CProtoObject, IevHyperlink)
  procedure Create(const aLink: IevHyperlink);
  function Make(const aLink: IevHyperlink): IevHyperlink;
  function DoFromDocumentExternalHandle: Integer;
  function DoGetKind: TevLinkViewKind;
  function Exists: Boolean;
   {* Проверяет существует ли данная ссылка }
  procedure Insert;
   {* Вставляет новую ссылку }
  procedure Delete;
   {* Удаляет гипертекстовую ссылку }
  function ID: Integer;
   {* Идентификатор ссылки }
  function Para: InevPara;
   {* Параграф на котором стоит ссылка }
  function AddressList: IevAddressList;
  function Address: TevAddress;
   {* Адрес на который указывает ссылка (первый из AddressList) }
  function URL: Tl3PCharLen;
   {* Путь к ресурсу на который может указывать ссылка }
  function Hint: Tl3PCharLen;
   {* "подсказка" появляющаяся при наведении курсора на ссылку }
  function Kind: TevLinkViewKind;
   {* Вид отображения ссылки }
  function FromDocumentExternalHandle: Integer;
  function TargetDocumentID: Integer;
  function Name: Tl3PCharLen;
  function GetHyperlink: Tl3Tag;
 end;//TevHyperlinkProxy
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
;

end.
