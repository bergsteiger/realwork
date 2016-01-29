////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/RelevancyCore/RelevancyUtility.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::ContextSearch::RelevancyCore::RelevancyUtility
//
// Утилитный пакет вспомогательных (для алгоритма вычисления релевантности) функций.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCYCORE_RELEVANCYUTILITY_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCYCORE_RELEVANCYUTILITY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Defs/Defs.h"

namespace ContextSearch {
namespace RelevancyUtility {

// Предикат сравнения релевантности фрагмента
struct RelevancyCompare : public std::unary_function<Defs::Fragment, bool> {
	bool operator () (const Defs::Fragment& param_) const;

	RelevancyCompare (Defs::RelevancyType value_);

private:
	Defs::RelevancyType value;
};

// Функтор получения позиций цепочки
struct ReceivePosition : public std::unary_function<Defs::Position, void> {
	void operator () (Defs::Position& param_) const;

	ReceivePosition (bool value_);

private:
	bool value;
};

// Свойства алгоритма релевантности
struct RelevancyProperties {
	// свойство упорядоченности слов в цепочке
	bool is_direct;
	// минимальная позиция в цепочке
	Defs::Position min;
	// максимальная позиция в цепочке
	Defs::Position max;
	// баллы за невидимый текст
	Defs::RelevancyType inv_factor;
	// счетчик особых позиций
	unsigned short marked;
	RelevancyProperties () : is_direct(true), inv_factor(0), marked(0) {
		//#UC START# *4A6593FD02B2_DEF_INIT_CTOR*
		//#UC END# *4A6593FD02B2_DEF_INIT_CTOR**cpp*
	}
};

// Компаратор для сравнения цепочек
struct CompareChains : public std::binary_function<Relevancy::Positions, Relevancy::Positions, bool> {
	bool operator () (const Relevancy::Positions& first_param_, const Relevancy::Positions& second_param_) const;

	CompareChains (size_t value_);

private:
	size_t value;
};

// Функтор для поиска блочной невидимой позиции
struct HasInvisibleBlock : public std::unary_function<Defs::Position, bool> {
	bool operator () (Defs::Position param_) const;
};

// Функтор для поиска невалидных цепочек
struct HasBadChain : public std::unary_function<Relevancy::Positions, bool> {
	bool operator () (const Relevancy::Positions& param_) const;
};

// сравнение масок
bool compare_mask_less (unsigned long x, unsigned long y);

// вычислить лучшую позицию в цепочке
Defs::Position get_position (const Relevancy::Positions& vect);

// сравнение векторов с позициями
bool compare_chain_less (const Relevancy::Positions& x, const Relevancy::Positions& y);


} // namespace RelevancyUtility
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCYCORE_RELEVANCYUTILITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
