#ifndef _SHARED_ADAPTERS_DEFAULT_STYLE_TABLE_H_
#define _SHARED_ADAPTERS_DEFAULT_STYLE_TABLE_H_

#include <string>

#include "ace/Singleton.h"
#include "shared/Core/sys/synch.h"

namespace Adapters {
	
class DSTable {
public:
	void set (const std::string& style_table);
	const std::string& get () const;

private:
	std::string m_style_table;
};

typedef ACE_Singleton<DSTable, ACE_SYNCH_MUTEX> DefaultStyleTable;

} // namespace Adapters

#endif // _SHARED_ADAPTERS_DEFAULT_STYLE_TABLE_H_
