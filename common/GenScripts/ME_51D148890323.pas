unit vcmEntityDefForContextMenu;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , vcmInterfaces
 , vcmExternalInterfaces
 , vcmUserControls
;

type
 TvcmEntityDefForContextMenu = class(Tl3CProtoObject, IvcmEntityDef)
  procedure Create(const anEn: IvcmEntityDef);
  function Make(const anEn: IvcmEntityDef): IvcmEntityDef;
  function Hint: IvcmCString;
   {* подсказка дл€ пункта меню, представл€ющего объект }
  function LongHint: IvcmCString;
   {* детальна€ подсказка дл€ пункта меню, представл€ющего объект }
  function ImageIndex: Integer;
  function ID: TvcmControlID;
   {* идентификатор объекта }
  function OperationsDefIterator: IvcmOperationsDefIterator;
   {* итератор описаний операций. ћожет быть nil }
  function ToolbarPos: TvcmToolBarPos;
   {* любой объект, обладающий набором операций, может отображать их в тулбаре }
  function Options: TvcmEntityOperationsOptions;
  function Caption: IvcmCString;
   {* пользовательское им€ объекта }
  function Name: TvcmString;
   {* им€ объекта }
  function ContextMenuWeight: Integer;
 end;//TvcmEntityDefForContextMenu
 
implementation

uses
 l3ImplUses
 , vcmOperationsDefIteratorForContextMenu
;

end.
