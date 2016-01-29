object TPersHolder
  P.Name = 'C#'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      CaseSensitive = True
      UseMetaSymbol = True
      UseMetaToWrapLines = False
      MetaSymbol = '\'
      FIText = 1
      FIIntNum = 4
      FIFloatNum = 5
      FIHexNum = 6
      FIDirective = 7
      FISymbol = 13
      UseSymbols = True
      UseLineDirectives = True
      UseComments = True
      UseSingleLineComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseMultiLineStrings = True
      UseNumbers = True
      UsePrefixedNumbers = True
      UseSuffixedNumbers = True
      UseMultipleNumSuffixes = True
      UsePrefixedSuffixedNumbers = True
      UsePSNumComposition = True
      UsePrefixedIdentifiers = True
      UseKeywords = True
      BlockDelimiters = <>
      LineDirectivePrefix = '#'
      SingleLineCommentDelimiters = <
        item
          FontID = 9
          LeftDelimiter = '//'
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 10
          LeftDelimiter = '/*'
          RightDelimiter = '*/'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 2
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end
        item
          FontID = 3
          LeftDelimiter = #39
          RightDelimiter = #39
        end>
      MultiLineStringDelimiters = <
        item
          FontID = 8
          LeftDelimiter = '@"'
          RightDelimiter = '"'
        end>
      NumPrefixes = <
        item
          LeftDelimiter = '0x'
        end
        item
          LeftDelimiter = '0X'
        end>
      NumSuffixes = <
        item
          LeftDelimiter = 'U'
        end
        item
          LeftDelimiter = 'u'
        end
        item
          LeftDelimiter = 'L'
        end
        item
          LeftDelimiter = 'l'
        end
        item
          LeftDelimiter = 'F'
        end
        item
          LeftDelimiter = 'f'
        end
        item
          LeftDelimiter = 'D'
        end
        item
          LeftDelimiter = 'd'
        end
        item
          LeftDelimiter = 'M'
        end
        item
          LeftDelimiter = 'm'
        end>
      NumPrefixesSuffixes = <>
      IdentPrefixes = <
        item
          LeftDelimiter = '@'
        end>
      KeywordSets = <
        item
          FontID = 11
          Name = 'reserved'
          Keywords = 
            'abstract,base,bool,break,byte,case,catch,char,checked,class,cons' +
            't,continue,decimal,default,delegate,do,double,else,enum,event,ex' +
            'plicit,extern,false,finally,fixed,float,for,foreach,goto,if,impl' +
            'icit,in,int,interface,internal,is,lock,long,namespace,new,null,o' +
            'bject,operator,out,override,params,private,protected,public,read' +
            'only,ref,return,sbyte,sealed,short,sizeof,static,string,struct,s' +
            'witch,this,throw,true,try,typeof,uint,ulong,unchecked,unsafe,ush' +
            'ort,using,virtual,void,while'
        end>
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
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 3
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 4
      GlobalAttrID = 'Integer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 5
      GlobalAttrID = 'Float'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 6
      GlobalAttrID = 'Integer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 7
      GlobalAttrID = 'Defines'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
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
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 10
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 11
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 13
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
