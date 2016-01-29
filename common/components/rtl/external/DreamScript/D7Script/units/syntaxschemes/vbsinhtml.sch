object TPersHolder
  P.Name = 'VBScript in HTML'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 14
      BlockDelimiters = <>
    end
    item
      Name = 'VBS'
      ID = 1
      ParentID = 0
      FIText = 0
      FIIntNum = 1
      FIFloatNum = 2
      FIHexNum = 3
      FISymbol = 8
      UseSymbols = True
      UseComments = True
      UseSingleLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseKeywords = True
      BlockDelimiters = <
        item
          LeftDelimiter = '<script language="vbscript">'
          RightDelimiter = '</script>'
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
      FIText = 34
      FIIntNum = 35
      FIFloatNum = 36
      FIHexNum = 37
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
          FontID = 38
          LeftDelimiter = '<!--'
          RightDelimiter = '-->'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 39
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end
        item
          FontID = 40
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
      FontID = 34
      GlobalAttrID = 'Html tags'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 35
      GlobalAttrID = 'Integer'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 36
      GlobalAttrID = 'Float'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 37
      GlobalAttrID = 'Integer'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 38
      GlobalAttrID = 'Comment'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 39
      GlobalAttrID = 'String'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 40
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
      GlobalAttrID = 'Script Delimiters'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
