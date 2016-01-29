////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/TemplatePainter_ContainerDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::TemplatePainter::ContainerDumper
//
// дампер представляющий собой контэйнер - список
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"
#include "boost/iterator/indirect_iterator.hpp"

class TemplatePainter;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TemplatePainter::ContainerDumper::ContainerDumper (const std::string& name)
//#UC START# *4B581B5001EB_BASE_INIT*
	: TextDumper (name.c_str ())
//#UC END# *4B581B5001EB_BASE_INIT*
{
	//#UC START# *4B581B5001EB_BODY*
	//#UC END# *4B581B5001EB_BODY*
}

TemplatePainter::ContainerDumper::ContainerDumper (const ContainerDumper& copy) 
//#UC START# *4B57F92B0325_COPY_CTOR_BASE_INIT*
	: TextDumper (copy.get_name_str ().c_str ()), m_items (copy.get_items ())
//#UC END# *4B57F92B0325_COPY_CTOR_BASE_INIT*
{
	//#UC START# *4B57F92B0325_COPY_CTOR*
	//#UC END# *4B57F92B0325_COPY_CTOR*
}

TemplatePainter::ContainerDumper::~ContainerDumper () {
	//#UC START# *4B57F92B0325_DESTR_BODY*
	//#UC END# *4B57F92B0325_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавляет элемент с в контэйнер
void TemplatePainter::ContainerDumper::add (const AbstractDumperBase* item) {
	//#UC START# *4B57FA30000D*
	GDS_ASSERT(item);

	//при добавлении в контейнер элемента на нем увеличивается счетчик ссылок
	item->addref ();
	m_items.push_back (item);
	//#UC END# *4B57FA30000D*
}

// добавляет все элементы из списка
void TemplatePainter::ContainerDumper::add (const AbstractDumperBase::VarList& items) {
	//#UC START# *4B5827EE038C*
	m_items.insert (m_items.end (), items.begin (), items.end ());
	//#UC END# *4B5827EE038C*
}

// очищает контэйнер
void TemplatePainter::ContainerDumper::clear () {
	//#UC START# *4B57FC400228*
	m_items.clear ();
	//#UC END# *4B57FC400228*
}

// возвращает количество элементов в списке
size_t TemplatePainter::ContainerDumper::count (const AbstractDumperBase* item) const {
	//#UC START# *4B57FC1F0184*
	GDS_ASSERT(item);

	return std::count_if (
		boost::make_indirect_iterator (m_items.begin ())
		, boost::make_indirect_iterator (m_items.end ())
		, boost::bind (
			std::equal_to<AbstractDumperBase> ()
			, _1
			, boost::cref(*item)
		)
	);
	//#UC END# *4B57FC1F0184*
}

// удалить элемент из контэйнера
void TemplatePainter::ContainerDumper::erase (const AbstractDumperBase* item) {
	//#UC START# *4B57FB450262*
	m_items.remove_if (
		boost::bind (AbstractDumperBase::IsEqual ()
			, boost::bind (
				static_cast<const AbstractDumperBase* (AbstractDumperBase::VarList::value_type::*) () const> (&AbstractDumperBase::VarList::value_type::ptr)
				, _1
			)
			, item
		)
	);
	//#UC END# *4B57FB450262*
}

// сравниваем содержимое двух контэйнеров
bool TemplatePainter::ContainerDumper::is_equal (const ContainerDumper* cont) const {
	//#UC START# *4B582F5303BB*
	return this == cont 
		|| (
			this->size () == cont->size ()
			&& std::equal (
				boost::make_indirect_iterator (get_items ().begin ())
				, boost::make_indirect_iterator (get_items ().end ())
				, boost::make_indirect_iterator (cont->get_items ().begin ())
				, boost::bind (
					std::equal_to<AbstractDumperBase> ()
					, _1
					, _2
				)
			)
		);
	//#UC END# *4B582F5303BB*
}

// удаляет элемент с конца списка
void TemplatePainter::ContainerDumper::pop_back () {
	//#UC START# *4B58352C0207*
	m_items.pop_back ();
	//#UC END# *4B58352C0207*
}

// удаляет элемент с начала списка
void TemplatePainter::ContainerDumper::pop_front () {
	//#UC START# *4B58351803A5*
	m_items.pop_front ();
	//#UC END# *4B58351803A5*
}

// размер списка
size_t TemplatePainter::ContainerDumper::size () const {
	//#UC START# *4B57FA1C00FF*
	return m_items.size ();
	//#UC END# *4B57FA1C00FF*
}

// удаляет содержимое контэйнера arg
void TemplatePainter::ContainerDumper::substract (const ContainerDumper* arg) {
	//#UC START# *4B60374103A8*
	if (!m_items.empty () && arg->size () > 0) {
		std::for_each (
			arg->get_items ().begin ()
			, arg->get_items ().end ()
			, boost::bind (
				&TemplatePainter::ContainerDumper::erase
				, this
				, boost::bind (
					static_cast<const AbstractDumperBase* (AbstractDumperBase::VarList::value_type::*) () const> (&AbstractDumperBase::VarList::value_type::ptr)
					, _1
				)
			)
		);
	}
	//#UC END# *4B60374103A8*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const AbstractDumperBase::VarList& TemplatePainter::ContainerDumper::get_items () const {
	//#UC START# *4B57FA0C034B_GET_ACCESSOR*
	return m_items;
	//#UC END# *4B57FA0C034B_GET_ACCESSOR*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// массив всех вложенных элементов (рекурсивно)
AbstractDumperBase::ADList* TemplatePainter::ContainerDumper::get_all_contents () const {
	//#UC START# *4666369E01D4_4B57F92B0325*
	class local {
	public:
		static void get_all_contents_impl (
			const TemplatePainter::ContainerDumper* container
			, std::set<const TemplatePainter::ContainerDumper*> visited_containers
			, AbstractDumperBase::ADList& all_contents
		) {
			visited_containers.insert (container);
			for (
				AbstractDumperBase::VarList::const_iterator it = container->get_items().begin ()
				; it != container->get_items().end ()
				; ++it
			) {
				all_contents.insert (all_contents.begin (), it->ptr ());
				const TemplatePainter::ContainerDumper* it_cont = dynamic_cast<const TemplatePainter::ContainerDumper*> (it->ptr ());
				if (it_cont) {
					//проверяем что не входим в цикл
					if (
						visited_containers.find (it_cont) == visited_containers.end ()						
					) {						
						get_all_contents_impl (it_cont, visited_containers, all_contents);
					} else {
						break;
					}
				} else {
					Core::Aptr<AbstractDumperBase::ADList> all ((*it)->get_all_contents ());
					if (!all.is_nil ()) {
						all_contents.insert (all_contents.end (), all->begin (), all->end ());
					}
				}				
			}
		}
	};
	
	Core::Aptr<AbstractDumperBase::ADList> ret (new AbstractDumperBase::ADList ());
	std::set<const TemplatePainter::ContainerDumper*> visited_containers;

	local::get_all_contents_impl (this, visited_containers, *ret);
	return ret.forget ();
	//#UC END# *4666369E01D4_4B57F92B0325*
}

// overloaded method from AbstractDumperBase
// массив вложенных элементов
AbstractDumperBase::ADList* TemplatePainter::ContainerDumper::get_contents () const {
	//#UC START# *4666367C01D4_4B57F92B0325*
	Core::Aptr<AbstractDumperBase::ADList> contents = new AbstractDumperBase::ADList ();

	std::transform (
		m_items.begin ()
		, m_items.end ()
		, std::back_inserter(*contents.ptr ())
		, boost::bind (
			static_cast<const AbstractDumperBase* (AbstractDumperBase::VarList::value_type::*) () const> (&AbstractDumperBase::VarList::value_type::ptr)
			, _1
		)
	);

	return contents.forget ();
	//#UC END# *4666367C01D4_4B57F92B0325*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

