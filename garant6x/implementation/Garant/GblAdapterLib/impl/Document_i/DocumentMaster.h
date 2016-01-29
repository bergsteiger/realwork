////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentMaster
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTMASTER_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTMASTER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"

//#UC START# *460A604B02E4_CUSTOM_INCLUDES*
//#UC END# *460A604B02E4_CUSTOM_INCLUDES*

// forward decls for defined friends
namespace GblAdapterLib {
	class DocumentDelegate;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DocumentMaster; // self forward Var
typedef ::Core::Var<DocumentMaster> DocumentMaster_var;
typedef ::Core::Var<const DocumentMaster> DocumentMaster_cvar;

class DocumentMaster_factory;

class DocumentMaster:
	virtual public Document_i
{
	SET_OBJECT_COUNTER (DocumentMaster)
	friend class DocumentMaster_factory; // self factory
	friend class DocumentDelegate; // defined friend
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	static char s_may_show_attributes;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit DocumentMaster (GblPilot::Document* document);

	DocumentMaster (const GCD::PID& pid, const char* name);

	virtual ~DocumentMaster ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// возвращает true, если список проинициализированн, иначе false
	virtual bool is_redaction_info_list_init () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable Document_var m_annotation;

	mutable boost::tribool m_can_set_to_control;

	mutable LanguagesList m_language_list;

	mutable Core::Box<GCD::PID> m_pid;

	mutable Core::Box<RedactionInfoList> m_redaction_info_list;

	mutable Document_var m_related_doc;

	mutable unsigned long m_under_control_status;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	virtual const RedactionInfoList get_redaction_info_list () const;

	virtual void set_redaction_info_list (const RedactionInfoList& redaction_info_list) const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Controllable
	// Возвращает true, если разрешена постановка на контроль
	virtual const bool get_can_set_to_control () const;

	// implemented method from Controllable
	// свойство определяющее, что данная сущность находится на контроле. Установка свойства в true
	// приводит к добавлению сущности на контроль, в false соответственно к снятию.
	virtual bool get_controlled () const;

	virtual void set_controlled (bool controlled);

	// implemented method from Controllable
	// Возврящает текущее значение статуса изменений.
	virtual unsigned long get_control_status ();

	// implemented method from Controllable
	// Сравнение объектов на контроле.
	virtual bool is_same_controllable (const Controllable* other);

	// implemented method from Controllable
	// Сбрасывает статус изменений в ноль.
	virtual void reset_control_status ();

	// implemented method from Controllable
	virtual ControlledItemType get_type () const;

	// implemented method from DocWithPid
	virtual const GCD::PID& get_document_pid () const;

	// implemented method from Document
	virtual const Document* get_annotation () const;
	virtual Document* get_annotation ();

	// implemented method from Document
	virtual GCD::PID get_redaction_pid () const;

	// implemented method from Document
	// есть ли у документа хронология рассмотрения судебного дела
	// K555095873
	virtual bool has_chronology () const;

	// implemented method from Document
	// Проверка возможности отображения атрибутов документа для текущего документа.
	// Возвращает true в случае, если показ атрибутов разрешен.
	// 
	// для редакций проверяются атрибуты, соответсвующие редакции (т.е. соответсвующие топику редакции
	// )
	virtual bool may_show_attributes () const;

	// implemented method from Document
	virtual const RedactionInfoList& get_redactions_list () const;

	// implemented method from Document
	virtual const Document* get_related_doc () const;
	virtual Document* get_related_doc ();

	// implemented method from Document
	virtual const LanguagesList& get_text_languages () const;

	// implemented method from Document_i
	virtual const DocumentMaster* get_master () const;

	// implemented method from Document_i
	virtual void load_server_doc () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Document
	// Статус документа
	virtual const ItemStatus get_status () const;

	// overloaded method from Document_i
	virtual void load (GblPilotDef::ExtendedDocInfo* edi) const;
private:

	// overloaded method from BaseUpdateChecker_i
	virtual void clear_cache ();


//#UC START# *460A604B02E4*
//#UC END# *460A604B02E4*
}; // class DocumentMaster

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTMASTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
