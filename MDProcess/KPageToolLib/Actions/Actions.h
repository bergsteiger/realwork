////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/Actions/Actions.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::KPageToolLib::Actions
//
// ����� ��������� �������� �� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONS_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "MDProcess/ServerGate/Contents/Contents.h"

namespace KPageToolLib {
namespace Actions {

// ������ ��������, ������� ����� ���������, �������� �� KPageTool
enum PageActionsEnum {
	PA_GET // �������� ����� ��������
	, PA_SET // ���������� ����� ��������
	, PA_APPEND // �������� ����� � ����� ������ ��������
	, PA_ATTACH // �������� ����� ��������
	, PA_GET_LABEL // �������� ������ ������� (����� �������, ������������� �� ��������)
	, PA_SET_LABEL // ���������� ����� ������ (�������� ����� �������, ����� �������)
};

class KPageAction;
typedef ::Core::Var<KPageAction> KPageAction_var;
typedef ::Core::Var<const KPageAction> KPageAction_cvar;
// ������ ��� KPage ��� ���������� ������� ������� KPageTool.
class KPageAction
	: virtual public ::Core::IObject
{
public:
	// ��������� �������� ��� ���������. ���������� 0 - � ������ �����. 1 - � ������ ����� ������
	// (����������� � ���������� ����).
	// page - ���������� �������� ��� ������� ����� ��������� ��������. page �� ����� ������ � Var!
	virtual int execute (ServerGate::Contents::KPage* page) = 0;
};

/// factory interface for KPageAction
class KPageActionFactory {
public:
	typedef std::vector<PageActionsEnum> KeySet;
	
	static KeySet* keys ();
public:
	// ���������� ��������� ��������
	static KPageAction& get (PageActionsEnum key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Actions
} // namespace KPageToolLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <KPageToolLib::Actions::KPageAction> {
	typedef KPageToolLib::Actions::KPageActionFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
