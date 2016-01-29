////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseCopyHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseDumpers::RoseCopyHelper
//
// набор вспомогательных функций для копирования элементов Розы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSECOPYHELPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSECOPYHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

namespace RoseCopyHelper {

// метод для копирования атрибута - в результате dest - полная копия source с тем же стереотипом,
// видимостью и т.д, НО - это другой объект
void copy (IRoseAttributePtr source, IRoseAttributePtr& dest, bool copy_for_relocate);

// метод для копирования  операции - в результате dest - полная копия source с тем же стереотипом,
// видимостью и т.д, НО - это другой объект
void copy (IRoseOperationPtr source, IRoseOperationPtr& dest, bool copy_for_relocate);

// копируем все mda-свойства элемента (списки исключений, юзер-свойства и т.д)
void copy_mda_property (IRoseElementPtr source, IRoseElementPtr& dest, bool copy_for_relocate);


} // namespace RoseCopyHelper


#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSECOPYHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
