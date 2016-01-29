unit evTableRowHotSpot;
{* ���������� ����������� IevHotSpotTester � IevHotSpot ��� ������ �������. }

{ ���������� "�������"        }
{ �����: ����� �.�. �         }
{ ������: evTableRowHotSpot - }
{ �����: 01.11.2000 13:15 }
{ $Id: evTableRowHotSpot.pas,v 1.72 2015/01/19 18:36:36 lulin Exp $ }

// $Log: evTableRowHotSpot.pas,v $
// Revision 1.72  2015/01/19 18:36:36  lulin
// {RequestLink:580710025}
//
// Revision 1.71  2014/04/29 13:38:51  lulin
// - �������� �������� �����������.
//
// Revision 1.70  2014/04/21 11:45:00  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.69  2014/04/07 17:56:59  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.68  2013/10/25 10:52:41  morozov
// {RequestLink: 254939874}
//
// Revision 1.67  2013/10/21 15:42:58  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.66  2013/10/21 10:30:41  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.65  2013/04/24 09:35:36  lulin
// - ���������.
//
// Revision 1.64  2011/11/29 13:46:26  dinishev
// {Requestlink:109904163}
//
// Revision 1.63  2011/11/25 12:20:42  dinishev
// {Requestlink:109904163}. ����� ������� ��� ���������� ������. ;-)
//
// Revision 1.62  2011/09/13 10:48:06  lulin
// {RequestLink:278839709}.
//
// Revision 1.61  2011/02/22 19:41:04  lulin
// {RequestLink:182157315}.
//
// Revision 1.60  2011/02/15 11:24:49  lulin
// {RequestLink:231670346}.
//
// Revision 1.59  2010/06/24 15:16:27  lulin
// {RequestLink:219125149}.
// - �������� ������������� ����, ���� ���� �� ��� �������.
//
// Revision 1.58  2010/04/08 08:11:16  dinishev
// [$201490621]
//
// Revision 1.57  2010/04/06 09:20:42  dinishev
// ����� ��� ������ [$201490621]. ��-�� ������� ����������� ������ �� ������ ����� ���� ��������� ������.
//
// Revision 1.56  2010/03/23 12:16:28  dinishev
// [$198673290]
//
// Revision 1.55  2010/03/02 13:34:35  lulin
// {RequestLink:193823544}.
//
// Revision 1.54  2010/03/01 14:02:56  lulin
// {RequestLink:193823544}.
// - ������ ���.
//
// Revision 1.53  2009/07/23 08:14:39  lulin
// - �������� �������� ������������� ���������� ��������.
//
// Revision 1.52  2009/07/14 14:56:28  lulin
// {RequestLink:141264340}. �25.
//
// Revision 1.51  2009/07/13 12:31:37  lulin
// {RequestLink:141264340}. �23ac.
//
// Revision 1.50  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. �22.
//
// Revision 1.49  2009/06/25 12:57:30  lulin
// - �������� �������� ��������.
//
// Revision 1.48  2009/06/02 06:25:58  dinishev
// [$148571693] - ����������� �� ������ �����.
//
// Revision 1.47  2009/05/29 17:18:25  lulin
// [$142610853].
//
// Revision 1.46  2009/05/26 11:14:50  dinishev
// [$146905510]. �� ����������� �� ������, ��������� � ������.
//
// Revision 1.45  2009/05/26 07:25:27  dinishev
// [$146905510]
//
// Revision 1.44  2009/04/14 18:11:55  lulin
// [$143396720]. ���������������� ������.
//
// Revision 1.43  2009/04/06 09:45:27  lulin
// [$140837386]. ������� ������������� ������� ��� ������� ����������.
//
// Revision 1.42  2009/03/31 12:04:36  lulin
// [$140286997].
//
// Revision 1.41  2009/03/04 13:32:47  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.40  2008/04/15 08:23:46  lulin
// - ������� ��� � �������� ���������.
//
// Revision 1.39  2008/04/14 07:48:09  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.38  2008/04/10 14:34:05  lulin
// - <K>: 89098970.
//
// Revision 1.37  2008/04/09 17:57:08  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.36  2008/04/08 16:41:20  lulin
// - ������� View � AssignPoint. <K>: 89096854.
//
// Revision 1.35  2008/04/04 16:17:59  lulin
// - ������ � �������� ��� ������ �������� ������ �� �����.
//
// Revision 1.34  2008/02/29 10:55:23  dinishev
// Bug fix: ����������� ��������� ��������� ������
//
// Revision 1.33  2008/02/27 17:24:58  lulin
// - ��������� ��� ��� ������.
//
// Revision 1.32  2007/12/04 12:47:05  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.27.4.46  2007/11/28 15:43:47  dinishev
// ������� ���������� ��� � ��������� �������������� ���������
//
// Revision 1.27.4.45  2007/09/14 13:26:06  lulin
// - ��������� � ������ B_Tag_Clean.
//
// Revision 1.27.4.44.2.1  2007/09/12 15:23:02  lulin
// - ����������� �� ������, ������������ ���������������� ��������� ��������.
//
// Revision 1.27.4.44  2007/07/18 15:07:19  lulin
// - ���������� �����������. ����� ���������, ������ �� ������� �� ��������.
//
// Revision 1.27.4.43  2007/02/12 18:06:13  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.27.4.42  2007/02/12 17:15:59  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.27.4.41  2007/02/12 16:40:20  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.27.4.40  2007/01/24 10:21:42  oman
// - new: ����������� ��������� - ev (cq24078)
//
// Revision 1.27.4.39  2006/11/03 11:00:07  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.27.4.38.2.8  2006/10/31 09:39:37  lulin
// - ���������� ����� �������������� ���������� ������, � �� ����������� � �������.
//
// Revision 1.27.4.38.2.7  2006/10/31 09:21:18  lulin
// - ��� ������ ������� ����� ������ ��� ����������� ����� ��������������.
//
// Revision 1.27.4.38.2.6  2006/10/25 10:47:11  lulin
// - � ������� ����� ������ �������������� ����������.
//
// Revision 1.27.4.38.2.5  2006/10/23 08:58:09  lulin
// - ������ ��� ����������� "������� �����" �������� ������� ������.
//
// Revision 1.27.4.38.2.4  2006/10/19 13:33:18  lulin
// - ��������� ������� � ��������� �� ����� ������.
//
// Revision 1.27.4.38.2.3  2006/10/19 12:05:43  lulin
// - �������� ����� ��� ��������� ���������� � ������� �������.
//
// Revision 1.27.4.38.2.2  2006/10/19 10:56:17  lulin
// - ��������� ������� ��������� � ����� ����� ����������.
//
// Revision 1.27.4.38.2.1  2006/10/18 13:06:34  lulin
// - �������� �������� ������.
//
// Revision 1.27.4.38  2006/10/10 12:06:14  lulin
// - cleanup.
//
// Revision 1.27.4.37  2006/10/06 08:24:09  lulin
// - ������ ��������������.
//
// Revision 1.27.4.36  2006/10/06 08:19:42  lulin
// - ���������� �������� �������� - ����� ������� �����.
//
// Revision 1.27.4.35.2.2  2006/10/04 15:17:08  lulin
// - ���������� �������� �������� - ����� ������� �����.
//
// Revision 1.27.4.35.2.1  2006/10/04 14:10:20  lulin
// - �������� �������� ��������� ������� �����.
//
// Revision 1.27.4.35  2006/10/04 11:23:02  lulin
// - ��� ��������� ������� ����� �������� "���������" �������.
//
// Revision 1.27.4.34  2006/10/04 08:32:06  lulin
// - ������ ������������� ��������� ��� ��������� ����� ����������� ���������� - ����� ����� ���� ��������� ���������.
//
// Revision 1.27.4.33  2006/10/04 06:23:44  lulin
// - ����� ���� ����������� � ��������� ����.
//
// Revision 1.27.4.32  2006/10/04 04:33:51  lulin
// - ����������� �� ������������� �������� � ����� OLE.
//
// Revision 1.27.4.31  2006/08/02 10:51:53  lulin
// - ��������� � ������ � ������� ������� �� �����������.
//
// Revision 1.27.4.30.2.1  2006/08/01 10:51:37  lulin
// - � ������������ �������� ������ �������� "������".
//
// Revision 1.27.4.30  2006/07/21 11:43:31  lulin
// - ��� ������ ������ �� ������������ - ����� �� ���������� ����������� �������.
//
// Revision 1.27.4.29  2006/07/20 18:36:56  lulin
// - ��� ������ ������ �� ������������ - ����� �� ���������� ����������� �������.
//
// Revision 1.27.4.28  2006/07/20 12:55:46  lulin
// - ��� ������ ������ �� ������������ - ����� �� ���������� ����������� �������.
//
// Revision 1.27.4.27  2006/07/03 11:58:53  lulin
// - �������� �� ��������� ������, � "��������� ����".
//
// Revision 1.27.4.26  2005/11/21 09:56:54  lulin
// - ������ �������� ���������� �����.
//
// Revision 1.27.4.25  2005/11/08 06:39:37  lulin
// - � ���������� ��������� � ������ ���������� �������� �������� ������ ��������� ������� ����� ���������.
//
// Revision 1.27.4.24  2005/11/07 06:25:22  lulin
// - �������� � ����� � � ������� ����� ����������������.
//
// Revision 1.27.4.23  2005/11/05 07:55:29  lulin
// - cleanup: ������ �������� �������������� ������� � ���������.
//
// Revision 1.27.4.22  2005/10/07 10:29:01  lulin
// - ��������� �������� ����������� ������.
//
// Revision 1.27.4.21  2005/08/31 12:04:34  lulin
// - ������ �������� ������.
//
// Revision 1.27.4.20  2005/08/25 14:12:52  lulin
// - new behavior: ��� �� �� ������� Hint'� � ������ ��� ����� � ����� ������� � ����������.
//
// Revision 1.27.4.19  2005/07/20 18:21:14  lulin
// - ����� ���������� ���������.
//
// Revision 1.27.4.18  2005/07/18 11:22:37  lulin
// - ������, ������������� ��������� �� ��������� ���� ����� ���������� ��������.
//
// Revision 1.27.4.17  2005/07/07 15:10:38  lulin
// - new behavior: ������ HotSpot ���������� ����� � ������� ��������� ������.
//
// Revision 1.27.4.16  2005/07/07 13:09:28  lulin
// - ����������� �������� �����������.
//
// Revision 1.27.4.15  2005/07/07 11:41:17  lulin
// - �������� � _GetAdvancedHotSpot ����������� ��������� InevViewPoint.
//
// Revision 1.27.4.14  2005/07/05 16:02:44  lulin
// - bug fix: ������������ ��������� ��� ��������� ������ �����.
//
// Revision 1.27.4.13  2005/06/20 15:42:10  lulin
// - cleanup: ����������� �� ���������� ���������.
//
// Revision 1.27.4.12  2005/06/16 11:24:12  lulin
// - ������ ��������� ��������� ���������� (��� ������ _QI � QT).
//
// Revision 1.27.4.11  2005/06/15 17:23:52  lulin
// - remove proc: _evMoveCursor.
//
// Revision 1.27.4.10  2005/06/14 14:51:51  lulin
// - new interface: _InevSelection.
// - remove interface: IevSelection.
//
// Revision 1.27.4.9  2005/06/14 12:38:58  lulin
// - ��������� �� �������� ��������� ���������� (������ ���������� View).
//
// Revision 1.27.4.8  2005/06/14 10:01:31  lulin
// - ��������� �� �������� ��������� ���������� (������ ���������� View).
//
// Revision 1.27.4.7  2005/06/11 08:55:38  lulin
// - � �����-�� ���� ������������� ����������������� HotSpot'��.
//
// Revision 1.27.4.6  2005/06/06 15:36:09  lulin
// - ���������� �������� �� ������� � ������� ���������� ��������.
//
// Revision 1.27.4.5  2005/06/02 12:33:08  lulin
// - ������ ������� ������ �������� ����� ��������� �� ��� ��������� �� �������.
//
// Revision 1.27.4.4  2005/06/01 16:22:25  lulin
// - remove unit: evIntf.
//
// Revision 1.27.4.3  2005/05/31 17:46:39  lulin
// - �������� ������� �������� � �������� ��������.
//
// Revision 1.27.4.2  2005/05/31 14:48:01  lulin
// - cleanup: ��� ������ � ��������� ���������� ����������, � �� �������.
//
// Revision 1.27.4.1  2005/05/18 12:42:47  lulin
// - ����� ����� �����.
//
// Revision 1.25.2.4  2005/05/18 12:32:10  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.25.2.3  2005/04/28 09:18:30  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.25.2.2  2005/04/09 12:48:37  lulin
// - ����� ParaByOffset ������������ � _ShapeByPt � ��������� �� ��������� InevComplexShape.
//
// Revision 1.25.2.1  2005/04/08 13:35:05  lulin
// - _Processor ���� ������������ ����������.
//
// Revision 1.26.2.1  2005/04/23 16:07:25  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.26  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.27  2005/04/28 15:03:38  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.26.2.1  2005/04/23 16:07:25  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.26  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.25  2005/04/07 15:42:05  lulin
// - cleanup.
//
// Revision 1.24  2005/04/07 15:12:30  lulin
// - ������� �������� ���������� ���������.
//
// Revision 1.23  2005/04/07 14:59:56  lulin
// - new method: _InevShape._TranslatePt.
//
// Revision 1.22  2005/04/07 14:32:49  lulin
// - remove proc: evGetTopPara.
//
// Revision 1.21  2005/03/28 11:32:08  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.20  2005/03/24 13:14:37  lulin
// - ������� �������� ������� �������������� Tk2AtomR � _Ik2Tag.
//
// Revision 1.19  2005/03/16 12:16:52  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.18  2005/03/10 16:40:10  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.17  2005/03/10 16:22:32  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.16  2005/03/10 14:58:38  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.15  2005/03/10 07:05:11  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.14  2005/03/09 18:40:19  lulin
// - remove method: Tk2AtomR.DeleteChild.
// - new method: _Ik2Tag.DeleteChild.
//
// Revision 1.13  2003/10/02 16:33:24  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.12  2003/01/14 16:47:11  law
// - new proc: evTagIndex.
//
// Revision 1.11  2003/01/13 16:34:04  law
// - bug fix: �� ����������� ����������� �����.
//
// Revision 1.10  2003/01/13 16:16:32  law
// - new behavior: ����������� ��������� ������� ��� DoubleClick �� ������.
//
// Revision 1.9  2003/01/13 15:58:31  law
// - new behavior: ����������� ��������� ������ ������� �������.
//
// Revision 1.8  2002/07/09 12:02:21  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.7  2002/01/29 16:46:25  law
// - new behavior:  �������� �������� ��������� ������.
//
// Revision 1.6  2002/01/29 16:18:14  law
// - new behavior:  �������� �������� ��������� ������.
//
// Revision 1.5  2001/04/03 14:13:48  law
// - new behavior: ������ evTable_GetMergeHead ���������� ��� ID ������� � ���� (� �� �������). ����� �������� �������� pRowID.
//
// Revision 1.4  2001/03/22 15:22:27  law
// - ������� ���������� HotSpot'� � �������� ������.
//
// Revision 1.3  2000/12/15 15:10:38  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3IID,

  l3Units,

  afwInterfaces,

  k2Interfaces,
  k2InternalInterfaces,

  evInternalInterfaces,
  evTableColumnHotSpot,
  evParaListHotSpotTester,
  evSelectingHotSpot,

  nevTools,
  nevGUIInterfaces
  ;

type
  TevTableRowHotSpotTester = class(TevParaListHotSpotTester)
    {* - ��������� ��������� IevHotSpotTester ��� ������ ������� }
    protected
    // internal methods
      function GetTableColumnHotSpot: RevTableColumnHotSpot;
        virtual;
         {-}
      function NeedRowSpot: Boolean;
        virtual;
        {-}
    public
    //public methods
      function GetChildHotSpot(const aView  : InevControlView;
                               const aState : TevCursorState;
                               const aPt    : InevBasePoint;
                               const aMap   : InevMap;
                               const aChild : InevObject;
                               out theSpot  : IevHotSpot): Boolean;
        override;
        {-}
  end;//TevTableRowHotSpotTester

  TevTableRowHotSpot = class(TevSelectingHotSpot)
  private
   {* - ��������� ��������� IevAdvancedHotSpot ��� ������ �������. }
    protected
    // internal fields
      f_StartPoint : InevBasePoint;
       {* - ��������� �����. }
    protected
    //property methods
      procedure DoHitTest(const aView  : InevControlView;
                        const aState : TafwCursorState;
                        var theInfo  : TafwCursorInfo);
        override;
        {-}
    protected
    // internal methods
      function  InitSelection(const aView : InevControlView;
                              const aPt : InevBasePoint;
                              const theStart  : InevBasePoint;
                              const theFinish : InevBasePoint): Bool;
        override;
        {-}
      function SelectionTable: InevParaList;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    //public methods
      function MouseAction(const aView : InevControlView;
                           aButton     : TevMouseButton;
                           anAction    : TevMouseAction;
                           const Keys  : TevMouseState;
                           var Effect  : TevMouseEffect): Bool;
        override;
        {* - ������������ ������� ����. }
  end;//TevTableRowHotSpot

implementation

uses
  l3Const,
  l3String,

  k2Tags,

  evdTypes,
  
  evOp,
  evConst,
  evParaTools,
  evTableTools,
  evCursorTools,
  evHotSpotMisc,

  nevInterfaces,

  TableRow_Const
  ;

// start class TevTableRowHotSpotTester

function TevTableRowHotSpotTester.NeedRowSpot: Boolean;
  //virtual;
  {-}
begin
 Result := True;
end;

function TevTableRowHotSpotTester.GetChildHotSpot(const aView  : InevControlView;
                                                  const aState : TevCursorState;
                                                  const aPt    : InevBasePoint;
                                                  const aMap   : InevMap;
                                                  const aChild : InevObject;
                                                  out theSpot  : IevHotSpot): Boolean;
  //override;
  {-}
var
 l_Map   : InevMap;
 l_X     : Integer;
 l_Delta : Integer;
begin
 if NeedRowSpot then
 begin
  Result := True;
  l_Map := aMap;
  if (l_Map <> nil) then
  begin
   if not l_Map.rVisible then
    l_Map := aView.MapByPoint(aChild.MakePoint, True);
   Assert(l_Map <> nil); 
   l_X := aState.rPoint.X - l_Map.Bounds.Left;
   if (l_X < 0) then
    theSpot := TevHotSpotWrap.Make(TevTableRowHotSpot.Make(aChild.OwnerObj.AsObject, Processor))
   else
   begin
    l_Delta := l_X - l_Map.FI.Width; 
    if (Abs(l_Delta) <= 4 * evEpsilon) then
     theSpot :=  TevHotSpotWrap.Make(
                       GetTableColumnHotSpot.Make(aView, aChild.OwnerObj.AsObject,
                                                  aChild.PID + 1,
                                                  str_nevmhCellSize.AsCStr,
                                                  l_Delta))
    else
     Result := inherited GetChildHotSpot(aView, aState, aPt, aMap, aChild, theSpot);
   end//l_X < 0
  end//l_Map <> nil
  else
   Result := inherited GetChildHotSpot(aView, aState, aPt, aMap, aChild, theSpot);
 end//NeedRowSpot
 else
  Result := inherited GetChildHotSpot(aView, aState, aPt, aMap, aChild, theSpot);
end;

// start class TevTableRowHotSpot

procedure TevTableRowHotSpot.DoHitTest(const aView  : InevControlView;
                                     const aState : TafwCursorState;
                                     var theInfo  : TafwCursorInfo);
  //override;
  {-}
begin
 inherited;
 theInfo.rCursor := ev_csSelectLine;
 theInfo.rHint := str_nevmhhTableRow.AsCStr;
end;

function TevTableRowHotSpot.InitSelection(const aView : InevControlView;
                                          const aPt       : InevBasePoint;
                                          const theStart  : InevBasePoint;
                                          const theFinish : InevBasePoint): Bool;
  //override;
  {-}
var
 l_Point : InevBasePoint;
begin
 Result := True;
 Assert(aView <> nil);
 l_Point := aPt;
 while (l_Point <> nil) do
 begin
  if l_Point.AsObject.IsKindOf(k2_typTableRow) then Break;
  l_Point := l_Point.Inner;
 end;//while (l_Point <> nil)
 if (l_Point <> nil) then
 begin
  if ((f_StartPoint.Obj.PID) > l_Point.Obj.PID) then
  begin
   theFinish.AssignPoint(aView, f_StartPoint);
   theFinish.Move(aView, ev_ocBottomRight);
   theStart.AssignPoint(aView, l_Point);
   theStart.Move(aView, ev_ocTopLeft);
  end//if (l_Start > l_Finish) then
  else
  begin
   theStart.AssignPoint(aView, f_StartPoint);
   theStart.Move(aView, ev_ocTopLeft);
   theFinish.AssignPoint(aView, l_Point);
   theFinish.Move(aView, ev_ocBottomRight);
  end;//(f_StartPoint.Obj.PID) > l_Point.Obj.PID
 end//l_Point <> nil
 else
  Result := False;
end;

function TevTableRowHotSpot.MouseAction(const aView : InevControlView;
                                        aButton     : TevMouseButton;
                                        anAction    : TevMouseAction;
                                        const Keys  : TevMouseState;
                                        var Effect  : TevMouseEffect): Bool;
  {* - ������������ ������� ����. }
begin
 Result := inherited MouseAction(aView, aButton, anAction, Keys, Effect);
 case aButton of
  ev_mbLeft :
  begin
   case anAction of
    ev_maDown :
    begin
     f_StartPoint := ParaX.MakePoint;
     f_StartPoint.SetAtStart(aView, True);
     Result := evSelectTablePara(aView.Control.Selection, ParaX);
    end;//ev_maDown
    ev_maDouble :
    begin
     Result := evSelectTablePara(aView.Control.Selection, SelectionTable);
     if Result then
      Effect.rNeedAsyncLoop := False;
    end;//ev_maDouble
   end;//case anAction
  end;//ev_mbLeft
 end;//case aButton
end;

function TevTableRowHotSpot.SelectionTable: InevParaList;
begin
 Result := ParaX.OwnerPara;
end;

procedure TevTableRowHotSpot.Cleanup;
begin
 f_StartPoint := nil;
 inherited;
end;

function TevTableRowHotSpotTester.GetTableColumnHotSpot: RevTableColumnHotSpot;
begin
 Result := TevTableColumnHotSpot;
end;

end.

