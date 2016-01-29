object TPersHolder
  P.Name = 'SQL (Oracle)'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
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
      BlockDelimiters = <>
      SingleLineCommentDelimiters = <
        item
          FontID = 4
          LeftDelimiter = '--'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 5
          LeftDelimiter = #39
          RightDelimiter = #39
        end
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
            'ABORT,ACCEPT,ACCESS,ADD,ALL,ALTER,AND,ANY,ARRAY,AS,ASC,ASSERT,AS' +
            'SIGN,AT,AUDIT,AUTHORIZATION,AVG,BEGIN,BETWEEN,BODY,BOOLEAN,BY,CA' +
            'SE,CHAR,CHAR_BASE,CHECK,CLOSE,CLUSTER,CLUSTERS,COLAUTH,COLUMN,CO' +
            'LUMNS,COMMENT,COMMIT,COMPRESS,CONNECT,CONSTANT,COUNT,CRASH,CREAT' +
            'E,CURRENT,CURSOR,DATA_BASE,DATABASE,DATE,DBA,DEBUGOFF,DEBUGON,DE' +
            'CIMAL,DECLARE,DEFAULT,DEFINITION,DELAY,DELETE,DELTA,DESC,DIGITS,' +
            'DISPOSE,DISTINCT,DO,DROP,ELSE,ELSIF,END,ENTRY,EXCEPTION,EXCEPTIO' +
            'N_INIT,EXCLUSIVE,EXISTS,EXIT,FALSE,FETCH,FILE,FLOAT,FOR,FORM,FRO' +
            'M,FUNCTION,GENERIC,GOTO,GRANT,GROUP,HAVING,IDENTFIED,IDENTIFIED,' +
            'IF,IMMEDIATE,IN,INCREMENT,INDEX,INDEXES,INDICATOR,INITIAL,INSERT' +
            ',INTEGER,INTERSECT,INTO,IS,LEVEL,LIKE,LIMITED,LOCK,LONG,LOOP,MAX' +
            ',MAXEXTENTS,MIN,MINUS,MOD,MODE,MODIFY,NEW,NOAUDIT,NOCOMPRESS,NOT' +
            ',NOWAIT,NULL,NUMBER,NUMBER_BASE,OF,OFFLINE,ON,ONLINE,OPEN,OPTION' +
            ',OR,ORDER,OTHERS,OUT,PACKAGE,PARTITION,PCTFREE,PRAGMA,PRIOR,PRIV' +
            'ATE,PRIVILEGES,PROCEDURE,PUBLIC,RAISE,RANGE,RAW,RECORD,RELEASE,R' +
            'EM,RENAME,REPLACE,RESOURCE,RETURN,REVERSE,REVOKE,ROLLBACK,ROW,RO' +
            'WID,ROWLABEL,ROWNUM,ROWS,ROWTYPE,RUN,SAVEPOINT,SCHEMA,SELECT,SEP' +
            'ARATE,SESSION,SET,SHARE,SIZE,SMALLINT,SPACE,SQL,SQLCODE,SQLERRM,' +
            'START,STATEMENT,STDDEV,SUBTYPE,SUCCESSFUL,SUM,SYNONYM,SYSDATE,TA' +
            'BAUTH,TABLE,TABLES,TASK,TERMINATE,THEN,TO,TRIGGER,TRUE,TYPE,UID,' +
            'UNION,UNIQUE,UPDATE,USE,USER,VALIDATE,VALUES,VARCHAR,VARCHAR2,VA' +
            'RIANCE,VIEW,VIEWS,WHEN,WHENEVER,WHERE,WHILE,WITH,WORK,XOR'
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
      FontID = 8
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
