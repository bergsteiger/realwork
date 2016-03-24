unit StdCtrls;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\StdCtrls.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "StdCtrls" MUID: (48C78D5402A6)

interface

{$If NOT Defined(NoVCL)}
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
  protected
   procedure AdjustBounds; virtual;
   {$If Defined(l3HackedVCL)}
   function GetLabelText: AnsiString; virtual;
   {$IfEnd} // Defined(l3HackedVCL)
   procedure DoDrawText(var Rect: TRect;
    Flags: Integer); virtual;
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
  protected
   procedure Change; virtual;
 end;//TCustomEdit

 TComboBoxStyle = (
 );//TComboBoxStyle

 TListBox = class
 end;//TListBox

 TEdit = class(TCustomEdit)
 end;//TEdit
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TCustomLabel.AdjustBounds;
//#UC START# *4F2A44BC0297_4F29268F035C_var*
//#UC END# *4F2A44BC0297_4F29268F035C_var*
begin
//#UC START# *4F2A44BC0297_4F29268F035C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A44BC0297_4F29268F035C_impl*
end;//TCustomLabel.AdjustBounds

{$If Defined(l3HackedVCL)}
function TCustomLabel.GetLabelText: AnsiString;
//#UC START# *4F2A45C40091_4F29268F035C_var*
//#UC END# *4F2A45C40091_4F29268F035C_var*
begin
//#UC START# *4F2A45C40091_4F29268F035C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A45C40091_4F29268F035C_impl*
end;//TCustomLabel.GetLabelText
{$IfEnd} // Defined(l3HackedVCL)

procedure TCustomLabel.DoDrawText(var Rect: TRect;
 Flags: Integer);
//#UC START# *4F2A461702D8_4F29268F035C_var*
//#UC END# *4F2A461702D8_4F29268F035C_var*
begin
//#UC START# *4F2A461702D8_4F29268F035C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A461702D8_4F29268F035C_impl*
end;//TCustomLabel.DoDrawText

procedure TCustomEdit.Change;
//#UC START# *554CAA8400E5_52A9AE070267_var*
//#UC END# *554CAA8400E5_52A9AE070267_var*
begin
//#UC START# *554CAA8400E5_52A9AE070267_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CAA8400E5_52A9AE070267_impl*
end;//TCustomEdit.Change

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomLabel);
 {* Регистрация TCustomLabel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TRadioButton);
 {* Регистрация TRadioButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomEdit);
 {* Регистрация TCustomEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TEdit);
 {* Регистрация TEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
