unit vcmUserTypesCollection;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcm -           }
{ Начат: 25.07.2003 14:48 }
{ $Id: vcmUserTypesCollection.pas,v 1.6 2015/06/03 12:26:27 lulin Exp $ }

// $Log: vcmUserTypesCollection.pas,v $
// Revision 1.6  2015/06/03 12:26:27  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.5  2006/03/14 13:04:52  lulin
// - разделяем UserType'ы в репозитарии и в формах.
//
// Revision 1.4  2006/02/07 15:47:25  mmorozov
// - new: вес UserType-а формы можно изменять динамически в Run-Time-е она автоматически будет переразмещена в PageControl-е;
// - рефакторинг ElPgCtl: упрощена процедура стыковки компонента на PC; объединены интерфейсы, в следствии чего изжит IelpcNotifyPageChanged;
// - new: появилась возможность при обновлении сборки указывать веса форм;
//
// Revision 1.3  2003/11/30 11:39:41  law
// - new behavior: автогенерируем типы пользовательских объектов.
//
// Revision 1.2  2003/11/19 11:38:25  law
// - new behavior: регистрируем все сущности и операции в MenuManager'е для дальнейшей централизации редактирования. Само редактирование пока не доделано.
//
// Revision 1.1  2003/07/25 11:03:42  law
// - new units: vcmUserTypesCollection, vcmUserTypesCollectionItem.
//

{$I vcmDefine.inc }

interface

{$If not defined(NoVCM)}

uses
  Classes,

  vcmBaseCollection,
  vcmBaseUserTypesCollection
  ;

type
  TvcmUserTypesCollection = class(TvcmBaseUserTypesCollection)
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
  end;//TvcmUserTypesCollection
{$IfEnd}  

implementation

{$If not defined(NoVCM)}
uses
  vcmUserTypesCollectionItem
  ;

// start class TvcmUserTypesCollection

class function TvcmUserTypesCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmUserTypesCollectionItem;
end;
{$IfEnd}

end.

