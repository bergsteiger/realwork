////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Banner/Banner.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Banner
//
// �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BANNER_H__
#define __GARANT6X_GBLADAPTERLIB_BANNER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"

namespace GblAdapterLib {

class Banner;
typedef ::Core::Var<Banner> Banner_var;
typedef ::Core::Var<const Banner> Banner_cvar;
// ������
class Banner
	: virtual public ::Core::IObject
{
public:
	// ������� ������ ������� (���������� ��� IDocument ��� ExternalLink)
	virtual Core::IObject* open_link () const /*throw (CanNotFindData)*/ = 0;

	// ��������
	virtual ExternalObject* get_picture () const = 0;
};

/// factory interface for Banner
class BannerFactory {
public:
	static Banner* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, CanNotFindData)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Banner> {
	typedef GblAdapterLib::BannerFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_BANNER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
