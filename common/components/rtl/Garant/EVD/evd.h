#ifndef __COMPONENTS_RTL_GARANT_EVD_H__
#define __COMPONENTS_RTL_GARANT_EVD_H__

#include "shared/Core/sys/Exception.h"
#include "shared/Core/mng/Var.h"
#include "shared/GCI/IO/IO.h"

#include "common/components/rtl/Garant/EVD/evddata.h"
#include "common/components/rtl/Garant/EVD/Styles/Styles.h"
#include "common/components/rtl/Garant/EVD/Types/Types.h"

namespace evd {

typedef unsigned short TeeTagID;
typedef unsigned char  TeeTypeID;

const long eeInch           = 1440;
const long eeCmInch         = 254;
const long eeCharsPerLine   = 73;
const long eePaperWidth     = 10205;
const char binary_header [] = "%binary\x0D\x0A";

inline long cm2inch   (long a) { return (a * eeInch) / eeCmInch;             }
inline long char2inch (long a) { return (eePaperWidth * a) / eeCharsPerLine; }

typedef long (__stdcall *TeeWriter) (unsigned char* buf, long len, void* user_data);

// SAX-подобный интерфейс. EvdReader берет экземпл€р объекта, реализующего 
// этот интерфейс и по наступлению событий вызывает соотв. методы 
// на нем.  ћетод Start() дергаетс€ тем, кто этот фильтр создает. 
// EvdReader этот метод не вызывает.
class eeGenerator {
public:
	virtual void Start () = 0;
	virtual void StartChild (long type_id) = 0;
	virtual void Finish (bool is_need_undo = false) = 0;
	virtual void StartTag (long tag_id) = 0;
	virtual void StartDefaultChild () = 0;
	virtual void AddIntegerAtom (long tag_id, long value) = 0;
	virtual void AddStringAtom (long tag_id, const char* value, long len = -1, long code_page = 0) = 0;
	virtual void AddBoolAtom (long tag_id, bool value) = 0;
	virtual void AddMemAtom (long tag_id, const char* mem_buf, long len) = 0;
	virtual void AddStreamAtom (long tag_id, GCI::IO::Stream* stream) = 0;
	virtual void AddRawData (const char* mem_buf, long len) = 0;
	virtual void AddTransparentAtom (unsigned short index) = 0;
};

class IeeGenerator : virtual public eeGenerator, virtual public Core::IObject {
};

typedef Core::Var<IeeGenerator> IeeGenerator_var;

enum evdDecorations {
	evd_clDefault
	, evd_clBlack
	, evd_clMaroon
	, evd_clGreen
	, evd_clOlive
	, evd_clNavy
	, evd_clPurple
	, evd_clTeal
	, evd_clGray
	, evd_clSilver
	, evd_clRed
	, evd_clLime
	, evd_clYellow
	, evd_clBlue
	, evd_clFuchsia
	, evd_clAqua
	, evd_clLtGray
	, evd_clDkGray
	, evd_clWhite
	, evd_ffVerdana
	, evd_ffArial
	, evd_NumSymbols
};

} // namespace evd

#endif //__COMPONENTS_RTL_GARANT_EVD_H__

