{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit JBIG2Stream;

interface

uses
  Classes, Stream, FilterStream;

{$IFDEF JBIG2}
type
  TgtJBIG2Stream = class(TgtFilterStream)

  end;
{$ENDIF}

implementation

end.
