{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//Note: Gestalt routines are not available on iOS
{$IF NOT DECLARED(_PU)}
const
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
{$ENDIF}
function Gestalt; external CarbonCoreLib name _PU + 'Gestalt';
function ReplaceGestalt; external CarbonCoreLib name _PU + 'ReplaceGestalt';
function NewGestalt; external CarbonCoreLib name _PU + 'NewGestalt';
function NewGestaltValue; external CarbonCoreLib name _PU + 'NewGestaltValue';
function ReplaceGestaltValue; external CarbonCoreLib name _PU + 'ReplaceGestaltValue';
function SetGestaltValue; external CarbonCoreLib name _PU + 'SetGestaltValue';
function DeleteGestaltValue; external CarbonCoreLib name _PU + 'DeleteGestaltValue';
function NewSelectorFunctionUPP; external CarbonCoreLib name _PU + 'NewSelectorFunctionUPP';
procedure DisposeSelectorFunctionUPP; external CarbonCoreLib name _PU + 'DisposeSelectorFunctionUPP';
function InvokeSelectorFunctionUPP; external CarbonCoreLib name _PU + 'InvokeSelectorFunctionUPP';
