/////////////////////////////////////////////////////////////////////////
//  MTSHLPR.CPP -- transparent support for MTS and COM+
//
// $Rev: 86413 $
//
// Copyright(c) 2016 Embarcadero Technologies, Inc. 
//              All rights reserved                      
//////////////////////////////////////////////////////////////////////////

#include <windows.h>
#include <System.SysUtils.hpp>
#include "mtshlpr.h"
#include "mtshlpr.rh"

#if !defined(_WIN64) //FIXME
#pragma resource "mtshlpr.res"
#endif

#define COMPLUS 0
#define MTS 1
#define NOTSUPPORTED 1000

#undef GetObjectContext

TMtsDll::TMtsDll() 
{
  bool init = init_com();
  if (!init) { init = init_mts(); }
  if (!init) { throw System::Sysutils::Exception(System::Sysutils::LoadStr(sInitMTSServicesError)); }
}

TMtsDll::~TMtsDll()
{
  if (Library) delete Library;
}

bool TMtsDll::init_com() 
{
  TDll* comservices = new TDll("comsvcs.dll"); /* do not localize */
  HINSTANCE success = comservices->operator HINSTANCE ();
  if (success)
  {
    delete comservices;
    comservices = new TDll("ole32.dll"); /* do not localize */
    success = comservices->operator HINSTANCE();
  }
  if (success)
  {
    Library = comservices;
    Type = COMPLUS;
    return true;
  } else {
    delete comservices;
    return false;
  }
}

bool TMtsDll::init_mts()
{
  TDll* mtsservices = new TDll("mtxex.dll"); /* do not localize */
  HINSTANCE success = mtsservices->operator HINSTANCE();
  if (success)
  {
    Library = mtsservices;
    Type = MTS;
    return true;
  } else {
    delete mtsservices;
    return false;
  }
}

HRESULT TMtsDll::Get_ObjectContext(IObjectContext** ppInstanceContext)
{
  switch(Type) 
  {
    case COMPLUS :
    {
      TDllStdProc2<REFIID, IObjectContext**> BGetObjectContext(*Library, _T("CoGetObjectContext")); /* do not localize */
      HRESULT hr = E_FAIL;
      if (BGetObjectContext)
        hr = BGetObjectContext(IID_IObjectContext, ppInstanceContext);
      return hr;
    }
    case MTS :
    {
      TDllProc1<IObjectContext**, HRESULT> BGetObjectContext(*Library, _T("GetObjectContext")); /* do not localize */
      HRESULT hr = E_FAIL;
      if (BGetObjectContext)
        hr = BGetObjectContext(ppInstanceContext);
      return hr;
    }
    default :
    {
      throw System::Sysutils::Exception(System::Sysutils::LoadStr(sLoadMTSServicesError));
    }
  }
}

void* TMtsDll::SafeRef(REFIID rid, IUnknown* pUnknown)
{
  switch(Type)
  {
    case COMPLUS:
    {
      pUnknown->AddRef();
      return pUnknown; 
    }
    case MTS:
    {
      TDllProc2<REFIID, IUnknown*, void*> BSafeRef(*Library, _T("SafeRef")); /* do not localize */
      if (BSafeRef)
        return BSafeRef(rid, pUnknown);
      else
        return 0;
    }
    default :
    {
      throw System::Sysutils::Exception(System::Sysutils::LoadStr(sLocateMTSServicesError));
    }
  }
}

long LockMode_SetGet = LockSetGet;
long LockMode_LockMethod = LockMethod;
long ReleaseMode_Standard = Standard;
long ReleaseMode_Process = Process;
