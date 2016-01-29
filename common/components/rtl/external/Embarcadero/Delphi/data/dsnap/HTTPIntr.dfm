object HTTPServer: THTTPServer
  OldCreateOrder = False
  OnCreate = WebModuleCreate
  OnDestroy = WebModuleDestroy
  Actions = <
    item
      Default = True
      Name = 'Interpreter'
      OnAction = InterpreterAction
    end>
  Height = 150
  Width = 215
end
