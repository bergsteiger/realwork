////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/MDACommands/DblClickActionImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::MDACommands::DblClickActionImpl
//
// действие на дабл-клик
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/MDACommands/DblClickActionImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAAddinLib/CommonViews/ChoiceDialog.h"
#include "MDProcess/MDAAddinLib/impl/MDACommands/ActionSettings.h"

namespace MDACommands {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DblClickActionImpl::DblClickActionImpl ()
//#UC START# *480323260316_480323740072_46FB3844007D_BASE_INIT*
//#UC END# *480323260316_480323740072_46FB3844007D_BASE_INIT*
{
	//#UC START# *480323260316_480323740072_46FB3844007D_BODY*
	//#UC END# *480323260316_480323740072_46FB3844007D_BODY*
}

DblClickActionImpl::~DblClickActionImpl () {
	//#UC START# *46FB3844007D_DESTR_BODY*
	//#UC END# *46FB3844007D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// вспомогательный метод для показа дилога выбора конкретного действия
void DblClickActionImpl::ask (IRoseElementPtr elem) {
	//#UC START# *46FB39AC00FA*
	GCL::StrSet selections;
	std::string open_prop ("Открыть свойства");
	std::string open_create_diag ("Открыть/создать диаграмму");
	selections.insert (open_prop);
	selections.insert (open_create_diag);
	ChoiceDialog choice ("Выбор действия", selections);
	if (choice.DoModal () == IDOK) {
		std::string res = choice.get_selection ();
		if (res == open_prop) {
			Commands::CmdManagerFactory::get ().properties (elem, false, true);
		} else if (res == open_create_diag) {
			this->open_create_diag (elem);
		}
	}
	//#UC END# *46FB39AC00FA*
}

// вспомогательный метод, пытается активировать диаграмму элемента, если диаграммы для элемента нет
// - создаёт её
void DblClickActionImpl::open_create_diag (IRoseElementPtr elem) {
	//#UC START# *46FB3A4800BB*
	//IRoseDiagramCollectionPtr diags = RoseHelper::get_diagrams (elem);
	/*if (elem->IsClass (CLASS_TYPE)) {
		diags = RoseHelper::get_class_diagrams (elem);
	} else if (elem->IsClass (CATEGORY_TYPE)) {
		diags = ((IRoseCategoryPtr)elem)->ClassDiagrams;
	}*/
	/*IRoseDiagramPtr diag;
	if (diags && diags->Count > 0) {
		diag = diags->GetAt (1);
	}
	if (diag == 0) {
		diag = Commands::CmdManagerFactory::get ().new_class_diagram (elem, "Main");
	}
	if (diag) {			
		diag->Activate ();
	}*/
	if (open_diag (elem) == false) {
		IRoseDiagramPtr diag = Commands::CmdManagerFactory::get ().new_class_diagram (elem, "Main");
		if (diag) {			
			diag->Activate ();
		}
	}
	//#UC END# *46FB3A4800BB*
}

// вспомогательный метод для активиции диаграммы
// возвращает rue, если диаграмма для элемента найдена и активированна, иначе - false
bool DblClickActionImpl::open_diag (IRoseElementPtr elem) {
	//#UC START# *46FB39F90290*
	bool res = false;
	/*IRoseClassDiagramCollectionPtr diags;
	if (elem->IsClass (CLASS_TYPE)) {
		diags = RoseHelper::get_class_diagrams (elem);
	} else if (elem->IsClass (CATEGORY_TYPE)) {
		diags = ((IRoseCategoryPtr)elem)->ClassDiagrams;
	}*/
	IRoseDiagramCollectionPtr diags = RoseHelper::get_diagrams (elem);
	IRoseDiagramPtr diag;
	if (diags && diags->Count > 0) {
		diag = diags->GetAt (1);
	}
	if (diag) {			
		diag->Activate ();
		res = true;
	}
	return res;
	//#UC END# *46FB39F90290*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Commands::DblClickAction
// выполняет действие
void DblClickActionImpl::action (IRoseElementPtr elem) {
	//#UC START# *4803236B0028_46FB3844007D*

	ActionID action;
	if (elem->IsClass (CLASS_TYPE)) {
		std::string action_str = ActionSettings::get_class_dbl_click_action();
		try {
			action = ActionIDConvertorSingleton::instance ()->get (action_str);
		} catch (Core::ElementNotFound&) {
			LOG_E (("Unknown action %s", action_str.c_str ()));			
		}
	} else if (elem->IsClass (CATEGORY_TYPE)) {
		std::string action_str = ActionSettings::get_package_dbl_click_action();
		try {
			action = ActionIDConvertorSingleton::instance ()->get (action_str);
		} catch (Core::ElementNotFound&) {
			LOG_E (("Unknown action %s", action_str.c_str ()));		
		}
	} else if (elem->IsClass ("DependencyRelation")) {
		action = OPEN_PROPERTIES;
	} else {
		std::string caption ("Неопределено действие для: ");
		caption += elem->IdentifyClass ();

		std::string text ("Для данного типа объектов не поддерживается\nспециальная реакция на double-click");
		::MessageBox (
			0, text.c_str (), caption.c_str (), MB_OK | MB_ICONERROR
		);
		return;
	}
	switch (action) {
		case OPEN_PROPERTIES: {
			Commands::CmdManagerFactory::get ().properties (elem, false, true);
			break;
		}
		case OPEN_DIAGRAM: {
			this->open_create_diag (elem);
			break;
		}
		case ALWAYS_ASK: {
			this->ask (elem);
			break;
		}
		case OPEN_DIAGRAM_IF_EXISTS_ELSE_PROPERTIES: {
			if (this->open_diag (elem) == false) {
				Commands::CmdManagerFactory::get ().properties (elem, false, true);
			}
			break;
		}
		case OPEN_DIAGRAM_IF_EXISTS_ELSE_ASK: {
			if (this->open_diag (elem) == false) {				
				this->ask (elem);
			}
			break;
		}
	}
	//#UC END# *4803236B0028_46FB3844007D*
}
} // namespace MDACommands

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

