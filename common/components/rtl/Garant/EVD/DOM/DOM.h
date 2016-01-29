////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/rtl/Garant/EVD/DOM/DOM.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::EVD::DOM
//
// Объектная модель документа EVD
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_DELPHI_EVD_DOM_H__
#define __SHARED_DELPHI_EVD_DOM_H__

#include "shared/Core/sys/std_inc.h"
#include "common/components/rtl/Garant/EVD/Types/Types.h"

namespace EVD {
namespace DOM {

// Размер бумаги
enum PaperSize {
	ps_Custom
	, ps_A0 // 84   x 118.8
	, ps_A1 // 59.4 x 84
	, ps_A2 // 42   x 59.4
	, ps_A3 // 29.7 x 42
	, ps_A4 // 21   x 29.7
	, ps_A5 // 14.8 x 21
};

class Section;
typedef ::Core::Var<Section> Section_var;
typedef ::Core::Var<const Section> Section_cvar;
// Свойства раздела документа
class Section
	: virtual public ::Core::IObject
{
public:
	// Ориентация страницы
	virtual const PageOrientation get_Orientation () const = 0;

	virtual void set_Orientation (PageOrientation Orientation) = 0;

	// Размер бумаги
	virtual const PaperSize get_PaperSize () const = 0;

	virtual void set_PaperSize (PaperSize PaperSize) = 0;
};

// Язык
enum Language {
	lg_Russian // Русский
	, lg_English // Английский
	, lg_German // Немецкий
	, lg_French // Французский
	, lg_Italian // Итальянский
	, lg_Spanish // Испанский
};

class DictEntry;
typedef ::Core::Var<DictEntry> DictEntry_var;
typedef ::Core::Var<const DictEntry> DictEntry_cvar;
// Вхождение толкового словаря
class DictEntry
	: virtual public ::Core::IObject
{
public:
	// Короткие имена
	virtual  get_ShortName (Language aLang) const = 0;

	virtual void set_ShortName ( ShortName, Language aLang) = 0;
};

} // namespace DOM
} // namespace EVD


#endif //__SHARED_DELPHI_EVD_DOM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
