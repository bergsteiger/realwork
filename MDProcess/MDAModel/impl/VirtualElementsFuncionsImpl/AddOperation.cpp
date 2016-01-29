////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddOperation
//
// 1. %S%f_add_operation(<GUID нового элемента>,<стереотип>, <имя операции>,<тип результата>,<имя
// переменной>) - создает новый элемент - операцию с заданным именем и стереотипом, сохраняет его в
// переменной и добавляет как ребенка к текущему элементу, тип операции задается либо ГУИДОМ
// существующего элемента, либо просто именем типа - в этом случае в дереве будет искаться элемент
// с таким именем.
// 2. %S%f_add_operation(<GUID нового элемента>, <стереотип>,<имя опреации с парметрами и
// результатом>,<имя переменной>) - создает новый элемент - операцию имя операции тип результата, а
// также параметры задаются вторым параметром, в формате: <имя операции> (<спецификатор параметра>
// <имя параметра> : <тип параметра (GUID или строка) = <значение по умолчанию (GUID или
// строка)>>):<GUID или имя возвращемого параметра>
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseOperationImpl.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
#include "boost/regex.hpp"
#include "MDProcess/MDAModel/Parsers/Parsers.h"
#include "MDProcess/MDAModel/RoseInternal/RoseParameterImpl.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddOperation::AddOperation ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFE4F0383_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFE4F0383_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFE4F0383_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFE4F0383_BODY*
}

AddOperation::~AddOperation () {
	//#UC START# *4A2DFE4F0383_DESTR_BODY*
	//#UC END# *4A2DFE4F0383_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// создает новый элемент - операцию с заданным именем и стереотипом, сохраняет его в переменной и
// добавляет как ребенка к текущему элементу, тип операции задается либо ГУИДОМ существующего
// элемента, либо просто именем типа - в этом случае в дереве будет искаться элемент с таким именем.
const std::string AddOperation::create_operation (
	const RoseAbstractDumper* parent
	, const std::string& guid_suffix
	, const std::string& name
	, const std::string& stereotype
	, const std::string& result
	, const std::string& var_id
	, TemplatePainter* painter
) const {
	//#UC START# *4A3881E70076*
	std::string guid  (this->make_uid (parent, "", guid_suffix));
	GDS_ASSERT(parent);
	ATL::CComObject<RoseInternal::RoseOperationImpl>* obj;
	obj->CreateInstance (&obj);
	IRoseOperationPtr op;
	obj->QueryInterface (&op);

	IRoseItemPtr item = parent->rose_element ();
	if (item) {
		obj->set_unique_id (guid);
		obj->set_stereotype (stereotype);
		obj->set_name (name);
		obj->set_context (item);

		RoseAbstractDumper* target_rad = RoseAbstractDumper::find_in_tree (result);
		if (target_rad) {
			obj->set_target_class (target_rad->rose_element ());
		} else {
			obj->set_target (result);
		}

		IRoseClassPtr cls = obj->get_target_class ();
		if (cls) {
			TypeLinkHelperFactory::get ().link (op, get_rose_element_uid (cls));
		}

		RoseHelper::set_default_abstraction_type (op);

		Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
		RoseAbstractDumper::set_dumper_factory (df.in());

		RoseAbstractDumper* new_op = df->create_by_stereotype (parent, op);
		if (new_op) {
			RoseAbstractDumper::add_virtual_dumper (new_op, painter->get_main_scope ());
			new_op->link_all_suppliers ();
			TemplatePainter::set_var_dumper (var_id, new_op);
			parent->set_var_dumper (guid_suffix, new_op);
		} else {
			throw Base::FatalError ("Creation virtual Operation failed");
		}
	}

	return std::string ();
	//#UC END# *4A3881E70076*
}

// создает новый элемент - операцию имя операции тип результата, а также параметры задаются вторым
// параметром, в формате: <имя операции> (<спецификатор параметра> <имя параметра> : <тип параметра
// (GUID или строка) = <значение по умолчанию (GUID или строка)>>):<GUID или имя возвращемого
// параметра>
const std::string AddOperation::create_operation (
	const RoseAbstractDumper* parent
	, const std::string& guid_suffix
	, const std::string& signature
	, const std::string& stereotype
	, const std::string& var_id
	, TemplatePainter* painter
) const {
	//#UC START# *4A38853D0229*
	GDS_ASSERT(parent);

	std::string guid  (this->make_uid (parent, "", guid_suffix));

	ATL::CComObject<RoseInternal::RoseOperationImpl>* obj;
	obj->CreateInstance (&obj);
	IRoseOperationPtr op;
	obj->QueryInterface (&op);

	IRoseItemPtr item = parent->rose_element ();
	if (item) {
		obj->set_unique_id (guid);
		obj->set_stereotype (stereotype);
		obj->set_context (item);

		try {
			Core::Aptr<Parsers::OperationData> op_data = Parsers::OperationParserFactory::get ().parse (signature);
			obj->set_name (op_data->name);
			
			IRoseApplicationPtr app = item->GetApplication ();
			obj->set_application (app);

			RoseAbstractDumper* target_rad = RoseAbstractDumper::find_in_tree (op_data->return_type);
			if (target_rad) {
				obj->set_target_class (target_rad->rose_element ());
			} else {
				obj->set_target (op_data->return_type);
			}
			
			IRoseClassPtr cls = obj->get_target_class ();
			if (cls) {
				TypeLinkHelperFactory::get ().link (op, get_rose_element_uid (cls));
			}

			RoseHelper::set_default_abstraction_type (op);

			Parsers::AttributeDataVector::const_iterator it = op_data->parameters.begin ();
			Parsers::AttributeDataVector::const_iterator end = op_data->parameters.end ();
			
			char i = 0;
			
			static const std::string sVIRT_PARAM_PREFIX = "VPARAM";
			for (; it != end; ++it, ++i) {
				ATL::CComObject<RoseInternal::RoseParameterImpl>* param;
				param->CreateInstance (&param);
				IRoseParameterPtr parameter;
				param->QueryInterface (&parameter);

				param->set_context (op);
				std::string param_uid = guid + sVIRT_PARAM_PREFIX;
				param_uid += i;
				
				param->set_unique_id (param_uid);
				param->set_application (app);
				param->set_name (it->name);
				
				RoseAbstractDumper* param_target_rad = RoseAbstractDumper::find_in_tree (it->type);
				if (param_target_rad) {
					param->set_target_class (param_target_rad->rose_element ());
				} else {
					param->set_target (it->type);
				}
				
				IRoseClassPtr param_cls = param->get_target_class ();
				if (param_cls) {
					TypeLinkHelperFactory::get ().link (parameter, get_rose_element_uid (param_cls));
				}

				param->set_initial_value (it->init_value);

				obj->add_parameter (parameter);
			}

			Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
			RoseAbstractDumper::set_dumper_factory (df.in());
			
			RoseAbstractDumper* new_op = df->create_by_stereotype (parent, op);
			if (new_op) {
				painter->invalidate_dumpers_list (SX_3_CONTENTS, parent);
				painter->invalidate_dumpers_list (SX_3_ALL_CONTENTS, parent);

				RoseAbstractDumper::add_virtual_dumper (new_op, painter->get_main_scope ());
				new_op->link_all_suppliers ();
				TemplatePainter::set_var_dumper (var_id, new_op);
				parent->set_var_dumper (guid_suffix, new_op);
			} else {
				throw Base::FatalError ("Creation virtual Operation failed");
			}
		} catch (Parsers::ParseError& ex) {
			throw Base::FatalError (ex.what ());
		}
	}

	return std::string ();
	//#UC END# *4A38853D0229*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string AddOperation::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A2DFE4F0383*
	if (params.size () < 4) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 4, params.size ());
	}
	
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (self);
	if (rad) {
		std::string guid_suffix = TemplatePainter::resolve_exp (params[0], painter);

		std::string stereotype = TemplatePainter::resolve_exp (params[1], painter);
		std::string signature = TemplatePainter::resolve_exp (params[2], painter);
		std::string param3 = TemplatePainter::resolve_exp (params[3], painter);		
		if (params.size () == 5) {
			std::string var_id = TemplatePainter::resolve_exp (params[3], painter);
			return this->create_operation (rad, guid_suffix, signature, stereotype, param3, var_id, painter);
		} else {
			return this->create_operation (rad, guid_suffix, signature, stereotype, param3, painter);
		}
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4A2DFE4F0383*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

