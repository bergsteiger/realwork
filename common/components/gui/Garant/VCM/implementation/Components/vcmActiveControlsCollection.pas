unit vcmActiveControlsCollection;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcm -           }
{ Начат: 18.11.2004 20:46 }
{ $Id: vcmActiveControlsCollection.pas,v 1.8 2015/06/03 12:26:27 lulin Exp $ }

// $Log: vcmActiveControlsCollection.pas,v $
// Revision 1.8  2015/06/03 12:26:27  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.7  2009/08/28 17:15:46  lulin
// - начинаем публикацию и описание внутренних операций.
//
// Revision 1.6  2009/02/11 15:19:45  lulin
// - чистка кода.
//
// Revision 1.5  2005/01/27 13:43:28  lulin
// - bug fix: не все контролы отвязывались от операций (CQ OIT5-11924).
//
// Revision 1.4  2004/11/25 10:44:11  lulin
// - rename type: _TvcmExecuteEvent -> TvcmControlExecuteEvent.
// - rename type: _TvcmTestEvent -> TvcmControlTestEvent.
// - new type: TvcmControlGetTargetEvent.
//
// Revision 1.3  2004/11/24 12:35:55  lulin
// - new behavior: обработчики операций от контролов теперь привязываются к операциям.
//
// Revision 1.2  2004/11/22 15:55:08  lulin
// - new unit: vcmActiveControlsCollectionItem.
//
// Revision 1.1  2004/11/18 17:57:22  lulin
// - new class: TvcmActiveControlsCollection.
//

{$I vcmDefine.inc }

interface

{$If not defined(NoVCM)}
uses
  Classes,

  vcmExternalInterfaces,
  vcmControlsCollection
  ;

type
  TvcmActiveControlsCollection = class(TvcmControlsCollection)
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
      procedure PublishOp(const aControl : TComponent;
                          anExecute      : TvcmControlExecuteEvent = nil;
                          aTest          : TvcmControlTestEvent = nil);
        {* - опубликовать операцию. }
      procedure UnlinkControl(aControl : TComponent);
        {* - отвязать контрол. }
  end;//TvcmActiveControlsCollection
{$IfEnd}  

implementation

{$If not defined(NoVCM)}
uses
  vcmControlsCollectionItem,
  vcmActiveControlsCollectionItem
  ;

// start class TvcmActiveControlsCollection

class function TvcmActiveControlsCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmActiveControlsCollectionItem;
end;

procedure TvcmActiveControlsCollection.PublishOp(const aControl : TComponent;
                                                 anExecute      : TvcmControlExecuteEvent = nil;
                                                 aTest          : TvcmControlTestEvent = nil);
  {* - опубликовать операцию. }
var
 l_Item : TvcmActiveControlsCollectionItem;
begin
 l_Item := FindItemByControl(aControl) As TvcmActiveControlsCollectionItem;
 if (l_Item = nil) then
 begin
  l_Item := Add As TvcmActiveControlsCollectionItem;
  l_Item.Control := aControl;
 end;//l_Item = nil
 l_Item.OnExecute := anExecute;
 l_Item.OnTest := aTest;
end;

procedure TvcmActiveControlsCollection.UnlinkControl(aControl : TComponent);
  {* - отвязать контрол. }
var
 l_Item : TvcmControlsCollectionItem;
begin
 l_Item := FindItemByControl(aControl);
 if (l_Item <> nil) then
  Delete(l_Item.Index);
end;
{$IfEnd}  

end.

