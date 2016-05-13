unit Dialogs;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\Dialogs.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "Dialogs" MUID: (4AB0EE02004E)

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Classes
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
  protected
   procedure DoClose; virtual;
   procedure DoShow; virtual;
  public
   function Execute: Boolean; virtual; abstract;
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
 end;//TCommonDialog

 TOpenDialog = class(TCommonDialog)
  protected
   function DoCanClose: Boolean; virtual;
  public
   function Execute: Boolean; override;
 end;//TOpenDialog

 TSaveDialog = class(TOpenDialog)
 end;//TSaveDialog
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCommonDialog);
 {* Регистрация TCommonDialog }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOpenDialog);
 {* Регистрация TOpenDialog }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TSaveDialog);
 {* Регистрация TSaveDialog }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
