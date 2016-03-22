////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/impl/Impl/CacheTxt_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::CacheTxt_i
//
// Реализация кэша словарей с загрузкой словарей из текстовых файлов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_IMPL_CACHETXT_I_H__
#define __SHARED_MORPHO_IMPL_CACHETXT_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Morpho/Def/Def.h"

namespace Morpho {
namespace Impl {

// Реализация кэша словарей с загрузкой словарей из текстовых файлов
class CacheTxt_i;
typedef Core::Var<CacheTxt_i> CacheTxt_i_var;
typedef Core::Var<const CacheTxt_i> CacheTxt_i_cvar;

class CacheTxt_i :
	virtual public Def::ICache
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CacheTxt_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// конструктор
	explicit CacheTxt_i (const std::string& path);

public:
	virtual ~CacheTxt_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// загрузка списка строк
	void load (const char* name, GCL::StrVector& out);

	// загрузка постфиксов
	void load_postfixes (const char* name);

	// загрузка данных для псевдоморфологии
	void load_pseudo (const char* name);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Box<Def::CacheData> m_data;

	Core::Mutex m_mutex;

	std::string m_path;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Def::ICache
	// очистить кэш
	virtual void clear ();

	// implemented method from Def::ICache
	// исключаемые
	virtual const Def::Exclude& get_exclude () const;

	// implemented method from Def::ICache
	// вектор опечаток и их исправлений
	virtual const Def::FixedPairs& get_fixed_pairs () const;

	// implemented method from Def::ICache
	// данные для морфоанализа
	virtual const Def::MorphoData& get_morpho_data () const;

	// implemented method from Def::ICache
	// ненормализуемые
	virtual const GCL::StrVector& get_not_normalized () const;

	// implemented method from Def::ICache
	// вектор синонимичных пар
	virtual const Def::FixedPairs& get_syn_pairs () const;

	// implemented method from Def::ICache
	// загрузка
	virtual void load (DBCore::IBase* base);
}; // class CacheTxt_i

} // namespace Impl
} // namespace Morpho


#endif //__SHARED_MORPHO_IMPL_CACHETXT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

