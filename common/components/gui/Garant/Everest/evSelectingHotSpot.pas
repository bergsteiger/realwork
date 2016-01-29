unit evSelectingHotSpot;

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evSelectingHotSpot - }
{ �����: 13.01.2003 17:15 }
{ $Id: evSelectingHotSpot.pas,v 1.33 2014/04/11 15:30:29 lulin Exp $ }

// $Log: evSelectingHotSpot.pas,v $
// Revision 1.33  2014/04/11 15:30:29  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.32  2014/04/07 17:56:59  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.31  2011/11/23 11:37:00  dinishev
// {Requestlink:290951663}
//
// Revision 1.30  2010/06/24 18:33:33  lulin
// {RequestLink:219125149}.
// - ���� ����������� ����, ���� ���� �� ��� �������.
// - ������������ ����� ��������� � �������.
//
// Revision 1.29  2010/06/24 15:16:26  lulin
// {RequestLink:219125149}.
// - �������� ������������� ����, ���� ���� �� ��� �������.
//
// Revision 1.28  2010/06/24 14:48:30  lulin
// {RequestLink:219125149}.
// - �������� ��������.
//
// Revision 1.27  2010/06/24 12:52:54  lulin
// {RequestLink:219125149}.
//
// Revision 1.26  2009/07/14 14:56:28  lulin
// {RequestLink:141264340}. �25.
//
// Revision 1.25  2009/07/13 12:31:36  lulin
// {RequestLink:141264340}. �23ac.
//
// Revision 1.24  2009/06/25 12:57:30  lulin
// - �������� �������� ��������.
//
// Revision 1.23  2009/05/29 17:18:25  lulin
// [$142610853].
//
// Revision 1.22  2009/04/06 09:45:27  lulin
// [$140837386]. ������� ������������� ������� ��� ������� ����������.
//
// Revision 1.21  2008/04/09 17:57:08  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.20  2008/04/04 16:17:59  lulin
// - ������ � �������� ��� ������ �������� ������ �� �����.
//
// Revision 1.19  2008/02/29 10:51:53  dinishev
// Bug fix: AV ��� ���������� ��������� ������
//
// Revision 1.18  2008/02/27 17:24:58  lulin
// - ��������� ��� ��� ������.
//
// Revision 1.17  2007/12/05 18:25:39  lulin
// - ������ �������� ���.
//
// Revision 1.16  2007/12/05 18:00:08  lulin
// - ������ �������� ���.
//
// Revision 1.15  2007/12/04 12:47:04  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.14.4.31  2007/06/20 09:14:42  dinishev
// merge � ������
//
// Revision 1.14.4.30  2006/11/03 11:00:06  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.14.4.29.2.7  2006/10/19 13:33:18  lulin
// - ��������� ������� � ��������� �� ����� ������.
//
// Revision 1.14.4.29.2.6  2006/10/19 12:05:43  lulin
// - �������� ����� ��� ��������� ���������� � ������� �������.
//
// Revision 1.14.4.29.2.5  2006/10/19 10:56:17  lulin
// - ��������� ������� ��������� � ����� ����� ����������.
//
// Revision 1.14.4.29.2.4  2006/10/18 13:37:59  lulin
// - ������������ �������� ����������.
//
// Revision 1.14.4.29.2.3  2006/10/18 13:06:34  lulin
// - �������� �������� ������.
//
// Revision 1.14.4.29.2.2  2006/10/18 12:45:03  lulin
// - ������ �������� ��������.
//
// Revision 1.14.4.29.2.1  2006/10/18 12:33:15  lulin
// - ���� ��� ��������� ���� ��������� � ����� ����� ����������.
//
// Revision 1.14.4.29  2006/10/06 15:26:45  lulin
// - ������ ����������� ��������������� ��������� ���������� �� ���������, ����������� ��������� ������� �����.
//
// Revision 1.14.4.28  2006/10/06 13:25:38  lulin
// - ������ ��� ������ ���������� �� ���������, ����������� ��������� ������� �����.
//
// Revision 1.14.4.27  2006/10/04 08:32:06  lulin
// - ������ ������������� ��������� ��� ��������� ����� ����������� ���������� - ����� ����� ���� ��������� ���������.
//
// Revision 1.14.4.26  2006/10/04 06:23:44  lulin
// - ����� ���� ����������� � ��������� ����.
//
// Revision 1.14.4.25  2006/07/10 14:55:45  lulin
// - ������ ������������� ������ �� ������������ ������ ���������.
//
// Revision 1.14.4.24  2006/07/03 11:58:53  lulin
// - �������� �� ��������� ������, � "��������� ����".
//
// Revision 1.14.4.23  2006/05/18 12:23:35  lulin
// - bug fix: ������ �� assert'� ��� ��������� ����� ������� ����� (CQ OIT5-20464).
//
// Revision 1.14.4.22  2005/11/09 20:01:04  lulin
// - ����� ���������� ����� ��������� �������. �� ��� ����� ��� ������ ��������� assert - ������ ���� ����� ������ ������� - ���� �� ���������. ��� - �������� - �������� ����� - ����� ��������.
//
// Revision 1.14.4.21  2005/11/09 16:14:29  lulin
// - bug fix: � Shift'�� ���� ����������� �������� ��� ������ ���������.
//
// Revision 1.14.4.20  2005/09/23 16:03:55  lulin
// - ������� ������ � ������ ������������.
//
// Revision 1.14.4.19  2005/07/20 18:21:14  lulin
// - ����� ���������� ���������.
//
// Revision 1.14.4.18  2005/07/18 11:22:37  lulin
// - ������, ������������� ��������� �� ��������� ���� ����� ���������� ��������.
//
// Revision 1.14.4.17  2005/07/15 10:14:03  lulin
// - ����������� �� ������������� ����������� ������� �������������� �����������.
//
// Revision 1.14.4.16  2005/07/11 06:07:06  lulin
// - ����������� �������� �����������.
//
// Revision 1.14.4.15  2005/07/07 15:10:38  lulin
// - new behavior: ������ HotSpot ���������� ����� � ������� ��������� ������.
//
// Revision 1.14.4.14  2005/07/07 13:09:28  lulin
// - ����������� �������� �����������.
//
// Revision 1.14.4.13  2005/06/21 13:54:53  lulin
// - cleanup: ������� �������� ������.
//
// Revision 1.14.4.12  2005/06/16 11:24:12  lulin
// - ������ ��������� ��������� ���������� (��� ������ _QI � QT).
//
// Revision 1.14.4.11  2005/06/15 13:06:00  lulin
// - ������ ������������� ������ ��������� � ����� ����.
//
// Revision 1.14.4.10  2005/06/14 14:51:51  lulin
// - new interface: _InevSelection.
// - remove interface: IevSelection.
//
// Revision 1.14.4.9  2005/06/14 12:38:58  lulin
// - ��������� �� �������� ��������� ���������� (������ ���������� View).
//
// Revision 1.14.4.8  2005/06/07 13:43:47  lulin
// - ������ �������� ������.
//
// Revision 1.14.4.7  2005/06/07 12:46:30  lulin
// - �������������� ������ �������� � �������� �� ���������� (��� ������ � ���������).
//
// Revision 1.14.4.6  2005/06/03 12:08:19  lulin
// - cleanup: ������ �������� �����������.
//
// Revision 1.14.4.5  2005/06/02 12:33:08  lulin
// - ������ ������� ������ �������� ����� ��������� �� ��� ��������� �� �������.
//
// Revision 1.14.4.4  2005/06/01 16:22:25  lulin
// - remove unit: evIntf.
//
// Revision 1.14.4.3  2005/05/31 17:46:39  lulin
// - �������� ������� �������� � �������� ��������.
//
// Revision 1.14.4.2  2005/05/20 11:27:36  lulin
// - ����� TevBlock ������� � ��������� ������.
//
// Revision 1.14.4.1  2005/05/18 12:42:47  lulin
// - ����� ����� �����.
//
// Revision 1.12.2.2  2005/05/18 12:32:09  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.12.2.1  2005/04/28 09:18:30  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.13.2.1  2005/04/23 16:07:25  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.13  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.14  2005/04/28 15:03:38  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.13.2.1  2005/04/23 16:07:25  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.13  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.12  2005/04/07 15:42:05  lulin
// - cleanup.
//
// Revision 1.11  2005/03/28 11:32:08  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.10  2005/03/24 18:39:21  lulin
// - remove object: Tk2AtomR.
//
// Revision 1.9  2005/03/10 14:58:38  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.8  2004/11/10 11:06:08  lulin
// - new interface: IevTagShape.
// - remove interface: IevVisualShapedTag.
//
// Revision 1.7  2003/10/02 16:33:24  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.6  2003/02/13 12:50:53  law
// - cleanup: l3IQueryInterface, l3IBQueryInterface ������������� � l3QueryInterface, Supports.
//
// Revision 1.5  2003/01/14 17:17:22  law
// - bug fix: ������ ��� ��������� inherited MouseAction.
//
// Revision 1.4  2003/01/14 16:47:41  law
// - new class: TevSelectingHotSpotEx.
//
// Revision 1.3  2003/01/14 15:22:58  law
// - change: ���������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Units,

  k2Interfaces,
  k2InternalInterfaces,
  k2TagTool,

  evInternalInterfaces,
  evHotSpot,

  nevBase,
  nevTools,
  nevGUIInterfaces
  ;

type
  _nevParaListTool_Parent_ = TevHotSpot;
  {$Include nevParaListTool.imp.pas}
  TevSelectingHotSpot = class(_nevParaListTool_, IevAdvancedHotSpot)
   {* - ��������� ��������� IevAdvancedHotSpot ��� �������. }
    private
    //internal fields
      f_Block : InevRange;
      f_OriginPoint : InevBasePoint;
    protected
    //internal fields
      f_Origin : Tl3Point;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
(*      function  InitSelection(const aView : InevControlView;
                              const aPt     : TnevPoint;
                              out theStart  : Tl3Point;
                              out theFinish : Tl3Point): Bool;
        overload;
        virtual;
        {-}*)
      function  InitSelection(const aView : InevControlView;
                              const aPt       : InevBasePoint;
                              const theStart  : InevBasePoint;
                              const theFinish : InevBasePoint): Bool;
        overload;
        virtual;
        {-}
      function  SelectionTag : InevParaList;
        virtual;
        {-}
      function CanDrag: Boolean;
        {-}
    public
    //public methods
      class function Make(aTag       : Tl3Variant;
                          const aProcessor : Ik2Processor): IevAdvancedHotSpot;
        reintroduce;
        {-}
      function MouseAction(const aView : InevControlView;
                           aButton     : TevMouseButton;
                           anAction    : TevMouseAction;
                           const Keys  : TevMouseState;
                           var Effect  : TevMouseEffect): Bool;
        virtual;
        {* - ������������ ������� ����. }
  end;//TevSelectingHotSpot

  TevSelectingHotSpotEx = class(TevSelectingHotSpot)
    protected
    //internal fields
      f_ForeignHotSpot : IevAdvancedHotSpot;
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
        virtual;
        {* - ������������ ������� ����. }
    public
    //public methods
      function MouseAction(const aView : InevControlView;
                           aButton     : TevMouseButton;
                           anAction    : TevMouseAction;
                           const Keys  : TevMouseState;
                           var Effect  : TevMouseEffect): Bool;
        override;
        {* - ������������ ������� ����. }
  end;//TevSelectingHotSpotEx

implementation

uses
  SysUtils,
  
  l3Interfaces,
  l3InterfacesMisc,

  afwInterfaces,
  
  evConst,
  evParaTools
  ;

{$Include nevParaListTool.imp.pas}

// start class TevSelectingHotSpot

class function TevSelectingHotSpot.Make(aTag       : Tl3Variant;
                                        const aProcessor : Ik2Processor): IevAdvancedHotSpot;
  //reintroduce;
  {-}
var
 l_HS : TevSelectingHotSpot;
begin
 l_HS := Create(aTag, aProcessor);
 try
  Result := l_HS;
 finally
  l3Free(l_HS);
 end;//try..finally
end;

procedure TevSelectingHotSpot.Cleanup;
  //override;
  {-}
begin
 f_OriginPoint := nil;
 f_Block := nil;
 inherited;
end;

(*function TevSelectingHotSpot.InitSelection(const aView : InevControlView;
                                           const aPt     : TnevPoint;
                                           out theStart  : Tl3Point;
                                           out theFinish : Tl3Point): Bool;
  //virtual;
  {-}
begin
 Result := False;
 theStart := evPoint0;
 theFinish := evPoint0;
end;*)

function TevSelectingHotSpot.InitSelection(const aView : InevControlView;
                                           const aPt       : InevBasePoint;
                                           const theStart  : InevBasePoint;
                                           const theFinish : InevBasePoint): Bool;
  //overload;
  //virtual;
  {-}
(*var
 l_StartPoint  : Tl3Point;
 l_FinishPoint : Tl3Point;*)
begin
 Result := false;
 //Result := InitSelection(aView, aPt, l_StartPoint, l_FinishPoint);
end;

function TevSelectingHotSpot.SelectionTag : InevParaList;
  //virtual;
  {-}
begin
 Result := ParaX;
end;

function TevSelectingHotSpot.MouseAction(const aView : InevControlView;
                                         aButton     : TevMouseButton;
                                         anAction    : TevMouseAction;
                                         const Keys  : TevMouseState;
                                         var Effect  : TevMouseEffect): Bool;
  {* - ������������ ������� ����. }

var
 l_MousePoint : InevBasePoint;
 
  function MakeMousePointVisible: Boolean;
  var
   l_SV : InevSelectionView;
  begin//MakeMousePointVisible
   Result := false;
   if Supports(aView, InevSelectionView, l_SV) then
    try
     //aView.Control.ViewArea.Update;
     //l_MousePoint.MostInner.SetAtEnd(aView, true);
     Result := l_SV.MakePointVisible(l_MousePoint);
    finally
     l_SV := nil;
    end;//try..finally
  end;//MakeMousePointVisible

var
 l_Start      : InevBasePoint;
 l_Finish     : InevBasePoint;
begin
 case aButton of
  ev_mbLeft:
  begin
   case anAction of
    ev_maDown :
    begin
     Result := True;
     TnevPoint(f_Origin) := TnevPoint(Keys.rPoint);
     f_OriginPoint := aView.PointByPt(f_Origin);
     f_Block := nil;
     with SelectionTag do
      f_Block := Range(MakePoint, MakePoint);
    end;//ev_maDown
    ev_maMove :
    begin
     Result := False;
     if (f_Block <> nil)  then
     begin
      Result := true;
      f_Block.GetBorderPoints(l_Start, l_Finish);
      l_MousePoint := aView.PointByPt(Keys.rPoint);
      if (l_MousePoint = nil) then
      begin
       aView.Control.ViewArea.Update;
       l_MousePoint := aView.PointByPt(Keys.rPoint);
      end;//l_MousePoint = nil
      if InitSelection(aView, l_MousePoint, l_Start, l_Finish) then
      begin
       aView.Control.Selection.Select(f_Block, false);
       MakeMousePointVisible;
       aView.Control.ViewArea.Update;
      end//InitSelection(aView, l_MousePoint, l_Start, l_Finish)
      else
      if (l_MousePoint <> nil) then
      begin
       aView.Control.Selection.AddBlock(f_OriginPoint, l_MousePoint);
       MakeMousePointVisible;
       aView.Control.ViewArea.Update;
      end;//l_MousePoint <> nil
     end;//f_Block <> nil
    end;//ev_maMove
    else
     Result := False;
   end;//case anAction
  end;//ev_mbLeft
  else
   Result := False;
 end;//case aButton
end;

// start class TevSelectingHotSpotEx

procedure TevSelectingHotSpotEx.Cleanup;
  //override;
  {-}
begin
 f_ForeignHotSpot := nil;
 inherited;
end;

function TevSelectingHotSpotEx.MouseAction(const aView : InevControlView;
                                           aButton     : TevMouseButton;
                                           anAction    : TevMouseAction;
                                           const Keys  : TevMouseState;
                                           var Effect  : TevMouseEffect): Bool;
  //override;
  {* - ������������ ������� ����. }
begin
 if (f_ForeignHotSpot = nil) then
 begin
  inherited MouseAction(aView, aButton, anAction, Keys, Effect);
  Result := DoMouseAction(aView, aButton, anAction, Keys, Effect)
 end
 else
  Result := f_ForeignHotSpot.MouseAction(aView, aButton, anAction, Keys, Effect);
end;

function TevSelectingHotSpotEx.DoMouseAction(const aView : InevControlView;
                                             aButton     : TevMouseButton;
                                             anAction    : TevMouseAction;
                                             const Keys  : TevMouseState;
                                             var Effect  : TevMouseEffect): Bool;
  //virtual;
  {* - ������������ ������� ����. }
begin
 Result := False;
end;

function TevSelectingHotSpot.CanDrag: Boolean;
begin
 Result := True;
end;

end.

