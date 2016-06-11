{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Web.ApacheConst;

interface

resourcestring
  sHTTPDImplNotRegistered = 'Apache version implementation is not registered.  An Apache project must use a unit such as Web.HTTPD24Impl.';
  sMultipleVersions = 'Multiple Apache versions implementations are referenced by this project.  A project may not reference multiple versions such as Web.HTTPD22Impl and Web.HTTPD24Impl.';

implementation

end.
