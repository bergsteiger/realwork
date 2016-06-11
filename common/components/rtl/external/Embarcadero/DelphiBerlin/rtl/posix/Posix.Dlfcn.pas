{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Dlfcn;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base;

{$IFDEF MACOS}
{$I osx/DlfcnTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/DlfcnTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/DlfcnTypes.inc}
{$ENDIF}

{$I DlfcnAPI.inc}

{$HPPEMIT '#include <dlfcn.h>'}
{$IF defined(ANDROID)}
// In Android dlfcn.h header file there isn't any dl_info on the tag
// namespace, like is on MACOS. It is declared as anonymous (no tag)
// structure and directly typedef'd as Dl_info.
(*$HPPEMIT 'typedef Dl_info dl_info;' *)
{$ENDIF} { defined(ANDROID) }


implementation

end.
