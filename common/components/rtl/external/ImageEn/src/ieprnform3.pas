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

unit ieprnform3;

{$R-}
{$Q-}

{$I ie.inc}

{$ifdef IEINCLUDEPRINTDIALOGS}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, hyiedefs,hyieutils,iemio,
  ExtCtrls, imageenview, ieview, iemview,imageenio, ComCtrls, StdCtrls,
  Buttons, imageenproc, Menus;

type
  Tfieprnform3 = class(TForm)
    Splitter1: TSplitter;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    UpDown7: TUpDown;
    PrinterSetupDialog1: TPrinterSetupDialog;
    ImageEnView1: TImageEnView;
    Panel3: TPanel;
    ImageEnMView1: TImageEnMView;
    PopupMenu1: TPopupMenu;
    ComboBox2: TComboBox;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown3Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown4Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown5Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown6Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown7Click(Sender: TObject; Button: TUDBtnType);
    procedure FormResize(Sender: TObject);
    procedure PrintPreview(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImageEnMView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Delete1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
  private
    { Private declarations }
    srcview:TImageEnMView;
    ie:TImageEnView;
    procedure incdecmargins(text:TEdit; Button: TUDBtnType);
    procedure ImageSelect;
  public
    { Public declarations }
      mio: TImageEnMIO;
      fTaskName:string;
      fLanguage:TMsgLanguage;
      fDialogsMeasureUnit:TIEDialogsMeasureUnit;
      procedure SetLanguage(l:TMsgLanguage);
  end;

implementation

uses printers;

{$R *.DFM}

const
	FLOATINC=0.01;


procedure tfieprnform3.SetLanguage(l:TMsgLanguage);
begin
   Caption:=iemsg(IEMSG_PRINT,l);
   Edit1.Hint:=iemsg(IEMSG_LEFTMARGIN,l);
   Edit2.Hint:=iemsg(IEMSG_TOPMARGIN,l);
   Edit3.Hint:=iemsg(IEMSG_RIGHTMARGIN,l);
   Edit4.hint:=iemsg(IEMSG_BOTTOMMARGIN,l);
   ComboBox1.Hint:=iemsg(IEMSG_LOCATIONSIZE,l);
   Edit5.Hint:=iemsg(IEMSG_WIDTH,l);
   Edit6.Hint:=iemsg(IEMSG_HEIGHT,l);
   SpeedButton1.Hint:=iemsg(IEMSG_TOPLEFT,l);
   SpeedButton2.Hint:=iemsg(IEMSG_TOPCENTER,l);
   SpeedButton3.hint:=iemsg(IEMSG_TOPRIGHT,l);
   SpeedButton4.hint:=iemsg(IEMSG_CENTERLEFT,l);
   SpeedButton5.hint:=iemsg(IEMSG_CENTER,l);
   SpeedButton6.hint:=iemsg(IEMSG_CENTERRIGHT,l);
   SpeedButton7.hint:=iemsg(IEMSG_BOTTOMLEFT,l);
   SpeedButton8.hint:=iemsg(IEMSG_BOTTOMCENTER,l);
   SpeedButton9.hint:=iemsg(IEMSG_BOTTOMRIGHT,l);
   Edit7.hint:=iemsg(IEMSG_GAMMACORRECTION,l);
   SpeedButton10.hint:=iemsg(IEMSG_PRINTSETUP,l);
   SpeedButton11.hint:=iemsg(IEMSG_PRINT,l);
   SpeedButton12.caption:=iemsg(IEMSG_CLOSE2,l);
   ComboBox2.Items.Add(iemsg(IEMSG_PRINTALL,l));
   ComboBox2.Items.Add(iemsg(IEMSG_PRINTSELECTED,l));
end;

procedure Tfieprnform3.FormActivate(Sender: TObject);
var
   i,idx:integer;
begin
	//
   ImageEnMView1.FillThumbnail:=false;
   ImageEnMView1.SoftShadow.Enabled:=true;
   ImageEnMView1.GradientEndColor:=clGray;
	// load ImageEnMView1
	srcview:=mio.AttachedMView as TImageEnMView;
	for i:=0 to srcview.ImageCount-1 do begin
   	idx:=ImageEnMView1.AppendImage;
      ImageEnMView1.SetIEBitmapEx(idx, srcview.GetTIEBitmap(i) );
      srcview.ReleaseBitmap(idx);
      ImageEnMVIew1.ImageTopText[i].Caption:= 'Image ' + inttostr(i+1);
   end;
   ImageEnMView1.SelectedImage:=0;
   //
	ComboBox1.ItemIndex := 1;
   ComboBox2.ItemIndex := 0;
   //
   ImageSelect;
end;

// preview or print
procedure tfieprnform3.PrintPreview(Sender: TObject);
var
   VerticalPos: TIEVerticalPos;
   HorizontalPos: TIEHorizontalPos;
   Size: TIESize;
   MarginLeft, MarginTop, MarginRight, MarginBottom, SpecWidth, SpecHeight, GammaCorrection: double;
   xmult:double;
   i,idx:integer;
begin
	if (Width<100) or (Height<100) then
   	exit;	// to disallow AV
   VerticalPos := ievpCENTER;
   HorizontalPos := iehpCENTER;
   if SpeedButton1.Down or SpeedButton2.Down or SpeedButton3.Down then
      VerticalPos := ievpTOP;
   if SpeedButton7.Down or SpeedButton8.Down or SpeedButton9.Down then
      VerticalPos := ievpBOTTOM;
   if SpeedButton1.Down or SpeedButton4.Down or SpeedButton7.Down then
      HorizontalPos := iehpLEFT;
   if SpeedButton3.Down or SpeedButton6.Down or SpeedButton9.Down then
      HorizontalPos := iehpRIGHT;
   Size := iesFITTOPAGE;
   case ComboBox1.ItemIndex of
      0: Size := iesNORMAL;
      1: Size := iesFITTOPAGE;
      2: Size := iesFITTOPAGESTRETCH;
      3: Size := iesSPECIFIEDSIZE;
   end;
   if (fDialogsMeasureUnit=ieduCm) or (fDialogsMeasureUnit=ieduSelectableDefCm) then
   	xmult:=2.54
   else
   	xmult:=1;
   MarginLeft := IEStrToFloatDef(Edit2.Text, 0)/xmult;
   MarginTop := IEStrToFloatDef(Edit1.Text, 0)/xmult;
   MarginRight := IEStrToFloatDef(Edit3.Text, 0)/xmult;
   MarginBottom := IEStrToFloatDef(Edit4.text, 0)/xmult;
   SpecWidth := IEStrToFloatDef(Edit5.Text, 1)/xmult;
   SpecHeight := IEStrToFloatDef(Edit6.Text, 1)/xmult;
   GammaCorrection := IEStrToFloatDef(Edit7.Text, 1);
   if Sender = SpeedButton11 then begin
      // print
      Printer.BeginDoc;
      Printer.Title:=fTaskName;
      if ComboBox2.ItemIndex = 0 then begin
      	// print all
         for i:=0 to srcview.ImageCount-1 do begin
         	if i>0 then
	            Printer.NewPage;
            srcview.CopyToIEBitmap(i, ie.IEBitmap );
            //ie.IEBitmap.Assign( srcview.GetTIEBitmap( i ) );
            //srcview.ReleaseBitmap( i );
            ie.Update;
            ie.io.PrintImage(Printer.Canvas, MarginLeft, MarginTop, MarginRight, MarginBottom, VerticalPos, HorizontalPos, Size, SpecWidth, SpecHeight, GammaCorrection);
         end;
      end else begin
      	// print selected
         for i:=0 to ImageEnMView1.MultiSelectedImagesCount-1 do begin
         	if i>0 then
	            Printer.NewPage;
         	idx:=ImageEnMView1.MultiSelectedImages[i];
            srcview.CopyToIEBitmap(idx, ie.IEBitmap );
            //ie.IEBitmap.Assign( srcview.GetTIEBitmap( idx ) );
            //srcview.ReleaseBitmap( idx );
            ie.Update;
            ie.io.PrintImage(Printer.Canvas, MarginLeft, MarginTop, MarginRight, MarginBottom, VerticalPos, HorizontalPos, Size, SpecWidth, SpecHeight, GammaCorrection);
         end;
      end;
      Printer.EndDoc;
      ImageSelect;
   end else begin
      // preview
      ie.io.PreviewPrintImage(ImageEnView1.Bitmap, ImageEnView1.Width, ImageEnView1.Height, Printer, MarginLeft, MarginTop, MarginRight, MarginBottom, VerticalPos, HorizontalPos, Size, SpecWidth, SpecHeight, GammaCorrection);
      ImageEnView1.Update;
   end;
end;


procedure Tfieprnform3.incdecmargins(text:TEdit; Button: TUDBtnType);
begin
	case button of
   	btNext:
      	text.Text:=floattostr(dmax(IEStrToFloatDef(text.Text,0)+FLOATINC,0));
      btPrev:
      	text.Text:=floattostr(dmax(IEStrToFloatDef(text.Text,0)-FLOATINC,0));
   end;
end;

procedure Tfieprnform3.ComboBox1Change(Sender: TObject);
var
   en: boolean;
begin
   en := ComboBox1.ItemIndex = 3; // true when Specified Sizes
   Edit5.Enabled := en;
   Edit6.Enabled := en;
   printpreview(Sender);
end;

procedure Tfieprnform3.SpeedButton12Click(Sender: TObject);
begin
	modalresult:=mrOK;
   Close;
end;

procedure Tfieprnform3.SpeedButton10Click(Sender: TObject);
begin
   PrinterSetupDialog1.Execute;
   PrintPreview(self);
end;

procedure Tfieprnform3.SpeedButton11Click(Sender: TObject);
begin
	PrintPreview(SpeedButton11);
end;

procedure Tfieprnform3.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit1, Button);
end;

procedure Tfieprnform3.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit2, Button);
end;

procedure Tfieprnform3.UpDown3Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit3, Button);
end;

procedure Tfieprnform3.UpDown4Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit4, Button);
end;

procedure Tfieprnform3.UpDown5Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit5, Button);
end;

procedure Tfieprnform3.UpDown6Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit6, Button);
end;

procedure Tfieprnform3.UpDown7Click(Sender: TObject; Button: TUDBtnType);
begin
	case button of
   	btNext:
      	Edit7.Text:=floattostr(dmax(IEStrToFloatDef(Edit7.Text,0)+0.1,0));
      btPrev:
      	Edit7.Text:=floattostr(dmax(IEStrToFloatDef(Edit7.Text,0)-0.1,0));
   end;
end;

procedure Tfieprnform3.FormResize(Sender: TObject);
begin
	PrintPreview(self);
end;


procedure Tfieprnform3.ImageSelect;
var
	idx:integer;
begin
	idx:=ImageEnMView1.SelectedImage;
	if idx>-1 then begin
      //ie.IEBitmap.Assign( srcview.GetTIEBitmap( idx ) );
      //srcview.ReleaseBitmap( idx );
      srcview.CopyToIEBitmap(idx, ie.IEBitmap);
      ie.Update;
   end;
	PrintPreview(self);
end;

procedure Tfieprnform3.ImageEnMView1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	ImageSelect;
end;


procedure Tfieprnform3.FormDestroy(Sender: TObject);
begin
	ie.free;
end;

procedure Tfieprnform3.FormCreate(Sender: TObject);
begin
	ie:=TImageEnView.Create(nil);
   ie.Blank;
end;

procedure Tfieprnform3.Delete1Click(Sender: TObject);
begin
  	ImageEnMView1.ThumbWidth:=ImageEnMView1.ThumbWidth-10;
   ImageEnMView1.ThumbHeight:=ImageEnMView1.ThumbHeight-10;
end;

procedure Tfieprnform3.Add1Click(Sender: TObject);
begin
	ImageEnMView1.ThumbWidth:=ImageEnMView1.ThumbWidth+50;
   ImageEnMView1.ThumbHeight:=ImageEnMView1.ThumbHeight+50;
end;


{$else} // {$ifdef IEINCLUDEPRINTDIALOGS}

interface
implementation

{$endif}



end.
