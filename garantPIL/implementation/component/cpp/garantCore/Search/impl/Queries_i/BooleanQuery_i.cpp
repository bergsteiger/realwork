////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Queries_i/BooleanQuery_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Queries_i::BooleanQuery_i
//
// Реализация комбинирующего запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Queries_i/BooleanQuery_i.h"
// by <<uses>> dependencies
#include "boost/algorithm/string/trim.hpp"

namespace Search {
namespace Queries_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

BooleanQuery_i::BooleanQuery_i ()
//#UC START# *509D3C870314_BASE_INIT*
	: m_count (0)
//#UC END# *509D3C870314_BASE_INIT*
{
	//#UC START# *509D3C870314_BODY*
	//#UC END# *509D3C870314_BODY*
}

BooleanQuery_i::BooleanQuery_i (const std::string& str)
//#UC START# *55B8CB660082_BASE_INIT*
	: m_count (0)
	, m_data (str)
//#UC END# *55B8CB660082_BASE_INIT*
{
	//#UC START# *55B8CB660082_BODY*
	size_t count = 0;

	for (std::string::const_iterator it = m_data.begin (); it != m_data.end (); ++it) {
		if (*it == '(') {
			++count;
		} else if (*it == ')') {
			--count;

			if (count == 0) {
				++m_count;
			}
		}
	}
	//#UC END# *55B8CB660082_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IBooleanQuery
// добавить запрос
void BooleanQuery_i::add (IQuery* query, MergeOp op) {
	//#UC START# *509CFCDC002B_509D3C3203DB*
	GDS_ASSERT (query);

	++m_count;

	if (m_data.empty () == false) {
		m_data += ' ';
	}

	if (query->get_type () == BOOL_TYPE) {
		IBooleanQuery* _query = dynamic_cast <IBooleanQuery*> (query);

		GDS_ASSERT (_query);

		size_t count = _query->get_count ();

		if (count == 0) {
			return;
		} else if (count == 1) {
			std::string str = _query->get_data ();

			boost::trim (str);

			if (str [0] != so_AND && str [0] != so_OR && str [0] != so_NOT) {
				str.insert (0, "  ");
			}

			if (str [0] != so_NOT) {
				str [0] = op;     // A op1 (op2 B) == A op1 (B) == A op1 B
			} else if (op == so_NOT) {
				str [0] = so_AND; // A ~ (~B) == A & B
			} else if (op != so_AND) {
				GDS_ASSERT (0);   // A & (~B) == A ~ B ; A | (~B) == ?
			}

			m_data += str;
			return;
		}
	}

	m_data += op;
	m_data += ' ' + query->get_type () + '(' + query->get_data () + ')';
	//#UC END# *509CFCDC002B_509D3C3203DB*
}

// implemented method from IBooleanQuery
// количество запросов
size_t BooleanQuery_i::get_count () const {
	//#UC START# *5167FD020040_509D3C3203DB*
	return m_count;
	//#UC END# *5167FD020040_509D3C3203DB*
}

// implemented method from IQuery
// данные
const std::string& BooleanQuery_i::get_data () const {
	//#UC START# *50D4894A0101_509D3C3203DB*
	return m_data;
	//#UC END# *50D4894A0101_509D3C3203DB*
}

// implemented method from IQuery
// тип
const std::string& BooleanQuery_i::get_type () const {
	//#UC START# *50A4D98F0266_509D3C3203DB*
	return BOOL_TYPE;
	//#UC END# *50A4D98F0266_509D3C3203DB*
}
} // namespace Queries_i
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

