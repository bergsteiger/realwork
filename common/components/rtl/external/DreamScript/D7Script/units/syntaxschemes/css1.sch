object TPersHolder
  P.Name = 'CSS, level 1'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 16
      FISymbol = 8
      UseSymbols = True
      UseComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      BlockDelimiters = <>
      MultiLineCommentDelimiters = <
        item
          FontID = 17
          LeftDelimiter = '/*'
          RightDelimiter = '*/'
        end
        item
          FontID = 11
          LeftDelimiter = '<!--'
          RightDelimiter = '-->'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 10
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
    end
    item
      Name = 'Style'
      ID = 1
      ParentID = 0
      UseMetaSymbol = True
      UseMetaToWrapLines = False
      MetaSymbol = '\'
      FIText = 0
      FIIntNum = 1
      FIFloatNum = 2
      FIHexNum = 3
      FISymbol = 9
      UseSymbols = True
      UseComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UsePrefixedNumbers = True
      UseSuffixedNumbers = True
      UseMultipleNumSuffixes = False
      UseKeywords = True
      BlockDelimiters = <
        item
          LeftDelimiter = '{'
          RightDelimiter = '}'
          DelimitersArePartOfBlock = True
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 4
          LeftDelimiter = '/*'
          RightDelimiter = '*/'
        end
        item
          FontID = 13
          LeftDelimiter = '<!--'
          RightDelimiter = '-->'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 5
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end
        item
          FontID = 6
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
        end
        item
          LeftDelimiter = 'em'
        end
        item
          LeftDelimiter = 'ex'
        end
        item
          LeftDelimiter = 'px'
        end
        item
          LeftDelimiter = 'in'
        end
        item
          LeftDelimiter = 'cm'
        end
        item
          LeftDelimiter = 'mm'
        end
        item
          LeftDelimiter = 'pt'
        end
        item
          LeftDelimiter = 'pc'
        end
        item
          LeftDelimiter = 'p'
        end>
      KeywordSets = <
        item
          FontID = 7
          Name = 'properties'
          Keywords = 
            'align,attachment,auto,background,border,bottom,clear,color,decor' +
            'ation,display,family,float,font,height,image,indent,left,letter,' +
            'line,list,margin,padding,position,repeat,right,size,space,spacin' +
            'g,style,text,through,top,transform,type,variant,vertical,weight,' +
            'white,width,word'
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
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 16
      GlobalAttrID = 'Emphasis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 17
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 10
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 11
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 13
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 8
      GlobalAttrID = 'Emphasis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 9
      GlobalAttrID = 'Delimiters'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
