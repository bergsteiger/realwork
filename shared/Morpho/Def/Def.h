////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Morpho/Def/Def.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Morpho::Def
//
// ���������� � ���� ������, ������������ � ����������  ������������ � ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_DEF_H__
#define __SHARED_MORPHO_DEF_H__

#include "shared/Core/sys/std_inc.h"
#include <set>
#include <map>
#include <vector>
#include "shared/DB/DBCore/DBCore.h"
#include "shared/GCL/data/std_defs.h"

namespace Morpho {
namespace Def {

#pragma pack (push, 1)

// ��������� ��� ��������� ������������
struct NSettings {
	// ������������ ������
	bool use_filter;
	// ��������� ������������ � ���� ������
	bool as_key;
	NSettings () : use_filter(true), as_key(true) {
		//#UC START# *4E009F7E02D3_DEF_INIT_CTOR*
		//#UC END# *4E009F7E02D3_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

// ��� ���������������� �������
enum AnalysisKind {
	ak_Morpho // ����� �� ���������� ���������
	, ak_Prefix // ������ ��� ������ ����� ���������
	, ak_Postfix // ������ ��� ������ ����� ������� ����
	, ak_NPseudo // ������ ��� ������ ����� ����������������
	, ak_Pseudo // ������ ��� ������ ������ ���������������� (�������� ������)
	, ak_Unknown // ������ �� ��������� (��������, ��������, �����)
};

// ��������� ��� ����������������
typedef std::map < std::string, std::string > StrStrMap;

#pragma pack (push, 1)

// ������ ��� ������������
struct MorphoData {
	// ������ ����������
	GCL::StrVector postfixes;
	// ������ ���������
	GCL::StrVector prefixes;
	// ������ ����-����
	GCL::StrVector stop_lemmas;
	// ������ ��������� ��� ����������������
	StrStrMap pseudo;
};

#pragma pack (pop)

// ����������� �������
typedef std::map < std::string, GCL::StrVector > Exclude;

#pragma pack (push, 1)

// ���� � ��������������� �������
struct AnalysisInfo {
	// ������� ������
	bool is_pseudo;
	// ��� �������
	AnalysisKind kind;
	AnalysisInfo () : is_pseudo(true) {
		//#UC START# *4E733EBB0283_DEF_INIT_CTOR*
		kind = ak_Unknown;
		//#UC END# *4E733EBB0283_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

// ��������� ��������
typedef std::set < unsigned char > UCharSet;

class IMorphoAdapter;
typedef ::Core::Var<IMorphoAdapter> IMorphoAdapter_var;
typedef ::Core::Var<const IMorphoAdapter> IMorphoAdapter_cvar;
// ����� �������
class IMorphoAdapter
	: virtual public ::Core::IObject
{
public:
	// ����������
	virtual short get_gramm (const char* in, char* out, unsigned short size) = 0;

	// ������������
	virtual short lemmatize (const char* in, char* buf, size_t buf_len) = 0;
};

#pragma pack (push, 1)

// ������ ����
struct CacheData {
	// ������ ��� ������������
	MorphoData data;
	// ��������������� �������
	GCL::StrVector stops;
	// ����������� �� ���������� ������������ �������
	Exclude exclude;
};

#pragma pack (pop)

#pragma pack (push, 1)

// �������� - �����������
struct FixedPair {
	// ��������
	std::string mistake;
	// �����������
	std::string correct;
	//#UC START# *5499947E0206*
	bool operator < (const FixedPair& val) const {
		return mistake < val.mistake;
	}
	//#UC END# *5499947E0206*
};

#pragma pack (pop)

// ������ �������� � �� �����������
typedef std::vector < FixedPair > FixedPairs;

class ICache;
typedef ::Core::Var<ICache> ICache_var;
typedef ::Core::Var<const ICache> ICache_cvar;
// ��������� ���� ������
class ICache
	: virtual public ::Core::IObject
{
public:
	// �������� ���
	virtual void clear () = 0;

	// �����������
	virtual const Exclude& get_exclude () const = 0;

	// ������ �������� � �� �����������
	virtual const FixedPairs& get_fixed_pairs () const = 0;

	// ������ ��� ������������
	virtual const MorphoData& get_morpho_data () const = 0;

	// ���������������
	virtual const GCL::StrVector& get_not_normalized () const = 0;

	// ������ ������������ ���
	virtual const FixedPairs& get_syn_pairs () const = 0;

	// ��������
	virtual void load (DBCore::IBase* base) = 0;
};

// ��������� ��������� ������������
static const size_t MAX_WORD_LEN = 31; // ������������ ����� �����

class INormalizer;
typedef ::Core::Var<INormalizer> INormalizer_var;
typedef ::Core::Var<const INormalizer> INormalizer_cvar;
// ��������� ��������� ������������ ����� �����
class INormalizer
	: virtual public ::Core::IObject
{
public:
	// ������������ �����
	virtual GCL::StrSet* execute (const std::string& word, const NSettings& info) = 0;

	// ������������ ������
	virtual GCL::StrSet* execute (const std::string& str) = 0;

	// ������������ �����
	virtual GCL::StrSet* execute (const std::string& word, bool as_key) = 0;

	// ������������ �����
	virtual GCL::StrVector* execute_for_phrase (const std::string& in) = 0;

	// ���� � ������������
	virtual const AnalysisInfo& get_info () const = 0;

	// ����� ���� ��� �����
	virtual void get_parts_of_speech (const std::string& word, UCharSet& out) = 0;

	// �������� ������� �� ��, ��� ���  ����� �������� ���������� �����
	virtual bool has_norma (const std::string& word, const std::string& norma) = 0;

	// �������� �� ������
	virtual bool is_pseudo (const std::string& in) = 0;

	// ������������
	virtual size_t lemmatize (const char* in, char* out) = 0;
};

} // namespace Def
} // namespace Morpho


#endif //__SHARED_MORPHO_DEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
