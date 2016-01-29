{
  $Project$
  $Workfile$
  $Revision: 1.2 $
  $DateUTC$
  $Id: IdRegisterCore.pas,v 1.2 2013/05/24 13:30:22 lulin Exp $

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log: IdRegisterCore.pas,v $
  Revision 1.2  2013/05/24 13:30:22  lulin
  - �������� ��������� XE4.

}
{
  Rev 1.1    2/8/2004 1:35:40 PM  JPMugaas
  IdSocks is now in DotNET.

  Rev 1.0    2/3/2004 12:28:06 PM  JPMugaas
  Kudzu wanted this renamed.

  Rev 1.27    2004.01.01 2:40:02 PM  czhower
  Removed test ifdef

  Rev 1.26    1/1/2004 3:32:30 PM  BGooijen
  Added icons for .Net

  Rev 1.25    2003.12.31 11:02:50 PM  czhower
  New components now registered for .net.

  Rev 1.24    2003.12.25 6:55:20 PM  czhower
  TCPServer

  Rev 1.23    11/22/2003 11:49:52 PM  BGooijen
  Icons for DotNet

  Rev 1.22    17/11/2003 16:00:22  ANeillans
  Fix Delphi compile errors.

  Rev 1.21    11/8/2003 8:09:24 PM  BGooijen
  fix, i mixed up some stuff

  Rev 1.20    11/8/2003 7:27:10 PM  BGooijen
  DotNet

  Rev 1.19    2003.10.19 1:35:32 PM  czhower
  Moved Borland define to .inc

  Rev 1.18    2003.10.18 11:32:42 PM  czhower
  Changed throttler to intercept

  Rev 1.17    2003.10.17 6:18:50 PM  czhower
  TIdInterceptSimLog

  Rev 1.16    2003.10.14 1:26:42 PM  czhower
  Uupdates + Intercept support

  Rev 1.15    9/21/2003 01:10:40 AM  JPMugaas
  Added IdThreadCOmponent to the registration in Core.

  Rev 1.14    2003.08.19 11:06:34 PM  czhower
  Fixed names of scheduler units.

  Rev 1.13    8/19/2003 01:25:08 AM  JPMugaas
  Unnecessary junk removed.

  Rev 1.12    8/15/2003 12:02:48 AM  JPMugaas
  Incremented version number.
  Moved some units to new IndySuperCore package in D7.
  Made sure package titles are uniform in the IDE and in the .RES files.

  Rev 1.11    7/24/2003 03:22:00 AM  JPMugaas
  Removed some old files.

  Rev 1.10    7/18/2003 4:33:12 PM  SPerry
  Added TIdCmdTCPClient

  Rev 1.7    4/17/2003 05:02:26 PM  JPMugaas

  Rev 1.6    4/11/2003 01:09:50 PM  JPMugaas

  Rev 1.5    3/25/2003 11:12:54 PM  BGooijen
  TIdChainEngineStack added.

  Rev 1.4    3/25/2003 05:02:00 PM  JPMugaas
  TCmdTCPServer added.

  Rev 1.3    3/22/2003 10:14:54 PM  BGooijen
  Added TIdServerIOHandlerChain to the palette

  Rev 1.2    3/22/2003 02:20:48 PM  JPMugaas
  Updated registration.

  Rev 1.1    1/17/2003 04:18:44 PM  JPMugaas
  Now compiles with new packages.

  Rev 1.0    11/13/2002 08:41:42 AM  JPMugaas
}

unit IdRegisterCore;

interface

uses
  Classes;

// Procedures

  procedure Register;

implementation

{$I IdCompilerDefines.inc}

uses
  {$IFDEF VCL_XE2_OR_ABOVE}
  VCL.Controls, // have to specify "VCL.Controls" to differentiate from "FMX.Controls"
  {$ENDIF}
  {$IFDEF FPC}
  LResources,
  {$ENDIF}
  {$IFNDEF DOTNET}
  IdIcmpClient,
  {$ENDIF}
  IdSocks,
  {$IFDEF HAS_TSelectionEditor}
    {$IFDEF FPC}
  PropEdits,
    {$ELSE}
  DesignIntf,
    {$ENDIF}
  {$ENDIF}

  IdDsnCoreResourceStrings,
  IdAntiFreeze,
  IdCmdTCPClient,
  IdCmdTCPServer,
  IdIOHandlerStream,
  IdInterceptSimLog,
  IdInterceptThrottler,
  IdIPMCastClient,
  IdIPMCastServer,
  IdLogDebug,
  IdLogEvent,
  IdLogFile,
  IdLogStream,
  IdSchedulerOfThread,
  IdSchedulerOfThreadDefault,
  IdSchedulerOfThreadPool,
  IdServerIOHandlerSocket,
  IdServerIOHandlerStack,
  IdSimpleServer,
  IdThreadComponent,
  IdUDPClient,
  IdUDPServer,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdIntercept,
  IdTCPServer,
  IdTCPClient
  {$IFDEF HAS_TSelectionEditor}
  ,IdCoreSelectionEditors
  {$ENDIF}
  ;

{$IFDEF DOTNET}
  {$R IconsDotNet\TIdAntiFreeze.bmp}
  {$R IconsDotNet\TIdCmdTCPClient.bmp}
  {$R IconsDotNet\TIdCmdTCPServer.bmp}
  {$R IconsDotNet\TIdConnectionIntercept.bmp}
  {$R IconsDotNet\TIdICMPClient.bmp}
  {$R IconsDotNet\TIdInterceptSimLog.bmp}
  {$R IconsDotNet\TIdInterceptThrottler.bmp}
  {$R IconsDotNet\TIdIOHandlerStack.bmp}
  {$R IconsDotNet\TIdIOHandlerStream.bmp}
  {$R IconsDotNet\TIdLogDebug.bmp}
  {$R IconsDotNet\TIdLogEvent.bmp}
  {$R IconsDotNet\TIdLogFile.bmp}
  {$R IconsDotNet\TIdLogStream.bmp}
  {$R IconsDotNet\TIdSchedulerOfThreadDefault.bmp}
  {$R IconsDotNet\TIdSchedulerOfThreadPool.bmp}
  {$R IconsDotNet\TIdServerIOHandlerStack.bmp}
  {$R IconsDotNet\TIdSimpleServer.bmp}
  {$R IconsDotNet\TIdTCPClient.bmp}
  {$R IconsDotNet\TIdTCPServer.bmp}
  {$R IconsDotNet\TIdThreadComponent.bmp}
  {$R IconsDotNet\TIdUDPClient.bmp}
  {$R IconsDotNet\TIdUDPServer.bmp}
  {$R IconsDotNet\TIdIPMCastClient.bmp}
  {$R IconsDotNet\TIdIPMCastServer.bmp}
  {$R IconsDotNet\TIdSocksInfo.bmp}
{$ELSE}
  {$IFNDEF FPC}
    {$IFDEF BORLAND}
      {$R IdCoreRegister.dcr}
    {$ELSE}
      {$R IdCoreRegisterCool.dcr}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

procedure Register;
begin
  {$IFNDEF FPC}
  RegisterComponents(RSRegIndyClients, [
   TIdTCPClient
   ,TIdUDPClient
   ,TIdCmdTCPClient
   ,TIdIPMCastClient
   {$IFNDEF DOTNET}
   ,TIdIcmpClient
   {$ENDIF}
  ]);
  RegisterComponents(RSRegIndyServers, [
   TIdUDPServer,
   TIdCmdTCPServer,
   TIdSimpleServer,
   TIdTCPServer,
   TIdIPMCastServer
  ]);
  RegisterComponents(RSRegIndyIOHandlers,[
   TIdIOHandlerStack
   ,TIdIOHandlerStream
   ,TIdServerIOHandlerStack
  ]);
  RegisterComponents(RSRegIndyIntercepts, [
   TIdConnectionIntercept
   ,TIdInterceptSimLog
   ,TIdInterceptThrottler
   ,TIdLogDebug
   ,TIdLogEvent
   ,TIdLogFile
   ,TIdLogStream
  ]);

  {$IFDEF VCL_XE2_OR_ABOVE}
  // RLebeau 8/1/2011 - FireMonkey has problems resolving references to
  // TIdAntiFreeze correctly because it is implemented in a design-time
  // package and not a run-time package.  Until we can fix that properly,
  // we'll group TIdAntiFreeze with TControl so the IDE can filter out
  // TIdAntiFreeze from appearing at design-time in FireMoney projects.
  // Users will have to instantiate TIdAntiFreeze in code. This does not
  // affect VCL projects.
  GroupDescendentsWith(TIdAntiFreeze, TControl);
  {$ENDIF}

  RegisterComponents(RSRegIndyMisc, [
   TIdSocksInfo,
   TIdAntiFreeze,
   TIdSchedulerOfThreadDefault,
   TIdSchedulerOfThreadPool,
   TIdThreadComponent
  ]);
  {$ELSE}
  //This is a tempoary workaround for components not fitting on the palette
  //in Lazarus.  Unlike Delphi, Lazarus still does not have the ability to
  //scroll through a palette page.
  RegisterComponents(RSRegIndyClients+CoreSuffix, [
   TIdTCPClient
   ,TIdUDPClient
   ,TIdCmdTCPClient
   ,TIdIPMCastClient
   {$IFNDEF DOTNET}
   ,TIdIcmpClient
   {$ENDIF}
  ]);
  RegisterComponents(RSRegIndyServers+CoreSuffix, [
   TIdUDPServer,
   TIdCmdTCPServer,
   TIdSimpleServer,
   TIdTCPServer,
   TIdIPMCastServer
  ]);
  RegisterComponents(RSRegIndyIOHandlers+CoreSuffix,[
   TIdIOHandlerStack
   ,TIdIOHandlerStream
   ,TIdServerIOHandlerStack
  ]);
  RegisterComponents(RSRegIndyIntercepts+CoreSuffix, [
   TIdConnectionIntercept
   ,TIdInterceptSimLog
   ,TIdInterceptThrottler
   ,TIdLogDebug
   ,TIdLogEvent
   ,TIdLogFile
   ,TIdLogStream
  ]);
  RegisterComponents(RSRegIndyMisc+CoreSuffix, [
   TIdSocksInfo,
   TIdAntiFreeze,
   TIdSchedulerOfThreadDefault,
   TIdSchedulerOfThreadPool,
   TIdThreadComponent
  ]);
  {$ENDIF}
  {$IFDEF HAS_TSelectionEditor}
  RegisterSelectionEditor(TIdTCPServer, TIdContextSelectionEditor);
  RegisterSelectionEditor(TIdCmdTCPClient, TIdContextSelectionEditor);
  RegisterSelectionEditor(TIdUDPServer, TIdSocketHandleSelectionEditor);
  {$ENDIF}
end;

{$IFDEF FPC}
initialization
{$i IdRegisterCore.lrs}
{$ENDIF}
end.
