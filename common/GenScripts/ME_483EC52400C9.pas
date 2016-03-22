unit atXMLScenarioGenerator;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atXMLScenarioGenerator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatXMLScenarioGenerator" MUID: (483EC52400C9)

interface

uses
 l3IntfUses
 , atScenario
 , atOperationBase
 , XMLIntf
 , SysUtils
;

type
 EInvalidXMLScenario = class(Exception)
 end;//EInvalidXMLScenario

 TatXMLScenarioGenerator = class
  private
   f_Scenario: TatScenario;
  private
   procedure FillOperationParameters(anOperation: TatOperationBase;
    const anAttributes: IXMLNodeList); virtual;
   procedure ParseXMLDoc(const aXmlDoc: IXMLDocument); virtual;
   procedure ParseOperationNode(const aXmlNode: IXMLNode;
    aParentOp: TatOperationBase); virtual;
  public
   function FillScenario(aScenario: TatScenario;
    const aXmlFileName: AnsiString): Boolean; virtual;
 end;//TatXMLScenarioGenerator

implementation

uses
 l3ImplUses
 , atLogger
 , atOperationFactory
 , XMLDoc
;

function TatXMLScenarioGenerator.FillScenario(aScenario: TatScenario;
 const aXmlFileName: AnsiString): Boolean;
//#UC START# *483ECFCA023D_483EC52400C9_var*
  var
    xmlDoc : IXMLDocument;
//#UC END# *483ECFCA023D_483EC52400C9_var*
begin
//#UC START# *483ECFCA023D_483EC52400C9_impl*
  xmlDoc := TXMLDocument.Create(aXmlFileName);
  Assert(aScenario <> nil, 'aScenario <> nil');
  f_Scenario := aScenario;
  ParseXMLDoc(xmlDoc);
  Result := true;
//#UC END# *483ECFCA023D_483EC52400C9_impl*
end;//TatXMLScenarioGenerator.FillScenario

procedure TatXMLScenarioGenerator.FillOperationParameters(anOperation: TatOperationBase;
 const anAttributes: IXMLNodeList);
//#UC START# *483ECFFD02CA_483EC52400C9_var*
  var
    i : Integer;
    attribute : IXMLNode;
//#UC END# *483ECFFD02CA_483EC52400C9_var*
begin
//#UC START# *483ECFFD02CA_483EC52400C9_impl*
  for i := 0 to anAttributes.Count-1 do
  begin
    attribute := anAttributes.Nodes[i];
    if attribute.NodeName = 'name' then
      continue
    else
      anOperation.Parameters[attribute.NodeName].AsStr := attribute.NodeValue;
  end;
//#UC END# *483ECFFD02CA_483EC52400C9_impl*
end;//TatXMLScenarioGenerator.FillOperationParameters

procedure TatXMLScenarioGenerator.ParseXMLDoc(const aXmlDoc: IXMLDocument);
//#UC START# *483ED078005D_483EC52400C9_var*
  var
    nodes : IXMLNodeList;
    scenarioNode : IXMLNode;
    operationNodes : IXMLNodeList;
    i : integer;
//#UC END# *483ED078005D_483EC52400C9_var*
begin
//#UC START# *483ED078005D_483EC52400C9_impl*
  nodes := aXmlDoc.ChildNodes;
  if nodes.Count <> 2 then
    Raise EInvalidXMLScenario.Create(Logger.Error('В xml-файле обнаружено более одного корневого элемента!'));
  nodes := nodes.Nodes['scenarios'].ChildNodes;
  scenarioNode := nodes.Nodes['scenario'];
  if (scenarioNode = nil) then
    Raise EInvalidXMLScenario.Create(Logger.Error('Cценарий не найден!'));
  // парсим ноду сценария
  FillOperationParameters(f_Scenario, scenarioNode.AttributeNodes);
  // парсим операции
  operationNodes := scenarioNode.ChildNodes;
  if (operationNodes.Count < 1) then
    Raise EInvalidXMLScenario.Create(Logger.Error('Должна быть как-минимум одна операция!'));
  for i := 0 to operationNodes.Count-1 do
    ParseOperationNode(operationNodes.Nodes[i], f_Scenario);
//#UC END# *483ED078005D_483EC52400C9_impl*
end;//TatXMLScenarioGenerator.ParseXMLDoc

procedure TatXMLScenarioGenerator.ParseOperationNode(const aXmlNode: IXMLNode;
 aParentOp: TatOperationBase);
//#UC START# *483ED09F0138_483EC52400C9_var*
  var
    opName : String;
    attributes, childs : IXMLNodeList;
    operation : TatOperationBase;
    i : integer;
//#UC END# *483ED09F0138_483EC52400C9_var*
begin
//#UC START# *483ED09F0138_483EC52400C9_impl*
  if (aXmlNode.NodeType = ntComment) then
    Exit; // пропускаем комментарии
  if (aXmlNode.NodeName <> 'operation') then
    Raise EInvalidXMLScenario.Create(Logger.Error('Ожидали ноду operation, а встретили "' + aXmlNode.NodeName + '"'));
  // получаем имя операции и создаем ее
  opName := aXmlNode.Attributes['name'];
  operation := OperationFactory.MakeOperation(opName);
  attributes := aXmlNode.AttributeNodes;
  // добавляем к родителю
  aParentOp.AddChild(operation);
  // заполняем параметры
  FillOperationParameters(operation, attributes);
  operation.AfterFillingParamList();
  // парсим детей
  childs := aXmlNode.ChildNodes;
  for i := 0 to childs.Count-1 do
    ParseOperationNode(childs.Nodes[i], operation);
//#UC END# *483ED09F0138_483EC52400C9_impl*
end;//TatXMLScenarioGenerator.ParseOperationNode

end.
