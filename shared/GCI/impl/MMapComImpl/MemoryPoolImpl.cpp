////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapComImpl/MemoryPoolImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MMapComImpl::MemoryPoolImpl
//
// Реализация пула.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/MMapComImpl/MemoryPoolImpl.h"
// by <<uses>> dependencies
#include "shared/GCI/impl/MMapComImpl/LargeMemoryImpl.h"
#include "shared/GCI/MMap/MMap.h"
#include <list>

#if defined(WIN32)
namespace GCI {
namespace MMapComImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MemoryPoolImpl::MemoryPoolImpl ()
//#UC START# *49747D620277_49747DB30310_49771A0202DB_BASE_INIT*
: m_max_pool_size(GCI::MMap::DEFAULT_MAX_POOL_SIZE)
  , m_current_pool_size(0) 
//#UC END# *49747D620277_49747DB30310_49771A0202DB_BASE_INIT*
{
	//#UC START# *49747D620277_49747DB30310_49771A0202DB_BODY*
	#if defined(WIN32) && defined(_WIN32_WINNT) && (_WIN32_WINNT >= 0x0500)
	SYSTEM_INFO sinf;
	GetSystemInfo(&sinf); 
	m_granularity = sinf.dwAllocationGranularity; 
	#endif //WIN32 && _WIN32_WINNT>=0x0500
	//#UC END# *49747D620277_49747DB30310_49771A0202DB_BODY*
}

MemoryPoolImpl::~MemoryPoolImpl () {
	//#UC START# *49771A0202DB_DESTR_BODY*
	//#UC END# *49771A0202DB_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const MemoryList& MemoryPoolImpl::get_memory_list () const {
	//#UC START# *49DC6B0201A2_GET_ACCESSOR*
	GUARD(m_pool_mutex);
	return m_memory_list;
	//#UC END# *49DC6B0201A2_GET_ACCESSOR*
}

void MemoryPoolImpl::set_memory_list (const MemoryList& memory_list) const {
	//#UC START# *49DC6B0201A2_SET_ACCESSOR*
	GUARD(m_pool_mutex);
	m_memory_list = memory_list;
	//#UC END# *49DC6B0201A2_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MMap::MemoryPool
// персонифицированный участок памяти, связанный с указанным указанный ммап-файлом. Этот файл будет
// добавлен в пул, доступ к нему будет "разбит" на страницы указанного размера. Если размер = 0
// (или меньше пороговой величины), то берется размер по умолчанию. При попытке переразбить ранее
// добавленный файл - исключение.
const MMap::LargeMemory* MemoryPoolImpl::get_large_memory (const MMap::FileForMem* file, size_t page_size, bool regulary_segmentation) const {
	//#UC START# *497F03AF0277_49771A0202DB_GET*
	GCI::MMap::FileForMem_cvar file_for_mem = Core::IObject::_duplicate(file);

	std::list < MMap::Memory_var >::iterator it;
	{
		GUARD(m_pool_mutex);
		size_t len = m_memory_list.size(); 
		for(size_t i=0; i<len; i++) {
			if(m_memory_list[i]->get_file_name() == file_for_mem->get_file_name()) {
				throw Core::Root::InvalidParams();
			}
		}
	}

	if (page_size < m_granularity) {
		throw Core::Root::InvalidParams();
	}

	GCI::MMap::LargeMemory_cvar large_memory = new GCI::MMapComImpl::LargeMemoryImpl(
		file_for_mem.in()
		, const_cast<MemoryPoolImpl*>(this)
		, page_size, m_granularity
		, regulary_segmentation
	);
	return large_memory._retn();
	//#UC END# *497F03AF0277_49771A0202DB_GET*
}

MMap::LargeMemory* MemoryPoolImpl::get_large_memory (MMap::FileForMem* file, size_t page_size, bool regulary_segmentation) {
	//#UC START# *497F03AF0277_49771A0202DB_GET_NC*
	return const_cast<MMap::LargeMemory*>(((const MemoryPoolImpl*)this)->get_large_memory (file, page_size, regulary_segmentation));
	//#UC END# *497F03AF0277_49771A0202DB_GET_NC*
}

// implemented method from MMap::MemoryPool
// Максимальный размер пула - максимальный размер виртуальной памяти,
// который может быть использован для маппинга всех файлов.
const size_t MemoryPoolImpl::get_pool_size () const {
	//#UC START# *49DD9EF40216_49771A0202DB_GET*
	GUARD(m_pool_mutex);
	return m_max_pool_size;
	//#UC END# *49DD9EF40216_49771A0202DB_GET*
}

void MemoryPoolImpl::set_pool_size (size_t pool_size) {
	//#UC START# *49DD9EF40216_49771A0202DB_SET*
	GUARD(m_pool_mutex);
	m_max_pool_size = pool_size;
	//#UC END# *49DD9EF40216_49771A0202DB_SET*
}

// implemented method from PoolListHandler
// Возвращает смапленный кусок памяти из списка по заданному
// смещению в файле - offset.
MMap::Memory* MemoryPoolImpl::get_memory (MMap::LongSize offset, HANDLE file_handle) const {
	//#UC START# *49DCBC9203B1_49771A0202DB*
	GUARD(m_pool_mutex);
	size_t len = m_memory_list.size();
	for(size_t i=len; i>0; i--) {
		if	( offset >= m_memory_list[i-1]->get_file_offset() && 
			  offset < m_memory_list[i-1]->get_file_offset() + m_memory_list[i-1]->get_view_size() &&
		 	  m_memory_list[i-1]->get_file_handle() == file_handle ) {
			if(i != len) {
				m_memory_list.push_back(MMap::Memory_var(m_memory_list[i-1]));
				m_memory_list.erase(m_memory_list.begin() + i - 1);
			}
			return m_memory_list.back()._sretn();
		}
	}

	return NULL;
	//#UC END# *49DCBC9203B1_49771A0202DB*
}

// implemented method from PoolListHandler
// Добавляем заданный кусок памяти в список
void MemoryPoolImpl::set_memory (MMap::Memory* memory) {
	//#UC START# *49DCBC3D02F7_49771A0202DB*
	GUARD(m_pool_mutex);
	while (m_current_pool_size + memory->get_view_size() > m_max_pool_size) {
		size_t best_memory_index = 0;
		size_t min_ref_count = m_memory_list[best_memory_index]->ref_count ();
		size_t len = m_memory_list.size ();
		for (size_t i = 0; i < len; i++) {
			if(m_memory_list[i]->ref_count() == 1) {
				best_memory_index = i;
				break;
			}
			if(m_memory_list[i]->ref_count() < min_ref_count) {
				min_ref_count = m_memory_list[i]->ref_count();
				best_memory_index = i;
			}
		}
		m_current_pool_size -= m_memory_list[best_memory_index]->get_view_size();
		m_memory_list.erase(m_memory_list.begin() + best_memory_index);
	}

	m_memory_list.push_back(GCI::MMap::Memory_var(Core::IObject::_duplicate(memory)));
	m_current_pool_size += memory->get_view_size();
	//#UC END# *49DCBC3D02F7_49771A0202DB*
}
} // namespace MMapComImpl
} // namespace GCI

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

