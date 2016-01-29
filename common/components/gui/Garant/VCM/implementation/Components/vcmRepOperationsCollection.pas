unit vcmRepOperationsCollection;
{* Коллекция операций. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmRepOperationsCollection - }
{ Начат: 19.11.2003 13:44 }
{ $Id: vcmRepOperationsCollection.pas,v 1.4 2015/09/24 14:29:20 kostitsin Exp $ }

// $Log: vcmRepOperationsCollection.pas,v $
// Revision 1.4  2015/09/24 14:29:20  kostitsin
// {requestlink: 605157327 }
//
// Revision 1.3  2012/08/07 14:37:42  lulin
// {RequestLink:358352265}
//
// Revision 1.2  2003/11/19 15:18:41  law
// - bug fix: неправильно вычислялся _GroupID.
// - new behavior: дерегестрируем описатели операций из MenuManager'а.
//
// Revision 1.1  2003/11/19 11:38:25  law
// - new behavior: регистрируем все сущности и операции в MenuManager'е для дальнейшей централизации редактирования. Само редактирование пока не доделано.
//

{$I vcmDefine.inc }

interface

uses
  Classes,

  vcmBaseOperationsCollection
  ;

type
  TvcmRepOperationsCollection = class(TvcmBaseOperationsCollection)
   {* Коллекция операций. }
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
      procedure RemoveHolder(anOpHolder : TObject);
        overload;
        {-}
  end;//TvcmRepOperationsCollection

implementation

uses
  vcmRepOperationsCollectionItem,
  vcmOperationsCollectionItem
  ;

// start class TvcmRepOperationsCollection

class function TvcmRepOperationsCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmRepOperationsCollectionItem;
end;

procedure TvcmRepOperationsCollection.RemoveHolder(anOpHolder : TObject);
  //overload;
  {-}
var
 l_Index : Integer;  
begin
 for l_Index := 0 to Pred(Count) do
 begin
  Assert(anOpHolder is TvcmOperationsCollectionItem);
  TvcmRepOperationsCollectionItem(Items[l_Index]).RemoveHolder(anOpHolder as TvcmOperationsCollectionItem);
 end;
end;
  
end.

