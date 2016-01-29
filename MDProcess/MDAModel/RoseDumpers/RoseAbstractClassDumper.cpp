////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractClassDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractClassDumper
//
// Дампер для Розовских классов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractClassDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseDiagramDumper.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571DD3D03D8_CUSTOM_INCLUDES*
//#UC END# *4571DD3D03D8_CUSTOM_INCLUDES*


//#UC START# *4571DD3D03D8*
RoseAbstractClassDumper::RoseAbstractClassDumper (const RoseAbstractDumper* parent, IRoseClassPtr cls ) 
	: RoseAbstractDumper (parent, cls, AbstractDumperBase::StereotypeID ("")) 
{
	try {	

		int i;
		// ops	
		IRoseClassCollectionPtr classes = cls->GetNestedClasses();
		int classes_count = classes->Count;
		for (i = 1; i <= classes_count; i++) {
			IRoseClassPtr cls = classes->GetAt(i);
			RoseAbstractDumper::dump_factory()->create_by_stereotype (this, cls);			
		}

		IRoseAttributeCollectionPtr attrs = cls->Attributes;
		int attrs_count = attrs->Count;
		for (i = 1; i <= attrs_count; i++) {		
			IRoseAttributePtr attr = attrs->GetAt(i);
			RoseAbstractDumper::dump_factory()->create_by_stereotype (this, attr);
		}

		IRoseRoleCollectionPtr rl_attrs = cls->GetAssociateRoles();
		int rl_attrs_count = rl_attrs->Count;
		for (i = 1; i <= rl_attrs_count; i++) {
			IRoseRolePtr rl_attr = rl_attrs->GetAt(i);
			if (
				rl_attr->HasSupplier () //проверяем, что связь к чему-то идёт, иначе нет смысла её добавлять в дерево
				&& RoseHelper::is_attribute_role (rl_attr)
			) {
				RoseAbstractDumper::dump_factory()->create_by_stereotype (this, rl_attr);
			}
		}

		IRoseOperationCollectionPtr ops = cls->Operations;
		int ops_count = ops->Count;
		for (i = 1; i <= ops_count; i++) {
			IRoseOperationPtr op = ops->GetAt(i);
			RoseAbstractDumper::dump_factory()->create_by_stereotype (this, op);
		}

		IRoseParameterCollectionPtr pars = cls->Parameters;
		int pars_count = pars->Count;
		for (i = 1; i <= pars_count; i++) {
			IRoseParameterPtr par = pars->GetAt(i);
			RoseAbstractDumper::dump_factory()->create_by_stereotype (this, par);
		}
		
		IRoseClassDependencyCollectionPtr deps = cls->GetClassDependencies();	
		int deps_count = deps->Count;
		for (i = 1; i <= deps_count; i++) {
			IRoseClassDependencyPtr dep = deps->GetAt(i);
			if (dep->HasSupplier ()) {
				//собираем только "правильные" связи - Роза почему-то
				//считает валидной связь, которая никуда не указывает
				RoseAbstractDumper::dump_factory()->create_by_stereotype (this, dep);
			}
		}
		
		IRoseCategoryPtr cat = RoseHelper::get_parent_category (cls);
		IRoseScenarioDiagramCollectionPtr sc_diags = cat->ScenarioDiagrams;
		if (sc_diags != 0) {
			std::string self_guid = get_rose_element_uid(cls);
			short collection_count = sc_diags->Count;
			for (i = 1; i <= collection_count; i++) {
				IRoseScenarioDiagramPtr diag = sc_diags->GetAt(i);
				//проверяем есть ли на диаграмме элементы или нет
				//если диаграмма пустая - не добавляем её в дерево,
				//т.к это бессмысленнно
				if (diag->ItemViews->Count > 0) {
					std::string use_case_uid = diag->GetPropertyValue (TOOL_NAME, "UseCase");				
					
					//проверяем, если даграмма связана с этим юзкейсом -
					//добавляем её
					if (use_case_uid == self_guid) {
						this->add_diagram (new RoseDiagramDumper (diag));
					}
				}
			}
		} else {
			GenSupport::LogManagerFactory::get ().log_error("NULL in Scenario Diagrams collection");
		}

		IRoseClassDiagramCollectionPtr cls_diags = cat->ClassDiagrams;
		if (cls_diags != 0) {
			std::string self_guid (get_rose_element_uid(cls));
			short collection_count = cls_diags->Count;
			for (i = 1; i <= collection_count; i++) {
				IRoseClassDiagramPtr diag = cls_diags->GetAt(i);
				
				//проверяем есть ли на диаграмме элементы или нет
				//если диаграмма пустая - не добавляем её в дерево,
				//т.к это бессмысленнно
				if (diag->ItemViews->Count > 0) {
					std::string link_uid = diag->GetPropertyValue (TOOL_NAME, RoseHelper::CLASS_DIAG_LINK_PROPERTY);				
					
					//проверяем, если даграмма связана с этим юзкейсом -
					//добавляем её
					if (link_uid == self_guid) {
						this->add_diagram (new RoseDiagramDumper (diag));
					}
				}
			}
		} else {
			GenSupport::LogManagerFactory::get ().log_error("NULL in Class Diagrams collection");
		}
		//собираем все State-диаграммы
		IRoseStateMachineOwnerPtr state_machine_owner = cls->GetStateMachineOwner ();
		if (state_machine_owner) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				RoseAbstractDumper::dump_factory()->create_by_stereotype (this, st_machines->GetAt (i));
			}
		}
	} catch (std::exception& ex) {
		std::string str = "Exception in RoseAbstractClassDumper ctor: ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (_com_error& ex) {
		AbstractDumperBase::has_error(true);
		std::string str = "_com_error in RoseAbstractClassDumper ctor: ";
		str += ex.ErrorMessage ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (...) {
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error ("Unknown exception in RoseAbstractClassDumper ctor");
	}
}

IRoseClassPtr RoseAbstractClassDumper::cls() const {
	return (IRoseClassPtr) this->rose_element();
}

bool RoseAbstractClassDumper::check_protected_visibility_access (const ObjectTreeResolver* sup, const std::string& link_stereotype) const {
	const ObjectTreeResolver* par = this->ObjectTreeResolver::get_parent_category();
	const ObjectTreeResolver* sup_par = sup->ObjectTreeResolver::get_parent_category();
	if (par == sup_par) {
		return true;
	} else {
		return false;
	}
}

bool RoseAbstractClassDumper::check_private_visibility_access (const ObjectTreeResolver* sup, const std::string& link_stereotype) const {
	const ObjectTreeResolver* par = this->ObjectTreeResolver::get_parent_category();
	const ObjectTreeResolver* sup_par = sup->ObjectTreeResolver::get_parent_category();
	return (par == sup_par);
}
//#UC END# *4571DD3D03D8*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseAbstractClassDumper::~RoseAbstractClassDumper () {
	//#UC START# *4571DD3D03D8_DESTR_BODY*
	//#UC END# *4571DD3D03D8_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает класс
const std::string RoseAbstractClassDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_4571DD3D03D8*
	return CLASS_TYPE;
	//#UC END# *465EA35D005D_4571DD3D03D8*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// вид элемента
const std::string RoseAbstractClassDumper::get_class_kind_str () const {
	//#UC START# *465FE63402FD_4571DD3D03D8*
	return (char*)cls()->ClassKind->GetName();
	//#UC END# *465FE63402FD_4571DD3D03D8*
}

// overloaded method from ObjectTreeResolver
// связывает с элементом всех supplier
void RoseAbstractClassDumper::link_suppliers () {
	//#UC START# *465E57F1029F_4571DD3D03D8*
	RoseAbstractDumper::link_suppliers ();

	IRoseClassPtr cls = this->cls ();
	RoseElementSet deps_to_delete;
	IRoseInheritRelationCollectionPtr inhs = cls->GetInheritRelations();
	for (short i = 1; i < inhs->Count+1; i++) {
		IRoseInheritRelationPtr inh = inhs->GetAt(i);
		if (inh->HasSupplier ()) {
			IRoseClassPtr sup_cls = inh->GetSupplierClass();
			add_supplier (RoseAbstractDumper::find_in_tree(sup_cls), ST_NAVIGABLE, ST_LINK_INH );
		} else {
			deps_to_delete.insert (RoseElementWrapper (inh));
		}
	}

	IRoseRealizeRelationCollectionPtr rels = cls->GetRealizeRelations();
	for (short i = 1; i < rels->Count+1; i++) {
		IRoseRealizeRelationPtr rel = rels->GetAt(i);
		if (rel->HasSupplier ()) {
			IRoseClassPtr sup_cls = rel->GetSupplierClass();
			add_supplier (RoseAbstractDumper::find_in_tree(sup_cls), ST_NAVIGABLE, ST_LINK_REL );
		} else {
			deps_to_delete.insert (RoseElementWrapper (rel));
		}
	}
	
	IRoseClassDependencyCollectionPtr deps = cls->GetClassDependencies();	
	short deps_count = deps->Count;
	for (short i = 1; i <= deps_count; i++) {
		IRoseClassDependencyPtr dep = deps->GetAt(i);
		if (!dep->HasSupplier ()) {
			deps_to_delete.insert (RoseElementWrapper (dep));
		}
	}	
	
	IRoseAssociationCollectionPtr assocs = cls->GetAssociations ();
	short assocs_count = assocs->Count;

	for (short i = 1; i <= assocs_count; ++i) {
		IRoseAssociationPtr assoc = assocs->GetAt (i);
		IRoseRolePtr role = RoseHelper::get_role (assoc);
		if (role && !role->HasSupplier ()) {
			deps_to_delete.insert (RoseElementWrapper (assoc));
		}
	}	
	//#UC END# *465E57F1029F_4571DD3D03D8*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

