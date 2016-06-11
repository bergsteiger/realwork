{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

(*:Simplified XPath parser.
   Based on XPath tutorial from http://www.w3schools.com/xpath/default.asp.
   @author Primoz Gabrijelcic
   @desc <pre>
   (c) 2011 Primoz Gabrijelcic
   Free for personal and commercial use. No rights reserved.

   Author            : Primoz Gabrijelcic
   Creation date     : 2005-10-28
   Last modification : 2011-08-30
   Version           : 1.03
</pre>*)(*
   History:
     1.03: 2011-08-30
       - Added support for the '..' element.
     1.02: 2010-07-06
       - Added support for predicates [node] and [node='value'].
     1.01a: 2008-01-10
       - Parser was calling 8-bit versions of Pos and PosEx. Fixed PosEx to accept
         16-bit parameters and added 16-bit version of Pos.
     1.01: 2006-02-02
       - Added support for parameters in double quotes.
         Example: /bookstore/book/title[@lang="eng"].
       - Added support for the '.' element.
         Example: ./title.
     1.0b: 2006-01-12
       - Fixed bug in nested query processing.
     1.0a: 2005-11-03
       - Passing OmniIXMLDocument to the XPathSelect with absolute expression (starting in
         '/') resulted in wrong output.
     1.0: 2005-10-30
       - Released.
*)
unit Xml.Internal.OmniXMLXPath;

interface

uses
  System.SysUtils, Xml.Internal.OmniXML;

type
  {:Exceptions raised on invalid XPath expressions.
    @since   2005-10-28
  }
  EXMLXPath = class(Exception);

  {:Simplified XPath expression evaluator.

     Currently supported syntax elements are:
       nodename	   selects all child nodes of the node
       /           selects from the root node
       //          selects in complete subtree
       @	         selects attributes
       .           selects the current node
       ..          selects the parrent of the current node

     Currently supported predicates are:
       [n] 	       selects the n-th subelement of the current element ('n' is a number,
                   first subelement has index 1)
       [@attr]     selects all subelements that have an attribute named 'attr'
       [@attr='x'] selects all subelements that have an attribute named 'attr'
       or          with a value of 'x'
       [@attr="x"]
       [node]      selects all subelements named 'node'
       [node='x']  selects all subelements named node containing test 'x'
       or
       [node="x"]

     Currently supported wildcards are:
       *           matches any element node

     Examples:
       /bookstore/book[1]                      select the first book in bookstore
       /bookstore/book/title[@lang=''eng'']    select all english books
       //title[@lang=''eng'']                  select all english books
       //title                                 select all titles
       /bookstore/book/title                   select all titles
       /bookstore//title[@lang]                select all titles with lang attribute
       /bookstore/book[3]/*                    select all nodes of the third book
       /bookstore//book[title="Harry Potter"]  select all Harry Potter books
       @lang                                   select lang attribute of the current node
       /bookstore/book[1]/title/@lang          select language of the first book
       /bookstore/book/title/@lang             select all languages
       //title/@lang                           select all languages
       //book//@lang                           select all languages
       //@lang                                 select all languages
       title                                   select the title subnode of some node
       ./title                                 select the title subnode of some node

    @param    rootNode   Starting node.
    @param    expression XPath expression.
    @since    2005-10-28
  }
  function XPathSelect(rootNode: OmniIXMLNode; const expression: string): OmniIXMLNodeList;

implementation

{$ZEROBASEDSTRINGS OFF}

type
  {:XPath element processing flags.
    @enum    pefScanTree  Scan complete tree under the parent node (triggered by the //
                          prefix).
    @since   2005-10-28
  }
  OmniTXMLXPathElementFlag = (pefScanTree);
  OmniTXMLXPathElementFlags = set of OmniTXMLXPathElementFlag;

  {:XPath evaluator class.
    @since   2005-10-28
  }
  OmniTXMLXPathEvaluator = class
  private
    FExpression   : string;
    FPosExpression: integer;
  protected
    procedure CollectChildNodes(node: OmniIXMLNode; const element: string;
      element_type: integer; recurse: boolean; endList: OmniIXMLNodeList);
    procedure CopyList(startList, endList: OmniIXMLNodeList);
    procedure EvaluateNode(node: OmniIXMLNode; const element, predicate: string;
      flags: OmniTXMLXPathElementFlags; endList: OmniIXMLNodeList);
    procedure EvaluatePart(startList: OmniIXMLNodeList; const element, predicate: string;
      flags: OmniTXMLXPathElementFlags; endList: OmniIXMLNodeList);
    procedure FilterByAttrib(startList: OmniIXMLNodeList; const attribName, attribValue:
      string; endList: OmniIXMLNodeList);
    procedure FilterByChild(startList: OmniIXMLNodeList; const childName,
      childValue: string; endList: OmniIXMLNodeList);
    procedure FilterNodes(startList: OmniIXMLNodeList; const predicate: string;
      endList: OmniIXMLNodeList);
    function  GetNextExpressionPart(var element, predicate: string;
      var flags: OmniTXMLXPathElementFlags): boolean;
    procedure InitializeExpressionParser(const expression: string);
    function  Pos(ch: WideChar; const s: string): integer;
    function  PosEx(ch: WideChar; const s: string; offset: integer = 1): integer;
    procedure SplitExpression(const predicate: string; var left, op,
      right: string);
  public
    function Evaluate(rootNode: OmniIXMLNode; const expression: string): OmniIXMLNodeList;
  end; { OmniTXMLXPathEvaluator }

{ publics }

  {:Evaluates XML document from the given node according to the specified XPath expression
    and returns list of matching nodes.
    @since   2005-10-28
  }
  function XPathSelect(rootNode: OmniIXMLNode; const expression: string): OmniIXMLNodeList;
  var
    xPath: OmniTXMLXPathEvaluator;
  begin
    xPath := OmniTXMLXPathEvaluator.Create;
    try
      Result := xPath.Evaluate(rootNode, expression);
    finally	FreeAndNil(xpath); end;
  end; { XPathSelect }

{ OmniTXMLXPathEvaluator }

{:Selects child nodes or attributes matching specified name, optionally recursing into
  each subnode.
  @since   2005-10-28
}
procedure OmniTXMLXPathEvaluator.CollectChildNodes(node: OmniIXMLNode; const element: string;
  element_type: integer; recurse: boolean; endList: OmniIXMLNodeList);
var
  childNode: OmniIXMLNode;
  iNode    : integer;
  matchAll : boolean;
  nodeList : OmniIXMLCustomList;
begin
  matchAll := (element = '*');
  if element_type = ATTRIBUTE_NODE then
    nodeList := node.Attributes
  else
    nodeList := node.ChildNodes;
  for iNode := 0 to nodeList.Length-1 do begin
    childNode := nodeList.Item[iNode];
    if (childNode.NodeType = element_type) and
       (matchAll or (childNode.NodeName = element))
    then
      endList.Add(childNode);
    if recurse and (childNode.NodeType = ELEMENT_NODE) then
      CollectChildNodes(childNode, element, element_type, true, endList);
  end;
  //if recursion is on and we were iterating over attributes, we must also check child nodes
  if recurse and (element_type = ATTRIBUTE_NODE) then begin
    for iNode := 0 to node.ChildNodes.Length-1 do begin
      childNode := node.ChildNodes.Item[iNode];
      if childNode.NodeType = ELEMENT_NODE then
        CollectChildNodes(childNode, element, element_type, true, endList);
    end; //for iNode;
  end;
end; { OmniTXMLXPathEvaluator.CollectChildNodes }

{:Copies one node list to another.
  @since   2005-10-28
}
procedure OmniTXMLXPathEvaluator.CopyList(startList, endList: OmniIXMLNodeList);
var
  iNode: integer;
begin
  for iNode := 0 to startList.Length-1 do
    endList.Add(startList.Item[iNode]);
end; { OmniTXMLXPathEvaluator.CopyList }

{:Evaluates XML document from the given node according to the specified XPath expression
  and returns list of matching nodes.
  @since   2005-10-28
}
function OmniTXMLXPathEvaluator.Evaluate(rootNode: OmniIXMLNode; const expression: string):
  OmniIXMLNodeList;
var
  element  : string;
  flags    : OmniTXMLXPathElementFlags;
  predicate: string;
  startList: OmniIXMLNodeList;
  endList  : OmniIXMLNodeList;
begin
  endList := OmniTXMLNodeList.Create;
  if expression <> '' then begin
    if expression[1] <> '/' then
      endList.AddNode(rootNode)
    else if rootNode.OwnerDocument = nil then // already at root
      endList.AddNode(rootNode)
    else
      endList.AddNode(rootNode.OwnerDocument);
    InitializeExpressionParser(expression);
    while GetNextExpressionPart(element, predicate, flags) do begin
      startList := endList;
      endList := OmniTXMLNodeList.Create;
      EvaluatePart(startList, element, predicate, flags, endList);
    end;
  end;
  Result := endList;
end; { OmniTXMLXPathEvaluator.Evaluate }

{:Evaluates one node and stores all matched subnodes in endList.
  @since   2005-10-28
}
procedure OmniTXMLXPathEvaluator.EvaluateNode(node: OmniIXMLNode; const element,
  predicate: string; flags: OmniTXMLXPathElementFlags; endList: OmniIXMLNodeList);
var
  tempList: OmniIXMLNodeList;
begin
  tempList := OmniTXMLNodeList.Create;
  if element = '.' then
    endList.Add(node)
  else if element = '..' then begin
    if node.ParentNode <> nil then
      endList.Add(node.ParentNode);
  end
  else begin
    if (element <> '') and (element[1] = '@') then
      CollectChildNodes(node, Copy(element, 2, Length(element)-1), ATTRIBUTE_NODE,
        pefScanTree in flags, tempList)
    else
      CollectChildNodes(node, element, ELEMENT_NODE, pefScanTree in flags, tempList);
    FilterNodes(tempList, predicate, endList);
  end;
end; { OmniTXMLXPathEvaluator.EvaluateNode }

{:Evaluates all nodes in start list according to element, predicate, and flags, and
  returns all matched subnodes in endList.
  @since   2005-10-28
}
procedure OmniTXMLXPathEvaluator.EvaluatePart(startList: OmniIXMLNodeList; const element,
  predicate: string; flags: OmniTXMLXPathElementFlags; endList: OmniIXMLNodeList);
var
  iNode: integer;
begin
  endList.Clear;
  for iNode := 0 to startList.Length-1 do
    EvaluateNode(startList.Item[iNode], element, predicate, flags, endList);
end; { OmniTXMLXPathEvaluator.EvaluatePart }

{:Copies one list to another and filters on attribute name/content.
  @since   2005-10-28
}
procedure OmniTXMLXPathEvaluator.FilterByAttrib(startList: OmniIXMLNodeList; const attribName,
  attribValue: string; endList: OmniIXMLNodeList);
var
  attrNode     : OmniIXMLNode;
  iNode        : integer;
  matchAnyValue: boolean;
begin
  matchAnyValue := (attribValue = '*');
  for iNode := 0 to startList.Length-1 do begin
    attrNode := startList.Item[iNode].Attributes.GetNamedItem(attribName);
    if (attrNode <> nil) and (matchAnyValue or (attrNode.NodeValue = attribValue)) then
      endList.Add(startList.Item[iNode]);
  end;
end; { OmniTXMLXPathEvaluator.FilterByAttrib }

{:Copies one list to another and filters on child name/content.
  @since   2010-07-06
}
procedure OmniTXMLXPathEvaluator.FilterByChild(startList: OmniIXMLNodeList; const childName,
  childValue: string; endList: OmniIXMLNodeList);

  function GetTextChild(node: OmniIXMLNode): OmniIXMLNode;
  var
    iText: integer;
  begin
    Result := nil;
    if node = nil then
      Exit;
    for iText := 0 to node.ChildNodes.Length-1 do
      if node.ChildNodes.Item[iText].NodeType = TEXT_NODE then begin
        Result := node.ChildNodes.Item[iText];
        break; //for
      end;
  end; { GetTextChild }

var
  childNode    : OmniIXMLNode;
  iNode        : integer;
  matchAnyValue: boolean;
begin
  matchAnyValue := (childValue = '*');
  for iNode := 0 to startList.Length-1 do begin
    childNode := startList.Item[iNode].SelectSingleNode(childName);
    if childNode <> nil then begin
      if matchAnyValue then
        endList.Add(startList.Item[iNode])
      else begin
        childNode := GetTextChild(childNode);
        if (childNode <> nil) and (childNode.NodeValue = childValue) then
          endList.Add(startList.Item[iNode]);
      end;
    end;
  end;
end; { OmniTXMLXPathEvaluator.FilterByChild }

procedure OmniTXMLXPathEvaluator.FilterNodes(startList: OmniIXMLNodeList; const
  predicate: string; endList: OmniIXMLNodeList);
var
  code      : integer;
  idxElement: integer;
  left      : string;
  op        : string;
  right     : string;
begin
  if predicate = '' then
    CopyList(startList, endList)
  else begin
    Val(predicate, idxElement, code);
    if code = 0 then begin // [n] 
      if idxElement <= 0 then
        raise EXMLXPath.CreateFmt('Invalid predicate [%s]', [predicate]);
      if idxElement <= startList.Length then
        endList.Add(startList.Item[idxElement-1]);
    end
    else if predicate[1] <> '@' then begin
      SplitExpression(predicate, left, op, right);
      if op = '' then // [node]
        FilterByChild(startList, left, '*', endList)
      else if op = '=' then // [node='test']
        FilterByChild(startList, left, right, endList)
      else
        raise EXMLXPath.CreateFmt('Unsupported operator [%s]', [predicate]);
    end
    else begin
      SplitExpression(Copy(predicate, 2, Length(predicate)-1), left, op, right);
      if op = '' then // [@attrib]
        FilterByAttrib(startList, left, '*', endList)
      else if op = '=' then // [@attrib='x']
        FilterByAttrib(startList, left, right, endList)
      else
        raise EXMLXPath.CreateFmt('Unsupported operator [%s]', [predicate]);
    end;
  end;
end; { OmniTXMLXPathEvaluator.FilterNodes }

{:Extract next element, predicate and flags from the expression.
  @returns False if there are no more elements in the expression.
  @since   2005-10-28
}
function OmniTXMLXPathEvaluator.GetNextExpressionPart(var element, predicate: string;
  var flags: OmniTXMLXPathElementFlags): boolean;
var
  endElement: integer;
  pPredicate: integer;
begin
  if FPosExpression > Length(FExpression) then
    Result := false
  else begin
    flags := [];
    if FExpression[FPosExpression] = '/' then begin
      Inc(FPosExpression); // initial '/' was already taken into account in Evaluate
      if FExpression[FPosExpression] = '/' then begin
        Inc(FPosExpression);
        Include(flags, pefScanTree);
      end;
    end;
    endElement := PosEx('/', FExpression, FPosExpression);
    if endElement = 0 then
      endElement := Length(FExpression) + 1;
    element := Copy(FExpression, FPosExpression, endElement - FPosExpression);
    FPosExpression := endElement;
    if element = '' then
      raise EXMLXPath.CreateFmt('Empty element at position %d',
        [FPosExpression]);
    pPredicate := Pos('[', element);
    if pPredicate = 0 then begin
      if Pos(']', element) > 0 then
        raise EXMLXPath.CreateFmt('Invalid syntax at position %d',
          [Pos(']', element)]);
      predicate := '';
    end
    else begin
      if Copy(element, Length(element), 1) <> ']' then
        raise EXMLXPath.CreateFmt('Invalid syntax at position %d',
          [FPosExpression + Length(element) - 1]);
      predicate := Copy(element, pPredicate+1, Length(element)-pPredicate-1);
      Delete(element, pPredicate, Length(element)-pPredicate+1);
    end;                                                                    
    Result := true;
  end;
end; { OmniTXMLXPathEvaluator.GetNextExpressionPart }

{:Initializes expression parser.
  @since   2005-10-28
}
procedure OmniTXMLXPathEvaluator.InitializeExpressionParser(const expression: string);
begin
  FExpression := expression;
  FPosExpression := 1;
end; { OmniTXMLXPathEvaluator.InitializeExpressionParser }

function OmniTXMLXPathEvaluator.Pos(ch: WideChar; const s: string): integer;
begin
  Result := PosEx(ch, s);
end; { OmniTXMLXPathEvaluator.Pos }

function OmniTXMLXPathEvaluator.PosEx(ch: WideChar; const s: string; offset: integer = 1): integer;
begin
  for Result := offset to Length(s) do begin
    if s[Result] = ch then
      Exit;
  end;
  Result := 0;
end; { OmniTXMLXPathEvaluator.PosEx }

{:Splits expression into left side, operator, and right side.
  Currently, only '=' operator is recognized.
  @since   2005-10-28
}
procedure OmniTXMLXPathEvaluator.SplitExpression(const predicate: string; var left, op,
  right: string);
var
  pOp: integer;
begin
  pOp := Pos('=', predicate);
  if pOp = 0 then begin
    left := predicate;
    op := '';
    right := '';
  end
  else begin
    left := Trim(Copy(predicate, 1, pOp-1));
    op := predicate[pOp];
    right := Trim(Copy(predicate, pOp+1, Length(predicate)-pOp));
    if (right[1] = '''') and (right[Length(right)] = '''') then
      right := Copy(right, 2, Length(right)-2)
    else if (right[1] = '"') and (right[Length(right)] = '"') then
      right := Copy(right, 2, Length(right)-2);
  end;
end; { OmniTXMLXPathEvaluator.SplitExpression }

end.
