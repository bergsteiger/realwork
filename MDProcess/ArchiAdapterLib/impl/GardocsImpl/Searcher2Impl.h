////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/Searcher2Impl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::Searcher2Impl
// Заголовок реализации класса серванта для интерфеса Searcher2
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHER2IMPL_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHER2IMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

class Searcher2Impl; // self forward Var
typedef ::Core::Var<Searcher2Impl> Searcher2Impl_var;
typedef ::Core::Var<const Searcher2Impl> Searcher2Impl_cvar;

class Searcher2Impl_factory;

class Searcher2Impl:
	virtual public Gardocs::Searcher2
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Searcher2Impl)
	friend class Searcher2Impl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Searcher2Impl ();

	virtual ~Searcher2Impl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Gardocs::Searcher2
	virtual Gardocs::GardocList* get_notop_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
		, const char* partnerId
	) const /*throw (
		Gardocs::CommunicationFailure
	)*/;

	// implemented method from Gardocs::Searcher2
	virtual Gardocs::GardocList* get_top_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
		, const char* partnerId
	) const /*throw (
		Gardocs::CommunicationFailure
	)*/;
}; // class Searcher2Impl

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHER2IMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
