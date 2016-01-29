unit vcmRepEntitiesCollection;
{* Коллекция сущностей. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmRepEntitiesCollection - }
{ Начат: 19.11.2003 11:08 }
{ $Id: vcmRepEntitiesCollection.pas,v 1.14 2012/08/07 14:37:42 lulin Exp $ }

// $Log: vcmRepEntitiesCollection.pas,v $
// Revision 1.14  2012/08/07 14:37:42  lulin
// {RequestLink:358352265}
//
// Revision 1.13  2011/11/17 10:42:27  lulin
// {RequestLink:232098711}
//
// Revision 1.12  2010/08/27 15:17:56  lulin
// {RequestLink:224134305}.
//
// Revision 1.11  2009/09/18 09:14:57  lulin
// - для регистрации модулей и операций не лазаем в кишочки.
//
// Revision 1.10  2009/08/27 17:03:52  lulin
// - готовимся к публикации внутренних операций.
//
// Revision 1.9  2009/08/21 15:54:14  lulin
// - в индексе ошибались на единицу.
// - правим заголовки.
//
// Revision 1.8  2009/08/21 10:34:25  lulin
// - возвращаем код операции - чтобы в дальнейшем им можно было пользоваться.
//
// Revision 1.7  2009/08/12 15:43:56  lulin
// - уменьшаем количество строковых констант.
//
// Revision 1.6  2009/08/03 18:12:37  lulin
// - публикуем операции.
//
// Revision 1.5  2006/03/14 10:10:29  lulin
// - bug fix: не очищались провисшие ссылки - в результате была вероятность AV.
//
// Revision 1.4  2004/08/30 12:42:46  demon
// - fix: убраны лишние сортировки
//
// Revision 1.3  2004/03/23 05:57:22  mmorozov
// new: сортировка;
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

  vcmExternalInterfaces,
  vcmBaseEntitiesCollection,
  vcmBaseOperationState,
  vcmBaseCollectionItem
  ;

type
  TvcmRepEntitiesCollection = class(TvcmBaseEntitiesCollection)
   {* Коллекция сущностей. }
    private
    // internal methods
      function  PublishOperationPrim(const anEn    : String;
                                     const anOp    : String;
                                     const anEnCap : String;
                                     const anOpCap : String;
                                     aNoPrefix     : Boolean;
                                     anInternal    : Boolean): TvcmOPID;
        {-}
      function GetOperation(const anEn: String;
        const anOp: String;
        aNoPrefix: Boolean): TvcmBaseCollectionItem;
    public
    // public methods
      constructor Create(anOwner: TPersistent);
        override;
        { - }
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
      function  PublishOperation(const anEn    : String;
                                 const anOp    : String;
                                 const anEnCap : String;
                                 const anOpCap : String;
                                 aNoPrefix     : Boolean): TvcmOPID;
        {-}
      function  PublishInternalOperation(const anEn    : String;
                                 const anOp    : String;
                                 const anEnCap : String;
                                 const anOpCap : String;
                                 aNoPrefix     : Boolean): TvcmOPID;
        {-}
   function PublishOperationState(const anEn: String;
     const anOp: String;
     const aState: String;
     aNoPrefix: Boolean): TvcmBaseOperationState;
     {* Публикует состояние операции }
   procedure SetOperationImageIndex(const anEn: String;
     const anOp: String;
     anImageIndex: Integer;
     aNoPrefix: Boolean);
  end;//TvcmRepEntitiesCollection

implementation

uses
  vcmRepEntitiesCollectionItem,
  vcmRepOperationsCollectionItem,
  vcmBaseCollection,
  vcmBaseEntitiesCollectionItem,
  vcmBaseOperationsCollectionItem
  ;

// start class TvcmRepEntitiesCollection

constructor TvcmRepEntitiesCollection.Create(anOwner: TPersistent);
begin
 inherited Create(anOwner);
 {$IfDef DesignTimeLibrary}
 Sorted := True;
 {$EndIf DesignTimeLibrary}
end;

class function TvcmRepEntitiesCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmRepEntitiesCollectionItem;
end;

function TvcmRepEntitiesCollection.PublishOperation(const anEn    : String;
                                                    const anOp    : String;
                                                    const anEnCap : String;
                                                    const anOpCap : String;
                                                    aNoPrefix: Boolean): TvcmOPID;
  {-}
begin
 Result := PublishOperationPrim(anEn, anOp, anEnCap, anOpCap, aNoPrefix, false)
end;

function TvcmRepEntitiesCollection.PublishInternalOperation(const anEn    : String;
                                                    const anOp    : String;
                                                    const anEnCap : String;
                                                    const anOpCap : String;
                                                    aNoPrefix: Boolean): TvcmOPID;
  {-}
begin
 Result := PublishOperationPrim(anEn, anOp, anEnCap, anOpCap, aNoPrefix, true)
end;

function TvcmRepEntitiesCollection.PublishOperationPrim(const anEn    : String;
                                                        const anOp    : String;
                                                        const anEnCap : String;
                                                        const anOpCap : String;
                                                        aNoPrefix     : Boolean;
                                                        anInternal    : Boolean): TvcmOPID;
  {-}
var
 l_EnN : String;
 l_OpN : String;
 l_En : TvcmBaseCollectionItem;
 l_Op : TvcmBaseCollectionItem;
begin
 l_EnN := 'en' + anEn;
 if aNoPrefix then
  l_OpN := anOp
 else
  l_OpN := 'op' + anOp;
 l_En := FindItemByName(l_EnN);
 if (l_En = nil) then
 begin
  l_En := TvcmBaseCollectionItem(Add);
  l_En.Name := l_EnN;
  l_En.Caption := anEnCap;
 end//l_En = nil
 else
 if (l_En.Caption = '') OR (l_En.Caption = l_En.Name) then
  l_En.Caption := anEnCap;
 l_Op := TvcmRepEntitiesCollectionItem(l_En).Operations.FindItemByName(l_OpN);
 if (l_Op = nil) then
 begin
  l_Op := TvcmBaseCollectionItem(TvcmRepEntitiesCollectionItem(l_En).Operations.Add);
  l_Op.Name := l_OpN;
  l_Op.Caption := anOpCap;
 end//l_Op = nil
 else
 if (l_Op.Caption = '') OR (l_Op.Caption = l_Op.Name) then
  l_Op.Caption := anOpCap;
 if anInternal then
  TvcmBaseOperationsCollectionItem(l_Op).OperationType := vcm_otInternal;
 Result.rEnID := Succ(l_En.ID);
 Result.rOpID := Succ(l_Op.ID);
end;

function TvcmRepEntitiesCollection.PublishOperationState(const anEn: String;
  const anOp: String;
  const aState: String;
  aNoPrefix: Boolean): TvcmBaseOperationState;
  {* Публикует состояние операции }
var
 l_StN : String;
 l_Op : TvcmBaseCollectionItem;
 l_St : TvcmBaseCollectionItem;
begin
 l_Op := GetOperation(anEn, anOp, aNoPrefix);
 Assert(l_Op <> nil);
 l_StN := 'st' + aState;
 l_St := TvcmRepOperationsCollectionItem(l_Op).States.FindItemByName(l_StN);
 if (l_St = nil) then
 begin
  l_St := TvcmBaseCollectionItem(TvcmRepOperationsCollectionItem(l_Op).States.Add);
  l_St.Name := l_StN;
 end;//l_St = nil
 Assert(l_St <> nil);
 Assert(l_St Is TvcmBaseOperationState);
 Result := TvcmBaseOperationState(l_St);
end;

function TvcmRepEntitiesCollection.GetOperation(const anEn: String;
  const anOp: String;
  aNoPrefix: Boolean): TvcmBaseCollectionItem;
var
 l_EnN : String;
 l_OpN : String;
 l_En : TvcmBaseCollectionItem;
begin
 l_EnN := 'en' + anEn;
 if aNoPrefix then
  l_OpN := anOp
 else
  l_OpN := 'op' + anOp;
 l_En := FindItemByName(l_EnN);
 Assert(l_En <> nil);
 Result := TvcmRepEntitiesCollectionItem(l_En).Operations.FindItemByName(l_OpN);
 Assert(Result <> nil);
end;

procedure TvcmRepEntitiesCollection.SetOperationImageIndex(const anEn: String;
  const anOp: String;
  anImageIndex: Integer;
  aNoPrefix: Boolean);
var
 l_Op : TvcmBaseCollectionItem;
begin
 l_Op := GetOperation(anEn, anOp, aNoPrefix);
 Assert(l_Op <> nil);
 TvcmRepOperationsCollectionItem(l_Op).ImageIndex := anImageIndex;
end;

end.

