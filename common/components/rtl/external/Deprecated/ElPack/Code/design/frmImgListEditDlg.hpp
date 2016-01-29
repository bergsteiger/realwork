// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frmImgListEditDlg.pas' rev: 6.00

#ifndef frmImgListEditDlgHPP
#define frmImgListEditDlgHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ElScrollBox.hpp>	// Pascal unit
#include <ElLabel.hpp>	// Pascal unit
#include <ElCLabel.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ElPopBtn.hpp>	// Pascal unit
#include <ElBtnCtl.hpp>	// Pascal unit
#include <ElXPThemedControl.hpp>	// Pascal unit
#include <ElCheckItemGrp.hpp>	// Pascal unit
#include <ElGroupBox.hpp>	// Pascal unit
#include <ElPanel.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frmimglisteditdlg
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TImageOperation { ioCrop, ioStretch, ioCenter, ioCenterStretch, ioCenterCrop, ioDivideIntoFragment };
#pragma option pop

typedef Set<TImageOperation, ioCrop, ioDivideIntoFragment>  TImageOperations;

class DELPHICLASS TFormImgListEditDlg;
class PASCALIMPLEMENTATION TFormImgListEditDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Elcheckitemgrp::TElRadioGroup* ElRadioGroup1;
	Elpanel::TElPanel* pBtns;
	Elpopbtn::TElPopupButton* OkButton;
	Elpopbtn::TElPopupButton* CancelButton;
	Ellabel::TElLabel* ElLabel1;
	Elscrollbox::TElScrollBox* ScrollBox;
	Extctrls::TImage* Image;
	Elpanel::TElPanel* ElPanel2;
	Ellabel::TElLabel* lbDestInfo;
	Ellabel::TElLabel* lbSrcInfo;
	Elpanel::TElPanel* ElPanel1;
	void __fastcall FormCreate(System::TObject* Sender);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TFormImgListEditDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormImgListEditDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormImgListEditDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TFormImgListEditDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _rsQuestion;
#define Frmimglisteditdlg_rsQuestion System::LoadResourceString(&Frmimglisteditdlg::_rsQuestion)
extern PACKAGE bool __fastcall GetProccesingImageOperation(const TImageOperations ImageOperations, Graphics::TGraphic* Graphic, int SrcWidth, int SrcHeight, int DestWidth, int DestHeight, TImageOperation &RetCode);

}	/* namespace Frmimglisteditdlg */
using namespace Frmimglisteditdlg;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// frmImgListEditDlg
