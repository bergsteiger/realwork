{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: lzexpand.h                             }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{       Win32 LZ compression Interface Unit             }
{*******************************************************}

unit Winapi.LZExpand;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT '#include <lzexpand.h>'}

interface

uses Winapi.Windows;

{ Error Return Codes }

const
  {$EXTERNALSYM LZERROR_BADINHANDLE}
  LZERROR_BADINHANDLE = -1;         { invalid input handle }
  {$EXTERNALSYM LZERROR_BADOUTHANDLE}
  LZERROR_BADOUTHANDLE = -2;        { invalid output handle }
  {$EXTERNALSYM LZERROR_READ}
  LZERROR_READ = -3;                { corrupt compressed file format }
  {$EXTERNALSYM LZERROR_WRITE}
  LZERROR_WRITE = -4;               { out of space for output file }
  {$EXTERNALSYM LZERROR_GLOBALLOC}
  LZERROR_GLOBALLOC = -5;           { insufficient memory for LZFile struct }
  {$EXTERNALSYM LZERROR_GLOBLOCK}
  LZERROR_GLOBLOCK = -6;            { bad global handle }
  {$EXTERNALSYM LZERROR_BADVALUE}
  LZERROR_BADVALUE = -7;            { input parameter out of acceptable range }
  {$EXTERNALSYM LZERROR_UNKNOWNALG}
  LZERROR_UNKNOWNALG = -8;          { compression algorithm not recognized }


{ Prototypes }

{$EXTERNALSYM LZCopy}
function LZCopy(Source, Dest: Integer): Longint; stdcall;
{$EXTERNALSYM LZInit}
function LZInit(Source: Integer): Integer; stdcall;
{$EXTERNALSYM GetExpandedName}
function GetExpandedName(Source, Buffer: LPWSTR): Integer; stdcall;
{$EXTERNALSYM GetExpandedNameA}
function GetExpandedNameA(Source, Buffer: LPSTR): Integer; stdcall;
{$EXTERNALSYM GetExpandedNameW}
function GetExpandedNameW(Source, Buffer: LPWSTR): Integer; stdcall;
{$EXTERNALSYM LZOpenFile}
function LZOpenFile(Filename: LPWSTR; var ReOpenBuff: TOFStruct; Style: Word): Integer; stdcall;
{$EXTERNALSYM LZOpenFileA}
function LZOpenFileA(Filename: LPSTR; var ReOpenBuff: TOFStruct; Style: Word): Integer; stdcall;
{$EXTERNALSYM LZOpenFileW}
function LZOpenFileW(Filename: LPWSTR; var ReOpenBuff: TOFStruct; Style: Word): Integer; stdcall;
{$EXTERNALSYM LZSeek}
function LZSeek(hFile: Integer; Offset: Longint; Origin: Integer): Longint; stdcall;
{$EXTERNALSYM LZRead}
function LZRead(hFile: Integer; Buffer: LPSTR; Count: Integer): Integer; stdcall;
{$EXTERNALSYM LZClose}
procedure LZClose(hFile: Integer); stdcall;


implementation

const
  lz32 = 'LZ32.DLL';

function GetExpandedName;    external lz32 name 'GetExpandedNameW';
function GetExpandedNameA;    external lz32 name 'GetExpandedNameA';
function GetExpandedNameW;    external lz32 name 'GetExpandedNameW';
procedure LZClose;              external lz32 name 'LZClose';
function LZCopy;                external lz32 name 'LZCopy';
function LZInit;                external lz32 name 'LZInit';
function LZOpenFile;         external lz32 name 'LZOpenFileW';
function LZOpenFileA;         external lz32 name 'LZOpenFileA';
function LZOpenFileW;         external lz32 name 'LZOpenFileW';
function LZRead;                external lz32 name 'LZRead';
function LZSeek;                external lz32 name 'LZSeek';

end.
