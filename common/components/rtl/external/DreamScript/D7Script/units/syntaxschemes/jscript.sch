object TPersHolder
  P.Name = 'JavaScript'
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
      FISymbol = 9
      UseSymbols = True
      UseComments = True
      UseSingleLineComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UsePrefixedNumbers = True
      UseKeywords = True
      BlockDelimiters = <>
      SingleLineCommentDelimiters = <
        item
          FontID = 4
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
          LeftDelimiter = #39
          RightDelimiter = #39
        end
        item
          FontID = 7
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      NumPrefixes = <
        item
          LeftDelimiter = '0x'
        end
        item
          LeftDelimiter = '0X'
        end>
      KeywordSets = <
        item
          FontID = 8
          Name = 'reserved'
          Keywords = 
            'break,case,catch,class,const,continue,debugger,default,delete,do' +
            ',else,enum,export,extends,false,finally,for,function,if,import,i' +
            'n,new,null,return,super,switch,this,throw,true,try,typeof,var,vo' +
            'id,while,with'
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
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
