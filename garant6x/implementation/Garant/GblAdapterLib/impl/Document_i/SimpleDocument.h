////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::SimpleDocument
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SIMPLEDOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SIMPLEDOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"

namespace GblAdapterLib {

class SimpleDocument; // self forward Var
typedef ::Core::Var<SimpleDocument> SimpleDocument_var;
typedef ::Core::Var<const SimpleDocument> SimpleDocument_cvar;

class SimpleDocument_factory;

class SimpleDocument:
	virtual public DocumentMaster
{
	SET_OBJECT_COUNTER (SimpleDocument)
	friend class SimpleDocument_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit SimpleDocument (GblPilot::Document* document);

	virtual ~SimpleDocument ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Controllable
	// Возвращает true, если разрешена постановка на контроль
	virtual const bool get_can_set_to_control () const;

	// overloaded method from Controllable
	// свойство определяющее, что данная сущность находится на контроле. Установка свойства в true
	// приводит к добавлению сущности на контроль, в false соответственно к снятию.
	virtual bool get_controlled () const;

	virtual void set_controlled (bool controlled);

	// overloaded method from Controllable
	// Возврящает текущее значение статуса изменений.
	virtual unsigned long get_control_status ();

	// overloaded method from Controllable
	// Сравнение объектов на контроле.
	virtual bool is_same_controllable (const Controllable* other);

	// overloaded method from Controllable
	// Сбрасывает статус изменений в ноль.
	virtual void reset_control_status ();

	// overloaded method from Controllable
	virtual ControlledItemType get_type () const;

	// overloaded method from Document
	virtual const NodeBase* get_attributes_root () const;
	virtual NodeBase* get_attributes_root ();

	// overloaded method from Document
	// Получить url для отсканированного WWW-образа документа.
	virtual ExternalLink* get_internet_image_url (long block_id) const;

	// overloaded method from Document
	virtual TimeMachineWarning* get_time_machine_warning (const Date& date);

	// overloaded method from Document
	// Проверка наличия корреспондентов (любогй категории) у текущего документа.
	// Возвращает true в случае, если список корреспондентов для документа по категории CR_ALL не пуст.
	// 
	// для редакций, отличных от "главной", возвращает FALSE
	virtual bool has_correspondents (const NodeBase* category) const;

	// overloaded method from Document
	// Проверка наличия WWW-образа у текущего документа.
	// Возвращает true в случае, если у текущего документа есть WWW-образ.
	virtual bool has_internet_image () const;

	// overloaded method from Document
	// Функция показывает наличие следующей редакции для объекта.
	// Следующая редакция считается относительно текущего состояния (current_redaction).
	// Возвращает True в случае наличия хотябы одной более поздней (чем текущая) редакции.
	virtual bool has_next_redaction () const;

	// overloaded method from Document
	// Функция показывает наличие предыдущей редакции для объекта.
	// Предыдущая редакция считается относительно текущего состояния (current_redaction).
	// Возвращает True в случае наличия хотябы одной более ранней (чем текущая) редакции.
	virtual bool has_prev_redaction () const;

	// overloaded method from Document
	// Проверка наличия справки у текущего документа.
	// Возвращает true в случае, если у текущего документа есть справка.
	// 
	// для редакций, отличных от "главной", поведение такое же как и для "главной"
	virtual bool has_related_doc () const;

	// overloaded method from Document
	// Проверка наличия респондентов (любогй категории) у текущего документа.
	// Возвращает true в случае, если список респондентов для документа по категории CR_ALL не пуст.
	// 
	// для редакций, отличных от "главной", возвращает FALSE
	virtual bool has_respondents (const NodeBase* category) const;

	// overloaded method from Document
	// Присутствие предупреждения.
	virtual bool has_warning () const;

	// overloaded method from Document
	// Метод позволяет определить попадает ли date в интервал неуверенности документа.
	virtual bool is_date_in_not_sure_interval (const Date& date) const;

	// overloaded method from Document
	// Проверка возможности отображения атрибутов документа для текущего документа.
	// Возвращает true в случае, если показ атрибутов разрешен.
	// 
	// для редакций проверяются атрибуты, соответсвующие редакции (т.е. соответсвующие топику редакции
	// )
	virtual bool may_show_attributes () const;

	// overloaded method from Document
	virtual const RedactionInfoList& get_redactions_list () const;

	// overloaded method from Document
	virtual const Document* get_related_doc () const;
	virtual Document* get_related_doc ();

	// overloaded method from Document
	// Статус документа
	virtual const ItemStatus get_status () const;

	// overloaded method from Document
	// Предупреждение к документу.
	virtual const GCI::IO::String& get_warning () const;
	virtual GCI::IO::String& get_warning ();

}; // class SimpleDocument

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_SIMPLEDOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
