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

(*
NeuQuant Neural-Net Quantization algorithm by Anthony Dekker.
*)

unit neurquant;

{$R-}
{$Q-}


{$I ie.inc}

interface

(*$ifdef IEKYLIX*)
uses SysUtils, iekdef, Types, QGraphics, Classes,
	 hyiedefs, ImageEnProc, hyieutils;
(*$endif*)
(*$ifdef IEDELPHI*)
uses Windows, Graphics, classes, sysutils, imageen, ImageEnProc, hyiedefs, hyieutils;
(*$endif*)

type TIEQuantizer=class
	private
		fMethod:integer;
	   fQT:pointer;
      fGrayScale:boolean;
      fSQ:PRGBROW;	// simple quantizer
      fNCol:integer;
      fSrcBmp:TIEBitmap;
      function GetRGBIndex(const cl:TRGB):integer;
   public
   	constructor Create(SrcBitmap:TIEBitmap; var ColorMap:array of TRGB; NCol:integer; Quality:integer; qmethod:integer);
      destructor Destroy; override;
      property RGBIndex[const cl:TRGB]:integer read GetRGBIndex;
      property GrayScale:boolean read fGrayScale;
end;

implementation

uses stdquant;

{$R-}

const

   prime1=499;
   prime2=491;
   prime3=487;
   prime4=503;
   minpicturebytes=3*prime4;
   netbiasshift=4;
   ncycles=100;
   intbiasshift=16;
   intbias=1 SHL intbiasshift;
   gammashift=10;
   gamma=1 SHL gammashift;
   betashift=10;
   beta=intbias SHR betashift;
   betagamma=intbias SHL (gammashift-betashift);
   radiusbiasshift=6;
   radiusbias=1 SHL radiusbiasshift;
   radiusdec=30;
   alphabiasshift=10;
   initalpha=1 SHL alphabiasshift;
   radbiasshift=8;
   radbias=1 SHL radbiasshift;
   alpharadbshift=alphabiasshift+radbiasshift;
   alpharadbias=1 SHL alpharadbshift;

type

pixel = array [0..3] of integer;
ppixel = ^pixel;

integerarray = array [0..Maxint div 16] of integer;
pintegerarray = ^integerarray;
pixelarray = array [0..Maxint div 32] of pixel;
ppixelarray = ^pixelarray;

TVars = record
	netsize:integer;
	maxnetpos:integer;
   initrad:integer;
   initradius:integer;
   alphadec:integer;
   Bitmap:TIEBitmap;
   lengthcount:integer;
   samplefac:integer;
   network:ppixelarray;
   netindex:array [0..255] of integer;
   bias:pintegerarray;
   freq:pintegerarray;
   radpower:pintegerarray;
   bitmapwidth,bitmapheight:integer;
end;
PVars=^TVars;

// im=width*height dell'immagine
// Calcola Quality (1..30) in base alla dimensione dell'immagine
function AutoCalcQuality(im:integer):integer;
const
	// Valori di riferimento
	IM1=2000;   Q1=2;
   IM2=150000; Q2=15;
begin
	if im<2000 then
     	result:=1	// massima qualità per immagini piccole
   else
     	result:=ilimit(round((im-IM1)*(Q2-Q1)/(IM2-IM1)+Q1),1,30);
end;

procedure initnet(var vars:TVars; SrcBitmap:TIEBitmap; sample:integer; NCols:integer);
var
	i:integer;
   p:ppixel;
begin
	with vars do begin
      Bitmap:=SrcBitmap;
      bitmapwidth:=(Bitmap as TIEBitmap).Width;
      bitmapheight:=(Bitmap as TIEBitmap).Height;
      if sample=-1 then
         sample:= AutoCalcQuality(BitmapWidth*BitmapHeight)
      else
         sample:= trunc(((100-sample)/100)*29)+1;
   	netsize:=NCols;
		maxnetpos:=netsize-1;
  		initrad:=netsize SHR 3;
  	   initradius:=initrad*radiusbias;
      network:=allocmem(netsize*sizeof(pixel));
      bias:=allocmem(netsize*sizeof(integer));
      freq:=allocmem(netsize*sizeof(integer));
      radpower:=allocmem(initrad*sizeof(integer));
   	//
      lengthcount := BitmapWidth*BitmapHeight*3;
      samplefac := sample;
      for i:=0 to netsize-1 do begin
	      p := @(network[i]);
         p^[0] := (i SHL (netbiasshift+8)) div netsize;
         p^[1] := p^[0];
         p^[2] := p^[0];
         freq[i] := intbias div netsize;
         bias[i] := 0;
      end;
   end;
end;

procedure freenet(var vars:TVars);
begin
	with vars do begin
   	freemem(radpower);
      freemem(freq);
      freemem(bias);
      freemem(network);
   end;
end;

procedure unbiasnet(var vars:TVars);
var
	i,j:integer;
begin
	with vars do begin
	   for i:=0 to netsize-1 do begin
			for j:=0 to 2 do
				network[i][j] := network[i][j] SHR netbiasshift;
			network[i][3] := i;
		end;
   end;
end;

procedure writecolourmap(var vars:TVars; var ColorMap:array of TRGB);
var
	j:integer;
begin
	with vars do begin
   	for j:=0 to netsize-1 do begin
      	ColorMap[j].b:=network[j][0];
         ColorMap[j].g:=network[j][1];
         ColorMap[j].r:=network[j][2];
      end;
   end;
end;

procedure inxbuild(var vars:TVars);
var
	i,j,smallpos,smallval:integer;
	p,q:ppixel;
   previouscol,startpos:integer;
begin
	with vars do begin
		previouscol := 0;
		startpos := 0;
		for i:=0 to netsize-1 do begin
			p := @(network[i]);
			smallpos := i;
			smallval := p^[1];
			for j:=i+1 to netsize-1 do begin
				q := @(network[j]);
				if (q[1] < smallval) then begin
					smallpos := j;
					smallval := q^[1];
				end;
			end;
			q := @(network[smallpos]);
			if (i <> smallpos) then begin
				j := q^[0];   q^[0] := p^[0];   p^[0] := j;
				j := q^[1];   q^[1] := p^[1];   p^[1] := j;
				j := q^[2];   q^[2] := p^[2];   p^[2] := j;
				j := q^[3];   q^[3] := p^[3];   p^[3] := j;
			end;
			if (smallval <> previouscol) then begin
				netindex[previouscol] := (startpos+i) SHR 1;
				for j:=previouscol+1 to smallval-1 do
            	netindex[j] := i;
				previouscol := smallval;
				startpos := i;
			end;
		end;
		netindex[previouscol] := (startpos+maxnetpos) SHR 1;
		for j:=previouscol+1 to 255 do
      	netindex[j] := maxnetpos;
   end;
end;

function inxsearch(var vars:TVars; b,g,r:integer):integer;
var
	i,j,dist,a,bestd:integer;
	p:ppixel;
	best:integer;
begin
	with vars do begin
		bestd := 1000;
		best := -1;
		i := netindex[g];
		j := i-1;
		while ((i<netsize) or (j>=0)) do begin
			if (i<netsize) then begin
				p := @(network[i]);
				dist := p^[1] - g;
				if (dist >= bestd) then i := netsize
				else begin
					inc(i);
					if (dist<0) then dist := -dist;
					a := p^[0] - b;
	            if (a<0) then a := -a;
					inc(dist,a);
					if (dist<bestd) then begin
						a := p^[2] - r;
	               if (a<0) then a := -a;
						inc(dist,a);
						if (dist<bestd) then begin
	               	bestd:=dist;
	                  best:=p^[3];
	               end;
					end;
				end;
			end;
			if (j>=0) then begin
				p := @(network[j]);
				dist := g - p^[1];
				if (dist >= bestd) then j := -1
				else begin
					dec(j);
					if (dist<0) then dist := -dist;
					a := p^[0] - b;
	            if (a<0) then a := -a;
					inc(dist,a);
					if (dist<bestd) then begin
						a := p^[2] - r;
	               if (a<0) then a := -a;
						inc(dist,a);
						if (dist<bestd) then begin
	               	bestd:=dist;
	                  best:=p^[3];
	               end;
					end;
				end;
			end;
		end;
	   result:=best;
   end;
end;

function contest(var vars:TVars; b,g,r:integer):integer;
var
	i,dist,a,biasdist,betafreq:integer;
	bestpos,bestbiaspos,bestd,bestbiasd:integer;
	p,f:pinteger;
   n:ppixel;
begin
	with vars do begin
		bestd := not (1 SHL 31);
		bestbiasd := bestd;
		bestpos := -1;
		bestbiaspos := bestpos;
		p := @(bias[0]);
		f := @(freq[0]);
		for i:=0 to netsize-1 do begin
			n := @(network[i]);
			dist := n^[0] - b;
	      if (dist<0) then dist := -dist;
			a := n^[1] - g;
	      if (a<0) then a := -a;
			inc(dist,a);
			a := n^[2] - r;
	      if (a<0) then a := -a;
			inc(dist,a);
			if (dist<bestd) then begin
	      	bestd:=dist;
	         bestpos:=i;
	      end;
			biasdist := dist - ((p^) SHR (intbiasshift-netbiasshift));
			if (biasdist<bestbiasd) then begin
	      	bestbiasd:=biasdist;
	         bestbiaspos:=i;
	      end;
			betafreq := (f^ SHR betashift);
			dec(f^,betafreq);
	      inc(f);
			inc(p^,(betafreq SHL gammashift));
   	   inc(p);
		end;
		inc(freq[bestpos],beta);
		dec(bias[bestpos],betagamma);
		result:=bestbiaspos;
   end;
end;

procedure altersingle(var vars:TVars;alpha,i,b,g,r:integer);
var
	n:ppixel;
begin
	with vars do begin
		n := @(network[i]);
		dec(n^[0], (alpha*(n^[0] - b)) div initalpha);
		dec(n^[1], (alpha*(n^[1] - g)) div initalpha);
		dec(n^[2], (alpha*(n^[2] - r)) div initalpha);
   end;
end;

procedure alterneigh(var vars:Tvars; rad,i,b,g,r:integer);
var
	j,k,lo,hi,a:integer;
	p:ppixel;
   q:pinteger;
begin
	with vars do begin
		lo := i-rad;
	   if (lo<-1) then lo:=-1;
		hi := i+rad;
	   if (hi>netsize) then hi:=netsize;
		j := i+1;
		k := i-1;
		q := @(radpower[0]);
		while ((j<hi) or (k>lo)) do begin
	      inc(q);
			a := q^;
			if (j<hi) then begin
				p := @(network[j]);
				dec(p^[0], (a*(p^[0] - b)) div alpharadbias);
				dec(p^[1], (a*(p^[1] - g)) div alpharadbias);
				dec(p^[2], (a*(p^[2] - r)) div alpharadbias);
				inc(j);
			end;
			if (k>lo) then begin
				p := @(network[k]);
				dec(p^[0], (a*(p^[0] - b)) div alpharadbias);
				dec(p^[1], (a*(p^[1] - g)) div alpharadbias);
				dec(p^[2], (a*(p^[2] - r)) div alpharadbias);
				dec(k);
			end;
		end;
	end;
end;

procedure learn(var vars:TVars);
var
	i,j,b,g,r:integer;
	radius,rad,alpha,step,delta,samplepixels:integer;
	p,x,y,lim:integer;
   px:PRGB;
begin
	with vars do begin
		alphadec := 30 + ((samplefac-1) div 3);
      lim := lengthcount div 3;
		samplepixels := lengthcount div (3*samplefac);
		delta := samplepixels div ncycles;
      if delta=0 then delta:=1;
		alpha := initalpha;
		radius := initradius;
		rad := radius SHR radiusbiasshift;
		if (rad <= 1) then rad := 0;
		for i:=0 to rad-1 do
			radpower[i] := alpha*(((rad*rad - i*i)*radbias) div (rad*rad));
		if ((lengthcount mod prime1) <> 0) then step := prime1
		else begin
			if ((lengthcount mod prime2) <>0) then step := prime2
			else begin
				if ((lengthcount mod prime3) <>0) then step := prime3
				else step := prime4;
			end;
		end;
      //
      i:=0;
      p:=0;
      while (i < samplepixels) do begin
         y:=p div BitmapWidth;
         if y>=BitmapHeight then y:=y mod BitmapHeight;
         x:=p mod BitmapWidth;
         if x>=BitmapWidth then x:=x mod BitmapWidth;
         px:=PRGB((Bitmap as TIEBitmap).scanline[y]);
         inc(px, x);
         b := px^.b SHL netbiasshift;
         g := px^.g SHL netbiasshift;
         r := px^.r SHL netbiasshift;
         j := contest(vars,b,g,r);
         altersingle(vars,alpha,j,b,g,r);
         if (rad<>0) then
            alterneigh(vars,rad,j,b,g,r);
         inc(p,step);
         if (p >= lim) then
            dec(p,lim);
         inc(i);
         if (i mod delta = 0) then begin
            dec(alpha, alpha div alphadec);
            dec(radius, radius div radiusdec);
            rad := radius SHR radiusbiasshift;
            if (rad <= 1) then rad := 0;
            for j:=0 to rad-1 do
               radpower[j] := alpha*(((rad*rad - j*j)*radbias) div (rad*rad));
         end;
      end;
	end;
end;

/////////////////////////////////////////////////////////////////////////////////////////
// Restituisce la ColorMap ed un puntatore all'oggetto vars (esternamente chiamato NeuralNet).
// Al termine bisogna chiamare FreeNeurQuantizer.
// Quality da 0..100 (100 massima qualità)
// Se Quality è -1 viene calcolata automaticamente (inversamente proporz. all'immagine).
function NQ_CreateNeurQuantizer(SrcBitmap:TIEBitmap; var ColorMap:array of TRGB; NCol:integer; Quality:integer):pointer;
var
	vars:PVars;
begin
	new(vars);
	initnet(vars^,SrcBitmap,Quality,NCol);
   learn(vars^);
   unbiasnet(vars^);
   writecolourmap(vars^,ColorMap);
	inxbuild(vars^);
   result:=vars;
end;

/////////////////////////////////////////////////////////////////////////////////////////
function NQ_FindIndex(NeuralNet:pointer; const rgb:TRGB):integer;
begin
	result:=inxsearch( PVars(NeuralNet)^, rgb.b, rgb.g, rgb.r);
end;

/////////////////////////////////////////////////////////////////////////////////////////
// Libera oggetto restituito da CreateNeurQuantizer
procedure NQ_FreeNeurQuantizer(NeuralNet:pointer);
begin
	freenet( PVars(NeuralNet)^ );
   dispose( PVars(NeuralNet) );
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// simple quantizer (just count colors and works only for <NCol colors

function SQ_FindCol(sq:PRGBROW; NCol:integer; const tofind:TRGB):integer;
begin
	for result:=0 to NCol-1 do
   	with sq[result] do
      	if (r=tofind.r) and (g=tofind.g) and (b=tofind.b) then
         	exit;
   result:=-1;
end;

function SQ_Create(image:TIEBitmap; NCol:integer; var ColorMap:array of TRGB):PRGBROW;
var
	x,y,cf,r:integer;
   px:PRGB;
begin
	result:=nil;
   if image.PixelFormat<>ie24RGB then exit;
   getmem(result,NCol*sizeof(TRGB));
   cf:=0;
	for y:=0 to image.Height-1 do begin
   	px:=image.Scanline[y];
   	for x:=0 to image.Width-1 do begin
      	r:=SQ_FindCol(result,cf,px^);
         if r=-1 then begin
         	if cf=NCol then begin
            	freemem(result);
               result:=nil;
               exit;	// more than NCol colors
            end;
            result[cf]:=px^;
            inc(cf);
         end;
         inc(px);
      end;
   end;
   // fill colormap
   copymemory(@ColorMap[0],result,sizeof(TRGB)*cf);
end;

procedure SQ_Free(sq:PRGBROW);
begin
	freemem(sq);
end;


/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

// TIEQuantizer


// SrcBitmap must be TIEBitmap
// Restituisce la ColorMap ed un puntatore referente l'oggetto quantizzatore creato
// Al termine bisogna chiamare FreeQuantizer.
// Quality da 0..100 (100 massima qualità)
// Se Quality è -1 viene calcolata automaticamente (inversamente proporz. all'immagine).
// qmethod: metodo di quantizzazione
//			0 = Kohonen map se NCol>=128, MedianCut se NCol<128
constructor TIEQuantizer.Create(SrcBitmap:TIEBitmap; var ColorMap:array of TRGB; NCol:integer; Quality:integer; qmethod:integer);
var
 lColStep: Double;
   q:integer;
begin
	inherited Create;
   fSrcBmp:=SrcBitmap;
   fNCol:=NCol;
   fGrayScale:=SrcBitmap.IsGrayScale;
   fQT:=nil;
   fSQ:=nil;
   if (not fGrayScale) and (SrcBitmap.PixelFormat=ie24RGB) then begin
   	fSQ:=SQ_Create(SrcBitmap,NCol,ColorMap);	// try simple quantizer
      if fSQ=nil then begin
      	// kohonen map or median cut
         if fmethod=0 then begin
            if NCol>=128 then fMethod:=0 else fMethod:=1;
         end else
            fmethod:=qmethod;
         case fMethod of
            0: fQT:=NQ_CreateNeurQuantizer(SrcBitmap,ColorMap,NCol,Quality);
            1: fQT:=CreateMedianCutQuantizer(SrcBitmap,ColorMap,NCol);
         end;
      end;
   end else begin
   	// other pixel formats do not requires color subsampling
      if SrcBitmap.PixelFormat=ie8p then begin
         for q:=0 to NCol-1 do begin
            ColorMap[q].r:=SrcBitmap.Palette[q].r;
            ColorMap[q].g:=SrcBitmap.Palette[q].g;
            ColorMap[q].b:=SrcBitmap.Palette[q].b;
         end;
      end else if fGrayScale then
      begin
       lColStep := 255/(NCol-1);
       for q:=0 to NCol-1 do
       begin
        ColorMap[q].r:= trunc(lColStep * q) ;
        ColorMap[q].g:= trunc(lColStep * q) ;
        ColorMap[q].b:= trunc(lColStep * q) ;
       end;
      end;
   end;
end;

// free quantizer
destructor TIEQuantizer.Destroy;
begin
	if fSQ<>nil then
   	SQ_Free(fSQ);
   if fQT<>nil then begin
      case fMethod of
         0: NQ_FreeNeurQuantizer(fQT);
         1: FreeMedianCutQuantizer(fQT);
      end;
   end;
   inherited;
end;

// Trova l'indice del colore specificato
function TIEQuantizer.GetRGBIndex(const cl:TRGB):integer;
begin
	if fSQ<>nil then
   	result := SQ_FindCol(fSQ,fNCol,cl)
   else if fGrayScale then begin
      result := trunc(cl.r*fNCol / 256);
   end else if fQT<>nil then begin
      case fMethod of
         0: result:=NQ_FindIndex(fQT,cl);
         1: result:=MedianCutFindIndex(fQT,cl);
         else
            result:=0;
      end;
   end else if fSrcBmp.PixelFormat=ie8p then begin
   	for result:=0 to fSrcBmp.PaletteLength-1 do
      	with fSrcBmp.Palette[result] do
	      	if (r=cl.r) and (g=cl.g) and (b=cl.b) then
	         	break;
   end else
   	result:=0;
end;


end.

