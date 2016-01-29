unit vcmOperationsCollection;
{* ��������� ��������. }

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmOperationsCollection - }
{ �����: 11.03.2003 12:19 }
{ $Id: vcmOperationsCollection.pas,v 1.16 2011/07/29 15:08:37 lulin Exp $ }

// $Log: vcmOperationsCollection.pas,v $
// Revision 1.16  2011/07/29 15:08:37  lulin
// {RequestLink:209585097}.
//
// Revision 1.15  2009/10/12 11:27:15  lulin
// - �������� ����� ������� CVS.
//
// Revision 1.15  2009/10/08 12:46:44  lulin
// - ������ ����.
//
// Revision 1.14  2009/02/20 17:29:20  lulin
// - ������ ������������.
//
// Revision 1.13  2009/02/20 15:19:00  lulin
// - <K>: 136941122.
//
// Revision 1.12  2004/09/21 16:22:18  mmorozov
// change: ������ IvcmUserFriendlyControl ����� IvcmIdentifiedUserFriendlyControl;
//
// Revision 1.11  2004/09/13 07:10:32  mmorozov
// new: ���������� TvcmOperationsCollectionItem.UnRegister;
//
// Revision 1.10  2004/09/10 16:52:08  mmorozov
// new behaviour: � ReRegisterItem �� �������� UnRegisterItem ���� ��� ��������������� �������;
//
// Revision 1.9  2003/12/30 10:03:55  law
// - optimization: ��� �������� ������� Main-���� �� ������� �� ����� ��� ����� ��������� (CQ OIT5-5628).
//
// Revision 1.8  2003/11/24 17:35:21  law
// - new method: TvcmCustomEntities._RegisterInRep.
//
// Revision 1.7  2003/11/19 11:38:25  law
// - new behavior: ������������ ��� �������� � �������� � MenuManager'� ��� ���������� ������������� ��������������. ���� �������������� ���� �� ��������.
//
// Revision 1.6  2003/11/18 19:35:54  law
// - new: ����� ������ ����� ����������� �������, ��������� � �������� � MenuManager'�. ����� ��� ����� ���� ������� �� ������ �����.
//
// Revision 1.5  2003/07/25 10:45:43  law
// - new unit: vcmBaseCollection.
//
// Revision 1.4  2003/04/22 14:03:00  law
// - new behavior: ������� ��������� ��������, ��������� �� �������� �����.
//
// Revision 1.3  2003/04/08 10:40:46  law
// - bug fix: ����������� ������������� ��������.
//
// Revision 1.2  2003/04/04 10:58:58  law
// - bug fix: ���� ������ � ����� ���� TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:44  law
// - ��������������� MVC � VCM.
//
// Revision 1.8  2003/03/27 14:36:53  law
// - new prop: �������� ������ ����� ��������.
//
// Revision 1.7  2003/03/26 12:13:41  law
// - cleanup.
//
// Revision 1.6  2003/03/24 14:04:06  law
// - change: ���������� ������������ ��� ����������� � �������� � _IvcmParams.
//
// Revision 1.5  2003/03/24 13:25:47  law
// - change: ���������� ������������ ��� ����������� � �������� � _IvcmParams.
//
// Revision 1.4  2003/03/21 12:34:43  law
// - new behavior: ��������� �������� ������ ����������.
//
// Revision 1.3  2003/03/20 12:30:01  law
// - new behavior: ������� ��������� ����������� ��������.
//
// Revision 1.2  2003/03/13 09:52:02  law
// - new component: TvcmModuleDef.
//
// Revision 1.1  2003/03/11 09:31:23  law
// - new prop: TvcmEntitiesCollectionItem.Operations.
//

{$I vcmDefine.inc }

interface

{$IfNDef NoVCM}
uses
  Classes,

  vcmInterfaces,
  vcmBase,
  vcmBaseOperationsCollection
  ;

type
  TvcmOperationsCollection = class(TvcmBaseOperationsCollection)
   {* ��������� ��������. }
    protected
    // internal methods
      procedure Notify(Item: TCollectionItem; Action: TCollectionNotification);
        override;
        {-}
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
      procedure RegisterItem(anItem: TCollectionItem);
        {-}
      procedure ReRegisterItem(anItem: TCollectionItem);
        {-}
      procedure UnRegisterItem(anItem: TCollectionItem);
        {-}
  end;//TvcmOperationsCollection
{$EndIf NoVCM}

implementation

{$IfNDef NoVCM}
uses
  SysUtils,

  vcmUserControls,

  vcmOperationsCollectionItem,

  vcmBaseMenuManager
  ;

// start class TvcmOperationsCollection

class function TvcmOperationsCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmOperationsCollectionItem;
end;

procedure TvcmOperationsCollection.RegisterItem(anItem: TCollectionItem);
  {-}
var
 l_UF : IvcmIdentifiedUserFriendlyControl;
 l_Op : IvcmOperationDef;
begin
 if (g_MenuManager <> nil) then
 begin
  if Supports(anItem, IvcmOperationDef, l_Op) then
   try
    if (l_Op.Name <> '') AND
       Supports(Owner, IvcmIdentifiedUserFriendlyControl, l_UF) then
     try
      g_MenuManager.RegisterOperation(l_UF, l_Op, Owner, anItem);
     finally
      l_UF := nil;
     end;//try..finally
   finally
    l_Op := nil;
   end;//try..finally
 end;//g_MenuManager <> nil
end;

procedure TvcmOperationsCollection.Notify(Item: TCollectionItem; Action: TCollectionNotification);
  //override;
  {-}
begin
 inherited;
 case Action of
  cnAdded :
   RegisterItem(Item);
  cnDeleting:
   UnRegisterItem(Item);
 end;//case Action
end;

procedure TvcmOperationsCollection.UnRegisterItem(anItem: TCollectionItem);
  {-}
begin
 TvcmOperationsCollectionItem(anItem).UnRegister;
end;

procedure TvcmOperationsCollection.ReRegisterItem(anItem: TCollectionItem);
  {-}
begin
 with TvcmOperationsCollectionItem(anItem) do
 begin
  if IsRegistred then
   UnRegisterItem(anItem);
  RegisterItem(anItem);
  IsRegistred := True;
 end;
end;
{$EndIf NoVCM}

end.

