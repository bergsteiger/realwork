////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RenameParser_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::RenameParser_i
// Заголовок реализации класса серванта для интерфеса XMLRuleParser
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RENAMEPARSER_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RENAMEPARSER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ParameterParser.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

class RenameParser_i; // self forward Var
typedef ::Core::Var<RenameParser_i> RenameParser_i_var;
typedef ::Core::Var<const RenameParser_i> RenameParser_i_cvar;

class RenameParser_i_factory;

class RenameParser_i:
	virtual public IniConverter::XMLRuleParser
	, virtual public ::Core::RefCountObjectBase
	, virtual public ParameterParser
{
	SET_OBJECT_COUNTER (RenameParser_i)
	friend class RenameParser_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RenameParser_i (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node);

	virtual ~RenameParser_i ();
}; // class RenameParser_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RENAMEPARSER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
