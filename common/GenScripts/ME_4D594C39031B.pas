unit evTextParaHeaderHotSpot;

interface

uses
 l3IntfUses
 , evHotSpot
 , nevGUIInterfaces
 , nevTools
 , nevBase
 , afwInterfaces
 , l3StringIDEx
;

type
 TevTextParaHeaderHotSpot = class(TevHotSpot, IevHotSpot)
  {* HotSpot �� ��������� ��������� }
  procedure Create(const aPara: InevPara;
   const aProcessor: InevProcessor);
  function Make(const aPara: InevPara;
   const aProcessor: InevProcessor): IevHotSpot;
  procedure DoCollapse(const aView: InevControlView);
  function MouseMove(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ����������� ���� }
  function LButtonDown(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� ����� ������ ���� }
  function LButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ���������� ����� ������ ���� }
  function LButtonDoubleClick(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� ������� ����� ������ ���� }
  function RButtonDown(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ������� ������ ������ ���� }
  function RButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ���������� ������ ������� ���� }
  function MButtonDown(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ������� ������ ���� }
  function MButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ���������� ������ ���� }
  function CanDrag: Boolean;
 end;//TevTextParaHeaderHotSpot
 
implementation

uses
 l3ImplUses
 , l3MessageID
 , evParaTools
 , k2Tags
 , evdStyles
;

end.
