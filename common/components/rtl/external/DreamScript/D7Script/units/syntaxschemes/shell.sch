object TPersHolder
  P.Name = 'Unix Shell'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      CaseSensitive = True
      UseMetaSymbol = True
      UseMetaToWrapLines = True
      MetaSymbol = '\'
      FIText = 1
      FIIntNum = 7
      FIFloatNum = 8
      FIHexNum = 9
      FISymbol = 2
      UseSymbols = True
      UseComments = True
      UseSingleLineComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UsePrefixedNumbers = True
      UsePrefixedIdentifiers = True
      UseKeywords = True
      BlockDelimiters = <>
      SingleLineCommentDelimiters = <
        item
          FontID = 3
          LeftDelimiter = '#'
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 11
          LeftDelimiter = '<<EOF'
          RightDelimiter = 'EOF'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 4
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end
        item
          FontID = 5
          LeftDelimiter = #39
          RightDelimiter = #39
        end
        item
          FontID = 6
          LeftDelimiter = '`'
          RightDelimiter = '`'
        end>
      NumPrefixes = <
        item
          LeftDelimiter = '0x'
        end
        item
          LeftDelimiter = '0X'
        end>
      IdentPrefixes = <
        item
          LeftDelimiter = '$'
        end>
      KeywordSets = <
        item
          FontID = 10
          Name = 'reserved'
          Keywords = 
            'alias,bg,bind,break,builtin,case,cd,command,continue,declare,dir' +
            's,disown,do,done,echo,elif,else,enable,esac,eval,exec,exit,expor' +
            't,fc,fg,fi,for,function,getopts,hash,help,history,if,in,jobs,kil' +
            'l,let,local,logout,popd,printf,pushd,pwd,read,readonly,return,se' +
            'lect,set,shift,shopt,suspend,test,then,time,times,trap,type,type' +
            'set,ulimit,umask,unalias,unset,until,wait,while'
        end>
      FirstIdentChars = '.-/A-Z_a-z~'
      OtherIdentChars = '.-9A-Z_a-z~'
    end>
  P.FontTable = <
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
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 3
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 4
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
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
      GlobalAttrID = 'Integer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 8
      GlobalAttrID = 'Float'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 9
      GlobalAttrID = 'Integer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 10
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 11
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
