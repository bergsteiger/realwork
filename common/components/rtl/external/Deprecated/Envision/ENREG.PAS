{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnReg
|
| Description: Unit to register Envision graphic formats with the VCL.
|              The file Envision.Inc determines which formats are
|              registered. 
|
| History: Mar 08, 1999. Michel Brazeau, first version
|          Sep 13, 1999. Michel Brazeau, change the purpose of this file.
|                        It use to be for design time registration and to
|                        include all graphic units for TGraphic class
|                        registrations as defined in the Envision.Inc Now it
|                        only serves this second purpose, and design-time
|                        registration is located in file EnDesign.Pas
|
|---------------------------------------------------------------------------}
unit EnReg;

{$I Envision.Inc}

interface

{--------------------------------------------------------------------------}

implementation

uses
    { include all graphic file format units to register each
      graphic class with TPicture. See Envision.Inc }
    EnBmpGr,
    EnIcoGr,
    EnWmfGr,
    EnTifGr,
    EnPngGr,
    EnJpgGr,
    EnTgaGr,
    EnPcxGr,
    EnDcxGr;

end.

