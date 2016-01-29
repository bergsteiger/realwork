unit vcmModulesCollectionItem;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmModulesCollectionItem - }
{ Начат: 27.02.2004 21:34 }
{ $Id: vcmModulesCollectionItem.pas,v 1.2 2004/09/22 15:50:10 lulin Exp $ }

// $Log: vcmModulesCollectionItem.pas,v $
// Revision 1.2  2004/09/22 15:50:10  lulin
// - cleanup.
//
// Revision 1.1  2004/02/27 19:22:16  law
// - bug fix: поправлена обработка ShortCut'ов для операций модулей.
// - bug fix: поправдена ДВОЙНАЯ обработка ShortCut'ов в случае редактора.
//

{$I vcmDefine.inc }

interface

uses
  vcmRepEntitiesCollectionItem,
  vcmRepositoryEx
  ;

type
  TvcmModulesCollectionItem = class(TvcmRepEntitiesCollectionItem)
    protected
    // property methods
      function pm_GetModuleID: Integer;
        {-}
    protected
    // internal methods
      function IDRep: TvcmRep;
        override;
        {-}
    public
    // public properties
      property ModuleID: Integer
        read pm_GetModuleID;
        {-}    
  end;//TvcmModulesCollectionItem

implementation

// start class TvcmModulesCollectionItem

function TvcmModulesCollectionItem.pm_GetModuleID: Integer;
  {-}
begin
 Result := EntityID;
end;

function TvcmModulesCollectionItem.IDRep: TvcmRep;
  //override;
  {-}
begin
 Result := vcm_repModule;
end;

end.

