unit vcmMenuItemsCollection;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmMenuItemsCollection - }
{ Начат: 28.10.2003 11:38 }
{ $Id: vcmMenuItemsCollection.pas,v 1.2 2003/11/19 11:38:25 law Exp $ }

// $Log: vcmMenuItemsCollection.pas,v $
// Revision 1.2  2003/11/19 11:38:25  law
// - new behavior: регистрируем все сущности и операции в MenuManager'е для дальнейшей централизации редактирования. Само редактирование пока не доделано.
//
// Revision 1.1  2003/10/28 09:07:34  law
// - new prop: TvcmCustomMenuManager.MainMenuItems.
//

{$I vcmDefine.inc }

interface

uses
  Classes,
  
  vcmBaseCollection
  ;

type
  TvcmMenuItemsCollection = class(TvcmBaseCollection)
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
  end;//TvcmMenuItemsCollection

implementation

uses
  vcmMenuItemsCollectionItem
  ;

// start class TvcmMenuItemsCollection

class function TvcmMenuItemsCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmMenuItemsCollectionItem;
end;

end.

