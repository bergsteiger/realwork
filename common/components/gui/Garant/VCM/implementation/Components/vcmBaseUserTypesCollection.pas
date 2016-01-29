unit vcmBaseUserTypesCollection;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmBaseUserTypesCollection - }
{ �����: 25.07.2003 14:48 }
{ $Id: vcmBaseUserTypesCollection.pas,v 1.2 2015/06/03 12:26:27 lulin Exp $ }

// $Log: vcmBaseUserTypesCollection.pas,v $
// Revision 1.2  2015/06/03 12:26:27  lulin
// - �������� ��������� �����������.
//
// Revision 1.1  2006/03/14 13:04:52  lulin
// - ��������� UserType'� � ����������� � � ������.
//
// Revision 1.4  2006/02/07 15:47:25  mmorozov
// - new: ��� UserType-� ����� ����� �������� ����������� � Run-Time-� ��� ������������� ����� ������������� � PageControl-�;
// - ����������� ElPgCtl: �������� ��������� �������� ���������� �� PC; ���������� ����������, � ��������� ���� ����� IelpcNotifyPageChanged;
// - new: ��������� ����������� ��� ���������� ������ ��������� ���� ����;
//
// Revision 1.3  2003/11/30 11:39:41  law
// - new behavior: �������������� ���� ���������������� ��������.
//
// Revision 1.2  2003/11/19 11:38:25  law
// - new behavior: ������������ ��� �������� � �������� � MenuManager'� ��� ���������� ������������� ��������������. ���� �������������� ���� �� ��������.
//
// Revision 1.1  2003/07/25 11:03:42  law
// - new units: vcmUserTypesCollection, vcmUserTypesCollectionItem.
//

{$Include vcmDefine.inc }

interface

{$If not defined(NoVCM)}
uses
  Classes,
  
  vcmBaseCollection,
  vcmBaseUserTypesCollectionItem
  ;

type
  TvcmBaseUserTypesCollection = class(TvcmBaseCollection)
    private
    // property fields
      f_OnWeightChanged: TNotifyEvent;
    protected
    // property methods
      function  pm_GetItem(anIndex: Integer): TvcmBaseUserTypesCollectionItem;
      procedure pm_SetItem(anIndex: Integer; aValue: TvcmBaseUserTypesCollectionItem);
        {-}
      procedure Notify(Item: TCollectionItem; Action: TCollectionNotification);
        override;
        {-}
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
    public
    // public properties
      property Items[anIndex: Integer]: TvcmBaseUserTypesCollectionItem
        read pm_GetItem
        write pm_SetItem;
        default;
        {-}
      property OnWeightChanged: TNotifyEvent
        read f_OnWeightChanged
        write f_OnWeightChanged;
        {* - ���������� ��� ��������� ���� ������� ��������. }
  end;//TvcmBaseUserTypesCollection
{$IfEnd}  

implementation

{$If not defined(NoVCM)}

// start class TvcmBaseUserTypesCollection

class function TvcmBaseUserTypesCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmBaseUserTypesCollectionItem;
end;

procedure TvcmBaseUserTypesCollection.Notify(Item: TCollectionItem; Action: TCollectionNotification);
  // override;
  {-}
begin
 inherited;
 if Action = cnAdded then
  TvcmBaseUserTypesCollectionItem(Item).OnWeightChanged := f_OnWeightChanged;
end;

function TvcmBaseUserTypesCollection.pm_GetItem(anIndex: Integer): TvcmBaseUserTypesCollectionItem;
  {-}
begin
 Result := TvcmBaseUserTypesCollectionItem(inherited Items[anIndex]);
end;

procedure TvcmBaseUserTypesCollection.pm_SetItem(anIndex: Integer; aValue: TvcmBaseUserTypesCollectionItem);
  {-}
begin
 inherited Items[anIndex] := aValue;
end;

{$IfEnd}

end.

