{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{       Web server application components               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

// TUTF8ContentParser is a WebRequest content parser that parses UTF-8 requests.
// TUTF8ContentParser class automatically replace the default content parser when this unit (UTF8ContentParser)
// is used in a web application.  You should only use UTF8ContentParser in web applications that generate UTF-8
// responses.
//
// To generated UTF-8 encoded responses, set Response.ContentType as follows before setting Response.Content.
//    Response.ContentType := 'text/html; charset=UTF-8';
//
// Note that, if your application uses the ReqMulti unit to parse multipart content, ReqMulti must appear in the application
// uses list after UTF8ContentParser.


{$HPPEMIT LINKUNIT}
unit Web.UTF8ContentParser;

interface

uses Web.HTTPApp;


type
{ TUTF8ContentParser }

  TUTF8ContentParser = class(TContentParser)  // deprecated
  end;

implementation

end.
