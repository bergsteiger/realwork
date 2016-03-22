unit l3PrinterInterfaces;

// ������: "w:\common\components\rtl\Garant\L3\l3PrinterInterfaces.pas"
// ���������: "Interfaces"
// ������� ������: "l3PrinterInterfaces" MUID: (556F09AA036E)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

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
  ['{D81ECD1A-CE19-4262-BE7C-58A1401F2C7E}']
  function Get_PrinterIndex: Integer;
  procedure Set_PrinterIndex(aValue: Integer);
  function Get_Title: Il3CString;
  procedure Set_Title(const aValue: Il3CString);
  function Get_FileName: AnsiString;
  procedure Set_FileName(const aValue: AnsiString);
  function Get_Printing: Boolean;
  function Get_PageHeight: Integer;
  function Get_PageWidth: Integer;
  function Get_Copies: Integer;
  procedure Set_Copies(aValue: Integer);
  function Get_Collate: Boolean;
  procedure Set_Collate(aValue: Boolean);
  function Get_CanCollate: Boolean;
  function Get_DC: hDC;
  function Get_Canvas: TCanvas;
  function Get_Printers: TStrings;
  function Get_Orientation: Tl3PageOrientation;
  procedure Set_Orientation(aValue: Tl3PageOrientation);
  function Get_PaperExtent: Tl3_Point;
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
  property PrinterIndex: Integer
   read Get_PrinterIndex
   write Set_PrinterIndex;
   {* ������ �������� ��������. }
  property Title: Il3CString
   read Get_Title
   write Set_Title;
   {* ��������� ������� ������. }
  property FileName: AnsiString
   read Get_FileName
   write Set_FileName;
   {* ��� ����� - ���� ��������. }
  property Printing: Boolean
   read Get_Printing;
   {* ��������� � �������� ������? }
  property PageHeight: Integer
   read Get_PageHeight;
   {* ������ ������� ��������. }
  property PageWidth: Integer
   read Get_PageWidth;
   {* ������ ������� ��������. }
  property Copies: Integer
   read Get_Copies
   write Set_Copies;
   {* ���������� ���������� �����. }
  property Collate: Boolean
   read Get_Collate
   write Set_Collate;
  property CanCollate: Boolean
   read Get_CanCollate;
  property DC: hDC
   read Get_DC;
   {* �������� ������. }
  property Canvas: TCanvas
   read Get_Canvas;
   {* ����� ��� ������. }
  property Printers: TStrings
   read Get_Printers;
   {* ������ ��������� ���������. }
  property Orientation: Tl3PageOrientation
   read Get_Orientation
   write Set_Orientation;
   {* ���������� ������� ��������. }
  property PaperExtent: Tl3_Point
   read Get_PaperExtent;
   {* ������ ������. }
 end;//Il3Printer

implementation

uses
 l3ImplUses
;

end.
