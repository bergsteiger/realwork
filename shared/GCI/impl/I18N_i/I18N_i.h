////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/I18N_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::GCI::I18N_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_H__
#define __SHARED_GCI_I18N_I_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCI/I18N/I18N.h"


namespace GCI {
namespace I18N_i {

// порядок следования байтов в числе
enum EndianType {
	ET_BIG_ENDIAN // порядок следования байтов big endian
	, ET_LITTLE_ENDIAN // порядок следования байтов little endian
};

// буфер символов
typedef std::vector < char > CharBuffer;

} //namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

