{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDModelException;

interface

uses
  gtTypes;

const
  ErrBadAction = 'Bad Action object';
  ErrBadAnnotation = 'Bad Annotation object';
  ErrPasswordRequired = 'Encrypted PDF: Password required for loading';
  ErrPage = 'Bad Page object';
  ErrFileCreateError = 'Error occured when creating the File';

type
  ExBadAction = class(EPDFProcessor);
  ExBadAnnotation = class(EPDFProcessor);
  ExPasswordRequired = class(EPDFProcessor);
  ExBadPage = class(EPDFProcessor);
  ExFileCreateError = class(EPDFProcessor);

implementation

end.
