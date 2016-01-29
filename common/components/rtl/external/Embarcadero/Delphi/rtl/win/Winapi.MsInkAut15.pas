{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: MsInkAut15.h                           }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.MsInkAut15;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT ''}
{$HPPEMIT '#include "msinkaut15.h"'}
{$HPPEMIT ''}

interface

uses
  Winapi.Windows, Winapi.MsInkAut, Winapi.ActiveX;

const
  SID_IInkDivider = '{5DE00405-F9A4-4651-B0C5-C317DEFD58B9}';
  SID_IInkDivisionResult = '{2DBEC0A7-74C7-4B38-81EB-AA8EF0C24900}';
  SID_IInkDivisionUnit = '{85AEE342-48B0-4244-9DD5-1ED435410FAB}';
  SID_IInkDivisionUnits = '{1BB5DDC2-31CC-4135-AB82-2C66C9F00C41}';

  IID_IInkDivider: TGUID = (
    D1:$5DE00405; D2:$F9A4; D3:$4651; D4:($B0,$C5,$C3,$17,$DE,$FD,$58,$B9));
  {$EXTERNALSYM IID_IInkDivider}
  IID_IInkDivisionResult: TGUID = (
    D1:$2DBEC0A7; D2:$74C7; D3:$4B38; D4:($81,$EB,$AA,$8E,$F0,$C2,$49,$00));
  {$EXTERNALSYM IID_IInkDivisionResult}
  IID_IInkDivisionUnit: TGUID = (
    D1:$85AEE342; D2:$48B0; D3:$4244; D4:($9D,$D5,$1E,$D4,$35,$41,$0F,$AB));
  {$EXTERNALSYM IID_IInkDivisionUnit}
  IID_IInkDivisionUnits: TGUID = (
    D1:$1BB5DDC2; D2:$31CC; D3:$4135; D4:($AB,$82,$2C,$66,$C9,$F0,$0C,$41));
  {$EXTERNALSYM IID_IInkDivisionUnits}

  CLSID_InkDivider: TGUID = (
    D1:$8854F6A0; D2:$4683; D3:$4AE7; D4:($91,$91,$75,$2F,$E6,$46,$12,$C3));
  {$EXTERNALSYM CLSID_InkDivider}

const
  IDT_Segment   = 0;
  {$EXTERNALSYM IDT_Segment}
  IDT_Line      = 1;
  {$EXTERNALSYM IDT_Line}
  IDT_Paragraph = 2;
  {$EXTERNALSYM IDT_Paragraph}
  IDT_Drawing   = 3;
  {$EXTERNALSYM IDT_Drawing}

  DISPID_IInkDivider_Strokes           = 1;
  {$EXTERNALSYM DISPID_IInkDivider_Strokes}
  DISPID_IInkDivider_RecognizerContext = DISPID_IINKDIVIDER_STROKES + 1;
  {$EXTERNALSYM DISPID_IInkDivider_RecognizerContext}
  DISPID_IInkDivider_LineHeight        = DISPID_IINKDIVIDER_RECOGNIZERCONTEXT + 1;
  {$EXTERNALSYM DISPID_IInkDivider_LineHeight}
  DISPID_IInkDivider_Divide            = DISPID_IINKDIVIDER_LINEHEIGHT + 1;
  {$EXTERNALSYM DISPID_IInkDivider_Divide}

  DISPID_IInkDivisionResult_Strokes      = 1;
  {$EXTERNALSYM DISPID_IInkDivisionResult_Strokes}
  DISPID_IInkDivisionResult_ResultByType = DISPID_IINKDIVISIONRESULT_STROKES + 1;
  {$EXTERNALSYM DISPID_IInkDivisionResult_ResultByType}

  DISPID_IInkDivisionUnit_Strokes           = 1;
  {$EXTERNALSYM DISPID_IInkDivisionUnit_Strokes}
  DISPID_IInkDivisionUnit_DivisionType      = DISPID_IINKDIVISIONUNIT_STROKES + 1;
  {$EXTERNALSYM DISPID_IInkDivisionUnit_DivisionType}
  DISPID_IInkDivisionUnit_RecognizedString  = DISPID_IINKDIVISIONUNIT_DIVISIONTYPE + 1;
  {$EXTERNALSYM DISPID_IInkDivisionUnit_RecognizedString}
  DISPID_IInkDivisionUnit_RotationTransform = DISPID_IINKDIVISIONUNIT_RECOGNIZEDSTRING + 1;
  {$EXTERNALSYM DISPID_IInkDivisionUnit_RotationTransform}

  DISPID_IInkDivisionUnits_NewEnum = DISPID_NEWENUM;
  {$EXTERNALSYM DISPID_IInkDivisionUnits_NewEnum}
  DISPID_IInkDivisionUnits_Item    = DISPID_VALUE;
  {$EXTERNALSYM DISPID_IInkDivisionUnits_Item}
  DISPID_IInkDivisionUnits_Count   = 1;
  {$EXTERNALSYM DISPID_IInkDivisionUnits_Count}

{ Forward Declarations }

type
  IInkDivider = interface;
  IInkDivisionResult = interface;
  IInkDivisionUnit = interface;
  IInkDivisionUnits = interface;

  InkDivisionType = type Integer;
  {$EXTERNALSYM InkDivisionType}

  DISPID_InkDivider = type Integer;
  {$EXTERNALSYM DISPID_InkDivider}

  DISPID_InkDivisionResult = type Integer;
  {$EXTERNALSYM DISPID_InkDivisionResult}

  DISPID_InkDivisionUnit = type Integer;
  {$EXTERNALSYM DISPID_InkDivisionUnit}

  DISPID_InkDivisionUnits = type Integer;
  {$EXTERNALSYM DISPID_InkDivisionUnits}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IInkDivider);'}
  IInkDivider = interface(IDispatch)
    [SID_IInkDivider]
    function get_Strokes(var Strokes: IInkStrokes): HRESULT; stdcall;
    function putref_Strokes(Strokes: IInkStrokes): HRESULT; stdcall;
    function get_RecognizerContext(var RecognizerContext: IInkRecognizerContext): HRESULT; stdcall;
    function putref_RecognizerContext(RecognizerContext: IInkRecognizerContext): HRESULT; stdcall;
    function get_LineHeight(var LineHeight: Integer): HRESULT; stdcall;
    function put_LineHeight(LineHeight: Integer): HRESULT; stdcall;
    function Divide(var InkDivisionResult: IInkDivisionResult): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IInkDivider}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IInkDivisionResult);'}
  IInkDivisionResult = interface(IDispatch)
    [SID_IInkDivisionResult]
    function get_Strokes(var Strokes: IInkStrokes): HRESULT; stdcall;
    function ResultByType(divisionType: InkDivisionType;
      var InkDivisionUnits: IInkDivisionUnits): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IInkDivisionResult}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IInkDivisionUnit);'}
  IInkDivisionUnit = interface(IDispatch)
    [SID_IInkDivisionUnit]
    function get_Strokes(var Strokes: IInkStrokes): HRESULT; stdcall;
    function get_DivisionType(var divisionType: InkDivisionType): HRESULT; stdcall;
    function get_RecognizedString(var RecoString: WideString): HRESULT; stdcall;
    function get_RotationTransform(var RotationTransform: IInkTransform): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IInkDivisionUnit}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IInkDivisionUnits);'}
  IInkDivisionUnits = interface(IDispatch)
    [SID_IInkDivisionUnits]
    function get_Count(var Count: Integer): HRESULT; stdcall;
    function get__NewEnum(var _NewEnum: IUnknown): HRESULT; stdcall;
    function Item(Index: Integer; var InkDivisionUnit: IInkDivisionUnit): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IInkDivisionUnits}


implementation

end.
