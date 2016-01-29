object TPersHolder
  P.Name = 'Microsoft IDL'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      CaseSensitive = True
      FIText = 0
      FIIntNum = 1
      FIFloatNum = 2
      FIHexNum = 3
      FIDirective = 4
      FISymbol = 7
      UseSymbols = True
      UseLineDirectives = True
      UseComments = True
      UseSingleLineComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UsePrefixedNumbers = True
      UseKeywords = True
      BlockDelimiters = <>
      LineDirectivePrefix = '#'
      SingleLineCommentDelimiters = <
        item
          FontID = 5
          LeftDelimiter = '//'
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 6
          LeftDelimiter = '/*'
          RightDelimiter = '*/'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 8
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end
        item
          FontID = 9
          LeftDelimiter = 'uuid('
          RightDelimiter = ')'
        end
        item
          FontID = 9
          LeftDelimiter = 'uuid ('
          RightDelimiter = ')'
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
          FontID = 10
          Name = 'reserved'
          Keywords = 
            '__int3264,__int64,aggregatable,allocate,appobject,arrays,async,a' +
            'sync_uuid,auto_handle,bindable,boolean,broadcast,byte,byte_count' +
            ',call_as,callback,char,coclass,code,comm_status,const,context_ha' +
            'ndle,context_handle_noserialize,context_handle_serialize,control' +
            ',cpp_quote,custom,decode,default,defaultbind,defaultcollelem,def' +
            'aultvalue,defaultvtable,dispinterface,displaybind,dllname,double' +
            ',dual,enable_allocate,encode,endpoint,entry,enum,error_status_t,' +
            'explicit_handle,fault_status,first_is,float,handle,handle_t,heap' +
            ',helpcontext,helpfile,helpstring,helpstringcontext,helpstringdll' +
            ',hidden,hyper,id,idempotent,ignore,iid_is,immediatebind,implicit' +
            '_handle,import,importlib,in,in_line,include,int,interface,last_i' +
            's,lcid,length_is,library,licensed,local,long,max_is,maybe,messag' +
            'e,midl_pragma,midl_user_allocate,midl_user_free,min_is,module,ms' +
            '_union,ncacn_at_dsp,ncacn_dnet_nsp,ncacn_http,ncacn_ip_tcp,ncacn' +
            '_nb_ipx,ncacn_nb_nb,ncacn_nb_tcp,ncacn_np,ncacn_spx,ncacn_vns_sp' +
            'p,ncadg_ip_udp,ncadg_ipx,ncadg_mq,ncalrpc,nocode,nonbrowsable,no' +
            'ncreatable,nonextensible,notify,object,odl,oleautomation,optimiz' +
            'e,optional,out,out_of_line,pipe,pointer_default,propget,propput,' +
            'propputref,ptr,public,range,readonly,ref,represent_as,requestedi' +
            't,restricted,retval,shape,short,signed,size_is,small,source,stri' +
            'ct_context_handle,string,struct,switch,switch_is,switch_type,tra' +
            'nsmit_as,typedef,uidefault,union,unique,unsigned,user_marshal,us' +
            'esgetlasterror,uuid,v1_enum,vararg,version,void,warning,wchar_t,' +
            'wire_marshal'
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
      FontID = 8
      GlobalAttrID = 'String'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
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
      FontID = 9
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
