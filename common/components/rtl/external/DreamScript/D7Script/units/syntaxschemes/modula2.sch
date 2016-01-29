object TPersHolder
  P.Name = 'Modula-2'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      CaseSensitive = True
      FIText = 0
      FIIntNum = 1
      FIFloatNum = 2
      FIHexNum = 3
      FISymbol = 16
      UseSymbols = True
      UseComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseSuffixedNumbers = True
      UseMultipleNumSuffixes = False
      UseKeywords = True
      BlockDelimiters = <>
      MultiLineCommentDelimiters = <
        item
          FontID = 4
          LeftDelimiter = '(*'
          RightDelimiter = '*)'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 5
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      NumSuffixes = <
        item
          LeftDelimiter = 'X'
        end
        item
          LeftDelimiter = 'L'
        end>
      KeywordSets = <
        item
          FontID = 6
          Name = 'reserved'
          Keywords = 
            'ARRAY,ASM,BEGIN,BOOLEAN,BY,CARDINAL,CASE,CHAR,CLASS,CONST,DEFINI' +
            'TION,DESTROY,DIV,DO,ELSE,ELSIF,END,EXIT,EXPORT,FOR,FOREIGN,FROM,' +
            'IF,IMPLEMENTATION,IMPORT,INHERIT,INIT,INLINE,INTEGER,LONGCARD,LO' +
            'NGINT,LONGREAL,LOOP,MOD,MODULE,NIL,OF,POINTER,PROCEDURE,REAL,REC' +
            'ORD,REPEAT,RETURN,SET,THEN,TO,TYPE,UNTIL,VAR,WHILE,WITH'
        end>
    end
    item
      Name = 'Assembler'
      ID = 1
      ParentID = 0
      CaseSensitive = True
      FIText = 7
      FIIntNum = 8
      FIFloatNum = 9
      FIHexNum = 10
      UseComments = True
      UseMultiLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseSuffixedNumbers = True
      UseMultipleNumSuffixes = False
      UsePrefixedIdentifiers = True
      UseKeywords = True
      BlockDelimiters = <
        item
          LeftDelimiter = 'ASM'
          RightDelimiter = 'END'
        end>
      MultiLineCommentDelimiters = <
        item
          FontID = 11
          LeftDelimiter = '(*'
          RightDelimiter = '*)'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 17
          LeftDelimiter = '"'
          RightDelimiter = '"'
        end>
      NumSuffixes = <
        item
          LeftDelimiter = 'X'
        end
        item
          LeftDelimiter = 'L'
        end>
      IdentPrefixes = <
        item
          LeftDelimiter = '@'
        end>
      KeywordSets = <
        item
          FontID = 13
          Name = 'OpCodes'
          Keywords = 
            'AAA,AAD,AAM,AAS,ADC,ADD,AND,ARPL,BOUND,BSF,BSR,BSWAP,BT,BTC,BTR,' +
            'BTS,CALL,CBW,CDQ,CLC,CLD,CLI,CLTS,CMC,CMP,CMPS,CMPSB,CMPSD,CMPSW' +
            ',CMPXCHG,CWD,CWDE,DAA,DAS,DEC,DIV,ENTER,ESC,F2XM1,FABS,FADD,FADD' +
            'P,FBLD,FBSTP,FCHS,FCLEX,FCOM,FCOMP,FCOMPP,FCOS,FDECSTP,FDISI,FDI' +
            'V,FDIVP,FDIVR,FDIVRP,FENI,FFREE,FIADD,FICOM,FICOMP,FIDIV,FIDIVR,' +
            'FILD,FIMUL,FINCSTP,FINIT,FIST,FISTP,FISUB,FISUBR,FLD,FLD1,FLDCW,' +
            'FLDENV,FLDL2E,FLDL2T,FLDLG2,FLDLN2,FLDPI,FLDZ,FMUL,FMULP,FNCLEX,' +
            'FNDISI,FNENI,FNINIT,FNOP,FNSAVE,FNSTCW,FNSTENV,FNSTSW,FPATAN,FPR' +
            'EM,FPREM1,FPTAN,FRNDINT,FRSTOR,FSAVE,FSCALE,FSETPM,FSIN,FSINCOS,' +
            'FSQRT,FST,FSTCW,FSTENV,FSTP,FSTSW,FSUB,FSUBP,FSUBR,FSUBRP,FTST,F' +
            'UCOM,FUCOMP,FUCOMPP,FWAIT,FXAM,FXCH,FXTRACT,FYL2X,FYL2XP1,HLT,ID' +
            'IV,IMUL,IN,INC,INSB,INSD,INSW,INT,INTO,INVD,INVLPG,IRET,IRETD,JA' +
            ',JAE,JB,JBE,JC,JCXZ,JE,JECXZ,JG,JGE,JL,JLE,JMP,JNA,JNAE,JNB,JNBE' +
            ',JNC,JNE,JNG,JNGE,JNL,JNLE,JNO,JNP,JNS,JNZ,JO,JP,JPE,JPO,JS,JZ,L' +
            'AHF,LAR,LDS,LEA,LEAVE,LES,LFS,LGDT,LGS,LIDT,LLDT,LMSW,LOCK,LODS,' +
            'LODSB,LODSD,LODSW,LOOP,LOOPD,LOOPDE,LOOPDNE,LOOPDNZ,LOOPDZ,LOOPE' +
            ',LOOPNE,LOOPNZ,LOOPZ,LSL,LSS,LTR,MOV,MOVS,MOVSB,MOVSD,MOVSW,MOVS' +
            'X,MOVZX,MUL,NEG,NOP,NOT,OR,OUT,OUTSB,OUTSD,OUTSW,POP,POPA,POPAD,' +
            'POPF,POPFD,PUSH,PUSHA,PUSHAD,PUSHF,PUSHFD,RCL,RCR,REP,REPE,REPNE' +
            ',REPNZ,REPZ,RET,RETF,RETN,ROL,ROR,SAHF,SAL,SAR,SBB,SCAS,SCASB,SC' +
            'ASD,SCASW,SEGCS,SEGDS,SEGES,SEGFS,SEGGS,SEGSS,SETA,SETAE,SETB,SE' +
            'TBE,SETC,SETE,SETG,SETGE,SETL,SETLE,SETNA,SETNAE,SETNB,SETNBE,SE' +
            'TNC,SETNE,SETNG,SETNGE,SETNL,SETNLE,SETNO,SETNP,SETNS,SETNZ,SETO' +
            ',SETP,SETPE,SETPO,SETS,SETZ,SGDT,SHL,SHLD,SHR,SHRD,SIDT,SLDT,SMS' +
            'W,STC,STD,STI,STOS,STOSB,STOSD,STOSW,STR,SUB,TEST,VERR,VERW,WAIT' +
            ',WBINVD,XADD,XCHG,XLAT,XOR'
        end
        item
          FontID = 14
          Name = 'Operands'
          Keywords = 
            'AH,AL,AND,AX,BH,BL,BP,BX,BYTE,CH,CL,CS,CX,DH,DI,DL,DS,DWORD,DX,E' +
            'AX,EBP,EBX,ECX,EDI,EDX,EIP,ES,ESI,ESP,FS,GS,HIGH,LOW,MOD,NOT,OFF' +
            'SET,OR,PTR,QWORD,SHL,SHR,SI,SP,SS,ST,TBYTE,TYPE,WORD,XOR'
        end
        item
          FontID = 15
          Name = 'Directives'
          Keywords = 'DB,DD,DW'
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
      GlobalAttrID = 'Reserved words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 7
      GlobalAttrID = 'Assembler'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 8
      GlobalAttrID = 'Assembler'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 9
      GlobalAttrID = 'Assembler'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 10
      GlobalAttrID = 'Assembler'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 11
      GlobalAttrID = 'Comment'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 17
      GlobalAttrID = 'String'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 13
      GlobalAttrID = 'Assembler'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 14
      GlobalAttrID = 'Assembler'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
    end
    item
      FontID = 15
      GlobalAttrID = 'Assembler'
      BlockID = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    item
      FontID = 16
      GlobalAttrID = 'Delimiters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end>
  P.SyntaxVersion = 3
end
