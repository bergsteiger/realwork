unit evPhoneEdit;

interface

uses
 l3IntfUses
 , evEditControl
 , evQueryCardInt
;

type
 TevPhoneEdit = class(TevEditControl, IevEditorPhoneField)
  function IsStart: Boolean;
   {* ������� ������ ��������� ���� ���������. }
  function GetOtherField: IevEditorPhoneField;
   {* ������ �������. }
 end;//TevPhoneEdit
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
