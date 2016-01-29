unit vcmActiveControlsCollectionItem;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmActiveControlsCollectionItem - }
{ Начат: 22.11.2004 18:49 }
{ $Id: vcmActiveControlsCollectionItem.pas,v 1.6 2009/08/28 17:15:46 lulin Exp $ }

// $Log: vcmActiveControlsCollectionItem.pas,v $
// Revision 1.6  2009/08/28 17:15:46  lulin
// - начинаем публикацию и описание внутренних операций.
//
// Revision 1.5  2009/02/11 15:19:45  lulin
// - чистка кода.
//
// Revision 1.4  2005/01/28 16:33:03  lulin
// - bug fix: не вычищались события и был AV в диалоге Page Setup.
//
// Revision 1.3  2004/11/25 10:44:11  lulin
// - rename type: _TvcmExecuteEvent -> TvcmControlExecuteEvent.
// - rename type: _TvcmTestEvent -> TvcmControlTestEvent.
// - new type: TvcmControlGetTargetEvent.
//
// Revision 1.2  2004/11/24 12:35:55  lulin
// - new behavior: обработчики операций от контролов теперь привязываются к операциям.
//
// Revision 1.1  2004/11/22 15:55:08  lulin
// - new unit: vcmActiveControlsCollectionItem.
//

{$I vcmDefine.inc }

interface

uses
  vcmExternalInterfaces,
  vcmControlsCollectionItem
  ;

type
  TvcmActiveControlsCollectionItem = class(TvcmControlsCollectionItem)
    private
    // internal fields
      f_OnExecute : TvcmControlExecuteEvent;
      f_OnTest    : TvcmControlTestEvent;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public properties
      property OnExecute: TvcmControlExecuteEvent
        read f_OnExecute
        write f_OnExecute;
        {-}
      property OnTest: TvcmControlTestEvent
        read f_OnTest
        write f_OnTest;
        {-}
  end;//TvcmActiveControlsCollectionItem

implementation

procedure TvcmActiveControlsCollectionItem.Cleanup;
  //override;
  {-}
begin
 OnTest := nil;
 OnExecute := nil;
 inherited;
end;

end.

