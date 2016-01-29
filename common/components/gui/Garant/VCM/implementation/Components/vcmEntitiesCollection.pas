unit vcmEntitiesCollection;
{* ��������� ���������. }

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmEntitiesCollection - }
{ �����: 11.03.2003 11:41 }
{ $Id: vcmEntitiesCollection.pas,v 1.6 2007/02/27 14:14:49 lulin Exp $ }

// $Log: vcmEntitiesCollection.pas,v $
// Revision 1.6  2007/02/27 14:14:49  lulin
// - ��� ������������ �������� � �������� ���������� �� �������������, � �� ���.
//
// Revision 1.5  2003/11/19 11:38:25  law
// - new behavior: ������������ ��� �������� � �������� � MenuManager'� ��� ���������� ������������� ��������������. ���� �������������� ���� �� ��������.
//
// Revision 1.4  2003/11/18 16:40:31  law
// - new behavior: ��� Root'� �� ������ �������.
// - bug fix: ��� ��������� ��������� � Run-time  � ���������� �� ������������� ����������� ����.
//
// Revision 1.3  2003/11/18 15:21:46  law
// - new method: TvcmCustomEntities._LinkControlToEntity.
//
// Revision 1.2  2003/07/25 10:45:43  law
// - new unit: vcmBaseCollection.
//
// Revision 1.1  2003/04/01 12:54:44  law
// - ��������������� MVC � VCM.
//
// Revision 1.2  2003/03/26 12:13:41  law
// - cleanup.
//
// Revision 1.1  2003/03/11 09:02:13  law
// - new class: TvcmEntitiesCollection.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,

  vcmBaseEntitiesCollection
  ;

type
  TvcmEntitiesCollection = class(TvcmBaseEntitiesCollection)
   {* ��������� ���������. }
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
  end;//TvcmEntitiesCollection

implementation

uses
  vcmEntitiesCollectionItem
  ;

// start class TvcmEntitiesCollection

class function TvcmEntitiesCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmEntitiesCollectionItem;
end;

end.

