// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtrvxportintf.pas' rev: 11.00

#ifndef GtrvxportintfHPP
#define GtrvxportintfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Rprender.hpp>	// Pascal unit
#include <Rpdefine.hpp>	// Pascal unit
#include <Rpsystem.hpp>	// Pascal unit
#include <Rprave.hpp>	// Pascal unit
#include <Gtconsts3.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtxportintf.hpp>	// Pascal unit
#include <Gtutils3.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtrvxportintf
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TgtEncodeGraphicEvent)(System::TObject* AObject, bool &UniqueImage, int &ReuseImageIndex);

typedef void __fastcall (__closure *TgtEncodeGraphicDoneEvent)(System::TObject* AObject, int ObjectImageIndex);

class DELPHICLASS TgtRaveXport;
class PASCALIMPLEMENTATION TgtRaveXport : public Rprender::TRPRenderStream 
{
	typedef Rprender::TRPRenderStream inherited;
	
private:
	System::TObject* FParent;
	Gtcstdoceng::TgtCustomDocumentEngine* FEngine;
	double __fastcall CalcYDisp(int FontSize, float LineHeight, bool Superscript);
	void __fastcall GetgtPoints(Rprender::TFloatPoint * APointArray, const int APointArray_Size, Gtcstdoceng::TgtPoints &AgtPoints);
	void __fastcall SetEngine(const Gtcstdoceng::TgtCustomDocumentEngine* Value);
	
protected:
	virtual void __fastcall DocBegin(void);
	virtual void __fastcall DocEnd(void);
	virtual void __fastcall PageBegin(void);
	virtual void __fastcall Arc(const double X1, const double Y1, const double X2, const double Y2, const double X3, const double Y3, const double X4, const double Y4);
	virtual void __fastcall Chord(const double X1, const double Y1, const double X2, const double Y2, const double X3, const double Y3, const double X4, const double Y4);
	virtual void __fastcall Ellipse(const double X1, const double Y1, const double X2, const double Y2);
	virtual void __fastcall LineTo(const double X1, const double Y1);
	virtual void __fastcall MoveTo(const double X1, const double Y1);
	virtual void __fastcall PolyLine(Rprender::TFloatPoint const * PolyLineArr, const int PolyLineArr_Size);
	virtual void __fastcall Polygon(Rprender::TFloatPoint const * PolyLineArr, const int PolyLineArr_Size);
	virtual void __fastcall Rectangle(const double X1, const double Y1, const double X2, const double Y2);
	virtual void __fastcall FillRect(const Types::TRect &ARect);
	virtual void __fastcall RoundRect(const double X1, const double Y1, const double X2, const double Y2, const double X3, const double Y3);
	virtual void __fastcall Pie(const double X1, const double Y1, const double X2, const double Y2, const double X3, const double Y3, const double X4, const double Y4);
	virtual void __fastcall Draw(const double X1, const double Y1, Graphics::TGraphic* AGraphic);
	virtual void __fastcall PrintBitmapRect(const double X1, const double Y1, const double X2, const double Y2, Graphics::TBitmap* AGraphic);
	virtual void __fastcall PrintBitmap(const double X1, const double Y1, const double ScaleX, const double ScaleY, Graphics::TBitmap* AGraphic);
	virtual void __fastcall StretchDraw(const Types::TRect &ARect, Graphics::TGraphic* AGraphic);
	virtual void __fastcall PrintRightWidth(double &X1, double &Y1, AnsiString Text, double Width);
	virtual void __fastcall PrintSpaces(const AnsiString AText, const double X1, const double Y1, const double AWidth);
	virtual void __fastcall TextRect(const Types::TRect &Rect, double X1, double Y1, AnsiString S1);
	virtual void __fastcall CenterText(const AnsiString AText, const double X1, const double Y1);
	virtual void __fastcall LeftText(const AnsiString AText, const double X1, const double Y1);
	virtual void __fastcall RightText(const AnsiString AText, const double X1, const double Y1);
	__property Gtcstdoceng::TgtCustomDocumentEngine* Engine = {read=FEngine, write=SetEngine};
	
public:
	__fastcall virtual TgtRaveXport(Classes::TComponent* AOwner)/* overload */;
	__fastcall TgtRaveXport(Classes::TComponent* AOwner, Gtcstdoceng::TgtCustomDocumentEngine* AEngine)/* overload */;
	__fastcall virtual ~TgtRaveXport(void);
};


class DELPHICLASS TgtRaveExportInterface;
class PASCALIMPLEMENTATION TgtRaveExportInterface : public Gtxportintf::TgtExportInterface 
{
	typedef Gtxportintf::TgtExportInterface inherited;
	
private:
	TgtRaveXport* FRaveXport;
	TgtEncodeGraphicEvent FEncodeGraphic;
	TgtEncodeGraphicDoneEvent FEncodeGraphicDone;
	void __fastcall ExecuteReport(Rpdefine::TRpComponent* ARPComponent, AnsiString AFileName, bool AShowPrepareStatus);
	HIDESBASE void __fastcall SetEngine(const Gtcstdoceng::TgtCustomDocumentEngine* Value);
	HIDESBASE void __fastcall SetVisible(const bool Value);
	TgtEncodeGraphicEvent __fastcall GetEncodeGraphic();
	TgtEncodeGraphicDoneEvent __fastcall GetOnEncodeGraphicDone();
	void __fastcall SetOnEncodeGraphic(const TgtEncodeGraphicEvent Value);
	void __fastcall SetOnEncodeGraphicDone(const TgtEncodeGraphicDoneEvent Value);
	Classes::TStream* __fastcall GetUserStream(void);
	void __fastcall SetUserStream(Classes::TStream* Value);
	
public:
	__fastcall virtual TgtRaveExportInterface(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtRaveExportInterface(void);
	void __fastcall RenderDocument(Classes::TStream* ANDRStream)/* overload */;
	void __fastcall RenderDocument(AnsiString ANDRFileName)/* overload */;
	void __fastcall RenderDocument(Rpdefine::TRpComponent* ARPComponent, bool AShowPrepareStatus)/* overload */;
	__property Classes::TStream* UserStream = {read=GetUserStream, write=SetUserStream};
	
__published:
	__property Engine  = {write=SetEngine};
	__property Visible  = {write=SetVisible, default=1};
	__property TgtEncodeGraphicEvent OnEncodeGraphic = {read=GetEncodeGraphic, write=SetOnEncodeGraphic};
	__property TgtEncodeGraphicDoneEvent OnEncodeGraphicDone = {read=GetOnEncodeGraphicDone, write=SetOnEncodeGraphicDone};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TgtEncodeGraphicEvent EncodeGraphic;
extern PACKAGE TgtEncodeGraphicDoneEvent EncodeGraphicDone;
extern PACKAGE bool MetafileAsRaster;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gtrvxportintf */
using namespace Gtrvxportintf;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtrvxportintf
