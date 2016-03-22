////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/DBCommunicator_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::DBCommunicator_i
//
// Реализация интерфейса коммуникации с хранилищем
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_DBCOMMUNICATOR_I_H__
#define __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_DBCOMMUNICATOR_I_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Defs/Defs.h"
#include "shared/DB/DBCore/DBCore.h"

namespace SearchAdapterLib {
namespace DBComm_i {

// Реализация интерфейса коммуникации с хранилищем
class DBCommunicator_i;
typedef Core::Var<DBCommunicator_i> DBCommunicator_i_var;
typedef Core::Var<const DBCommunicator_i> DBCommunicator_i_cvar;

class DBCommunicator_i :
	virtual public ContextSearch::DBComm::IDBCommunicator
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DBCommunicator_i)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Ключ для синонимов
	struct SynKey {
		// значение
		std::string key;
		// порядковый номер
		size_t i;
		//#UC START# *535A2A490135*
		bool operator < (const SynKey& val) const {
			if (key.size () == val.key.size ()) {
				return key [0] < val.key [0];
			}
			return key.size () > val.key.size ();
		}
		//#UC END# *535A2A490135*
	};

	// Список синонимичных ключей
	typedef std::vector < SynKey > SynKeys;

	// Список значений синонимов
	typedef std::vector < GCL::StrVector > SynValues;

	// Функтор сравнения синонимичных шаблонов
	struct PatternCompare : public std::binary_function<SynKey, SynKey, bool> {
		bool operator () (const SynKey& first_param_, const SynKey& second_param_) const;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// инициализация вектора строк
	static void init_str_vector (const char* buf, size_t size, GCL::StrVector& out);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit DBCommunicator_i (DBCore::IBase* base);

public:
	virtual ~DBCommunicator_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// дамп
	void dump ();

	// загрузка синонимов
	void init_syns (const char* buf, size_t size, SynKeys& keys, SynValues& data);

	// загрузка шаблонов частей речи
	void load_PSD_templates (DBCore::IIndex* index);

	// загрузка длин блоков, приписанных к позициям из невидимого текста
	void load_blocks_lengths (DBCore::IIndex* index);

	// загрузка стоп-слов и стоп-фраз
	void load_exclude_data (DBCore::IIndex* index);

	// загрузка строгих фраз
	void load_hard_phrases (DBCore::IIndex* index);

	// загрузка индекса для невидимых блочных
	void load_invb_index (DBCore::IIndex* index);

	// загрузка значений релевантности для обычного невидимого текста
	void load_invisible_rel (DBCore::IIndex* index);

	// загрузка словаря фразальных замен
	void load_phrasal_replacement (DBCore::IIndex* index);

	// загрузка однословных синонимов
	void load_ssyns (DBCore::IIndex* index);

	// загрузка синонимов
	void load_syns (DBCore::IIndex* index);

	// загрузка данных для алгоритма модификации значений релевантности
	void load_tune_data (DBCore::IIndex* index);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCL::StrVector m_excluded;

	GCL::StrVector m_hard_phrases;

	ContextSearch::DBComm::InvisibleDataIndex m_invb_index;

	ContextSearch::Defs::InvisibleBlocks m_invisible_blocks;

	ContextSearch::Defs::InvisibleRel m_invisible_rel;

	ContextSearch::DBComm::StrPairVector m_phrasal_pair;

	ContextSearch::DBComm::Synonyms m_ssyns;

	ContextSearch::DBComm::Synonyms m_syns;

	DBCore::PSDTemplates m_templates;

	ContextSearch::DBComm::Synonyms m_templates_syns;

	DBCore::RelTuneData m_tune_data;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// стоп-слова и стоп-фразы
	virtual const GCL::StrVector& get_exclude_data () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// устойчивые словосочетания
	virtual const GCL::StrVector& get_hard_phrases () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// индекс с невидимыми блочными
	virtual const ContextSearch::DBComm::InvisibleDataIndex& get_invb_index () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// длины блоков приписанных к позициям из невидимого текста
	virtual const ContextSearch::Defs::InvisibleBlocks& get_invisible_blocks () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// "баллы релевантности" для позиций из простого невидимого текста документа
	virtual const ContextSearch::Defs::InvisibleRel& get_invisible_rel () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// фразальные замены
	virtual const ContextSearch::DBComm::StrPairVector& get_phrasal_replacement () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// однословные синонимы
	virtual const ContextSearch::DBComm::Synonyms& get_ssyns () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// синонимы
	virtual const ContextSearch::DBComm::Synonyms& get_syns () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// шаблоны частиречных связей
	virtual const DBCore::PSDTemplates& get_templates () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// шаблонные синонимы
	virtual const ContextSearch::DBComm::Synonyms& get_templates_syns () const;

	// implemented method from ContextSearch::DBComm::IDBCommunicator
	// данные для алгоритма модификации значений релевантности
	virtual const DBCore::RelTuneData& get_tune_data () const;
}; // class DBCommunicator_i

} // namespace DBComm_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_DBCOMMUNICATOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

