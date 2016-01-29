////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseDiagramDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseDiagramDumper
//
// ������ ��� ��������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEDIAGRAMDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEDIAGRAMDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include <ostream>
#include "ximage.h"

//#UC START# *4571DFB400FA_CUSTOM_INCLUDES*
//#UC END# *4571DFB400FA_CUSTOM_INCLUDES*


// ������ ��� ��������� ��������
class RoseDiagramDumper;
typedef Core::Var<RoseDiagramDumper> RoseDiagramDumper_var;
typedef Core::Var<const RoseDiagramDumper> RoseDiagramDumper_cvar;

class RoseDiagramDumper :
	public AbstractSingleDumperBase
{
	SET_OBJECT_COUNTER (RoseDiagramDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// ����� ������ ��� ����������, ��������� � view (��������� �� ��������) �
	// ����� stream
	static void dump_item_view (IRoseItemViewPtr view, std::ostream& stream);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// ctor
	explicit RoseDiagramDumper (IRoseDiagramPtr diag);

public:
	virtual ~RoseDiagramDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� �������� � ���� ��������, � ���-�������� = 100 � ��������� ��� ������������� ������,
	// ����� �������� ���������� �� ������ � 1200 ��������
	virtual CxImage* create_image () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IRoseDiagramPtr m_diag;

	// ������ ��������� ������ IdentifyClass ()
	std::string m_model_class_str;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// ���������� ���
	virtual const std::string get_name_str () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumperBase
	// ����� ������ ���������, ���������� �������� � ���� ����� ������.
	// items - ��������� ��������� ��������, ��� ������������ ������������� ����
	// diagram_hash - ��� ���������, ������������� �� ������ ���� view - ��������� �� ��������
	virtual CxMemFile* dump_diagram (AbstractDumperBase::DiagramItemCollection& items, std::string& diagram_hash) const;

	// overloaded method from AbstractDumperBase
	// ���������� �����
	virtual const std::string get_model_class_str () const;

	// overloaded method from AbstractDumperBase
	// ��������� �� ������ (VCMModule, CORBAInterface::operation, ...)
	virtual const AbstractDumperBase::StereotypeID& get_model_stereotype_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� GUID ��������
	virtual const std::string& get_model_unique_id_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� true, ���� ������� ��� ������ (������������ �� ����������� ����, ��� ��������� ����
	// ��������)
	virtual bool is_changed () const;

	// overloaded method from AbstractDumperBase
	// ���������� ���������� �� �����������
	virtual void reset_changed () const;


//#UC START# *4571DFB400FA*
public:	
	bool operator == (const AbstractDumperBase& c) const;

protected:	
	virtual void dump (std::ostream* output = NULL) const;

private:
	AbstractDumperBase::StereotypeID m_model_stereotype_id;
//#UC END# *4571DFB400FA*
}; // class RoseDiagramDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEDIAGRAMDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

