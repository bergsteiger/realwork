{*********************************************************}
{* XMLPartner: XpDefine.INC 2.56                         *}
{* Copyright (c) TurboPower Software Co 2002             *}
{* All rights reserved.                                  *}
{*********************************************************}
{* XMLPartner: Compiler options/directives include file  *}
{*********************************************************}

{NOTE: XPDEFINE.INC is included in all XMLPartner units; hence you can
       specify global compiler options here. XPDEFINE.INC is included
       *before* each unit's own required compiler options, so options
       specified here could be overridden by hardcoded options in the
       unit source file.}

{====Compiler options that can be changed====}
{$A+ Force alignment on word/dword boundaries}
{$S- No stack checking}


{====Determination of compiler (do NOT change)====}
{$IFDEF VER100}
  {$DEFINE Delphi3}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE CBuilder3}
{$ENDIF}
{$IFDEF VER120}
  {$DEFINE Delphi4}
  {$DEFINE DCC4OrLater}
{$ENDIF}
{$IFDEF VER125}
  {$DEFINE CBuilder4}
  {$DEFINE DCC4OrLater}
{$ENDIF}
{$IFDEF VER130}
  {$DEFINE DCC4OrLater}
  {$DEFINE DCC5OrLater}
  {$IFNDEF BCB}
    {$DEFINE Delphi5}
  {$ELSE}
    {$DEFINE CBuilder5}
  {$ENDIF}
{$ENDIF}
{$IFDEF VER140}
  {$DEFINE DCC4OrLater}
  {$DEFINE DCC5OrLater}
  {$DEFINE DCC6OrLater}
  {$IFNDEF BCB}
    {$DEFINE Delphi6}
  {$ELSE}
    {$DEFINE CBuilder6}
  {$ENDIF}
{$ENDIF}
{$ifdef VER150}
  {$DEFINE DCC4OrLater}
  {$DEFINE DCC5OrLater}
  {$DEFINE DCC6OrLater}
  {$define Delphi6}
{$endif}

{ Determine if using VCL or CLX }
{$IFDEF LINUX}
{$DEFINE UsingCLX }
{$ENDIF LINUX}

{$IFNDEF MSWINDOWS}
  {$IFNDEF LINUX}
    {$DEFINE MSWINDOWS}
  {$ENDIF}
{$ENDIF MSWINDOWS}

{====Global fixed compiler options (do NOT change)====}
{---Delphi 3---}
  {$IFDEF Delphi3}
  {$B- Incomplete boolean evaluation}
  {$H+ Long string support}
  {$J+ Writeable typed constants}
  {$P- No open string parameters}
  {$T- No type-checked pointers}
  {$V- No var string checking}
  {$X+ Extended syntax}
  {$Z1 Enumerations are word sized}
  {$ENDIF}
{---Delphi 4---}
  {$IFDEF Delphi4}
  {$B- Incomplete boolean evaluation}
  {$H+ Long string support}
  {$J+ Writeable typed constants}
  {$P- No open string parameters}
  {$T- No type-checked pointers}
  {$V- No var string checking}
  {$X+ Extended syntax}
  {$Z1 Enumerations are word sized}
  {$ENDIF}
{---Delphi 5---}
  {$IFDEF Delphi5}
  {$B- Incomplete boolean evaluation}
  {$H+ Long string support}
  {$J+ Writeable typed constants}
  {$P- No open string parameters}
  {$T- No type-checked pointers}
  {$V- No var string checking}
  {$X+ Extended syntax}
  {$Z1 Enumerations are word sized}
  {$ENDIF}
{---Delphi 6---}
  {$IFDEF Delphi6}
  {$B- Incomplete boolean evaluation}
  {$H+ Long string support}
  {$J+ Writeable typed constants}
  {$P- No open string parameters}
  {$T- No type-checked pointers}
  {$V- No var string checking}
  {$X+ Extended syntax}
  {$Z1 Enumerations are word sized}
  {$ENDIF}
{---C++Builder 3---}
  {$IFDEF CBuilder3}
  {$B- Incomplete boolean evaluation}
  {$H+ Long string support}
  {$J+ Writeable typed constants}
  {$P- No open string parameters}
  {$T- No type-checked pointers}
  {$V- No var string checking}
  {$X+ Extended syntax}
  {$Z1 Enumerations are word sized}
  {$OBJEXPORTALL ON}
  {$ENDIF}
{---C++Builder 4---}
  {$IFDEF CBuilder4}
  {$B- Incomplete boolean evaluation}
  {$H+ Long string support}
  {$J+ Writeable typed constants}
  {$P- No open string parameters}
  {$T- No type-checked pointers}
  {$V- No var string checking}
  {$X+ Extended syntax}
  {$Z1 Enumerations are word sized}
  {$OBJEXPORTALL ON}
  {$ENDIF}
{---C++Builder 5---}
  {$IFDEF CBuilder5}
  {$B- Incomplete boolean evaluation}
  {$H+ Long string support}
  {$J+ Writeable typed constants}
  {$P- No open string parameters}
  {$T- No type-checked pointers}
  {$V- No var string checking}
  {$X+ Extended syntax}
  {$Z1 Enumerations are word sized}
  {$OBJEXPORTALL ON}
  {$ENDIF}
{---C++Builder 6---}
  {$IFDEF CBuilder6}
  {$B- Incomplete boolean evaluation}
  {$H+ Long string support}
  {$J+ Writeable typed constants}
  {$P- No open string parameters}
  {$T- No type-checked pointers}
  {$V- No var string checking}
  {$X+ Extended syntax}
  {$Z1 Enumerations are word sized}
  {$OBJEXPORTALL ON}
  {$ENDIF}


{====General defines=================================================}

{Disable the following define to disable support for retrieval of files
 via HTTP and FTP. }
{$DEFINE XpUseInet}

{-------- !! DO NOT CHANGE DEFINES BELOW THIS LINE !! --------}

{$DEFINE XPDSTD}


