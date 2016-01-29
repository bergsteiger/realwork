unit l3PrinterInterfaces;

interface

uses
 l3IntfUses
 , Graphics
 , l3Interfaces
 , l3Core
;

type
 TCanvas = Graphics.TCanvas;
  {* ����� ��� ������. }
 
 Il3Printer = interface
  {* �������. }
  procedure Refresh;
   {* ��������� ������ ��������� }
  function HasPrinter: Boolean;
   {* ���� �� ������� ��� ������. }
  procedure GetPrinter(ADevice: PChar;
   ADriver: PChar;
   APort: PChar;
   var ADeviceMode: THandle);
   {* �������� ��������� ��������. }
  procedure SetPrinter(ADevice: PChar;
   ADriver: PChar;
   APort: PChar;
   ADeviceMode: THandle);
   {* ���������� ��������� ��������. }
  procedure BeginDoc;
   {* ������ ������ ���������. }
  procedure EndDoc;
   {* ��������� ������ ���������. }
  procedure NewPage;
   {* ������ ����� ��������. }
  function Clone: Il3Printer;
   {* ��������� ������� }
 end;//Il3Printer
 
implementation

uses
 l3ImplUses
;

end.
