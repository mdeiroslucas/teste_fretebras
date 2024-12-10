object frmRegisterPeople: TfrmRegisterPeople
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registrar Pessoa'
  ClientHeight = 630
  ClientWidth = 1058
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1058
    Height = 57
    Align = alTop
    TabOrder = 0
    object btnNovo: TBitBtn
      Left = 1
      Top = 1
      Width = 75
      Height = 55
      Align = alLeft
      Caption = 'Novo'
      TabOrder = 0
    end
    object btnDelete: TBitBtn
      Left = 226
      Top = 1
      Width = 75
      Height = 55
      Align = alLeft
      Caption = 'Deletar'
      TabOrder = 1
    end
    object btnEdit: TBitBtn
      Left = 151
      Top = 1
      Width = 75
      Height = 55
      Align = alLeft
      Caption = 'Editar'
      TabOrder = 2
    end
    object btnSave: TBitBtn
      Left = 76
      Top = 1
      Width = 75
      Height = 55
      Align = alLeft
      Caption = 'Salvar'
      TabOrder = 3
      OnClick = btnSaveClick
    end
    object BitBtn1: TBitBtn
      Left = 301
      Top = 1
      Width = 75
      Height = 55
      Align = alLeft
      Caption = 'Pesquisar'
      TabOrder = 4
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 57
    Width = 1058
    Height = 513
    Align = alClient
    TabOrder = 1
    object lvlFullName: TLabel
      Left = 24
      Top = 21
      Width = 89
      Height = 15
      Caption = 'Nome Completo'
    end
    object lblCPF: TLabel
      Left = 568
      Top = 21
      Width = 21
      Height = 15
      Caption = 'CPF'
    end
    object lblBirthDate: TLabel
      Left = 432
      Top = 21
      Width = 107
      Height = 15
      Caption = 'Data de Nascimento'
    end
    object lblRG: TLabel
      Left = 703
      Top = 21
      Width = 15
      Height = 15
      Caption = 'RG'
    end
    object lblEmail: TLabel
      Left = 24
      Top = 71
      Width = 29
      Height = 15
      Caption = 'Email'
    end
    object lblPhone: TLabel
      Left = 432
      Top = 71
      Width = 44
      Height = 15
      Caption = 'Telefone'
    end
    object lblStreet: TLabel
      Left = 24
      Top = 176
      Width = 62
      Height = 15
      Caption = 'Logradouro'
    end
    object lblDistrict: TLabel
      Left = 126
      Top = 176
      Width = 31
      Height = 15
      Caption = 'Bairro'
    end
    object lblZipCode: TLabel
      Left = 24
      Top = 128
      Width = 21
      Height = 15
      Caption = 'CEP'
    end
    object lblCity: TLabel
      Left = 122
      Top = 128
      Width = 37
      Height = 15
      Caption = 'Cidade'
    end
    object lblState: TLabel
      Left = 241
      Top = 128
      Width = 35
      Height = 15
      Caption = 'Estado'
    end
    object lblPersonType: TLabel
      Left = 568
      Top = 71
      Width = 78
      Height = 15
      Caption = 'Tipo de Pessoa'
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 298
      Width = 1056
      Height = 214
      Align = alBottom
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
    object edtFullName: TEdit
      Left = 24
      Top = 36
      Width = 377
      Height = 23
      TabOrder = 1
      Text = 'Lucas'
    end
    object edtRg: TEdit
      Left = 703
      Top = 36
      Width = 121
      Height = 23
      TabOrder = 2
      Text = '1234567'
    end
    object medtBirthDate: TMaskEdit
      Left = 432
      Top = 36
      Width = 107
      Height = 23
      EditMask = '!99/99/0000;1;'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
    end
    object meditCPF: TMaskEdit
      Left = 568
      Top = 36
      Width = 102
      Height = 23
      EditMask = '!999.999.999-99;0; '
      MaxLength = 14
      TabOrder = 4
      Text = '12332112332'
    end
    object edtEmail: TEdit
      Left = 24
      Top = 86
      Width = 377
      Height = 23
      TabOrder = 5
      Text = 'lucas@gmail.com'
    end
    object edtStreet: TEdit
      Left = 24
      Top = 192
      Width = 89
      Height = 23
      TabOrder = 6
    end
    object edtDistrict: TEdit
      Left = 126
      Top = 192
      Width = 121
      Height = 23
      TabOrder = 7
    end
    object medtPhone: TMaskEdit
      Left = 432
      Top = 86
      Width = 105
      Height = 23
      EditMask = '!(99)99999-9999;0; '
      MaxLength = 14
      TabOrder = 8
      Text = '75991541206'
    end
    object edtZipCode: TEdit
      Left = 24
      Top = 144
      Width = 89
      Height = 23
      TabOrder = 9
      Text = '44441786'
      OnExit = edtZipCodeExit
    end
    object edtCity: TEdit
      Left = 122
      Top = 144
      Width = 104
      Height = 23
      TabOrder = 10
    end
    object edtState: TEdit
      Left = 241
      Top = 144
      Width = 72
      Height = 23
      TabOrder = 11
    end
    object dcboxPersonType: TDBLookupComboBox
      Left = 568
      Top = 86
      Width = 256
      Height = 23
      KeyField = 'id'
      ListField = 'descricao'
      TabOrder = 12
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 570
    Width = 1058
    Height = 60
    Align = alBottom
    TabOrder = 2
  end
end