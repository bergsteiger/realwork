object TPersHolder
  P.Name = 'XML with Scripts'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 0
      BlockDelimiters = <>
    end
    item
      Name = 'CDATA'
      ID = 2
      ParentID = 0
      FIText = 8
      BlockDelimiters = <
        item
          LeftDelimiter = '<![CDATA['
          RightDelimiter = ']]>'
          DelimitersArePartOfBlock = True
        end>
    end
    item
      Name = 'Text'
      ID = 3
      ParentID = 2
      FIText = 11
      BlockDelimiters = <
        item
          LeftDelimiter = '<![CDATA['
          RightDelimiter = ']]>'
        end>
    end
    item
      Name = 'JS'
      ID = 6
      ParentID = 0
      CaseSensitive = True
      UseMetaSymbol = True
      UseMetaToWrapLines = True
      MetaSymbol = '\'
      FIText = 31
      FIIntNum = 32
      FIFloatNum = 33
      FIHexNum = 34
      FISymbol = 45
      UseSymbols = True
      UseComments = True
      UseSingleLineComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UsePrefixedNumbers = True
      UseKeywords = True
      BlockDelimiters = <
        item
          LeftDelimiter = '<script language="jscript">'
          RightDelimiter = '</script>'
        end
        item
          LeftDelimiter = '<script language="javascript">'
          RightDelimiter = '</script>'
        end>
      SingleLineCommentDelimiters = <
        item
          FontID = 36
          LeftDelimiter = '//'
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 37
          LeftDelimiter = '/*'
          RightDelimiter = '*/'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 38
          LeftDelimiter = #39
          RightDelimiter = #39
        end
        item
          FontID = 39
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
          FontID = 40
          Name = 'reserved'
          Keywords = 
            'break,case,catch,class,const,continue,debugger,default,delete,do' +
            ',else,enum,export,extends,false,finally,for,function,if,import,i' +
            'n,new,null,return,super,switch,this,throw,true,try,typeof,var,vo' +
            'id,while,with'
        end>
    end
    item
      Name = 'VBS'
      ID = 5
      ParentID = 0
      FIText = 23
      FIIntNum = 24
      FIFloatNum = 25
      FIHexNum = 26
      FISymbol = 44
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
        end
        item
          LeftDelimiter = '<%'
          RightDelimiter = '%>'
          DelimitersArePartOfBlock = True
        end>
      SingleLineCommentDelimiters = <
        item
          FontID = 27
          LeftDelimiter = #39
        end
        item
          FontID = 28
          LeftDelimiter = 'rem'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 29
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      KeywordSets = <
        item
          FontID = 30
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
      Name = 'PHP'
      ID = 4
      ParentID = 0
      CaseSensitive = True
      UseMetaSymbol = True
      UseMetaToWrapLines = True
      MetaSymbol = '\'
      FIText = 3
      FIIntNum = 13
      FIFloatNum = 14
      FIHexNum = 15
      FISymbol = 43
      UseSymbols = True
      UseComments = True
      UseSingleLineComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UsePrefixedNumbers = True
      UseKeywords = True
      BlockDelimiters = <
        item
          LeftDelimiter = '<?php'
          RightDelimiter = '?>'
          DelimitersArePartOfBlock = True
        end
        item
          LeftDelimiter = '<script language="php">'
          RightDelimiter = '</script>'
        end>
      SingleLineCommentDelimiters = <
        item
          FontID = 16
          LeftDelimiter = '//'
        end
        item
          FontID = 17
          LeftDelimiter = '#'
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 18
          LeftDelimiter = '/*'
          RightDelimiter = '*/'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 19
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end
        item
          FontID = 20
          LeftDelimiter = #39
          RightDelimiter = #39
        end
        item
          FontID = 21
          LeftDelimiter = '`'
          RightDelimiter = '`'
        end>
      NumPrefixes = <
        item
          LeftDelimiter = '0x'
        end>
      KeywordSets = <
        item
          FontID = 22
          Name = 'keywords'
          Keywords = 
            'break,case,class,continue,default,do,else,elseif,endfor,endif,en' +
            'dswitch,endwhile,extends,for,function,global,if,int,old_function' +
            ',pval,return,static,string,switch,var,void,while'
        end>
    end
    item
      Name = 'Tags'
      ID = 1
      ParentID = 0
      FIText = 1
      FIIntNum = 41
      FIFloatNum = 46
      FIHexNum = 47
      FIIdentifier = 7
      UseComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseKeywords = True
      BlockDelimiters = <
        item
          LeftDelimiter = '<'
          RightDelimiter = '>'
          DelimitersArePartOfBlock = True
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 5
          LeftDelimiter = '<!--'
          RightDelimiter = '-->'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 6
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      KeywordSets = <
        item
          FontID = 2
          Name = 'NameSpace'
          Keywords = 'ee,xsl,xwl'
        end
        item
          FontID = 10
          Name = 'Attributes'
          Keywords = 'source,target'
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
      GlobalAttrID = 'Html tags'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 5
      GlobalAttrID = 'Comment'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 6
      GlobalAttrID = 'String'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 7
      GlobalAttrID = 'Identifier'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 8
      GlobalAttrID = 'Html tags'
      BlockID = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 2
      GlobalAttrID = 'Reserved words'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 11
      GlobalAttrID = 'Html tags'
      BlockID = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      BackColor = clAqua
    end
    item
      FontID = 10
      GlobalAttrID = 'Emphasis'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clFuchsia
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 3
      GlobalAttrID = 'Script Whitespace'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 13
      GlobalAttrID = 'Script Number'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 14
      GlobalAttrID = 'Script Number'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 15
      GlobalAttrID = 'Script Number'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 16
      GlobalAttrID = 'Script Comment'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 17
      GlobalAttrID = 'Script Comment'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 18
      GlobalAttrID = 'Script Comment'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 19
      GlobalAttrID = 'Script String'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 20
      GlobalAttrID = 'Script String'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 21
      GlobalAttrID = 'Script String'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 22
      GlobalAttrID = 'Script ResWord'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 23
      GlobalAttrID = 'Script Whitespace'
      BlockID = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 24
      GlobalAttrID = 'Script Number'
      BlockID = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 25
      GlobalAttrID = 'Script Number'
      BlockID = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 26
      GlobalAttrID = 'Script Number'
      BlockID = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 27
      GlobalAttrID = 'Script Comment'
      BlockID = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 28
      GlobalAttrID = 'Script Comment'
      BlockID = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 29
      GlobalAttrID = 'Script String'
      BlockID = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 30
      GlobalAttrID = 'Script ResWord'
      BlockID = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 31
      GlobalAttrID = 'Script Whitespace'
      BlockID = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 32
      GlobalAttrID = 'Script Number'
      BlockID = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 33
      GlobalAttrID = 'Script Number'
      BlockID = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 34
      GlobalAttrID = 'Script Number'
      BlockID = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 36
      GlobalAttrID = 'Script Comment'
      BlockID = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 37
      GlobalAttrID = 'Script Comment'
      BlockID = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 38
      GlobalAttrID = 'Script String'
      BlockID = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 39
      GlobalAttrID = 'Script String'
      BlockID = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 40
      GlobalAttrID = 'Script ResWord'
      BlockID = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 41
      GlobalAttrID = 'Integer'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 43
      GlobalAttrID = 'Script Delimiters'
      BlockID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 44
      GlobalAttrID = 'Script Delimiters'
      BlockID = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 45
      GlobalAttrID = 'Script Delimiters'
      BlockID = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 46
      GlobalAttrID = 'Float'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 47
      GlobalAttrID = 'Integer'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
