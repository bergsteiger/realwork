////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/PosContainer_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::PosContainer_i
//
// Имплементация IPosContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_POSCONTAINER_I_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_POSCONTAINER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"

namespace ContextSearch {

// Имплементация IPosContainer
class PosContainer_i;
typedef Core::Var<PosContainer_i> PosContainer_i_var;
typedef Core::Var<const PosContainer_i> PosContainer_i_cvar;

class PosContainer_i :
	virtual public DBCore::IPosContainer
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PosContainer_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	PosContainer_i (size_t max_fragment, size_t sz);

public:
	virtual ~PosContainer_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// проверка
	bool check (unsigned long pos);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBCore::ContextPositions m_data;

	bool m_has_block;

	size_t m_max_fragment;

	const DBCore::ULongVector* m_min;

	size_t m_pos;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DBCore::IPosContainer
	// добавить
	virtual bool add (unsigned long val);

	// implemented method from DBCore::IPosContainer
	// добавить
	virtual bool add (unsigned long pos, unsigned long flags);

	// implemented method from DBCore::IPosContainer
	// данные
	virtual const DBCore::ContextPositions& get () const;

	// implemented method from DBCore::IPosContainer
	// имеет блочную позицию
	virtual bool has_block () const;

	// implemented method from DBCore::IPosContainer
	// ссылка на текущий элемент
	virtual const DBCore::ULongVector& ref () const;

	// implemented method from DBCore::IPosContainer
	// очистить
	virtual void reset ();

	// implemented method from DBCore::IPosContainer
	// настроится на элемент
	virtual void set (size_t pos);

	// implemented method from DBCore::IPosContainer
	// указываем на вектор с минимальным набором вхождений
	virtual void set_min (const DBCore::ULongVector& in);
}; // class PosContainer_i

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_POSCONTAINER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

