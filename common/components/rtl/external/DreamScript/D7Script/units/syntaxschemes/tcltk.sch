object TPersHolder
  P.Name = 'Tcl/Tk'
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
      FISymbol = 7
      UseSymbols = True
      UseComments = True
      UseFullLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseSuffixedNumbers = True
      UseMultipleNumSuffixes = False
      UsePrefixedIdentifiers = True
      UseKeywords = True
      BlockDelimiters = <>
      FullLineCommentDelimiters = <
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
      NumSuffixes = <
        item
          LeftDelimiter = 'c'
        end
        item
          LeftDelimiter = 'i'
        end
        item
          LeftDelimiter = 'm'
        end>
      IdentPrefixes = <
        item
          LeftDelimiter = '$'
        end>
      KeywordSets = <
        item
          FontID = 6
          Name = 'commands'
          Keywords = 
            'AFTER,APPEND,ARRAY,BELL,BGERROR,BINARY,BIND,BINDIDPROC,BINDPROC,' +
            'BINDTAGS,BITMAP,BREAK,BUTTON,CANVAS,CATCH,CD,CHECKBUTTON,CLIPBOA' +
            'RD,CLOCK,CLOSE,CONCAT,CONTINUE,DESTROY,ELSE,ENTRY,EOF,ERROR,EVAL' +
            ',EVENT,EXEC,EXIT,EXPR,FBLOCKED,FCONFIGURE,FCOPY,FILE,FILEEVENT,F' +
            'ILENAME,FLUSH,FOCUS,FONT,FOR,FOREACH,FORMAT,FRAME,GETS,GLOB,GLOB' +
            'AL,GRAB,GRID,HISTORY,HTTP,IF,IMAGE,INCR,INFO,INTERP,JOIN,LABEL,L' +
            'APPEND,LIBRARY,LINDEX,LINSERT,LIST,LISTBOX,LLENGTH,LOAD,LOADTK,L' +
            'OWER,LRANGE,LREPLACE,LSEARCH,LSORT,MENU,MESSAGE,NAMESPACE,NAMESP' +
            'UPD,OPEN,OPTION,OPTIONS,PACK,PACKAGE,PHOTO,PID,PKG_MKINDEX,PLACE' +
            ',PROC,PUTS,PWD,RADIOBUTTON,RAISE,READ,REGEXP,REGISTRY,REGSUB,REN' +
            'AME,RESOURCE,RETURN,RGB,SAFEBASE,SCALE,SCAN,SEEK,SELECTION,SEND,' +
            'SENDOUT,SET,SOCKET,SOURCE,SPLIT,STRING,SUBST,SWITCH,TCL,TCLVARS,' +
            'TELL,TEXT,THEN,TIME,TK,TK_BISQUE,TK_CHOOSECOLOR,TK_DIALOG,TK_FOC' +
            'USFOLLOWSMOUSE,TK_FOCUSNEXT,TK_FOCUSPREV,TK_GETOPENFILE,TK_GETSA' +
            'VEFILE,TK_MESSAGEBOX,TK_OPTIONMENU,TK_POPUP,TK_SETPALETTE,TKERRO' +
            'R,TKVARS,TKWAIT,TOPLEVEL,TRACE,UNKNOWN,UNSET,UPDATE,UPLEVEL,UPVA' +
            'R,VARIABLE,VWAIT,WHILE,WINFO,WM'
        end>
      OtherIdentChars = '.0-9A-Z_a-z'
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
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
