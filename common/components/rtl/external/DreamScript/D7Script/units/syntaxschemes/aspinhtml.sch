object TPersHolder
  P.Name = 'ASP in HTML'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 14
      BlockDelimiters = <>
    end
    item
      Name = 'ASP (VBS)'
      ID = 1
      ParentID = 0
      FIText = 0
      FIIntNum = 1
      FIFloatNum = 2
      FIHexNum = 3
      FISymbol = 24
      UseSymbols = True
      UseComments = True
      UseSingleLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseKeywords = True
      BlockDelimiters = <
        item
          LeftDelimiter = '<%'
          RightDelimiter = '%>'
          DelimitersArePartOfBlock = True
        end>
      SingleLineCommentDelimiters = <
        item
          FontID = 4
          LeftDelimiter = #39
        end
        item
          FontID = 5
          LeftDelimiter = 'rem'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 6
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      KeywordSets = <
        item
          FontID = 7
          Name = 'reserved'
          Keywords = 
            'And,As,Attribute,Base,ByVal,Call,Case,Compare,Const,Date,Declare' +
            ',Dim,Do,Each,Else,Elseif,Empty,end,Error,Exit,Explicit,False,For' +
            ',friend,Function,get,If,Is,let,Loop,Mod,Next,Not,Nothing,Null,On' +
            ',Option,Or,Private,property,Public,ReDim,Rem,Select,Set,String,S' +
            'ub,Then,To,True,Type,Wend,While,With,Xor'
        end>
    end
    item
      Name = 'HTML'
      ID = 2
      ParentID = 0
      FIText = 15
      FIIntNum = 16
      FIFloatNum = 17
      FIHexNum = 18
      UseComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UsePrefixedNumbers = True
      UseSuffixedNumbers = True
      UseMultipleNumSuffixes = False
      UsePrefixedIdentifiers = True
      BlockDelimiters = <
        item
          LeftDelimiter = '<'
          RightDelimiter = '>'
          DelimitersArePartOfBlock = True
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 19
          LeftDelimiter = '<!--'
          RightDelimiter = '-->'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 20
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end
        item
          FontID = 21
          LeftDelimiter = #39
          RightDelimiter = #39
        end>
      NumPrefixes = <
        item
          LeftDelimiter = '#'
        end>
      NumSuffixes = <
        item
          LeftDelimiter = '%'
        end>
      IdentPrefixes = <
        item
          LeftDelimiter = '/'
        end>
    end
    item
      Name = 'ASP (VBS)'
      ID = 3
      ParentID = 2
      FIText = 8
      FIIntNum = 9
      FIFloatNum = 10
      FIHexNum = 11
      FISymbol = 25
      UseSymbols = True
      UseComments = True
      UseSingleLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseKeywords = True
      BlockDelimiters = <
        item
          LeftDelimiter = '<%'
          RightDelimiter = '%>'
          DelimitersArePartOfBlock = True
        end>
      SingleLineCommentDelimiters = <
        item
          FontID = 26
          LeftDelimiter = #39
        end
        item
          FontID = 13
          LeftDelimiter = 'rem'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 22
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      KeywordSets = <
        item
          FontID = 23
          Name = 'reserved'
          Keywords = 
            'And,As,Attribute,Base,ByVal,Call,Case,Compare,Const,Date,Declare' +
            ',Dim,Do,Each,Else,Elseif,Empty,end,Error,Exit,Explicit,False,For' +
            ',friend,Function,get,If,Is,let,Loop,Mod,Next,Not,Nothing,Null,On' +
            ',Option,Or,Private,property,Public,ReDim,Rem,Select,Set,String,S' +
            'ub,Then,To,True,Type,Wend,While,With,Xor'
        end>
    end>
  P.FontTable = <
    item
      FontID = 0
      GlobalAttrID = 'Script Whitespace'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 1
      GlobalAttrID = 'Script Number'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 2
      GlobalAttrID = 'Script Number'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 3
      GlobalAttrID = 'Script Number'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 4
      GlobalAttrID = 'Script Comment'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 5
      GlobalAttrID = 'Script Comment'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 6
      GlobalAttrID = 'Script String'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 7
      GlobalAttrID = 'Script ResWord'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 14
      GlobalAttrID = 'Whitespace'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 15
      GlobalAttrID = 'Html tags'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 16
      GlobalAttrID = 'Integer'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 17
      GlobalAttrID = 'Float'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 18
      GlobalAttrID = 'Integer'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 19
      GlobalAttrID = 'Comment'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 20
      GlobalAttrID = 'String'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 21
      GlobalAttrID = 'String'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 8
      GlobalAttrID = 'Script Whitespace'
      BlockID = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 9
      GlobalAttrID = 'Script Number'
      BlockID = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 10
      GlobalAttrID = 'Script Number'
      BlockID = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 11
      GlobalAttrID = 'Script Number'
      BlockID = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 26
      GlobalAttrID = 'Script Comment'
      BlockID = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 13
      GlobalAttrID = 'Script Comment'
      BlockID = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 22
      GlobalAttrID = 'Script String'
      BlockID = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 23
      GlobalAttrID = 'Script ResWord'
      BlockID = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 24
      GlobalAttrID = 'Script Delimiters'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 25
      GlobalAttrID = 'Script Delimiters'
      BlockID = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
