////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultingTemplateInfo_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::ConsultingTemplateInfo_i
// Заголовок реализации класса серванта для интерфеса ConsultingTemplateInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTINGTEMPLATEINFO_I_H__
#define __GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTINGTEMPLATEINFO_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"

namespace GblAdapterLib {

class ConsultingTemplateInfo_i; // self forward Var
typedef ::Core::Var<ConsultingTemplateInfo_i> ConsultingTemplateInfo_i_var;
typedef ::Core::Var<const ConsultingTemplateInfo_i> ConsultingTemplateInfo_i_cvar;

class ConsultingTemplateInfo_i_factory;

class ConsultingTemplateInfo_i:
	virtual public ConsultingTemplateInfo
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
{
	SET_OBJECT_COUNTER (ConsultingTemplateInfo_i)
	friend class ConsultingTemplateInfo_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <ConsultingTemplateInfo_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConsultingTemplateInfo_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ConsultingTemplateInfo_i ();

	virtual ~ConsultingTemplateInfo_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable MemoryStream_var m_answer;

	mutable MemoryStream_var m_preanswer;

	mutable MemoryStream_var m_query;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();

	// implemented method from ConsultingTemplateInfo
	virtual GCI::IO::Stream* get_answer_template () const;

	// implemented method from ConsultingTemplateInfo
	// информация о комплекте, которая может быть нужна для шаблона. См. [$100008775]
	virtual GCI::IO::String* get_dealer_info () const;

	// implemented method from ConsultingTemplateInfo
	virtual GCI::IO::Stream* get_preanswer_template () const;

	// implemented method from ConsultingTemplateInfo
	// получить шаблон для запроса
	virtual GCI::IO::Stream* get_query_template () const;

	// implemented method from ConsultingTemplateInfo
	// определяет какой шаблон нужен для отображения консультации
	virtual TemplateType get_template_type (const Consultation* consultation) const /*throw (Deleted)*/;
}; // class ConsultingTemplateInfo_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTINGTEMPLATEINFO_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
