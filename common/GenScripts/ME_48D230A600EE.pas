unit evButtonControl;

interface

uses
 l3IntfUses
 , evControl
 , evQueryCardInt
 , nevTools
 , nevBase
;

type
 TevButtonControl = class(TevControl, IevEditorControlButton, IevEditorStateButton)
  {* ����� ������ }
  procedure IncButtonState;
   {* �������� ��������� ������ }
  function GetButtonType: TevButtonType;
  function StateCount: Integer;
   {* ���������� ���������. }
  function CurrentIndex: Integer;
   {* ������� �������� ��� �����������. }
  function ImageIndex: Integer;
   {* ��������� ����� ��������. }
  function GetStateIndex: Integer;
   {* ���������� ���������� ��������� ������ �� 0 �� �������������. }
  function DoLMouseBtnUp(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   anInPara: Boolean): Boolean;
  function DoLMouseBtnDown(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   anInPara: Boolean;
   const aMap: InevMap): Boolean;
 end;//TevButtonControl
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evQueryCardDropControlsInt
 , evQueryCardConst
 , l3String
 , OvcConst
 , SysUtils
 , l3Units
 , l3Base
;

end.
