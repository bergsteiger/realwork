unit nevControlPara;

interface

uses
 l3IntfUses
 , nevTextPara
 , nevTools
 , evQueryCardInt
 , l3Variant
 , l3Interfaces
 , evdTypes
 , nevBase
 , l3StringIDEx
;

type
 TnevControlPara = class(TnevTextPara, IevCommonControl, IevControl, IevControlFriend)
  function Make(aTag: Tl3Variant): IevControlFriend;
  function Enabled: Boolean;
   {* ����������� �����. }
  function Checked: Boolean;
   {* ������ ������/��������. }
  function Flat: Boolean;
   {* ����������� �����. <?> ��, ��� ���������� �����������? }
  function Name: Tl3WString;
   {* ��� ��������. }
  function Text: Tl3WString;
   {* ����� ��������. }
  function ControlType: TevControlType;
   {* ��� ��������. }
  function Upper: Boolean;
   {* ������ ��� �����. }
  function Collapsed: Boolean;
  function GetControl: IevEditorControl;
   {* �������� ������� �� ������. }
 end;//TnevControlPara
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3String
 , afwFacade
 , afwInterfaces
 , l3MessageID
;

end.
