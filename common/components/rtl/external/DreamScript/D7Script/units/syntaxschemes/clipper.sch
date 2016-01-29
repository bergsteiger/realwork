object TPersHolder
  P.Name = 'Clipper'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      UseMetaSymbol = True
      UseMetaToWrapLines = True
      MetaSymbol = ';'
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
      UseFullLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UsePrefixedSuffixedIdentifiers = True
      UseKeywords = True
      BlockDelimiters = <>
      LineDirectivePrefix = '#'
      SingleLineCommentDelimiters = <
        item
          FontID = 5
          LeftDelimiter = '//'
        end
        item
          FontID = 15
          LeftDelimiter = '&&'
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 6
          LeftDelimiter = '/*'
          RightDelimiter = '*/'
        end>
      FullLineCommentDelimiters = <
        item
          FontID = 7
          LeftDelimiter = '*'
        end
        item
          FontID = 16
          LeftDelimiter = 'note'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 8
          LeftDelimiter = #39
          RightDelimiter = #39
        end
        item
          FontID = 9
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      IdentPrefixesSuffixes = <
        item
          LeftDelimiter = '.'
          RightDelimiter = '.'
        end>
      KeywordSets = <
        item
          FontID = 14
          Name = 'reserved'
          Keywords = 
            '.and.,.f.,.not.,.or.,.t.,announce,begin,break,case,class,continu' +
            'e,declare,do,else,elseif,end,endcase,endclass,enddo,endif,endseq' +
            'uence,exit,exported,field,for,function,hidden,if,in,init,local,m' +
            'emvar,method,next,nil,note,otherwise,parameters,private,procedur' +
            'e,protected,public,recover,request,return,self,sequence,static,s' +
            'tep,then,to,using,var,while'
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
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
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
      FontID = 14
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 15
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 16
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
