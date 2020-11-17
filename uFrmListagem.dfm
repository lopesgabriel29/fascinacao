object FrmListar: TFrmListar
  Left = 0
  Top = 0
  Caption = 'Centro musical fascina'#231#227'o'
  ClientHeight = 488
  ClientWidth = 762
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 762
    Height = 488
    ActivePage = TabProfessores
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    ScrollOpposite = True
    TabOrder = 0
    object TabAlunos: TTabSheet
      Caption = 'Alunos'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 754
        Height = 129
        Align = alTop
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 0
        object Label1: TLabel
          Left = 40
          Top = 16
          Width = 33
          Height = 16
          Caption = 'Nome'
        end
        object Label2: TLabel
          Left = 349
          Top = 16
          Width = 33
          Height = 16
          Caption = 'Curso'
        end
        object Label3: TLabel
          Left = 538
          Top = 16
          Width = 22
          Height = 16
          Caption = 'CPF'
        end
        object Label4: TLabel
          Left = 349
          Top = 68
          Width = 50
          Height = 16
          Caption = 'Telefone'
        end
        object Label5: TLabel
          Left = 40
          Top = 68
          Width = 31
          Height = 16
          Caption = 'Email'
        end
        object EdtNomeAluno: TEdit
          Left = 40
          Top = 35
          Width = 265
          Height = 24
          TabOrder = 0
        end
        object EdtEmailAluno: TEdit
          Left = 40
          Top = 87
          Width = 265
          Height = 24
          TabOrder = 1
        end
        object EdtTelefoneAluno: TEdit
          Left = 349
          Top = 87
          Width = 145
          Height = 24
          TabOrder = 2
        end
        object BtnSearch: TButton
          Left = 656
          Top = 76
          Width = 80
          Height = 40
          Caption = 'Pesquisar'
          TabOrder = 3
          OnClick = BtnSearchClick
        end
        object EdtCPFAluno: TMaskEdit
          Left = 538
          Top = 35
          Width = 96
          Height = 24
          EditMask = '!999.999.999-99;1;_'
          MaxLength = 14
          TabOrder = 4
          Text = '   .   .   -  '
        end
        object EdtCursoAluno: TComboBox
          Left = 349
          Top = 35
          Width = 145
          Height = 24
          TabOrder = 5
        end
        object BtnClearAluno: TButton
          Left = 656
          Top = 27
          Width = 80
          Height = 40
          Caption = 'Limpar'
          TabOrder = 6
          OnClick = BtnClearAlunoClick
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 389
        Width = 754
        Height = 68
        Align = alBottom
        Caption = 'Panel2'
        ShowCaption = False
        TabOrder = 1
        object BtnCadastroAluno: TButton
          Left = 32
          Top = 16
          Width = 106
          Height = 41
          Caption = 'Novo aluno'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = BtnCadastroAlunoClick
        end
        object BrnView: TButton
          Left = 312
          Top = 16
          Width = 105
          Height = 41
          Caption = 'Visualizar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object BtnDelete: TButton
          Left = 592
          Top = 16
          Width = 105
          Height = 41
          Caption = 'Excluir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
      object LVAluno: TListView
        Left = 0
        Top = 129
        Width = 754
        Height = 260
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            AutoSize = True
            Caption = 'Nome'
          end
          item
            AutoSize = True
            Caption = 'CPF'
          end
          item
            AutoSize = True
            Caption = 'Curso'
          end
          item
            AutoSize = True
            Caption = 'Telefone'
          end
          item
            AutoSize = True
            Caption = 'Email'
          end>
        RowSelect = True
        TabOrder = 2
        ViewStyle = vsReport
      end
    end
    object TabProfessores: TTabSheet
      Caption = 'Professores'
      ImageIndex = 1
      object LVProfessor: TListView
        Left = 0
        Top = 129
        Width = 754
        Height = 260
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            AutoSize = True
            Caption = 'Nome'
          end
          item
            AutoSize = True
            Caption = 'CNPJ'
          end
          item
            AutoSize = True
            Caption = 'Cursos'
          end
          item
            AutoSize = True
            Caption = 'Telefone'
          end>
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
      object Panel3: TPanel
        Left = 0
        Top = 389
        Width = 754
        Height = 68
        Align = alBottom
        Caption = 'Panel2'
        ShowCaption = False
        TabOrder = 1
        object BtnCadastroProfessor: TButton
          Left = 32
          Top = 16
          Width = 106
          Height = 41
          Caption = 'Novo Professor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = BtnCadastroProfessorClick
        end
        object BtnViewProfessor: TButton
          Left = 312
          Top = 16
          Width = 105
          Height = 41
          Caption = 'Visualizar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = BtnViewProfessorClick
        end
        object Button3: TButton
          Left = 592
          Top = 16
          Width = 105
          Height = 41
          Caption = 'Excluir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 754
        Height = 129
        Align = alTop
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 2
        object Label6: TLabel
          Left = 40
          Top = 16
          Width = 33
          Height = 16
          Caption = 'Nome'
        end
        object Label7: TLabel
          Left = 381
          Top = 16
          Width = 33
          Height = 16
          Caption = 'Curso'
        end
        object Label8: TLabel
          Left = 381
          Top = 68
          Width = 28
          Height = 16
          Caption = 'CNPJ'
        end
        object Label9: TLabel
          Left = 40
          Top = 68
          Width = 50
          Height = 16
          Caption = 'Telefone'
        end
        object EdtNomeProfessor: TEdit
          Left = 40
          Top = 35
          Width = 265
          Height = 24
          TabOrder = 0
        end
        object EdtContatoProfessor: TEdit
          Left = 40
          Top = 87
          Width = 121
          Height = 24
          TabOrder = 1
        end
        object BtnPesquisaProfessor: TButton
          Left = 633
          Top = 73
          Width = 88
          Height = 40
          Caption = 'Pesquisar'
          TabOrder = 2
          OnClick = BtnPesquisaProfessorClick
        end
        object EdtCnpj: TMaskEdit
          Left = 381
          Top = 87
          Width = 124
          Height = 24
          EditMask = '!99.999.999/9999-99;1;_'
          MaxLength = 18
          TabOrder = 3
          Text = '  .   .   /    -  '
        end
        object EdtCursoProfessor: TComboBox
          Left = 381
          Top = 35
          Width = 145
          Height = 24
          TabOrder = 4
          Items.Strings = (
            'acoredeon'
            'viol'#227'o')
        end
        object BtnClearProfessor: TButton
          Left = 633
          Top = 27
          Width = 88
          Height = 40
          Caption = 'Limpar'
          TabOrder = 5
          OnClick = BtnClearProfessorClick
        end
      end
    end
    object TabCursos: TTabSheet
      Caption = 'Cursos'
      ImageIndex = 2
      object LVCurso: TListView
        Left = 0
        Top = 129
        Width = 754
        Height = 260
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'Nome'
            Width = 252
          end
          item
            Caption = 'Pre'#231'o'
            Width = 251
          end
          item
            Caption = 'Salas'
            Width = 251
          end>
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        ExplicitTop = 123
      end
      object Panel5: TPanel
        Left = 0
        Top = 389
        Width = 754
        Height = 68
        Align = alBottom
        Caption = 'Panel2'
        ShowCaption = False
        TabOrder = 1
        object BtnNovoCurso: TButton
          Left = 32
          Top = 16
          Width = 106
          Height = 41
          Caption = 'Novo curso'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = BtnNovoCursoClick
        end
        object Button5: TButton
          Left = 312
          Top = 16
          Width = 105
          Height = 41
          Caption = 'Visualizar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object Button6: TButton
          Left = 592
          Top = 16
          Width = 105
          Height = 41
          Caption = 'Excluir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 754
        Height = 129
        Align = alTop
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 2
        object Label10: TLabel
          Left = 40
          Top = 16
          Width = 33
          Height = 16
          Caption = 'Nome'
        end
        object EdtNomeCurso: TEdit
          Left = 40
          Top = 35
          Width = 265
          Height = 24
          AutoSize = False
          TabOrder = 0
        end
        object PesquisaCurso: TButton
          Left = 456
          Top = 19
          Width = 74
          Height = 40
          Caption = 'Pesquisar'
          TabOrder = 1
          OnClick = PesquisaCursoClick
        end
      end
    end
  end
end
