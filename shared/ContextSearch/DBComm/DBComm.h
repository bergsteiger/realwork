////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/DBComm/DBComm.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::DBComm
//
// Интерфейсы и типы для коммуникации с хранилищем.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_DBCOMM_H__
#define __SHARED_CONTEXTSEARCH_DBCOMM_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/ContextSearch/Defs/Defs.h"
#include "shared/DB/DBCore/DBCore.h"
#include "shared/GCL/data/std_defs.h"

namespace ContextSearch {
namespace DBComm {

// Прогресс-индикатор
typedef DBCore::IProgress IProgress;
typedef DBCore::IProgress_var IProgress_var;
typedef DBCore::IProgress_cvar IProgress_cvar;

#pragma pack (push, 1)

// Синонмичная пара
struct SynPair {
	// ключ
	std::string key;
	// данные
	GCL::StrVector data;
	//#UC START# *5356905A0200*
	inline bool operator < (const SynPair& val) const {
		if (key.size () == val.key.size ()) {
			return key [0] < val.key [0];
		}
		return key.size () > val.key.size ();
	}
	//#UC END# *5356905A0200*
};

#pragma pack (pop)

// Тип для идентификатора документа
typedef DBCore::DocId DocId;

// Константы
static const DocId NULL_DOC_ID = 0; // нулевой идентификатор документа
static const DocId INFINITE_DOC_ID = std::numeric_limits <DocId>::max (); // максимально допустимый идентификатор документа

// Фабрика стримов
typedef DBCore::IStreamsFactory IStreamsFactory;
typedef DBCore::IStreamsFactory_var IStreamsFactory_var;
typedef DBCore::IStreamsFactory_cvar IStreamsFactory_cvar;

// Пара крайних значений
typedef DBCore::ExtrPair ExtrPair;

// Шаблоны связей между частями речи
typedef DBCore::PSDTemplates PSDTemplates;

// Синонимы
typedef std::vector < SynPair > Synonyms;

#pragma pack (push, 1)

// Пара строк
struct StrPair {
	// first
	std::string first;
	// second
	std::string second;
	//#UC START# *53EB77B3015E*
	bool operator < (const StrPair& val) const {
		if (first.size () == val.first.size ()) {
			return first [0] < val.first [0];
		}
		return first.size () > val.first.size ();
	}
	//#UC END# *53EB77B3015E*
};

#pragma pack (pop)

// Вектор пар строк
typedef std::vector < StrPair > StrPairVector;

class IDBCommunicator;
typedef ::Core::Var<IDBCommunicator> IDBCommunicator_var;
typedef ::Core::Var<const IDBCommunicator> IDBCommunicator_cvar;
// Интерфейс для доступа к словарям
class IDBCommunicator
	: virtual public ::Core::IObject
{
public:
	// стоп-слова и стоп-фразы
	virtual const GCL::StrVector& get_exclude_data () const = 0;

	// устойчивые словосочетания
	virtual const GCL::StrVector& get_hard_phrases () const = 0;

	// длины блоков приписанных к позициям из невидимого текста
	virtual const Defs::InvisibleBlocks& get_invisible_blocks () const = 0;

	// "баллы релевантности" для позиций из простого невидимого текста документа
	virtual const Defs::InvisibleRel& get_invisible_rel () const = 0;

	// фразальные замены
	virtual const StrPairVector& get_phrasal_replacement () const = 0;

	// синонимы
	virtual const Synonyms& get_syns () const = 0;

	// шаблоны частиречных связей
	virtual const DBCore::PSDTemplates& get_templates () const = 0;

	// шаблонные синонимы
	virtual const Synonyms& get_templates_syns () const = 0;

	// данные для алгоритма модификации значений релевантности
	virtual const DBCore::RelTuneData& get_tune_data () const = 0;
};

class IWildCard;
typedef ::Core::Var<IWildCard> IWildCard_var;
typedef ::Core::Var<const IWildCard> IWildCard_cvar;
// Интерфейс для шаблона
class IWildCard
	: virtual public ::Core::IObject
{
public:
	// получить множество удовлетворяющее шаблону
	virtual GCL::StrSet* get (const std::string& in) = 0;
};

} // namespace DBComm
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_DBCOMM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
