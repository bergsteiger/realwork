unit evFramedParaListPainter;

interface

uses
 l3IntfUses
 , evParaListPainter
 , l3Interfaces
 , l3InternalInterfaces
 , nevRealTools
;

type
 TevFramedParaListPainter = class(_evDelayedPainters_)
  {* ����� ���������������� ��� ����������� ������ }
  function GetFameObjectBehaviur: Tl3FrameObjectBehaviour;
  function GetColorArray: Tl3LinesColorArray;
  function NeedLog: Boolean;
   {* ������������ �� ��������� ������ ������ � ��� ��� ������. }
 end;//TevFramedParaListPainter
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Graphics
 , k2Base
 , k2Tags
 , l3Units
 , l3Base
 , evDelayedPaintersSpy
;

end.
