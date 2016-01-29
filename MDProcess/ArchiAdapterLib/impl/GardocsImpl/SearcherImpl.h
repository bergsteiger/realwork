////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/SearcherImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::SearcherImpl
// ��������� ���������� ������ �������� ��� ��������� Searcher
//
// SearcherImpl - ������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHERIMPL_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"

//#UC START# *4E1447E0018C_CUSTOM_INCLUDES*
//#UC END# *4E1447E0018C_CUSTOM_INCLUDES*

namespace ArchiAdapterLib {
namespace GardocsImpl {

class SearcherImpl; // self forward Var
typedef ::Core::Var<SearcherImpl> SearcherImpl_var;
typedef ::Core::Var<const SearcherImpl> SearcherImpl_cvar;

class SearcherImpl_factory;

// SearcherImpl - ������ �������
class SearcherImpl:
	virtual public Gardocs::Searcher
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (SearcherImpl)
	friend class SearcherImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SearcherImpl ();

	virtual ~SearcherImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Gardocs::Searcher
	virtual Gardocs::GardocList* get_notop_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
	) const /*throw (
		Gardocs::CommunicationFailure
	)*/;

	// implemented method from Gardocs::Searcher
	// ���������� ������ ����� ����������, ������������������ � � ����� date (date - ����� �
	// ������������� ����� 1 ������ 1970 ����, �.�. �����������)
	virtual Gardocs::GardocList* get_recently_created_since (
		const GCI::IO::DateTimeBox& date
		, const char* partnerId
	) const /*throw (
		Gardocs::CommunicationFailure
	)*/;

	// implemented method from Gardocs::Searcher
	virtual Gardocs::GardocList* get_top_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
	) const /*throw (
		Gardocs::CommunicationFailure
	)*/;

//#UC START# *4E1447E0018C*
//#UC END# *4E1447E0018C*
}; // class SearcherImpl

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
