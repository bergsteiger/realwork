////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/PageProxyImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::PageProxyImpl
// Заголовок реализации класса серванта для интерфеса PageProxy
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PAGEPROXYIMPL_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PAGEPROXYIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContents.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"

namespace GenSupportImpl {

class PageProxyImpl; // self forward Var
typedef ::Core::Var<PageProxyImpl> PageProxyImpl_var;
typedef ::Core::Var<const PageProxyImpl> PageProxyImpl_cvar;

class PageProxyImpl_factory;

class PageProxyImpl:
	virtual public GenSupport::PageProxy
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PageProxyImpl)
	friend class PageProxyImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PageProxyImpl (ServerGate::GenerationContents::ModelElementId_const page_guid);

	virtual ~PageProxyImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// делегат
	mutable ServerGate::GenerationContents::Page* m_delegate;

	// генерируемая часть текста страницы (без UC). Изменения данного атрибта реально будут
	// произведены только при операции commit.  При чтении атрибута используются данные транзакции
	// если читаем из тойже сессии, или персистентные в противном случае. Попытка конкурентной записи
	// приводит к исключению
	mutable std::auto_ptr<std::string> m_generated_text;

	// гуид страницы
	std::string m_guid;

	// кэшированное значение метода is_modified
	mutable Core::Box<bool> m_is_modified;

	// кэшированное значение метода is_new_page
	mutable Core::Box<bool> m_is_new_page;

	// перечисление лэйблов через запятую
	mutable std::auto_ptr<std::string> m_labels;

	mutable std::auto_ptr<std::string> m_path;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_guid () const;
private:
	ServerGate::GenerationContents::Page* get_delegate () const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GenSupport::PageProxy
	// добавляет диаграмму в аттач
	virtual void add_diagram (
		const char* name
		, const ServerGate::GenerationContents::Diagram& d
	) /*throw (
		ServerGate::GenerationContents::TransactionConflict
		, ServerGate::GenerationContents::ReadOnlyContent
	)*/;

	// implemented method from GenSupport::PageProxy
	// добавляет или заменяет свойства элемента генерации
	virtual void add_property_map (
		const ServerGate::GenerationContents::PropertyMapEntryList& map
	) /*throw (
		ServerGate::GenerationContents::TransactionConflict
		, ServerGate::GenerationContents::ReadOnlyContent
		, ServerGate::GenerationContents::ContentUpdateError
		, ServerGate::GenerationContents::PathNotValid
	)*/;

	// implemented method from GenSupport::PageProxy
	// генерируемая часть текста страницы (без UC). Изменения данного атрибта реально будут
	// произведены только при операции commit.  При чтении атрибута используются данные транзакции
	// если читаем из тойже сессии, или персистентные в противном случае. Попытка конкурентной записи
	// приводит к исключению
	virtual const std::string& get_generated_text () const;

	virtual void set_generated_text (const std::string& generated_text)
		/*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// возвращает контрольную сумму для всех свойств элемента генерации (нужно для того, чтобы понять,
	// что значения или набор свойств изменились с прошлой генерации)
	virtual long long get_all_property_cheksum () const;

	// implemented method from GenSupport::PageProxy
	// по имени диаграммы возвращает ее хэш
	virtual char* get_diagram_hash (const char* name) const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// возвращает тру если страница была изменена
	virtual bool is_modified () const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// возвращает тру если страница новая
	virtual bool is_new_page () const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// перечисление лэйблов через запятую
	virtual const std::string& get_labels () const;

	virtual void set_labels (const std::string& labels)
		/*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// помечает страницу на удаление. Реальное удаление произайдет при коммите
	virtual void mark_for_remove () /*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/;

	// implemented method from GenSupport::PageProxy
	// r/o экземпляр страницы до не прокоммиченых изменений
	virtual ServerGate::GenerationContents::Page* get_page_before_changes () const;

	// implemented method from GenSupport::PageProxy
	virtual const std::string& get_path () const;

	virtual void set_path (const std::string& path);

	// implemented method from GenSupport::PageProxy
	// сбрасывает все кэши прокси
	virtual void reset ();

	// implemented method from GenSupport::PageProxy
	virtual void rollback_all_changes () /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/;
}; // class PageProxyImpl

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PAGEPROXYIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
