////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/shared/ContextSearch/impl/Relevancy_i/Algorithm_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::Algorithm_i
// «аголовок реализации класса серванта дл€ интерфеса IAlgorithm
//
// —ервант реализующий алгоритм расчета релевантности
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHM_I_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHM_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Defs/Defs.h"
#include "shared/ContextSearch/RelevancyCore/RelevancyCore.h"

namespace ContextSearch {
namespace Relevancy_i {

class Algorithm_i; // self forward Var
typedef ::Core::Var<Algorithm_i> Algorithm_i_var;
typedef ::Core::Var<const Algorithm_i> Algorithm_i_cvar;

class Algorithm_i_factory;

// —ервант реализующий алгоритм расчета релевантности
class Algorithm_i:
	virtual public Relevancy::IAlgorithm
	, virtual public ::Core::RefCountObjectBase
	, virtual public RelevancyCore
{
	SET_OBJECT_COUNTER (Algorithm_i)
	friend class Algorithm_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// √енератор дополнительных цепочек
	class ExtChainsGenerator {
		SET_OBJECT_COUNTER (ExtChainsGenerator)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		ExtChainsGenerator ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// генерировать новую цепочку
		void generate (Defs::Position x_val, Defs::Position x_pos, Defs::Position y_val, Defs::Position y_pos);

		// генерировать новую цепочку
		void generate (const Relevancy::Positions& data, Defs::Position val, Defs::Position pos, bool check_identical);

		// инициализаци€
		void init (size_t count);

		// смерджить цепочки
		void merge (RelevancyCore::Chains& out);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		Relevancy::Positions m_def_chain;

		RelevancyCore::Chains m_ext_chains;

		size_t m_offset;
	}; // class ExtChainsGenerator

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// получить позиции дл€ заданного блока
	static bool get_block_positions (const Relevancy::DataVector& in, const Defs::InvisibleData& inv_data, Relevancy::DataVector& out, Defs::Position mask, size_t point);

	// определение наименее встречающегос€ в блоке слова (позици€ в запросе)
	static size_t get_point (const Relevancy::DataVector& in, size_t block_point);

	// добавить позицию в цепочку
	static void put (Relevancy::Positions& data, size_t pos, Defs::Position value);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Algorithm_i (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties);

	virtual ~Algorithm_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// сделать цепочку не валидной
	void chain_destruction (Relevancy::Positions& out);

	// проверка на существование невидимой блочной позиции
	bool has_block_position (const Relevancy::DataVector& positions);

	// инициализаци€ контейнера цепочек
	void init (const Relevancy::Positions& vect, RelevancyCore::Chains& chains, size_t count);

	// вычисление оптимальных позиций и добавление их к цепочкам
	bool intersection (
		const Relevancy::Positions& vect
		, const Relevancy::IntersectProp& prop
		, Defs::Position pos
		, RelevancyCore::Chains& chains
	);

	// генераци€ перестановок
	bool intersection (
		const Relevancy::Positions& vect
		, const Relevancy::IntersectProp& prop
		, Defs::Position pos
		, Defs::Position min_pos
		, RelevancyCore::Chains& chains
	);

	// генератор цепочек прив€зынных к невидимому блочному тексту
	bool make_block_chains (const Relevancy::DataVector& positions, const Defs::InvisibleData& inv_data);

	// генераци€ контейнера цепочек
	bool make_chains (const Relevancy::DataVector& positions);

	// инициализаци€ вектора, задающего пор€док обхода слов
	void set_direction (size_t count);

	// вычисление устойчивых позиций и добавление их к цепочкам
	bool strong_intersection (
		const Relevancy::Positions& vect
		, const Relevancy::IntersectProp& prop
		, Defs::Position pos
		, RelevancyCore::Chains& chains
		, bool is_frame
	);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ExtChainsGenerator m_ext_chains_generator;

	unsigned long m_ext_fragment;

	Defs::InvisibleData m_fake;

	Relevancy::Positions m_frames;

	// максимальна€ длина фрагмента рамочного словосочетани€
	size_t m_max_frame_len;

	size_t m_point;

	Relevancy::Positions m_positions;

	Relevancy::Positions m_strongs;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Relevancy::IAlgorithm
	// сбросить свойство
	virtual void clear_property (unsigned long value);

	// implemented method from Relevancy::IAlgorithm
	// получить список релевантных фрагментов приписанных к блочному невидимому тексту
	virtual Relevancy::Fragments* get_block_fragments (
		const Relevancy::DataVector& positions
		, const Defs::InvisibleData& inv_data
	);

	// implemented method from Relevancy::IAlgorithm
	// получить список релевантных фрагментов
	virtual Relevancy::Fragments* get_fragments (const Relevancy::DataVector& positions);

	// implemented method from Relevancy::IAlgorithm
	// расчет релевантности дл€ невидимого блочного
	virtual void get_inv_block_relevancy (
		Defs::RelevancyInfo& info
		, const Relevancy::DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
	);

	// implemented method from Relevancy::IAlgorithm
	// расчет релевантности
	virtual void get_relevancy_info (
		Defs::RelevancyInfo& info
		, const Relevancy::DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
		, bool has_block
	);

	// implemented method from Relevancy::IAlgorithm
	// установить свойство
	virtual void set_property (unsigned long value);
}; // class Algorithm_i

} // namespace Relevancy_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
