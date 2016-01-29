unit StdCtrls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Vcl"
// Модуль: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Vcl/StdCtrls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Core::Vcl::Implementation::StdCtrls
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoVCL)}
uses
  Types,
  Controls
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
 // protected methods
   procedure AdjustBounds; virtual;
    {$If defined(l3HackedVCL) AND not defined(NoVCL)}
   function GetLabelText: AnsiString; virtual;
    {$IfEnd} //l3HackedVCL AND not NoVCL
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

 TScrollEvent = procedure (Sender: TObject;
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
 // protected methods
   procedure Change; virtual;
     {* Сигнатура метода Change }
 end;//TCustomEdit

 TComboBoxStyle = (
   
 );//TComboBoxStyle

 TListBox = class
 end;//TListBox

 TEdit = class(TCustomEdit)
 end;//TEdit
{$IfEnd} //not NoVCL

implementation

{$If not defined(NoVCL)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TCustomLabel

procedure TCustomLabel.AdjustBounds;
//#UC START# *4F2A44BC0297_4F29268F035C_var*
//#UC END# *4F2A44BC0297_4F29268F035C_var*
begin
//#UC START# *4F2A44BC0297_4F29268F035C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A44BC0297_4F29268F035C_impl*
end;//TCustomLabel.AdjustBounds

{$If defined(l3HackedVCL) AND not defined(NoVCL)}
function TCustomLabel.GetLabelText: AnsiString;
//#UC START# *4F2A45C40091_4F29268F035C_var*
//#UC END# *4F2A45C40091_4F29268F035C_var*
begin
//#UC START# *4F2A45C40091_4F29268F035C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A45C40091_4F29268F035C_impl*
end;//TCustomLabel.GetLabelText
{$IfEnd} //l3HackedVCL AND not NoVCL

procedure TCustomLabel.DoDrawText(var Rect: TRect;
  Flags: Integer);
//#UC START# *4F2A461702D8_4F29268F035C_var*
//#UC END# *4F2A461702D8_4F29268F035C_var*
begin
//#UC START# *4F2A461702D8_4F29268F035C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A461702D8_4F29268F035C_impl*
end;//TCustomLabel.DoDrawText
// start class TCustomEdit

procedure TCustomEdit.Change;
//#UC START# *554CAA8400E5_52A9AE070267_var*
//#UC END# *554CAA8400E5_52A9AE070267_var*
begin
//#UC START# *554CAA8400E5_52A9AE070267_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CAA8400E5_52A9AE070267_impl*
end;//TCustomEdit.Change
{$IfEnd} //not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация TCustomLabel
 TtfwClassRef.Register(TCustomLabel);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация TRadioButton
 TtfwClassRef.Register(TRadioButton);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация TCustomEdit
 TtfwClassRef.Register(TCustomEdit);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация TEdit
 TtfwClassRef.Register(TEdit);
{$IfEnd} //not NoScripts AND not NoVCL

end.