////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/RelevancyCore/DebugInfo.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::RelevancyCore::DebugInfo
//
// ����� ���������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCYCORE_DEBUGINFO_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCYCORE_DEBUGINFO_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"

namespace ContextSearch {

// ����� ���������� ����������
class DebugInfo {
	SET_OBJECT_COUNTER (DebugInfo)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// ���� �������
	static void* make (bool val, Relevancy::IAlgorithm* algorithm);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// �����������
	explicit DebugInfo (Relevancy::IAlgorithm* algorithm);

public:
	~DebugInfo ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Relevancy::IAlgorithm_var m_algorithm;
}; // class DebugInfo

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCYCORE_DEBUGINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

