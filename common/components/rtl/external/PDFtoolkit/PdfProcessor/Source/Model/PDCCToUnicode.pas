unit PDCCToUnicode;

interface

uses
  Classes, gtObject, gtTypes, gtConstants, SysUtils;

type
  NameToUnicode = record
    Unicode: Integer;
    Name: AnsiString;
  end;

  TgtUnicodeArray =   array [0..255] of TgtUnicode;

const
  NameToUnicodeTab: array[0..1083] of NameToUnicode =
    ( (Unicode: $0021; Name: '!'),
      (Unicode: $0023; Name: '#'),
      (Unicode: $0024; Name: '$'),
      (Unicode: $0025; Name: '%'),
      (Unicode: $0026; Name: '&'),
      (Unicode: $0027; Name: ''''),
      (Unicode: $0028; Name: '('),
      (Unicode: $0029; Name: ')'),
      (Unicode: $002a; Name: '*'),
      (Unicode: $002b; Name: '+'),
      (Unicode: $002c; Name: ','),
      (Unicode: $002d; Name: '-'),
      (Unicode: $002e; Name: '.'),
      (Unicode: $002f; Name: '/'),
      (Unicode: $0030; Name: '0'),
      (Unicode: $0031; Name: '1'),
      (Unicode: $0032; Name: '2'),
      (Unicode: $0033; Name: '3'),
      (Unicode: $0034; Name: '4'),
      (Unicode: $0035; Name: '5'),
      (Unicode: $0036; Name: '6'),
      (Unicode: $0037; Name: '7'),
      (Unicode: $0038; Name: '8'),
      (Unicode: $0039; Name: '9'),
      (Unicode: $003a; Name: ':'),
      (Unicode: $003b; Name: ';'),
      (Unicode: $003c; Name: '<'),
      (Unicode: $003d; Name: '='),
      (Unicode: $003e; Name: '>'),
      (Unicode: $003f; Name: '?'),
      (Unicode: $0040; Name: '@'),
      (Unicode: $0041; Name: 'A'),
      (Unicode: $00c6; Name: 'AE'),
      (Unicode: $01fc; Name: 'AEacute'),
      (Unicode: $f7e6; Name: 'AEsmall'),
      (Unicode: $00c1; Name: 'Aacute'),
      (Unicode: $f7e1; Name: 'Aacutesmall'),
      (Unicode: $0102; Name: 'Abreve'),
      (Unicode: $00c2; Name: 'Acircumflex'),
      (Unicode: $f7e2; Name: 'Acircumflexsmall'),
      (Unicode: $f6c9; Name: 'Acute'),
      (Unicode: $f7b4; Name: 'Acutesmall'),
      (Unicode: $00c4; Name: 'Adieresis'),
      (Unicode: $f7e4; Name: 'Adieresissmall'),
      (Unicode: $00c0; Name: 'Agrave'),
      (Unicode: $f7e0; Name: 'Agravesmall'),
      (Unicode: $0391; Name: 'Alpha'),
      (Unicode: $0386; Name: 'Alphatonos'),
      (Unicode: $0100; Name: 'Amacron'),
      (Unicode: $0104; Name: 'Aogonek'),
      (Unicode: $00c5; Name: 'Aring'),
      (Unicode: $01fa; Name: 'Aringacute'),
      (Unicode: $f7e5; Name: 'Aringsmall'),
      (Unicode: $f761; Name: 'Asmall'),
      (Unicode: $00c3; Name: 'Atilde'),
      (Unicode: $f7e3; Name: 'Atildesmall'),
      (Unicode: $0042; Name: 'B'),
      (Unicode: $0392; Name: 'Beta'),
      (Unicode: $f6f4; Name: 'Brevesmall'),
      (Unicode: $f762; Name: 'Bsmall'),
      (Unicode: $0043; Name: 'C'),
      (Unicode: $0106; Name: 'Cacute'),
      (Unicode: $f6ca; Name: 'Caron'),
      (Unicode: $f6f5; Name: 'Caronsmall'),
      (Unicode: $010c; Name: 'Ccaron'),
      (Unicode: $00c7; Name: 'Ccedilla'),
      (Unicode: $f7e7; Name: 'Ccedillasmall'),
      (Unicode: $0108; Name: 'Ccircumflex'),
      (Unicode: $010a; Name: 'Cdotaccent'),
      (Unicode: $f7b8; Name: 'Cedillasmall'),
      (Unicode: $03a7; Name: 'Chi'),
      (Unicode: $f6f6; Name: 'Circumflexsmall'),
      (Unicode: $f763; Name: 'Csmall'),
      (Unicode: $0044; Name: 'D'),
      (Unicode: $010e; Name: 'Dcaron'),
      (Unicode: $0110; Name: 'Dcroat'),
      (Unicode: $2206; Name: 'Delta'),
      (Unicode: $f6cb; Name: 'Dieresis'),
      (Unicode: $f6cc; Name: 'DieresisAcute'),
      (Unicode: $f6cd; Name: 'DieresisGrave'),
      (Unicode: $f7a8; Name: 'Dieresissmall'),
      (Unicode: $f6f7; Name: 'Dotaccentsmall'),
      (Unicode: $f764; Name: 'Dsmall'),
      (Unicode: $0045; Name: 'E'),
      (Unicode: $00c9; Name: 'Eacute'),
      (Unicode: $f7e9; Name: 'Eacutesmall'),
      (Unicode: $0114; Name: 'Ebreve'),
      (Unicode: $011a; Name: 'Ecaron'),
      (Unicode: $00ca; Name: 'Ecircumflex'),
      (Unicode: $f7ea; Name: 'Ecircumflexsmall'),
      (Unicode: $00cb; Name: 'Edieresis'),
      (Unicode: $f7eb; Name: 'Edieresissmall'),
      (Unicode: $0116; Name: 'Edotaccent'),
      (Unicode: $00c8; Name: 'Egrave'),
      (Unicode: $f7e8; Name: 'Egravesmall'),
      (Unicode: $0112; Name: 'Emacron'),
      (Unicode: $014a; Name: 'Eng'),
      (Unicode: $0118; Name: 'Eogonek'),
      (Unicode: $0395; Name: 'Epsilon'),
      (Unicode: $0388; Name: 'Epsilontonos'),
      (Unicode: $f765; Name: 'Esmall'),
      (Unicode: $0397; Name: 'Eta'),
      (Unicode: $0389; Name: 'Etatonos'),
      (Unicode: $00d0; Name: 'Eth'),
      (Unicode: $f7f0; Name: 'Ethsmall'),
      (Unicode: $20ac; Name: 'Euro'),
      (Unicode: $0046; Name: 'F'),
      (Unicode: $f766; Name: 'Fsmall'),
      (Unicode: $0047; Name: 'G'),
      (Unicode: $0393; Name: 'Gamma'),
      (Unicode: $011e; Name: 'Gbreve'),
      (Unicode: $01e6; Name: 'Gcaron'),
      (Unicode: $011c; Name: 'Gcircumflex'),
      (Unicode: $0122; Name: 'Gcommaaccent'),
      (Unicode: $0120; Name: 'Gdotaccent'),
      (Unicode: $f6ce; Name: 'Grave'),
      (Unicode: $f760; Name: 'Gravesmall'),
      (Unicode: $f767; Name: 'Gsmall'),
      (Unicode: $0048; Name: 'H'),
      (Unicode: $25cf; Name: 'H18533'),
      (Unicode: $25aa; Name: 'H18543'),
      (Unicode: $25ab; Name: 'H18551'),
      (Unicode: $25a1; Name: 'H22073'),
      (Unicode: $0126; Name: 'Hbar'),
      (Unicode: $0124; Name: 'Hcircumflex'),
      (Unicode: $f768; Name: 'Hsmall'),
      (Unicode: $f6cf; Name: 'Hungarumlaut'),
      (Unicode: $f6f8; Name: 'Hungarumlautsmall'),
      (Unicode: $0049; Name: 'I'),
      (Unicode: $0132; Name: 'IJ'),
      (Unicode: $00cd; Name: 'Iacute'),
      (Unicode: $f7ed; Name: 'Iacutesmall'),
      (Unicode: $012c; Name: 'Ibreve'),
      (Unicode: $00ce; Name: 'Icircumflex'),
      (Unicode: $f7ee; Name: 'Icircumflexsmall'),
      (Unicode: $00cf; Name: 'Idieresis'),
      (Unicode: $f7ef; Name: 'Idieresissmall'),
      (Unicode: $0130; Name: 'Idotaccent'),
      (Unicode: $2111; Name: 'Ifraktur'),
      (Unicode: $00cc; Name: 'Igrave'),
      (Unicode: $f7ec; Name: 'Igravesmall'),
      (Unicode: $012a; Name: 'Imacron'),
      (Unicode: $012e; Name: 'Iogonek'),
      (Unicode: $0399; Name: 'Iota'),
      (Unicode: $03aa; Name: 'Iotadieresis'),
      (Unicode: $038a; Name: 'Iotatonos'),
      (Unicode: $f769; Name: 'Ismall'),
      (Unicode: $0128; Name: 'Itilde'),
      (Unicode: $004a; Name: 'J'),
      (Unicode: $0134; Name: 'Jcircumflex'),
      (Unicode: $f76a; Name: 'Jsmall'),
      (Unicode: $004b; Name: 'K'),
      (Unicode: $039a; Name: 'Kappa'),
      (Unicode: $0136; Name: 'Kcommaaccent'),
      (Unicode: $f76b; Name: 'Ksmall'),
      (Unicode: $004c; Name: 'L'),
      (Unicode: $f6bf; Name: 'LL'),
      (Unicode: $0139; Name: 'Lacute'),
      (Unicode: $039b; Name: 'Lambda'),
      (Unicode: $013d; Name: 'Lcaron'),
      (Unicode: $013b; Name: 'Lcommaaccent'),
      (Unicode: $013f; Name: 'Ldot'),
      (Unicode: $0141; Name: 'Lslash'),
      (Unicode: $f6f9; Name: 'Lslashsmall'),
      (Unicode: $f76c; Name: 'Lsmall'),
      (Unicode: $004d; Name: 'M'),
      (Unicode: $f6d0; Name: 'Macron'),
      (Unicode: $f7af; Name: 'Macronsmall'),
      (Unicode: $f76d; Name: 'Msmall'),
      (Unicode: $039c; Name: 'Mu'),
      (Unicode: $004e; Name: 'N'),
      (Unicode: $0143; Name: 'Nacute'),
      (Unicode: $0147; Name: 'Ncaron'),
      (Unicode: $0145; Name: 'Ncommaaccent'),
      (Unicode: $f76e; Name: 'Nsmall'),
      (Unicode: $00d1; Name: 'Ntilde'),
      (Unicode: $f7f1; Name: 'Ntildesmall'),
      (Unicode: $039d; Name: 'Nu'),
      (Unicode: $004f; Name: 'O'),
      (Unicode: $0152; Name: 'OE'),
      (Unicode: $f6fa; Name: 'OEsmall'),
      (Unicode: $00d3; Name: 'Oacute'),
      (Unicode: $f7f3; Name: 'Oacutesmall'),
      (Unicode: $014e; Name: 'Obreve'),
      (Unicode: $00d4; Name: 'Ocircumflex'),
      (Unicode: $f7f4; Name: 'Ocircumflexsmall'),
      (Unicode: $00d6; Name: 'Odieresis'),
      (Unicode: $f7f6; Name: 'Odieresissmall'),
      (Unicode: $f6fb; Name: 'Ogoneksmall'),
      (Unicode: $00d2; Name: 'Ograve'),
      (Unicode: $f7f2; Name: 'Ogravesmall'),
      (Unicode: $01a0; Name: 'Ohorn'),
      (Unicode: $0150; Name: 'Ohungarumlaut'),
      (Unicode: $014c; Name: 'Omacron'),
      (Unicode: $2126; Name: 'Omega'),
      (Unicode: $038f; Name: 'Omegatonos'),
      (Unicode: $039f; Name: 'Omicron'),
      (Unicode: $038c; Name: 'Omicrontonos'),
      (Unicode: $00d8; Name: 'Oslash'),
      (Unicode: $01fe; Name: 'Oslashacute'),
      (Unicode: $f7f8; Name: 'Oslashsmall'),
      (Unicode: $f76f; Name: 'Osmall'),
      (Unicode: $00d5; Name: 'Otilde'),
      (Unicode: $f7f5; Name: 'Otildesmall'),
      (Unicode: $0050; Name: 'P'),
      (Unicode: $03a6; Name: 'Phi'),
      (Unicode: $03a0; Name: 'Pi'),
      (Unicode: $03a8; Name: 'Psi'),
      (Unicode: $f770; Name: 'Psmall'),
      (Unicode: $0051; Name: 'Q'),
      (Unicode: $f771; Name: 'Qsmall'),
      (Unicode: $0052; Name: 'R'),
      (Unicode: $0154; Name: 'Racute'),
      (Unicode: $0158; Name: 'Rcaron'),
      (Unicode: $0156; Name: 'Rcommaaccent'),
      (Unicode: $211c; Name: 'Rfraktur'),
      (Unicode: $03a1; Name: 'Rho'),
      (Unicode: $f6fc; Name: 'Ringsmall'),
      (Unicode: $f772; Name: 'Rsmall'),
      (Unicode: $0053; Name: 'S'),
      (Unicode: $250c; Name: 'SF010000'),
      (Unicode: $2514; Name: 'SF020000'),
      (Unicode: $2510; Name: 'SF030000'),
      (Unicode: $2518; Name: 'SF040000'),
      (Unicode: $253c; Name: 'SF050000'),
      (Unicode: $252c; Name: 'SF060000'),
      (Unicode: $2534; Name: 'SF070000'),
      (Unicode: $251c; Name: 'SF080000'),
      (Unicode: $2524; Name: 'SF090000'),
      (Unicode: $2500; Name: 'SF100000'),
      (Unicode: $2502; Name: 'SF110000'),
      (Unicode: $2561; Name: 'SF190000'),
      (Unicode: $2562; Name: 'SF200000'),
      (Unicode: $2556; Name: 'SF210000'),
      (Unicode: $2555; Name: 'SF220000'),
      (Unicode: $2563; Name: 'SF230000'),
      (Unicode: $2551; Name: 'SF240000'),
      (Unicode: $2557; Name: 'SF250000'),
      (Unicode: $255d; Name: 'SF260000'),
      (Unicode: $255c; Name: 'SF270000'),
      (Unicode: $255b; Name: 'SF280000'),
      (Unicode: $255e; Name: 'SF360000'),
      (Unicode: $255f; Name: 'SF370000'),
      (Unicode: $255a; Name: 'SF380000'),
      (Unicode: $2554; Name: 'SF390000'),
      (Unicode: $2569; Name: 'SF400000'),
      (Unicode: $2566; Name: 'SF410000'),
      (Unicode: $2560; Name: 'SF420000'),
      (Unicode: $2550; Name: 'SF430000'),
      (Unicode: $256c; Name: 'SF440000'),
      (Unicode: $2567; Name: 'SF450000'),
      (Unicode: $2568; Name: 'SF460000'),
      (Unicode: $2564; Name: 'SF470000'),
      (Unicode: $2565; Name: 'SF480000'),
      (Unicode: $2559; Name: 'SF490000'),
      (Unicode: $2558; Name: 'SF500000'),
      (Unicode: $2552; Name: 'SF510000'),
      (Unicode: $2553; Name: 'SF520000'),
      (Unicode: $256b; Name: 'SF530000'),
      (Unicode: $256a; Name: 'SF540000'),
      (Unicode: $015a; Name: 'Sacute'),
      (Unicode: $0160; Name: 'Scaron'),
      (Unicode: $f6fd; Name: 'Scaronsmall'),
      (Unicode: $015e; Name: 'Scedilla'),
      (Unicode: $015c; Name: 'Scircumflex'),
      (Unicode: $0218; Name: 'Scommaaccent'),
      (Unicode: $03a3; Name: 'Sigma'),
      (Unicode: $f773; Name: 'Ssmall'),
      (Unicode: $0054; Name: 'T'),
      (Unicode: $03a4; Name: 'Tau'),
      (Unicode: $0166; Name: 'Tbar'),
      (Unicode: $0164; Name: 'Tcaron'),
      (Unicode: $0162; Name: 'Tcommaaccent'),
      (Unicode: $0398; Name: 'Theta'),
      (Unicode: $00de; Name: 'Thorn'),
      (Unicode: $f7fe; Name: 'Thornsmall'),
      (Unicode: $f6fe; Name: 'Tildesmall'),
      (Unicode: $f774; Name: 'Tsmall'),
      (Unicode: $0055; Name: 'U'),
      (Unicode: $00da; Name: 'Uacute'),
      (Unicode: $f7fa; Name: 'Uacutesmall'),
      (Unicode: $016c; Name: 'Ubreve'),
      (Unicode: $00db; Name: 'Ucircumflex'),
      (Unicode: $f7fb; Name: 'Ucircumflexsmall'),
      (Unicode: $00dc; Name: 'Udieresis'),
      (Unicode: $f7fc; Name: 'Udieresissmall'),
      (Unicode: $00d9; Name: 'Ugrave'),
      (Unicode: $f7f9; Name: 'Ugravesmall'),
      (Unicode: $01af; Name: 'Uhorn'),
      (Unicode: $0170; Name: 'Uhungarumlaut'),
      (Unicode: $016a; Name: 'Umacron'),
      (Unicode: $0172; Name: 'Uogonek'),
      (Unicode: $03a5; Name: 'Upsilon'),
      (Unicode: $03d2; Name: 'Upsilon1'),
      (Unicode: $03ab; Name: 'Upsilondieresis'),
      (Unicode: $038e; Name: 'Upsilontonos'),
      (Unicode: $016e; Name: 'Uring'),
      (Unicode: $f775; Name: 'Usmall'),
      (Unicode: $0168; Name: 'Utilde'),
      (Unicode: $0056; Name: 'V'),
      (Unicode: $f776; Name: 'Vsmall'),
      (Unicode: $0057; Name: 'W'),
      (Unicode: $1e82; Name: 'Wacute'),
      (Unicode: $0174; Name: 'Wcircumflex'),
      (Unicode: $1e84; Name: 'Wdieresis'),
      (Unicode: $1e80; Name: 'Wgrave'),
      (Unicode: $f777; Name: 'Wsmall'),
      (Unicode: $0058; Name: 'X'),
      (Unicode: $039e; Name: 'Xi'),
      (Unicode: $f778; Name: 'Xsmall'),
      (Unicode: $0059; Name: 'Y'),
      (Unicode: $00dd; Name: 'Yacute'),
      (Unicode: $f7fd; Name: 'Yacutesmall'),
      (Unicode: $0176; Name: 'Ycircumflex'),
      (Unicode: $0178; Name: 'Ydieresis'),
      (Unicode: $f7ff; Name: 'Ydieresissmall'),
      (Unicode: $1ef2; Name: 'Ygrave'),
      (Unicode: $f779; Name: 'Ysmall'),
      (Unicode: $005a; Name: 'Z'),
      (Unicode: $0179; Name: 'Zacute'),
      (Unicode: $017d; Name: 'Zcaron'),
      (Unicode: $f6ff; Name: 'Zcaronsmall'),
      (Unicode: $017b; Name: 'Zdotaccent'),
      (Unicode: $0396; Name: 'Zeta'),
      (Unicode: $f77a; Name: 'Zsmall'),
      (Unicode: $0022; Name: '\"'),
      (Unicode: $005c; Name: '\\'),
      (Unicode: $005d; Name: ']'),
      (Unicode: $005e; Name: '^'),
      (Unicode: $005f; Name: '_'),
      (Unicode: $0060; Name: '`'),
      (Unicode: $0061; Name: 'a'),
      (Unicode: $00e1; Name: 'aacute'),
      (Unicode: $0103; Name: 'abreve'),
      (Unicode: $00e2; Name: 'acircumflex'),
      (Unicode: $00b4; Name: 'acute'),
      (Unicode: $0301; Name: 'acutecomb'),
      (Unicode: $00e4; Name: 'adieresis'),
      (Unicode: $00e6; Name: 'ae'),
      (Unicode: $01fd; Name: 'aeacute'),
      (Unicode: $2015; Name: 'afii00208'),
      (Unicode: $0410; Name: 'afii10017'),
      (Unicode: $0411; Name: 'afii10018'),
      (Unicode: $0412; Name: 'afii10019'),
      (Unicode: $0413; Name: 'afii10020'),
      (Unicode: $0414; Name: 'afii10021'),
      (Unicode: $0415; Name: 'afii10022'),
      (Unicode: $0401; Name: 'afii10023'),
      (Unicode: $0416; Name: 'afii10024'),
      (Unicode: $0417; Name: 'afii10025'),
      (Unicode: $0418; Name: 'afii10026'),
      (Unicode: $0419; Name: 'afii10027'),
      (Unicode: $041a; Name: 'afii10028'),
      (Unicode: $041b; Name: 'afii10029'),
      (Unicode: $041c; Name: 'afii10030'),
      (Unicode: $041d; Name: 'afii10031'),
      (Unicode: $041e; Name: 'afii10032'),
      (Unicode: $041f; Name: 'afii10033'),
      (Unicode: $0420; Name: 'afii10034'),
      (Unicode: $0421; Name: 'afii10035'),
      (Unicode: $0422; Name: 'afii10036'),
      (Unicode: $0423; Name: 'afii10037'),
      (Unicode: $0424; Name: 'afii10038'),
      (Unicode: $0425; Name: 'afii10039'),
      (Unicode: $0426; Name: 'afii10040'),
      (Unicode: $0427; Name: 'afii10041'),
      (Unicode: $0428; Name: 'afii10042'),
      (Unicode: $0429; Name: 'afii10043'),
      (Unicode: $042a; Name: 'afii10044'),
      (Unicode: $042b; Name: 'afii10045'),
      (Unicode: $042c; Name: 'afii10046'),
      (Unicode: $042d; Name: 'afii10047'),
      (Unicode: $042e; Name: 'afii10048'),
      (Unicode: $042f; Name: 'afii10049'),
      (Unicode: $0490; Name: 'afii10050'),
      (Unicode: $0402; Name: 'afii10051'),
      (Unicode: $0403; Name: 'afii10052'),
      (Unicode: $0404; Name: 'afii10053'),
      (Unicode: $0405; Name: 'afii10054'),
      (Unicode: $0406; Name: 'afii10055'),
      (Unicode: $0407; Name: 'afii10056'),
      (Unicode: $0408; Name: 'afii10057'),
      (Unicode: $0409; Name: 'afii10058'),
      (Unicode: $040a; Name: 'afii10059'),
      (Unicode: $040b; Name: 'afii10060'),
      (Unicode: $040c; Name: 'afii10061'),
      (Unicode: $040e; Name: 'afii10062'),
      (Unicode: $f6c4; Name: 'afii10063'),
      (Unicode: $f6c5; Name: 'afii10064'),
      (Unicode: $0430; Name: 'afii10065'),
      (Unicode: $0431; Name: 'afii10066'),
      (Unicode: $0432; Name: 'afii10067'),
      (Unicode: $0433; Name: 'afii10068'),
      (Unicode: $0434; Name: 'afii10069'),
      (Unicode: $0435; Name: 'afii10070'),
      (Unicode: $0451; Name: 'afii10071'),
      (Unicode: $0436; Name: 'afii10072'),
      (Unicode: $0437; Name: 'afii10073'),
      (Unicode: $0438; Name: 'afii10074'),
      (Unicode: $0439; Name: 'afii10075'),
      (Unicode: $043a; Name: 'afii10076'),
      (Unicode: $043b; Name: 'afii10077'),
      (Unicode: $043c; Name: 'afii10078'),
      (Unicode: $043d; Name: 'afii10079'),
      (Unicode: $043e; Name: 'afii10080'),
      (Unicode: $043f; Name: 'afii10081'),
      (Unicode: $0440; Name: 'afii10082'),
      (Unicode: $0441; Name: 'afii10083'),
      (Unicode: $0442; Name: 'afii10084'),
      (Unicode: $0443; Name: 'afii10085'),
      (Unicode: $0444; Name: 'afii10086'),
      (Unicode: $0445; Name: 'afii10087'),
      (Unicode: $0446; Name: 'afii10088'),
      (Unicode: $0447; Name: 'afii10089'),
      (Unicode: $0448; Name: 'afii10090'),
      (Unicode: $0449; Name: 'afii10091'),
      (Unicode: $044a; Name: 'afii10092'),
      (Unicode: $044b; Name: 'afii10093'),
      (Unicode: $044c; Name: 'afii10094'),
      (Unicode: $044d; Name: 'afii10095'),
      (Unicode: $044e; Name: 'afii10096'),
      (Unicode: $044f; Name: 'afii10097'),
      (Unicode: $0491; Name: 'afii10098'),
      (Unicode: $0452; Name: 'afii10099'),
      (Unicode: $0453; Name: 'afii10100'),
      (Unicode: $0454; Name: 'afii10101'),
      (Unicode: $0455; Name: 'afii10102'),
      (Unicode: $0456; Name: 'afii10103'),
      (Unicode: $0457; Name: 'afii10104'),
      (Unicode: $0458; Name: 'afii10105'),
      (Unicode: $0459; Name: 'afii10106'),
      (Unicode: $045a; Name: 'afii10107'),
      (Unicode: $045b; Name: 'afii10108'),
      (Unicode: $045c; Name: 'afii10109'),
      (Unicode: $045e; Name: 'afii10110'),
      (Unicode: $040f; Name: 'afii10145'),
      (Unicode: $0462; Name: 'afii10146'),
      (Unicode: $0472; Name: 'afii10147'),
      (Unicode: $0474; Name: 'afii10148'),
      (Unicode: $f6c6; Name: 'afii10192'),
      (Unicode: $045f; Name: 'afii10193'),
      (Unicode: $0463; Name: 'afii10194'),
      (Unicode: $0473; Name: 'afii10195'),
      (Unicode: $0475; Name: 'afii10196'),
      (Unicode: $f6c7; Name: 'afii10831'),
      (Unicode: $f6c8; Name: 'afii10832'),
      (Unicode: $04d9; Name: 'afii10846'),
      (Unicode: $200e; Name: 'afii299'),
      (Unicode: $200f; Name: 'afii300'),
      (Unicode: $200d; Name: 'afii301'),
      (Unicode: $066a; Name: 'afii57381'),
      (Unicode: $060c; Name: 'afii57388'),
      (Unicode: $0660; Name: 'afii57392'),
      (Unicode: $0661; Name: 'afii57393'),
      (Unicode: $0662; Name: 'afii57394'),
      (Unicode: $0663; Name: 'afii57395'),
      (Unicode: $0664; Name: 'afii57396'),
      (Unicode: $0665; Name: 'afii57397'),
      (Unicode: $0666; Name: 'afii57398'),
      (Unicode: $0667; Name: 'afii57399'),
      (Unicode: $0668; Name: 'afii57400'),
      (Unicode: $0669; Name: 'afii57401'),
      (Unicode: $061b; Name: 'afii57403'),
      (Unicode: $061f; Name: 'afii57407'),
      (Unicode: $0621; Name: 'afii57409'),
      (Unicode: $0622; Name: 'afii57410'),
      (Unicode: $0623; Name: 'afii57411'),
      (Unicode: $0624; Name: 'afii57412'),
      (Unicode: $0625; Name: 'afii57413'),
      (Unicode: $0626; Name: 'afii57414'),
      (Unicode: $0627; Name: 'afii57415'),
      (Unicode: $0628; Name: 'afii57416'),
      (Unicode: $0629; Name: 'afii57417'),
      (Unicode: $062a; Name: 'afii57418'),
      (Unicode: $062b; Name: 'afii57419'),
      (Unicode: $062c; Name: 'afii57420'),
      (Unicode: $062d; Name: 'afii57421'),
      (Unicode: $062e; Name: 'afii57422'),
      (Unicode: $062f; Name: 'afii57423'),
      (Unicode: $0630; Name: 'afii57424'),
      (Unicode: $0631; Name: 'afii57425'),
      (Unicode: $0632; Name: 'afii57426'),
      (Unicode: $0633; Name: 'afii57427'),
      (Unicode: $0634; Name: 'afii57428'),
      (Unicode: $0635; Name: 'afii57429'),
      (Unicode: $0636; Name: 'afii57430'),
      (Unicode: $0637; Name: 'afii57431'),
      (Unicode: $0638; Name: 'afii57432'),
      (Unicode: $0639; Name: 'afii57433'),
      (Unicode: $063a; Name: 'afii57434'),
      (Unicode: $0640; Name: 'afii57440'),
      (Unicode: $0641; Name: 'afii57441'),
      (Unicode: $0642; Name: 'afii57442'),
      (Unicode: $0643; Name: 'afii57443'),
      (Unicode: $0644; Name: 'afii57444'),
      (Unicode: $0645; Name: 'afii57445'),
      (Unicode: $0646; Name: 'afii57446'),
      (Unicode: $0648; Name: 'afii57448'),
      (Unicode: $0649; Name: 'afii57449'),
      (Unicode: $064a; Name: 'afii57450'),
      (Unicode: $064b; Name: 'afii57451'),
      (Unicode: $064c; Name: 'afii57452'),
      (Unicode: $064d; Name: 'afii57453'),
      (Unicode: $064e; Name: 'afii57454'),
      (Unicode: $064f; Name: 'afii57455'),
      (Unicode: $0650; Name: 'afii57456'),
      (Unicode: $0651; Name: 'afii57457'),
      (Unicode: $0652; Name: 'afii57458'),
      (Unicode: $0647; Name: 'afii57470'),
      (Unicode: $06a4; Name: 'afii57505'),
      (Unicode: $067e; Name: 'afii57506'),
      (Unicode: $0686; Name: 'afii57507'),
      (Unicode: $0698; Name: 'afii57508'),
      (Unicode: $06af; Name: 'afii57509'),
      (Unicode: $0679; Name: 'afii57511'),
      (Unicode: $0688; Name: 'afii57512'),
      (Unicode: $0691; Name: 'afii57513'),
      (Unicode: $06ba; Name: 'afii57514'),
      (Unicode: $06d2; Name: 'afii57519'),
      (Unicode: $06d5; Name: 'afii57534'),
      (Unicode: $20aa; Name: 'afii57636'),
      (Unicode: $05be; Name: 'afii57645'),
      (Unicode: $05c3; Name: 'afii57658'),
      (Unicode: $05d0; Name: 'afii57664'),
      (Unicode: $05d1; Name: 'afii57665'),
      (Unicode: $05d2; Name: 'afii57666'),
      (Unicode: $05d3; Name: 'afii57667'),
      (Unicode: $05d4; Name: 'afii57668'),
      (Unicode: $05d5; Name: 'afii57669'),
      (Unicode: $05d6; Name: 'afii57670'),
      (Unicode: $05d7; Name: 'afii57671'),
      (Unicode: $05d8; Name: 'afii57672'),
      (Unicode: $05d9; Name: 'afii57673'),
      (Unicode: $05da; Name: 'afii57674'),
      (Unicode: $05db; Name: 'afii57675'),
      (Unicode: $05dc; Name: 'afii57676'),
      (Unicode: $05dd; Name: 'afii57677'),
      (Unicode: $05de; Name: 'afii57678'),
      (Unicode: $05df; Name: 'afii57679'),
      (Unicode: $05e0; Name: 'afii57680'),
      (Unicode: $05e1; Name: 'afii57681'),
      (Unicode: $05e2; Name: 'afii57682'),
      (Unicode: $05e3; Name: 'afii57683'),
      (Unicode: $05e4; Name: 'afii57684'),
      (Unicode: $05e5; Name: 'afii57685'),
      (Unicode: $05e6; Name: 'afii57686'),
      (Unicode: $05e7; Name: 'afii57687'),
      (Unicode: $05e8; Name: 'afii57688'),
      (Unicode: $05e9; Name: 'afii57689'),
      (Unicode: $05ea; Name: 'afii57690'),
      (Unicode: $fb2a; Name: 'afii57694'),
      (Unicode: $fb2b; Name: 'afii57695'),
      (Unicode: $fb4b; Name: 'afii57700'),
      (Unicode: $fb1f; Name: 'afii57705'),
      (Unicode: $05f0; Name: 'afii57716'),
      (Unicode: $05f1; Name: 'afii57717'),
      (Unicode: $05f2; Name: 'afii57718'),
      (Unicode: $fb35; Name: 'afii57723'),
      (Unicode: $05b4; Name: 'afii57793'),
      (Unicode: $05b5; Name: 'afii57794'),
      (Unicode: $05b6; Name: 'afii57795'),
      (Unicode: $05bb; Name: 'afii57796'),
      (Unicode: $05b8; Name: 'afii57797'),
      (Unicode: $05b7; Name: 'afii57798'),
      (Unicode: $05b0; Name: 'afii57799'),
      (Unicode: $05b2; Name: 'afii57800'),
      (Unicode: $05b1; Name: 'afii57801'),
      (Unicode: $05b3; Name: 'afii57802'),
      (Unicode: $05c2; Name: 'afii57803'),
      (Unicode: $05c1; Name: 'afii57804'),
      (Unicode: $05b9; Name: 'afii57806'),
      (Unicode: $05bc; Name: 'afii57807'),
      (Unicode: $05bd; Name: 'afii57839'),
      (Unicode: $05bf; Name: 'afii57841'),
      (Unicode: $05c0; Name: 'afii57842'),
      (Unicode: $02bc; Name: 'afii57929'),
      (Unicode: $2105; Name: 'afii61248'),
      (Unicode: $2113; Name: 'afii61289'),
      (Unicode: $2116; Name: 'afii61352'),
      (Unicode: $202c; Name: 'afii61573'),
      (Unicode: $202d; Name: 'afii61574'),
      (Unicode: $202e; Name: 'afii61575'),
      (Unicode: $200c; Name: 'afii61664'),
      (Unicode: $066d; Name: 'afii63167'),
      (Unicode: $02bd; Name: 'afii64937'),
      (Unicode: $00e0; Name: 'agrave'),
      (Unicode: $2135; Name: 'aleph'),
      (Unicode: $03b1; Name: 'alpha'),
      (Unicode: $03ac; Name: 'alphatonos'),
      (Unicode: $0101; Name: 'amacron'),
      (Unicode: $0026; Name: 'ampersand'),
      (Unicode: $f726; Name: 'ampersandsmall'),
      (Unicode: $2220; Name: 'angle'),
      (Unicode: $2329; Name: 'angleleft'),
      (Unicode: $232a; Name: 'angleright'),
      (Unicode: $0387; Name: 'anoteleia'),
      (Unicode: $0105; Name: 'aogonek'),
      (Unicode: $2248; Name: 'approxequal'),
      (Unicode: $00e5; Name: 'aring'),
      (Unicode: $01fb; Name: 'aringacute'),
      (Unicode: $2194; Name: 'arrowboth'),
      (Unicode: $21d4; Name: 'arrowdblboth'),
      (Unicode: $21d3; Name: 'arrowdbldown'),
      (Unicode: $21d0; Name: 'arrowdblleft'),
      (Unicode: $21d2; Name: 'arrowdblright'),
      (Unicode: $21d1; Name: 'arrowdblup'),
      (Unicode: $2193; Name: 'arrowdown'),
      (Unicode: $f8e7; Name: 'arrowhorizex'),
      (Unicode: $2190; Name: 'arrowleft'),
      (Unicode: $2192; Name: 'arrowright'),
      (Unicode: $2191; Name: 'arrowup'),
      (Unicode: $2195; Name: 'arrowupdn'),
      (Unicode: $21a8; Name: 'arrowupdnbse'),
      (Unicode: $f8e6; Name: 'arrowvertex'),
      (Unicode: $005e; Name: 'asciicircum'),
      (Unicode: $007e; Name: 'asciitilde'),
      (Unicode: $002a; Name: 'asterisk'),
      (Unicode: $2217; Name: 'asteriskmath'),
      (Unicode: $f6e9; Name: 'asuperior'),
      (Unicode: $0040; Name: 'at'),
      (Unicode: $00e3; Name: 'atilde'),
      (Unicode: $0062; Name: 'b'),
      (Unicode: $005c; Name: 'backslash'),
      (Unicode: $007c; Name: 'bar'),
      (Unicode: $03b2; Name: 'beta'),
      (Unicode: $2588; Name: 'block'),
      (Unicode: $f8f4; Name: 'braceex'),
      (Unicode: $007b; Name: 'braceleft'),
      (Unicode: $f8f3; Name: 'braceleftbt'),
      (Unicode: $f8f2; Name: 'braceleftmid'),
      (Unicode: $f8f1; Name: 'bracelefttp'),
      (Unicode: $007d; Name: 'braceright'),
      (Unicode: $f8fe; Name: 'bracerightbt'),
      (Unicode: $f8fd; Name: 'bracerightmid'),
      (Unicode: $f8fc; Name: 'bracerighttp'),
      (Unicode: $005b; Name: 'bracketleft'),
      (Unicode: $f8f0; Name: 'bracketleftbt'),
      (Unicode: $f8ef; Name: 'bracketleftex'),
      (Unicode: $f8ee; Name: 'bracketlefttp'),
      (Unicode: $005d; Name: 'bracketright'),
      (Unicode: $f8fb; Name: 'bracketrightbt'),
      (Unicode: $f8fa; Name: 'bracketrightex'),
      (Unicode: $f8f9; Name: 'bracketrighttp'),
      (Unicode: $02d8; Name: 'breve'),
      (Unicode: $00a6; Name: 'brokenbar'),
      (Unicode: $f6ea; Name: 'bsuperior'),
      (Unicode: $2022; Name: 'bullet'),
      (Unicode: $0063; Name: 'c'),
      (Unicode: $0107; Name: 'cacute'),
      (Unicode: $02c7; Name: 'caron'),
      (Unicode: $21b5; Name: 'carriagereturn'),
      (Unicode: $010d; Name: 'ccaron'),
      (Unicode: $00e7; Name: 'ccedilla'),
      (Unicode: $0109; Name: 'ccircumflex'),
      (Unicode: $010b; Name: 'cdotaccent'),
      (Unicode: $00b8; Name: 'cedilla'),
      (Unicode: $00a2; Name: 'cent'),
      (Unicode: $f6df; Name: 'centinferior'),
      (Unicode: $f7a2; Name: 'centoldstyle'),
      (Unicode: $f6e0; Name: 'centsuperior'),
      (Unicode: $03c7; Name: 'chi'),
      (Unicode: $25cb; Name: 'circle'),
      (Unicode: $2297; Name: 'circlemultiply'),
      (Unicode: $2295; Name: 'circleplus'),
      (Unicode: $02c6; Name: 'circumflex'),
      (Unicode: $2663; Name: 'club'),
      (Unicode: $003a; Name: 'colon'),
      (Unicode: $20a1; Name: 'colonmonetary'),
      (Unicode: $002c; Name: 'comma'),
      (Unicode: $f6c3; Name: 'commaaccent'),
      (Unicode: $f6e1; Name: 'commainferior'),
      (Unicode: $f6e2; Name: 'commasuperior'),
      (Unicode: $2245; Name: 'congruent'),
      (Unicode: $00a9; Name: 'copyright'),
      (Unicode: $00a9; Name: 'copyrightsans'),
      (Unicode: $00a9; Name: 'copyrightserif'),
      (Unicode: $00a4; Name: 'currency'),
      (Unicode: $f6d1; Name: 'cyrBreve'),
      (Unicode: $f6d2; Name: 'cyrFlex'),
      (Unicode: $f6d4; Name: 'cyrbreve'),
      (Unicode: $f6d5; Name: 'cyrflex'),
      (Unicode: $0064; Name: 'd'),
      (Unicode: $2020; Name: 'dagger'),
      (Unicode: $2021; Name: 'daggerdbl'),
      (Unicode: $f6d3; Name: 'dblGrave'),
      (Unicode: $f6d6; Name: 'dblgrave'),
      (Unicode: $010f; Name: 'dcaron'),
      (Unicode: $0111; Name: 'dcroat'),
      (Unicode: $00b0; Name: 'degree'),
      (Unicode: $03b4; Name: 'delta'),
      (Unicode: $2666; Name: 'diamond'),
      (Unicode: $00a8; Name: 'dieresis'),
      (Unicode: $f6d7; Name: 'dieresisacute'),
      (Unicode: $f6d8; Name: 'dieresisgrave'),
      (Unicode: $0385; Name: 'dieresistonos'),
      (Unicode: $00f7; Name: 'divide'),
      (Unicode: $2593; Name: 'dkshade'),
      (Unicode: $2584; Name: 'dnblock'),
      (Unicode: $0024; Name: 'dollar'),
      (Unicode: $f6e3; Name: 'dollarinferior'),
      (Unicode: $f724; Name: 'dollaroldstyle'),
      (Unicode: $f6e4; Name: 'dollarsuperior'),
      (Unicode: $20ab; Name: 'dong'),
      (Unicode: $02d9; Name: 'dotaccent'),
      (Unicode: $0323; Name: 'dotbelowcomb'),
      (Unicode: $0131; Name: 'dotlessi'),
      (Unicode: $f6be; Name: 'dotlessj'),
      (Unicode: $22c5; Name: 'dotmath'),
      (Unicode: $f6eb; Name: 'dsuperior'),
      (Unicode: $0065; Name: 'e'),
      (Unicode: $00e9; Name: 'eacute'),
      (Unicode: $0115; Name: 'ebreve'),
      (Unicode: $011b; Name: 'ecaron'),
      (Unicode: $00ea; Name: 'ecircumflex'),
      (Unicode: $00eb; Name: 'edieresis'),
      (Unicode: $0117; Name: 'edotaccent'),
      (Unicode: $00e8; Name: 'egrave'),
      (Unicode: $0038; Name: 'eight'),
      (Unicode: $2088; Name: 'eightinferior'),
      (Unicode: $f738; Name: 'eightoldstyle'),
      (Unicode: $2078; Name: 'eightsuperior'),
      (Unicode: $2208; Name: 'element'),
      (Unicode: $2026; Name: 'ellipsis'),
      (Unicode: $0113; Name: 'emacron'),
      (Unicode: $2014; Name: 'emdash'),
      (Unicode: $2205; Name: 'emptyset'),
      (Unicode: $2013; Name: 'endash'),
      (Unicode: $014b; Name: 'eng'),
      (Unicode: $0119; Name: 'eogonek'),
      (Unicode: $03b5; Name: 'epsilon'),
      (Unicode: $03ad; Name: 'epsilontonos'),
      (Unicode: $003d; Name: 'equal'),
      (Unicode: $2261; Name: 'equivalence'),
      (Unicode: $212e; Name: 'estimated'),
      (Unicode: $f6ec; Name: 'esuperior'),
      (Unicode: $03b7; Name: 'eta'),
      (Unicode: $03ae; Name: 'etatonos'),
      (Unicode: $00f0; Name: 'eth'),
      (Unicode: $0021; Name: 'exclam'),
      (Unicode: $203c; Name: 'exclamdbl'),
      (Unicode: $00a1; Name: 'exclamdown'),
      (Unicode: $f7a1; Name: 'exclamdownsmall'),
      (Unicode: $0021; Name: 'exclamleft'),
      (Unicode: $f721; Name: 'exclamsmall'),
      (Unicode: $2203; Name: 'existential'),
      (Unicode: $0066; Name: 'f'),
      (Unicode: $2640; Name: 'female'),
      (Unicode: $fb00; Name: 'ff'),
      (Unicode: $fb03; Name: 'ffi'),
      (Unicode: $fb04; Name: 'ffl'),
      (Unicode: $fb01; Name: 'fi'),
      (Unicode: $2012; Name: 'figuredash'),
      (Unicode: $25a0; Name: 'filledbox'),
      (Unicode: $25ac; Name: 'filledrect'),
      (Unicode: $0035; Name: 'five'),
      (Unicode: $215d; Name: 'fiveeighths'),
      (Unicode: $2085; Name: 'fiveinferior'),
      (Unicode: $f735; Name: 'fiveoldstyle'),
      (Unicode: $2075; Name: 'fivesuperior'),
      (Unicode: $fb02; Name: 'fl'),
      (Unicode: $0192; Name: 'florin'),
      (Unicode: $0034; Name: 'four'),
      (Unicode: $2084; Name: 'fourinferior'),
      (Unicode: $f734; Name: 'fouroldstyle'),
      (Unicode: $2074; Name: 'foursuperior'),
      (Unicode: $2044; Name: 'fraction'),
      (Unicode: $20a3; Name: 'franc'),
      (Unicode: $0067; Name: 'g'),
      (Unicode: $03b3; Name: 'gamma'),
      (Unicode: $011f; Name: 'gbreve'),
      (Unicode: $01e7; Name: 'gcaron'),
      (Unicode: $011d; Name: 'gcircumflex'),
      (Unicode: $0123; Name: 'gcommaaccent'),
      (Unicode: $0121; Name: 'gdotaccent'),
      (Unicode: $00df; Name: 'germandbls'),
      (Unicode: $2207; Name: 'gradient'),
      (Unicode: $0060; Name: 'grave'),
      (Unicode: $0300; Name: 'gravecomb'),
      (Unicode: $003e; Name: 'greater'),
      (Unicode: $2265; Name: 'greaterequal'),
      (Unicode: $00ab; Name: 'guillemotleft'),
      (Unicode: $00bb; Name: 'guillemotright'),
      (Unicode: $2039; Name: 'guilsinglleft'),
      (Unicode: $203a; Name: 'guilsinglright'),
      (Unicode: $0068; Name: 'h'),
      (Unicode: $0127; Name: 'hbar'),
      (Unicode: $0125; Name: 'hcircumflex'),
      (Unicode: $2665; Name: 'heart'),
      (Unicode: $0309; Name: 'hookabovecomb'),
      (Unicode: $2302; Name: 'house'),
      (Unicode: $02dd; Name: 'hungarumlaut'),
      (Unicode: $002d; Name: 'hyphen'),
      (Unicode: $f6e5; Name: 'hypheninferior'),
      (Unicode: $f6e6; Name: 'hyphensuperior'),
      (Unicode: $0069; Name: 'i'),
      (Unicode: $00ed; Name: 'iacute'),
      (Unicode: $012d; Name: 'ibreve'),
      (Unicode: $00ee; Name: 'icircumflex'),
      (Unicode: $00ef; Name: 'idieresis'),
      (Unicode: $00ec; Name: 'igrave'),
      (Unicode: $0133; Name: 'ij'),
      (Unicode: $012b; Name: 'imacron'),
      (Unicode: $221e; Name: 'infinity'),
      (Unicode: $222b; Name: 'integral'),
      (Unicode: $2321; Name: 'integralbt'),
      (Unicode: $f8f5; Name: 'integralex'),
      (Unicode: $2320; Name: 'integraltp'),
      (Unicode: $2229; Name: 'intersection'),
      (Unicode: $25d8; Name: 'invbullet'),
      (Unicode: $25d9; Name: 'invcircle'),
      (Unicode: $263b; Name: 'invsmileface'),
      (Unicode: $012f; Name: 'iogonek'),
      (Unicode: $03b9; Name: 'iota'),
      (Unicode: $03ca; Name: 'iotadieresis'),
      (Unicode: $0390; Name: 'iotadieresistonos'),
      (Unicode: $03af; Name: 'iotatonos'),
      (Unicode: $f6ed; Name: 'isuperior'),
      (Unicode: $0129; Name: 'itilde'),
      (Unicode: $006a; Name: 'j'),
      (Unicode: $0135; Name: 'jcircumflex'),
      (Unicode: $006b; Name: 'k'),
      (Unicode: $03ba; Name: 'kappa'),
      (Unicode: $0137; Name: 'kcommaaccent'),
      (Unicode: $0138; Name: 'kgreenlandic'),
      (Unicode: $006c; Name: 'l'),
      (Unicode: $013a; Name: 'lacute'),
      (Unicode: $03bb; Name: 'lambda'),
      (Unicode: $013e; Name: 'lcaron'),
      (Unicode: $013c; Name: 'lcommaaccent'),
      (Unicode: $0140; Name: 'ldot'),
      (Unicode: $003c; Name: 'less'),
      (Unicode: $2264; Name: 'lessequal'),
      (Unicode: $258c; Name: 'lfblock'),
      (Unicode: $20a4; Name: 'lira'),
      (Unicode: $f6c0; Name: 'll'),
      (Unicode: $2227; Name: 'logicaland'),
      (Unicode: $00ac; Name: 'logicalnot'),
      (Unicode: $2228; Name: 'logicalor'),
      (Unicode: $017f; Name: 'longs'),
      (Unicode: $25ca; Name: 'lozenge'),
      (Unicode: $0142; Name: 'lslash'),
      (Unicode: $f6ee; Name: 'lsuperior'),
      (Unicode: $2591; Name: 'ltshade'),
      (Unicode: $006d; Name: 'm'),
      (Unicode: $00af; Name: 'macron'),
      (Unicode: $2642; Name: 'male'),
      (Unicode: $2212; Name: 'minus'),
      (Unicode: $2032; Name: 'minute'),
      (Unicode: $f6ef; Name: 'msuperior'),
      (Unicode: $00b5; Name: 'mu'),
      (Unicode: $00d7; Name: 'multiply'),
      (Unicode: $266a; Name: 'musicalnote'),
      (Unicode: $266b; Name: 'musicalnotedbl'),
      (Unicode: $006e; Name: 'n'),
      (Unicode: $0144; Name: 'nacute'),
      (Unicode: $0149; Name: 'napostrophe'),
      (Unicode: $00a0; Name: 'nbspace'),
      (Unicode: $0148; Name: 'ncaron'),
      (Unicode: $0146; Name: 'ncommaaccent'),
      (Unicode: $0039; Name: 'nine'),
      (Unicode: $2089; Name: 'nineinferior'),
      (Unicode: $f739; Name: 'nineoldstyle'),
      (Unicode: $2079; Name: 'ninesuperior'),
      (Unicode: $00a0; Name: 'nonbreakingspace'),
      (Unicode: $2209; Name: 'notelement'),
      (Unicode: $2260; Name: 'notequal'),
      (Unicode: $2284; Name: 'notsubset'),
      (Unicode: $207f; Name: 'nsuperior'),
      (Unicode: $00f1; Name: 'ntilde'),
      (Unicode: $03bd; Name: 'nu'),
      (Unicode: $0023; Name: 'numbersign'),
      (Unicode: $006f; Name: 'o'),
      (Unicode: $00f3; Name: 'oacute'),
      (Unicode: $014f; Name: 'obreve'),
      (Unicode: $00f4; Name: 'ocircumflex'),
      (Unicode: $00f6; Name: 'odieresis'),
      (Unicode: $0153; Name: 'oe'),
      (Unicode: $02db; Name: 'ogonek'),
      (Unicode: $00f2; Name: 'ograve'),
      (Unicode: $01a1; Name: 'ohorn'),
      (Unicode: $0151; Name: 'ohungarumlaut'),
      (Unicode: $014d; Name: 'omacron'),
      (Unicode: $03c9; Name: 'omega'),
      (Unicode: $03d6; Name: 'omega1'),
      (Unicode: $03ce; Name: 'omegatonos'),
      (Unicode: $03bf; Name: 'omicron'),
      (Unicode: $03cc; Name: 'omicrontonos'),
      (Unicode: $0031; Name: 'one'),
      (Unicode: $2024; Name: 'onedotenleader'),
      (Unicode: $215b; Name: 'oneeighth'),
      (Unicode: $f6dc; Name: 'onefitted'),
      (Unicode: $00bd; Name: 'onehalf'),
      (Unicode: $2081; Name: 'oneinferior'),
      (Unicode: $f731; Name: 'oneoldstyle'),
      (Unicode: $00bc; Name: 'onequarter'),
      (Unicode: $00b9; Name: 'onesuperior'),
      (Unicode: $2153; Name: 'onethird'),
      (Unicode: $25e6; Name: 'openbullet'),
      (Unicode: $00aa; Name: 'ordfeminine'),
      (Unicode: $00ba; Name: 'ordmasculine'),
      (Unicode: $221f; Name: 'orthogonal'),
      (Unicode: $00f8; Name: 'oslash'),
      (Unicode: $01ff; Name: 'oslashacute'),
      (Unicode: $f6f0; Name: 'osuperior'),
      (Unicode: $00f5; Name: 'otilde'),
      (Unicode: $0070; Name: 'p'),
      (Unicode: $00b6; Name: 'paragraph'),
      (Unicode: $0028; Name: 'parenleft'),
      (Unicode: $f8ed; Name: 'parenleftbt'),
      (Unicode: $f8ec; Name: 'parenleftex'),
      (Unicode: $208d; Name: 'parenleftinferior'),
      (Unicode: $207d; Name: 'parenleftsuperior'),
      (Unicode: $f8eb; Name: 'parenlefttp'),
      (Unicode: $0029; Name: 'parenright'),
      (Unicode: $f8f8; Name: 'parenrightbt'),
      (Unicode: $f8f7; Name: 'parenrightex'),
      (Unicode: $208e; Name: 'parenrightinferior'),
      (Unicode: $207e; Name: 'parenrightsuperior'),
      (Unicode: $f8f6; Name: 'parenrighttp'),
      (Unicode: $2202; Name: 'partialdiff'),
      (Unicode: $0025; Name: 'percent'),
      (Unicode: $002e; Name: 'period'),
      (Unicode: $00b7; Name: 'periodcentered'),
      (Unicode: $f6e7; Name: 'periodinferior'),
      (Unicode: $f6e8; Name: 'periodsuperior'),
      (Unicode: $22a5; Name: 'perpendicular'),
      (Unicode: $2030; Name: 'perthousand'),
      (Unicode: $20a7; Name: 'peseta'),
      (Unicode: $03c6; Name: 'phi'),
      (Unicode: $03d5; Name: 'phi1'),
      (Unicode: $03c0; Name: 'pi'),
      (Unicode: $002b; Name: 'plus'),
      (Unicode: $00b1; Name: 'plusminus'),
      (Unicode: $211e; Name: 'prescription'),
      (Unicode: $220f; Name: 'product'),
      (Unicode: $2282; Name: 'propersubset'),
      (Unicode: $2283; Name: 'propersuperset'),
      (Unicode: $221d; Name: 'proportional'),
      (Unicode: $03c8; Name: 'psi'),
      (Unicode: $0071; Name: 'q'),
      (Unicode: $003f; Name: 'question'),
      (Unicode: $00bf; Name: 'questiondown'),
      (Unicode: $f7bf; Name: 'questiondownsmall'),
      (Unicode: $f73f; Name: 'questionsmall'),
      (Unicode: $0022; Name: 'quotedbl'),
      (Unicode: $201e; Name: 'quotedblbase'),
      (Unicode: $201c; Name: 'quotedblleft'),
      (Unicode: $201d; Name: 'quotedblright'),
      (Unicode: $2018; Name: 'quoteleft'),
      (Unicode: $201b; Name: 'quotereversed'),
      (Unicode: $2019; Name: 'quoteright'),
      (Unicode: $201a; Name: 'quotesinglbase'),
      (Unicode: $0027; Name: 'quotesingle'),
      (Unicode: $0072; Name: 'r'),
      (Unicode: $0155; Name: 'racute'),
      (Unicode: $221a; Name: 'radical'),
      (Unicode: $f8e5; Name: 'radicalex'),
      (Unicode: $0159; Name: 'rcaron'),
      (Unicode: $0157; Name: 'rcommaaccent'),
      (Unicode: $2286; Name: 'reflexsubset'),
      (Unicode: $2287; Name: 'reflexsuperset'),
      (Unicode: $00ae; Name: 'registered'),
      (Unicode: $00ae; Name: 'registersans'),
      (Unicode: $00ae; Name: 'registerserif'),
      (Unicode: $2310; Name: 'revlogicalnot'),
      (Unicode: $03c1; Name: 'rho'),
      (Unicode: $02da; Name: 'ring'),
      (Unicode: $f6f1; Name: 'rsuperior'),
      (Unicode: $2590; Name: 'rtblock'),
      (Unicode: $f6dd; Name: 'rupiah'),
      (Unicode: $0073; Name: 's'),
      (Unicode: $015b; Name: 'sacute'),
      (Unicode: $0161; Name: 'scaron'),
      (Unicode: $015f; Name: 'scedilla'),
      (Unicode: $015d; Name: 'scircumflex'),
      (Unicode: $0219; Name: 'scommaaccent'),
      (Unicode: $2033; Name: 'second'),
      (Unicode: $00a7; Name: 'section'),
      (Unicode: $003b; Name: 'semicolon'),
      (Unicode: $0037; Name: 'seven'),
      (Unicode: $215e; Name: 'seveneighths'),
      (Unicode: $2087; Name: 'seveninferior'),
      (Unicode: $f737; Name: 'sevenoldstyle'),
      (Unicode: $2077; Name: 'sevensuperior'),
      (Unicode: $2592; Name: 'shade'),
      (Unicode: $03c3; Name: 'sigma'),
      (Unicode: $03c2; Name: 'sigma1'),
      (Unicode: $223c; Name: 'similar'),
      (Unicode: $0036; Name: 'six'),
      (Unicode: $2086; Name: 'sixinferior'),
      (Unicode: $f736; Name: 'sixoldstyle'),
      (Unicode: $2076; Name: 'sixsuperior'),
      (Unicode: $002f; Name: 'slash'),
      (Unicode: $263a; Name: 'smileface'),
      (Unicode: $0020; Name: 'space'),
      (Unicode: $2660; Name: 'spade'),
      (Unicode: $f6f2; Name: 'ssuperior'),
      (Unicode: $00a3; Name: 'sterling'),
      (Unicode: $220b; Name: 'suchthat'),
      (Unicode: $2211; Name: 'summation'),
      (Unicode: $263c; Name: 'sun'),
      (Unicode: $0074; Name: 't'),
      (Unicode: $03c4; Name: 'tau'),
      (Unicode: $0167; Name: 'tbar'),
      (Unicode: $0165; Name: 'tcaron'),
      (Unicode: $0163; Name: 'tcommaaccent'),
      (Unicode: $2234; Name: 'therefore'),
      (Unicode: $03b8; Name: 'theta'),
      (Unicode: $03d1; Name: 'theta1'),
      (Unicode: $00fe; Name: 'thorn'),
      (Unicode: $0033; Name: 'three'),
      (Unicode: $215c; Name: 'threeeighths'),
      (Unicode: $2083; Name: 'threeinferior'),
      (Unicode: $f733; Name: 'threeoldstyle'),
      (Unicode: $00be; Name: 'threequarters'),
      (Unicode: $f6de; Name: 'threequartersemdash'),
      (Unicode: $00b3; Name: 'threesuperior'),
      (Unicode: $02dc; Name: 'tilde'),
      (Unicode: $0303; Name: 'tildecomb'),
      (Unicode: $0384; Name: 'tonos'),
      (Unicode: $2122; Name: 'trademark'),
      (Unicode: $2122; Name: 'trademarksans'),
      (Unicode: $2122; Name: 'trademarkserif'),
      (Unicode: $25bc; Name: 'triagdn'),
      (Unicode: $25c4; Name: 'triaglf'),
      (Unicode: $25ba; Name: 'triagrt'),
      (Unicode: $25b2; Name: 'triagup'),
      (Unicode: $f6f3; Name: 'tsuperior'),
      (Unicode: $0032; Name: 'two'),
      (Unicode: $2025; Name: 'twodotenleader'),
      (Unicode: $2082; Name: 'twoinferior'),
      (Unicode: $f732; Name: 'twooldstyle'),
      (Unicode: $00b2; Name: 'twosuperior'),
      (Unicode: $2154; Name: 'twothirds'),
      (Unicode: $0075; Name: 'u'),
      (Unicode: $00fa; Name: 'uacute'),
      (Unicode: $016d; Name: 'ubreve'),
      (Unicode: $00fb; Name: 'ucircumflex'),
      (Unicode: $00fc; Name: 'udieresis'),
      (Unicode: $00f9; Name: 'ugrave'),
      (Unicode: $01b0; Name: 'uhorn'),
      (Unicode: $0171; Name: 'uhungarumlaut'),
      (Unicode: $016b; Name: 'umacron'),
      (Unicode: $005f; Name: 'underscore'),
      (Unicode: $2017; Name: 'underscoredbl'),
      (Unicode: $222a; Name: 'union'),
      (Unicode: $2200; Name: 'universal'),
      (Unicode: $0173; Name: 'uogonek'),
      (Unicode: $2580; Name: 'upblock'),
      (Unicode: $03c5; Name: 'upsilon'),
      (Unicode: $03cb; Name: 'upsilondieresis'),
      (Unicode: $03b0; Name: 'upsilondieresistonos'),
      (Unicode: $03cd; Name: 'upsilontonos'),
      (Unicode: $016f; Name: 'uring'),
      (Unicode: $0169; Name: 'utilde'),
      (Unicode: $0076; Name: 'v'),
      (Unicode: $0077; Name: 'w'),
      (Unicode: $1e83; Name: 'wacute'),
      (Unicode: $0175; Name: 'wcircumflex'),
      (Unicode: $1e85; Name: 'wdieresis'),
      (Unicode: $2118; Name: 'weierstrass'),
      (Unicode: $1e81; Name: 'wgrave'),
      (Unicode: $0078; Name: 'x'),
      (Unicode: $03be; Name: 'xi'),
      (Unicode: $0079; Name: 'y'),
      (Unicode: $00fd; Name: 'yacute'),
      (Unicode: $0177; Name: 'ycircumflex'),
      (Unicode: $00ff; Name: 'ydieresis'),
      (Unicode: $00a5; Name: 'yen'),
      (Unicode: $1ef3; Name: 'ygrave'),
      (Unicode: $007a; Name: 'z'),
      (Unicode: $017a; Name: 'zacute'),
      (Unicode: $017e; Name: 'zcaron'),
      (Unicode: $017c; Name: 'zdotaccent'),
      (Unicode: $0030; Name: 'zero'),
      (Unicode: $2080; Name: 'zeroinferior'),
      (Unicode: $f730; Name: 'zerooldstyle'),
      (Unicode: $2070; Name: 'zerosuperior'),
      (Unicode: $03b6; Name: 'zeta'),
      (Unicode: $007b; Name: '{'),
      (Unicode: $007c; Name: '|'),
      (Unicode: $007d; Name: '}'),
      (Unicode: $007e; Name: '~'),
      (Unicode: $0000; Name: '')
    );

const
  MAXUNICODESTRING = 8;
  
type
  TgtCCToUnicodeString = record
    FC: TgtCharCode;
    FUnicode: array [0..MAXUNICODESTRING - 1] of TgtUnicode;
    FLength: Integer;
  end;

  TgtPDCCToUnicode = class(TgtObject)
  private
    FSMap: array of TgtCCToUnicodeString;
    FMapLen: TgtCharCode;
    FMap: TgtUnicodes;
    FSMapLen, FSMapSize, FRefCount: Integer;
    FTag: AnsiString;
    procedure AddMapping(ACode: TgtCharCode; AString: AnsiString; ANum, AOffset: Integer);

  public
    class function ParseCMap(Stream: TStream): TgtPDCCToUnicode;
    class function Make8BitToUnicode(ToUnicode: TgtUnicodeArray): TgtPDCCToUnicode;

    procedure MergeCMap(Stream: TStream);
    function MapToUnicode(Code: TgtCharCode; Unicodes: TgtUnicodes;
      Size: Integer): Integer;
    procedure SetMapping(Code: TgtCharCode; Unicodes: TgtUnicodes; Size: Integer);

    constructor Create(ATag: AnsiString); overload;
    constructor Create(ATag: AnsiString; AUnicodes: TgtUnicodes; AMapLen: TgtCharCode;
      ACopyMap: Boolean; SMapA: TgtCCToUnicodeString; SMapLenA, sMapSizeA: Integer); overload;
    destructor Destroy; override;

    function IsName(const TagName: AnsiString): Boolean;

    property Length: TgtCharCode read FMapLen;
  end;

var
  E: Exception;

implementation

{ TgtPDCCToUnicode }

constructor TgtPDCCToUnicode.Create(ATag: AnsiString);
var
  I: TgtCharCode;
begin
(*
  FTag := ATag;
  FMapLen := 256;
  SetLength(FMap, FMapLen);
  for I := 0 to FMapLen - 1 do
    FMap[I] := 0;
  FSMap := nil;
  FSMapLen := 0;
  FSMapSize := 0;
  FRefCount := 0;
*)  
end;

procedure TgtPDCCToUnicode.AddMapping(ACode: TgtCharCode; AString: AnsiString; ANum,
  AOffset: Integer);
var
  LOldLen, I, J: TgtCharCode;
  LUnicode: TgtUniCode;
  LUHex, LString: AnsiString;
  LChar: PAnsiChar;
begin
(*

  if ACode >= FMapLen then
  begin
    LOldLen := FMapLen;
    FMapLen := (ACode + 256) and (not 255);
    SetLength(FMap, FMapLen);
    for I := LOldLen to FMapLen - 1 do
    begin
      FMap[I] := 0;
    end;
  end;

  if ANum <= 4 then
  begin
//    J := 0;
    LString := '';
    for I := 0 to (System.Length(AString) - 1) do   // simulate minimal sscanf(only 1 format spec)
    begin
      if ((StrToInt(AString[I]) = SPACE) or (StrToInt(AString[I]) = TABSPACE) or
        (StrToInt(AString[I]) = LINEFEED)) then
        Continue
      else
        LString := LString + AString[I];
    end;
    LUnicode := IntToHex(StrToInt(LString), 4);
//    if J > 1 then
//    begin
//      raise E.Create('Illegal entry in ToUnicode CMap');
//      Exit;
//    end;
    FMap[ACode] := LUnicode + AOffset;
  end
  else
  begin
    if FSMapLen >= FSMapSize then
    begin
      Inc(FSMapSize, 16);
      SetLength(FSMap, FSMapSize);
      FMap[ACode] := 0;
      FSMap[FSMapLen].FC := ACode;
      FSMap[FSMapLen].FLength := ANum div 4;
      J := 0;
      LChar := PAnsiChar(AString);
      while((J < FSMap[FSMapLen].FLength) and ( J < MAXUNICODESTRING)) do
      begin
        Inc(LChar, J * 4);
        StrLCopy(PAnsiChar(LUHex), LChar, 4);
        LString := '';
        for I := 0 to Length(AString) - 1 do   // simulate minimal sscanf(only 1 format spec)
        begin
          if ((StrToInt(LUHex[I]) = SPACE) or (StrToInt(LUHex[I]) = TABSPACE) or
            (StrToInt(LUHex[I]) = LINEFEED)) then
            Continue
          else
            LString := LString + LUHex[I];
        end;
        FSMap[FSMapLen].FUnicode[J] := IntToHex(StrToInt(LString), 4);
        Inc(J);
      end;
      FSMap[FMapLen].FUnicode[FSMap[FMapLen].FLength - 1] :=
        FSMap[FMapLen].FUnicode[FSMap[FMapLen].FLength - 1] + 1;
      Inc(FSMapLen);
    end;
  end;
*)
end;

constructor TgtPDCCToUnicode.Create(ATag: AnsiString; AUnicodes: TgtUnicodes;
  AMapLen: TgtCharCode; ACopyMap: Boolean; SMapA: TgtCCToUnicodeString; SMapLenA,
  sMapSizeA: Integer);
var
  I: Integer;
begin
//  FTag := ATag;
//  FMapLen := AMapLen;
//  if ACopyMap then
//  begin
//    SetLength(FMap, FMapLen);
//    for I := 0 to FMapLen - 1 do
//      FMap[I] := AUnicodes[I];
//  end
//  else
//    FMap := AUnicodes;
//
//  FSMap := SMapA;
//  FSMapLen := SMapLenA;
//  FRefCount := 1;
end;

destructor TgtPDCCToUnicode.Destroy;
begin

  inherited;
end;

function TgtPDCCToUnicode.IsName(const TagName: AnsiString): Boolean;
begin

end;

class function TgtPDCCToUnicode.Make8BitToUnicode(
  ToUnicode: TgtUnicodeArray): TgtPDCCToUnicode;
begin
//  Result := TgtPDCCToUnicode.Create('', ToUnicode, 256, True, nil, 0, 0);
end;

function TgtPDCCToUnicode.MapToUnicode(Code: TgtCharCode;
  Unicodes: TgtUnicodes; Size: Integer): Integer;
var
  I, J: Integer;
begin
//  if Code >= FMapLen then
//  begin
//    Result := 0;
//    Exit;
//  end;
//  if FMap[Code] <> 0 then
//  begin
//    Unicodes[0] := FMap[Code];
//    Result := 1;
//    Exit;
//  end;
//
//  for I := 0 to FSMapLen - 1 do
//  begin
//    if FSMap[I].FC = Code then
//    begin
//      J := 0;
//      while((J < FSMap[I].FLength) and (J < Size)) do
//      begin
//        Unicodes[J] := FSMap[I].FUnicode[J];
//        Inc(J);
//      end;
//      Result := j;
//      Exit;
//    end;
//  end;
//  Result := 0;
end;

procedure TgtPDCCToUnicode.MergeCMap(Stream: TStream);
begin

end;

class function TgtPDCCToUnicode.ParseCMap(Stream: TStream): TgtPDCCToUnicode;
begin

end;

procedure TgtPDCCToUnicode.SetMapping(Code: TgtCharCode; Unicodes: TgtUnicodes;
  Size: Integer);
var
  I, J: Integer;
begin
(*
  if Size = 1 then
    FMap[Code] := Unicodes[0]
  else
  begin
    for I := 0 to FSMapLen - 1 do
    begin
      if FSMap[I].FC = Code then
        Break;
    end;
  end;

  if I = FSMapLen then
  begin
    if FSMapLen = FSMapSize then
    begin
      Inc(FSMapSize, 8);
      SetLength(FSMap, FSMapSize);
    end;
    Inc(FSMapLen);
  end;

  FMap[Code] := 0;
  FSMap[I].FC := Code;
  FSMap[I].FLength := Size;

  J := 0;
  while((J < Size) and (J < MAXUNICODESTRING)) do
  begin
    FSMap[I].FUnicode[J] := Unicodes[J];
    Inc(J);
  end;
*)  
end;

end.
