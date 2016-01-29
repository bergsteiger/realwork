unit bsFrozenNode;

{------------------------------------------------------------------------------}
{ ���������� : ������ ���� ������� "�������";                                  }
{ �����      : ������� �.�.                                                    }
{ �����      : 12.12.2005 16.48;                                               }
{ ������     : bsFrozenNode                                                    }
{ ��������   : ������ ������������ ��� ������ � ������������� ������;          }
{------------------------------------------------------------------------------}

// $Id: bsFrozenNode.pas,v 1.2 2009/12/04 11:53:08 lulin Exp $
// $Log: bsFrozenNode.pas,v $
// Revision 1.2  2009/12/04 11:53:08  lulin
// - ��������� �� ������ � �������� ������������.
//
// Revision 1.1  2009/09/14 11:28:58  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.15  2008/12/25 12:19:30  lulin
// - <K>: 121153186.
//
// Revision 1.14  2008/12/24 19:49:12  lulin
// - <K>: 121153186.
//
// Revision 1.13  2008/12/04 14:58:41  lulin
// - <K>: 121153186.
//
// Revision 1.12  2008/04/01 05:52:33  oman
// warning fix
//
// Revision 1.11  2008/03/25 08:33:01  mmorozov
// - bugfix: ��� ��������� �������� �� �������������� ������� � ����������������� ��� (CQ: OIT5-28504);
//
// Revision 1.10  2008/01/21 07:18:36  mmorozov
// - new: ������ � ����������������� �������� �� �������� � �� ��������� ���������� �� sdsDocInfo, ����� ���� ��������� ��� ������ � ��������� + ������������� ����������� (� ������ ������ ��� CQ: OIT5-17587);
//
// Revision 1.9  2008/01/10 07:23:00  oman
// ������� �� ����� �������
//
// Revision 1.8.4.1  2007/11/21 10:26:15  oman
// ������������ �� ����� �������
//
// Revision 1.8  2007/09/25 13:47:17  oman
// - new: ������ ��� ������ ���� (cq26792)
//
// Revision 1.7  2007/02/09 12:37:43  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.6  2007/01/22 12:55:00  lulin
// - ����������� �� ������������ �����.
//
// Revision 1.5  2007/01/22 12:22:55  lulin
// - ��������� �� ����� ���������� ������.
//
// Revision 1.4  2006/11/03 09:45:31  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.3.12.1  2006/10/31 16:18:55  oman
// - fix: ��� ���������� �� ����� �� ���� (cq23213)
//
// Revision 1.3  2005/12/23 13:25:23  mmorozov
// - bugfix: ��� ���������� ���� ���� ����\���� �� �����;
//
// Revision 1.2  2005/12/13 09:45:05  mmorozov
// - bugfix: ������������ ���� ����� ���������� �����������;
// - new behaviour: ��� ���������� ������� ������������ �������� ������ ��� ������ ����, ���� �� ������, �� ������������ ����������� ������ ����\����, �.�. �� �������� �� ������ ������ ��� ������ ����;
//
// Revision 1.1  2005/12/13 08:51:07  mmorozov
// - new: ������������� ������������ ����� ��� ������ � ����\���� ��� ������� ������� ��������� � �����������;
//

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  l3Types,
  
  DynamicTreeUnit,
  
  bsBase,
  bsInterfaces
  ;

type
  TbsFrozenNode = class(TbsBase, IbsFrozenNode)
  {* ������� ����� ��� ������ � ������������� ������. }
  protected
  // protected fields
    f_Value: INodeBase;
  protected
  // protected methods
    procedure Cleanup;
      override;
      {-}
    function DefreezeNode: INodeBase;
      virtual;
      {* - ����������� ����. }
  protected
  // IbsFrozenNode
    function pm_GetValue: INodeBase;
    procedure pm_SetValue(const aValue: INodeBase);
      {-}
    function pm_GetHasNode: Boolean;
      {* - ���������� ����������� �� ��������. }
    function pm_GetCaption: Tl3PCharLen;
      {* - ��������� ������������ ����. }
    function IsSame(const aValue: IbsFrozenNode): Boolean;
      {* - ��������� �� ���������. }
    procedure IbsFrozenNode.Assign = IbsFrozenNode_Assign;
    procedure IbsFrozenNode_Assign(const aValue: IbsFrozenNode);
      {* - ����������� ������. }
  protected
  // properties
    property Value: INodeBase
      read pm_GetValue
      write pm_SetValue;
      {* - �������� ��������, ������� ��������������� ��� ���������. }
    property HasNode: Boolean
      read pm_GetHasNode;
      {* - ���������� ����������� �� ��������. }
    property Caption: Tl3PCharLen
      read pm_GetCaption;
      {* - ��������� ������������ ����. }
  public
  // public methods
    constructor Create(const aValue: INodeBase = nil);
      reintroduce;
      {-}
    class function Make(const aValue: INodeBase = nil): IbsFrozenNode;
      {-}
  end;//TbsFrozenNode

  TbsCRTypeFrozen = class(TbsFrozenNode)
  {* ��� ������ � ������������ ����� ����\����. }
  protected
  // IbsFrozenNode
    function DefreezeNode: INodeBase;
      override;
      {-}
  end;//TbsCRTypeFrozen
{$IfEnd}  

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3String,
  
  vcmBase,

  bsUtils,

  DataAdapter,

  nsTreeStruct,
  nsTreeUtils,
  nsNodes
  ;

{ TbsFrozenNode }

constructor TbsFrozenNode.Create(const aValue: INodeBase);
  // reintroduce;
  {-}
begin
 inherited Create;
 pm_SetValue(aValue);
end;

class function TbsFrozenNode.Make(const aValue: INodeBase): IbsFrozenNode;
var
 l_Class: TbsFrozenNode;
begin
 l_Class := Create(aValue);
 try
  Result := l_Class;
 finally
  vcmFree(l_Class);
 end;{try..finally}
end;//Make

procedure TbsFrozenNode.Cleanup;
  // override;
  {-}
begin
 f_Value := nil;
 inherited;
end;//Cleanup

function TbsFrozenNode.pm_GetHasNode: Boolean;
  {* - ���������� ����������� �� ��������. }
begin
 Result := Assigned(f_Value) and (DefreezeNode <> nil);
end;

function TbsFrozenNode.pm_GetValue: INodeBase;
  {-}
begin
 // ������������� ����
 Result := DefreezeNode;
end;//pm_GetValue

procedure TbsFrozenNode.pm_SetValue(const aValue: INodeBase);
  {-}
begin
 f_Value := nil;
 if Assigned(aValue) then
  aValue.GetFrozenNode(f_Value);
end;

function TbsFrozenNode.DefreezeNode: INodeBase;
  // virtual;
  {* - ����������� ����. }
begin
 Result := f_Value;
end;

procedure TbsFrozenNode.IbsFrozenNode_Assign(const aValue: IbsFrozenNode);
  {* - ����������� ������. }
begin
 Value := aValue.Value;
end;

function TbsFrozenNode.IsSame(const aValue: IbsFrozenNode): Boolean;
  {* - ��������� �� ���������. }
begin
 Result := (aValue <> nil) and (HasNode = aValue.HasNode);
 if Result and HasNode then
  Result := Value.IsSameNode(aValue.Value);
end;//IsSame

function TbsFrozenNode.pm_GetCaption: Tl3PCharLen;
begin
 if (f_Value <> nil) then
  Tl3WString(Result) := nsGetCaption(f_Value).AsWStr
 else
  l3AssignNil(Result);
end;

{ TbsCRTypeFrozen }

function TbsCRTypeFrozen.DefreezeNode: INodeBase;
  // override;
var
 l_Cap : Tl3PCharLen;  
begin//DefrozeCRType
 Result := nil;
 if Assigned(f_Value) then
 begin
  l_Cap := pm_GetCaption;
  // �� �� ����� �� ������ ������ ��� ������ ����, ���� ������� � �������
  // ������ (���������� ������ �����)
  Result := bsFindNodeByCaption(DefDataAdapter.CRSimpleListTypeRootNode, l_Cap);
 end;//if Assigned(aType) then
end;//DefreezeNode
{$IfEnd}

end.
