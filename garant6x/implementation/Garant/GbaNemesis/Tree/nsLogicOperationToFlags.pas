unit nsLogicOperationToFlags;

// $Id: nsLogicOperationToFlags.pas,v 1.1 2009/09/14 11:29:19 lulin Exp $

// $Log: nsLogicOperationToFlags.pas,v $
// Revision 1.1  2009/09/14 11:29:19  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.18  2009/07/31 17:30:07  lulin
// - ������� �����.
//
// Revision 1.17  2009/02/09 19:17:30  lulin
// - <K>: 133891247. �������� ���������� ������.
//
// Revision 1.16  2008/01/10 07:23:08  oman
// ������� �� ����� �������
//
// Revision 1.13.4.2  2007/12/04 11:19:15  mmorozov
// - MERGE WITH HEAD;
//
// Revision 1.13.4.1  2007/11/21 15:07:46  oman
// ������������ �� ����� �������
//
// Revision 1.15  2007/11/15 12:05:52  mmorozov
// - � ������ ������ ��� "�� ��������� � ���������� � ������" (CQ: OIT5-19586);
//
// Revision 1.14  2007/11/12 12:28:30  mmorozov
// - method was renamed;
//
// Revision 1.13  2007/05/25 14:25:13  lulin
// - ������� �������� �����.
//
// Revision 1.12  2006/04/20 08:53:53  oman
// - new beh: ������������� StdStr � _StdRes
//
// Revision 1.11  2006/03/22 08:41:54  oman
// - new beh: ������������� ��� ��������� ��������� � ��� ����� (StdStr, DebugStr � SystemStr)
//
// Revision 1.10  2004/09/17 13:25:33  am
// new: _GetLogicOpCount
//
// Revision 1.9  2004/07/28 08:06:59  am
// change: ���������� ��������� GblAdapter'� � DropExtraSelection
//
// Revision 1.8  2004/07/02 10:42:29  am
// change: ����� PureSetLogicOperation, �������� � public
//
// Revision 1.7  2004/06/28 13:36:09  am
// change: cSelectionFlag
//
// Revision 1.6  2004/06/23 13:44:44  am
// change: ������ ������ � DropExtraSelection
//
// Revision 1.5  2004/06/23 07:19:49  am
// new: DropSystemFlags - �������� ��������� ����� ������ (���������)
//
// Revision 1.4  2004/06/16 08:01:30  mmorozov
// - ��������� �����������;
//
// Revision 1.3  2004/06/16 08:00:23  mmorozov
// new: global procedure DropAllOperations;
//
// Revision 1.2  2004/06/15 11:04:08  am
// *** empty log message ***
//
// Revision 1.1  2004/06/15 11:02:17  am
// *** empty log message ***
//
// Revision 1.7  2004/06/02 05:55:51  demon
// - fix:  ����� ���������� �������� � ����� ��������� � ��� ��� � ������� ��� �����.
//
// Revision 1.6  2004/05/31 09:19:54  cyberz
// 1) ��������� INode -> INodeBase
// 2) �������� ���� ������ � plane_next_back
// 3) ���� ��� ���� ��������� ������
//
// Revision 1.5  2004/05/28 15:17:49  demon
// - new: ����� ��� ��������� ���������.
//
// Revision 1.4  2004/05/26 12:01:10  demon
// - new: ������� ���������� ���������� ����������� ���������� ����������.
//
// Revision 1.3  2004/05/25 08:39:16  demon
// - new behavior: ����� ���������� �������� ����������� � 3 ����, � �� � 2.
// - new: ��������� ����������� � �������� ��� ����������� ���������� ��������.
//
// Revision 1.2  2004/05/25 07:21:48  demon
// - new behavior: ����������� �������������� ������ � ��������� � ����� ���������� ���������.
//

interface

uses
 SysUtils,
 nsTypes,

 l3Tree,
 l3Tree_TLB,
 l3TreeInterfaces,

 DynamicTreeUnit,

 SearchDomainInterfaces
 ;

function SetLogicOperation(const aNode: INodeBase;
                           anOperation: TLogicOperation): Boolean;
function GetLogicOperation(const aNode: INodeBase): TLogicOperation;

function GetParentsOperation(const aNode: INodeBase): TLogicOperation;
function HasAnyChildOperation(const aNode: INodeBase): Boolean;

function GetOperationIterator(const aNode       : INodeBase;
                              const anOperation : TLogicOperation): INodeIterator;

procedure DropAllOperations(const aNode     : INodeBase;
                            const aNodeDrop : Boolean = False);
  {* - ���������� ����� �������� ��� ���� �������� ����� aNode.
       aNodeDrop - ����������� ����� �� ���������� ����� � aNode. }

procedure DropExtraSelection(const aRoot: INodeBase;
                             const aExceptNode: INodeBase);

procedure PureSetLogicOperation(const aNode       : INodeBase;
                                const anOperation : TLogicOperation);

implementation

uses
  bsConvert
  ;

procedure DropAllOperations(const aNode     : INodeBase;
                            const aNodeDrop : Boolean = False);
begin
 Assert(Assigned(aNode));
 with aNode do
 begin
  SetAllFlag(cOrBitFlag, False);
  SetAllFlag(cAndBitFlag, False);
  SetAllFlag(cNotBitFlag, False);
  if aNodeDrop then
  begin
   SetFlag(cOrBitFlag, False);
   SetFlag(cAndBitFlag, False);
   SetFlag(cNotBitFlag, False);
  end;
 end;
end;

procedure DropExtraSelection(const aRoot: INodeBase;
 const aExceptNode: INodeBase);
begin
 if aRoot <> nil then
 begin
  aRoot.SetAllFlag(FM_SELECTION, False);
  if aExceptNode <> nil then
   aExceptNode.SetFlag(FM_SELECTION, True);
 end;
end;

function ConvertFlagsToOneOperation(aOrBitFlag, anAndBitFlag, aNotBitFlag: Boolean): TLogicOperation;
begin
 if aNotBitFlag then
  Result := loNot
 else
  if anAndBitFlag then
   Result := loAnd
  else
   if aOrBitFlag then
    Result := loOr
   else
    Result := loNone;
end;

procedure PureSetLogicOperation(const aNode       : INodeBase;
                                const anOperation : TLogicOperation);
begin
 case anOperation of
  loNone : begin
            aNode.SetFlag(cOrBitFlag, False);
            aNode.SetFlag(cAndBitFlag, False);
            aNode.SetFlag(cNotBitFlag, False);
           end;
  loOr   : begin
            aNode.SetFlag(cOrBitFlag, True);
            aNode.SetFlag(cAndBitFlag, False);
            aNode.SetFlag(cNotBitFlag, False);
           end;
  loAnd  : begin
            aNode.SetFlag(cOrBitFlag, False);
            aNode.SetFlag(cAndBitFlag, True);
            aNode.SetFlag(cNotBitFlag, False);
           end;
  loNot  : begin
            aNode.SetFlag(cOrBitFlag, False);
            aNode.SetFlag(cAndBitFlag, False);
            aNode.SetFlag(cNotBitFlag, True);
           end;
 end;
end;

procedure DropLogicOperationForChildren(const aNode: INodeBase; anOperations: TLogicOperationSet);
var
 l_Operation: TLogicOperation;
begin
 if anOperations <> [] then
 begin
  for l_Operation := Low(TLogicOperation) to High(TLogicOperation) do
   if (l_Operation <> loNone) and
      (l_Operation in anOperations) then
    case l_Operation of
     loOr   : aNode.SetAllFlag(cOrBitFlag, False);
     loAnd  : aNode.SetAllFlag(cAndBitFlag, False);
     loNot  : aNode.SetAllFlag(cNotBitFlag, False);
    end;
 end;
end;

function SetLogicOperation(const aNode: INodeBase; anOperation: TLogicOperation): Boolean;
var
 l_ParentsOperation: TLogicOperation;
begin
 Result := False;

 if (anOperation <> loNone) then
 begin
  // �������� ������������ ��������
  l_ParentsOperation := GetParentsOperation(aNode);
  if l_ParentsOperation = loNot then
   exit
  else
   if (l_ParentsOperation <> loNone) and
      (anOperation <> loNot) then
    exit;

  // ����������� ������ � ����� ��������� ����
  if aNode.HasChildren then
   case anOperation of
    loOr,
    loAnd : DropLogicOperationForChildren(aNode, [loOr, loAnd]);
    loNot : DropLogicOperationForChildren(aNode, [loOr, loAnd, loNot]);
   end;
 end;

 // ����������� ����� � ��������� ����
 PureSetLogicOperation(aNode, anOperation);

 Result := True;
end;

function GetLogicOperation(const aNode: INodeBase): TLogicOperation;
var
 l_OrBitFlag,
 l_AndBitFlag,
 l_NotBitFlag: Boolean;
begin
 l_OrBitFlag := aNode.HasFlag(cOrBitFlag);
 l_AndBitFlag := aNode.HasFlag(cAndBitFlag);
 l_NotBitFlag := aNode.HasFlag(cNotBitFlag);
 Result := ConvertFlagsToOneOperation( l_OrBitFlag, l_AndBitFlag, l_NotBitFlag);
end;

function GetParentsOperation(const aNode: INodeBase): TLogicOperation;
var
 l_OrBitFlag,
 l_AndBitFlag,
 l_NotBitFlag: Boolean;
begin
 l_OrBitFlag := aNode.HasParentFlag(cOrBitFlag);
 l_AndBitFlag := aNode.HasParentFlag(cAndBitFlag);
 l_NotBitFlag := aNode.HasParentFlag(cNotBitFlag);
 Result := ConvertFlagsToOneOperation( l_OrBitFlag, l_AndBitFlag, l_NotBitFlag);
end;

function HasAnyChildOperation(const aNode: INodeBase): Boolean;
begin
 Result := aNode.HasChildrenFlag(cOrBitFlag) or
           aNode.HasChildrenFlag(cAndBitFlag) or
           aNode.HasChildrenFlag(cNotBitFlag);
end;

function GetOperationIterator(const aNode       : INodeBase;
                              const anOperation : TLogicOperation): INodeIterator;
begin
 aNode.IterateAllNodes(bsBusinessToAdapter(anOperation), Result);
end;//GetOperationIterator

end.
