unit GarantPDFDocument;

interface

uses
 l3IntfUses
 , SynPDF
 , Graphics
;

type
 TGarantPDFDocument = class(TPdfDocument)
  {* ���������� ��� ���� ������ PDF-�����. }
  procedure InitPrinterPxPerInch(anPPIX: Integer;
   anPPIY: Integer);
  procedure Create(aPPX: Integer;
   aPPY: Integer;
   aForEtalon: Boolean);
  procedure RenderNewPage(aMetaFile: TMetafile;
   anOrientation: Boolean);
   {* ������������������ ��������� ��� ����� ����. }
 end;//TGarantPDFDocument
 
implementation

uses
 l3ImplUses
 , Windows
;

end.
