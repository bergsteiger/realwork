unit vtCombo;

interface

uses
 l3IntfUses
 , Mask
 , l3Interfaces
 , Controls
;

type
 TvtSimpleCustomCombo = class(TCustomMaskEdit)
  procedure DoCloseUp(Accept: Boolean);
  function ProcessCommand(Cmd: Tl3OperationCode;
   aForce: Boolean;
   aCount: Integer): Boolean;
  procedure UpdateButtonPosition;
  procedure DropDown;
  procedure CloseUp(Accept: Boolean);
 end;//TvtSimpleCustomCombo
 
 TvtCustomCombo = class(TvtSimpleCustomCombo)
  function GetDropDownContainer: TWinControl;
 end;//TvtCustomCombo
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

end.
