unit vcmTargetedControlsCollectionItem;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmTargetedControlsCollectionItem - }
{ Начат: 25.11.2004 14:20 }
{ $Id: vcmTargetedControlsCollectionItem.pas,v 1.2 2005/01/28 16:33:00 lulin Exp $ }

// $Log: vcmTargetedControlsCollectionItem.pas,v $
// Revision 1.2  2005/01/28 16:33:00  lulin
// - bug fix: не вычищались события и был AV в диалоге Page Setup.
//
// Revision 1.1  2004/11/25 11:28:26  lulin
// - new unit: vcmTargetedControlsCollection.
// - new unit: vcmTargetedControlsCollectionItem.
//

{$I vcmDefine.inc }

interface

uses
  vcmExternalInterfaces,
  vcmControlsCollectionItem
  ;

type
  TvcmTargetedControlsCollectionItem = class(TvcmControlsCollectionItem)
    private
    // internal fields
      f_OnGetTarget : TvcmControlGetTargetEvent;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public properties
      property OnGetTarget: TvcmControlGetTargetEvent
        read f_OnGetTarget
        write f_OnGetTarget;
        {-}
  end;//TvcmTargetedControlsCollectionItem

implementation

procedure TvcmTargetedControlsCollectionItem.Cleanup;
  //override;
  {-}
begin
 OnGetTarget := nil;
 inherited;
end;

end.

