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


unit ieprnform2;

{$R-}
{$Q-}

{$I ie.inc}

{$ifdef IEINCLUDEPRINTDIALOGS}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ImageEnView, ImageEnIO, ieview, hyiedefs, hyieutils,
  ComCtrls, ImageEnProc;

type
  Tfieprnform2 = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    GroupBox2: TGroupBox;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton1: TSpeedButton;
    GroupBox3: TGroupBox;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    Edit5: TEdit;
    Label7: TLabel;
    Edit6: TEdit;
    Label8: TLabel;
    GroupBox4: TGroupBox;
    Edit7: TEdit;
    Label9: TLabel;
    Button1: TButton;
    Button2: TButton;
    GroupBox5: TGroupBox;
    ImageEnView1: TImageEnView;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    UpDown7: TUpDown;
    Button4: TButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    GroupBox6: TGroupBox;
    Label10: TLabel;
    ComboBox2: TComboBox;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure printpreview(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown3Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown4Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown7Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown5Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown6Click(Sender: TObject; Button: TUDBtnType);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    { Private declarations }
    procedure incdecmargins(text:TEdit; Button: TUDBtnType);
    procedure SetLanguage_units;
  public
    { Public declarations }
    io:TImageEnIO;
    fDialogsMeasureUnit:TIEDialogsMeasureUnit;
    fLanguage:TMsgLanguage;
    fTaskName:string;
    procedure SetLanguage(l:TMsgLanguage);
  end;

implementation

uses printers;

{$R *.DFM}

const
	FLOATINC=0.01;

procedure Tfieprnform2.FormActivate(Sender: TObject);
begin
	ComboBox1.ItemIndex := 1;
   GroupBox6.visible:=(fDialogsMeasureUnit=ieduSelectableDefInches) or (fDialogsMeasureUnit=ieduSelectableDefCm);
   if (fDialogsMeasureUnit=ieduSelectableDefInches) then
      ComboBox2.ItemIndex:=0
   else if (fDialogsMeasureUnit=ieduSelectableDefCm) then
      ComboBox2.ItemIndex:=1;
	printpreview(Sender);
end;

// Changes Size combobox
procedure Tfieprnform2.ComboBox1Change(Sender: TObject);
var
	en:boolean;
begin
	en:= ComboBox1.ItemIndex=3;	// true when Specified Sizes
   Label5.Enabled:=en;
   Label6.Enabled:=en;
   Label7.Enabled:=en;
   Label8.Enabled:=en;
   Edit5.Enabled:=en;
   Edit6.Enabled:=en;
   printpreview(Sender);
end;

// Preview
procedure Tfieprnform2.Button3Click(Sender: TObject);
begin
	printpreview(Sender);
end;

// OK (print)
procedure Tfieprnform2.Button1Click(Sender: TObject);
begin
   printpreview(Sender);
end;

// preview or print
procedure Tfieprnform2.printpreview(Sender: TObject);
var
	VerticalPos:TIEVerticalPos;
   HorizontalPos:TIEHorizontalPos;
   Size:TIESize;
   MarginLeft,MarginTop,MarginRight,MarginBottom,SpecWidth,SpecHeight,GammaCorrection:double;
   xmult:double;
begin
   VerticalPos:=ievpCENTER;
   HorizontalPos:=iehpCENTER;
   if SpeedButton1.Down or SpeedButton2.Down or SpeedButton3.Down then
      VerticalPos:=ievpTOP;
   if SpeedButton7.Down or SpeedButton8.Down or SpeedButton9.Down then
      VerticalPos:=ievpBOTTOM;
   if SpeedButton1.Down or SpeedButton4.Down or SpeedButton7.Down then
      HorizontalPos:=iehpLEFT;
   if SpeedButton3.Down or SpeedButton6.Down or SpeedButton9.Down then
      HorizontalPos:=iehpRIGHT;
   Size:=iesFITTOPAGE;
   case ComboBox1.ItemIndex of
   	0: Size:=iesNORMAL;
      1: Size:=iesFITTOPAGE;
      2: Size:=iesFITTOPAGESTRETCH;
      3: Size:=iesSPECIFIEDSIZE;
   end;
   if (fDialogsMeasureUnit=ieduCm) or (fDialogsMeasureUnit=ieduSelectableDefCm) then
   	xmult:=2.54
   else
   	xmult:=1;
   MarginLeft:=IEStrToFloatDef(Edit2.Text,0)/xmult;
   MarginTop:=IEStrToFloatDef(Edit1.Text,0)/xmult;
   MarginRight:=IEStrToFloatDef(Edit3.Text,0)/xmult;
   MarginBottom:=IEStrToFloatDef(Edit4.text,0)/xmult;
   SpecWidth:=IEStrToFloatDef(Edit5.Text,1)/xmult;
   SpecHeight:=IEStrToFloatDef(Edit6.Text,1)/xmult;
   GammaCorrection:=IEStrToFloatDef(Edit7.Text,1);
   if Sender=Button1 then begin
   	// print
      Printer.BeginDoc;
      Printer.Title:=fTaskName;
      io.PrintImage(Printer.Canvas,MarginLeft,MarginTop,MarginRight,MarginBottom,VerticalPos,HorizontalPos,
            Size,SpecWidth,SpecHeight,GammaCorrection);
      Printer.EndDoc;
   end else begin
   	// preview
      io.PreviewPrintImage(ImageEnView1.Bitmap,ImageEnView1.Width,ImageEnView1.Height,Printer,MarginLeft,MarginTop,MarginRight,MarginBottom,VerticalPos,HorizontalPos,
            Size,SpecWidth,SpecHeight,GammaCorrection);
      ImageEnView1.Update;
   end;
end;

procedure tfieprnform2.SetLanguage_units;
begin
   if (fDialogsMeasureUnit=ieduInches) or (fDialogsMeasureUnit=ieduSelectableDefInches) then begin
   	// inches
	   GroupBox1.Caption:=' '+iemsg(IEMSG_MARGINS,fLanguage)+' ('+iemsg(IEMSG_INCHES,fLanguage)+') ';
	   Label7.Caption:=iemsg(IEMSG_INCHES,fLanguage);
	   Label8.Caption:=iemsg(IEMSG_INCHES,fLanguage);
   end else begin
   	// centimeters (Cm)
	   GroupBox1.Caption:=' '+iemsg(IEMSG_MARGINS,fLanguage)+' (cm) ';
	   Label7.Caption:='cm';
	   Label8.Caption:='cm';
   end;
end;

procedure tfieprnform2.SetLanguage(l:TMsgLanguage);
begin
   fLanguage:=l;
	Caption:=iemsg(IEMSG_PRINT,l);
   SetLanguage_units;
   Label1.Caption:=iemsg(IEMSG_TOP,l);
   Label2.Caption:=iemsg(IEMSG_LEFT,l);
   Label3.Caption:=iemsg(IEMSG_RIGHT,l);
   Label4.Caption:=iemsg(IEMSG_BOTTOM,l);
   GroupBox2.Caption:=' '+iemsg(IEMSG_POSITION,l)+' ';
   GroupBox5.Caption:=' '+iemsg(IEMSG_PREVIEW,l)+' ';
   GroupBox3.Caption:=' '+iemsg(IEMSG_SIZE,l)+' ';
   ComboBox1.Items[0]:=iemsg(IEMSG_NORMAL,l);
	ComboBox1.Items[1]:=iemsg(IEMSG_FITTOPAGE,l);
   ComboBox1.Items[2]:=iemsg(IEMSG_STRETCHTOPAGE,l);
   ComboBox1.Items[3]:=iemsg(IEMSG_SPECIFIEDSIZE,l);
   Label5.Caption:=iemsg(IEMSG_WIDTH,l);
   Label6.Caption:=iemsg(IEMSG_HEIGHT,l);
   GroupBox4.Caption:=' '+iemsg(IEMSG_GAMMACORRECTION,l)+' ';
   Label9.Caption:=iemsg(IEMSG_VALUE2,l);
   Button1.Caption:=iemsg(IEMSG_OK,l);
   Button2.Caption:=iemsg(IEMSG_CANCEL,l);
   Button4.Caption:=iemsg(IEMSG_PRINTSETUP,l)+'...';
   GroupBox6.Caption:=iemsg(IEMSG_MEASUREUNITS,l);
   Label10.Caption:=iemsg(IEMSG_UNITS,l);
   ComboBox2.Items[0]:=iemsg(IEMSG_INCHES,l);
end;

procedure Tfieprnform2.incdecmargins(text:TEdit; Button: TUDBtnType);
begin
	case button of
   	btNext:
      	text.Text:=floattostr(dmax(IEStrToFloatDef(text.Text,0)+FLOATINC,0));
      btPrev:
      	text.Text:=floattostr(dmax(IEStrToFloatDef(text.Text,0)-FLOATINC,0));
   end;
end;

procedure Tfieprnform2.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit1, Button);
end;

procedure Tfieprnform2.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit2, Button);
end;

procedure Tfieprnform2.UpDown3Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit3, Button);
end;

procedure Tfieprnform2.UpDown4Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit4, Button);
end;

procedure Tfieprnform2.UpDown7Click(Sender: TObject; Button: TUDBtnType);
begin
	case button of
   	btNext:
      	Edit7.Text:=floattostr(dmax(IEStrToFloatDef(Edit7.Text,0)+0.1,0));
      btPrev:
      	Edit7.Text:=floattostr(dmax(IEStrToFloatDef(Edit7.Text,0)-0.1,0));
   end;
end;

procedure Tfieprnform2.UpDown5Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit5, Button);
end;

procedure Tfieprnform2.UpDown6Click(Sender: TObject; Button: TUDBtnType);
begin
	incdecmargins(Edit6, Button);
end;

// setup
procedure Tfieprnform2.Button4Click(Sender: TObject);
begin
	PrinterSetupDialog1.Execute;
   printpreview(self);
end;

// units
procedure Tfieprnform2.ComboBox2Change(Sender: TObject);
var
   pred:TIEDialogsMeasureUnit;
   xmult:double;
begin
   pred:=fDialogsMeasureUnit;
   if ComboBox2.ItemIndex=0 then
      fDialogsMeasureUnit:=ieduSelectableDefInches
   else
      fDialogsMeasureUnit:=ieduSelectableDefCm;
   if pred<>fDialogsMeasureUnit then begin
      if pred=ieduSelectableDefCm then
         xmult:=1/2.54
      else
         xmult:=2.54;
      Edit1.Text:=floattostr(IEStrToFloatDef(Edit1.Text,0)*xmult);
      Edit2.Text:=floattostr(IEStrToFloatDef(Edit2.Text,0)*xmult);
      Edit3.Text:=floattostr(IEStrToFloatDef(Edit3.Text,0)*xmult);
      Edit4.Text:=floattostr(IEStrToFloatDef(Edit4.Text,0)*xmult);
      Edit5.Text:=floattostr(IEStrToFloatDef(Edit5.Text,0)*xmult);
      Edit6.Text:=floattostr(IEStrToFloatDef(Edit6.Text,0)*xmult);
      SetLanguage_units;
   end;
end;

{$else}  // {$ifdef IEINCLUDEPRINTDIALOGS}

interface
implementation

{$endif}

end.
