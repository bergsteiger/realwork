////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/NewComTarget/NewComTarget.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ComTarget::Category>> TestModel::NewComTarget
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_NEWCOMTARGET_H__
#define __TESTMODEL_NEWCOMTARGET_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"
#include "Resource.h"
extern ATL::CComModule _Module;	

static const char* DLL_VERSION = "1.0.0";

static const long DLL_BUILD_NUM = 0;

class COMDllInintializator {
public:
	static void init ();
	static void done ();

private:
	static Core::Mutex s_init_mutex;
	static unsigned long s_count;
};

#endif //__TESTMODEL_NEWCOMTARGET_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
