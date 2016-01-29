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
   {* Контрол хранит начальную дату интервала. }
  function GetOtherField: IevEditorPhoneField;
   {* Другой контрол. }
 end;//TevPhoneEdit
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
