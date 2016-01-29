{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }


unit PDPageIntf;

interface

uses
  PDElementIntf, PDAnnotIntf, gtObjectIntf, PDBaseObjectIntf, PDRectIntf;

type

  TPageSize = packed record
    Width: Double;
    Height: Double;
  end;

  IgtPDPage = Class(IgtPDElement)
    procedure Update;Virtual;abstract;
    procedure AddAnnot(AddAfter: Integer; Annot: IgtPDAnnot);Virtual;abstract;
//    function AddNewAnnot(AddAfter: Integer; AnnotType: TgtPDAnnotType;
//      InitialRect: TgtPDRect): TgtPDAnnot;
//    function CreateAnnot(AnnotType: TgtPDAnnotType;
//      InitialLocation: TgtPDRect): TgtPDAnnot;

    function GetPageSize: TPageSize;Virtual;abstract;
    function GetPageHeight: Double;Virtual;abstract;
    function GetPageWidth: Double;Virtual;abstract;
//    function GetAnnots: TgtPDAnnotList;
//    function GetActions: TgtPDAction;
    procedure ReplaceContents(NewContents: IgtPDBaseObject);Virtual;abstract;
//    procedure AddResource(ResType: TgtPDResourceType; const ResName: string;
//      ResObject: TgtPDBaseObject);
//
//    procedure EnumFontResources(FontEnumEvent: TgtPDEnumFontEvent);
//    procedure EnumXObjectResources(XObjectEnumEvent: TgtPDEnumXObjectEvent);
//    procedure EnumColorSpaceResources(ColorSpaceEnumEvent:
//      TgtPDEnumColorSpaceEvent);
//    procedure EnumProcSetResources(ProcSetEnumEvent: TgtPDEnumProcSetEvent);

//    procedure Display(OutDev: TgtPDExportDevice; hDPI, vDPI: Double;
//      Rotate: Integer; UseMediaBox: Boolean; Crop: Boolean; Printing: Boolean);
//    procedure DisplaySlice(OutDev: TgtPDExportDevice; hDPI: Double; vDPI: Double;
//      Rotate: Integer; UseMediaBox: Boolean; Crop: Boolean; SliceX: Integer;
//      SliceY: Integer; SliceW: Integer; SliceH: Integer; Printing:Boolean);
//    procedure MakeBox(hDPI: Double; vDPI: Double; Rotate: Integer;
//      UseMediaBox: Boolean; UpsideDown: Boolean; SliceX: Integer;
//      SliceY: Integer; SliceW: Integer; SliceH: Integer; Box: TgtPDRect;
//      var Crop: Boolean);
//    procedure ProcessLinks(OutDev: TgtPDExportDevice; Catatlog: TgtPDElement);
//    procedure GetDefaultCTM(Matix: TgtPDMatrix; hDPI: Double; vDPI: Double;
//      Rotate: Integer; uSeMediaBox, UpsideDown: Boolean);


    function GetPageNum: Integer;Virtual;abstract;
    function GetMediaBox: IgtPDRect;Virtual;abstract;
    function GetCropBox: IgtPDRect;Virtual;abstract;
    function GetBleedBox: IgtPDRect;Virtual;abstract;
    function GetTrimBox: IgtPDRect;Virtual;abstract;
    function GetRotate: Integer;Virtual;abstract;
    procedure SetRotate(ARotate: Integer);Virtual;abstract;
    function GetDuration: Integer;Virtual;abstract;
    procedure SetDuration(ADuration: Integer);Virtual;abstract;
//    function GetContents: IgtPDContents;
//    function GetResources: IgtPDResources;
    procedure Delete;Virtual;abstract;
  end;

{$IFDEF DLLIMPORT}
  function NewPDPage(AParentDoc: IgtObject; AParentElement: IgtPDElement;
      ABaseObject: IgtPDBaseObject): IgtPDPage; stdcall;
  procedure FreePage(Apage: IgtPDPage); stdcall;
{$ENDIF}

implementation

{$IFDEF DLLIMPORT}
  function NewPDPage; external 'PDFProcessor.dll';
  procedure FreePage; external 'PDFProcessor.dll';
{$ENDIF}


end.
