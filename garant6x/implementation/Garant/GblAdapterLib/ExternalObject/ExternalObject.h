////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalObject
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

enum ExternalObjectType {
	EOT_PIC // �������� � ������� BMP.
	, EOT_JPG
	, EOT_PNG
	, EOT_GIF
	, EOT_RTF // ����� � ������� RTF.
	, EOT_XLS // ������� � ������� XLS.
	, EOT_MP3
	, EOT_EVD
	, EOT_TIF
	, EOT_PDF
	, EOT_PPT // ����� PowerPoint
	, EOT_CDR // ����� CorelDraw
	, EOT_DOC // �������� Word
	, EOT_DOCX
	, EOT_XLSX
	, EOT_XML
	, EOT_XSD
	, EOT_USR
};

class ExternalLink;
typedef ::Core::Var<ExternalLink> ExternalLink_var;
typedef ::Core::Var<const ExternalLink> ExternalLink_cvar;
class ExternalLink
	: virtual public ::Core::IObject
{
public:
	// ������ �� ������� ������� � ��������� URL.
	virtual const GCI::IO::String* get_url () const = 0;
};

/// factory interface for ExternalLink
class ExternalLinkFactory {
public:
	static ExternalLink* make (const char* url)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ExternalObject;
typedef ::Core::Var<ExternalObject> ExternalObject_var;
typedef ::Core::Var<const ExternalObject> ExternalObject_cvar;
class ExternalObject
	: virtual public ::Core::IObject
{
public:
	// ����� ������ ������������ ������.
	virtual unsigned long get_data_size () const = 0;

	// ��������� �� ����� � �������.
	virtual const void* get_data_pointer () const = 0;
	virtual void* get_data_pointer () = 0;

	// ��� �������� �������.
	virtual const GCI::IO::String* get_name () const = 0;

	// ���������� ��� ����� (������ � ���������� ������) �� �����
	virtual const GCI::IO::String* get_extension () const = 0;

	virtual ExternalObjectType get_data_type () const = 0;
};

/// factory interface for ExternalObject
class ExternalObjectFactory {
public:
	static ExternalObject* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static ExternalObject* make (GblPilot::InternalObj* obj)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class SplashScreen;
typedef ::Core::Var<SplashScreen> SplashScreen_var;
typedef ::Core::Var<const SplashScreen> SplashScreen_cvar;
class SplashScreen
	: virtual public ExternalObject
{
public:
	virtual short get_show_time () const = 0;

	virtual const GCI::IO::String* get_owner_caption () const = 0;

	virtual const GCI::IO::String* get_owner () const = 0;
};

/// factory interface for SplashScreen
class SplashScreenFactory {
public:
	// is_start - �������� ��� ������
	// x,y - ���������� ������
	// flash_available -�������� �� ����� ���� �������
	static SplashScreen* make (bool is_start, short x, short y, bool flash_available)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, CanNotFindData)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ExternalLink> {
	typedef GblAdapterLib::ExternalLinkFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ExternalObject> {
	typedef GblAdapterLib::ExternalObjectFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::SplashScreen> {
	typedef GblAdapterLib::SplashScreenFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
