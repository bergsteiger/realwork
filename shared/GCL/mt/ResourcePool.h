////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCL/mt/ResourcePool.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::mt::ResourcePool
//
// ��������� ������������ �������� � ������������� ������ �������� ������������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

	// ��������� � ���������� ������
	inline _Resource acquire (_Selector selector);

	// ����������� ������ (������� ���)
	inline void release (_Resource resource);

	// �������� ����� ��������� ����� ������ � ��������� ��� � ��� ����������
	// ��������� ��������
	void add_resources (_Selector selector, unsigned long count = 1);

	// �������� ��� ������� ������� ���������� � ���������� � ������� ���
	void clear ();
	inline size_t length () const;
protected:
	struct ResourceInfo {
		//��������
		_Selector selector;

		//������ ���������
		unsigned long activity;

		// ������
		Core::Mutex lock;

		// ������ ������� �� ��������
		ACE_Atomic_Op <ACE_SYNCH_MUTEX, long> query_length;

		/* ������ */
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

	// �������� �� ������ ��������� ������ � ��������� ���������� �
	// ����������� ��� ������ ����������,  ��� ���������� ��������� �� �����
	inline typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator select_available (_Selector selector); // GARANT_TYPENAME

	// ����� � ����� ��� ��������� (�� ����������) ����, � �������� �� ���
	// ���� � ���������� �������� ����������
	typename ResourcePool <_Resource,_Selector,_Allocator>::ResourceInfoMap::iterator acquire_available (_Selector selector); // GARANT_TYPENAME
};
//#UC END# *45028FEA035B_USER_DEFINITION*

} // namespace GCL

#include "shared/GCL/mt/ResourcePool.i.h"

#endif //__SHARED_GCL_MT_RESOURCEPOOL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
