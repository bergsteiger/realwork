// $ANTLR 3.3 Nov 30, 2010 12:45:30 W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g 2011-08-08 22:14:58

	package dsparser.antlr.generated;


import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;


import org.antlr.runtime.tree.*;

public class DelphiScriptParser extends Parser {
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


        public DelphiScriptParser(TokenStream input) {
            this(input, new RecognizerSharedState());
        }
        public DelphiScriptParser(TokenStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        
    protected TreeAdaptor adaptor = new CommonTreeAdaptor();

    public void setTreeAdaptor(TreeAdaptor adaptor) {
        this.adaptor = adaptor;
    }
    public TreeAdaptor getTreeAdaptor() {
        return adaptor;
    }

    public String[] getTokenNames() { return DelphiScriptParser.tokenNames; }
    public String getGrammarFileName() { return "W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g"; }


    public static class goal_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "goal"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:36:1: goal : sdUnit ;
    public final DelphiScriptParser.goal_return goal() throws RecognitionException {
        DelphiScriptParser.goal_return retval = new DelphiScriptParser.goal_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.sdUnit_return sdUnit1 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:37:2: ( sdUnit )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:37:5: sdUnit
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_sdUnit_in_goal110);
            sdUnit1=sdUnit();

            state._fsp--;

            adaptor.addChild(root_0, sdUnit1.getTree());

            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "goal"

    public static class sdUnit_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "sdUnit"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:40:1: sdUnit : ( usesClause )? ( implementationDecl )* -> ^( UNIT ( usesClause )? ^( IMPL_DECL ( implementationDecl )* ) ) ;
    public final DelphiScriptParser.sdUnit_return sdUnit() throws RecognitionException {
        DelphiScriptParser.sdUnit_return retval = new DelphiScriptParser.sdUnit_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.usesClause_return usesClause2 = null;

        DelphiScriptParser.implementationDecl_return implementationDecl3 = null;


        RewriteRuleSubtreeStream stream_usesClause=new RewriteRuleSubtreeStream(adaptor,"rule usesClause");
        RewriteRuleSubtreeStream stream_implementationDecl=new RewriteRuleSubtreeStream(adaptor,"rule implementationDecl");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:41:2: ( ( usesClause )? ( implementationDecl )* -> ^( UNIT ( usesClause )? ^( IMPL_DECL ( implementationDecl )* ) ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:41:4: ( usesClause )? ( implementationDecl )*
            {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:41:4: ( usesClause )?
            int alt1=2;
            int LA1_0 = input.LA(1);

            if ( (LA1_0==USES) ) {
                alt1=1;
            }
            switch (alt1) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:41:4: usesClause
                    {
                    pushFollow(FOLLOW_usesClause_in_sdUnit122);
                    usesClause2=usesClause();

                    state._fsp--;

                    stream_usesClause.add(usesClause2.getTree());

                    }
                    break;

            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:42:3: ( implementationDecl )*
            loop2:
            do {
                int alt2=2;
                int LA2_0 = input.LA(1);

                if ( ((LA2_0>=VAR && LA2_0<=LABEL)||LA2_0==CONST||(LA2_0>=PROCEDURE && LA2_0<=FUNCTION)) ) {
                    alt2=1;
                }


                switch (alt2) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:42:3: implementationDecl
            	    {
            	    pushFollow(FOLLOW_implementationDecl_in_sdUnit128);
            	    implementationDecl3=implementationDecl();

            	    state._fsp--;

            	    stream_implementationDecl.add(implementationDecl3.getTree());

            	    }
            	    break;

            	default :
            	    break loop2;
                }
            } while (true);



            // AST REWRITE
            // elements: usesClause, implementationDecl
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 43:3: -> ^( UNIT ( usesClause )? ^( IMPL_DECL ( implementationDecl )* ) )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:43:6: ^( UNIT ( usesClause )? ^( IMPL_DECL ( implementationDecl )* ) )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(UNIT, "UNIT"), root_1);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:43:13: ( usesClause )?
                if ( stream_usesClause.hasNext() ) {
                    adaptor.addChild(root_1, stream_usesClause.nextTree());

                }
                stream_usesClause.reset();
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:43:25: ^( IMPL_DECL ( implementationDecl )* )
                {
                CommonTree root_2 = (CommonTree)adaptor.nil();
                root_2 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(IMPL_DECL, "IMPL_DECL"), root_2);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:43:37: ( implementationDecl )*
                while ( stream_implementationDecl.hasNext() ) {
                    adaptor.addChild(root_2, stream_implementationDecl.nextTree());

                }
                stream_implementationDecl.reset();

                adaptor.addChild(root_1, root_2);
                }

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "sdUnit"

    public static class implementationDecl_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "implementationDecl"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:47:1: implementationDecl : ( labelDeclSection | constSection | varSection | methodImplOrForwardDecl );
    public final DelphiScriptParser.implementationDecl_return implementationDecl() throws RecognitionException {
        DelphiScriptParser.implementationDecl_return retval = new DelphiScriptParser.implementationDecl_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.labelDeclSection_return labelDeclSection4 = null;

        DelphiScriptParser.constSection_return constSection5 = null;

        DelphiScriptParser.varSection_return varSection6 = null;

        DelphiScriptParser.methodImplOrForwardDecl_return methodImplOrForwardDecl7 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:48:2: ( labelDeclSection | constSection | varSection | methodImplOrForwardDecl )
            int alt3=4;
            switch ( input.LA(1) ) {
            case LABEL:
                {
                alt3=1;
                }
                break;
            case CONST:
                {
                alt3=2;
                }
                break;
            case VAR:
                {
                alt3=3;
                }
                break;
            case PROCEDURE:
            case FUNCTION:
                {
                alt3=4;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 3, 0, input);

                throw nvae;
            }

            switch (alt3) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:48:5: labelDeclSection
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_labelDeclSection_in_implementationDecl160);
                    labelDeclSection4=labelDeclSection();

                    state._fsp--;

                    adaptor.addChild(root_0, labelDeclSection4.getTree());

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:49:4: constSection
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_constSection_in_implementationDecl165);
                    constSection5=constSection();

                    state._fsp--;

                    adaptor.addChild(root_0, constSection5.getTree());

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:50:4: varSection
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_varSection_in_implementationDecl170);
                    varSection6=varSection();

                    state._fsp--;

                    adaptor.addChild(root_0, varSection6.getTree());

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:51:4: methodImplOrForwardDecl
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_methodImplOrForwardDecl_in_implementationDecl175);
                    methodImplOrForwardDecl7=methodImplOrForwardDecl();

                    state._fsp--;

                    adaptor.addChild(root_0, methodImplOrForwardDecl7.getTree());

                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "implementationDecl"

    public static class methodImplOrForwardDecl_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "methodImplOrForwardDecl"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:54:1: methodImplOrForwardDecl : methodHeading ( fancyBlock -> ^( METHOD_DEF methodHeading fancyBlock ) | FORWARD -> ^( METHOD_DECL methodHeading ) ) SEMI ;
    public final DelphiScriptParser.methodImplOrForwardDecl_return methodImplOrForwardDecl() throws RecognitionException {
        DelphiScriptParser.methodImplOrForwardDecl_return retval = new DelphiScriptParser.methodImplOrForwardDecl_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token FORWARD10=null;
        Token SEMI11=null;
        DelphiScriptParser.methodHeading_return methodHeading8 = null;

        DelphiScriptParser.fancyBlock_return fancyBlock9 = null;


        CommonTree FORWARD10_tree=null;
        CommonTree SEMI11_tree=null;
        RewriteRuleTokenStream stream_FORWARD=new RewriteRuleTokenStream(adaptor,"token FORWARD");
        RewriteRuleTokenStream stream_SEMI=new RewriteRuleTokenStream(adaptor,"token SEMI");
        RewriteRuleSubtreeStream stream_methodHeading=new RewriteRuleSubtreeStream(adaptor,"rule methodHeading");
        RewriteRuleSubtreeStream stream_fancyBlock=new RewriteRuleSubtreeStream(adaptor,"rule fancyBlock");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:55:2: ( methodHeading ( fancyBlock -> ^( METHOD_DEF methodHeading fancyBlock ) | FORWARD -> ^( METHOD_DECL methodHeading ) ) SEMI )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:55:4: methodHeading ( fancyBlock -> ^( METHOD_DEF methodHeading fancyBlock ) | FORWARD -> ^( METHOD_DECL methodHeading ) ) SEMI
            {
            pushFollow(FOLLOW_methodHeading_in_methodImplOrForwardDecl186);
            methodHeading8=methodHeading();

            state._fsp--;

            stream_methodHeading.add(methodHeading8.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:56:3: ( fancyBlock -> ^( METHOD_DEF methodHeading fancyBlock ) | FORWARD -> ^( METHOD_DECL methodHeading ) )
            int alt4=2;
            int LA4_0 = input.LA(1);

            if ( (LA4_0==BEGIN||(LA4_0>=VAR && LA4_0<=LABEL)||LA4_0==CONST||(LA4_0>=PROCEDURE && LA4_0<=FUNCTION)) ) {
                alt4=1;
            }
            else if ( (LA4_0==FORWARD) ) {
                alt4=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 4, 0, input);

                throw nvae;
            }
            switch (alt4) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:57:4: fancyBlock
                    {
                    pushFollow(FOLLOW_fancyBlock_in_methodImplOrForwardDecl196);
                    fancyBlock9=fancyBlock();

                    state._fsp--;

                    stream_fancyBlock.add(fancyBlock9.getTree());


                    // AST REWRITE
                    // elements: fancyBlock, methodHeading
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 57:15: -> ^( METHOD_DEF methodHeading fancyBlock )
                    {
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:57:18: ^( METHOD_DEF methodHeading fancyBlock )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(METHOD_DEF, "METHOD_DEF"), root_1);

                        adaptor.addChild(root_1, stream_methodHeading.nextTree());
                        adaptor.addChild(root_1, stream_fancyBlock.nextTree());

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:58:6: FORWARD
                    {
                    FORWARD10=(Token)match(input,FORWARD,FOLLOW_FORWARD_in_methodImplOrForwardDecl213);  
                    stream_FORWARD.add(FORWARD10);



                    // AST REWRITE
                    // elements: methodHeading
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 58:15: -> ^( METHOD_DECL methodHeading )
                    {
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:58:18: ^( METHOD_DECL methodHeading )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(METHOD_DECL, "METHOD_DECL"), root_1);

                        adaptor.addChild(root_1, stream_methodHeading.nextTree());

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;

            }

            SEMI11=(Token)match(input,SEMI,FOLLOW_SEMI_in_methodImplOrForwardDecl230);  
            stream_SEMI.add(SEMI11);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "methodImplOrForwardDecl"

    public static class fancyBlock_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "fancyBlock"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:63:1: fancyBlock : ( implementationDecl )* block -> ^( IMPL_DECL ( implementationDecl )* ) block ;
    public final DelphiScriptParser.fancyBlock_return fancyBlock() throws RecognitionException {
        DelphiScriptParser.fancyBlock_return retval = new DelphiScriptParser.fancyBlock_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.implementationDecl_return implementationDecl12 = null;

        DelphiScriptParser.block_return block13 = null;


        RewriteRuleSubtreeStream stream_block=new RewriteRuleSubtreeStream(adaptor,"rule block");
        RewriteRuleSubtreeStream stream_implementationDecl=new RewriteRuleSubtreeStream(adaptor,"rule implementationDecl");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:64:2: ( ( implementationDecl )* block -> ^( IMPL_DECL ( implementationDecl )* ) block )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:64:4: ( implementationDecl )* block
            {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:64:4: ( implementationDecl )*
            loop5:
            do {
                int alt5=2;
                int LA5_0 = input.LA(1);

                if ( ((LA5_0>=VAR && LA5_0<=LABEL)||LA5_0==CONST||(LA5_0>=PROCEDURE && LA5_0<=FUNCTION)) ) {
                    alt5=1;
                }


                switch (alt5) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:64:4: implementationDecl
            	    {
            	    pushFollow(FOLLOW_implementationDecl_in_fancyBlock242);
            	    implementationDecl12=implementationDecl();

            	    state._fsp--;

            	    stream_implementationDecl.add(implementationDecl12.getTree());

            	    }
            	    break;

            	default :
            	    break loop5;
                }
            } while (true);

            pushFollow(FOLLOW_block_in_fancyBlock245);
            block13=block();

            state._fsp--;

            stream_block.add(block13.getTree());


            // AST REWRITE
            // elements: block, implementationDecl
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 64:30: -> ^( IMPL_DECL ( implementationDecl )* ) block
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:64:33: ^( IMPL_DECL ( implementationDecl )* )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(IMPL_DECL, "IMPL_DECL"), root_1);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:64:45: ( implementationDecl )*
                while ( stream_implementationDecl.hasNext() ) {
                    adaptor.addChild(root_1, stream_implementationDecl.nextTree());

                }
                stream_implementationDecl.reset();

                adaptor.addChild(root_0, root_1);
                }
                adaptor.addChild(root_0, stream_block.nextTree());

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "fancyBlock"

    public static class block_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "block"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:67:1: block : BEGIN ( statementList | SEMI )? END -> ^( BLOCK ( statementList )? ) ;
    public final DelphiScriptParser.block_return block() throws RecognitionException {
        DelphiScriptParser.block_return retval = new DelphiScriptParser.block_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token BEGIN14=null;
        Token SEMI16=null;
        Token END17=null;
        DelphiScriptParser.statementList_return statementList15 = null;


        CommonTree BEGIN14_tree=null;
        CommonTree SEMI16_tree=null;
        CommonTree END17_tree=null;
        RewriteRuleTokenStream stream_END=new RewriteRuleTokenStream(adaptor,"token END");
        RewriteRuleTokenStream stream_SEMI=new RewriteRuleTokenStream(adaptor,"token SEMI");
        RewriteRuleTokenStream stream_BEGIN=new RewriteRuleTokenStream(adaptor,"token BEGIN");
        RewriteRuleSubtreeStream stream_statementList=new RewriteRuleSubtreeStream(adaptor,"rule statementList");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:68:2: ( BEGIN ( statementList | SEMI )? END -> ^( BLOCK ( statementList )? ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:68:4: BEGIN ( statementList | SEMI )? END
            {
            BEGIN14=(Token)match(input,BEGIN,FOLLOW_BEGIN_in_block267);  
            stream_BEGIN.add(BEGIN14);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:68:10: ( statementList | SEMI )?
            int alt6=3;
            int LA6_0 = input.LA(1);

            if ( (LA6_0==BEGIN||(LA6_0>=BREAK && LA6_0<=TRY)||LA6_0==WITH||LA6_0==FOR||(LA6_0>=WHILE && LA6_0<=REPEAT)||LA6_0==CASE||LA6_0==IF||LA6_0==GOTO||LA6_0==INT||LA6_0==MINUS||LA6_0==LSQBR||LA6_0==LPAREN||(LA6_0>=STRING_LITERAL && LA6_0<=NOT)||(LA6_0>=FILE && LA6_0<=ID)) ) {
                alt6=1;
            }
            else if ( (LA6_0==SEMI) ) {
                alt6=2;
            }
            switch (alt6) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:68:11: statementList
                    {
                    pushFollow(FOLLOW_statementList_in_block270);
                    statementList15=statementList();

                    state._fsp--;

                    stream_statementList.add(statementList15.getTree());

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:68:25: SEMI
                    {
                    SEMI16=(Token)match(input,SEMI,FOLLOW_SEMI_in_block272);  
                    stream_SEMI.add(SEMI16);


                    }
                    break;

            }

            END17=(Token)match(input,END,FOLLOW_END_in_block276);  
            stream_END.add(END17);



            // AST REWRITE
            // elements: statementList
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 68:36: -> ^( BLOCK ( statementList )? )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:68:39: ^( BLOCK ( statementList )? )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(BLOCK, "BLOCK"), root_1);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:68:47: ( statementList )?
                if ( stream_statementList.hasNext() ) {
                    adaptor.addChild(root_1, stream_statementList.nextTree());

                }
                stream_statementList.reset();

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "block"

    public static class statementList_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "statementList"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:71:1: statementList : ( statement SEMI )+ ;
    public final DelphiScriptParser.statementList_return statementList() throws RecognitionException {
        DelphiScriptParser.statementList_return retval = new DelphiScriptParser.statementList_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token SEMI19=null;
        DelphiScriptParser.statement_return statement18 = null;


        CommonTree SEMI19_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:72:2: ( ( statement SEMI )+ )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:72:4: ( statement SEMI )+
            {
            root_0 = (CommonTree)adaptor.nil();

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:72:4: ( statement SEMI )+
            int cnt7=0;
            loop7:
            do {
                int alt7=2;
                int LA7_0 = input.LA(1);

                if ( (LA7_0==BEGIN||(LA7_0>=BREAK && LA7_0<=TRY)||LA7_0==WITH||LA7_0==FOR||(LA7_0>=WHILE && LA7_0<=REPEAT)||LA7_0==CASE||LA7_0==IF||LA7_0==GOTO||LA7_0==INT||LA7_0==MINUS||LA7_0==LSQBR||LA7_0==LPAREN||(LA7_0>=STRING_LITERAL && LA7_0<=NOT)||(LA7_0>=FILE && LA7_0<=ID)) ) {
                    alt7=1;
                }


                switch (alt7) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:72:5: statement SEMI
            	    {
            	    pushFollow(FOLLOW_statement_in_statementList299);
            	    statement18=statement();

            	    state._fsp--;

            	    adaptor.addChild(root_0, statement18.getTree());
            	    SEMI19=(Token)match(input,SEMI,FOLLOW_SEMI_in_statementList301); 

            	    }
            	    break;

            	default :
            	    if ( cnt7 >= 1 ) break loop7;
                        EarlyExitException eee =
                            new EarlyExitException(7, input);
                        throw eee;
                }
                cnt7++;
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "statementList"

    public static class statement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "statement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:76:1: statement : ( labelId COLON | ( labelId COLON )? simpleStatement );
    public final DelphiScriptParser.statement_return statement() throws RecognitionException {
        DelphiScriptParser.statement_return retval = new DelphiScriptParser.statement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token COLON21=null;
        Token COLON23=null;
        DelphiScriptParser.labelId_return labelId20 = null;

        DelphiScriptParser.labelId_return labelId22 = null;

        DelphiScriptParser.simpleStatement_return simpleStatement24 = null;


        CommonTree COLON21_tree=null;
        CommonTree COLON23_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:77:2: ( labelId COLON | ( labelId COLON )? simpleStatement )
            int alt9=2;
            switch ( input.LA(1) ) {
            case INT:
                {
                int LA9_1 = input.LA(2);

                if ( (LA9_1==COLON) ) {
                    int LA9_5 = input.LA(3);

                    if ( (LA9_5==SEMI||LA9_5==ELSE) ) {
                        alt9=1;
                    }
                    else if ( (LA9_5==BEGIN||(LA9_5>=BREAK && LA9_5<=TRY)||LA9_5==WITH||LA9_5==FOR||(LA9_5>=WHILE && LA9_5<=REPEAT)||LA9_5==CASE||LA9_5==IF||LA9_5==GOTO||LA9_5==INT||LA9_5==MINUS||LA9_5==LSQBR||LA9_5==LPAREN||(LA9_5>=STRING_LITERAL && LA9_5<=NOT)||(LA9_5>=FILE && LA9_5<=ID)) ) {
                        alt9=2;
                    }
                    else {
                        NoViableAltException nvae =
                            new NoViableAltException("", 9, 5, input);

                        throw nvae;
                    }
                }
                else if ( (LA9_1==SEMI||LA9_1==ASSIGN||LA9_1==ELSE||(LA9_1>=PLUS && LA9_1<=LSQBR)||LA9_1==LPAREN||LA9_1==EQUAL||(LA9_1>=NOT_EQUAL && LA9_1<=IN)) ) {
                    alt9=2;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 9, 1, input);

                    throw nvae;
                }
                }
                break;
            case ID:
                {
                int LA9_2 = input.LA(2);

                if ( (LA9_2==COLON) ) {
                    int LA9_5 = input.LA(3);

                    if ( (LA9_5==SEMI||LA9_5==ELSE) ) {
                        alt9=1;
                    }
                    else if ( (LA9_5==BEGIN||(LA9_5>=BREAK && LA9_5<=TRY)||LA9_5==WITH||LA9_5==FOR||(LA9_5>=WHILE && LA9_5<=REPEAT)||LA9_5==CASE||LA9_5==IF||LA9_5==GOTO||LA9_5==INT||LA9_5==MINUS||LA9_5==LSQBR||LA9_5==LPAREN||(LA9_5>=STRING_LITERAL && LA9_5<=NOT)||(LA9_5>=FILE && LA9_5<=ID)) ) {
                        alt9=2;
                    }
                    else {
                        NoViableAltException nvae =
                            new NoViableAltException("", 9, 5, input);

                        throw nvae;
                    }
                }
                else if ( (LA9_2==SEMI||LA9_2==ASSIGN||LA9_2==ELSE||(LA9_2>=PLUS && LA9_2<=LSQBR)||LA9_2==LPAREN||LA9_2==EQUAL||(LA9_2>=NOT_EQUAL && LA9_2<=IN)) ) {
                    alt9=2;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 9, 2, input);

                    throw nvae;
                }
                }
                break;
            case FILE:
                {
                int LA9_3 = input.LA(2);

                if ( (LA9_3==COLON) ) {
                    int LA9_6 = input.LA(3);

                    if ( (LA9_6==SEMI||LA9_6==ELSE) ) {
                        alt9=1;
                    }
                    else if ( (LA9_6==BEGIN||(LA9_6>=BREAK && LA9_6<=TRY)||LA9_6==WITH||LA9_6==FOR||(LA9_6>=WHILE && LA9_6<=REPEAT)||LA9_6==CASE||LA9_6==IF||LA9_6==GOTO||LA9_6==INT||LA9_6==MINUS||LA9_6==LSQBR||LA9_6==LPAREN||(LA9_6>=STRING_LITERAL && LA9_6<=NOT)||(LA9_6>=FILE && LA9_6<=ID)) ) {
                        alt9=2;
                    }
                    else {
                        NoViableAltException nvae =
                            new NoViableAltException("", 9, 6, input);

                        throw nvae;
                    }
                }
                else if ( (LA9_3==SEMI||LA9_3==ASSIGN||LA9_3==ELSE||(LA9_3>=PLUS && LA9_3<=LSQBR)||LA9_3==LPAREN||LA9_3==EQUAL||(LA9_3>=NOT_EQUAL && LA9_3<=IN)) ) {
                    alt9=2;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 9, 3, input);

                    throw nvae;
                }
                }
                break;
            case BEGIN:
            case BREAK:
            case RAISE:
            case TRY:
            case WITH:
            case FOR:
            case WHILE:
            case REPEAT:
            case CASE:
            case IF:
            case GOTO:
            case MINUS:
            case LSQBR:
            case LPAREN:
            case STRING_LITERAL:
            case NIL:
            case FALSE:
            case TRUE:
            case RESULT:
            case EXCEPTIONMESSAGE:
            case FLOAT:
            case HEX:
            case NOT:
                {
                alt9=2;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 9, 0, input);

                throw nvae;
            }

            switch (alt9) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:77:4: labelId COLON
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_labelId_in_statement317);
                    labelId20=labelId();

                    state._fsp--;

                    adaptor.addChild(root_0, labelId20.getTree());
                    COLON21=(Token)match(input,COLON,FOLLOW_COLON_in_statement319); 
                    COLON21_tree = (CommonTree)adaptor.create(COLON21);
                    root_0 = (CommonTree)adaptor.becomeRoot(COLON21_tree, root_0);


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:78:4: ( labelId COLON )? simpleStatement
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:78:4: ( labelId COLON )?
                    int alt8=2;
                    switch ( input.LA(1) ) {
                        case INT:
                            {
                            int LA8_1 = input.LA(2);

                            if ( (LA8_1==COLON) ) {
                                alt8=1;
                            }
                            }
                            break;
                        case ID:
                            {
                            int LA8_2 = input.LA(2);

                            if ( (LA8_2==COLON) ) {
                                alt8=1;
                            }
                            }
                            break;
                        case FILE:
                            {
                            int LA8_3 = input.LA(2);

                            if ( (LA8_3==COLON) ) {
                                alt8=1;
                            }
                            }
                            break;
                    }

                    switch (alt8) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:78:5: labelId COLON
                            {
                            pushFollow(FOLLOW_labelId_in_statement326);
                            labelId22=labelId();

                            state._fsp--;

                            adaptor.addChild(root_0, labelId22.getTree());
                            COLON23=(Token)match(input,COLON,FOLLOW_COLON_in_statement328); 
                            COLON23_tree = (CommonTree)adaptor.create(COLON23);
                            root_0 = (CommonTree)adaptor.becomeRoot(COLON23_tree, root_0);


                            }
                            break;

                    }

                    pushFollow(FOLLOW_simpleStatement_in_statement333);
                    simpleStatement24=simpleStatement();

                    state._fsp--;

                    adaptor.addChild(root_0, simpleStatement24.getTree());

                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "statement"

    public static class simpleStatement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "simpleStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:81:1: simpleStatement : ( expressionOrAssignment | gotoStatement | block | caseStatement | repeatStatement | whileStatement | forStatement | withStatement | tryStatement | raiseStatement | ifStatement | BREAK );
    public final DelphiScriptParser.simpleStatement_return simpleStatement() throws RecognitionException {
        DelphiScriptParser.simpleStatement_return retval = new DelphiScriptParser.simpleStatement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token BREAK36=null;
        DelphiScriptParser.expressionOrAssignment_return expressionOrAssignment25 = null;

        DelphiScriptParser.gotoStatement_return gotoStatement26 = null;

        DelphiScriptParser.block_return block27 = null;

        DelphiScriptParser.caseStatement_return caseStatement28 = null;

        DelphiScriptParser.repeatStatement_return repeatStatement29 = null;

        DelphiScriptParser.whileStatement_return whileStatement30 = null;

        DelphiScriptParser.forStatement_return forStatement31 = null;

        DelphiScriptParser.withStatement_return withStatement32 = null;

        DelphiScriptParser.tryStatement_return tryStatement33 = null;

        DelphiScriptParser.raiseStatement_return raiseStatement34 = null;

        DelphiScriptParser.ifStatement_return ifStatement35 = null;


        CommonTree BREAK36_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:82:2: ( expressionOrAssignment | gotoStatement | block | caseStatement | repeatStatement | whileStatement | forStatement | withStatement | tryStatement | raiseStatement | ifStatement | BREAK )
            int alt10=12;
            alt10 = dfa10.predict(input);
            switch (alt10) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:82:4: expressionOrAssignment
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_expressionOrAssignment_in_simpleStatement344);
                    expressionOrAssignment25=expressionOrAssignment();

                    state._fsp--;

                    adaptor.addChild(root_0, expressionOrAssignment25.getTree());

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:83:4: gotoStatement
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_gotoStatement_in_simpleStatement349);
                    gotoStatement26=gotoStatement();

                    state._fsp--;

                    adaptor.addChild(root_0, gotoStatement26.getTree());

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:84:4: block
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_block_in_simpleStatement354);
                    block27=block();

                    state._fsp--;

                    adaptor.addChild(root_0, block27.getTree());

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:85:4: caseStatement
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_caseStatement_in_simpleStatement359);
                    caseStatement28=caseStatement();

                    state._fsp--;

                    adaptor.addChild(root_0, caseStatement28.getTree());

                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:86:4: repeatStatement
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_repeatStatement_in_simpleStatement364);
                    repeatStatement29=repeatStatement();

                    state._fsp--;

                    adaptor.addChild(root_0, repeatStatement29.getTree());

                    }
                    break;
                case 6 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:87:4: whileStatement
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_whileStatement_in_simpleStatement369);
                    whileStatement30=whileStatement();

                    state._fsp--;

                    adaptor.addChild(root_0, whileStatement30.getTree());

                    }
                    break;
                case 7 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:88:4: forStatement
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_forStatement_in_simpleStatement374);
                    forStatement31=forStatement();

                    state._fsp--;

                    adaptor.addChild(root_0, forStatement31.getTree());

                    }
                    break;
                case 8 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:89:4: withStatement
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_withStatement_in_simpleStatement379);
                    withStatement32=withStatement();

                    state._fsp--;

                    adaptor.addChild(root_0, withStatement32.getTree());

                    }
                    break;
                case 9 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:90:4: tryStatement
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_tryStatement_in_simpleStatement384);
                    tryStatement33=tryStatement();

                    state._fsp--;

                    adaptor.addChild(root_0, tryStatement33.getTree());

                    }
                    break;
                case 10 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:91:4: raiseStatement
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_raiseStatement_in_simpleStatement389);
                    raiseStatement34=raiseStatement();

                    state._fsp--;

                    adaptor.addChild(root_0, raiseStatement34.getTree());

                    }
                    break;
                case 11 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:92:4: ifStatement
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_ifStatement_in_simpleStatement394);
                    ifStatement35=ifStatement();

                    state._fsp--;

                    adaptor.addChild(root_0, ifStatement35.getTree());

                    }
                    break;
                case 12 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:93:4: BREAK
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    BREAK36=(Token)match(input,BREAK,FOLLOW_BREAK_in_simpleStatement399); 
                    BREAK36_tree = (CommonTree)adaptor.create(BREAK36);
                    adaptor.addChild(root_0, BREAK36_tree);


                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "simpleStatement"

    public static class raiseStatement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "raiseStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:96:1: raiseStatement : RAISE ( expression )? ;
    public final DelphiScriptParser.raiseStatement_return raiseStatement() throws RecognitionException {
        DelphiScriptParser.raiseStatement_return retval = new DelphiScriptParser.raiseStatement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token RAISE37=null;
        DelphiScriptParser.expression_return expression38 = null;


        CommonTree RAISE37_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:97:2: ( RAISE ( expression )? )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:97:4: RAISE ( expression )?
            {
            root_0 = (CommonTree)adaptor.nil();

            RAISE37=(Token)match(input,RAISE,FOLLOW_RAISE_in_raiseStatement410); 
            RAISE37_tree = (CommonTree)adaptor.create(RAISE37);
            root_0 = (CommonTree)adaptor.becomeRoot(RAISE37_tree, root_0);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:97:11: ( expression )?
            int alt11=2;
            int LA11_0 = input.LA(1);

            if ( (LA11_0==INT||LA11_0==MINUS||LA11_0==LSQBR||LA11_0==LPAREN||(LA11_0>=STRING_LITERAL && LA11_0<=NOT)||(LA11_0>=FILE && LA11_0<=ID)) ) {
                alt11=1;
            }
            switch (alt11) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:97:12: expression
                    {
                    pushFollow(FOLLOW_expression_in_raiseStatement414);
                    expression38=expression();

                    state._fsp--;

                    adaptor.addChild(root_0, expression38.getTree());

                    }
                    break;

            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "raiseStatement"

    public static class tryStatement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "tryStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:100:1: tryStatement : TRY (tb= statementList )? (fe= FINALLY | fe= EXCEPT ) (feb= statementList )? END -> ^( TRY ^( BLOCK ( $tb)? ) ^( $fe ( $feb)? ) ) ;
    public final DelphiScriptParser.tryStatement_return tryStatement() throws RecognitionException {
        DelphiScriptParser.tryStatement_return retval = new DelphiScriptParser.tryStatement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token fe=null;
        Token TRY39=null;
        Token END40=null;
        DelphiScriptParser.statementList_return tb = null;

        DelphiScriptParser.statementList_return feb = null;


        CommonTree fe_tree=null;
        CommonTree TRY39_tree=null;
        CommonTree END40_tree=null;
        RewriteRuleTokenStream stream_FINALLY=new RewriteRuleTokenStream(adaptor,"token FINALLY");
        RewriteRuleTokenStream stream_EXCEPT=new RewriteRuleTokenStream(adaptor,"token EXCEPT");
        RewriteRuleTokenStream stream_END=new RewriteRuleTokenStream(adaptor,"token END");
        RewriteRuleTokenStream stream_TRY=new RewriteRuleTokenStream(adaptor,"token TRY");
        RewriteRuleSubtreeStream stream_statementList=new RewriteRuleSubtreeStream(adaptor,"rule statementList");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:101:2: ( TRY (tb= statementList )? (fe= FINALLY | fe= EXCEPT ) (feb= statementList )? END -> ^( TRY ^( BLOCK ( $tb)? ) ^( $fe ( $feb)? ) ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:101:4: TRY (tb= statementList )? (fe= FINALLY | fe= EXCEPT ) (feb= statementList )? END
            {
            TRY39=(Token)match(input,TRY,FOLLOW_TRY_in_tryStatement427);  
            stream_TRY.add(TRY39);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:102:6: (tb= statementList )?
            int alt12=2;
            int LA12_0 = input.LA(1);

            if ( (LA12_0==BEGIN||(LA12_0>=BREAK && LA12_0<=TRY)||LA12_0==WITH||LA12_0==FOR||(LA12_0>=WHILE && LA12_0<=REPEAT)||LA12_0==CASE||LA12_0==IF||LA12_0==GOTO||LA12_0==INT||LA12_0==MINUS||LA12_0==LSQBR||LA12_0==LPAREN||(LA12_0>=STRING_LITERAL && LA12_0<=NOT)||(LA12_0>=FILE && LA12_0<=ID)) ) {
                alt12=1;
            }
            switch (alt12) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:102:6: tb= statementList
                    {
                    pushFollow(FOLLOW_statementList_in_tryStatement435);
                    tb=statementList();

                    state._fsp--;

                    stream_statementList.add(tb.getTree());

                    }
                    break;

            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:103:3: (fe= FINALLY | fe= EXCEPT )
            int alt13=2;
            int LA13_0 = input.LA(1);

            if ( (LA13_0==FINALLY) ) {
                alt13=1;
            }
            else if ( (LA13_0==EXCEPT) ) {
                alt13=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 13, 0, input);

                throw nvae;
            }
            switch (alt13) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:103:4: fe= FINALLY
                    {
                    fe=(Token)match(input,FINALLY,FOLLOW_FINALLY_in_tryStatement443);  
                    stream_FINALLY.add(fe);


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:103:17: fe= EXCEPT
                    {
                    fe=(Token)match(input,EXCEPT,FOLLOW_EXCEPT_in_tryStatement449);  
                    stream_EXCEPT.add(fe);


                    }
                    break;

            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:104:7: (feb= statementList )?
            int alt14=2;
            int LA14_0 = input.LA(1);

            if ( (LA14_0==BEGIN||(LA14_0>=BREAK && LA14_0<=TRY)||LA14_0==WITH||LA14_0==FOR||(LA14_0>=WHILE && LA14_0<=REPEAT)||LA14_0==CASE||LA14_0==IF||LA14_0==GOTO||LA14_0==INT||LA14_0==MINUS||LA14_0==LSQBR||LA14_0==LPAREN||(LA14_0>=STRING_LITERAL && LA14_0<=NOT)||(LA14_0>=FILE && LA14_0<=ID)) ) {
                alt14=1;
            }
            switch (alt14) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:104:7: feb= statementList
                    {
                    pushFollow(FOLLOW_statementList_in_tryStatement457);
                    feb=statementList();

                    state._fsp--;

                    stream_statementList.add(feb.getTree());

                    }
                    break;

            }

            END40=(Token)match(input,END,FOLLOW_END_in_tryStatement462);  
            stream_END.add(END40);



            // AST REWRITE
            // elements: fe, TRY, tb, feb
            // token labels: fe
            // rule labels: retval, tb, feb
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleTokenStream stream_fe=new RewriteRuleTokenStream(adaptor,"token fe",fe);
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);
            RewriteRuleSubtreeStream stream_tb=new RewriteRuleSubtreeStream(adaptor,"rule tb",tb!=null?tb.tree:null);
            RewriteRuleSubtreeStream stream_feb=new RewriteRuleSubtreeStream(adaptor,"rule feb",feb!=null?feb.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 106:3: -> ^( TRY ^( BLOCK ( $tb)? ) ^( $fe ( $feb)? ) )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:106:6: ^( TRY ^( BLOCK ( $tb)? ) ^( $fe ( $feb)? ) )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_TRY.nextNode(), root_1);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:106:12: ^( BLOCK ( $tb)? )
                {
                CommonTree root_2 = (CommonTree)adaptor.nil();
                root_2 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(BLOCK, "BLOCK"), root_2);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:106:20: ( $tb)?
                if ( stream_tb.hasNext() ) {
                    adaptor.addChild(root_2, stream_tb.nextTree());

                }
                stream_tb.reset();

                adaptor.addChild(root_1, root_2);
                }
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:106:26: ^( $fe ( $feb)? )
                {
                CommonTree root_2 = (CommonTree)adaptor.nil();
                root_2 = (CommonTree)adaptor.becomeRoot(stream_fe.nextNode(), root_2);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:106:32: ( $feb)?
                if ( stream_feb.hasNext() ) {
                    adaptor.addChild(root_2, stream_feb.nextTree());

                }
                stream_feb.reset();

                adaptor.addChild(root_1, root_2);
                }

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "tryStatement"

    public static class withStatement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "withStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:109:1: withStatement : WITH expression DO ( statement )? -> ^( WITH expression ( statement )? ) ;
    public final DelphiScriptParser.withStatement_return withStatement() throws RecognitionException {
        DelphiScriptParser.withStatement_return retval = new DelphiScriptParser.withStatement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token WITH41=null;
        Token DO43=null;
        DelphiScriptParser.expression_return expression42 = null;

        DelphiScriptParser.statement_return statement44 = null;


        CommonTree WITH41_tree=null;
        CommonTree DO43_tree=null;
        RewriteRuleTokenStream stream_DO=new RewriteRuleTokenStream(adaptor,"token DO");
        RewriteRuleTokenStream stream_WITH=new RewriteRuleTokenStream(adaptor,"token WITH");
        RewriteRuleSubtreeStream stream_expression=new RewriteRuleSubtreeStream(adaptor,"rule expression");
        RewriteRuleSubtreeStream stream_statement=new RewriteRuleSubtreeStream(adaptor,"rule statement");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:110:2: ( WITH expression DO ( statement )? -> ^( WITH expression ( statement )? ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:110:4: WITH expression DO ( statement )?
            {
            WITH41=(Token)match(input,WITH,FOLLOW_WITH_in_withStatement500);  
            stream_WITH.add(WITH41);

            pushFollow(FOLLOW_expression_in_withStatement502);
            expression42=expression();

            state._fsp--;

            stream_expression.add(expression42.getTree());
            DO43=(Token)match(input,DO,FOLLOW_DO_in_withStatement507);  
            stream_DO.add(DO43);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:111:6: ( statement )?
            int alt15=2;
            int LA15_0 = input.LA(1);

            if ( (LA15_0==BEGIN||(LA15_0>=BREAK && LA15_0<=TRY)||LA15_0==WITH||LA15_0==FOR||(LA15_0>=WHILE && LA15_0<=REPEAT)||LA15_0==CASE||LA15_0==IF||LA15_0==GOTO||LA15_0==INT||LA15_0==MINUS||LA15_0==LSQBR||LA15_0==LPAREN||(LA15_0>=STRING_LITERAL && LA15_0<=NOT)||(LA15_0>=FILE && LA15_0<=ID)) ) {
                alt15=1;
            }
            switch (alt15) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:111:6: statement
                    {
                    pushFollow(FOLLOW_statement_in_withStatement509);
                    statement44=statement();

                    state._fsp--;

                    stream_statement.add(statement44.getTree());

                    }
                    break;

            }



            // AST REWRITE
            // elements: WITH, statement, expression
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 112:3: -> ^( WITH expression ( statement )? )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:112:6: ^( WITH expression ( statement )? )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_WITH.nextNode(), root_1);

                adaptor.addChild(root_1, stream_expression.nextTree());
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:112:24: ( statement )?
                if ( stream_statement.hasNext() ) {
                    adaptor.addChild(root_1, stream_statement.nextTree());

                }
                stream_statement.reset();

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "withStatement"

    public static class forStatement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "forStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:115:1: forStatement : FOR ident ASSIGN from= expression (t_or_d= TO | t_or_d= DOWNTO ) to= expression DO statement -> ^( FOR ident $from $t_or_d $to statement ) ;
    public final DelphiScriptParser.forStatement_return forStatement() throws RecognitionException {
        DelphiScriptParser.forStatement_return retval = new DelphiScriptParser.forStatement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token t_or_d=null;
        Token FOR45=null;
        Token ASSIGN47=null;
        Token DO48=null;
        DelphiScriptParser.expression_return from = null;

        DelphiScriptParser.expression_return to = null;

        DelphiScriptParser.ident_return ident46 = null;

        DelphiScriptParser.statement_return statement49 = null;


        CommonTree t_or_d_tree=null;
        CommonTree FOR45_tree=null;
        CommonTree ASSIGN47_tree=null;
        CommonTree DO48_tree=null;
        RewriteRuleTokenStream stream_FOR=new RewriteRuleTokenStream(adaptor,"token FOR");
        RewriteRuleTokenStream stream_DO=new RewriteRuleTokenStream(adaptor,"token DO");
        RewriteRuleTokenStream stream_DOWNTO=new RewriteRuleTokenStream(adaptor,"token DOWNTO");
        RewriteRuleTokenStream stream_TO=new RewriteRuleTokenStream(adaptor,"token TO");
        RewriteRuleTokenStream stream_ASSIGN=new RewriteRuleTokenStream(adaptor,"token ASSIGN");
        RewriteRuleSubtreeStream stream_expression=new RewriteRuleSubtreeStream(adaptor,"rule expression");
        RewriteRuleSubtreeStream stream_statement=new RewriteRuleSubtreeStream(adaptor,"rule statement");
        RewriteRuleSubtreeStream stream_ident=new RewriteRuleSubtreeStream(adaptor,"rule ident");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:116:2: ( FOR ident ASSIGN from= expression (t_or_d= TO | t_or_d= DOWNTO ) to= expression DO statement -> ^( FOR ident $from $t_or_d $to statement ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:116:4: FOR ident ASSIGN from= expression (t_or_d= TO | t_or_d= DOWNTO ) to= expression DO statement
            {
            FOR45=(Token)match(input,FOR,FOLLOW_FOR_in_forStatement534);  
            stream_FOR.add(FOR45);

            pushFollow(FOLLOW_ident_in_forStatement536);
            ident46=ident();

            state._fsp--;

            stream_ident.add(ident46.getTree());
            ASSIGN47=(Token)match(input,ASSIGN,FOLLOW_ASSIGN_in_forStatement538);  
            stream_ASSIGN.add(ASSIGN47);

            pushFollow(FOLLOW_expression_in_forStatement542);
            from=expression();

            state._fsp--;

            stream_expression.add(from.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:116:37: (t_or_d= TO | t_or_d= DOWNTO )
            int alt16=2;
            int LA16_0 = input.LA(1);

            if ( (LA16_0==TO) ) {
                alt16=1;
            }
            else if ( (LA16_0==DOWNTO) ) {
                alt16=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 16, 0, input);

                throw nvae;
            }
            switch (alt16) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:116:38: t_or_d= TO
                    {
                    t_or_d=(Token)match(input,TO,FOLLOW_TO_in_forStatement547);  
                    stream_TO.add(t_or_d);


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:116:48: t_or_d= DOWNTO
                    {
                    t_or_d=(Token)match(input,DOWNTO,FOLLOW_DOWNTO_in_forStatement551);  
                    stream_DOWNTO.add(t_or_d);


                    }
                    break;

            }

            pushFollow(FOLLOW_expression_in_forStatement556);
            to=expression();

            state._fsp--;

            stream_expression.add(to.getTree());
            DO48=(Token)match(input,DO,FOLLOW_DO_in_forStatement558);  
            stream_DO.add(DO48);

            pushFollow(FOLLOW_statement_in_forStatement560);
            statement49=statement();

            state._fsp--;

            stream_statement.add(statement49.getTree());


            // AST REWRITE
            // elements: from, ident, FOR, statement, to, t_or_d
            // token labels: t_or_d
            // rule labels: to, retval, from
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleTokenStream stream_t_or_d=new RewriteRuleTokenStream(adaptor,"token t_or_d",t_or_d);
            RewriteRuleSubtreeStream stream_to=new RewriteRuleSubtreeStream(adaptor,"rule to",to!=null?to.tree:null);
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);
            RewriteRuleSubtreeStream stream_from=new RewriteRuleSubtreeStream(adaptor,"rule from",from!=null?from.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 117:3: -> ^( FOR ident $from $t_or_d $to statement )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:117:6: ^( FOR ident $from $t_or_d $to statement )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_FOR.nextNode(), root_1);

                adaptor.addChild(root_1, stream_ident.nextTree());
                adaptor.addChild(root_1, stream_from.nextTree());
                adaptor.addChild(root_1, stream_t_or_d.nextNode());
                adaptor.addChild(root_1, stream_to.nextTree());
                adaptor.addChild(root_1, stream_statement.nextTree());

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "forStatement"

    public static class whileStatement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "whileStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:120:1: whileStatement : WHILE expression DO ( statement )? -> ^( WHILE expression ( statement )? ) ;
    public final DelphiScriptParser.whileStatement_return whileStatement() throws RecognitionException {
        DelphiScriptParser.whileStatement_return retval = new DelphiScriptParser.whileStatement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token WHILE50=null;
        Token DO52=null;
        DelphiScriptParser.expression_return expression51 = null;

        DelphiScriptParser.statement_return statement53 = null;


        CommonTree WHILE50_tree=null;
        CommonTree DO52_tree=null;
        RewriteRuleTokenStream stream_DO=new RewriteRuleTokenStream(adaptor,"token DO");
        RewriteRuleTokenStream stream_WHILE=new RewriteRuleTokenStream(adaptor,"token WHILE");
        RewriteRuleSubtreeStream stream_expression=new RewriteRuleSubtreeStream(adaptor,"rule expression");
        RewriteRuleSubtreeStream stream_statement=new RewriteRuleSubtreeStream(adaptor,"rule statement");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:121:2: ( WHILE expression DO ( statement )? -> ^( WHILE expression ( statement )? ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:121:4: WHILE expression DO ( statement )?
            {
            WHILE50=(Token)match(input,WHILE,FOLLOW_WHILE_in_whileStatement592);  
            stream_WHILE.add(WHILE50);

            pushFollow(FOLLOW_expression_in_whileStatement594);
            expression51=expression();

            state._fsp--;

            stream_expression.add(expression51.getTree());
            DO52=(Token)match(input,DO,FOLLOW_DO_in_whileStatement596);  
            stream_DO.add(DO52);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:121:24: ( statement )?
            int alt17=2;
            int LA17_0 = input.LA(1);

            if ( (LA17_0==BEGIN||(LA17_0>=BREAK && LA17_0<=TRY)||LA17_0==WITH||LA17_0==FOR||(LA17_0>=WHILE && LA17_0<=REPEAT)||LA17_0==CASE||LA17_0==IF||LA17_0==GOTO||LA17_0==INT||LA17_0==MINUS||LA17_0==LSQBR||LA17_0==LPAREN||(LA17_0>=STRING_LITERAL && LA17_0<=NOT)||(LA17_0>=FILE && LA17_0<=ID)) ) {
                alt17=1;
            }
            switch (alt17) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:121:24: statement
                    {
                    pushFollow(FOLLOW_statement_in_whileStatement598);
                    statement53=statement();

                    state._fsp--;

                    stream_statement.add(statement53.getTree());

                    }
                    break;

            }



            // AST REWRITE
            // elements: WHILE, expression, statement
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 122:3: -> ^( WHILE expression ( statement )? )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:122:6: ^( WHILE expression ( statement )? )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_WHILE.nextNode(), root_1);

                adaptor.addChild(root_1, stream_expression.nextTree());
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:122:25: ( statement )?
                if ( stream_statement.hasNext() ) {
                    adaptor.addChild(root_1, stream_statement.nextTree());

                }
                stream_statement.reset();

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "whileStatement"

    public static class repeatStatement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "repeatStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:125:1: repeatStatement : REPEAT ( statementList )? UNTIL expression -> ^( REPEAT ^( BLOCK ( statementList )? ) expression ) ;
    public final DelphiScriptParser.repeatStatement_return repeatStatement() throws RecognitionException {
        DelphiScriptParser.repeatStatement_return retval = new DelphiScriptParser.repeatStatement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token REPEAT54=null;
        Token UNTIL56=null;
        DelphiScriptParser.statementList_return statementList55 = null;

        DelphiScriptParser.expression_return expression57 = null;


        CommonTree REPEAT54_tree=null;
        CommonTree UNTIL56_tree=null;
        RewriteRuleTokenStream stream_REPEAT=new RewriteRuleTokenStream(adaptor,"token REPEAT");
        RewriteRuleTokenStream stream_UNTIL=new RewriteRuleTokenStream(adaptor,"token UNTIL");
        RewriteRuleSubtreeStream stream_statementList=new RewriteRuleSubtreeStream(adaptor,"rule statementList");
        RewriteRuleSubtreeStream stream_expression=new RewriteRuleSubtreeStream(adaptor,"rule expression");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:126:2: ( REPEAT ( statementList )? UNTIL expression -> ^( REPEAT ^( BLOCK ( statementList )? ) expression ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:126:4: REPEAT ( statementList )? UNTIL expression
            {
            REPEAT54=(Token)match(input,REPEAT,FOLLOW_REPEAT_in_repeatStatement623);  
            stream_REPEAT.add(REPEAT54);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:126:11: ( statementList )?
            int alt18=2;
            int LA18_0 = input.LA(1);

            if ( (LA18_0==BEGIN||(LA18_0>=BREAK && LA18_0<=TRY)||LA18_0==WITH||LA18_0==FOR||(LA18_0>=WHILE && LA18_0<=REPEAT)||LA18_0==CASE||LA18_0==IF||LA18_0==GOTO||LA18_0==INT||LA18_0==MINUS||LA18_0==LSQBR||LA18_0==LPAREN||(LA18_0>=STRING_LITERAL && LA18_0<=NOT)||(LA18_0>=FILE && LA18_0<=ID)) ) {
                alt18=1;
            }
            switch (alt18) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:126:11: statementList
                    {
                    pushFollow(FOLLOW_statementList_in_repeatStatement625);
                    statementList55=statementList();

                    state._fsp--;

                    stream_statementList.add(statementList55.getTree());

                    }
                    break;

            }

            UNTIL56=(Token)match(input,UNTIL,FOLLOW_UNTIL_in_repeatStatement628);  
            stream_UNTIL.add(UNTIL56);

            pushFollow(FOLLOW_expression_in_repeatStatement630);
            expression57=expression();

            state._fsp--;

            stream_expression.add(expression57.getTree());


            // AST REWRITE
            // elements: expression, REPEAT, statementList
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 127:3: -> ^( REPEAT ^( BLOCK ( statementList )? ) expression )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:127:6: ^( REPEAT ^( BLOCK ( statementList )? ) expression )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_REPEAT.nextNode(), root_1);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:127:15: ^( BLOCK ( statementList )? )
                {
                CommonTree root_2 = (CommonTree)adaptor.nil();
                root_2 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(BLOCK, "BLOCK"), root_2);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:127:23: ( statementList )?
                if ( stream_statementList.hasNext() ) {
                    adaptor.addChild(root_2, stream_statementList.nextTree());

                }
                stream_statementList.reset();

                adaptor.addChild(root_1, root_2);
                }
                adaptor.addChild(root_1, stream_expression.nextTree());

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "repeatStatement"

    public static class caseStatement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "caseStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:130:1: caseStatement : CASE expression OF ( caseSelector )+ ( ELSE ( statement )? SEMI )? END -> ^( CASE expression ( caseSelector )+ ( ^( ELSE ( statement )? ) )? ) ;
    public final DelphiScriptParser.caseStatement_return caseStatement() throws RecognitionException {
        DelphiScriptParser.caseStatement_return retval = new DelphiScriptParser.caseStatement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token CASE58=null;
        Token OF60=null;
        Token ELSE62=null;
        Token SEMI64=null;
        Token END65=null;
        DelphiScriptParser.expression_return expression59 = null;

        DelphiScriptParser.caseSelector_return caseSelector61 = null;

        DelphiScriptParser.statement_return statement63 = null;


        CommonTree CASE58_tree=null;
        CommonTree OF60_tree=null;
        CommonTree ELSE62_tree=null;
        CommonTree SEMI64_tree=null;
        CommonTree END65_tree=null;
        RewriteRuleTokenStream stream_END=new RewriteRuleTokenStream(adaptor,"token END");
        RewriteRuleTokenStream stream_OF=new RewriteRuleTokenStream(adaptor,"token OF");
        RewriteRuleTokenStream stream_SEMI=new RewriteRuleTokenStream(adaptor,"token SEMI");
        RewriteRuleTokenStream stream_ELSE=new RewriteRuleTokenStream(adaptor,"token ELSE");
        RewriteRuleTokenStream stream_CASE=new RewriteRuleTokenStream(adaptor,"token CASE");
        RewriteRuleSubtreeStream stream_expression=new RewriteRuleSubtreeStream(adaptor,"rule expression");
        RewriteRuleSubtreeStream stream_statement=new RewriteRuleSubtreeStream(adaptor,"rule statement");
        RewriteRuleSubtreeStream stream_caseSelector=new RewriteRuleSubtreeStream(adaptor,"rule caseSelector");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:131:2: ( CASE expression OF ( caseSelector )+ ( ELSE ( statement )? SEMI )? END -> ^( CASE expression ( caseSelector )+ ( ^( ELSE ( statement )? ) )? ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:131:4: CASE expression OF ( caseSelector )+ ( ELSE ( statement )? SEMI )? END
            {
            CASE58=(Token)match(input,CASE,FOLLOW_CASE_in_caseStatement658);  
            stream_CASE.add(CASE58);

            pushFollow(FOLLOW_expression_in_caseStatement660);
            expression59=expression();

            state._fsp--;

            stream_expression.add(expression59.getTree());
            OF60=(Token)match(input,OF,FOLLOW_OF_in_caseStatement662);  
            stream_OF.add(OF60);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:132:4: ( caseSelector )+
            int cnt19=0;
            loop19:
            do {
                int alt19=2;
                int LA19_0 = input.LA(1);

                if ( (LA19_0==INT||LA19_0==MINUS||LA19_0==LSQBR||LA19_0==LPAREN||(LA19_0>=STRING_LITERAL && LA19_0<=NOT)||(LA19_0>=FILE && LA19_0<=ID)) ) {
                    alt19=1;
                }


                switch (alt19) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:132:4: caseSelector
            	    {
            	    pushFollow(FOLLOW_caseSelector_in_caseStatement667);
            	    caseSelector61=caseSelector();

            	    state._fsp--;

            	    stream_caseSelector.add(caseSelector61.getTree());

            	    }
            	    break;

            	default :
            	    if ( cnt19 >= 1 ) break loop19;
                        EarlyExitException eee =
                            new EarlyExitException(19, input);
                        throw eee;
                }
                cnt19++;
            } while (true);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:133:3: ( ELSE ( statement )? SEMI )?
            int alt21=2;
            int LA21_0 = input.LA(1);

            if ( (LA21_0==ELSE) ) {
                alt21=1;
            }
            switch (alt21) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:133:4: ELSE ( statement )? SEMI
                    {
                    ELSE62=(Token)match(input,ELSE,FOLLOW_ELSE_in_caseStatement673);  
                    stream_ELSE.add(ELSE62);

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:133:9: ( statement )?
                    int alt20=2;
                    int LA20_0 = input.LA(1);

                    if ( (LA20_0==BEGIN||(LA20_0>=BREAK && LA20_0<=TRY)||LA20_0==WITH||LA20_0==FOR||(LA20_0>=WHILE && LA20_0<=REPEAT)||LA20_0==CASE||LA20_0==IF||LA20_0==GOTO||LA20_0==INT||LA20_0==MINUS||LA20_0==LSQBR||LA20_0==LPAREN||(LA20_0>=STRING_LITERAL && LA20_0<=NOT)||(LA20_0>=FILE && LA20_0<=ID)) ) {
                        alt20=1;
                    }
                    switch (alt20) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:133:9: statement
                            {
                            pushFollow(FOLLOW_statement_in_caseStatement675);
                            statement63=statement();

                            state._fsp--;

                            stream_statement.add(statement63.getTree());

                            }
                            break;

                    }

                    SEMI64=(Token)match(input,SEMI,FOLLOW_SEMI_in_caseStatement678);  
                    stream_SEMI.add(SEMI64);


                    }
                    break;

            }

            END65=(Token)match(input,END,FOLLOW_END_in_caseStatement684);  
            stream_END.add(END65);



            // AST REWRITE
            // elements: expression, ELSE, statement, caseSelector, CASE
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 135:3: -> ^( CASE expression ( caseSelector )+ ( ^( ELSE ( statement )? ) )? )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:135:6: ^( CASE expression ( caseSelector )+ ( ^( ELSE ( statement )? ) )? )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_CASE.nextNode(), root_1);

                adaptor.addChild(root_1, stream_expression.nextTree());
                if ( !(stream_caseSelector.hasNext()) ) {
                    throw new RewriteEarlyExitException();
                }
                while ( stream_caseSelector.hasNext() ) {
                    adaptor.addChild(root_1, stream_caseSelector.nextTree());

                }
                stream_caseSelector.reset();
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:135:38: ( ^( ELSE ( statement )? ) )?
                if ( stream_ELSE.hasNext()||stream_statement.hasNext() ) {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:135:38: ^( ELSE ( statement )? )
                    {
                    CommonTree root_2 = (CommonTree)adaptor.nil();
                    root_2 = (CommonTree)adaptor.becomeRoot(stream_ELSE.nextNode(), root_2);

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:135:45: ( statement )?
                    if ( stream_statement.hasNext() ) {
                        adaptor.addChild(root_2, stream_statement.nextTree());

                    }
                    stream_statement.reset();

                    adaptor.addChild(root_1, root_2);
                    }

                }
                stream_ELSE.reset();
                stream_statement.reset();

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "caseStatement"

    public static class caseSelector_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "caseSelector"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:138:1: caseSelector : expressionOrRange ( COMMA expressionOrRange )* COLON ( statement )? SEMI -> ^( CASE_SELECTOR ( expressionOrRange )+ ^( BLOCK ( statement )? ) ) ;
    public final DelphiScriptParser.caseSelector_return caseSelector() throws RecognitionException {
        DelphiScriptParser.caseSelector_return retval = new DelphiScriptParser.caseSelector_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token COMMA67=null;
        Token COLON69=null;
        Token SEMI71=null;
        DelphiScriptParser.expressionOrRange_return expressionOrRange66 = null;

        DelphiScriptParser.expressionOrRange_return expressionOrRange68 = null;

        DelphiScriptParser.statement_return statement70 = null;


        CommonTree COMMA67_tree=null;
        CommonTree COLON69_tree=null;
        CommonTree SEMI71_tree=null;
        RewriteRuleTokenStream stream_COLON=new RewriteRuleTokenStream(adaptor,"token COLON");
        RewriteRuleTokenStream stream_COMMA=new RewriteRuleTokenStream(adaptor,"token COMMA");
        RewriteRuleTokenStream stream_SEMI=new RewriteRuleTokenStream(adaptor,"token SEMI");
        RewriteRuleSubtreeStream stream_statement=new RewriteRuleSubtreeStream(adaptor,"rule statement");
        RewriteRuleSubtreeStream stream_expressionOrRange=new RewriteRuleSubtreeStream(adaptor,"rule expressionOrRange");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:139:2: ( expressionOrRange ( COMMA expressionOrRange )* COLON ( statement )? SEMI -> ^( CASE_SELECTOR ( expressionOrRange )+ ^( BLOCK ( statement )? ) ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:139:4: expressionOrRange ( COMMA expressionOrRange )* COLON ( statement )? SEMI
            {
            pushFollow(FOLLOW_expressionOrRange_in_caseSelector717);
            expressionOrRange66=expressionOrRange();

            state._fsp--;

            stream_expressionOrRange.add(expressionOrRange66.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:139:22: ( COMMA expressionOrRange )*
            loop22:
            do {
                int alt22=2;
                int LA22_0 = input.LA(1);

                if ( (LA22_0==COMMA) ) {
                    alt22=1;
                }


                switch (alt22) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:139:23: COMMA expressionOrRange
            	    {
            	    COMMA67=(Token)match(input,COMMA,FOLLOW_COMMA_in_caseSelector720);  
            	    stream_COMMA.add(COMMA67);

            	    pushFollow(FOLLOW_expressionOrRange_in_caseSelector722);
            	    expressionOrRange68=expressionOrRange();

            	    state._fsp--;

            	    stream_expressionOrRange.add(expressionOrRange68.getTree());

            	    }
            	    break;

            	default :
            	    break loop22;
                }
            } while (true);

            COLON69=(Token)match(input,COLON,FOLLOW_COLON_in_caseSelector726);  
            stream_COLON.add(COLON69);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:139:55: ( statement )?
            int alt23=2;
            int LA23_0 = input.LA(1);

            if ( (LA23_0==BEGIN||(LA23_0>=BREAK && LA23_0<=TRY)||LA23_0==WITH||LA23_0==FOR||(LA23_0>=WHILE && LA23_0<=REPEAT)||LA23_0==CASE||LA23_0==IF||LA23_0==GOTO||LA23_0==INT||LA23_0==MINUS||LA23_0==LSQBR||LA23_0==LPAREN||(LA23_0>=STRING_LITERAL && LA23_0<=NOT)||(LA23_0>=FILE && LA23_0<=ID)) ) {
                alt23=1;
            }
            switch (alt23) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:139:55: statement
                    {
                    pushFollow(FOLLOW_statement_in_caseSelector728);
                    statement70=statement();

                    state._fsp--;

                    stream_statement.add(statement70.getTree());

                    }
                    break;

            }

            SEMI71=(Token)match(input,SEMI,FOLLOW_SEMI_in_caseSelector731);  
            stream_SEMI.add(SEMI71);



            // AST REWRITE
            // elements: statement, expressionOrRange
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 140:3: -> ^( CASE_SELECTOR ( expressionOrRange )+ ^( BLOCK ( statement )? ) )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:140:6: ^( CASE_SELECTOR ( expressionOrRange )+ ^( BLOCK ( statement )? ) )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(CASE_SELECTOR, "CASE_SELECTOR"), root_1);

                if ( !(stream_expressionOrRange.hasNext()) ) {
                    throw new RewriteEarlyExitException();
                }
                while ( stream_expressionOrRange.hasNext() ) {
                    adaptor.addChild(root_1, stream_expressionOrRange.nextTree());

                }
                stream_expressionOrRange.reset();
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:140:41: ^( BLOCK ( statement )? )
                {
                CommonTree root_2 = (CommonTree)adaptor.nil();
                root_2 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(BLOCK, "BLOCK"), root_2);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:140:49: ( statement )?
                if ( stream_statement.hasNext() ) {
                    adaptor.addChild(root_2, stream_statement.nextTree());

                }
                stream_statement.reset();

                adaptor.addChild(root_1, root_2);
                }

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "caseSelector"

    public static class ifStatement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "ifStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:144:1: ifStatement : IF expression THEN (ts= statement )? ( ELSE (es= statement )? )? -> ^( IF expression ^( THEN ( $ts)? ) ( ^( ELSE ( $es)? ) )? ) ;
    public final DelphiScriptParser.ifStatement_return ifStatement() throws RecognitionException {
        DelphiScriptParser.ifStatement_return retval = new DelphiScriptParser.ifStatement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token IF72=null;
        Token THEN74=null;
        Token ELSE75=null;
        DelphiScriptParser.statement_return ts = null;

        DelphiScriptParser.statement_return es = null;

        DelphiScriptParser.expression_return expression73 = null;


        CommonTree IF72_tree=null;
        CommonTree THEN74_tree=null;
        CommonTree ELSE75_tree=null;
        RewriteRuleTokenStream stream_THEN=new RewriteRuleTokenStream(adaptor,"token THEN");
        RewriteRuleTokenStream stream_IF=new RewriteRuleTokenStream(adaptor,"token IF");
        RewriteRuleTokenStream stream_ELSE=new RewriteRuleTokenStream(adaptor,"token ELSE");
        RewriteRuleSubtreeStream stream_expression=new RewriteRuleSubtreeStream(adaptor,"rule expression");
        RewriteRuleSubtreeStream stream_statement=new RewriteRuleSubtreeStream(adaptor,"rule statement");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:145:2: ( IF expression THEN (ts= statement )? ( ELSE (es= statement )? )? -> ^( IF expression ^( THEN ( $ts)? ) ( ^( ELSE ( $es)? ) )? ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:145:4: IF expression THEN (ts= statement )? ( ELSE (es= statement )? )?
            {
            IF72=(Token)match(input,IF,FOLLOW_IF_in_ifStatement761);  
            stream_IF.add(IF72);

            pushFollow(FOLLOW_expression_in_ifStatement763);
            expression73=expression();

            state._fsp--;

            stream_expression.add(expression73.getTree());
            THEN74=(Token)match(input,THEN,FOLLOW_THEN_in_ifStatement765);  
            stream_THEN.add(THEN74);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:145:25: (ts= statement )?
            int alt24=2;
            int LA24_0 = input.LA(1);

            if ( (LA24_0==BEGIN||(LA24_0>=BREAK && LA24_0<=TRY)||LA24_0==WITH||LA24_0==FOR||(LA24_0>=WHILE && LA24_0<=REPEAT)||LA24_0==CASE||LA24_0==IF||LA24_0==GOTO||LA24_0==INT||LA24_0==MINUS||LA24_0==LSQBR||LA24_0==LPAREN||(LA24_0>=STRING_LITERAL && LA24_0<=NOT)||(LA24_0>=FILE && LA24_0<=ID)) ) {
                alt24=1;
            }
            switch (alt24) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:145:25: ts= statement
                    {
                    pushFollow(FOLLOW_statement_in_ifStatement769);
                    ts=statement();

                    state._fsp--;

                    stream_statement.add(ts.getTree());

                    }
                    break;

            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:146:3: ( ELSE (es= statement )? )?
            int alt26=2;
            int LA26_0 = input.LA(1);

            if ( (LA26_0==ELSE) ) {
                alt26=1;
            }
            switch (alt26) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:146:4: ELSE (es= statement )?
                    {
                    ELSE75=(Token)match(input,ELSE,FOLLOW_ELSE_in_ifStatement777);  
                    stream_ELSE.add(ELSE75);

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:146:11: (es= statement )?
                    int alt25=2;
                    int LA25_0 = input.LA(1);

                    if ( (LA25_0==BEGIN||(LA25_0>=BREAK && LA25_0<=TRY)||LA25_0==WITH||LA25_0==FOR||(LA25_0>=WHILE && LA25_0<=REPEAT)||LA25_0==CASE||LA25_0==IF||LA25_0==GOTO||LA25_0==INT||LA25_0==MINUS||LA25_0==LSQBR||LA25_0==LPAREN||(LA25_0>=STRING_LITERAL && LA25_0<=NOT)||(LA25_0>=FILE && LA25_0<=ID)) ) {
                        alt25=1;
                    }
                    switch (alt25) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:146:11: es= statement
                            {
                            pushFollow(FOLLOW_statement_in_ifStatement781);
                            es=statement();

                            state._fsp--;

                            stream_statement.add(es.getTree());

                            }
                            break;

                    }


                    }
                    break;

            }



            // AST REWRITE
            // elements: THEN, es, expression, ELSE, IF, ts
            // token labels: 
            // rule labels: retval, ts, es
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);
            RewriteRuleSubtreeStream stream_ts=new RewriteRuleSubtreeStream(adaptor,"rule ts",ts!=null?ts.tree:null);
            RewriteRuleSubtreeStream stream_es=new RewriteRuleSubtreeStream(adaptor,"rule es",es!=null?es.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 147:3: -> ^( IF expression ^( THEN ( $ts)? ) ( ^( ELSE ( $es)? ) )? )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:147:6: ^( IF expression ^( THEN ( $ts)? ) ( ^( ELSE ( $es)? ) )? )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_IF.nextNode(), root_1);

                adaptor.addChild(root_1, stream_expression.nextTree());
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:147:22: ^( THEN ( $ts)? )
                {
                CommonTree root_2 = (CommonTree)adaptor.nil();
                root_2 = (CommonTree)adaptor.becomeRoot(stream_THEN.nextNode(), root_2);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:147:29: ( $ts)?
                if ( stream_ts.hasNext() ) {
                    adaptor.addChild(root_2, stream_ts.nextTree());

                }
                stream_ts.reset();

                adaptor.addChild(root_1, root_2);
                }
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:147:35: ( ^( ELSE ( $es)? ) )?
                if ( stream_es.hasNext()||stream_ELSE.hasNext() ) {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:147:35: ^( ELSE ( $es)? )
                    {
                    CommonTree root_2 = (CommonTree)adaptor.nil();
                    root_2 = (CommonTree)adaptor.becomeRoot(stream_ELSE.nextNode(), root_2);

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:147:42: ( $es)?
                    if ( stream_es.hasNext() ) {
                        adaptor.addChild(root_2, stream_es.nextTree());

                    }
                    stream_es.reset();

                    adaptor.addChild(root_1, root_2);
                    }

                }
                stream_es.reset();
                stream_ELSE.reset();

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "ifStatement"

    public static class gotoStatement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "gotoStatement"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:150:1: gotoStatement : GOTO labelId ;
    public final DelphiScriptParser.gotoStatement_return gotoStatement() throws RecognitionException {
        DelphiScriptParser.gotoStatement_return retval = new DelphiScriptParser.gotoStatement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token GOTO76=null;
        DelphiScriptParser.labelId_return labelId77 = null;


        CommonTree GOTO76_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:151:2: ( GOTO labelId )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:151:4: GOTO labelId
            {
            root_0 = (CommonTree)adaptor.nil();

            GOTO76=(Token)match(input,GOTO,FOLLOW_GOTO_in_gotoStatement826); 
            GOTO76_tree = (CommonTree)adaptor.create(GOTO76);
            root_0 = (CommonTree)adaptor.becomeRoot(GOTO76_tree, root_0);

            pushFollow(FOLLOW_labelId_in_gotoStatement829);
            labelId77=labelId();

            state._fsp--;

            adaptor.addChild(root_0, labelId77.getTree());

            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "gotoStatement"

    public static class expressionOrAssignment_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "expressionOrAssignment"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:154:1: expressionOrAssignment : expression ( ASSIGN expression )? ;
    public final DelphiScriptParser.expressionOrAssignment_return expressionOrAssignment() throws RecognitionException {
        DelphiScriptParser.expressionOrAssignment_return retval = new DelphiScriptParser.expressionOrAssignment_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token ASSIGN79=null;
        DelphiScriptParser.expression_return expression78 = null;

        DelphiScriptParser.expression_return expression80 = null;


        CommonTree ASSIGN79_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:155:2: ( expression ( ASSIGN expression )? )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:155:4: expression ( ASSIGN expression )?
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_expression_in_expressionOrAssignment840);
            expression78=expression();

            state._fsp--;

            adaptor.addChild(root_0, expression78.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:155:15: ( ASSIGN expression )?
            int alt27=2;
            int LA27_0 = input.LA(1);

            if ( (LA27_0==ASSIGN) ) {
                alt27=1;
            }
            switch (alt27) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:155:16: ASSIGN expression
                    {
                    ASSIGN79=(Token)match(input,ASSIGN,FOLLOW_ASSIGN_in_expressionOrAssignment843); 
                    ASSIGN79_tree = (CommonTree)adaptor.create(ASSIGN79);
                    root_0 = (CommonTree)adaptor.becomeRoot(ASSIGN79_tree, root_0);

                    pushFollow(FOLLOW_expression_in_expressionOrAssignment846);
                    expression80=expression();

                    state._fsp--;

                    adaptor.addChild(root_0, expression80.getTree());

                    }
                    break;

            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "expressionOrAssignment"

    public static class varSection_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "varSection"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:158:1: varSection : VAR ( varDecl )+ ;
    public final DelphiScriptParser.varSection_return varSection() throws RecognitionException {
        DelphiScriptParser.varSection_return retval = new DelphiScriptParser.varSection_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token VAR81=null;
        DelphiScriptParser.varDecl_return varDecl82 = null;


        CommonTree VAR81_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:159:2: ( VAR ( varDecl )+ )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:159:4: VAR ( varDecl )+
            {
            root_0 = (CommonTree)adaptor.nil();

            VAR81=(Token)match(input,VAR,FOLLOW_VAR_in_varSection859); 
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:159:9: ( varDecl )+
            int cnt28=0;
            loop28:
            do {
                int alt28=2;
                int LA28_0 = input.LA(1);

                if ( ((LA28_0>=FILE && LA28_0<=ID)) ) {
                    alt28=1;
                }


                switch (alt28) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:159:9: varDecl
            	    {
            	    pushFollow(FOLLOW_varDecl_in_varSection862);
            	    varDecl82=varDecl();

            	    state._fsp--;

            	    adaptor.addChild(root_0, varDecl82.getTree());

            	    }
            	    break;

            	default :
            	    if ( cnt28 >= 1 ) break loop28;
                        EarlyExitException eee =
                            new EarlyExitException(28, input);
                        throw eee;
                }
                cnt28++;
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "varSection"

    public static class varDecl_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "varDecl"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:162:1: varDecl : r= identList ( COLON idents+= type )? SEMI -> ( ^( VAR $idents ( type )? ) )+ ;
    public final DelphiScriptParser.varDecl_return varDecl() throws RecognitionException {
        DelphiScriptParser.varDecl_return retval = new DelphiScriptParser.varDecl_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token COLON83=null;
        Token SEMI84=null;
        List list_idents=null;
        DelphiScriptParser.identList_return r = null;

        RuleReturnScope idents = null;
        CommonTree COLON83_tree=null;
        CommonTree SEMI84_tree=null;
        RewriteRuleTokenStream stream_COLON=new RewriteRuleTokenStream(adaptor,"token COLON");
        RewriteRuleTokenStream stream_SEMI=new RewriteRuleTokenStream(adaptor,"token SEMI");
        RewriteRuleSubtreeStream stream_identList=new RewriteRuleSubtreeStream(adaptor,"rule identList");
        RewriteRuleSubtreeStream stream_type=new RewriteRuleSubtreeStream(adaptor,"rule type");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:163:2: (r= identList ( COLON idents+= type )? SEMI -> ( ^( VAR $idents ( type )? ) )+ )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:163:4: r= identList ( COLON idents+= type )? SEMI
            {
            pushFollow(FOLLOW_identList_in_varDecl876);
            r=identList();

            state._fsp--;

            stream_identList.add(r.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:163:16: ( COLON idents+= type )?
            int alt29=2;
            int LA29_0 = input.LA(1);

            if ( (LA29_0==COLON) ) {
                alt29=1;
            }
            switch (alt29) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:163:17: COLON idents+= type
                    {
                    COLON83=(Token)match(input,COLON,FOLLOW_COLON_in_varDecl879);  
                    stream_COLON.add(COLON83);

                    pushFollow(FOLLOW_type_in_varDecl883);
                    idents=type();

                    state._fsp--;

                    stream_type.add(idents.getTree());
                    if (list_idents==null) list_idents=new ArrayList();
                    list_idents.add(idents.getTree());


                    }
                    break;

            }

            SEMI84=(Token)match(input,SEMI,FOLLOW_SEMI_in_varDecl887);  
            stream_SEMI.add(SEMI84);

            list_idents=(r!=null?r.list:null);


            // AST REWRITE
            // elements: idents, type
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: idents
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);
            RewriteRuleSubtreeStream stream_idents=new RewriteRuleSubtreeStream(adaptor,"token idents",list_idents);
            root_0 = (CommonTree)adaptor.nil();
            // 165:3: -> ( ^( VAR $idents ( type )? ) )+
            {
                if ( !(stream_idents.hasNext()) ) {
                    throw new RewriteEarlyExitException();
                }
                while ( stream_idents.hasNext() ) {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:165:6: ^( VAR $idents ( type )? )
                    {
                    CommonTree root_1 = (CommonTree)adaptor.nil();
                    root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(VAR, "VAR"), root_1);

                    adaptor.addChild(root_1, stream_idents.nextTree());
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:165:20: ( type )?
                    if ( stream_type.hasNext() ) {
                        adaptor.addChild(root_1, stream_type.nextTree());

                    }
                    stream_type.reset();

                    adaptor.addChild(root_0, root_1);
                    }

                }
                stream_idents.reset();

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "varDecl"

    public static class labelDeclSection_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "labelDeclSection"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:168:1: labelDeclSection : LABEL ( labelId ( COMMA )? )+ SEMI -> ^( LABEL ( labelId )+ ) ;
    public final DelphiScriptParser.labelDeclSection_return labelDeclSection() throws RecognitionException {
        DelphiScriptParser.labelDeclSection_return retval = new DelphiScriptParser.labelDeclSection_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token LABEL85=null;
        Token COMMA87=null;
        Token SEMI88=null;
        DelphiScriptParser.labelId_return labelId86 = null;


        CommonTree LABEL85_tree=null;
        CommonTree COMMA87_tree=null;
        CommonTree SEMI88_tree=null;
        RewriteRuleTokenStream stream_LABEL=new RewriteRuleTokenStream(adaptor,"token LABEL");
        RewriteRuleTokenStream stream_COMMA=new RewriteRuleTokenStream(adaptor,"token COMMA");
        RewriteRuleTokenStream stream_SEMI=new RewriteRuleTokenStream(adaptor,"token SEMI");
        RewriteRuleSubtreeStream stream_labelId=new RewriteRuleSubtreeStream(adaptor,"rule labelId");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:169:2: ( LABEL ( labelId ( COMMA )? )+ SEMI -> ^( LABEL ( labelId )+ ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:169:4: LABEL ( labelId ( COMMA )? )+ SEMI
            {
            LABEL85=(Token)match(input,LABEL,FOLLOW_LABEL_in_labelDeclSection918);  
            stream_LABEL.add(LABEL85);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:169:10: ( labelId ( COMMA )? )+
            int cnt31=0;
            loop31:
            do {
                int alt31=2;
                int LA31_0 = input.LA(1);

                if ( (LA31_0==INT||(LA31_0>=FILE && LA31_0<=ID)) ) {
                    alt31=1;
                }


                switch (alt31) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:169:11: labelId ( COMMA )?
            	    {
            	    pushFollow(FOLLOW_labelId_in_labelDeclSection921);
            	    labelId86=labelId();

            	    state._fsp--;

            	    stream_labelId.add(labelId86.getTree());
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:169:19: ( COMMA )?
            	    int alt30=2;
            	    int LA30_0 = input.LA(1);

            	    if ( (LA30_0==COMMA) ) {
            	        alt30=1;
            	    }
            	    switch (alt30) {
            	        case 1 :
            	            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:169:19: COMMA
            	            {
            	            COMMA87=(Token)match(input,COMMA,FOLLOW_COMMA_in_labelDeclSection923);  
            	            stream_COMMA.add(COMMA87);


            	            }
            	            break;

            	    }


            	    }
            	    break;

            	default :
            	    if ( cnt31 >= 1 ) break loop31;
                        EarlyExitException eee =
                            new EarlyExitException(31, input);
                        throw eee;
                }
                cnt31++;
            } while (true);

            SEMI88=(Token)match(input,SEMI,FOLLOW_SEMI_in_labelDeclSection928);  
            stream_SEMI.add(SEMI88);



            // AST REWRITE
            // elements: labelId, LABEL
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 170:3: -> ^( LABEL ( labelId )+ )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:170:6: ^( LABEL ( labelId )+ )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_LABEL.nextNode(), root_1);

                if ( !(stream_labelId.hasNext()) ) {
                    throw new RewriteEarlyExitException();
                }
                while ( stream_labelId.hasNext() ) {
                    adaptor.addChild(root_1, stream_labelId.nextTree());

                }
                stream_labelId.reset();

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "labelDeclSection"

    public static class labelId_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "labelId"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:173:1: labelId : ( INT | ident );
    public final DelphiScriptParser.labelId_return labelId() throws RecognitionException {
        DelphiScriptParser.labelId_return retval = new DelphiScriptParser.labelId_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token INT89=null;
        DelphiScriptParser.ident_return ident90 = null;


        CommonTree INT89_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:174:2: ( INT | ident )
            int alt32=2;
            int LA32_0 = input.LA(1);

            if ( (LA32_0==INT) ) {
                alt32=1;
            }
            else if ( ((LA32_0>=FILE && LA32_0<=ID)) ) {
                alt32=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 32, 0, input);

                throw nvae;
            }
            switch (alt32) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:174:4: INT
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    INT89=(Token)match(input,INT,FOLLOW_INT_in_labelId950); 
                    INT89_tree = (CommonTree)adaptor.create(INT89);
                    adaptor.addChild(root_0, INT89_tree);


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:175:4: ident
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_ident_in_labelId955);
                    ident90=ident();

                    state._fsp--;

                    adaptor.addChild(root_0, ident90.getTree());

                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "labelId"

    public static class usesClause_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "usesClause"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:178:1: usesClause : USES ( usedUnit ( COMMA )? )+ SEMI -> ^( USES ( usedUnit )+ ) ;
    public final DelphiScriptParser.usesClause_return usesClause() throws RecognitionException {
        DelphiScriptParser.usesClause_return retval = new DelphiScriptParser.usesClause_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token USES91=null;
        Token COMMA93=null;
        Token SEMI94=null;
        DelphiScriptParser.usedUnit_return usedUnit92 = null;


        CommonTree USES91_tree=null;
        CommonTree COMMA93_tree=null;
        CommonTree SEMI94_tree=null;
        RewriteRuleTokenStream stream_USES=new RewriteRuleTokenStream(adaptor,"token USES");
        RewriteRuleTokenStream stream_COMMA=new RewriteRuleTokenStream(adaptor,"token COMMA");
        RewriteRuleTokenStream stream_SEMI=new RewriteRuleTokenStream(adaptor,"token SEMI");
        RewriteRuleSubtreeStream stream_usedUnit=new RewriteRuleSubtreeStream(adaptor,"rule usedUnit");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:179:2: ( USES ( usedUnit ( COMMA )? )+ SEMI -> ^( USES ( usedUnit )+ ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:179:4: USES ( usedUnit ( COMMA )? )+ SEMI
            {
            USES91=(Token)match(input,USES,FOLLOW_USES_in_usesClause966);  
            stream_USES.add(USES91);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:179:9: ( usedUnit ( COMMA )? )+
            int cnt34=0;
            loop34:
            do {
                int alt34=2;
                int LA34_0 = input.LA(1);

                if ( ((LA34_0>=FILE && LA34_0<=ID)) ) {
                    alt34=1;
                }


                switch (alt34) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:179:10: usedUnit ( COMMA )?
            	    {
            	    pushFollow(FOLLOW_usedUnit_in_usesClause969);
            	    usedUnit92=usedUnit();

            	    state._fsp--;

            	    stream_usedUnit.add(usedUnit92.getTree());
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:179:19: ( COMMA )?
            	    int alt33=2;
            	    int LA33_0 = input.LA(1);

            	    if ( (LA33_0==COMMA) ) {
            	        alt33=1;
            	    }
            	    switch (alt33) {
            	        case 1 :
            	            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:179:19: COMMA
            	            {
            	            COMMA93=(Token)match(input,COMMA,FOLLOW_COMMA_in_usesClause971);  
            	            stream_COMMA.add(COMMA93);


            	            }
            	            break;

            	    }


            	    }
            	    break;

            	default :
            	    if ( cnt34 >= 1 ) break loop34;
                        EarlyExitException eee =
                            new EarlyExitException(34, input);
                        throw eee;
                }
                cnt34++;
            } while (true);

            SEMI94=(Token)match(input,SEMI,FOLLOW_SEMI_in_usesClause976);  
            stream_SEMI.add(SEMI94);



            // AST REWRITE
            // elements: usedUnit, USES
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 179:34: -> ^( USES ( usedUnit )+ )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:179:37: ^( USES ( usedUnit )+ )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_USES.nextNode(), root_1);

                if ( !(stream_usedUnit.hasNext()) ) {
                    throw new RewriteEarlyExitException();
                }
                while ( stream_usedUnit.hasNext() ) {
                    adaptor.addChild(root_1, stream_usedUnit.nextTree());

                }
                stream_usedUnit.reset();

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "usesClause"

    public static class usedUnit_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "usedUnit"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:182:1: usedUnit : ident ;
    public final DelphiScriptParser.usedUnit_return usedUnit() throws RecognitionException {
        DelphiScriptParser.usedUnit_return retval = new DelphiScriptParser.usedUnit_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.ident_return ident95 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:183:2: ( ident )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:183:4: ident
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_ident_in_usedUnit997);
            ident95=ident();

            state._fsp--;

            adaptor.addChild(root_0, ident95.getTree());

            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "usedUnit"

    public static class addOp_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "addOp"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:186:1: addOp : ( PLUS | MINUS | OR | XOR );
    public final DelphiScriptParser.addOp_return addOp() throws RecognitionException {
        DelphiScriptParser.addOp_return retval = new DelphiScriptParser.addOp_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token set96=null;

        CommonTree set96_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:187:2: ( PLUS | MINUS | OR | XOR )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:
            {
            root_0 = (CommonTree)adaptor.nil();

            set96=(Token)input.LT(1);
            if ( (input.LA(1)>=PLUS && input.LA(1)<=XOR) ) {
                input.consume();
                adaptor.addChild(root_0, (CommonTree)adaptor.create(set96));
                state.errorRecovery=false;
            }
            else {
                MismatchedSetException mse = new MismatchedSetException(null,input);
                throw mse;
            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "addOp"

    public static class simpleExpression_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "simpleExpression"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:193:1: simpleExpression : term ( addOp term )* ;
    public final DelphiScriptParser.simpleExpression_return simpleExpression() throws RecognitionException {
        DelphiScriptParser.simpleExpression_return retval = new DelphiScriptParser.simpleExpression_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.term_return term97 = null;

        DelphiScriptParser.addOp_return addOp98 = null;

        DelphiScriptParser.term_return term99 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:194:2: ( term ( addOp term )* )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:194:4: term ( addOp term )*
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_term_in_simpleExpression1034);
            term97=term();

            state._fsp--;

            adaptor.addChild(root_0, term97.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:194:9: ( addOp term )*
            loop35:
            do {
                int alt35=2;
                int LA35_0 = input.LA(1);

                if ( ((LA35_0>=PLUS && LA35_0<=XOR)) ) {
                    alt35=1;
                }


                switch (alt35) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:194:10: addOp term
            	    {
            	    pushFollow(FOLLOW_addOp_in_simpleExpression1037);
            	    addOp98=addOp();

            	    state._fsp--;

            	    root_0 = (CommonTree)adaptor.becomeRoot(addOp98.getTree(), root_0);
            	    pushFollow(FOLLOW_term_in_simpleExpression1040);
            	    term99=term();

            	    state._fsp--;

            	    adaptor.addChild(root_0, term99.getTree());

            	    }
            	    break;

            	default :
            	    break loop35;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "simpleExpression"

    public static class term_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "term"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:197:1: term : factor ( mulOp factor )* ;
    public final DelphiScriptParser.term_return term() throws RecognitionException {
        DelphiScriptParser.term_return retval = new DelphiScriptParser.term_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.factor_return factor100 = null;

        DelphiScriptParser.mulOp_return mulOp101 = null;

        DelphiScriptParser.factor_return factor102 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:198:2: ( factor ( mulOp factor )* )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:198:4: factor ( mulOp factor )*
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_factor_in_term1053);
            factor100=factor();

            state._fsp--;

            adaptor.addChild(root_0, factor100.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:198:11: ( mulOp factor )*
            loop36:
            do {
                int alt36=2;
                int LA36_0 = input.LA(1);

                if ( ((LA36_0>=STAR && LA36_0<=SHR)) ) {
                    alt36=1;
                }


                switch (alt36) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:198:12: mulOp factor
            	    {
            	    pushFollow(FOLLOW_mulOp_in_term1056);
            	    mulOp101=mulOp();

            	    state._fsp--;

            	    root_0 = (CommonTree)adaptor.becomeRoot(mulOp101.getTree(), root_0);
            	    pushFollow(FOLLOW_factor_in_term1059);
            	    factor102=factor();

            	    state._fsp--;

            	    adaptor.addChild(root_0, factor102.getTree());

            	    }
            	    break;

            	default :
            	    break loop36;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "term"

    public static class mulOp_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "mulOp"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:201:1: mulOp : ( STAR | SLASH | DIV | MOD | AND | SHL | SHR );
    public final DelphiScriptParser.mulOp_return mulOp() throws RecognitionException {
        DelphiScriptParser.mulOp_return retval = new DelphiScriptParser.mulOp_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token set103=null;

        CommonTree set103_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:202:2: ( STAR | SLASH | DIV | MOD | AND | SHL | SHR )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:
            {
            root_0 = (CommonTree)adaptor.nil();

            set103=(Token)input.LT(1);
            if ( (input.LA(1)>=STAR && input.LA(1)<=SHR) ) {
                input.consume();
                adaptor.addChild(root_0, (CommonTree)adaptor.create(set103));
                state.errorRecovery=false;
            }
            else {
                MismatchedSetException mse = new MismatchedSetException(null,input);
                throw mse;
            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "mulOp"

    public static class factor_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "factor"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:211:1: factor : ( atom | unaryOperator atom );
    public final DelphiScriptParser.factor_return factor() throws RecognitionException {
        DelphiScriptParser.factor_return retval = new DelphiScriptParser.factor_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.atom_return atom104 = null;

        DelphiScriptParser.unaryOperator_return unaryOperator105 = null;

        DelphiScriptParser.atom_return atom106 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:212:2: ( atom | unaryOperator atom )
            int alt37=2;
            int LA37_0 = input.LA(1);

            if ( (LA37_0==INT||LA37_0==LSQBR||LA37_0==LPAREN||(LA37_0>=STRING_LITERAL && LA37_0<=HEX)||(LA37_0>=FILE && LA37_0<=ID)) ) {
                alt37=1;
            }
            else if ( (LA37_0==MINUS||LA37_0==NOT) ) {
                alt37=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 37, 0, input);

                throw nvae;
            }
            switch (alt37) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:212:4: atom
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_atom_in_factor1115);
                    atom104=atom();

                    state._fsp--;

                    adaptor.addChild(root_0, atom104.getTree());

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:213:5: unaryOperator atom
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_unaryOperator_in_factor1121);
                    unaryOperator105=unaryOperator();

                    state._fsp--;

                    root_0 = (CommonTree)adaptor.becomeRoot(unaryOperator105.getTree(), root_0);
                    pushFollow(FOLLOW_atom_in_factor1124);
                    atom106=atom();

                    state._fsp--;

                    adaptor.addChild(root_0, atom106.getTree());

                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "factor"

    public static class atom_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "atom"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:216:1: atom : ( atom2 -> atom2 ) ( DOT r= atom2 -> ^( QUALIFIED_ACCESS $atom $r) )* ;
    public final DelphiScriptParser.atom_return atom() throws RecognitionException {
        DelphiScriptParser.atom_return retval = new DelphiScriptParser.atom_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token DOT108=null;
        DelphiScriptParser.atom2_return r = null;

        DelphiScriptParser.atom2_return atom2107 = null;


        CommonTree DOT108_tree=null;
        RewriteRuleTokenStream stream_DOT=new RewriteRuleTokenStream(adaptor,"token DOT");
        RewriteRuleSubtreeStream stream_atom2=new RewriteRuleSubtreeStream(adaptor,"rule atom2");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:217:2: ( ( atom2 -> atom2 ) ( DOT r= atom2 -> ^( QUALIFIED_ACCESS $atom $r) )* )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:217:4: ( atom2 -> atom2 ) ( DOT r= atom2 -> ^( QUALIFIED_ACCESS $atom $r) )*
            {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:217:4: ( atom2 -> atom2 )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:217:5: atom2
            {
            pushFollow(FOLLOW_atom2_in_atom1137);
            atom2107=atom2();

            state._fsp--;

            stream_atom2.add(atom2107.getTree());


            // AST REWRITE
            // elements: atom2
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 217:11: -> atom2
            {
                adaptor.addChild(root_0, stream_atom2.nextTree());

            }

            retval.tree = root_0;
            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:217:21: ( DOT r= atom2 -> ^( QUALIFIED_ACCESS $atom $r) )*
            loop38:
            do {
                int alt38=2;
                int LA38_0 = input.LA(1);

                if ( (LA38_0==DOT) ) {
                    alt38=1;
                }


                switch (alt38) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:217:22: DOT r= atom2
            	    {
            	    DOT108=(Token)match(input,DOT,FOLLOW_DOT_in_atom1145);  
            	    stream_DOT.add(DOT108);

            	    pushFollow(FOLLOW_atom2_in_atom1149);
            	    r=atom2();

            	    state._fsp--;

            	    stream_atom2.add(r.getTree());


            	    // AST REWRITE
            	    // elements: atom, r
            	    // token labels: 
            	    // rule labels: retval, r
            	    // token list labels: 
            	    // rule list labels: 
            	    // wildcard labels: 
            	    retval.tree = root_0;
            	    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);
            	    RewriteRuleSubtreeStream stream_r=new RewriteRuleSubtreeStream(adaptor,"rule r",r!=null?r.tree:null);

            	    root_0 = (CommonTree)adaptor.nil();
            	    // 217:34: -> ^( QUALIFIED_ACCESS $atom $r)
            	    {
            	        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:217:37: ^( QUALIFIED_ACCESS $atom $r)
            	        {
            	        CommonTree root_1 = (CommonTree)adaptor.nil();
            	        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(QUALIFIED_ACCESS, "QUALIFIED_ACCESS"), root_1);

            	        adaptor.addChild(root_1, stream_retval.nextTree());
            	        adaptor.addChild(root_1, stream_r.nextTree());

            	        adaptor.addChild(root_0, root_1);
            	        }

            	    }

            	    retval.tree = root_0;
            	    }
            	    break;

            	default :
            	    break loop38;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "atom"

    public static class atom2_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "atom2"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:221:1: atom2 : ( particle -> particle ) ( ( LSQBR expressionList RSQBR -> ^( INDEX particle expressionList ) )* | LPAREN (p+= parameterExpression ( COMMA p+= parameterExpression )* )? RPAREN -> ^( METHOD_CALL particle ( $p)* ) ) ;
    public final DelphiScriptParser.atom2_return atom2() throws RecognitionException {
        DelphiScriptParser.atom2_return retval = new DelphiScriptParser.atom2_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token LSQBR110=null;
        Token RSQBR112=null;
        Token LPAREN113=null;
        Token COMMA114=null;
        Token RPAREN115=null;
        List list_p=null;
        DelphiScriptParser.particle_return particle109 = null;

        DelphiScriptParser.expressionList_return expressionList111 = null;

        RuleReturnScope p = null;
        CommonTree LSQBR110_tree=null;
        CommonTree RSQBR112_tree=null;
        CommonTree LPAREN113_tree=null;
        CommonTree COMMA114_tree=null;
        CommonTree RPAREN115_tree=null;
        RewriteRuleTokenStream stream_RPAREN=new RewriteRuleTokenStream(adaptor,"token RPAREN");
        RewriteRuleTokenStream stream_LSQBR=new RewriteRuleTokenStream(adaptor,"token LSQBR");
        RewriteRuleTokenStream stream_COMMA=new RewriteRuleTokenStream(adaptor,"token COMMA");
        RewriteRuleTokenStream stream_RSQBR=new RewriteRuleTokenStream(adaptor,"token RSQBR");
        RewriteRuleTokenStream stream_LPAREN=new RewriteRuleTokenStream(adaptor,"token LPAREN");
        RewriteRuleSubtreeStream stream_particle=new RewriteRuleSubtreeStream(adaptor,"rule particle");
        RewriteRuleSubtreeStream stream_expressionList=new RewriteRuleSubtreeStream(adaptor,"rule expressionList");
        RewriteRuleSubtreeStream stream_parameterExpression=new RewriteRuleSubtreeStream(adaptor,"rule parameterExpression");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:222:2: ( ( particle -> particle ) ( ( LSQBR expressionList RSQBR -> ^( INDEX particle expressionList ) )* | LPAREN (p+= parameterExpression ( COMMA p+= parameterExpression )* )? RPAREN -> ^( METHOD_CALL particle ( $p)* ) ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:222:5: ( particle -> particle ) ( ( LSQBR expressionList RSQBR -> ^( INDEX particle expressionList ) )* | LPAREN (p+= parameterExpression ( COMMA p+= parameterExpression )* )? RPAREN -> ^( METHOD_CALL particle ( $p)* ) )
            {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:222:5: ( particle -> particle )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:222:6: particle
            {
            pushFollow(FOLLOW_particle_in_atom21180);
            particle109=particle();

            state._fsp--;

            stream_particle.add(particle109.getTree());


            // AST REWRITE
            // elements: particle
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 222:15: -> particle
            {
                adaptor.addChild(root_0, stream_particle.nextTree());

            }

            retval.tree = root_0;
            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:223:3: ( ( LSQBR expressionList RSQBR -> ^( INDEX particle expressionList ) )* | LPAREN (p+= parameterExpression ( COMMA p+= parameterExpression )* )? RPAREN -> ^( METHOD_CALL particle ( $p)* ) )
            int alt42=2;
            int LA42_0 = input.LA(1);

            if ( (LA42_0==EOF||LA42_0==SEMI||LA42_0==COLON||LA42_0==DO||(LA42_0>=ASSIGN && LA42_0<=DOWNTO)||(LA42_0>=OF && LA42_0<=COMMA)||LA42_0==THEN||(LA42_0>=PLUS && LA42_0<=RSQBR)||LA42_0==RPAREN||LA42_0==EQUAL||(LA42_0>=NOT_EQUAL && LA42_0<=DOTDOT)) ) {
                alt42=1;
            }
            else if ( (LA42_0==LPAREN) ) {
                alt42=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 42, 0, input);

                throw nvae;
            }
            switch (alt42) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:223:6: ( LSQBR expressionList RSQBR -> ^( INDEX particle expressionList ) )*
                    {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:223:6: ( LSQBR expressionList RSQBR -> ^( INDEX particle expressionList ) )*
                    loop39:
                    do {
                        int alt39=2;
                        int LA39_0 = input.LA(1);

                        if ( (LA39_0==LSQBR) ) {
                            alt39=1;
                        }


                        switch (alt39) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:223:8: LSQBR expressionList RSQBR
                    	    {
                    	    LSQBR110=(Token)match(input,LSQBR,FOLLOW_LSQBR_in_atom21194);  
                    	    stream_LSQBR.add(LSQBR110);

                    	    pushFollow(FOLLOW_expressionList_in_atom21196);
                    	    expressionList111=expressionList();

                    	    state._fsp--;

                    	    stream_expressionList.add(expressionList111.getTree());
                    	    RSQBR112=(Token)match(input,RSQBR,FOLLOW_RSQBR_in_atom21198);  
                    	    stream_RSQBR.add(RSQBR112);



                    	    // AST REWRITE
                    	    // elements: particle, expressionList
                    	    // token labels: 
                    	    // rule labels: retval
                    	    // token list labels: 
                    	    // rule list labels: 
                    	    // wildcard labels: 
                    	    retval.tree = root_0;
                    	    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    	    root_0 = (CommonTree)adaptor.nil();
                    	    // 223:36: -> ^( INDEX particle expressionList )
                    	    {
                    	        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:223:39: ^( INDEX particle expressionList )
                    	        {
                    	        CommonTree root_1 = (CommonTree)adaptor.nil();
                    	        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(INDEX, "INDEX"), root_1);

                    	        adaptor.addChild(root_1, stream_particle.nextTree());
                    	        adaptor.addChild(root_1, stream_expressionList.nextTree());

                    	        adaptor.addChild(root_0, root_1);
                    	        }

                    	    }

                    	    retval.tree = root_0;
                    	    }
                    	    break;

                    	default :
                    	    break loop39;
                        }
                    } while (true);


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:224:6: LPAREN (p+= parameterExpression ( COMMA p+= parameterExpression )* )? RPAREN
                    {
                    LPAREN113=(Token)match(input,LPAREN,FOLLOW_LPAREN_in_atom21219);  
                    stream_LPAREN.add(LPAREN113);

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:224:13: (p+= parameterExpression ( COMMA p+= parameterExpression )* )?
                    int alt41=2;
                    int LA41_0 = input.LA(1);

                    if ( (LA41_0==INT||LA41_0==MINUS||LA41_0==LSQBR||LA41_0==LPAREN||(LA41_0>=STRING_LITERAL && LA41_0<=NOT)||(LA41_0>=FILE && LA41_0<=ID)) ) {
                        alt41=1;
                    }
                    switch (alt41) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:224:14: p+= parameterExpression ( COMMA p+= parameterExpression )*
                            {
                            pushFollow(FOLLOW_parameterExpression_in_atom21224);
                            p=parameterExpression();

                            state._fsp--;

                            stream_parameterExpression.add(p.getTree());
                            if (list_p==null) list_p=new ArrayList();
                            list_p.add(p.getTree());

                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:224:37: ( COMMA p+= parameterExpression )*
                            loop40:
                            do {
                                int alt40=2;
                                int LA40_0 = input.LA(1);

                                if ( (LA40_0==COMMA) ) {
                                    alt40=1;
                                }


                                switch (alt40) {
                            	case 1 :
                            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:224:38: COMMA p+= parameterExpression
                            	    {
                            	    COMMA114=(Token)match(input,COMMA,FOLLOW_COMMA_in_atom21227);  
                            	    stream_COMMA.add(COMMA114);

                            	    pushFollow(FOLLOW_parameterExpression_in_atom21231);
                            	    p=parameterExpression();

                            	    state._fsp--;

                            	    stream_parameterExpression.add(p.getTree());
                            	    if (list_p==null) list_p=new ArrayList();
                            	    list_p.add(p.getTree());


                            	    }
                            	    break;

                            	default :
                            	    break loop40;
                                }
                            } while (true);


                            }
                            break;

                    }

                    RPAREN115=(Token)match(input,RPAREN,FOLLOW_RPAREN_in_atom21237);  
                    stream_RPAREN.add(RPAREN115);



                    // AST REWRITE
                    // elements: particle, p
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: p
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);
                    RewriteRuleSubtreeStream stream_p=new RewriteRuleSubtreeStream(adaptor,"token p",list_p);
                    root_0 = (CommonTree)adaptor.nil();
                    // 224:79: -> ^( METHOD_CALL particle ( $p)* )
                    {
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:224:82: ^( METHOD_CALL particle ( $p)* )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(METHOD_CALL, "METHOD_CALL"), root_1);

                        adaptor.addChild(root_1, stream_particle.nextTree());
                        // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:224:105: ( $p)*
                        while ( stream_p.hasNext() ) {
                            adaptor.addChild(root_1, stream_p.nextTree());

                        }
                        stream_p.reset();

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;

            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "atom2"

    public static class parameterExpression_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "parameterExpression"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:229:1: parameterExpression : expression ;
    public final DelphiScriptParser.parameterExpression_return parameterExpression() throws RecognitionException {
        DelphiScriptParser.parameterExpression_return retval = new DelphiScriptParser.parameterExpression_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.expression_return expression116 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:230:2: ( expression )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:230:4: expression
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_expression_in_parameterExpression1268);
            expression116=expression();

            state._fsp--;

            adaptor.addChild(root_0, expression116.getTree());

            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "parameterExpression"

    public static class particle_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "particle"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:233:1: particle : ( STRING_LITERAL | NIL | FALSE | TRUE | RESULT | EXCEPTIONMESSAGE | number | ident | parentesizedExpression | constArray );
    public final DelphiScriptParser.particle_return particle() throws RecognitionException {
        DelphiScriptParser.particle_return retval = new DelphiScriptParser.particle_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token STRING_LITERAL117=null;
        Token NIL118=null;
        Token FALSE119=null;
        Token TRUE120=null;
        Token RESULT121=null;
        Token EXCEPTIONMESSAGE122=null;
        DelphiScriptParser.number_return number123 = null;

        DelphiScriptParser.ident_return ident124 = null;

        DelphiScriptParser.parentesizedExpression_return parentesizedExpression125 = null;

        DelphiScriptParser.constArray_return constArray126 = null;


        CommonTree STRING_LITERAL117_tree=null;
        CommonTree NIL118_tree=null;
        CommonTree FALSE119_tree=null;
        CommonTree TRUE120_tree=null;
        CommonTree RESULT121_tree=null;
        CommonTree EXCEPTIONMESSAGE122_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:234:2: ( STRING_LITERAL | NIL | FALSE | TRUE | RESULT | EXCEPTIONMESSAGE | number | ident | parentesizedExpression | constArray )
            int alt43=10;
            alt43 = dfa43.predict(input);
            switch (alt43) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:234:4: STRING_LITERAL
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    STRING_LITERAL117=(Token)match(input,STRING_LITERAL,FOLLOW_STRING_LITERAL_in_particle1279); 
                    STRING_LITERAL117_tree = (CommonTree)adaptor.create(STRING_LITERAL117);
                    adaptor.addChild(root_0, STRING_LITERAL117_tree);


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:235:4: NIL
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    NIL118=(Token)match(input,NIL,FOLLOW_NIL_in_particle1284); 
                    NIL118_tree = (CommonTree)adaptor.create(NIL118);
                    adaptor.addChild(root_0, NIL118_tree);


                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:236:4: FALSE
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    FALSE119=(Token)match(input,FALSE,FOLLOW_FALSE_in_particle1289); 
                    FALSE119_tree = (CommonTree)adaptor.create(FALSE119);
                    adaptor.addChild(root_0, FALSE119_tree);


                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:237:4: TRUE
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    TRUE120=(Token)match(input,TRUE,FOLLOW_TRUE_in_particle1294); 
                    TRUE120_tree = (CommonTree)adaptor.create(TRUE120);
                    adaptor.addChild(root_0, TRUE120_tree);


                    }
                    break;
                case 5 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:238:4: RESULT
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    RESULT121=(Token)match(input,RESULT,FOLLOW_RESULT_in_particle1300); 
                    RESULT121_tree = (CommonTree)adaptor.create(RESULT121);
                    adaptor.addChild(root_0, RESULT121_tree);


                    }
                    break;
                case 6 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:239:4: EXCEPTIONMESSAGE
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    EXCEPTIONMESSAGE122=(Token)match(input,EXCEPTIONMESSAGE,FOLLOW_EXCEPTIONMESSAGE_in_particle1306); 
                    EXCEPTIONMESSAGE122_tree = (CommonTree)adaptor.create(EXCEPTIONMESSAGE122);
                    adaptor.addChild(root_0, EXCEPTIONMESSAGE122_tree);


                    }
                    break;
                case 7 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:240:4: number
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_number_in_particle1311);
                    number123=number();

                    state._fsp--;

                    adaptor.addChild(root_0, number123.getTree());

                    }
                    break;
                case 8 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:241:5: ident
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_ident_in_particle1317);
                    ident124=ident();

                    state._fsp--;

                    adaptor.addChild(root_0, ident124.getTree());

                    }
                    break;
                case 9 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:242:4: parentesizedExpression
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_parentesizedExpression_in_particle1325);
                    parentesizedExpression125=parentesizedExpression();

                    state._fsp--;

                    adaptor.addChild(root_0, parentesizedExpression125.getTree());

                    }
                    break;
                case 10 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:243:4: constArray
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_constArray_in_particle1330);
                    constArray126=constArray();

                    state._fsp--;

                    adaptor.addChild(root_0, constArray126.getTree());

                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "particle"

    public static class constArray_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "constArray"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:246:1: constArray : LSQBR expressionList RSQBR -> ^( CONST_ARRAY expressionList ) ;
    public final DelphiScriptParser.constArray_return constArray() throws RecognitionException {
        DelphiScriptParser.constArray_return retval = new DelphiScriptParser.constArray_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token LSQBR127=null;
        Token RSQBR129=null;
        DelphiScriptParser.expressionList_return expressionList128 = null;


        CommonTree LSQBR127_tree=null;
        CommonTree RSQBR129_tree=null;
        RewriteRuleTokenStream stream_LSQBR=new RewriteRuleTokenStream(adaptor,"token LSQBR");
        RewriteRuleTokenStream stream_RSQBR=new RewriteRuleTokenStream(adaptor,"token RSQBR");
        RewriteRuleSubtreeStream stream_expressionList=new RewriteRuleSubtreeStream(adaptor,"rule expressionList");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:247:2: ( LSQBR expressionList RSQBR -> ^( CONST_ARRAY expressionList ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:247:4: LSQBR expressionList RSQBR
            {
            LSQBR127=(Token)match(input,LSQBR,FOLLOW_LSQBR_in_constArray1341);  
            stream_LSQBR.add(LSQBR127);

            pushFollow(FOLLOW_expressionList_in_constArray1343);
            expressionList128=expressionList();

            state._fsp--;

            stream_expressionList.add(expressionList128.getTree());
            RSQBR129=(Token)match(input,RSQBR,FOLLOW_RSQBR_in_constArray1345);  
            stream_RSQBR.add(RSQBR129);



            // AST REWRITE
            // elements: expressionList
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 247:31: -> ^( CONST_ARRAY expressionList )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:247:34: ^( CONST_ARRAY expressionList )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(CONST_ARRAY, "CONST_ARRAY"), root_1);

                adaptor.addChild(root_1, stream_expressionList.nextTree());

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "constArray"

    public static class number_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "number"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:251:1: number : ( INT | FLOAT | HEX );
    public final DelphiScriptParser.number_return number() throws RecognitionException {
        DelphiScriptParser.number_return retval = new DelphiScriptParser.number_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token set130=null;

        CommonTree set130_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:252:2: ( INT | FLOAT | HEX )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:
            {
            root_0 = (CommonTree)adaptor.nil();

            set130=(Token)input.LT(1);
            if ( input.LA(1)==INT||(input.LA(1)>=FLOAT && input.LA(1)<=HEX) ) {
                input.consume();
                adaptor.addChild(root_0, (CommonTree)adaptor.create(set130));
                state.errorRecovery=false;
            }
            else {
                MismatchedSetException mse = new MismatchedSetException(null,input);
                throw mse;
            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "number"

    public static class expressionOrRangeList_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "expressionOrRangeList"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:257:1: expressionOrRangeList : expressionOrRange ( COMMA expressionOrRange )* ;
    public final DelphiScriptParser.expressionOrRangeList_return expressionOrRangeList() throws RecognitionException {
        DelphiScriptParser.expressionOrRangeList_return retval = new DelphiScriptParser.expressionOrRangeList_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token COMMA132=null;
        DelphiScriptParser.expressionOrRange_return expressionOrRange131 = null;

        DelphiScriptParser.expressionOrRange_return expressionOrRange133 = null;


        CommonTree COMMA132_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:258:2: ( expressionOrRange ( COMMA expressionOrRange )* )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:258:4: expressionOrRange ( COMMA expressionOrRange )*
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_expressionOrRange_in_expressionOrRangeList1390);
            expressionOrRange131=expressionOrRange();

            state._fsp--;

            adaptor.addChild(root_0, expressionOrRange131.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:258:22: ( COMMA expressionOrRange )*
            loop44:
            do {
                int alt44=2;
                int LA44_0 = input.LA(1);

                if ( (LA44_0==COMMA) ) {
                    alt44=1;
                }


                switch (alt44) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:258:23: COMMA expressionOrRange
            	    {
            	    COMMA132=(Token)match(input,COMMA,FOLLOW_COMMA_in_expressionOrRangeList1393); 
            	    pushFollow(FOLLOW_expressionOrRange_in_expressionOrRangeList1396);
            	    expressionOrRange133=expressionOrRange();

            	    state._fsp--;

            	    adaptor.addChild(root_0, expressionOrRange133.getTree());

            	    }
            	    break;

            	default :
            	    break loop44;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "expressionOrRangeList"

    public static class parentesizedExpression_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "parentesizedExpression"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:261:1: parentesizedExpression : LPAREN expression RPAREN -> expression ;
    public final DelphiScriptParser.parentesizedExpression_return parentesizedExpression() throws RecognitionException {
        DelphiScriptParser.parentesizedExpression_return retval = new DelphiScriptParser.parentesizedExpression_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token LPAREN134=null;
        Token RPAREN136=null;
        DelphiScriptParser.expression_return expression135 = null;


        CommonTree LPAREN134_tree=null;
        CommonTree RPAREN136_tree=null;
        RewriteRuleTokenStream stream_RPAREN=new RewriteRuleTokenStream(adaptor,"token RPAREN");
        RewriteRuleTokenStream stream_LPAREN=new RewriteRuleTokenStream(adaptor,"token LPAREN");
        RewriteRuleSubtreeStream stream_expression=new RewriteRuleSubtreeStream(adaptor,"rule expression");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:262:2: ( LPAREN expression RPAREN -> expression )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:262:4: LPAREN expression RPAREN
            {
            LPAREN134=(Token)match(input,LPAREN,FOLLOW_LPAREN_in_parentesizedExpression1409);  
            stream_LPAREN.add(LPAREN134);

            pushFollow(FOLLOW_expression_in_parentesizedExpression1411);
            expression135=expression();

            state._fsp--;

            stream_expression.add(expression135.getTree());
            RPAREN136=(Token)match(input,RPAREN,FOLLOW_RPAREN_in_parentesizedExpression1413);  
            stream_RPAREN.add(RPAREN136);



            // AST REWRITE
            // elements: expression
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 263:3: -> expression
            {
                adaptor.addChild(root_0, stream_expression.nextTree());

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "parentesizedExpression"

    public static class unaryOperator_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "unaryOperator"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:266:1: unaryOperator : ( NOT | MINUS );
    public final DelphiScriptParser.unaryOperator_return unaryOperator() throws RecognitionException {
        DelphiScriptParser.unaryOperator_return retval = new DelphiScriptParser.unaryOperator_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token set137=null;

        CommonTree set137_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:267:2: ( NOT | MINUS )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:
            {
            root_0 = (CommonTree)adaptor.nil();

            set137=(Token)input.LT(1);
            if ( input.LA(1)==MINUS||input.LA(1)==NOT ) {
                input.consume();
                adaptor.addChild(root_0, (CommonTree)adaptor.create(set137));
                state.errorRecovery=false;
            }
            else {
                MismatchedSetException mse = new MismatchedSetException(null,input);
                throw mse;
            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "unaryOperator"

    public static class arrayType_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "arrayType"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:271:1: arrayType : ARRAY ( LSQBR e+= expressionOrRange ( COMMA e+= expressionOrRange )* RSQBR )? OF type -> ^( ARRAY ( $e)* type ) ;
    public final DelphiScriptParser.arrayType_return arrayType() throws RecognitionException {
        DelphiScriptParser.arrayType_return retval = new DelphiScriptParser.arrayType_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token ARRAY138=null;
        Token LSQBR139=null;
        Token COMMA140=null;
        Token RSQBR141=null;
        Token OF142=null;
        List list_e=null;
        DelphiScriptParser.type_return type143 = null;

        RuleReturnScope e = null;
        CommonTree ARRAY138_tree=null;
        CommonTree LSQBR139_tree=null;
        CommonTree COMMA140_tree=null;
        CommonTree RSQBR141_tree=null;
        CommonTree OF142_tree=null;
        RewriteRuleTokenStream stream_LSQBR=new RewriteRuleTokenStream(adaptor,"token LSQBR");
        RewriteRuleTokenStream stream_COMMA=new RewriteRuleTokenStream(adaptor,"token COMMA");
        RewriteRuleTokenStream stream_OF=new RewriteRuleTokenStream(adaptor,"token OF");
        RewriteRuleTokenStream stream_RSQBR=new RewriteRuleTokenStream(adaptor,"token RSQBR");
        RewriteRuleTokenStream stream_ARRAY=new RewriteRuleTokenStream(adaptor,"token ARRAY");
        RewriteRuleSubtreeStream stream_expressionOrRange=new RewriteRuleSubtreeStream(adaptor,"rule expressionOrRange");
        RewriteRuleSubtreeStream stream_type=new RewriteRuleSubtreeStream(adaptor,"rule type");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:272:2: ( ARRAY ( LSQBR e+= expressionOrRange ( COMMA e+= expressionOrRange )* RSQBR )? OF type -> ^( ARRAY ( $e)* type ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:272:4: ARRAY ( LSQBR e+= expressionOrRange ( COMMA e+= expressionOrRange )* RSQBR )? OF type
            {
            ARRAY138=(Token)match(input,ARRAY,FOLLOW_ARRAY_in_arrayType1448);  
            stream_ARRAY.add(ARRAY138);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:272:10: ( LSQBR e+= expressionOrRange ( COMMA e+= expressionOrRange )* RSQBR )?
            int alt46=2;
            int LA46_0 = input.LA(1);

            if ( (LA46_0==LSQBR) ) {
                alt46=1;
            }
            switch (alt46) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:272:11: LSQBR e+= expressionOrRange ( COMMA e+= expressionOrRange )* RSQBR
                    {
                    LSQBR139=(Token)match(input,LSQBR,FOLLOW_LSQBR_in_arrayType1451);  
                    stream_LSQBR.add(LSQBR139);

                    pushFollow(FOLLOW_expressionOrRange_in_arrayType1455);
                    e=expressionOrRange();

                    state._fsp--;

                    stream_expressionOrRange.add(e.getTree());
                    if (list_e==null) list_e=new ArrayList();
                    list_e.add(e.getTree());

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:272:38: ( COMMA e+= expressionOrRange )*
                    loop45:
                    do {
                        int alt45=2;
                        int LA45_0 = input.LA(1);

                        if ( (LA45_0==COMMA) ) {
                            alt45=1;
                        }


                        switch (alt45) {
                    	case 1 :
                    	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:272:39: COMMA e+= expressionOrRange
                    	    {
                    	    COMMA140=(Token)match(input,COMMA,FOLLOW_COMMA_in_arrayType1458);  
                    	    stream_COMMA.add(COMMA140);

                    	    pushFollow(FOLLOW_expressionOrRange_in_arrayType1462);
                    	    e=expressionOrRange();

                    	    state._fsp--;

                    	    stream_expressionOrRange.add(e.getTree());
                    	    if (list_e==null) list_e=new ArrayList();
                    	    list_e.add(e.getTree());


                    	    }
                    	    break;

                    	default :
                    	    break loop45;
                        }
                    } while (true);

                    RSQBR141=(Token)match(input,RSQBR,FOLLOW_RSQBR_in_arrayType1466);  
                    stream_RSQBR.add(RSQBR141);


                    }
                    break;

            }

            OF142=(Token)match(input,OF,FOLLOW_OF_in_arrayType1470);  
            stream_OF.add(OF142);

            pushFollow(FOLLOW_type_in_arrayType1472);
            type143=type();

            state._fsp--;

            stream_type.add(type143.getTree());


            // AST REWRITE
            // elements: ARRAY, e, type
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: e
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);
            RewriteRuleSubtreeStream stream_e=new RewriteRuleSubtreeStream(adaptor,"token e",list_e);
            root_0 = (CommonTree)adaptor.nil();
            // 273:3: -> ^( ARRAY ( $e)* type )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:273:6: ^( ARRAY ( $e)* type )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_ARRAY.nextNode(), root_1);

                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:273:14: ( $e)*
                while ( stream_e.hasNext() ) {
                    adaptor.addChild(root_1, stream_e.nextTree());

                }
                stream_e.reset();
                adaptor.addChild(root_1, stream_type.nextTree());

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "arrayType"

    public static class type_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "type"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:276:1: type : ( arrayType | fileType | stringType | ident );
    public final DelphiScriptParser.type_return type() throws RecognitionException {
        DelphiScriptParser.type_return retval = new DelphiScriptParser.type_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.arrayType_return arrayType144 = null;

        DelphiScriptParser.fileType_return fileType145 = null;

        DelphiScriptParser.stringType_return stringType146 = null;

        DelphiScriptParser.ident_return ident147 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:277:2: ( arrayType | fileType | stringType | ident )
            int alt47=4;
            switch ( input.LA(1) ) {
            case ARRAY:
                {
                alt47=1;
                }
                break;
            case FILE:
                {
                int LA47_2 = input.LA(2);

                if ( (!((((input.LT(-1).getType() == DOT))))) ) {
                    alt47=2;
                }
                else if ( (((input.LT(-1).getType() == DOT))) ) {
                    alt47=4;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 47, 2, input);

                    throw nvae;
                }
                }
                break;
            case STRING:
                {
                alt47=3;
                }
                break;
            case ID:
                {
                alt47=4;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 47, 0, input);

                throw nvae;
            }

            switch (alt47) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:277:4: arrayType
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_arrayType_in_type1498);
                    arrayType144=arrayType();

                    state._fsp--;

                    adaptor.addChild(root_0, arrayType144.getTree());

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:278:4: fileType
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_fileType_in_type1503);
                    fileType145=fileType();

                    state._fsp--;

                    adaptor.addChild(root_0, fileType145.getTree());

                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:279:4: stringType
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_stringType_in_type1508);
                    stringType146=stringType();

                    state._fsp--;

                    adaptor.addChild(root_0, stringType146.getTree());

                    }
                    break;
                case 4 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:280:4: ident
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_ident_in_type1513);
                    ident147=ident();

                    state._fsp--;

                    adaptor.addChild(root_0, ident147.getTree());

                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "type"

    public static class stringType_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "stringType"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:284:1: stringType : STRING ( LSQBR expression RSQBR )? ;
    public final DelphiScriptParser.stringType_return stringType() throws RecognitionException {
        DelphiScriptParser.stringType_return retval = new DelphiScriptParser.stringType_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token STRING148=null;
        Token LSQBR149=null;
        Token RSQBR151=null;
        DelphiScriptParser.expression_return expression150 = null;


        CommonTree STRING148_tree=null;
        CommonTree LSQBR149_tree=null;
        CommonTree RSQBR151_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:285:2: ( STRING ( LSQBR expression RSQBR )? )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:285:4: STRING ( LSQBR expression RSQBR )?
            {
            root_0 = (CommonTree)adaptor.nil();

            STRING148=(Token)match(input,STRING,FOLLOW_STRING_in_stringType1525); 
            STRING148_tree = (CommonTree)adaptor.create(STRING148);
            adaptor.addChild(root_0, STRING148_tree);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:285:11: ( LSQBR expression RSQBR )?
            int alt48=2;
            int LA48_0 = input.LA(1);

            if ( (LA48_0==LSQBR) ) {
                alt48=1;
            }
            switch (alt48) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:285:12: LSQBR expression RSQBR
                    {
                    LSQBR149=(Token)match(input,LSQBR,FOLLOW_LSQBR_in_stringType1528); 
                    LSQBR149_tree = (CommonTree)adaptor.create(LSQBR149);
                    adaptor.addChild(root_0, LSQBR149_tree);

                    pushFollow(FOLLOW_expression_in_stringType1530);
                    expression150=expression();

                    state._fsp--;

                    adaptor.addChild(root_0, expression150.getTree());
                    RSQBR151=(Token)match(input,RSQBR,FOLLOW_RSQBR_in_stringType1532); 
                    RSQBR151_tree = (CommonTree)adaptor.create(RSQBR151);
                    adaptor.addChild(root_0, RSQBR151_tree);


                    }
                    break;

            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "stringType"

    public static class expressionList_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "expressionList"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:288:1: expressionList : expression ( COMMA expression )* ;
    public final DelphiScriptParser.expressionList_return expressionList() throws RecognitionException {
        DelphiScriptParser.expressionList_return retval = new DelphiScriptParser.expressionList_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token COMMA153=null;
        DelphiScriptParser.expression_return expression152 = null;

        DelphiScriptParser.expression_return expression154 = null;


        CommonTree COMMA153_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:289:2: ( expression ( COMMA expression )* )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:289:4: expression ( COMMA expression )*
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_expression_in_expressionList1545);
            expression152=expression();

            state._fsp--;

            adaptor.addChild(root_0, expression152.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:289:15: ( COMMA expression )*
            loop49:
            do {
                int alt49=2;
                int LA49_0 = input.LA(1);

                if ( (LA49_0==COMMA) ) {
                    alt49=1;
                }


                switch (alt49) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:289:16: COMMA expression
            	    {
            	    COMMA153=(Token)match(input,COMMA,FOLLOW_COMMA_in_expressionList1548); 
            	    pushFollow(FOLLOW_expression_in_expressionList1551);
            	    expression154=expression();

            	    state._fsp--;

            	    adaptor.addChild(root_0, expression154.getTree());

            	    }
            	    break;

            	default :
            	    break loop49;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "expressionList"

    public static class constSection_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "constSection"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:293:1: constSection : CONST ( constandDecl )+ -> ( ^( CONST constandDecl ) )+ ;
    public final DelphiScriptParser.constSection_return constSection() throws RecognitionException {
        DelphiScriptParser.constSection_return retval = new DelphiScriptParser.constSection_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token CONST155=null;
        DelphiScriptParser.constandDecl_return constandDecl156 = null;


        CommonTree CONST155_tree=null;
        RewriteRuleTokenStream stream_CONST=new RewriteRuleTokenStream(adaptor,"token CONST");
        RewriteRuleSubtreeStream stream_constandDecl=new RewriteRuleSubtreeStream(adaptor,"rule constandDecl");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:294:2: ( CONST ( constandDecl )+ -> ( ^( CONST constandDecl ) )+ )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:294:4: CONST ( constandDecl )+
            {
            CONST155=(Token)match(input,CONST,FOLLOW_CONST_in_constSection1565);  
            stream_CONST.add(CONST155);

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:294:10: ( constandDecl )+
            int cnt50=0;
            loop50:
            do {
                int alt50=2;
                int LA50_0 = input.LA(1);

                if ( ((LA50_0>=FILE && LA50_0<=ID)) ) {
                    alt50=1;
                }


                switch (alt50) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:294:10: constandDecl
            	    {
            	    pushFollow(FOLLOW_constandDecl_in_constSection1567);
            	    constandDecl156=constandDecl();

            	    state._fsp--;

            	    stream_constandDecl.add(constandDecl156.getTree());

            	    }
            	    break;

            	default :
            	    if ( cnt50 >= 1 ) break loop50;
                        EarlyExitException eee =
                            new EarlyExitException(50, input);
                        throw eee;
                }
                cnt50++;
            } while (true);



            // AST REWRITE
            // elements: CONST, constandDecl
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 295:3: -> ( ^( CONST constandDecl ) )+
            {
                if ( !(stream_CONST.hasNext()||stream_constandDecl.hasNext()) ) {
                    throw new RewriteEarlyExitException();
                }
                while ( stream_CONST.hasNext()||stream_constandDecl.hasNext() ) {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:295:6: ^( CONST constandDecl )
                    {
                    CommonTree root_1 = (CommonTree)adaptor.nil();
                    root_1 = (CommonTree)adaptor.becomeRoot(stream_CONST.nextNode(), root_1);

                    adaptor.addChild(root_1, stream_constandDecl.nextTree());

                    adaptor.addChild(root_0, root_1);
                    }

                }
                stream_CONST.reset();
                stream_constandDecl.reset();

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "constSection"

    public static class constandDecl_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "constandDecl"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:298:1: constandDecl : ident EQUAL typedConstant SEMI -> ident typedConstant ;
    public final DelphiScriptParser.constandDecl_return constandDecl() throws RecognitionException {
        DelphiScriptParser.constandDecl_return retval = new DelphiScriptParser.constandDecl_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token EQUAL158=null;
        Token SEMI160=null;
        DelphiScriptParser.ident_return ident157 = null;

        DelphiScriptParser.typedConstant_return typedConstant159 = null;


        CommonTree EQUAL158_tree=null;
        CommonTree SEMI160_tree=null;
        RewriteRuleTokenStream stream_SEMI=new RewriteRuleTokenStream(adaptor,"token SEMI");
        RewriteRuleTokenStream stream_EQUAL=new RewriteRuleTokenStream(adaptor,"token EQUAL");
        RewriteRuleSubtreeStream stream_ident=new RewriteRuleSubtreeStream(adaptor,"rule ident");
        RewriteRuleSubtreeStream stream_typedConstant=new RewriteRuleSubtreeStream(adaptor,"rule typedConstant");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:299:2: ( ident EQUAL typedConstant SEMI -> ident typedConstant )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:299:4: ident EQUAL typedConstant SEMI
            {
            pushFollow(FOLLOW_ident_in_constandDecl1591);
            ident157=ident();

            state._fsp--;

            stream_ident.add(ident157.getTree());
            EQUAL158=(Token)match(input,EQUAL,FOLLOW_EQUAL_in_constandDecl1593);  
            stream_EQUAL.add(EQUAL158);

            pushFollow(FOLLOW_typedConstant_in_constandDecl1595);
            typedConstant159=typedConstant();

            state._fsp--;

            stream_typedConstant.add(typedConstant159.getTree());
            SEMI160=(Token)match(input,SEMI,FOLLOW_SEMI_in_constandDecl1597);  
            stream_SEMI.add(SEMI160);



            // AST REWRITE
            // elements: ident, typedConstant
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 300:3: -> ident typedConstant
            {
                adaptor.addChild(root_0, stream_ident.nextTree());
                adaptor.addChild(root_0, stream_typedConstant.nextTree());

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "constandDecl"

    public static class typedConstant_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "typedConstant"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:303:1: typedConstant : expression ;
    public final DelphiScriptParser.typedConstant_return typedConstant() throws RecognitionException {
        DelphiScriptParser.typedConstant_return retval = new DelphiScriptParser.typedConstant_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.expression_return expression161 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:304:2: ( expression )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:304:4: expression
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_expression_in_typedConstant1617);
            expression161=expression();

            state._fsp--;

            adaptor.addChild(root_0, expression161.getTree());

            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "typedConstant"

    public static class methodOrProperty_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "methodOrProperty"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:308:1: methodOrProperty : methodHeading ;
    public final DelphiScriptParser.methodOrProperty_return methodOrProperty() throws RecognitionException {
        DelphiScriptParser.methodOrProperty_return retval = new DelphiScriptParser.methodOrProperty_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.methodHeading_return methodHeading162 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:309:2: ( methodHeading )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:309:4: methodHeading
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_methodHeading_in_methodOrProperty1630);
            methodHeading162=methodHeading();

            state._fsp--;

            adaptor.addChild(root_0, methodHeading162.getTree());

            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "methodOrProperty"

    public static class methodHeading_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "methodHeading"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:313:1: methodHeading : (m= PROCEDURE | m= FUNCTION ) name= qualifiedIdent ( LPAREN (p+= parameter ( SEMI p+= parameter )* )? RPAREN )? ( COLON methodReturnType )? SEMI -> ^( $m $name ( $p)* ( methodReturnType )? ) ;
    public final DelphiScriptParser.methodHeading_return methodHeading() throws RecognitionException {
        DelphiScriptParser.methodHeading_return retval = new DelphiScriptParser.methodHeading_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token m=null;
        Token LPAREN163=null;
        Token SEMI164=null;
        Token RPAREN165=null;
        Token COLON166=null;
        Token SEMI168=null;
        List list_p=null;
        DelphiScriptParser.qualifiedIdent_return name = null;

        DelphiScriptParser.methodReturnType_return methodReturnType167 = null;

        RuleReturnScope p = null;
        CommonTree m_tree=null;
        CommonTree LPAREN163_tree=null;
        CommonTree SEMI164_tree=null;
        CommonTree RPAREN165_tree=null;
        CommonTree COLON166_tree=null;
        CommonTree SEMI168_tree=null;
        RewriteRuleTokenStream stream_FUNCTION=new RewriteRuleTokenStream(adaptor,"token FUNCTION");
        RewriteRuleTokenStream stream_COLON=new RewriteRuleTokenStream(adaptor,"token COLON");
        RewriteRuleTokenStream stream_RPAREN=new RewriteRuleTokenStream(adaptor,"token RPAREN");
        RewriteRuleTokenStream stream_SEMI=new RewriteRuleTokenStream(adaptor,"token SEMI");
        RewriteRuleTokenStream stream_PROCEDURE=new RewriteRuleTokenStream(adaptor,"token PROCEDURE");
        RewriteRuleTokenStream stream_LPAREN=new RewriteRuleTokenStream(adaptor,"token LPAREN");
        RewriteRuleSubtreeStream stream_parameter=new RewriteRuleSubtreeStream(adaptor,"rule parameter");
        RewriteRuleSubtreeStream stream_methodReturnType=new RewriteRuleSubtreeStream(adaptor,"rule methodReturnType");
        RewriteRuleSubtreeStream stream_qualifiedIdent=new RewriteRuleSubtreeStream(adaptor,"rule qualifiedIdent");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:314:2: ( (m= PROCEDURE | m= FUNCTION ) name= qualifiedIdent ( LPAREN (p+= parameter ( SEMI p+= parameter )* )? RPAREN )? ( COLON methodReturnType )? SEMI -> ^( $m $name ( $p)* ( methodReturnType )? ) )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:314:4: (m= PROCEDURE | m= FUNCTION ) name= qualifiedIdent ( LPAREN (p+= parameter ( SEMI p+= parameter )* )? RPAREN )? ( COLON methodReturnType )? SEMI
            {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:314:4: (m= PROCEDURE | m= FUNCTION )
            int alt51=2;
            int LA51_0 = input.LA(1);

            if ( (LA51_0==PROCEDURE) ) {
                alt51=1;
            }
            else if ( (LA51_0==FUNCTION) ) {
                alt51=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 51, 0, input);

                throw nvae;
            }
            switch (alt51) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:314:5: m= PROCEDURE
                    {
                    m=(Token)match(input,PROCEDURE,FOLLOW_PROCEDURE_in_methodHeading1645);  
                    stream_PROCEDURE.add(m);


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:314:19: m= FUNCTION
                    {
                    m=(Token)match(input,FUNCTION,FOLLOW_FUNCTION_in_methodHeading1651);  
                    stream_FUNCTION.add(m);


                    }
                    break;

            }

            pushFollow(FOLLOW_qualifiedIdent_in_methodHeading1658);
            name=qualifiedIdent();

            state._fsp--;

            stream_qualifiedIdent.add(name.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:316:3: ( LPAREN (p+= parameter ( SEMI p+= parameter )* )? RPAREN )?
            int alt54=2;
            int LA54_0 = input.LA(1);

            if ( (LA54_0==LPAREN) ) {
                alt54=1;
            }
            switch (alt54) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:316:4: LPAREN (p+= parameter ( SEMI p+= parameter )* )? RPAREN
                    {
                    LPAREN163=(Token)match(input,LPAREN,FOLLOW_LPAREN_in_methodHeading1663);  
                    stream_LPAREN.add(LPAREN163);

                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:316:11: (p+= parameter ( SEMI p+= parameter )* )?
                    int alt53=2;
                    int LA53_0 = input.LA(1);

                    if ( (LA53_0==VAR||LA53_0==CONST||(LA53_0>=OUT && LA53_0<=ID)) ) {
                        alt53=1;
                    }
                    switch (alt53) {
                        case 1 :
                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:316:12: p+= parameter ( SEMI p+= parameter )*
                            {
                            pushFollow(FOLLOW_parameter_in_methodHeading1668);
                            p=parameter();

                            state._fsp--;

                            stream_parameter.add(p.getTree());
                            if (list_p==null) list_p=new ArrayList();
                            list_p.add(p.getTree());

                            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:316:25: ( SEMI p+= parameter )*
                            loop52:
                            do {
                                int alt52=2;
                                int LA52_0 = input.LA(1);

                                if ( (LA52_0==SEMI) ) {
                                    alt52=1;
                                }


                                switch (alt52) {
                            	case 1 :
                            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:316:26: SEMI p+= parameter
                            	    {
                            	    SEMI164=(Token)match(input,SEMI,FOLLOW_SEMI_in_methodHeading1671);  
                            	    stream_SEMI.add(SEMI164);

                            	    pushFollow(FOLLOW_parameter_in_methodHeading1675);
                            	    p=parameter();

                            	    state._fsp--;

                            	    stream_parameter.add(p.getTree());
                            	    if (list_p==null) list_p=new ArrayList();
                            	    list_p.add(p.getTree());


                            	    }
                            	    break;

                            	default :
                            	    break loop52;
                                }
                            } while (true);


                            }
                            break;

                    }

                    RPAREN165=(Token)match(input,RPAREN,FOLLOW_RPAREN_in_methodHeading1681);  
                    stream_RPAREN.add(RPAREN165);


                    }
                    break;

            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:317:3: ( COLON methodReturnType )?
            int alt55=2;
            int LA55_0 = input.LA(1);

            if ( (LA55_0==COLON) ) {
                alt55=1;
            }
            switch (alt55) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:317:4: COLON methodReturnType
                    {
                    COLON166=(Token)match(input,COLON,FOLLOW_COLON_in_methodHeading1688);  
                    stream_COLON.add(COLON166);

                    pushFollow(FOLLOW_methodReturnType_in_methodHeading1690);
                    methodReturnType167=methodReturnType();

                    state._fsp--;

                    stream_methodReturnType.add(methodReturnType167.getTree());

                    }
                    break;

            }

            SEMI168=(Token)match(input,SEMI,FOLLOW_SEMI_in_methodHeading1696);  
            stream_SEMI.add(SEMI168);



            // AST REWRITE
            // elements: name, p, methodReturnType, m
            // token labels: m
            // rule labels: retval, name
            // token list labels: 
            // rule list labels: p
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleTokenStream stream_m=new RewriteRuleTokenStream(adaptor,"token m",m);
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);
            RewriteRuleSubtreeStream stream_name=new RewriteRuleSubtreeStream(adaptor,"rule name",name!=null?name.tree:null);
            RewriteRuleSubtreeStream stream_p=new RewriteRuleSubtreeStream(adaptor,"token p",list_p);
            root_0 = (CommonTree)adaptor.nil();
            // 319:3: -> ^( $m $name ( $p)* ( methodReturnType )? )
            {
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:319:6: ^( $m $name ( $p)* ( methodReturnType )? )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_m.nextNode(), root_1);

                adaptor.addChild(root_1, stream_name.nextTree());
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:319:17: ( $p)*
                while ( stream_p.hasNext() ) {
                    adaptor.addChild(root_1, stream_p.nextTree());

                }
                stream_p.reset();
                // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:319:21: ( methodReturnType )?
                if ( stream_methodReturnType.hasNext() ) {
                    adaptor.addChild(root_1, stream_methodReturnType.nextTree());

                }
                stream_methodReturnType.reset();

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "methodHeading"

    public static class methodReturnType_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "methodReturnType"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:323:1: methodReturnType : ( qualifiedIdent | STRING );
    public final DelphiScriptParser.methodReturnType_return methodReturnType() throws RecognitionException {
        DelphiScriptParser.methodReturnType_return retval = new DelphiScriptParser.methodReturnType_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token STRING170=null;
        DelphiScriptParser.qualifiedIdent_return qualifiedIdent169 = null;


        CommonTree STRING170_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:324:2: ( qualifiedIdent | STRING )
            int alt56=2;
            int LA56_0 = input.LA(1);

            if ( ((LA56_0>=FILE && LA56_0<=ID)) ) {
                alt56=1;
            }
            else if ( (LA56_0==STRING) ) {
                alt56=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 56, 0, input);

                throw nvae;
            }
            switch (alt56) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:324:4: qualifiedIdent
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_qualifiedIdent_in_methodReturnType1727);
                    qualifiedIdent169=qualifiedIdent();

                    state._fsp--;

                    adaptor.addChild(root_0, qualifiedIdent169.getTree());

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:325:4: STRING
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    STRING170=(Token)match(input,STRING,FOLLOW_STRING_in_methodReturnType1732); 
                    STRING170_tree = (CommonTree)adaptor.create(STRING170);
                    adaptor.addChild(root_0, STRING170_tree);


                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "methodReturnType"

    public static class parameter_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "parameter"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:328:1: parameter : ( VAR | CONST | OUT )? r= identList ( COLON idents+= type )? ( EQUAL typedConstant )? -> ( ^( FORMAL_PARAMETER $idents ( type )? ( typedConstant )? ) )+ ;
    public final DelphiScriptParser.parameter_return parameter() throws RecognitionException {
        DelphiScriptParser.parameter_return retval = new DelphiScriptParser.parameter_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token VAR171=null;
        Token CONST172=null;
        Token OUT173=null;
        Token COLON174=null;
        Token EQUAL175=null;
        List list_idents=null;
        DelphiScriptParser.identList_return r = null;

        DelphiScriptParser.typedConstant_return typedConstant176 = null;

        RuleReturnScope idents = null;
        CommonTree VAR171_tree=null;
        CommonTree CONST172_tree=null;
        CommonTree OUT173_tree=null;
        CommonTree COLON174_tree=null;
        CommonTree EQUAL175_tree=null;
        RewriteRuleTokenStream stream_COLON=new RewriteRuleTokenStream(adaptor,"token COLON");
        RewriteRuleTokenStream stream_VAR=new RewriteRuleTokenStream(adaptor,"token VAR");
        RewriteRuleTokenStream stream_OUT=new RewriteRuleTokenStream(adaptor,"token OUT");
        RewriteRuleTokenStream stream_CONST=new RewriteRuleTokenStream(adaptor,"token CONST");
        RewriteRuleTokenStream stream_EQUAL=new RewriteRuleTokenStream(adaptor,"token EQUAL");
        RewriteRuleSubtreeStream stream_identList=new RewriteRuleSubtreeStream(adaptor,"rule identList");
        RewriteRuleSubtreeStream stream_typedConstant=new RewriteRuleSubtreeStream(adaptor,"rule typedConstant");
        RewriteRuleSubtreeStream stream_type=new RewriteRuleSubtreeStream(adaptor,"rule type");
        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:329:2: ( ( VAR | CONST | OUT )? r= identList ( COLON idents+= type )? ( EQUAL typedConstant )? -> ( ^( FORMAL_PARAMETER $idents ( type )? ( typedConstant )? ) )+ )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:329:4: ( VAR | CONST | OUT )? r= identList ( COLON idents+= type )? ( EQUAL typedConstant )?
            {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:329:4: ( VAR | CONST | OUT )?
            int alt57=4;
            switch ( input.LA(1) ) {
                case VAR:
                    {
                    alt57=1;
                    }
                    break;
                case CONST:
                    {
                    alt57=2;
                    }
                    break;
                case OUT:
                    {
                    alt57=3;
                    }
                    break;
            }

            switch (alt57) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:329:5: VAR
                    {
                    VAR171=(Token)match(input,VAR,FOLLOW_VAR_in_parameter1744);  
                    stream_VAR.add(VAR171);


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:329:11: CONST
                    {
                    CONST172=(Token)match(input,CONST,FOLLOW_CONST_in_parameter1748);  
                    stream_CONST.add(CONST172);


                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:329:19: OUT
                    {
                    OUT173=(Token)match(input,OUT,FOLLOW_OUT_in_parameter1752);  
                    stream_OUT.add(OUT173);


                    }
                    break;

            }

            pushFollow(FOLLOW_identList_in_parameter1760);
            r=identList();

            state._fsp--;

            stream_identList.add(r.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:330:15: ( COLON idents+= type )?
            int alt58=2;
            int LA58_0 = input.LA(1);

            if ( (LA58_0==COLON) ) {
                alt58=1;
            }
            switch (alt58) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:330:16: COLON idents+= type
                    {
                    COLON174=(Token)match(input,COLON,FOLLOW_COLON_in_parameter1763);  
                    stream_COLON.add(COLON174);

                    pushFollow(FOLLOW_type_in_parameter1767);
                    idents=type();

                    state._fsp--;

                    stream_type.add(idents.getTree());
                    if (list_idents==null) list_idents=new ArrayList();
                    list_idents.add(idents.getTree());


                    }
                    break;

            }

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:331:3: ( EQUAL typedConstant )?
            int alt59=2;
            int LA59_0 = input.LA(1);

            if ( (LA59_0==EQUAL) ) {
                alt59=1;
            }
            switch (alt59) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:331:4: EQUAL typedConstant
                    {
                    EQUAL175=(Token)match(input,EQUAL,FOLLOW_EQUAL_in_parameter1775);  
                    stream_EQUAL.add(EQUAL175);

                    pushFollow(FOLLOW_typedConstant_in_parameter1777);
                    typedConstant176=typedConstant();

                    state._fsp--;

                    stream_typedConstant.add(typedConstant176.getTree());

                    }
                    break;

            }

            list_idents=(r!=null?r.list:null);


            // AST REWRITE
            // elements: type, typedConstant, idents
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: idents
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);
            RewriteRuleSubtreeStream stream_idents=new RewriteRuleSubtreeStream(adaptor,"token idents",list_idents);
            root_0 = (CommonTree)adaptor.nil();
            // 332:3: -> ( ^( FORMAL_PARAMETER $idents ( type )? ( typedConstant )? ) )+
            {
                if ( !(stream_idents.hasNext()) ) {
                    throw new RewriteEarlyExitException();
                }
                while ( stream_idents.hasNext() ) {
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:332:6: ^( FORMAL_PARAMETER $idents ( type )? ( typedConstant )? )
                    {
                    CommonTree root_1 = (CommonTree)adaptor.nil();
                    root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(FORMAL_PARAMETER, "FORMAL_PARAMETER"), root_1);

                    adaptor.addChild(root_1, stream_idents.nextTree());
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:332:33: ( type )?
                    if ( stream_type.hasNext() ) {
                        adaptor.addChild(root_1, stream_type.nextTree());

                    }
                    stream_type.reset();
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:332:39: ( typedConstant )?
                    if ( stream_typedConstant.hasNext() ) {
                        adaptor.addChild(root_1, stream_typedConstant.nextTree());

                    }
                    stream_typedConstant.reset();

                    adaptor.addChild(root_0, root_1);
                    }

                }
                stream_idents.reset();

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "parameter"

    public static class parameterType_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "parameterType"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:335:1: parameterType : ( qualifiedIdent | STRING | FILE );
    public final DelphiScriptParser.parameterType_return parameterType() throws RecognitionException {
        DelphiScriptParser.parameterType_return retval = new DelphiScriptParser.parameterType_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token STRING178=null;
        Token FILE179=null;
        DelphiScriptParser.qualifiedIdent_return qualifiedIdent177 = null;


        CommonTree STRING178_tree=null;
        CommonTree FILE179_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:336:2: ( qualifiedIdent | STRING | FILE )
            int alt60=3;
            switch ( input.LA(1) ) {
            case ID:
                {
                alt60=1;
                }
                break;
            case FILE:
                {
                int LA60_2 = input.LA(2);

                if ( (((input.LT(-1).getType() == DOT))) ) {
                    alt60=1;
                }
                else if ( (true) ) {
                    alt60=3;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 60, 2, input);

                    throw nvae;
                }
                }
                break;
            case STRING:
                {
                alt60=2;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 60, 0, input);

                throw nvae;
            }

            switch (alt60) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:336:4: qualifiedIdent
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_qualifiedIdent_in_parameterType1811);
                    qualifiedIdent177=qualifiedIdent();

                    state._fsp--;

                    adaptor.addChild(root_0, qualifiedIdent177.getTree());

                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:337:4: STRING
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    STRING178=(Token)match(input,STRING,FOLLOW_STRING_in_parameterType1816); 
                    STRING178_tree = (CommonTree)adaptor.create(STRING178);
                    adaptor.addChild(root_0, STRING178_tree);


                    }
                    break;
                case 3 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:338:4: FILE
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    FILE179=(Token)match(input,FILE,FOLLOW_FILE_in_parameterType1821); 
                    FILE179_tree = (CommonTree)adaptor.create(FILE179);
                    adaptor.addChild(root_0, FILE179_tree);


                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "parameterType"

    public static class identList_return extends ParserRuleReturnScope {
        public List list;
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "identList"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:341:1: identList returns [List list] : (i+= ident ( COMMA )? )+ ;
    public final DelphiScriptParser.identList_return identList() throws RecognitionException {
        DelphiScriptParser.identList_return retval = new DelphiScriptParser.identList_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token COMMA180=null;
        List list_i=null;
        RuleReturnScope i = null;
        CommonTree COMMA180_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:342:2: ( (i+= ident ( COMMA )? )+ )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:342:4: (i+= ident ( COMMA )? )+
            {
            root_0 = (CommonTree)adaptor.nil();

            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:342:4: (i+= ident ( COMMA )? )+
            int cnt62=0;
            loop62:
            do {
                int alt62=2;
                int LA62_0 = input.LA(1);

                if ( ((LA62_0>=FILE && LA62_0<=ID)) ) {
                    alt62=1;
                }


                switch (alt62) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:342:5: i+= ident ( COMMA )?
            	    {
            	    pushFollow(FOLLOW_ident_in_identList1839);
            	    i=ident();

            	    state._fsp--;

            	    adaptor.addChild(root_0, i.getTree());
            	    if (list_i==null) list_i=new ArrayList();
            	    list_i.add(i.getTree());

            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:342:14: ( COMMA )?
            	    int alt61=2;
            	    int LA61_0 = input.LA(1);

            	    if ( (LA61_0==COMMA) ) {
            	        alt61=1;
            	    }
            	    switch (alt61) {
            	        case 1 :
            	            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:342:14: COMMA
            	            {
            	            COMMA180=(Token)match(input,COMMA,FOLLOW_COMMA_in_identList1841); 
            	            COMMA180_tree = (CommonTree)adaptor.create(COMMA180);
            	            adaptor.addChild(root_0, COMMA180_tree);


            	            }
            	            break;

            	    }


            	    }
            	    break;

            	default :
            	    if ( cnt62 >= 1 ) break loop62;
                        EarlyExitException eee =
                            new EarlyExitException(62, input);
                        throw eee;
                }
                cnt62++;
            } while (true);

            retval.list =list_i;

            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "identList"

    public static class fileType_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "fileType"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:345:1: fileType : ( FILE | FILE OF qualifiedIdent );
    public final DelphiScriptParser.fileType_return fileType() throws RecognitionException {
        DelphiScriptParser.fileType_return retval = new DelphiScriptParser.fileType_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token FILE181=null;
        Token FILE182=null;
        Token OF183=null;
        DelphiScriptParser.qualifiedIdent_return qualifiedIdent184 = null;


        CommonTree FILE181_tree=null;
        CommonTree FILE182_tree=null;
        CommonTree OF183_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:346:2: ( FILE | FILE OF qualifiedIdent )
            int alt63=2;
            int LA63_0 = input.LA(1);

            if ( (LA63_0==FILE) ) {
                int LA63_1 = input.LA(2);

                if ( (LA63_1==OF) ) {
                    alt63=2;
                }
                else if ( (LA63_1==SEMI||LA63_1==RPAREN||LA63_1==EQUAL) ) {
                    alt63=1;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 63, 1, input);

                    throw nvae;
                }
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 63, 0, input);

                throw nvae;
            }
            switch (alt63) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:346:4: FILE
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    FILE181=(Token)match(input,FILE,FOLLOW_FILE_in_fileType1858); 
                    FILE181_tree = (CommonTree)adaptor.create(FILE181);
                    adaptor.addChild(root_0, FILE181_tree);


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:347:4: FILE OF qualifiedIdent
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    FILE182=(Token)match(input,FILE,FOLLOW_FILE_in_fileType1863); 
                    FILE182_tree = (CommonTree)adaptor.create(FILE182);
                    adaptor.addChild(root_0, FILE182_tree);

                    OF183=(Token)match(input,OF,FOLLOW_OF_in_fileType1865); 
                    OF183_tree = (CommonTree)adaptor.create(OF183);
                    adaptor.addChild(root_0, OF183_tree);

                    pushFollow(FOLLOW_qualifiedIdent_in_fileType1867);
                    qualifiedIdent184=qualifiedIdent();

                    state._fsp--;

                    adaptor.addChild(root_0, qualifiedIdent184.getTree());

                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "fileType"

    public static class qualifiedIdent_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "qualifiedIdent"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:350:1: qualifiedIdent : ident ;
    public final DelphiScriptParser.qualifiedIdent_return qualifiedIdent() throws RecognitionException {
        DelphiScriptParser.qualifiedIdent_return retval = new DelphiScriptParser.qualifiedIdent_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.ident_return ident185 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:351:2: ( ident )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:351:4: ident
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_ident_in_qualifiedIdent1878);
            ident185=ident();

            state._fsp--;

            adaptor.addChild(root_0, ident185.getTree());

            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "qualifiedIdent"

    public static class ident_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "ident"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:355:1: ident : ( ID | keywordAsIdent );
    public final DelphiScriptParser.ident_return ident() throws RecognitionException {
        DelphiScriptParser.ident_return retval = new DelphiScriptParser.ident_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token ID186=null;
        DelphiScriptParser.keywordAsIdent_return keywordAsIdent187 = null;


        CommonTree ID186_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:356:2: ( ID | keywordAsIdent )
            int alt64=2;
            int LA64_0 = input.LA(1);

            if ( (LA64_0==ID) ) {
                alt64=1;
            }
            else if ( (LA64_0==FILE) ) {
                alt64=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 64, 0, input);

                throw nvae;
            }
            switch (alt64) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:356:4: ID
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    ID186=(Token)match(input,ID,FOLLOW_ID_in_ident1892); 
                    ID186_tree = (CommonTree)adaptor.create(ID186);
                    adaptor.addChild(root_0, ID186_tree);


                    }
                    break;
                case 2 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:357:4: keywordAsIdent
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_keywordAsIdent_in_ident1897);
                    keywordAsIdent187=keywordAsIdent();

                    state._fsp--;

                    adaptor.addChild(root_0, keywordAsIdent187.getTree());

                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "ident"

    public static class keywordAsIdent_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "keywordAsIdent"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:360:1: keywordAsIdent : {...}? FILE -> ID[$keywordAsIdent.start] ;
    public final DelphiScriptParser.keywordAsIdent_return keywordAsIdent() throws RecognitionException {
        DelphiScriptParser.keywordAsIdent_return retval = new DelphiScriptParser.keywordAsIdent_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token FILE188=null;

        CommonTree FILE188_tree=null;
        RewriteRuleTokenStream stream_FILE=new RewriteRuleTokenStream(adaptor,"token FILE");

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:361:2: ({...}? FILE -> ID[$keywordAsIdent.start] )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:361:4: {...}? FILE
            {
            if ( !(((input.LT(-1).getType() == DOT))) ) {
                throw new FailedPredicateException(input, "keywordAsIdent", "(input.LT(-1).getType() == DOT)");
            }
            FILE188=(Token)match(input,FILE,FOLLOW_FILE_in_keywordAsIdent1913);  
            stream_FILE.add(FILE188);



            // AST REWRITE
            // elements: 
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 363:3: -> ID[$keywordAsIdent.start]
            {
                adaptor.addChild(root_0, (CommonTree)adaptor.create(ID, ((Token)retval.start)));

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "keywordAsIdent"

    public static class expression_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "expression"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:366:1: expression : simpleExpression ( relOp simpleExpression )* ;
    public final DelphiScriptParser.expression_return expression() throws RecognitionException {
        DelphiScriptParser.expression_return retval = new DelphiScriptParser.expression_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        DelphiScriptParser.simpleExpression_return simpleExpression189 = null;

        DelphiScriptParser.relOp_return relOp190 = null;

        DelphiScriptParser.simpleExpression_return simpleExpression191 = null;



        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:367:2: ( simpleExpression ( relOp simpleExpression )* )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:367:4: simpleExpression ( relOp simpleExpression )*
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_simpleExpression_in_expression1932);
            simpleExpression189=simpleExpression();

            state._fsp--;

            adaptor.addChild(root_0, simpleExpression189.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:367:21: ( relOp simpleExpression )*
            loop65:
            do {
                int alt65=2;
                int LA65_0 = input.LA(1);

                if ( (LA65_0==EQUAL||(LA65_0>=NOT_EQUAL && LA65_0<=IN)) ) {
                    alt65=1;
                }


                switch (alt65) {
            	case 1 :
            	    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:367:22: relOp simpleExpression
            	    {
            	    pushFollow(FOLLOW_relOp_in_expression1935);
            	    relOp190=relOp();

            	    state._fsp--;

            	    root_0 = (CommonTree)adaptor.becomeRoot(relOp190.getTree(), root_0);
            	    pushFollow(FOLLOW_simpleExpression_in_expression1938);
            	    simpleExpression191=simpleExpression();

            	    state._fsp--;

            	    adaptor.addChild(root_0, simpleExpression191.getTree());

            	    }
            	    break;

            	default :
            	    break loop65;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "expression"

    public static class relOp_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "relOp"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:370:1: relOp : ( EQUAL | NOT_EQUAL | LT | LE | GE | GT | IN );
    public final DelphiScriptParser.relOp_return relOp() throws RecognitionException {
        DelphiScriptParser.relOp_return retval = new DelphiScriptParser.relOp_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token set192=null;

        CommonTree set192_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:371:2: ( EQUAL | NOT_EQUAL | LT | LE | GE | GT | IN )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:
            {
            root_0 = (CommonTree)adaptor.nil();

            set192=(Token)input.LT(1);
            if ( input.LA(1)==EQUAL||(input.LA(1)>=NOT_EQUAL && input.LA(1)<=IN) ) {
                input.consume();
                adaptor.addChild(root_0, (CommonTree)adaptor.create(set192));
                state.errorRecovery=false;
            }
            else {
                MismatchedSetException mse = new MismatchedSetException(null,input);
                throw mse;
            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "relOp"

    public static class expressionOrRange_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "expressionOrRange"
    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:380:1: expressionOrRange : simpleExpression ( DOTDOT simpleExpression )? ;
    public final DelphiScriptParser.expressionOrRange_return expressionOrRange() throws RecognitionException {
        DelphiScriptParser.expressionOrRange_return retval = new DelphiScriptParser.expressionOrRange_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        Token DOTDOT194=null;
        DelphiScriptParser.simpleExpression_return simpleExpression193 = null;

        DelphiScriptParser.simpleExpression_return simpleExpression195 = null;


        CommonTree DOTDOT194_tree=null;

        try {
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:381:2: ( simpleExpression ( DOTDOT simpleExpression )? )
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:381:4: simpleExpression ( DOTDOT simpleExpression )?
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_simpleExpression_in_expressionOrRange1994);
            simpleExpression193=simpleExpression();

            state._fsp--;

            adaptor.addChild(root_0, simpleExpression193.getTree());
            // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:381:21: ( DOTDOT simpleExpression )?
            int alt66=2;
            int LA66_0 = input.LA(1);

            if ( (LA66_0==DOTDOT) ) {
                alt66=1;
            }
            switch (alt66) {
                case 1 :
                    // W:\\quality\\test\\garant6x\\DelphiScriptParser\\ANTLRGrammars\\DelphiScript.g:381:22: DOTDOT simpleExpression
                    {
                    DOTDOT194=(Token)match(input,DOTDOT,FOLLOW_DOTDOT_in_expressionOrRange1997); 
                    DOTDOT194_tree = (CommonTree)adaptor.create(DOTDOT194);
                    root_0 = (CommonTree)adaptor.becomeRoot(DOTDOT194_tree, root_0);

                    pushFollow(FOLLOW_simpleExpression_in_expressionOrRange2000);
                    simpleExpression195=simpleExpression();

                    state._fsp--;

                    adaptor.addChild(root_0, simpleExpression195.getTree());

                    }
                    break;

            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
    	retval.tree = (CommonTree)adaptor.errorNode(input, retval.start, input.LT(-1), re);

        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "expressionOrRange"

    // Delegated rules


    protected DFA10 dfa10 = new DFA10(this);
    protected DFA43 dfa43 = new DFA43(this);
    static final String DFA10_eotS =
        "\15\uffff";
    static final String DFA10_eofS =
        "\15\uffff";
    static final String DFA10_minS =
        "\1\22\14\uffff";
    static final String DFA10_maxS =
        "\1\117\14\uffff";
    static final String DFA10_acceptS =
        "\1\uffff\1\1\1\2\1\3\1\4\1\5\1\6\1\7\1\10\1\11\1\12\1\13\1\14";
    static final String DFA10_specialS =
        "\15\uffff}>";
    static final String[] DFA10_transitionS = {
            "\1\3\2\uffff\1\14\1\12\1\11\2\uffff\1\10\1\uffff\1\7\3\uffff"+
            "\1\6\1\5\1\uffff\1\4\3\uffff\1\13\1\uffff\1\2\2\uffff\1\1\2"+
            "\uffff\1\1\12\uffff\1\1\1\uffff\1\1\1\uffff\11\1\7\uffff\2\1",
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
            "",
            ""
    };

    static final short[] DFA10_eot = DFA.unpackEncodedString(DFA10_eotS);
    static final short[] DFA10_eof = DFA.unpackEncodedString(DFA10_eofS);
    static final char[] DFA10_min = DFA.unpackEncodedStringToUnsignedChars(DFA10_minS);
    static final char[] DFA10_max = DFA.unpackEncodedStringToUnsignedChars(DFA10_maxS);
    static final short[] DFA10_accept = DFA.unpackEncodedString(DFA10_acceptS);
    static final short[] DFA10_special = DFA.unpackEncodedString(DFA10_specialS);
    static final short[][] DFA10_transition;

    static {
        int numStates = DFA10_transitionS.length;
        DFA10_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA10_transition[i] = DFA.unpackEncodedString(DFA10_transitionS[i]);
        }
    }

    class DFA10 extends DFA {

        public DFA10(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 10;
            this.eot = DFA10_eot;
            this.eof = DFA10_eof;
            this.min = DFA10_min;
            this.max = DFA10_max;
            this.accept = DFA10_accept;
            this.special = DFA10_special;
            this.transition = DFA10_transition;
        }
        public String getDescription() {
            return "81:1: simpleStatement : ( expressionOrAssignment | gotoStatement | block | caseStatement | repeatStatement | whileStatement | forStatement | withStatement | tryStatement | raiseStatement | ifStatement | BREAK );";
        }
    }
    static final String DFA43_eotS =
        "\13\uffff";
    static final String DFA43_eofS =
        "\13\uffff";
    static final String DFA43_minS =
        "\1\54\12\uffff";
    static final String DFA43_maxS =
        "\1\117\12\uffff";
    static final String DFA43_acceptS =
        "\1\uffff\1\1\1\2\1\3\1\4\1\5\1\6\1\7\1\10\1\11\1\12";
    static final String DFA43_specialS =
        "\13\uffff}>";
    static final String[] DFA43_transitionS = {
            "\1\7\15\uffff\1\12\1\uffff\1\11\1\uffff\1\1\1\2\1\3\1\4\1\5"+
            "\1\6\2\7\10\uffff\2\10",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
    };

    static final short[] DFA43_eot = DFA.unpackEncodedString(DFA43_eotS);
    static final short[] DFA43_eof = DFA.unpackEncodedString(DFA43_eofS);
    static final char[] DFA43_min = DFA.unpackEncodedStringToUnsignedChars(DFA43_minS);
    static final char[] DFA43_max = DFA.unpackEncodedStringToUnsignedChars(DFA43_maxS);
    static final short[] DFA43_accept = DFA.unpackEncodedString(DFA43_acceptS);
    static final short[] DFA43_special = DFA.unpackEncodedString(DFA43_specialS);
    static final short[][] DFA43_transition;

    static {
        int numStates = DFA43_transitionS.length;
        DFA43_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA43_transition[i] = DFA.unpackEncodedString(DFA43_transitionS[i]);
        }
    }

    class DFA43 extends DFA {

        public DFA43(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 43;
            this.eot = DFA43_eot;
            this.eof = DFA43_eof;
            this.min = DFA43_min;
            this.max = DFA43_max;
            this.accept = DFA43_accept;
            this.special = DFA43_special;
            this.transition = DFA43_transition;
        }
        public String getDescription() {
            return "233:1: particle : ( STRING_LITERAL | NIL | FALSE | TRUE | RESULT | EXCEPTIONMESSAGE | number | ident | parentesizedExpression | constArray );";
        }
    }
 

    public static final BitSet FOLLOW_sdUnit_in_goal110 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_usesClause_in_sdUnit122 = new BitSet(new long[]{0x00000C0000000002L,0x0000000000001A00L});
    public static final BitSet FOLLOW_implementationDecl_in_sdUnit128 = new BitSet(new long[]{0x00000C0000000002L,0x0000000000001A00L});
    public static final BitSet FOLLOW_labelDeclSection_in_implementationDecl160 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_constSection_in_implementationDecl165 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_varSection_in_implementationDecl170 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_methodImplOrForwardDecl_in_implementationDecl175 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_methodHeading_in_methodImplOrForwardDecl186 = new BitSet(new long[]{0x00000C0000050000L,0x0000000000001A00L});
    public static final BitSet FOLLOW_fancyBlock_in_methodImplOrForwardDecl196 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_FORWARD_in_methodImplOrForwardDecl213 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_SEMI_in_methodImplOrForwardDecl230 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_implementationDecl_in_fancyBlock242 = new BitSet(new long[]{0x00000C0000040000L,0x0000000000001A00L});
    public static final BitSet FOLLOW_block_in_fancyBlock245 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_BEGIN_in_block267 = new BitSet(new long[]{0xD4009E8B14EE0000L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_statementList_in_block270 = new BitSet(new long[]{0x0000000000080000L});
    public static final BitSet FOLLOW_SEMI_in_block272 = new BitSet(new long[]{0x0000000000080000L});
    public static final BitSet FOLLOW_END_in_block276 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_statement_in_statementList299 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_SEMI_in_statementList301 = new BitSet(new long[]{0xD4009E8B14E40002L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_labelId_in_statement317 = new BitSet(new long[]{0x0000000000100000L});
    public static final BitSet FOLLOW_COLON_in_statement319 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_labelId_in_statement326 = new BitSet(new long[]{0x0000000000100000L});
    public static final BitSet FOLLOW_COLON_in_statement328 = new BitSet(new long[]{0xD4009E8B14E40000L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_simpleStatement_in_statement333 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_expressionOrAssignment_in_simpleStatement344 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_gotoStatement_in_simpleStatement349 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_block_in_simpleStatement354 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_caseStatement_in_simpleStatement359 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_repeatStatement_in_simpleStatement364 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_whileStatement_in_simpleStatement369 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_forStatement_in_simpleStatement374 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_withStatement_in_simpleStatement379 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_tryStatement_in_simpleStatement384 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_raiseStatement_in_simpleStatement389 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ifStatement_in_simpleStatement394 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_BREAK_in_simpleStatement399 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RAISE_in_raiseStatement410 = new BitSet(new long[]{0xD400900000000002L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_raiseStatement414 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_TRY_in_tryStatement427 = new BitSet(new long[]{0xD4009E8B17E40000L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_statementList_in_tryStatement435 = new BitSet(new long[]{0x0000000003000000L});
    public static final BitSet FOLLOW_FINALLY_in_tryStatement443 = new BitSet(new long[]{0xD4009E8B14EC0000L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_EXCEPT_in_tryStatement449 = new BitSet(new long[]{0xD4009E8B14EC0000L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_statementList_in_tryStatement457 = new BitSet(new long[]{0x0000000000080000L});
    public static final BitSet FOLLOW_END_in_tryStatement462 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_WITH_in_withStatement500 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_withStatement502 = new BitSet(new long[]{0x0000000008000000L});
    public static final BitSet FOLLOW_DO_in_withStatement507 = new BitSet(new long[]{0xD4009E8B14E40002L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_statement_in_withStatement509 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_FOR_in_forStatement534 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_ident_in_forStatement536 = new BitSet(new long[]{0x0000000020000000L});
    public static final BitSet FOLLOW_ASSIGN_in_forStatement538 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_forStatement542 = new BitSet(new long[]{0x00000000C0000000L});
    public static final BitSet FOLLOW_TO_in_forStatement547 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_DOWNTO_in_forStatement551 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_forStatement556 = new BitSet(new long[]{0x0000000008000000L});
    public static final BitSet FOLLOW_DO_in_forStatement558 = new BitSet(new long[]{0xD4009E8B14E40000L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_statement_in_forStatement560 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_WHILE_in_whileStatement592 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_whileStatement594 = new BitSet(new long[]{0x0000000008000000L});
    public static final BitSet FOLLOW_DO_in_whileStatement596 = new BitSet(new long[]{0xD4009E8B14E40002L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_statement_in_whileStatement598 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_REPEAT_in_repeatStatement623 = new BitSet(new long[]{0xD4009E8F14E40000L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_statementList_in_repeatStatement625 = new BitSet(new long[]{0x0000000400000000L});
    public static final BitSet FOLLOW_UNTIL_in_repeatStatement628 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_repeatStatement630 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_CASE_in_caseStatement658 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_caseStatement660 = new BitSet(new long[]{0x0000001000000000L});
    public static final BitSet FOLLOW_OF_in_caseStatement662 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_caseSelector_in_caseStatement667 = new BitSet(new long[]{0xD400902000080000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_ELSE_in_caseStatement673 = new BitSet(new long[]{0xD4009E8B14E60000L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_statement_in_caseStatement675 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_SEMI_in_caseStatement678 = new BitSet(new long[]{0x0000000000080000L});
    public static final BitSet FOLLOW_END_in_caseStatement684 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_expressionOrRange_in_caseSelector717 = new BitSet(new long[]{0x0000004000100000L});
    public static final BitSet FOLLOW_COMMA_in_caseSelector720 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expressionOrRange_in_caseSelector722 = new BitSet(new long[]{0x0000004000100000L});
    public static final BitSet FOLLOW_COLON_in_caseSelector726 = new BitSet(new long[]{0xD4009E8B14E60000L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_statement_in_caseSelector728 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_SEMI_in_caseSelector731 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_IF_in_ifStatement761 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_ifStatement763 = new BitSet(new long[]{0x0000010000000000L});
    public static final BitSet FOLLOW_THEN_in_ifStatement765 = new BitSet(new long[]{0xD4009EAB14E40002L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_statement_in_ifStatement769 = new BitSet(new long[]{0x0000002000000002L});
    public static final BitSet FOLLOW_ELSE_in_ifStatement777 = new BitSet(new long[]{0xD4009E8B14E40002L,0x000000000000DA7FL});
    public static final BitSet FOLLOW_statement_in_ifStatement781 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_GOTO_in_gotoStatement826 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_labelId_in_gotoStatement829 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_expression_in_expressionOrAssignment840 = new BitSet(new long[]{0x0000000020000002L});
    public static final BitSet FOLLOW_ASSIGN_in_expressionOrAssignment843 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_expressionOrAssignment846 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_VAR_in_varSection859 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_varDecl_in_varSection862 = new BitSet(new long[]{0x0000100000000002L,0x000000000000C000L});
    public static final BitSet FOLLOW_identList_in_varDecl876 = new BitSet(new long[]{0x0000000000120000L});
    public static final BitSet FOLLOW_COLON_in_varDecl879 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C180L});
    public static final BitSet FOLLOW_type_in_varDecl883 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_SEMI_in_varDecl887 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LABEL_in_labelDeclSection918 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_labelId_in_labelDeclSection921 = new BitSet(new long[]{0x0000104000020000L,0x000000000000C000L});
    public static final BitSet FOLLOW_COMMA_in_labelDeclSection923 = new BitSet(new long[]{0x0000100000020000L,0x000000000000C000L});
    public static final BitSet FOLLOW_SEMI_in_labelDeclSection928 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_INT_in_labelId950 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ident_in_labelId955 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_USES_in_usesClause966 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_usedUnit_in_usesClause969 = new BitSet(new long[]{0x0000104000020000L,0x000000000000C000L});
    public static final BitSet FOLLOW_COMMA_in_usesClause971 = new BitSet(new long[]{0x0000100000020000L,0x000000000000C000L});
    public static final BitSet FOLLOW_SEMI_in_usesClause976 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ident_in_usedUnit997 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_addOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_term_in_simpleExpression1034 = new BitSet(new long[]{0x0003C00000000002L});
    public static final BitSet FOLLOW_addOp_in_simpleExpression1037 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_term_in_simpleExpression1040 = new BitSet(new long[]{0x0003C00000000002L});
    public static final BitSet FOLLOW_factor_in_term1053 = new BitSet(new long[]{0x01FC000000000002L});
    public static final BitSet FOLLOW_mulOp_in_term1056 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_factor_in_term1059 = new BitSet(new long[]{0x01FC000000000002L});
    public static final BitSet FOLLOW_set_in_mulOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_atom_in_factor1115 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_unaryOperator_in_factor1121 = new BitSet(new long[]{0xD400100000000000L,0x000000000000C03FL});
    public static final BitSet FOLLOW_atom_in_factor1124 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_atom2_in_atom1137 = new BitSet(new long[]{0x0200000000000002L});
    public static final BitSet FOLLOW_DOT_in_atom1145 = new BitSet(new long[]{0xD400100000000000L,0x000000000000C03FL});
    public static final BitSet FOLLOW_atom2_in_atom1149 = new BitSet(new long[]{0x0200000000000002L});
    public static final BitSet FOLLOW_particle_in_atom21180 = new BitSet(new long[]{0x1400000000000002L});
    public static final BitSet FOLLOW_LSQBR_in_atom21194 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expressionList_in_atom21196 = new BitSet(new long[]{0x0800000000000000L});
    public static final BitSet FOLLOW_RSQBR_in_atom21198 = new BitSet(new long[]{0x0400000000000002L});
    public static final BitSet FOLLOW_LPAREN_in_atom21219 = new BitSet(new long[]{0xF400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_parameterExpression_in_atom21224 = new BitSet(new long[]{0x2000004000000000L});
    public static final BitSet FOLLOW_COMMA_in_atom21227 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_parameterExpression_in_atom21231 = new BitSet(new long[]{0x2000004000000000L});
    public static final BitSet FOLLOW_RPAREN_in_atom21237 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_expression_in_parameterExpression1268 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_LITERAL_in_particle1279 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_NIL_in_particle1284 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_FALSE_in_particle1289 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_TRUE_in_particle1294 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_RESULT_in_particle1300 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_EXCEPTIONMESSAGE_in_particle1306 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_number_in_particle1311 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ident_in_particle1317 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_parentesizedExpression_in_particle1325 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_constArray_in_particle1330 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LSQBR_in_constArray1341 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expressionList_in_constArray1343 = new BitSet(new long[]{0x0800000000000000L});
    public static final BitSet FOLLOW_RSQBR_in_constArray1345 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_number0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_expressionOrRange_in_expressionOrRangeList1390 = new BitSet(new long[]{0x0000004000000002L});
    public static final BitSet FOLLOW_COMMA_in_expressionOrRangeList1393 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expressionOrRange_in_expressionOrRangeList1396 = new BitSet(new long[]{0x0000004000000002L});
    public static final BitSet FOLLOW_LPAREN_in_parentesizedExpression1409 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_parentesizedExpression1411 = new BitSet(new long[]{0x2000000000000000L});
    public static final BitSet FOLLOW_RPAREN_in_parentesizedExpression1413 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_unaryOperator0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ARRAY_in_arrayType1448 = new BitSet(new long[]{0x0400001000000000L});
    public static final BitSet FOLLOW_LSQBR_in_arrayType1451 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expressionOrRange_in_arrayType1455 = new BitSet(new long[]{0x0800004000000000L});
    public static final BitSet FOLLOW_COMMA_in_arrayType1458 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expressionOrRange_in_arrayType1462 = new BitSet(new long[]{0x0800004000000000L});
    public static final BitSet FOLLOW_RSQBR_in_arrayType1466 = new BitSet(new long[]{0x0000001000000000L});
    public static final BitSet FOLLOW_OF_in_arrayType1470 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C180L});
    public static final BitSet FOLLOW_type_in_arrayType1472 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_arrayType_in_type1498 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_fileType_in_type1503 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_stringType_in_type1508 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ident_in_type1513 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_in_stringType1525 = new BitSet(new long[]{0x0400000000000002L});
    public static final BitSet FOLLOW_LSQBR_in_stringType1528 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_stringType1530 = new BitSet(new long[]{0x0800000000000000L});
    public static final BitSet FOLLOW_RSQBR_in_stringType1532 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_expression_in_expressionList1545 = new BitSet(new long[]{0x0000004000000002L});
    public static final BitSet FOLLOW_COMMA_in_expressionList1548 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_expression_in_expressionList1551 = new BitSet(new long[]{0x0000004000000002L});
    public static final BitSet FOLLOW_CONST_in_constSection1565 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_constandDecl_in_constSection1567 = new BitSet(new long[]{0x0000100000000002L,0x000000000000C000L});
    public static final BitSet FOLLOW_ident_in_constandDecl1591 = new BitSet(new long[]{0x0000000000000000L,0x0000000000000400L});
    public static final BitSet FOLLOW_EQUAL_in_constandDecl1593 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_typedConstant_in_constandDecl1595 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_SEMI_in_constandDecl1597 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_expression_in_typedConstant1617 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_methodHeading_in_methodOrProperty1630 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_PROCEDURE_in_methodHeading1645 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_FUNCTION_in_methodHeading1651 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_qualifiedIdent_in_methodHeading1658 = new BitSet(new long[]{0x1000000000120000L});
    public static final BitSet FOLLOW_LPAREN_in_methodHeading1663 = new BitSet(new long[]{0x2000140000000000L,0x000000000000E200L});
    public static final BitSet FOLLOW_parameter_in_methodHeading1668 = new BitSet(new long[]{0x2000000000020000L});
    public static final BitSet FOLLOW_SEMI_in_methodHeading1671 = new BitSet(new long[]{0x0000140000000000L,0x000000000000E200L});
    public static final BitSet FOLLOW_parameter_in_methodHeading1675 = new BitSet(new long[]{0x2000000000020000L});
    public static final BitSet FOLLOW_RPAREN_in_methodHeading1681 = new BitSet(new long[]{0x0000000000120000L});
    public static final BitSet FOLLOW_COLON_in_methodHeading1688 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C100L});
    public static final BitSet FOLLOW_methodReturnType_in_methodHeading1690 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_SEMI_in_methodHeading1696 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_qualifiedIdent_in_methodReturnType1727 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_in_methodReturnType1732 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_VAR_in_parameter1744 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_CONST_in_parameter1748 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_OUT_in_parameter1752 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_identList_in_parameter1760 = new BitSet(new long[]{0x0000000000100002L,0x0000000000000400L});
    public static final BitSet FOLLOW_COLON_in_parameter1763 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C180L});
    public static final BitSet FOLLOW_type_in_parameter1767 = new BitSet(new long[]{0x0000000000000002L,0x0000000000000400L});
    public static final BitSet FOLLOW_EQUAL_in_parameter1775 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_typedConstant_in_parameter1777 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_qualifiedIdent_in_parameterType1811 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_in_parameterType1816 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_FILE_in_parameterType1821 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ident_in_identList1839 = new BitSet(new long[]{0x0000104000000002L,0x000000000000C000L});
    public static final BitSet FOLLOW_COMMA_in_identList1841 = new BitSet(new long[]{0x0000100000000002L,0x000000000000C000L});
    public static final BitSet FOLLOW_FILE_in_fileType1858 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_FILE_in_fileType1863 = new BitSet(new long[]{0x0000001000000000L});
    public static final BitSet FOLLOW_OF_in_fileType1865 = new BitSet(new long[]{0x0000100000000000L,0x000000000000C000L});
    public static final BitSet FOLLOW_qualifiedIdent_in_fileType1867 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ident_in_qualifiedIdent1878 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_ident1892 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_keywordAsIdent_in_ident1897 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_FILE_in_keywordAsIdent1913 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_simpleExpression_in_expression1932 = new BitSet(new long[]{0x0000000000000002L,0x00000000003F0400L});
    public static final BitSet FOLLOW_relOp_in_expression1935 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_simpleExpression_in_expression1938 = new BitSet(new long[]{0x0000000000000002L,0x00000000003F0400L});
    public static final BitSet FOLLOW_set_in_relOp0 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_simpleExpression_in_expressionOrRange1994 = new BitSet(new long[]{0x0000000000000002L,0x0000000000400000L});
    public static final BitSet FOLLOW_DOTDOT_in_expressionOrRange1997 = new BitSet(new long[]{0xD400900000000000L,0x000000000000C07FL});
    public static final BitSet FOLLOW_simpleExpression_in_expressionOrRange2000 = new BitSet(new long[]{0x0000000000000002L});

}