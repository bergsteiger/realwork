////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/PropertyViews/MDAGeneratorProperties.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::PropertyViews::MDAGeneratorProperties
//
// ����� ���������� ���������� ���������� MDA-����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_MDAGENERATORPROPERTIES_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_MDAGENERATORPROPERTIES_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/function.hpp"
#include <vector>
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"

// ����� ���������� ���������� ���������� MDA-����������
class MDAGeneratorProperties : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (MDAGeneratorProperties)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ������� ��� ��������� �������� �������� ���������� ����
	typedef boost::function<bool ()> BoolFunctorGet;

	// ������� ��� ��������� �������� �������� ���������� ����
	typedef boost::function<void (bool)> BoolFunctionSet;

	enum MDAGeneratorPropertyType {
		PT_BOOL // ���������� ��� ��������
	};

	// ������� ��� ������� ������ ��� ���������� ����������
	struct MDAGeneratorPropertiesModel {
		// ������������ �������� (������������ � ���)
		int id;
		// �������� ��������
		std::string label;
		// ������ ���������� ��������
		BoolFunctorGet bool_get;
		// ������� ��� ������ �������� �������� ���������� ����
		BoolFunctionSet bool_set;
		// ��� ��������
		MDAGeneratorPropertyType type;
	};

	// ������ ������ ��� �����������
	typedef std::vector < MDAGeneratorPropertiesModel > MDAGeneratorPropertiesModelList;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_MDA_GENERATOR_PROPERTIES };

public:
	MDAGeneratorProperties ();

public:
	virtual ~MDAGeneratorProperties ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(MDAGeneratorProperties)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
private:
	// ��������� ������ �������
	virtual void fill_properties ();

	// ������� ��� ��� ����������� �������� ���������� ����
	virtual WinGUI::COptionTreeItem* make_bool_property (
		const MDAGeneratorPropertiesModel& data
		, WinGUI::COptionTreeItem& root
	);

	// ���������� ������� ������ OK
	virtual void on_ok ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������� - ������ �������
	WinGUI::COptionTree m_properties;

	// ������ ������ ��� �������
	MDAGeneratorPropertiesModelList m_properties_model;
}; // class MDAGeneratorProperties



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_MDAGENERATORPROPERTIES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

