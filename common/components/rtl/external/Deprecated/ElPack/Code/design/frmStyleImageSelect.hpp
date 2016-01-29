// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frmStyleImageSelect.pas' rev: 6.00

#ifndef frmStyleImageSelectHPP
#define frmStyleImageSelectHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ExtDlgs.hpp>	// Pascal unit
#include <ElEdits.hpp>	// Pascal unit
#include <ElCheckCtl.hpp>	// Pascal unit
#include <ElGroupBox.hpp>	// Pascal unit
#include <ElScrollBox.hpp>	// Pascal unit
#include <ElPanel.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ElPopBtn.hpp>	// Pascal unit
#include <ElBtnCtl.hpp>	// Pascal unit
#include <ElXPThemedControl.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
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

namespace Frmstyleimageselect
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TImageType { itBitmap, itIcon };
#pragma option pop

class DELPHICLASS TStyleImageSelectForm;
class PASCALIMPLEMENTATION TStyleImageSelectForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Elpanel::TElPanel* Panel1;
	Elpopbtn::TElPopupButton* OkButton;
	Elpopbtn::TElPopupButton* CancelButton;
	Elpanel::TElPanel* ElPanel1;
	Elscrollbox::TElScrollBox* ScrollBox;
	Extctrls::TImage* Image;
	Elpopbtn::TElPopupButton* btnLoad;
	Elpopbtn::TElPopupButton* btnSave;
	Elpopbtn::TElPopupButton* btnClear;
	Elpopbtn::TElPopupButton* btnPaste;
	Elpopbtn::TElPopupButton* btnCopy;
	Dialogs::TSaveDialog* SD;
	Elpopbtn::TElPopupButton* btnMono;
	void __fastcall ImageListSelClick(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall btnPasteClick(System::TObject* Sender);
	void __fastcall btnLoadClick(System::TObject* Sender);
	void __fastcall btnSaveClick(System::TObject* Sender);
	void __fastcall btnCopyClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnMonoClick(System::TObject* Sender);
	
private:
	Dialogs::TOpenDialog* fOD;
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Msg);
	void __fastcall CheckEnabledPaste(void);
	void __fastcall CheckEnabledCopy(void);
	
public:
	bool __fastcall isImage(void);
	void __fastcall SaveToStream(Classes::TStream* S, TImageType Format);
	void __fastcall LoadFromStream(Classes::TStream* S, TImageType Format);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TStyleImageSelectForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TStyleImageSelectForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TStyleImageSelectForm(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TStyleImageSelectForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


#pragma pack(push, 1)
struct TCursorOrIcon
{
	Word Reserved;
	Word wType;
	Word Count;
} ;
#pragma pack(pop)

struct TIconRec;
typedef TIconRec *PIconRec;

#pragma pack(push, 1)
struct TIconRec
{
	Byte Width;
	Byte Height;
	Word Colors;
	Word Reserved1;
	Word Reserved2;
	int DIBSize;
	int DIBOffset;
} ;
#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TStyleImageSelectForm* StyleImageSelectForm;
extern PACKAGE System::ResourceString _rsBitmapInvalid;
#define Frmstyleimageselect_rsBitmapInvalid System::LoadResourceString(&Frmstyleimageselect::_rsBitmapInvalid)
static const Shortint rc3_StockIcon = 0x0;
static const Shortint rc3_Icon = 0x1;
static const Shortint rc3_Cursor = 0x2;

}	/* namespace Frmstyleimageselect */
using namespace Frmstyleimageselect;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// frmStyleImageSelect
