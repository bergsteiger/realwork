object TPersHolder
  P.Name = 'MS-DOS Batch Language'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 0
      FIIntNum = 1
      FIFloatNum = 2
      FIHexNum = 3
      FISymbol = 8
      UseSymbols = True
      UseComments = True
      UseSingleLineComments = True
      UseFullLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseKeywords = True
      BlockDelimiters = <>
      SingleLineCommentDelimiters = <
        item
          FontID = 4
          LeftDelimiter = 'rem'
        end>
      FullLineCommentDelimiters = <
        item
          FontID = 5
          LeftDelimiter = ':'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 7
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      KeywordSets = <
        item
          FontID = 6
          Name = 'commands'
          Keywords = 
            'call,do,echo,errorlevel,exist,for,goto,if,in,not,pause,rem,set,s' +
            'hift'
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
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 6
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
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
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
