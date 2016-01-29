{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDBaseExceptions;

interface

uses
  gtTypes;

resourcestring
  ErrInvalidFileName = 'Invalid file name';
  ErrFileCreateError = 'File create error: ';
  ErrInvalidStream = 'Invalid Stream';
  ErrFileOpenError = 'File Open error';
  ErrFileNotFound = 'File Not Found';
  ErrInvalidObject = 'Invalid Object';
  ErrOutOfMemory = 'Out of memory';
  ErrInvalidPassword = 'Invalid password';
  ErrStartXrefNotFound = 'startxref not found';
  ErrBadRootObj = 'Catalog not found';
  ErrNoPageTree = 'No Page Entry in Catalog';
  ErrInvalidPDFFile = 'Invalid PDF Document';
  ErrImproperCrossRefTableOrStream = 'Improper Cross reference Table or Stream';


type
  ExInvalidFileName = class(EPDFProcessor);
  ExFileCreateError = class(EPDFProcessor);
  ExFileNotFound = class(EPDFProcessor);
  ExInvalidStream = class(EPDFProcessor);
  ExFileOpenError = class(EPDFProcessor);
  ExInvalidObject = class(EPDFProcessor);
  ExOutOfMemory = class(EPDFProcessor);
  ExInvalidPassword = class(EPDFProcessor);
  ExStartXrefNotFound = class(EPDFProcessor);
  ExBadRootObj = class(EPDFProcessor);
  ExNoPageTreeObj = class(EPDFProcessor);
  ExInvalidPDFFile = class(EPDFProcessor);
  ExImproperCrossRefTableOrStream = class(EPDFProcessor);

implementation

end.
