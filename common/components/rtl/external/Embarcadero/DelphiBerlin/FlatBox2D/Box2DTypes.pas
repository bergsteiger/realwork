// ==========================================================================
//
//   Copyright(c) 2012-2014 Embarcadero Technologies, Inc.
//
// ==========================================================================

//
// Delphi-C++ Library Bridge
// Interface for library Box2D
//

unit Box2DTypes;

interface

uses System.Types;

type

{$IF DEFINED(ANDROID)}
  tdCharPtr = MarshaledAString;
{$ELSEIF DEFINED(IOS)}
  tdCharPtr = MarshaledAString;
{$ELSE}
  tdCharPtr = PAnsiChar;
{$ENDIF}

 
  TDWordFiller = record 
  {$IF (defined(CPUX64) or defined(CPUARM64))} 
    Filler: array[1..4] of Byte; 
  {$ENDIF} 
  end; 
  

implementation

end.
