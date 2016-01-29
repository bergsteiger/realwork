{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXOpenSSLRes;

interface

resourcestring
  SOpenSSLLoadError     = 'Loading SSL module failed. One or more mapped methods are not available.';
  SOpenSSLNotLoaded     = 'SSL module was not loaded or it was not loaded successful. Use LoadSSL method to load the module';
  SKeyCannotBeGenerated = 'RSA key generation failed';
  STooMuchData          = 'Cannot %s more than %d bytes; current size is %d';
  SEncryptWord          = 'encrypt';
  SDecryptWord          = 'decrypt';
  sSSLAlreadyLoaded     = 'SSL module was already loaded and the IP implementation cannot be changed.';

implementation

end.
