////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/MorphoBase/Synonymizer.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::Synonymizer
//
// �������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_SYNONYMIZER_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_SYNONYMIZER_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/Morpho/Def/Def.h"

//#UC START# *53567E4D0007_CUSTOM_INCLUDES*
//#UC END# *53567E4D0007_CUSTOM_INCLUDES*

namespace ContextSearch {

// �������������
class Synonymizer {
	SET_OBJECT_COUNTER (Synonymizer)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ��� ������ ����
	typedef std::map < std::string, Morpho::Def::UCharSet > PartsSpeechCache;

	// EnvMap
	typedef std::map < std::string, std::string > EnvMap;

public:
	// Pattern
	struct Pattern {
		// ����� �����
		size_t len;
		// �������� ��������������� �������
		Search::Phrase values;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// ���������� ���������
	static const std::string& split (std::string& str);

private:
	// ����� ������������� ���������
	static bool find (const std::string& str, const DBComm::Synonyms& syns, DBComm::Synonyms::const_iterator& it);

	// ������������� ����
	static Search::Phrase* get_dates (const std::string& str, size_t& offset);

	// �������� �� �������
	static bool is_syn (const std::string& str, const std::string& syn);

	// ������������� ���������� ���������
	static void transform (std::string& str, EnvMap& env);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	Synonymizer (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������������
	Search::PhraseEx* get (const Search::Phrase& in);

	// �������������
	Search::Phrase* get (const std::string& str, size_t& offset);

	// ������������ �����
	const std::string& normalize (std::string& out) const;

private:
	// �������� �� �������������� � ����� ����
	bool check (const std::string& str, unsigned char x, unsigned char y);

	// �������� �� ������������ ����������
	bool check (const std::string& str, char attr);

	// ����� ������������� ��������� ���������������� �������
	bool find_template (
		const std::string& str
		, const DBComm::Synonyms& syns
		, DBComm::Synonyms::const_iterator& it
		, Pattern& out
	);

	// ���������
	void generate (const std::string& str, Search::PhraseEx& out);

	// ���������� ������ ������������ ����� ��� �������
	Search::Phrase* get_for_template (const Search::Phrase& values, const Search::Phrase& data);

	// �������� �� ������
	bool is_template (const std::string& str, const std::string& syn, Pattern& out);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	PartsSpeechCache m_cache;

	DBComm::IDBCommunicator* m_communicator;

	Morpho::Def::INormalizer* m_normalizer;

//#UC START# *53567E4D0007*
private:
	enum ExprType {
		et_None
		, et_Simple
		, et_Digit
		, et_Set
		, et_Colon
		, et_Bool
	};

	static ExprType get_expr_type (std::string::const_iterator beg, std::string::const_iterator end);

private:
	bool check_simple (std::string& str, std::string& span, char attr, bool strong);

	static bool check (
		std::string& out
		, std::string::const_iterator i_beg
		, std::string::const_iterator i_end
		, std::string::const_iterator s_beg
		, std::string::const_iterator s_end
	);

	static bool check_set (
		std::string& str
		, std::string& span
		, std::string::const_iterator s_beg
		, std::string::const_iterator s_end
		, bool strong
	);

	static bool is_exist (
		std::string& str
		, std::string& span
		, std::string::const_iterator s_beg
		, std::string::const_iterator s_end
		, bool strong
	);

	bool check_len (
		std::string& str
		, std::string& span
		, std::string::const_iterator beg
		, std::string::const_iterator end
		, bool strong
	);

	bool check_bool (
		std::string& str
		, std::string& span
		, std::string::const_iterator beg
		, std::string::const_iterator end
		, bool strong
	);

	bool check (
		std::string& str
		, std::string& span
		, std::string::const_iterator beg
		, std::string::const_iterator end
		, bool strong
	);
//#UC END# *53567E4D0007*
}; // class Synonymizer

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_SYNONYMIZER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

