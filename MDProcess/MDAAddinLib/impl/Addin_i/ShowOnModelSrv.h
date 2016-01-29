////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/ShowOnModelSrv.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::ShowOnModelSrv
//
// ���������� ������ ShowOnModel
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_SHOWONMODELSRV_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_SHOWONMODELSRV_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "MDProcess/LinkSupport/ConfModelLinks/ConfModelLinks.h"
#include "MDProcess/LinkSupport/ConfModelLinks/ConfModelLinksS.h"


// ���������� ������ ShowOnModel
class ShowOnModelSrv;
typedef Core::Var<ShowOnModelSrv> ShowOnModelSrv_var;
typedef Core::Var<const ShowOnModelSrv> ShowOnModelSrv_cvar;

class ShowOnModelSrv :
	virtual public POA_LinkSupport::ConfModelLinks::ShowOnModel
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (ShowOnModelSrv)

	// singleton declaration
	typedef ACE_Singleton <ShowOnModelSrv, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ShowOnModelSrv, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static ShowOnModelSrv* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~ShowOnModelSrv ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from LinkSupport::ConfModelLinks::ShowOnModel
	// �������� ������� � ����, ���������� 0 - ���� �������, 1 - ���� ������� �� �� ������
	virtual CORBA::Long show (const char* project_name, const char* elem_guid) throw (CORBA::SystemException);
}; // class ShowOnModelSrv



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_SHOWONMODELSRV_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

