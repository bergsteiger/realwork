// $ANTLR 3.3 Nov 30, 2010 12:45:30 W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g 2011-08-08 23:23:30

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
public class TDelphiScript3 extends TreeParser {
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
        EnumSet<IdType> id_type;
    }
    protected Stack SIdCheckControl_stack = new Stack();
    protected static class SMethod_scope {
        MethodContext context;
    }
    protected Stack SMethod_stack = new Stack();


        public TDelphiScript3(TreeNodeStream input) {
            this(input, new RecognizerSharedState());
        }
        public TDelphiScript3(TreeNodeStream input, RecognizerSharedState state) {
            super(input, state);
            this.state.ruleMemo = new HashMap[37+1];
             
             
        }
        

    public String[] getTokenNames() { return TDelphiScript3.tokenNames; }
    public String getGrammarFileName() { return "W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g"; }


    	UnitContext unit_context;
    	MethodContext method_context;
    	boolean is_dont_check_next_ident;
    	boolean is_dont_check_ident;
    	
    	public TDelphiScript3(Unit unit)
    	{
    		this(unit.ast);
    		this.unit_context = unit.context;
    		is_dont_check_next_ident = false;
    		is_dont_check_ident = false;
    	}



    // $ANTLR start "tGoal"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:44:1: tGoal : ^( UNIT ( tUses )? ^( IMPL_DECL ( tImplementationDecl )* ) ) ;
    public final void tGoal() throws RecognitionException {
        SIdCheckControl_stack.push(new SIdCheckControl_scope());


        	((SIdCheckControl_scope)SIdCheckControl_stack.peek()).id_type = EnumSet.of(IdType.CONST, IdType.VAR, IdType.METHOD, IdType.UNIT);

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:49:2: ( ^( UNIT ( tUses )? ^( IMPL_DECL ( tImplementationDecl )* ) ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:49:4: ^( UNIT ( tUses )? ^( IMPL_DECL ( tImplementationDecl )* ) )
            {
            match(input,UNIT,FOLLOW_UNIT_in_tGoal71); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:49:11: ( tUses )?
            int alt1=2;
            int LA1_0 = input.LA(1);

            if ( (LA1_0==USES) ) {
                alt1=1;
            }
            switch (alt1) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:49:11: tUses
                    {
                    pushFollow(FOLLOW_tUses_in_tGoal73);
                    tUses();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;

            }

            match(input,IMPL_DECL,FOLLOW_IMPL_DECL_in_tGoal77); if (state.failed) return ;

            if ( input.LA(1)==Token.DOWN ) {
                match(input, Token.DOWN, null); if (state.failed) return ;
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:49:30: ( tImplementationDecl )*
                loop2:
                do {
                    int alt2=2;
                    int LA2_0 = input.LA(1);

                    if ( ((LA2_0>=METHOD_DECL && LA2_0<=METHOD_DEF)||(LA2_0>=VAR && LA2_0<=LABEL)||LA2_0==CONST) ) {
                        alt2=1;
                    }


                    switch (alt2) {
                	case 1 :
                	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:49:30: tImplementationDecl
                	    {
                	    pushFollow(FOLLOW_tImplementationDecl_in_tGoal79);
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


    // $ANTLR start "tUses"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:52:1: tUses : ^( USES ( tIdent )+ ) ;
    public final void tUses() throws RecognitionException {
        TDelphiScript3.tIdent_return tIdent1 = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:53:2: ( ^( USES ( tIdent )+ ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:53:4: ^( USES ( tIdent )+ )
            {
            match(input,USES,FOLLOW_USES_in_tUses95); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:54:4: ( tIdent )+
            int cnt3=0;
            loop3:
            do {
                int alt3=2;
                int LA3_0 = input.LA(1);

                if ( (LA3_0==ID) ) {
                    alt3=1;
                }


                switch (alt3) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:54:5: tIdent
            	    {
            	    pushFollow(FOLLOW_tIdent_in_tUses102);
            	    tIdent1=tIdent();

            	    state._fsp--;
            	    if (state.failed) return ;
            	    if ( state.backtracking==0 ) {

            	      				unit_context.UnitUsed(
            	      					(tIdent1!=null?(input.getTokenStream().toString(
            	        input.getTreeAdaptor().getTokenStartIndex(tIdent1.start),
            	        input.getTreeAdaptor().getTokenStopIndex(tIdent1.start))):null),	
            	      					(tIdent1!=null?((CommonTree)tIdent1.start):null).getLine(),
            	      					(tIdent1!=null?((CommonTree)tIdent1.start):null).getCharPositionInLine()
            	      				);
            	    }

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
    // $ANTLR end "tUses"


    // $ANTLR start "tImplementationDecl"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:64:1: tImplementationDecl : ( ^( CONST tConstantDecl ) | tMethodDef | ^( METHOD_DECL ( . )* ) | ^( VAR tVarDecl ) | ^( LABEL ( . )* ) );
    public final void tImplementationDecl() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:65:2: ( ^( CONST tConstantDecl ) | tMethodDef | ^( METHOD_DECL ( . )* ) | ^( VAR tVarDecl ) | ^( LABEL ( . )* ) )
            int alt6=5;
            switch ( input.LA(1) ) {
            case CONST:
                {
                alt6=1;
                }
                break;
            case METHOD_DEF:
                {
                alt6=2;
                }
                break;
            case METHOD_DECL:
                {
                alt6=3;
                }
                break;
            case VAR:
                {
                alt6=4;
                }
                break;
            case LABEL:
                {
                alt6=5;
                }
                break;
            default:
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 6, 0, input);

                throw nvae;
            }

            switch (alt6) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:65:4: ^( CONST tConstantDecl )
                    {
                    match(input,CONST,FOLLOW_CONST_in_tImplementationDecl128); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tConstantDecl_in_tImplementationDecl130);
                    tConstantDecl();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:66:4: tMethodDef
                    {
                    pushFollow(FOLLOW_tMethodDef_in_tImplementationDecl136);
                    tMethodDef();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:67:4: ^( METHOD_DECL ( . )* )
                    {
                    match(input,METHOD_DECL,FOLLOW_METHOD_DECL_in_tImplementationDecl142); if (state.failed) return ;

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:67:18: ( . )*
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
                        	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:67:18: .
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
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:68:4: ^( VAR tVarDecl )
                    {
                    match(input,VAR,FOLLOW_VAR_in_tImplementationDecl153); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tVarDecl_in_tImplementationDecl155);
                    tVarDecl();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:69:4: ^( LABEL ( . )* )
                    {
                    match(input,LABEL,FOLLOW_LABEL_in_tImplementationDecl162); if (state.failed) return ;

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:69:12: ( . )*
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
                        	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:69:12: .
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


    // $ANTLR start "tMethodDef"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:72:1: tMethodDef : ^( METHOD_DEF tMethodHeading tFancyBlock ) ;
    public final void tMethodDef() throws RecognitionException {
        SMethod_stack.push(new SMethod_scope());

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:74:2: ( ^( METHOD_DEF tMethodHeading tFancyBlock ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:74:4: ^( METHOD_DEF tMethodHeading tFancyBlock )
            {
            match(input,METHOD_DEF,FOLLOW_METHOD_DEF_in_tMethodDef183); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tMethodHeading_in_tMethodDef185);
            tMethodHeading();

            state._fsp--;
            if (state.failed) return ;
            pushFollow(FOLLOW_tFancyBlock_in_tMethodDef187);
            tFancyBlock();

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
            SMethod_stack.pop();

        }
        return ;
    }
    // $ANTLR end "tMethodDef"


    // $ANTLR start "tFancyBlock"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:77:1: tFancyBlock : ^( IMPL_DECL ( tImplementationDecl )* ) tBlock ;
    public final void tFancyBlock() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:78:2: ( ^( IMPL_DECL ( tImplementationDecl )* ) tBlock )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:78:4: ^( IMPL_DECL ( tImplementationDecl )* ) tBlock
            {
            match(input,IMPL_DECL,FOLLOW_IMPL_DECL_in_tFancyBlock200); if (state.failed) return ;

            if ( input.LA(1)==Token.DOWN ) {
                match(input, Token.DOWN, null); if (state.failed) return ;
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:78:16: ( tImplementationDecl )*
                loop7:
                do {
                    int alt7=2;
                    int LA7_0 = input.LA(1);

                    if ( ((LA7_0>=METHOD_DECL && LA7_0<=METHOD_DEF)||(LA7_0>=VAR && LA7_0<=LABEL)||LA7_0==CONST) ) {
                        alt7=1;
                    }


                    switch (alt7) {
                	case 1 :
                	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:78:16: tImplementationDecl
                	    {
                	    pushFollow(FOLLOW_tImplementationDecl_in_tFancyBlock202);
                	    tImplementationDecl();

                	    state._fsp--;
                	    if (state.failed) return ;

                	    }
                	    break;

                	default :
                	    break loop7;
                    }
                } while (true);


                match(input, Token.UP, null); if (state.failed) return ;
            }
            pushFollow(FOLLOW_tBlock_in_tFancyBlock206);
            tBlock();

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
    // $ANTLR end "tFancyBlock"


    // $ANTLR start "tBlock"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:81:1: tBlock : ^( BLOCK ( tStatement )* ) ;
    public final void tBlock() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:82:2: ( ^( BLOCK ( tStatement )* ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:82:4: ^( BLOCK ( tStatement )* )
            {
            match(input,BLOCK,FOLLOW_BLOCK_in_tBlock218); if (state.failed) return ;

            if ( input.LA(1)==Token.DOWN ) {
                match(input, Token.DOWN, null); if (state.failed) return ;
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:82:12: ( tStatement )*
                loop8:
                do {
                    int alt8=2;
                    int LA8_0 = input.LA(1);

                    if ( (LA8_0==BLOCK||(LA8_0>=METHOD_CALL && LA8_0<=QUALIFIED_ACCESS)||LA8_0==CONST_ARRAY||(LA8_0>=COLON && LA8_0<=TRY)||LA8_0==WITH||(LA8_0>=FOR && LA8_0<=ASSIGN)||(LA8_0>=WHILE && LA8_0<=REPEAT)||LA8_0==CASE||LA8_0==IF||LA8_0==GOTO||LA8_0==INT||(LA8_0>=PLUS && LA8_0<=SHR)||(LA8_0>=STRING_LITERAL && LA8_0<=NOT)||LA8_0==EQUAL||(LA8_0>=ID && LA8_0<=IN)) ) {
                        alt8=1;
                    }


                    switch (alt8) {
                	case 1 :
                	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:82:12: tStatement
                	    {
                	    pushFollow(FOLLOW_tStatement_in_tBlock220);
                	    tStatement();

                	    state._fsp--;
                	    if (state.failed) return ;

                	    }
                	    break;

                	default :
                	    break loop8;
                    }
                } while (true);


                match(input, Token.UP, null); if (state.failed) return ;
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
    // $ANTLR end "tBlock"


    // $ANTLR start "tStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:85:1: tStatement : ( ^( COLON tLabelId ) )? ( tExpression | tAssign | ^( GOTO tLabelId ) | tBlock | ^( CASE tExpression ( tCaseSelector )+ ( ^( ELSE ( tStatement )? ) )? ) | ^( REPEAT ^( BLOCK ( tStatement )* ) tExpression ) | ^( WHILE tExpression ( tStatement )? ) | ^( FOR tIdent tExpression ( TO | DOWNTO ) tExpression tStatement ) | tWithStatement | ^( TRY ^( BLOCK ( tStatement )* ) ^( ( FINALLY | EXCEPT ) ( tStatement )* ) ) | ^( RAISE ( tExpression )? ) | ^( IF tExpression ^( THEN ( tStatement )? ) ( ^( ELSE ( tStatement )? ) )? ) | BREAK ) ;
    public final void tStatement() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:86:2: ( ( ^( COLON tLabelId ) )? ( tExpression | tAssign | ^( GOTO tLabelId ) | tBlock | ^( CASE tExpression ( tCaseSelector )+ ( ^( ELSE ( tStatement )? ) )? ) | ^( REPEAT ^( BLOCK ( tStatement )* ) tExpression ) | ^( WHILE tExpression ( tStatement )? ) | ^( FOR tIdent tExpression ( TO | DOWNTO ) tExpression tStatement ) | tWithStatement | ^( TRY ^( BLOCK ( tStatement )* ) ^( ( FINALLY | EXCEPT ) ( tStatement )* ) ) | ^( RAISE ( tExpression )? ) | ^( IF tExpression ^( THEN ( tStatement )? ) ( ^( ELSE ( tStatement )? ) )? ) | BREAK ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:86:4: ( ^( COLON tLabelId ) )? ( tExpression | tAssign | ^( GOTO tLabelId ) | tBlock | ^( CASE tExpression ( tCaseSelector )+ ( ^( ELSE ( tStatement )? ) )? ) | ^( REPEAT ^( BLOCK ( tStatement )* ) tExpression ) | ^( WHILE tExpression ( tStatement )? ) | ^( FOR tIdent tExpression ( TO | DOWNTO ) tExpression tStatement ) | tWithStatement | ^( TRY ^( BLOCK ( tStatement )* ) ^( ( FINALLY | EXCEPT ) ( tStatement )* ) ) | ^( RAISE ( tExpression )? ) | ^( IF tExpression ^( THEN ( tStatement )? ) ( ^( ELSE ( tStatement )? ) )? ) | BREAK )
            {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:86:4: ( ^( COLON tLabelId ) )?
            int alt9=2;
            int LA9_0 = input.LA(1);

            if ( (LA9_0==COLON) ) {
                alt9=1;
            }
            switch (alt9) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:86:5: ^( COLON tLabelId )
                    {
                    match(input,COLON,FOLLOW_COLON_in_tStatement235); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tLabelId_in_tStatement237);
                    tLabelId();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;

            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:86:25: ( tExpression | tAssign | ^( GOTO tLabelId ) | tBlock | ^( CASE tExpression ( tCaseSelector )+ ( ^( ELSE ( tStatement )? ) )? ) | ^( REPEAT ^( BLOCK ( tStatement )* ) tExpression ) | ^( WHILE tExpression ( tStatement )? ) | ^( FOR tIdent tExpression ( TO | DOWNTO ) tExpression tStatement ) | tWithStatement | ^( TRY ^( BLOCK ( tStatement )* ) ^( ( FINALLY | EXCEPT ) ( tStatement )* ) ) | ^( RAISE ( tExpression )? ) | ^( IF tExpression ^( THEN ( tStatement )? ) ( ^( ELSE ( tStatement )? ) )? ) | BREAK )
            int alt21=13;
            switch ( input.LA(1) ) {
            case METHOD_CALL:
            case INDEX:
            case QUALIFIED_ACCESS:
            case CONST_ARRAY:
            case INT:
            case PLUS:
            case MINUS:
            case OR:
            case XOR:
            case STAR:
            case SLASH:
            case DIV:
            case MOD:
            case AND:
            case SHL:
            case SHR:
            case STRING_LITERAL:
            case NIL:
            case FALSE:
            case TRUE:
            case RESULT:
            case EXCEPTIONMESSAGE:
            case FLOAT:
            case HEX:
            case NOT:
            case EQUAL:
            case ID:
            case NOT_EQUAL:
            case LT:
            case LE:
            case GE:
            case GT:
            case IN:
                {
                alt21=1;
                }
                break;
            case ASSIGN:
                {
                alt21=2;
                }
                break;
            case GOTO:
                {
                alt21=3;
                }
                break;
            case BLOCK:
                {
                alt21=4;
                }
                break;
            case CASE:
                {
                alt21=5;
                }
                break;
            case REPEAT:
                {
                alt21=6;
                }
                break;
            case WHILE:
                {
                alt21=7;
                }
                break;
            case FOR:
                {
                alt21=8;
                }
                break;
            case WITH:
                {
                alt21=9;
                }
                break;
            case TRY:
                {
                alt21=10;
                }
                break;
            case RAISE:
                {
                alt21=11;
                }
                break;
            case IF:
                {
                alt21=12;
                }
                break;
            case BREAK:
                {
                alt21=13;
                }
                break;
            default:
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 21, 0, input);

                throw nvae;
            }

            switch (alt21) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:87:4: tExpression
                    {
                    pushFollow(FOLLOW_tExpression_in_tStatement247);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:88:5: tAssign
                    {
                    pushFollow(FOLLOW_tAssign_in_tStatement253);
                    tAssign();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:89:5: ^( GOTO tLabelId )
                    {
                    match(input,GOTO,FOLLOW_GOTO_in_tStatement260); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tLabelId_in_tStatement262);
                    tLabelId();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:90:5: tBlock
                    {
                    pushFollow(FOLLOW_tBlock_in_tStatement269);
                    tBlock();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:91:5: ^( CASE tExpression ( tCaseSelector )+ ( ^( ELSE ( tStatement )? ) )? )
                    {
                    match(input,CASE,FOLLOW_CASE_in_tStatement276); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tStatement278);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:91:24: ( tCaseSelector )+
                    int cnt10=0;
                    loop10:
                    do {
                        int alt10=2;
                        int LA10_0 = input.LA(1);

                        if ( (LA10_0==CASE_SELECTOR) ) {
                            alt10=1;
                        }


                        switch (alt10) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:91:24: tCaseSelector
                    	    {
                    	    pushFollow(FOLLOW_tCaseSelector_in_tStatement280);
                    	    tCaseSelector();

                    	    state._fsp--;
                    	    if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt10 >= 1 ) break loop10;
                    	    if (state.backtracking>0) {state.failed=true; return ;}
                                EarlyExitException eee =
                                    new EarlyExitException(10, input);
                                throw eee;
                        }
                        cnt10++;
                    } while (true);

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:91:39: ( ^( ELSE ( tStatement )? ) )?
                    int alt12=2;
                    int LA12_0 = input.LA(1);

                    if ( (LA12_0==ELSE) ) {
                        alt12=1;
                    }
                    switch (alt12) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:91:40: ^( ELSE ( tStatement )? )
                            {
                            match(input,ELSE,FOLLOW_ELSE_in_tStatement285); if (state.failed) return ;

                            if ( input.LA(1)==Token.DOWN ) {
                                match(input, Token.DOWN, null); if (state.failed) return ;
                                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:91:47: ( tStatement )?
                                int alt11=2;
                                int LA11_0 = input.LA(1);

                                if ( (LA11_0==BLOCK||(LA11_0>=METHOD_CALL && LA11_0<=QUALIFIED_ACCESS)||LA11_0==CONST_ARRAY||(LA11_0>=COLON && LA11_0<=TRY)||LA11_0==WITH||(LA11_0>=FOR && LA11_0<=ASSIGN)||(LA11_0>=WHILE && LA11_0<=REPEAT)||LA11_0==CASE||LA11_0==IF||LA11_0==GOTO||LA11_0==INT||(LA11_0>=PLUS && LA11_0<=SHR)||(LA11_0>=STRING_LITERAL && LA11_0<=NOT)||LA11_0==EQUAL||(LA11_0>=ID && LA11_0<=IN)) ) {
                                    alt11=1;
                                }
                                switch (alt11) {
                                    case 1 :
                                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:91:47: tStatement
                                        {
                                        pushFollow(FOLLOW_tStatement_in_tStatement287);
                                        tStatement();

                                        state._fsp--;
                                        if (state.failed) return ;

                                        }
                                        break;

                                }


                                match(input, Token.UP, null); if (state.failed) return ;
                            }

                            }
                            break;

                    }


                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 6 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:92:5: ^( REPEAT ^( BLOCK ( tStatement )* ) tExpression )
                    {
                    match(input,REPEAT,FOLLOW_REPEAT_in_tStatement300); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    match(input,BLOCK,FOLLOW_BLOCK_in_tStatement303); if (state.failed) return ;

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:92:22: ( tStatement )*
                        loop13:
                        do {
                            int alt13=2;
                            int LA13_0 = input.LA(1);

                            if ( (LA13_0==BLOCK||(LA13_0>=METHOD_CALL && LA13_0<=QUALIFIED_ACCESS)||LA13_0==CONST_ARRAY||(LA13_0>=COLON && LA13_0<=TRY)||LA13_0==WITH||(LA13_0>=FOR && LA13_0<=ASSIGN)||(LA13_0>=WHILE && LA13_0<=REPEAT)||LA13_0==CASE||LA13_0==IF||LA13_0==GOTO||LA13_0==INT||(LA13_0>=PLUS && LA13_0<=SHR)||(LA13_0>=STRING_LITERAL && LA13_0<=NOT)||LA13_0==EQUAL||(LA13_0>=ID && LA13_0<=IN)) ) {
                                alt13=1;
                            }


                            switch (alt13) {
                        	case 1 :
                        	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:92:22: tStatement
                        	    {
                        	    pushFollow(FOLLOW_tStatement_in_tStatement305);
                        	    tStatement();

                        	    state._fsp--;
                        	    if (state.failed) return ;

                        	    }
                        	    break;

                        	default :
                        	    break loop13;
                            }
                        } while (true);


                        match(input, Token.UP, null); if (state.failed) return ;
                    }
                    pushFollow(FOLLOW_tExpression_in_tStatement309);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 7 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:93:5: ^( WHILE tExpression ( tStatement )? )
                    {
                    match(input,WHILE,FOLLOW_WHILE_in_tStatement317); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tStatement319);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:93:25: ( tStatement )?
                    int alt14=2;
                    int LA14_0 = input.LA(1);

                    if ( (LA14_0==BLOCK||(LA14_0>=METHOD_CALL && LA14_0<=QUALIFIED_ACCESS)||LA14_0==CONST_ARRAY||(LA14_0>=COLON && LA14_0<=TRY)||LA14_0==WITH||(LA14_0>=FOR && LA14_0<=ASSIGN)||(LA14_0>=WHILE && LA14_0<=REPEAT)||LA14_0==CASE||LA14_0==IF||LA14_0==GOTO||LA14_0==INT||(LA14_0>=PLUS && LA14_0<=SHR)||(LA14_0>=STRING_LITERAL && LA14_0<=NOT)||LA14_0==EQUAL||(LA14_0>=ID && LA14_0<=IN)) ) {
                        alt14=1;
                    }
                    switch (alt14) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:93:25: tStatement
                            {
                            pushFollow(FOLLOW_tStatement_in_tStatement321);
                            tStatement();

                            state._fsp--;
                            if (state.failed) return ;

                            }
                            break;

                    }


                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 8 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:94:5: ^( FOR tIdent tExpression ( TO | DOWNTO ) tExpression tStatement )
                    {
                    match(input,FOR,FOLLOW_FOR_in_tStatement330); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tIdent_in_tStatement332);
                    tIdent();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tStatement334);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    if ( (input.LA(1)>=TO && input.LA(1)<=DOWNTO) ) {
                        input.consume();
                        state.errorRecovery=false;state.failed=false;
                    }
                    else {
                        if (state.backtracking>0) {state.failed=true; return ;}
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_tExpression_in_tStatement342);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tStatement_in_tStatement344);
                    tStatement();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 9 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:95:5: tWithStatement
                    {
                    pushFollow(FOLLOW_tWithStatement_in_tStatement351);
                    tWithStatement();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 10 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:96:5: ^( TRY ^( BLOCK ( tStatement )* ) ^( ( FINALLY | EXCEPT ) ( tStatement )* ) )
                    {
                    match(input,TRY,FOLLOW_TRY_in_tStatement358); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    match(input,BLOCK,FOLLOW_BLOCK_in_tStatement361); if (state.failed) return ;

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:96:19: ( tStatement )*
                        loop15:
                        do {
                            int alt15=2;
                            int LA15_0 = input.LA(1);

                            if ( (LA15_0==BLOCK||(LA15_0>=METHOD_CALL && LA15_0<=QUALIFIED_ACCESS)||LA15_0==CONST_ARRAY||(LA15_0>=COLON && LA15_0<=TRY)||LA15_0==WITH||(LA15_0>=FOR && LA15_0<=ASSIGN)||(LA15_0>=WHILE && LA15_0<=REPEAT)||LA15_0==CASE||LA15_0==IF||LA15_0==GOTO||LA15_0==INT||(LA15_0>=PLUS && LA15_0<=SHR)||(LA15_0>=STRING_LITERAL && LA15_0<=NOT)||LA15_0==EQUAL||(LA15_0>=ID && LA15_0<=IN)) ) {
                                alt15=1;
                            }


                            switch (alt15) {
                        	case 1 :
                        	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:96:19: tStatement
                        	    {
                        	    pushFollow(FOLLOW_tStatement_in_tStatement363);
                        	    tStatement();

                        	    state._fsp--;
                        	    if (state.failed) return ;

                        	    }
                        	    break;

                        	default :
                        	    break loop15;
                            }
                        } while (true);


                        match(input, Token.UP, null); if (state.failed) return ;
                    }
                    if ( (input.LA(1)>=FINALLY && input.LA(1)<=EXCEPT) ) {
                        input.consume();
                        state.errorRecovery=false;state.failed=false;
                    }
                    else {
                        if (state.backtracking>0) {state.failed=true; return ;}
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }


                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:96:51: ( tStatement )*
                        loop16:
                        do {
                            int alt16=2;
                            int LA16_0 = input.LA(1);

                            if ( (LA16_0==BLOCK||(LA16_0>=METHOD_CALL && LA16_0<=QUALIFIED_ACCESS)||LA16_0==CONST_ARRAY||(LA16_0>=COLON && LA16_0<=TRY)||LA16_0==WITH||(LA16_0>=FOR && LA16_0<=ASSIGN)||(LA16_0>=WHILE && LA16_0<=REPEAT)||LA16_0==CASE||LA16_0==IF||LA16_0==GOTO||LA16_0==INT||(LA16_0>=PLUS && LA16_0<=SHR)||(LA16_0>=STRING_LITERAL && LA16_0<=NOT)||LA16_0==EQUAL||(LA16_0>=ID && LA16_0<=IN)) ) {
                                alt16=1;
                            }


                            switch (alt16) {
                        	case 1 :
                        	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:96:51: tStatement
                        	    {
                        	    pushFollow(FOLLOW_tStatement_in_tStatement374);
                        	    tStatement();

                        	    state._fsp--;
                        	    if (state.failed) return ;

                        	    }
                        	    break;

                        	default :
                        	    break loop16;
                            }
                        } while (true);


                        match(input, Token.UP, null); if (state.failed) return ;
                    }

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 11 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:97:5: ^( RAISE ( tExpression )? )
                    {
                    match(input,RAISE,FOLLOW_RAISE_in_tStatement385); if (state.failed) return ;

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:97:13: ( tExpression )?
                        int alt17=2;
                        int LA17_0 = input.LA(1);

                        if ( ((LA17_0>=METHOD_CALL && LA17_0<=QUALIFIED_ACCESS)||LA17_0==CONST_ARRAY||LA17_0==INT||(LA17_0>=PLUS && LA17_0<=SHR)||(LA17_0>=STRING_LITERAL && LA17_0<=NOT)||LA17_0==EQUAL||(LA17_0>=ID && LA17_0<=IN)) ) {
                            alt17=1;
                        }
                        switch (alt17) {
                            case 1 :
                                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:97:13: tExpression
                                {
                                pushFollow(FOLLOW_tExpression_in_tStatement387);
                                tExpression();

                                state._fsp--;
                                if (state.failed) return ;

                                }
                                break;

                        }


                        match(input, Token.UP, null); if (state.failed) return ;
                    }

                    }
                    break;
                case 12 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:98:5: ^( IF tExpression ^( THEN ( tStatement )? ) ( ^( ELSE ( tStatement )? ) )? )
                    {
                    match(input,IF,FOLLOW_IF_in_tStatement396); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tStatement398);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    match(input,THEN,FOLLOW_THEN_in_tStatement401); if (state.failed) return ;

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); if (state.failed) return ;
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:98:29: ( tStatement )?
                        int alt18=2;
                        int LA18_0 = input.LA(1);

                        if ( (LA18_0==BLOCK||(LA18_0>=METHOD_CALL && LA18_0<=QUALIFIED_ACCESS)||LA18_0==CONST_ARRAY||(LA18_0>=COLON && LA18_0<=TRY)||LA18_0==WITH||(LA18_0>=FOR && LA18_0<=ASSIGN)||(LA18_0>=WHILE && LA18_0<=REPEAT)||LA18_0==CASE||LA18_0==IF||LA18_0==GOTO||LA18_0==INT||(LA18_0>=PLUS && LA18_0<=SHR)||(LA18_0>=STRING_LITERAL && LA18_0<=NOT)||LA18_0==EQUAL||(LA18_0>=ID && LA18_0<=IN)) ) {
                            alt18=1;
                        }
                        switch (alt18) {
                            case 1 :
                                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:98:29: tStatement
                                {
                                pushFollow(FOLLOW_tStatement_in_tStatement403);
                                tStatement();

                                state._fsp--;
                                if (state.failed) return ;

                                }
                                break;

                        }


                        match(input, Token.UP, null); if (state.failed) return ;
                    }
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:98:42: ( ^( ELSE ( tStatement )? ) )?
                    int alt20=2;
                    int LA20_0 = input.LA(1);

                    if ( (LA20_0==ELSE) ) {
                        alt20=1;
                    }
                    switch (alt20) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:98:43: ^( ELSE ( tStatement )? )
                            {
                            match(input,ELSE,FOLLOW_ELSE_in_tStatement409); if (state.failed) return ;

                            if ( input.LA(1)==Token.DOWN ) {
                                match(input, Token.DOWN, null); if (state.failed) return ;
                                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:98:50: ( tStatement )?
                                int alt19=2;
                                int LA19_0 = input.LA(1);

                                if ( (LA19_0==BLOCK||(LA19_0>=METHOD_CALL && LA19_0<=QUALIFIED_ACCESS)||LA19_0==CONST_ARRAY||(LA19_0>=COLON && LA19_0<=TRY)||LA19_0==WITH||(LA19_0>=FOR && LA19_0<=ASSIGN)||(LA19_0>=WHILE && LA19_0<=REPEAT)||LA19_0==CASE||LA19_0==IF||LA19_0==GOTO||LA19_0==INT||(LA19_0>=PLUS && LA19_0<=SHR)||(LA19_0>=STRING_LITERAL && LA19_0<=NOT)||LA19_0==EQUAL||(LA19_0>=ID && LA19_0<=IN)) ) {
                                    alt19=1;
                                }
                                switch (alt19) {
                                    case 1 :
                                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:98:50: tStatement
                                        {
                                        pushFollow(FOLLOW_tStatement_in_tStatement411);
                                        tStatement();

                                        state._fsp--;
                                        if (state.failed) return ;

                                        }
                                        break;

                                }


                                match(input, Token.UP, null); if (state.failed) return ;
                            }

                            }
                            break;

                    }


                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 13 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:99:5: BREAK
                    {
                    match(input,BREAK,FOLLOW_BREAK_in_tStatement422); if (state.failed) return ;

                    }
                    break;

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
    // $ANTLR end "tStatement"


    // $ANTLR start "tWithStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:103:1: tWithStatement : ^( WITH tExpression ( tStatement )? ) ;
    public final void tWithStatement() throws RecognitionException {
        SIdCheckControl_stack.push(new SIdCheckControl_scope());

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:105:2: ( ^( WITH tExpression ( tStatement )? ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:105:4: ^( WITH tExpression ( tStatement )? )
            {
            match(input,WITH,FOLLOW_WITH_in_tWithStatement442); if (state.failed) return ;

            if ( state.backtracking==0 ) {

              				((SIdCheckControl_scope)SIdCheckControl_stack.peek()).id_type = EnumSet.of(IdType.VAR, IdType.CONST, IdType.METHOD, IdType.UNIT);
              			
            }

            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tExpression_in_tWithStatement453);
            tExpression();

            state._fsp--;
            if (state.failed) return ;
            if ( state.backtracking==0 ) {

              				is_dont_check_ident = true;
              			
            }
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:114:4: ( tStatement )?
            int alt22=2;
            int LA22_0 = input.LA(1);

            if ( (LA22_0==BLOCK||(LA22_0>=METHOD_CALL && LA22_0<=QUALIFIED_ACCESS)||LA22_0==CONST_ARRAY||(LA22_0>=COLON && LA22_0<=TRY)||LA22_0==WITH||(LA22_0>=FOR && LA22_0<=ASSIGN)||(LA22_0>=WHILE && LA22_0<=REPEAT)||LA22_0==CASE||LA22_0==IF||LA22_0==GOTO||LA22_0==INT||(LA22_0>=PLUS && LA22_0<=SHR)||(LA22_0>=STRING_LITERAL && LA22_0<=NOT)||LA22_0==EQUAL||(LA22_0>=ID && LA22_0<=IN)) ) {
                alt22=1;
            }
            switch (alt22) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:114:4: tStatement
                    {
                    pushFollow(FOLLOW_tStatement_in_tWithStatement468);
                    tStatement();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;

            }

            if ( state.backtracking==0 ) {

              				is_dont_check_ident = false;
              			
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
    // $ANTLR end "tWithStatement"


    // $ANTLR start "tAssign"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:121:1: tAssign : ^( ASSIGN tExpression tExpression ) ;
    public final void tAssign() throws RecognitionException {
        SIdCheckControl_stack.push(new SIdCheckControl_scope());

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:123:2: ( ^( ASSIGN tExpression tExpression ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:123:4: ^( ASSIGN tExpression tExpression )
            {
            match(input,ASSIGN,FOLLOW_ASSIGN_in_tAssign498); if (state.failed) return ;

            if ( state.backtracking==0 ) {

              				((SIdCheckControl_scope)SIdCheckControl_stack.peek()).id_type = EnumSet.of(IdType.VAR);	
              			
            }

            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tExpression_in_tAssign510);
            tExpression();

            state._fsp--;
            if (state.failed) return ;
            if ( state.backtracking==0 ) {

              				((SIdCheckControl_scope)SIdCheckControl_stack.peek()).id_type = EnumSet.of(IdType.VAR, IdType.CONST, IdType.METHOD);	
              			
            }
            pushFollow(FOLLOW_tExpression_in_tAssign522);
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
            SIdCheckControl_stack.pop();

        }
        return ;
    }
    // $ANTLR end "tAssign"


    // $ANTLR start "tCaseSelector"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:135:1: tCaseSelector : ^( CASE_SELECTOR ( tExpressionOrRange )+ ^( BLOCK ( tStatement )? ) ) ;
    public final void tCaseSelector() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:136:2: ( ^( CASE_SELECTOR ( tExpressionOrRange )+ ^( BLOCK ( tStatement )? ) ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:136:4: ^( CASE_SELECTOR ( tExpressionOrRange )+ ^( BLOCK ( tStatement )? ) )
            {
            match(input,CASE_SELECTOR,FOLLOW_CASE_SELECTOR_in_tCaseSelector538); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:136:20: ( tExpressionOrRange )+
            int cnt23=0;
            loop23:
            do {
                int alt23=2;
                int LA23_0 = input.LA(1);

                if ( ((LA23_0>=METHOD_CALL && LA23_0<=QUALIFIED_ACCESS)||LA23_0==CONST_ARRAY||LA23_0==INT||(LA23_0>=PLUS && LA23_0<=SHR)||(LA23_0>=STRING_LITERAL && LA23_0<=NOT)||LA23_0==EQUAL||(LA23_0>=ID && LA23_0<=DOTDOT)) ) {
                    alt23=1;
                }


                switch (alt23) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:136:20: tExpressionOrRange
            	    {
            	    pushFollow(FOLLOW_tExpressionOrRange_in_tCaseSelector540);
            	    tExpressionOrRange();

            	    state._fsp--;
            	    if (state.failed) return ;

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

            match(input,BLOCK,FOLLOW_BLOCK_in_tCaseSelector544); if (state.failed) return ;

            if ( input.LA(1)==Token.DOWN ) {
                match(input, Token.DOWN, null); if (state.failed) return ;
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:136:48: ( tStatement )?
                int alt24=2;
                int LA24_0 = input.LA(1);

                if ( (LA24_0==BLOCK||(LA24_0>=METHOD_CALL && LA24_0<=QUALIFIED_ACCESS)||LA24_0==CONST_ARRAY||(LA24_0>=COLON && LA24_0<=TRY)||LA24_0==WITH||(LA24_0>=FOR && LA24_0<=ASSIGN)||(LA24_0>=WHILE && LA24_0<=REPEAT)||LA24_0==CASE||LA24_0==IF||LA24_0==GOTO||LA24_0==INT||(LA24_0>=PLUS && LA24_0<=SHR)||(LA24_0>=STRING_LITERAL && LA24_0<=NOT)||LA24_0==EQUAL||(LA24_0>=ID && LA24_0<=IN)) ) {
                    alt24=1;
                }
                switch (alt24) {
                    case 1 :
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:136:48: tStatement
                        {
                        pushFollow(FOLLOW_tStatement_in_tCaseSelector546);
                        tStatement();

                        state._fsp--;
                        if (state.failed) return ;

                        }
                        break;

                }


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
    // $ANTLR end "tCaseSelector"


    // $ANTLR start "tLabelId"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:139:1: tLabelId : ( INT | tIdent );
    public final void tLabelId() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:140:2: ( INT | tIdent )
            int alt25=2;
            int LA25_0 = input.LA(1);

            if ( (LA25_0==INT) ) {
                alt25=1;
            }
            else if ( (LA25_0==ID) ) {
                alt25=2;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 25, 0, input);

                throw nvae;
            }
            switch (alt25) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:140:4: INT
                    {
                    match(input,INT,FOLLOW_INT_in_tLabelId560); if (state.failed) return ;

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:141:4: tIdent
                    {
                    pushFollow(FOLLOW_tIdent_in_tLabelId565);
                    tIdent();

                    state._fsp--;
                    if (state.failed) return ;

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
    // $ANTLR end "tLabelId"


    // $ANTLR start "tMethodHeading"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:144:1: tMethodHeading : ^( ( PROCEDURE | FUNCTION ) name= tIdent ( tFormalParameter )* (ret_type= tType )? ) ;
    public final void tMethodHeading() throws RecognitionException {
        TDelphiScript3.tIdent_return name = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:145:2: ( ^( ( PROCEDURE | FUNCTION ) name= tIdent ( tFormalParameter )* (ret_type= tType )? ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:145:4: ^( ( PROCEDURE | FUNCTION ) name= tIdent ( tFormalParameter )* (ret_type= tType )? )
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
            pushFollow(FOLLOW_tIdent_in_tMethodHeading585);
            name=tIdent();

            state._fsp--;
            if (state.failed) return ;
            if ( state.backtracking==0 ) {

              				if (SMethod_stack.size() > 0)
              					((SMethod_scope)SMethod_stack.peek()).context = unit_context.MethodDefined(
              						(name!=null?(input.getTokenStream().toString(
                input.getTreeAdaptor().getTokenStartIndex(name.start),
                input.getTreeAdaptor().getTokenStopIndex(name.start))):null),
              						(name!=null?((CommonTree)name.start):null).getLine(),
              						(name!=null?((CommonTree)name.start):null).getCharPositionInLine()
              				);
              			
            }
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:154:3: ( tFormalParameter )*
            loop26:
            do {
                int alt26=2;
                int LA26_0 = input.LA(1);

                if ( (LA26_0==FORMAL_PARAMETER) ) {
                    alt26=1;
                }


                switch (alt26) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:154:3: tFormalParameter
            	    {
            	    pushFollow(FOLLOW_tFormalParameter_in_tMethodHeading595);
            	    tFormalParameter();

            	    state._fsp--;
            	    if (state.failed) return ;

            	    }
            	    break;

            	default :
            	    break loop26;
                }
            } while (true);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:154:29: (ret_type= tType )?
            int alt27=2;
            int LA27_0 = input.LA(1);

            if ( ((LA27_0>=ARRAY && LA27_0<=STRING)||(LA27_0>=FILE && LA27_0<=ID)) ) {
                alt27=1;
            }
            switch (alt27) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:154:29: ret_type= tType
                    {
                    pushFollow(FOLLOW_tType_in_tMethodHeading600);
                    tType();

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
    // $ANTLR end "tMethodHeading"


    // $ANTLR start "tFormalParameter"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:157:1: tFormalParameter : ^( FORMAL_PARAMETER id= tIdent ( tType )? ( tTypedConstant )? ) ;
    public final void tFormalParameter() throws RecognitionException {
        TDelphiScript3.tIdent_return id = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:158:2: ( ^( FORMAL_PARAMETER id= tIdent ( tType )? ( tTypedConstant )? ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:158:4: ^( FORMAL_PARAMETER id= tIdent ( tType )? ( tTypedConstant )? )
            {
            match(input,FORMAL_PARAMETER,FOLLOW_FORMAL_PARAMETER_in_tFormalParameter614); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tIdent_in_tFormalParameter618);
            id=tIdent();

            state._fsp--;
            if (state.failed) return ;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:158:33: ( tType )?
            int alt28=2;
            int LA28_0 = input.LA(1);

            if ( ((LA28_0>=ARRAY && LA28_0<=STRING)||(LA28_0>=FILE && LA28_0<=ID)) ) {
                alt28=1;
            }
            switch (alt28) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:158:33: tType
                    {
                    pushFollow(FOLLOW_tType_in_tFormalParameter620);
                    tType();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;

            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:158:40: ( tTypedConstant )?
            int alt29=2;
            int LA29_0 = input.LA(1);

            if ( ((LA29_0>=METHOD_CALL && LA29_0<=QUALIFIED_ACCESS)||LA29_0==CONST_ARRAY||LA29_0==INT||(LA29_0>=PLUS && LA29_0<=SHR)||(LA29_0>=STRING_LITERAL && LA29_0<=NOT)||LA29_0==EQUAL||(LA29_0>=ID && LA29_0<=IN)) ) {
                alt29=1;
            }
            switch (alt29) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:158:40: tTypedConstant
                    {
                    pushFollow(FOLLOW_tTypedConstant_in_tFormalParameter623);
                    tTypedConstant();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;

            }


            match(input, Token.UP, null); if (state.failed) return ;
            if ( state.backtracking==0 ) {

              			((SMethod_scope)SMethod_stack.peek()).context.VarDeclared(
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
    // $ANTLR end "tFormalParameter"


    // $ANTLR start "tVarDecl"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:168:1: tVarDecl : id= tIdent (type= tType )? ;
    public final void tVarDecl() throws RecognitionException {
        TDelphiScript3.tIdent_return id = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:169:2: (id= tIdent (type= tType )? )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:169:4: id= tIdent (type= tType )?
            {
            pushFollow(FOLLOW_tIdent_in_tVarDecl642);
            id=tIdent();

            state._fsp--;
            if (state.failed) return ;
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:169:18: (type= tType )?
            int alt30=2;
            int LA30_0 = input.LA(1);

            if ( ((LA30_0>=ARRAY && LA30_0<=STRING)||(LA30_0>=FILE && LA30_0<=ID)) ) {
                alt30=1;
            }
            switch (alt30) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:169:18: type= tType
                    {
                    pushFollow(FOLLOW_tType_in_tVarDecl646);
                    tType();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;

            }

            if ( state.backtracking==0 ) {

              			if (SMethod_stack.size() > 0) 
              				((SMethod_scope)SMethod_stack.peek()).context.VarDeclared(
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:180:1: tType : ( tIdent | ^( ARRAY ( tExpressionOrRange )* tType ) | ( FILE | FILE OF tIdent ) | STRING );
    public final void tType() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:181:2: ( tIdent | ^( ARRAY ( tExpressionOrRange )* tType ) | ( FILE | FILE OF tIdent ) | STRING )
            int alt33=4;
            switch ( input.LA(1) ) {
            case ID:
                {
                alt33=1;
                }
                break;
            case ARRAY:
                {
                alt33=2;
                }
                break;
            case FILE:
                {
                alt33=3;
                }
                break;
            case STRING:
                {
                alt33=4;
                }
                break;
            default:
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 33, 0, input);

                throw nvae;
            }

            switch (alt33) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:181:4: tIdent
                    {
                    pushFollow(FOLLOW_tIdent_in_tType662);
                    tIdent();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:182:4: ^( ARRAY ( tExpressionOrRange )* tType )
                    {
                    match(input,ARRAY,FOLLOW_ARRAY_in_tType668); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:182:12: ( tExpressionOrRange )*
                    loop31:
                    do {
                        int alt31=2;
                        int LA31_0 = input.LA(1);

                        if ( (LA31_0==ID) ) {
                            int LA31_1 = input.LA(2);

                            if ( ((LA31_1>=METHOD_CALL && LA31_1<=QUALIFIED_ACCESS)||LA31_1==CONST_ARRAY||LA31_1==INT||(LA31_1>=PLUS && LA31_1<=SHR)||(LA31_1>=STRING_LITERAL && LA31_1<=STRING)||LA31_1==EQUAL||(LA31_1>=FILE && LA31_1<=DOTDOT)) ) {
                                alt31=1;
                            }


                        }
                        else if ( ((LA31_0>=METHOD_CALL && LA31_0<=QUALIFIED_ACCESS)||LA31_0==CONST_ARRAY||LA31_0==INT||(LA31_0>=PLUS && LA31_0<=SHR)||(LA31_0>=STRING_LITERAL && LA31_0<=NOT)||LA31_0==EQUAL||(LA31_0>=NOT_EQUAL && LA31_0<=DOTDOT)) ) {
                            alt31=1;
                        }


                        switch (alt31) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:182:12: tExpressionOrRange
                    	    {
                    	    pushFollow(FOLLOW_tExpressionOrRange_in_tType670);
                    	    tExpressionOrRange();

                    	    state._fsp--;
                    	    if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    break loop31;
                        }
                    } while (true);

                    pushFollow(FOLLOW_tType_in_tType673);
                    tType();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:183:4: ( FILE | FILE OF tIdent )
                    {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:183:4: ( FILE | FILE OF tIdent )
                    int alt32=2;
                    int LA32_0 = input.LA(1);

                    if ( (LA32_0==FILE) ) {
                        int LA32_1 = input.LA(2);

                        if ( (LA32_1==OF) ) {
                            alt32=2;
                        }
                        else if ( (LA32_1==UP||(LA32_1>=METHOD_CALL && LA32_1<=QUALIFIED_ACCESS)||LA32_1==CONST_ARRAY||LA32_1==INT||(LA32_1>=PLUS && LA32_1<=SHR)||(LA32_1>=STRING_LITERAL && LA32_1<=NOT)||LA32_1==EQUAL||(LA32_1>=ID && LA32_1<=IN)) ) {
                            alt32=1;
                        }
                        else {
                            if (state.backtracking>0) {state.failed=true; return ;}
                            NoViableAltException nvae =
                                new NoViableAltException("", 32, 1, input);

                            throw nvae;
                        }
                    }
                    else {
                        if (state.backtracking>0) {state.failed=true; return ;}
                        NoViableAltException nvae =
                            new NoViableAltException("", 32, 0, input);

                        throw nvae;
                    }
                    switch (alt32) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:183:5: FILE
                            {
                            match(input,FILE,FOLLOW_FILE_in_tType680); if (state.failed) return ;

                            }
                            break;
                        case 2 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:183:11: FILE OF tIdent
                            {
                            match(input,FILE,FOLLOW_FILE_in_tType683); if (state.failed) return ;
                            match(input,OF,FOLLOW_OF_in_tType685); if (state.failed) return ;
                            pushFollow(FOLLOW_tIdent_in_tType687);
                            tIdent();

                            state._fsp--;
                            if (state.failed) return ;

                            }
                            break;

                    }


                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:184:4: STRING
                    {
                    match(input,STRING,FOLLOW_STRING_in_tType693); if (state.failed) return ;

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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:187:1: tExpressionOrRange : ( tExpression | ^( DOTDOT tExpression tExpression ) );
    public final void tExpressionOrRange() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:188:2: ( tExpression | ^( DOTDOT tExpression tExpression ) )
            int alt34=2;
            int LA34_0 = input.LA(1);

            if ( ((LA34_0>=METHOD_CALL && LA34_0<=QUALIFIED_ACCESS)||LA34_0==CONST_ARRAY||LA34_0==INT||(LA34_0>=PLUS && LA34_0<=SHR)||(LA34_0>=STRING_LITERAL && LA34_0<=NOT)||LA34_0==EQUAL||(LA34_0>=ID && LA34_0<=IN)) ) {
                alt34=1;
            }
            else if ( (LA34_0==DOTDOT) ) {
                alt34=2;
            }
            else {
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 34, 0, input);

                throw nvae;
            }
            switch (alt34) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:188:4: tExpression
                    {
                    pushFollow(FOLLOW_tExpression_in_tExpressionOrRange704);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:189:4: ^( DOTDOT tExpression tExpression )
                    {
                    match(input,DOTDOT,FOLLOW_DOTDOT_in_tExpressionOrRange710); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpressionOrRange712);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpressionOrRange714);
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
        }
        return ;
    }
    // $ANTLR end "tExpressionOrRange"


    // $ANTLR start "tConstSection"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:192:1: tConstSection : ^( CONST tConstantDecl ) ;
    public final void tConstSection() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:193:2: ( ^( CONST tConstantDecl ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:193:4: ^( CONST tConstantDecl )
            {
            match(input,CONST,FOLLOW_CONST_in_tConstSection727); if (state.failed) return ;

            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tConstantDecl_in_tConstSection729);
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:196:1: tConstantDecl : id= tIdent tc= tTypedConstant ;
    public final void tConstantDecl() throws RecognitionException {
        SIdCheckControl_stack.push(new SIdCheckControl_scope());

        TDelphiScript3.tIdent_return id = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:198:2: (id= tIdent tc= tTypedConstant )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:198:4: id= tIdent tc= tTypedConstant
            {
            pushFollow(FOLLOW_tIdent_in_tConstantDecl749);
            id=tIdent();

            state._fsp--;
            if (state.failed) return ;
            if ( state.backtracking==0 ) {

              			if (SMethod_stack.size() > 0) 
              				((SMethod_scope)SMethod_stack.peek()).context.ConstDeclared(
              					(id!=null?(input.getTokenStream().toString(
                input.getTreeAdaptor().getTokenStartIndex(id.start),
                input.getTreeAdaptor().getTokenStopIndex(id.start))):null),
              					(id!=null?((CommonTree)id.start):null).getLine(),
              					(id!=null?((CommonTree)id.start):null).getCharPositionInLine()
              				);
              		
            }
            if ( state.backtracking==0 ) {

              			((SIdCheckControl_scope)SIdCheckControl_stack.peek()).id_type = EnumSet.of(IdType.CONST);
              		
            }
            pushFollow(FOLLOW_tTypedConstant_in_tConstantDecl767);
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:214:1: tTypedConstant : tExpression ;
    public final void tTypedConstant() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:215:2: ( tExpression )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:215:4: tExpression
            {
            pushFollow(FOLLOW_tExpression_in_tTypedConstant778);
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:219:1: tExpression options {backtrack=true; memoize=true; } : ( tAtom | ^( tRelOp tExpression tExpression ) | ^( tMulOp tExpression tExpression ) | ^( tAddOp tExpression tExpression ) | ^( tUnaryOperator tExpression ) | tQualifiedAccess | tMethodCall | ^( INDEX tAtom ( tExpression )+ ) | ^( CONST_ARRAY ( tExpression )+ ) );
    public final void tExpression() throws RecognitionException {
        int tExpression_StartIndex = input.index();
        try {
            if ( state.backtracking>0 && alreadyParsedRule(input, 20) ) { return ; }
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:224:2: ( tAtom | ^( tRelOp tExpression tExpression ) | ^( tMulOp tExpression tExpression ) | ^( tAddOp tExpression tExpression ) | ^( tUnaryOperator tExpression ) | tQualifiedAccess | tMethodCall | ^( INDEX tAtom ( tExpression )+ ) | ^( CONST_ARRAY ( tExpression )+ ) )
            int alt37=9;
            alt37 = dfa37.predict(input);
            switch (alt37) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:224:4: tAtom
                    {
                    pushFollow(FOLLOW_tAtom_in_tExpression812);
                    tAtom();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:225:4: ^( tRelOp tExpression tExpression )
                    {
                    pushFollow(FOLLOW_tRelOp_in_tExpression818);
                    tRelOp();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression820);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression822);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:226:4: ^( tMulOp tExpression tExpression )
                    {
                    pushFollow(FOLLOW_tMulOp_in_tExpression829);
                    tMulOp();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression831);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression833);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:227:4: ^( tAddOp tExpression tExpression )
                    {
                    pushFollow(FOLLOW_tAddOp_in_tExpression840);
                    tAddOp();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression842);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression844);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:228:4: ^( tUnaryOperator tExpression )
                    {
                    pushFollow(FOLLOW_tUnaryOperator_in_tExpression851);
                    tUnaryOperator();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tExpression_in_tExpression853);
                    tExpression();

                    state._fsp--;
                    if (state.failed) return ;

                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 6 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:229:4: tQualifiedAccess
                    {
                    pushFollow(FOLLOW_tQualifiedAccess_in_tExpression859);
                    tQualifiedAccess();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 7 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:230:4: tMethodCall
                    {
                    pushFollow(FOLLOW_tMethodCall_in_tExpression864);
                    tMethodCall();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 8 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:231:4: ^( INDEX tAtom ( tExpression )+ )
                    {
                    match(input,INDEX,FOLLOW_INDEX_in_tExpression870); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    pushFollow(FOLLOW_tAtom_in_tExpression872);
                    tAtom();

                    state._fsp--;
                    if (state.failed) return ;
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:231:18: ( tExpression )+
                    int cnt35=0;
                    loop35:
                    do {
                        int alt35=2;
                        int LA35_0 = input.LA(1);

                        if ( ((LA35_0>=METHOD_CALL && LA35_0<=QUALIFIED_ACCESS)||LA35_0==CONST_ARRAY||LA35_0==INT||(LA35_0>=PLUS && LA35_0<=SHR)||(LA35_0>=STRING_LITERAL && LA35_0<=NOT)||LA35_0==EQUAL||(LA35_0>=ID && LA35_0<=IN)) ) {
                            alt35=1;
                        }


                        switch (alt35) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:231:18: tExpression
                    	    {
                    	    pushFollow(FOLLOW_tExpression_in_tExpression874);
                    	    tExpression();

                    	    state._fsp--;
                    	    if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt35 >= 1 ) break loop35;
                    	    if (state.backtracking>0) {state.failed=true; return ;}
                                EarlyExitException eee =
                                    new EarlyExitException(35, input);
                                throw eee;
                        }
                        cnt35++;
                    } while (true);


                    match(input, Token.UP, null); if (state.failed) return ;

                    }
                    break;
                case 9 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:232:4: ^( CONST_ARRAY ( tExpression )+ )
                    {
                    match(input,CONST_ARRAY,FOLLOW_CONST_ARRAY_in_tExpression882); if (state.failed) return ;

                    match(input, Token.DOWN, null); if (state.failed) return ;
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:232:18: ( tExpression )+
                    int cnt36=0;
                    loop36:
                    do {
                        int alt36=2;
                        int LA36_0 = input.LA(1);

                        if ( ((LA36_0>=METHOD_CALL && LA36_0<=QUALIFIED_ACCESS)||LA36_0==CONST_ARRAY||LA36_0==INT||(LA36_0>=PLUS && LA36_0<=SHR)||(LA36_0>=STRING_LITERAL && LA36_0<=NOT)||LA36_0==EQUAL||(LA36_0>=ID && LA36_0<=IN)) ) {
                            alt36=1;
                        }


                        switch (alt36) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:232:18: tExpression
                    	    {
                    	    pushFollow(FOLLOW_tExpression_in_tExpression884);
                    	    tExpression();

                    	    state._fsp--;
                    	    if (state.failed) return ;

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt36 >= 1 ) break loop36;
                    	    if (state.backtracking>0) {state.failed=true; return ;}
                                EarlyExitException eee =
                                    new EarlyExitException(36, input);
                                throw eee;
                        }
                        cnt36++;
                    } while (true);


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
            if ( state.backtracking>0 ) { memoize(input, 20, tExpression_StartIndex); }
        }
        return ;
    }
    // $ANTLR end "tExpression"


    // $ANTLR start "tAtom"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:235:1: tAtom : ( tIdent | tNumber | NIL | TRUE | FALSE | EXCEPTIONMESSAGE | RESULT | STRING_LITERAL );
    public final void tAtom() throws RecognitionException {
        TDelphiScript3.tIdent_return tIdent2 = null;


        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:236:2: ( tIdent | tNumber | NIL | TRUE | FALSE | EXCEPTIONMESSAGE | RESULT | STRING_LITERAL )
            int alt38=8;
            switch ( input.LA(1) ) {
            case ID:
                {
                alt38=1;
                }
                break;
            case INT:
            case FLOAT:
            case HEX:
                {
                alt38=2;
                }
                break;
            case NIL:
                {
                alt38=3;
                }
                break;
            case TRUE:
                {
                alt38=4;
                }
                break;
            case FALSE:
                {
                alt38=5;
                }
                break;
            case EXCEPTIONMESSAGE:
                {
                alt38=6;
                }
                break;
            case RESULT:
                {
                alt38=7;
                }
                break;
            case STRING_LITERAL:
                {
                alt38=8;
                }
                break;
            default:
                if (state.backtracking>0) {state.failed=true; return ;}
                NoViableAltException nvae =
                    new NoViableAltException("", 38, 0, input);

                throw nvae;
            }

            switch (alt38) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:236:4: tIdent
                    {
                    pushFollow(FOLLOW_tIdent_in_tAtom899);
                    tIdent2=tIdent();

                    state._fsp--;
                    if (state.failed) return ;
                    if ( state.backtracking==0 ) {

                      			if (!is_dont_check_next_ident)
                      			{
                      				if (!is_dont_check_ident && (SMethod_stack.size() > 0)) 
                      					((SMethod_scope)SMethod_stack.peek()).context.IdUsed(
                      						(tIdent2!=null?(input.getTokenStream().toString(
                        input.getTreeAdaptor().getTokenStartIndex(tIdent2.start),
                        input.getTreeAdaptor().getTokenStopIndex(tIdent2.start))):null).replaceAll("\\(\\s*(.*?)\\s*\\)", "$1").replaceAll("(.*?);", "$1"),
                      						(tIdent2!=null?((CommonTree)tIdent2.start):null).getLine(),
                      						(tIdent2!=null?((CommonTree)tIdent2.start):null).getCharPositionInLine(),
                      						((SIdCheckControl_scope)SIdCheckControl_stack.peek()).id_type
                      				);
                      			}
                      			else
                      				is_dont_check_next_ident = false;
                      							
                      		
                    }

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:252:4: tNumber
                    {
                    pushFollow(FOLLOW_tNumber_in_tAtom909);
                    tNumber();

                    state._fsp--;
                    if (state.failed) return ;

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:253:5: NIL
                    {
                    match(input,NIL,FOLLOW_NIL_in_tAtom915); if (state.failed) return ;

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:254:4: TRUE
                    {
                    match(input,TRUE,FOLLOW_TRUE_in_tAtom920); if (state.failed) return ;

                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:255:4: FALSE
                    {
                    match(input,FALSE,FOLLOW_FALSE_in_tAtom925); if (state.failed) return ;

                    }
                    break;
                case 6 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:256:4: EXCEPTIONMESSAGE
                    {
                    match(input,EXCEPTIONMESSAGE,FOLLOW_EXCEPTIONMESSAGE_in_tAtom930); if (state.failed) return ;

                    }
                    break;
                case 7 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:257:4: RESULT
                    {
                    match(input,RESULT,FOLLOW_RESULT_in_tAtom935); if (state.failed) return ;

                    }
                    break;
                case 8 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:258:4: STRING_LITERAL
                    {
                    match(input,STRING_LITERAL,FOLLOW_STRING_LITERAL_in_tAtom940); if (state.failed) return ;

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


    // $ANTLR start "tMethodCall"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:261:1: tMethodCall : ^( METHOD_CALL tAtom ( tExpression )* ) ;
    public final void tMethodCall() throws RecognitionException {
        SIdCheckControl_stack.push(new SIdCheckControl_scope());

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:263:2: ( ^( METHOD_CALL tAtom ( tExpression )* ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:263:4: ^( METHOD_CALL tAtom ( tExpression )* )
            {
            match(input,METHOD_CALL,FOLLOW_METHOD_CALL_in_tMethodCall960); if (state.failed) return ;

            if ( state.backtracking==0 ) {
              	
              				((SIdCheckControl_scope)SIdCheckControl_stack.peek()).id_type = EnumSet.of(IdType.METHOD);
              			
            }

            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tAtom_in_tMethodCall973);
            tAtom();

            state._fsp--;
            if (state.failed) return ;
            if ( state.backtracking==0 ) {
              	
              				((SIdCheckControl_scope)SIdCheckControl_stack.peek()).id_type = EnumSet.of(IdType.METHOD, IdType.VAR, IdType.CONST, IdType.UNIT);
              			
            }
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:271:4: ( tExpression )*
            loop39:
            do {
                int alt39=2;
                int LA39_0 = input.LA(1);

                if ( ((LA39_0>=METHOD_CALL && LA39_0<=QUALIFIED_ACCESS)||LA39_0==CONST_ARRAY||LA39_0==INT||(LA39_0>=PLUS && LA39_0<=SHR)||(LA39_0>=STRING_LITERAL && LA39_0<=NOT)||LA39_0==EQUAL||(LA39_0>=ID && LA39_0<=IN)) ) {
                    alt39=1;
                }


                switch (alt39) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:271:4: tExpression
            	    {
            	    pushFollow(FOLLOW_tExpression_in_tMethodCall985);
            	    tExpression();

            	    state._fsp--;
            	    if (state.failed) return ;

            	    }
            	    break;

            	default :
            	    break loop39;
                }
            } while (true);


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
    // $ANTLR end "tMethodCall"


    // $ANTLR start "tQualifiedAccess"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:274:1: tQualifiedAccess : ^( QUALIFIED_ACCESS tExpression tExpression ) ;
    public final void tQualifiedAccess() throws RecognitionException {
        SIdCheckControl_stack.push(new SIdCheckControl_scope());

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:276:2: ( ^( QUALIFIED_ACCESS tExpression tExpression ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:276:4: ^( QUALIFIED_ACCESS tExpression tExpression )
            {
            match(input,QUALIFIED_ACCESS,FOLLOW_QUALIFIED_ACCESS_in_tQualifiedAccess1005); if (state.failed) return ;

            if ( state.backtracking==0 ) {

              				((SIdCheckControl_scope)SIdCheckControl_stack.peek()).id_type = EnumSet.of(IdType.VAR, IdType.METHOD, IdType.UNIT);
              			
            }

            match(input, Token.DOWN, null); if (state.failed) return ;
            pushFollow(FOLLOW_tExpression_in_tQualifiedAccess1017);
            tExpression();

            state._fsp--;
            if (state.failed) return ;
            if ( state.backtracking==0 ) {
              	
              				is_dont_check_next_ident = true;
              			
            }
            pushFollow(FOLLOW_tExpression_in_tQualifiedAccess1029);
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
            SIdCheckControl_stack.pop();

        }
        return ;
    }
    // $ANTLR end "tQualifiedAccess"


    // $ANTLR start "tNumber"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:291:1: tNumber : ( INT | FLOAT | HEX );
    public final void tNumber() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:292:2: ( INT | FLOAT | HEX )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:297:1: tUnaryOperator : ( NOT | MINUS );
    public final void tUnaryOperator() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:298:2: ( NOT | MINUS )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:302:1: tAddOp : ( PLUS | MINUS | OR | XOR );
    public final void tAddOp() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:303:2: ( PLUS | MINUS | OR | XOR )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:309:1: tMulOp : ( STAR | SLASH | DIV | MOD | AND | SHL | SHR );
    public final void tMulOp() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:310:2: ( STAR | SLASH | DIV | MOD | AND | SHL | SHR )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:319:1: tRelOp : ( EQUAL | NOT_EQUAL | LT | LE | GE | GT | IN );
    public final void tRelOp() throws RecognitionException {
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:320:2: ( EQUAL | NOT_EQUAL | LT | LE | GE | GT | IN )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:
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
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:329:1: tIdent : ID ;
    public final TDelphiScript3.tIdent_return tIdent() throws RecognitionException {
        TDelphiScript3.tIdent_return retval = new TDelphiScript3.tIdent_return();
        retval.start = input.LT(1);

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:330:2: ( ID )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:330:4: ID
            {
            match(input,ID,FOLLOW_ID_in_tIdent1201); if (state.failed) return retval;

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

    // $ANTLR start synpred4_TDelphiScript3
    public final void synpred4_TDelphiScript3_fragment() throws RecognitionException {   
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:227:4: ( ^( tAddOp tExpression tExpression ) )
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:227:4: ^( tAddOp tExpression tExpression )
        {
        pushFollow(FOLLOW_tAddOp_in_synpred4_TDelphiScript3840);
        tAddOp();

        state._fsp--;
        if (state.failed) return ;

        match(input, Token.DOWN, null); if (state.failed) return ;
        pushFollow(FOLLOW_tExpression_in_synpred4_TDelphiScript3842);
        tExpression();

        state._fsp--;
        if (state.failed) return ;
        pushFollow(FOLLOW_tExpression_in_synpred4_TDelphiScript3844);
        tExpression();

        state._fsp--;
        if (state.failed) return ;

        match(input, Token.UP, null); if (state.failed) return ;

        }
    }
    // $ANTLR end synpred4_TDelphiScript3

    // $ANTLR start synpred5_TDelphiScript3
    public final void synpred5_TDelphiScript3_fragment() throws RecognitionException {   
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:228:4: ( ^( tUnaryOperator tExpression ) )
        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\TDelphiScript3.g:228:4: ^( tUnaryOperator tExpression )
        {
        pushFollow(FOLLOW_tUnaryOperator_in_synpred5_TDelphiScript3851);
        tUnaryOperator();

        state._fsp--;
        if (state.failed) return ;

        match(input, Token.DOWN, null); if (state.failed) return ;
        pushFollow(FOLLOW_tExpression_in_synpred5_TDelphiScript3853);
        tExpression();

        state._fsp--;
        if (state.failed) return ;

        match(input, Token.UP, null); if (state.failed) return ;

        }
    }
    // $ANTLR end synpred5_TDelphiScript3

    // Delegated rules

    public final boolean synpred5_TDelphiScript3() {
        state.backtracking++;
        int start = input.mark();
        try {
            synpred5_TDelphiScript3_fragment(); // can never throw exception
        } catch (RecognitionException re) {
            System.err.println("impossible: "+re);
        }
        boolean success = !state.failed;
        input.rewind(start);
        state.backtracking--;
        state.failed=false;
        return success;
    }
    public final boolean synpred4_TDelphiScript3() {
        state.backtracking++;
        int start = input.mark();
        try {
            synpred4_TDelphiScript3_fragment(); // can never throw exception
        } catch (RecognitionException re) {
            System.err.println("impossible: "+re);
        }
        boolean success = !state.failed;
        input.rewind(start);
        state.backtracking--;
        state.failed=false;
        return success;
    }


    protected DFA37 dfa37 = new DFA37(this);
    static final String DFA37_eotS =
        "\22\uffff";
    static final String DFA37_eofS =
        "\22\uffff";
    static final String DFA37_minS =
        "\1\12\12\uffff\1\0\6\uffff";
    static final String DFA37_maxS =
        "\1\125\12\uffff\1\0\6\uffff";
    static final String DFA37_acceptS =
        "\1\uffff\1\1\7\uffff\1\2\1\3\1\uffff\1\4\1\5\1\6\1\7\1\10\1\11";
    static final String DFA37_specialS =
        "\13\uffff\1\0\6\uffff}>";
    static final String[] DFA37_transitionS = {
            "\1\17\1\20\1\16\2\uffff\1\21\34\uffff\1\1\1\uffff\1\14\1\13"+
            "\2\14\7\12\5\uffff\10\1\1\15\3\uffff\1\11\4\uffff\1\1\6\11",
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
            "\1\uffff",
            "",
            "",
            "",
            "",
            "",
            ""
    };

    static final short[] DFA37_eot = DFA.unpackEncodedString(DFA37_eotS);
    static final short[] DFA37_eof = DFA.unpackEncodedString(DFA37_eofS);
    static final char[] DFA37_min = DFA.unpackEncodedStringToUnsignedChars(DFA37_minS);
    static final char[] DFA37_max = DFA.unpackEncodedStringToUnsignedChars(DFA37_maxS);
    static final short[] DFA37_accept = DFA.unpackEncodedString(DFA37_acceptS);
    static final short[] DFA37_special = DFA.unpackEncodedString(DFA37_specialS);
    static final short[][] DFA37_transition;

    static {
        int numStates = DFA37_transitionS.length;
        DFA37_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA37_transition[i] = DFA.unpackEncodedString(DFA37_transitionS[i]);
        }
    }

    class DFA37 extends DFA {

        public DFA37(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 37;
            this.eot = DFA37_eot;
            this.eof = DFA37_eof;
            this.min = DFA37_min;
            this.max = DFA37_max;
            this.accept = DFA37_accept;
            this.special = DFA37_special;
            this.transition = DFA37_transition;
        }
        public String getDescription() {
            return "219:1: tExpression options {backtrack=true; memoize=true; } : ( tAtom | ^( tRelOp tExpression tExpression ) | ^( tMulOp tExpression tExpression ) | ^( tAddOp tExpression tExpression ) | ^( tUnaryOperator tExpression ) | tQualifiedAccess | tMethodCall | ^( INDEX tAtom ( tExpression )+ ) | ^( CONST_ARRAY ( tExpression )+ ) );";
        }
        public int specialStateTransition(int s, IntStream _input) throws NoViableAltException {
            TreeNodeStream input = (TreeNodeStream)_input;
        	int _s = s;
            switch ( s ) {
                    case 0 : 
                        int LA37_11 = input.LA(1);

                         
                        int index37_11 = input.index();
                        input.rewind();
                        s = -1;
                        if ( (synpred4_TDelphiScript3()) ) {s = 12;}

                        else if ( (synpred5_TDelphiScript3()) ) {s = 13;}

                         
                        input.seek(index37_11);
                        if ( s>=0 ) return s;
                        break;
            }
            if (state.backtracking>0) {state.failed=true; return -1;}
            NoViableAltException nvae =
                new NoViableAltException(getDescription(), 37, _s, input);
            error(nvae);
            throw nvae;
        }
    }
 

    public static final BitSet FOLLOW_UNIT_in_tGoal71 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tUses_in_tGoal73 = new BitSet(new long[]{0x0000000000002000L});
    public static final BitSet FOLLOW_IMPL_DECL_in_tGoal77 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tImplementationDecl_in_tGoal79 = new BitSet(new long[]{0x00000C00000000C8L,0x0000000000000200L});
    public static final BitSet FOLLOW_USES_in_tUses95 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tIdent_in_tUses102 = new BitSet(new long[]{0x0000000000000008L,0x0000000000008000L});
    public static final BitSet FOLLOW_CONST_in_tImplementationDecl128 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tConstantDecl_in_tImplementationDecl130 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tMethodDef_in_tImplementationDecl136 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_METHOD_DECL_in_tImplementationDecl142 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_VAR_in_tImplementationDecl153 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tVarDecl_in_tImplementationDecl155 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_LABEL_in_tImplementationDecl162 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_METHOD_DEF_in_tMethodDef183 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tMethodHeading_in_tMethodDef185 = new BitSet(new long[]{0x0000000000002000L});
    public static final BitSet FOLLOW_tFancyBlock_in_tMethodDef187 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_IMPL_DECL_in_tFancyBlock200 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tImplementationDecl_in_tFancyBlock202 = new BitSet(new long[]{0x00000C00000000C8L,0x0000000000000200L});
    public static final BitSet FOLLOW_tBlock_in_tFancyBlock206 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_BLOCK_in_tBlock218 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tStatement_in_tBlock220 = new BitSet(new long[]{0xC1FFD28B34F09D08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_COLON_in_tStatement235 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tLabelId_in_tStatement237 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tExpression_in_tStatement247 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tAssign_in_tStatement253 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_GOTO_in_tStatement260 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tLabelId_in_tStatement262 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tBlock_in_tStatement269 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_CASE_in_tStatement276 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tStatement278 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_tCaseSelector_in_tStatement280 = new BitSet(new long[]{0x0000002000004008L});
    public static final BitSet FOLLOW_ELSE_in_tStatement285 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tStatement_in_tStatement287 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_REPEAT_in_tStatement300 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_BLOCK_in_tStatement303 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tStatement_in_tStatement305 = new BitSet(new long[]{0xC1FFD28B34F09D08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_tStatement309 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_WHILE_in_tStatement317 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tStatement319 = new BitSet(new long[]{0xC1FFD28B34F09D08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tStatement_in_tStatement321 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_FOR_in_tStatement330 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tIdent_in_tStatement332 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_tStatement334 = new BitSet(new long[]{0x00000000C0000000L});
    public static final BitSet FOLLOW_set_in_tStatement336 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_tStatement342 = new BitSet(new long[]{0xC1FFD28B34F09D08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tStatement_in_tStatement344 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tWithStatement_in_tStatement351 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_TRY_in_tStatement358 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_BLOCK_in_tStatement361 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tStatement_in_tStatement363 = new BitSet(new long[]{0xC1FFD28B34F09D08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_set_in_tStatement368 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tStatement_in_tStatement374 = new BitSet(new long[]{0xC1FFD28B34F09D08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_RAISE_in_tStatement385 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tStatement387 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_IF_in_tStatement396 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tStatement398 = new BitSet(new long[]{0x0000010000000000L});
    public static final BitSet FOLLOW_THEN_in_tStatement401 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tStatement_in_tStatement403 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_ELSE_in_tStatement409 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tStatement_in_tStatement411 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_BREAK_in_tStatement422 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_WITH_in_tWithStatement442 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tWithStatement453 = new BitSet(new long[]{0xC1FFD28B34F09D08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tStatement_in_tWithStatement468 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_ASSIGN_in_tAssign498 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tAssign510 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_tAssign522 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_CASE_SELECTOR_in_tCaseSelector538 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpressionOrRange_in_tCaseSelector540 = new BitSet(new long[]{0xC1FFD00000009D08L,0x00000000007F847FL});
    public static final BitSet FOLLOW_BLOCK_in_tCaseSelector544 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tStatement_in_tCaseSelector546 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_INT_in_tLabelId560 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tIdent_in_tLabelId565 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tMethodHeading577 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tIdent_in_tMethodHeading585 = new BitSet(new long[]{0x0000000000000018L,0x000000000000C180L});
    public static final BitSet FOLLOW_tFormalParameter_in_tMethodHeading595 = new BitSet(new long[]{0x0000000000000018L,0x000000000000C180L});
    public static final BitSet FOLLOW_tType_in_tMethodHeading600 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_FORMAL_PARAMETER_in_tFormalParameter614 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tIdent_in_tFormalParameter618 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003FC5FFL});
    public static final BitSet FOLLOW_tType_in_tFormalParameter620 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tTypedConstant_in_tFormalParameter623 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tIdent_in_tVarDecl642 = new BitSet(new long[]{0x000000000000000AL,0x000000000000C180L});
    public static final BitSet FOLLOW_tType_in_tVarDecl646 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tIdent_in_tType662 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ARRAY_in_tType668 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpressionOrRange_in_tType670 = new BitSet(new long[]{0xC1FFD00000009D08L,0x00000000007FC5FFL});
    public static final BitSet FOLLOW_tType_in_tType673 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_FILE_in_tType680 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_FILE_in_tType683 = new BitSet(new long[]{0x0000001000000000L});
    public static final BitSet FOLLOW_OF_in_tType685 = new BitSet(new long[]{0x0000000000000008L,0x0000000000008000L});
    public static final BitSet FOLLOW_tIdent_in_tType687 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_in_tType693 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tExpression_in_tExpressionOrRange704 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_DOTDOT_in_tExpressionOrRange710 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpressionOrRange712 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_tExpressionOrRange714 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_CONST_in_tConstSection727 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tConstantDecl_in_tConstSection729 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tIdent_in_tConstantDecl749 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tTypedConstant_in_tConstantDecl767 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tExpression_in_tTypedConstant778 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tAtom_in_tExpression812 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tRelOp_in_tExpression818 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression820 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_tExpression822 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tMulOp_in_tExpression829 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression831 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_tExpression833 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tAddOp_in_tExpression840 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression842 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_tExpression844 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tUnaryOperator_in_tExpression851 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression853 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tQualifiedAccess_in_tExpression859 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tMethodCall_in_tExpression864 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_INDEX_in_tExpression870 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tAtom_in_tExpression872 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_tExpression874 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_CONST_ARRAY_in_tExpression882 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tExpression884 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tIdent_in_tAtom899 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tNumber_in_tAtom909 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_NIL_in_tAtom915 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_TRUE_in_tAtom920 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_FALSE_in_tAtom925 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_EXCEPTIONMESSAGE_in_tAtom930 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RESULT_in_tAtom935 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_LITERAL_in_tAtom940 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_METHOD_CALL_in_tMethodCall960 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tAtom_in_tMethodCall973 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_tMethodCall985 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_QUALIFIED_ACCESS_in_tQualifiedAccess1005 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_tQualifiedAccess1017 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_tQualifiedAccess1029 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_set_in_tNumber0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tUnaryOperator0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tAddOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tMulOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_tRelOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_tIdent1201 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tAddOp_in_synpred4_TDelphiScript3840 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_synpred4_TDelphiScript3842 = new BitSet(new long[]{0xC1FFD00000009C08L,0x00000000003F847FL});
    public static final BitSet FOLLOW_tExpression_in_synpred4_TDelphiScript3844 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_tUnaryOperator_in_synpred5_TDelphiScript3851 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_tExpression_in_synpred5_TDelphiScript3853 = new BitSet(new long[]{0x0000000000000008L});

}