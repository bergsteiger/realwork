// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'gtQRXportIntf.pas' rev: 25.00 (Windows)

#ifndef GtqrxportintfHPP
#define GtqrxportintfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <QRPrntr.hpp>	// Pascal unit
#include <QuickRpt.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <QRPrgres.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <gtCstDocEng.hpp>	// Pascal unit
#include <gtXportIntf.hpp>	// Pascal unit
#include <Vcl.Printers.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtqrxportintf
{
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TgtQRExportFilterClass;

class DELPHICLASS TgtQRXport_Base;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRXport_Base : public Qrprntr::TQRExportFilter
{
	typedef Qrprntr::TQRExportFilter inherited;
	
private:
	Gtcstdoceng::TgtCustomDocumentEngine* FLocalEngine;
	
protected:
	Gtcstdoceng::TgtCustomDocumentEngine* FEngine;
	Vcl::Graphics::TMetafile* FMetafile;
	virtual System::UnicodeString __fastcall GetExtension(void);
	virtual System::UnicodeString __fastcall GetFilterName(void);
	
public:
	virtual void __fastcall Finish(void);
	__fastcall virtual ~TgtQRXport_Base(void);
	virtual void __fastcall AfterConstruction(void);
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRXport_Base(System::UnicodeString Filename) : Qrprntr::TQRExportFilter(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRPDFXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRPDFXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRPDFXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRPDFXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRRTFXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRRTFXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRRTFXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRRTFXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRHTMLXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRHTMLXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRHTMLXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRHTMLXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRXHTMLXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRXHTMLXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRXHTMLXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRXHTMLXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRTextXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRTextXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRTextXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRTextXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRExcelXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRExcelXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRExcelXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRExcelXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRQuattroProXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRQuattroProXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRQuattroProXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRQuattroProXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRSYLKXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRSYLKXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRSYLKXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRSYLKXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRDIFXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRDIFXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRDIFXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRDIFXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRLotusXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRLotusXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRLotusXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRLotusXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRBMPXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRBMPXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRBMPXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRBMPXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRJPEGXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRJPEGXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRJPEGXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRJPEGXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRGIFXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRGIFXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRGIFXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRGIFXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQREMFXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQREMFXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQREMFXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQREMFXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRWMFXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRWMFXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRWMFXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRWMFXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRClipboardXport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TgtQRClipboardXport : public TgtQRXport_Base
{
	typedef TgtQRXport_Base inherited;
	
public:
	virtual void __fastcall AfterConstruction(void);
public:
	/* TgtQRXport_Base.Destroy */ inline __fastcall virtual ~TgtQRClipboardXport(void) { }
	
public:
	/* TQRExportFilter.Create */ inline __fastcall virtual TgtQRClipboardXport(System::UnicodeString Filename) : TgtQRXport_Base(Filename) { }
	
};

#pragma pack(pop)

class DELPHICLASS TgtQRExportInterface;
class PASCALIMPLEMENTATION TgtQRExportInterface : public Gtxportintf::TgtExportInterface
{
	typedef Gtxportintf::TgtExportInterface inherited;
	
private:
	bool FShowProgress;
	Qrprgres::TQRProgressForm* FProgress;
	bool __fastcall IsFilterNotInList(void);
	void __fastcall RemoveFilterClass(void);
	void __fastcall AddFilterClass(void);
	void __fastcall SetFilterObject(void);
	void __fastcall RemoveFilterObject(void);
	HIDESBASE void __fastcall SetEngine(Gtcstdoceng::TgtCustomDocumentEngine* const Value);
	HIDESBASE void __fastcall SetVisible(const bool Value);
	void __fastcall ExportQR(Qrprntr::TQRPrinter* QRPrinter);
	void __fastcall InitProgress(Qrprntr::TQRPrinter* AQRPrinter);
	void __fastcall EndProgress(Qrprntr::TQRPrinter* AQRPrinter);
	void __fastcall SetShowProgress(const bool Value);
	
protected:
	TgtQRExportFilterClass FFilterClass;
	
public:
	__fastcall virtual TgtQRExportInterface(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TgtQRExportInterface(void);
	void __fastcall RenderDocument(Quickrpt::TQuickRep* AReport, bool AlreadyPrepared)/* overload */;
	void __fastcall RenderDocument(Quickrpt::TQRCompositeReport* ACompositeReport, bool AlreadyPrepared)/* overload */;
	void __fastcall RenderDocument(System::Classes::TList* AQuickRepList, bool AlreadyPrepared)/* overload */;
	void __fastcall RenderDocument(System::UnicodeString AQRPFile)/* overload */;
	
__published:
	__property Engine = {write=SetEngine};
	__property Visible = {write=SetVisible, default=1};
	__property bool ShowProgress = {read=FShowProgress, write=SetShowProgress, default=1};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Gtqrxportintf */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_GTQRXPORTINTF)
using namespace Gtqrxportintf;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtqrxportintfHPP
