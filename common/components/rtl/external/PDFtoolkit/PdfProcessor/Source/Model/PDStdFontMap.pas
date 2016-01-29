unit PDStdFontMap;

interface

type

  TgtStdFontMapEntry = record
    AlternateName: AnsiString;
    ProperName: AnsiString;
  end;

const
  StdFontCount = 49;

  TgtStdFontMapTable: array[0..StdFontCount - 1] of TgtStdFontMapEntry =
  (
    (AlternateName: 'Arial'; ProperName: 'Helvetica'),
    (AlternateName: 'Arial,Bold'; ProperName: 'Helvetica-Bold'),
    (AlternateName: 'Arial,BoldItalic'; ProperName: 'Helvetica-BoldOblique'),
    (AlternateName: 'Arial,Italic'; ProperName: 'Helvetica-Oblique'),
    (AlternateName: 'Arial-Bold'; ProperName: 'Helvetica-Bold'),
    (AlternateName: 'Arial-BoldItalic'; ProperName: 'Helvetica-BoldOblique'),
    (AlternateName: 'Arial-BoldItalicMT'; ProperName: 'Helvetica-BoldOblique'),
    (AlternateName: 'Arial-BoldMT'; ProperName: 'Helvetica-Bold'),
    (AlternateName: 'Arial-Italic'; ProperName: 'Helvetica-Oblique'),
    (AlternateName: 'Arial-ItalicMT'; ProperName: 'Helvetica-Oblique'),
    (AlternateName: 'Helvetica-Compressed'; ProperName: 'Helvetica'),
    (AlternateName: 'ArialMT'; ProperName: 'Helvetica'),
//    (AlternateName: 'Courier,Bold'; ProperName: 'Courier-Bold'),
//    (AlternateName: 'Courier,BoldItalic'; ProperName: 'Courier-BoldOblique'),
//    (AlternateName: 'Courier,Italic'; ProperName: 'Courier-Oblique'),
    (AlternateName: 'CourierNew'; ProperName: 'Courier'),
    (AlternateName: 'CourierNew,Bold'; ProperName: 'Courier-Bold'),
    (AlternateName: 'CourierNew,BoldItalic'; ProperName: 'Courier-BoldOblique'),
    (AlternateName: 'CourierNew,Italic'; ProperName: 'Courier-Oblique'),
    (AlternateName: 'CourierNew-Bold'; ProperName: 'Courier-Bold'),
    (AlternateName: 'CourierNew-BoldItalic'; ProperName: 'Courier-BoldOblique'),
    (AlternateName: 'CourierNew-Italic'; ProperName: 'Courier-Oblique'),
    (AlternateName: 'CourierNewPS-BoldItalicMT'; ProperName: 'Courier-BoldOblique'),
    (AlternateName: 'CourierNewPS-BoldMT'; ProperName: 'Courier-Bold'),
    (AlternateName: 'CourierNewPS-ItalicMT'; ProperName: 'Courier-Oblique'),
    (AlternateName: 'CourierNewPSMT'; ProperName: 'Courier'),
    (AlternateName: 'Helvetica,Bold'; ProperName: 'Helvetica-Bold'),
    (AlternateName: 'Helvetica,BoldItalic'; ProperName: 'Helvetica-BoldOblique'),
    (AlternateName: 'Helvetica,Italic'; ProperName: 'Helvetica-Oblique'),
    (AlternateName: 'Helvetica-BoldItalic'; ProperName: 'Helvetica-BoldOblique'),
    (AlternateName: 'Helvetica-Italic'; ProperName: 'Helvetica-Oblique'),
    (AlternateName: 'Symbol,Bold'; ProperName: 'Symbol'),
    (AlternateName: 'Symbol,BoldItalic'; ProperName: 'Symbol'),
    (AlternateName: 'Symbol,Italic'; ProperName: 'Symbol'),
    (AlternateName: 'TimesNewRoman'; ProperName: 'Times-Roman'),
    (AlternateName: 'TimesNewRoman,Bold'; ProperName: 'Times-Bold'),
    (AlternateName: 'TimesNewRoman,BoldItalic'; ProperName: 'Times-BoldItalic'),
    (AlternateName: 'TimesNewRoman,Italic'; ProperName: 'Times-Italic'),
    (AlternateName: 'TimesNewRoman-Bold'; ProperName: 'Times-Bold'),
    (AlternateName: 'TimesNewRoman-BoldItalic'; ProperName: 'Times-BoldItalic'),
    (AlternateName: 'TimesNewRoman-Italic'; ProperName: 'Times-Italic'),
    (AlternateName: 'TimesNewRomanPS'; ProperName: 'Times-Roman'),
    (AlternateName: 'TimesNewRomanPS-Bold'; ProperName: 'Times-Bold'),
    (AlternateName: 'TimesNewRomanPS-BoldItalic'; ProperName: 'Times-BoldItalic'),
    (AlternateName: 'TimesNewRomanPS-BoldItalicMT'; ProperName: 'Times-BoldItalic'),
    (AlternateName: 'TimesNewRomanPS-BoldMT'; ProperName: 'Times-Bold'),
    (AlternateName: 'TimesNewRomanPS-Italic'; ProperName: 'Times-Italic'),
    (AlternateName: 'TimesNewRomanPS-ItalicMT'; ProperName: 'Times-Italic'),
    (AlternateName: 'TimesNewRomanPSMT'; ProperName: 'Times-Roman'),
    (AlternateName: 'TimesNewRomanPSMT,Bold'; ProperName: 'Times-Bold'),
    (AlternateName: 'TimesNewRomanPSMT,BoldItalic'; ProperName: 'Times-BoldItalic'),
    (AlternateName: 'TimesNewRomanPSMT,Italic'; ProperName: 'Times-Italic')
    );

implementation

end.
