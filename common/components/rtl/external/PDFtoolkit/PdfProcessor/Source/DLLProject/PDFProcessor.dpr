library PDFProcessor;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  PDDocumentIntf in 'PDDocumentIntf.pas',
  PDPageIntf in 'PDPageIntf.pas',
  CoPDPage in 'CoPDPage.pas',
  CoPDDocument in 'CoPDDocument.pas',
  PDElementIntf in 'PDElementIntf.pas',
  PDAnnotIntf in 'PDAnnotIntf.pas',
  CoPDAnnot in 'CoPDAnnot.pas',
  gtObjectIntf in 'gtObjectIntf.pas',
  CoPDElement in 'CoPDElement.pas',
  CogtObject in 'CogtObject.pas',
  PDRectIntf in 'PDRectIntf.pas',
  COPDRect in 'COPDRect.pas',
  PDDocInfoIntf in 'PDDocInfoIntf.pas',
  CoPDDocInfo in 'CoPDDocInfo.pas',
  PDViewerPreferenceIntf in 'PDViewerPreferenceIntf.pas',
  CoPDViewerPreference in 'CoPDViewerPreference.pas',
  PDFormFieldIntf in 'PDFormFieldIntf.pas',
  CoPDFormField in 'CoPDFormField.pas',
  PDBookmarkIntf in 'PDBookmarkIntf.pas',
  CoPDBookmark in 'CoPDBookmark.pas',
  PDActionIntf in 'PDActionIntf.pas',
  CoPDAction in 'CoPDAction.pas',
  PDExportDeviceIntf in 'PDExportDeviceIntf.pas',
  CoPDExportDevice in 'CoPDExportDevice.pas',
  PDMatrixIntf in 'PDMatrixIntf.pas',
  CoPDMatrix in 'CoPDMatrix.pas',
  PDStateIntf in 'PDStateIntf.pas',
  CoPDState in 'CoPDState.pas';

{$R *.res}

exports
  NewPDDocument,
  FreePDDocument,
  NewPDPage,
  FreePDPage,
  NewPDRect,
  NewPDAnnot;
//  FreePDAnnot;

begin
end.
