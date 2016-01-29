object TPersHolder
  P.Name = 'AWK Script'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
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
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
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
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      KeywordSets = <
        item
          FontID = 6
          Name = 'Statements'
          Keywords = 
            'BEGIN,break,continue,do,else,END,exit,for,function,if,in,pattern' +
            ',return,while'
        end
        item
          FontID = 7
          Name = 'Built-in Variables'
          Keywords = 
            'ARGC,ARGIND,ARGV,CONVFMT,ENVIRON,ERRNO,FIELDWIDTHS,FILENAME,FNR,' +
            'FS,IGNORECASE,NF,NR,OFMT,OFS,ORS,RLENGTH,RS,RSTART,RT,SUBSEP'
        end
        item
          FontID = 8
          Name = 'Internal Functions'
          Keywords = 
            'atan2,close,cos,exp,fflush,gensub,getline,gsub,index,int,length,' +
            'log,match,next,nextfile,print,printf,rand,sin,split,sprintf,sqrt' +
            ',srand,strftime,sub,substr,system,systime,tolower,toupper'
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
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 7
      GlobalAttrID = 'System Variable'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 8
      GlobalAttrID = 'System Variable'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
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
