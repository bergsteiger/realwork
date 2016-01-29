unit evHyperlink;

interface

uses
 l3IntfUses
 , nevNavigation
 , nevTools
 , afwNavigation
 , l3Types
 , evdTypes
 , l3Variant
;

type
 TevHyperlink = class(IevHyperlink)
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
 end;//TevHyperlink
 
implementation

uses
 l3ImplUses
;

end.
