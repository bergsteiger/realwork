unit l3GraphicControlCanvas;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3GraphicControlCanvas.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Canvas::Tl3GraphicControlCanvas
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3ControlCanvas
  ;

type
 Tl3GraphicControlCanvas = class(Tl3ControlCanvas)
 public
 // public methods
   constructor Create(aControl: TGraphicControl); reintroduce;
 end;//Tl3GraphicControlCanvas

implementation

type
  TGraphicControlFriend = {abstract} class(TGraphicControl)
   {* ���� ��� TGraphicControl }
  end;//TGraphicControlFriend

// start class Tl3GraphicControlCanvas

constructor Tl3GraphicControlCanvas.Create(aControl: TGraphicControl);
//#UC START# *56B9CBE7022E_4F29376B00C7_var*
//#UC END# *56B9CBE7022E_4F29376B00C7_var*
begin
//#UC START# *56B9CBE7022E_4F29376B00C7_impl*
 inherited Create(aControl);
 BackColor := TGraphicControlFriend(aControl).Color;
 Canvas := TGraphicControlFriend(aControl).Canvas;
//#UC END# *56B9CBE7022E_4F29376B00C7_impl*
end;//Tl3GraphicControlCanvas.Create

end.