////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Morpho/Facade/Factory.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Morpho::Facade::Factory
//
// �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_FACADE_FACTORY_H__
#define __SHARED_MORPHO_FACADE_FACTORY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Morpho/Def/Def.h"

namespace Morpho {

// �������
class Factory {
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������
	static Def::INormalizer* make (Def::ICache* cache);

	// �������
	static Def::ICache* make ();

	// �������
	static Def::INormalizer* make (Def::ICache* cache, Def::IMorphoAdapter* adapter);

	// �������
	static Def::ICache* make_for_txt (const std::string& path);

}; // class Factory

} // namespace Morpho


#endif //__SHARED_MORPHO_FACADE_FACTORY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

