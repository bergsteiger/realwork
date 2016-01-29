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

unit dbimageenvect;

{$R-}
{$Q-}


{$I ie.inc}

{$ifdef IEINCLUDEDB}

interface


uses Windows, Messages, classes, Graphics, Db, dbctrls, ImageEnView, ImageEnio, dbimageen,ievect, hyiedefs;

type

	TImageEnDBVect = class(TImageEnVect)
   	private
      	FAutoDisplay: Boolean;
         FDataLink: TFieldDataLink;
         FPictureLoaded: Boolean;
         fDataFieldImageFormat: TDataFieldImageFormat;
         fDoImageChange:boolean; // se true viene eseguita ImageChange
         fAbsolutePath:string;
         fIsInsideDbCtrl:boolean;
  			procedure SetAutoDisplay(Value: Boolean);
	      function GetDataField: string;
	      function GetDataSource: TDataSource;
	      function GetField: TField;
   	   function GetReadOnly: Boolean;
		   procedure SetDataField(const Value: string);
		   procedure SetDataSource(Value: TDataSource);
		   procedure SetReadOnly(Value: Boolean);
		   procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
         procedure SetJPegQuality(q:integer);
         function GetJPegQuality:integer;
         function GetIOParams:TIOParamsVals;
		   function GetIOPreviewsParams:TIOPreviewsParams;
		   procedure SetIOPreviewsParams(v:TIOPreviewsParams);
	      procedure SetPreviewFont(f:TFont);
         function GetPreviewFont:TFont;
         procedure SetAbsolutePath(const v:string);
      protected
		   procedure Notification(AComponent: TComponent;Operation: TOperation); override;
         procedure DataChange(Sender: TObject); virtual;
  		   procedure UpdateData(Sender: TObject); virtual;
         function GetDataFieldImageFormat:TDataFieldImageFormat; virtual;
         procedure SetDataFieldImageFormat(v:TDataFieldImageFormat); virtual;
  			procedure LoadPictureEx(ffImageEnIO:TImageEnIO);
         procedure DoVectorialChanged; override;
         function InsideDBCtrl:boolean; virtual;
      public
         constructor Create(AOwner: TComponent); override;
		   destructor Destroy; override;
         procedure PaintToEx(ABitmap:TBitmap; ABitmapScanline:ppointerarray; UpdRect:PRect); override;
         procedure Paint; override;
  			procedure ImageChange; override;
         property Field: TField read GetField;
         procedure LoadPicture; virtual;
         function LoadedFieldImageFormat:TDataFieldImageFormat; virtual;
         property IOParams:TIOParamsVals read GetIOParams;
         {$ifdef IEINCLUDEDIALOGIO}
      	function DoIOPreview:boolean;
         {$endif}
         property PictureLoaded:boolean read fPictureLoaded;
         property AbsolutePath:string read fAbsolutePath write SetAbsolutePath;
      published
      	property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
		   property DataField: string read GetDataField write SetDataField;
		   property DataSource: TDataSource read GetDataSource write SetDataSource;
	      property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
         property DataFieldImageFormat: TDataFieldImageFormat read GetDataFieldImageFormat write SetDataFieldImageFormat default ifBitmap;
			property JpegQuality:integer read GetJpegQuality write SetJpegQuality default 25;
         property IOPreviewsParams:TIOPreviewsParams read GetIOPreviewsParams write SetIOPreviewsParams default [];
         property PreviewFont:TFont read GetPreviewFont write SetPreviewFont;
         property IsInsideDbCtrl:boolean read fIsInsideDbCtrl write fIsInsideDbCtrl default false;
   end;

implementation

uses dbtables, controls, giffilter, ImageEn, sysutils, hyieutils;

{$R-}

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then begin
    FAutoDisplay := Value;
    if Value then LoadPicture;
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////
constructor TImageEnDBVect.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  GetImageEnIO;   // creates fImageEnIO;
  fAbsolutePath:='';
  fDataFieldImageFormat:=ifBitmap;
  FAutoDisplay := True;
  fDoImageChange:=true;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  SetJpegQuality(25);
  fIsInsideDbCtrl:=false;
end;

/////////////////////////////////////////////////////////////////////////////////////
destructor TImageEnDBVect.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnDBVect.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnDBVect.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnDBVect.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnDBVect.GetField: TField;
begin
  Result := FDataLink.Field;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.DataChange(Sender: TObject);
begin
  Clear;
  RemoveAllObjects;
  FPictureLoaded := False;
  if (not assigned(fDataLink.DataSource)) or (not assigned(FDataLink.DataSource.DataSet)) or (not FDataLink.DataSource.DataSet.Active) then exit;
  if FAutoDisplay then LoadPicture;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  LoadPicture;
  inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.ImageChange;
begin
	inherited;
   if fDoImageChange then begin
      FDataLink.Modified;
      FPictureLoaded := True;
      Invalidate;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.DoVectorialChanged;
begin
	ImageChange;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.SetDataFieldImageFormat(v:TDataFieldImageFormat);
begin
	fDataFieldImageFormat:=v;
   ImageChange;
end;

/////////////////////////////////////////////////////////////////////////////////////
// save the image
procedure TImageEnDBVect.UpdateData(Sender: TObject);
var
  ms:tmemorystream;
  ss:string;
begin
  	if FDataLink.Field is TBlobField then begin
   	fImageEnIO.StreamHeaders:=true;
   	ms:=tmemorystream.create;
   	try
		case fDataFieldImageFormat of
      	ifBitmap: fImageEnIO.SaveToStreamBMP(ms);
         ifJpeg: fImageEnIO.SaveToStreamJpeg(ms);
         ifGif: fImageEnIO.SaveToStreamGif(ms);
         ifPCX: fImageEnIO.SaveToStreamPCX(ms);
         ifTIFF: fImageEnIO.SaveToStreamTIFF(ms);
         {$ifdef IEINCLUDEPNG}
         ifPNG: fImageEnIO.SaveToStreamPNG(ms);
         {$endif}
         ifTGA: fImageEnIO.SaveToStreamTGA(ms);
         ifPXM: fImageEnIO.SaveToStreamPXM(ms);
         ifICO: fImageEnIO.SaveToStreamICO(ms);
         {$ifdef IEINCLUDEJPEG2000}
         ifJP2: fImageEnIO.SaveToStreamJP2(ms);
         ifJ2K: fImageEnIO.SaveToStreamJ2K(ms);
         {$endif}
         ifWBMP: fImageEnIO.SaveToStreamWBMP(ms);
      end;
      SaveToStreamIEV(ms);
      ms.position:=0;
		(fdatalink.field as tblobfield).loadfromstream(ms);
      finally
 			ms.Free;
      end;
   end else if FDataLink.Field is TStringField then begin
   	// path
      fImageEnIO.StreamHeaders:=false;
      ss:=TStringField(FDataLink.Field).Value;
      if (ss<>'') then begin
      	ss:=fAbsolutePath+ss;
         case fDataFieldImageFormat of
            ifBitmap: fImageEnIO.SaveToFileBMP(ss);
            ifJpeg: fImageEnIO.SaveToFileJpeg(ss);
            ifGif: fImageEnIO.SaveToFileGif(ss);
            ifPCX: fImageEnIO.SaveToFilePCX(ss);
            ifTIFF: fImageEnIO.SaveToFileTIFF(ss);
            {$ifdef IEINCLUDEPNG}
            ifPNG: fImageEnIO.SaveToFilePNG(ss);
            {$endif}
            ifTGA: fImageEnIO.SaveToFileTGA(ss);
            ifPXM: fImageEnIO.SaveToFilePXM(ss);
            ifICO: fImageEnIO.SaveToFileICO(ss);
            {$ifdef IEINCLUDEJPEG2000}
            ifJP2: fImageEnIO.SaveToFileJP2(ss);
            ifJ2K: fImageEnIO.SaveToFileJ2K(ss);
            {$endif}
            ifWBMP: fImageEnIO.SaveToFileWBMP(ss);
         end;
         SaveToFileIEV(ss+'.iev');
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Carica immagine da fdatalink.field senza controllare fPictureLoaded
// non assegna fDataFieldImageFormat
procedure TImageEnDBVect.LoadPictureEx(ffImageEnIO:TImageEnIO);
var
	ms:tmemorystream;
   ifm:TDataFieldImageFormat;
   bg:THYIEGraphicHeader;
   ss:string;
begin
	if (FDataLink.Field is TBlobField) and ((FDataLink.Field as TBlobField).BlobSize>0) then begin
   	ffImageEnIO.StreamHeaders:=true;
      fDoImageChange:=false;
     	ifm:=LoadedFieldImageFormat;
      ms:=tmemorystream.create;
   	try
		(fdatalink.field as tblobfield).savetostream(ms);
      ms.position:=0;
      if ifm=ifUnknown then begin
      	// try paradox graphic
         ms.read(bg,sizeof(THYIEGraphicHeader));
			if (bg.Count=1) and (bg.HType=$0100) then
         	ifm:=ifBitmap
         else
         	ms.position:=0;
      end;
      case ifm of
         ifBitmap: ffImageEnIO.LoadFromStreamBMP(ms);
         ifJpeg: ffImageEnIO.LoadFromStreamJpeg(ms);
         ifGif: ffImageEnIO.LoadFromStreamGif(ms);
         ifPCX: ffImageEnIO.LoadFromStreamPCX(ms);
         ifTIFF: ffImageEnIO.LoadFromStreamTIFF(ms);
         {$ifdef IEINCLUDEPNG}
         ifPNG: ffImageEnIO.LoadFromStreamPNG(ms);
         {$endif}
			ifTGA: ffImageEnIO.LoadFromStreamTGA(ms);
         ifPXM: ffImageEnIO.LoadFromStreamPXM(ms);
         ifICO: ffImageEnIO.LoadFromStreamICO(ms);
         {$ifdef IEINCLUDEJPEG2000}
         ifJP2: ffImageEnIO.LoadFromStreamJP2(ms);
         ifJ2K: ffImageEnIO.LoadFromStreamJ2K(ms);
         {$endif}
         ifWBMP: ffImageEnIO.LoadFromStreamWBMP(ms);
         else
            Clear;
      end;
      RemoveAllObjects;
      LoadFromStreamIEV(ms);
      finally
      	ms.free;
         fDoImageChange:=true;
   	end;
   end else if (FDataLink.Field is TStringField) then begin
   	ffImageEnIO.StreamHeaders:=false;
		ss:=TStringField(FDataLink.Field).Value;
      if (ss<>'') and (fileexists(fAbsolutePath+ss)) then begin
      	ss:=fAbsolutePath+ss;
      	ifm:=LoadedFieldImageFormat;
         case ifm of
            ifBitmap: ffImageEnIO.LoadFromFileBMP(ss);
            ifJpeg: ffImageEnIO.LoadFromFileJpeg(ss);
            ifGif: ffImageEnIO.LoadFromFileGif(ss);
            ifPCX: ffImageEnIO.LoadFromFilePCX(ss);
            ifTIFF: ffImageEnIO.LoadFromFileTIFF(ss);
            {$ifdef IEINCLUDEPNG}
            ifPNG: ffImageEnIO.LoadFromFilePNG(ss);
            {$endif}
            ifTGA: ffImageEnIO.LoadFromFileTGA(ss);
            ifPXM: ffImageEnIO.LoadFromFilePXM(ss);
            ifICO: ffImageEnIO.LoadFromFileICO(ss);
            {$ifdef IEINCLUDEJPEG2000}
            ifJP2: ffImageEnIO.LoadFromFileJP2(ss);
            ifJ2K: ffImageEnIO.LoadFromFileJ2K(ss);
            {$endif}
            ifWBMP: ffImageEnIO.LoadFromFileWBMP(ss);
            else
               Clear;
         end;
         RemoveAllObjects;
         if fileexists(ss+'.iev') then
	         LoadFromFileIEV(ss+'.iev');
	     	fDoImageChange:=true;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Carica immagine da fdatalink.field
procedure TImageEnDBVect.LoadPicture;
begin
	if (not FPictureLoaded) and
      ( ((FDataLink.Field is TBlobField) and ((FDataLink.Field as TBlobField).BlobSize>0)) or
        (FDataLink.Field is TStringField) ) then begin
     	LoadPictureEx(fImageEnIO);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// restituisce il formato dell'immagine memorizzata in fDataLink.Field
function TImageEnDBVect.LoadedFieldImageFormat:TDataFieldImageFormat;
var
   ms:tmemorystream;
   ss:string;
begin
	result:=ifUnknown;
   if not FAutoDisplay then
   	exit;
	if FDataLink.Field is TBlobField then begin
		ms:=tmemorystream.create;
	   try
		(fdatalink.field as tblobfield).savetostream(ms);
      ms.position:=0;
      case FindStreamFormat(ms) of
      	ioBMP:  result:=ifBitmap;
      	ioJPEG: result:=ifJpeg;
      	ioGIF:  result:=ifGIF;
      	ioPCX:  result:=ifPCX;
      	ioTIFF: result:=ifTIFF;
         {$ifdef IEINCLUDEPNG}
      	ioPNG:  result:=ifPNG;
         {$endif}
         ioTGA:  result:=ifTGA;
         ioPXM:  result:=ifPXM;
         ioICO:  result:=ifICO;
         {$ifdef IEINCLUDEJPEG2000}
         ioJP2:  result:=ifJP2;
         ioJ2K:  result:=ifJ2K;
         {$endif}
         ioWBMP: result:=ifWBMP;
      end;
      finally
      	ms.free;
      end;
   end else if FDataLink.Field is TStringField then begin
		ss:=TStringField(FDataLink.Field).Value;
      if (ss<>'') and (fileexists(fAbsolutePath+ss)) then begin
      	case FindFileFormat(fAbsolutePath+ss,false) of
            ioBMP:  result:=ifBitmap;
            ioJPEG: result:=ifJpeg;
            ioGIF:  result:=ifGIF;
            ioPCX:  result:=ifPCX;
            ioTIFF: result:=ifTIFF;
            {$ifdef IEINCLUDEPNG}
            ioPNG:  result:=ifPNG;
            {$endif}
            ioTGA:  result:=ifTGA;
            ioPXM:  result:=ifPXM;
            ioICO:  result:=ifICO;
            {$ifdef IEINCLUDEJPEG2000}
            ioJP2:  result:=ifJP2;
            ioJ2K:  result:=ifJ2K;
            {$endif}
            ioWBMP: result:=ifWBMP;
      	end;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.SetJPegQuality(q:integer);
begin
	IOParams.JPEG_Quality:=q;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnDBVect.GetJPegQuality:integer;
begin
	result:=IOParams.JPEG_Quality;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnDBVect.GetIOParams:TIOParamsVals;
begin
	result:=fImageEnIO.Params;
end;

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDEDIALOGIO}
function TImageEnDBVect.DoIOPreview:boolean;
var
	pp:TPreviewParams;
begin
	case fDataFieldImageFormat of
   	ifBitmap: pp:=[ppBMP];
      ifJpeg:   pp:=[ppJPEG];
      ifGif:    pp:=[ppGIF];
      ifPCX:    pp:=[ppPCX];
      ifTIFF:   pp:=[ppTIFF];
      ifPNG:    pp:=[ppPNG];
      ifTGA:    pp:=[ppTGA];
      else begin
      	result:=false;
      	exit;
      end;
   end;
	result:=fImageEnIO.DoPreviews(pp);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.SetIOPreviewsParams(v:TIOPreviewsParams);
begin
	fImageEnIO.PreviewsParams:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnDBVect.GetIOPreviewsParams:TIOPreviewsParams;
begin
	result:=fImageEnIO.PreviewsParams;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnDBVect.SetPreviewFont(f:TFont);
begin
	fImageEnIO.PreviewFont:=f;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnDBVect.GetPreviewFont:TFont;
begin
	result:=fImageEnIO.PreviewFont;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnDBVect.GetDataFieldImageFormat:TDataFieldImageFormat;
begin
	result:=fDataFieldImageFormat;
end;

function TImageEnDBVect.InsideDBCtrl:boolean;
var
	parent:TControl;
begin
	result:=false;
	parent:=self;
	while (parent<>nil) do begin
   	if parent.ClassName='TDBCtrlGrid' then begin
      	result:=true;
         break;
      end;
      if parent=parent.parent then break;
      parent:=parent.parent;
   end;
end;

procedure TImageEnDBVect.PaintToEx(ABitmap:TBitmap; ABitmapScanline:ppointerarray; UpdRect:PRect);
var
   ie:TImageEnVect;
   bmp:TIEBitmap;
begin
   if (not (csDesigning in ComponentState)) and assigned(fDataLink.DataSource) and assigned(fDataLink.DataSource.DataSet) and
   	FDataLink.DataSource.DataSet.Active and (fIsInsideDBCtrl or InsideDbCtrl) then begin
   	// we are in TDBGrid
      (*
      fImageEnIO:=TImageEnIO.Create(self);
		fImageEnVect:=TImageEnVect.Create(self);
      fImageEnVect.visible:=false;
      fImageEnVect.Parent:=Parent;
      fImageEnVect.AutoFit:=AutoFit;
      fImageEnVect.Center:=Center;
      fImageEnVect.Background:=Background;
      fImageEnVect.Width:=Width;
      fImageEnVect.Height:=Height;
      fImageEnVect.BorderStyle:=BorderStyle;
      fImageEnVect.BackgroundStyle:=BackgroundStyle;
      fUpdateInvalidate:=false;
      fImageEnIO.AttachedImageEn:=fImageEnVect;
      LoadPictureEx(fImageEnIO);
		fImageEnIO.AttachedImageEn:=nil;
      fUpdateInvalidate:=true;
      fImageEnVect.PaintToEx(ABitmap,ABitmapScanline,UpdRect);
		fImageEnVect.free;
      fImageEnIO.free;
      *)
      //(*
      bmp:=TIEBitmap.Create;
      bmp.assign( IEBitmap );
      fUpdateInvalidate:=false;
      ie:=TImageEnVect.Create(nil);
      LoadPictureEx(ie.IO);
      if (ie.IEBitmap.Width=0) or (ie.IEBitmap.Height=0) then begin
      	IEBitmap.Resize(1,1,Background,255,iehLeft,ievTop);
      	IEBitmap.Fill( Background );
      end else
      	IEBitmap.Assign( ie.IEBitmap );
      Update;
      inherited;
      IEBitmap.Assign( bmp );
      ie.free;
      bmp.free;
      fUpdateInvalidate:=true;
      //*)
   end else
		inherited;
end;

procedure TImageEnDBVect.Paint;
begin
	fDBToDraw:=true;
   inherited;
end;

procedure TImageEnDBVect.SetAbsolutePath(const v:string);
begin
	fAbsolutePath:=v;
	FPictureLoaded:=false;
	LoadPicture;
end;

{$else} // {$ifdef IEINCLUDEDB}

interface
implementation

{$endif}

end.
