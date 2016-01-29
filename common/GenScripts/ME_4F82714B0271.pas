unit vcmLayoutImplementation;

interface

uses
 l3IntfUses
 , l3ProtoObjectWithCOMQI
 , vcmInterfaces
 , Controls
;

type
 IvcmLayoutInternal = interface
  procedure ClearLinkToControl;
 end;//IvcmLayoutInternal
 
 TvcmLayoutImplementation = class(Tl3ProtoObjectWithCOMQI, IvcmLayout, IvcmLayoutInternal)
  procedure Create(aControl: TWinControl);
  function Make(aControl: TWinControl): IvcmLayout;
  function GetIsAcceptable(aDataUpdate: Boolean): Boolean;
   {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
  procedure ClearLinkToControl;
  function VCLWinControl: TWinControl;
  function IsAcceptable(aDataUpdate: Boolean): Boolean;
   {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
 end;//TvcmLayoutImplementation
 
implementation

uses
 l3ImplUses
;

end.
