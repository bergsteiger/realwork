// -----------------------------------------------------------------------------------
// comhlpr.cpp - C++ ActiveX Helpers
//
// $Rev: 86413 $
//
// Copyright(c) 2016 Embarcadero Technologies, Inc. 
//              All rights reserved                      
// -----------------------------------------------------------------------------------
#include <axbase.h>
#include <cstdlib>

HRESULT COMHlpr_ConnectEvents(REFIID eventsIID, IUnknown* server, IUnknown* sink, DWORD &cookie)
{
  HRESULT hr = E_NOINTERFACE;
  TComInterface<IConnectionPointContainer, &IID_IConnectionPointContainer> pCPC;
  pCPC = server;
  if (pCPC)
  {
    TComInterface<IConnectionPoint, &IID_IConnectionPoint> pCP;
    hr = pCPC->FindConnectionPoint(eventsIID, &pCP);
    if (SUCCEEDED(hr))
      if (pCP)
        hr = pCP->Advise(sink, &cookie);
  }
  return hr;
}


HRESULT COMHlpr_DisconnectEvents(REFIID eventsIID, IUnknown* server, DWORD &cookie)
{
  if (cookie == 0)
    return CONNECT_E_NOCONNECTION;
  HRESULT hr = E_NOINTERFACE;
  TComInterface<IConnectionPointContainer, &IID_IConnectionPointContainer> pCPC;
  pCPC = server;
  if (pCPC)
  {
    TComInterface<IConnectionPoint, &IID_IConnectionPoint> pCP;
    hr = pCPC->FindConnectionPoint(eventsIID, &pCP);
    if (SUCCEEDED(hr))
      if (pCP)
        hr = pCP->Unadvise(cookie);
    if (SUCCEEDED(hr))
      cookie = 0;
  }
  return hr;
}
