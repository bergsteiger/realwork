////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/TemplateDumperDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::TemplateDumperDumper
//
// Псевдо дампер для доступа к описанию и свойствам текущего генератора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_TEMPLATEDUMPERDUMPER_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_TEMPLATEDUMPERDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"

//#UC START# *4571A39F0280_CUSTOM_INCLUDES*
//#UC END# *4571A39F0280_CUSTOM_INCLUDES*


// Псевдо дампер для доступа к описанию и свойствам текущего генератора
class TemplateDumperDumper;
typedef Core::Var<TemplateDumperDumper> TemplateDumperDumper_var;
typedef Core::Var<const TemplateDumperDumper> TemplateDumperDumper_cvar;

class TemplateDumperDumper :
	virtual public AbstractSingleDumperBase
{
	SET_OBJECT_COUNTER (TemplateDumperDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// принудительно сбрасываем кэш (пока самого кэша на модели нет)
	static void reset_dumpers_list ();

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~TemplateDumperDumper ();


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
	// возвращает мэйн элемент
	virtual AbstractDumperBase* get_main_element () const;

	// overloaded method from AbstractDumperBase
	// возвращает GUID элемента
	virtual const std::string& get_model_unique_id_str () const;

	// overloaded method from AbstractDumperBase
	// значение рутовой дирректории для генерации
	virtual const std::string get_root_dir (bool direct_get) const;

	// overloaded method from AbstractDumperBase
	// выводит значение пользовательского свойства «prop_name»
	virtual const std::string get_user_property_str (const std::string& prop_name) const;


//#UC START# *4571A39F0280*
public:
	//фабрика - возвращает дампер по заданному идентификатору, результат не нужно складывать в Var
	static TemplateDumperDumper* get_by_id (const std::string& gen_id);

	bool operator == (const AbstractDumperBase& c) const {
		return c.get_model_unique_id_str() == this->get_model_unique_id_str();		
	}

protected:
	// контейнер для хранения созданных экземпляров TemplateDumperDumper
	typedef std::map <std::string, Core::Var<TemplateDumperDumper> > TemplateDumperContainer;

	TemplateDumperDumper (std::string gen_id) {
		m_gen_id = gen_id;
	}

protected:
	std::string m_gen_id;	

// static member data
private:
	static TemplateDumperContainer s_dumpers;
//#UC END# *4571A39F0280*
}; // class TemplateDumperDumper



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_TEMPLATEDUMPERDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

