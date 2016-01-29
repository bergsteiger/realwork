// $ANTLR 3.3 Nov 30, 2010 12:45:30 W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g 2011-08-08 22:14:59

	package dsparser.antlr.generated;


import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
public class DelphiScriptLexer extends Lexer {
    public static final int EOF=-1;
    public static final int FORMAL_PARAMETER=4;
    public static final int ACTUAL_PARAMETER=5;
    public static final int METHOD_DECL=6;
    public static final int METHOD_DEF=7;
    public static final int BLOCK=8;
    public static final int QUALIFIED_IDENT=9;
    public static final int METHOD_CALL=10;
    public static final int INDEX=11;
    public static final int QUALIFIED_ACCESS=12;
    public static final int IMPL_DECL=13;
    public static final int CASE_SELECTOR=14;
    public static final int CONST_ARRAY=15;
    public static final int FORWARD=16;
    public static final int SEMI=17;
    public static final int BEGIN=18;
    public static final int END=19;
    public static final int COLON=20;
    public static final int BREAK=21;
    public static final int RAISE=22;
    public static final int TRY=23;
    public static final int FINALLY=24;
    public static final int EXCEPT=25;
    public static final int WITH=26;
    public static final int DO=27;
    public static final int FOR=28;
    public static final int ASSIGN=29;
    public static final int TO=30;
    public static final int DOWNTO=31;
    public static final int WHILE=32;
    public static final int REPEAT=33;
    public static final int UNTIL=34;
    public static final int CASE=35;
    public static final int OF=36;
    public static final int ELSE=37;
    public static final int COMMA=38;
    public static final int IF=39;
    public static final int THEN=40;
    public static final int GOTO=41;
    public static final int VAR=42;
    public static final int LABEL=43;
    public static final int INT=44;
    public static final int USES=45;
    public static final int PLUS=46;
    public static final int MINUS=47;
    public static final int OR=48;
    public static final int XOR=49;
    public static final int STAR=50;
    public static final int SLASH=51;
    public static final int DIV=52;
    public static final int MOD=53;
    public static final int AND=54;
    public static final int SHL=55;
    public static final int SHR=56;
    public static final int DOT=57;
    public static final int LSQBR=58;
    public static final int RSQBR=59;
    public static final int LPAREN=60;
    public static final int RPAREN=61;
    public static final int STRING_LITERAL=62;
    public static final int NIL=63;
    public static final int FALSE=64;
    public static final int TRUE=65;
    public static final int RESULT=66;
    public static final int EXCEPTIONMESSAGE=67;
    public static final int FLOAT=68;
    public static final int HEX=69;
    public static final int NOT=70;
    public static final int ARRAY=71;
    public static final int STRING=72;
    public static final int CONST=73;
    public static final int EQUAL=74;
    public static final int PROCEDURE=75;
    public static final int FUNCTION=76;
    public static final int OUT=77;
    public static final int FILE=78;
    public static final int ID=79;
    public static final int NOT_EQUAL=80;
    public static final int LT=81;
    public static final int LE=82;
    public static final int GE=83;
    public static final int GT=84;
    public static final int IN=85;
    public static final int DOTDOT=86;
    public static final int D=87;
    public static final int I=88;
    public static final int V=89;
    public static final int M=90;
    public static final int O=91;
    public static final int A=92;
    public static final int N=93;
    public static final int R=94;
    public static final int X=95;
    public static final int S=96;
    public static final int H=97;
    public static final int L=98;
    public static final int T=99;
    public static final int Y=100;
    public static final int F=101;
    public static final int E=102;
    public static final int SET=103;
    public static final int B=104;
    public static final int G=105;
    public static final int P=106;
    public static final int C=107;
    public static final int U=108;
    public static final int W=109;
    public static final int UNIT=110;
    public static final int K=111;
    public static final int AT=112;
    public static final int AMPERSAND=113;
    public static final int POINTER=114;
    public static final int J=115;
    public static final int Q=116;
    public static final int Z=117;
    public static final int EXPONENT=118;
    public static final int RANGE_OR_INT=119;
    public static final int COMMENT=120;
    public static final int WS=121;
    public static final int CHAR_LITERAL=122;
    public static final int HEX_DIGIT=123;

    // delegates
    // delegators

    public DelphiScriptLexer() {;} 
    public DelphiScriptLexer(CharStream input) {
        this(input, new RecognizerSharedState());
    }
    public DelphiScriptLexer(CharStream input, RecognizerSharedState state) {
        super(input,state);

    }
    public String getGrammarFileName() { return "W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g"; }

    // $ANTLR start "DIV"
    public final void mDIV() throws RecognitionException {
        try {
            int _type = DIV;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:387:7: ( D I V )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:387:9: D I V
            {
            mD(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mV(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "DIV"

    // $ANTLR start "MOD"
    public final void mMOD() throws RecognitionException {
        try {
            int _type = MOD;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:388:7: ( M O D )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:388:9: M O D
            {
            mM(); if (state.failed) return ;
            mO(); if (state.failed) return ;
            mD(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "MOD"

    // $ANTLR start "AND"
    public final void mAND() throws RecognitionException {
        try {
            int _type = AND;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:389:7: ( A N D )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:389:9: A N D
            {
            mA(); if (state.failed) return ;
            mN(); if (state.failed) return ;
            mD(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "AND"

    // $ANTLR start "OR"
    public final void mOR() throws RecognitionException {
        try {
            int _type = OR;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:390:6: ( O R )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:390:8: O R
            {
            mO(); if (state.failed) return ;
            mR(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "OR"

    // $ANTLR start "XOR"
    public final void mXOR() throws RecognitionException {
        try {
            int _type = XOR;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:391:7: ( X O R )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:391:9: X O R
            {
            mX(); if (state.failed) return ;
            mO(); if (state.failed) return ;
            mR(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "XOR"

    // $ANTLR start "SHL"
    public final void mSHL() throws RecognitionException {
        try {
            int _type = SHL;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:392:7: ( S H L )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:392:9: S H L
            {
            mS(); if (state.failed) return ;
            mH(); if (state.failed) return ;
            mL(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "SHL"

    // $ANTLR start "SHR"
    public final void mSHR() throws RecognitionException {
        try {
            int _type = SHR;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:393:7: ( S H R )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:393:10: S H R
            {
            mS(); if (state.failed) return ;
            mH(); if (state.failed) return ;
            mR(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "SHR"

    // $ANTLR start "NOT"
    public final void mNOT() throws RecognitionException {
        try {
            int _type = NOT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:394:7: ( N O T )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:394:9: N O T
            {
            mN(); if (state.failed) return ;
            mO(); if (state.failed) return ;
            mT(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "NOT"

    // $ANTLR start "ARRAY"
    public final void mARRAY() throws RecognitionException {
        try {
            int _type = ARRAY;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:395:8: ( A R R A Y )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:395:10: A R R A Y
            {
            mA(); if (state.failed) return ;
            mR(); if (state.failed) return ;
            mR(); if (state.failed) return ;
            mA(); if (state.failed) return ;
            mY(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "ARRAY"

    // $ANTLR start "OF"
    public final void mOF() throws RecognitionException {
        try {
            int _type = OF;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:396:6: ( O F )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:396:9: O F
            {
            mO(); if (state.failed) return ;
            mF(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "OF"

    // $ANTLR start "IN"
    public final void mIN() throws RecognitionException {
        try {
            int _type = IN;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:397:6: ( I N )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:397:8: I N
            {
            mI(); if (state.failed) return ;
            mN(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "IN"

    // $ANTLR start "SET"
    public final void mSET() throws RecognitionException {
        try {
            int _type = SET;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:398:7: ( S E T )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:398:9: S E T
            {
            mS(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mT(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "SET"

    // $ANTLR start "FILE"
    public final void mFILE() throws RecognitionException {
        try {
            int _type = FILE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:399:7: ( F I L E )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:399:9: F I L E
            {
            mF(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mL(); if (state.failed) return ;
            mE(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "FILE"

    // $ANTLR start "FOR"
    public final void mFOR() throws RecognitionException {
        try {
            int _type = FOR;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:400:7: ( F O R )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:400:9: F O R
            {
            mF(); if (state.failed) return ;
            mO(); if (state.failed) return ;
            mR(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "FOR"

    // $ANTLR start "BEGIN"
    public final void mBEGIN() throws RecognitionException {
        try {
            int _type = BEGIN;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:401:8: ( B E G I N )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:401:10: B E G I N
            {
            mB(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mG(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mN(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "BEGIN"

    // $ANTLR start "END"
    public final void mEND() throws RecognitionException {
        try {
            int _type = END;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:402:7: ( E N D )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:402:9: E N D
            {
            mE(); if (state.failed) return ;
            mN(); if (state.failed) return ;
            mD(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "END"

    // $ANTLR start "VAR"
    public final void mVAR() throws RecognitionException {
        try {
            int _type = VAR;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:403:7: ( V A R )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:403:9: V A R
            {
            mV(); if (state.failed) return ;
            mA(); if (state.failed) return ;
            mR(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "VAR"

    // $ANTLR start "PROCEDURE"
    public final void mPROCEDURE() throws RecognitionException {
        try {
            int _type = PROCEDURE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:404:12: ( P R O C E D U R E )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:404:14: P R O C E D U R E
            {
            mP(); if (state.failed) return ;
            mR(); if (state.failed) return ;
            mO(); if (state.failed) return ;
            mC(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mD(); if (state.failed) return ;
            mU(); if (state.failed) return ;
            mR(); if (state.failed) return ;
            mE(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "PROCEDURE"

    // $ANTLR start "FUNCTION"
    public final void mFUNCTION() throws RecognitionException {
        try {
            int _type = FUNCTION;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:405:10: ( F U N C T I O N )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:405:12: F U N C T I O N
            {
            mF(); if (state.failed) return ;
            mU(); if (state.failed) return ;
            mN(); if (state.failed) return ;
            mC(); if (state.failed) return ;
            mT(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mO(); if (state.failed) return ;
            mN(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "FUNCTION"

    // $ANTLR start "CONST"
    public final void mCONST() throws RecognitionException {
        try {
            int _type = CONST;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:406:8: ( C O N S T )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:406:11: C O N S T
            {
            mC(); if (state.failed) return ;
            mO(); if (state.failed) return ;
            mN(); if (state.failed) return ;
            mS(); if (state.failed) return ;
            mT(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "CONST"

    // $ANTLR start "OUT"
    public final void mOUT() throws RecognitionException {
        try {
            int _type = OUT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:407:7: ( O U T )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:407:10: O U T
            {
            mO(); if (state.failed) return ;
            mU(); if (state.failed) return ;
            mT(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "OUT"

    // $ANTLR start "FORWARD"
    public final void mFORWARD() throws RecognitionException {
        try {
            int _type = FORWARD;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:408:10: ( F O R W A R D )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:408:12: F O R W A R D
            {
            mF(); if (state.failed) return ;
            mO(); if (state.failed) return ;
            mR(); if (state.failed) return ;
            mW(); if (state.failed) return ;
            mA(); if (state.failed) return ;
            mR(); if (state.failed) return ;
            mD(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "FORWARD"

    // $ANTLR start "STRING"
    public final void mSTRING() throws RecognitionException {
        try {
            int _type = STRING;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:409:9: ( S T R I N G )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:409:11: S T R I N G
            {
            mS(); if (state.failed) return ;
            mT(); if (state.failed) return ;
            mR(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mN(); if (state.failed) return ;
            mG(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "STRING"

    // $ANTLR start "NIL"
    public final void mNIL() throws RecognitionException {
        try {
            int _type = NIL;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:410:7: ( N I L )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:410:9: N I L
            {
            mN(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mL(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "NIL"

    // $ANTLR start "USES"
    public final void mUSES() throws RecognitionException {
        try {
            int _type = USES;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:411:9: ( U S E S )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:411:11: U S E S
            {
            mU(); if (state.failed) return ;
            mS(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mS(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "USES"

    // $ANTLR start "LABEL"
    public final void mLABEL() throws RecognitionException {
        try {
            int _type = LABEL;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:412:9: ( L A B E L )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:412:11: L A B E L
            {
            mL(); if (state.failed) return ;
            mA(); if (state.failed) return ;
            mB(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mL(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "LABEL"

    // $ANTLR start "GOTO"
    public final void mGOTO() throws RecognitionException {
        try {
            int _type = GOTO;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:413:7: ( G O T O )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:413:9: G O T O
            {
            mG(); if (state.failed) return ;
            mO(); if (state.failed) return ;
            mT(); if (state.failed) return ;
            mO(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "GOTO"

    // $ANTLR start "IF"
    public final void mIF() throws RecognitionException {
        try {
            int _type = IF;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:414:6: ( I F )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:414:8: I F
            {
            mI(); if (state.failed) return ;
            mF(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "IF"

    // $ANTLR start "THEN"
    public final void mTHEN() throws RecognitionException {
        try {
            int _type = THEN;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:415:8: ( T H E N )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:415:10: T H E N
            {
            mT(); if (state.failed) return ;
            mH(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mN(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "THEN"

    // $ANTLR start "ELSE"
    public final void mELSE() throws RecognitionException {
        try {
            int _type = ELSE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:416:7: ( E L S E )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:416:9: E L S E
            {
            mE(); if (state.failed) return ;
            mL(); if (state.failed) return ;
            mS(); if (state.failed) return ;
            mE(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "ELSE"

    // $ANTLR start "CASE"
    public final void mCASE() throws RecognitionException {
        try {
            int _type = CASE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:417:8: ( C A S E )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:417:10: C A S E
            {
            mC(); if (state.failed) return ;
            mA(); if (state.failed) return ;
            mS(); if (state.failed) return ;
            mE(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "CASE"

    // $ANTLR start "REPEAT"
    public final void mREPEAT() throws RecognitionException {
        try {
            int _type = REPEAT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:418:9: ( R E P E A T )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:418:11: R E P E A T
            {
            mR(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mP(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mA(); if (state.failed) return ;
            mT(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "REPEAT"

    // $ANTLR start "UNTIL"
    public final void mUNTIL() throws RecognitionException {
        try {
            int _type = UNTIL;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:419:8: ( U N T I L )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:419:10: U N T I L
            {
            mU(); if (state.failed) return ;
            mN(); if (state.failed) return ;
            mT(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mL(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "UNTIL"

    // $ANTLR start "WHILE"
    public final void mWHILE() throws RecognitionException {
        try {
            int _type = WHILE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:420:9: ( W H I L E )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:420:11: W H I L E
            {
            mW(); if (state.failed) return ;
            mH(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mL(); if (state.failed) return ;
            mE(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "WHILE"

    // $ANTLR start "DO"
    public final void mDO() throws RecognitionException {
        try {
            int _type = DO;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:421:6: ( D O )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:421:8: D O
            {
            mD(); if (state.failed) return ;
            mO(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "DO"

    // $ANTLR start "TO"
    public final void mTO() throws RecognitionException {
        try {
            int _type = TO;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:422:7: ( T O )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:422:9: T O
            {
            mT(); if (state.failed) return ;
            mO(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "TO"

    // $ANTLR start "DOWNTO"
    public final void mDOWNTO() throws RecognitionException {
        try {
            int _type = DOWNTO;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:423:9: ( D O W N T O )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:423:11: D O W N T O
            {
            mD(); if (state.failed) return ;
            mO(); if (state.failed) return ;
            mW(); if (state.failed) return ;
            mN(); if (state.failed) return ;
            mT(); if (state.failed) return ;
            mO(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "DOWNTO"

    // $ANTLR start "WITH"
    public final void mWITH() throws RecognitionException {
        try {
            int _type = WITH;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:424:7: ( W I T H )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:424:9: W I T H
            {
            mW(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mT(); if (state.failed) return ;
            mH(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "WITH"

    // $ANTLR start "TRY"
    public final void mTRY() throws RecognitionException {
        try {
            int _type = TRY;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:425:7: ( T R Y )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:425:9: T R Y
            {
            mT(); if (state.failed) return ;
            mR(); if (state.failed) return ;
            mY(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "TRY"

    // $ANTLR start "FINALLY"
    public final void mFINALLY() throws RecognitionException {
        try {
            int _type = FINALLY;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:426:10: ( F I N A L L Y )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:426:12: F I N A L L Y
            {
            mF(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mN(); if (state.failed) return ;
            mA(); if (state.failed) return ;
            mL(); if (state.failed) return ;
            mL(); if (state.failed) return ;
            mY(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "FINALLY"

    // $ANTLR start "EXCEPT"
    public final void mEXCEPT() throws RecognitionException {
        try {
            int _type = EXCEPT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:427:9: ( E X C E P T )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:427:11: E X C E P T
            {
            mE(); if (state.failed) return ;
            mX(); if (state.failed) return ;
            mC(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mP(); if (state.failed) return ;
            mT(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "EXCEPT"

    // $ANTLR start "RAISE"
    public final void mRAISE() throws RecognitionException {
        try {
            int _type = RAISE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:428:8: ( R A I S E )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:428:10: R A I S E
            {
            mR(); if (state.failed) return ;
            mA(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mS(); if (state.failed) return ;
            mE(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RAISE"

    // $ANTLR start "UNIT"
    public final void mUNIT() throws RecognitionException {
        try {
            int _type = UNIT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:429:7: ( U N I T )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:429:9: U N I T
            {
            mU(); if (state.failed) return ;
            mN(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mT(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "UNIT"

    // $ANTLR start "RESULT"
    public final void mRESULT() throws RecognitionException {
        try {
            int _type = RESULT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:430:9: ( R E S U L T )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:430:11: R E S U L T
            {
            mR(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mS(); if (state.failed) return ;
            mU(); if (state.failed) return ;
            mL(); if (state.failed) return ;
            mT(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RESULT"

    // $ANTLR start "EXCEPTIONMESSAGE"
    public final void mEXCEPTIONMESSAGE() throws RecognitionException {
        try {
            int _type = EXCEPTIONMESSAGE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:431:18: ( E X C E P T I O N M E S S A G E )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:431:20: E X C E P T I O N M E S S A G E
            {
            mE(); if (state.failed) return ;
            mX(); if (state.failed) return ;
            mC(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mP(); if (state.failed) return ;
            mT(); if (state.failed) return ;
            mI(); if (state.failed) return ;
            mO(); if (state.failed) return ;
            mN(); if (state.failed) return ;
            mM(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mS(); if (state.failed) return ;
            mS(); if (state.failed) return ;
            mA(); if (state.failed) return ;
            mG(); if (state.failed) return ;
            mE(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "EXCEPTIONMESSAGE"

    // $ANTLR start "FALSE"
    public final void mFALSE() throws RecognitionException {
        try {
            int _type = FALSE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:432:8: ( F A L S E )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:432:10: F A L S E
            {
            mF(); if (state.failed) return ;
            mA(); if (state.failed) return ;
            mL(); if (state.failed) return ;
            mS(); if (state.failed) return ;
            mE(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "FALSE"

    // $ANTLR start "TRUE"
    public final void mTRUE() throws RecognitionException {
        try {
            int _type = TRUE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:433:7: ( T R U E )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:433:9: T R U E
            {
            mT(); if (state.failed) return ;
            mR(); if (state.failed) return ;
            mU(); if (state.failed) return ;
            mE(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "TRUE"

    // $ANTLR start "BREAK"
    public final void mBREAK() throws RecognitionException {
        try {
            int _type = BREAK;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:434:8: ( B R E A K )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:434:10: B R E A K
            {
            mB(); if (state.failed) return ;
            mR(); if (state.failed) return ;
            mE(); if (state.failed) return ;
            mA(); if (state.failed) return ;
            mK(); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "BREAK"

    // $ANTLR start "PLUS"
    public final void mPLUS() throws RecognitionException {
        try {
            int _type = PLUS;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:438:7: ( '+' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:438:9: '+'
            {
            match('+'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "PLUS"

    // $ANTLR start "MINUS"
    public final void mMINUS() throws RecognitionException {
        try {
            int _type = MINUS;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:439:8: ( '-' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:439:10: '-'
            {
            match('-'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "MINUS"

    // $ANTLR start "STAR"
    public final void mSTAR() throws RecognitionException {
        try {
            int _type = STAR;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:440:7: ( '*' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:440:9: '*'
            {
            match('*'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "STAR"

    // $ANTLR start "SLASH"
    public final void mSLASH() throws RecognitionException {
        try {
            int _type = SLASH;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:441:8: ( '/' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:441:10: '/'
            {
            match('/'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "SLASH"

    // $ANTLR start "AT"
    public final void mAT() throws RecognitionException {
        try {
            int _type = AT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:442:6: ( '@' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:442:9: '@'
            {
            match('@'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "AT"

    // $ANTLR start "LSQBR"
    public final void mLSQBR() throws RecognitionException {
        try {
            int _type = LSQBR;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:443:10: ( '[' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:443:12: '['
            {
            match('['); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "LSQBR"

    // $ANTLR start "RSQBR"
    public final void mRSQBR() throws RecognitionException {
        try {
            int _type = RSQBR;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:444:8: ( ']' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:444:10: ']'
            {
            match(']'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RSQBR"

    // $ANTLR start "LPAREN"
    public final void mLPAREN() throws RecognitionException {
        try {
            int _type = LPAREN;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:445:9: ( '(' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:445:11: '('
            {
            match('('); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "LPAREN"

    // $ANTLR start "RPAREN"
    public final void mRPAREN() throws RecognitionException {
        try {
            int _type = RPAREN;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:446:9: ( ')' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:446:11: ')'
            {
            match(')'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RPAREN"

    // $ANTLR start "COMMA"
    public final void mCOMMA() throws RecognitionException {
        try {
            int _type = COMMA;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:447:8: ( ',' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:447:10: ','
            {
            match(','); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "COMMA"

    // $ANTLR start "SEMI"
    public final void mSEMI() throws RecognitionException {
        try {
            int _type = SEMI;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:448:7: ( ';' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:448:9: ';'
            {
            match(';'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "SEMI"

    // $ANTLR start "COLON"
    public final void mCOLON() throws RecognitionException {
        try {
            int _type = COLON;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:449:8: ( ':' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:449:10: ':'
            {
            match(':'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "COLON"

    // $ANTLR start "EQUAL"
    public final void mEQUAL() throws RecognitionException {
        try {
            int _type = EQUAL;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:450:8: ( '=' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:450:10: '='
            {
            match('='); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "EQUAL"

    // $ANTLR start "NOT_EQUAL"
    public final void mNOT_EQUAL() throws RecognitionException {
        try {
            int _type = NOT_EQUAL;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:451:11: ( '<>' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:451:13: '<>'
            {
            match("<>"); if (state.failed) return ;


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "NOT_EQUAL"

    // $ANTLR start "LT"
    public final void mLT() throws RecognitionException {
        try {
            int _type = LT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:452:6: ( '<' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:452:8: '<'
            {
            match('<'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "LT"

    // $ANTLR start "LE"
    public final void mLE() throws RecognitionException {
        try {
            int _type = LE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:453:6: ( '<=' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:453:8: '<='
            {
            match("<="); if (state.failed) return ;


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "LE"

    // $ANTLR start "GE"
    public final void mGE() throws RecognitionException {
        try {
            int _type = GE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:454:6: ( '>=' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:454:8: '>='
            {
            match(">="); if (state.failed) return ;


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "GE"

    // $ANTLR start "GT"
    public final void mGT() throws RecognitionException {
        try {
            int _type = GT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:455:6: ( '>' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:455:8: '>'
            {
            match('>'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "GT"

    // $ANTLR start "ASSIGN"
    public final void mASSIGN() throws RecognitionException {
        try {
            int _type = ASSIGN;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:456:9: ( ':=' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:456:11: ':='
            {
            match(":="); if (state.failed) return ;


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "ASSIGN"

    // $ANTLR start "AMPERSAND"
    public final void mAMPERSAND() throws RecognitionException {
        try {
            int _type = AMPERSAND;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:457:11: ( '&' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:457:13: '&'
            {
            match('&'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "AMPERSAND"

    // $ANTLR start "DOTDOT"
    public final void mDOTDOT() throws RecognitionException {
        try {
            int _type = DOTDOT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:458:9: ( '..' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:458:11: '..'
            {
            match(".."); if (state.failed) return ;


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "DOTDOT"

    // $ANTLR start "DOT"
    public final void mDOT() throws RecognitionException {
        try {
            int _type = DOT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:459:7: ( '.' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:459:9: '.'
            {
            match('.'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "DOT"

    // $ANTLR start "POINTER"
    public final void mPOINTER() throws RecognitionException {
        try {
            int _type = POINTER;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:460:10: ( '^' )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:460:12: '^'
            {
            match('^'); if (state.failed) return ;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "POINTER"

    // $ANTLR start "A"
    public final void mA() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:464:11: ( ( 'a' | 'A' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:464:12: ( 'a' | 'A' )
            {
            if ( input.LA(1)=='A'||input.LA(1)=='a' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "A"

    // $ANTLR start "B"
    public final void mB() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:465:11: ( ( 'b' | 'B' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:465:12: ( 'b' | 'B' )
            {
            if ( input.LA(1)=='B'||input.LA(1)=='b' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "B"

    // $ANTLR start "C"
    public final void mC() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:466:11: ( ( 'c' | 'C' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:466:12: ( 'c' | 'C' )
            {
            if ( input.LA(1)=='C'||input.LA(1)=='c' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "C"

    // $ANTLR start "D"
    public final void mD() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:467:11: ( ( 'd' | 'D' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:467:12: ( 'd' | 'D' )
            {
            if ( input.LA(1)=='D'||input.LA(1)=='d' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "D"

    // $ANTLR start "E"
    public final void mE() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:468:11: ( ( 'e' | 'E' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:468:12: ( 'e' | 'E' )
            {
            if ( input.LA(1)=='E'||input.LA(1)=='e' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "E"

    // $ANTLR start "F"
    public final void mF() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:469:11: ( ( 'f' | 'F' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:469:12: ( 'f' | 'F' )
            {
            if ( input.LA(1)=='F'||input.LA(1)=='f' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "F"

    // $ANTLR start "G"
    public final void mG() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:470:11: ( ( 'g' | 'G' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:470:12: ( 'g' | 'G' )
            {
            if ( input.LA(1)=='G'||input.LA(1)=='g' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "G"

    // $ANTLR start "H"
    public final void mH() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:471:11: ( ( 'h' | 'H' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:471:12: ( 'h' | 'H' )
            {
            if ( input.LA(1)=='H'||input.LA(1)=='h' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "H"

    // $ANTLR start "I"
    public final void mI() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:472:11: ( ( 'i' | 'I' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:472:12: ( 'i' | 'I' )
            {
            if ( input.LA(1)=='I'||input.LA(1)=='i' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "I"

    // $ANTLR start "J"
    public final void mJ() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:473:11: ( ( 'j' | 'J' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:473:12: ( 'j' | 'J' )
            {
            if ( input.LA(1)=='J'||input.LA(1)=='j' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "J"

    // $ANTLR start "K"
    public final void mK() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:474:11: ( ( 'k' | 'K' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:474:12: ( 'k' | 'K' )
            {
            if ( input.LA(1)=='K'||input.LA(1)=='k' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "K"

    // $ANTLR start "L"
    public final void mL() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:475:11: ( ( 'l' | 'L' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:475:12: ( 'l' | 'L' )
            {
            if ( input.LA(1)=='L'||input.LA(1)=='l' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "L"

    // $ANTLR start "M"
    public final void mM() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:476:11: ( ( 'm' | 'M' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:476:12: ( 'm' | 'M' )
            {
            if ( input.LA(1)=='M'||input.LA(1)=='m' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "M"

    // $ANTLR start "N"
    public final void mN() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:477:11: ( ( 'n' | 'N' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:477:12: ( 'n' | 'N' )
            {
            if ( input.LA(1)=='N'||input.LA(1)=='n' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "N"

    // $ANTLR start "O"
    public final void mO() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:478:11: ( ( 'o' | 'O' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:478:12: ( 'o' | 'O' )
            {
            if ( input.LA(1)=='O'||input.LA(1)=='o' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "O"

    // $ANTLR start "P"
    public final void mP() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:479:11: ( ( 'p' | 'P' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:479:12: ( 'p' | 'P' )
            {
            if ( input.LA(1)=='P'||input.LA(1)=='p' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "P"

    // $ANTLR start "Q"
    public final void mQ() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:480:11: ( ( 'q' | 'Q' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:480:12: ( 'q' | 'Q' )
            {
            if ( input.LA(1)=='Q'||input.LA(1)=='q' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "Q"

    // $ANTLR start "R"
    public final void mR() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:481:11: ( ( 'r' | 'R' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:481:12: ( 'r' | 'R' )
            {
            if ( input.LA(1)=='R'||input.LA(1)=='r' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "R"

    // $ANTLR start "S"
    public final void mS() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:482:11: ( ( 's' | 'S' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:482:12: ( 's' | 'S' )
            {
            if ( input.LA(1)=='S'||input.LA(1)=='s' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "S"

    // $ANTLR start "T"
    public final void mT() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:483:11: ( ( 't' | 'T' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:483:12: ( 't' | 'T' )
            {
            if ( input.LA(1)=='T'||input.LA(1)=='t' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "T"

    // $ANTLR start "U"
    public final void mU() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:484:11: ( ( 'u' | 'U' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:484:12: ( 'u' | 'U' )
            {
            if ( input.LA(1)=='U'||input.LA(1)=='u' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "U"

    // $ANTLR start "V"
    public final void mV() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:485:11: ( ( 'v' | 'V' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:485:12: ( 'v' | 'V' )
            {
            if ( input.LA(1)=='V'||input.LA(1)=='v' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "V"

    // $ANTLR start "W"
    public final void mW() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:486:11: ( ( 'w' | 'W' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:486:12: ( 'w' | 'W' )
            {
            if ( input.LA(1)=='W'||input.LA(1)=='w' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "W"

    // $ANTLR start "X"
    public final void mX() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:487:11: ( ( 'x' | 'X' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:487:12: ( 'x' | 'X' )
            {
            if ( input.LA(1)=='X'||input.LA(1)=='x' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "X"

    // $ANTLR start "Y"
    public final void mY() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:488:11: ( ( 'y' | 'Y' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:488:12: ( 'y' | 'Y' )
            {
            if ( input.LA(1)=='Y'||input.LA(1)=='y' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "Y"

    // $ANTLR start "Z"
    public final void mZ() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:489:11: ( ( 'z' | 'Z' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:489:12: ( 'z' | 'Z' )
            {
            if ( input.LA(1)=='Z'||input.LA(1)=='z' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "Z"

    // $ANTLR start "ID"
    public final void mID() throws RecognitionException {
        try {
            int _type = ID;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:495:2: ( ( 'a' .. 'z' | 'A' .. 'Z' | '_' ) ( 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' )* )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:495:4: ( 'a' .. 'z' | 'A' .. 'Z' | '_' ) ( 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' )*
            {
            if ( (input.LA(1)>='A' && input.LA(1)<='Z')||input.LA(1)=='_'||(input.LA(1)>='a' && input.LA(1)<='z') ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:495:28: ( 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' )*
            loop1:
            do {
                int alt1=2;
                int LA1_0 = input.LA(1);

                if ( ((LA1_0>='0' && LA1_0<='9')||(LA1_0>='A' && LA1_0<='Z')||LA1_0=='_'||(LA1_0>='a' && LA1_0<='z')) ) {
                    alt1=1;
                }


                switch (alt1) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:
            	    {
            	    if ( (input.LA(1)>='0' && input.LA(1)<='9')||(input.LA(1)>='A' && input.LA(1)<='Z')||input.LA(1)=='_'||(input.LA(1)>='a' && input.LA(1)<='z') ) {
            	        input.consume();
            	    state.failed=false;
            	    }
            	    else {
            	        if (state.backtracking>0) {state.failed=true; return ;}
            	        MismatchedSetException mse = new MismatchedSetException(null,input);
            	        recover(mse);
            	        throw mse;}


            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "ID"

    // $ANTLR start "INT"
    public final void mINT() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:500:2: ( ( '0' .. '9' )+ )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:500:4: ( '0' .. '9' )+
            {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:500:4: ( '0' .. '9' )+
            int cnt2=0;
            loop2:
            do {
                int alt2=2;
                int LA2_0 = input.LA(1);

                if ( ((LA2_0>='0' && LA2_0<='9')) ) {
                    alt2=1;
                }


                switch (alt2) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:500:5: '0' .. '9'
            	    {
            	    matchRange('0','9'); if (state.failed) return ;

            	    }
            	    break;

            	default :
            	    if ( cnt2 >= 1 ) break loop2;
            	    if (state.backtracking>0) {state.failed=true; return ;}
                        EarlyExitException eee =
                            new EarlyExitException(2, input);
                        throw eee;
                }
                cnt2++;
            } while (true);


            }

        }
        finally {
        }
    }
    // $ANTLR end "INT"

    // $ANTLR start "FLOAT"
    public final void mFLOAT() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:505:5: ( ( '0' .. '9' )+ DOT ( '0' .. '9' )+ ( EXPONENT )? | ( '0' .. '9' )+ EXPONENT )
            int alt7=2;
            alt7 = dfa7.predict(input);
            switch (alt7) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:505:9: ( '0' .. '9' )+ DOT ( '0' .. '9' )+ ( EXPONENT )?
                    {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:505:9: ( '0' .. '9' )+
                    int cnt3=0;
                    loop3:
                    do {
                        int alt3=2;
                        int LA3_0 = input.LA(1);

                        if ( ((LA3_0>='0' && LA3_0<='9')) ) {
                            alt3=1;
                        }


                        switch (alt3) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:505:10: '0' .. '9'
                    	    {
                    	    matchRange('0','9'); if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt3 >= 1 ) break loop3;
                    	    if (state.backtracking>0) {state.failed=true; return ;}
                                EarlyExitException eee =
                                    new EarlyExitException(3, input);
                                throw eee;
                        }
                        cnt3++;
                    } while (true);

                    mDOT(); if (state.failed) return ;
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:505:25: ( '0' .. '9' )+
                    int cnt4=0;
                    loop4:
                    do {
                        int alt4=2;
                        int LA4_0 = input.LA(1);

                        if ( ((LA4_0>='0' && LA4_0<='9')) ) {
                            alt4=1;
                        }


                        switch (alt4) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:505:26: '0' .. '9'
                    	    {
                    	    matchRange('0','9'); if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt4 >= 1 ) break loop4;
                    	    if (state.backtracking>0) {state.failed=true; return ;}
                                EarlyExitException eee =
                                    new EarlyExitException(4, input);
                                throw eee;
                        }
                        cnt4++;
                    } while (true);

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:505:37: ( EXPONENT )?
                    int alt5=2;
                    int LA5_0 = input.LA(1);

                    if ( (LA5_0=='E'||LA5_0=='e') ) {
                        alt5=1;
                    }
                    switch (alt5) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:505:37: EXPONENT
                            {
                            mEXPONENT(); if (state.failed) return ;

                            }
                            break;

                    }


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:506:9: ( '0' .. '9' )+ EXPONENT
                    {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:506:9: ( '0' .. '9' )+
                    int cnt6=0;
                    loop6:
                    do {
                        int alt6=2;
                        int LA6_0 = input.LA(1);

                        if ( ((LA6_0>='0' && LA6_0<='9')) ) {
                            alt6=1;
                        }


                        switch (alt6) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:506:10: '0' .. '9'
                    	    {
                    	    matchRange('0','9'); if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt6 >= 1 ) break loop6;
                    	    if (state.backtracking>0) {state.failed=true; return ;}
                                EarlyExitException eee =
                                    new EarlyExitException(6, input);
                                throw eee;
                        }
                        cnt6++;
                    } while (true);

                    mEXPONENT(); if (state.failed) return ;

                    }
                    break;

            }
        }
        finally {
        }
    }
    // $ANTLR end "FLOAT"

    // $ANTLR start "RANGE_OR_INT"
    public final void mRANGE_OR_INT() throws RecognitionException {
        try {
            int _type = RANGE_OR_INT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:510:2: ( ( INT DOTDOT )=> INT | ( INT DOT INT )=> FLOAT | INT )
            int alt8=3;
            int LA8_0 = input.LA(1);

            if ( ((LA8_0>='0' && LA8_0<='9')) ) {
                int LA8_1 = input.LA(2);

                if ( ((LA8_1>='0' && LA8_1<='9')) && (synpred2_DelphiScript())) {
                    alt8=2;
                }
                else if ( (LA8_1=='.') && (synpred2_DelphiScript())) {
                    alt8=2;
                }
                else if ( (LA8_1=='E'||LA8_1=='e') && (synpred2_DelphiScript())) {
                    alt8=2;
                }
                else if ( (synpred1_DelphiScript()) ) {
                    alt8=1;
                }
                else if ( (true) ) {
                    alt8=3;
                }
                else {
                    if (state.backtracking>0) {state.failed=true; return ;}
                    NoViableAltException nvae =
                        new NoViableAltException("", 8, 1, input);

                    throw nvae;
                }
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 8, 0, input);

                throw nvae;
            }
            switch (alt8) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:510:4: ( INT DOTDOT )=> INT
                    {
                    mINT(); if (state.failed) return ;
                    if ( state.backtracking==0 ) {
                      _type = INT;
                    }

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:511:4: ( INT DOT INT )=> FLOAT
                    {
                    mFLOAT(); if (state.failed) return ;
                    if ( state.backtracking==0 ) {
                      _type = FLOAT;
                    }

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:512:4: INT
                    {
                    mINT(); if (state.failed) return ;
                    if ( state.backtracking==0 ) {
                      _type = INT;
                    }

                    }
                    break;

            }
            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "RANGE_OR_INT"

    // $ANTLR start "COMMENT"
    public final void mCOMMENT() throws RecognitionException {
        try {
            int _type = COMMENT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:517:5: ( '//' (~ ( '\\n' | '\\r' ) )* ( '\\r' )? '\\n' | '{' ( options {greedy=false; } : . )* '}' )
            int alt12=2;
            int LA12_0 = input.LA(1);

            if ( (LA12_0=='/') ) {
                alt12=1;
            }
            else if ( (LA12_0=='{') ) {
                alt12=2;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 12, 0, input);

                throw nvae;
            }
            switch (alt12) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:517:9: '//' (~ ( '\\n' | '\\r' ) )* ( '\\r' )? '\\n'
                    {
                    match("//"); if (state.failed) return ;

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:517:14: (~ ( '\\n' | '\\r' ) )*
                    loop9:
                    do {
                        int alt9=2;
                        int LA9_0 = input.LA(1);

                        if ( ((LA9_0>='\u0000' && LA9_0<='\t')||(LA9_0>='\u000B' && LA9_0<='\f')||(LA9_0>='\u000E' && LA9_0<='\uFFFF')) ) {
                            alt9=1;
                        }


                        switch (alt9) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:517:14: ~ ( '\\n' | '\\r' )
                    	    {
                    	    if ( (input.LA(1)>='\u0000' && input.LA(1)<='\t')||(input.LA(1)>='\u000B' && input.LA(1)<='\f')||(input.LA(1)>='\u000E' && input.LA(1)<='\uFFFF') ) {
                    	        input.consume();
                    	    state.failed=false;
                    	    }
                    	    else {
                    	        if (state.backtracking>0) {state.failed=true; return ;}
                    	        MismatchedSetException mse = new MismatchedSetException(null,input);
                    	        recover(mse);
                    	        throw mse;}


                    	    }
                    	    break;

                    	default :
                    	    break loop9;
                        }
                    } while (true);

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:517:28: ( '\\r' )?
                    int alt10=2;
                    int LA10_0 = input.LA(1);

                    if ( (LA10_0=='\r') ) {
                        alt10=1;
                    }
                    switch (alt10) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:517:28: '\\r'
                            {
                            match('\r'); if (state.failed) return ;

                            }
                            break;

                    }

                    match('\n'); if (state.failed) return ;
                    if ( state.backtracking==0 ) {
                      _channel=HIDDEN;
                    }

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:518:9: '{' ( options {greedy=false; } : . )* '}'
                    {
                    match('{'); if (state.failed) return ;
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:518:13: ( options {greedy=false; } : . )*
                    loop11:
                    do {
                        int alt11=2;
                        int LA11_0 = input.LA(1);

                        if ( (LA11_0=='}') ) {
                            alt11=2;
                        }
                        else if ( ((LA11_0>='\u0000' && LA11_0<='|')||(LA11_0>='~' && LA11_0<='\uFFFF')) ) {
                            alt11=1;
                        }


                        switch (alt11) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:518:41: .
                    	    {
                    	    matchAny(); if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    break loop11;
                        }
                    } while (true);

                    match('}'); if (state.failed) return ;
                    if ( state.backtracking==0 ) {
                      _channel=HIDDEN;
                    }

                    }
                    break;

            }
            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "COMMENT"

    // $ANTLR start "WS"
    public final void mWS() throws RecognitionException {
        try {
            int _type = WS;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:522:2: ( ( ' ' | '\\t' | '\\r' | '\\n' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:522:6: ( ' ' | '\\t' | '\\r' | '\\n' )
            {
            if ( (input.LA(1)>='\t' && input.LA(1)<='\n')||input.LA(1)=='\r'||input.LA(1)==' ' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}

            if ( state.backtracking==0 ) {
              _channel=HIDDEN;
            }

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "WS"

    // $ANTLR start "CHAR_LITERAL"
    public final void mCHAR_LITERAL() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:2: ( ( '#' ( '0' .. '9' ) ( ( '0' .. '9' )? ( '0' .. '9' ) )? )+ )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:5: ( '#' ( '0' .. '9' ) ( ( '0' .. '9' )? ( '0' .. '9' ) )? )+
            {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:5: ( '#' ( '0' .. '9' ) ( ( '0' .. '9' )? ( '0' .. '9' ) )? )+
            int cnt15=0;
            loop15:
            do {
                int alt15=2;
                int LA15_0 = input.LA(1);

                if ( (LA15_0=='#') ) {
                    alt15=1;
                }


                switch (alt15) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:7: '#' ( '0' .. '9' ) ( ( '0' .. '9' )? ( '0' .. '9' ) )?
            	    {
            	    match('#'); if (state.failed) return ;
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:11: ( '0' .. '9' )
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:12: '0' .. '9'
            	    {
            	    matchRange('0','9'); if (state.failed) return ;

            	    }

            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:22: ( ( '0' .. '9' )? ( '0' .. '9' ) )?
            	    int alt14=2;
            	    int LA14_0 = input.LA(1);

            	    if ( ((LA14_0>='0' && LA14_0<='9')) ) {
            	        alt14=1;
            	    }
            	    switch (alt14) {
            	        case 1 :
            	            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:23: ( '0' .. '9' )? ( '0' .. '9' )
            	            {
            	            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:23: ( '0' .. '9' )?
            	            int alt13=2;
            	            int LA13_0 = input.LA(1);

            	            if ( ((LA13_0>='0' && LA13_0<='9')) ) {
            	                int LA13_1 = input.LA(2);

            	                if ( ((LA13_1>='0' && LA13_1<='9')) ) {
            	                    alt13=1;
            	                }
            	            }
            	            switch (alt13) {
            	                case 1 :
            	                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:24: '0' .. '9'
            	                    {
            	                    matchRange('0','9'); if (state.failed) return ;

            	                    }
            	                    break;

            	            }

            	            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:35: ( '0' .. '9' )
            	            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:531:36: '0' .. '9'
            	            {
            	            matchRange('0','9'); if (state.failed) return ;

            	            }


            	            }
            	            break;

            	    }


            	    }
            	    break;

            	default :
            	    if ( cnt15 >= 1 ) break loop15;
            	    if (state.backtracking>0) {state.failed=true; return ;}
                        EarlyExitException eee =
                            new EarlyExitException(15, input);
                        throw eee;
                }
                cnt15++;
            } while (true);


            }

        }
        finally {
        }
    }
    // $ANTLR end "CHAR_LITERAL"

    // $ANTLR start "STRING_LITERAL"
    public final void mSTRING_LITERAL() throws RecognitionException {
        try {
            int _type = STRING_LITERAL;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:535:5: ( ( CHAR_LITERAL )* '\\'' ( '\\'\\'' | ~ ( '\\'' ) )+ '\\'' ( CHAR_LITERAL )* | '\\'\\'' | ( CHAR_LITERAL )+ )
            int alt20=3;
            alt20 = dfa20.predict(input);
            switch (alt20) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:535:7: ( CHAR_LITERAL )* '\\'' ( '\\'\\'' | ~ ( '\\'' ) )+ '\\'' ( CHAR_LITERAL )*
                    {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:535:7: ( CHAR_LITERAL )*
                    loop16:
                    do {
                        int alt16=2;
                        int LA16_0 = input.LA(1);

                        if ( (LA16_0=='#') ) {
                            alt16=1;
                        }


                        switch (alt16) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:535:7: CHAR_LITERAL
                    	    {
                    	    mCHAR_LITERAL(); if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    break loop16;
                        }
                    } while (true);

                    match('\''); if (state.failed) return ;
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:535:26: ( '\\'\\'' | ~ ( '\\'' ) )+
                    int cnt17=0;
                    loop17:
                    do {
                        int alt17=3;
                        int LA17_0 = input.LA(1);

                        if ( (LA17_0=='\'') ) {
                            int LA17_1 = input.LA(2);

                            if ( (LA17_1=='\'') ) {
                                alt17=1;
                            }


                        }
                        else if ( ((LA17_0>='\u0000' && LA17_0<='&')||(LA17_0>='(' && LA17_0<='\uFFFF')) ) {
                            alt17=2;
                        }


                        switch (alt17) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:535:28: '\\'\\''
                    	    {
                    	    match("''"); if (state.failed) return ;


                    	    }
                    	    break;
                    	case 2 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:535:37: ~ ( '\\'' )
                    	    {
                    	    if ( (input.LA(1)>='\u0000' && input.LA(1)<='&')||(input.LA(1)>='(' && input.LA(1)<='\uFFFF') ) {
                    	        input.consume();
                    	    state.failed=false;
                    	    }
                    	    else {
                    	        if (state.backtracking>0) {state.failed=true; return ;}
                    	        MismatchedSetException mse = new MismatchedSetException(null,input);
                    	        recover(mse);
                    	        throw mse;}


                    	    }
                    	    break;

                    	default :
                    	    if ( cnt17 >= 1 ) break loop17;
                    	    if (state.backtracking>0) {state.failed=true; return ;}
                                EarlyExitException eee =
                                    new EarlyExitException(17, input);
                                throw eee;
                        }
                        cnt17++;
                    } while (true);

                    match('\''); if (state.failed) return ;
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:535:53: ( CHAR_LITERAL )*
                    loop18:
                    do {
                        int alt18=2;
                        int LA18_0 = input.LA(1);

                        if ( (LA18_0=='#') ) {
                            alt18=1;
                        }


                        switch (alt18) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:535:53: CHAR_LITERAL
                    	    {
                    	    mCHAR_LITERAL(); if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    break loop18;
                        }
                    } while (true);


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:536:7: '\\'\\''
                    {
                    match("''"); if (state.failed) return ;


                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:537:7: ( CHAR_LITERAL )+
                    {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:537:7: ( CHAR_LITERAL )+
                    int cnt19=0;
                    loop19:
                    do {
                        int alt19=2;
                        int LA19_0 = input.LA(1);

                        if ( (LA19_0=='#') ) {
                            alt19=1;
                        }


                        switch (alt19) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:537:7: CHAR_LITERAL
                    	    {
                    	    mCHAR_LITERAL(); if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt19 >= 1 ) break loop19;
                    	    if (state.backtracking>0) {state.failed=true; return ;}
                                EarlyExitException eee =
                                    new EarlyExitException(19, input);
                                throw eee;
                        }
                        cnt19++;
                    } while (true);


                    }
                    break;

            }
            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "STRING_LITERAL"

    // $ANTLR start "HEX"
    public final void mHEX() throws RecognitionException {
        try {
            int _type = HEX;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:541:2: ( '$' ( HEX_DIGIT )+ )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:541:4: '$' ( HEX_DIGIT )+
            {
            match('$'); if (state.failed) return ;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:541:8: ( HEX_DIGIT )+
            int cnt21=0;
            loop21:
            do {
                int alt21=2;
                int LA21_0 = input.LA(1);

                if ( ((LA21_0>='0' && LA21_0<='9')||(LA21_0>='A' && LA21_0<='F')||(LA21_0>='a' && LA21_0<='f')) ) {
                    alt21=1;
                }


                switch (alt21) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:541:8: HEX_DIGIT
            	    {
            	    mHEX_DIGIT(); if (state.failed) return ;

            	    }
            	    break;

            	default :
            	    if ( cnt21 >= 1 ) break loop21;
            	    if (state.backtracking>0) {state.failed=true; return ;}
                        EarlyExitException eee =
                            new EarlyExitException(21, input);
                        throw eee;
                }
                cnt21++;
            } while (true);


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "HEX"

    // $ANTLR start "EXPONENT"
    public final void mEXPONENT() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:545:10: ( ( 'e' | 'E' ) ( '+' | '-' )? ( '0' .. '9' )+ )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:545:12: ( 'e' | 'E' ) ( '+' | '-' )? ( '0' .. '9' )+
            {
            if ( input.LA(1)=='E'||input.LA(1)=='e' ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:545:22: ( '+' | '-' )?
            int alt22=2;
            int LA22_0 = input.LA(1);

            if ( (LA22_0=='+'||LA22_0=='-') ) {
                alt22=1;
            }
            switch (alt22) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:
                    {
                    if ( input.LA(1)=='+'||input.LA(1)=='-' ) {
                        input.consume();
                    state.failed=false;
                    }
                    else {
                        if (state.backtracking>0) {state.failed=true; return ;}
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        recover(mse);
                        throw mse;}


                    }
                    break;

            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:545:33: ( '0' .. '9' )+
            int cnt23=0;
            loop23:
            do {
                int alt23=2;
                int LA23_0 = input.LA(1);

                if ( ((LA23_0>='0' && LA23_0<='9')) ) {
                    alt23=1;
                }


                switch (alt23) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:545:34: '0' .. '9'
            	    {
            	    matchRange('0','9'); if (state.failed) return ;

            	    }
            	    break;

            	default :
            	    if ( cnt23 >= 1 ) break loop23;
            	    if (state.backtracking>0) {state.failed=true; return ;}
                        EarlyExitException eee =
                            new EarlyExitException(23, input);
                        throw eee;
                }
                cnt23++;
            } while (true);


            }

        }
        finally {
        }
    }
    // $ANTLR end "EXPONENT"

    // $ANTLR start "HEX_DIGIT"
    public final void mHEX_DIGIT() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:548:11: ( ( '0' .. '9' | 'a' .. 'f' | 'A' .. 'F' ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:548:13: ( '0' .. '9' | 'a' .. 'f' | 'A' .. 'F' )
            {
            if ( (input.LA(1)>='0' && input.LA(1)<='9')||(input.LA(1)>='A' && input.LA(1)<='F')||(input.LA(1)>='a' && input.LA(1)<='f') ) {
                input.consume();
            state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

        }
        finally {
        }
    }
    // $ANTLR end "HEX_DIGIT"

    public void mTokens() throws RecognitionException {
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:8: ( DIV | MOD | AND | OR | XOR | SHL | SHR | NOT | ARRAY | OF | IN | SET | FILE | FOR | BEGIN | END | VAR | PROCEDURE | FUNCTION | CONST | OUT | FORWARD | STRING | NIL | USES | LABEL | GOTO | IF | THEN | ELSE | CASE | REPEAT | UNTIL | WHILE | DO | TO | DOWNTO | WITH | TRY | FINALLY | EXCEPT | RAISE | UNIT | RESULT | EXCEPTIONMESSAGE | FALSE | TRUE | BREAK | PLUS | MINUS | STAR | SLASH | AT | LSQBR | RSQBR | LPAREN | RPAREN | COMMA | SEMI | COLON | EQUAL | NOT_EQUAL | LT | LE | GE | GT | ASSIGN | AMPERSAND | DOTDOT | DOT | POINTER | ID | RANGE_OR_INT | COMMENT | WS | STRING_LITERAL | HEX )
        int alt24=77;
        alt24 = dfa24.predict(input);
        switch (alt24) {
            case 1 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:10: DIV
                {
                mDIV(); if (state.failed) return ;

                }
                break;
            case 2 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:14: MOD
                {
                mMOD(); if (state.failed) return ;

                }
                break;
            case 3 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:18: AND
                {
                mAND(); if (state.failed) return ;

                }
                break;
            case 4 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:22: OR
                {
                mOR(); if (state.failed) return ;

                }
                break;
            case 5 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:25: XOR
                {
                mXOR(); if (state.failed) return ;

                }
                break;
            case 6 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:29: SHL
                {
                mSHL(); if (state.failed) return ;

                }
                break;
            case 7 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:33: SHR
                {
                mSHR(); if (state.failed) return ;

                }
                break;
            case 8 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:37: NOT
                {
                mNOT(); if (state.failed) return ;

                }
                break;
            case 9 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:41: ARRAY
                {
                mARRAY(); if (state.failed) return ;

                }
                break;
            case 10 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:47: OF
                {
                mOF(); if (state.failed) return ;

                }
                break;
            case 11 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:50: IN
                {
                mIN(); if (state.failed) return ;

                }
                break;
            case 12 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:53: SET
                {
                mSET(); if (state.failed) return ;

                }
                break;
            case 13 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:57: FILE
                {
                mFILE(); if (state.failed) return ;

                }
                break;
            case 14 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:62: FOR
                {
                mFOR(); if (state.failed) return ;

                }
                break;
            case 15 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:66: BEGIN
                {
                mBEGIN(); if (state.failed) return ;

                }
                break;
            case 16 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:72: END
                {
                mEND(); if (state.failed) return ;

                }
                break;
            case 17 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:76: VAR
                {
                mVAR(); if (state.failed) return ;

                }
                break;
            case 18 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:80: PROCEDURE
                {
                mPROCEDURE(); if (state.failed) return ;

                }
                break;
            case 19 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:90: FUNCTION
                {
                mFUNCTION(); if (state.failed) return ;

                }
                break;
            case 20 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:99: CONST
                {
                mCONST(); if (state.failed) return ;

                }
                break;
            case 21 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:105: OUT
                {
                mOUT(); if (state.failed) return ;

                }
                break;
            case 22 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:109: FORWARD
                {
                mFORWARD(); if (state.failed) return ;

                }
                break;
            case 23 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:117: STRING
                {
                mSTRING(); if (state.failed) return ;

                }
                break;
            case 24 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:124: NIL
                {
                mNIL(); if (state.failed) return ;

                }
                break;
            case 25 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:128: USES
                {
                mUSES(); if (state.failed) return ;

                }
                break;
            case 26 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:133: LABEL
                {
                mLABEL(); if (state.failed) return ;

                }
                break;
            case 27 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:139: GOTO
                {
                mGOTO(); if (state.failed) return ;

                }
                break;
            case 28 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:144: IF
                {
                mIF(); if (state.failed) return ;

                }
                break;
            case 29 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:147: THEN
                {
                mTHEN(); if (state.failed) return ;

                }
                break;
            case 30 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:152: ELSE
                {
                mELSE(); if (state.failed) return ;

                }
                break;
            case 31 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:157: CASE
                {
                mCASE(); if (state.failed) return ;

                }
                break;
            case 32 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:162: REPEAT
                {
                mREPEAT(); if (state.failed) return ;

                }
                break;
            case 33 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:169: UNTIL
                {
                mUNTIL(); if (state.failed) return ;

                }
                break;
            case 34 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:175: WHILE
                {
                mWHILE(); if (state.failed) return ;

                }
                break;
            case 35 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:181: DO
                {
                mDO(); if (state.failed) return ;

                }
                break;
            case 36 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:184: TO
                {
                mTO(); if (state.failed) return ;

                }
                break;
            case 37 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:187: DOWNTO
                {
                mDOWNTO(); if (state.failed) return ;

                }
                break;
            case 38 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:194: WITH
                {
                mWITH(); if (state.failed) return ;

                }
                break;
            case 39 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:199: TRY
                {
                mTRY(); if (state.failed) return ;

                }
                break;
            case 40 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:203: FINALLY
                {
                mFINALLY(); if (state.failed) return ;

                }
                break;
            case 41 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:211: EXCEPT
                {
                mEXCEPT(); if (state.failed) return ;

                }
                break;
            case 42 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:218: RAISE
                {
                mRAISE(); if (state.failed) return ;

                }
                break;
            case 43 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:224: UNIT
                {
                mUNIT(); if (state.failed) return ;

                }
                break;
            case 44 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:229: RESULT
                {
                mRESULT(); if (state.failed) return ;

                }
                break;
            case 45 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:236: EXCEPTIONMESSAGE
                {
                mEXCEPTIONMESSAGE(); if (state.failed) return ;

                }
                break;
            case 46 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:253: FALSE
                {
                mFALSE(); if (state.failed) return ;

                }
                break;
            case 47 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:259: TRUE
                {
                mTRUE(); if (state.failed) return ;

                }
                break;
            case 48 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:264: BREAK
                {
                mBREAK(); if (state.failed) return ;

                }
                break;
            case 49 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:270: PLUS
                {
                mPLUS(); if (state.failed) return ;

                }
                break;
            case 50 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:275: MINUS
                {
                mMINUS(); if (state.failed) return ;

                }
                break;
            case 51 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:281: STAR
                {
                mSTAR(); if (state.failed) return ;

                }
                break;
            case 52 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:286: SLASH
                {
                mSLASH(); if (state.failed) return ;

                }
                break;
            case 53 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:292: AT
                {
                mAT(); if (state.failed) return ;

                }
                break;
            case 54 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:295: LSQBR
                {
                mLSQBR(); if (state.failed) return ;

                }
                break;
            case 55 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:301: RSQBR
                {
                mRSQBR(); if (state.failed) return ;

                }
                break;
            case 56 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:307: LPAREN
                {
                mLPAREN(); if (state.failed) return ;

                }
                break;
            case 57 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:314: RPAREN
                {
                mRPAREN(); if (state.failed) return ;

                }
                break;
            case 58 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:321: COMMA
                {
                mCOMMA(); if (state.failed) return ;

                }
                break;
            case 59 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:327: SEMI
                {
                mSEMI(); if (state.failed) return ;

                }
                break;
            case 60 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:332: COLON
                {
                mCOLON(); if (state.failed) return ;

                }
                break;
            case 61 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:338: EQUAL
                {
                mEQUAL(); if (state.failed) return ;

                }
                break;
            case 62 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:344: NOT_EQUAL
                {
                mNOT_EQUAL(); if (state.failed) return ;

                }
                break;
            case 63 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:354: LT
                {
                mLT(); if (state.failed) return ;

                }
                break;
            case 64 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:357: LE
                {
                mLE(); if (state.failed) return ;

                }
                break;
            case 65 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:360: GE
                {
                mGE(); if (state.failed) return ;

                }
                break;
            case 66 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:363: GT
                {
                mGT(); if (state.failed) return ;

                }
                break;
            case 67 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:366: ASSIGN
                {
                mASSIGN(); if (state.failed) return ;

                }
                break;
            case 68 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:373: AMPERSAND
                {
                mAMPERSAND(); if (state.failed) return ;

                }
                break;
            case 69 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:383: DOTDOT
                {
                mDOTDOT(); if (state.failed) return ;

                }
                break;
            case 70 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:390: DOT
                {
                mDOT(); if (state.failed) return ;

                }
                break;
            case 71 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:394: POINTER
                {
                mPOINTER(); if (state.failed) return ;

                }
                break;
            case 72 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:402: ID
                {
                mID(); if (state.failed) return ;

                }
                break;
            case 73 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:405: RANGE_OR_INT
                {
                mRANGE_OR_INT(); if (state.failed) return ;

                }
                break;
            case 74 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:418: COMMENT
                {
                mCOMMENT(); if (state.failed) return ;

                }
                break;
            case 75 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:426: WS
                {
                mWS(); if (state.failed) return ;

                }
                break;
            case 76 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:429: STRING_LITERAL
                {
                mSTRING_LITERAL(); if (state.failed) return ;

                }
                break;
            case 77 :
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:1:444: HEX
                {
                mHEX(); if (state.failed) return ;

                }
                break;

        }

    }

    // $ANTLR start synpred1_DelphiScript
    public final void synpred1_DelphiScript_fragment() throws RecognitionException {   
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:510:4: ( INT DOTDOT )
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:510:5: INT DOTDOT
        {
        mINT(); if (state.failed) return ;
        mDOTDOT(); if (state.failed) return ;

        }
    }
    // $ANTLR end synpred1_DelphiScript

    // $ANTLR start synpred2_DelphiScript
    public final void synpred2_DelphiScript_fragment() throws RecognitionException {   
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:511:4: ( INT DOT INT )
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:511:5: INT DOT INT
        {
        mINT(); if (state.failed) return ;
        mDOT(); if (state.failed) return ;
        mINT(); if (state.failed) return ;

        }
    }
    // $ANTLR end synpred2_DelphiScript

    public final boolean synpred1_DelphiScript() {
        state.backtracking++;
        int start = input.mark();
        try {
            synpred1_DelphiScript_fragment(); // can never throw exception
        } catch (RecognitionException re) {
            System.err.println("impossible: "+re);
        }
        boolean success = !state.failed;
        input.rewind(start);
        state.backtracking--;
        state.failed=false;
        return success;
    }
    public final boolean synpred2_DelphiScript() {
        state.backtracking++;
        int start = input.mark();
        try {
            synpred2_DelphiScript_fragment(); // can never throw exception
        } catch (RecognitionException re) {
            System.err.println("impossible: "+re);
        }
        boolean success = !state.failed;
        input.rewind(start);
        state.backtracking--;
        state.failed=false;
        return success;
    }


    protected DFA7 dfa7 = new DFA7(this);
    protected DFA20 dfa20 = new DFA20(this);
    protected DFA24 dfa24 = new DFA24(this);
    static final String DFA7_eotS =
        "\4\uffff";
    static final String DFA7_eofS =
        "\4\uffff";
    static final String DFA7_minS =
        "\1\60\1\56\2\uffff";
    static final String DFA7_maxS =
        "\1\71\1\145\2\uffff";
    static final String DFA7_acceptS =
        "\2\uffff\1\1\1\2";
    static final String DFA7_specialS =
        "\4\uffff}>";
    static final String[] DFA7_transitionS = {
            "\12\1",
            "\1\2\1\uffff\12\1\13\uffff\1\3\37\uffff\1\3",
            "",
            ""
    };

    static final short[] DFA7_eot = DFA.unpackEncodedString(DFA7_eotS);
    static final short[] DFA7_eof = DFA.unpackEncodedString(DFA7_eofS);
    static final char[] DFA7_min = DFA.unpackEncodedStringToUnsignedChars(DFA7_minS);
    static final char[] DFA7_max = DFA.unpackEncodedStringToUnsignedChars(DFA7_maxS);
    static final short[] DFA7_accept = DFA.unpackEncodedString(DFA7_acceptS);
    static final short[] DFA7_special = DFA.unpackEncodedString(DFA7_specialS);
    static final short[][] DFA7_transition;

    static {
        int numStates = DFA7_transitionS.length;
        DFA7_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA7_transition[i] = DFA.unpackEncodedString(DFA7_transitionS[i]);
        }
    }

    class DFA7 extends DFA {

        public DFA7(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 7;
            this.eot = DFA7_eot;
            this.eof = DFA7_eof;
            this.min = DFA7_min;
            this.max = DFA7_max;
            this.accept = DFA7_accept;
            this.special = DFA7_special;
            this.transition = DFA7_transition;
        }
        public String getDescription() {
            return "503:1: fragment FLOAT : ( ( '0' .. '9' )+ DOT ( '0' .. '9' )+ ( EXPONENT )? | ( '0' .. '9' )+ EXPONENT );";
        }
    }
    static final String DFA20_eotS =
        "\3\uffff\1\7\1\10\1\uffff\1\7\2\uffff\1\7";
    static final String DFA20_eofS =
        "\12\uffff";
    static final String DFA20_minS =
        "\1\43\1\60\1\0\1\43\1\47\1\uffff\1\43\2\uffff\1\43";
    static final String DFA20_maxS =
        "\1\47\1\71\1\uffff\1\71\1\47\1\uffff\1\71\2\uffff\1\47";
    static final String DFA20_acceptS =
        "\5\uffff\1\1\1\uffff\1\3\1\2\1\uffff";
    static final String DFA20_specialS =
        "\2\uffff\1\0\7\uffff}>";
    static final String[] DFA20_transitionS = {
            "\1\1\3\uffff\1\2",
            "\12\3",
            "\47\5\1\4\uffd8\5",
            "\1\1\3\uffff\1\5\10\uffff\12\6",
            "\1\5",
            "",
            "\1\1\3\uffff\1\5\10\uffff\12\11",
            "",
            "",
            "\1\1\3\uffff\1\5"
    };

    static final short[] DFA20_eot = DFA.unpackEncodedString(DFA20_eotS);
    static final short[] DFA20_eof = DFA.unpackEncodedString(DFA20_eofS);
    static final char[] DFA20_min = DFA.unpackEncodedStringToUnsignedChars(DFA20_minS);
    static final char[] DFA20_max = DFA.unpackEncodedStringToUnsignedChars(DFA20_maxS);
    static final short[] DFA20_accept = DFA.unpackEncodedString(DFA20_acceptS);
    static final short[] DFA20_special = DFA.unpackEncodedString(DFA20_specialS);
    static final short[][] DFA20_transition;

    static {
        int numStates = DFA20_transitionS.length;
        DFA20_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA20_transition[i] = DFA.unpackEncodedString(DFA20_transitionS[i]);
        }
    }

    class DFA20 extends DFA {

        public DFA20(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 20;
            this.eot = DFA20_eot;
            this.eof = DFA20_eof;
            this.min = DFA20_min;
            this.max = DFA20_max;
            this.accept = DFA20_accept;
            this.special = DFA20_special;
            this.transition = DFA20_transition;
        }
        public String getDescription() {
            return "534:1: STRING_LITERAL : ( ( CHAR_LITERAL )* '\\'' ( '\\'\\'' | ~ ( '\\'' ) )+ '\\'' ( CHAR_LITERAL )* | '\\'\\'' | ( CHAR_LITERAL )+ );";
        }
        public int specialStateTransition(int s, IntStream _input) throws NoViableAltException {
            IntStream input = _input;
        	int _s = s;
            switch ( s ) {
                    case 0 : 
                        int LA20_2 = input.LA(1);

                        s = -1;
                        if ( (LA20_2=='\'') ) {s = 4;}

                        else if ( ((LA20_2>='\u0000' && LA20_2<='&')||(LA20_2>='(' && LA20_2<='\uFFFF')) ) {s = 5;}

                        if ( s>=0 ) return s;
                        break;
            }
            if (state.backtracking>0) {state.failed=true; return -1;}
            NoViableAltException nvae =
                new NoViableAltException(getDescription(), 20, _s, input);
            error(nvae);
            throw nvae;
        }
    }
    static final String DFA24_eotS =
        "\1\uffff\24\47\3\uffff\1\125\7\uffff\1\127\1\uffff\1\132\1\134"+
        "\1\uffff\1\136\7\uffff\1\47\1\140\3\47\1\145\1\146\7\47\1\157\1"+
        "\160\22\47\1\u0085\5\47\12\uffff\1\u008d\1\uffff\1\47\1\u008f\1"+
        "\u0090\1\47\2\uffff\1\u0092\1\u0093\1\u0094\1\u0095\1\u0096\1\47"+
        "\1\u0098\1\u0099\2\uffff\2\47\1\u009c\4\47\1\u00a2\2\47\1\u00a5"+
        "\11\47\1\uffff\1\u00af\6\47\1\uffff\1\47\2\uffff\1\47\5\uffff\1"+
        "\47\2\uffff\1\u00b9\1\47\1\uffff\5\47\1\uffff\1\u00c0\1\47\1\uffff"+
        "\2\47\1\u00c4\1\u00c5\1\47\1\u00c7\1\47\1\u00c9\1\u00ca\1\uffff"+
        "\1\u00cb\4\47\1\u00d0\1\47\1\u00d2\1\47\1\uffff\3\47\1\u00d7\1\u00d8"+
        "\1\u00d9\1\uffff\2\47\1\u00dc\2\uffff\1\u00dd\1\uffff\1\u00de\3"+
        "\uffff\2\47\1\u00e1\1\u00e2\1\uffff\1\u00e3\1\uffff\1\u00e4\3\47"+
        "\3\uffff\1\u00e8\1\47\3\uffff\1\u00eb\1\u00ec\4\uffff\1\u00ed\1"+
        "\u00ee\1\47\1\uffff\2\47\4\uffff\1\u00f2\2\47\1\uffff\1\47\1\u00f6"+
        "\1\47\1\uffff\5\47\1\u00fd\1\uffff";
    static final String DFA24_eofS =
        "\u00fe\uffff";
    static final String DFA24_minS =
        "\1\11\1\111\1\117\1\116\1\106\1\117\1\105\1\111\1\106\1\101\1\105"+
        "\1\114\1\101\1\122\1\101\1\116\1\101\1\117\1\110\1\101\1\110\3\uffff"+
        "\1\57\7\uffff\1\75\1\uffff\2\75\1\uffff\1\56\7\uffff\1\126\1\60"+
        "\2\104\1\122\2\60\1\124\1\122\1\114\1\124\1\122\1\124\1\114\2\60"+
        "\1\114\1\122\1\116\1\114\1\107\1\105\1\104\1\123\1\103\1\122\1\117"+
        "\1\116\1\123\1\105\1\111\1\102\1\124\1\105\1\60\1\125\1\120\2\111"+
        "\1\124\12\uffff\1\60\1\uffff\1\116\2\60\1\101\2\uffff\5\60\1\111"+
        "\2\60\2\uffff\1\105\1\101\1\60\1\103\1\123\1\111\1\101\1\60\2\105"+
        "\1\60\1\103\1\123\1\105\1\123\1\111\1\124\1\105\1\117\1\116\1\uffff"+
        "\1\60\2\105\1\125\1\123\1\114\1\110\1\uffff\1\124\2\uffff\1\131"+
        "\5\uffff\1\116\2\uffff\1\60\1\114\1\uffff\1\101\1\124\1\105\1\116"+
        "\1\113\1\uffff\1\60\1\120\1\uffff\1\105\1\124\2\60\1\114\1\60\1"+
        "\114\2\60\1\uffff\1\60\1\101\1\114\2\105\1\60\1\117\1\60\1\107\1"+
        "\uffff\1\114\1\122\1\111\3\60\1\uffff\1\124\1\104\1\60\2\uffff\1"+
        "\60\1\uffff\1\60\3\uffff\2\124\2\60\1\uffff\1\60\1\uffff\1\60\1"+
        "\131\1\104\1\117\3\uffff\1\60\1\125\3\uffff\2\60\4\uffff\2\60\1"+
        "\116\1\uffff\1\117\1\122\4\uffff\1\60\1\116\1\105\1\uffff\1\115"+
        "\1\60\1\105\1\uffff\2\123\1\101\1\107\1\105\1\60\1\uffff";
    static final String DFA24_maxS =
        "\1\173\2\157\1\162\1\165\1\157\1\164\1\157\1\156\1\165\1\162\1"+
        "\170\1\141\1\162\1\157\1\163\1\141\1\157\1\162\1\145\1\151\3\uffff"+
        "\1\57\7\uffff\1\75\1\uffff\1\76\1\75\1\uffff\1\56\7\uffff\1\166"+
        "\1\172\2\144\1\162\2\172\1\164\2\162\1\164\1\162\1\164\1\154\2\172"+
        "\1\156\1\162\1\156\1\154\1\147\1\145\1\144\1\163\1\143\1\162\1\157"+
        "\1\156\1\163\1\145\1\164\1\142\1\164\1\145\1\172\1\171\1\163\2\151"+
        "\1\164\12\uffff\1\172\1\uffff\1\156\2\172\1\141\2\uffff\5\172\1"+
        "\151\2\172\2\uffff\1\145\1\141\1\172\1\143\1\163\1\151\1\141\1\172"+
        "\2\145\1\172\1\143\1\163\1\145\1\163\1\151\1\164\1\145\1\157\1\156"+
        "\1\uffff\1\172\2\145\1\165\1\163\1\154\1\150\1\uffff\1\164\2\uffff"+
        "\1\171\5\uffff\1\156\2\uffff\1\172\1\154\1\uffff\1\141\1\164\1\145"+
        "\1\156\1\153\1\uffff\1\172\1\160\1\uffff\1\145\1\164\2\172\1\154"+
        "\1\172\1\154\2\172\1\uffff\1\172\1\141\1\154\2\145\1\172\1\157\1"+
        "\172\1\147\1\uffff\1\154\1\162\1\151\3\172\1\uffff\1\164\1\144\1"+
        "\172\2\uffff\1\172\1\uffff\1\172\3\uffff\2\164\2\172\1\uffff\1\172"+
        "\1\uffff\1\172\1\171\1\144\1\157\3\uffff\1\172\1\165\3\uffff\2\172"+
        "\4\uffff\2\172\1\156\1\uffff\1\157\1\162\4\uffff\1\172\1\156\1\145"+
        "\1\uffff\1\155\1\172\1\145\1\uffff\2\163\1\141\1\147\1\145\1\172"+
        "\1\uffff";
    static final String DFA24_acceptS =
        "\25\uffff\1\61\1\62\1\63\1\uffff\1\65\1\66\1\67\1\70\1\71\1\72"+
        "\1\73\1\uffff\1\75\2\uffff\1\104\1\uffff\1\107\1\110\1\111\1\112"+
        "\1\113\1\114\1\115\50\uffff\1\64\1\103\1\74\1\76\1\100\1\77\1\101"+
        "\1\102\1\105\1\106\1\uffff\1\43\4\uffff\1\4\1\12\10\uffff\1\13\1"+
        "\34\24\uffff\1\44\7\uffff\1\1\1\uffff\1\2\1\3\1\uffff\1\25\1\5\1"+
        "\6\1\7\1\14\1\uffff\1\10\1\30\2\uffff\1\16\5\uffff\1\20\2\uffff"+
        "\1\21\11\uffff\1\47\11\uffff\1\15\6\uffff\1\36\3\uffff\1\37\1\31"+
        "\1\uffff\1\53\1\uffff\1\33\1\35\1\57\4\uffff\1\46\1\uffff\1\11\4"+
        "\uffff\1\56\1\17\1\60\2\uffff\1\24\1\41\1\32\2\uffff\1\52\1\42\1"+
        "\45\1\27\3\uffff\1\51\2\uffff\1\40\1\54\1\50\1\26\3\uffff\1\23\3"+
        "\uffff\1\22\6\uffff\1\55";
    static final String DFA24_specialS =
        "\u00fe\uffff}>";
    static final String[] DFA24_transitionS = {
            "\2\52\2\uffff\1\52\22\uffff\1\52\2\uffff\1\53\1\54\1\uffff"+
            "\1\44\1\53\1\34\1\35\1\27\1\25\1\36\1\26\1\45\1\30\12\50\1\40"+
            "\1\37\1\42\1\41\1\43\1\uffff\1\31\1\3\1\12\1\16\1\1\1\13\1\11"+
            "\1\21\1\47\1\10\2\47\1\20\1\2\1\7\1\4\1\15\1\47\1\23\1\6\1\22"+
            "\1\17\1\14\1\24\1\5\2\47\1\32\1\uffff\1\33\1\46\1\47\1\uffff"+
            "\1\3\1\12\1\16\1\1\1\13\1\11\1\21\1\47\1\10\2\47\1\20\1\2\1"+
            "\7\1\4\1\15\1\47\1\23\1\6\1\22\1\17\1\14\1\24\1\5\2\47\1\51",
            "\1\55\5\uffff\1\56\31\uffff\1\55\5\uffff\1\56",
            "\1\57\37\uffff\1\57",
            "\1\60\3\uffff\1\61\33\uffff\1\60\3\uffff\1\61",
            "\1\63\13\uffff\1\62\2\uffff\1\64\20\uffff\1\63\13\uffff\1"+
            "\62\2\uffff\1\64",
            "\1\65\37\uffff\1\65",
            "\1\67\2\uffff\1\66\13\uffff\1\70\20\uffff\1\67\2\uffff\1\66"+
            "\13\uffff\1\70",
            "\1\72\5\uffff\1\71\31\uffff\1\72\5\uffff\1\71",
            "\1\74\7\uffff\1\73\27\uffff\1\74\7\uffff\1\73",
            "\1\100\7\uffff\1\75\5\uffff\1\76\5\uffff\1\77\13\uffff\1\100"+
            "\7\uffff\1\75\5\uffff\1\76\5\uffff\1\77",
            "\1\101\14\uffff\1\102\22\uffff\1\101\14\uffff\1\102",
            "\1\104\1\uffff\1\103\11\uffff\1\105\23\uffff\1\104\1\uffff"+
            "\1\103\11\uffff\1\105",
            "\1\106\37\uffff\1\106",
            "\1\107\37\uffff\1\107",
            "\1\111\15\uffff\1\110\21\uffff\1\111\15\uffff\1\110",
            "\1\113\4\uffff\1\112\32\uffff\1\113\4\uffff\1\112",
            "\1\114\37\uffff\1\114",
            "\1\115\37\uffff\1\115",
            "\1\116\6\uffff\1\117\2\uffff\1\120\25\uffff\1\116\6\uffff"+
            "\1\117\2\uffff\1\120",
            "\1\122\3\uffff\1\121\33\uffff\1\122\3\uffff\1\121",
            "\1\123\1\124\36\uffff\1\123\1\124",
            "",
            "",
            "",
            "\1\51",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "\1\126",
            "",
            "\1\131\1\130",
            "\1\133",
            "",
            "\1\135",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "\1\137\37\uffff\1\137",
            "\12\47\7\uffff\26\47\1\141\3\47\4\uffff\1\47\1\uffff\26\47"+
            "\1\141\3\47",
            "\1\142\37\uffff\1\142",
            "\1\143\37\uffff\1\143",
            "\1\144\37\uffff\1\144",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\147\37\uffff\1\147",
            "\1\150\37\uffff\1\150",
            "\1\151\5\uffff\1\152\31\uffff\1\151\5\uffff\1\152",
            "\1\153\37\uffff\1\153",
            "\1\154\37\uffff\1\154",
            "\1\155\37\uffff\1\155",
            "\1\156\37\uffff\1\156",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\161\1\uffff\1\162\35\uffff\1\161\1\uffff\1\162",
            "\1\163\37\uffff\1\163",
            "\1\164\37\uffff\1\164",
            "\1\165\37\uffff\1\165",
            "\1\166\37\uffff\1\166",
            "\1\167\37\uffff\1\167",
            "\1\170\37\uffff\1\170",
            "\1\171\37\uffff\1\171",
            "\1\172\37\uffff\1\172",
            "\1\173\37\uffff\1\173",
            "\1\174\37\uffff\1\174",
            "\1\175\37\uffff\1\175",
            "\1\176\37\uffff\1\176",
            "\1\177\37\uffff\1\177",
            "\1\u0081\12\uffff\1\u0080\24\uffff\1\u0081\12\uffff\1\u0080",
            "\1\u0082\37\uffff\1\u0082",
            "\1\u0083\37\uffff\1\u0083",
            "\1\u0084\37\uffff\1\u0084",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u0087\3\uffff\1\u0086\33\uffff\1\u0087\3\uffff\1\u0086",
            "\1\u0088\2\uffff\1\u0089\34\uffff\1\u0088\2\uffff\1\u0089",
            "\1\u008a\37\uffff\1\u008a",
            "\1\u008b\37\uffff\1\u008b",
            "\1\u008c\37\uffff\1\u008c",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "",
            "\1\u008e\37\uffff\1\u008e",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u0091\37\uffff\1\u0091",
            "",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u0097\37\uffff\1\u0097",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "",
            "",
            "\1\u009a\37\uffff\1\u009a",
            "\1\u009b\37\uffff\1\u009b",
            "\12\47\7\uffff\26\47\1\u009d\3\47\4\uffff\1\47\1\uffff\26"+
            "\47\1\u009d\3\47",
            "\1\u009e\37\uffff\1\u009e",
            "\1\u009f\37\uffff\1\u009f",
            "\1\u00a0\37\uffff\1\u00a0",
            "\1\u00a1\37\uffff\1\u00a1",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00a3\37\uffff\1\u00a3",
            "\1\u00a4\37\uffff\1\u00a4",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00a6\37\uffff\1\u00a6",
            "\1\u00a7\37\uffff\1\u00a7",
            "\1\u00a8\37\uffff\1\u00a8",
            "\1\u00a9\37\uffff\1\u00a9",
            "\1\u00aa\37\uffff\1\u00aa",
            "\1\u00ab\37\uffff\1\u00ab",
            "\1\u00ac\37\uffff\1\u00ac",
            "\1\u00ad\37\uffff\1\u00ad",
            "\1\u00ae\37\uffff\1\u00ae",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00b0\37\uffff\1\u00b0",
            "\1\u00b1\37\uffff\1\u00b1",
            "\1\u00b2\37\uffff\1\u00b2",
            "\1\u00b3\37\uffff\1\u00b3",
            "\1\u00b4\37\uffff\1\u00b4",
            "\1\u00b5\37\uffff\1\u00b5",
            "",
            "\1\u00b6\37\uffff\1\u00b6",
            "",
            "",
            "\1\u00b7\37\uffff\1\u00b7",
            "",
            "",
            "",
            "",
            "",
            "\1\u00b8\37\uffff\1\u00b8",
            "",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00ba\37\uffff\1\u00ba",
            "",
            "\1\u00bb\37\uffff\1\u00bb",
            "\1\u00bc\37\uffff\1\u00bc",
            "\1\u00bd\37\uffff\1\u00bd",
            "\1\u00be\37\uffff\1\u00be",
            "\1\u00bf\37\uffff\1\u00bf",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00c1\37\uffff\1\u00c1",
            "",
            "\1\u00c2\37\uffff\1\u00c2",
            "\1\u00c3\37\uffff\1\u00c3",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00c6\37\uffff\1\u00c6",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00c8\37\uffff\1\u00c8",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00cc\37\uffff\1\u00cc",
            "\1\u00cd\37\uffff\1\u00cd",
            "\1\u00ce\37\uffff\1\u00ce",
            "\1\u00cf\37\uffff\1\u00cf",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00d1\37\uffff\1\u00d1",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00d3\37\uffff\1\u00d3",
            "",
            "\1\u00d4\37\uffff\1\u00d4",
            "\1\u00d5\37\uffff\1\u00d5",
            "\1\u00d6\37\uffff\1\u00d6",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "",
            "\1\u00da\37\uffff\1\u00da",
            "\1\u00db\37\uffff\1\u00db",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "",
            "",
            "",
            "\1\u00df\37\uffff\1\u00df",
            "\1\u00e0\37\uffff\1\u00e0",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00e5\37\uffff\1\u00e5",
            "\1\u00e6\37\uffff\1\u00e6",
            "\1\u00e7\37\uffff\1\u00e7",
            "",
            "",
            "",
            "\12\47\7\uffff\10\47\1\u00e9\21\47\4\uffff\1\47\1\uffff\10"+
            "\47\1\u00e9\21\47",
            "\1\u00ea\37\uffff\1\u00ea",
            "",
            "",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "",
            "",
            "",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00ef\37\uffff\1\u00ef",
            "",
            "\1\u00f0\37\uffff\1\u00f0",
            "\1\u00f1\37\uffff\1\u00f1",
            "",
            "",
            "",
            "",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00f3\37\uffff\1\u00f3",
            "\1\u00f4\37\uffff\1\u00f4",
            "",
            "\1\u00f5\37\uffff\1\u00f5",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            "\1\u00f7\37\uffff\1\u00f7",
            "",
            "\1\u00f8\37\uffff\1\u00f8",
            "\1\u00f9\37\uffff\1\u00f9",
            "\1\u00fa\37\uffff\1\u00fa",
            "\1\u00fb\37\uffff\1\u00fb",
            "\1\u00fc\37\uffff\1\u00fc",
            "\12\47\7\uffff\32\47\4\uffff\1\47\1\uffff\32\47",
            ""
    };

    static final short[] DFA24_eot = DFA.unpackEncodedString(DFA24_eotS);
    static final short[] DFA24_eof = DFA.unpackEncodedString(DFA24_eofS);
    static final char[] DFA24_min = DFA.unpackEncodedStringToUnsignedChars(DFA24_minS);
    static final char[] DFA24_max = DFA.unpackEncodedStringToUnsignedChars(DFA24_maxS);
    static final short[] DFA24_accept = DFA.unpackEncodedString(DFA24_acceptS);
    static final short[] DFA24_special = DFA.unpackEncodedString(DFA24_specialS);
    static final short[][] DFA24_transition;

    static {
        int numStates = DFA24_transitionS.length;
        DFA24_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA24_transition[i] = DFA.unpackEncodedString(DFA24_transitionS[i]);
        }
    }

    class DFA24 extends DFA {

        public DFA24(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 24;
            this.eot = DFA24_eot;
            this.eof = DFA24_eof;
            this.min = DFA24_min;
            this.max = DFA24_max;
            this.accept = DFA24_accept;
            this.special = DFA24_special;
            this.transition = DFA24_transition;
        }
        public String getDescription() {
            return "1:1: Tokens : ( DIV | MOD | AND | OR | XOR | SHL | SHR | NOT | ARRAY | OF | IN | SET | FILE | FOR | BEGIN | END | VAR | PROCEDURE | FUNCTION | CONST | OUT | FORWARD | STRING | NIL | USES | LABEL | GOTO | IF | THEN | ELSE | CASE | REPEAT | UNTIL | WHILE | DO | TO | DOWNTO | WITH | TRY | FINALLY | EXCEPT | RAISE | UNIT | RESULT | EXCEPTIONMESSAGE | FALSE | TRUE | BREAK | PLUS | MINUS | STAR | SLASH | AT | LSQBR | RSQBR | LPAREN | RPAREN | COMMA | SEMI | COLON | EQUAL | NOT_EQUAL | LT | LE | GE | GT | ASSIGN | AMPERSAND | DOTDOT | DOT | POINTER | ID | RANGE_OR_INT | COMMENT | WS | STRING_LITERAL | HEX );";
        }
    }
 

}