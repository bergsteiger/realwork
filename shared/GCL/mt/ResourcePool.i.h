////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/mt/ResourcePool.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::mt::ResourcePool
// Файл inline реализации утилитного набора ResourcePool
//
// управляет конкурентным доступом к ограниченному набору ресурсов произвольного типа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//#UC START# *45028FEA035B_CUSTOM_INCLUDES*
//#UC END# *45028FEA035B_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *45028FEA035B*
template <class _Resource, class _Selector, class _Allocator>
ResourcePool <_Resource,_Selector,_Allocator>::ResourcePool (
	_Allocator& allocator
	, ResourcePoolPolicy::Acquire acquire_policy
	, ResourcePoolPolicy::Select select_policy
) : m_allocator (allocator), m_acquire_policy (acquire_policy), m_select_policy (select_policy) {
	if (m_update_mutex.acquire_write () == -1) {
		throw;
	}
}

template <class _Resource, class _Selector, class _Allocator>
ResourcePool <_Resource,_Selector,_Allocator>::~ResourcePool () {
	try {
		this->clear ();
		m_update_mutex.release ();
	} catch (...) {
	}
}

template <class _Resource, class _Selector, class _Allocator>
inline 
size_t ResourcePool <_Resource,_Selector,_Allocator>::length () const {
	return m_resource_info_map.size ();
}

template <class _Resource, class _Selector, class _Allocator>
inline 
_Resource ResourcePool <_Resource,_Selector,_Allocator>::acquire (_Selector selector) {
	//LOG_D (("ResourcePool::acquire->acquire_read"));
	if (m_update_mutex.acquire_read () == -1) {
		return 0;
	}

	// find available resource
	typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator it = select_available (selector); // GARANT_TYPENAME
	if (it == m_resource_info_map.end ()) {
		it = acquire_available (selector);
	}
	return (*it).first;
}

template <class _Resource, class _Selector, class _Allocator>
inline 
void ResourcePool <_Resource,_Selector,_Allocator>::release(_Resource resource) {
	typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator it = m_resource_info_map.find (resource); // GARANT_TYPENAME
	assert (it != m_resource_info_map.end ());
	
	(*it).second.lock.release ();
	m_update_mutex.release ();
}

template <class _Resource, class _Selector, class _Allocator>
void ResourcePool <_Resource,_Selector,_Allocator>::add_resources (_Selector selector, unsigned long count) {
	for (unsigned long i = 0; i < count; ++i) {
		ResourceInfo info;
		info.selector = selector;
		info.resource = m_allocator.new_resource ();

		if (!info.resource) {
			ACE_DEBUG ((LM_ERROR, "Failed to get new resource\n"));			
			return;
		}

		typedef typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::value_type ThisInfoMapvalue_type;
		m_resource_info_map.insert (ThisInfoMapvalue_type (info.resource, info)); // GARANT_TYPENAME
	}

	m_update_mutex.release ();
}

template <class _Resource, class _Selector, class _Allocator>
void ResourcePool <_Resource,_Selector,_Allocator>::clear () {
	if (m_resource_info_map.empty ()) {
		return;
	}

	if (m_update_mutex.acquire_write () == -1) {
		throw;
	}

	for (typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator it = m_resource_info_map.begin (); it != m_resource_info_map.end (); ++it) { // GARANT_TYPENAME
		m_allocator.free_resource ((*it).second.resource);
	}

	m_resource_info_map.clear ();
}

template <class _Resource, class _Selector, class _Allocator>
inline 
typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator // GARANT_TYPENAME
ResourcePool <_Resource,_Selector,_Allocator>::select_available (_Selector selector) {
	for (typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator it = m_resource_info_map.begin (); it != m_resource_info_map.end (); ++it) { // GARANT_TYPENAME
		if ((*it).second.selector == selector ) {
			if ((*it).second.lock.tryacquire () != -1) {
				++(*it).second.activity;
				return it;
			}
		}
	}

	return m_resource_info_map.end ();
}

template <class _Resource, class _Selector, class _Allocator>
typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator // GARANT_TYPENAME
ResourcePool <_Resource,_Selector,_Allocator>::acquire_available (_Selector selector) {	
	typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator it;
	typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator minit = m_resource_info_map.end ();

	while (!m_resource_info_map.size ()) {
		ACE_OS::sleep (ACE_Time_Value (0, 2500)); // 0.0025 second
		continue;  //wait for adding base
	}

	while (true) {
		for (it = m_resource_info_map.begin (); it != m_resource_info_map.end (); ++it) {
			if ((*it).second.lock.tryacquire () != -1) {
				if (minit != m_resource_info_map.end ()) { // has previose min value
					if ((*minit).second.activity > (*it).second.activity) { // we find less active!
						(*minit).second.lock.release ();
						minit = it;
					} else {
						(*it).second.lock.release ();
					}
				} else { //first available
					minit = it;			
					if (m_select_policy != ResourcePoolPolicy::sp_inert) break;
				}
			} 
		}

		if (minit != m_resource_info_map.end ()) { // one cycle processed and find available - exit
			if ((*minit).second.selector != selector) {
				(*minit).second.selector = selector;
				(*minit).second.activity = 1;
			}
			return minit;
		} 

		if (m_acquire_policy == ResourcePoolPolicy::ap_waiting) {
			ACE_OS::sleep (ACE_Time_Value (0, 2500)); // 0.0025 second
			continue;
		}

		//if (m_acquire_policy == ap_addition) {
		//	add (selector); // need to correct RWMutex release
		//	continue;
		//}

		for (it = m_resource_info_map.begin (); it != m_resource_info_map.end (); ++it) {
			if (minit != m_resource_info_map.end ()) { // has previose min value
				if (m_select_policy != ResourcePoolPolicy::sp_inert) {
					if ((*minit).second.query_length.value () > (*it).second.query_length.value ()) {
						minit = it;
					}
				} else {
					if (
						((*minit).second.query_length.value () > (*it).second.query_length.value ())
						|| (
							((*minit).second.query_length.value () == (*it).second.query_length.value ())
							&& ((*minit).second.activity > (*it).second.activity)
						)
					) { 
						// we find less active!
						minit = it;
					} 
				}
			} else {
				//first locked
				minit = it;					
			}
		}		
		
		++(*minit).second.query_length;
		(*minit).second.lock.acquire ();
		--(*minit).second.query_length;
		
		if ((*minit).second.selector != selector) {
			(*minit).second.selector = selector;
			(*minit).second.activity = 1;
		}

		return minit; // GARANT_ISOSTL
	}
}

//#UC END# *45028FEA035B*

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

