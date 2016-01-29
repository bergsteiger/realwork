////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/MDProcess/MDAAddinLib/PropertyViews/MDAGeneratorProperties.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::PropertyViews::MDAGeneratorProperties
//
// дилог управлени€ различными свойствами MDA-генератора
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
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

// дилог управлени€ различными свойствами MDA-генератора
class MDAGeneratorProperties : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (MDAGeneratorProperties)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// функтор дл€ получени€ значени€ свойства булевского типа
	typedef boost::function<bool ()> BoolFunctorGet;

	// функтор дл€ установки значени€ свойства булевского типа
	typedef boost::function<void (bool)> BoolFunctionSet;

	enum MDAGeneratorPropertyType {
		PT_BOOL // булевуский тип свойства
	};

	// обертка над моделью данных дл€ управлени€ свойствами
	struct MDAGeneratorPropertiesModel {
		// идентифкатор свойства (используетс€ в гуи)
		int id;
		// описание свойства
		std::string label;
		// чтение булевского свойства
		BoolFunctorGet bool_get;
		// функтор дл€ записи значени€ свойства булевского типа
		BoolFunctionSet bool_set;
		// тип свойства
		MDAGeneratorPropertyType type;
	};

	// модель данных дл€ отображени€
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
	// заполн€ет дерево свойств
	virtual void fill_properties ();

	// создает вью дл€ отображени€ свойства булевского типа
	virtual WinGUI::COptionTreeItem* make_bool_property (
		const MDAGeneratorPropertiesModel& data
		, WinGUI::COptionTreeItem& root
	);

	// обработчик нажати€ кнопки OK
	virtual void on_ok ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// контрол - дерево свойств
	WinGUI::COptionTree m_properties;

	// модель данных дл€ свойств
	MDAGeneratorPropertiesModelList m_properties_model;
}; // class MDAGeneratorProperties



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_MDAGENERATORPROPERTIES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

