{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.StdDef;

{$WEAKPACKAGEUNIT}

interface

{$IFDEF MACOS}
{$I osx/StdDefTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/StdDefTypes.inc}
{$ENDIF LINUX}

implementation

end.
