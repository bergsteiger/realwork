unit l3LexLib;
{* Объектная обертка к Standard Lex library unit for TP Lex Version 3.0.
   2-11-91 AG. }

{ Библиотека "L3 (Low Level Library)" }
{ Автор: Люлин А.В. ©                 }
{ Модуль: l3LexLib -                  }
{ Начат: 11.12.2001 17:34             }
{ $Id: l3LexLib.pas,v 1.8 2011/05/18 12:09:36 lulin Exp $ }

// $Log: l3LexLib.pas,v $
// Revision 1.8  2011/05/18 12:09:36  lulin
// {RequestLink:266409354}.
//
// Revision 1.7  2010/03/25 11:27:58  fireton
// - терялась кодовая страница (всё перекодировалось в ANSI)
//
// Revision 1.6  2009/12/14 11:46:57  lulin
// - готовимся к возврату более простых строк.
//
// Revision 1.5  2001/12/19 08:27:45  law
// - new behavior: сделана обработка ошибок в поисковых формулах.
//
// Revision 1.4  2001/12/14 16:39:18  law
// - new unit: m4SearchFormula.
//
// Revision 1.3  2001/12/14 14:45:12  law
// - new behavior: избавились от использования goto.
//
// Revision 1.2  2001/12/14 14:18:07  law
// - new behavior: в первом приближении написана объектная обертка для Yacc и Lex.
//
// Revision 1.1  2001/12/11 15:20:16  law
// - new units: начата работа над объектными обертками для Lex и Yacc.
//

{$I l3Define.inc }

{$I-}

interface

{* The Lex library unit supplies a collection of variables and routines
   needed by the lexical analyzer routine yylex and application programs
   using Lex-generated lexical analyzers. It also provides access to the
   input/output streams used by the lexical analyzer and the text of the
   matched string, and provides some utility functions which may be used
   in actions.

   This `standard' version of the LexLib unit is used to implement lexical
   analyzers which read from and write to MS-DOS files (using standard input
   and output, by default). It is suitable for many standard applications
   for lexical analyzers, such as text conversion tools or compilers.

   However, you may create your own version of the LexLib unit, tailored to
   your target applications. In particular, you may wish to provide another
   set of I/O functions, e.g., if you want to read from or write to memory
   instead to files, or want to use different file types. }

{* Variables:

   The variable yytext contains the current match, yyleng its length.
   The variable yyline contains the current input line, and yylineno and
   yycolno denote the current input position (line, column). These values
   are often used in giving error diagnostics (however, they will only be
   meaningful if there is no rescanning across line ends).

   The variables yyinput and yyoutput are the text files which are used
   by the lexical analyzer. By default, they are assigned to standard
   input and output, but you may change these assignments to fit your
   target application (use the Turbo Pascal standard routines assign,
   reset, and rewrite for this purpose). }

uses
  {$IfNDef l3LexUseStdIn}
  Classes,
  {$EndIf  l3LexUseStdIn}
  l3Types,
  l3Base,
  l3ProtoObject
  {$IfNDef l3LexUseStdIn}
  ,
  l3Filer,
  l3Interfaces,
  l3String
  {$EndIf l3LexUseStdIn}
  ;

const
  max_matches = 1024;
  max_rules   = 256;
  max_chars   = 2048;

type
  Tl3Lex = class(Tl3ProtoObject)
   {* Машина для лексического разбора. }
    private
    // internal fields
      {$IfNDef l3LexUseStdIn}
      f_Filer            : Tl3CustomFiler;
      {$EndIf  l3LexUseStdIn}
      yystext            : String;
      yysstate, yylstate : Integer;
      yymatches          : Integer;
      yystack            : array [1..max_matches] of Integer;
      yypos              : array [1..max_rules] of Integer;
       {* Variables:

          Some state information is maintained to keep track with calls to yymore,
          yyless, reject, start and yymatch/yymark, and to initialize state
          information used by the lexical analyzer.
          - yystext: contains the initial contents of the yytext variable; this
            will be the empty string, unless yymore is called which sets yystext
            to the current yytext
          - yysstate: start state of lexical analyzer (set to 0 during
            initialization, and modified in calls to the start routine)
          - yylstate: line state information (1 if at beginning of line, 0
            otherwise)
          - yystack: stack containing matched rules; yymatches contains the number of
            matches
          - yypos: for each rule the last marked position (yymark); zeroed when rule
            has already been considered
          - yysleng: copy of the original yyleng used to restore state information
            when reject is used }

      yysleng            : Byte;

      bufptr : Integer;
      buf    : array [1..max_chars] of Char;
    private
    // property methods
      function  pm_Getyyleng: Long;
      procedure pm_SetyyLeng(aValue: Long);
        {-}
    public

      {$IfDef l3LexUseStdIn}
      yyinput           : Text;        {* input file }
      {$EndIf l3LexUseStdIn}
      yyoutput          : Text;        {* output file }
      yyline            : String;      {* current input line }
      yylineno, yycolno : Integer;     {* current input position }
      yytext             : String;
       {* matched text (should be considered r/o) }

    {* I/O routines:

       The following routines get_char, unget_char and put_char are used to
       implement access to the input and output files. Since \n (newline) for
       Lex means line end, the I/O routines have to translate MS-DOS line ends
       (carriage-return/line-feed) into newline characters and vice versa. Input
       is buffered to allow rescanning text (via unput_char).

       The input buffer holds the text of the line to be scanned. When the input
       buffer empties, a new line is obtained from the input stream. Characters
       can be returned to the input buffer by calls to unget_char. At end-of-
       file a null character is returned.

       The input routines also keep track of the input position and set the
       yyline, yylineno, yycolno variables accordingly.

       Since the rest of the Lex library only depends on these three routines
       (there are no direct references to the yyinput and yyoutput files or
       to the input buffer), you can easily replace get_char, unget_char and
       put_char by another suitable set of routines, e.g. if you want to read
       from/write to memory, etc. }

    function get_char : Char;
      {* obtain one character from the input file (null character at end-of-
         file) }

    procedure unget_char ( c : Char );
      {* return one character to the input file to be reread in subsequent calls
         to get_char }

    procedure put_char ( c : Char );
      {* write one character to the output file }

    {* Utility routines: }

    procedure echo;
      {* echoes the current match to the output stream }

    procedure yymore;
      {* append the next match to the current one }

    procedure yyless ( n : Integer );
      {* truncate yytext to size n and return the remaining characters to the
         input stream }

    procedure reject;
      {* reject the current match and execute the next one }

      {* reject does not actually cause the input to be rescanned; instead,
         internal state information is used to find the next match. Hence
         you should not try to modify the input stream or the yytext variable
         when rejecting a match. }

    procedure return ( n : Integer );
    procedure returnc ( c : Char );
      {* sets the return value of yylex }

    procedure start ( state : Integer );
      {* puts the lexical analyzer in the given start state; state=0 denotes
         the default start state, other values are user-defined }

    {* yywrap:

       The yywrap function is called by yylex at end-of-file (unless you have
       specified a rule matching end-of-file). You may redefine this routine
       in your Lex program to do application-dependent processing at end of
       file. In particular, yywrap may arrange for more input and return false
       in which case the yylex routine resumes lexical analysis. }

    function yywrap : Boolean;
      {* The default yywrap routine supplied here closes input and output files
         and returns true (causing yylex to terminate). }

    {* The following are the internal data structures and routines used by the
       lexical analyzer routine yylex; they should not be used directly. }
    public
    
    yystate    : Integer; {* current state of lexical analyzer }
    yyactchar  : Char;    {* current character }
    yylastchar : Char;    {* last matched character (#0 if none) }
    yyrule     : Integer; {* matched rule }
    yyreject   : Boolean; {* current match rejected? }
    yydone     : Boolean; {* yylex return value set? }
    yyretval   : Integer; {* yylex return value }

    procedure yynew;
      {* starts next match; initializes state information of the lexical
         analyzer }

    procedure yyscan;
      {* gets next character from the input stream and updates yytext and
         yyactchar accordingly }

    procedure yymark ( n : Integer );
      {* marks position for rule no. n }

    procedure yymatch ( n : Integer );
      {* declares a match for rule number n }

    function yyfind ( var n : Integer ) : Boolean;
      {* finds the last match and the corresponding marked position and adjusts
         the matched string accordingly; returns:
         - true if a rule has been matched, false otherwise
         - n: the number of the matched rule }

    function yydefault : Boolean;
      {* executes the default action (copy character); returns true unless
         at end-of-file }

    procedure yyclear;
      {* reinitializes state information after lexical analysis has been
         finished }
    protected
    // internal methods
      {$IfNDef l3LexUseStdIn}
      procedure Release;
        override;
        {-}
      {$EndIf  l3LexUseStdIn}
    public
    // public methods
      {$IfDef l3LexUseStdIn}
      constructor Create(anOwner: TObject = nil);
        override;
        {-}
      {$Else  l3LexUseStdIn}
      constructor Create(aStream: TStream);
        reintroduce;
        {-}
      {$EndIf l3LexUseStdIn}
    public
    // public properties
      property yyleng: Long
        read pm_GetyyLeng
        write pm_Setyyleng;
        {-}
  end;//Tl3Lex

implementation

{$IfNDef Console}
uses
  SysUtils
  ;
{$EndIf  Console}

// start class Tl3Lex

{$IfDef l3LexUseStdIn}
constructor Tl3Lex.Create(anOwner: TObject = nil);
  //override;
  {-}
{$Else  l3LexUseStdIn}
constructor Tl3Lex.Create(aStream: TStream);
  //reintroduce;
  {-}
{$EndIf l3LexUseStdIn}
begin
 inherited Create;
 {$IfDef l3LexUseStdIn}
 AssignFile(yyinput, '');
 {$Else  l3LexUseStdIn}
 f_Filer := Tl3CustomFiler.Create;
 f_Filer.Mode := l3_fmRead;
 f_Filer.Stream := aStream;
 {$EndIf l3LexUseStdIn}
 AssignFile(yyoutput, '');
 {$IfDef l3LexUseStdIn}
 reset(yyinput);
 {$EndIf l3LexUseStdIn}
 rewrite(yyoutput);
 yylineno := 0;
 yyclear;
end;

{$IfNDef l3LexUseStdIn}
procedure Tl3Lex.Release;
  //override;
  {-}
begin
 f_Filer.Close;
 l3Free(f_Filer);
 inherited;
end;
{$EndIf  l3LexUseStdIn}

procedure fatal ( msg : String );
  {* writes a fatal error message and halts program }
  begin
   {$IfDef Console}
    writeln('LexLib: ', msg);
    halt(1);
   {$Else  Console}
    raise Exception.Create(msg);
   {$EndIf Console}
  end{*fatal};

{* I/O routines: }

const nl = #10;  {* newline character }

function Tl3Lex.get_char : Char;
  var i : Integer;
      l_S: Tl3WString;
  begin
    if (bufptr=0) and not
    {$IfDef l3LexUseStdIn}
     eof(yyinput)
    {$Else  l3LexUseStdIn}
     f_Filer.EOF
    {$EndIf l3LexUseStdIn} then
      begin
        {$IfDef l3LexUseStdIn}
        readln(yyinput, yyline);
        {$Else  l3LexUseStdIn}
        l_S := f_Filer.Readln;
        yyline := l3PCharLen2String(l_S, l_S.SCodePage);
        {$EndIf l3LexUseStdIn}
        inc(yylineno); yycolno := 1;
        buf[1] := nl;
        for i := 1 to length(yyline) do
          buf[i+1] := yyline[length(yyline)-i+1];
        inc(bufptr, length(yyline)+1);
      end;
    if bufptr>0 then
      begin
        get_char := buf[bufptr];
        dec(bufptr);
        inc(yycolno);
      end
    else
      get_char := #0;
  end{*get_char};

procedure Tl3Lex.unget_char ( c : Char );
  begin
    if bufptr=max_chars then fatal('input buffer overflow');
    inc(bufptr);
    dec(yycolno);
    buf[bufptr] := c;
  end{*unget_char};

procedure Tl3Lex.put_char ( c : Char );
  begin
    if c=#0 then
      { ignore }
    else if c=nl then
      writeln(yyoutput)
    else
      write(yyoutput, c)
  end{*put_char};

{* Utilities: }

procedure Tl3Lex.echo;
  var i : Integer;
  begin
    for i := 1 to yyleng do
      put_char(yytext[i])
  end{*echo};

procedure Tl3Lex.yymore;
  begin
    yystext := yytext;
  end{*yymore};

procedure Tl3Lex.yyless ( n : Integer );
  var i : Integer;
  begin
    for i := yyleng downto n+1 do
      unget_char(yytext[i]);
    yyleng := n;
  end{*yyless};

procedure Tl3Lex.reject;
  var i : Integer;
  begin
    yyreject := true;
    for i := yyleng+1 to yysleng do
      yytext := yytext+get_char;
    dec(yymatches);
  end{*reject};

procedure Tl3Lex.return ( n : Integer );
  begin
    yyretval := n;
    yydone := true;
  end{*return};

procedure Tl3Lex.returnc ( c : Char );
  begin
    yyretval := ord(c);
    yydone := true;
  end{*returnc};

procedure Tl3Lex.start ( state : Integer );
  begin
    yysstate := state;
  end{*start};

{* yywrap: }

function Tl3Lex.yywrap : Boolean;
  begin
    {$IfDef l3LexUseStdIn}
    close(yyinput);
    {$Else  l3LexUseStdIn}
    f_Filer.Stream := nil;
    {$EndIf l3LexUseStdIn}
    close(yyoutput);
    yywrap := true;
  end{*yywrap};

{* Internal routines: }

procedure Tl3Lex.yynew;
  begin
    if yylastchar<>#0 then
      if yylastchar=nl then
        yylstate := 1
      else
        yylstate := 0;
    yystate := yysstate+yylstate;
    yytext  := yystext;
    yystext := '';
    yymatches := 0;
    yydone := false;
  end{*yynew};

procedure Tl3Lex.yyscan;
  begin
    {$IfOpt H-}
    if yyleng=255 then fatal('yytext overflow');
    {$EndIf H-}
    yyactchar := get_char;
    yyleng := yyleng + 1;
    yytext[yyleng] := yyactchar;
  end{*yyscan};

procedure Tl3Lex.yymark ( n : Integer );
  begin
    if n>max_rules then fatal('too many rules');
    yypos[n] := yyleng;
  end{*yymark};

procedure Tl3Lex.yymatch ( n : Integer );
  begin
    inc(yymatches);
    if yymatches>max_matches then fatal('match stack overflow');
    yystack[yymatches] := n;
  end{*yymatch};

function Tl3Lex.yyfind ( var n : Integer ) : Boolean;
  begin
    yyreject := false;
    while (yymatches>0) and (yypos[yystack[yymatches]]=0) do
      dec(yymatches);
    if yymatches>0 then
      begin
        yysleng := yyleng;
        n       := yystack[yymatches];
        yyless(yypos[n]);
        yypos[n] := 0;
        if yyleng>0 then
          yylastchar := yytext[yyleng]
        else
          yylastchar := #0;
        yyfind := true;
      end
    else
      begin
        yyless(0);
        yylastchar := #0;
        yyfind := false;
      end
  end{*yyfind};

function Tl3Lex.yydefault : Boolean;
  begin
    yyreject := false;
    yyactchar := get_char;
    if yyactchar<>#0 then
      begin
        put_char(yyactchar);
        yydefault := true;
      end
    else
      begin
        yylstate := 1;
        yydefault := false;
      end;
    yylastchar := yyactchar;
  end{*yydefault};

procedure Tl3Lex.yyclear;
  begin
    bufptr := 0;
    yysstate := 0;
    yylstate := 1;
    yylastchar := #0;
    yytext := '';
    yystext := '';
  end{*yyclear};

function Tl3Lex.pm_Getyyleng: Long;
  {-}
begin
 Result := Length(yytext);
end;

procedure Tl3Lex.pm_SetyyLeng(aValue: Long);
  {-}
begin
 SetLength(yytext, aValue);
end;

end{*LexLib}.

