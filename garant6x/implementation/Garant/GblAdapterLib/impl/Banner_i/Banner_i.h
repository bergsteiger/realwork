////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Banner_i/Banner_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Banner_i::Banner_i
// ��������� ���������� ������ �������� ��� ��������� Banner
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BANNER_I_BANNER_I_H__
#define __GARANT6X_GBLADAPTERLIB_BANNER_I_BANNER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Banner/Banner.h"

namespace GblAdapterLib {

class Banner_i; // self forward Var
typedef ::Core::Var<Banner_i> Banner_i_var;
typedef ::Core::Var<const Banner_i> Banner_i_cvar;

class Banner_i_factory;

class Banner_i:
	virtual public Banner
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Banner_i)
	friend class Banner_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Banner_i ();

	virtual ~Banner_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ��������� ������
	GblPilot::Banner_var m_server_banner;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Banner
	// ��������
	virtual ExternalObject* get_picture () const;

	// implemented method from Banner
	// ������� ������ ������� (���������� ��� IDocument ��� ExternalLink)
	virtual Core::IObject* open_link () const /*throw (CanNotFindData)*/;
}; // class Banner_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BANNER_I_BANNER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
