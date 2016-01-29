////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseDiagramDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseDiagramDumper
//
// Дампер для розовских диаграмм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEDIAGRAMDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEDIAGRAMDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include <ostream>
#include "ximage.h"

//#UC START# *4571DFB400FA_CUSTOM_INCLUDES*
//#UC END# *4571DFB400FA_CUSTOM_INCLUDES*


// Дампер для розовских диаграмм
class RoseDiagramDumper;
typedef Core::Var<RoseDiagramDumper> RoseDiagramDumper_var;
typedef Core::Var<const RoseDiagramDumper> RoseDiagramDumper_cvar;

class RoseDiagramDumper :
	public AbstractSingleDumperBase
{
	SET_OBJECT_COUNTER (RoseDiagramDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// метод дампит всю информацию, связанную с view (элементом на диграмме) в
	// поток stream
	static void dump_item_view (IRoseItemViewPtr view, std::ostream& stream);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// ctor
	explicit RoseDiagramDumper (IRoseDiagramPtr diag);

public:
	virtual ~RoseDiagramDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// сохраняет диграмму в виде картинке, с зум-фактором = 100 и выполняет при необходимости ресайз,
	// чтобы картинка уместилась по ширине в 1200 пикселей
	virtual CxImage* create_image () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IRoseDiagramPtr m_diag;

	// хранит результат вызова IdentifyClass ()
	std::string m_model_class_str;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// возвращает имя
	virtual const std::string get_name_str () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumperBase
	// метод дампит диаграмму, возвращает диаграму в виде куска памяти.
	// items - коллекция элементов даграммы, для формирования навигационной мапы
	// diagram_hash - хэш диаграммы, высчитывается на основе всех view - элементов на диграмме
	virtual CxMemFile* dump_diagram (AbstractDumperBase::DiagramItemCollection& items, std::string& diagram_hash) const;

	// overloaded method from AbstractDumperBase
	// возвращает класс
	virtual const std::string get_model_class_str () const;

	// overloaded method from AbstractDumperBase
	// стереотип на модели (VCMModule, CORBAInterface::operation, ...)
	virtual const AbstractDumperBase::StereotypeID& get_model_stereotype_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает GUID элемента
	virtual const std::string& get_model_unique_id_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает true, если элемент был изменён (используется дл определения того, что диаграмма была
	// изменена)
	virtual bool is_changed () const;

	// overloaded method from AbstractDumperBase
	// сбрасывает информацию об изменённости
	virtual void reset_changed () const;


//#UC START# *4571DFB400FA*
public:	
	bool operator == (const AbstractDumperBase& c) const;

protected:	
	virtual void dump (std::ostream* output = NULL) const;

private:
	AbstractDumperBase::StereotypeID m_model_stereotype_id;
//#UC END# *4571DFB400FA*
}; // class RoseDiagramDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEDIAGRAMDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

