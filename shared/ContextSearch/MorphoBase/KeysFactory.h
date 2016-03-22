////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/MorphoBase/KeysFactory.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::KeysFactory
//
// ������� ������ ��� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_KEYSFACTORY_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_KEYSFACTORY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"

//#UC START# *565C3ADC00FD_CUSTOM_INCLUDES*
//#UC END# *565C3ADC00FD_CUSTOM_INCLUDES*

namespace ContextSearch {

// ������� ������ ��� ���������
class KeysFactory {
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// �������� �������� �����
	static GCL::StrVector* correct (const std::string& in);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit KeysFactory (DBComm::IDBCommunicator* comm);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ����������� ����������
	void get_identical (const Search::PhraseEx& request, Relevancy::Positions& out);

	// ����������� ����������
	void get_identical (const std::string& request, Relevancy::Positions& out);

	// �������
	GCL::StrSet* make (const GCL::StrSet& in);

	// �������
	GCL::StrSet* make_for_word (const std::string& word);

private:
	// �������� ���� ��� �������� �����
	void add (const std::string& word, GCL::StrSet& out);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBComm::IDBCommunicator* m_communicator;

//#UC START# *565C3ADC00FD*
//#UC END# *565C3ADC00FD*
}; // class KeysFactory

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_KEYSFACTORY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

