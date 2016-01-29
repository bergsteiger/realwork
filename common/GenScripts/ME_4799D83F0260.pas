unit l3Printer;

interface

uses
 l3IntfUses
 , l3PrinterInterfaces
 , Classes
 , Printers
 , Windows
 , l3Units
 , l3Interfaces
;

type
 Tl3CastablePrinter = class(TPrinter)
  {* ѕринтер с методом QueryInterface. }
 end;//Tl3CastablePrinter
 
 Tl3Printer = class(_l3Unknown_, Il3Printer)
  function Make: Il3Printer;
  function LP2DP(const P: Tl3_Point): Tl3SPoint;
  function DP2LP(const P: Tl3_SPoint): Tl3Point;
  function HasPrinter: Boolean;
   {* есть ли принтер дл€ печати. }
  function PrinterIndex: Integer;
   {* индекс текущего принтера. }
  function Title: Il3CString;
   {* заголовок задани€ печати. }
  function FileName: AnsiString;
   {* »м€ файла - куда печатать. }
  function DC: hDC;
   {* контекст печати. }
  function Canvas: TCanvas;
   {* канва дл€ печати. }
  function Printers: TStrings;
   {* список доступных принтеров. }
  function Orientation: Tl3PageOrientation;
   {* ориентаци€ текущей страницы. }
  function Printing: Boolean;
   {* находимс€ в процессе печати? }
  function PageHeight: Integer;
   {* высота текущей страницы. }
  function PageWidth: Integer;
   {* ширина текущей страницы. }
  function Copies: Integer;
   {* количество печатаемых копий. }
  function PaperExtent: Tl3_Point;
   {* –азмер бумаги. }
  function Clone: Il3Printer;
   {*  лонирует принтер }
  function Collate: Boolean;
  function CanCollate: Boolean;
  procedure Refresh;
   {* ќбновл€ет список принтеров }
 end;//Tl3Printer
 
implementation

uses
 l3ImplUses
 , l3PrinterIC
 , l3InternalInterfaces
 , l3Defaults
 , l3Base
 , SysUtils
 , l3String
 , l3Const
 , l3Math
 , Consts
 , l3Core
 , l3MemUtils
 , l3Interlocked
;

type
 THackPrinter = class(TObject)
 end;//THackPrinter
 
end.
