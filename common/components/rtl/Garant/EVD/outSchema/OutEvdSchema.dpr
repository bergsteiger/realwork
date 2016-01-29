program OutEvdSchema;

{$AppType Console}

uses
  TypInfo,
  
  SysUtils,
  StrUtils,

  Graphics,

  l3Variant,
  l3Chars,
  l3Const,
  l3Types,
  l3Base,
  l3Filer,
  l3KeyWrd,
  l3String,

  k2Interfaces,
  k2Base,
  k2Facade,
  k2Tags,
  k2Const,

  evdSchema,
  evdTypes,

  evTypes,
  evdConst,
  evdStyles,

  LeafPara_Const,
  ParaList_Const,
  Para_Const,
  TextPara_Const,
  StyledLeafPara_Const,
  Style_Const,
  ControlPara_Const,

  evStyleInterface
  ;

procedure DoOut;
const
 c_TypeID = 'TypeID';
 c_DefChild = 'DEF_CHILD';
 c_BaseChild = 'BASE_CHILD';
 c_AttrType = 'ATTR_TYPE';
 c_AttrDefaultValue = 'ATTR_DEFAULT_VALUE';
 c_AttrChild = 'DEF_ATTR_CHILD';
 c_Inherits = 'INHERITS';
 c_Enum = 'enum %s {';
 c_EnumItem = '%s // %d';
 c_EnumEnd = '}; // %s';
var
 l_Out   : Tl3DOSFiler;
 l_Table : Tk2TypeTable;
 l_First : Boolean;

 procedure Put(const aString: String = '');
   overload;
 begin//Put
  l_Out.WriteLn(aString);
 end;//Put

 procedure Put(const aString: String; const Params: array of const);
   overload;
 begin
  Put(Format(aString, Params));
 end;

 procedure PutComma;
 begin//PutComma
  if l_First then
  begin
   l_First := false;
   l_Out.Write('  ');
  end//l_First
  else
   l_Out.Write(', ');
 end;//PutComma

 procedure PutOR;
 begin//PutOR
  if l_First then
  begin
   l_First := false;
   l_Out.Write('     ');
  end//l_First
  else
   l_Out.Write('   ||');
 end;//PutOR

 function mEnum(const aType       : String;
                const aFrom       : String = '';
                const aTo         : String = ''): String; overload;
 begin//mEnum
  Result := AnsiReplaceStr(aType, aFrom, aTo);
 end;//mEnum

 function mEnum(i : Integer;
                aType       : PTypeInfo;
                const aFrom       : String = '';
                const aTo         : String = ''): String; overload;
 begin//mEnum
  Result := mEnum(GetEnumName(aType, i), aFrom, aTo);
 end;//mEnum

 function mTypeX(i : Integer): String;
 var
  l_Type : Tk2Type;
 begin//mTypeX
  l_Type := l_Table.TypeByHandle[i];
  if (l_Type = nil) then
  begin
   Result := 'Empty';
   if (i > 0) then
    Result := Result + IntToStr(i);
  end//l_Type = nil
  else
  begin
   Result := l_Type.AsString;
   Assert(Result <> '');
  end;//l_Type = nil
 end;//mTypeX

 function mType(i : Integer): String;
 begin//mType
  Result := 'id_' + mTypeX(i);
 end;//mType

 function mTagX(i : Integer): String;
 begin//mTagX
  Result := mEnum(Ord(i), TypeInfo(Tk2TagID), '_k2_ti', '');
 end;//mTagX

 procedure PutEnum(const aName : String;
                   aType       : PTypeInfo;
                   aComment    : String;
                   aFrom       : String = '';
                   aTo         : String = '');
 var
  i      : Integer;
  l_TD   : PTypeData;
  l_Name : String;
 begin//PutEnum
  Put('// %s:', [aComment]);
  l_TD := GetTypeData(aType);
  if (aName = '') then
   l_Name := aType.Name
  else
   l_Name := aName;
  l_First := true;
  Put(c_Enum, [l_Name]);
  for i := l_TD.MinValue to l_TD.MaxValue do
  begin
   PutComma;
   Put(c_EnumItem, [mEnum(i, aType, aFrom, aTo), i]);
  end;//for i
  Put(c_EnumEnd, [l_Name]);
  Put;
 end;//PutEnum

 procedure PutVect(const aName : String;
                   aType       : PTypeInfo;
                   aComment    : String;
                   aFrom       : String = '';
                   aTo         : String = '');
 var
  i      : Integer;
  l_TD   : PTypeData;
  l_Name : String;
 begin//PutVect
  Put('// %s:', [aComment]);
  l_TD := GetTypeData(aType);
  if (aName = '') then
   l_Name := aType.Name
  else
   l_Name := aName;
  l_First := true;
  Put('const %s %s[] = {', ['char*', l_Name]);
  for i := l_TD.MinValue to l_TD.MaxValue do
  begin
   PutComma;
   Put('"%s"', [mEnum(i, aType, aFrom, aTo)]);
  end;//for i
  PutComma;
  Put('0');
  Put(c_EnumEnd, [l_Name]);
  Put;
 end;//PutVect

 procedure PutTypeVect(const aName : String;
                       const aComment : String);
 var
  i      : Integer;
 begin//PutVect
  Put('// %s:', [aComment]);
  l_First := true;
  Put('const %s %s[] = {', ['char*', aName]);
  for i := 0 to l_Table.MaxTypeID do
  begin
   PutComma;
   Put('"%s"', [mTypeX(i)]);
  end;//for i
  PutComma;
  Put('0');
  Put(c_EnumEnd, [aName]);
  Put;
 end;//PutVect

 procedure PutTypes;
 var
  i      : Integer;
  l_Type : Tk2Type;
  l_Name : String;
 begin//PutTypes
  Put('// идентификаторы типов:');
  Put(c_Enum, [c_TypeID]);
  l_First := true;
  for i := 0 to l_Table.MaxTypeID do
  begin
   PutComma;
   l_Type := l_Table.TypeByHandle[i];
   if (l_Type = nil) then
    l_Name := 'зарезервированно'
   else
    l_Name := l_Type.AsString{DisplayName};
   Put('%s // %s %d', [mType(i), l_Name, Ord(i)]);
  end;//for i
  Put(c_EnumEnd, [c_TypeID]);
  Put;
 end;//PutTypes

 procedure PutDefaultChildren;

  procedure PutEmpty(const aType: String; i: Integer);
  begin//PutEmpty
   Put('%s // %s %d -> no default %d', [mType(0), aType, i, 0]);
  end;//PutEmpty

 var
  i       : Integer;
  l_Type  : Tk2Type;
  l_CT    : Tk2Type;
  l_Prop  : Tk2ArrayProperty;
 begin//PutDefaultChildren
  Put('// таблица соответствия типа ноды и ее дочерних нод по умолчанию:');
  Put;
  Put('const %s %s[] = {', [c_TypeID, c_DefChild]);
  l_First := true;
  for i := 0 to l_Table.MaxTypeID do
  begin
   PutComma;
   l_Type := l_Table.TypeByHandle[Ord(i)];
   if (l_Type = nil) then
    PutEmpty(mType(i), Ord(i))
   else
   begin
    l_Prop := l_Type.ArrayProp[k2_tiChildren];
    if (l_Prop = nil) OR (l_Prop.DefaultChildType = nil) then
     PutEmpty(l_Type.AsString, Ord(i))
    else
    begin
     l_CT := l_Prop.DefaultChildType;
     Put('%s // %s %d -> %s %d', [mType(l_CT.ID), l_Type.AsString, Ord(i), l_CT.AsString, l_CT.ID]);
    end;//l_Prop = nil..
   end;//l_Type = nil
  end;//for i
  Put(c_EnumEnd, [c_DefChild]);
  Put;
 end;//PutDefaultChildren

 procedure PutInherrits;

  procedure PutEmpty(const aType1, aType2: String);
  begin//PutEmpty
   Put('%s // %s -> %s', ['false', aType1, aType2]);
  end;//PutEmpty

 var
  i   : Integer;
  j   : Integer;
  l_A : Tk2Type;
 begin//PutInherrits
  Put('// таблица отношения наследования типов тегов:');
  Put;
  Put('const %s %s[%d][%d] = {', ['bool', c_Inherits, l_Table.MaxTypeID+1, l_Table.MaxTypeID+1]);
  l_First := true;
  for i := 0 to l_Table.MaxTypeID do
  begin
   PutComma;
   Put('{');
   l_First := true;
   l_A := l_Table.TypeByHandle[Ord(i)];
   for j := 0 to l_Table.MaxTypeID do
   begin
    PutComma;
    if (l_A = nil) then
     PutEmpty(mType(i), mType(j))
    else
    begin
     if l_A.IsKindOf(l_Table.TypeByHandle[Ord(j)]) then
      Put('%s // %s -> %s', ['true', mType(i), mType(j)])
     else
      Put('%s // %s -> %s', ['false', mType(i), mType(j)]);
    end;//l_A = nil
   end;//for j
   Put('}');
  end;//for i
  Put(c_EnumEnd, [c_Inherits]);
  Put;
 end;//PutInherrits

 procedure PutBaseChildren;

  procedure PutEmpty(const aType: String; i: Integer);
  begin//PutEmpty
   Put('%s // %s %d -> no children %d', [mType(0), aType, i, 0]);
  end;//PutEmpty

 var
  i       : Integer;
  l_Type  : Tk2Type;
  l_CT    : Tk2Type;
  l_Prop  : Tk2ArrayProperty;
 begin//PutBaseChildren
  Put('// таблица соответствия типа ноды и ее базовых дочерних нод:');
  Put;
  Put('const %s %s[] = {', [c_TypeID, c_BaseChild]);
  l_First := true;
  for i := 0 to l_Table.MaxTypeID do
  begin
   PutComma;
   l_Type := l_Table.TypeByHandle[Ord(i)];
   if (l_Type = nil) then
    PutEmpty(mType(i), Ord(i))
   else
   begin
    l_Prop := l_Type.ArrayProp[k2_tiChildren];
    if (l_Prop = nil) OR (l_Prop.ChildType = nil) then
     PutEmpty(l_Type.AsString, Ord(i))
    else
    begin
     l_CT := l_Prop.ChildType;
     Put('%s // %s %d -> %s %d', [mType(l_CT.ID), l_Type.AsString, Ord(i), l_CT.AsString, l_CT.ID]);
    end;//l_Prop = nil..
   end;//l_Type = nil
  end;//for i
  Put(c_EnumEnd, [c_BaseChild]);
  Put;
 end;//PutBaseChildren

 procedure PutAttrTypes;

  procedure PutEmpty(const aType: String; i: Integer; j: Integer);
  begin//PutEmpty
   Put('%s // %s %d -> no attr %s %d', [mType(0), aType, i, mTagX(j), Ord(j)]);
  end;//PutEmpty

 var
  i       : Integer;
  j       : Tk2TagID;
  l_Type  : Tk2Type;
  l_Prop  : Tk2Prop;
 begin//PutAttrTypes
  Put('// таблица соответствия ноды и типов ее атрибутов:');
  Put;
  Put('const %s %s[%d][%d] = {', [c_TypeID, c_AttrType, l_Table.MaxTypeID+1, Ord(High(Tk2TagID))+1]);
  l_First := true;
  for i := 0 to l_Table.MaxTypeID do
  begin
   PutComma;
   Put('{');
   l_First := true;
   l_Type := l_Table.TypeByHandle[Ord(i)];
   if (l_Type = nil) then
   begin
    for j := Low(Tk2TagID) to High(Tk2TagID) do
    begin
     PutComma;
     PutEmpty(mTypeX(i), Ord(i), Ord(j));
    end;//for j 
   end//l_Type = nil
   else
   begin
    for j := Low(Tk2TagID) to High(Tk2TagID) do
    begin
     PutComma;
     l_Prop := Tk2Prop(l_Type.Prop[Ord(j)]);
     if (l_Prop = nil) then
      PutEmpty(mTypeX(i), Ord(i), Ord(j))
     else
      Put('%s // %s %d -> %s %d', [mType(l_Prop.AtomType.ID), l_Type.AsString, Ord(i), l_Prop.AsString, l_Prop.TagIndex]);
    end;//for j
   end;//l_Type = nil
   Put('}');
  end;//for i
  Put(c_EnumEnd, [c_AttrType]);
  Put;
 end;//PutAttrTypes

 procedure PutAttrDefaultValues;

 const
  c_EmptyValue = 'EmptyValue';
  c_TransparentValue = 'TransparentValue';

  procedure PutEmpty(const aType: String; i: Integer; j: Integer);
  begin//PutEmpty
   Put('%s // %s %d -> no attr %s %d', [c_EmptyValue, aType, i, mTagX(j), Ord(j)]);
  end;//PutEmpty

  function PropValueName(aProp : Tk2Prop): String;
  begin//PropValueName
   Result := '';
   if (aProp <> nil) then
   begin
    if (aProp.DefaultValue <> k2_TransparentValue) AND
       (aProp.DefaultValue <> l3NilLong) then
    begin
     try
      Result := Tk2Type(aProp.TagType).IntToTag(aProp.DefaultValue).AsObject.AsString;
     except
     end;//try..except
    end;//aProp.DefaultValue <> k2_TransparentValue
    if (Result <> '') then
    begin
     if (Result[1] in cc_Digits + [cc_Minus, cc_DollarSign]) then
      Result := ''
     else
     if l3CharSetPresent(PChar(Result), Length(Result), cc_ANSIRussian) then
      Result := ''
    end;//Result <> ''
   end;//aProp <> nil
  end;//PropValueName

 var
  i       : Integer;
  j       : Tk2TagID;
  k       : Integer;
  l_Type  : Tk2Type;
  l_Prop  : Tk2Prop;
  l_KW    : Tl3KeyWords;
  l_Name  : String;
  l_Index : Integer;
 begin//PutAttrDefaultValues
  Put('const long %s = %d; // - значение не задано', [c_EmptyValue, l3NilLong]);
  Put('const long %s = %d; // - тег имеет "прозрачное" значение', [c_TransparentValue, k2_TransparentValue]);
  Put;

  l_KW := Tl3KeyWords.Create;
  try
   l_KW.Duplicates := l3_dupIgnore;
   for i := 0 to l_Table.MaxTypeID do
   begin
    l_Type := l_Table.TypeByHandle[i];
    if (l_Type <> nil) then
    begin
     for j := Low(Tk2TagID) to High(Tk2TagID) do
     begin
      l_Prop := Tk2Prop(l_Type.Prop[Ord(j)]);
      l_Name := PropValueName(l_Prop);
      if (l_Name <> '') then
       l_KW.AddKeyWord(l_Name, l_Prop.DefaultValue);
     end;//for j
    end;//l_Type <> nil
   end;//for i

   for k := 0 to l_KW.Count - 1 do
    Put('const long %s = %d;', [l_KW[k].AsString, l_KW[k].StringID]);

   Put; 

   Put('// таблица соответствия ноды и значений по-умолчанию ее атрибутов:');
   Put;
   Put('const %s %s[%d][%d] = {', ['long', c_AttrDefaultValue, l_Table.MaxTypeID+1, Ord(High(Tk2TagID))+1]);
   l_First := true;
   for i := 0 to l_Table.MaxTypeID do
   begin
    PutComma;
    Put('{');
    l_First := true;
    l_Type := l_Table.TypeByHandle[Ord(i)];
    if (l_Type = nil) then
    begin
     for j := Low(Tk2TagID) to High(Tk2TagID) do
     begin
      PutComma;
      PutEmpty(mTypeX(i), Ord(i), Ord(j));
     end;//for j
    end//l_Type = nil
    else
    begin
     for j := Low(Tk2TagID) to High(Tk2TagID) do
     begin
      PutComma;
      l_Prop := Tk2Prop(l_Type.Prop[Ord(j)]);
      if (l_Prop = nil) then
       PutEmpty(mTypeX(i), Ord(i), Ord(j))
      else
      if (l_Prop.DefaultValue = k2_TransparentValue) then
       Put('%s // %s %d -> %s %d', [c_TransparentValue, l_Type.AsString, Ord(i), l_Prop.AsString, l_Prop.TagIndex])
      else
      if (l_Prop.DefaultValue = l3NilLong) then
      begin
       if l_Table.TypeByHandle[Ord(i)].IsKindOf(k2_typLeafPara) AND
          l_Prop.AtomType.IsKindOf(k2_typStyle) then
          // http://mdp.garant.ru/pages/viewpage.action?pageId=289276029&focusedCommentId=290954895#comment-290954895
        Put('%d // %s %d -> %s %d', [-1, l_Type.AsString, Ord(i), l_Prop.AsString, l_Prop.TagIndex])
       else
        Put('%s // %s %d -> %s %d', [c_EmptyValue, l_Type.AsString, Ord(i), l_Prop.AsString, l_Prop.TagIndex]);
      end//l_Prop.DefaultValue = l3NilLong
      else
      begin
       l_Name := PropValueName(l_Prop);
       if (l_Name <> '') AND
          l_KW.FindData(l_Name, l_Index) AND
          (l_KW[l_Index].StringID = l_Prop.DefaultValue) then
        Put('%s // %s %d -> %s %d', [l_Name, l_Type.AsString, Ord(i), l_Prop.AsString, l_Prop.TagIndex])
       else
        Put('%d // %s %d -> %s %d', [l_Prop.DefaultValue, l_Type.AsString, Ord(i), l_Prop.AsString, l_Prop.TagIndex]);
      end;//l_Prop.DefaultValue = l3NilLong
     end;//for j
    end;//l_Type = nil
    Put('}');
   end;//for i
   Put(c_EnumEnd, [c_AttrDefaultValue]);
   Put;
  finally
   FreeAndNil(l_KW);
  end;//try..finally
 end;//PutAttrDefaultValues

 procedure PutAttrChilds;

  procedure PutEmpty(const aType: String; i: Integer; j: Integer);
  begin//PutEmpty
   Put('%s // %s %d -> no attr %s %d', [mType(0), aType, i, mTagX(j), Ord(j)]);
  end;//PutEmpty

 var
  i       : Integer;
  j       : Tk2TagID;
  l_Type  : Tk2Type;
  l_Prop  : Tk2Prop;
  l_CProp : Tk2ArrayProperty;
 begin//PutAttrChilds
  Put('// таблица соответствия ноды и типов детей ее атрибутов:');
  Put;
  Put('const %s %s[%d][%d] = {', [c_TypeID, c_AttrChild, l_Table.MaxTypeID+1, Ord(High(Tk2TagID))+1]);
  l_First := true;
  for i := 0 to l_Table.MaxTypeID do
  begin
   PutComma;
   Put('{');
   l_First := true;
   l_Type := l_Table.TypeByHandle[Ord(i)];
   if (l_Type = nil) then
   begin
    for j := Low(Tk2TagID) to High(Tk2TagID) do
    begin
     PutComma;
     PutEmpty(mTypeX(i), Ord(i), Ord(j));
    end;//for j 
   end//l_Type = nil
   else
   begin
    for j := Low(Tk2TagID) to High(Tk2TagID) do
    begin
     PutComma;
     l_Prop := Tk2Prop(l_Type.Prop[Ord(j)]);
     if (l_Prop = nil) then
      PutEmpty(mTypeX(i), Ord(i), Ord(j))
     else
     begin
      l_CProp := Tk2Type(l_Prop.AtomType).ArrayProp[k2_tiChildren];
      if (l_CProp = nil) then
       PutEmpty(mTypeX(i), Ord(i), Ord(j))
      else
       Put('%s // %s %d -> %s %d', [mType(l_CProp.ChildType.ID), l_Type.AsString, Ord(i), l_Prop.AsString, l_Prop.TagIndex]);
     end;//l_Prop = nil
    end;//for j
   end;//l_Type = nil
   Put('}');
  end;//for i
  Put(c_EnumEnd, [c_AttrChild]);
  Put;
 end;//PutAttrChilds

 procedure PutIsType(const aName: String; aType: Tk2Type; aComment: String);
 var
(*  i       : Integer;
  l_Type  : Ik2Type;*)
  l_Name  : String;
 begin//PutIsType
  l_Name := 'is_' + aName;
  Put('inline bool %s (int type) {', [l_Name]);
  Put('// %s', [aComment]);
  Put(' return %s[%s][%s];', [c_Inherits, 'type', mType(aType.ID)]);
(*  Put(' if (');
  l_First := true;
  for i := 0 to l_Table.MaxTypeID do
  begin
   l_Type := l_Table[Ord(i)];
   if (l_Type <> nil) AND l_Type.InheritsFrom(aType) then
   begin
    PutOR;
    Put(' %s == type', [mType(i)]);
   end;//l_Type <> nil
  end;//for i
  Put(' ) {');
  Put('     return true;');
  Put(' }');
  Put(' return false;');*)
  Put('} // %s', [l_Name]);
  Put;
 end;//PutIsType;

 procedure WriteAttrs;
 var
  l_T : Tk2TagID;
 begin//WriteAttrs
  Put('// Идентификаторы атрибутов');
  Put;
  for l_T := Low(l_T) to High(l_T) do
   Put('CONST evd::ti_%s %d', [mTagX(Ord(l_T)), Ord(l_T)]);
 end;//WriteAttrs

 procedure WriteTypes;
 var
  l_T : Integer;
 begin//WriteTypes
  Put('// Идентификаторы типов');
  Put;
  for l_T := 0 to l_Table.MaxTypeID do
   Put('CONST evd::%s %d', [mType(l_T), l_T]);
 end;//WriteTypes

 procedure WriteStyles;
 
  function OutStyle(aStyle: Pl3Variant; Index: Long): Bool;
  var
   l_Tag : Tl3Tag;
   l_H   : Integer;
  begin//OutStyle
   Result := true;
   l_Tag := aStyle^;
   l_H := -l_Tag.IntA[k2_tiHandle];
   if (l_H >= Low(StandardNames)) AND (l_H <= High(StandardNames)) then
   begin
    Put('CONST evd::sa_%s %d', [StandardNames[l_H], -l_H]);
    Put('// %s', [l_Tag.StrA[k2_tiName]]);
   end;//l_H >= Low(StandardNames)
  end;//OutStyle

  function OutStyle1(aStyle: Pl3Variant; Index: Long): Bool;
  var
   l_Tag : Tl3Tag;
   l_H   : Integer;
  begin//OutStyle1
   Result := true;
   l_Tag := astyle^;
   l_H := l_Tag.IntA[k2_tiHandle];
   Put('CONST evd::стиль:"%s" %d', [l_Tag.StrA[k2_tiName], l_H]);
  end;//OutStyle1

 var
  l_SI : TevStyleInterface;
 begin//WriteTypes
  Put('// Идентификаторы стилей');
  Put;
  l_SI := TevStyleInterface.Make;
  try
   l_SI.IterateF(l3L2IA(@OutStyle));
   Put;
   l_SI.IterateF(l3L2IA(@OutStyle1));
  finally
   FreeAndNil(l_SI);
  end;//try..finally
 end;//WriteTypes

 procedure WriteControlParaAttrValues;
 var
  l_CP : Tl3Variant;
  l_CT : TevControlType;
  l_TID : Tk2TagID;
  l_Prop : Tk2CustomProperty;
 begin//WriteControlParaAttrValues
  Put('// Значения предопределённых атрибутов параграфов-контролов');
  Put;
  l_CP := k2_typControlPara.MakeTag.AsObject;
  try
   for l_TID := Low(l_TID) to High(l_TID) do
   begin
    l_Prop := Tk2CustomProperty(Tk2Type(l_CP.TagType).Prop[Ord(l_TID)]);
    if (l_Prop <> nil) then
    begin
     if l_Prop.ReadOnly then
     begin
      l_First := true;
      Put('const long ControlPara_%s_Values [] = {', [l_Prop.AsString]);
      for l_CT := Low(l_CT) to High(l_CT) do
      begin
       PutComma;
       l_CP.IntA[k2_tiType] := Ord(l_CT);
       Put('%s', [l_CP.StrA[Ord(l_TID)]]);
       //Put('%d', [l_CP.IntA[Ord(l_TID)]]);
      end;//for l_CT
      Put(c_EnumEnd, [Format('ControlPara_%s_Values', [l_Prop.AsString])]);
      Put;
     end;//l_Prop
    end;//l_Prop <> nil
   end;//for l_TID
  finally
   l_CP := nil;
  end;//try..finally
 end;//WriteControlParaAttrValues

begin
 l_Out := Tl3DOSFiler.Make('evddata.h', l3_fmWrite, false);
 try
  l_Out.Open;
  try
   l_Table := k2.TypeTable;
   if (l_Table = nil) then
    WriteLn('No tag table defined')
   else
   begin
    Put('#ifndef EVD_H__');
    Put('#define EVD_H__');
    Put;
    Put('// !!! Это автосгенерированный файл. Не добавляйте сюда ничего руками !!!');
    Put;
    Put('// константы для работы с логическим представлением формата evd:');
    Put;
    Put('namespace evd {');
    Put;
    Put('// имена тегов:');
    Put('extern const char* TagName[];');
    Put;
    Put('// имена типов:');
    Put('extern const char* TypeName[];');
    Put;
    //PutVect('TagName', TypeInfo(Tk2TagID), 'имена тегов', '_k2_ti', '');
    PutEnum('TagID', TypeInfo(Tk2TagID), 'Идентификаторы тегов', '_k2_ti', 'ti_');
    PutTypes;
    PutDefaultChildren;
    PutInherrits;
    PutBaseChildren;
    PutAttrTypes;
    PutAttrDefaultValues;
    PutAttrChilds;
    //PutEnum('', TypeInfo(TevIndentType), 'Выравнивание параграфа', 'ev_it', 'jt_');
    //PutEnum('', TypeInfo(TevSubPlace), 'Место отображения метки', 'ev_sp', 'sp_');
    //PutEnum('', TypeInfo(TevVerticalAligment), 'Выравнивание по вертикали', 'ev_val', 'val_');
    Put;
    (*Put('// стили для разметки параграфов:');
    Put;
    Put('const int sa_Empty           = %d; // "Пустое" значение.', [ev_saEmpty]);
    Put('const int sa_TxtNormalANSI   = %d; // Нормальный.', [ev_saTxtNormalANSI]);
    Put('const int sa_TxtNormalOEM    = %d; // Нормальный (OEM).', [ev_saTxtNormalOEM]);
    Put('const int sa_TxtHeader1      = %d; // Заголовок 1.', [ev_saTxtHeader1]);
    Put('const int sa_TxtHeader2      = %d; // Заголовок 2.', [ev_saTxtHeader2]);
    Put('const int sa_TxtHeader3      = %d; // Заголовок 3.', [ev_saTxtHeader3]);
    Put('const int sa_TxtHeader4      = %d; // Заголовок 4.', [ev_saTxtHeader4]);
    Put('const int sa_TxtOutOfDate    = %d; // Утратил силу.', [ev_saTxtOutOfDate]);
    Put('const int sa_HyperLink       = %d; // Гипертекстовая ссылка.', [ev_saHyperLink]);
    Put('const int sa_TxtComment      = %d; // Комментарий.', [ev_saTxtComment]);
    Put('const int sa_ColorSelection  = %d; // Цветовое выделение.', [ev_saColorSelection]);
    Put('const int sa_HyperLinkCont   = %d; // Продолжение ссылки.', [ev_saHyperLinkCont]);
    Put('const int sa_ANSIDOS         = %d; // Моноширинный.', [ev_saANSIDOS]);
    Put('const int sa_FoundWords      = %d; // Найденные слова.', [ev_saFoundWords]);
    Put('const int sa_NormalNote      = %d; // Нормальный (справка).', [ev_saNormalNote]);
    Put('const int sa_ArticleHeader   = %d; // Заголовок статьи.', [ev_saArticleHeader]);
    Put('const int sa_ToLeft          = %d; // Прижатый влево.', [ev_saToLeft]);
    Put('const int sa_NormalTable     = %d; // Нормальный для таблиц.', [ev_saNormalTable]);
    Put('const int sa_NormalSBSLeft   = %d; // Нормальный для левых частей SBS.', [ev_saNormalSBSLeft]);
    Put('const int sa_NormalSBSRight  = %d; // Нормальный для правых частей SBS.', [ev_saNormalSBSRight]);
    Put('const int sa_NormalTableList = %d; // Нормальный для списков в виде таблиц.', [ev_saNormalTableList]);
    Put('const int sa_TechComment     = %d; // Технический комментарий.', [ev_saTechComment]);
    Put('const int sa_VersionInfo     = %d; // Информация о версии.', [ev_saVersionInfo]);
    Put('const int sa_UserComment     = %d; // Комментарий пользователя (для Гаранта 6х).', [ev_saUserComment]);
    Put('const int sa_Contents        = %d; // Оглавление (для Гаранта 6х).', [ev_saContents]);
    Put('const int sa_NotApplied      = %d; // Не вступил в силу.', [ev_saNotApplied]);
    Put('const int sa_DictEntry       = %d; // Словарная статья.', [ev_saDictEntry]);
    Put;*)
    Put('// типы закладок:');
    Put;
    Put('enum BookmarkType {');
    Put('bt_Unknown = -1');
    Put(', bt_Other = 1');
    //Put(', bt_History = 2');
    Put(', bt_Self = 4');
    Put('};');
    Put;
    (*Put('// идентификаторы слоев оформления:');
    Put;
    Put('enum SegmentsLayer {');
    Put('sl_View = %d // %s', [Ord(ev_slView), 'слой оформления']);
    Put(', sl_Hyperlinks = %d // %s', [Ord(ev_slHyperlinks), 'слой гиперссылок']);
    Put(', sl_FoundWords = %d // %s', [Ord(ev_slFoundWords), 'слой слов найденных по контексту']);
    Put(', sl_Found = %d // %s', [Ord(ev_slFound), 'слой найденных слов (зарезервированно)']);
    Put('};');
    Put;*)
    Put('// логическое представление здесь кончается');
    Put;
    Put('// helpers functions');
    Put;
    PutIsType('leaf_para', k2_typLeafPara, 'Определяет, что параграф листьевой');
    PutIsType('para_list', k2_typParaList, 'Определяет, что параграф является списком параграфов');
    PutIsType('para', k2_typPara, 'Определяет, что тег является параграфом');
    PutIsType('text_para', k2_typTextPara, 'Определяет, что параграф является текстовым');
    PutIsType('styled_leaf_para', k2_typStyledLeafPara, 'Определяет, что параграф является листьевым и имеет стиль');
    Put('// helpers functions end');
    Put;
    (*Put('// константы для работы с физическим представлением формата evd:');
    Put;
    Put('typedef unsigned char  uInt8;');
    Put('typedef unsigned short uInt16;');
    Put('typedef unsigned long  uInt32;');
    Put('typedef char  sInt8;');
    Put('typedef short sInt16;');
    Put('typedef long  sInt32;');
    Put;
    PutEnum('', TypeInfo(TevTypeID), 'Типы тегов для записи evd в поток');
    Put('const uInt16 idFinish       = 0x%x; // закрывающая скобка тега', [unpack_idFinish]);
    Put('const uInt16 idMask         = 0x%x; // маска распределения памяти', [unpack_idMask]);
    Put('const uInt16 idChildren     = 0x%x; // признак начала списка дочерних тегов', [unpack_idChildren]);
    Put('const uInt16 idRollback     = 0x%x; // признак отката тега', [unpack_idRollback]);
    Put('const uInt16 idMaskEx       = 0x%x; // расширенная маска распределения памяти', [unpack_idMaskEx]);
    Put('const uInt16 idLink         = 0x%x; // ссылка на объект в другом IStorage', [unpack_idLink]);
    Put('const uInt16 idDefaultChild = 0x%x; // дочерний тег с типом по умолчанию', [unpack_idDefaultChild]);
    Put;
    Put('const uInt16 idKey1 = 0x%x; // {-''%%e''} признак завершения бинарных данных.', [unpack_idKey1]);
    Put('const uInt16 idKey2 = 0x%x; // {-''%%E''} признак завершения бинарных данных.', [unpack_idKey2]);
    Put('const uInt16 idKey3 = 0x%x; // {-''%%b''} признак начала бинарных данных.', [unpack_idKey3]);
    Put('const uInt16 idKey4 = 0x%x; // {-''%%B''} признак начала бинарных данных.', [unpack_idKey4]);
    Put;
    Put('// физическое представление здесь кончается');
    Put;*)
    WriteControlParaAttrValues;
    Put('} // namespace');
    Put;
    Put('#endif // EVD_H__');
   end;//l_TypeTable = nil
  finally
   l_Out.Close;
  end;//try..finally
 finally
  l3Free(l_Out);
 end;//try..finally
 l_Out := Tl3DOSFiler.Make('evddata.cpp', l3_fmWrite, false);
 try
  l_Out.Open;
  try
    Put('// !!! Это автосгенерированный файл. Не добавляйте сюда ничего руками !!!');
    Put;
    Put('#include "ace/ACE.h"');
    Put('#include "common/components/rtl/Garant/EVD/evddata.h"');
    Put('// константы для работы с логическим представлением формата evd:');
    Put;
    Put('namespace evd {');
    Put;
    PutVect('TagName', TypeInfo(Tk2TagID), 'имена тегов', '_k2_ti', '');
    PutTypeVect('TypeName', 'имена типов');
    Put('} // namespace');
    Put;
  finally
   l_Out.Close;
  end;//try..finally
 finally
  l3Free(l_Out);
 end;//try..finally
 l_Out := Tl3DOSFiler.Make('EVDSchema.script', l3_fmWrite, false);
 try
  l_Out.Open;
  try
   Put('// !!! Это автосгенерированный файл. Не добавляйте сюда ничего руками !!!');
   Put;
   WriteAttrs;
   Put;
   WriteTypes;
   Put;
   WriteStyles;
  finally
   l_Out.Close;
  end;//try..finally
 finally
  l3Free(l_Out);
 end;//try..finally
end;

begin
 DoOut;
end.