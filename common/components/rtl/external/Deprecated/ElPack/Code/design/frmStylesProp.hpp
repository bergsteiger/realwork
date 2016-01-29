// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frmStylesProp.pas' rev: 6.00

#ifndef frmStylesPropHPP
#define frmStylesPropHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ElBtnCtl.hpp>	// Pascal unit
#include <ElCheckItemGrp.hpp>	// Pascal unit
#include <ElPopBtn.hpp>	// Pascal unit
#include <ElXPThemedControl.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignConst.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <ElPanel.hpp>	// Pascal unit
#include <ElACtrls.hpp>	// Pascal unit
#include <ElCheckCtl.hpp>	// Pascal unit
#include <ElGroupBox.hpp>	// Pascal unit
#include <ElPgCtl.hpp>	// Pascal unit
#include <ElEdits.hpp>	// Pascal unit
#include <ElTree.hpp>	// Pascal unit
#include <ElDBConst.hpp>	// Pascal unit
#include <ElDBTree.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frmstylesprop
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TElStylesDefsProperty;
class PASCALIMPLEMENTATION TElStylesDefsProperty : public Designeditors::TClassProperty 
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TElStylesDefsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElStylesDefsProperty(void) { }
	#pragma option pop
	
};


class DELPHICLASS TStylesPropDlg;
class PASCALIMPLEMENTATION TStylesPropDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Elpgctl::TElPageControl* PageControl1;
	Elpgctl::TElTabSheet* TabSheet1;
	Elpgctl::TElTabSheet* TabSheet2;
	Elpanel::TElPanel* Panel1;
	Elpopbtn::TElPopupButton* OKBtn;
	Comctrls::TTabControl* ListStyle;
	Elpopbtn::TElPopupButton* Button1;
	Elgroupbox::TElGroupBox* Styles;
	Elcheckctl::TElCheckBox* StylesCB;
	Elcheckctl::TElCheckBox* ColorsCB;
	Elgroupbox::TElGroupBox* StylesGB;
	Elcheckctl::TElCheckBox* BoldCB;
	Elcheckctl::TElCheckBox* ItCB;
	Elcheckctl::TElCheckBox* ULCB;
	Elcheckctl::TElCheckBox* StrikeCB;
	Elgroupbox::TElGroupBox* ColorsGB;
	Stdctrls::TLabel* Label4;
	Stdctrls::TLabel* Label5;
	Stdctrls::TLabel* Label12;
	Elcheckctl::TElCheckBox* UseBkColorCB;
	Elactrls::TElAdvancedComboBox* ColorCombo;
	Elactrls::TElAdvancedComboBox* BkColorCombo;
	Elactrls::TElAdvancedComboBox* RowBkColorCombo;
	Elcheckctl::TElCheckBox* ShowChecksCB;
	Elgroupbox::TElGroupBox* CBGroup;
	Stdctrls::TLabel* Label7;
	Elcheckctl::TElCheckBox* CBEnabledCB;
	Elactrls::TElAdvancedComboBox* CheckBoxCB;
	Elgroupbox::TElGroupBox* Image1GB;
	Stdctrls::TLabel* Label10;
	Stdctrls::TLabel* Label11;
	Stdctrls::TLabel* Label24;
	Stdctrls::TLabel* Label25;
	Elactrls::TElAdvancedComboBox* ImageCB;
	Elactrls::TElAdvancedComboBox* StImageCB;
	Elactrls::TElAdvancedComboBox* Image2CB;
	Elactrls::TElAdvancedComboBox* StImage2CB;
	Elgroupbox::TElGroupBox* Image0GB;
	Stdctrls::TLabel* Label8;
	Stdctrls::TLabel* Label9;
	Stdctrls::TLabel* Label14;
	Stdctrls::TLabel* Label16;
	Eledits::TElEdit* IndexEdit;
	Eledits::TElEdit* Index2Edit;
	Eledits::TElEdit* StIndexEdit;
	Eledits::TElEdit* StIndex2Edit;
	Elcheckitemgrp::TElRadioGroup* ImagesGB;
	Elgroupbox::TElGroupBox* PatternGB;
	Stdctrls::TLabel* Label30;
	Elpopbtn::TElGraphicButton* SpeedButton1;
	Eledits::TElEdit* PatternE;
	Elactrls::TElAdvancedComboBox* PatternCB;
	Elcheckctl::TElCheckBox* UsePatternCB;
	Elgroupbox::TElGroupBox* Misc;
	Stdctrls::TLabel* Label15;
	Stdctrls::TLabel* Label32;
	Elcheckctl::TElCheckBox* EnabledCB;
	Elcheckctl::TElCheckBox* HiddenCB;
	Elcheckctl::TElCheckBox* HtmlCB;
	Elcheckctl::TElCheckBox* MultilineCB;
	Elcheckctl::TElCheckBox* HorZlineCB;
	Elcheckctl::TElCheckBox* AllowEditCB;
	Elcheckctl::TElCheckBox* ForcedBtnsCB;
	Elcheckctl::TElCheckBox* SuppressButtonsCB;
	Elcheckctl::TElCheckBox* SuppressLinesCB;
	Elcheckctl::TElCheckBox* IndentAdjustCB;
	Elcheckctl::TElCheckBox* OwnHeightCB;
	Elcheckctl::TElCheckBox* StrikeOutCB;
	Elgroupbox::TElGroupBox* Hints;
	Stdctrls::TLabel* Label26;
	Stdctrls::TLabel* Label27;
	Elcheckitemgrp::TElRadioGroup* HintRG;
	Eledits::TElEdit* HintED;
	Elcheckctl::TElCheckBox* HTMLCBL;
	Elactrls::TElAdvancedComboBox* HintCB;
	Eledits::TElEdit* CaptionE;
	Elcheckctl::TElCheckBox* CaptionCB;
	Elactrls::TElAdvancedComboBox* BorderStyleCombo;
	Elactrls::TElAdvancedComboBox* StrikeLineColorCB;
	Elgroupbox::TElGroupBox* Styles1;
	Elcheckctl::TElCheckBox* StylesCB1;
	Elcheckctl::TElCheckBox* ColorsCB1;
	Elgroupbox::TElGroupBox* StylesGB1;
	Elcheckctl::TElCheckBox* BoldCB1;
	Elcheckctl::TElCheckBox* ItCB1;
	Elcheckctl::TElCheckBox* ULCB1;
	Elcheckctl::TElCheckBox* StrikeCB1;
	Elgroupbox::TElGroupBox* ColorsGB1;
	Stdctrls::TLabel* Label20;
	Stdctrls::TLabel* Label21;
	Stdctrls::TLabel* Label22;
	Elcheckctl::TElCheckBox* UseBkColorCB1;
	Elactrls::TElAdvancedComboBox* ColorCombo1;
	Elactrls::TElAdvancedComboBox* BkColorCombo1;
	Elactrls::TElAdvancedComboBox* RowBkColorCombo1;
	Elcheckctl::TElCheckBox* ShowChecksCB1;
	Elgroupbox::TElGroupBox* CBGroup1;
	Stdctrls::TLabel* Label1;
	Elcheckctl::TElCheckBox* CBEnabledCB1;
	Elactrls::TElAdvancedComboBox* CheckBoxCB1;
	Elcheckitemgrp::TElRadioGroup* ImagesGB1;
	Elgroupbox::TElGroupBox* Image0GB1;
	Stdctrls::TLabel* Label2;
	Stdctrls::TLabel* Label3;
	Stdctrls::TLabel* Label6;
	Stdctrls::TLabel* Label13;
	Eledits::TElEdit* IndexEdit1;
	Eledits::TElEdit* Index2Edit1;
	Eledits::TElEdit* StIndexEdit1;
	Eledits::TElEdit* StIndex2Edit1;
	Elgroupbox::TElGroupBox* Image1GB1;
	Stdctrls::TLabel* Label17;
	Stdctrls::TLabel* Label18;
	Stdctrls::TLabel* Label19;
	Stdctrls::TLabel* Label23;
	Elactrls::TElAdvancedComboBox* ImageCB1;
	Elactrls::TElAdvancedComboBox* StImageCB1;
	Elactrls::TElAdvancedComboBox* Image2CB1;
	Elactrls::TElAdvancedComboBox* StImage2CB1;
	Elcheckctl::TElCheckBox* UsePatternCB1;
	Elgroupbox::TElGroupBox* PatternGB1;
	Stdctrls::TLabel* Label31;
	Elpopbtn::TElGraphicButton* SpeedButton2;
	Eledits::TElEdit* PatternE1;
	Elactrls::TElAdvancedComboBox* PatternCB1;
	Elgroupbox::TElGroupBox* Misc1;
	Stdctrls::TLabel* Label33;
	Elcheckctl::TElCheckBox* EnabledCB1;
	Elcheckctl::TElCheckBox* HiddenCB1;
	Elcheckctl::TElCheckBox* HtmlCB1;
	Elcheckctl::TElCheckBox* MultilineCB1;
	Elcheckctl::TElCheckBox* HorZlineCB1;
	Elcheckctl::TElCheckBox* AllowEditCB1;
	Elcheckctl::TElCheckBox* ForcedBtnsCB1;
	Elcheckctl::TElCheckBox* SuppressButtonsCB1;
	Elcheckctl::TElCheckBox* SuppressLinesCB1;
	Elcheckctl::TElCheckBox* IndentAdjustCB1;
	Elcheckctl::TElCheckBox* OwnHeightCB1;
	Elcheckctl::TElCheckBox* StrikeOutCB1;
	Elgroupbox::TElGroupBox* GroupBox1;
	Stdctrls::TLabel* Label28;
	Stdctrls::TLabel* Label29;
	Elcheckitemgrp::TElRadioGroup* HintRG1;
	Eledits::TElEdit* HintED1;
	Elcheckctl::TElCheckBox* HTMLCBL1;
	Elactrls::TElAdvancedComboBox* HintCB1;
	Elcheckctl::TElCheckBox* CaptionCB1;
	Eledits::TElEdit* CaptionE1;
	Elactrls::TElAdvancedComboBox* BorderStyleCombo1;
	Elactrls::TElAdvancedComboBox* StrikeLineColorCB1;
	Stdctrls::TLabel* Label34;
	Eledits::TElEdit* HeightEdit;
	Eledits::TElEdit* IndentEdit;
	Eledits::TElEdit* IndentEdit1;
	Eledits::TElEdit* HeightEdit1;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall OKBtnClick(System::TObject* Sender);
	void __fastcall StylesCB1Click(System::TObject* Sender);
	void __fastcall StylesCBClick(System::TObject* Sender);
	void __fastcall ColorsCBClick(System::TObject* Sender);
	void __fastcall ColorsCB1Click(System::TObject* Sender);
	void __fastcall ShowChecksCBClick(System::TObject* Sender);
	void __fastcall ShowChecksCB1Click(System::TObject* Sender);
	void __fastcall StrikeOutCBClick(System::TObject* Sender);
	void __fastcall StrikeOutCB1Click(System::TObject* Sender);
	void __fastcall OwnHeightCBClick(System::TObject* Sender);
	void __fastcall OwnHeightCB1Click(System::TObject* Sender);
	void __fastcall IndentAdjustCB1Click(System::TObject* Sender);
	void __fastcall IndentAdjustCBClick(System::TObject* Sender);
	void __fastcall ListStyleChange(System::TObject* Sender);
	void __fastcall ListStyleChanging(System::TObject* Sender, bool &AllowChange);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall ImagesGBClick(System::TObject* Sender);
	void __fastcall ImagesGB1Click(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall HintRGClick(System::TObject* Sender);
	void __fastcall HintRG1Click(System::TObject* Sender);
	void __fastcall UsePatternCBClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall UsePatternCB1Click(System::TObject* Sender);
	void __fastcall PageControl1ClosePageQuery(System::TObject* Sender, Elpgctl::TElTabSheet* Page, bool &CanClose);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
public:
	Classes::TComponent* AComp;
	Eldbtree::TElStylesDefs* DStylesDefs;
	Eldbtree::TElStylesDefsItem* DStylesDefsItem;
	void __fastcall SetData(int param);
	void __fastcall GetData(int param);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TStylesPropDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TStylesPropDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TStylesPropDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TStylesPropDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TStylesPropDlg* StylesPropDlg;

}	/* namespace Frmstylesprop */
using namespace Frmstylesprop;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// frmStylesProp
