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


unit ieprnform1;

{$R-}
{$Q-}

{$I ie.inc}

{$ifdef IEINCLUDEPRINTDIALOGS}

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   StdCtrls, Buttons, ImageEnView, ImageEnIO, ComCtrls,
   ExtCtrls, Menus, ieview, hyiedefs, hyieutils, imageenproc;

type
   tfieprnform1 = class(TForm)
      PrinterSetupDialog1: TPrinterSetupDialog;
      ImageEnView1: TImageEnView;
      MainMenu1: TMainMenu;
      Panel1: TPanel;
      SpeedButton1: TSpeedButton;
      SpeedButton2: TSpeedButton;
      SpeedButton3: TSpeedButton;
      SpeedButton4: TSpeedButton;
      SpeedButton5: TSpeedButton;
      SpeedButton6: TSpeedButton;
      SpeedButton7: TSpeedButton;
      SpeedButton8: TSpeedButton;
      SpeedButton9: TSpeedButton;
      Edit1: TEdit;
      Edit2: TEdit;
      Edit3: TEdit;
      Edit4: TEdit;
      ComboBox1: TComboBox;
      Edit5: TEdit;
      Edit6: TEdit;
      Edit7: TEdit;
      SpeedButton10: TSpeedButton;
      SpeedButton11: TSpeedButton;
      UpDown1: TUpDown;
      UpDown2: TUpDown;
      UpDown3: TUpDown;
      UpDown4: TUpDown;
      UpDown5: TUpDown;
      UpDown6: TUpDown;
      UpDown7: TUpDown;
      File1: TMenuItem;
      Exit1: TMenuItem;
      N1: TMenuItem;
      PrintSetup1: TMenuItem;
      Print1: TMenuItem;
      SpeedButton12: TSpeedButton;
      procedure Button3Click(Sender: TObject);
      procedure PrintPreview(Sender: TObject);
      procedure FormActivate(Sender: TObject);
      procedure ComboBox1Change(Sender: TObject);
      procedure Exit1Click(Sender: TObject);
      procedure SpeedButton12Click(Sender: TObject);
      procedure SpeedButton10Click(Sender: TObject);
      procedure Print1Click(Sender: TObject);
      procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
      procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
      procedure UpDown3Click(Sender: TObject; Button: TUDBtnType);
      procedure UpDown4Click(Sender: TObject; Button: TUDBtnType);
      procedure UpDown7Click(Sender: TObject; Button: TUDBtnType);
      procedure UpDown5Click(Sender: TObject; Button: TUDBtnType);
      procedure UpDown6Click(Sender: TObject; Button: TUDBtnType);
      procedure FormResize(Sender: TObject);
   private
    { Private declarations }
      procedure incdecmargins(text:TEdit; Button: TUDBtnType);
   public
    { Public declarations }
      fDialogsMeasureUnit:TIEDialogsMeasureUnit;
      io: TImageEnIO;
      fTaskName:string;
      procedure SetLanguage(l:TMsgLanguage);
   end;


implementation

uses printers;

{$R *.DFM}

const
	FLOATINC=0.01;


procedure tfieprnform1.FormActivate(Sender: TObject);
begin
	ComboBox1.ItemIndex := 1;
   PrintPreview(Sender);
end;

procedure tfieprnform1.Button3Click(Sender: TObject);
begin
   PrinterSetupDialog1.Execute;
   PrintPreview(self);
end;

// preview or print
procedure tfieprnform1.PrintPreview(Sender: TObject);
var
   VerticalPos: TIEVerticalPos;
   HorizontalPos: TIEHorizontalPos;
   Size: TIESize;
   MarginLeft, MarginTop, MarginRight, MarginBottom, SpecWidth, SpecHeight, GammaCorrection: double;
   xmult:double;
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
      io.PrintImage(Printer.Canvas, MarginLeft, MarginTop, MarginRight, MarginBottom, VerticalPos, HorizontalPos,
         Size, SpecWidth, SpecHeight, GammaCorrection);
      Printer.EndDoc;
   end else begin
    	// preview
      io.PreviewPrintImage(ImageEnView1.Bitmap, ImageEnView1.Width, ImageEnView1.Height, Printer, MarginLeft, MarginTop, MarginRight, MarginBottom, VerticalPos, HorizontalPos,
         Size, SpecWidth, SpecHeight, GammaCorrection);
      ImageEnView1.Update;
   end;
end;

procedure tfieprnform1.ComboBox1Change(Sender: TObject);
var
   en: boolean;
begin
   en := ComboBox1.ItemIndex = 3; // true when Specified Sizes
   Edit5.Enabled := en;
   Edit6.Enabled := en;
   printpreview(Sender);
end;

procedure tfieprnform1.Exit1Click(Sender: TObject);
begin
	modalresult:=mrOK;
   Close;
end;

procedure tfieprnform1.SpeedButton12Click(Sender: TObject);
begin
	modalresult:=mrOK;
   Close;
end;

procedure tfieprnform1.SpeedButton10Click(Sender: TObject);
begin
   PrinterSetupDialog1.Execute;
   PrintPreview(self);
end;

procedure Tfieprnform1.Print1Click(Sender: TObject);
begin
	PrintPreview(SpeedButton11);
end;

procedure tfieprnform1.SetLanguage(l:TMsgLanguage);
begin
	Caption:=iemsg(IEMSG_PRINT,l);
   Print1.Caption:=iemsg(IEMSG_PRINT,l);
   PrintSetup1.Caption:=iemsg(IEMSG_PRINTSETUP,l)+'...';
   Exit1.Caption:=iemsg(IEMSG_CLOSE2,l);
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
end;

procedure Tfieprnform1.incdecmargins(text:TEdit; Button: TUDBtnType);
begin
	case button of
   	btNext:
      	text.Text:=floattostr(dmax(IEStrToFloatDef(text.Text,0)+FLOATINC,0));
      btPrev:
      	text.Text:=floattostr(dmax(IEStrToFloatDef(text.Text,0)-FLOATINC,0));
   end;
end;

procedure Tfieprnform1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit1, Button);
end;

procedure Tfieprnform1.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit2, Button);
end;

procedure Tfieprnform1.UpDown3Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit3, Button);
end;

procedure Tfieprnform1.UpDown4Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit4, Button);
end;

procedure Tfieprnform1.UpDown7Click(Sender: TObject; Button: TUDBtnType);
begin
	case button of
   	btNext:
      	Edit7.Text:=floattostr(dmax(IEStrToFloatDef(Edit7.Text,0)+0.1,0));
      btPrev:
      	Edit7.Text:=floattostr(dmax(IEStrToFloatDef(Edit7.Text,0)-0.1,0));
   end;
end;

procedure Tfieprnform1.UpDown5Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit5, Button);
end;

procedure Tfieprnform1.UpDown6Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit6, Button);
end;

procedure Tfieprnform1.FormResize(Sender: TObject);
begin
	PrintPreview(self);
end;


{$else} // {$ifdef IEINCLUDEPRINTDIALOGS}

interface
implementation

{$endif}


end.

