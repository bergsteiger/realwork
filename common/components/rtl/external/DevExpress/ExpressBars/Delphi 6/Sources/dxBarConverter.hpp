// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dxBarConverter.pas' rev: 6.00

#ifndef dxBarConverterHPP
#define dxBarConverterHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <dxBar.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dxbarconverter
{
//-- type declarations -------------------------------------------------------
typedef IDesigner TCurDesigner;
;

class DELPHICLASS TdxBarConverter;
class PASCALIMPLEMENTATION TdxBarConverter : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Dxbar::TdxBarManager* FBarManager;
	bool FConverting;
	bool FExecute;
	Menus::TMenu* FMenu;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	void __fastcall Convert(Designintf::_di_IDesigner ADesigner);
	
__published:
	__property Dxbar::TdxBarManager* BarManager = {read=FBarManager, write=FBarManager};
	__property Menus::TMenu* Menu = {read=FMenu, write=FMenu};
	__property bool Execute = {read=FExecute, write=FExecute, nodefault};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TdxBarConverter(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TdxBarConverter(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Dxbarconverter */
using namespace Dxbarconverter;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// dxBarConverter
