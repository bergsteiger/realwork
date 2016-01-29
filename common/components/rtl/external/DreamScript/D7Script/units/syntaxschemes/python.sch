object TPersHolder
  P.Name = 'Python'
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
      FISymbol = 14
      UseSymbols = True
      UseComments = True
      UseSingleLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseMultiLineStrings = True
      UseNumbers = True
      UsePrefixedNumbers = True
      UseSuffixedNumbers = True
      UseMultipleNumSuffixes = False
      UsePrefixedSuffixedNumbers = True
      UsePSNumComposition = False
      UseKeywords = True
      BlockDelimiters = <>
      SingleLineCommentDelimiters = <
        item
          FontID = 4
          LeftDelimiter = '#'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 5
          LeftDelimiter = #39
          RightDelimiter = #39
        end
        item
          FontID = 6
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end
        item
          FontID = 7
          LeftDelimiter = 'r'#39
          RightDelimiter = #39
        end
        item
          FontID = 7
          LeftDelimiter = 'R'#39
          RightDelimiter = #39
        end
        item
          FontID = 8
          LeftDelimiter = 'r"'
          RightDelimiter = '"'
        end
        item
          FontID = 8
          LeftDelimiter = 'R"'
          RightDelimiter = '"'
        end>
      MultiLineStringDelimiters = <
        item
          FontID = 9
          LeftDelimiter = #39#39#39
          RightDelimiter = #39#39#39
        end
        item
          FontID = 10
          LeftDelimiter = '"""'
          RightDelimiter = '"""'
        end
        item
          FontID = 11
          LeftDelimiter = 'r'#39#39#39
          RightDelimiter = #39#39#39
        end
        item
          FontID = 11
          LeftDelimiter = 'R'#39#39#39
          RightDelimiter = #39#39#39
        end
        item
          FontID = 15
          LeftDelimiter = 'r"""'
          RightDelimiter = '"""'
        end
        item
          FontID = 15
          LeftDelimiter = 'R"""'
          RightDelimiter = '"""'
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
          LeftDelimiter = 'j'
        end
        item
          LeftDelimiter = 'J'
        end>
      NumPrefixesSuffixes = <
        item
          LeftDelimiter = '0x'
          RightDelimiter = 'l'
        end
        item
          LeftDelimiter = '0x'
          RightDelimiter = 'L'
        end
        item
          LeftDelimiter = '0X'
          RightDelimiter = 'l'
        end
        item
          LeftDelimiter = '0X'
          RightDelimiter = 'L'
        end>
      KeywordSets = <
        item
          FontID = 13
          Name = 'reserved'
          Keywords = 
            'and,assert,break,class,continue,def,del,elif,else,except,exec,fi' +
            'nally,for,from,global,if,import,in,is,lambda,not,or,pass,print,r' +
            'aise,return,try,while'
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
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 5
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
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
      Font.Style = [fsBold]
    end
    item
      FontID = 10
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 11
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 15
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 13
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 14
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
