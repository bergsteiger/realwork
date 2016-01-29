
unit ieregctrl;

interface

{$I ie.inc}
{$R *.dcr}

procedure Register;

implementation

(*$ifdef IEKYLIX*)
uses Classes,imageen,hsvbox,imageenproc,imageenview,imageenio,histogrambox, rulerbox,iegradientbar,
	videocap,ievect,iemview,iemio,hvideocap,hyieutils;
(*$else*)
uses Classes,
{$ifndef IECPPBUILDER}
FiltEdit,
{$ifdef IEFIXDESIGNINT}
DesignIntf,
{$else}
DsgnIntf,
{$endif}
{$endif}
ImageEn, HSVBox, ImageEnProc, ImageEnView, ImageEnIO, HistogramBox, RulerBox,IEGradientBar,
	VideoCap,IEVect,IEMView,Iemio, IEOpenSaveDlg, hvideocap,hyieutils;
(*$endif*)

procedure Register;
begin
   {$ifdef IEINCLUDETIMAGEEN}
   RegisterComponents('ImageEn', [TImageEn]);
   {$endif}
   RegisterComponents('ImageEn', [TImageEnProc]);
   RegisterComponents('ImageEn', [TImageEnView]);
   (*$ifdef IEDELPHI*)
   RegisterComponents('ImageEn', [TImageEnVect]);
   (*$endif*)
   {$ifdef IEINCLUDEVIDEOCAPTURE}
   RegisterComponents('ImageEn', [TImageEnVideoView]);
   RegisterComponents('ImageEn', [TImageEnVideoCap]);
   {$endif}
   {$ifdef IEINCLUDEMULTIVIEW}
   RegisterComponents('ImageEn', [TImageEnMIO]);
   RegisterComponents('ImageEn', [TImageEnMView]);
   {$endif}
   RegisterComponents('ImageEn', [TImageEnIO]);
   RegisterComponents('ImageEn', [THistogramBox]);
   RegisterComponents('ImageEn', [TIEGradientBar]);
   RegisterComponents('ImageEn', [THSVBox]);
   (*$ifdef IEDELPHI*)
   RegisterComponents('ImageEn', [TOpenImageEnDialog]);
   RegisterComponents('ImageEn', [TSaveImageEnDialog]);
   RegisterComponents('ImageEn', [TRulerBox]);
   (*$endif*)
   {$ifndef IECPPBUILDER}
   (*$ifdef IEDELPHI*)
   RegisterPropertyEditor(TypeInfo(String), TOpenImageEnDialog, 'Filter',TFilterProperty);
   (*$endif*)
   {$endif}
end;


end.
