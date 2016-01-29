{ $Id: TB97VER.INC,v 1.13 2015/06/22 06:06:25 kostitsin Exp $ }

{ Determine Delphi/C++Builder version }
{$IFNDEF WIN32} Delphi 1 is not supported. {$ENDIF}
{$IFNDEF VER90}  { if it's not Delphi 2.0 }
  {$IFNDEF VER93}  { and it's not C++Builder 1.0 }
    {$DEFINE TB97D3}  { then it must be at least Delphi 3 or C++Builder 3 }
    {$IFNDEF VER100}  { if it's not Delphi 3.0 }
      {$IFNDEF VER120}  { Delphi 4's command line compiler doesn't like the ObjExportAll directive, so don't include it on Delphi 4 }
        {$ObjExportAll On}  { <- needed for compatibility with run-time packages in C++Builder 3 }
      {$ENDIF}
      {$IFNDEF VER110}  { and it's not C++Builder 3.0 }
        {$DEFINE TB97D4}  { then it must be at least Delphi 4 or C++Builder 4 }
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$ALIGN ON}
{$BOOLEVAL OFF}
{$LONGSTRINGS ON}
{$WRITEABLECONST ON}

{$Include l3Define.inc}

{$Define tb97NeedCustomGlyphDraw}
{$Define tb97NeedMouseEvents}
{$Define tb97NeedWordWrap}
{$Define tb97NeedOnDropdown}
{$Define tb97NeedSpacing}

{$IfDef Nemesis}
 {$Ifndef DesignTimeLibrary}
  {$Undef tb97NeedCustomGlyphDraw}
 {$Endif}
 {$Undef tb97NeedMouseEvents}
 {.$Undef tb97NeedWordWrap}
 {$Undef tb97NeedOnDropdown}
 {$Undef tb97NeedSpacing}
 {$Define tb97DoCache}
 {$Define NemesisToolButtonStyle}
{$EndIf Nemesis}

{.$Define tb97NeedRepeating}
{.$WriteableConst On}
