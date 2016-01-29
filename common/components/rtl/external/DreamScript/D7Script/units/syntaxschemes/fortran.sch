object TPersHolder
  P.Name = 'Fortran'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 0
      FIIntNum = 1
      FIFloatNum = 2
      FIHexNum = 3
      FIDirective = 4
      FISymbol = 13
      UseSymbols = True
      UseLineDirectives = True
      UseComments = True
      UseSingleLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UsePrefixedNumbers = True
      UsePrefixedSuffixedIdentifiers = True
      UseKeywords = True
      BlockDelimiters = <>
      LineDirectivePrefix = '$'
      SingleLineCommentDelimiters = <
        item
          FontID = 5
          LeftDelimiter = '!'
        end
        item
          FontID = 6
          LeftDelimiter = 'c'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 7
          LeftDelimiter = #39
          RightDelimiter = #39
        end
        item
          FontID = 8
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      NumPrefixes = <
        item
          LeftDelimiter = '#'
        end>
      IdentPrefixesSuffixes = <
        item
          LeftDelimiter = '.'
          RightDelimiter = '.'
        end>
      KeywordSets = <
        item
          FontID = 9
          Name = 'statements'
          Keywords = 
            'ALIAS,ALLOCATE,ASSIGN,AUTOMATIC,BACKSPACE,BLOCK,BYTE,C,CALL,CASE' +
            ',CHARACTER,CLOSE,COMMON,COMPLEX,CONTINUE,CYCLE,DATA,DEALLOCATE,D' +
            'IMENSION,DO,DOUBLE,ELSE,END,ENDFILE,ENTRY,EQUIVALENCE,EXIT,EXTER' +
            'NAL,FORMAT,FUNCTION,GOTO,IF,IMPLICIT,INCLUDE,INQUIRE,INTEGER,INT' +
            'RINSIC,LOCKING,LOGICAL,MAP,NAMELIST,OPEN,PARAMETER,PAUSE,PRECISI' +
            'ON,PRINT,PROGRAM,READ,REAL,RECORD,REFERENCE,RETURN,REWIND,SAVE,S' +
            'ELECT,STDCALL,STOP,STRUCTURE,SUBROUTINE,TO,UNION,VALUE,VARYING,W' +
            'HILE,WRITE'
        end
        item
          FontID = 10
          Name = 'directives'
          Keywords = 
            'ALIAS,ATTRIBUTES,DECLARE,DEFINE,DEFINED,ELSE,ELSEIF,ENDIF,FIXEDF' +
            'ORMLINESIZE,FREEFORM,IDENT,IF,INTEGER,MESSAGE,NODECLARE,NOFREEFO' +
            'RM,NOSTRICT,OBJCOMMENT,OPTIONS,PACK,PSECT,REAL,STRICT,SUBTITLE,T' +
            'ITLE,UNDEFINE'
        end
        item
          FontID = 11
          Name = 'logical'
          Keywords = 
            '.AND.,.EQ.,.EQV.,.FALSE.,.GT.,.LT.,.NEQV.,.NOT.,.OR.,.TRUE.,.XOR' +
            '.'
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
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
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
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
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
