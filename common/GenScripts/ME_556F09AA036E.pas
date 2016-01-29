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
  {*  анва дл€ вывода. }
 
 Il3Printer = interface
  {* ѕринтер. }
  procedure Refresh;
   {* ќбновл€ет список принтеров }
  function HasPrinter: Boolean;
   {* есть ли принтер дл€ печати. }
  procedure GetPrinter(ADevice: PChar;
   ADriver: PChar;
   APort: PChar;
   var ADeviceMode: THandle);
   {* получить параметры принтера. }
  procedure SetPrinter(ADevice: PChar;
   ADriver: PChar;
   APort: PChar;
   ADeviceMode: THandle);
   {* установить параметры принтера. }
  procedure BeginDoc;
   {* начать печать документа. }
  procedure EndDoc;
   {* закончить печать документа. }
  procedure NewPage;
   {* начать новую страницу. }
  function Clone: Il3Printer;
   {*  лонирует принтер }
 end;//Il3Printer
 
implementation

uses
 l3ImplUses
;

end.
