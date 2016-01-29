{ ********************************************************************* }
{                                                                       }
{                       Gnostice Streams                                }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit StreamExceptions;

interface

uses
  gtTypes;

const
  ErrInvalidBuffer = 'Invalid Buffer';
  ErrInvalidStream = 'Invalid Stream';
  ErrOutofMemory = 'Out of Memory';
  ErrCompression = 'Compression error';
  ErrInvalidFileID = 'Invalid File ID in Trailer';
  ErrInvalidOwnerKey = 'Invalid Owner Key';
  ErrInvalidUserKey = 'Invalid user key';
  ErrInvalidKeyLen = 'RC4: Invalid key length';

type
  ExInvalidBuffer = class(EPDFProcessor);
  ExInvalidStream = class(EPDFProcessor);
  ExOutofMemory = class(EPDFProcessor);
  ExCompressionError = class(EPDFProcessor);
  ExInvalidFileID = class(EPDFProcessor);
  ExInvalidOwnerKey = class(EPDFProcessor);
  ExInvalidUserKey = class(EPDFProcessor);
  ExInvalidKeyLen = class(EPDFProcessor);

implementation

end.
