{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Win.ComConst;

interface
{$HPPEMIT LEGACYHPP}

resourcestring
  SCreateRegKeyError = 'Error creating system registry entry';
  SOleError = 'OLE error %.8x';
  SObjectFactoryMissing = 'Object factory for class %s missing';
  STypeInfoMissing = 'Type information missing for class %s';
  SBadTypeInfo = 'Incorrect type information for class %s';
  SDispIntfMissing = 'Dispatch interface missing from class %s';
  SNoMethod = 'Method ''%s'' not supported by automation object';
  SVarNotObject = 'Variant does not reference an automation object';
  STooManyParams = 'Dispatch methods do not support more than 64 parameters';
  SDCOMNotInstalled = 'DCOM not installed';
  SDAXError = 'DAX Error';

  SAutomationWarning = 'COM Server Warning';
  SNoCloseActiveServer1 = 'There are still active COM objects in this ' +
    'application.  One or more clients may have references to these objects, ' +
    'so manually closing ';
  SNoCloseActiveServer2 = 'this application may cause those client ' +
    'application(s) to fail.'#13#10#13#10'Are you sure you want to close this ' +
    'application?';

  sNoRunningObject = 'Unable to retrieve a pointer to a running object registered with OLE for %s/%s';
  sParameterCountExceeded = 'Parameter count exceeded';

  SBadPropValue = '''%s'' is not a valid property value';
  SInvalidLicense = 'License information for %s is invalid';
  SNotLicensed = 'License information for %s not found. You cannot use this control in design mode';
  SCannotActivate = 'OLE control activation failed';
  SNoWindowHandle = 'Could not obtain OLE control window handle';

type
  TInvoke = (CreateWnd = 0, SetBounds = 1, DestroyWindowHandle = 2);

implementation

end.
