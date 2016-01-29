unit evdSegmentsLayerJoiner;

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evSegmentsLayerJoiner - }
{ �����: 16.03.2004 18:26 }
{ $Id: evdSegmentsLayerJoiner.pas,v 1.12 2014/04/21 11:45:05 lulin Exp $ }

// $Log: evdSegmentsLayerJoiner.pas,v $
// Revision 1.12  2014/04/21 11:45:05  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.11  2014/04/09 14:19:30  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.10  2014/04/09 13:12:10  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.9  2014/04/04 17:53:45  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.8  2014/03/25 11:53:35  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.7  2013/10/21 15:43:12  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.6  2013/10/21 10:31:00  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.5  2009/03/04 13:33:09  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.4  2008/02/19 11:05:55  lulin
// - ����������� ������ ������������ ������ � ������� ��������.
//
// Revision 1.3  2008/02/13 16:03:10  lulin
// - ������ ������� ������ ������ ������.
//
// Revision 1.2  2007/09/04 17:06:06  lulin
// - cleanup.
//
// Revision 1.1  2005/10/18 07:26:40  lulin
// - ������, ������������ ���� ��������� �������� � ����� �����.
//
// Revision 1.8.4.5  2005/10/18 07:19:40  lulin
// - new behavior: ������ ������ ������� � ���������� �������� ����� ����� ��������� ����������� ����.
//
// Revision 1.8.4.4  2005/06/23 13:42:52  lulin
// - ����� ��������� �������� � ����� K2.
//
// Revision 1.8.4.3  2005/06/22 17:53:03  lulin
// - ���� ������������� � ������������ � ��������� ����������.
//
// Revision 1.8.4.2  2005/06/22 17:34:09  lulin
// - ��������� ��������� � ������ ��������� � "����������" ����������.
//
// Revision 1.8.4.1  2005/05/18 12:42:47  lulin
// - ����� ����� �����.
//
// Revision 1.6.2.1  2005/04/28 09:18:30  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.7.2.1  2005/04/21 15:36:40  lulin
// - ������������ ��������� �� ������������� �������.
//
// Revision 1.7  2005/04/20 14:19:44  lulin
// - ������� ������ ��������� � ����.
//
// Revision 1.6  2005/03/28 11:32:08  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.5  2005/03/16 19:21:53  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.4  2005/03/04 13:59:17  lulin
// - remove method: Tk2AtomR._AddChild.
//
// Revision 1.3  2004/06/02 16:42:26  law
// - ������ ����� Tl3VList.
//
// Revision 1.2  2004/03/16 17:27:39  law
// - new behavior: ������ ���� ���������� ������-��������� ��������� � ���������� ���� ��������.
//
// Revision 1.1  2004/03/16 15:55:47  law
// - new units: evTextParaMultiSelectionBlock, evSegmentsLayerJoiner.
//

{$Include evdDefine.inc }

interface

uses
  l3Types,
  
  k2DocumentGenerator,
  k2DocumentBuffer
  ;

type
  TevdSegmentsLayerJoiner = class(Tk2DocumentBuffer)
    protected
    // internal methods
      function AddChild(var aChild: Tk2StackAtom): Long;
        override;
        {-}
  end;//TevdSegmentsLayerJoiner

implementation

uses
  l3Base,

  k2Interfaces,
  k2Tags,
  k2TagList,

  SegmentsLayer_Const
  ;

// start class TevdSegmentsLayerJoiner

function TevdSegmentsLayerJoiner.AddChild(var aChild: Tk2StackAtom): Long;
  //override;
  {-}
var
 l_Parent : PevStackAtom;
 l_Child  : Tl3Variant;
 l_Index  : Integer;
 l_Seg    : Tl3Variant;
begin
 Result := inherited AddChild(aChild);
 if aChild.IsKindOf(k2_typSegmentsLayer) then
 begin
  l_Parent := aChild.Parent;
  if (l_Parent <> nil) then
  begin
   if (Result < 0) then
    with (l_Parent^.Box.cAtom(k2_tiChildren).AsObject As Tk2TagList) do
     if not FindData(aChild.Box, Result, SortIndex) then
      Assert(false, '�� ����� ����!!!');
   // - ��� �������, ����� ���� ���-�� ������������
   l_Child := l_Parent^.Box.Child[Result];
   if not l_Child.IsSame(aChild.Box) then
   begin
    // - �� ����� ���� ���� �� �������� - ���� �������� ��� �����
    for l_Index := 0 to Pred(aChild.Box.ChildrenCount) do
    begin
     l_Seg := aChild.Box.Child[l_Index];
     l_Child.AddChild(l_Seg.AsObject);
    end;//for l_Index
   end;//not l_Child.EQ(aChild)
  end;//l_Parent <> nil
 end;//Result >= 0
end;
  
end.

