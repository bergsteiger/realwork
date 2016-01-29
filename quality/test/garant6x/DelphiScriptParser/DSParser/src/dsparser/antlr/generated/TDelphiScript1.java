// $ANTLR 3.3 Nov 30, 2010 12:45:30 W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g 2011-08-08 22:15:07

	package dsparser.antlr.generated;
	
	import dsparser.worker.*;	
	import dsparser.worker.AllUnits.Unit;	
	import dsparser.worker.BaseContext.IdType;
	import java.util.EnumSet;


import org.antlr.runtime.*;
import org.antlr.runtime.tree.*;import java.util.Stack;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
public class TDelphiScript1 extends TreeParser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "FORMAL_PARAMETER", "ACTUAL_PARAMETER", "METHOD_DECL", "METHOD_DEF", "BLOCK", "QUALIFIED_IDENT", "METHOD_CALL", "INDEX", "QUALIFIED_ACCESS", "IMPL_DECL", "CASE_SELECTOR", "CONST_ARRAY", "FORWARD", "SEMI", "BEGIN", "END", "COLON", "BREAK", "RAISE", "TRY", "FINALLY", "EXCEPT", "WITH", "DO", "FOR", "ASSIGN", "TO", "DOWNTO", "WHILE", "REPEAT", "UNTIL", "CASE", "OF", "ELSE", "COMMA", "IF", "THEN", "GOTO", "VAR", "LABEL", "INT", "USES", "PLUS", "MINUS", "OR", "XOR", "STAR", "SLASH", "DIV", "MOD", "AND", "SHL", "SHR", "DOT", "LSQBR", "RSQBR", "LPAREN", "RPAREN", "STRING_LITERAL", "NIL", "FALSE", "TRUE", "RESULT", "EXCEPTIONMESSAGE", "FLOAT", "HEX", "NOT", "ARRAY", "STRING", "CONST", "EQUAL", "PROCEDURE", "FUNCTION", "OUT", "FILE", "ID", "NOT_EQUAL", "LT", "LE", "GE", "GT", "IN", "DOTDOT", "D", "I", "V", "M", "O", "A", "N", "R", "X", "S", "H", "L", "T", "Y", "F", "E", "SET", "B", "G", "P", "C", "U", "W", "UNIT", "K", "AT", "AMPERSAND", "POINTER", "J", "Q", "Z", "EXPONENT", "RANGE_OR_INT", "COMMENT", "WS", "CHAR_LITERAL", "HEX_DIGIT"
    };
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


        public TDelphiScript1(TreeNodeStream input) {
            this(input, new RecognizerSharedState());
        }
        public TDelphiScript1(TreeNodeStream input, RecognizerSharedState state) {
            super(input, state);
            this.state.ruleMemo = new HashMap[17+1];
             
             
        }
        

    public String[] getTokenNames() { return TDelphiScript1.tokenNames; }
    public String getGrammarFileName() { return "W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g"; }


    	UnitContext unit_context;
    	
    	public TDelphiScript1(Unit unit)
    	{
    		this(unit.ast);
    		this.unit_context = unit.context;
    	}



    // $ANTLR start "tGoal"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:29:1: tGoal : ^( UNIT ( . )* ^( IMPL_DECL ( tImplementationDecl )* ) ) ;
    public final void tGoal() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:30:2: ( ^( UNIT ( . )* ^( IMPL_DECL ( tImplementationDecl )* ) ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:30:4: ^( UNIT ( . )* ^( IMPL_DECL ( tImplementationDecl )* ) )
            {
            match(input,UNIT,FOLLOW_UNIT_in_tGoal45); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:30:11: ( . )*
            loop1:
            do {
                int alt1=2;
                int LA1_0 = input.LA(1);

                if ( (LA1_0==IMPL_DECL) ) {
                    alt1=2;
                }
                else if ( ((LA1_0>=FORMAL_PARAMETER && LA1_0<=QUALIFIED_ACCESS)||(LA1_0>=CASE_SELECTOR && LA1_0<=HEX_DIGIT)) ) {
                    alt1=1;
                }


                switch (alt1) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:30:11: .
            	    {
            	    matchAny(input); if (state.failed) return ;

            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);

            match(input,IMPL_DECL,FOLLOW_IMPL_DECL_in_tGoal51); if (state.failed) return ;

            if ( input.LA(1)==Token.DOWN ) {
                match(input, Token.DOWN, null); if (state.failed) return ;
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:30:26: ( tImplementationDecl )*
                loop2:
                do {
                    int alt2=2;
                    int LA2_0 = input.LA(1);

                    if ( ((LA2_0>=METHOD_DECL && LA2_0<=METHOD_DEF)||(LA2_0>=VAR && LA2_0<=LABEL)||LA2_0==CONST) ) {
                        alt2=1;
                    }


                    switch (alt2) {
                	case 1 :
                	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:30:26: tImplementationDecl
                	    {
                	    pushFollow(FOLLOW_tImplementationDecl_in_tGoal53);
                	    tImplementationDecl();

                	    state._fsp--;
                	    if (state.failed) return ;

                	    }
                	    break;

                	default :
                	    break loop2;
                    }
                } while (true);


                match(input, Token.UP, null); if (state.failed) return ;
            }

            match(input, Token.UP, null); if (state.failed) return ;

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "tGoal"


    // $ANTLR start "tImplementationDecl"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:33:1: tImplementationDecl : ( ^( CONST tConstantDecl ) | ^( METHOD_DEF ( . )* ) | ^( METHOD_DECL ( . )* ) | ^( VAR ( . )* ) | ^( LABEL ( . )* ) );
    public final void tImplementationDecl() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:34:2: ( ^( CONST tConstantDecl ) | ^( METHOD_DEF ( . )* ) | ^( METHOD_DECL ( . )* ) | ^( VAR ( . )* ) | ^( LABEL ( . )* ) )
            int alt7=5;
            switch ( input.LA(1) ) {
            case CONST:
                {
                alt7=1;
                }
                break;
            case METHOD_DEF:
                {
                alt7=2;
                }
                break;
            case METHOD_DECL:
                {
                alt7=3;
                }
                break;
            case VAR:
                {
                alt7=4;
                }
                break;
            case LABEL:
                {
                alt7=5;
                }
                break;
            default:
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 7, 0, input);

                throw nvae;
            }

            switch (alt7) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:34:4: ^( CONST tConstantDecl )
                    {
                    match(input,CONST,FOLLOW_CONST_in_tImplementationDecl70); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tConstantDecl_in_tImplementationDecl72);
                    tConstantDecl();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:35:4: ^( METHOD_DEF ( . )* )
                    {
                    match(input,METHOD_DEF,FOLLOW_METHOD_DEF_in_tImplementationDecl79); if (state.failed) return ;

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:35:17: ( . )*
                        loop3:
                        do {
                            int alt3=2;
                            int LA3_0 = input.LA(1);

                            if ( ((LA3_0>=FORMAL_PARAMETER && LA3_0<=HEX_DIGIT)) ) {
                                alt3=1;
                            }
                            else if ( (LA3_0==UP) ) {
                                alt3=2;
                            }


                            switch (alt3) {
                        	case 1 :
                        	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:35:17: .
                        	    {
                        	    matchAny(input); if (state.failed) return ;

                        	    }
                        	    break;

                        	default :
                        	    break loop3;
                            }
                        } while (true);


                        match(input, Token.UP, null); if (state.failed) return ;
                    }

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:36:4: ^( METHOD_DECL ( . )* )
                    {
                    match(input,METHOD_DECL,FOLLOW_METHOD_DECL_in_tImplementationDecl89); if (state.failed) return ;

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:36:18: ( . )*
                        loop4:
                        do {
                            int alt4=2;
                            int LA4_0 = input.LA(1);

                            if ( ((LA4_0>=FORMAL_PARAMETER && LA4_0<=HEX_DIGIT)) ) {
                                alt4=1;
                            }
                            else if ( (LA4_0==UP) ) {
                                alt4=2;
                            }


                            switch (alt4) {
                        	case 1 :
                        	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:36:18: .
                        	    {
                        	    matchAny(input); if (state.failed) return ;

                        	    }
                        	    break;

                        	default :
                        	    break loop4;
                            }
                        } while (true);


                        match(input, Token.UP, null); if (state.failed) return ;
                    }

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:37:4: ^( VAR ( . )* )
                    {
                    match(input,VAR,FOLLOW_VAR_in_tImplementationDecl100); if (state.failed) return ;

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:37:10: ( . )*
                        loop5:
                        do {
                            int alt5=2;
                            int LA5_0 = input.LA(1);

                            if ( ((LA5_0>=FORMAL_PARAMETER && LA5_0<=HEX_DIGIT)) ) {
                                alt5=1;
                            }
                            else if ( (LA5_0==UP) ) {
                                alt5=2;
                            }


                            switch (alt5) {
                        	case 1 :
                        	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:37:10: .
                        	    {
                        	    matchAny(input); if (state.failed) return ;

                        	    }
                        	    break;

                        	default :
                        	    break loop5;
                            }
                        } while (true);


                        match(input, Token.UP, null); if (state.failed) return ;
                    }

                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:38:4: ^( LABEL ( . )* )
                    {
                    match(input,LABEL,FOLLOW_LABEL_in_tImplementationDecl110); if (state.failed) return ;

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:38:12: ( . )*
                        loop6:
                        do {
                            int alt6=2;
                            int LA6_0 = input.LA(1);

                            if ( ((LA6_0>=FORMAL_PARAMETER && LA6_0<=HEX_DIGIT)) ) {
                                alt6=1;
                            }
                            else if ( (LA6_0==UP) ) {
                                alt6=2;
                            }


                            switch (alt6) {
                        	case 1 :
                        	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:38:12: .
                        	    {
                        	    matchAny(input); if (state.failed) return ;

                        	    }
                        	    break;

                        	default :
                        	    break loop6;
                            }
                        } while (true);


                        match(input, Token.UP, null); if (state.failed) return ;
                    }

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "tImplementationDecl"


    // $ANTLR start "tConstSection"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:41:1: tConstSection : ^( CONST tConstantDecl ) ;
    public final void tConstSection() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:42:2: ( ^( CONST tConstantDecl ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:42:4: ^( CONST tConstantDecl )
            {
            match(input,CONST,FOLLOW_CONST_in_tConstSection126); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tConstantDecl_in_tConstSection128);
            tConstantDecl();

            state._fsp--;
            if (state.failed) return ;

            match(input, Token.UP, null); if (state.failed) return ;

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "tConstSection"


    // $ANTLR start "tConstantDecl"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:45:1: tConstantDecl : id= tIdent tc= tTypedConstant ;
    public final void tConstantDecl() throws RecognitionException {
        TDelphiScript1.tIdent_return id = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:46:2: (id= tIdent tc= tTypedConstant )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:46:4: id= tIdent tc= tTypedConstant
            {
            pushFollow(FOLLOW_tIdent_in_tConstantDecl143);
            id=tIdent();

            state._fsp--;
            if (state.failed) return ;
            pushFollow(FOLLOW_tTypedConstant_in_tConstantDecl147);
            tTypedConstant();

            state._fsp--;
            if (state.failed) return ;
            if ( state.backtracking==0 ) {

              			unit_context.ConstDeclared(
              				(id!=null?(input.getTokenStream().toString(
                input.getTreeAdaptor().getTokenStartIndex(id.start),
                input.getTreeAdaptor().getTokenStopIndex(id.start))):null),
              				(id!=null?((CommonTree)id.start):null).getLine(),
              				(id!=null?((CommonTree)id.start):null).getCharPositionInLine()
              			);
              		
            }

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "tConstantDecl"


    // $ANTLR start "tTypedConstant"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:56:1: tTypedConstant : tExpression ;
    public final void tTypedConstant() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:57:2: ( tExpression )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:57:4: tExpression
            {
            pushFollow(FOLLOW_tExpression_in_tTypedConstant163);
            tExpression();

            state._fsp--;
            if (state.failed) return ;

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "tTypedConstant"


    // $ANTLR start "tExpression"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:61:1: tExpression options {backtrack=true; memoize=true; } : ( tAtom | ^( tRelOp tExpression tExpression ) | ^( tMulOp tExpression tExpression ) | ^( tAddOp tExpression tExpression ) | ^( tUnaryOperator tExpression ) );
    public final void tExpression() throws RecognitionException {
        int tExpression_StartIndex = input.index();
        try {
            if ( state.backtracking>0 && alreadyParsedRule(input, 6) ) { return ; }
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:66:2: ( tAtom | ^( tRelOp tExpression tExpression ) | ^( tMulOp tExpression tExpression ) | ^( tAddOp tExpression tExpression ) | ^( tUnaryOperator tExpression ) )
            int alt8=5;
            alt8 = dfa8.predict(input);
            switch (alt8) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:66:4: tAtom
                    {
                    pushFollow(FOLLOW_tAtom_in_tExpression197);
                    tAtom();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:67:4: ^( tRelOp tExpression tExpression )
                    {
                    pushFollow(FOLLOW_tRelOp_in_tExpression203);
                    tRelOp();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression205);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression207);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:68:4: ^( tMulOp tExpression tExpression )
                    {
                    pushFollow(FOLLOW_tMulOp_in_tExpression214);
                    tMulOp();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression216);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression218);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:69:4: ^( tAddOp tExpression tExpression )
                    {
                    pushFollow(FOLLOW_tAddOp_in_tExpression225);
                    tAddOp();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression227);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression229);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:70:4: ^( tUnaryOperator tExpression )
                    {
                    pushFollow(FOLLOW_tUnaryOperator_in_tExpression236);
                    tUnaryOperator();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression238);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
            if ( state.backtracking>0 ) { memoize(input, 6, tExpression_StartIndex); }
        }
        return ;
    }
    // $ANTLR end "tExpression"


    // $ANTLR start "tAtom"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:73:1: tAtom : ( tIdent | tNumber | NIL | TRUE | FALSE | STRING_LITERAL );
    public final void tAtom() throws RecognitionException {
        TDelphiScript1.tIdent_return tIdent1 = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:74:2: ( tIdent | tNumber | NIL | TRUE | FALSE | STRING_LITERAL )
            int alt9=6;
            switch ( input.LA(1) ) {
            case ID:
                {
                alt9=1;
                }
                break;
            case INT:
            case FLOAT:
            case HEX:
                {
                alt9=2;
                }
                break;
            case NIL:
                {
                alt9=3;
                }
                break;
            case TRUE:
                {
                alt9=4;
                }
                break;
            case FALSE:
                {
                alt9=5;
                }
                break;
            case STRING_LITERAL:
                {
                alt9=6;
                }
                break;
            default:
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 9, 0, input);

                throw nvae;
            }

            switch (alt9) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:74:4: tIdent
                    {
                    pushFollow(FOLLOW_tIdent_in_tAtom251);
                    tIdent1=tIdent();

                    state._fsp--;
                    if (state.failed) return ;
                    if ( state.backtracking==0 ) {

                      			unit_context.IdUsed(
                      				(tIdent1!=null?(input.getTokenStream().toString(
                        input.getTreeAdaptor().getTokenStartIndex(tIdent1.start),
                        input.getTreeAdaptor().getTokenStopIndex(tIdent1.start))):null),
                      				(tIdent1!=null?((CommonTree)tIdent1.start):null).getLine(),
                      				(tIdent1!=null?((CommonTree)tIdent1.start):null).getCharPositionInLine(),
                      				EnumSet.of(IdType.CONST)
                      			);
                      		
                    }

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:83:4: tNumber
                    {
                    pushFollow(FOLLOW_tNumber_in_tAtom261);
                    tNumber();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:84:4: NIL
                    {
                    match(input,NIL,FOLLOW_NIL_in_tAtom266); if (state.failed) return ;

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:85:4: TRUE
                    {
                    match(input,TRUE,FOLLOW_TRUE_in_tAtom271); if (state.failed) return ;

                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:86:4: FALSE
                    {
                    match(input,FALSE,FOLLOW_FALSE_in_tAtom276); if (state.failed) return ;

                    }
                    break;
                case 6 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:87:4: STRING_LITERAL
                    {
                    match(input,STRING_LITERAL,FOLLOW_STRING_LITERAL_in_tAtom281); if (state.failed) return ;

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "tAtom"


    // $ANTLR start "tNumber"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:90:1: tNumber : ( INT | FLOAT | HEX );
    public final void tNumber() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:91:2: ( INT | FLOAT | HEX )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:
            {
            if ( input.LA(1)==INT||(input.LA(1)>=FLOAT && input.LA(1)<=HEX) ) {
                input.consume();
                state.errorRecovery=false;state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                throw mse;
            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "tNumber"


    // $ANTLR start "tUnaryOperator"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:96:1: tUnaryOperator : ( NOT | MINUS );
    public final void tUnaryOperator() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:97:2: ( NOT | MINUS )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:
            {
            if ( input.LA(1)==MINUS||input.LA(1)==NOT ) {
                input.consume();
                state.errorRecovery=false;state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                throw mse;
            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "tUnaryOperator"


    // $ANTLR start "tAddOp"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:101:1: tAddOp : ( PLUS | MINUS | OR | XOR );
    public final void tAddOp() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:102:2: ( PLUS | MINUS | OR | XOR )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:
            {
            if ( (input.LA(1)>=PLUS && input.LA(1)<=XOR) ) {
                input.consume();
                state.errorRecovery=false;state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                throw mse;
            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "tAddOp"


    // $ANTLR start "tMulOp"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:108:1: tMulOp : ( STAR | SLASH | DIV | MOD | AND | SHL | SHR );
    public final void tMulOp() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:109:2: ( STAR | SLASH | DIV | MOD | AND | SHL | SHR )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:
            {
            if ( (input.LA(1)>=STAR && input.LA(1)<=SHR) ) {
                input.consume();
                state.errorRecovery=false;state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                throw mse;
            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "tMulOp"


    // $ANTLR start "tRelOp"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:118:1: tRelOp : ( EQUAL | NOT_EQUAL | LT | LE | GE | GT | IN );
    public final void tRelOp() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:119:2: ( EQUAL | NOT_EQUAL | LT | LE | GE | GT | IN )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:
            {
            if ( input.LA(1)==EQUAL||(input.LA(1)>=NOT_EQUAL && input.LA(1)<=IN) ) {
                input.consume();
                state.errorRecovery=false;state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                throw mse;
            }


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "tRelOp"

    public static class tIdent_return extends TreeRuleReturnScope {
    };

    // $ANTLR start "tIdent"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:128:1: tIdent : ID ;
    public final TDelphiScript1.tIdent_return tIdent() throws RecognitionException {
        TDelphiScript1.tIdent_return retval = new TDelphiScript1.tIdent_return();
        retval.start = input.LT(1);

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:129:2: ( ID )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:129:4: ID
            {
            match(input,ID,FOLLOW_ID_in_tIdent447); if (state.failed) return retval;

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "tIdent"

    // $ANTLR start synpred4_TDelphiScript1
    public final void synpred4_TDelphiScript1_fragment() throws RecognitionException {   
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:69:4: ( ^( tAddOp tExpression tExpression ) )
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript1.g:69:4: ^( tAddOp tExpression tExpression )
        {
        pushFollow(FOLLOW_tAddOp_in_synpred4_TDelphiScript1225);
        tAddOp();

        state._fsp--;
        if (state.failed) return ;

        match(input, Token.DOWN, null); if (state.failed) return ;
        pushFollow(FOLLOW_tExpression_in_synpred4_TDelphiScript1227);
        tExpression();

        state._fsp--;
        if (state.failed) return ;
        pushFollow(FOLLOW_tExpression_in_synpred4_TDelphiScript1229);
        tExpression();

        state._fsp--;
        if (state.failed) return ;

        match(input, Token.UP, null); if (state.failed) return ;

        }
    }
    // $ANTLR end synpred4_TDelphiScript1

    // Delegated rules

    public final boolean synpred4_TDelphiScript1() {
        state.backtracking++;
        int start = input.mark();
        try {
            synpred4_TDelphiScript1_fragment(); // can never throw exception
        } catch (RecognitionException re) {
            System.err.println("impossible: "+re);
        }
        boolean success = !state.failed;
        input.rewind(start);
        state.backtracking--;
        state.failed=false;
        return success;
    }


    protected DFA8 dfa8 = new DFA8(this);
    static final String DFA8_eotS =
        "\14\uffff";
    static final String DFA8_eofS =
        "\14\uffff";
    static final String DFA8_minS =
        "\1\54\10\uffff\1\0\2\uffff";
    static final String DFA8_maxS =
        "\1\125\10\uffff\1\0\2\uffff";
    static final String DFA8_acceptS =
        "\1\uffff\1\1\5\uffff\1\2\1\3\1\uffff\1\4\1\5";
    static final String DFA8_specialS =
        "\11\uffff\1\0\2\uffff}>";
    static final String[] DFA8_transitionS = {
            "\1\1\1\uffff\1\12\1\11\2\12\7\10\5\uffff\4\1\2\uffff\2\1\1"+
            "\13\3\uffff\1\7\4\uffff\1\1\6\7",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "\1\uffff",
            "",
            ""
    };

    static final short[] DFA8_eot = DFA.unpackEncodedString(DFA8_eotS);
    static final short[] DFA8_eof = DFA.unpackEncodedString(DFA8_eofS);
    static final char[] DFA8_min = DFA.unpackEncodedStringToUnsignedChars(DFA8_minS);
    static final char[] DFA8_max = DFA.unpackEncodedStringToUnsignedChars(DFA8_maxS);
    static final short[] DFA8_accept = DFA.unpackEncodedString(DFA8_acceptS);
    static final short[] DFA8_special = DFA.unpackEncodedString(DFA8_specialS);
    static final short[][] DFA8_transition;

    static {
        int numStates = DFA8_transitionS.length;
        DFA8_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA8_transition[i] = DFA.unpackEncodedString(DFA8_transitionS[i]);
        }
    }

    class DFA8 extends DFA {

        public DFA8(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 8;
            this.eot = DFA8_eot;
            this.eof = DFA8_eof;
            this.min = DFA8_min;
            this.max = DFA8_max;
            this.accept = DFA8_accept;
            this.special = DFA8_special;
            this.transition = DFA8_transition;
        }
        public String getDescription() {
            return "61:1: tExpression options {backtrack=true; memoize=true; } : ( tAtom | ^( tRelOp tExpression tExpression ) | ^( tMulOp tExpression tExpression ) | ^( tAddOp tExpression tExpression ) | ^( tUnaryOperator tExpression ) );";
        }
        public int specialStateTransition(int s, IntStream _input) throws NoViableAltException {
            TreeNodeStream input = (TreeNodeStream)_input;
        	int _s = s;
            switch ( s ) {
                    case 0 : 
                        int LA8_9 = input.LA(1);

                         
                        int index8_9 = input.index();
                        input.rewind();
                        s = -1;
                        if ( (synpred4_TDelphiScript1()) ) {s = 10;}

                        else if ( (true) ) {s = 11;}

                         
                        input.seek(index8_9);
                        if ( s>=0 ) return s;
                        break;
            }
            if (state.backtracking>0) {state.failed=true; return -1;}
            NoViableAltException nvae =
                new NoViableAltException(getDescription(), 8, _s, input);
            error(nvae);
            throw nvae;
        }
    }
 

    public static final BitSet FOLLOW_UNIT_in_tGoal45 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_IMPL_DECL_in_tGoal51 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tImplementationDecl_in_tGoal53 = new BitSet(new long[]{0x00000C00000000C8L,0x0000000000000200L});
    public static final BitSet FOLLOW_CONST_in_tImplementationDecl70 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tConstantDecl_in_tImplementationDecl72 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_METHOD_DEF_in_tImplementationDecl79 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_METHOD_DECL_in_tImplementationDecl89 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_VAR_in_tImplementationDecl100 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_LABEL_in_tImplementationDecl110 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_CONST_in_tConstSection126 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tConstantDecl_in_tConstSection128 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tIdent_in_tConstantDecl143 = new BitSet(new long[]{0xC1FFD00000000000L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tTypedConstant_in_tConstantDecl147 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tExpression_in_tTypedConstant163 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tAtom_in_tExpression197 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tRelOp_in_tExpression203 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression205 = new BitSet(new long[]{0xC1FFD00000000000L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tExpression_in_tExpression207 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tMulOp_in_tExpression214 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression216 = new BitSet(new long[]{0xC1FFD00000000000L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tExpression_in_tExpression218 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tAddOp_in_tExpression225 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression227 = new BitSet(new long[]{0xC1FFD00000000000L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tExpression_in_tExpression229 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tUnaryOperator_in_tExpression236 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression238 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tIdent_in_tAtom251 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tNumber_in_tAtom261 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_NIL_in_tAtom266 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_TRUE_in_tAtom271 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_FALSE_in_tAtom276 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_LITERAL_in_tAtom281 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tNumber0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tUnaryOperator0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tAddOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tMulOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tRelOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_tIdent447 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tAddOp_in_synpred4_TDelphiScript1225 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_synpred4_TDelphiScript1227 = new BitSet(new long[]{0xC1FFD00000000000L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tExpression_in_synpred4_TDelphiScript1229 = new BitSet(new long[]{0x0000000000000008L});

}