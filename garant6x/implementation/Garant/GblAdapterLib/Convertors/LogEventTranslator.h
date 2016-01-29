////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/LogEventTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Convertors::LogEventTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_LOGEVENTTRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_LOGEVENTTRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Logging/Logging.h"
#include "garantServer/src/Business/GblLogging/GblLoggingC.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class LogEventTranslator : 
	public Core::UnsortedTypeConverter<GblLogging::LogEvent, LogEvent> {
	protected:
		void fill_array () {
			//#UC START# *460BC9DA0222_FILL_ARRAY_IMPLEMENTATION*
			this->add (LE_OPEN_DOCUMENT_FROM_LIST, GblLogging::LE_OPEN_DOCUMENT_FROM_LIST);
			this->add (LE_OPEN_DOCUMENT_FROM_LINK, GblLogging::LE_OPEN_DOCUMENT_FROM_LINK);
			this->add (LE_EXPORT_TO_FILE, GblLogging::LE_EXPORT_TO_FILE);
			this->add (LE_EXPORT_TO_WORD, GblLogging::LE_EXPORT_TO_WORD);
			this->add (LE_GET_DOCUMENT_STRUCTURE, GblLogging::LE_GET_STRUCTURE);
			this->add (LE_OPEN_RELATED, GblLogging::LE_OPEN_RELATED);
			this->add (LE_OPEN_ANNOTATION, GblLogging::LE_OPEN_ANNOTATION);
			this->add (LE_OPEN_MAIN_MENU, GblLogging::LE_OPEN_MAIN_MENU);
			this->add (LE_OPEN_DICTIONARY, GblLogging::LE_OPEN_DICTIONARY);
			this->add (LE_USER_OPERATION, GblLogging::LE_USER_OPERATION);
			this->add (LE_ADD_TO_LIST, GblLogging::LE_ADD_TO_LIST);
			this->add (LE_DELETE_FROM_LIST, GblLogging::LE_DELETE_FROM_LIST);
			this->add (LE_SEARCH_IN_DOCUMENT, GblLogging::LE_SEARCH_IN_DOCUMENT);
			this->add (LE_OPEN_DOCUMENT_FROM_FOLDERS, GblLogging::LE_OPEN_DOCUMENT_FROM_FOLDERS);
			this->add (LE_SAVE_DOCUMENT_TO_FOLDERS, GblLogging::LE_SAVE_DOC_TO_FOLDERS);
			this->add (LE_PRIMARY_MONITOR_RESOLUTION, GblLogging::LE_PRIMARY_MONITOR_RESOLUTION);
			this->add (LE_DPI, GblLogging::LE_DPI);
			this->add (LE_FONT_SIZE, GblLogging::LE_FONT_SIZE);
			this->add (LE_FIND_CONTEXT_IN_LIST, GblLogging::LE_FIND_CONTEXT_IN_LIST);
			this->add (LE_OPEN_DOCUMENT_FROM_HISTORY, GblLogging::LE_OPEN_DOCUMENT_FROM_HISTORY);
			this->add (LE_LIST_PRINT, GblLogging::LE_LIST_PRINT);
			this->add (LE_LIST_PRINT_PREVIEW, GblLogging::LE_LIST_PRINT_PREVIEW);
			this->add (LE_LIST_SORT, GblLogging::LE_LIST_SORT);
			this->add (LE_LIST_REFERENCE_ACTIVATE, GblLogging::LE_LIST_REFERENCE_ACTIVATE);
			this->add (LE_SYNCHROVIEW_ACTIVATE, GblLogging::LE_SYNCHROVIEW_ACTIVATE);
			this->add (LE_TIME_MACHINE_ON, GblLogging::LE_TIME_MACHINE_ON);
			this->add (LE_TIME_MACHINE_OFF, GblLogging::LE_TIME_MACHINE_OFF);
			this->add (LE_NEXT_DOCUMENT, GblLogging::LE_NEXT_DOCUMENT);
			this->add (LE_PREV_DOCUMENT, GblLogging::LE_PREV_DOCUMENT);
			this->add (LE_VIEW_DOCUMENT_EDITION_LIST, GblLogging::LE_VIEW_DOCUMENT_EDITION_LIST);
			this->add (LE_VIEW_DOCUMENT_ATTRIBUTES, GblLogging::LE_VIEW_DOCUMENT_ATTRIBUTES);
			this->add (LE_BACK, GblLogging::LE_BACK);
			this->add (LE_FORWARD, GblLogging::LE_FORWARD);
			this->add (LE_INC_FONT, GblLogging::LE_INC_FONT);
			this->add (LE_DEC_FONT, GblLogging::LE_DEC_FONT);
			this->add (LE_OPEN_NEWS_LINE, GblLogging::LE_OPEN_NEWS_LINE);
			this->add (LE_OPEN_CONSULTATION, GblLogging::LE_OPEN_CONSULTATION);
			this->add (LE_SAVE_QUERY, GblLogging::LE_SAVE_QUERY);
			this->add (LE_LOAD_QUERY, GblLogging::LE_LOAD_QUERY);
			this->add (LE_LOAD_QUERY_FROM_HISTORY, GblLogging::LE_LOAD_QUERY_FROM_HISTORY);
			this->add (LE_CONTEXT_FILTER_IN_TREE, GblLogging::LE_CONTEXT_FILTER_IN_TREE);
			this->add (LE_DOCUMENT_PRINT, GblLogging::LE_DOCUMENT_PRINT);
			this->add (LE_DOCUMENT_PRINT_PREVIEW, GblLogging::LE_DOCUMENT_PRINT_PREVIEW);
			this->add (LE_VIEW_SAME_DOCUMENTS, GblLogging::LE_VIEW_SAME_DOCUMENTS);
			this->add (LE_SEND_DOCUMENT_BY_EMAIL, GblLogging::LE_SEND_DOCUMENT_BY_EMAIL);
			this->add (LE_SEND_LIST_BY_EMAIL, GblLogging::LE_SEND_LIST_BY_EMAIL);
			this->add (LE_UNKNOWN, GblLogging::LE_UNKNOWN);
			this->add (LE_SEND_REQUEST_TO_LEGAL_ADVISE, GblLogging::LE_SEND_REQUEST_TO_LEGAL_ADVISE);
			this->add (LE_SEND_TEST_REQUEST_TO_LEGAL_ADVISE, GblLogging::LE_SEND_TEST_REQUEST_TO_LEGAL_ADVISE);
			this->add (LE_OPEN_MEDIC_FIRMS, GblLogging::LE_OPEN_MEDIC_FIRMS);
			this->add (LE_OPEN_MEDIC_DICTIONARY, GblLogging::LE_OPEN_MEDIC_DICTIONARY);
			this->add (LE_USE_SUB_PANEL_DOCUMENT_OPERATION, GblLogging::LE_USE_SUB_PANEL_DOCUMENT_OPERATION);
			this->add (LE_USE_BASE_SEARCH_EXAMPLE, GblLogging::LE_USE_BASE_SEARCH_EXAMPLE);
			this->add (LE_USE_TASK_PANEL_OPERATION, GblLogging::LE_USE_TASK_PANEL_OPERATION);
			this->add (LE_OPEN_DOCUMENT_BY_NUMBER, GblLogging::LE_OPEN_DOCUMENT_BY_NUMBER);
			this->add (LE_OPEN_PHARM_DOCUMENT, GblLogging::LE_OPEN_PHARM_DOCUMENT);
			this->add (LE_OPEN_PHARM_FIRM_DOCUMENT, GblLogging::LE_OPEN_PHARM_FIRM_DOCUMENT);
			this->add (LE_USE_BASE_SEARCH_HINT, GblLogging::LE_USE_BASE_SEARCH_HINT);

			this->add (LE_LIST_EXPORT_TO_FILE, GblLogging::LE_LIST_EXPORT_TO_FILE);
			this->add (LE_LIST_EXPORT_TO_WORD, GblLogging::LE_LIST_EXPORT_TO_WORD);

			// добавления для версии 7.4
			this->add (LE_USE_BACK_SEARCH_BUTTON, GblLogging::LE_USE_BACK_SEARCH_BUTTON);
			this->add (LE_OPEN_INTERNET_AGENT, GblLogging::LE_OPEN_INTERNET_AGENT);
			this->add (LE_SWITCH_VERSION_COMMENTS, GblLogging::LE_SWITCH_VERSION_COMMENTS);
			this->add (LE_CHAT_WINDOW_OPENS_COUNT, GblLogging::LE_CHAT_WINDOW_OPENS_COUNT);

			this->add (LE_SEARCH_IN_DOCUMENT_DONE, GblLogging::LE_SEARCH_IN_DOCUMENT_DONE);
			this->add (LE_NEXT_SEARCH_IN_DOCUMENT, GblLogging::LE_NEXT_SEARCH_IN_DOCUMENT);
			this->add (LE_PREVIOUS_SEARCH_IN_DOCUMENT, GblLogging::LE_PREVIOUS_SEARCH_IN_DOCUMENT);
			this->add (LE_DOCUMENT_NOT_EXIST, GblLogging::LE_DOCUMENT_NOT_EXIST);
			this->add (LE_OPEN_DOCUMENT_FROM_SEARCH_HINT, GblLogging::LE_OPEN_DOCUMENT_FROM_SEARCH_HINT);

			//#UC END# *460BC9DA0222_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class LogEventTranslator

typedef ACE_Singleton<LogEventTranslator, ACE_SYNCH_NULL_MUTEX> LogEventTranslatorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_LOGEVENTTRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

