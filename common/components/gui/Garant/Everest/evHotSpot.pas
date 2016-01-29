unit evHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evHotSpot.pas"
// �����: 19.10.2006 15:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevHotSpot
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedHotSpot)}
uses
  afwInterfaces,
  k2ProcTagTool,
  nevTools,
  nevGUIInterfaces
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 TevHotSpot = class(Tk2ProcTagTool)
 public
 // realized methods
   procedure HitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo);
 protected
 // protected methods
   procedure DoHitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo); virtual;
 end;//TevHotSpot
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}

// start class TevHotSpot

procedure TevHotSpot.DoHitTest(const aView: InevControlView;
  const aState: TafwCursorState;
  var theInfo: TafwCursorInfo);
//#UC START# *4A267FC6016B_4A267FA903BA_var*
//#UC END# *4A267FC6016B_4A267FA903BA_var*
begin
//#UC START# *4A267FC6016B_4A267FA903BA_impl*
 // - ������ �� ������
//#UC END# *4A267FC6016B_4A267FA903BA_impl*
end;//TevHotSpot.DoHitTest

procedure TevHotSpot.HitTest(const aView: InevControlView;
  const aState: TafwCursorState;
  var theInfo: TafwCursorInfo);
//#UC START# *48E2622A03C4_4A267FA903BA_var*
//#UC END# *48E2622A03C4_4A267FA903BA_var*
begin
//#UC START# *48E2622A03C4_4A267FA903BA_impl*
 DoHitTest(aView, aState, theInfo);
//#UC END# *48E2622A03C4_4A267FA903BA_impl*
end;//TevHotSpot.HitTest

{$IfEnd} //evNeedHotSpot

end.