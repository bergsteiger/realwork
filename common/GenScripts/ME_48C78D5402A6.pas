unit StdCtrls;

interface

uses
 l3IntfUses
 , Controls
 , Types
;

type
 TScrollStyle = (
  {* Identifies a set of scrollbars by their orientation }
  ssNone
  , ssHorizontal
  , ssVertical
  , ssBoth
 );//TScrollStyle
 
 TCheckBoxState = (
 );//TCheckBoxState
 
 TButton = class
 end;//TButton
 
 TScrollBar = class
 end;//TScrollBar
 
 TCustomLabel = class(TGraphicControl)
  procedure AdjustBounds;
  function GetLabelText: AnsiString;
  procedure DoDrawText(var Rect: TRect;
   Flags: Integer);
 end;//TCustomLabel
 
 TRadioButton = class
 end;//TRadioButton
 
 TCustomCheckBox = class
 end;//TCustomCheckBox
 
 TCheckBox = class(TCustomCheckBox)
 end;//TCheckBox
 
 TScrollCode = (
 );//TScrollCode
 
 TScrollEvent = procedure(Sender: TObject;
  ScrollCode: TScrollCode;
  var ScrollPos: Integer) of object;
 
 TCustomCombo = class
 end;//TCustomCombo
 
 TCustomComboBox = class(TCustomCombo)
 end;//TCustomComboBox
 
 TComboBox = class(TCustomComboBox)
 end;//TComboBox
 
 TCustomEdit = class(TWinControl)
  procedure Change;
 end;//TCustomEdit
 
 TComboBoxStyle = (
 );//TComboBoxStyle
 
 TListBox = class
 end;//TListBox
 
 TEdit = class(TCustomEdit)
 end;//TEdit
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
