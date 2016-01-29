unit PDEncoding;

interface

type
  TgtEncodingArray = array[0..255] of AnsiString;
  TgtEncodingType = (etMac, etMacExpert, etWinAnsi, etStandard, etExpert,
    etSymbol, etZapfDingbats);

const
  EMPTY = '';

  MacRomanEncoding: TgtEncodingArray =
  (
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    'space', 'exclam', 'quotedbl', 'numbersign',
    'dollar', 'percent', 'ampersand', 'quotesingle',
    'parenleft', 'parenright', 'asterisk', 'plus',
    'comma', 'hyphen', 'period', 'slash',
    'zero', 'one', 'two', 'three',
    'four', 'five', 'six', 'seven',
    'eight', 'nine', 'colon', 'semicolon',
    'less', 'equal', 'greater', 'question',
    'at', 'A', 'B', 'C',
    'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K',
    'L', 'M', 'N', 'O',
    'P', 'Q', 'R', 'S',
    'T', 'U', 'V', 'W',
    'X', 'Y', 'Z', 'bracketleft',
    'backslash', 'bracketright', 'asciicircum', 'underscore',
    'grave', 'a', 'b', 'c',
    'd', 'e', 'f', 'g',
    'h', 'i', 'j', 'k',
    'l', 'm', 'n', 'o',
    'p', 'q', 'r', 's',
    't', 'u', 'v', 'w',
    'x', 'y', 'z', 'braceleft',
    'bar', 'braceright', 'asciitilde', 'UL',
    'Adieresis', 'Aring', 'Ccedilla', 'Eacute',
    'Ntilde', 'Odieresis', 'Udieresis', 'aacute',
    'agrave', 'acircumflex', 'adieresis', 'atilde',
    'aring', 'ccedilla', 'eacute', 'egrave',
    'ecircumflex', 'edieresis', 'iacute', 'igrave',
    'icircumflex', 'idieresis', 'ntilde', 'oacute',
    'ograve', 'ocircumflex', 'odieresis', 'otilde',
    'uacute', 'ugrave', 'ucircumflex', 'udieresis',
    'dagger', 'degree', 'cent', 'sterling',
    'section', 'bullet', 'paragraph', 'germandbls',
    'registered', 'copyright', 'trademark', 'acute',
    'dieresis', 'notequal', 'AE', 'Oslash',
    'infinity', 'plusminus', 'lessequal', 'greaterequal',
    'yen', 'mu', 'partialdiff', 'summation',
    'product', 'pi', 'integral', 'ordfeminine',
    'ordmasculine', 'Omega', 'ae', 'oslash',
    'questiondown', 'exclamdown', 'logicalnot', 'radical',
    'florin', 'approxequal', 'Delta', 'guillemotleft',
    'guillemotright', 'ellipsis', 'space', 'Agrave',
    'Atilde', 'Otilde', 'OE', 'oe',
    'endash', 'emdash', 'quotedblleft', 'quotedblright',
    'quoteleft', 'quoteright', 'divide', 'lozenge',
    'ydieresis', 'Ydieresis', 'fraction', 'currency',
    'guilsinglleft', 'guilsinglright', 'fi', 'fl',
    'daggerdbl', 'periodcentered', 'quotesinglbase', 'quotedblbase',
    'perthousand', 'Acircumflex', 'Ecircumflex', 'Aacute',
    'Edieresis', 'Egrave', 'Iacute', 'Icircumflex',
    'Idieresis', 'Igrave', 'Oacute', 'Ocircumflex',
    'apple', 'Ograve', 'Uacute', 'Ucircumflex',
    'Ugrave', 'dotlessi', 'circumflex', 'tilde',
    'macron', 'breve', 'dotaccent', 'ring',
    'cedilla', 'hungarumlaut', 'ogonek', 'caro'
    );

  MacExpertEncoding: TgtEncodingArray =
  (
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    'space', 'exclamsmall', 'Hungarumlautsmall', 'centoldstyle',
    'dollaroldstyle', 'dollarsuperior', 'ampersandsmall', 'Acutesmall',
    'parenleftsuperior', 'parenrightsuperior', 'twodotenleader', 'onedotenleader',
    'comma', 'hyphen', 'period', 'fraction',
    'zerooldstyle', 'oneoldstyle', 'twooldstyle', 'threeoldstyle',
    'fouroldstyle', 'fiveoldstyle', 'sixoldstyle', 'sevenoldstyle',
    'eightoldstyle', 'nineoldstyle', 'colon', 'semicolon',
    EMPTY, 'threequartersemdash', EMPTY, 'questionsmall',
    EMPTY, EMPTY, EMPTY, EMPTY,
    'Ethsmall', EMPTY, EMPTY, 'onequarter',
    'onehalf', 'threequarters', 'oneeighth', 'threeeighths',
    'fiveeighths', 'seveneighths', 'onethird', 'twothirds',
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, 'ff', 'fi',
    'fl', 'ffi', 'ffl', 'parenleftinferior',
    EMPTY, 'parenrightinferior', 'Circumflexsmall', 'hypheninferior',
    'Gravesmall', 'Asmall', 'Bsmall', 'Csmall',
    'Dsmall', 'Esmall', 'Fsmall', 'Gsmall',
    'Hsmall', 'Ismall', 'Jsmall', 'Ksmall',
    'Lsmall', 'Msmall', 'Nsmall', 'Osmall',
    'Psmall', 'Qsmall', 'Rsmall', 'Ssmall',
    'Tsmall', 'Usmall', 'Vsmall', 'Wsmall',
    'Xsmall', 'Ysmall', 'Zsmall', 'colonmonetary',
    'onefitted', 'rupiah', 'Tildesmall', EMPTY,
    EMPTY, 'asuperior', 'centsuperior', EMPTY,
    EMPTY, EMPTY, EMPTY, 'Aacutesmall',
    'Agravesmall', 'Acircumflexsmall', 'Adieresissmall', 'Atildesmall',
    'Aringsmall', 'Ccedillasmall', 'Eacutesmall', 'Egravesmall',
    'Ecircumflexsmall', 'Edieresissmall', 'Iacutesmall', 'Igravesmall',
    'Icircumflexsmall', 'Idieresissmall', 'Ntildesmall', 'Oacutesmall',
    'Ogravesmall', 'Ocircumflexsmall', 'Odieresissmall', 'Otildesmall',
    'Uacutesmall', 'Ugravesmall', 'Ucircumflexsmall', 'Udieresissmall',
    EMPTY, 'eightsuperior', 'fourinferior', 'threeinferior',
    'sixinferior', 'eightinferior', 'seveninferior', 'Scaronsmall',
    EMPTY, 'centinferior', 'twoinferior', EMPTY,
    'Dieresissmall', EMPTY, 'Caronsmall', 'osuperior',
    'fiveinferior', EMPTY, 'commainferior', 'periodinferior',
    'Yacutesmall', EMPTY, 'dollarinferior', EMPTY,
    EMPTY, 'Thornsmall', EMPTY, 'nineinferior',
    'zeroinferior', 'Zcaronsmall', 'AEsmall', 'Oslashsmall',
    'questiondownsmall', 'oneinferior', 'Lslashsmall', EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, 'Cedillasmall', EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, 'OEsmall',
    'figuredash', 'hyphensuperior', EMPTY, EMPTY,
    EMPTY, EMPTY, 'exclamdownsmall', EMPTY,
    'Ydieresissmall', EMPTY, 'onesuperior', 'twosuperior',
    'threesuperior', 'foursuperior', 'fivesuperior', 'sixsuperior',
    'sevensuperior', 'ninesuperior', 'zerosuperior', EMPTY,
    'esuperior', 'rsuperior', 'tsuperior', EMPTY,
    EMPTY, 'isuperior', 'ssuperior', 'dsuperior',
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, 'lsuperior', 'Ogoneksmall', 'Brevesmall',
    'Macronsmall', 'bsuperior', 'nsuperior', 'msuperior',
    'commasuperior', 'periodsuperior', 'Dotaccentsmall', 'Ringsmall',
    EMPTY, EMPTY, EMPTY, EMPTY
    );

  WinAnsiEncoding: TgtEncodingArray =
  (
    EMPTY, EMPTY, EMPTY, EMPTY,                                //  1
    EMPTY, EMPTY, EMPTY, EMPTY,                                //  2
    EMPTY, EMPTY, EMPTY, EMPTY,                                //  3
    EMPTY, EMPTY, EMPTY, EMPTY,                                //  4
    EMPTY, EMPTY, EMPTY, EMPTY,                                //  5
    EMPTY, EMPTY, EMPTY, EMPTY,                                //  6
    EMPTY, EMPTY, EMPTY, EMPTY,                                //  7
    EMPTY, EMPTY, EMPTY, EMPTY,                                //  8
    'space', 'exclam', 'quotedbl', 'numbersign',               //  9
    'dollar', 'percent', 'ampersand', 'quotesingle',           // 10
    'parenleft', 'parenright', 'asterisk', 'plus',             // 11
    'comma', 'hyphen', 'period', 'slash',                      // 12
    'zero', 'one', 'two', 'three',                             // 13
    'four', 'five', 'six', 'seven',                            // 14
    'eight', 'nine', 'colon', 'semicolon',                     // 15
    'less', 'equal', 'greater', 'question',                    // 16
    'at', 'A', 'B', 'C',                                       // 17
    'D', 'E', 'F', 'G',                                        // 18
    'H', 'I', 'J', 'K',                                        // 19
    'L', 'M', 'N', 'O',                                        // 20
    'P', 'Q', 'R', 'S',                                        // 21
    'T', 'U', 'V', 'W',                                        // 22
    'X', 'Y', 'Z', 'bracketleft',                              // 23
    'backslash', 'bracketright', 'asciicircum', 'underscore',  // 24
    'grave', 'a', 'b', 'c',                                    // 25
    'd', 'e', 'f', 'g',                                        // 26
    'h', 'i', 'j', 'k',                                        // 27
    'l', 'm', 'n', 'o',                                        // 28
    'p', 'q', 'r', 's',                                        // 29
    't', 'u', 'v', 'w',                                        // 30
    'x', 'y', 'z', 'braceleft',                                // 31
    'bar', 'braceright', 'asciitilde', 'bullet',               // 32
    'Euro', 'bullet', 'quotesinglbase', 'florin',              // 33
    'quotedblbase', 'ellipsis', 'dagger', 'daggerdbl',         // 34
    'circumflex', 'perthousand', 'Scaron', 'guilsinglleft',    // 35
    'OE', 'bullet', 'Zcaron', 'bullet',                        // 36
    'bullet', 'quoteleft', 'quoteright', 'quotedblleft',       // 37
    'quotedblright', 'bullet', 'endash', 'emdash',             // 38
    'tilde', 'trademark', 'scaron', 'guilsinglright',          // 39
    'oe', 'bullet', 'zcaron', 'Ydieresis',                     // 40
    'space', 'exclamdown', 'cent', 'sterling',                 // 41
    'currency', 'yen', 'brokenbar', 'section',                 // 42
    'dieresis', 'copyright', 'ordfeminine', 'guillemotleft',   // 43
    'logicalnot', 'hyphen', 'registered', 'macron',            // 44
    'degree', 'plusminus', 'twosuperior', 'threesuperior',     // 45
    'acute', 'mu', 'paragraph', 'periodcentered',              // 46
    'cedilla', 'onesuperior', 'ordmasculine', 'guillemotright',// 47
    'onequarter', 'onehalf', 'threequarters', 'questiondown',  // 48
    'Agrave', 'Aacute', 'Acircumflex', 'Atilde',               // 49
    'Adieresis', 'Aring', 'AE', 'Ccedilla',                    // 50
    'Egrave', 'Eacute', 'Ecircumflex', 'Edieresis',            // 51
    'Igrave', 'Iacute', 'Icircumflex', 'Idieresis',            // 52
    'Eth', 'Ntilde', 'Ograve', 'Oacute',                       // 53
    'Ocircumflex', 'Otilde', 'Odieresis', 'multiply',          // 54
    'Oslash', 'Ugrave', 'Uacute', 'Ucircumflex',               // 55
    'Udieresis', 'Yacute', 'Thorn', 'germandbls',              // 56
    'agrave', 'aacute', 'acircumflex', 'atilde',               // 57
    'adieresis', 'aring', 'ae', 'ccedilla',                    // 58
    'egrave', 'eacute', 'ecircumflex', 'edieresis',            // 59
    'igrave', 'iacute', 'icircumflex', 'idieresis',            // 60
    'eth', 'ntilde', 'ograve', 'oacute',                       // 61
    'ocircumflex', 'otilde', 'odieresis', 'divide',            // 62
    'oslash', 'ugrave', 'uacute', 'ucircumflex',               // 63
    'udieresis', 'yacute', 'thorn', 'ydieresis'                // 64
    );

  StandardEncoding: TgtEncodingArray =
  (
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    'space', 'exclam', 'quotedbl', 'numbersign',
    'dollar', 'percent', 'ampersand', 'quoteright',
    'parenleft', 'parenright', 'asterisk', 'plus',
    'comma', 'hyphen', 'period', 'slash',
    'zero', 'one', 'two', 'three',
    'four', 'five', 'six', 'seven',
    'eight', 'nine', 'colon', 'semicolon',
    'less', 'equal', 'greater', 'question',
    'at', 'A', 'B', 'C',
    'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K',
    'L', 'M', 'N', 'O',
    'P', 'Q', 'R', 'S',
    'T', 'U', 'V', 'W',
    'X', 'Y', 'Z', 'bracketleft',
    'backslash', 'bracketright', 'asciicircum', 'underscore',
    'quoteleft', 'a', 'b', 'c',
    'd', 'e', 'f', 'g',
    'h', 'i', 'j', 'k',
    'l', 'm', 'n', 'o',
    'p', 'q', 'r', 's',
    't', 'u', 'v', 'w',
    'x', 'y', 'z', 'braceleft',
    'bar', 'braceright', 'asciitilde', EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, 'exclamdown', 'cent', 'sterling',
    'fraction', 'yen', 'florin', 'section',
    'currency', 'quotesingle', 'quotedblleft', 'guillemotleft',
    'guilsinglleft', 'guilsinglright', 'fi', 'fl',
    EMPTY, 'endash', 'dagger', 'daggerdbl',
    'periodcentered', EMPTY, 'paragraph', 'bullet',
    'quotesinglbase', 'quotedblbase', 'quotedblright', 'guillemotright',
    'ellipsis', 'perthousand', EMPTY, 'questiondown',
    EMPTY, 'grave', 'acute', 'circumflex',
    'tilde', 'macron', 'breve', 'dotaccent',
    'dieresis', EMPTY, 'ring', 'cedilla',
    EMPTY, 'hungarumlaut', 'ogonek', 'caron',
    'emdash', EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, 'AE', EMPTY, 'ordfeminine',
    EMPTY, EMPTY, EMPTY, EMPTY,
    'Lslash', 'Oslash', 'OE', 'ordmasculine',
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, 'ae', EMPTY, EMPTY,
    EMPTY, 'dotlessi', EMPTY, EMPTY,
    'lslash', 'oslash', 'oe', 'germandbls',
    EMPTY, EMPTY, EMPTY, EMPTY
    );


  ExpertEncoding: TgtEncodingArray =
  (
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    'space', 'exclamsmall', 'Hungarumlautsmall', EMPTY,
    'dollaroldstyle', 'dollarsuperior', 'ampersandsmall', 'Acutesmall',
    'parenleftsuperior', 'parenrightsuperior', 'twodotenleader', 'onedotenleader',
    'comma', 'hyphen', 'period', 'fraction',
    'zerooldstyle', 'oneoldstyle', 'twooldstyle', 'threeoldstyle',
    'fouroldstyle', 'fiveoldstyle', 'sixoldstyle', 'sevenoldstyle',
    'eightoldstyle', 'nineoldstyle', 'colon', 'semicolon',
    'commasuperior', 'threequartersemdash', 'periodsuperior', 'questionsmall',
    EMPTY, 'asuperior', 'bsuperior', 'centsuperior',
    'dsuperior', 'esuperior', EMPTY, EMPTY,
    EMPTY, 'isuperior', EMPTY, EMPTY,
    'lsuperior', 'msuperior', 'nsuperior', 'osuperior',
    EMPTY, EMPTY, 'rsuperior', 'ssuperior',
    'tsuperior', EMPTY, 'ff', 'fi',
    'fl', 'ffi', 'ffl', 'parenleftinferior',
    EMPTY, 'parenrightinferior', 'Circumflexsmall', 'hyphensuperior',
    'Gravesmall', 'Asmall', 'Bsmall', 'Csmall',
    'Dsmall', 'Esmall', 'Fsmall', 'Gsmall',
    'Hsmall', 'Ismall', 'Jsmall', 'Ksmall',
    'Lsmall', 'Msmall', 'Nsmall', 'Osmall',
    'Psmall', 'Qsmall', 'Rsmall', 'Ssmall',
    'Tsmall', 'Usmall', 'Vsmall', 'Wsmall',
    'Xsmall', 'Ysmall', 'Zsmall', 'colonmonetary',
    'onefitted', 'rupiah', 'Tildesmall', EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, 'exclamdownsmall', 'centoldstyle', 'Lslashsmall',
    EMPTY, EMPTY, 'Scaronsmall', 'Zcaronsmall',
    'Dieresissmall', 'Brevesmall', 'Caronsmall', EMPTY,
    'Dotaccentsmall', EMPTY, EMPTY, 'Macronsmall',
    EMPTY, EMPTY, 'figuredash', 'hypheninferior',
    EMPTY, EMPTY, 'Ogoneksmall', 'Ringsmall',
    'Cedillasmall', EMPTY, EMPTY, EMPTY,
    'onequarter', 'onehalf', 'threequarters', 'questiondownsmall',
    'oneeighth', 'threeeighths', 'fiveeighths', 'seveneighths',
    'onethird', 'twothirds', EMPTY, EMPTY,
    'zerosuperior', 'onesuperior', 'twosuperior', 'threesuperior',
    'foursuperior', 'fivesuperior', 'sixsuperior', 'sevensuperior',
    'eightsuperior', 'ninesuperior', 'zeroinferior', 'oneinferior',
    'twoinferior', 'threeinferior', 'fourinferior', 'fiveinferior',
    'sixinferior', 'seveninferior', 'eightinferior', 'nineinferior',
    'centinferior', 'dollarinferior', 'periodinferior', 'commainferior',
    'Agravesmall', 'Aacutesmall', 'Acircumflexsmall', 'Atildesmall',
    'Adieresissmall', 'Aringsmall', 'AEsmall', 'Ccedillasmall',
    'Egravesmall', 'Eacutesmall', 'Ecircumflexsmall', 'Edieresissmall',
    'Igravesmall', 'Iacutesmall', 'Icircumflexsmall', 'Idieresissmall',
    'Ethsmall', 'Ntildesmall', 'Ogravesmall', 'Oacutesmall',
    'Ocircumflexsmall', 'Otildesmall', 'Odieresissmall', 'OEsmall',
    'Oslashsmall', 'Ugravesmall', 'Uacutesmall', 'Ucircumflexsmall',
    'Udieresissmall', 'Yacutesmall', 'Thornsmall', 'Ydieresissmall'
    );

  SymbolEncoding: TgtEncodingArray =
  (
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    'space', 'exclam', 'universal', 'numbersign',
    'existential', 'percent', 'ampersand', 'suchthat',
    'parenleft', 'parenright', 'asteriskmath', 'plus',
    'comma', 'minus', 'period', 'slash',
    'zero', 'one', 'two', 'three',
    'four', 'five', 'six', 'seven',
    'eight', 'nine', 'colon', 'semicolon',
    'less', 'equal', 'greater', 'question',
    'congruent', 'Alpha', 'Beta', 'Chi',
    'Delta', 'Epsilon', 'Phi', 'Gamma',
    'Eta', 'Iota', 'theta1', 'Kappa',
    'Lambda', 'Mu', 'Nu', 'Omicron',
    'Pi', 'Theta', 'Rho', 'Sigma',
    'Tau', 'Upsilon', 'sigma1', 'Omega',
    'Xi', 'Psi', 'Zeta', 'bracketleft',
    'therefore', 'bracketright', 'perpendicular', 'underscore',
    'radicalex', 'alpha', 'beta', 'chi',
    'delta', 'epsilon', 'phi', 'gamma',
    'eta', 'iota', 'phi1', 'kappa',
    'lambda', 'mu', 'nu', 'omicron',
    'pi', 'theta', 'rho', 'sigma',
    'tau', 'upsilon', 'omega1', 'omega',
    'xi', 'psi', 'zeta', 'braceleft',
    'bar', 'braceright', 'similar', EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, 'Upsilon1', 'minute', 'lessequal',
    'fraction', 'infinity', 'florin', 'club',
    'diamond', 'heart', 'spade', 'arrowboth',
    'arrowleft', 'arrowup', 'arrowright', 'arrowdown',
    'degree', 'plusminus', 'second', 'greaterequal',
    'multiply', 'proportional', 'partialdiff', 'bullet',
    'divide', 'notequal', 'equivalence', 'approxequal',
    'ellipsis', 'arrowvertex', 'arrowhorizex', 'carriagereturn',
    'aleph', 'Ifraktur', 'Rfraktur', 'weierstrass',
    'circlemultiply', 'circleplus', 'emptyset', 'intersection',
    'union', 'propersuperset', 'reflexsuperset', 'notsubset',
    'propersubset', 'reflexsubset', 'element', 'notelement',
    'angle', 'gradient', 'registerserif', 'copyrightserif',
    'trademarkserif', 'product', 'radical', 'dotmath',
    'logicalnot', 'logicaland', 'logicalor', 'arrowdblboth',
    'arrowdblleft', 'arrowdblup', 'arrowdblright', 'arrowdbldown',
    'lozenge', 'angleleft', 'registersans', 'copyrightsans',
    'trademarksans', 'summation', 'parenlefttp', 'parenleftex',
    'parenleftbt', 'bracketlefttp', 'bracketleftex', 'bracketleftbt',
    'bracelefttp', 'braceleftmid', 'braceleftbt', 'braceex',
    EMPTY, 'angleright', 'integral', 'integraltp',
    'integralex', 'integralbt', 'parenrighttp', 'parenrightex',
    'parenrightbt', 'bracketrighttp', 'bracketrightex', 'bracketrightbt',
    'bracerighttp', 'bracerightmid', 'bracerightbt', EMPTY
    );

  ZapfDingbatsEncoding: TgtEncodingArray =
  (
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    'space', 'a1', 'a2', 'a202',
    'a3', 'a4', 'a5', 'a119',
    'a118', 'a117', 'a11', 'a12',
    'a13', 'a14', 'a15', 'a16',
    'a105', 'a17', 'a18', 'a19',
    'a20', 'a21', 'a22', 'a23',
    'a24', 'a25', 'a26', 'a27',
    'a28', 'a6', 'a7', 'a8',
    'a9', 'a10', 'a29', 'a30',
    'a31', 'a32', 'a33', 'a34',
    'a35', 'a36', 'a37', 'a38',
    'a39', 'a40', 'a41', 'a42',
    'a43', 'a44', 'a45', 'a46',
    'a47', 'a48', 'a49', 'a50',
    'a51', 'a52', 'a53', 'a54',
    'a55', 'a56', 'a57', 'a58',
    'a59', 'a60', 'a61', 'a62',
    'a63', 'a64', 'a65', 'a66',
    'a67', 'a68', 'a69', 'a70',
    'a71', 'a72', 'a73', 'a74',
    'a203', 'a75', 'a204', 'a76',
    'a77', 'a78', 'a79', 'a81',
    'a82', 'a83', 'a84', 'a97',
    'a98', 'a99', 'a100', EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, EMPTY, EMPTY, EMPTY,
    EMPTY, 'a101', 'a102', 'a103',
    'a104', 'a106', 'a107', 'a108',
    'a112', 'a111', 'a110', 'a109',
    'a120', 'a121', 'a122', 'a123',
    'a124', 'a125', 'a126', 'a127',
    'a128', 'a129', 'a130', 'a131',
    'a132', 'a133', 'a134', 'a135',
    'a136', 'a137', 'a138', 'a139',
    'a140', 'a141', 'a142', 'a143',
    'a144', 'a145', 'a146', 'a147',
    'a148', 'a149', 'a150', 'a151',
    'a152', 'a153', 'a154', 'a155',
    'a156', 'a157', 'a158', 'a159',
    'a160', 'a161', 'a163', 'a164',
    'a196', 'a165', 'a192', 'a166',
    'a167', 'a168', 'a169', 'a170',
    'a171', 'a172', 'a173', 'a162',
    'a174', 'a175', 'a176', 'a177',
    'a178', 'a179', 'a193', 'a180',
    'a199', 'a181', 'a200', 'a182',
    EMPTY, 'a201', 'a183', 'a184',
    'a197', 'a185', 'a194', 'a198',
    'a186', 'a195', 'a187', 'a188',
    'a189', 'a190', 'a191', EMPTY
    );

implementation

end.
