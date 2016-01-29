unit vcmEntitiesCollectionItemEntity;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmEntitiesCollectionItemEntity - }
{ �����: 11.03.2003 16:52 }
{ $Id: vcmEntitiesCollectionItemEntity.pas,v 1.9 2015/10/04 17:37:06 kostitsin Exp $ }

// $Log: vcmEntitiesCollectionItemEntity.pas,v $
// Revision 1.9  2015/10/04 17:37:06  kostitsin
// ������ TvcmBaseEntitiesCollectionItem
//
// Revision 1.8  2009/11/12 18:07:34  lulin
// - ������� �������� ������������ ��������.
//
// Revision 1.7  2009/02/20 17:29:20  lulin
// - ������ ������������.
//
// Revision 1.6  2009/02/20 16:45:38  lulin
// - <K>: 136941122.
//
// Revision 1.5  2009/02/20 15:19:00  lulin
// - <K>: 136941122.
//
// Revision 1.4  2003/11/19 11:38:25  law
// - new behavior: ������������ ��� �������� � �������� � MenuManager'� ��� ���������� ������������� ��������������. ���� �������������� ���� �� ��������.
//
// Revision 1.3  2003/07/07 18:00:14  demon
// - bug fix: ������������ ����������, � �� Release.
//
// Revision 1.2  2003/04/04 10:58:58  law
// - bug fix: ���� ������ � ����� ���� TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:44  law
// - ��������������� MVC � VCM.
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
// Revision 1.2  2003/03/11 15:34:30  law
// - new behavior: ������� ����������� ��������.
//
// Revision 1.1  2003/03/11 13:54:46  law
// - new unit: vcmEntitiesCollectionItemEntity.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,

  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  
  vcmControlEntity,
  vcmBaseEntitiesCollectionItem
  ;

type
  TvcmEntitiesCollectionItemEntity = class(TvcmControlEntity)
    private
    // internal fields
      f_Item : TvcmBaseEntitiesCollectionItemPrim;
    protected
    // interface methods
      function Get_ID: TvcmControlID;
        override;
        {* - ���������� ������������� ��������. }
    protected
    // internal methods
      procedure SelfOperation(const anOperationID : TvcmControlID;
                             aMode               : TvcmOperationMode;
                             const aParams       : IvcmParams);
        override;
        {* - ��������� �������� ��������. }
    public
    // public methods
      constructor Create(aControl : TComponent;
                         anItem   : TvcmBaseEntitiesCollectionItemPrim);
        reintroduce;
        {* - ������� ������. }
  end;//TvcmEntitiesCollectionItemEntity

  TvcmEntitiesCollectionItemTargetedEntity = class(TvcmEntitiesCollectionItemEntity)
    private
    // internal fields
      f_Target : IUnknown;
    protected
    // internal methods
      procedure SelfOperation(const anOperationID : TvcmControlID;
                             aMode               : TvcmOperationMode;
                             const aParams       : IvcmParams);
        override;
        {* - ��������� �������� ��������. }
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(aControl      : TComponent;
                         anItem        : TvcmBaseEntitiesCollectionItemPrim;
                         const aTarget : IUnknown);
        reintroduce;
        {* - ������� ������. }
  end;//TvcmEntitiesCollectionItemTargetedEntity

implementation

// start class TvcmEntitiesCollectionItemEntity

constructor TvcmEntitiesCollectionItemEntity.Create(aControl : TComponent;
                                                    anItem   : TvcmBaseEntitiesCollectionItemPrim);
  //reintroduce;
  {* - ������� ������. }
begin
 inherited Create(aControl);
 f_Item := anItem;
end;

function TvcmEntitiesCollectionItemEntity.Get_ID: TvcmControlID;
  //override;
  {-}
begin
 Result := f_Item.EntityID;
end;

procedure TvcmEntitiesCollectionItemEntity.SelfOperation(const anOperationID : TvcmControlID;
                                                        aMode               : TvcmOperationMode;
                                                        const aParams       : IvcmParams);
  //override;
  {* - ��������� �������� ��������. }
begin
 f_Item.Operation(Control, nil, anOperationID, aMode, aParams);
end;

// start class TvcmEntitiesCollectionItemTargetedEntity

constructor TvcmEntitiesCollectionItemTargetedEntity.Create(aControl      : TComponent;
                                                            anItem        : TvcmBaseEntitiesCollectionItemPrim;
                                                            const aTarget : IUnknown);
  //reintroduce;
  {* - ������� ������. }
begin
 inherited Create(aControl, anItem);
 f_Target := aTarget;
end;

procedure TvcmEntitiesCollectionItemTargetedEntity.Cleanup;
  //override;
  {-}
begin
 f_Target := nil;
 inherited;
end;

procedure TvcmEntitiesCollectionItemTargetedEntity.SelfOperation(const anOperationID : TvcmControlID;
                                                                aMode               : TvcmOperationMode;
                                                                const aParams       : IvcmParams);
  //override;
  {* - ��������� �������� ��������. }
begin
 f_Item.Operation(Control, f_Target, anOperationID, aMode, aParams);
end;

end.

