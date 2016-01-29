{ *********************************************************************** }
{                                                                         }
{ Delphi Runtime Library                                                  }
{                                                                         }
{ Copyright (c) 1999-2001 Borland Software Corporation                    }
{                                                                         }
{ *********************************************************************** }

unit CorbCnst;

interface

resourcestring
  SCorbaDllNotLoaded = 'Unable to load CORBA libraries';
  SCorbaNotInitialized = 'CORBA libraries are unavailable or not initialized';
  SCorbaSkeletonNotRegistered = 'CORBA server skeleton not registered for object %s';
  SCorbaStubNotRegistered = 'CORBA client stub not registered';
  SCorbaInterfaceIDNotRegister = 'CORBA interface not registered';
  SCorbaRepositoryIDNotRegistered = 'CORBA Repository ID "%s" not registered';
  SCorbaIncompleteFactory = 'CORBA Factory did not implement CreateInterface';

resourcestring
  sInvalidTypeCast = 'Variant cannot be converted to a CORBA Any';
  sNotCorbaObject = 'Variant/Any not a CORBA object';
  sParamTypeCast = 'Parameter (%d) of method %s not of the correct type';
  sParamOut = 'Parameter (%d) of method %s is an out or in/out parameter and requires a variable reference';
  sNoRepository = 'Could not perform CORBA Dispatch, no interface repository found';
  sInvalidParameterCount = 'Incorrect number of parameters to method %s';
  sMethodNotFound = 'Method %s not found';
  sConnecting = 'Connecting to CORBA server...';

implementation

end.
