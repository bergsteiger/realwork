////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Morpho/impl/Impl/CacheTxt_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::CacheTxt_i
//
// ���������� ���� �������� � ��������� �������� �� ��������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_IMPL_CACHETXT_I_H__
#define __SHARED_MORPHO_IMPL_CACHETXT_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Morpho/Def/Def.h"

namespace Morpho {
namespace Impl {

// ���������� ���� �������� � ��������� �������� �� ��������� ������
class CacheTxt_i;
typedef Core::Var<CacheTxt_i> CacheTxt_i_var;
typedef Core::Var<const CacheTxt_i> CacheTxt_i_cvar;

class CacheTxt_i :
	virtual public Def::ICache
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CacheTxt_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// �����������
	explicit CacheTxt_i (const std::string& path);

public:
	virtual ~CacheTxt_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// �������� ������ �����
	void load (const char* name, GCL::StrVector& out);

	// �������� ����������
	void load_postfixes (const char* name);

	// �������� ������ ��� ����������������
	void load_pseudo (const char* name);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Box<Def::CacheData> m_data;

	Core::Mutex m_mutex;

	std::string m_path;

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
	virtual void load (DBCore::IBase* base);
}; // class CacheTxt_i

} // namespace Impl
} // namespace Morpho


#endif //__SHARED_MORPHO_IMPL_CACHETXT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

