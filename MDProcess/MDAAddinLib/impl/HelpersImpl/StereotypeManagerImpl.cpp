////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/StereotypeManagerImpl.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::StereotypeManagerImpl
//
// ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/StereotypeManagerImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/HelpersImpl.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

namespace HelpersImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StereotypeManagerImpl::StereotypeManagerImpl ()
//#UC START# *4907EFD50359_4907EFFE02B5_4907F2010250_BASE_INIT*
//#UC END# *4907EFD50359_4907EFFE02B5_4907F2010250_BASE_INIT*
{
	//#UC START# *4907EFD50359_4907EFFE02B5_4907F2010250_BODY*
	//#UC END# *4907EFD50359_4907EFFE02B5_4907F2010250_BODY*
}

StereotypeManagerImpl::~StereotypeManagerImpl () {
	//#UC START# *4907F2010250_DESTR_BODY*
	//#UC END# *4907F2010250_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Helpers::StereotypeManager
// ��������� ������ ����������� ���������, ����������� ��������� � �������� ��������.
// �������������� ������ ������������ �� ������� ������������� ����������� ������ ������!
Helpers::StereotypeList* StereotypeManagerImpl::make_allowable_stereotypes (
	IRoseElementPtr elem
	, IRoseElementPtr context
) const {
	//#UC START# *4907F0D70315_4907F2010250*
	Core::Aptr<Helpers::StereotypeList> stereotypes (new Helpers::StereotypeList ());

	IRoseElementPtr container = context != 0 ? RoseHelper::get_nearest_category (context) : 0;
	for (
		AbstractDumperBase::Templates::const_iterator it = AbstractDumperBase::templates_begin ()
		; it != AbstractDumperBase::templates_end ()
		; ++it
	) {
		if (
			RoseHelper::is_it_available_by_type (elem, context, it->first) 
			&& RoseHelper::is_it_available_by_constr (elem, context, it->first)
			&& !it->second.is_internal //������ ������������ �� ������ �������� � ���������� �����������
		) {
			stereotypes->push_back (it->first);
		}
	}
	if (container) {
		Core::Aptr<Helpers::StereotypeUseMap> use_map (this->make_use_map (container));
		std::sort (stereotypes->begin (), stereotypes->end (), SortStereotypeByUse (*use_map));
	} else {
		std::sort (stereotypes->begin (), stereotypes->end ());
	}

	return stereotypes.forget ();
	//#UC END# *4907F0D70315_4907F2010250*
}

// implemented method from Helpers::StereotypeManager
// ��������� ���� ������� ������������� ����������� ������ ��������� ��������
Helpers::StereotypeUseMap* StereotypeManagerImpl::make_use_map (IRoseElementPtr elem) const {
	//#UC START# *4907F01201E3_4907F2010250*
	class local {
	public:
		static RoseElementSet* collect_child (const IRoseElementPtr& elem) {
			Core::Aptr<RoseElementSet> res = new RoseElementSet ();
			Core::Aptr<RoseElementSet> childs = RoseHelper::get_childs (elem);
			RoseElementSet::const_iterator it = childs->begin ();
			RoseElementSet::const_iterator end = childs->end ();

			for (; it != end; ++it) {
				if (it->element->IsClass (CLASS_TYPE)) {
					Core::Aptr<RoseElementSet> class_childs = RoseHelper::get_all_childs (it->element);
					if (!class_childs.is_nil () && !class_childs->empty ()) {
						res->insert (class_childs->begin (), class_childs->end ());
					}
				}
			}
			res->insert (childs->begin (), childs->end ());

			return res.forget ();
		}
	};
	Core::Aptr<Helpers::StereotypeUseMap> res (new Helpers::StereotypeUseMap ());
	
	//�������� ���� ����� ��������. ���� ��� ����� �� � �����-������� 
	//�������� ������������� ��� ��������� �������� (����������)
	Core::Aptr<RoseElementSet> childs = local::collect_child (elem);

	if (!childs.is_nil () && !childs->empty ()) {
		RoseElementSet::const_iterator it = childs->begin ();
		RoseElementSet::const_iterator end = childs->end ();

		for (; it != end; ++it) {
			AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype (it->element);
			Helpers::StereotypeUseMap::iterator it = res->find (stereotype);
			if (it == res->end ()) {
				//����� ������� - �������������� 1-�
				res->insert (std::make_pair(stereotype, 1));
			} else {
				//����������� ������� �������������
				++(it->second);
			}
		}
	}
	return res.forget ();
	//#UC END# *4907F01201E3_4907F2010250*
}
} // namespace HelpersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

