inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cad. Categoria'
  ExplicitTop = -156
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    ActivePage = TabManutencao
    inherited TabListagem: TTabSheet
      inherited gridLista: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'categoria_id'
            Width = 43
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 573
            Visible = True
          end>
      end
    end
    inherited TabManutencao: TTabSheet
      object edtCategoriaID: TLabeledEdit
        Tag = 1
        Left = 27
        Top = 24
        Width = 70
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Codigo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 27
        Top = 80
        Width = 385
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 30
        TabOrder = 1
      end
    end
  end
  inherited Panel1: TPanel
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryLista: TZQuery
    SQL.Strings = (
      'SELECT *'
      'FROM categorias;')
    Left = 676
    object qryListacategoria_id: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'categoria_id'
      ReadOnly = True
    end
    object qryListadescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
  inherited dataLista: TDataSource
    Left = 708
  end
end