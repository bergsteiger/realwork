unit evPDFWriter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evPDFWriter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Printing::TevPDFWriter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evCustomPDFWriter
  ;

type
 TevPDFWriter = class(TevCustomPDFWriter)
 protected
 // realized methods
   procedure ExportPDF; override;
 end;//TevPDFWriter

implementation

uses
  evDocumentPreview,
  nevBase,
  ddPDFExporter,
  nevDocumentProvider4PDF,
  nevTools
  ;

// start class TevPDFWriter

procedure TevPDFWriter.ExportPDF;
//#UC START# *53FEE4FE01CB_53FEE940022B_var*
var
 l_DocPara  : InevPara;
 l_Preview  : TevDocumentPreview;
 l_Storable : InevStorable;
 l_Exporter : TddPDFExporter;
//#UC END# *53FEE4FE01CB_53FEE940022B_var*
begin
//#UC START# *53FEE4FE01CB_53FEE940022B_impl*
 l_DocPara := GetDocument;
 if l_DocPara.QT(InevStorable, l_Storable) then
  try
   l_Preview := TevDocumentPreview.Create(TnevDocumentProvider4PDF.Make(l_Storable, l_DocPara.AsObject), evDefaultPreviewCacheKey, nil);
   try
    l_Exporter := TddPDFExporter.Create(Filer.Stream);
    try
     l_Preview.Print2PDF(l_Exporter.GetCanvas(l_Preview.Printer));
    finally
     l_Exporter.Free;
    end;
   finally
    l_Preview.Free;
   end;
  finally
   l_DocPara := nil;
   l_Storable := nil;
  end
 else
  Assert(false);
//#UC END# *53FEE4FE01CB_53FEE940022B_impl*
end;//TevPDFWriter.ExportPDF

end.