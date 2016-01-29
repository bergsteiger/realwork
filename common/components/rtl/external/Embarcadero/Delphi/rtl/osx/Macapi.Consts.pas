{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Macapi.Consts;

interface

resourcestring
  SObjectiveCRTTINotAvailable = 'RTTI for type %s was not found.  Perhaps missing {$M+}?';
  SObjectiveCClassNotFound = 'ObjectiveC class %s could not be found';
  SInvalidObjectiveCType = '%s is not a valid ObjectiveC type';
  SInternalBindingError = 'Internal error creating binding for ''%s''';
  SMethodMustBeCDecl = 'Method ''%s'' of type ''%s'' must have cdecl calling convention';
  SBadObjectiveCClass = '''%s'' must be an interface derived from IObjectiveCClass';
  SBadObjectiveCInstance = '''%s'' must be an interface derived from IObjectiveCInstance';
  SBadObjectiveCProtocol = '''%s'' must be an interface derived from IObjectiveCProtocol';
  SErrorCreatingOCObject = 'Unable to create ObjectiveC persona for instance of ''%s''';
  SOCInvokeError = 'Fatal error invoking interface';
  SInvalidObjCType = 'The type ''%s'' is not supported with ObjectiveC interoperability';

implementation

end.
