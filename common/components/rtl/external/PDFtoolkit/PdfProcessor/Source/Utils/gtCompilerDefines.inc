{ ********************************************************************* }
{                                                                       }
{                        Gnostice PDF Processor                         }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

//Delphi 5
{$IFDEF VER130}
  {$DEFINE VCL4ORABOVE}
  {$IFDEF BCB}
    {$DEFINE CBUILDER5}
    {$DEFINE ALLOW_NAMED_THREADS}
	{$ObjExportAll On}
  {$ELSE}
    {$DEFINE DELPHI5}
  {$ENDIF}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL50}
{$ENDIF}

//Delphi 6
{$IFDEF VER140}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$IFDEF BCB}
    {$DEFINE CBUILDER6}
    {$DEFINE ALLOW_NAMED_THREADS}
	{$ObjExportAll On}
  {$ELSE}
    {$DEFINE DELPHI6}
  {$ENDIF}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL60}
{$ENDIF}

//Delphi 7
{$IFDEF VER150}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL70}
  {$IFDEF BCB}
    {$DEFINE CBUILDER7}
  {$ELSE}
    {$DEFINE DELPHI7}
  {$ENDIF}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}

//Delphi 8
{$IFDEF VER160}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL80}
  {$DEFINE DELPHI8}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}

//Delphi 9
{$IFDEF VER170}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL9ORABOVE}
  {$DEFINE VCL90}
  {$DEFINE DELPHI9}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}

//Delphi 10
{$IFDEF VER180}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL9ORABOVE}
  {$DEFINE VCL10ORABOVE}
  {$DEFINE VCL10}
  {$DEFINE DELPHI10}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}

//Delphi 11
{$IFDEF VER180}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL9ORABOVE}
  {$DEFINE VCL10ORABOVE}
  {$DEFINE VCL11ORABOVE}
  {$DEFINE VCL11}
  {$DEFINE DELPHI11}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}

//Delphi 12    Delphi 
{$IFDEF VER200}
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL9ORABOVE}
  {$DEFINE VCL10ORABOVE}
  {$DEFINE VCL11ORABOVE}
  {$DEFINE VCL12ORABOVE}
  {$DEFINE VCL12}
  {$DEFINE DELPHI12}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}

{$IFDEF VER210} //Delphi 2010
  {$DEFINE VCL4ORABOVE}
  {$DEFINE VCL5ORABOVE}
  {$DEFINE VCL6ORABOVE}
  {$DEFINE VCL7ORABOVE}
  {$DEFINE VCL8ORABOVE}
  {$DEFINE VCL9ORABOVE}
  {$DEFINE VCL10ORABOVE}
  {$DEFINE VCL11ORABOVE}
  {$DEFINE VCL12ORABOVE}
  {$DEFINE VCL13ORABOVE}
  {$DEFINE VCL13}
  {$DEFINE DELPHI13}
  {$DEFINE OPTIONALPARAMS}
  {$DEFINE SAMETEXT}
  {$DEFINE ALLOW_NAMED_THREADS}
{$ENDIF}

//Delphi.NET
// Covers D8+
{$IFDEF CIL}
  // Platform specific conditional. Used for platform specific code.
  {$DEFINE DOTNET}
{$ENDIF}

{ Switch that determines Debug mode or Release mode}
{.$DEFINE DEBUG}

{Switch determines Optimization On or Off}
{$DEFINE OPTIMIZATION}

{Switch determines whether to encrypt gtpdf32.dll}
{ON only when release buid is made}
{.$DEFINE COPYPROTECT}

{**************************************************}
{ Do not alter the code below }

{$IFDEF DEBUG}
  {Switch determines IOChecks On or Off}
  {.$DEFINE IOCHECK}

  {Switch determines RangeChecks On or Off}
  {.$DEFINE RANGECHECK}

  {Switch determines OverFolwCheks On or Off}
  {.$DEFINE OVERFLOW}

  {Switch determines Logging is enable or not}
  {.$DEFINE LOGERROR}

  {Switch determines application's debug info is set}
  {.$DEFINE DEBUGINFO}

  {Switch on warning messages}
  {.$DEFINE WARNING}

  {Switch to determine UnSafe code On or Off}
  {.$DEFINE UNSAFE}

  {$IFDEF OPTIMIZATION}
    {$UNDEF OPTIMIZATION}
  {$ENDIF}
{$ENDIF}


{$IFDEF UNSAFE}
  {$WARN UNSAFE_CODE ON}
  {$WARN UNSAFE_TYPE ON}
  {$WARN UNSAFE_CAST ON}
{$ENDIF}

{$IFDEF IOCHECK}
  {$I+}
{$ENDIF}

{$IFDEF RANGECHECK}
  {$R+}
{$ENDIF}

{$IFDEF OVERFLOW}
  {$Q+}
{$ENDIF}

{$IFDEF OPTIMIZATION}
  {$O+}
{$ENDIF}

{$IFDEF DEBUGINFO}
  {$D+}
{$ENDIF}

{$WARNINGS OFF}
{$HINTS OFF}

{$DEFINE FLATE}
{$DEFINE ASCII85}
  {$DEFINE ASCII85DECODE}
  {$DEFINE ASCII85ENCODE}
{$DEFINE ASCIIHEX}
{$DEFINE CCITT}
{$DEFINE CRYPT}
{$DEFINE DCT}

{**************************************************}
{Switch to determine registered or trial}

{$DEFINE gtRegistered}
{.$DEFINE DLLPROJECT}
