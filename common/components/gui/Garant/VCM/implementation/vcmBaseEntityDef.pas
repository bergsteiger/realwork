unit vcmBaseEntityDef;
{* ������� ����� �������� ��������. }

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmBaseEntityDef - }
{ �����: 26.02.2003 21:38 }
{ $Id: vcmBaseEntityDef.pas,v 1.15 2015/10/04 17:37:07 kostitsin Exp $ }

// $Log: vcmBaseEntityDef.pas,v $
// Revision 1.15  2015/10/04 17:37:07  kostitsin
// ������ TvcmBaseEntitiesCollectionItem
//
// Revision 1.14  2013/07/05 09:10:33  lulin
// - ������ ���.
//
// Revision 1.13  2013/07/01 12:28:54  morozov
// {RequestLink:382416588}
//
// Revision 1.12  2012/08/07 14:37:36  lulin
// {RequestLink:358352265}
//
// Revision 1.11  2009/02/20 15:18:56  lulin
// - <K>: 136941122.
//
// Revision 1.10  2007/04/12 07:57:07  lulin
// - ���������� ������ � ����������.
//
// Revision 1.9  2007/04/10 14:06:20  lulin
// - ���������� ������ � ����������.
//
// Revision 1.8  2006/01/20 11:33:08  mmorozov
// 1. ������ ���� �� ������ ������������ �������� �������� �������� �� ������ ��������� � ����������� �������;
// 2. ���� � ������ ������������ ����������� �������� � ����������� ����������, �� �� ������������� ����������� ������� � ���� �������� ��������;
// 3. ��������� ����������� �������, ��� ����������� �������� �������� ������ ������������ � ��������� ������ ����;
// 3.
//
// Revision 1.7  2005/01/14 10:42:27  lulin
// - ������ Get*ParentForm ��������� � ���������� AFW.
//
// Revision 1.6  2004/09/10 16:21:42  lulin
// - ����������� - �������� OpDef � �������� ������ �� OperationItem, � �� �� ���� ����������.
//
// Revision 1.5  2004/09/10 14:04:00  lulin
// - ����������� - �������� EntityDef � �������� ������ �� EntityItem, � �� �� ���� ����������.
//
// Revision 1.4  2004/02/02 13:19:13  am
// new: ��������� ����������� �������� ����� ����� ������ �������.
//
// Revision 1.3  2004/01/22 18:56:09  law
// - remove props: IvcmEntityDef.OwnerID, OwnerCaption.
// - new prop: IvcmEntityDef.OwnerDef.
//
// Revision 1.2  2004/01/22 17:31:18  law
// - new props: IvcmEntityDef.OnwerID, OnwerCaption.
//
// Revision 1.1  2003/04/01 12:54:41  law
// - ��������������� MVC � VCM.
//
// Revision 1.9  2003/03/27 14:36:52  law
// - new prop: �������� ������ ����� ��������.
//
// Revision 1.8  2003/03/21 10:13:32  law
// - cleanup: ������� ������ vcm*Repository.
//
// Revision 1.7  2003/03/20 16:42:56  law
// - change: ���� �������� ����� Name ��������� �������� Caption.
//
// Revision 1.6  2003/03/11 13:03:57  law
// - new behavior: ������� �������������� ����������� ��������������� ��������� � ��������.
//
// Revision 1.5  2003/02/27 10:23:23  law
// - new unit: vcmOperationableIdentifiedUserFriendly.
//
// Revision 1.4  2003/02/27 10:06:08  law
// - change: ������ � �������� �������� �������������.
//
// Revision 1.3  2003/02/27 09:51:44  law
// - new behavior: ������� ���������� �������� �������� � ����.
//
// Revision 1.2  2003/02/27 09:37:57  law
// - new behavior: � �������� �������� ��������� ��������.
//
// Revision 1.1  2003/02/27 07:57:37  law
// - new behavior: ������� ��������� ��������� ������.
//

{$I vcmDefine.inc }

interface

uses
  vcmUserControls,
  vcmInterfaces,

  vcmBase,
  vcmBaseOperationsCollection,
  vcmOperationableIdentifiedUserFriendly,
  vcmBaseEntitiesCollectionItem
  ;

type
  TvcmBaseEntityDef = class(TvcmOperationalIdentifiedUserFriendly, IvcmEntityDef)
   {* ������� ����� �������� ��������. }
    private
    // internal fields
      f_Entity   : TvcmBaseEntitiesCollectionItemPrim;
    protected
    // inteface methods
      // IvcmEntityDef
      function pm_GetOptions: TvcmEntityOperationsOptions;
        {-}
      function Get_ContextMenuWeight: Integer;
      function Get_ToolbarPos: TvcmToolbarPos;
        override;
        {-}
      procedure ClearOps;
        override;
        {-}
    public
    // public methods
      constructor Create(anEntity: TvcmBaseEntitiesCollectionItemPrim);
        reintroduce;
        {-}
      class function Make(anEntity: TvcmBaseEntitiesCollectionItemPrim): IvcmEntityDef;
        reintroduce;
        {* - ���������� ������� ��������� ��������. }
      property ContextMenuWeight: Integer
        read Get_ContextMenuWeight;
  end;//TvcmBaseEntityDef

implementation

uses
  SysUtils,

  afwFacade,
  
  vcmForm,
  vcmRepositoryEx,
  vcmOperationsDefIterator
  ;

// start class TvcmBaseEntityDef

constructor TvcmBaseEntityDef.Create(anEntity: TvcmBaseEntitiesCollectionItemPrim);
  //reintroduce;
  {-}
begin
 inherited Create(anEntity.EntityID,
                  anEntity.Name,
                  vcmCStr(anEntity.Caption),
                  vcmCStr(anEntity.Caption),
                  vcmCStr(anEntity.Caption),
                  //anEntity.Caption,
                  anEntity.ToolbarPos,
                  -1,
                  anEntity.Operations);
 f_Entity := anEntity;
end;

class function TvcmBaseEntityDef.Make(anEntity: TvcmBaseEntitiesCollectionItemPrim): IvcmEntityDef;
  {* - ���������� ������� ��������� ��������. }
var
 l_EntityDef : TvcmBaseEntityDef;
begin
 l_EntityDef := Create(anEntity);
 try
  Result := l_EntityDef;
 finally
  vcmFree(l_EntityDef);
 end;//try..finally
end;

function TvcmBaseEntityDef.pm_GetOptions: TvcmEntityOperationsOptions;
  {-}
begin
 if Assigned(f_Entity) then
  Result := f_Entity.Options
 else
  Result := [];
end;

function TvcmBaseEntityDef.Get_ContextMenuWeight: Integer;
begin
 if Assigned(f_Entity) then
  Result := f_Entity.ContextMenuWeight
 else
  Result := -1;
end;

function TvcmBaseEntityDef.Get_ToolbarPos: TvcmToolbarPos;
  //override;
  {-}
begin
 if (f_Entity = nil) then
  Result := inherited Get_ToolbarPos
 else
  Result := f_Entity.ToolbarPos;
end;

procedure TvcmBaseEntityDef.ClearOps;
  //override;
  {-}
begin
 inherited;
 f_Entity := nil;
end;

end.

