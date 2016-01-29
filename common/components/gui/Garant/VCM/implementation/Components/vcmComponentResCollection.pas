unit vcmComponentResCollection;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmComponentResCollection - }
{ Начат: 17.10.2006 10:25 }
{ $Id: vcmComponentResCollection.pas,v 1.2 2006/11/03 11:00:32 lulin Exp $ }

// $Log: vcmComponentResCollection.pas,v $
// Revision 1.2  2006/11/03 11:00:32  lulin
// - объединил с веткой 6.4.
//
// Revision 1.1.2.1  2006/10/17 07:37:05  lulin
// - ресурсы компонент загружаем в специально предназначенную для этого коллекцию.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,

  vcmBaseCollection
  ;

type
  TvcmComponentResCollection = class(TvcmBaseCollection)
   {* Коллекция управляющих элементов, привязанных к сущностям. }
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
  end;//TvcmComponentResCollection

implementation

uses
  vcmComponentResCollectionItem
  ;

// start class TvcmComponentResCollection

class function TvcmComponentResCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmComponentResCollectionItem;
end;
  
end.

