
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// DLL контекстного морфологического поиска
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef __GARANTCORE_CSADAPTER_H__
#define __GARANTCORE_CSADAPTER_H__

#include "ace/Log_Msg_Backend.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"

extern "C" __declspec (dllexport) void dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void dll_done ();

extern "C" __declspec (dllexport) void set_log (ACE_Log_Msg_Backend* log_msg_backend);

extern "C" __declspec (dllexport) SearchAdapterLib::Adapter::IAdapter& get ();

extern "C" __declspec (dllexport) unsigned long dll_version ();

#endif //__GARANTCORE_CSADAPTER_H__

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
