////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Morpho/impl/Impl/Cache_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::Cache_i
//
// ���������� ���� �������� � ��������� ������ �� gkdb
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_IMPL_CACHE_I_H__
#define __SHARED_MORPHO_IMPL_CACHE_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/DB/DBCore/DBCore.h"
#include "shared/Morpho/Def/Def.h"

namespace Morpho {
namespace Impl {

// ���������� ���� �������� � ��������� ������ �� gkdb
class Cache_i;
typedef Core::Var<Cache_i> Cache_i_var;
typedef Core::Var<const Cache_i> Cache_i_cvar;

class Cache_i :
	virtual public Def::ICache
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Cache_i)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ����������
	static const size_t RESERVE_SIZE; // ������ ��� ��������������
	static const size_t SMALL_RESERVE_SIZE; // ������ ��� ��������������

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// �������� ������ �����
	static void load (DBCore::IIndex* index, const void* key, GCL::StrVector& out);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	Cache_i ();

public:
	virtual ~Cache_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// �������� ����������� �� ������������� ������
	void load_exclude (DBCore::IIndex* index);

	// �������� �����-��������
	void load_pairs (DBCore::IIndex* index, const void* key, Def::FixedPairs& out);

	// �������� ����������
	void load_postfixes (DBCore::IIndex* index);

	// �������� ������ ��� ����������������
	void load_pseudo (DBCore::IIndex* index);

	// �������� ����������� ���������
	void load_simple_syns (DBCore::IIndex* index);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Box<Def::CacheData> m_data;

	Def::FixedPairs m_fixed_pairs;

	Core::Mutex m_mutex;

	Def::FixedPairs m_syn_pairs;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Def::ICache
	// �������� ���
	virtual void clear ();

	// implemented method from Def::ICache
	// �����������
	virtual const Def::Exclude& get_exclude () const;

	// implemented method from Def::ICache
	// ������ �������� � �� �����������
	virtual const Def::FixedPairs& get_fixed_pairs () const;

	// implemented method from Def::ICache
	// ������ ��� ������������
	virtual const Def::MorphoData& get_morpho_data () const;

	// implemented method from Def::ICache
	// ���������������
	virtual const GCL::StrVector& get_not_normalized () const;

	// implemented method from Def::ICache
	// ������ ������������ ���
	virtual const Def::FixedPairs& get_syn_pairs () const;

	// implemented method from Def::ICache
	// ��������
	virtual const Def::Synonyms& get_syns () const;

	// implemented method from Def::ICache
	// ��������
	virtual const GCL::StrVector& get_syns (const std::string& key);

	// implemented method from Def::ICache
	// ��������
	virtual void load (DBCore::IBase* base, bool load_ssyn);
}; // class Cache_i

} // namespace Impl
} // namespace Morpho


#endif //__SHARED_MORPHO_IMPL_CACHE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

