{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.NetConsts;

interface

resourcestring
  { HTTP }
  SSchemeAlreadyRegistered = 'Scheme "%s" already registered for %s';
  SCredentialInvalidUserPassword = 'Credential without user or password';
  SNetPlatformFunctionNotImplemented = 'Platform-dependant function not implemented';
  SNetSchemeFunctionNotImplemented = 'Scheme-dependant function not implemented';
  SNetUriMethodAlreadyAssigned = 'Method already assigned';
  SNetUriURLAlreadyAssigned = 'URL already assigned';
  SNetUriIndexOutOfRange = 'Parameter index (%d) out of range (%d..%d)';
  SNetUriInvalid = 'Invalid URL: "%s"';
  SNetUriParamNotFound = 'Parameter "%s" not found';

  SNetHttpMaxRedirections = 'Maximum number of redirections (%d) exceeded';
  SNetHttpGetServerCertificate = 'Error getting Server Certificate';

  SNetHttpInvalidServerCertificate = 'Server Certificate Invalid or not present';
  SNetHttpServerCertificateNotAccepted = 'Server Certificate not accepted';
  SNetHttpEmptyCertificateList = 'Empty certificate list';
  SNetHttpUnspecifiedCertificate = 'Unspecified certificate from client';
  SNetHttpRejectedCertificate = 'Client rejected the certificate';
  SNetHttpIdentitiesError = 'Error obtaining identities';
  SNetHttpCertificatesError = 'Error obtaining certificates';
  SNetHttpIdentityCertError = 'Error getting the identity of the certificate';
  SNetHttpCertificateImportError = 'Error importing certificate';

  SNetHttpClientUnknownError = 'Execution of request terminated with unknown error';

  SNetHttpClientErrorAccessing = 'Error %d accessing to %s: %s';

  SNetHttpComponentRequestClient = 'Client not assigned to request component';

  SNetHttpHeadersError = 'Error querying headers: (%d) %s';

  SNetHttpClientHandleError = 'Error obtaining session handle';
  SNetHttpClientSendError = 'Error sending data: (%d) %s';
  SNetHttpClientReceiveError = 'Error receiving data: (%d) %s';

  SNetHttpRequestConnectError = 'Error connecting to server: %s';
  SNetHttpRequestOpenError = 'Error opening request: (%d) %s';
  SNetHttpRequestAddHeaderError = 'Error adding header: (%d) %s';
  SNetHttpRequestRemoveHeaderError = 'Error removing header: (%d) %s';
  SNetHttpRequestQueryDataError = 'Error querying data available: (%d) %s';
  SNetHttpRequestReadDataError = 'Error reading data: (%d) %s';
  SNetHttpRequestSetTimeoutError = 'Error setting timeout for the request: (%d) %s';
  SNetHttpClientResponseError = 'Error obtaining response data';

  { Beacon }
  SAPINotAvailable = 'Beacon API not available on this platform';
  SBeaconNoDeviceRegister = 'No Beacon device registered';
  SNotAllowedLocationServices = 'You are not allowed to use location services.';
  SCannotChangeBeaconType = 'Beacon type cannot be changed in this mode';
  SMonitoringNotAvailable = 'Monitoring is not available on this device.';
  SManagerOnlyInMode = 'This manager can only be used in %s mode.';
  SBeaconDeviceNoUUID = 'You must provide a proximity UUID';
  SBeaconIncorrectMID = 'Incorrect ManufacturerId';
  SBeaconIncorrectEddyNamespace = 'Invalid Namespace ID (10 Hex num)';
  SBeaconIncorrectEddyInstance = 'Invalid Instance ID (6 Hex num)';
  SiOSiBeaconMustBeRegistered = 'A region must be registerded in order to scan for iBeacons due to Core Location framework.';

  SBeaconMDHelperModesNotPermitted = 'These modes are not permitted';

  SEddystoneAdvertiseNotSupported = 'Eddystone format not supported';
  SInvalidEddystoneNamespace = '%s is not a valid Eddystone namespace';
  SInvalidEddystoneInstance = '%s is not a valid Eddystone instance';
  SIncorrectTxPower = 'We have fixed the TxValue for this beacon, previous value was %d';



  { Sockets }
  sSocketError = 'Network socket error: %s (%d), on API ''%s''';
  sSocketAlreadyClosed = 'Socket already closed';
  sSocketNotListening = 'Socket not listening';
  sIncorrectSocketType = 'Socket type not compatible with call';
  sBroadcastOnUDPOnly = 'Only UDP socket types support broadcasts';
  sSocketNotValid = 'Invalid socket handle';
  sFDSetSizeTooLarge = 'Number of sockets must not exceed FD_SETSIZE(%d)';
  sFunctionNil = 'Async function must not be nil';

  { Bluetooth }
  SBluetoothOperationNotSupported = 'Operation not supported with this descriptor kind: %s';
  SBluetoothMissingImplementation = 'No BluetoothManager implementation found';
  SBluetoothInvalidServiceName = 'Invalid service name, you must provide one.';

  SBluetoothNotImplemented = 'Not supported in this platform';
  SBluetoothDeviceNotFound = 'Bluetooth device not found: disconnected or turned off';
  SBluetoothNoDiscoverable = 'Cannot set discoverable mode';
  SBluetoothCanNotConnect = 'Cannot connect to device: %s';
  SBluetoothNoService = 'Cannot get service record for the service: %s on device: %s';
  SBluetoothNoRFChannel = 'Cannot get RFCOMM channel ID to connect to the device: %s, service: %s';
  SBluetoothCanNotRemoveService = 'Cannot remove service: %s';
  SBluetoothRFChannelClosed = 'Channel is closed, cannot read data';
  SBluetoothCanNotSendData = 'Error sending data over current channel';

  SBluetoothScanModeError = 'The bluetooth adapter is in unknown scan mode';
  SBluetoothStateError = 'Cannot retrieve the state of the bluetooth adapter';
  SBluetoothNotSupported = 'Operation "%s" not supported on %s';
  SBluetoothDeviceStateError = 'Cannot get state for device: %s';
  SBluetoothSocketOutputStreamError = 'Cannot create Socket Output Stream';
  SBluetoothCharacteristicError = 'Error while working with characteristic, error message: %s, %d';
  SBluetoothDescriptorTypeError = 'Not applicable to this descriptor type';
  SBluetoothSettingPropertyError = 'Error setting property: %s';
  SBluetoothAndroidVersionError = 'Need at least Android %s (API %s)';

  SBluetoothServiceListError = 'Error getting service list: (%d) %s';
  SBluetoothDeviceInfoError = 'Error getting device info: (%d) %s';
  SBluetoothAcceptError = 'Error trying to accept connections';
  SBluetoothUnregisterError = 'Error unregistering service: %s';
  SBluetoothCreateSocketError = 'Unable to create server socket';
  SBluetoothServerSocket = 'Cannot create server socket: %s';
  SBluetoothServiceError = 'Service registration error(%d): %s';
  SBluetoothServiceAlreadyExists = 'Service %s is already added to this server';
  SBluetoothRCVTIMEOError = 'Error calling setsockopt SO_RCVTIMEO: %s';
  SBluetoothWisockInitError = 'Bluetooth: Unable to initialize Winsock';
  SBluetoothWisockCleanupError = 'Bluetooth: Unable to clean up Winsock';
  SBluetoothSetSockOptError = 'Error calling setsockopt: %s';
  SBluetoothClientsocketError = 'Cannot create client socket';
  SBluetoothClientConnectError = 'Cannot connect to device: (%d) %s';
  SBluetoothSendDataError = 'Cannot send data: (%d) %s';
  SBluetoothWSALookupError = 'Bluetooth: WSALookupServiceBegin error: (%d) %s';
  SBluetoothUsedGUIDError = 'Unable to create server socket: the specified GUID is in use';

  SBluetoothIntegerFormatType = 'Format type (%d) for Integer conversion is not supported';
  SBluetoothSingleFormatType = 'Format type (%d) for Single conversion is not supported';

  { Bluetooth LE }
  SBluetoothLECanNotFindCharacteristic = 'Cannot find characteristic: %s';
  SBluetoothLECanNotFindDescriptor = 'Cannot find descriptor: %s';
  SBluetoothLECanNotDiscoverServices = 'Cannot discover services for device: %s';
  SBluetoothLECanNotGetIncludedServices = 'Cannot get list of included services for service: %s';
  SBluetoothLECharacteristicExists = 'Characteristic with UUID: %s already exists';
  SBluetoothLENoCharacteristics = 'Cannot get list of characteristics for service: %s';
  SBluetoothLENoDescriptors = 'Cannot get list of descriptors for characteristic: %s';
  SBluetoothOSVersionError = 'At least MacOS X 10.9 or iOS 6 is required to create Gatt servers';

  SBluetoothLEGetDevicesError = 'Cannot get list of LE devices: (%d) %s';
  SBluetoothLEGetDeviceError = 'Cannot get the LE device';
  SBluetoothLENoDeviceAssigned = 'No Device assigned';
  SBluetoothLEDeviceHandleError = 'Bluetooth: Create LE device handle error: (%d) %s';
  SBluetoothLEGattServiceError = 'Bluetooth: BluetoothGATTGetServices res: %d(%X) error: (%d) %s';
  SBluetoothLEGattIncludedServicesError = 'Bluetooth: BluetoothGATTGetIncludedServices error:  (%d) %s';
  SBluetoothLEGetServicesHandle = 'SetupDiGetClassDevs error: (%d) %s';
  SBluetoothLENoServiceAssigned = 'No Service assigned';
  SBluetoothLEDeviceNotPaired = 'This device is not paired';
  SBluetoothLEDeviceDisconnectedExplicity = 'This device was disconnected explicity';
  SBluetoothLEAdvertisementEmpty = 'The advertisement is empty';

  ADVERTISE_FAILED_DEVICE_NOT_SUPPORTED = 'The device does not support peripheral mode';
  ADVERTISE_FAILED_DATA_TOO_LARGE = 'Failed to start advertising as the advertise data to be broadcasted is larger than 31 bytes';
  ADVERTISE_FAILED_TOO_MANY_ADVERTISERS = 'Failed to start advertising because no advertising instance is available';
  ADVERTISE_FAILED_ALREADY_STARTED = 'Failed to start advertising as the advertising is already started';
  ADVERTISE_FAILED_INTERNAL_ERROR = 'Operation failed due to an internal error';
  ADVERTISE_FAILED_FEATURE_UNSUPPORTED = 'This feature is not supported on this platform';
  ADVERTISE_FAILED_UNKNOWN_ERROR = 'There was an unknown error';

const
  DefaultUserAgent = 'Embarcadero URI Client/1.0'; // Do not translate

  // Common Header Names
  sUserAgent = 'User-Agent'; // Do not translate
  sAccept = 'Accept'; // Do not translate
  sAcceptCharset = 'Accept-Charset'; // Do not translate
  sAcceptEncoding = 'Accept-Encoding'; // Do not translate
  sAcceptLanguage = 'Accept-Language'; // Do not translate
  sContentEncoding = 'Content-Encoding'; // Do not translate
  sContentLanguage = 'Content-Language'; // Do not translate
  sContentLength = 'Content-Length'; // Do not translate
  sContentType = 'Content-Type'; // Do not translate
  sLastModified = 'Last-Modified'; // Do not translate

  sXMethodOverride = 'x-method-override'; // Do not translate

  sWWWAuthenticate  = 'WWW-Authenticate'; // Do not translate
  sProxyAuthenticate  = 'Proxy-Authenticate'; // Do not translate

implementation

end.
