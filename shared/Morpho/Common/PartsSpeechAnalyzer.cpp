////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/Common/PartsSpeechAnalyzer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Morpho::Common::PartsSpeechAnalyzer
//
// Анализатор частей речи
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Morpho/Common/PartsSpeechAnalyzer.h"
// by <<uses>> dependencies
#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/split.hpp"

//#UC START# *4D306C4201BA_CUSTOM_INCLUDES*
#include <set>
//#UC END# *4D306C4201BA_CUSTOM_INCLUDES*

namespace Morpho {

//#UC START# *4D306C4201BA*
template <typename T>
static void print_vect (const std::vector <T>& in) {
	std::cout << std::endl;
	std::copy (in.begin (), in.end (), std::ostream_iterator <T> (std::cout, " "));
	std::cout << std::endl;
}
//#UC END# *4D306C4201BA*

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// позиции рамочной связи, соответствующей определенному шаблону
DBCore::ULongVector* PartsSpeechAnalyzer::get_positions (const DBCore::PSDTemplates& in, const std::string& req) {
	//#UC START# *4D306FB200BC*
	Core::Aptr <DBCore::ULongVector> ret = new DBCore::ULongVector ();

	DBCore::PSDTemplates data;
	PartsSpeechAnalyzer::get_templates (req, data);

	DBCore::Bytes::const_iterator f_it;
	DBCore::PSDTemplates::const_iterator _it;

	for (DBCore::PSDTemplates::const_iterator it = data.begin (); it != data.end (); ++it) {
		f_it = it->begin ();

		for (_it = in.begin (); _it != in.end ();) {
			f_it = std::search (f_it, it->end (), _it->begin (), _it->end ());

			if (f_it != it->end ()) {
				unsigned long pos = f_it - it->begin ();

				for (size_t i = 1; i < _it->size (); ++i) {
					ret->push_back (++pos); // записываем найденные позиции
				}

				++f_it;
				continue; // ищем следующее вхождение
			}

			++_it;
			f_it = it->begin ();
		}
	}

	std::sort (ret->begin (), ret->end ());
	ret->erase (std::unique (ret->begin (), ret->end ()), ret->end ());

	//print_vect <unsigned long> (*ret);

	return ret._retn ();
	//#UC END# *4D306FB200BC*
}

// генерация частиречных представлений запроса
void PartsSpeechAnalyzer::get_templates (const std::string& req, DBCore::PSDTemplates& out) {
	//#UC START# *4D352089034F*
	std::vector <std::string> context;
	boost::split (context, req, boost::is_punct () || boost::is_space ());

	DBCore::Bytes tmp (1, 0);

	typedef std::set <unsigned char> Parts;

	Parts parts;

	for (std::vector <std::string>::iterator it = context.begin (); it != context.end (); ++it) {
		if (*(it->rbegin ()) == '!') {
			it->erase (it->size () - 1);
		}

		//PartsSpeechAnalyzer::get_parts_of_speech (*it, parts);

		if (out.empty ()) {
			for (Parts::const_iterator _it = parts.begin (); _it != parts.end (); ++_it) {
				tmp [0] = *_it;
				out.push_back (tmp);
			}
		} else if (parts.size () > 1) {
			DBCore::PSDTemplates data;
			data.reserve (out.size () * parts.size ());

			for (DBCore::PSDTemplates::const_iterator _it = out.begin (); _it != out.end (); ++_it) {
				for (Parts::const_iterator __it = parts.begin (); __it != parts.end (); ++__it) {
					data.push_back (*_it);
					data.back ().push_back (*__it);
				}
			}

			out = data;
		} else {
			unsigned char item = *(parts.begin ());

			for (DBCore::PSDTemplates::iterator _it = out.begin (); _it != out.end (); ++_it) {
				_it->push_back (item);
			}
		}

		parts.clear ();
	}

#ifdef _DEBUG
	/*
	std::cout << std::endl;

	for (DBCore::PSDTemplates::const_iterator it = out.begin (); it != out.end (); ++it) {
		std::copy (it->begin (), it->end (), std::ostream_iterator <short> (std::cout, " "));
		std::cout << std::endl;
	}
	std::cout << std::endl;
	*/
#endif
	//#UC END# *4D352089034F*
}

// установить рамочные связи между словами
void PartsSpeechAnalyzer::set_frames (const DBCore::PSDTemplates& in, std::string& req) {
	//#UC START# *4D385636016F*
	if (in.empty () == false) {
		Core::Aptr <DBCore::ULongVector> frames = PartsSpeechAnalyzer::get_positions (in, req);

		if (frames->empty () == false) {
			size_t pos = 0;

			for (std::string::iterator it = req.begin (); it != req.end (); ) {
				it = std::find_if (it, req.end (), boost::is_any_of (" +-~"));

				if (it != req.end ()) {
					++pos;

					if (*it == ' ') {
						if (std::binary_search (frames->begin (), frames->end (), pos)) {
							*it = '~';
						}
					}

					++it;
				}
			}
		}
	}
	//#UC END# *4D385636016F*
}

} // namespace Morpho

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

