////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/WildCard_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::WildCard_i
//
// Имплементация IWildCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/impl/DBComm_i/WildCard_i.h"

namespace SearchAdapterLib {
namespace DBComm_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

WildCard_i::WildCard_i (
	DBCore::IBase* base
	, const std::string& src
	, size_t max_size
	, Morpho::Def::INormalizer* normalizer
)
//#UC START# *5540D0C90283_BASE_INIT*
	: m_src (src)
	, m_max_size (max_size) 
//#UC END# *5540D0C90283_BASE_INIT*
{
	//#UC START# *5540D0C90283_BODY*
	m_base = DBCore::IBase::_duplicate (base);
	m_normalizer = Morpho::Def::INormalizer::_duplicate (normalizer);
	//#UC END# *5540D0C90283_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContextSearch::DBComm::IWildCard
// получить множество удовлетворяющее шаблону
GCL::StrSet* WildCard_i::get (const std::string& in) {
	//#UC START# *5540CDDD01F2_5540CF29039B*
	Core::Aptr <GCL::StrSet> ret = new GCL::StrSet ();

	DBCore::IIndex_var index = m_base->make (m_src.c_str ());

	if (index->is_valid ()) {
		std::string word = in.substr (0, in.size () - 1);

		char buf [64];

		DBCore::IBTreeIterator_var it = index->make_iterator ();

		bool is_context_str = (m_src == "Context.str");

		if (is_context_str) {
			std::string key = std::string (1, 0xc0 + word.size ()) + word;
			it->Set (key.c_str ());
		} else {
			it->Set (word.c_str ());
		}

		for (; !it->End (); it->next ()) {
			const char* k = (const char*) it->Key ();

			if (ACE_OS::memcmp ((is_context_str)? k + 1 : k, word.c_str (), word.size ()) != 0) {
				break;
			}

			DBCore::Store* str = index->open_stream (k, 0);

			if (str) {
				long len = str->Length ();

				str->Read (buf, len);
				buf [len] = 0;

				index->close_stream (str);

				const char* norm_buf = buf + sizeof (long);

				Core::Aptr <GCL::StrSet> res;

				if (norm_buf [0] & 0x80) {
					ret->insert (norm_buf + 1); // нулевой байт игнорируем
				} else {
					Core::Aptr <GCL::StrSet> res = m_normalizer->execute ((is_context_str)? k + 1: k, false);
					ret->insert (res->begin (), res->end ());
				}
			}
		}
	}

	GCL::StrSet::iterator it = ret->begin ();
	std::advance (it, std::min <size_t> (ret->size (), m_max_size));
	ret->erase (it, ret->end ());

	return ret._retn ();
	//#UC END# *5540CDDD01F2_5540CF29039B*
}
} // namespace DBComm_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

