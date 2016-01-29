////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> MDProcess::MDAModel
//
// библиотека классов отображающих элементы модели в элементы генерации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/lexical_cast.hpp"
#include "shared/Core/Params/Params.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/DebugFunc_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/DecToHex_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/DumpDiagram_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ElemCounter_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Error_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Evaluate_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/HasNonEmptyGen_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/IsKindOf_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaRootInternal_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaTypePath_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedDir_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedPath_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/SetGenID_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/SetProp_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftIntend_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftScope_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToBorland_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToJava_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToOmg_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToRGB_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/UpsToList_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Warning_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/WithGenID_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NumberCmp_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Exec_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/PrintStack_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileDrive_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileExtension_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileName_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileDir_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/CycleBreak_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/CutPostfix_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/CutPrefix_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromBegin_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromEnd_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/Prefix_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SplitToList_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrConv_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrReplace_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrSplit_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrToRule_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringFind_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringHash_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringLength_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromBegin_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromEnd_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/Suffix_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToLower_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToUpper_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToWideStr_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ConsistOf_factory.h"
#include "MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/CategoryImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/IsVirtualImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/PropertyHelperImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/ModelPropertiesHelperImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/TypeLinkHelperImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/ImplementedItemImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/OverloadedItemImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/ModelSearcherImpl_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddInheritable_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddClass_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddAttribute_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddParameter_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUp_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAppliedGen_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddImplement_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOverride_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetLinkType_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTargetStereotype_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetVisibilityType_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAbstractionType_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetImplementSelectType_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetOverloadSelectType_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPostUserCodeContent_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPreUserCodeContent_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDocumentation_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddCategory_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDefaultUC_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUserCodeContent_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyElement_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyUP_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetStereotype_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTarget_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveChild_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveInheritable_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveRealized_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddRealized_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/IsVirtual_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/MakeAccessable_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddDependency_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetGlobalLocally_factory.h"
#include "MDProcess/MDAModel/impl/ParsersImpl/OperationParserImpl_factory.h"
#include "MDProcess/MDAModel/impl/ParsersImpl/AttributeParserImpl_factory.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/ProgessIndicatorServiceImpl_factory.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/PageProxyImpl_factory.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/DefaultLogManagerImpl_factory.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/ErrorManagerImpl_factory.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/EnvironmentImpl_factory.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerTemplateOperationsImpl_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/AddToList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/ClearList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/CountInList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/CopyList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/ExistsInList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/IsEmpty_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/IsEqualList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/PopFirstToVar_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/PopLastToVar_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/RemoveFromList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SizeList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SortList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/UniqueList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SetVar_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/DelVar_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SetVar_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SubstractList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/ClearList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/AddToList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/RemoveFromList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SortList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/UniqueList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/IsEqual_factory.h"

namespace MDAModel {

namespace {
	template <typename T>
	bool check_param (const char* key, bool is_requared) {
		bool res = true;
		if (Core::ParamManagerFactory::get ().is_exist (key)) {
			std::string value = Core::ParamManagerFactory::get ().get_string (key);
			try {
				boost::lexical_cast<T> (value);
			} catch (boost::bad_lexical_cast&) {
				res = false;
				LOG_E (("Неверное значение параметра %s: %s", key, value.c_str ()));
			}
		} else if (is_requared) {
			res = false;
			LOG_E(("Не задан обязательный параметр: %s", key));
		}
		
		return res;
	}
	
	template <>
	bool check_param<std::string> (const char* key, bool is_requared) {
		if (is_requared && !Core::ParamManagerFactory::get ().is_exist (key)) {
			LOG_E(("Не задан обязательный параметр <%s>", key));
			return false;
		}
		return true;
	}
	
} //namespace

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4571A07300FA_ENVIRONMENTS_CONFIG*
	//#UC END# *4571A07300FA_ENVIRONMENTS_CONFIG*

	{
		SystemFunctionsImpl::DebugFunc_factory_var fctr = new SystemFunctionsImpl::DebugFunc_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::DecToHex_factory_var fctr = new SystemFunctionsImpl::DecToHex_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::DumpDiagram_factory_var fctr = new SystemFunctionsImpl::DumpDiagram_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::ElemCounter_factory_var fctr = new SystemFunctionsImpl::ElemCounter_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::Error_factory_var fctr = new SystemFunctionsImpl::Error_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::Evaluate_factory_var fctr = new SystemFunctionsImpl::Evaluate_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::HasNonEmptyGen_factory_var fctr = new SystemFunctionsImpl::HasNonEmptyGen_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::IsKindOf_factory_var fctr = new SystemFunctionsImpl::IsKindOf_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::JavaRootInternal_factory_var fctr = new SystemFunctionsImpl::JavaRootInternal_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::JavaTypePath_factory_var fctr = new SystemFunctionsImpl::JavaTypePath_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::NormolizedDir_factory_var fctr = new SystemFunctionsImpl::NormolizedDir_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::NormolizedPath_factory_var fctr = new SystemFunctionsImpl::NormolizedPath_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::SetGenID_factory_var fctr = new SystemFunctionsImpl::SetGenID_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::SetProp_factory_var fctr = new SystemFunctionsImpl::SetProp_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::ShiftIntend_factory_var fctr = new SystemFunctionsImpl::ShiftIntend_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::ShiftScope_factory_var fctr = new SystemFunctionsImpl::ShiftScope_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::ToBorland_factory_var fctr = new SystemFunctionsImpl::ToBorland_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::ToJava_factory_var fctr = new SystemFunctionsImpl::ToJava_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::ToOmg_factory_var fctr = new SystemFunctionsImpl::ToOmg_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::ToRGB_factory_var fctr = new SystemFunctionsImpl::ToRGB_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::UpsToList_factory_var fctr = new SystemFunctionsImpl::UpsToList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::Warning_factory_var fctr = new SystemFunctionsImpl::Warning_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::WithGenID_factory_var fctr = new SystemFunctionsImpl::WithGenID_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::NumberCmp_factory_var fctr = new SystemFunctionsImpl::NumberCmp_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::Exec_factory_var fctr = new SystemFunctionsImpl::Exec_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::PrintStack_factory_var fctr = new SystemFunctionsImpl::PrintStack_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::FileDrive_factory_var fctr = new SystemFunctionsImpl::FileDrive_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::FileExtension_factory_var fctr = new SystemFunctionsImpl::FileExtension_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::FileName_factory_var fctr = new SystemFunctionsImpl::FileName_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::FileDir_factory_var fctr = new SystemFunctionsImpl::FileDir_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SystemFunctionsImpl::CycleBreak_factory_var fctr = new SystemFunctionsImpl::CycleBreak_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::CutPostfix_factory_var fctr = new StrFunctionImpl::CutPostfix_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::CutPrefix_factory_var fctr = new StrFunctionImpl::CutPrefix_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::DelSubstrFromBegin_factory_var fctr = new StrFunctionImpl::DelSubstrFromBegin_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::DelSubstrFromEnd_factory_var fctr = new StrFunctionImpl::DelSubstrFromEnd_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::Prefix_factory_var fctr = new StrFunctionImpl::Prefix_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::SplitToList_factory_var fctr = new StrFunctionImpl::SplitToList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::StrConv_factory_var fctr = new StrFunctionImpl::StrConv_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::StrReplace_factory_var fctr = new StrFunctionImpl::StrReplace_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::StrSplit_factory_var fctr = new StrFunctionImpl::StrSplit_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::StrToRule_factory_var fctr = new StrFunctionImpl::StrToRule_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::StringCmp_factory_var fctr = new StrFunctionImpl::StringCmp_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::StringFind_factory_var fctr = new StrFunctionImpl::StringFind_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::StringHash_factory_var fctr = new StrFunctionImpl::StringHash_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::StringLength_factory_var fctr = new StrFunctionImpl::StringLength_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::SubstrFromBegin_factory_var fctr = new StrFunctionImpl::SubstrFromBegin_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::SubstrFromEnd_factory_var fctr = new StrFunctionImpl::SubstrFromEnd_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::Suffix_factory_var fctr = new StrFunctionImpl::Suffix_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::ToLower_factory_var fctr = new StrFunctionImpl::ToLower_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::ToUpper_factory_var fctr = new StrFunctionImpl::ToUpper_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::ToWideStr_factory_var fctr = new StrFunctionImpl::ToWideStr_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StrFunctionImpl::ConsistOf_factory_var fctr = new StrFunctionImpl::ConsistOf_factory ();
		fctr->registrate_me(0);
	}
	
	{
		MetadataFunctionsImpl::AddMetadatas_factory_var fctr = new MetadataFunctionsImpl::AddMetadatas_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RoseModelImpl::CategoryImpl_factory_var fctr = new RoseModelImpl::CategoryImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RoseModelImpl::IsVirtualImpl_factory_var fctr = new RoseModelImpl::IsVirtualImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RoseModelImpl::PropertyHelperImpl_factory_var fctr = new RoseModelImpl::PropertyHelperImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RoseModelImpl::ModelPropertiesHelperImpl_factory_var fctr = new RoseModelImpl::ModelPropertiesHelperImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RoseModelImpl::TypeLinkHelperImpl_factory_var fctr = new RoseModelImpl::TypeLinkHelperImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RoseModelImpl::InheritedItemHelperImpl_factory_var fctr = new RoseModelImpl::InheritedItemHelperImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RoseModelImpl::ImplementedItemImpl_factory_var fctr = new RoseModelImpl::ImplementedItemImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RoseModelImpl::OverloadedItemImpl_factory_var fctr = new RoseModelImpl::OverloadedItemImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RoseModelImpl::ModelSearcherImpl_factory_var fctr = new RoseModelImpl::ModelSearcherImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::AddInheritable_factory_var fctr = new VirtualElementsFuncionsImpl::AddInheritable_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::AddClass_factory_var fctr = new VirtualElementsFuncionsImpl::AddClass_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::AddOperation_factory_var fctr = new VirtualElementsFuncionsImpl::AddOperation_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::AddAttribute_factory_var fctr = new VirtualElementsFuncionsImpl::AddAttribute_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::AddParameter_factory_var fctr = new VirtualElementsFuncionsImpl::AddParameter_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetUp_factory_var fctr = new VirtualElementsFuncionsImpl::SetUp_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetAppliedGen_factory_var fctr = new VirtualElementsFuncionsImpl::SetAppliedGen_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::AddImplement_factory_var fctr = new VirtualElementsFuncionsImpl::AddImplement_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::AddOverride_factory_var fctr = new VirtualElementsFuncionsImpl::AddOverride_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetLinkType_factory_var fctr = new VirtualElementsFuncionsImpl::SetLinkType_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetTargetStereotype_factory_var fctr = new VirtualElementsFuncionsImpl::SetTargetStereotype_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetVisibilityType_factory_var fctr = new VirtualElementsFuncionsImpl::SetVisibilityType_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetAbstractionType_factory_var fctr = new VirtualElementsFuncionsImpl::SetAbstractionType_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetImplementSelectType_factory_var fctr = new VirtualElementsFuncionsImpl::SetImplementSelectType_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetOverloadSelectType_factory_var fctr = new VirtualElementsFuncionsImpl::SetOverloadSelectType_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetPostUserCodeContent_factory_var fctr = new VirtualElementsFuncionsImpl::SetPostUserCodeContent_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetPreUserCodeContent_factory_var fctr = new VirtualElementsFuncionsImpl::SetPreUserCodeContent_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetDocumentation_factory_var fctr = new VirtualElementsFuncionsImpl::SetDocumentation_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::AddCategory_factory_var fctr = new VirtualElementsFuncionsImpl::AddCategory_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetDefaultUC_factory_var fctr = new VirtualElementsFuncionsImpl::SetDefaultUC_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetUserCodeContent_factory_var fctr = new VirtualElementsFuncionsImpl::SetUserCodeContent_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::CopyElement_factory_var fctr = new VirtualElementsFuncionsImpl::CopyElement_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::CopyUP_factory_var fctr = new VirtualElementsFuncionsImpl::CopyUP_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetStereotype_factory_var fctr = new VirtualElementsFuncionsImpl::SetStereotype_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetTarget_factory_var fctr = new VirtualElementsFuncionsImpl::SetTarget_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::RemoveChild_factory_var fctr = new VirtualElementsFuncionsImpl::RemoveChild_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::RemoveInheritable_factory_var fctr = new VirtualElementsFuncionsImpl::RemoveInheritable_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::RemoveRealized_factory_var fctr = new VirtualElementsFuncionsImpl::RemoveRealized_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::AddRealized_factory_var fctr = new VirtualElementsFuncionsImpl::AddRealized_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::IsVirtual_factory_var fctr = new VirtualElementsFuncionsImpl::IsVirtual_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::MakeAccessable_factory_var fctr = new VirtualElementsFuncionsImpl::MakeAccessable_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::AddDependency_factory_var fctr = new VirtualElementsFuncionsImpl::AddDependency_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VirtualElementsFuncionsImpl::SetGlobalLocally_factory_var fctr = new VirtualElementsFuncionsImpl::SetGlobalLocally_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ParsersImpl::OperationParserImpl_factory_var fctr = new ParsersImpl::OperationParserImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ParsersImpl::AttributeParserImpl_factory_var fctr = new ParsersImpl::AttributeParserImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		GenSupportImpl::ProgessIndicatorServiceImpl_factory_var fctr = new GenSupportImpl::ProgessIndicatorServiceImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		GenSupportImpl::PageProxyImpl_factory_var fctr = new GenSupportImpl::PageProxyImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		GenSupportImpl::DefaultLogManagerImpl_factory_var fctr = new GenSupportImpl::DefaultLogManagerImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		GenSupportImpl::ErrorManagerImpl_factory_var fctr = new GenSupportImpl::ErrorManagerImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		GenSupportImpl::EnvironmentImpl_factory_var fctr = new GenSupportImpl::EnvironmentImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ContainerOperationsImpl::ContainerTemplateOperationsImpl_factory_var fctr = new ContainerOperationsImpl::ContainerTemplateOperationsImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::AddToList_factory_var fctr = new VarFunctionsImpl::AddToList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::ClearList_factory_var fctr = new VarFunctionsImpl::ClearList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::CountInList_factory_var fctr = new VarFunctionsImpl::CountInList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::CopyList_factory_var fctr = new VarFunctionsImpl::CopyList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::ExistsInList_factory_var fctr = new VarFunctionsImpl::ExistsInList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::IsEmpty_factory_var fctr = new VarFunctionsImpl::IsEmpty_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::IsEqualList_factory_var fctr = new VarFunctionsImpl::IsEqualList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::PopFirstToVar_factory_var fctr = new VarFunctionsImpl::PopFirstToVar_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::PopLastToVar_factory_var fctr = new VarFunctionsImpl::PopLastToVar_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::RemoveFromList_factory_var fctr = new VarFunctionsImpl::RemoveFromList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::SizeList_factory_var fctr = new VarFunctionsImpl::SizeList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::SortList_factory_var fctr = new VarFunctionsImpl::SortList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::UniqueList_factory_var fctr = new VarFunctionsImpl::UniqueList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::SetVar_factory_var fctr = new VarFunctionsImpl::SetVar_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::DelVar_factory_var fctr = new VarFunctionsImpl::DelVar_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VarFunctionsImpl::FindElement_factory_var fctr = new VarFunctionsImpl::FindElement_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StereotypeFunctionsImpl::SetVar_factory_var fctr = new StereotypeFunctionsImpl::SetVar_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StereotypeFunctionsImpl::SubstractList_factory_var fctr = new StereotypeFunctionsImpl::SubstractList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StereotypeFunctionsImpl::ClearList_factory_var fctr = new StereotypeFunctionsImpl::ClearList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StereotypeFunctionsImpl::AddToList_factory_var fctr = new StereotypeFunctionsImpl::AddToList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StereotypeFunctionsImpl::RemoveFromList_factory_var fctr = new StereotypeFunctionsImpl::RemoveFromList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StereotypeFunctionsImpl::SortList_factory_var fctr = new StereotypeFunctionsImpl::SortList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StereotypeFunctionsImpl::UniqueList_factory_var fctr = new StereotypeFunctionsImpl::UniqueList_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StereotypeFunctionsImpl::IsEqual_factory_var fctr = new StereotypeFunctionsImpl::IsEqual_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
	
void LibHomeImpl::print_usage () const {
	std::cout << "-lock_strategy: (unsignedlong)= 0\n";
	std::cout << "-enable_spell_explicit_call_logging: (boolean) - включить логирование\n";
	std::cout << "                         явного вызова спелл генератора\n";
	std::cout << "                         = false\n";
	std::cout << "-scold_if_call_tpl_function_on_null: (boolean) - Ругаться ли, если в\n";
	std::cout << "                         шаблоне вызывают функцию на несуществующем\n";
	std::cout << "                         элементе\n";
	std::cout << "                         = false\n";
	std::cout << "-overwrite_creation_order_property: (boolean) - перезаписать свойство,\n";
	std::cout << "                         определяющее порядковый номер элементов (время\n";
	std::cout << "                         генерации)\n";
	std::cout << "                         = false\n";
	std::cout << "-TemplatesDir: (string)= C:\\Program Files\\Rational\\Rose\\Garant\\MDAGenerator\\templates\\\n";
	std::cout << "-ImageDir: (string)= C:\\Program Files\\Rational\\Rose\\Garant\\MDAGenerator\\images\\\n";
	std::cout << "-PathComponentToControl: (string) - часть пути файле сохранённой модели,\n";
	std::cout << "                         при наличии которой выполняется автоматическая\n";
	std::cout << "                         выливка пакетов в cat-ы\n";
	std::cout << "                         = shared\\models\n";

}

bool LibHomeImpl::check_params () const {
	bool res = check_param<unsigned long> ("-lock_strategy", false);
	res &= check_param<unsigned long> ("-enable_spell_explicit_call_logging", false);
	res &= check_param<unsigned long> ("-scold_if_call_tpl_function_on_null", false);
	res &= check_param<unsigned long> ("-overwrite_creation_order_property", false);
	res &= check_param<std::string> ("-TemplatesDir", false);
	res &= check_param<std::string> ("-ImageDir", false);
	res &= check_param<std::string> ("-PathComponentToControl", false);

	return res;
}
} // namespace MDAModel

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
