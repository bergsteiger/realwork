object TPersHolder
  P.Name = 'INI files'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 0
      FISymbol = 4
      UseSymbols = True
      UseComments = True
      UseSingleLineComments = True
      UseFullLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      BlockDelimiters = <>
      SingleLineCommentDelimiters = <
        item
          FontID = 1
          LeftDelimiter = '='
        end>
      FullLineCommentDelimiters = <
        item
          FontID = 2
          LeftDelimiter = ';'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 3
          LeftDelimiter = '['
          RightDelimiter = ']'
        end>
    end>
  P.FontTable = <
    item
      FontID = 0
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 1
      GlobalAttrID = 'Whitespace'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 2
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 3
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 4
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
