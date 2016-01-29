////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/EmptyDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::EmptyDumper
//
// ������ ������, ����� �������������� ��� ������ �������� � ������ �� ��������� UID
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_EMPTYDUMPER_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_EMPTYDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"

//#UC START# *4A4892480384_CUSTOM_INCLUDES*
//#UC END# *4A4892480384_CUSTOM_INCLUDES*


// ������ ������, ����� �������������� ��� ������ �������� � ������ �� ��������� UID
class EmptyDumper;
typedef Core::Var<EmptyDumper> EmptyDumper_var;
typedef Core::Var<const EmptyDumper> EmptyDumper_cvar;

class EmptyDumper :
	virtual public ObjectTreeResolver
	, virtual public AbstractSingleDumperBase
{
	SET_OBJECT_COUNTER (EmptyDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit EmptyDumper (const std::string& model_unique_id);

public:
	virtual ~EmptyDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// UID ��������
	std::string m_model_unique_id;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// ���������� ���
	virtual const std::string get_name_str () const;

	// implemented method from ObjectTreeResolver
	// ��������� � ��������� ���� supplier
	virtual void link_suppliers ();
protected:

	// implemented method from ObjectTreeResolver
	// ���������� ��� ������� ����������
	virtual long get_fwd_weight () const;

	// implemented method from ObjectTreeResolver
	// ���������� true, ���� ������� ������ ������� �������������
	virtual bool is_forbiden_forward_dcl () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumperBase
	// ���������� GUID ��������
	virtual const std::string& get_model_unique_id_str () const;

	// overloaded method from ObjectTreeResolver
	// ������������ ��������� ������
	virtual int compare (const ObjectTreeResolver* od) const;
protected:

	// overloaded method from Base::NamedElement
	// ���������� ������ ��� ��������
	virtual const std::string get_full_name () const;


//#UC START# *4A4892480384*
	virtual bool operator == (const AbstractDumperBase& c) const;
	virtual void clean_forward (OTRSet& scope);
//#UC END# *4A4892480384*
}; // class EmptyDumper



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_EMPTYDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

