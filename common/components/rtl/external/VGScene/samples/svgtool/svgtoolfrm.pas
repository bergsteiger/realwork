unit svgtoolfrm;

{$I vg_define.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  xdom, vg_layouts, vg_scene, vg_controls, vg_objects;

type

  TfrmSVGTool = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    ToolBar1: TvgToolBar;
    OpenDialog1: TOpenDialog;
    btnLoad: TvgToolPathButton;
    btnSave: TvgToolPathButton;
    SaveDialog1: TSaveDialog;
    Layout1: TvgLayout;
    SVG: TvgScaledLayout;
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoExternalSubset(sender: TObject; const parentSystemId: wideString;
      var publicId, systemId: wideString; var stream: TStream;
      var action: TXmlParserAction);
  public
    { Public declarations }
    FSvg: TdomDocument;
    procedure SvgToVG;
  end;

var
  frmSVGTool: TfrmSVGTool;

implementation

uses Math;

{$R *.dfm}

(* colors_num = 148;

 colors : array[0..colors_num - 1 ] of named_color =
  ((name:'aliceblue';            r:240; g:248; b:255; a:255 ) ,
   (name:'antiquewhite';         r:250; g:235; b:215; a:255 ) ,
   (name:'aqua';                 r:0;   g:255; b:255; a:255 ) ,
   (name:'aquamarine';           r:127; g:255; b:212; a:255 ) ,
   (name:'azure';                r:240; g:255; b:255; a:255 ) ,
   (name:'beige';                r:245; g:245; b:220; a:255 ) ,
   (name:'bisque';               r:255; g:228; b:196; a:255 ) ,
   (name:'black';                r:0;   g:0;   b:0;   a:255 ) ,
   (name:'blanchedalmond';       r:255; g:235; b:205; a:255 ) ,
   (name:'blue';                 r:0;   g:0;   b:255; a:255 ) ,
   (name:'blueviolet';           r:138; g:43;  b:226; a:255 ) ,
   (name:'brown';                r:165; g:42;  b:42;  a:255 ) ,
   (name:'burlywood';            r:222; g:184; b:135; a:255 ) ,
   (name:'cadetblue';            r:95;  g:158; b:160; a:255 ) ,
   (name:'chartreuse';           r:127; g:255; b:0;   a:255 ) ,
   (name:'chocolate';            r:210; g:105; b:30;  a:255 ) ,
   (name:'coral';                r:255; g:127; b:80;  a:255 ) ,
   (name:'cornflowerblue';       r:100; g:149; b:237; a:255 ) ,
   (name:'cornsilk';             r:255; g:248; b:220; a:255 ) ,
   (name:'crimson';              r:220; g:20;  b:60;  a:255 ) ,
   (name:'cyan';                 r:0;   g:255; b:255; a:255 ) ,
   (name:'darkblue';             r:0;   g:0;   b:139; a:255 ) ,
   (name:'darkcyan';             r:0;   g:139; b:139; a:255 ) ,
   (name:'darkgoldenrod';        r:184; g:134; b:11;  a:255 ) ,
   (name:'darkgray';             r:169; g:169; b:169; a:255 ) ,
   (name:'darkgreen';            r:0;   g:100; b:0;   a:255 ) ,
   (name:'darkgrey';             r:169; g:169; b:169; a:255 ) ,
   (name:'darkkhaki';            r:189; g:183; b:107; a:255 ) ,
   (name:'darkmagenta';          r:139; g:0;   b:139; a:255 ) ,
   (name:'darkolivegreen';       r:85;  g:107; b:47;  a:255 ) ,
   (name:'darkorange';           r:255; g:140; b:0;   a:255 ) ,
   (name:'darkorchid';           r:153; g:50;  b:204; a:255 ) ,
   (name:'darkred';              r:139; g:0;   b:0;   a:255 ) ,
   (name:'darksalmon';           r:233; g:150; b:122; a:255 ) ,
   (name:'darkseagreen';         r:143; g:188; b:143; a:255 ) ,
   (name:'darkslateblue';        r:72;  g:61;  b:139; a:255 ) ,
   (name:'darkslategray';        r:47;  g:79;  b:79;  a:255 ) ,
   (name:'darkslategrey';        r:47;  g:79;  b:79;  a:255 ) ,
   (name:'darkturquoise';        r:0;   g:206; b:209; a:255 ) ,
   (name:'darkviolet';           r:148; g:0;   b:211; a:255 ) ,
   (name:'deeppink';             r:255; g:20;  b:147; a:255 ) ,
   (name:'deepskyblue';          r:0;   g:191; b:255; a:255 ) ,
   (name:'dimgray';              r:105; g:105; b:105; a:255 ) ,
   (name:'dimgrey';              r:105; g:105; b:105; a:255 ) ,
   (name:'dodgerblue';           r:30;  g:144; b:255; a:255 ) ,
   (name:'firebrick';            r:178; g:34;  b:34;  a:255 ) ,
   (name:'floralwhite';          r:255; g:250; b:240; a:255 ) ,
   (name:'forestgreen';          r:34;  g:139; b:34;  a:255 ) ,
   (name:'fuchsia';              r:255; g:0;   b:255; a:255 ) ,
   (name:'gainsboro';            r:220; g:220; b:220; a:255 ) ,
   (name:'ghostwhite';           r:248; g:248; b:255; a:255 ) ,
   (name:'gold';                 r:255; g:215; b:0;   a:255 ) ,
   (name:'goldenrod';            r:218; g:165; b:32;  a:255 ) ,
   (name:'gray';                 r:128; g:128; b:128; a:255 ) ,
   (name:'green';                r:0;   g:128; b:0;   a:255 ) ,
   (name:'greenyellow';          r:173; g:255; b:47;  a:255 ) ,
   (name:'grey';                 r:128; g:128; b:128; a:255 ) ,
   (name:'honeydew';             r:240; g:255; b:240; a:255 ) ,
   (name:'hotpink';              r:255; g:105; b:180; a:255 ) ,
   (name:'indianred';            r:205; g:92;  b:92;  a:255 ) ,
   (name:'indigo';               r:75;  g:0;   b:130; a:255 ) ,
   (name:'ivory';                r:255; g:255; b:240; a:255 ) ,
   (name:'khaki';                r:240; g:230; b:140; a:255 ) ,
   (name:'lavender';             r:230; g:230; b:250; a:255 ) ,
   (name:'lavenderblush';        r:255; g:240; b:245; a:255 ) ,
   (name:'lawngreen';            r:124; g:252; b:0;   a:255 ) ,
   (name:'lemonchiffon';         r:255; g:250; b:205; a:255 ) ,
   (name:'lightblue';            r:173; g:216; b:230; a:255 ) ,
   (name:'lightcoral';           r:240; g:128; b:128; a:255 ) ,
   (name:'lightcyan';            r:224; g:255; b:255; a:255 ) ,
   (name:'lightgoldenrodyellow'; r:250; g:250; b:210; a:255 ) ,
   (name:'lightgray';            r:211; g:211; b:211; a:255 ) ,
   (name:'lightgreen';           r:144; g:238; b:144; a:255 ) ,
   (name:'lightgrey';            r:211; g:211; b:211; a:255 ) ,
   (name:'lightpink';            r:255; g:182; b:193; a:255 ) ,
   (name:'lightsalmon';          r:255; g:160; b:122; a:255 ) ,
   (name:'lightseagreen';        r:32;  g:178; b:170; a:255 ) ,
   (name:'lightskyblue';         r:135; g:206; b:250; a:255 ) ,
   (name:'lightslategray';       r:119; g:136; b:153; a:255 ) ,
   (name:'lightslategrey';       r:119; g:136; b:153; a:255 ) ,
   (name:'lightsteelblue';       r:176; g:196; b:222; a:255 ) ,
   (name:'lightyellow';          r:255; g:255; b:224; a:255 ) ,
   (name:'lime';                 r:0;   g:255; b:0;   a:255 ) ,
   (name:'limegreen';            r:50;  g:205; b:50;  a:255 ) ,
   (name:'linen';                r:250; g:240; b:230; a:255 ) ,
   (name:'magenta';              r:255; g:0;   b:255; a:255 ) ,
   (name:'maroon';               r:128; g:0;   b:0;   a:255 ) ,
   (name:'mediumaquamarine';     r:102; g:205; b:170; a:255 ) ,
   (name:'mediumblue';           r:0;   g:0;   b:205; a:255 ) ,
   (name:'mediumorchid';         r:186; g:85;  b:211; a:255 ) ,
   (name:'mediumpurple';         r:147; g:112; b:219; a:255 ) ,
   (name:'mediumseagreen';       r:60;  g:179; b:113; a:255 ) ,
   (name:'mediumslateblue';      r:123; g:104; b:238; a:255 ) ,
   (name:'mediumspringgreen';    r:0;   g:250; b:154; a:255 ) ,
   (name:'mediumturquoise';      r:72;  g:209; b:204; a:255 ) ,
   (name:'mediumvioletred';      r:199; g:21;  b:133; a:255 ) ,
   (name:'midnightblue';         r:25;  g:25;  b:112; a:255 ) ,
   (name:'mintcream';            r:245; g:255; b:250; a:255 ) ,
   (name:'mistyrose';            r:255; g:228; b:225; a:255 ) ,
   (name:'moccasin';             r:255; g:228; b:181; a:255 ) ,
   (name:'navajowhite';          r:255; g:222; b:173; a:255 ) ,
   (name:'navy';                 r:0;   g:0;   b:128; a:255 ) ,
   (name:'oldlace';              r:253; g:245; b:230; a:255 ) ,
   (name:'olive';                r:128; g:128; b:0;   a:255 ) ,
   (name:'olivedrab';            r:107; g:142; b:35;  a:255 ) ,
   (name:'orange';               r:255; g:165; b:0;   a:255 ) ,
   (name:'orangered';            r:255; g:69;  b:0;   a:255 ) ,
   (name:'orchid';               r:218; g:112; b:214; a:255 ) ,
   (name:'palegoldenrod';        r:238; g:232; b:170; a:255 ) ,
   (name:'palegreen';            r:152; g:251; b:152; a:255 ) ,
   (name:'paleturquoise';        r:175; g:238; b:238; a:255 ) ,
   (name:'palevioletred';        r:219; g:112; b:147; a:255 ) ,
   (name:'papayawhip';           r:255; g:239; b:213; a:255 ) ,
   (name:'peachpuff';            r:255; g:218; b:185; a:255 ) ,
   (name:'peru';                 r:205; g:133; b:63;  a:255 ) ,
   (name:'pink';                 r:255; g:192; b:203; a:255 ) ,
   (name:'plum';                 r:221; g:160; b:221; a:255 ) ,
   (name:'powderblue';           r:176; g:224; b:230; a:255 ) ,
   (name:'purple';               r:128; g:0;   b:128; a:255 ) ,
   (name:'red';                  r:255; g:0;   b:0;   a:255 ) ,
   (name:'rosybrown';            r:188; g:143; b:143; a:255 ) ,
   (name:'royalblue';            r:65;  g:105; b:225; a:255 ) ,
   (name:'saddlebrown';          r:139; g:69;  b:19;  a:255 ) ,
   (name:'salmon';               r:250; g:128; b:114; a:255 ) ,
   (name:'sandybrown';           r:244; g:164; b:96;  a:255 ) ,
   (name:'seagreen';             r:46;  g:139; b:87;  a:255 ) ,
   (name:'seashell';             r:255; g:245; b:238; a:255 ) ,
   (name:'sienna';               r:160; g:82;  b:45;  a:255 ) ,
   (name:'silver';               r:192; g:192; b:192; a:255 ) ,
   (name:'skyblue';              r:135; g:206; b:235; a:255 ) ,
   (name:'slateblue';            r:106; g:90;  b:205; a:255 ) ,
   (name:'slategray';            r:112; g:128; b:144; a:255 ) ,
   (name:'slategrey';            r:112; g:128; b:144; a:255 ) ,
   (name:'snow';                 r:255; g:250; b:250; a:255 ) ,
   (name:'springgreen';          r:0;   g:255; b:127; a:255 ) ,
   (name:'steelblue';            r:70;  g:130; b:180; a:255 ) ,
   (name:'tan';                  r:210; g:180; b:140; a:255 ) ,
   (name:'teal';                 r:0;   g:128; b:128; a:255 ) ,
   (name:'thistle';              r:216; g:191; b:216; a:255 ) ,
   (name:'tomato';               r:255; g:99;  b:71;  a:255 ) ,
   (name:'turquoise';            r:64;  g:224; b:208; a:255 ) ,
   (name:'violet';               r:238; g:130; b:238; a:255 ) ,
   (name:'wheat';                r:245; g:222; b:179; a:255 ) ,
   (name:'white';                r:255; g:255; b:255; a:255 ) ,
   (name:'whitesmoke';           r:245; g:245; b:245; a:255 ) ,
   (name:'yellow';               r:255; g:255; b:0;   a:255 ) ,
   (name:'yellowgreen';          r:154; g:205; b:50;  a:255 ) ,
   (name:'zzzzzzzzzzz';          r:0;   g:0;   b:0;   a:0   ) ); *)

procedure TfrmSVGTool.btnLoadClick(Sender: TObject);
var
  DomImpl : TDomImplementation;
  Parser : TXmlToDomParser;
begin
  if OpenDialog1.Execute then
  begin
    DomImpl:= TDomImplementation.Create(nil);
    Parser:= TXmlToDomParser.Create(nil);
    Parser.DomImpl := DomImpl;
    Parser.OnExternalSubset := DoExternalSubset;
    FSvg := Parser.fileToDom(OpenDialog1.FileName);
    SvgToVG;
    Parser.Free;
    DomImpl.Free;
  end;
end;

procedure TfrmSVGTool.btnSaveClick(Sender: TObject);
var
  S: TStream;
begin
  if SaveDialog1.Execute then
  begin
    S := TFileStream.Create(SaveDialog1.FileName, fmCreate);
    SVG.Align := vaNone;
    SVG.SaveToStream(S);
    SVG.Align := vaFit;
    S.Free;
  end;
end;

procedure TfrmSVGTool.DoExternalSubset(sender: TObject;
  const parentSystemId: wideString; var publicId, systemId: wideString;
  var stream: TStream; var action: TXmlParserAction);
begin
  action := paOK;
end;

procedure TfrmSVGTool.SvgToVG;

var
  W, H: single;

  function FromRGB(Color: longword): longword;
  asm
    BSWAP   EAX
    MOV     AL, $FF
    ROR     EAX,8
  end;

  function parseTransform(var Node: TdomNode): TvgMatrix;
  var
    Attr: TdomNode;
    v, v1, v2, t, Trans: AnsiString;
  begin
    Result := IdentityMatrix;
    Attr := Node.attributes.getNamedItem('transform');
    if (Attr <> nil) then
    begin
      Trans := Attr.NodeValue;
      while Trans <> '' do
      begin
        t := vgGetToken(Trans, '(');
        if LowerCase(t) = 'translate' then
        begin
          v1 := vgGetToken(Trans, ',');
          v2 := vgGetToken(Trans, ')');
          Result.m31 := vgStrToFloat(v1);
          Result.m32 := vgStrToFloat(v2);
        end;
        if LowerCase(t) = 'matrix' then
        begin
          v1 := vgGetToken(Trans, ',');
          v2 := vgGetToken(Trans, ',');
          Result.m11 := vgStrToFloat(v1);
          Result.m12 := vgStrToFloat(v2);
          v1 := vgGetToken(Trans, ',');
          v2 := vgGetToken(Trans, ',');
          Result.m21 := vgStrToFloat(v1);
          Result.m22 := vgStrToFloat(v2);
          v1 := vgGetToken(Trans, ',');
          v2 := vgGetToken(Trans, ')');
          Result.m31 := vgStrToFloat(v1);
          Result.m32 := vgStrToFloat(v2);
        end;
      end;
    end;
  end;

  function vgStr4ToColor(Value: string): TvgColor;
  begin
    try
      if Length(Value) = 4 then
      begin
        Result := vgStrToColor('#' + Value[2] + Value[2] + Value[3] + Value[3] + Value[4] + Value[4]);
      end
      else
        Result := 0;
    except
    end;
  end;

  function parseColorToInt(str: AnsiString): cardinal;
  var
    s, v, v1, v2: AnsiString;
    c: longint;
    o: TvgObject;
  begin
    Result := 0;
    if Length(str) = 0 then Exit;

    if Pos('rgb', LowerCase(str)) > 0 then
    begin
      s := str;
      vgGetToken(str, '(');
      v := vgGetToken(str, ',');
      v1 := vgGetToken(str, ',');
      v2 := vgGetToken(str, ')');
      try
        Result := RGB(StrToInt(v2), StrToInt(v1), StrToInt(v)) or $FF000000;
      except
        Result := $FFFFFF or $FF000000;
      end;
    end
    else
    if LowerCase(str) = 'none' then
      Result := 0
    else
    if not (Pos(Str[1], '#0123456789') > 0) then
    begin
      if IdentToColor('cl' + Str, c) then
        Result := FromRGB(c) or $FF000000;
    end
    else
    if Length(str) = 4 then
    begin
      Result := vgStr4ToColor(str) or $FF000000;
    end
    else
    begin
      Result := vgStrToColor(str) or $FF000000;
    end;
  end;

  procedure parseColor(str: AnsiString; var Fill: TvgBrush);
  var
    s, v, v1, v2: AnsiString;
    c: longint;
    o: TvgObject;
  begin
    if Length(str) = 0 then Exit;

    if Pos('rgb', LowerCase(str)) > 0 then
    begin
      s := str;
      vgGetToken(str, '(');
      v := vgGetToken(str, ',');
      v1 := vgGetToken(str, ',');
      v2 := vgGetToken(str, ')');
      Fill.Style := vgBrushSolid;
      try
        Fill.Color := vgColorToStr(RGB(StrToInt(v2), StrToInt(v1), StrToInt(v)) or $FF000000);
      except
        Fill.Color := vgColorToStr($FFFFFF or $FF000000);
      end;
    end
    else
    if Pos('url', LowerCase(str)) > 0 then
    begin
      vgGetToken(str, '#');
      v := vgGetToken(str, ')');
      o := FindResource(v);
      Fill.Style := vgBrushResource;
      if o is TvgBrushObject then
        Fill.Resource.Resource := TvgBrushObject(o);
    end
    else
    if LowerCase(str) = 'none' then
      Fill.Style := vgBrushNone
    else
    if not (Pos(Str[1], '#0123456789') > 0) then
    begin
      Fill.Style := vgBrushSolid;
      if IdentToColor('cl' + Str, c) then
        Fill.Color := vgColorToStr(FromRGB(c) or $FF000000);
    end
    else
    if Length(str) = 4 then
    begin
      Fill.Color := vgColorToStr(vgStr4ToColor(str) or $FF000000);
    end
    else
    begin
      Fill.Style := vgBrushSolid;
      Fill.Color := vgColorToStr(vgStrToColor(str) or $FF000000);
    end;
  end;

  procedure parseStyle(Parent: TvgVisualObject; var Node: TdomNode; var Fill, Stroke: TvgBrush; var StrokeThickness: single);
  var
    Attr: TdomNode;
    v, v1, v2, s, style: AnsiString;
  begin
    Attr := Node.attributes.getNamedItem('fill');
    if (Attr <> nil) then
    begin
      s := Attr.NodeValue;
      parseColor(s, Fill);
    end;
    Attr := Node.attributes.getNamedItem('stroke');
    if (Attr <> nil) then
    begin
      s := Attr.NodeValue;
      parseColor(s, Stroke);
    end;
    Attr := Node.attributes.getNamedItem('fill-opacity');
    if (Attr <> nil) then
    begin
      s := Attr.NodeValue;
      Stroke.Color := vgColorToStr(Stroke.SolidColor and $FFFFFF or (trunc(vgStrToFloat(s) * $FF) shl 24));
    end;
    Attr := Node.attributes.getNamedItem('stroke-opacity');
    if (Attr <> nil) then
    begin
      s := Attr.NodeValue;
      Stroke.Color := vgColorToStr(Stroke.SolidColor and $FFFFFF or (trunc(vgStrToFloat(s) * $FF) shl 24));
    end;
    Attr := Node.attributes.getNamedItem('stroke-width');
    if (Attr <> nil) then
    begin
      s := Attr.NodeValue;
      v := vgGetToken(s, 'abcdefjhiklmnopqrtsuvwxyz,');
      StrokeThickness := vgStrToFloat(v);
    end;
    Attr := Node.attributes.getNamedItem('style');
    if (Attr <> nil) then
    begin
      style := Attr.NodeValue;
      while style <> '' do
      begin
        s := vgGetToken(style, ';');
        v := vgGetToken(s, ':');
        if LowerCase(v) = 'fill' then
        begin
          parseColor(s, Fill);
        end;
        if LowerCase(v) = 'fill-opacity' then
        begin
          Fill.Color := vgColorToStr(Fill.SolidColor and $FFFFFF or (trunc(vgStrToFloat(s) * $FF) shl 24));
        end;
        if LowerCase(v) = 'stroke' then
        begin
          parseColor(s, Stroke);
        end;
        if LowerCase(v) = 'stroke-opacity' then
        begin
          Stroke.Color := vgColorToStr(Stroke.SolidColor and $FFFFFF or (trunc(vgStrToFloat(s) * $FF) shl 24));
        end;
        if LowerCase(v) = 'stroke-width' then
        begin
          v := vgGetToken(s, 'abcdefjhiklmnopqrtsuvwxyz');
          StrokeThickness := vgStrToFloat(v);
        end;
      end;
    end;
    // apply
    if Parent is TvgShape then
    begin
      TvgShape(Parent).Fill.Assign(Fill);
      TvgShape(Parent).Stroke.Assign(Stroke);
      TvgShape(Parent).StrokeThickness := StrokeThickness;
    end;
  end;

  procedure parseGradient(Gradient: TvgGradient; Node: TdomNode);
  var
    Children: TdomNodeList;
    CName: string;
    style, v, S: AnsiString;
    Attr: TdomNode;
    i: integer;
    P: TvgGradientPoint;
  begin
    // children
    Children := Node.childNodes;
    Gradient.Points.Clear;
    Gradient.StopPosition.Point := vgPoint(1, 0);

    for i := 0 to Children.length - 1 do
    begin
      if (Byte(Children.Item(I).nodeType) = 1) then
      begin
        CName := Children.Item(I).nodeName;
        if LowerCase(CName) = 'stop' then
        begin
          P := TvgGradientPoint(Gradient.Points.Add);
          Attr := Children.Item(I).attributes.getNamedItem('offset');
          if Attr <> nil then
          begin
            s := Attr.nodeValue;
            if Pos('%', s) > 0 then
              P.Offset := vgStrToFloat(vgGetToken(s, '%')) / 100
            else
              P.Offset := vgStrToFloat(s);
          end;
          Attr := Children.Item(I).attributes.getNamedItem('stop-color');
          if Attr <> nil then
            P.Color := vgColorToStr(parseColorToInt(Attr.nodeValue));
          Attr := Children.Item(I).attributes.getNamedItem('style');
          if Attr <> nil then
          begin
            style := Attr.nodeValue;
            while style <> '' do
            begin
              s := vgGetToken(style, ';');
              v := vgGetToken(s, ':');
              if LowerCase(v) = 'stop-color' then
              begin
                P.Color := vgColorToStr(parseColorToInt(s));
              end;
              if LowerCase(v) = 'stop-opacity' then
              begin
                P.Color := vgColorToStr(vgStrToColor(P.Color) and $FFFFFF or (trunc(vgStrToFloat(s) * $FF) shl 24));
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  procedure processDefs(Parent: TvgVisualObject; var Node: TdomNode);
  var
    Children: TdomNodeList;
    CName: string;
    S: AnsiString;
    Brush: TvgBrushObject;
    Attr: TdomNode;
    i: integer;
  begin
    Children := Node.childNodes;
    if Children = nil then Exit;
    // children
    for i := 0 to Children.length - 1 do
    begin
      if (Byte(Children.Item(I).nodeType) = 1) then
      begin
        CName := Children.Item(I).nodeName;
        if LowerCase(CName) = 'lineargradient' then
        begin
          Brush := TvgBrushObject.Create(Self);
          Brush.Parent := Parent;
          Attr := Children.Item(I).attributes.getNamedItem('id');
          if Attr <> nil then
            Brush.ResourceName := Attr.nodeValue;
          Brush.Brush.Style := vgBrushGradient;
          Attr := Children.Item(I).attributes.getNamedItem('xlink:href');
          if Attr <> nil then
          begin
            // assign
            s := Attr.nodeValue;
            Delete(s, 1, 1);
            if (FindResource(s) <> nil) and (FindResource(s) is TvgBrushObject) then
              Brush.Brush.Assign(TvgBrushObject(FindResource(s)).Brush);
          end
          else
            parseGradient(Brush.Brush.Gradient, Children.Item(i));
        end;
      end;
    end;
  end;

  procedure processChild(Parent: TvgVisualObject; var Node: TdomNode; var Matrix: TvgMatrix; var Fill, Stroke: TvgBrush; var StrokeThickness: single);
  var
    Children: TdomNodeList;
    CName: string;
    S, tok: AnsiString;
    Cur: TvgVisualObject;
    CurNode: TdomNode;
    Attr: TdomNode;
    i: integer;
    SaveFill, SaveStroke: TvgBrush;
    SaveStrokeThickness: single;
    R: TvgRect;
    SaveMatrix, M: TvgMatrix;
  begin
    Children := Node.childNodes;
    if Children = nil then Exit;
    // case object
    CName := Node.nodeName;

    // transform
    M := vgMatrixMultiply(parseTransform(Node), Matrix);
    // object
    if LowerCase(CName) = 'svg' then
    begin
      Cur := Parent;
    end
    else
    if LowerCase(CName) = 'defs' then
    begin
      processDefs(Parent, Node);
      Exit;
    end
    else
    if LowerCase(CName) = 'path' then
    begin
      // path
      Cur := TvgPath.Create(Self);
      Cur.Parent := Parent;
      Cur.HitTest := false;
      Cur.Locked := true;
      with TvgPath(Cur) do
      begin
        WrapMode := vgPathStretch;
        Attr := Node.attributes.getNamedItem('d');
        if Attr <> nil then
        begin
          Data.Data := Attr.NodeValue;
          Data.ApplyMatrix(M);
          R := Data.GetBounds;
          Data.Offset(-R.Left, -R.Top);
          Position.X := R.Left;
          Position.Y := R.Top;
          SetSizeWithoutChange(vgRectWidth(R), vgRectHeight(R));
        end;
      end;
    end
    else
    if LowerCase(CName) = 'polygon' then
    begin
      // polygon
      Cur := TvgPath.Create(Self);
      Cur.Parent := Parent;
      Cur.HitTest := false;
      Cur.Locked := true;
      with TvgPath(Cur) do
      begin
        WrapMode := vgPathStretch;
        Attr := Node.attributes.getNamedItem('points');
        if Attr <> nil then
        begin
          S := trim(Attr.NodeValue);
          tok := vgGetToken(S, ' ');
          Data.MoveTo(vgPoint(vgStrToFloat(vgGetToken(tok, ', ')), vgStrToFloat(vgGetToken(tok, ', '))));
          tok := vgGetToken(S, ' ');
          while S <> '' do
          begin
            Data.LineTo(vgPoint(vgStrToFloat(vgGetToken(tok, ', ')), vgStrToFloat(vgGetToken(tok, ', '))));
            tok := vgGetToken(S, ' ');
          end;
          R := Data.GetBounds;
          Data.Offset(-R.Left, -R.Top);
          Position.X := R.Left;
          Position.Y := R.Top;
          SetSizeWithoutChange(vgRectWidth(R), vgRectHeight(R));
        end;
      end;
    end
    else
    if LowerCase(CName) = 'rect' then
    begin
      // path
      Cur := TvgRectangle.Create(Self);
      Cur.Parent := Parent;
      Cur.HitTest := false;
      Cur.Locked := true;
      Attr := Node.attributes.getNamedItem('x');
      if Attr <> nil then
        Cur.Position.X := vgStrToFloat(Attr.nodeValue);
      Attr := Node.attributes.getNamedItem('y');
      if Attr <> nil then
        Cur.Position.Y := vgStrToFloat(Attr.nodeValue);
      Attr := Node.attributes.getNamedItem('width');
      if Attr <> nil then
        Cur.Width := vgStrToFloat(Attr.nodeValue);
      Attr := Node.attributes.getNamedItem('height');
      if Attr <> nil then
        Cur.Height := vgStrToFloat(Attr.nodeValue);
    end
    else
    if LowerCase(CName) = 'text' then
    begin
      // path
      Cur := TvgText.Create(Self);
      Cur.Parent := Parent;
      Cur.HitTest := false;
      Cur.Locked := true;
      TvgText(Cur).WordWrap := false;
      TvgText(Cur).HorzTextAlign := vgTextAlignNear;
      TvgText(Cur).VertTextAlign := vgTextAlignNear;
      Attr := Node.attributes.getNamedItem('x');
      if Attr <> nil then
        Cur.Position.X := vgStrToFloat(Attr.nodeValue);
      Attr := Node.attributes.getNamedItem('y');
      if Attr <> nil then
        Cur.Position.Y := vgStrToFloat(Attr.nodeValue);
      Attr := Node.attributes.getNamedItem('font-size');
      if Attr <> nil then
        TvgText(Cur).Font.Size := vgStrToFloat(Attr.nodeValue);
      Attr := Node.attributes.getNamedItem('font-family');
      if Attr <> nil then
        TvgText(Cur).Font.Family := Attr.nodeValue;
      TvgText(Cur).Text := Node.textContent;
      TvgText(Cur).AutoSize := true;
      Cur.Position.Y := Cur.Position.Y - Cur.Height;
    end
    else
    if LowerCase(CName) = 'line' then
    begin
      // line
      Cur := TvgLine.Create(Self);
      Cur.Parent := Parent;
      Cur.HitTest := false;
      Cur.Locked := true;
      Attr := Node.attributes.getNamedItem('x1');
      if Attr <> nil then
        Cur.Position.X := vgStrToFloat(Attr.nodeValue);
      Attr := Node.attributes.getNamedItem('y1');
      if Attr <> nil then
        Cur.Position.Y := vgStrToFloat(Attr.nodeValue);
      Attr := Node.attributes.getNamedItem('x2');
      if Attr <> nil then
        Cur.Width := vgStrToFloat(Attr.nodeValue) - Cur.Position.X;
      Attr := Node.attributes.getNamedItem('y2');
      if Attr <> nil then
        Cur.Height := vgStrToFloat(Attr.nodeValue) - Cur.Position.Y;
    end
    else
    begin
      // default
      Cur := TvgLayout.Create(Self);
      Cur.Parent := Parent;
      Cur.HitTest := false;
      Cur.Locked := true;
    end;
    // correct size
    with Cur.AbsoluteRect do
    begin
      if Right > W then W := Right;
      if Bottom > H then H := Bottom;
    end;
    // set name
    Attr := Node.attributes.getNamedItem('id');
    if Attr <> nil then
      Cur.BindingName := Attr.nodeValue;
    // style
    parseStyle(Cur, Node, Fill, Stroke, StrokeThickness);
    // children
    for i := 0 to Children.length - 1 do
    begin
      if (Byte(Children.Item(I).nodeType) = 1) then
      begin
        SaveFill := TvgBrush.Create(vgBrushSolid, $FFFFFFFF);
        SaveStroke := TvgBrush.Create(vgBrushNone, $FF000000);
        SaveStrokeThickness := 1;
        SaveFill.Assign(Fill);
        SaveStroke.Assign(Stroke);
        SaveStrokeThickness := StrokeThickness;
        SaveMatrix := M;
        CurNode := Children.Item(I);
        processChild(Cur, Curnode, M, Fill, Stroke, StrokeThickness);
        M := SaveMatrix;
        Fill.Assign(SaveFill);
        Stroke.Assign(SaveStroke);
        StrokeThickness := SaveStrokeThickness;
        SaveStroke.Free;
        SaveFill.Free;
      end;
    end;
  end;
var
  Node: TdomNode;
  Attr: TdomNode;
  Fill, Stroke: TvgBrush;
  StrokeThickness: single;
  M: TvgMatrix;
begin
  if FSvg = nil then Exit;

  Node := FSvg.documentElement;
  if not Assigned(Node) then Exit;

  Fill := TvgBrush.Create(vgBrushSolid, $FFE0E0E0);
  Fill.SolidColor := $FF000000;
  Stroke := TvgBrush.Create(vgBrushSolid, $FF000000);
  Stroke.SolidColor := $FF000000;
  StrokeThickness := 1;
  M := IdentityMatrix;
  W := 1; H := 1;

  SVG.Align := vaNone;

  SVG.DeleteChildren;
  SVG.DisableAlign;
  SVG.SetSizeWithoutChange(1, 1);
  SVG.OriginalWidth := 1;
  SVG.OriginalHeight := 1;
  processChild(SVG, Node, M, Fill, Stroke, StrokeThickness);
  with SVG.AbsoluteToLocal(vgPoint(W, H)) do
  begin
    SVG.SetSizeWithoutChange(x * 1, y * 1);
    SVG.OriginalWidth := x;
    SVG.OriginalHeight := y;
  end;
  SVG.EnableAlign;

  SVG.Align := vaFit;

  Stroke.Free;
  Fill.Free;
end;

end.
