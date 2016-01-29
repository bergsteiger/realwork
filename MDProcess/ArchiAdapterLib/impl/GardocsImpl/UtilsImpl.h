////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/UtilsImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::UtilsImpl
// Заголовок реализации класса серванта для интерфеса Utils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_UTILSIMPL_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_UTILSIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

class UtilsImpl; // self forward Var
typedef ::Core::Var<UtilsImpl> UtilsImpl_var;
typedef ::Core::Var<const UtilsImpl> UtilsImpl_cvar;

class UtilsImpl_factory;

class UtilsImpl:
	virtual public Gardocs::Utils
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (UtilsImpl)
	friend class UtilsImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UtilsImpl ();

	virtual ~UtilsImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Gardocs::Utils
	// Особенность работы сервера заключается в том что он сначало получает все документы с указанной
	// даты в реализации Searcher2::get_xxxx, а потом выкидывает лишнее (например фильтрует по
	// партнеру). Если время, которое подает клиент слишком старое, то фильрация может занимать
	// несколько десятков минут. Поэтому клиенту предлагается в случае, если ему на
	// Searcher2::get_xxxx не вернулся ни один документ, дернуть update_old_last_created_time и
	// результат запомнить у себя.
	// Сервер будет отнимать от текущего времени 30-ть минут и результат возвращать клиенту. Если
	// получившееся время старше входного параметра, то просто отдается time.
	virtual GCI::IO::DateTimeBox* update_old_last_created_time (
		const GCI::IO::DateTimeBox& date
	) const /*throw (
		Gardocs::CommunicationFailure
	)*/;
}; // class UtilsImpl

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_UTILSIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
