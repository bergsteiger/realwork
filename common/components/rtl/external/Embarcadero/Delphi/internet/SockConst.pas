{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ *************************************************************************** }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

unit SockConst;

interface

resourcestring
  sUnknownCommand = 'Unknown command';
  sNoHost = 'No host';
  sSocketReadError = 'Socket read error';
  sCouldNotOpenRegKey = 'Unable to not open registry key: %s';
  sInvalidAction = 'Invalid Action %d';
  sInterpretDataException = 'Exception in InterpretData: %s';
  sInvalidDataPacket = 'Invalid data packet';
  sBadVariantType = 'Bad variant type %x';

{$IFDEF MSWINDOWS}
  sErrorExec = 'Can''t execute %s %d';
  sFailedTimeZoneInfo = 'Failed attempting to retrieve time zone information.';
{$ENDIF}
{$IFDEF LINUX}
  sErrorExecTimeout = 'Timeout occurred waiting for %s to execute';
  sErrorExecFail = 'Unable to execute %s';
  sErrorExecUnexpected = 'Unexpected error occurred executing %s';
{$ENDIF}

  sSocketRequestError = 'SocketRequest error in WebAppDbg: ';

implementation

end.

