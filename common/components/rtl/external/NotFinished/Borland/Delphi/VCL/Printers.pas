unit Printers;
 {* TPrinter encapsulates the Windows printer interface. }

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\Printers.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "Printers" MUID: (4799D2E6027B)

interface

uses
 l3IntfUses
 , SysUtils
;

type
 EPrinter = class(Exception)
 end;//EPrinter

 TPrinter = class(TObject)
  {* TPrinter encapsulates the Windows printer interface. }
 end;//TPrinter

 TPrinterState = (
  psNoHandle
  , psHandleIC
  , psHandleDC
 );//TPrinterState

 TPrinterOrientation = (
  poPortrait
  , poLandscape
 );//TPrinterOrientation

 TPrinterCapability = (
  pcCopies
  , pcOrientation
  , pcCollation
 );//TPrinterCapability

 TPrinterCapabilities = set of TPrinterCapability;

procedure Printer; overload;
function Printer: TPrinter; overload;
function SetPrinter(NewPrinter: TPrinter): TPrinter;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4799D2E6027Bimpl_uses*
 //#UC END# *4799D2E6027Bimpl_uses*
;

procedure Printer;
//#UC START# *4AE1D63601CB_4799D2E6027B_var*
//#UC END# *4AE1D63601CB_4799D2E6027B_var*
begin
//#UC START# *4AE1D63601CB_4799D2E6027B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE1D63601CB_4799D2E6027B_impl*
end;//Printer

function Printer: TPrinter;
//#UC START# *4799F731014C_4799D2E6027B_var*
//#UC END# *4799F731014C_4799D2E6027B_var*
begin
//#UC START# *4799F731014C_4799D2E6027B_impl*
 assert(false, 'Printer not implemented');
//#UC END# *4799F731014C_4799D2E6027B_impl*
end;//Printer

function SetPrinter(NewPrinter: TPrinter): TPrinter;
//#UC START# *4799F74602BA_4799D2E6027B_var*
//#UC END# *4799F74602BA_4799D2E6027B_var*
begin
//#UC START# *4799F74602BA_4799D2E6027B_impl*
 assert(false, 'SetPrinter not implemented');
//#UC END# *4799F74602BA_4799D2E6027B_impl*
end;//SetPrinter

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EPrinter));
 {* Регистрация типа EPrinter }
{$IfEnd} // NOT Defined(NoScripts)

end.
