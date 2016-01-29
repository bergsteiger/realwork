unit evNode;

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evNode -        }
{ �����: 26.08.1999 14:49 }
{ $Id: evNode.pas,v 1.15 2014/04/30 13:11:27 lulin Exp $ }

// $Log: evNode.pas,v $
// Revision 1.15  2014/04/30 13:11:27  lulin
// - ���������� �����������.
//
// Revision 1.14  2014/04/29 12:03:52  lulin
// - �������� �������� �����.
//
// Revision 1.13  2014/04/21 12:56:51  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.12  2014/04/10 13:09:45  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.11  2014/04/07 17:57:03  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.10  2014/04/04 17:53:38  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.9  2014/04/03 17:10:26  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.8  2014/03/28 12:15:27  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.7  2014/03/24 17:45:16  lulin
// - ���������� ������������.
//
// Revision 1.6  2014/03/18 15:57:02  lulin
// - ������������� ������ � ������.
//
// Revision 1.5  2014/03/14 13:27:28  lulin
// - ������� �������� ���������.
//
// Revision 1.4  2014/03/12 11:45:36  lulin
// - �������� �������� ������.
//
// Revision 1.3  2013/10/21 15:43:02  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.2  2013/10/21 10:30:46  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.1  2009/09/14 11:28:04  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.50  2009/07/20 16:44:04  lulin
// - ������� �� ��������� ��������� ���������� �������� ���� ����������� ����, ������ ����� "������" ��� ������ ��� ���� ���� ��� ������.
//
// Revision 1.49  2009/07/17 13:47:19  lulin
// - bug fix: ����������� ������������ �������� �������� �����.
//
// Revision 1.48  2009/07/15 15:12:22  lulin
// - ������� �������� �������� ������� ����������.
//
// Revision 1.47  2009/07/10 15:04:43  lulin
// - ����������� �� ������� ������� ��������� ������.
//
// Revision 1.46  2009/07/10 13:55:57  lulin
// - ����������� �� ������� ������������ ������.
//
// Revision 1.45  2009/07/10 13:03:27  lulin
// - ������ ����.
//
// Revision 1.44  2009/07/09 14:54:27  lulin
// {RequestLink:140837386}. �3.
//
// Revision 1.43  2009/07/07 08:58:23  lulin
// - �������� ��������.
//
// Revision 1.42  2009/06/25 12:57:30  lulin
// - �������� �������� ��������.
//
// Revision 1.41  2009/04/07 16:09:41  lulin
// [$140837386]. �13.
//
// Revision 1.40  2009/03/04 13:32:46  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.39  2009/02/26 10:21:19  lulin
// - <K>: 137465982. �1
//
// Revision 1.38  2009/02/25 17:43:43  lulin
// - <K>: 90441983. ��������� �� ������.
//
// Revision 1.37  2008/02/08 17:06:16  lulin
// - ����� _Tk2TagObject �������� �� ������.
//
// Revision 1.36  2007/12/13 14:31:30  lulin
// - ������� �������� ����.
//
// Revision 1.35  2007/12/04 12:47:03  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.32.4.6  2007/01/05 14:37:19  lulin
// - cleanup.
//
// Revision 1.32.4.5  2006/12/20 12:32:14  lulin
// - cleanup.
//
// Revision 1.32.4.4  2006/04/12 06:16:02  oman
// �� ��������������� - �� ������� k2Strings
//
// Revision 1.32.4.3  2005/11/18 13:26:24  lulin
// - � ��������� ����� ����������� ������ ����� �������� ����� ��������.
//
// Revision 1.32.4.2  2005/07/20 11:49:51  lulin
// - bug fix: ��� AV ��� ������� ��������� � Sub'� ����, ������� ��� ������� �� ���������.
//
// Revision 1.32.4.1  2005/05/18 12:42:47  lulin
// - ����� ����� �����.
//
// Revision 1.23.2.4  2005/05/18 12:32:09  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.23.2.3  2005/04/28 09:18:29  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.23.2.2  2005/04/15 08:21:35  lulin
// - ������ ������ ������ �� ���, � �� ���������� ���.
//
// Revision 1.23.2.1  2005/04/15 07:35:28  lulin
// - ������ ������ �� _Box, � �� �� ��� ���.
//
// Revision 1.31.2.2  2005/04/23 16:07:25  lulin
// - ������ ��������� ��������� _Ik2Tag.
//
// Revision 1.31.2.1  2005/04/21 15:36:40  lulin
// - ������������ ��������� �� ������������� �������.
//
// Revision 1.31  2005/04/21 05:27:02  lulin
// - � �������� ��������� ��������� � ���������� - ����� ������� ������/������� ����.
//
// Revision 1.30  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.29  2005/04/20 17:40:50  lulin
// - ��������� �� �������������� ���������� Ik2TagBoxQT.
//
// Revision 1.28  2005/04/20 16:09:43  lulin
// - ���������� ������.
//
// Revision 1.27  2005/04/20 15:16:43  lulin
// - new method: _Ik2Tag.rLong.
//
// Revision 1.26  2005/04/20 13:38:42  lulin
// - new method: _Ik2Tag.IsKindOf.
//
// Revision 1.25  2005/04/15 09:38:30  lulin
// - bug fix: �� �������������� ����������.
//
// Revision 1.24  2005/04/15 08:59:52  lulin
// - ������ ������ ������ �� ���, � �� ���������� ���.
//
// Revision 1.23.2.2  2005/04/15 08:21:35  lulin
// - ������ ������ ������ �� ���, � �� ���������� ���.
//
// Revision 1.23.2.1  2005/04/15 07:35:28  lulin
// - ������ ������ �� _Box, � �� �� ��� ���.
//
// Revision 1.32  2005/04/28 15:03:38  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.31.2.2  2005/04/23 16:07:25  lulin
// - ������ ��������� ��������� _Ik2Tag.
//
// Revision 1.31.2.1  2005/04/21 15:36:40  lulin
// - ������������ ��������� �� ������������� �������.
//
// Revision 1.31  2005/04/21 05:27:02  lulin
// - � �������� ��������� ��������� � ���������� - ����� ������� ������/������� ����.
//
// Revision 1.30  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.29  2005/04/20 17:40:50  lulin
// - ��������� �� �������������� ���������� Ik2TagBoxQT.
//
// Revision 1.28  2005/04/20 16:09:43  lulin
// - ���������� ������.
//
// Revision 1.27  2005/04/20 15:16:43  lulin
// - new method: _Ik2Tag.rLong.
//
// Revision 1.26  2005/04/20 13:38:42  lulin
// - new method: _Ik2Tag.IsKindOf.
//
// Revision 1.25  2005/04/15 09:38:30  lulin
// - bug fix: �� �������������� ����������.
//
// Revision 1.24  2005/04/15 08:59:52  lulin
// - ������ ������ ������ �� ���, � �� ���������� ���.
//
// Revision 1.23.2.2  2005/04/15 08:21:35  lulin
// - ������ ������ ������ �� ���, � �� ���������� ���.
//
// Revision 1.23.2.1  2005/04/15 07:35:28  lulin
// - ������ ������ �� _Box, � �� �� ��� ���.
//
// Revision 1.23  2005/03/28 11:32:07  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.22  2005/03/24 12:08:12  lulin
// - remove method: _Ik2Tag._Tag.
// - new method: _Ik2Tag._Target.
//
// Revision 1.21  2005/03/22 10:38:01  lulin
// - cleanup.
//
// Revision 1.20  2005/03/22 07:54:49  lulin
// - remove method: Tk2AtomR.AsIUnknown.
//
// Revision 1.19  2005/03/19 16:39:51  lulin
// - �������� �������� ������.
//
// Revision 1.18  2005/03/17 17:57:02  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.17  2004/09/20 12:42:50  lulin
// - ����������� - ����� ����������� ����� �������� � ���, ����� �������� �� (�� ������ ����������) ��������� � 3.5 ��� �� 2.6 ���.
//
// Revision 1.16  2004/08/05 16:58:17  law
// - new behavior: ��� �������� � ���������� ������ ����� ��������� ������� "����������" (CQ OIT5-8572).
// - ��������� �� ���� Warning'�� � Hint'��.
//
// Revision 1.15  2004/06/29 16:22:26  law
// - new method: _Ik2Tag.Owner.
//
// Revision 1.14  2004/06/29 16:13:14  law
// - bug fix: AV ��� ��������� ��������� � evNode.
//
// Revision 1.13  2004/06/29 16:01:34  law
// - bug fix: ������������ � ��������� ��������� � evNode.
//
// Revision 1.12  2003/11/05 16:57:36  law
// - new behavior: ��������� �������� � ���������� (������ ��� ���� ����, � ����� ���� ������ ���������� ��� ���������� �� ��������).
//
// Revision 1.11  2003/02/10 16:06:19  law
// - cleanup: ������� ��������� l3NodeActionL2FA - ���� ������ ��� ������������ l3L2NA.
//
// Revision 1.10  2002/09/02 12:59:49  law
// - new behavior: �������� �����/����� �� Del �� �������� ����.
//
// Revision 1.9  2001/06/27 11:59:29  law
// - cleanup: ������� ��������� safecall.
//
// Revision 1.8  2000/12/19 14:41:37  law
// - ��������� �������� �������� � ������������� ���������������� ������.
//
// Revision 1.7  2000/12/15 15:10:36  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3IID,
  l3Base,
  l3TreeInterfaces,
  l3Tree_TLB,
  l3Nodes,
  l3Variant,

  k2BaseTypes,
  k2Interfaces,
  k2InternalInterfaces,
  k2Base,
  k2InterfaceFactory
  ;

type
 _k2TagHolder_Parent_ = Tl3PlaceNode;
 {$Include k2TagHolder.imp.pas}
 TevCustomNodePrim = class(_k2TagHolder_)
 end;//TevCustomNodePrim

 _k2TagBox_Parent_ = TevCustomNodePrim;
 {$Include k2TagBox.imp.pas}
 TevCustomNode = class(_k2TagBox_, Il3HandleNode)
    protected
    // property methods
      function  pm_GetDocument: Tl3Variant;
        virtual;
        {-}
      function  Get_Handle: Integer;
      procedure Set_Handle(Value: Integer);
        {-}
    protected
    // internal methods
    public
    // public methods
      constructor Create(aTagWrap: Tl3Variant);
        reintroduce;
        {-}
      class function Make(aTagWrap: Tl3Variant): Il3Node;
        reintroduce;
        virtual;
        {-}
      class function IsCacheable: Bool;
        override;
        {-}
    public
    // public properties
      property Tag: Tl3Variant
        read GetRedirect;
        {-}
      property Document: Tl3Variant
        read pm_GetDocument;
        {-}  
  end;//TevCustomNode

function FindNodeByTag(const Parent : Il3Node;
                       Param  : Tl3Variant;
                       FindMode     : Byte = 0) : Il3Node;
  {-}

implementation

uses
  SysUtils,

  l3Const,
  l3Except,

  k2Tags,
  k2Strings,
  k2Facade,
  k2NullTagImpl,

  Document_Const
  ;

type _Instance_R_ = TevCustomNode;

{$Include k2TagHolder.imp.pas}

{$Include k2TagBox.imp.pas}  

function FindNodeByTag(const Parent : Il3Node;
                       Param  : Tl3Variant;
                       FindMode     : Byte = 0) : Il3Node;
  //overload;
  {-}

 function IterHandler(const CurNode : Il3Node) : Boolean;
  var
   l_TagWrap : Il3TagRef;
  begin//IterHandler
   if Supports(CurNode, Il3TagRef, l_TagWrap) then
    try
     Result := l_TagWrap.AsObject.IsSame(Param);
    finally
     l_TagWrap := nil;
    end{try..finally}
   else
    Result := false;
  end;//IterHandler

begin
 Result := Parent.IterateF(l3L2NA(@IterHandler), imCheckResult or FindMode);
end;

// start class TevCustomNode

constructor TevCustomNode.Create(aTagWrap: Tl3Variant);
  {reintroduce;}
  {-}
begin
 inherited Create;
 if (aTagWrap = nil) then
  Redirect := Tk2NullTagImpl.Instance
 else
  Redirect := aTagWrap.Box;
end;

class function TevCustomNode.Make(aTagWrap: Tl3Variant): Il3Node;
  {-}
var
 l_Node : TevCustomNode;
begin
 l_Node := Create(aTagWrap);
 try
  Result := l_Node;
 finally
  l3Free(l_Node);
 end;//try..finally
end;

class function TevCustomNode.IsCacheable: Bool;
  //override;
  {-}
begin
 Result := true;
end;

function TevCustomNode.pm_GetDocument: Tl3Variant;
  {-}
var
 l_Parent  : Il3Node;
 l_TagWrap : Il3TagRef;
 l_Tag     : Tl3Variant;
begin
 Result := k2NullTag;
 l_Parent := Self;
 while (l_Parent <> nil) do
 begin
  if l3IOk(l_Parent.QueryInterface(Il3TagRef, l_TagWrap)) then
   try
    if l_TagWrap.AsObject.IsKindOf(k2_typDocument) then
    begin
     Result := l_TagWrap.AsObject.Box;
     Exit;
    end;{k2_idDocument}
   finally
    l_TagWrap := nil;
   end;{try..finally}
  l_Parent := l_Parent.ParentNode;
 end;{l_Parent <> nil}
 l_Tag := Tag.AsObject;
 while l_Tag.IsValid do
 begin
  if l_Tag.IsKindOf(k2_typDocument) then
  begin
   Result := l_Tag.Box;
   Exit;
  end;{k2_idDocument}
  l_Tag := l_Tag.Owner;
 end;//while l_Tag.IsValid
end;

function TevCustomNode.Get_Handle: Integer;
  {-}
begin
 Result := Tag.IntA[k2_tiHandle];
end;

procedure TevCustomNode.Set_Handle(Value: Integer);
  {-}
begin
end;

end.

