//
// DivisionInfo.h : header file
//

#ifndef __DIVISION_INFO_H__
#define __DIVISION_INFO_H__

#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"
#include "garantPIL/implementation/component/cpp/libs/endt/EndtWriter.h"

#include <map>

namespace EndtConvertor {

	struct DivisionInfoEx {
		char m_symbol;
		std::string m_params;

		DivisionInfoEx (char symbol, const char* params) {
			m_symbol = symbol;

			if (params) {
				m_params = params;
			}
		}
	};

	typedef std::map <long, DivisionInfoEx> DivisionData;

	class DivisionInfos {
	public:
		DivisionInfos (Base* base, long doc_id);

	public:
		const DivisionData& get_data () const {
			return m_data;
		}

	private:
		DivisionData m_data;
	};

	class DivisionInfoGenerator {
	public:
		static void generate (
			evd::IeeGenerator* generator
			, EndtTools::EndtWriter& writer
			, const DivisionInfoEx& info
		);

		static void generate_section_break (evd::IeeGenerator* generator, const DivisionInfoEx& info);
	};

} // namespace

#endif // #ifndef __DIVISION_INFO_H__
