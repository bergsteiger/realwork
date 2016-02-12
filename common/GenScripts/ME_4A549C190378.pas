unit atQuery;
 {* ��������������� ������� ��� Query }

// ������: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atQuery.pas"
// ���������: "SimpleClass"

interface

uses
 l3IntfUses
 , SearchUnit
 , XMLIntf
 , DynamicTreeUnit
 , BaseTypesUnit
 , Classes
 , l3_Base
;

type
 _EntityInterface_ = IQuery;
 {$Include w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atEntityWithName.imp.pas}
 TatQuery = class(_atEntityWithName_)
  {* ��������������� ������� ��� Query }
  protected
   function pm_GetQuery: IQuery;
   function pm_GetQueryType: TQueryType;
   function pm_GetEmpty: Boolean;
  public
   constructor CreateByType(const aQueryType: TQueryType); reintroduce; virtual;
   procedure ClearAttribute(const aTagName: AnsiString); virtual;
   procedure SaveNodeAttribute(const aTagName: AnsiString;
    const aOp: TQueryLogicOperation;
    const aNode: INodeBase); virtual;
   procedure SaveContextAttribute(const aTagName: AnsiString;
    const aOp: TQueryLogicOperation;
    const aContext: AnsiString); virtual;
   procedure SavePhoneAttribute(const aTagName: AnsiString;
    const aCityCode: AnsiString;
    const aPhoneNumber: AnsiString); virtual;
   procedure SaveDateAttribute(const aTagName: AnsiString;
    const aFrom: TDate;
    const aTo: TDate); virtual;
   constructor CreateFromXML(const anXML: IXMLDocument;
    const anImportErrors: TStrings = nil); reintroduce; virtual;
   function ExportAsXML: IXMLDocument; virtual;
  public
   property Query: IQuery
    read pm_GetQuery;
   property QueryType: TQueryType
    read pm_GetQueryType;
   property Empty: Boolean
    read pm_GetEmpty;
 end;//TatQuery

implementation

uses
 l3ImplUses
 , atStringHelper
 , atGblAdapterWorker
 , SysUtils
 , IOUnit
 , atQueryTypeConverter
 , atQueryLogicOperationConverter
 , atNodeHelper
 , XMLDoc
 , Variants
 , atNonATQueryLogicOperationConverter
;

const
 NN_ATTR = 'attribute';
 NN_QUERY = 'query';
 NN_ITEM = 'item';
 NN_TEXT = 'text';
 NN_DATE = 'date';
 NN_PHONE = 'phone';
 AN_TYPE = 'type';
 AN_TAG = 'tag';
 AN_LOGIC_OPERATION = 'logic_operation';
 AN_FROM_DAY = 'from_day';
 AN_FROM_MONTH = 'from_month';
 AN_FROM_YEAR = 'from_year';
 AN_TO_DAY = 'to_day';
 AN_TO_MONTH = 'to_month';
 AN_TO_YEAR = 'to_year';
 AN_BY_AT = 'created_by_at';
 AN_XML_VERSION = 'xml_version';
 AN_PHONE_NUMBER = 'phone_number';
 AN_CITY_CODE = 'city_code';
 PATH_DELIMITER = '\';

{$Include w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atEntityWithName.imp.pas}

function TatQuery.pm_GetQuery: IQuery;
//#UC START# *4A549D35001C_4A549C190378get_var*
//#UC END# *4A549D35001C_4A549C190378get_var*
begin
//#UC START# *4A549D35001C_4A549C190378get_impl*
  Result := f_Entity
//#UC END# *4A549D35001C_4A549C190378get_impl*
end;//TatQuery.pm_GetQuery

function TatQuery.pm_GetQueryType: TQueryType;
//#UC START# *500553180242_4A549C190378get_var*
//#UC END# *500553180242_4A549C190378get_var*
begin
//#UC START# *500553180242_4A549C190378get_impl*
  Result := Query.GetType;
//#UC END# *500553180242_4A549C190378get_impl*
end;//TatQuery.pm_GetQueryType

function TatQuery.pm_GetEmpty: Boolean;
//#UC START# *50102D42035C_4A549C190378get_var*
  var
    l_QAL : IQueryAttributeList;
//#UC END# *50102D42035C_4A549C190378get_var*
begin
//#UC START# *50102D42035C_4A549C190378get_impl*
  Query.GetAttributes(l_QAL);
  Result := (l_QAL = nil) OR (l_QAL.Count = 0);
//#UC END# *50102D42035C_4A549C190378get_impl*
end;//TatQuery.pm_GetEmpty

constructor TatQuery.CreateByType(const aQueryType: TQueryType);
//#UC START# *4A549C6B019E_4A549C190378_var*
//#UC END# *4A549C6B019E_4A549C190378_var*
begin
//#UC START# *4A549C6B019E_4A549C190378_impl*
  inherited Create(TatGblAdapterWorker.Instance.GblAdapterDll.MakeQuery(aQueryType));
  if (f_Entity = nil) then Raise Exception.Create('�� ���� ������� Query!');
  Name;
//#UC END# *4A549C6B019E_4A549C190378_impl*
end;//TatQuery.CreateByType

procedure TatQuery.ClearAttribute(const aTagName: AnsiString);
//#UC START# *4A549CF603AC_4A549C190378_var*
  var
    l_AttrList : IQueryAttributeList;
    l_Attr : IQueryAttribute;
    i : Integer;
//#UC END# *4A549CF603AC_4A549C190378_var*
begin
//#UC START# *4A549CF603AC_4A549C190378_impl*
  Query.GetAttributes(l_AttrList);
  if (l_AttrList <> nil) then
  begin
    i := 0;
    while (i < l_AttrList.Count) do
    begin
      l_AttrList.pm_GetItem(i, l_Attr);
      if (l_Attr.GetTag = aTagName) then
      begin
        l_Attr := nil;
        l_AttrList.Delete(i);
      end
      else
        Inc(i);
    end;
  end;
//#UC END# *4A549CF603AC_4A549C190378_impl*
end;//TatQuery.ClearAttribute

procedure TatQuery.SaveNodeAttribute(const aTagName: AnsiString;
 const aOp: TQueryLogicOperation;
 const aNode: INodeBase);
//#UC START# *4A549D8100F9_4A549C190378_var*
  var
    l_NodeAttr : IQueryNodeAttribute;
//#UC END# *4A549D8100F9_4A549C190378_var*
begin
//#UC START# *4A549D8100F9_4A549C190378_impl*
  Query.GetNodeAttribute(PAnsiChar(aTagName), l_NodeAttr);
  Assert(l_NodeAttr <> nil, 'l_NodeAttr <> nil');
  l_NodeAttr.AddValue(aOp, aNode);
//#UC END# *4A549D8100F9_4A549C190378_impl*
end;//TatQuery.SaveNodeAttribute

procedure TatQuery.SaveContextAttribute(const aTagName: AnsiString;
 const aOp: TQueryLogicOperation;
 const aContext: AnsiString);
//#UC START# *4A549DAD0296_4A549C190378_var*
  var
    l_ContextAttr : IQueryContextAttribute;
//#UC END# *4A549DAD0296_4A549C190378_var*
begin
//#UC START# *4A549DAD0296_4A549C190378_impl*
  Query.GetContextAttribute(PAnsiChar(aTagName), l_ContextAttr);
  Assert(l_ContextAttr <> nil, 'l_ContextAttr <> nil');
  l_ContextAttr.AddValue(aOp, TatStringHelper.DStr2AStr(aContext) );
//#UC END# *4A549DAD0296_4A549C190378_impl*
end;//TatQuery.SaveContextAttribute

procedure TatQuery.SavePhoneAttribute(const aTagName: AnsiString;
 const aCityCode: AnsiString;
 const aPhoneNumber: AnsiString);
//#UC START# *4A54B321025E_4A549C190378_var*
  var
    l_PhoneAttr : IQueryPhoneNumberAttribute;
//#UC END# *4A54B321025E_4A549C190378_var*
begin
//#UC START# *4A54B321025E_4A549C190378_impl*
  Query.GetPhoneNumberAttribute(PAnsiChar(aTagName), l_PhoneAttr);
  Assert(l_PhoneAttr <> nil, 'l_PhoneAttr <> nil');
  l_PhoneAttr.SetCityCode( TatStringHelper.DStr2AStr(aCityCode) );
  l_PhoneAttr.SetPhoneNumber( TatStringHelper.DStr2AStr(aPhoneNumber) );
//#UC END# *4A54B321025E_4A549C190378_impl*
end;//TatQuery.SavePhoneAttribute

procedure TatQuery.SaveDateAttribute(const aTagName: AnsiString;
 const aFrom: TDate;
 const aTo: TDate);
//#UC START# *50045A9402F4_4A549C190378_var*
  var
    l_DateAttr : IQueryDateAttribute;
//#UC END# *50045A9402F4_4A549C190378_var*
begin
//#UC START# *50045A9402F4_4A549C190378_impl*
  Query.GetDateAttribute(PAnsiChar(aTagName), l_DateAttr);
  Assert(l_DateAttr <> nil, 'l_DateAttr <> nil');
  l_DateAttr.AddValue(QLO_OR, aFrom, aTo);
//#UC END# *50045A9402F4_4A549C190378_impl*
end;//TatQuery.SaveDateAttribute

constructor TatQuery.CreateFromXML(const anXML: IXMLDocument;
 const anImportErrors: TStrings = nil);
//#UC START# *50045B3F032A_4A549C190378_var*
  var
    i, j : Integer;
    l_Tag, l_NodeName : String;
    l_ParsedNode : IXMLNode;
    l_IsByAT : Boolean;
    l_OldOpts : TXMLDocOptions;

    procedure AddError(const anError : String);
    begin
      if anImportErrors <> nil then
        anImportErrors.Append(anError);
    end;

    procedure ParseTextNode;
    begin
      SaveContextAttribute(l_Tag, QLO_OR, l_ParsedNode.Text);
    end;

    procedure ParsePhoneNode;
    begin
      SavePhoneAttribute(l_Tag,l_ParsedNode.Attributes[AN_CITY_CODE], l_ParsedNode.Attributes[AN_PHONE_NUMBER]);
    end;

    procedure ParseDateNode;
      var
        l_FromDate, l_ToDate : BaseTypesUnit.TDate;
    begin
      l_FromDate.rDay   :=  StrToInt(l_ParsedNode.Attributes[AN_FROM_DAY]);
      l_FromDate.rMonth :=  StrToInt(l_ParsedNode.Attributes[AN_FROM_MONTH]);
      l_FromDate.rYear  :=  StrToInt(l_ParsedNode.Attributes[AN_FROM_Year]);
      //
      l_ToDate.rDay   :=  StrToInt(l_ParsedNode.Attributes[AN_TO_DAY]);
      l_ToDate.rMonth :=  StrToInt(l_ParsedNode.Attributes[AN_TO_MONTH]);
      l_ToDate.rYear  :=  StrToInt(l_ParsedNode.Attributes[AN_TO_Year]);
      //
      SaveDateAttribute(l_Tag, l_FromDate, l_ToDate);
    end;

    procedure ParseItemNode;
      var
        l_TreeRoot, l_Node : INodeBase;
        l_LOStr, l_NodeText : String;
        l_QLO : TQueryLogicOperation;
    begin
      l_NodeText := l_ParsedNode.Text;
      l_LOStr := l_ParsedNode.Attributes[AN_LOGIC_OPERATION];
      // ������������ �������� ��������� ���� � ���
      if l_IsByAT then
        l_QLO := TatQueryLogicOperationConverter.Instance.ToValue(l_LOStr)
      else
        l_QLO := TatNonATQueryLogicOperationConverter.Instance.ToValueCI(l_LOStr);
      // ���� � ������ ��������� �������
      l_TreeRoot := TatGblAdapterWorker.Instance.GblAdapterDll.MakeNodeBase(PAnsiChar(l_Tag));
      if l_TreeRoot = nil then
      begin
        AddError( Format('��� ������ ������: %s', [l_Tag]) );
        Exit;
      end;
      l_Node := TatNodeHelper.FindNodeByPath(l_TreeRoot, l_NodeText, PATH_DELIMITER, true, true);
      //
      if l_Node <> nil then
        SaveNodeAttribute(l_Tag, l_QLO, l_Node)
      else
        AddError( Format('�� ������ ����� � ������ %s ������� "%s"', [l_Tag, l_NodeText]) );
    end;
//#UC END# *50045B3F032A_4A549C190378_var*
begin
//#UC START# *50045B3F032A_4A549C190378_impl*
  if anImportErrors <> nil then
    anImportErrors.Clear;
  //
  l_OldOpts := anXML.Options;
  anXML.Options := [doAttrNull];
  try
  //
    with anXML.ChildNodes.Nodes[NN_QUERY] do
    begin
      CreateByType(TatQueryTypeConverter.Instance.ToValue(Attributes[AN_TYPE]));
      //
      l_IsByAT := NOT VarIsNull(Attributes[AN_BY_AT]);
      //
      with ChildNodes do
        for i := 0 to Count-1 do
          with Nodes[i] do
            if AnsiSameText(NodeName, NN_ATTR) then
            begin
              l_Tag := Attributes[AN_TAG];
              //
              with ChildNodes do
                for j := 0 to Count-1 do
                begin
                  l_ParsedNode := Nodes[j];
                  l_NodeName := l_ParsedNode.NodeName;
                  //
                  if AnsiSameText(l_NodeName, NN_TEXT) then
                    ParseTextNode
                  else if AnsiSameText(l_NodeName, NN_DATE) then
                    ParseDateNode
                  else if AnsiSameText(l_NodeName, NN_ITEM) then
                    ParseItemNode
                  else if AnsiSameText(l_NodeName, NN_PHONE) then
                    ParsePhoneNode
                  else
                    Raise Exception.CreateFmt('����������� �������: %s', [l_NodeName]);
                end;
            end
            else
              Raise Exception.CreateFmt('����������� �������: %s', [NodeName]);
    end;
  finally
    anXML.Options := l_OldOpts;
  end;
//#UC END# *50045B3F032A_4A549C190378_impl*
end;//TatQuery.CreateFromXML

function TatQuery.ExportAsXML: IXMLDocument;
//#UC START# *50045DC901DA_4A549C190378_var*
  var
    l_QueryXMLNode, l_AttrXMLNode : IXMLNode;
    l_QueryAttributes : IQueryAttributeList;
    l_QueryAttribute : IQueryAttribute;
    l_ContextVL : IContextValueList;
    l_Context : TContextValue;
    l_DateVL : IDateValueList;
    l_Date : TDateValue;
    l_NodeVL : INodeValueList;
    l_NodeValue : TQueryNodeValue;
    i, j : Integer;
    l_AStr : IString;
//#UC END# *50045DC901DA_4A549C190378_var*
begin
//#UC START# *50045DC901DA_4A549C190378_impl*
  Result := TXMLDocument.Create(nil);
  //
  Result.Active := true;
  Result.Encoding := 'windows-1251';
  Result.Version := '1.0';
  Result.StandAlone := 'no';
  Result.Options := [doNodeAutoIndent];

  //
  l_QueryXMLNode := Result.AddChild(NN_QUERY);
  l_QueryXMLNode.Attributes[AN_TYPE] := TatQueryTypeConverter.Instance.ToName(QueryType);
  l_QueryXMLNode.Attributes[AN_BY_AT] := '';

  //
  Query.GetAttributes(l_QueryAttributes);
  if (l_QueryAttributes = nil) OR (l_QueryAttributes.Count = 0)  then
    Raise Exception.Create('Empty query!');
  //
  for i := 0 to l_QueryAttributes.Count-1 do
  begin
    l_QueryAttributes.pm_GetItem(i, l_QueryAttribute);
    //
    l_AttrXMLNode := l_QueryXMLNode.AddChild(NN_ATTR);
    l_AttrXMLNode.Attributes[AN_TAG] := String(l_QueryAttribute.GetTag);
    //
    case l_QueryAttribute.GetType of
      QTT_CONTEXT :
        begin
          (l_QueryAttribute as IQueryContextAttribute).GetValues(l_ContextVL);
          for j := 0 to l_ContextVL.Count-1 do
          begin
            l_ContextVL.pm_GetItem(j, l_Context);
            //
            l_AttrXMLNode.AddChild(NN_TEXT).Text := TatStringHelper.AStr2DStr(l_Context.rContext);
          end;
          l_ContextVL := nil;
        end; // QTT_CONTEXT
      QTT_DATE :
        begin
          (l_QueryAttribute as IQueryDateAttribute).GetValues(l_DateVL);
          for j := 0 to l_DateVL.Count-1 do
          begin
            l_DateVL.pm_GetItem(j, l_Date);
            //
            with l_AttrXMLNode.AddChild(NN_DATE) do
            begin
              Attributes[AN_FROM_DAY]   := IntToStr(l_Date.rFrom.rDay);
              Attributes[AN_FROM_MONTH] := IntToStr(l_Date.rFrom.rMonth);
              Attributes[AN_FROM_YEAR]  := IntToStr(l_Date.rFrom.rYear);
              Attributes[AN_TO_DAY]   := IntToStr(l_Date.rTo.rDay);
              Attributes[AN_TO_MONTH] := IntToStr(l_Date.rTo.rMonth);
              Attributes[AN_TO_YEAR]  := IntToStr(l_Date.rTo.rYear);
              Attributes[AN_LOGIC_OPERATION] := TatQueryLogicOperationConverter.Instance.ToName(l_Date.rOperation);
            end;
          end;
          l_DateVL := nil;
        end; // QTT_DATE
      QTT_PHONE_NUMBER :
        with (l_QueryAttribute as IQueryPhoneNumberAttribute), l_AttrXMLNode.AddChild(NN_PHONE) do
        begin
          GetPhoneNumber(l_AStr);
          Attributes[AN_PHONE_NUMBER] := TatStringHelper.AStr2DStr(l_AStr);
          GetCityCode(l_AStr);
          Attributes[AN_CITY_CODE] := TatStringHelper.AStr2DStr(l_AStr);
        end;
      QTT_NODE :
        begin
          (l_QueryAttribute as IQueryNodeAttribute).GetValues(l_NodeVL);
          for j := 0 to l_NodeVL.Count-1 do
          begin
            l_NodeVL.pm_GetItem(j, l_NodeValue);
            //
            with l_AttrXMLNode.AddChild(NN_ITEM) do
            begin
              Text := TatNodeHelper.GetPath(l_NodeValue.rNode, PATH_DELIMITER, true);
              Attributes[AN_LOGIC_OPERATION] := TatQueryLogicOperationConverter.Instance.ToName(l_NodeValue.rOperation);
            end;
          end;
          l_NodeVL := nil;
        end; //QTT_NODE
    end; // case l_QueryAttribute.GetType
  end;
//#UC END# *50045DC901DA_4A549C190378_impl*
end;//TatQuery.ExportAsXML

end.
