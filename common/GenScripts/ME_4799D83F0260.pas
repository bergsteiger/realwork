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
  {* ������� � ������� QueryInterface. }
 end;//Tl3CastablePrinter
 
 Tl3Printer = class(_l3Unknown_, Il3Printer)
  function Make: Il3Printer;
  function LP2DP(const P: Tl3_Point): Tl3SPoint;
  function DP2LP(const P: Tl3_SPoint): Tl3Point;
  function HasPrinter: Boolean;
   {* ���� �� ������� ��� ������. }
  function PrinterIndex: Integer;
   {* ������ �������� ��������. }
  function Title: Il3CString;
   {* ��������� ������� ������. }
  function FileName: AnsiString;
   {* ��� ����� - ���� ��������. }
  function DC: hDC;
   {* �������� ������. }
  function Canvas: TCanvas;
   {* ����� ��� ������. }
  function Printers: TStrings;
   {* ������ ��������� ���������. }
  function Orientation: Tl3PageOrientation;
   {* ���������� ������� ��������. }
  function Printing: Boolean;
   {* ��������� � �������� ������? }
  function PageHeight: Integer;
   {* ������ ������� ��������. }
  function PageWidth: Integer;
   {* ������ ������� ��������. }
  function Copies: Integer;
   {* ���������� ���������� �����. }
  function PaperExtent: Tl3_Point;
   {* ������ ������. }
  function Clone: Il3Printer;
   {* ��������� ������� }
  function Collate: Boolean;
  function CanCollate: Boolean;
  procedure Refresh;
   {* ��������� ������ ��������� }
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
