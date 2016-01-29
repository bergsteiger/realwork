unit Dialogs;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Vcl"
// Модуль: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Vcl/Dialogs.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Core::Vcl::Implementation::Dialogs
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoVCL)}
uses
  Classes
  ;

type
 TMsgDlgBtn = (
   
 );//TMsgDlgBtn

 TMsgDlgButtons = set of TMsgDlgBtn;

 TMsgDlgType = (
   
 );//TMsgDlgType

 TOpenOption = (
   
 );//TOpenOption

 TOpenOptions = set of TOpenOption;

 TCommonDialog = class(TComponent)
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
 protected
 // protected methods
   procedure DoClose; virtual;
   procedure DoShow; virtual;
 public
 // public methods
   function Execute: Boolean; virtual; abstract;
 end;//TCommonDialog

 TOpenDialog = class(TCommonDialog)
 protected
 // realized methods
   function Execute: Boolean; override;
 protected
 // protected methods
   function DoCanClose: Boolean; virtual;
 end;//TOpenDialog

 TSaveDialog = class(TOpenDialog)
 end;//TSaveDialog
{$IfEnd} //not NoVCL

implementation

{$If not defined(NoVCL)}
// start class TCommonDialog

procedure TCommonDialog.DoClose;
//#UC START# *4DCC1EF50061_4DCC0B2702A0_var*
//#UC END# *4DCC1EF50061_4DCC0B2702A0_var*
begin
//#UC START# *4DCC1EF50061_4DCC0B2702A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DCC1EF50061_4DCC0B2702A0_impl*
end;//TCommonDialog.DoClose

procedure TCommonDialog.DoShow;
//#UC START# *4DCC1FEE0352_4DCC0B2702A0_var*
//#UC END# *4DCC1FEE0352_4DCC0B2702A0_var*
begin
//#UC START# *4DCC1FEE0352_4DCC0B2702A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DCC1FEE0352_4DCC0B2702A0_impl*
end;//TCommonDialog.DoShow

constructor TCommonDialog.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4DCC0B2702A0_var*
//#UC END# *47D1602000C6_4DCC0B2702A0_var*
begin
//#UC START# *47D1602000C6_4DCC0B2702A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D1602000C6_4DCC0B2702A0_impl*
end;//TCommonDialog.Create

destructor TCommonDialog.Destroy;
//#UC START# *48077504027E_4DCC0B2702A0_var*
//#UC END# *48077504027E_4DCC0B2702A0_var*
begin
//#UC START# *48077504027E_4DCC0B2702A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *48077504027E_4DCC0B2702A0_impl*
end;//TCommonDialog.Destroy
// start class TOpenDialog

function TOpenDialog.DoCanClose: Boolean;
//#UC START# *4DCC203E0199_4DA44E2C0153_var*
//#UC END# *4DCC203E0199_4DA44E2C0153_var*
begin
//#UC START# *4DCC203E0199_4DA44E2C0153_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DCC203E0199_4DA44E2C0153_impl*
end;//TOpenDialog.DoCanClose

function TOpenDialog.Execute: Boolean;
//#UC START# *4DCC20C10116_4DA44E2C0153_var*
//#UC END# *4DCC20C10116_4DA44E2C0153_var*
begin
//#UC START# *4DCC20C10116_4DA44E2C0153_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DCC20C10116_4DA44E2C0153_impl*
end;//TOpenDialog.Execute
{$IfEnd} //not NoVCL
end.