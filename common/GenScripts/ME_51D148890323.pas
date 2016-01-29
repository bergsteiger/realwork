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
   {* ��������� ��� ������ ����, ��������������� ������ }
  function LongHint: IvcmCString;
   {* ��������� ��������� ��� ������ ����, ��������������� ������ }
  function ImageIndex: Integer;
  function ID: TvcmControlID;
   {* ������������� ������� }
  function OperationsDefIterator: IvcmOperationsDefIterator;
   {* �������� �������� ��������. ����� ���� nil }
  function ToolbarPos: TvcmToolBarPos;
   {* ����� ������, ���������� ������� ��������, ����� ���������� �� � ������� }
  function Options: TvcmEntityOperationsOptions;
  function Caption: IvcmCString;
   {* ���������������� ��� ������� }
  function Name: TvcmString;
   {* ��� ������� }
  function ContextMenuWeight: Integer;
 end;//TvcmEntityDefForContextMenu
 
implementation

uses
 l3ImplUses
 , vcmOperationsDefIteratorForContextMenu
;

end.
