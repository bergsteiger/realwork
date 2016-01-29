//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "gtClasses3"
#pragma link "gtCstDocEng"
#pragma link "gtCstHTMLEng"
#pragma link "gtCstPDFEng"
#pragma link "gtCstPlnEng"

#ifdef gtPro
#pragma link "gtExHTMLEng"
#pragma link "gtExPDFEng"
#endif

#pragma link "gtHTMLEng"
#pragma link "gtPDFEng"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
  TgtPDFEngine *FEngine = new TgtPDFEngine(this);
  FEngine->Preferences->ShowSetupDialog = CheckBox1->Checked;
  FEngine->Preferences->OpenAfterCreate = CheckBox2->Checked;
	FEngine->FileName = "BlankDoc";
	FEngine->Page->PaperSize = A4;
	//... Set any other document properties as required
	FEngine->BeginDoc();
	if (FEngine->EngineStatus == esStarted)
  {
		// 1st Page: Render text, image and other items here

		FEngine->NewPage();
		// 2nd Page: Render text, image and other items here

	  // Similarly render any number of pages using NewPage method
	  FEngine->EndDoc();
	}
	delete FEngine;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{
	TgtPDFEngine *FEngine = new TgtPDFEngine(this);
  FEngine->Preferences->ShowSetupDialog = CheckBox1->Checked;
  FEngine->Preferences->OpenAfterCreate = CheckBox2->Checked;
  FEngine->FileName = "TextOut";
  FEngine->Page->PaperSize = A4;
  //... Set any other document properties as required
  FEngine->BeginDoc();
  if (FEngine->EngineStatus == esStarted)
  {
    FEngine->Font->Name = "Arial";
    FEngine->Font->Size = 18;
    FEngine->Font->Style = TFontStyles() << fsBold << fsUnderline;
    //... Set any text properties as required
    FEngine->TextOut(3, 2, "Simple TextOut Demo");

    FEngine->Brush->Color = clLtGray;
    FEngine->Brush->Style = bsSolid;
    FEngine->Font->Style = TFontStyles();
    FEngine->Font->Size = 14;
    FEngine->Font->Color = clBlue;
    //... Change settings if necessary
    FEngine->TextOut(2, 5, "Gnostice eDocEngine. Visit www.gnostice.com");
    FEngine->EndDoc();
  } 
  delete FEngine;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button5Click(TObject *Sender)
{
	TgtPDFEngine *FEngine = new TgtPDFEngine(this);
  FEngine->Preferences->ShowSetupDialog = CheckBox1->Checked;
  FEngine->Preferences->OpenAfterCreate = CheckBox2->Checked;
  FEngine->FileName = "Images";
  FEngine->MeasurementUnit = muPixels;
  FEngine->Page->PaperSize = A4;
	//... Set any other document properties as required
  FEngine->BeginDoc();
  if (FEngine->EngineStatus == esStarted)
  {
  	FEngine->TextFormatting->BeforeSpace = 144;
    FEngine->TextFormatting->Alignment = haCenter;
    FEngine->Font->Name = "Arial";
    FEngine->Font->Style = TFontStyles() << fsBold << fsUnderline;
    FEngine->Font->Size = 20;
    FEngine->BeginPara();
    FEngine->TextOut("Image Drawing Demo");
    FEngine->EndPara();
    FEngine->ImageSettings->OutputImageFormat = ifJPEG;
    FEngine->ImageSettings->IsFrame = True;
    FEngine->ImageSettings->Stretch = True;
    FEngine->ImageSettings->KeepAspectRatio = True;
    FEngine->Pen->Width = 2;
    FEngine->Pen->Color = clBlue;
    FEngine->Brush->Color = clLtGray;
    //... Set any image properties through ImageSettings as required

    //Use this method to draw image at a perticular position
    FEngine->DrawImage(210, 336, Image2->Picture->Graphic);

    //Use this method to specify a rectangle within which to draw the image
    FEngine->ImageSettings->Stretch = False;
    FEngine->ImageSettings->KeepAspectRatio = False;
    FEngine->ImageSettings->Center = True;
    FEngine->DrawImage(gtRect(200, 192, 600, 307.2), Image3->Picture->Graphic);
	  FEngine->EndDoc();
  }
  delete FEngine;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button6Click(TObject *Sender)
{
	TgtPDFEngine *FEngine = new TgtPDFEngine(this);
  FEngine->Preferences->ShowSetupDialog = CheckBox1->Checked;
  FEngine->Preferences->OpenAfterCreate = CheckBox2->Checked;
  FEngine->FileName = "Shapes";
  FEngine->Page->PaperSize = A4;
  FEngine->Page->LeftMargin = 0.5;
  FEngine->Page->RightMargin = 0.5;
  FEngine->Page->BottomMargin = 0.5;
  FEngine->Page->TopMargin = 0.5;
  //... Set any other document properties as required
  FEngine->BeginDoc();
  if (FEngine->EngineStatus == esStarted)
  {
    FEngine->TextFormatting->BeforeSpace = 1.5;
    FEngine->TextFormatting->Alignment = haCenter;
    FEngine->Font->Name = "Arial";
    FEngine->Font->Style = TFontStyles() << fsBold << fsUnderline;
    FEngine->Font->Size = 20;
    FEngine->BeginPara();
      FEngine->TextOut("Shape Drawing Demo");
    FEngine->EndPara();
    FEngine->Pen->Color = clBlack;
    FEngine->Brush->Color = clLtGray;
    //... Set/Change Pen and Brush at any point.
    //Last parameter specifies if the shape needs to be filled with
    //the current brush
    FEngine->Ellipse(1.5, 2.5, 4, 3.5, False);
    FEngine->Pen->Style = psDashDot;
    FEngine->Brush->Style = bsFDiagonal;
    FEngine->Brush->Color = clGreen;
    FEngine->RoundRect(6.3, 5.6, 7.3, 7.5, 0.25, 0.15, True);
    FEngine->Arc(4.2, 2.2, 6, 2.6, 4.5, 6, 4, 4);
    FEngine->Chord(0.2, 4, 3, 5, 2.3, 3, 4.3, 5, True);
    FEngine->Pie(4.2, 4, 5, 5, 3, 3, 4.5, 5.2, False);
    FEngine->Pen->Color = clBlue;
    FEngine->Brush->Color = clLtGray;
    FEngine->Line(0.5, 5.5, 1.75, 7.7);
    FEngine->Rectangle(2, 5.5, 6, 7.8, True);
  	FEngine->EndDoc();
  }
  delete FEngine;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
  TList *LColumns;
  String LS;
  int I, J, LState1, LState2, LState3, LState4;
  TGraphic *LGraphic;
	LS = "Gnostice eDocEngine is a comprehensive, generic, electronic"
  	" document creation component suite for Borland® Delphi™"
    " and Borland® C++Builder™. eDocEngine enables developers to deliver"
    " information straight from the applications they develop in over 20"
    " popular electronic document formats, including PDF, HTML, RTF, TIFF,"
    " XML graphics and many more.";
  TgtPDFEngine *FEngine = new TgtPDFEngine(this);
  FEngine->Preferences->ShowSetupDialog = CheckBox1->Checked;
  FEngine->Preferences->OpenAfterCreate = CheckBox2->Checked;
  FEngine->Page->PaperSize = A4;
  FEngine->FileName = "AdvancedFeatures";
  FEngine->MeasurementUnit = muPixels;
  FEngine->BeginDoc();
  if (FEngine->EngineStatus == esStarted)
  {
    FEngine->TextFormatting->Alignment = haCenter;
    FEngine->TextFormatting->BeforeSpace = 125;
    FEngine->Font->Name = "Arial";
    FEngine->Font->Size = 18;
    FEngine->Font->Color = clBlue;
    FEngine->Font->Style = TFontStyles() << fsBold;
    FEngine->BeginPara();
      FEngine->TextOut("Advanced Drawing Functions");
    FEngine->EndPara();
    FEngine->Font->Size = 7;
    FEngine->Font->Style = TFontStyles();
    FEngine->TableSettings->ColumnWidth = 100;
    FEngine->TableSettings->RowHeight = 40;
    FEngine->TableSettings->EnableTitle = True;
    FEngine->TableSettings->TitleHeight = 10;
    FEngine->TableSettings->InternalMargin = gtRect(5,5,5,5);
    FEngine->ImageSettings->Stretch = True;

    LState1 = FEngine->SaveEngineState();
    FEngine->TextFormatting->BeforeSpace = 8;
    FEngine->TextFormatting->Alignment = haLeft;
    FEngine->TextFormatting->LeftIndent = 40;
    FEngine->Font->Size = 12;
    FEngine->Font->Color = clBlack;
    FEngine->Font->Style = TFontStyles() << fsBold << fsUnderline;
    FEngine->BeginPara();
    FEngine->TextOut("Paragraph Support");
    FEngine->EndPara();
    LState2 = FEngine->SaveEngineState();
    FEngine->Font->Style = TFontStyles() << fsBold;
    FEngine->Font->Size = 8;
    FEngine->BeginPara();
      FEngine->TextOut("Align Left");
    FEngine->EndPara();
    LState4 = FEngine->SaveEngineState();
    FEngine->TextFormatting->RightIndent = 75;
    FEngine->TextFormatting->LeftIndent = 75;
    FEngine->TextFormatting->BeforeSpace = 5;
    FEngine->Font->Size = 10;
    FEngine->Font->Color = clMaroon;
    FEngine->Font->Style = TFontStyles();
    LState3 = FEngine->SaveEngineState();
    FEngine->TextFormatting->Alignment = haLeft;
    FEngine->BeginPara();
    FEngine->TextOut(LS);
    FEngine->EndPara();

    FEngine->RestoreEngineState(LState4);
    FEngine->BeginPara();
    FEngine->TextOut("Align Right");
    FEngine->EndPara();
    FEngine->RestoreEngineState(LState3);

    FEngine->TextFormatting->Alignment = haRight;
    FEngine->BeginPara();
    FEngine->TextOut(LS);
    FEngine->EndPara();

    FEngine->RestoreEngineState(LState4);
    FEngine->BeginPara();
    FEngine->TextOut("Center");
    FEngine->EndPara();
    FEngine->RestoreEngineState(LState3);

    FEngine->TextFormatting->Alignment = haCenter;
    FEngine->BeginPara();
    FEngine->TextOut(LS);
    FEngine->EndPara();

    FEngine->RestoreEngineState(LState4);
    FEngine->BeginPara();
    FEngine->TextOut("Justify");
    FEngine->EndPara();
    FEngine->RestoreEngineState(LState3);

    FEngine->TextFormatting->Alignment = haJustify;
    FEngine->BeginPara();
    FEngine->TextOut(LS);
    FEngine->EndPara();

    FEngine->RestoreEngineState(LState2);

    FEngine->TextFormatting->BeforeSpace = 40;
    FEngine->BeginPara();
    FEngine->TextOut("Table Support");
    FEngine->EndPara();

    FEngine->RestoreEngineState(LState1);

    FEngine->Pen->Width = 2;
    FEngine->Brush->Color = clAqua;
    FEngine->ImageSettings->Transparent = True;
    LColumns = FEngine->BeginTable(40, 615, 5);

    for(I = 0; I < 5; I++)
    {
     ((TgtColumn *)(LColumns->Items[I]))->Width = DBGrid1->Columns->Items[I]->Width;
     ((TgtColumn *)(LColumns->Items[I]))->Title = DBGrid1->Columns->Items[I]->Title->Caption;
    }

    DBGrid1->DataSource->DataSet->Next();
    for(J = 0; J < 3; J++)
    {
      FEngine->NewRow();
      for(I = 0; I < 5; I++)
      {
        if(I != 2)
        {
          FEngine->Brush->Style = bsClear;
          FEngine->TextOut(I, DBGrid1->Fields[I]->AsString);
        }
        else
        {
          FEngine->Brush->Color = clAqua;
          FEngine->Brush->Style = bsSolid;
          DBImage1->Refresh();
          LGraphic = DBImage1->Picture->Graphic;
          FEngine->DrawImage(I, LGraphic->Width, LGraphic->Height, LGraphic);
        }
      }
      DBGrid1->DataSource->DataSet->Next();
    }
    FEngine->EndTable();
    DBGrid1->DataSource->DataSet->First();

    FEngine->RestoreEngineState(LState2);

    FEngine->TextOut(40, 965, "Textbox Support");

    FEngine->RestoreEngineState(LState1);
    FEngine->Brush->Color = clLime;
    FEngine->Pen->Width = 3;

    FEngine->Frame->InternalMargin = gtRect(5, 5, 4, 4);
    FEngine->TextBox(gtRect(40, 990, 300, 1100), LS, haJustify, vaTop);

    FEngine->Pen->Style = psDash;
    FEngine->TextBox(gtRect(430, 990, 690, 1100), LS, haJustify, vaTop);

    FEngine->EndDoc();
  }
  delete FEngine;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button7Click(TObject *Sender)
{
	TgtPDFEngine *FEngine = new TgtPDFEngine(this);
  FEngine->Preferences->ShowSetupDialog = CheckBox1->Checked;
  FEngine->Preferences->OpenAfterCreate = CheckBox2->Checked;
  FEngine->FileName = "Metafile";
  FEngine->Page->PaperSize = A4;
  FEngine->Page->LeftMargin = 0;
  FEngine->Page->RightMargin = 0;
  FEngine->Page->BottomMargin = 0;
  FEngine->Page->TopMargin = 0;
  FEngine->BeginDoc();
  if (FEngine->EngineStatus == esStarted)
  {
		TMetafile *LMetafile = new TMetafile();
    LMetafile->Assign(Image1->Picture->Graphic);
    FEngine->PlayMetafile(LMetafile);
	  FEngine->EndDoc();
    delete LMetafile;
	}
  delete FEngine;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button8Click(TObject *Sender)
{
	TgtPDFEngine *FEngine = new TgtPDFEngine(this);
  FEngine->Preferences->ShowSetupDialog = CheckBox1->Checked;
  FEngine->Preferences->OpenAfterCreate = CheckBox2->Checked;
  FEngine->FileName = "HeaderFooter";
  FEngine->Page->PaperSize = A4;
  FEngine->Page->HeaderHeight = 2;
  FEngine->Page->FooterHeight = 2;
  FEngine->Page->LeftMargin = 0.25;
  FEngine->Page->RightMargin = 0.25;
  FEngine->Page->BottomMargin = 0.25;
  FEngine->Page->TopMargin = 0.25;

  FEngine->BeginDoc();
  if (FEngine->EngineStatus == esStarted)
  {
  	FEngine->BeginHeader();
    FEngine->Font->Name = "Courier New";
    FEngine->Font->Size = 10;
    FEngine->Font->Color = clBlue;
    FEngine->TextFormatting->Alignment = haRight;
    FEngine->TextFormatting->BeforeSpace = 1.1;
    FEngine->BeginPara();
    FEngine->TextOut("Document Header");
    FEngine->EndPara();
    FEngine->ImageSettings->Stretch = True;
    FEngine->ImageSettings->KeepAspectRatio = True;
    FEngine->DrawImage(gtRect(0.3, 0.9, 2, 2), Image3->Picture->Graphic);
    FEngine->EndHeader();
    FEngine->BeginFooter();
    FEngine->Font->Name = "Verdana";
    FEngine->Font->Size = 10;
    FEngine->Font->Color = clRed;
    FEngine->TextOut(0.3, 0.9, "Gnostice Information Technologies Private Limited");
    FEngine->TextOut(6, 0.9, "www.gnostice.com");
    FEngine->EndFooter();
    FEngine->Font->Name = "Times New Roman";
    FEngine->Font->Size = 20;
    FEngine->Font->Color = clBlack;
    FEngine->TextFormatting->BeforeSpace = 2;
    FEngine->TextFormatting->Alignment = haCenter;
    FEngine->BeginPara();
    FEngine->TextOut("eDocEngine");
    FEngine->EndPara();
    FEngine->TextFormatting->BeforeSpace = 0.3;
    FEngine->BeginPara();
    FEngine->TextOut("Header and Footer Demo");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("Page 1");
    FEngine->EndPara();
    FEngine->NewPage();
    FEngine->TextFormatting->BeforeSpace = 2;
    FEngine->BeginPara();
    FEngine->TextOut("eDocEngine");
    FEngine->EndPara();
    FEngine->TextFormatting->BeforeSpace = 0.3;
    FEngine->BeginPara();
    FEngine->TextOut("Header and Footer Demo");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("Page 2");
    FEngine->EndPara();
    FEngine->NewPage();
    FEngine->TextFormatting->BeforeSpace = 2;
    FEngine->BeginPara();
    FEngine->TextOut("eDocEngine");
    FEngine->EndPara();
    FEngine->TextFormatting->BeforeSpace = 0.3;
    FEngine->BeginPara();
    FEngine->TextOut("Header and Footer Demo");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("Page 3");
    FEngine->EndPara();
    FEngine->EndDoc();
	}
  delete FEngine;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button9Click(TObject *Sender)
{
	TgtPDFEngine *FEngine = new TgtPDFEngine(this);
  FEngine->Preferences->ShowSetupDialog = CheckBox1->Checked;
  FEngine->Preferences->OpenAfterCreate = CheckBox2->Checked;
  FEngine->FileName = "Watermark";
  FEngine->Page->PaperSize = A4;
  FEngine->Page->HeaderHeight = 2;
  FEngine->Page->FooterHeight = 2;
  FEngine->Page->LeftMargin = 0.25;
  FEngine->Page->RightMargin = 0.25;
  FEngine->Page->BottomMargin = 0.25;
  FEngine->Page->TopMargin = 0.25;

  FEngine->BeginDoc();
  if (FEngine->EngineStatus == esStarted)
  {
  	FEngine->BeginWaterMark();
    FEngine->Font->Name = "Verdana";
    FEngine->Font->Size = 6;
    FEngine->Pen->Width = 2;
    FEngine->Rectangle(1.5, 1.7, 6.35, 3.5, False);
    FEngine->TextOut(5.7, 3.35, "Watermark");
    FEngine->Font->Size = 12;
    FEngine->Font->Color = clBlue;
    FEngine->TextFormatting->Alignment = haCenter;
    FEngine->TextFormatting->BeforeSpace = 2;
    FEngine->BeginPara();
    FEngine->TextOut("Gnostice Information Technologies Private Limited");
    FEngine->EndPara();
    FEngine->ImageSettings->Stretch = True;
    FEngine->ImageSettings->KeepAspectRatio = True;
    FEngine->DrawImage(2.5, 2.5, Image3->Picture->Graphic);
    FEngine->EndWaterMark();
    FEngine->Font->Name = "Times New Roman";
    FEngine->Font->Size = 20;
    FEngine->Font->Color = clBlack;
    FEngine->TextFormatting->BeforeSpace = 2;
    FEngine->TextFormatting->Alignment = haCenter;
    FEngine->BeginPara();
    FEngine->TextOut("eDocEngine");
    FEngine->EndPara();
    FEngine->TextFormatting->BeforeSpace = 0.3;
    FEngine->BeginPara();
    FEngine->TextOut("Watermark Demo");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("Page 1");
    FEngine->EndPara();
    FEngine->NewPage();
    FEngine->TextFormatting->BeforeSpace = 2;
    FEngine->BeginPara();
    FEngine->TextOut("eDocEngine");
    FEngine->EndPara();
    FEngine->TextFormatting->BeforeSpace = 0.3;
    FEngine->BeginPara();
    FEngine->TextOut("Watermark Demo");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("Page 2");
    FEngine->EndPara();
    FEngine->NewPage();
    FEngine->TextFormatting->BeforeSpace = 2;
    FEngine->BeginPara();
    FEngine->TextOut("eDocEngine");
    FEngine->EndPara();
    FEngine->TextFormatting->BeforeSpace = 0.3;
    FEngine->BeginPara();
    FEngine->TextOut("Watermark Demo");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("Page 3");
    FEngine->EndPara();
	  FEngine->EndDoc();
	}
  delete FEngine;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{
  int LI;
	TgtPDFEngine *FEngine = new TgtPDFEngine(this);
  FEngine->Preferences->ShowSetupDialog = CheckBox1->Checked;
  FEngine->Preferences->OpenAfterCreate = CheckBox2->Checked;
  FEngine->FileName = "PDFBookmarks";
  FEngine->MeasurementUnit = muPixels;
  FEngine->Page->PaperSize = A4;
  FEngine->Page->LeftMargin = 25;
  FEngine->Page->RightMargin = 25;
  FEngine->Page->BottomMargin = 25;
  FEngine->Page->TopMargin = 25;
  FEngine->BeginDoc();
  if (FEngine->EngineStatus == esStarted)
  {
  	FEngine->Font->Name = "Times New Roman";
    FEngine->Font->Size = 20;
    FEngine->Font->Color = clBlue;
    FEngine->TextFormatting->BeforeSpace = 400;
    FEngine->TextFormatting->Alignment = haCenter;
    FEngine->BeginPara();
    FEngine->TextOut("eDocEngine");
    FEngine->EndPara();
    FEngine->Font->Size = 18;
    FEngine->TextFormatting->BeforeSpace = 50;
    FEngine->BeginPara();
    FEngine->TextOut("PDF Bookmarks Demo");
    FEngine->EndPara();
    FEngine->NewPage();
    FEngine->TextFormatting->BeforeSpace = 120;
    FEngine->TextFormatting->Alignment = haRight;
    FEngine->Font->Size = 18;
    FEngine->Font->Color = clBlack;
    FEngine->Font->Style = TFontStyles() << fsBold << fsUnderline;
    FEngine->BeginPara();
    FEngine->TextOut("Introduction");
    FEngine->EndPara();
    FEngine->TextFormatting->BeforeSpace = 150;
    FEngine->Font->Style = TFontStyles() << fsBold;
    FEngine->TextFormatting->Alignment = haLeft;
    FEngine->Font->Size = 16;
    FEngine->BeginPara();
    FEngine->TextOut("1.1. What is eDocEngine?");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("1.2. System Requirements");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("1.3. Legal Notices");
    FEngine->EndPara();
    FEngine->NewPage();
    FEngine->TextFormatting->BeforeSpace = 120;
    FEngine->TextFormatting->Alignment = haRight;
    FEngine->Font->Size = 18;
    FEngine->Font->Style = TFontStyles() << fsBold << fsUnderline;
    FEngine->BeginPara();
    FEngine->TextOut("Using eDocEngine");
    FEngine->EndPara();
    FEngine->TextFormatting->BeforeSpace = 150;
    FEngine->Font->Style = TFontStyles() << fsBold;
    FEngine->TextFormatting->Alignment = haLeft;
    FEngine->Font->Size = 16;
    FEngine->BeginPara();
    FEngine->TextOut("2.1. Starting eDocEngine");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("2.2. Advanced Features");
    FEngine->EndPara();
    FEngine->Font->Size = 14;
    FEngine->BeginPara();
    FEngine->TextOut("2.2.1. Paragraphs");
    FEngine->EndPara();
    FEngine->NewPage();
    FEngine->TextFormatting->BeforeSpace = 150;
    FEngine->BeginPara();
    FEngine->TextOut("2.2.2. Tables");
    FEngine->EndPara();

    // Bookmarks
    FEngine->AddTOCItem("PDF Bookmarks Demo", -1, 1, 0);
    LI = FEngine->AddTOCItem("1. Introduction", -1, 2, 145);
    FEngine->AddTOCItem("1.1. What is eDocEngine?", LI, 2, 320);
    FEngine->AddTOCItem("1.2. System Requirements", LI, 2, 495);
    FEngine->AddTOCItem("1.3. Legal Notices", LI, 2, 670);
    LI = FEngine->AddTOCItem("2. Using eDocEngine", -1, 3, 145);
    FEngine->AddTOCItem("2.1. Starting eDocEngine", LI, 3, 320);
    LI = FEngine->AddTOCItem("2.2. Advanced Features", LI, 3, 495);
    FEngine->AddTOCItem("2.2.1. Paragraphs", LI, 3, 670);
    FEngine->AddTOCItem("2.2.2. Tables", LI, 4, 175);
    FEngine->AddTOCItem("www.gnostice.com", -1, "http://www.gnostice.com");
    FEngine->ViewerPreferences->PageMode = pmUseOutlines;
  	FEngine->EndDoc();
	}
  delete FEngine;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button11Click(TObject *Sender)
{
#ifdef gtPro
	TgtPDFEngine *FEngine = new TgtPDFEngine(this);
  TgtPDFFormPushButton *PDFButton;
  TgtPDFFormCheckBox *PDFCheckbox;
  TgtPDFTextAnnot *PDFTextAnnot;
  TgtPDFFormRadioButton *PDFRadioGroup;
  TgtPDFFormRadioItem *PDFRadioI1, *PDFRadioI2, *PDFRadioI3;
  TgtPDFFormComboBox *PDFComboBox;
  TgtPDFFormListBox *PDFListBox;
  TgtPDFFormTextField *PDFTextField;

  FEngine->Preferences->ShowSetupDialog = CheckBox1->Checked;
  FEngine->Preferences->OpenAfterCreate = CheckBox2->Checked;
  FEngine->MeasurementUnit = muPixels;
  FEngine->Page->PaperSize = A4;
  FEngine->FileName = "PDFForms";
  FEngine->BeginDoc();
  if (FEngine->EngineStatus == esStarted)
  {
    FEngine->Font->Name = "Verdana";
    FEngine->Font->Size = 15;
    FEngine->TextFormatting->Alignment = haCenter;
    FEngine->TextFormatting->BeforeSpace = 125;
    FEngine->Font->Size = 20;
    FEngine->Font->Color = clRed;
    FEngine->Font->Style = TFontStyles() << fsBold;
    FEngine->BeginPara();
    FEngine->TextOut("PDF Forms Demo");
    FEngine->EndPara();
    FEngine->TextFormatting->BeforeSpace = 15;
    FEngine->Font->Name = "Arial";
    FEngine->Font->Size = 12;
    FEngine->Font->Color = clBlack;
    FEngine->Font->Style = TFontStyles() << fsBold << fsUnderline;
    FEngine->BeginPara();
    FEngine->TextOut("Buttons");
    FEngine->EndPara();

    // Push Button with JavaScript Action.
    PDFButton = new TgtPDFFormPushButton();
    PDFButton->Rect = gtRect(190, 200, 330, 250);
    PDFButton->Font->Name = "Comic Sans MS";
    PDFButton->Font->Size = 15;
    PDFButton->FieldName = "JavaScriptButton";
    PDFButton->NormalCaption = "JavaScript";
    PDFButton->RolloverCaption = "Rollover";
    PDFButton->DownCaption = "Down";
    PDFButton->Action = pbaJavaScript;
    PDFButton->BackgroundColor = clBtnFace;
    PDFButton->JavaScript = "app.alert(\"Gnostice Information Technologies Private Limited\")";
    FEngine->AddFormItem(PDFButton);

    // Push Button with Submit Action. 
    PDFButton = new TgtPDFFormPushButton();
    PDFButton->Rect = gtRect(350, 200, 470, 250);
    PDFButton->Font->Name = "Comic Sans MS";
    PDFButton->Font->Size = 15;
    PDFButton->FieldName = "SubmitButton";
    PDFButton->NormalCaption = "Submit";
    PDFButton->RolloverCaption = "Rollover";
    PDFButton->DownCaption = "Down";
    PDFButton->Action = pbaSubmit;
    PDFButton->BackgroundColor = clBtnFace;
    PDFButton->SubmitURL = "http://www.gnostice.com";
    FEngine->AddFormItem(PDFButton);

    // Push Button with Reset Action. 
    PDFButton = new TgtPDFFormPushButton();
    PDFButton->Rect = gtRect(500, 200, 620, 250);
    PDFButton->Font->Name = "Comic Sans MS";
    PDFButton->Font->Size = 15;
    PDFButton->FieldName = "ResetButton";
    PDFButton->NormalCaption = "Reset";
    PDFButton->RolloverCaption = "Rollover";
    PDFButton->DownCaption = "Down";
    PDFButton->Action = pbaReset;
    PDFButton->BackgroundColor = clBtnFace;
    FEngine->AddFormItem(PDFButton);

    FEngine->TextFormatting->BeforeSpace = 75;
    FEngine->BeginPara();
      FEngine->TextOut("Checkboxes");
    FEngine->EndPara();
    // Checkbox 1
    PDFCheckbox = new TgtPDFFormCheckBox();
    PDFCheckbox->Rect = gtRect(340, 295, 365, 320);
    PDFCheckbox->Font->Size = 15;
    PDFCheckbox->Font->Color = clRed;
    PDFCheckbox->FieldName = "Checkbox1";
    PDFCheckbox->Symbol = pfcsStar;
    PDFCheckbox->Checked = False;
    FEngine->AddFormItem(PDFCheckbox);

    // Checkbox 2
    PDFCheckbox = new TgtPDFFormCheckBox();
    PDFCheckbox->Rect = gtRect(390, 295, 415, 320);
    PDFCheckbox->Font->Size = 15;
    PDFCheckbox->Font->Color = clRed;
    PDFCheckbox->FieldName = "Checkbox2";
    PDFCheckbox->Symbol = pfcsCheck;
    PDFCheckbox->Checked = False;
    FEngine->AddFormItem(PDFCheckbox);

    // Checkbox 3
    PDFCheckbox = new TgtPDFFormCheckBox();
    PDFCheckbox->Rect = gtRect(440, 295, 465, 320);
    PDFCheckbox->Font->Size = 15;
    PDFCheckbox->Font->Color = clRed;
    PDFCheckbox->FieldName = "Checkbox3";
    PDFCheckbox->Symbol = pfcsCross;
    PDFCheckbox->Checked = False;
    FEngine->AddFormItem(PDFCheckbox);

    FEngine->TextFormatting->BeforeSpace = 50;
    FEngine->BeginPara();
    FEngine->TextOut("Radio Button Group");
    FEngine->EndPara();

    // RadioGroup
    PDFRadioGroup = new TgtPDFFormRadioButton();
    PDFRadioGroup->Font->Size = 20;
    PDFRadioGroup->FieldName = "RadioGroup";
    PDFRadioGroup->Symbol = pfcsDiamond;
    PDFRadioGroup->AtleastOneSelectedItem = True;

    PDFRadioI1 = new TgtPDFFormRadioItem();
    PDFRadioI1->Rect = gtRect(340, 370, 365, 395);
    PDFRadioGroup->AddItem(PDFRadioI1);

    PDFRadioI2 = new TgtPDFFormRadioItem();
    PDFRadioI2->Rect = gtRect(390, 370, 415, 395);
    PDFRadioGroup->AddItem(PDFRadioI2);

    PDFRadioI3 = new TgtPDFFormRadioItem();
    PDFRadioI3->Rect = gtRect(440, 370, 465, 395);
    PDFRadioGroup->AddItem(PDFRadioI3);

    PDFRadioGroup->SelectedItemIndex = 1;
    FEngine->AddFormItem(PDFRadioGroup);

    FEngine->TextFormatting->BeforeSpace = 60;
    FEngine->BeginPara();
      FEngine->TextOut("ComboBox");
    FEngine->EndPara();

    // Combobox 
    PDFComboBox = new TgtPDFFormComboBox();
    PDFComboBox->Rect = gtRect(320, 455, 485, 480);
    PDFComboBox->Font->Size = 10;
    PDFComboBox->Font->Color = clBlue;
    PDFComboBox->FieldName = "Combo Box";
    PDFComboBox->BackgroundColor = clYellow;
    PDFComboBox->AddItem("TgtExcelEngine");
    PDFComboBox->AddItem("TgtPDFEngine");
    PDFComboBox->AddItem("TgtRTFEngine");
    PDFComboBox->AddItem("TgtSVGEngine");
    PDFComboBox->SelectedItemIndex = 1;
    FEngine->AddFormItem(PDFComboBox);

    FEngine->TextFormatting->BeforeSpace = 65;
    FEngine->BeginPara();
    FEngine->TextOut("List Box");
    FEngine->EndPara();

    // Listbox 
    PDFListBox = new TgtPDFFormListBox();
    PDFListBox->Rect = gtRect(335, 535, 465, 575);
    PDFListBox->Font->Size = 10;
    PDFListBox->Font->Color = clBlue;
    PDFListBox->FieldName = "ListBox";
    PDFListBox->BackgroundColor = clYellow;
    PDFListBox->AddItem("TgtExcelEngine");
    PDFListBox->AddItem("TgtPDFEngine");
    PDFListBox->AddItem("TgtRTFEngine");
    PDFListBox->AddItem("TgtSVGEngine");
    PDFListBox->IsMultiSelect = True;
    FEngine->AddFormItem(PDFListBox);

    FEngine->TextFormatting->BeforeSpace = 75;
    FEngine->BeginPara();
      FEngine->TextOut("Single Line Text Field");
    FEngine->EndPara();

    // Single line text 
    PDFTextField = new TgtPDFFormTextField();
    PDFTextField->Rect = gtRect(240, 630, 565, 655);
    PDFTextField->Font->Size = 10;
    PDFTextField->Font->Color = clBlack;
    PDFTextField->FieldName = "SingleLineText";
    PDFTextField->BackgroundColor = clLime;
    PDFTextField->Value = "Gnostice eDocEngine";
    PDFTextField->MaxLength = 30;
    FEngine->AddFormItem(PDFTextField);

    FEngine->TextFormatting->BeforeSpace = 65;
    FEngine->BeginPara();
    FEngine->TextOut("Password Text Field");
    FEngine->EndPara();

    // Password 
    PDFTextField = new TgtPDFFormTextField();
    PDFTextField->Rect = gtRect(240, 705, 565, 730);
    PDFTextField->Font->Size = 10;
    PDFTextField->Font->Color = clBlack;
    PDFTextField->FieldName = "PasswordText";
    PDFTextField->BackgroundColor = clLime;
    PDFTextField->IsPassword = True;
    PDFTextField->MaxLength = 30;
    FEngine->AddFormItem(PDFTextField);

    FEngine->TextFormatting->BeforeSpace = 80;
    FEngine->BeginPara();
    FEngine->TextOut("Multiline Text Field");
    FEngine->EndPara();

    // Multiline text 
    PDFTextField = new TgtPDFFormTextField();
    PDFTextField->Rect = gtRect(240, 810, 565, 910);
    PDFTextField->Font->Size = 10;
    PDFTextField->Font->Color = clBlack;
    PDFTextField->FieldName = "MultiLineText";
    PDFTextField->BackgroundColor = clLime;
    PDFTextField->Value = "Gnostice eDocEngine";
    PDFTextField->IsMultiline = True;
    FEngine->AddFormItem(PDFTextField);

    // Text Annotation
    PDFTextAnnot = new TgtPDFTextAnnot();
    PDFTextAnnot->Rect = gtRect(600, 425, 600, 825);
    PDFTextAnnot->Contents = "Using Gnostice eDocEngine, you can even add notes to "
      "the PDF documents created and assist the user in filling up forms.";
    PDFTextAnnot->Open = True;
    PDFTextAnnot->Name = tnComment;

    FEngine->AddAnnotItem(PDFTextAnnot);

    FEngine->EndDoc();
  }
  delete FEngine;
#endif
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button10Click(TObject *Sender)
{
  #ifdef gtPro
  int LI;
	TgtHTMLEngine *FEngine = new TgtHTMLEngine(this);
  FEngine->Preferences->ShowSetupDialog = CheckBox1->Checked;
  FEngine->Preferences->OpenAfterCreate = CheckBox2->Checked;
  FEngine->FileName = "TableOfContents";
  FEngine->MeasurementUnit = muPixels;
  FEngine->Page->PaperSize = A4;
  FEngine->Page->LeftMargin = 25;
  FEngine->Page->RightMargin = 25;
  FEngine->Page->BottomMargin = 25;
  FEngine->Page->TopMargin = 25;
  FEngine->Preferences->SingleFile = False;
  FEngine->Navigator->Enabled = True;
  FEngine->TOCPageSettings->ItemFont->Name = "Arial";
  FEngine->TOCPageSettings->ItemFont->Size = 12;
  FEngine->TOCPageSettings->ItemFont->Color = clBlue;
  FEngine->TOCPageSettings->TitleFont->Name = "Verdana";
  FEngine->TOCPageSettings->TitleFont->Size = 16;
  FEngine->TOCPageSettings->TitleFont->Color = clRed;
  FEngine->TOCPageSettings->TitleFont->Style = TFontStyles() << fsBold << fsUnderline;
  FEngine->TOCPageSettings->Title = "Table of Contents";
  FEngine->BeginDoc();
  if (FEngine->EngineStatus == esStarted)
  {
    FEngine->Font->Name = "Times New Roman";
    FEngine->Font->Size = 20;
    FEngine->Font->Color = clBlue;
    FEngine->TextFormatting->BeforeSpace = 400;
    FEngine->TextFormatting->Alignment = haCenter;
    FEngine->BeginPara();
    FEngine->TextOut("eDocEngine");
    FEngine->EndPara();
    FEngine->Font->Size = 18;
    FEngine->TextFormatting->BeforeSpace = 50;
    FEngine->BeginPara();
    FEngine->TextOut("HTML Table of Contents Demo");
    FEngine->EndPara();
    FEngine->NewPage();
    FEngine->TextFormatting->BeforeSpace = 120;
    FEngine->TextFormatting->Alignment = haRight;
    FEngine->Font->Size = 18;
    FEngine->Font->Color = clBlack;
    FEngine->Font->Style = TFontStyles() << fsBold << fsUnderline;
    FEngine->BeginPara();
    FEngine->TextOut("Introduction");
    FEngine->EndPara();
    FEngine->TextFormatting->BeforeSpace = 150;
    FEngine->Font->Style = TFontStyles() << fsBold;
    FEngine->TextFormatting->Alignment = haLeft;
    FEngine->Font->Size = 16;
    FEngine->BeginPara();
    FEngine->TextOut("1.1. What is eDocEngine?");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("1.2. System Requirements");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("1.3. Legal Notices");
    FEngine->EndPara();
    FEngine->NewPage();
    FEngine->TextFormatting->BeforeSpace = 120;
    FEngine->TextFormatting->Alignment = haRight;
    FEngine->Font->Size = 18;
    FEngine->Font->Style = TFontStyles() << fsBold << fsUnderline;
    FEngine->BeginPara();
    FEngine->TextOut("Using eDocEngine");
    FEngine->EndPara();
    FEngine->TextFormatting->BeforeSpace = 150;
    FEngine->Font->Style = TFontStyles() << fsBold;
    FEngine->TextFormatting->Alignment = haLeft;
    FEngine->Font->Size = 16;
    FEngine->BeginPara();
    FEngine->TextOut("2.1. Starting eDocEngine");
    FEngine->EndPara();
    FEngine->BeginPara();
    FEngine->TextOut("2.2. Advanced Features");
    FEngine->EndPara();
    FEngine->Font->Size = 14;
    FEngine->BeginPara();
    FEngine->TextOut("2.2.1. Paragraphs");
    FEngine->EndPara();
    FEngine->NewPage();
    FEngine->TextFormatting->BeforeSpace = 150;
    FEngine->BeginPara();
    FEngine->TextOut("2.2.2. Tables");
    FEngine->EndPara();

    // Table of Contents Page
    FEngine->AddTOCItem("HTML Table of Contents Demo", -1, 1, 0);
    LI = FEngine->AddTOCItem("1. Introduction", -1, 2, 145);
    FEngine->AddTOCItem("1.1. What is eDocEngine?", LI, 2, 320);
    FEngine->AddTOCItem("1.2. System Requirements", LI, 2, 495);
    FEngine->AddTOCItem("1.3. Legal Notices", LI, 2, 670);
    LI = FEngine->AddTOCItem("2. Using eDocEngine", -1, 3, 145);
    FEngine->AddTOCItem("2.1. Starting eDocEngine", LI, 3, 320);
    LI = FEngine->AddTOCItem("2.2. Advanced Features", LI, 3, 495);
    FEngine->AddTOCItem("2.2.1. Paragraphs", LI, 3, 670);
    FEngine->AddTOCItem("2.2.2. Tables", LI, 4, 175);
    FEngine->AddTOCItem("www.gnostice.com", -1, "http://www.gnostice.com");

	  FEngine->EndDoc();
	}
  delete FEngine;
#endif
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
#ifdef gtPro
  SetControlsEnabled(GroupBox2, True);
#else
  SetControlsEnabled(GroupBox2, False);
#endif
}
//---------------------------------------------------------------------------

