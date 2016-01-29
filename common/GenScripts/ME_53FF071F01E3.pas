unit ddPDFExporter;

interface

uses
 l3IntfUses
 , Printers
 , l3Canvas
 , l3PrinterInterfaces
 , l3Core
 , l3Units
 , l3InternalInterfaces
 , l3SimpleObject
 , l3Metafile
 , Classes
 , GarantPDFDocument
;

type
 IddPDFDoc = interface
  {* Интерфейс для управления созданием интерфейса. }
  procedure NewPage(aOrientation: TPrinterOrientation);
  procedure EndDoc;
 end;//IddPDFDoc
 
 TddPDFExporter = class;
 
 TddPDFCanvas = class(Tl3Canvas)
  {* Канвая для экспорта. }
  procedure Create(const anExpoter: TddPDFExporter;
   const aPrinter: Il3Printer);
 end;//TddPDFCanvas
 
 TddPDFExporter = class(Tl3SimpleObject, IddPDFDoc)
  {* Класс-обертка над gtPDFEng. }
  procedure CheckMetaFile;
  procedure ClearMetaFile;
  procedure CreatePDFEngine;
  procedure DeInitPDFEngine;
  procedure CreateCanvas(const aPrinter: Il3Printer);
  procedure DropMetaFile2PDF;
  procedure Create(aFileStream: TStream);
  function GetCanvas(const aPrinter: Il3Printer): Il3Canvas;
  procedure NewPage(aOrientation: TPrinterOrientation);
  procedure EndDoc;
 end;//TddPDFExporter
 
implementation

uses
 l3ImplUses
 , Graphics
 , SysUtils
 , l3Defaults
 , ddPicturePathListner
 , l3Math
 , l3Const
 , Windows
 , SynPDF
;

end.
