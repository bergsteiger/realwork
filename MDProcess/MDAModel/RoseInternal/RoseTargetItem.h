////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseTargetItem.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseTargetItem
//
// базовый класс для всех элементов, имеющих цель (атрибут, операция параметр)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSETARGETITEM_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSETARGETITEM_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseInternal/RoseItem.h"

namespace RoseInternal {

// базовый класс для всех элементов, имеющих цель (атрибут, операция параметр)
class RoseTargetItem :
	virtual public RoseItem
{
	SET_OBJECT_COUNTER (RoseTargetItem)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseTargetItem ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_target;

	IRoseClassPtr m_target_class;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_target () const;

	void set_target (const std::string& target);

	IRoseClassPtr get_target_class () const;

	void set_target_class (IRoseClassPtr target_class);
}; // class RoseTargetItem

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSETARGETITEM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

