unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, cCadCategoria, uDTMConexao, uEnum;

type
  TfrmCadCategoria = class(TfrmTelaHerenca)
    qryListacategoria_id: TIntegerField;
    qryListadescricao: TWideStringField;
    edtCategoriaID: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridListaDblClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    oCategoria:TCategoria;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}

{$region 'Override'}
function TfrmCadCategoria.Apagar: Boolean;
begin
  if oCategoria.Selecionar(qryLista.FieldByName('categoria_id').AsInteger) then
  begin
       Result:=oCategoria.Apagar;
  end;

end;

function TfrmCadCategoria.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin

    if edtCategoriaID.Text<>EmptyStr then
        oCategoria.codigo:=StrToInt(edtCategoriaID.Text)
    else
      oCategoria.codigo:=0;
      oCategoria.descricao:=edtDescricao.Text;

   if (EstadoDoCadastro=ecInserir) then
      Result:=oCategoria.Inserir
   else if (EstadoDoCadastro=ecAlterar) then begin
      Result:=oCategoria.Atualizar ;

   end;

end;
procedure TfrmCadCategoria.gridListaDblClick(Sender: TObject);
begin
  inherited;

end;

{$endregion}
procedure TfrmCadCategoria.btnAlterarClick(Sender: TObject);
begin
if oCategoria.Selecionar(qryLista.FieldByName('categoria_id').AsInteger) then
    begin
      edtCategoriaID.Text:=IntToStr(oCategoria.codigo);
      edtDescricao.Text:=oCategoria.descricao;
    end
    else begin
      btnCancelar.Click;
      Abort;
    end;

  inherited;

end;

procedure TfrmCadCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin


  inherited;
  if Assigned(oCategoria) then
    FreeAndNil(oCategoria);
end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  oCategoria:=TCategoria.Create(DTMPrincipal.ConexaoDB);
  IndiceAtual:= 'descricao';
end;



end.
