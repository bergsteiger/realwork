{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: Envision.Inc
|
| Description: Include for to define global compilation constants
|
| History: Dec 03, 1998. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}

{$B-}  { Complete boolean evaluation off. DO NOT CHANGE }
{$H+}  { Long strings. DO NOT CHANGE }
{$X+}  { Extended syntax. DO NOT CHANGE }

{$ifdef __EnvisionDebug}
    {$R+,Q+,O-,I+}
{$else}
    {$R-,Q-,O+,I-}
{$endif}

{$ifdef Ver90}
    {$define __Delphi2}
    {$define __Delphi2AndAbove}
{$endif}

{$ifdef Ver100}
    {$define __Delphi3}
    {$define __Delphi2AndAbove}
    {$define __Delphi3AndAbove}
{$endif}

{$ifdef Ver120}
    {$define __Delphi4}
    {$define __Delphi2AndAbove}
    {$define __Delphi3AndAbove}
    {$define __Delphi4AndAbove}
{$endif}

{$ifdef Ver130}
    {$define __Delphi5}
    {$define __Delphi2AndAbove}
    {$define __Delphi3AndAbove}
    {$define __Delphi4AndAbove}
    {$define __Delphi5AndAbove}
{$endif}

{$ifdef Ver93}
    {$define __CBuilder1}
    {$define __CBuilder1AndAbove}
{$endif}

{$ifdef Ver110}
    {$define __CBuilder3}
    {$define __CBuilder1AndAbove}
    {$define __CBuilder3AndAbove}
{$endif}

{$ifdef Ver125}
    {$define __CBuilder4}
    {$define __CBuilder1AndAbove}
    {$define __CBuilder3AndAbove}
    {$define __CBuilder4AndAbove}
{$endif}

{ conditional constants to register graphic file formats with
  TPicture. To disable, put a period (.) before the dollar ($)
  If a format is not defined, TPicture.LoadFromFile will not
  recognize the file extension. 
}


{ MB May 1, 1999. Do not replace TBitmap, TIcon, and TMetafile by default,
  as this interferes with at design time with forms containing these
  graphics.

  MB Sep 26, 1999. The VCL classes are no longer unregistered, so it is safe
  to have both VCL and Envision classes registered; for example both TBitmap
  and TBitmapGraphic may be registered, and a form may contain both types
  of graphics at design-time.

  Note that the TImageList component does not integrate with graphic classes
  other than TBitmap and TIcon. 
}
{.$define __RegisterEnvisionBmp}
{.$define __RegisterEnvisionIco}
{.$define __RegisterEnvisionWmf}

{$define __RegisterEnvisionTif}
{$define __RegisterEnvisionPng}
{$define __RegisterEnvisionJpg}
{$define __RegisterEnvisionTga}
{$define __RegisterEnvisionPcx}
{$define __RegisterEnvisionDcx}

