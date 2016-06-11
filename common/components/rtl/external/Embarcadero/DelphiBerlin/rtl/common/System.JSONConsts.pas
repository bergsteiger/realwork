{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.JSONConsts;

interface

resourcestring
  SCannotCreateObject = 'The input value is not a valid Object';
  SUTF8Start = 'UTF8: A start byte not followed by enough continuation bytes in position %s';
  SUTF8UnexpectedByte = 'UTF8: An unexpected continuation byte in %s-byte UTF8 in position %s';
  SUTF8InvalidHeaderByte = 'UTF8: Type cannot be determined out of header byte at position %s';
  SFieldValueMissing = 'Internal: Field %s has no serialized value';
  SFieldExpected = 'Internal: Field %s conversion is incomplete';
  SArrayExpected = 'Internal: Array expected instead of %s';
  SValueExpected = 'Internal: JSON value expected instead of %s';
  SNoArray = 'Internal: Array expected instead of nil';
  SInvalidContext = 'Internal: Current context cannot accept a value';
  SObjectExpectedForPair = 'Internal: Object context expected when processing a pair';
  SInvalidContextForPair = 'Internal: Current context cannot accept a pair';
  SNoConversionForType = 'Internal: No conversion possible for type: %s';
  SInconsistentConversion = 'Internal: Conversion failed, converted object is most likely incomplete';
  STypeNotSupported = 'Internal: Type %s is not currently supported';
  SNoTypeInterceptorExpected = 'Field attribute should provide a field interceptor instead of a type one on field %s';

  SCannotCreateType = 'Internal: Cannot instantiate type %s';
  SObjectExpectedInArray = 'Object expected at position %d in JSON array %s';
  SStringExpectedInArray = 'String expected at position %d in JSON array %s';
  SArrayExpectedForField = 'JSON array expected for field %s in JSON %s';
  SObjectExpectedForField = 'JSON object expected for field %s in JSON %s';
  SInvalidJSONFieldType = 'Un-marshaled array cannot be set as a field value. A reverter may be missing for field %s of %s';
  SNoValueConversionForField = 'Internal: Value %s cannot be converted to be assigned to field %s in type %s';
  SInvalidTypeForField = 'Cannot set value for field %s as it is expected to be an array instead of %s';
  SNoConversionAvailableForValue = 'Value %s cannot be converted into %s. You may use a user-defined reverter';
  SValueNotFound = 'Value ''%s'' not found';
  SCannotConvertJSONValueToType = 'Conversion from %0:s to %1:s is not supported';
  SEndOfPath = 'End of path';
  SErrorInPath = 'Error in path';
  
  { Marshalling }
  SBadEscapeSequence = 'Bad JSON escape sequence: %s';
  SErrorConvertStringToDatetime = 'Could not convert string to DateTime: %s';
  SErrorConvertStringToDouble = 'Could not convert string to double: %s';
  SErrorConvertStringToInteger = 'Could not convert string to integer: %s';
  SFormatMessageLinePos = ', line %d, position %d';
  SFormatMessagePath = 'Path ''%s''';
  SIdentationGreaterThanZero = 'Indentation value must be greater than 0';
  SInputInvalidDouble = 'Input string %s is not a valid double';
  SInputInvalidInteger = 'Input string %s is not a valid integer';
  SInputInvalidNumber = 'Input string %s is not a valid number';
  SInvalidCharacterAfterProperty = 'Invalid character after parsing property name. Expected '':'' but got: %s';
  SInvalidCloseToken = 'Not a valid close JsonToken: %s';
  SInvalidJavascriptProperty = 'Invalid JavaScript property identifier character: %s.';
  SInvalidJavascriptQuote = 'Invalid JavaScript string quote character. Valid quote characters are '' and "';
  SInvalidJsonToken = 'Invalid JsonToken: %s';
  SInvalidObjectId = 'An ObjectId must be 12 bytes';
  SInvalidPropertyCharacter = 'Invalid property identifier character: %s';
  SInvalidState = 'Invalid state: %s';
  SInvalidTokenForContainer = 'JsonToken %s is not valid for closing JsonType %s.';
  SNoTokenForType = 'No close token for type %s';
  SNoTokenToClose = 'No token to close.';
  SParseErrorBoolean = 'Error parsing boolean value.';
  SParseErrorComment = 'Error parsing comment. Expected: *, got %s.';
  SParseErrorNan = 'Cannot read NaN value.';
  SParseErrorNegativeInfinity = 'Cannot read Infinity value';
  SParseErrorNull = 'Error parsing null value.';
  SParseErrorPositiveInfinity = 'Cannot read -Infinity value';
  SParseErrorUndefined = 'Error parsing undefined value';
  SReadErrorContainerEnd = 'Read past end of current container context';
  SReaderAdditionalText = 'Additional text encountered after finished reading JSON content: %s.';
  SReaderMaxDepthExceeded = 'The reader''s MaxDepth of %s has been exceeded.';
  SRequiredPropertyName = 'A name is required when setting property name state';
  STokenInStateInvalid = 'Token %s in state %s would result in an invalid JSON object.';
  SUnexpecteCharAfterValue = 'After parsing a value an unexpected character was encountered: %s';
  SUnexpectedBytesEnd = 'Unexpected end when reading bytes.';
  SUnexpectedCharConstructor = 'Unexpected character while parsing constructor: %s';
  SUnexpectedCharNumber = 'Unexpected character encountered while parsing number: %s';
  SUnexpectedCharValue =  'Unexpected character encountered while parsing value: %s.';
  SUnexpectedCommentEnd = 'Unexpected end while parsing comment';
  SUnexpectedConstructorEnd = 'Unexpected end while parsing constructor.';
  SUnexpectedEnd = 'Unexpected end';
  SUnexpectedEndConstructorDate = 'Unexpected end when reading date constructor';
  SUnexpectedJsonContent = 'Unexpected content while parsing JSON';
  SUnexpectedObjectByteEnd = 'Unexpected end of object byte value';
  SUnexpectedState = 'Unexpected state: %s';
  SUnexpectedTokenCodeWScope = 'Error reading code with scope. Unexpected token: %s';
  SUnexpectedTokenDate = 'Error reading date. Unexpected token: %s';
  SUnexpectedTokenDateConstructorExpEnd = 'Unexpected token when reading date constructor. Expected EndConstructor, got %s';
  SUnexpectedTokenDateConstructorExpInt = 'Unexpected token when reading date constructor. Expected Integer, got %s';
  SUnexpectedTokenDouble = 'Error reading double. Unexpected token: %s';
  SUnexpectedTokenInteger = 'Error reading integer. Unexpected token: %s';
  SUnexpectedTokenReadBytes ='Unexpected token when reading bytes: %s';
  SUnexpectedTokenString = 'Error reading string. Unexpected token: %s';
  SUnexpectedTypeOnEnd = 'Unexpected type when writing end: %s';
  SUnexpectedUnicodeCharEnd = 'Unexpected end while parsing unicode character';
  SUnexpectedUnquotedPropertyEnd = 'Unexpected end while parsing unquoted property name';
  SUnknowContainerType = 'Unknown JsonType: %s';
  SUnsupportedBsonConstructor = 'Cannot write JSON constructor as BSON';
  SUnsupportedBsonRaw = 'Cannot write raw JSON as BSON';
  SUnsupportedJSONValueRaw = 'Write raw JSON is unsupported';
  SUnsupportedJSONValueConstructor = 'Write constructor is unsupported';
  SUnsupportedCommentBson = 'Cannot write JSON comment as BSON';
  SUnsupportedType = 'Unsupported type: %s';
  SUnterminatedString = 'Unterminated string. Expected delimiter: %s.';
  SWhitespaceOnly = 'Only white space characters should be used.';
  SUnexpectedExtJSONToken = 'Unexpected token when reading Extended JSON value %s. Expected token: %s';

{ TJSONPathParser }
  SJSONPathUnexpectedRootChar = 'Unexpected char for root element: .';
  SJSONPathEndedOpenBracket = 'Path ended with an open bracket';
  SJSONPathEndedOpenString = 'Path ended with an open string';
  SJSONPathInvalidArrayIndex = 'Invalid index for array: %s';
  SJSONPathUnexpectedIndexedChar ='Unexpected character while parsing indexer: %s';
  SJSONPathDotsEmptyName = 'Empty name not allowed in dot notation, use ['''']';

  { TJsonSerializer }
  SUnexpectedTokenDeserializeObject = 'Unexpected token while deserializing object: %s';
  SUnexpectedEndDeserializeArray = 'Unexpected end when deserializing array';
  SUnexpectedEndDeserializeObject = 'Unexpected end when deserializing object';
  SUnexpectedEndDeserializeValue = 'Unexpected end when deserializing value';
  SUnexpectedTypePrimitiveContract = 'Unexpected type to create a primitive contract';
  SUnexpectedTokenReadObject = 'Unexpected type while read json object';
  SUnexpectedTokenReadArray = 'Unexpected type while read json array';
  SErrorObjectNotInstantiable = 'Object cannot be instantiated';
  SUnexpectedEnumerationValue = 'Unexpected value %s';
  SUnexpectedToken = 'Unexpected token %s';
  SUnexpectedTokenPopulateObject = 'Unexpected Token while populate an Object';
  SUnexpectedTokenPopulateArray = 'Unexpected Token while populate an Array';
  SWriteJsonNotImplemented = 'WriteJson is not implemented cause CanWrite is False';
  SReadJsonNotImplemented = 'ReadJson is not implemented cause CanRead is False';
  SErrorTypeNotInstantiable = 'Type %s cannot be instantiated';
  SCannotFindFieldForType = 'Cant find %s field for the given type %s';
  SCannotFindPropertyForType = 'Cant find %s property for the given type %s';
  SCannotFindType = 'Cant find %s property for the given type %s';
  SConverterNotMatchingType = 'Type of Value ''%s'' does not match with the expected type: ''%s''';
  SConverterStringNotMatchingEnum = 'The string ''%s'' does not match any value of %s';
  

  STypeArgumentNil = 'Type is nil';
  SDefaultReferenceResolverInternally = 'The DefaultReferenceResolver can only be used internally';

  { System.JSON.Builders }
  sJSONBuilderNotEmpty = 'This operation is not permitted after pairs or elements have been added';
  sJSONBuilderNotParentType = 'This operation is not permitted on the current JSON type';
  sJSONBuilderUnsupVarRecType = 'Cannot add element of unsupported TVarRec type %d';
  sJSONBuilderUnsupVariantType = 'Cannot add element of unsupported Variant type %d';
  sJSONBuilderInvalidOpenArrayItem = 'Failed to append open array on item with index  %d';
  sJSONBuilderInvalidSetOfItems = 'Failed to append not properly closed set of items';
  sJSONBuilderNoReaderCallback = 'This operation is not permitted without assigned callback';
  sJSONIteratorInvalidState = 'Cannot iterate due to invalid iterator state';
  sJSONIteratorNoReaderCallback = 'This operation is not permitted without assigned callback';

implementation

end.
