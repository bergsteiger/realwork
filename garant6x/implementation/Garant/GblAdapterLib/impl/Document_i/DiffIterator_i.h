////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffIterator_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DiffIterator_i
// Заголовок реализации класса серванта для интерфеса DiffIterator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DIFFITERATOR_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DIFFITERATOR_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"

//#UC START# *4B4EE41D0386_CUSTOM_INCLUDES*
//#UC END# *4B4EE41D0386_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class DiffIterator_i; // self forward Var
typedef ::Core::Var<DiffIterator_i> DiffIterator_i_var;
typedef ::Core::Var<const DiffIterator_i> DiffIterator_i_cvar;

class DiffIterator_i_factory;

class DiffIterator_i:
	virtual public DiffIterator
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DiffIterator_i)
	friend class DiffIterator_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DiffIterator_i (const GblPilot::DiffData& diff_data);

	virtual ~DiffIterator_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DiffIterator
	virtual ParaNum acquire_next () const;

	// implemented method from DiffIterator
	virtual ParaNum acquire_prev () const;

	// implemented method from DiffIterator
	virtual bool has_next () const;

	// implemented method from DiffIterator
	virtual bool has_prev () const;

	// implemented method from DiffIterator
	virtual void move_to (ParaNum para) /*throw (CanNotFindData)*/;

	// implemented method from DiffIterator
	virtual ParaNum next () /*throw (CanNotFindData)*/;

	// implemented method from DiffIterator
	virtual ParaNum prev () /*throw (CanNotFindData)*/;

//#UC START# *4B4EE41D0386*
public:
  struct Item {
		Item (): id (0), cur_para_num (-1), prev_para_num (-1) {
		}
		unsigned long id;
		long cur_para_num;
		long prev_para_num;
	};

private:
	std::map<unsigned long, long> m_cur_para_index;
	std::map<unsigned long, long> m_prev_para_index;
	std::vector <Item> m_list;
	size_t m_pos;
//#UC END# *4B4EE41D0386*
}; // class DiffIterator_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DIFFITERATOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
