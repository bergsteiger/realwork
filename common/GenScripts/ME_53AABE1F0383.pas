unit evCustomStyleManager;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Variant
 , nevTools
;

 (*
 MevCustomStyleManager = interface
  {* Контракт сервиса TevCustomStyleManager }
  function IsAbolishedDocumentLink(aSeg: Tl3Variant;
   const aPara: InevPara): Boolean;
  function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
 end;//MevCustomStyleManager
 *)
 
type
 IevCustomStyleManager = interface
  {* Интерфейс сервиса TevCustomStyleManager }
  function IsAbolishedDocumentLink(aSeg: Tl3Variant;
   const aPara: InevPara): Boolean;
  function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
 end;//IevCustomStyleManager
 
 TevCustomStyleManager = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function IsAbolishedDocumentLink(aSeg: Tl3Variant;
   const aPara: InevPara): Boolean;
  function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
 end;//TevCustomStyleManager
 
implementation

uses
 l3ImplUses
;

end.
