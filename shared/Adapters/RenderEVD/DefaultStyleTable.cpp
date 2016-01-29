#include "shared/Adapters/RenderEVD/DefaultStyleTable.h"
#include "shared/Core/sys/assert.h"

namespace Adapters {
	
void DSTable::set (const std::string& style_table) {
	m_style_table = style_table;
}

const std::string& DSTable::get () const {
	GDS_ASSERT (!m_style_table.empty ());
	return m_style_table;
}

}
