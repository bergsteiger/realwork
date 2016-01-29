object TPersHolder
  P.Name = 'Visual Basic'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIText = 0
      FIIntNum = 1
      FIFloatNum = 2
      FIHexNum = 3
      FIDirective = 4
      FISymbol = 9
      UseSymbols = True
      UseLineDirectives = True
      UseComments = True
      UseSingleLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseSuffixedIdentifiers = True
      UseKeywords = True
      BlockDelimiters = <>
      LineDirectivePrefix = '#'
      SingleLineCommentDelimiters = <
        item
          FontID = 5
          LeftDelimiter = #39
        end
        item
          FontID = 6
          LeftDelimiter = 'rem'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 7
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      IdentSuffixes = <
        item
          LeftDelimiter = '$'
        end>
      KeywordSets = <
        item
          FontID = 8
          Name = 'reserved'
          Keywords = 
            'addressof,and,appactivate,as,base,beep,binary,byref,byval,call,c' +
            'ase,chdir,chdrive,close,compare,const,date,declare,deftype,delet' +
            'esetting,dim,do,each,else,empty,end,enum,eqv,erase,error,event,e' +
            'xit,explicit,false,filecopy,for,friend,function,get,gosub,goto,i' +
            'f,imp,implements,input,is,kill,len,let,like,line,load,lock,loop,' +
            'lset,me,mid,mkdir,mod,name,new,next,not,nothing,null,on,open,opt' +
            'ion,optional,or,paramarray,print,private,property,public,put,rai' +
            'seevent,randomize,redim,rem,reset,resume,return,rmdir,rset,savep' +
            'icture,savesetting,seek,select,sendkeys,set,setattr,static,step,' +
            'stop,string,sub,then,time,to,true,type,unload,unlock,wend,while,' +
            'width,with,withevents,write,xor'
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
