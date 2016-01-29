////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MMapComImpl/LargeMemoryImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCI::MMapComImpl::LargeMemoryImpl
//
// реализация фасета "большой Памяти"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/MMapComImpl/LargeMemoryImpl.h"

#if defined(WIN32)
namespace GCI {
namespace MMapComImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// Конструктор с параметром PoolListHandler
LargeMemoryImpl::LargeMemoryImpl (
	const MMap::FileForMem* file
	, PoolListHandler* pool_list_handler
	, size_t page_size
	, size_t granularity
	, bool regulary_segmentation
)
//#UC START# *49DC9103019F_BASE_INIT*
: m_pool_list_handler(Core::IObject::_duplicate(pool_list_handler))
  , m_page_size(page_size)
  , m_file(Core::IObject::_duplicate(file))
  , m_granularity(granularity) 
  , m_regulary_segmentation(regulary_segmentation)
//#UC END# *49DC9103019F_BASE_INIT*
{
	//#UC START# *49DC9103019F_BODY*
	//#UC END# *49DC9103019F_BODY*
}

LargeMemoryImpl::~LargeMemoryImpl () {
	//#UC START# *497719E00316_DESTR_BODY*
	//#UC END# *497719E00316_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MMap::LargeMemory
// соотвествующий данной логической памяти ммап-файл
const MMap::FileForMem& LargeMemoryImpl::get_map_file () const {
	//#UC START# *49748DA1003E_497719E00316_GET*
	return *m_file;
	//#UC END# *49748DA1003E_497719E00316_GET*
}

MMap::FileForMem& LargeMemoryImpl::get_map_file () {
	return const_cast<MMap::FileForMem&>(((const LargeMemoryImpl*)this)->get_map_file ());
}

// implemented method from MMap::LargeMemory
// Логический кусок памяти, соотвествующий указанному смещению (указанное смещение гарантированно
// находится внутри него). В out параметре возвращает смещение от начала логического куска
// (Memeory::base_addr) до заданного.
const MMap::Memory* LargeMemoryImpl::get_memory (MMap::LongSize offset, size_t& inside_offset) const {
	//#UC START# *497F0613001E_497719E00316_GET*
	GCI::MMap::LongSize granulary_offset = offset - offset % m_granularity;
	size_t granulary_page_size = m_page_size;
	if(granulary_page_size % m_granularity != 0) {
		granulary_page_size = granulary_page_size - granulary_page_size % m_granularity + m_granularity;
	}

	if (m_regulary_segmentation) {
		granulary_offset = offset - offset % granulary_page_size;
	} else {
		granulary_offset = offset - offset % m_granularity;
	}

	GCI::MMap::Memory_cvar memory = m_pool_list_handler->get_memory(offset, m_file->get_file_handle());

	if(memory.is_nil()) {
		size_t memory_offset;
		memory = m_file->get_memory(granulary_offset, granulary_page_size, memory_offset);
		m_pool_list_handler->set_memory(const_cast<GCI::MMap::Memory*>(memory.in()));
	}
	inside_offset = (size_t)(offset - memory->get_file_offset());
	return memory._retn();
	//#UC END# *497F0613001E_497719E00316_GET*
}

MMap::Memory* LargeMemoryImpl::get_memory (MMap::LongSize offset, size_t& inside_offset) {
	return const_cast<MMap::Memory*>(((const LargeMemoryImpl*)this)->get_memory (offset, inside_offset));
}

// implemented method from MMap::LargeMemory
// Фискированный размер страницы соотвествующий этой логической памяти
const size_t LargeMemoryImpl::get_page_size () const {
	//#UC START# *49748DCE013B_497719E00316_GET*
	return m_page_size;
	//#UC END# *49748DCE013B_497719E00316_GET*
}

// implemented method from MMap::LargeMemory
// Системная область файла, недоступная через метод get_memory()
const MMap::Memory* LargeMemoryImpl::get_system_memory () const {
	//#UC START# *4A1A872D0386_497719E00316_GET*
	if(m_system_memory.is_nil()) {
		size_t inside_offset;
		GCI::MMap::LongSize system_size = m_file->get_memory_offset();
		const_cast<GCI::MMap::FileForMem*>(m_file.ptr())->set_memory_offset(0);
		m_system_memory = m_file->get_memory(0, (size_t)system_size, inside_offset);
		const_cast<GCI::MMap::FileForMem*>(m_file.ptr())->set_memory_offset(system_size);
	}
	return m_system_memory._sretn();
	//#UC END# *4A1A872D0386_497719E00316_GET*
}

MMap::Memory* LargeMemoryImpl::get_system_memory () {
	return const_cast<MMap::Memory*>(((const LargeMemoryImpl*)this)->get_system_memory ());
}
} // namespace MMapComImpl
} // namespace GCI

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

