unit eeVirtualNode;
{* ������� ���������� ������������ ���� ������. }

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: eeVirtualNode - }
{ �����: 29.05.2003 19:28 }
{ $Id: eeVirtualNode.pas,v 1.5 2015/01/25 17:43:27 kostitsin Exp $ }

// $Log: eeVirtualNode.pas,v $
// Revision 1.5  2015/01/25 17:43:27  kostitsin
// ������ TeeNode
//
// Revision 1.4  2014/12/05 14:51:03  kostitsin
// {requestlink: 570118718 } - eeInterfaces
//
// Revision 1.3  2014/04/03 17:10:31  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.2  2012/11/01 07:10:30  lulin
// - �������� �����.
//
// Revision 1.1  2010/04/21 16:52:40  lulin
// {RequestLink:144575972}.
// - ��������� � ���������� ����� ��� ���������� ������.
//
// Revision 1.2  2009/10/20 17:59:26  lulin
// {RequestLink:159360578}. �4.
//
// Revision 1.54  2009/10/20 17:55:59  lulin
// {RequestLink:159360578}. �4.
//
// Revision 1.52  2009/07/20 11:21:58  lulin
// - ���������� �������� F1 ����� - {RequestLink:141264340}. �7, 32, 33.
//
// Revision 1.51  2008/04/07 06:18:39  lulin
// - cleanup.
//
// Revision 1.50  2008/03/20 09:48:12  lulin
// - cleanup.
//
// Revision 1.49  2007/12/04 12:47:34  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.48.24.8  2007/03/20 13:58:40  lulin
// - ����������� �� ������ �������������� �����.
//
// Revision 1.48.24.7  2007/02/16 17:54:08  lulin
// - ����������� �� ������������ ���������� ����.
//
// Revision 1.48.24.6  2006/12/22 15:06:32  lulin
// - ����� ���� - ������ ��������� � ������ � ������� ���������.
//
// Revision 1.48.24.5  2005/07/28 15:37:08  lulin
// - ������ � ������������ � ����������� ������ � ����������� �������������.
//
// Revision 1.48.24.4  2005/07/21 14:56:12  lulin
// - ������� ����� ����������� ���, ���������� �������.
//
// Revision 1.48.24.3  2005/07/21 14:47:33  lulin
// - ������� ����������� ���� �������� � ��������� ������.
//
// Revision 1.48.24.2  2005/07/21 14:16:38  lulin
// - ���������� ��� ����������� ��������� � ������ ������� �����������.
//
// Revision 1.48.24.1  2005/07/15 10:14:06  lulin
// - ����������� �� ������������� ����������� ������� �������������� �����������.
//
// Revision 1.48  2004/06/22 12:56:04  law
// - ����� ����� Set_AllChildrenCount, �.�. �� ������ ���������� � ������������ ������.
//
// Revision 1.47  2004/06/21 16:12:40  law
// - bug fix: � ������ Tl3CustomVirtualNode ��� ����������� ����� Set_AllChildrenCount.
//
// Revision 1.46  2004/06/21 15:44:22  law
// - � Tl3CustomVirtualNode.ReleaseChilds �������� Assert, �.�. ��� ��� ����� ���������.
//
// Revision 1.45  2004/06/03 17:29:13  law
// - ������ � ����� � ���������� ���������� Il3Base.
//
// Revision 1.44  2004/06/01 14:56:28  law
// - ������� ������������ Tl3VList.MakeLongint, MakeLongintSorted - ����������� _Tl3LongintList.
//
// Revision 1.43  2004/05/27 14:31:59  law
// - new methods: _Tl3_CBase.IsCacheable, _NeedStoreInPool.
//
// Revision 1.42  2004/05/27 08:59:10  law
// - change: ��������� �� ������� ������ IsMyIntf - ������ ��� ������ ������ ������������ IsSame.
//
// Revision 1.41  2004/05/26 18:17:19  law
// - change: Il3Node ������ ����������� �� Il3SimpleNode.
//
// Revision 1.40  2004/05/26 14:21:59  law
// - change: ������� "��� � ����" (������ ������� � ������).
//
// Revision 1.39  2004/04/27 07:25:31  law
// - remove prop: IeeNode.Expanded.
// - cleanup: �� TeeNode ������ ������ ��� _Tl3Tree.
//
// Revision 1.38  2004/04/13 13:29:39  law
// - cleanup: ������ ������ ���������� ����� As � Il3Node.
//
// Revision 1.37  2004/04/13 08:49:48  demon
// - optimise: �������� Iterate - �� ���������� IsMyIntf, ���� aFromNode = nil
//
// Revision 1.36  2004/04/08 19:19:41  law
// - optimization: ������ ��������� stdcall.
//
// Revision 1.35  2004/04/02 10:54:51  demon
// - new: �������� GetLevelForParent �������� �� ��������� IeeNode
//
// Revision 1.34  2004/02/13 10:05:23  law
// - bug fix: � Cleanup �� ��������� ����� ����.
//
// Revision 1.33  2004/01/30 18:23:37  demon
// - cleanup: ������� ���������� SortChilds (��������� �� TnsBaseNode)
// - new: �� ��������� IeeNode ��������� ������� Move, RelocateChild, SortChilds.
//
// Revision 1.32  2004/01/30 11:39:51  demon
// - cleanup: ������� �������������� ������� _InsertChild(�� �����)
// - new: ��������� ������� InsertChildBefore
//
// Revision 1.31  2003/12/27 16:39:02  law
// - new behavior: �� ���������� ������ ��� ������� ����.
//
// Revision 1.30  2003/12/11 19:01:08  law
// - cleanup: ����� ������� � AllChildrenCount � ThisChildrenCount.
//
// Revision 1.29  2003/12/11 12:50:11  law
// - rename: ��� ���������� ChildsCount ������������� � AllChildrenCount.
//
// Revision 1.28  2003/12/10 09:14:07  law
// - new method: Il3InternalNode.Set_NextNodePrim.
//
// Revision 1.27  2003/11/05 16:32:01  law
// - new prop: IeeNode.IsFirst, IsLast.
//
// Revision 1.26  2003/08/21 15:10:14  demon
// - new: � ��������� IeeNode �������� �������� PrevNode � NextNode
//
// Revision 1.25  2003/07/28 11:56:54  law
// - new methods: IeeNode.Iterate, IterateF.
//
// Revision 1.24  2003/07/28 09:50:34  demon
// - bug fix : ����������� ������� �������� ��� ������������� Result
//
// Revision 1.23  2003/07/15 13:44:48  law
// - new prop: IeeNode.ParentNode.
//
// Revision 1.22  2003/07/09 11:29:08  demon
// - bug fix: ��� AV ��� �������� ����������� �� ���� (�. �. ���� ������������ ������ ����������).
//
// Revision 1.21  2003/07/04 15:28:39  demon
// - fix: ��������� ������ �������� �����������.
//
// Revision 1.20  2003/07/02 17:27:36  law
// - bug fix: ����������� �������� ������� ������ (TnsListChild). �������� ��������, �� ����� �� ������� �������.
//
// Revision 1.19  2003/07/01 18:08:11  law
// - new prop: TeeNode.ChildNode.
//
// Revision 1.18  2003/06/25 09:22:31  law
// - change: ParentNodeClass, ChildNodeClass � �������� ������� ��������� �����������, � �� �������.
//
// Revision 1.17  2003/06/21 12:29:25  law
// - new method: IeeNode.Delete.
//
// Revision 1.16  2003/06/11 13:00:46  law
// - new behavior: �������� �������� ������� NumInParent - ������ ����� ������� ��������, ����� ��� NumInParent ��� �����������.
//
// Revision 1.15  2003/06/04 14:39:20  demon
// - bug fix: ����������� ������������ ��������� ����.
//
// Revision 1.14  2003/06/03 16:45:07  demon
// - bug fix: �������������� ������ �� ������������ ����� (Tl3Node).
//
// Revision 1.13  2003/06/03 14:27:50  demon
// - new method: IeeNode.IsSameNode.
//
// Revision 1.12  2003/06/03 08:21:21  law
// - new prop: IeeNode.HasChild.
//
// Revision 1.11  2003/06/02 15:25:22  law
// - cleanup: ����� ������������� ����������� ��������� ����������� const.
//
// Revision 1.10  2003/05/30 17:24:48  law
// - change: ������ l3*Flag ������������� � l3*Mask.
//
// Revision 1.9  2003/05/30 17:11:21  law
// - new behavior: ������ ���������� �������� Parent - �.�. ����������� ���� ��� �� � ����.
//
// Revision 1.8  2003/05/30 17:07:48  law
// - cleanup.
//
// Revision 1.7  2003/05/30 14:26:23  law
// - bug fix.
//
// Revision 1.6  2003/05/30 14:25:25  law
// - new behavior: ���������� ����� Tl3CustomVirtualNode.Get_ChildsCount.
//
// Revision 1.5  2003/05/30 12:26:36  law
// - new class: Tl3CustomVirtualNode.
//
// Revision 1.4  2003/05/29 16:50:39  law
// - new behavior: TeeVirtualNode ������ ���� ������ ������������ ���� (Parent).
//
// Revision 1.3  2003/05/29 16:42:43  law
// - new behavior: TeeVirtualNode ������ ���� ������ �����.
//
// Revision 1.2  2003/05/29 16:22:26  law
// - new behavior: TeeVirtualNode ������ ������������ ��������� IeeNode.
//
// Revision 1.1  2003/05/29 15:57:17  law
// - new unit: eeVirtualNode.
//

{$Include evDefine.inc }

interface

uses
  Windows,

  l3Interfaces,
  l3Types,
  l3TreeInterfaces,
  l3Tree_TLB,
  l3Base,
  l3Nodes,
  l3VirtualNode,

  eeInterfaces
  ;

type
  TeeVirtualNode = class(Tl3VirtualFlagsNode, IeeNode)
   {* ������� ���������� ������������ ���� ������. }
    private
    // interface methods
      // IeeNode
      function  IeeNode_Get_Text: Il3CString;
      procedure IeeNode_Set_Text(const aValue: Il3CString);
        {-}
      function  IeeNode_Get_ID: Integer;
      procedure IeeNode_Set_ID(aValue: Integer);
        {-}
      function  IeeNode_Get_HasChild: Boolean;
        {-}
      function  IeeNode_Get_ChildNode: IeeNode;
        {-}
      function  IeeNode_Get_ParentNode: IeeNode;
        {-}
      function  IeeNode_Get_NextNode: IeeNode;
        {-}
      function  IeeNode_Get_PrevNode: IeeNode;
        {-}
      function  Get_IsFirst: Boolean;
        {-}
      function  Get_IsLast: Boolean;
        {-}
      function  IeeNode_InsertChild(const aNode: IeeNode): IeeNode;
        {-}
      function  IeeNode_InsertChildBefore(const aNextChild: IeeNode; const aChild: IeeNode): IeeNode;
        {-}
      procedure IeeNode_Changing;
        {-}
      procedure IeeNode_Changed;
        {-}
      procedure IeeNode_Remove;
        {* - ������� ���� �� ������. }
      procedure IeeNode_Delete;
        {* - ������� ���� �� ������. }
      procedure IeeNode_RemoveChildren;
        {* - ���������� �������� ����. }
      function  IeeNode_Move(aDirection : TeeDirection) : Boolean;
        {* - ����������� ����. }
      procedure RelocateChild(const aChild: IeeNode);
        {* - ���������� ���������� �������, �������������� ����������
             ���������� ������������ ������ ����� (� �������� ������ ������)}
      procedure IeeNode_SortChilds;
        {* - ����������������� ���� ����� (���� �������)}
      function  IeeNode_IsSameNode(const aNode: IeeNode): Boolean;
        {-}
      function  IeeNode_GetLevelForParent(const aParent: IeeNode): Integer;
        {* ������������ �������������� ���� ������������ ��������� Paretnt'� }
      function  IeeNode_Iterate(Action          : TeeNodeAction;
                                IterMode        : Integer = 0;
                                const aFromNode : IeeNode = nil) : IeeNode;
       {* - ��������� ��� �������� ����. IterMode ��. imExpandOnly etc. }
      function  IeeNode_IterateF(Action          : TeeNodeAction;
                                 IterMode        : Integer = 0;
                                 const aFromNode : IeeNode = nil) : IeeNode;
       {* - ��������� ��� �������� ���� � ���������� �������� ��� Action. }
      function  IeeNode.Get_Text = IeeNode_Get_Text;
      procedure IeeNode.Set_Text = IeeNode_Set_Text;
      function  IeeNode.Get_ID = IeeNode_Get_ID;
      procedure IeeNode.Set_ID = IeeNode_Set_ID;
      procedure IeeNode.Changing = IeeNode_Changing;
      procedure IeeNode.Changed = IeeNode_Changed;
      procedure IeeNode.Remove = IeeNode_Remove;
      procedure IeeNode.Delete = IeeNode_Delete;
      procedure IeeNode.RemoveChildren = IeeNode_RemoveChildren;
      function  IeeNode.Move = IeeNode_Move;
      function  IeeNode.Get_HasChild = IeeNode_Get_HasChild;
      function  IeeNode.Get_ChildNode = IeeNode_Get_ChildNode;
      function  IeeNode.Get_ParentNode = IeeNode_Get_ParentNode;
      function  IeeNode.Get_NextNode = IeeNode_Get_NextNode;
      function  IeeNode.Get_PrevNode = IeeNode_Get_PrevNode;
      function  IeeNode.InsertChild = IeeNode_InsertChild;
      function  IeeNode.InsertChildBefore = IeeNode_InsertChildBefore;
      procedure IeeNode.SortChilds = IeeNode_SortChilds;
      function  IeeNode.IsSameNode = IeeNode_IsSameNode;
      function  IeeNode.GetLevelForParent = IeeNode_GetLevelForParent;
      function  IeeNode.Iterate = IeeNode_Iterate;
      function  IeeNode.IterateF = IeeNode_IterateF;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
  end;//TeeVirtualNode

implementation

uses
  SysUtils,
  
  l3Bits,
  l3InterfacesMisc,
  l3String,

  eeNode,
  eeNodeUtils
  ;

// start class TeeVirtualNode  

procedure TeeVirtualNode.Cleanup;
  //override;
  {-}
begin
 Set_ParentNode(nil);
 inherited;
end;

function TeeVirtualNode.IeeNode_Get_Text: Il3CString;
  {-}
begin
 Result := l3CStr(Self);
end;

procedure TeeVirtualNode.IeeNode_Set_Text(const aValue: Il3CString);
  {-}
begin
 Set_Text(l3PCharLen(aValue));
end;

function TeeVirtualNode.IeeNode_Get_ID: Integer;
  {-}
var
 l_HandleNode : Il3HandleNode;
begin
 if Supports(Self, Il3HandleNode, l_HandleNode) then
  try
   Result := l_HandleNode.Handle;
  finally
   l_HandleNode := nil;
  end//try..finally
 else
  Result := 0;
end;

procedure TeeVirtualNode.IeeNode_Set_ID(aValue: Integer);
  {-}
var
 l_HandleNode : Il3HandleNode;
begin
 if Supports(Self, Il3HandleNode, l_HandleNode) then
  try
   l_HandleNode.Handle := aValue;
  finally
   l_HandleNode := nil;
  end;//try..finally
end;

function TeeVirtualNode.IeeNode_Get_HasChild: Boolean;
  {-}
begin
 Result := HasChild;
end;

function TeeVirtualNode.IeeNode_Get_ChildNode: IeeNode;
  {-}
begin
 Result := TeeNode.Make(ChildNode);
end;

function TeeVirtualNode.IeeNode_Get_ParentNode: IeeNode;
  {-}
begin
 Result := TeeNode.Make(ParentNode);
end;

function TeeVirtualNode.IeeNode_Get_NextNode: IeeNode;
  {-}
begin
 Result := TeeNode.Make(NextNode);
end;

function TeeVirtualNode.IeeNode_Get_PrevNode: IeeNode;
  {-}
begin
 Result := TeeNode.Make(PrevNode);
end;

function TeeVirtualNode.Get_IsFirst: Boolean;
  {-}
begin
 Result := IsFirst;
end;

function TeeVirtualNode.Get_IsLast: Boolean;
  {-}
begin
 Result := IsLast;
end;

function TeeVirtualNode.IeeNode_InsertChild(const aNode: IeeNode): IeeNode;
  //overload;
  {-}
var
 l_Node : Il3Node;
begin
 if Supports(aNode, Il3Node, l_Node) then begin
  Result := aNode;
  InsertChild(l_Node);
 end else
  Result := nil;
end;

function TeeVirtualNode.IeeNode_InsertChildBefore(const aNextChild: IeeNode;
                                                  const aChild: IeeNode): IeeNode;
  //overload;
  {-}
var
 l_Child,
 l_NextChild : Il3Node;
begin
 if Supports(aChild, Il3Node, l_Child) and
    Supports(aNextChild, Il3Node, l_NextChild) then
 begin
  Result := aChild;
  InsertChildBefore(l_NextChild, l_Child);
 end
 else
  Result := nil;
end;

procedure TeeVirtualNode.IeeNode_Changing;
  {-}
begin
 Changing;
end;

procedure TeeVirtualNode.IeeNode_Changed;
  {-}
begin
 Changed;
end;

procedure TeeVirtualNode.IeeNode_Remove;
  {* - ������� ���� �� ������. }
begin
 Remove;
end;

procedure TeeVirtualNode.IeeNode_Delete;
  {* - ������� ���� �� ������. }
begin
 Delete;
end;

procedure TeeVirtualNode.IeeNode_RemoveChildren;
  {* - ���������� �������� ����. }
begin
 ReleaseChilds;
end;

function TeeVirtualNode.IeeNode_Move(aDirection : TeeDirection) : Boolean;
  //overload;
  {* - ����������� ����. }
begin
 Result := Move(eeDirection2l3Direction(aDirection));
end;

procedure TeeVirtualNode.RelocateChild(const aChild: IeeNode);
  {* - ���������� ���������� �������, �������������� ����������
       ���������� ������������ ������ ����� (� �������� ������ ������)}
var
 l_Child : Il3Node;
begin
 if Supports(aChild, Il3Node, l_Child) then
  try
   SortChilds(l_Child);
  finally
   l_Child := nil;
  end;//try..finally
end;

procedure TeeVirtualNode.IeeNode_SortChilds;
  {* - ����������������� ���� ����� (���� �������)}
begin
 SortChilds(nil);
end;

function TeeVirtualNode.IeeNode_IsSameNode(const aNode: IeeNode): Boolean;
  {-}
var
 l_Node : Il3Node;
begin
 Result := l3IEQ(Self, aNode);
 if not Result then
 begin
  if Supports(aNode, Il3Node, l_Node) then
   try
    Result := IsSame(l_Node);
   finally
    l_Node := nil;
   end;//try..finally
 end;//not Result
end;

function TeeVirtualNode.IeeNode_GetLevelForParent(const aParent: IeeNode): Integer;
 {* ������������ �������������� ���� ������������ ��������� Paretnt'� }
var
 l_Parent : Il3Node;
begin
 if Supports(aParent, Il3Node, l_Parent) then
  try
   Result := GetLevelForParent(l_Parent);
  finally
   l_Parent := nil;
  end
 else
  Result := -1;
end;

function TeeVirtualNode.IeeNode_Iterate(Action          : TeeNodeAction;
                                        IterMode        : Integer = 0;
                                        const aFromNode : IeeNode = nil) : IeeNode;
 {* - ��������� ��� �������� ����. IterMode ��. imExpandOnly etc. }

 function l_CheckNode(const aNode: Il3Node): Boolean;
 begin
  Result := Action(TeeNode.Make(aNode));
 end;

var
 l_FromNode : Il3Node;
begin
 Supports(aFromNode, Il3Node, l_FromNode);
 Result := TeeNode.Make(IterateF(l3L2NA(@l_CheckNode), IterMode, l_FromNode));
end;

function TeeVirtualNode.IeeNode_IterateF(Action          : TeeNodeAction;
                                         IterMode        : Integer = 0;
                                         const aFromNode : IeeNode = nil) : IeeNode;
 {* - ��������� ��� �������� ���� � ���������� �������� ��� Action. }
begin
 try
  Result := IeeNode_Iterate(Action, IterMode, aFromNode);
 finally
  l3FreeFA(Tl3FreeAction(Action));
 end;//try..finally
end;

end.
