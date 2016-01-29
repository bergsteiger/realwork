unit evSectionBreakHotSpot;
{* ���������� "������� �����" ��� ������� ������. }

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evSectionBreakHotSpot - }
{ �����: 06.10.2000 17:24 }
{ $Id: evSectionBreakHotSpot.pas,v 1.26 2014/04/21 11:45:00 lulin Exp $ }

// $Log: evSectionBreakHotSpot.pas,v $
// Revision 1.26  2014/04/21 11:45:00  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.25  2014/04/07 17:56:59  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.24  2011/11/23 11:37:00  dinishev
// {Requestlink:290951663}
//
// Revision 1.23  2011/09/13 10:48:06  lulin
// {RequestLink:278839709}.
//
// Revision 1.22  2011/04/14 16:19:20  lulin
// {RequestLink:257822128}.
//
// Revision 1.21  2011/02/15 11:24:49  lulin
// {RequestLink:231670346}.
//
// Revision 1.20  2010/03/02 13:34:35  lulin
// {RequestLink:193823544}.
//
// Revision 1.19  2010/03/01 14:50:06  lulin
// {RequestLink:193823544}.
// - ��� ������.
//
// Revision 1.18  2009/07/10 16:15:41  lulin
// - ����������� �� ������� ������� ��������� ������.
//
// Revision 1.17  2009/06/25 15:02:54  lulin
// {RequestLink:149784312}.
//
// Revision 1.16  2009/06/01 16:07:31  lulin
// [$148574348].
//
// Revision 1.15  2009/05/29 17:18:25  lulin
// [$142610853].
//
// Revision 1.14  2008/12/12 19:19:14  lulin
// - <K>: 129762414.
//
// Revision 1.13  2007/12/04 12:47:04  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.9.8.23  2007/07/04 08:30:16  dinishev
// Bug fix: �� ����������� ��������� _IevHotSpotSink ��� �������� _TevHotSpotWrap. ��-�� ����� ������� ����� ������������ ���� ��� ������� ��������.
//
// Revision 1.9.8.22  2007/02/12 17:15:59  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.9.8.21  2007/02/12 16:40:20  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.9.8.20  2007/01/24 10:21:42  oman
// - new: ����������� ��������� - ev (cq24078)
//
// Revision 1.9.8.19  2006/11/03 11:00:06  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.9.8.18.2.8  2006/10/31 09:21:18  lulin
// - ��� ������ ������� ����� ������ ��� ����������� ����� ��������������.
//
// Revision 1.9.8.18.2.7  2006/10/23 08:58:09  lulin
// - ������ ��� ����������� "������� �����" �������� ������� ������.
//
// Revision 1.9.8.18.2.6  2006/10/19 13:33:18  lulin
// - ��������� ������� � ��������� �� ����� ������.
//
// Revision 1.9.8.18.2.5  2006/10/19 12:05:43  lulin
// - �������� ����� ��� ��������� ���������� � ������� �������.
//
// Revision 1.9.8.18.2.4  2006/10/19 10:56:17  lulin
// - ��������� ������� ��������� � ����� ����� ����������.
//
// Revision 1.9.8.18.2.3  2006/10/18 14:02:40  lulin
// - ����������� �� �������� �� ����������� �������� ����� ������ ����.
//
// Revision 1.9.8.18.2.2  2006/10/18 13:06:34  lulin
// - �������� �������� ������.
//
// Revision 1.9.8.18.2.1  2006/10/18 12:45:03  lulin
// - ������ �������� ��������.
//
// Revision 1.9.8.18  2006/10/06 15:26:45  lulin
// - ������ ����������� ��������������� ��������� ���������� �� ���������, ����������� ��������� ������� �����.
//
// Revision 1.9.8.17  2006/10/06 13:25:38  lulin
// - ������ ��� ������ ���������� �� ���������, ����������� ��������� ������� �����.
//
// Revision 1.9.8.16  2006/10/06 08:19:42  lulin
// - ���������� �������� �������� - ����� ������� �����.
//
// Revision 1.9.8.15.2.2  2006/10/04 15:17:08  lulin
// - ���������� �������� �������� - ����� ������� �����.
//
// Revision 1.9.8.15.2.1  2006/10/04 14:10:20  lulin
// - �������� �������� ��������� ������� �����.
//
// Revision 1.9.8.15  2006/10/04 11:23:02  lulin
// - ��� ��������� ������� ����� �������� "���������" �������.
//
// Revision 1.9.8.14  2006/10/04 08:32:06  lulin
// - ������ ������������� ��������� ��� ��������� ����� ����������� ���������� - ����� ����� ���� ��������� ���������.
//
// Revision 1.9.8.13  2006/10/04 06:23:44  lulin
// - ����� ���� ����������� � ��������� ����.
//
// Revision 1.9.8.12  2006/10/04 04:33:51  lulin
// - ����������� �� ������������� �������� � ����� OLE.
//
// Revision 1.9.8.11  2006/10/03 13:56:23  lulin
// - �������� �������������� ��������� ��������� "������� �����".
//
// Revision 1.9.8.10  2006/07/20 18:36:56  lulin
// - ��� ������ ������ �� ������������ - ����� �� ���������� ����������� �������.
//
// Revision 1.9.8.9  2006/07/03 11:58:53  lulin
// - �������� �� ��������� ������, � "��������� ����".
//
// Revision 1.9.8.8  2005/11/09 16:14:29  lulin
// - bug fix: � Shift'�� ���� ����������� �������� ��� ������ ���������.
//
// Revision 1.9.8.7  2005/11/09 15:28:24  lulin
// - ������� ���������� ���������� � ���������� ������.
//
// Revision 1.9.8.6  2005/09/23 12:27:38  lulin
// - ����������� ����� ���������� � ����� �������.
//
// Revision 1.9.8.5  2005/07/07 15:10:38  lulin
// - new behavior: ������ HotSpot ���������� ����� � ������� ��������� ������.
//
// Revision 1.9.8.4  2005/07/07 11:41:17  lulin
// - �������� � _GetAdvancedHotSpot ����������� ��������� InevViewPoint.
//
// Revision 1.9.8.3  2005/06/14 12:38:58  lulin
// - ��������� �� �������� ��������� ���������� (������ ���������� View).
//
// Revision 1.9.8.2  2005/06/14 10:01:30  lulin
// - ��������� �� �������� ��������� ���������� (������ ���������� View).
//
// Revision 1.9.8.1  2005/06/11 08:55:38  lulin
// - � �����-�� ���� ������������� ����������������� HotSpot'��.
//
// Revision 1.9  2005/03/28 11:32:08  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.8  2005/03/21 16:28:16  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.7  2004/03/25 16:28:41  law
// - new method: TevSectionBreakHotSpotTester._Make.
//
// Revision 1.6  2002/07/09 12:02:21  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.5  2001/11/26 14:31:04  law
// - change type: Keys: Long -> Keys: TShiftState.
//
// Revision 1.4  2001/09/05 07:22:26  law
// - comments: xHelpGen.
//
// Revision 1.3  2001/04/12 16:35:26  law
// - new behavior: ������� ������ ��� ��������� � �����.
//
// Revision 1.2  2000/12/15 15:10:37  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  l3IID,
  l3Types,
  l3Base,

  l3Units,

  afwInterfaces,

  k2Interfaces,
  k2InternalInterfaces,
  k2TagTool,

  evInternalInterfaces,
  evSectionImplementation,
  evHotSpot,

  nevTools,
  nevInterfaces,
  nevGUIInterfaces
  ;

type
  TevSectionBreakHotSpotTester = class(TevHotSpot,  
                                       InevHotSpotTester2,
                                       IevAdvancedHotSpot)
   {* ���������� "������� �����" ��� ������� ������. }
    private
    // internal fields
      f_Section : TevSection;
    protected
    // property methods
      // IevHotSpot
      procedure DoHitTest(const aView  : InevControlView;
                        const aState : TafwCursorState;
                        var theInfo  : TafwCursorInfo);
        override;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure CheckSection;
        {-}
      function CanDrag: Boolean;
        {-} 
    public
    // public methods
      class function Make(aTagWrap   : Tl3Variant;
                          const aProcessor : Ik2Processor): InevHotSpotTester2;
        reintroduce;                  
        {* - ������� ������. }
      // InevHotSpotTester2
      function GetAdvancedHotSpot(const aView  : InevControlView;
                                  const aState : TevCursorState;
                                  const aPt    : InevBasePoint;
                                  const aMap   : InevMap;
                                  out theSpot  : IevHotSpot): Boolean;
        {-}
      // IevAdvancedHotSpot
      function MouseAction(const aView : InevControlView;
                           aButton     : TevMouseButton;
                           anAction    : TevMouseAction;
                           const Keys  : TevMouseState;
                           var Effect  : TevMouseEffect): Bool;
        {-}
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
  end;//TevSectionBreakHotSpotTester

implementation

uses
  l3Const,
  l3Interfaces,
  l3String,

  evdDOM,

  evHotSpotMisc
  ;

// start class TevSectionBreakHotSpotTester

class function TevSectionBreakHotSpotTester.Make(aTagWrap   : Tl3Variant;
                                                 const aProcessor : Ik2Processor): InevHotSpotTester2;
  {* - ������� ������. }
var
 l_Tester : TevSectionBreakHotSpotTester;
begin
 l_Tester := Create(aTagWrap, aProcessor);
 try
  Result := l_Tester;
 finally
  l3Free(l_Tester);
 end;//tryt..finally
end;

procedure TevSectionBreakHotSpotTester.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_Section);
 inherited;
end;

procedure TevSectionBreakHotSpotTester.CheckSection;
  {-}
begin
 if (f_Section = nil) then
  f_Section := TevSection.Create(GetRedirect, Processor);
end;                                                
  
function TevSectionBreakHotSpotTester.GetAdvancedHotSpot(const aView  : InevControlView;
                                                         const aState : TevCursorState;
                                                         const aPt    : InevBasePoint;
                                                         const aMap   : InevMap;
                                                         out theSpot  : IevHotSpot): Boolean;
  {-}
var
 l_HotSpotSink: IevHotSpotSink; 
begin
 Result := True;
 aView.Control.QueryInterface(IevHotSpotSink, l_HotSpotSink);
 theSpot := TevHotSpotWrap.Make(Self, l_HotSpotSink);
end;

procedure TevSectionBreakHotSpotTester.DoHitTest(const aView  : InevControlView;
                                               const aState : TafwCursorState;
                                               var theInfo  : TafwCursorInfo);
  //override;
  {-}
begin
 inherited;
 theInfo.rCursor := ev_csDefault;
 theInfo.rHint := str_nevmhhBlockParams.AsCStr;
end;

function TevSectionBreakHotSpotTester.MouseAction(const aView : InevControlView;
                                                  aButton     : TevMouseButton;
                                                  anAction    : TevMouseAction;
                                                  const Keys  : TevMouseState;
                                                  var Effect  : TevMouseEffect): Bool;
  {-}
begin
 CheckSection;
 Result := false;
end;

function TevSectionBreakHotSpotTester.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  {override;}
  {-}
begin
 if IID.EQ(IevdSection) then
 begin
  if (f_Section = nil) then
   Result := inherited COMQueryInterface(IID, Obj)
  else
  begin
   Result.SetOk;
   IevdSection(Obj) := f_Section;
  end;//f_Section = nil
 end//IID.EQ(IevdSection)
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;
  
function TevSectionBreakHotSpotTester.CanDrag: Boolean;
begin
 Result := True;
end;

end.

