unit Printers;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Vcl"
// ������: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Vcl/Printers.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Core::Vcl::Printing::Printers
//
// TPrinter encapsulates the Windows printer interface.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  SysUtils
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

function Printer: TPrinter; overload; 
function SetPrinter(NewPrinter: TPrinter): TPrinter;
procedure Printer; overload; 
   {* ��������� ������ Printer }

implementation

// unit methods

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

end.