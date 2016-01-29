(*
Copyright (c) 1998-2004 by HiComponents. All rights reserved.

This software comes without any warranty either implied or expressed.
In no case shall the author be liable for any damage or unwanted behavior of any
computer hardware and/or software.

HiComponents grants you the right to include the compiled component
in your application, whether COMMERCIAL, SHAREWARE, or FREEWARE,
BUT YOU MAY NOT DISTRIBUTE THIS SOURCE CODE OR ITS COMPILED .DCU IN ANY FORM.

ImageEn may not be included in any commercial, shareware or freeware DELPHI
libraries or components.

email: support@hicomponents.com

http://www.hicomponents.com

*)

unit iemio;

{$R-}
{$Q-}


{$I ie.inc}

{$ifdef IEINCLUDEMULTIVIEW}

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ImageEnView, ImageEnProc, ExtCtrls, hyiedefs, ImageEnIO,ieview,
  {$ifdef IEINCLUDEWIA}
  iewia,
  {$endif}
  hyieutils;

type

  TImageEnMIO = class(TComponent)
  private
    { Private declarations }
    fImageEnMView:TIEView;
    fImageEnMViewIdx:integer; // bitmap change index (-1=nothing)
    fParams:TList;	// lista di TIOParamasVals (uno per ogni frame)
    fSimplifiedParamsDialogs:boolean;
    {$ifdef IEINCLUDETWAIN}
    fTwainParams:TIETWainParams;
    {$endif}
    // WIA
    {$ifdef IEINCLUDEWIA}
    fWIA:TIEWia;
    {$endif}
    fMsgLanguage:TMsgLanguage;
    fPreviewsParams:TIOPreviewsParams;
    fPreviewFont:TFont;
    fTWainNextToInsert:integer;	// index of next image to insert (twain multipage acq.)
    fAutoAdjustDPI:boolean;
    fFilteredAdjustDPI:boolean;
    fDefaultDitherMethod:TIEDitherMethod;
    fResetPrinter:boolean;
    fDialogsMeasureUnit:TIEDialogsMeasureUnit;
    // TWain modeless
    fgrec:pointer;
    //
    procedure SetAttachedMView(v:TIEView);
    procedure RemoveIOParam(idx:integer);
    procedure InsertIOParam(idx:integer);
    function GetParams(idx:integer):TIOParamsVals;
    procedure SetPreviewFont(f:TFont);
    function GetParamsCount:integer;
    procedure SetIOPreviewParams(v:TIOPreviewsParams);
    function GetIOPreviewParams:TIOPreviewsParams;
  protected
    { Protected declarations }
    fAborting:boolean;
    fOnProgress:TIEProgressEvent;
    fOnAcquireBitmap:TIEAcquireBitmapEvent;
    fOnFinishWork:TNotifyEvent;
    procedure TWMultiCallBack( Bitmap:TIEBitmap; var IOParams:TObject); virtual;
    procedure TWCloseCallBack; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure OnBitmapChange(Sender:TObject; destroying:boolean);
    procedure DoFinishWork; virtual;
    {$ifdef IEINCLUDEWIA}
    function GetWIAParams:TIEWia; virtual;
    {$endif}
    procedure CheckDPI(p:TIOParamsVals);
  public
    { Public declarations }
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure Update;
    property DefaultDitherMethod:TIEDitherMethod read fDefaultDitherMethod write fDefaultDitherMethod;
    // Other
    property Params[idx:integer]:TIOParamsVals read GetParams;
    property ParamsCount:integer read GetParamsCount;
    procedure DuplicateCompressionInfo;
    {$ifdef IEINCLUDEDIALOGIO}
    function DoPreviews(idx:integer; pp:TPreviewParams):boolean;
    {$endif}
    {$ifdef IEINCLUDETWAIN}
    property TWainParams:TIETWainParams read fTWainParams;
    {$endif}
    {$ifdef IEINCLUDEWIA}
    property WIAParams:TIEWia read GetWIAParams;
    {$endif}
    property Aborting:boolean read fAborting write fAborting;
    // GIF
    procedure LoadFromFileGif(const nf:AnsiString);
    procedure LoadFromStreamGif(Stream:TStream);
    procedure SaveToFileGif(const nf:AnsiString);
    procedure SaveToStreamGif(Stream:TStream);
    // TIFF
    procedure LoadFromFileTIFF(const nf:AnsiString);
    procedure LoadFromStreamTIFF(Stream:TStream);
    procedure SaveToFileTIFF(const nf:AnsiString);
    procedure SaveToStreamTIFF(Stream:TStream);
    // AVI
    procedure LoadFromFileAVI(const nf:AnsiString);
    {$ifdef IESUPPORTDEFPARAMS}
    procedure SaveToFileAVI(const nf:AnsiString; const codec:AnsiString='');
    {$else}
    procedure SaveToFileAVI(const nf:AnsiString; const codec:AnsiString);
    {$endif}
    // PostScript (PS)
    procedure SaveToFilePS(const nf:AnsiString);
    procedure SaveToStreamPS(Stream:TStream);
    // Adobe PDF
    procedure SaveToFilePDF(const nf:AnsiString);
    procedure SaveToStreamPDF(Stream:TStream);
    // ICO
    procedure LoadFromFileICO(const nf:AnsiString);
    procedure LoadFromStreamICO(Stream:TStream);
    // TWAIN
    {$ifdef IEINCLUDETWAIN}
       {$ifdef IESUPPORTDEFPARAMS}
    function Acquire(api:TIEAcquireApi=ieaTWain):boolean;
    function SelectAcquireSource(api:TIEAcquireApi=ieaTWain):boolean;
       {$else}
    function Acquire(api:TIEAcquireApi):boolean;
    function SelectAcquireSource(api:TIEAcquireApi):boolean;
       {$endif}
    function AcquireOpen:boolean;
    procedure AcquireClose;
    {$endif}
    // General
    procedure LoadFromFile(const nf:AnsiString);
    procedure SaveToFile(const nf:AnsiString);
    {$ifdef IEINCLUDEOPENSAVEDIALOGS}
       {$ifdef IESUPPORTDEFPARAMS}
    function ExecuteOpenDialog(InitialDir:AnsiString=''; InitialFileName:AnsiString=''; AlwaysAnimate:boolean=True; FilterIndex:integer=1; ExtendedFilters:AnsiString=''):AnsiString;
    function ExecuteSaveDialog(InitialDir:AnsiString=''; InitialFileName:AnsiString=''; AlwaysAnimate:boolean=False; FilterIndex:integer=1; ExtendedFilters:AnsiString=''):AnsiString;
       {$else}
    function ExecuteOpenDialog(InitialDir:AnsiString; InitialFileName:AnsiString; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:AnsiString):AnsiString;
    function ExecuteSaveDialog(InitialDir:AnsiString; InitialFileName:AnsiString; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:AnsiString):AnsiString;
       {$endif}
    {$endif}
    {$ifdef IEINCLUDEPRINTDIALOGS}
       {$ifdef IESUPPORTDEFPARAMS}
    function DoPrintPreviewDialog(const TaskName:AnsiString=''):boolean;
       {$else}
    function DoPrintPreviewDialog(const TaskName:AnsiString):boolean;
       {$endif}
    {$endif}
    property ResetPrinter:boolean read fResetPrinter write fResetPrinter;
  published
    { Published declarations }
    property AttachedMView:TIEView read fImageEnMView write SetAttachedMView;
    property OnProgress:TIEProgressEvent read fOnProgress write fOnProgress;
    property OnAcquireBitmap:TIEAcquireBitmapEvent read fOnAcquireBitmap write fOnAcquireBitmap;
    property MsgLanguage:TMsgLanguage read fMsgLanguage write fMsgLanguage default msSystem;
    property PreviewsParams:TIOPreviewsParams read GetIOPreviewParams write SetIOPreviewParams default [];
    property PreviewFont:TFont read fPreviewFont write SetPreviewFont;
    property AutoAdjustDPI:boolean read fAutoAdjustDPI write fAutoAdjustDPI default false;
    property FilteredAdjustDPI:boolean read fFilteredAdjustDPI write fFilteredAdjustDPI default false;
    property SimplifiedParamsDialogs:boolean read fSimplifiedParamsDialogs write fSimplifiedParamsDialogs default true;
    property OnFinishWork:TNotifyEvent read fOnFinishWork write fOnFinishWork;
    property DialogsMeasureUnit:TIEDialogsMeasureUnit read fDialogsMeasureUnit write fDialogsMeasureUnit default ieduInches;
  end;

implementation

uses GIFFilter,TIFFilt,IEVfw,imscan,iopreviews,IEMView,IEOpenSaveDlg,bmpfilt,ieprnform3;

{$R-}


/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.SetAttachedMView(v:TIEView);
begin
	if assigned(fImageEnMView) then
   	fImageEnMView.RemoveBitmapChangeEvent(fImageEnMViewIdx);	// rimuove precedente, se c'è
   fImageEnMView:=v;
   if assigned(fImageEnMView) then begin // fImageEnMView ora potrebbe anche essere nil
      fImageEnMView.FreeNotification(self);
      fImageEnMViewIdx:=fImageEnMView.RegisterBitmapChangeEvent(OnBitmapChange);
      // synchronize parameters count
      while fParams.Count < (fImageEnMview as TImageEnMView).ImageCount do
         InsertIOParam(fParams.Count);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.Notification(AComponent: TComponent; Operation: TOperation);
begin
	inherited Notification(AComponent, Operation);
	if (AComponent=fImageEnMView) and (Operation=opRemove) then begin
	   fImageEnMView.RemoveBitmapChangeEvent(fImageEnMViewIdx);
   	fImageEnMView:=nil;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
constructor TImageEnMIO.Create(Owner: TComponent);
begin
	inherited Create(Owner);
	//
   fImageEnMViewIdx:=-1;
   fAborting:=false;
   fImageEnMView:=nil;
   fOnProgress:=nil;
   fOnFinishWork:=nil;
   fParams:=TList.Create;
   {$ifdef IEINCLUDETWAIN}
   fTWainParams:=TIETWainParams.Create(Self);
   {$endif}
   fPreviewsParams:=[];
   fPreviewFont:=TFont.Create;
   fMsgLanguage:=msSystem;
   fAutoAdjustDPI:=false;
   fFilteredAdjustDPI:=false;
   fOnAcquireBitmap:=nil;
   fgrec:=nil;
   fDefaultDitherMethod:=ieThreshold;
   SimplifiedParamsDialogs:=true;
   {$ifdef IEINCLUDEWIA}
   fWIA:=nil;
   {$endif}
   fResetPrinter:=true;
   fDialogsMeasureUnit:=ieduInches;
end;

/////////////////////////////////////////////////////////////////////////////////////
destructor TImageEnMIO.Destroy;
begin
	if assigned(fImageEnMView) then
   	fImageEnMView.RemoveBitmapChangeEvent(fImageEnMViewIdx);
   while fParams.Count>0 do
   	RemoveIOParam(0);
   fParams.free;
   {$ifdef IEINCLUDETWAIN}
   fTWainParams.free;
   {$endif}
   {$ifdef IEINCLUDEWIA}
   if assigned(fWia) then
   	fWia.free;
   {$endif}
   fPreviewFont.free;
   inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.Update;
begin
   if assigned(fImageEnMView) then
     	with fImageEnMView do begin
	      Update;
	      ImageChange;
      end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rimuove l'oggetto parametri IO per l'immagine idx
procedure TImageEnMIO.RemoveIOParam(idx:integer);
var
	q:integer;
begin
	TIOParamsVals( fParams[idx] ).free;
   fParams.Delete(idx);
   // sort image indexes
   for q:=0 to fParams.Count-1 do begin
   	TIOParamsVals(fParams[q]).TIFF_ImageIndex:=q;
		TIOParamsVals(fParams[q]).GIF_ImageIndex:=q;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Inserisce un nuovo oggetto parametri IO alla posizione idx
// I valori dell'oggetto vengono presettati a quelli dell'oggetto precedente (se esiste),
// o dell'elemento successivo (se esiste), cioè dell'elemento idx prima che venga
// inserito il nuovo.
procedure TImageEnMIO.InsertIOParam(idx:integer);
var
	iop:TIOParamsVals;
   q:integer;
begin
	iop:=TIOparamsVals.Create(nil);
   if fParams.Count>0 then begin
   	if idx>=fParams.Count then
			iop.Assign( TIOParamsVals(fParams[idx-1]) )
      else
	      iop.Assign( TIOParamsVals(fParams[idx]) );
   end;
	if idx<fParams.Count then
   	// insert
      fParams.Insert(idx, iop)
   else
   	// add
		fParams.Add(iop);
   // riordina indici immagini
   for q:=0 to fParams.Count-1 do begin
   	TIOParamsVals(fParams[q]).TIFF_ImageIndex:=q;
		TIOParamsVals(fParams[q]).GIF_ImageIndex:=q;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// (chiamato dal meccanismo RegisterBitmapChangeEvent)
// Riallinea i parametri di I/O con l'oggetto TImageEnMView associato
procedure TImageEnMIO.OnBitmapChange(Sender:TObject; destroying:boolean);
var
	lop,lidx:integer;
begin
	if destroying then
   	fImageEnMView:=nil
	else if assigned(fImageEnMView) then begin
		lop:=(fImageEnMView as TImageEnMView).GetLastOp;
      lidx:=(fImageEnMView as TImageEnMView).GetLastOpIdx;
      if lop=1 then
      	// Insert dell'immagine lidx
			InsertIOParam(lidx)
      else if lop=2 then
      	// delete dell'immagine lidx
         RemoveIOParam(lidx);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnMIO.GetParams(idx:integer):TIOParamsVals;
begin
	if (idx>=0) and (idx<fParams.Count) then
		result:=TIOParamsVals(fParams[idx])
   else
   	result:=nil;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnMIO.GetParamsCount:integer;
begin
	result:=fParams.Count;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.LoadFromFileGif(const nf:AnsiString);
var
	fs:TFileStream;
begin
	fAborting:=False;
	fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
	LoadFromStreamGif(fs);
   fs.free;
end;


/////////////////////////////////////////////////////////////////////////////////////
// Inserisce dalla posizione selezionata fImageEnMView.SelectedImage
// Chiama Update
procedure TImageEnMIO.LoadFromStreamGif(Stream:TStream);
var
	bmp,xbmp,merged:TIEBitmap;
   numi,p1,idx:integer;
   Progress,Progress2:TProgressRec;
   Param:TIOParamsVals;
   ld,im:integer;	// last delay
   tempAlphaChannel:TIEMask;
   dummy1:ppointerarray;
   dummy2,dummy3:pinteger;
   act:TIEGifAction;
   backx,backy,backw,backh:integer;
   dx,dy:integer;
begin
	if not assigned(fImageEnMView) then exit;
   try
   fAborting:=False;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   Progress.Aborting:=@fAborting;
   Progress2.fOnProgress:=nil;
   Progress2.Sender:=nil;
   Progress2.Aborting:=@fAborting;
   p1:=Stream.Position;
   idx:=imax((fImageEnMView as TImageEnMView).SelectedImage,0);
   ld:=10;	// 10ms default
   im:=0;
   merged:=TIEBitmap.Create;
   merged.Location:=ieTBitmap;
   act:=ioGIF_None;
   backw:=0;
   backh:=0;
   backx:=0;
   backy:=0;
   repeat
   	(fImageEnMView as TImageEnMView).InsertImageEx(idx);
   	bmp:=TIEBitmap.Create;
      Param:=TIOParamsVals(fParams[idx]);
      Stream.position:=p1;
      Param.GIF_ImageIndex:=im;
      tempAlphaChannel:=nil;
   	ReadGifStream(Stream,bmp,numi,Param,Progress2,False,tempAlphaChannel,false);
      dx:=imax(Param.GIF_WinWidth,bmp.Width);
      dy:=imax(Param.GIF_WinHeight,bmp.Height);
      if assigned(tempAlphaChannel) then begin
         bmp.AlphaChannel.CopyFromTIEMask(tempAlphaChannel);
         tempAlphaChannel.free;
      end;
      if fAutoAdjustDPI then
      	xbmp:=IEAdjustDPI(bmp,Param,fFilteredAdjustDPI)
      else
      	xbmp:=bmp;
      if bmp<>xbmp then
      	bmp.free;
      bmp:=xbmp;
      //

      if numi>1 then begin
         if act=ioGIF_DrawBackground then begin
            merged.FillRect(backx,backy,backx+backw-1,backy+backh-1,TRGB2TColor(param.GIF_Background));
         end;
         if (merged.Width=0) or (bmp.PixelFormat<>merged.PixelFormat) then begin
            merged.Allocate(dx,dy,bmp.PixelFormat);
            merged.Fill( TRGB2TColor( param.GIF_Background ));
         end;
         if (dx>merged.Width) or (dy>merged.Height) then
            merged.Resize(dx,dy,TRGB2TColor( param.GIF_Background ),255,iehLeft,ievTop);
         dummy1:=nil;
         dummy2:=nil;
         dummy3:=nil;
         bmp.RenderToTBitmap(merged.VclBitmap,dummy1,dummy2,dummy3,nil,Param.GIF_XPos,Param.GIF_YPos,bmp.Width,bmp.Height,0,0,bmp.Width,bmp.Height, true ,false,255,rfNone,true,ielNormal);
         backw:=bmp.Width;
         backh:=bmp.Height;
         backx:=Param.GIF_XPos;
         backy:=Param.GIF_YPos;
         bmp.free;
         bmp:=merged;
         act:=param.GIF_Action;	// act refers to the action of next image
      end;

      //
      Param.Gif_ImageIndex:=idx;
      Param.TIFF_ImageIndex:=idx;
      Param.FileType:=ioGIF;
      Param.fFileName:='';
      if fAborting then begin
      	(fImageEnMView as TImageEnMView).DeleteImage(idx);
         bmp.free;
         break;
      end;
		if numi=0 then
         (fImageEnMView as TImageEnMView).DeleteImage(idx)
      else begin
	      Progress.per1:=100/numi;
	      (fImageEnMView as TImageEnMView).SetIEBitmapEx(idx,bmp);
	      (fImageEnMView as TImageEnMView).ImageBackground[idx]:=TRGB2TColor(Param.GIF_Background);
         if Param.Gif_DelayTime>0 then begin
		      (fImageEnMView as TImageEnMView).ImageDelayTime[idx]:=Param.GIF_DelayTime*10;
            ld:=Param.GIF_DelayTime*10;
         end else
				(fImageEnMView as TImageEnMView).ImageDelayTime[idx]:=ld;
      end;
      if bmp<>merged then
	      bmp.free;
      with Progress do
	      if assigned(fOnProgress) then
    	  		fOnProgress(Sender,trunc(per1*im));
      if fAborting then
      	break;
      inc(idx);
      inc(im);
   until im>=numi;
   merged.free;
   Update;
   finally
   	DoFinishWork;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.SaveToFileGif(const nf:AnsiString);
var
	fs:TFileStream;
begin
	fAborting:=False;
	fs:=TFileStream.Create(nf,fmCreate);
   SaveToStreamGif(fs);
   fs.free;
   _GifMakeAnimate(nf,0,0,0);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Salva tutte le immagini nel Gif-stream
procedure TImageEnMIO.SaveToStreamGif(Stream:TStream);
var
	p1,q:integer;
   Param:TIOParamsVals;
   Progress:TProgressRec;
   bmp:TIEBitmap;
  	nullpr:TProgressRec;
begin
	try
	fAborting:=False;
	if not assigned(fImageEnMView) then exit;
   if (fImageEnMView as TImageEnMView).ImageCount=0 then exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   Progress.Aborting:=@fAborting;
   with nullpr do begin
	   Aborting:=Progress.Aborting;
      fOnProgress:=nil;
      Sender:=nil;
	end;
   p1:=Stream.Position;
   Progress.per1:=100/(fImageEnMView as TImageEnMView).ImageCount;
   bmp:=TIEBitmap.Create;
   for q:=0 to (fImageEnMView as TImageEnMView).ImageCount-1 do begin
      Param:=TIOParamsVals(fParams[q]);
      Stream.position:=p1;
      (fImageEnMView as TImageEnMView).CopyToIEBitmap(q,bmp);
      bmp.DefaultDitherMethod:=fDefaultDitherMethod;
      if q=0 then
	      WriteGifStream(Stream,bmp,Param,NullPr)
      else
      	_InsertGifImStream(Stream,bmp,Param,NullPr);
      with Progress do
	      if assigned(fOnProgress) then
    	  		fOnProgress(Sender,trunc(per1*q));
      if fAborting then
      	break;
   end;
   bmp.free;
   finally
   	DoFinishWork;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.LoadFromFileTIFF(const nf:AnsiString);
var
	fs:TFileStream;
begin
	fAborting:=False;
	fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
	LoadFromStreamTIFF(fs);
   fs.free;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Assegna un delay di default di 100ms
procedure TImageEnMIO.LoadFromStreamTIFF(Stream:TStream);
var
	xbmp,bmp:TIEBitmap;
   numi,p1,idx:integer;
   Progress,Progress2:TProgressRec;
   Param:TIOParamsVals;
   im:integer;
   tempAlphaChannel:TIEMask;
begin
	fAborting:=False;
	if not assigned(fImageEnMView) then exit;
   try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   Progress.Aborting:=@fAborting;
   Progress2.fOnProgress:=nil;
   Progress2.Sender:=nil;
   Progress2.Aborting:=@fAborting;
   p1:=Stream.Position;
   idx:=imax((fImageEnMView as TImageEnMView).SelectedImage,0);
   im:=0;
   repeat
   	(fImageEnMView as TImageEnMView).InsertImageEx(idx);
   	bmp:=TIEBitmap.Create;
      Param:=TIOParamsVals(fParams[idx]);
      Stream.position:=p1;
      Param.TIFF_ImageIndex:=im;
      tempAlphaChannel:=nil;
      TIFFReadStream(bmp,Stream,numi,Param,Progress2,false,tempAlphaChannel,true,false,false);
      CheckDPI(Param);
      if assigned(tempAlphaChannel) then begin
         bmp.AlphaChannel.CopyFromTIEMask(tempAlphaChannel);
         tempAlphaChannel.free;
      end;
      if fAutoAdjustDPI then
      	xbmp:=IEAdjustDPI(bmp,Param,fFilteredAdjustDPI)
      else
      	xbmp:=bmp;
      if bmp<>xbmp then
      	bmp.free;
      bmp:=xbmp;
      Param.TIFF_ImageIndex:=idx;
      Param.GIF_ImageIndex:=idx;
	   Param.FileType:=ioTIFF;
      Param.fFileName:='';
      if fAborting then begin
      	(fImageEnMView as TImageEnMView).DeleteImage(idx);
         bmp.free;
         break;
      end;
		if numi=0 then
         (fImageEnMView as TImageEnMView).DeleteImage(idx)
      else begin
	      Progress.per1:=100/numi;
	      (fImageEnMView as TImageEnMView).SetIEBitmapEx(idx,bmp);
	      (fImageEnMView as TImageEnMView).ImageDelayTime[idx]:=100;
      end;
      bmp.free;
      with Progress do
	      if assigned(fOnProgress) then
    	  		fOnProgress(Sender,trunc(per1*im));
      if fAborting then
      	break;
      inc(idx);
      inc(im);
   until im>=numi;
   Update;
   finally
   	DoFinishWork;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.SaveToFileTIFF(const nf:AnsiString);
var
	fs:TFileStream;
begin
	fAborting:=False;
	fs:=TFileStream.Create(nf,fmCreate);
   SaveToStreamTIFF(fs);
   fs.free;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.SaveToStreamTIFF(Stream:TStream);
var
	p1,q:integer;
   Param:TIOParamsVals;
   Progress:TProgressRec;
   bmp:TIEBitmap;
  	nullpr:TProgressRec;
begin
	try
	fAborting:=False;
	if not assigned(fImageEnMView) then exit;
   if (fImageEnMView as TImageEnMView).ImageCount=0 then exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   Progress.Aborting:=@fAborting;
   with nullpr do begin
	   Aborting:=Progress.Aborting;
      fOnProgress:=nil;
      Sender:=nil;
	end;
   p1:=Stream.Position;
   Progress.per1:=100/(fImageEnMView as TImageEnMView).ImageCount;
   bmp:=TIEBitmap.Create;
   for q:=0 to (fImageEnMView as TImageEnMView).ImageCount-1 do begin
      Param:=TIOParamsVals(fParams[q]);
      Stream.position:=p1;
      (fImageEnMView as TImageEnMView).CopyToIEBitmap(q,bmp);
      bmp.DefaultDitherMethod:=fDefaultDitherMethod;
      if q=0 then
      	TIFFWriteStream(Stream,false,bmp,Param,NullPr)
      else
         TIFFWriteStream(Stream,true,bmp,Param,NullPr);
      with Progress do
	      if assigned(fOnProgress) then
    	  		fOnProgress(Sender,trunc(per1*q));
      if fAborting then
      	break;
   end;
   bmp.free;
   finally
   	DoFinishWork;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.LoadFromFileAVI(const nf:AnsiString);
var
	avf:PAVIFILE;
   avs:PAVISTREAM;
   gf:PGETFRAME;
   pt:pointer;
   ln,idx,im:integer;
   Progress:TProgressRec;
   bmp:TIEDibBitmap;
   Param:TIOParamsVals;
   psi:TAVISTREAMINFOA;
   dt:integer;
   bitcount:integer;
begin
	try
	fAborting:=False;
	if not assigned(fImageEnMView) then exit;
	if not gAVIFILEinit then begin
		AVIFileInit;
		gAVIFILEinit:=true;
   end;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   Progress.Aborting:=@fAborting;
   //
   if AVIFileOpen(avf,pAnsiChar(nf),OF_READ,nil)<>0 then begin
   	fAborting:=True;
      exit;
   end;
   if AVIFileGetStream(avf,avs,streamtypeVIDEO,0)<>0 then begin
	   AVIFileRelease(avf);
   	fAborting:=True;
      exit;
   end;
   if AVIStreamInfo(avs,psi,sizeof(TAVISTREAMINFO))<>0 then begin
	   AVIFileRelease(avf);
      AVIStreamRelease(avs);
   	fAborting:=True;
      exit;
   end;
   gf:=AVIStreamGetFrameOpen(avs,nil);
   if gf=nil then begin
	   AVIFileRelease(avf);
      AVIStreamRelease(avs);
		fAborting:=True;
   	exit;
   end;
   //
   ln:=psi.dwLength;
   dt:=trunc((1/(psi.dwRate/psi.dwScale))*1000);
   Progress.per1:=100/ln;
   idx:=imax((fImageEnMView as TImageEnMView).SelectedImage,0);
   bmp:=TIEDibBitmap.Create;
   for im:=0 to ln-1 do begin
	   pt:=AVIStreamGetFrame(gf,im);
      if pt<>nil then begin
         (fImageEnMView as TImageEnMView).InsertImageEx(idx);
         Param:=TIOParamsVals(fParams[idx]);
         //bitcount:=_CopyDIB2BitmapEx(integer(pt),bmp,nil,true);
			bitcount:=_IECopyDIB2Bitmap2Ex(integer(pt),bmp,nil,true);	// uses drawdibdraw
         (fImageEnMView as TImageEnMView).SetIEBitmapEx(idx,bmp);
      	if im=0 then
         	(fImageEnMView as TImageEnMView).PrepareSpaceFor(bmp.Width,bmp.Height,BitCount,ln-1);
         (fImageEnMView as TImageEnMView).ImageDelayTime[idx]:=dt;
         Param.GIF_DelayTime:=dt;
         case BitCount of
            1: begin Param.BitsPerSample:=1; Param.SamplesPerPixel:=1; end;
            4: begin Param.BitsPerSample:=4; Param.SamplesPerPixel:=1; end;
            8: begin Param.BitsPerSample:=8; Param.SamplesPerPixel:=1; end;
            15: begin Param.BitsPerSample:=5; Param.SamplesPerPixel:=3; end;
            16,24,32: begin Param.BitsPerSample:=8; Param.SamplesPerPixel:=3; end;
         end;
         Param.Gif_ImageIndex:=idx;
         Param.TIFF_ImageIndex:=idx;
         Param.DpiX:=gDefaultDPIX;
         Param.DpiY:=gDefaultDPIY;
         Param.Width:=bmp.Width;
         Param.Height:=bmp.Height;
         Param.fFileName:=nf;
         Param.FileType:=ioUnknown;
         if Param.ColorMap<>nil then begin
            freemem(Param.ColorMap);
            Param.fColorMap:=nil;
            Param.fColorMapCount:=0;
         end;
         with Progress do
            if assigned(fOnProgress) then
               fOnProgress(Sender,trunc(per1*im));
      end else
      	fAborting:=true;
      if fAborting then
      	break;
      inc(idx);
   end;
   bmp.free;
   AVIStreamGetFrameClose(gf);
   AVIStreamRelease(avs);
   AVIFileRelease(avf);
   Update;
   finally
   	DoFinishWork;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// le immagini devono essere tutte della stessa dimensione: quelle diverse dalla prima
// non vengono salvate (al loro posto viene messa la precedente)
procedure TImageEnMIO.SaveToFileAVI(const nf:AnsiString; const codec:AnsiString);
var
	io:TImageEnIO;
   Progress:TProgressRec;
   q:integer;
begin
	if not assigned(fImageEnMView) then exit;
   if (fImageEnMView as TImageEnMView).ImageCount=0 then exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   Progress.per1:=100/(fImageEnMView as TImageEnMView).ImageCount;
   Progress.Aborting:=@fAborting;
	io:=TImageEnIO.Create(nil);
   io.Params.Width:=(fImageEnMView as TImageEnMView).ImageWidth[0];
   io.Params.Height:=(fImageEnMView as TImageEnMView).ImageHeight[0];
   io.Params.BitsPerSample:=TIOParamsVals(fParams[0]).BitsPerSample;
   io.Params.SamplesPerPixel:=TIOParamsVals(fParams[0]).SamplesPerPixel;
   io.CreateAVIFile(nf,trunc(1/(imax((fImageEnMView as TImageEnMView).ImageDelayTime[0],1)/1000)),codec);
   for q:=0 to (fImageEnMView as TImageEnMView).ImageCount-1 do begin
   	io.AttachedIEBitmap:=(fImageEnMView as TImageEnMView).GetTIEBitmap(q);
      io.SaveToAVI;
      (fImageEnMView as TImageEnMView).ReleaseBitmap(q);
   end;
   io.CloseAVIFile;
   io.free;
end;
(*
var
	q:integer;
   Progress:TProgressRec;
	avf:PAVIFILE;
   avs,avs1:PAVISTREAM;
   psi:TAVISTREAMINFOA;
   hdib:THANDLE;
   dib:PBITMAPINFO;
   opts:TAVICOMPRESSOPTIONS;
   popts:PAVICOMPRESSOPTIONS;
   ww,hh,lim,sw,sx:integer;
   bmp:TIEBitmap;
begin
	try
	fAborting:=False;
	if not assigned(fImageEnMView) then exit;
   if (fImageEnMView as TImageEnMView).ImageCount=0 then exit;
	if not gAVIFILEinit then begin
		AVIFileInit;
		gAVIFILEinit:=true;
   end;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   Progress.per1:=100/(fImageEnMView as TImageEnMView).ImageCount;
   Progress.Aborting:=@fAborting;
   //
   if AVIFileOpen(avf,PAnsiChar(nf),OF_WRITE or OF_CREATE,nil)<>0 then
	   raise EInvalidGraphic.Create('unable to create AVI file');
   zeromemory(@psi,sizeof(psi));
   psi.fccType:=streamtypeVIDEO;
   psi.dwScale:=1;
   psi.dwRate:= trunc(1/(imax((fImageEnMView as TImageEnMView).ImageDelayTime[0],1)/1000));
   psi.dwQuality:=$FFFFFFFF;
   zeromemory(@opts,sizeof(opts));
   popts:=@opts;
   ww:=(fImageEnMView as TImageEnMView).ImageWidth[0];
   hh:=(fImageEnMView as TImageEnMView).ImageHeight[0];
   //
   lim:=0;
   bmp:=TIEBitmap.Create;
   for q:=0 to (fImageEnMView as TImageEnMView).ImageCount-1 do begin
   	if (ww=(fImageEnMView as TImageEnMView).ImageWidth[q]) and (hh=(fImageEnMView as TImageEnMView).ImageHeight[q]) then
      	lim:=q;
      (fImageEnMView as TImageEnMView).CopyToIEBitmap(lim,bmp);
      hdib:=_CopyBitmapToDIBEx(bmp,0,0,0,0);
      dib:=GlobalLock(hdib);
      if q=0 then begin
      	// primo frame
         psi.dwSuggestedBufferSize:=GlobalSize(hdib);
         psi.rcFrame:=rect(0,0,dib^.bmiHeader.biWidth,dib^.bmiHeader.biHeight);
         AVIFileCreateStream(avf,avs1,psi);
         if not AVISaveOptions(0,0,1,@avs1,@popts) then begin
            GlobalUnLock(hdib);
            GlobalFree(hdib);
			   AVIStreamRelease(avs1);
			   AVIFileRelease(avf);
            exit;			// EXIT POINT
			end;
         sw:=AVIMakeCompressedStream(avs,avs1,@opts,nil);
		   sw:=AVIStreamSetFormat(avs,0,@(dib^.bmiHeader),sizeof(TBITMAPINFOHEADER));
      end;
      sw:=0; sx:=0;
      AVIStreamWrite(avs,q,1,@(dib^.bmiColors),GlobalSize(hdib),AVIIF_KEYFRAME,@sx,@sw);
      GlobalUnLock(hdib);
      if assigned(bmp) then begin
      	GlobalFree(hdib);
         (fImageEnMView as TImageEnMView).ReleaseBitmap(lim);
      end;
      with Progress do
	      if assigned(fOnProgress) then
    	  		fOnProgress(Sender,trunc(per1*q));
      if fAborting then
      	break;
   end;
   bmp.free;
   AVISaveOptionsFree(1,popts);
   AVIStreamRelease(avs);
   AVIStreamRelease(avs1);
   AVIFileRelease(avf);
   finally
   	DoFinishWork;
   end;
end;
*)

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.LoadFromFile(const nf:AnsiString);
var
	ex:AnsiString;
   idx:integer;
begin
	if trim(nf)='' then begin
   	fAborting:=true;
      exit;
   end;
	fAborting:=False;
	ex:=lowercase(ExtractFileExt(nf));
   if (ex='.gif') then
   	LoadFromFileGIF(nf)
   else if (ex='.tif') or (ex='.tiff') then
   	LoadFromFileTIFF(nf)
   else if (ex='.avi') then
   	LoadFromFileAVI(nf)
   else if (ex='.ico') then
   	LoadFromFileICO(nf)
   else if assigned(fImageEnMView) then begin
   	// try single image
		idx:=imax((fImageEnMView as TImageEnMView).SelectedImage,0);
      (fImageEnMView as TImageEnMView).InsertImageEx(idx);
		(fImageEnMView as TImageEnMView).SetImageFromFile(idx,nf);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.SaveToFile(const nf:AnsiString);
var
	ex:AnsiString;
begin
	if trim(nf)='' then begin
   	fAborting:=true;
      exit;
   end;
	fAborting:=False;
	ex:=lowercase(ExtractFileExt(nf));
   if (ex='.gif') then
   	SaveToFileGIF(nf)
   else if (ex='.tif') or (ex='.tiff') then
   	SaveToFileTIFF(nf)
   else if (ex='.avi') then
   	SaveToFileAVI(nf,'')
   else if (ex='.ps') or (ex='.eps') then
   	SaveToFilePS(nf)
   else if (ex='.pdf') then
   	SaveToFilePDF(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDETWAIN}
function TImageEnMIO.SelectAcquireSource(api:TIEAcquireApi):boolean;
var
	sn:AnsiString;
begin
	result:=false;
	case api of
   	ieaTWain:
      	begin
            result:=IETW_SelectImageSource(sn,@fTWainParams.TWainShared,IEFindHandle(self));
            fTWainParams.SelectSourceByName(sn);
         end;
      ieaWIA:
      	begin
         	{$ifdef IEINCLUDEWIA}
            result:=WIAParams.ConnectToUsingDialog;
            {$endif}
         end;
   end;
end;
{$endif}

procedure TImageEnMIO.TWMultiCallBack( Bitmap:TIEBitmap; var IOParams:TObject);
var
   bHandled:boolean;  // Flag indicating whether the user has handled the acquired bitmap themselves
   bmp:TIEBitmap;
begin
   bHandled:=false;
   if assigned(fOnAcquireBitmap) then
   	fOnAcquireBitmap(Self, Bitmap, bHandled);
   if (bHandled=false) and assigned(fImageEnMView) then begin
   	fTWainNextToInsert:=imax(imin(fTWainNextToInsert,(fImageEnMView as TImageEnMView).ImageCount),0);
      (fImageEnMView as TImageEnMView).InsertImageEx(fTWainNextToInsert);
      IOParams:=TIOParamsVals(fParams[fTWainNextToInsert]);
      if fAutoAdjustDPI then
      	bmp:=IEAdjustDPI(Bitmap,IOParams as TIOParamsVals,fFilteredAdjustDPI)
      else
      	bmp:=Bitmap;
      (fImageEnMView as TImageEnMView).SetIEBitmapEx(fTWainNextToInsert,bmp);
      if bmp<>Bitmap then
      	bmp.free;
      (fImageEnMView as TImageEnMView).ImageDelayTime[fTWainNextToInsert]:=100;
      inc(fTWainNextToInsert);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDETWAIN}
function TImageEnMIO.Acquire(api:TIEAcquireApi):boolean;
var
   Progress:TProgressRec;
   tmpbitmap:TIEBitmap;
begin
	// calling Acquire after AcquireOpen!!!!
	if assigned(fgrec) then begin
   	result:=true;	// there is already a scanner dialog open
	   exit;
   end;
	try
	fAborting:=False;
   result:=false;
   if assigned(fImageEnMView) then begin
   	if (fImageEnMView as TImageEnMView).SelectedImage>=0 then
   		fTWainNextToInsert:=(fImageEnMView as TImageEnMView).SelectedImage
      else
       	fTWainNextToInsert:=(fImageEnMView as TImageEnMView).ImageCount;
   end else
   	fTWainNextToInsert:=0;
   Progress.Aborting:=@fAborting;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   case api of
   	ieaTWain:
      	begin
            result:=IETW_Acquire(nil,true,TWMultiCallBack,fTWainParams,nil,Progress,@fTWainParams.TWainShared,IEFindHandle(self));
            SetFocus(IEFindHandle(self));
         end;
      ieaWIA:
      	begin
         	{$ifdef iEINCLUDEWIA}
            tmpbitmap:=TIEBitmap.Create;
            WIAParams.ProcessingBitmap:=tmpbitmap;
            WIAParams.OnGetPage:=TWMultiCallBack;
   			WIAParams.SetDeviceProperty(WIA_DPS_DOCUMENT_HANDLING_SELECT,1);	// select feeder
   			WIAParams.SetDeviceProperty(WIA_DPS_PAGES,0);	// unlimited number of pages
            WIAParams.Transfer( nil, true );	// transfer in multi page mode
            tmpbitmap.free;
            {$endif}
         end;
	end;
   Update;
   except
   	result:=false;
   end;
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
// show the input/output parameters preview dialog
// return True if the user press OK
// if idx=-1 applies the some compression parameters to all images
{$ifdef IEINCLUDEDIALOGIO}
function TImageEnMIO.DoPreviews(idx:integer; pp:TPreviewParams):boolean;
var
  fIOPreviews: TfIOPreviews;
  fBitmap:TBitmap;
  q:integer;
begin
	result:=false;
	if not assigned(fImageEnMView) then exit;
   if ((fImageEnMView as TImageEnMView).ImageCount>0) and ((fImageEnMView as TImageEnMView).SelectedImage<0) then
   	(fImageEnMView as TImageEnMView).SelectedImage:=0;
	fBitmap:=fImageEnMView.Bitmap;
   if not assigned(fBitmap) then exit;
	fIOPreviews:=TfIOPreviews.Create(self);
   fIOPreviews.DefaultLockPreview:=ioppDefaultLockPreview in PreviewsParams;
   fIOPreviews.Button4.Visible:=ioppApplyButton in PreviewsParams;
   fIOPreviews.fSimplified:=fSimplifiedParamsDialogs;
   if fSimplifiedParamsDialogs then begin
      fIOPreviews.PageControl1.Height:=trunc(122/96*Screen.PixelsPerInch);
      fIOPreviews.Height:=trunc(330/96*Screen.PixelsPerInch);
   end;
   fIOPreviews.fDefaultDitherMethod:=fDefaultDitherMethod;
   if idx<0 then
   	fIOPreviews.fParams:=Params[0]
   else
      fIOPreviews.fParams:=Params[idx];
   //
   fIOPreviews.SetLanguage(fMsgLanguage);
   fIOPreviews.Font.assign(fPreviewFont);
   //
   with fIOPreviews.ImageEn1 do begin
      IECopyBitmap(fBitmap,Bitmap);
   	Update;
   end;
   if fIOPreviews.SetPreviewParams(pp) then
		result:=fIOPreviews.ShowModal=mrOk
   else
   	result:=false;
   fIOPreviews.Release;
   // duplicate compression parameters
   if idx<0 then
   	DuplicateCompressionInfo;
   // reorder image indexes
   for q:=0 to fParams.Count-1 do begin
   	TIOParamsVals(fParams[q]).TIFF_ImageIndex:=q;
		TIOParamsVals(fParams[q]).GIF_ImageIndex:=q;
   end;
   Update;
end;
{$endif}

// duplicate compression info of page 0
procedure TImageEnMIO.DuplicateCompressionInfo;
var
	i:integer;
begin
	for i:=1 to fParams.Count-1 do
		TIOParamsVals(fParams[i]).AssignCompressionInfo( fParams[0] );
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.SetPreviewFont(f:TFont);
begin
	fPreviewFont.assign(f);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnMIO.SetIOPreviewParams(v:TIOPreviewsParams);
begin
	fPreviewsParams:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnMIO.GetIOPreviewParams:TIOPreviewsParams;
begin
	result:=fPreviewsParams;
end;

procedure TImageEnMIO.TWCloseCallBack;
begin
	fgrec:=nil;
end;

{$ifdef IEINCLUDETWAIN}
function TImageEnMIO.AcquireOpen:boolean;
begin
	if (not assigned(fgrec)) and assigned(fImageEnMView) then begin
      if assigned(fImageEnMView) then begin
         if (fImageEnMView as TImageEnMView).SelectedImage>=0 then
            fTWainNextToInsert:=(fImageEnMView as TImageEnMView).SelectedImage
               else
            fTWainNextToInsert:=(fImageEnMView as TImageEnMView).ImageCount;
      end else
         fTWainNextToInsert:=0;
   	fAborting:=false;
      fTWainParams.FreeResources;
      fgrec:=IETWAINAcquireOpen(TWCloseCallBack,TWMultiCallBack, fTWainParams,@fTWainParams.TWainShared,nil,fImageEnMView);
      result:= fgrec<>nil;
   end else
   	result:= false;
end;
{$endif}

{$ifdef IEINCLUDETWAIN}
procedure TImageEnMIO.AcquireClose;
begin
	if fgrec<>nil then begin
		IETWAINAcquireClose(fgrec);
      fgrec:=nil;
   end;
end;
{$endif}

procedure TImageEnMIO.DoFinishWork;
begin
   if assigned(fOnProgress) then
      fOnProgress(self, 100);
   if assigned(fOnFinishWork) then
      fOnFinishWork(self);
end;

{$ifdef IEINCLUDEOPENSAVEDIALOGS}
function TImageEnMIO.ExecuteOpenDialog(InitialDir:AnsiString; InitialFileName:AnsiString; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:AnsiString):AnsiString;
(*$ifdef IEDELPHI*)
var
	fOpenImageEnDialog:TOpenImageEnDialog;
begin
	fOpenImageEnDialog:=TOpenImageEnDialog.create(self);
   fOpenImageEnDialog.InitialDir:=InitialDir;
	fOpenImageEnDialog.FileName:=InitialFileName;
   fOpenImageEnDialog.AlwaysAnimate:=AlwaysAnimate;
   fOpenImageEnDialog.PreviewBorderStyle:=IepsCropShadow;
   fOpenImageEnDialog.FilterIndex:=FilterIndex;
   fOpenImageEnDialog.AutoAdjustDPI:=AutoAdjustDPI;
   fOpenImageEnDialog.FilteredAdjustDPI:=FilteredAdjustDPI;
   fOpenImageEnDialog.ExtendedFilters:=ExtendedFilters;
   fOpenImageEnDialog.MsgLanguage:=fMsgLanguage;
   if fOpenImageEnDialog.Execute then
   	result:=fOpenImageEnDialog.FileName
   else
   	result:='';
   fOpenImageEnDialog.free;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
end;
(*$endif*)
{$endif}

{$ifdef IEINCLUDEOPENSAVEDIALOGS}
function TImageEnMIO.ExecuteSaveDialog(InitialDir:AnsiString; InitialFileName:AnsiString; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:AnsiString):AnsiString;
(*$ifdef IEDELPHI*)
var
	fSaveImageEnDialog:TSaveImageEnDialog;
begin
	fSaveImageEnDialog:=TSaveImageEnDialog.create(self);
	fSaveImageEnDialog.InitialDir:=InitialDir;
   fSaveImageEnDialog.FileName:=InitialFileName;
   fSaveImageEnDialog.AlwaysAnimate:=AlwaysAnimate;
   fsaveImageEnDialog.AttachedImageEnIO:=self;
   fSaveImageEnDialog.PreviewBorderStyle:=IepsCropShadow;
   fSaveImageEnDialog.FilterIndex:=FilterIndex;
   fSaveImageEnDialog.AutoAdjustDPI:=AutoAdjustDPI;
   fSaveImageEnDialog.FilteredAdjustDPI:=FilteredAdjustDPI;
   fSaveImageEnDialog.ExtendedFilters:=ExtendedFilters;
   fSaveImageEnDialog.MsgLanguage:=fMsgLanguage;
   if fSaveImageEnDialog.Execute then
   	result:=fSaveImageEnDialog.FileName
   else
   	result:='';
   fSaveImageEnDialog.free;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
end;
(*$endif*)
{$endif}

{$ifdef IEINCLUDEWIA}
function TImageEnMIO.GetWIAParams:TIEWia;
begin
	if not assigned(fWIA) then
   	fWIA:=TIEWia.Create(self);
   result:=fWIA;
end;
{$endif}

procedure TImageEnMIO.SaveToStreamPS(Stream:TStream);
var
	q:integer;
   Param:TIOParamsVals;
   Progress:TProgressRec;
   bmp:TIEBitmap;
  	nullpr:TProgressRec;
   han:pointer;
begin
	try
	fAborting:=False;
	if not assigned(fImageEnMView) then exit;
   if (fImageEnMView as TImageEnMView).ImageCount=0 then exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   Progress.Aborting:=@fAborting;
   with nullpr do begin
	   Aborting:=Progress.Aborting;
      fOnProgress:=nil;
      Sender:=nil;
	end;
   Progress.per1:=100/(fImageEnMView as TImageEnMView).ImageCount;
   bmp:=TIEBitmap.Create;
   han:=nil;
   for q:=0 to (fImageEnMView as TImageEnMView).ImageCount-1 do begin
      Param:=TIOParamsVals(fParams[q]);
   	if q=0 then
      	han:=IEPostScriptCreate(Stream,Param);
      (fImageEnMView as TImageEnMView).CopyToIEBitmap(q,bmp);
      bmp.DefaultDitherMethod:=fDefaultDitherMethod;
      IEPostScriptSave(han,Stream,bmp,Param,nullpr);
      with Progress do
	      if assigned(fOnProgress) then
    	  		fOnProgress(Sender,trunc(per1*q));
      if fAborting then
      	break;
   end;
   IEPostScriptClose(han,Stream);
   bmp.free;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnMIO.SaveToFilePS(const nf:AnsiString);
var
	fs:TFileStream;
begin
	fAborting:=False;
	fs:=TFileStream.Create(nf,fmCreate);
   SaveToStreamPS(fs);
   fs.free;
end;

procedure TImageEnMIO.SaveToStreamPDF(Stream:TStream);
var
	q:integer;
   Param:TIOParamsVals;
   Progress:TProgressRec;
   bmp:TIEBitmap;
  	nullpr:TProgressRec;
   han:pointer;
begin
	try
	fAborting:=False;
	if not assigned(fImageEnMView) then exit;
   if (fImageEnMView as TImageEnMView).ImageCount=0 then exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   Progress.Aborting:=@fAborting;
   with nullpr do begin
	   Aborting:=Progress.Aborting;
      fOnProgress:=nil;
      Sender:=nil;
	end;
   Progress.per1:=100/(fImageEnMView as TImageEnMView).ImageCount;
   bmp:=TIEBitmap.Create;
   han:=nil;
   for q:=0 to (fImageEnMView as TImageEnMView).ImageCount-1 do begin
      Param:=TIOParamsVals(fParams[q]);
   	if q=0 then
      	han:=IEPDFCreate(Param);
      (fImageEnMView as TImageEnMView).CopyToIEBitmap(q,bmp);
      bmp.DefaultDitherMethod:=fDefaultDitherMethod;
      IEPDFSave(han,bmp,Param,nullpr);
      with Progress do
	      if assigned(fOnProgress) then
    	  		fOnProgress(Sender,trunc(per1*q));
      if fAborting then
      	break;
   end;
   if (fImageEnMView as TImageEnMView).ImageCount>0 then
   	Param:=TIOParamsVals(fParams[0]);
   IEPDFClose(han,Stream,Param);
   bmp.free;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnMIO.SaveToFilePDF(const nf:AnsiString);
var
	fs:TFileStream;
begin
	fAborting:=False;
	fs:=TFileStream.Create(nf,fmCreate);
   SaveToStreamPDF(fs);
   fs.free;
end;

{$ifdef IEINCLUDEPRINTDIALOGS}
function TImageEnMIO.DoPrintPreviewDialog(const TaskName:AnsiString):boolean;
var
	fieprnform:tfieprnform3;
begin
	if fResetPrinter then
   	IEResetPrinter;
   fieprnform:=tfieprnform3.Create(self);
   fieprnform.mio:=self;
   fieprnform.SetLanguage(fMsgLanguage);
   fieprnform.Font.assign(fPreviewFont);
   fieprnform.fTaskName:=TaskName;
   fieprnform.fDialogsMeasureUnit:=fDialogsMeasureUnit;
   result:=fieprnform.ShowModal=mrOk;
   fieprnform.Release;
end;
{$endif}

procedure TImageEnMIO.LoadFromFileICO(const nf:AnsiString);
var
	fs:TFileStream;
begin
	fAborting:=False;
	fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
	LoadFromStreamICO(fs);
   fs.free;
end;

procedure TImageEnMIO.LoadFromStreamICO(Stream:TStream);
var
	bmp:TIEBitmap;
   numi,p1,idx:integer;
   Progress,Progress2:TProgressRec;
   Param:TIOParamsVals;
   im:integer;
   tempAlphaChannel:TIEMask;
begin
	fAborting:=False;
	if not assigned(fImageEnMView) then exit;
   try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   Progress.Aborting:=@fAborting;
   Progress2.fOnProgress:=nil;
   Progress2.Sender:=nil;
   Progress2.Aborting:=@fAborting;
   p1:=Stream.Position;
   idx:=imax((fImageEnMView as TImageEnMView).SelectedImage,0);
   im:=0;
   numi:=_EnumICOImStream(Stream);
   repeat
   	(fImageEnMView as TImageEnMView).InsertImageEx(idx);
   	bmp:=TIEBitmap.Create;
      Param:=TIOParamsVals(fParams[idx]);
      Stream.position:=p1;
      Param.ICO_ImageIndex:=im;
      tempAlphaChannel:=nil;
      ICOReadStream(Stream,bmp,Param,false,Progress2,tempAlphaChannel,false);
      if assigned(tempAlphaChannel) then begin
         bmp.AlphaChannel.CopyFromTIEMask(tempAlphaChannel);
         tempAlphaChannel.free;
      end;
      Param.TIFF_ImageIndex:=idx;
      Param.GIF_ImageIndex:=idx;
      Param.ICO_ImageIndex:=idx;
	   Param.FileType:=ioICO;
      Param.fFileName:='';
      if fAborting then begin
      	(fImageEnMView as TImageEnMView).DeleteImage(idx);
         bmp.free;
         break;
      end;
		if numi=0 then
         (fImageEnMView as TImageEnMView).DeleteImage(idx)
      else begin
	      Progress.per1:=100/numi;
	      (fImageEnMView as TImageEnMView).SetIEBitmapEx(idx,bmp);
	      (fImageEnMView as TImageEnMView).ImageDelayTime[idx]:=100;
      end;
      bmp.free;
      with Progress do
	      if assigned(fOnProgress) then
    	  		fOnProgress(Sender,trunc(per1*im));
      if fAborting then
      	break;
      inc(idx);
      inc(im);
   until im>=numi;
   Update;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnMIO.CheckDPI(p:TIOParamsVals);
begin
	if p.DpiX<2 then p.DpiX:=gDefaultDPIX;
   if p.DpiY<2 then p.DpiY:=gDefaultDPIY;
end;

{$else}	// {$ifdef IEINCLUDEMULTIVIEW}

interface
implementation

{$endif}


end.
