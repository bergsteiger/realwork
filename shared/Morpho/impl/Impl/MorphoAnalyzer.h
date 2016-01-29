////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Morpho/impl/Impl/MorphoAnalyzer.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::MorphoAnalyzer
//
// ������� ����������� ��������� ��������� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_IMPL_MORPHOANALYZER_H__
#define __SHARED_MORPHO_IMPL_MORPHOANALYZER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Morpho/Def/Def.h"

//#UC START# *4E046AA602AA_CUSTOM_INCLUDES*
//#UC END# *4E046AA602AA_CUSTOM_INCLUDES*

namespace Morpho {
namespace Impl {

// ������� ����������� ��������� ��������� ������������
class MorphoAnalyzer {
	SET_OBJECT_COUNTER (MorphoAnalyzer)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ��������� ��������� ������������
	static const size_t LEMMA_BUF_LEN; // ������ ������� ����
	static const size_t MAX_WORD_END; // ������������ ����� ��������� �����
	static const size_t MIN_LEFT_SIZE; // ����������� ������ ����� ����� ����� ������������ ���������

	// ��������� ��� ��������������� �������
	static const unsigned short GRAM_SIZE; // ������ �������
	static const unsigned char DIGIT_PART; // �������� ����� ���� ��� �����
	static const unsigned char UNKNOWN_PART; // �������� ��� ����������� ����� ����

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ����������� ������� � ������� � ������
	static void convert (const char* buf, size_t count, GCL::StrVector& out);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	MorphoAnalyzer (Def::ICache* cache, Def::IMorphoAdapter* adapter);

public:
	virtual ~MorphoAnalyzer ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ����� ���� ��� �����
	void get_parts_of_speech (const std::string& word, Def::UCharSet& out);

	// ���������
	bool lemmatize (const std::string& word, GCL::StrVector& lemmas, Def::AnalysisInfo& info);

private:
	// ������������
	short lemmatize (const char* in, char* buf);

	// ��������� ����������
	void postfixes_analysis (const std::string& word, GCL::StrVector& out);

	// ��������� ���������
	void prefixes_analysis (const std::string& word, GCL::StrVector& out);

	// ����������������
	void pseudo_analysis (const std::string& word, GCL::StrVector& out);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Def::IMorphoAdapter_var m_adapter;

	Def::ICache_var m_cache;

//#UC START# *4E046AA602AA*
//#UC END# *4E046AA602AA*
}; // class MorphoAnalyzer

} // namespace Impl
} // namespace Morpho


#endif //__SHARED_MORPHO_IMPL_MORPHOANALYZER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

