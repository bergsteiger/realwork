unit vcmModulesCollection;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmModulesCollection - }
{ Начат: 27.02.2004 21:34 }
{ $Id: vcmModulesCollection.pas,v 1.6 2010/09/15 18:15:01 lulin Exp $ }

// $Log: vcmModulesCollection.pas,v $
// Revision 1.6  2010/09/15 18:15:01  lulin
// {RequestLink:235047275}.
//
// Revision 1.5  2009/09/25 10:16:04  lulin
// - продолжаем переносить на модель модуль Common.
//
// Revision 1.4  2009/09/11 08:56:32  lulin
// - минимизируем пути к файлам относительно рута проекта.
//
// Revision 1.3  2009/08/27 10:39:44  lulin
// - регистрируем операции модулей.
//
// Revision 1.2  2009/07/30 18:39:09  lulin
// {RequestLink:129240934}. №6.
//
// Revision 1.1  2004/02/27 19:22:16  law
// - bug fix: поправлена обработка ShortCut'ов для операций модулей.
// - bug fix: поправдена ДВОЙНАЯ обработка ShortCut'ов в случае редактора.
//

{$I vcmDefine.inc }

interface

uses
  Classes,

  vcmExternalInterfaces,
  vcmRepEntitiesCollection,
  vcmModule
  ;

type
  TvcmModulesCollection = class(TvcmRepEntitiesCollection)
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
      procedure PublishModule(aModule: RvcmModule; const aCap: String);
        {-}
      function  PublishModuleOperation(aModule: RvcmModule;
                                       const aName : String;
                                       const aCap  : String;
                                       aNoPrefix   : Boolean): TvcmMOPID;
        {-}
  end;//TvcmModulesCollection
  RvcmModulesCollection = class of TvcmModulesCollection;

implementation

uses
  SysUtils,

  vcmInterfaces,
  vcmBase,
  vcmBaseCollectionItem,
  vcmModulesCollectionItem
  ;

// start class TvcmModulesCollection

class function TvcmModulesCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmModulesCollectionItem;
end;

procedure TvcmModulesCollection.PublishModule(aModule: RvcmModule; const aCap: String);
  {-}
var
 l_M : String;
 l_Item : TvcmBaseCollectionItem;
begin
 l_M := aModule.ClassName;
 if SameText(l_M[1], 'T') then
  System.Delete(l_M, 1, 1);
 l_Item := FindItemByName(l_M);
 if (l_Item <> nil) then
  Exit;
 l_Item := TvcmBaseCollectionItem(Add);
 l_Item.Name := l_M;
 l_Item.Caption := aCap;
end;

function TvcmModulesCollection.PublishModuleOperation(aModule: RvcmModule;
                                                      const aName : String;
                                                      const aCap  : String;
                                                      aNoPrefix   : Boolean): TvcmMOPID;
  {-}
var
 l_M : String;
 l_Mo : TvcmBaseCollectionItem;
 l_Op : TvcmBaseCollectionItem;
 l_ON : String;
begin
 l_M := aModule.ClassName;
 if SameText(l_M[1], 'T') then
  System.Delete(l_M, 1, 1);
 l_Mo := FindItemByName(l_M);
 Assert(l_Mo <> nil);
 if aNoPrefix then
  l_ON := aName
 else
  l_ON := 'op' + aName;
 l_Op := TvcmModulesCollectionItem(l_Mo).Operations.FindItemByName(l_ON);
 if (l_Op = nil) then
 begin
  l_Op := TvcmBaseCollectionItem(TvcmModulesCollectionItem(l_Mo).Operations.Add);
  l_Op.Name := l_ON;
  l_Op.Caption := aCap;
 end//l_Op = nil
 else
 if (l_Op.Caption = '') OR (l_Op.Caption = l_Op.Name) then
  l_Op.Caption := aCap;
 Result.rMoID := Succ(l_Mo.ID);
 Result.rOpID := Succ(l_Op.ID);
end;
  
end.

