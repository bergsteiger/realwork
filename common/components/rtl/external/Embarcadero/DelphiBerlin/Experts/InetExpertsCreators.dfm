object InetExpertsCreatorsModule: TInetExpertsCreatorsModule
  OldCreateOrder = False
  Height = 428
  Width = 529
  object CommonTemplateProperties: TExpertsTemplateProperties
    Left = 264
    Top = 40
  end
  object WebModule: TExpertsModule
    SourceTemplateFile = WebModuleSourceTemplate
    InterfaceTemplateFile = WebModuleIntfTemplate
    FormTemplateFile = WebModuleDFMTemplate
    TemplateProperties = CommonTemplateProperties
    AncestorName = 'WebModule'
    FileName = 'WebModuleUnit%d'
    FormName = 'WebModule%d'
    Left = 56
    Top = 144
  end
  object ProjectTemplate: TExpertsTemplateFile
    TemplateFileManager = WebModulesTemplatePersonalityFiles
    Left = 144
    Top = 24
  end
  object WebProject: TExpertsProject
    ProjectType = ptApplication
    ProjectTemplateFile = ProjectTemplate
    TemplateProperties = CommonTemplateProperties
    OnCreateModules = WebProjectCreateModules
    Left = 64
    Top = 24
  end
  object ConsoleSourceTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'IndyFormConsoleSource=TRUE')
    TemplateFileManager = WebModulesTemplatePersonalityFiles
    Left = 416
    Top = 80
  end
  object WebModuleIntfTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'WebModuleIntf=TRUE')
    TemplateFileManager = WebModulesTemplatePersonalityFiles
    Left = 56
    Top = 248
  end
  object WebModuleSourceTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'WebModuleSource=TRUE')
    TemplateFileManager = WebModulesTemplatePersonalityFiles
    Left = 56
    Top = 200
  end
  object WebModuleDFMTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'WebModuleDFMSource=TRUE')
    TemplateFileManager = WebModulesTemplatePersonalityFiles
    Left = 48
    Top = 304
  end
  object ConsoleModule: TExpertsModule
    SourceTemplateFile = ConsoleSourceTemplate
    InterfaceTemplateFile = ConsoleIntfTemplate
    FormTemplateFile = ConsoleDFMTemplate
    TemplateProperties = CommonTemplateProperties
    AncestorName = 'Form'
    FileName = 'FormUnit%d'
    FormName = 'Form%d'
    Left = 416
    Top = 32
  end
  object ConsoleIntfTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'IndyFormConsoleIntf=TRUE')
    TemplateFileManager = WebModulesTemplatePersonalityFiles
    Left = 416
    Top = 136
  end
  object ConsoleDFMTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'IndyFormConsoleDFMSource=TRUE')
    TemplateFileManager = WebModulesTemplatePersonalityFiles
    Left = 416
    Top = 192
  end
  object WebModulesTemplatePersonalityFiles: TExpertsTemplatePersonalityFiles
    DelphiTemplateFile = 'newwebmodules.pas'
    CBuilderTemplateFile = 'cpp\newwebmodules.cpp'
    Left = 264
    Top = 96
  end
  object PCHSourceTemplate: TExpertsTemplateFile
    TemplateFile = 'cpp\WebPCHModule.h'
    TemplatePropertiesDoc.Strings = (
      '=')
    Left = 416
    Top = 320
  end
  object PchModule: TExpertsPchModule
    SourceTemplateFile = PCHSourceTemplate
    Left = 416
    Top = 264
  end
  object ServerConstSourceTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'ServerConstSource=TRUE')
    TemplateFileManager = WebModulesTemplatePersonalityFiles
    Left = 242
    Top = 300
  end
  object ServerConstIntfTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'ServerConstIntf=TRUE')
    TemplateFileManager = WebModulesTemplatePersonalityFiles
    Left = 240
    Top = 352
  end
  object ServerContainerConst: TExpertsUnit
    SourceTemplateFile = ServerConstSourceTemplate
    InterfaceTemplateFile = ServerConstIntfTemplate
    TemplateProperties = CommonTemplateProperties
    FileName = 'ServerConst%d'
    Left = 240
    Top = 240
  end
end
