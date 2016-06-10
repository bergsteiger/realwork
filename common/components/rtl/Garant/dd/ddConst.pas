unit ddConst;

{$I ddDefine.inc }

interface

{$IFNDEF Envision}
Uses
 evConst,
 l3Chars,
 imageenio;
{$ENDIF}

const
  alcuPrefix     = 'Auto Import #';
  StagesFileName = 'stage.dat';
  BridgeFileName = 'bridge.dat';

const
 ddCellWidthEpsilon = evFindCellDelta;
 ddDefMinimumPicWidth = 200;
 ddDefMinimumPicHeight = 200;

{$IFDEF Envision}
  pictNONE = 0;
  pictBMP  = 1;
  pictICO  = 2;
  pictWMF  = 3;
  pictTIFF = 4;
  pictPNG  = 5;
  pictJPG  = 6;
  pictTGA  = 7;
  pictPCX  = 8;
  pictGIF  = 9;
  PictExt : array[pictNONE..pictGIF] of String = (
    '', '.bmp', '.ico', '.wmf', '.tif', '.png', '.jpg', '.tga', '.pcx', '.gif');
{$ELSE}
  pictNONE = ioUnknown;
  pictTIFF = ioTIFF;
  pictGIF  = ioGIF;
  pictJPG  = ioJPEG;
  pictPCX  = ioPCX;
  pictBMP  = ioBMP;
  pictICO  = ioICO;
  pictCUR  = ioCUR;
  {$ifdef IEINCLUDEPNG}
  pictPNG  = ioPNG;
  {$endif}
  pictWMF  = ioWMF;
  pictEMF  = ioEMF;
  pictTGA  = ioTGA;
  pictPXM  = ioPXM;

  PictExt : array[pictNONE..pictPXM] of String = (
            '', '.tif', '.gif', '.jpg', '.pcx', '.bmp', '.ico', '.cur', '.png',
            '.wmf', '.emf', '.tga', '.pxm');
{$ENDIF}
const
  ddEpsilon = evEpsilon;
  
  cc_HexDigitalCharSet = cc_Digits + ['a'..'f'] + ['A'..'F'];
  cc_HexDigitalCharSetWithEnters = cc_HexDigitalCharSet + [cc_HardEnter, cc_SoftEnter];
  cc_RTFFinishLineChar = cc_CloseBrace;


implementation

end.
 