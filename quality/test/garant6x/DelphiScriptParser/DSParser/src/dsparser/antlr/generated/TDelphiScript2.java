// $ANTLR 3.3 Nov 30, 2010 12:45:30 W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g 2011-08-08 22:15:14

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
public class TDelphiScript2 extends TreeParser {
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

    protected static class SIdCheckControl_scope {
        boolean is_skip;
        EnumSet<IdType> id_type;
    }
    protected Stack SIdCheckControl_stack = new Stack();


        public TDelphiScript2(TreeNodeStream input) {
            this(input, new RecognizerSharedState());
        }
        public TDelphiScript2(TreeNodeStream input, RecognizerSharedState state) {
            super(input, state);
            this.state.ruleMemo = new HashMap[22+1];
             
             
        }
        

    public String[] getTokenNames() { return TDelphiScript2.tokenNames; }
    public String getGrammarFileName() { return "W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g"; }


    	UnitContext unit_context;
    	
    	public TDelphiScript2(Unit unit)
    	{
    		this(unit.ast);
    		this.unit_context = unit.context;
    	}



    // $ANTLR start "tGoal"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:35:1: tGoal : ^( UNIT ( . )* ^( IMPL_DECL ( tImplementationDecl )* ) ) ;
    public final void tGoal() throws RecognitionException {
        SIdCheckControl_stack.push(new SIdCheckControl_scope());


        	((SIdCheckControl_scope)SIdCheckControl_stack.peek()).is_skip = false;
        	((SIdCheckControl_scope)SIdCheckControl_stack.peek()).id_type = EnumSet.of(IdType.CONST);

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:41:2: ( ^( UNIT ( . )* ^( IMPL_DECL ( tImplementationDecl )* ) ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:41:4: ^( UNIT ( . )* ^( IMPL_DECL ( tImplementationDecl )* ) )
            {
            match(input,UNIT,FOLLOW_UNIT_in_tGoal63); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:41:11: ( . )*
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
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:41:11: .
            	    {
            	    matchAny(input); if (state.failed) return ;

            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);

            match(input,IMPL_DECL,FOLLOW_IMPL_DECL_in_tGoal69); if (state.failed) return ;

            if ( input.LA(1)==Token.DOWN ) {
                match(input, Token.DOWN, null); if (state.failed) return ;
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:41:26: ( tImplementationDecl )*
                loop2:
                do {
                    int alt2=2;
                    int LA2_0 = input.LA(1);

                    if ( ((LA2_0>=METHOD_DECL && LA2_0<=METHOD_DEF)||(LA2_0>=VAR && LA2_0<=LABEL)||LA2_0==CONST) ) {
                        alt2=1;
                    }


                    switch (alt2) {
                	case 1 :
                	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:41:26: tImplementationDecl
                	    {
                	    pushFollow(FOLLOW_tImplementationDecl_in_tGoal71);
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
            SIdCheckControl_stack.pop();

        }
        return ;
    }
    // $ANTLR end "tGoal"


    // $ANTLR start "tImplementationDecl"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:44:1: tImplementationDecl : ( ^( CONST tConstantDecl ) | ^( METHOD_DEF tMethodHeading[false] ( . )* ) | ^( METHOD_DECL tMethodHeading[true] ) | ^( VAR tVarDecl ) | ^( LABEL ( . )* ) );
    public final void tImplementationDecl() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:45:2: ( ^( CONST tConstantDecl ) | ^( METHOD_DEF tMethodHeading[false] ( . )* ) | ^( METHOD_DECL tMethodHeading[true] ) | ^( VAR tVarDecl ) | ^( LABEL ( . )* ) )
            int alt5=5;
            switch ( input.LA(1) ) {
            case CONST:
                {
                alt5=1;
                }
                break;
            case METHOD_DEF:
                {
                alt5=2;
                }
                break;
            case METHOD_DECL:
                {
                alt5=3;
                }
                break;
            case VAR:
                {
                alt5=4;
                }
                break;
            case LABEL:
                {
                alt5=5;
                }
                break;
            default:
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 5, 0, input);

                throw nvae;
            }

            switch (alt5) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:45:4: ^( CONST tConstantDecl )
                    {
                    match(input,CONST,FOLLOW_CONST_in_tImplementationDecl88); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tConstantDecl_in_tImplementationDecl90);
                    tConstantDecl();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:46:4: ^( METHOD_DEF tMethodHeading[false] ( . )* )
                    {
                    match(input,METHOD_DEF,FOLLOW_METHOD_DEF_in_tImplementationDecl97); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tMethodHeading_in_tImplementationDecl99);
                    tMethodHeading(false);

                    state._fsp--;
                    if (state.failed) return ;
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:46:39: ( . )*
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
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:46:39: .
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
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:47:4: ^( METHOD_DECL tMethodHeading[true] )
                    {
                    match(input,METHOD_DECL,FOLLOW_METHOD_DECL_in_tImplementationDecl110); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tMethodHeading_in_tImplementationDecl112);
                    tMethodHeading(true);

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:48:4: ^( VAR tVarDecl )
                    {
                    match(input,VAR,FOLLOW_VAR_in_tImplementationDecl121); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tVarDecl_in_tImplementationDecl123);
                    tVarDecl();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:49:4: ^( LABEL ( . )* )
                    {
                    match(input,LABEL,FOLLOW_LABEL_in_tImplementationDecl130); if (state.failed) return ;

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:49:12: ( . )*
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
                        	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:49:12: .
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


    // $ANTLR start "tMethodHeading"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:52:1: tMethodHeading[Boolean is_decl] : ^( ( PROCEDURE | FUNCTION ) name= tIdent ( tFormalParameter )* (ret_type= tType )? ) ;
    public final void tMethodHeading(Boolean is_decl) throws RecognitionException {
        TDelphiScript2.tIdent_return name = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:53:2: ( ^( ( PROCEDURE | FUNCTION ) name= tIdent ( tFormalParameter )* (ret_type= tType )? ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:53:4: ^( ( PROCEDURE | FUNCTION ) name= tIdent ( tFormalParameter )* (ret_type= tType )? )
            {
            if ( (input.LA(1)>=PROCEDURE && input.LA(1)<=FUNCTION) ) {
                input.consume();
                state.errorRecovery=false;state.failed=false;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                MismatchedSetException mse = new MismatchedSetException(null,input);
                throw mse;
            }


            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tIdent_in_tMethodHeading156);
            name=tIdent();

            state._fsp--;
            if (state.failed) return ;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:53:39: ( tFormalParameter )*
            loop6:
            do {
                int alt6=2;
                int LA6_0 = input.LA(1);

                if ( (LA6_0==FORMAL_PARAMETER) ) {
                    alt6=1;
                }


                switch (alt6) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:53:39: tFormalParameter
            	    {
            	    pushFollow(FOLLOW_tFormalParameter_in_tMethodHeading158);
            	    tFormalParameter();

            	    state._fsp--;
            	    if (state.failed) return ;

            	    }
            	    break;

            	default :
            	    break loop6;
                }
            } while (true);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:53:65: (ret_type= tType )?
            int alt7=2;
            int LA7_0 = input.LA(1);

            if ( ((LA7_0>=ARRAY && LA7_0<=STRING)||(LA7_0>=FILE && LA7_0<=ID)) ) {
                alt7=1;
            }
            switch (alt7) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:53:65: ret_type= tType
                    {
                    pushFollow(FOLLOW_tType_in_tMethodHeading163);
                    tType();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;

            }


            match(input, Token.UP, null); if (state.failed) return ;
            if ( state.backtracking==0 ) {

              			if (is_decl)
              				unit_context.MethodDeclared(
              					(name!=null?(input.getTokenStream().toString(
                input.getTreeAdaptor().getTokenStartIndex(name.start),
                input.getTreeAdaptor().getTokenStopIndex(name.start))):null),
              					(name!=null?((CommonTree)name.start):null).getLine(),
              					(name!=null?((CommonTree)name.start):null).getCharPositionInLine()
              				);
              			else
              				unit_context.MethodDefined(
              					(name!=null?(input.getTokenStream().toString(
                input.getTreeAdaptor().getTokenStartIndex(name.start),
                input.getTreeAdaptor().getTokenStopIndex(name.start))):null),
              					(name!=null?((CommonTree)name.start):null).getLine(),
              					(name!=null?((CommonTree)name.start):null).getCharPositionInLine()
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
    // $ANTLR end "tMethodHeading"


    // $ANTLR start "tFormalParameter"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:71:1: tFormalParameter : ^( FORMAL_PARAMETER tIdent ( tType )? ( tTypedConstant )? ) ;
    public final void tFormalParameter() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:72:2: ( ^( FORMAL_PARAMETER tIdent ( tType )? ( tTypedConstant )? ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:72:4: ^( FORMAL_PARAMETER tIdent ( tType )? ( tTypedConstant )? )
            {
            match(input,FORMAL_PARAMETER,FOLLOW_FORMAL_PARAMETER_in_tFormalParameter181); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tIdent_in_tFormalParameter183);
            tIdent();

            state._fsp--;
            if (state.failed) return ;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:72:30: ( tType )?
            int alt8=2;
            int LA8_0 = input.LA(1);

            if ( ((LA8_0>=ARRAY && LA8_0<=STRING)||(LA8_0>=FILE && LA8_0<=ID)) ) {
                alt8=1;
            }
            switch (alt8) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:72:30: tType
                    {
                    pushFollow(FOLLOW_tType_in_tFormalParameter185);
                    tType();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;

            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:72:37: ( tTypedConstant )?
            int alt9=2;
            int LA9_0 = input.LA(1);

            if ( (LA9_0==INT||(LA9_0>=PLUS && LA9_0<=SHR)||(LA9_0>=STRING_LITERAL && LA9_0<=TRUE)||(LA9_0>=FLOAT && LA9_0<=NOT)||LA9_0==EQUAL||(LA9_0>=ID && LA9_0<=IN)) ) {
                alt9=1;
            }
            switch (alt9) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:72:37: tTypedConstant
                    {
                    pushFollow(FOLLOW_tTypedConstant_in_tFormalParameter188);
                    tTypedConstant();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;

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
    // $ANTLR end "tFormalParameter"


    // $ANTLR start "tVarDecl"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:75:1: tVarDecl : id= tIdent (type= tType )? ;
    public final void tVarDecl() throws RecognitionException {
        TDelphiScript2.tIdent_return id = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:76:2: (id= tIdent (type= tType )? )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:76:4: id= tIdent (type= tType )?
            {
            pushFollow(FOLLOW_tIdent_in_tVarDecl203);
            id=tIdent();

            state._fsp--;
            if (state.failed) return ;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:76:18: (type= tType )?
            int alt10=2;
            int LA10_0 = input.LA(1);

            if ( ((LA10_0>=ARRAY && LA10_0<=STRING)||(LA10_0>=FILE && LA10_0<=ID)) ) {
                alt10=1;
            }
            switch (alt10) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:76:18: type= tType
                    {
                    pushFollow(FOLLOW_tType_in_tVarDecl207);
                    tType();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;

            }

            if ( state.backtracking==0 ) {

              			unit_context.VarDeclared(
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
    // $ANTLR end "tVarDecl"


    // $ANTLR start "tType"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:86:1: tType : ( tIdent | ^( ARRAY ( tExpressionOrRange )* tType ) | ( FILE | FILE OF tIdent ) | STRING );
    public final void tType() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:87:2: ( tIdent | ^( ARRAY ( tExpressionOrRange )* tType ) | ( FILE | FILE OF tIdent ) | STRING )
            int alt13=4;
            switch ( input.LA(1) ) {
            case ID:
                {
                alt13=1;
                }
                break;
            case ARRAY:
                {
                alt13=2;
                }
                break;
            case FILE:
                {
                alt13=3;
                }
                break;
            case STRING:
                {
                alt13=4;
                }
                break;
            default:
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 13, 0, input);

                throw nvae;
            }

            switch (alt13) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:87:4: tIdent
                    {
                    pushFollow(FOLLOW_tIdent_in_tType223);
                    tIdent();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:88:4: ^( ARRAY ( tExpressionOrRange )* tType )
                    {
                    match(input,ARRAY,FOLLOW_ARRAY_in_tType229); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:88:12: ( tExpressionOrRange )*
                    loop11:
                    do {
                        int alt11=2;
                        int LA11_0 = input.LA(1);

                        if ( (LA11_0==DOTDOT) ) {
                            alt11=1;
                        }


                        switch (alt11) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:88:12: tExpressionOrRange
                    	    {
                    	    pushFollow(FOLLOW_tExpressionOrRange_in_tType231);
                    	    tExpressionOrRange();

                    	    state._fsp--;
                    	    if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    break loop11;
                        }
                    } while (true);

                    pushFollow(FOLLOW_tType_in_tType234);
                    tType();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:89:4: ( FILE | FILE OF tIdent )
                    {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:89:4: ( FILE | FILE OF tIdent )
                    int alt12=2;
                    int LA12_0 = input.LA(1);

                    if ( (LA12_0==FILE) ) {
                        int LA12_1 = input.LA(2);

                        if ( (LA12_1==OF) ) {
                            alt12=2;
                        }
                        else if ( (LA12_1==UP||LA12_1==INT||(LA12_1>=PLUS && LA12_1<=SHR)||(LA12_1>=STRING_LITERAL && LA12_1<=TRUE)||(LA12_1>=FLOAT && LA12_1<=NOT)||LA12_1==EQUAL||(LA12_1>=ID && LA12_1<=IN)) ) {
                            alt12=1;
                        }
                        else {
                            if (state.backtracking>0) {state.failed=true; return ;}
                            NoViableAltException nvae =
                                new NoViableAltException("", 12, 1, input);

                            throw nvae;
                        }
                    }
                    else {
                        if (state.backtracking>0) {state.failed=true; return ;}
                        NoViableAltException nvae =
                            new NoViableAltException("", 12, 0, input);

                        throw nvae;
                    }
                    switch (alt12) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:89:5: FILE
                            {
                            match(input,FILE,FOLLOW_FILE_in_tType241); if (state.failed) return ;

                            }
                            break;
                        case 2 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:89:11: FILE OF tIdent
                            {
                            match(input,FILE,FOLLOW_FILE_in_tType244); if (state.failed) return ;
                            match(input,OF,FOLLOW_OF_in_tType246); if (state.failed) return ;
                            pushFollow(FOLLOW_tIdent_in_tType248);
                            tIdent();

                            state._fsp--;
                            if (state.failed) return ;

                            }
                            break;

                    }


                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:90:4: STRING
                    {
                    match(input,STRING,FOLLOW_STRING_in_tType254); if (state.failed) return ;

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
    // $ANTLR end "tType"


    // $ANTLR start "tExpressionOrRange"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:93:1: tExpressionOrRange : ^( DOTDOT tExpression tExpression ) ;
    public final void tExpressionOrRange() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:94:2: ( ^( DOTDOT tExpression tExpression ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:94:4: ^( DOTDOT tExpression tExpression )
            {
            match(input,DOTDOT,FOLLOW_DOTDOT_in_tExpressionOrRange266); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tExpression_in_tExpressionOrRange268);
            tExpression();

            state._fsp--;
            if (state.failed) return ;
            pushFollow(FOLLOW_tExpression_in_tExpressionOrRange270);
            tExpression();

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
    // $ANTLR end "tExpressionOrRange"


    // $ANTLR start "tConstSection"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:97:1: tConstSection : ^( CONST tConstantDecl ) ;
    public final void tConstSection() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:98:2: ( ^( CONST tConstantDecl ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:98:4: ^( CONST tConstantDecl )
            {
            match(input,CONST,FOLLOW_CONST_in_tConstSection283); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tConstantDecl_in_tConstSection285);
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:101:1: tConstantDecl : id= tIdent tc= tTypedConstant ;
    public final void tConstantDecl() throws RecognitionException {
        SIdCheckControl_stack.push(new SIdCheckControl_scope());

        TDelphiScript2.tIdent_return id = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:103:2: (id= tIdent tc= tTypedConstant )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:103:4: id= tIdent tc= tTypedConstant
            {
            pushFollow(FOLLOW_tIdent_in_tConstantDecl305);
            id=tIdent();

            state._fsp--;
            if (state.failed) return ;
            if ( state.backtracking==0 ) {
              ((SIdCheckControl_scope)SIdCheckControl_stack.peek()).is_skip = true;
            }
            pushFollow(FOLLOW_tTypedConstant_in_tConstantDecl310);
            tTypedConstant();

            state._fsp--;
            if (state.failed) return ;

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
            SIdCheckControl_stack.pop();

        }
        return ;
    }
    // $ANTLR end "tConstantDecl"


    // $ANTLR start "tTypedConstant"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:106:1: tTypedConstant : tExpression ;
    public final void tTypedConstant() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:107:2: ( tExpression )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:107:4: tExpression
            {
            pushFollow(FOLLOW_tExpression_in_tTypedConstant321);
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:111:1: tExpression options {backtrack=true; memoize=true; } : ( tAtom | ^( tRelOp tExpression tExpression ) | ^( tMulOp tExpression tExpression ) | ^( tAddOp tExpression tExpression ) | ^( tUnaryOperator tExpression ) );
    public final void tExpression() throws RecognitionException {
        int tExpression_StartIndex = input.index();
        try {
            if ( state.backtracking>0 && alreadyParsedRule(input, 11) ) { return ; }
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:116:2: ( tAtom | ^( tRelOp tExpression tExpression ) | ^( tMulOp tExpression tExpression ) | ^( tAddOp tExpression tExpression ) | ^( tUnaryOperator tExpression ) )
            int alt14=5;
            alt14 = dfa14.predict(input);
            switch (alt14) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:116:4: tAtom
                    {
                    pushFollow(FOLLOW_tAtom_in_tExpression355);
                    tAtom();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:117:4: ^( tRelOp tExpression tExpression )
                    {
                    pushFollow(FOLLOW_tRelOp_in_tExpression361);
                    tRelOp();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression363);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression365);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:118:4: ^( tMulOp tExpression tExpression )
                    {
                    pushFollow(FOLLOW_tMulOp_in_tExpression372);
                    tMulOp();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression374);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression376);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:119:4: ^( tAddOp tExpression tExpression )
                    {
                    pushFollow(FOLLOW_tAddOp_in_tExpression383);
                    tAddOp();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression385);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression387);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:120:4: ^( tUnaryOperator tExpression )
                    {
                    pushFollow(FOLLOW_tUnaryOperator_in_tExpression394);
                    tUnaryOperator();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression396);
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
            if ( state.backtracking>0 ) { memoize(input, 11, tExpression_StartIndex); }
        }
        return ;
    }
    // $ANTLR end "tExpression"


    // $ANTLR start "tAtom"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:123:1: tAtom : ( tIdent | tNumber | NIL | TRUE | FALSE | STRING_LITERAL );
    public final void tAtom() throws RecognitionException {
        TDelphiScript2.tIdent_return tIdent1 = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:124:2: ( tIdent | tNumber | NIL | TRUE | FALSE | STRING_LITERAL )
            int alt15=6;
            switch ( input.LA(1) ) {
            case ID:
                {
                alt15=1;
                }
                break;
            case INT:
            case FLOAT:
            case HEX:
                {
                alt15=2;
                }
                break;
            case NIL:
                {
                alt15=3;
                }
                break;
            case TRUE:
                {
                alt15=4;
                }
                break;
            case FALSE:
                {
                alt15=5;
                }
                break;
            case STRING_LITERAL:
                {
                alt15=6;
                }
                break;
            default:
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 15, 0, input);

                throw nvae;
            }

            switch (alt15) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:124:4: tIdent
                    {
                    pushFollow(FOLLOW_tIdent_in_tAtom409);
                    tIdent1=tIdent();

                    state._fsp--;
                    if (state.failed) return ;
                    if ( state.backtracking==0 ) {

                      			if (!((SIdCheckControl_scope)SIdCheckControl_stack.peek()).is_skip)
                      				unit_context.IdUsed(
                      					(tIdent1!=null?(input.getTokenStream().toString(
                        input.getTreeAdaptor().getTokenStartIndex(tIdent1.start),
                        input.getTreeAdaptor().getTokenStopIndex(tIdent1.start))):null),
                      					(tIdent1!=null?((CommonTree)tIdent1.start):null).getLine(),
                      					(tIdent1!=null?((CommonTree)tIdent1.start):null).getCharPositionInLine(),
                      					((SIdCheckControl_scope)SIdCheckControl_stack.peek()).id_type
                      				);
                      		
                    }

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:134:4: tNumber
                    {
                    pushFollow(FOLLOW_tNumber_in_tAtom419);
                    tNumber();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:135:5: NIL
                    {
                    match(input,NIL,FOLLOW_NIL_in_tAtom425); if (state.failed) return ;

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:136:4: TRUE
                    {
                    match(input,TRUE,FOLLOW_TRUE_in_tAtom430); if (state.failed) return ;

                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:137:4: FALSE
                    {
                    match(input,FALSE,FOLLOW_FALSE_in_tAtom435); if (state.failed) return ;

                    }
                    break;
                case 6 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:138:4: STRING_LITERAL
                    {
                    match(input,STRING_LITERAL,FOLLOW_STRING_LITERAL_in_tAtom440); if (state.failed) return ;

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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:141:1: tNumber : ( INT | FLOAT | HEX );
    public final void tNumber() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:142:2: ( INT | FLOAT | HEX )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:147:1: tUnaryOperator : ( NOT | MINUS );
    public final void tUnaryOperator() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:148:2: ( NOT | MINUS )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:152:1: tAddOp : ( PLUS | MINUS | OR | XOR );
    public final void tAddOp() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:153:2: ( PLUS | MINUS | OR | XOR )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:159:1: tMulOp : ( STAR | SLASH | DIV | MOD | AND | SHL | SHR );
    public final void tMulOp() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:160:2: ( STAR | SLASH | DIV | MOD | AND | SHL | SHR )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:169:1: tRelOp : ( EQUAL | NOT_EQUAL | LT | LE | GE | GT | IN );
    public final void tRelOp() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:170:2: ( EQUAL | NOT_EQUAL | LT | LE | GE | GT | IN )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:179:1: tIdent : ID ;
    public final TDelphiScript2.tIdent_return tIdent() throws RecognitionException {
        TDelphiScript2.tIdent_return retval = new TDelphiScript2.tIdent_return();
        retval.start = input.LT(1);

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:180:2: ( ID )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:180:4: ID
            {
            match(input,ID,FOLLOW_ID_in_tIdent606); if (state.failed) return retval;

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

    // $ANTLR start synpred4_TDelphiScript2
    public final void synpred4_TDelphiScript2_fragment() throws RecognitionException {   
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:119:4: ( ^( tAddOp tExpression tExpression ) )
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript2.g:119:4: ^( tAddOp tExpression tExpression )
        {
        pushFollow(FOLLOW_tAddOp_in_synpred4_TDelphiScript2383);
        tAddOp();

        state._fsp--;
        if (state.failed) return ;

        match(input, Token.DOWN, null); if (state.failed) return ;
        pushFollow(FOLLOW_tExpression_in_synpred4_TDelphiScript2385);
        tExpression();

        state._fsp--;
        if (state.failed) return ;
        pushFollow(FOLLOW_tExpression_in_synpred4_TDelphiScript2387);
        tExpression();

        state._fsp--;
        if (state.failed) return ;

        match(input, Token.UP, null); if (state.failed) return ;

        }
    }
    // $ANTLR end synpred4_TDelphiScript2

    // Delegated rules

    public final boolean synpred4_TDelphiScript2() {
        state.backtracking++;
        int start = input.mark();
        try {
            synpred4_TDelphiScript2_fragment(); // can never throw exception
        } catch (RecognitionException re) {
            System.err.println("impossible: "+re);
        }
        boolean success = !state.failed;
        input.rewind(start);
        state.backtracking--;
        state.failed=false;
        return success;
    }


    protected DFA14 dfa14 = new DFA14(this);
    static final String DFA14_eotS =
        "\14\uffff";
    static final String DFA14_eofS =
        "\14\uffff";
    static final String DFA14_minS =
        "\1\54\10\uffff\1\0\2\uffff";
    static final String DFA14_maxS =
        "\1\125\10\uffff\1\0\2\uffff";
    static final String DFA14_acceptS =
        "\1\uffff\1\1\5\uffff\1\2\1\3\1\uffff\1\4\1\5";
    static final String DFA14_specialS =
        "\11\uffff\1\0\2\uffff}>";
    static final String[] DFA14_transitionS = {
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

    static final short[] DFA14_eot = DFA.unpackEncodedString(DFA14_eotS);
    static final short[] DFA14_eof = DFA.unpackEncodedString(DFA14_eofS);
    static final char[] DFA14_min = DFA.unpackEncodedStringToUnsignedChars(DFA14_minS);
    static final char[] DFA14_max = DFA.unpackEncodedStringToUnsignedChars(DFA14_maxS);
    static final short[] DFA14_accept = DFA.unpackEncodedString(DFA14_acceptS);
    static final short[] DFA14_special = DFA.unpackEncodedString(DFA14_specialS);
    static final short[][] DFA14_transition;

    static {
        int numStates = DFA14_transitionS.length;
        DFA14_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA14_transition[i] = DFA.unpackEncodedString(DFA14_transitionS[i]);
        }
    }

    class DFA14 extends DFA {

        public DFA14(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 14;
            this.eot = DFA14_eot;
            this.eof = DFA14_eof;
            this.min = DFA14_min;
            this.max = DFA14_max;
            this.accept = DFA14_accept;
            this.special = DFA14_special;
            this.transition = DFA14_transition;
        }
        public String getDescription() {
            return "111:1: tExpression options {backtrack=true; memoize=true; } : ( tAtom | ^( tRelOp tExpression tExpression ) | ^( tMulOp tExpression tExpression ) | ^( tAddOp tExpression tExpression ) | ^( tUnaryOperator tExpression ) );";
        }
        public int specialStateTransition(int s, IntStream _input) throws NoViableAltException {
            TreeNodeStream input = (TreeNodeStream)_input;
        	int _s = s;
            switch ( s ) {
                    case 0 : 
                        int LA14_9 = input.LA(1);

                         
                        int index14_9 = input.index();
                        input.rewind();
                        s = -1;
                        if ( (synpred4_TDelphiScript2()) ) {s = 10;}

                        else if ( (true) ) {s = 11;}

                         
                        input.seek(index14_9);
                        if ( s>=0 ) return s;
                        break;
            }
            if (state.backtracking>0) {state.failed=true; return -1;}
            NoViableAltException nvae =
                new NoViableAltException(getDescription(), 14, _s, input);
            error(nvae);
            throw nvae;
        }
    }
 

    public static final BitSet FOLLOW_UNIT_in_tGoal63 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_IMPL_DECL_in_tGoal69 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tImplementationDecl_in_tGoal71 = new BitSet(new long[]{0x00000C00000000C8L,0x0000000000000200L});
    public static final BitSet FOLLOW_CONST_in_tImplementationDecl88 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tConstantDecl_in_tImplementationDecl90 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_METHOD_DEF_in_tImplementationDecl97 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tMethodHeading_in_tImplementationDecl99 = new BitSet(new long[]{0xFFFFFFFFFFFFFFF8L,0x0FFFFFFFFFFFFFFFL});
    public static final BitSet FOLLOW_METHOD_DECL_in_tImplementationDecl110 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tMethodHeading_in_tImplementationDecl112 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_VAR_in_tImplementationDecl121 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tVarDecl_in_tImplementationDecl123 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_LABEL_in_tImplementationDecl130 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_set_in_tMethodHeading148 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tIdent_in_tMethodHeading156 = new BitSet(new long[]{0x0000000000000018L,0x000000000000C180L});
    public static final BitSet FOLLOW_tFormalParameter_in_tMethodHeading158 = new BitSet(new long[]{0x0000000000000018L,0x000000000000C180L});
    public static final BitSet FOLLOW_tType_in_tMethodHeading163 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_FORMAL_PARAMETER_in_tFormalParameter181 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tIdent_in_tFormalParameter183 = new BitSet(new long[]{0xC1FFD00000000008L,0x00000000003FC5F3L});
    public static final BitSet FOLLOW_tType_in_tFormalParameter185 = new BitSet(new long[]{0xC1FFD00000000008L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tTypedConstant_in_tFormalParameter188 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tIdent_in_tVarDecl203 = new BitSet(new long[]{0x0000000000000002L,0x000000000000C180L});
    public static final BitSet FOLLOW_tType_in_tVarDecl207 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tIdent_in_tType223 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ARRAY_in_tType229 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpressionOrRange_in_tType231 = new BitSet(new long[]{0x0000000000000000L,0x000000000040C180L});
    public static final BitSet FOLLOW_tType_in_tType234 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_FILE_in_tType241 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_FILE_in_tType244 = new BitSet(new long[]{0x0000001000000000L});
    public static final BitSet FOLLOW_OF_in_tType246 = new BitSet(new long[]{0x0000000000000000L,0x0000000000008000L});
    public static final BitSet FOLLOW_tIdent_in_tType248 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_in_tType254 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_DOTDOT_in_tExpressionOrRange266 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpressionOrRange268 = new BitSet(new long[]{0xC1FFD00000000000L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tExpression_in_tExpressionOrRange270 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_CONST_in_tConstSection283 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tConstantDecl_in_tConstSection285 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tIdent_in_tConstantDecl305 = new BitSet(new long[]{0xC1FFD00000000000L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tTypedConstant_in_tConstantDecl310 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tExpression_in_tTypedConstant321 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tAtom_in_tExpression355 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tRelOp_in_tExpression361 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression363 = new BitSet(new long[]{0xC1FFD00000000000L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tExpression_in_tExpression365 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tMulOp_in_tExpression372 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression374 = new BitSet(new long[]{0xC1FFD00000000000L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tExpression_in_tExpression376 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tAddOp_in_tExpression383 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression385 = new BitSet(new long[]{0xC1FFD00000000000L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tExpression_in_tExpression387 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tUnaryOperator_in_tExpression394 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression396 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tIdent_in_tAtom409 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tNumber_in_tAtom419 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_NIL_in_tAtom425 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_TRUE_in_tAtom430 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_FALSE_in_tAtom435 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_LITERAL_in_tAtom440 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tNumber0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tUnaryOperator0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tAddOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tMulOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tRelOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_tIdent606 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tAddOp_in_synpred4_TDelphiScript2383 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_synpred4_TDelphiScript2385 = new BitSet(new long[]{0xC1FFD00000000000L,0x00000000003F8473L});
    public static final BitSet FOLLOW_tExpression_in_synpred4_TDelphiScript2387 = new BitSet(new long[]{0x0000000000000008L});

}