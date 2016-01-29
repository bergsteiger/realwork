unit vcmRepEntitiesCollectionItem;
{* Элемент коллекции сущностей. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmRepEntitiesCollectionItem - }
{ Начат: 19.11.2003 11:09 }
{ $Id: vcmRepEntitiesCollectionItem.pas,v 1.13 2015/09/24 17:28:50 kostitsin Exp $ }

// $Log: vcmRepEntitiesCollectionItem.pas,v $
// Revision 1.13  2015/09/24 17:28:50  kostitsin
// {requestlink: 605157327 }
//
// Revision 1.12  2013/04/25 14:22:38  lulin
// - портируем.
//
// Revision 1.11  2012/08/07 14:37:42  lulin
// {RequestLink:358352265}
//
// Revision 1.10  2008/03/20 09:48:19  lulin
// - cleanup.
//
// Revision 1.9  2007/06/26 09:42:36  mmorozov
// - hint fix;
//
// Revision 1.8  2006/03/14 10:10:29  lulin
// - bug fix: не очищались провисшие ссылки - в результате была вероятность AV.
//
// Revision 1.7  2006/03/10 14:11:04  lulin
// - bug fix: не отвязывали ссылку.
//
// Revision 1.6  2006/03/10 12:45:49  lulin
// - new behavior: берем Caption сущности из репозитория.
//
// Revision 1.5  2005/07/14 16:39:45  lulin
// - new behavior: в run-time получаем ID сущности и модуля по их имени из информации, содержащейся в MenuManager'е.
//
// Revision 1.4  2004/09/11 11:55:47  lulin
// - cleanup: избавляемся от прямого использования деструкторов.
//
// Revision 1.3  2004/06/01 14:56:35  law
// - удалены конструкторы Tl3VList.MakeLongint, MakeLongintSorted - пользуйтесь _Tl3LongintList.
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
  vcmBase,
  vcmBaseCollection,
  vcmBaseEntitiesCollectionItem,
  vcmEntitiesCollectionItemList,
  vcmEntitiesCollectionItem
  ;

type
  TvcmRepEntitiesCollectionItem = class(TvcmBaseEntitiesCollectionItem)
   {* Элемент коллекции сущностей. }
    private
    // internal fields
      f_Holders : TvcmEntitiesCollectionItemList;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      {$IfNDef DesignTimeLibrary}
      function  MakeID(const aName: AnsiString): Integer;
        override;
        {-}
      {$EndIf  DesignTimeLibrary}  
      class function GetOperationsCollectionClass: RvcmBaseCollection;
        override;
        {-}
      procedure AddHolder(aHolder: TvcmEntitiesCollectionItem);
        {-}
      procedure RemoveHolder(aHolder: TvcmEntitiesCollectionItem);
        {-}
  end;//TvcmRepEntitiesCollectionItem

implementation

uses
  vcmRepOperationsCollection
  ;

// start class TvcmRepEntitiesCollectionItem

procedure TvcmRepEntitiesCollectionItem.Cleanup;
  //override;
  {-}
var
 l_Index : Integer;
begin
 if (f_Holders <> nil) then
  with f_Holders do
   for l_Index := 0 to Pred(Count) do
    Items[l_Index].SetRep(nil);
 vcmFree(f_Holders);
 inherited;
end;

{$IfNDef DesignTimeLibrary}
function TvcmRepEntitiesCollectionItem.MakeID(const aName: AnsiString): Integer;
  //override;
  {-}
begin
 Result := Succ(Index);
end;
{$EndIf  DesignTimeLibrary}

class function TvcmRepEntitiesCollectionItem.GetOperationsCollectionClass: RvcmBaseCollection;
  //override;
  {-}
begin
 Result := TvcmRepOperationsCollection;
end;

procedure TvcmRepEntitiesCollectionItem.AddHolder(aHolder: TvcmEntitiesCollectionItem);
  {-}
begin
 if (f_Holders = nil) then
  f_Holders := TvcmEntitiesCollectionItemList.Create;
 f_Holders.Add(aHolder);
 aHolder.SetRep(Self);
end;

procedure TvcmRepEntitiesCollectionItem.RemoveHolder(aHolder: TvcmEntitiesCollectionItem);
  {-}
begin
 if (f_Holders <> nil) then
  f_Holders.Remove(aHolder);
 aHolder.SetRep(nil);
end;

end.

