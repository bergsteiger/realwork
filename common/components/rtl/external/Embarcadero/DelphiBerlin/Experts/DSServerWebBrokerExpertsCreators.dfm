inherited DSServerWebBrokerExpertsCreatorsModule: TDSServerWebBrokerExpertsCreatorsModule
  OldCreateOrder = True
  Height = 598
  inherited WebModuleIntfTemplate: TExpertsTemplateFile
    TemplatePropertiesDoc.Strings = (
      'DataSnapWebModuleIntf=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
  end
  inherited WebModuleSourceTemplate: TExpertsTemplateFile
    TemplatePropertiesDoc.Strings = (
      'DataSnapWebModuleSource=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
  end
  inherited WebModuleDFMTemplate: TExpertsTemplateFile
    TemplatePropertiesDoc.Strings = (
      'DataSnapWebModuleDFMSource=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
  end
  object DataSnapTemplatePersonalityFiles: TExpertsTemplatePersonalityFiles
    DelphiTemplateFile = 'newdatasnapmodules.pas'
    CBuilderTemplateFile = 'cpp\newdatasnapmodules.cpp'
    Left = 288
    Top = 304
  end
  object ServerContainerModuleSourceTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DataSnapModuleSource=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 90
    Top = 520
  end
  object ServerContainerDFMTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DataSnapModuleDFMSource=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 90
    Top = 472
  end
  object ServerContainerModuleIntfTemplate: TExpertsTemplateFile
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      'DataSnapModuleIntf=TRUE')
    TemplateFileManager = DataSnapTemplatePersonalityFiles
    Left = 90
    Top = 416
  end
  object ServerContainerModule: TExpertsModule
    SourceTemplateFile = ServerContainerModuleSourceTemplate
    InterfaceTemplateFile = ServerContainerModuleIntfTemplate
    FormTemplateFile = ServerContainerDFMTemplate
    TemplateProperties = CommonTemplateProperties
    TemplatePropertiesDoc.Strings = (
      '=')
    AncestorName = 'DataModule'
    FileName = 'ServerContainerUnit%d'
    FormName = 'ServerContainer%d'
    Left = 48
    Top = 360
  end
end
