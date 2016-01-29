object TPersHolder
  P.Name = 'Resource .RC Files'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 0
      FIIntNum = 1
      FIFloatNum = 2
      FIHexNum = 3
      FIDirective = 4
      FISymbol = 10
      UseSymbols = True
      UseLineDirectives = True
      UseComments = True
      UseSingleLineComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UsePrefixedNumbers = True
      UseSuffixedNumbers = True
      UseMultipleNumSuffixes = False
      UsePrefixedSuffixedNumbers = True
      UsePSNumComposition = True
      UseKeywords = True
      BlockDelimiters = <>
      LineDirectivePrefix = '#'
      SingleLineCommentDelimiters = <
        item
          FontID = 9
          LeftDelimiter = '//'
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 5
          LeftDelimiter = '/*'
          RightDelimiter = '*/'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 6
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end
        item
          FontID = 7
          LeftDelimiter = #39
          RightDelimiter = #39
        end>
      NumPrefixes = <
        item
          LeftDelimiter = '0x'
        end>
      NumSuffixes = <
        item
          LeftDelimiter = 'L'
        end>
      NumPrefixesSuffixes = <>
      KeywordSets = <
        item
          FontID = 8
          Name = 'reserved'
          Keywords = 
            'ACCELERATORS,ALT,ASCII,AUTO3STATE,AUTOCHECKBOX,AUTORADIOBUTTON,B' +
            'ITMAP,BLOCK,CAPTION,CHARACTERISTICS,CHECKBOX,CHECKED,CLASS,COMBO' +
            'BOX,CONTROL,CTEXT,CURSOR,DEFPUSHBUTTON,DIALOG,DIALOGEX,DISCARDAB' +
            'LE,DLGINIT,EDITTEXT,EXSTYLE,FILEFLAGS,FILEFLAGSMASK,FILEOS,FILES' +
            'UBTYPE,FILETYPE,FILEVERSION,FIXED,FONT,GRAYED,GROUPBOX,HELP,ICON' +
            ',IMPURE,INACTIVE,LANGUAGE,LISTBOX,LOADONCALL,LTEXT,MENU,MENUBARB' +
            'REAK,MENUBREAK,MENUEX,MENUITEM,MESSAGETABLE,MOVEABLE,NOINVERT,NO' +
            'NDISCARDABLE,NONSHARED,POPUP,PRELOAD,PRODUCTVERSION,PURE,PUSHBOX' +
            ',PUSHBUTTON,RADIOBUTTON,RCDATA,RTEXT,SCROLLBAR,SEPARATOR,SHARED,' +
            'SHIFT,STATE3,STRINGTABLE,STYLE,USERBUTTON,VALUE,VERSION,VERSIONI' +
            'NFO,VIRTKEY'
        end>
    end>
  P.FontTable = <
    item
      FontID = 0
      GlobalAttrID = 'Whitespace'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 1
      GlobalAttrID = 'Integer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 2
      GlobalAttrID = 'Float'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 3
      GlobalAttrID = 'Integer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 4
      GlobalAttrID = 'Defines'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 5
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 6
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 7
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 8
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 9
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 10
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
