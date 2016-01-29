object TPersHolder
  P.Name = 'PL/SQL'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 0
      FIIntNum = 5
      FIFloatNum = 6
      FIHexNum = 7
      FISymbol = 9
      UseSymbols = True
      UseComments = True
      UseSingleLineComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UsePrefixedIdentifiers = True
      UseKeywords = True
      BlockDelimiters = <>
      SingleLineCommentDelimiters = <
        item
          FontID = 1
          LeftDelimiter = '--'
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 2
          LeftDelimiter = '/*'
          RightDelimiter = '*/'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 3
          LeftDelimiter = #39
          RightDelimiter = #39
        end
        item
          FontID = 4
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      IdentPrefixes = <
        item
          LeftDelimiter = '%'
        end>
      KeywordSets = <
        item
          FontID = 8
          Name = 'reserved'
          Keywords = 
            'ABORT,ACCEPT,ACCESS,ADD,ALL,ALTER,AND,ANY,ARRAY,ARRAYLEN,AS,ASC,' +
            'ASSERT,ASSIGN,AT,AUTHORIZATION,AVG,BASE_TABLE,BEGIN,BETWEEN,BINA' +
            'RY_INTEGER,BODY,BOOLEAN,BY,CASE,CHAR,CHAR_BASE,CHECK,CLOSE,CLUST' +
            'ER,CLUSTERS,COLAUTH,COLUMNS,COMMIT,COMPRESS,CONNECT,CONSTANT,COU' +
            'NT,CRASH,CREATE,CURRENT,CURRVAL,CURSOR,DATA_BASE,DATABASE,DATE,D' +
            'BA,DEBUGOFF,DEBUGON,DECIMAL,DECLARE,DEFAULT,DEFINITION,DELAY,DEL' +
            'ETE,DELTA,DESC,DIGITS,DISPOSE,DISTINCT,DO,DROP,ELSE,ELSIF,END,EN' +
            'TRY,EXCEPTION,EXCEPTION_INIT,EXISTS,EXIT,FALSE,FETCH,FLOAT,FOR,F' +
            'ORM,FROM,FUNCTION,GENERIC,GOTO,GRANT,GROUP,HAVING,IDENTIFIED,IF,' +
            'IN,INDEX,INDEXES,INDICATOR,INSERT,INTEGER,INTERSECT,INTO,IS,LEVE' +
            'L,LIKE,LIMITED,LOOP,MAX,MIN,MINUS,MLSLABEL,MOD,NATURAL,NEW,NEXTV' +
            'AL,NOCOMPRESS,NOT,NULL,NUMBER,NUMBER_BASE,OF,ON,OPEN,OPTION,OR,O' +
            'RDER,OTHERS,OUT,PACKAGE,PARTITION,PCTFREE,POSITIVE,PRAGMA,PRIOR,' +
            'PRIVATE,PROCEDURE,PUBLIC,RAISE,RANGE,REAL,RECORD,RELEASE,REM,REN' +
            'AME,RESOURCE,RETURN,REVERSE,REVOKE,ROLLBACK,ROWID,ROWLABEL,ROWNU' +
            'M,ROWTYPE,RUN,SAVEPOINT,SCHEMA,SELECT,SEPARATE,SET,SIZE,SMALLINT' +
            ',SPACE,SQL,SQLCODE,SQLERRM,START,STATEMENT,STDDEV,SUBTYPE,SUM,TA' +
            'BAUTH,TABLE,TABLES,TASK,TERMINATE,THEN,TO,TRUE,TYPE,UNION,UNIQUE' +
            ',UPDATE,USE,VALUES,VARCHAR,VARCHAR2,VARIANCE,VIEW,VIEWS,WHEN,WHE' +
            'RE,WHILE,WITH,WORK,XOR'
        end>
      OtherIdentChars = '%0-9A-Z_a-z'
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
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 2
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
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
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 5
      GlobalAttrID = 'Integer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 6
      GlobalAttrID = 'Float'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
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
