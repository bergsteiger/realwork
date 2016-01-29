{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.Consts;

interface

resourcestring
  sMaxArgsExceeded = 'Maximum number of arguments allowed exceeded (%d)';
  sFormatArgError = 'Expected at least one variable for Format() call';
  sFormatExpectedStr = 'First argument to Format() must be a string';
  sFormatUnexpectedType = 'Unsupported Format() type found: %s';
  sUnexpectedArgCount = 'Expected %d arguments, but received %d';
  sToStrArgCount = 'Expected 1 argument to ToStr';
  sManagerNotFound = 'Manager cannot be Nil.';
  sOwnerNotFound = 'Owner cannot be Nil.';
  sScopeObjNull = 'Scope obj cannot be Nil.';
  sUncompiledExpression = 'The expression has not been compiled yet.';
  sUnsupportedManager = 'Manager does not support IBindingNotification.';
  sClassTypeNotFound = 'ClassType must be specified.';
  sOutputIsReadOnly = 'Output expression evaluates a read only value';
  sUnavailNotifier = 'Unable to create notifier';
  sConversionUnavailable = 'No conversion is available from type %s to %s';
  sConverterNotFound = 'Unable to cast or find converters between types %s and %s.';
  sConverterIDNotFound = 'Converter ID must be specified';
  sConverterIDNotRegistered = 'No converter with the name %s has been registered';
  sDuplicatedConverterType = 'The converter named "%s" with an identical input type (%s) and output type (%s) has already been added';
  sMismatchedSignature = 'Method signature does not match expected';
  sDuplicatedMethodName = 'A method with name %s already exists';
  sMethodNotFound = 'No method with the name %s has been registered';
  sDoSetUpRequired = 'Class %s must provide an override for DoSetUp';
  sInvalidObject = 'Object must be valid';
  sHandlerNotFound = 'No handler to link types %s and %s.';
  sIsStillInactive = '%s needs to be activated first.';
  sCannotChangeWhileActive = '%s needs to be disabled before changed.';
  sMismatchAttach = 'Cannot attach the specified object because it is not of the same type as the metaclass.';
  sMetaClassNotFound = 'MetaClass cannot be nil.';
  sOverloadGroupArgCount = 'Overload group %s must all have same number of arguments (%d)';
  sNamedMismatchArgCount = 'Invalid number of arguments to %s: expected %d, received %d';
  sMismatchArgCount = 'Wrong number of args: expected %d, got %d';
  sOverloadNotFound = 'No matching overload for %s found';
  sAmbiguousOverloadCall = 'Ambiguous overloaded call to %s';
  sAddOpFail = 'Don''t know how to add "%s" and "%s"';
  sSubtractOpFail = 'Don''t know how to subtract "%s" and "%s"';
  sMultiplyOpFail = 'Don''t know how to multiply "%s" and "%s"';
  sDivideOpFail = 'Don''t know how to divide "%s" and "%s"';
  sNegateOpFail = 'Don''t know how to negate "%s"';
  sCompareOpFail = 'Don''t know how to compare "%s" and "%s"';
  sParserUnexpected = 'Expected %s but got %s';
  sInvalidFloatingPt = 'Invalid floating-point constant - expected one or more digits after "."';
  sInvalidFloatingPtExpt = 'Invalid floating-point constant - expected one or more digits as part of exponent';
  sUnterminatedString = 'Unterminated string found';
  sInvalidOperator = 'Invalid operator in source (%s)';
  sInvalidOperatorNum = 'Invalid character in source (#%d)';
  sExpectedEOF = 'Expected EOF - trailing text in expression';
  sTooManyArgs = 'Too many arguments';
  sExpectedIdentifier = 'Expected an identifier, number or string';
  sExpressionTooComplex = 'Expression too complex (too many constants)';
  sEvalStackOverflow = 'Stack underflow';
  sLookupError = 'Couldn''t find %s';
  sInvokeError = 'Tried to invoke non-function / non-indexed-property';
  sUnsupportedWrapper = 'Cannot determine value because the wrapper does not support IValue';
  sUnsupportedGroup = 'Cannot find result wrapper because the member wrapper does not support IGroup';
  sWrapError = 'Unable to wrap: %s';
  sEmptyOutValue = 'Expression evaluated an empty (nil) value and cannot be assigned';
  sClassConflict = 'Unexpected class conflict';
  sObjectTypeNotRegistered = 'Object type %s not registered';
  sScopeClassNotRegistered = 'Scope class %s not registered';
  sScopeClassAlreadyRegistered = 'Scope class %s is already registered';
  sInvalidCustomWrapper = 'The given custom wrapper does not support %s';
  sPropertyNotFound = 'Property %s not found';
  sNoGetterOrSetter = 'Need at least a getter or a setter.';
  sUpdateOutputLocFailed = 'Unable to recompile output expression for %s (%s)';
  sNoOutputScopes = 'An output scope is required';
  sVirtualMemberReadOnly = 'Virtual members are read-only.';
  sConvertWrapperFail = 'Cannot convert wrapper. It does not support %s';

  // Converters
  sNilToTDateTime = 'NilToDateTime';
  sNilToTDateTimeDesc = '';
  sNilToTStrings = 'NilToTStrings';
  sNilToTStringsDesc = '';
  sPersistentToPersistent = 'PersistentToPersistent';
  sPersistentToPersistentDesc = '';
  sBoolToString = 'BoolToString';
  sBoolToStringDesc = '';
  sStringToBool = 'StringToBool';
  sStringToBoolDesc = '';
  sNilToNumber = 'NilToNumber';
  sNilToNumberDesc = '';
  sIntegerToString = 'IntegerToString';
  sIntegerToStringDesc = '';
  sStringToInteger = 'StringToInteger';
  sStringToIntegerDesc = '';
  sFloatToString = 'FloatToString';
  sFloatToStringDesc = '';
  sStrToTDateTime = 'StrToTDateTime';
  sStrToTDateTimeDesc = '';
  sTDateTimeToStr = 'TDateTimeToStr';
  sTDateTimeToStrDesc = '';
  sStrToTDate = 'TStrTDate';
  sStrToTDateDesc = '';
  sStrToTTime = 'TStrTTime';
  sStrToTTimeDesc = '';
  sNilToString = 'NilToString';
  sNilToStringDesc = '';
  sNilToBoolean = 'NilToBoolean';
  sNilToBooleanDesc = '';
  sNilToVariant = 'NilToVariant';
  sNilToVariantDesc = '';
  sStringToVariant = 'StringToVariant';
  sStringToVariantDesc = '';
  sFloatToVariant = 'FloatToVariant';
  sFloatToVariantDesc = '';
  sIntToVariant = 'IntToVariant';
  sIntToVariantDesc = '';
  sBoolToVariant = 'BoolToVariant';
  sBoolToVariantDesc = '';
  sVariantToBool = 'VariantToBool';
  sVariantToBoolDesc = '';
  sStrToFloat = 'StrToFloat';
  sStrToFloatDesc = '';
  sFloatToInteger = 'FloatToInteger';
  sFloatToIntegerDesc = 'Convert float to integer using Round()';
  sTStringsToString = 'TStringsToString';
  sTStringToStringDesc = '';
  sStringToTStrings = 'StringToTStrings';
  sStringToTStringsDesc = '';
  sStringToChar = 'StringToChar';
  sStringToCharDesc = '';

  // Methods
  sToStrDesc = '';
  sToVariantDesc = '';
  sToNotifyEventDesc = '';
  sFormatDesc = '';
  sUpperCaseDesc = '';
  sLowerCaseDesc = '';

implementation

end.
