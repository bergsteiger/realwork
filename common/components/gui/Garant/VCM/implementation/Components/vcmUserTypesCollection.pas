unit vcmUserTypesCollection;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcm -           }
{ �����: 25.07.2003 14:48 }
{ $Id: vcmUserTypesCollection.pas,v 1.6 2015/06/03 12:26:27 lulin Exp $ }

// $Log: vcmUserTypesCollection.pas,v $
// Revision 1.6  2015/06/03 12:26:27  lulin
// - �������� ��������� �����������.
//
// Revision 1.5  2006/03/14 13:04:52  lulin
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

