unit l3PrinterIC;
 {* ���������� �����. }

// ������: "w:\common\components\rtl\Garant\L3\l3PrinterIC.pas"
// ���������: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3InternalInterfaces
;

function l3PrnIC: Il3InfoCanvas;

implementation

uses
 l3ImplUses
 , Printers
 , l3ScreenIC
 , l3Canvas
 , l3Printer
 , l3Base
;

var f_PrnIC: Pointer = nil;
var f_InCreatePrnIC: Boolean = False;

procedure FreeInfoCanvas;
//#UC START# *4799F5200358_4799F47002E2_var*
//#UC END# *4799F5200358_4799F47002E2_var*
begin
//#UC START# *4799F5200358_4799F47002E2_impl*
 Il3InfoCanvas(f_PrnIC) := nil;
//#UC END# *4799F5200358_4799F47002E2_impl*
end;//FreeInfoCanvas

function l3PrnIC: Il3InfoCanvas;
//#UC START# *4799F4970301_4799F47002E2_var*
//#UC END# *4799F4970301_4799F47002E2_var*
begin
//#UC START# *4799F4970301_4799F47002E2_impl*
 if (Printer.Printers.Count > 0) then
 begin
  if f_InCreatePrnIC then
  // - ���� ����� ������� ������ ��� ������ EPrinter ������ ������������
  begin
   Result := l3CrtIC;
   Exit;
  end;//f_InCreatePrnIC
  if (f_PrnIC = nil) then
  begin
   f_InCreatePrnIC := true;
   try
    try
     Il3InfoCanvas(f_PrnIC) := Tl3Canvas.MakeForPrinting(Tl3Printer.Make); // ����� ��������� ������ �������� � �������� ��� �������� (!) ������� ���� ����� ������
     Il3InfoCanvas(f_PrnIC).DC;
    except
     on EPrinter do
     begin
      Il3InfoCanvas(f_PrnIC) := l3CrtIC;
     end;//on EPrinter
    end;//try..except
   finally
    f_InCreatePrnIC := false;
   end;//try..finally
   l3System.AddExitProc(FreeInfoCanvas);
  end;//f_PrnIC = nil
  Result := Il3InfoCanvas(f_PrnIC);
  if (Result = nil) then
   Result := l3CrtIC;
 end//Printer.Printers.Count > 0
 else
  Result := l3CrtIC;
//#UC END# *4799F4970301_4799F47002E2_impl*
end;//l3PrnIC

end.
