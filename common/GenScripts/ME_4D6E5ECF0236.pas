unit MouseClickSupport.imp;

interface

uses
 l3IntfUses
 , Controls
;

type
 _MouseClickSupport_ = class
  {* ��������� �������� ����� �� ���������� }
  function GetKeyData: Integer;
  procedure MakeClick(aControl: TWinControl);
  procedure GetDeltaXY(var X: Integer;
   var Y: Integer);
   {* �������� ��������� "������" ������������ ������ �������� ���� ��������. }
 end;//_MouseClickSupport_
 
implementation

uses
 l3ImplUses
 , Types
 , Messages
 , Windows
;

end.
