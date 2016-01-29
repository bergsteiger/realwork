unit vcmEntities;
{* Компонент для определения списка сущностей. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmEntities -   }
{ Начат: 11.03.2003 11:14 }
{ $Id: vcmEntities.pas,v 1.20 2015/06/03 12:26:27 lulin Exp $ }

// $Log: vcmEntities.pas,v $
// Revision 1.20  2015/06/03 12:26:27  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.19  2012/04/13 18:22:34  lulin
// {RequestLink:237994598}
//
// Revision 1.18  2009/10/14 18:39:48  lulin
// {RequestLink:166855347}.
//
// Revision 1.17  2009/10/13 15:55:29  lulin
// - чистка кода.
//
// Revision 1.16  2009/10/12 11:27:15  lulin
// - коммитим после падения CVS.
//
// Revision 1.16  2009/10/08 12:46:44  lulin
// - чистка кода.
//
// Revision 1.15  2009/02/20 16:45:38  lulin
// - <K>: 136941122.
//
// Revision 1.14  2007/02/27 14:14:49  lulin
// - для привязывания сущности к контролу используем ее идентификатор, а не имя.
//
// Revision 1.13  2007/02/27 12:08:52  lulin
// - cleanup.
//
// Revision 1.12  2004/12/23 14:06:38  am
// bugfix: синтаксис
//
// Revision 1.11  2004/12/23 13:48:48  am
// new: прокинул методы из _Entities: _UnlinkControlFromEntity и _UnlinkControl
//
// Revision 1.10  2004/09/22 05:41:25  lulin
// - оптимизация - убраны код и данные, не используемые в Run-Time.
//
// Revision 1.9  2004/01/29 15:54:12  law
// - change: проявил "жест доброй воли" :-) и избавился от использования _CurrentmainForm.
//
// Revision 1.8  2003/11/24 17:35:21  law
// - new method: TvcmCustomEntities._RegisterInRep.
//
// Revision 1.7  2003/11/19 11:38:25  law
// - new behavior: регистрируем все сущности и операции в MenuManager'е для дальнейшей централизации редактирования. Само редактирование пока не доделано.
//
// Revision 1.6  2003/11/18 16:40:31  law
// - new behavior: для Root'а не делаем подменю.
// - bug fix: для компонент связанных в Run-time  с сущностями не присваивалось контекстное меню.
//
// Revision 1.5  2003/11/18 15:21:46  law
// - new method: TvcmCustomEntities._LinkControlToEntity.
//
// Revision 1.4  2003/10/15 16:16:36  law
// - new method: GetItemByName.
//
// Revision 1.3  2003/04/04 10:58:58  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.2  2003/04/03 13:50:54  law
// - доделана подписка на события.
//
// Revision 1.1  2003/04/01 12:54:44  law
// - переименовываем MVC в VCM.
//
// Revision 1.6  2003/03/26 12:13:41  law
// - cleanup.
//
// Revision 1.5  2003/03/20 12:30:01  law
// - new behavior: сделана обработка контекстных операций.
//
// Revision 1.4  2003/03/19 11:51:03  law
// - cleanup: добавлен метод TvcmCustomEntities.GetFirstFormItem.
//
// Revision 1.3  2003/03/11 15:34:30  law
// - new behavior: сделаны обработчики операций.
//
// Revision 1.2  2003/03/11 09:02:13  law
// - new class: TvcmEntitiesCollection.
//
// Revision 1.1  2003/03/11 08:37:34  law
// - new unit: vcmEntities.
//

{$Include vcmDefine.inc }

interface

{$If not defined(NoVCM)}
uses
  Classes,

  vcmExternalInterfaces,
  vcmInterfaces,
  vcmBase,
  vcmBaseCollection,
  vcmBaseEntities,

  vcmEntitiesCollectionItem
  ;

type
  TvcmCustomEntities = class(TvcmBaseEntities)
   {* Компонент для определения списка сущностей. }
    public
    // public methods
      class function GetEntitiesCollectionClass: RvcmBaseCollection;
        override;
        {-}
      function GetEntityForControl(const anEntityID : TvcmControlID;
                                   aControl         : TComponent;
                                   aX, aY           : Integer): IvcmEntity;
        {-}
      function GetFirstFormItem: TvcmEntitiesCollectionItem;
        {-}
      {$IfDef DesignTimeLibrary}
      procedure UnlinkControl(aControl: TComponent);
        {-}
      procedure RegisterInRep;
        {-}
      {$EndIf DesignTimeLibrary}  
  end;//TvcmCustomEntities

  TvcmEntities = class(TvcmCustomEntities)
   {*! Компонент для определения списка сущностей. Для конечного использования. }
    published
    // published properties
      property Entities;
        {-}
  end;//TvcmEntities
{$IfEnd}  

implementation

{$If not defined(NoVCM)}
uses
  TypInfo,
  
  SysUtils,

  Menus,

  vcmEntitiesCollection,
  vcmBaseMenuManager, 
  vcmBaseEntitiesCollection;

// start class TvcmCustomEntities

class function TvcmCustomEntities.GetEntitiesCollectionClass: RvcmBaseCollection;
  //override;
  {-}
begin
 Result := TvcmEntitiesCollection;
end;

function TvcmCustomEntities.GetEntityForControl(const anEntityID : TvcmControlID;
                                                aControl         : TComponent;
                                                aX, aY           : Integer): IvcmEntity;
  {-}
var
 l_Index : Integer;
begin
 Result := nil;
 with Entities do
  for l_Index := 0 to Pred(Count) do
   with TvcmEntitiesCollectionItem(Items[l_Index]) do
    if (EntityID = anEntityID) then begin
     Result := GetEntityForControl(aControl, aX, aY);
     break;
    end;//EntityID = anEntityID
end;

function TvcmCustomEntities.GetFirstFormItem: TvcmEntitiesCollectionItem;
  {-}
var
 l_Item  : TvcmEntitiesCollectionItem;
 l_Index : Integer;
begin
 Result := nil;
 with Entities do
  for l_Index := 0 to Pred(Count) do begin
   l_Item := TvcmEntitiesCollectionItem(Items[l_Index]);
   if l_Item.IsFormItem then begin
    Result := l_Item;
    break;
   end;//l_Item.IsFormItem
  end;//for l_Index
end;

{$IfDef DesignTimeLibrary}
procedure TvcmCustomEntities.RegisterInRep;
  {-}
begin
 if (Entities <> nil) then
  Entities.RegisterInRep;
end;

procedure TvcmCustomEntities.UnlinkControl(aControl: TComponent);
begin
 Entities.UnlinkControl(aControl);
end;
{$EndIf DesignTimeLibrary}

{$IfEnd}

end.

