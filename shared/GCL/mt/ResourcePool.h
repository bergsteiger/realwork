////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/mt/ResourcePool.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::mt::ResourcePool
//
// управляет конкурентным доступом к ограниченному набору ресурсов произвольного типа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_MT_RESOURCEPOOL_H__
#define __SHARED_GCL_MT_RESOURCEPOOL_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *45028FEA035B_USER_INCLUDES*
#include "ace/Atomic_Op.h"
#include <map>
//#UC END# *45028FEA035B_USER_INCLUDES*

namespace GCL {

//#UC START# *45028FEA035B_USER_DEFINITION*
namespace ResourcePoolPolicy {
	enum Select {
		sp_inert,
		sp_routine
	};

	enum Acquire {
		ap_occupy,
		//ap_addition, // need to correct RWMutex release
		ap_waiting
	};
} // namespace ResourcePoolPolicy

template <class _Resource, class _Selector, class _Allocator>
class ResourcePool {
public:
	ResourcePool ( 
		_Allocator& allocator
		, ResourcePoolPolicy::Acquire acquire_policy = ResourcePoolPolicy::ap_occupy
		, ResourcePoolPolicy::Select select_policy = ResourcePoolPolicy::sp_inert
	);

	~ResourcePool ();

	// блокирует и возвращает ресурс
	inline _Resource acquire (_Selector selector);

	// освобождает ресурс (снимает лок)
	inline void release (_Resource resource);

	// получает через аллокатор новый ресурс и добавляет его в пул присваивая
	// указанный селектор
	void add_resources (_Selector selector, unsigned long count = 1);

	// вызывает для каждого ресурса деструктор в аллокаторе и очищает пул
	void clear ();
	inline size_t length () const;
protected:
	struct ResourceInfo {
		//селектор
		_Selector selector;

		//индекс активноси
		unsigned long activity;

		// мютекс
		Core::Mutex lock;

		// длинна очереди за ресурсом
		ACE_Atomic_Op <ACE_SYNCH_MUTEX, long> query_length;

		/* ресурс */
		_Resource resource;

		ResourceInfo () :
			activity (0)
			, query_length (0)
			, resource (0) {
		}

		ResourceInfo (const ResourceInfo  &resource_info) :
			selector (resource_info.selector)
			, activity (resource_info.activity)
			, query_length (resource_info.query_length)
			, resource (resource_info.resource) {
		}
	};

	typedef std::map <_Resource, ResourceInfo> ResourceInfoMap;

	ResourceInfoMap m_resource_info_map;

	_Allocator& m_allocator;

	ResourcePoolPolicy::Acquire m_acquire_policy;
	ResourcePoolPolicy::Select m_select_policy;
protected:
	Core::RWMutex m_update_mutex;

	// выбирает из списка свободный ресурс с указанным селектором и
	// увеличивает его индекс активности,  или возвращает указатель на конец
	inline typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator select_available (_Selector selector); // GARANT_TYPENAME

	// исчет в цикле все свободные (не залоченные) базы, и выбирает из них
	// базу с наименьшим индексом активности
	typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator acquire_available (_Selector selector); // GARANT_TYPENAME
};
//#UC END# *45028FEA035B_USER_DEFINITION*

} // namespace GCL

#include "shared/GCL/mt/ResourcePool.i.h"

#endif //__SHARED_GCL_MT_RESOURCEPOOL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
