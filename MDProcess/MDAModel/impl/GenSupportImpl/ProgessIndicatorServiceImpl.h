////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/ProgessIndicatorServiceImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::ProgessIndicatorServiceImpl
// Заголовок реализации класса серванта для интерфеса ProgessIndicatorService
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PROGESSINDICATORSERVICEIMPL_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PROGESSINDICATORSERVICEIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "shared/WinGUI/Controls/ProgressIndicator.h"

namespace GenSupportImpl {

class ProgessIndicatorServiceImpl; // self forward Var
typedef ::Core::Var<ProgessIndicatorServiceImpl> ProgessIndicatorServiceImpl_var;
typedef ::Core::Var<const ProgessIndicatorServiceImpl> ProgessIndicatorServiceImpl_cvar;

class ProgessIndicatorServiceImpl_factory;

// реализация
class ProgessIndicatorServiceImpl:
	virtual public GenSupport::ProgessIndicatorService
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ProgessIndicatorServiceImpl)
	friend class ProgessIndicatorServiceImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ProgessIndicatorServiceImpl ();

	virtual ~ProgessIndicatorServiceImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// индифкатор процесса
	WinGUI::ProgressIndicator* m_indicator;

	// мьютекс для синхронизации
	mutable Core::Mutex m_mutex;

	// размер прогресс-индикатора
	unsigned int m_progress_size;

	// устанавливает размер шага
	unsigned int m_step_size;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GenSupport::ProgessIndicatorService
	// событие завершения генерации
	virtual void end () /*throw (GenSupport::GenerationNotStarted)*/;

	// implemented method from GenSupport::ProgessIndicatorService
	// возвращает true, если прогресс запущен, но еще не закончен
	virtual bool is_started () const;

	// implemented method from GenSupport::ProgessIndicatorService
	// начало генерации - показывает прогресс индикатор
	virtual void start () /*throw (GenSupport::GenerationAlreadyStarted)*/;

	// implemented method from GenSupport::ProgessIndicatorService
	// выполняет шаг прогресса. Если не был вызыван start, то вызывает его
	virtual void step ();

	// implemented method from GenSupport::ProgessIndicatorService
	// инициирует шаг, передает сообщение описывающее шаг. Если не был вызыван start, то вызывает его
	virtual void step (const std::string& message);

	// implemented method from GenSupport::ProgessIndicatorService
	// обновляет информацию в прогресс индикаторе
	virtual void update_message (const std::string& mess);

	// implemented method from WinGUI::ProgressIndicatorDelegate
	// обработчик нажатия кнопки "CANCEL" при этом событие progress_indicator_closed не вызывается!
	virtual void progress_indicator_canceled (const WinGUI::ProgressIndicator& indicator);

	// implemented method from WinGUI::ProgressIndicatorDelegate
	// событие о закрытии окна прогресс индикатора
	virtual void progress_indicator_closed (const WinGUI::ProgressIndicator& indicator);

	// implemented method from WinGUI::ProgressIndicatorDelegate
	// собатие  о том, что прогресс бар дошел до конца
	virtual void progress_indicator_finished (const WinGUI::ProgressIndicator& indicator);

	// implemented method from WinGUI::ProgressIndicatorDelegate
	// размер прогресс-индикатора
	virtual unsigned int get_progress_size () const;

	virtual void set_progress_size (unsigned int progress_size);

	// implemented method from WinGUI::ProgressIndicatorDelegate
	// устанавливает размер шага
	virtual unsigned int get_step_size () const;

	virtual void set_step_size (unsigned int step_size);
}; // class ProgessIndicatorServiceImpl

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PROGESSINDICATORSERVICEIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
