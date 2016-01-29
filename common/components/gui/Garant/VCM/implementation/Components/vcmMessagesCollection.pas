unit vcmMessagesCollection;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmMessagesCollection - }
{ Начат: 21.02.2003 16:19 }
{ $Id: vcmMessagesCollection.pas,v 1.16 2014/02/18 10:01:27 lulin Exp $ }

// $Log: vcmMessagesCollection.pas,v $
// Revision 1.16  2014/02/18 10:01:27  lulin
// - для несортируемых списков убираем возможность поставить флаг сортировки.
//
// Revision 1.15  2011/12/08 16:30:03  lulin
// {RequestLink:273590436}
// - чистка кода.
//
// Revision 1.14  2011/06/27 16:50:19  lulin
// {RequestLink:254944102}.
// - чистим мусорок.
//
// Revision 1.13  2009/02/20 12:29:37  lulin
// - <K>: 136941122.
//
// Revision 1.12  2007/01/24 15:47:14  lulin
// - убрана ненужная сортировка.
//
// Revision 1.11  2006/03/23 14:06:51  lulin
// - добавлена коллекция строковых констант.
//
// Revision 1.10  2006/03/23 13:33:45  lulin
// - cleanup.
//
// Revision 1.9  2006/03/23 13:31:00  lulin
// - cleanup.
//
// Revision 1.8  2004/09/17 14:57:06  lulin
// - clenaup.
//
// Revision 1.7  2004/09/15 13:57:59  lulin
// - new unit: vcmStringList.
//
// Revision 1.6  2004/09/15 12:54:58  mmorozov
// new behaviour: в RunTime сортировка сообщений отключена по умолчанию, сообщения сортируются после загрузки в vcmBaseMenuManager;
//
// Revision 1.5  2004/09/11 11:55:47  lulin
// - cleanup: избавляемся от прямого использования деструкторов.
//
// Revision 1.4  2004/07/06 16:18:08  mmorozov
// new: включена сортировка;
//
// Revision 1.3  2004/06/10 14:23:35  mmorozov
// new: property TvcmMessagesCollection.Categories;
//
// Revision 1.2  2004/05/12 13:02:14  am
// new method: FindByKeyName - поиск итема в коллекции по ключу.
//
// Revision 1.1  2004/01/27 16:52:57  law
// - new units: vcmMessagesCollection, vcmMessagesCollectionItem.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,

  vcmExternalInterfaces,
  vcmInterfaces,
  vcmBase,
  vcmStringList,
  vcmBaseCollection,
  vcmBaseStringCollection,
  vcmMessagesCollectionItem
  ;

type
  TvcmMessagesCollection = class(TvcmBaseStringCollection)
(*    {$IfDef DesignTimeLibrary}
    private
    // private fields
      f_Categories : _IvcmStrings;
    protected
    // protected methods
      function pm_GetCategories : _IvcmStrings;
        {-}
      procedure Cleanup;
        override;
        {-}
    {$EndIf DesignTimeLibrary}*)
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
(*    {$IfDef DesignTimeLibrary}
    public
    // public properties
      property Categories : _IvcmStrings
        read pm_GetCategories;
        {* - список категорий сообщений. }
    {$EndIf DesignTimeLibrary}*)
  end;//TvcmMessagesCollection

implementation

uses
  SysUtils
  ;

// start class TvcmMessagesCollection

(*{$IfDef DesignTimeLibrary}
procedure TvcmMessagesCollection.Cleanup;
begin
 f_Categories := nil;
 inherited;
end;
{$EndIf DesignTimeLibrary}*)

class function TvcmMessagesCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmMessagesCollectionItem;
end;

(*{$IfDef DesignTimeLibrary}
function TvcmMessagesCollection.pm_GetCategories: _IvcmStrings;
  {-}
var
 lIndex : Integer;
begin
 // создадим если список не был построен
 if not Assigned(f_Categories) then
  f_Categories := TvcmStringList.Make;
 // очистим
 f_Categories.Clear;
 for lIndex := 0 to Pred(Count) do
  with TvcmMessagesCollectionItem(Items[lIndex]) do
   // добавим если ещё не добавили
   if f_Categories.IndexOf(_Category) = -1 then
    f_Categories.Add(_Category);
 // отсортируем
 (f_Categories.Items As TStringList).Sort;
 Result := f_Categories;
end;
{$EndIf DesignTimeLibrary}*)

end.

