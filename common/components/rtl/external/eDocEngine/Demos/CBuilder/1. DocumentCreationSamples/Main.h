//---------------------------------------------------------------------------

#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <DB.hpp>
#include <DBCtrls.hpp>
#include <DBGrids.hpp>
#include <DBTables.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
#include <Grids.hpp>
#include <jpeg.hpp>
#include "gtClasses3.hpp"
#include "gtCstDocEng.hpp"
#include "gtCstHTMLEng.hpp"
#include "gtCstPDFEng.hpp"
#include "gtCstPlnEng.hpp"
#include "gtExHTMLEng.hpp"
#include "gtExPDFEng.hpp"
#include "gtHTMLEng.hpp"
#include "gtPDFEng.hpp"
#include <Db.hpp>
#include <Buttons.hpp>

// DISABLE THE SWITCH IF YOU ARE USING THE STANDARD EDITION OF eDocEngine
#define gtPro

//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TImage *Image1;
        TImage *Image2;
        TImage *Image3;
        TCheckBox *CheckBox1;
        TCheckBox *CheckBox2;
        TDBImage *DBImage1;
        TDBGrid *DBGrid1;
        TDataSource *DataSource1;
        TTable *Table1;
        TFloatField *Table1SpeciesNo;
        TStringField *Table1Category;
        TStringField *Table1Common_Name;
        TStringField *Table1SpeciesName;
        TFloatField *Table1Lengthcm;
        TFloatField *Table1Length_In;
        TMemoField *Table1Notes;
        TGraphicField *Table1Graphic;
        TGroupBox *GroupBox1;
        TImage *Image10;
        TLabel *Label8;
        TLabel *Label4;
        TImage *Image6;
        TLabel *Label9;
        TImage *Image11;
        TLabel *Label7;
        TImage *Image9;
        TLabel *Label3;
        TImage *Image5;
        TLabel *Label5;
        TImage *Image7;
        TImage *Image8;
        TLabel *Label6;
        TImage *Image4;
        TLabel *Label2;
        TSpeedButton *SpeedButton4;
        TSpeedButton *Button1;
        TSpeedButton *Button5;
        TSpeedButton *Button3;
        TSpeedButton *Button8;
        TSpeedButton *Button9;
        TSpeedButton *Button2;
        TSpeedButton *Button6;
        TSpeedButton *Button7;
        TGroupBox *GroupBox2;
        TLabel *Label14;
        TImage *Image14;
        TLabel *Label13;
        TImage *Image13;
        TSpeedButton *Button11;
        TSpeedButton *Button10;
        TSpeedButton *Button4;
        TImage *Image12;
        TLabel *Label12;
        void __fastcall Button1Click(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall Button5Click(TObject *Sender);
	void __fastcall Button6Click(TObject *Sender);
	void __fastcall Button3Click(TObject *Sender);
	void __fastcall Button7Click(TObject *Sender);
	void __fastcall Button8Click(TObject *Sender);
	void __fastcall Button9Click(TObject *Sender);
	void __fastcall Button4Click(TObject *Sender);
	void __fastcall Button11Click(TObject *Sender);
	void __fastcall Button10Click(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
