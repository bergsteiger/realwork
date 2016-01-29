object TPersHolder
  P.Name = 'Oberon'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      CaseSensitive = True
      FIText = 0
      FIIntNum = 3
      FIFloatNum = 4
      FIHexNum = 5
      FISymbol = 7
      UseSymbols = True
      UseComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseSuffixedNumbers = True
      UseMultipleNumSuffixes = False
      UseKeywords = True
      BlockDelimiters = <>
      MultiLineCommentDelimiters = <
        item
          FontID = 1
          LeftDelimiter = '(*'
          RightDelimiter = '*)'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 2
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      NumSuffixes = <
        item
          LeftDelimiter = 'H'
        end
        item
          LeftDelimiter = 'X'
        end>
      KeywordSets = <
        item
          FontID = 6
          Name = 'reserved'
          Keywords = 
            'ARRAY,BEGIN,CASE,CONST,DIV,DO,ELSE,ELSIF,END,EXIT,IF,IMPORT,IN,I' +
            'S,LOOP,MOD,MODULE,NIL,OF,OR,POINTER,PROCEDURE,RECORD,REPEAT,RETU' +
            'RN,THEN,TO,TYPE,UNTIL,VAR,WHILE,WITH'
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
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 2
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
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
      GlobalAttrID = 'Float'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 5
      GlobalAttrID = 'Integer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
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
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
