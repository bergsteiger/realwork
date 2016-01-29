////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAGenerator/MDAGenerator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ComTarget::Category>> MDProcess::MDAGenerator
//
// цель сборки - com-dll плагина к Rose
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAGENERATOR_H__
#define __MDPROCESS_MDAGENERATOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"
#include "Resource.h"
extern ATL::CComModule _Module;	

static const char* DLL_VERSION = "1.118.0";

static const long DLL_BUILD_NUM = 51;

class COMDllInintializator {
public:
	static void init ();
	static void done ();

private:
	static Core::Mutex s_init_mutex;
	static unsigned long s_count;
};

#endif //__MDPROCESS_MDAGENERATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
