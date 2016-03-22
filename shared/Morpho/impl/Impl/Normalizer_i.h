////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Morpho/impl/Impl/Normalizer_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::Normalizer_i
//
// ���������� ���������� �������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_IMPL_NORMALIZER_I_H__
#define __SHARED_MORPHO_IMPL_NORMALIZER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Morpho/Def/Def.h"
#include "shared/Morpho/impl/Impl/MorphoFilter.h"
#include "shared/Morpho/impl/Impl/MorphoAnalyzer.h"

namespace Morpho {
namespace Impl {

// ���������� ���������� �������������
class Normalizer_i;
typedef Core::Var<Normalizer_i> Normalizer_i_var;
typedef Core::Var<const Normalizer_i> Normalizer_i_cvar;

class Normalizer_i :
	virtual public Def::INormalizer
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Normalizer_i)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// �������� ������
	static void add (GCL::StrVector& out, const std::string& str, char delim = ' ');

	// ������� ����
	static const std::string& make_key (const std::string& in, std::string& out, bool is_pseudo);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	Normalizer_i (Def::ICache* cache, Def::IMorphoAdapter* adapter);

public:
	virtual ~Normalizer_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ��������� ���� ��� �������� ����������
	void add (const std::string& word, GCL::StrSet& out, const Def::NSettings& info);

	// �������� �����
	void add_word (GCL::StrSet& normas, const std::string& word, bool is_pseudo, bool as_key);

	// ������������ �����
	bool get (GCL::StrSet& normas, const std::string& word, bool use_filter, bool as_key);

	// ������������
	void normalize (const std::string& word, char delim, GCL::StrVector& reqs);

	// ������������ �����
	bool normalize (GCL::StrSet& normas, const std::string& word, bool use_filter, bool as_key);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Box<MorphoAnalyzer> m_analyzer;

	Def::ICache_var m_cache;

	Core::Box<MorphoFilter> m_filter;

	Def::AnalysisInfo m_info;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Def::INormalizer
	// ������������ �����
	virtual GCL::StrSet* execute (const std::string& word, const Def::NSettings& info);

	// implemented method from Def::INormalizer
	// ������������ ������
	virtual GCL::StrSet* execute (const std::string& str);

	// implemented method from Def::INormalizer
	// ������������ �����
	virtual GCL::StrSet* execute (const std::string& word, bool as_key);

	// implemented method from Def::INormalizer
	// ������������ �����
	virtual GCL::StrVector* execute_for_phrase (const std::string& in);

	// implemented method from Def::INormalizer
	// ���� � ������������
	virtual const Def::AnalysisInfo& get_info () const;

	// implemented method from Def::INormalizer
	// ����� ���� ��� �����
	virtual void get_parts_of_speech (const std::string& word, Def::UCharSet& out);

	// implemented method from Def::INormalizer
	// �������� ������� �� ��, ��� ���  ����� �������� ���������� �����
	virtual bool has_norma (const std::string& word, const std::string& norma);

	// implemented method from Def::INormalizer
	// �������� �� ������
	virtual bool is_pseudo (const std::string& in);

	// implemented method from Def::INormalizer
	// ������������
	virtual size_t lemmatize (const char* in, char* out);
}; // class Normalizer_i

} // namespace Impl
} // namespace Morpho


#endif //__SHARED_MORPHO_IMPL_NORMALIZER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

