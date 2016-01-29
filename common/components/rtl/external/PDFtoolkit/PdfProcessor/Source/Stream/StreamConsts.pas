{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit StreamConsts;

interface

const
  ENDOFFILE = -1; // End of File (EOF)
  NUL = 00; // Null
  BACKSPACE = 08; // Backspace
  TABSPACE = 09; // Tab
  LINEFEED = 10; // Line Feed
  FORMFEED = 12; // Form Feed (PageBreak)
  CARRIAGERETURN = 13; // Carriage Return
  SPACE = 32; // Space

  CRLF = #10 + #13;

  //Internal Error Messages
  ErrStrReadRawChar = 'Internal: Cannot call ReadRawChar' +
    'on a non-predictor stream';
  ErrStrWrite = 'Internal: Cannot call Write on TgtStream';




implementation

end.
