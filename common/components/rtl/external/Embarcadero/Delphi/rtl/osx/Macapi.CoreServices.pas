{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: CoreServices.h                         }
{          Copyright (c) Apple, Inc.                    }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Macapi.CoreServices;

{$WEAKPACKAGEUNIT}

interface

{$I OSTypes.inc}
{$I MacTypes.inc}
{$I TextCommon.inc}
{$I Files.inc}
{$I DispatchSemaphores.inc}
{$IFNDEF IOS}
{$I Multiprocessing.inc}
{$I DriverServices.inc}
{$I Gestalt.inc}
{$ENDIF !IOS}
{ $I OSServices.inc}
{ $I SFNetwork.inc}
{ $I LaunchServices.inc}
{ $I SearchKit.inc}
{ $I Metadata.inc}
{ $I DictionaryServices.inc}
{ $I AE.inc}

const
  CoreServicesLib = '/System/Library/Frameworks/CoreServices.framework/CoreServices';
  {$EXTERNALSYM CoreServicesLib}
  CarbonCoreLib = '/System/Library/Frameworks/CoreServices.framework/Frameworks/CarbonCore.framework/CarbonCore';
  {$EXTERNALSYM CarbonCoreLib}

implementation

{$IF NOT DECLARED(_PU)}
const
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
{$ENDIF}

{$I MacTypesImpl.inc}
{ $I TextCommonImpl.inc}
{$I FilesImpl.inc}
{$I DispatchSemaphoresImpl.inc}
{$IFNDEF IOS}
{$I MultiprocessingImpl.inc}
{$I DriverServicesImpl.inc}
{$I GestaltImpl.inc}
{$ENDIF !IOS}
{ $I OSServicesImpl.inc}
{ $I SFNetworkImpl.inc}
{ $I LaunchServicesImpl.inc}
{ $I SearchKitImpl.inc}
{ $I MetadataImpl.inc}
{ $I DictionaryServicesImpl.inc}
{ $I AEImpl.inc}

end.
