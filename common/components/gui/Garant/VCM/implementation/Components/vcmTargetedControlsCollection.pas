unit vcmTargetedControlsCollection;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmTargetedControlsCollection - }
{ �����: 25.11.2004 14:15 }
{ $Id: vcmTargetedControlsCollection.pas,v 1.2 2004/11/25 11:59:01 lulin Exp $ }

// $Log: vcmTargetedControlsCollection.pas,v $
// Revision 1.2  2004/11/25 11:59:01  lulin
// - new behavior: ������ �������� ����� ����������� ����������� ���� ������ GetTarget.
//
// Revision 1.1  2004/11/25 11:28:29  lulin
// - new unit: vcmTargetedControlsCollection.
// - new unit: vcmTargetedControlsCollectionItem.
//

{$I vcmDefine.inc }

interface

uses
  Types,
  Classes,

  vcmExternalInterfaces,
  vcmControlsCollection
  ;

type
  TvcmTargetedControlsCollection = class(TvcmControlsCollection)
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
      procedure PublishEntity(const aControl : TComponent;
                              aGetTarget     : TvcmControlGetTargetEvent);
        {* - ������������ ��������. }
      function  GetTargetForControl(aControl    : TComponent;
                                    const aPt   : TPoint;
                                    out aTarget : IUnknown): Boolean;
        {-}                            
  end;//TvcmTargetedControlsCollection

implementation

uses
  vcmTargetedControlsCollectionItem
  ;

class function TvcmTargetedControlsCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmTargetedControlsCollectionItem;
end;

procedure TvcmTargetedControlsCollection.PublishEntity(const aControl : TComponent;
                                                       aGetTarget     : TvcmControlGetTargetEvent);
  {* - ������������ ��������. }
var
 l_Item : TvcmTargetedControlsCollectionItem;
begin
 l_Item := FindItemByControl(aControl) As TvcmTargetedControlsCollectionItem;
 if (l_Item = nil) then
 begin
  l_Item := Add As TvcmTargetedControlsCollectionItem;
  l_Item.Control := aControl;
 end;//l_Item = nil
 l_Item.OnGetTarget := aGetTarget;
end;

function TvcmTargetedControlsCollection.GetTargetForControl(aControl    : TComponent;
                                                            const aPt   : TPoint;
                                                            out aTarget : IUnknown): Boolean;
  {-}
var
 l_Item : TvcmTargetedControlsCollectionItem;
begin
 Result := false;
 l_Item := FindItemByControl(aControl) As TvcmTargetedControlsCollectionItem;
 if (l_Item <> nil) AND Assigned(l_Item.OnGetTarget) then
  Result := l_Item.OnGetTarget(aPt, aTarget);
end;

end.

