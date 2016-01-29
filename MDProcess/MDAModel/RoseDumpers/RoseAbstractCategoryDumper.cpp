////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractCategoryDumper.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractCategoryDumper
//
// ������ ��� ��������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractCategoryDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseDiagramDumper.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571DD1A009C_CUSTOM_INCLUDES*
//#UC END# *4571DD1A009C_CUSTOM_INCLUDES*


//#UC START# *4571DD1A009C*
RoseAbstractCategoryDumper::RoseAbstractCategoryDumper (const RoseAbstractDumper* parent, IRoseCategoryPtr cat)
	: RoseAbstractDumper ( parent, cat )
{
	try {
		bool is_global;

		if (!parent) {
			RoseAbstractDumper::global_cats().clear();
			is_global = false;
		} else {
			is_global =( cat->Global != 0 || parent->is_global());
		}

		if (is_global) {	
			RoseAbstractDumper::global_cats().push_back(this);
		}

		// insert childs
		int i;
		
		IRoseClassCollectionPtr classes = cat->GetClasses();

		short collection_count = classes->Count;
		if (classes != 0) {
			for (i = 1; i <= collection_count; i++) {
				IRoseClassPtr cls = classes->GetAt(i);
				RoseAbstractDumper::dump_factory()->create_by_stereotype (this, cls);
			}
		} else {
			GenSupport::LogManagerFactory::get ().log_error("NULL in Class collection");
		}

		IRoseClassDiagramCollectionPtr cls_diags = cat->ClassDiagrams;
		if (cls_diags != 0) {
			collection_count = cls_diags->Count;
			for (i = 1; i <= collection_count; i++) {
				IRoseClassDiagramPtr diag = cls_diags->GetAt(i);

				//��������� ���� �� �� ��������� �������� ��� ���
				//���� ��������� ������ - �� ��������� � � ������,
				//�.� ��� �������������
				if (diag->ItemViews->Count > 0) {
					std::string linked_uid = diag->GetPropertyValue (TOOL_NAME, RoseHelper::CLASS_DIAG_LINK_PROPERTY);
					
					//���������, ���� �������� �� ������� �� � ����� �������� -
					//��������� �
					if (linked_uid == "") {
						this->add_diagram (new RoseDiagramDumper (diag));
					}
				}
			}
				
		} else {
			GenSupport::LogManagerFactory::get ().log_error("NULL in Diagrams collection");
		}
		
		IRoseScenarioDiagramCollectionPtr sc_diags = cat->ScenarioDiagrams;
		if (sc_diags != 0) {
			collection_count = sc_diags->Count;
			for (i = 1; i <= collection_count; i++) {
				IRoseScenarioDiagramPtr diag = sc_diags->GetAt(i);
				
				//��������� ���� �� �� ��������� �������� ��� ���
				//���� ��������� ������ - �� ��������� � � ������,
				//�.� ��� �������������
				if (diag->ItemViews->Count > 0) {
					std::string use_case_uid = diag->GetPropertyValue (TOOL_NAME, "UseCase");
					
					//���������, ���� �������� �� ������� �� � ����� �������� -
					//��������� �
					if (use_case_uid == "") {
						this->add_diagram (new RoseDiagramDumper (diag));
					}
				}
			}
		} else {
			GenSupport::LogManagerFactory::get ().log_error("NULL in Scenario Diagrams collection");
		}

		IRoseCategoryCollectionPtr cats = cat->Categories;
		if (cats != 0) {
			collection_count = cats->Count;
			for (i = 1; i <= collection_count; i++) {
				IRoseCategoryPtr ch_cat = cats->GetAt(i);
				RoseAbstractDumper::dump_factory()->create_by_stereotype (this, ch_cat);
			}
		} else {
			GenSupport::LogManagerFactory::get ().log_error("NULL in Category collection");
		}

		//�������� ��� State-���������
		IRoseStateMachineOwnerPtr state_machine_owner = cat->GetStateMachineOwner ();
		if (state_machine_owner) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				RoseAbstractDumper::dump_factory()->create_by_stereotype (this, st_machines->GetAt (i));
			}
		}
		
		RoseAbstractCategoryDumper::update_cached_attrs ();
	} catch (std::exception& ex) {
		std::string str = "Exception in RoseAbstractCategoryDumper ctor: ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (...) {
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error ("Unknown exception in RoseAbstractCategoryDumper ctor");
	}
}

IRoseCategoryPtr RoseAbstractCategoryDumper::cat() const {
	return (IRoseCategoryPtr) this->rose_element();
}

bool RoseAbstractCategoryDumper::is_global() const {
	//TRACE ("%s: %s", (const char*) this->cat()->GetName(), p ? : p->;
	if (this->cat()->Global != 0 && this->cat()->GetParentCategory() != 0) {
		return true;
	} else {
		const ObjectTreeResolver* par = dynamic_cast<const ObjectTreeResolver*> (this->parent());
		if (par) {
			return par->is_global();
		} else {
			return false;
		}
	}	
}
//#UC END# *4571DD1A009C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseAbstractCategoryDumper::~RoseAbstractCategoryDumper () {
	//#UC START# *4571DD1A009C_DESTR_BODY*
	RoseAbstractDumper::global_cats ().remove (this);
	//#UC END# *4571DD1A009C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

bool RoseAbstractCategoryDumper::get_is_global_locally () const {
	//#UC START# *4B98B1F100E8_GET_ACCESSOR*
	return m_is_global_locally;
	//#UC END# *4B98B1F100E8_GET_ACCESSOR*
}

void RoseAbstractCategoryDumper::set_is_global_locally (bool is_global_locally) const {
	//#UC START# *4B98B1F100E8_SET_ACCESSOR*
	m_is_global_locally = is_global_locally;
	//#UC END# *4B98B1F100E8_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// ���������� �����
const std::string RoseAbstractCategoryDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_4571DD1A009C*
	return CATEGORY_TYPE;
	//#UC END# *465EA35D005D_4571DD1A009C*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from ObjectTreeResolver
// C������� ��������� ������������ - ���� � ������ ���������� ����� ��������, �� ���������, ����
// ������� - ������� �������� �������� �� ���� � ��� ����� �������� �������� �������, �.� ��� ���-
// �� ����� ���� ��������� ����� � ��� �������
bool RoseAbstractCategoryDumper::is_global_locally () const {
	//#UC START# *4B4DB9F00341_4571DD1A009C*
	return this->get_is_global_locally ();
	//#UC END# *4B4DB9F00341_4571DD1A009C*
}

// overloaded method from ObjectTreeResolver
// ��������� � ��������� ���� supplier
void RoseAbstractCategoryDumper::link_suppliers () {
	//#UC START# *465E57F1029F_4571DD1A009C*
	RoseAbstractDumper::link_suppliers ();

	short i;
	IRoseCategoryPtr cat = this->cat ();
	IRoseCategoryDependencyCollectionPtr deps = cat->GetCategoryDependencies();
	short deps_count = deps->Count;

	RoseElementSet deps_to_delete;
	for (i = 1; i <= deps_count; i++) {		
		IRoseCategoryDependencyPtr dep = deps->GetAt(i);
		if (dep->HasSupplier ()) {
				//�������� ������ "����������" ����� - ���� ������-��
				//������� �������� �����, ������� ������ �� ���������
			try { // damn... shit
				IRoseCategoryPtr sup_cat = dep->GetSupplierCategory();
				if (sup_cat != 0) {
					if ( dep->Stereotype != _bstr_t ("") ) {
						add_supplier ( RoseAbstractDumper::find_in_tree(sup_cat), ST_NOT_NAVIGABLE, (char*)dep->Stereotype );
					} else {
						add_supplier ( RoseAbstractDumper::find_in_tree(sup_cat), ST_NOT_NAVIGABLE, ST_LINK_DEP);
					}
				}
			} catch (...) {
				std::string message ("��������� ����� GetSupplierCategory ��� ��������: ");
				message += RoseHelper::get_full_name (cat);
				message += ". �������� ����������� ��������� ������� ����������� (������ ��������� ������� �� ������ � ������, � ��������)";
				
				GenSupport::ErrorManagerFactory::get ().fatal_error (this, message, GDS_CURRENT_FUNCTION);
				GenSupport::LogManagerFactory::get ().log_error (message);
			}
		} else {
			deps_to_delete.insert (RoseElementWrapper (dep));
		}				
	}

	// link with parent
	IRoseCategoryPtr par = cat->GetParentCategory();
	while (par) {
		const AbstractDumper* par_rad = RoseAbstractDumper::find_in_tree(par);
		const AbstractDumperBase::StereotypeID& st (par_rad->get_model_stereotype_str());
		if (this->is_parent_visability_stereotype (st)) {
			add_supplier (par_rad , ST_NOT_NAVIGABLE, ST_CATEGORY_NESTED_DEPENDENCE);
		}
		
		par = par->GetParentCategory();
	}
	//#UC END# *465E57F1029F_4571DD1A009C*
}

// overloaded method from RoseAbstractDumper
// ����� ����������, ����� ����� ��������, �������������� �� ������� �������� ���������
void RoseAbstractCategoryDumper::update_cached_attrs () const {
	//#UC START# *4B98C3A50072_4571DD1A009C*
	this->set_is_global_locally (ModelPropertiesHelperFactory::get ().is_global_locally (cat ()));
	RoseAbstractDumper::update_cached_attrs ();
	//#UC END# *4B98C3A50072_4571DD1A009C*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

