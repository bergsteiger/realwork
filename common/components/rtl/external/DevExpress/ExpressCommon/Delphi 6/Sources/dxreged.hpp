// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxreged.pas' rev: 6.00

#ifndef dxregedHPP
#define dxregedHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ImgList.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
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

namespace Dxreged
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmdxLibREgPathEditor;
class PASCALIMPLEMENTATION TfrmdxLibREgPathEditor : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* Panel;
	Comctrls::TTreeView* TreeView;
	Stdctrls::TButton* bOk;
	Stdctrls::TButton* bCancel;
	Stdctrls::TButton* bNew;
	Controls::TImageList* ImageList;
	Stdctrls::TLabel* lbRegistry;
	Stdctrls::TButton* bDelete;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall TreeViewChange(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall bNewClick(System::TObject* Sender);
	void __fastcall TreeViewGetImageIndex(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall TreeViewGetSelectedIndex(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall TreeViewExpanded(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall TreeViewCollapsed(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall bDeleteClick(System::TObject* Sender);
	
private:
	Registry::TRegistry* reg;
	AnsiString __fastcall GetFullText(Comctrls::TTreeNode* Node);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TWMGetMinMaxInfo &Message);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfrmdxLibREgPathEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmdxLibREgPathEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmdxLibREgPathEditor(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfrmdxLibREgPathEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall dxGetRegistryPath(AnsiString &APath);

}	/* namespace Dxreged */
using namespace Dxreged;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxreged
