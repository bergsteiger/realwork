object TPersHolder
  P.Name = 'C'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      CaseSensitive = True
      UseMetaSymbol = True
      UseMetaToWrapLines = True
      MetaSymbol = '\'
      FIText = 0
      FIIntNum = 1
      FIFloatNum = 2
      FIHexNum = 3
      FIDirective = 4
      FISymbol = 11
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
      UseMultipleNumSuffixes = True
      UsePrefixedSuffixedNumbers = True
      UsePSNumComposition = True
      UseKeywords = True
      BlockDelimiters = <>
      LineDirectivePrefix = '#'
      SingleLineCommentDelimiters = <
        item
          FontID = 5
          LeftDelimiter = '//'
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 6
          LeftDelimiter = '/*'
          RightDelimiter = '*/'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 7
          LeftDelimiter = #39
          RightDelimiter = #39
        end
        item
          FontID = 8
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end
        item
          FontID = 9
          LeftDelimiter = 'L"'
          RightDelimiter = '"'
        end>
      NumPrefixes = <
        item
          LeftDelimiter = '0x'
        end
        item
          LeftDelimiter = '0X'
        end>
      NumSuffixes = <
        item
          LeftDelimiter = 'l'
        end
        item
          LeftDelimiter = 'L'
        end
        item
          LeftDelimiter = 'u'
        end
        item
          LeftDelimiter = 'U'
        end>
      NumPrefixesSuffixes = <>
      KeywordSets = <
        item
          FontID = 10
          Name = 'reserved'
          Keywords = 
            'auto,break,case,cdecl,char,const,continue,default,do,double,else' +
            ',enum,extern,far,float,for,fortran,goto,huge,if,int,interrupt,lo' +
            'ng,near,pascal,register,return,short,signed,sizeof,static,struct' +
            ',switch,typedef,union,unsigned,void,volatile,while'
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
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
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
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 9
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 10
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 11
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
