unit evTableCellHotSpot;
{* ���������� ����������� IevHotSpotTester � IevHotSpot ��� ������ �������. }

{ ���������� "�������"         }
{ �����: ����� �.�. �          }
{ ������: evTableCellHotSpot - }
{ �����: 02.11.2000 10:18      }
{ $Id: evTableCellHotSpot.pas,v 1.82 2015/01/19 18:36:36 lulin Exp $ }

// $Log: evTableCellHotSpot.pas,v $
// Revision 1.82  2015/01/19 18:36:36  lulin
// {RequestLink:580710025}
//
// Revision 1.81  2015/01/19 16:52:44  lulin
// {RequestLink:580710025}
//
// Revision 1.80  2014/04/30 11:23:52  lulin
// - ���������� �����������.
//
// Revision 1.79  2014/04/29 13:38:51  lulin
// - �������� �������� �����������.
//
// Revision 1.78  2014/04/21 11:45:00  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.77  2014/04/07 17:56:59  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.76  2014/03/28 12:15:23  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.75  2014/03/18 15:56:59  lulin
// - ������������� ������ � ������.
//
// Revision 1.74  2013/10/21 17:30:59  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.73  2013/10/21 15:42:58  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.72  2013/10/21 10:30:41  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.71  2011/09/13 10:48:06  lulin
// {RequestLink:278839709}.
//
// Revision 1.70  2011/02/22 19:41:04  lulin
// {RequestLink:182157315}.
//
// Revision 1.69  2011/02/15 11:24:49  lulin
// {RequestLink:231670346}.
//
// Revision 1.68  2010/06/24 18:33:33  lulin
// {RequestLink:219125149}.
// - ���� ����������� ����, ���� ���� �� ��� �������.
// - ������������ ����� ��������� � �������.
//
// Revision 1.67  2010/06/24 15:16:27  lulin
// {RequestLink:219125149}.
// - �������� ������������� ����, ���� ���� �� ��� �������.
//
// Revision 1.66  2010/06/24 12:52:54  lulin
// {RequestLink:219125149}.
//
// Revision 1.65  2010/03/02 13:34:35  lulin
// {RequestLink:193823544}.
//
// Revision 1.64  2010/03/01 14:50:06  lulin
// {RequestLink:193823544}.
// - ��� ������.
//
// Revision 1.63  2009/07/23 08:14:39  lulin
// - �������� �������� ������������� ���������� ��������.
//
// Revision 1.62  2009/07/14 14:56:28  lulin
// {RequestLink:141264340}. �25.
//
// Revision 1.61  2009/07/13 12:31:37  lulin
// {RequestLink:141264340}. �23ac.
//
// Revision 1.60  2009/07/11 17:11:05  lulin
// {RequestLink:141264340}. �19.
//
// Revision 1.59  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. �22.
//
// Revision 1.58  2009/07/10 16:15:41  lulin
// - ����������� �� ������� ������� ��������� ������.
//
// Revision 1.57  2009/06/25 12:57:30  lulin
// - �������� �������� ��������.
//
// Revision 1.56  2009/05/29 17:18:25  lulin
// [$142610853].
//
// Revision 1.55  2009/05/22 11:38:03  dinishev
// ����� ��������� �����.
//
// Revision 1.54  2009/04/14 18:11:55  lulin
// [$143396720]. ���������������� ������.
//
// Revision 1.53  2009/04/06 09:45:27  lulin
// [$140837386]. ������� ������������� ������� ��� ������� ����������.
//
// Revision 1.52  2009/03/04 13:32:47  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.51  2008/12/12 19:19:14  lulin
// - <K>: 129762414.
//
// Revision 1.50  2008/12/12 15:34:20  lulin
// - <K>: 129762414.
//
// Revision 1.49  2008/10/02 15:34:22  lulin
// - <K>: 119476261.
//
// Revision 1.48  2008/05/05 12:56:39  lulin
// - <K>: 90439843.
//
// Revision 1.47  2008/04/24 12:26:19  lulin
// - ��������� � ������ <K>: 89106312.
//
// Revision 1.46  2008/04/15 08:23:46  lulin
// - ������� ��� � �������� ���������.
//
// Revision 1.45  2008/04/14 07:48:09  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.44  2008/04/10 14:34:05  lulin
// - <K>: 89098970.
//
// Revision 1.43  2008/04/09 17:57:08  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.42  2008/04/08 16:41:20  lulin
// - ������� View � AssignPoint. <K>: 89096854.
//
// Revision 1.41  2008/04/04 16:17:59  lulin
// - ������ � �������� ��� ������ �������� ������ �� �����.
//
// Revision 1.40  2008/02/29 10:52:39  dinishev
// Bug fix: AV ��� ���������� ��������� ������
//
// Revision 1.39  2008/02/27 17:24:58  lulin
// - ��������� ��� ��� ������.
//
// Revision 1.38  2007/12/04 12:47:05  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.33.4.45  2007/11/28 15:31:54  dinishev
// ����������� �� Assert'�� ��� ������ � ��������� � ����
//
// Revision 1.33.4.44  2007/09/14 13:26:06  lulin
// - ��������� � ������ B_Tag_Clean.
//
// Revision 1.33.4.43.2.1  2007/09/12 15:23:02  lulin
// - ����������� �� ������, ������������ ���������������� ��������� ��������.
//
// Revision 1.33.4.43  2007/07/18 15:07:19  lulin
// - ���������� �����������. ����� ���������, ������ �� ������� �� ��������.
//
// Revision 1.33.4.42  2007/02/12 17:15:59  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.33.4.41  2007/02/12 16:40:20  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.33.4.40  2007/01/24 10:21:42  oman
// - new: ����������� ��������� - ev (cq24078)
//
// Revision 1.33.4.39  2006/11/03 11:00:07  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.33.4.38.2.10  2006/10/31 09:39:37  lulin
// - ���������� ����� �������������� ���������� ������, � �� ����������� � �������.
//
// Revision 1.33.4.38.2.9  2006/10/31 09:21:18  lulin
// - ��� ������ ������� ����� ������ ��� ����������� ����� ��������������.
//
// Revision 1.33.4.38.2.8  2006/10/25 14:30:48  lulin
// - ���������� ����� ����������� ��� �����.
//
// Revision 1.33.4.38.2.7  2006/10/25 10:47:11  lulin
// - � ������� ����� ������ �������������� ����������.
//
// Revision 1.33.4.38.2.6  2006/10/23 08:58:09  lulin
// - ������ ��� ����������� "������� �����" �������� ������� ������.
//
// Revision 1.33.4.38.2.5  2006/10/19 13:33:18  lulin
// - ��������� ������� � ��������� �� ����� ������.
//
// Revision 1.33.4.38.2.4  2006/10/19 12:05:43  lulin
// - �������� ����� ��� ��������� ���������� � ������� �������.
//
// Revision 1.33.4.38.2.3  2006/10/19 10:56:17  lulin
// - ��������� ������� ��������� � ����� ����� ����������.
//
// Revision 1.33.4.38.2.2  2006/10/18 13:06:34  lulin
// - �������� �������� ������.
//
// Revision 1.33.4.38.2.1  2006/10/18 12:33:15  lulin
// - ���� ��� ��������� ���� ��������� � ����� ����� ����������.
//
// Revision 1.33.4.38  2006/10/10 12:06:14  lulin
// - cleanup.
//
// Revision 1.33.4.37  2006/10/06 08:19:42  lulin
// - ���������� �������� �������� - ����� ������� �����.
//
// Revision 1.33.4.36.2.2  2006/10/04 15:17:08  lulin
// - ���������� �������� �������� - ����� ������� �����.
//
// Revision 1.33.4.36.2.1  2006/10/04 14:10:20  lulin
// - �������� �������� ��������� ������� �����.
//
// Revision 1.33.4.36  2006/10/04 11:23:02  lulin
// - ��� ��������� ������� ����� �������� "���������" �������.
//
// Revision 1.33.4.35  2006/10/04 08:32:06  lulin
// - ������ ������������� ��������� ��� ��������� ����� ����������� ���������� - ����� ����� ���� ��������� ���������.
//
// Revision 1.33.4.34  2006/10/04 06:23:44  lulin
// - ����� ���� ����������� � ��������� ����.
//
// Revision 1.33.4.33  2006/10/04 04:33:51  lulin
// - ����������� �� ������������� �������� � ����� OLE.
//
// Revision 1.33.4.32  2006/07/21 11:40:26  lulin
// - ��� ������ ������ �� ������������ - ����� �� ���������� ����������� �������.
//
// Revision 1.33.4.31  2006/07/21 11:35:25  lulin
// - ��� ������ ������ �� ������������ - ����� �� ���������� ����������� �������.
//
// Revision 1.33.4.30  2006/07/20 18:36:56  lulin
// - ��� ������ ������ �� ������������ - ����� �� ���������� ����������� �������.
//
// Revision 1.33.4.29  2006/07/20 12:55:46  lulin
// - ��� ������ ������ �� ������������ - ����� �� ���������� ����������� �������.
//
// Revision 1.33.4.28  2006/07/03 11:58:53  lulin
// - �������� �� ��������� ������, � "��������� ����".
//
// Revision 1.33.4.27  2005/11/21 09:56:54  lulin
// - ������ �������� ���������� �����.
//
// Revision 1.33.4.26  2005/11/08 06:39:37  lulin
// - � ���������� ��������� � ������ ���������� �������� �������� ������ ��������� ������� ����� ���������.
//
// Revision 1.33.4.25  2005/11/07 06:25:22  lulin
// - �������� � ����� � � ������� ����� ����������������.
//
// Revision 1.33.4.24  2005/09/23 16:03:55  lulin
// - ������� ������ � ������ ������������.
//
// Revision 1.33.4.23  2005/08/31 12:04:34  lulin
// - ������ �������� ������.
//
// Revision 1.33.4.22  2005/08/25 14:12:52  lulin
// - new behavior: ��� �� �� ������� Hint'� � ������ ��� ����� � ����� ������� � ����������.
//
// Revision 1.33.4.21  2005/07/20 18:21:14  lulin
// - ����� ���������� ���������.
//
// Revision 1.33.4.20  2005/07/18 11:22:37  lulin
// - ������, ������������� ��������� �� ��������� ���� ����� ���������� ��������.
//
// Revision 1.33.4.19  2005/07/07 16:54:02  lulin
// - cleanup.
//
// Revision 1.33.4.18  2005/07/07 15:38:05  lulin
// - InevViewPoint ������ �� ����������� �� InevAnchor.
//
// Revision 1.33.4.17  2005/07/07 15:10:38  lulin
// - new behavior: ������ HotSpot ���������� ����� � ������� ��������� ������.
//
// Revision 1.33.4.16  2005/07/07 13:09:28  lulin
// - ����������� �������� �����������.
//
// Revision 1.33.4.15  2005/07/07 11:41:17  lulin
// - �������� � _GetAdvancedHotSpot ����������� ��������� InevViewPoint.
//
// Revision 1.33.4.14  2005/07/05 16:02:44  lulin
// - bug fix: ������������ ��������� ��� ��������� ������ �����.
//
// Revision 1.33.4.13  2005/06/20 15:42:10  lulin
// - cleanup: ����������� �� ���������� ���������.
//
// Revision 1.33.4.12  2005/06/16 11:24:12  lulin
// - ������ ��������� ��������� ���������� (��� ������ _QI � QT).
//
// Revision 1.33.4.11  2005/06/15 17:23:52  lulin
// - remove proc: _evMoveCursor.
//
// Revision 1.33.4.10  2005/06/14 14:51:51  lulin
// - new interface: _InevSelection.
// - remove interface: IevSelection.
//
// Revision 1.33.4.9  2005/06/14 12:38:58  lulin
// - ��������� �� �������� ��������� ���������� (������ ���������� View).
//
// Revision 1.33.4.8  2005/06/14 10:01:31  lulin
// - ��������� �� �������� ��������� ���������� (������ ���������� View).
//
// Revision 1.33.4.7  2005/06/11 08:55:38  lulin
// - � �����-�� ���� ������������� ����������������� HotSpot'��.
//
// Revision 1.33.4.6  2005/06/06 15:36:09  lulin
// - ���������� �������� �� ������� � ������� ���������� ��������.
//
// Revision 1.33.4.5  2005/06/02 12:33:08  lulin
// - ������ ������� ������ �������� ����� ��������� �� ��� ��������� �� �������.
//
// Revision 1.33.4.4  2005/06/01 16:22:25  lulin
// - remove unit: evIntf.
//
// Revision 1.33.4.3  2005/05/31 17:46:39  lulin
// - �������� ������� �������� � �������� ��������.
//
// Revision 1.33.4.2  2005/05/31 14:48:01  lulin
// - cleanup: ��� ������ � ��������� ���������� ����������, � �� �������.
//
// Revision 1.33.4.1  2005/05/18 12:42:47  lulin
// - ����� ����� �����.
//
// Revision 1.30.2.4  2005/05/18 12:32:10  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.30.2.3  2005/04/28 09:18:30  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.30.2.2  2005/04/09 12:48:37  lulin
// - ����� ParaByOffset ������������ � _ShapeByPt � ��������� �� ��������� InevComplexShape.
//
// Revision 1.30.2.1  2005/04/08 13:35:05  lulin
// - _Processor ���� ������������ ����������.
//
// Revision 1.32.2.1  2005/04/23 16:07:25  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.32  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.31  2005/04/20 17:40:50  lulin
// - ��������� �� �������������� ���������� Ik2TagBoxQT.
//
// Revision 1.33  2005/04/28 15:03:38  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.32.2.1  2005/04/23 16:07:25  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.32  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.31  2005/04/20 17:40:50  lulin
// - ��������� �� �������������� ���������� Ik2TagBoxQT.
//
// Revision 1.30  2005/04/07 15:42:05  lulin
// - cleanup.
//
// Revision 1.29  2005/04/07 14:32:49  lulin
// - remove proc: evGetTopPara.
//
// Revision 1.28  2005/03/28 11:32:08  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.27  2005/03/24 13:14:37  lulin
// - ������� �������� ������� �������������� Tk2AtomR � _Ik2Tag.
//
// Revision 1.26  2005/03/21 16:28:16  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.25  2005/03/19 16:39:51  lulin
// - �������� �������� ������.
//
// Revision 1.24  2005/03/16 17:04:21  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.23  2005/03/16 12:16:52  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.22  2005/03/10 16:22:31  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.21  2005/03/10 14:58:38  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.20  2005/03/09 18:40:19  lulin
// - remove method: Tk2AtomR.DeleteChild.
// - new method: _Ik2Tag.DeleteChild.
//
// Revision 1.19  2004/11/10 11:06:08  lulin
// - new interface: IevTagShape.
// - remove interface: IevVisualShapedTag.
//
// Revision 1.18  2004/06/30 10:48:41  law
// - ������� ��� ��������� Parent � ������� IevVisualShapedTag._ParentToClient, _ClientToParent � IUnknown �� _Ik2Tag.
//
// Revision 1.17  2003/10/02 16:33:24  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.16  2003/02/14 17:10:06  law
// - bug fix: BUG: ���� �������� ����� �������, ����� �������� ��� �������� ������ (��� ������ HotSpot), ����� �� ������ �������� ���-������ ���������, � ����� ����� ���������� �������� �� �� ����� ������, �� ������ ������ ���������� �� ������� (�122).
//
// Revision 1.15  2003/01/14 17:26:40  law
// - bug fix: �������� ��������� ������� �� Ctrl.
// - new behavior: ����������� ��������� ���������� ��������.
//
// Revision 1.14  2003/01/14 16:48:40  law
// - new behavior: ����������� ��������� ����� ���������� ����� �� HotSpot.
//
// Revision 1.13  2003/01/14 15:21:26  law
// - bug fix: ����������� ������������� DoubleClick - � ����� �������� ���������� ���������� ������, � �� ������.
//
// Revision 1.12  2003/01/13 17:35:49  law
// - new behavior: ��������� ����������� ��������� ����� ��� DoubleClick ������ ������.
//
// Revision 1.11  2002/07/09 12:02:21  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.10  2001/11/26 14:31:04  law
// - change type: Keys: Long -> Keys: TShiftState.
//
// Revision 1.9  2001/04/27 14:11:49  law
// - new behavior: ����� �������� ������������ �����.
//
// Revision 1.8  2001/04/12 16:35:26  law
// - new behavior: ������� ������ ��� ��������� � �����.
//
// Revision 1.7  2001/03/22 15:20:23  law
// - ��������� ������� evTable_GetMergeHead.
//
// Revision 1.6  2001/03/19 15:34:56  law
// - ������� ��������� ������������� ����������� �����.
//
// Revision 1.5  2001/03/01 14:13:45  law
// - ������� ��������� ������� ������� ��� Ctrl+Double Click.
//
// Revision 1.4  2001/01/31 10:37:31  law
// - �������������� ������������� QueryInterface.
//
// Revision 1.3  2000/12/15 15:10:38  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  Windows,

  Classes,

  l3Types,
  l3Base,
  l3IID,

  l3Units,

  afwInterfaces,

  k2Interfaces,
  k2InternalInterfaces,

  evInternalInterfaces,
  evEditorInterfaces,
  evParaListHotSpotTester,
  evSelectingHotSpot,

  nevBase,
  nevTools,
  nevGUIInterfaces
  ;

type
  TevTableCellHotSpotTester = class(TevParaListHotSpotTester)
   {* - ��������� ��������� IevHotSpotTester ��� ������ �������. }
    protected
    // internal methods
      function NeedCellSpot: Boolean;
        virtual;
        {-}
   public
   // public methods
      function DoGetAdvancedHotSpot(const aView  : InevControlView;
                                  const aState : TevCursorState;
                                  const aPt    : InevBasePoint;
                                  const aMap   : InevMap;
                                  out theSpot  : IevHotSpot): Boolean;
        override;
        {* - ���������� HotSpot ��� ����� aPt ������ �������. }
  end;//TevTableCellHotSpotTester

  TevTableCellHotSpot = class(TevSelectingHotSpotEx)
   {* - ��������� ��������� IevAdvancedHotSpot ��� ������ �������. }
    private
    //internal fields
      f_Cell      : IedCell;
      f_StartCell : InevBasePoint;
    protected
    //property methods
      procedure DoHitTest(const aView  : InevControlView;
                        const aState : TafwCursorState;
                        var theInfo  : TafwCursorInfo);
        override;
        {-}
    protected
    //internal methods
      procedure Cleanup;
        override;
        {-}    
      function DoMouseAction(const aView : InevControlView;
                             aButton     : TevMouseButton;
                             anAction    : TevMouseAction;
                             const Keys  : TevMouseState;
                             var Effect  : TevMouseEffect): Bool;
        override;
        {* - ������������ ������� ����. }
      function  SelectionTable : InevParaList;
        {-}
      function  InitSelection(const aView : InevControlView;
                              const aPt : InevBasePoint;
                              const theStart  : InevBasePoint;
                              const theFinish : InevBasePoint): Bool;
        override;
        {-}
    public
    //public methods
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
  end;//TevTableCellHotSpot

implementation

uses
  SysUtils,
  
  l3InterfacesMisc,
  l3String,

  evdTypes,
  
  evConst,

  k2Tags,

  evOp,
  evCursorTools,
  evParaTools,
  evTableTools,
  evTableRowHotSpot,
  evTableHotSpot,
  evHotSpotMisc,

  nevInterfaces,

  TableRow_Const,
  TableCell_Const
  ;

// start class TevTableCellHotSpotTester

function TevTableCellHotSpotTester.NeedCellSpot: Boolean;
  //virtual;
  {-}
begin
 Result := true;
end;

function TevTableCellHotSpotTester.DoGetAdvancedHotSpot(const aView  : InevControlView;
                                                      const aState : TevCursorState;
                                                      const aPt    : InevBasePoint;
                                                      const aMap   : InevMap;
                                                      out theSpot  : IevHotSpot): Boolean;
  //override;
  {-}
var
 l_Map : InevMap;
 l_Pt  : TnevPoint;
begin
 if NeedCellSpot then
 begin
  l_Map := aMap;
  if (l_Map <> nil) then
  begin
   l_Pt := Tl3Point(aState.rPoint).Sub(l_Map.Bounds.R.TopLeft);
   with l_Pt do
   begin
    if (X > evEpsilon * 2) AND (X <= evEpsilon * 7) AND
       (Y >= l_Map.FI.Height - evEpsilon * 7) then
    begin
     theSpot := TevHotSpotWrap.Make(TevTableCellHotSpot.Make(GetRedirect, Processor));
     Result := True;
     Exit;
    end;//X <= evEpsilon * 2..
   end;//with aPt
  end;//l_Map <> nil
 end;//..IevAdvancedHotSpot..
 Result := inherited DoGetAdvancedHotSpot(aView, aState, aPt, aMap, theSpot);
end;

// start class TevTableCellHotSpot 

procedure TevTableCellHotSpot.Cleanup;
  //override;
  {-}
begin
 f_Cell := nil;
 f_StartCell := nil;
 inherited;
end;

procedure TevTableCellHotSpot.DoHitTest(const aView  : InevControlView;
                                      const aState : TafwCursorState;
                                      var theInfo  : TafwCursorInfo);
  //override;
  {-}
begin
 inherited;
 theInfo.rCursor := ev_csSelectCell;
 theInfo.rHint := str_nevmhhTableCell.AsCStr;
end;

function TevTableCellHotSpot.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 if IID.EQ(IedCell) AND (f_Cell <> nil) then
 begin
  IedCell(Obj) := f_Cell;
  Result.SetOk;
 end//IID.EQ(IedCell) AND (f_Cell <> nil)
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

function TevTableCellHotSpot.DoMouseAction(const aView : InevControlView;
                                           aButton     : TevMouseButton;
                                           anAction    : TevMouseAction;
                                           const Keys  : TevMouseState;
                                           var Effect  : TevMouseEffect): Bool;
  {-}
var
 l_TableHotSpot : TevTableHotSpot;
 l_Point        : InevBasePoint;
 l_Start        : InevPoint;
 l_Finish       : InevPoint;
 l_Block        : InevRange;
begin
 evQueryParaInterface(aView, aView.Control.Processor, ParaX, Tl3GUID_C(IedCell), f_Cell);
 case aButton of
  ev_mbLeft :
  begin
   case anAction of
    ev_maDown :
     if not (ssCtrl in Keys.rKeys) then
     begin
      f_StartCell := ParaX.MakePoint;
      f_StartCell.SetAtStart(aView, True);
      f_StartCell := f_StartCell.PointToTypedParent(k2_typTableRow);
      Result := aView.Control.Selection <> nil;
      if Result then
      begin
       l_Start := ParaX.MakePoint;
       l_Finish := ParaX.MakePoint;
       l_Start.SetAtStart(aView, True);
       l_Finish.SetAtEnd(aView, True);
       if (ParaX.AsObject.ChildrenCount <= 1) AND l_Finish.AtStart then
        l_Block := ParaX.Range(l_Finish, l_Finish)
       else
        l_Block := ParaX.Range(l_Start, l_Finish);
       aView.Control.Selection.Select(l_Block, false);
      end; // if Result then
     end//not (ssCtrl in Keys.rKeys)
     else
     begin
      l_Point := aView.PointByPt(Tl3Point(Keys.rPoint));
      while l_Point.HasInner do
      begin
       if l_Point.AsObject.IsKindOf(k2_typTableCell) then Break;
       l_Point := l_Point.Inner;
      end;//while l_Point.HasInner
      if l_Point <> nil then
       l_TableHotSpot := TevTableHotSpot.Create(SelectionTable.AsObject,
                                                Processor,
                                                l_Point.Obj.PID)
      else
       Assert(False);
      try
       f_ForeignHotSpot := l_TableHotSpot;
       Result := f_ForeignHotSpot.MouseAction(aView, aButton, ev_maDown, Keys, Effect);
      finally
       l3Free(l_TableHotSpot);
      end;//try..finally
     end;//not (ssCtrl in Keys.rKeys)
    ev_maDouble :
    begin
     if not (ssCtrl in Keys.rKeys) then
     begin
      f_ForeignHotSpot := TevTableRowHotSpot.Make(GetRedirect.Owner, Processor);
      Result := f_ForeignHotSpot.MouseAction(aView, aButton, ev_maDown, Keys, Effect);
     end//not (ssCtrl in Keys.rKeys)
     else
     begin
      Result := evSelectTablePara(aView.Control.Selection, SelectionTable);
      if Result then
       Effect.rNeedAsyncLoop := False;
     end;//not (ssCtrl in Keys.rKeys)
    end;//ev_maDouble
    else
     Result := True;
   end;//case anAction
  end;//ev_mbLeft
  else
   Result := False;
 end;//case aButton
end;

function TevTableCellHotSpot.SelectionTable : InevParaList;
  //override;
  {-}
begin
 Result := ParaX.OwnerPara.OwnerPara;
end;

function TevTableCellHotSpot.InitSelection(const aView : InevControlView;
                                           const aPt : InevBasePoint;
                                           const theStart  : InevBasePoint;
                                           const theFinish : InevBasePoint): Bool;
  //override;
  {-}
var
 l_Point      : InevBasePoint;
 l_StartCell  : InevBasePoint;
 l_FinishCell : InevBasePoint;
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
  if (f_StartCell.Obj.PID > l_Point.Obj.PID) then
  begin
   if (l_Point.Inner <> nil) AND
      (f_StartCell.Inner.Obj.PID < l_Point.Inner.Obj.PID) then
   begin
    l_StartCell := f_StartCell.Inner;
    l_FinishCell := l_Point.Inner;
    theFinish.AssignPoint(aView, f_StartCell);
    theFinish.SetEntryPoint(l_FinishCell.Obj.PID + 1);
    theStart.AssignPoint(aView, l_Point);
    theStart.SetEntryPoint(l_StartCell.Obj.PID + 1);
   end//f_StartCell.Inner.Obj.PID < l_Point.Inner.Obj.PID
   else
   begin
    theFinish.AssignPoint(aView, f_StartCell);
    theStart.AssignPoint(aView, l_Point);
   end;//f_StartCell.Inner.Obj.PID < l_Point.Inner.Obj.PID
  end//f_StartCell.Obj.PID > l_Point.Obj.PID
  else
  begin
   if (l_Point.Inner <> nil) AND
      (f_StartCell.Inner.Obj.PID > l_Point.Inner.Obj.PID) then
   begin
    if (f_StartCell.Obj.PID = l_Point.Obj.PID) then
    begin
     theFinish.AssignPoint(aView, f_StartCell);
     theStart.AssignPoint(aView, l_Point);
    end//f_StartCell.Obj.PID = l_Point.Obj.PID
    else
    begin
     l_StartCell := f_StartCell.Inner;
     l_FinishCell := l_Point.Inner;
     theFinish.AssignPoint(aView, l_Point{f_StartCell});
     theFinish.SetEntryPoint(l_FinishCell.Obj.PID + 1);
     theStart.AssignPoint(aView, f_StartCell{l_Point});
     theStart.SetEntryPoint(l_StartCell.Obj.PID + 1);
    end;//f_StartCell.Obj.PID = l_Point.Obj.PID
   end//f_StartCell.Inner.Obj.PID > l_Point.Inner.Obj.PID
   else
   begin
    theStart.AssignPoint(aView, f_StartCell);
    theFinish.AssignPoint(aView, l_Point);
   end;//f_StartCell.Inner.Obj.PID > l_Point.Inner.Obj.PID
  end;//f_StartCell.Obj.PID > l_Point.Obj.PID
  if theStart.HasInner then
   theStart.Inner.SetAtStart(aView, True);
  if theFinish.HasInner then
   theFinish.Inner.SetAtEnd(aView, True);
 end//l_Point <> nil
 else
  Result := False;
end;

end.

