{ $OmniXML: OmniXML/OmniXML.inc,v 1.4 2008/09/12 11:25:17 mremec Exp $ }

{***************************************************************************}
{ "Unit names renamed for integration with Gnostice libraries  - Gnostice"
{***************************************************************************}

{$IFDEF CONDITIONALEXPRESSIONS}

  {$IF Declared(CompilerVersion) and (CompilerVersion >= 14.0)}  // Delphi 6 or newer
    {$DEFINE HAS_UNIT_VARIANTS}
    {$DEFINE DELPHI6_UP}
  {$IFEND}  // Declared(CompilerVersion) and (CompilerVersion >= 14.0)

  {$IFDEF UNICODE}  // Delphi with Unicode support
    {$DEFINE OmniXML_Unicode}
  {$ENDIF}  // UNICODE

{$ENDIF}  // CONDITIONALEXPRESSIONS

{$IFDEF LINUX}
  {$DEFINE OmniXML_WantWideString}
{$ENDIF}  // LINUX

{$IFDEF OmniXML_WantWideString}
  {$UNDEF OmniXML_Unicode}
{$ENDIF}  // OmniXML_WantWideString

{$IFDEF FPC}
  {$DEFINE OmniXML_Unicode}
  {$DEFINE UNICODE}
{$ENDIF}

{$I gtOmniXML_JEDI.inc}
