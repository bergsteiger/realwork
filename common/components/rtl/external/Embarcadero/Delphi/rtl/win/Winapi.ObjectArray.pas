{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: ObjectArray.h                          }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


unit Winapi.ObjectArray;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

interface

uses Winapi.Windows, Winapi.ActiveX;

{$HPPEMIT '#include <ObjectArray.h>'}

const
  SID_IObjectArray      = '{92CA9DCD-5622-4BBA-A805-5E9F541BD8C9}';
  SID_IObjectCollection = '{5632B1A4-E38A-400A-928A-D4CD63230295}';

  IID_IObjectArray: TGUID      = SID_IObjectArray;
  {$EXTERNALSYM IID_IObjectArray}
  IID_IObjectCollection: TGUID = SID_IObjectCollection;
  {$EXTERNALSYM IID_IObjectCollection}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IObjectArray);'}
  IObjectArray = interface(IUnknown) 
    [SID_IObjectArray]
    function GetCount(var pcObjects: UINT): HRESULT; stdcall;
  
    function GetAt(uiIndex: UINT; const riid: TIID; out ppv): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IObjectArray}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IObjectCollection);'}
  IObjectCollection = interface(IObjectArray) 
    [SID_IObjectCollection]
    function AddObject(const punk: IUnknown): HRESULT; stdcall;
  
    function AddFromArray(const poaSource: IObjectArray): HRESULT; stdcall;
  
    function RemoveObjectAt(uiIndex: UINT): HRESULT; stdcall;
  
    function Clear: HRESULT; stdcall;
  end;
  {$EXTERNALSYM IObjectCollection}

implementation

end.
