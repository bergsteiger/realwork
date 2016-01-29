object TPersHolder
  P.Name = 'FoxPro'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 0
      FIIntNum = 1
      FIFloatNum = 2
      FIHexNum = 3
      FIDirective = 4
      FISymbol = 14
      UseSymbols = True
      UseLineDirectives = True
      UseComments = True
      UseSingleLineComments = True
      UseFullLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseSuffixedNumbers = True
      UseMultipleNumSuffixes = False
      UsePrefixedSuffixedIdentifiers = True
      UseKeywords = True
      BlockDelimiters = <>
      LineDirectivePrefix = '#'
      SingleLineCommentDelimiters = <
        item
          FontID = 5
          LeftDelimiter = '&&'
        end>
      FullLineCommentDelimiters = <
        item
          FontID = 6
          LeftDelimiter = '*'
        end
        item
          FontID = 7
          LeftDelimiter = 'c'
        end
        item
          FontID = 8
          LeftDelimiter = '/'
        end
        item
          FontID = 9
          LeftDelimiter = '???'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 10
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end
        item
          FontID = 11
          LeftDelimiter = #39
          RightDelimiter = #39
        end>
      NumSuffixes = <
        item
          LeftDelimiter = 'f'
        end>
      IdentPrefixesSuffixes = <
        item
          LeftDelimiter = '.'
          RightDelimiter = '.'
        end>
      KeywordSets = <
        item
          FontID = 15
          Name = 'Commands'
          Keywords = 
            'ACCEPT,ACTIVATE,ADD,ALL,ALTER,ALTERNATE,ANSI,APLABOUT,APP,APPEND' +
            ',ARRAY,AS,ASSIST,AUTOSAVE,AVERAGE,BAR,BEGIN,BELL,BLANK,BLINK,BLO' +
            'CKSIZE,BORDER,BOX,BROWSE,BRSTATUS,BUILD,CALCULATE,CALL,CANCEL,CA' +
            'RRY,CASE,CD,CENTURY,CHANGE,CHDIR,CLASS,CLASSLIB,CLEAR,CLOCK,CLOS' +
            'E,COLLATE,COLOR,COMMAND,COMPATIBLE,COMPILE,CONFIRM,CONNECTION,CO' +
            'NNECTIONS,CONSOLE,CONTINUE,COPY,COUNT,CPCOMPILE,CPDIALOG,CREATE,' +
            'CURRENCY,CURSOR,DATA,DATABASE,DATABASES,DATASESSION,DATE,DEACTIV' +
            'ATE,DEBUG,DECIMALS,DECLARE,DEFAULT,DEFINE,DELETE,DELETED,DELIMIT' +
            'ERS,DEVELOPMENT,DEVICE,DIMENSION,DIR,DIRECTORY,DISPLAY,DLLS,DO,D' +
            'OHISTORY,ECHO,EDIT,EJECT,ELSE,END,ENDCASE,ENDDEFINE,ENDDO,ENDFOR' +
            ',ENDFUNC,ENDIF,ENDPRINTJOB,ENDPROC,ENDSCAN,ENDWITH,ERASE,ERROR,E' +
            'SCAPE,EVENTS,EXACT,EXCLUSIVE,EXE,EXIT,EXPORT,EXTENDED,EXTERNAL,F' +
            'DOW,FIELDS,FILE,FILER,FILES,FILTER,FIND,FIXED,FLUSH,FOR,FORM,FOR' +
            'MAT,FREE,FROM,FULLPATH,FUNCTION,FWEEK,GATHER,GENERAL,GET,GETEXPR' +
            ',GETS,GO,GOTO,HEADINGS,HELP,HELPFILTER,HIDE,HOURS,ID,IF,IMPORT,I' +
            'NDEX,INDEXES,INPUT,INSERT,INTENSITY,JOIN,KEY,KEYBOARD,KEYCOMP,LA' +
            'BEL,LIBRARY,LIST,LOAD,LOCAL,LOCATE,LOCK,LOGERRORS,LPARAMETERS,MA' +
            'CDESKTOP,MACHELP,MACKEY,MACRO,MACROS,MARGIN,MARK,MD,MEMO,MEMORY,' +
            'MEMOWIDTH,MENU,MENUS,MESSAGE,MKDIR,MODIFY,MODULE,MOUSE,MOVE,MULT' +
            'ILOCKS,NEAR,NOCPTRANS,NOTE,NOTIFY,NULL,OBJECT,OBJECTS,ODOMETER,O' +
            'F,OFF,OLEOBJECT,ON,OPEN,OPTIMIZE,or,ORDER,OTHERWISE,PACK,PAD,PAG' +
            'E,PALETTE,PARAMETERS,PATH,PDSETUP,PLAY,POINT,POP,POPUP,POPUPS,PR' +
            'INTER,PRINTJOB,PRIVATE,PROCEDURE,PROCEDURES,PROJECT,PUBLIC,PUSH,' +
            'QUERY,QUIT,RD,READ,READBORDER,READERROR,RECALL,REFRESH,REGIONAL,' +
            'REINDEX,RELATION,RELEASE,REMOVE,RENAME,REPLACE,REPORT,REPROCESS,' +
            'RESOURCE,RESTORE,RESUME,RETRY,RETURN,RMDIR,ROLLBACK,RUN,RUNSCRIP' +
            'T,s,SAFETY,SAVE,SCAN,SCATTER,SCHEME,SCOREBOARD,SCREEN,SCROLL,SEC' +
            'ONDS,SEEK,SELECT,SELECTION,SEPARATOR,SET,SHADOWS,SHOW,SHUTDOWN,S' +
            'IZE,SKIP,SORT,SPACE,SQL,STATUS,STEP,STICKY,STORE,string$,STRUCTU' +
            'RE,SUM,SUSPEND,SYSFORMATS,SYSMENU,TABLE,TABLES,TAG,TALK,TEXTMERG' +
            'E,TO,TOPIC,TOTAL,TRANSACTION,TRBETWEEN,TRIGGER,TYPE,TYPEAHEAD,UD' +
            'FPARMS,UNIQUE,UNLOCK,UPDATE,USE,VALIDATE,VIEW,VIEWS,VOLUME,WAIT,' +
            'WHILE,WINDOW,WINDOWS,WITH,XCMDFILE,ZAP,ZOOM'
        end
        item
          FontID = 13
          Name = 'Logical'
          Keywords = '.AND.,.F.,.N.,.NOT.,.NULL.,.OR.,.T.,.Y.'
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
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 9
      GlobalAttrID = 'Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
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
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 15
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 13
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 14
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
