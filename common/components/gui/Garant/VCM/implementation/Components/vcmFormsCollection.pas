unit vcmFormsCollection;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmFormsCollection - }
{ Начат: 27.11.2003 21:12 }
{ $Id: vcmFormsCollection.pas,v 1.14 2011/08/01 14:51:33 lulin Exp $ }

// $Log: vcmFormsCollection.pas,v $
// Revision 1.14  2011/08/01 14:51:33  lulin
// {RequestLink:274825697}.
//
// Revision 1.13  2010/04/27 18:02:24  lulin
// {RequestLink:159352361}.
// - признак возможности закрытия формы переносим на модель.
//
// Revision 1.12  2009/10/19 13:07:56  lulin
// {RequestLink:159360578}. №7.
//
// Revision 1.11  2005/07/25 12:14:08  mmorozov
// new: public property Items;
//
// Revision 1.10  2005/02/17 10:08:02  lulin
// - new behavior: в коллекции _AppForms обновляем Caption из формы, если оно не было задано.
//
// Revision 1.9  2004/09/22 11:45:47  lulin
// - bug fix: избавляемся от дублирования элементов коллекции форм.
//
// Revision 1.8  2004/09/22 09:06:54  lulin
// - bug fix: дублирование идентификаторов форм.
//
// Revision 1.7  2004/09/22 06:36:18  lulin
// - оптимизация - TvcmFormsCollection теперь тоже ищет элементы по индексу (в роли которого выступает класс формы).
//
// Revision 1.6  2004/08/30 12:42:46  demon
// - fix: убраны лишние сортировки
//
// Revision 1.5  2004/03/22 14:22:26  mmorozov
// new: сортировать список форм;
//
// Revision 1.4  2003/12/01 11:01:38  law
// - bug fix: поправлена генерация UserType'ов.
// - bug fix: свойство Weigth переименовано в _Weight.
//
// Revision 1.3  2003/11/30 12:38:16  law
// - bug fix: при убивании формы удаляем ссылку на нее из MenuManager'а.
//
// Revision 1.2  2003/11/30 11:39:41  law
// - new behavior: автогенерируем типы пользовательских объектов.
//
// Revision 1.1  2003/11/27 18:55:57  law
// - new prop: TvcmBaseMenuManager._AppForms - список всех форм приложения.
//

{$I vcmDefine.inc }

interface

uses
  Classes,

  vcmInterfaces,
  
  vcmBaseCollection,
  vcmFormsCollectionItem,
  vcmEntityForm
  ;

type
  TvcmFormsCollection = class(TvcmBaseCollection)
    protected
    // protected methods
     function GetItem(aIndex : Integer) : TvcmFormsCollectionItem;
       {-}
     procedure SetItem(     aIndex : Integer;
                       const Value : TvcmFormsCollectionItem);
       {-}
    public
    // public methods
      constructor Create(anOwner: TPersistent);
        override;
        {-}
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
      procedure AddForm(aForm: {$IfDef DesignTimeLibrary}
                               TvcmEntityForm
                               {$Else}
                               RvcmEntityForm
                               {$EndIf}
                               );
        {-}
      {$IfDef DesignTimeLibrary}
      procedure RemoveForm(aForm: TvcmEntityForm);
        {-}
      {$EndIf DesignTimeLibrary}  
    public
    // public properties
      property Items[aIndex : Integer] : TvcmFormsCollectionItem
        read GetItem
        write SetItem;
  end;//TvcmFormsCollection

implementation

uses
  SysUtils,

  vcmBase
  ;

{ TvcmFormsCollection }

constructor TvcmFormsCollection.Create(anOwner: TPersistent);
  //override;
  {-}
begin
 inherited Create(anOwner);
 {$IfDef DesignTimeLibrary}
 Sorted := True;
 {$EndIf DesignTimeLibrary}
end;

class function TvcmFormsCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmFormsCollectionItem;
end;

procedure TvcmFormsCollection.AddForm(aForm: {$IfDef DesignTimeLibrary}
                                             TvcmEntityForm
                                             {$Else}
                                             RvcmEntityForm
                                             {$EndIf});
  {-}
var
 l_Item : TvcmFormsCollectionItem;
 {$IfNDef DesignTimeLibrary}
 l_Name : String;
 {$EndIf  DesignTimeLibrary}
begin
 if (aForm <> nil) then
 begin
  {$IfNDef DesignTimeLibrary}
  l_Item := TvcmFormsCollectionItem(FindItemByID(Integer(aForm{.ClassType})));
  if (l_Item = nil) then
  begin
   l_Name := aForm.ClassName;
   if SameText(l_Name[1], 'T') then
    System.Delete(l_Name, 1, 1);
   l_Item := TvcmFormsCollectionItem(FindItemByName(l_Name));
  end;//l_Item = nil
  {$Else  DesignTimeLibrary}
   l_Item := TvcmFormsCollectionItem(FindItemByName(aForm.FormID.rName));
  {$EndIf  DesignTimeLibrary}
  if (l_Item = nil) then
  begin
   l_Item := TvcmFormsCollectionItem(Add);
   with l_Item do
   begin
    {$IfNDef DesignTimeLibrary}
    l_Name := aForm.ClassName;
    if SameText(l_Name[1], 'T') then
     System.Delete(l_Name, 1, 1);
    Name := l_Name;
    {$Else  DesignTimeLibrary}
    Name := aForm.Name;
    {$EndIf DesignTimeLibrary}
    {$IfDef DesignTimeLibrary}
    Caption := aForm.Caption;
    {$EndIf DesignTimeLibrary}
   end;//with TvcmFormsCollectionItem(Insert)
  end//FindItemByID(aForm.Name) = nil
  else
  {$IfDef DesignTimeLibrary}
  if ((l_Item.Caption = l_Item.Name) OR (l_Item.Caption = '')) AND
     (aForm.Caption <> '') then
   l_Item.Caption := aForm.Caption
  {$EndIf DesignTimeLibrary} 
  ;
  {$IfDef DesignTimeLibrary}
  l_Item.Form := aForm;
  {$Else  DesignTimeLibrary}
  l_Item.FormClass := aForm;
  {$EndIf DesignTimeLibrary}
 end;//aForm <> nil
end;

{$IfDef DesignTimeLibrary}
procedure TvcmFormsCollection.RemoveForm(aForm: TvcmEntityForm);
  {-}
var
 l_Item : TvcmFormsCollectionItem;
begin
 if (aForm <> nil) then
 begin
  {$IfDef DesignTimeLibrary}
  l_Item := TvcmFormsCollectionItem(FindItemByName(aForm.FormID.rName));
  {$Else  DesignTimeLibrary}
  l_Item := TvcmFormsCollectionItem(FindItemByID(Integer(aForm.ClassType)));
  {$EndIf DesignTimeLibrary}
  if (l_Item <> nil) then
   if (l_Item.Form = aForm) then
    l_Item.Form := nil;
 end;//aForm <> nil
end;
{$EndIf DesignTimeLibrary}

function TvcmFormsCollection.GetItem(aIndex : Integer) : TvcmFormsCollectionItem;
begin
 Result := TvcmFormsCollectionItem(inherited GetItem(aIndex));
end;

procedure TvcmFormsCollection.SetItem(     aIndex : Integer;
                                      const Value : TvcmFormsCollectionItem);
begin
 inherited SetItem(aIndex, Value);
end;

end.

