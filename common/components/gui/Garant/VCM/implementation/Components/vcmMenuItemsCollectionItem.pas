unit vcmMenuItemsCollectionItem;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmMenuItemsCollectionItem - }
{ Начат: 28.10.2003 11:38 }
{ $Id: vcmMenuItemsCollectionItem.pas,v 1.3 2008/03/24 08:48:43 lulin Exp $ }

// $Log: vcmMenuItemsCollectionItem.pas,v $
// Revision 1.3  2008/03/24 08:48:43  lulin
// - <K>: 87591840.
//
// Revision 1.2  2006/03/15 11:09:48  lulin
// - new behavior: выливаем не заголовки категорий, а их идентификаторы.
//
// Revision 1.1  2003/10/28 09:07:34  law
// - new prop: TvcmCustomMenuManager.MainMenuItems.
//

{$Include vcmDefine.inc }

interface

uses
  vcmInterfaces,
  vcmBaseCollectionItem
  ;

type
  TvcmMenuItemsCollectionItem = class(TvcmBaseCollectionItem)
    private
    // internal fields
      f_LinkID : Integer;
      f_OnTest : TvcmTestEvent;
    protected
    // property methods
      function  pm_GetLinkID: Integer;
      procedure pm_SetLinkID(aValue: Integer);
        {-}
    public
    // public methods
      function GetID: Integer;
        override;
        {-}
    published
    // published properties
      property LinkID: Integer
        read pm_GetLinkID
        write pm_SetLinkID
        default 0;
        {-}
      property OnTest: TvcmTestEvent
        read f_OnTest
        write f_OnTest;
        {-}
  end;//TvcmMenuItemsCollectionItem

implementation

uses
  vcmBaseCollection
  ;

// start class TvcmMenuItemsCollectionItem

function TvcmMenuItemsCollectionItem.pm_GetLinkID: Integer;
  {-}
var
 l_ID : Integer;  
begin
 if (f_LinkID = 0) AND (Collection <> nil) then
 begin
  l_ID := 0;
  while true do
  begin
   Inc(l_ID);
   if (TvcmBaseCollection(Collection).FindItemByID(l_ID) = nil) then
   begin
    f_LinkID := l_ID;
    break;
   end;//TvcmBaseCollection(Collection).FindItemByID(l_ID) = nil
  end;//while true
 end;//f_LinkID = 0
 Result := f_LinkID;
end;

procedure TvcmMenuItemsCollectionItem.pm_SetLinkID(aValue: Integer);
  {-}
begin
 f_LinkID := aValue;
end;

function TvcmMenuItemsCollectionItem.GetID: Integer;
  //override;
  {-}
begin
 Result := f_LinkID;
end;

end.

