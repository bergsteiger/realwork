{******************************************************************************}
{                                                                              }
{  Gnostice PDFtoolkit                                                         }
{                                                                              }
{  Copyright © 2002-2004 Gnostice Information Technologies Private Limited     }
{  http://www.gnostice.com                                                     }
{                                                                              }
{******************************************************************************}

{---- ZLib Compression Support ------------------------------------------------}
{     Remove dot(.) below to use the ZLib compression library and enable       }
{     text compression. The ZLib compression library does not install          }
{     automatically with Delphi/C++Builder. It has to be manually installed.   }
{     The library ships on the Delphi CD from version 5 onwards and you should }
{     find it under \Info\Extras\Zlib.                                         }
{     If the library is not present on your CD you could download one of       }
{     several available from http://www.torry.net                              }
{     Make sure you have installed the units before enabling the option.       }

{$DEFINE ZLib}

{------------------------------------------------------------------------------}


{---- GIF Support -------------------------------------------------------------}
{     Remove ONE of the dots(.) below to get built-in support for GIF images.  }
{     Make sure you have the appropriate units installed first.                }

{---- GIF using RxGIF unit (http://www.rxlib.com)}
{.$DEFINE GIFByRx}

{---- GIF using Anders Melander's GIF unit (http://www.melander.dk)}
{.$DEFINE GIFByAM}

{------------------------------------------------------------------------------}


{---- Report E-Mailing Support ------------------------------------------------}
{     Remove ONE of the dots(.) below to get built-in support for              }
{     FastNet or Indy Components.                                              }
{     Make sure you have the appropriate Components installed first            }

{---- E-Mail using FastNet units}
{.$DEFINE EMailWithFastNet}

{---- E-Mail using Indy units}
{.$DEFINE EMailWithIndy}


// switch that determines whether web application services are enabled or not
{.$DEFINE WebAppServices}

{------------------------------------------------------------------------------}


{---- Indy Version ------------------------------------------------------------}
{     Remove dot(.) before $DEFINE below to configure QRExport to              }
{     support Indy versions above 9.00. By Default QuickReport Export          }
{     is configured to work with Indy Version below 9.00.                      }


{.$DEFINE Indy900Up}

{    Switch that determines Indy 10 enabled or not }
{.$DEFINE Indy1000Up}

{------------------------------------------------------------------------------}


{---- Nothing to change below -------------------------------------------------}

{$IFDEF EMailWithFastNet}
  {$DEFINE EMailSupport}
  {$UNDEF Indy900Up}
  {$UNDEF Indy1000Up}
{$ENDIF}
{$IFDEF EMailWithIndy}
  {$DEFINE EMailSupport}
{$ENDIF}
{$IFDEF EMailWithIndy}
  {$UNDEF EMailWithFastNet}
{$ENDIF}
{$IFDEF EMailWithIndy}
  {$IFDEF Indy900Up}
     {$UNDEF Indy1000Up}
  {$ENDIF}
{$ENDIF}

{$IFDEF GIFByRx}
  {$DEFINE GIFSupport}
{$ENDIF}
{$IFDEF GIFByAM}
  {$DEFINE GIFSupport}
{$ENDIF}

{------------------------------------------------------------------------------}
