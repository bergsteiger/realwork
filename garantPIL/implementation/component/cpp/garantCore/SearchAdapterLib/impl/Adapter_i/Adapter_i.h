////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/Adapter_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garantCore::SearchAdapterLib::Adapter_i::Adapter_i
// ��������� ���������� ������ �������� ��� ��������� IAdapter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_ADAPTER_I_H__
#define __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_ADAPTER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"

namespace SearchAdapterLib {
namespace Adapter_i {

class Adapter_i; // self forward Var
typedef ::Core::Var<Adapter_i> Adapter_i_var;
typedef ::Core::Var<const Adapter_i> Adapter_i_cvar;

class Adapter_i_factory;

class Adapter_i:
	virtual public Adapter::IAdapter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Adapter_i)
	friend class Adapter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	Adapter_i ();

	~Adapter_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Adapter::IAdapter
	// ������� ����� � ������ �����������
	void fini ();

	// implemented method from Adapter::IAdapter
	// ��������� ����������
	Adapter::ISearcher* get (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src);

	// implemented method from Adapter::IAdapter
	// ��������� �������
	Adapter::IHelper* get (DBCore::IBase* base, Morpho::Def::ICache* cache);

	// implemented method from Adapter::IAdapter
	// ������ ��� ��������� ����������� �������� �������������
	const DBCore::RelTuneData& get_tune_data () const;

	// implemented method from Adapter::IAdapter
	// �������������
	void init (DBCore::IBase* base);

	// implemented method from Adapter::IAdapter
	// ��������� memcache ���������� �������
	void load_memcache (const DBCore::MemCacheSettings& settings);
}; // class Adapter_i

} // namespace Adapter_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_ADAPTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
